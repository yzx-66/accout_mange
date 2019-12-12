package com.hfut.laboratory.util.jwt;

import com.hfut.laboratory.dto.UserInfo;
import com.hfut.laboratory.config.JwtConfig;
import com.hfut.laboratory.pojo.*;
import com.hfut.laboratory.service.*;
import com.hfut.laboratory.util.BeanUtils;
import com.hfut.laboratory.util.CookieUtils;
import com.hfut.laboratory.util.QueryWapperUtils;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.util.HashSet;
import java.util.Set;

@Slf4j
public class JwtTokenUtils {

    /**
     * 给cookie设置jwtToken
     *
     * @param request
     * @param response
     * @param userSign：可以是id 或者 username（必须唯一） 通过id或者username找到唯一的user 然后生成UserInfo对象 设置到token里
     * @throws Exception
     */
    public static void setJwtToken(HttpServletRequest request, HttpServletResponse response, Object userSign) throws Exception {
        UserService userService=BeanUtils.getBean(UserService.class,request);
        JwtConfig jwtConfig=BeanUtils.getBean(JwtConfig.class,request);
        PrivateKey privateKey=BeanUtils.getBean(PrivateKey.class,request);
        UserRoleService userRoleService=BeanUtils.getBean(UserRoleService.class,request);

        User user=null;
        if(userSign instanceof Integer){
            user=userService.getById((Serializable) userSign);
        }else if(userSign instanceof String){
            user=userService.getOne(QueryWapperUtils.getInWapper("name",(String) userSign));
        }else {
            log.info(JwtTokenUtils.class.getName()+"setJwtToken:error");
            return;
        }

        UserInfo userInfo=new UserInfo(user.getId(),user.getName());
        int roleId=userRoleService.getOne(QueryWapperUtils.getInWapper("user_id",user.getId())).getRoleId();

        //新生成token
        int expireTime=roleId==4? jwtConfig.getExpireMinutes(): jwtConfig.getAdminExpireMinutes();
        String token=JwtUtils.generateToken(userInfo,privateKey,expireTime);
        CookieUtils.setCookie(request,response, jwtConfig.getCookieName(),token,null,null);
    }

    /**
     * 从request中直接读取cookie中的信息 然后重新设置到cookie中
     */
    public static void setJwtTokenByInfoFormCookie(HttpServletRequest request, HttpServletResponse response) throws Exception {
        UserInfo userInfo=getUserInfoFromToken(request);
        if(userInfo==null){
            log.info(JwtTokenUtils.class.getName()+"setJwtTokenByInfoFormCookie:error");
            return;
        }
        setJwtToken(request,response,userInfo.getId());
    }

    public static UserInfo getUserInfoFromToken(HttpServletRequest request){
        JwtConfig jwtConfig = BeanUtils.getBean(JwtConfig.class, request);
        String token= CookieUtils.getCookieValue(request,jwtConfig.getCookieName());
        UserInfo userInfo=null;
        try {
            PublicKey publicKey = RsaUtils.getPublicKey(jwtConfig.getPubKeyPath());
            userInfo= JwtUtils.getInfoFromToken(token,publicKey);
        } catch (Exception e) {
            log.info(JwtTokenUtils.class.getName()+"getUserInfoFromToken:error");
            return null;
        }
        return userInfo;
    }

    public static Set<String> getRolesSet(HttpServletRequest request){
        UserService userService=BeanUtils.getBean(UserService.class,request);
        RoleService roleService=BeanUtils.getBean(RoleService.class,request);
        UserRoleService userRoleService=BeanUtils.getBean(UserRoleService.class,request);

        Set<String> roles=new HashSet<>();
        UserInfo userInfo= JwtTokenUtils.getUserInfoFromToken(request);
        if(userInfo==null){
            return null;
        }
        User user=userService.getById(userInfo.getId());

        userRoleService.list(QueryWapperUtils.getInWapper("user_id",user.getId())).forEach(u_r->{
            UserRole userRole= (UserRole) u_r;
            Role role = roleService.getById(userRole.getRoleId());
            roles.add(role.getName());
        });

        return roles;
    }

    public static Set<String> getPermsSet(HttpServletRequest request){
        UserService userService=BeanUtils.getBean(UserService.class,request);
        RoleService roleService=BeanUtils.getBean(RoleService.class,request);
        PermissionService permissionService=BeanUtils.getBean(PermissionService.class,request);
        UserRoleService userRoleService=BeanUtils.getBean(UserRoleService.class,request);
        RolePermissionService rolePermissionService=BeanUtils.getBean(RolePermissionService.class,request);

        Set<String> perms=new HashSet<>();
        UserInfo userInfo= JwtTokenUtils.getUserInfoFromToken(request);;
        if(userInfo==null){
            return null;
        }
        User user=userService.getById(userInfo.getId());

        userRoleService.list(QueryWapperUtils.getInWapper("user_id",user.getId())).forEach(u_r->{
            UserRole userRole= (UserRole) u_r;
            Role role = roleService.getById(userRole.getRoleId());

            rolePermissionService.list(QueryWapperUtils.getInWapper("role_id", role.getId())).forEach(r_p->{
                RolePermission rolePermission= (RolePermission) r_p;
                Permission permission = permissionService.getById(rolePermission.getPermissionId());
                perms.add(permission.getName());
            });
        });

        return perms;
    }
}
