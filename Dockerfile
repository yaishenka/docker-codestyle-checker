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
  make \
  cmake

RUN apt install -y lsb-release wget software-properties-common
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"


# Alias cc, c++, clang and clang-format to Clang 13
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-13 100 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-13 100 && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-13 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 100

# Build GTest library
RUN cd /usr/src/googletest && \
    cmake -DCMAKE_CXX_FLAGS="-Wno-error=deprecated-copy" . && \
    cmake -DCMAKE_CXX_FLAGS="-Wno-error=deprecated-copy" --build . --target install