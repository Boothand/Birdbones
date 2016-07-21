export FX_BryarProjectileThink
code
proc FX_BryarProjectileThink 16 12
file "../fx_bryarpistol.c"
line 15
;1:// Bryar Pistol Weapon Effects
;2:
;3:#include "cg_local.h"
;4:
;5:/*
;6:-------------------------
;7:
;8:	MAIN FIRE
;9:
;10:-------------------------
;11:FX_BryarProjectileThink
;12:-------------------------
;13:*/
;14:void FX_BryarProjectileThink(  centity_t *cent, const struct weaponInfo_s *weapon )
;15:{
line 18
;16:	vec3_t forward;
;17:
;18:	if ( VectorNormalize2( cent->currentState.pos.trDelta, forward ) == 0.0f )
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $121
line 19
;19:	{
line 20
;20:		forward[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 21
;21:	}
LABELV $121
line 23
;22:
;23:	trap_FX_PlayEffectID( cgs.effects.bryarShotEffect, cent->lerpOrigin, forward );
ADDRGP4 cgs+71560
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 24
;24:}
LABELV $120
endproc FX_BryarProjectileThink 16 12
export FX_BryarHitWall
proc FX_BryarHitWall 0 12
line 32
;25:
;26:/*
;27:-------------------------
;28:FX_BryarHitWall
;29:-------------------------
;30:*/
;31:void FX_BryarHitWall( vec3_t origin, vec3_t normal )
;32:{
line 33
;33:	trap_FX_PlayEffectID( cgs.effects.bryarWallImpactEffect, origin, normal );
ADDRGP4 cgs+71560+8
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 34
;34:}
LABELV $125
endproc FX_BryarHitWall 0 12
export FX_BryarHitPlayer
proc FX_BryarHitPlayer 0 12
line 42
;35:
;36:/*
;37:-------------------------
;38:FX_BryarHitPlayer
;39:-------------------------
;40:*/
;41:void FX_BryarHitPlayer( vec3_t origin, vec3_t normal, qboolean humanoid )
;42:{
line 43
;43:	if ( humanoid )
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $129
line 44
;44:	{
line 45
;45:		trap_FX_PlayEffectID( cgs.effects.bryarFleshImpactEffect, origin, normal );
ADDRGP4 cgs+71560+20
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 46
;46:	}
ADDRGP4 $130
JUMPV
LABELV $129
line 48
;47:	else
;48:	{
line 49
;49:		trap_FX_PlayEffectID( cgs.effects.bryarDroidImpactEffect, origin, normal );
ADDRGP4 cgs+71560+24
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 50
;50:	}
LABELV $130
line 51
;51:}
LABELV $128
endproc FX_BryarHitPlayer 0 12
export FX_BryarAltProjectileThink
proc FX_BryarAltProjectileThink 20 12
line 64
;52:
;53:
;54:/*
;55:-------------------------
;56:
;57:	ALT FIRE
;58:
;59:-------------------------
;60:FX_BryarAltProjectileThink
;61:-------------------------
;62:*/
;63:void FX_BryarAltProjectileThink(  centity_t *cent, const struct weaponInfo_s *weapon )
;64:{
line 68
;65:	vec3_t forward;
;66:	int t;
;67:
;68:	if ( VectorNormalize2( cent->currentState.pos.trDelta, forward ) == 0.0f )
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 16
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
CNSTF4 0
NEF4 $136
line 69
;69:	{
line 70
;70:		forward[2] = 1.0f;
ADDRLP4 4+8
CNSTF4 1065353216
ASGNF4
line 71
;71:	}
LABELV $136
line 74
;72:
;73:	// see if we have some sort of extra charge going on
;74:	for (t = 1; t < cent->currentState.generic1; t++ )
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $142
JUMPV
LABELV $139
line 75
;75:	{
line 77
;76:		// just add ourselves over, and over, and over when we are charged
;77:		trap_FX_PlayEffectID( cgs.effects.bryarPowerupShotEffect, cent->lerpOrigin, forward );
ADDRGP4 cgs+71560+4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 78
;78:	}
LABELV $140
line 74
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $142
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
LTI4 $139
line 82
;79:
;80:	//	for ( int t = 1; t < cent->gent->count; t++ )	// The single player stores the charge in count, which isn't accessible on the client
;81:
;82:	trap_FX_PlayEffectID( cgs.effects.bryarShotEffect, cent->lerpOrigin, forward );
ADDRGP4 cgs+71560
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 83
;83:}
LABELV $135
endproc FX_BryarAltProjectileThink 20 12
export FX_BryarAltHitWall
proc FX_BryarAltHitWall 8 12
line 91
;84:
;85:/*
;86:-------------------------
;87:FX_BryarAltHitWall
;88:-------------------------
;89:*/
;90:void FX_BryarAltHitWall( vec3_t origin, vec3_t normal, int power )
;91:{
line 92
;92:	switch( power )
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $147
ADDRLP4 0
INDIRI4
CNSTI4 5
GTI4 $147
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LSHI4
ADDRGP4 $157-8
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $157
address $152
address $152
address $149
address $149
code
line 93
;93:	{
LABELV $149
line 96
;94:	case 4:
;95:	case 5:
;96:		trap_FX_PlayEffectID( cgs.effects.bryarWallImpactEffect3, origin, normal );
ADDRGP4 cgs+71560+16
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 97
;97:		break;
ADDRGP4 $148
JUMPV
LABELV $152
line 101
;98:
;99:	case 2:
;100:	case 3:
;101:		trap_FX_PlayEffectID( cgs.effects.bryarWallImpactEffect2, origin, normal );
ADDRGP4 cgs+71560+12
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 102
;102:		break;
ADDRGP4 $148
JUMPV
LABELV $147
line 105
;103:
;104:	default:
;105:		trap_FX_PlayEffectID( cgs.effects.bryarWallImpactEffect, origin, normal );
ADDRGP4 cgs+71560+8
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 106
;106:		break;
LABELV $148
line 108
;107:	}
;108:}
LABELV $146
endproc FX_BryarAltHitWall 8 12
export FX_BryarAltHitPlayer
proc FX_BryarAltHitPlayer 0 12
line 116
;109:
;110:/*
;111:-------------------------
;112:FX_BryarAltHitPlayer
;113:-------------------------
;114:*/
;115:void FX_BryarAltHitPlayer( vec3_t origin, vec3_t normal, qboolean humanoid )
;116:{
line 117
;117:	if ( humanoid )
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $160
line 118
;118:	{
line 119
;119:		trap_FX_PlayEffectID( cgs.effects.bryarFleshImpactEffect, origin, normal );
ADDRGP4 cgs+71560+20
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 120
;120:	}
ADDRGP4 $161
JUMPV
LABELV $160
line 122
;121:	else
;122:	{
line 123
;123:		trap_FX_PlayEffectID( cgs.effects.bryarDroidImpactEffect, origin, normal );
ADDRGP4 cgs+71560+24
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 124
;124:	}
LABELV $161
line 125
;125:}
LABELV $159
endproc FX_BryarAltHitPlayer 0 12
export FX_TurretProjectileThink
proc FX_TurretProjectileThink 16 12
line 135
;126:
;127:
;128://TURRET
;129:/*
;130:-------------------------
;131:FX_TurretProjectileThink
;132:-------------------------
;133:*/
;134:void FX_TurretProjectileThink(  centity_t *cent, const struct weaponInfo_s *weapon )
;135:{
line 138
;136:	vec3_t forward;
;137:
;138:	if ( VectorNormalize2( cent->currentState.pos.trDelta, forward ) == 0.0f )
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $167
line 139
;139:	{
line 140
;140:		forward[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 141
;141:	}
LABELV $167
line 143
;142:
;143:	trap_FX_PlayEffectID( cgs.effects.turretShotEffect, cent->lerpOrigin, forward );
ADDRGP4 cgs+71560+164
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 144
;144:}
LABELV $166
endproc FX_TurretProjectileThink 16 12
export FX_TurretHitWall
proc FX_TurretHitWall 0 12
line 152
;145:
;146:/*
;147:-------------------------
;148:FX_TurretHitWall
;149:-------------------------
;150:*/
;151:void FX_TurretHitWall( vec3_t origin, vec3_t normal )
;152:{
line 153
;153:	trap_FX_PlayEffectID( cgs.effects.bryarWallImpactEffect, origin, normal );
ADDRGP4 cgs+71560+8
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 154
;154:}
LABELV $172
endproc FX_TurretHitWall 0 12
export FX_TurretHitPlayer
proc FX_TurretHitPlayer 0 12
line 162
;155:
;156:/*
;157:-------------------------
;158:FX_TurretHitPlayer
;159:-------------------------
;160:*/
;161:void FX_TurretHitPlayer( vec3_t origin, vec3_t normal, qboolean humanoid )
;162:{
line 163
;163:	if ( humanoid )
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $176
line 164
;164:	{
line 165
;165:		trap_FX_PlayEffectID( cgs.effects.bryarFleshImpactEffect, origin, normal );
ADDRGP4 cgs+71560+20
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 166
;166:	}
ADDRGP4 $177
JUMPV
LABELV $176
line 168
;167:	else
;168:	{
line 169
;169:		trap_FX_PlayEffectID( cgs.effects.bryarDroidImpactEffect, origin, normal );
ADDRGP4 cgs+71560+24
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 170
;170:	}
LABELV $177
line 171
;171:}
LABELV $175
endproc FX_TurretHitPlayer 0 12
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
import CG_Spark
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
