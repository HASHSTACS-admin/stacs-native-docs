## 交易类接口
#### BD发布
     
#### Policy注册
API接口：
io.stacs.nav.drs.api.ISubmitterService.registerPolicy(RegisterPolicyVO vo)
RegisterPolicyVO属性描述:

| 属性            | 类型            | 最大长度 | 必填 | 说明                           |
| -------------  | -------------   | -------- | ---- | -------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                                     
| subbmiter    | `String`        | 40       | Y    | 用户地址                                    
| feeCurrency    | `String`        | 32       | N    | 手续费币种                                   
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费                              
| sign           | `String`        | 64       | Y    | 签名                                        
| bdCode         | `String`        |          | Y    | BD code                                
| policyId       | `String`        | 32       | Y    | 注册的policyId                               
| policyName     | `String`        | 64       | Y    | ploicy name                                 
| votePattern    | `String`        |          | Y    | 投票模式，1. SYNC 2. ASYNC                   
| callbackType   | `String`        |          | Y    | 回调类型，1. ALL 2. SELF                     
| decisionType   | `String`        |          | Y    | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM      
| domainIds      | `List<String>`  |          | Y    | 参与投票的domainId列表                        
| requireAuthIds | `List<String>`  |          | Y    | 需要通过该集合对应的rs授权才能修改当前policy     
| assigMeta      | `AssigMeta`     |          | N    | 指定数量类型时的规则信息                       
#### AssigMeta类型
| 属性          | 类型          | 最大长度 | 必填 | 说明                           |
| ------------- | ------------- | -------- | ---- | ------------------------------ |
| verifyNum     | `int`         |          | N    | 需要投票的domain数量             
| mustDomainIds | `List<String` |          | N    | 必须参与投票的domainId列表        
| expression    | `String`      |          | N    | 投票规则表达式，example: n/2+1   


#### Policy更新
API接口：
io.stacs.nav.drs.api.ISubmitterService.modifyPolicy(ModifyPolicyVO vo)
ModifyPolicyVO 属性描述:

| 属性            | 类型            | 最大长度 | 必填 | 说明                           |
| -------------  | -------------   | -------- | ---- | -------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                             
| subbmiter    | `String`        | 40       | Y    | 用户地址                            
| feeCurrency    | `String`        | 32       | N    | 手续费币种                           
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费                      
| sign           | `String`        | 64       | Y    | 签名                                
| bdCode         | `String`        |          | Y    | BD code                            
| policyId       | `String`        | 32       | Y    | 注册的policyId                       
| policyName     | `String`        | 64       | Y    | ploicy name                         
| votePattern    | `String`        |          | Y    | 投票模式，1. SYNC 2. ASYNC           
| callbackType   | `String`        |          | Y    | 回调类型，1. ALL 2. SELF                
| decisionType   | `String`        |          | Y    | 1. FULL_VOTE 2. ONE_VOTE 3. ASSIGN_NUM 
| domainIds      | `List<String>`  |          | Y    | 参与投票的domainId列表                   
| requireAuthIds | `List<String>`  |          | Y    | 需要通过该集合对应的rs授权才能修改当前policy 
| assigMeta      | `AssigMeta`     |          | N    | 指定数量类型时的规则信息                    
#### AssigMeta类型
| 属性          | 类型          | 最大长度 | 必填 | 说明                           |
| ------------- | ------------- | -------- | ---- | ------------------------------ |
| verifyNum     | `int`         |          | N    | 需要投票的domain数量            
| mustDomainIds | `List<String>`|          | N    | 必须参与投票的domainId列表       
| expression    | `String`      |          | N    | 投票规则表达式，example: n/2+1   


#### Identity创建
API接口：
io.stacs.nav.drs.api.ISubmitterService.identitySetting(IdentitySettingVO vo)
IdentitySettingVO 属性描述:

