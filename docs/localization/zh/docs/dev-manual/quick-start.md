# **DApp 快速开始**

### 在本文档中，将创建一个 Spring Boot 的工程，引入 Stacs-DRS 基础依赖，演示如何快速上手Stacs-Dapp的开发。
[DApp示例工程](https://github.com/Aurorasic/stacs-native-dapp/tree/dev_1.0.0/dapp-sample)

### **环境准备**
  要开发Stacs-Dapp，需要先准备好基础环境，Stacs-Dapp依赖以下环境：JDK8以上、Spring-Boot2.1.9以上版本，需要采用Apache Maven 3.2.5 或者以上的版本来编译
### **创建工程**
 Stacs-Dapp 是直接构建在 Spring Boot 之上，因此可以使用 [Spring Boot 的工程生成工具](https://start.spring.io/) 来生成基本的项目结构。
### **添加Maven相关依赖**
在创建好一个 Spring Boot 的工程之后，接下来就需要引入 Stacs-DRS 的依赖，首先，需要将上文中生成的 Spring Boot 工程的 zip 包解压后，修改 maven 项目的配置文件 pom.xml，`dependencies`标签中添加如下坐标：

```xml
<dependency>
    <groupId>io.stacs.nav</groupId>
    <artifactId>dapp-maven-plugin</artifactId>
    <version>1.0.0-SNAPSHOT</version>
</dependency>
<dependency>
    <groupId>io.stacs.nav</groupId>
    <artifactId>drs-api</artifactId>
    <version>1.0.0-SNAPSHOT</version>
</dependency>
<dependency>
    <groupId>io.stacs.nav</groupId>
    <artifactId>dapp-core</artifactId>
    <version>1.0.0-SNAPSHOT</version>
</dependency>
<dependency>
    <groupId>com.alipay.sofa</groupId>
    <artifactId>web-ark-plugin</artifactId>
    <version>1.0.0</version>
</dependency>
<dependency>
    <groupId>com.alipay.sofa</groupId>
    <artifactId>sofa-ark-springboot-starter</artifactId>
    <version>1.0.0</version>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid-spring-boot-starter</artifactId>
    <version>1.1.10</version>
</dependency>
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <version>1.4.200</version>
</dependency>
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.43</version>
</dependency>
<dependency>
    <groupId>com.github.pagehelper</groupId>
    <artifactId>pagehelper-spring-boot-starter</artifactId>
    <version>1.2.13</version>
</dependency>
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.4.5</version>
</dependency>
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>1.3.1</version>
</dependency>
<dependency>
    <groupId>com.google.guava</groupId>
    <artifactId>guava</artifactId>
    <version>22.0</version>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.16.18</version>
</dependency>
<dependency>
    <groupId>org.aspectj</groupId>
    <artifactId>aspectjrt</artifactId>
    <version>1.9.4</version>
</dependency>
<dependency>
    <groupId>org.aspectj</groupId>
    <artifactId>aspectjweaver</artifactId>
    <version>1.9.4</version>
</dependency>
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-lang3</artifactId>
    <version>3.7</version>
</dependency>
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-collections4</artifactId>
    <version>4.1</version>
</dependency>
<dependency>
    <groupId>javax.validation</groupId>
    <artifactId>validation-api</artifactId>
    <version>2.0.1.Final</version>
</dependency>
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.9.9.3</version>
</dependency>

```

### **配置打包插件**
需要把默认的打包插件：
```xml
<build>
<plugins>
    <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
    </plugin>
</plugins>
</build>
```
替换为：
```xml
<build>
  <plugins>
    <plugin>
      <groupId>io.stacs.nav</groupId>
      <artifactId>dapp-maven-plugin</artifactId>
      <version>1.0.0-SNAPSHOT</version>
      <executions>
        <execution>
          <id>default-cli</id>
          <goals>
            <goal>package</goal>
          </goals>
        </execution>
      </executions>
      <configuration>
        <webContextPath>demo</webContextPath>
      </configuration>
    </plugin>
  </plugins>
</build>
```

>   插件会自动获取当前项目依赖的`drs-api`版本，默认情况下会打出两个包：
>
>   *   `*-dapp`：提交到DRS实际执行的包
>   *   `*-debug`：开发时使用，自带对应`drs-api`版本的运行环境，可以通过jar包直接运行
>   *   注：由于Dapp需要运行在DRS容器中才能访问到相关API，所以开发DAPP时需要开发者运行Debug包来调试/测试相关业务功能。
>   *   更多参数配置详见[1]

### **运行配置**

开发者可以通过运行`debug`时，传入`spring.config.location`参数，指定配置文件所在**目录**。

```shell
$ java -jar dapp-sample-1.0.0-SNAPSHOT-debug.jar \
	--spring.config.location={配置文件所在目录的路径}/
```

>   *   路径后面必须要包含`/`，才能被`spring`识别为目录，进而加载对应配置
>
>   *   `drs-boot`配置文件名称必须为：`boot.properties`
>   *   完整参数请见[2]



### **DApp 升级**

#### **升级文件目录说明**
- 需在项目resources目录下建立文件名为upgrade的目录，其下含有两个子目录：DDL、DML
- 需在DDL和DML目录下按照递增方式命名脚本文件，存放具体版本的升级脚本，如：1.sql,2.sql
- 目录结构：
``` 
   
   resources
   │
   └───upgrade
   │   │
   │   └───DDL
   │       │   1.sql
   │       │   2.sql
   │       │   ...
   │   
   └───----DML
           │   1.sql
           │   2.sql
           │   ...
```  
#### **AppStore配置说明**
- AppStore的Json配置中增加`versionCode`字段，int类型，从0递增
- 表示dapp的版本记录，该值在Dapp的upgrade文件下的DDL/DML下应该有与之对应的*.sql文件。


### **开发示例**

#### **DRS API 调用示例**

```java
@Service @Slf4j public class SampleService {

     @ArkInject ISubmitterService dappService;

    public RespData<?> authPermission(AuthPermissionVO vo) {
        log.info("dapp calling authPermission service ...");
        try {
            dappService.authPermission(vo);
          	log.info("authPermission service success");
            return success();
        } catch (DappException e) {
            log.error("authPermission service has error:", e);
            return fail(e);
        }
    }
}
```

>   *   注意：​DRS*交易提交(ISubmitterService)*接口返回值均为`void`，即为异步接口；需要等待*DRS*通过回调通知DApp交易执行完毕。
>   *   *DRS*提供的服务，在*DApp*中需要通过`@ArkInject`注解来获取
>   *   DRS 更多接口请参考[3]

#### **回调示例**

```
@Component @Slf4j public class SimpleCallbackHanlder implements ITxCallbackHandler {

    @Override public CallbackType[] supportType() {
        return new CallbackType[] {CallbackType.of(ApiConstants.TransactionApiEnum.AUTHORIZE_PERMISSION.getFunctionName())};
    }

    @Override public void handle(TransactionPO po) {
        log.info("handle callback msg from block chain,po:{}", po);
    }
}
```

>   *   回调处理器需要实现`ITxCallbackHandler`
>   *   需要根据请求端的业务类型配置回调类型，用以支持回调的处理。
        例如：示例中业务端的类型为授权业务，则回调实现中的回调类型为：`AUTHORIZE_PERMISSION`
        如此配置，当区块链回调数据过来时才会调用到该类的`handle`方法。

### **静态页面开发及配置**

>   *   前端页面可以基于VUE框架实现，在项目中src/main/目录下创建websource目录
>   *   前端页面源文件都放到该目录下。
>   *   增加maven打包插件：
```
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.8.0</version>
    <configuration>
        <source>8</source>
        <target>8</target>
    </configuration>
</plugin>
<plugin>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>exec-maven-plugin</artifactId>
    <version>1.4.0</version>
    <executions>
        <execution>
            <id>exec-cnpm-install</id>
            <goals>
                <goal>exec</goal>
            </goals>
            <phase>initialize</phase>
            <configuration>
                <executable>npm</executable>
                <arguments>
                    <argument>--registry=https://registry.npm.taobao.org</argument>
                    <argument>install</argument>
                </arguments>
            </configuration>
        </execution>
        <execution>
            <id>exec-cnpm-run-build</id>
            <goals>
                <goal>exec</goal>
            </goals>
            <phase>compile</phase>
            <configuration>
                <executable>npm</executable>
                <arguments>
                    <argument>run</argument>
                    <argument>build</argument>
                </arguments>
            </configuration>
        </execution>
    </executions>
    <configuration>
        <workingDirectory>./src/main/websource</workingDirectory>
    </configuration>
</plugin>
<plugin>
    <artifactId>maven-resources-plugin</artifactId>
    <version>2.7</version>
    <executions>
        <execution>
            <id>copy-resources</id>
            <phase>compile</phase>
            <goals>
                <goal>copy-resources</goal>
            </goals>
            <configuration>
                <outputDirectory>${basedir}/target/classes/static</outputDirectory>
                <resources>
                    <resource>
                        <directory>${basedir}/src/main/websource/dist</directory>
                        <filtering>false</filtering>
                    </resource>
                </resources>
            </configuration>
        </execution>
    </executions>
</plugin>
```
注：增加前端打包插件后，websource下必须有VUE相关配置文件才能打包成功。



### **开发运行/调试示例**

#### **IDEA 配置**

![image-20191204180459598](../images/dev-manual/quick-start/IDEA-run-config.png)

如图所示

1.  创建一个新的`Run/Debug Configuration`，选择`JAR Application`
2.  `Path to Jar`选择 *DApp* `debug包`所在路径（需要先执行**打包流程**）
3.  点击`OK`即可

#### **Eclipse 配置**

![image-20191204183041710](../images/dev-manual/quick-start/Eclipse-run-config.png)

1.  在`Run > External Tools > External tools Configurations`选择`External Tool`
2.  如上图创建一个运行设置，配置`debug包`文件路径即可。



[1]: maven-plugin.md	"Maven插件"
[2]: custom-params.md	"自定义参数"
[3]: ../api/drs-api.md	"DRS 接口列表"

