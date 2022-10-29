#!/bin/bash

#
# ____          __  __  _____ 
# |  _ \   /\   |  \/  |/ ____|     bams: https://github.com/opeoniye
# | |_) | /  \  | \  / | (___       portfolio: https://opeoniye.vercel.app/
# |  _ < / /\ \ | |\/| |\___ \      credit: http://patorjk.com/software/taag/
# | |_) / ____ \| |  | |____) |     source: https://gist.github.com/2206527
# |____/_/    \_\_|  |_|_____/ 
#

#set -e
set -uo pipefail
# set -o errtrace
# set -o nounset
# set -o errexit

###################################################
# config
###################################################
ver="2.4.9"   # https://github.com/illuspas/Node-Media-Server/tags
server_dir="./server"
relay_dir="./relay"
server_tag="opeoniye/dclm-nodems-server"
relay_tag="opeoniye/dclm-nodems-relay"
server="$server_tag:$ver"
relay="$relay_tag:$ver"
image_server=`docker image ls | grep $server_tag | cut -b -27`
image_relay=`docker image ls | grep $relay_tag | cut -b -26`

##################################################
# code
##################################################

# Output colours
COL='\033[1;34m'
NOC='\033[0m'


# build & tag image
echo -e  "$COL> Building $server docker image...$NOC"
# https://docs.docker.com/engine/reference/commandline/build/
docker build $server_dir -t $server --build-arg NODEMS_VERSION=$ver

echo -e  "\n$COL> Building $relay image...$NOC"
docker build $relay_dir -t $relay --build-arg NODEMS_VERSION=$ver

# deploy image
# https://docs.docker.com/engine/reference/commandline/login/
cat ./access.txt | docker login --username opeoniye --password-stdin

echo -e  "\n$COL> Pushing $server image into docker hub...$NOC"
if [ "$server_tag" = "$image_server" ]; then
  docker push $server
else
  echo -e "\nDocker image $server_tag not found"
  exit 1
fi

echo -e  "\n$COL> Pushing $relay image into docker hub...$NOC"
if [ "$relay_tag" = "$image_relay" ]; then
  docker push $relay
else
  echo -e "\nDocker image $relay_tag not found"
  exit 1
fi