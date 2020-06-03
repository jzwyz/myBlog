---
title: electron 学习笔记
date: 2020-06-02 15:49:49
tags: electron
---

`Electron` 是一个用 `HTML，CSS` 和 `JavaScript` 来构建跨平台桌面应用程序的一个开源库

原理为 `Electron` 通过将 `Chromium` 和 `Node.js` 合并到同一个运行时环境中，并将其打包为 **Mac**，**Windows** 和 **Linux** 系统下的应用来实现这一目的。

[官网](https://www.electronjs.org/)

## 环境搭建

确保 `node` 和 `npm` 已经安装好了,

验证:

```sh
# 可以看到node的版本信息
node -v
# 可以看到npm的版本信息
npm -v
```

从开发的角度来看, Electron application 本质上是一个 Node. js 应用程序。 与 Node.js 模块相同，应用的入口是 package.json 文件

1. 使用 `npm` 创建一个 `nodejs` 项目

```sh
# 创建一个项目文件夹
mkdir myapp

# 进去
cd ./myapp

# npm初始化项目
npm init
```

## 最后
