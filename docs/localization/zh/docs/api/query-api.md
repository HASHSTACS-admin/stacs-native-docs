### 查询接口

##### <a id="/queryMaxHeight">查询当前最大区块高度</a>
- [x] 开放
- 接口描述：  查询当前最大的区块高度
- 请求地址：`GET`:`/queryMaxHeight`
- 请求参数： 
 
|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| height | `long` | 19     | Y    | Y        | 当前链的最大高度                      |

##### <a id="/queryTxByTxId/{txId}">根据txId查询交易数据</a>
- [x] 开放
- 接口描述：  根据txId查询交易数据
- 请求地址：`GET`:`/queryTxByTxId/{txId}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | 当前链的最大高度                      |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| <a href="#coreTx">coreTx</a>             | `json`     | 64       | Y    |        | 交易原始内容                      |
| policyData         | `json`     | 64       | N    |        | policy投票内容(交易未上链，返回为null)                    |
| transactionReceipt | `json`     | 64       | N    |        | 交易执行结果(交易未上链，返回为null)                      |
| blockHeight        | `string`   | 64       | N    |        | 区块高度 (交易未上链，返回为null)                     |
| blockTime          | `string`   | 64       | N    |        | 区块时间(交易未上链，返回为null)                      |

- <a id="coreTx">coreTx</a>:

|     属性      | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| :-----------: | -------- | -------- | ---- | :------: | ------------------------------------------------------------ |
| txId          | `string` | 64       | Y    |    Y     | 请求Id |
| bdId        | `string` | 32       | Y    |    Y     | 所有业务交易都需要指定bdCode  |
| templateId  | `string` | 32       | N    |    Y     |发布合约或执行合约方法时的合约templateCode|
| functionId  | `string` | 32       | Y    |    Y     | BD的functionId，如果是BD的初始化或者合约的发布：`CONTRACT_CREATION` |
| submitter     | `string` | 40       | Y    |    Y     | 操作提交者地址                                               |
| actionDatas   | `string` | text        | Y    |    Y     | 业务参数JSON格式化数据，json数据包含{"version":"4.0.0","datas":{}}                                               |
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
- 请求地址：`POST`:`/queryContract`
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
- 接口描述：  根据高度查询区块内所有交易数据
- 请求地址：`GET`:`/queryBlockVO`
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
| :-----------------: | --------------------- | ------- | ---- |  :---------------------------- |
| txRootHash          | `string`              | 64      | Y    |  交易hash                    |
| accountRootHash     | `string`              | 64      | Y    |  余额模型的账户               |
| txReceiptRootHash   | `string`              | 64      | Y    |  交易执行结果的hash           |
| rsRootHash          | `string`              | 64      | Y    |  rs信息的hash                |
| policyRootHash      | `string`              | 64      | Y    |  policyHash                 |
| contractRootHash    | `string`              | 64      | Y    |  合约hash                    |
| caRootHash          | `string`              | 64      | Y    |  ca的hash                    |
| stateRoot           | `string`              | 64      | Y    |  state hash                 |
