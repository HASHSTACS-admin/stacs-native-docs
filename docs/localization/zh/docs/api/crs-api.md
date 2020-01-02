# CRS接口文档

接口分为区分系统级和非系统级接口， 系统级接口仅供内部RS节点调用，对外接口均为非系统级接口。
非系统级接口又分为查询类接口和交易类接口，查询类接口采用GET请求，接口无安全性设计考虑；交易类接口采用POST请求，
请求数据采用AES256加密，并会将加密数据采用ECC签名，具体参见接口规范

## 术语
- `merchantId`: 商户Id, 用于区分不同的接入方
- `merchantPriKey`: 商户ECC私钥，用于签名请求数据
- `merchantPubKey`: 商户ECC公钥，用于CRS验证商户请求签名
- `merchantAesKey`: 商户AES256格式密钥，用于加密请求数据或响应数据
- `crsPubKey`: CRS公钥，用户商户验证响应数据签名
- `crsPriKey`: CRS公钥，用于CRS签名响应数据

## 接口规范

- HTTP请求头

    *   `GET`：**无额外参数**
    
    *   `POST`:         
        `Content-Type: application/json`  
        `merchantId:${merchantId}`: CRS分配的
        
    
- Http响应状态码 200
  
- 安全性
  
    所有POST请求数据采用AES256加密，并会附上原始数据的签名; 响应数据也同样采用AES256加密，并附上CRS对原始响应数据的签名，加密并签名的数据格式如下：

    - 请求数据格式
    
      |     属性     | 类型     | 说明                                                         |
      | :----------: | -------- | ------------------------------------------------------------ |
      | requestParam | `string` | 请求数据，将原始请求数据采用${merchantAesKey}加密后使用BASE64编码 |
      |  signature   | `string` | 商户签名，将原始请求数据采用${merchantPriKey}签名后的HEX格式数据 |
    
    - 响应数据格式
    
      |   属性    | 类型     | 说明                                                         |
      | :-------: | -------- | ------------------------------------------------------------ |
      | respCode  | `string` | 返回状态码，000000为成功，其他为失败                         |
      |    msg    | `string` | 返回状态描述                                                 |
      |   data    | `string` | 响应数据，将原始响应数据采用${merchantAesKey}加密后使用BASE64编码 |
      | signature | `string` | CRS签名，将原始响应数据采用${crsPriKey}签名后的HEX格式数据   |
    



```json tab="请求实例"
{
	"requestParam": "qxZrjKc4aV/57vHBAh9yLUC40ez4XsE7OJgHFM4Uy2BrmE3mwkzcVdR20QIEHhcWvyeSVy4mQIu5pG7HhpS+AvBdH33f/r+4YSXmtKo1/vOkLsU5h/t1Z23sD/gRRMB1K5zqH7PK+Ij0//zLuLavg0+UZgFT8m3fW5egy9ULTuRPYQgmU627hrJZU72qP+EoEOKR06+RRQDflz0gkA9SSVpz9MgAZCnYFe8sFtMSqAjeRWTspaP9qXXcX4OafMYm4GlrNkyWUYwcl9A8G2NLOViGuPuDC8tFKShN+9mt4uPwsvj6um7eGwlBBL8FtqrWcX2HZMFTdHCD1rNipi+lbDta5j54p6y5wpLHoR9AOxiOuWXOiGDhzE/HiXae7DRiaPI/AHmVu5p8KPTiKIVSphpbl0kK5vv+lunvmokn1DOlRMs6CvFRIKnqbRwJrEvpaPZkXXqerYbIevtQ9e8ZtRxpdgms5bWGIAijlrOzxsKxmzCrvuMAWt9tHUz2LpCyJCG+woEnbD4p/mJ0u+68kE7P6bztLanWJ31X8DnZlRKs88S3WgYlq3WJrnuQ+qQqRbf5f6+hqPGogxVOZ3AOC3uAVTE4fkcyPTLCOuMDXp5B9hPioXHyMPVMZyGkc1IFx84XRa++uJKGQ7Ja1E/MDANTFxu4CQ/szvHuvVP+Gl3Fk50rKMY0/QiH155xgSq7pnwy2ItCYiTXXc09D2jiahEcXOLGqCuHLh/7YY3zH8hV6dxhB9/66HLaF4p5jGiXyUvbZRhcQE2gu+jW43EETLq+t29z122NQm75M+Q60toy7UrIr+brOrAfMYGpE527vNZAmaEWFJd2i8lDDXoaGMd8l8OiHqnMbxjWQsU4VkGHz0+3jpZpJY5fraq+EgATXfG9IyiNM+yrNL+kwcEmnH3WOdcve+P8keocey2SPu5LgQ10XUvN6qVsi+m6qXy6TsjAWq3Zq5u8beIY9zFBWxScaXlV9c4XLJkXM7tfz04wD7/hGM/S4Il8awRYHAJkUEF2GR1zYNzDFeHWq/mE2x3HWogdKAjwwkPdw8ZEjN9BIVDKVmH1Q/12nUgfr1w9",
	"signature": "017236d91c3fa2560a5c5fdee1e4a7a55397d146213153d09cea97b1d1949596e2636cf6081bf1a0695811556e9f41918924c41a58149e994ab4132eb54279345d"
}
```

