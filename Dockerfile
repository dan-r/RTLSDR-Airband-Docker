FROM ubuntu:latest  
RUN apt-get update && apt-get install -y libmp3lame-dev libconfig++-dev libfftw3-dev librtlsdr-dev gnupg build-essential cmake pkg-config wget

# Needed to install libshout 2.4.1. Newest version does not update icecast metadata correctly
RUN bash -c "echo 'deb http://ports.ubuntu.com/ubuntu-ports/ bionic main' >> /etc/apt/sources.list"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && apt-get update && apt-get install -y --allow-downgrades libshout3=2.4.1-2build1 libshout3-dev=2.4.1-2build1

RUN mkdir /build
WORKDIR /build
RUN wget -O RTLSDR-Airband.tar.gz https://github.com/szpajder/RTLSDR-Airband/archive/v4.0.2.tar.gz
RUN tar xvfz RTLSDR-Airband.tar.gz --strip-components=1
RUN mkdir build
WORKDIR /build/build
RUN cmake ../ && make && cp /build/build/src/rtl_airband /bin/
RUN cd / && rm -rf /build /var/lib/apt/lists/*

RUN mkdir /config
COPY rtl_airband.conf.sample /
COPY start.sh /start.sh
RUN chmod +x /bin/rtl_airband && chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
