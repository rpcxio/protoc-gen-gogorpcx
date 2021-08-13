version := $(shell /bin/date "+%Y-%m-%d %H:%M")

build:
	go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogofaster.exe main.go
	$(if $(shell command -v upx), upx protoc-gen-gogofaster)
mac:
	GOOS=darwin go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogofaster-darwin main.go
	$(if $(shell command -v upx), upx protoc-gen-gogofaster-darwin)
win:
	GOOS=windows go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogofaster.exe main.go
	$(if $(shell command -v upx), upx protoc-gen-gogofaster.exe)
linux:
	GOOS=linux go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogofaster-linux main.go
	$(if $(shell command -v upx), upx protoc-gen-gogofaster-linux)
