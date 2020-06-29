FROM python:3.7-alpine3.11
MAINTAINER TeskaLabs Ltd (support@teskalabs.com)

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8


RUN set -ex \
	&& apk update \
	&& apk upgrade \
	&& apk add git \
	&& apk add boost

# Create build environment so that dependencies like aiohttp can be build
RUN set -ex \
	&& apk add --virtual buildenv python3-dev \
	&& apk add --virtual buildenv libffi-dev \
	&& apk add --virtual buildenv openssl-dev \
	&& apk add --virtual buildenv gcc \
	&& apk add --virtual buildenv g++ \
	&& apk add --virtual buildenv musl-dev \
	&& apk add --virtual buildenv snappy-dev \
	&& apk add --virtual buildenv openssl-dev \
	&& apk add --virtual buildenv libffi-dev


# Keep this in sync with bspump/setup.py
RUN set -ex \
	&& pip install --no-cache-dir aiohttp \
	&& pip install --no-cache-dir aiozk \
	&& pip install --no-cache-dir requests \
	&& pip install --no-cache-dir aiokafka \
	&& pip install --no-cache-dir aiosmtplib \
	&& pip install --no-cache-dir fastavro \
	&& pip install --no-cache-dir google-api-python-client \
	&& pip install --no-cache-dir numpy \
	&& pip install --no-cache-dir pika \
	&& pip install --no-cache-dir pymysql \
	&& pip install --no-cache-dir aiomysql \
	&& pip install --no-cache-dir mysql-replication \
	&& pip install --no-cache-dir pytz \
	&& pip install --no-cache-dir netaddr \
	&& pip install --no-cache-dir pyyaml \
	&& pip install --no-cache-dir pymongo \
	&& pip install --no-cache-dir motor \
	&& pip install --no-cache-dir mongoquery \
	&& pip install --no-cache-dir pywinrm \
	&& pip install --no-cache-dir python-snappy

# Pyarrow
COPY ./pyarrow_0_11_0-37m-x86_64-alpine38.tar.gz /root/pyarrow_0_11_0-37m-x86_64-alpine38.tar.gz
RUN set -ex \
	&& tar xzvf /root/pyarrow_0_11_0-37m-x86_64-alpine38.tar.gz -C /usr/local/lib/python3.7/site-packages/ \
	&& rm /root/pyarrow_0_11_0-37m-x86_64-alpine38.tar.gz

# Remove build environment
RUN apk del buildenv

RUN set -ex \
	&& apk add lsof

EXPOSE 80/tcp

CMD ["python3"]
