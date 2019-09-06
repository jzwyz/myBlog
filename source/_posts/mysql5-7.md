---
title: mysql学习笔记
date: 2019-06-05 17:00:05
tags: 数据库
---

这篇文章主要是我日常使用mysql的一些记录
我使用的mysql版本是:`5.7`

## 用户

### 创建用户

```sh
create user 'testuser'@'%' identified by 'password';
```

创建 `testuser` 用户, 可以在所有主机上登陆使用, 密码为`password`;

1. testuser 是创建的用户名
2. % 是主机名,指定哪些主机可以使用改用户
   1. %/0.0.0.0 所有主机可以使用
   2. localhost/127.0.0.1 本机可以使用
   3. ...
3. password 是创建的用户登陆密码, 如果指定为 `identified by ''` 则不设置密码

### 删除用户

```sh
drop user 'apollo'@'%';
```

### 用户权限

#### 授予权限

```sh
grant all on testdb.* to 'testuser'@'%';
grant select on testdb.* to 'testuser'@'%';
grant insert on testdb.* to 'testuser'@'%';
```

授予用户`testuser`在所有主机上使用`testdb`数据库下**所有表**的权限

+ all 代表权限
  + select 查询权限
  + insert 插入权限
  + delete 删除权限
  + update 修改权限
+ testdb.* 改数据库下的所有表
+ 'testuser'@'%' 表示`testuser`在`%`主机可以使用授予的权限

#### 刷新权限

`flush privileges;`

#### 删除权限

```sh
REVOKE ALL ON test.* FROM 'testuser'@'%';
REVOKE select ON test.* FROM 'testuser'@'%';
REVOKE insert ON test.* FROM 'testuser'@'%';
```

+ 删除所有权限
+ 删除查询权限
+ 删除插入权限

#### 查看用户权限

`SHOW GRANTS FOR 'testuser'@'%';`

## 数据库

### 基本语法

#### 函数

##### 类型转换函数

用于类型转化 CAST()和CONVERT()

```sh
CAST(value as type);
CONVERT(value, type);
```

可以转换的类型是有限制的。这个类型可以是以下值其中的一个：

+ 二进制，同带binary前缀的效果 : BINARY
+ 字符型，可带参数 : CHAR()
+ 日期 : DATE
+ 时间: TIME
+ 日期时间型 : DATETIME
+ 浮点数 : DECIMAL
+ 整数 : SIGNED
+ 无符号整数 : UNSIGNED

示例:

```sh
# 1
mysql> SELECT CONVERT('23',SIGNED);
+----------------------+
| CONVERT('23',SIGNED) |
+----------------------+
|                   23 |
+----------------------+
1 row in set

# 2
mysql> SELECT CAST('125e342.83' AS signed);
+------------------------------+
| CAST('125e342.83' AS signed) |
+------------------------------+
|                          125 |
+------------------------------+
1 row in set

# 3
mysql> SELECT CAST('3.35' AS signed);
+------------------------+
| CAST('3.35' AS signed) |
+------------------------+
|                      3 |
+------------------------+
1 row in set
```

##### 格式化函数

##### 随机数 rand()

```sh
select rand()
```

#### 时间

##### 获取系统时间 `now()` 和 `sysdate()` 这两个函数的区别是, `now()`在执行前就确认了值, `sysdate()`在执行时动态确认值

例子:

```sh
> select now(), sleep(3), now();
> select sysdate(), sleep(3), sysdate();
```

> 感兴趣的可以看一下这两天sql执行的结果

##### 获得当前时间戳函数：current_timestamp, current_timestamp()

语法: `select current_timestamp, current_timestamp()`

##### 日期、时间转换

时间转换为字符串 date_format(date,format), time_format(time,format)

时间格式化函数 DATE_FORMAT(date, format)

1. date 时间
2. format 参数格式有

