#!/bin/bash
cd /work
echo "[+] Python env setup..."
python -m venv pyenv
chmod -R +x pyenv
source pyenv/bin/activate
echo "[+] Install components..."
git clone --depth 1 https://github.com/ticarpi/jwt_tool.git jwt_tool
git clone --depth 1 https://github.com/silentsignal/rsa_sign2n.git rsa_sign2n
wget -q -O /tmp/yq https://github.com/mikefarah/yq/releases/download/v4.52.2/yq_linux_amd64
chmod +x /tmp/yq
/tmp/yq -r '.project.dependencies[]' rsa_sign2n/standalone/pyproject.toml > /tmp/req.txt
pip install PyJWT
pip install -r jwt_tool/requirements.txt
pip install -r /tmp/req.txt
gem install ecdsa openssl base64
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
chmod -R +x *
echo "[+] Validate the correct installation..."
cd jwt_tool
python jwt_tool.py "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbiI6InRpY2FycGkifQ.bsSwqj2c2uI9n7-ajmi3ixVGhPUiY7jO9SUn9dm15Po";echo 0
python jwt_tool.py "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbiI6InRpY2FycGkifQ.bsSwqj2c2uI9n7-ajmi3ixVGhPUiY7jO9SUn9dm15Po";echo 0
cd ..
ruby generate-jwt-ecdsa-derivated-public-keys.rb "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.Iz_M0cIFVVjr9PYLRpaLzLCQzWOCxyU9T4AFElKWuEFZ-eEIDXNL7b8gOg0KqywmpALiC0W74d8zmXvc_VqGdQ"
## Take too many time so skipped bt keep the line for a manual test
#bash generate-jwt-rsa-derivated-public-keys.sh "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyMTIzIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNzc5MDAxMzczLCJleHAiOjE3NzkwMDQ5NzN9.DuhYTsXwlkQ3_XznoLNDoqejGsYe95XYs5b_VpdxAIPobP3W6tCSWJbwZf-ddRxBnZD5nW5jvksPqNSHU7zuLyl4r35JWVrG5qeROqa7oUlfxEJgmRiodn1_6tsjOdlAOH1q5BVrORc-mKWCr0deGacpD8Lq4x3uNuHpxWto21R9y3sZROzduiV4jq8SvterpEUYXzh_K6al6pKcAEOvIHawO0thEEag8A3LGB8Y6MBVrkZ4lECWNdqDm_eNijLAxgCeIzhV4xlR71exuBfGsZK3gnevo_23_3eVRzhvSzkn_KOGJ09lydGw5pmSy6dnKKQLZXd3C20Lta4UBM7wDQ" "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyMTIzIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNzc5MDAxMzczLCJleHAiOjE3NzkwMDQ5NzN9.DuhYTsXwlkQ3_XznoLNDoqejGsYe95XYs5b_VpdxAIPobP3W6tCSWJbwZf-ddRxBnZD5nW5jvksPqNSHU7zuLyl4r35JWVrG5qeROqa7oUlfxEJgmRiodn1_6tsjOdlAOH1q5BVrORc-mKWCr0deGacpD8Lq4x3uNuHpxWto21R9y3sZROzduiV4jq8SvterpEUYXzh_K6al6pKcAEOvIHawO0thEEag8A3LGB8Y6MBVrkZ4lECWNdqDm_eNijLAxgCeIzhV4xlR71exuBfGsZK3gnevo_23_3eVRzhvSzkn_KOGJ09lydGw5pmSy6dnKKQLZXd3C20Lta4UBM7wDQ"