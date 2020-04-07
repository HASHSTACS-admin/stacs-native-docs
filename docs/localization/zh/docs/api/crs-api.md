# CRS接口文档

接口分为区分系统级和非系统级接口， 系统级接口仅供内部RS节点调用，对外接口均为非系统级接口。
非系统级接口又分为查询类接口和交易类接口，查询类接口采用GET请求，接口无安全性设计考虑；交易类接口采用POST请求，
请求数据采用AES256加密，并会将加密数据采用ECC签名，具体参见接口规范


## **术语**
---
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


## **系统内置**
--- 
1. 系统内置Function

    | functionidId      	| execPermission | execPolicy         	    | 备注 |
    | :-----                |  :-----        |  :-----                  |  :-----            |
    | ADD_BD  			    | DEFAULT        | SYNC_ONE_VOTE_DEFAULT   	|发布BD      |
    | SET_POLICY  		    | DEFAULT        | SYNC_ONE_VOTE_DEFAULT   	|设置Policy      |
    | ADD_RS  			    | DEFAULT        | ADD_RS   	            |RS注册      |
    | REMOVE_RS  			| RS        	 | REMOVE_RS   	  		    |RS撤销      |
    | ADD_CA  				| DEFAULT        | ADD_CA   	  		    |CA认证      |
    | UPDATE_CA  			| RS             | UPDATE_CA   	  		    |CA更新      |
    | REMOVE_CA  			| RS        	 | REMOVE_CA   	  		    |CA撤销      |
    | ADD_NODE  			| DEFAULT        |  ADD_NODE   	  		    |加入节点      |
    | REMOVE_NODE  			| DEFAULT     | REMOVE_NODE   	  	    |退出节点      |

2. 系统内置Permission
    
    | Permission      	    | 备注 |
    | :-----                |  :-----        |
    | DEFAULT  	            | 系统默认所有地址都拥有DEFAULT的Permission       |
    | RS  			        | 系统节点初始化时RS节点拥有该Permission        |

3. 系统内置Policy
    
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
    |SYNC_ONE_VOTE_DEFAULT  |  SYNC             |ONE_VOTE          |  |
    |ASYNC_DEFAULT      	|  ASYNC            |FULL_VOTE          |  |
    |SYNC_DEFAULT      		|  SYNC             |FULL_VOTE          |  |

## **接口规范**
---
1. HTTP请求头

    *   `GET`：**无额外参数**
    
    *   `POST`:         
        `Content-Type: application/json`  
        `merchantId:{merchantId}`: CRS分配的
        
    
2. Http响应

    * 响应状态码 200
  
3. 安全性
  
    所有POST请求数据采用AES256加密，并会附上原始数据的签名; 响应数据也同样采用AES256加密，并附上CRS对原始响应数据的签名，加密并签名的数据格式如下：
    
    - 请求数据格式
        
          |     属性     | 类型     | 说明                                                         |
          | :----------: | -------- | ------------------------------------------------------------ |
          | requestParam | `string` | 请求数据，将原始请求数据采用{merchantAesKey}加密后使用BASE64编码, 加密可选 |
          |  signature   | `string` | 商户签名，将原始请求数据采用{merchantPriKey}签名后的HEX格式数据 |
          
        - <a id="requestParam">requestParam参数列表</a>
          
          |     属性     | 类型     | 说明                                                         |
          | :----------: | -------- | ------------------------------------------------------------ |
          | txData       | `string` | 请求原始数据                                                   |
          | txSign       | `string` | 请求原始数据的签名(用户级)                                       |
          
          示例：
          ```json 
          {
             "txData":"{"txId":"7c587484f89c91ab6481ea3ccaf581ac2543cf5fcd047816d9b3b7a0361ce28c","bdCode":"SystemBD","functionId":"ADD_BD","submitter":"b8da898d50712ea4695ade4b1de6926cbc4bcfb9","version":"4.0.0","actionDatas":{"datas":{"bdVersion":"4.0.0","code":"sto_code","contracts":[{"createPermission":"DEFAULT","createPolicy":"BD_PUBLISH","desc":"余额查询-1","functions":[{"desc":"余额查询","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(uint256) balanceOf(address)","id":"balanceOf","type":"Contract"},{"desc":"转账","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(bool) transfer(address,uint256)","id":"transfer","type":"Contract"}],"templateCode":"code-balanceOf-1"},{"createPermission":"DEFAULT","createPolicy":"BD_PUBLISH","desc":"余额查询-2","functions":[{"desc":"余额查询","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(uint256) balanceOf(address)","id":"balanceOf","type":"Contract"},{"desc":"转账","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(bool) transfer(address,uint256)","id":"transfer","type":"Contract"}],"templateCode":"code-balanceOf-2"}],"label":"sto_code_name"},"version":"4.0.0"}}",
                 "txSign":"017ee57b7567039c214f0b27a186e567277731a95ad09baa84d8092cd8af125c29342a234ea67a0d095a36f63e92b49adb57d66e7909499992ee7eae12bc7451c3"}
          }
          ```
        
    - 响应数据格式
        
          |   属性    | 类型     | 说明                                                         |
          | :-------: | -------- | ------------------------------------------------------------ |
          | respCode  | `string` | 返回状态码，000000为成功，其他为失败                         |
          |    msg    | `string` | 返回状态描述                                                 |
          |   data    | `string` | 响应数据，将原始响应数据采用{merchantAesKey}加密后使用BASE64编码-aesKey不配置时不做解密 |
          | signature | `string` | CRS签名，将原始响应数据采用{crsPriKey}签名后的HEX格式数据   |
        
4. 实例

    ```json tab="请求实例"
    {
        "requestParam": "{
            "txData":"{
                "txId":"txId-123",
                "bdCode":"SystemBD",
                "functionId":"BD_PUBLISH",
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

### 统一交易提交接口
- [x] 开放
- 接口描述：  功能：发起交易
   1. 所有类型的交易都需要指定`bdId`
- 请求地址：`POST`: `/submitTx`
- 请求参数：

|    属性     | 类型                  | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------------------- | --------| ---- | -------- | :-------------------------------- |
| txData      | `string`             |        | Y    | Y        | 交易数据，json格式，参见`交易数据列表`|
| txSign      | `string`             |        | Y    | Y        | 交易签名                             |

- <a id="COMMON_PRAMS_LIST">交易数据列表</a>

|     属性      | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| :-----------: | -------- | -------- | ---- | :------: | ------------------------------------------------------------ |
| txId          | `string` | 64       | Y    |    Y     | 请求Id |
| bdId        | `string` | 32       | Y    |    Y     | 所有业务交易都需要指定bdCode                                       |
| templateId  | `string` | 32       | N    |    Y     |发布合约或执行合约方法时的合约templateCode                           |
| type          | `string` | 32       | N    |    Y     |系统级actionType                                                  |
| subType       | `string` | 32       | N    |    Y     |子业务类型                                             |
| sessionId     | `string` | 64       | N    |    Y     |订单id                                            |
| functionId  | `string` | 32          | Y    |    Y     | BD的functionId，如果是BD的初始化或者合约的发布：`ADD_CONTRACT` |
| submitter     | `string` | 40       | Y    |    Y     | 操作提交者地址                                               |
| actionDatas   | `string` | text     | Y    |    Y     | 业务参数JSON格式化数据，json数据包含{"version":"4.0.0","datas":{}}，datas为Json格式数据，数据参见各交易接口|
| version       | `string` | 40       | Y    |    Y     | 交易版本号                                               |
|extensionDatas | `string` | 1024     | N    |    Y     | 交易存证新消息                                               |
| submitterSign | `string` | 64       | Y    |    N     | 提交者`submitter`的`ECC`对交易的签名,该字段不参与签名                                                   |

- 实例：

```json tab="请求实例"
    {
    	"txData":"{\"txId\":\"769b222dec0c49f39a2c80cb14a3da6470a92397fec8b164f20c56a2eaa2d8af\",\"bdId\":\"SystemBD\",\"functionId\":\"ADD_BD\",\"type\":\"ADD_BD\",\"submitter\":\"b8da898d50712ea4695ade4b1de6926cbc4bcfb9\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"bdVersion\":\"4.0.0\",\"functions\":[{\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"methodSign\":\"SET_ATTESTATION\",\"id\":\"SET_ATTESTATION\",\"type\":\"SystemAction\"}],\"id\":\"sto_code_token5476\",\"label\":\"sto_code__token_name\"},\"version\":\"4.0.0\"}}",
    	"txSign":"01b1eb09ff94d9d136597bb1b5665b5322203b0f56abee6c521bad91fa99b6bfb930520b74dab0e88e120e26a48d87e5e0dcaf5293bc0242e74b525f4eb9f8517b"
    }

