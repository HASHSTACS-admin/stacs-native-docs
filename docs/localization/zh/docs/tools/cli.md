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