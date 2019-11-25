package com.hfut.laboratory.controller.authc;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hfut.laboratory.pojo.CouponCard;
import com.hfut.laboratory.pojo.Project;
import com.hfut.laboratory.pojo.RecordBusiness;
import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.pojo.*;
import com.hfut.laboratory.service.*;
import com.hfut.laboratory.util.QueryWapperUtils;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.staff.SimpleStaffVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

@RestController
@RequestMapping("staff")
@Api(tags = "员工相关接口")
public class StaffController {

    @Autowired
    private RecordBusinessService recordBusinessService;
    @Autowired
    private ProjectService projectService;
    @Autowired
    private CouponCardService couponCardService;
    @Autowired
    private UserService userService;
    @Autowired
    private UserRoleService userRoleService;

    @GetMapping("/list")
    @ApiOperation("获取在职员工（boss、manger、staff）id、name列表")
    @Cacheable(value = "getStaffList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<List<SimpleStaffVo>> getStaffList(){
        List<UserRole> roleList = userRoleService.list(QueryWapperUtils.getInWapper("role_id", new Integer[]{2, 3, 4}));

        List<SimpleStaffVo> res=new ArrayList<>();
        roleList.forEach(u_r->{
            User user = userService.getById(u_r.getUserId());
            if(user.getStatus()!=0){
                res.add(new SimpleStaffVo(user.getId(),user.getName()));
            }
        });
        return ApiResponse.ok(res);
    }

    @GetMapping("/job")
    @ApiOperation("查询员工做的事情")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit"),
            @ApiImplicitParam(name = "startTime",value = "起始时间"),
            @ApiImplicitParam(name = "endTime",value = "结束时间"),
            @ApiImplicitParam(name = "staffId",value = "员工id"),
    })
    @Cacheable(value = "getProjectByName",keyGenerator="simpleKeyGenerator")
    public ApiResponse<Map<String,Integer>> getProjectByName(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                             @RequestParam(required = false,defaultValue = "20") Integer size,
                                                             @RequestParam(required = false) LocalDateTime startTime,
                                                             @RequestParam(required = false) LocalDateTime endTime,
                                                             @RequestParam(required = false) Integer staffId,
                                                             @RequestParam Integer type){
        if(type!= 1 && type!=2){
            return ApiResponse.selfError(ReturnCode.ERROR_PARAM);
        }

        Map<String,Integer> res=new HashMap<>();
        Page<RecordBusiness> page=new Page<>(current,size);
        QueryWrapper<RecordBusiness> queryWrapper=new QueryWrapper();

        queryWrapper.and(wapper -> wapper.in("type", type));
        if(startTime!=null){
            queryWrapper.and(wapper->wapper.ge("date",startTime));
        }
        if(endTime!=null){
            queryWrapper.and(wapper->wapper.le("date",endTime));
        }
        if(staffId!=null){
            queryWrapper.and(wapper->wapper.in("user_id",staffId));
        }
        IPage<RecordBusiness> recordBusinessIPage = recordBusinessService.page(page, queryWrapper);

        recordBusinessIPage.getRecords().forEach(record->{
            String thingName=null;
            if(type==1){
                CouponCard couponCard = couponCardService.getById(record.getThingId());
                thingName=couponCard.getName();
            }else if(type==2){
                Project project = projectService.getById(record.getThingId());
                thingName=project.getName();
            }

            if(res.containsKey(thingName)){
                res.put(thingName,res.get(thingName)+1);
            }else {
                res.put(thingName,1);
            }
        });

        return ApiResponse.ok(res);
    }



}
