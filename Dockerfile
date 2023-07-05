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
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y python3.8 python3-pip python3-gmpy2 ruby ruby-dev openssl libssl-dev curl wget make nano vim iputils-ping nmap flatpak 
RUN mkdir /work
WORKDIR /work
COPY . .
RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
RUN flatpak install -y flathub org.freedesktop.Platform//22.08
RUN flatpak --bundle john.flatpak
RUN rm Dockerfile LICENSE project.code-workspace .gitignore .gitmodules install-john.sh 
RUN rm -rf .git .github .vscode
RUN pip3 install -r rsa_sign2n/standalone/requirements.txt
RUN pip3 install -r jwt_tool/requirements.txt
RUN pip3 install PyJWT
RUN gem install ecdsa openssl base64
RUN wget -q -O /tmp/rockyou.tgz https://github.com/danielmiessler/SecLists/raw/master/Passwords/Leaked-Databases/rockyou.txt.tar.gz
RUN tar -xvf /tmp/rockyou.tgz
RUN rm /tmp/rockyou.tgz
RUN iconv -f ISO-8859-1 -t UTF-8//TRANSLIT /work/rockyou.txt -o /work/rockyou-converted.txt
RUN mv /work/rockyou-converted.txt /work/rockyou.txt
RUN chmod -R +x *
RUN echo "alias ll='ls -rtl' >> /root/.bashrc"
RUN echo "export PATH=$PATH:/work/john/run >> /root/.bashrc"
RUN cd jwt_tool;python3 jwt_tool.py eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbiI6InRpY2FycGkifQ.bsSwqj2c2uI9n7-ajmi3ixVGhPUiY7jO9SUn9dm15Po;echo 0
RUN cd jwt_tool;python3 jwt_tool.py eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbiI6InRpY2FycGkifQ.bsSwqj2c2uI9n7-ajmi3ixVGhPUiY7jO9SUn9dm15Po;echo 0
RUN apt autoremove -y
RUN apt autoclean -y

