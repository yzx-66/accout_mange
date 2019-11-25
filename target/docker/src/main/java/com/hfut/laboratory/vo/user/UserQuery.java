package com.hfut.laboratory.vo.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 登陆验证时传递的对象
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserQuery {

    private String name;
    private String pwd;
}
