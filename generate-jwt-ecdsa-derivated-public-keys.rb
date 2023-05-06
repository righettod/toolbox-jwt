require 'ecdsa'
require 'digest/sha2'
require 'openssl'
require 'base64'

=begin
Script to generate derivated ECDSA public keys from a JWT ECDSA signed token.
To goal is to test exposure to algorithm confusion attacks on token using ECDSA key pair.

Dependencies:
	gem install ecdsa

Source of the script (author):
	https://blog.pentesterlab.com/exploring-algorithm-confusion-attacks-on-jwt-exploiting-ecdsa-23f7ff83390f
=end

# We take the token from the command line
token = ARGV[0]

# We use Secp256r1
group = ECDSA::Group::Secp256r1

# We split the token to get the data to digest and the signature
parts = token.split('.')
data=parts[0]+"."+parts[1]
signature_b64 = parts[2]

# we compute the 
digest = Digest::SHA2.digest(data)

# we create an ECDSA::Signature from the JWT signature 
signature_bytes = Base64.urlsafe_decode64(signature_b64)

r = ECDSA::Format::IntegerOctetString.decode signature_bytes[0..31]
s = ECDSA::Format::IntegerOctetString.decode signature_bytes[32..-1]
signature  = ECDSA::Signature.new(r,s)

# We recover all the potential keys in an array
keys = ECDSA.recover_public_key(group, digest, signature).to_a

# Finally, we use OpenSSL to get the keys in a pem format.
group = OpenSSL::PKey::EC::Group.new('prime256v1')
ec_key = OpenSSL::PKey::EC.new(group)

keys.each do |point| 
  ec_point = OpenSSL::PKey::EC::Point.new(group, ECDSA::Format::PointOctetString.encode(point))
  ec_key.public_key = ec_point
  puts "[+] Key:"
  puts ec_key.to_pem
end