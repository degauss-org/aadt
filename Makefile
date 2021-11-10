.PHONY: build test shell clean

build:
	docker build -t aadt .

test:
	docker run --rm -v "${PWD}/test":/tmp aadt my_address_file_geocoded.csv

shell:
	docker run --rm -it --entrypoint=/bin/bash -v "${PWD}/test":/tmp aadt

clean:
	docker system prune -f
