#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

i=6
count=0

power=120
lv=3
clock=10
memory=10
fanstatus=1
fan=35

sudo nvidia-smi -pl ${power}
while [ "${count}" != "${i}" ]
do
	# GPU Level 
	sudo nvidia-settings -a "[gpu:${count}]/GPUPowerMizerMode=2"
	# GPU clock
	sudo nvidia-settings -a "[gpu:${count}]/GPUGraphicsClockOffset[${lv}]=${clock}"
	# GPU Memory
	sudo nvidia-settings -a "[gpu:${count}]/GPUMemoryTransferRateOffset[${lv}]=${memory}"
	# FPU Fan (0=auto, 1=custom)
	sudo nvidia-settings -a "[gpu:${count}]/GPUFanControlState=${fanstatus}" -a "[fan:${count}]/GPUTargetFanSpeed=${fan}"
   	count=$(($count+1))
	echo "set GPU[$count]"
done
