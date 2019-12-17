package com.hfut.laboratory.other;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hfut.laboratory.pojo.CouponCard;
import com.hfut.laboratory.pojo.Customer;
import com.hfut.laboratory.service.CustomerService;
import com.hfut.laboratory.util.CodecUtils;
import com.hfut.laboratory.util.TimeConvertUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.*;
import java.lang.reflect.Proxy;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

@RunWith(SpringRunner.class)
@SpringBootTest
public class OtherTests {

    @Autowired
    private ObjectMapper objectMapper;


    @Test
    public void test(){
        System.out.println(CodecUtils.md5Hex("other",3));
    }

    @Test
    public void test02(){
        System.out.println(LocalDateTime.now());
    }

    @Test
    public void test03(){
        System.out.println(new Date().getTime());
    }

    @Test
    public void test04(){
        LocalDateTime dateTime=TimeConvertUtils.convertTo_yMd(LocalDateTime.now());
        System.out.println(dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
    }

    @Test
    public void test05(){
        File test=new File("test1.txt");
        System.out.println(test.getAbsolutePath());
        Class<? extends OtherTests> aClass = this.getClass();
    }

    @Test
    public void test06(){
    }
}
