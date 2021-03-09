#!/bin/sh
set -ex

mkdir -p /tfbuilder
cd /tfbuilder

python3 -m venv /tfbuilder/venv
. /tfbuilder/venv/bin/activate
pip install -U pip numpy wheel
pip install -U keras_preprocessing --no-deps

git clone https://github.com/tensorflow/tensorflow.git -b r1.15 --depth=1 tf
cd tf

# default config is ok
</dev/null ./configure

# mount this directory before building anything..!
mkdir -p /tfbuilder/output

cat > /usr/bin/build <<'EOF'
#!/bin/sh

# --local_cpu_resources=HOST_CPUS-1

set -ex
cd /tfbuilder/tf

. /tfbuilder/venv/bin/activate

bazel build --config=opt --config=monolithic \
  "$@" \
  "//tensorflow/tools/lib_package:libtensorflow"

tar -tf bazel-bin/tensorflow/tools/lib_package/libtensorflow.tar.gz
cp bazel-bin/tensorflow/tools/lib_package/libtensorflow.tar.gz /tfbuilder/output/
EOF

chmod a+x /usr/bin/build
