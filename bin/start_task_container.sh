#!/bin/bash

docker image ls | grep -q gtd_helper
if [[ $? -ne 0 ]]
then
   echo "Need to load gtd_helper image from file"
   docker load < ~/.local/docker/gtd_helper.tar
fi

docker run -it --rm \
   --volume=$HOME/.task:/home/theuser/.task \
   --volume=$HOME/.timewarrior/:/home/theuser/.timewarrior \
   --volume=$HOME/journal/:/home/theuser/journal \
   --volume=$HOME/.config/jrnl/:/home/theuser/.config/jrnl \
   gtd_helper:latest $@
#  --user "`id -u`:`id -g`" \
