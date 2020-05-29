FROM ubuntu:18.04
MAINTAINER TeskaLabs Ltd (support@teskalabs.com)

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN set -ex \
	&& apt-get -y update \
	&& apt-get -y upgrade \
	&& apt-get -y install git

RUN set -ex \
	&& apt-get -y install libboost-all-dev \
	&& apt-get -y install libssl1.0 \
	&& apt-get -y install python3.7

## Switch Python3.6 to Python3.7
RUN apt-get -y install python3-pip
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
RUN update-alternatives --config python3

# Create build environment so that dependencies like aiohttp can be build
RUN set -ex \
	&& apt-get -y install python3.7-dev \
	&& apt-get -y install libffi-dev \
	&& apt-get -y install libssl-dev \
	&& apt-get -y install gcc \
	&& apt-get -y install g++ \
	&& apt-get -y install musl-dev \
	&& pip3 install Cython

RUN set -ex \
	&& apt-get -y install libsnappy-dev

# Pyarrow
RUN set -ex \
	&& pip3 install pyarrow

RUN set -ex \
	&& pip3 install aiohttp \
	&& pip3 install aiomysql \
	&& pip3 install aiokafka \
	&& pip3 install pika \
	&& pip3 install six \
	&& pip3 install mongoquery \
	&& pip3 install numpy \
	&& pip3 install pandas \
	&& pip3 install aiozk \
	&& pip3 install pyyml

RUN set -ex \
	&& pip3 install python-snappy

RUN set -ex \
	&& apt-get -y install lsof

EXPOSE 80/tcp

CMD ["python3"]
