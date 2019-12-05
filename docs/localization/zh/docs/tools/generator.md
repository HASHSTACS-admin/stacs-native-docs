# 下载工具

下载路径： stacs-native-deploy-generator

## 生成公私钥及地址
```shell
$ java -jar stacs-native-deploy-generator*.jar
```

### 输出示例

```shell
Generated ecc keys: = = = = =
publicKey：  04c1a2f5b7975c069e9d38d6cf2cece005d631fc4af839d3a66e3938508d8bbdc852311ea2be4c0bd131f6979aba50f02ad83c73a388116ce6687aa849d0c58283
privateKey： 901ab43101bf2f2de6202870b10f56c266526e968ba330598bfb8e4cdfed6166
address:     766fa5e5b8cb1ce447e22888d53ef6ae20f5b3d9
```

## 私钥生成地址及公钥

```shell
$ java -jar stacs-native-deploy-generator*.jar ${privateKey}
```
- `privateKey`: 私钥

### 输出示例

```shell
publicKey：  043d96f05bcc8743139e00a56e3cd985a4f41306a199036647a0ae3017e1e1333dd2ee97a77e64768a74df955d0f983fe86a89aa21ff50b28eb9b744ca3a8ed679
privateKey： 78637c920bc993f50c038fa146b917fc625793e59f677cdbfbbe1c46b7fd407a
address:     54bd202186dd2de178ea220a875136a9dea736c
```

## 生成配置文件

```shell
$ java -jar stacs-native-deploy-generator*.jar ${define.yml} ${output-path}
```
- `oupt-path`: 配置输出位置
- `define.yml`: 系统定义文件，详细定义说明如下：

