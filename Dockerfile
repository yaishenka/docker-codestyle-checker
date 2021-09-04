FROM ubuntu:latest

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
  clang-12 \
 && rm -rf /var/lib/apt/lists/*