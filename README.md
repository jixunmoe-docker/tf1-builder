# tf1-builder

A static library builder image for TensorFlow v1.x

# Build Image

```
docker build --tag tfbuilder .
```

# Build TFv1 for node

Enter shell:

```
docker run --rm -v "$(pwd)/output:/tfbuilder/output/" -it tfbuilder
```

Then

```
build
```

(or you can exam & edit the environment / build script ahead of this)