```

```json tab="响应实例"
  {
     respCode='000000',
     msg='Success', 
     data=b81855f921bf87823a51c89457f136d242b67ef8d7c67c97f764ca05b8548b40
  }

```

###  签名
 交易签名值拼接方式 
``` java

    /**
     * should sign fields
     */
    private static String[] SIGN_FIELDS = new String[]
        {"txId","bdId","functionId","templateId","type","submitter","version","actionDatas","extensionDatas","subType","sessionId"};

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

### 接口索引

1. 交易接口列表

    | 接口type                                             | 是否系统级 | 说明 |  
    | :-----                                     |:---:              | :-----    |
    |<a href="#ADD_RS">ADD_RS</a>                       |Y     |RS注册|
    |<a href="#REMOVE_RS">REMOVE_RS</a>                 |Y     |RS撤销|
    |<a href="#ADD_CA">ADD_CA</a>                       |Y     |CA认证|
    |<a href="#UPDATE_CA">UPDATE_CA</a>                 |Y     |CA更新|
    |<a href="#REMOVE_CA">REMOVE_CA</a>                 |Y     |CA撤销|
    |<a href="#ADD_NODE">ADD_NODE</a>                   |Y     |节点加入|
    |<a href="#REMOVE_NODE">REMOVE_NODE</a>             |Y     |退出节点|
    |<a href="#ADD_BD">ADD_BD</a>                       |N      |发布BD|
    |<a href="#SET_POLICY">SET_POLICY</a>             	|N      |设置Policy|
    |<a href="#SET_PERMISSION">SET_PERMISSION</a>     	|N  	|Permission设置|
    |<a href="#ADD_CONTRACT">ADD_CONTRACT</a>           |N      |合约创建|
    |<a href="#EXECUTE_CONTRACT">EXECUTE_CONTRACT</a>   |N      |合约执行|
    |<a href="#SET_IDENTITY">SET_IDENTITY</a>           |N      |Identity设置|
    |<a href="#FREEZE_IDENTITY">FREEZE_IDENTITY</a>     |N      |Identity冻结|
    |<a href="#UNFREEZE_IDENTITY">UNFREEZE_IDENTITY</a> |N      |Identity解冻|
    |<a href="#SET_ATTESTATION">SET_ATTESTATION</a>     |N    	|存证|
    |<a href="#ADD_SNAPSHOT">ADD_SNAPSHOT</a>           |N  |快照交易|


2. 查询接口列表
    
    | 接口地址                                                          | 说明 |
    | :-----                                                           | :-----    |
    |[queryMaxHeight][1]                  |查询当前最大区块高度|
    |[queryTxByTxId/{txId}][2]            |根据txId查询交易数据|
    |[queryContract][4]                   |合约数据状态查询|


### 快速接入
更快接入参考SDK提供的`SubmitTransactionExample`实例
``` java

<dependency>
    <groupId>com.hashstacs</groupId>
    <artifactId>stacs-client</artifactId>
    <version>4.1.1-SNAPSHOT</version>
</dependency>

```

## **系统级接口**
---

!!! info "提示"
    系统级接口只能由`CRS`节点发起，并不对`DRS`和上层应用开放。

### `Domain & RS`
>   `Domain`管理旗下`RS`节点的接口，让节点可以**注册**到`Domain`中参与交易处理，也可以**移除**`domain`下指定节点

#### <a id="ADD_RS">注册RS</a>
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
| txId | `string` | 64     | Y    | Y        | 交易id                      |


#### <a id="REMOVE_RS">移除RS</a>

- [ ] 开放

- 接口描述：  移除已注册的 RS

- type：`REMOVE_RS`

- 请求参数： 

| 属性 | 类型     | 最大长度 | 必填 | 是否签名 | 说明 |
| :---------: | -------- | -------- | ---- | -------- | :-------------------------|
| rsId | `string` | 32       | Y    | Y        |      |
  
- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :-------------------------|
| txId | `string` |  64    | Y    | Y        | 交易id                      |

### `CA`管理
> 用于管理节点CA, 节点在加入集群前必须在链上有可信的CA

#### <a id="ADD_CA">注册`CA`</a>
- [x] 开放
- 接口描述： 将CA上链
- type：`ADD_CA`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ----  | -------- | :---------------------------- |
| caList        | `json[]` |1024        | Y       | Y        | ca集合(签名拼接需要将caList中的每个ca拼接)                      |

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
| txId | `string` | 64     | Y    | Y        | 交易id                      |

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
	]
} 
```

```json tab="响应实例"
{"data":null,"msg":"Success","respCode":"000000","success":true}  
```

#### <a id="UPDATE_CA">更新`CA`</a>
- [x] 开放
- 接口描述： 更新CA
- type：`UPDATE_CA`

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| period | `string`   | 20     | Y    | Y        | 过期时间                      |
| pubKey | `string`   | 131    | Y    | Y        | 公钥                      |
| user   | `string`   | 32     | Y    | Y        | 节点名称                      |
| domainId | `string` | 32     | Y    | Y        | 域                      |
| usage | `string`    | 10     | Y    | Y        | 使用类型biz/consensus                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` |  64    | Y    | Y        | 交易id                      |

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

#### <a id="REMOVE_CA">撤销`CA`</a>
- [x] 开放
- 接口描述： 撤销CA，设置CA为不可用
- type：`REMOVE_CA`

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| pubKey | `string` | 131     | Y    | Y        | 公钥                      |
| user | `string` | 32     | Y    | Y        | 节点名称                      |
| domainId | `string` | 32     | Y    | Y        | 域                      |
| usage | `string` | 10     | Y    | Y        | 使用类型biz/consensus                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | 交易id                      |

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


### 节点管理
> 用于维护集群节点

#### <a id="ADD_NODE">节点加入</a>
- [x] 开放
- 接口描述： 节点加入共识网络
- type：`ADD_NODE`
- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| nodeName  | `string` |   32       | Y    | Y        | 加入的节点名称 |
| domainId  | `string` |   32       | Y    | Y        |   domain域             |
| signValue | `string` |   1024      | Y    | Y        |   签名值             |
| selfSign | `string` |   130      | Y    | Y        |   自签名后的签名值             |
|  pubKey   | `string` |    131      | Y    | Y        | 节点公钥       |


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




#### <a id="REMOVE_NODE">节点退出</a>