```json tab="响应实例"
{
	"data": "LxLoZ460dSIcnN2jZWvDfEwUsg8B2cEwgnb5olJp6jbrOYSIAryN+27QpLLRLNeIGqwSHgTRr93mtpJlqA0wCPS9iLt/vLY3hS4fQjtF4Rs=",
	"msg": "Success", // 操作成功
	"respCode": "000000", // 返回代码， 000000为成功
	"signature": "012db52119a153606a362ff78e197e27cbf1fbff8e04d138cfe0e858ab701741ae1556e0667a145a50004504771297e48815ef31a9f5028b9132da0f70ded82075"
}
```


## 系统级接口

!!! info "提示"
    系统级接口只能由`CRS`节点发起，并不对`DRS`节点开放。

### 通用参数列表

|     属性      | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| :-----------: | -------- | -------- | ---- | :------: | ------------------------------------------------------------ |
|     txId      | `string` | 64       | Y    |    Y     | 请求Id                                                       |
|   submitter   | `string` | 40       | Y    |    Y     | 操作提交者地址                                               |
| submitterSign | `string` | 64       | Y    |    Y     | 提交者签名                                                   |
|    bdCode     | `string` | 64       | Y    |    Y     |                                                              |
|  feeCurrency  | `string` | 32       | N    |    Y     | 手续费币种                                                   |
| feeMaxAmount  | `string` | 18       | N    |    Y     | 最大允许的手续费                                             |
| functionName  | `string` |          | Y    |    Y     | BD的functionName，如果是BD的初始化或者合约的发布：`CREATE_CONTRACT` |

> 相比非系统级，少了`execPolicyId`字段，接口中会设定固定的`execPolicyId`

### Domain & RS

>   `Domain`管理旗下`RS`节点的接口，让节点可以**注册**到`Domain`中参与交易处理，也可以**移除**`domain`下指定节点

#### 注册RS

- - [ ] 开放

- 接口描述： RS 注册

- 请求地址：`POST`：`/rs/register` 

- 请求参数： 

  |    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明             |
  | :---------: | -------- | -------- | ---- | :------: | ---------------- |
  |    rsId     | `string` | 32       | Y    |    Y     | RS id            |
  |    desc     | `string` | 128      | Y    |    Y     | RS 节点描述      |
  |  domainId   | `string` | 16       | Y    |    Y     | Domain ID        |
  | maxNodeSize | `int`    |          | N    |    Y     | 最大节点允许数量 |
  | domainDesc  | `string` |          | N    |    Y     | domain 描述      |
  
- 响应参数：

  | 属性 | 类型 | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | ---- | -------- | ---- | -------- | ---- |
  |  无  |      |          |      |          |      |


##### 示例

```java
// todo sdk 请求代码
```



#### 移除RS

- - [ ] 开放

- 接口描述：  移除已注册的 RS

- 请求地址：`POST`：`/rs/cancel`

- 请求参数： 

  | 属性 | 类型     | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | -------- | -------- | ---- | -------- | ---- |
  | rsId | `string` | 32       | Y    | Y        |      |
  
- 响应参数：

  | 属性 | 类型 | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | ---- | -------- | ---- | -------- | ---- |
  |  无  |      |          |      |          |      |


### CA

> 节点接入时认证信息

#### CA注册

- - [ ] 开放

- 接口描述：  注册 CA 信息

- 请求地址：`POST`：`/ca/auth`

- 请求参数： 

  |  属性  | 类型         | 最大长度 | 必填 | 是否签名 | 说明 |
  | :----: | ------------ | -------- | ---- | -------- | ---- |
  | caList | `list<CaVO>` |          | Y    | Y        |      |

- CaVO：

  |   属性   | 类型     | 最大长度 | 必填 | 是否签名 | 说明                 |
  | :------: | -------- | -------- | ---- | -------- | -------------------- |
  |  period  | `date`   |          | Y    | Y        | ca生效时间(暂时无用) |
  |  pubKey  | `string` |          | Y    | Y        | ca公钥               |
  |   user   | `string` |          | Y    | Y        |                      |
  | domainId | `string` |          | Y    | Y        | 生效的domainId       |
  |  usage   | `string` |          | Y    | Y        | 1. biz 2. consensus  |


- 响应参数：

  | 属性 | 类型 | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | ---- | -------- | ---- | -------- | ---- |
  |  无  |      |          |      |          |      |

#### CA更新

- - [ ] 开放

- 接口描述：  更新 CA 信息

- 请求地址：`POST`：`/ca/update`

- 请求参数：

  |   属性   | 类型     | 最大长度 | 必填 | 是否签名 | 说明                 |
  | :------: | -------- | -------- | ---- | -------- | -------------------- |
  |  period  | `date`   |          | Y    | Y        | ca生效时间(暂时无用) |
  |  pubKey  | `string` |          | Y    | Y        | ca公钥               |
  |   user   | `string` |          | Y    | Y        |                      |
  | domainId | `string` |          | Y    | Y        | 生效的domainId       |
  |  usage   | `string` |          | Y    | Y        | 1. biz 2. consensus  |

- 响应参数：

  | 属性 | 类型 | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | ---- | -------- | ---- | -------- | ---- |
  |  无  |      |          |      |          |      |



#### CA撤销

- - [ ] 开放

- 接口描述：  撤销授权后的 CA

- 请求地址：`POST`:`/ca/cancel`

- 请求参数： 

  |   属性   | 类型     | 最大长度 | 必填 | 是否签名 | 说明                |
  | :------: | -------- | -------- | ---- | -------- | ------------------- |
  |  pubKey  | `string` |          | Y    | Y        |                     |
  |   user   | `string` |          | Y    | Y        |                     |
  | domainId | `string` |          | Y    | Y        |                     |
  |  usage   | `string` |          | Y    | Y        | 1. biz 2. consensus |

