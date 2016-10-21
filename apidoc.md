---
title: API Reference

language_tabs:
  - json

toc_footers:

includes:
  - errors

search: true

---
# 项目看板
日期 | 更新日志
----|----
2016-10-18 	| 	提交‘登录’接口 
2016-10-19	|	提交‘课程类别’，‘门店’，更新‘客户’；重装系统，解决中文问题；
2016-10-20	|	提交‘课程规则’，’课程‘，更新’客户‘增加字段；
2016-10-21	|	修改 客户，课程，增加按照门店过滤，按照微信，名字，手机搜索客户； 提交 用户模块；编写测试代码； 
2016-10-22 	| 

模块  | 后端开发 | 前端对接 | 问题
----|----|----|----
1 登录 		| 完成 | 完成 |
2 会员客户 	| 修改 | 进行中 | TODO：<br>1.需要加分页，<br> 2.增加搜索，名称，电话，微信；[done]<br> 3. index接受门店参数[done]<br> 4. 增加门店名称[done]
3 后台用户 	| 完成 | 进行中 | 
4 课程规则 	| 完成 | 完成 | 
5 门店 		| 完成 | 完成 | 
6 课程分类 	| 完成 | 完成 | 
7 课程 		| 完成 | 进行中 | TODO：<br>1.index接受门店参数[done] <br> 2.增加课程分类名称，门店名称[done]
8 课程表  	| 进行中 | | 
9 训练  	| 进行中 | | 从客户进入
10 会员操作	| 进行中 | | 从客户进入
11 微信 	|  | |
12 报表 	|  | |




# 0. 概述

API按照Restful风格设计, 所有管理端的api放在admin/后面；所有微信端api放到weixin/后,基本都CRUD遵循下面的规范：

动作 | http METHOD | URI | Form-data Params
----|----|----|----
查询列表[index]：	|GET |http://domain.com/admin/resources|
查询一行[show]: |	GET| http://domain.com/admin/resources/id|
创建[create]: 	|	POST  |http://domain.com/admin/resources | 需要 如：resource[attributes]='value'
更新[update]: |		PUT | http://domain.com/admin/resources | 需要 如：resource[attributes]='value'
删除[destroy]: 	|	DELET |http://domain.com/admin/resources/id|


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
| 参数| customer[name]<br> * customer[mobile]<br> * customer[weixin]<br> customer[store_id]<br> * customer[membership_type]<br> customer[membership_remaining_times]<br> customer[membership_duedate]<br>--以上参数至少传一个。
消息：| 200: 更新成功 <br> 404:未找到资源 <br> 422: 验证没通过

> 成功后返回200，以及更新后的信息：






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


# 8 课程表 - schedule
# 9 训练 - training
# 10 会员操作 - operation
# 11 微信接口
# 12 报表接口
