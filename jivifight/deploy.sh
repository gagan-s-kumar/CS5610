#!/bin/bash

export PORT=5100
export MIX_ENV=prod
export GIT_PATH=/home/jivifight/src/jivifight 

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "jivifight" ]; then
	echo "Error: must run as user 'jivifight'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/jivifight ]; then
	echo mv ~/www/jivifight ~/old/$NOW
	mv ~/www/jivifight ~/old/$NOW
fi

mkdir -p ~/www/jivifight
REL_TAR=~/src/jivifight/_build/prod/rel/jivifight/releases/0.0.1/jivifight.tar.gz
(cd ~/www/jivifight && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/jivifight/src/jivifight/start.sh
CRONTAB

#. start.sh
