package com.hfut.laboratory.controller.authc.roles.boss;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hfut.laboratory.dto.UserInfo;
import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.pojo.Role;
import com.hfut.laboratory.pojo.User;
import com.hfut.laboratory.pojo.UserRole;
import com.hfut.laboratory.service.RoleService;
import com.hfut.laboratory.service.UserRoleService;
import com.hfut.laboratory.service.UserService;
import com.hfut.laboratory.util.CodecUtils;
import com.hfut.laboratory.util.QueryWapperUtils;
import com.hfut.laboratory.util.jwt.JwtTokenUtils;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.PageResult;
import com.hfut.laboratory.vo.user.UserVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yzx
 * @since 2019-11-06
 */
@RestController
@RequestMapping("user")
@Api(tags = "系统用户的相关接口（只有root和boss可以访问）")
@Slf4j
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private UserRoleService userRoleService;

    @GetMapping("/list")
    @ApiOperation("获取系统用户列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getUserAndRoleList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<User>> getUserAndRoleList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                               @RequestParam(required = false,defaultValue = "20") Integer size){
        Page<User> page=new Page<>(current,size);
        IPage<User> userIPage = userService.page(page, null);
        return ApiResponse.ok(new PageResult<>(userIPage.getRecords(),userIPage.getTotal(),userIPage.getSize()));
    }

    @GetMapping("/u_r/list")
    @ApiOperation("获取系统用户列表及每个用户对应角色")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getUserList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<UserVo>> getUserList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                          @RequestParam(required = false,defaultValue = "20") Integer size){
        List<UserVo> res=new ArrayList<>();
        Page<User> page=new Page<>(current,size);
        IPage<User> userIPage = userService.page(page, null);

        userIPage.getRecords().forEach(user -> {
            //一个用户只可以有一个角色
            UserRole userRole = userRoleService.getOne(QueryWapperUtils.getInWapper("user_id", user.getId()));
            Role role=roleService.getById(userRole.getRoleId());
            UserVo userVo=new UserVo(user,role.getId());
            res.add(userVo);
        });
        return ApiResponse.ok(new PageResult<>(res,userIPage.getTotal(),userIPage.getSize()));
    }

    @GetMapping("/r_list/{rid}")
    @ApiOperation("查询某个角色所有人")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleId",value = "1:root、2：boss、3：manager、4.staff"),
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getStaffList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<User>> getStaffList(@PathVariable Integer rid,
                                                         @RequestParam(required = false,defaultValue = "1") Integer current,
                                                         @RequestParam(required = false,defaultValue = "20") Integer size){
        Page<UserRole> page=new Page<>();
        IPage<UserRole> userRoleIPage = userRoleService.page(page, QueryWapperUtils.getInWapper("role_id", rid));

        List<User> res=new ArrayList<>();
        userRoleIPage.getRecords().forEach(u_r->{
            res.add(userService.getById(u_r.getUserId()));
        });

        return ApiResponse.ok(new PageResult<>(res,userRoleIPage.getTotal(),userRoleIPage.getSize()));
    }

    @GetMapping("/{id}")
    @ApiOperation("通过id获取系统用户")
    @ApiImplicitParam(name = "id",value = "系统用户的id")
    @Cacheable(value = "getUserById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<User> getUserById(@PathVariable Integer id){
        User user=userService.getById(id);
        return ApiResponse.ok(user);
    }

    @GetMapping("/u_r/{id}")
    @ApiOperation("通过id获取系统用户及对应角色")
    @ApiImplicitParam(name = "id",value = "系统用户的id")
    @Cacheable(value = "getUserAndRoleById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<UserVo> getUserAndRoleById(@PathVariable Integer id){
        User user=userService.getById(id);
        UserRole userRole = userRoleService.getOne(QueryWapperUtils.getInWapper("user_id", user.getId()));
        Role role=roleService.getById(userRole.getRoleId());

        UserVo userVo=new UserVo(user,role.getId());
        return ApiResponse.ok(userVo);
    }

    @PostMapping
    @ApiOperation("添加系统用户")
    @ApiImplicitParam(name = "userVo",value = "user的包装对象，其中role.id：1.root、2.boss、3.manger、4.staff")
    @Transactional //多个表添加 开启事务
    public ApiResponse<Void> insertUser(@RequestBody UserVo userVo, HttpServletRequest request){
        if(StringUtils.isBlank(userVo.getName()) || StringUtils.isBlank(userVo.getPassword()) || StringUtils.isBlank(userVo.getPhone()) ||
                userVo.getRoleId()==null || (userVo.getRoleId()!=1 && userVo.getBaseSalary()==null)){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }

        //TODO 设置角色id要大于自己的id才有权限
//        UserInfo userInfo= JwtTokenUtils.getUserInfoFromToken(request);
//        Integer thisRoleId=userRoleService.getOne(QueryWapperUtils.getInWapper("user_id",userInfo.getId())).getRoleId();
//        if(userVo.getRoleId()<=thisRoleId){
//            return ApiResponse.authError();
//        }

        userVo.setEntryTime(LocalDateTime.now());
        userVo.setPassword(CodecUtils.md5Hex(userVo.getPassword(),3));
        boolean res1 = userService.save(userVo);

        UserRole userRole=UserRole.builder().roleId(userVo.getRoleId()).userId(userVo.getId()).build();
        boolean res2 = userRoleService.save(userRole);

        if(res1 && res2){
            return ApiResponse.created();
        } else {
            log.info(this.getClass().getName()+"insertUser:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    @PutMapping
    @ApiOperation("修改系统用户")
    @ApiImplicitParam(name = "userVo",value = "user的包装对象 该对象包含id，如果不修改role，请不要传递role对象，如果传递其中roleId：1.root、2.boss、3.manger、4.staff")
    @Transactional
    public ApiResponse<Void> updateUser(@RequestBody UserVo userVo,HttpServletRequest request){
        if(StringUtils.isBlank(userVo.getName()) || StringUtils.isBlank(userVo.getPassword()) || StringUtils.isBlank(userVo.getPhone()) ||
                userVo.getRoleId()==null || (userVo.getRoleId()!=1 && userVo.getBaseSalary()==null)){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        boolean res1=true, res2=true,res3=true;

        if(userVo.getRoleId()!=null){
            //TODO
//            UserInfo userInfo= JwtTokenUtils.getUserInfoFromToken(request);
//            Integer thisRoleId=userRoleService.getOne(QueryWapperUtils.getInWapper("user_id",userInfo.getId())).getRoleId();
//            //设置角色id要大自己的id才有权限
//            if(userVo.getRoleId()<=thisRoleId){
//                return ApiResponse.authError();
//            }

            res2=userRoleService.remove(QueryWapperUtils.getInWapper("user_id",userVo.getId()));
            UserRole userRole=UserRole.builder().roleId(userVo.getRoleId()).userId(userVo.getId()).build();
            res3 = userRoleService.save(userRole);
        }

        userVo.setPassword(null);
        userVo.setEntryTime(null);
        res1 = userService.updateById(userVo);

        if(res1 && res2 && res3){
            return ApiResponse.ok();
        } else {
            log.info(this.getClass().getName()+"updateUser:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    @DeleteMapping("/{id}")
    @ApiOperation("删除系统用户")
    @ApiImplicitParam(name = "id",value = "要删除的用户id")
    @Transactional
    public ApiResponse<Void> deleteUser(@PathVariable Integer id ){
        boolean res1=userRoleService.remove(QueryWapperUtils.getInWapper("user_id",id));
        boolean res2=true;
        try{
            res2 = userService.removeById(id);
        }catch (Exception e){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.selfError(ReturnCode.DELETE_FALI_Foreign_KEY);
        }

        if(res1 && res2){
            return ApiResponse.ok();
        } else {
            log.info(this.getClass().getName()+"deleteUser:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

}
