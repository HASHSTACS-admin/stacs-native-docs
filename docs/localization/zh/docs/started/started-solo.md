# 概述
stacs-native单节点模式是

# 环境准备
+ docker环境

# docker镜像
docker hub上solo镜像地址：

```shell
stacs-native/solo: latest
```

# 启动

`docker  docker run -it stacs-native/solo:latest`

# 控制台


# 配置

单节点模式同样支持系统参数配置，

## 端口
- `7070`: 应用层端口，主要用于接收交易等
- `8080`: 协议层端口
- `2000`: CLI命令行工具端口

## 环境参数
- `DATA_PATH`: 数据存放位置，如区块数据等
- `CONFIG_LOCATION`: 配置文件路径，如果有其他配置信息需要修改，可直接该指定写入配置文件, 配置文件支持`properties`和 `yaml`格式
可配置参数如下：
```properties
stacs.native.prefix=STACS
stacs.native.nodeName=GSX-GROUP-RS-A
stacs.native.domainId=GSX-GROUP
stacs.native.bizPrivateKey=01a87194b8e5a3591896542d942f54393bce9c9b7413f8ab70515b950269fe56
stacs.native.consensusPrivateKey=1e69731447b94df7afbe49ec5ec3bc39afb14fc40cf9ae385c8175eebcd57b5d
```



## JVM参数
- `JAVA_OPTS`: 通过该参数，可以指定JVM允许参数




