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

RUN pip3 install git+https://github.com/LibertyAces/BitSwanPump.git
RUN pip3 install -U git+https://github.com/TeskaLabs/asab.git

RUN apt-get -y remove \
	git \
	gcc \
	g++ \
	python3.7-dev \
	libsnappy-dev

RUN apt-get -y autoremove

EXPOSE 80/tcp

CMD ["python3", "-m", "bspump", "-w"]
