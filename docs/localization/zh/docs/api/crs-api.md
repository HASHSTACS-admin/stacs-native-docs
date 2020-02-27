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
- `Permission`:
- `Policy`:
- `KYC`:
- `BD`:
- `Identity`:

## 系统内置function
系统内置BD为SystemBD [系统BD列表](SystemBd.md)

## 系统内置Permission

## 系统内置Policy

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
- [x] 开放
- 接口描述： 执行合约定义的方法，需确保交易提交者具备db定义的permission权限
- 请求地址：`POST`：`/rs/register`
- 请求参数： 
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount
 +snapshotId + functionName 
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

#### CA注册

- [x] 开放
- 接口描述： 将CA上链
- 请求地址：`POST`：`/ca/auth`
- 请求参数： 
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount
 +caList(循环caList拼接顺序 period+domainId+user+usage+pubKey,period格式化格式"yyyy-MM-dd hh:mm:ss"北京时间需要减8个小时)  

- 请求参数：

|    属性        | 类型     | 最大长度 | 必填     | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ----  | -------- | :---------------------------- |
| txId          | `string` |        | Y       | Y        | 交易id                      |
| caList        | `json[]` |        | Y       | Y        | ca集合(签名拼接需要将caList中的每个ca拼接)                      |
| proxyNodeName | `string` |        | Y       | N        | 代理节点                      |

-- caList
| version       | `string` |        | Y       | Y        | 版本号                      |
| period        | `string` |        | Y       | Y        |格式化格式"yyyy-MM-dd hh:mm:ss"北京时间需要减8个小时                      |
| pubKey        | `string` |        | Y       | Y        | 公钥                      |
| user          | `string` |        | Y       | Y        | 节点名称                      |
| domainId      | `string` |        | Y       | Y        | domain                      |
| usage         | `string` |        | Y       | Y        | biz/consensus                      |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :-------------------------|
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"caList":[
		{
			"domainId":"FORT-CAPITAL",
			"period":1579343411360,
			"pubKey":"048cd341689539e91f3a74fb66060ffa11afb6f8cdc1f5ef79f962a90b0aa7ee9c233a263ae6be1a92ed4742c027a7ffcee677d34415574e7632375f474d0c93bc",
			"usage":"biz",
			"user":"Node-d",
			"version":"1.0.0"
		},
		{
			"domainId":"FORT-CAPITAL",
			"period":1579343411402,
			"pubKey":"045164d0cb674adeb461d3fb9e88217824ed0663bb8858a245c47362bdfcc9fad65515cb95f9b1123a1b62f6ab4bf6612d0b950caf6f384abc43b5610f4fdd78b4",
			"submitter":"9056d67b-7b83-4d04-8524-dcd86408881b1234",
			"submitterSign":"9056d67b-7b83-4d04-8524-dcd86408881b1234",
			"usage":"consensus",
			"user":"Node-d",
			"version":"1.0.0"
		}
	],
	"execPolicyId":"CA_AUTH",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"CA_AUTH",
	"proxyNodeName":null,
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"018e63a4c83e339417e0c85d9355fee1e62907cfdc0dfec0a45d3bb0fe13c1793e0828709351ab0cb3b76e88a13c1ad11841c54d376c071039ec6e4bfc4faa4e3f",
	"txId":"9a2b9cfb143acccd49ece0b5b6fa8474c97a6e414e099bcb031da085c2fca80b"
} 
```

```json tab="响应实例"
{"data":null,"msg":"Success","respCode":"000000","success":true}  
```

#### CA更新
- [x] 开放
- 接口描述： 更新CA
- 请求地址：`POST`：`ca/update`
- 请求参数： 
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount
 +caList(循环caList拼接顺序 period+domainId+user+usage+pubKey,period格式化格式"yyyy-MM-dd hh:mm:ss"北京时间需要减8个小时)  

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| period | `string` | 64     | Y    | Y        | 过期时间                      |
| pubKey | `string` | 64     | Y    | Y        | 公钥                      |
| user | `string` | 64     | Y    | Y        | 节点名称                      |
| domainId | `string` | 64     | Y    | Y        | 域                      |
| usage; | `string` | 64     | Y    | Y        | 使用类型biz/consensus                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"domainId":"FORT-CAPITAL",
	"execPolicyId":"CA_UPDATE",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"CA_UPDATE",
	"period":1579343411360,
	"pubKey":"041db72c7828299254ad1163ec8c39e9d33443eaef4b113ec1010e6f4f1b722854a4e8321db3013acbd6a69e1c3f45bf014351554d523d3661157ec169d8b5402c",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"01bbe21608707ce555549f807e1ce41f37defc900919b2ede6011cd672b042ff551b935f4f4792007bc93a9820d5048ae198617eac4e71b6fc89d3e399d2f50bbf",
	"txId":"8eb84689c2098ec00833fdb5ae0382cc8f6f35b8a19aace4573e1897fd1b511c",
	"usage":"biz",
	"user":"Node-d"
} 
```

```json tab="响应实例"
{
	"data":"\"8eb84689c2098ec00833fdb5ae0382cc8f6f35b8a19aace4573e1897fd1b511c\"",
	"msg":"Success",
	"respCode":"000000"
} 
```

