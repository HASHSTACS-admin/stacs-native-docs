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
| currentBlockHeight | `long` |     | Y    | Y        | 当前的区块高度                     | 
| identityInfo | `identityInfo` | 40     | Y    | Y        | identity对象                |

`identityInfo`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------:    | -------- | -----| ---- | -------- | :---------------------------- |
| bdId    | `string`       | 32       | Y    | Y        | BD编号                   |
| address | `string` | 40     | Y    | Y        | user identity 地址                      |
| currentTxId | `string` | 40     | Y    | Y        |    user identity 改修改时的txId                   |
| hidden | `string` | 1     | Y    | Y        | 1：显示，0：隐藏                      |
| froze | `boolean` |  10    | Y    | Y        | true：冻结，false：未冻结                      |
| identityType | `string` | 64     | Y    | Y        | identity类型(user/node/domain)                      |
| kyc | `string` |1024      | Y    | Y        | identity认证信息                      |
| preTxId | `string` | 40     | Y    | Y        |  上次identity被修改时交易id                   |
| property | `string` | 1024     | Y    | Y        |  扩展属性                   |
| version | `string`  | 10     | Y    | Y        |  修改记录版本                   |

- 实例：

```json tab="响应实例"
{
	"data":{
		"identityInfo":{
			"address":"42473da8cfb880f9e0df4874bb54b12b2efcde69",
			"hidden":1,
			"identityType":"node",
			"preTxId":"",
			"froze":false,
			"version":0,
			"currentTxId":"",
            "bdId":"BD1"
		},
		"currentBlockHeight":655
	},
	"msg":"Success",
	"respCode":"000000"
} 
```

#### 查询Permission 

- [ ] 开放
- 接口描述：查询Permission的详细信息  
- 请求地址：`GET`:`/v4/perimission/query?permissionId={permissionId}`
- 请求参数：

|     属性      | 类型       | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------: | ---------- | -------- | ---- | -------- | ----------------------------- |
| permissionId       | `string`   |   32    | Y    |   Y     | 权限ID              |


- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| currentBlockHeight | `long` |     | Y    | Y        | 当前的区块高度                     | 
| permissionInfo | `permissionInfo` | 40     | Y    | Y        | permission对象       |


`permissionInfo`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------:    | -------- | -----| ---- | -------- | :---------------------------- |
| id | `string` | 40     | Y    | Y        | 权限ID                      |
| label | `string` |  32    |     | Y        |   标签                 |
| type          | `string`  | 64        | Y    | Y        | 授权类型（ADDRESS/IDENTITY）       |
| authorizers   | `string[]`|           | Y    | Y        | 被授予后期可以修改Permission的地址|
| datas | `string` |      | Y    | Y        | 当type为ADDRESS时，datas为地址数组；type为IDENTITY时，datas为验证Identity表达式                      |
| currentTxId | `string`  | 40     | Y    | Y        |  交易ID                  |

- 实例：

