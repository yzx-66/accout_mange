package com.hfut.laboratory.shiro.filter;

import com.hfut.laboratory.util.jwt.JwtTokenUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Set;

/**
 * 权限or的过滤器
 */
public class PermisstionOrAuthorizationFilter extends AuthorizationFilter {

    @SuppressWarnings({"unchecked"})
    public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        String[] perms = ((String[])mappedValue);
        if(perms==null || perms.length==0){
            return true;
        }

        HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
        HttpServletResponse httpServletResponse=WebUtils.toHttp(response);
        Set<String> hasPerms= JwtTokenUtils.getPermsSet(httpServletRequest);
        if(hasPerms==null){
            return false;
        }

        for(String perm:perms){
            if(hasPerms.contains(perm)){
                JwtTokenUtils.setJwtTokenByInfoFormCookie(httpServletRequest,httpServletResponse);
                return true;
            }
        }

        return false;
    }
}