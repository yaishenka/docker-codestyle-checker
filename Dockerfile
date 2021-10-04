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
  libgtest-dev \
  cmake

RUN apt install -y lsb-release wget software-properties-common
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
RUN cd /usr/src/gtest
RUN cmake CMakeLists.txt
RUN make
RUN cp *.a /usr/lib
RUN cd ~/
RUN rm -rf /var/lib/apt/lists/*