- [x] 开放
- 接口描述： 节点退出
- type：`REMOVE_NODE`
- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| nodeName  | `string` |  32        | Y    | Y        | 加入的节点名称 |
| domainId  | `string` |  32        | Y    | Y        |   domain域             |
| signValue | `string` |  1024        | Y    | Y        |                |
| selfSign | `string` |    130      | Y    | Y        |            对signValue的签名    |
|  pubKey   | `string` |  131       | Y    | Y        | 节点公钥       |


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

### <a id="SET_POLICY">设置Policy</a>

- [x] 开放
- 接口描述： 设置Policy
- type：`SET_POLICY`
- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| policyId       | `string`       | 32       | Y    | Y        | 注册/修改的policyId                               |
| label          | `string`       | 64       | Y    | Y        |                                              |
| votePattern    | `string`       | 10        | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| callbackType   | `string`       | 10         | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
| decisionType   | `string`       | 10         | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| domainIds      | `list<string>` | 256         | N    | Y        | 参与投票的domainId列表                       |
| requireAuthIds | `list<string>` | 256         | Y    | Y        | 需要通过该集合对应的domain授权才能修改当前policy |
| assignMeta     | `json` | 1024         | N    | Y        | 当decisionType=ASSIGN_NUM,assignMeta属性值需要签名 |

- assignMeta结构

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| verifyNum | `int` |      10    | N    | Y        | 当decisionType=ASSIGN_NUM时签名需要, the number to verify  |
| expression | `string` |   256       | N    | Y        | 当decisionType=ASSIGN_NUM时签名需要,the expression for vote rule example: n/2+1 |
| mustDomainIds | `list<string>` | 256         | N    | Y        |当decisionType=ASSIGN_NUM时签名需要  |


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


## **非系统级接口**
---
### <a id="ADD_BD">BD发布</a>
- [ ] 开放
- 接口描述：  功能：发布自定义`BD`
   1. 所有类型的交易都需要指定`bdId`,系统内置`BD`参考()；
   2. 发布BD使用用到的`Policy`和`execPermission`，链上必须存在（参考`注册Permission`和`注册Policy`功能）
- type：`ADD_BD`
- 请求参数： 

|    属性     | 类型                  | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------------------- | -------- | ---- | -------- | :-------------------------------- |
| id      | `string`                 |32       | Y    | Y        | BD编号（唯一）                      |
| label      | `string`              |32       | Y    | Y        | BD名称                             |
| desc      | `string`               |1024     | N    | Y        | 描述                      |
| functions | `List<FunctionDefine>` |     | N    | Y        | bd定义function            |
| contracts | `List<ContractDefine>` |     | N    | Y        | bd定义contract            |
| bdVersion | `string`               | 16       | Y    | Y        | bd版本                    |

`ContractDefine`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------:    | -------- | -------------- | ---- | -------- | :---------------------------- |
| templateId   | `string` | 32             | Y    | Y        | 合约模板名称，在同一个bd下不能重复                      |
| desc             | `string` | 256            | N    | Y        | function描述                     |
| createPermission | `string` | 64             | Y    | Y        | 合约发布时的权限,,发布bd时，该permission已经存在于链上 |
| createPolicy     | `string` | 32             | Y    | Y        | 合约发布时的 policy,发布bd时，该policy已经存在于链上                |
| functions        | `List<FunctionDefine>`    |      | Y        | Y        | 合约方法定义function            |

`FunctionDefine`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:    | -------- | -------- | ---- | -------- | :---------------------------- |
| desc           | `string` | 256     | N    | Y        | function描述                     |
| execPermission | `string` | 64     | Y    | Y        | 执行function权限,发布bd时，该permission已经存在于链上                   |
| execPolicy     | `string` | 32     | Y    | Y        | 执行function policy,发布bd时，该policy已经存在于链上                      |
| methodSign     | `string` | 256     | Y    | Y        | 如果发布的是合约则填写的合约方法签名
| id           | `string` | 32     | Y    | Y        | function名称在同一个bd下不能重复                      |
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
    	"txData":"{\"txId\":\"769b222dec0c49f39a2c80cb14a3da6470a92397fec8b164f20c56a2eaa2d8af\",\"bdId\":\"SystemBD\",\"functionId\":\"ADD_BD\",\"type\":\"ADD_BD\",\"submitter\":\"b8da898d50712ea4695ade4b1de6926cbc4bcfb9\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"bdVersion\":\"4.0.0\",\"functions\":[{\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"methodSign\":\"SET_ATTESTATION\",\"id\":\"SET_ATTESTATION\",\"type\":\"SystemAction\"}],\"id\":\"sto_code_token5476\",\"label\":\"sto_code__token_name\"},\"version\":\"4.0.0\"}}",
    	"txSign":"01b1eb09ff94d9d136597bb1b5665b5322203b0f56abee6c521bad91fa99b6bfb930520b74dab0e88e120e26a48d87e5e0dcaf5293bc0242e74b525f4eb9f8517b"
    }

```

```json tab="响应实例"
{
respCode='000000', 
msg='Success', 
data=769b222dec0c49f39a2c80cb14a3da6470a92397fec8b164f20c56a2eaa2d8af}
```

### 快照
#### <a id="ADD_SNAPSHOT">快照发布</a>

- [ ] 开放
- 接口描述： 申请一个快照版本，入链后记录当前快照处理的区块高度，快照申请成功后，可以按区块高度查询到申请快照时的信息 
（快照发布使用的是存证的execPolicyId和id）
- type：`ADD_SNAPSHOT`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| remark      | `string` | 1024      | Y    | Y        | 快照备注                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | 交易id                      |

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

#### 快照查询

- [ ] 开放
- 接口描述：  
- 请求地址：`GET`:`/snapshot/query?txId={txId}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | 交易id                      |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| blockHeight | `int` |   10   | Y    | Y        | 区块高度                      |
| remark     | `string` |  1024    | Y    | Y        | 备注                      |

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

### 智能合约

#### <a id="ADD_CONTRACT">合约部署</a>

- [ ] 开放
- 接口描述：用户发布自定义合约实现业务(合约代码需要提前编译)
- type：`ADD_CONTRACT`
- 请求参数：

| 属性            | 类型       | 最大长度 | 必填 | 是否签名 | 说明                       |
| --------------- | ---------- | -------- | ---- | -------- | -------------------------- |
| contractAddress | `string`   | 40       | Y    | Y        | 合约地址 |
| id              | `string`   | 64       | Y    | Y        | 合约名称                   |
| label           | `string`   | 64       | N    | Y        | 合约简称                   |
| contractor      | `string`   | 1024     | Y    | Y        | 合约构造器(函数)名         |
| sourceCode      | `string`   | text       | Y    | Y      | 合约代码                   |
| opCode          | `string`   | text     | Y    | Y        | 合约编译后的指令           |
| abi             | `string`   | text        | Y    | Y     | 合约abi                   |
| initArgs        | `object[]` |          | N    | Y        | 合约构造入参（签名时需使用逗号分隔拼接(参见StringUtils.join(args,",")),如果参数中包含数组，数组请使用JSONArray来装）              |

- 响应参数：

| 属性            | 类型       | 最大长度 | 必填 | 是否签名 | 说明                       |
| --------------- | ---------- | -------- | ---- | -------- | ---------------------|
| txId | `string` |  64    | Y    | Y        | 交易id                      |

- 编译合约代码示例
```java
        ContractCreateVO actionData = new ContractCreateVO();
        /**
         * 使用sdk中编译工具类
         * 参数一：合约源代码
         * 参数二：合约构造方法
         * 参数三：合约构造方法参数
         */
        CompileContractResult contractResult = ContractCompileUtil
            .buildContract(actionData.getSourceCode(), actionData.getContractor(), actionData.getInitArgs());
        //将编译结果code设置到参数opCode
        actionData.setOpCode(contractResult.getCode());
        //将编译结果abi设置到参数abi
        actionData.setAbi(contractResult.getAbi().toJson());
```

