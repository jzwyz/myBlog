---
title: GraphQL 学习
date: 2019-10-22 16:52:00
tags: API
---

GraphQL 既是一种用于 API 的查询语言也是一个满足你数据查询的运行时。 GraphQL 对你的 API 中的数据提供了一套易于理解的完整描述，使得客户端能够准确地获得它需要的数据，而且没有任何冗余，也让 API 更容易地随着时间推移而演进，还能用于构建强大的开发者工具。

[官网文档](https://www.apollographql.com/docs/apollo-server)

## 入门

这里使用 nodejs 来创建demo, 使用到的npm包如下:

1. fastify
2. apollo-server-fastify

### 定义GraphQL 模型

```typescript
import { gql } from 'apollo-server-core';

const typeDefs = gql`
    # 自定义 类型
    scalar Date

    # 自定义一个模型
    type Book {
        title: String
        author: String
        sex: String
    }
    ...

    # 定义输入模型
    input BookForm {
        title: String!
        author: String!
        sex: String!
    }

    # Query 定义查询的方法
    type Query {
        # 查询所以 books 的方法
        getBooks: [Book]
    }

    # Mutation 定义更新的方法
    type Mutation {
        addBook(book: BookForm): Boolean
    }
`
```

1. 自定义类型用 `scalar` 标注
2. 自定义模型用 `type` 标注
3. 输入模型用 `input` 标注 (与模型的唯一区别是 关键字不同)

> Query 和 Mutation 是GraphQL内的两个特殊模型, 我们在这里定义 *查询* 和 *更新* 及返回类型, typeDefs中只能各存在一个.

### 定义GraphQL的 resolver

```typescript
    const resolvers = {
        Query: {
            // Query中实现typeDefs中定义的查询
            getBooks: (obj: any, args: any, context: any, info: any) => {
                return [];
            }
        },
        Mutation: {
            // Mutation中实现typeDefs中定义的更新
            addBook: (obj: any, args: any, context: any, info: any) => {
                console.log('----> params', args['book'])
                return true;
            }
        },
        // 实现typeDefs中自定义的模型
        Book: {
            // 针对 单个属性定义
            sex: (book:any, args: any, context: any, info: any) => {
                return book.sex === 1 ? '男' : '女';
            }
        }
        // ... 多个自定义模型
    }
```

> 注意: resolver 中 Query和Mutation 只能有一个

### 开始使用

```typescript
import { ApolloServer } from 'apollo-server-fastify';
import * as fastify from 'fastify';

const gqlserver =  new ApolloServer({
    typeDefs,
    resolvers
})

fast.register(gqlserver.createHandler());

fast.listen(3000, '0.0.0.0', async (err, address) => {
    if (err) {
        fast.log.error(err, address);
    } else {
        console.info(`service start success > ${address}`);
    }
})
```

## 参考链接

[](http://www.zhaiqianfeng.com/2017/06/learn-graphql-first-demo.html)

[](http://www.zhaiqianfeng.com/2017/06/learn-graphql-type-system.html)

[](http://www.zhaiqianfeng.com/2017/06/learn-graphql-action-by-javascript.html)
