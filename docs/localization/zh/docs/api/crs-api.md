# CRS接口文档

接口分为区分系统级和非系统级接口， 系统级接口仅供内部RS节点调用，对外接口均为非系统级接口。
非系统级接口又分为查询类接口和交易类接口，查询类接口采用GET请求，接口无安全性设计考虑；交易类接口采用POST请求，
请求数据采用AES256加密，并会将加密数据采用ECC签名，具体参见接口规范

## 术语
- `merchantId`: 商户Id, 用于区分不同的接入方
- `merchantPriKey`: 商户ECC私钥，用于签名请求数据
- `merchantPubKey`: 商户ECC公钥，用于CRS验证商户请求签名
- `merchantAesKey`: 商户AES256格式密钥，用于加密请求数据或响应数据--不配置表示不加密(同时要求zuul也不要配置)
- `crsPubKey`: CRS公钥，用户商户验证响应数据签名
- `crsPriKey`: CRS公钥，用于CRS签名响应数据
- `Permission`:
- `Policy`:
- `kyc`:
- `BD`:
- `Identity`:
- `{}`: 动态值表示符号

## 交易接口列表
| 接口type                                              | 说明 |
| :-----                                                    | :-----    |
|<a href="#SET_IDENTITY">SET_IDENTITY</a>                   |Identity设置|
|<a href="#FREEZE_IDENTITY">FREEZE_IDENTITY</a>             |Identity冻结|
|<a href="#UNFREEZE_IDENTITY">UNFREEZE_IDENTITY</a>         |Identity解冻|
|<a href="#ADD_BD">ADD_BD</a>                               |发布BD|
|<a href="#SET_PERMISSION">SET_PERMISSION</a>     			|Permission设置|
|<a href="#SET_POLICY">SET_POLICY</a>             			|设置Policy|
|<a href="#ADD_RS">ADD_RS</a>                               |RS注册|
|<a href="#REMOVE_RS">REMOVE_RS</a>                         |RS撤销|
|<a href="#INIT_CA">INIT_CA</a>                             |CA初始化|
|<a href="#ADD_CA">ADD_CA</a>                               |CA认证|
|<a href="#UPDATE_CA">UPDATE_CA</a>                         |CA更新|
|<a href="#REMOVE_CA">REMOVE_CA</a>                         |CA撤销|
|<a href="#ADD_NODE">ADD_NODE</a>                           |节点加入|
|<a href="#REMOVE_NODE">REMOVE_NODE</a>                     |退出节点|
|<a href="#ADD_CONTRACT">ADD_CONTRACT</a>                   |合约创建|
|<a href="#EXECUTE_CONTRACT">EXECUTE_CONTRACT</a>           |合约执行|
|<a href="#SET_ATTESTATION">SET_ATTESTATION</a>           	|存证|
|<a href="#ADD_SNAPSHOT">ADD_SNAPSHOT</a>               |快照交易|


## 查询接口列表
| 接口地址                                                          | 说明 |
| :-----                                                           | :-----    |
|[queryMaxHeight][1]                  |查询当前最大区块高度|
|[queryTxByTxId/{txId}][2]            |根据txId查询交易数据|
|[queryTxsByHeight/{height}][3]       |根据高度查询区块内所有交易数据|
|[queryContract][4]                   |合约数据状态查询|

