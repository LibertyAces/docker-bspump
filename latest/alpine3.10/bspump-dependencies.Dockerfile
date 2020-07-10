FROM alpine:3.10
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
COPY ./pyarrow-0.17.1.latest553+gdd5b76816.d20200630-cp37-cp37m-linux_x86_64.whl /root/pyarrow-0.17.1.latest553+gdd5b76816.d20200630-cp37-cp37m-linux_x86_64.whl
RUN pip3 install /root/pyarrow-0.17.1.latest553+gdd5b76816.d20200630-cp37-cp37m-linux_x86_64.whl
RUN rm /root/pyarrow-0.17.1.latest553+gdd5b76816.d20200630-cp37-cp37m-linux_x86_64.whl

# Remove build environment
RUN apk del .build-deps

CMD ["python3"]
