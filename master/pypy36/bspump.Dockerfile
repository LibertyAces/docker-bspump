FROM pypy:3.6-slim AS builder

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

RUN pypy3 -m pip install git+https://github.com/LibertyAces/BitSwanPump.git
RUN pypy3 -m pip install -U git+https://github.com/TeskaLabs/asab.git

LABEL maintainer="TeskaLabs Ltd (support@teskalabs.com)"

# Cleanup
# TODO find out how to use staged build for pypy
RUN apt-get -y remove gcc \
	&& apt-get -y clean autoclean \
	&& apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 80/tcp

CMD ["pypy3", "-m", "bspump", "-w"]
