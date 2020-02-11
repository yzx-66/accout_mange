package com.hfut.laboratory.shiro;

import com.hfut.laboratory.constants.UrlConstants;
import com.hfut.laboratory.shiro.filter.JWTFilter;
import com.hfut.laboratory.shiro.filter.PermisstionOrAuthorizationFilter;
import com.hfut.laboratory.shiro.filter.RolesOrAuthorizationFilter;
import com.hfut.laboratory.shiro.matcher.UserCredentialsMatcher;
import com.hfut.laboratory.shiro.realm.UserRealm;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import javax.servlet.Filter;
import java.util.LinkedHashMap;
import java.util.Map;

@Configuration
public class ShiroConfig {

    @Bean
    public ShiroFilterFactoryBean shiroFilter() {

        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();

        //必须设置securityManager
        shiroFilterFactoryBean.setSecurityManager(securityManager());

        //设置自定义filter
        Map<String, Filter> filterMap = new LinkedHashMap<String, Filter>();
        filterMap.put("roleOrFilter", new RolesOrAuthorizationFilter());
        filterMap.put("permissionOrFilter",new PermisstionOrAuthorizationFilter());
        filterMap.put("jwt", new JWTFilter());
        shiroFilterFactoryBean.setFilters(filterMap);

        //需要登录的接口，如果访问某个接口，需要登录却没登录，则调用此接口(如果不是前后端分离，则跳转页面)
        shiroFilterFactoryBean.setLoginUrl("/acc/pub/reject");

        //登录成功，跳转url，如果前后端分离，则没这个调用
        //shiroFilterFactoryBean.setSuccessUrl("/");

        //没有权限，未授权就会调用此方法， 先验证登录 再验证是否有权限
        shiroFilterFactoryBean.setUnauthorizedUrl("/acc/pub/reject");


        //拦截器路径，坑一，部分路径无法进行拦截，时有时无；因为使用的是hashmap, 无序的，应该改为LinkedHashMap
        Map<String, String> filterChainDefinitionMap = new LinkedHashMap<String, String>();

        //有权限才可以访问
        for(String u:UrlConstants.PERMURLS){
            String[] url_perms = StringUtils.split(u,":");
            filterChainDefinitionMap.put(url_perms[0], "permissionOrFilter["+url_perms[1]+"]");
        }

        //匿名可以访问，也是就游客模式
        for(String u: UrlConstants.ANONURLS){
            filterChainDefinitionMap.put(u,"anon");
        }

        //超级管理员才可以访问
        for(String u: UrlConstants.ROOTURLS){
            filterChainDefinitionMap.put(u,"roleOrFilter[root]");
        }

        //特别管理员角色才可以访问
        for(String u: UrlConstants.SPECIAL_ADMINURLS){
            filterChainDefinitionMap.put(u,"roleOrFilter[root,boss]");
        }

        //一般管理员角色才可以访问
        for(String u: UrlConstants.NORMAL_ADMINURLS){
            filterChainDefinitionMap.put(u,"roleOrFilter[root,boss,manger]");
        }

        //坑二: 过滤链是顺序执行，从上而下，一般讲/** 放到最下面
        filterChainDefinitionMap.put("/**", "jwt");

        //TODO 取消拦截就注释这里
        //shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);

        return shiroFilterFactoryBean;
    }


    @Bean
    public DefaultWebSecurityManager securityManager() {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();

        //设置realm（推荐放到最后，不然某些情况会不生效）
        securityManager.setRealm(userRealm());

        return securityManager;
    }


    /**
     * 自定义登陆时的realm
     *
     * @return
     */
    @Bean
    public UserRealm userRealm() {
        UserRealm userRealm=new UserRealm();

        userRealm.setCredentialsMatcher(new UserCredentialsMatcher());
        return userRealm;
    }


    /**
     * 管理shiro一些bean的生命周期 即bean初始化 与销毁
     *
     * @return
     */
    @Bean
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    /**
     * 用来扫描上下文寻找所有的Advistor(通知器),
     * 将符合条件的Advisor应用到切入点的Bean中，需要在LifecycleBeanPostProcessor创建后才可以创建
     *
     * @return
     */
    @Bean
    @DependsOn("lifecycleBeanPostProcessor")
    public DefaultAdvisorAutoProxyCreator getDefaultAdvisorAutoProxyCreator() {
        DefaultAdvisorAutoProxyCreator defaultAdvisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
        defaultAdvisorAutoProxyCreator.setUsePrefix(true);
        return defaultAdvisorAutoProxyCreator;
    }

    /**
     * api controller 层面
     * 加入注解的使用，不加入这个AOP注解不生效(shiro的注解 例如 @RequiresGuest)
     *
     * @return
     */
    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor() {
        AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
        authorizationAttributeSourceAdvisor.setSecurityManager(securityManager());
        return authorizationAttributeSourceAdvisor;
    }

}
