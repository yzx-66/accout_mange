package com.hfut.laboratory.json;

import com.hfut.laboratory.enums.ConsumeTypeEnum;
import com.hfut.laboratory.util.JsonUtils;
import com.hfut.laboratory.util.TimeConvertUtils;
import com.hfut.laboratory.vo.record.AddOrEditConsumVo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.time.LocalDateTime;

@SpringBootTest
@RunWith(SpringRunner.class)
public class RecordsJsons {

//    @Test
//    public void serializeQueryConsumVo(){
//        QueryConsumVo consumVo=QueryConsumVo.builder()
//                .startTime(TimeConvertUtils.convertTo_yMd(LocalDateTime.now()))
//                .endTime(LocalDateTime.now())
//                .customerName("cus_4")
//                .build();
//
//        System.out.println(JsonUtils.serialize(consumVo));
//    }

//    @Test
//    public void serializeQueryTurnover(){
//        QueryTurnoverVo turnoverVo=QueryTurnoverVo.builder()
//                .startTime(TimeConvertUtils.convertTo_yMd(LocalDateTime.now()))
//                .endTime(LocalDateTime.now())
//                .build();
//
//        System.out.println(JsonUtils.serialize(turnoverVo));
//    }

    @Test
    public void addAndEditConsumVo(){
        AddOrEditConsumVo addOrEditConsumVo=AddOrEditConsumVo.builder()
                .consumType(ConsumeTypeEnum.PROJECT.getType())
                .customerPhone("333")
                .payType(3)
                .price(40f)
                .staffId(5)
                .remark("给staff_1设置工资")
                .build();

        System.out.println(JsonUtils.serialize(addOrEditConsumVo));

    }
}
