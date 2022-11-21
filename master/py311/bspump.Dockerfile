FROM python:3.11 AS builder

RUN set -ex \
&& apt-get -y update \
&& apt-get -y upgrade

RUN set -ex \
&& apt-get -y install lsof

RUN apt-get -y install \
git \
gcc \
g++ \
libsnappy-dev

# https://github.com/confluentinc/confluent-kafka-python/issues/1452
RUN apt-get -y install git
RUN apt-get -y install curl make gcc g++ libc-dev libz-dev libzstd-dev
RUN curl -O -L https://github.com/edenhill/librdkafka/archive/v1.9.0.tar.gz --silent --fail \
	&& tar xzf v1.9.0.tar.gz \
	&& cd librdkafka-1.9.0 \
	&& ./configure \
	&& cd src \
	&& make \
	&& make install
RUN ldconfig

RUN pip3 install git+https://github.com/LibertyAces/BitSwanPump.git
RUN pip3 uninstall -y asab
RUN pip3 install -U git+https://github.com/TeskaLabs/asab.git

FROM python:3.11-slim

LABEL maintainer="TeskaLabs Ltd (support@teskalabs.com)"

COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin/asab-manifest.py /usr/local/bin/asab-manifest.py

EXPOSE 80/tcp

CMD ["python3", "-m", "bspump", "-w"]