## 系统内置function表
| functionName      	| execPermission | execPolicy         	    | 备注 |
| :-----                |  :-----        |  :-----                  |  :-----            |
| SET_IDENTITY  	    |                |    	                    |Identity设置      |
| FREEZE_IDENTITY  	    |                |    	                    |Identity冻结      |
| UNFREEZE_IDENTITY  	|                |    	                    |Identity解冻      |
| ADD_BD  			    | DEFAULT        | SYNC_ONE_VOTE_DEFAULT   	|发布BD      |
| SET_PERMISSION  	    | DEFAULT        | SET_PERMISSION           |Permission设置      |
| SET_POLICY  		    | DEFAULT        | SYNC_ONE_VOTE_DEFAULT   	|设置Policy      |
| ADD_RS  			    | DEFAULT        | ADD_RS   	            |RS注册      |
| REMOVE_RS  			| RS        	 | REMOVE_RS   	  		    |RS撤销      |
| INIT_CA  			    |         	     |    	  		            |CA初始化     |
| ADD_CA  				| DEFAULT        | ADD_CA   	  		    |CA认证      |
| UPDATE_CA  			| RS             | UPDATE_CA   	  		    |CA更新      |
| REMOVE_CA  			| RS        	 | REMOVE_CA   	  		    |CA撤销      |
| ADD_NODE  			| DEFAULT        |  ADD_NODE   	  		    |加入节点      |
| REMOVE_NODE  			| RS        	 | REMOVE_NODE   	  	    |退出节点      |
| ADD_CONTRACT  	    |         	    |    	  	                |合约创建      |
| EXECUTE_CONTRACT      |         	    |    	  	                |合约执行      |
| ADD_SNAPSHOT  		| DEFAULT           | SYNC_ONE_VOTE_DEFAULT |快照交易      |
| SET_ATTESTATION  		|                   |    	                |存证      |

## 系统内置Permission表
| Permission      	    | 备注 |
| :-----                |  :-----        |
| DEFAULT  	            | 系统默认所有地址都拥有DEFAULT的Permission       |
| RS  			        | 系统节点初始化时RS节点拥有该Permission        |

## 系统内置Policy表
| Policy       	   		|投票方式            |决议方式            |备注               |
| :-----           		|  :-----           |  :-----           |:-----           |
|SET_POLICY        		|  ASYNC            |FULL_VOTE          |  |
|ADD_RS    				|  ASYNC            |FULL_VOTE          |  |
|REMOVE_RS    			|  ASYNC            |FULL_VOTE          |  |
|ADD_CA           		|	 ASYNC          |FULL_VOTE          |  |
|UPDATE_CA        		|  ASYNC            |FULL_VOTE          |  |
|REMOVE_CA        		|  ASYNC            |FULL_VOTE          |  |
|ADD_NODE         		|  ASYNC            |FULL_VOTE          |  |
|REMOVE_NODE      		|  ASYNC            |FULL_VOTE          |  |
|SYNC_ONE_VOTE_DEFAULT  |  SYNC             |FULL_VOTE          |  |
|ASYNC_DEFAULT      	|  ASYNC            |FULL_VOTE          |  |
|SYNC_DEFAULT      		|  SYNC             |FULL_VOTE          |  |


## SDK
更快接入参考SDK提供的`SubmitTransactionExample`实例
``` java

<dependency>
    <groupId>com.hashstacs</groupId>
    <artifactId>stacs-client</artifactId>
    <version>4.1.1-SNAPSHOT</version>
</dependency>

```

## kyc规范

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
      |   data    | `string` | 响应数据，将原始响应数据采用{merchantAesKey}加密后使用BASE64编码-aesKey不配置时不做解密 |
      | signature | `string` | CRS签名，将原始响应数据采用{crsPriKey}签名后的HEX格式数据   |
    



```json tab="请求实例"
{
	"requestParam": "{
	    "txData":"{
	        "txId":"txId-123",
	        "bdCode":"SystemBD",
	        "functionName":"BD_PUBLISH",
	        "type":"BD_PUBLISH",
	        .......
	    }",
	    txSign:"xxx"
	}",
	"signature": "017236d91c3fa2560a5c5fdee1e4a7a55397d146213153d09cea97b1d1949596e2636cf6081bf1a0695811556e9f41918924c41a58149e994ab4132eb54279345d"
}
```

```json tab="响应实例"
{
	"data": "",
	"msg": "Success", // 操作成功
	"respCode": "000000", // 返回代码， 000000为成功
}
```
### <a id="requestParam">requestParam参数列表</a>

|     属性     | 类型     | 说明                                                         |
| :----------: | -------- | ------------------------------------------------------------ |
| txData       | `string` | 请求原始数据                                                   |
| txSign       | `string` | 请求原始数据的签名(用户级)                                       |

