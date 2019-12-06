package com.hfut.laboratory.controller.authc.perms;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hfut.laboratory.enums.ConsumeTypeEnum;
import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.enums.PayTypeEnum;
import com.hfut.laboratory.pojo.*;
import com.hfut.laboratory.service.*;
import com.hfut.laboratory.util.QueryWapperUtils;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.PageResult;
import com.hfut.laboratory.vo.customer.*;
import com.hfut.laboratory.vo.customer.CustomerCardVo;
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
@RequestMapping("customer")
@Api(tags = "客户相关接口")
@Slf4j
public class CustomerController {

    @Autowired
    private CustomerService customerService;
    @Autowired
    private CustomerCardService customerCardService;
    @Autowired
    private CustomerCardProjectService customerCardProjectService;
    @Autowired
    private ProjectService projectService;
    @Autowired
    private CouponCardDetailService couponCardDetailService;
    @Autowired
    private RecordsConsumptionService recordsConsumptionService;
    @Autowired
    private RecordBusinessService recordBusinessService;
    @Autowired
    private UserService userService;
    @Autowired
    private CouponCardService couponCardService;

    @GetMapping("/list")
    @ApiOperation("获取客户列表")
    @Cacheable(value = "getCustomerList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<Customer>> getCustomerList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                             @RequestParam(required = false,defaultValue = "20") Integer size){
        Page<Customer> page=new Page<>(current,size);
        IPage<Customer> customerIPage = customerService.page(page, null);
        return ApiResponse.ok(new PageResult<>(customerIPage.getRecords(),customerIPage.getTotal(),customerIPage.getSize()));
    }


    @GetMapping("/{id}")
    @ApiOperation("通过id获取客户")
    @ApiImplicitParam(name = "id",value = "客户的id")
    @Cacheable(value = "getCustomerById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<Customer> getCustomerById(@PathVariable Integer id){
        Customer customer = customerService.getById(id);
        return ApiResponse.ok(customer);
    }

