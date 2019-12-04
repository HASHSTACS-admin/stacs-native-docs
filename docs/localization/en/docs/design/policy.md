## Policy
+ 无论是主流`POS` 、`POW`、`BFPT` 等投票共识策略是不能满足现实多机构或公司业务，多公司参与策略都是基于股权策略，他们投票的权重并不`平等` 大多都按各自占比股权来划分投票权重，为此我们`Policy`  由此诞生，它是可以帮我们配置除灵活的投票策略，`Policy`提供多样化的投票策略配置，使区块链投票规则更加满足更多元化业务场景。

  
## 投票规则

+ 同步投票（SYNC）:`Policy`指定投票规则`votePattern`为同步投票，在`RS`收到交易时会收集投票，如果投票满足且通过交易流程才会继续执行，如果投票规则是同步且收集投票当满足规则交易会继续执行，
+ 异步投票（ASYNC）：如果是异步投票规则，当RS接收到交易时，交易状态会更新为需要投票(NEED_VOTE);
## Policy参数详情
+ Policy支持自定义，如`DomainA`，`DomainB`，`DomainC`三个领域组成的一个区块网络，`DomainA`是主要参与者，所以必须指定A必须对该交易的执行进行投票.
+ 参数释意
  
    .policyId=ISSUE
    
    .policyName=issue name
    
    .votePattern=SYNC  表示同步投票方式
    
    .callbackType=ALL   表示回调给所有RS
    
    .decisionType=ASSIGN_NUM  表示决议规则为自定义的
    
    .domainIds=[DomainA,DomainB,DomainC] 表示参与者集合，当前案例中是已知的三个`Domain`,`Policy`中所指定的投票单元为一个`Domain`,
    只需要该`Domain`下任意一个`RS`投票成功就算该`Domain`投票成功
    
    .verifyNum=2 表示在参与集合中的数量至少2个投赞成票
    
    .mustDomainIds=[DomainA]   表示所有投票中必须有`DomainA`投赞成票
    
    .expression=n/2 + 1   n=当前集群中的`Domain`数量，该表达式当前结果为2，即需要至少2个`Domain`投赞成票
    
    .requireAuthIds=[DomainB] 表示修改该`Policy`时除了上述投票规则外，还需要`DomainB`给投赞成票才能修改该`Policy`