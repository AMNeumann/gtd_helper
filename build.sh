#!/bin/bash

mkdir -p ~/.local/docker
./render.py Dockerfile.jinja2 > Dockerfile
docker build . -t gtd_helper && docker save gtd_helper > ~/.local/docker/gtd_helper.tar

mkdir -p ~/.local/bin
install bin/* ~/.local/bin
