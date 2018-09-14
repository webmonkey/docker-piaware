build:
	docker build -t webmonkey/piaware .

run:
	docker run  --network adsb-containers_adsb --rm -it webmonkey/piaware bash
