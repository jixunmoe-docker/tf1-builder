FROM debian:buster-20210208

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    python3 \
    python3-dev \
    python3-venv \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/*

ENV BAZEL_VER=0.26.1
ENV BAZEL_INSTALLER="bazel-$BAZEL_VER-installer-linux-x86_64.sh"
RUN wget -q -O "$BAZEL_INSTALLER" "https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VER/$BAZEL_INSTALLER"\
  && chmod a+x "$BAZEL_INSTALLER" \
  && "./$BAZEL_INSTALLER" \
  && rm -rf "$BAZEL_INSTALLER"

COPY script/build.sh /tmp/build.sh
RUN sh /tmp/build.sh && rm /tmp/build.sh

WORKDIR /tfbuilder/tf