- 响应参数：

  | 属性 | 类型 | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | ---- | -------- | ---- | -------- | ---- |
  |  无  |      |          |      |          |      |

> 相比**统一参数**，缺少了`period`字段

### 节点

#### 节点加入

- - [ ] 开放

- 接口描述：  节点加入共识网络

- 请求地址：`POST`：`/node/join`

- 请求参数： 

  |   属性    | 类型     | 最大长度 | 必填 | 是否签名 | 说明           |
  | :-------: | -------- | -------- | ---- | -------- | -------------- |
  | nodeName  | `string` |          | Y    | Y        | 加入的节点名称 |
  | domainId  | `string` |          | Y    | Y        |                |
  | signValue | `string` |          | Y    | Y        |                |
  |  pubKey   | `string` |          | Y    | Y        | 节点公钥       |

- 响应参数：

  | 属性 | 类型 | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | ---- | -------- | ---- | -------- | ---- |
  |  无  |      |          |      |          |      |





#### 节点离开

- - [ ] 开放

- 接口描述： 节点离开共识网络

- 请求地址：`POST`：`/node/leave`

- 请求参数： 

  |   属性    | 类型     | 最大长度 | 必填 | 是否签名 | 说明           |
  | :-------: | -------- | -------- | ---- | -------- | -------------- |
  | nodeName  | `string` | 32       | Y    | Y        | 离开的节点名称 |
  | domainId  | `string` | 16       | Y    | Y        |                |
  | signValue | `string` |          | Y    | Y        |                |
  |  pubKey   | `string` |          | Y    | Y        | 节点公钥       |

- 响应参数：

  | 属性 | 类型 | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | ---- | -------- | ---- | -------- | ---- |
  |  无  |      |          |      |          |      |



### 手续费

#### 手续费地址合约配置

- - [ ] 开放

- 接口描述：  配置手续费收取货币所在合约地址，以及收取手续费后，转入手续费的账户地址。

- 请求地址：`POST`：`/fee/setConfig`

- 请求参数： 

  |      属性       | 类型     | 最大长度 | 必填 | 是否签名 | 说明                       |
  | :-------------: | -------- | -------- | ---- | -------- | -------------------------- |
  | currency        | `string` | 32       | Y    | Y        | 币种代码symbol              |
  | receiveAddr     | `string` | 40       | Y    | Y        | 手续费收费地址               |

- 响应参数：

  | 属性 | 类型 | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | ---- | -------- | ---- | -------- | ---- |
  |  无  |      |          |      |          |      |



## 非系统级接口

#### 权限

##### Identity权限查询

- [x] 开放
- 接口描述：  查询Identity用户所拥有的permission权限
- 请求地址：`GET`:`/identity/permission/query?address={address}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | Y        | 用户地址                     |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| permissionIndex | `int` | 64     | Y    | Y        | 权限编号                      |
| permissionName | `string` | 64     | Y    | Y        | 权限名称                      |
- 实例：

``` tab="请求实例"

```

```json tab="响应实例"
{
    "data":[
        {
            "permissionIndex":22,
            "permissionName":"CONTRACT_INVOKE"
        },
        {
            "permissionIndex":0,
            "permissionName":"DEFAULT"
        },
        {
            "permissionIndex":21,
            "permissionName":"CONTRACT_ISSUE"
        }
    ],
    "msg":"Success",
    "respCode":"000000",
    "success":true
}
```



##### Identity鉴权
- [x] 开放
- 接口描述：  检查用户是否有鉴别的权限
- 请求地址：`POST`：`identity/checkPermission`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | N        | 用户地址                     |
| permissionNames | `<string[]>` | 40     | N    | Y        | 需要检查的权限，数组                     |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| data | `boolean` | 64     | Y    | Y        | 检查结果，成功返回true,失败返回false                      |

- 实例：

``` tab="请求实例"
{
	"address":"b187fa1ba0e50a887b3fbd23f0c7f4163300b5f9",
	"bdCode":null,
	"execPolicyId":null,
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":null,
	"permissionNames":[
		"CONTRACT_INVOKE"
	],
	"submitter":null,
	"submitterSign":null,
	"txId":null
} 
```

```json tab="响应实例"
{
    "data":"true",
    "msg":"Success",
    "respCode":"000000"
}
```



#### BD

##### BD发布
- [x] 开放
- 接口描述：  发布自定义BD
- 请求地址：`POST`:`/bd/publish`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| code      | `string` | 64     | Y    | Y        | BD编号（唯一）                      |
| name      | `string` | 64     | Y    | Y        | BD名称                      |
| bdType    | `string` | 64     | Y    | Y        | BD类型（/system/contract/asserts）                      |
| desc      | `string` | 64     | Y    | Y        | 描述                      |
| functions | `json[]` | 64     | Y    | Y        | functions                      |
| initPermission | `string` | 64     | Y    | Y        | 初始化BD的业务需要permission                      |
| initPolicy | `string` | 64     | Y    | Y        | 初始化BD的业务需要policy策略                     |

function定义:

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| desc | `string` | 64     | Y    | Y        | function描述                     |
| execPermission | `string` | 64     | Y    | Y        | 执行function权限                      |
| execPolicy | `string` | 64     | Y    | Y        | 执行function policy                      |
| methodSign | `string` | 64     | Y    | Y        | 如果dbType类型为(contract/asserts),则为方法签名                      |
| name | `string` | 64     | Y    | Y        | function名称                      |
| type | `string` | 64     | Y    | Y        |     (SystemAction/Contract)                  |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"bdType":"asserts",
	"bdVersion":"1.0",
	"code":"CBD_SC_61418",
	"desc":null,
	"execPolicyId":"BD_PUBLISH",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"BD_PUBLISH",
	"functions":[
		{
			"desc":"",
			"execPermission":"CONTRACT_INVOKE",
			"execPolicy":"CONTRACT_INVOKE",
			"methodSign":"transfer(address,uint256)",
			"name":"transfer",
			"type":"Contract"
		},
		{
			"desc":"",
			"execPermission":"CONTRACT_INVOKE",
			"execPolicy":"CONTRACT_INVOKE",
			"methodSign":"transferToContract(uint256,uint256,address,string)",
			"name":"transferToContract",
			"type":"Contract"
		},
		{
			"desc":"",
			"execPermission":"CONTRACT_INVOKE",
			"execPolicy":"CONTRACT_INVOKE",
			"methodSign":"balanceOf(address)",
			"name":"balanceOf",
			"type":"Contract"
		},
		{
			"desc":"",
			"execPermission":"CONTRACT_INVOKE",
			"execPolicy":"CONTRACT_INVOKE",
			"methodSign":"additionalIssue(uint256)",
			"name":"additionalIssue",
			"type":"Contract"
		},
		{
			"desc":"",
			"execPermission":"CONTRACT_INVOKE",
			"execPolicy":"CONTRACT_INVOKE",
			"methodSign":"buybackPay(address[],uint256[])",
			"name":"buybackPay",
			"type":"Contract"
		},
		{
			"desc":"",
			"execPermission":"CONTRACT_INVOKE",
			"execPolicy":"CONTRACT_INVOKE",
			"methodSign":"settlPay(address[],uint256[])",
			"name":"settlPay",
			"type":"Contract"
		}
	],
	"initPermission":"DEFAULT",
	"initPolicy":"CONTRACT_ISSUE",
	"name":"CBD_SC_61418",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"00597f7f51767ed748cfe83d54b117a6a6f7af5556b051c0cff82708dff13892736ff022fddd9a0dbcfaeafe8df2b1c211dcb1b666b3d64859f0e331f4bd7d7dac",
	"txId":"0f2222f69027942c341b0e1296256b2b8acd3135bc448b3e6bea106d22e362a3"
} 
```

