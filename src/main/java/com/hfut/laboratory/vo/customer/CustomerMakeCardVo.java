package com.hfut.laboratory.vo.customer;

import io.swagger.models.auth.In;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 客户办卡时传递的对象
 */
@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class CustomerMakeCardVo {

    private Integer staffId;
    private Integer cardId;
    private LocalDateTime openingTime;
    private LocalDateTime deadTime;
    private Float price;
    //2.从余额里扣除，3：支付
    private Integer payType;
    private String remark;
}
