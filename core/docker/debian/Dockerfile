FROM debian:12.6

RUN apt-get update && apt-get install -y \
	locales \
	pipx \
	git \
	sudo \
	openssl

RUN useradd -m -N -s /bin/bash -u 1000 -p $(openssl passwd -6 test) test-user && \
    usermod -aG sudo test-user  

RUN rm -rf /var/lib/apt/lists/* && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN mkdir -p ~/.my/dotfiles/

ENV LANG=en_US.utf8

USER test-user
WORKDIR /home/test-user/.my/dotfiles/
COPY --chown=test-user:test-user . .
