FROM teskalabs/bspump-dependencies:20.06-alpine3.8
MAINTAINER TeskaLabs Ltd (support@teskalabs.com)

RUN pip3 install --no-dependencies -e git://github.com/LibertyAces/BitSwanPump.git@v20.07#egg=bspump
RUN pip3 install -e  git://github.com/TeskaLabs/asab.git@v20.07#egg=asab

EXPOSE 80/tcp

CMD ["python3", "-m", "bspump", "-w"]
