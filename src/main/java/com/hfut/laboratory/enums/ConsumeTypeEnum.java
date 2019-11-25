package com.hfut.laboratory.enums;

import lombok.Data;

/**
 * 消费类型
 */
public enum  ConsumeTypeEnum {

    //1.收费项目、2.办卡、3.充值余额、4.给卡充值次数、5.退余额、6.退卡
    PROJECT(1,"消费收费项目"),
    MAKE_CARD(2,"办卡消费"),
    ADD_BALANCE(3,"充值余额"),
    ADD_PROTIMES(4,"给卡的项目充值次数"),
    RETURN_BALANCE(5,"退还余额"),
    RETURN_CARD(6,"退卡")
    ;


    private Integer type;
    private String describe;

    ConsumeTypeEnum(Integer type, String describe) {
        this.type=type;
        this.describe=describe;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }
}
