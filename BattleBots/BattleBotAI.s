	.file	1 "BattleBotAI.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg

 # -G value = 0, Arch = vr4300, ISA = 3
 # GNU C17 (GCC) version 10.1.0 (mips64-elf)
 #	compiled by GNU C version 4.2.1 Compatible Apple LLVM 10.0.1 (clang-1001.0.46.4), GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.22.1-GMP

 # warning: MPFR header version 4.0.2 differs from library version 4.1.0.
 # warning: MPC header version 1.1.0 differs from library version 1.2.0.
 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed:  BattleBots/BattleBotAI.c -G 0 -mtune=vr4300
 # -march=vr4300 -mabi=32 -mips3 -auxbase-strip BattleBots/BattleBotAI.s
 # -O1 -Wall -fomit-frame-pointer -fverbose-asm
 # options enabled:  -faggressive-loop-optimizations -fallocation-dce
 # -fauto-inc-dec -fbranch-count-reg -fcombine-stack-adjustments
 # -fcompare-elim -fcprop-registers -fdefer-pop -fdelayed-branch
 # -fdelete-null-pointer-checks -fdwarf2-cfi-asm -fearly-inlining
 # -feliminate-unused-debug-symbols -feliminate-unused-debug-types
 # -fforward-propagate -ffp-int-builtin-inexact -ffunction-cse -fgcse-lm
 # -fgnu-unique -fguess-branch-probability -fident -fif-conversion
 # -fif-conversion2 -finline -finline-atomics
 # -finline-functions-called-once -fipa-profile -fipa-pure-const
 # -fipa-reference -fipa-reference-addressable -fipa-stack-alignment
 # -fira-hoist-pressure -fira-share-save-slots -fira-share-spill-slots
 # -fivopts -fkeep-static-consts -fleading-underscore -flifetime-dse
 # -fmath-errno -fmerge-constants -fmerge-debug-strings
 # -fmove-loop-invariants -fomit-frame-pointer -fpcc-struct-return
 # -fpeephole -fplt -fprefetch-loop-arrays -freorder-blocks
 # -fsched-critical-path-heuristic -fsched-dep-count-heuristic
 # -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
 # -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
 # -fsched-stalled-insns-dep -fschedule-fusion -fsemantic-interposition
 # -fshow-column -fshrink-wrap -fshrink-wrap-separate -fsigned-zeros
 # -fsplit-ivs-in-unroller -fsplit-wide-types -fssa-backprop -fssa-phiopt
 # -fstdarg-opt -fstrict-volatile-bitfields -fsync-libcalls
 # -ftoplevel-reorder -ftrapping-math -ftree-bit-ccp
 # -ftree-builtin-call-dce -ftree-ccp -ftree-ch -ftree-coalesce-vars
 # -ftree-copy-prop -ftree-cselim -ftree-dce -ftree-dominator-opts
 # -ftree-dse -ftree-forwprop -ftree-fre -ftree-loop-if-convert
 # -ftree-loop-im -ftree-loop-ivcanon -ftree-loop-optimize
 # -ftree-parallelize-loops= -ftree-phiprop -ftree-pta -ftree-reassoc
 # -ftree-scev-cprop -ftree-sink -ftree-slsr -ftree-sra -ftree-ter
 # -funit-at-a-time -fverbose-asm -fzero-initialized-in-bss -mbranch-likely
 # -mcheck-zero-division -mdivide-traps -mdouble-float -meb
 # -mexplicit-relocs -mextern-sdata -mfp-exceptions -mfp32 -mgp32 -mgpopt
 # -mhard-float -mload-store-pairs -mlocal-sdata -mlong32 -mlra -mlxc1-sxc1
 # -mmadd4 -mno-mdmx -mno-mips16 -mno-mips3d -mshared

	.text
	.align	2
	.globl	botControl
	.set	nomips16
	.set	nomicromips
	.ent	botControl
	.type	botControl, @function
botControl:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
 # BattleBots/BattleBotAI.c:65:     if(GlobalController[0]->ButtonPressed & BTN_DLEFT)
	lui	$2,%hi(GlobalController)	 # tmp216,
 # BattleBots/BattleBotAI.c:65:     if(GlobalController[0]->ButtonPressed & BTN_DLEFT)
	lw	$2,%lo(GlobalController)($2)		 # GlobalController, GlobalController
 # BattleBots/BattleBotAI.c:65:     if(GlobalController[0]->ButtonPressed & BTN_DLEFT)
	lhu	$2,6($2)	 #, _1->ButtonPressed
	andi	$2,$2,0x200	 # tmp221, _1->ButtonPressed,
	beq	$2,$0,$L6	 #, tmp221,,
	lui	$2,%hi(g_PlayerStructTable)	 # tmp235,

 # BattleBots/BattleBotAI.c:67:         GlobalPlayer[0].position[0] = 450;
	lui	$2,%hi(GlobalPlayer)	 # tmp222,
	addiu	$2,$2,%lo(GlobalPlayer)	 # tmp223, tmp222,
	lui	$3,%hi($LC0)	 # tmp224,
	lwc1	$f0,%lo($LC0)($3)	 # tmp225,
	swc1	$f0,20($2)	 # tmp225, GlobalPlayer[0].position
 # BattleBots/BattleBotAI.c:68:         GlobalPlayer[0].position[1] = 98;
	lui	$3,%hi($LC1)	 # tmp228,
	lwc1	$f2,%lo($LC1)($3)	 # tmp229,
	swc1	$f2,24($2)	 # tmp229, GlobalPlayer[0].position
 # BattleBots/BattleBotAI.c:69:         GlobalPlayer[0].position[2] = 450;
	swc1	$f0,28($2)	 # tmp225, GlobalPlayer[0].position
 # BattleBots/BattleBotAI.c:71:     int carID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
	lui	$2,%hi(g_PlayerStructTable)	 # tmp235,
$L6:
	addiu	$2,$2,%lo(g_PlayerStructTable)	 # tmp234, tmp235,
	subu	$4,$4,$2	 # tmp236, Car, tmp234
 # BattleBots/BattleBotAI.c:71:     int carID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
	li	$2,1240924160			# 0x49f70000	 # tmp239,
	ori	$2,$2,0xe8e3	 # tmp238, tmp239,
	mult	$4,$2	 # tmp236, tmp238
	mfhi	$2		 # tmp237
	sra	$2,$2,10	 # tmp240, tmp237,
	sra	$4,$4,31	 # tmp241, tmp236,
	subu	$2,$2,$4	 # carID, tmp240, tmp241
 # BattleBots/BattleBotAI.c:73:     if (bot_status_p1[carID] > 0)
	lui	$3,%hi(bot_status_p1)	 # tmp242,
	addiu	$3,$3,%lo(bot_status_p1)	 # tmp244, tmp242,
	addu	$3,$2,$3	 # tmp243, carID, tmp244
 # BattleBots/BattleBotAI.c:73:     if (bot_status_p1[carID] > 0)
	lbu	$3,0($3)	 # tmp245, bot_status_p1
	beq	$3,$0,$L7	 #, tmp245,,
	lui	$4,%hi(TripleTap)	 # tmp246,

 # BattleBots/BattleBotAI.c:75:         TripleTap++;
	lbu	$3,%lo(TripleTap)($4)	 #, TripleTap
	addiu	$3,$3,1	 # tmp248, TripleTap,
	sll	$3,$3,24	 # _11, tmp248,
	sra	$3,$3,24	 # _11, _11,
	sb	$3,%lo(TripleTap)($4)	 # _11, TripleTap
 # BattleBots/BattleBotAI.c:76:         if ((TripleTap % 3) == 1)
	li	$4,1431633920			# 0x55550000	 # tmp253,
	addiu	$4,$4,21846	 # tmp252, tmp253,
	mult	$3,$4	 # _11, tmp252
	mfhi	$4		 # tmp251
	sra	$6,$3,31	 # tmp254, _11,
	subu	$4,$4,$6	 # tmp250, tmp251, tmp254
	sll	$6,$4,1	 # tmp256, tmp250,
	addu	$4,$6,$4	 # tmp257, tmp256, tmp250
	subu	$3,$3,$4	 # tmp258, _11, tmp257
 # BattleBots/BattleBotAI.c:76:         if ((TripleTap % 3) == 1)
	sll	$3,$3,24	 # tmp259, tmp258,
	sra	$3,$3,24	 # tmp259, tmp259,
	li	$4,1			# 0x1	 # tmp260,
	beq	$3,$4,$L5	 #, tmp259, tmp260,
	sll	$3,$2,1	 # tmp262, carID,

$L4:
 # BattleBots/BattleBotAI.c:80:         cont->ButtonPressed = bot_pressed[carID];
	sll	$4,$2,1	 # tmp273, carID,
	lui	$3,%hi(bot_pressed)	 # tmp272,
	addiu	$3,$3,%lo(bot_pressed)	 # tmp275, tmp272,
	addu	$3,$4,$3	 # tmp274, tmp273, tmp275
	lhu	$3,0($3)	 # _15, bot_pressed
 # BattleBots/BattleBotAI.c:80:         cont->ButtonPressed = bot_pressed[carID];
	sh	$3,6($5)	 # _15, cont_29(D)->ButtonPressed
 # BattleBots/BattleBotAI.c:81:         cont->ButtonHeld = bot_buttons[carID]; //bot_controller_input_p1[carID]; //Test moving player 2 foward
	lui	$3,%hi(bot_buttons)	 # tmp276,
	addiu	$3,$3,%lo(bot_buttons)	 # tmp279, tmp276,
	addu	$4,$4,$3	 # tmp278, tmp273, tmp279
	lhu	$3,0($4)	 # _16, bot_buttons
 # BattleBots/BattleBotAI.c:81:         cont->ButtonHeld = bot_buttons[carID]; //bot_controller_input_p1[carID]; //Test moving player 2 foward
	sh	$3,4($5)	 # _16, cont_29(D)->ButtonHeld
 # BattleBots/BattleBotAI.c:82:         cont->AnalogX = bot_x_stick[carID]; //Turn some direction
	lui	$3,%hi(bot_x_stick)	 # tmp280,
	addiu	$3,$3,%lo(bot_x_stick)	 # tmp282, tmp280,
	addu	$2,$2,$3	 # tmp281, carID, tmp282
	lb	$2,0($2)		 # tmp283, bot_x_stick
	sh	$2,0($5)	 # tmp283, cont_29(D)->AnalogX
$L7:
 # BattleBots/BattleBotAI.c:85: }
	jr	$31
	nop
	 #
$L5:
 # BattleBots/BattleBotAI.c:78:             bot_pressed[carID] |= BTN_A;
	lui	$4,%hi(bot_pressed)	 # tmp261,
	addiu	$4,$4,%lo(bot_pressed)	 # tmp264, tmp261,
	addu	$3,$3,$4	 # tmp263, tmp262, tmp264
	lhu	$4,0($3)	 #, bot_pressed
	li	$6,-32768			# 0xffffffffffff8000	 # tmp271,
	or	$4,$4,$6	 # tmp270, tmp269, tmp271
	b	$L4	 #
	sh	$4,0($3)	 # tmp270, bot_pressed

	.set	macro
	.set	reorder
	.end	botControl
	.size	botControl, .-botControl
	.align	2
	.globl	ProSteeringPlus
	.set	nomips16
	.set	nomicromips
	.ent	ProSteeringPlus
	.type	ProSteeringPlus, @function
ProSteeringPlus:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32	 #,,
	sw	$31,28($sp)	 #,
	sw	$17,24($sp)	 #,
	sw	$16,20($sp)	 #,
	move	$16,$4	 # i, tmp496
 # BattleBots/BattleBotAI.c:92:     short TargetPath = AIPathfinder[i].TargetPath;
	sll	$2,$4,5	 # tmp267, i,
	lui	$3,%hi(AIPathfinder)	 # tmp266,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp269, tmp266,
	addu	$2,$2,$3	 # tmp268, tmp267, tmp269
	lh	$4,0($2)		 # TargetPath, AIPathfinder[i_70(D)].TargetPath
 # BattleBots/BattleBotAI.c:93:     short Progression = AIPathfinder[i].Progression; //(int)AIPathfinder[i].Progression;
	lh	$3,20($2)		 # Progression, AIPathfinder[i_70(D)].Progression
 # BattleBots/BattleBotAI.c:94:     switch (AIPathfinder[i].PathType) //Get position of current marker to drive towards
	lb	$2,31($2)		 # _1, AIPathfinder[i_70(D)].PathType
 # BattleBots/BattleBotAI.c:94:     switch (AIPathfinder[i].PathType) //Get position of current marker to drive towards
	li	$8,1			# 0x1	 # tmp278,
	beq	$2,$8,$L9	 #, _1, tmp278,
	sll	$4,$4,2	 # tmp298, TargetPath,

	li	$6,2			# 0x2	 # tmp279,
	beq	$2,$6,$L10
	nop
	 #, _1, tmp279,
	beq	$2,$0,$L38	 #, _1,,
	addu	$5,$5,$4	 # _4, PathArray, tmp280

$L11:
 # BattleBots/BattleBotAI.c:113:     GlobalShortA = (short)(MakeDirection(GlobalPlayer[i].position[0],GlobalPlayer[i].position[2], objectPosition[0], objectPosition[2]) * -1);
	lui	$3,%hi(objectPosition)	 # tmp334,
	addiu	$4,$3,%lo(objectPosition)	 # tmp335, tmp334,
	lui	$17,%hi(GlobalPlayer)	 # tmp339,
	sll	$2,$16,3	 # tmp343, i,
	subu	$2,$2,$16	 # tmp344, tmp343, i
	sll	$2,$2,4	 # tmp345, tmp344,
	subu	$2,$2,$16	 # tmp346, tmp345, i
	sll	$2,$2,2	 # tmp347, tmp346,
	subu	$2,$2,$16	 # tmp348, tmp347, i
	sll	$2,$2,3	 # tmp349, tmp348,
	addiu	$17,$17,%lo(GlobalPlayer)	 # tmp340, tmp339,
	addu	$17,$17,$2	 # tmp341, tmp340, tmp349
	lw	$7,8($4)		 #, objectPosition
	lw	$6,%lo(objectPosition)($3)		 #, objectPosition
	lwc1	$f14,28($17)	 #, GlobalPlayer[i_70(D)].position
	jal	MakeDirection	 #
	lwc1	$f12,20($17)	 #, GlobalPlayer[i_70(D)].position

 # BattleBots/BattleBotAI.c:114:     GlobalShortA -= GlobalPlayer[i].direction[1];
	lhu	$3,46($17)	 #, GlobalPlayer[i_70(D)].direction
	addu	$2,$2,$3	 # tmp377, tmp500, GlobalPlayer[i_70(D)].direction
	subu	$2,$0,$2	 # tmp379, tmp377
	sll	$2,$2,16	 # _63, tmp379,
	sra	$2,$2,16	 # _63, _63,
	lui	$3,%hi(GlobalShortA)	 # tmp380,
	sh	$2,%lo(GlobalShortA)($3)	 # _63, GlobalShortA
 # BattleBots/BattleBotAI.c:115:     GlobalUInt64 = GlobalShortA * GlobalShortA;
	mult	$2,$2	 # _63, _63
	mflo	$6		 # _66
	sra	$5,$6,31	 # _66, _66,
 # BattleBots/BattleBotAI.c:115:     GlobalUInt64 = GlobalShortA * GlobalShortA;
	lui	$3,%hi(GlobalUInt64)	 # tmp383,
	sw	$5,%lo(GlobalUInt64)($3)	 # _66, GlobalUInt64
	sw	$6,%lo(GlobalUInt64+4)($3)	 # _66, GlobalUInt64
 # BattleBots/BattleBotAI.c:118:     bot_buttons[i] = BTN_A;
	sll	$3,$16,1	 # tmp385, i,
	lui	$4,%hi(bot_buttons)	 # tmp384,
	addiu	$4,$4,%lo(bot_buttons)	 # tmp387, tmp384,
	addu	$4,$3,$4	 # tmp386, tmp385, tmp387
	li	$7,-32768			# 0xffffffffffff8000	 # tmp388,
	sh	$7,0($4)	 # tmp388, bot_buttons
 # BattleBots/BattleBotAI.c:119:     bot_pressed[i] = 0;
	lui	$4,%hi(bot_pressed)	 # tmp389,
	addiu	$4,$4,%lo(bot_pressed)	 # tmp392, tmp389,
	addu	$3,$3,$4	 # tmp391, tmp385, tmp392
 # BattleBots/BattleBotAI.c:121:     if (GlobalUInt64 > STOPTURN)
	bne	$5,$0,$L31	 #, _66,,
	sh	$0,0($3)	 #, bot_pressed

	bne	$5,$0,$L12	 #, _66,,
	li	$3,119209984			# 0x71b0000	 # tmp397,

	ori	$3,$3,0x8e41	 # tmp396, tmp397,
	sltu	$3,$6,$3	 # tmp395, _66, tmp396
	bne	$3,$0,$L12
	nop
	 #, tmp395,,
$L31:
 # BattleBots/BattleBotAI.c:124:         bot_buttons[i] |= BTN_B;  //continue braking
	sll	$3,$16,1	 # tmp399, i,
	lui	$4,%hi(bot_buttons)	 # tmp398,
	addiu	$4,$4,%lo(bot_buttons)	 # tmp401, tmp398,
	addu	$3,$3,$4	 # tmp400, tmp399, tmp401
	li	$4,-16384			# 0xffffffffffffc000	 # tmp402,
 # BattleBots/BattleBotAI.c:125:         if (GlobalShortA > 0)
	blez	$2,$L14	 #, _63,
	sh	$4,0($3)	 # tmp402, bot_buttons

 # BattleBots/BattleBotAI.c:129:                 bot_buttons[i] |= BTN_R;  //continue drifting, otherwise stop.    
	sll	$2,$16,1	 # tmp404, i,
	lui	$3,%hi(bot_buttons)	 # tmp403,
	addiu	$3,$3,%lo(bot_buttons)	 # tmp406, tmp403,
	addu	$2,$2,$3	 # tmp405, tmp404, tmp406
	li	$3,-16368			# 0xffffffffffffc010	 # tmp407,
	sh	$3,0($2)	 # tmp407, bot_buttons
 # BattleBots/BattleBotAI.c:132:             bot_x_stick[i] = 127;  
	lui	$4,%hi(bot_x_stick)	 # tmp408,
	addiu	$4,$4,%lo(bot_x_stick)	 # tmp410, tmp408,
	addu	$16,$16,$4	 # tmp409, i, tmp410
	li	$2,127			# 0x7f	 # tmp411,
	sb	$2,0($16)	 # tmp411, bot_x_stick
$L8:
 # BattleBots/BattleBotAI.c:212: }
	lw	$31,28($sp)		 #,
	lw	$17,24($sp)		 #,
	lw	$16,20($sp)		 #,
	jr	$31	 #
	addiu	$sp,$sp,32	 #,,

$L38:
 # BattleBots/BattleBotAI.c:97:             objectPosition[0] = (float)PathArray[TargetPath][Progression].Position[0];
	sll	$3,$3,3	 # _7, Progression,
 # BattleBots/BattleBotAI.c:97:             objectPosition[0] = (float)PathArray[TargetPath][Progression].Position[0];
	lui	$2,%hi(objectPosition)	 # tmp281,
 # BattleBots/BattleBotAI.c:97:             objectPosition[0] = (float)PathArray[TargetPath][Progression].Position[0];
	lw	$4,0($5)		 # *_4, *_4
	addu	$4,$4,$3	 # tmp283, *_4, _7
 # BattleBots/BattleBotAI.c:97:             objectPosition[0] = (float)PathArray[TargetPath][Progression].Position[0];
	lh	$4,0($4)		 # _8->Position, _8->Position
	mtc1	$4,$f0	 # _8->Position, _8->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp285, _8->Position
	swc1	$f0,%lo(objectPosition)($2)	 # tmp285, objectPosition
 # BattleBots/BattleBotAI.c:98:             objectPosition[1] = (float)PathArray[TargetPath][Progression].Position[1];
	addiu	$2,$2,%lo(objectPosition)	 # tmp287, tmp281,
 # BattleBots/BattleBotAI.c:98:             objectPosition[1] = (float)PathArray[TargetPath][Progression].Position[1];
	lw	$4,0($5)		 # *_4, *_4
	addu	$4,$4,$3	 # tmp289, *_4, _7
 # BattleBots/BattleBotAI.c:98:             objectPosition[1] = (float)PathArray[TargetPath][Progression].Position[1];
	lh	$4,2($4)		 # _12->Position, _12->Position
	mtc1	$4,$f0	 # _12->Position, _12->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp291, _12->Position
	swc1	$f0,4($2)	 # tmp291, objectPosition
 # BattleBots/BattleBotAI.c:99:             objectPosition[2] = (float)PathArray[TargetPath][Progression].Position[2]; 
	lw	$4,0($5)		 # *_4, *_4
	addu	$3,$4,$3	 # tmp295, *_4, _7
 # BattleBots/BattleBotAI.c:99:             objectPosition[2] = (float)PathArray[TargetPath][Progression].Position[2]; 
	lh	$3,4($3)		 # _16->Position, _16->Position
	mtc1	$3,$f0	 # _16->Position, _16->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp297, _16->Position
 # BattleBots/BattleBotAI.c:100:             break;
	b	$L11	 #
	swc1	$f0,8($2)	 # tmp297, objectPosition

$L9:
 # BattleBots/BattleBotAI.c:102:             objectPosition[0] = (float)RampArray[TargetPath][Progression].Position[0];
	addu	$6,$6,$4	 # _21, RampArray, tmp298
 # BattleBots/BattleBotAI.c:102:             objectPosition[0] = (float)RampArray[TargetPath][Progression].Position[0];
	sll	$3,$3,3	 # _24, Progression,
 # BattleBots/BattleBotAI.c:102:             objectPosition[0] = (float)RampArray[TargetPath][Progression].Position[0];
	lui	$2,%hi(objectPosition)	 # tmp299,
 # BattleBots/BattleBotAI.c:102:             objectPosition[0] = (float)RampArray[TargetPath][Progression].Position[0];
	lw	$4,0($6)		 # *_21, *_21
	addu	$4,$4,$3	 # tmp301, *_21, _24
 # BattleBots/BattleBotAI.c:102:             objectPosition[0] = (float)RampArray[TargetPath][Progression].Position[0];
	lh	$4,0($4)		 # _25->Position, _25->Position
	mtc1	$4,$f0	 # _25->Position, _25->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp303, _25->Position
	swc1	$f0,%lo(objectPosition)($2)	 # tmp303, objectPosition
 # BattleBots/BattleBotAI.c:103:             objectPosition[1] = (float)RampArray[TargetPath][Progression].Position[1];
	addiu	$2,$2,%lo(objectPosition)	 # tmp305, tmp299,
 # BattleBots/BattleBotAI.c:103:             objectPosition[1] = (float)RampArray[TargetPath][Progression].Position[1];
	lw	$4,0($6)		 # *_21, *_21
	addu	$4,$4,$3	 # tmp307, *_21, _24
 # BattleBots/BattleBotAI.c:103:             objectPosition[1] = (float)RampArray[TargetPath][Progression].Position[1];
	lh	$4,2($4)		 # _29->Position, _29->Position
	mtc1	$4,$f0	 # _29->Position, _29->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp309, _29->Position
	swc1	$f0,4($2)	 # tmp309, objectPosition
 # BattleBots/BattleBotAI.c:104:             objectPosition[2] = (float)RampArray[TargetPath][Progression].Position[2]; 
	lw	$4,0($6)		 # *_21, *_21
	addu	$3,$4,$3	 # tmp313, *_21, _24
 # BattleBots/BattleBotAI.c:104:             objectPosition[2] = (float)RampArray[TargetPath][Progression].Position[2]; 
	lh	$3,4($3)		 # _33->Position, _33->Position
	mtc1	$3,$f0	 # _33->Position, _33->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp315, _33->Position
 # BattleBots/BattleBotAI.c:105:             break;
	b	$L11	 #
	swc1	$f0,8($2)	 # tmp315, objectPosition

$L10:
 # BattleBots/BattleBotAI.c:107:             objectPosition[0] = (float)DropArray[TargetPath][Progression].Position[0];
	addu	$7,$7,$4	 # _38, DropArray, tmp316
 # BattleBots/BattleBotAI.c:107:             objectPosition[0] = (float)DropArray[TargetPath][Progression].Position[0];
	sll	$3,$3,3	 # _41, Progression,
 # BattleBots/BattleBotAI.c:107:             objectPosition[0] = (float)DropArray[TargetPath][Progression].Position[0];
	lui	$2,%hi(objectPosition)	 # tmp317,
 # BattleBots/BattleBotAI.c:107:             objectPosition[0] = (float)DropArray[TargetPath][Progression].Position[0];
	lw	$4,0($7)		 # *_38, *_38
	addu	$4,$4,$3	 # tmp319, *_38, _41
 # BattleBots/BattleBotAI.c:107:             objectPosition[0] = (float)DropArray[TargetPath][Progression].Position[0];
	lh	$4,0($4)		 # _42->Position, _42->Position
	mtc1	$4,$f0	 # _42->Position, _42->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp321, _42->Position
	swc1	$f0,%lo(objectPosition)($2)	 # tmp321, objectPosition
 # BattleBots/BattleBotAI.c:108:             objectPosition[1] = (float)DropArray[TargetPath][Progression].Position[1];
	addiu	$2,$2,%lo(objectPosition)	 # tmp323, tmp317,
 # BattleBots/BattleBotAI.c:108:             objectPosition[1] = (float)DropArray[TargetPath][Progression].Position[1];
	lw	$4,0($7)		 # *_38, *_38
	addu	$4,$4,$3	 # tmp325, *_38, _41
 # BattleBots/BattleBotAI.c:108:             objectPosition[1] = (float)DropArray[TargetPath][Progression].Position[1];
	lh	$4,2($4)		 # _46->Position, _46->Position
	mtc1	$4,$f0	 # _46->Position, _46->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp327, _46->Position
	swc1	$f0,4($2)	 # tmp327, objectPosition
 # BattleBots/BattleBotAI.c:109:             objectPosition[2] = (float)DropArray[TargetPath][Progression].Position[2]; 
	lw	$4,0($7)		 # *_38, *_38
	addu	$3,$4,$3	 # tmp331, *_38, _41
 # BattleBots/BattleBotAI.c:109:             objectPosition[2] = (float)DropArray[TargetPath][Progression].Position[2]; 
	lh	$3,4($3)		 # _50->Position, _50->Position
	mtc1	$3,$f0	 # _50->Position, _50->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp333, _50->Position
 # BattleBots/BattleBotAI.c:110:             break;
	b	$L11	 #
	swc1	$f0,8($2)	 # tmp333, objectPosition

$L14:
 # BattleBots/BattleBotAI.c:141:             bot_x_stick[i] = -127;  
	lui	$4,%hi(bot_x_stick)	 # tmp412,
	addiu	$4,$4,%lo(bot_x_stick)	 # tmp414, tmp412,
	addu	$16,$16,$4	 # tmp413, i, tmp414
	li	$2,-127			# 0xffffffffffffff81	 # tmp415,
	b	$L8	 #
	sb	$2,0($16)	 # tmp415, bot_x_stick

$L12:
 # BattleBots/BattleBotAI.c:144:     else if (GlobalUInt64 > DRIFTTURN)
	bne	$5,$0,$L39	 #, _66,,
	sll	$3,$16,1	 # tmp422, i,

	bne	$5,$0,$L16	 #, _66,,
	li	$3,52953088			# 0x3280000	 # tmp420,

	ori	$3,$3,0xb101	 # tmp419, tmp420,
	sltu	$3,$6,$3	 # tmp418, _66, tmp419
	bne	$3,$0,$L16	 #, tmp418,,
	sll	$3,$16,1	 # tmp422, i,

$L39:
 # BattleBots/BattleBotAI.c:147:         bot_pressed[i] = BTN_R | BTN_B;   //tap brake and jump
	lui	$4,%hi(bot_pressed)	 # tmp421,
	addiu	$4,$4,%lo(bot_pressed)	 # tmp424, tmp421,
	addu	$4,$3,$4	 # tmp423, tmp422, tmp424
	li	$5,16400			# 0x4010	 # tmp425,
	sh	$5,0($4)	 # tmp425, bot_pressed
 # BattleBots/BattleBotAI.c:148:         bot_buttons[i] |= BTN_B;
	lui	$4,%hi(bot_buttons)	 # tmp426,
	addiu	$4,$4,%lo(bot_buttons)	 # tmp429, tmp426,
	addu	$3,$3,$4	 # tmp428, tmp422, tmp429
	li	$4,-16384			# 0xffffffffffffc000	 # tmp430,
 # BattleBots/BattleBotAI.c:149:         if (GlobalShortA > 0)
	blez	$2,$L18	 #, _63,
	sh	$4,0($3)	 # tmp430, bot_buttons

 # BattleBots/BattleBotAI.c:151:             bot_x_stick[i] = 75;
	lui	$4,%hi(bot_x_stick)	 # tmp431,
	addiu	$4,$4,%lo(bot_x_stick)	 # tmp433, tmp431,
	addu	$16,$16,$4	 # tmp432, i, tmp433
	li	$2,75			# 0x4b	 # tmp434,
	b	$L8	 #
	sb	$2,0($16)	 # tmp434, bot_x_stick

$L18:
 # BattleBots/BattleBotAI.c:155:             bot_x_stick[i] = -75;
	lui	$4,%hi(bot_x_stick)	 # tmp435,
	addiu	$4,$4,%lo(bot_x_stick)	 # tmp437, tmp435,
	addu	$16,$16,$4	 # tmp436, i, tmp437
	li	$2,-75			# 0xffffffffffffffb5	 # tmp438,
	b	$L8	 #
	sb	$2,0($16)	 # tmp438, bot_x_stick

$L16:
 # BattleBots/BattleBotAI.c:158:     else if (GlobalUInt64 > WIDETURN)
	bne	$5,$0,$L33
	nop
	 #, _66,,
	bne	$5,$0,$L19	 #, _66,,
	li	$3,20643840			# 0x13b0000	 # tmp443,

	ori	$3,$3,0xe525	 # tmp442, tmp443,
	sltu	$3,$6,$3	 # tmp441, _66, tmp442
	bne	$3,$0,$L19
	nop
	 #, tmp441,,
$L33:
 # BattleBots/BattleBotAI.c:160:         if (GlobalShortA > 0)
	blez	$2,$L21	 #, _63,
	lui	$4,%hi(bot_x_stick)	 # tmp444,

 # BattleBots/BattleBotAI.c:162:             bot_x_stick[i] = 70;
	addiu	$4,$4,%lo(bot_x_stick)	 # tmp446, tmp444,
	addu	$16,$16,$4	 # tmp445, i, tmp446
	li	$2,70			# 0x46	 # tmp447,
	b	$L8	 #
	sb	$2,0($16)	 # tmp447, bot_x_stick

$L21:
 # BattleBots/BattleBotAI.c:166:             bot_x_stick[i] = -70;
	lui	$2,%hi(bot_x_stick)	 # tmp448,
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp450, tmp448,
	addu	$16,$16,$2	 # tmp449, i, tmp450
	li	$2,-70			# 0xffffffffffffffba	 # tmp451,
	b	$L8	 #
	sb	$2,0($16)	 # tmp451, bot_x_stick

$L19:
 # BattleBots/BattleBotAI.c:169:     else if (GlobalUInt64 > MIDTURN)
	bne	$5,$0,$L34
	nop
	 #, _66,,
	bne	$5,$0,$L22	 #, _66,,
	li	$3,4718592			# 0x480000	 # tmp456,

	ori	$3,$3,0xc841	 # tmp455, tmp456,
	sltu	$3,$6,$3	 # tmp454, _66, tmp455
	bne	$3,$0,$L22
	nop
	 #, tmp454,,
$L34:
 # BattleBots/BattleBotAI.c:173:         if (GlobalShortA > 0)
	blez	$2,$L24	 #, _63,
	lui	$2,%hi(bot_x_stick)	 # tmp457,

 # BattleBots/BattleBotAI.c:175:             bot_x_stick[i] = 55;
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp459, tmp457,
	addu	$16,$16,$2	 # tmp458, i, tmp459
	li	$2,55			# 0x37	 # tmp460,
	b	$L8	 #
	sb	$2,0($16)	 # tmp460, bot_x_stick

$L24:
 # BattleBots/BattleBotAI.c:179:             bot_x_stick[i] = -55;
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp463, tmp461,
	addu	$16,$16,$2	 # tmp462, i, tmp463
	li	$2,-55			# 0xffffffffffffffc9	 # tmp464,
	b	$L8	 #
	sb	$2,0($16)	 # tmp464, bot_x_stick

$L22:
 # BattleBots/BattleBotAI.c:182:     else if (GlobalUInt64 > SHORTTURN)
	bne	$5,$0,$L35
	nop
	 #, _66,,
	bne	$5,$0,$L25	 #, _66,,
	li	$3,786432			# 0xc0000	 # tmp469,

	ori	$3,$3,0xa2c5	 # tmp468, tmp469,
	sltu	$3,$6,$3	 # tmp467, _66, tmp468
	bne	$3,$0,$L25
	nop
	 #, tmp467,,
