#!/bin/sh
set -x # Print debug info

# This is running under Ubuntu 16.04
# Install necessary packages. 
sudo apt-get install -y autoconf libssl-dev

error_file=`pwd`/my_errors.json
autoreconf -i
./configure CC=kcc LD=kcc CFLAGS=-fissue-report=$error_file
make -j`nproc`

rm $error_file # Remove compile-time errors.

make test # Run tests

# Generate a HTML report with `rv-html-report` command,
# and output the HTML report to `./report` directory. 
rv-html-report $error_file -o report

# Upload your HTML report to RV-Toolkit website with `rv-upload-report` command. 
rv-upload-report `pwd`/report

# Done.