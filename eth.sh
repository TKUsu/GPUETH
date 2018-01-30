#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

chmod a+x config.sh
./config.sh

./ethminer --farm-recheck 200 -U -S "eth.gpumine.org:3333" -FS "eth2.gpumine.org:4333" -O "0x8d97B68ef799229f72aB38Ce4386b163eEF66F73.ubuntu" -SP 1 
