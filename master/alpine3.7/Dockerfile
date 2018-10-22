FROM python:3.6-alpine3.7
MAINTAINER TeskaLabs Ltd (support@teskalabs.com)

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8


RUN set -ex \
	&& apk update \
	&& apk upgrade \
	&& apk add git \
	&& apk add libssl1.0


# Create build environment so that dependencies like aiohttp can be build
RUN set -ex \
	&& apk add --virtual buildenv python3-dev \
	&& apk add --virtual buildenv libffi-dev \
	&& apk add --virtual buildenv openssl-dev \
	&& apk add --virtual buildenv gcc \
	&& apk add --virtual buildenv musl-dev

RUN set -ex \
	&& pip install aiohttp \
	&& pip install aiomysql \
	&& pip install aiokafka \
	&& pip install pika \
	&& pip install git+https://github.com/TeskaLabs/asab.git \
	&& pip install git+https://github.com/TeskaLabs/bspump.git

# Remove build environment
RUN apk del buildenv

CMD ["python3", "-m", "bspump"]

