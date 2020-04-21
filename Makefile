ifndef GOPATH
  GOPATH:=$(shell go env GOPATH)
endif

ifndef GOBIN
  GOBIN:=$(GOPATH)/bin
endif

ifndef GOARCH
  GOARCH:=$(shell go env GOARCH)
endif

ifndef GOOS
  GOOS:=$(shell go env GOOS)
endif

ifndef GOARM
  GOARM:=$(shell go env GOARM)
endif

ifndef TARGET_FILE
  TARGET_FILE:=bin/mqtt2prometheus.$(GOOS)_$(GOARCH)$(GOARM)
endif

all: build

GO111MODULE=on


test:
	go test ./...
	go vet ./...

build:
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(TARGET_FILE) ./cmd

static_build:
	CGO_ENABLED=0 GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(TARGET_FILE) -a -tags netgo -ldflags '-w -extldflags "-static"' ./cmd

container:
	docker build -t mqtt2prometheus:latest .
