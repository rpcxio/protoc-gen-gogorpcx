本工具基于[gogo/protobuf](https://github.com/gogo/protobuf), 在gogo protobuf的基础上增加了生成rpcx服务的能力。

gogo 生成的 protobuf代码性能更好，人性化高，并且兼容protobu协议：

- fast marshalling and unmarshalling
- more canonical Go structures
- goprotobuf compatibility
- less typing by optionally generating extra helper code
- peace of mind by optionally generating test and benchmark code
- other serialization formats


## 安装

首先，确保你已经安装了`protoc`编译器,并且安装了Go。

本工具提供了三中代码生成的方式。

### Speed

安装`protoc-gen-gofast`二进制：

```sh
go get github.com/rpcxio/protoc-gen-rpcx/protoc-gen-gofast
```

使用它你可以产生更快的序列化代码：
```sh
protoc --gofast_out=plugins=rpcx:. myproto.proto
```
但是你不能使用其它的 [gogoprotobu 扩展](https://github.com/gogo/protobuf/blob/master/extensions.md)。

### 更快，更便利

字段无指针可以让GC花费更好的时间，而且可以产生更多的辅助方法。

```sh
protoc-gen-gogofast (在gofast一基础上， 可以导入gogoprotobuf)
protoc-gen-gogofaster (在gogofast基础上, 去掉XXX_unrecognized方法, 更少的指针字段)
protoc-gen-gogoslick (在gogofaster基础上, 辅助方法string, gostring 和 equal)
```

# 例子

- proto文件

最简单的一个打招呼的rpc服务。

```proto
syntax = "proto3";

option go_package = "helloword";

package helloworld;

// The greeting service definition.
service Greeter {
  // Sends a greeting
  rpc SayHello (HelloRequest) returns (HelloReply) {}
}

// The request message containing the user's name.
message HelloRequest {
  string name = 1;
}

// The response message containing the greetings
message HelloReply {
  string message = 1;
}
```

- 使用protoc编译器编译出Go代码

```sh
protoc --gofast_out=plugins=rpcx:. helloworld.proto
```

上述命令生成了 `helloworld.pb.go` 文件， 它包含各种struct的定义， 还有服务端的一个骨架， 以及客户端的代码。

- 服务端代码

服务端的代码只是一个骨架，很显然你要实现你的逻辑。比如这个打招呼的例子， 客户端传入一个名称，你可以返回一个`hello <name>`的字符串。

它还提供了一个简单启动服务的方法，你可以在此基础上实现服务端的代码，注册很多的服务，配置注册中心和其它插件等等。

```go
package main

import (
	context "context"
	"fmt"

	helloworld "github.com/golang/protobuf/protoc-gen-go/testdata/rpcx"
	server "github.com/smallnest/rpcx/server"
)

func main() {
	s := server.NewServer()
	s.RegisterName("Greeter", new(GreeterImpl), "")
	err := s.Serve("tcp", ":8972")
	if err != nil {
		panic(err)
	}
}

type GreeterImpl struct{}

// SayHello is server rpc method as defined
func (s *GreeterImpl) SayHello(ctx context.Context, args *helloworld.HelloRequest, reply *helloworld.HelloReply) (err error) {
	*reply = helloworld.HelloReply{
		Message: fmt.Sprintf("hello %s!", args.Name),
	}
	return nil
}
```

- 客户端代码

客户端生成的代码更友好，它包装了`XClient`对象，提供了符合人工美学的方法调用格式(请求参数作为方法参数，返回结果作为方法的返回值)。并且提供了客户端的配置方式。

你也可以扩展客户端的配置，提供注册中心、路由算法，失败模式、重试、熔断等服务治理的设置。　


```go
package main

import (
	"context"
	"fmt"

	helloworld "github.com/golang/protobuf/protoc-gen-go/testdata/rpcx"
)

func main() {
	xclient := helloworld.NewXClientForGreeter("127.0.0.1:8972")
	client := helloworld.NewGreeterClient(xclient)

	args := &helloworld.HelloRequest{
		Name: "rpcx",
	}

	reply, err := client.SayHello(context.Background(), args)
	if err != nil {
		panic(err)
	}

	fmt.Println("reply: ", reply.Message)
}

```