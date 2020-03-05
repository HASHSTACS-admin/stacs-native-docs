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
- `{}`: 动态值表示符号

## 交易接口列表
| 接口function                                              | 说明 |
| :-----                                                    | :-----    |
|<a href="#BD_PUBLISH">BD_PUBLISH</a>                       |发布BD|
|<a href="#REGISTER_POLICY">REGISTER_POLICY</a>             |注册Policy|
|<a href="#BD_PUBLISH">BD_PUBLISH</a>                       |修改Policy|
|<a href="#MODIFY_POLICY">MODIFY_POLICY</a>                 |给地址做身份认证|
|<a href="#PERMISSION_REGISTER">PERMISSION_REGISTER</a>     |注册Permission|
|<a href="#AUTHORIZE_PERMISSION">AUTHORIZE_PERMISSION</a>   |给地址授权Permission|
|<a href="#KYC_SETTING">KYC_SETTING</a>                     |为Identity设置KYC|
|<a href="#IDENTITY_BD_MANAGE">IDENTITY_BD_MANAGE</a>       |冻结Identity使用BD|
|<a href="#SAVE_ATTESTATION">SAVE_ATTESTATION</a>           |存证交易|
|<a href="#BUILD_SNAPSHOT">BUILD_SNAPSHOT</a>               |快照交易|
|<a href="#CA_AUTH">CA_AUTH</a>                             |注册CA|
|<a href="#CA_CANCEL">CA_CANCEL</a>                         |取消CA|
|<a href="#CA_UPDATE">CA_UPDATE</a>                         |更新CA|
|<a href="#NODE_JOIN">NODE_JOIN</a>                         |节点加入|
|<a href="#REGISTER_RS">REGISTER_RS</a>                     |注册为RS节点|
|<a href="#CANCEL_RS">CANCEL_RS</a>                         |取消RS节点|
|<a href="#SYSTEM_PROPERTY">SYSTEM_PROPERTY</a>             |设置系统属性|
|<a href="#SET_FEE_CONFIG">SET_FEE_CONFIG</a>               |设置费用|
|<a href="#SET_FEE_RULE">SET_FEE_RULE</a>                   |设置费用规则|


## 查询接口列表
| 接口地址                                                          | 说明 |
| :-----                                                           | :-----    |
|<a href="query-api.md#/queryMaxHeight">/queryMaxHeight/{height}</a>              |查询当前最大区块高度|
|<a href="query-api.md#queryTxByTxId/{txId}">queryTxByTxId/{txId}</a>             |根据txId查询交易数据|
|<a href="query-api.md#/queryTxsByHeight/{height}">/queryTxsByHeight/{height}</a> |根据高度查询区块内所有交易数据|
|<a href="query-api.md#/queryContract">/queryContract</a>                 |合约数据状态查询|

## 系统内置function表
| functionName      	| execPermission | execPolicy         	| 备注 |
| :-----                |  :-----        |  :-----             |  :-----            |
| IDENTITY_SETTING  	| DEFAULT        | IDENTITY_SETTING   	|给地址做身份认证      |
| BD_PUBLISH  			| DEFAULT        | BD_PUBLISH   	  	|发布BD      |
| PERMISSION_REGISTER  	| DEFAULT        | PERMISSION_REGISTER  |注册Permission      |
| AUTHORIZE_PERMISSION  | DEFAULT        | AUTHORIZE_PERMISSION |给地址添加Permission      |
| REGISTER_POLICY  		| DEFAULT        | REGISTER_POLICY   	|注册Policy      |
| MODIFY_POLICY  		| DEFAULT        | MODIFY_POLICY   	    |修改Policy      |
| REGISTER_RS  			| DEFAULT        | REGISTER_RS   	    |注册为RS节点      |
| CANCEL_RS  			| RS        	 | CANCEL_RS   	  		|取消RS节点      |
| CA_AUTH  				| DEFAULT        | CA_AUTH   	  		|注册CA      |
| CA_CANCEL  			| RS        	 | CA_CANCEL   	  		|取消CA      |
| CA_UPDATE  			| RS        	 | CA_UPDATE   	  		|更新CA      |
| NODE_JOIN  			| DEFAULT        | NODE_JOIN   	  		|节点加入      |
| NODE_LEAVE  			| RS        	 | NODE_LEAVE   	  	|节点离开      |
| SYSTEM_PROPERTY  		| RS        	 | SYSTEM_PROPERTY   	|设置系统属性      |
| IDENTITY_BD_MANAGE  	| DEFAULT        | IDENTITY_BD_MANAGE  	|冻结Identity使用BD      |
| KYC_SETTING  			| DEFAULT        | KYC_SETTING   	  	|为Identity设置KYC      |
| SET_FEE_CONFIG  		| RS        	 | SET_FEE_CONFIG   	|设置费用      |
| SET_FEE_RULE  		| RS        	 | SET_FEE_RULE   	  	|设置费用规则      |
| SAVE_ATTESTATION  	| DEFAULT        | SAVE_ATTESTATION   	|存证交易      |
| BUILD_SNAPSHOT  		| DEFAULT        | BUILD_SNAPSHOT   	|快照交易      |

