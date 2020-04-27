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
- `Permission`: 权限，用于交易鉴权
- `Policy`: 投票策略，用于执行交易的投票策略
- `kyc`: Know your customer，用于用户划线
- `BD`: 业务规范，用于规范所有业务相关功能
- `Identity`: 用户唯一标识，用于验证用户
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
    | ADD_NODE  			| DEFAULT        | ADD_NODE   	  		    |加入节点      |
    | REMOVE_NODE  			| DEFAULT        | REMOVE_NODE   	        |退出节点      |
    | UPGRADE_VERSION		| DEFAULT        | SYNC_ONE_VOTE_DEFAULT   	|版本升级      |
    | SET_DOMAIN		    | DEFAULT        | SYNC_ONE_VOTE_DEFAULT   	|设置domain信息  |
    | ADD_SNAPSHOT		    | DEFAULT        | SYNC_ONE_VOTE_DEFAULT   	|打快照  |

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
             "txData":"{"txId":"000001719c1956965df6e0e2761359d30a827505","bdCode":"SystemBD","functionId":"ADD_BD","submitter":"b8da898d50712ea4695ade4b1de6926cbc4bcfb9","version":"4.0.0","actionDatas":{"datas":{"bdVersion":"4.0.0","code":"sto_code","contracts":[{"createPermission":"DEFAULT","createPolicy":"BD_PUBLISH","desc":"余额查询-1","functions":[{"desc":"余额查询","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(uint256) balanceOf(address)","id":"balanceOf","type":"Contract"},{"desc":"转账","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(bool) transfer(address,uint256)","id":"transfer","type":"Contract"}],"templateCode":"code-balanceOf-1"},{"createPermission":"DEFAULT","createPolicy":"BD_PUBLISH","desc":"余额查询-2","functions":[{"desc":"余额查询","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(uint256) balanceOf(address)","id":"balanceOf","type":"Contract"},{"desc":"转账","execPermission":"DEFAULT","execPolicy":"BD_PUBLISH","methodSign":"(bool) transfer(address,uint256)","id":"transfer","type":"Contract"}],"templateCode":"code-balanceOf-2"}],"label":"sto_code_name"},"version":"4.0.0"}}",
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
                "txId":"000001719c1956965df6e0e2761359d30a827505",
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
        "data": "...",
        "msg": "Success", // 操作成功
        "respCode": "000000", // 返回代码， 000000为成功
    }
    ```

### 统一交易提交接口
- [x] 开放
- 接口描述：发起交易（所有类型的交易都需要指定`bdId`）
- 请求地址：`POST`: `/v4/submitTx`
- 请求参数：

|    属性     | 类型                  | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------------------- | --------| ---- | -------- | :-------------------------------- |
| txData      | `string`             |        | Y    | Y        | 交易数据，json格式，参见`txData`|
| txSign      | `string`             |        | Y    | Y        | 交易签名                             |

- `txData`

|     属性      | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| :-----------: | -------- | -------- | ---- | :------: | ------------------------------------------------------------ |
| txId          | `string` | 40       | Y    |    Y     | 请求Id |
| bdId          | `string` | 32       | Y    |    Y     | 所有业务交易都需要指定bdId                                       |
| templateId    | `string` | 32       | N    |    Y     |发布合约或执行合约方法时的合约templateCode                           |
| type          | `string` | 32       | N    |    Y     |系统级actionType                                                  |
| subType       | `string` | 32       | N    |    Y     |子业务类型                                             |
| sessionId     | `string` | 64       | N    |    Y     |订单id                                            |
| functionId    | `string` | 32       | Y    |    Y     | BD的functionId，如果是BD的初始化或者合约的发布：`ADD_CONTRACT` |
| submitter     | `string` | 40       | Y    |    Y     | 操作提交者地址                                               |
| actionDatas   | `string` | text     | Y    |    Y     | 业务参数JSON格式化数据，json数据包含{"version":"4.0.0","datas":{}}，datas为Json格式数据，数据参见各交易接口|
| version       | `string` | 40       | Y    |    Y     | 交易版本号                                               |
|extensionDatas | `string` | 1024     | N    |    Y     | 交易存证新消息                                               |

- `txSign`

提交者`submitter`的`ECC`对交易`txData`签名后的值

  
- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |     返回数据   |
| respCode    |   `string` |    状态码,000000为成功    |
| msg         |   `string` |    状态信息   |

- 实例：

```json tab="请求实例"
    {
    	"txData":"{\"txId\":\"000001719c1956965df6e0e2761359d30a827505\",\"bdId\":\"SystemBD\",\"functionId\":\"ADD_BD\",\"type\":\"ADD_BD\",\"submitter\":\"b8da898d50712ea4695ade4b1de6926cbc4bcfb9\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"bdVersion\":\"4.0.0\",\"functions\":[{\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"methodSign\":\"SET_ATTESTATION\",\"id\":\"SET_ATTESTATION\",\"type\":\"SystemAction\"}],\"id\":\"sto_code_token5476\",\"label\":\"sto_code__token_name\"},\"version\":\"4.0.0\"}}",
    	"txSign":"01b1eb09ff94d9d136597bb1b5665b5322203b0f56abee6c521bad91fa99b6bfb930520b74dab0e88e120e26a48d87e5e0dcaf5293bc0242e74b525f4eb9f8517b"
    }