$L35:
 # BattleBots/BattleBotAI.c:185:         if (GlobalShortA > 0)
	blez	$2,$L27	 #, _63,
	lui	$2,%hi(bot_x_stick)	 # tmp470,

 # BattleBots/BattleBotAI.c:187:             bot_x_stick[i] = 45;
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp472, tmp470,
	addu	$16,$16,$2	 # tmp471, i, tmp472
	li	$2,45			# 0x2d	 # tmp473,
	b	$L8	 #
	sb	$2,0($16)	 # tmp473, bot_x_stick

$L27:
 # BattleBots/BattleBotAI.c:191:             bot_x_stick[i] = -45;
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp476, tmp474,
	addu	$16,$16,$2	 # tmp475, i, tmp476
	li	$2,-45			# 0xffffffffffffffd3	 # tmp477,
	b	$L8	 #
	sb	$2,0($16)	 # tmp477, bot_x_stick

$L25:
 # BattleBots/BattleBotAI.c:195:     else if (GlobalUInt64 > NOTURN)
	bne	$5,$0,$L36
	nop
	 #, _66,,
	bnel	$5,$0,$L40	 #, _66,,
	lui	$2,%hi(bot_x_stick)	 # tmp491,

	li	$3,131072			# 0x20000	 # tmp482,
	addiu	$3,$3,1425	 # tmp481, tmp482,
	sltu	$6,$6,$3	 # tmp480, _66, tmp481
	bnel	$6,$0,$L28	 #, tmp480,,
	lui	$2,%hi(bot_x_stick)	 # tmp491,

$L36:
 # BattleBots/BattleBotAI.c:197:         if (GlobalShortA > 0)
	blez	$2,$L30	 #, _63,
	lui	$2,%hi(bot_x_stick)	 # tmp483,

 # BattleBots/BattleBotAI.c:199:             bot_x_stick[i] = 29;
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp485, tmp483,
	addu	$16,$16,$2	 # tmp484, i, tmp485
	li	$2,29			# 0x1d	 # tmp486,
	b	$L8	 #
	sb	$2,0($16)	 # tmp486, bot_x_stick

$L30:
 # BattleBots/BattleBotAI.c:203:             bot_x_stick[i] = -29;
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp489, tmp487,
	addu	$16,$16,$2	 # tmp488, i, tmp489
	li	$2,-29			# 0xffffffffffffffe3	 # tmp490,
	b	$L8	 #
	sb	$2,0($16)	 # tmp490, bot_x_stick

$L28:
$L40:
 # BattleBots/BattleBotAI.c:209:         bot_x_stick[i] = 0x00;
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp493, tmp491,
	addu	$16,$16,$2	 # tmp492, i, tmp493
 # BattleBots/BattleBotAI.c:212: }
	b	$L8	 #
	sb	$0,0($16)	 #, bot_x_stick

	.set	macro
	.set	reorder
	.end	ProSteeringPlus
	.size	ProSteeringPlus, .-ProSteeringPlus
	.align	2
	.globl	StandardBattleBot
	.set	nomips16
	.set	nomicromips
	.ent	StandardBattleBot
	.type	StandardBattleBot, @function
StandardBattleBot:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32	 #,,
	sw	$31,28($sp)	 #,
	sw	$17,24($sp)	 #,
	sw	$16,20($sp)	 #,
	move	$17,$4	 # i, tmp307
 # BattleBots/BattleBotAI.c:227:     AIPathfinder[i].TargetPath = -1;
	sll	$4,$4,5	 # tmp211, i,
	lui	$6,%hi(AIPathfinder)	 # tmp210,
	addiu	$6,$6,%lo(AIPathfinder)	 # tmp213, tmp210,
	addu	$2,$4,$6	 # tmp212, tmp211, tmp213
	li	$3,-1			# 0xffffffffffffffff	 # tmp214,
	sh	$3,0($2)	 # tmp214, AIPathfinder[i_12(D)].TargetPath
 # BattleBots/BattleBotAI.c:231:             switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x7) ) //Returns -1 or 1, to give direction to turn
	sll	$2,$17,3	 # tmp216, i,
	subu	$16,$2,$17	 # tmp217, tmp216, i
	sll	$16,$16,4	 # tmp218, tmp217,
	subu	$16,$16,$17	 # tmp219, tmp218, i
	sll	$16,$16,2	 # tmp220, tmp219,
	subu	$16,$16,$17	 # tmp221, tmp220, i
	sll	$16,$16,3	 # tmp222, tmp221,
	addiu	$16,$16,20	 # tmp223, tmp222,
	lui	$3,%hi(GlobalPlayer)	 # tmp225,
	addiu	$3,$3,%lo(GlobalPlayer)	 # tmp224, tmp225,
	addu	$16,$3,$16	 # _1, tmp224, tmp223
 # BattleBots/BattleBotAI.c:231:             switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x7) ) //Returns -1 or 1, to give direction to turn
	addiu	$4,$4,8	 # tmp227, tmp211,
 # BattleBots/BattleBotAI.c:231:             switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x7) ) //Returns -1 or 1, to give direction to turn
	subu	$2,$2,$17	 # tmp236, tmp216, i
	sll	$2,$2,4	 # tmp237, tmp236,
	subu	$2,$2,$17	 # tmp238, tmp237, i
	sll	$2,$2,2	 # tmp239, tmp238,
	subu	$2,$2,$17	 # tmp240, tmp239, i
	sll	$2,$2,3	 # tmp241, tmp240,
	addu	$2,$3,$2	 # tmp233, tmp224, tmp241
	li	$7,7			# 0x7	 #,
	addu	$6,$6,$4	 #, tmp213, tmp227
	lh	$5,46($2)		 #, GlobalPlayer[i_12(D)].direction
	jal	ObjectSubBehaviorTurnTarget	 #
	move	$4,$16	 #, _1

 # BattleBots/BattleBotAI.c:231:             switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x7) ) //Returns -1 or 1, to give direction to turn
	beq	$2,$0,$L42	 #, _4,,
	li	$3,1			# 0x1	 # tmp244,

	beq	$2,$3,$L43	 #, _4, tmp244,
	li	$3,-1			# 0xffffffffffffffff	 # tmp245,

	beq	$2,$3,$L49	 #, _4, tmp245,
	sll	$2,$17,1	 # tmp299, i,

$L41:
 # BattleBots/BattleBotAI.c:273: }
	lw	$31,28($sp)		 #,
	lw	$17,24($sp)		 #,
	lw	$16,20($sp)		 #,
	jr	$31	 #
	addiu	$sp,$sp,32	 #,,

$L42:
 # BattleBots/BattleBotAI.c:234:                     if (TestCollideSphere(GlobalPlayer[bot_rival_p1[i]].position, 35, GlobalPlayer[i].position, 35)) //&& ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x4)==0)  //If near rival, use weapon (note this is meant to only be when near a rival NOT necessarily another type of target)
	lui	$2,%hi($LC2)	 # tmp247,
	lw	$5,%lo($LC2)($2)		 # tmp246,
 # BattleBots/BattleBotAI.c:234:                     if (TestCollideSphere(GlobalPlayer[bot_rival_p1[i]].position, 35, GlobalPlayer[i].position, 35)) //&& ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x4)==0)  //If near rival, use weapon (note this is meant to only be when near a rival NOT necessarily another type of target)
	lui	$2,%hi(bot_rival_p1)	 # tmp250,
	addiu	$2,$2,%lo(bot_rival_p1)	 # tmp252, tmp250,
	addu	$2,$17,$2	 # tmp251, i, tmp252
 # BattleBots/BattleBotAI.c:234:                     if (TestCollideSphere(GlobalPlayer[bot_rival_p1[i]].position, 35, GlobalPlayer[i].position, 35)) //&& ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x4)==0)  //If near rival, use weapon (note this is meant to only be when near a rival NOT necessarily another type of target)
	lbu	$4,0($2)	 # tmp253, bot_rival_p1
	sll	$2,$4,3	 # tmp255, tmp253,
	subu	$2,$2,$4	 # tmp256, tmp255, tmp253
	sll	$2,$2,4	 # tmp257, tmp256,
	subu	$2,$2,$4	 # tmp258, tmp257, tmp253
	sll	$2,$2,2	 # tmp259, tmp258,
	subu	$2,$2,$4	 # tmp260, tmp259, tmp253
	sll	$2,$2,3	 # tmp261, tmp260,
	addiu	$2,$2,20	 # tmp262, tmp261,
 # BattleBots/BattleBotAI.c:234:                     if (TestCollideSphere(GlobalPlayer[bot_rival_p1[i]].position, 35, GlobalPlayer[i].position, 35)) //&& ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x4)==0)  //If near rival, use weapon (note this is meant to only be when near a rival NOT necessarily another type of target)
	move	$7,$5	 #, tmp246
	move	$6,$16	 #, _1
	lui	$4,%hi(GlobalPlayer)	 # tmp264,
	addiu	$4,$4,%lo(GlobalPlayer)	 # tmp263, tmp264,
	jal	TestCollideSphere	 #
	addu	$4,$4,$2	 #, tmp263, tmp262

 # BattleBots/BattleBotAI.c:234:                     if (TestCollideSphere(GlobalPlayer[bot_rival_p1[i]].position, 35, GlobalPlayer[i].position, 35)) //&& ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x4)==0)  //If near rival, use weapon (note this is meant to only be when near a rival NOT necessarily another type of target)
	beq	$2,$0,$L46	 #, tmp309,,
	sll	$2,$17,1	 # tmp278, i,

 # BattleBots/BattleBotAI.c:236:                         bot_pressed[i] = BTN_Z;
	lui	$3,%hi(bot_pressed)	 # tmp267,
	addiu	$3,$3,%lo(bot_pressed)	 # tmp270, tmp267,
	addu	$3,$2,$3	 # tmp269, tmp268, tmp270
	li	$4,8192			# 0x2000	 # tmp271,
	sh	$4,0($3)	 # tmp271, bot_pressed
 # BattleBots/BattleBotAI.c:237:                         bot_buttons[i] = BTN_A + BTN_Z;
	lui	$3,%hi(bot_buttons)	 # tmp272,
	addiu	$3,$3,%lo(bot_buttons)	 # tmp275, tmp272,
	addu	$2,$2,$3	 # tmp274, tmp268, tmp275
	li	$3,-24576			# 0xffffffffffffa000	 # tmp276,
	sh	$3,0($2)	 # tmp276, bot_buttons
$L47:
 # BattleBots/BattleBotAI.c:250:                     bot_x_stick[i] = 0x00;
	lui	$4,%hi(bot_x_stick)	 # tmp286,
	addiu	$4,$4,%lo(bot_x_stick)	 # tmp288, tmp286,
	addu	$17,$17,$4	 # tmp287, i, tmp288
 # BattleBots/BattleBotAI.c:251:                     break;
	b	$L41	 #
	sb	$0,0($17)	 #, bot_x_stick

$L46:
 # BattleBots/BattleBotAI.c:247:                         bot_pressed[i] = 0;
	lui	$3,%hi(bot_pressed)	 # tmp277,
	addiu	$3,$3,%lo(bot_pressed)	 # tmp280, tmp277,
	addu	$3,$2,$3	 # tmp279, tmp278, tmp280
	sh	$0,0($3)	 #, bot_pressed
 # BattleBots/BattleBotAI.c:248:                         bot_buttons[i] = BTN_A;
	lui	$3,%hi(bot_buttons)	 # tmp281,
	addiu	$3,$3,%lo(bot_buttons)	 # tmp284, tmp281,
	addu	$2,$2,$3	 # tmp283, tmp278, tmp284
	li	$3,-32768			# 0xffffffffffff8000	 # tmp285,
	b	$L47	 #
	sh	$3,0($2)	 # tmp285, bot_buttons

$L43:
 # BattleBots/BattleBotAI.c:253:                     bot_buttons[i] = BTN_A + BTN_B;
	sll	$2,$17,1	 # tmp290, i,
	lui	$3,%hi(bot_buttons)	 # tmp289,
	addiu	$3,$3,%lo(bot_buttons)	 # tmp292, tmp289,
	addu	$2,$2,$3	 # tmp291, tmp290, tmp292
	li	$3,-16384			# 0xffffffffffffc000	 # tmp293,
	sh	$3,0($2)	 # tmp293, bot_buttons
 # BattleBots/BattleBotAI.c:254:                     bot_x_stick[i] = 0x50;
	lui	$4,%hi(bot_x_stick)	 # tmp294,
	addiu	$4,$4,%lo(bot_x_stick)	 # tmp296, tmp294,
	addu	$17,$17,$4	 # tmp295, i, tmp296
	li	$2,80			# 0x50	 # tmp297,
 # BattleBots/BattleBotAI.c:255:                     break;
	b	$L41	 #
	sb	$2,0($17)	 # tmp297, bot_x_stick

$L49:
 # BattleBots/BattleBotAI.c:257:                     bot_buttons[i] = BTN_A + BTN_B;
	lui	$3,%hi(bot_buttons)	 # tmp298,
	addiu	$3,$3,%lo(bot_buttons)	 # tmp301, tmp298,
	addu	$2,$2,$3	 # tmp300, tmp299, tmp301
	li	$3,-16384			# 0xffffffffffffc000	 # tmp302,
	sh	$3,0($2)	 # tmp302, bot_buttons
 # BattleBots/BattleBotAI.c:258:                     bot_x_stick[i] = -0x50;
	lui	$4,%hi(bot_x_stick)	 # tmp303,
	addiu	$4,$4,%lo(bot_x_stick)	 # tmp305, tmp303,
	addu	$17,$17,$4	 # tmp304, i, tmp305
	li	$2,-80			# 0xffffffffffffffb0	 # tmp306,
 # BattleBots/BattleBotAI.c:273: }
	b	$L41	 #
	sb	$2,0($17)	 # tmp306, bot_x_stick

	.set	macro
	.set	reorder
	.end	StandardBattleBot
	.size	StandardBattleBot, .-StandardBattleBot
	.align	2
	.globl	RandomBattleBot
	.set	nomips16
	.set	nomicromips
	.ent	RandomBattleBot
	.type	RandomBattleBot, @function
RandomBattleBot:
	.frame	$sp,104,$31		# vars= 8, regs= 10/8, args= 24, gp= 0
	.mask	0xc0ff0000,-36
	.fmask	0x0ff00000,-8
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-104	 #,,
	sw	$31,68($sp)	 #,
	sw	$fp,64($sp)	 #,
	sw	$23,60($sp)	 #,
	sw	$22,56($sp)	 #,
	sw	$21,52($sp)	 #,
	sw	$20,48($sp)	 #,
	sw	$19,44($sp)	 #,
	sw	$18,40($sp)	 #,
	sw	$17,36($sp)	 #,
	sw	$16,32($sp)	 #,
	sdc1	$f26,96($sp)	 #,
	sdc1	$f24,88($sp)	 #,
	sdc1	$f22,80($sp)	 #,
	sdc1	$f20,72($sp)	 #,
	move	$22,$4	 # i, tmp705
 # BattleBots/BattleBotAI.c:869:     float x_distance_squared = pow(GlobalPlayer[i].position[0]-test_bot_sphere_position[i][0], 2);
	sll	$3,$4,1	 # tmp277, i,
	addu	$3,$3,$4	 # tmp278, tmp277, i
	sll	$3,$3,2	 # tmp279, tmp278,
	lui	$2,%hi(test_bot_sphere_position)	 # tmp275,
	addiu	$2,$2,%lo(test_bot_sphere_position)	 # tmp281, tmp275,
	addu	$3,$3,$2	 # tmp280, tmp279, tmp281
	lwc1	$f6,0($3)	 # _2, test_bot_sphere_position
 # BattleBots/BattleBotAI.c:869:     float x_distance_squared = pow(GlobalPlayer[i].position[0]-test_bot_sphere_position[i][0], 2);
	lui	$4,%hi(GlobalPlayer)	 # tmp282,
	sll	$2,$22,3	 # tmp286, i,
	subu	$2,$2,$22	 # tmp287, tmp286, i
	sll	$2,$2,4	 # tmp288, tmp287,
	subu	$2,$2,$22	 # tmp289, tmp288, i
	sll	$2,$2,2	 # tmp290, tmp289,
	subu	$2,$2,$22	 # tmp291, tmp290, i
	sll	$2,$2,3	 # tmp292, tmp291,
	addiu	$4,$4,%lo(GlobalPlayer)	 # tmp283, tmp282,
	addu	$2,$4,$2	 # tmp284, tmp283, tmp292
 # BattleBots/BattleBotAI.c:869:     float x_distance_squared = pow(GlobalPlayer[i].position[0]-test_bot_sphere_position[i][0], 2);
	lwc1	$f0,20($2)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	sub.s	$f0,$f0,$f6	 # _3, GlobalPlayer[i_85(D)].position, _2
 # BattleBots/BattleBotAI.c:870:     float y_distance_squared = pow(GlobalPlayer[i].position[1]-test_bot_sphere_position[i][1], 2);
	lwc1	$f2,24($2)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	lwc1	$f4,4($3)	 # tmp313, test_bot_sphere_position
	sub.s	$f2,$f2,$f4	 # _8, GlobalPlayer[i_85(D)].position, tmp313
	mul.s	$f2,$f2,$f2	 # _34, _8, _8
 # BattleBots/BattleBotAI.c:871:     float z_distance_squared = pow(GlobalPlayer[i].position[2]-test_bot_sphere_position[i][2], 2);
	lwc1	$f4,28($2)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	lwc1	$f8,8($3)	 # tmp333, test_bot_sphere_position
	sub.s	$f4,$f4,$f8	 # _13, GlobalPlayer[i_85(D)].position, tmp333
 # BattleBots/BattleBotAI.c:872:     bot_distance_from_path_marker[i] = x_distance_squared + y_distance_squared + z_distance_squared;
	mul.s	$f0,$f0,$f0	 # tmp334, _3, _3
	add.s	$f0,$f0,$f2	 # tmp335, tmp334, _34
 # BattleBots/BattleBotAI.c:872:     bot_distance_from_path_marker[i] = x_distance_squared + y_distance_squared + z_distance_squared;
	mul.s	$f4,$f4,$f4	 # tmp336, _13, _13
	add.s	$f0,$f0,$f4	 # _17, tmp335, tmp336
 # BattleBots/BattleBotAI.c:872:     bot_distance_from_path_marker[i] = x_distance_squared + y_distance_squared + z_distance_squared;
	sll	$2,$22,2	 # tmp338, i,
	lui	$3,%hi(bot_distance_from_path_marker)	 # tmp337,
	addiu	$3,$3,%lo(bot_distance_from_path_marker)	 # tmp340, tmp337,
	addu	$2,$2,$3	 # tmp339, tmp338, tmp340
	swc1	$f0,0($2)	 # _17, bot_distance_from_path_marker
 # BattleBots/BattleBotAI.c:874:     if  (y_distance_squared > 200.0) //If elevation has changed signifcantly
	lui	$2,%hi($LC3)	 # tmp342,
	lwc1	$f4,%lo($LC3)($2)	 # tmp341,
	c.lt.s	$f4,$f2	 #, tmp341, _34
	nop	
	bc1t	$L65	 #,,
	lui	$2,%hi($LC5)	 # tmp436,

 # BattleBots/BattleBotAI.c:885:     else if ((bot_distance_from_path_marker[i] <= 62500.0) || (test_bot_sphere_position[i][0] == 0.0)) //If bot comes near point or if game is started
	lwc1	$f2,%lo($LC5)($2)	 # tmp435,
	c.le.s	$f0,$f2	 #, _17, tmp435
	nop	
	bc1t	$L67	 #,,
	sll	$23,$22,6	 # tmp438, i,

 # BattleBots/BattleBotAI.c:885:     else if ((bot_distance_from_path_marker[i] <= 62500.0) || (test_bot_sphere_position[i][0] == 0.0)) //If bot comes near point or if game is started
	mtc1	$0,$f0	 #, tmp437
	nop	
	c.eq.s	$f6,$f0	 #, _2, tmp437
	nop	
	bc1f	$L68	 #,,
	sll	$5,$22,1	 # tmp645, i,

 # BattleBots/BattleBotAI.c:902:             bumpCheckValue3= check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1], objectPosition[2]);
	sll	$23,$22,6	 # tmp438, i,
$L67:
	lui	$2,%hi(bot_bump)	 # tmp440,
	addiu	$2,$2,%lo(bot_bump)	 # tmp439, tmp440,
	addu	$23,$2,$23	 # _45, tmp439, tmp438
	li	$20,4096			# 0x1000	 # randomness,
 # BattleBots/BattleBotAI.c:895:             objectPosition[0] = 0.0; //Set up vector IN FRONT of player
	lui	$18,%hi(objectPosition)	 # tmp441,
 # BattleBots/BattleBotAI.c:896:             objectPosition[1] = -5.0;
	addiu	$16,$18,%lo(objectPosition)	 # tmp443, tmp441,
	lui	$2,%hi($LC6)	 # tmp444,
	lwc1	$f26,%lo($LC6)($2)	 # tmp445,
 # BattleBots/BattleBotAI.c:897:             objectPosition[2] = 70.0;                            
	lui	$2,%hi($LC7)	 # tmp448,
	lwc1	$f24,%lo($LC7)($2)	 # tmp449,
 # BattleBots/BattleBotAI.c:898:             MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1]);
	lui	$17,%hi(GlobalPlayer)	 # tmp450,
	sll	$2,$22,3	 # tmp454, i,
	subu	$2,$2,$22	 # tmp455, tmp454, i
	sll	$2,$2,4	 # tmp456, tmp455,
	subu	$2,$2,$22	 # tmp457, tmp456, i
	sll	$2,$2,2	 # tmp458, tmp457,
	subu	$2,$2,$22	 # tmp459, tmp458, i
	sll	$2,$2,3	 # tmp460, tmp459,
	addiu	$17,$17,%lo(GlobalPlayer)	 # tmp451, tmp450,
	addu	$17,$17,$2	 # tmp452, tmp451, tmp460
 # BattleBots/BattleBotAI.c:902:             bumpCheckValue3= check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1], objectPosition[2]);
	lui	$2,%hi($LC8)	 # tmp513,
	lw	$fp,%lo($LC8)($2)		 # tmp512,
 # BattleBots/BattleBotAI.c:907:             objectPosition[2] = 300.0;
	lui	$2,%hi($LC9)	 # tmp520,
	lwc1	$f22,%lo($LC9)($2)	 # tmp521,
 # BattleBots/BattleBotAI.c:913:             bumpCheckValue2 = check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1]-5.0, objectPosition[2]);
	lui	$2,%hi($LC10)	 # tmp601,
	lwc1	$f20,%lo($LC10)($2)	 # tmp600,
 # BattleBots/BattleBotAI.c:895:             objectPosition[0] = 0.0; //Set up vector IN FRONT of player
	sw	$0,%lo(objectPosition)($18)	 #, objectPosition
$L69:
 # BattleBots/BattleBotAI.c:896:             objectPosition[1] = -5.0;
	swc1	$f26,4($16)	 # tmp445, objectPosition
 # BattleBots/BattleBotAI.c:897:             objectPosition[2] = 70.0;                            
	swc1	$f24,8($16)	 # tmp449, objectPosition
 # BattleBots/BattleBotAI.c:898:             MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1]);
	lh	$5,46($17)		 #, GlobalPlayer[i_85(D)].direction
	jal	MakeAlignVector	 #
	move	$4,$16	 #, tmp443

 # BattleBots/BattleBotAI.c:899:             objectPosition[0] += GlobalPlayer[i].position[0];
	lwc1	$f0,%lo(objectPosition)($18)	 # objectPosition, objectPosition
	lwc1	$f2,20($17)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	add.s	$f0,$f0,$f2	 # _38, objectPosition, GlobalPlayer[i_85(D)].position
	mfc1	$6,$f0	 # _38, _38
	swc1	$f0,%lo(objectPosition)($18)	 # _38, objectPosition
 # BattleBots/BattleBotAI.c:900:             objectPosition[1] += GlobalPlayer[i].position[1];
	lwc1	$f0,4($16)	 # objectPosition, objectPosition
	lwc1	$f2,24($17)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	add.s	$f0,$f0,$f2	 # _41, objectPosition, GlobalPlayer[i_85(D)].position
	mfc1	$7,$f0	 # _41, _41
	swc1	$f0,4($16)	 # _41, objectPosition
 # BattleBots/BattleBotAI.c:901:             objectPosition[2] += GlobalPlayer[i].position[2];
	lwc1	$f0,8($16)	 # objectPosition, objectPosition
	lwc1	$f2,28($17)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	add.s	$f0,$f0,$f2	 # _44, objectPosition, GlobalPlayer[i_85(D)].position
	swc1	$f0,8($16)	 # _44, objectPosition
 # BattleBots/BattleBotAI.c:902:             bumpCheckValue3= check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1], objectPosition[2]);
	swc1	$f0,16($sp)	 # _44,
	move	$5,$fp	 #, tmp512
	jal	check_bump	 #
	move	$4,$23	 #, _45

	sw	$2,24($sp)	 # tmp707, %sfp
 # BattleBots/BattleBotAI.c:905:             objectPosition[0] = 0.0; //Set up vector IN FRONT of player
	sw	$0,%lo(objectPosition)($18)	 #, objectPosition
 # BattleBots/BattleBotAI.c:906:             objectPosition[1] = 0.0;
	sw	$0,4($16)	 #, objectPosition
 # BattleBots/BattleBotAI.c:907:             objectPosition[2] = 300.0;
	swc1	$f22,8($16)	 # tmp521, objectPosition
 # BattleBots/BattleBotAI.c:908:             MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
	lhu	$19,46($17)	 # _48, GlobalPlayer[i_85(D)].direction
	andi	$21,$20,0xffff	 # _5, randomness
 # BattleBots/BattleBotAI.c:908:             MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
	jal	MakeRandomLimmit	 #
	move	$4,$21	 #, _5

 # BattleBots/BattleBotAI.c:908:             MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
	addu	$19,$19,$2	 # tmp534, _48, tmp708
 # BattleBots/BattleBotAI.c:908:             MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
	srl	$5,$20,31	 # tmp536, randomness,
	addu	$5,$5,$20	 # tmp537, tmp536, randomness
	sra	$5,$5,1	 # tmp538, tmp537,
	subu	$5,$19,$5	 # tmp541, tmp534, tmp538
 # BattleBots/BattleBotAI.c:908:             MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
	sll	$5,$5,16	 #, tmp541,
	sra	$5,$5,16	 #,,
	jal	MakeAlignVector	 #
	move	$4,$16	 #, tmp443

 # BattleBots/BattleBotAI.c:909:             objectPosition[0] += GlobalPlayer[i].position[0];
	lwc1	$f0,%lo(objectPosition)($18)	 # objectPosition, objectPosition
	lwc1	$f2,20($17)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	add.s	$f0,$f0,$f2	 # _58, objectPosition, GlobalPlayer[i_85(D)].position
	mfc1	$6,$f0	 # _58, _58
	swc1	$f0,%lo(objectPosition)($18)	 # _58, objectPosition
 # BattleBots/BattleBotAI.c:910:             objectPosition[1] += GlobalPlayer[i].position[1];
	lwc1	$f0,4($16)	 # objectPosition, objectPosition
	lwc1	$f2,24($17)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	add.s	$f0,$f0,$f2	 # _61, objectPosition, GlobalPlayer[i_85(D)].position
	mfc1	$7,$f0	 # _61, _61
	swc1	$f0,4($16)	 # _61, objectPosition
 # BattleBots/BattleBotAI.c:911:             objectPosition[2] += GlobalPlayer[i].position[2];
	lwc1	$f0,8($16)	 # objectPosition, objectPosition
	lwc1	$f2,28($17)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	add.s	$f0,$f0,$f2	 # _64, objectPosition, GlobalPlayer[i_85(D)].position
	swc1	$f0,8($16)	 # _64, objectPosition
 # BattleBots/BattleBotAI.c:912:             bumpCheckValue1 = check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1], objectPosition[2]);
	swc1	$f0,16($sp)	 # _64,
	move	$5,$fp	 #, tmp512
	jal	check_bump	 #
	move	$4,$23	 #, _45

	move	$19,$2	 # tmp595, tmp709
 # BattleBots/BattleBotAI.c:913:             bumpCheckValue2 = check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1]-5.0, objectPosition[2]);
	lwc1	$f0,4($16)	 # objectPosition, objectPosition
	lwc1	$f2,8($16)	 # objectPosition, objectPosition
	swc1	$f2,16($sp)	 # objectPosition,
	sub.s	$f0,$f0,$f20	 # tmp717, objectPosition, tmp600
	mfc1	$7,$f0	 #, tmp717
	lw	$6,%lo(objectPosition)($18)		 #, objectPosition
	move	$5,$fp	 #, tmp512
	jal	check_bump	 #
	move	$4,$23	 #, _45

	addiu	$20,$21,128	 # tmp610, _5,
	sll	$20,$20,16	 # randomness, tmp610,
 # BattleBots/BattleBotAI.c:920:         }while((bumpCheckValue1 != 0x4000 && bumpCheckValue2 != 0x4000 && bumpCheckValue3 != 0x4000) && count < 100);
	li	$3,16384			# 0x4000	 # tmp611,
	beq	$19,$3,$L55	 #, tmp595, tmp611,
	sra	$20,$20,16	 # randomness, randomness,

 # BattleBots/BattleBotAI.c:920:         }while((bumpCheckValue1 != 0x4000 && bumpCheckValue2 != 0x4000 && bumpCheckValue3 != 0x4000) && count < 100);
	beq	$2,$3,$L55	 #, _70, tmp612,
	li	$2,16384			# 0x4000	 # tmp613,

 # BattleBots/BattleBotAI.c:920:         }while((bumpCheckValue1 != 0x4000 && bumpCheckValue2 != 0x4000 && bumpCheckValue3 != 0x4000) && count < 100);
	lw	$3,24($sp)		 # _46, %sfp
	beq	$3,$2,$L55	 #, _46, tmp613,
	li	$2,16896			# 0x4200	 # tmp614,

 # BattleBots/BattleBotAI.c:920:         }while((bumpCheckValue1 != 0x4000 && bumpCheckValue2 != 0x4000 && bumpCheckValue3 != 0x4000) && count < 100);
	bnel	$20,$2,$L69	 #, randomness, tmp614,
	sw	$0,%lo(objectPosition)($18)	 #, objectPosition

$L55:
 # BattleBots/BattleBotAI.c:921:         test_bot_sphere_position[i][0] = objectPosition[0];
	sll	$2,$22,1	 # tmp617, i,
	addu	$2,$2,$22	 # tmp618, tmp617, i
	sll	$2,$2,2	 # tmp619, tmp618,
	lui	$3,%hi(test_bot_sphere_position)	 # tmp615,
	addiu	$3,$3,%lo(test_bot_sphere_position)	 # tmp621, tmp615,
	addu	$2,$2,$3	 # tmp620, tmp619, tmp621
 # BattleBots/BattleBotAI.c:921:         test_bot_sphere_position[i][0] = objectPosition[0];
	lui	$3,%hi(objectPosition)	 # tmp622,
 # BattleBots/BattleBotAI.c:921:         test_bot_sphere_position[i][0] = objectPosition[0];
	lwc1	$f0,%lo(objectPosition)($3)	 # objectPosition, objectPosition
	swc1	$f0,0($2)	 # objectPosition, test_bot_sphere_position
 # BattleBots/BattleBotAI.c:922:         test_bot_sphere_position[i][1] = objectPosition[1];
	addiu	$3,$3,%lo(objectPosition)	 # tmp632, tmp622,
 # BattleBots/BattleBotAI.c:922:         test_bot_sphere_position[i][1] = objectPosition[1];
	lwc1	$f0,4($3)	 # objectPosition, objectPosition
	swc1	$f0,4($2)	 # objectPosition, test_bot_sphere_position
 # BattleBots/BattleBotAI.c:923:         test_bot_sphere_position[i][2] = objectPosition[2];
	lwc1	$f0,8($3)	 # objectPosition, objectPosition
	swc1	$f0,8($2)	 # objectPosition, test_bot_sphere_position
$L53:
 # BattleBots/BattleBotAI.c:926:     switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], test_bot_sphere_position[i], 0x7) ) //Returns -1 or 1, to give direction to turn
	sll	$5,$22,1	 # tmp645, i,
