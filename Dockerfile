FROM ubuntu:latest

# Install tippeacanoe
RUN apt-get update && apt-get -y install \
	git \
	make \
	build-essential \
	g++ \
	libsqlite3-dev \
	zlib1g-dev && \
  git clone https://github.com/mapbox/tippecanoe.git && \
  cd tippecanoe && \
  make -j && \
  make install

RUN apt-get -y install gdal-bin

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
