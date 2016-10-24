---
title: API Reference

language_tabs:
  - json

toc_footers:

includes:
  - errors

search: true

author: Chen Xi

---
文档目录

* [项目看板](#prj)
* [0.概述] (#0)
*  [ 1.登录 ] (#1)
*  [ 2.会员客户 ] 	(#2)
*  [ 3.后台用户 ] 	(#3)
*  [ 4.课程规则 ] 	(#4)
*  [ 5.门店 ] 		(#5)
*  [ 6.课程分类 ] 	(#6)
*  [ 7.课程 ] 		(#7)
*  [ 8.课程表 ]  	(#8)
*  [ 9.训练 ]  	(#9)
*  [ 10.会员操作 ]	(#10)
*  [ 11.微信 ] 	(#11)
*  [ 12.报表 ] 	(#12)



<p id="prj"/>
# 项目看板 

日期 | 更新日志
----|----
2016-10-18 	| 	提交‘[登录](#1)’接口 
2016-10-19	|	提交‘课程类别’，‘[门店](#5)’，更新‘[客户](#2)’；重装系统，解决中文问题；
2016-10-20	|	提交‘[课程规则](#4)’，’[课程](#7)‘，更新’客户‘增加字段；
2016-10-21	|	修改 客户，课程，增加按照门店过滤，按照微信，名字，手机搜索客户； 提交 [用户](#3)模块；编写测试代码； 
2016-10-22 	|  提交”[课程表](#8)‘，
2016-10-23 | 提交”[会员操作](#10)“；提交”[训练](#9)“；提交 客户，训练的分页； 
2016-10-24 | 课程表对接中； 开发“课程表按周操作“功能；
2016-10-25 | 发布“课程表按周操作“

模块  | 后端开发 | 前端对接 | 问题
----|----|----|----
1 登录 		| 完成 | 完成 | 😄
2 会员客户 	| 修改 | 完成 | 😄 
3 后台用户 	| 完成 | 完成 | 😄
4 课程规则 	| 完成 | 完成 | 😄
5 门店 		| 完成 | 完成 | 😄
6 课程分类 	| 完成 | 完成 | 😄
7 课程 		| 完成 | 完成 |  😄
8 课程表  	| 完成 | 进行中 | TODO：增加复制一周的功能【DONE】
9 训练  	| 完成 | | 
10 会员操作	| 完成 | | 
11 微信 	|  | |
12 报表 	|  | |



<p id="0"/>
# 0. API概述

## CRUD

API按照Restful风格设计, 所有管理端的api放在admin/后面；所有微信端api放到weixin/后,基本都CRUD遵循下面的规范：


动作 | METHOD | URI | Form-data Params
----|----|----|----
查询列表[index]：	|GET |http://domain.com/admin/resources|
查询一行[show]: |	GET| http://domain.com/admin/resources/id|
创建[create]: 	|	POST  |http://domain.com/admin/resources | 需要 如：resource[attributes]='value'
更新[update]: |		PUT | http://domain.com/admin/resources | 需要 如：resource[attributes]='value'
删除[destroy]: 	|	DELET |http://domain.com/admin/resources/id|


## 分页

- 传递URL参数 
- 参数格式：“page=2&per_page=1”，
 - page: 第几页，
 - per_page: 每页多少条
 - 如果不传参数，page默认为1，per_page默认为25；
-  目前支持分页的有 customer，training 的获取列表接口；
-  带分页如下例子：
	-  links：其它页的链接
	-  meta：当前页的信息 （见下面注释）

```json
{
    "data": [
        {
            "id": "2",
            "type": "customers",
            "attributes": {
                "name": "李四",
                "mobile": "18912345678",
                "weixin": "wx234567",
                "membership-type": "time_card",
                "store-id": 2,
                "membership-remaining-times": 20,
                "membership-duedate": "2016-01-23",
                "store-name": "大望路店",
                "is-locked": false
            }
        }
    ],
    "links": {
        "self": "http://localhost:3000/admin/customers?page%5Bnumber%5D=2&page%5Bsize%5D=1&per_page=1",
        "first": "http://localhost:3000/admin/customers?page%5Bnumber%5D=1&page%5Bsize%5D=1&per_page=1",
        "prev": "http://localhost:3000/admin/customers?page%5Bnumber%5D=1&page%5Bsize%5D=1&per_page=1",
        "next": "http://localhost:3000/admin/customers?page%5Bnumber%5D=3&page%5Bsize%5D=1&per_page=1",
        "last": "http://localhost:3000/admin/customers?page%5Bnumber%5D=3&page%5Bsize%5D=1&per_page=1"
    },
    "meta": {
        "current-page": 2, //当前页
        "next-page": 3,		//后面还有？页
        "prev-page": 1,		//前面有？页
        "total-pages": 3,	//总共有？页
        "total-count": 3	//总共？条数据
    }
}
```

<p id="1"/>
# 1. 用户登录

## 1.1 登录

 | API说明
--------- | -----------
Method | POST
URI |  /admin/sessions
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
URI | /admin/sessions
参数类型 | 无
参数 | 无

<p id="2"/>
# 2 客户


## 2.1 获取客户列表

 | API说明
--------- | -----------
Method | GET
URI |  /admin/customers[?store_id=#][&qstring=?]
参数类型 | URL
参数 | store_id, 为空不过滤，否则按照门店过滤; qstring, 如果不为空则搜索 name,weixin,mobile.
消息 | 无

> 返回Jason:

>  "membership-type": "time_card", 时间卡
>  "membership-type": "measured_card", 次卡

```json

{
  "data": [
    {
      "id": "1",
      "type": "customers",
      "attributes": {
        "name": "张三",
        "mobile": "13912345678",
        "weixin": "wx123456",
        "membership-type": "time_card",
        "store-id": 1,
        "membership-remaining-times": null,
        "membership-duedate": "2010-12-31",
        "store-name": "中关村店"
      },
      "relationships": {
        "trainings": {
          "data": [
            {
              "id": "1",
              "type": "trainings"
            }
          ]
        }
      }
    },
    {
      "id": "2",
      "type": "customers",
      "attributes": {
        "name": "李四",
        "mobile": "18912345678",
        "weixin": "wx234567",
        "membership-type": "measured_card",
        "store-id": 2,
        "membership-remaining-times": 20,
        "membership-duedate": null,
        "store-name": "大望路店"
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
URI |  /admin/customers/:id
参数类型 | URI
参数 | :id
消息 | 404: 没有找到该客户



```json
{
  "data": {
    "id": "1",
    "type": "customers",
    "attributes": {
      "name": "张三",
      "mobile": "13912345678",
      "weixin": "wx123456",
      "membership-type": "time_card",
      "store-id": 1,
      "membership-remaining-times": null,
      "membership-duedate": "2010-12-31",
      "store-name": "中关村店"
    },
    "relationships": {
      "trainings": {
        "data": [
          {
            "id": "1",
            "type": "trainings"
          }
        ]
      }
    }
  }
}
```


## 2.3 创建客户
 | API说明
--------- | -----------
|  Method| POST
|  URI|  /admin/customers/
|  参数类型| form-data
| 参数| customer[name]:必填，不重复 <br> customer[mobile]:必填，不重复  <br> customer[weixin]:必填，不重复 <br> customer[store_id]: 必填，store必须存在。 <br> customer[membership_type] 必填, <br> ---'measured_card' 表示次卡，'time_card' 表示时间卡 <br> customer[membership_remaining_times]: 前端校验，如果是次卡则必填； <br> customer[membership_duedate]: 前端校验，如果是时间卡则必填； <br>



消息：| 201：成功 <br> 400: 参数错误（没有包含customer参数）<br> 422: 验证没通过

> 成功创建后返回201：

```json

{
  "data": {
    "id": "10",
    "type": "customers",
    "attributes": {
      "name": "chenxi2",
      "mobile": "1234423423",
      "weixin": "weixin1234",
      "membership-type": "time_card",
      "store-id": 1,
      "membership-remaining-times": null,
      "membership-duedate": null,
      "store-name": "中关村店"
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
> "detail": "must exist" => 关联数据必须存在

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
|  URI|  /admin/customers/[id]
|  参数类型| URI
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
|  Method|  PUT
|  URI|  /admin/customers/[id]
|  参数类型| form-data
| 参数| customer[name]<br> customer[mobile]<br> customer[weixin]<br> customer[store_id]<br> customer[membership_type]<br> customer[membership_remaining_times]<br> customer[membership_duedate]<br>--以上参数至少传一个。
| 特殊参数 | operation_memo: text <br> -- 所有对客户的修改都要求用户写“备忘”，例如：“客户因特殊情况要求延期一个月，因此修改客户时间卡。。”，这个字段跟客户其它字段一起传入此接口，必须提供。详见  [ 10.会员操作 ]	(#10)
消息：| 200: 更新成功 <br> 404:未找到资源 <br> 422: 验证没通过

> 成功后返回200，以及更新后的信息：





<p id="3"/>
# 3 后台用户 - user


管理登录用的帐号，在修改客户记录（增加／修改会员权益）的时候，会记录登录操作的管理员id；


参数名 | 说明  | 类型| 约束 |
----|----|----|----|----
 user[full_name]         | | string| 必填 | |
 user[password]  | | string  | 必填 |
 user[description] | | text | |
 user[create_at] | | datetime | 只读|


## 3.1 用户 - 获取列表
 | API说明
--------- | -----------
|  Method| GET
|  URI|  /admin/users
|  参数类型| n/a
|  参数| n/a
消息：| 200: 更新成功

```json
{
  "data": [
    {
      "id": "1",
      "type": "users",
      "attributes": {
        "full-name": "Sasa J",
        "description": null,
        "created-at": "2016-10-12T18:30:24.000Z"
      }
    },
    {
      "id": "2",
      "type": "users",
      "attributes": {
        "full-name": "admin",
        "description": null,
        "created-at": "2016-10-12T19:32:22.000Z"
      }
    }
  ]
}


```


## 3.2 用户 - 新增

 | API说明
--------- | -----------
|  Method| POST
|  URI|  /admin/users
|  参数类型| form-data
| 参数| user[name]: 不能重复, 不能为空 <br> user[password]
| 消息：| 201：成功 <br> 400: 参数错误（没有包含customer参数）<br> 422: 验证没通过

> 成功创建后返回201：
> 验证没通过返回422:


## 3.3 用户 - 删除
 | API说明
--------- | -----------
|  Method| DELETE
|  URI|  /admin/users/[id]
|  参数类型| URI
| 参数| * id,
消息：| 204: 删除成功 <br> 404: 未找到资源 <br> 422: 验证没通过

> 如果有关联 操作记录, 不能被删除，并会返回422：



## 3.4 用户 - 修改
 | API说明
--------- | -----------
|  Method|  PUT
|  URI|  /admin/users/[id]
|  参数类型| form-data
| 参数| name, password, description 至少包含一个
消息：| 200: 更新成功 <br> 404:未找到资源 <br> 422: 验证没通过
> 成功后返回200，以及更新后的信息：

<p id="4"/>
# 4 课程规则 - setting
# 4.1 课程规则

课程规则只能修改现有记录，不能删除，不能新增；

参数名 | 说明  | 类型| 约束 |
----|----|----|----|----
 setting[key]         | 设置项  | string| 必填 | |
 setting[value]  | 设置值  | string  | 必填 |
 setting[updated_at] | 更新时间| int | 不可修改 |


设置项[:key] | 标题 | 说明
----|----|----
booking_limit_days | 课程预约时间限制（天） | 客户可以预定未来？的天课程
course_view_days | 课程浏览时间限制（天）|客户可以查看未来？天的课程
cancle_limit_minutes | 课程冻结时间（分钟）|课程开始前？分钟，客户可以取消预约，可以自动排队
queue_limit_number| 允许排队人数（个）| 允许排队的人数（所有课程有效）


```json
{
  "data": [
    {
      "id": "1",
      "type": "settings",
      "attributes": {
        "key": "booking_limit_days",
        "value": "7"
      }
    },
    {
      "id": "2",
      "type": "settings",
      "attributes": {
        "key": "course_view_days",
        "value": "7"
      }
    },
    {
      "id": "3",
      "type": "settings",
      "attributes": {
        "key": "cancle_limit_minutes",
        "value": "7"
      }
    },
    {
      "id": "4",
      "type": "settings",
      "attributes": {
        "key": "queue_limit_number",
        "value": "7"
      }
    }
  ]
}
```
## 4.2 获取所有设置

 | API说明
--------- | -----------
Method | GET
URI |  /admin/settings
参数类型 | 无
参数 | 无
消息 | 无


## 4.3 获取一项设置

 | API说明
--------- | -----------
Method | GET
URI |  /admin/settings/:key
参数类型 | URI
参数 | :key
消息 | 404: 没有找到该课程


## 4.4 更新设置

 | API说明
--------- | -----------
|  Method|  PUT
|  URI|  /admin/settings/:key
|  参数类型| form-data
| 参数| <参考参数表>
消息：| 200: 更新成功 <br> 404:未找到资源

> 成功后返回200，以及更新后的信息：


<p id="5"/>
# 5 门店 - store

## 5.1 门店 - 获取列表
 | API说明
--------- | -----------
|  Method| GET
|  URI|  /admin/stores
|  参数类型| n/a
| 参数| n/a
消息：| 200: 更新成功

```json
{
  "data": [
    {
      "id": "1",
      "type": "stores",
      "attributes": {
        "name": "中关村店",
        "address": "中关村",
        "telphone": "010-009988776"
      }
    },
    {
      "id": "2",
      "type": "stores",
      "attributes": {
        "name": "大望路店",
        "address": "大望路",
        "telphone": "010-119988776"
      }
    }
  ]
}
```


## 5.2 门店 - 新增

 | API说明
--------- | -----------
|  Method| POST
|  URI|  /admin/stores
|  参数类型| form-data
| 参数| store[name]: 不能重复, 不能为空 <br> store[address] <br> store[telphone]
| 消息：| 201：成功 <br> 400: 参数错误（没有包含customer参数）<br> 422: 验证没通过

> 成功创建后返回201：
> 验证没通过返回422:

```json
{
  "errors": [
    {
      "source": {
        "pointer": "/data/attributes/name"
      },
      "detail": "has already been taken"
    }
  ]
}

{
  "errors": [
    {
      "source": {
        "pointer": "/data/attributes/name"
      },
      "detail": "can't be blank"
    }
  ]
}
```

## 5.3 门店 - 删除
 | API说明
--------- | -----------
|  Method| DELETE
|  URI|  /admin/stores/[id]
|  参数类型| URI
| 参数| * id,
消息：| 204: 删除成功 <br> 404: 未找到资源 <br> 422: 验证没通过

> 如果有关联课程, 客户，不能被删除，并会返回422：

```json
{
  "errors": [
    {
      "source": {
        "pointer": "/data/attributes/base"
      },
      "detail": "Cannot delete record because dependent courses exist"
    }
  ]
}


{
  "errors": [
    {
      "source": {
        "pointer": "/data/attributes/base"
      },
      "detail": "Cannot delete record because dependent customer exist"
    }
  ]
}

```


## 5.4 门店 - 修改
 | API说明
--------- | -----------
|  Method|  PUT
|  URI|  /admin/stores/[id]
|  参数类型| form-data
| 参数| store[name]: 不能重复, 不能为空 <br> store[address]--以上参数至少传一个。
消息：| 200: 更新成功 <br> 404:未找到资源 <br> 422: 验证没通过
> 成功后返回200，以及更新后的信息：
> 验证没通过消息同新增

```json

{
  "data": {
    "id": "5",
    "type": "stores",
    "attributes": {
      "name": "haha",
      "address": "big store address",
      "telphone": "12312340"
    }
  }
}

```


<p id="6"/>
# 6 课程类型 - course_type
## 6.1 课程类型 - 获取列表
 | API说明
--------- | -----------
|  Method| GET
|  URI|  /admin/course_types
|  参数类型| n/a
| 参数| n/a
消息：| 200: 更新成功

```json
{
  "data": [
    {
      "id": "1",
      "type": "course-types",
      "attributes": {
        "name": "基础课程",
        "description": null
      },
      "relationships": {
        "courses": {
          "data": [
            {
              "id": "1",
              "type": "courses"
            }
          ]
        }
      }
    },
    {
      "id": "2",
      "type": "course-types",
      "attributes": {
        "name": "进阶课程",
        "description": null
      },
      "relationships": {
        "courses": {
          "data": []
        }
      }
    }
  ]
}
```


## 6.2 课程类型 - 新增

 | API说明
--------- | -----------
|  Method| POST
|  URI|  /admin/course_types
|  参数类型| form-data
| 参数| course_type[name]: 不能重复, 不能为空 <br> course_type[description]
| 消息：| 201：成功 <br> 400: 参数错误（没有包含customer参数）<br> 422: 验证没通过

> 成功创建后返回201：
> 验证没通过返回422:

```json
{
  "errors": [
    {
      "source": {
        "pointer": "/data/attributes/name"
      },
      "detail": "has already been taken"
    }
  ]
}

{
  "errors": [
    {
      "source": {
        "pointer": "/data/attributes/name"
      },
      "detail": "can't be blank"
    }
  ]
}
```

## 6.3 课程类型 - 删除
 | API说明
--------- | -----------
|  Method| DELETE
|  URI|  /admin/course_types/[id]
|  参数类型| URI
| 参数| * id,
消息：| 204: 删除成功 <br> 404: 未找到资源 <br> 422: 验证没通过

> 如果有关联课程，不能被删除，并会返回422：

```json
{
  "errors": [
    {
      "source": {
        "pointer": "/data/attributes/base"
      },
      "detail": "Cannot delete record because dependent courses exist"
    }
  ]
}
```


## 6.4 课程类型 - 修改
 | API说明
--------- | -----------
|  Method|  PUT
|  URI|  /admin/course_types/[id]
|  参数类型| form-data
| 参数| course_type[name]: 不能重复, 不能为空 <br> course_type[description]--以上参数至少传一个。
消息：| 200: 更新成功 <br> 404:未找到资源 <br> 422: 验证没通过
> 成功后返回200，以及更新后的信息：
> 验证没通过消息同新增

```json
{
  "data": {
    "id": "6",
    "type": "course-types",
    "attributes": {
      "name": "haha",
      "description": "make you strong than ever"
    }
  }
}
```

<p id="7"/>
# 7 课程

字段说明

参数名 | 说明  | 类型| 约束 |
----|----|----|----|----
 course[name]         | 课程名称  | string| 必填 | |
 course[description]  | 课程描述  | text  |  |
 course[store_id]     | 门店id    |int    | 必填 |
 course[status]     | 课程状态    |string    | 必填，只有两个值 'active','inactive' |
 course[type_id]      | 课程分类id| int   | 必填 |
 course[default_capacity] | 默认容量 | int |  |
 course[created_at] | 创建时间 | int | 不可修改 |
 course[updated_at] | 更新时间| int | 不可修改 |


## 7.1 获取课程列表

 | API说明
--------- | -----------
Method | GET
URI |  /admin/courses[?store_id=#]
参数类型 | URL
参数 | store_id, 为空不过滤，否则按照门店过滤


> 返回Jason:

```json
{
  "data": {
    "id": "2",
    "type": "courses",
    "attributes": {
      "name": "上肢训练",
      "status": null,
      "description": "客户如果要在开课前n小时内取消，需要跟小助手联系，由小助手在后台操作，以方便小助手对排队客户进行安排和及时通知；",
      "type-id": 2,
      "store-id": 2,
      "default-capacity": 10,
      "updated-at": "2016-10-20T08:20:28.000Z",
      "created-at": "2016-10-20T08:20:28.000Z"
    }
  }
}


```

## 7.2 查看课程

 | API说明
--------- | -----------
Method | GET
URI |  /admin/courses/:id
参数类型 | URI
参数 | :id
消息 | 404: 没有找到该课程


## 7.3 创建课程
 | API说明
--------- | -----------
|  Method| POST
|  URI|  /admin/courses/
|  参数类型| form-data
| 参数| course[name]:必填 <br>  course[description]:  <br>  course[store_id]:门店id，必填 <br> course[type_id]: 课程类型id，必填，course_type必须存在。<br> course[default_capacity]:课程默认容量；


消息：| 201：成功 <br> 400: 参数错误（没有包含course参数）<br> 422: 验证没通过

> 成功创建后返回201, 以及新课程json：


> 未通过验证的返回422：
> "detail": "can't be blank" =>  不能为空
> "detail": "has already been taken"  => 不能重复
> "detail": "must exist" => 关联数据必须存在


## 7.4 删除课程

 | API说明
--------- | -----------
|  Method| DELETE
|  URI|  /admin/courses/[id]
|  参数类型| URI
| 参数| * id
消息：| 204: 删除成功 <br> 404: 未找到资源 <br> 422: 验证没通过

> 422: 如果Course有关联的Schedule，会返回422, 并告知错误如下：

```json
{
  "errors": [
    {
      "source": {
        "pointer": "/data/attributes/base"
      },
      "detail": "Cannot delete record because dependent schedule exist"
    }
  ]
}

```


## 7.5 更新课程

 | API说明
--------- | -----------
|  Method|  PUT
|  URI|  /admin/courses/[id]
|  参数类型| form-data
| 参数| <参考参数表>
消息：| 200: 更新成功 <br> 404:未找到资源 <br> 422: 验证没通过

> 成功后返回200，以及更新后的信息：

<p id="8"/>
# 8 课程表
参数名 | 说明  | 类型| 约束 |
----|----|----|----|----
 schedule[store_id]   | 课程id  | int  | 必填  | store必须存在
 schedule[store_name]   | 门店名称  | string  | 只读  |
 schedule[course_id]  | 门店id    |int    | 必填 | course必须存在
 schedule[course_name]   | 课程名称  | string  | 只读  |
 schedule[start_time] | 开始时间    |datetime    | 必填 |
 schedule[end_time]   | 结束时间 | datetime   | 必填 | 开始时间与结束时间之差不能超过8小时；
 schedule[capacity] | 课程容量 | int | 必填 |
 schedule[is_published] | 是否发布 | boolean |  |
 schedule[created_at] | 创建时间 | int | 不可修改 |
 schedule[updated_at] | 更新时间| int | 不可修改 |

## 8.1 获取课程表列表

 | API说明
--------- | -----------
Method | GET
URI |  /admin/schedules?[store_id=1]&[by_week=2016-10-22]
参数类型 | URL
参数 | store_id: 按照门店获取，<br>by_week: 提供一天时间，将返回这一周的课程表，日期格式为 %y-%m-%d
消息 | 200 404

> 返回Jason:

```json
{
    "data": [
        {
            "id": "3",
            "type": "schedules",
            "attributes": {
                "store-id": 4,
                "store-name": "a big store",
                "course-id": 1,
                "course-name": "测试课程",
                "start-time": "2016-10-21T16:13:52.000Z",
                "end-time": "2016-10-21T16:13:52.000Z",
                "capacity": 101,
                "is-published": false,
                "updated-at": "2016-10-21T16:19:12.000Z"
            }
        },
        {
            "id": "4",
            "type": "schedules",
            "attributes": {
                "store-id": 4,
                "store-name": "a big store",
                "course-id": 1,
                "course-name": "测试课程",
                "start-time": "2016-10-21T16:13:52.000Z",
                "end-time": "2016-10-21T16:13:52.000Z",
                "capacity": 10,
                "is-published": false,
                "updated-at": "2016-10-21T16:19:24.000Z"
            }
        },
        {
            "id": "5",
            "type": "schedules",
            "attributes": {
                "store-id": 4,
                "store-name": "a big store",
                "course-id": 1,
                "course-name": "测试课程",
                "start-time": "2016-10-21T16:13:52.000Z",
                "end-time": "2016-10-21T16:13:52.000Z",
                "capacity": 10,
                "is-published": false,
                "updated-at": "2016-10-21T16:19:28.000Z"
            }
        }
    ]
}

```

## 8.2 更新课程表

 | API说明
--------- | -----------
|  Method|  PUT
|  URI|  /admin/schedules/[id]
|  参数类型| form-data
| 参数| 没有标注只读的都可以传入更新
消息：| 200: 更新成功 <br> 404:未找到资源 <br> 422: 验证没通过

## 8.3 查看课程表

 | API说明
--------- | -----------
Method | GET
URI |  /admin/schedules/:id
参数类型 | URI
参数 | :id
消息 | 404: 没有找到该课程表


## 8.4 创建课程表
 | API说明
--------- | -----------
|  Method| POST
|  URI|  /admin/schedules/
|  参数类型| form-data
| 参数| 见<参数表>

消息：| 201：成功 <br> 400: 参数错误（没有包含schedule参数）<br> 422: 验证没通过

> 成功创建后返回201 和新数据json：

> 未通过验证的返回422：
>> "pointer": "/data/attributes/foo" ：字段名称为foo
> "detail": "can't be blank" =>  不能为空
> "detail": "has already been taken"  => 不能重复
> "detail": "must exist" => 关联数据必须存在

## 8.5 删除课程表

 | API说明
--------- | -----------
|  Method| DELETE
|  URI|  /admin/schedules/[id]
|  参数类型| URI
| 参数| * id
消息：| 204: 删除成功 <br> 404: 未找到资源 <br> 422: 验证没通过

> 如果schedule有关联的trainings，会返回422, 并告知错误如下：

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

## 8.6 按周查看课程表
 | API说明
--------- | -----------
|  Method| GET
|  URI|  /admin/stores/[store_id]/schedules_by_week/[id]
|  参数类型| URI
| 参数| [store_id]: 门店id，必填； <br>[id]: 格式为 %y-%m-%d, 输入任意日期，返回这周的课程表；
消息：| 200: 如果没有则数据为空

## 8.7 按周复制课程表
 | API说明
--------- | -----------
|  Method| POST
|  URI|  /admin/stores/[store_id]/schedules_by_week
|  参数类型| form-date
| 参数| from_week: 复制数据来源 <br> to_week: 复制目标，<br>格式都为 %y-%m-%d
消息：| 200, 422, 409, 403

> 返回 200: 如果复制成功，则返回所有新创建的课程表数据； （json略）

> 返回 422: 如果参数错误：

```json

{
	"errors": [
        {
            "source": {
                "pointer": "/data/attributes/schedules"
            },
            "detail": "params 'from_week' and 'to_week' must be given as as '%y-%m-%d', and shouldn't be  the same week!"
        }
    ]
}
```

> 返回 409:  如果to_week已经存在至少一条课程表记录，将拒绝复制；

```json
{
    "errors": [
        {
            "source": {
                "pointer": "/data/attributes/schedules"
            },
            "detail": "target week already have schedules, please delete them all and try again!!"
        }
    ]
}
```

> 返回 403: 如果from_week 没有数据：

```json
{
    "errors": [
        {
            "source": {
                "pointer": "/data/attributes/schedules"
            },
            "detail": "Can't find any schedules in from_week!!"
        }
    ]
}

``` 



## 8.8 按周删除课程表
 | API说明
--------- | -----------
|  Method| DELETE
|  URI|  /admin/stores/[store_id]/schedules_by_week/[id]
|  参数类型| URL
| 参数| [store_id]: 门店id，必填； <br>[id]: 格式为 %y-%m-%d, 输入任意日期，返回这周的课程表；
| 消息：| 204, 422, 409, 403

> 返回 204: 如果删除成功

> 返回 422: 如果参数错误：

```json
{
    "errors": [
        {
            "source": {
                "pointer": "/data/attributes/schedules"
            },
            "detail": "id must be given as %y-%m-%d!!"
        }
    ]
}

```

> 返回 409:  如果to_week已经存在至少一条课程表记录，将拒绝复制；

```json
{
    "errors": [
        {
            "source": {
                "pointer": "/data/attributes/schedules"
            },
            "detail": "some schedules of this week have already created trainings, can't be deleted!!"
        }
    ]
}
```

> 返回 403: 如果from_week 没有数据：

```json
{
    "errors": [
        {
            "source": {
                "pointer": "/data/attributes/schedules"
            },
            "detail": "Can't find any schedules in the giving week, nothing can be delete!"
        }
    ]
}
``` 

<p id="9"/>
# 9 训练 - training
# 9 训练
参数名 | 说明  | 类型| 约束 |
----|----|----|----|----
 training[schedule_id]  | 课程表id    |int    | 必填 |schedule必须存在
 training[customer_id]  | 客户id    |int    | 必填 | customer必须存在
 training[booking_status]   | 预定状态 | enum   | 必填 | no_booking:未预定，由管理员直接创建；<br> booked: 已预定；<br>waiting: 排队中；<br> waiting_confirmed: <br> cancelled: 取消预定
 training[training_status]   | 训练状态 | enum   | 必填 | not_start: 未开始, <br> absence: 缺席,<br> be_late: 迟到, <br> complete: 完成训练
 training[customer_name]   | 客户名称  | string  | 只读  | 来自cusrtomer
 training[start_time] | 开始时间    |datetime    | 只读 | 来自schedule
 training[end_time]   | 结束时间 | datetime   | 只读| 来自schedule
 training[store_id]   | 门店id  | int  | 必填  | 来自schedule
 training[store_name]   | 门店名称  | string  | 只读  | 来自schedule
 training[course_id]  | 课程id    |int    | 只读 | 来自schedule
 training[course_name]   | 课程名称  | string  | 只读  |来自schedule
 training[created_at] | 创建时间 | int | 自动修改 |
 training[updated_at] | 更新时间| int | 自动修改 |

状态说明：

>1. 客户预约  
> 1.1. 如果容量未满： booking_status: booked ; training_status: not_start;  
> 1.2. 如果容量已满： booking_status: waiting ; training_status: not_start;  
> 1.3. 如果有人取消，或者管理员操作‘确认排队’： booking_status: booked ; training_status: not_start;

>2. 客户取消预约：booking_status: cancelled ; training_status: not_start;

>3. 课程结束，管理员签到  
>  3.1 如果预约的客户完成训练：booking_status: booked ; training_status: complete;  
>  3.2 如果预约的客户缺席训练：booking_status: booked ; training_status: absence;  
> 3.3 如果预约的客户迟到：    booking_status: booked ; training_status: be_late;  
> 3.4 如果由未预约的客户参加训练： booking_status: no_booking; training_status: complete;

## 9.1 获取训练列表

 | API说明
--------- | -----------
Method | GET
URI |  /admin/trainings?[store_id=1]&[customer_id=#]
参数类型 | URL
参数 | store_id: 按照门店获取，<br>customer_id: 按照customer_id获取
消息 | 200 404

> 返回Jason:

```json

{
    "data": [
        {
            "id": "1",
            "type": "trainings",
            "attributes": {
                "store-id": 1,
                "store-name": "中关村店",
                "customer-id": 1,
                "customer-name": "张三",
                "schedule-id": 1,
                "start-time": "2016-10-21T16:13:52.000Z",
                "end-time": "2016-10-21T16:58:52.000Z",
                "course-id": 1,
                "course-name": "测试课程",
                "booking-status": "waiting",
                "training-status": "absence",
                "created-at": "2016-10-12T19:16:30.000Z",
                "updated-at": "2016-10-23T03:01:22.000Z"
            },
            "relationships": {
                "customer": {
                    "data": {
                        "id": "1",
                        "type": "customers"
                    }
                }
            }
        },
        {
            "id": "2",
            "type": "trainings",
            "attributes": {
                "store-id": 1,
                "store-name": "中关村店",
                "customer-id": 1,
                "customer-name": "张三",
                "schedule-id": 1,
                "start-time": "2016-10-21T16:13:52.000Z",
                "end-time": "2016-10-21T16:58:52.000Z",
                "course-id": 1,
                "course-name": "测试课程",
                "booking-status": "booked",
                "training-status": "not_start",
                "created-at": "2016-10-23T03:10:42.000Z",
                "updated-at": "2016-10-23T03:10:42.000Z"
            },
            "relationships": {
                "customer": {
                    "data": {
                        "id": "1",
                        "type": "customers"
                    }
                }
            }
        },
```

## 9.2 更新训练

 | API说明
--------- | -----------
|  Method|  PUT
|  URI|  /admin/trainings/[id]
|  参数类型| form-data
| 参数| 没有标注只读的都可以传入更新
消息：| 200: 更新成功 <br> 404:未找到资源 <br> 422: 验证没通过

## 9.3 查看训练

 | API说明
--------- | -----------
Method | GET
URI |  /admin/trainings/:id
参数类型 | URI
参数 | :id
消息 | 404: 没有找到该训练


## 9.4 创建训练
 | API说明
--------- | -----------
|  Method| POST
|  URI|  /admin/trainings/
|  参数类型| form-data
| 参数| 见<参数表>

消息：| 201：成功 <br> 400: 参数错误（没有包含training参数）<br> 422: 验证没通过

> 成功创建后返回201 和新数据json：

> 未通过验证的返回422：
>> "pointer": "/data/attributes/foo" ：字段名称为foo
> "detail": "can't be blank" =>  不能为空
> "detail": "has already been taken"  => 不能重复
> "detail": "must exist" => 关联数据必须存在

## 9.5 删除训练

 | API说明
--------- | -----------
|  Method| DELETE
|  URI|  /admin/trainings/[id]
|  参数类型| URI
| 参数| * id
消息：| 204: 删除成功 <br> 404: 未找到资源 <br> 422: 验证没通过

> 如果training有关联的trainings，会返回422, 并告知错误如下：

<p id="10"/>
# 10 操作记录 - operation

系统操作：

- 当用户修改客户资料时，在新的客户信息保存到数据库以后，会生产一条操作记录；
- 操作记录无法从UI中修改，或者删除；
- 当客户可以删除时，（从未预约／训练过的客户），所有操作记录一起被删除；
- description: 由系统记录，自动登记修改后的会员权益信息；
- operation_memo: 需要在修改客户时由管理用户填写，而且必须填写，否则不允许修改客户资料；


## 10.1 获取操作记录列表

 | API说明
--------- | -----------
Method | GET
URI |  /admin/operations?[customer_id=#]
参数类型 | URL
参数 | customer_id: 按客户id获取操作记录列表
消息 | 200 404

> 返回Jason:

```json
{
    "data": [
        {
            "id": "7",
            "type": "operations",
            "attributes": {
                "user-id": 4,
                "customer-id": 2,
                "description": "系统用户: 'admin'修改了客户:'李四', 会员类型： 'time_card', 会员到期时间:'2017-01-31', 会员卡剩余次数:'20' ",
                "operation-memo": null,
                "created-at": "2016-10-22T16:02:17.000Z"
            }
        }
    ]
}
```

## 10.2 查看操作记录

 | API说明
--------- | -----------
Method | GET
URI |  /admin/operations/:id
参数类型 | URI
参数 | :id
消息 | 404: 没有找到该操作记录


<p id="11"/>
# 11 微信接口

<p id="12"/>
# 12 报表接口