## 合约类的function表

| functionName      	| execPermission | execPolicy         	| 备注 |
| :-------------------- |  :-----        |  :-----             |  :--------------------            |
| CONTRACT_CREATION		| 取决于BD定义    | 取决于BD定义   	   |合约创建                            |
| ${functionDefine.name}| 取决于BD定义    | 取决于BD定义   	   |合约中的方法，functionDefine中的name |

## 系统内置Permission表
| Permission      	    | 备注 |
| :-----                |  :-----        |
| DEFAULT  	            | 系统默认所有地址都拥有DEFAULT的Permission       |
| RS  			        | 系统节点初始化时RS节点拥有该Permission        |

## 系统内置Policy表
| Policy       	    |投票方式            |决议方式            |备注                |
| :-----            |  :-----           |  :-----           |:-----           |
|REGISTER_POLICY    |  ASYNC            |FULL_VOTE          |  |
|MODIFY_POLICY    |  ASYNC            |FULL_VOTE          |  |
|REGISTER_RS        |  ASYNC            |FULL_VOTE          |  |
|CANCEL_RS        |  ASYNC            |FULL_VOTE          |  |
|CA_AUTH        |  ASYNC            |FULL_VOTE          |  |
|CA_UPDATE        |  ASYNC            |FULL_VOTE          |  |
|CA_CANCEL        |  ASYNC            |FULL_VOTE          |  |
|NODE_JOIN        |  ASYNC            |FULL_VOTE          |  |
|NODE_LEAVE        |  ASYNC            |FULL_VOTE          |  |
|SET_FEE_CONFIG        |  ASYNC            |FULL_VOTE      |    |

## SDK
更快接入参考SDK提供的`SubmitTransactionExample`实例
``` java

<dependency>
    <groupId>com.hashstacs</groupId>
    <artifactId>stacs-client</artifactId>
    <version>4.1.0-SNAPSHOT</version>
</dependency>

```

## KYC规范

> 

## 接口规范

- HTTP请求头

    *   `GET`：**无额外参数**
    
    *   `POST`:         
        `Content-Type: application/json`  
        `merchantId:{merchantId}`: CRS分配的
        
    
- Http响应状态码 200
  
- 安全性
  
    所有POST请求数据采用AES256加密，并会附上原始数据的签名; 响应数据也同样采用AES256加密，并附上CRS对原始响应数据的签名，加密并签名的数据格式如下：

    - 请求数据格式
    
      |     属性     | 类型     | 说明                                                         |
      | :----------: | -------- | ------------------------------------------------------------ |
      | requestParam | `string` | 请求数据，将原始请求数据采用{merchantAesKey}加密后使用BASE64编码 |
      |  signature   | `string` | 商户签名，将原始请求数据采用{merchantPriKey}签名后的HEX格式数据 |
    
    - 响应数据格式
    
      |   属性    | 类型     | 说明                                                         |
      | :-------: | -------- | ------------------------------------------------------------ |
      | respCode  | `string` | 返回状态码，000000为成功，其他为失败                         |
      |    msg    | `string` | 返回状态描述                                                 |
      |   data    | `string` | 响应数据，将原始响应数据采用{merchantAesKey}加密后使用BASE64编码 |
      | signature | `string` | CRS签名，将原始响应数据采用{crsPriKey}签名后的HEX格式数据   |
    



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
### <a id="requestParam">requestParam参数列表</a>

|     属性     | 类型     | 说明                                                         |
| :----------: | -------- | ------------------------------------------------------------ |
| txData       | `string` | 请求原始数据                                                   |
| txSign       | `string` | 请求原始数据的签名                                            |

```示例：
   {
       "txData":"{"txId":"7c587484f89c91ab6481ea3ccaf581ac2543cf5fcd047816d9b3b7a0361ce28c","bdCode":"SystemBD","functionName":"BD_PUBLISH","submitter":"b8da898d50712ea4695ade4b1de6926cbc4bcfb9","version":"4.0.0","actionDatas":{"datas":{"bdVersion":"4.0.0","code":"sto_code","contracts":[{"createPermission":"DEFAULT","createPolicy":"BD_PUBLISH","desc":"余额查询-1","functions":[{"desc":"余额查询","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(uint256) balanceOf(address)","name":"balanceOf","type":"Contract"},{"desc":"转账","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(bool) transfer(address,uint256)","name":"transfer","type":"Contract"}],"templateCode":"code-balanceOf-1"},{"createPermission":"DEFAULT","createPolicy":"BD_PUBLISH","desc":"余额查询-2","functions":[{"desc":"余额查询","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(uint256) balanceOf(address)","name":"balanceOf","type":"Contract"},{"desc":"转账","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(bool) transfer(address,uint256)","name":"transfer","type":"Contract"}],"templateCode":"code-balanceOf-2"}],"label":"sto_code_name"},"version":"4.0.0"}}",
       "txSign":"017ee57b7567039c214f0b27a186e567277731a95ad09baa84d8092cd8af125c29342a234ea67a0d095a36f63e92b49adb57d66e7909499992ee7eae12bc7451c3"}
   }
```
### <a id="COMMON_PRAMS_LIST">通用参数列表</a>

