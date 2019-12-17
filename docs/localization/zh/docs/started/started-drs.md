# 环境准备
1. docker环境
2. 安装docker。
3. 安装docker-compose。
4. 拉取镜像文件:`$ sudo docker pull stacs-native-dapp/drs-boot`
5. 创建docker-compose.yml文件，并执行：`sudo docker-compose up –d`


# 配置

## 可配置参数
```properties
spring.jmx.default-domain=DRS
# spring.profiles.active=mysql 
spring.profiles.active=h2
server.port=8080

# dapp 相关配置
drs.dir=drs
drs.download-path=${drs.dir}/download
drs.config-path=${drs.dir}/config
drs.dapp-store-path=http://

# 区块链 domain 配置
drs.domain.baseUrl=http://localhost:7070/
drs.domain.chainPubKey=04711e86d74444c10d7506dbcfcb861ae1280a384ba617802a02d81ea99ca70f015d67e4efc3630331143f53fe18dca733d3802552225b17289e0ce13cac648823
drs.domain.merchantPriKey=78637c920bc993f50c038fa146b917fc625793e59f677cdbfbbe1c46b7fd407a
drs.domain.aesKey=gsp-sto-12sd9ie4
drs.domain.merchantId=default
drs.domain.callbackUrl=http://localhost:8080/drs/callback

# 数据源配置
spring.datasource.druid.initialSize= 1
spring.datasource.druid.maxActive= 20
spring.datasource.druid.maxWait= 5000
spring.datasource.druid.min-evictable-idle-time-millis= 300000
spring.datasource.druid.minIdle= 1
spring.datasource.druid.validation-query=select 1 from dual
spring.datasource.druid.time-between-eviction-runs-millis= 60000

# 以下配置不能修改
spring.datasource.type=com.alibaba.druid.pool.DruidDataSource
# mybatis 配置
mybatis.configLocation = classpath:mybatis-config.xml
mybatis.mapper-locations = classpath*:mybatis/**/*Mapper.xml
```

### h2 数据源配置

```properties
# H2
# h2 数据库名称，需要配置为绝对路径
h2.database.name=./drs
spring.datasource.druid.url=jdbc:h2:${h2.database.name};DB_CLOSE_DELAY=-1
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console
spring.datasource.druid.username=root
spring.datasource.druid.password=root

# 以下配置不能修改
spring.datasource.DruidDataSourceFactory.driver-class-name=org.h2.Driver
spring.datasource.schema=classpath:h2/schema.sql
```

### MySQL 数据源配置

```properties
# MySQL
spring.datasource.druid.url=jdbc:mysql://localhost:3306/drs?useUnicode=true&characterEncoding=UTF8&allowMultiQueries=true&useAffectedRows=true
spring.datasource.druid.username=root
spring.datasource.druid.password=root

# 以下配置不能修改
spring.datasource.DruidDataSourceFactory.driver-class-name=com.mysql.jdbc.Driver
```