```json tab="响应实例"
{
	"data":"0f2222f69027942c341b0e1296256b2b8acd3135bc448b3e6bea106d22e362a3",
	"msg":"Success",
	"respCode":"000000"
} 
```

##### BD查询

- [x] 开放
- 接口描述：  按db查询db详情
- 请求地址：`GET`:`/bd/query?bdCode={bdCode}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| bdCode          | `string`     | 40     | N    | N        | 查询的BD                     |
                    |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| bdType | `string` | 64     | Y    | Y        | bd类型(system/contract/asserts)                      |
| code | `string` | 64     | Y    | Y        | BD的code，唯一                     |
| desc | `string` | 64     | Y    | Y        | 描述                     |
| functions | `JSONArray` | 4082     | Y    | Y        | bd定义的支持的function申明|
| initPermission | `string` | 64     | Y    | Y        | 发布BD时，发布者需要具备的权限                      |
| initPolicy | `string` | 64     | Y    | Y        | 发布BD时，发布执行的policy策略    |
| name | `string` | 64     | Y    | Y        | BD名称                      |
| bdVersion | `string` | 64     | Y    | Y        | BD版本号                     |
- 实例：

``` tab="请求实例"
/bd/query?bdCode=
```

```json tab="响应实例"
{
	"data":[
		{
			"bdType":"asserts",
			"bdVersion":"1.0",
			"code":"CBD_SC_87716",
			"createTime":1576152885920,
			"desc":null,
			"functions":"[{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"transfer(address,uint256)\",\"name\":\"transfer\",\"signValue\":\"transferContracttransfer(address,uint256)CONTRACT_INVOKECONTRACT_INVOKE\",\"type\":\"Contract\"},{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"transferToContract(uint256,uint256,address,string)\",\"name\":\"transferToContract\",\"signValue\":\"transferToContractContracttransferToContract(uint256,uint256,address,string)CONTRACT_INVOKECONTRACT_INVOKE\",\"type\":\"Contract\"},{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"balanceOf(address)\",\"name\":\"balanceOf\",\"signValue\":\"balanceOfContractbalanceOf(address)CONTRACT_INVOKECONTRACT_INVOKE\",\"type\":\"Contract\"},{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"additionalIssue(uint256)\",\"name\":\"additionalIssue\",\"signValue\":\"additionalIssueContractadditionalIssue(uint256)CONTRACT_INVOKECONTRACT_INVOKE\",\"type\":\"Contract\"},{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"buybackPay(address[],uint256[])\",\"name\":\"buybackPay\",\"signValue\":\"buybackPayContractbuybackPay(address[],uint256[])CONTRACT_INVOKECONTRACT_INVOKE\",\"type\":\"Contract\"},{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"settlPay(address[],uint256[])\",\"name\":\"settlPay\",\"signValue\":\"settlPayContractsettlPay(address[],uint256[])CONTRACT_INVOKECONTRACT_INVOKE\",\"type\":\"Contract\"}]",
			"id":null,
			"initPermission":"DEFAULT",
			"initPolicy":"CONTRACT_ISSUE",
			"name":"CBD_SC_87716",
			"updateTime":null
		}
	],
	"msg":"Success",
	"respCode":"000000"
} 
```





#### 快照
##### 快照发布

- [x] 开放
- 接口描述： 申请一个快照版本，入链后记录当前快照处理的区块高度，快照申请成功后，可以按区块高度查询到申请快照时的信息 
（快照发布使用的是存证的execPolicyId和functionName）
- 请求地址：`GET`:`/snapshot/build`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| snapshotId | `string` | 64     | Y    | Y        | 快照id                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"execPolicyId":"SAVE_ATTESTATION",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"SAVE_ATTESTATION",
	"snapshotId":"96839",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"018fec08c850da8fef29e296f6ab1a171c1ad6b7a0357c4050512e2e99ad958a0464751aa16549044ea14ebfacd7a9f766b07c7e8089d66224e92cb7aef760b385",
	"txId":"77ba0c8d3759fb3a3aa886d5f3083012f4850463d7400d1e23fb709b0914de82"
} 
```

