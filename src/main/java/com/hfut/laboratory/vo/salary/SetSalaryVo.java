package com.hfut.laboratory.vo.salary;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * 老板设置员工薪水时传递的对象
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SetSalaryVo {

    private Integer staffId;
    /**
     * 底薪
     */
    private Float baseSalary;

    /**
     * 其他奖金
     */
    private Float otherBonus;

    /**
     * 扣除的钱
     */
    private Float deductSalary;

    private String remark;
}
