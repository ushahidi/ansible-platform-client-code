#!/bin/bash

# download and leave the built bundle accessible at /usr/src/ushahidi-platform-client-bundle
client_bundle_version=v3.5.1

set -e

curl -L https://github.com/ushahidi/platform-client/releases/download/v3.5.1/ushahidi-platform-client-bundle-${client_bundle_version}.tar.gz \
	| tar -C /usr/src -xz

mv /usr/src/ushahidi-platform-client-bundle-${client_bundle_version} /usr/src/ushahidi-platform-client-bundle
