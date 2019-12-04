package com.hfut.laboratory.vo.customer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 客户使用现金结算某些项目时
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CustomerSettleVo {

    private Integer staffId;
    //如果不是会员不填
    private Integer customerId;
    private Integer projectId;
    private Float price;
    //此次改变的备注
    private String remark;

}
