#!/bin/bash
cd /Users/kfkaplan/Dropbox/battlekart64
#/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "MarioKart.c" -o "MarioKart.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Core/SharedFunctions.c" -o "Core/SharedFunctions.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Core/MarioKart3D.c" -o "Core/MarioKart3D.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Core/MarioKartObjects.c" -o "Core/MarioKartObjects.o"
~/Desktop/N64/armips/build/armips "BattleKart.asm"
~/Desktop/N64/n64crc "BattleKart.z64"
loader64 -vwf BattleKart.z64 
loader64 -p
