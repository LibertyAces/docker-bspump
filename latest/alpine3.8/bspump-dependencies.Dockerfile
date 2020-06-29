FROM alpine:3.8
MAINTAINER TeskaLabs Ltd (support@teskalabs.com)

ENV LANG C.UTF-8

RUN set -ex \
	&& apk update \
	&& apk upgrade

RUN apk add --no-cache \
	git \
	python3 \
	py3-pip \
	snappy \
	openssl \
	lsof

# Create build environment so that dependencies like aiohttp can be build
RUN apk add --no-cache --virtual .build-deps \
	gcc \
	g++ \
	python3-dev \
	libffi-dev \
	openssl-dev \
	musl-dev \
	snappy-dev \
	openssl-dev \
	libffi-dev

# Keep this in sync with bspump/setup.py
RUN pip3 install --no-cache-dir aiohttp
RUN pip3 install --no-cache-dir aiozk
RUN pip3 install --no-cache-dir requests
RUN pip3 install --no-cache-dir aiokafka
RUN pip3 install --no-cache-dir aiosmtplib
RUN pip3 install --no-cache-dir fastavro
RUN pip3 install --no-cache-dir google-api-python-client
RUN pip3 install --no-cache-dir numpy
RUN pip3 install --no-cache-dir pandas
RUN pip3 install --no-cache-dir pika
RUN pip3 install --no-cache-dir pymysql
RUN pip3 install --no-cache-dir aiomysql
RUN pip3 install --no-cache-dir mysql-replication
RUN pip3 install --no-cache-dir pytz
RUN pip3 install --no-cache-dir netaddr
RUN pip3 install --no-cache-dir pyyaml
RUN pip3 install --no-cache-dir pymongo
RUN pip3 install --no-cache-dir motor
RUN pip3 install --no-cache-dir mongoquery
RUN pip3 install --no-cache-dir pywinrm
RUN pip3 install --no-cache-dir python-snappy

# Pyarrow
# COPY ./pyarrow_0_11_0-37m-x86_64-alpine310.tar.gz /root/pyarrow_0_11_0-37m-x86_64-alpine310.tar.gz
# RUN set -ex \
#	&& tar xzvf /root/pyarrow_0_11_0-37m-x86_64-alpine310.tar.gz -C /usr/local/lib/python3.7/site-packages/ \
#	&& rm /root/pyarrow_0_11_0-37m-x86_64-alpine310.tar.gz

# Remove build environment
RUN apk del .build-deps

CMD ["python3"]
