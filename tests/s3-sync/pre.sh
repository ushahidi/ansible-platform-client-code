#!/bin/bash

# install required awscli
pip install awscli

# download and leave the built bundle accessible at /usr/src/ushahidi-platform-client-bundle
client_bundle_version=v3.5.1

set -e

curl -L https://github.com/ushahidi/platform-client/releases/download/v3.5.1/ushahidi-platform-client-bundle-${client_bundle_version}.tar.gz \
	| tar -C /usr/src -xz

mv /usr/src/ushahidi-platform-client-bundle-${client_bundle_version} /usr/src/ushahidi-platform-client-bundle

# create patched aws script entrypoint that will point to minio target
target_host=${TARGET_HOST:-target}
target_port=${TARGET_PORT:-9000}
## (look for legacy linking environment variablles)
target_host=${TARGET_PORT_9000_TCP_ADDR:-$target_host}
target_port=${TARGET_PORT_9000_TCP_PORT:-$target_port}

cat > /usr/bin/aws-minio <<EOF
#!/bin/bash
exec aws --endpoint-url http://${target_host}:${target_port} "\$@"
EOF
chmod +x /usr/bin/aws-minio

# configure signature version to v4
aws configure set default.s3.signature_version s3v4

# create test bucket
aws-minio s3 mb s3://platform-client-code-test

# overwrite /etc/ansible/hosts to use local
cat >/etc/ansible/hosts <<EOF
target ansible_connection=local
EOF