```json tab="响应实例"
{
	"data":"77ba0c8d3759fb3a3aa886d5f3083012f4850463d7400d1e23fb709b0914de82",
	"msg":"Success",
	"respCode":"000000"
} 
```

##### 快照查询

- [x] 开放
- 接口描述：  
- 请求地址：`GET`:`/snapshot/query?txId=${txId}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | 交易id                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| blockHeight | `int` |      | Y    | Y        | 区块高度                      |
| snapshotId | `string` |      | Y    | Y        | 快照id                      |

- 实例：

```json tab="请求实例"

```

```json tab="响应实例"
{
    "data":{
        "blockHeight":926,
        "snapshotId":"68240"
    },
    "msg":"Success",
    "respCode":"000000",
    "success":true
}
```

#### 合约

##### 查询

- [x] 开放

`POST`:`/contract/query`

>   基于BD `code`查询对应业务类型合约列表。

|      属性       | 类型       | 最大长度 | 必填 | 是否签名 | 说明                                   |
| :-------------: | ---------- | -------- | ---- | -------- | -------------------------------------- |
|     address     | `string`   | 40       | Y    | N        | 合约地址                               |
| methodSignature | `string`   |          | Y    | N        | 方法签名，eg：`(uint256) get(uint256)` |
|   blockHeight   | `long`     |          | N    | N        | 块高度                                 |
|   parameters    | `object[]` |          | N    | N        | 方法参数                               |

### 交易类接口

#### 交易类接口通用参数列表

|     属性      | 类型     | 最大长度 | 必填 | 是否签名 | 说明             |
| :-----------: | -------- | -------- | ---- | -------- | ---------------- |
|     txId      | `string` | 64       | Y    | Y        | 请求Id           |
|   submitter   | `string` | 40       | Y    | Y        | 操作提交者地址   |
| execPolicyId  | `string` | 32       | Y    | Y        | 执行policyId     |
| submitterSign | `string` | 64       | Y    | Y        | 提交者签名       |
| bdCode | `string` | 64       | Y    | Y        |        |
|  feeCurrency  | `string` | 32       | N    | Y        | 手续费币种       |
| feeMaxAmount  | `string` | 18       | N    | Y        | 最大允许的手续费 |



#### BD(Business Define)

##### BD发布

- [x] 开放

`POST`:`/bd/publish`

>   在整个区块链上发布新的业务定义(`BD`)

| 属性           | 类型                   | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| -------------- | ---------------------- | -------- | ---- | -------- | ------------------------------------------------------------ |
| code           | `string`               | 32       | Y    | Y        | BD code，唯一且只能使用大小写字母与数字的组合                |
| name           | `string`               | 64       | N    | Y        | 必须参与投票的domainId列表                                   |
| bdType         | `string`               | 32       | N    | Y        | BD类型：`system`、`contract`，如果值为`system`表示系统类型，`initPermission`&`initPolicy`可为**空** |
| desc           | `string`               | 1024     | N    | Y        | BD描述                                                       |
| initPermission | `string`               | 64       | Y    | Y        | BD执行`initPolicy`时所需的`PermissionName`                   |
| initPolicy     | `string`               | 32       | Y    | Y        | 创建`BD`关联的合约时所需`policy`的id                         |
| functions      | `list<FunctionDefine>` |          | Y    | Y        | BD中定义的`function`列表                                     |
| bdVersion      | `string`               | 4        | Y    | Y        | BD 版本号                                                    |

**FuncitonDefine参数**

>   BD中定义的各类业务方法以及它们关联的执行权限、执行策略(Policy)

| 属性           | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                       |
| -------------- | -------- | -------- | ---- | -------- | ------------------------------------------ |
| name           | `string` | 64       | Y    | Y        | function name                              |
| type           | `string` |          | Y    | Y        | 1. contract 2. systemAction                |
| desc           | `string` | 256      | N    | Y        | BD function文字描述                        |
| methodSign     | `string` | 256      | Y    | Y        | 方法签名，eg：`(bool) buybackFrozen(bool)` |
| initPermission | `string` | 64       | N    | Y        | BD执行`initPolicy`时所需的`PermissionName` |
| execPolicy     | `string` | 32       | N    | Y        | 执行`function`时所需`policy`Id             |

#### 智能合约

##### 部署

- [x] 开放

`POST`:`/contract/deploy`

>   创建一个关联对应`bdCode`的**合约**，`initArgs`将传入对应BD的初始化方法。

| 属性            | 类型       | 最大长度 | 必填 | 是否签名 | 说明                       |
| --------------- | ---------- | -------- | ---- | -------- | -------------------------- |
| fromAddr        | `string`   | 40       | Y    | Y        | 提交者地址                 |
| contractAddress | `string`   | 40       | N    | Y        | 必须参与投票的domainId列表 |
| name            | `string`   | 64       | Y    | Y        | 合约名称                   |
| extension       | `string`   | 1024     | N    | Y        | 扩展属性                   |
| contractor      | `string`   |          | Y    | Y        | 合约构造器(函数)名         |
| sourceCode      | `string`   |          | Y    | Y        | 合约代码                   |
| initArgs        | `object[]` |          | Y    | Y        | 合约构造入参               |



##### 执行

- [x] 开放

`POST`:`/contract/invoke`

>   传入参数`args`，执行合约对应的方法。

| 属性            | 类型         | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| --------------- | ------------ | -------- | ---- | -------- | ------------------------------------------------------------ |
| methodSignature | `string`     |          | Y    | Y        | 方法签名                                                     |
| args            | `object[]`   |          | N    | Y        | 合约方法入参                                                 |
| from            | `string`     | 40       | Y    | Y        | 交易提交地址                                                 |
| to              | `string`     | 40       | Y    | Y        | 合约地址                                                     |
| value           | `BigDecimal` |          | N    | Y        | (如果是转账方法)转账金额                                     |
| functionName    | `string`     |          | Y    | Y        | BD的functionName，如果是BD的初始化或者合约的发布：`CREATE_CONTRACT` |

#### Policy

##### AssigMeta类型


| 属性          | 类型          | 最大长度 | 必填 | 是否签名 | 说明                           |
| ------------- | ------------- | -------- | ---- | -------- | ------------------------------ |
| verifyNum     | `int`         |          | N    | Y        | 需要投票的domain数量           |
| mustDomainIds | `list<string` |          | N    | Y        | 必须参与投票的domainId列表     |
| expression    | `string`      |          | N    | Y        | 投票规则表达式，example: n/2+1 |

##### Policy注册

- [ ] 开放

`POST`:`/policy/register`

>   创建新的投票策略

| 属性           | 类型           | 最大长度 | 必填 | 是否签名 | 说明                                         |
| -------------- | -------------- | -------- | ---- | -------- | -------------------------------------------- |
| policyId       | `string`       | 32       | Y    | Y        | 注册的policyId                               |
| policyName     | `string`       | 64       | Y    | Y        |                                              |
| votePattern    | `string`       |          | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| callbackType   | `string`       |          | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
| decisionType   | `string`       |          | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| domainIds      | `list<string>` |          | Y    | Y        | 参与投票的domainId列表                       |
| requireAuthIds | `list<string>` |          | N    | Y        | 需要通过该集合对应的rs授权才能修改当前policy |

##### Policy更新

- [ ] 开放

`POST`:`/policy/modify`

>   更新旧的投票策略

|      属性      | 类型           | 最大长度 | 必填 | 是否签名 | 说明                                         |
| :------------: | -------------- | -------- | ---- | -------- | -------------------------------------------- |
|    policyId    | `string`       | 32       | Y    | Y        | 注册的policyId                               |
|   policyName   | `string`       | 64       | Y    | Y        |                                              |
|  votePattern   | `string`       |          | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
|  callbackType  | `string`       |          | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
|  decisionType  | `string`       |          | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
|   domainIds    | `list<string>` |          | Y    | Y        | domainId列表                                 |
| requireAuthIds | `list<string>` |          | N    | Y        | 需要通过该集合对应的rs授权才能修改当前policy |

#### Permission

##### 新增Permission

- [x] 开放
- 接口描述：  添加permission,Identity被授予permission后才能执行该permission所定义交易
- 请求地址：`POST`:`/permission/register`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| permissionName       | `string` | 64        | Y    | Y        | permission名称       |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| data       | `string` | 64        | Y    | Y        | 返回交易ID       |

- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"execPolicyId":"PERMISSION_REGISTER",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"PERMISSION_REGISTER",
	"permissionName":"permission_97251",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"0146a281667fea21a7f3fa5910689b3a0ea33a84f6d87885584237cd0306cc05715cdc6a527c9564c58a05e801b117ae2cf43869656fd4bb4aa8eee7e2bb355763",
	"txId":"45ebc7a42b0ad5364e4f5a141db6473a12ffce2ee7d5226d9490183ef172d4a7"
} 
```

