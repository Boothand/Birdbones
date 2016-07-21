export FX_DEMP2_ProjectileThink
code
proc FX_DEMP2_ProjectileThink 16 12
file "../fx_demp2.c"
line 12
;1:// DEMP2 Weapon
;2:
;3:#include "cg_local.h"
;4:
;5:/*
;6:---------------------------
;7:FX_DEMP2_ProjectileThink
;8:---------------------------
;9:*/
;10:
;11:void FX_DEMP2_ProjectileThink( centity_t *cent, const struct weaponInfo_s *weapon )
;12:{
line 15
;13:	vec3_t forward;
;14:
;15:	if ( VectorNormalize2( cent->currentState.pos.trDelta, forward ) == 0.0f )
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
line 16
;16:	{
line 17
;17:		forward[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 18
;18:	}
LABELV $121
line 20
;19:
;20:	trap_FX_PlayEffectID( cgs.effects.demp2ProjectileEffect, cent->lerpOrigin, forward );
ADDRGP4 cgs+71560+96
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
line 21
;21:}
LABELV $120
endproc FX_DEMP2_ProjectileThink 16 12
export FX_DEMP2_HitWall
proc FX_DEMP2_HitWall 0 12
line 30
;22:
;23:/*
;24:---------------------------
;25:FX_DEMP2_HitWall
;26:---------------------------
;27:*/
;28:
;29:void FX_DEMP2_HitWall( vec3_t origin, vec3_t normal )
;30:{
line 31
;31:	trap_FX_PlayEffectID( cgs.effects.demp2WallImpactEffect, origin, normal );
ADDRGP4 cgs+71560+100
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
line 32
;32:}
LABELV $126
endproc FX_DEMP2_HitWall 0 12
export FX_DEMP2_HitPlayer
proc FX_DEMP2_HitPlayer 0 12
line 41
;33:
;34:/*
;35:---------------------------
;36:FX_DEMP2_HitPlayer
;37:---------------------------
;38:*/
;39:
;40:void FX_DEMP2_HitPlayer( vec3_t origin, vec3_t normal, qboolean humanoid )
;41:{
line 42
;42:	trap_FX_PlayEffectID( cgs.effects.demp2FleshImpactEffect, origin, normal );
ADDRGP4 cgs+71560+104
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
line 43
;43:}
LABELV $129
endproc FX_DEMP2_HitPlayer 0 12
export FX_DEMP2_AltBeam
proc FX_DEMP2_AltBeam 0 0
line 52
;44:
;45:/*
;46:---------------------------
;47:FX_DEMP2_AltBeam
;48:---------------------------
;49:*/
;50:void FX_DEMP2_AltBeam( vec3_t start, vec3_t end, vec3_t normal, //qboolean spark, 
;51:								vec3_t targ1, vec3_t targ2 )
;52:{
line 237
;53://NOTENOTE Fix this after trap calls for all primitives are created.
;54:/*
;55:	vec3_t	dir, chaos,
;56:			c1, c2,
;57:			v1, v2;
;58:	float	len,
;59:			s1, s2, s3;
;60:
;61:	VectorSubtract( end, start, dir );
;62:	len = VectorNormalize( dir );
;63:
;64:	// Get the base control points, we'll work from there
;65:	VectorMA( start, 0.3333f * len, dir, c1 );
;66:	VectorMA( start, 0.6666f * len, dir, c2 );
;67:
;68:	// get some chaos values that really aren't very chaotic :)
;69:	s1 = sin( cg.time * 0.005f ) * 2 + crandom() * 0.2f;
;70:	s2 = sin( cg.time * 0.001f );
;71:	s3 = sin( cg.time * 0.011f );
;72:
;73:	VectorSet( chaos, len * 0.01f * s1,
;74:						len * 0.02f * s2,
;75:						len * 0.04f * (s1 + s2 + s3));
;76:
;77:	VectorAdd( c1, chaos, c1 );
;78:	VectorScale( chaos, 4.0f, v1 );
;79:
;80:	VectorSet( chaos, -len * 0.02f * s3,
;81:						len * 0.01f * (s1 * s2),
;82:						-len * 0.02f * (s1 + s2 * s3));
;83:
;84:	VectorAdd( c2, chaos, c2 );
;85:	VectorScale( chaos, 2.0f, v2 );
;86:
;87:	VectorSet( chaos, 1.0f, 1.0f, 1.0f );
;88:
;89:	FX_AddBezier( start, targ1,
;90:						c1, v1, c2, v2, 
;91:						5.0f + s1 * 2, 8.0f, 0.0f, 
;92:						1.0f, 0.0f, 0.0f,
;93:						chaos, chaos, 0.0f,
;94:						1.0f, trap_R_RegisterShader( "gfx/misc/electric2" ), FX_ALPHA_LINEAR );
;95:
;96:	FX_AddBezier( start, targ1,
;97:						c2, v2, c1, v1, 
;98:						3.0f + s3, 3.0f, 0.0f, 
;99:						1.0f, 0.0f, 0.0f,
;100:						chaos, chaos, 0.0f,
;101:						1.0f, trap_R_RegisterShader( "gfx/misc/electric2" ), FX_ALPHA_LINEAR );
;102:
;103:	s1 = sin( cg.time * 0.0005f ) + crandom() * 0.1f;
;104:	s2 = sin( cg.time * 0.0025f );
;105:	float cc2 = cos( cg.time * 0.0025f );
;106:	s3 = sin( cg.time * 0.01f ) + crandom() * 0.1f;
;107:
;108:	VectorSet( chaos, len * 0.08f * s2,
;109:						len * 0.04f * cc2,//s1 * -s3,
;110:						len * 0.06f * s3 );
;111:
;112:	VectorAdd( c1, chaos, c1 );
;113:	VectorScale( chaos, 4.0f, v1 );
;114:
;115:	VectorSet( chaos, len * 0.02f * s1 * s3,
;116:						len * 0.04f * s2,
;117:						len * 0.03f * s1 * s2 );
;118:
;119:	VectorAdd( c2, chaos, c2 );
;120:	VectorScale( chaos, 3.0f, v2 );
;121:
;122:	VectorSet( chaos, 1.0f, 1.0f, 1.0f );
;123:
;124:	FX_AddBezier( start, targ1,
;125:						c1, v1, c2, v2, 
;126:						4.0f + s3, 8.0f, 0.0f, 
;127:						1.0f, 0.0f, 0.0f,
;128:						chaos, chaos, 0.0f,
;129:						1.0f, trap_R_RegisterShader( "gfx/misc/electric2" ), FX_ALPHA_LINEAR );
;130:
;131:	FX_AddBezier( start, targ1,
;132:						c2, v1, c1, v2, 
;133:						5.0f + s1 * 2, 8.0f, 0.0f, 
;134:						1.0f, 0.0f, 0.0f,
;135:						chaos, chaos, 0.0f,
;136:						1.0f, trap_R_RegisterShader( "gfx/misc/electric2" ), FX_ALPHA_LINEAR );
;137:
;138:
;139:	VectorMA( start, 14.0f, dir, c1 );
;140:
;141:	FX_AddSprite( c1, NULL, NULL, 12.0f + crandom() * 4, 0.0f, 1.0f, 1.0f, random() * 360, 0.0f, 1.0f, 
;142:						trap_R_RegisterShader( "gfx/misc/lightningFlash" ));
;143:	FX_AddSprite( c1, NULL, NULL, 6.0f + crandom() * 2, 0.0f, 1.0f, 1.0f, random() * 360, 0.0f, 1.0f, 
;144:						trap_R_RegisterShader( "gfx/misc/lightningFlash" ));
;145:
;146:	FX_AddSprite( targ1, NULL, NULL, 4.0f + crandom(), 0.0f, 1.0f, 0.0f, chaos, chaos, random() * 360, 0.0f, 10, 
;147:						trap_R_RegisterShader( "gfx/misc/lightningFlash" ));
;148:	FX_AddSprite( targ1, NULL, NULL, 8.0f + crandom() * 2, 0.0f, 1.0f, 0.0f, chaos, chaos, random() * 360, 0.0f, 10, 
;149:						trap_R_RegisterShader( "gfx/misc/lightningFlash" ));
;150:
;151:
;152:	//--------------------------------------------
;153:
;154:	VectorSubtract( targ2, targ1, dir );
;155:	len = VectorNormalize( dir );
;156:
;157:	// Get the base control points, we'll work from there
;158:	VectorMA( targ1, 0.3333f * len, dir, c1 );
;159:	VectorMA( targ1, 0.6666f * len, dir, c2 );
;160:
;161:	// get some chaos values that really aren't very chaotic :)
;162:	s1 = sin( cg.time * 0.005f ) * 2 + crandom() * 0.2f;
;163:	s2 = sin( cg.time * 0.001f );
;164:	s3 = sin( cg.time * 0.011f );
;165:
;166:	VectorSet( chaos, len * 0.01f * s1,
;167:						len * 0.02f * s2,
;168:						len * 0.04f * (s1 + s2 + s3));
;169:
;170:	VectorAdd( c1, chaos, c1 );
;171:	VectorScale( chaos, 4.0f, v1 );
;172:
;173:	VectorSet( chaos, -len * 0.02f * s3,
;174:						len * 0.01f * (s1 * s2),
;175:						-len * 0.02f * (s1 + s2 * s3));
;176:
;177:	VectorAdd( c2, chaos, c2 );
;178:	VectorScale( chaos, 2.0f, v2 );
;179:
;180:	VectorSet( chaos, 1.0f, 1.0f, 1.0f );
;181:
;182:	FX_AddBezier( targ1, targ2,
;183:						c1, v1, c2, v2, 
;184:						5.0f + s1 * 2, 8.0f, 0.0f, 
;185:						1.0f, 0.0f, 0.0f,
;186:						chaos, chaos, 0.0f,
;187:						1.0f, trap_R_RegisterShader( "gfx/misc/electric2" ), FX_ALPHA_LINEAR );
;188:
;189:	FX_AddBezier( targ1, targ2,
;190:						c2, v2, c1, v1, 
;191:						3.0f + s3, 3.0f, 0.0f, 
;192:						1.0f, 0.0f, 0.0f,
;193:						chaos, chaos, 0.0f,
;194:						1.0f, trap_R_RegisterShader( "gfx/misc/electric2" ), FX_ALPHA_LINEAR );
;195:
;196:	s1 = sin( cg.time * 0.0005f ) + crandom() * 0.1f;
;197:	s2 = sin( cg.time * 0.0025f );
;198:	cc2 = cos( cg.time * 0.0025f );
;199:	s3 = sin( cg.time * 0.01f ) + crandom() * 0.1f;
;200:
;201:	VectorSet( chaos, len * 0.08f * s2,
;202:						len * 0.04f * cc2,//s1 * -s3,
;203:						len * 0.06f * s3 );
;204:
;205:	VectorAdd( c1, chaos, c1 );
;206:	VectorScale( chaos, 4.0f, v1 );
;207:
;208:	VectorSet( chaos, len * 0.02f * s1 * s3,
;209:						len * 0.04f * s2,
;210:						len * 0.03f * s1 * s2 );
;211:
;212:	VectorAdd( c2, chaos, c2 );
;213:	VectorScale( chaos, 3.0f, v2 );
;214:
;215:	VectorSet( chaos, 1.0f, 1.0f, 1.0f );
;216:
;217:	FX_AddBezier( targ1, targ2,
;218:						c1, v1, c2, v2, 
;219:						4.0f + s3, 8.0f, 0.0f, 
;220:						1.0f, 0.0f, 0.0f,
;221:						chaos, chaos, 0.0f,
;222:						1.0f, trap_R_RegisterShader( "gfx/misc/electric2" ), FX_ALPHA_LINEAR );
;223:
;224:	FX_AddBezier( targ1, targ2,
;225:						c2, v1, c1, v2, 
;226:						5.0f + s1 * 2, 8.0f, 0.0f, 
;227:						1.0f, 0.0f, 0.0f,
;228:						chaos, chaos, 0.0f,
;229:						1.0f, trap_R_RegisterShader( "gfx/misc/electric2" ), FX_ALPHA_LINEAR );
;230:
;231:
;232:	FX_AddSprite( targ2, NULL, NULL, 4.0f + crandom(), 0.0f, 1.0f, 0.0f, chaos, chaos, random() * 360, 0.0f, 10, 
;233:						trap_R_RegisterShader( "gfx/misc/lightningFlash" ));
;234:	FX_AddSprite( targ2, NULL, NULL, 8.0f + crandom() * 2, 0.0f, 1.0f, 0.0f, chaos, chaos, random() * 360, 0.0f, 10, 
;235:						trap_R_RegisterShader( "gfx/misc/lightningFlash" ));
;236:*/
;237:}
LABELV $132
endproc FX_DEMP2_AltBeam 0 0
export FX_DEMP2_AltDetonate
proc FX_DEMP2_AltDetonate 24 12
line 241
;238:
;239://---------------------------------------------
;240:void FX_DEMP2_AltDetonate( vec3_t org, float size )
;241:{
line 244
;242:	localEntity_t	*ex;
;243:
;244:	ex = CG_AllocLocalEntity();
ADDRLP4 4
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 245
;245:	ex->leType = LE_FADE_SCALE_MODEL;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 3
ASGNI4
line 246
;246:	memset( &ex->refEntity, 0, sizeof( refEntity_t ));
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 248
;247:
;248:	ex->refEntity.renderfx |= RF_VOLUMETRIC;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 250
;249:
;250:	ex->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 251
;251:	ex->endTime = ex->startTime + 800;//1600;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 800
ADDI4
ASGNI4
line 253
;252:	
;253:	ex->radius = size;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 254
;254:	ex->refEntity.customShader = cgs.media.demp2ShellShader;
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
ADDRGP4 cgs+70280+924
INDIRI4
ASGNI4
line 255
;255:	ex->refEntity.hModel = cgs.media.demp2Shell;
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDRGP4 cgs+70280+920
INDIRI4
ASGNI4
line 256
;256:	VectorCopy( org, ex->refEntity.origin );
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 258
;257:		
;258:	ex->color[0] = ex->color[1] = ex->color[2] = 255.0f;
ADDRLP4 20
CNSTF4 1132396544
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 259
;259:}
LABELV $133
endproc FX_DEMP2_AltDetonate 24 12
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