|     属性      | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| :-----------: | -------- | -------- | ---- | :------: | ------------------------------------------------------------ |
| txId          | `string` | 64       | Y    |    Y     | 请求Id |
| bdCode        | `string` | 32       | Y    |    Y     | 所有业务交易都需要指定bdCode  |
| templateCode  | `string` | 32       | N    |    Y     |发布合约或执行合约方法时的合约templateCode|
| functionName  | `string` | 32       | Y    |    Y     | BD的functionName，如果是BD的初始化或者合约的发布：`CONTRACT_CREATION` |
| submitter     | `string` | 40       | Y    |    Y     | 操作提交者地址                                               |
| actionDatas   | `string` |          | Y    |    Y     | 业务参数JSON格式化数据，json数据包含{"version":"4.0.0","datas":{}}                                               |
| version       | `string` | 40       | Y    |    Y     | 交易版本号                                               |
|extensionDatas | `string` | 1024     | N    |    Y     | 交易存证新消息                                               |
| maxAllowFee   | `string` | 18       | N    |    Y     | 最大允许的手续费                                             |
|  feeCurrency  | `string` | 32       | N    |    Y     | 手续费币种                                                   |
| submitterSign | `string` | 64       | Y    |    N     | 提交者`submitter`的`ECC`对交易的签名,该字段不参与签名                                                   |

###  签名方式
#### 交易签名值拼接方式 
``` java

    /**
     * should sign fields
     */
    private static String[] SIGN_FIELDS = new String[]
        {"txId","bdCode","functionName","templateCode","submitter","version","actionDatas","extensionDatas","maxAllowFee","feeCurrency"};

    public static final String getSignValue(Transaction tx){
        String str = "";
        try {
            StringBuilder sb = new StringBuilder();
            for(String fieldName : SIGN_FIELDS){
                Field f = tx.getClass().getDeclaredField(fieldName);
                f.setAccessible(true);
                Object v = f.get(tx);
                if(v != null && StringUtils.isNotEmpty(String.valueOf(v))){

                    sb.append("\"").append(fieldName).append("\"").append(":");

                    if(!StringUtils.equals(fieldName,"actionDatas")){
                        sb.append("\"");
                    }

                    sb.append(v);

                    if(!StringUtils.equals(fieldName,"actionDatas")){
                        sb.append("\"");
                    }

                    sb.append(SEPARATOR);
                }
            }
            str = sb.toString();
            str = str.substring(0,str.length() - 1);
        } catch (Exception e) {
            log.error("make json has error",e);
        }
        return "{" + str + "}";
    }
  
```

## 系统级接口

!!! info "提示"
    系统级接口只能由`CRS`节点发起，并不对`DRS`节点开放。

### Domain & RS

>   `Domain`管理旗下`RS`节点的接口，让节点可以**注册**到`Domain`中参与交易处理，也可以**移除**`domain`下指定节点

#### <a id="REGISTER_RS">注册RS
- [x] 开放
- 接口描述： 执行合约定义的方法，需确保交易提交者具备db定义的permission权限
- functionName：`REGISTER_RS`
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



#### <a id="CANCEL_RS"/>移除RS</a>

- - [ ] 开放

- 接口描述：  移除已注册的 RS

- functionName：`CANCEL_RS`

- 请求参数： 

  | 属性 | 类型     | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | -------- | -------- | ---- | -------- | ---- |
  | rsId | `string` | 32       | Y    | Y        |      |
  
- 响应参数：

  | 属性 | 类型 | 最大长度 | 必填 | 是否签名 | 说明 |
  | :--: | ---- | -------- | ---- | -------- | ---- |
  |  无  |      |          |      |          |      |


### CA

#### <a id="CA_AUTH"/>CA注册</a>

- [x] 开放
- 接口描述： 将CA上链
- functionName：`CA_AUTH`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ----  | -------- | :---------------------------- |
| txId          | `string` |        | Y       | Y        | 交易id                      |
| caList        | `json[]` |        | Y       | Y        | ca集合(签名拼接需要将caList中的每个ca拼接)                      |
| proxyNodeName | `string` |        | Y       | N        | 代理节点                      |

