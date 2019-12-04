## Policy规则
+ 我们为不同的交易制定了不同的执行规则policy，policy的粒度可以支持同步/异步投票模式，可以提升
某个参与者的权重，使投票规则更加符号满足现实业务场景。
## 投票规则
+ policy指定的投票规则，交易真正执行前会验证交易的policy，且会收集投票，如果投票满足且通过交易
流程才会继续执行，如果投票规则是同步且收集投票满足规则交易会继续执行，
如果是异步投票规则吗，交易状态会更新为需要投票(NEED_VOTE);
## Policy注册
+ Policy支持自定义，如DomainA，DomainB，DomainC三个领域组成的一个区块网络，DomainA是
主要参与者，所以必须指定A必须对该交易的执行进行投票.
+ 参数
    + policyId=ISSUE
    + policyName=issue name
    + votePattern=SYNC  表示同步投票方式
    + callbackType=ALL   表示回调给所有RS
    + decisionType=ASSIGN_NUM  表示决议规则为自定义的
    + domainIds=[DomainA,DomainB,DomainC] 表示参与者集合，当前案例中是已知的三个Domain,:policy中所指定的投票单元为一个Domain,
    只需要该Domain下任意一个RS投票成功就算该Domain投票成功
    + verifyNum=2 表示在参与集合中的数量至少2个投赞成票
    + mustDomainIds=[DomainA]   表示所有投票中必须有DomainA投赞成票
    + expression=n/2 + 1   n=当前集群中的domain数量，该表达式当前结果为2，即需要至少2个Domain投赞成票
    + requireAuthIds=[DomainB] 表示修改该policy时除了上述投票规则外，还需要DomainB给投赞成票才能修改该policy
## Policy更新
当参与者们想对策略做出变更时，我们可以使用policy更新来改变策略，我们在注册的时候指定了requireAuthIds属性为DomainB，那么
更新policy必须要得到DomainB的投票，更新才会被认可上链。
## Policy删除
