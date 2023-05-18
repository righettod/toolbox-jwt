#!/bin/bash
###########################################################################################
# Script to test an web service against the TICARPI attack playbook.
#
# Source of the tool (author):
#	https://github.com/ticarpi/jwt_tool
#	https://github.com/ticarpi/jwt_tool/wiki/Attack-Methodology
###########################################################################################	
if [ "$#" -lt 3 ]; then
    script_name=$(basename "$0")
    echo "Usage:"
    echo "   $script_name [ENDPOINT_FULL_URL] [CANARY_WORD] [VALID_JWT_TOKEN]"
    echo ""
    echo "Call example:"
    echo "    $script_name 'https://host.com/api/profile' 'righettod' 'eyJ0eXAiOiJ...'"
    exit 1
fi
endpoint=$1
canary=$2
token=$3
echo "[i] Edit the file '/root/.jwt_tool/jwtconf.ini' to define the configuration that must be used for the test."
echo "[i] By default HTTP GET requests are performed."
cd /work/jwt_tool
python3 jwt_tool.py -t "$endpoint" -M at -cv "$canary" -rh "Authorization: Bearer $token"