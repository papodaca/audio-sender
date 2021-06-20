FROM ubuntu:20.04

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    supervisor \
    mpv \
    jackd2 \
    libjack-jackd2-0 \
    libjack-jackd2-dev \
    libsamplerate0 \
    libsamplerate0-dev \
    curl \
  && rm -rf /var/lib/apt/lists/* \
  && curl -Ls https://github.com/emfeng/mai/archive/refs/heads/master.tar.gz > mai.tar.gz \
  && tar xf mai.tar.gz \
  && cd mai-master \
  && make \
  && mv ./mai /usr/local/bin/ \
  && cd / \
  && rm -rf mai.tar.gz mai-master \
  && apt-get remove -y \
    build-essential \
    libjack-jackd2-dev \
    libsamplerate0-dev curl \
  && apt-get autoremove -y

COPY ./supervisor.conf /supervisor.conf
CMD ["supervisord", "-c", "/supervisor.conf"]
