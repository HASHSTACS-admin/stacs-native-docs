# 

#### 主网回调区块信息接口

- 接口描述：主网回调区块信息
- 请求地址：`POST`: `/v4/block/callback`
- 请求参数：

|    属性     | 类型                  | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------------------- | --------| ---- | -------- | :-------------------------------- |
| BlockVO      | `BlockVO`             |        | Y    | Y        | 交易数据，json格式，参见`BlockVO`|

- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |     返回数据   |
| respCode    |   `string` |    状态码,000000为成功    |
| msg         |   `string` |    状态信息   |

``` 
{
  "genesis": false,
  "blockHeader": {
    "version": "4.3.0",
    "previousHash": "pre hash",
    "blockHash": "root hash",
    "height": "11",
    "stateRootHash": null,
    "blockTime": "1594981900000",
    "txNum": 12,
    "totalBlockSize": 1234,
    "totalTxNum": null
  },
  "transactionList": [
    {
      "coreTx": {
        "txId": "000001735c545a4ce9df25aa429918bf17d0f4ef",
        "chainId": "STACS",
        "bdId": "bd id",
        "templateId": null,
        "type": "xxx",
        "subType": null,
        "sessionId": null,
        "merchantId": null,
        "merchantSign": null,
        "functionId": null,
        "submitter": "xx",
        "actionDatas": "action datas",
        "version": "xxx",
        "submitterSign": "xxxxx",
        "extensionDatas": null
      },
      "policyData": {
        "policyId": null,
        "policyVersion": 0,
        "sender": null,
        "sendTime": null,
        "voteInfos": null,
        "decision": false
      },
      "transactionReceipt": {
        "txId": null,
        "result": false,
        "errorCode": null,
        "errorMessage": null,
        "receiptData": null,
        "version": null
      },
      "blockHeight": "12",
      "blockTime": null
    }
  ],
  "callbackTime": "0",
  "createTime": null,
  "packSendTime": null,
  "packReceivedTime": null
}

``` 


#### 协调网关/主网 接收请求接口

- 接口描述： 协调网关/主网 接收请求接口
- 请求地址：`POST`: `/v4/receiveData`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ----  | -------- | :---------------------------- |
| SendDataVO        | `SendDataVO` |1024        | Y       | Y        | ca集合(签名拼接需要将caList中的每个ca拼接)                 |

- 响应参数：

|    属性      | 类型       |  说明        |
 | :---------: | -------    | :---------- |
 | data        |   `string` |   交易id     |
 | respCode    |   `string` |    状态码    |
 | msg         |   `string` |    状态信息   |

- 实例：

``` 
{
  "coreTx": {
    "txId": "000001735c4c4ec23fad168dd08d7f4c5e933d7e",
    "chainId": "STACS",
    "bdId": "bd id",
    "templateId": null,
    "type": "xxx",
    "subType": null,
    "sessionId": null,
    "merchantId": null,
    "merchantSign": null,
    "functionId": null,
    "submitter": "xx",
    "actionDatas": "action datas",
    "version": "xxx",
    "submitterSign": "xxxxx",
    "extensionDatas": null
  },
  "from": "from-test",
  "to": "STCS",
  "sign": "STCS-signature"
}

```



#### 协调网关接收发送数据接口

- 接口描述： 协调网关接收发送数据接口
- 请求地址：`POST`: `/v4/sendData`
- 请求参数： 

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| CoreTxSendVO | `CoreTxSendVO`   | 20     | N    | Y        | 过期时间                      |


- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

``` 
{
  "coreTx": {
    "txId": "000001735c4993abbbdb426bec7ba3796f0e53e3",
    "chainId": "STACS",
    "bdId": "bd id",
    "templateId": null,
    "type": "xxx",
    "subType": null,
    "sessionId": null,
    "merchantId": null,
    "merchantSign": null,
    "functionId": null,
    "submitter": "xx",
    "actionDatas": "action datas",
    "version": "xxx",
    "submitterSign": "xxxxx",
    "extensionDatas": null
  },
  "to": "STCS"
}
```


#### 获取主网所有节点信息(host+pubKey)接口

- 接口描述： 获取主网所有节点信息(host+pubKey)接口
- 请求地址：`POST`: `/node/peers`
- 请求参数： 

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |


- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

``` 
[
  {
    "nodeName": "node-a",
    "domainId": "domain-a",
    "pubNetwork": "native-a:7001",
    "pubKey": "pubkey",
    "priority": 5
  }
]
```