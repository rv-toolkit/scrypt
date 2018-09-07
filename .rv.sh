#!/bin/sh
set -x # Print debug info

json_out=`pwd`/errors.json
report_out=`pwd`/report

# This is running under Ubuntu 16.04
# Install necessary packages. 
apt install -y autoconf libssl-dev

autoreconf -i
./configure CC=kcc LD=kcc CFLAGS="-fissue-report=$json_out"
make -j`nproc`

rm $json_out # Remove compile-time errors.

make test # Run tests

# Generate a HTML report with `rv-html-report` command,
# and output the HTML report to `./report` directory. 
touch $json_out && rv-html-report $json_out -o $report_out

# Upload your HTML report to RV-Toolkit website with `rv-upload-report` command. 
rv-upload-report $report_out

# Done.