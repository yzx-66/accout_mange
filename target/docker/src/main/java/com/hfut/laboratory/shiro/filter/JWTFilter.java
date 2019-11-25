package com.hfut.laboratory.shiro.filter;

import com.hfut.laboratory.dto.UserInfo;
import com.hfut.laboratory.constants.UrlConstants;
import com.hfut.laboratory.util.jwt.JwtTokenUtils;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.util.AntPathMatcher;
import org.apache.shiro.web.filter.authc.BasicHttpAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 相当于原来的登陆拦截器 authc
 */
public class JWTFilter extends BasicHttpAuthenticationFilter {

    private AntPathMatcher pathMatcher = new AntPathMatcher();

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws UnauthorizedException {
        HttpServletRequest httpServletRequest = WebUtils.toHttp(request);

        for (String u : UrlConstants.ANONURLS) {
            if (pathMatcher.match(u, httpServletRequest.getRequestURI())){
                //直接允许
                return true;
            }
        }

        return executeLogin(request, response);
    }


    @Override
    protected boolean executeLogin(ServletRequest request, ServletResponse response) {
        HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
        HttpServletResponse httpServletResponse=WebUtils.toHttp(response);

        try {
            UserInfo userInfo = JwtTokenUtils.getUserInfoFromToken(httpServletRequest);
            if(userInfo==null){
                return false;
            }

            JwtTokenUtils.setJwtToken(httpServletRequest,httpServletResponse,userInfo.getId());
            return true;
        } catch (Exception e) {
            return false;
        }
    }

}

