FROM ubuntu:latest

# Install tippeacanoe
RUN apt-get update && apt-get -y install \
	git \
	make \
	build-essential \
	g++ \
	libsqlite3-dev \
	zlib1g-dev
RUN git clone https://github.com/mapbox/tippecanoe.git && \
  cd tippecanoe && \
  make -j && \
  make install

# Install mb-util
RUN apt-get install -y python3 python3-setuptools python-is-python3
RUN git clone https://github.com/mapbox/mbutil.git
RUN cd mbutil && python setup.py install

RUN apt-get install -y jq

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
