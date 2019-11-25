package com.hfut.laboratory.vo.card;

import com.hfut.laboratory.pojo.CouponCard;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 优惠卡基本信息+所包含项目
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CouponCardVo extends CouponCard {

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Deatil {
        private Integer projectId;
        private String projectName;
        private Integer times;
    }

    private List<Deatil> deatils;

    public CouponCardVo(CouponCard card,List<Deatil> deatils){
        this.deatils=deatils;
        this.setId(card.getId());
        this.setStartTime(card.getStartTime());
        this.setEndTime(card.getEndTime());
        this.setIntroduction(card.getIntroduction());
        this.setName(card.getName());
        this.setPercentage(card.getPercentage());
        this.setPrice(card.getPrice());
    }
}



