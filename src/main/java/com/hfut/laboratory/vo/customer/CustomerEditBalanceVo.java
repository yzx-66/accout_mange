package com.hfut.laboratory.vo.customer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 客户充值或减少余额
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CustomerEditBalanceVo {

    private Integer staffId;
    //如果是扣除为负，如果是充值为正
    private Float changeBalance;
    //如果changeBalance<0 那么是：0.退钱给客户，2.消费余额
    private Integer payType;
    //如果payType=2 那么减少余额的原因：1.收费项目、2.办卡、4.给卡充值次数、5.退余额
    private Integer consumType;
    //此次改变的备注
    private String remark;
}
