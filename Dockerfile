# TODO: change permitrootlogin option in sshd_config
FROM kalilinux/kali-linux-docker

RUN apt update
RUN apt upgrade -y
RUN apt install -y xvfb \
                    x11vnc \
                    i3 \
                    ssh \
                    locales

RUN wget https://www.torproject.org/dist/torbrowser/8.5.4/tor-browser-linux64-8.5.4_en-US.tar.xz

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
