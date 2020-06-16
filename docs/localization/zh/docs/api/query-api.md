### 查询接口

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
| version | `string`  | 10     | Y    | Y        |  修改记录版本                   |
| currentBlockHeight | `long` |     | Y    | Y        | 当前的区块高度                     |

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
        "currentBlockHeight": 6，
        "currentTxId":"00000171b55f3daf1c818e557dac3def738e3c67"
    }
}
```

#### 查询perimission

- [ ] 开放
- 接口描述：查询perimission的详细信息  
- 请求地址：`GET`:`/v4/perimission/query?permissionId={permissionId}`
- 请求参数：

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| permissionId       | `string`   |        | Y    |   Y     | 权限ID              |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| id | `string` | 40     | Y    | Y        | 权限ID                      |
| label | `string` |  32    |     | Y        |   标签                 |
| type          | `string`  | 64        | Y    | Y        | 授权类型（ADDRESS/IDENTITY）       |
| authorizers   | `string[]`|           | Y    | Y        | 被授予后期可以修改Permission的地址|
| datas | `string` |      | Y    | Y        | 当type为ADDRESS时，datas为地址数组；type为IDENTITY时，datas为验证Identity表达式                      |
| version | `string`  | 10     | Y    | Y        |  修改记录版本                   |
| currentBlockHeight | `long` |     | Y    | Y        | 当前的区块高度                     |

- 实例：

```json tab="响应实例"
{
	respCode='000000',
    msg='Success', 
    data={
        "authorizers":[
            "6cab3f4122dd3bc9850e445d0eb3ef105d6a40e4"
        ],
        "currentTxId":"00000172bc02cfc6e9a727a7e1643cc48fbb211f",
        "datas":"["6cab3f4122dd3bc9850e445d0eb3ef105d6a40e4"]",
        "id":"permission_demo_1",
        "label":"jicaowu666",
        "preTxId":null,
        "type":"ADDRESS"，
        "currentBlockHeight": 6，
        "version":"4.2.0"
    }
}
```

#### 查询policy

- [ ] 开放
- 接口描述：查询policy的详细信息  
- 请求地址：`GET`:`/v4/policy/query?policyId={policyId}`
- 请求参数：

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| policyId       | `string`   |     32   | Y    |    Y    | policyID            |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| policyId       | `string`       | 32       | Y    | Y        | 注册/修改的policyId                               |
| label          | `string`       | 64       | N    | Y        |  标签                                            |
| votePattern    | `string`       | 10        | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| callbackType   | `string`       | 10         | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
| decisionType   | `string`       | 10         | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| domainIds      | `list<string>` | 256         | N    | Y        | 参与投票的domainId列表                       |
| requireAuthIds | `list<string>` | 256         | Y    | Y        | 需要通过该集合对应的domain授权才能修改当前policy |
| assignMeta     | `json` | 1024         | N    | Y        | 当decisionType=ASSIGN_NUM,assignMeta属性值需要签名 |
| version | `string` | 10     | Y    | Y        |  修改记录版本                   |
| currentBlockHeight | `long` |     | Y    | Y        | 当前的区块高度                     |

- 实例：

```json tab="响应实例"
{
	respCode='000000',
    msg='Success', 
    data={
        "assignMeta":null,
        "callbackType":"ALL",
        "decisionType":"FULL_VOTE",
        "domainIds":"["STACS-Domain-A","STACS-Domain-C","STACS-Domain-D"]",
        "label":"SYNC_DEFAULT",
        "policyId":"SYNC_DEFAULT",
        "requireAuthIds":"["STACS-Domain-A","STACS-Domain-C","STACS-Domain-D"]",
        "version":0,
        "votePattern":"SYNC"，
        "currentBlockHeight": 6，
        "version":"4.2.0"
    }
}
```

#### 查询BD

- [ ] 开放
- 接口描述：查询BD发布时的详细信息  
- 请求地址：`GET`:`/v4/BD/query?bdid={bdid}`
- 请求参数：

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| bdid       | `string`   |    32    | Y    |    Y    | BD编号            |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| id       | `string`       | 32       | Y    | Y        | BD编号                              |
| label   | `string`       | 32         | Y    | Y        | 标签       |
| contracts          | `List<FunctionDefine>`       |        | Y    | Y        |  BD定义的版本                                            |
| desc    | `string`       | 1024       | Y    | Y        | BD描述                   |
| functions   | `List<FunctionDefine>`       |          | Y    | Y        | BD定义function                    |
| bdVersion | `string`  | 10     | Y    | Y        |  修改记录版本                   |
| currentBlockHeight | `long` |     | Y    | Y        | 当前的区块高度                     |

`FunctionDefine`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:    | -------- | -------- | ---- | -------- | :---------------------------- |
| desc           | `string` | 256     | N    | Y        | function描述                     |
| execPermission | `string` | 64     | Y    | Y        | 执行function权限,发布bd时，该permission已经存在于链上                   |
| execPolicy     | `string` | 32     | Y    | Y        | 执行function policy,发布bd时，该policy已经存在于链上                      |
| methodSign     | `string` | 256     | Y    | Y        | 如果发布的是合约则填写的合约方法签名
| id             | `string` | 32     | Y    | Y        | function名称在同一个bd下不能重复                      |
| type           | `string` | 64     | Y    | Y        |function功能类型<a href="FUNCTION_TYPE">FUNCTION_TYPE</a>        |

- 实例：

```json tab="响应实例"
{
	respCode='000000',
    msg='Success', 
    data={
        "bdVersion":"4.2.0",
        "currentBlockHeight": 6，
        "contracts":"[{"createPermission":"DEFAULT","createPolicy":"SYNC_ONE_VOTE_DEFAULT","desc":"test","functions":[{"desc":"余额查询","execPermission":"DEFAULT","execPolicy":"SYNC_ONE_VOTE_DEFAULT","id":"balanceOf","methodSign":"(uint256) balanceOf(address)","type":"Contract"}]",
        "desc":"dvp_test_label",
        "functions":"[{"desc":"Identity解冻","execPermission":"DEFAULT","execPolicy":"SYNC_ONE_VOTE_DEFAULT","id":"UNFREEZE_IDENTITY","methodSign":"UNFREEZE_IDENTITY","type":"SystemAction"}]",
        "id":"bd_demo_5",
        "label":"dvp_test_label"
    }
}
```

#### 查询contract

- [ ] 开放
- 接口描述：查询合约发布时的详细信息  
- 请求地址：`GET`:`/v4/contract/query?address={address}`
- 请求参数：

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| address      | `string`   |    40    | Y    |    Y    | 合约地址            |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| address   | `string`       | 40         | Y    | Y        | 合约地址       |
| bdCodeVersion  | `string`        |     32   | Y    | Y        | BD版本     |
| bdId    | `string`       | 32       | Y    | Y        | BD编号                   |
| code   | `string`        |     text     | Y    | Y        | 合约源码                    |
| extension   | `string`        |     1024     | Y    | Y        | 扩展字段                   |
| id   | `string`        |     32     | Y    | Y        | 合约ID                    |
| label   | `string`       | 32         | Y    | Y        | 标签/合约简称       |
| language   | `string`        |     32     | Y    | Y        | 合约编程语言类型                    |
| status   | `string`        |     32     | Y    | Y        | 状态                   |
| templateId   | `string`        |     32     | Y    | Y        | 合约模板名称                   |
| txId   | `string`        |     40     | Y    | Y        | 交易id                   |
| version | `string`  | 10     | Y    | Y        |  修改记录版本                   |
| blockHeight | `long` |     | Y    | Y        | 发布合约时区块高度                     |
| currentBlockHeight | `long` |     | Y    | Y        | 当前的区块高度                     |

- 实例：

```json tab="响应实例"
{
	respCode='000000',
    msg='Success', 
    data={
        "blockHeight": 3,
        "currentBlockHeight": 6,
        "address":"6cab3f4122dd3bc9850e445d0eb3ef105d6a40e4",
        "bdCodeVersion":"4.0.0",
        "bdId":"bd_demo_5",
        "code":"~~~",
        "extension":null,
        "id":"certificate_demo_1",
        "label":"lalala",
        "language":"JAVA",
        "status":"ENABLED",
        "templateId":"t-code-cert",
        "txId":"00000172bbe389b1a09d504cfeefe02da623679e",
        "version":"4.2.0"
    }
}
```

#### 检查合约查询接口

- [ ] 开放
- 接口描述：检查该地址是否为合约地址  
- 请求地址：`GET`:`/v4/contract/checkContractAddress?address={address}`
- 请求参数：

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| address      | `string`   |    40    | Y    |    Y    | 地址            |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| checkResult    | `Boolean` |        | Y    | Y        | true/false       |


- 实例：

```json tab="响应实例"
{
	respCode='000000',
    msg='Success', 
    data={
        "checkResult": true
    }
}
```

#### 区块链状态查询接口

- [ ] 开放
- 接口描述：检查该地址是否为合约地址  
- 请求地址：`GET`:`/v4/stacs/info/query`
- 请求参数：无

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| nodeInfos    | `list<domainId>` | text      | Y    | Y        | 总数据         |


`domainId` 定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------:    | -------- | -----| ---- | -------- | :---------------------------- |
| domainId       | `string` | 32    | Y    | Y        | domain域                     |
| nodeInfos      | `list<NodeInfoVO>` | 256   | N    | Y        | 节点集合           |

`NodeInfoVO`定义:

###### NodeInfoVO
| 属性          | 类型          | 最大长度 | 必填 | 说明                           |
| ------------- | ------------- | -------- | ---- | ------------------------------ |
| nodeName         | `String`      |          | Y    | 当前节点名称
| domainId         | `String`      |          | Y    | 所属domain Id
| height           | `Long`        |          | Y    | 区块高度
| master           | `Boolean`     |          | Y    | 是否为master
| nodeState        | `String`      |          | Y    | 节点状态

- 实例：

```json tab="响应实例"
{
	respCode='000000',
    msg='Success', 
    "data":
        {"caAuth":false,"domainId":"GSX-GROUP","height":1,"joinedConsensus":false,"master":false,"masterName":"N/A",
            "nodeInfos":[
                {"domainId":"GSX-GROUP","nodeInfos":[{"domainId":"GSX-GROUP","height":1,"master":false,"nodeName":"GSX-GROUP-RS-B","nodeState":"Starting"},
                {"domainId":"GSX-GROUP","height":1,"master":false,"nodeName":"GSX-GROUP-RS-A","nodeState":"StartingConsensus"}]},
                {"domainId":"GSX-Slave","nodeInfos":[{"domainId":"GSX-Slave","height":0,"master":false,"nodeName":"GSX-Slave","nodeState":"N/A"}]},
                {"domainId":"JNUO","nodeInfos":[{"domainId":"JNUO","height":1,"master":false,"nodeName":"Jnuo-Slave","nodeState":"StartingConsensus"}]}],"nodeName":"GSX-GROUP-RS-A","nodeState":"Starting"},
    "msg":"Success","respCode":"000000","success":true
}
```

##### <a id="/queryMaxHeight">查询当前最大区块高度</a>
- [x] 开放
- 接口描述：  查询当前最大的区块高度
- 请求地址：`GET`:`/v4/queryMaxHeight`
- 请求参数： 无
 
- 响应参数：

|    属性     | 类型     | 说明                   |
| :---------: | -------- | :------------------ |
| height       | `long` | 当前链的最大高度         |

```json tab='响应实例'
   {"height":18}
