package com.hfut.laboratory.controller;

import com.hfut.laboratory.config.JwtConfig;
import com.hfut.laboratory.dto.UserInfo;
import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.pojo.User;
import com.hfut.laboratory.service.UserService;
import com.hfut.laboratory.util.CodecUtils;
import com.hfut.laboratory.util.CookieUtils;
import com.hfut.laboratory.util.jwt.JwtTokenUtils;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.user.PasswordVo;
import com.hfut.laboratory.vo.user.UserQuery;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

@RestController
@Slf4j
@Api(tags = "系统相关接口")
public class SystemController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtConfig jwtConfig;

    @RequestMapping("pub/reject")
    @ApiOperation("没权限shiro会转发到该接口")
    public ApiResponse needLogin(){
        return ApiResponse.authError();
    }

    @PostMapping("login")
    @ApiOperation("登陆接口")
    @ApiImplicitParam(name = "userQuery",value = "登陆验证的对象")
    public ApiResponse login(@RequestBody UserQuery userQuery, HttpServletRequest request, HttpServletResponse response){

        Subject subject = SecurityUtils.getSubject();
        try {
            UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(userQuery.getName(), userQuery.getPwd());
            subject.login(usernamePasswordToken);

            try{
                JwtTokenUtils.setJwtToken(request,response,userQuery.getName());
            }catch (Exception e){
                e.printStackTrace();
                log.error(new Date()+this.getClass().getName());
                return ApiResponse.serverError();
            }

            return ApiResponse.ok();

        }catch (Exception e){
            return ApiResponse.selfError(ReturnCode.USERNAME_OR_PASSWORD_ERROR);
        }
    }

    @GetMapping("logout")
    public ApiResponse logout(HttpServletRequest request,HttpServletResponse response){
        CookieUtils.setCookie(request,response,jwtConfig.getCookieName(),null,1,"utf-8");
        return ApiResponse.ok();
    }

    @PutMapping("pwd")
    @ApiOperation("修改密码接口")
    @ApiImplicitParam(name = "passwordVo",value = "修改密码的对象")
    public ApiResponse reSetPassword(@RequestBody PasswordVo passwordVo,HttpServletRequest request){
        UserInfo userInfo = JwtTokenUtils.getUserInfoFromToken(request);
        if(userInfo==null){
            return ApiResponse.selfError(ReturnCode.NEED_LOGIN);
        }

        User user = userService.getById(userInfo.getId());
        String password = CodecUtils.md5Hex(passwordVo.getOldPassword(), 3);
        if(!password.equals(user.getPassword())){
            return ApiResponse.selfError(ReturnCode.PASSWORD_ERROR);
        }

        user.setPassword(CodecUtils.md5Hex(passwordVo.getNewPassword(),3));
        boolean res=userService.updateById(user);
        return res ? ApiResponse.ok():ApiResponse.serverError();
    }

}
