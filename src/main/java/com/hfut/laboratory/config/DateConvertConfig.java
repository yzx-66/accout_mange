package com.hfut.laboratory.config;

import com.fasterxml.jackson.databind.*;
import com.hfut.laboratory.util.ObjectMapperUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 * spring传递对象时 转化时间类型
 */
@Configuration
public class DateConvertConfig {

    /** 默认日期时间格式 */
    public static final String DEFAULT_DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
    /** 默认日期格式 */
    public static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd";
    /** 默认时间格式 */
    public static final String DEFAULT_TIME_FORMAT = "HH:mm:ss";


    /**
     * 演示：时间戳转化为Date
     *
     * 注入转换器Converter< , >
     * 泛型的第一个参数是转换前的类型 泛型的第二个参数是转换后的类型
     */
/*
    @Bean
    public Converter<Long,Date> dateConverterByTimestap(){
        return new Converter<Long, Date>() {
            @Override
            public Date convert(Long source) {
                return new Date(source);
            }
        };
    }
*/

    /**
     * LocalDate转换器，用于转换RequestParam和PathVariable参数
     */
    @Bean
    public Converter<String, LocalDate> localDateConverter() {
        return new Converter<String, LocalDate>() {
            @Override
            public LocalDate convert(String source) {
                if(StringUtils.isNoneBlank(source))
                    return LocalDate.parse(source, DateTimeFormatter.ofPattern(DEFAULT_DATE_FORMAT));
                return null;
            }
        };
    }

    /**
     * LocalDateTime转换器，用于转换RequestParam和PathVariable参数
     */
    @Bean
    public Converter<String, LocalDateTime> localDateTimeConverter() {
        return new Converter<String, LocalDateTime>() {
            @Override
            public LocalDateTime convert(String source) {
                if(StringUtils.isNoneBlank(source))
                    return LocalDateTime.parse(source, DateTimeFormatter.ofPattern(DEFAULT_DATE_TIME_FORMAT));
                return null;
            }
        };
    }

    /**
     * LocalTime转换器，用于转换RequestParam和PathVariable参数
     */
    @Bean
    public Converter<String, LocalTime> localTimeConverter() {
        return new Converter<String, LocalTime>() {
            @Override
            public LocalTime convert(String source) {
                if(StringUtils.isNoneBlank(source))
                    return LocalTime.parse(source, DateTimeFormatter.ofPattern(DEFAULT_TIME_FORMAT));
                return null;
            }
        };
    }

    /**
     * Date转换器，用于转换RequestParam和PathVariable参数
     */
    @Bean
    public Converter<String, Date> dateConverterByFormate() {
        return new Converter<String,Date>(){
            @Override
            public Date convert(String source) {
                if(StringUtils.isNoneBlank(source)){
                    SimpleDateFormat format = new SimpleDateFormat(DEFAULT_DATE_TIME_FORMAT);
                    try {
                        return format.parse(source);
                    } catch (ParseException e) {
                        throw new RuntimeException(e);
                    }
                }
                return null;
            }
        };
    }

    /**
     * Json序列化和反序列化转换器，用于转换Post请求体中的json以及将我们的对象序列化为返回响应的json
     */
    @Bean
    public ObjectMapper objectMapper(){
        ObjectMapper objectMapper = new ObjectMapper();
        ObjectMapperUtils.registerTimeModule(objectMapper);
        return objectMapper;
    }


}
