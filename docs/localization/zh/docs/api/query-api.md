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
| height | `long` | 64     | Y    | Y        | 当前链的最大高度                      |

##### <a id="/queryTxByTxId/{txId}">根据txId查询交易数据</a>
- [x] 开放
- 接口描述：  查询当前最大的区块高度
- 请求地址：`GET`:`/queryTxByTxId/{txId}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| coreTx             | `json`     | 64       | Y    |        | 交易原始内容                      |
| policyData         | `json`     | 64       | N    |        | policy投票内容(交易未上链，返回为null)                    |
| transactionReceipt | `json`     | 64       | N    |        | 交易执行结果(交易未上链，返回为null)                      |
| blockHeight        | `string`   | 64       | N    |        | 区块高度 (交易未上链，返回为null)                     |
| blockTime          | `string`   | 64       | N    |        | 区块时间(交易未上链，返回为null)                      |

##### <a id="/queryTxsByHeight/{height}">根据高度查询区块内所有交易数据</a>
- [x] 开放
- 接口描述：  根据高度查询区块内所有交易数据
- 请求地址：`GET`:`/queryTxsByHeight/{height}`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| coreTx             | `json`     | 64       | Y    |        | 交易原始内容                      |
| policyData         | `json`     | 64       | Y    |        | policy投票内容                    |
| transactionReceipt | `json`     | 64       | Y    |        | 交易执行结果                      |
| blockHeight        | `string`   | 64       | Y    |        | 区块高度                      |
| blockTime          | `string`   | 64       | Y    |        | 区块时间                      |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| coreTx             | `json`     | 64       | Y    |        | 交易原始内容                      |
| policyData         | `json`     | 64       | Y    |        | policy投票内容                    |
| transactionReceipt | `json`     | 64       | Y    |        | 交易执行结果                      |
| blockHeight        | `string`   | 64       | Y    |        | 区块高度                      |
| blockTime          | `string`   | 64       | Y    |        | 区块时间                      |

##### <a id="/queryContract">合约状态查询</a>
- [x] 开放
- 接口描述：  根据高度查询区块内所有交易数据
- 请求地址：`POST`:`/queryContract`
- 请求参数： 

|    属性             | 类型     | 最大长度 | 必填    | 是否签名   | 说明                          |
| :----------------: | -------- | -------- | ---- | -------- | :---------------------------- |
| blockHeight        | `long`     | 64     | N    |          | 指定查询合约的区块高度，不指定使用链的最大高度|
| address            | `string`   | 40     | Y    |          | 指定查询合约地址，需要满足地址格式|
| methodSignature    | `string`   |        | Y    |          | 指定查询合约方法|
| parameters         | `jsonArray`|        | N    |          | 如果查询的方法参数列表为空，可以不指定参数，需要和`methodSignature`参数列表对应|

- 响应参数：

|    属性             | 类型        | 最大长度  | 必填  | 是否签名 | 说明                          |
| :----------------: | -----------| -------- | ---- | -------- | :---------------------------- |
| data             | `array`     | 64       | Y    |        | 返回的是一个数组，取决于合约方法返回值的定义   |

#### 交易返回属性结果
- policyData结构

|    属性             | 类型     | 最大长度 | 必填    | 是否签名   | 说明                          |
| policyId           | `string`   | 64       | Y    |        | 交易原始内容                      |
| policyVersion      | `string`   | 64       | Y    |        | policy投票内容                    |
| actionType         | `string`   | 64       | Y    |        | methodSign                      |
| sender             | `string`   | 64       | Y    |        | 区块高度                      |
| sendTime           | `date`     | 64       | Y    |        | 区块时间                      |
| voteInfos          | `json[]`   | 64       | Y    |        | 区块时间                      |
| decision           | `string`   | 64       | Y    |        | 区块时间                      |

- voteInfos结构

|    属性             | 类型     | 最大长度 | 必填    | 是否签名   | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| domainId           | `string`   | 64       | Y    |        | Domain                      |
| owner              | `string`   | 64       | Y    |        | 投票节点                    |
| decision           | `boolean`  | 64       | Y    |        | 投票回执结果                      |
| signType           | `string`   | 64       | Y    |        | 签名类型(BIZ|CONSENSUS)                      |
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