package com.hfut.laboratory;

import com.hfut.laboratory.controller.CouponCardController;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;


@SpringBootApplication
@EnableScheduling
public class AccoutMangeApplication {

    public static void main(String[] args) {
        SpringApplication.run(AccoutMangeApplication.class);
    }
}