$L68:
	addu	$5,$5,$22	 # tmp646, tmp645, i
	sll	$5,$5,2	 # tmp647, tmp646,
 # BattleBots/BattleBotAI.c:926:     switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], test_bot_sphere_position[i], 0x7) ) //Returns -1 or 1, to give direction to turn
	lui	$4,%hi(GlobalPlayer)	 # tmp651,
	addiu	$4,$4,%lo(GlobalPlayer)	 # tmp652, tmp651,
	sll	$2,$22,3	 # tmp655, i,
	subu	$3,$2,$22	 # tmp656, tmp655, i
	sll	$3,$3,4	 # tmp657, tmp656,
	subu	$3,$3,$22	 # tmp658, tmp657, i
	sll	$3,$3,2	 # tmp659, tmp658,
	subu	$3,$3,$22	 # tmp660, tmp659, i
	sll	$3,$3,3	 # tmp661, tmp660,
	addu	$3,$4,$3	 # tmp653, tmp652, tmp661
 # BattleBots/BattleBotAI.c:926:     switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], test_bot_sphere_position[i], 0x7) ) //Returns -1 or 1, to give direction to turn
	subu	$2,$2,$22	 # tmp665, tmp655, i
	sll	$2,$2,4	 # tmp666, tmp665,
	subu	$2,$2,$22	 # tmp667, tmp666, i
	sll	$2,$2,2	 # tmp668, tmp667,
	subu	$2,$2,$22	 # tmp669, tmp668, i
	sll	$2,$2,3	 # tmp670, tmp669,
	addiu	$2,$2,20	 # tmp671, tmp670,
 # BattleBots/BattleBotAI.c:926:     switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], test_bot_sphere_position[i], 0x7) ) //Returns -1 or 1, to give direction to turn
	li	$7,7			# 0x7	 #,
	lui	$6,%hi(test_bot_sphere_position)	 # tmp649,
	addiu	$6,$6,%lo(test_bot_sphere_position)	 # tmp648, tmp649,
	addu	$6,$6,$5	 #, tmp648, tmp647
	lh	$5,46($3)		 #, GlobalPlayer[i_85(D)].direction
	jal	ObjectSubBehaviorTurnTarget	 #
	addu	$4,$4,$2	 #, tmp652, tmp671

 # BattleBots/BattleBotAI.c:926:     switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], test_bot_sphere_position[i], 0x7) ) //Returns -1 or 1, to give direction to turn
	beq	$2,$0,$L57	 #, _78,,
	li	$3,1			# 0x1	 # tmp676,

	beq	$2,$3,$L58	 #, _78, tmp676,
	li	$3,-1			# 0xffffffffffffffff	 # tmp677,

	beq	$2,$3,$L66	 #, _78, tmp677,
	sll	$2,$22,1	 # tmp696, i,

$L50:
 # BattleBots/BattleBotAI.c:944: }
	lw	$31,68($sp)		 #,
	lw	$fp,64($sp)		 #,
	lw	$23,60($sp)		 #,
	lw	$22,56($sp)		 #,
	lw	$21,52($sp)		 #,
	lw	$20,48($sp)		 #,
	lw	$19,44($sp)		 #,
	lw	$18,40($sp)		 #,
	lw	$17,36($sp)		 #,
	lw	$16,32($sp)		 #,
	ldc1	$f26,96($sp)	 #,
	ldc1	$f24,88($sp)	 #,
	ldc1	$f22,80($sp)	 #,
	ldc1	$f20,72($sp)	 #,
	jr	$31	 #
	addiu	$sp,$sp,104	 #,,

$L65:
 # BattleBots/BattleBotAI.c:877:         objectPosition[0] = 0.0; //Set up vector IN FRONT of player
	lui	$17,%hi(objectPosition)	 # tmp343,
	sw	$0,%lo(objectPosition)($17)	 #, objectPosition
 # BattleBots/BattleBotAI.c:878:         objectPosition[1] = 0.0;
	addiu	$16,$17,%lo(objectPosition)	 # tmp345, tmp343,
	sw	$0,4($16)	 #, objectPosition
 # BattleBots/BattleBotAI.c:879:         objectPosition[2] = 180.0;
	lui	$2,%hi($LC4)	 # tmp348,
	lwc1	$f0,%lo($LC4)($2)	 # tmp349,
	swc1	$f0,8($16)	 # tmp349, objectPosition
 # BattleBots/BattleBotAI.c:880:         MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
	sll	$2,$22,3	 # tmp354, i,
	subu	$2,$2,$22	 # tmp355, tmp354, i
	sll	$2,$2,4	 # tmp356, tmp355,
	subu	$2,$2,$22	 # tmp357, tmp356, i
	sll	$2,$2,2	 # tmp358, tmp357,
	subu	$2,$2,$22	 # tmp359, tmp358, i
	sll	$2,$2,3	 # tmp360, tmp359,
	addu	$18,$4,$2	 # tmp352, tmp351, tmp360
	lhu	$19,46($18)	 # _19, GlobalPlayer[i_85(D)].direction
 # BattleBots/BattleBotAI.c:880:         MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
	jal	MakeRandomLimmit	 #
	li	$4,2048			# 0x800	 #,

 # BattleBots/BattleBotAI.c:880:         MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
	addiu	$5,$19,-1024	 # tmp362, _19,
	addu	$5,$2,$5	 # tmp364, tmp706, tmp362
 # BattleBots/BattleBotAI.c:880:         MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
	sll	$5,$5,16	 #, tmp364,
	sra	$5,$5,16	 #,,
	jal	MakeAlignVector	 #
	move	$4,$16	 #, tmp345

 # BattleBots/BattleBotAI.c:881:         test_bot_sphere_position[i][0] = objectPosition[0] + GlobalPlayer[i].position[0];
	sll	$2,$22,1	 # tmp369, i,
	addu	$2,$2,$22	 # tmp370, tmp369, i
	sll	$2,$2,2	 # tmp371, tmp370,
	lui	$3,%hi(test_bot_sphere_position)	 # tmp367,
	addiu	$3,$3,%lo(test_bot_sphere_position)	 # tmp373, tmp367,
	addu	$2,$2,$3	 # tmp372, tmp371, tmp373
 # BattleBots/BattleBotAI.c:881:         test_bot_sphere_position[i][0] = objectPosition[0] + GlobalPlayer[i].position[0];
	lwc1	$f0,%lo(objectPosition)($17)	 # objectPosition, objectPosition
	lwc1	$f2,20($18)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	add.s	$f0,$f0,$f2	 # tmp386, objectPosition, GlobalPlayer[i_85(D)].position
 # BattleBots/BattleBotAI.c:881:         test_bot_sphere_position[i][0] = objectPosition[0] + GlobalPlayer[i].position[0];
	swc1	$f0,0($2)	 # tmp386, test_bot_sphere_position
 # BattleBots/BattleBotAI.c:882:         test_bot_sphere_position[i][1] = objectPosition[1] + GlobalPlayer[i].position[1];
	lwc1	$f0,4($16)	 # objectPosition, objectPosition
	lwc1	$f2,24($18)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	add.s	$f0,$f0,$f2	 # tmp409, objectPosition, GlobalPlayer[i_85(D)].position
 # BattleBots/BattleBotAI.c:882:         test_bot_sphere_position[i][1] = objectPosition[1] + GlobalPlayer[i].position[1];
	swc1	$f0,4($2)	 # tmp409, test_bot_sphere_position
 # BattleBots/BattleBotAI.c:883:         test_bot_sphere_position[i][2] = objectPosition[2] + GlobalPlayer[i].position[2];
	lwc1	$f0,8($16)	 # objectPosition, objectPosition
	lwc1	$f2,28($18)	 # GlobalPlayer[i_85(D)].position, GlobalPlayer[i_85(D)].position
	add.s	$f0,$f0,$f2	 # tmp432, objectPosition, GlobalPlayer[i_85(D)].position
	b	$L53	 #
	swc1	$f0,8($2)	 # tmp432, test_bot_sphere_position

$L57:
 # BattleBots/BattleBotAI.c:929:             bot_buttons[i] = BTN_A;
	sll	$2,$22,1	 # tmp679, i,
	lui	$3,%hi(bot_buttons)	 # tmp678,
	addiu	$3,$3,%lo(bot_buttons)	 # tmp681, tmp678,
	addu	$2,$2,$3	 # tmp680, tmp679, tmp681
	li	$3,-32768			# 0xffffffffffff8000	 # tmp682,
	sh	$3,0($2)	 # tmp682, bot_buttons
 # BattleBots/BattleBotAI.c:930:             bot_x_stick[i] = 0x00;
	lui	$2,%hi(bot_x_stick)	 # tmp683,
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp685, tmp683,
	addu	$22,$22,$2	 # tmp684, i, tmp685
 # BattleBots/BattleBotAI.c:932:             break;
	b	$L50	 #
	sb	$0,0($22)	 #, bot_x_stick

$L58:
 # BattleBots/BattleBotAI.c:934:             bot_buttons[i] = BTN_A;
	sll	$2,$22,1	 # tmp687, i,
	lui	$3,%hi(bot_buttons)	 # tmp686,
	addiu	$3,$3,%lo(bot_buttons)	 # tmp689, tmp686,
	addu	$2,$2,$3	 # tmp688, tmp687, tmp689
	li	$3,-32768			# 0xffffffffffff8000	 # tmp690,
	sh	$3,0($2)	 # tmp690, bot_buttons
 # BattleBots/BattleBotAI.c:935:             bot_x_stick[i] = 0x50;
	lui	$2,%hi(bot_x_stick)	 # tmp691,
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp693, tmp691,
	addu	$22,$22,$2	 # tmp692, i, tmp693
	li	$2,80			# 0x50	 # tmp694,
 # BattleBots/BattleBotAI.c:937:             break;
	b	$L50	 #
	sb	$2,0($22)	 # tmp694, bot_x_stick

$L66:
 # BattleBots/BattleBotAI.c:939:             bot_buttons[i] = BTN_A;
	lui	$3,%hi(bot_buttons)	 # tmp695,
	addiu	$3,$3,%lo(bot_buttons)	 # tmp698, tmp695,
	addu	$2,$2,$3	 # tmp697, tmp696, tmp698
	li	$3,-32768			# 0xffffffffffff8000	 # tmp699,
	sh	$3,0($2)	 # tmp699, bot_buttons
 # BattleBots/BattleBotAI.c:940:             bot_x_stick[i] = -0x50;
	lui	$2,%hi(bot_x_stick)	 # tmp700,
	addiu	$2,$2,%lo(bot_x_stick)	 # tmp702, tmp700,
	addu	$22,$22,$2	 # tmp701, i, tmp702
	li	$2,-80			# 0xffffffffffffffb0	 # tmp703,
 # BattleBots/BattleBotAI.c:944: }
	b	$L50	 #
	sb	$2,0($22)	 # tmp703, bot_x_stick

	.set	macro
	.set	reorder
	.end	RandomBattleBot
	.size	RandomBattleBot, .-RandomBattleBot
	.align	2
	.globl	getRival
	.set	nomips16
	.set	nomicromips
	.ent	getRival
	.type	getRival, @function
getRival:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, gp= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40	 #,,
	sw	$31,36($sp)	 #,
	sw	$20,32($sp)	 #,
	sw	$19,28($sp)	 #,
	sw	$18,24($sp)	 #,
	sw	$17,20($sp)	 #,
	sw	$16,16($sp)	 #,
 # BattleBots/BattleBotAI.c:1196:     if (game_mode==4 || (game_mode == 3 && ctf_game_mode == 0)) //If game mode is keep away or if 1 flag CTF
	lui	$2,%hi(game_mode)	 # tmp217,
	lb	$2,%lo(game_mode)($2)		 # game_mode.55_1, game_mode
 # BattleBots/BattleBotAI.c:1196:     if (game_mode==4 || (game_mode == 3 && ctf_game_mode == 0)) //If game mode is keep away or if 1 flag CTF
	li	$3,4			# 0x4	 # tmp218,
	beq	$2,$3,$L71	 #, game_mode.55_1, tmp218,
	move	$16,$4	 # currentPlayer, tmp278

 # BattleBots/BattleBotAI.c:1196:     if (game_mode==4 || (game_mode == 3 && ctf_game_mode == 0)) //If game mode is keep away or if 1 flag CTF
	li	$3,3			# 0x3	 # tmp219,
	beq	$2,$3,$L87	 #, game_mode.55_1, tmp219,
	lui	$2,%hi(ctf_game_mode)	 # tmp220,

 # BattleBots/BattleBotAI.c:1259:             if (ffa_or_teams == 0) //If FFA
	lui	$17,%hi(ffa_or_teams)	 # tmp248,
$L95:
 # BattleBots/BattleBotAI.c:1275:         }while(currentPlayer == enemy || GlobalPlayer[enemy].flag == 0xC0); //If returned rival is the current player or dead, reroll the dice until a living rival can be found
	lui	$18,%hi(GlobalPlayer)	 # tmp274,
	addiu	$18,$18,%lo(GlobalPlayer)	 # tmp275, tmp274,
 # BattleBots/BattleBotAI.c:1265:                 if (currentPlayer <= 1) //Team 1
	slt	$19,$16,2	 # tmp276, currentPlayer,
 # BattleBots/BattleBotAI.c:1261:                     enemy = MakeRandomLimmit(player_count); //Randomly grab a rival
	b	$L80	 #
	lui	$20,%hi(player_count)	 # tmp277,

$L87:
 # BattleBots/BattleBotAI.c:1196:     if (game_mode==4 || (game_mode == 3 && ctf_game_mode == 0)) //If game mode is keep away or if 1 flag CTF
	lb	$2,%lo(ctf_game_mode)($2)		 # ctf_game_mode.57_3, ctf_game_mode
 # BattleBots/BattleBotAI.c:1196:     if (game_mode==4 || (game_mode == 3 && ctf_game_mode == 0)) //If game mode is keep away or if 1 flag CTF
	bne	$2,$0,$L73	 #, ctf_game_mode.57_3,,
	li	$3,1			# 0x1	 # tmp232,

$L71:
 # BattleBots/BattleBotAI.c:1198:         flag_holder = playerHoldingFlag[0];
	lui	$2,%hi(playerHoldingFlag)	 # tmp221,
 # BattleBots/BattleBotAI.c:1199:         if (ffa_or_teams == 0) //If FFA
	lui	$3,%hi(ffa_or_teams)	 # tmp222,
 # BattleBots/BattleBotAI.c:1199:         if (ffa_or_teams == 0) //If FFA
	lb	$3,%lo(ffa_or_teams)($3)		 # ffa_or_teams, ffa_or_teams
	bne	$3,$0,$L74	 #, ffa_or_teams,,
	lw	$2,%lo(playerHoldingFlag)($2)		 # <retval>, playerHoldingFlag

 # BattleBots/BattleBotAI.c:1201:             if((flag_holder-1 != currentPlayer) && (flag_holder != -1))
	addiu	$3,$2,-1	 # tmp224, <retval>,
 # BattleBots/BattleBotAI.c:1201:             if((flag_holder-1 != currentPlayer) && (flag_holder != -1))
	beq	$3,$16,$L75	 #, tmp224, currentPlayer,
	li	$3,-1			# 0xffffffffffffffff	 # tmp225,

 # BattleBots/BattleBotAI.c:1201:             if((flag_holder-1 != currentPlayer) && (flag_holder != -1))
	bne	$2,$3,$L92	 #, <retval>, tmp225,
	lw	$31,36($sp)		 #,

$L75:
 # BattleBots/BattleBotAI.c:1281:     return(bot_rival_p1[currentPlayer]);
	lui	$4,%hi(bot_rival_p1)	 # tmp270,
$L93:
	addiu	$4,$4,%lo(bot_rival_p1)	 # tmp272, tmp270,
	addu	$16,$16,$4	 # tmp271, currentPlayer, tmp272
	lbu	$2,0($16)	 # <retval>, bot_rival_p1
 # BattleBots/BattleBotAI.c:1283: }
	lw	$31,36($sp)		 #,
$L92:
	lw	$20,32($sp)		 #,
	lw	$19,28($sp)		 #,
	lw	$18,24($sp)		 #,
	lw	$17,20($sp)		 #,
	lw	$16,16($sp)		 #,
	jr	$31	 #
	addiu	$sp,$sp,40	 #,,

$L74:
 # BattleBots/BattleBotAI.c:1209:             if ((currentPlayer==0 || currentPlayer==1) && (flag_holder==2 ||flag_holder==3)) //Team 1
	sltu	$3,$16,2	 # tmp226, currentPlayer,
	bne	$3,$0,$L88	 #, tmp226,,
	addiu	$3,$16,-2	 # tmp229, currentPlayer,

 # BattleBots/BattleBotAI.c:1213:             else if  ((currentPlayer==2 || currentPlayer==3) && (flag_holder==0 || flag_holder==1))//Team 2
	sltu	$3,$3,2	 # tmp230, tmp229,
	beq	$3,$0,$L75	 #, tmp230,,
	sltu	$3,$2,2	 # tmp231, <retval>,

 # BattleBots/BattleBotAI.c:1213:             else if  ((currentPlayer==2 || currentPlayer==3) && (flag_holder==0 || flag_holder==1))//Team 2
	beq	$3,$0,$L93	 #, tmp231,,
	lui	$4,%hi(bot_rival_p1)	 # tmp270,

 # BattleBots/BattleBotAI.c:1283: }
	b	$L92	 #
	lw	$31,36($sp)		 #,

$L88:
 # BattleBots/BattleBotAI.c:1209:             if ((currentPlayer==0 || currentPlayer==1) && (flag_holder==2 ||flag_holder==3)) //Team 1
	addiu	$3,$2,-2	 # tmp227, <retval>,
 # BattleBots/BattleBotAI.c:1209:             if ((currentPlayer==0 || currentPlayer==1) && (flag_holder==2 ||flag_holder==3)) //Team 1
	sltu	$3,$3,2	 # tmp228, tmp227,
	beq	$3,$0,$L93	 #, tmp228,,
	lui	$4,%hi(bot_rival_p1)	 # tmp270,

 # BattleBots/BattleBotAI.c:1283: }
	b	$L92	 #
	lw	$31,36($sp)		 #,

$L73:
 # BattleBots/BattleBotAI.c:1219:     else if (game_mode==3 && ctf_game_mode == 1) //If game mode is CTF multiflag
	bne	$2,$3,$L95	 #, ctf_game_mode.57_3, tmp232,
	lui	$17,%hi(ffa_or_teams)	 # tmp248,

 # BattleBots/BattleBotAI.c:1223:         if (ffa_or_teams == 0) //If FFA
	lui	$2,%hi(ffa_or_teams)	 # tmp233,
 # BattleBots/BattleBotAI.c:1223:         if (ffa_or_teams == 0) //If FFA
	lb	$2,%lo(ffa_or_teams)($2)		 # ffa_or_teams, ffa_or_teams
	bne	$2,$0,$L78	 #, ffa_or_teams,,
	sltu	$2,$4,2	 # tmp240, currentPlayer,

 # BattleBots/BattleBotAI.c:1225:             flag_holder = playerHoldingFlag[currentPlayer];
	sll	$2,$4,2	 # tmp236, currentPlayer,
	lui	$3,%hi(playerHoldingFlag)	 # tmp235,
	addiu	$3,$3,%lo(playerHoldingFlag)	 # tmp238, tmp235,
	addu	$2,$2,$3	 # tmp237, tmp236, tmp238
	lw	$2,0($2)		 # <retval>, playerHoldingFlag
 # BattleBots/BattleBotAI.c:1226:             if (flag_holder != -1)
	li	$3,-1			# 0xffffffffffffffff	 # tmp239,
	bne	$2,$3,$L92	 #, <retval>, tmp239,
	lw	$31,36($sp)		 #,

 # BattleBots/BattleBotAI.c:1281:     return(bot_rival_p1[currentPlayer]);
	b	$L93	 #
	lui	$4,%hi(bot_rival_p1)	 # tmp270,

$L78:
 # BattleBots/BattleBotAI.c:1233:             if (currentPlayer==0 || currentPlayer==1) //Team 1
	bne	$2,$0,$L89	 #, tmp240,,
	addiu	$2,$4,-2	 # tmp243, currentPlayer,

 # BattleBots/BattleBotAI.c:1241:             else if (currentPlayer==2 || currentPlayer==3) //Team 2
	sltu	$2,$2,2	 # tmp244, tmp243,
	beql	$2,$0,$L93	 #, tmp244,,
	lui	$4,%hi(bot_rival_p1)	 # tmp270,

 # BattleBots/BattleBotAI.c:1243:                 flag_holder = playerHoldingFlag[2];
	lui	$2,%hi(playerHoldingFlag+8)	 # tmp246,
	lw	$2,%lo(playerHoldingFlag+8)($2)		 # <retval>, playerHoldingFlag
 # BattleBots/BattleBotAI.c:1244:                 if (flag_holder != -1)
	li	$3,-1			# 0xffffffffffffffff	 # tmp247,
	bne	$2,$3,$L92	 #, <retval>, tmp247,
	lw	$31,36($sp)		 #,

 # BattleBots/BattleBotAI.c:1281:     return(bot_rival_p1[currentPlayer]);
	b	$L93	 #
	lui	$4,%hi(bot_rival_p1)	 # tmp270,

$L89:
 # BattleBots/BattleBotAI.c:1235:                 flag_holder = playerHoldingFlag[0];
	lui	$2,%hi(playerHoldingFlag)	 # tmp241,
	lw	$2,%lo(playerHoldingFlag)($2)		 # <retval>, playerHoldingFlag
 # BattleBots/BattleBotAI.c:1236:                 if (flag_holder != -1)
	li	$3,-1			# 0xffffffffffffffff	 # tmp242,
	bne	$2,$3,$L92	 #, <retval>, tmp242,
	lw	$31,36($sp)		 #,

 # BattleBots/BattleBotAI.c:1281:     return(bot_rival_p1[currentPlayer]);
	b	$L93	 #
	lui	$4,%hi(bot_rival_p1)	 # tmp270,

$L90:
 # BattleBots/BattleBotAI.c:1261:                     enemy = MakeRandomLimmit(player_count); //Randomly grab a rival
	jal	MakeRandomLimmit	 #
	andi	$4,$4,0xffff	 #, player_count

	b	$L82
	nop
	 #
$L91:
 # BattleBots/BattleBotAI.c:1267:                     enemy = MakeRandomLimmit(2)+2; //Return 2 or 3 (players 3 or 4 on oppositing team)
	jal	MakeRandomLimmit	 #
	li	$4,2			# 0x2	 #,

 # BattleBots/BattleBotAI.c:1267:                     enemy = MakeRandomLimmit(2)+2; //Return 2 or 3 (players 3 or 4 on oppositing team)
	addiu	$2,$2,2	 # <retval>, tmp280,
 # BattleBots/BattleBotAI.c:1275:         }while(currentPlayer == enemy || GlobalPlayer[enemy].flag == 0xC0); //If returned rival is the current player or dead, reroll the dice until a living rival can be found
	sll	$3,$2,3	 # tmp259, <retval>,
$L96:
	subu	$3,$3,$2	 # tmp260, tmp259, <retval>
	sll	$3,$3,4	 # tmp261, tmp260,
	subu	$3,$3,$2	 # tmp262, tmp261, <retval>
	sll	$3,$3,2	 # tmp263, tmp262,
	subu	$3,$3,$2	 # tmp264, tmp263, <retval>
	sll	$3,$3,3	 # tmp265, tmp264,
	addu	$3,$3,$18	 # tmp266, tmp265, tmp275
 # BattleBots/BattleBotAI.c:1275:         }while(currentPlayer == enemy || GlobalPlayer[enemy].flag == 0xC0); //If returned rival is the current player or dead, reroll the dice until a living rival can be found
	lhu	$4,0($3)	 # GlobalPlayer[enemy_47].flag, GlobalPlayer[enemy_47].flag
	li	$3,192			# 0xc0	 # tmp269,
	bne	$4,$3,$L92	 #, GlobalPlayer[enemy_47].flag, tmp269,
	lw	$31,36($sp)		 #,

$L80:
 # BattleBots/BattleBotAI.c:1259:             if (ffa_or_teams == 0) //If FFA
	lb	$2,%lo(ffa_or_teams)($17)		 # ffa_or_teams, ffa_or_teams
$L94:
	beq	$2,$0,$L90	 #, ffa_or_teams,,
	lb	$4,%lo(player_count)($20)		 # player_count, player_count

 # BattleBots/BattleBotAI.c:1265:                 if (currentPlayer <= 1) //Team 1
	bne	$19,$0,$L91
	nop
	 #, tmp276,,
 # BattleBots/BattleBotAI.c:1271:                     enemy = MakeRandomLimmit(2); //Return 0 or 1 (players 1 or 2 on oppositing team)
	jal	MakeRandomLimmit	 #
	li	$4,2			# 0x2	 #,

$L82:
 # BattleBots/BattleBotAI.c:1275:         }while(currentPlayer == enemy || GlobalPlayer[enemy].flag == 0xC0); //If returned rival is the current player or dead, reroll the dice until a living rival can be found
	bne	$2,$16,$L96	 #, <retval>, currentPlayer,
	sll	$3,$2,3	 # tmp259, <retval>,

	b	$L94	 #
	lb	$2,%lo(ffa_or_teams)($17)		 # ffa_or_teams, ffa_or_teams

	.set	macro
	.set	reorder
	.end	getRival
	.size	getRival, .-getRival
	.align	2
	.globl	ResetPathfinderBots
	.set	nomips16
	.set	nomicromips
	.ent	ResetPathfinderBots
	.type	ResetPathfinderBots, @function
ResetPathfinderBots:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, gp= 0
	.mask	0x803f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48	 #,,
	sw	$31,44($sp)	 #,
	sw	$21,40($sp)	 #,
	sw	$20,36($sp)	 #,
	sw	$19,32($sp)	 #,
	sw	$18,28($sp)	 #,
	sw	$17,24($sp)	 #,
	sw	$16,20($sp)	 #,
	lui	$19,%hi(bot_rival_p1)	 # tmp203,
	addiu	$19,$19,%lo(bot_rival_p1)	 # ivtmp.101, tmp203,
	lui	$18,%hi(AIPathfinder)	 # tmp204,
	addiu	$18,$18,%lo(AIPathfinder)	 # ivtmp.102, tmp204,
	lui	$16,%hi(nearest_item_box)	 # tmp205,
	addiu	$16,$16,%lo(nearest_item_box)	 # ivtmp.103, tmp205,
 # BattleBots/BattleBotAI.c:50:     for (int i=0; i<4; i++)
	move	$17,$0	 # i,
 # BattleBots/BattleBotAI.c:53:         AIPathfinder[i].TargetPath = -1;
	li	$21,-1			# 0xffffffffffffffff	 # tmp206,
 # BattleBots/BattleBotAI.c:50:     for (int i=0; i<4; i++)
	li	$20,4			# 0x4	 # tmp207,
$L98:
 # BattleBots/BattleBotAI.c:52:         bot_rival_p1[i] = getRival(i);
	jal	getRival	 #
	move	$4,$17	 #, i

 # BattleBots/BattleBotAI.c:52:         bot_rival_p1[i] = getRival(i);
	sb	$2,0($19)	 # tmp208, MEM[base: _28, offset: 0B]
 # BattleBots/BattleBotAI.c:53:         AIPathfinder[i].TargetPath = -1;
	sh	$21,0($18)	 # tmp206, MEM[base: _29, offset: 0B]
 # BattleBots/BattleBotAI.c:57:             nearest_item_box[i][j] = 0.0;
	sw	$0,0($16)	 #, MEM[base: _19, offset: 0B]
	sw	$0,4($16)	 #, MEM[base: _19, offset: 4B]
	sw	$0,8($16)	 #, MEM[base: _19, offset: 8B]
 # BattleBots/BattleBotAI.c:50:     for (int i=0; i<4; i++)
	addiu	$17,$17,1	 # i, i,
 # BattleBots/BattleBotAI.c:50:     for (int i=0; i<4; i++)
	addiu	$19,$19,1	 # ivtmp.101, ivtmp.101,
	addiu	$18,$18,32	 # ivtmp.102, ivtmp.102,
	bne	$17,$20,$L98	 #, i, tmp207,
	addiu	$16,$16,12	 # ivtmp.103, ivtmp.103,

 # BattleBots/BattleBotAI.c:60: }
	lw	$31,44($sp)		 #,
	lw	$21,40($sp)		 #,
	lw	$20,36($sp)		 #,
	lw	$19,32($sp)		 #,
	lw	$18,28($sp)		 #,
	lw	$17,24($sp)		 #,
	lw	$16,20($sp)		 #,
	jr	$31	 #
	addiu	$sp,$sp,48	 #,,

	.set	macro
	.set	reorder
	.end	ResetPathfinderBots
	.size	ResetPathfinderBots, .-ResetPathfinderBots
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC17:
	.ascii	"Target[0]\000"
	.align	2
$LC18:
	.ascii	"Target[1]\000"
	.align	2
$LC19:
	.ascii	"Target[2]\000"
	.align	2
$LC20:
	.ascii	"Progression\000"
	.align	2
$LC21:
	.ascii	"Nearest\000"
	.align	2
$LC22:
	.ascii	"Direction\000"
	.align	2
$LC23:
	.ascii	"PathType\000"
	.align	2
$LC24:
	.ascii	"TargetPath\000"
	.align	2
$LC25:
	.ascii	"ixbox x\000"
	.align	2
$LC26:
	.ascii	"ixbox y\000"
	.align	2
$LC27:
	.ascii	"ixbox z\000"
	.align	2
$LC28:
	.ascii	"ixbox count\000"
	.align	2
$LC29:
	.ascii	"bot x\000"
	.align	2
$LC30:
	.ascii	"bot y\000"
	.align	2
$LC31:
	.ascii	"bot z\000"
	.align	2
$LC32:
	.ascii	"Rival\000"
	.text
	.align	2
	.globl	SeekerBattleBot
	.set	nomips16
	.set	nomicromips
	.ent	SeekerBattleBot
	.type	SeekerBattleBot, @function
SeekerBattleBot:
	.frame	$sp,144,$31		# vars= 24, regs= 10/12, args= 32, gp= 0
	.mask	0xc0ff0000,-52
	.fmask	0xfff00000,-8
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-144	 #,,
	sw	$31,92($sp)	 #,
	sw	$fp,88($sp)	 #,
	sw	$23,84($sp)	 #,
	sw	$22,80($sp)	 #,
	sw	$21,76($sp)	 #,
	sw	$20,72($sp)	 #,
	sw	$19,68($sp)	 #,
	sw	$18,64($sp)	 #,
	sw	$17,60($sp)	 #,
	sw	$16,56($sp)	 #,
	sdc1	$f30,136($sp)	 #,
	sdc1	$f28,128($sp)	 #,
	sdc1	$f26,120($sp)	 #,
	sdc1	$f24,112($sp)	 #,
	sdc1	$f22,104($sp)	 #,
	sdc1	$f20,96($sp)	 #,
	move	$16,$4	 # i, tmp2218
 # BattleBots/BattleBotAI.c:300:     short ci = BattleLevelConverts[g_courseID]; //Grab index for current course, used to index path arrays
	lui	$2,%hi(g_courseID)	 # tmp686,
	lh	$2,%lo(g_courseID)($2)		 # g_courseID, g_courseID
	lui	$3,%hi(BattleLevelConverts)	 # tmp685,
	addiu	$3,$3,%lo(BattleLevelConverts)	 # tmp689, tmp685,
	addu	$2,$2,$3	 # tmp688, g_courseID, tmp689
	lb	$17,0($2)		 # _3, BattleLevelConverts
 # BattleBots/BattleBotAI.c:303:     float bot_x = GlobalPlayer[i].position[0]; //x,y,z coordinates of current bot
	lui	$3,%hi(GlobalPlayer)	 # tmp690,
	sll	$2,$4,3	 # tmp694, i,
	subu	$2,$2,$4	 # tmp695, tmp694, i
	sll	$2,$2,4	 # tmp696, tmp695,
	subu	$2,$2,$4	 # tmp697, tmp696, i
	sll	$2,$2,2	 # tmp698, tmp697,
	subu	$2,$2,$4	 # tmp699, tmp698, i
	sll	$2,$2,3	 # tmp700, tmp699,
	addiu	$3,$3,%lo(GlobalPlayer)	 # tmp691, tmp690,
	addu	$2,$3,$2	 # tmp692, tmp691, tmp700
	lwc1	$f26,20($2)	 # bot_x, GlobalPlayer[i_533(D)].position
 # BattleBots/BattleBotAI.c:304:     float bot_y = GlobalPlayer[i].position[1];
	lwc1	$f22,24($2)	 # bot_y, GlobalPlayer[i_533(D)].position
 # BattleBots/BattleBotAI.c:308:     if (!checkItems(i) && !(GlobalPlayer[i].slip_flag & STAR))
	jal	checkItems	 #
	lwc1	$f24,28($2)	 # bot_z, GlobalPlayer[i_533(D)].position

 # BattleBots/BattleBotAI.c:308:     if (!checkItems(i) && !(GlobalPlayer[i].slip_flag & STAR))
	bne	$2,$0,$L204	 #, tmp2219,,
	lui	$2,%hi(bot_rival_p1)	 # tmp845,

 # BattleBots/BattleBotAI.c:308:     if (!checkItems(i) && !(GlobalPlayer[i].slip_flag & STAR))
	lui	$3,%hi(GlobalPlayer)	 # tmp724,
	sll	$2,$16,3	 # tmp728, i,
	subu	$2,$2,$16	 # tmp729, tmp728, i
	sll	$2,$2,4	 # tmp730, tmp729,
	subu	$2,$2,$16	 # tmp731, tmp730, i
	sll	$2,$2,2	 # tmp732, tmp731,
	subu	$2,$2,$16	 # tmp733, tmp732, i
	sll	$2,$2,3	 # tmp734, tmp733,
	addiu	$3,$3,%lo(GlobalPlayer)	 # tmp725, tmp724,
	addu	$2,$3,$2	 # tmp726, tmp725, tmp734
 # BattleBots/BattleBotAI.c:308:     if (!checkItems(i) && !(GlobalPlayer[i].slip_flag & STAR))
	lw	$2,188($2)		 # GlobalPlayer[i_533(D)].slip_flag, GlobalPlayer[i_533(D)].slip_flag
	andi	$2,$2,0x200	 # tmp735, GlobalPlayer[i_533(D)].slip_flag,
 # BattleBots/BattleBotAI.c:308:     if (!checkItems(i) && !(GlobalPlayer[i].slip_flag & STAR))
	bne	$2,$0,$L102	 #, tmp735,,
	lui	$2,%hi(bot_rival_p1)	 # tmp845,

 # BattleBots/BattleBotAI.c:312:         if (nearest_item_box[i][0] == 0.0)
	sll	$2,$16,1	 # tmp739, i,
	addu	$2,$2,$16	 # tmp740, tmp739, i
	sll	$2,$2,2	 # tmp741, tmp740,
	lui	$3,%hi(nearest_item_box)	 # tmp737,
	addiu	$3,$3,%lo(nearest_item_box)	 # tmp743, tmp737,
	addu	$2,$2,$3	 # tmp742, tmp741, tmp743
	lwc1	$f28,0($2)	 # rival_x, nearest_item_box
 # BattleBots/BattleBotAI.c:312:         if (nearest_item_box[i][0] == 0.0)
	mtc1	$0,$f0	 #, tmp744
	nop	
	c.eq.s	$f28,$f0	 #, rival_x, tmp744
	nop	
	bc1t	$L191	 #,,
	sll	$2,$16,1	 # tmp834, i,

 # BattleBots/BattleBotAI.c:334:             rival_y = nearest_item_box[i][1];
	addu	$2,$2,$16	 # tmp835, tmp834, i
	sll	$2,$2,2	 # tmp836, tmp835,
	lui	$3,%hi(nearest_item_box)	 # tmp831,
	addiu	$3,$3,%lo(nearest_item_box)	 # tmp837, tmp831,
	addu	$2,$2,$3	 # tmp832, tmp836, tmp837
	lwc1	$f20,4($2)	 # rival_y, nearest_item_box
 # BattleBots/BattleBotAI.c:335:             rival_z = nearest_item_box[i][2];   
	lwc1	$f30,8($2)	 # rival_z, nearest_item_box
 # BattleBots/BattleBotAI.c:299:     float turn_towards_rival_radius = 60.0; //Distance bot must get to rival to just start turning twoards them wholesale
	lui	$2,%hi($LC11)	 # tmp678,
	b	$L105	 #
	lw	$fp,%lo($LC11)($2)		 # turn_towards_rival_radius,