```

##### <a id="/queryTxByTxId/{txId}">根据txId查询交易数据</a>
- [x] 开放
- 接口描述：  根据txId查询交易数据
- 请求地址：`GET`:`/v4/queryTxByTxId/{txId}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :----------------- |
| txId | `string` | 40     | Y    | Y        | txId                      |

- 响应参数：

|    属性     | 类型     |  说明                          |
| :---------: | -------- |  :---------------------------- |
| <a href="#coreTx">coreTx</a>   | `json`          | 交易原始内容                      |
| policyData         | `json`      | policy投票内容(交易未上链，返回为null)                    |
| transactionReceipt | `json`      | 交易执行结果(交易未上链，返回为null)                      |
| blockHeight        | `string`   | 区块高度 (交易未上链，返回为null)                     |
| blockTime          | `string`    | 区块时间(交易未上链，返回为null)                      |

- <a id="coreTx">coreTx</a>:

|     属性      | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| :-----------: | -------- | -------- | ---- | :------: | ------------------------------------------------------------ |
| txId          | `string` | 40       | Y    |    Y     | txId |
| bdId        | `string` | 32       | Y    |    Y     | 所有业务交易都需要指定bdCode  |
| templateId  | `string` | 32       | N    |    Y     |发布合约或执行合约方法时的合约templateCode|
| functionId  | `string` | 32       | Y    |    Y     | BD的functionId，如果是BD的初始化或者合约的发布：`CONTRACT_CREATION` |
| submitter     | `string` | 40       | Y    |    Y     | 操作提交者地址                                               |
| actionDatas   | `string` | ...      | Y    |    Y     | 业务参数JSON格式化数据，json数据包含{"version":"4.0.0","datas":{}}                                               |
| version       | `string` | 40       | Y    |    Y     | 交易版本号                                               |
| subType       | `string` | 32       | N    |    Y     |子业务类型                                             |
| sessionId     | `string` | 64       | N    |    Y     |会话id                                            |
| merchantId    | `string` | 32       | N    |    Y     |商户id                                            |
| merchantSign  | `string` | 128      | N    |    Y     |商户签名     
|extensionDatas | `string` | 1024     | N    |    Y     | 交易存证新消息                                               |
| submitterSign | `string` | 64       | Y    |    N     | 提交者`submitter`的`ECC`对交易的签名,该字段不参与签名 