    @GetMapping
    @ApiOperation("查找客户")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "customerQuery",value = "查询客户的对象"),
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "queryCutomer",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<Customer>> queryCutomer(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                          @RequestParam(required = false,defaultValue = "20") Integer size,
                                                          @RequestParam(required = false) String name,
                                                          @RequestParam(required = false) String phone,
                                                          @RequestParam(required = false) LocalDateTime startTime,
                                                          @RequestParam(required = false) LocalDateTime endTime){
        Page page=new Page(current,size);
        QueryWrapper<Customer> queryWrapper=new QueryWrapper<>();

        if(StringUtils.isNoneBlank(name)){
            queryWrapper.and(wapper->wapper.like("name","%"+name+"%"));
        }
        if(StringUtils.isNoneBlank(phone)){
            queryWrapper.and(wapper->wapper.like("phone","%"+phone+"%"));
        }
        if(startTime!=null){
            queryWrapper.and(wapper->wapper.ge("registe_time",startTime));
        }
        if(endTime!=null){
            queryWrapper.and(wapper->wapper.le("registe_time",endTime));
        }

        IPage customerIpage = customerService.page(page, queryWrapper);
        return ApiResponse.ok(new PageResult<>(customerIpage.getRecords(),customerIpage.getTotal(),customerIpage.getSize()));
    }

    @GetMapping("/card/{id}")
    @ApiOperation("通过id获取客户的所有优惠卡")
    @ApiImplicitParam(name = "id",value = "客户的id")
    @Cacheable(value = "getCustmerCardById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<List<CustomerCardVo>> getCustmerCardById(@PathVariable Integer id){
        if (!isCustomerExits(id)) {
            return ApiResponse.selfError(ReturnCode.CUSTOMER_NOT_EXIST);
        }

        List<CustomerCardVo> res=new ArrayList<>();
        customerCardService.list(QueryWapperUtils.getInWapper("customer_id", new Integer[]{id})).forEach(c_card->{
            CustomerCard customerCard= (CustomerCard) c_card;
            List<CustomerCardVo.Deatil> deatils=new ArrayList<>();

            customerCardProjectService.list(QueryWapperUtils.getInWapper("customer_card_id", new Integer[]{customerCard.getId()})).forEach(c_c_pro->{
                CustomerCardProject customerCardProject= (CustomerCardProject) c_c_pro;
                Project project=projectService.getById(customerCardProject.getProjectId());
                CustomerCardVo.Deatil deatil=new CustomerCardVo.Deatil(project.getId(),project.getName(),customerCardProject.getResidualTimes());
                deatils.add(deatil);
            });

            CustomerCardVo customerCardVo=new CustomerCardVo(customerCard,deatils);
            res.add(customerCardVo);
        });

        return ApiResponse.ok(res);
    }

    @GetMapping("/balance/{id}")
    @ApiOperation("通过id获取客户的余额")
    @ApiImplicitParam(name = "id",value = "客户的id")
    @Cacheable(value = "getBalanceById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<Float> getBalanceById(@PathVariable Integer id){
        Customer customer = customerService.getById(id);
        if(customer==null){
            return ApiResponse.selfError(ReturnCode.CUSTOMER_NOT_EXIST);
        }

        Float balance=customer.getBalance();
        if(balance==null || Float.isNaN(balance)){
            balance=0.0f;
        }

        return ApiResponse.ok(balance);
    }


    @PostMapping("/add")
    @ApiOperation("添加客户 不可添加余额 必须走充值")
    @ApiImplicitParam(name = "customer",value = "客户的json对象")
    public ApiResponse<Void> insertCustomer(@RequestBody Customer customer){
        if(customer.getName()==null || customer.getPhone()==null){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        customer.setRegisteTime(LocalDateTime.now());
        customer.setStatus(1);
        customer.setBalance(0.0f);
        boolean res = customerService.save(customer);
        return res ? ApiResponse.created():ApiResponse.serverError();
    }

    @PostMapping("/freeze/{id}")
    @ApiOperation("冻结或解冻客户 如果是冻结则解冻 如果是非冻结则冻结（需要权限：[customer_freeze]）")
    @ApiImplicitParam(name = "id",value = "客户的id")
    public ApiResponse<Void> deleteCustomer(@PathVariable Integer id){
        Customer customer = customerService.getById(id);
        if(customer==null){
            return ApiResponse.selfError(ReturnCode.CUSTOMER_NOT_EXIST);
        }

        customer.setStatus(customer.getStatus()==1 ? 0 : 1);
        customer.setRegisteTime(null);
        boolean res = customerService.updateById(customer);
        return res ? ApiResponse.ok(): ApiResponse.serverError();
    }

    @PutMapping("/edit")
    @ApiOperation("修改客户 不可以修改余额")
    @ApiImplicitParam(name = "customer",value = "客户的json对象")
    public ApiResponse<Void> updateCustomer(@RequestBody Customer customer){
        if (!isCustomerExits(customer.getId())) {
            return ApiResponse.selfError(ReturnCode.CUSTOMER_NOT_EXIST);
        }

        customer.setRegisteTime(null);
        customer.setBalance(null);
        boolean res = customerService.updateById(customer);
        return res ? ApiResponse.ok():ApiResponse.serverError();
    }


    @PostMapping("/card/{id}")
    @ApiOperation("客户办卡")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "客户id"),
            @ApiImplicitParam(name = "makeCardVo",value = "客户办卡的传递对象")
    })
    @Transactional
    public ApiResponse<Void> insertCustmerCard(@PathVariable Integer id,
                                                  @RequestBody CustomerMakeCardVo makeCardVo){
        if (!isCustomerExits(id)) {
            return ApiResponse.selfError(ReturnCode.CUSTOMER_NOT_EXIST);
        }
        if(isFreeze(id)){
            return ApiResponse.selfError(ReturnCode.CUSTOMER_FREEZE);
        }
        if(makeCardVo.getStaffId()==null || makeCardVo.getPayType()==null){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        if(userService.getById(makeCardVo.getStaffId())==null){
            return ApiResponse.selfError(ReturnCode.USER_NOT_EXITST);
        }
        if(couponCardService.getById(makeCardVo.getCardId())==null){
            return ApiResponse.selfError(ReturnCode.CARD_NOT_EXIST);
        }
        boolean res1=true,res2=true,res3=true,res4=true,res5=true;

        CouponCard card=couponCardService.getById(makeCardVo.getCardId());
        if(makeCardVo.getPrice()==null){
            makeCardVo.setPrice(card.getPrice());
        }
        //如果是余额支付
        if(makeCardVo.getPayType()== PayTypeEnum.REDUCE_BALANCE.getType()){
            Integer updateBalanceCode=changeBalance(id,-1 * makeCardVo.getPrice());
            if(updateBalanceCode==-1){
                return ApiResponse.selfError(ReturnCode.CUSTOMER_BALANCE_NOT_ENOUGH);
            }
            res1=updateBalanceCode==1;
        }

        CustomerCard customerCard=CustomerCard.builder()
                .cardId(makeCardVo.getCardId())
                .customerId(id)
                .userId(makeCardVo.getStaffId())
                .price(makeCardVo.getPrice())
                .openingTime(LocalDateTime.now())
                .deadTime(makeCardVo.getDeadTime()!=null ? makeCardVo.getDeadTime() : card.getEndTime())
                .remarks(makeCardVo.getRemark())
                .build();
       res2=customerCardService.save(customerCard);

        List<CouponCardDetail> cardDetailList = couponCardDetailService.list(QueryWapperUtils.getInWapper("card_id", new Integer[]{makeCardVo.getCardId()}));
        for(CouponCardDetail couponCardDetail:cardDetailList){
            CustomerCardProject customerCardProject=CustomerCardProject.builder()
                    .customerCardId(customerCard.getId())
                    .projectId(couponCardDetail.getProjectId())
                    .residualTimes(couponCardDetail.getTimes())
                    .build();
            if(!customerCardProjectService.save(customerCardProject)){
                res3=false;
                break;
            }
        }

        RecordsConsumption recordsConsumption=RecordsConsumption.builder()
                .customerId(id)
                .userId(makeCardVo.getStaffId())
                .payType(makeCardVo.getPayType())
                .payTime(LocalDateTime.now())
                .price(makeCardVo.getPrice())
                .consumType(ConsumeTypeEnum.MAKE_CARD.getType())
                .remark(makeCardVo.getRemark())
                .isRecord(false)
                .build();
        res4 = recordsConsumptionService.save(recordsConsumption);

        RecordBusiness recordBusiness=RecordBusiness.builder()
                .date(LocalDateTime.now())
                .type(1)
                .thingId(makeCardVo.getCardId())
                .userId(makeCardVo.getStaffId())
                .customerId(id)
                .build();
        res5=recordBusinessService.save(recordBusiness);

        if(res1 && res2 && res3 && res4 && res5){
            return ApiResponse.created();
        }else {
            log.info(this.getClass().getName()+"insertCustmerCard:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }


    @PutMapping("/card/{id}")
    @ApiOperation("充值或减少客户现有卡的项目次数")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "客户id"),
            @ApiImplicitParam(name = "editCardVo",value = "客户改变卡的次数的传递对象")
    })
    @Transactional
    public ApiResponse<Void> updateCustmerCardPro(@PathVariable Integer id,
                                                     @RequestBody CustomerEditCardVo editCardVo){
        if (!isCustomerExits(id)) {
            return ApiResponse.selfError(ReturnCode.CUSTOMER_NOT_EXIST);
        }
        if(isFreeze(id)){
            return ApiResponse.selfError(ReturnCode.CUSTOMER_FREEZE);
        }
        if(editCardVo.getStaffId()==null || (editCardVo.getTimes()>0 && editCardVo.getPayType()==null)){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        if(projectService.getById(editCardVo.getProjectId())==null){
            return ApiResponse.selfError(ReturnCode.PROJECT_NOT_EXITST);
        }
        if(userService.getById(editCardVo.getStaffId())==null){
            return ApiResponse.selfError(ReturnCode.USER_NOT_EXITST);
        }

        boolean res1=true,res2=true,res3=true,res4=true;

        //如果使用优惠卡结算 判断是否过期
        if(editCardVo.getTimes()<0){
            CustomerCard customerCard = customerCardService.getById(editCardVo.getCustomerCardId());
            LocalDateTime now=LocalDateTime.now(),openingTime=customerCard.getOpeningTime(),deadTime=customerCard.getDeadTime();
            if (!(now.isAfter(openingTime) && now.isBefore(deadTime))) {
                return ApiResponse.selfError(ReturnCode.CUSTOMER_CARD_DEAD);
            }
        }

        QueryWrapper<CustomerCardProject> queryWrapper=new QueryWrapper<>();
        queryWrapper.in("customer_card_id", new Integer[]{editCardVo.getCustomerCardId()});
        queryWrapper.and(wapper->wapper.in("project_id", new Integer[]{editCardVo.getProjectId()}));
        CustomerCardProject customerCardProject = customerCardProjectService.getOne(queryWrapper);

        //如果客户优惠卡的优惠项目不存在
        if(customerCardProject==null){
            return ApiResponse.selfError(ReturnCode.CUSTOMER_CARD_NOT_EXITST);
        }

        //如果用卡消费 那么该卡的该项目次数是否够
        int resTimes=customerCardProject.getResidualTimes()+editCardVo.getTimes();
        if(editCardVo.getTimes()<0 && resTimes<0){
            return ApiResponse.selfError(ReturnCode.CUSTOMER_CARD_NOT_ENOUGH);
        }

        //如果充值 且使用余额支付 判断余额是否充足
        if(editCardVo.getTimes()>0 && editCardVo.getPayType()== PayTypeEnum.REDUCE_BALANCE.getType()){
            Integer updateBalanceCode=changeBalance(id,-1 * editCardVo.getPrice()); //扣除所以乘-1
            if(updateBalanceCode==-1){
                return ApiResponse.selfError(ReturnCode.CUSTOMER_BALANCE_NOT_ENOUGH);
            }
            res1=updateBalanceCode==1;
        }

        customerCardProject.setResidualTimes(resTimes);
        res2=customerCardProjectService.updateById(customerCardProject);

        //如果是用卡消费 那么消费金额要找到对应的project
        Project project=null;
        if(editCardVo.getTimes()<0){
             project = projectService.getById(editCardVo.getProjectId());
        }

        RecordsConsumption recordsConsumption=RecordsConsumption.builder()
                .customerId(id)
                .userId(editCardVo.getStaffId())
                .payType(editCardVo.getTimes()<0 ? PayTypeEnum.REDUCE_CARD_TIMES.getType() :editCardVo.getPayType())
                .payTime(LocalDateTime.now())
                .price(editCardVo.getTimes()<0 ? project.getPrice()* Math.abs(editCardVo.getTimes()) : editCardVo.getPrice())
                .consumType(editCardVo.getTimes()<0 ? ConsumeTypeEnum.PROJECT.getType() : ConsumeTypeEnum.ADD_PROTIMES.getType() )
                .remark(editCardVo.getRemark())
                .isRecord(false)
                .build();
        res3 = recordsConsumptionService.save(recordsConsumption);

        //如果是用工做了项目 要给员工记录
        if(editCardVo.getTimes()<0){
            List<RecordBusiness> recordBusinessList=new ArrayList<>();
            for(int i = 0; i<Math.abs(editCardVo.getTimes());i++){
                RecordBusiness recordBusiness=RecordBusiness.builder()
                        .date(LocalDateTime.now())
                        .type(2)
                        .thingId(editCardVo.getProjectId())
                        .userId(editCardVo.getStaffId())
                        .customerId(id)
                        .build();
                recordBusinessList.add(recordBusiness);
            }
            res4=recordBusinessService.saveBatch(recordBusinessList);
        }

        if(res1 && res2 && res3 && res4){
            return ApiResponse.ok();
        }else {
            log.info(this.getClass().getName()+"updateCustmerCardPro:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    @PutMapping("/balance/{id}")
    @ApiOperation("充值或减少客户现有的余额")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "客户id"),
            @ApiImplicitParam(name = "balanceVo",value = "客户改变卡余额的传递对象")
    })
    @Transactional
    public ApiResponse<Void> updateCustmerBalance(@PathVariable Integer id,
                                                  @RequestBody CustomerEditBalanceVo balanceVo){
        if (!isCustomerExits(id)) {
            return ApiResponse.selfError(ReturnCode.CUSTOMER_NOT_EXIST);
        }
        if(isFreeze(id)){
            return ApiResponse.selfError(ReturnCode.CUSTOMER_FREEZE);
        }
        if(balanceVo.getStaffId()==null || (balanceVo.getChangeBalance()<0 && (balanceVo.getConsumType()==null || balanceVo.getPayType()==null))){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        if(userService.getById(balanceVo.getStaffId())==null){
            return ApiResponse.selfError(ReturnCode.USER_NOT_EXITST);
        }

        boolean res1=true,res2=true;

        //判断改变余额后余额是否>0
        Integer updateBalanceCode=changeBalance(id,balanceVo.getChangeBalance());
        if(updateBalanceCode==-1){
            return ApiResponse.selfError(ReturnCode.CUSTOMER_BALANCE_NOT_ENOUGH);
        }
        res1=updateBalanceCode==1;

        RecordsConsumption recordsConsumption=RecordsConsumption.builder()
                .customerId(id)
                .userId(balanceVo.getStaffId())
                .payType(balanceVo.getChangeBalance()>0 ? PayTypeEnum.USE_MONEY.getType() : balanceVo.getPayType())
                .payTime(LocalDateTime.now())
                .price(Math.abs(balanceVo.getChangeBalance()))
                .consumType(balanceVo.getChangeBalance()>0 ? ConsumeTypeEnum.ADD_BALANCE.getType() : balanceVo.getConsumType() )
                .remark(balanceVo.getRemark())
                .isRecord(false)
                .build();
        res2 = recordsConsumptionService.save(recordsConsumption);

        if(res1 && res2){
            return ApiResponse.ok();
        }else {
            log.info(this.getClass().getName()+"updateCustmerBalance:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    @PostMapping("/settle")
    @ApiOperation("客户用现金结算")
    @ApiImplicitParam(name = "settleVo",value = "客户用现金结算的传递对象")
    @Transactional
    public ApiResponse<Void> settleCustomer(@RequestBody CustomerSettleVo settleVo){
        if(settleVo.getStaffId()==null || settleVo.getProjectId()==null){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        if(projectService.getById(settleVo.getProjectId())==null){
            return ApiResponse.selfError(ReturnCode.PROJECT_NOT_EXITST);
        }
        if(userService.getById(settleVo.getStaffId())==null){
            return ApiResponse.selfError(ReturnCode.USER_NOT_EXITST);
        }
        boolean res1=true,res2=true;
        Project project=null;

        project=projectService.getById(settleVo.getProjectId());
        RecordBusiness recordBusiness=RecordBusiness.builder()
                .date(LocalDateTime.now())
                .type(2)
                .thingId(settleVo.getProjectId())
                .userId(settleVo.getStaffId())
                .customerId(settleVo.getCustomerId())
                .build();
        res1=recordBusinessService.save(recordBusiness);

        RecordsConsumption recordsConsumption=RecordsConsumption.builder()
                .customerId(settleVo.getCustomerId())
                .userId(settleVo.getStaffId())
                .payType(PayTypeEnum.USE_MONEY.getType())
                .payTime(LocalDateTime.now())
                .price(settleVo.getPrice()==null ? project.getPrice() : settleVo.getPrice())
                .consumType(ConsumeTypeEnum.PROJECT.getType())
                .remark(settleVo.getRemark())
                .isRecord(false)
                .build();
        res2 = recordsConsumptionService.save(recordsConsumption);

        if(res1 && res2){
            return ApiResponse.ok();
        }else {
            log.info(this.getClass().getName()+"settleCustomer:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    @PostMapping("/card/return/{id}")
    @ApiOperation("退客户现有的卡")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id",value = "客户id"),
            @ApiImplicitParam(name = "returnCardVo",value = "退卡的对象")
    })
    @Transactional
    public ApiResponse<Void> returnCustmerCard(@PathVariable Integer id,
                                                  @RequestBody CustomerReturnCardVo returnCardVo){
        if(returnCardVo.getStaffId()==null){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        if(userService.getById(returnCardVo.getStaffId())==null){
            return ApiResponse.selfError(ReturnCode.USER_NOT_EXITST);
        }

        CustomerCard customerCard=customerCardService.getById(returnCardVo.getCustomerCardId());
        if(customerCard==null){
            return ApiResponse.selfError(ReturnCode.CUSTOMER_CARD_NOT_EXITST);
        }
        boolean res1=true,res2=true,res3=true;

        res1 = customerCardProjectService.remove(QueryWapperUtils.getInWapper("customer_card_id", new Integer[]{returnCardVo.getCustomerCardId()}));
        res2 = customerCardService.removeById(returnCardVo.getCustomerCardId());

        RecordsConsumption recordsConsumption=RecordsConsumption.builder()
                .customerId(id)
                .userId(returnCardVo.getStaffId())
                .payType(PayTypeEnum.RETURN_TO_COSTOMER.getType())
                .payTime(LocalDateTime.now())
                .price(returnCardVo.getPrice())
                .consumType(ConsumeTypeEnum.RETURN_CARD.getType())
                .remark(returnCardVo.getRemark())
                .isRecord(false)
                .build();
        res3 = recordsConsumptionService.save(recordsConsumption);

        if(res1 && res2 && res3){
            return ApiResponse.ok();
        }else {
            log.info(this.getClass().getName()+"returnCustmerCard:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    @DeleteMapping("/card")
    @ApiOperation("删除客户现有的卡 ")
    @ApiImplicitParam(name = "cardId",value = "客户优惠卡的id")
    @Transactional
    public ApiResponse<Void> deleteCustmerCard(@RequestParam Integer cardId){
        CustomerCard customerCard=customerCardService.getById(cardId);
        if(customerCard==null){
            return ApiResponse.selfError(ReturnCode.CUSTOMER_CARD_NOT_EXITST);
        }
        boolean res1=true,res2=true;

        res1 = customerCardProjectService.remove(QueryWapperUtils.getInWapper("customer_card_id", new Integer[]{cardId}));
        res2 = customerCardService.removeById(cardId);

        if(res1 && res2 ){
            return ApiResponse.ok();
        }else {
            log.info(this.getClass().getName()+"deleteCustmerCard:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    /**
     * 检查客户是否存在
     */
    public boolean isCustomerExits(Integer cid){
        return customerService.getById(cid)!=null;
    }

    /**
     * changeBalance 有正有负
     * -1:余额为负、0：没有命中、1：操作成功
     */
    public Integer changeBalance(Integer cid,Float changeBalance){
        Customer customer = customerService.getById(cid);
        Float balance = customer.getBalance()+changeBalance;
        if(balance<0){
            return -1;
        }
        customer.setBalance(balance);
        return customerService.updateById(customer)? 1 : 0;
    }

    /**
     * 检查客户是否冻结 如果冻结则不可对卡、余额进行操作
     */
    public boolean isFreeze(Integer cid){
        Customer customer = customerService.getById(cid);
        return customer.getStatus()==0;
    }

}
