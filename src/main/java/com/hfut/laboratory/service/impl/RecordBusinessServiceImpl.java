package com.hfut.laboratory.service.impl;

import com.hfut.laboratory.constants.TimeFormatConstants;
import com.hfut.laboratory.pojo.RecordBusiness;
import com.hfut.laboratory.mapper.RecordBusinessMapper;
import com.hfut.laboratory.service.RecordBusinessService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yzx
 * @since 2019-11-11
 */
@Service
public class RecordBusinessServiceImpl extends ServiceImpl<RecordBusinessMapper, RecordBusiness> implements RecordBusinessService {

    @Resource
    private RecordBusinessMapper recordBusinessMapper;

    @Override
    public List<Map<String, Object>> groupByProject(Integer type, LocalDateTime startTime,LocalDateTime endTime) {
        return recordBusinessMapper.groupByProject(type,
                startTime!=null ? startTime.format(DateTimeFormatter.ofPattern(TimeFormatConstants.DEFAULT_DATE_TIME_FORMAT)): null ,
                endTime!=null ? endTime.format(DateTimeFormatter.ofPattern(TimeFormatConstants.DEFAULT_DATE_TIME_FORMAT)): null );
    }
}
