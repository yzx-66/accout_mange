package com.hfut.laboratory.vo.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 修改密码时传递的对象
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PasswordVo {

    private String oldPassword;
    private String newPassword;
}
