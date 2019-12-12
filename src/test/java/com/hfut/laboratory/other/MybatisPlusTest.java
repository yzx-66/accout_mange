package com.hfut.laboratory.other;

import com.hfut.laboratory.pojo.User;
import com.hfut.laboratory.service.UserService;
import com.hfut.laboratory.util.QueryWapperUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class MybatisPlusTest {

    @Autowired
    private UserService userService;

    @Test
    public void testUpdate(){
        User user=new User();
        user.setId(5);
        user.setName("test000");
        //修改结果>=1 返回ture
        System.out.println(userService.update(user, QueryWapperUtils.getInWapper("name","test000")));
        //删除结果>=0 返回ture
        System.out.println(userService.remove(QueryWapperUtils.getInWapper("name","test000")));
    }

    @Test
    public void testList(){
        System.out.println(userService.list(null));
    }

    @Test
    public void testQueryWapperUtils(){
        User user=new User();
        user.setName("test01");
        userService.update(user, QueryWapperUtils.getInWapper("name","test01"));
    }
}
