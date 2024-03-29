FROM python:3.7-slim-buster AS builder

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
RUN pip3 uninstall -y asab
RUN pip3 install -U git+https://github.com/TeskaLabs/asab.git

FROM python:3.7-slim-buster

LABEL maintainer="TeskaLabs Ltd (support@teskalabs.com)"

COPY --from=builder /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages
COPY --from=builder /usr/local/bin/asab-manifest.py /usr/local/bin/asab-manifest.py

EXPOSE 80/tcp

CMD ["python3", "-m", "bspump", "-w"]
