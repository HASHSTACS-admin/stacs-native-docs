## 系统内置SystemBD表
| functionName      	| execPermission | execPolicy         	| 备注 |
| IDENTITY_SETTING  	| DEFAULT        | IDENTITY_SETTING   	|给地址做身份认证      |
| BD_PUBLISH  			| DEFAULT        | BD_PUBLISH   	  	|发布BD      |
| PERMISSION_REGISTER  	| DEFAULT        | PERMISSION_REGISTER  |注册Permission      |
| AUTHORIZE_PERMISSION  | DEFAULT        | AUTHORIZE_PERMISSION |给地址添加Permission      |
| CANCEL_PERMISSION  	| RS        	 | CANCEL_PERMISSION   	|取消地址的Permission      |
| REGISTER_POLICY  		| DEFAULT        | REGISTER_POLICY   	|注册Policy      |
| MODIFY_POLICY  		| DEFAULT        | MODIFY_POLICY   	    |修改Policy      |
| REGISTER_RS  			| DEFAULT        | REGISTER_RS   	    |注册为RS节点      |
| CANCEL_RS  			| RS        	 | CANCEL_RS   	  		|取消RS节点      |
| CA_AUTH  				| DEFAULT        | CA_AUTH   	  		|注册CA      |
| CA_CANCEL  			| RS        	 | CA_CANCEL   	  		|取消CA      |
| CA_UPDATE  			| RS        	 | CA_UPDATE   	  		|更新CA      |
| NODE_JOIN  			| DEFAULT        | NODE_JOIN   	  		|节点加入      |
| NODE_LEAVE  			| RS        	 | NODE_LEAVE   	  	|节点离开      |
| SYSTEM_PROPERTY  		| RS        	 | SYSTEM_PROPERTY   	|设置系统属性      |
| IDENTITY_BD_MANAGE  	| DEFAULT        | IDENTITY_BD_MANAGE  	|冻结Identity使用BD      |
| KYC_SETTING  			| DEFAULT        | KYC_SETTING   	  	|为Identity设置KYC      |
| SET_FEE_CONFIG  		| RS        	 | SET_FEE_CONFIG   	|设置费用      |
| SET_FEE_RULE  		| RS        	 | SET_FEE_RULE   	  	|设置费用规则      |
| SAVE_ATTESTATION  	| DEFAULT        | SAVE_ATTESTATION   	|存证交易      |
| BUILD_SNAPSHOT  		| DEFAULT        | BUILD_SNAPSHOT   	|快照交易      |


