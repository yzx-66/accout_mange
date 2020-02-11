# From java image, version : 8
FROM java:8

##将maven构建好的jar添加到镜像中
ADD target/accout-mange-1.0-SNAPSHOT.jar accout-mange-1.0.jar
#自动化部署了 所以每次在部署Jenkins的机子上 在build是用Add 或者creat是-v
#ADD target/classes/rsa /tmp/rsa/
#ADD target/classes/salary.txt /tmp/salary.txt

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "accout-mange-1.0.jar"]

