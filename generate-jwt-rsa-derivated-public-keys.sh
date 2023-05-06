#!/bin/bash
###########################################################################################
# Script to generate derivated RSA public keys from a JWT RSA signed token.
# To goal is to test exposure to algorithm confusion attacks on token using RSA key pair.
#
# Source of the scripts (author):
#	https://github.com/PortSwigger/rsa_sign2n
#	https://github.com/silentsignal/rsa_sign2n
#	https://blog.silentsignal.eu/2021/02/08/abusing-jwt-public-keys-without-the-public-key/
###########################################################################################	
if [ "$#" -lt 2 ]; then
    script_name=$(basename "$0")
    echo "Usage:"
    echo "   $script_name [JWT_TOKEN_1] [JWT_TOKEN_2]"
    echo ""
    echo "Call example:"
    echo "    $script_name 'eyJ0eXAiOiJ...' 'eyJ0eXAiOiJ...'"
    exit 1
fi
token1=$1
token2=$2
cdir=$(pwd)
cd /work/rsa_sign2n/standalone
python3 jwt_forgery.py "$token1" "$token2"