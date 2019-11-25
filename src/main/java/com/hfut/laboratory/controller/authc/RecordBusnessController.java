package com.hfut.laboratory.controller.authc;

import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.service.CouponCardService;
import com.hfut.laboratory.service.ProjectService;
import com.hfut.laboratory.service.RecordBusinessService;
import com.hfut.laboratory.vo.ApiResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/busness")
@Api("员工生意记录")
public class RecordBusnessController {

    @Autowired
    private RecordBusinessService recordBusinessService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private CouponCardService couponCardService;

    @GetMapping("/group")
    @ApiOperation("聚合查询")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "startTime",value = "起始时间"),
            @ApiImplicitParam(name = "endTime",value = "结束时间"),
            @ApiImplicitParam(name = "type",value = "类型 1：项目、2：卡"),
    })
    @Cacheable(value = "groupByProject",keyGenerator="simpleKeyGenerator")
    public ApiResponse<Map<String,Object>> groupByProject(@RequestParam(required = false) LocalDateTime startTime,
                                                          @RequestParam(required = false) LocalDateTime endTime,
                                                          @RequestParam Integer type){
        if(type != 1 && type != 2){
            return ApiResponse.selfError(ReturnCode.ERROR_PARAM);
        }
        List<Map<String, Object>> groupByProject = recordBusinessService.groupByProject(type,startTime,endTime);
        Map<String,Object> res=new HashMap<>();
        groupByProject.forEach(map->{
            String name="";
            if(type==1){
                name = projectService.getById((Integer) map.get("thing_id")).getName();
            }
            if(type ==2){
                name = couponCardService.getById((Integer) map.get("thing_id")).getName();
            }
            res.put(name,map.get("count"));
        });
        return ApiResponse.ok(res);
    }


}
