version := $(shell /bin/date "+%Y-%m-%d %H:%M")

build:
	go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogoslick.exe main.go
	$(if $(shell command -v upx), upx protoc-gen-gogoslick)
mac:
	GOOS=darwin go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogoslick-darwin main.go
	$(if $(shell command -v upx), upx protoc-gen-gogoslick-darwin)
win:
	GOOS=windows go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogoslick.exe main.go
	$(if $(shell command -v upx), upx protoc-gen-gogoslick.exe)
linux:
	GOOS=linux go build -ldflags="-s -w" -ldflags="-X 'main.BuildTime=$(version)'" -o protoc-gen-gogoslick-linux main.go
	$(if $(shell command -v upx), upx protoc-gen-gogoslick-linux)
