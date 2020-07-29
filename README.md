# 美发店管理平台全套代码（前后端含运行教程）

#### 介绍
给外面美发店做的工资系统后台
主要功能：会员卡管理、客户管理、权限角色管理、项目管理、消费记录管理、营业记录管理、营业额管理、薪水管理、员工管理、用户管理等

#### 软件架构
以SpringBoot为基础的三层架构
使用的技术栈：
* 后端：SpringBoot + MybatisPlus + Shiro + Jwt + Swagger2 + Redis
* 前端：JQuery + Echarts + bootStrap + vue 
* 自动化部署：Jenkis + Docker + gitee （可以参考我的blog：https://blog.csdn.net/weixin_43934607/article/details/104217800）

#### 安装教程
启动后端
* 运行数据库脚本，修改application.properties中的 spring.datasource.username 和 spring.datasource.password
* 运行单元测试生成jwt的密钥文件：com.hfut.laboratory.jwt.GenerorRsa（生成路径在配置文件中 已配置成 C:\\tmp\\accout\\rsa\\）
* 运行application.java 启动后端服务

启动前端
* 前端使用nginx作为静态资源服务器，修改前端文件夹路径
![输入图片说明](https://images.gitee.com/uploads/images/2020/0728/192329_45a28292_5494607.png "屏幕截图.png")


访问：http://localhost/login.html
* 管理员：admin admin
* 老板：boss admin
* 员工：staff admin

#### 使用说明

1.已经关闭swaggerUI 因为会影响打包 如果想开启参考我的blog（https://blog.csdn.net/weixin_43934607/article/details/103060022）
2.已经关闭redis 如果还想用其做springboot cache 请取消注释


