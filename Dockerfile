# From java image, version : 8
FROM java:8

#挂载app目录
#VOLUME /app

##将maven构建好的jar添加到镜像中
ADD target/accout-mange-1.0-SNAPSHOT.jar accout-mange-1.0.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "accout-mange-1.0.jar"]