FROM ubuntu:16.04

MAINTAINER Anatoly Galiulin <galiulin.anatoly@gmail.com>

WORKDIR /root

RUN apt-get update

RUN apt-get install -y \
  curl \
  git \
  gcc \
  g++ \
  libzip-dev

RUN git clone -b devel https://github.com/nim-lang/Nim.git && \
  cd Nim && git clone --depth 1 https://github.com/nim-lang/csources && \
  cd csources && sh build.sh && cd .. && bin/nim c koch && ./koch boot -d:release && \
  ./koch tools -d:release

ENV PATH=$PATH:/root/Nim/bin

RUN nimble refresh -y