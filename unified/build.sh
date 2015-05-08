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

dist=""

help () {
echo "Available arguments:"
echo -e "- \"build\" starts a new build using packer-io${NC}"
echo -e "- \"pack\" the output image gets packed using pigz${NC}"
echo -e "- \"upload\" uploads the image${NC}"
echo -e "- \"deploy\" deploys the image in the environment${NC}"
echo -e "- \"complete\" builds, packs, uploads the image and deploys it${NC}"
}

build() {
	if [ -f "./output/packer-$dist.raw.gz" ]
		then
			if [ -z "$dist" ]
				then
				exit
			fi
			echo -e "${yellow}Image already exists!${NC}"
	elif
		then
			if [ -z "$dist" ]
				then
				exit

			fi
			echo -e "${green}Started building...${NC}"
			packer-io build -force template_$dist.json && \
			echo -e "${green}Build successfully completed!${NC}"
	elif 
		then
		echo -e "${yellow}Ugh, wtf are you trying to pull here!?${NC}"
	fi
}

pack() {
	if [ -f ./output/packer-$dist.raw ]
		then
			if [ -z "$dist" ]
				then
				exit
			fi
			echo -e "${green}started packing...${NC}" && \
			pv -tpreb output/packer-$dist | pigz > output/packer-$dist.gz && \
			rm output/packer-$dist
			echo -e "${green}Image successfully compressed${NC}"
			echo -e "${NC}Filesize: $(ls -lrth output | awk 'NR==1{print$2}')"
	elif [ -f ./output/packer-$dist.gz ]
		then
			if [ -z "$dist" ]
				then
				exit
			fi
			echo -e "${yellow}Image is already packed!${NC}"
			echo -e "${NC}Filesize: $(ls -lrth output | awk 'NR==1{print$2}')"
	fi
}

upload() {
	if [ -f ./output/packer-$dist.gz ]
		then
			if [ -z "$dist" ]
				then
				exit
			fi
			echo -e "${green}uploading started...${NC}" && \
			lftp -c "open -u root sftp://localhost:2222; put -O /var/tmp/image output/packer-$dist.gz" && \
			echo -e "${green}upload finished!${NC}"
	fi
}

deploy() {
	if [ -z "$dist" ]
				then
				exit
			fi
	ssh root@os-control 'cd /var/tmp/image && \
	gunzip -f packer-CentOS_7.raw.gz && \
	DATE=$(date +"%H%M_%d_%m_%Y") && \
	DATE1=$(echo $DATE) && \
	mv /var/tmp/image/packer-CentOS_7.raw "/var/tmp/image/packer-CentOS_7.raw_$DATE1.raw" && \
	source ~/openrc && \
	glance image-create --name "CentOS 7 $DATE1" --container-format bare --disk-format raw --is-public true --file packer-CentOS_7_$DATE1.raw'
}

complete() {
	build && \
	pack && \
	upload && \
	deploy && \
}

if [[ $1 = "centos" ]]
	then
		dist=centos
elif [[ $1 = "ubuntu-14.04" ]]
	then
		dist=ubuntu-14.04
elif [[ $1 = "ubuntu-15.04" ]]
	then
		echo -e "${yellow}Work in progress!${NC}"
elif [[ -n "$1" ]]
	then
		echo -e "${yellow}At the moment, only \"centos\", \"ubuntu-14.04\" and \"ubuntu-15.04\" are available :(${NC}"
elif [[ -z "$1" ]]
	then
		echo -e "${yellow}I'm sorry, you seem to have forgotten to pick a distribution!${NC}"
fi

if [[ $2 = "help" ]]
	then
    	help
elif [[ $2 == "build" ]]
	then
    	build
elif [[ $2 == "upload" ]]
	then
		upload
elif [[ $2 == "pack" ]]
	then
		pack
elif [[ $2 == "complete" ]]
	then
		#echo -e "${red}Todo!${NC}"
		complete
elif [[ $2 == "deploy" ]]
	then
		deploy
		#echo -e "${red}Todo!${NC}"
elif [[ -n "$2" ]]
	then
		echo -e "${red}Invalid argument!${NC}"
		help
elif [[ -z "$2" ]]
	then
		help
fi
