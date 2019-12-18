# **常用命令** 

## consensus

用于节点处理共识协议：加入共识协议，退出共识协议等

<pre><code>
usage: consensus [-h | --help] COMMAND [ARGS] <br>
The most commonly used consensus commands are:
   leaveConsensus   leave a consensus cluster
   joinConsensus    join a consensus cluster
<br></code></pre>

## **term**

用于管理集群选主
<pre><code>
usage: term [-h | --help] COMMAND [ARGS] <br>
The most commonly used term commands are:
   election         set election master
   info             show the terms of cluster
   startNewTerm     start new term
   endTerm          end the master term
<br></code></pre>

## **failover**
用于恢复故障节点
<pre><code>
usage: failover [-h | --help] COMMAND [ARGS] <br>
The most commonly used failover commands are:
   single           failover single block, which will get the block from other node, transfer to package, validating/persisting the package transaction and validate the result with received consensus validating/persisting block header
   selfCheck        check the current block of node
   autoSync         auto sync the batch blocks, get the blocks from other node and validate block by raft/b2p channel and execute it, this option will auto change the node state.
   batch            sync batch blocks, get the blocks from other node and validate block by raft/b2p channel and execute it
   genesis          sync the genesis block
<br></code></pre>

## **bizType**
用于管理业务类型
<pre><code>
usage: bizType [-h | --help] COMMAND [ARGS] <br>
The most commonly used bizType commands are:
   add              add biz type
   get              get biz type
   update           update biz type
<br></code></pre>   

## **ca**
用于管理CA
<pre><code>
usage: ca [-h | --help] COMMAND [ARGS] <br>
The most commonly used ca commands are:
   authCA           auth CA
   updateCA         update CA
   cancelCA         cancel CA
   acquireCA        query CA
<br></code></pre> 

## **cluster**
用于管理集群：加入共识，退出共识等
<pre><code>
usage: cluster [-h | --help] COMMAND [ARGS] <br>
The most commonly used cluster commands are:
   leaveConsensus   leave consensus layer
   joinRequest      join consensus request layer
   joinConsensus    join consensus layer
<br></code></pre> 

## **rocksdb**
用于对rocksdb进行增删改查
<pre><code>
usage: rocksdb [-h | --help] COMMAND [ARGS] <br>
The most commonly used rocksdb commands are:
   put              put the value
   count            count by
   clear            clear tables
   queryByPrefix    query by prefix and limit size
   showTables       show all table names
   queryByKey       query by key
   queryByCount     query by count and order
   clearAll         clear all tables allow ignored
<br></code></pre>

## **tx**
用于获取交易信息
<pre><code>
usage: tx [-h | --help] COMMAND [ARGS] <br>
The most commonly used tx commands are:
   info             get the tx info
<br></code></pre>

## **vote**
用于获取接收到的投票信息和处理投票
<pre><code>
usage: vote [-h | --help] COMMAND [ARGS] <br>
The most commonly used vote commands are:
   show             show INIT vote request by page
   receipt          receipt for vote
<br></code></pre>

## **block**
用于查看某个指定节点上的区块信息
<pre><code>
usage: block [-h | --help] COMMAND [ARGS] <br>
The most commonly used block commands are:
   info             get the block info
   height           get the current block height
<br></code></pre>

## **node**
用于查看和管理节点信息
<pre>
<code>
usage: node [-h | --help] COMMAND [ARGS] <br>
The most commonly used node commands are:
   startConsensus   start consensus layer
   refreshView      refresh the cluster view
   info             show the node info
   height           show the current height of node
   log              change log level, log [logName] [OFF|ERROR|WARN|INFO|DEBUG|TRACE|ALL]
   state            show the current state of node
   views            show the views of cluster
   changeState      change the state of node
<br>
</code>
</pre>

## **property**
用于查看和更新系统属性
<pre><code>
usage: property [-h | --help] COMMAND [ARGS] <br>
The most commonly used property commands are:
   get              get system property
   set              set system property
<br></code></pre>