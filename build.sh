#!/bin/bash

mkdir -p ~/.local/docker
docker build . -t taskwarrior && docker save taskwarrior > ~/.local/docker/taskwarrior.tar
