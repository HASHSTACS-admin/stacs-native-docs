# CRS接口文档

> 区分系统级和非系统级接口

## 通用请求

### 请求头

*   `GET`：**无额外参数**
*   `POST`:`Content-Type: application/json`

## 通用响应

### 200

请求提交成功，可能执行成功，也可能执行失败。具体需要根据响应内容来确定

#### 成功示例

```json
{
  "respCode": "000000", // 操作成功的返回代码
  "msg":"Success",		  // 操作成功
  "data":{...},				  // 请求实际响应 
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

`POST`：`/rs/register` 

- [ ] 开放

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明             |
| :---------: | -------- | -------- | ---- | :------: | ---------------- |
|    rsId     | `string` | 32       | Y    |    Y     |                  |
|    desc     | `string` | 128      | Y    |    Y     |                  |
|  domainId   | `string` | 16       | Y    |    Y     |                  |
| maxNodeSize | `int`    |          | N    |    Y     | 最大节点允许数量 |
| domainDesc  | `string` |          | N    |    Y     |                  |

##### 示例

```java
// todo sdk 请求代码
```



#### 移除RS

`POST`：`/rs/cancel`

- [ ] 开放

| 属性 | 类型     | 最大长度 | 必填 | 是否签名 | 说明 |
| :--: | -------- | -------- | ---- | -------- | ---- |
| rsId | `string` | 32       | Y    | Y        |      |

### CA

> 节点接入时认证信息

#### CA注册

`POST`：`/ca/auth`

- [ ] 开放

|  属性  | 类型         | 最大长度 | 必填 | 是否签名 | 说明 |
| :----: | ------------ | -------- | ---- | -------- | ---- |
| caList | `list<CaVO>` |          | Y    | Y        |      |

**CaVO：**

|   属性   | 类型     | 最大长度 | 必填 | 是否签名 | 说明                 |
| :------: | -------- | -------- | ---- | -------- | -------------------- |
|  period  | `date`   |          | Y    | Y        | ca生效时间(暂时无用) |
|  pubKey  | `string` |          | Y    | Y        | ca公钥               |
|   user   | `string` |          | Y    | Y        |                      |
| domainId | `string` |          | Y    | Y        | 生效的domainId       |
|  usage   | `string` |          | Y    | Y        | 1. biz 2. consensus  |



#### CA更新

`POST`：`/ca/update`

- [ ] 开放

|   属性   | 类型     | 最大长度 | 必填 | 是否签名 | 说明                 |
| :------: | -------- | -------- | ---- | -------- | -------------------- |
|  period  | `date`   |          | Y    | Y        | ca生效时间(暂时无用) |
|  pubKey  | `string` |          | Y    | Y        | ca公钥               |
|   user   | `string` |          | Y    | Y        |                      |
| domainId | `string` |          | Y    | Y        | 生效的domainId       |
|  usage   | `string` |          | Y    | Y        | 1. biz 2. consensus  |

#### CA撤销

`POST`：`/ca/cancel`

- [ ] 开放

|   属性   | 类型     | 最大长度 | 必填 | 是否签名 | 说明                |
| :------: | -------- | -------- | ---- | -------- | ------------------- |
|  pubKey  | `string` |          | Y    | Y        |                     |
|   user   | `string` |          | Y    | Y        |                     |
| domainId | `string` |          | Y    | Y        |                     |
|  usage   | `string` |          | Y    | Y        | 1. biz 2. consensus |

> 相比**统一参数**，缺少了`period`字段

### 节点

#### 节点加入

- [ ] 开放

`POST`：`/node/join`

>   节点加入共识网络

|   属性    | 类型     | 最大长度 | 必填 | 是否签名 | 说明           |
| :-------: | -------- | -------- | ---- | -------- | -------------- |
| nodeName  | `string` |          | Y    | Y        | 加入的节点名称 |
| domainId  | `string` |          | Y    | Y        |                |
| signValue | `string` |          | Y    | Y        |                |
|  pubKey   | `string` |          | Y    | Y        | 节点公钥       |



#### 节点离开

- [ ] 开放

`POST`：`/node/leave`

>   节点离开共识网络

|   属性    | 类型     | 最大长度 | 必填 | 是否签名 | 说明           |
| :-------: | -------- | -------- | ---- | -------- | -------------- |
| nodeName  | `string` | 32       | Y    | Y        | 离开的节点名称 |
| domainId  | `string` | 16       | Y    | Y        |                |
| signValue | `string` |          | Y    | Y        |                |
|  pubKey   | `string` |          | Y    | Y        | 节点公钥       |

### 手续费

#### 手续费地址合约配置

`POST`：`/fee/setConfig`

- [ ] 开放

>   配置手续费收取货币所在合约地址，以及收取手续费后，转入手续费的账户地址。

|      属性       | 类型     | 最大长度 | 必填 | 是否签名 | 说明                       |
| :-------------: | -------- | -------- | ---- | -------- | -------------------------- |
| contractAddress | `string` | 32       | Y    | Y        | 手续费收取货币所在合约地址 |
|   receiveAddr   | `string` | 40       | Y    | Y        | 手续费收费地址             |

## 非系统级接口

### 查询类接口

#### 查询类接口通用参数列表

#### 节点

##### 查询所有节点信息

`GET`：`/node/query`

- [x] 开放

>   查询目前集群中所有的节点信息

#### 权限

##### Identity权限查询

`GET`：`/identity/permission/query`

- [x] 开放

>   查询用户所有的权限
>
>   注：如果用户不存在或传入`address`为空,则返回空的权限列表

|  属性   | 类型     | 最大长度 | 必填 | 是否签名 | 说明                      |
| :-----: | -------- | -------- | ---- | -------- | ------------------------- |
| address | `string` | 40       | Y    | N        | 需要查询的identityAddress |



##### Identity鉴权

- [x] 开放

`POST`：`identity/checkPermission`

>   验证identity是否有对应Permission列表的权限：
>
>   1.  如果用户不存在，返回`false`
>   2.  如果`permissionNames`为空，返回`true`

|      属性       | 类型           | 最大长度 | 必填 | 是否签名 | 说明                           |
| :-------------: | -------------- | -------- | ---- | -------- | ------------------------------ |
|     address     | `string`       | 40       | Y    | N        | 需要查询的identityAddress      |
| permissionNames | `list<string>` |          | N    | N        | 需要鉴权的`permissionName`列表 |



#### BD

##### BD查询

- [x] 开放

`GET`:`/bd/query`

>   查询所有BD,或是基于给定的BD`code`查询对应BD。
>
>   如果参数`bdCode`为空，返回系统所有BD列表

|  属性  | 类型     | 最大长度 | 必填 | 是否签名 | 说明             |
| :----: | -------- | -------- | ---- | -------- | ---------------- |
| bdCode | `string` | 64       | N    | N        | 需要查询的BDCode |

#### 存证

##### 存证查询

- [x] 开放

`GET`:`/attestation/query`

>   根据交易Id查询对应的存证信息，需要查询存证已存在。

| 属性 | 类型     | 最大长度 | 必填 | 是否签名 | 说明             |
| :--: | -------- | -------- | ---- | -------- | ---------------- |
| txId | `string` | 64       | Y    | N        | 需要查询的交易id |

#### 快照

##### 快照查询

- [x] 开放

`GET`:`/snapshot/query`

>   根据交易Id查询对应的快照信息，需要该快照对应的`打快照`操作已经执行完成。

| 属性 | 类型     | 最大长度 | 必填 | 是否签名 | 说明             |
| :--: | -------- | -------- | ---- | -------- | ---------------- |
| txId | `string` | 64       | Y    | N        | 需要查询的交易id |

#### 合约

##### 查询

- [x] 开放

`POST`:`/contract/query`

>   基于BD `code`查询对应业务类型合约列表。

|      属性       | 类型       | 最大长度 | 必填 | 是否签名 | 说明                                   |
| :-------------: | ---------- | -------- | ---- | -------- | -------------------------------------- |
|     address     | `string`   | 40       | Y    | N        | 合约地址                               |
| methodSignature | `string`   |          | Y    | N        | 方法签名，eg：`(uint256) get(uint256)` |
|   blockHeight   | `long`     |          | N    | N        | 块高度                                 |
|   parameters    | `object[]` |          | N    | N        | 方法参数                               |

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



#### BD(Business Define)

##### BD发布

- [x] 开放

`POST`:`/bd/publish`

>   在整个区块链上发布新的业务定义(`BD`)

| 属性           | 类型                   | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| -------------- | ---------------------- | -------- | ---- | -------- | ------------------------------------------------------------ |
| code           | `string`               | 32       | Y    | Y        | BD code，唯一且只能使用大小写字母与数字的组合                |
| name           | `string`               | 64       | N    | Y        | 必须参与投票的domainId列表                                   |
| bdType         | `string`               | 32       | N    | Y        | BD类型：`system`、`contract`，如果值为`system`表示系统类型，`initPermission`&`initPolicy`可为**空** |
| desc           | `string`               | 1024     | N    | Y        | BD描述                                                       |
| initPermission | `string`               | 64       | Y    | Y        | BD执行`initPolicy`时所需的`PermissionName`                   |
| initPolicy     | `string`               | 32       | Y    | Y        | 创建`BD`关联的合约时所需`policy`的id                         |
| functions      | `list<FunctionDefine>` |          | Y    | Y        | BD中定义的`function`列表                                     |
| bdVersion      | `string`               | 4        | Y    | Y        | BD 版本号                                                    |

**FuncitonDefine参数**

>   BD中定义的各类业务方法以及它们关联的执行权限、执行策略(Policy)

| 属性           | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                       |
| -------------- | -------- | -------- | ---- | -------- | ------------------------------------------ |
| name           | `string` | 64       | Y    | Y        | function name                              |
| type           | `string` |          | Y    | Y        | 1. contract 2. systemAction                |
| desc           | `string` | 256      | N    | Y        | BD function文字描述                        |
| methodSign     | `string` | 256      | Y    | Y        | 方法签名，eg：`(bool) buybackFrozen(bool)` |
| initPermission | `string` | 64       | N    | Y        | BD执行`initPolicy`时所需的`PermissionName` |
| execPolicy     | `string` | 32       | N    | Y        | 执行`function`时所需`policy`Id             |

#### 智能合约

##### 部署

- [x] 开放

`POST`:`/contract/deploy`

>   创建一个关联对应`bdCode`的**合约**，`initArgs`将传入对应BD的初始化方法。

| 属性            | 类型       | 最大长度 | 必填 | 是否签名 | 说明                       |
| --------------- | ---------- | -------- | ---- | -------- | -------------------------- |
| fromAddr        | `string`   | 40       | Y    | Y        | 提交者地址                 |
| contractAddress | `string`   | 40       | N    | Y        | 必须参与投票的domainId列表 |
| name            | `string`   | 64       | Y    | Y        | 合约名称                   |
| extension       | `string`   | 1024     | N    | Y        | 扩展属性                   |
| contractor      | `string`   |          | Y    | Y        | 合约构造器(函数)名         |
| sourceCode      | `string`   |          | Y    | Y        | 合约代码                   |
| initArgs        | `object[]` |          | Y    | Y        | 合约构造入参               |



##### 执行

- [x] 开放

`POST`:`/contract/invoke`

>   传入参数`args`，执行合约对应的方法。

| 属性            | 类型         | 最大长度 | 必填 | 是否签名 | 说明                                                         |
| --------------- | ------------ | -------- | ---- | -------- | ------------------------------------------------------------ |
| methodSignature | `string`     |          | Y    | Y        | 方法签名                                                     |
| args            | `object[]`   |          | N    | Y        | 合约方法入参                                                 |
| from            | `string`     | 40       | Y    | Y        | 交易提交地址                                                 |
| to              | `string`     | 40       | Y    | Y        | 合约地址                                                     |
| value           | `BigDecimal` |          | N    | Y        | (如果是转账方法)转账金额                                     |
| functionName    | `string`     |          | Y    | Y        | BD的functionName，如果是BD的初始化或者合约的发布：`CREATE_CONTRACT` |

#### Policy

##### AssigMeta类型


| 属性          | 类型          | 最大长度 | 必填 | 是否签名 | 说明                           |
| ------------- | ------------- | -------- | ---- | -------- | ------------------------------ |
| verifyNum     | `int`         |          | N    | Y        | 需要投票的domain数量           |
| mustDomainIds | `list<string` |          | N    | Y        | 必须参与投票的domainId列表     |
| expression    | `string`      |          | N    | Y        | 投票规则表达式，example: n/2+1 |

##### Policy注册

- [ ] 开放

`POST`:`/policy/register`

>   创建新的投票策略

| 属性           | 类型           | 最大长度 | 必填 | 是否签名 | 说明                                         |
| -------------- | -------------- | -------- | ---- | -------- | -------------------------------------------- |
| policyId       | `string`       | 32       | Y    | Y        | 注册的policyId                               |
| policyName     | `string`       | 64       | Y    | Y        |                                              |
| votePattern    | `string`       |          | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| callbackType   | `string`       |          | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
| decisionType   | `string`       |          | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| domainIds      | `list<string>` |          | Y    | Y        | 参与投票的domainId列表                       |
| requireAuthIds | `list<string>` |          | N    | Y        | 需要通过该集合对应的rs授权才能修改当前policy |

##### Policy更新

- [ ] 开放

`POST`:`/policy/modify`

>   更新旧的投票策略

|      属性      | 类型           | 最大长度 | 必填 | 是否签名 | 说明                                         |
| :------------: | -------------- | -------- | ---- | -------- | -------------------------------------------- |
|    policyId    | `string`       | 32       | Y    | Y        | 注册的policyId                               |
|   policyName   | `string`       | 64       | Y    | Y        |                                              |
|  votePattern   | `string`       |          | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
|  callbackType  | `string`       |          | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
|  decisionType  | `string`       |          | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
|   domainIds    | `list<string>` |          | Y    | Y        | domainId列表                                 |
| requireAuthIds | `list<string>` |          | N    | Y        | 需要通过该集合对应的rs授权才能修改当前policy |

#### Permission

##### 新增Permission

- [x] 开放

`POST`:`/permission/register`

>   注册新的权限，用于新的业务权限管理

|      属性      | 类型     | 最大长度 | 必填 | 是否签名 | 说明         |
| :------------: | -------- | -------- | ---- | -------- | ------------ |
| permissionName | `string` | 64       | Y    | Y        | 新增权限名称 |

#### Identity

##### Identity设置

- [x] 开放

`POST`:`/identity/setting`

>   新增`identity`或修改对应地址的`identity`属性设置

|     属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                                              |
| :----------: | -------- | -------- | ---- | -------- | ------------------------------------------------- |
| identityType | `string` |          | Y    | Y        | 1. user（DApp） 2. domain（机构） 3. node（节点） |
|   property   | `string` | 1024     | N    | Y        | 用户自定义属性，Json类型                          |
|   address    | `string` | 40       | Y    | Y        | 新增identity地址                                  |



##### Identity授权

- [x] 开放

`POST`:`/permission/authorize`

>   向地址对应的`identity`赋予权限列表对应的权限，如果`identity`不存在，则自动新增。

|      属性       | 类型       | 最大长度 | 必填 | 是否签名 | 说明                               |
| :-------------: | ---------- | -------- | ---- | -------- | ---------------------------------- |
| identityAddress | `string`   | 40       | Y    | Y        | 新增identity地址                   |
| permissionNames | `string[]` |          | Y    | Y        | 给Identity授权的PermissionName数组 |
|  identityType   | `string`   |          | Y    | Y        | 1. user 2. domain 3. node          |

> 如果`address`中对应的`identity`不存在，则会自动新增`identity`，因此`identityType`也是必填字段

##### identity撤销权限

- [x] 开放

`POST`:`/permission/cancel`

>   向地址对应的`identity`撤销权限列表对应的权限。
>
>   同授权，不同的是，撤销授权时，如果`identityAddress`没有对应的`identity`则会执行失败。

|      属性       | 类型       | 最大长度 | 必填 | 是否签名 | 说明                               |
| :-------------: | ---------- | -------- | ---- | -------- | ---------------------------------- |
| identityAddress | `string`   | 40       | Y    | Y        | 新增identity地址                   |
| permissionNames | `string[]` |          | Y    | Y        | 给Identity授权的PermissionName数组 |

##### Identity冻结/解冻

- [x] 开放

`POST`:`/identity/bdManage`

>   对`identity`冻结/解冻相应`BD`，如果`identity`被冻结，则该`identity`不能执行所有关联冻结`BD`的合约

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| targetAddress | `string`   | 40       | Y    | Y        | 目标identity地址              |
|    BDCodes    | `string[]` |          | Y    | Y        |                               |
|  actionType   | `string`   |          | Y    | Y        | 操作类型：1. froze 2. unfroze |



##### KYC设置

- [x] 开放

`POST`:`/kyc/setting`

>   设置`identity`的*KYC*属性，如果`identityAddress`不存在对应的`identity`，则该会新增该`identity`，类型默认为`user`

|      属性       | 类型     | 最大长度 | 必填 | 是否签名 | 说明                            |
| :-------------: | -------- | -------- | ---- | -------- | ------------------------------- |
| identityAddress | `string` | 40       | Y    | Y        | 目标identity地址                |
|       KYC       | `string` | 1024     | Y    | Y        | KYC属性                         |
|  identityType   | `string` |          | N    | Y        | 1. user(默认) 2. domain 3. node |



#### 手续费

 手续费收取规则配置

- [x] 开放

`POST`:`/fee/setRule`

>   配置多个`policy`每笔交易收取的手续费金额

`FeeTxRuleVO`：

|   属性   | 类型     | 最大长度 | 必填 | 是否签名 | 说明                     |
| :------: | -------- | -------- | ---- | -------- | ------------------------ |
| policyId | `string` | 32       | Y    | Y        | 交易对应的policyId       |
|  amount  | `string` | 18       | Y    | Y        | 每笔交易收取的手续费金额 |

>   接口参数类型：`list<FeeTxRuleVO>`

#### 系统配置

- [x] 开放

`POST`:`/systemProperty/config`

>   配置区块链系统参数，如果不存在则新增，反之则更新。



| 属性  | 类型     | 最大长度 | 必填 | 是否签名 | 说明      |
| :---: | -------- | -------- | ---- | -------- | --------- |
|  key  | `string` | 190      | Y    | Y        | 属性key   |
| value | `string` | 1024     | Y    | Y        | 属性value |
| desc  | `string` |          | Y    | Y        | 属性描述  |

#### 快照

-   [x] 开放

`POST`:`/snapshot/build`

>   创建区块链当前最高区块的快照

|    属性    | 类型     | 最大长度 | 必填 | 是否签名 | 说明     |
| :--------: | -------- | -------- | ---- | -------- | -------- |
| snapshotId | `string` | 64       | Y    | Y        | 请求标识 |



#### 存证

- [x] 开放
- 接口描述：  保存存证信息入链
- 请求地址：`POST`:`/attestation/save`
- 请求参数： 

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| attestation | `string` | 4096     | Y    | Y        | 存证内容                      |
|   version   | `string` | 20       | Y    | Y        | 存证版本                      |
|   remark    | `string` | 1024     | N    | Y        | 备注                          |
|  objective  | `string` | 40       | N    | Y        | 目标地址，默认使用`submitter` |

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| txId | `string` | 64     | Y    | Y        | 存证内容                      |

- 实例：

``` json tab="请求实例"
    {
        attestation: "我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，我是存证，",
        attestationVersion: "1.0",
        baseSignValue: "71a29ad1d5968081bfc911b07066a2e953ebe5451b1f1779a9ff54f580170914SystemBDSAVE_ATTESTATIONnullnull",
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
``` json tab="响应实例"
{
   txId: "71a29ad1d5968081bfc911b07066a2e953ebe5451b1f1779a9ff54f580170914"
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

