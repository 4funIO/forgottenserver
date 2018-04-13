FROM debian:buster-slim AS build

RUN apt-get update -y \
	&& apt-get install -y --no-install-recommends \
		cmake make clang gcc \
		# build packages
		libboost-dev \
		libboost-system-dev \
		libboost-iostreams-dev \
		libgmp-dev \
		liblua5.2-dev \
		libluajit-5.1-dev \
		# libmysqlclient-dev \
		default-libmysqlclient-dev \
		libpugixml-dev \
	&& apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY . /tfs

ENV LUAJIT "OFF"

RUN mkdir /tfs/build \
	&& cd /tfs/build \
	&& cmake -DCMAKE_BUILD_TYPE=Release -DUSE_LUAJIT=$LUAJIT .. \
	&& make -j2

FROM debian:buster-slim

RUN apt-get update -y \
	&& apt-get install -y --no-install-recommends \
		libmariadbclient18 \
		libboost-iostreams1.62.0 \
		libboost-regex1.62.0 \
		libboost-system1.62.0 \
		libgmp10 \
		liblua5.2 \
		libpugixml1v5 \
	&& apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/tfs
COPY --from=build /tfs/build/tfs /opt/tfs/
# assets
COPY --from=build /tfs/config.lua.dist /opt/tfs/
COPY --from=build /tfs/data /opt/tfs/data
COPY --from=build /tfs/schema.sql /opt/tfs/

WORKDIR "/opt/tfs"
EXPOSE 7171 7172

ENTRYPOINT ["/opt/tfs/tfs"]