$L191:
 # BattleBots/BattleBotAI.c:315:             if (FindNearestItemBox(GlobalPlayer[i].position, nearest_item_box[i]) != -1) //If an item box is found on the same level, target that
	sll	$3,$16,1	 # tmp746, i,
	addu	$3,$3,$16	 # tmp747, tmp746, i
	sll	$3,$3,2	 # tmp748, tmp747,
 # BattleBots/BattleBotAI.c:315:             if (FindNearestItemBox(GlobalPlayer[i].position, nearest_item_box[i]) != -1) //If an item box is found on the same level, target that
	sll	$2,$16,3	 # tmp753, i,
	subu	$2,$2,$16	 # tmp754, tmp753, i
	sll	$2,$2,4	 # tmp755, tmp754,
	subu	$2,$2,$16	 # tmp756, tmp755, i
	sll	$2,$2,2	 # tmp757, tmp756,
	subu	$2,$2,$16	 # tmp758, tmp757, i
	sll	$2,$2,3	 # tmp759, tmp758,
	addiu	$2,$2,20	 # tmp760, tmp759,
 # BattleBots/BattleBotAI.c:315:             if (FindNearestItemBox(GlobalPlayer[i].position, nearest_item_box[i]) != -1) //If an item box is found on the same level, target that
	lui	$5,%hi(nearest_item_box)	 # tmp750,
	addiu	$5,$5,%lo(nearest_item_box)	 # tmp749, tmp750,
	addu	$5,$5,$3	 #, tmp749, tmp748
	lui	$4,%hi(GlobalPlayer)	 # tmp762,
	addiu	$4,$4,%lo(GlobalPlayer)	 # tmp761, tmp762,
	jal	FindNearestItemBox	 #
	addu	$4,$4,$2	 #, tmp761, tmp760

 # BattleBots/BattleBotAI.c:315:             if (FindNearestItemBox(GlobalPlayer[i].position, nearest_item_box[i]) != -1) //If an item box is found on the same level, target that
	li	$3,-1			# 0xffffffffffffffff	 # tmp764,
	bne	$2,$3,$L192	 #, tmp2220, tmp764,
	lui	$2,%hi(bot_rival_p1)	 # tmp795,

 # BattleBots/BattleBotAI.c:326:                 rival_x = GlobalPlayer[bot_rival_p1[i]].position[0]; //x,y,z coords of rival
	addiu	$2,$2,%lo(bot_rival_p1)	 # tmp797, tmp795,
	addu	$2,$16,$2	 # tmp796, i, tmp797
	lbu	$4,0($2)	 # _17, bot_rival_p1
 # BattleBots/BattleBotAI.c:326:                 rival_x = GlobalPlayer[bot_rival_p1[i]].position[0]; //x,y,z coords of rival
	lui	$5,%hi(GlobalPlayer)	 # tmp798,
	addiu	$5,$5,%lo(GlobalPlayer)	 # tmp799, tmp798,
	sll	$2,$4,3	 # tmp802, _17,
	subu	$3,$2,$4	 # tmp803, tmp802, _17
	sll	$3,$3,4	 # tmp804, tmp803,
	subu	$3,$3,$4	 # tmp805, tmp804, _17
	sll	$3,$3,2	 # tmp806, tmp805,
	subu	$3,$3,$4	 # tmp807, tmp806, _17
	sll	$3,$3,3	 # tmp808, tmp807,
	addu	$3,$5,$3	 # tmp800, tmp799, tmp808
	lwc1	$f28,20($3)	 # rival_x, GlobalPlayer[_17].position
 # BattleBots/BattleBotAI.c:327:                 rival_y = GlobalPlayer[bot_rival_p1[i]].position[1];
	lwc1	$f20,24($3)	 # rival_y, GlobalPlayer[_17].position
 # BattleBots/BattleBotAI.c:328:                 rival_z = GlobalPlayer[bot_rival_p1[i]].position[2];    
	lwc1	$f30,28($3)	 # rival_z, GlobalPlayer[_17].position
 # BattleBots/BattleBotAI.c:299:     float turn_towards_rival_radius = 60.0; //Distance bot must get to rival to just start turning twoards them wholesale
	lui	$2,%hi($LC11)	 # tmp680,
	b	$L105	 #
	lw	$fp,%lo($LC11)($2)		 # turn_towards_rival_radius,

$L192:
 # BattleBots/BattleBotAI.c:317:                 rival_x = nearest_item_box[i][0]; //x,y,z coords of rival
	sll	$2,$16,1	 # tmp767, i,
	addu	$2,$2,$16	 # tmp768, tmp767, i
	sll	$2,$2,2	 # tmp769, tmp768,
	lui	$3,%hi(nearest_item_box)	 # tmp765,
	addiu	$3,$3,%lo(nearest_item_box)	 # tmp771, tmp765,
	addu	$2,$2,$3	 # tmp770, tmp769, tmp771
	lwc1	$f28,0($2)	 # rival_x, nearest_item_box
 # BattleBots/BattleBotAI.c:318:                 rival_y = nearest_item_box[i][1];
	lwc1	$f20,4($2)	 # rival_y, nearest_item_box
 # BattleBots/BattleBotAI.c:319:                 rival_z = nearest_item_box[i][2];   
	lwc1	$f30,8($2)	 # rival_z, nearest_item_box
 # BattleBots/BattleBotAI.c:321:                 bot_rival_p1[i] = getRival(i); //Grab a new rival
	jal	getRival	 #
	move	$4,$16	 #, i

 # BattleBots/BattleBotAI.c:321:                 bot_rival_p1[i] = getRival(i); //Grab a new rival
	lui	$3,%hi(bot_rival_p1)	 # tmp786,
	addiu	$3,$3,%lo(bot_rival_p1)	 # tmp788, tmp786,
	addu	$3,$16,$3	 # tmp787, i, tmp788
	sb	$2,0($3)	 # tmp2221, bot_rival_p1
 # BattleBots/BattleBotAI.c:322:                 bot_timer_p1[i] = MakeRandomLimmit(1200) +  3000; //Reset bot timer 50-70 seconds. (600 = 10 seconds)
	jal	MakeRandomLimmit	 #
	li	$4,1200			# 0x4b0	 #,

 # BattleBots/BattleBotAI.c:322:                 bot_timer_p1[i] = MakeRandomLimmit(1200) +  3000; //Reset bot timer 50-70 seconds. (600 = 10 seconds)
	sll	$3,$16,2	 # tmp791, i,
	lui	$4,%hi(bot_timer_p1)	 # tmp790,
	addiu	$4,$4,%lo(bot_timer_p1)	 # tmp793, tmp790,
	addu	$3,$3,$4	 # tmp792, tmp791, tmp793
 # BattleBots/BattleBotAI.c:322:                 bot_timer_p1[i] = MakeRandomLimmit(1200) +  3000; //Reset bot timer 50-70 seconds. (600 = 10 seconds)
	addiu	$2,$2,3000	 # tmp794, tmp2222,
 # BattleBots/BattleBotAI.c:322:                 bot_timer_p1[i] = MakeRandomLimmit(1200) +  3000; //Reset bot timer 50-70 seconds. (600 = 10 seconds)
	sw	$2,0($3)	 # tmp794, bot_timer_p1
 # BattleBots/BattleBotAI.c:320:                 turn_towards_rival_radius = 70;     
	lui	$2,%hi($LC7)	 # tmp681,
	b	$L105	 #
	lw	$fp,%lo($LC7)($2)		 # turn_towards_rival_radius,

$L102:
$L204:
 # BattleBots/BattleBotAI.c:341:         rival_x = GlobalPlayer[bot_rival_p1[i]].position[0]; //x,y,z coords of rival
	addiu	$2,$2,%lo(bot_rival_p1)	 # tmp847, tmp845,
	addu	$2,$16,$2	 # tmp846, i, tmp847
	lbu	$4,0($2)	 # _19, bot_rival_p1
 # BattleBots/BattleBotAI.c:341:         rival_x = GlobalPlayer[bot_rival_p1[i]].position[0]; //x,y,z coords of rival
	lui	$5,%hi(GlobalPlayer)	 # tmp848,
	addiu	$5,$5,%lo(GlobalPlayer)	 # tmp849, tmp848,
	sll	$2,$4,3	 # tmp852, _19,
	subu	$3,$2,$4	 # tmp853, tmp852, _19
	sll	$3,$3,4	 # tmp854, tmp853,
	subu	$3,$3,$4	 # tmp855, tmp854, _19
	sll	$3,$3,2	 # tmp856, tmp855,
	subu	$3,$3,$4	 # tmp857, tmp856, _19
	sll	$3,$3,3	 # tmp858, tmp857,
	addu	$3,$5,$3	 # tmp850, tmp849, tmp858
	lwc1	$f28,20($3)	 # rival_x, GlobalPlayer[_19].position
 # BattleBots/BattleBotAI.c:342:         rival_y = GlobalPlayer[bot_rival_p1[i]].position[1];
	lwc1	$f20,24($3)	 # rival_y, GlobalPlayer[_19].position
 # BattleBots/BattleBotAI.c:343:         rival_z = GlobalPlayer[bot_rival_p1[i]].position[2];        
	lwc1	$f30,28($3)	 # rival_z, GlobalPlayer[_19].position
 # BattleBots/BattleBotAI.c:299:     float turn_towards_rival_radius = 60.0; //Distance bot must get to rival to just start turning twoards them wholesale
	lui	$2,%hi($LC11)	 # tmp679,
	lw	$fp,%lo($LC11)($2)		 # turn_towards_rival_radius,
$L105:
	sll	$18,$16,5	 # _654, i,
 # BattleBots/BattleBotAI.c:377:     if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
	lui	$19,%hi(AIPathfinder)	 # tmp882,
	addiu	$19,$19,%lo(AIPathfinder)	 # tmp881, tmp882,
	addu	$19,$19,$18	 # _20, tmp881, _654
	sll	$2,$17,2	 # tmp884, _3,
	lui	$4,%hi(CourseDropLengths)	 # tmp883,
	addiu	$4,$4,%lo(CourseDropLengths)	 # tmp886, tmp883,
	addu	$4,$2,$4	 # tmp885, tmp884, tmp886
	lui	$3,%hi(CourseRampLengths)	 # tmp888,
	addiu	$3,$3,%lo(CourseRampLengths)	 # tmp891, tmp888,
	addu	$3,$2,$3	 # tmp890, tmp884, tmp891
	lui	$5,%hi(CoursePathLengths)	 # tmp893,
	addiu	$5,$5,%lo(CoursePathLengths)	 # tmp896, tmp893,
	addu	$2,$2,$5	 # tmp895, tmp884, tmp896
	lw	$7,0($4)		 #, CourseDropLengths
	lw	$6,0($3)		 #, CourseRampLengths
	lw	$5,0($2)		 #, CoursePathLengths
	jal	PathfinderComplete	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:377:     if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
	bnel	$2,$0,$L193	 #, tmp2223,,
	swc1	$f28,8($19)	 # rival_x, AIPathfinder[i_533(D)].Target

 # BattleBots/BattleBotAI.c:398:     short TargetPath = AIPathfinder[i].TargetPath;
	sll	$2,$16,5	 # tmp929, i,
$L200:
	lui	$3,%hi(AIPathfinder)	 # tmp928,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp931, tmp928,
	addu	$2,$2,$3	 # tmp930, tmp929, tmp931
	lh	$20,0($2)		 # TargetPath, AIPathfinder[i_533(D)].TargetPath
 # BattleBots/BattleBotAI.c:400:     if (TargetPath != -1) //Check if Bot has fallen
	li	$2,-1			# 0xffffffffffffffff	 # tmp932,
	beq	$20,$2,$L107	 #, TargetPath, tmp932,
	lui	$3,%hi(AIPathfinder)	 # tmp933,

 # BattleBots/BattleBotAI.c:402:         switch (AIPathfinder[i].PathType)
	sll	$2,$16,5	 # tmp936, i,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp934, tmp933,
	addu	$2,$3,$2	 # tmp935, tmp934, tmp936
	lb	$2,31($2)		 # _31, AIPathfinder[i_533(D)].PathType
 # BattleBots/BattleBotAI.c:402:         switch (AIPathfinder[i].PathType)
	li	$3,1			# 0x1	 # tmp937,
	beq	$2,$3,$L108	 #, _31, tmp937,
	li	$3,2			# 0x2	 # tmp938,

	beql	$2,$3,$L109	 #, _31, tmp938,
	li	$2,-2140143616			# 0xffffffff80700000	 # tmp1152,

	beq	$2,$0,$L194	 #, _31,,
	sll	$2,$17,2	 # tmp940, _3,

$L107:
 # BattleBots/BattleBotAI.c:537:     if (i == 1)
	li	$2,1			# 0x1	 # tmp1275,
$L208:
	beq	$16,$2,$L195
	nop
	 #, i, tmp1275,
 # BattleBots/BattleBotAI.c:567:     if (TargetPath != -1) //If bot has NOT fallen
	li	$2,-1			# 0xffffffffffffffff	 # tmp1341,
$L201:
	beq	$20,$2,$L132	 #, TargetPath, tmp1341,
	lui	$3,%hi($LC33)	 # tmp1343,

 # BattleBots/BattleBotAI.c:575:         GlobalFloatA = 1600.0;
	lui	$2,%hi(GlobalFloatA)	 # tmp1342,
	lwc1	$f0,%lo($LC33)($3)	 # tmp1344,
	swc1	$f0,%lo(GlobalFloatA)($2)	 # tmp1344, GlobalFloatA
 # BattleBots/BattleBotAI.c:576:         if (AIPathfinder[i].Direction > 0)
	lui	$3,%hi(AIPathfinder)	 # tmp1345,
	sll	$2,$16,5	 # tmp1348, i,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp1346, tmp1345,
	addu	$2,$3,$2	 # tmp1347, tmp1346, tmp1348
	lb	$3,30($2)		 # _238, AIPathfinder[i_533(D)].Direction
 # BattleBots/BattleBotAI.c:576:         if (AIPathfinder[i].Direction > 0)
	blez	$3,$L133	 #, _238,
	lui	$4,%hi(AIPathfinder)	 # tmp1349,

 # BattleBots/BattleBotAI.c:578:             if (AIPathfinder[i].Progression > 4)
	sll	$2,$16,5	 # tmp1352, i,
	addiu	$4,$4,%lo(AIPathfinder)	 # tmp1350, tmp1349,
	addu	$2,$4,$2	 # tmp1351, tmp1350, tmp1352
 # BattleBots/BattleBotAI.c:578:             if (AIPathfinder[i].Progression > 4)
	lh	$2,20($2)		 # AIPathfinder[i_533(D)].Progression, AIPathfinder[i_533(D)].Progression
	slt	$2,$2,5	 # tmp1354, AIPathfinder[i_533(D)].Progression,
	bne	$2,$0,$L205	 #, tmp1354,,
	lui	$4,%hi(AIPathfinder)	 # tmp1376,

 # BattleBots/BattleBotAI.c:580:                 GlobalFloatA = 3200.0;
	lui	$4,%hi($LC34)	 # tmp1356,
	lui	$2,%hi(GlobalFloatA)	 # tmp1355,
	lwc1	$f0,%lo($LC34)($4)	 # tmp1357,
	swc1	$f0,%lo(GlobalFloatA)($2)	 # tmp1357, GlobalFloatA
$L134:
 # BattleBots/BattleBotAI.c:591:         short Progression = AIPathfinder[i].Progression;
	lui	$4,%hi(AIPathfinder)	 # tmp1376,
$L205:
	sll	$2,$16,5	 # tmp1379, i,
	addiu	$4,$4,%lo(AIPathfinder)	 # tmp1377, tmp1376,
	addu	$2,$4,$2	 # tmp1378, tmp1377, tmp1379
	lh	$4,20($2)		 # Progression, AIPathfinder[i_533(D)].Progression
 # BattleBots/BattleBotAI.c:592:         switch (AIPathfinder[i].PathType) //Get position of current marker to drive towards
	lb	$2,31($2)		 # _249, AIPathfinder[i_533(D)].PathType
 # BattleBots/BattleBotAI.c:592:         switch (AIPathfinder[i].PathType) //Get position of current marker to drive towards
	li	$5,1			# 0x1	 # tmp1384,
	beq	$2,$5,$L135	 #, _249, tmp1384,
	li	$5,2			# 0x2	 # tmp1385,

	beq	$2,$5,$L136	 #, _249, tmp1385,
	sll	$5,$17,2	 # tmp1451, _3,

	beq	$2,$0,$L196	 #, _249,,
	lui	$6,%hi(CoursePaths)	 # tmp1386,

$L137:
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	lui	$5,%hi(objectPosition)	 # tmp1482,
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	lwc1	$f0,%lo(objectPosition)($5)	 # objectPosition, objectPosition
	sub.s	$f0,$f26,$f0	 # tmp1483, bot_x, objectPosition
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	cvt.d.s	$f0,$f0	 # _321, tmp1483
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	addiu	$5,$5,%lo(objectPosition)	 # tmp1486, tmp1482,
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	lwc1	$f4,4($5)	 # objectPosition, objectPosition
	sub.s	$f4,$f22,$f4	 # tmp1487, bot_y, objectPosition
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	cvt.d.s	$f4,$f4	 # _325, tmp1487
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	lwc1	$f2,8($5)	 # objectPosition, objectPosition
	sub.s	$f2,$f24,$f2	 # tmp1491, bot_z, objectPosition
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	cvt.d.s	$f2,$f2	 # _330, tmp1491
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	mul.d	$f0,$f0,$f0	 # tmp1493, _321, _321
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	mul.d	$f4,$f4,$f4	 # tmp1494, _325, _325
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	add.d	$f0,$f0,$f4	 # tmp1495, tmp1493, tmp1494
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	mul.d	$f2,$f2,$f2	 # tmp1496, _330, _330
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	add.d	$f0,$f0,$f2	 # tmp1497, tmp1495, tmp1496
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	lui	$5,%hi(GlobalFloatA)	 # tmp1498,
	lwc1	$f2,%lo(GlobalFloatA)($5)	 # GlobalFloatA, GlobalFloatA
	cvt.d.s	$f2,$f2	 # tmp1499, GlobalFloatA
 # BattleBots/BattleBotAI.c:615:         if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
	c.lt.d	$f0,$f2	 #, tmp1497, tmp1499
	nop	
	bc1f	$L185	 #,,
	lui	$5,%hi(AIPathfinder)	 # tmp1512,

 # BattleBots/BattleBotAI.c:617:             AIPathfinder[i].Progression += AIPathfinder[i].Direction;
	lui	$6,%hi(AIPathfinder)	 # tmp1501,
	sll	$5,$16,5	 # tmp1504, i,
	addiu	$6,$6,%lo(AIPathfinder)	 # tmp1502, tmp1501,
	addu	$5,$6,$5	 # tmp1503, tmp1502, tmp1504
	addu	$4,$4,$3	 # tmp1507, Progression, _238
	sh	$4,20($5)	 # tmp1507, AIPathfinder[i_533(D)].Progression
 # BattleBots/BattleBotAI.c:618:             AIPathfinder[i].ProgressTimer = 0;
	sh	$0,28($5)	 #, AIPathfinder[i_533(D)].ProgressTimer
$L140:
 # BattleBots/BattleBotAI.c:625:         if (AIPathfinder[i].Progression > GlobalIntA)
	lui	$4,%hi(GlobalIntA)	 # tmp1522,
	lw	$6,%lo(GlobalIntA)($4)		 # GlobalIntA.41_347, GlobalIntA
 # BattleBots/BattleBotAI.c:625:         if (AIPathfinder[i].Progression > GlobalIntA)
	lui	$5,%hi(AIPathfinder)	 # tmp1523,
	sll	$4,$16,5	 # tmp1526, i,
	addiu	$5,$5,%lo(AIPathfinder)	 # tmp1524, tmp1523,
	addu	$4,$5,$4	 # tmp1525, tmp1524, tmp1526
	lh	$4,20($4)		 # AIPathfinder[i_533(D)].Progression, AIPathfinder[i_533(D)].Progression
 # BattleBots/BattleBotAI.c:625:         if (AIPathfinder[i].Progression > GlobalIntA)
	slt	$4,$6,$4	 # tmp1528, GlobalIntA.41_347, AIPathfinder[i_533(D)].Progression
	beq	$4,$0,$L141	 #, tmp1528,,
	lui	$5,%hi(AIPathfinder)	 # tmp1529,

 # BattleBots/BattleBotAI.c:627:             AIPathfinder[i].Progression = GlobalIntA;
	sll	$4,$16,5	 # tmp1532, i,
	addiu	$5,$5,%lo(AIPathfinder)	 # tmp1530, tmp1529,
	addu	$4,$5,$4	 # tmp1531, tmp1530, tmp1532
	sh	$6,20($4)	 # GlobalIntA.41_347, AIPathfinder[i_533(D)].Progression
$L141:
 # BattleBots/BattleBotAI.c:633:         if (AIPathfinder[i].Direction > 0)
	blez	$3,$L142	 #, _238,
	lui	$4,%hi(AIPathfinder)	 # tmp1533,

 # BattleBots/BattleBotAI.c:635:             if (AIPathfinder[i].NearestMarker > AIPathfinder[i].Progression)
	sll	$3,$16,5	 # tmp1536, i,
	addiu	$4,$4,%lo(AIPathfinder)	 # tmp1534, tmp1533,
	addu	$3,$4,$3	 # tmp1535, tmp1534, tmp1536
	lh	$5,22($3)		 # _350, AIPathfinder[i_533(D)].NearestMarker
 # BattleBots/BattleBotAI.c:635:             if (AIPathfinder[i].NearestMarker > AIPathfinder[i].Progression)
	lh	$3,20($3)		 # AIPathfinder[i_533(D)].Progression, AIPathfinder[i_533(D)].Progression
	slt	$3,$3,$5	 # tmp1542, AIPathfinder[i_533(D)].Progression, _350
	beq	$3,$0,$L206	 #, tmp1542,,
	li	$3,1			# 0x1	 # tmp1582,

 # BattleBots/BattleBotAI.c:637:                 AIPathfinder[i].Progression = AIPathfinder[i].NearestMarker;
	lui	$4,%hi(AIPathfinder)	 # tmp1543,
	sll	$3,$16,5	 # tmp1546, i,
	addiu	$4,$4,%lo(AIPathfinder)	 # tmp1544, tmp1543,
	addu	$3,$4,$3	 # tmp1545, tmp1544, tmp1546
	sh	$5,20($3)	 # _350, AIPathfinder[i_533(D)].Progression
$L143:
 # BattleBots/BattleBotAI.c:663:     switch (AIPathfinder[i].PathType)
	li	$3,1			# 0x1	 # tmp1582,
$L206:
	beq	$2,$3,$L145	 #, _249, tmp1582,
	li	$3,2			# 0x2	 # tmp1583,

	beql	$2,$3,$L146	 #, _249, tmp1583,
	sll	$2,$17,2	 # tmp2065, _3,

	beq	$2,$0,$L197	 #, _249,,
	sll	$2,$17,2	 # tmp1585, _3,

$L147:
 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	sll	$2,$16,3	 # tmp2110, i,
$L202:
	subu	$2,$2,$16	 # tmp2111, tmp2110, i
	sll	$2,$2,4	 # tmp2112, tmp2111,
	subu	$2,$2,$16	 # tmp2113, tmp2112, i
	sll	$2,$2,2	 # tmp2114, tmp2113,
	subu	$2,$2,$16	 # tmp2115, tmp2114, i
	sll	$2,$2,3	 # tmp2116, tmp2115,
	addiu	$2,$2,20	 # tmp2117, tmp2116,
 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	addiu	$4,$18,8	 # tmp2121, _654,
 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	move	$7,$fp	 #, turn_towards_rival_radius
	lui	$6,%hi(GlobalPlayer)	 # tmp2119,
	addiu	$6,$6,%lo(GlobalPlayer)	 # tmp2118, tmp2119,
	addu	$6,$6,$2	 #, tmp2118, tmp2117
	move	$5,$fp	 #, turn_towards_rival_radius
	lui	$2,%hi(AIPathfinder)	 # tmp2123,
	addiu	$2,$2,%lo(AIPathfinder)	 # tmp2122, tmp2123,
	jal	TestCollideSphere	 #
	addu	$4,$2,$4	 #, tmp2122, tmp2121

 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	beq	$2,$0,$L207	 #, tmp2230,,
	sll	$17,$17,2	 # tmp2152, _3,

 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	sub.s	$f20,$f22,$f20	 # tmp2126, bot_y, rival_y
 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	cvt.d.s	$f20,$f20	 # _491, tmp2126
	mul.d	$f20,$f20,$f20	 # tmp2127, _491, _491
 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	lui	$2,%hi($LC39)	 # tmp2129,
	ldc1	$f0,%lo($LC39)($2)	 # tmp2128,
	c.lt.d	$f20,$f0	 #, tmp2127, tmp2128
	nop	
	bc1t	$L198	 #,,
	sll	$2,$16,1	 # tmp2132, i,

$L207:
 # BattleBots/BattleBotAI.c:836:     ProSteeringPlus(i, CoursePaths[ci], CourseRamps[ci], CourseDrops[ci]);
	lui	$3,%hi(CourseDrops)	 # tmp2151,
	addiu	$3,$3,%lo(CourseDrops)	 # tmp2154, tmp2151,
	addu	$3,$17,$3	 # tmp2153, tmp2152, tmp2154
	lui	$2,%hi(CourseRamps)	 # tmp2156,
	addiu	$2,$2,%lo(CourseRamps)	 # tmp2159, tmp2156,
	addu	$2,$17,$2	 # tmp2158, tmp2152, tmp2159
	lui	$4,%hi(CoursePaths)	 # tmp2161,
	addiu	$4,$4,%lo(CoursePaths)	 # tmp2164, tmp2161,
	addu	$17,$17,$4	 # tmp2163, tmp2152, tmp2164
	lw	$7,0($3)		 #, CourseDrops
	lw	$6,0($2)		 #, CourseRamps
	lw	$5,0($17)		 #, CoursePaths
	jal	ProSteeringPlus	 #
	move	$4,$16	 #, i

$L101:
 # BattleBots/BattleBotAI.c:839: }
	lw	$31,92($sp)		 #,
$L203:
	lw	$fp,88($sp)		 #,
	lw	$23,84($sp)		 #,
	lw	$22,80($sp)		 #,
	lw	$21,76($sp)		 #,
	lw	$20,72($sp)		 #,
	lw	$19,68($sp)		 #,
	lw	$18,64($sp)		 #,
	lw	$17,60($sp)		 #,
	lw	$16,56($sp)		 #,
	ldc1	$f30,136($sp)	 #,
	ldc1	$f28,128($sp)	 #,
	ldc1	$f26,120($sp)	 #,
	ldc1	$f24,112($sp)	 #,
	ldc1	$f22,104($sp)	 #,
	ldc1	$f20,96($sp)	 #,
	jr	$31	 #
	addiu	$sp,$sp,144	 #,,

$L193:
 # BattleBots/BattleBotAI.c:382:         AIPathfinder[i].Target[1] = rival_y;
	swc1	$f20,12($19)	 # rival_y, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:383:         AIPathfinder[i].Target[2] = rival_z;
	swc1	$f30,16($19)	 # rival_z, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:384:         UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                            
	sll	$2,$17,2	 # tmp912, _3,
	lui	$4,%hi(CoursePathLengths)	 # tmp911,
	addiu	$4,$4,%lo(CoursePathLengths)	 # tmp914, tmp911,
	addu	$4,$2,$4	 # tmp913, tmp912, tmp914
	lui	$3,%hi(CoursePaths)	 # tmp916,
	addiu	$3,$3,%lo(CoursePaths)	 # tmp919, tmp916,
	addu	$3,$2,$3	 # tmp918, tmp912, tmp919
	sw	$0,24($sp)	 #,
	sll	$5,$16,16	 # i, i,
	sra	$5,$5,16	 # i, i,
	sw	$5,20($sp)	 # i,
 # BattleBots/BattleBotAI.c:384:         UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                            
	lui	$5,%hi(LineCounts)	 # tmp922,
	addiu	$5,$5,%lo(LineCounts)	 # tmp925, tmp922,
	addu	$2,$2,$5	 # tmp924, tmp912, tmp925
 # BattleBots/BattleBotAI.c:384:         UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                            
	lw	$2,0($2)		 # tmp926, LineCounts
	lh	$2,0($2)		 # *_28, *_28
	sw	$2,16($sp)	 # *_28,
	lw	$7,0($4)		 #, CoursePathLengths
	lw	$6,0($3)		 #, CoursePaths
	li	$5,350			# 0x15e	 #,
	jal	UpdateBKPath	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:398:     short TargetPath = AIPathfinder[i].TargetPath;
	b	$L200	 #
	sll	$2,$16,5	 # tmp929, i,

$L194:
 # BattleBots/BattleBotAI.c:419:                if (TargetPath >= LineCounts[ci][0]) //Catch crash where TargetPath had a value not corresponding to number of drops in the course
	lui	$3,%hi(LineCounts)	 # tmp939,
	addiu	$3,$3,%lo(LineCounts)	 # tmp942, tmp939,
	addu	$2,$2,$3	 # tmp941, tmp940, tmp942
 # BattleBots/BattleBotAI.c:419:                if (TargetPath >= LineCounts[ci][0]) //Catch crash where TargetPath had a value not corresponding to number of drops in the course
	lw	$2,0($2)		 # tmp943, LineCounts
 # BattleBots/BattleBotAI.c:419:                if (TargetPath >= LineCounts[ci][0]) //Catch crash where TargetPath had a value not corresponding to number of drops in the course
	lh	$2,0($2)		 # *_32, *_32
	slt	$2,$20,$2	 # tmp945, TargetPath, *_32
	bne	$2,$0,$L110	 #, tmp945,,
	sll	$2,$16,5	 # tmp953, i,

 # BattleBots/BattleBotAI.c:422:                     AIPathfinder[i].TargetPath = -1; 
	lui	$3,%hi(AIPathfinder)	 # tmp946,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp949, tmp946,
	addu	$2,$2,$3	 # tmp948, tmp947, tmp949
	li	$3,-1			# 0xffffffffffffffff	 # tmp950,
	sh	$3,0($2)	 # tmp950, AIPathfinder[i_533(D)].TargetPath
	b	$L107	 #
	li	$20,-1			# 0xffffffffffffffff	 # TargetPath,

