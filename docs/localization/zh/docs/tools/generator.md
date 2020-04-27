# **下载工具**

下载路径：

- 对应区块链版本v4.2.0 [stacs-native-deploy-generator-v4.2.0](hhttp://maven.primeledger.cn:8081/repository/maven-snapshots/com/hashstacs/stacs-native-deploy-generator/4.2-SNAPSHOT/stacs-native-deploy-generator-4.2-20200427.070148-1.jar)

## **生成公私钥及地址**
```shell
$ java -jar stacs-native-deploy-generator*.jar
```

### **输出示例**

```shell
Generated ecc keys: = = = = =
publicKey：  04c1a2f5b7975c069e9d38d6cf2cece005d631fc4af839d3a66e3938508d8bbdc852311ea2be4c0bd131f6979aba50f02ad83c73a388116ce6687aa849d0c58283
privateKey： 901ab43101bf2f2de6202870b10f56c266526e968ba330598bfb8e4cdfed6166
address:     766fa5e5b8cb1ce447e22888d53ef6ae20f5b3d9
```

## **私钥生成地址及公钥**

```shell
$ java -jar stacs-native-deploy-generator*.jar ${privateKey}
```
- `privateKey`: 私钥

### **输出示例**

```shell
publicKey：  043d96f05bcc8743139e00a56e3cd985a4f41306a199036647a0ae3017e1e1333dd2ee97a77e64768a74df955d0f983fe86a89aa21ff50b28eb9b744ca3a8ed679
privateKey： 78637c920bc993f50c038fa146b917fc625793e59f677cdbfbbe1c46b7fd407a
address:     54bd202186dd2de178ea220a875136a9dea736c
```

## **生成配置文件**

```shell
$ java -jar stacs-native-deploy-generator*.jar ${define.yml} ${output-path}
```
- `oupt-path`: 配置输出位置
- `define.yml`: 系统定义文件，详细定义说明如下：

```yaml
#数据存放路径，用于存放合约数据或区块链数据
path: /data/home/admin/stacs.native/data/
#domain定义
domains:
  # domain id 也即domain名
  - name: GSX-GROUP
    #允许的最大节点数
    maxNodeSize: 3
    #是否配置eureka，如果domain对外接入，须配置eureka、zuul，并通过zuul访问
    eurekaEnable: true
    #eureka配置
    eurekas:
      - host: registry-a
      - host: registry-b
    #zuul定义
    zuulDefine:
      zuul:
        host: zuul
      #DRS接入配置
      merchants:
        #DRS ID
        - merchatId: DRS
          host: drs-boot
          drsPath: /data/home/admin/stacs.drs/data
    # domain 节点配置
    nodes:
      # 节点host
      - host: native-a
        # 节点名称，不可有空格
        name: GSX-GROUP-RS-A
        # 是否注册为RS
        rs: true
      - host: native-b
        name: GSX-GROUP-RS-B
        rs: true
  - name: JNUO
    maxNodeSize: 3
    eurekaEnable: false
    nodes:
      - host: native-c
        name: Jnuo-Slave
        rs: false
  - name: GSX
    maxNodeSize: 3
    eurekaEnable: false
    nodes:
      - host: native-d
        name: GSX-Slave
        rs: false

```

### **结果示例**

#### **创世块**

```yaml
!!com.hashstacs.deploy.generator.genius.GeniusBlockConfig
domains:
- maxNodeSize: 3
  name: GSX-GROUP
  nodes:
  - {bizPubKey: 04ebd72a8bf492f7e0030cc937575b5be1a858971e3474fbea958453a84325dc4ce70f5a6bafc3c95129fe2577098ed0ee74ad61a96c4db6aa79e9d7cb05ac9ffd,
    consensusPubKey: 04bd919cb71a38229457118205d1eb0f90a65f9c9fc50a7d9df83a7e326b704f2d8e8a942e31b6ace4b0b6d33cdbefb5b9ddbd2acfd5ba4f910dba40ce0d5d26f8,
    name: GSX-GROUP-RS-A}
  - {bizPubKey: 04bc27f8182037283a30e17c85db0e7d708dd29f655740546e1e0123f9b32df4922ac52b5d3e44806750e334c04375313d14ab3a6b3b4e24e2c0c712db24d48513,
    consensusPubKey: 04d88047383455808ba841a850aa55598db51f0de3d64478c9db5a0209e1f56ed2828e93e5001a5f4d43a3b84a82f41941b63899e07863c456ed66fc36af9e871e,
    name: GSX-GROUP-RS-B}
  rsList: [GSX-GROUP-RS-A, GSX-GROUP-RS-B]
- maxNodeSize: 3
  name: JNUO
  nodes:
  - {bizPubKey: 04929589da84b328d6bbd5aca588a2053b498dd2026d79b66a8a1b8e20c845bd4a6229f13d3fcd96a5c8a57e7d2a4e2a6a4f058173403ac87e1a0fb1c1d70ef195,
    consensusPubKey: 040700b5b41593bcad66c38895e9fb8ff37a1d9c4ae8ad72d0a64eff19a552242f713e46114bf26c8ac7a5c8b5c75b9bb56c3a9c75da4607635847eefb89572e8c,
    name: Jnuo-Slave}
  rsList: []
- maxNodeSize: 3
  name: GSX
  nodes:
  - {bizPubKey: 0449a16fec8f8c03aff5e56efb7163999ac55cf1cf11610350b71241936a08295c7e7eb55f2db19bbf609a902bfad7bfc13cf1fc75072021017f41a980474294fc,
    consensusPubKey: 048f40916e22aeba3054e12e3509c2045e0faeeef1580e34026af18819b412f3fd58907e8c28fe4508f02c335bbb433c33f7976e380126523d14184f4adca2fe5b,
    name: GSX-Slave}
  rsList: []
height: 1
previousHash: D40114568F302846D8CFEDD04C87F30ABC9DBFE568F89E44F97FD581BA97BBC4
startTime: '2019-12-10 02:47:03'

```

#### **ZUUL**

```properties
#common properties
#Tue Dec 10 14:47:05 CST 2019
eureka.client.serviceUrl.defaultZone=http://registry-a:8761/eureka/,http://registry-b:8761/eureka/
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.native/data/log
zuul.routes.v1.serverId=GSX-GROUP
zuul.routes.explorer.serviceId=GSX-GROUP
management.shell.ssh.port=2000
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
merchants.DRS.merchantId=DRS
merchants.DRS.merchantName=DRS
merchants.DRS.aesKey=stacs-19ae4c8e32
merchants.DRS.pubKey=04247010ca557da04d9c4046a3af9e36698956d0f5b343cde96da3629d4473d8d4c3e97f396bc8da909fd78a04ece851549f661aa6e13b37bb1e24cf4263d7e312
merchants.DRS.priKey=95c482164316fb9a9b35f9ab3df8296d5d8431c0deea4fc8c9b3f9dafe68475f
#zuul properties
#Tue Dec 10 14:47:05 CST 2019
server.port=7070

```



#### **注册中心**

- A 中心

```properties
#registry-a properties
#Tue Dec 10 14:47:05 CST 2019
server.port=8761
eureka.instance.hostname=registry-a
eureka.client.serviceUrl.defaultZone=http://registry-a:8761/eureka/,http://registry-b:8761/eureka/

```

- B 中心

```properties
#registry-b properties
#Tue Dec 10 14:47:05 CST 2019
server.port=8761
eureka.instance.hostname=registry-b
eureka.client.serviceUrl.defaultZone=http://registry-a:8761/eureka/,http://registry-b:8761/eureka/

```

#### **节点**

- 节点 A

```properties
#common properties
#Tue Dec 10 14:47:05 CST 2019
stacs.native.crypto.biz=ECC
stacs.native.newNode=false
stacs.native.crypto.consensus=ECC
stacs.native.path=/data/home/admin/stacs.native/data/
stacs.native.geniusPath=file:/data/home/admin/stacs.native/data/geniusBlock.yml
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.native/data/log
network.peers=native-a:9001,native-b:9001,native-c:9001,native-d:9001
sofajraft.initConfStr=native-a:8800,native-b:8800,native-c:8800,native-d:8800
#native-a properties
#Tue Dec 10 14:47:05 CST 2019
server.port=7070
stacs.native.prefix=STACS
stacs.native.nodeName=GSX-GROUP-RS-A
stacs.native.domainId=GSX-GROUP
stacs.native.rs=true
stacs.native.bizPrivateKey=83400bf49a60a6a7d38bf9f4b7a28f334801851d0d7ac4aa24b3d1dd81ec5250
stacs.native.consensusPrivateKey=b0110b203200ad718a4ffac721c275f8f0d7a3701dd0f8822bffe7ad89639b3c
eureka.client.enabled=true
eureka.client.serviceUrl.defaultZone=http://registry-a:8761/eureka/,http://registry-b:8761/eureka/
stacs.native.useMySQL=false
management.shell.ssh.port=2000
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
network.host=native-a
network.port=9001
sofajraft.serverIdStr=native-a:8800

```

- 节点 B

```properties
#common properties
#Tue Dec 10 14:47:05 CST 2019
stacs.native.crypto.biz=ECC
stacs.native.newNode=false
stacs.native.crypto.consensus=ECC
stacs.native.path=/data/home/admin/stacs.native/data/
stacs.native.geniusPath=file:/data/home/admin/stacs.native/data/geniusBlock.yml
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.native/data/log
network.peers=native-a:9001,native-b:9001,native-c:9001,native-d:9001
sofajraft.initConfStr=native-a:8800,native-b:8800,native-c:8800,native-d:8800
#native-b properties
#Tue Dec 10 14:47:05 CST 2019
server.port=7070
stacs.native.prefix=STACS
stacs.native.nodeName=GSX-GROUP-RS-B
stacs.native.domainId=GSX-GROUP
stacs.native.rs=true
stacs.native.bizPrivateKey=1894bc46f584055e6df9f3ba377fd7b930c04566dbbe53dd383ebf09f4577968
stacs.native.consensusPrivateKey=11ebce243b713eda48e63c4ff299d0af0e83cd8385d43d76eba4e5fb460a3bc3
eureka.client.enabled=true
eureka.client.serviceUrl.defaultZone=http://registry-a:8761/eureka/,http://registry-b:8761/eureka/
stacs.native.useMySQL=false
management.shell.ssh.port=2000
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
network.host=native-b
network.port=9001
sofajraft.serverIdStr=native-b:8800

```

- 节点 C

```properties
#common properties
#Tue Dec 10 14:47:05 CST 2019
stacs.native.crypto.biz=ECC
stacs.native.newNode=false
stacs.native.crypto.consensus=ECC
stacs.native.path=/data/home/admin/stacs.native/data/
stacs.native.geniusPath=file:/data/home/admin/stacs.native/data/geniusBlock.yml
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.native/data/log
network.peers=native-a:9001,native-b:9001,native-c:9001,native-d:9001
sofajraft.initConfStr=native-a:8800,native-b:8800,native-c:8800,native-d:8800
#native-c properties
#Tue Dec 10 14:47:05 CST 2019
server.port=7070
stacs.native.prefix=STACS
stacs.native.nodeName=Jnuo-Slave
stacs.native.domainId=JNUO
stacs.native.rs=false
stacs.native.bizPrivateKey=1d4c6d8dbd21e06d14d6ab1b71c5f0fb8f910c202f4f62ae9ff350c0cd733265
stacs.native.consensusPrivateKey=ded494261db48e2259664b63f696b41a13590035377bd987f24a05720d43d9b1
eureka.client.enabled=false
stacs.native.useMySQL=false
management.shell.ssh.port=2000
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
network.host=native-c
network.port=9001
sofajraft.serverIdStr=native-c:8800

```

- 节点 D

```properties
#common properties
#Tue Dec 10 14:47:05 CST 2019
stacs.native.crypto.biz=ECC
stacs.native.newNode=false
stacs.native.crypto.consensus=ECC
stacs.native.path=/data/home/admin/stacs.native/data/
stacs.native.geniusPath=file:/data/home/admin/stacs.native/data/geniusBlock.yml
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.native/data/log
network.peers=native-a:9001,native-b:9001,native-c:9001,native-d:9001
sofajraft.initConfStr=native-a:8800,native-b:8800,native-c:8800,native-d:8800
#native-d properties
#Tue Dec 10 14:47:05 CST 2019
server.port=7070
stacs.native.prefix=STACS
stacs.native.nodeName=GSX-Slave
stacs.native.domainId=GSX
stacs.native.rs=false
stacs.native.bizPrivateKey=33d3b711e0fc9c1a5547c7ce8a31146742947029e60c8cf86137a8f3d98538cc
stacs.native.consensusPrivateKey=4452583eda9d4a579855835cbdf072eb55eb9518f86f2d8dd920e0f9d77bcbcd
eureka.client.enabled=false
stacs.native.useMySQL=false
management.shell.ssh.port=2000
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
network.host=native-d
network.port=9001
sofajraft.serverIdStr=native-d:8800

```