```

```json tab="响应实例"
  {
     respCode='000000',
     msg='Success', 
     data='000001719c1956965df6e0e2761359d30a827505'
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
    |<a href="#ADD_SNAPSHOT">ADD_SNAPSHOT</a>           |N      |快照交易|


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
    <version>4.2.0-SNAPSHOT</version>
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
- 接口描述： 将普通节点注册为RS节点，需确保交易提交者具备db定义的permission权限
- type：`ADD_RS`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 |     说明             |
| :---------: | -------- | -------- | ---- | :------: | ------------- |
| nodeName     | `string` | 32      | Y    |    Y     | RS id            |
|  desc     | `string` | 128      | N    |    Y     | RS 节点描述      |
|  domainId   | `string` | 16      | Y    |    Y     | Domain ID        |
| maxNodeSize | `int`    | 10      | N    |    Y     | 最大节点允许数量 |
| domainDesc  | `string` | 1024     | N    |    Y     | domain 描述      |
  
- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |


#### <a id="REMOVE_RS">移除RS</a>

- [ ] 开放

- 接口描述：  移除已注册的 RS，将RS节点变更为普通节点

- type：`REMOVE_RS`

- 请求参数： 

| 属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明 |
| :---------: | -------- | -------- | ---- | -------- | :--------|
| nodeName     | `string` | 32      | Y    | Y        |  被移除的RS节点名称    |
  
- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

### `CA`管理
> 用于管理节点CA, 节点在加入集群前必须在链上有可信的CA

#### <a id="ADD_CA">注册`CA`</a>
- [x] 开放
- 接口描述： 将待加入节点的CA上链
- type：`ADD_CA`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ----  | -------- | :---------------------------- |
| caList        | `string` |1024        | Y       | Y        | ca集合(签名拼接需要将caList中的每个ca拼接)                      |

- `caList`

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                       |
| :---------:   | -------- | -------- | ----  | -------- | :---------------- |
| version       | `string` |10       | N       | Y        | 版本号   |
| period        | `string` |20       | N       | Y        |格式化格式"yyyy-MM-dd hh:mm:ss"北京时间需要减8个小时  |
| pubKey        | `string` |131      | Y       | Y        | 公钥   |
| user          | `string` |32        | Y       | Y        | 节点名称  |
| domainId      | `string` |32        | Y       | Y        | domain  |
| usage         | `string` |10        | Y       | Y        | biz/consensus      |

- 响应参数：

|    属性      | 类型       |  说明        |
 | :---------: | -------    | :---------- |
 | data        |   `string` |   交易id     |
 | respCode    |   `string` |    状态码    |
 | msg         |   `string` |    状态信息   |

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
{"data":"000001719c1956965df6e0e2761359d30a827505","msg":"Success","respCode":"000000","success":true}  
```

#### <a id="UPDATE_CA">更新`CA`</a>
- [x] 开放
- 接口描述： 更新CA
- type：`UPDATE_CA`

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| period | `string`   | 20     | N    | Y        | 过期时间                      |
| pubKey | `string`   | 131    | Y    | Y        | 公钥                      |
| user   | `string`   | 32     | Y    | Y        | 节点名称                      |
| domainId | `string` | 32     | Y    | Y        | 域                      |
| usage | `string`    | 10     | Y    | Y        | 使用类型biz/consensus                      |


- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

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
	"data":"000001719c1956965df6e0e2761359d30a827505",
	"msg":"Success",
	"respCode":"000000",
    "success":true
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

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

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
	"data":"000001719c1956965df6e0e2761359d30a827505",
	"msg":"Success",
	"respCode":"000000",
    "success":true
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

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |


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
	"data":"000001719c1956965df6e0e2761359d30a827505",
    "msg":"Success",
    "respCode":"000000",
    "success":true
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

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |


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
	"data":"000001719c1956965df6e0e2761359d30a827505",
	"msg":"Success",
	"respCode":"000000",
    "success":true
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
| label          | `string`       | 64       | N    | Y        |  别名                                            |
| votePattern    | `string`       | 10        | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| callbackType   | `string`       | 10         | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
| decisionType   | `string`       | 10         | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| domainIds      | `list<string>` | 256         | N    | Y        | 参与投票的domainId列表                       |
| requireAuthIds | `list<string>` | 256         | Y    | Y        | 需要通过该集合对应的domain授权才能修改当前policy |
| assignMeta     | `json` | 1024         | N    | Y        | 当decisionType=ASSIGN_NUM,assignMeta属性值需要签名 |

- assignMeta结构

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | --------| ------- | ---- | ----- | :---------------------------- |
| verifyNum  | `int`    |   10    | N    | Y     |  赞成票的最少票数  |
| expression | `string` |   256   | N    | Y     | 赞成票数的表达式，例如: n/2+1，其中n代表集群中的domain数 |
| mustDomainIds | `list<string>`| 256 | N  | Y  |  必须投赞成票的domainId|


- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |


- 实例：

```json tab="请求实例"
{
	"txData":"{\"txId\":\"00000171b47c4fd2f9d0fc62e725906694d47ca1\",\"bdId\":\"SystemBD\",\"functionId\":\"SET_POLICY\",\"type\":\"SET_POLICY\",\"submitter\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"callbackType\":\"ALL\",\"decisionType\":\"ONE_VOTE\",\"domainIds\":[\"STACS-Domain-A\",\"STACS-Domain-B\"],\"label\":\"biubiu\",\"policyId\":\"policy_demo_2\",\"requireAuthIds\":[\"STACS-Domain-A\"],\"votePattern\":\"SYNC\"},\"version\":\"4.0.0\"}}",
    "txSign":"00c7804a67757f4e3a567d672ec85273f0c9e2ad5c1ef009c5f25c8a1eff9c2cd60edfdff9c1a5e2354f42fb47c423588a3f98ea554f55da42608048856ce90d34"
} 
```

```json tab="响应实例"
{"data":"00000171b47c4fd2f9d0fc62e725906694d47ca1","msg":"Success","respCode":"000000","success":true} 
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
| :---------:| -------------------- | -------- | ---- | -------- | :-------------------------------- |
| id         | `string`               |32       | Y    | Y        | BD编号（唯一）                      |
| label      | `string`              |32       | N    | Y        | BD名称                             |
| desc      | `string`               |1024     | N    | Y        | 描述                      |
| functions | `List<FunctionDefine>` |         | N    | Y        | bd定义function            |
| contracts | `List<ContractDefine>` |         | N    | Y        | bd定义contract            |
| bdVersion | `string`               | 16      | Y    | Y        | bd版本                    |

`ContractDefine`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------:    | -------- | -----| ---- | -------- | :---------------------------- |
| templateId       | `string` | 32    | Y    | Y        | 合约模板名称，在同一个bd下不能重复                      |
| desc             | `string` | 256   | N    | Y        | function描述                     |
| createPermission | `string` | 64     | Y    | Y        | 合约发布时的权限,,发布bd时，该permission已经存在于链上 |
| createPolicy     | `string` | 32      | Y    | Y        | 合约发布时的 policy,发布bd时，该policy已经存在于链上                |
| functions        | `List<FunctionDefine>`| | Y| Y        | 合约方法定义function            |

`FunctionDefine`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:    | -------- | -------- | ---- | -------- | :---------------------------- |
| desc           | `string` | 256     | N    | Y        | function描述                     |
| execPermission | `string` | 64     | Y    | Y        | 执行function权限,发布bd时，该permission已经存在于链上                   |
| execPolicy     | `string` | 32     | Y    | Y        | 执行function policy,发布bd时，该policy已经存在于链上                      |
| methodSign     | `string` | 256     | Y    | Y        | 如果发布的是合约则填写的合约方法签名
| id             | `string` | 32     | Y    | Y        | function名称在同一个bd下不能重复                      |
| type           | `string` | 64     | Y    | Y        |function功能类型<a href="FUNCTION_TYPE">FUNCTION_TYPE</a>        |


- <a id="FUNCTION_TYPE">function type类型</a>

|    类型            | 说明                         |
| :----------------:| --------                    |
| SystemAction      |系统内置function功能            |
| Contract          |该function属于合约方法           |
| ContractQuery      |该function属于合约查询类,可以通过<a href="query-api.md#queryContract">合约状态查询</a>调用该方法|

- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

```java tab="请求实例-actionDatas"
    {
    	"txData":"{\"txId\":\"00000171b4763a8688974ea47641ddcf0bf1724b\",\"bdId\":\"SystemBD\",\"functionId\":\"ADD_BD\",\"type\":\"ADD_BD\",\"submitter\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"bdVersion\":\"4.0.0\",\"contracts\":[{\"createPermission\":\"DEFAULT\",\"createPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"desc\":\"test\",\"functions\":[{\"desc\":\"余额查询\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"balanceOf\",\"methodSign\":\"(uint256) balanceOf(address)\",\"type\":\"Contract\"},{\"desc\":\"转账\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"transfer\",\"methodSign\":\"(bool) transfer(address,uint256)\",\"type\":\"Contract\"}],\"templateId\":\"t-code-bond\"},{\"createPermission\":\"DEFAULT\",\"createPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"desc\":\"test\",\"functions\":[{\"desc\":\"已支付\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"payment\",\"methodSign\":\"(bool) payment(bytes32)\",\"type\":\"Contract\"},{\"desc\":\"确认白条已支付\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"confirm\",\"methodSign\":\"(bool) confirm(bytes32)\",\"type\":\"Contract\"},{\"desc\":\"回退\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"release\",\"methodSign\":\"(bool) release()\",\"type\":\"Contract\"},{\"desc\":\"提现\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"withdrawal\",\"methodSign\":\"(bool) withdrawal(address,address,uint256)\",\"type\":\"Contract\"},{\"desc\":\"检查kyc\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"checkKyc\",\"methodSign\":\"(bool) checkKyc(address,string)\",\"type\":\"Contract\"},{\"desc\":\"购买记录\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"buyHistory\",\"methodSign\":\"(bytes32,address,address,uint256,uint256,uint256) buyHistory()\",\"type\":\"Contract\"}],\"templateId\":\"t-code-dvp\"},{\"createPermission\":\"DEFAULT\",\"createPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"desc\":\"test\",\"functions\":[{\"desc\":\"余额查询\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"balanceOf\",\"methodSign\":\"(uint256) balanceOf(address)\",\"type\":\"Contract\"},{\"desc\":\"转账\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"transfer\",\"methodSign\":\"(bool) transfer(address,uint256)\",\"type\":\"Contract\"},{\"desc\":\"标的类型查询\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"benchmark\",\"methodSign\":\"(string) benchmark()\",\"type\":\"Contract\"},{\"desc\":\"花费\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"cost\",\"methodSign\":\"(bool) cost(address,uint256)\",\"type\":\"Contract\"},{\"desc\":\"购买\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"buy\",\"methodSign\":\"(bool) buy(address,uint256,uint256)\",\"type\":\"Contract\"}],\"templateId\":\"t-code-cert\"}],\"desc\":\"dvp_test_label\",\"functions\":[{\"desc\":\"这是一个测试2\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"SET_IDENTITY\",\"methodSign\":\"SET_IDENTITY\",\"type\":\"SystemAction\"},{\"desc\":\"这是一个测试2\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"FREEZE_IDENTITY\",\"methodSign\":\"FREEZE_IDENTITY\",\"type\":\"SystemAction\"},{\"desc\":\"Identity解冻\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"UNFREEZE_IDENTITY\",\"methodSign\":\"UNFREEZE_IDENTITY\",\"type\":\"SystemAction\"},{\"desc\":\"设置存证\",\"execPermission\":\"DEFAULT\",\"execPolicy\":\"SYNC_ONE_VOTE_DEFAULT\",\"id\":\"SET_ATTESTATION\",\"methodSign\":\"SET_ATTESTATION\",\"type\":\"SystemAction\"}],\"id\":\"bd_demo_5\",\"label\":\"dvp_test_label\"},\"version\":\"4.0.0\"}}",
        "txSign":"006be9ac9bff3a006125ea5bdaff76d67b091acee356fef9f0365a8f05e84060613d7bb6ad454b950ae3f99893fd568093916088ef94fd4fd0fbe241c5b13eee8d"
    }

```

```json tab="响应实例"
    {"data":"00000171b4763a8688974ea47641ddcf0bf1724b","msg":"Success","respCode":"000000","success":true} 
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

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

```json tab="请求实例"
	{
        "txData":"{\"txId\":\"00000171b51a09954629a8e0aa1c148d30ee8f3c\",\"bdId\":\"SystemBD\",\"functionId\":\"ADD_SNAPSHOT\",\"type\":\"ADD_SNAPSHOT\",\"submitter\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"remark\":\"you see see you\"},\"version\":\"4.0.0\"}}",
        "txSign":"01418b639f0fb79b578c29fea821b8dc88f390812e0c1ae8f879d7c9c8919c7fc30d1173bdffd5c24b79cc19f056e857c00c7ce79b7b5a8d1d39e5a2e5b974a687"
    }
```

```json tab="响应实例"
{
    "data":"00000171b51a09954629a8e0aa1c148d30ee8f3c","msg":"Success","respCode":"000000","success":true
}
```

#### 快照查询

- [ ] 开放
- 接口描述：  
- 请求地址：`GET`:`/v4/snapshot/query?txId={txId}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 40     | Y    | Y        | 交易id                      |

- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   快照信息     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- `data`

|    属性     | 类型     |  说明                          |
| :---------: | -------- | :---------------------------- |
| snapshotId | `string`    |   快照Id                      |
| blockHeight | `int`    |   区块高度                      |
| remark     | `string` | 备注                      |

- 实例：

```json tab="响应实例"
{
    respCode='000000', msg='Success', data={"snapshotId":"00000171b5259d51cfee6d3384b66cb8baebf136","blockHeight":48,"remark":"you see see you"}}
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

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

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
	"txData":"{\"txId\":\"00000171b50e98ac6817929db66d979c4e416e68\",\"bdId\":\"bd_demo_5\",\"functionId\":\"ADD_CONTRACT\",\"templateId\":\"t-code-cert\",\"type\":\"ADD_CONTRACT\",\"submitter\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"abi\":\"[{\\\"constant\\\":false,\\\"name\\\":\\\"withdrawal\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"contractAddress\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"to\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"amount\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"isContract\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_addr\\\",\\\"type\\\":\\\"address\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"is_contract\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"totalSupply\\\",\\\"inputs\\\":[],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"balanceOf\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_addr\\\",\\\"type\\\":\\\"address\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"balanceAmount\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":false,\\\"name\\\":\\\"batchTransfer\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_addrs\\\",\\\"type\\\":\\\"address[]\\\"},{\\\"name\\\":\\\"_values\\\",\\\"type\\\":\\\"uint256[]\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"success\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"benchmark\\\",\\\"inputs\\\":[],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"string\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":false,\\\"name\\\":\\\"buy\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"orderAddr\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"amount\\\",\\\"type\\\":\\\"uint256\\\"},{\\\"name\\\":\\\"payAmount\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"success\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"invalidTotalSupply\\\",\\\"inputs\\\":[],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":false,\\\"name\\\":\\\"transfer\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_to\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"_value\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"success\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":true},{\\\"constant\\\":false,\\\"name\\\":\\\"additionalIssue\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"num\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"invalidBalanceOf\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_addr\\\",\\\"type\\\":\\\"address\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"balanceAmount\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":false,\\\"name\\\":\\\"cost\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"addr\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"amount\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"name\\\":\\\"\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_total\\\",\\\"type\\\":\\\"uint256\\\"},{\\\"name\\\":\\\"_owner\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"_benchmark\\\",\\\"type\\\":\\\"string\\\"}],\\\"type\\\":\\\"constructor\\\",\\\"payable\\\":false},{\\\"anonymous\\\":false,\\\"name\\\":\\\"Transfer\\\",\\\"inputs\\\":[{\\\"indexed\\\":true,\\\"name\\\":\\\"from\\\",\\\"type\\\":\\\"address\\\"},{\\\"indexed\\\":true,\\\"name\\\":\\\"to\\\",\\\"type\\\":\\\"address\\\"},{\\\"indexed\\\":false,\\\"name\\\":\\\"value\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"type\\\":\\\"event\\\",\\\"payable\\\":false},{\\\"constant\\\":false,\\\"name\\\":\\\"withdrawal\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"contractAddress\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"to\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"amount\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"isContract\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_addr\\\",\\\"type\\\":\\\"address\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"is_contract\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"totalSupply\\\",\\\"inputs\\\":[],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"balanceOf\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_addr\\\",\\\"type\\\":\\\"address\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"balanceAmount\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":false,\\\"name\\\":\\\"batchTransfer\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_addrs\\\",\\\"type\\\":\\\"address[]\\\"},{\\\"name\\\":\\\"_values\\\",\\\"type\\\":\\\"uint256[]\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"success\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"benchmark\\\",\\\"inputs\\\":[],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"string\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":false,\\\"name\\\":\\\"buy\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"orderAddr\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"amount\\\",\\\"type\\\":\\\"uint256\\\"},{\\\"name\\\":\\\"payAmount\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"success\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"invalidTotalSupply\\\",\\\"inputs\\\":[],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":false,\\\"name\\\":\\\"transfer\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_to\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"_value\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"success\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":true},{\\\"constant\\\":false,\\\"name\\\":\\\"additionalIssue\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"num\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":true,\\\"name\\\":\\\"invalidBalanceOf\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"_addr\\\",\\\"type\\\":\\\"address\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"balanceAmount\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false},{\\\"constant\\\":false,\\\"name\\\":\\\"cost\\\",\\\"inputs\\\":[{\\\"name\\\":\\\"addr\\\",\\\"type\\\":\\\"address\\\"},{\\\"name\\\":\\\"amount\\\",\\\"type\\\":\\\"uint256\\\"}],\\\"outputs\\\":[{\\\"name\\\":\\\"\\\",\\\"type\\\":\\\"bool\\\"}],\\\"type\\\":\\\"function\\\",\\\"payable\\\":false}]\",\"contractAddress\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"contractor\":\"Certificate_TypeA(uint256,address,string)\",\"id\":\"certificate_demo_1\",\"initArgs\":[10000000000,\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"USD\"],\"label\":\"lalala\",\"opCode\":\"60806040526008600160006101000a81548160ff021916908360ff1602179055503480156200002d57600080fd5b5060405162001cd938038062001cd983398101806040528101908080519060200190929190805190602001909291908051820192919050505060008273ffffffffffffffffffffffffffffffffffffffff1614151515620000f6576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260148152602001807f6f776e657220616464726573732069732030783000000000000000000000000081525060200191505060405180910390fd5b6000831115156200016f576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260108152602001807f746f74616c20697320696c6c6567616c0000000000000000000000000000000081525060200191505060405180910390fd5b6000815114151515620001ea576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260148152602001807f62656e63686d61726b20697320696c6c6567616c00000000000000000000000081525060200191505060405180910390fd5b82600081905550336001806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555081600260006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555080600390805190602001906200028a92919062000404565b5060005460056000600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000181905550600160056000600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060010160006101000a81548160ff0219169083151502179055506007600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690806001815401808255809150509060018203906000526020600020016000909192909190916101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555050505050620004b3565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106200044757805160ff191683800117855562000478565b8280016001018555821562000478579182015b82811115620004775782518255916020019190600101906200045a565b5b5090506200048791906200048b565b5090565b620004b091905b80821115620004ac57600081600090555060010162000492565b5090565b90565b61181680620004c36000396000f3006080604052600436106100b9576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806229c0b4146100be578063162790551461014357806318160ddd1461019e57806370a08231146101c957806388d695b2146102205780638903c5a2146102e1578063a59ac6dd14610371578063a80157a6146103e0578063a9059cbb1461040b578063b369f42314610463578063c71b622c146104a8578063f94d6dc7146104ff575b600080fd5b3480156100ca57600080fd5b50610129600480360381019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190803573ffffffffffffffffffffffffffffffffffffffff16906020019092919080359060200190929190505050610564565b604051808215151515815260200191505060405180910390f35b34801561014f57600080fd5b50610184600480360381019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506107bd565b604051808215151515815260200191505060405180910390f35b3480156101aa57600080fd5b506101b36107d0565b6040518082815260200191505060405180910390f35b3480156101d557600080fd5b5061020a600480360381019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506107d9565b6040518082815260200191505060405180910390f35b34801561022c57600080fd5b506102c76004803603810190808035906020019082018035906020019080806020026020016040519081016040528093929190818152602001838360200280828437820191505050505050919291929080359060200190820180359060200190808060200260200160405190810160405280939291908181526020018383602002808284378201915050505050509192919290505050610828565b604051808215151515815260200191505060405180910390f35b3480156102ed57600080fd5b506102f6610946565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561033657808201518184015260208101905061031b565b50505050905090810190601f1680156103635780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b34801561037d57600080fd5b506103c6600480360381019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919080359060200190929190803590602001909291905050506109e8565b604051808215151515815260200191505060405180910390f35b3480156103ec57600080fd5b506103f5610bda565b6040518082815260200191505060405180910390f35b610449600480360381019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919080359060200190929190505050610be4565b604051808215151515815260200191505060405180910390f35b34801561046f57600080fd5b5061048e60048036038101908080359060200190929190505050610bf9565b604051808215151515815260200191505060405180910390f35b3480156104b457600080fd5b506104e9600480360381019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610d76565b6040518082815260200191505060405180910390f35b34801561050b57600080fd5b5061054a600480360381019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919080359060200190929190505050610dc5565b604051808215151515815260200191505060405180910390f35b6000806000831115156105df576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252600b8152602001807f616d6f756e74206973203000000000000000000000000000000000000000000081525060200191505060405180910390fd5b6105e8856107bd565b151561065c576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601f8152602001807f636f6e747261637441646472657373206973206e6f7420636f6e74726163740081525060200191505060405180910390fd5b8490508073ffffffffffffffffffffffffffffffffffffffff1663a9059cbb85856040518363ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200182815260200192505050602060405180830381600087803b15801561070257600080fd5b505af1158015610716573d6000803e3d6000fd5b505050506040513d602081101561072c57600080fd5b810190808051906020019092919050505015156107b1576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260118152602001807f7769746864726177616c206661696c656400000000000000000000000000000081525060200191505060405180910390fd5b60019150509392505050565b600080823b905060008111915050919050565b60008054905090565b6000600560008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001549050809050919050565b6000808251845114151561083b57600080fd5b600084511115156108b4576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260198152602001807f61646472657373206172726179206c656e67746820697320300000000000000081525060200191505060405180910390fd5b600090505b83518161ffff16101561093b576000838261ffff168151811015156108da57fe5b9060200190602002015114151561092e5761092c33858361ffff1681518110151561090157fe5b90602001906020020151858461ffff1681518110151561091d57fe5b906020019060200201516110f7565b505b80806001019150506108b9565b600191505092915050565b606060038054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156109de5780601f106109b3576101008083540402835291602001916109de565b820191906000526020600020905b8154815290600101906020018083116109c157829003601f168201915b5050505050905090565b6000806109f4856107bd565b1515610a68576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260198152602001807f6f7264657241646472206973206e6f7420636f6e74726163740000000000000081525060200191505060405180910390fd5b610a733386856110f7565b1515610ae7576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252600f8152602001807f7472616e73666572206661696c6564000000000000000000000000000000000081525060200191505060405180910390fd5b8490508073ffffffffffffffffffffffffffffffffffffffff1663a59ac6dd3386866040518463ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018381526020018281526020019350505050602060405180830381600087803b158015610b9557600080fd5b505af1158015610ba9573d6000803e3d6000fd5b505050506040513d6020811015610bbf57600080fd5b81019080805190602001909291905050509150509392505050565b6000600454905090565b6000610bf13384846110f7565b905092915050565b60008082111515610c72576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252600e8152602001807f6e756d20697320696c6c6567616c00000000000000000000000000000000000081525060200191505060405180910390fd5b8160008082825401925050819055508160056000600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001600082825401925050819055506000805410151515610d6d576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601d8152602001807f5468652064617461206f662063726f7373696e6720746865206c696e6500000081525060200191505060405180910390fd5b60019050919050565b6000600660008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001549050809050919050565b6000808260005410151515610e42576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252600f8152602001807f616d6f756e7420677420746f74616c000000000000000000000000000000000081525060200191505060405180910390fd5b6000805410151515610ebc576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260138152602001807f746f74616c496e76616c6964206661696c65640000000000000000000000000081525060200191505060405180910390fd5b82600560003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000015410151515610f76576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260118152602001807f62616c616e6365206c7420616d6f756e7400000000000000000000000000000081525060200191505060405180910390fd5b826000540360008190555082600560003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000160008282540392505081905550600660008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154905082600660008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000016000828254019250508190555082600454016004819055506000600454101515156110ec576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260138152602001807f746f74616c496e76616c6964206661696c65640000000000000000000000000081525060200191505060405180910390fd5b600191505092915050565b6000806000808573ffffffffffffffffffffffffffffffffffffffff161415151561118a576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260118152602001807f746f20616464726573732069732030783000000000000000000000000000000081525060200191505060405180910390fd5b600084111515611228576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252602c8152602001807f5468652076616c7565206d75737420626520746861742069732067726561746581526020017f72207468616e207a65726f2e000000000000000000000000000000000000000081525060400191505060405180910390fd5b83600560008873ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154101515156112e2576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601f8152602001807f66726f6d20616464726573732062616c616e6365206e6f7420656e6f7567680081525060200191505060405180910390fd5b83600560008773ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001540191506000821115156113a1576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601b8152602001807f746f20616464726573732062616c616e6365206f766572666c6f77000000000081525060200191505060405180910390fd5b600560008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001548211151561145a576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601b8152602001807f746f20616464726573732062616c616e6365206f766572666c6f77000000000081525060200191505060405180910390fd5b600560008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154600560008873ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000015401905083600560008873ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000160008282540392505081905550600560008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060010160009054906101000a900460ff1615156116965783600560008773ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001819055506001600560008773ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060010160006101000a81548160ff02191690831515021790555060078590806001815401808255809150509060018203906000526020600020016000909192909190916101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550506116e7565b83600560008773ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600001600082825401925050819055505b8473ffffffffffffffffffffffffffffffffffffffff168673ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef866040518082815260200191505060405180910390a380600560008773ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154600560008973ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154011415156117dd57fe5b60019250505093925050505600a165627a7a723058200237125711ea4e316b66ff3a6994e6ef7d0ffd7e4ff10c7fe63e42706d2befe6002900000000000000000000000000000000000000000000000000000002540be4000000000000000000000000002a4060d480ebf0b601294b1f9f9599936681de61000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000035553440000000000000000000000000000000000000000000000000000000000\",\"sourceCode\":\"pragma solidity ^0.4.24;\\n\\ncontract Common {\\n\\n\\n    bytes32 constant TX_ID = bytes32(0x00000000000000000000000000000000000000000000000000000074785f6964);\\n    bytes32 constant STACS_KEY_ADDR = bytes32(0x5354414353000000000000000000000000000000000000000000000000000002);\\n\\n    event Transfer(address indexed from, address indexed to, uint256 value);\\n\\n    //assemble the given address bytecode. If bytecode exists then the _addr is a contract.\\n    function isContract(address _addr) public view returns (bool is_contract) {\\n        uint length;\\n        assembly {\\n        //retrieve the size of the code on target address, this needs assembly\\n            length := extcodesize(_addr)\\n        }\\n        return (length > 0);\\n    }\\n\\n}\\n\\ninterface OrderContract {\\n    function buy(address buyer, uint256 amount, uint256 payAmount) external returns (bool success);\\n}\\n\\ninterface TokenContract {\\n    function transfer(address _to, uint256 _value) external returns (bool success);\\n}\\n\\ncontract Certificate_TypeA is Common {\\n    uint16 constant MAX_NUMBER_OF_QUERY_PER_PAGE = 100;\\n    uint256 total;\\n    uint8 decimals = 8;\\n    address issuer;\\n    address owner;\\n    string  supportBenchmark;\\n    uint256 totalInvalid;\\n\\n    struct Balance {\\n        uint256 balance;\\n        bool exists;\\n    }\\n\\n    mapping(address => Balance) balance;\\n    mapping(address => Balance) invalidBalance;\\n\\n    address[] addresses;\\n\\n    constructor (\\n        uint256 _total,\\n        address _owner,\\n        string _benchmark\\n    ) public {\\n        require(_owner != 0x0, \\\"owner address is 0x0\\\");\\n        require(_total > 0, \\\"total is illegal\\\");\\n        require(bytes(_benchmark).length != 0, \\\"benchmark is illegal\\\");\\n\\n        total = _total;\\n        issuer = msg.sender;\\n        owner = _owner;\\n        supportBenchmark = _benchmark;\\n        balance[owner].balance = total;\\n        balance[owner].exists = true;\\n        addresses.push(owner);\\n    }\\n\\n    function benchmark() public view returns (string){\\n        return supportBenchmark;\\n    }\\n\\n    function totalSupply() public view returns (uint256){\\n        return total;\\n    }\\n\\n    function invalidTotalSupply() public view returns (uint256){\\n        return totalInvalid;\\n    }\\n\\n    function balanceOf(address _addr) public view returns (uint256 balanceAmount){\\n        balanceAmount = balance[_addr].balance;\\n        return (balanceAmount);\\n    }\\n\\n    function invalidBalanceOf(address _addr) public view returns (uint256 balanceAmount){\\n        balanceAmount = invalidBalance[_addr].balance;\\n        return (balanceAmount);\\n    }\\n\\n    function transfer(address _to, uint256 _value) public payable returns (bool success){\\n        return transferFrom(msg.sender, _to, _value);\\n    }\\n\\n    function batchTransfer(address[] _addrs, uint256[] _values) public returns (bool success){\\n        require(_addrs.length == _values.length);\\n        require(_addrs.length > 0, \\\"address array length is 0\\\");\\n        for (uint16 i = 0; i < _addrs.length; i++) {\\n            if (_values[i] != 0) {\\n                transferFrom(msg.sender, _addrs[i], _values[i]);\\n            }\\n        }\\n        return true;\\n    }\\n\\n    /**\\n    *1:transfer USD to orderAddr(PFC contract addresss)\\n    *2:call PFC buy function,add buy history\\n    */\\n    function buy(address orderAddr, uint256 amount, uint256 payAmount) public returns (bool success){\\n        require(isContract(orderAddr), \\\"orderAddr is not contract\\\");\\n        require(transferFrom(msg.sender, orderAddr, payAmount), \\\"transfer failed\\\");\\n\\n        OrderContract orderContract = OrderContract(orderAddr);\\n        return orderContract.buy(msg.sender, amount, payAmount);\\n    }\\n\\n    function cost(address addr, uint256 amount) public returns (bool){\\n\\n        require((total >= amount), \\\"amount gt total\\\");\\n        require(total >= 0, \\\"totalInvalid failed\\\");\\n        //买方的白条余额需要扣减\\n        require(balance[msg.sender].balance >= amount, \\\"balance lt amount\\\");\\n\\n        total = total - amount;\\n        balance[msg.sender].balance -= amount;\\n        //给卖方增加白条余额\\n        uint256 before = invalidBalance[addr].balance;\\n        invalidBalance[addr].balance += amount;\\n        totalInvalid = totalInvalid + amount;\\n        require(totalInvalid >= 0, \\\"totalInvalid failed\\\");\\n\\n        return true;\\n    }\\n\\n    function additionalIssue(uint256 num) public returns (bool){\\n        require(num > 0, \\\"num is illegal\\\");\\n        total += num;\\n        balance[owner].balance += num;\\n        require(total >= 0, \\\"The data of crossing the line\\\");\\n        return true;\\n    }\\n\\n    function withdrawal(address contractAddress, address to, uint256 amount) public returns (bool){\\n        require(amount > 0, \\\"amount is 0\\\");\\n        require(isContract(contractAddress), \\\"contractAddress is not contract\\\");\\n        TokenContract tokenContract = TokenContract(contractAddress);\\n        require(tokenContract.transfer(to, amount), \\\"withdrawal failed\\\");\\n        return true;\\n    }\\n\\n    function transferFrom(address _from, address _to, uint256 _value) internal returns (bool){\\n        require(_to != 0x0, \\\"to address is 0x0\\\");\\n        require(_value > 0, \\\"The value must be that is greater than zero.\\\");\\n        require(balance[_from].balance >= _value, \\\"from address balance not enough\\\");\\n        uint256 result = balance[_to].balance + _value;\\n        require(result > 0, \\\"to address balance overflow\\\");\\n        require(result > balance[_to].balance, \\\"to address balance overflow\\\");\\n\\n        uint previousBalance = balance[_from].balance + balance[_to].balance;\\n        balance[_from].balance -= _value;\\n        if (!balance[_to].exists) {\\n            balance[_to].balance = _value;\\n            balance[_to].exists = true;\\n            addresses.push(_to);\\n        }\\n        else {\\n            balance[_to].balance += _value;\\n        }\\n        emit Transfer(_from, _to, _value);\\n        assert(balance[_from].balance + balance[_to].balance == previousBalance);\\n        return true;\\n    }\\n\\n\\n}\"},\"version\":\"4.0.0\"}}",
    "txSign":"01eaafc401958c80e998cabc70a8d5fabb8ad835865421b952f1fa7d34a65418400ee94ce789a17b304ed0ee441f20e1ad9033fb11232823a5662fbae7db7f0c3f"
} 
```

```json tab="响应实例"
{
	"data":"00000171b50e98ac6817929db66d979c4e416e68","msg":"Success","respCode":"000000","success":true
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

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

```json tab="请求实例"
{
	"txData":"{\"txId\":\"00000171b510d9a42b7f529d411cb865888d8df7\",\"bdId\":\"bd_demo_5\",\"functionId\":\"transfer\",\"templateId\":\"t-code-cert\",\"type\":\"EXECUTE_CONTRACT\",\"submitter\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"args\":[\"f1cc1d4385d0e3ed1b909e793506f2fb9d81db3d\",10000000000],\"contractAddress\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"methodSignature\":\"transfer(address,uint256)\"},\"version\":\"4.0.0\"}}",
    	"txSign":"0080a391ae13e0e7b31ed93e79d90d78a7ee583e3e1e86062d3477b5e8e4c7b53b1dfda6ea52445cc9f86f53f1455499c1ad21f5daf50ffe8cce07ba9995732950" 
} 
```

```json tab="响应实例"
{
	"data":"00000171b510d9a42b7f529d411cb865888d8df7","msg":"Success","respCode":"000000","success":true
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

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

```json tab="请求实例"
{
	"txData":"{\"txId\":\"00000171b50c928edb1aa9dd43080b94484f1eb7\",\"bdId\":\"SystemBD\",\"functionId\":\"SET_PERMISSION\",\"type\":\"SET_PERMISSION\",\"submitter\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"authorizers\":[\"2a4060d480ebf0b601294b1f9f9599936681de61\"],\"datas\":\"[\\\"2a4060d480ebf0b601294b1f9f9599936681de61\\\"]\",\"id\":\"permission_demo_1\",\"label\":\"dududu\",\"type\":\"ADDRESS\"},\"version\":\"4.0.0\"}}",
    	"txSign":"00b42baf90e2aca01c48b981fcb75b53e36bdb90a93cce503a662c808dc48ce8bc0c246b0d590104dc6219a1378eda77ae5b89619011aba6198bca9f8bf61b8ac9"
}
```

```json tab="响应实例"

{
    "data":"00000171b50c928edb1aa9dd43080b94484f1eb7","msg":"Success","respCode":"000000","success":true
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

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |                          |

- 实例：

```json tab="请求实例"
{
   "txData":"{\"txId\":\"00000171b513a81ed25f61b1da423e8b2a61aced\",\"bdId\":\"bd_demo_5\",\"functionId\":\"SET_IDENTITY\",\"type\":\"SET_IDENTITY\",\"submitter\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"address\":\"2671ea4b3c863cb5fc059889b7b37673369c073f\",\"identityType\":\"\",\"kyc\":\"\\\"country\\\":\\\"china\\\"\",\"property\":\"\\\"name\\\":\\\"luojianbo\\\"\"},\"version\":\"4.0.0\"}}",
   	"txSign":"0149849f25d4eeb9021518494ab50dbd3219294072138ba65d9ee2a9f89747aec054f0aaebac4e93d46b646ce1002932e2f46b4615133d10b152106523b7f755fc"
}
```

```json tab="响应实例"
{
	"data":"00000171b513a81ed25f61b1da423e8b2a61aced","msg":"Success","respCode":"000000","success":true
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

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |                         |

- 实例：

```json tab="请求实例"
{
	"txData":"{\"txId\":\"00000171b51585ff2d96adf9c3cdbad7d3180a18\",\"bdId\":\"bd_demo_5\",\"functionId\":\"FREEZE_IDENTITY\",\"type\":\"FREEZE_IDENTITY\",\"submitter\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"address\":\"2671ea4b3c863cb5fc059889b7b37673369c073f\"},\"version\":\"4.0.0\"}}",
    "txSign":"00a40c9fe26cdef423193847ea67680330df13ce3b083a2aebd8cbb6b450b39a637e587cba9dde08be9a6403fbfea90b6500bdc403d99ac588720d12f2202c25e1"
}
```

```json tab="响应实例"
{
    "data":"00000171b51585ff2d96adf9c3cdbad7d3180a18","msg":"Success","respCode":"000000","success":true
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

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

```json tab="请求实例"
{
	"txData":"{\"txId\":\"00000171b51729e48060ee75879a059b451a43d2\",\"bdId\":\"bd_demo_5\",\"functionId\":\"UNFREEZE_IDENTITY\",\"type\":\"UNFREEZE_IDENTITY\",\"submitter\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"address\":\"2671ea4b3c863cb5fc059889b7b37673369c073f\"},\"version\":\"4.0.0\"}}",
    "txSign":"014d0756a50d8f860df7cbfd945058677bd5ba635d1c2d46844c3c5840ea9648815eb84387520697a5ebf4f3fbb43e8dcb11d8ce9dc5cbb6ba2d559d28af4ef881"
}
```

```json tab="响应实例"
{
    "data":"00000171b51729e48060ee75879a059b451a43d2","msg":"Success","respCode":"000000","success":true
}
```


#### Identity鉴权
- [ ] 开放
- 接口描述：  检查用户是否有鉴别的权限
- 请求地址：`POST`：`v4/identity/checkPermission`
- 请求参数：(无签名) 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | N        | 用户地址                     |
| permissionNames | `string[]` |      | Y    | Y        | 需要检查的权限，数组                     |

- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `boolean` |   检查结果   |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

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
    respCode='000000', msg='Success', data=false
}
```

#### 查询Identity

- [ ] 开放
- 接口描述：查询Identity的详细信息  
- 请求地址：`GET`:`/v4/identity/query?address={address}`
- 请求参数：

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| address       | `string`   | 40       | Y    | Y        | identity地址              |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address | `string` | 40     | Y    | Y        | user identity 地址                      |
| currentTxId | `string` | 40     | Y    | Y        |    user identity 改修改时的txId                   |
| hidden | `string` | 1     | Y    | Y        | 1：显示，0：隐藏                      |
| froze | `boolean` |  10    | Y    | Y        | true：冻结，false：未冻结                      |
| identityType | `string` | 64     | Y    | Y        | identity类型(user/node/domain)                      |
| kyc | `string` |1024      | Y    | Y        | identity认证信息                      |
| preTxId | `string` | 40     | Y    | Y        |  上次identity被修改时交易id                   |
| property | `string` | 1024     | Y    | Y        |  扩展属性                   |
| version | `int` | 10     | Y    | Y        |  修改记录版本                   |

- 实例：

```json tab="响应实例"
{
	respCode='000000',
    msg='Success', 
    data={
        "address":"2671ea4b3c863cb5fc059889b7b37673369c073f",
        "bdId":"bd_demo_5",
        "hidden":0,
        "kyc":"\"country\":\"china\"",
        "identityType":"",
        "property":"\"name\":\"luojianbo\"",
        "preTxId":"00000171b55f3daf1c818e557dac3def738e3c67",
        "froze":false,
        "version":1,
        "currentTxId":"00000171b55f3daf1c818e557dac3def738e3c67"
    }
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
| id   | `string` | 40       | Y    | N        | 存证Id（唯一）                      |

- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

```json tab="请求实例"
{
	"txData":"{\"txId\":\"00000171b518d70461d63a39d06c4f8efb2899f2\",\"bdId\":\"bd_demo_5\",\"functionId\":\"SET_ATTESTATION\",\"type\":\"SET_ATTESTATION\",\"submitter\":\"2a4060d480ebf0b601294b1f9f9599936681de61\",\"version\":\"4.0.0\",\"actionDatas\":{\"datas\":{\"attestation\":\"存证的内容\",\"id\":\"00000171b518d6a65df6e0e2761359d30a827505\"},\"version\":\"4.0.0\"}}",
    "txSign":"00e35830840c00f6c443f43494425382c88b871ccc72e40a42b56fe465ec76f6c04a7569361ea0b2c1f351ae7e1dcf49d1047ac52709d817ffb936ba6bef42f80a"
}
```

```json tab="响应实例"
{
    "data":"00000171b518d70461d63a39d06c4f8efb2899f2","msg":"Success","respCode":"000000","success":true
}
```

#### 存证查询
- [ ] 开放
- 接口描述：  查询入链存证信息
- 请求地址：`GET`:`/v4/queryAttestation/{id}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:| -------- | -------| ---- | -------| :---------------------------- |
|      id    | `string` | 40     | Y    | Y      | 存证id                      |

- 响应参数：

|    属性        | 类型     | 最大长度   | 必填 | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ---- | -------- | :---------------------------- |
| id            | `string` | 40       | Y    | Y        | 存证id                      |
| attestation   | `string` | 4096     | Y    | N        | 存证内容                      |
| preTxId       | `string` | 40       | Y     | N        | 上次一次修改`txId` |
| currentTxId   | `string` | 40       | Y     | N        | 最近一次修改`txId` |
| version       | `int`    | 10       | Y     | N        | 版本号，系统自增 |
| bdId          | `string` | 32       | Y     | N        | 设置存证时的`bdId` |

- 实例：

```json tab="响应实例"
{
	respCode='000000', msg='Success', data={"attestation":"存证的内容","bdId":"bd_demo_5","id":"00000171b5664ea85df6e0e2761359d30a827505","version":1,"currentTxId":"00000171b5664ef3c6cb718e7130f80c4faea8c3"}
}
```

## **普通接口**
---
#### DRS回调地址注册(需要定时上报，Stacs-Native区块链不会存储)

-  [ ] 开放

`POST`:`/v4/callback/register`

>   (通常是)`DRS`向`CRS`注册交易完成时通知交易完成的回调地址

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明          |
| :----------: | -------- | -------- | ---- | -------- | ------------- |
| callbackUrl | `string` |   1024    | Y    | Y        | 回调地址，URL |


## **RS回调**
---
> 基于已经注册的回调地址，发送出块信息

- 回调实例

|     属性     | 类型     |  说明        |
| :----------:| -------- |  -----------|
| genesis     | `boolean` | 是否创世块 |
| blockHeader | `json` | 区块头信息 |
| transactionList | `json` | 区块头中的交易数据 |

- `blockHeader`

|     属性     | 类型     |  说明        |
| :----------:| -------- |  -----------|
| version     | `string` | 区块链版本 |
| previousHash | `string` | 上一个区块的hash |
| blockHash   | `string`  | 当前区块的hash |
| height       | `string` | 当前区块的高度 |
| stateRootHash| `StateRootHash` | 账本数据的hash散列表 |
| blockTime    | `string` | 出块时间 |
| txNum        | `string` | 当前区块的交易数量 |
| totalBlockSize | `string` | 区块链的总区块数量 |
| totalTxNum    | `string` | 区块链的总交易数量 |

- `stateRootHash`

|    属性           | 类型                  | 最大长度 | 必填 |  说明                          |
| :-----------------: | ----------------- | ------- | ---- |  :---------------------------- |
| attestation          | `string`          | 64      | Y    |  存证信息的MPT根hash                    |
| domainInfo     | `string`               | 64      | Y    |  domain信息的存储(MPT)树根hash              |
| stacsConfig   | `string`                | 64      | Y    |  系统属性的存储(MPT)树根hash         |
| contract          | `string`            | 64      | Y    |  合约数据的存储(MPT)树根hash                |
| permission      | `string`              | 64      | Y    |  perimission的存储(MPT)树根hash                 |
| domainMerchant    | `string`            | 64      | Y    |  商户信息的存储(MPT)树根hash                    |
| businessDefine          | `string`      | 64      | Y    |  businessDefine的存储(MPT)树根hash                    |
| identity           | `string`           | 64      | Y    |  identity的存储(MPT)树根hash               |
| ca           | `string`                 | 64      | Y    |  ca的存储(MPT)树根hash                |
| transaction           | `string`         | 64      | Y    |  交易数据的存储(MPT)树根hash                |
| policy           | `string`              | 64      | Y    |  policy的存储(MPT)树根hash                 |


- `transactionList`

 TransactionPO元素组成的数组

- `TransactionPO`

|     属性     | 类型     |  说明        |
| :----------:| -------- |  -----------|
| coreTx     | `string` | 交易原始信息 |
| policyData | `json` | 交易的policy |
| transactionReceipt   | `json`  | 交易执行信息 |
| blockHeight   | `string`  | 区块高度 |
| blockTime   | `string`  | 交易出块时间 |

- `coreTx`

|     属性     | 类型     |  说明        |
| :----------:| -------- |  -----------|
| txId     | `string` | 交易Id |
| bdId     | `string` | 交易绑定的businessDefine的Id |
| templateId  | `string` | 执行的智能合约templateId |
| type     | `string` | 交易类型 |
| subType     | `string` | 交易的子类型，由客户自定义 |
| sessionId     | `string` | 长会话Id |
| merchantId     | `string` | 商户Id |
| merchantSign     | `string` | 商户签名 |
| functionId     | `string` | 执行的bd或合约的functionId |
| submitter     | `string` | 交易提交者 |
| actionDatas     | `string` | 交易原始信息 |
| version     | `string` | 交易版本 |
| submitterSign     | `string` | 交易提交者的签名 |
| extensionDatas     | `string` | 额外补充信息 |

- `policyData`

|     属性     | 类型     |  说明        |
| :----------:| -------- |  -----------|
| policyId     | `string` | policy的Id |
| policyVersion | `string` | policy版本 |
| sender       | `string` | 投票的发送节点名称 |
| sendTime     | `string` | 投票的发送时间 |

- `transactionReceipt`

|     属性     | 类型     |  说明      |
| :----------:| -------- |  ---------|
| txId        | `string` | 交易的Id |
| result      | `boolean` | 交易的执行结果 |
| errorCode   | `string` | 错误码 |
| errorMessage| `string` | 错误信息 |
| receiptData | `json`   |交易执行结果信息|
| version     | `string` | 交易的版本 |




[1]: query-api.md#queryMaxHeight 
[2]: query-api.md#queryTxByTxId/{txId} 
[3]: query-api.md#queryTxsByHeight/{height}
[4]: query-api.md#queryContract
