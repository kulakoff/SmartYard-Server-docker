PROGNAME=$(basename $0)

if test -z ${ASTERISK_VERSION}; then
  echo "${PROGNAME}: ASTERISK_VERSION required" >&2
  exit 1
fi

set -ex

# useradd --system asterisk
groupadd asterisk
useradd -g asterisk -s /bin/true -d /var/lib/asterisk asterisk

apt-get update -qq

DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
    gcc \
    g++ \
    make \
    autoconf \
    binutils-dev \
    build-essential \
    ca-certificates \
    curl \
    file \
    libcurl4-openssl-dev \
    libedit-dev \
    libgsm1-dev \
    libogg-dev \
    libpopt-dev \
    libresample1-dev \
    libspandsp-dev \
    libspeex-dev \
    libspeexdsp-dev \
    libsqlite3-dev \
    libsrtp2-dev \
    libssl-dev \
    libvorbis-dev \
    libxml2-dev \
    libxslt1-dev \
    procps \
    portaudio19-dev \
    unixodbc \
    unixodbc-bin \
    unixodbc-dev \
    odbcinst \
    uuid \
    uuid-dev \
    xmlstarlet \
    lua5.3 \
    liblua5.3-dev \
    lua-cjson \
    luarocks

apt-get purge -y --auto-remove

rm -rf /var/lib/apt/lists/*

lua -v

luarocks install inspect
luarocks install luasocket
luarocks install luasec
luarocks install lua-cjson 2.1.0-1

mkdir -p /usr/src/asterisk

cd /usr/src/asterisk

curl -vsL https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${ASTERISK_VERSION}.tar.gz | tar --strip-components 1 -xz || \

# 1.5 jobs per core works out okay
: ${JOBS:=$(( $(nproc) + $(nproc) / 2 ))}

./configure  --with-jansson-bundled
make menuselect.makeopts
./menuselect/menuselect --enable codec_opus --disable CORE-SOUNDS-EN-GSM --enable CORE-SOUNDS-EN-WAV --enable CORE-SOUNDS-RU-WAV --enable MOH-OPSOUND-WAV

make -j `nproc` && make install