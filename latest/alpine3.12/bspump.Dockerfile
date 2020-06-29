FROM teskalabs/bspump-dependencies:master-alpine3.12
MAINTAINER TeskaLabs Ltd (support@teskalabs.com)

RUN pip3 install git+https://github.com/LibertyAces/BitSwanPump.git
RUN pip3 install -U git+https://github.com/TeskaLabs/asab.git

EXPOSE 80/tcp

CMD ["python3", "-m", "bspump", "-w"]
