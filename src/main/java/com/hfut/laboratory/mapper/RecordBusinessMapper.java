package com.hfut.laboratory.mapper;

import com.hfut.laboratory.pojo.RecordBusiness;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yzx
 * @since 2019-11-11
 */
public interface RecordBusinessMapper extends BaseMapper<RecordBusiness> {

    @Select({"<script> " +
            "SELECT " +
            "COUNT( * ) count, thing_id  " +
            "FROM " +
            "record_business  " +
            "WHERE " +
            "type = #{type} " +
            "<if test='startTime != null'> AND <![CDATA[ date >= #{startTime} ]]> </if> " +
            "<if test='endTime != null'> AND <![CDATA[ date <= #{endTime} ]]> </if> " +
            "GROUP BY " +
            "thing_id;" +
            "</script>"})
    List<Map<String,Object>> groupByProject(@Param("type") Integer type,
                                            @Param("startTime")String startTime,
                                            @Param("endTime") String endTime);
}
