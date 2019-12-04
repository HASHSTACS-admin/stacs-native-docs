# 下载工具

下载路径： stacs-native-deploy-generator

# 生成公私钥及地址：
```
java -jar stacs-native-deploy-generator*.jar
```

# 私钥生成地址及公钥：
```
java -jar stacs-native-deploy-generator*.jar ${privateKey}
```
- `privateKey`: 私钥

# 生成配置文件：

```
java -jar stacs-native-deploy-generator*.jar ${define.yml} ${output-path}
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