FROM alpine:3.7
LABEL maintainer="Devin Alexander Torres <d@devinus.io>"

RUN apk add --update --no-cache git cmake build-base boost-dev

ENV RAI_VERSION 8.0
WORKDIR /tmp
RUN git clone https://github.com/clemahieu/raiblocks.git

WORKDIR /tmp/raiblocks
RUN git checkout V${RAI_VERSION}
RUN git submodule init
RUN git submodule update
RUN cmake .
RUN make
RUN mv rai_node /usr/local/bin
RUN rm -rf /tmp/raiblocks

RUN addgroup -S rai
RUN adduser -Sh /RaiBlocks rai
USER rai
WORKDIR /RaiBlocks

EXPOSE 7075 7075/udp 7076
CMD ["rai_node", "--daemon"]
