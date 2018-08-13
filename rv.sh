#!/bin/sh
set -x
set -e

# This is running under Ubuntu 16.04
# Install necessary packages. 
# sudo apt-get install -y libssl-dev
sudo apt-get install -y autoconf libssl-dev

# autoscan
# aclocal ; autoheader ; autoreconf
# automake --add-missing
compiler=kcc
autoreconf -i
./configure CC=$compiler LD=$compiler CFLAGS=-fissue-report=`pwd`/my_errors.json
make -j`nproc`
make test

# Generate a HTML report with `rv-html-report` command,
# and output the HTML report to `./report` directory. 
rv-html-report my_errors.json -o report

# Upload your HTML report to RV-Toolkit website with `rv-upload-report` command. 
rv-upload-report `pwd`/report

# Done.