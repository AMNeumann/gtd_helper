#!/bin/bash

docker image ls | grep -q taskwarrior
if [[ $? -ne 0 ]]
then
   echo "Need to load taskwarrior image from file"
   docker load < ~/.local/docker/taskwarrior.tar
fi

docker run -it --rm \
   --volume=/home/neumanna/.task:/home/neumanna/.task \
   --volume=/home/neumanna/.timewarrior/:/home/neumanna/.timewarrior \
   --volume=/home/neumanna/journal/:/home/neumanna/journal \
   --volume=/home/neumanna/.config/jrnl/:/home/neumanna/.config/jrnl \
   taskwarrior:latest $@
#  --user "`id -u`:`id -g`" \
