package com.hfut.laboratory.controller.authc.perms;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hfut.laboratory.constants.TimeFormatConstants;
import com.hfut.laboratory.pojo.RecordsConsumption;
import com.hfut.laboratory.pojo.Salary;
import com.hfut.laboratory.enums.ConsumeTypeEnum;
import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.enums.PayTypeEnum;
import com.hfut.laboratory.pojo.*;
import com.hfut.laboratory.service.*;
import com.hfut.laboratory.util.TimeConvertUtils;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.PageResult;
import com.hfut.laboratory.vo.salary.ReturnSalaryVo;
import com.hfut.laboratory.vo.salary.SetSalaryVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/salary")
@Api(tags = "薪水的相关接口")
public class SalaryController {

    @Autowired
    private SalaryService salaryService;

    @Autowired
    private RecordsConsumptionService recordsConsumptionService;

    @Autowired
    private UserService userService;

    @Value("${salary.salaryPath}")
    private String salaryPath;

    @GetMapping("/list")
    @ApiOperation("查询薪水列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getSalaryList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<ReturnSalaryVo>> getSalaryList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                                 @RequestParam(required = false,defaultValue = "20") Integer size,
                                                                 @RequestParam(required = false,defaultValue = "true")boolean isDesc){
        Page<Salary> page=new Page<>(current,size);
        QueryWrapper queryWrapper=null;
        if(isDesc){
            queryWrapper=new QueryWrapper<>().orderByDesc("settle_date");
        }
        IPage<Salary> salaryIPage = salaryService.page(page,queryWrapper);

        return ApiResponse.ok(new PageResult<>(getReturnSalaryVoList(salaryIPage.getRecords()),salaryIPage.getTotal(),salaryIPage.getSize()));
    }

    @GetMapping
    @ApiOperation("查询员工的薪水")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit"),
            @ApiImplicitParam(name = "startTime",value = "起始时间"),
            @ApiImplicitParam(name = "endTime",value = "结束时间"),
            @ApiImplicitParam(name = "staffId",value = "员工id"),
    })
    @Cacheable(value = "QuerySalaryList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<ReturnSalaryVo>> QuerySalaryList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                                   @RequestParam(required = false,defaultValue = "20") Integer size,
                                                                   @RequestParam(required = false,defaultValue = "true")boolean isDesc,
                                                                   @RequestParam(required = false) LocalDateTime startTime,
                                                                   @RequestParam(required = false) LocalDateTime endTime,
                                                                   @RequestParam(required = false) Integer staffId
                                                                   ){

        QueryWrapper<Salary> queryWrapper=new QueryWrapper<>();
        if(isDesc){
            queryWrapper.orderByDesc("settle_date");
        }
        if(staffId!=null){
            queryWrapper.and(wapper->wapper.in("user_id",staffId));
        }
        if(startTime!=null){
            queryWrapper.and(wapper->wapper.ge("settle_date",startTime));
        }
        if(endTime!=null){
            queryWrapper.and(wapper->wapper.le("settle_date",endTime));
        }


        Page<Salary> page=new Page<>(current,size);
        IPage<Salary> salaryIPage = salaryService.page(page, queryWrapper);

        return ApiResponse.ok(new PageResult<>(getReturnSalaryVoList(salaryIPage.getRecords()),salaryIPage.getTotal(),salaryIPage.getSize()));
    }

    @GetMapping("/salary_time")
    @ApiOperation("获取出账时间")
    public ApiResponse<LocalDateTime> getsalaryTime() throws IOException {
        File file=new File(salaryPath);
        if(!file.exists()){
           return ApiResponse.selfError(ReturnCode.SALARY_TIME_NOT_EXIST);
        }

        LocalDateTime resTime;
        try(BufferedReader bufferedReader=new BufferedReader(new FileReader(file))){
            String content = bufferedReader.readLine();
            resTime=LocalDateTime.parse(content, DateTimeFormatter.ofPattern(TimeFormatConstants.DEFAULT_DATE_TIME_FORMAT));
        }catch (Exception e){
            return ApiResponse.selfError(ReturnCode.SALARY_TIME_NOT_EXIST);
        }

        String salaryMonth=LocalDateTime.now().getMonth().getValue() >=10 ? ""+LocalDateTime.now().getMonth().getValue() : "0"+LocalDateTime.now().getMonth().getValue();
        String salaryDay=resTime.getDayOfMonth() >=10 ? ""+resTime.getDayOfMonth() : "0"+resTime.getDayOfMonth();
        String resDate=String.valueOf(LocalDateTime.now().getYear())+"-"+salaryMonth+"-"+salaryDay+" 00:00:00";
        return ApiResponse.ok(LocalDateTime.parse(resDate,DateTimeFormatter.ofPattern(TimeFormatConstants.DEFAULT_DATE_TIME_FORMAT)));
    }


    @PostMapping("/set")
    @ApiOperation("设置结算薪水的时间 需要权限[salay_set]")
    @ApiImplicitParam(name = "salaryTime",value = "结算时间")
    public ApiResponse setSalayTime(@RequestParam LocalDateTime salaryTime) throws IOException {
        File file=new File(salaryPath);
        if(!file.exists()){
            file.createNewFile();
        }
        BufferedWriter bufferedWriter=new BufferedWriter(new FileWriter(file,false));
        LocalDateTime resTime = TimeConvertUtils.convertTo_yMd(salaryTime);
        String content = resTime.format(DateTimeFormatter.ofPattern(TimeFormatConstants.DEFAULT_DATE_TIME_FORMAT));
        bufferedWriter.write(content);
        bufferedWriter.close();
        return ApiResponse.ok();
    }

    @PutMapping("/edit/{id}")
    @ApiOperation("修改员工薪水 需要权限[salay_edit]")
    @ApiImplicitParam(name = "salaryVo",value = "设置员工薪水基本信息的对象")
    public ApiResponse<Void> updateSalary(@PathVariable Integer id,
                                          @RequestBody SetSalaryVo salaryVo){
        if(salaryVo.getChange()==null || StringUtils.isBlank(salaryVo.getRemark())){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        Salary salary=salaryService.getById(id);
        if(salary==null){
            return ApiResponse.selfError(ReturnCode.SALARY_NOT_EXITST);
        }

        String remark=(StringUtils.isBlank(salary.getRemark()) ? "" : salary.getRemark())
                +"修改时间："+LocalDateTime.now().format(DateTimeFormatter.ofPattern(TimeFormatConstants.DEFAULT_DATE_TIME_FORMAT))+"\t"
                +"修改原因："+salaryVo.getRemark()+"\t"
                +"工资改变："+(salaryVo.getChange()>0 ? "增加" : "减少")+salaryVo.getChange()+"元"+"<br/>";

        salary.setRemark(remark);
        salary.setSumSalary(salary.getSumSalary()+salaryVo.getChange());

        boolean res=salaryService.updateById(salary);

        return res ? ApiResponse.ok():ApiResponse.serverError();
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation("删除员工薪水 需要权限[salay_del]")
    @ApiImplicitParam(name = "id",value = "薪水id")
    public ApiResponse<Void> deleteSalary(@PathVariable Integer id){
        boolean res=salaryService.removeById(id);
        return res ? ApiResponse.ok():ApiResponse.serverError();
    }

    public List<ReturnSalaryVo> getReturnSalaryVoList(List<Salary> records){
        List<ReturnSalaryVo> res=new ArrayList<>();
        records.forEach(salary -> {
            User staff = userService.getById(salary.getUserId());
            res.add(new ReturnSalaryVo(salary,staff.getName()));
        });
        return res;
    }
}