#### CA撤销
- [x] 开放
- 接口描述： 撤销CA，设置CA为不可用
- 请求地址：`POST`:`/ca/cancel`
- 请求参数： 
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount
 +domainId+user+usage+pubKey

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| pubKey | `string` | 64     | Y    | Y        | 公钥                      |
| user | `string` | 64     | Y    | Y        | 节点名称                      |
| domainId | `string` | 64     | Y    | Y        | 域                      |
| usage; | `string` | 64     | Y    | Y        | 使用类型biz/consensus                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"domainId":"FORT-CAPITAL",
	"execPolicyId":"CA_CANCEL",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"CA_CANCEL",
	"pubKey":"041db72c7828299254ad1163ec8c39e9d33443eaef4b113ec1010e6f4f1b722854a4e8321db3013acbd6a69e1c3f45bf014351554d523d3661157ec169d8b5402c",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"0025dff49f9383d8d5ca09aabae0390536546759d82658ca7d536214012091c7fb51d898a376fa6d2f1c95ee57e0b28be90be378af28706256c44a4706bcb07dec",
	"txId":"3865a759f1308b370074bf34a21f87016f23f566c428b80bf1b7afc5515b0703",
	"usage":"biz",
	"user":"Node-d"
} 
```

```json tab="响应实例"
{
	"data":"\"3865a759f1308b370074bf34a21f87016f23f566c428b80bf1b7afc5515b0703\"",
	"msg":"Success",
	"respCode":"000000"
} 
```


### 节点

#### 节点加入
- [x] 开放
- 接口描述： 节点加入共识网络
- 请求地址：`POST`：`/node/join`
- 请求参数：
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount
 +nodeName+domainId+signValue+pubKey+functionName 


|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
 | nodeName  | `string` |          | Y    | Y        | 加入的节点名称 |
  | domainId  | `string` |          | Y    | Y        |   domain域             |
  | signValue | `string` |          | Y    | Y        |                |
  |  pubKey   | `string` |          | Y    | Y        | 节点公钥       |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |


- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"domainId":"FORT-CAPITAL",
	"execPolicyId":"NODE_JOIN",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"NODE_JOIN",
	"nodeName":"Node-d",
	"pubKey":"04ba98bf34af47145cf552b710570538b37bf3eff124e51c3361d02ea128c0447737be86077667feaca6dbc0679ae0653c4887d328a2b9d6d7f777599c287bf054",
	"sign":"005a086c04657767f395744c13d3e7eced587f95fa71e2735e4f020b3aee5c339715dd8e329a50bd90a3f17c01925cdc988a3264dbcb95d3abb7c31d29bf2758bb",
	"signValue":"4c34be99e70917f2c8ecf0c9a6111e108cbd36180bd161a9468e56a05a8e72c5SystemBDNODE_JOINNode-dFORT-CAPITALFORT-CAPITALNode-d04ba98bf34af47145cf552b710570538b37bf3eff124e51c3361d02ea128c0447737be86077667feaca6dbc0679ae0653c4887d328a2b9d6d7f777599c287bf05404ba98bf34af47145cf552b710570538b37bf3eff124e51c3361d02ea128c0447737be86077667feaca6dbc0679ae0653c4887d328a2b9d6d7f777599c287bf054NODE_JOIN",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"01be5c031f1c1fa055fffffd16573635794c9b07557eb7cec79692f933ab0907351b4e67e5e9fee951878341430c8fec65b06c8b9fed7cb96f91a4ca3524fc1ee4",
	"txId":"4c34be99e70917f2c8ecf0c9a6111e108cbd36180bd161a9468e56a05a8e72c5"
} 
```

```json tab="响应实例"
{
	"data":null,
	"msg":"Success",
	"respCode":"000000"
} 
```




#### 节点离开

- [x] 开放
- 接口描述： 节点离开
- 请求地址：`POST`：`/node/level`
- 请求参数：
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount
 +nodeName+domainId+signValue+pubKey+functionName 


|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
 | nodeName  | `string` |          | Y    | Y        | 加入的节点名称 |
  | domainId  | `string` |          | Y    | Y        |   domain域             |
  | signValue | `string` |          | Y    | Y        |                |
  | sign | `string` |          | Y    | Y        |            对signValue的签名    |
  |  pubKey   | `string` |          | Y    | Y        | 节点公钥       |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |


- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"domainId":"Domain",
	"execPolicyId":"NODE_LEAVE",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"NODE_LEAVE",
	"nodeName":"Node-g12",
	"pubKey":"04ba98bf34af47145cf552b710570538b37bf3eff124e51c3361d02ea128c0447737be86077667feaca6dbc0679ae0653c4887d328a2b9d6d7f777599c287bf054",
	"sign":"002d678597d5b2402cc37bf836efe9a7f122ca7687231aeb6db4b0efee3e92aaa26aedcd6d68e08d77aadfc8f72d89b328505a4f36444b09b9df888c533d721057",
	"signValue":"1111111111",
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"00d538eb51258ef8972ced6565442a0885d3d3a8bb9d63e240e7123636011c2f406b33c5ba7a420031da602caff355d74170ab8ba3e303fd6c3cf57dc7d5c7752f",
	"txId":"f23329f0d855b525b301c9054fe05b38d97478c91a0b60a01300cb31fe473c25"
} 
```

```json tab="响应实例"
{
	"data":null,
	"msg":"Success",
	"respCode":"000000"
} 
```

##### Policy注册

- [x] 开放
- 接口描述： 注册Policy
- 请求地址：`POST`:`/policy/register`
- 请求参数：
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount
 +policyId+policyName+votePattern+desc+[verifyNum+mustDomainIds+expression]+domainIds+requireAuthIds+functionName 


|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| policyId       | `string`       | 32       | Y    | Y        | 注册的policyId                               |
| policyName     | `string`       | 64       | Y    | Y        |                                              |
| votePattern    | `string`       |          | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| callbackType   | `string`       |          | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
| decisionType   | `string`       |          | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| domainIds      | `list<string>` |          | Y    | Y        | 参与投票的domainId列表                       |
| requireAuthIds | `list<string>` |          | N    | Y        | 需要通过该集合对应的rs授权才能修改当前policy |
| assignMeta | `json` |          | N    | Y        | 当decisionType=ASSIGN_NUM,assignMeta属性值需要签名 |

- assignMeta结构
| verifyNum | `int` |          | N    | Y        | 当decisionType=ASSIGN_NUM时签名需要, the number to verify  |
| expression | `string` |          | N    | Y        | 当decisionType=ASSIGN_NUM时签名需要,the expression for vote rule example: n/2+1 |
| mustDomainIds | `list<string>` |          | N    | Y        |当decisionType=ASSIGN_NUM时签名需要  |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |


- 实例：

```json tab="请求实例"
{
	"assignMeta":{
		"expression":"n/2+1",
		"mustDomainIds":null,
		"verifyNum":1
	},
	"bdCode":"SystemBD",
	"callbackType":"ALL",
	"decisionType":"FULL_VOTE",
	"domainIds":[
		"Domain"
	],
	"execPolicyId":"REGISTER_POLICY",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"REGISTER_POLICY",
	"policyId":"P_",
	"policyName":"P_-name",
	"requireAuthIds":[],
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"015bcf8f804fec7835676d594899cf6643a5fe4ac3c586dfa6f89842e756234862514719c31a043eca395256e03707e228f7cdb15daeb0e9de2545d2c4ecbea304",
	"txId":"92904f2ed902d1a4b7c2442d302fd098fbbf6aee071b8179d51c885cfabe87ce",
	"votePattern":"SYNC"
} 
```

```json tab="响应实例"
{
	"data":null,
	"msg":"Success",
	"respCode":"000000"
} 
```

##### Policy更新
- [x] 开放
- 接口描述： 修改Policy
- 请求地址：`POST`:`/policy/modify`
- 请求参数：
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount
 +policyId+policyName+votePattern+desc+[verifyNum+mustDomainIds+expression]+domainIds+requireAuthIds+functionName 


|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| policyId       | `string`       | 32       | Y    | Y        | 注册的policyId                               |
| policyName     | `string`       | 64       | Y    | Y        |                                              |
| votePattern    | `string`       |          | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| callbackType   | `string`       |          | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
| decisionType   | `string`       |          | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| domainIds      | `list<string>` |          | Y    | Y        | 参与投票的domainId列表                       |
| requireAuthIds | `list<string>` |          | N    | Y        | 需要通过该集合对应的rs授权才能修改当前policy |
| assignMeta | `json` |          | N    | Y        | 当decisionType=ASSIGN_NUM,assignMeta属性值需要签名 |

- assignMeta结构
| verifyNum | `int` |          | N    | Y        | 当decisionType=ASSIGN_NUM时签名需要, the number to verify  |
| expression | `string` |          | N    | Y        | 当decisionType=ASSIGN_NUM时签名需要,the expression for vote rule example: n/2+1 |
| mustDomainIds | `list<string>` |          | N    | Y        |当decisionType=ASSIGN_NUM时签名需要  |



- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |

- 实例：

```json tab="请求实例"
{
	"assignMeta":{
		"expression":"n/2+1",
		"mustDomainIds":null,
		"verifyNum":1
	},
	"bdCode":"SystemBD",
	"callbackType":"ALL",
	"decisionType":"FULL_VOTE",
	"domainIds":[
		"Domain"
	],
	"execPolicyId":"MODIFY_POLICY",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"MODIFY_POLICY",
	"policyId":"P_ID_873",
	"policyName":"P_ID_873-name",
	"requireAuthIds":[],
	"submitter":"177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
	"submitterSign":"006f17de9fe8a791c2e90f0e5207069adad3d531236946d332c499a56aa857026f2896183ff1f9b8028ea20be4184febd70fa86ee24017a3601d61c4d98a622f0a",
	"txId":"fc180d4f1fe7ed3d5cccabcad3b9c8205f4c7c6d9ec7e5395274c786b4a1a223",
	"votePattern":"SYNC"
} 
```

```json tab="响应实例"
{
	"data":null,
	"msg":"Success",
	"respCode":"000000"
} 
```

## 非系统级接口

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
#### BD

##### BD发布
- [x] 开放
- 接口描述：  功能：发布自定义`BD`
   1. 所有类型的交易都需要指定`bdCode`,系统内置`BD`参考()；
   2. 发布BD使用用到的`Policy`和`execPermission`，链上必须存在（参考`注册Permission`和`注册Policy`功能）
   3. 如果发布`bdType`类型为`assets`或`contract`,那么后续发布的合约必须满足该`BD`的`functions`规范；
   4. 如果发布的`bdType`为`system`,那么`BD`的`functions`中定义的`name`只能是系统内置的`function`;
- functionName：`BD_PUBLISH`
- 请求参数： 
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount
 +code+name+bdType+desc+initPermission + initPolicy + bdVersion + functions + functionName 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| code      | `string` | 32     | Y    | Y        | BD编号（唯一）                      |
| name      | `string` | 64     | Y    | Y        | BD名称                      |
| bdType    | `string` | 32     | Y    | Y        | BD类型（/system/contract/assets）                      |
| desc      | `string` | 1024     | N    | Y        | 描述                      |
| functions | `json[]` |      | Y    | Y        | bd定义function (字符串拆分逗号分隔拼接)                     |
| initPermission | `string` | 64     | Y    | Y        | 初始化BD的业务需要permission                      |
| initPolicy | `string` | 32     | Y    | Y        | 初始化BD的业务需要policy策略                     |
| bdVersion | `string` | 4     | Y    | Y        | bd版本                     |

function定义:如果bdType为assets，functions必须包含(uint256) balanceOf(address)和(uint256) balanceOf(address)

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:    | -------- | -------- | ---- | -------- | :---------------------------- |
| desc           | `string` | 256     | N    | Y        | function描述                     |
| execPermission | `string` | 64     | Y    | Y        | 执行function权限,发布bd时，该function已经存在于链上                      |
| execPolicy     | `string` | 32     | Y    | Y        | 执行function policy,发布bd时，该policy已经存在于链上                      |
| methodSign     | `string` | 64     | Y    | Y        | 如果dbType类型为(contract/assets),则为方法签名                      |
| name           | `string` | 64     | Y    | Y        | function名称在同一个bd下不能重复                      |
| type           | `string` | 64     | Y    | Y        | (SystemAction/Contract/ContractQuery)             |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
	"bdCode":"SystemBD",
	"bdType":"assets",
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
- 请求参数： （无需签名）

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| bdCode          | `string`     | 32     | N    | N        | 查询的BD                     |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| bdType | `string` | 32     | Y    | Y        | bd类型(system/contract/assets)                      |
| code | `string` | 32     | Y    | Y        | BD的code，唯一                     |
| desc | `string` | 1024     | Y    | Y        | 描述                     |
| functions | `JSONArray` | 4082     | Y    | Y        | bd定义的支持的function申明|
| initPermission | `string` | 64     | Y    | Y        | 发布BD时，发布者需要具备的权限                      |
| initPolicy | `string` | 64     | Y    | Y        | 发布BD时，发布执行的policy策略    |
| name | `string` | 64     | Y    | Y        | BD名称                      |
| bdVersion | `string` | 4     | Y    | Y        | BD版本号                     |
- 实例：

``` tab="请求实例"
/bd/query?bdCode=
```

```json tab="响应实例"
{
	"data":[
		{
			"bdType":"assets",
			"bdVersion":"1.0",
			"code":"CBD_SC_87716",
			"createTime":1576152885920,
			"desc":null,
			"functions":"[{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"transfer(address,uint256)\",\"name\":\"transfer\",\"type\":\"Contract\"},{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"transferToContract(uint256,uint256,address,string)\",\"name\":\"transferToContract\",\"type\":\"Contract\"},{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"balanceOf(address)\",\"name\":\"balanceOf\",\"type\":\"Contract\"},{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"additionalIssue(uint256)\",\"name\":\"additionalIssue\",\"type\":\"Contract\"},{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"buybackPay(address[],uint256[])\",\"name\":\"buybackPay\",\"type\":\"Contract\"},{\"desc\":\"\",\"execPermission\":\"CONTRACT_INVOKE\",\"execPolicy\":\"CONTRACT_INVOKE\",\"methodSign\":\"settlPay(address[],uint256[])\",\"name\":\"settlPay\",\"type\":\"Contract\"}]",
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
- 请求地址：`POST`:`/snapshot/build`
- 请求参数： 
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount+ snapshotId + functionName 
 
|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| snapshotId | `string` | 64     | Y    | Y        | 快照id                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"

	"bdCode":"SystemBD",
	"execPolicyId":"BUILD_SNAPSHOT",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"functionName":"BUILD_SNAPSHOT",
	"snapshotId":"28829",
	"submitter":"323c1e309841d2feb683b1227658de77d90406bf",
	"submitterSign":"00c2fff5aeeb03cf0d77badbf71841169540856f387fb31f6797021ea78961e4de505cb1269626568f62f876861de7e99494be704961153dae2ba6012934246abd",
	"txId":"541dadd6cb406a8206c6e3ea5979a52a30786ccf7480f5ec598c452e0a23c549"
} 
```

```json tab="响应实例"
{
	"data":"\"541dadd6cb406a8206c6e3ea5979a52a30786ccf7480f5ec598c452e0a23c549\"",
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
       
#### 智能合约

##### 部署

- [x] 开放
- 接口描述：用户发布自定义合约实现业务
- 请求地址：`POST`:`/contract/deploy`
- 请求参数：
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount+ fromAddr + contractAddress +  name + symbol + extension + functionName


| 属性            | 类型       | 最大长度 | 必填 | 是否签名 | 说明                       |
| --------------- | ---------- | -------- | ---- | -------- | -------------------------- |
| fromAddr        | `string`   | 40       | Y    | Y        | 提交者地址                 |
| contractAddress | `string`   | 40       | Y    | Y        | 合约地址 |
| name            | `string`   | 64       | Y    | Y        | 合约名称                   |
| symbol          | `string`   | 64       | Y    | Y      | 合约简称                   |
| extension       | `string`   | 1024     | N    | Y        | 扩展属性                   |
| contractor      | `string`   |          | Y    | N        | 合约构造器(函数)名         |
| sourceCode      | `string`   |          | Y    | N        | 合约代码                   |
| initArgs        | `object[]` |          | Y    | N        | 合约构造入参（签名时需使用逗号分隔拼接(参见StringUtils.join(args,",")),如果参数中包含数组，数组请使用JSONArray来装）              |

- 响应参数：

| 属性            | 类型       | 最大长度 | 必填 | 是否签名 | 说明                       |
| --------------- | ---------- | -------- | ---- | -------- | ---------------------|
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：
```json tab="请求实例"
{
	"bdCode":"CBD_SC_50954",
	"contractAddress":"becb1870d5a0a6ea0e9d8cceafb58c40292f04bb",
	"contractor":"StandardCurrency(address,string,string,uint,uint8,string)",
	"execPolicyId":"CONTRACT_ISSUE",
	"extension":"{\"a\":1}",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"fromAddr":"1b3c3dd36e37478ffa73e86816b20a1c12a57fa4",
	"functionName":"CREATE_CONTRACT",
	"initArgs":[
		"1b3c3dd36e37478ffa73e86816b20a1c12a57fa4",
		"S_50954",
		"S_50954_Name",
		100000000000000,
		8,
		"00000000000000000000000000000000000000000000000000000074785f6964"
	],
	"name":"StandardCurrency",
	"sourceCode":"pragma solidity ^0.4.24;\n\n\n//This smart contact is generated for  #name#\ncontract Common {\n    bytes32 constant STACS_ADDR = bytes32(0x5354414353000000000000000000000000000000000000000000000000000001);\n    bytes32 constant  POLICY_ID = bytes32(0x0000000000000000000000000000000000000000000000706f6c6963795f6964);\n    bytes32 constant TX_ID = bytes32(0x00000000000000000000000000000000000000000000000000000074785f6964);\n    bytes32 constant MSG_SENDER = bytes32(0x000000000000000000000000000000000000000000004d53475f53454e444552);\n    event Bytes32(bytes32);\n    event UintLog(uint, uint);\n    event Bytes(bytes);\n    event Address(address);\n    event String(string);\n\n    bytes32 policyId;\n\n    function updatePolicyId(string newPolicyIdStr) public returns (bool success);\n\n    function getPolicyId() public view returns (bytes32){\n        return policyId;\n    }\n\n    function recovery(bytes sig, bytes32 hash) public pure returns (address) {\n        bytes32 r;\n        bytes32 s;\n        uint8 v;\n        //Check the signature length\n        require(sig.length == 65, \"signature length not match\");\n\n        // Divide the signature in r, s and v variables\n        assembly {\n            r := mload(add(sig, 32))\n            s := mload(add(sig, 64))\n            v := byte(0, mload(add(sig, 96)))\n        }\n        // Version of signature should be 27 or 28\n        if (v < 27) {\n            v += 27;\n        }\n        //check version\n        if (v != 27 && v != 28) {\n            return address(0);\n        }\n        return ecrecover(hash, v, r, s);\n    }\n\n    function hexStr2bytes(string data) public pure returns (bytes){\n        bytes memory a = bytes(data);\n        require(a.length > 0, \"hex string to bytes error, hex string is empty\");\n        uint[] memory b = new uint[](a.length);\n\n        for (uint i = 0; i < a.length; i++) {\n            uint _a = uint(a[i]);\n\n            if (_a > 96) {\n                b[i] = _a - 97 + 10;\n            }\n            else if (_a > 66) {\n                b[i] = _a - 65 + 10;\n            }\n            else {\n                b[i] = _a - 48;\n            }\n        }\n\n        bytes memory c = new bytes(b.length / 2);\n        for (uint _i = 0; _i < b.length; _i += 2) {\n            c[_i / 2] = byte(b[_i] * 16 + b[_i + 1]);\n        }\n        return c;\n    }\n\n    function getContextIdByKey(bytes32 key) internal returns (bytes32 contextPolicyId){\n        emit Bytes32(key);\n        bytes32 output = getContextParam(key, 32, STACS_ADDR);\n        require(output.length > 0, \"output is empty\");\n        return output;\n    }\n\n    function getContextParam(bytes32 input, uint outputSize, bytes32 precompliedContractAddr) internal returns (bytes32){\n        bytes32[1] memory inputs;\n        inputs[0] = input;\n        bytes32 stacs_addr = precompliedContractAddr;\n        bytes32[1] memory output;\n        assembly{\n            let success := call(//This is the critical change (Pop the top stack value)\n            0, //5k gas\n            stacs_addr, //To addr\n            0, //No value\n            inputs,\n            32,\n            output,\n            outputSize)\n        }\n        emit Bytes32(output[0]);\n        return output[0];\n    }\n\n    function stringToBytes32(string memory source) public pure returns (bytes32 result) {\n        bytes memory tempEmptyStringTest = bytes(source);\n        if (tempEmptyStringTest.length == 0) {\n            return 0x0;\n        }\n        assembly {\n            result := mload(add(source, 32))\n        }\n    }\n\n    function splitBytes(bytes strBytes, uint start, uint length) public pure returns (bytes){\n        require(strBytes.length > 0, \"input bytes length is 0\");\n        bytes memory b = new bytes(length);\n        for (uint i = 0; i < length; i++) {\n            b[i] = strBytes[start + i];\n        }\n        return b;\n    }\n\n    function bytesToAddress(bytes bys) internal pure returns (address addr) {\n        require(bys.length == 20, \"bytes to address error. input bytes length is not 20\");\n        assembly {\n            addr := mload(add(bys, 20))\n        }\n    }\n\n    function bytesToBytes32(bytes bytes_32) public pure returns (bytes32 result){\n        require(bytes_32.length == 32, \"input bytes length must is 32\");\n        assembly {\n            result := mload(add(bytes_32, 32))\n        }\n    }\n\n    function hexStringToBytes32(string hexString) public pure returns (bytes32 result){\n        bytes memory hexStringBytes = bytes(hexString);\n        require(hexStringBytes.length == 64, \"hex String length must is 64\");\n        return bytesToBytes32(hexStr2bytes(hexString));\n    }\n\n    function verifyPolicyId() internal returns (bool){\n        bytes32 contextPolicyId = getContextIdByKey(POLICY_ID);\n        emit Bytes32(contextPolicyId);\n        emit Bytes32(policyId);\n        require(contextPolicyId == policyId, \"policyId failed validation\");\n        return true;\n    }\n\n    //assemble the given address bytecode. If bytecode exists then the _addr is a contract.\n    function isContract(address _addr) public view returns (bool is_contract) {\n        uint length;\n        assembly {\n        //retrieve the size of the code on target address, this needs assembly\n            length := extcodesize(_addr)\n        }\n        return (length > 0);\n    }\n\n    function getContextParam2(bytes32 input, uint outputSize, bytes32 precompliedContractAddr) internal returns (bytes32){\n        bytes32[1] memory inputs;\n        inputs[0] = input;\n        bytes32 stacs_addr = precompliedContractAddr;\n        bytes32[1] memory output;\n        assembly{\n            let success := call(\n            0,\n            stacs_addr,\n            0,\n            inputs,\n            32,\n            output,\n            outputSize)\n        }\n        return output[0];\n    }\n\n    //get context sender\n    function getContextSender() internal returns (address){\n        //通过使用增强的预编译合约验证，originalAddress是否是最原始交易的sender\n        bytes32 output = getContextParam2(MSG_SENDER, 32, STACS_ADDR);\n        return address(output);\n    }\n}\n\n\n//This smart contact is generated for  #name#\ncontract StandardToken is Common {\n    address issuerAddress;\n    address ownerAddress;\n    string tokenName;\n    string tokenSymbol;\n    uint totalSupplyAmount;\n    uint8 decimalsDigit;\n\n\n    function issuerAddr() public view returns (address){\n        return issuerAddress;\n    }\n\n    function ownerAddr() public view returns (address){\n        return ownerAddress;\n    }\n\n    function name() public view returns (string){\n        return tokenName;\n    }\n\n    function symbol() public view returns (string){\n        return tokenSymbol;\n    }\n\n    function decimals() public view returns (uint8){\n        return decimalsDigit;\n    }\n\n    function totalSupply() public view returns (uint256){\n        return totalSupplyAmount;\n    }\n\n\n\n    function transfer(address _to, uint256 _value) public payable returns (bool success);\n\n    function transferFrom(address _from, address _to, uint256 _value) internal returns (bool);\n\n    function recoverToken(address _from, address _to, uint256 _value) public payable returns (bool success);\n\n    function additionalIssue(uint num) public returns (bool success);\n\n    event Transfer(address indexed from, address indexed to, uint256 value);\n\n    function updatePolicyId(string newPolicyIdStr) public returns (bool success){\n        require(verifyPolicyId());\n        //update policyId\n        bytes32 newPolicyId = hexStringToBytes32(newPolicyIdStr);\n        policyId = newPolicyId;\n        return true;\n    }\n\n    function settlPay(address[] _addrs, uint256[] _values) public returns (bool success){\n        require(_addrs.length == _values.length);\n        require(_addrs.length > 0, \"address array length is 0\");\n\n        for (uint16 i = 0; i < _addrs.length; i++) {\n            transferFrom(msg.sender, _addrs[i], _values[i]);\n        }\n        return true;\n    }\n\n    function buybackPay( address[] _addrs, uint256[] _payValues)public returns (bool success){\n        require(_addrs.length == _payValues.length,\"addr length not eq value length\");\n\n        for (uint16 i = 0; i < _addrs.length; i++) {\n            transferFrom(getContextSender(), _addrs[i], _payValues[i]);\n        }\n        return true;\n    }\n}\n\n\n//This smart contact is generated for  #name#\ninterface TokenReceiver {\n    /// @param _payment stable token payment of subscribe token\n    /// @param _amount The amount of token to be transferred\n    /// @return success whether the contract method invoke is successful\n    function receiveToken(uint256 _payment, uint256 _amount) external returns (bool success);\n\n    ///@return offerAddress the address of contract offer\n    function tokenOwnerAddress() external view returns (address offerAddress);\n\n    function symbol() external view returns (string);\n}\n\n\n//This smart contact is generated for  #name#\ncontract StandardCurrency is StandardToken {\n\n    constructor (\n        address _ownerAddr,\n        string _tokenName,\n        string _tokenSymbol,\n        uint _totalSupply,\n        uint8 _decimals,\n        string _policyId\n    ) public {\n        ownerAddress = _ownerAddr;\n        issuerAddress = msg.sender;\n        tokenName = _tokenName;\n        tokenSymbol = _tokenSymbol;\n        decimalsDigit = _decimals;\n        totalSupplyAmount = _totalSupply;\n        balance[ownerAddress] = totalSupplyAmount;\n        policyId = hexStringToBytes32(_policyId);\n        emit Bytes32(policyId);\n    }\n\n    mapping(address => uint) balance;\n\n    function balanceOf(address _owner) public view returns (uint256 balanceAmount){\n        balanceAmount = balance[_owner];\n        return (balanceAmount);\n    }\n\n    function getBalance(address _owner) internal view returns (uint){\n        return balance[_owner];\n    }\n\n    function additionalIssue(uint num) public returns (bool){\n        require(false, \"standard currency temporarily do not support additional issuance\");\n        //        require(verifyPolicyId());\n        //        bytes32 txId = getContextIdByKey(TX_ID);\n        //        bytes32 sourceHash = getAdditionalIssueSourceHashInner(txId, msg.sender, num);\n        //        require(verifySpecifiedAddressSig(issuerAddress,sourceHash, signature));\n        //        totalSupplyAmount += num;\n        //        balance[ownerAddress] += num;\n        return false;\n    }\n\n    function transfer(address _to, uint256 _value) public payable returns (bool success){\n        require(msg.sender != 0x0, \"from address is 0x0\");\n        return transferFrom(msg.sender, _to, _value);\n    }\n\n    function batchTransfer(address[] _addrs, uint256[] _values) public returns (bool success){\n        require(_addrs.length == _values.length);\n        require(_addrs.length > 0, \"address array length is 0\");\n\n        for (uint16 i = 0; i < _addrs.length; i++) {\n            transferFrom(msg.sender, _addrs[i], _values[i]);\n        }\n        return true;\n    }\n    function recoverToken(address _from, address _to, uint256 _value) public payable returns (bool success){\n        require(msg.sender != 0x0, \"msg.sender address is 0x0\");\n        return transferFrom(_from, _to, _value);\n    }\n\n    function transferFrom(address _from, address _to, uint256 _value) internal returns (bool){\n        require(_to != 0x0, \"to address is 0x0\");\n        require(_value > 0, \"the value must be that is greater than zero.\");\n        require(balance[_from]  >= _value, \"balance not enough\");\n        require(balance[_to] + _value >= balance[_to], \"to address balance overflow\");\n        uint previousBalance = balance[_from] + balance[_to];\n        balance[_from] -= _value;\n        balance[_to] += _value;\n        emit Transfer(_from, _to, _value);\n        assert(balance[_from] + balance[_to] == previousBalance);\n\n        return true;\n    }\n\n    /// @param _to The address of the contract\n    /// @param token use verify sign\n    /// @param _payment cost of stable token to subscribe\n    /// @param _amount The amount of token to be transferred/// @param _amount The amount of token to be transferred\n    /// @return Whether the subscribe is successful or not\n    function transferToContract(uint256 _payment, uint256 _amount,address _to, string token ) public returns (bool success) {\n        emit UintLog(_payment,getBalance(msg.sender));\n        require(_payment <= getBalance(msg.sender), \"standard currency balance not enough\");\n        require(_to != address(0), \"to address illegal\");\n        require(isContract(_to), \"unstable currency contract address does not exist\");\n\n        TokenReceiver tokenReceiver = TokenReceiver(_to);\n        require(keccak256(tokenReceiver.symbol()) == keccak256(token), \"the token symbol not equals\");\n\n        address contractOfferAddress = tokenReceiver.tokenOwnerAddress();\n        success = transferFrom(msg.sender, contractOfferAddress, _payment);\n        if (success) {\n            success = tokenReceiver.receiveToken(_payment, _amount);\n            emit RechangeSuccess(msg.sender, success);\n            if (!success) {\n                rollbackTransfer(msg.sender, contractOfferAddress, _payment);\n            }\n        }\n        return success;\n    }\n\n    // rollback of transfer when failure\n    function rollbackTransfer(address _from, address _to, uint _value) private {\n        balance[_to] -= _value;\n        balance[_from] += _value;\n        emit RollbackTransfer(_to, _from, _value);\n    }\n\n\n    event RechangeSuccess(address indexed _to, bool success);\n    event RollbackTransfer(address indexed _from, address indexed _to, uint256 _value);\n}",
	"submitter":"1b3c3dd36e37478ffa73e86816b20a1c12a57fa4",
	"submitterSign":"01b8c3509b70758de076bc3850d4ae00f77a4ed5d37ce7e639a8a98aaf4b5c194841f2131d3063328310ee9498086baeb8dcfcd22187cc3fc5746c6fd5eb6b7ecf",
	"symbol":"S_50954",
	"txId":"4a7bc3a9b86583818b94a5de346fce29047f88a07e773a47c70701f5bb2f7f32"
} 
```

```json tab="响应实例"
{
	"data":"\"4a7bc3a9b86583818b94a5de346fce29047f88a07e773a47c70701f5bb2f7f32\"",
	"msg":"Success",
	"respCode":"000000"
} 
```

##### 执行
- [x] 开放
- 接口描述： 执行合约定义的方法，需确保交易提交者具备db定义的permission权限
- 请求地址：`POST`:`/contract/invoke`
- 请求参数： 
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount+ methodSignature + from +  to + args + functionName

|    属性         | 类型          | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:    | --------     | -------- | ---- | -------- | :---------------------------- |
| value          | `bigDecimal` |      | Y    | Y        | 转入合约金额(为null)                      |
| methodSignature| `string`     |      | Y    | Y        | 方法执行的方法abi((uint) balanceOf(address))   |
| args           | `object[]`   |      | Y    | Y        | 方法执行入参参数，（签名时需使用逗号分隔拼接(参见StringUtils.join(args,",")),如果参数中包含数组，数组请使用JSONArray来装）       |
| from           | `string`     |      | Y    | Y        | 同交易提交地址                     |
| to             | `string`     |      | Y    | Y        | 执行的合约地址                     |
| remark         | `string`     |      | N    | Y        | 备注存证                     |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"
{
	"args":[
		"e966fe88795f4ff5b772475efea405631e644f59",
		20
	],
	"bdCode":"CBD_SC_50954",
	"execPolicyId":"CONTRACT_INVOKE",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"from":"1b3c3dd36e37478ffa73e86816b20a1c12a57fa4",
	"functionName":"transfer",
	"methodSignature":"(bool) transfer(address,uint256)",
	"submitter":"1b3c3dd36e37478ffa73e86816b20a1c12a57fa4",
	"submitterSign":"0161df9af5b9998a8e3bb8b49882d1fc2ba7f32681ed99e74978f4b6c9fa1a5ba77b03f0a5d2314cbeb795ebd4c0e91de5625c130bd204f3246a53102621628cf1",
	"to":"becb1870d5a0a6ea0e9d8cceafb58c40292f04bb",
	"txId":"9584564d326e9cd0a1fe161257c49d2edc973feb43335de54a7ae198d42602a4",
	"value":null
} 
```

```json tab="响应实例"
{
	"data":"\"9584564d326e9cd0a1fe161257c49d2edc973feb43335de54a7ae198d42602a4\"",
	"msg":"Success",
	"respCode":"000000"
} 
```

##### 查询
- [x] 开放
- 接口描述： 链支持可直接调用合约查询方法(不执行交易流程)
- 请求地址：`POST`:`/contract/query`
- 请求参数： （无）

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
|     address     | `string`   | 40       | Y    | N        | 合约地址                               |
| methodSignature | `string`   |          | Y    | N        | 方法签名，eg：`(uint256) get(uint256)` |
|   blockHeight   | `long`     |          | N    | N        | 块高度，高度为null，默认查节点的最高链的最高度                                 |
|   parameters    | `object[]` |          | N    | N        | 方法参数                               |


- 响应参数：响应参数返回类型为对象数组，数组中的参与取决与合约发放返回定义，该例balanceOf方法返回的是uint256类型的值，该值为方法定义方法的余额


|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |

- 实例：

```json tab="请求实例"
{
	"address":"7fc61ef682d44bb74f6a9cce6e423f0277cb1b6c",
	"blockHeight":null,
	"methodSignature":"(uint256) balanceOf(address)",
	"parameters":[
		"f6ff9c931b453543c1514030dfdba444f7f81e64"
	]
}
```

```json tab="响应实例"
{
	"data":[
		0
	],
	"msg":"Success",
	"respCode":"000000"
}  
```

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

##### 查询permission
- [x] 开放
- 接口描述：  
- 请求地址：`GET`:`/permission/queryAll`
- 请求参数： 
- 签名原值拼接排序（无需签名）

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| permissionIndex | `int` | 64     | Y    | Y        | permission编号                  |
| permissionName  | `string` | 64     | Y    | Y        | permission名称               |

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

#### Identity

##### Identity设置

- [x] 开放
- 接口描述：  设置Identity(此接口不能设置KYC信息)
- 请求地址：`POST`:`/identity/setting`
- 请求参数： 
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount + identityType + property + address + functionName

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:  | -------- | -------- | ---- | -------- | :---------------------------- |
| address      | `string` | 40     | Y    | Y        | Identity地址                      |
| hidden       | `int`    | 1      | Y    | Y        | 是否隐藏                      |
| identityType | `string` | 64     | Y    | Y        |  1. user 2. domain 3. node       |
| property     | `string` | 1024   | N    | Y      |  属性json格式       |


- 响应参数：

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| txId | `string` |          | Y    | Y        | 交易id |                           |

- 实例：

```json tab="请求实例"
{
	"address":"4a02aa7f84d01b63b28c81c096f8c2e3feda7df9",
	"bdCode":"SystemBD",
	"execPolicyId":"IDENTITY_SETTING",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"froze":null,
	"functionName":"IDENTITY_SETTING",
	"identityType":"user",
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
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount +identityAddress+ identityType + permissionNames + functionName

|      属性       | 类型       | 最大长度 | 必填 | 是否签名 | 说明                               |
| :-------------: | ---------- | -------- | ---- | -------- | ---------------------------------- |
| identityAddress | `string`   | 40       | Y    | Y        | 新增identity地址                   |
| permissionNames | `string[]` |          | Y    | Y        | 给Identity授权的PermissionName数组(签名拼接时，需要使用逗号进行分割拼接成字符串) |
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
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount 
+identityAddress + permissionNames + functionName

|      属性       | 类型       | 最大长度 | 必填 | 是否签名 | 说明                               |
| :-------------: | ---------- | -------- | ---- | -------- | ---------------------------------- |
| identityAddress | `string`   | 40       | Y    | Y        | 新增identity地址                   |
| permissionNames | `string[]` |          | Y    | Y        | 给Identity撤销授权的PermissionName数组(签名拼接时，需要使用逗号进行分割拼接成字符串) |

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
- 接口描述：冻结某个bdCode，冻结成功后identity无法执行该bdCode的所有function 
- 请求地址：`POST`:`/identity/bdManage`
- 请求参数： 
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount 
+targetAddress + actionType +BDCodes+ functionName

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| targetAddress | `string`   | 40       | Y    | Y        | 目标identity地址              |
|    BDCodes    | `string[]` |          | Y    | Y        | 冻结的bd数组，冻结成功后，identity无法操作冻结bd的所有交易(签名拼接时，需要使用逗号进行分割拼接成字符串)|
|  actionType   | `string`   |          | Y    | Y        | 操作类型： froze:冻结  unfroze:解冻 |

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

##### Identity权限查询

- [x] 开放
- 接口描述：  查询Identity用户所拥有的permission权限
- 请求地址：`GET`:`/identity/permission/query?address={address}`
- 请求参数：接口无需签名 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | N        | 用户地址                     |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| permissionIndex | `int` | 64     | Y    | Y        | 权限编号                      |
| permissionName | `string` | 64     | Y    | Y        | 权限名称                      |
- 实例：

``` tab="请求实例"
/identity/permission/query?address=b187fa1ba0e50a887b3fbd23f0c7f4163300b5f9
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
- 请求参数：(无签名) 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | N        | 用户地址                     |
| permissionNames | `<string[]>` |      | Y    | Y        | 需要检查的权限，数组                     |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| data | `boolean` | 64     | Y    | Y        | 检查结果，成功返回true,失败返回false                      |

- 实例：

``` tab="请求实例"
{
	"address":"b187fa1ba0e50a887b3fbd23f0c7f4163300b5f9",
	"permissionNames":[
		"CONTRACT_INVOKE"
	]
} 
```

```json tab="响应实例"
{
    "data":"true",
    "msg":"Success",
    "respCode":"000000"
}
```

##### 查询Identity

- [x] 开放
- 接口描述：查询Identity的详细信息  
- 请求地址：`GET`:`identity/query?userAddress=${userAddress}`
- 请求参数： （无需签名）

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| userAddress | `string`   | 40       | Y    | Y        | identity地址              |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | Y        | user identity 地址                      |
| currentTxId | `string` | 64     | Y    | Y        |    user identity 改修改时的txId                   |
| froze | `string` | 64     | Y    | Y        | 用户冻结的bd                      |
| hidden | `string` | 1     | Y    | Y        | 1：显示，0：隐藏                      |
| identityType | `string` | 64     | Y    | Y        | identity类型(user/node/domain)                      |
| kYC | `string` |      | Y    | Y        | identity认证信息                      |
| permissions | `string` | 64     | Y    | Y        | 权限编号(32进制)                      |
| preTxId | `string` | 64     | Y    | Y        |  上次identity被修改时交易id                   |
| property | `string` | 64     | Y    | Y        |  扩展属性                   |

- 实例：
```json tab="请求实例"
```

```json tab="响应实例"
{
"data":{
		"address":"f6ff9c931b453543c1514030dfdba444f7f81e64",
		"currentTxId":"92264f3552f54d1db0bded08b943004692aefd2033ad7b43876251cee8187967",
		"froze":null,
		"hidden":1,
		"identityType":"user",
		"kYC":"{\"aaa\":111,\"bbb\":222}",
		"permissions":"1",
		"preTxId":"92264f3552f54d1db0bded08b943004692aefd2033ad7b43876251cee8187967",
		"property":null
	},
	"msg":"Success",
	"respCode":"000000"
} 
```

##### KYC设置

- [x] 开放
- 接口描述：  给Identity设置KYC信息，KYC为json格式，每次设置设置会覆盖之前的KYC信息;identityType会覆盖之前identityType
- 请求地址：`POST`:`/kyc/setting`
- 请求参数：
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount 
+ identityAddress + KYC +identityType+ functionName

|      属性       | 类型     | 最大长度 | 必填 | 是否签名 | 说明                            |
| :-------------: | -------- | -------- | ---- | -------- | ------------------------------- |
| identityAddress | `string` | 40       | Y    | Y        | 目标identity地址                |
| KYC       | `string` | 1024     | Y    | Y        | KYC属性（json字符串，合约目前支持kyc验证）                         |
| identityType   | `string` |          | N    | Y        | 1. user(默认) 2. domain 3. node |

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
- 签名原值拼接排序(feeCurrency,feeMaxAmount如果为null，则字符串拼接为"")：txId + bdCode + execPolicyId+feeCurrency + feeMaxAmount 
+attestation+functionName

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| attestation | `string` | 4096     | Y    | Y        | 存证内容                      |
|   version   | `string` | 20       | Y    | N        | 存证版本                      |
|   remark    | `string` | 1024     | N    | N        | 备注                          |
|  objective  | `string` | 40       | N    | N        | 目标地址，默认使用`submitter` |

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
- 签名原值拼接排序(无需签名)

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

