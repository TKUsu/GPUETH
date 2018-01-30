# mine pool by linux
#linux&ubuntu
* install ufw 內建防火牆
`$ sudo apt-get install ufw`
`$ sudo ufw enable`
* 查詢狀態
`$ sudo ufw status verbose `
- - - -
## Nvidia
* `sudo apt-get install nvidia-'current/304'` 
> 最新版本 or 304版本  
* `sudo apt install nvidia-prime`
> Normally the package nvidia-prime should be installed alongside the NVIDIA drivers automatically - to do it manually,  
* `nvidia-xconfig` 
> Bulid org.conf file  
* 直接變更
`nvidia-xconfig --cool-bits='你要的數值'`
> `-a` all 顯示卡  
> cool bits - 12 --> 解開風扇、GPU及Memory Rate 限制  
> OR  
> `vim /etc/X11/xorg.conf`(Setting Location)  
> User Vim or gedit  
``` .conf
section "Screen"
	...
	Option "Coolbits" "12"
EndSection
```
* show status
`nvidia-smi`

## gpumine

* eth.sh
``` sh
#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

i=6
count=0

power=140
lv=3
clock=200
memory=1500
fanstatus=1
fan=100

while [ "${count}" != "${i}" ]
do
	echo "set GPU[$count]"
	sudo nvidia-smi -pl ${power}
	# GPU Level 
	sudo nvidia-settings -a "[gpu:${count}]/GPUPowerMizerMode=1"
	# GPU clock
	sudo nvidia-settings -a "[gpu:${count}]/GPUGraphicsClockOffset[${lv}]=${clock}"
	# GPU Memory
	sudo nvidia-settings -a "[gpu:${count}]/GPUMemoryTransferRateOffset[${lv}]=${memory}"
	# FPU Fan (0=auto, 1=custom)
	sudo nvidia-settings -a "[gpu:${count}]/GPUFanControlState=${fanstatus}" -a "[fan:${count}]/GPUTargetFanSpeed=${fan}"
   	count=$(($count+1))
done

./ethminer --farm-recheck 200 -U -S "eth.gpumine.org:3333" -FS "eth2.gpumine.org:4333" -O "0x8d97B68ef799229f72aB38Ce4386b163eEF66F73.ubuntu" -SP 1 
```

* `chmod a+x eth.sh; ./eth.sh`
> a -> all user  
> +x -> permission can running program  
- - - -
## Auto start

## problem
`apt-get install nvidia-settings nvidia-xconfig nvidia-driver`
> will This also build the kernel nvidia module  
`nvidia-xconfig` [ error messages can usually be ignored ]
> Create xorg server config file [ important to do this before restarting X!!]  
