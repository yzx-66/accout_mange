package com.hfut.laboratory.shiro.filter;

import com.hfut.laboratory.util.jwt.JwtTokenUtils;
import org.apache.shiro.util.CollectionUtils;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Set;

/**
 * 角色or的过滤器
 */
public class RolesOrAuthorizationFilter extends AuthorizationFilter {

    @SuppressWarnings({"unchecked"})
    public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        String[] rolesArray = (String[]) mappedValue;
        //没有角色限制，可以直接访问
        if (rolesArray == null || rolesArray.length == 0) {
            return true;
        }

        HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
        HttpServletResponse httpServletResponse=WebUtils.toHttp(response);
        Set<String> hasRoles= JwtTokenUtils.getRolesSet(httpServletRequest);
        if(hasRoles==null){
            return false;
        }

        //获取当前访问路径所需要的角色集合
        Set<String> roles = CollectionUtils.asSet(rolesArray);

        //当前subject是roles 中的任意一个，则有权限访问
        for(String role : roles){
            if(hasRoles.contains(role)){
                JwtTokenUtils.setJwtTokenByInfoFormCookie(httpServletRequest,httpServletResponse);
                return true;
            }
        }

        return false;
    }
}