FROM ubuntu:20.04
LABEL org.opencontainers.image.authors="dominique.righetto@gmail.com"
LABEL org.opencontainers.image.vendor="Dominique RIGHETTO (righettod)"
LABEL org.opencontainers.image.url="https://github.com/righettod/toolbox-jwt"
LABEL org.opencontainers.image.source="https://github.com/righettod/toolbox-jwt"
LABEL org.opencontainers.image.documentation="https://github.com/righettod/toolbox-jwt"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.title="toolbox-jwt"
LABEL org.opencontainers.image.description="Customized toolbox to perform different attacks against JWT tokens"
LABEL org.opencontainers.image.base.name="righettod/toolbox-jwt:main"
RUN apt update
RUN apt install -y python3.8 python3-pip python3-gmpy2 ruby ruby-dev openssl libssl-dev curl wget make nano vim
RUN mkdir /work
WORKDIR /work
COPY . . 
RUN rm Dockerfile LICENSE project.code-workspace
RUN pip3 install -r rsa_sign2n/standalone/requirements.txt
RUN pip3 install -r jwt_tool/requirements.txt
RUN gem install ecdsa openssl base64
RUN chmod -R +x *
RUN echo "alias ll='ls -rtl' >> /root/.bashrc"