```yaml
#初始高度定义
height: 1
#区块开始时间设置
startTime: "2019-08-01 00:00:00"
#创始块前一hash定义
priviousHash: "0123456789ABCDEFFEDCBA98765432100123456789ABCDEFFEDCBA9876543210"
#创始块文件路径，集群启动时需要创建创始块或自建
geniusPath: file:/data/home/admin/stacs.native/data/geniusBlock.yml
#集群定义
prefix: TRUST
#rocksdb存放路径，用于存放合约数据或区块链数据
rocksdbPath: /data/home/admin/stacs.native/data/rocksdb/
#合约存放路径，用于发币
contractPath: /data/home/admin/stacs.native/data/contracts/
#日志配置文件，默认即可
logConfig: classpath:logback-prod.xml
#日志存放路径
logPath: /data/home/admin/stacs.native/data/log/
#sofajraft协议层数据存放路径
sofaPath: /data/home/admin/stacs.native/data/sofajraft/
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
        port: 8761
      - host: registry-b
        port: 8761
    #是否配置zuul，在配置eureka时，须配置zuul，通过zuul接入系统
    zuulEnable: true
    #zuul定义
    zuulDefine:
      #zuul 日志配置文件，默认即可
      logConfig: classpath:logback-prod.xml
      #zuul 日志存放路径
      logPath: /data/home/admin/stacs.zuul/log/
      #shell登陆端口
      sshPort: 2001
      #shell登陆用户名
      sshUser: user
      #shell登陆密码
      sshPwd: pwd
      #商户定义，
      merchants:
        #商户id
        - merchatId: STO
          #商户名
          merchatName: STO
          #商户通信对称加密密钥，如果是STO平台，需要domain中定义的aesKey一致
          aesKey: gsp-sto-12sd9ie4
          #商户公钥，如果是STO平台，需要domain中定义的stoPublicKey一致
          pubKey: 043d96f05bcc8743139e00a56e3cd985a4f41306a199036647a0ae3017e1e1333dd2ee97a77e64768a74df955d0f983fe86a89aa21ff50b28eb9b744ca3a8ed679
      zuuls:
        - host: zuul
          port: 7070
        - host: zuul
          port: 7070
    # 平台私钥
    gspPrivateKey: 2b236839774975579cd28704438264cac795e25b71f722a1960828b762c6adf3
    # 与STO平台通信对称加密密钥，须与zuul中STO商户的aesKey一致
    aesKey: gsp-sto-12sd9ie4
    # STO平台公钥，须与zuul中STO商户的pubKey一致
    stoPublicKey: 043d96f05bcc8743139e00a56e3cd985a4f41306a199036647a0ae3017e1e1333dd2ee97a77e64768a74df955d0f983fe86a89aa21ff50b28eb9b744ca3a8ed679
    # domain 节点配置
    nodes:
      # 节点host
      - host: native-a
        # 节点对外端口
        port: 7070
        # 节点名称，不可有空格
        name: GSX-GROUP-RS-A
        # 是否注册为RS
        rs: true
        # 是否使用Mysql，如果节点是RS节点或是节点包括浏览器对外使用，必须使用mysql
        useMySQL: true
        #mysql url
        mysqlUrl: jdbc:mysql://a-gsp-mysql:3306/gsp?useUnicode=true&characterEncoding=UTF8&allowMultiQueries=true&useAffectedRows=true
        #mysql 用户名
        mysqlUsername: root
        #mysql 密码
        mysqlPassword: 123456
        #节点shell登陆端口
        sshPort: 2000
        #节点shell登陆用户名
        sshUser: user
        #节点shell登陆密码
        sshPwd: pwd
        #节点网络层端口，用于p2p
        netPort: 9001
        #节点sofajraft协议层端口
        softPort: 8800
      - host: native-b
        port: 7070
        name: GSX-GROUP-RS-B
        rs: true
        useMySQL: true
        mysqlUrl: jdbc:mysql://b-gsp-mysql:3306/gsp?useUnicode=true&characterEncoding=UTF8&allowMultiQueries=true&useAffectedRows=true
        mysqlUsername: root
        mysqlPassword: 123456
        sshPort: 2000
        sshUser: user
        sshPwd: pwd
        netPort: 9001
        softPort: 8800
  - name: JNUO
    maxNodeSize: 3
    eurekaEnable: false
    gspPrivateKey: N/A
    aesKey: N/A
    stoPublicKey: N/A
    nodes:
      - host: native-c
        port: 7070
        name: Jnuo-Slave
        rs: false
        useMySQL: false
        mysqlUrl: jdbc:mysql://localhost:3306/gsp?useUnicode=true&characterEncoding=UTF8&allowMultiQueries=true&useAffectedRows=true
        mysqlUsername: root
        mysqlPassword: 123456
        sshPort: 2000
        sshUser: user
        sshPwd: pwd
        netPort: 9001
        softPort: 8800
  - name: GSX
    maxNodeSize: 3
    eurekaEnable: false
    gspPrivateKey: N/A
    aesKey: N/A
    stoPublicKey: N/A
    nodes:
      - host: native-d
        port: 7070
        name: GSX-Slave
        rs: false
        useMySQL: false
        mysqlUrl: jdbc:mysql://localhost:3306/gsp?useUnicode=true&characterEncoding=UTF8&allowMultiQueries=true&useAffectedRows=true
        mysqlUsername: root
        mysqlPassword: 123456
        sshPort: 2000
        sshUser: user
        sshPwd: pwd
        netPort: 9001
        softPort: 8800
  - name: FORT-CAPITAL
    maxNodeSize: 3
    eurekaEnable: false
    gspPrivateKey: N/A
    aesKey: N/A
    stoPublicKey: N/A
    nodes:
      - host: native-e
        port: 7070
        name: Fort-Capital-Slave
        rs: false
        useMySQL: false
        mysqlUrl: jdbc:mysql://localhost:3306/gsp?useUnicode=true&characterEncoding=UTF8&allowMultiQueries=true&useAffectedRows=true
        mysqlUsername: root
        mysqlPassword: 123456
        sshPort: 2000
        sshUser: user
        sshPwd: pwd
        netPort: 9001
        softPort: 8800
```

### 结果示例

#### 创世块

