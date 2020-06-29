Dockerfiles for bspump
===

## Organization of the repo

Dockerfiles in this repository are organized as follows:

```
.
└──${VERSION}
    └──${BASE}
        └──bspump-dependencies.Dockerfile
		───bspump.Dockerfile
```


## BSPump image

### Build

Build an image of BSPump version (`${VERSION}`) and base (`${BASE}`).

`${VERSION}`:

 * `latest`


`${BASE}`:

 * `py38` for [official](https://hub.docker.com/_/python) Python 3.8 on Debian Buster (slimmed), image size 334MB
 * `py37` for [official](https://hub.docker.com/_/python) Python 3.7 on Debian Buster (slimmed), image size 325MB

 * `alpine3.12` for Python 3.8 on Alpine 3.12
 * `alpine3.10` for Python 3.7 on Alpine 3.10
 * `alpine3.8` for Python 3.6 on Alpine 3.8


```
$ cd ${VERSION}/${BASE}
$ docker build --squash -t teskalabs/bspump:${VERSION}-${BASE} -f bspump.Dockerfile .
$ docker tag teskalabs/bspump:${VERSION}-${BASE} teskalabs/bspump:latest
```

### Publish

```
$ docker login
$ docker push teskalabs/bspump:${VERSION}-${BASE}
$ docker push teskalabs/bspump:latest
```


## BSPump dependencies image (aka `bspump-dependencies`)

Needed for Alpine-based images.

 * `alpine3.8` for Python 3.6, image size 265MB
 * `alpine3.10` for Python 3.7, image size 279MB
 * `alpine3.12` for Python 3.8, image size 432MB

### Build

Build an image of bspump dependencies version (`${VERSION}`) and base (`${BASE}`).

```
$ cd ${VERSION}/${BASE}
$ docker build --squash -t teskalabs/bspump-dependencies:${VERSION}-${BASE} -f bspump-dependencies.Dockerfile .
$ docker tag teskalabs/bspump-dependencies:${VERSION}-${BASE} teskalabs/bspump-dependencies:latest
```

### Publish

```
$ docker login
$ docker push teskalabs/bspump-dependencies:${VERSION}-${BASE}
```
