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
image=""
dist_glance=""

help(){
	echo "Available arguments:"
	echo -e "- \"build\" starts a new build using packer-io${NC}"
	echo -e "- \"pack\" the output image gets packed using pigz${NC}"
	echo -e "- \"upload\" uploads the image${NC}"
	echo -e "- \"deploy\" deploys the image in the environment${NC}"
	echo -e "- \"complete\" builds, packs, uploads the image and deploys it${NC}"
	exit 1
}

nodist(){
	if [ -z $dist ]
		then
			echo -e "${yellow}Please pick a distribution!${NC}"
			exit 1
	fi
}

wrongdist(){
	echo -e "${yellow}I'm sorry, you seem to have forgotten to pick a distribution!${NC}"
	exit 1
}

noimage(){
	if [ -z $image ]
		then
			echo -e "${yellow}No image found!${NC}"
			echo -e "${yellow}Please build one first${NC}"
			exit 1
	fi
}

build(){
	echo -e "${green}Started building...${NC}"
	packer-io build -force template_$dist.json && \
	echo -e "${green}Building finished!${NC}"
}

pack(){
	image=`ls -Art output_$dist/ | tail -n1`
	if [[ $image =~ \.raw$ ]]
		then
			echo -e "${green}started packing...${NC}"
			pv -tpreb output_$dist/$image | pigz > output_$dist/$image.gz && \
			echo -e "${green}Image successfully compressed!${NC}" && \
			rm output_$dist/$image && \
			echo -e "${NC}Filesize: $(ls -lrth output_$dist | awk 'NR==1{print$2}')"
	elif [[ $image =~ \.gz$ ]]
		then
			echo -e "${yellow}Image is already packed!${NC}"
			echo -e "${NC}Filesize: $(ls -lrth output_$dist | awk 'NR==1{print$2}')"
	fi
}

upload(){
	image=`ls -Art output_$dist/ | tail -n1`
	if [[ $image =~ \.raw$ ]]
		then
			echo -e "${yellow}You happen to have forgotten to pack the image first!${NC}"
	elif [[ $image =~ \.gz$ ]]
		then
			echo -e "${green}uploading started...${NC}" && \
			lftp -c "open -u root,thisisnottheactualpassword sftp://localhost:2222; put -O /var/tmp/image output_$dist/$image" && \
			echo -e "${green}upload finished!${NC}"
	fi
}

deploy() {
	if [[ $dist == "centos" ]]
		then
			dist_glance="CentOS 7"
	elif [[ $dist == "ubuntu-14.04" ]]
		then
			dist_glance="Ubuntu 14.04"
	elif [[ $dist == "ubuntu-15.04" ]]
		then
			dist_glance="Ubuntu 15.04"
	fi
	image=`ls -Art output_$dist | grep packer | tail -n1`
	image2=$(echo "${image:0:${#image}-3}")
	date=`echo $image | grep -oP '\d{8}'`
	ssh root@os-control "cd /var/tmp/image
	echo -e \"${green}Deployment started!${NC}\"
	echo -e \"${green}Unpacking...${NC}\"
	gunzip $image && \
	echo -e \"${green}Unpacking finished!${NC}\"
	source ~/openrc
	glance image-create --name \"$dist_glance $date\" --container-format bare --disk-format raw --is-public true --file $image2 && \
	rm $image2"
}

complete() {
	build && \
	pack && \
	upload && \
	deploy
}

test(){
	echo "This is just a test for Travis CI."
	exit 0
}

if [[ $1 == "centos" ]]
	then
		dist="centos"
elif [[ $1 == "ubuntu-14.04" ]]
	then
		dist="ubuntu-14.04"
elif [[ $1 == "ubuntu-15.04" ]]
	then
		dist="ubuntu-15.04"
elif [[ $1 == "build" ]]
	then
		wrongdist
elif [[ $1 == "pack" ]]
	then
		wrongdist
elif [[ $1 == "upload" ]]
	then
		wrongdist
elif [[ $1 == "deploy" ]]
	then
		wrongdist
elif [[ $1 == "complete" ]]
	then
		wrongdist
elif [[ $1 == "test" ]]
	then
		test
elif [[ -n "$1" ]]
	then
		help
elif [[ -z "$1" ]]
	then
		help
fi

if [[ $2 == "build" ]]
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
		complete
elif [[ $2 == "deploy" ]]
	then
		deploy
elif [[ $2 == "test" ]]
	then
		test
elif [[ -n "$2" ]]
	then
		echo -e "${red}Invalid argument!${NC}"
		help
elif [[ -z "$2" ]]
	then
		help
fi
