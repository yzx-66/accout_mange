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

    private Float change;

    private String remark;
}
