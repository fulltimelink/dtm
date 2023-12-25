# dev env https://www.dtm.pub/other/develop.html
all: fmt lint test_redis
.PHONY: all

fmt:
	@gofmt -s -w ./

lint:
	revive -config revive.toml ./...

.PHONY: test
test:
	@go test ./...

test_redis:
	TEST_STORE=redis go test ./...

test_all:
	TEST_STORE=redis go test ./...
	TEST_STORE=boltdb go test ./...
	TEST_STORE=mysql go test ./...
	TEST_STORE=postgres go test ./...

cover_test:
	./helper/test-cover.sh


VERSION=0.0.3
APP_NAME=dtm

# 构建linux amd64环境下的可执行文件
.PHONY: linux
linux:
	GOOS=linux GOARCH=amd64 go build

.PHONY: docker
docker:
	docker build -t $(APP_NAME):v$(VERSION) .
	docker tag $(APP_NAME):v$(VERSION) hub-tx.dianzhenkeji.com/fulltimelink/$(APP_NAME):v$(VERSION)
	docker login https://hub-tx.dianzhenkeji.com/
	docker push hub-tx.dianzhenkeji.com/fulltimelink/$(APP_NAME):v$(VERSION)