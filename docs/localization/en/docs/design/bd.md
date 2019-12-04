## **BD(Business Define) 业务定义**
BD是定义一整套完整的包含所有业务相关功能的业务规范，它定义了初始化所需[Permission][1]、[policy][2]，以及每个业务功能的类型、方法签名、执行Permission以及执行所需的policy策略等约束。
可以有一个或多个DAPP协作执行整套业务。

具体定义如下：

```yaml
name: 名称
type: 业务类型（稳定币、证券、系统级合约），system-非合约型BD,不需要初始化
code: 业务代码
initPermission: 初始化所需Permission
initPolicy: 初始化所需Policy
version: 业务版本
functions: # 功能列表
  - name: 功能名称
    desc: 功能描述
    type: 功能执行类型（Contract,SystemAction） 
    methodSign: 功能执行方法签名
    exePermission: 执行所需Permission
    exePolicy: 执行所需policy 
```
!!! note
    BD定义发布时所需要的[Permission][1]、[Policy][2]需要在BD发布前注册定义, BD的发布为系统功能，采用异步全domain投票的policy。

- **业务类型/业务代码：** 业务类型与业务代码一一对应，业务代码是用于区分在链上发布的合约的业务属性。DAPP可以根据具体的业务代码，获取其关联业务的合约，以便执行具体的业务功能。
    
    * `system`: 系统BD类型，不需要初始化，所包含的功能列表全部为系统功能，不包含合约方法 
    * 自定义：合约类BD, 需要初始化，也即发布合约。可以包含系统功能，如kyc设置、打开快照等

- **功能执行类型：** 定义了该功能执行的方法类型。

    * `Contract`: 合约方法。表示<code>methodSign</code>为合约的方法签名。
    * `SystemAction`: 系统功能。可选择如下功能：
        - `BD_PUBLISH` : BD发布
        - `IDENTITY_SETTING` : Identity设置，设置Identity的一般属性
        - `IDENTITY_BD_MANAGE` : Identity BD 管理，冻结或解冻identity对BD的操作
        - `KYC_SETTING` : identity kyc 设置，设置identity的KYC属性
        - `PERMISSION_REGISTER` : Permission注册，注册系统permission
        - `AUTHORIZE_PERMISSION` : Permission授权，将permission授权给某一Identity
        - `CANCEL_PERMISSION` : Permission撤销授权，撤销Identity的permission授权
        - `REGISTER_POLICY` : Policy注册
        - `MODIFY_POLICY` : Policy修改
        - `SYSTEM_PROPERTY` : 系统属性配置，配置一些系统属性（key-value）
        - `SET_FEE_RULE` : 手续费费率配置
        - `SAVE_ATTESTATION` : 存证，保存存证数据
        - `BUILD_SNAPSHOT` : 打快照
        
Stacs智能合约通过BD定义的Permission和Policy约束规则，可以将合约的不同功能分配给不同permission和policy, 每个[Identity][3]可以授予不同的permission,
通过这种方式，合约的不同功能就会授权由特定permission的identity执行，从而达到金融业务分权执行合约功能的目的。

### 系统初始BD

系统在初始化时，会默认初始化系统BD（定义如下），系统BD中定义的所有系统功能，都采用异步domain投票策略且需要RS permission。在初始化时会将系统BD中的Policy注册为domain异步投票策略，系统BD中出现的permission也会注册。
也就是说系统初始化完成后，所有的投票策略都是异步domain投票。

- 公平性：通过上述初始化方式确保在系统初始后各个domain对系统管理能力都是公平的。所有系统功能在执行时都会异步参与投票，
特别时BD发布，Permission注册、授权、撤销授权，Policy注册更新，Identity KYC设置等执行权限相关的功能。
- 灵活性：后续可通过发布其他BD来指定某一系统功能采用其他投票策略或其他的permission。但该BD的发布需要所有domain异步授权投票，在保证灵活性的同时有确保了各domain的公平性。

