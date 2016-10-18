---
title: API Reference

language_tabs:
  - json

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true
---

# 0. 概述

API按照Restful风格设计

- 所有管理端的api 放在admin/  后面；所有微信端api放到weixin/ 后；
- 查询列表[index]：GET http://domain.com/admin/resources
- 查询一行[show]: GET http://domain.com/admin/resources/id
- 创建[create]: POST  http://domain.com/admin/resources 加form参数， resource[attributes]='value'
- 删除[destroy]: 
- 新增[create]:

API文档约定：

- 参数类型: Post方法一般使用form-data类型传参，GET方法一般使用URL。
- 参数说明： 没有标明类型的都是string，如果有其它类型则特殊说明。
- 必填参数： 前面带*号

# 1. 用户登录

## 1.1 登录

 | API说明
--------- | -----------
Method | POST
URL | http://commonstrength.com:3000/admin/sessions
参数类型 | form-data
参数 | * user[full_name]: '用户名'  <br> 	* user[password]: '密码'


> 登录成功后返回Token，

```json
{
	"data": {	
		"id": "2"
		"type": "users"
		"attributes": {
			"full-name": "admin"
			"token": "HBYh1piyn2hmhK5rALDGSErn"
		}
	}
}
```
> 以后每次请求将Token值放到Header中 

```json
X-Api-Key: Y4b2bVBazqD24WURPwJcHmh4IDkTsVdOrNwZJTM2AMB5p+wrqdQJJFtYOlQX5ALvOkDuxOziQTTixNPRQtdICg==
```


## 1.2 注销

 | API说明
--------- | -----------
Method | DELETE
URL | http://commonstrength.com:3000/admin/sessions
参数类型 | 无
参数 | 无

# 2 客户


## 2.1 获取客户列表

 | API说明
--------- | -----------
Method | GET
URL | http://commonstrength.com:3000/admin/customers
参数类型 | 无
参数 | 无
消息 | 无

> 返回Jason: 

```json

{
    "data": [
        {
            "id": "1",
            "type": "customers",
            "attributes": {
                "name": "wang",
                "mobile": "13912341324",
                "weixin": "sdfhsdfn"
            },
            "relationships": {
                "trainings": {
                    "data": []
                }
            }
        },
        {
            "id": "2",
            "type": "customers",
            "attributes": {
                "name": "Li Si",
                "mobile": "13923452345",
                "weixin": "lisi_weixin"
            },
            "relationships": {
                "trainings": {
                    "data": []
                }
            }
        }
    ]
}

```

## 2.2 查看客户

 | API说明
--------- | -----------
Method | GET
URL | http://commonstrength.com:3000/admin/customers/:id
参数类型 | URL
参数 | :id
消息 | 404: 没有找到该客户



```json
{
    "data": {
        "id": "1",
        "type": "customers",
        "attributes": {
            "name": "wang",
            "mobile": "13912341324",
            "weixin": "sdfhsdfn"
        },
        "relationships": {
            "trainings": {
                "data": []
            }
        }
    }
}

```


## 2.3 创建客户
 | API说明
--------- | -----------
|  Method| POST
|  URL| http://commonstrength.com:3000/admin/customers/
|  参数类型| form-data
| 参数| * customer[name] <br> * customer[mobile] <br> * customer[weixin] <br>
消息：| 201：成功 <br> 400: 参数错误（没有包含customer参数）<br> 422: 验证没通过

> 成功创建后返回201：

```json
{
    "data": {
        "id": "1",
        "type": "customers",
        "attributes": {
            "name": "wang",
            "mobile": "13912341324",
            "weixin": "sdfhsdfn"
        },
        "relationships": {
            "trainings": {
                "data": []
            }
        }
    }
}

```

> 未通过验证的返回422：
>> "pointer": "/data/attributes/mobile" ：字段名称为mobile   
> "detail": "can't be blank" =>  不能为空   
> "detail": "has already been taken"  => 不能重复  

```json
{
  "errors": [
    {
      "source": {
        "pointer": "/data/attributes/mobile"
      },
      "detail": "can't be blank"
    },
    {
      "source": {
        "pointer": "/data/attributes/name"
      },
      "detail": "has already been taken"
    }
  ]
}
```

## 2.4 删除客户

 | API说明
--------- | -----------
|  Method| DELETE
|  URL| http://commonstrength.com:3000/admin/customers/[id]
|  参数类型| URL
| 参数| * id
消息：| 204: 删除成功 <br> 404: 未找到资源 <br> 422: 验证没通过

> 如果Customer有关联的Training，会返回422, 并告知错误如下：

```json
{
  "errors": [
    {
      "source": {
        "pointer": "/data/attributes/base"
      },
      "detail": "Cannot delete record because dependent trainings exist"
    }
  ]
}

```




## 2.5 更新客户

 | API说明
--------- | -----------
|  Method| PATCH
|  URL| http://commonstrength.com:3000/admin/customers/[id]
|  参数类型| form-data
| 参数| customer[name] <br> customer[mobile] <br> customer[weixin] <br> --以上参数至少传一个。
消息：| 200: 更新成功 <br> 404:未找到资源 <br> 422: 验证没通过
> 成功后返回200，以及更新后的信息：

```json
{
  "data": {
    "id": "6",
    "type": "customers",
    "attributes": {
      "name": "王宝强",
      "mobile": "138000123",
      "weixin": "wangbaoqiang"
    },
    "relationships": {
      "trainings": {
        "data": []
      }
    }
  }
}

```

# 后台用户 - user
# 系统设置 - setting
# 门店 - store
# 课程 - course
# 课程表 - schedule
# 训练 - training
# 客户权益 - membership
