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
RUN sudo apt install software-properties-common
RUN sudo add-apt-repository ppa:deadsnakes/ppa
RUN apt install -y python3.11 python3-pip python3-gmpy2 ruby ruby-dev openssl libssl-dev curl wget make nano vim iputils-ping nmap zsh dos2unix dnsutils git highlight
RUN mkdir /work
WORKDIR /work
COPY . .
RUN rm Dockerfile LICENSE project.code-workspace .gitignore .gitmodules 
RUN rm -rf .git .github .vscode
RUN wget -q -O /tmp/yq https://github.com/mikefarah/yq/releases/download/v4.52.2/yq_linux_amd64
RUN chmod +x /tmp/yq
RUN /tmp/yq -r '.project.dependencies[]' rsa_sign2n/standalone/pyproject.toml > /tmp/req.txt
RUN pip3 install -r /tmp/req.txt
RUN pip3 install -r jwt_tool/requirements.txt
RUN pip3 install PyJWT
RUN rm /tmp/req.txt /tmp/yq
RUN gem install ecdsa openssl base64
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN chmod -R +x *
RUN echo "alias ll='ls -rtl'" >> /root/.bashrc
RUN echo "alias print-jwt='python3 /work/jwt_tool/jwt_tool.py'" >> /root/.bashrc
RUN echo "alias cat-colorized='highlight -O ansi --force'" >> /root/.bashrc
RUN echo "alias ll='ls -rtl'" >> /root/.zshrc
RUN echo "alias print-jwt='python3 /work/jwt_tool/jwt_tool.py'" >> /root/.zshrc
RUN echo "alias cat-colorized='highlight -O ansi --force'" >> /root/.zshrc
RUN echo "alias jwtconfig-edit='nano /root/.jwt_tool/jwtconf.ini'" >> /root/.zshrc
RUN cd jwt_tool;python3 jwt_tool.py eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbiI6InRpY2FycGkifQ.bsSwqj2c2uI9n7-ajmi3ixVGhPUiY7jO9SUn9dm15Po;echo 0
RUN cd jwt_tool;python3 jwt_tool.py eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbiI6InRpY2FycGkifQ.bsSwqj2c2uI9n7-ajmi3ixVGhPUiY7jO9SUn9dm15Po;echo 0
RUN apt autoremove -y
RUN apt autoclean -y

