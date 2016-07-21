data
align 4
LABELV WHITE
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export FX_DisruptorMainShot
code
proc FX_DisruptorMainShot 12 56
file "../fx_disruptor.c"
line 14
;1:// Disruptor Weapon
;2:
;3:#include "cg_local.h"
;4:#include "fx_local.h"
;5:
;6:/*
;7:---------------------------
;8:FX_DisruptorMainShot
;9:---------------------------
;10:*/
;11:static vec3_t WHITE={1.0f,1.0f,1.0f};
;12:
;13:void FX_DisruptorMainShot( vec3_t start, vec3_t end )
;14:{
line 18
;15://	vec3_t	dir;
;16://	float	len;
;17:
;18:	trap_FX_AddLine( start, end, 0.1f, 6.0f, 0.0f, 
ADDRGP4 $121
ARGP4
ADDRLP4 0
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1036831949
ARGF4
CNSTF4 1086324736
ARGF4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 WHITE
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 150
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 257
ARGI4
ADDRGP4 trap_FX_AddLine
CALLV
pop
line 33
;19:							1.0f, 0.0f, 0.0f,
;20:							WHITE, WHITE, 0.0f,
;21:							150, trap_R_RegisterShader( "gfx/effects/redLine" ), 
;22:							FX_SIZE_LINEAR | FX_ALPHA_LINEAR );
;23:
;24://	VectorSubtract( end, start, dir );
;25://	len = VectorNormalize( dir );
;26:
;27://	FX_AddCylinder( start, dir, 5.0f, 5.0f, 0.0f,
;28://								5.0f, 5.0f, 0.0f,
;29://								len, len, 0.0f,
;30://								1.0f, 1.0f, 0.0f,
;31://								WHITE, WHITE, 0.0f,
;32://								400, cgi_R_RegisterShader( "gfx/effects/spiral" ), 0 );
;33:}
LABELV $120
endproc FX_DisruptorMainShot 12 56
lit
align 4
LABELV $125
byte 4 1061997773
byte 4 1060320051
byte 4 0
export FX_DisruptorAltShot
code
proc FX_DisruptorAltShot 32 56
line 42
;34:
;35:
;36:/*
;37:---------------------------
;38:FX_DisruptorAltShot
;39:---------------------------
;40:*/
;41:void FX_DisruptorAltShot( vec3_t start, vec3_t end, qboolean fullCharge )
;42:{
line 43
;43:	trap_FX_AddLine( start, end, 0.1f, 10.0f, 0.0f, 
ADDRGP4 $121
ARGP4
ADDRLP4 0
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1036831949
ARGF4
CNSTF4 1092616192
ARGF4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 WHITE
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 175
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 257
ARGI4
ADDRGP4 trap_FX_AddLine
CALLV
pop
line 49
;44:							1.0f, 0.0f, 0.0f,
;45:							WHITE, WHITE, 0.0f,
;46:							175, trap_R_RegisterShader( "gfx/effects/redLine" ), 
;47:							FX_SIZE_LINEAR | FX_ALPHA_LINEAR );
;48:
;49:	if ( fullCharge )
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $123
line 50
;50:	{
line 51
;51:		vec3_t	YELLER={0.8f,0.7f,0.0f};
ADDRLP4 12
ADDRGP4 $125
INDIRB
ASGNB 12
line 54
;52:
;53:		// add some beef
;54:		trap_FX_AddLine( start, end, 0.1f, 7.0f, 0.0f, 
ADDRGP4 $126
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1036831949
ARGF4
CNSTF4 1088421888
ARGF4
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 12
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
INDIRF4
ARGF4
CNSTI4 150
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
CNSTI4 257
ARGI4
ADDRGP4 trap_FX_AddLine
CALLV
pop
line 59
;55:							1.0f, 0.0f, 0.0f,
;56:							YELLER, YELLER, 0.0f,
;57:							150, trap_R_RegisterShader( "gfx/misc/whiteline2" ), 
;58:							FX_SIZE_LINEAR | FX_ALPHA_LINEAR );
;59:	}
LABELV $123
line 60
;60:}
LABELV $122
endproc FX_DisruptorAltShot 32 56
export FX_DisruptorAltMiss
proc FX_DisruptorAltMiss 212 12
line 71
;61:
;62:
;63:/*
;64:---------------------------
;65:FX_DisruptorAltMiss
;66:---------------------------
;67:*/
;68:#define FX_ALPHA_WAVE		0x00000008
;69:
;70:void FX_DisruptorAltMiss( vec3_t origin, vec3_t normal )
;71:{
line 75
;72:	vec3_t pos, c1, c2;
;73:	addbezierArgStruct_t b;
;74:
;75:	VectorMA( origin, 4.0f, normal, c1 );
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
CNSTF4 1082130432
ASGNF4
ADDRLP4 180
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 172
INDIRP4
INDIRF4
ADDRLP4 176
INDIRF4
ADDRLP4 180
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 184
CNSTI4 4
ASGNI4
ADDRLP4 136+4
ADDRLP4 172
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
INDIRF4
ADDRLP4 176
INDIRF4
ADDRLP4 180
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 188
CNSTI4 8
ASGNI4
ADDRLP4 136+8
ADDRFP4 0
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRF4
CNSTF4 1082130432
ADDRFP4 4
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 76
;76:	VectorCopy( c1, c2 );
ADDRLP4 160
ADDRLP4 136
INDIRB
ASGNB 12
line 77
;77:	c1[2] += 4;
ADDRLP4 136+8
ADDRLP4 136+8
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 78
;78:	c2[2] += 12;
ADDRLP4 160+8
ADDRLP4 160+8
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 80
;79:	
;80:	VectorAdd( origin, normal, pos );
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 148
ADDRLP4 192
INDIRP4
INDIRF4
ADDRLP4 196
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 200
CNSTI4 4
ASGNI4
ADDRLP4 148+4
ADDRLP4 192
INDIRP4
ADDRLP4 200
INDIRI4
ADDP4
INDIRF4
ADDRLP4 196
INDIRP4
ADDRLP4 200
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 204
CNSTI4 8
ASGNI4
ADDRLP4 148+8
ADDRFP4 0
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 81
;81:	pos[2] += 28;
ADDRLP4 148+8
ADDRLP4 148+8
INDIRF4
CNSTF4 1105199104
ADDF4
ASGNF4
line 88
;82:
;83:	/*
;84:	FX_AddBezier( origin, pos, c1, vec3_origin, c2, vec3_origin, 6.0f, 6.0f, 0.0f, 0.0f, 0.2f, 0.5f,
;85:	WHITE, WHITE, 0.0f, 4000, trap_R_RegisterShader( "gfx/effects/smokeTrail" ), FX_ALPHA_WAVE );
;86:	*/
;87:
;88:	VectorCopy(origin, b.start);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 89
;89:	VectorCopy(pos, b.end);
ADDRLP4 0+12
ADDRLP4 148
INDIRB
ASGNB 12
line 90
;90:	VectorCopy(c1, b.control1);
ADDRLP4 0+24
ADDRLP4 136
INDIRB
ASGNB 12
line 91
;91:	VectorCopy(vec3_origin, b.control1Vel);
ADDRLP4 0+36
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 92
;92:	VectorCopy(c2, b.control2);
ADDRLP4 0+48
ADDRLP4 160
INDIRB
ASGNB 12
line 93
;93:	VectorCopy(vec3_origin, b.control2Vel);
ADDRLP4 0+60
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 95
;94:
;95:	b.size1 = 6.0f;
ADDRLP4 0+72
CNSTF4 1086324736
ASGNF4
line 96
;96:	b.size2 = 6.0f;
ADDRLP4 0+76
CNSTF4 1086324736
ASGNF4
line 97
;97:	b.sizeParm = 0.0f;
ADDRLP4 0+80
CNSTF4 0
ASGNF4
line 98
;98:	b.alpha1 = 0.0f;
ADDRLP4 0+84
CNSTF4 0
ASGNF4
line 99
;99:	b.alpha2 = 0.2f;
ADDRLP4 0+88
CNSTF4 1045220557
ASGNF4
line 100
;100:	b.alphaParm = 0.5f;
ADDRLP4 0+92
CNSTF4 1056964608
ASGNF4
line 102
;101:	
;102:	VectorCopy(WHITE, b.sRGB);
ADDRLP4 0+96
ADDRGP4 WHITE
INDIRB
ASGNB 12
line 103
;103:	VectorCopy(WHITE, b.eRGB);
ADDRLP4 0+108
ADDRGP4 WHITE
INDIRB
ASGNB 12
line 105
;104:
;105:	b.rgbParm = 0.0f;
ADDRLP4 0+120
CNSTF4 0
ASGNF4
line 106
;106:	b.killTime = 4000;
ADDRLP4 0+124
CNSTI4 4000
ASGNI4
line 107
;107:	b.shader = trap_R_RegisterShader( "gfx/effects/smokeTrail" );
ADDRGP4 $151
ARGP4
ADDRLP4 208
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0+128
ADDRLP4 208
INDIRI4
ASGNI4
line 108
;108:	b.flags = FX_ALPHA_WAVE;
ADDRLP4 0+132
CNSTI4 8
ASGNI4
line 110
;109:
;110:	trap_FX_AddBezier(&b);
ADDRLP4 0
ARGP4
ADDRGP4 trap_FX_AddBezier
CALLV
pop
line 112
;111:
;112:	trap_FX_PlayEffectID( cgs.effects.disruptorAltMissEffect, origin, normal );
ADDRGP4 cgs+71560+60
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
line 113
;113:}
LABELV $127
endproc FX_DisruptorAltMiss 212 12
export FX_DisruptorAltHit
proc FX_DisruptorAltHit 0 12
line 122
;114:
;115:/*
;116:---------------------------
;117:FX_DisruptorAltHit
;118:---------------------------
;119:*/
;120:
;121:void FX_DisruptorAltHit( vec3_t origin, vec3_t normal )
;122:{
line 123
;123:	trap_FX_PlayEffectID( cgs.effects.disruptorAltHitEffect, origin, normal );
ADDRGP4 cgs+71560+64
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
;124:}
LABELV $155
endproc FX_DisruptorAltHit 0 12
export FX_DisruptorHitWall
proc FX_DisruptorHitWall 0 12
line 135
;125:
;126:
;127:
;128:/*
;129:---------------------------
;130:FX_DisruptorHitWall
;131:---------------------------
;132:*/
;133:
;134:void FX_DisruptorHitWall( vec3_t origin, vec3_t normal )
;135:{
line 136
;136:	trap_FX_PlayEffectID( cgs.effects.disruptorWallImpactEffect, origin, normal );
ADDRGP4 cgs+71560+52
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
line 137
;137:}
LABELV $158
endproc FX_DisruptorHitWall 0 12
export FX_DisruptorHitPlayer
proc FX_DisruptorHitPlayer 0 12
line 146
;138:
;139:/*
;140:---------------------------
;141:FX_DisruptorHitPlayer
;142:---------------------------
;143:*/
;144:
;145:void FX_DisruptorHitPlayer( vec3_t origin, vec3_t normal, qboolean humanoid )
;146:{
line 147
;147:	trap_FX_PlayEffectID( cgs.effects.disruptorFleshImpactEffect, origin, normal );
ADDRGP4 cgs+71560+56
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
line 148
;148:}
LABELV $161
endproc FX_DisruptorHitPlayer 0 12
import FX_RocketHitPlayer
import FX_RocketHitWall
import FX_RocketAltProjectileThink
import FX_RocketProjectileThink
import FX_FlechetteAltProjectileThink
import FX_FlechetteWeaponHitPlayer
import FX_FlechetteWeaponHitWall
import FX_FlechetteProjectileThink
import FX_DEMP2_AltDetonate
import FX_DEMP2_HitPlayer
import FX_DEMP2_HitWall
import FX_DEMP2_ProjectileThink
import FX_RepeaterAltHitPlayer
import FX_RepeaterHitPlayer
import FX_RepeaterAltHitWall
import FX_RepeaterHitWall
import FX_RepeaterAltProjectileThink
import FX_RepeaterProjectileThink
import FX_BowcasterHitPlayer
import FX_BowcasterHitWall
import FX_BowcasterAltProjectileThink
import FX_BowcasterProjectileThink
import FX_BryarAltProjectileThink
import FX_BryarProjectileThink
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
LABELV $151
char 1 103
char 1 102
char 1 120
char 1 47
char 1 101
char 1 102
char 1 102
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 115
char 1 109
char 1 111
char 1 107
char 1 101
char 1 84
char 1 114
char 1 97
char 1 105
char 1 108
char 1 0
align 1
LABELV $126
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 119
char 1 104
char 1 105
char 1 116
char 1 101
char 1 108
char 1 105
char 1 110
char 1 101
char 1 50
char 1 0
align 1
LABELV $121
char 1 103
char 1 102
char 1 120
char 1 47
char 1 101
char 1 102
char 1 102
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 114
char 1 101
char 1 100
char 1 76
char 1 105
char 1 110
char 1 101
char 1 0
