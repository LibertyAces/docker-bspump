FROM pypy:3.6-slim
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
	libsnappy-dev \
	libssl-dev

RUN pypy3 -m pip install pybind11
RUN pypy3 -m pip install pandas

RUN pypy3 -m pip install git+https://github.com/LibertyAces/BitSwanPump.git@simdjson
RUN pypy3 -m pip install -U git+https://github.com/TeskaLabs/asab.git

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

CMD ["pypy3", "-m", "bspump", "-w"]
