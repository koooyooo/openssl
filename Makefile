#################################
# CA
#################################

# 秘密鍵の生成 (ca-privkey.pem)
gen-ca-priv-key:
	@ openssl genrsa -out ca-privkey.pem 2048

# 公開鍵の生成 (ca-pubkey.pem)
gen-ca-pub-key:
	@ openssl rsa -in ca-privkey.pem -pubout -out ca-pubkey.pem

# 証明書署名要求の生成 (ca-csr.pem)
gen-ca-csr:
	@ openssl req -new -key ca-privkey.pem -out ca-csr.pem

# 自己証明書の生成 (ca-cert.pem)
gen-ca-self-signed-cert:
	@ openssl x509 -req -in ca-csr.pem -signkey ca-privkey.pem -days 10000 -out ca-cert.pem


#################################
# Server
#################################

# 秘密鍵の生成 (srv-privkey.pem)
gen-srv-priv-key:
	@ openssl genrsa 2048 > srv-privkey.pem

# 公開鍵の生成 (srv-pubkey.pem)
gen-srv-pub-key:
	@ openssl rsa -in srv-privkey.pem -pubout -out srv-pubkey.pem

# 証明書署名要求の生成 (srv-csr.pem)
gen-srv-csr:
	@ openssl req -new -key srv-privkey.pem -out srv-csr.pem

# 証明書の生成 (srv-cert.pem)
gen-srv-cert:
	@ openssl x509 -req -in srv-csr.pem -CA ca-cert.pem -CAkey ca-privkey.pem -CAcreateserial -out srv-cert.pem

# p12ファイルの生成 (srv.p12)
gen-srv-p12:
	@ openssl pkcs12 -export -inkey srv-privkey.pem -in srv-cert.pem -out srv.p12
