package com.hfut.laboratory.vo.salary;

import com.hfut.laboratory.pojo.Salary;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 返回的薪水详情
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReturnSalaryVo extends Salary {

    /**
     * 用户名称
     */
    private String staffName;

    public ReturnSalaryVo(Salary salary, String staffName){
        this.staffName=staffName;
        this.setId(salary.getId());
        this.setUserId(salary.getUserId());
        this.setCardSum(salary.getCardSum());
        this.setProSum(salary.getProSum());
        this.setMakeMoneyIncome(salary.getMakeMoneyIncome());
        this.setBaseSalary(salary.getBaseSalary());
        this.setSumSalary(salary.getSumSalary());
        this.setSettleDate(salary.getSettleDate());
        this.setProAdd(salary.getProAdd());
    }

}
