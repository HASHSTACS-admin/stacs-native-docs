# **DApp Maven 打包插件** 

## **使用**

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
            <!-- 指定执行参数，不能修改 -->
            <goal>package</goal>
          </goals>
        </execution>
      </executions>
      <configuration>
        <!-- DApp页面资源路径 -->
        <webContextPath>sample</webContextPath>
      </configuration>
    </plugin>
  </plugins>
</build>
```

## **插件参数**

| 参数               | 备注                                                         | 类型           | 默认值                     |
| ------------------ | ------------------------------------------------------------ | -------------- | -------------------------- |
| appName            | app名称，每个DRS内的app名称需要是唯一的                      | `string`       | ${artifactId}              |
| outputDirectory    | 打包输出路径                                                 | `string`       | ${project.build.directory} |
| debugClassifier    | debug包对应classifier                                        | `string`       | debug                      |
| dappClassifier     | dapp包对应classifier                                         | `string`       | dapp                       |
| priority           | 优先级                                                       | `int`          | 100                        |
| skip               | 跳过插件打包流程（插件不做任何操作）                         | `boolean`      | false                      |
| skipBuildDebug     | 跳过构建debug包                                              | `boolean`      | false                      |
| attach             | 更新maven仓库依赖                                            | `boolean`      | true                       |
| excludes           | 剔除的依赖列表，格式：`groupId:artifactId[:classifier]`，多个使用逗号(`,`)隔开 | `list<string>` |                            |
| excludeGroupIds    | 剔除`groupId`依赖的列表，格式：`groupId`，多个使用逗号(`,`)隔开 | `list<string>` |                            |
| excludeArtifactIds | 剔除`artifactsId`依赖的列表，格式：`artifactId`，多个使用逗号(`,`)隔开 | `list<string>` |                            |
| webContextPath     | web资源目录                                                  | `string`       | /                          |
| packageProvided    | 是否将`provided`类型的打包                                   | `boolean`      | false                      |
| mainClass          | 指定启动类                                                   | `string`       |                            |

>   注意：
>
>   1.  `priority`：`50`即以下的优先级被*DRS*预留，因此优先级不能低于或等于`50`

## **全参数配置示例**

**注意**：此处配置仅做格式参考，并不是能实际打包运行的配置。

```xml
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
    <!-- 配置插件的名字，务必配置对，运行时，是插件的唯一标识 ID。 默认为 ${artifactId} -->
    <appName>${artifactId}</appName>
    
    <!-- 指定打包的 ${pluginName}.ark.plugin 存放目录; 默认放在 ${project.build.directory} -->
    <outputDirectory>./</outputDirectory>

    <!-- 指定 debug 包的classifier -->
    <debugClassifier>dev</debugClassifier>
    
    <!-- 指定 dapp 包的classifier -->
    <dappClassifier>runner</dappClassifier>
    
    <!-- 配置优先级，数字越小，优先级越高，优先启动，优先导出类，默认100，低于50被DRS预留，DApp不能使用 -->
    <priority>2000</priority>

     <!-- 是否把 dapp 安装、发布到仓库，默认为true -->
    <attach>true</attach>
    
    <!-- 跳过整个打包流程 -->
    <skip>true</skip>
    
    <!-- 跳过debug包的打包流程 -->
    <skipBuildDebug>true</skipBuildDebug>

    <!-- 打包插件时，排除指定的包依赖；格式为: ${groupId:artifactId} 或者 ${groupId:artifactId:classifier} -->
    <excludes>
      <exclude>org.apache.commons:commons-lang3</exclude>
    </excludes>

    <!-- 打包插件时，排除和指定 groupId 相同的包依赖 -->
    <excludeGroupIds>
      <excludeGroupId>org.springframework</excludeGroupId>
    </excludeGroupIds>

    <!-- 打包插件时，排除和指定 artifactId 相同的包依赖 -->
    <excludeArtifactIds>
      <excludeArtifactId>sofa-ark-spi</excludeArtifactId>
    </excludeArtifactIds>

    <!-- 页面静态资源目录 -->
    <webContextPath>sample</webContextPath>
    
    <!-- 将 scope=provided 的依赖也打入包中 -->
    <packageProvided>true</packageProvided>
    
    <!-- 指定包中的 mainClass 配置 -->
    <mainClass>io.stacs.nav.dapp.sample.SampleApplication</mainClass>

  </configuration>
</plugin>
```

## **打包结果**

>   请注意：目前插件只支持打`jar`包，如果*pom*中`packing`设置为`war`、`pom`，则插件不会执行打包操作。
>
>   默认的插件配置打包会生成以下三种jar包：
>
>   *   普通 Jar：Maven 打包生成的jar包（非该插件生成）
>   *   DApp Jar：用于在*DRS*上运行的Jar包
>   *   Debug Jar：开发人员使用，用于`Debug`或测试的Jar包

### **普通 Jar**

>   缺少实际*DRS*环境依赖，无法单独运行，此处不做多的描述

### **DApp Jar**

提供*DRS*运行的Jar包，详细流程请见[DApp介绍]

### **Debug Jar**

开发人员可以通过执行命令启动DApp

```shell
$ java -jar dapp-sample-1.0.0-SNAPSHOT-debug.jar
```

若需要修改启动、运行参数，请参考[自定义参数]



[DApp介绍]: ../design/dapp.md	"什么是DApp"
[自定义参数]: custom-params.md	"自定义参数"
