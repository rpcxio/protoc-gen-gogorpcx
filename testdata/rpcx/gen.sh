#!/bin/sh

protoc -I.:${GOPATH}/src  --gofast_out=plugins=rpcx:. helloworld.proto
