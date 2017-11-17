FROM golang:alpine

ENV GIN_MODE release

RUN apk add --update git bash && \
    rm -rf /var/cache/apk/* && \
    go get -d github.com/jamessoubry/vault-gatekeeper-mesos && \
    cd $GOPATH/src/github.com/jamessoubry/vault-gatekeeper-mesos && \
    git checkout master && \
    /bin/bash ./build.bash && \
    cp ./vltgatekeeper /bin/vltgatekeeper && \
    rm -r $GOPATH/src/github.com/jamessoubry/vault-gatekeeper-mesos && \
    apk del git

EXPOSE 9201

ENTRYPOINT ["/bin/vltgatekeeper"]
