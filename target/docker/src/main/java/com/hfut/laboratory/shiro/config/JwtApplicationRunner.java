package com.hfut.laboratory.shiro.config;

import com.hfut.laboratory.config.JwtConfig;
import com.hfut.laboratory.util.jwt.RsaUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import java.io.File;

@Component
public class JwtApplicationRunner implements ApplicationRunner {

    @Autowired
    private JwtConfig jwtConfig;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        String priKeyPath = jwtConfig.getPriKeyPath();
        String pubKeyPath = jwtConfig.getPubKeyPath();

        String priKeyDirpath = StringUtils.substring(priKeyPath,0,StringUtils.lastIndexOf(priKeyPath,"\\"));
        String pubKeyDirpath = StringUtils.substring(pubKeyPath,0,StringUtils.lastIndexOf(priKeyPath,"\\"));

        File priDir=new File(priKeyDirpath);
        if(!priDir.exists()){
            priDir.mkdirs();
        }

        File pubDir=new File(pubKeyDirpath);
        if(!pubDir.exists()){
            priDir.mkdirs();
        }

        RsaUtils.generateKey(pubKeyPath,priKeyPath, jwtConfig.getSecret());
    }
}