##### <a id="/queryContract">合约状态查询</a>
- [x] 开放
- 接口描述：  合约状态查询
    1. blockHeight传0或null返回当前最新区块高度的合约状态;
    2. 如果链查询时区块链高度为1返回查询结果为`合约不存在`错误信息;
    3. 传的高度大于实际链的最大高度返回`the block is not exist`错误信息
- 请求地址：`POST`:`/v4/queryContract`
- 请求参数： 

|    属性             | 类型     | 最大长度 | 必填    | 是否签名   | 说明                          |
| :----------------: | -------- | -------- | ---- | -------- | :---------------------------- |
| blockHeight        | `long`     | 64     | N    |          | 指定查询合约的区块高度，不指定使用链的最大高度|
| contractAddress    | `string`   | 40     | Y    |          | 指定查询合约地址，需要满足地址格式|
| methodSignature    | `string`   |  256      | Y    |          | 指定查询合约方法|
| parameters         | `jsonArray`|  256      | N    |          | 如果查询的方法参数列表为空，可以不指定参数，需要和`methodSignature`参数列表对应|

- 响应参数：

|    属性             | 类型        | 最大长度  | 必填  | 是否签名 | 说明                          |
| :----------------: | -----------| -------- | ---- | -------- | :---------------------------- |
| data             | `array`     | 64       | Y    |        | 返回的是一个数组，取决于合约方法返回值的定义   |

