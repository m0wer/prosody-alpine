# Prosody Docker based on Alpine Linux

Basic XMPP server using `prosody`. Simple and lightweight.

## Building the image

`./docker-build.sh`

## Configuration

You need at least to configure *prosody.cfg.lua* and provide it to the container.

You can download an example configuration file from [hg.prosody.im](https://hg.prosody.im/0.9/raw-file/tip/prosody.cfg.lua.dist) or modify the one provided.

You need to set `daemonize = false` in *Server-wide settings*. It is also a good idea to enale logging to **console**. This modifications are already done in the provided configuration file.

Also, configure it to fit your needs: change the virtual hosts domain, provide certificates, enable modules, setup a database...

## Running the container

`docker run -d --name prosody -p 5222:5222 -p 5269:5269 -v [path to configuration file]:/etc/prosody/prosody.cfg.lua:ro m0wer/prosody-alpine`

You may also want to mount the certificates folder and some modules.

To mount the certificates and the configuration:

`docker run -d --name prosody -p 5222:5222 -p 5269:5269 -v [key path]:/etc/prosody/certs/localhost.key:ro -v [crt path]:/etc/prosody/certs/localhost.crt:ro -v [path to configuration file]:/etc/prosody/prosody.cfg.lua:ro m0wer/prosody`

<!-- Commented until alpine updates to prosody 0.10 (https://pkgs.alpinelinux.org/package/v3.6/community/x86_64/prosody) If you use the provided config file, you neet to mount the certificates in */etc/prosody/certs/example.com.crt* and */etc/prosody/certs/example.com.key* as described in [prosody-doc](https://prosody.im/doc/certificates). -->

If you provide the enviroment variables **LOCAL** (user), **PASSWORD** (pass) and **DOMAIN** (virutalhost) the user will be registered.

`docker run -d --name prosody -p 5222:5222 -p 5269:5269 -v [key path]:/etc/prosody/certs/localhost.key:ro -v [crt path]:/etc/prosody/certs/localhost.crt:ro -v [path to configuration file]:/etc/prosody/prosody.cfg.lua:ro -e "LOCAL=test" -e "PASSWORD=test" -e "DOMAIN=localhost" m0wer/prosody`

**Note**: If you don't use a database as a backend for the persistent data, you have to preserve a data volume and mount it each time. For example `-v prosody-data:/var/lib/prosody`.

## Testing

You can test the image generating an SSL certificate and running the image with minimal configuration.

Create the certificates:

`openssl req -x509 -nodes -subj '/CN=localhost' -days 365 -newkey rsa:4096 -sha256 -keyout localhost.key -out localhost.crt`

Run the container:

`docker run -d --rm --name prosody -p 5222:5222 -p 5269:5269 -v `pwd`/localhost.key:/etc/prosody/certs/localhost.key:ro -v `pwd`/localhost.crt:/etc/prosody/certs/localhost.crt:ro m0wer/prosody`
