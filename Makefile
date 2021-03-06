gitrev := $(shell git rev-parse --short HEAD)
ldflags := -X "main.GitRivision=$(gitrev)"
packages := $(shell go list ./... | grep -v memsniff/vendor)
gometalinter := ${GOPATH}/bin/gometalinter.v1

all: install lint test

install:
	go install -x -ldflags "$(ldflags)" $(packages)

test:
	go test -v -x -ldflags "$(ldflags)" $(packages)

$(gometalinter):
	go get -u gopkg.in/alecthomas/gometalinter.v1
	gometalinter.v1 --install

lint: $(gometalinter)
	gometalinter.v1 --vendor --deadline 1m --enable-gc --disable=aligncheck ./...
