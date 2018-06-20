#!/bin/bash
. /appenv/bin/activate

pip3 download -d /build -r requirements_test.txt --no-input

#install application requirments from file
pip3 install --no-input -f /build -r requirements_test.txt

#Run test args
exec $@