-- caList
|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ----  | -------- | :---------------- |
| version       | `string` |        | Y       | Y        | 版本号   |
| period        | `string` |        | Y       | Y        |格式化格式"yyyy-MM-dd hh:mm:ss"北京时间需要减8个小时  |
| pubKey        | `string` |        | Y       | Y        | 公钥   |
| user          | `string` |        | Y       | Y        | 节点名称  |
| domainId      | `string` |        | Y       | Y        | domain  |
| usage         | `string` |        | Y       | Y        | biz/consensus      |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :-------------------------|
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"
{
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
	"proxyNodeName":null
} 
```

```json tab="响应实例"
{"data":null,"msg":"Success","respCode":"000000","success":true}  
```

#### <a id="CA_UPDATE"/>CA更新</a>
- [x] 开放
- 接口描述： 更新CA
- functionName：`CA_UPDATE`

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| period | `string` | 64     | Y    | Y        | 过期时间                      |
| pubKey | `string` | 64     | Y    | Y        | 公钥                      |
| user   | `string`   | 64     | Y    | Y        | 节点名称                      |
| domainId | `string` | 64     | Y    | Y        | 域                      |
| usage; | `string` | 64     | Y    | Y        | 使用类型biz/consensus                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"
{
	"domainId":"FORT-CAPITAL",
	"period":1579343411360,
	"pubKey":"041db72c7828299254ad1163ec8c39e9d33443eaef4b113ec1010e6f4f1b722854a4e8321db3013acbd6a69e1c3f45bf014351554d523d3661157ec169d8b5402c",
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

#### <a id="CA_CANCEL">CA撤销</a>
- [x] 开放
- 接口描述： 撤销CA，设置CA为不可用
- functionName：`CA_CANCEL`
- 请求参数： 

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
	"domainId":"FORT-CAPITAL",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"pubKey":"041db72c7828299254ad1163ec8c39e9d33443eaef4b113ec1010e6f4f1b722854a4e8321db3013acbd6a69e1c3f45bf014351554d523d3661157ec169d8b5402c",
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

#### <a id="NODE_JOIN">节点加入</a>
- [x] 开放
- 接口描述： 节点加入共识网络
- functionName：`NODE_JOIN`
- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| nodeName  | `string` |          | Y    | Y        | 加入的节点名称 |
| domainId  | `string` |          | Y    | Y        |   domain域             |
| signValue | `string` |          | Y    | Y        |                |
|  pubKey   | `string` |          | Y    | Y        | 节点公钥       |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------- |
| 	| 	|	|	| | 		|


- 实例：

```json tab="请求实例"
{
	"domainId":"FORT-CAPITAL",
	"feeCurrency":null,
	"feeMaxAmount":null,
	"nodeName":"Node-d",
	"pubKey":"04ba98bf34af47145cf552b710570538b37bf3eff124e51c3361d02ea128c0447737be86077667feaca6dbc0679ae0653c4887d328a2b9d6d7f777599c287bf054",
	"sign":"005a086c04657767f395744c13d3e7eced587f95fa71e2735e4f020b3aee5c339715dd8e329a50bd90a3f17c01925cdc988a3264dbcb95d3abb7c31d29bf2758bb",
	"signValue":"4c34be99e70917f2c8ecf0c9a6111e108cbd36180bd161a9468e56a05a8e72c5SystemBDNODE_JOINNode-dFORT-CAPITALFORT-CAPITALNode-d04ba98bf34af47145cf552b710570538b37bf3eff124e51c3361d02ea128c0447737be86077667feaca6dbc0679ae0653c4887d328a2b9d6d7f777599c287bf05404ba98bf34af47145cf552b710570538b37bf3eff124e51c3361d02ea128c0447737be86077667feaca6dbc0679ae0653c4887d328a2b9d6d7f777599c287bf054NODE_JOIN",
} 
```

```json tab="响应实例"
{
	"data":null,
	"msg":"Success",
	"respCode":"000000"
} 
```




#### <a id="NODE_LEAVE">节点离开</aa>

- [x] 开放
- 接口描述： 节点离开
- functionName：`NODE_LEAVE`
- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| nodeName  | `string` |          | Y    | Y        | 加入的节点名称 |
| domainId  | `string` |          | Y    | Y        |   domain域             |
| signValue | `string` |          | Y    | Y        |                |
| sign | `string` |          | Y    | Y        |            对signValue的签名    |
|  pubKey   | `string` |          | Y    | Y        | 节点公钥       |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :----------- |
| 	|	|	|	|	|	|	|


- 实例：

```json tab="请求实例"
{
	"domainId":"Domain",
	"nodeName":"Node-g12",
	"pubKey":"04ba98bf34af47145cf552b710570538b37bf3eff124e51c3361d02ea128c0447737be86077667feaca6dbc0679ae0653c4887d328a2b9d6d7f777599c287bf054",
	"sign":"002d678597d5b2402cc37bf836efe9a7f122ca7687231aeb6db4b0efee3e92aaa26aedcd6d68e08d77aadfc8f72d89b328505a4f36444b09b9df888c533d721057",
	"signValue":"1111111111",
} 
```

```json tab="响应实例"
{
	"data":null,
	"msg":"Success",
	"respCode":"000000"
} 
```

##### <a id="REGISTER_POLICY">Policy注册</a>

- [x] 开放
- 接口描述： 注册Policy
- functionName：`REGISTER_POLICY`
- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| policyId       | `string`       | 32       | Y    | Y        | 注册的policyId                               |
| policyName     | `string`       | 64       | Y    | Y        |                                              |
| votePattern    | `string`       |          | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| callbackType   | `string`       |          | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
| decisionType   | `string`       |          | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| domainIds      | `list<string>` |          | Y    | Y        | 参与投票的domainId列表                       |
| requireAuthIds | `list<string>` |          | N    | Y        | 需要通过该集合对应的rs授权才能修改当前policy |
| assignMeta     | `json` |          | N    | Y        | 当decisionType=ASSIGN_NUM,assignMeta属性值需要签名 |

- assignMeta结构
|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| verifyNum | `int` |          | N    | Y        | 当decisionType=ASSIGN_NUM时签名需要, the number to verify  |
| expression | `string` |          | N    | Y        | 当decisionType=ASSIGN_NUM时签名需要,the expression for vote rule example: n/2+1 |
| mustDomainIds | `list<string>` |          | N    | Y        |当decisionType=ASSIGN_NUM时签名需要  |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :----------- |
| 	|	|	|	|	|	|


- 实例：

```json tab="请求实例"
{
	"assignMeta":{
		"expression":"n/2+1",
		"mustDomainIds":null,
		"verifyNum":1
	},
	"callbackType":"ALL",
	"decisionType":"FULL_VOTE",
	"domainIds":[
		"Domain"
	],
	"policyId":"P_",
	"policyName":"P_-name",
	"requireAuthIds":[],
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

##### <a id ="MODIFY_POLICY">Policy更新</a>
- [x] 开放
- 接口描述： 修改Policy
- functionName：`MODIFY_POLICY`
- 请求参数：

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
|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| verifyNum | `int` |          | N    | Y        | 当decisionType=ASSIGN_NUM时签名需要, the number to verify  |
| expression | `string` |          | N    | Y        | 当decisionType=ASSIGN_NUM时签名需要,the expression for vote rule example: n/2+1 |
| mustDomainIds | `list<string>` |          | N    | Y        |当decisionType=ASSIGN_NUM时签名需要  |



- 响应参数：

| 属性 | 类型 | 最大长度 | 必填 | 是否签名 | 说明 |
| :---------: | -------- | -------- | ---- | -------- | :---------- |
|             |          |          |      |          |        |



- 实例：

```json tab="请求实例"
{
	"assignMeta":{
		"expression":"n/2+1",
		"mustDomainIds":null,
		"verifyNum":1
	},
	"callbackType":"ALL",
	"decisionType":"FULL_VOTE",
	"domainIds":[
		"Domain"
	],
	"policyId":"P_ID_873",
	"policyName":"P_ID_873-name",
	"requireAuthIds":[],
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

#### BD
##### <a id="BD_PUBLISH">BD发布</a>
- [x] 开放
- 接口描述：  功能：发布自定义`BD`
   1. 所有类型的交易都需要指定`bdCode`,系统内置`BD`参考()；
   2. 发布BD使用用到的`Policy`和`execPermission`，链上必须存在（参考`注册Permission`和`注册Policy`功能）
   3. 如果发布`bdType`类型为`assets`或`contract`,那么后续发布的合约必须满足该`BD`的`functions`规范；
   4. 如果发布的`bdType`为`system`,那么`BD`的`functions`中定义的`name`只能是系统内置的`function`;
- functionName：`BD_PUBLISH`
- 请求参数： 

|    属性     | 类型                  | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------------------- | -------- | ---- | -------- | :-------------------------------- |
| code      | `string`               | 32       | Y    | Y        | BD编号（唯一）                      |
| label      | `string`              | 64       | Y    | Y        | BD名称                             |
| desc      | `string`               | 1024     | N    | Y        | 描述                      |
| functions | `List<FunctionDefine>` |          | Y    | Y        | bd定义function            |
| contracts | `List<ContractDefine>` |          | Y    | Y        | bd定义contract            |
| bdVersion | `string`               | 4        | Y    | Y        | bd版本                    |

`ContractDefine`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------:    | -------- | -------------- | ---- | -------- | :---------------------------- |
|   templateCode   | `string` | 32             | Y    | Y        | 合约模板名称，在同一个bd下不能重复                      |
| desc             | `string` | 256            | N    | Y        | function描述                     |
| createPermission | `string` | 64             | Y    | Y        | 合约发布时的权限,,发布bd时，该permission已经存在于链上 |
| createPolicy     | `string` | 32             | Y    | Y        | 合约发布时的 policy,发布bd时，该policy已经存在于链上                |
| functions        | `List<FunctionDefine>`|      | Y        | Y        | 合约方法定义function            |

`FunctionDefine`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:    | -------- | -------- | ---- | -------- | :---------------------------- |
| desc           | `string` | 256     | N    | Y        | function描述                     |
| execPermission | `string` | 64     | Y    | Y        | 执行function权限,发布bd时，该permission已经存在于链上                   |
| execPolicy     | `string` | 32     | Y    | Y        | 执行function policy,发布bd时，该policy已经存在于链上                      |
| methodSign     | `string` | 64     | Y    | Y        | 如果dbType类型为(contract/assets),则为方法签名                      |
| name           | `string` | 64     | Y    | Y        | function名称在同一个bd下不能重复                      |
| type           | `string` | 64     | Y    | Y        |function功能类型<a href="FUNCTION_TYPE">FUNCTION_TYPE</a>        |


- <a id="FUNCTION_TYPE">function type类型</a>

|    类型                         | 说明                         |
| :-----------------------------:| --------                    |
| SystemAction                   |系统内置function功能            |
| Contract                       |该function属于合约方法           |
| ContractQuery                  |该function属于合约查询类,可以通过<a href="query-api.md#queryContract">合约状态查询</a>调用该方法|

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```java tab="请求实例-actionDatas"
    {
        "datas":{
            "bdVersion":"4.0.0",
            "code":"sto_code",
            "contracts":[
                {
                    "createPermission":"DEFAULT",
                    "createPolicy":"BD_PUBLISH",
                    "desc":"余额查询-1",
                    "functions":[
                        {
                            "desc":"余额查询",
                            "execPermission":"DEFAULT",
                            "execPolicy":"BD_PUBLISH",
                            "methodSign":"(uint256) balanceOf(address)",
                            "name":"balanceOf",
                            "type":"Contract"
                        },
                        {
                            "desc":"转账",
                            "execPermission":"DEFAULT",
                            "execPolicy":"BD_PUBLISH",
                            "methodSign":"(bool) transfer(address,uint256)",
                            "name":"transfer",
                            "type":"Contract"
                        }
                    ],
                    "templateCode":"code-balanceOf-1"
                },
                {
                    "createPermission":"DEFAULT",
                    "createPolicy":"BD_PUBLISH",
                    "desc":"余额查询-2",
                    "functions":[
                        {
                            "desc":"余额查询",
                            "execPermission":"DEFAULT",
                            "execPolicy":"BD_PUBLISH",
                            "methodSign":"(uint256) balanceOf(address)",
                            "name":"balanceOf",
                            "type":"Contract"
                        },
                        {
                            "desc":"转账",
                            "execPermission":"DEFAULT",
                            "execPolicy":"BD_PUBLISH",
                            "methodSign":"(bool) transfer(address,uint256)",
                            "name":"transfer",
                            "type":"Contract"
                        }
                    ],
                    "templateCode":"code-balanceOf-2"
                }
            ],
            "label":"sto_code_name"
        },
        "version":"4.0.0"
    }

```

```json tab="响应实例"
{
	"data":"0f2222f69027942c341b0e1296256b2b8acd3135bc448b3e6bea106d22e362a3",
	"msg":"Success",
	"respCode":"000000"
} 
```

#### 快照
##### <a id="BUILD_SNAPSHOT">快照发布</a>

- [x] 开放
- 接口描述： 申请一个快照版本，入链后记录当前快照处理的区块高度，快照申请成功后，可以按区块高度查询到申请快照时的信息 
（快照发布使用的是存证的execPolicyId和functionName）
- functionName：`BUILD_SNAPSHOT`
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
	    "datas":{"snapshotId":"0e248ba7-8c95-4667-a1f3-d98c2a861973"},
	    "version":"4.0.0"
    }
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
- 请求地址：`GET`:`/snapshot/query?txId={txId}`
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

##### <a id="CONTRACT_CREATION">合约部署</a>

- [x] 开放
- 接口描述：用户发布自定义合约实现业务
- functionName：`CONTRACT_CREATION`
- 请求参数：

| 属性            | 类型       | 最大长度 | 必填 | 是否签名 | 说明                       |
| --------------- | ---------- | -------- | ---- | -------- | -------------------------- |
| fromAddr        | `string`   | 40       | Y    | Y        | 提交者地址                 |
| contractAddress | `string`   | 40       | Y    | Y        | 合约地址 |
| name            | `string`   | 64       | Y    | Y        | 合约名称                   |
| symbol          | `string`   | 64       | Y    | Y        | 合约简称                   |
| extension       | `string`   | 1024     | Y    | Y        | 扩展属性                   |
| contractor      | `string`   |          | Y    | Y        | 合约构造器(函数)名         |
| sourceCode      | `string`   |          | Y    | Y        | 合约代码                   |
| initArgs        | `object[]` |          | Y    | Y        | 合约构造入参（签名时需使用逗号分隔拼接(参见StringUtils.join(args,",")),如果参数中包含数组，数组请使用JSONArray来装）              |
| version         | `string`   |10        | Y    | Y        | 版本号：4.0.0            |

- 响应参数：

| 属性            | 类型       | 最大长度 | 必填 | 是否签名 | 说明                       |
| --------------- | ---------- | -------- | ---- | -------- | ---------------------|
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：
```json tab="请求实例"
{
	"datas":
	{
        "fromAddr":"1b3c3dd36e37478ffa73e86816b20a1c12a57fa4",
        "contractAddress":"becb1870d5a0a6ea0e9d8cceafb58c40292f04bb",
        "contractor":"StandardCurrency(address,string,string,uint,uint8,string)",
        "extension":"{\"a\":1}",
        "initArgs":[
            "1b3c3dd36e37478ffa73e86816b20a1c12a57fa4",
            "S_50954",
            "S_50954_Name",
            100000000000000,
            8,
            "00000000000000000000000000000000000000000000000000000074785f6964"
        ],
        "name":"StandardCurrency",
        "sourceCode":"pragma solidity ^0.4.24;"
	},
	"version":"4.0.0"
} 
```

```json tab="响应实例"
{
	"data":"\"4a7bc3a9b86583818b94a5de346fce29047f88a07e773a47c70701f5bb2f7f32\"",
	"msg":"Success",
	"respCode":"000000"
} 
```

##### <a id="CONTRACT_INVOKE">合约执行</a>
- [x] 开放
- 接口描述： 执行合约定义的方法，需确保交易提交者具备db定义的permission权限
- functionName：`{functionName}`
- 请求参数： 

|    属性         | 类型          | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:    | --------     | -------- | ---- | -------- | :---------------------------- |
| methodSignature| `string`     |      | Y    | Y        | 方法执行的方法abi((uint) balanceOf(address))   |
| args           | `object[]`   |      | Y    | Y        | 方法执行入参参数，（签名时需使用逗号分隔拼接(参见StringUtils.join(args,",")),如果参数中包含数组，数组请使用JSONArray来装）       |
| from           | `string`     |      | Y    | Y        | 同交易提交地址                     |
| to             | `string`     |      | Y    | Y        | 执行的合约地址                     |
| remark         | `string`     |      | N    | Y        | 备注存证                     |
| version        | `string`     |10    | Y    | Y        | 版本号：4.0.0            |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"
{
	"datas":
	    {
            "args":[
                "e966fe88795f4ff5b772475efea405631e644f59",
                20
            ],
            "from":"1b3c3dd36e37478ffa73e86816b20a1c12a57fa4",
            "methodSignature":"(bool) transfer(address,uint256)",
            "to":"becb1870d5a0a6ea0e9d8cceafb58c40292f04bb"
        },
    "version":"4.0.0"   
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
- 请求地址：`POST`:`/queryContract`
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
| 	|	|	|	|	|	|

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

##### <a id="PERMISSION_REGISTER"> 新增Permission </a>

- [x] 开放
- 接口描述：  添加permission,Identity被授予permission后才能执行该permission所定义交易
- functionName：`PERMISSION_REGISTER`
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
	"datas":
    	    {
	            "permissionName":"permission_97251",
            },
    "version":"4.0.0"   
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

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
|	|	|	|	|	|	|

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

##### <a id="IDENTITY_SETTING">Identity设置</a>

- [x] 开放
- 接口描述：  设置Identity(此接口不能设置KYC信息)
- functionName：`IDENTITY_SETTING`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:  | -------- | -------- | ---- | -------- | :---------------------------- |
| address      | `string` | 40     | Y    | Y        | Identity地址                      |
| property     | `string` | 1024   | Y   | Y      |  属性json格式       |


- 响应参数：

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| txId | `string` |          | Y    | Y        | 交易id |                           |

- 实例：

```json tab="请求实例"
{
   "datas":
    	    {
	          "address":"5342594ae09e2f8844464824e24e61334603bc49",
	          "property":""
            },
    "version":"4.0.0"   
}
```

```json tab="响应实例"
{
	"data":"1573c09b4d38a9ec914cca57b950db35e1142b63396c0a238c9e4f656c7509c6",
	"msg":"Success",
	"respCode":"000000"
} 
```


#####  <a id="AUTHORIZE_PERMISSION">Identity授权Permission</a>

- [x] 开放
- 接口描述：  给Identity赋予已入链的permission
- functionName：`AUTHORIZE_PERMISSION`
- 请求参数

|      属性          | 类型       | 最大长度 | 必填 | 是否签名 | 说明                                    |
| :---------------: | ---------- | -------- | ---- | -------- | ------------------------------------ |
| identityAddress   | `string`   | 40       | Y    | Y        | 新增identity地址                      |
| addPermissions    | `string[]` |          | Y    | Y        | 给Identity授权的PermissionName数组     |
| canclePermissions    | `string[]` |          | Y    | Y        | 给Identity撤销的的PermissionName数组     |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| data | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"

{
   "datas":
    	    {
	            "identityAddress":"5165c656244637cf8d5f7ad8f5e10f703c784962",
                "identityType":"user",
                "addPermissions":["permission_97251"],
                "cancelPermissions":["permission_97251"],
            },
    "version":"4.0.0"   
}

```

```json tab="响应实例"
{
	"data":"c03ba6d1fe11c941b110a3064ce675e52c74be56c9dae4beaccbe287ce4f86e1",
	"msg":"Success",
	"respCode":"000000"
} 
```

##### <a id="IDENTITY_BD_MANAGE">Identity冻结/解冻BD</a>

- [x] 开放
- 接口描述：冻结某个bdCode，冻结成功后identity无法执行该bdCode的所有function 
- functionName：`IDENTITY_BD_MANAGE`
- 请求参数： 

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| targetAddress | `string`   | 40       | Y    | Y        | 目标identity地址              |
|    codes    | `string[]` |          | Y    | Y          | 冻结或解冻的类型code|
|  actionType   | `string`   |          | Y    | Y        | <a href="actionType">操作类型</a> |
|  frozeType   | `string`   |          | Y    | Y        | <a href="frozeType">冻结类型</a> |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
   "datas":
    	    {
	            "actionType":"UNFROZE",
                "frozeType":"BD",
                "codes":["SystemBD"]
            },
    "version":"4.0.0"   
}

