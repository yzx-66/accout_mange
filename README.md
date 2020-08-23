# 发型屋的门店系统

#### 介绍
给外面发型屋做的门店系统（管理平台）
* 主要功能：客户管理、权限角色管理、项目管理、优惠卡管理、消费记录管理、营业记录管理、营业额管理、薪水管理、用户管理等
* 还有一级功能基础上的的二级菜单和功能

**部分一级菜单截图：**
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/1.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/2.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/3.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/4_.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/4_5.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/7.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/5.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/6.png "屏幕截图.png")



#### 软件架构
以SpringBoot为基础的三层架构
使用的技术栈：
* 后端：SpringBoot + MybatisPlus + Shiro + Jwt + Swagger2 + Redis
* 前端：JQuery + Echarts + bootStrap + Vue 
* 自动化部署：Jenkis + Docker + gitee 

#### 安装教程
启动后端
* 运行数据库脚本，修改application.properties中的 spring.datasource.username 和 spring.datasource.password
* 运行单元测试生成jwt的密钥文件：src/main/test/java/com/hfut/laboratory/jwt/GenerorRsa
    * 生成路径在配置文件中 已配置成 C:\\tmp\\accout\\rsa\\，其余jwt相关配置均以 jwt.* 开头
* 运行application.java 启动后端服务

启动前端
* 前端使用nginx作为静态资源服务器，修改前端文件夹路径（前端文件为：web/accout）
![输入图片说明](https://images.gitee.com/uploads/images/2020/0730/120229_8a08cec0_5494607.png "屏幕截图.png")


访问：http://localhost/login.html
* 管理员：admin admin
* 老板：boss admin
* 员工：staff admin

##### 代码说明
代码在关键处都有注释，每个类也都有注释，并且每个controller作用及入参都有说明。
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/code.png "屏幕截图.png")


#### 参考
上面后端用到的技术可以参考我写过的博客
* SpringBoot
  * SpringBoot整合与使用（一）：https://blog.csdn.net/weixin_43934607/article/details/100055620
  * SpringBoot整合与使用（二）：https://blog.csdn.net/weixin_43934607/article/details/100111858
  * SpringBoot整合与使用（三）：https://blog.csdn.net/weixin_43934607/article/details/100115270
* Redis作为springBoot二级缓存：https://blog.csdn.net/weixin_43934607/article/details/100141311
* Mybatis-plus及逆向工程：https://blog.csdn.net/weixin_43934607/article/details/102540483
* Shiro + Jwt
  * Shiro（一）：https://blog.csdn.net/weixin_43934607/article/details/100141720
  * Shiro（二）：https://blog.csdn.net/weixin_43934607/article/details/100141754
  * SpringBoot整合Jwt：https://blog.csdn.net/weixin_43934607/article/details/101356581
  * Shiro+JWT整合（一）：https://blog.csdn.net/weixin_43934607/article/details/103060127
  * Shiro+JWT整合（二）：https://blog.csdn.net/weixin_43934607/article/details/103060208
* 跨域问题（Cors方式）：https://blog.csdn.net/weixin_43934607/article/details/102299264
* swagger2生成离线 pdf、html 接口文档：https://blog.csdn.net/weixin_43934607/article/details/103060022
* Redis反序列化或前后端传参时关于Date相关类的序列化和反序列化：https://blog.csdn.net/weixin_43934607/article/details/103154703
* Jenkins自动化部署项目（SpringBoot到Docker）：https://blog.csdn.net/weixin_43934607/article/details/104217800）

说明
* 已经关闭swaggerUI 因为会影响打包 如果还想用其生成api文档 可以参考我的blog 然后取消注释
* 已经关闭redis缓存 如果还想用其做springboot cache 可以参考我的blog 然后取消注释


