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
  make -j2 && \
  make install

# Install Geolonia
RUN apt-get install -y nodejs npm && npm install -g @geolonia/cli@0.0.7

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
