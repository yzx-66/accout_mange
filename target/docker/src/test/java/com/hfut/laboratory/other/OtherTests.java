package com.hfut.laboratory.other;

import com.hfut.laboratory.util.CodecUtils;
import com.hfut.laboratory.util.TimeConvertUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@RunWith(SpringRunner.class)
@SpringBootTest
public class OtherTests {


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
    }


}