示例：
```json 
{
   "txData":"{"txId":"7c587484f89c91ab6481ea3ccaf581ac2543cf5fcd047816d9b3b7a0361ce28c","bdCode":"SystemBD","functionName":"BD_PUBLISH","submitter":"b8da898d50712ea4695ade4b1de6926cbc4bcfb9","version":"4.0.0","actionDatas":{"datas":{"bdVersion":"4.0.0","code":"sto_code","contracts":[{"createPermission":"DEFAULT","createPolicy":"BD_PUBLISH","desc":"余额查询-1","functions":[{"desc":"余额查询","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(uint256) balanceOf(address)","name":"balanceOf","type":"Contract"},{"desc":"转账","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(bool) transfer(address,uint256)","name":"transfer","type":"Contract"}],"templateCode":"code-balanceOf-1"},{"createPermission":"DEFAULT","createPolicy":"BD_PUBLISH","desc":"余额查询-2","functions":[{"desc":"余额查询","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(uint256) balanceOf(address)","name":"balanceOf","type":"Contract"},{"desc":"转账","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(bool) transfer(address,uint256)","name":"transfer","type":"Contract"}],"templateCode":"code-balanceOf-2"}],"label":"sto_code_name"},"version":"4.0.0"}}",
       "txSign":"017ee57b7567039c214f0b27a186e567277731a95ad09baa84d8092cd8af125c29342a234ea67a0d095a36f63e92b49adb57d66e7909499992ee7eae12bc7451c3"}
}
```
### <a id="COMMON_PRAMS_LIST">通用参数列表</a>

|     属性      | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| :-----------: | -------- | -------- | ---- | :------: | ------------------------------------------------------------ |
| txId          | `string` | 64       | Y    |    Y     | 请求Id |
| bdId        | `string` | 32       | Y    |    Y     | 所有业务交易都需要指定bdCode                                       |
| templateId  | `string` | 32       | N    |    Y     |发布合约或执行合约方法时的合约templateCode                           |
| type          | `string` | 32       | N    |    Y     |系统级actionType                                                  |
| subType       | `string` | 32       | N    |    Y     |子业务类型                                             |
| sessionId     | `string` | 64       | N    |    Y     |订单id                                            |
| merchantId    | `string` | 32       | N    |    Y     |商户id                                            |
| merchantSign  | `string` | 128      | N    |    Y     |商户签名                                            |
| functionId  | `string` | 32          | Y    |    Y     | BD的functionId，如果是BD的初始化或者合约的发布：`CONTRACT_CREATION` |
| submitter     | `string` | 40       | Y    |    Y     | 操作提交者地址                                               |
| actionDatas   | `string` | text     | Y    |    Y     | 业务参数JSON格式化数据，json数据包含{"version":"4.0.0","datas":{}}                                               |
| version       | `string` | 40       | Y    |    Y     | 交易版本号                                               |
|extensionDatas | `string` | 1024     | N    |    Y     | 交易存证新消息                                               |
| submitterSign | `string` | 64       | Y    |    N     | 提交者`submitter`的`ECC`对交易的签名,该字段不参与签名                                                   |

