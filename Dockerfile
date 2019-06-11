# FROM mdillon/postgis:11-alpine
FROM mdillon/postgis:11


# Use reduced cmake file
COPY CMakeLists.txt /opt/nominatim/CMakeLists.txt

# FIXME maybe no need to build /opt/nominatim/build/nominatim/nominatim?
# FIXME remove not needed packages and files at end
# Build /opt/nominatim/build/module/nominatim.so
RUN apt update && apt install -y --no-install-recommends \
                build-essential \
                cmake \
                curl \
                ca-certificates \
                postgresql-server-dev-11 \
                zlib1g-dev \
                libbz2-dev \
                libxml2-dev \
        && mkdir -p /opt/nominatim && cd /opt/nominatim \
        && curl -sfSL https://github.com/openstreetmap/Nominatim/archive/v3.3.0.tar.gz \
                | tar -xz --directory /opt/nominatim --strip-components=1 \
                        Nominatim-3.3.0/module \
                        Nominatim-3.3.0/nominatim \
        && mkdir ./build && cd ./build \
        && cmake -DPostgreSQL_TYPE_INCLUDE_DIR=/usr/include/postgresql/ .. && make \
        && rm -rf /var/lib/apt/lists/*
