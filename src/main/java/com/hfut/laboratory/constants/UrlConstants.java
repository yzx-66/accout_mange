package com.hfut.laboratory.constants;

public class UrlConstants {

    /**
     * 不用登陆可访问
     * 该等级一般就是展示首页 没有功能
     */
    public static final String[] ANONURLS=new String[]{"" +
            "/pub/**",
            "/login",
            "/swagger-resources/**",
            "/v2/**",
            "/swagger-ui.html#!/**",
            "/swagger-resources/**"
    };
    /**
     * 登陆后可访问
     * 不用设置 因为后置拦截器/** 会拦截所有没匹配的路径
     */
    public static final String[] AUTHCURLS=new String[]{};

    //涉及到角色或者权限的一定是登陆成功了 因为登陆后才有principal 才可以获取角色和权限 不然shiro会返回未登录

    /**
     * 超级管理员可访问
     * 比如：角色设置 权限设置
     */
    public static final String[] ROOTURLS=new String[]{
            "/role/**",
            "/perm/**"
    };
    /**
     * 管理员可以访问：root、boss
     * 该等级为老板的权限
     */
    public static final String[] SPECIAL_ADMINURLS=new String[]{
            "/user/**",
            "/salary/**",
            "/turnover/**",
    };
    /**
     * 一般管理员可访问：root、boss、manger
     * 该等级为比老板更低低一级的管理权
     */
    public static final String[] NORMAL_ADMINURLS=new String[]{};


    /**
     * 需要某些权限才可以访问
     * 一个路径只能进入一个拦截器 所以有的情况只有后半个路径不同 比如/card/add、/card/edit 两者都要登陆 但是后者要有权限才可以操作
     */
    public static final String[] PERMURLS=new String[]{
            "/card/add:card_add",
            "/card/edit:card_edit",
            "/card/edit_pro:card_edit",
            "/card/del/*:card_del",
            "/card/freeze/*:card_freeze",

            "/project/add:pro_add",
            "/project/edit:pro_edit",
            "/project/del/*:pro_del",

            "/customer/freeze/*:customer_freeze",

            "/salary/set:salary_set",
            "/salary/edit/*:salary_edit",
            "/salary/del/*:salary_del",

            "/consum/edit/*:consum_edit",
            "/consum/del/*:consum_del",

            "/staff/job/*:job_del",
    };

}
