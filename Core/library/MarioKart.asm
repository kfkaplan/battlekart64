.definelabel SYSTEM_Region, 0x80000300

.definelabel decodeMIO0, 0x800400D0 ;MIO0 File A0 = input, A1 = output
.definelabel DMA, 0x80001158
.definelabel decodeTKMK, 0x800405D0
.definelabel loadCourse, 0x802AA918
.definelabel ramCopy, 0x800D7FE0

.definelabel readControllers, 0x80000A28
.definelabel InitControllers, 0x800008A4

.definelabel deleteObjectBuffer, 0x8029E854
.definelabel addObjectBuffer, 0x8029EC88

.definelabel CollisionCylinder, 0x8029EEB8
.definelabel CollisionSphere, 0x8029FB80

.definelabel sinT, 0x802B8018
.definelabel cosT, 0x802B8038
.definelabel sinF, 0x800D60F0
.definelabel cosF, 0x800D62B0

.definelabel SegmentToVirtual, 0x802A7BD4

.definelabel printNumber, 0x80057524
.definelabel printString, 0x800577A4
.definelabel printStringNumber, 0x800577D0
.definelabel drawBox, 0x80098DF8

.definelabel SegmentTable, 0x80150258

.definelabel GraphPtr, 0x80150298
.definelabel GraphPtrOffset, 0x80150298
.definelabel KWSprite, 0x8004C364
.definelabel KWSpriteScale, 0x8004CA58

.definelabel SetMatrix, 0x802B4FF8
.definelabel CreateModelingMatrix, 0x802B5F74

.definelabel SetSegment, 0x802A7B94

.definelabel SetStar, 0x8008F778

.definelabel initializePlayer, 0x800393C0


.definelabel asm_itemJump1A, 0x8007B084  //3C058016
.definelabel asm_itemJump1B, 0x8007B098  //84A543BA

.definelabel asm_itemJump2A, 0x8007AFC0  //3C058016
.definelabel asm_itemJump2B, 0x8007AFD4  //84A543BA

.definelabel playSound, 0x800C8E10

.definelabel colorFont, 0x800930D8
.definelabel loadFont, 0x80057710

.definelabel g_SegmentA, 0x80117974
;;
;;

.definelabel g_resetToggle, 0x800DC50C
.definelabel g_startingIndicator,  0x800DC510  //2 starting line 3-race 5-results
.definelabel g_screenSplitA, 0x800DC52C
.definelabel g_ScreenSplitB, 0x800DC530
.definelabel g_playerCount, 0x800DC538
.definelabel g_raceClass, 0x800DC548
.definelabel g_gameTimer, 0x800DC598
.definelabel g_courseID,  0x800DC5A0
.definelabel g_loadedcourseFlag, 0x800DC5A4
.definelabel g_gameMode, 0x800DC53C
.definelabel g_mirrorMode, 0x800DC604


.definelabel gravity_1, 0x800E2650
.definelabel gravity_2, 0x800E2654
.definelabel gravity_3, 0x800E2658
.definelabel gravity_4, 0x800E265C
.definelabel gravity_5, 0x800E2660
.definelabel gravity_6, 0x800E2664
.definelabel gravity_7, 0x800E2668
.definelabel gravity_8, 0x800E266C

.definelabel antialiasToggle, 0x800EB3DC
.definelabel antialiasToggleB, 0x800EB40C


.definelabel g_CupArray, 0x800F2BB4
.definelabel g_cup0Array0, 0x800F2BB4
.definelabel g_cup0Array1, 0x800F2BB6
.definelabel g_cup0Array2, 0x800F2BB8
.definelabel g_cup0Array3, 0x800F2BBA
.definelabel g_cup1Array0, 0x800F2BBC
.definelabel g_cup1Array1, 0x800F2BBE
.definelabel g_cup1Array2, 0x800F2BC0
.definelabel g_cup1Array3, 0x800F2BC2
.definelabel g_cup2Array0, 0x800F2BC4
.definelabel g_cup2Array1, 0x800F2BC6
.definelabel g_cup2Array2, 0x800F2BC8
.definelabel g_cup2Array3, 0x800F2BCA
.definelabel g_cup3Array0, 0x800F2BCC
.definelabel g_cup3Array1, 0x800F2BCE
.definelabel g_cup3Array2, 0x800F2BD0
.definelabel g_cup3Array3, 0x800F2BD2
.definelabel g_cupBArray0, 0x800F2BD4
.definelabel g_cupBArray1, 0x800F2BD6
.definelabel g_cupBArray2, 0x800F2BD8
.definelabel g_cupBArray3, 0x800F2BDA


