# **常用命令** 

## **term**

用于管理集群选主
<pre><code>
usage: term [-h | --help] COMMAND [ARGS] <br>
The most commonly used term commands are:
   election         set election master(设置节点参与选举)
   info             show the terms of cluster(集群信息)
   startNewTerm     start new term(开启一个新的选举周期)
   endTerm          end the master term(结束周期)
<br></code></pre>

## **failover**
用于恢复故障节点
<pre><code>
usage: failover [-h | --help] COMMAND [ARGS] <br>
The most commonly used failover commands are:
   single           failover single block, which will get the block from other node, transfer to package, validating/persisting the package transaction and validate the result with received consensus validating/persisting block header(同步单个区块)
   selfCheck        check the current block of node(检查当前节点的区块)
   autoSync         auto sync the batch blocks, get the blocks from other node and validate block by raft/b2p channel and execute it, this option will auto change the node state.(自动同步批处理块，从其他节点获取块，通过raft/b2p通道验证块并执行，此选项将自动更改节点状态)
   batch            sync batch blocks, get the blocks from other node and validate block by raft/b2p channel and execute it(同步批处理块，从其他节点获取块，通过raft/b2p通道验证块并执行它)
   genesis          sync the genesis block(同步创世块)
   reset            sync reset blocks
<br></code></pre>

## **failover reset 快速恢复步骤**
<pre><code>
    #第一步 状态切换为SelfChecking
    node  changeState Running SelfChecking
    #第二步 状态切换为ArtificialSync
    node  changeState SelfChecking ArtificialSync 
    #重置快速恢复的起始高度 包含startHeight 
    failover reset {startHeight}
    #开始同步 指定起始高度和size
    failover batch {startHeight} {size}
    #状态切换为Running
    node  changeState  ArtificialSync Running
</code></pre>


## **ca**
用于管理CA
<pre><code>
usage: ca [-h | --help] COMMAND [ARGS] <br>
The most commonly used ca commands are:
   listCA           list CA (显示所有CA)
<br></code></pre> 

## **cluster**
用于管理集群：加入共识，退出共识等
<pre><code>
usage: cluster [-h | --help] COMMAND [ARGS] <br>
The most commonly used cluster commands are:
   joinRequest      join consensus request layer(节点加入)
   leaveRequest   leave consensus layer(节点离开)
<br></code></pre> 

## **noderocksdb**
用于对noderocksdb进行增删改查
<pre><code>
usage: rocksdb [-h | --help] COMMAND [ARGS] <br>
The most commonly used rocksdb commands are:
   put              put the value(设置value )
   showTables       show all table names(显示所有的表)
   queryByPrefix    query by prefix and limit size(按key前缀查询)
   queryByKey       query by tableName and key  (查单一数据)
   queryByCount     query by tableName、count and order(查分页数据)
<br></code></pre>

## **rocksdb**
用于对rocksdb进行增删改查
<pre><code>
usage: rocksdb [-h | --help] COMMAND [ARGS] <br>
The most commonly used rocksdb commands are:
   put              put the value(设置value)
   count            count by(统计数据)
   clear            clear tables(清除表)
   showTables       show all table names(显示所有的表)
   queryByKey       query by key and height (查单一数据 height 可选值 )
   queryByCount     query by count、order and height(查分页数据 height 可选值 )
   clearAll         clear all tables allow ignored(清除所有表，慎用)
<br></code></pre>

## **tx**
用于获取交易信息
<pre><code>
usage: tx [-h | --help] COMMAND [ARGS] <br>
The most commonly used tx commands are:
   info             get the tx info(查看交易详情)
   verify           quick verify ledger data(账本数据快速校验,定位出数据不一致的最小区块高度的具体txId)
<br></code></pre>

## **vote**
用于获取接收到的投票信息和处理投票
<pre><code>
usage: vote [-h | --help] COMMAND [ARGS] <br>
The most commonly used vote commands are:
   show             show INIT vote request by page（显示投票列表）
   receipt          receipt for vote(投票操作)
<br></code></pre>

