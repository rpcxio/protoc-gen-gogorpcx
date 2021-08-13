version := $(shell /bin/date "+%Y-%m-%d %H:%M")

build:
	go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gofast.exe main.go
	$(if $(shell command -v upx), upx protoc-gen-gofast)
mac:
	GOOS=darwin go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gofast-darwin main.go
	$(if $(shell command -v upx), upx protoc-gen-gofast-darwin)
win:
	GOOS=windows go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gofast.exe main.go
	$(if $(shell command -v upx), upx protoc-gen-gofast.exe)
linux:
	GOOS=linux go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gofast-linux main.go
	$(if $(shell command -v upx), upx protoc-gen-gofast-linux)