```

```json tab="响应实例"
{
	"data":"9e93ae8071511828c2879206a1a6c50f3d292f5790e3d8f0379a0b3b5f98b67c",
	"msg":"Success",
	"respCode":"000000"
} 
```

-  <a id="actionType">操作类型</a> 

|     类型                   | 说明                 |
| :-----------------------: | ------------------  |
| FROZE                     | 冻结`Identity`的`BD`后,`Identity`不能再调用被冻结`BD`所有交易;<br>冻结`Identity`的`CONTRACT`后,`Identity`不能再调用被冻结`CONTRACT`所有交易,但可以调用`BD`的其他`templateCode`合约;<br>冻结`Identity`的`FUNCTION_NAME`后`Identity`不能在调用被冻结`FUNCTION_NAME`交易,但可以调用`BD`的其他`FUNCTION_NAME`|
| UNFROZE                   | 解冻`BD`,`CONTRACT`,`functionName`,解冻成功后可以正常使用|

-  <a id="frozeType">冻结类型</a> 

|     类型                   | 说明                 |
| :-----------------------: | ------------------  |
| BD                        |  冻结或解冻整个`BD`   |
| CONTRACT                  |  冻结或解冻整个整个合约,冻结的是合约code格式为`bdCode`+`templateCode`|
| FUNCTION_NAME              |  冻结或解冻`funtionName`,code格式为`bdCode`+`templateCode`+`functionName`  |



##### Identity权限查询

- [x] 开放
- 接口描述：  查询Identity用户所拥有的permission权限
- 请求地址：`GET`:`/identity/permission/query?address={address}`
- 请求参数：接口无需签名 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | N        | 用户地址                     |



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
- 请求地址：`GET`:`identity/query?userAddress={userAddress}`
- 请求参数：

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| userAddress | `string`   | 40       | Y    | Y        | identity地址              |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | Y        | user identity 地址                      |
| currentTxId | `string` | 64     | Y    | Y        |    user identity 改修改时的txId                   |
| frozeBDs | `string` | 64     | Y    | Y        | 冻结的bd，采用`,`分隔  |
| frozeContracts | `string` | 64     | Y    | Y        | 冻结的合约，采用`,`分隔   |
| frozeFunctions | `string` | 64     | Y    | Y        | 冻结的function，采用`,`分隔   |
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

##### <a id="KYC_SETTING">KYC设置</a>

- [x] 开放
- 接口描述：  给Identity设置KYC信息，KYC为json格式，每次设置设置会覆盖之前的KYC信息;identityType会覆盖之前identityType
- functionName：`KYC_SETTING`
- 请求参数：

|      属性       | 类型     | 最大长度 | 必填 | 是否签名 | 说明                            |
| :-------------: | -------- | -------- | ---- | -------- | ------------------------------- |
| identityAddress | `string` | 40       | Y    | Y        | 目标identity地址                |
| KYC       | `string` | 1024     | Y    | Y        | KYC属性（json字符串，合约目前支持kyc验证）                         |
| identityType   | `string` |          | N    | Y        | 1. user(默认) 2. domain 3. node， 用户可自定义 |

-  <a id="identityType">identityType类型</a> 

|     类型                   | 说明                |
| :-----------------------: | ------------------  |
| user                      |  普通用户            |
| domain                    |  Domain域           |
| node                      |  参与网络的区块链节点   |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
   "datas":
    	    {
	            "identityAddress":"7cc176180280d46bc15d871e02475ae47a4255f2",
                "identityType":"user",
                "kYC":"{\"aaa\":111,\"bbb\":222}",
            },
    "version":"4.0.0"   
}
```

```json tab="响应实例"
{
	"data":"ebabcbf2151fbcfe42e1c5d2aae532b5eedac461fe71ccc67263c5a5a3b53ea5",
	"msg":"Success",
	"respCode":"000000"
} 
```

#### <a id="SAVE_ATTESTATION">存证</a>

- [x] 开放
- 接口描述：  保存存证信息入链
- functionName：`SAVE_ATTESTATION`
- 请求参数： 

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
{
   "datas":
    	    {
	           "attestation": "我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，",
               "attestationVersion": "1.0",
               "objective": "177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf",
               "remark": "markmarkmarkmarkmark",
            },
    "version":"4.0.0"   
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