## **block**
用于查看某个指定节点上的区块信息
<pre><code>
usage: block [-h | --help] COMMAND [ARGS] <br>
The most commonly used block commands are:
   info             get the block info(获取当前最大高度区块信息)
   height           get the current block height(获取当前节点高度)
<br></code></pre>

## **node**
用于查看和管理节点信息
<pre>
<code>
usage: node [-h | --help] COMMAND [ARGS] <br>
The most commonly used node commands are:
   startConsensus   start consensus layer(节点加入共识)
   refreshView      refresh the cluster view(刷新集群)
   info             show the node info(节点信息)
   height           show the current height of node(当前节点高度)
   log              change log level, log [logName] [OFF|ERROR|WARN|INFO|DEBUG|TRACE|ALL](改变日志级别)
   state            show the current state of node(节点状态)
   views            show the views of cluster(集群views)
   changeState      change the state of node(改变节点状态)
<br>
</code>
</pre>


## **RS**
用于查看和管理RS节点信息
<pre>
<code>
usage: rs [-h | --help] COMMAND [ARGS] <br>
The most commonly used rs commands are:
   add         add current node to rs node(注册当前普通节点为RS节点)
   remove      remove current rs node(注销当前RS节点围为普通节点)
<br>
</code>
</pre>

## **merchant**
用于管理商户信息
<pre>
<code>
usage: node [-h | --help] COMMAND [ARGS] <br>
The most commonly used node commands are:
   add         add merchant info(添加商户信息)
   modify      modify merchant info(修改商户信息)
   opt         start and stop merchants(对商户进行启停操作)
   query       query all merchant information under this domain(查询该domain下所有商户信息)
<br>
</code>
</pre>

## **domain**
用于管理domain
<pre>
<code>
usage: node [-h | --help] COMMAND [ARGS] <br>
The most commonly used node commands are:
   set         add or update domain info
   remove      remove domain info,note:also remove node of domain`s
   query       query all domain info
<br>
</code>
</pre>

## 节点加入/退出说明
### 前置步骤
1. 原始集群创世块中需要配置具体的运营者信息，必须为现有domain中的一个或多个
```
 management:
        domains: STACS-A    #运营者domainId,支持多个，逗号连接
        voteType: ONE_VOTE  #投票方式，ONE_VOTE-一票通过 FULL_VOTE-全票通过
          
```
2. 在运营者节点的CLI命令中执行新加入节点所属Domain信息的配置
   
``` 
   
   domain set ${domainId} ${maxNodeSize} ${descrition} 
   domain query
   
```
3. domain 配置命令提交后，需要domain运营者来投票

### 新节点配置：
1. stacs.native.newNode = true   #标记为新节点
2. network.peers = native-a:9001 #现有集群种子节点ip+port 
3. stacs.native.nodeName = Fort-Capital-Slave #节点名称
4. stacs.native.domainId = FORT-CAPITAL       #domainId,需要与运营者分配的domainId一致

### 节点加入：

  * 自动加入：
   
     新节点启动后会自动发起请求到现有集群，需要运营者domain来投票确定是否允许该节点的加入，如果投票通过，该节点就会加入集群中，无需在做操作。 
   
     注：
    
    1.运营者投票通过后，新节点需等待5分钟左右方可可用，检测方式：ssh -p2000 user@localhost 密码:pwd ,执行：node state -a 命令，若能看到其他节点及本节点信息即表示加入成功。
     
     2.自动加入仅限节点第一次启动时，若第一次加入失败，则以后再加入需要手动发起
     
  * 手动加入：
     
     CLI中执行：cluster joinRequest 命令
     若该节点所属domain下还有其他节点，则需要其他任意节点投票，否则需要运营者投票

### 节点退出：
1.运营者主动移除domain(该domain下所有节点均会被退出)
运营者domain可以在CLI命令行中执行：domain remove ${domainId} 并且投票。被执行的domain下所有节点就会退出并Offline。

2.某节点主动退出
节点CLI中执行：cluster leaveRequest 若该节点所属domain下还有其他节点，则需要其他任意节点投票，否则需要运营者投票
