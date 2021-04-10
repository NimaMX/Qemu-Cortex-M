#!/bin/sh

if [ $# -eq 0 ]
   then 
   echo "error: no input firmware found."
   exit 1
fi

echo "the firmware file is $1"
echo "starting QEMU ..."

qemu_system_arm -M versatilepb -m 128M -nographic -s -S -kernel $1 
