FROM ubuntu:latest

# Install tippeacanoe
RUN apt-get update && apt-get -y install \
		git \
		make \
		build-essential \
		g++ \
		libsqlite3-0 \
		libsqlite3-dev \
		zlib1g-dev \
		nodejs \
		npm \
		jq \
	&& \
	mkdir -p /tmp/build && cd /tmp/build && \
  git clone https://github.com/mapbox/tippecanoe.git && \
  cd tippecanoe && \
  make -j2 && \
  make install && \
	cd /tmp && \
	rm -r /tmp/build && \
	npm install -g @geolonia/cli@0.0.10 && \
	apt-get remove -y git make build-essential g++ zlib1g-dev libsqlite3-dev && \
	apt-get autoremove -y && \
	rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
