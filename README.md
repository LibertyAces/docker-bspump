Dockerfiles for bspump
===

## Organization of the repo

Dockerfiles in this repository are organized as follows:

```
.
└──${VERSION}
    └──${BASEOS}
        └──bspump-dependencies.Dockerfile
		───bspump.Dockerfile
```

## BSPump dependencies

### Build

Build an image of bspump dependencies version (`${VERSION}`) and base OS (`${BASEOS}`).

```
$ cd ${VERSION}/${BASEOS}
$ docker build -t teskalabs/bspump:${VERSION}-${BASEOS} -f bspump-dependencies.Dockerfile .
```

### Publish

```
$ docker login
$ docker push teskalabs/bspump-dependencies:${VERSION}-${BASEOS}
```

## BSPump specific image

### Build

Build an image of specific bspump version (`${VERSION}`) and base OS (`${BASEOS}`).

```
$ cd ${VERSION}/${BASEOS}
<<<<<<< HEAD
$ docker build -t teskalabs/bspump:${VERSION}-${BASEOS} -f bspump.Dockerfile .
=======
$ docker build -t teskalabs/bspump:${VERSION}-${BASEOS} .
$ docker tag teskalabs/bspump:${VERSION}-${BASEOS} teskalabs/bspump:latest
>>>>>>> 94564d4cdfcb759e08c8097a17882793b80dcd9b
```

### Publish

```
$ docker login
$ docker push teskalabs/bspump:${VERSION}-${BASEOS}
$ docker push teskalabs/bspump:latest
```