```yaml
name: SystemBD
bdType: system
code: SystemBD
bdVersion: 1.0
functions:
  - name: IDENTITY_SETTING
    type: SystemAction
    desc: Identity设置
    methodSign: IDENTITY_SETTING
    execPermission: DEFAULT
    execPolicy: IDENTITY_SETTING
  - name: BD_PUBLISH
    type: SystemAction
    desc: BD发布
    methodSign: BD_PUBLISH
    execPermission: RS
    execPolicy: BD_PUBLISH
  - name: PERMISSION_REGISTER
    type: SystemAction
    desc: Permission注册
    methodSign: PERMISSION_REGISTER
    execPermission: RS
    execPolicy: PERMISSION_REGISTER
  - name: AUTHORIZE_PERMISSION
    type: SystemAction
    desc: Permission授权
    methodSign: AUTHORIZE_PERMISSION
    execPermission: RS
    execPolicy: AUTHORIZE_PERMISSION
  - name: CANCEL_PERMISSION
    type: SystemAction
    desc: Permission撤销授权
    methodSign: CANCEL_PERMISSION
    execPermission: RS
    execPolicy: CANCEL_PERMISSION
  - name: REGISTER_POLICY
    type: SystemAction
    desc: Policy注册
    methodSign: REGISTER_POLICY
    execPermission: RS
    execPolicy: REGISTER_POLICY
  - name: MODIFY_POLICY
    type: SystemAction
    desc: Policy修改
    methodSign: MODIFY_POLICY
    execPermission: RS
    execPolicy: MODIFY_POLICY
  - name: REGISTER_RS
    type: SystemAction
    desc: RS注册
    methodSign: REGISTER_RS
    execPermission: RS
    execPolicy: REGISTER_RS
  - name: CANCEL_RS
    type: SystemAction
    desc: RS撤销
    methodSign: RS_CANCEL
    execPermission: RS
    execPolicy: CANCEL_RS
  - name: CA_AUTH
    type: SystemAction
    desc: CA认证
    methodSign: CA_AUTH
    execPermission: RS
    execPolicy: CA_AUTH
  - name: CA_CANCEL
    type: SystemAction
    desc: CA撤销
    methodSign: CA_CANCEL
    execPermission: RS
    execPolicy: CA_CANCEL
  - name: CA_UPDATE
    type: SystemAction
    desc: CA更新
    methodSign: CA_UPDATE
    execPermission: RS
    execPolicy: CA_UPDATE
  - name: NODE_JOIN
    type: SystemAction
    desc: 节点加入
    methodSign: NODE_JOIN
    execPermission: RS
    execPolicy: NODE_JOIN
  - name: NODE_LEAVE
    type: SystemAction
    desc: 节点退出
    methodSign: NODE_LEAVE
    execPermission: RS
    execPolicy: NODE_LEAVE
  - name: SYSTEM_PROPERTY
    type: SystemAction
    desc: 系统属性配置
    methodSign: SYSTEM_PROPERTY
    execPermission: RS
    execPolicy: SYSTEM_PROPERTY
  - name: IDENTITY_BD_MANAGE
    type: SystemAction
    desc: Identity BD 管理（froze/unfroze）
    methodSign: IDENTITY_BD_MANAGE
    execPermission: RS
    execPolicy: IDENTITY_BD_MANAGE
  - name: KYC_SETTING
    type: SystemAction
    desc: identity kyc 设置
    methodSign: KYC_SETTING
    execPermission: RS
    execPolicy: KYC_SETTING
  - name: SET_FEE_CONFIG
    type: SystemAction
    desc: 手续费设置：合约地址 & 收取地址
    methodSign: SET_FEE_CONFIG
    execPermission: RS
    execPolicy: SET_FEE_CONFIG
  - name: SET_FEE_RULE
    type: SystemAction
    desc: 手续费费率配置
    methodSign: SET_FEE_RULE
    execPermission: RS
    execPolicy: SET_FEE_RULE
  - name: SAVE_ATTESTATION
    type: SystemAction
    desc: 保存存证
    methodSign: SAVE_ATTESTATION
    execPermission: RS
    execPolicy: SAVE_ATTESTATION
  - name: BUILD_SNAPSHOT
    type: SystemAction
    desc: 打快照
    methodSign: BUILD_SNAPSHOT
    execPermission: RS
    execPolicy: BUILD_SNAPSHOT
```

[1]: permission.md
[2]: policy.md
[3]: identity.md
