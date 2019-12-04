package com.hfut.laboratory.vo.user;

import com.hfut.laboratory.pojo.Role;
import com.hfut.laboratory.pojo.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 包含用户的角色 从视图层接收和返回都用
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserVo extends User {

    private Integer roleId;

    public UserVo(User user,Integer roleId){
        this.roleId=roleId;
        this.setId(user.getId());
        this.setName(user.getName());
        this.setEntryTime(user.getEntryTime());
        this.setPassword(user.getPassword());
        this.setPhone(user.getPhone());
        this.setSex(user.getSex());
        this.setStatus(user.getStatus());
        this.setBaseSalary(user.getBaseSalary());
    }
}