```yaml
!!com.hashstacs.deploy.generator.genius.GeniusBlockConfig
domains:
- maxNodeSize: 3
  name: GSX-GROUP
  nodes:
  - {bizPubKey: 04f82c2b2099c56a7ad073539d79888ecedcf7a5f79c1f7410d6bb83245157fe09f3f3c14f08577708c5f85403443ee1cd461382b8dcd33065dbbf2f2be853fdd4,
    consensusPubKey: 04f2eb9fab323a934fb87d2dcfa8c4f4132bc37154985d1943358540a91f9bcd843538f3039f654cd449664e04531d108dd2872f4955156f66efdf943fb5fe0c32,
    name: GSX-GROUP-RS-A}
  - {bizPubKey: 04da25b0990a9cb72616691848db8a0d2ccc2003eb62d29a494220493cf8976f69a28decd2d967ee6f3e757d0186d2628b4f9eaf32413afe45b21fb4a992a8b8ec,
    consensusPubKey: 040e6c585add9a154ad8555ce01afabcec622912f905d864e7bca1918fb86f54eaa3419a1f1cdcf4afeede7ecd4eb382d2d1a379cd6cea857d7bfac763448ec2ba,
    name: GSX-GROUP-RS-B}
  rsList: [GSX-GROUP-RS-A, GSX-GROUP-RS-B]
- maxNodeSize: 3
  name: JNUO
  nodes:
  - {bizPubKey: 0473b3d3f085bda0471a8bee4f0314f843216408911924c05ccf898dbc1c54f66b6e54a221ed604a67e77c8ebcf120e0a2ac0050818c6b963eb8d65abd0d8c7304,
    consensusPubKey: 04e98cca9d7455559a4815ba10ef50aef91ad18b65b99f5f44407c053a15d2ae07b4b39391c3150775f071dc749111ce7a272ee9f535b40941f8cc1af77ba13c2b,
    name: Jnuo-Slave}
  rsList: []
- maxNodeSize: 3
  name: GSX
  nodes:
  - {bizPubKey: 04e30775fa04c6ccb6e074d6ef0c539db646136c60ac9f96297a2aba789ec458a38f7be904926c3d3ff25dbebede5348192b3304ca23995e30f04298ab28c588a4,
    consensusPubKey: 04b86cdd3e3f5755d88968a655c7174093c4d7d5c485b906ac2706eb4ff1628b4ff8201cabf341fd790d3d3d35b33eda68fac9ea8263bf3349cfbd3d826c6fc3db,
    name: GSX-Slave}
  rsList: []
- maxNodeSize: 3
  name: FORT-CAPITAL
  nodes:
  - {bizPubKey: 04448f6773ad6c5505b3cb4352fc326994af0ddee37b27757f0e129d066c1e387ec727a650c6935ae06b4bd834adab0fdd85547495a3e81f23f550d5f9990688f7,
    consensusPubKey: 0466333c29258b5848e502cc56d927a7a4ed3ad857038ba2c61fa6c6e310ccbda0392a46007d4c8ecc3c85cdf10aa4c48477ad44b3ab92a8f567e7b51462dcdaf0,
    name: Fort-Capital-Slave}
  rsList: []
height: 1
previousHash: 0123456789ABCDEFFEDCBA98765432100123456789ABCDEFFEDCBA9876543210
startTime: '2019-08-01 00:00:00'
```

#### zuul 

```properties
#common properties
#Wed Dec 04 17:13:22 CST 2019
eureka.client.serviceUrl.defaultZone=http://registry-a:8761/eureka/,http://registry-b:8761/eureka/
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.zuul/log/
zuul.routes.v1.serverId=GSX-GROUP
zuul.routes.explorer.serviceId=GSX-GROUP
management.shell.ssh.port=2001
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
merchants.STO.merchantId=STO
merchants.STO.merchantName=STO
merchants.STO.aesKey=gsp-sto-12sd9ie4
merchants.STO.pubKey=043d96f05bcc8743139e00a56e3cd985a4f41306a199036647a0ae3017e1e1333dd2ee97a77e64768a74df955d0f983fe86a89aa21ff50b28eb9b744ca3a8ed679
merchants.STO.priKey=2b236839774975579cd28704438264cac795e25b71f722a1960828b762c6adf3
#zuul properties
#Wed Dec 04 17:13:22 CST 2019
server.port=7070
```



#### 注册中心

##### A 中心

```properties
#registry-a properties
#Wed Dec 04 17:13:22 CST 2019
server.port=8761
eureka.instance.hostname=registry-a
eureka.client.serviceUrl.defaultZone=http://registry-a:8761/eureka/,http://registry-b:8761/eureka/
```

##### B 中心

