package com.hfut.laboratory.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hfut.laboratory.pojo.RecordsTurnover;
import com.hfut.laboratory.service.RecordsTurnoverService;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.PageResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yzx
 * @since 2019-11-06
 */
@RestController
@RequestMapping("turnover")
@Api(tags = "营业额登记相关接口（只有root和boss可以访问）")
public class RecordsTurnoverController {

    @Autowired
    private RecordsTurnoverService recordsTurnoverService;

    @GetMapping("list")
    @ApiOperation("获取营业额列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getRecordsTurnoverList",keyGenerator="simpleKeyGenerator")
    public ApiResponse getRecordsTurnoverList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                                           @RequestParam(required = false,defaultValue = "20") Integer size,
                                                                           @RequestParam(required = false,defaultValue = "true")boolean isDesc){
        Page<RecordsTurnover> page=new Page<>(current,size);
        QueryWrapper queryWrapper=null;
        if(isDesc){
            queryWrapper=new QueryWrapper<>().orderByDesc("date");
        }
        IPage<RecordsTurnover> recordsTurnoverIPage = recordsTurnoverService.page(page, queryWrapper);
        return ApiResponse.ok(new PageResult<>(recordsTurnoverIPage.getRecords(),recordsTurnoverIPage.getTotal(),recordsTurnoverIPage.getSize()));
    }

    @GetMapping
    @ApiOperation("获取指定营业额列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit"),
            @ApiImplicitParam(name = "startTime",value = "起始时间"),
            @ApiImplicitParam(name = "endTime",value = "结束时间")
    })
    @Cacheable(value = "QueryRecordsTurnoverList",keyGenerator="simpleKeyGenerator")
    public ApiResponse QueryRecordsTurnoverList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                                             @RequestParam(required = false,defaultValue = "20") Integer size,
                                                                             @RequestParam(required = false,defaultValue = "true")boolean isDesc,
                                                                             @RequestParam(required = false) LocalDateTime startTime,
                                                                             @RequestParam(required = false) LocalDateTime endTime){
        QueryWrapper<RecordsTurnover> queryWrapper=new QueryWrapper<>();
        if(isDesc){
            queryWrapper.orderByDesc("date");
        }
        if(startTime!=null){
            queryWrapper.and(wapper->wapper.ge("date",startTime));
        }
        if(endTime!=null){
            queryWrapper.and(wapper->wapper.le("date",endTime));
        }

        Page<RecordsTurnover> page=new Page<>(current,size);
        IPage<RecordsTurnover> recordsTurnoverIPage = recordsTurnoverService.page(page,queryWrapper);
        return ApiResponse.ok(new PageResult<>(recordsTurnoverIPage.getRecords(),recordsTurnoverIPage.getTotal(),recordsTurnoverIPage.getSize()));
    }
}