- 实例：
```json tab="请求实例"
{
	"datas":{
    			"contractor":"Bonds_TypeA(uint256,address,string,address)",
    			"sourceCode":"pragma solidity ^0.4.24;\n\ncontract Common {\n\n    bytes32 constant TX_ID = bytes32(0x00000000000000000000000000000000000000000000000000000074785f6964);\n    bytes32 constant STACS_KEY_ADDR = bytes32(0x5354414353000000000000000000000000000000000000000000000000000002);\n\n    event Transfer(address indexed from, address indexed to, uint256 value);\n    event AddressLog(address);\n\n    //assemble the given address bytecode. If bytecode exists then the _addr is a contract.\n    function isContract(address _addr) public view returns (bool is_contract) {\n        uint length;\n        assembly {\n        //retrieve the size of the code on target address, this needs assembly\n            length := extcodesize(_addr)\n        }\n        return (length > 0);\n    }\n}\n\ninterface TokenContract {\n    function batchTransfer(address[] toAdd, uint256[] amount) external returns (bool success);\n\n    function transfer(address _to, uint256 _value) external returns (bool success);\n}\n\ncontract Bonds_TypeA is Common {\n\n    uint16 constant MAX_NUMBER_OF_QUERY_PER_PAGE = 100;\n    uint256 total;\n    uint8 decimals = 8;\n    address issuer;\n    address owner;\n    string kycExp;\n    address disbursementToken;\n    bool buyBackFroze = false;\n\n    struct Balance {\n        uint256 balance;\n        bool exists;\n    }\n\n    mapping(address => Balance) balance;\n    address[] addresses;\n\n    constructor (\n        uint256 _total,\n        address _owner,\n        string _kycExp,\n        address _disbursementToken\n    ) public {\n        require(_owner != 0x0, \"owner address is 0x0\");\n        require(_total > 0, \"total is illegal\");\n        require(_disbursementToken != 0x0, \"_disbursementToken address is 0x0\");\n\n        total = _total;\n        issuer = msg.sender;\n        owner = _owner;\n        kycExp = _kycExp;\n        disbursementToken = _disbursementToken;\n        balance[owner].balance = total;\n        balance[owner].exists = true;\n        addresses.push(owner);\n    }\n\n    function balanceOf(address _owner) public view returns (uint256 balanceAmount){\n        balanceAmount = balance[_owner].balance;\n        return (balanceAmount);\n    }\n\n    function pagingQuery(uint32 currentPage, uint32 pageSize) public view returns (address[], uint256[], uint256){\n        require(currentPage >= 1 && pageSize >= 1);\n        if (pageSize > MAX_NUMBER_OF_QUERY_PER_PAGE) {\n            pageSize = MAX_NUMBER_OF_QUERY_PER_PAGE;\n        }\n        uint256 addressLength = addresses.length;\n        if (pageSize > addressLength) {\n            pageSize = uint32(addressLength);\n        }\n        address[] memory addrs;\n        uint256[] memory balanceResult;\n\n        uint32 start = (currentPage - 1) * pageSize;\n        if (start >= addressLength) {\n            return (addrs, balanceResult, addressLength);\n        }\n\n        uint32 arrayInitLength = calculateArrayInitLength(currentPage, pageSize, addressLength);\n        addrs = new address[](arrayInitLength);\n        balanceResult = new uint256[](arrayInitLength);\n\n        for (uint16 i = 0; i < arrayInitLength; i++) {\n            address tmpAddress = addresses[start];\n            addrs[i] = tmpAddress;\n            balanceResult[i] = balance[tmpAddress].balance;\n            start++;\n        }\n\n        return (addrs, balanceResult, addressLength);\n    }\n\n    function transfer(address _to, uint256 _value) public payable returns (bool success){\n\n        if (bytes(kycExp).length != 0 && !isContract(_to)) {\n            require(checkKyc(_to, kycExp), \"_to address kyc verify failed\");\n        }\n        require(!buyBackFroze, \"buyBackFroze is true\");\n        return transferFrom(msg.sender, _to, _value);\n    }\n\n    function batchTransfer(address[] _addrs, uint256[] _values) public returns (bool success){\n        require(_addrs.length == _values.length, \"addrs length must eq _values length\");\n        require(_addrs.length > 0, \"address array length is 0\");\n        require(!buyBackFroze, \"buyBackFroze is true\");\n        for (uint16 i = 0; i < _addrs.length; i++) {\n            if (_values[i] != 0) {\n                if (bytes(kycExp).length != 0 && !isContract(_addrs[i])) {\n                    require(checkKyc(_addrs[i], kycExp), \"_to address kyc verify failed\");\n                }\n                transferFrom(msg.sender, _addrs[i], _values[i]);\n            }\n        }\n        return true;\n    }\n\n    function additionalIssue(uint256 num) public returns (bool){\n        require(num > 0, \"num is illegal\");\n        require(!buyBackFroze, \"buyBackFroze is true\");\n        total += num;\n        balance[owner].balance += num;\n        require(total > 0, \"The data of crossing the line\");\n        return true;\n    }\n\n    function interestSettle(address[] _addrs, uint256[] _values) public returns (bool success){\n        require(_addrs.length == _values.length);\n        require(_addrs.length > 0, \"address array length is 0\");\n        require(!buyBackFroze, \"buyBackFroze is true\");\n        TokenContract tokenContract = TokenContract(disbursementToken);\n        tokenContract.batchTransfer(_addrs, _values);\n        return true;\n    }\n\n    function buybackFroze() public returns (bool){\n        buyBackFroze = true;\n        return true;\n    }\n\n    function buyback(address[] _addrs, uint256[] _values, uint256[] payAmount) public returns (bool success){\n        require(_addrs.length == _values.length);\n        require(_values.length == payAmount.length);\n        require(_addrs.length > 0, \"address array length is 0\");\n        require(buyBackFroze, \"buyback must buyBackFroze is true\");\n        //buy back bonds\n        for (uint16 i = 0; i < _addrs.length; i++) {\n            require(balance[_addrs[i]].balance == _values[i], \"address balance must eq value\");\n            require(transferFrom(_addrs[i], owner, _values[i]), \"transfer failed\");\n        }\n\n        //send usd\n        TokenContract tokenContract = TokenContract(disbursementToken);\n        require(tokenContract.batchTransfer(_addrs, payAmount), \"send usd failed\");\n\n        return true;\n    }\n\n    function withdrawal(address contractAddress, address to, uint256 amount) public returns (bool){\n        require(amount > 0, \"amount is 0\");\n        require(isContract(contractAddress), \"contractAddress is not contract\");\n        TokenContract tokenContract = TokenContract(contractAddress);\n        require(tokenContract.transfer(to, amount), \"withdrawal failed\");\n        return true;\n    }\n\n    function transferFrom(address _from, address _to, uint256 _value) internal returns (bool){\n        require(_to != 0x0, \"to address is 0x0\");\n        require(_value > 0, \"The value must be that is greater than zero.\");\n        emit AddressLog(_from);\n        emit AddressLog(_to);\n        require(balance[_from].balance >= _value, \"from address balance not enough\");\n        uint256 result = balance[_to].balance + _value;\n        require(result > 0, \"to address balance overflow\");\n        require(result > balance[_to].balance, \"to address balance overflow\");\n\n        uint previousBalance = balance[_from].balance + balance[_to].balance;\n        balance[_from].balance -= _value;\n        if (!balance[_to].exists) {\n            balance[_to].balance = _value;\n            balance[_to].exists = true;\n            addresses.push(_to);\n        }\n        else {\n            balance[_to].balance += _value;\n        }\n        emit Transfer(_from, _to, _value);\n        assert(balance[_from].balance + balance[_to].balance == previousBalance);\n        return true;\n    }\n\n    function totalSupply() public view returns (uint256){\n        return total;\n    }\n\n    function calculateArrayInitLength(uint32 currentPage, uint32 pageSize, uint256 arrayLength) private pure returns (uint32){\n        if (arrayLength % pageSize == 0) {\n            return pageSize;\n        }\n        uint allPageSize = arrayLength / pageSize + 1;\n        if (currentPage <= allPageSize - 1) {\n            return pageSize;\n        }\n        uint32 arrayInitLength = uint32(arrayLength - (currentPage - 1) * pageSize);\n        return arrayInitLength;\n    }\n\n    function checkKyc(address userAddress, string kyc) public returns (bool){\n\n        bytes memory input = abi.encode(userAddress, kyc);\n        bytes32[1] memory output;\n        uint inputSize = input.length + 32;\n        bytes32 callAddress = STACS_KEY_ADDR;\n        assembly{\n            let success := call(\n            0,\n            callAddress,\n            0,\n            input,\n            inputSize,\n            output,\n            32)\n        }\n        if (output[0] == bytes32(0x0000000000000000000000000000000000000000000000000000000000000001)) {\n            return true;\n        } else {\n            return false;\n        }\n\n    }\n}",
    			"abi":"[{\"constant\":false,\"name\":\"withdrawal\",\"inputs\":[{\"name\":\"contractAddress\",\"type\":\"address\"},{\"name\":\"to\",\"type\":\"address\"},{\"name\":\"amount\",\"type\":\"uint256\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":true,\"name\":\"isContract\",\"inputs\":[{\"name\":\"_addr\",\"type\":\"address\"}],\"outputs\":[{\"name\":\"is_contract\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":true,\"name\":\"totalSupply\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"buyback\",\"inputs\":[{\"name\":\"_addrs\",\"type\":\"address[]\"},{\"name\":\"_values\",\"type\":\"uint256[]\"},{\"name\":\"payAmount\",\"type\":\"uint256[]\"}],\"outputs\":[{\"name\":\"success\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":true,\"name\":\"balanceOf\",\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"outputs\":[{\"name\":\"balanceAmount\",\"type\":\"uint256\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"checkKyc\",\"inputs\":[{\"name\":\"userAddress\",\"type\":\"address\"},{\"name\":\"kyc\",\"type\":\"string\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"batchTransfer\",\"inputs\":[{\"name\":\"_addrs\",\"type\":\"address[]\"},{\"name\":\"_values\",\"type\":\"uint256[]\"}],\"outputs\":[{\"name\":\"success\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"buybackFroze\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"transfer\",\"inputs\":[{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_value\",\"type\":\"uint256\"}],\"outputs\":[{\"name\":\"success\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":true},{\"constant\":false,\"name\":\"additionalIssue\",\"inputs\":[{\"name\":\"num\",\"type\":\"uint256\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":true,\"name\":\"pagingQuery\",\"inputs\":[{\"name\":\"currentPage\",\"type\":\"uint32\"},{\"name\":\"pageSize\",\"type\":\"uint32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"address[]\"},{\"name\":\"\",\"type\":\"uint256[]\"},{\"name\":\"\",\"type\":\"uint256\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"interestSettle\",\"inputs\":[{\"name\":\"_addrs\",\"type\":\"address[]\"},{\"name\":\"_values\",\"type\":\"uint256[]\"}],\"outputs\":[{\"name\":\"success\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"name\":\"\",\"inputs\":[{\"name\":\"_total\",\"type\":\"uint256\"},{\"name\":\"_owner\",\"type\":\"address\"},{\"name\":\"_kycExp\",\"type\":\"string\"},{\"name\":\"_disbursementToken\",\"type\":\"address\"}],\"type\":\"constructor\",\"payable\":false},{\"anonymous\":false,\"name\":\"Transfer\",\"inputs\":[{\"indexed\":true,\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"value\",\"type\":\"uint256\"}],\"type\":\"event\",\"payable\":false},{\"anonymous\":false,\"name\":\"AddressLog\",\"inputs\":[{\"indexed\":false,\"name\":\"\",\"type\":\"address\"}],\"type\":\"event\",\"payable\":false},{\"constant\":false,\"name\":\"withdrawal\",\"inputs\":[{\"name\":\"contractAddress\",\"type\":\"address\"},{\"name\":\"to\",\"type\":\"address\"},{\"name\":\"amount\",\"type\":\"uint256\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":true,\"name\":\"isContract\",\"inputs\":[{\"name\":\"_addr\",\"type\":\"address\"}],\"outputs\":[{\"name\":\"is_contract\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":true,\"name\":\"totalSupply\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"buyback\",\"inputs\":[{\"name\":\"_addrs\",\"type\":\"address[]\"},{\"name\":\"_values\",\"type\":\"uint256[]\"},{\"name\":\"payAmount\",\"type\":\"uint256[]\"}],\"outputs\":[{\"name\":\"success\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":true,\"name\":\"balanceOf\",\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"outputs\":[{\"name\":\"balanceAmount\",\"type\":\"uint256\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"checkKyc\",\"inputs\":[{\"name\":\"userAddress\",\"type\":\"address\"},{\"name\":\"kyc\",\"type\":\"string\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"batchTransfer\",\"inputs\":[{\"name\":\"_addrs\",\"type\":\"address[]\"},{\"name\":\"_values\",\"type\":\"uint256[]\"}],\"outputs\":[{\"name\":\"success\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"buybackFroze\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"transfer\",\"inputs\":[{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_value\",\"type\":\"uint256\"}],\"outputs\":[{\"name\":\"success\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":true},{\"constant\":false,\"name\":\"additionalIssue\",\"inputs\":[{\"name\":\"num\",\"type\":\"uint256\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false},{\"constant\":true,\"name\":\"pagingQuery\",\"inputs\":[{\"name\":\"currentPage\",\"type\":\"uint32\"},{\"name\":\"pageSize\",\"type\":\"uint32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"address[]\"},{\"name\":\"\",\"type\":\"uint256[]\"},{\"name\":\"\",\"type\":\"uint256\"}],\"type\":\"function\",\"payable\":false},{\"constant\":false,\"name\":\"interestSettle\",\"inputs\":[{\"name\":\"_addrs\",\"type\":\"address[]\"},{\"name\":\"_values\",\"type\":\"uint256[]\"}],\"outputs\":[{\"name\":\"success\",\"type\":\"bool\"}],\"type\":\"function\",\"payable\":false}]",
    			"contractAddress":"e32e955c77876a58d906547519a2333c338d8008",
    			"initArgs":[
    				1000000000000,
    				"b8da898d50712ea4695ade4b1de6926cbc4bcfb9",
    				"",
    				"a4d7da26f66a347114faccb14c7ab2e7869ce27c"
    			],
    			"opCode":"60806040526008600160006101000a81548160ff021916908360ff1602179055506000600460146101000a81548160ff0219169083151502179055503480156200004857600080fd5b5060405162002a6438038062002a648339810180604052810190808051906020019092919080519060200190929190805182019291906020018051906020019092919050505060008373ffffffffffffffffffffffffffffffffffffffff16141515156200011e576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260148152602001807f6f776e657220616464726573732069732030783000000000000000000000000081525060200191505060405180910390fd5b60008411151562000197576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260108152602001807f746f74616c20697320696c6c6567616c0000000000000000000000000000000081525060200191505060405180910390fd5b60008173ffffffffffffffffffffffffffffffffffffffff16141515156200024d576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260218152602001807f5f64697362757273656d656e74546f6b656e206164647265737320697320307881526020017f300000000000000000000000000000000000000000000000000000000000000081525060400191505060405180910390fd5b83600081905550336001806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555082600260006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508160039080519060200190620002ed929190620004a9565b5080600460006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555060005460056000600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000181905550600160056000600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060010160006101000a81548160ff0219169083151502179055506006600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690806001815401808255809150509060018203906000526020600020016000909192909190916101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550505050505062000558565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f10620004ec57805160ff19168380011785556200051d565b828001600101855582156200051d579182015b828111156200051c578251825591602001919060010190620004ff565b5b5090506200052c919062000530565b5090565b6200055591905b808211156200055157600081600090555060010162000537565b5090565b90565b6124fc80620005686000396000f3006080604052600436106100b9576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806229c0b4146100be578063162790551461014357806318160ddd1461019e57806349ce8cff146101c957806370a08231146102cd578063853076d11461032457806388d695b2146103c55780639be7f6de14610486578063a9059cbb146104b5578063b369f4231461050d578063de6d0e7a14610552578063f387b48114610639575b600080fd5b3480156100ca57600080fd5b50610129600480360381019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190803573ffffffffffffffffffffffffffffffffffffffff169060200190929190803590602001909291905050506106fa565b604051808215151515815260200191505060405180910390f35b34801561014f57600080fd5b50610184600480360381019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610953565b604051808215151515815260200191505060405180910390f35b3480156101aa57600080fd5b506101b3610966565b6040518082815260200191505060405180910390f35b3480156101d557600080fd5b506102b360048036038101908080359060200190820180359060200190808060200260200160405190810160405280939291908181526020018383602002808284378201915050505050509192919290803590602001908201803590602001908080602002602001604051908101604052809392919081815260200183836020028082843782019150505050505091929192908035906020019082018035906020019080806020026020016040519081016040528093929190818152602001838360200280828437820191505050505050919291929050505061096f565b604051808215151515815260200191505060405180910390f35b3480156102d957600080fd5b5061030e600480360381019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610e76565b6040518082815260200191505060405180910390f35b34801561033057600080fd5b506103ab600480360381019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190803590602001908201803590602001908080601f0160208091040260200160405190810160405280939291908181526020018383808284378201915050505050509192919290505050610ec5565b604051808215151515815260200191505060405180910390f35b3480156103d157600080fd5b5061046c6004803603810190808035906020019082018035906020019080806020026020016040519081016040528093929190818152602001838360200280828437820191505050505050919291929080359060200190820180359060200190808060200260200160405190810160405280939291908181526020018383602002808284378201915050505050509192919290505050611006565b604051808215151515815260200191505060405180910390f35b34801561049257600080fd5b5061049b6113b9565b604051808215151515815260200191505060405180910390f35b6104f3600480360381019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190803590602001909291905050506113dd565b604051808215151515815260200191505060405180910390f35b34801561051957600080fd5b50610538600480360381019080803590602001909291905050506115c1565b604051808215151515815260200191505060405180910390f35b34801561055e57600080fd5b50610593600480360381019080803563ffffffff169060200190929190803563ffffffff1690602001909291905050506117c2565b604051808060200180602001848152602001838103835286818151815260200191508051906020019060200280838360005b838110156105e05780820151818401526020810190506105c5565b50505050905001838103825285818151815260200191508051906020019060200280838360005b83811015610622578082015181840152602081019050610607565b505050509050019550505050505060405180910390f35b34801561064557600080fd5b506106e06004803603810190808035906020019082018035906020019080806020026020016040519081016040528093929190818152602001838360200280828437820191505050505050919291929080359060200190820180359060200190808060200260200160405190810160405280939291908181526020018383602002808284378201915050505050509192919290505050611a0a565b604051808215151515815260200191505060405180910390f35b600080600083111515610775576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252600b8152602001807f616d6f756e74206973203000000000000000000000000000000000000000000081525060200191505060405180910390fd5b61077e85610953565b15156107f2576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601f8152602001807f636f6e747261637441646472657373206973206e6f7420636f6e74726163740081525060200191505060405180910390fd5b8490508073ffffffffffffffffffffffffffffffffffffffff1663a9059cbb85856040518363ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200182815260200192505050602060405180830381600087803b15801561089857600080fd5b505af11580156108ac573d6000803e3d6000fd5b505050506040513d60208110156108c257600080fd5b81019080805190602001909291905050501515610947576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260118152602001807f7769746864726177616c206661696c656400000000000000000000000000000081525060200191505060405180910390fd5b60019150509392505050565b600080823b905060008111915050919050565b60008054905090565b60008060008451865114151561098457600080fd5b8351855114151561099457600080fd5b60008651111515610a0d576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260198152602001807f61646472657373206172726179206c656e67746820697320300000000000000081525060200191505060405180910390fd5b600460149054906101000a900460ff161515610ab7576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260218152602001807f6275796261636b206d757374206275794261636b46726f7a652069732074727581526020017f650000000000000000000000000000000000000000000000000000000000000081525060400191505060405180910390fd5b600091505b85518261ffff161015610c9c57848261ffff16815181101515610adb57fe5b9060200190602002015160056000888561ffff16815181101515610afb57fe5b9060200190602002015173ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154141515610bb8576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601d8152602001807f616464726573732062616c616e6365206d7573742065712076616c756500000081525060200191505060405180910390fd5b610c1b868361ffff16815181101515610bcd57fe5b90602001906020020151600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16878561ffff16815181101515610c0c57fe5b90602001906020020151611c80565b1515610c8f576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252600f8152602001807f7472616e73666572206661696c6564000000000000000000000000000000000081525060200191505060405180910390fd5b8180600101925050610abc565b600460009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690508073ffffffffffffffffffffffffffffffffffffffff166388d695b287866040518363ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401808060200180602001838103835285818151815260200191508051906020019060200280838360005b83811015610d51578082015181840152602081019050610d36565b50505050905001838103825284818151815260200191508051906020019060200280838360005b83811015610d93578082015181840152602081019050610d78565b50505050905001945050505050602060405180830381600087803b158015610dba57600080fd5b505af1158015610dce573d6000803e3d6000fd5b505050506040513d6020811015610de457600080fd5b81019080805190602001909291905050501515610e69576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252600f8152602001807f73656e6420757364206661696c6564000000000000000000000000000000000081525060200191505060405180910390fd5b6001925050509392505050565b6000600560008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001549050809050919050565b60006060610ed16124ad565b6000808686604051602001808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200180602001828103825283818151815260200191508051906020019080838360005b83811015610f4b578082015181840152602081019050610f30565b50505050905090810190601f168015610f785780820380516001836020036101000a031916815260200191505b5093505050506040516020818303038152906040529350602084510191507f5354414353000000000000000000000000000000000000000000000000000002600102905060208383866000856000f1506001800260001916836000600181101515610fdf57fe5b6020020151600019161415610ff75760019450610ffc565b600094505b5050505092915050565b600080825184511415156110a8576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260238152602001807f6164647273206c656e677468206d757374206571205f76616c756573206c656e81526020017f677468000000000000000000000000000000000000000000000000000000000081525060400191505060405180910390fd5b60008451111515611121576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260198152602001807f61646472657373206172726179206c656e67746820697320300000000000000081525060200191505060405180910390fd5b600460149054906101000a900460ff161515156111a6576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260148152602001807f6275794261636b46726f7a65206973207472756500000000000000000000000081525060200191505060405180910390fd5b600090505b83518161ffff1610156113ae576000838261ffff168151811015156111cc57fe5b906020019060200201511415156113a15760006003805460018160011615610100020316600290049050141580156112255750611223848261ffff1681518110151561121457fe5b90602001906020020151610953565b155b1561135e576112e9848261ffff1681518110151561123f57fe5b9060200190602002015160038054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156112df5780601f106112b4576101008083540402835291602001916112df565b820191906000526020600020905b8154815290600101906020018083116112c257829003601f168201915b5050505050610ec5565b151561135d576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601d8152602001807f5f746f2061646472657373206b796320766572696679206661696c656400000081525060200191505060405180910390fd5b5b61139f33858361ffff1681518110151561137457fe5b90602001906020020151858461ffff1681518110151561139057fe5b90602001906020020151611c80565b505b80806001019150506111ab565b600191505092915050565b60006001600460146101000a81548160ff0219169083151502179055506001905090565b60008060038054600181600116156101000203166002900490501415801561140b575061140983610953565b155b15611529576114b48360038054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156114aa5780601f1061147f576101008083540402835291602001916114aa565b820191906000526020600020905b81548152906001019060200180831161148d57829003601f168201915b5050505050610ec5565b1515611528576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601d8152602001807f5f746f2061646472657373206b796320766572696679206661696c656400000081525060200191505060405180910390fd5b5b600460149054906101000a900460ff161515156115ae576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260148152602001807f6275794261636b46726f7a65206973207472756500000000000000000000000081525060200191505060405180910390fd5b6115b9338484611c80565b905092915050565b6000808211151561163a576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252600e8152602001807f6e756d20697320696c6c6567616c00000000000000000000000000000000000081525060200191505060405180910390fd5b600460149054906101000a900460ff161515156116bf576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260148152602001807f6275794261636b46726f7a65206973207472756500000000000000000000000081525060200191505060405180910390fd5b8160008082825401925050819055508160056000600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000160008282540192505081905550600080541115156117b9576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601d8152602001807f5468652064617461206f662063726f7373696e6720746865206c696e6500000081525060200191505060405180910390fd5b60019050919050565b60608060008060608060008060008060018c63ffffffff16101580156117ef575060018b63ffffffff1610155b15156117fa57600080fd5b606461ffff168b63ffffffff16111561181657606461ffff169a505b6006805490509650868b63ffffffff16111561183057869a505b8a60018d03029350868463ffffffff16101515611855578585889950995099506119fc565b6118608c8c89612439565b92508263ffffffff166040519080825280602002602001820160405280156118975781602001602082028038833980820191505090505b5095508263ffffffff166040519080825280602002602001820160405280156118cf5781602001602082028038833980820191505090505b509450600091505b8263ffffffff168261ffff1610156119f25760068463ffffffff168154811015156118fe57fe5b9060005260206000200160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16905080868361ffff1681518110151561193e57fe5b9060200190602002019073ffffffffffffffffffffffffffffffffffffffff16908173ffffffffffffffffffffffffffffffffffffffff1681525050600560008273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154858361ffff168151811015156119cf57fe5b9060200190602002018181525050838060010194505081806001019250506118d7565b8585889950995099505b505050505050509250925092565b60008082518451141515611a1d57600080fd5b60008451111515611a96576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260198152602001807f61646472657373206172726179206c656e67746820697320300000000000000081525060200191505060405180910390fd5b600460149054906101000a900460ff16151515611b1b576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260148152602001807f6275794261636b46726f7a65206973207472756500000000000000000000000081525060200191505060405180910390fd5b600460009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690508073ffffffffffffffffffffffffffffffffffffffff166388d695b285856040518363ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401808060200180602001838103835285818151815260200191508051906020019060200280838360005b83811015611bd0578082015181840152602081019050611bb5565b50505050905001838103825284818151815260200191508051906020019060200280838360005b83811015611c12578082015181840152602081019050611bf7565b50505050905001945050505050602060405180830381600087803b158015611c3957600080fd5b505af1158015611c4d573d6000803e3d6000fd5b505050506040513d6020811015611c6357600080fd5b810190808051906020019092919050505050600191505092915050565b6000806000808573ffffffffffffffffffffffffffffffffffffffff1614151515611d13576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260118152602001807f746f20616464726573732069732030783000000000000000000000000000000081525060200191505060405180910390fd5b600084111515611db1576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252602c8152602001807f5468652076616c7565206d75737420626520746861742069732067726561746581526020017f72207468616e207a65726f2e000000000000000000000000000000000000000081525060400191505060405180910390fd5b7f0bf07deb1c3fbf03980ee15c98791b07cdd7d1fc54ca3a39248f2cd40efe7aaa86604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390a17f0bf07deb1c3fbf03980ee15c98791b07cdd7d1fc54ca3a39248f2cd40efe7aaa85604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390a183600560008873ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000015410151515611f31576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601f8152602001807f66726f6d20616464726573732062616c616e6365206e6f7420656e6f7567680081525060200191505060405180910390fd5b83600560008773ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154019150600082111515611ff0576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601b8152602001807f746f20616464726573732062616c616e6365206f766572666c6f77000000000081525060200191505060405180910390fd5b600560008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154821115156120a9576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601b8152602001807f746f20616464726573732062616c616e6365206f766572666c6f77000000000081525060200191505060405180910390fd5b600560008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154600560008873ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000015401905083600560008873ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000160008282540392505081905550600560008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060010160009054906101000a900460ff1615156122e55783600560008773ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001819055506001600560008773ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060010160006101000a81548160ff02191690831515021790555060068590806001815401808255809150509060018203906000526020600020016000909192909190916101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555050612336565b83600560008773ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001600082825401925050819055505b8473ffffffffffffffffffffffffffffffffffffffff168673ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef866040518082815260200191505060405180910390a380600560008773ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154600560008973ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001540114151561242c57fe5b6001925050509392505050565b6000806000808563ffffffff168581151561245057fe5b06141561245f578492506124a4565b60018563ffffffff168581151561247257fe5b04019150600182038663ffffffff16111515612490578492506124a4565b84600187030263ffffffff16840390508092505b50509392505050565b6020604051908101604052806001906020820280388339808201915050905050905600a165627a7a723058201b6ca3438ad8c058c9f95b20d49d1aee05865d808f198e0a119e9d0f5b7a15070029000000000000000000000000000000000000000000000000000000e8d4a51000000000000000000000000000b8da898d50712ea4695ade4b1de6926cbc4bcfb90000000000000000000000000000000000000000000000000000000000000080000000000000000000000000a4d7da26f66a347114faccb14c7ab2e7869ce27c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    			"id":"Bonds7342",
    			"label":"Bonds"
    		},
    		"version":"4.0.0"
} 
```

