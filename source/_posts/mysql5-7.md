---
title: mysql5.7学习笔记
date: 2019-06-05 17:00:05
tags: 数据库
---

这里主要记录日常使用mysql5.7的一些操作

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

## 结语

...