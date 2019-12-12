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
public class Salary implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 用户id（员工类型）
     */
    private Integer userId;

    /**
     * 任何方式支付前提下完成收费项目的价值
     */
    private Float proSum;

    /**
     * 任何方式支付前提下完成办卡的价值
     */
    private Float cardSum;

    /**
     * 招揽的现金营业额
     */
    private Float makeMoneyIncome;

    /**
     * 底薪
     */
    private Float baseSalary;

    private Float proAdd;

    /**
     * 总的工资
     */
    private Float sumSalary;

    /**
     * 结算日期
     */
    private LocalDateTime settleDate;

    private String remark;
}
