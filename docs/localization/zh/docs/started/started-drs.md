# 环境准备
1. docker环境
2. 安装docker。
3. 安装docker-compose。
4. 拉取镜像文件:`$ sudo docker pull stacs-native-dapp/drs-boot`
5. 创建docker-compose.yml文件，并执行：`sudo docker-compose up –d`


# 配置

## 可配置参数
```properties
server.port=8080
# DRS 默认 profile=h2
spring.profiles.active=h2
# DRS 所在父路径，支持相对、绝对路径
drs.dir=drs 
# DRS 下载目录
drs.download-path=${ds.dir}/download
# DRS 配置文件目录
drs.config-path=${drs.dir}/config

# DRS 域配置
drs.domain.baseUrl=http://localhost:7070/
drs.domain.chainPubKey=04711e86d74444c10d7506dbcfcb861ae1280a384ba617802a02d81ea99ca70f015d67e4efc3630331143f53fe18dca733d3802552225b17289e0ce13cac648823
drs.domain.merchantPriKey=78637c920bc993f50c038fa146b917fc625793e59f677cdbfbbe1c46b7fd407a
drs.domain.aesKey=gsp-sto-12sd9ie4
# 商户 id
drs.domain.merchantId=default
# CRS 回调请求地址
drs.domain.callbackUrl=http://localhost:8080/drs/callback
```

### h2 数据源配置

```properties
# H2
# h2 数据库名称，需要配置为绝对路径
h2.database.name=./drs
spring.datasource.druid.url=jdbc:h2:${h2.database.name};DB_CLOSE_DELAY=-1
spring.datasource.DruidDataSourceFactory.driver-class-name=org.h2.Driver
spring.datasource.schema=classpath:h2/schema.sql
# 启动控制台
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console
spring.datasource.druid.username=root
spring.datasource.druid.password=root
```

### MySQL 数据源配置

```properties
# MySQL
spring.datasource.DruidDataSourceFactory.driver-class-name=com.mysql.jdbc.Driver
# 配置数据库连接，默认数据库为 drs
spring.datasource.druid.url=jdbc:mysql://localhost:3306/drs?useUnicode=true&characterEncoding=UTF8&allowMultiQueries=true&useAffectedRows=true
spring.datasource.druid.username=root
spring.datasource.druid.password=root
```

