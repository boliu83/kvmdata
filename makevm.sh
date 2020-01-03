#!/bin/bash

name=$1
cpu=$2
ram=$((1024*$3))
bridge=$4

if [[ -z $bridge ]]; then
    bridge='virbr0'
fi

cd /vmdata

if [[ ! -d vm_${name} ]]; then
     mkdir vm_${name}
fi

#IMAGE=/vmdata/templates/CentOS-7-x86_64-GenericCloud.qcow2
IMAGE=/vmdata/templates/CentOS-7-cloud_init.qcow2

if [[ ! -f vm_${name}/${name}.qcow2 ]]; then
    qemu-img create -f qcow2 -b ${IMAGE} vm_${name}/${name}.qcow2 50G
fi

virt-install --name ${name}\
 --cpu host-passthrough --vcpus ${cpu}\
 --ram ${ram}\
 --disk path=/vmdata/vm_${name}/${name}.qcow2,format=qcow2\
 --network network=default\
 --os-type linux --os-variant centos7.0\
 --graphics vnc,listen=192.168.0.250\
 --noautoconsole\
 --boot hd\
 --noreboot\
 --transient
