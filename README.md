# SICoreFunctionLibrary_0.2.5
系列 MOD 的核心框架库。

主要功能有以下几个方面：
1. util 文件提供了最基本的数据结构支撑。包含了最底层的函数，自动构建基础数据结构（constants 和 constants_data），同时也负责创建日志和消息输出。
2. 变量封装和构建。define 目录下的文件封装了一些公共常量和内部常量，包括数值、标签字符串、颜色、data 数据类型、MOD 情况等数据，这些常量用于同一参数减少魔法值。
3. 公共函数和方法构建。function 目录下的文件封装了一些公共函数和方法，包括分割字符串、格式化游戏时间、表转字符串等方法。
4. 数据构建器。SIGen 提供了用于 data 模块下构建 data 数据的构建器，旨在用极少量的代码创建 data 数据；SIPackers 提供了快速构建数据包和数据序列的支持；SIPics 提供了快速构建贴图数据的支持；SISounds 提供了快速构建声音数据的支持。
5. 运行时数据管理。封装了 global 表的访问方法。
6. 快速构建设置。
7. 调试工具套装。

单独安装这个 MOD 的话，则除了调试工具套装以外，不会添加任何实际的功能，并且几乎全部的功能代码都会在游戏载入完毕后被丢弃。

注意：

由于并不是每次完成一个完整功能时才提交代码，而是随时提交代码，因此当你在运行从 GitHub 上获取的副本时，很可能会遇到致命错误

解决办法是从 MOD 网站获取发布的版本，而不是从 GitHub 上获取最新版本
