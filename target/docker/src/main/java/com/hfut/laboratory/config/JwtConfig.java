package com.hfut.laboratory.config;

import com.hfut.laboratory.util.jwt.JwtUtils;
import com.hfut.laboratory.util.jwt.RsaUtils;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.security.PrivateKey;
import java.security.PublicKey;

/**
 * 读取配置文件的jwt信息
 */
@Configuration
@ConfigurationProperties(prefix = "jwt")
@Data
public class JwtConfig {

    private String cookieName;
    private String pubKeyPath;
    private String priKeyPath;
    private String secret;
    private Integer adminExpireMinutes;
    private Integer expireMinutes;

//    @Bean
//    public PublicKey publicKey() throws Exception {
//        return RsaUtils.getPublicKey(pubKeyPath);
//    }
//
//    @Bean
//    public PrivateKey privateKey() throws Exception {
//        return RsaUtils.getPrivateKey(priKeyPath);
//    }


}