```json tab="响应实例"
{
	"data":"\"14d4b73d830fa399e8285113d71965ca8befe72a591be9d3730ba20d2f519c48\"",
	"msg":"Success",
	"respCode":"000000"
} 
```

#### <a id="EXECUTE_CONTRACT">合约执行</a>
- [ ] 开放
- 接口描述： 执行合约定义的方法，需确保交易提交者具备db定义的permission权限
- type：`EXECUTE_CONTRACT`
- 请求参数： 

|    属性         | 类型          | 最大长度 | 必填 | 是否签名 | 说明                          |
| :------------:  | --------     | -------- | ---- | -------- | :---------------------------- |
| methodSignature | `string`     | 256     | Y    | Y        | 方法执行的方法abi((uint) balanceOf(address))   |
| args            | `object[]`   |         | N    | Y        | 方法执行入参参数      |
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

### Permission

#### <a id="SET_PERMISSION"> 设置Permission </a>

- [ ] 开放
- 接口描述：  添加permission,Identity被授予permission后才能执行该permission所定义交易
- type：`SET_PERMISSION`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| id            | `string`  | 32        | Y    | Y        | permission id（唯一）       |
| label         | `string`  | 32        | N    | Y        | 名称       |
| type          | `string`  | 64        | Y    | Y        | 授权类型（ADDRESS/IDENTITY）       |
| authorizers   | `string[]`|           | Y    | Y        | 被授予后期可以修改Permission的地址|
| datas         | `json`    |           | Y    | Y        | 当type为ADDRESS时，datas为地址数组；type为IDENTITY时，datas为验证Identity表达式|

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:| -------- | -------- | ---- | -------- | :---------------------------- |
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

