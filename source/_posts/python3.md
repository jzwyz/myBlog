---
title: python3 学习
date: 2019-07-04 15:16:11
tags:
---

本篇博客学习总结于[jackfrued/Python-100-Days](https://github.com/jackfrued/Python-100-Days)

## Python是一个“优雅”、“明确”、“简单”的编程语言

给初学者的建议:

1. Make English as your working language.
2. Practice makes perfect.
3. All experience comes from mistakes.
4. Don't be one of the leeches.
5. Either stand out or kicked out.

## Python基础数据类型

1. 整数
2. 字符串
3. 浮点数
4. True/False
5. None

## Python数据结构

1. List（列表）: 数组
2. Tuple（元组）: 不可修改列表
3. Set（集合）: 同数学中的集合, 不可重复, 可以技术 交集、并集、差集等运算
4. Dictionary（字典）: 每一个元素都是由 “键值对” 组成


## 字符串格式化代码

参数|说明
:----:|:----------------------------:
%%|百分号标记
%c|字符及其ASCII码
%s|字符串
%d|有符号整数(十进制)
%u|无符号整数(十进制)
%o|无符号整数(八进制)
%x|无符号整数(十六进制)
%X|无符号整数(十六进制大写字符)
%e|浮点数字(科学计数法)
%E|浮点数字(科学计数法，用E代替e)
%f|浮点数字(用小数点符号)
%g|浮点数字(根据值的大小采用%e或%f)
%G|浮点数字(类似于%g)
%p|指针(用十六进制打印值的内存地址)
%n|存储输出字符的数量放进参数列表的下一个变量中

## 算术运算符

运算符|描述|实例
:------:|:--------------------:|:----------:
+|加 - 两个对象相加|a + b 输出结果 31
-|减 - 得到负数或是一个数减去另一个数|a - b 输出结果 -11
*|乘 - 两个数相乘或是返回一个被重复若干次的字符串|a * b 输出结果 210
/|除 - x 除以 y|b / a 输出结果 2.1
%|取模 - 返回除法的余数|b % a 输出结果 1
**|幂 - 返回x的y次幂|a**b 为10的21次方
//|取整除 - 向下取接近除数的整数|9//2 = 4; -9//2 = -5

## 特殊运算符

运算符|描述
:-----:|:--------------------:
&|在set求交集的时候,同set1.intersection(set2)
\||在set求并集的时候,同set1.union(set2)
-|在set求差集的时候,同set1.difference(set2)
^|在set求对称差的时候,同set1.symmetric_difference(set2)
