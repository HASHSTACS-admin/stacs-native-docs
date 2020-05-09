### **概述**

BD（Business Define）是定义一整套完整的包含所有业务相关功能的业务规范，它定义了初始化所需[Permission][1]、[Policy][2]，以及每个业务功能的类型、方法签名、执行Permission以及执行所需的Policy策略等约束。
可以有一个或多个DApp协作执行整套业务。

具体定义如下：

```yaml
id: id
label: 名称
bdVersion: 业务版本
functions: # 功能列表
  - name: 功能名称
    desc: 功能描述
    type: 功能执行类型（Contract,SystemAction） 
    methodSign: 功能执行方法签名
    exePermission: 执行所需Permission
    exePolicy: 执行所需policy 
```
!!! note
    BD定义发布时所需要的[Permission][1]、[Policy][2]需要在BD发布前注册定义, BD的发布为系统功能，采用异步全Domain投票的Policy。
  
- **功能执行类型：** 定义了该功能执行的方法类型。

    * `Contract`: 合约方法。表示<code>methodSign</code>为合约的方法签名。
    * `SystemAction`: 系统功能。可选择如下功能：
        - `ADD_BD` : BD发布
        - `SET_IDENTITY` : Identity设置
        - `FREEZE_IDENTITY` : Identity冻结
        - `UNFREEZE_IDENTITY` : Identity解冻
        - `SET_PERMISSION` : Permission设置
        - `PERMISSION_ADD_ADDR` : 添加Permission的address
        - `PERMISSION_REMOVE_ADDR` : 删除Permission的address
        - `SET_POLICY` : 设置Policy
        - `ADD_RS` : RS注册
        - `REMOVE_RS` : RS撤销
        - `INIT_CA` : CA初始化
        - `ADD_CA` : CA认证
        - `UPDATE_CA` : CA更新
        - `REMOVE_CA` : CA撤销
        - `ADD_NODE` : 节点加入
        - `REMOVE_NODE` : 退出节点
        - `ADD_CONTRACT` : 合约创建
        - `EXECUTE_CONTRACT` : 合约执行
        - `SET_ATTESTATION` : 存证
        - `ADD_SNAPSHOT` : 快照交易
        
### **系统初始BD**

系统在初始化时，会默认初始化系统BD（定义如下），系统BD中定义的所有系统功能，都采用异步Domain投票策略且需要RS Permission。在初始化时会将系统BD中的Policy注册为Domain异步投票策略，系统BD中出现的Permission也会注册。
也就是说系统初始化完成后，所有的投票策略都是异步Domain投票。

- 公平性：通过上述初始化方式确保在系统初始后各个Domain对系统管理能力都是公平的。所有系统功能在执行时都会异步参与投票，特别是BD发布，Permission注册、授权、撤销授权，Policy注册更新，Identity KYC设置等执行权限相关的功能。
- 灵活性：后续可通过发布其他BD来指定某一系统功能采用其他投票策略或其他的Permission。但该BD的发布需要所有Domain异步授权投票，在保证灵活性的同时有确保了各Domain的公平性。

```yaml
label: SystemBD
id: SystemBD
bdVersion: 1.0
functions:
  - name: ADD_BD
    type: SystemAction
    desc: BD Specification
    methodSign: ADD_BD
    execPermission: DEFAULT
    execPolicy: SYNC_ONE_VOTE_DEFAULT
  - name: SET_PERMISSION
    type: SystemAction
    desc: Permission Register
    methodSign: SET_PERMISSION
    execPermission: DEFAULT
    execPolicy: SYNC_ONE_VOTE_DEFAULT
  - name: SET_POLICY
    type: SystemAction
    desc: Register Policy
    methodSign: SET_POLICY
    execPermission: DEFAULT
    execPolicy: SYNC_ONE_VOTE_DEFAULT
  - name: ADD_RS
    type: SystemAction
    desc: Register Rs
    methodSign: ADD_RS
    execPermission: DEFAULT
    execPolicy: ADD_RS
  - name: REMOVE_RS
    type: SystemAction
    desc: Cancel Rs
    methodSign: REMOVE_RS
    execPermission: RS
    execPolicy: REMOVE_RS
  - name: ADD_CA
    type: SystemAction
    desc: CA Auth
    methodSign: ADD_CA
    execPermission: DEFAULT
    execPolicy: ADD_CA
  - name: REMOVE_CA
    type: SystemAction
    desc: CA Cancel
    methodSign: REMOVE_CA
    execPermission: RS
    execPolicy: REMOVE_CA
  - name: UPDATE_CA
    type: SystemAction
    desc: CA Update
    methodSign: UPDATE_CA
    execPermission: RS
    execPolicy: UPDATE_CA
  - name: ADD_NODE
    type: SystemAction
    desc: Node Join
    methodSign: ADD_NODE
    execPermission: DEFAULT
    execPolicy: ADD_NODE
  - name: REMOVE_NODE
    type: SystemAction
    desc: Node Leave
    methodSign: REMOVE_NODE
    execPermission: RS
    execPolicy: REMOVE_NODE
  - name: ADD_SNAPSHOT
    type: SystemAction
    desc: Build Snapshot
    methodSign: ADD_SNAPSHOT
    execPermission: DEFAULT
    execPolicy: SYNC_ONE_VOTE_DEFAULT
```

[1]: permission.md
[2]: policy.md
[3]: identity.md