|     属性     | 类型     | 最大长度 | 必填 | 说明                                              |
| :----------: | -------- | -------- | ---- | ------------------------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                           
| subbmiter    | `String`        | 40       | Y    | 用户地址                          
| feeCurrency    | `String`        | 32       | N    | 手续费币种                         
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费
| sign           | `String`        | 64       | Y    | 签名                              
| bdCode         | `String`        |          | Y    | BD code                    
| property       | `String`        | 1024     | N    | 用户自定义属性，Json类型                          
| address        | `String`        | 40       | Y    | 新增identity地址                                 


#### Identity修改
API接口：
io.stacs.nav.drs.api.ISubmitterService.identityManager(IdentityBDManageVO vo)
IdentityBDManageVO 属性描述:

|     属性     | 类型     | 最大长度 | 必填 | 说明                                              |
| :----------: | -------- | -------- | ---- | ------------------------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                             
| subbmiter    | `String`        | 40       | Y    | 用户地址                            
| feeCurrency    | `String`        | 32       | N    | 手续费币种                           
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费
| sign           | `String`        | 64       | Y    | 签名                                
| bdCode         | `String`        |          | Y    | BD code                      
| property       | `String`        | 1024     | N    | 用户自定义属性，Json类型                         
| address        | `String`        | 40       | Y    | 要修改的identity地址                               


#### Permission注册
API接口：
io.stacs.nav.drs.api.ISubmitterService.registerPermission(RegisterPermissionVO vo)
RegisterPermissionVO 属性描述:

|      属性       | 类型       | 最大长度 | 必填 | 说明                               |
| :-------------: | ---------- | -------- | ---- | ---------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                         
| subbmiter    | `String`        | 40       | Y    | 用户地址                        
| feeCurrency    | `String`        | 32       | N    | 手续费币种                       
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费
| sign           | `String`        | 64       | Y    | 签名                            
| bdCode         | `String`        |          | Y    | BD code                  
| permissionNames | `String[]`     |          | Y    | PermissionName数组 

#### 用户Permission授权
API接口：
io.stacs.nav.drs.api.ISubmitterService.authPermission(AuthPermissionVO vo)
AuthPermissionVO 属性描述:

|      属性       | 类型       | 最大长度 | 必填 | 说明                               |
| :-------------: | ---------- | -------- | ---- | ---------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                         
| subbmiter    | `String`        | 40       | Y    | 用户地址                        
| feeCurrency    | `String`        | 32       | N    | 手续费币种                       
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费
| sign           | `String`        | 64       | Y    | 签名                            
| bdCode         | `String`        |          | Y    | BD code                  
| identityAddress | `String`       | 40       | Y    | 要授权的identity地址              
| permissionNames | `String[]`     |          | Y    | 给Identity授权的PermissionName数组

 

#### 用户Permission撤销
API接口：
io.stacs.nav.drs.api.ISubmitterService.cancelPermission(CancelPermissionVO vo)
CancelPermissionVO 属性描述:

|      属性       | 类型       | 最大长度 | 必填 | 说明                               |
| :-------------: | ---------- | -------- | ---- | ---------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                           
| subbmiter    | `String`        | 40       | Y    | 用户地址                          
| feeCurrency    | `String`        | 32       | N    | 手续费币种                         
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费
| sign           | `String`        | 64       | Y    | 签名                              
| bdCode         | `String`        |          | Y    | BD code                    
| identityAddress | `String`       | 40       | Y    | 要撤销授权的identity地址            
| permissionNames | `String[]`     |          | Y    | 给Identity授权的PermissionName数组 

#### KYC注册
API接口：
io.stacs.nav.drs.api.ISubmitterService.settingKYC(KYCSettingVO vo)
KYCSettingVO 属性描述:

