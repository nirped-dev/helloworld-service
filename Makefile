clean:
	@echo "Cleanining generated go files"
	@rm -f proto/*.go

build: proto
	@echo "Building"
	@go build 

install: proto
	@echo "Installing"
	@go install

proto:
	@echo "Generating GRPC stubs"
	@protoc -I/usr/local/include -I. \
		   -I/work/go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		   proto/helloworld.proto \
		   --go_out=plugins=grpc:.
	@protoc -I/usr/local/include -I. \
		   -I/work/go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		   proto/helloworld.proto \
		   --grpc-gateway_out=logtostderr=true:.

.PHONY: \
	clean \
	proto \
	install \
	build 
	
