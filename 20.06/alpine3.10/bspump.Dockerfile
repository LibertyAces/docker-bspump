FROM teskalabs/bspump-dependencies:master-alpine3.10
MAINTAINER TeskaLabs Ltd (support@teskalabs.com)

RUN pip3 install -e git://github.com/LibertyAces/BitSwanPump.git@v20.06#egg=bspump
RUN pip3 install -e  git://github.com/TeskaLabs/asab.git@v20.06#egg=asab

EXPOSE 80/tcp

CMD ["python3", "-m", "bspump", "-w"]
