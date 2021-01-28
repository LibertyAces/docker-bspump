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

FROM pypy:3.6-slim

LABEL maintainer="TeskaLabs Ltd (support@teskalabs.com)"

COPY --from=builder /usr/local/lib/python3.6/site-packages /usr/local/lib/python3.6/site-packages

EXPOSE 80/tcp

CMD ["pypy3", "-m", "bspump", "-w"]
