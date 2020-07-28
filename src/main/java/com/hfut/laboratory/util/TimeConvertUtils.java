package com.hfut.laboratory.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TimeConvertUtils {

    /**
     * 转换后时间为当天的00:00:00
     * @return
     */
    public static LocalDateTime convertTo_yMd(LocalDateTime localDateTime){
        String date = localDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))+" 00:00:00";
        return LocalDateTime.parse(date,DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

    }
}