.definelabel g_bannerTexture, 0x801F2750
.definelabel g_previewTexture, 0x8020E460
.definelabel g_mapTexture, 0x8018D240
.definelabel g_mapStartToggle, 0x8004F150 //0C0132B4
.definelabel g_mapScale, 0x8018D2A0
.definelabel g_mapX, 0x8018D2C0
.definelabel g_mapY, 0x8018D2D8
.definelabel g_startX, 0x8018D2E0
.definelabel g_startY, 0x8018D2E8
.definelabel g_mapHeight, 0x8018D2B8
.definelabel g_mapWidth, 0x8018D2B0
.definelabel g_mapR, 0x8018D300
.definelabel g_mapG, 0x8018D308
.definelabel g_mapB, 0x8018D310

.definelabel g_DEBUG, 0x80430000

.definelabel r_CoursePreviewOffsets, 0x12C60C
.definelabel g_CoursePreviewOffsets, 0x801993FC
.definelabel g_CourseBannerOffsets, 0x801FA860
.definelabel g_cup0preview0, 0x80199540
.definelabel g_cup0preview1, 0x80199568
.definelabel g_cup0preview2, 0x801994F0
.definelabel g_cup0preview3, 0x801995B8


.definelabel g_cup1preview0, 0x80199590
.definelabel g_cup1preview1, 0x801994C8
.definelabel g_cup1preview2, 0x80199428
.definelabel g_cup1preview3, 0x80199400


.definelabel g_cup2preview0, 0x80199630
.definelabel g_cup2preview1, 0x801995E0
.definelabel g_cup2preview2, 0x80199518
.definelabel g_cup2preview3, 0x80199450


.definelabel g_cup3preview0, 0x801996D0
.definelabel g_cup3preview1, 0x801994A0
.definelabel g_cup3preview2, 0x80199478
.definelabel g_cup3preview3, 0x80199608

.definelabel g_NintendoLogoOffset, 0x8019F88C
.definelabel g_NintendoLogoBorder, 0x800944AC

.definelabel g_lakituStatus, 0x80165DCE
.definelabel g_lakituSurface, 0x80163318

.definelabel p_Input, 0x800F6915
.definelabel d_Input, 0x800F6914
.definelabel c_Input, 0x800F691A



.definelabel player1inputX, 0x800F6910
.definelabel player1inputY, 0x800F6912
.definelabel p1Button, 0x800F6914

.definelabel g_player1LocationX, 0x800F69A4
.definelabel g_player1LocationY, 0x800F69A8
.definelabel g_player1LocationZ, 0x800F69AC
.definelabel g_player1LastLocationX, 0x800F69B0
.definelabel g_player1LastLocationY, 0x800F69B4
.definelabel g_player1LastLocationZ, 0x800F69B8
.definelabel g_player1LocationA, 0x800F69BC
.definelabel g_player1SpeedX, 0x800F69C4
.definelabel g_player1SpeedY, 0x800F69C8
.definelabel g_player1SpeedZ, 0x800F69CC
.definelabel g_player1SpeedA, 0x800F6A24
.definelabel g_player1SpeedU1, 0x800F6A28
.definelabel g_player1SpeedU2, 0x800F6A2C
.definelabel g_playerStatus, 0x800F6A58

.definelabel g_player1CameraX, 0x800F6B28
.definelabel g_player1CameraY, 0x800F6B2C
.definelabel g_player1CameraZ, 0x800F6B30
.definelabel g_playerSpriteSize, 0x800F6BB4



.definelabel surface_p0, 0x800F6A4E

