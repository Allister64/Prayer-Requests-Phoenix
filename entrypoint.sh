#!/bin/bash

if [ -e ./.production ]; then
  echo "production mode?"
  	export MIX_ENV=prod
	# echo "============ Precompiling Assets ============"
	# cd assets && webpack --mode production && cd ..
	# mix phx.digest
	echo "============ Migrating Database ============="
	MIX_ENV=prod mix ecto.migrate
	echo "============ woot ============="
	MIX_ENV=prod mix phx.server
	# echo "=============== Serer Stopped  ================"
else
	echo "================ Compiling =================="
	mix deps.get --only prod
	MIX_ENV=prod mix deps.compile
	echo "============ Migrating Database ============="
	MIX_ENV=prod mix ecto.migrate
	echo "============ Starting Passenger ============="
  MIX_ENV=prod mix phx.server
	echo "============= Server Stopped  ==============="
	sleep 99
fi;
