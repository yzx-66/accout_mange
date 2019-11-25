package com.hfut.laboratory.vo.card;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 修改优惠卡项目时传递的对象
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CardDetailVo {

    @Data
    @NoArgsConstructor
    public static class ProDetail{
        private Integer projectId;
        private Integer times;
        private String introduction;
    }

    private Integer cardId;
    private List<ProDetail> proDetails;
}