#### 查询permission
- [ ] 开放
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
| authorizers   | `string[]`|          | Y    | Y        | 被授予后期可以修改Permission的地址|
| datas         | `json`    |          | Y    | Y        | 当type为ADDRESS时，datas为地址数组；type为IDENTITY时，datas为验证Identity表达式|
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

### Identity

#### <a id="SET_IDENTITY">Identity设置</a>

- [ ] 开放
- 接口描述：  设置Identity(此接口可以设置KYC信息)
- type：`SET_IDENTITY`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:  | -------- | -------- | ---- | -------- | :---------------------------- |
| address      | `string` | 40     | Y    | Y        | Identity地址                      |
| property     | `string` | 1024   | N    | Y        |  属性json格式       |
| identityType | `string` | 32     | N    | Y        |  type:user/node/domain       |
| kyc          | `string` | 1024   | N    | Y        |  kyc信息       |


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

#### <a id="FREEZE_IDENTITY">Identity冻结</a>

- [ ] 开放
- 接口描述：  Identity冻结
- type：`FREEZE_IDENTITY`
- 请求参数： 

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| address      | `string` | 40     | Y    | Y        | Identity地址                      |


- 响应参数：

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| txId | `string` | 64         | Y    | Y        | 交易id |                           |

- 实例：

