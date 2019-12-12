package com.hfut.laboratory.controller.authc.roles.root;

import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.pojo.Permission;
import com.hfut.laboratory.pojo.Role;
import com.hfut.laboratory.pojo.RolePermission;
import com.hfut.laboratory.service.PermissionService;
import com.hfut.laboratory.service.RolePermissionService;
import com.hfut.laboratory.service.RoleService;
import com.hfut.laboratory.util.QueryWapperUtils;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.role.RoleVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/role")
@Api(tags = "角色管理（只有root权限可访问）")
@Slf4j
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private RolePermissionService rolePermissionService;

    @GetMapping("/list")
    @ApiOperation("获取角色列表")
    @Cacheable(value = "getRoleList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<List<Role>> getRoleList(){
        List<Role> roleList = roleService.list(null);
        return ApiResponse.ok(roleList);
    }

    @GetMapping("/r_p/list")
    @ApiOperation("获取角色和对应权限的列表")
    @Cacheable(value = "getRoleAndPermList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<List<RoleVo>> getRoleAndPermList(){
        List<RoleVo> res=new ArrayList<>();
        roleService.list(null).forEach(role -> {
            res.add(getRoleVo(role));
        });
        return ApiResponse.ok(res);
    }

    @GetMapping("/{id}")
    @ApiOperation("通过id获取角色")
    @ApiImplicitParam(name = "id",value = "角色的id")
    @Cacheable(value = "getRoleById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<Role> getRoleById(@PathVariable Integer id){
        Role role = roleService.getById(id);
        return ApiResponse.ok(role);
    }

    @GetMapping("/r_p/{id}")
    @ApiOperation("通过id获取角色即对应权限")
    @ApiImplicitParam(name = "id",value = "角色的id")
    @Cacheable(value = "getRoleAndPermessionById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<RoleVo> getRoleAndPermessionById(@PathVariable Integer id){
        Role role = roleService.getById(id);
        return ApiResponse.ok(getRoleVo(role));
    }

    @PostMapping
    @ApiOperation("添加角色")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name",value = "角色的英文名字"),
            @ApiImplicitParam(name = "introduction",value = "该角色的中文介绍")
    })
    public ApiResponse<Void> insertRole(@RequestParam String name,
                                           @RequestParam String introduction){
        Role role=new Role();
        role.setName(name);
        role.setIntroduction(introduction);

        boolean res=roleService.save(role);
        return res ? ApiResponse.created() : ApiResponse.serverError();
    }

    @PutMapping("/{id}")
    @ApiOperation("修改角色对应权限")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "角色的id"),
            @ApiImplicitParam(name = "permIds",value = "该角色的权限id集合 没有的话不填写该参数")
    })
    @Transactional //多次操作数据库 开启事务
    public ApiResponse<Void> updateRole(@PathVariable Integer id,
                                           @RequestParam List<Integer> permIds){
        Role role=roleService.getById(id);
        rolePermissionService.remove(QueryWapperUtils.getInWapper("role_id",role.getId()));

        if(!(permIds==null || CollectionUtils.isEmpty(permIds))){
            for(Integer permId:permIds){
                RolePermission rolePermission = RolePermission.builder().roleId(role.getId()).permissionId(permId).build();
                if(!rolePermissionService.save(rolePermission)){
                    log.info(this.getClass().getName()+"updateRole:error");
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    return ApiResponse.serverError();
                }
            }
        }

        return ApiResponse.ok();
    }

    @DeleteMapping("/{id}")
    @ApiOperation("删除角色")
    @ApiImplicitParam(name = "id",value = "角色的id")
    @Transactional
    public ApiResponse<Void> deleteRole(@PathVariable Integer id){
        boolean res1 = rolePermissionService.remove(QueryWapperUtils.getInWapper("role_id",id));
        boolean res2=true;
        try {
            res2 = roleService.removeById(id);
        }catch (Exception e){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.selfError(ReturnCode.DELETE_FALI_Foreign_KEY);
        }

        if(res1 && res2){
            return ApiResponse.ok();
        } else {
            log.info(this.getClass().getName()+"updateUser:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    public RoleVo getRoleVo(Role role){
        List<Permission> permissionList=new ArrayList<>();
        rolePermissionService.list(QueryWapperUtils.getInWapper("role_id",role.getId())).forEach(r_p->{
            RolePermission rolePermission= (RolePermission) r_p;
            permissionList.add(permissionService.getById(rolePermission.getPermissionId()));
        });

        return new RoleVo(role,permissionList);
    }
}
