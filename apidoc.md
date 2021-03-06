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
2016-10-25 | 发布“课程表[按周操作](#8.8),查询，复制，删除“；“批量发布，取消发布课程表”
2016-10-26 | 修改批量操作bug；确认微信认证流程；写后端自动测试代码50%；
2016-10-27 | 写完后端测试代码并通过测试，代码覆盖率 96%；前端完成会员操作和课程表的对接；
2016-10-28 | 完成微信接口开发，测试，文档：11.1，11.2，11.3；前端继续对接训练相关接口；
2016-10-30 | 继续开发微信接口；前端发布系统到测试环境；
2016-10-31 | 调整微信预约接口，前端解决发布问题；
2016-11-1 | 发布微信课程预约接口：11.4-7 4个接口，前端微信登录验证对接成功；
2016-11-2 | 修改11.6, 加入验证会员卡信息；修改11.7, 时间卡会员预约时自动减去次卡一次；修改my_trainings,默认按课程开始时间倒序，增加分页；
2016-11-3 | 报告15个bug；
2016-11-4 | 修改了9个bug，确认关掉5个bug，另外4个仍有问题；另外增加了4个bug； 前端继续对接微信接口；
2016-11-5 | 无
2016-11-6 | 前端修改2个bug，微信登录验证仍然在对接中；问题：测试机页面经常打不开；
2016-11-7 | 后端：修改一个文档bug<br> 为11.3添加两个字段<br>前端：修改微信登录认证，模拟获取openid； <br>更改微信课程列表；<br>更改微信课程详情，11.6接口任然404；<br>测试获取微信openID，流程已模拟完成，因scope验证失败，暂未完成测试
2016-11-8  | 测试：新增10个，关闭9个bug；看板新增测试状态
2016-11-9 | 前端对接微信训练模块，后端修改接口文档小bug
2016-11-10 | 前端对接微信模块，后端优化数据库，加索引，从mysql更换到postgresql
2016-11-11 | 前端发布微信测试版本，以及改过bug后的管理系统；修改一个bug，把数据优化发布到测试环境中； <br>BUG统计：未关闭：15，已关闭：16。
2016-11-12 | 更新bug，有些问题改了但是仍然有问题,或者发布前没问题发布后出现问题；晚上跟柠檬对了一下，可能是缓存或者版本的问题，接下来柠檬会再检查一下；<br>BUG统计：<span style="color:red">未关闭：13，已关闭：20。</span>
2016-11-13 | 完成报表后端开发,12.1/12.2；<br>11.6 接口加入会员锁定判断，已锁会员is_membership_valid为false;<br>7.1 修改接口，增加是否Active参数；<br>2.1 修改接口，增加过滤 是否锁定 的参数；
2016-11-14 | 电话沟通报表接口；修改bug；<br>BUG统计：<span style="color:red">未关闭：10；已关闭：29</span>
2015-11-15 | 修改Schedule接口；<br>测试与改bug：<br>BUG统计：<span style="color:red">未关闭:8, 已关闭：36</span>
2015-11-16 | 基本功能测试结束，开始测试复杂业务逻辑；<br>BUG统计：<span style="color:red">未关闭:16, 已关闭：44（今日关闭8，新增16）</span>
2015-11-17 | 提交报表；修改bug；进入验收测试阶段；
2016-11-18 | 测试与修改Bug：BUG统计：<span style="color:red">未关闭:10, 已关闭：55（关闭11，新增5）</span>
2016-11-19 | 修改提示有关的bug；与罗超对测试结果，记录流程修改3条，UI调整10条，bug反馈10条；
2016-11-20 | 修改3个流程大改动；修改微信首页的logo效果；
2016-11-21 | 前端的流程改动完成；<br>复查罗超的bug清单，将未完成的提交到tower：<br>BUG统计：<span style="color:red">未关闭:18, 已关闭：63（关闭8，新增16）</span>
2016-11-22 | BUG统计：<span style="color:red">未关闭:8, 已关闭：80（关闭17，新增8）</span>
2016-11-23 | 准备验收测试文档，以及修改bug；
2016-11-24 | 晚上验收测试，发现7个问题，正在解决中；
2016-11-25 | 
2016-11-30 | 发布生产
2016-12-1 | 上线第一天，发现公众号没有配置，以及分页的问题；



模块  | 后端开发 | 前端对接 | 问题 | 测试通过
----|----|----|----|---
1 登录 		| 完成 | 完成 | 😄  | 👌
2 会员客户 	| 修改 | 完成 | 😄  | 👌
3 后台用户 	| 完成 | 完成 | 😄 | 👌
4 课程规则 	| 完成 | 完成 | 😄 | 👌
5 门店 		| 完成 | 完成 | 😄 | 👌
6 课程分类 	| 完成 | 完成 | 😄 | 👌
7 课程 		| 完成 | 完成 |  😄 | 👌
8 课程表  	| 完成 | 完成 | 😄 | 👌
9 训练  	| 完成 | 完成| 😄 | 👌
10 会员操作	| 完成 | 完成| 😄 | 👌
11.1-3 微信-登录与验证	| 完成 | 完成| 😄  | 👌
11.5-7 微信-课程预约	| 完成 | 完成 |😄 | 👌
11.4 微信-个人信息	| 完成| 完成 | 😄 | 👌
11.8 微信-预约查询，修改	| 完成| 完成| 😄 | 👌
12 报表 	| 完成 | 完成 | 😄 | 👌

需要注意的变化：
<div style='color:red'>
接口11.4， 增加课程统计的字段，用于显示在微信“我的资料”界面；
接口11.6， 增加两个字段，是否可取消，以及，如果可以取消，对应的training id；
  
</div>

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
URI |  /admin/session
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
URI | /admin/session
参数类型 | headers:{'x-api-token': [token]}
参数 | 无

<p id="2"/>
# 2 客户


## 2.1 获取客户列表

 | API说明
--------- | -----------
Method | GET
URI | /admin/stores/1/customers?locked=true&qstring=? <br>OR /admin/customers[?store_id=#][&qstring=?]
参数类型 | URL
参数 | store_id, 为空不过滤，否则按照门店过滤; <br>qstring, 如果不为空则搜索 name,weixin,mobile. <br>locked=true/false
消息 | 无

> 返回Jason:

>  "membership-type": "time_card", 时间卡
>  "membership-type": "measured_card", 次卡

```json

{
    "data": [
        {
            "id": "3",
            "type": "customers",
            "attributes": {
                "name": "chenxi",
                "mobile": "18011520426",
                "is-weixin-connected": true,
                "membership-type": "measured_card",
                "store-id": 1,
                "membership-remaining-times": -18,
                "membership-total-times": 20,
                "membership-duedate": "2016-12-31",
                "store-name": "中关村店",
                "is-locked": false
            }
        }
    ],
    "links": {},
    "meta": {
        "current-page": 1,
        "next-page": null,
        "prev-page": null,
        "total-pages": 1,
        "total-count": 1
    }
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
        "id": "3",
        "type": "customers",
        "attributes": {
            "name": "chenxi",
            "mobile": "18011520426",
            "is-weixin-connected": true,
            "membership-type": "measured_card",
            "store-id": 1,
            "membership-remaining-times": -18,
            "membership-total-times": 20,
            "membership-duedate": "2016-12-31",
            "store-name": "中关村店",
            "is-locked": false
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
| 参数| customer[name]:必填，不重复 <br> customer[mobile]:必填，不重复  <br> customer[weixin]:必填，不重复 <br> customer[store_id]: 必填，store必须存在。 <br> customer[membership_type] 必填, <br> ---'measured_card' 表示次卡，'time_card' 表示时间卡 <br> customer[membership_total_times]: 客户总次数；前端校验，如果是次卡则必填； <br> customer[membership_duedate]: 前端校验，如果是时间卡则必填； <br>



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
| 参数| customer[name]<br> customer[mobile]<br> customer[weixin]<br> customer[store_id]<br> customer[membership_type]<br> customer[membership_total_times]<br> customer[membership_duedate]<br>--以上参数至少传一个。
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
| 参数| user[full_name]: 不能重复, 不能为空 <br> user[password]
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
cancel_limit_minutes | 课程允许取消时间（分钟）|课程开始前？分钟，客户可以取消预约，可以自动排队
queue_limit_number| 允许排队人数（个）| 允许排队的人数（所有课程有效）
booking_limit_minutes | 课程允许预约时间（分钟）|课程开始前？分钟，客户可以预约。


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
        "key": "cancel_limit_minutes",
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
消息 | 404: 没有找到


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
URI |  /admin/stores/1/courses?status=active 或者 /admin/courses?store_id=1&status=active
参数类型 | URL
参数 | store_id, 为空不过滤，否则按照门店过滤, status= active/inactive；


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

> 返回 404: 如果from_week 没有数据：

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


<p id="8.8"/>
## 8.8 按周删除课程表
 | API说明
--------- | -----------
|  Method| DELETE
|  URI|  /admin/stores/[store_id]/schedules_by_week/[id]
|  参数类型| URL
| 参数| [store_id]: 门店id，必填； <br>[id]: 格式为 %y-%m-%d, 输入任意日期，返回这周的课程表；
| 消息：| 204, 422, 409, 404

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

> 返回 404: 如果from_week 没有数据：

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

## 8.9 发布一周课程表
 | API说明
--------- | -----------
|  Method| POST
|  URI|  /admin/stores/[store_id]/schedules_by_week/[id]/publish_all
|  参数类型| URL
| 参数| [store_id]: 门店id，必填； <br>[id]: 格式为 %y-%m-%d, 输入任意日期，进入这周的课程表；
| 消息：| 204:成功， 422:参数错误, , 404: 没有找到


## 8.10 取消发布一周课程表
 | API说明
--------- | -----------
|  Method| POST
|  URI|  /admin/stores/[store_id]/schedules_by_week/[id]/unpublish_all
|  参数类型| URL
| 参数| [store_id]: 门店id，必填； <br>[id]: 格式为 %y-%m-%d, 输入任意日期，进入这周的课程表；
| 消息：| 204:成功， 422:参数错误, 404: 没有找到， 409: 如果课程表已经关联了training，则不允许取消发布；


<p id="9"/>
# 9 训练 - training
# 9 训练
参数名 | 说明  | 类型| 约束 |
----|----|----|----|----
 training[schedule_id]  | 课程表id    |int    | 必填 |schedule必须存在
 training[customer_id]  | 客户id    |int    | 必填 | customer必须存在
 training[booking_status]   | 预定状态 | enum   | 必填 | no_booking:未预定，由管理员直接创建；<br> booked: 已预定；<br>waiting: 排队中；
 training[training_status]   | 训练状态 | enum   | 必填 | normal: 正常, <br> absence: 缺席,<br> be_late: 迟到
 training[customer_name]   | 客户名称  | string  | 只读  | 来自cusrtomer
 training[start_time] | 开始时间    |datetime    | 只读 | 来自schedule
 training[end_time]   | 结束时间 | datetime   | 只读| 来自schedule
 training[store_id]   | 门店id  | int  | 必填  | 来自schedule
 training[store_name]   | 门店名称  | string  | 只读  | 来自schedule
 training[course_id]  | 课程id    |int    | 只读 | 来自schedule
 training[course_name]   | 课程名称  | string  | 只读  |来自schedule
 training[created_at] | 创建时间 | int | 自动修改 |
 training[updated_at] | 更新时间| int | 自动修改 |
 training[readable-status] | 可直接显示在界面的训练的状态， | string | 只读 | 状态说明如下
 training[cancelable] | 是否可取消（显示取消按钮） | boolean| 只读 |

>>状态说明：
```ruby
def readable_status
     if schedule.time_stage == 'finished'
        return '课程已完成' if normal? && !waiting?
        return '排队失败' if normal? && waiting?
        return '课程迟到' if be_late?
        return '缺席' if absence?
        return '数据错误'
      elsif schedule.time_stage == 'ongoing'
        return '排队失败' if waiting?
        return '课程进行中'
      else #not_started
        return '您已预约' if booked?
        return '您已排队' if waiting?
        return '门店已帮你预约' if no_booking?
        return '数据错误'
    end
```
>1. 客户预约
> 1.1. 如果容量未满： booking_status: booked ; training_status: not_start;
> 1.2. 如果容量已满： booking_status: waiting ; training_status: not_start;
> 1.3. 如果有人取消，或者管理员操作‘确认排队’： booking_status: booked ; training_status: not_start;

>2. 客户取消预约：删除训练

>3. 课程结束，管理员签到
>  3.1 如果预约的客户完成训练：booking_status: booked/no_booking ; training_status: normal;
>  3.2 如果预约的客户缺席训练：booking_status: booked/no_booking ; training_status: absence;
>  3.3 如果预约的客户迟到：    booking_status: booked/no_booking ; training_status: be_late;
> 3.4 如果由未预约的客户参加训练： booking_status: no_booking; training_status: normal;

## 9.1 获取训练列表

 | API说明
--------- | -----------
Method | GET
URI |  /admin/trainings?[store_id=1]&[customer_id=#]<br> 或 /admin/store/[store_id]/trainings <br>或 /admin/schedules/[schedule_id]/trainings
参数类型 | URL
参数 | store_id: 按照门店获取，<br>customer_id: 按照customer_id获取
消息 | 200， 404

> 返回Jason:

```json

{
"data": [
        {
            "id": "9",
            "type": "trainings",
            "attributes": {
                "store-id": 1,
                "store-name": "中关村店",
                "customer-id": 3,
                "customer-name": "chenxi",
                "schedule-id": 32,
                "start-time": "2016-11-26T14:00:00.000Z",
                "end-time": "2016-11-26T15:00:00.000Z",
                "course-id": 2,
                "course-name": "测试课程2",
                "booking-status": "waiting",
                "training-status": "normal",
                "cancelable": true,
                "created-at": "2016-11-12T17:14:44.308Z",
                "readable-status": "您已排队",
                "updated-at": "2016-11-12T17:14:44.308Z"
            }
        },
        {
            "id": "13",
            "type": "trainings",
            "attributes": {
                "store-id": 1,
                "store-name": "中关村店",
                "customer-id": 3,
                "customer-name": "chenxi",
                "schedule-id": 36,
                "start-time": "2016-11-22T14:00:00.000Z",
                "end-time": "2016-11-22T15:00:00.000Z",
                "course-id": 2,
                "course-name": "测试课程2",
                "booking-status": "booked",
                "training-status": "normal",
                "cancelable": true,
                "created-at": "2016-11-12T17:14:44.351Z",
                "readable-status": "您已预约",
                "updated-at": "2016-11-12T17:14:44.351Z"
            }
           },
```

## 9.2 取消训练
同9.5

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
> "detail": "has already been taken"  => 不能重复(同一schedule 同一个customer 只能有一条training)
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
URI |  /admin/customers/[:customer_id]/operations <br>或：/admin/users/[:users_id]/operations
参数类型 | URL
参数 | customer_id， user_id
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
                "description": "系统用户: 'admin'修改了客户:'李四', 会员类型： 'time_card', 会员到期时间:'2017-01-31', 会员卡次数:'20' ",
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
微信登录流程：

1. 客户从公众号里打开“预约课程”
2. 验证：如果客户的openid已经被关联在系统中，验证成功，则后端返回客户Token，用token访问其它接口；
3. 注册：如果客户openid没有找到，则提示404，前端可以引导用户“请输入手机号”，系统将匹配手机号，如果找到（由管理员在后台输入过），则系统登记openid，同时通过验证；如果手机号没有匹配到，返回404，前台可以提示客户“请先成为会员再预约课程”，并提供给客户门店联系方式；



## 11.1 客户验证
 | API说明
--------- | -----------
Method | POST
URI |  /weixin/session
参数类型 | from-data
参数 | :openid
消息 | 200:验证成功，返回token； <br>404: 没有找到该openid。建议重定向引导用户用填写手机号进行注册；

>成功后返回客户Token, 以下所有接口都需要把token放入 header的‘x-api-key’中；

```json
{
    "data": {
        "id": "1",
        "type": "customers",
        "attributes": {
            "weixin": "wx123456",
            "token": "QXXmKYPeWiwarpwHNSLc3v5J"
        }
    }
}
```

## 11.2 客户注册

 | API说明
--------- | -----------
Method | POST
URI |  /weixin/register
参数类型 | form-data
参数 | mobile: ""， openid: ""
消息 | 200:如果匹配，则总是返回更新后的customer信息 （同11.1）； <br>404:如果没有匹配到手机号；<br>409:如果查询的手机号已经有openid存在，建议前端提示“此手机号已经绑定了另一个微信号，如果您更换了微信号，请与我们门店联系！” <br>400: 如果传入的参数不包含 openid 和 mobile；



## 11.3 按天获取课程表列表
 | API说明
--------- | -----------
Method | Get
URI |  /weixin/my_schedules[/%y-%m-%d]
参数类型 | URL； 注意，2016-01-01 不要写成 2016-1-1 !!!
参数 | 日期；返回为schdeules的列表，满足几个条件：<br>1.当前用户所属store <br>2.管理员设置“课程规则”“course_view_days”日期的内；<br>3.课程 is_published = true <br>4.日期，给出日期则显示这天的课程，如果不给出，默认为当天；
消息 | 总是返回200，如果没有符合条件的课程则结果为空；


```json
{
    "data": [
        {
            "id": "4539",
            "type": "schedules",
            "attributes": {
                "store-id": 2,
                "store-name": "大望路店",
                "course-id": 2,
                "course-name": "上肢训练",
                "start-time": "2016-10-28T10:00:00.000Z",
                "end-time": "2016-10-28T11:00:00.000Z",
                "capacity": 10,
                "is-published": false,
                "updated-at": "2016-10-28T08:43:06.000Z",
                "booked-number": 0
            }
        }
    ]
}

```
## 11.4 我的个人资料

 | API说明
--------- | -----------
Method | Get
URI |  /weixin/my_info
参数类型 |
参数 | 无
消息 | 返回200，返回当前登录用户的个人信息

```json
{
    "data": {
        "id": "3",
        "type": "customers",
        "attributes": {
            "name": "chenxi",
            "mobile": "18011520426",
            "is-weixin-connected": true,
            "membership-type": "measured_card",
            "store-id": 1,
            "membership-remaining-times": -15,
            "membership-total-times": 20,
            "membership-duedate": "2016-12-31",
            "store-name": "中关村店",
            "is-locked": false,
            "weixin": "aasdfjasdf",
            "token": "DvX5EUWwVFGN48VA68tBNLyk",
            "booked-number": 51,
            "booked-and-not-started-number": 32,
            "booked-and-complete-number": 14,
            "booked-and-be-late-number": 0,
            "booked-and-absence-number": 5
        }
    }
}

```


## 11.5 查看一门课程详情
 | API说明
--------- | -----------
Method | Get
URI |  /weixin/schedules/[schedule_id]
参数类型 | URL
参数 | 参数为课程表id，课程必须为当前用户的课程
消息 | 200：参数正确返回schedule Json， 404:没有找到课程, 403: 用户无权限访问这个课程；


## 11.6 获取某课程可操作性
 | API说明
--------- | -----------
Method | Get
URI |  http://{{sitename}}/weixin/schedules/1137/schedule_operations
参数类型 | URL
参数 | 参数为课程表id
消息 | 200：参数正确返回操作性Json， 404:没有找到课程，403:用户无权访问（没有发布的课程不能访问，不在同一个门店的课程不能访问，不在可视范围内的课程不能访问）；

页面显示建议：

* 如果xxxable有true：
  - “bookable:true”: 显示“预约”按钮
  - “waitable:true”: 显示“排队”按钮
  - “cancelable: true" 显示“取消”按钮，
  		- “booking-status:waiting”,显示"取消排队"
  		- “booking-status:其它”,显示"取消预约"
  - “bookable:false, waitable:false，cancelabe：false“: 显示原因：schedule-reject-msg
  
* 如果显示的 is_membership_valid 是false，则在用户点击按钮后提示错误原因：customer-reject-msg

> schedule_reject_msg:可能的值
  '你已经预约过该课程！'
  '课程还未开放预约！'
  "课程已经无法预约！"
  "报名人数已满，下次早点来哦！"

> customer_reject_msg:可能的值
您的会员卡已被锁定！
您的会员卡已经到期！
您的已经没有可用的预约次数了！

> 返回某个课程表项目对于当前用户的可操作性：
```json
{
    "data": {
        "id": "14_3",
        "type": "schedule-operations",
        "attributes": {
            "schedule-id": 14,
            "bookable": false,
            "waitable": false,
            "cancelable": false, 	//是否可取消，
            "cancel-id": -1,  	//如果可以取消，对应的training-id，如果不可以，给-1
            "booking-status": "booked",
            "schedule-reject-msg": "你已经预约过该课程！",
            "customer-id": 3,
            "is-membership-valid": false,
            "customer-is-locked": false,
            "customer-membership-type": "measured_card",
            "customer-duedate": "2016-12-31",
            "customer-remainming-times": -15,
            "customer-reject-msg": "您的已经没有可用的预约次数了！"
        }
    }
}

```

## 11.7 预约（排队）课程
 | API说明
--------- | -----------
Method | POST
URI |  /weixin/schedules/[schedule_id]/booking
参数类型 | URL
参数 | 参数为课程表id
消息 | 200：参数正确返回操作性Json，404:没有找到课程，403:用户无权访问；409: 如果创建时发现课程或者客户权限不可用，则返回schduele_operation json:

* 预约和排队都是这个接口，后台会自动判断创建“预约”还是“排队”
* 操作会返回一个operation json, 无论是200还是409：

```json
{
    "data": {
        "id": "16_3",
        "type": "schedule-operations",
        "attributes": {
            "schedule-id": 16,
            "bookable": false,
            "waitable": false,
            "booking-status": "booked",
            "schedule-reject-msg": "你已经预约过该课程！",
            "customer-id": 3,
            "is-membership-valid": false,
            "customer-is-locked": false,
            "customer-membership-type": "measured_card",
            "customer-duedate": "2016-12-31",
            "customer-remainming-times": -18,
            "customer-reject-msg": "您的已经没有可用的预约次数了！"
        }
    }
}
```


## 11.8 我的训练列表

 | API说明
--------- | -----------
Method | Get
URI |  /weixin/my_trainings/[param]
参数类型 | URL
参数 | 1.有[分页] (#0) <br>2.建议默认为all；<br>3.参数取值可以为：["no_booking", "booked", "waiting", "waiting_confirmed", "cancelled", "not_start", "absence", "be_late", "complete", "all"]，<br>--搜索范围是该登录用户所有的training记录。<br>
消息 | 200：参数正确返回查询列表， 400:参数在列表之外；

- 状态显示：直接显示 readable-status
- （cancelable=true，booking-status:waiting） 显示取消"取消排队"按钮；
- （cancelable=true，booking-status:其它） 显示取消"取消预约"按钮；

```json
{
"data": [
        {
            "id": "9",
            "type": "trainings",
            "attributes": {
                "store-id": 1,
                "store-name": "中关村店",
                "customer-id": 3,
                "customer-name": "chenxi",
                "schedule-id": 32,
                "start-time": "2016-11-26T14:00:00.000Z",
                "end-time": "2016-11-26T15:00:00.000Z",
                "course-id": 2,
                "course-name": "测试课程2",
                "booking-status": "waiting",
                "training-status": "normal",
                "cancelable": true,
                "created-at": "2016-11-12T17:14:44.308Z",
                "readable-status": "您已排队",
                "updated-at": "2016-11-12T17:14:44.308Z"
            }
        },
        {
            "id": "13",
            "type": "trainings",
            "attributes": {
                "store-id": 1,
                "store-name": "中关村店",
                "customer-id": 3,
                "customer-name": "chenxi",
                "schedule-id": 36,
                "start-time": "2016-11-22T14:00:00.000Z",
                "end-time": "2016-11-22T15:00:00.000Z",
                "course-id": 2,
                "course-name": "测试课程2",
                "booking-status": "booked",
                "training-status": "normal",
                "cancelable": true,
                "created-at": "2016-11-12T17:14:44.351Z",
                "readable-status": "您已预约",
                "updated-at": "2016-11-12T17:14:44.351Z"
            }
        }
    }
}

```
## 11.9 查看训练详情

 | API说明
--------- | -----------
Method | Get
URI |  /weixin/my_trainings/[training_id]
参数类型 | URL
参数 | 训练
消息 | 200：参数正确返回查询列表， 400:参数在列表之外；


## 11.10 取消训练

 | API说明
--------- | -----------
Method | DELETE
URI |  /weixin/trainings/[training_id]
参数类型 | URL
参数 |  training_id
消息 | 204：取消（删除）成功， 404:没找到； 409: 不允许取消训练（cancel_limit_minutes）




<p id="12"/>
# 12 报表接口
## 12.1 客户报表

 | API说明
--------- | -----------
Method | GET
URI |  http://{{sitename}}/admin/customer_report?from_date=2016-11-07&to_date=2016-11-20&store_id=1
参数类型 | URL,
参数 | store_id/from_date/to_date, 可以一个或着全部为空；
消息 | 200：参数正确返回查询列表
> 200将会返回json
> 一个客户一行，后面的统计根据所选时间范围计算；

```json
{
    "data": [
        {
            "id": "3",
            "type": "customer-reports",
            "attributes": {
                "customer-name": "chenxi",
                "store-name": "中关村店",
                "from-date": null,
                "to-date": null,
                "count-of-valid-booking": 18,
                "count-of-absence": 5,
                "count-of-complete": 13,
                "count-of-be-late": 0,
                "favorite-time-slots": "14:11~15:11,18 10:11~11:11,17 16:11~17:11,17",
                "favarite-courses": "测试课程2:22,测试课程3:21,测试课程1:21"
            }
        }
    ]
}
```

## 12.2 课程报表

 | API说明
--------- | -----------
Method | GET
URI |  http://{{sitename}}/admin/course_report?from_date=2016-11-07&to_date=2016-11-20
参数类型 | URL,
参数 | store_id/from_date/to_date, 可以一个或着全部为空；
消息 | 200：参数正确返回查询列表
> 200将会返回json
> 一个课程一行，后面的统计根据所选时间范围计算；

```json
{
    "data": [
        {
            "id": "1",
            "type": "course-reports",
            "attributes": {
                "course-name": "测试课程1",
                "course-type": "基础课程",
                "store-name": "中关村店",
                "from-date": null,
                "to-date": null,
                "total-capacity": 80,
                "count-of-valid-booking": 6,
                "count-of-absence": 2,
                "count-of-complete": 4,
                "count-of-be-late": 0
            }
        },
        {
            "id": "2",
            "type": "course-reports",
            "attributes": {
                "course-name": "测试课程2",
                "course-type": "基础课程",
                "store-name": "中关村店",
                "from-date": null,
                "to-date": null,
                "total-capacity": 80,
                "count-of-valid-booking": 7,
                "count-of-absence": 2,
                "count-of-complete": 5,
                "count-of-be-late": 0
            }
        },
        {
            "id": "3",
            "type": "course-reports",
            "attributes": {
                "course-name": "测试课程3",
                "course-type": "基础课程",
                "store-name": "中关村店",
                "from-date": null,
                "to-date": null,
                "total-capacity": 70,
                "count-of-valid-booking": 5,
                "count-of-absence": 1,
                "count-of-complete": 4,
                "count-of-be-late": 0
            }
        }
    ]
}
```

