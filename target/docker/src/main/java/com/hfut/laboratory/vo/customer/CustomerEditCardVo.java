package com.hfut.laboratory.vo.customer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 客户充值或减少卡的次数
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CustomerEditCardVo {

    private Integer staffId;
    private Integer customerCardId;
    private Integer projectId;
    //改变的次数 充值为正 减少为负
    private Integer times;
    //如果是扣除次数：不填，如果是充值 那么充值花多钱
    private Float price;
    //如果扣除次数：1，如果是充值 充值的方式 2.从余额里扣除，3：支付
    private Integer payType;
    //此次改变的备注
    private String remark;
}
