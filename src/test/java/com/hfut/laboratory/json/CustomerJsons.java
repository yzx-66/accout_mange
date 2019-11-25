package com.hfut.laboratory.json;

import com.hfut.laboratory.enums.ConsumeTypeEnum;
import com.hfut.laboratory.enums.PayTypeEnum;
import com.hfut.laboratory.pojo.Customer;
import com.hfut.laboratory.util.JsonUtils;
import com.hfut.laboratory.vo.customer.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@SpringBootTest
@RunWith(SpringRunner.class)
public class CustomerJsons {

    /**
     * 添加或者修改customer时传递的对象
     */
    @Test
    public void serializeCustomer() {
        Customer customer=Customer.builder()
                .balance(100f)
                .name("cus_1")
                .phone("1234")
                .sex(1)
                .weixin("wex")
                .build();

        System.out.println(JsonUtils.serialize(customer));
    }


    /**
     * 客户用现金办卡
     */
    @Test
    public void serializeCustomerMakeCardVo_Money(){
        CustomerMakeCardVo makeCardVo=CustomerMakeCardVo.builder()
                .cardId(2)
                .deadTime(LocalDateTime.parse("2020-11-11 00:00:00", DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                .openingTime(LocalDateTime.parse("2019-11-11 00:00:00",DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                .price(80f)
                .remark("cus_1 80元办卡")
                .payType(PayTypeEnum.USE_MONEY.getType())
                .staffId(4)
                .build();

        System.out.println(JsonUtils.serialize(makeCardVo));

    }

    /**
     * 客户用余额办卡
     */
    @Test
    public void serializeCustomerMakeCardVo_Balance(){
        CustomerMakeCardVo makeCardVo=CustomerMakeCardVo.builder()
                .cardId(3)
                .deadTime(LocalDateTime.parse("2020-11-11 00:00:00", DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                .openingTime(LocalDateTime.parse("2019-11-11 00:00:00",DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                .price(80f)
                .remark("cus_1 用80元余额办1、2、3优惠卡")
                .payType(PayTypeEnum.REDUCE_BALANCE.getType())
                .staffId(4)
                .build();

        System.out.println(JsonUtils.serialize(makeCardVo));
    }

    /**
     * 余额充值
     */
    @Test
    public void serializeCustomerEditBalanceVo(){
        CustomerEditBalanceVo customerEditBalanceVo=CustomerEditBalanceVo.builder()
                .changeBalance(100f)
                .consumType(ConsumeTypeEnum.ADD_BALANCE.getType())
                .staffId(4)
                .remark("4号员工给客户充值余额")
                .build();

        System.out.println(JsonUtils.serialize(customerEditBalanceVo));

    }

    /**
     * 客户退余额
     */
    @Test
    public void serializeCustomerEditBalanceVo_Reduce(){
        CustomerEditBalanceVo customerEditBalanceVo=CustomerEditBalanceVo.builder()
                .changeBalance(-10f)
                .payType(PayTypeEnum.RETURN_TO_COSTOMER.getType())
                .consumType(ConsumeTypeEnum.RETURN_BALANCE.getType())
                .staffId(4)
                .remark("4号员工给客户退余额10元")
                .build();

        System.out.println(JsonUtils.serialize(customerEditBalanceVo));
    }

    /**
     * 客户消费卡里的次数
     */
    @Test
    public void serializeCustomerEditCardVo_ReducePro(){
        CustomerEditCardVo customerEditCardVo=CustomerEditCardVo.builder()
                .customerCardId(5)
                .times(-1)
                .projectId(2)
                .remark("客户使用1、2、3优惠卡的项目1 减少1次")
                .staffId(4)
                .build();

        System.out.println(JsonUtils.serialize(customerEditCardVo));
    }

    /**
     * 客户给卡里充值次数:用支付
     */
    @Test
    public void serializeCustomerEditCardVo_AddPro_Money(){
        CustomerEditCardVo customerEditCardVo=CustomerEditCardVo.builder()
                .customerCardId(4)
                .times(10)
                .projectId(2)
                .remark("客户使用现金给1、2优惠卡的项目1 充值10次")
                .staffId(4)
                .price(50f)
                .payType(PayTypeEnum.USE_MONEY.getType())
                .build();

        System.out.println(JsonUtils.serialize(customerEditCardVo));
    }

    /**
     * 客户给卡里充值次数:用余额
     */
    @Test
    public void serializeCustomerEditCardVo_AddPro_Balance(){
        CustomerEditCardVo customerEditCardVo=CustomerEditCardVo.builder()
                .customerCardId(4)
                .times(10)
                .projectId(2)
                .remark("客户使用余额给1、2优惠卡的项目1 充值10次")
                .staffId(4)
                .price(50f)
                .payType(PayTypeEnum.REDUCE_BALANCE.getType())
                .build();

        System.out.println(JsonUtils.serialize(customerEditCardVo));
    }

    /**
     * 客户使用现金结算
     */
    @Test
    public void serializeCustomerSettleVo(){
        CustomerSettleVo customerSettleVo=CustomerSettleVo.builder()
                .customerId(1)
                .price(20f)
                .projectId(4)
                .staffId(4)
                .consumType(ConsumeTypeEnum.PROJECT.getType())
                .remark("客户使用现金结算4号项目")
                .build();

        System.out.println(JsonUtils.serialize(customerSettleVo));
    }

    /**
     * 退客户现有的卡
     */
    @Test
    public void serializeCustomerDelCardVo(){
        CustomerReturnCardVo customerDelCardVo= CustomerReturnCardVo.builder()
                .customerCardId(4)
                .remark("员工4号 删除客户1的1、2优惠卡")
                .price(20f)
                .staffId(4)
                .build();

        System.out.println(JsonUtils.serialize(customerDelCardVo));
    }

}