.definelabel player2X, 0x800F777C
.definelabel player2Y, 0x800F7780
.definelabel player2Z, 0x800F7784
.definelabel player3X, 0x800F8854
.definelabel player3Y, 0x800F8858
.definelabel player3Z, 0x800F885C
.definelabel player4X, 0x800F9324
.definelabel player4Y, 0x800F9328
.definelabel player4Z, 0x800F932C

.definelabel cpu2Speed, 0x800F797C
.definelabel cpu3Speed, 0x800F8754
.definelabel cpu4Speed, 0x800F952C

.definelabel boost2, 0x800F7776
.definelabel boost3, 0x800F854E
.definelabel boost4, 0x800F9326

.definelabel g_PlayerStateTable, 0x800F6990
.definelabel g_player0State, 0x800F6990
.definelabel g_player1State, 0x800F7768
.definelabel g_player2State, 0x800F8540
.definelabel g_player3State, 0x800F9318
.definelabel g_player4State, 0x800FA0F0
.definelabel g_player5State, 0x800FAEC8
.definelabel g_player6State, 0x800FBCA0
.definelabel g_player7State, 0x800FCA78

.definelabel g_aspectRatio, 0x80150148
.definelabel g_farClip, 0x8015014C

.definelabel g_player1View, 0x8015F4B4
.definelabel g_player1Section, 0x8015F4B8

.definelabel lastLoadedAddress, 0x8015F728
.definelabel g_raceTime, 0x8015F898
.definelabel g_lap2Time, 0x8015F89C
.definelabel g_lap3Time, 0x8015F8A0

.definelabel g_waterHeight, 0x8015F8E4

.definelabel g_progressValue, 0x8016328A


.definelabel g_playerPosition1, 0x801643B8
.definelabel g_playerPosition2, 0x801643BC
.definelabel g_playerPosition3, 0x801643C0
.definelabel g_playerPosition4, 0x801643C4
.definelabel g_playerPosition5, 0x801643C8
.definelabel g_playerPosition6, 0x801643CC
.definelabel g_playerPosition7, 0x801643D0
.definelabel g_playerPosition8, 0x801643D4

.definelabel g_gameLapPlayer1, 0x80164390
.definelabel g_gameLapPlayer2, 0x80164394
.definelabel g_gameLapPlayer3, 0x80164398
.definelabel g_gameLapPlayer4, 0x8016439C
.definelabel g_gameLapPlayer5, 0x801643A0
.definelabel g_gameLapPlayer6, 0x801643A4
.definelabel g_gameLapPlayer7, 0x801643A8
.definelabel g_gameLapPlayer8, 0x801643AC

.definelabel itemBoolean, 0x80165F5F
.definelabel itemA, 0x80165F5B
.definelabel itemB, 0x80165F5D
.definelabel itemC, 0x80165F8A

.definelabel g_lapCheckA, 0x8018CAE1
.definelabel g_lapCheckB, 0x8018CAE2

.definelabel disableEngine, 0x800E9F74
.definelabel disableHUD, 0x80059D08 //0C016A67
.definelabel disableGhostHUD, 0x8018DAAA

.definelabel g_mlogoY, 0x8018D9F0
.definelabel g_mflagID, 0x8018DA30
.definelabel g_mpressstartID, 0x8018DA58
.definelabel g_mracewayTime, 0x8018DA80


.definelabel backButton, 0x8018EDE0
.definelabel menuScreenC, 0x8018EDEE
.definelabel menuScreenA, 0x8018EDEC
.definelabel menuScreenB, 0x8018EDED

.definelabel titleDemo, 0x8018EE00

.definelabel g_cupSelect, 0x8018EE09
.definelabel g_courseSelect, 0x8018EE0B
.definelabel g_InGame, 0x8018EDFB

.definelabel asm_CupCount, 0x8028E3C6
.definelabel songID, 0x8028ECE6
.definelabel asm_SongA, 0x8028EC9C
.definelabel asm_SongB, 0x8028F9C4
//802B8B70
.definelabel g_skyColorTop, 0x802B8AD0
.definelabel g_skyColorBot, 0x802B8BCC


.definelabel player2OK, 0x8018EDE9
.definelabel player3OK, 0x8018EDEA
.definelabel player4OK, 0x8018EDEB

.definelabel g_RNG, 0x802BA350
