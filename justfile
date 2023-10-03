RSC_API_KEYS=tests/rsconnect_api_keys.json

dev: 
    tests/rsconnect_api_keys.json

dev-start:
	docker-compose up -d
	docker-compose exec -T rsconnect bash < setup-rsconnect/add-users.sh
	# curl fails with error 52 without a short sleep....
	sleep 5
	curl -s --retry 10 --retry-connrefused http://localhost:3939

dev-stop:
	docker-compose down
	rm -f $(RSC_API_KEYS)

$(RSC_API_KEYS): dev-start
	python setup-rsconnect/dump_api_keys.py $@