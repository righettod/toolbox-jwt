FROM ubuntu:24.04
LABEL org.opencontainers.image.authors="dominique.righetto@gmail.com"
LABEL org.opencontainers.image.vendor="Dominique RIGHETTO (righettod)"
LABEL org.opencontainers.image.url="https://github.com/righettod/toolbox-jwt"
LABEL org.opencontainers.image.source="https://github.com/righettod/toolbox-jwt"
LABEL org.opencontainers.image.documentation="https://github.com/righettod/toolbox-jwt"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.title="toolbox-jwt"
LABEL org.opencontainers.image.description="Customized toolbox to perform different attacks against JWT tokens"
LABEL org.opencontainers.image.base.name="righettod/toolbox-jwt:main"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y curl dnsutils dos2unix gcc git highlight iputils-ping libffi-dev libssl-dev make nano nmap openssl python-is-python3 python3 python3-dev python3-gmpy2 python3-pip python3-setuptools python3-venv ruby ruby-dev vim wget zsh
RUN mkdir /work
WORKDIR /work
COPY *.sh .
COPY *.rb .
RUN dos2unix *.sh *.rb
RUN chmod +x *.sh
RUN bash install.sh
ENV PATH="/work/pyenv/bin:$PATH"
RUN echo "alias ll='ls -rtl'" >> /root/.bashrc
RUN echo "alias print-jwt='python /work/jwt_tool/jwt_tool.py'" >> /root/.bashrc
RUN echo "alias cat-colorized='highlight -O ansi --force'" >> /root/.bashrc
RUN echo "alias jwtconfig-edit='nano /root/.jwt_tool/jwtconf.ini'" >> /root/.zshrc
RUN apt autoremove -y
RUN apt autoclean -y
RUN rm install.sh
RUN rm -rf /tmp/*
RUN rm -rf /var/lib/apt/lists/*