###  签名方式
#### 交易签名值拼接方式 
``` java

    /**
     * should sign fields
     */
    private static String[] SIGN_FIELDS = new String[]
        {"txId","bdCode","funtionId","templateCode","type","submitter","version","actionDatas","extensionDatas","subType","sessionId"};

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

#### <a id="ADD_RS">注册RS
- [x] 开放
- 接口描述： 执行合约定义的方法，需确保交易提交者具备db定义的permission权限
- type：`ADD_RS`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明             |
| :---------: | -------- | -------- | ---- | :------: | ---------------- |
|    rsId     | `string` | 32       | Y    |    Y     | RS id            |
|    desc     | `string` | 128      | Y    |    Y     | RS 节点描述      |
|  domainId   | `string` | 16       | Y    |    Y     | Domain ID        |
| maxNodeSize | `int`    | 10         | N    |    Y     | 最大节点允许数量 |
| domainDesc  | `string` | 1024         | N    |    Y     | domain 描述      |
  
- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :-------------------------|
| txId | `string` |      | Y    | Y        | 交易id                      |

##### 示例

```java
// todo sdk 请求代码
```



#### <a id="CANCEL_RS"/>移除RS</a>

- - [ ] 开放

- 接口描述：  移除已注册的 RS

- type：`CANCEL_RS`

- 请求参数： 

| 属性 | 类型     | 最大长度 | 必填 | 是否签名 | 说明 |
| :---------: | -------- | -------- | ---- | -------- | :-------------------------|
| rsId | `string` | 32       | Y    | Y        |      |
  
- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :-------------------------|
| txId | `string` |      | Y    | Y        | 交易id                      |


### CA

#### <a id="ADD_CA"/>CA注册</a>

- [x] 开放
- 接口描述： 将CA上链
- type：`ADD_CA`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ----  | -------- | :---------------------------- |
| txId          | `string` | 64       | Y       | Y        | 交易id                      |
| caList        | `json[]` |1024        | Y       | Y        | ca集合(签名拼接需要将caList中的每个ca拼接)                      |
| proxyNodeName | `string` | 64       | Y       | N        | 代理节点                      |

- `caList`

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                       |
| :---------:   | -------- | -------- | ----  | -------- | :---------------- |
| version       | `string` |10       | Y       | Y        | 版本号   |
| period        | `string` |20       | Y       | Y        |格式化格式"yyyy-MM-dd hh:mm:ss"北京时间需要减8个小时  |
| pubKey        | `string` |131      | Y       | Y        | 公钥   |
| user          | `string` |32        | Y       | Y        | 节点名称  |
| domainId      | `string` |32        | Y       | Y        | domain  |
| usage         | `string` |10        | Y       | Y        | biz/consensus      |

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

#### <a id="UPDATE_CA"/>CA更新</a>
- [x] 开放
- 接口描述： 更新CA
- type：`UPDATE_CA`

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
- type：`CA_CANCEL`

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
- type：`NODE_JOIN`
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
- type：`NODE_LEAVE`
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

#### <a id="SET_POLICY">Policy设置</a>

- [x] 开放
- 接口描述： Policy设置
- type：`SET_POLICY`
- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| policyId       | `string`       | 32       | Y    | Y        | 注册/修改的policyId                               |
| label          | `string`       | 64       | Y    | Y        |                                              |
| votePattern    | `string`       |          | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| callbackType   | `string`       |          | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
| decisionType   | `string`       |          | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| domainIds      | `list<string>` |          | Y    | Y        | 参与投票的domainId列表                       |
| requireAuthIds | `list<string>` |          | N    | Y        | 需要通过该集合对应的domain授权才能修改当前policy |
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
	"label":"P_-name",
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
##### <a id="ADD_BD">BD发布</a>
- [x] 开放
- 接口描述：  功能：发布自定义`BD`
   1. 所有类型的交易都需要指定`bdId`,系统内置`BD`参考()；
   2. 发布BD使用用到的`Policy`和`execPermission`，链上必须存在（参考`注册Permission`和`注册Policy`功能）
- type：`ADD_BD`
- 请求参数： 

|    属性     | 类型                  | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------------------- | -------- | ---- | -------- | :-------------------------------- |
| id      | `string`                 |32       | Y    | Y        | BD编号（唯一）                      |
| label      | `string`              |64       | Y    | Y        | BD名称                             |
| desc      | `string`               |1024     | N    | Y        | 描述                      |
| functions | `List<FunctionDefine>` |2048     | N    | Y        | bd定义function            |
| contracts | `List<ContractDefine>` |2048     | N    | Y        | bd定义contract            |
| bdVersion | `string`               | 4       | Y    | Y        | bd版本                    |

`ContractDefine`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------:    | -------- | -------------- | ---- | -------- | :---------------------------- |
|   templateId   | `string` | 32             | Y    | Y        | 合约模板名称，在同一个bd下不能重复                      |
| desc             | `string` | 256            | N    | Y        | function描述                     |
| createPermission | `string` | 64             | Y    | Y        | 合约发布时的权限,,发布bd时，该permission已经存在于链上 |
| createPolicy     | `string` | 32             | Y    | Y        | 合约发布时的 policy,发布bd时，该policy已经存在于链上                |
| functions        | `List<FunctionDefine>`|2048      | Y        | Y        | 合约方法定义function            |

`FunctionDefine`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:    | -------- | -------- | ---- | -------- | :---------------------------- |
| desc           | `string` | 256     | N    | Y        | function描述                     |
| execPermission | `string` | 64     | Y    | Y        | 执行function权限,发布bd时，该permission已经存在于链上                   |
| execPolicy     | `string` | 32     | Y    | Y        | 执行function policy,发布bd时，该policy已经存在于链上                      |
| methodSign     | `string` | 64     | Y    | Y        | 如何发布的是合约填写的合约方法签名
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
    	"txData":"{\"txId\":\"769b222dec0c49f39a2c80cb14a3da6470a92397fec8b164f20c56a2eaa2d8af\",\"bdId\":\"SystemBD\",\"functionId\":\"ADD_BD\",\"type\":\"ADD_BD\",\"submitter\":\"b8da898d50712ea4695ade4b1de6926cbc4bcfb9\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"bdVersion\":\"4.0.0\",\"functions\":[{\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"methodSign\":\"SET_ATTESTATION\",\"name\":\"SET_ATTESTATION\",\"type\":\"SystemAction\"}],\"id\":\"sto_code_token5476\",\"label\":\"sto_code__token_name\"},\"version\":\"4.0.0\"}}",
    	"txSign":"01b1eb09ff94d9d136597bb1b5665b5322203b0f56abee6c521bad91fa99b6bfb930520b74dab0e88e120e26a48d87e5e0dcaf5293bc0242e74b525f4eb9f8517b"
    }

```