```json tab="响应实例"

	"data":"45ebc7a42b0ad5364e4f5a141db6473a12ffce2ee7d5226d9490183ef172d4a7",
	"msg":"Success",
	"respCode":"000000"
} 
```

#### Identity

##### Identity设置

- [x] 开放
- 接口描述：  设置Identity(此接口不能设置KYC信息)
- 请求地址：`POST`:`/identity/setting`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:  | -------- | -------- | ---- | -------- | :---------------------------- |
| address      | `string` | 64     | Y    | Y        | Identity地址                      |
| hidden       | `int`    | 1      | Y    | Y        | 是否隐藏                      |
| identityType | `string` | 64     | Y    | Y        |  1. user 2. domain 3. node       |



|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| txId | `string` |          | Y    | Y        | 交易id |                           |

- 实例：

```json tab="请求实例"
{
	"address":"4a02aa7f84d01b63b28c81c096f8c2e3feda7df9",
	"bdCode":"SystemBD",
	"currentBlockHeight":null,
	"execPolicyId":"IDENTITY_SETTING",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"froze":null,
	"functionName":"IDENTITY_SETTING",
	"hidden":0,
	"identityType":"user",
	"kYC":null,
	"permissions":null,
	"preBlockHeight":null,
	"property":"{}",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"0126dd3b87c68bd0977c9dd952f3695dc6ecb7f9b85125918a8834991d16547e3f71380e4ed9bf1cc9b3cc3b47d8ad90208bff8f2f15cc0991dc8fe0dcbeeda7f0",
	"txId":"1573c09b4d38a9ec914cca57b950db35e1142b63396c0a238c9e4f656c7509c6"
} 
```

