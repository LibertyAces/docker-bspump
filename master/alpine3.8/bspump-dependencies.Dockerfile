FROM python:3.6-alpine3.8
MAINTAINER TeskaLabs Ltd (support@teskalabs.com)

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8


RUN set -ex \
	&& apk update \
	&& apk upgrade \
	&& apk add git \
	&& apk add boost \
	&& apk add libssl1.0


# Create build environment so that dependencies like aiohttp can be build
RUN set -ex \
	&& apk add --virtual buildenv python3-dev \
	&& apk add --virtual buildenv libffi-dev \
	&& apk add --virtual buildenv openssl-dev \
	&& apk add --virtual buildenv gcc \
	&& apk add --virtual buildenv g++ \
	&& apk add --virtual buildenv musl-dev \
	&& pip install Cython

RUN set -ex \
	&& apk add --no-cache snappy g++ snappy-dev

RUN set -ex \
	&& pip install aiohttp \
	&& pip install aiomysql \
	&& pip install aiokafka \
	&& pip install pika \
	&& pip install six \
	&& pip install numpy \
	&& pip install pandas \
	&& pip install --no-cache-dir --ignore-installed python-snappy

# Remove build environment
RUN apk del buildenv

RUN set -ex \
	&& apk add lsof

# Pyarrow
COPY ./pyarrow_0_11_0-36m-x86_64-alpine38.tar.gz /root/pyarrow_0_11_0-36m-x86_64-alpine38.tar.gz
RUN set -ex \
	&& tar xzvf /root/pyarrow_0_11_0-36m-x86_64-alpine38.tar.gz -C /usr/local/lib/python3.6/site-packages/ \
	&& rm /root/pyarrow_0_11_0-36m-x86_64-alpine38.tar.gz

CMD ["python3", "-m", "aiohttp"]
