#!/bin/bash
cd /Users/kfkaplan/Dropbox/battlekart64
#Markers on courses for Bot AI
#/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "BattleKartFlag/BattleKartPathData.c" -o "BattleKartFlag/BattleKartPathData.o" 
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "BattleKartPaths/BlockFortPaths.c" -o "BattleKartPaths/BlockFortPaths.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "BattleKartPaths/DoubleDeckerPaths.c" -o "BattleKartPaths/DoubleDeckerPaths.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "BattleKartPaths/SkyscraperPaths.c" -o "BattleKartPaths/SkyscraperPaths.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "BattleKartPaths/BigDonutPaths.c" -o "BattleKartPaths/BigDonutPaths.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Library/Player/Pathfinding.c" -S -o "Library/Player/Pathfinding.s"  -fverbose-asm #output assembly
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Library/Player/Pathfinding.c" -o "Library/Player/Pathfinding.o"
#Files from Library
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/LibraryVariables.c" -o "library/LibraryVariables.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/CustomParticles/CustomParticles.c" -o "library/CustomParticles/CustomParticles.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/MarioKart3D.c" -o "library/MarioKart3D.o"
#/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/MarioKartMemory.c" -o "library/MarioKartMemory.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/MarioKartObjects.c" -o "library/MarioKartObjects.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/Player/MarioKartStats.c" -o "library/Player/MarioKartStats.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/Player/PlayerEffects.c" -o "library/Player/PlayerEffects.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/SharedFunctions.c" -o "library/SharedFunctions.o" 
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/CustomCourses/CustomLevels.c" -o "library/CustomCourses/CustomLevels.o" 
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/CustomCourses/CustomSurfaces.c" -o "library/CustomCourses/CustomSurfaces.o" 
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/CustomObjects/OKBehaviors.c" -o "library/CustomObjects/OKBehaviors.o" 
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/Player/PlayerChecks.c" -o "library/Player/PlayerChecks.o" 
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/CustomObjects/OKCustomObjects.c" -o "library/CustomObjects/OKCustomObjects.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/MarioKartMenu.c" -o "library/MarioKartMenu.o" 
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/MusicSound/CustomSounds.c" -o "library/MusicSound/CustomSounds.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/MusicSound/MusicControl.c" -o "library/MusicSound/MusicControl.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/CustomObjects/ObjectHandler.c" -o "library/CustomObjects/ObjectHandler.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/PreCode.c" -o "library/PreCode.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/PreSwitch.c" -o "library/PreSwitch.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/Gametypes/CTF.c" -o "library/Gametypes/CTF.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/Gametypes/Soccer.c" -o "library/Gametypes/Soccer.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/Gametypes/GameTypesGeneric.c" -o "library/Gametypes/GameTypesGeneric.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "library/Gametypes/GBI/SNet.c" -o "library/Gametypes/GBI/SNet.o"


#Battlekart related c files
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "BattleKartFlag/BattleKartFlag.c" -S -o "BattleKartFlag/BattleKartFlag.s"  -fverbose-asm #output assembly 
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -lm -c "BattleKartFlag/BattleKartFlag.c" -o "BattleKartFlag/BattleKartFlag.o" 
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0  -c "BattleBots/BattleBotAI.c" -S -o "BattleBots/BattleBotAI.s"  -fverbose-asm #output assembly
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "BattleBots/BattleBotAI.c"  -o "BattleBots/BattleBotAI.o"
/Users/kfkaplan/Desktop/N64/n64chain/tools/bin/mips64-elf-gcc  -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "BattleKartVariables.c" -o "BattleKartVariables.o" 


~/Desktop/N64/armips/build/armips "BattleKart.asm"
~/Desktop/N64/n64crc "BattleKart64.z64"
#loader64 -vwf BattleKart64.z64 
#loader64 -p
#UNFLoader -r BattleKart64.z64
