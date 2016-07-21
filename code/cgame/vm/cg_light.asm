export CG_ClearLightStyles
code
proc CG_ClearLightStyles 4 12
file "../cg_light.c"
line 16
;1:#include "cg_local.h"
;2:
;3:#if !defined(CG_LIGHTS_H_INC)
;4:	#include "cg_lights.h"
;5:#endif
;6:
;7:static	clightstyle_t	cl_lightstyle[MAX_LIGHT_STYLES];
;8:static	int				lastofs;
;9:
;10:/*
;11:================
;12:FX_ClearLightStyles
;13:================
;14:*/
;15:void CG_ClearLightStyles (void)
;16:{
line 19
;17:	int	i;
;18:
;19:	memset (cl_lightstyle, 0, sizeof(cl_lightstyle));
ADDRGP4 cl_lightstyle
ARGP4
CNSTI4 0
ARGI4
CNSTI4 16896
ARGI4
ADDRGP4 memset
CALLP4
pop
line 20
;20:	lastofs = -1;
ADDRGP4 lastofs
CNSTI4 -1
ASGNI4
line 22
;21:
;22:	for(i=0;i<MAX_LIGHT_STYLES*3;i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $122
line 23
;23:	{
line 24
;24:		CG_SetLightstyle (i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_SetLightstyle
CALLV
pop
line 25
;25:	}
LABELV $123
line 22
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 192
LTI4 $122
line 26
;26:}
LABELV $121
endproc CG_ClearLightStyles 4 12
export CG_RunLightStyles
proc CG_RunLightStyles 28 8
line 34
;27:
;28:/*
;29:================
;30:FX_RunLightStyles
;31:================
;32:*/
;33:void CG_RunLightStyles (void)
;34:{
line 39
;35:	int		ofs;
;36:	int		i;
;37:	clightstyle_t	*ls;
;38:
;39:	ofs = cg.time / 50;
ADDRLP4 8
ADDRGP4 cg+64
INDIRI4
CNSTI4 50
DIVI4
ASGNI4
line 42
;40://	if (ofs == lastofs)
;41://		return;
;42:	lastofs = ofs;
ADDRGP4 lastofs
ADDRLP4 8
INDIRI4
ASGNI4
line 44
;43:
;44:	for (i=0,ls=cl_lightstyle ; i<MAX_LIGHT_STYLES ; i++, ls++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cl_lightstyle
ASGNP4
ADDRGP4 $131
JUMPV
LABELV $128
line 45
;45:	{
line 46
;46:		if (!ls->length)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $132
line 47
;47:		{
line 48
;48:			ls->value[0] = ls->value[1] = ls->value[2] = ls->value[3] = 255;
ADDRLP4 16
CNSTU1 255
ASGNU1
ADDRLP4 0
INDIRP4
CNSTI4 7
ADDP4
ADDRLP4 16
INDIRU1
ASGNU1
ADDRLP4 0
INDIRP4
CNSTI4 6
ADDP4
ADDRLP4 16
INDIRU1
ASGNU1
ADDRLP4 0
INDIRP4
CNSTI4 5
ADDP4
ADDRLP4 16
INDIRU1
ASGNU1
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRU1
ASGNU1
line 49
;49:		}
ADDRGP4 $133
JUMPV
LABELV $132
line 50
;50:		else if (ls->length == 1)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
NEI4 $134
line 51
;51:		{
line 52
;52:			ls->value[0] = ls->map[0][0];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRU1
ASGNU1
line 53
;53:			ls->value[1] = ls->map[0][1];
ADDRLP4 0
INDIRP4
CNSTI4 5
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 9
ADDP4
INDIRU1
ASGNU1
line 54
;54:			ls->value[2] = ls->map[0][2];
ADDRLP4 0
INDIRP4
CNSTI4 6
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 10
ADDP4
INDIRU1
ASGNU1
line 55
;55:			ls->value[3] = 255; //ls->map[0][3];
ADDRLP4 0
INDIRP4
CNSTI4 7
ADDP4
CNSTU1 255
ASGNU1
line 56
;56:		}
ADDRGP4 $135
JUMPV
LABELV $134
line 58
;57:		else
;58:		{
line 59
;59:			ls->value[0] = ls->map[ofs%ls->length][0];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDP4
INDIRU1
ASGNU1
line 60
;60:			ls->value[1] = ls->map[ofs%ls->length][1];
ADDRLP4 0
INDIRP4
CNSTI4 5
ADDP4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDP4
CNSTI4 1
ADDP4
INDIRU1
ASGNU1
line 61
;61:			ls->value[2] = ls->map[ofs%ls->length][2];
ADDRLP4 24
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6
ADDP4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
MODI4
ADDRLP4 24
INDIRI4
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRU1
ASGNU1
line 62
;62:			ls->value[3] = 255; //ls->map[ofs%ls->length][3];
ADDRLP4 0
INDIRP4
CNSTI4 7
ADDP4
CNSTU1 255
ASGNU1
line 63
;63:		}
LABELV $135
LABELV $133
line 64
;64:		trap_R_SetLightStyle(i, *(int*)ls->value);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_R_SetLightStyle
CALLV
pop
line 65
;65:	}
LABELV $129
line 44
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 264
ADDP4
ASGNP4
LABELV $131
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $128
line 66
;66:}
LABELV $126
endproc CG_RunLightStyles 28 8
export CG_SetLightstyle
proc CG_SetLightstyle 44 12
line 69
;67:
;68:void CG_SetLightstyle (int i)
;69:{
line 73
;70:	const char	*s;
;71:	int			j, k;
;72:
;73:	s = CG_ConfigString( i+CS_LIGHT_STYLES );
ADDRFP4 0
INDIRI4
CNSTI4 832
ADDI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 74
;74:	j = strlen (s);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 75
;75:	if (j >= MAX_QPATH)
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $137
line 76
;76:	{
line 77
;77:		Com_Error (ERR_DROP, "svc_lightstyle length=%i", j);
CNSTI4 1
ARGI4
ADDRGP4 $139
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 Com_Error
CALLV
pop
line 78
;78:	}
LABELV $137
line 80
;79:
;80:	cl_lightstyle[(i/3)].length = j;
CNSTI4 264
ADDRFP4 0
INDIRI4
CNSTI4 3
DIVI4
MULI4
ADDRGP4 cl_lightstyle
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 81
;81:	for (k=0 ; k<j ; k++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $143
JUMPV
LABELV $140
line 82
;82:	{
line 83
;83:		cl_lightstyle[(i/3)].map[k][(i%3)] = (float)(s[k]-'a')/(float)('z'-'a') * 255.0;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 97
SUBI4
CVIF4 4
CNSTF4 1103626240
DIVF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $146
ADDRLP4 20
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $147
JUMPV
LABELV $146
ADDRLP4 20
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $147
ADDRLP4 36
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 40
CNSTI4 3
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
MODI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 264
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
DIVI4
MULI4
ADDRGP4 cl_lightstyle+8
ADDP4
ADDP4
ADDP4
ADDRLP4 20
INDIRU4
CVUU1 4
ASGNU1
line 84
;84:	}
LABELV $141
line 81
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $143
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $140
line 85
;85:}
LABELV $136
endproc CG_SetLightstyle 44 12
bss
align 4
LABELV lastofs
skip 4
align 4
LABELV cl_lightstyle
skip 16896
import g2WeaponInstances
import CG_CheckPlayerG2Weapons
import CG_CopyG2WeaponInstance
import CG_ShutDownG2Weapons
import CG_InitG2Weapons
import CG_CreateBBRefEnts
import CG_SetGhoul2Info
import CG_Init_CGents
import CG_Init_CG
import trap_G2API_SetNewOrigin
import trap_G2API_SetSurfaceOnOff
import trap_G2API_SetRootSurface
import trap_G2API_SetBoneAnim
import trap_G2API_GetGLAName
import trap_G2API_SetBoneAngles
import trap_G2API_CleanGhoul2Models
import trap_G2API_SetBoltInfo
import trap_G2API_AddBolt
import trap_G2API_RemoveGhoul2Model
import trap_G2API_HasGhoul2ModelOnIndex
import trap_G2API_DuplicateGhoul2Instance
import trap_G2API_CopySpecificGhoul2Model
import trap_G2API_CopyGhoul2Instance
import trap_G2API_GiveMeVectorFromMatrix
import trap_G2API_InitGhoul2Model
import trap_G2API_GetBoltMatrix_NoReconstruct
import trap_G2API_GetBoltMatrix
import trap_G2_HaveWeGhoul2Models
import trap_G2_SetGhoul2ModelIndexes
import trap_G2_ListModelBones
import trap_G2_ListModelSurfaces
import FX_ForceDrained
import FX_BlasterWeaponHitPlayer
import FX_BlasterWeaponHitWall
import FX_BlasterAltFireThink
import FX_BlasterProjectileThink
import FX_BryarAltHitPlayer
import FX_BryarHitPlayer
import FX_BryarAltHitWall
import FX_BryarHitWall
import CG_Spark
import FX_TurretHitPlayer
import FX_TurretHitWall
import FX_TurretProjectileThink
import CG_NewParticleArea
import initparticles
import CG_GetStripEdString
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_ROFF_Purge_Ent
import trap_ROFF_Play
import trap_ROFF_Cache
import trap_ROFF_UpdateEntities
import trap_ROFF_Clean
import trap_CG_RegisterSharedMemory
import trap_SP_GetStringTextString
import trap_SP_Print
import trap_FX_AddSprite
import trap_FX_AddPrimitive
import trap_FX_AddBezier
import trap_FX_AddPoly
import trap_FX_AdjustTime
import trap_FX_FreeSystem
import trap_FX_InitSystem
import trap_FX_AddScheduledEffects
import trap_FX_PlayBoltedEffectID
import trap_FX_PlayEntityEffectID
import trap_FX_PlayEffectID
import trap_FX_PlaySimpleEffectID
import trap_FX_PlayEntityEffect
import trap_FX_PlayEffect
import trap_FX_PlaySimpleEffect
import trap_FX_RegisterEffect
import trap_R_inPVS
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import BG_CycleForce
import BG_ProperForceIndex
import BG_CycleInven
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_OpenUIMenu
import trap_SetClientTurnExtent
import trap_SetClientForceAngle
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_FX_AddLine
import trap_R_GetBModelVerts
import trap_R_SetLightStyle
import trap_R_GetLightStyle
import trap_R_RemapShader
import trap_R_DrawRotatePic2
import trap_R_DrawRotatePic
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_AnyLanguage_ReadCharFromString
import trap_R_Font_DrawString
import trap_R_Font_HeightPixels
import trap_R_Font_StrLenChars
import trap_R_Font_StrLenPixels
import trap_R_RegisterFont
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_S_MuteSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_SagaObjectiveCompleted
import CG_SagaRoundOver
import CG_InitSagaMode
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_IsMindTricked
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_ProcessSnapshots
import CG_InitGlass
import CG_TestLine
import CG_SurfaceExplosion
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayer
import CG_ScorePlum
import CG_CreateDebris
import CG_GlassShatter
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawIconBackground
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_GetClientWeaponMuzzleBoltPoint
import TurretClientRun
import ScaleModelAxis
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_ManualEntityRender
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_ReattachLimb
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_PlayerShieldHit
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_DeferMenuScript
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawScaledProportionalString
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawNumField
import CG_DrawString
import CG_DrawRotatePic2
import CG_DrawRotatePic
import CG_DrawPic
import CG_FillRect
import CG_TestModelAnimate_f
import CG_TestModelSetAnglespost_f
import CG_TestModelSetAnglespre_f
import CG_ListModelBones_f
import CG_ListModelSurfaces_f
import CG_TestModelSurfaceOnOff_f
import CG_TestG2Model_f
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_PrevForcePower_f
import CG_NextForcePower_f
import CG_PrevInventory_f
import CG_NextInventory_f
import CG_BuildSpectatorString
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import cg_debugBB
import ui_myteam
import cg_recordSPDemoName
import cg_recordSPDemo
import cg_singlePlayerActive
import cg_enableBreath
import cg_enableDust
import cg_singlePlayer
import cg_currentSelectedPlayerName
import cg_currentSelectedPlayer
import cg_blueTeamName
import cg_redTeamName
import cg_trueLightning
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_cameraMode
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import pmove_msec
import pmove_fixed
import cg_smoothClients
import cg_hudFiles
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawEnemyInfo
import cg_lagometer
import cg_stereoSeparation
import cg_thirdPersonHorzOffset
import cg_thirdPersonAlpha
import cg_thirdPersonTargetDamp
import cg_thirdPersonCameraDamp
import cg_thirdPersonVertOffset
import cg_thirdPersonPitchOffset
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_thirdPerson
import cg_dismember
import cg_animBlend
import cg_auraShell
import cg_speedTrail
import cg_saberTrail
import cg_saberContact
import cg_swingAngles
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_ignore
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_dynamicCrosshair
import cg_drawScores
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
import CGCam_SetMusicMult
import CGCam_Shake
import cgScreenEffects
import ammoTicPos
import forceTicPos
import forcePowerDarkLight
import WeaponAttackAnim
import WeaponReadyAnim
import BG_OutOfMemory
import BG_StringAlloc
import BG_TempFree
import BG_TempAlloc
import BG_AllocUnaligned
import BG_Alloc
import BG_CanUseFPNow
import BG_HasYsalamiri
import BG_GetItemIndexByTag
import BG_ParseAnimationFile
import BG_PlayerTouchesItem
import BG_G2PlayerAngles
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_ForcePowerDrain
import BG_SaberStartTransAnim
import BG_InDeathAnim
import BG_InRoll
import BG_SaberInSpecialAttack
import BG_SpinningSaberAnim
import BG_FlippingAnim
import BG_SaberInIdle
import BG_SaberInSpecial
import BG_SaberInAttack
import BG_DirectFlippingAnim
import BG_InSaberStandAnim
import BG_InSpecialJump
import BG_LegalizedForcePowers
import saberMoveData
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import vectoyaw
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import pm
import bgForcePowerCost
import forceMasteryPoints
import forceMasteryLevels
import bgGlobalAnimations
import BGPAFtextLoaded
import forcePowerSorted
import WP_MuzzlePoint
import ammoData
import weaponData
import GetStringForID
import GetIDForString
import Q_irand
import irand
import flrand
import Rand_Init
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import SkipWhitespace
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import powf
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkBlue
import colorLtBlue
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import colorTable
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import forceSpeedLevels
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $139
char 1 115
char 1 118
char 1 99
char 1 95
char 1 108
char 1 105
char 1 103
char 1 104
char 1 116
char 1 115
char 1 116
char 1 121
char 1 108
char 1 101
char 1 32
char 1 108
char 1 101
char 1 110
char 1 103
char 1 116
char 1 104
char 1 61
char 1 37
char 1 105
char 1 0
