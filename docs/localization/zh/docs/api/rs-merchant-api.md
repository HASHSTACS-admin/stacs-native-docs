#商户配置相关接口文档

#### 添加商户信息
##### 接口地址：/domain/addMerchant
请求方式：POST
##### 请求参数（通过RequestBody形式）

| 属性            | 类型              | 最大长度 | 必填 | 说明                           |
| -------------  | -------------     | -------- | ---- | -------------------------------- |
| merchantId     | `String`          | 64       | Y    | 商户ID
| merchantName   | `String`          | 128      | Y    | 商户name
| pubKey         | `String`          | 132      | Y    | 商户公钥


##### 返回值：

| 属性            | 类型            | 最大长度 | 必填 | 说明                           |
| -------------  | -------------   | -------- | ---- | -------------------------------- |
| respCode       | `String`        | 6        | Y    | 返回码 '000000'表示成功
| msg            | `String`        | 64       | Y    | 消息信息
| data           | `Object`        |          | N    | 返回数据 交易Id
 

###### 返回值样例：
```
{
"data":"000001741e899e509dff1a16a63466fbe59f72e4","msg":"Success","respCode":"000000","success":true
}
```

#### 修改商户信息
##### 接口地址：/domain/modifyMerchant
请求方式：POST
##### 请求参数（通过RequestBody形式）

| 属性            | 类型              | 最大长度 | 必填 | 说明                           |
| -------------  | -------------     | -------- | ---- | -------------------------------- |
| merchantId     | `String`          | 64       | Y    | 商户ID
| merchantName   | `String`          | 128      | Y    | 商户name
| pubKey         | `String`          | 132      | Y    | 商户公钥


##### 返回值：

| 属性            | 类型            | 最大长度 | 必填 | 说明                           |
| -------------  | -------------   | -------- | ---- | -------------------------------- |
| respCode       | `String`        | 6        | Y    | 返回码 '000000'表示成功
| msg            | `String`        | 64       | Y    | 消息信息
| data           | `Object`        |          | N    | 返回数据 交易Id
 

###### 返回值样例：
```
{
"data":"000001741e899e509dff1a16a63466fbe59f72e4","msg":"Success","respCode":"000000","success":true
}
```


#### 查询商户信息
##### 接口地址：/domain/queryMerchant
请求方式：GET
##### 请求参数

| 属性            | 类型              | 最大长度 | 必填 | 说明                           |
| -------------  | -------------     | -------- | ---- | -------------------------------- |
| txId           | `String`          | 40       | Y    | txId
| merchantId     | `String`          | 64       | Y    | 商户ID


##### 返回值：

| 属性            | 类型            | 最大长度 | 必填 | 说明                           |
| -------------  | -------------   | -------- | ---- | -------------------------------- |
| respCode       | `String`        | 6        | Y    | 返回码 '000000'表示成功
| msg            | `String`        | 64       | Y    | 消息信息
| data           | `Object`        |          | N    | 返回数据


###### 返回值样例：
```
{
"data":{
"merchantId":"TEST-merchant",
"merchantName":"TEST",
"pubKey":"04eb1a1d24b2456b600b5ba594f9783a6d51bec678ef57cdb5c7127d107a956c0240e89d41bfe164e8ef7a21f43f4c16e6a46874d9835929422b3264602186c79c"
},"msg":"Success","respCode":"000000","success":true
}
```
