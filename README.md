# 门店系统（外包）

#### 介绍
XX造型的门店系统

**主干需求**
* 可以计算员工工资
* 可以让客户办卡和充余额
* 可以统计当天流水

**功能实现**
* 主干功能：客户管理、薪水管理、项目管理、优惠卡管理、消费记录管理、工作记录管理、营业额管理、权限角色管理、用户管理等
* 附加功能：完整权限管理（角色细分、功能权限细分）、冻结功能（客户、员工、优惠卡、项目等）、自动生成功能（员工工资、计算营业额、删除客户无用卡等）、统计功能（员工贡献、项目与卡的受欢迎度等）、剩下附加功能说明省略。

**一级菜单截图：**
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/1.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/2.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/3.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/4.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/5.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/6.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/7.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/8.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/9.png "屏幕截图.png")
![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/10.png "屏幕截图.png")



#### 软件架构
以SpringBoot为基础的三层架构
使用的技术栈：
* 后端：SpringBoot + MybatisPlus + Shiro + Jwt + Swagger2 + Redis
* 前端：JQuery + Echarts + BootStrap + Vue 
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

##### 说明
表说明

![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/table_.png "屏幕截图.png")

代码说明（内部注释也较详细）

![输入图片说明](https://github.com/yzx66-net/accout_mange/blob/master/img/code.png "屏幕截图.png")


#### 参考
上面后端用到的技术如果有不了解的可以参考我写过的博客
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

#### 项目补充说明
* 项目周期主要为2019.11月~12月初，之后由于有别的事情所以搁置了。原先预计2020年后3月份拿这个一期项目去给店老板展示，然后再进一步改进优化，但是由于疫情原因，一直拖到了2020年8月份，所以这个项目也就搁置了，可能也就没有二期了。
* 放到github的目的也是这个项目完成度较高，通用性较强，并且技术难度不大，所以如果不想造轮子，可以把这个项目拿去再改改。在近几次提交中已经修复了去年遗留的几个明显bug。目前的情况是代码运行没有明显bug，主要问题可能还是前端做的不够好，不过前端用的技术简单，所以也很好理解，改动也挺简单。
* 如果真的有谁用到了这套代码，欢迎随时在issue向我提问。
