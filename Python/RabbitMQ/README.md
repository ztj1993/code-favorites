RabbitMQ 使用
======

## RabbitMQ 介绍

RabbitMQ 是采用 Erlang 语言实现 AMQP(Advanced Message Queuing Protocol 高级消息队列协议)的消息中间件。

AMQP 的主要特征是面向消息、队列、路由(包括点对点和发布/订阅)、可靠性、安全。

## RabbitMQ 特点

- 可靠性: RabbitMQ 使用一些机制来保证可靠性， 如持久化、传输确认及发布确认等。
- 灵活的路由: 在消息进入队列之前，通过交换器来路由消息。
  - 对于典型的路由功能，RabbitMQ 己经提供了一些内置的交换器来实现。
  - 针对更复杂的路由功能，可以将多个交换器绑定在一起， 也可以通过插件机制来实现自己的交换器。
- 扩展性: 多个 RabbitMQ 节点可以组成一个集群，也可以根据实际业务情况动态地扩展集群中节点。
- 高可用性: 队列可以在集群中的机器上设置镜像，使得在部分节点出现问题的情况下队列仍然可用。
- 多种协议: RabbitMQ 除了原生支持 AMQP 协议，还支持 STOMP ， MQTT 等多种消息中间件协议。
- 多语言客户端: RabbitMQ 几乎支持所有常用语言，比如Java、Python 、Ruby 、PHP 、C# 、JavaScript 等。
- 管理界面: RabbitMQ 提供了一个易用的用户界面，使得用户可以监控和管理消息、集群中的节点等。
- 插件机制: RabbitMQ 提供了许多插件， 以实现从多方面进行扩展，当然也可以编写自己的插件。

## 基础概念

### ConnectionFactory(连接工厂)
- 用于创建 Connection 连接对象

### Connection(连接对象)
- 封装了 socket 协议部分逻辑

## Channel(通道)
- 大部分业务操作是在 Channel 接口中完成
- 包括定义 Queue、定义 Exchange、绑定 Queue 与 Exchange、发布消息

### Virtual Hosts(虚拟主机)
- 相当于一个小型的 RabbitMQ 服务器
- 独立的队列、交换器以及绑定关系等待
- 具有独立的权限
- 每个虚拟主机绝对的隔离

### Queue(队列)
- 作用是存储消息
- 特性是先进先出
- 多个消费者可以定义一个队列
- 多个消费者会平摊队列消息

### Message acknowledgment(消息确认)
- 实际应用中，会发生消费者收到 Queue 中的消息，但没有处理完成就宕机的情况
- 这种情况下就可能会导致消息丢失
- 为了避免这种情况发生，我们可以要求消费者在消费完消息后发送一个回执给 RabbitMQ
- RabbitMQ 收到消息回执后才将该消息从Queue中移除
- 如果RabbitMQ没有收到回执并检测到消费者的RabbitMQ连接断开
- RabbitMQ 会将该消息发送给其他消费者进行处理
- 这里不存在超时概念，除非它的 RabbitMQ 连接断开，否则或一直任务在处理消息
- 这会产生另外一个问题，如果没有发送回执给 RabbitMQ
- 会导致 Queue 中堆积的消息会越来越多
- 消费者重启后会重复消费这些消息并重复执行业务逻辑

### Message durability(消息持久化)
- 要实现在 RabbitMQ 服务重启下，也不会丢失消息
- 可以将 Queue 与 Message 都设置为持久化

### Prefetch count(预处理数量)
- 多个消费者同时订阅同一个 Queue 中的消息，Queue 中的消息会被平摊给多个消费者
- 如果消息处理时间不同，会导致负载不均情况
- 可以设置 prefetchCount 来限制 Queue 每次发送给每个消费者的消息数
- 只有消费者完成处理后，才会继续发送消息

### Exchange(交换器)
- 决定消息绑定到哪个队列
- 这里有 Binding(绑定器) 的概念

### routing key(路由键)
- 生产者在将消息发送给 Exchange 的时候，一般会指定一个 routing key，来指定这个消息的路由规则
- routing key 需要与 Exchange Type 及 binding key 联合使用才能最终生效
- RabbitMQ 为 routing key 设定的长度限制为255 bytes

### Binding(绑定器)
- 通过 Binding 将 Exchange 与 Queue 关联起来
- 这样就知道如何正确地将消息路由到指定的 Queue 了

### Binding key(绑定键)
- 在绑定 Exchange 与 Queue 的同时，一般会指定一个 binding key
- 生产者将消息发送给 Exchange 时，一般会指定一个 routing key
- 当 binding key 与 routing key 相匹配时，消息将会被路由到对应的 Queue 中
- 绑定多个 Queue 到同一个 Exchange 时，这些 Binding 允许使用相同的 binding key
- binding key 并不是在所有情况下都生效，它依赖于 Exchange Type
- fanout 类型的 Exchange 就会无视 binding key
- fanout 类型的 Exchange 会将消息路由到所有绑定到该 Exchange 的 Queue

### Exchange Types(交换器类型)
- 常用的交换器类型有 fanout、direct、topic、headers 四种

### 交换器类型：fanout
- 把所有发送到该 Exchange 的消息路由到所有与它绑定的 Queue 中

### 交换器类型：direct
- 把消息路由到那些 binding key 与 routing key 完全匹配的 Queue 中

### 交换器类型：topic
- 它与 direct 类型的 Exchange 相似
- 将消息路由到 binding key 与 routing key 相匹配的 Queue 中
- binding key 支持模糊匹配

### 交换器类型：headers
- 不依赖于 routing key 与 binding key 的匹配规则来路由消息
- 根据发送的消息内容中的 headers 属性进行匹配

### 交换器类型：RPC
- 客户端发送请求消息时，在消息的属性中设置两个值 replyTo 和 correlationId
- 服务器端收到消息并处理
- 处理完消息后，将生成一条应答消息到 replyTo 指定的 Queue，同时带上 correlationId 属性
- 客户端之订阅 replyTo 指定的 Queue，从中分析哪条请求被执行了
