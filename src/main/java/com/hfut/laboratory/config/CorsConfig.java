package com.hfut.laboratory.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

/**
 * 跨域支持
 */
@Configuration
public class CorsConfig {

    @Bean
    public CorsFilter corsFilter(){
        CorsConfiguration corsConfiguration=new CorsConfiguration();
        //允许携带请求头
        corsConfiguration.addAllowedHeader("*");

        //允许所有访问方法 Get、Post...
        corsConfiguration.addAllowedMethod("*");

        //TODO http://127.0.0.1:80
        corsConfiguration.addAllowedOrigin("http://localhost");
        corsConfiguration.addAllowedOrigin("http://106.14.125.136");
        //corsConfiguration.addAllowedOrigin("*");

        //允许携带cookie
        corsConfiguration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource urlBasedCorsConfigurationSource=new UrlBasedCorsConfigurationSource();
        urlBasedCorsConfigurationSource.registerCorsConfiguration("/**",corsConfiguration);

        return new CorsFilter(urlBasedCorsConfigurationSource);
    }
}

