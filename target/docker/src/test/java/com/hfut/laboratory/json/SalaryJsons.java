package com.hfut.laboratory.json;


import com.hfut.laboratory.util.JsonUtils;
import com.hfut.laboratory.vo.salary.SetSalaryVo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class SalaryJsons {

    @Test
    public void serializeSetSalaryVo(){
        SetSalaryVo setSalaryVo=SetSalaryVo.builder()
                .baseSalary(2000f)
                .deductSalary(100f)
                .otherBonus(200f)
                .remark("扣除100 奖金200")
                .staffId(5)
                .build();

        System.out.println(JsonUtils.serialize(setSalaryVo));
    }

//    @Test
//    public void serializeQuerySalaryVo(){
//        QuerySalaryVo querySalaryVo=QuerySalaryVo.builder()
//                .staffId(4)
//                .startTime(TimeConvertUtils.convertTo_yMd(LocalDateTime.now()))
//                .endTime(LocalDateTime.now())
//                .build();
//
//        System.out.println(JsonUtils.serialize(querySalaryVo));
//    }
}