```properties
#registry-b properties
#Wed Dec 04 17:13:22 CST 2019
server.port=8761
eureka.instance.hostname=registry-b
eureka.client.serviceUrl.defaultZone=http://registry-a:8761/eureka/,http://registry-b:8761/eureka/
```

#### 节点

##### 节点 A

```properties
#common properties
#Wed Dec 04 17:13:22 CST 2019
stacs.native.crypto.biz=ECC
stacs.native.crypto.consensus=ECC
stacs.native.geniusPath=file:/data/home/admin/stacs.native/data/geniusBlock.yml
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.native/data/log/
stacs.native.rocksdb.file.root=/data/home/admin/stacs.native/data/rocksdb/
gsp.contract.path=/data/home/admin/stacs.native/data/contracts/
sofajraft.dataPath=/data/home/admin/stacs.native/data/sofajraft/
network.peers=native-a:9001,native-b:9001,native-c:9001,native-d:9001,native-e:9001
sofajraft.initConfStr=native-a:8800,native-b:8800,native-c:8800,native-d:8800,native-e:8800
#native-a properties
#Wed Dec 04 17:13:22 CST 2019
server.port=7070
stacs.native.prefix=TRUST
stacs.native.nodeName=GSX-GROUP-RS-A
stacs.native.domainId=GSX-GROUP
stacs.native.rs=true
stacs.native.keys.bizPrivateKey=ad169c432d5eec7b0a39e5f591669a50f0c7c1ce4a9f0588e9f8710e7fffd899
stacs.native.keys.bizPublicKey=04f82c2b2099c56a7ad073539d79888ecedcf7a5f79c1f7410d6bb83245157fe09f3f3c14f08577708c5f85403443ee1cd461382b8dcd33065dbbf2f2be853fdd4
stacs.native.keys.consensusPrivateKey=05aa5d92b7684b9ce8b9b1434fac591b3ea04453b8282cbe39fd0eb261ac563d
stacs.native.keys.consensusPublicKey=04f2eb9fab323a934fb87d2dcfa8c4f4132bc37154985d1943358540a91f9bcd843538f3039f654cd449664e04531d108dd2872f4955156f66efdf943fb5fe0c32
gsp.privateKey=2b236839774975579cd28704438264cac795e25b71f722a1960828b762c6adf3
gsp.aesKey=gsp-sto-12sd9ie4
gsp.sto.publicKey=043d96f05bcc8743139e00a56e3cd985a4f41306a199036647a0ae3017e1e1333dd2ee97a77e64768a74df955d0f983fe86a89aa21ff50b28eb9b744ca3a8ed679
eureka.client.enabled=true
eureka.client.serviceUrl.defaultZone=http://registry-a:8761/eureka/,http://registry-b:8761/eureka/
stacs.native.useMySQL=true
spring.datasource.druid.username=root
spring.datasource.druid.password=123456
spring.datasource.druid.url=jdbc:mysql://a-gsp-mysql:3306/gsp?useUnicode=true&characterEncoding=UTF8&allowMultiQueries=true&useAffectedRows=true
management.shell.ssh.port=2000
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
network.host=native-a
network.port=9001
sofajraft.serverIdStr=native-a:8800
```

##### 节点 B

