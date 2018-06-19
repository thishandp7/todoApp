#!/bin/bash
. /appenv/bin/activate

#install application requirments from file
pip3 install -r requirements_test.txt

#Run test args
exec $@
