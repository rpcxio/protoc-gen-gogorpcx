version := $(shell /bin/date "+%Y-%m-%d %H:%M")

build:
	go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogofast.exe main.go
	$(if $(shell command -v upx), upx protoc-gen-gogofast)
mac:
	GOOS=darwin go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogofast-darwin main.go
	$(if $(shell command -v upx), upx protoc-gen-gogofast-darwin)
win:
	GOOS=windows go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogofast.exe main.go
	$(if $(shell command -v upx), upx protoc-gen-gogofast.exe)
linux:
	GOOS=linux go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogofast-linux main.go
	$(if $(shell command -v upx), upx protoc-gen-gogofast-linux)
