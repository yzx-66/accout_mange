package com.hfut.laboratory.jwt;

import com.hfut.laboratory.config.JwtConfig;
import com.hfut.laboratory.util.jwt.RsaUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.File;

@SpringBootTest
@RunWith(SpringRunner.class)
public class GenerorRsa {

    @Autowired
    private JwtConfig jwtConfig;

    @Test
    public void genRsa() throws Exception {
        File priRsa=new File(jwtConfig.getPriKeyPath());
        File pubRsa=new File(jwtConfig.getPubKeyPath());

        if(!priRsa.getParentFile().exists()){
            priRsa.getParentFile().mkdirs();
        }

        if(!pubRsa.getParentFile().exists()){
            pubRsa.getParentFile().mkdirs();
        }

        RsaUtils.generateKey(jwtConfig.getPubKeyPath(),jwtConfig.getPriKeyPath(),jwtConfig.getSecret());
    }

}
