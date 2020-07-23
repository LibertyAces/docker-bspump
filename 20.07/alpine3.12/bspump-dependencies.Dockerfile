FROM alpine:3.12
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
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir aiohttp==3.6.2
RUN pip3 install --no-cache-dir aiozk==0.25.0
RUN pip3 install --no-cache-dir requests==2.24.0
RUN pip3 install --no-cache-dir aiokafka==0.6.0
RUN pip3 install --no-cache-dir aiosmtplib==1.1.3
RUN pip3 install --no-cache-dir fastavro==0.23.5
RUN pip3 install --no-cache-dir google-api-python-client==1.9.3
RUN pip3 install --no-cache-dir numpy==1.19.0
RUN pip3 install --no-cache-dir pandas==1.0.5
RUN pip3 install --no-cache-dir pika==1.1.0
RUN pip3 install --no-cache-dir pymysql==0.9.2
RUN pip3 install --no-cache-dir aiomysql==0.0.20
RUN pip3 install --no-cache-dir mysql-replication==0.21
RUN pip3 install --no-cache-dir pytz==2020.1
RUN pip3 install --no-cache-dir netaddr==0.7.20
RUN pip3 install --no-cache-dir pyyaml==5.3.1
RUN pip3 install --no-cache-dir pymongo==3.10.1
RUN pip3 install --no-cache-dir motor==2.1.0
RUN pip3 install --no-cache-dir mongoquery==1.3.6
RUN pip3 install --no-cache-dir pywinrm==0.4.1
RUN pip3 install --no-cache-dir python-snappy==0.5.4

# Remove build environment
RUN apk del .build-deps

CMD ["python3"]
