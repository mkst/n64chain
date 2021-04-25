FROM ubuntu:20.04 as build

RUN apt-get update && apt-get install -y \
  build-essential \
  libmpc-dev \
  wget

COPY build-posix64-toolchain.sh /

RUN bash build-posix64-toolchain.sh

FROM ubuntu:20.04

COPY --from=build /opt/crashsdk /opt/crashsdk

RUN apt-get update && apt-get install -y --reinstall ca-certificates libmpc3
RUN echo "deb [trusted=yes] https://crashoveride95.github.io/apt/ ./" > /etc/apt/sources.list.d/n64sdk.list

ENV N64_LIBGCCDIR="/opt/crashsdk/lib/gcc/mips64-elf/10.2.0"
ENV PATH="${PATH}:/opt/crashsdk/bin"