```json tab="请求实例"
{
	"txData":"{\"txId\":\"f008e6d5b5abab6c795dd8b8bf3dc57c61189b68ae5903d9272b2a53e5dc1f97\",\"bdId\":\"bd_id_3599\",\"functionId\":\"FREEZE_IDENTITY\",\"type\":\"FREEZE_IDENTITY\",\"submitter\":\"5342594ae09e2f8844464824e24e61334603bc49\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"address\":\"5342594ae09e2f8844464824e24e61334603bc49\"},\"version\":\"4.0.0\"}}",
	"txSign":"01f9cb708cc1674183aa1a06fcf0edd83be4367627e5715d772132b14b0a1855a11683b295cc1affe85d4d430635968d15486ac49594e3322eb9fbafa30fee8c55"
}
```

```json tab="响应实例"
{
    "data":"f008e6d5b5abab6c795dd8b8bf3dc57c61189b68ae5903d9272b2a53e5dc1f97",
    "msg":"Success",
    "respCode":"000000"
    ,"success":true
}
```

#### <a id="UNFREEZE_IDENTITY">Identity解冻</a>

- [ ] 开放
- 接口描述：  Identity解冻
- type：`UNFREEZE_IDENTITY`
- 请求参数： 

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| address      | `string` | 40     | Y    | Y        | Identity地址                      |


