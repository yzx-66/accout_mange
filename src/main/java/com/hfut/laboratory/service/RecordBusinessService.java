package com.hfut.laboratory.service;

import com.hfut.laboratory.pojo.RecordBusiness;
import com.baomidou.mybatisplus.extension.service.IService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yzx
 * @since 2019-11-11
 */
public interface RecordBusinessService extends IService<RecordBusiness> {

    List<Map<String,Object>> groupByProject(Integer type, LocalDateTime startTime, LocalDateTime endTime);

}
