#!/bin/sh
set -x

# This is running under Ubuntu 16.04
# Install necessary packages. 
sudo apt-get install -y autoconf libssl-dev

error_file=`pwd`/my_errors.json
compiler=kcc
autoreconf -i
./configure CC=$compiler LD=$compiler CFLAGS=-fissue-report=$error_file
make -j`nproc`

rm $error_file # remove compile-time errors.

make test

# Generate a HTML report with `rv-html-report` command,
# and output the HTML report to `./report` directory. 
rv-html-report $error_file -o report

# Upload your HTML report to RV-Toolkit website with `rv-upload-report` command. 
rv-upload-report `pwd`/report

# Done.