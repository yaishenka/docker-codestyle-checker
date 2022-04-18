FROM ubuntu:latest

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
  clang-format \
  clang-tidy \
  git \
  ssh \
  ca-certificates \
  gcc \
  valgrind \
  g++ \
  python3.8 \
  wget \
  libboost-all-dev \
  openssl \
  libssl-dev \
  make \
  cmake

RUN apt install -y lsb-release wget software-properties-common
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

RUN ln -s /usr/bin/clang++-14 /usr/bin/clang++-13

RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt install -y g++-11

RUN git clone --depth=1 -b main -q https://github.com/google/googletest.git /googletest
RUN mkdir -p /googletest/build
WORKDIR /googletest/build
RUN cmake .. && make && make install
WORKDIR /
RUN rm -rf /googletest