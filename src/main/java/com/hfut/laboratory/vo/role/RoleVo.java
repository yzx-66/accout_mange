package com.hfut.laboratory.vo.role;

import com.hfut.laboratory.pojo.Permission;
import com.hfut.laboratory.pojo.Role;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * 角色的详情
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class RoleVo extends Role {

    List<Permission> permissionList;

    public RoleVo(Role role,List<Permission> permissionList){
        this.permissionList=permissionList;
        this.setId(role.getId());
        this.setName(role.getName());
        this.setIntroduction(role.getIntroduction());
    }
}