```properties
#common properties
#Wed Dec 04 17:13:22 CST 2019
stacs.native.crypto.biz=ECC
stacs.native.crypto.consensus=ECC
stacs.native.geniusPath=file:/data/home/admin/stacs.native/data/geniusBlock.yml
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.native/data/log/
stacs.native.rocksdb.file.root=/data/home/admin/stacs.native/data/rocksdb/
gsp.contract.path=/data/home/admin/stacs.native/data/contracts/
sofajraft.dataPath=/data/home/admin/stacs.native/data/sofajraft/
network.peers=native-a:9001,native-b:9001,native-c:9001,native-d:9001,native-e:9001
sofajraft.initConfStr=native-a:8800,native-b:8800,native-c:8800,native-d:8800,native-e:8800
#native-b properties
#Wed Dec 04 17:13:22 CST 2019
server.port=7070
stacs.native.prefix=TRUST
stacs.native.nodeName=GSX-GROUP-RS-B
stacs.native.domainId=GSX-GROUP
stacs.native.rs=true
stacs.native.keys.bizPrivateKey=f192e9d133ac32db8c8010d9f1fa46913aad2a6f2b64929e154d81f502340d19
stacs.native.keys.bizPublicKey=04da25b0990a9cb72616691848db8a0d2ccc2003eb62d29a494220493cf8976f69a28decd2d967ee6f3e757d0186d2628b4f9eaf32413afe45b21fb4a992a8b8ec
stacs.native.keys.consensusPrivateKey=ce91aa877f98bb00d48234f3e5971f48ec328568502c393d64dbeecb5a800387
stacs.native.keys.consensusPublicKey=040e6c585add9a154ad8555ce01afabcec622912f905d864e7bca1918fb86f54eaa3419a1f1cdcf4afeede7ecd4eb382d2d1a379cd6cea857d7bfac763448ec2ba
gsp.privateKey=2b236839774975579cd28704438264cac795e25b71f722a1960828b762c6adf3
gsp.aesKey=gsp-sto-12sd9ie4
gsp.sto.publicKey=043d96f05bcc8743139e00a56e3cd985a4f41306a199036647a0ae3017e1e1333dd2ee97a77e64768a74df955d0f983fe86a89aa21ff50b28eb9b744ca3a8ed679
eureka.client.enabled=true
eureka.client.serviceUrl.defaultZone=http://registry-a:8761/eureka/,http://registry-b:8761/eureka/
stacs.native.useMySQL=true
spring.datasource.druid.username=root
spring.datasource.druid.password=123456
spring.datasource.druid.url=jdbc:mysql://b-gsp-mysql:3306/gsp?useUnicode=true&characterEncoding=UTF8&allowMultiQueries=true&useAffectedRows=true
management.shell.ssh.port=2000
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
network.host=native-b
network.port=9001
sofajraft.serverIdStr=native-b:8800
```

##### 节点 C

```properties
#common properties
#Wed Dec 04 17:13:22 CST 2019
stacs.native.crypto.biz=ECC
stacs.native.crypto.consensus=ECC
stacs.native.geniusPath=file:/data/home/admin/stacs.native/data/geniusBlock.yml
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.native/data/log/
stacs.native.rocksdb.file.root=/data/home/admin/stacs.native/data/rocksdb/
gsp.contract.path=/data/home/admin/stacs.native/data/contracts/
sofajraft.dataPath=/data/home/admin/stacs.native/data/sofajraft/
network.peers=native-a:9001,native-b:9001,native-c:9001,native-d:9001,native-e:9001
sofajraft.initConfStr=native-a:8800,native-b:8800,native-c:8800,native-d:8800,native-e:8800
#native-c properties
#Wed Dec 04 17:13:22 CST 2019
server.port=7070
stacs.native.prefix=TRUST
stacs.native.nodeName=Jnuo-Slave
stacs.native.domainId=JNUO
stacs.native.rs=false
stacs.native.keys.bizPrivateKey=d59f65e543ceddeb3b4e009872ee9ed52ff8f5df1909616cd7cdc69a2547e372
stacs.native.keys.bizPublicKey=0473b3d3f085bda0471a8bee4f0314f843216408911924c05ccf898dbc1c54f66b6e54a221ed604a67e77c8ebcf120e0a2ac0050818c6b963eb8d65abd0d8c7304
stacs.native.keys.consensusPrivateKey=092dff5f6b6bfb6ab3c87d53331d1b51a0b704210a14d9be72459e2920f30270
stacs.native.keys.consensusPublicKey=04e98cca9d7455559a4815ba10ef50aef91ad18b65b99f5f44407c053a15d2ae07b4b39391c3150775f071dc749111ce7a272ee9f535b40941f8cc1af77ba13c2b
gsp.privateKey=N/A
gsp.aesKey=N/A
gsp.sto.publicKey=N/A
eureka.client.enabled=false
stacs.native.useMySQL=false
management.shell.ssh.port=2000
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
network.host=native-c
network.port=9001
sofajraft.serverIdStr=native-c:8800
```

##### 节点 D