```json tab="响应实例"
{
respCode='000000', 
msg='Success', 
data=769b222dec0c49f39a2c80cb14a3da6470a92397fec8b164f20c56a2eaa2d8af}
```

#### 快照
##### <a id="ADD_SNAPSHOT">快照发布</a>

- [x] 开放
- 接口描述： 申请一个快照版本，入链后记录当前快照处理的区块高度，快照申请成功后，可以按区块高度查询到申请快照时的信息 
（快照发布使用的是存证的execPolicyId和name）
- type：`ADD_SNAPSHOT`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| remark      | `string` | 256      | Y    | Y        | 快照备注                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"
	{
    	"txData":"{\"txId\":\"27f02fcbfcbdfb6659da0f3d870f11c969730efbb7a0ef769fd5ced4b7ed7a13\",\"bdId\":\"SystemBD\",\"functionId\":\"ADD_SNAPSHOT\",\"type\":\"ADD_SNAPSHOT\",\"submitter\":\"b8da898d50712ea4695ade4b1de6926cbc4bcfb9\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"remark\":\"d01a7e41-184c-4a69-bc98-a9a9a2f5005f\"},\"version\":\"4.0.0\"}}",
    	"txSign":"008fe95f4d816e93a14d46344c2140c20491d1d73bdeb7a6f2cae65d989fe9b84517fa1d04ea70e420990d2e1c32f9d69c539d40cf771d3fad42a4df3760fb8083"
    }
