#!/bin/bash

# colored echo
# Black        0;30     Dark Gray     1;30
# Blue         0;34     Light Blue    1;34
# Green        0;32     Light Green   1;32
# Cyan         0;36     Light Cyan    1;36
# Red          0;31     Light Red     1;31
# Purple       0;35     Light Purple  1;35
# Brown/Orange 0;33     Yellow        1;33
# Light Gray   0;37     White         1;37
green='\033[0;32m'
red='\033[0;31m'
yellow='\033[1;33m'
NC='\033[0m' # No Color

help () {
echo "Available arguments:"
echo -e "- \"build\" starts a new build using packer-io${NC}"
echo -e "- \"pack\" the output image gets packed using pigz${NC}"
echo -e "- \"upload\" uploads the image${NC}"
echo -e "- \"deploy\" deploys the image in the environment${NC}"
echo -e "- \"complete\" builds, packs, uploads the image and deploys it${NC}"
}

build() {
	if [ -f ./output/packer-CentOS_7.raw.gz ]
		then
			echo -e "${yellow}Image already exists!${NC}"
	elif
		then
			echo -e "${green}Started building...${NC}"
			packer-io build template.json > /dev/null 2>&1 && \
			echo -e "${green}Build successfully completed!${NC}"
	elif 
		then
		echo -e "${yellow}Ugh, wtf are you trying to pull here!?${NC}"
	fi
}

pack() {
	if [ -f ./output/packer-CentOS_7.raw ]
		then
			echo -e "${green}started packing...${NC}" && \
			pv -tpreb output/packer-CentOS_7.raw | pigz > output/packer-CentOS_7.raw.gz && \
			rm output/packer-CentOS_7.raw
			echo -e "${green}Image successfully compressed${NC}"
			echo -e "${NC}Filesize: $(ls -lrth output | awk 'NR==1{print$2}')"
	elif [ -f ./output/packer-CentOS_7.raw.gz ]
		then
			echo -e "${yellow}Image is already packed!${NC}"
			echo -e "${NC}Filesize: $(ls -lrth output | awk 'NR==1{print$2}')"
	fi
}

upload() {
	if [ -f ./output/packer-CentOS_7.raw.gz ]
		then
			echo -e "${green}uploading started...${NC}" && \
			lftp -c "open -u root sftp://localhost:2222; put -O /var/tmp/image output/packer-CentOS_7.raw.gz" && \
			echo -e "${green}upload finished!${NC}"
	fi
}

deploy() {
	ssh root@os-control 'cd /var/tmp/image && \
	gunzip -f packer-CentOS_7.raw.gz && \
	DATE=$(date +"%H%M_%d_%m_%Y") && \
	DATE1=$(echo $DATE) && \
	mv /var/tmp/image/packer-CentOS_7.raw "/var/tmp/image/packer-CentOS_7.raw_$DATE1.raw" && \
	source ~/openrc && \
	glance image-create --name "CentOS 7 $DATE1" --container-format bare --disk-format qcow2 --is-public true --file packer-CentOS_7.raw_$DATE1.raw'
}

complete() {
	build
	pack
	upload
	deploy
}

if [[ $1 = "help" ]]
	then
    	help
elif [[ $1 == "build" ]]
	then
    	build
elif [[ $1 == "upload" ]]
	then
		upload
elif [[ $1 == "pack" ]]
	then
		pack
elif [[ $1 == "complete" ]]
	then
		#echo -e "${red}Todo!${NC}"
		complete
elif [[ $1 == "deploy" ]]
	then
		deploy
		#echo -e "${red}Todo!${NC}"
elif [[ -n "$1" ]]
	then
		echo -e "${red}Invalid argument!${NC}"
		help
elif [[ -z "$1" ]]
	then
		help
fi
