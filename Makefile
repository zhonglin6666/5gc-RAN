GO_BIN_PATH = bin
GO_SRC_PATH = src

VERSION = $(shell git describe --tags)
BUILD_TIME = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
COMMIT_HASH = $(shell git submodule status | grep $(GO_SRC_PATH)/$(@F) | awk '{print $$(1)}' | cut -c1-8)
COMMIT_TIME = $(shell cd $(GO_SRC_PATH)/$(@F) && git log --pretty="%ai" -1 | awk '{time=$$(1)"T"$$(2)"Z"; print time}')
LDFLAGS = -X free5gc/src/$(@F)/version.VERSION=$(VERSION) \
          -X free5gc/src/$(@F)/version.BUILD_TIME=$(BUILD_TIME) \
          -X free5gc/src/$(@F)/version.COMMIT_HASH=$(COMMIT_HASH) \
          -X free5gc/src/$(@F)/version.COMMIT_TIME=$(COMMIT_TIME)


all: build

build:
	@echo "Start building ......""
	go build -ldflags "$(LDFLAGS)" -o $@ $<

clean:
	rm -rf $(addprefix $(GO_BIN_PATH)/
