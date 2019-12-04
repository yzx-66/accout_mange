package com.hfut.laboratory.enums;

public enum ReturnCode {

    SUCCESS("0001","成功"),
    CREATED("0002","添加成功"),
    UNAUTHORIZED("0003","没有权限"),
    INTERNAL_SERVER_ERROR("0004","服务器错误"),

    DELETE_FALI_Foreign_KEY("0005","存在外键 删除失败"),
    NEED_PARAM("0006","缺少参数"),
    ERROR_PARAM("0007","参数错误"),

    NEED_LOGIN("1001","未登录"),
    PASSWORD_ERROR("1002","旧密码错误"),
    USERNAME_OR_PASSWORD_ERROR("1003","密码或用户名错误"),

    CUSTOMER_NOT_EXIST("2001","客户不存在"),
    CARD_NOT_EXIST("2002","优惠卡不存在"),
    PROJECT_NOT_EXITST("2003","收费项目不存在"),
    SALARY_NOT_EXITST("2004","薪水不存在"),
    CUSTOMER_CARD_NOT_EXITST("2005","客户优惠卡不存在"),
    CONSUM_NOT_EXITST("2006","客户优惠卡不存在"),
    USER_NOT_EXITST("2007","用户不存在"),

    CUSTOMER_FREEZE("3001","客户被冻结 无法操作"),
    CUSTOMER_CARD_NOT_ENOUGH("3002","客户优惠卡次数不足"),
    CUSTOMER_BALANCE_NOT_ENOUGH("3003","客户余额不足"),
    CUSTOMER_CARD_DEAD("3004","客户的优惠卡已经过期"),
    CUSTOMER_CARD_ALREADLY_EXITES("3005","客户优惠卡已经存在");

    private String code;
    private String msg;

    public String getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

    ReturnCode(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }

}