$L110:
 # BattleBots/BattleBotAI.c:425:                 else if (AIPathfinder[i].NearestMarkerHeight - bot_y > 25)
	lui	$3,%hi(AIPathfinder)	 # tmp951,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp954, tmp951,
	addu	$2,$2,$3	 # tmp952, tmp953, tmp954
 # BattleBots/BattleBotAI.c:425:                 else if (AIPathfinder[i].NearestMarkerHeight - bot_y > 25)
	lwc1	$f0,24($2)	 # AIPathfinder[i_533(D)].NearestMarkerHeight, AIPathfinder[i_533(D)].NearestMarkerHeight
	sub.s	$f0,$f0,$f22	 # tmp955, AIPathfinder[i_533(D)].NearestMarkerHeight, bot_y
 # BattleBots/BattleBotAI.c:425:                 else if (AIPathfinder[i].NearestMarkerHeight - bot_y > 25)
	lui	$2,%hi($LC13)	 # tmp958,
	lwc1	$f2,%lo($LC13)($2)	 # tmp957,
	c.lt.s	$f2,$f0	 #, tmp957, tmp955
	nop	
	bc1t	$L111	 #,,
	sll	$2,$16,5	 # tmp967, i,

 # BattleBots/BattleBotAI.c:433:                     for (int ThisMarker = 0; ThisMarker <= CoursePathLengths[ci][TargetPath]; ThisMarker++)
	sll	$2,$17,2	 # tmp960, _3,
	lui	$3,%hi(CoursePathLengths)	 # tmp959,
	addiu	$3,$3,%lo(CoursePathLengths)	 # tmp962, tmp959,
	addu	$2,$2,$3	 # tmp961, tmp960, tmp962
 # BattleBots/BattleBotAI.c:433:                     for (int ThisMarker = 0; ThisMarker <= CoursePathLengths[ci][TargetPath]; ThisMarker++)
	sll	$6,$20,1	 # tmp963, TargetPath,
	lw	$2,0($2)		 # tmp964, CoursePathLengths
	addu	$6,$2,$6	 # _741, tmp964, tmp963
 # BattleBots/BattleBotAI.c:433:                     for (int ThisMarker = 0; ThisMarker <= CoursePathLengths[ci][TargetPath]; ThisMarker++)
	lh	$2,0($6)		 # *_741, *_741
	bltz	$2,$L107	 #, *_741,
	lui	$3,%hi(GlobalPlayer)	 # tmp971,

 # BattleBots/BattleBotAI.c:435:                         if (pow(GlobalPlayer[i].position[1] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1], 2) < 324) //If height is not too far off
	sll	$2,$16,3	 # tmp975, i,
	subu	$2,$2,$16	 # tmp976, tmp975, i
	sll	$2,$2,4	 # tmp977, tmp976,
	subu	$2,$2,$16	 # tmp978, tmp977, i
	sll	$2,$2,2	 # tmp979, tmp978,
	subu	$2,$2,$16	 # tmp980, tmp979, i
	sll	$2,$2,3	 # tmp981, tmp980,
	addiu	$3,$3,%lo(GlobalPlayer)	 # tmp972, tmp971,
	addu	$2,$3,$2	 # tmp973, tmp972, tmp981
	lwc1	$f8,24($2)	 # _36, GlobalPlayer[i_533(D)].position
 # BattleBots/BattleBotAI.c:435:                         if (pow(GlobalPlayer[i].position[1] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1], 2) < 324) //If height is not too far off
	sll	$2,$17,2	 # tmp983, _3,
	lui	$3,%hi(CoursePaths)	 # tmp982,
	addiu	$3,$3,%lo(CoursePaths)	 # tmp985, tmp982,
	addu	$2,$2,$3	 # tmp984, tmp983, tmp985
 # BattleBots/BattleBotAI.c:435:                         if (pow(GlobalPlayer[i].position[1] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1], 2) < 324) //If height is not too far off
	sll	$7,$20,2	 # tmp986, TargetPath,
	lw	$2,0($2)		 # tmp987, CoursePaths
	addu	$7,$2,$7	 # _39, tmp987, tmp986
 # BattleBots/BattleBotAI.c:433:                     for (int ThisMarker = 0; ThisMarker <= CoursePathLengths[ci][TargetPath]; ThisMarker++)
	move	$4,$0	 # ThisMarker,
 # BattleBots/BattleBotAI.c:397:     float CheckMarkerDistance = 9999999999;
	lui	$2,%hi($LC12)	 # tmp682,
	lwc1	$f2,%lo($LC12)($2)	 # CheckMarkerDistance,
 # BattleBots/BattleBotAI.c:435:                         if (pow(GlobalPlayer[i].position[1] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1], 2) < 324) //If height is not too far off
	lui	$2,%hi($LC14)	 # tmp994,
	ldc1	$f4,%lo($LC14)($2)	 # tmp993,
 # BattleBots/BattleBotAI.c:437:                             GlobalFloatA =  pow(GlobalPlayer[i].position[0] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[0], 2) + 
	lui	$8,%hi(GlobalPlayer)	 # tmp2173,
	addiu	$8,$8,%lo(GlobalPlayer)	 # tmp2174, tmp2173,
	sll	$2,$16,3	 # tmp2175, i,
	subu	$2,$2,$16	 # tmp2176, tmp2175, i
	sll	$2,$2,4	 # tmp2177, tmp2176,
	subu	$2,$2,$16	 # tmp2178, tmp2177, i
	sll	$2,$2,2	 # tmp2179, tmp2178,
	subu	$2,$2,$16	 # tmp2180, tmp2179, i
	sll	$2,$2,3	 # tmp2181, tmp2180,
	addu	$8,$8,$2	 # tmp2182, tmp2174, tmp2181
 # BattleBots/BattleBotAI.c:437:                             GlobalFloatA =  pow(GlobalPlayer[i].position[0] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[0], 2) + 
	lui	$10,%hi(GlobalFloatA)	 # tmp2183,
 # BattleBots/BattleBotAI.c:442:                                 AIPathfinder[i].NearestMarker = ThisMarker;
	lui	$9,%hi(AIPathfinder)	 # tmp2184,
	addiu	$9,$9,%lo(AIPathfinder)	 # tmp2185, tmp2184,
	sll	$2,$16,5	 # tmp2186, i,
	b	$L116	 #
	addu	$9,$9,$2	 # tmp2187, tmp2185, tmp2186

$L111:
 # BattleBots/BattleBotAI.c:428:                     AIPathfinder[i].TargetPath = -1;  
	lui	$3,%hi(AIPathfinder)	 # tmp966,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp969, tmp966,
	addu	$2,$2,$3	 # tmp968, tmp967, tmp969
	li	$3,-1			# 0xffffffffffffffff	 # tmp970,
	sh	$3,0($2)	 # tmp970, AIPathfinder[i_533(D)].TargetPath
	b	$L107	 #
	li	$20,-1			# 0xffffffffffffffff	 # TargetPath,

$L113:
 # BattleBots/BattleBotAI.c:433:                     for (int ThisMarker = 0; ThisMarker <= CoursePathLengths[ci][TargetPath]; ThisMarker++)
	addiu	$4,$4,1	 # ThisMarker, ThisMarker,
$L209:
 # BattleBots/BattleBotAI.c:433:                     for (int ThisMarker = 0; ThisMarker <= CoursePathLengths[ci][TargetPath]; ThisMarker++)
	lh	$2,0($6)		 # *_741, *_741
 # BattleBots/BattleBotAI.c:433:                     for (int ThisMarker = 0; ThisMarker <= CoursePathLengths[ci][TargetPath]; ThisMarker++)
	slt	$2,$2,$4	 # tmp1042, *_741, ThisMarker
	bne	$2,$0,$L208	 #, tmp1042,,
	li	$2,1			# 0x1	 # tmp1275,

$L116:
	sll	$5,$4,3	 # _771, ThisMarker,
 # BattleBots/BattleBotAI.c:435:                         if (pow(GlobalPlayer[i].position[1] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1], 2) < 324) //If height is not too far off
	lw	$3,0($7)		 # *_39, *_39
	addu	$3,$3,$5	 # _43, *_39, _771
 # BattleBots/BattleBotAI.c:435:                         if (pow(GlobalPlayer[i].position[1] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1], 2) < 324) //If height is not too far off
	lh	$2,2($3)		 # _43->Position, _43->Position
	mtc1	$2,$f0	 # _43->Position, _43->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp989, _43->Position
 # BattleBots/BattleBotAI.c:435:                         if (pow(GlobalPlayer[i].position[1] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1], 2) < 324) //If height is not too far off
	sub.s	$f0,$f8,$f0	 # tmp991, _36, tmp989
 # BattleBots/BattleBotAI.c:435:                         if (pow(GlobalPlayer[i].position[1] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1], 2) < 324) //If height is not too far off
	cvt.d.s	$f0,$f0	 # _47, tmp991
	mul.d	$f0,$f0,$f0	 # tmp992, _47, _47
 # BattleBots/BattleBotAI.c:435:                         if (pow(GlobalPlayer[i].position[1] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1], 2) < 324) //If height is not too far off
	c.lt.d	$f0,$f4	 #, tmp992, tmp993
	nop	
	bc1fl	$L209	 #,,
	addiu	$4,$4,1	 # ThisMarker, ThisMarker,

 # BattleBots/BattleBotAI.c:437:                             GlobalFloatA =  pow(GlobalPlayer[i].position[0] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[0], 2) + 
	lh	$2,0($3)		 # _43->Position, _43->Position
	mtc1	$2,$f0	 # _43->Position, _43->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1006, _43->Position
 # BattleBots/BattleBotAI.c:437:                             GlobalFloatA =  pow(GlobalPlayer[i].position[0] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[0], 2) + 
	lwc1	$f6,20($8)	 # GlobalPlayer[i_533(D)].position, GlobalPlayer[i_533(D)].position
	sub.s	$f0,$f6,$f0	 # tmp1008, GlobalPlayer[i_533(D)].position, tmp1006
 # BattleBots/BattleBotAI.c:437:                             GlobalFloatA =  pow(GlobalPlayer[i].position[0] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[0], 2) + 
	cvt.d.s	$f0,$f0	 # _57, tmp1008
 # BattleBots/BattleBotAI.c:438:                                             pow(GlobalPlayer[i].position[2] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[2], 2)   ;
	lh	$2,4($3)		 # _43->Position, _43->Position
	mtc1	$2,$f6	 # _43->Position, _43->Position
	nop	
	cvt.s.w	$f6,$f6	 # tmp1021, _43->Position
 # BattleBots/BattleBotAI.c:438:                                             pow(GlobalPlayer[i].position[2] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[2], 2)   ;
	lwc1	$f10,28($8)	 # GlobalPlayer[i_533(D)].position, GlobalPlayer[i_533(D)].position
	sub.s	$f6,$f10,$f6	 # tmp1023, GlobalPlayer[i_533(D)].position, tmp1021
 # BattleBots/BattleBotAI.c:438:                                             pow(GlobalPlayer[i].position[2] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[2], 2)   ;
	cvt.d.s	$f6,$f6	 # _67, tmp1023
 # BattleBots/BattleBotAI.c:437:                             GlobalFloatA =  pow(GlobalPlayer[i].position[0] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[0], 2) + 
	mul.d	$f0,$f0,$f0	 # tmp1025, _57, _57
 # BattleBots/BattleBotAI.c:438:                                             pow(GlobalPlayer[i].position[2] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[2], 2)   ;
	mul.d	$f6,$f6,$f6	 # tmp1026, _67, _67
 # BattleBots/BattleBotAI.c:437:                             GlobalFloatA =  pow(GlobalPlayer[i].position[0] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[0], 2) + 
	add.d	$f0,$f0,$f6	 # tmp1027, tmp1025, tmp1026
	cvt.s.d	$f0,$f0	 # _70, tmp1027
 # BattleBots/BattleBotAI.c:439:                             if (GlobalFloatA < CheckMarkerDistance)
	c.lt.s	$f0,$f2	 #, _70, CheckMarkerDistance
	nop	
	bc1f	$L113	 #,,
	swc1	$f0,%lo(GlobalFloatA)($10)	 # _70, GlobalFloatA

 # BattleBots/BattleBotAI.c:442:                                 AIPathfinder[i].NearestMarker = ThisMarker;
	sh	$4,22($9)	 # ThisMarker, AIPathfinder[i_533(D)].NearestMarker
 # BattleBots/BattleBotAI.c:443:                                 AIPathfinder[i].NearestMarkerHeight = (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1];
	lw	$2,0($7)		 # *_39, *_39
	addu	$5,$2,$5	 # tmp1038, *_39, _771
 # BattleBots/BattleBotAI.c:443:                                 AIPathfinder[i].NearestMarkerHeight = (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1];
	lh	$2,2($5)		 # _75->Position, _75->Position
	mtc1	$2,$f2	 # _75->Position, _75->Position
	nop	
	cvt.s.w	$f2,$f2	 # tmp1040, _75->Position
	swc1	$f2,24($9)	 # tmp1040, AIPathfinder[i_533(D)].NearestMarkerHeight
 # BattleBots/BattleBotAI.c:441:                                 CheckMarkerDistance = GlobalFloatA;
	b	$L113	 #
	mov.s	$f2,$f0	 # CheckMarkerDistance, _70

$L108:
 # BattleBots/BattleBotAI.c:457:                if (TargetPath >= LineCounts[ci][1]) //Catch crash where TargetPath had a value not corresponding to number of drops in the course
	sll	$2,$17,2	 # tmp1044, _3,
	lui	$3,%hi(LineCounts)	 # tmp1043,
	addiu	$3,$3,%lo(LineCounts)	 # tmp1046, tmp1043,
	addu	$2,$2,$3	 # tmp1045, tmp1044, tmp1046
 # BattleBots/BattleBotAI.c:457:                if (TargetPath >= LineCounts[ci][1]) //Catch crash where TargetPath had a value not corresponding to number of drops in the course
	lw	$2,0($2)		 # tmp1047, LineCounts
 # BattleBots/BattleBotAI.c:457:                if (TargetPath >= LineCounts[ci][1]) //Catch crash where TargetPath had a value not corresponding to number of drops in the course
	lh	$2,2($2)		 # MEM[(short int *)_84 + 2B], MEM[(short int *)_84 + 2B]
	slt	$2,$20,$2	 # tmp1049, TargetPath, MEM[(short int *)_84 + 2B]
	bne	$2,$0,$L117	 #, tmp1049,,
	sll	$2,$17,2	 # tmp1056, _3,

 # BattleBots/BattleBotAI.c:460:                     AIPathfinder[i].TargetPath = -1; 
	sll	$2,$16,5	 # tmp1051, i,
	lui	$3,%hi(AIPathfinder)	 # tmp1050,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp1053, tmp1050,
	addu	$2,$2,$3	 # tmp1052, tmp1051, tmp1053
	li	$3,-1			# 0xffffffffffffffff	 # tmp1054,
	sh	$3,0($2)	 # tmp1054, AIPathfinder[i_533(D)].TargetPath
	b	$L107	 #
	li	$20,-1			# 0xffffffffffffffff	 # TargetPath,

$L117:
 # BattleBots/BattleBotAI.c:463:                 else if ((float)CourseRamps[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	lui	$3,%hi(CourseRamps)	 # tmp1055,
	addiu	$3,$3,%lo(CourseRamps)	 # tmp1058, tmp1055,
	addu	$2,$2,$3	 # tmp1057, tmp1056, tmp1058
 # BattleBots/BattleBotAI.c:463:                 else if ((float)CourseRamps[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	sll	$6,$20,2	 # tmp1059, TargetPath,
	lw	$2,0($2)		 # tmp1060, CourseRamps
	addu	$6,$2,$6	 # _89, tmp1060, tmp1059
 # BattleBots/BattleBotAI.c:463:                 else if ((float)CourseRamps[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	lui	$3,%hi(AIPathfinder)	 # tmp1061,
	sll	$2,$16,5	 # tmp1064, i,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp1062, tmp1061,
	addu	$2,$3,$2	 # tmp1063, tmp1062, tmp1064
	lh	$3,20($2)		 # AIPathfinder[i_533(D)].Progression, AIPathfinder[i_533(D)].Progression
 # BattleBots/BattleBotAI.c:463:                 else if ((float)CourseRamps[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	lw	$2,0($6)		 # *_89, *_89
	sll	$3,$3,3	 # tmp1067, AIPathfinder[i_533(D)].Progression,
	addu	$2,$2,$3	 # tmp1068, *_89, tmp1067
 # BattleBots/BattleBotAI.c:463:                 else if ((float)CourseRamps[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	lh	$2,2($2)		 # _94->Position, _94->Position
	mtc1	$2,$f0	 # _94->Position, _94->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1069, _94->Position
 # BattleBots/BattleBotAI.c:463:                 else if ((float)CourseRamps[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	sub.s	$f0,$f0,$f22	 # tmp1071, tmp1069, bot_y
 # BattleBots/BattleBotAI.c:463:                 else if ((float)CourseRamps[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	lui	$2,%hi($LC15)	 # tmp1073,
	lwc1	$f2,%lo($LC15)($2)	 # tmp1072,
	c.lt.s	$f2,$f0	 #, tmp1072, tmp1071
	nop	
	bc1t	$L118	 #,,
	sll	$2,$16,5	 # tmp1082, i,

 # BattleBots/BattleBotAI.c:471:                     for (int ThisMarker = 0; ThisMarker <= CourseRampLengths[ci][TargetPath]; ThisMarker++)
	sll	$2,$17,2	 # tmp1075, _3,
	lui	$3,%hi(CourseRampLengths)	 # tmp1074,
	addiu	$3,$3,%lo(CourseRampLengths)	 # tmp1077, tmp1074,
	addu	$2,$2,$3	 # tmp1076, tmp1075, tmp1077
 # BattleBots/BattleBotAI.c:471:                     for (int ThisMarker = 0; ThisMarker <= CourseRampLengths[ci][TargetPath]; ThisMarker++)
	sll	$7,$20,1	 # tmp1078, TargetPath,
	lw	$2,0($2)		 # tmp1079, CourseRampLengths
	addu	$7,$2,$7	 # _749, tmp1079, tmp1078
 # BattleBots/BattleBotAI.c:471:                     for (int ThisMarker = 0; ThisMarker <= CourseRampLengths[ci][TargetPath]; ThisMarker++)
	lh	$2,0($7)		 # *_749, *_749
	bltz	$2,$L107	 #, *_749,
	lui	$3,%hi(GlobalPlayer)	 # tmp1086,

 # BattleBots/BattleBotAI.c:473:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	sll	$2,$16,3	 # tmp1090, i,
	subu	$2,$2,$16	 # tmp1091, tmp1090, i
	sll	$2,$2,4	 # tmp1092, tmp1091,
	subu	$2,$2,$16	 # tmp1093, tmp1092, i
	sll	$2,$2,2	 # tmp1094, tmp1093,
	subu	$2,$2,$16	 # tmp1095, tmp1094, i
	sll	$2,$2,3	 # tmp1096, tmp1095,
	addiu	$3,$3,%lo(GlobalPlayer)	 # tmp1087, tmp1086,
	addu	$2,$3,$2	 # tmp1088, tmp1087, tmp1096
	lwc1	$f8,24($2)	 # _98, GlobalPlayer[i_533(D)].position
 # BattleBots/BattleBotAI.c:471:                     for (int ThisMarker = 0; ThisMarker <= CourseRampLengths[ci][TargetPath]; ThisMarker++)
	move	$4,$0	 # ThisMarker,
 # BattleBots/BattleBotAI.c:397:     float CheckMarkerDistance = 9999999999;
	lui	$2,%hi($LC12)	 # tmp683,
	lwc1	$f2,%lo($LC12)($2)	 # CheckMarkerDistance,
 # BattleBots/BattleBotAI.c:473:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	lui	$2,%hi($LC16)	 # tmp1103,
	ldc1	$f4,%lo($LC16)($2)	 # tmp1102,
 # BattleBots/BattleBotAI.c:475:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[0], 2) + 
	sll	$2,$16,3	 # tmp2205, i,
	subu	$2,$2,$16	 # tmp2206, tmp2205, i
	sll	$2,$2,4	 # tmp2207, tmp2206,
	subu	$2,$2,$16	 # tmp2208, tmp2207, i
	sll	$2,$2,2	 # tmp2209, tmp2208,
	subu	$2,$2,$16	 # tmp2210, tmp2209, i
	sll	$2,$2,3	 # tmp2211, tmp2210,
	addu	$8,$3,$2	 # tmp2212, tmp2204, tmp2211
 # BattleBots/BattleBotAI.c:475:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[0], 2) + 
	lui	$10,%hi(GlobalFloatA)	 # tmp2213,
 # BattleBots/BattleBotAI.c:480:                                 AIPathfinder[i].NearestMarker = ThisMarker;
	lui	$9,%hi(AIPathfinder)	 # tmp2214,
	addiu	$9,$9,%lo(AIPathfinder)	 # tmp2215, tmp2214,
	sll	$2,$16,5	 # tmp2216, i,
	b	$L123	 #
	addu	$9,$9,$2	 # tmp2217, tmp2215, tmp2216

$L118:
 # BattleBots/BattleBotAI.c:466:                     AIPathfinder[i].TargetPath = -1; 
	lui	$3,%hi(AIPathfinder)	 # tmp1081,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp1084, tmp1081,
	addu	$2,$2,$3	 # tmp1083, tmp1082, tmp1084
	li	$3,-1			# 0xffffffffffffffff	 # tmp1085,
	sh	$3,0($2)	 # tmp1085, AIPathfinder[i_533(D)].TargetPath
	b	$L107	 #
	li	$20,-1			# 0xffffffffffffffff	 # TargetPath,

$L120:
 # BattleBots/BattleBotAI.c:471:                     for (int ThisMarker = 0; ThisMarker <= CourseRampLengths[ci][TargetPath]; ThisMarker++)
	addiu	$4,$4,1	 # ThisMarker, ThisMarker,
$L210:
 # BattleBots/BattleBotAI.c:471:                     for (int ThisMarker = 0; ThisMarker <= CourseRampLengths[ci][TargetPath]; ThisMarker++)
	lh	$2,0($7)		 # *_749, *_749
 # BattleBots/BattleBotAI.c:471:                     for (int ThisMarker = 0; ThisMarker <= CourseRampLengths[ci][TargetPath]; ThisMarker++)
	slt	$2,$2,$4	 # tmp1151, *_749, ThisMarker
	bne	$2,$0,$L208	 #, tmp1151,,
	li	$2,1			# 0x1	 # tmp1275,

$L123:
	sll	$5,$4,3	 # _58, ThisMarker,
 # BattleBots/BattleBotAI.c:473:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	lw	$3,0($6)		 # *_89, *_89
	addu	$3,$3,$5	 # _104, *_89, _58
 # BattleBots/BattleBotAI.c:473:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	lh	$2,2($3)		 # _104->Position, _104->Position
	mtc1	$2,$f0	 # _104->Position, _104->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1098, _104->Position
 # BattleBots/BattleBotAI.c:473:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	sub.s	$f0,$f8,$f0	 # tmp1100, _98, tmp1098
 # BattleBots/BattleBotAI.c:473:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	cvt.d.s	$f0,$f0	 # _108, tmp1100
	mul.d	$f0,$f0,$f0	 # tmp1101, _108, _108
 # BattleBots/BattleBotAI.c:473:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	c.lt.d	$f0,$f4	 #, tmp1101, tmp1102
	nop	
	bc1fl	$L210	 #,,
	addiu	$4,$4,1	 # ThisMarker, ThisMarker,

 # BattleBots/BattleBotAI.c:475:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[0], 2) + 
	lh	$2,0($3)		 # _104->Position, _104->Position
	mtc1	$2,$f0	 # _104->Position, _104->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1115, _104->Position
 # BattleBots/BattleBotAI.c:475:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[0], 2) + 
	lwc1	$f6,20($8)	 # GlobalPlayer[i_533(D)].position, GlobalPlayer[i_533(D)].position
	sub.s	$f0,$f6,$f0	 # tmp1117, GlobalPlayer[i_533(D)].position, tmp1115
 # BattleBots/BattleBotAI.c:475:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[0], 2) + 
	cvt.d.s	$f0,$f0	 # _118, tmp1117
 # BattleBots/BattleBotAI.c:476:                                             pow(GlobalPlayer[i].position[2] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[2], 2)   ;
	lh	$2,4($3)		 # _104->Position, _104->Position
	mtc1	$2,$f6	 # _104->Position, _104->Position
	nop	
	cvt.s.w	$f6,$f6	 # tmp1130, _104->Position
 # BattleBots/BattleBotAI.c:476:                                             pow(GlobalPlayer[i].position[2] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[2], 2)   ;
	lwc1	$f10,28($8)	 # GlobalPlayer[i_533(D)].position, GlobalPlayer[i_533(D)].position
	sub.s	$f6,$f10,$f6	 # tmp1132, GlobalPlayer[i_533(D)].position, tmp1130
 # BattleBots/BattleBotAI.c:476:                                             pow(GlobalPlayer[i].position[2] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[2], 2)   ;
	cvt.d.s	$f6,$f6	 # _128, tmp1132
 # BattleBots/BattleBotAI.c:475:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[0], 2) + 
	mul.d	$f0,$f0,$f0	 # tmp1134, _118, _118
 # BattleBots/BattleBotAI.c:476:                                             pow(GlobalPlayer[i].position[2] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[2], 2)   ;
	mul.d	$f6,$f6,$f6	 # tmp1135, _128, _128
 # BattleBots/BattleBotAI.c:475:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[0], 2) + 
	add.d	$f0,$f0,$f6	 # tmp1136, tmp1134, tmp1135
	cvt.s.d	$f0,$f0	 # _131, tmp1136
 # BattleBots/BattleBotAI.c:477:                             if (GlobalFloatA < CheckMarkerDistance)
	c.lt.s	$f0,$f2	 #, _131, CheckMarkerDistance
	nop	
	bc1f	$L120	 #,,
	swc1	$f0,%lo(GlobalFloatA)($10)	 # _131, GlobalFloatA

 # BattleBots/BattleBotAI.c:480:                                 AIPathfinder[i].NearestMarker = ThisMarker;
	sh	$4,22($9)	 # ThisMarker, AIPathfinder[i_533(D)].NearestMarker
 # BattleBots/BattleBotAI.c:481:                                 AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1];
	lw	$2,0($6)		 # *_89, *_89
	addu	$5,$2,$5	 # tmp1147, *_89, _58
 # BattleBots/BattleBotAI.c:481:                                 AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1];
	lh	$2,2($5)		 # _136->Position, _136->Position
	mtc1	$2,$f2	 # _136->Position, _136->Position
	nop	
	cvt.s.w	$f2,$f2	 # tmp1149, _136->Position
	swc1	$f2,24($9)	 # tmp1149, AIPathfinder[i_533(D)].NearestMarkerHeight
 # BattleBots/BattleBotAI.c:479:                                 CheckMarkerDistance = GlobalFloatA;
	b	$L120	 #
	mov.s	$f2,$f0	 # CheckMarkerDistance, _131

$L109:
 # BattleBots/BattleBotAI.c:493:                 *(uint*)(0x80700000) = (uint)ci;
	sw	$17,0($2)	 # _3, MEM[(uint *)2154823680B]
 # BattleBots/BattleBotAI.c:494:                 *(uint*)(0x80700004) = (uint)TargetPath;
	sw	$20,4($2)	 # TargetPath, MEM[(uint *)2154823684B]
 # BattleBots/BattleBotAI.c:495:                 *(uint*)(0x80700008) = (uint)i;
	sw	$16,8($2)	 # i, MEM[(uint *)2154823688B]
 # BattleBots/BattleBotAI.c:496:                 *(float*)(0x8070000C) = (float)bot_y;
	swc1	$f22,12($2)	 # bot_y, MEM[(float *)2154823692B]
 # BattleBots/BattleBotAI.c:497:                 *(uint*)(0x80700010) = (uint)AIPathfinder[i].Progression;
	lui	$4,%hi(AIPathfinder)	 # tmp1161,
	sll	$3,$16,5	 # tmp1164, i,
	addiu	$4,$4,%lo(AIPathfinder)	 # tmp1162, tmp1161,
	addu	$3,$4,$3	 # tmp1163, tmp1162, tmp1164
 # BattleBots/BattleBotAI.c:497:                 *(uint*)(0x80700010) = (uint)AIPathfinder[i].Progression;
	lh	$3,20($3)		 # AIPathfinder[i_533(D)].Progression, AIPathfinder[i_533(D)].Progression
	sw	$3,16($2)	 # AIPathfinder[i_533(D)].Progression, MEM[(uint *)2154823696B]
 # BattleBots/BattleBotAI.c:499:                 if (TargetPath >= LineCounts[ci][2]) //Catch crash where TargetPath had a value not corresponding to number of drops in the course
	sll	$2,$17,2	 # tmp1167, _3,
	lui	$3,%hi(LineCounts)	 # tmp1166,
	addiu	$3,$3,%lo(LineCounts)	 # tmp1169, tmp1166,
	addu	$2,$2,$3	 # tmp1168, tmp1167, tmp1169
 # BattleBots/BattleBotAI.c:499:                 if (TargetPath >= LineCounts[ci][2]) //Catch crash where TargetPath had a value not corresponding to number of drops in the course
	lw	$2,0($2)		 # tmp1170, LineCounts
 # BattleBots/BattleBotAI.c:499:                 if (TargetPath >= LineCounts[ci][2]) //Catch crash where TargetPath had a value not corresponding to number of drops in the course
	lh	$2,4($2)		 # MEM[(short int *)_149 + 4B], MEM[(short int *)_149 + 4B]
	slt	$2,$20,$2	 # tmp1172, TargetPath, MEM[(short int *)_149 + 4B]
	bne	$2,$0,$L124	 #, tmp1172,,
	sll	$2,$17,2	 # tmp1179, _3,

 # BattleBots/BattleBotAI.c:502:                     AIPathfinder[i].TargetPath = -1; 
	sll	$2,$16,5	 # tmp1174, i,
	addu	$2,$2,$4	 # tmp1175, tmp1174, tmp1176
	li	$3,-1			# 0xffffffffffffffff	 # tmp1177,
	sh	$3,0($2)	 # tmp1177, AIPathfinder[i_533(D)].TargetPath
	b	$L107	 #
	li	$20,-1			# 0xffffffffffffffff	 # TargetPath,

$L124:
 # BattleBots/BattleBotAI.c:505:                 else if ((float)CourseDrops[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	lui	$3,%hi(CourseDrops)	 # tmp1178,
	addiu	$3,$3,%lo(CourseDrops)	 # tmp1181, tmp1178,
	addu	$2,$2,$3	 # tmp1180, tmp1179, tmp1181
 # BattleBots/BattleBotAI.c:505:                 else if ((float)CourseDrops[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	sll	$6,$20,2	 # tmp1182, TargetPath,
	lw	$2,0($2)		 # tmp1183, CourseDrops
	addu	$6,$2,$6	 # _153, tmp1183, tmp1182
 # BattleBots/BattleBotAI.c:505:                 else if ((float)CourseDrops[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	lui	$3,%hi(AIPathfinder)	 # tmp1184,
	sll	$2,$16,5	 # tmp1187, i,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp1185, tmp1184,
	addu	$2,$3,$2	 # tmp1186, tmp1185, tmp1187
	lh	$3,20($2)		 # AIPathfinder[i_533(D)].Progression, AIPathfinder[i_533(D)].Progression
 # BattleBots/BattleBotAI.c:505:                 else if ((float)CourseDrops[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	lw	$2,0($6)		 # *_153, *_153
	sll	$3,$3,3	 # tmp1190, AIPathfinder[i_533(D)].Progression,
	addu	$2,$2,$3	 # tmp1191, *_153, tmp1190
 # BattleBots/BattleBotAI.c:505:                 else if ((float)CourseDrops[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	lh	$2,2($2)		 # _158->Position, _158->Position
	mtc1	$2,$f0	 # _158->Position, _158->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1192, _158->Position
 # BattleBots/BattleBotAI.c:505:                 else if ((float)CourseDrops[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	sub.s	$f0,$f0,$f22	 # tmp1194, tmp1192, bot_y
 # BattleBots/BattleBotAI.c:505:                 else if ((float)CourseDrops[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
	lui	$2,%hi($LC15)	 # tmp1196,
	lwc1	$f2,%lo($LC15)($2)	 # tmp1195,
	c.lt.s	$f2,$f0	 #, tmp1195, tmp1194
	nop	
	bc1t	$L125	 #,,
	sll	$2,$16,5	 # tmp1205, i,

 # BattleBots/BattleBotAI.c:513:                     for (int ThisMarker = 0; ThisMarker <= CourseDropLengths[ci][TargetPath]; ThisMarker++)
	sll	$2,$17,2	 # tmp1198, _3,
	lui	$3,%hi(CourseDropLengths)	 # tmp1197,
	addiu	$3,$3,%lo(CourseDropLengths)	 # tmp1200, tmp1197,
	addu	$2,$2,$3	 # tmp1199, tmp1198, tmp1200
 # BattleBots/BattleBotAI.c:513:                     for (int ThisMarker = 0; ThisMarker <= CourseDropLengths[ci][TargetPath]; ThisMarker++)
	sll	$7,$20,1	 # tmp1201, _145,
	lw	$2,0($2)		 # tmp1202, CourseDropLengths
	addu	$7,$2,$7	 # _757, tmp1202, tmp1201
 # BattleBots/BattleBotAI.c:513:                     for (int ThisMarker = 0; ThisMarker <= CourseDropLengths[ci][TargetPath]; ThisMarker++)
	lh	$2,0($7)		 # *_757, *_757
	bltz	$2,$L107	 #, *_757,
	lui	$3,%hi(GlobalPlayer)	 # tmp1209,

 # BattleBots/BattleBotAI.c:515:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	sll	$2,$16,3	 # tmp1213, i,
	subu	$2,$2,$16	 # tmp1214, tmp1213, i
	sll	$2,$2,4	 # tmp1215, tmp1214,
	subu	$2,$2,$16	 # tmp1216, tmp1215, i
	sll	$2,$2,2	 # tmp1217, tmp1216,
	subu	$2,$2,$16	 # tmp1218, tmp1217, i
	sll	$2,$2,3	 # tmp1219, tmp1218,
	addiu	$3,$3,%lo(GlobalPlayer)	 # tmp1210, tmp1209,
	addu	$2,$3,$2	 # tmp1211, tmp1210, tmp1219
	lwc1	$f8,24($2)	 # _162, GlobalPlayer[i_533(D)].position
 # BattleBots/BattleBotAI.c:513:                     for (int ThisMarker = 0; ThisMarker <= CourseDropLengths[ci][TargetPath]; ThisMarker++)
	move	$4,$0	 # ThisMarker,
 # BattleBots/BattleBotAI.c:397:     float CheckMarkerDistance = 9999999999;
	lui	$2,%hi($LC12)	 # tmp684,
	lwc1	$f2,%lo($LC12)($2)	 # CheckMarkerDistance,
 # BattleBots/BattleBotAI.c:515:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	lui	$2,%hi($LC16)	 # tmp1226,
	ldc1	$f4,%lo($LC16)($2)	 # tmp1225,
 # BattleBots/BattleBotAI.c:517:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[0], 2) + 
	sll	$2,$16,3	 # tmp2190, i,
	subu	$2,$2,$16	 # tmp2191, tmp2190, i
	sll	$2,$2,4	 # tmp2192, tmp2191,
	subu	$2,$2,$16	 # tmp2193, tmp2192, i
	sll	$2,$2,2	 # tmp2194, tmp2193,
	subu	$2,$2,$16	 # tmp2195, tmp2194, i
	sll	$2,$2,3	 # tmp2196, tmp2195,
	addu	$8,$3,$2	 # tmp2197, tmp2189, tmp2196
 # BattleBots/BattleBotAI.c:517:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[0], 2) + 
	lui	$10,%hi(GlobalFloatA)	 # tmp2198,
 # BattleBots/BattleBotAI.c:522:                                 AIPathfinder[i].NearestMarker = ThisMarker;
	lui	$9,%hi(AIPathfinder)	 # tmp2199,
	addiu	$9,$9,%lo(AIPathfinder)	 # tmp2200, tmp2199,
	sll	$2,$16,5	 # tmp2201, i,
	b	$L130	 #
	addu	$9,$9,$2	 # tmp2202, tmp2200, tmp2201

