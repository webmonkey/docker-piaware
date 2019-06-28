FROM debian:stretch

RUN apt-get update
RUN apt-get install -y build-essential debhelper tcl8.6-dev autoconf python3-dev python3-venv dh-systemd libz-dev wget git libboost-all-dev
WORKDIR /tmp
RUN git clone https://github.com/flightaware/piaware_builder.git
WORKDIR piaware_builder
RUN sh sensible-build.sh stretch
WORKDIR package-stretch
RUN dpkg-buildpackage -b


FROM debian:stretch
COPY --from=0 /tmp/piaware_builder/piaware_*.deb /tmp/
RUN apt-get update
RUN apt install --yes /tmp/piaware_*.deb
RUN piaware-config receiver-type other && \
    piaware-config receiver-host decoder && \
    piaware-config receiver-port 30005
CMD piaware -debug
