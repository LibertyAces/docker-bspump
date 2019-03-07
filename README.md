Dockerfiles for bspump
===

## Organization of the repo

Dockerfiles in this repository are organized as follows:

```
.
└──${VERSION}
    └──${BASEOS}
        └──Dockerfile
```

## Build

Build an image of specific bspump version (`${VERSION}`) and base OS (`${BASEOS}`).

```
$ cd ${VERSION}/${BASEOS}
$ docker build -t teskalabs/bspump:${VERSION}-${BASEOS} .
$ docker tag teskalabs/bspump:${VERSION}-${BASEOS} teskalabs/bspump:latest
```

## Publish

```
$ docker login
$ docker push teskalabs/bspump:${VERSION}-${BASEOS}
$ docker push teskalabs/bspump:latest
```
