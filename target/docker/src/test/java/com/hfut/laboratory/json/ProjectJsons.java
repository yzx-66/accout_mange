package com.hfut.laboratory.json;

import com.hfut.laboratory.pojo.Project;
import com.hfut.laboratory.util.JsonUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class ProjectJsons {

    /**
     * 添加或者修改project时传递的对象
     */
    @Test
    public void serializeProject() {
        Project project=Project.builder()
                .introduction("这是介绍")
                .name("收费项目1")
                .percentage(0.1f)
                .price(20.0f)
                .build();

        System.out.println(JsonUtils.serialize(project));
    }
}