```properties
#common properties
#Wed Dec 04 17:13:22 CST 2019
stacs.native.crypto.biz=ECC
stacs.native.crypto.consensus=ECC
stacs.native.geniusPath=file:/data/home/admin/stacs.native/data/geniusBlock.yml
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.native/data/log/
stacs.native.rocksdb.file.root=/data/home/admin/stacs.native/data/rocksdb/
gsp.contract.path=/data/home/admin/stacs.native/data/contracts/
sofajraft.dataPath=/data/home/admin/stacs.native/data/sofajraft/
network.peers=native-a:9001,native-b:9001,native-c:9001,native-d:9001,native-e:9001
sofajraft.initConfStr=native-a:8800,native-b:8800,native-c:8800,native-d:8800,native-e:8800
#native-d properties
#Wed Dec 04 17:13:22 CST 2019
server.port=7070
stacs.native.prefix=TRUST
stacs.native.nodeName=GSX-Slave
stacs.native.domainId=GSX
stacs.native.rs=false
stacs.native.keys.bizPrivateKey=de1d911ff5da8f021dad8ddab55b05ee460795bed22e858018ad0a20b518eb84
stacs.native.keys.bizPublicKey=04e30775fa04c6ccb6e074d6ef0c539db646136c60ac9f96297a2aba789ec458a38f7be904926c3d3ff25dbebede5348192b3304ca23995e30f04298ab28c588a4
stacs.native.keys.consensusPrivateKey=861435af31e40e83cb2c919ff888b298a9d6c9d874d5784de847c8b4c9c926a0
stacs.native.keys.consensusPublicKey=04b86cdd3e3f5755d88968a655c7174093c4d7d5c485b906ac2706eb4ff1628b4ff8201cabf341fd790d3d3d35b33eda68fac9ea8263bf3349cfbd3d826c6fc3db
gsp.privateKey=N/A
gsp.aesKey=N/A
gsp.sto.publicKey=N/A
eureka.client.enabled=false
stacs.native.useMySQL=false
management.shell.ssh.port=2000
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
network.host=native-d
network.port=9001
sofajraft.serverIdStr=native-d:8800
```

##### 节点 E

```properties
#common properties
#Wed Dec 04 17:13:22 CST 2019
stacs.native.crypto.biz=ECC
stacs.native.crypto.consensus=ECC
stacs.native.geniusPath=file:/data/home/admin/stacs.native/data/geniusBlock.yml
logging.config=classpath:logback-prod.xml
logging.path=/data/home/admin/stacs.native/data/log/
stacs.native.rocksdb.file.root=/data/home/admin/stacs.native/data/rocksdb/
gsp.contract.path=/data/home/admin/stacs.native/data/contracts/
sofajraft.dataPath=/data/home/admin/stacs.native/data/sofajraft/
network.peers=native-a:9001,native-b:9001,native-c:9001,native-d:9001,native-e:9001
sofajraft.initConfStr=native-a:8800,native-b:8800,native-c:8800,native-d:8800,native-e:8800
#native-e properties
#Wed Dec 04 17:13:22 CST 2019
server.port=7070
stacs.native.prefix=TRUST
stacs.native.nodeName=Fort-Capital-Slave
stacs.native.domainId=FORT-CAPITAL
stacs.native.rs=false
stacs.native.keys.bizPrivateKey=e0f18020c1116759c8d1015f786b80d0b4493d5e4f55794a68bd41b4c1c7672a
stacs.native.keys.bizPublicKey=04448f6773ad6c5505b3cb4352fc326994af0ddee37b27757f0e129d066c1e387ec727a650c6935ae06b4bd834adab0fdd85547495a3e81f23f550d5f9990688f7
stacs.native.keys.consensusPrivateKey=8e7c239a5b1349e7d3f4f38e3632a3bfb0804a58d5fdce7abef48791ba3f5a1e
stacs.native.keys.consensusPublicKey=0466333c29258b5848e502cc56d927a7a4ed3ad857038ba2c61fa6c6e310ccbda0392a46007d4c8ecc3c85cdf10aa4c48477ad44b3ab92a8f567e7b51462dcdaf0
gsp.privateKey=N/A
gsp.aesKey=N/A
gsp.sto.publicKey=N/A
eureka.client.enabled=false
stacs.native.useMySQL=false
management.shell.ssh.port=2000
management.shell.auth.simple.user.name=user
management.shell.auth.simple.user.password=pwd
network.host=native-e
network.port=9001
sofajraft.serverIdStr=native-e:8800
```



