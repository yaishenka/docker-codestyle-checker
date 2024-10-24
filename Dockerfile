FROM ubuntu:latest

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  ssh \
  ca-certificates \
  gcc \
  valgrind \
  g++ \
  python3 \
  wget \
  libboost-all-dev \
  openssl \
  libssl-dev \
  make \
  cmake \
  lsb-release \
  wget \
  software-properties-common

# Installs latest llvm version
RUN wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 18 \
    && apt-get install -y clang-tidy-18 clang-format-18 \
    && bash -c 'for item in /usr/bin/clang*-18; do ln -s $item ${item%-18}; done' \
    && rm llvm.sh && apt-get clean && rm -rf /var/lib/apt/lists/*


RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt install -y g++

# Adds symlinks wrt old scripts
RUN ln -s /usr/bin/clang++-18 /usr/bin/clang++-13

RUN git clone --depth=1 -b main -q https://github.com/google/googletest.git /googletest \
    && mkdir -p /googletest/build
    && cd /googletest/build
    && cmake .. && make && make install
    && cd /
    && rm -rf /googletest