```

```json tab="响应实例"
{
    "data":"27f02fcbfcbdfb6659da0f3d870f11c969730efbb7a0ef769fd5ced4b7ed7a13",
    "msg":"Success","respCode":"000000",
    "success":true
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
| remark     | `string` |      | Y    | Y        | 备注                      |

- 实例：

```json tab="请求实例"

```

```json tab="响应实例"
{
    "data":{
        "blockHeight":926,
        "snapshotId":"68240",
        "remark":"remark"
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
- type：`CONTRACT_CREATION`
- 请求参数：

| 属性            | 类型       | 最大长度 | 必填 | 是否签名 | 说明                       |
| --------------- | ---------- | -------- | ---- | -------- | -------------------------- |
| contractAddress | `string`   | 40       | Y    | Y        | 合约地址 |
| name            | `string`   | 64       | Y    | Y        | 合约名称                   |
| symbol          | `string`   | 64       | Y    | Y        | 合约简称                   |
| contractor      | `string`   | 1024         | Y    | Y        | 合约构造器(函数)名         |
| sourceCode      | `string`   | text         | Y    | Y        | 合约代码                   |
| initArgs        | `object[]` | 2048         | N    | Y        | 合约构造入参（签名时需使用逗号分隔拼接(参见StringUtils.join(args,",")),如果参数中包含数组，数组请使用JSONArray来装）              |

- 响应参数：

| 属性            | 类型       | 最大长度 | 必填 | 是否签名 | 说明                       |
| --------------- | ---------- | -------- | ---- | -------- | ---------------------|
| txId | `string` |      | Y    | Y        | 交易id                      |

- 实例：
```json tab="请求实例"
{
	"datas":
	{
        "contractAddress":"becb1870d5a0a6ea0e9d8cceafb58c40292f04bb",
        "contractor":"StandardCurrency(address,string,string,uint,uint8,string)",
        "initArgs":[
            "1b3c3dd36e37478ffa73e86816b20a1c12a57fa4",
            "S_50954",
            "S_50954_Name",
            100000000000000,
            8,
            "00000000000000000000000000000000000000000000000000000074785f6964"
        ],
        "name":"StandardCurrency",
        "symbol":"BTC",
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
- type：`EXECUTE_CONTRACT`
- 请求参数： 

|    属性         | 类型          | 最大长度 | 必填 | 是否签名 | 说明                          |
| :------------:  | --------     | -------- | ---- | -------- | :---------------------------- |
| methodSignature | `string`     | 256     | Y    | Y        | 方法执行的方法abi((uint) balanceOf(address))   |
| args            | `object[]`   | 2048     | N    | Y        | 方法执行入参参数      |
| contractAddress | `string`     | 40     | Y    | Y        | 执行的合约地址                     |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` |   64   | Y    | Y        | 交易id                      |

- 实例：

```json tab="请求实例"
{
	"datas":
	    {
            "args":[
                "e966fe88795f4ff5b772475efea405631e644f59",
                20
            ],
            "methodSignature":"(bool) transfer(address,uint256)",
            "contractAddress":"becb1870d5a0a6ea0e9d8cceafb58c40292f04bb"
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

#### Permission

##### <a id="SET_PERMISSION"> 设置Permission </a>

- [x] 开放
- 接口描述：  添加permission,Identity被授予permission后才能执行该permission所定义交易
- type：`SET_PERMISSION`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| id            | `string`  | 64        | Y    | Y        | permission id（唯一）       |
| label         | `string`  | 64        | N    | Y        | 名称       |
| type          | `string`  | 64        | N    | Y        | 授权类型（ADDRESS/IDENTITY）       |
| authorizers   | `string[]`|2048         | Y    | Y        | 被授予后期可以修改Permission的地址|
| datas         | `json`    |2048      | Y    | Y        | 当type为ADDRESS时，datas为地址数组；type为IDENTITY时，datas为验证Identity表达式|

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| data       | `string` | 64        | Y    | Y        | 返回交易ID       |

- 实例：

```json tab="请求实例"
{
	"txData":"{\"txId\":\"b1269f6239121c98174d3f8e2ff64dba32d0b0b87062e103f811b0431541537d\",\"bdId\":\"SystemBD\",\"functionId\":\"SET_PERMISSION\",\"type\":\"SET_PERMISSION\",\"submitter\":\"b8da898d50712ea4695ade4b1de6926cbc4bcfb9\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"authorizers\":[\"b8da898d50712ea4695ade4b1de6926cbc4bcfb9\"],\"datas\":\"{\\\"combineType\\\":\\\"AND\\\",\\\"propertyRule\\\":\\\"true\\\",\\\"kycRule\\\":\\\"true\\\"}\",\"id\":\"Permission1\",\"type\":\"IDENTITY\"},\"version\":\"4.0.0\"}}",
	"txSign":"001f0a1b4ee2a9723858f8e00a70b1d0be1d121d972bac1edf1478dd5c8fc410ee67ebe56ddd739786ceae717370530567b34534a93bc5f4e49f0408df765a43c1"
}
```

```json tab="响应实例"

{
    respCode='000000', 
    msg='Success', 
    data=b1269f6239121c98174d3f8e2ff64dba32d0b0b87062e103f811b0431541537d
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
| id            | `string` | 64        | Y    | Y        | permission id（唯一）       |
| label         | `string` | 64        | N    | Y        | 名称       |
| type          | `string` | 64        | N    | Y        | 授权类型       |（ADDRESS/IDENTITY）
| authorizers   | `string[]`|2048          | Y    | Y        | 被授予后期可以修改Permission的地址|
| datas         | `json`    |2048      | Y    | Y        | 当type为ADDRESS时，datas为地址数组；type为IDENTITY时，datas为验证Identity表达式|
| preTxId       | `string`  |64        | Y    | Y        |上次操作的txId|
| currentTxId   | `string`  |64        | Y    | Y        |最近操作的txId|

- 实例：

```json tab="请求实例"

```

```json tab="响应实例"
{
    "data":[
        {
            "authorizers":[
                "177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf"
            ],
            "currentTxId":null,
            "datas":"["177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf"]",
            "id":"RS",
            "label":null,
            "preTxId":null,
            "type":"ADDRESS"
        },
        {
            "authorizers":[
                "b8da898d50712ea4695ade4b1de6926cbc4bcfb9"
            ],
            "currentTxId":"4e933250b076195dc50a525dbaae488dc31415c6174615377823d30ed499fb54",
            "datas":"{"combineType":"AND","propertyRule":"true","kycRule":"true"}",
            "id":"Permission1",
            "label":null,
            "preTxId":"e65940b9823a8895eb3d074cf2dcbb4432422d3481198de59cbfd635c078de8e",
            "type":"IDENTITY"
        },
        {
            "authorizers":[
                "177f03aefabb6dfc07f189ddf6d0d48c2f60cdbf"
            ],
            "currentTxId":null,
            "datas":"["ALL"]",
            "id":"DEFAULT",
            "label":null,
            "preTxId":null,
            "type":"ADDRESS"
        }
    ],
    "msg":"Success",
    "respCode":"000000",
    "success":true
}
 
```

#### Identity

##### <a id="SET_IDENTITY">Identity设置</a>

- [x] 开放
- 接口描述：  设置Identity(此接口可以设置KYC信息)
- type：`SET_IDENTITY`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:  | -------- | -------- | ---- | -------- | :---------------------------- |
| address      | `string` | 40     | Y    | Y        | Identity地址                      |
| property     | `string` | 1024   | Y    | Y        |  属性json格式       |
| identityType | `string` | 32     | N    | Y        |  type:user/node/domain       |
| kyc          | `string` | 4096   | N    | Y        |  kyc信息       |


- 响应参数：

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| txId | `string` |  64        | Y    | Y        | 交易id |                           |

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


#### Identity冻结

##### <a id="FREEZE_IDENTITY">Identity冻结</a>

- [x] 开放
- 接口描述：  Identity冻结
- type：`FREEZE_IDENTITY`
- 请求参数： 

|    属性            | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-------------- :  | -------- | -------- | ---- | -------- | :---------------------------- |
| targetAddress      | `string` | 40     | Y    | Y        | Identity地址                      |


- 响应参数：

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| txId | `string` | 64         | Y    | Y        | 交易id |                           |

- 实例：

```json tab="请求实例"
{
   "datas":
    	    {
	          "address":"5342594ae09e2f8844464824e24e61334603bc49",
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

#### Identity解冻

##### <a id="UNFREEZE_IDENTITY">Identity解冻</a>

- [x] 开放
- 接口描述：  Identity解冻
- type：`UNFREEZE_IDENTITY`
- 请求参数： 

|    属性            | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-------------- :  | -------- | -------- | ---- | -------- | :---------------------------- |
| targetAddress      | `string` | 40     | Y    | Y        | Identity地址                      |


- 响应参数：

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| txId | `string` |  64        | Y    | Y        | 交易id |                           |

- 实例：

```json tab="请求实例"
{
   "datas":
    	    {
	          "address":"5342594ae09e2f8844464824e24e61334603bc49",
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


##### Identity鉴权
- [x] 开放
- 接口描述：  检查用户是否有鉴别的权限
- 请求地址：`POST`：`identity/checkPermission`
- 请求参数：(无签名) 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | N        | 用户地址                     |
| permissionNames | `<string[]>` | 1024     | Y    | Y        | 需要检查的权限，数组                     |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| data | `boolean` | 64     | Y    | Y        | 检查结果，成功返回true,失败返回false                      |

- 实例：

``` tab="请求实例"
{
	"address":"33c1237c1a99284ebe001f102eee70cf6a306866",
	"permissionNames":[
		"RS"
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
- 请求地址：`GET`:`identity/query?address={address}`
- 请求参数：

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| address | `string`   | 40       | Y    | Y        | identity地址              |


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
| kyc | `string` |1024      | Y    | Y        | identity认证信息                      |
| permissions | `string` | 64     | Y    | Y        | 权限编号(32进制)                      |
| preTxId | `string` | 64     | Y    | Y        |  上次identity被修改时交易id                   |
| property | `string` | 1024     | Y    | Y        |  扩展属性                   |

- 实例：
```json tab="请求实例"

```

```json tab="响应实例"
{
	"data":{
		"address":"33c1237c1a99284ebe001f102eee70cf6a306866",
		"hidden":1,
		"kyc":"{\"a\":\"1\",\"b\":\"1\",\"c\":\"1\"}",
		"permissions":"5",
		"preTxId":"",
		"currentTxId":"2357f642afea07282916ff879c9e12430ea61bd5387946499464759a687a4236"
}
```


#### <a id="SET_ATTESTATION">存证</a>

- [x] 开放
- 接口描述：  保存存证信息入链
- functionId：`SET_ATTESTATION`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| attestation | `string` | 4096     | Y    | Y        | 存证内容                      |
| id   | `string` | 64       | Y    | N        | 存证Id（唯一）                      |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | txId                      |

- 实例：

```json tab="请求实例"
{
	"txData":"{\"txId\":\"19d486684f268b79660875b45d70b81bff5052a08d8c3fe3188eec148936bda9\",\"bdId\":\"sto_code_token2256\",\"functionId\":\"SET_ATTESTATION\",\"type\":\"SET_ATTESTATION\",\"submitter\":\"b8da898d50712ea4695ade4b1de6926cbc4bcfb9\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"attestation\":\"modify  xxxxxxxxxxx v2\",\"id\":\"cc41355f8fe4100337ded5ddad0df2f1d651c7da3ecc7c79ce1161c8ecd9400f\"},\"version\":\"4.0.0\"}}",
	"txSign":"010bc1fecff8bbdc3418f57aaa04fc69c95f4ed0ff4193dcf079fba27d4141803c30657b0a4b448019048850f4a1aa27b49b98f83c5281a904c8754d0547069032"
}
```

```json tab="响应实例"
{
    respCode='000000',
    msg='Success', 
    data=19d486684f268b79660875b45d70b81bff5052a08d8c3fe3188eec148936bda9
}
```

##### 存证查询
- [x] 开放
- 接口描述：  查询入链存证信息
- 请求地址：`GET`:`queryAttestation/{id}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| id | `string` | 64     | Y    | Y        | 存证id                      |

- 响应参数：

|    属性        | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ---- | -------- | :---------------------------- |
| id            | `string` | 64     | Y        | Y        | 存证id                      |
| attestation   | `string` | 4096       | Y    | N        | 存证内容                      |
| preTxId       | `string` | 64       | Y     | N        | 上次一次修改`txId` |
| currentTxId   | `string` | 64       | Y     | N        | 最近一次修改`txId` |
| version       | `int`    | 10       | Y     | N        | 版本号，系统自增 |
| bdId          | `string` | 32       | Y     | N        | 设置存证时的`bdId` |

- 实例：

```json tab="请求实例"
/queryAttestation/cc41355f8fe4100337ded5ddad0df2f1d651c7da3ecc7c79ce1161c8ecd9400f
```

```json tab="响应实例"
{
	"data":{
		"attestation":"modify xxxxxxxxxxx",
		"bdId":"sto_code_token1308",
		"id":"cc41355f8fe4100337ded5ddad0df2f1d651c7da3ecc7c79ce1161c8ecd9400f",
		"preTxId":"9ae0f0c2fda16dafe6f86f71360aabbb58e2853599470d23314db559b95b887b",
		"version":2,
		"currentTxId":"30d5f16f0a2808a96eabd0d71ae7cb218c4a7bb65bbd256bfeec64193bfa572b"
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

[1]: query-api.md#queryMaxHeight 
[2]: query-api.md#queryTxByTxId/{txId} 
[3]: query-api.md#queryTxsByHeight/{height}
[4]: query-api.md#queryContract
