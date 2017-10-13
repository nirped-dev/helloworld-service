clean:
	@echo "Cleaning generated go files"
	@rm -f proto/*.go
	@rm -f helloworld-service

build: proto
	@echo "Building"
	@go build -o helloworld-service github.com/nirped-dev/helloworld-service/svc
	@go build -o helloworld-rproxy github.com/nirped-dev/helloworld-service/rproxy

install: proto
	@echo "Installing"
	@go install -o helloworld-service github.com/nirped-dev/helloworld-service/svc
	@go install -o helloworld-rproxy github.com/nirped-dev/helloworld-service/rproxy

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
	@protoc -I/usr/local/include -I. \
		   -I/work/go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		   proto/helloworld.proto \
		   --swagger_out=logtostderr=true:.

.PHONY: \
	clean \
	proto \
	install \
	build 
	