参数|说明
:----:|:-----------------------:
%a|缩写星期名
%b|缩写月名
%c|月，数值
%D|带有英文前缀的月中的天
%d|月的天，数值(00-31)
%e|月的天，数值(0-31)
%f|微秒
%H|小时 (00-23)
%h|小时 (01-12)
%I|小时 (01-12)
%i|分钟，数值(00-59)
%j|年的天 (001-366)
%k|小时 (0-23)
%l|小时 (1-12)
%M|月名
%m|月，数值(00-12)
%p|AM 或 PM
%r|时间，12-小时（hh:mm:ss AM 或 PM）
%S|秒(00-59)
%s|秒(00-59)
%T|时间, 24-小时 (hh:mm:ss)
%U|周 (00-53) 星期日是一周的第一天
%u|周 (00-53) 星期一是一周的第一天
%V|周 (01-53) 星期日是一周的第一天，与 %X 使用
%v|周 (01-53) 星期一是一周的第一天，与 %x 使用
%W|星期名
%w|周的天 （0=星期日, 6=星期六）
%X|年，其中的星期日是周的第一天，4 位，与 %V 使用
%x|年，其中的星期一是周的第一天，4 位，与 %v 使用
%Y|年，4 位
%y|年，2 位

字符串转换为时间 str_to_date(str, format)

(日期、天数）转换函数：to_days(date), from_days(days)

(时间、秒）转换函数：time_to_sec(time), sec_to_time(seconds)

拼凑日期、时间函数：makdedate(year,dayofyear), maketime(hour,minute,second)

Unix 时间戳、日期）转换函数

1. unix_timestamp(),
2. unix_timestamp(date),
3. from_unixtime(unix_timestamp),
4. from_unixtime(unix_timestamp,format)
   1. 格式化函数 FROM_UNIXTIME(unix_timestamp, [format])
   2. unix_timestamp 一般为10位的时间戳，如:1417363200
   3. format *可选* 转换之后的时间字符串显示的格式;

##### 日期时间计算函数

增加一个时间间隔：date_add(date,INTERVAL expr type)

+ date 要操作的时间
+ expr 要添加的时间间隔
+ type 参考下表

type的值|
|:----------:|
MICROSECOND|
SECOND|
MINUTE|
HOUR|
DAY|
WEEK|
MONTH|
QUARTER|
YEAR|
SECOND_MICROSECOND|
MINUTE_MICROSECOND|
MINUTE_SECOND|
HOUR_MICROSECOND|
HOUR_SECOND|
HOUR_MINUTE|
DAY_MICROSECOND|
DAY_SECOND|
DAY_MINUTE|
DAY_HOUR|
YEAR_MONTH|

> adddate(), addtime()函数，可以用 date_add() 来替代

日期减去一个时间间隔：DATE_SUB(date,INTERVAL expr type)

> DATE_SUB(date,INTERVAL expr type) 日期时间函数 和 date_add() 用法一致

日期、时间相减函数：datediff(date1,date2), timediff(time1,time2)

1. datediff 返回天数差距
2. timediff 返回time差距

> 注意：timediff(time1,time2) 函数的两个参数类型必须相同。

时间戳（timestamp）转换、增、减函数

1. timestamp(date) -- date to timestamp
2. timestamp(dt,time) -- dt + time
3. timestampadd(unit,interval,datetime_expr) --
4. timestampdiff(unit,datetime_expr1,datetime_expr2) --

示例:

```sh
select timestamp('2008-08-08'); -- 2008-08-08 00:00:00
select timestamp('2008-08-08 08:00:00', '01:01:01'); -- 2008-08-08 09:01:01
select timestamp('2008-08-08 08:00:00', '10 01:01:01'); -- 2008-08-18 09:01:01

select timestampadd(day, 1, '2008-08-08 08:00:00'); -- 2008-08-09 08:00:00
select date_add('2008-08-08 08:00:00', interval 1 day); -- 2008-08-09 08:00:00

timestampadd() 函数类似于 date_add()。
select timestampdiff(year,'2002-05-01','2001-01-01'); -- -1
select timestampdiff(day ,'2002-05-01','2001-01-01'); -- -485
select timestampdiff(hour,'2008-08-08 12:00:00','2008-08-08 00:00:00'); -- -12

select datediff('2008-08-08 12:00:00', '2008-08-01 00:00:00'); -- 7
```

> timestampdiff() 函数就比 datediff() 功能强多了，datediff() 只能计算两个日期（date）之间相差的天数。

时区（timezone）转换函数

```sh
convert_tz(dt,from_tz,to_tz)

select convert_tz('2008-08-08 12:00:00', '+08:00', '+00:00'); -- 2008-08-08 04:00:00
```

> 时区转换也可以通过 date_add, date_sub, timestampadd 来实现

## 相关链接

[MySQL CAST与CONVERT 函数的用法](https://www.cnblogs.com/chenqionghe/p/4675844.html)

[MySQL 日期格式](https://www.cnblogs.com/dest/p/4205371.html)

## 结语

每天都要去折腾才能进步