```json tab="响应实例"
{
	"data":"1573c09b4d38a9ec914cca57b950db35e1142b63396c0a238c9e4f656c7509c6",
	"msg":"Success",
	"respCode":"000000"
} 
```

##### Identity授权

- [x] 开放
- 接口描述：  给Identity赋予已入链的permission
- 请求地址：`POST`:`/permission/authorize`
- 请求参数

|      属性       | 类型       | 最大长度 | 必填 | 是否签名 | 说明                               |
| :-------------: | ---------- | -------- | ---- | -------- | ---------------------------------- |
| identityAddress | `string`   | 40       | Y    | Y        | 新增identity地址                   |
| permissionNames | `string[]` |          | Y    | Y        | 给Identity授权的PermissionName数组 |
|  identityType   | `string`   |          | Y    | Y        | 1. user 2. domain 3. node          |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| data | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"execPolicyId":"AUTHORIZE_PERMISSION",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"AUTHORIZE_PERMISSION",
	"identityAddress":"5165c656244637cf8d5f7ad8f5e10f703c784962",
	"identityType":"user",
	"permissionNames":["permission_97251"],
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"00b7dbeccdc06a57dd3ed5028d329c7ff9ae0c392967e4bb12220818ef9f0c26be4674102cb12036243c19ccce10f5beb89b4ce4b290d19ede1ff2227502daf7ff",
	"txId":"c03ba6d1fe11c941b110a3064ce675e52c74be56c9dae4beaccbe287ce4f86e1"
} 
```

```json tab="响应实例"
{
	"data":"c03ba6d1fe11c941b110a3064ce675e52c74be56c9dae4beaccbe287ce4f86e1",
	"msg":"Success",
	"respCode":"000000"
} 
```

##### identity撤销权限

- [x] 开放
- 接口描述：  撤销Identity已被授权的permission
- 请求地址：`POST`:`/permission/cancel`
- 请求参数： 

|      属性       | 类型       | 最大长度 | 必填 | 是否签名 | 说明                               |
| :-------------: | ---------- | -------- | ---- | -------- | ---------------------------------- |
| identityAddress | `string`   | 40       | Y    | Y        | 新增identity地址                   |
| permissionNames | `string[]` |          | Y    | Y        | 给Identity撤销授权的PermissionName数组 |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"execPolicyId":"CANCEL_PERMISSION",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"CANCEL_PERMISSION",
	"identityAddress":"5165c656244637cf8d5f7ad8f5e10f703c784962",
	"permissionNames":["permission_97251"],
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"01d28a6d7d7ed2b68bc7b0b63e1089a4d6c1f91dc5ffa22a99d508f744fc29aa554369f96c27594e3956aede9dbb8aa143cbedcd49850198b5391be958e160b9b6",
	"txId":"49046127ec22fd91e95ed7339bfbc051d1141869bb6abdae0699503e3255e8dc"
} 
```

```json tab="响应实例"
{
	"data":"49046127ec22fd91e95ed7339bfbc051d1141869bb6abdae0699503e3255e8dc",
	"msg":"Success",
	"respCode":"000000"
} 
```
##### Identity冻结/解冻

- [x] 开放
- 接口描述：  
- 请求地址：`POST`:`/identity/bdManage`
- 请求参数： 

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| targetAddress | `string`   | 40       | Y    | Y        | 目标identity地址              |
|    BDCodes    | `string[]` |          | Y    | Y        |                               |
|  actionType   | `string`   |          | Y    | Y        | 操作类型：1. froze 2. unfroze |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
	"actionType":"froze",
	"bDCodes":["CBD_SC_97251"],
	"bdCode":"SystemBD",
	"execPolicyId":"IDENTITY_BD_MANAGE",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"IDENTITY_BD_MANAGE",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"01355fe479c900c5bd3ec52c01aa3543f271b4ba6b0963adc31cc4b7baa1ccace17e1dd22c93a3ff9e7d35ad80e6a6e2028a38854583778a424a0c6ac143bb3975",
	"targetAddress":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"txId":"9e93ae8071511828c2879206a1a6c50f3d292f5790e3d8f0379a0b3b5f98b67c"
} 
```

```json tab="响应实例"
{
	"data":"9e93ae8071511828c2879206a1a6c50f3d292f5790e3d8f0379a0b3b5f98b67c",
	"msg":"Success",
	"respCode":"000000"
} 
```

##### 查询Identity

- [x] 开放
- 接口描述：  
- 请求地址：`GET`:`identity/query?userAddress=${userAddress}`
- 请求参数： 

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| userAddress | `string`   | 40       | Y    | Y        | identity地址              |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
	"actionType":"froze",
	"bDCodes":["CBD_SC_97251"],
	"bdCode":"SystemBD",
	"execPolicyId":"IDENTITY_BD_MANAGE",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"IDENTITY_BD_MANAGE",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"01355fe479c900c5bd3ec52c01aa3543f271b4ba6b0963adc31cc4b7baa1ccace17e1dd22c93a3ff9e7d35ad80e6a6e2028a38854583778a424a0c6ac143bb3975",
	"targetAddress":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"txId":"9e93ae8071511828c2879206a1a6c50f3d292f5790e3d8f0379a0b3b5f98b67c"
} 
```

