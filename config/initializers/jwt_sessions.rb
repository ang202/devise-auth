JWTSessions.encryption_key = Rails.application.credentials[:secret_key_base]
JWTSessions.algorithm   = "RS256"
JWTSessions.private_key = OpenSSL::PKey::RSA.generate(2048)
JWTSessions.public_key  = JWTSessions.private_key.public_key