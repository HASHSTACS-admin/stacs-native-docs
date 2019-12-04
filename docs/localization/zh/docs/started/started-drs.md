# 环境准备
+ docker环境

# 下载
[下载DRS镜像包][1]
# 配置

## 可配置参数
+ 端口号：`server.port=8080`
+ drs文件根路径：`drp.dir=drs`
+ drs下载文件子目录：`drs.download-path=${drp.dir}/download`
+ drs配置文件子目录：`drs.config-path=${drp.dir}/config`
+ drs AppStore地址：`drs.dapp-store-path=`
+ 区块链接口地址：`drs.domain.baseUrl=`
+ 区块链接口层公钥：`drs.domain.chainPubKey=`
+ 区块链接口层私钥：`drs.domain.merchantPriKey=`
+ 区块链接口层加密串：`drs.domain.aesKey=`
+ 区块链接口层商户id：`drs.domain.merchantId=`
+ 区块链回调地址：`drs.domain.callbackUrl=`
+ 数据库数据源驱动：`spring.datasource.DruidDataSourceFactory.driver-class-name=`
+ 数据库链接地址：`spring.datasource.druid.url=`
+ Mysql数据库用户名：`spring.datasource.druid.username=`
+ Mysql数据库密码：`spring.datasource.druid.password=`

[1]: https://github.com/Aurorasic/stacs-native-dapp/tree/dev/dapp-sample



   