#### 交易返回属性结果

- policyData结构

|    属性             | 类型     | 最大长度 | 必填    | 是否签名   | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| policyId           | `string`   | 64       | Y    |        | policy id(唯一)                      |
| label             | `string`   | 64       | N    |          | policy 名称                      |
| policyVersion      | `string`   | 64       | Y    |        | policy投票内容                    |
| actionType         | `string`   | 64       | Y    |        | methodSign                      |
| sender             | `string`   | 64       | Y    |        | 区块高度                      |
| sendTime           | `date`     | 64       | Y    |        | 区块时间                      |
| voteInfos          | `json[]`   | 64       | Y    |        | 投票信息                      |
| decision           | `string`   | 64       | Y    |        | 决议                      |

- voteInfos结构

|    属性             | 类型     | 最大长度 | 必填    | 是否签名   | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| domainId           | `string`   | 64       | Y    |        | Domain                      |
| owner              | `string`   | 64       | Y    |        | 投票节点                    |
| decision           | `boolean`  | 64       | Y    |        | 投票回执结果                      |
| signType           | `string`   | 64       | Y    |        | 签名类型(BIZ/CONSENSUS)                      |
| sign               | `date`     | 64       | Y    |        | 投票节点签名                      |

- transactionReceipt结构

|    属性             | 类型     | 最大长度 | 必填    | 是否签名   | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId               | `string`   | 64       | Y    |        | 交易id                      |
| result             | `boolean`  | 64       | Y    |        | 交易执行结果                    |
| errorCode          | `string`   | 64       | N    |        | 错误码                      |
| errorMessage       | `string`   | 64       | N    |        | 错误描述                      |
| receiptData        | `json`     | 64       | Y    |        | action回执                      |
| version            | `string`   | 64       | Y    |        | 交易版本号                      |

