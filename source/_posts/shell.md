---
title: Shell学习笔记
date: 2019-06-18 10:55:39
tags: 脚本语言
---

Shell 是一个用 C 语言编写的程序，它是用户使用 Linux 的桥梁

Shell 编程跟 java、php 编程一样，只要有一个能编写代码¸的文本编辑器和一个能解释执行的脚本解释器就可以了。

## 开始

### 创建脚本文件

新建一个扩展名为`.sh`的文件`test.sh`, sh代表*shell*

test.sh文件内容如下:

```sh
#!/bin/bash
echo "Hello Shell"
```

> `#!` 是一个约定俗成的标记, 用于告诉系统使用哪个解释器来执行这个脚本.  
> `echo` 命令是用于向终端输出文本信息,也可用于向文件中写入数据

### 运行shell脚本

运行shell脚本的方式两种

+ 通过可执行文件运行

需要给脚本文件添加可执行权限

```sh
# 在 test.sh 文件所在的文件夹下, 执行以下命令
chmod +x ./test.sh
```

> 这里需要注意的是, 一定要写成`./test.sh`而不是`test.sh`, 否责系统可能会找不到脚本文件, `./`的意思是 指定在当前文件路径下查找文件

+ 作为解释器参数

```sh
/bin/sh test.sh
/bin/php test.php
```

> 这种方式下,在文件第一行添加*标记*也没有效果(因为你已经指定了解释器来运行脚本)

## 变量

规则:

1. 定义变量时，变量名不加美元符号
2. 变量名和等号之间不能有空格
3. 命名只能使用英文字母，数字和下划线，首个字符不能以数字开头。
4. 中间不能有空格，可以使用下划线（_）。
5. 不能使用标点符号。
6. 不能使用bash里的关键字（可用help命令查看保留关键字）。

示例:

有效命名:

```sh
RUNOOB
LD_LIBRARY_PATH
_var
var2
```

无效命名:

```sh
?var=123
user*name=runoob
```

显示赋值

`your_name="runoob.com"`

通过语句赋值

```sh
for file in `ls /etc`
# 或
for file in $(ls /etc)
```

> 以上语句, 列出`/etc`路径下的所有文件名,赋值给`file`

### 使用变量

使用变量,只需要在变量前面加一个`$`符号

```sh
name="shell"
echo $name
echo ${name}
```

`$name`和`${name}`都是可以的, `{}`是可选的, 它的作用是帮助解释器来识别变量边界的, 比如:

```sh
for skill in Ada Coffe Action Java; do
    echo "I am good at ${skill}Script"
done
```

如果不加 `{}` 则解释器认为`$skillScript`是一个变量(内容为空),

>> 推荐给所有的变量加上`{}`,养成好的编程习惯

### 只读变量

已经定义的变量可以被重新赋值, **只读变量**除外

定义方式为: 在变量前面加上 `readonly`

```sh
readonly name="Shell"
name="jason" # 这里会报错  error: NAME: This variable is read only.
```

### 删除变量

```sh
unset name
```

> unset 命令不能删除只读变量。 删除之后不能使用

## 参考

[菜鸟教程](https://www.runoob.com/linux/linux-shell.html "Linux Shell教程")

## 结语

学习一门技术, 开始的时候不要纠结各种看不懂的语法、不钻牛角尖, 先培养兴趣, 再循序渐进.