```json tab="响应实例"
{
	"data":"9e93ae8071511828c2879206a1a6c50f3d292f5790e3d8f0379a0b3b5f98b67c",
	"msg":"Success",
	"respCode":"000000"
} 
```
##### 查询permission
- [x] 开放
- 接口描述：  
- 请求地址：`GET`:`/permission/queryAll`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| attestation | `string` | 4096     | Y    | Y        | 存证内容                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| permissionIndex | `int` | 64     | Y    | Y        | permission编号                      |
| permissionName  | `string` | 64     | Y    | Y        | permission名称                      |

- 实例：

```json tab="请求实例"

```

```json tab="响应实例"

	"data":[
		{
			"permissionIndex":34,
			"permissionName":"permission_98731"
		},
		{
			"permissionIndex":45,
			"permissionName":"permission_97251"
		},
		{
			"permissionIndex":1,
			"permissionName":"RS"
		},
		{
			"permissionIndex":0,
			"permissionName":"DEFAULT"
		},
		{
			"permissionIndex":21,
			"permissionName":"CONTRACT_ISSUE2"
		},
		{
			"permissionIndex":1,
			"permissionName":"CONTRACT_ISSUE"
		},
		{
			"permissionIndex":22,
			"permissionName":"CONTRACT_INVOKE2"
		},
		{
			"permissionIndex":2,
			"permissionName":"CONTRACT_INVOKE"
		}
	],
	"msg":"Success",
	"respCode":"000000"
} 
```

##### KYC设置

- [x] 开放
- 接口描述：  给Identity设置KYC信息，KYC为json格式，每次设置设置会覆盖之前的KYC信息
- 请求地址：`POST`:`/kyc/setting`
- 请求参数：

|      属性       | 类型     | 最大长度 | 必填 | 是否签名 | 说明                            |
| :-------------: | -------- | -------- | ---- | -------- | ------------------------------- |
| identityAddress | `string` | 40       | Y    | Y        | 目标identity地址                |
|       KYC       | `string` | 1024     | Y    | Y        | KYC属性（json字符串）                         |
|  identityType   | `string` |          | N    | Y        | 1. user(默认) 2. domain 3. node |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"execPolicyId":"KYC_SETTING",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"KYC_SETTING",
	"identityAddress":"7cc176180280d46bc15d871e02475ae47a4255f2",
	"identityType":"user",
	"kYC":"{\"aaa\":111,\"bbb\":222}",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"016f1536b7a6f1df12fe8b7a165d9c646028fb127c4d74e5f991aa05c234ad6d77656cc83a206334ae83f44cfbf3ad11078ac004825da67b48e47b6e51a8941ee9",
	"txId":"ebabcbf2151fbcfe42e1c5d2aae532b5eedac461fe71ccc67263c5a5a3b53ea5"
} 
```

```json tab="响应实例"
{
	"data":"ebabcbf2151fbcfe42e1c5d2aae532b5eedac461fe71ccc67263c5a5a3b53ea5",
	"msg":"Success",
	"respCode":"000000"
} 
```

#### 存证

- [x] 开放
- 接口描述：  保存存证信息入链
- 请求地址：`POST`:`/attestation/save`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| attestation | `string` | 4096     | Y    | Y        | 存证内容                      |
|   version   | `string` | 20       | Y    | Y        | 存证版本                      |
|   remark    | `string` | 1024     | N    | Y        | 备注                          |
|  objective  | `string` | 40       | N    | Y        | 目标地址，默认使用`submitter` |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
    attestation: "我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，",
    attestationVersion: "1.0",
    bdCode: "SystemBD",
    execPolicyId: "SAVE_ATTESTATION",
    feeCurrency: null,
    feeMaxAmount: null,
    functionName: "SAVE_ATTESTATION",
    objective: "177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
    remark: "markmarkmarkmarkmark",
    submitter: "177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
    submitterSign: "00053bf0571664f5de53b3afd7d18e32eaf8ce6afe3a2352e3bdf90d4ff748a2b66977d3b2d5c8a1f88867109bfde3c1eba25910fcc64649f2e41e39946f71dada",
    txId: "71a29ad1d5968081bfc911b07066a2e953ebe5451b1f1779a9ff54f580170914"
}
```

```json tab="响应实例"
{
   txId: "71a29ad1d5968081bfc911b07066a2e953ebe5451b1f1779a9ff54f580170914"
}
```

##### 存证查询
- [x] 开放
- 接口描述：  查询入链存证信息
- 请求地址：`GET`:`/attestation/query?txId={txId}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | 存证交易id                      |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
/attestation/query?txId={txId}
```

```json tab="响应实例"
{
	"data":{
		"attestation":"我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，",
		"attestationVersion":"1.0",
		"remark":"markmarkmarkmarkmark"
	},
	"msg":"Success",
	"respCode":"000000"
} 
```


### 普通接口

#### DRS回调地址注册

-   [x] 开放

`POST`:`/callback/register`

>   (通常是)`DRS`向`CRS`注册交易完成时通知交易完成的回调地址

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明          |
| :----------: | -------- | -------- | ---- | -------- | ------------- |
| callBackAddr | `string` |          | Y    | Y        | 回调地址，URL |

