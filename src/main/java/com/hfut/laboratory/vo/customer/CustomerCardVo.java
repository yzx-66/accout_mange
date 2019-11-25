package com.hfut.laboratory.vo.customer;

import com.hfut.laboratory.pojo.CustomerCard;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 客户优惠卡基本信息+所包含项目
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CustomerCardVo extends CustomerCard {

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Deatil {
        private Integer projectId;
        private String projectName;
        private Integer residualTimes;
    }

    private List<Deatil> deatils;

    public CustomerCardVo(CustomerCard card,List<Deatil> deatils){
        this.deatils=deatils;
        this.setId(card.getId());
        this.setCardId(card.getCardId());
        this.setCustomerId(card.getCustomerId());
        this.setOpeningTime(card.getOpeningTime());
        this.setDeadTime(card.getDeadTime());
        this.setRemarks(card.getRemarks());
    }

}
