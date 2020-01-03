#!/bin/bash

cd /vmdata


virsh destroy $1
virsh undefine $1

rm -rf vm_$1
