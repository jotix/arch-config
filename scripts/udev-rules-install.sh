#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath -s $0))

sudo cp $SCRIPT_PATH/udev/* /etc/udev/rules.d/ -v

