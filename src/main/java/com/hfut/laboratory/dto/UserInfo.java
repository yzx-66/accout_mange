package com.hfut.laboratory.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * jwt的Token中包含的对象
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserInfo {

    private Integer id;

    private String username;
}
