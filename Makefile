cert:
	echo "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth" > tmp_openssl.cnf
	openssl req -x509 \
		-out ./certs/priv.crt \
		-keyout ./certs/priv.key \
		-newkey rsa:2048 \
		-nodes -sha256 \
		-subj "/CN=localhost" \
		-extensions EXT \
		-config tmp_openssl.cnf
	rm tmp_openssl.cnf

run:
	docker compose up -d

clean:
	docker compose down && docker system prune --volumes -f

build:
	docker compose pull
	docker compose up --build