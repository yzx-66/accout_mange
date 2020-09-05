package com.hfut.laboratory.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hfut.laboratory.pojo.Customer;
import com.hfut.laboratory.pojo.RecordBusiness;
import com.hfut.laboratory.pojo.RecordsConsumption;
import com.hfut.laboratory.pojo.RecordsTurnover;
import com.hfut.laboratory.enums.ConsumeTypeEnum;
import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.enums.PayTypeEnum;
import com.hfut.laboratory.pojo.*;
import com.hfut.laboratory.service.*;
import com.hfut.laboratory.util.QueryWapperUtils;
import com.hfut.laboratory.util.TimeConvertUtils;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.PageResult;
import com.hfut.laboratory.vo.record.AddOrEditConsumVo;
import com.hfut.laboratory.vo.record.ReturnConsumVo;
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
@RequestMapping("consum")
@Api(tags = "消费记录相关接口")
@Slf4j
public class RecordsConsumptionController {

    @Autowired
    private RecordsConsumptionService recordsConsumptionService;

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private RecordsTurnoverService recordsTurnoverService;

    @Autowired
    private RecordBusinessService recordBusinessService;


    @GetMapping("list")
    @ApiOperation("返回消费记录列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getRecordsConsumptionList",keyGenerator="simpleKeyGenerator")
    public ApiResponse getRecordsConsumptionList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                                             @RequestParam(required = false,defaultValue = "20")Integer size,
                                                                             @RequestParam(required = false,defaultValue = "true")boolean isDesc){
        Page<RecordsConsumption> page=new Page<>(current,size);
        QueryWrapper queryWrapper=null;
        if(isDesc){
            queryWrapper=new QueryWrapper<>().orderByDesc("pay_time");
        }
        IPage<RecordsConsumption> recordsConsumptionIPage = recordsConsumptionService.page(page, queryWrapper);
        List<ReturnConsumVo> res = getReturnConsumVoList(recordsConsumptionIPage.getRecords());
        return ApiResponse.ok(new PageResult<>(res,recordsConsumptionIPage.getTotal(),recordsConsumptionIPage.getSize()));
    }

    @GetMapping
    @ApiOperation("根据查询条件返回")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit"),
            @ApiImplicitParam(name = "startTime",value = "起始时间"),
            @ApiImplicitParam(name = "isDesc",value = "是否降序排序"),
            @ApiImplicitParam(name = "endTime",value = "结束时间"),
            @ApiImplicitParam(name = "staffId",value = "员工id"),
            @ApiImplicitParam(name = "customerName",value = "客户姓名"),
            @ApiImplicitParam(name = "payType",value = "支付方式")
    })
    @Cacheable(value = "QueryRecordsConsumptionList",keyGenerator="simpleKeyGenerator")
    public ApiResponse QueryRecordsConsumptionList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                                               @RequestParam(required = false,defaultValue = "20") Integer size,
                                                                               @RequestParam(required = false,defaultValue = "true")boolean isDesc,
                                                                               @RequestParam(required = false) LocalDateTime startTime,
                                                                               @RequestParam(required = false) LocalDateTime endTime,
                                                                               @RequestParam(required = false) Integer staffId,
                                                                               @RequestParam(required = false) String customerName,
                                                                               @RequestParam(required = false) Integer consumeType,
                                                                               @RequestParam(required = false) Integer payType){
        QueryWrapper<RecordsConsumption> queryWrapper=new QueryWrapper<>();
        if(consumeType!=null){
            queryWrapper.and(wapper->wapper.in("consum_type",consumeType));
        }
        if(payType!=null){
            queryWrapper.and(wapper->wapper.in("pay_type",payType));
        }
        if(StringUtils.isNotBlank(customerName)){
            List<Customer> customerList = customerService.list(QueryWapperUtils.getLikeWapper("name", "%" + customerName + "%"));
            ArrayList<Integer> customerIds=new ArrayList<>();
            customerList.forEach(customer -> customerIds.add(customer.getId()));
            queryWrapper.and(wapper->wapper.in("customer_id",customerIds));
        }
        if(staffId!=null){
            queryWrapper.and(wapper->wapper.in("user_id",staffId));
        }
        if(startTime!=null){
            queryWrapper.and(wapper->wapper.ge("pay_time",startTime));
        }
        if(endTime!=null){
            queryWrapper.and(wapper->wapper.le("pay_time",endTime));
        }
        if(isDesc){
            queryWrapper.orderByDesc("pay_time");
        }


        Page<RecordsConsumption> page=new Page<>(current,size);
        IPage<RecordsConsumption> recordsConsumptionIPage = recordsConsumptionService.page(page, queryWrapper);
        List<ReturnConsumVo> res = getReturnConsumVoList(recordsConsumptionIPage.getRecords());
        return ApiResponse.ok(new PageResult<>(res,recordsConsumptionIPage.getTotal(),recordsConsumptionIPage.getSize()));
    }

    @PostMapping("/add")
    @ApiOperation("手动添加一些消费记录 会修改turnover（但consum_type不会添加到busness表 如果有这个需要 请通过CustomerController结算")
    @ApiImplicitParam(name = "consumVo",value = "添加或者修改的consum对象")
    public ApiResponse insertRecordsConsumption(@RequestBody AddOrEditConsumVo consumVo){
        if(consumVo.getConsumType()==null || consumVo.getPrice()==null || consumVo.getPrice()==null || consumVo.getStaffId()==null ){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        if(userService.getById(consumVo.getStaffId())==null){
            return ApiResponse.selfError(ReturnCode.USER_NOT_EXITST);
        }
        Customer customer=null;
        if(StringUtils.isNotBlank(consumVo.getCustomerName())){
             customer= customerService.getOne(QueryWapperUtils.getInWapper("name", consumVo.getCustomerName()));
            if(customer==null){
                return ApiResponse.selfError(ReturnCode.CUSTOMER_NOT_EXIST);
            }
        }
        RecordsConsumption recordsConsumption=RecordsConsumption.builder()
                .consumType(consumVo.getConsumType())
                .payTime(LocalDateTime.now())
                .payType(consumVo.getPayType())
                .price(consumVo.getPrice())
                .userId(consumVo.getStaffId())
                .customerId(customer!=null ? customer.getId() : null)
                .remark(consumVo.getRemark())
                .isRecord(false)
                .build();
        boolean res = recordsConsumptionService.save(recordsConsumption);
        return res ? ApiResponse.created():ApiResponse.serverError();
    }

    @PutMapping("/edit/{id}")
    @ApiOperation("修改消费记录（需要权限[consum_edit]）会随着修改busness、turnover")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "consumVo",value = "添加或者修改的consum对象"),
            @ApiImplicitParam(name = "id",value = "消费记录id"),
    })
    @Transactional
    public ApiResponse updateRecordsConsumption(@PathVariable Integer id,
                                                         @RequestBody AddOrEditConsumVo consumVo){
        if(consumVo.getConsumType()==null || consumVo.getPrice()==null || consumVo.getPrice()==null || consumVo.getStaffId()==null ){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        if(userService.getById(consumVo.getStaffId())==null){
            return ApiResponse.selfError(ReturnCode.USER_NOT_EXITST);
        }
        RecordsConsumption recordsConsumption = recordsConsumptionService.getById(id);
        if(recordsConsumption==null){
            return ApiResponse.selfError(ReturnCode.CONSUM_NOT_EXITST);
        }
        boolean res1=true,res2=true,res3=true;

        //是否修改turnover表
        if(consumVo.getPayType()!=null || consumVo.getPrice()!=null){
            boolean shouldChange_payType=false,shouldChange_price=false;
            if(consumVo.getPayType()!=null && consumVo.getPayType()!=recordsConsumption.getPayType()) {
                shouldChange_payType=true;
            }
            if(consumVo.getPrice()!=null && consumVo.getPrice()!=recordsConsumption.getPrice()){
                shouldChange_price=true;
            }

            if(shouldChange_payType || shouldChange_price) {
                res1=editTurnover(recordsConsumption);
            }

            if(shouldChange_payType){
                recordsConsumption.setPayType(consumVo.getPayType());
            }
            if(shouldChange_price){
                recordsConsumption.setPrice(consumVo.getPrice());
            }

        }

        //是否要修改bussness表
        if(consumVo.getStaffId()!=null || consumVo.getConsumType()!=null || StringUtils.isNotBlank(consumVo.getCustomerName())){
            boolean shouldChangeBussness_customerId=false,shouldChangeBussness_type=false,shouldChangeBussness_staffId=false;
            Integer customerId=null;

            if(StringUtils.isNotBlank(consumVo.getCustomerName())){
                Customer customer = customerService.getOne(QueryWapperUtils.getInWapper("name", consumVo.getCustomerName()));
                if(customer==null){
                    return ApiResponse.selfError(ReturnCode.CUSTOMER_NOT_EXIST);
                }
                if(recordsConsumption.getCustomerId()!=customer.getId()){
                    recordsConsumption.setCustomerId(customer.getId());
                    if(consumVo.getConsumType()== ConsumeTypeEnum.PROJECT.getType() || consumVo.getConsumType()==ConsumeTypeEnum.MAKE_CARD.getType()){
                        shouldChangeBussness_customerId=true;
                        customerId=customer.getId();
                    }
                }
            }
            if(consumVo.getConsumType()!=null && consumVo.getConsumType()!=recordsConsumption.getConsumType()){
                recordsConsumption.setConsumType(consumVo.getConsumType());
                if(consumVo.getConsumType()== ConsumeTypeEnum.PROJECT.getType() || consumVo.getConsumType()==ConsumeTypeEnum.MAKE_CARD.getType()){
                    shouldChangeBussness_type=true;
                }
            }
            if(consumVo.getStaffId()!=null && consumVo.getStaffId()!=recordsConsumption.getUserId()){
                recordsConsumption.setUserId(consumVo.getStaffId());
                if(consumVo.getConsumType()== ConsumeTypeEnum.PROJECT.getType() || consumVo.getConsumType()==ConsumeTypeEnum.MAKE_CARD.getType()){
                    shouldChangeBussness_staffId=true;
                }
            }

            RecordBusiness recordBusiness = recordBusinessService.getOne(
                    QueryWapperUtils.getInWapper("date", recordsConsumption.getPayTime()));
            if(recordBusiness!=null){
                if(shouldChangeBussness_customerId){
                    recordBusiness.setCustomerId(customerId);
                }
                if(shouldChangeBussness_type){
                    recordBusiness.setType(consumVo.getConsumType()== ConsumeTypeEnum.PROJECT.getType()?
                            ConsumeTypeEnum.PROJECT.getType() : ConsumeTypeEnum.MAKE_CARD.getType());
                }
                if(shouldChangeBussness_staffId){
                    recordBusiness.setUserId(consumVo.getStaffId());
                }
                res2=recordBusinessService.updateById(recordBusiness);
            }
        }

        if(consumVo.getRemark()!=null){
            recordsConsumption.setRemark(consumVo.getRemark());
        }
        recordsConsumption.setPayTime(null);
        res3=recordsConsumptionService.updateById(recordsConsumption);
        if(res1 && res2 && res3){
            return ApiResponse.ok();
        }else {
            log.info(this.getClass().getName()+"updateRecordsConsumption:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation("删除消费记录 （需要权限[consum_edit]） 会随着修改busness、turnover")
    @ApiImplicitParam(name = "id",value = "消费记录id")
    @Transactional
    public ApiResponse deleteRecordsConsumption(@PathVariable Integer id){
        RecordsConsumption recordsConsumption = recordsConsumptionService.getById(id);
        if(recordsConsumption==null){
            return ApiResponse.selfError(ReturnCode.CONSUM_NOT_EXITST);
        }

        boolean res1=true,res2=true,res3=true;
        res1=editTurnover(recordsConsumption);
        res2=recordBusinessService.remove(QueryWapperUtils.getInWapper("date", recordsConsumption.getPayTime()));
        res3=recordsConsumptionService.removeById(recordsConsumption);

        if(res1 && res2 && res3){
            return ApiResponse.ok();
        }else {
            log.info(this.getClass().getName()+"deleteRecordsConsumption:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    private List<ReturnConsumVo> getReturnConsumVoList(List<RecordsConsumption> records){
        List<ReturnConsumVo> res=new ArrayList<>();
        records.forEach(record->{
            User user=userService.getById(record.getUserId());
            Customer customer=customerService.getById(record.getCustomerId());
            res.add(new ReturnConsumVo(record,customer==null ? null:customer.getName(),user.getName()));
        });
        return res;
    }

    private boolean editTurnover(RecordsConsumption recordsConsumption){
        RecordsTurnover recordsTurnover = recordsTurnoverService.getOne(
                QueryWapperUtils.getInWapper("date", TimeConvertUtils.convertTo_yMd(recordsConsumption.getPayTime())));

        if (recordsTurnover != null && recordsConsumption.isRecord()) {
            recordsConsumption.setRecord(false);

            if (recordsConsumption.getPayType() == PayTypeEnum.RETURN_TO_COSTOMER.getType()) {
                recordsTurnover.setMoneyOutcome(recordsTurnover.getMoneyOutcome() - recordsConsumption.getPrice());
            } else if (recordsConsumption.getPayType() == PayTypeEnum.USE_MONEY.getType()) {
                recordsTurnover.setMoneyIncome(recordsTurnover.getMoneyIncome() - recordsConsumption.getPrice());
            } else if (recordsConsumption.getPayType() == PayTypeEnum.REDUCE_BALANCE.getType()) {
                recordsTurnover.setBalanceReduce(recordsTurnover.getBalanceReduce() - recordsConsumption.getPrice());
            } else if (recordsConsumption.getPayType() == PayTypeEnum.REDUCE_CARD_TIMES.getType()) {
                recordsTurnover.setCardReduce(recordsTurnover.getCardReduce() - recordsConsumption.getPrice());
            }
            recordsTurnover.setSumIncome(recordsTurnover.getSumIncome()-recordsConsumption.getPrice());
            return recordsTurnoverService.updateById(recordsTurnover);
        }

        return true;
    }
}
