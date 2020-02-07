package com.hfut.laboratory.jwt;

import com.hfut.laboratory.dto.UserInfo;
import com.hfut.laboratory.config.JwtConfig;
import com.hfut.laboratory.util.jwt.JwtUtils;
import com.hfut.laboratory.util.jwt.RsaUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.security.PrivateKey;

@SpringBootTest
@RunWith(SpringRunner.class)
public class GeneratorJwtToken {

    @Autowired
    private JwtConfig jwtConfig;

    /**
eyJhbGciOiJSUzI1NiJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJ0ZXN0MDEiLCJleHAiOjE1NzQ0NTc4MjB9.roirVA7Jao-wERJ9wNoza4YiXVNTlaycqnhkreS7x8HCxhyyLLl1h4xgLv9fwpFM3BeCBrLkEuqRT3XruTPlc3lzg019U8bI1ing0-EXDtcr4gWme6uM2jL6JDTT8nnzm2N4s2TwdOFpsQek7Yv3EKvbktsujH1KmzQ2CAT3YAM
     * @throws Exception
     */
    @Test
    public void genRoot() throws Exception {
        PrivateKey privateKey=RsaUtils.getPrivateKey(jwtConfig.getPriKeyPath());
        UserInfo userInfo=new UserInfo(1,"test01");
        System.out.println(JwtUtils.generateToken(userInfo,privateKey,jwtConfig.getExpireMinutes()));
    }

    /**
eyJhbGciOiJSUzI1NiJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJ0ZXN0MDIiLCJleHAiOjE1NzQ0NTc4NTJ9.r4z5t7xZhQKZvlhmiUa-KXXSEcYZIODaAjI6VINGCE1AqBNrp9bVE5M7AVMkmvVKu7fjkV_nbLeCEOkhYq2VMR1qiy6J46wZs4m1jYEi7by1YWHP-QZnvAe1uIe-vI1a9oD-0BJpt3FrKIdjyqQr4mtv7WyOhF9t2VKz-mriQZc
     * @throws Exception
     */
    @Test
    public void genBoss() throws Exception {
        PrivateKey privateKey=RsaUtils.getPrivateKey(jwtConfig.getPriKeyPath());
        UserInfo userInfo=new UserInfo(2,"test02");
        System.out.println(JwtUtils.generateToken(userInfo,privateKey,jwtConfig.getExpireMinutes()));
    }

    /**
eyJhbGciOiJSUzI1NiJ9.eyJpZCI6MywidXNlcm5hbWUiOiJ0ZXN0MDMiLCJleHAiOjE1NzQ0NTc4ODh9.T-O8FQwwuVYq4aEVHzVMkB3EID2syOYS4s2FiqvzPIVS-q3WEyvW_HhHqwaSSUget2HxMyJ3Eq9Zu2qh6ueT9Ah2zjsNU2Lp0KspLsUZDWkuSY8b0TKN69IFzd1Q5NJOlhCO-dFaPwCv8aO0HiClzJIev55gpqpcKLFn4X4ew64
     * @throws Exception
     */
    @Test
    public void genManager() throws Exception {
        PrivateKey privateKey=RsaUtils.getPrivateKey(jwtConfig.getPriKeyPath());
        UserInfo userInfo=new UserInfo(3,"test03");
        System.out.println(JwtUtils.generateToken(userInfo,privateKey,jwtConfig.getExpireMinutes()));
    }

    /**
eyJhbGciOiJSUzI1NiJ9.eyJpZCI6NCwidXNlcm5hbWUiOiJ0ZXN0MDQiLCJleHAiOjE1NzQ0NTc5MTh9.moyjAbeKeCl6Arug2ya5k0-quHmxFDnmpAcf6djmZL9HL6_mXScp17YnnQ8zEWj9Om2_XY2ZUSAViVHPhl3knkYWaUJMwXEWA2PnBSEpZaV2dvlD2CMw6FPhxpo2i9EA71Kq-jYEqV3w_eoJly4tMMRtTzxY1_1DXnZBPr128Ww
     * @throws Exception
     */
    @Test
    public void genStaff() throws Exception {
        PrivateKey privateKey=RsaUtils.getPrivateKey(jwtConfig.getPriKeyPath());
        UserInfo userInfo=new UserInfo(4,"test04");
        System.out.println(JwtUtils.generateToken(userInfo,privateKey,jwtConfig.getExpireMinutes()));
    }
}
