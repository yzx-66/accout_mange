package com.hfut.laboratory.vo.record;

import com.hfut.laboratory.pojo.RecordsConsumption;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ReturnConsumVo extends RecordsConsumption {

    private String customerName;
    private String staffName;

    public ReturnConsumVo(RecordsConsumption record,String customerName,String staffName){
        this.customerName=customerName;
        this.staffName=staffName;
        this.setRecord(record.isRecord());
        this.setConsumType(record.getConsumType());
        this.setPayType(record.getPayType());
        this.setCustomerId(record.getCustomerId());
        this.setUserId(record.getUserId());
        this.setId(record.getId());
        this.setPayTime(record.getPayTime());
        this.setPrice(record.getPrice());
        this.setRemark(record.getRemark());
    }
}
