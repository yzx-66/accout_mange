package com.hfut.laboratory.controller.authc.perms;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hfut.laboratory.pojo.RecordsConsumption;
import com.hfut.laboratory.pojo.Salary;
import com.hfut.laboratory.enums.ConsumeTypeEnum;
import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.enums.PayTypeEnum;
import com.hfut.laboratory.pojo.*;
import com.hfut.laboratory.service.*;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.PageResult;
import com.hfut.laboratory.vo.salary.ReturnSalaryVo;
import com.hfut.laboratory.vo.salary.SetSalaryVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
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

    @GetMapping("/list")
    @ApiOperation("查询进一个月发过的薪水列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getSalaryList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<ReturnSalaryVo>> getSalaryList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                                 @RequestParam(required = false,defaultValue = "20") Integer size){
        Page<Salary> page=new Page<>(current,size);
        QueryWrapper<Salary> queryWrapper=new QueryWrapper<>();
        queryWrapper.lt("settle_date",LocalDateTime.now())
                .and(wapper->wapper.ge("settle_date",LocalDateTime.now().minusMonths(1)));
        IPage<Salary> salaryIPage = salaryService.page(page, queryWrapper);

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
                                                                   @RequestParam(required = false) LocalDateTime startTime,
                                                                   @RequestParam(required = false) LocalDateTime endTime,
                                                                   @RequestParam(required = false) Integer staffId
                                                                   ){

        QueryWrapper<Salary> queryWrapper=new QueryWrapper<>();
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

    @PostMapping("/add")
    @ApiOperation("结算员工薪水 需要权限[salay_edit]")
    @ApiImplicitParam(name = "salaryVo",value = "设置员工薪水基本信息的对象")
    public ApiResponse<Void> InsertSalary(@RequestBody SetSalaryVo salaryVo) {
        Salary salary = new Salary();
        salary.setUserId(salaryVo.getStaffId());
        salary.setBaseSalary(salaryVo.getBaseSalary());
        salary.setDeductSalary(salaryVo.getDeductSalary());
        salary.setOtherBonus(salaryVo.getOtherBonus());
        salary.setRemark(salaryVo.getRemark());
        salary.setSettleDate(LocalDateTime.now());

        QueryWrapper<RecordsConsumption> consumptionQqueryWrapper = new QueryWrapper();
        // TODO lt
        consumptionQqueryWrapper.lt("pay_time", LocalDateTime.now())
                .and(wapper -> wapper.ge("pay_time", LocalDateTime.now().minusMonths(1)))
                .and(wapper -> wapper.in("user_id", salaryVo.getStaffId()));
        List<RecordsConsumption> recordsConsumptionList = recordsConsumptionService.list(consumptionQqueryWrapper);

        Float cardSum=0.0f,proSum=0.0f, makeMoneyIncome=0.0f;
        for(RecordsConsumption consum:recordsConsumptionList){
            if(consum.getConsumType()== ConsumeTypeEnum.PROJECT.getType()){
                proSum+=consum.getPrice();
            }else if(consum.getConsumType()==ConsumeTypeEnum.MAKE_CARD.getType()){
                cardSum+=consum.getPrice();
            }

            if(consum.getPayType()==PayTypeEnum.USE_MONEY.getType()){
                makeMoneyIncome+=consum.getPrice();
            }
        }

        salary.setCardSum(cardSum);
        salary.setProSum(proSum);
        salary.setMakeMoneyIncome(makeMoneyIncome);
        salary.setSumSalary(salary.getBaseSalary()+salary.getOtherBonus()+makeMoneyIncome-salary.getDeductSalary());
        boolean res = salaryService.saveOrUpdate(salary);

        return res ? ApiResponse.created() : ApiResponse.serverError();
    }

    @PutMapping("/edit/{id}")
    @ApiOperation("修改员工薪水 需要权限[salay_del]")
    @ApiImplicitParam(name = "salaryVo",value = "设置员工薪水基本信息的对象")
    public ApiResponse<Void> updateSalary(@PathVariable Integer id,
                                            @RequestBody SetSalaryVo salaryVo){
        Salary salary=salaryService.getById(id);
        if(salary==null){
            return ApiResponse.selfError(ReturnCode.SALARY_NOT_EXITST);
        }

        salary.setBaseSalary(salaryVo.getBaseSalary());
        salary.setDeductSalary(salaryVo.getDeductSalary());
        salary.setOtherBonus(salaryVo.getOtherBonus());
        salary.setRemark(salaryVo.getRemark());
        salary.setSettleDate(LocalDateTime.now());

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