|      属性       | 类型       | 最大长度 | 必填 | 说明                               |
| :-------------: | ---------- | -------- | ---- | ---------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                           
| subbmiter    | `String`        | 40       | Y    | 用户地址                          
| feeCurrency    | `String`        | 32       | N    | 手续费币种                         
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费
| sign           | `String`        | 64       | Y    | 签名                              
| bdCode         | `String`        |          | Y    | BD code                    
| identityAddress | `String`       | 40       | Y    | 目标identity地址    
| KYC             | `String`       | 1024     | Y    | KYC属性                      


#### 合约发布
API接口：
io.stacs.nav.drs.api.ISubmitterService.contractPublish(ContractCreateVO vo) 
ContractCreateVO 属性描述:
|      属性       | 类型       | 最大长度 | 必填 | 说明                               |
| :-------------: | ---------- | -------- | ---- | ---------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                           
| subbmiter    | `String`        | 40       | Y    | 用户地址                          
| feeCurrency    | `String`        | 32       | N    | 手续费币种                         
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费
| sign           | `String`        | 64       | Y    | 签名                              
| bdCode         | `String`        |          | Y    | BD code                    
| methodName     | `String`        |          | Y    | 合约构造方法    
| args           | `Object[]`      |          | Y    | 合约参数    
| code           | `String `       |          | Y    | 合约代码   
| bizData        | `JsonObject`    |          | N    | 业务数据json    


#### 合约执行
API接口：
io.stacs.nav.drs.api.ISubmitterService.contractInvoke(ContractInvokeVO vo) 
ContractInvokeVO 属性描述:

|      属性       | 类型       | 最大长度 | 必填 | 说明                               |
| :-------------: | ---------- | -------- | ---- | ---------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                           
| subbmiter    | `String`        | 40       | Y    | 用户地址                          
| feeCurrency    | `String`        | 32       | N    | 手续费币种                         
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费
| sign           | `String`        | 64       | Y    | 签名                              
| bdCode         | `String`        |          | Y    | BD code                    
| methodName     | `String`        |          | Y    | 合约方法    
| args           | `Object[]`      |          | Y    | 合约参数    
| bizData        | `JsonObject`    |          | N    | 业务数据json    

#### 存证交易
API接口：
io.stacs.nav.drs.api.ISubmitterService.saveAttestation(SaveAttestationVO vo) 
SaveAttestationVO 属性描述:

|      属性       | 类型       | 最大长度 | 必填 | 说明                               |
| :-------------: | ---------- | -------- | ---- | ---------------------------------- |
| txId           | `String`        | 64       | Y    | 交易ID                           
| subbmiter    | `String`        | 40       | Y    | 用户地址                          
| feeCurrency    | `String`        | 32       | N    | 手续费币种                         
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费
| sign           | `String`        | 64       | Y    | 签名                              
| bdCode         | `String`        |          | Y    | BD code                    
| attestation    | `String`        | 4096     | Y    | 存证内容 

#### 快照交易
API接口：
io.stacs.nav.drs.api.ISubmitterService.buildSnapshot(BuildSnapshotVO vo) 
BuildSnapshotVO 属性描述:

|      属性       | 类型       | 最大长度 | 必填 | 说明                               |
| :-------------: | ---------- | -------- | ---- | ---------------------------------- | 
| txId           | `String`        | 64       | Y    | 交易ID                           
| subbmiter    | `String`        | 40       | Y    | 用户地址                          
| feeCurrency    | `String`        | 32       | N    | 手续费币种                         
| feeMaxAmount   | `String`        | 18       | N    | 最大允许的手续费
| sign           | `String`        | 64       | Y    | 签名                              


## 查询类接口
#### BD查询
API接口：
io.stacs.nav.drs.api.IQueryService.queryBDByCode(String bdCode);
请求参数：
|      属性       | 类型       | 最大长度 | 必填 | 说明                               |
| :-------------: | ---------- | -------- | ---- | ---------------------------------- | 
| bdCode           | `String`        | 64       | Y    | bdCode                          
  
返回值：io.stacs.nav.drs.api.model.bd.BusinessDefine 
