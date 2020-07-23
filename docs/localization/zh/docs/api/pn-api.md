### 专属网络相关接口

#### 设置链

- 接口描述：设置链
- 请求地址：`POST`: `/v4/pn/chain`
- 请求参数：

|    属性     | 类型                  | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------------------- | --------| ---- | -------- | :-------------------------------- |
| <a href="#ProprietaryNetworkVO">ProprietaryNetworkVO</a>      | `ProprietaryNetworkVO`             |        | Y    | Y        | 交易数据，json格式，参见`ProprietaryNetworkVO`|

- <a id="ProprietaryNetworkVO">ProprietaryNetworkVO</a>:

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | --------| ------- | ---- | ----- | :---------------------------- |
| chainId  | `string`    |   8    | N    | Y     |  链标识（公网则不填，专属网络只允许26大写英文字母，且最长8位）  |
| address | `string` |   40   | N    | Y     | 链地址 |
| label | `string`| 64 | N  | Y  |  标签|
| policyInfo | `PolicyInfo`|  | N  | Y  |  出网Policy策略|
| pnNodes | `list<NodeInfo>`|  | N  | Y  |  专属网络节点信息|
| syncGateway | `string`|  | N  | Y  |  协调网关地址（网址URL格式）|
| syncGatewayPubKey | `string`|  | N  | Y  |  协调网关公钥|
| usageState | `PnUsageStateEnum`|  | N  | Y  |  链使用状态 1. INIT 初始化 2. DISABLE 冻结（不可用） 3. ENABLE 解冻（可用）|

- PolicyInfo结构

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | --------| ------- | ---- | ----- | :---------------------------- |
| domainIds      | `list<string>` |          | Y   | Y        | 收到投票的domainId列表 |
| decisionType   | `string`       | 10         | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| votePattern    | `string`       | 10        | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| assignMeta     | `json` | 1024         | N    | Y        | 当decisionType=ASSIGN_NUM,assignMeta属性值需要签名 |

- assignMeta结构

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | --------| ------- | ---- | ----- | :---------------------------- |
| verifyNum  | `int`    |   10    | N    | Y     |  赞成票的最少票数  |
| expression | `string` |   256   | N    | Y     | 赞成票数的表达式，例如: n/2+1，其中n代表集群中的domain数 |
| mustDomainIds | `list<string>`| 256 | N  | Y  |  必须投赞成票的domainId|

- NodeInfo结构

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | --------| ------- | ---- | ----- | :---------------------------- |
| domainId  | `String`    |       | N    | Y     |  domainId  |
| nodeName | `string` |     | N    | Y     | 节点名称 |
| pubKey | `String`|  | N  | Y  |  节点公钥|


- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |     返回数据   |
| respCode    |   `string` |    状态码,000000为成功    |
| msg         |   `string` |    状态信息   |

``` 
{
  "respCode": "000000",
  "msg": "Success",
  "data": "000001737a6edcda9c9d830b585fda2970ef218e"
} 
``` 


#### 添加专属网络（主网）

- 接口描述： 主网添加专属网络配置信息
- 请求地址：`POST`: `/v4/pn/add`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:   | -------- | -------- | ----  | -------- | :---------------------------- |
| <a href="#ProprietaryNetworkVO">ProprietaryNetworkVO</a>       | `ProprietaryNetworkVO`             |        | Y    | Y        | 交易数据，json格式，参见`ProprietaryNetworkVO`|

- 响应参数：

|    属性      | 类型       |  说明        |
 | :---------: | -------    | :---------- |
 | data        |   `string` |   交易id     |
 | respCode    |   `string` |    状态码    |
 | msg         |   `string` |    状态信息   |

- 实例：

``` 
{
  "respCode": "000000",
  "msg": "Success",
  "data": "000001737a6edcda9c9d830b585fda2970ef218e"
} 
```

#### 修改专属网络（主网）

- 接口描述： 主网修改专属网络配置信息
- 请求地址：`POST`: `/v4/pn/set`
- 请求参数： 

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| <a href="#ProprietaryNetworkVO">ProprietaryNetworkVO</a>       | `ProprietaryNetworkVO`             |        | Y    | Y        | 交易数据，json格式，参见`ProprietaryNetworkVO`|

- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

``` 
{
  "respCode": "000000",
  "msg": "Success",
  "data": "000001737a6edcda9c9d830b585fda2970ef218e"
} 
```


#### 删除专属网络（主网）

- 接口描述： 主网删除专属网络配置信息
- 请求地址：`POST`: `/v4/pn/remove`
- 请求参数： 

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| <a href="#ProprietaryNetworkManageVO">ProprietaryNetworkManageVO</a>       | `ProprietaryNetworkManageVO`             |        | Y    | Y        | 交易数据，json格式，参见`ProprietaryNetworkManageVO`|

- <a id="ProprietaryNetworkManageVO">ProprietaryNetworkManageVO</a>:

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | --------| ------- | ---- | ----- | :---------------------------- |
| chainId  | `string`    |   8    | Y  | Y     |  链标识（公网则不填，专属网络只允许26大写英文字母，且最长8位）  |
| frozeType | `PnUsageStateEnum`|  | N  | Y  |  链使用状态 1. INIT 初始化 2. DISABLE 冻结（不可用） 3. ENABLE 解冻（可用）|


- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

``` 
{
  "respCode": "000000",
  "msg": "Success",
  "data": "000001737a6edcda9c9d830b585fda2970ef218e"
} 
```

#### 冻结/解冻 专属网络（主网）

- 接口描述： 修改专属网络的使用状态
- 请求地址：`POST`: `/v4/pn/changeFrozeState`
- 请求参数： 

- 请求参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| <a href="#ProprietaryNetworkManageVO">ProprietaryNetworkManageVO</a>       | `ProprietaryNetworkManageVO`             |        | Y    | Y        | 交易数据，json格式，参见`ProprietaryNetworkManageVO`|

- <a id="ProprietaryNetworkManageVO">ProprietaryNetworkManageVO</a>:

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | --------| ------- | ---- | ----- | :---------------------------- |
| chainId  | `string`    |   8    | Y  | Y     |  链标识（公网则不填，专属网络只允许26大写英文字母，且最长8位）  |
| frozeType | `PnUsageStateEnum`|  | Y  | Y  |  链使用状态 1. INIT 初始化 2. DISABLE 冻结（不可用） 3. ENABLE 解冻（可用）|


- 响应参数：

|    属性      | 类型       |  说明        |
| :---------: | -------    | :---------- |
| data        |   `string` |   交易id     |
| respCode    |   `string` |    状态码    |
| msg         |   `string` |    状态信息   |

- 实例：

``` 
{
  "respCode": "000000",
  "msg": "Success",
  "data": "000001737a6edcda9c9d830b585fda2970ef218e"
} 
```