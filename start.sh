#!/bin/bash

docker build -t devsvr .

docker run -it --rm --name devsvr -p 3001:3001 \
  --shm-size 1g \
  -v ./config:/config \
  -v /tmp:/tmp \
  --security-opt seccomp=unconfined \
  devsvr /bin/bash 
