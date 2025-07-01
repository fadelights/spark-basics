#!/usr/bin/env bash

docker run --rm --interactive --tty \
    --name sparkly \
    --publish 8888:8888 \
    --volume ~/Development/ipyspark:/home/mani/ipyspark \
    ipyspark:custom