$L125:
 # BattleBots/BattleBotAI.c:508:                     AIPathfinder[i].TargetPath = -1; 
	lui	$3,%hi(AIPathfinder)	 # tmp1204,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp1207, tmp1204,
	addu	$2,$2,$3	 # tmp1206, tmp1205, tmp1207
	li	$3,-1			# 0xffffffffffffffff	 # tmp1208,
	sh	$3,0($2)	 # tmp1208, AIPathfinder[i_533(D)].TargetPath
	b	$L107	 #
	li	$20,-1			# 0xffffffffffffffff	 # TargetPath,

$L127:
 # BattleBots/BattleBotAI.c:513:                     for (int ThisMarker = 0; ThisMarker <= CourseDropLengths[ci][TargetPath]; ThisMarker++)
	addiu	$4,$4,1	 # ThisMarker, ThisMarker,
$L211:
 # BattleBots/BattleBotAI.c:513:                     for (int ThisMarker = 0; ThisMarker <= CourseDropLengths[ci][TargetPath]; ThisMarker++)
	lh	$2,0($7)		 # *_757, *_757
 # BattleBots/BattleBotAI.c:513:                     for (int ThisMarker = 0; ThisMarker <= CourseDropLengths[ci][TargetPath]; ThisMarker++)
	slt	$2,$2,$4	 # tmp1274, *_757, ThisMarker
	bne	$2,$0,$L208	 #, tmp1274,,
	li	$2,1			# 0x1	 # tmp1275,

$L130:
	sll	$5,$4,3	 # _372, ThisMarker,
 # BattleBots/BattleBotAI.c:515:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	lw	$3,0($6)		 # *_153, *_153
	addu	$3,$3,$5	 # _168, *_153, _372
 # BattleBots/BattleBotAI.c:515:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	lh	$2,2($3)		 # _168->Position, _168->Position
	mtc1	$2,$f0	 # _168->Position, _168->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1221, _168->Position
 # BattleBots/BattleBotAI.c:515:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	sub.s	$f0,$f8,$f0	 # tmp1223, _162, tmp1221
 # BattleBots/BattleBotAI.c:515:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	cvt.d.s	$f0,$f0	 # _172, tmp1223
	mul.d	$f0,$f0,$f0	 # tmp1224, _172, _172
 # BattleBots/BattleBotAI.c:515:                         if (pow(GlobalPlayer[i].position[1] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1], 2) < 625)
	c.lt.d	$f0,$f4	 #, tmp1224, tmp1225
	nop	
	bc1fl	$L211	 #,,
	addiu	$4,$4,1	 # ThisMarker, ThisMarker,

 # BattleBots/BattleBotAI.c:517:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[0], 2) + 
	lh	$2,0($3)		 # _168->Position, _168->Position
	mtc1	$2,$f0	 # _168->Position, _168->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1238, _168->Position
 # BattleBots/BattleBotAI.c:517:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[0], 2) + 
	lwc1	$f6,20($8)	 # GlobalPlayer[i_533(D)].position, GlobalPlayer[i_533(D)].position
	sub.s	$f0,$f6,$f0	 # tmp1240, GlobalPlayer[i_533(D)].position, tmp1238
 # BattleBots/BattleBotAI.c:517:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[0], 2) + 
	cvt.d.s	$f0,$f0	 # _182, tmp1240
 # BattleBots/BattleBotAI.c:518:                                             pow(GlobalPlayer[i].position[2] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[2], 2);
	lh	$2,4($3)		 # _168->Position, _168->Position
	mtc1	$2,$f6	 # _168->Position, _168->Position
	nop	
	cvt.s.w	$f6,$f6	 # tmp1253, _168->Position
 # BattleBots/BattleBotAI.c:518:                                             pow(GlobalPlayer[i].position[2] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[2], 2);
	lwc1	$f10,28($8)	 # GlobalPlayer[i_533(D)].position, GlobalPlayer[i_533(D)].position
	sub.s	$f6,$f10,$f6	 # tmp1255, GlobalPlayer[i_533(D)].position, tmp1253
 # BattleBots/BattleBotAI.c:518:                                             pow(GlobalPlayer[i].position[2] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[2], 2);
	cvt.d.s	$f6,$f6	 # _192, tmp1255
 # BattleBots/BattleBotAI.c:517:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[0], 2) + 
	mul.d	$f0,$f0,$f0	 # tmp1257, _182, _182
 # BattleBots/BattleBotAI.c:518:                                             pow(GlobalPlayer[i].position[2] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[2], 2);
	mul.d	$f6,$f6,$f6	 # tmp1258, _192, _192
 # BattleBots/BattleBotAI.c:517:                             GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[0], 2) + 
	add.d	$f0,$f0,$f6	 # tmp1259, tmp1257, tmp1258
	cvt.s.d	$f0,$f0	 # _195, tmp1259
 # BattleBots/BattleBotAI.c:519:                             if (GlobalFloatA < CheckMarkerDistance)
	c.lt.s	$f0,$f2	 #, _195, CheckMarkerDistance
	nop	
	bc1f	$L127	 #,,
	swc1	$f0,%lo(GlobalFloatA)($10)	 # _195, GlobalFloatA

 # BattleBots/BattleBotAI.c:522:                                 AIPathfinder[i].NearestMarker = ThisMarker;
	sh	$4,22($9)	 # ThisMarker, AIPathfinder[i_533(D)].NearestMarker
 # BattleBots/BattleBotAI.c:523:                                 AIPathfinder[i].NearestMarkerHeight = (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1];
	lw	$2,0($6)		 # *_153, *_153
	addu	$5,$2,$5	 # tmp1270, *_153, _372
 # BattleBots/BattleBotAI.c:523:                                 AIPathfinder[i].NearestMarkerHeight = (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1];
	lh	$2,2($5)		 # _200->Position, _200->Position
	mtc1	$2,$f2	 # _200->Position, _200->Position
	nop	
	cvt.s.w	$f2,$f2	 # tmp1272, _200->Position
	swc1	$f2,24($9)	 # tmp1272, AIPathfinder[i_533(D)].NearestMarkerHeight
 # BattleBots/BattleBotAI.c:521:                                 CheckMarkerDistance = GlobalFloatA;
	b	$L127	 #
	mov.s	$f2,$f0	 # CheckMarkerDistance, _195

$L195:
 # BattleBots/BattleBotAI.c:540:         loadFont();
	jal	loadFont	 #
	lui	$22,%hi($LC17)	 # tmp1277,

 # BattleBots/BattleBotAI.c:542:         printStringUnsignedHex(0, 120, "Target[0]", (uint)&AIPathfinder[i]);
	lui	$7,%hi(AIPathfinder+32)	 # tmp1276,
	addiu	$7,$7,%lo(AIPathfinder+32)	 #, tmp1276,
	addiu	$6,$22,%lo($LC17)	 #, tmp1277,
	li	$5,120			# 0x78	 #,
	jal	printStringUnsignedHex	 #
	move	$4,$0	 #,

 # BattleBots/BattleBotAI.c:543:         printStringNumber(0, 130, "Target[0]", AIPathfinder[i].Target[0]);
	lui	$21,%hi(AIPathfinder)	 # tmp1278,
	addiu	$21,$21,%lo(AIPathfinder)	 # tmp1279, tmp1278,
 # BattleBots/BattleBotAI.c:543:         printStringNumber(0, 130, "Target[0]", AIPathfinder[i].Target[0]);
	lwc1	$f0,40($21)	 # AIPathfinder[1].Target, AIPathfinder[1].Target
	trunc.w.s $f0,$f0	 # tmp2325, AIPathfinder[1].Target
	mfc1	$7,$f0	 #, tmp2325
	addiu	$6,$22,%lo($LC17)	 #, tmp1277,
	li	$5,130			# 0x82	 #,
	jal	printStringNumber	 #
	move	$4,$0	 #,

 # BattleBots/BattleBotAI.c:544:         printStringNumber(0, 140, "Target[1]", AIPathfinder[i].Target[1]);
	lwc1	$f0,44($21)	 # AIPathfinder[1].Target, AIPathfinder[1].Target
	trunc.w.s $f0,$f0	 # tmp2326, AIPathfinder[1].Target
	mfc1	$7,$f0	 #, tmp2326
	lui	$6,%hi($LC18)	 # tmp1287,
	addiu	$6,$6,%lo($LC18)	 #, tmp1287,
	li	$5,140			# 0x8c	 #,
	jal	printStringNumber	 #
	move	$4,$0	 #,

 # BattleBots/BattleBotAI.c:545:         printStringNumber(0, 150, "Target[2]", AIPathfinder[i].Target[2]);
	lwc1	$f0,48($21)	 # AIPathfinder[1].Target, AIPathfinder[1].Target
	trunc.w.s $f0,$f0	 # tmp2327, AIPathfinder[1].Target
	mfc1	$7,$f0	 #, tmp2327
	lui	$6,%hi($LC19)	 # tmp1292,
	addiu	$6,$6,%lo($LC19)	 #, tmp1292,
	li	$5,150			# 0x96	 #,
	jal	printStringNumber	 #
	move	$4,$0	 #,

 # BattleBots/BattleBotAI.c:546:         printStringNumber(0, 160, "Progression",  AIPathfinder[i].Progression);
	lh	$7,52($21)		 #, AIPathfinder[1].Progression
	lui	$6,%hi($LC20)	 # tmp1296,
	addiu	$6,$6,%lo($LC20)	 #, tmp1296,
	li	$5,160			# 0xa0	 #,
	jal	printStringNumber	 #
	move	$4,$0	 #,

 # BattleBots/BattleBotAI.c:547:         printStringNumber(0, 170, "Nearest",  AIPathfinder[i].NearestMarker);
	lh	$7,54($21)		 #, AIPathfinder[1].NearestMarker
	lui	$6,%hi($LC21)	 # tmp1300,
	addiu	$6,$6,%lo($LC21)	 #, tmp1300,
	li	$5,170			# 0xaa	 #,
	jal	printStringNumber	 #
	move	$4,$0	 #,

 # BattleBots/BattleBotAI.c:548:         printStringNumber(0, 180, "Direction",  AIPathfinder[i].Direction);
	lb	$7,62($21)		 #, AIPathfinder[1].Direction
	lui	$6,%hi($LC22)	 # tmp1304,
	addiu	$6,$6,%lo($LC22)	 #, tmp1304,
	li	$5,180			# 0xb4	 #,
	jal	printStringNumber	 #
	move	$4,$0	 #,

 # BattleBots/BattleBotAI.c:549:         printStringNumber(0, 190, "PathType",  AIPathfinder[i].PathType);
	lb	$7,63($21)		 #, AIPathfinder[1].PathType
	lui	$6,%hi($LC23)	 # tmp1308,
	addiu	$6,$6,%lo($LC23)	 #, tmp1308,
	li	$5,190			# 0xbe	 #,
	jal	printStringNumber	 #
	move	$4,$0	 #,

 # BattleBots/BattleBotAI.c:550:         printStringNumber(0, 200, "TargetPath",  AIPathfinder[i].TargetPath);
	lh	$7,32($21)		 #, AIPathfinder[1].TargetPath
	lui	$6,%hi($LC24)	 # tmp1312,
	addiu	$6,$6,%lo($LC24)	 #, tmp1312,
	li	$5,200			# 0xc8	 #,
	jal	printStringNumber	 #
	move	$4,$0	 #,

 # BattleBots/BattleBotAI.c:552:         printStringNumber(140, 120, "ixbox x", nearest_item_box[1][0]);
	lui	$21,%hi(nearest_item_box)	 # tmp1313,
	addiu	$21,$21,%lo(nearest_item_box)	 # tmp1314, tmp1313,
 # BattleBots/BattleBotAI.c:552:         printStringNumber(140, 120, "ixbox x", nearest_item_box[1][0]);
	lwc1	$f0,12($21)	 # nearest_item_box, nearest_item_box
	trunc.w.s $f0,$f0	 # tmp2328, nearest_item_box
	mfc1	$7,$f0	 #, tmp2328
	lui	$6,%hi($LC25)	 # tmp1317,
	addiu	$6,$6,%lo($LC25)	 #, tmp1317,
	li	$5,120			# 0x78	 #,
	jal	printStringNumber	 #
	li	$4,140			# 0x8c	 #,

 # BattleBots/BattleBotAI.c:553:         printStringNumber(140, 130, "ixbox y", nearest_item_box[1][1]);
	lwc1	$f0,16($21)	 # nearest_item_box, nearest_item_box
	trunc.w.s $f0,$f0	 # tmp2329, nearest_item_box
	mfc1	$7,$f0	 #, tmp2329
	lui	$6,%hi($LC26)	 # tmp1322,
	addiu	$6,$6,%lo($LC26)	 #, tmp1322,
	li	$5,130			# 0x82	 #,
	jal	printStringNumber	 #
	li	$4,140			# 0x8c	 #,

 # BattleBots/BattleBotAI.c:554:         printStringNumber(140, 140, "ixbox z", nearest_item_box[1][2]);
	lwc1	$f0,20($21)	 # nearest_item_box, nearest_item_box
	trunc.w.s $f0,$f0	 # tmp2330, nearest_item_box
	mfc1	$7,$f0	 #, tmp2330
	lui	$6,%hi($LC27)	 # tmp1327,
	addiu	$6,$6,%lo($LC27)	 #, tmp1327,
	li	$5,140			# 0x8c	 #,
	jal	printStringNumber	 #
	li	$4,140			# 0x8c	 #,

 # BattleBots/BattleBotAI.c:555:         printStringNumber(140, 150, "ixbox count", ItemBoxCount);
	lui	$2,%hi(ItemBoxCount)	 # tmp1328,
	lh	$7,%lo(ItemBoxCount)($2)		 #, ItemBoxCount
	lui	$6,%hi($LC28)	 # tmp1330,
	addiu	$6,$6,%lo($LC28)	 #, tmp1330,
	li	$5,150			# 0x96	 #,
	jal	printStringNumber	 #
	li	$4,140			# 0x8c	 #,

 # BattleBots/BattleBotAI.c:557:         printStringNumber(140, 160, "bot x", bot_x);
	trunc.w.s $f0,$f26	 # tmp2331, bot_x
	mfc1	$7,$f0	 #, tmp2331
	lui	$6,%hi($LC29)	 # tmp1332,
	addiu	$6,$6,%lo($LC29)	 #, tmp1332,
	li	$5,160			# 0xa0	 #,
	jal	printStringNumber	 #
	li	$4,140			# 0x8c	 #,

 # BattleBots/BattleBotAI.c:558:         printStringNumber(140, 170, "bot y", bot_y);
	trunc.w.s $f0,$f22	 # tmp2332, bot_y
	mfc1	$7,$f0	 #, tmp2332
	lui	$6,%hi($LC30)	 # tmp1334,
	addiu	$6,$6,%lo($LC30)	 #, tmp1334,
	li	$5,170			# 0xaa	 #,
	jal	printStringNumber	 #
	li	$4,140			# 0x8c	 #,

 # BattleBots/BattleBotAI.c:559:         printStringNumber(140, 180, "bot z", bot_z);
	trunc.w.s $f0,$f24	 # tmp2333, bot_z
	mfc1	$7,$f0	 #, tmp2333
	lui	$6,%hi($LC31)	 # tmp1336,
	addiu	$6,$6,%lo($LC31)	 #, tmp1336,
	li	$5,180			# 0xb4	 #,
	jal	printStringNumber	 #
	li	$4,140			# 0x8c	 #,

 # BattleBots/BattleBotAI.c:560:         printStringNumber(140, 190, "Rival", bot_rival_p1[i]);
	lui	$2,%hi(bot_rival_p1+1)	 # tmp1338,
	lbu	$7,%lo(bot_rival_p1+1)($2)	 #, bot_rival_p1
	lui	$6,%hi($LC32)	 # tmp1340,
	addiu	$6,$6,%lo($LC32)	 #, tmp1340,
	li	$5,190			# 0xbe	 #,
	jal	printStringNumber	 #
	li	$4,140			# 0x8c	 #,

 # BattleBots/BattleBotAI.c:567:     if (TargetPath != -1) //If bot has NOT fallen
	b	$L201	 #
	li	$2,-1			# 0xffffffffffffffff	 # tmp1341,

$L133:
 # BattleBots/BattleBotAI.c:585:             if (CoursePathLengths[ci][TargetPath]-AIPathfinder[i].Progression <= 4)
	sll	$2,$17,2	 # tmp1359, _3,
	lui	$4,%hi(CoursePathLengths)	 # tmp1358,
	addiu	$4,$4,%lo(CoursePathLengths)	 # tmp1361, tmp1358,
	addu	$2,$2,$4	 # tmp1360, tmp1359, tmp1361
 # BattleBots/BattleBotAI.c:585:             if (CoursePathLengths[ci][TargetPath]-AIPathfinder[i].Progression <= 4)
	lw	$2,0($2)		 # tmp1362, CoursePathLengths
	sll	$4,$20,1	 # tmp1363, TargetPath,
	addu	$2,$2,$4	 # tmp1364, tmp1362, tmp1363
	lh	$2,0($2)		 # *_243, *_243
 # BattleBots/BattleBotAI.c:585:             if (CoursePathLengths[ci][TargetPath]-AIPathfinder[i].Progression <= 4)
	lui	$5,%hi(AIPathfinder)	 # tmp1366,
	sll	$4,$16,5	 # tmp1369, i,
	addiu	$5,$5,%lo(AIPathfinder)	 # tmp1367, tmp1366,
	addu	$4,$5,$4	 # tmp1368, tmp1367, tmp1369
	lh	$4,20($4)		 # AIPathfinder[i_533(D)].Progression, AIPathfinder[i_533(D)].Progression
 # BattleBots/BattleBotAI.c:585:             if (CoursePathLengths[ci][TargetPath]-AIPathfinder[i].Progression <= 4)
	subu	$2,$2,$4	 # tmp1371, *_243, AIPathfinder[i_533(D)].Progression
 # BattleBots/BattleBotAI.c:585:             if (CoursePathLengths[ci][TargetPath]-AIPathfinder[i].Progression <= 4)
	slt	$2,$2,5	 # tmp1372, tmp1371,
	beq	$2,$0,$L205	 #, tmp1372,,
	lui	$4,%hi(AIPathfinder)	 # tmp1376,

 # BattleBots/BattleBotAI.c:587:                 GlobalFloatA = 3200.0;
	lui	$4,%hi($LC34)	 # tmp1374,
	lui	$2,%hi(GlobalFloatA)	 # tmp1373,
	lwc1	$f0,%lo($LC34)($4)	 # tmp1375,
	b	$L134	 #
	swc1	$f0,%lo(GlobalFloatA)($2)	 # tmp1375, GlobalFloatA

$L196:
 # BattleBots/BattleBotAI.c:596:                 objectPosition[0] = (float)CoursePaths[ci][TargetPath][Progression].Position[0];
	addiu	$6,$6,%lo(CoursePaths)	 # tmp1389, tmp1386,
	addu	$6,$5,$6	 # tmp1388, tmp1387, tmp1389
 # BattleBots/BattleBotAI.c:596:                 objectPosition[0] = (float)CoursePaths[ci][TargetPath][Progression].Position[0];
	sll	$8,$20,2	 # tmp1390, TargetPath,
	lw	$6,0($6)		 # tmp1391, CoursePaths
	addu	$8,$6,$8	 # _253, tmp1391, tmp1390
 # BattleBots/BattleBotAI.c:596:                 objectPosition[0] = (float)CoursePaths[ci][TargetPath][Progression].Position[0];
	sll	$7,$4,3	 # _256, Progression,
 # BattleBots/BattleBotAI.c:596:                 objectPosition[0] = (float)CoursePaths[ci][TargetPath][Progression].Position[0];
	lui	$6,%hi(objectPosition)	 # tmp1392,
 # BattleBots/BattleBotAI.c:596:                 objectPosition[0] = (float)CoursePaths[ci][TargetPath][Progression].Position[0];
	lw	$9,0($8)		 # *_253, *_253
	addu	$9,$9,$7	 # tmp1394, *_253, _256
 # BattleBots/BattleBotAI.c:596:                 objectPosition[0] = (float)CoursePaths[ci][TargetPath][Progression].Position[0];
	lh	$9,0($9)		 # _257->Position, _257->Position
	mtc1	$9,$f0	 # _257->Position, _257->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1396, _257->Position
	swc1	$f0,%lo(objectPosition)($6)	 # tmp1396, objectPosition
 # BattleBots/BattleBotAI.c:597:                 objectPosition[1] = (float)CoursePaths[ci][TargetPath][Progression].Position[1];
	addiu	$6,$6,%lo(objectPosition)	 # tmp1398, tmp1392,
 # BattleBots/BattleBotAI.c:597:                 objectPosition[1] = (float)CoursePaths[ci][TargetPath][Progression].Position[1];
	lw	$9,0($8)		 # *_253, *_253
	addu	$9,$9,$7	 # tmp1400, *_253, _256
 # BattleBots/BattleBotAI.c:597:                 objectPosition[1] = (float)CoursePaths[ci][TargetPath][Progression].Position[1];
	lh	$9,2($9)		 # _261->Position, _261->Position
	mtc1	$9,$f0	 # _261->Position, _261->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1402, _261->Position
	swc1	$f0,4($6)	 # tmp1402, objectPosition
 # BattleBots/BattleBotAI.c:598:                 objectPosition[2] = (float)CoursePaths[ci][TargetPath][Progression].Position[2]; 
	lw	$8,0($8)		 # *_253, *_253
	addu	$7,$8,$7	 # tmp1406, *_253, _256
 # BattleBots/BattleBotAI.c:598:                 objectPosition[2] = (float)CoursePaths[ci][TargetPath][Progression].Position[2]; 
	lh	$7,4($7)		 # _265->Position, _265->Position
	mtc1	$7,$f0	 # _265->Position, _265->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1408, _265->Position
	swc1	$f0,8($6)	 # tmp1408, objectPosition
 # BattleBots/BattleBotAI.c:599:                 GlobalIntA = CoursePathLengths[ci][TargetPath];
	lui	$6,%hi(CoursePathLengths)	 # tmp1410,
	addiu	$6,$6,%lo(CoursePathLengths)	 # tmp1413, tmp1410,
	addu	$5,$5,$6	 # tmp1412, tmp1387, tmp1413
 # BattleBots/BattleBotAI.c:599:                 GlobalIntA = CoursePathLengths[ci][TargetPath];
	lw	$5,0($5)		 # tmp1414, CoursePathLengths
	sll	$6,$20,1	 # tmp1415, TargetPath,
	addu	$5,$5,$6	 # tmp1416, tmp1414, tmp1415
	lh	$6,0($5)		 # *_270, *_270
	lui	$5,%hi(GlobalIntA)	 # tmp1409,
 # BattleBots/BattleBotAI.c:600:                 break;
	b	$L137	 #
	sw	$6,%lo(GlobalIntA)($5)	 # *_270, GlobalIntA

$L135:
 # BattleBots/BattleBotAI.c:602:                 objectPosition[0] = (float)CourseRamps[ci][TargetPath][Progression].Position[0];
	sll	$5,$17,2	 # tmp1419, _3,
	lui	$6,%hi(CourseRamps)	 # tmp1418,
	addiu	$6,$6,%lo(CourseRamps)	 # tmp1421, tmp1418,
	addu	$6,$5,$6	 # tmp1420, tmp1419, tmp1421
 # BattleBots/BattleBotAI.c:602:                 objectPosition[0] = (float)CourseRamps[ci][TargetPath][Progression].Position[0];
	sll	$8,$20,2	 # tmp1422, TargetPath,
	lw	$6,0($6)		 # tmp1423, CourseRamps
	addu	$8,$6,$8	 # _276, tmp1423, tmp1422
 # BattleBots/BattleBotAI.c:602:                 objectPosition[0] = (float)CourseRamps[ci][TargetPath][Progression].Position[0];
	sll	$7,$4,3	 # _279, Progression,
 # BattleBots/BattleBotAI.c:602:                 objectPosition[0] = (float)CourseRamps[ci][TargetPath][Progression].Position[0];
	lui	$6,%hi(objectPosition)	 # tmp1424,
 # BattleBots/BattleBotAI.c:602:                 objectPosition[0] = (float)CourseRamps[ci][TargetPath][Progression].Position[0];
	lw	$9,0($8)		 # *_276, *_276
	addu	$9,$9,$7	 # tmp1426, *_276, _279
 # BattleBots/BattleBotAI.c:602:                 objectPosition[0] = (float)CourseRamps[ci][TargetPath][Progression].Position[0];
	lh	$9,0($9)		 # _280->Position, _280->Position
	mtc1	$9,$f0	 # _280->Position, _280->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1428, _280->Position
	swc1	$f0,%lo(objectPosition)($6)	 # tmp1428, objectPosition
 # BattleBots/BattleBotAI.c:603:                 objectPosition[1] = (float)CourseRamps[ci][TargetPath][Progression].Position[1];
	addiu	$6,$6,%lo(objectPosition)	 # tmp1430, tmp1424,
 # BattleBots/BattleBotAI.c:603:                 objectPosition[1] = (float)CourseRamps[ci][TargetPath][Progression].Position[1];
	lw	$9,0($8)		 # *_276, *_276
	addu	$9,$9,$7	 # tmp1432, *_276, _279
 # BattleBots/BattleBotAI.c:603:                 objectPosition[1] = (float)CourseRamps[ci][TargetPath][Progression].Position[1];
	lh	$9,2($9)		 # _284->Position, _284->Position
	mtc1	$9,$f0	 # _284->Position, _284->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1434, _284->Position
	swc1	$f0,4($6)	 # tmp1434, objectPosition
 # BattleBots/BattleBotAI.c:604:                 objectPosition[2] = (float)CourseRamps[ci][TargetPath][Progression].Position[2]; 
	lw	$8,0($8)		 # *_276, *_276
	addu	$7,$8,$7	 # tmp1438, *_276, _279
 # BattleBots/BattleBotAI.c:604:                 objectPosition[2] = (float)CourseRamps[ci][TargetPath][Progression].Position[2]; 
	lh	$7,4($7)		 # _288->Position, _288->Position
	mtc1	$7,$f0	 # _288->Position, _288->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1440, _288->Position
	swc1	$f0,8($6)	 # tmp1440, objectPosition
 # BattleBots/BattleBotAI.c:605:                 GlobalIntA = CourseRampLengths[ci][TargetPath];
	lui	$6,%hi(CourseRampLengths)	 # tmp1442,
	addiu	$6,$6,%lo(CourseRampLengths)	 # tmp1445, tmp1442,
	addu	$5,$5,$6	 # tmp1444, tmp1419, tmp1445
 # BattleBots/BattleBotAI.c:605:                 GlobalIntA = CourseRampLengths[ci][TargetPath];
	lw	$5,0($5)		 # tmp1446, CourseRampLengths
	sll	$6,$20,1	 # tmp1447, TargetPath,
	addu	$5,$5,$6	 # tmp1448, tmp1446, tmp1447
	lh	$6,0($5)		 # *_293, *_293
	lui	$5,%hi(GlobalIntA)	 # tmp1441,
 # BattleBots/BattleBotAI.c:606:                 break;
	b	$L137	 #
	sw	$6,%lo(GlobalIntA)($5)	 # *_293, GlobalIntA

$L136:
 # BattleBots/BattleBotAI.c:608:                 objectPosition[0] = (float)CourseDrops[ci][TargetPath][Progression].Position[0];
	lui	$6,%hi(CourseDrops)	 # tmp1450,
	addiu	$6,$6,%lo(CourseDrops)	 # tmp1453, tmp1450,
	addu	$6,$5,$6	 # tmp1452, tmp1451, tmp1453
 # BattleBots/BattleBotAI.c:608:                 objectPosition[0] = (float)CourseDrops[ci][TargetPath][Progression].Position[0];
	sll	$8,$20,2	 # tmp1454, TargetPath,
	lw	$6,0($6)		 # tmp1455, CourseDrops
	addu	$8,$6,$8	 # _299, tmp1455, tmp1454
 # BattleBots/BattleBotAI.c:608:                 objectPosition[0] = (float)CourseDrops[ci][TargetPath][Progression].Position[0];
	sll	$7,$4,3	 # _302, Progression,
 # BattleBots/BattleBotAI.c:608:                 objectPosition[0] = (float)CourseDrops[ci][TargetPath][Progression].Position[0];
	lui	$6,%hi(objectPosition)	 # tmp1456,
 # BattleBots/BattleBotAI.c:608:                 objectPosition[0] = (float)CourseDrops[ci][TargetPath][Progression].Position[0];
	lw	$9,0($8)		 # *_299, *_299
	addu	$9,$9,$7	 # tmp1458, *_299, _302
 # BattleBots/BattleBotAI.c:608:                 objectPosition[0] = (float)CourseDrops[ci][TargetPath][Progression].Position[0];
	lh	$9,0($9)		 # _303->Position, _303->Position
	mtc1	$9,$f0	 # _303->Position, _303->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1460, _303->Position
	swc1	$f0,%lo(objectPosition)($6)	 # tmp1460, objectPosition
 # BattleBots/BattleBotAI.c:609:                 objectPosition[1] = (float)CourseDrops[ci][TargetPath][Progression].Position[1];
	addiu	$6,$6,%lo(objectPosition)	 # tmp1462, tmp1456,
 # BattleBots/BattleBotAI.c:609:                 objectPosition[1] = (float)CourseDrops[ci][TargetPath][Progression].Position[1];
	lw	$9,0($8)		 # *_299, *_299
	addu	$9,$9,$7	 # tmp1464, *_299, _302
 # BattleBots/BattleBotAI.c:609:                 objectPosition[1] = (float)CourseDrops[ci][TargetPath][Progression].Position[1];
	lh	$9,2($9)		 # _307->Position, _307->Position
	mtc1	$9,$f0	 # _307->Position, _307->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1466, _307->Position
	swc1	$f0,4($6)	 # tmp1466, objectPosition
 # BattleBots/BattleBotAI.c:610:                 objectPosition[2] = (float)CourseDrops[ci][TargetPath][Progression].Position[2]; 
	lw	$8,0($8)		 # *_299, *_299
	addu	$7,$8,$7	 # tmp1470, *_299, _302
 # BattleBots/BattleBotAI.c:610:                 objectPosition[2] = (float)CourseDrops[ci][TargetPath][Progression].Position[2]; 
	lh	$7,4($7)		 # _311->Position, _311->Position
	mtc1	$7,$f0	 # _311->Position, _311->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1472, _311->Position
	swc1	$f0,8($6)	 # tmp1472, objectPosition
 # BattleBots/BattleBotAI.c:611:                 GlobalIntA = CourseDropLengths[ci][TargetPath];
	lui	$6,%hi(CourseDropLengths)	 # tmp1474,
	addiu	$6,$6,%lo(CourseDropLengths)	 # tmp1477, tmp1474,
	addu	$5,$5,$6	 # tmp1476, tmp1451, tmp1477
 # BattleBots/BattleBotAI.c:611:                 GlobalIntA = CourseDropLengths[ci][TargetPath];
	lw	$5,0($5)		 # tmp1478, CourseDropLengths
	sll	$6,$20,1	 # tmp1479, TargetPath,
	addu	$5,$5,$6	 # tmp1480, tmp1478, tmp1479
	lh	$6,0($5)		 # *_316, *_316
	lui	$5,%hi(GlobalIntA)	 # tmp1473,
 # BattleBots/BattleBotAI.c:612:                 break;
	b	$L137	 #
	sw	$6,%lo(GlobalIntA)($5)	 # *_316, GlobalIntA

