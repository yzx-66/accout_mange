package com.hfut.laboratory.vo.record;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class AddOrEditConsumVo {

    private String customerName;

    private Integer staffId;

    /**
     * 消费类型 1：收费项目、2.办卡、3.充值余额、4.给卡增加次数
     */
    private Integer consumType;

    private Float price;

    /**
     * 1：从卡里扣除，2：从余额扣除，3.支付
     */
    private Integer payType;

    private String remark;
}
