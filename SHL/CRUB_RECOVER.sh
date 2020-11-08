#!/bin/bash

sudo apt-add-repository PPA:yannubuntu/boot-repair

sudo apt-get update

sudo apt-get install -y boot-repair

boot-repair 