```json tab="响应实例"
{
	"data":{
		"currentBlockHeight":655,
		"permissionInfo":{
			"datas":"[\"6cab3f4122dd3bc9850e445d0eb3ef105d6a40e4\"]",
			"authorizers":[
				"6cab3f4122dd3bc9850e445d0eb3ef105d6a40e4"
			],
			"id":"permission_demo_1",
			"label":"jicaowu666",
			"type":"ADDRESS",
			"currentTxId":"00000172bc02cfc6e9a727a7e1643cc48fbb211f"
		}
	},
	"msg":"Success",
	"respCode":"000000"
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
| currentBlockHeight | `long` |     | Y    | Y        | 当前的区块高度                     | 
| policyInfo | `policyInfo` | 40     | Y    | Y        | policy对象       |

`policyInfo`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------:    | -------- | -----| ---- | -------- | :---------------------------- |
| policyId       | `string`       | 32       | Y    | Y        | 注册/修改的policyId                               |
| label          | `string`       | 64       | N    | Y        |  标签                                            |
| votePattern    | `string`       | 10        | Y    | Y        | 投票模式，1. SYNC 2. ASYNC                   |
| callbackType   | `string`       | 10         | Y    | Y        | 回调类型，1. ALL 2. SELF                     |
| decisionType   | `string`       | 10         | Y    | Y        | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM       |
| domainIds      | `list<string>` | 256         | N    | Y        | 参与投票的domainId列表                       |
| requireAuthIds | `list<string>` | 256         | Y    | Y        | 需要通过该集合对应的domain授权才能修改当前policy |
| assignMeta     | `json` | 1024         | N    | Y        | 当decisionType=ASSIGN_NUM,assignMeta属性值需要签名 |
| version | `string` | 10     | Y    | Y        |  修改记录版本                   |

- 实例：

```json tab="响应实例"
{
	"data":{
		"currentBlockHeight":655,
		"policyInfo":{
			"domainIds":[
				"STACS-Domain-A",
				"STACS-Domain-C",
				"STACS-Domain-D"
			],
			"policyId":"ASYNC_DEFAULT",
			"uniqKey":"ASYNC_DEFAULT",
			"requireAuthIds":[
				"STACS-Domain-A",
				"STACS-Domain-C",
				"STACS-Domain-D"
			],
			"decisionType":"FULL_VOTE",
			"votePattern":"ASYNC",
			"label":"ASYNC_DEFAULT",
			"version":0,
			"callbackType":"ALL"
		}
	},
	"msg":"Success",
	"respCode":"000000"
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
| currentBlockHeight | `long` |     | Y    | Y        | 当前的区块高度                     |
| bdInfo | `bdInfo` |     | Y    | Y        | bd对象                     |

`bdInfo`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------:    | -------- | -----| ---- | -------- | :---------------------------- |
| id       | `string`       | 32       | Y    | Y        | BD编号                              |
| label   | `string`       | 32         | Y    | Y        | 标签       |
| contracts          | `List<ContractDefine>`      |        | Y    | Y        |  bd定义contract                                             |
| desc    | `string`       | 1024       | Y    | Y        | BD描述                   |
| functions   | `List<FunctionDefine>`       |          | Y    | Y        | BD定义function                    |
| bdVersion | `string`  | 10     | Y    | Y        |  修改记录版本                   |

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

- 实例：

```json tab="响应实例"
{
	"data":{
		"currentBlockHeight":655,
		"bdinfo":{
			"bdVersion":"4.0",
			"functions":[
				{
					"methodSign":"ADD_BD",
					"execPermission":"DEFAULT",
					"id":"ADD_BD",
					"execPolicy":"SYNC_ONE_VOTE_DEFAULT",
					"type":"SystemAction",
					"desc":"发布BD"
				},
				{
					"methodSign":"ADD_SNAPSHOT",
					"execPermission":"DEFAULT",
					"id":"ADD_SNAPSHOT",
					"execPolicy":"SYNC_ONE_VOTE_DEFAULT",
					"type":"SystemAction",
					"desc":"发布快照"
				}
			],
			"index":0,
			"id":"BD1",
			"label":"BD1",
			"contracts":[
				{
					"functions":[
						{
							"methodSign":"(uint256) balanceOf(address)",
							"execPermission":"DEFAULT",
							"id":"balanceOf",
							"execPolicy":"SYNC_ONE_VOTE_DEFAULT",
							"type":"Contract",
							"desc":"余额查询"
						},
						{
							"methodSign":"(bool) transfer(address,uint256)",
							"execPermission":"DEFAULT",
							"id":"transfer",
							"execPolicy":"SYNC_ONE_VOTE_DEFAULT",
							"type":"Contract",
							"desc":"转账"
						}
					],
					"createPolicy":"SYNC_ONE_VOTE_DEFAULT",
					"templateId":"bond",
					"createPermission":"DEFAULT",
					"desc":"test"
				},
				{
					"functions":[
						{
							"methodSign":"(uint256) balanceOf(address)",
							"execPermission":"DEFAULT",
							"id":"balanceOf",
							"execPolicy":"SYNC_ONE_VOTE_DEFAULT",
							"type":"Contract",
							"desc":"余额查询"
						},
						{
							"methodSign":"(bool) transfer(address,uint256)",
							"execPermission":"DEFAULT",
							"id":"transfer",
							"execPolicy":"SYNC_ONE_VOTE_DEFAULT",
							"type":"Contract",
							"desc":"转账"
						},
						{
							"methodSign":"(string) benchmark()",
							"execPermission":"DEFAULT",
							"id":"benchmark",
							"execPolicy":"SYNC_ONE_VOTE_DEFAULT",
							"type":"Contract",
							"desc":"标的类型查询"
						},
						{
							"methodSign":"(bool) buy(address,uint256,uint256)",
							"execPermission":"DEFAULT",
							"id":"buy",
							"execPolicy":"SYNC_ONE_VOTE_DEFAULT",
							"type":"Contract",
							"desc":"购买"
						}
					],
					"createPolicy":"SYNC_ONE_VOTE_DEFAULT",
					"templateId":"certificate",
					"createPermission":"DEFAULT",
					"desc":"test"
				}
			],
			"version":"4.0.0",
			"desc":"BD描述"
		}
	},
	"msg":"Success",
	"respCode":"000000"
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
| currentBlockHeight | `long` |     | Y    | Y        | 当前的区块高度                     |
| contractInfo | `contractInfo` |     | Y    | Y        | contract对象                     |

`contractInfo`定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------:    | -------- | -------- | ---- | -------- | :---------------------------- |
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

- 实例：

```json tab="响应实例"
{
	"data":{
		"contractInfo":{
			"address":"6cab3f4122dd3bc9850e445d0eb3ef105d6a40e4",
			"code":"pragma solidity ^0.4.24;\n\ncontract Common {\n\n\n    bytes32 constant TX_ID = bytes32(0x00000000000000000000000000000000000000000000000000000074785f6964);\n    bytes32 constant STACS_KEY_ADDR = bytes32(0x5354414353000000000000000000000000000000000000000000000000000002);\n\n    event Transfer(address indexed from, address indexed to, uint256 value);\n\n    //assemble the given address bytecode. If bytecode exists then the _addr is a contract.\n    function isContract(address _addr) public view returns (bool is_contract) {\n        uint length;\n        assembly {\n        //retrieve the size of the code on target address, this needs assembly\n            length := extcodesize(_addr)\n        }\n        return (length > 0);\n    }\n\n}\n\ninterface OrderContract {\n    function buy(address buyer, uint256 amount, uint256 payAmount) external returns (bool success);\n}\n\ninterface TokenContract {\n    function transfer(address _to, uint256 _value) external returns (bool success);\n}\n\ncontract Certificate_TypeA is Common {\n    uint16 constant MAX_NUMBER_OF_QUERY_PER_PAGE = 100;\n    uint256 total;\n    uint8 decimals = 8;\n    address issuer;\n    address owner;\n    string  supportBenchmark;\n    uint256 totalInvalid;\n\n    struct Balance {\n        uint256 balance;\n        bool exists;\n    }\n\n    mapping(address => Balance) balance;\n    mapping(address => Balance) invalidBalance;\n\n    address[] addresses;\n\n    constructor (\n        uint256 _total,\n        address _owner,\n        string _benchmark\n    ) public {\n        require(_owner != 0x0, \"owner address is 0x0\");\n        require(_total > 0, \"total is illegal\");\n        require(bytes(_benchmark).length != 0, \"benchmark is illegal\");\n\n        total = _total;\n        issuer = msg.sender;\n        owner = _owner;\n        supportBenchmark = _benchmark;\n        balance[owner].balance = total;\n        balance[owner].exists = true;\n        addresses.push(owner);\n    }\n\n    function benchmark() public view returns (string){\n        return supportBenchmark;\n    }\n\n    function totalSupply() public view returns (uint256){\n        return total;\n    }\n\n    function invalidTotalSupply() public view returns (uint256){\n        return totalInvalid;\n    }\n\n    function balanceOf(address _addr) public view returns (uint256 balanceAmount){\n        balanceAmount = balance[_addr].balance;\n        return (balanceAmount);\n    }\n\n    function invalidBalanceOf(address _addr) public view returns (uint256 balanceAmount){\n        balanceAmount = invalidBalance[_addr].balance;\n        return (balanceAmount);\n    }\n\n    function transfer(address _to, uint256 _value) public payable returns (bool success){\n        return transferFrom(msg.sender, _to, _value);\n    }\n\n    function batchTransfer(address[] _addrs, uint256[] _values) public returns (bool success){\n        require(_addrs.length == _values.length);\n        require(_addrs.length > 0, \"address array length is 0\");\n        for (uint16 i = 0; i < _addrs.length; i++) {\n            if (_values[i] != 0) {\n                transferFrom(msg.sender, _addrs[i], _values[i]);\n            }\n        }\n        return true;\n    }\n\n    /**\n    *1:transfer USD to orderAddr(PFC contract addresss)\n    *2:call PFC buy function,add buy history\n    */\n    function buy(address orderAddr, uint256 amount, uint256 payAmount) public returns (bool success){\n        require(isContract(orderAddr), \"orderAddr is not contract\");\n        require(transferFrom(msg.sender, orderAddr, payAmount), \"transfer failed\");\n\n        OrderContract orderContract = OrderContract(orderAddr);\n        return orderContract.buy(msg.sender, amount, payAmount);\n    }\n\n    function cost(address addr, uint256 amount) public returns (bool){\n\n        require((total >= amount), \"amount gt total\");\n        require(total >= 0, \"totalInvalid failed\");\n        //买方的白条余额需要扣减\n        require(balance[msg.sender].balance >= amount, \"balance lt amount\");\n\n        total = total - amount;\n        balance[msg.sender].balance -= amount;\n        //给卖方增加白条余额\n        uint256 before = invalidBalance[addr].balance;\n        invalidBalance[addr].balance += amount;\n        totalInvalid = totalInvalid + amount;\n        require(totalInvalid >= 0, \"totalInvalid failed\");\n\n        return true;\n    }\n\n    function additionalIssue(uint256 num) public returns (bool){\n        require(num > 0, \"num is illegal\");\n        total += num;\n        balance[owner].balance += num;\n        require(total >= 0, \"The data of crossing the line\");\n        return true;\n    }\n\n    function withdrawal(address contractAddress, address to, uint256 amount) public returns (bool){\n        require(amount > 0, \"amount is 0\");\n        require(isContract(contractAddress), \"contractAddress is not contract\");\n        TokenContract tokenContract = TokenContract(contractAddress);\n        require(tokenContract.transfer(to, amount), \"withdrawal failed\");\n        return true;\n    }\n\n    function transferFrom(address _from, address _to, uint256 _value) internal returns (bool){\n        require(_to != 0x0, \"to address is 0x0\");\n        require(_value > 0, \"The value must be that is greater than zero.\");\n        require(balance[_from].balance >= _value, \"from address balance not enough\");\n        uint256 result = balance[_to].balance + _value;\n        require(result > 0, \"to address balance overflow\");\n        require(result > balance[_to].balance, \"to address balance overflow\");\n\n        uint previousBalance = balance[_from].balance + balance[_to].balance;\n        balance[_from].balance -= _value;\n        if (!balance[_to].exists) {\n            balance[_to].balance = _value;\n            balance[_to].exists = true;\n            addresses.push(_to);\n        }\n        else {\n            balance[_to].balance += _value;\n        }\n        emit Transfer(_from, _to, _value);\n        assert(balance[_from].balance + balance[_to].balance == previousBalance);\n        return true;\n    }\n\n\n}",
			"txId":"00000172bbe389b1a09d504cfeefe02da623679e",
			"language":"JAVA",
			"label":"lalala",
			"templateId":"t-code-cert",
			"version":"1.0",
			"actionIndex":0,
			"bdId":"bd_demo_5",
			"blockHeight":6,
			"bdCodeVersion":"4.0.0",
			"id":"certificate_demo_1",
			"status":"ENABLED"
		},
		"currentBlockHeight":655
	},
	"msg":"Success",
	"respCode":"000000"
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
| isContract    | `Boolean` |        | Y    | Y        | true/false       |


- 实例：

```json tab="响应实例"
{
	"data":{
		"isContract":true
	},
	"msg":"Success",
	"respCode":"000000"
} 
```

#### 区块链状态查询接口

- [ ] 开放
- 接口描述：检查该地址是否为合约地址  
- 请求地址：`GET`:`/v4/stacs/info`
- 请求参数：无

- 响应参数：

|    属性     | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :---------: | -------- | -------- | ---- | -------- | :---------------------------- |
| data    | `list<domainId>` | text      | Y    | Y        | 总数据         |


`domainId` 定义:

|    属性         | 类型     | 最大长度 | 必填 | 是否签名 | 说明                          |
| :-----------:    | -------- | -----| ---- | -------- | :---------------------------- |
| domainId       | `string` | 32    | Y    | Y        | domain域                     |
| nodeInfos      | `list<NodeInfoVO>` | 256   | N    | Y        | 节点集合           |

`NodeInfoVO`定义:

| 属性          | 类型          | 最大长度 | 必填 | 说明                           |
| ------------- | ------------- | -------- | ---- | ------------------------------ |
| nodeName         | `String`      |          | Y    | 当前节点名称
| domainId         | `String`      |          | Y    | 所属domain Id
| height           | `Long`        |          | Y    | 当前区块高度
| master           | `Boolean`     |          | Y    | 是否为master
| nodeState        | `String`      |          | Y    | 节点状态
| p2pHeight        | `String`      |          | Y    | P2P数据共识高度

- 实例：

```json tab="响应实例"
{
	"data":[
		{
			"nodeInfos":[
				{
					"nodeName":"STACS-node-D",
					"nodeState":"Running",
					"p2pHeight":655,
					"domainId":"STACS-Domain-D",
					"height":655,
					"master":false
				}
			],
			"domainId":"STACS-Domain-D"
		},
		{
			"nodeInfos":[
				{
					"nodeName":"STACS-node-C",
					"nodeState":"Running",
					"p2pHeight":655,
					"domainId":"STACS-Domain-C",
					"height":655,
					"master":false
				}
			],
			"domainId":"STACS-Domain-C"
		},
		{
			"nodeInfos":[
				{
					"nodeName":"STACS-node-B",
					"nodeState":"Running",
					"p2pHeight":655,
					"domainId":"STACS-Domain-A",
					"height":655,
					"master":true
				},
				{
					"nodeName":"STACS-node-A",
					"nodeState":"Running",
					"p2pHeight":655,
					"domainId":"STACS-Domain-A",
					"height":655,
					"master":false
				}
			],
			"domainId":"STACS-Domain-A"
		}
	],
	"msg":"Success",
	"respCode":"000000"
} 
```

#### 查询当前最大区块高度
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

#### 根据txId查询交易数据
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

#### 合约状态查询
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

#### 根据高度查询区块内所有交易数据
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
