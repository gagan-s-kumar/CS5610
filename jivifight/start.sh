#!/bin/bash

export PORT=5100

cd ~/www/jivifight
./bin/jivifight stop || true
./bin/jivifight start