- 响应参数：

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| txId | `string` |  64        | Y    | Y        | 交易id |                           |

- 实例：

```json tab="请求实例"
{
	"txData":"{\"txId\":\"ff8541db5d88596dcbc09c1e15159c87b92421c16d4dcf65e7fc650d8e4f4abc\",\"bdId\":\"bd_id_3599\",\"functionId\":\"UNFREEZE_IDENTITY\",\"type\":\"UNFREEZE_IDENTITY\",\"submitter\":\"5342594ae09e2f8844464824e24e61334603bc49\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"address\":\"5342594ae09e2f8844464824e24e61334603bc49\"},\"version\":\"4.0.0\"}}",
	"txSign":"0023d7044b83890d37147886bbaafdc828b5ee48a27e636d76832f1718ac86b7e82a1bb8ec637603dfec8a949fb5a2e3ee361bcd57fa960bf270fbc96b373759ba"
}
```

```json tab="响应实例"
{
    "data":"ff8541db5d88596dcbc09c1e15159c87b92421c16d4dcf65e7fc650d8e4f4abc",
    "msg":"Success",
    "respCode":"000000",
    "success":true
}
```


#### Identity鉴权
- [ ] 开放
- 接口描述：  检查用户是否有鉴别的权限
- 请求地址：`POST`：`identity/checkPermission`
- 请求参数：(无签名) 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | N        | 用户地址                     |
| permissionNames | `string[]` |      | Y    | Y        | 需要检查的权限，数组                     |

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

#### 查询Identity

- [ ] 开放
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
| hidden | `string` | 1     | Y    | Y        | 1：显示，0：隐藏                      |
| froze | `boolean` |  10    | Y    | Y        | true：冻结，false：未冻结                      |
| identityType | `string` | 64     | Y    | Y        | identity类型(user/node/domain)                      |
| kyc | `string` |1024      | Y    | Y        | identity认证信息                      |
| preTxId | `string` | 64     | Y    | Y        |  上次identity被修改时交易id                   |
| property | `string` | 1024     | Y    | Y        |  扩展属性                   |
| version | `int` | 10     | Y    | Y        |  修改记录版本                   |

- 实例：
```json tab="请求实例"

```

```json tab="响应实例"
{
	"data":{
		"address":"5342594ae09e2f8844464824e24e61334603bc49",
		"bdId":"bd_id_3599",
		"hidden":0,
		"property":"",
		"preTxId":"558d04f17c5ff0783a75644ffa87bdd21f59f6f21468a6370f2f4fb7731b5f43",
		"froze":false,
		"version":1,
		"currentTxId":"beeb4eaf7a27ed4c2be3a911f2f3a0d0bef08806426e9ce3ef8ea2ba85b7f42d"
	},
	"msg":"Success",
	"respCode":"000000"
}
```


### 存证
 
#### <a id="SET_ATTESTATION">设置存证</a>

- [ ] 开放
- 接口描述：  保存存证信息入链，同一存证信息连续设置会进行覆盖处理
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

#### 存证查询
- [ ] 开放
- 接口描述：  查询入链存证信息
- 请求地址：`GET`:`queryAttestation/{id}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:| -------- | -------| ---- | -------| :---------------------------- |
|      id    | `string` | 64     | Y    | Y      | 存证id                      |

- 响应参数：

|    属性        | 类型     | 最大长度   | 必填 | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ---- | -------- | :---------------------------- |
| id            | `string` | 64       | Y    | Y        | 存证id                      |
| attestation   | `string` | 4096     | Y    | N        | 存证内容                      |
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

## **普通接口**
---
#### DRS回调地址注册

-  [ ] 开放

`POST`:`/callback/register`

>   (通常是)`DRS`向`CRS`注册交易完成时通知交易完成的回调地址

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明          |
| :----------: | -------- | -------- | ---- | -------- | ------------- |
| callbackUrl | `string` |   1024    | Y    | Y        | 回调地址，URL |

[1]: query-api.md#queryMaxHeight 
[2]: query-api.md#queryTxByTxId/{txId} 
[3]: query-api.md#queryTxsByHeight/{height}
[4]: query-api.md#queryContract
