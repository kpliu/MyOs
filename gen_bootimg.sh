#!/usr/bin/bash
nasm boot.asm -o boot.bin
dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
sudo mount ./boot.img /media/ -t vfat -o loop
sudo cp loader.bin /media/
sudo sync
sudo umount /media
