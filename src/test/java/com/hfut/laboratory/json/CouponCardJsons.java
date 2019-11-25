package com.hfut.laboratory.json;

import com.hfut.laboratory.pojo.CouponCard;
import com.hfut.laboratory.util.JsonUtils;
import com.hfut.laboratory.vo.card.CardDetailVo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
@RunWith(SpringRunner.class)
public class CouponCardJsons {

    /**
     * 添加优惠卡的json对象
     */
    @Test
    public void serializeCouponCard(){
        CouponCard card=CouponCard.builder()
                .name("收费项目1、2优惠卡")
                .percentage(0.1f)
                .introduction("介绍1")
                .price(100f)
                .startTime(LocalDateTime.parse("2019-11-11 00:00", DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")))
                .endTime(LocalDateTime.parse("2020-11-11 00:00",DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")))
                .build();

        System.out.println(JsonUtils.serialize(card));
    }


    /**
     * 给有优惠卡绑定项目的对象
     */
    @Test
    public void serializeCardDetailVo() {
        List<CardDetailVo.ProDetail> proDetails=new ArrayList<>();

        CardDetailVo.ProDetail pro1=new CardDetailVo.ProDetail();
        pro1.setProjectId(6);
        pro1.setTimes(60);
        pro1.setIntroduction("5、6优惠卡 绑定项目5");
        proDetails.add(pro1);

        CardDetailVo.ProDetail pro2=new CardDetailVo.ProDetail();
        pro2.setProjectId(7);
        pro2.setTimes(70);
        pro2.setIntroduction("5、6优惠卡 绑定项目6");
        proDetails.add(pro2);


        CardDetailVo cardDetailVo=CardDetailVo.builder()
                .cardId(4)
                .proDetails(proDetails)
                .build();

        System.out.println(JsonUtils.serialize(cardDetailVo));
    }
}
