#!/usr/bin/env bash
export GO_VERSION=${GO_VERSION:=1.4.1}

# this is where the go libraries are downloaded
export GO_CODE=${GO_CODE:=/srv/projects/gocode}

# this is where we download and build go itself
export GO_BUILD=${GO_BUILD:=$HOME/gobuild}

# install the various package managers used by go
apt-get install -y mercurial subversion bzr git

# ensure that we have the lib folder
mkdir -p $GO_CODE

# clone the go source code
git clone https://go.googlesource.com/go $GO_BUILD

# checkout the version of go
cd $GO_BUILD && git checkout go$GO_VERSION

# build go for linux and darwin
cd $GO_BUILD/src && GOOS=darwin GOARCH=amd64 CGO_ENABLED=1 ./make.bash --no-clean
cd $GO_BUILD/src && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 ./make.bash --no-clean

# build out the enviroment
echo "GOROOT=$GO_BUILD" >> /etc/environment
echo "GOPATH=$GO_CODE" >> /etc/environment
echo "GOBIN=$GO_CODE/bin" >> /etc/environment
echo "PATH=$GO_BUILD/bin:$PATH" >> /etc/environment

# ensure the go folders are owned by the user not root
chown -R $SUDO_USER:$SUDO_USER $GO_BUILD
chown -R $SUDO_USER:$SUDO_USER $GO_CODE
