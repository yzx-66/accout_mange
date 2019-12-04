package com.hfut.laboratory.json;

import com.hfut.laboratory.pojo.Role;
import com.hfut.laboratory.util.JsonUtils;
import com.hfut.laboratory.vo.user.UserVo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;


@SpringBootTest
@RunWith(SpringRunner.class)
public class UserJsons {


    /**
     * 添加或者修改user时传递的对象（包含role对象）
     */
    @Test
    public void serializeUserVo() {
        UserVo userVo=new UserVo();
        userVo.setStatus(1);
        userVo.setSex(1);
        userVo.setPhone("13325456805");
        userVo.setName("yzx");
        userVo.setPassword("other");
        //userVo.setEntryTime(LocalDateTime.now());
        Role role=new Role();
        role.setId(1);

        System.out.println(JsonUtils.serialize(userVo));
    }


}
