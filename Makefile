.PHONY: all

all: build push

build: download prepare
	docker build --rm -t olegfedoseev/phantomjs .
	docker tag olegfedoseev/phantomjs olegfedoseev/phantomjs:2.1.1

push:
	docker push olegfedoseev/phantomjs
	docker push olegfedoseev/phantomjs:2.1.1

download:
	rm -rf dist/ && mkdir dist/
	curl -skL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar -xj -C dist/
	mv dist/phantomjs-2.1.1-linux-x86_64/bin/phantomjs phantomjs && rm -rf dist/

prepare:
	docker rm -f ubuntu-donor || true
	docker run --name ubuntu-donor ubuntu:14.04 apt-get install --no-install-recommends -y --force-yes libfontconfig1 libfreetype6 gsfonts
	rm -rf usr/lib && mkdir -p usr/lib
	docker cp ubuntu-donor:/lib/x86_64-linux-gnu/libz.so.1.2.8 usr/lib/libz.so.1
	docker cp ubuntu-donor:/usr/lib/x86_64-linux-gnu/libfontconfig.so.1.8.0 usr/lib/libfontconfig.so.1
	docker cp ubuntu-donor:/usr/lib/x86_64-linux-gnu/libfreetype.so.6.11.1 usr/lib/libfreetype.so.6
	docker cp ubuntu-donor:/lib/x86_64-linux-gnu/libdl-2.19.so usr/lib/libdl.so.2
	docker cp ubuntu-donor:/lib/x86_64-linux-gnu/libexpat.so.1.6.0 usr/lib/libexpat.so.1
	docker cp ubuntu-donor:/lib/x86_64-linux-gnu/librt-2.19.so usr/lib/librt.so.1
	docker cp ubuntu-donor:/lib/x86_64-linux-gnu/libpng12.so.0.50.0 usr/lib/libpng12.so.0
	docker cp ubuntu-donor:/lib/x86_64-linux-gnu/libpthread-2.19.so usr/lib/libpthread.so.0
	docker cp ubuntu-donor:/usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.19 usr/lib/libstdc++.so.6
	docker cp ubuntu-donor:/lib/x86_64-linux-gnu/libgcc_s.so.1 usr/lib/libgcc_s.so.1

	rm -rf usr/share/fonts/ && mkdir -p usr/share/fonts/
	docker cp ubuntu-donor:/usr/share/fonts usr/share/

	rm -rf etc/fonts/ && mkdir -p etc/fonts/
	docker cp ubuntu-donor:/etc/fonts etc/

	docker rm -f ubuntu-donor || true
