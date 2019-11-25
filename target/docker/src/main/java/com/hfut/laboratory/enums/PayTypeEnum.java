package com.hfut.laboratory.enums;

/**
 * 支付类型
 */
public enum PayTypeEnum {

    //0：给客户退钱、1：从卡里扣除，2.从余额里扣除，3：花钱支付
    RETURN_TO_COSTOMER(0,"退卡或者退余额 需要给客户退钱"),
    REDUCE_CARD_TIMES(1,"从卡里扣除项目次数"),
    REDUCE_BALANCE(2,"从余额中扣除"),
    USE_MONEY(3,"不扣除 掏钱支付")
    ;

    private Integer type;
    private String describe;

    PayTypeEnum(Integer type, String describe) {
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
