# TODO: change permitrootlogin option in sshd_config
FROM kalilinux/kali-rolling

RUN apt update
RUN apt upgrade -y
RUN apt install -y xvfb \
                    x11vnc \
                    i3 \
                    ssh \
                    wget \
                    locales

RUN wget https://dist.torproject.org/torbrowser/14.0.4/tor-browser-linux-x86_64-14.0.4.tar.xz

RUN sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "root:root" | chpasswd

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
