---
title: Python3 学习
date: 2019-07-04 15:16:11
tags: 编程语言
---

本篇博客学习总结于[Python - 100天从新手到大师](https://github.com/jackfrued/Python-100-Days)

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

## 文件操作符

### python内置的 `open` 函数

操作模式|具体含义
:----:|:--------------------:
'r'|读取 （默认）
'w'|写入（会先截断之前的内容）
'x'|写入，如果文件已经存在会产生异常
'a'|追加，将内容写入到已有文件的末尾
'b'|二进制模式
't'|文本模式（默认）
'+'|更新（既可以读又可以写）

### python的`JSON`模块

常用的四个函数

+ dump - 将Python对象按照JSON格式序列化到文件中
+ dumps - 将Python对象处理成JSON格式的字符串
+ load - 将文件中的JSON数据反序列化成对象
+ loads - 将字符串的内容反序列化成Python对象

这里出现了两个概念，一个叫序列化，一个叫反序列化。自由的百科全书维基百科上对这两个概念是这样解释的：“序列化（serialization）在计算机科学的数据处理中，是指将数据结构或对象状态转换为可以存储或传输的形式，这样在需要的时候能够恢复到原先的状态，而且通过序列化的数据重新获取字节时，可以利用这些字节来产生原始对象的副本（拷贝）。与这个过程相反的动作，即从一系列字节中提取数据结构的操作，就是反序列化（deserialization）”。

### 实际操作

```python
#!/usr/local/bin/python3
"""
文件操作和异常处理及JSON数据
"""

import json


def read():
    """读取文件"""
    try:
        fs = open('a.txt', 'r', encoding='utf-8')
        print(fs.read())
    except FileNotFoundError:
        print('文件不存在')
    finally:
        if fs:
            fs.close()


def writh(cmd='w'):
    """写文件"""
    try:
        txt = (x for x in range(600, 1000))
        fs = open('b.txt', cmd, encoding='utf-8')
        for t in txt:
            fs.write(str(t) + '\n')
    except IOError:
        print('IO异常')
    finally:
        if fs:
            fs.close()


def with_def():
    """
    使用with关键字,指定文件对象的上下文环境并在离开上下文环境时自动释放文件资源
    """
    try:
        """一次读取所有文件"""
        with open('a.txt', 'r', encoding='utf-8') as f1:
            print(f1.read())

        """使用for-in逐行读取"""
        with open('a.txt', encoding='utf-8', mode='r') as f2:
            for line in f2:
                print(line, end='')
    except Exception:
        print('错误', Exception)


def buffer_file_def():
    """读取二进制文件(拷贝图片)"""
    try:
        """复制文件"""
        with open('/Users/aolei/Pictures/my images/32916897.jpg', mode='rb') as f:
            data = f.read()
            print(data)

        """粘贴到当前目录下"""
        with open('head.jpg', mode='wb') as f:
            f.write(data)
            print('Copy Success')
    except FileNotFoundError :
        print('文件不存在')
    except UnicodeEncodeError:
        print('编码异常')


def json_data_def():
    """python对json数据的处理"""
    myuser = {
        'name':'李黑',
        'sex': '男',
        'age': 0,
        'qq': 957658,
        'friends': ['王大锤', '白元芳'],
        'cars': [
            {'brand': 'BYD', 'max_speed': 180},
            {'brand': 'Audi', 'max_speed': 280},
            {'brand': 'Benz', 'max_speed': 320}
        ]
    }

    try:
        """将python字典对象序列化为json文件"""
        with open('users.json', 'w', encoding='utf-8') as f:
            json.dump(myuser, f)

        """将json文件反序列化为python字典对象"""
        with open('users.json', 'r', encoding = 'utf-8') as f:
            curr_user = json.load(f)
            print(curr_user)
    except IOError:
        print('文件写入失败')


if __name__ == "__main__":
    # read()
    # writh('a')
    # with_def()
    # buffer_file_def()
    json_data_def()
```

## 参考

[HTTP协议入门](http://www.ruanyifeng.com/blog/2016/08/http.html "阮一峰HTTP协议入门")

[聚合数据](https://www.juhe.cn/ "聚合数据")

[阿凡达数据](https://www.avatardata.cn/ "阿凡达数据")

## 结语

> Don't be one of the leeches.
