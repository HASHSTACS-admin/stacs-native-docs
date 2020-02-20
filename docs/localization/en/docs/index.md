# 欢迎来到 STACS-NATIVE
## Stacs-Native是什么？
Stacs-Native是一个开源的拜占庭容错的分布式区块链系统。为用户提供可靠的信任基础，为协调开展业务提供高效一致的共识流程。与此同时Stacs-Native区别去其它主流区块链系统，专为金融领域赋予了一些特殊能力。
例如通过[BD][3]的定义来约束智能合约执行，从而实现在金融场景下智能合约的分权执行；智能合约中进行KYC认证；私密交易等。

其主要功能特点如下：

- **Domain：** [Domain][1]是Stacs-Native中节点的维护主体，一个Domain可以拥有一个或多个节点。Stacs-Native中大多数的投票都是Domain为单位，采用一票通过的设计原则，即在Domain中，只要有一个节点背书投票，则认为Domain背书投票。
采用这种设计一方面可以避免一个Domain拥有过多节点时，其投票比重较大，破获去中心化信任基础；另一方面可以解决外部请求的单节点故障问题。
- **交易及Policy：** Stacs-Native的交易必须与唯一的Policy相对应，Policy定义了该交易的背书投票规则，在交易执行前会检查该交易是否被定义的规则所允许，具体规则参见[Policy][2].
- **账务模型：** Stacs-Native支持UTXO和余额模型两种账务模型。
    1. UTXO：UTXO是Unspent Transaction Output 的缩写，UTXO交易是由一笔或多笔“交易输入”，产生一笔或多笔“交易输出”，所产生的“交易输出”又称“未花费的交易输出”，也即UTXO。任何一笔“交易输入”都是前序某个交易当中产生的“未花费交易输出”，就像接链条一样，前后互相链接，前一个链条块的输出就是后一个链条块的输入。
    2. 余额模型：余额模型采用复式记账法中的借贷记账法，即以“借”、“贷”为记账符号的一种复式记账法。
- **BD(Business Define) & DAPP：** [BD][3]是定义一整套完整的包含所有业务相关功能的业务规范和业务约束，它定义了初始化和每个业务功能所需要的[Permission][5]、[policy][2]等约束，可以有一个或多个[DAPP][4]协作执行整套业务。
- **[智能合约][6]：** Stacs-Native采用solidity语言作为智能合约的程序代码，在solidity的基础上增强预编译合约，以提高系统的可靠性。
- **[私有数据][7]: ** Stacs-Native特别为金融业务提供了私有数据交易，用于不同机构间进行私密交易。在进行私密交易前会先约定交易方，并通过密钥交换技术生成密钥，交易发起方发给交易密文给确认方，确认方解密并验证，同时附上验证结果；
发起方在确认方确认无误后发起交易，该交易为私密交易，交易内容为密文同时会上链，以便后续审计与追溯。
- **插拔式共识协议：** 支持BFT（Byzantine Fault Tolerance）和CFT（Crash Fault Tolerance）。BFT协议使用[BFT-SMaRt](https://github.com/bft-smart/library)；CFT协议支持[atomix](https://github.com/atomix/atomix)和[sofa-jraft](https://github.com/sofastack/sofa-jraft)的接入。
- **业务master：** [业务master][8]主要负责交易的排序打包，保证各个节点交易线性一致执行。采用从1递增的**任期**序号，标识当前唯一master，用于选举及保证各节点收到交易的一致性。在初始启动或是一段时间内没有收到master心跳时，任一节点都会向其他节点发起master选举，当获得2f+1个节点一致认可后，节点将成为下一任业务master。
- **P2P结果确认：** Stacs-Native在交易执行完成后，通过P2P确认，2f+1个节点的执行结果一致时，才会回调上层业务。

如果你想更加详细的了解系统的设计？ 可以参考[系统架构设计][9]

如果你想了解Stacs-Native是如何运作的？可以参考[快速开始指南][10]。

如果你想了解如何开发DAPP? 可以参考[DAPP开发指南][11]

[1]: design/domain&RS.md
[2]: design/policy.md
[3]: design/bd.md
[4]: design/dapp.md
[5]: design/permission.md
[6]: smart-contract.md
[7]: smart-contract.md
[8]: design/master.md
[9]: design/arch-design.md
[10]: GettingStarted.md
[11]: dapp-dev.md
