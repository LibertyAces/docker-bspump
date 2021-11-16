FROM python:3.8-slim
MAINTAINER TeskaLabs Ltd (support@teskalabs.com)

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

RUN python3 -m pip install bspump==21.11
RUN python3 -m pip install asab==21.11

RUN apt-get -y remove \
	git \
	gcc \
	g++ \
	libsnappy-dev

# Cleanup
RUN apt-get -y remove gcc \
	&& apt-get -y clean autoclean \
	&& apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 80/tcp

CMD ["python3", "-m", "bspump", "-w"]
