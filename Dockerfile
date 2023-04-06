FROM ubuntu:jammy
RUN apt-get update && apt-get install -y libmp3lame-dev libconfig++-dev libfftw3-dev librtlsdr-dev gnupg build-essential cmake pkg-config wget libshout3 libshout3-dev

RUN mkdir /build
WORKDIR /build
RUN wget -O RTLSDR-Airband.tar.gz https://github.com/charlie-foxtrot/RTLSDR-Airband/archive/v4.0.3.tar.gz
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
