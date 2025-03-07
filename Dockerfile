FROM openjdk:11-jre-slim-sid

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl graphviz unzip \
  && rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get autoclean && apt-get autoremove

# URL from https://kaitai.io/#download-universal
ENV KAITAI_URL https://github.com/kaitai-io/kaitai_struct_compiler/releases/download/0.10/kaitai-struct-compiler-0.10.zip
RUN curl -SL ${KAITAI_URL} -o /tmp/kaitai-struct-compiler.zip && \
	unzip /tmp/kaitai-struct-compiler.zip -d /opt/ && \
	rm /tmp/kaitai-struct-compiler.zip && \
	mv /opt/$(basename ${KAITAI_URL%.*}) /opt/kaitai-struct-compiler && \
	chmod +x /opt/kaitai-struct-compiler/bin/kaitai-struct-compiler && \
	ln -s /opt/kaitai-struct-compiler/bin/kaitai-struct-compiler /usr/bin/ksc

VOLUME /pwd
WORKDIR /pwd
