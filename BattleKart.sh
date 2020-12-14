#!/bin/bash
#cd /Users/kfkaplan/Desktop/BattleKart64
#/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "MarioKart.c" -o "MarioKart.o"
~/Desktop/N64/armips/build/armips "BattleKart.asm"
~/Desktop/N64/n64crc "BattleKart.z64"
loader64 -vwf BattleKart.z64 
loader64 -p