##### <a id="/block/queryBlockVO">根据高度查询区块内所有交易数据</a>
- [x] 开放
- 接口描述：  根据高度查询区块内所有已经被所有domain确认的交易数据
- 请求地址：`GET`:`/v4/queryBlockVO`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                        |
| :---------: | -------- | -------- | ---- | -------- | :-------------------------------------- |
| startHeight | `long`     | 64       | Y    |        | 要查询的起始高度(startHeight必须大于等于1)                          |
| size        | `int`     | 8       | Y    |          | 起始高度后的多少个(size必须在1-10之间)            |

- 响应参数(数组中单个对象属性)：

|    属性           | 类型                  | 最大长度 | 必填 |  说明                          |
| :--------------: | --------------------- | ------- | ---- |  :---------------------------- |
| genesis          | `boolean`             | 6       | Y    |  是否为创世块                   |
| blockHeader      | `BlockHeader`         | 64      | Y    |  BlockHeader对象               |
| transactionList  | `JSONArray<Transaction>` | 64      | Y    |  含有<a href="#Transaction">Transaction</a>的集合        |

- <a id="Transaction">Transaction</a>:

|    属性                     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:                | -------- | -------- | ---- | -------- | :---------------------------- |
| <a href="coreTx">coreTx</a>| `json`     | 64       | Y    |        | 交易原始内容                      |
| policyData                 | `json`     | 64       | Y    |        | policy投票内容                    |
| transactionReceipt         | `json`     | 64       | Y    |        | 交易执行结果                     |
| blockHeight                | `string`   | 64       | Y    |        | 区块高度                     |
| blockTime                  | `string`   | 64       | Y    |        | 区块时间                  |

- BlockHeader对象属性：

|    属性           | 类型                  | 最大长度 | 必填 |  说明                          |
| :--------------: | --------------------- | ------- | ---- |  :---------------------------- |
| version          | `string`              | 8       | Y    |  区块版本号                   |
| previousHash     | `string`              | 64      | Y    |  上个区块的hash               |
| blockHash        | `string`              | 64      | Y    |  当前区块的hash               |
| height           | `long`                | 64      | Y    |  区块高度                     |
| stateRootHash    | `StateRootHash`       | 64      | Y    |  rootHash对象                |
| blockTime        | `long`                | 64      | Y    |  区块时间                     |
| txNum            | `int`                 | 8       | Y    |  当前区块内交易数量            |
| totalBlockSize   | `BigDecimal`          | 64      | Y    |  区块大小                     |
| totalTxNum       | `long`                | 64      | Y    |  到此区块时，总的交易数量       |


- StateRootHash对象属性：

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
