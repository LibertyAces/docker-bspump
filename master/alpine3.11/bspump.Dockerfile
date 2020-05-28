FROM teskalabs/bspump-dependencies:master-alpine3.11
MAINTAINER TeskaLabs Ltd (support@teskalabs.com)

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN set -ex \
	&& pip install requests

RUN set -ex \
	&& pip install git+https://github.com/TeskaLabs/asab.git

RUN set -ex \
	&& pip install git+https://github.com/LibertyAces/BitSwanPump.git --no-deps

CMD ["python3", "-m", "bspump", "-w"]
