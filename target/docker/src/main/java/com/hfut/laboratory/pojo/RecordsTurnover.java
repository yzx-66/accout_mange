package com.hfut.laboratory.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;

import lombok.*;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author yzx
 * @since 2019-11-09
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RecordsTurnover implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 某一天（以天为单位）
     */
    private LocalDateTime date;

    /**
     * 收入的钱：payType=3
     */
    private Float moneyIncome;

    /**
     * 给客户退的钱（退余额和退卡）payType=0
     */
    private Float moneyOutcome;

    /**
     * 通过卡消费的钱数 payType=1
     */
    private Float cardReduce;

    /**
     * 通过余额消费 payType=2
     */
    private Float balanceReduce;

    /**
     * 总的收入 money_income - money_outcome
     */
    private Float sumIncome;




}
