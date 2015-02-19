go-go-gadget
------------

Installation instructions for getting a cross-compiling go development environment to work.

## install

First you clone this repository and then:

```bash
$ sudo bash ./install.sh
```

## notes

The install script does the following steps:

 * install the package managers used by go (mercurial, subversion, bzr, git)
 * clone the go source code into $GO_CODE (/srv/projects/gocode)
 * checkout the $GO_VERSION (1.4.1)
 * build the go binaries for GOOS=darwin
 * build the go binaries for GOOS=linux
 * setup the environment with:
   * GOROOT - $GO_BUILD
   * GOPATH - $GO_PATH
   * GOBIN - $GO_CODE/bin
   * PATH - $PATH:$GO_BUILD/bin
 * change ownership of $GO_BUILD/src and $GO_CODE to the user

## compiling

To compile a package against darwin and linux - here is a simple Makefile format:

```
NAME=powerstrip
VERSION=0.1.0

build:
  mkdir -p build/linux  && CGO_ENABLED=0 GOOS=linux  \
    go build -ldflags "-X main.Version $(VERSION)" -o build/linux/$(NAME)
  mkdir -p build/darwin && CGO_ENABLED=0 GOOS=darwin \
    go build -ldflags "-X main.Version $(VERSION)" -o build/darwin/$(NAME)
```

## licence

MIT