package com.hfut.laboratory.vo.customer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 删除客户卡
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CustomerReturnCardVo {

    private Integer staffId;
    private Integer customerCardId;
    //退的钱
    private Float price;
    //此次改变的备注
    private String remark;
}