$L185:
 # BattleBots/BattleBotAI.c:622:             AIPathfinder[i].ProgressTimer++;
	sll	$4,$16,5	 # tmp1515, i,
	addiu	$5,$5,%lo(AIPathfinder)	 # tmp1513, tmp1512,
	addu	$4,$5,$4	 # tmp1514, tmp1513, tmp1515
	lhu	$5,28($4)	 #, AIPathfinder[i_533(D)].ProgressTimer
	addiu	$5,$5,1	 # tmp1521, AIPathfinder[i_533(D)].ProgressTimer,
	b	$L140	 #
	sh	$5,28($4)	 # tmp1521, AIPathfinder[i_533(D)].ProgressTimer

$L142:
 # BattleBots/BattleBotAI.c:642:             if (AIPathfinder[i].NearestMarker < AIPathfinder[i].Progression)
	sll	$3,$16,5	 # tmp1550, i,
	addiu	$4,$4,%lo(AIPathfinder)	 # tmp1548, tmp1547,
	addu	$3,$4,$3	 # tmp1549, tmp1548, tmp1550
	lh	$5,22($3)		 # _352, AIPathfinder[i_533(D)].NearestMarker
 # BattleBots/BattleBotAI.c:642:             if (AIPathfinder[i].NearestMarker < AIPathfinder[i].Progression)
	lh	$3,20($3)		 # AIPathfinder[i_533(D)].Progression, AIPathfinder[i_533(D)].Progression
	slt	$3,$5,$3	 # tmp1556, _352, AIPathfinder[i_533(D)].Progression
	beq	$3,$0,$L206	 #, tmp1556,,
	li	$3,1			# 0x1	 # tmp1582,

 # BattleBots/BattleBotAI.c:644:                 AIPathfinder[i].Progression = AIPathfinder[i].NearestMarker;
	lui	$4,%hi(AIPathfinder)	 # tmp1557,
	sll	$3,$16,5	 # tmp1560, i,
	addiu	$4,$4,%lo(AIPathfinder)	 # tmp1558, tmp1557,
	addu	$3,$4,$3	 # tmp1559, tmp1558, tmp1560
	b	$L143	 #
	sh	$5,20($3)	 # _352, AIPathfinder[i_533(D)].Progression

$L132:
 # BattleBots/BattleBotAI.c:652:             nearest_item_box[i][j] = 0.0;
	sll	$2,$16,1	 # tmp1563, i,
	addu	$3,$2,$16	 # tmp1564, tmp1563, i
	sll	$3,$3,2	 # tmp1565, tmp1564,
	lui	$4,%hi(nearest_item_box)	 # tmp1561,
	addiu	$4,$4,%lo(nearest_item_box)	 # tmp1567, tmp1561,
	addu	$3,$3,$4	 # tmp1566, tmp1565, tmp1567
	sw	$0,0($3)	 #, nearest_item_box
	sw	$0,4($3)	 #, nearest_item_box
	b	$L101	 #
	sw	$0,8($3)	 #, nearest_item_box

$L197:
 # BattleBots/BattleBotAI.c:666:             if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
	lui	$4,%hi(CourseDropLengths)	 # tmp1584,
	addiu	$4,$4,%lo(CourseDropLengths)	 # tmp1587, tmp1584,
	addu	$4,$2,$4	 # tmp1586, tmp1585, tmp1587
	lui	$3,%hi(CourseRampLengths)	 # tmp1589,
	addiu	$3,$3,%lo(CourseRampLengths)	 # tmp1592, tmp1589,
	addu	$3,$2,$3	 # tmp1591, tmp1585, tmp1592
	lui	$5,%hi(CoursePathLengths)	 # tmp1594,
	addiu	$5,$5,%lo(CoursePathLengths)	 # tmp1597, tmp1594,
	addu	$2,$2,$5	 # tmp1596, tmp1585, tmp1597
	lw	$7,0($4)		 #, CourseDropLengths
	lw	$6,0($3)		 #, CourseRampLengths
	lw	$5,0($2)		 #, CoursePathLengths
	jal	PathfinderComplete	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:666:             if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
	beq	$2,$0,$L202	 #, tmp2224,,
	sll	$2,$16,3	 # tmp2110, i,

 # BattleBots/BattleBotAI.c:662:     float diff_y = rival_y - bot_y;
	sub.s	$f0,$f20,$f22	 # diff_y, rival_y, bot_y
 # BattleBots/BattleBotAI.c:675:                 if (diff_y >= 15.0 && LineCounts[ci][1] > 0) //If target is above bot and ramps exist, look for ramps
	lui	$2,%hi($LC35)	 # tmp1601,
	lwc1	$f2,%lo($LC35)($2)	 # tmp1600,
	c.le.s	$f2,$f0	 #, tmp1600, diff_y
	nop	
	bc1f	$L186	 #,,
	lui	$2,%hi($LC37)	 # tmp1725,

 # BattleBots/BattleBotAI.c:675:                 if (diff_y >= 15.0 && LineCounts[ci][1] > 0) //If target is above bot and ramps exist, look for ramps
	sll	$2,$17,2	 # tmp1603, _3,
	lui	$3,%hi(LineCounts)	 # tmp1602,
	addiu	$3,$3,%lo(LineCounts)	 # tmp1605, tmp1602,
	addu	$2,$2,$3	 # tmp1604, tmp1603, tmp1605
	lw	$3,0($2)		 # _390, LineCounts
 # BattleBots/BattleBotAI.c:675:                 if (diff_y >= 15.0 && LineCounts[ci][1] > 0) //If target is above bot and ramps exist, look for ramps
	lh	$2,2($3)		 # MEM[(short int *)_359 + 2B], MEM[(short int *)_359 + 2B]
	bgtz	$2,$L199	 #, MEM[(short int *)_359 + 2B],
	lui	$2,%hi($LC37)	 # tmp2167,

 # BattleBots/BattleBotAI.c:712:                 else if (diff_y <= -15.0 && (LineCounts[ci][1] > 0 || LineCounts[ci][2] > 0)) //If target is below bot and ramps or drops exist, look for ramps and drops
	lwc1	$f2,%lo($LC37)($2)	 # tmp2166,
	c.le.s	$f0,$f2	 #, diff_y, tmp2166
	nop	
	bc1f	$L212	 #,,
	sll	$2,$16,5	 # tmp1992, i,

 # BattleBots/BattleBotAI.c:712:                 else if (diff_y <= -15.0 && (LineCounts[ci][1] > 0 || LineCounts[ci][2] > 0)) //If target is below bot and ramps or drops exist, look for ramps and drops
	lh	$2,4($3)		 # MEM[(short int *)_518 + 4B], MEM[(short int *)_518 + 4B]
$L214:
	bgtzl	$2,$L213	 #, MEM[(short int *)_518 + 4B],
	sw	$0,44($sp)	 #, rampNodePosition

$L155:
 # BattleBots/BattleBotAI.c:794:                     AIPathfinder[i].Target[0] = rival_x;
	sll	$2,$16,5	 # tmp1992, i,
$L212:
	lui	$3,%hi(AIPathfinder)	 # tmp1990,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp1993, tmp1990,
	addu	$2,$2,$3	 # tmp1991, tmp1992, tmp1993
	swc1	$f28,8($2)	 # rival_x, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:795:                     AIPathfinder[i].Target[1] = rival_y;
	swc1	$f20,12($2)	 # rival_y, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:796:                     AIPathfinder[i].Target[2] = rival_z;
	swc1	$f30,16($2)	 # rival_z, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:797:                     UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);
	sll	$2,$17,2	 # tmp2003, _3,
	lui	$4,%hi(CoursePathLengths)	 # tmp2002,
	addiu	$4,$4,%lo(CoursePathLengths)	 # tmp2005, tmp2002,
	addu	$4,$2,$4	 # tmp2004, tmp2003, tmp2005
	lui	$3,%hi(CoursePaths)	 # tmp2007,
	addiu	$3,$3,%lo(CoursePaths)	 # tmp2010, tmp2007,
	addu	$3,$2,$3	 # tmp2009, tmp2003, tmp2010
	sw	$0,24($sp)	 #,
	sll	$5,$16,16	 # i, i,
	sra	$5,$5,16	 # i, i,
	sw	$5,20($sp)	 # i,
 # BattleBots/BattleBotAI.c:797:                     UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);
	lui	$5,%hi(LineCounts)	 # tmp2013,
	addiu	$5,$5,%lo(LineCounts)	 # tmp2016, tmp2013,
	addu	$2,$2,$5	 # tmp2015, tmp2003, tmp2016
 # BattleBots/BattleBotAI.c:797:                     UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);
	lw	$2,0($2)		 # tmp2017, LineCounts
	lh	$2,0($2)		 # *_466, *_466
	sw	$2,16($sp)	 # *_466,
	lw	$7,0($4)		 #, CoursePathLengths
	lw	$6,0($3)		 #, CoursePaths
	li	$5,350			# 0x15e	 #,
	jal	UpdateBKPath	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	b	$L202	 #
	sll	$2,$16,3	 # tmp2110, i,

$L199:
 # BattleBots/BattleBotAI.c:677:                     float nodePosition[] = {0.,0.,0.};
	sw	$0,32($sp)	 #, MEM[(float[3] *)_48]
	sw	$0,36($sp)	 #, MEM[(float[3] *)_48]
	sw	$0,40($sp)	 #, MEM[(float[3] *)_48]
 # BattleBots/BattleBotAI.c:680:                     ramp_path_index = FindNearestRampNode(GlobalPlayer[i].position, nodePosition, rival_y, CourseRamps[ci], CourseRampLengths[ci], LineCounts[ci][1]);
	sll	$4,$17,2	 # tmp1608, _3,
	lui	$5,%hi(CourseRamps)	 # tmp1607,
	addiu	$5,$5,%lo(CourseRamps)	 # tmp1610, tmp1607,
	addu	$5,$4,$5	 # tmp1609, tmp1608, tmp1610
 # BattleBots/BattleBotAI.c:680:                     ramp_path_index = FindNearestRampNode(GlobalPlayer[i].position, nodePosition, rival_y, CourseRamps[ci], CourseRampLengths[ci], LineCounts[ci][1]);
	sll	$2,$16,3	 # tmp1613, i,
	subu	$2,$2,$16	 # tmp1614, tmp1613, i
	sll	$2,$2,4	 # tmp1615, tmp1614,
	subu	$2,$2,$16	 # tmp1616, tmp1615, i
	sll	$2,$2,2	 # tmp1617, tmp1616,
	subu	$2,$2,$16	 # tmp1618, tmp1617, i
	sll	$2,$2,3	 # tmp1619, tmp1618,
	addiu	$2,$2,20	 # tmp1620, tmp1619,
 # BattleBots/BattleBotAI.c:680:                     ramp_path_index = FindNearestRampNode(GlobalPlayer[i].position, nodePosition, rival_y, CourseRamps[ci], CourseRampLengths[ci], LineCounts[ci][1]);
	lh	$3,2($3)		 # MEM[(short int *)_359 + 2B], MEM[(short int *)_359 + 2B]
	sw	$3,20($sp)	 # MEM[(short int *)_359 + 2B],
	lui	$3,%hi(CourseRampLengths)	 # tmp1625,
	addiu	$3,$3,%lo(CourseRampLengths)	 # tmp1628, tmp1625,
	addu	$4,$4,$3	 # tmp1627, tmp1608, tmp1628
	lw	$3,0($4)		 # tmp1629, CourseRampLengths
	sw	$3,16($sp)	 # tmp1629,
	lw	$7,0($5)		 #, CourseRamps
	mfc1	$6,$f20	 #, rival_y
	addiu	$5,$sp,32	 #,,
	lui	$4,%hi(GlobalPlayer)	 # tmp1622,
	addiu	$4,$4,%lo(GlobalPlayer)	 # tmp1621, tmp1622,
	jal	FindNearestRampNode	 #
	addu	$4,$4,$2	 #, tmp1621, tmp1620

 # BattleBots/BattleBotAI.c:684:                     if (ramp_path_index == -1) //If no path is found in the middle of a fall
	li	$3,-1			# 0xffffffffffffffff	 # tmp1630,
	beq	$2,$3,$L101	 #, ramp_path_index, tmp1630,
	lwc1	$f4,32($sp)	 # _365, MEM[(float[3] *)_48]

 # BattleBots/BattleBotAI.c:689:                     if (PythagoreanTheorem(bot_x, nodePosition[0], bot_z, nodePosition[2]) < RAMPDISTANCESQUARE) //If bot is at ramp, use ramp
	sub.s	$f26,$f26,$f4	 # tmp1631, bot_x, _365
	cvt.d.s	$f26,$f26	 # _367, tmp1631
	lwc1	$f2,40($sp)	 # _369, MEM[(float[3] *)_48]
	sub.s	$f0,$f24,$f2	 # tmp1632, bot_z, _369
	cvt.d.s	$f0,$f0	 # _371, tmp1632
	mul.d	$f26,$f26,$f26	 # tmp1633, _367, _367
	mul.d	$f0,$f0,$f0	 # tmp1634, _371, _371
	add.d	$f26,$f26,$f0	 # tmp1635, tmp1633, tmp1634
 # BattleBots/BattleBotAI.c:689:                     if (PythagoreanTheorem(bot_x, nodePosition[0], bot_z, nodePosition[2]) < RAMPDISTANCESQUARE) //If bot is at ramp, use ramp
	lui	$3,%hi($LC36)	 # tmp1637,
	ldc1	$f0,%lo($LC36)($3)	 # tmp1636,
	c.lt.d	$f26,$f0	 #, tmp1635, tmp1636
	nop	
	bc1f	$L187	 #,,
	sll	$3,$16,5	 # tmp1640, i,

 # BattleBots/BattleBotAI.c:691:                         AIPathfinder[i].Target[0] = rival_x;
	lui	$4,%hi(AIPathfinder)	 # tmp1638,
	addiu	$4,$4,%lo(AIPathfinder)	 # tmp1641, tmp1638,
	addu	$3,$3,$4	 # tmp1639, tmp1640, tmp1641
	swc1	$f28,8($3)	 # rival_x, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:692:                         AIPathfinder[i].Target[1] = rival_y;
	swc1	$f20,12($3)	 # rival_y, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:693:                         AIPathfinder[i].Target[2] = rival_z;
	swc1	$f30,16($3)	 # rival_z, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:695:                         AIPathfinder[i].LastPath = TargetPath;
	sh	$20,2($3)	 # TargetPath, AIPathfinder[i_533(D)].LastPath
 # BattleBots/BattleBotAI.c:696:                         AIPathfinder[i].TargetPath = ramp_path_index;
	sh	$2,0($3)	 # ramp_path_index, AIPathfinder[i_533(D)].TargetPath
 # BattleBots/BattleBotAI.c:697:                         AIPathfinder[i].Progression = 0;
	sh	$0,20($3)	 #, AIPathfinder[i_533(D)].Progression
 # BattleBots/BattleBotAI.c:698:                         AIPathfinder[i].Direction = 1;
	li	$4,1			# 0x1	 # tmp1666,
	sb	$4,30($3)	 # tmp1666, AIPathfinder[i_533(D)].Direction
 # BattleBots/BattleBotAI.c:699:                         AIPathfinder[i].PathType = 1;
	sb	$4,31($3)	 # tmp1666, AIPathfinder[i_533(D)].PathType
 # BattleBots/BattleBotAI.c:700:                         AIPathfinder[i].NearestMarker = 0;
	sh	$0,22($3)	 #, AIPathfinder[i_533(D)].NearestMarker
 # BattleBots/BattleBotAI.c:701:                         AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][ramp_path_index][0].Position[1];
	sll	$4,$17,2	 # tmp1681, _3,
	lui	$5,%hi(CourseRamps)	 # tmp1680,
	addiu	$5,$5,%lo(CourseRamps)	 # tmp1683, tmp1680,
	addu	$4,$4,$5	 # tmp1682, tmp1681, tmp1683
 # BattleBots/BattleBotAI.c:701:                         AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][ramp_path_index][0].Position[1];
	lw	$4,0($4)		 # tmp1684, CourseRamps
	sll	$2,$2,2	 # tmp1685, ramp_path_index,
	addu	$2,$4,$2	 # tmp1686, tmp1684, tmp1685
 # BattleBots/BattleBotAI.c:701:                         AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][ramp_path_index][0].Position[1];
	lw	$2,0($2)		 # *_378, *_378
 # BattleBots/BattleBotAI.c:701:                         AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][ramp_path_index][0].Position[1];
	lh	$2,2($2)		 # _379->Position, _379->Position
	mtc1	$2,$f0	 # _379->Position, _379->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1689, _379->Position
	swc1	$f0,24($3)	 # tmp1689, AIPathfinder[i_533(D)].NearestMarkerHeight
	b	$L147	 #
	sh	$0,28($3)	 #, AIPathfinder[i_533(D)].ProgressTimer

$L187:
 # BattleBots/BattleBotAI.c:705:                         AIPathfinder[i].Target[0] = nodePosition[0];
	sll	$2,$16,5	 # tmp1696, i,
	lui	$3,%hi(AIPathfinder)	 # tmp1694,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp1697, tmp1694,
	addu	$2,$2,$3	 # tmp1695, tmp1696, tmp1697
	swc1	$f4,8($2)	 # _365, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:706:                         AIPathfinder[i].Target[1] = nodePosition[1];
	lwc1	$f0,36($sp)	 # MEM[(float[3] *)_48], MEM[(float[3] *)_48]
	swc1	$f0,12($2)	 # MEM[(float[3] *)_48], AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:707:                         AIPathfinder[i].Target[2] = nodePosition[2];
	swc1	$f2,16($2)	 # _369, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:708:                         UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                            
	sll	$2,$17,2	 # tmp1708, _3,
	lui	$4,%hi(CoursePathLengths)	 # tmp1707,
	addiu	$4,$4,%lo(CoursePathLengths)	 # tmp1710, tmp1707,
	addu	$4,$2,$4	 # tmp1709, tmp1708, tmp1710
	lui	$3,%hi(CoursePaths)	 # tmp1712,
	addiu	$3,$3,%lo(CoursePaths)	 # tmp1715, tmp1712,
	addu	$3,$2,$3	 # tmp1714, tmp1708, tmp1715
	sw	$0,24($sp)	 #,
	sll	$5,$16,16	 # i, i,
	sra	$5,$5,16	 # i, i,
	sw	$5,20($sp)	 # i,
 # BattleBots/BattleBotAI.c:708:                         UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                            
	lui	$5,%hi(LineCounts)	 # tmp1718,
	addiu	$5,$5,%lo(LineCounts)	 # tmp1721, tmp1718,
	addu	$2,$2,$5	 # tmp1720, tmp1708, tmp1721
 # BattleBots/BattleBotAI.c:708:                         UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                            
	lw	$2,0($2)		 # tmp1722, LineCounts
	lh	$2,0($2)		 # *_387, *_387
	sw	$2,16($sp)	 # *_387,
	lw	$7,0($4)		 #, CoursePathLengths
	lw	$6,0($3)		 #, CoursePaths
	li	$5,350			# 0x15e	 #,
	jal	UpdateBKPath	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:676:                 {
	b	$L202	 #
	sll	$2,$16,3	 # tmp2110, i,

$L186:
 # BattleBots/BattleBotAI.c:712:                 else if (diff_y <= -15.0 && (LineCounts[ci][1] > 0 || LineCounts[ci][2] > 0)) //If target is below bot and ramps or drops exist, look for ramps and drops
	lwc1	$f2,%lo($LC37)($2)	 # tmp1724,
	c.le.s	$f0,$f2	 #, diff_y, tmp1724
	nop	
	bc1f	$L155	 #,,
	lui	$3,%hi(LineCounts)	 # tmp1726,

 # BattleBots/BattleBotAI.c:712:                 else if (diff_y <= -15.0 && (LineCounts[ci][1] > 0 || LineCounts[ci][2] > 0)) //If target is below bot and ramps or drops exist, look for ramps and drops
	sll	$2,$17,2	 # tmp1727, _3,
	addiu	$3,$3,%lo(LineCounts)	 # tmp1729, tmp1726,
	addu	$2,$2,$3	 # tmp1728, tmp1727, tmp1729
	lw	$3,0($2)		 # _390, LineCounts
 # BattleBots/BattleBotAI.c:712:                 else if (diff_y <= -15.0 && (LineCounts[ci][1] > 0 || LineCounts[ci][2] > 0)) //If target is below bot and ramps or drops exist, look for ramps and drops
	lh	$2,2($3)		 # MEM[(short int *)_390 + 2B], MEM[(short int *)_390 + 2B]
	blezl	$2,$L214	 #, MEM[(short int *)_390 + 2B],
	lh	$2,4($3)		 # MEM[(short int *)_518 + 4B], MEM[(short int *)_518 + 4B]

 # BattleBots/BattleBotAI.c:715:                     float rampNodePosition[] = {0.,0.,0.};
	sw	$0,44($sp)	 #, rampNodePosition
$L213:
	sw	$0,48($sp)	 #, rampNodePosition
	sw	$0,52($sp)	 #, rampNodePosition
 # BattleBots/BattleBotAI.c:716:                     float dropNodePosition[] = {0.,0.,0.};
	sw	$0,32($sp)	 #, MEM[(float[3] *)_48]
	sw	$0,36($sp)	 #, MEM[(float[3] *)_48]
	sw	$0,40($sp)	 #, MEM[(float[3] *)_48]
 # BattleBots/BattleBotAI.c:718:                     int ramp_path_index = FindNearestRampNode(GlobalPlayer[i].position, rampNodePosition, rival_y, CourseRamps[ci], CourseRampLengths[ci], LineCounts[ci][1]);
	sll	$22,$16,3	 # tmp1733, i,
	subu	$22,$22,$16	 # tmp1734, tmp1733, i
	sll	$22,$22,4	 # tmp1735, tmp1734,
	subu	$22,$22,$16	 # tmp1736, tmp1735, i
	sll	$22,$22,2	 # tmp1737, tmp1736,
	subu	$22,$22,$16	 # tmp1738, tmp1737, i
	sll	$22,$22,3	 # tmp1739, tmp1738,
	addiu	$2,$22,20	 # tmp1740, tmp1739,
	lui	$22,%hi(GlobalPlayer)	 # tmp1742,
	addiu	$22,$22,%lo(GlobalPlayer)	 # tmp1741, tmp1742,
	addu	$22,$22,$2	 # _393, tmp1741, tmp1740
 # BattleBots/BattleBotAI.c:718:                     int ramp_path_index = FindNearestRampNode(GlobalPlayer[i].position, rampNodePosition, rival_y, CourseRamps[ci], CourseRampLengths[ci], LineCounts[ci][1]);
	sll	$21,$17,2	 # tmp1744, _3,
	lui	$2,%hi(CourseRamps)	 # tmp1743,
	addiu	$2,$2,%lo(CourseRamps)	 # tmp1746, tmp1743,
	addu	$2,$21,$2	 # tmp1745, tmp1744, tmp1746
	lh	$3,2($3)		 # MEM[(short int *)_509 + 2B], MEM[(short int *)_509 + 2B]
	sw	$3,20($sp)	 # MEM[(short int *)_509 + 2B],
	lui	$3,%hi(CourseRampLengths)	 # tmp1750,
	addiu	$3,$3,%lo(CourseRampLengths)	 # tmp1753, tmp1750,
	addu	$3,$21,$3	 # tmp1752, tmp1744, tmp1753
	lw	$3,0($3)		 # tmp1754, CourseRampLengths
	sw	$3,16($sp)	 # tmp1754,
	lw	$7,0($2)		 #, CourseRamps
	mfc1	$6,$f20	 #, rival_y
	addiu	$5,$sp,44	 #,,
	jal	FindNearestRampNode	 #
	move	$4,$22	 #, _393

	move	$23,$2	 # ramp_path_index, tmp2226
 # BattleBots/BattleBotAI.c:719:                     int drop_path_index = FindNearestDropNode(GlobalPlayer[i].position, dropNodePosition, rival_y, CourseDrops[ci], CourseDropLengths[ci], LineCounts[ci][2]);
	lui	$2,%hi(CourseDrops)	 # tmp1755,
	addiu	$2,$2,%lo(CourseDrops)	 # tmp1758, tmp1755,
	addu	$2,$21,$2	 # tmp1757, tmp1744, tmp1758
 # BattleBots/BattleBotAI.c:719:                     int drop_path_index = FindNearestDropNode(GlobalPlayer[i].position, dropNodePosition, rival_y, CourseDrops[ci], CourseDropLengths[ci], LineCounts[ci][2]);
	lui	$3,%hi(LineCounts)	 # tmp1760,
	addiu	$3,$3,%lo(LineCounts)	 # tmp1763, tmp1760,
	addu	$3,$21,$3	 # tmp1762, tmp1744, tmp1763
 # BattleBots/BattleBotAI.c:719:                     int drop_path_index = FindNearestDropNode(GlobalPlayer[i].position, dropNodePosition, rival_y, CourseDrops[ci], CourseDropLengths[ci], LineCounts[ci][2]);
	lw	$3,0($3)		 # tmp1764, LineCounts
	lh	$3,4($3)		 # MEM[(short int *)_399 + 4B], MEM[(short int *)_399 + 4B]
	sw	$3,20($sp)	 # MEM[(short int *)_399 + 4B],
	lui	$3,%hi(CourseDropLengths)	 # tmp1766,
	addiu	$3,$3,%lo(CourseDropLengths)	 # tmp1769, tmp1766,
	addu	$21,$21,$3	 # tmp1768, tmp1744, tmp1769
	lw	$3,0($21)		 # tmp1770, CourseDropLengths
	sw	$3,16($sp)	 # tmp1770,
	lw	$7,0($2)		 #, CourseDrops
	mfc1	$6,$f20	 #, rival_y
	addiu	$5,$sp,32	 #,,
	jal	FindNearestDropNode	 #
	move	$4,$22	 #, _393

 # BattleBots/BattleBotAI.c:720:                     if (ramp_path_index == -1 && drop_path_index == -1)//If no path is found in the middle of a fall
	and	$4,$23,$2	 # tmp1771, ramp_path_index, drop_path_index
	li	$3,-1			# 0xffffffffffffffff	 # tmp1772,
	beq	$4,$3,$L101	 #, tmp1771, tmp1772,
	sll	$3,$16,3	 # tmp1777, i,

 # BattleBots/BattleBotAI.c:739:                     float dist_to_nearest_ramp = PythagoreanTheorem(GlobalPlayer[i].position[0], rampNodePosition[0], GlobalPlayer[i].position[2], rampNodePosition[2]);
	lui	$4,%hi(GlobalPlayer)	 # tmp1773,
	subu	$3,$3,$16	 # tmp1778, tmp1777, i
	sll	$3,$3,4	 # tmp1779, tmp1778,
	subu	$3,$3,$16	 # tmp1780, tmp1779, i
	sll	$3,$3,2	 # tmp1781, tmp1780,
	subu	$3,$3,$16	 # tmp1782, tmp1781, i
	sll	$3,$3,3	 # tmp1783, tmp1782,
	addiu	$4,$4,%lo(GlobalPlayer)	 # tmp1774, tmp1773,
	addu	$3,$4,$3	 # tmp1775, tmp1774, tmp1783
	lwc1	$f0,20($3)	 # _401, GlobalPlayer[i_533(D)].position
	lwc1	$f8,44($sp)	 # _402, rampNodePosition
	sub.s	$f6,$f0,$f8	 # tmp1784, _401, _402
	cvt.d.s	$f6,$f6	 # _404, tmp1784
	lwc1	$f4,28($3)	 # _406, GlobalPlayer[i_533(D)].position
	lwc1	$f10,52($sp)	 # _407, rampNodePosition
	sub.s	$f2,$f4,$f10	 # tmp1796, _406, _407
	cvt.d.s	$f2,$f2	 # _409, tmp1796
	mul.d	$f2,$f2,$f2	 # tmp1797, _409, _409
	mul.d	$f6,$f6,$f6	 # tmp1798, _404, _404
	add.d	$f2,$f2,$f6	 # tmp1799, tmp1797, tmp1798
 # BattleBots/BattleBotAI.c:739:                     float dist_to_nearest_ramp = PythagoreanTheorem(GlobalPlayer[i].position[0], rampNodePosition[0], GlobalPlayer[i].position[2], rampNodePosition[2]);
	cvt.s.d	$f2,$f2	 # dist_to_nearest_ramp, tmp1799
 # BattleBots/BattleBotAI.c:740:                     float dist_to_nearest_drop = PythagoreanTheorem(GlobalPlayer[i].position[0], dropNodePosition[0], GlobalPlayer[i].position[2], dropNodePosition[2]);
	lwc1	$f12,32($sp)	 # _413, MEM[(float[3] *)_48]
	sub.s	$f0,$f0,$f12	 # tmp1800, _401, _413
	cvt.d.s	$f0,$f0	 # _415, tmp1800
	lwc1	$f6,40($sp)	 # _418, MEM[(float[3] *)_48]
	sub.s	$f4,$f4,$f6	 # tmp1801, _406, _418
	cvt.d.s	$f4,$f4	 # _420, tmp1801
	mul.d	$f0,$f0,$f0	 # tmp1802, _415, _415
	mul.d	$f4,$f4,$f4	 # tmp1803, _420, _420
	add.d	$f0,$f0,$f4	 # tmp1804, tmp1802, tmp1803
 # BattleBots/BattleBotAI.c:740:                     float dist_to_nearest_drop = PythagoreanTheorem(GlobalPlayer[i].position[0], dropNodePosition[0], GlobalPlayer[i].position[2], dropNodePosition[2]);
	cvt.s.d	$f0,$f0	 # dist_to_nearest_drop, tmp1804
 # BattleBots/BattleBotAI.c:741:                     if (dist_to_nearest_ramp < dist_to_nearest_drop || drop_path_index == -1) //If a ramp is closer than a drop, use the ramp
	c.lt.s	$f2,$f0	 #, dist_to_nearest_ramp, dist_to_nearest_drop
	nop	
	bc1tl	$L215	 #,,
	lui	$2,%hi($LC38)	 # tmp1807,

 # BattleBots/BattleBotAI.c:741:                     if (dist_to_nearest_ramp < dist_to_nearest_drop || drop_path_index == -1) //If a ramp is closer than a drop, use the ramp
	li	$3,-1			# 0xffffffffffffffff	 # tmp1805,
	beq	$2,$3,$L159	 #, drop_path_index, tmp1805,
	lui	$3,%hi($LC38)	 # tmp1903,

 # BattleBots/BattleBotAI.c:767:                         if (dist_to_nearest_drop < RAMPDISTANCESQUARE) //If bot is at drop, use drop
	lwc1	$f2,%lo($LC38)($3)	 # tmp1902,
	c.lt.s	$f0,$f2	 #, dist_to_nearest_drop, tmp1902
	nop	
	bc1f	$L189	 #,,
	sll	$3,$16,5	 # tmp1906, i,

 # BattleBots/BattleBotAI.c:769:                             AIPathfinder[i].Target[0] = rival_x;
	lui	$4,%hi(AIPathfinder)	 # tmp1904,
	addiu	$4,$4,%lo(AIPathfinder)	 # tmp1907, tmp1904,
	addu	$3,$3,$4	 # tmp1905, tmp1906, tmp1907
	swc1	$f28,8($3)	 # rival_x, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:770:                             AIPathfinder[i].Target[1] = rival_y;
	swc1	$f20,12($3)	 # rival_y, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:771:                             AIPathfinder[i].Target[2] = rival_z;
	swc1	$f30,16($3)	 # rival_z, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:773:                             AIPathfinder[i].LastPath = TargetPath;
	sh	$20,2($3)	 # TargetPath, AIPathfinder[i_533(D)].LastPath
 # BattleBots/BattleBotAI.c:774:                             AIPathfinder[i].TargetPath = drop_path_index;
	sh	$2,0($3)	 # drop_path_index, AIPathfinder[i_533(D)].TargetPath
 # BattleBots/BattleBotAI.c:775:                             AIPathfinder[i].Progression = 0;
	sh	$0,20($3)	 #, AIPathfinder[i_533(D)].Progression
 # BattleBots/BattleBotAI.c:776:                             AIPathfinder[i].Direction = 1;
	li	$4,1			# 0x1	 # tmp1932,
	sb	$4,30($3)	 # tmp1932, AIPathfinder[i_533(D)].Direction
 # BattleBots/BattleBotAI.c:777:                             AIPathfinder[i].PathType = 2;
	li	$4,2			# 0x2	 # tmp1937,
	sb	$4,31($3)	 # tmp1937, AIPathfinder[i_533(D)].PathType
 # BattleBots/BattleBotAI.c:778:                             AIPathfinder[i].NearestMarker = 0;
	sh	$0,22($3)	 #, AIPathfinder[i_533(D)].NearestMarker
 # BattleBots/BattleBotAI.c:779:                             AIPathfinder[i].NearestMarkerHeight = (float)CourseDrops[ci][drop_path_index][0].Position[1];
	sll	$4,$17,2	 # tmp1947, _3,
	lui	$5,%hi(CourseDrops)	 # tmp1946,
	addiu	$5,$5,%lo(CourseDrops)	 # tmp1949, tmp1946,
	addu	$4,$4,$5	 # tmp1948, tmp1947, tmp1949
 # BattleBots/BattleBotAI.c:779:                             AIPathfinder[i].NearestMarkerHeight = (float)CourseDrops[ci][drop_path_index][0].Position[1];
	lw	$4,0($4)		 # tmp1950, CourseDrops
	sll	$2,$2,2	 # tmp1951, drop_path_index,
	addu	$2,$4,$2	 # tmp1952, tmp1950, tmp1951
 # BattleBots/BattleBotAI.c:779:                             AIPathfinder[i].NearestMarkerHeight = (float)CourseDrops[ci][drop_path_index][0].Position[1];
	lw	$2,0($2)		 # *_452, *_452
 # BattleBots/BattleBotAI.c:779:                             AIPathfinder[i].NearestMarkerHeight = (float)CourseDrops[ci][drop_path_index][0].Position[1];
	lh	$2,2($2)		 # _453->Position, _453->Position
	mtc1	$2,$f0	 # _453->Position, _453->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1955, _453->Position
	swc1	$f0,24($3)	 # tmp1955, AIPathfinder[i_533(D)].NearestMarkerHeight
	b	$L147	 #
	sh	$0,28($3)	 #, AIPathfinder[i_533(D)].ProgressTimer

$L159:
 # BattleBots/BattleBotAI.c:743:                         if (dist_to_nearest_ramp < RAMPDISTANCESQUARE) //If bot is at ramp, use ramp
	lui	$2,%hi($LC38)	 # tmp1807,
$L215:
	lwc1	$f0,%lo($LC38)($2)	 # tmp1806,
	c.lt.s	$f2,$f0	 #, dist_to_nearest_ramp, tmp1806
	nop	
	bc1f	$L188	 #,,
	sll	$3,$16,5	 # tmp1810, i,

 # BattleBots/BattleBotAI.c:745:                             AIPathfinder[i].Target[0] = rival_x;
	lui	$2,%hi(AIPathfinder)	 # tmp1808,
	addiu	$2,$2,%lo(AIPathfinder)	 # tmp1811, tmp1808,
	addu	$3,$3,$2	 # tmp1809, tmp1810, tmp1811
	swc1	$f28,8($3)	 # rival_x, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:746:                             AIPathfinder[i].Target[1] = rival_y;
	swc1	$f20,12($3)	 # rival_y, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:747:                             AIPathfinder[i].Target[2] = rival_z;
	swc1	$f30,16($3)	 # rival_z, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:749:                             AIPathfinder[i].LastPath = TargetPath;
	sh	$20,2($3)	 # TargetPath, AIPathfinder[i_533(D)].LastPath
 # BattleBots/BattleBotAI.c:750:                             AIPathfinder[i].TargetPath = ramp_path_index;
	sh	$23,0($3)	 # ramp_path_index, AIPathfinder[i_533(D)].TargetPath
 # BattleBots/BattleBotAI.c:751:                             AIPathfinder[i].Progression = CourseRampLengths[ci][ramp_path_index];
	sll	$2,$17,2	 # tmp1829, _3,
	lui	$4,%hi(CourseRampLengths)	 # tmp1828,
	addiu	$4,$4,%lo(CourseRampLengths)	 # tmp1831, tmp1828,
	addu	$4,$2,$4	 # tmp1830, tmp1829, tmp1831
 # BattleBots/BattleBotAI.c:751:                             AIPathfinder[i].Progression = CourseRampLengths[ci][ramp_path_index];
	sll	$5,$23,1	 # tmp1832, ramp_path_index,
	lw	$4,0($4)		 # tmp1833, CourseRampLengths
	addu	$4,$4,$5	 # _427, tmp1833, tmp1832
	lh	$5,0($4)		 # _428, *_427
 # BattleBots/BattleBotAI.c:751:                             AIPathfinder[i].Progression = CourseRampLengths[ci][ramp_path_index];
	sh	$5,20($3)	 # _428, AIPathfinder[i_533(D)].Progression
 # BattleBots/BattleBotAI.c:752:                             AIPathfinder[i].Direction = -1;
	li	$5,-1			# 0xffffffffffffffff	 # tmp1842,
	sb	$5,30($3)	 # tmp1842, AIPathfinder[i_533(D)].Direction
 # BattleBots/BattleBotAI.c:753:                             AIPathfinder[i].PathType = 1;
	li	$5,1			# 0x1	 # tmp1847,
	sb	$5,31($3)	 # tmp1847, AIPathfinder[i_533(D)].PathType
 # BattleBots/BattleBotAI.c:754:                             AIPathfinder[i].NearestMarker = CourseRampLengths[ci][ramp_path_index];
	lh	$4,0($4)		 # _429, *_427
 # BattleBots/BattleBotAI.c:754:                             AIPathfinder[i].NearestMarker = CourseRampLengths[ci][ramp_path_index];
	sh	$4,22($3)	 # _429, AIPathfinder[i_533(D)].NearestMarker
 # BattleBots/BattleBotAI.c:755:                             AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][ramp_path_index][CourseRampLengths[ci][ramp_path_index]].Position[1];
	lui	$5,%hi(CourseRamps)	 # tmp1856,
	addiu	$5,$5,%lo(CourseRamps)	 # tmp1859, tmp1856,
	addu	$2,$2,$5	 # tmp1858, tmp1829, tmp1859
 # BattleBots/BattleBotAI.c:755:                             AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][ramp_path_index][CourseRampLengths[ci][ramp_path_index]].Position[1];
	lw	$2,0($2)		 # tmp1860, CourseRamps
	sll	$23,$23,2	 # tmp1861, ramp_path_index,
	addu	$23,$2,$23	 # tmp1862, tmp1860, tmp1861
 # BattleBots/BattleBotAI.c:755:                             AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][ramp_path_index][CourseRampLengths[ci][ramp_path_index]].Position[1];
	lw	$2,0($23)		 # *_432, *_432
	sll	$4,$4,3	 # tmp1864, _429,
	addu	$4,$2,$4	 # tmp1865, *_432, tmp1864
 # BattleBots/BattleBotAI.c:755:                             AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][ramp_path_index][CourseRampLengths[ci][ramp_path_index]].Position[1];
	lh	$2,2($4)		 # _437->Position, _437->Position
	mtc1	$2,$f0	 # _437->Position, _437->Position
	nop	
	cvt.s.w	$f0,$f0	 # tmp1867, _437->Position
	swc1	$f0,24($3)	 # tmp1867, AIPathfinder[i_533(D)].NearestMarkerHeight
	b	$L147	 #
	sh	$0,28($3)	 #, AIPathfinder[i_533(D)].ProgressTimer

$L188:
 # BattleBots/BattleBotAI.c:759:                             AIPathfinder[i].Target[0] = rampNodePosition[0];
	sll	$2,$16,5	 # tmp1874, i,
	lui	$3,%hi(AIPathfinder)	 # tmp1872,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp1875, tmp1872,
	addu	$2,$2,$3	 # tmp1873, tmp1874, tmp1875
	swc1	$f8,8($2)	 # _402, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:760:                             AIPathfinder[i].Target[1] = rampNodePosition[1];
	lwc1	$f0,48($sp)	 # rampNodePosition, rampNodePosition
	swc1	$f0,12($2)	 # rampNodePosition, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:761:                             AIPathfinder[i].Target[2] = rampNodePosition[2];
	swc1	$f10,16($2)	 # _407, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:762:                             UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                            
	sll	$2,$17,2	 # tmp1886, _3,
	lui	$4,%hi(CoursePathLengths)	 # tmp1885,
	addiu	$4,$4,%lo(CoursePathLengths)	 # tmp1888, tmp1885,
	addu	$4,$2,$4	 # tmp1887, tmp1886, tmp1888
	lui	$3,%hi(CoursePaths)	 # tmp1890,
	addiu	$3,$3,%lo(CoursePaths)	 # tmp1893, tmp1890,
	addu	$3,$2,$3	 # tmp1892, tmp1886, tmp1893
	sw	$0,24($sp)	 #,
	sll	$5,$16,16	 # i, i,
	sra	$5,$5,16	 # i, i,
	sw	$5,20($sp)	 # i,
 # BattleBots/BattleBotAI.c:762:                             UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                            
	lui	$5,%hi(LineCounts)	 # tmp1896,
	addiu	$5,$5,%lo(LineCounts)	 # tmp1899, tmp1896,
	addu	$2,$2,$5	 # tmp1898, tmp1886, tmp1899
 # BattleBots/BattleBotAI.c:762:                             UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                            
	lw	$2,0($2)		 # tmp1900, LineCounts
	lh	$2,0($2)		 # *_445, *_445
	sw	$2,16($sp)	 # *_445,
	lw	$7,0($4)		 #, CoursePathLengths
	lw	$6,0($3)		 #, CoursePaths
	li	$5,350			# 0x15e	 #,
	jal	UpdateBKPath	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	b	$L202	 #
	sll	$2,$16,3	 # tmp2110, i,

$L189:
 # BattleBots/BattleBotAI.c:783:                             AIPathfinder[i].Target[0] = dropNodePosition[0];
	sll	$2,$16,5	 # tmp1962, i,
	lui	$3,%hi(AIPathfinder)	 # tmp1960,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp1963, tmp1960,
	addu	$2,$2,$3	 # tmp1961, tmp1962, tmp1963
	swc1	$f12,8($2)	 # _413, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:784:                             AIPathfinder[i].Target[1] = dropNodePosition[1];
	lwc1	$f0,36($sp)	 # MEM[(float[3] *)_48], MEM[(float[3] *)_48]
	swc1	$f0,12($2)	 # MEM[(float[3] *)_48], AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:785:                             AIPathfinder[i].Target[2] = dropNodePosition[2];
	swc1	$f6,16($2)	 # _418, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:786:                             UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                            
	sll	$2,$17,2	 # tmp1974, _3,
	lui	$4,%hi(CoursePathLengths)	 # tmp1973,
	addiu	$4,$4,%lo(CoursePathLengths)	 # tmp1976, tmp1973,
	addu	$4,$2,$4	 # tmp1975, tmp1974, tmp1976
	lui	$3,%hi(CoursePaths)	 # tmp1978,
	addiu	$3,$3,%lo(CoursePaths)	 # tmp1981, tmp1978,
	addu	$3,$2,$3	 # tmp1980, tmp1974, tmp1981
	sw	$0,24($sp)	 #,
	sll	$5,$16,16	 # i, i,
	sra	$5,$5,16	 # i, i,
	sw	$5,20($sp)	 # i,
 # BattleBots/BattleBotAI.c:786:                             UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                            
	lui	$5,%hi(LineCounts)	 # tmp1984,
	addiu	$5,$5,%lo(LineCounts)	 # tmp1987, tmp1984,
	addu	$2,$2,$5	 # tmp1986, tmp1974, tmp1987
 # BattleBots/BattleBotAI.c:786:                             UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                            
	lw	$2,0($2)		 # tmp1988, LineCounts
	lh	$2,0($2)		 # *_461, *_461
	sw	$2,16($sp)	 # *_461,
	lw	$7,0($4)		 #, CoursePathLengths
	lw	$6,0($3)		 #, CoursePaths
	li	$5,350			# 0x15e	 #,
	jal	UpdateBKPath	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:713:                 {
	b	$L202	 #
	sll	$2,$16,3	 # tmp2110, i,

$L145:
 # BattleBots/BattleBotAI.c:805:             if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
	sll	$2,$17,2	 # tmp2020, _3,
	lui	$4,%hi(CourseDropLengths)	 # tmp2019,
	addiu	$4,$4,%lo(CourseDropLengths)	 # tmp2022, tmp2019,
	addu	$4,$2,$4	 # tmp2021, tmp2020, tmp2022
	lui	$3,%hi(CourseRampLengths)	 # tmp2024,
	addiu	$3,$3,%lo(CourseRampLengths)	 # tmp2027, tmp2024,
	addu	$3,$2,$3	 # tmp2026, tmp2020, tmp2027
	lui	$5,%hi(CoursePathLengths)	 # tmp2029,
	addiu	$5,$5,%lo(CoursePathLengths)	 # tmp2032, tmp2029,
	addu	$2,$2,$5	 # tmp2031, tmp2020, tmp2032
	lw	$7,0($4)		 #, CourseDropLengths
	lw	$6,0($3)		 #, CourseRampLengths
	lw	$5,0($2)		 #, CoursePathLengths
	jal	PathfinderComplete	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:805:             if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
	beql	$2,$0,$L202	 #, tmp2228,,
	sll	$2,$16,3	 # tmp2110, i,

 # BattleBots/BattleBotAI.c:807:                 AIPathfinder[i].Target[0] = rival_x; //Done with the ramp so go back to a flat path
	sll	$2,$16,5	 # tmp2037, i,
	lui	$3,%hi(AIPathfinder)	 # tmp2035,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp2038, tmp2035,
	addu	$2,$2,$3	 # tmp2036, tmp2037, tmp2038
	swc1	$f28,8($2)	 # rival_x, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:808:                 AIPathfinder[i].Target[1] = rival_y;
	swc1	$f20,12($2)	 # rival_y, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:809:                 AIPathfinder[i].Target[2] = rival_z;
	swc1	$f30,16($2)	 # rival_z, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:810:                 UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                   
	sll	$2,$17,2	 # tmp2048, _3,
	lui	$4,%hi(CoursePathLengths)	 # tmp2047,
	addiu	$4,$4,%lo(CoursePathLengths)	 # tmp2050, tmp2047,
	addu	$4,$2,$4	 # tmp2049, tmp2048, tmp2050
	lui	$3,%hi(CoursePaths)	 # tmp2052,
	addiu	$3,$3,%lo(CoursePaths)	 # tmp2055, tmp2052,
	addu	$3,$2,$3	 # tmp2054, tmp2048, tmp2055
	sw	$0,24($sp)	 #,
	sll	$5,$16,16	 # i, i,
	sra	$5,$5,16	 # i, i,
	sw	$5,20($sp)	 # i,
 # BattleBots/BattleBotAI.c:810:                 UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                   
	lui	$5,%hi(LineCounts)	 # tmp2058,
	addiu	$5,$5,%lo(LineCounts)	 # tmp2061, tmp2058,
	addu	$2,$2,$5	 # tmp2060, tmp2048, tmp2061
 # BattleBots/BattleBotAI.c:810:                 UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                   
	lw	$2,0($2)		 # tmp2062, LineCounts
	lh	$2,0($2)		 # *_475, *_475
	sw	$2,16($sp)	 # *_475,
	lw	$7,0($4)		 #, CoursePathLengths
	lw	$6,0($3)		 #, CoursePaths
	li	$5,350			# 0x15e	 #,
	jal	UpdateBKPath	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	b	$L202	 #
	sll	$2,$16,3	 # tmp2110, i,

$L146:
 # BattleBots/BattleBotAI.c:814:             if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
	lui	$4,%hi(CourseDropLengths)	 # tmp2064,
	addiu	$4,$4,%lo(CourseDropLengths)	 # tmp2067, tmp2064,
	addu	$4,$2,$4	 # tmp2066, tmp2065, tmp2067
	lui	$3,%hi(CourseRampLengths)	 # tmp2069,
	addiu	$3,$3,%lo(CourseRampLengths)	 # tmp2072, tmp2069,
	addu	$3,$2,$3	 # tmp2071, tmp2065, tmp2072
	lui	$5,%hi(CoursePathLengths)	 # tmp2074,
	addiu	$5,$5,%lo(CoursePathLengths)	 # tmp2077, tmp2074,
	addu	$2,$2,$5	 # tmp2076, tmp2065, tmp2077
	lw	$7,0($4)		 #, CourseDropLengths
	lw	$6,0($3)		 #, CourseRampLengths
	lw	$5,0($2)		 #, CoursePathLengths
	jal	PathfinderComplete	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:814:             if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
	beql	$2,$0,$L202	 #, tmp2229,,
	sll	$2,$16,3	 # tmp2110, i,

 # BattleBots/BattleBotAI.c:816:                 AIPathfinder[i].Target[0] = rival_x; //Done with the ramp so go back to a flat path
	sll	$2,$16,5	 # tmp2082, i,
	lui	$3,%hi(AIPathfinder)	 # tmp2080,
	addiu	$3,$3,%lo(AIPathfinder)	 # tmp2083, tmp2080,
	addu	$2,$2,$3	 # tmp2081, tmp2082, tmp2083
	swc1	$f28,8($2)	 # rival_x, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:817:                 AIPathfinder[i].Target[1] = rival_y;
	swc1	$f20,12($2)	 # rival_y, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:818:                 AIPathfinder[i].Target[2] = rival_z;
	swc1	$f30,16($2)	 # rival_z, AIPathfinder[i_533(D)].Target
 # BattleBots/BattleBotAI.c:819:                 UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                   
	sll	$2,$17,2	 # tmp2093, _3,
	lui	$4,%hi(CoursePathLengths)	 # tmp2092,
	addiu	$4,$4,%lo(CoursePathLengths)	 # tmp2095, tmp2092,
	addu	$4,$2,$4	 # tmp2094, tmp2093, tmp2095
	lui	$3,%hi(CoursePaths)	 # tmp2097,
	addiu	$3,$3,%lo(CoursePaths)	 # tmp2100, tmp2097,
	addu	$3,$2,$3	 # tmp2099, tmp2093, tmp2100
	sw	$0,24($sp)	 #,
	sll	$5,$16,16	 # i, i,
	sra	$5,$5,16	 # i, i,
	sw	$5,20($sp)	 # i,
 # BattleBots/BattleBotAI.c:819:                 UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                   
	lui	$5,%hi(LineCounts)	 # tmp2103,
	addiu	$5,$5,%lo(LineCounts)	 # tmp2106, tmp2103,
	addu	$2,$2,$5	 # tmp2105, tmp2093, tmp2106
 # BattleBots/BattleBotAI.c:819:                 UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);                                   
	lw	$2,0($2)		 # tmp2107, LineCounts
	lh	$2,0($2)		 # *_484, *_484
	sw	$2,16($sp)	 # *_484,
	lw	$7,0($4)		 #, CoursePathLengths
	lw	$6,0($3)		 #, CoursePaths
	li	$5,350			# 0x15e	 #,
	jal	UpdateBKPath	 #
	move	$4,$19	 #, _20

 # BattleBots/BattleBotAI.c:825:     if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius, GlobalPlayer[i].position, turn_towards_rival_radius) && (pow(bot_y-rival_y, 2) < 225.0))
	b	$L202	 #
	sll	$2,$16,3	 # tmp2110, i,

$L198:
 # BattleBots/BattleBotAI.c:827:         nearest_item_box[i][0] = 0.0; //Reset nearest item box
	addu	$2,$2,$16	 # tmp2133, tmp2132, i
	sll	$2,$2,2	 # tmp2134, tmp2133,
	lui	$3,%hi(nearest_item_box)	 # tmp2130,
	addiu	$3,$3,%lo(nearest_item_box)	 # tmp2136, tmp2130,
	addu	$2,$2,$3	 # tmp2135, tmp2134, tmp2136
	sw	$0,0($2)	 #, nearest_item_box
 # BattleBots/BattleBotAI.c:828:         nearest_item_box[i][1] = 0.0;
	sw	$0,4($2)	 #, nearest_item_box
 # BattleBots/BattleBotAI.c:829:         nearest_item_box[i][2] = 0.0;
	sw	$0,8($2)	 #, nearest_item_box
 # BattleBots/BattleBotAI.c:830:         return StandardBattleBot(i);
	jal	StandardBattleBot	 #
	move	$4,$16	 #, i

	b	$L203	 #
	lw	$31,92($sp)		 #,

	.set	macro
	.set	reorder
	.end	SeekerBattleBot
	.size	SeekerBattleBot, .-SeekerBattleBot
	.align	2
	.globl	runBots
	.set	nomips16
	.set	nomicromips
	.ent	runBots
	.type	runBots, @function
runBots:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, gp= 0
	.mask	0x80ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-56	 #,,
	sw	$31,52($sp)	 #,
	sw	$23,48($sp)	 #,
	sw	$22,44($sp)	 #,
	sw	$21,40($sp)	 #,
	sw	$20,36($sp)	 #,
	sw	$19,32($sp)	 #,
	sw	$18,28($sp)	 #,
	sw	$17,24($sp)	 #,
 # BattleBots/BattleBotAI.c:968:     loadFont();
	jal	loadFont	 #
	sw	$16,20($sp)	 #,

 # BattleBots/BattleBotAI.c:972:     if (game_paused == 0) //Skip code if game is paused
	lui	$2,%hi(game_paused)	 # tmp214,
 # BattleBots/BattleBotAI.c:972:     if (game_paused == 0) //Skip code if game is paused
	lbu	$2,%lo(game_paused)($2)	 # game_paused, game_paused
	bne	$2,$0,$L227	 #, game_paused,,
	lw	$31,52($sp)		 #,

 # BattleBots/BattleBotAI.c:974:         for (int i=0; i<player_count; i++) //Loop through each bot
	lui	$2,%hi(player_count)	 # tmp216,
 # BattleBots/BattleBotAI.c:974:         for (int i=0; i<player_count; i++) //Loop through each bot
	lb	$2,%lo(player_count)($2)		 # player_count, player_count
	blez	$2,$L227	 #, player_count,
	lui	$16,%hi(bot_status_p1)	 # tmp218,

	addiu	$16,$16,%lo(bot_status_p1)	 # ivtmp.125, tmp218,
	lui	$19,%hi(bot_rival_p1)	 # tmp219,
	addiu	$19,$19,%lo(bot_rival_p1)	 # ivtmp.126, tmp219,
	lui	$18,%hi(bot_timer_p1)	 # tmp220,
	addiu	$18,$18,%lo(bot_timer_p1)	 # ivtmp.127, tmp220,
 # BattleBots/BattleBotAI.c:974:         for (int i=0; i<player_count; i++) //Loop through each bot
	move	$17,$0	 # i,
 # BattleBots/BattleBotAI.c:1113:                 switch(bot_ai_type)
	lui	$23,%hi(bot_ai_type)	 # tmp231,
	li	$22,1			# 0x1	 # tmp232,
	li	$21,2			# 0x2	 # tmp233,
 # BattleBots/BattleBotAI.c:974:         for (int i=0; i<player_count; i++) //Loop through each bot
	b	$L222	 #
	lui	$20,%hi(player_count)	 # tmp228,

$L225:
 # BattleBots/BattleBotAI.c:986:                     bot_rival_p1[i] = getRival(i);
	jal	getRival	 #
	move	$4,$17	 #, i

 # BattleBots/BattleBotAI.c:986:                     bot_rival_p1[i] = getRival(i);
	sb	$2,0($19)	 # tmp235, MEM[base: _41, offset: 0B]
 # BattleBots/BattleBotAI.c:987:                     bot_timer_p1[i] = MakeRandomLimmit(1200) +  3000; //Reset bot timer 50-70 seconds. (600 = 10 seconds)
	jal	MakeRandomLimmit	 #
	li	$4,1200			# 0x4b0	 #,

 # BattleBots/BattleBotAI.c:987:                     bot_timer_p1[i] = MakeRandomLimmit(1200) +  3000; //Reset bot timer 50-70 seconds. (600 = 10 seconds)
	addiu	$2,$2,3000	 # tmp224, tmp236,
 # BattleBots/BattleBotAI.c:987:                     bot_timer_p1[i] = MakeRandomLimmit(1200) +  3000; //Reset bot timer 50-70 seconds. (600 = 10 seconds)
	b	$L219	 #
	sw	$2,0($18)	 # tmp224, MEM[base: _43, offset: 0B]

$L220:
 # BattleBots/BattleBotAI.c:1122:                         SeekerBattleBot(i); 
	jal	SeekerBattleBot	 #
	move	$4,$17	 #, i

 # BattleBots/BattleBotAI.c:974:         for (int i=0; i<player_count; i++) //Loop through each bot
	addiu	$17,$17,1	 # i, i,
$L226:
 # BattleBots/BattleBotAI.c:974:         for (int i=0; i<player_count; i++) //Loop through each bot
	addiu	$16,$16,1	 # ivtmp.125, ivtmp.125,
	addiu	$19,$19,1	 # ivtmp.126, ivtmp.126,
 # BattleBots/BattleBotAI.c:974:         for (int i=0; i<player_count; i++) //Loop through each bot
	lb	$2,%lo(player_count)($20)		 # player_count, player_count
 # BattleBots/BattleBotAI.c:974:         for (int i=0; i<player_count; i++) //Loop through each bot
	slt	$2,$17,$2	 # tmp230, i, player_count
	beq	$2,$0,$L216	 #, tmp230,,
	addiu	$18,$18,4	 # ivtmp.127, ivtmp.127,

$L222:
 # BattleBots/BattleBotAI.c:978:             if(bot_status_p1[i] > 0) //If bot is on
	lbu	$2,0($16)	 # MEM[base: _40, offset: 0B], MEM[base: _40, offset: 0B]
	beql	$2,$0,$L226	 #, MEM[base: _40, offset: 0B],,
	addiu	$17,$17,1	 # i, i,

 # BattleBots/BattleBotAI.c:980:                 bot_timer_p1[i] = decrementTimerWrapper(bot_timer_p1[i]); //decrement the current bot's timer
	jal	decrementTimerWrapper	 #
	lw	$4,0($18)		 #, MEM[base: _43, offset: 0B]

 # BattleBots/BattleBotAI.c:983:                 if (bot_timer_p1[i] <= 0) //If bot timer is <= 0, roll the dice and maybe get a new rival
	blez	$2,$L225	 #, _4,
	sw	$2,0($18)	 # _4, MEM[base: _43, offset: 0B]

$L219:
 # BattleBots/BattleBotAI.c:1113:                 switch(bot_ai_type)
	lbu	$2,%lo(bot_ai_type)($23)	 # bot_ai_type.53_10, bot_ai_type
	beq	$2,$22,$L220
	nop
	 #, bot_ai_type.53_10, tmp232,
	beq	$2,$21,$L221
	nop
	 #, bot_ai_type.53_10, tmp233,
	bnel	$2,$0,$L226	 #, bot_ai_type.53_10,,
	addiu	$17,$17,1	 # i, i,

 # BattleBots/BattleBotAI.c:1117:                         StandardBattleBot(i); 
	jal	StandardBattleBot	 #
	move	$4,$17	 #, i

 # BattleBots/BattleBotAI.c:1118:                         break;
	b	$L226	 #
	addiu	$17,$17,1	 # i, i,

$L221:
 # BattleBots/BattleBotAI.c:1127:                         RandomBattleBot(i); 
	jal	RandomBattleBot	 #
	move	$4,$17	 #, i

 # BattleBots/BattleBotAI.c:1128:                         break;
	b	$L226	 #
	addiu	$17,$17,1	 # i, i,

$L216:
 # BattleBots/BattleBotAI.c:1184: }
	lw	$31,52($sp)		 #,
$L227:
	lw	$23,48($sp)		 #,
	lw	$22,44($sp)		 #,
	lw	$21,40($sp)		 #,
	lw	$20,36($sp)		 #,
	lw	$19,32($sp)		 #,
	lw	$18,28($sp)		 #,
	lw	$17,24($sp)		 #,
	lw	$16,20($sp)		 #,
	jr	$31	 #
	addiu	$sp,$sp,56	 #,,

	.set	macro
	.set	reorder
	.end	runBots
	.size	runBots, .-runBots
	.globl	test_bot_sphere_position
	.section	.bss,"aw",@nobits
	.align	2
	.type	test_bot_sphere_position, @object
	.size	test_bot_sphere_position, 48
test_bot_sphere_position:
	.space	48
	.globl	BattleLevelConverts
	.data
	.align	2
	.type	BattleLevelConverts, @object
	.size	BattleLevelConverts, 20
BattleLevelConverts:
	.ascii	"\377\377\377\377\377\377\377\377\377\377\377\377\377\377"
	.ascii	"\377\000\002\001\377\003"
	.globl	LineCounts
	.align	2
	.type	LineCounts, @object
	.size	LineCounts, 16
LineCounts:
	.word	BlockFortPaths_LineCounts
	.word	DoubleDeckerPaths_LineCounts
	.word	SkyscraperPaths_LineCounts
	.word	BigDonutPaths_LineCounts
	.globl	CourseDropLengths
	.align	2
	.type	CourseDropLengths, @object
	.size	CourseDropLengths, 16
CourseDropLengths:
	.word	BlockFortPaths_DropLengths
	.word	DoubleDeckerPaths_DropLengths
	.word	SkyscraperPaths_DropLengths
	.word	BigDonutPaths_DropLengths
	.globl	CourseRampLengths
	.align	2
	.type	CourseRampLengths, @object
	.size	CourseRampLengths, 16
CourseRampLengths:
	.word	BlockFortPaths_RampLengths
	.word	DoubleDeckerPaths_RampLengths
	.word	SkyscraperPaths_RampLengths
	.word	BigDonutPaths_RampLengths
	.globl	CoursePathLengths
	.align	2
	.type	CoursePathLengths, @object
	.size	CoursePathLengths, 16
CoursePathLengths:
	.word	BlockFortPaths_PathLengths
	.word	DoubleDeckerPaths_PathLengths
	.word	SkyscraperPaths_PathLengths
	.word	BigDonutPaths_PathLengths
	.globl	CourseDrops
	.align	2
	.type	CourseDrops, @object
	.size	CourseDrops, 16
CourseDrops:
	.word	BlockFortPaths_Drops
	.word	DoubleDeckerPaths_Drops
	.word	SkyscraperPaths_Drops
	.word	BigDonutPaths_Drops
	.globl	CourseRamps
	.align	2
	.type	CourseRamps, @object
	.size	CourseRamps, 16
CourseRamps:
	.word	BlockFortPaths_Ramps
	.word	DoubleDeckerPaths_Ramps
	.word	SkyscraperPaths_Ramps
	.word	BigDonutPaths_Ramps
	.globl	CoursePaths
	.align	2
	.type	CoursePaths, @object
	.size	CoursePaths, 16
CoursePaths:
	.word	BlockFortPaths_Paths
	.word	DoubleDeckerPaths_Paths
	.word	SkyscraperPaths_Paths
	.word	BigDonutPaths_Paths
	.globl	bot_bump
	.section	.bss
	.align	2
	.type	bot_bump, @object
	.size	bot_bump, 256
bot_bump:
	.space	256
	.globl	TripleTap
	.type	TripleTap, @object
	.size	TripleTap, 1
TripleTap:
	.space	1
	.globl	nearest_item_box
	.align	2
	.type	nearest_item_box, @object
	.size	nearest_item_box, 48
nearest_item_box:
	.space	48
	.globl	bot_x_stick
	.align	2
	.type	bot_x_stick, @object
	.size	bot_x_stick, 4
bot_x_stick:
	.space	4
	.globl	bot_pressed
	.align	2
	.type	bot_pressed, @object
	.size	bot_pressed, 8
bot_pressed:
	.space	8
	.globl	bot_buttons
	.align	2
	.type	bot_buttons, @object
	.size	bot_buttons, 8
bot_buttons:
	.space	8
	.globl	bot_distance_from_path_marker
	.align	2
	.type	bot_distance_from_path_marker, @object
	.size	bot_distance_from_path_marker, 16
bot_distance_from_path_marker:
	.space	16
	.globl	max_bot_distance_path_marker
	.rdata
	.align	2
	.type	max_bot_distance_path_marker, @object
	.size	max_bot_distance_path_marker, 4
max_bot_distance_path_marker:
	.word	1137180672
	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
$LC0:
	.word	1138819072
	.align	2
$LC1:
	.word	1120141312
	.align	2
$LC2:
	.word	1108082688
	.align	2
$LC3:
	.word	1128792064
	.align	2
$LC4:
	.word	1127481344
	.align	2
$LC5:
	.word	1198793728
	.align	2
$LC6:
	.word	-1063256064
	.align	2
$LC7:
	.word	1116471296
	.align	2
$LC8:
	.word	1092616192
	.align	2
$LC9:
	.word	1133903872
	.align	2
$LC10:
	.word	1084227584
	.align	2
$LC11:
	.word	1114636288
	.align	2
$LC12:
	.word	1343554297
	.align	2
$LC13:
	.word	1103626240
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
$LC14:
	.word	1081360384
	.word	0
	.section	.rodata.cst4
	.align	2
$LC15:
	.word	1106247680
	.section	.rodata.cst8
	.align	3
$LC16:
	.word	1082361856
	.word	0
	.section	.rodata.cst4
	.align	2
$LC33:
	.word	1153957888
	.align	2
$LC34:
	.word	1162346496
	.align	2
$LC35:
	.word	1097859072
	.section	.rodata.cst8
	.align	3
$LC36:
	.word	1088653312
	.word	0
	.section	.rodata.cst4
	.align	2
$LC37:
	.word	-1049624576
	.align	2
$LC38:
	.word	1193033728
	.section	.rodata.cst8
	.align	3
$LC39:
	.word	1080827904
	.word	0
	.ident	"GCC: (GNU) 10.1.0"
