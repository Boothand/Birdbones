export CG_SetGhoul2InfoRef
code
proc CG_SetGhoul2InfoRef 16 0
file "../cg_weapons.c"
line 16
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_weapons.c -- events and effects dealing with weapons
;4:#include "cg_local.h"
;5:#include "fx_local.h"
;6:
;7:extern vec4_t	bluehudtint;
;8:extern vec4_t	redhudtint;
;9:extern float	*hudTintColor;
;10:
;11:/*
;12:Ghoul2 Insert Start
;13:*/
;14:// set up the appropriate ghoul2 info to a refent
;15:void CG_SetGhoul2InfoRef( refEntity_t *ent, refEntity_t	*s1)
;16:{
line 17
;17:	ent->ghoul2 = s1->ghoul2;
ADDRLP4 0
CNSTI4 208
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 18
;18:	VectorCopy( s1->modelScale, ent->modelScale);
ADDRLP4 4
CNSTI4 196
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 19
;19:	ent->radius = s1->radius;
ADDRLP4 8
CNSTI4 92
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 20
;20:	VectorCopy( s1->angles, ent->angles);
ADDRLP4 12
CNSTI4 184
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 21
;21:}
LABELV $120
endproc CG_SetGhoul2InfoRef 16 0
export CG_RegisterItemVisuals
proc CG_RegisterItemVisuals 48 28
line 34
;22:
;23:/*
;24:Ghoul2 Insert End
;25:*/
;26:
;27:/*
;28:=================
;29:CG_RegisterItemVisuals
;30:
;31:The server says this item is used on this level
;32:=================
;33:*/
;34:void CG_RegisterItemVisuals( int itemNum ) {
line 39
;35:	itemInfo_t		*itemInfo;
;36:	gitem_t			*item;
;37:	int				handle;
;38:
;39:	if ( itemNum < 0 || itemNum >= bg_numItems ) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $124
ADDRLP4 12
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $122
LABELV $124
line 40
;40:		CG_Error( "CG_RegisterItemVisuals: itemNum %d out of range [0-%d]", itemNum, bg_numItems-1 );
ADDRGP4 $125
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 bg_numItems
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 41
;41:	}
LABELV $122
line 43
;42:
;43:	itemInfo = &cg_items[ itemNum ];
ADDRLP4 4
CNSTI4 56
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_items
ADDP4
ASGNP4
line 44
;44:	if ( itemInfo->registered ) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $126
line 45
;45:		return;
ADDRGP4 $121
JUMPV
LABELV $126
line 48
;46:	}
;47:
;48:	item = &bg_itemlist[ itemNum ];
ADDRLP4 0
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 50
;49:
;50:	memset( itemInfo, 0, sizeof( &itemInfo ) );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 51
;51:	itemInfo->registered = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 53
;52:
;53:	if (item->giType == IT_TEAM &&
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $128
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $131
ADDRLP4 20
INDIRI4
CNSTI4 5
NEI4 $128
LABELV $131
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $128
line 56
;54:		(item->giTag == PW_REDFLAG || item->giTag == PW_BLUEFLAG) &&
;55:		cgs.gametype == GT_CTY)
;56:	{ //in CTY the flag model is different
line 57
;57:		itemInfo->models[0] = trap_R_RegisterModel( item->world_model[1] );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 58
;58:	}
ADDRGP4 $129
JUMPV
LABELV $128
line 59
;59:	else if (item->giType == IT_WEAPON &&
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $132
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 11
EQI4 $135
ADDRLP4 28
INDIRI4
CNSTI4 12
EQI4 $135
ADDRLP4 28
INDIRI4
CNSTI4 13
NEI4 $132
LABELV $135
line 61
;60:		(item->giTag == WP_THERMAL || item->giTag == WP_TRIP_MINE || item->giTag == WP_DET_PACK))
;61:	{
line 62
;62:		itemInfo->models[0] = trap_R_RegisterModel( item->world_model[1] );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 63
;63:	}
ADDRGP4 $133
JUMPV
LABELV $132
line 65
;64:	else
;65:	{
line 66
;66:		itemInfo->models[0] = trap_R_RegisterModel( item->world_model[0] );
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 67
;67:	}
LABELV $133
LABELV $129
line 71
;68:/*
;69:Ghoul2 Insert Start
;70:*/
;71:	if (!Q_stricmp(&item->world_model[0][strlen(item->world_model[0]) - 4], ".glm"))
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 4
SUBI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ADDP4
ARGP4
ADDRGP4 $138
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $136
line 72
;72:	{
line 73
;73:		handle = trap_G2API_InitGhoul2Model(&itemInfo->g2Models[0], item->world_model[0], 0 , 0, 0, 0, 0);
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 trap_G2API_InitGhoul2Model
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 44
INDIRI4
ASGNI4
line 74
;74:		if (handle<0)
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $139
line 75
;75:		{
line 76
;76:			itemInfo->g2Models[0] = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTP4 0
ASGNP4
line 77
;77:		}
ADDRGP4 $140
JUMPV
LABELV $139
line 79
;78:		else
;79:		{
line 80
;80:			itemInfo->radius[0] = 60;
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1114636288
ASGNF4
line 81
;81:		}
LABELV $140
line 82
;82:	}
LABELV $136
line 86
;83:/*
;84:Ghoul2 Insert End
;85:*/
;86:	if (item->icon)
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $141
line 87
;87:	{
line 88
;88:		itemInfo->icon = trap_R_RegisterShader( item->icon );
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 89
;89:	}
ADDRGP4 $142
JUMPV
LABELV $141
line 91
;90:	else
;91:	{
line 92
;92:		itemInfo->icon = 0;
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 93
;93:	}
LABELV $142
line 95
;94:
;95:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $143
line 96
;96:		CG_RegisterWeapon( item->giTag );
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_RegisterWeapon
CALLV
pop
line 97
;97:	}
LABELV $143
line 102
;98:
;99:	//
;100:	// powerups have an accompanying ring or sphere
;101:	//
;102:	if ( item->giType == IT_POWERUP || item->giType == IT_HEALTH || 
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 5
EQI4 $149
ADDRLP4 40
INDIRI4
CNSTI4 4
EQI4 $149
ADDRLP4 40
INDIRI4
CNSTI4 3
EQI4 $149
ADDRLP4 40
INDIRI4
CNSTI4 6
NEI4 $145
LABELV $149
line 103
;103:		item->giType == IT_ARMOR || item->giType == IT_HOLDABLE ) {
line 104
;104:		if ( item->world_model[1] ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $150
line 105
;105:			itemInfo->models[1] = trap_R_RegisterModel( item->world_model[1] );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 106
;106:		}
LABELV $150
line 107
;107:	}
LABELV $145
line 108
;108:}
LABELV $121
endproc CG_RegisterItemVisuals 48 28
data
align 4
LABELV cgWeapFrame
byte 4 0
align 4
LABELV cgWeapFrameTime
byte 4 0
code
proc CG_MapTorsoToWeaponFrame 40 0
line 133
;109:
;110:
;111:/*
;112:========================================================================================
;113:
;114:VIEW WEAPON
;115:
;116:========================================================================================
;117:*/
;118:
;119:#define WEAPON_FORCE_BUSY_HOLSTER
;120:
;121:#ifdef WEAPON_FORCE_BUSY_HOLSTER
;122://rww - this was done as a last resort. Forgive me.
;123:static int cgWeapFrame = 0;
;124:static int cgWeapFrameTime = 0;
;125:#endif
;126:
;127:/*
;128:=================
;129:CG_MapTorsoToWeaponFrame
;130:
;131:=================
;132:*/
;133:static int CG_MapTorsoToWeaponFrame( clientInfo_t *ci, int frame, int animNum ) {
line 134
;134:	animation_t *animations = bgGlobalAnimations;
ADDRLP4 0
ADDRGP4 bgGlobalAnimations
ASGNP4
line 136
;135:#ifdef WEAPON_FORCE_BUSY_HOLSTER
;136:	if (cg.snap->ps.forceHandExtend != HANDEXTEND_NONE || cgWeapFrameTime > cg.time)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1280
ADDP4
INDIRI4
CNSTI4 0
NEI4 $157
ADDRGP4 cgWeapFrameTime
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $153
LABELV $157
line 137
;137:	{ //the reason for the after delay is so that it doesn't snap the weapon frame to the "idle" (0) frame
line 139
;138:		//for a very quick moment
;139:		if (cgWeapFrame < 6)
ADDRGP4 cgWeapFrame
INDIRI4
CNSTI4 6
GEI4 $158
line 140
;140:		{
line 141
;141:			cgWeapFrame = 6;
ADDRGP4 cgWeapFrame
CNSTI4 6
ASGNI4
line 142
;142:			cgWeapFrameTime = cg.time + 10;
ADDRGP4 cgWeapFrameTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 143
;143:		}
LABELV $158
line 145
;144:
;145:		if (cgWeapFrameTime < cg.time && cgWeapFrame < 10)
ADDRGP4 cgWeapFrameTime
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $161
ADDRGP4 cgWeapFrame
INDIRI4
CNSTI4 10
GEI4 $161
line 146
;146:		{
line 147
;147:			cgWeapFrame++;
ADDRLP4 4
ADDRGP4 cgWeapFrame
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 148
;148:			cgWeapFrameTime = cg.time + 10;
ADDRGP4 cgWeapFrameTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 149
;149:		}
LABELV $161
line 151
;150:
;151:		if (cg.snap->ps.forceHandExtend != HANDEXTEND_NONE &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 1280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $165
ADDRGP4 cgWeapFrame
INDIRI4
CNSTI4 10
NEI4 $165
line 153
;152:			cgWeapFrame == 10)
;153:		{
line 154
;154:			cgWeapFrameTime = cg.time + 100;
ADDRGP4 cgWeapFrameTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 155
;155:		}
LABELV $165
line 157
;156:
;157:		return cgWeapFrame;
ADDRGP4 cgWeapFrame
INDIRI4
RETI4
ADDRGP4 $152
JUMPV
LABELV $153
line 160
;158:	}
;159:	else
;160:	{
line 161
;161:		cgWeapFrame = 0;
ADDRGP4 cgWeapFrame
CNSTI4 0
ASGNI4
line 162
;162:		cgWeapFrameTime = 0;
ADDRGP4 cgWeapFrameTime
CNSTI4 0
ASGNI4
line 163
;163:	}
line 166
;164:#endif
;165:
;166:	switch( animNum )
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 8
CNSTI4 954
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $171
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
GTI4 $181
LABELV $180
ADDRLP4 12
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 106
LTI4 $169
ADDRLP4 12
INDIRI4
CNSTI4 125
GTI4 $169
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $182-424
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $182
address $177
address $177
address $177
address $177
address $177
address $177
address $177
address $177
address $177
address $177
address $177
address $177
address $169
address $169
address $169
address $169
address $169
address $169
address $169
address $177
code
LABELV $181
ADDRFP4 8
INDIRI4
CNSTI4 958
EQI4 $174
ADDRGP4 $169
JUMPV
line 167
;167:	{
LABELV $171
line 169
;168:	case TORSO_DROPWEAP1:
;169:		if ( frame >= animations[animNum].firstFrame && frame < animations[animNum].firstFrame + 5 ) 
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
CNSTI4 28
ADDRFP4 8
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $170
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 5
ADDI4
GEI4 $170
line 170
;170:		{
line 171
;171:			return frame - animations[animNum].firstFrame + 6;
ADDRFP4 4
INDIRI4
CNSTI4 28
ADDRFP4 8
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI4
SUBI4
CNSTI4 6
ADDI4
RETI4
ADDRGP4 $152
JUMPV
line 173
;172:		}
;173:		break;
LABELV $174
line 176
;174:
;175:	case TORSO_RAISEWEAP1:
;176:		if ( frame >= animations[animNum].firstFrame && frame < animations[animNum].firstFrame + 4 ) 
ADDRLP4 24
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
CNSTI4 28
ADDRFP4 8
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 28
INDIRI4
LTI4 $170
ADDRLP4 24
INDIRI4
ADDRLP4 28
INDIRI4
CNSTI4 4
ADDI4
GEI4 $170
line 177
;177:		{
line 178
;178:			return frame - animations[animNum].firstFrame + 6 + 4;
ADDRFP4 4
INDIRI4
CNSTI4 28
ADDRFP4 8
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI4
SUBI4
CNSTI4 6
ADDI4
CNSTI4 4
ADDI4
RETI4
ADDRGP4 $152
JUMPV
line 180
;179:		}
;180:		break;
LABELV $177
line 194
;181:	case BOTH_ATTACK1:
;182:	case BOTH_ATTACK2:
;183:	case BOTH_ATTACK3:
;184:	case BOTH_ATTACK4:
;185:	case BOTH_ATTACK5:
;186:	case BOTH_ATTACK6:
;187:	case BOTH_ATTACK7:
;188:	case BOTH_ATTACK8:
;189:	case BOTH_ATTACK9:
;190:	case BOTH_ATTACK10:
;191:	case BOTH_ATTACK11:
;192:	case BOTH_ATTACK12:
;193:	case BOTH_THERMAL_THROW:
;194:		if ( frame >= animations[animNum].firstFrame && frame < animations[animNum].firstFrame + 6 ) 
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
CNSTI4 28
ADDRFP4 8
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRLP4 36
INDIRI4
LTI4 $170
ADDRLP4 32
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 6
ADDI4
GEI4 $170
line 195
;195:		{
line 196
;196:			return 1 + ( frame - animations[animNum].firstFrame );
ADDRFP4 4
INDIRI4
CNSTI4 28
ADDRFP4 8
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
RETI4
ADDRGP4 $152
JUMPV
line 199
;197:		}
;198:
;199:		break;
LABELV $169
LABELV $170
line 201
;200:	}	
;201:	return -1;
CNSTI4 -1
RETI4
LABELV $152
endproc CG_MapTorsoToWeaponFrame 40 0
proc CG_CalculateWeaponPosition 40 4
line 210
;202:}
;203:
;204:
;205:/*
;206:==============
;207:CG_CalculateWeaponPosition
;208:==============
;209:*/
;210:static void CG_CalculateWeaponPosition( vec3_t origin, vec3_t angles ) {
line 215
;211:	float	scale;
;212:	int		delta;
;213:	float	fracsin;
;214:
;215:	VectorCopy( cg.refdef.vieworg, origin );
ADDRFP4 0
INDIRP4
ADDRGP4 cg+3604+24
INDIRB
ASGNB 12
line 216
;216:	VectorCopy( cg.refdefViewAngles, angles );
ADDRFP4 4
INDIRP4
ADDRGP4 cg+3972
INDIRB
ASGNB 12
line 219
;217:
;218:	// on odd legs, invert some angles
;219:	if ( cg.bobcycle & 1 ) {
ADDRGP4 cg+13456
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $188
line 220
;220:		scale = -cg.xyspeed;
ADDRLP4 0
ADDRGP4 cg+13460
INDIRF4
NEGF4
ASGNF4
line 221
;221:	} else {
ADDRGP4 $189
JUMPV
LABELV $188
line 222
;222:		scale = cg.xyspeed;
ADDRLP4 0
ADDRGP4 cg+13460
INDIRF4
ASGNF4
line 223
;223:	}
LABELV $189
line 226
;224:
;225:	// gun angles from bobbing
;226:	angles[ROLL] += scale * cg.bobfracsin * 0.005;
ADDRLP4 12
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1000593162
ADDRLP4 0
INDIRF4
ADDRGP4 cg+13452
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 227
;227:	angles[YAW] += scale * cg.bobfracsin * 0.01;
ADDRLP4 16
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1008981770
ADDRLP4 0
INDIRF4
ADDRGP4 cg+13452
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 228
;228:	angles[PITCH] += cg.xyspeed * cg.bobfracsin * 0.005;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1000593162
ADDRGP4 cg+13460
INDIRF4
ADDRGP4 cg+13452
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 231
;229:
;230:	// drop the weapon when landing
;231:	delta = cg.time - cg.landTime;
ADDRLP4 8
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+3492
INDIRI4
SUBI4
ASGNI4
line 232
;232:	if ( delta < LAND_DEFLECT_TIME ) {
ADDRLP4 8
INDIRI4
CNSTI4 150
GEI4 $199
line 233
;233:		origin[2] += cg.landChange*0.25 * delta / LAND_DEFLECT_TIME;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1048576000
ADDRGP4 cg+3488
INDIRF4
MULF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
CNSTF4 1125515264
DIVF4
ADDF4
ASGNF4
line 234
;234:	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
ADDRGP4 $200
JUMPV
LABELV $199
ADDRLP4 8
INDIRI4
CNSTI4 450
GEI4 $202
line 235
;235:		origin[2] += cg.landChange*0.25 * 
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1048576000
ADDRGP4 cg+3488
INDIRF4
MULF4
CNSTI4 450
ADDRLP4 8
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1133903872
DIVF4
ADDF4
ASGNF4
line 237
;236:			(LAND_DEFLECT_TIME + LAND_RETURN_TIME - delta) / LAND_RETURN_TIME;
;237:	}
LABELV $202
LABELV $200
line 250
;238:
;239:#if 0
;240:	// drop the weapon when stair climbing
;241:	delta = cg.time - cg.stepTime;
;242:	if ( delta < STEP_TIME/2 ) {
;243:		origin[2] -= cg.stepChange*0.25 * delta / (STEP_TIME/2);
;244:	} else if ( delta < STEP_TIME ) {
;245:		origin[2] -= cg.stepChange*0.25 * (STEP_TIME - delta) / (STEP_TIME/2);
;246:	}
;247:#endif
;248:
;249:	// idle drift
;250:	scale = cg.xyspeed + 40;
ADDRLP4 0
ADDRGP4 cg+13460
INDIRF4
CNSTF4 1109393408
ADDF4
ASGNF4
line 251
;251:	fracsin = sin( cg.time * 0.001 );
CNSTF4 981668463
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 24
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 252
;252:	angles[ROLL] += scale * fracsin * 0.01;
ADDRLP4 28
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1008981770
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 253
;253:	angles[YAW] += scale * fracsin * 0.01;
ADDRLP4 32
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 1008981770
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 254
;254:	angles[PITCH] += scale * fracsin * 0.01;
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1008981770
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 255
;255:}
LABELV $184
endproc CG_CalculateWeaponPosition 40 4
proc CG_LightningBolt 220 12
line 269
;256:
;257:
;258:/*
;259:===============
;260:CG_LightningBolt
;261:
;262:Origin will be the exact tag point, which is slightly
;263:different than the muzzle point used for determining hits.
;264:The cent should be the non-predicted cent if it is from the player,
;265:so the endpoint will reflect the simulated strike (lagging the predicted
;266:angle)
;267:===============
;268:*/
;269:static void CG_LightningBolt( centity_t *cent, vec3_t origin ) {
line 276
;270://	trace_t  trace;
;271:	refEntity_t  beam;
;272://	vec3_t   forward;
;273://	vec3_t   muzzlePoint, endPoint;
;274:
;275:	//Must be a durational weapon that continuously generates an effect.
;276:	if ( cent->currentState.weapon == WP_DEMP2 && cent->currentState.eFlags & EF_ALT_FIRING ) 
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 216
CNSTI4 8
ASGNI4
ADDRLP4 212
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRLP4 216
INDIRI4
NEI4 $207
ADDRLP4 212
INDIRP4
ADDRLP4 216
INDIRI4
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $207
line 277
;277:	{ /*nothing*/ }
line 279
;278:	else
;279:	{
line 280
;280:		return;
LABELV $209
line 283
;281:	}
;282:
;283:	memset( &beam, 0, sizeof( beam ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 366
;284:
;285:	// NOTENOTE No lightning gun-ish stuff yet.
;286:/*
;287:	// CPMA  "true" lightning
;288:	if ((cent->currentState.number == cg.predictedPlayerState.clientNum) && (cg_trueLightning.value != 0)) {
;289:		vec3_t angle;
;290:		int i;
;291:
;292:		for (i = 0; i < 3; i++) {
;293:			float a = cent->lerpAngles[i] - cg.refdefViewAngles[i];
;294:			if (a > 180) {
;295:				a -= 360;
;296:			}
;297:			if (a < -180) {
;298:				a += 360;
;299:			}
;300:
;301:			angle[i] = cg.refdefViewAngles[i] + a * (1.0 - cg_trueLightning.value);
;302:			if (angle[i] < 0) {
;303:				angle[i] += 360;
;304:			}
;305:			if (angle[i] > 360) {
;306:				angle[i] -= 360;
;307:			}
;308:		}
;309:
;310:		AngleVectors(angle, forward, NULL, NULL );
;311:		VectorCopy(cent->lerpOrigin, muzzlePoint );
;312://		VectorCopy(cg.refdef.vieworg, muzzlePoint );
;313:	} else {
;314:		// !CPMA
;315:		AngleVectors( cent->lerpAngles, forward, NULL, NULL );
;316:		VectorCopy(cent->lerpOrigin, muzzlePoint );
;317:	}
;318:
;319:	// FIXME: crouch
;320:	muzzlePoint[2] += DEFAULT_VIEWHEIGHT;
;321:
;322:	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
;323:
;324:	// project forward by the lightning range
;325:	VectorMA( muzzlePoint, LIGHTNING_RANGE, forward, endPoint );
;326:
;327:	// see if it hit a wall
;328:	CG_Trace( &trace, muzzlePoint, vec3_origin, vec3_origin, endPoint, 
;329:		cent->currentState.number, MASK_SHOT );
;330:
;331:	// this is the endpoint
;332:	VectorCopy( trace.endpos, beam.oldorigin );
;333:
;334:	// use the provided origin, even though it may be slightly
;335:	// different than the muzzle origin
;336:	VectorCopy( origin, beam.origin );
;337:
;338:	beam.reType = RT_LIGHTNING;
;339:	beam.customShader = cgs.media.lightningShader;
;340:	trap_R_AddRefEntityToScene( &beam );
;341:*/
;342:
;343:	// NOTENOTE No lightning gun-ish stuff yet.
;344:/*
;345:	// add the impact flare if it hit something
;346:	if ( trace.fraction < 1.0 ) {
;347:		vec3_t	angles;
;348:		vec3_t	dir;
;349:
;350:		VectorSubtract( beam.oldorigin, beam.origin, dir );
;351:		VectorNormalize( dir );
;352:
;353:		memset( &beam, 0, sizeof( beam ) );
;354:		beam.hModel = cgs.media.lightningExplosionModel;
;355:
;356:		VectorMA( trace.endpos, -16, dir, beam.origin );
;357:
;358:		// make a random orientation
;359:		angles[0] = rand() % 360;
;360:		angles[1] = rand() % 360;
;361:		angles[2] = rand() % 360;
;362:		AnglesToAxis( angles, beam.axis );
;363:		trap_R_AddRefEntityToScene( &beam );
;364:	}
;365:*/
;366:}
LABELV $207
endproc CG_LightningBolt 220 12
proc CG_AddWeaponWithPowerups 0 4
line 374
;367:
;368:
;369:/*
;370:========================
;371:CG_AddWeaponWithPowerups
;372:========================
;373:*/
;374:static void CG_AddWeaponWithPowerups( refEntity_t *gun, int powerups ) {
line 376
;375:	// add powerup effects
;376:	trap_R_AddRefEntityToScene( gun );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 378
;377:
;378:	if ( powerups & ( 1 << PW_BATTLESUIT ) ) {
ADDRFP4 4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $211
line 379
;379:		gun->customShader = cgs.media.battleWeaponShader;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRGP4 cgs+70280+484
INDIRI4
ASGNI4
line 380
;380:		trap_R_AddRefEntityToScene( gun );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 381
;381:	}
LABELV $211
line 382
;382:	if ( powerups & ( 1 << PW_QUAD ) ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $215
line 383
;383:		gun->customShader = cgs.media.quadWeaponShader;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRGP4 cgs+70280+468
INDIRI4
ASGNI4
line 384
;384:		trap_R_AddRefEntityToScene( gun );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 385
;385:	}
LABELV $215
line 386
;386:}
LABELV $210
endproc CG_AddWeaponWithPowerups 0 4
export CG_AddPlayerWeapon
proc CG_AddPlayerWeapon 972 36
line 398
;387:
;388:
;389:/*
;390:=============
;391:CG_AddPlayerWeapon
;392:
;393:Used for both the view weapon (ps is valid) and the world modelother character models (ps is NULL)
;394:The main player will have this called for BOTH cases, so effects like light and
;395:sound should only be done on the world model case.
;396:=============
;397:*/
;398:void CG_AddPlayerWeapon( refEntity_t *parent, playerState_t *ps, centity_t *cent, int team, vec3_t newAngles, qboolean thirdPerson ) {
line 407
;399:	refEntity_t	gun;
;400:	refEntity_t	barrel;
;401:	vec3_t		angles;
;402:	weapon_t	weaponNum;
;403:	weaponInfo_t	*weapon;
;404:	centity_t	*nonPredictedCent;
;405:	refEntity_t	flash;
;406:
;407:	weaponNum = cent->currentState.weapon;
ADDRLP4 440
ADDRFP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
line 409
;408:
;409:	if (cent->currentState.weapon == WP_EMPLACED_GUN)
ADDRFP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 14
NEI4 $220
line 410
;410:	{
line 411
;411:		return;
ADDRGP4 $219
JUMPV
LABELV $220
line 414
;412:	}
;413:
;414:	CG_RegisterWeapon( weaponNum );
ADDRLP4 440
INDIRI4
ARGI4
ADDRGP4 CG_RegisterWeapon
CALLV
pop
line 415
;415:	weapon = &cg_weapons[weaponNum];
ADDRLP4 436
CNSTI4 208
ADDRLP4 440
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 420
;416:/*
;417:Ghoul2 Insert Start
;418:*/
;419:
;420:	memset( &gun, 0, sizeof( gun ) );
ADDRLP4 224
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 423
;421:
;422:	// only do this if we are in first person, since world weapons are now handled on the server by Ghoul2
;423:	if (!thirdPerson)
ADDRFP4 20
INDIRI4
CNSTI4 0
NEI4 $222
line 424
;424:	{
line 427
;425:
;426:		// add the weapon
;427:		VectorCopy( parent->lightingOrigin, gun.lightingOrigin );
ADDRLP4 224+108
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRB
ASGNB 12
line 428
;428:		gun.shadowPlane = parent->shadowPlane;
ADDRLP4 224+120
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ASGNF4
line 429
;429:		gun.renderfx = parent->renderfx;
ADDRLP4 224+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 431
;430:
;431:		if (ps)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $227
line 432
;432:		{	// this player, in first person view
line 433
;433:			gun.hModel = weapon->viewModel;
ADDRLP4 224+8
ADDRLP4 436
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 434
;434:		}
ADDRGP4 $228
JUMPV
LABELV $227
line 436
;435:		else
;436:		{
line 437
;437:			gun.hModel = weapon->weaponModel;
ADDRLP4 224+8
ADDRLP4 436
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 438
;438:		}
LABELV $228
line 439
;439:		if (!gun.hModel) {
ADDRLP4 224+8
INDIRI4
CNSTI4 0
NEI4 $231
line 440
;440:			return;
ADDRGP4 $219
JUMPV
LABELV $231
line 443
;441:		}
;442:
;443:		if ( !ps ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $234
line 445
;444:			// add weapon ready sound
;445:			cent->pe.lightningFiring = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 844
ADDP4
CNSTI4 0
ASGNI4
line 446
;446:			if ( ( cent->currentState.eFlags & EF_FIRING ) && weapon->firingSound ) {
ADDRLP4 660
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
ADDRLP4 660
INDIRI4
EQI4 $236
ADDRLP4 436
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRLP4 660
INDIRI4
EQI4 $236
line 448
;447:				// lightning gun and guantlet make a different sound when fire is held down
;448:				trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->firingSound );
ADDRLP4 664
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 664
INDIRP4
INDIRI4
ARGI4
ADDRLP4 664
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 436
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 449
;449:				cent->pe.lightningFiring = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 844
ADDP4
CNSTI4 1
ASGNI4
line 450
;450:			} else if ( weapon->readySound ) {
ADDRGP4 $237
JUMPV
LABELV $236
ADDRLP4 436
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
EQI4 $238
line 451
;451:				trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->readySound );
ADDRLP4 664
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 664
INDIRP4
INDIRI4
ARGI4
ADDRLP4 664
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 436
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 452
;452:			}
LABELV $238
LABELV $237
line 453
;453:		}
LABELV $234
line 455
;454:	
;455:		CG_PositionEntityOnTag( &gun, parent, parent->hModel, "tag_weapon");
ADDRLP4 224
ARGP4
ADDRLP4 660
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 660
INDIRP4
ARGP4
ADDRLP4 660
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $240
ARGP4
ADDRGP4 CG_PositionEntityOnTag
CALLV
pop
line 457
;456:
;457:		if (!CG_IsMindTricked(cent->currentState.trickedentindex,
ADDRLP4 664
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 664
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRLP4 664
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ARGI4
ADDRLP4 664
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
ARGI4
ADDRLP4 664
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
ADDRLP4 668
ADDRGP4 CG_IsMindTricked
CALLI4
ASGNI4
ADDRLP4 668
INDIRI4
CNSTI4 0
NEI4 $241
line 462
;458:			cent->currentState.trickedentindex2,
;459:			cent->currentState.trickedentindex3,
;460:			cent->currentState.trickedentindex4,
;461:			cg.snap->ps.clientNum))
;462:		{
line 463
;463:			CG_AddWeaponWithPowerups( &gun, cent->currentState.powerups ); //don't draw the weapon if the player is invisible
ADDRLP4 224
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddWeaponWithPowerups
CALLV
pop
line 474
;464:			/*
;465:			if ( weaponNum == WP_STUN_BATON )
;466:			{
;467:				gun.shaderRGBA[0] = gun.shaderRGBA[1] = gun.shaderRGBA[2] = 25;
;468:	
;469:				gun.customShader = trap_R_RegisterShader( "gfx/effects/stunPass" );
;470:				gun.renderfx = RF_RGB_TINT | RF_FIRST_PERSON | RF_DEPTHHACK;
;471:				trap_R_AddRefEntityToScene( &gun );
;472:			}
;473:			*/
;474:		}
LABELV $241
line 476
;475:
;476:		if (weaponNum == WP_STUN_BATON)
ADDRLP4 440
INDIRI4
CNSTI4 1
NEI4 $244
line 477
;477:		{
line 478
;478:			int i = 0;
ADDRLP4 672
CNSTI4 0
ASGNI4
ADDRGP4 $247
JUMPV
LABELV $246
line 481
;479:
;480:			while (i < 3)
;481:			{
line 482
;482:				memset( &barrel, 0, sizeof( barrel ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 483
;483:				VectorCopy( parent->lightingOrigin, barrel.lightingOrigin );
ADDRLP4 0+108
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRB
ASGNB 12
line 484
;484:				barrel.shadowPlane = parent->shadowPlane;
ADDRLP4 0+120
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ASGNF4
line 485
;485:				barrel.renderfx = parent->renderfx;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 487
;486:
;487:				if (i == 0)
ADDRLP4 672
INDIRI4
CNSTI4 0
NEI4 $252
line 488
;488:				{
line 489
;489:					barrel.hModel = trap_R_RegisterModel("models/weapons2/stun_baton/baton_barrel.md3");
ADDRGP4 $255
ARGP4
ADDRLP4 676
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 676
INDIRI4
ASGNI4
line 490
;490:				}
ADDRGP4 $253
JUMPV
LABELV $252
line 491
;491:				else if (i == 1)
ADDRLP4 672
INDIRI4
CNSTI4 1
NEI4 $256
line 492
;492:				{
line 493
;493:					barrel.hModel = trap_R_RegisterModel("models/weapons2/stun_baton/baton_barrel2.md3");
ADDRGP4 $259
ARGP4
ADDRLP4 676
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 676
INDIRI4
ASGNI4
line 494
;494:				}
ADDRGP4 $257
JUMPV
LABELV $256
line 496
;495:				else
;496:				{
line 497
;497:					barrel.hModel = trap_R_RegisterModel("models/weapons2/stun_baton/baton_barrel3.md3");
ADDRGP4 $261
ARGP4
ADDRLP4 676
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 676
INDIRI4
ASGNI4
line 498
;498:				}
LABELV $257
LABELV $253
line 499
;499:				angles[YAW] = 0;
ADDRLP4 212+4
CNSTF4 0
ASGNF4
line 500
;500:				angles[PITCH] = 0;
ADDRLP4 212
CNSTF4 0
ASGNF4
line 501
;501:				angles[ROLL] = 0;
ADDRLP4 212+8
CNSTF4 0
ASGNF4
line 503
;502:
;503:				AnglesToAxis( angles, barrel.axis );
ADDRLP4 212
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 505
;504:
;505:				if (i == 0)
ADDRLP4 672
INDIRI4
CNSTI4 0
NEI4 $265
line 506
;506:				{
line 507
;507:					CG_PositionRotatedEntityOnTag( &barrel, parent/*&gun*/, /*weapon->weaponModel*/weapon->handsModel, "tag_barrel" );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 436
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $267
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 508
;508:				}
ADDRGP4 $266
JUMPV
LABELV $265
line 509
;509:				else if (i == 1)
ADDRLP4 672
INDIRI4
CNSTI4 1
NEI4 $268
line 510
;510:				{
line 511
;511:					CG_PositionRotatedEntityOnTag( &barrel, parent/*&gun*/, /*weapon->weaponModel*/weapon->handsModel, "tag_barrel2" );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 436
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $270
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 512
;512:				}
ADDRGP4 $269
JUMPV
LABELV $268
line 514
;513:				else
;514:				{
line 515
;515:					CG_PositionRotatedEntityOnTag( &barrel, parent/*&gun*/, /*weapon->weaponModel*/weapon->handsModel, "tag_barrel3" );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 436
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $271
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 516
;516:				}
LABELV $269
LABELV $266
line 517
;517:				CG_AddWeaponWithPowerups( &barrel, cent->currentState.powerups );
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddWeaponWithPowerups
CALLV
pop
line 519
;518:
;519:				i++;
ADDRLP4 672
ADDRLP4 672
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 520
;520:			}
LABELV $247
line 480
ADDRLP4 672
INDIRI4
CNSTI4 3
LTI4 $246
line 521
;521:		}
ADDRGP4 $245
JUMPV
LABELV $244
line 523
;522:		else
;523:		{
line 525
;524:			// add the spinning barrel
;525:			if ( weapon->barrelModel ) {
ADDRLP4 436
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $272
line 526
;526:				memset( &barrel, 0, sizeof( barrel ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 527
;527:				VectorCopy( parent->lightingOrigin, barrel.lightingOrigin );
ADDRLP4 0+108
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRB
ASGNB 12
line 528
;528:				barrel.shadowPlane = parent->shadowPlane;
ADDRLP4 0+120
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ASGNF4
line 529
;529:				barrel.renderfx = parent->renderfx;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 531
;530:
;531:				barrel.hModel = weapon->barrelModel;
ADDRLP4 0+8
ADDRLP4 436
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 532
;532:				angles[YAW] = 0;
ADDRLP4 212+4
CNSTF4 0
ASGNF4
line 533
;533:				angles[PITCH] = 0;
ADDRLP4 212
CNSTF4 0
ASGNF4
line 534
;534:				angles[ROLL] = 0;
ADDRLP4 212+8
CNSTF4 0
ASGNF4
line 536
;535:
;536:				AnglesToAxis( angles, barrel.axis );
ADDRLP4 212
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 538
;537:
;538:				CG_PositionRotatedEntityOnTag( &barrel, parent/*&gun*/, /*weapon->weaponModel*/weapon->handsModel, "tag_barrel" );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 436
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $267
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 540
;539:
;540:				CG_AddWeaponWithPowerups( &barrel, cent->currentState.powerups );
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddWeaponWithPowerups
CALLV
pop
line 541
;541:			}
LABELV $272
line 542
;542:		}
LABELV $245
line 543
;543:	}
LABELV $222
line 548
;544:/*
;545:Ghoul2 Insert End
;546:*/
;547:
;548:	memset (&flash, 0, sizeof(flash));
ADDRLP4 444
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 549
;549:	CG_PositionEntityOnTag( &flash, &gun, gun.hModel, "tag_flash");
ADDRLP4 444
ARGP4
ADDRLP4 224
ARGP4
ADDRLP4 224+8
INDIRI4
ARGI4
ADDRGP4 $282
ARGP4
ADDRGP4 CG_PositionEntityOnTag
CALLV
pop
line 551
;550:
;551:	VectorCopy(flash.origin, cg.lastFPFlashPoint);
ADDRGP4 cg+13784
ADDRLP4 444+52
INDIRB
ASGNB 12
line 555
;552:
;553:	// Do special charge bits
;554:	//-----------------------
;555:	if ( (ps || cg.renderingThirdPerson || cg.predictedPlayerState.clientNum != cent->currentState.number) &&
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $291
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $291
ADDRGP4 cg+96+144
INDIRI4
ADDRFP4 8
INDIRP4
INDIRI4
EQI4 $285
LABELV $291
ADDRLP4 660
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 660
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 5
NEI4 $293
ADDRLP4 660
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
EQI4 $294
LABELV $293
ADDRLP4 664
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 664
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 6
NEI4 $295
ADDRLP4 664
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 4
EQI4 $294
LABELV $295
ADDRLP4 668
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 668
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 8
NEI4 $285
ADDRLP4 668
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 5
NEI4 $285
LABELV $294
line 559
;556:		( ( cent->currentState.modelindex2 == WEAPON_CHARGING_ALT && cent->currentState.weapon == WP_BRYAR_PISTOL ) ||
;557:		  ( cent->currentState.weapon == WP_BOWCASTER && cent->currentState.modelindex2 == WEAPON_CHARGING ) ||
;558:		  ( cent->currentState.weapon == WP_DEMP2 && cent->currentState.modelindex2 == WEAPON_CHARGING_ALT) ) )
;559:	{
line 560
;560:		int		shader = 0;
ADDRLP4 748
CNSTI4 0
ASGNI4
line 561
;561:		float	val = 0.0f;
ADDRLP4 744
CNSTF4 0
ASGNF4
line 562
;562:		float	scale = 1.0f;
ADDRLP4 752
CNSTF4 1065353216
ASGNF4
line 566
;563:		addspriteArgStruct_t fxSArgs;
;564:		vec3_t flashorigin, flashdir;
;565:
;566:		if (!thirdPerson)
ADDRFP4 20
INDIRI4
CNSTI4 0
NEI4 $296
line 567
;567:		{
line 568
;568:			VectorCopy(flash.origin, flashorigin);
ADDRLP4 756
ADDRLP4 444+52
INDIRB
ASGNB 12
line 569
;569:			VectorCopy(flash.axis[0], flashdir);
ADDRLP4 768
ADDRLP4 444+12
INDIRB
ASGNB 12
line 570
;570:		}
ADDRGP4 $297
JUMPV
LABELV $296
line 572
;571:		else
;572:		{
line 575
;573:			mdxaBone_t 		boltMatrix;
;574:
;575:			if (!trap_G2API_HasGhoul2ModelOnIndex(&(cent->ghoul2), 1))
ADDRFP4 8
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 828
ADDRGP4 trap_G2API_HasGhoul2ModelOnIndex
CALLI4
ASGNI4
ADDRLP4 828
INDIRI4
CNSTI4 0
NEI4 $300
line 576
;576:			{ //it's quite possible that we may have have no weapon model and be in a valid state, so return here if this is the case
line 577
;577:				return;
ADDRGP4 $219
JUMPV
LABELV $300
line 581
;578:			}
;579:
;580:			// go away and get me the bolt position for this frame please
;581: 			if (!(trap_G2API_GetBoltMatrix(cent->ghoul2, 1, 0, &boltMatrix, newAngles, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale)))
ADDRLP4 832
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 832
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 780
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 832
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 832
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRLP4 836
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
ASGNI4
ADDRLP4 836
INDIRI4
CNSTI4 0
NEI4 $302
line 582
;582:			{	// Couldn't find bolt point.
line 583
;583:				return;
ADDRGP4 $219
JUMPV
LABELV $302
line 586
;584:			}
;585:			
;586:			trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, ORIGIN, flashorigin);
ADDRLP4 780
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 756
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 587
;587:			trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, POSITIVE_X, flashdir);
ADDRLP4 780
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 768
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 588
;588:		}
LABELV $297
line 590
;589:
;590:		if ( cent->currentState.weapon == WP_BRYAR_PISTOL )
ADDRFP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
NEI4 $306
line 591
;591:		{
line 593
;592:			// Hardcoded max charge time of 1 second
;593:			val = ( cg.time - cent->currentState.constantLight ) * 0.001f;
ADDRLP4 744
CNSTF4 981668463
ADDRGP4 cg+64
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 594
;594:			shader = cgs.media.bryarFrontFlash;
ADDRLP4 748
ADDRGP4 cgs+70280+20
INDIRI4
ASGNI4
line 595
;595:		}
ADDRGP4 $307
JUMPV
LABELV $306
line 596
;596:		else if ( cent->currentState.weapon == WP_BOWCASTER )
ADDRFP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 6
NEI4 $311
line 597
;597:		{
line 599
;598:			// Hardcoded max charge time of 1 second
;599:			val = ( cg.time - cent->currentState.constantLight ) * 0.001f;
ADDRLP4 744
CNSTF4 981668463
ADDRGP4 cg+64
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 600
;600:			shader = cgs.media.greenFrontFlash;
ADDRLP4 748
ADDRGP4 cgs+70280+24
INDIRI4
ASGNI4
line 601
;601:		}
ADDRGP4 $312
JUMPV
LABELV $311
line 602
;602:		else if ( cent->currentState.weapon == WP_DEMP2 )
ADDRFP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 8
NEI4 $316
line 603
;603:		{
line 604
;604:			val = ( cg.time - cent->currentState.constantLight ) * 0.001f;
ADDRLP4 744
CNSTF4 981668463
ADDRGP4 cg+64
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 605
;605:			shader = cgs.media.lightningFlash;
ADDRLP4 748
ADDRGP4 cgs+70280+28
INDIRI4
ASGNI4
line 606
;606:			scale = 1.75f;
ADDRLP4 752
CNSTF4 1071644672
ASGNF4
line 607
;607:		}
LABELV $316
LABELV $312
LABELV $307
line 609
;608:
;609:		if ( val < 0.0f )
ADDRLP4 744
INDIRF4
CNSTF4 0
GEF4 $321
line 610
;610:		{
line 611
;611:			val = 0.0f;
ADDRLP4 744
CNSTF4 0
ASGNF4
line 612
;612:		}
ADDRGP4 $322
JUMPV
LABELV $321
line 613
;613:		else if ( val > 1.0f )
ADDRLP4 744
INDIRF4
CNSTF4 1065353216
LEF4 $323
line 614
;614:		{
line 615
;615:			val = 1.0f;
ADDRLP4 744
CNSTF4 1065353216
ASGNF4
line 616
;616:			if (ps && cent->currentState.number == ps->clientNum)
ADDRLP4 780
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 780
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $324
ADDRFP4 8
INDIRP4
INDIRI4
ADDRLP4 780
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
NEI4 $324
line 617
;617:			{
line 618
;618:				CGCam_Shake( /*0.1f*/0.2f, 100 );
CNSTF4 1045220557
ARGF4
CNSTI4 100
ARGI4
ADDRGP4 CGCam_Shake
CALLV
pop
line 619
;619:			}
line 620
;620:		}
ADDRGP4 $324
JUMPV
LABELV $323
line 622
;621:		else
;622:		{
line 623
;623:			if (ps && cent->currentState.number == ps->clientNum)
ADDRLP4 780
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 780
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $327
ADDRFP4 8
INDIRP4
INDIRI4
ADDRLP4 780
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
NEI4 $327
line 624
;624:			{
line 625
;625:				CGCam_Shake( val * val * /*0.3f*/0.6f, 100 );
CNSTF4 1058642330
ADDRLP4 744
INDIRF4
ADDRLP4 744
INDIRF4
MULF4
MULF4
ARGF4
CNSTI4 100
ARGI4
ADDRGP4 CGCam_Shake
CALLV
pop
line 626
;626:			}
LABELV $327
line 627
;627:		}
LABELV $324
LABELV $322
line 629
;628:
;629:		val += random() * 0.5f;
ADDRLP4 780
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 744
ADDRLP4 744
INDIRF4
CNSTF4 1056964608
ADDRLP4 780
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 631
;630:
;631:		VectorCopy(flashorigin, fxSArgs.origin);
ADDRLP4 672
ADDRLP4 756
INDIRB
ASGNB 12
line 632
;632:		VectorClear(fxSArgs.vel);
ADDRLP4 784
CNSTF4 0
ASGNF4
ADDRLP4 672+12+8
ADDRLP4 784
INDIRF4
ASGNF4
ADDRLP4 672+12+4
ADDRLP4 784
INDIRF4
ASGNF4
ADDRLP4 672+12
ADDRLP4 784
INDIRF4
ASGNF4
line 633
;633:		VectorClear(fxSArgs.accel);
ADDRLP4 788
CNSTF4 0
ASGNF4
ADDRLP4 672+24+8
ADDRLP4 788
INDIRF4
ASGNF4
ADDRLP4 672+24+4
ADDRLP4 788
INDIRF4
ASGNF4
ADDRLP4 672+24
ADDRLP4 788
INDIRF4
ASGNF4
line 634
;634:		fxSArgs.scale = 3.0f*val*scale;
ADDRLP4 672+36
CNSTF4 1077936128
ADDRLP4 744
INDIRF4
MULF4
ADDRLP4 752
INDIRF4
MULF4
ASGNF4
line 635
;635:		fxSArgs.dscale = 0.0f;
ADDRLP4 672+40
CNSTF4 0
ASGNF4
line 636
;636:		fxSArgs.sAlpha = 0.7f;
ADDRLP4 672+44
CNSTF4 1060320051
ASGNF4
line 637
;637:		fxSArgs.eAlpha = 0.7f;
ADDRLP4 672+48
CNSTF4 1060320051
ASGNF4
line 638
;638:		fxSArgs.rotation = random()*360;
ADDRLP4 792
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 672+52
CNSTF4 1135869952
ADDRLP4 792
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
line 639
;639:		fxSArgs.bounce = 0.0f;
ADDRLP4 672+56
CNSTF4 0
ASGNF4
line 640
;640:		fxSArgs.life = 1.0f;
ADDRLP4 672+60
CNSTI4 1
ASGNI4
line 641
;641:		fxSArgs.shader = shader;
ADDRLP4 672+64
ADDRLP4 748
INDIRI4
ASGNI4
line 642
;642:		fxSArgs.flags = 0x08000000;
ADDRLP4 672+68
CNSTI4 134217728
ASGNI4
line 645
;643:
;644:		//FX_AddSprite( flash.origin, NULL, NULL, 3.0f * val, 0.0f, 0.7f, 0.7f, WHITE, WHITE, random() * 360, 0.0f, 1.0f, shader, FX_USE_ALPHA );
;645:		trap_FX_AddSprite(&fxSArgs);
ADDRLP4 672
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 646
;646:	}
LABELV $285
line 649
;647:
;648:	// make sure we aren't looking at cg.predictedPlayerEntity for LG
;649:	nonPredictedCent = &cg_entities[cent->currentState.clientNum];
ADDRLP4 656
CNSTI4 1920
ADDRFP4 8
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 654
;650:
;651:	// if the index of the nonPredictedCent is not the same as the clientNum
;652:	// then this is a fake player (like on teh single player podiums), so
;653:	// go ahead and use the cent
;654:	if( ( nonPredictedCent - cg_entities ) != cent->currentState.clientNum ) {
ADDRLP4 656
INDIRP4
CVPU4 4
ADDRGP4 cg_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1920
DIVI4
ADDRFP4 8
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
EQI4 $348
line 655
;655:		nonPredictedCent = cent;
ADDRLP4 656
ADDRFP4 8
INDIRP4
ASGNP4
line 656
;656:	}
LABELV $348
line 659
;657:
;658:	// add the flash
;659:	if ( ( weaponNum == WP_DEMP2)
ADDRLP4 672
CNSTI4 8
ASGNI4
ADDRLP4 440
INDIRI4
ADDRLP4 672
INDIRI4
NEI4 $350
ADDRLP4 656
INDIRP4
ADDRLP4 672
INDIRI4
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $350
line 661
;660:		&& ( nonPredictedCent->currentState.eFlags & EF_FIRING ) ) 
;661:	{
line 663
;662:		// continuous flash
;663:	} else {
ADDRGP4 $351
JUMPV
LABELV $350
line 665
;664:		// impulse flash
;665:		if ( cg.time - cent->muzzleFlashTime > MUZZLE_FLASH_TIME) {
ADDRGP4 cg+64
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 600
ADDP4
INDIRI4
SUBI4
CNSTI4 20
LEI4 $352
line 666
;666:			return;
ADDRGP4 $219
JUMPV
LABELV $352
line 668
;667:		}
;668:	}
LABELV $351
line 670
;669:
;670:	if ( ps || cg.renderingThirdPerson ||
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $361
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $361
ADDRFP4 8
INDIRP4
INDIRI4
ADDRGP4 cg+96+144
INDIRI4
EQI4 $355
LABELV $361
line 672
;671:			cent->currentState.number != cg.predictedPlayerState.clientNum ) 
;672:	{	// Make sure we don't do the thirdperson model effects for the local player if we're in first person
line 676
;673:		vec3_t flashorigin, flashdir;
;674:		refEntity_t	flash;
;675:
;676:		memset (&flash, 0, sizeof(flash));
ADDRLP4 676
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 678
;677:
;678:		if (!thirdPerson)
ADDRFP4 20
INDIRI4
CNSTI4 0
NEI4 $362
line 679
;679:		{
line 680
;680:			CG_PositionEntityOnTag( &flash, &gun, gun.hModel, "tag_flash");
ADDRLP4 676
ARGP4
ADDRLP4 224
ARGP4
ADDRLP4 224+8
INDIRI4
ARGI4
ADDRGP4 $282
ARGP4
ADDRGP4 CG_PositionEntityOnTag
CALLV
pop
line 681
;681:			VectorCopy(flash.origin, flashorigin);
ADDRLP4 888
ADDRLP4 676+52
INDIRB
ASGNB 12
line 682
;682:			VectorCopy(flash.axis[0], flashdir);
ADDRLP4 900
ADDRLP4 676+12
INDIRB
ASGNB 12
line 683
;683:		}
ADDRGP4 $363
JUMPV
LABELV $362
line 685
;684:		else
;685:		{
line 688
;686:			mdxaBone_t 		boltMatrix;
;687:
;688:			if (!trap_G2API_HasGhoul2ModelOnIndex(&(cent->ghoul2), 1))
ADDRFP4 8
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 960
ADDRGP4 trap_G2API_HasGhoul2ModelOnIndex
CALLI4
ASGNI4
ADDRLP4 960
INDIRI4
CNSTI4 0
NEI4 $367
line 689
;689:			{ //it's quite possible that we may have have no weapon model and be in a valid state, so return here if this is the case
line 690
;690:				return;
ADDRGP4 $219
JUMPV
LABELV $367
line 694
;691:			}
;692:
;693:			// go away and get me the bolt position for this frame please
;694: 			if (!(trap_G2API_GetBoltMatrix(cent->ghoul2, 1, 0, &boltMatrix, newAngles, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale)))
ADDRLP4 964
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 964
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 912
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 964
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 964
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRLP4 968
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
ASGNI4
ADDRLP4 968
INDIRI4
CNSTI4 0
NEI4 $369
line 695
;695:			{	// Couldn't find bolt point.
line 696
;696:				return;
ADDRGP4 $219
JUMPV
LABELV $369
line 699
;697:			}
;698:			
;699:			trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, ORIGIN, flashorigin);
ADDRLP4 912
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 888
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 700
;700:			trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, POSITIVE_X, flashdir);
ADDRLP4 912
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 900
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 701
;701:		}
LABELV $363
line 703
;702:
;703:		if ( cg.time - cent->muzzleFlashTime <= MUZZLE_FLASH_TIME + 10 )
ADDRGP4 cg+64
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 600
ADDP4
INDIRI4
SUBI4
CNSTI4 30
GTI4 $373
line 704
;704:		{	// Handle muzzle flashes
line 705
;705:			if ( cent->currentState.eFlags & EF_ALT_FIRING )
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $376
line 706
;706:			{	// Check the alt firing first.
line 707
;707:				if (weapon->altMuzzleEffect)
ADDRLP4 436
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $377
line 708
;708:				{
line 709
;709:					trap_FX_PlayEffectID(weapon->altMuzzleEffect, flashorigin, flashdir);
ADDRLP4 436
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
ARGI4
ADDRLP4 888
ARGP4
ADDRLP4 900
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 710
;710:				}
line 711
;711:			}
ADDRGP4 $377
JUMPV
LABELV $376
line 713
;712:			else
;713:			{	// Regular firing
line 714
;714:				if (weapon->muzzleEffect)
ADDRLP4 436
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 0
EQI4 $380
line 715
;715:				{
line 716
;716:					trap_FX_PlayEffectID(weapon->muzzleEffect, flashorigin, flashdir);
ADDRLP4 436
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
ARGI4
ADDRLP4 888
ARGP4
ADDRLP4 900
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 717
;717:				}
LABELV $380
line 718
;718:			}
LABELV $377
line 719
;719:		}
LABELV $373
line 722
;720:
;721:		// add lightning bolt
;722:		CG_LightningBolt( nonPredictedCent, flashorigin );
ADDRLP4 656
INDIRP4
ARGP4
ADDRLP4 888
ARGP4
ADDRGP4 CG_LightningBolt
CALLV
pop
line 724
;723:
;724:		if ( weapon->flashDlightColor[0] || weapon->flashDlightColor[1] || weapon->flashDlightColor[2] ) {
ADDRLP4 916
CNSTF4 0
ASGNF4
ADDRLP4 436
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ADDRLP4 916
INDIRF4
NEF4 $385
ADDRLP4 436
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
ADDRLP4 916
INDIRF4
NEF4 $385
ADDRLP4 436
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
ADDRLP4 916
INDIRF4
EQF4 $382
LABELV $385
line 725
;725:			trap_R_AddLightToScene( flashorigin, 300 + (rand()&31), weapon->flashDlightColor[0],
ADDRLP4 920
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 888
ARGP4
ADDRLP4 920
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 300
ADDI4
CVIF4 4
ARGF4
ADDRLP4 436
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ARGF4
ADDRLP4 436
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
ARGF4
ADDRLP4 436
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 727
;726:				weapon->flashDlightColor[1], weapon->flashDlightColor[2] );
;727:		}
LABELV $382
line 728
;728:	}
LABELV $355
line 729
;729:}
LABELV $219
endproc CG_AddPlayerWeapon 972 36
export CG_AddViewWeapon
proc CG_AddViewWeapon 264 24
line 738
;730:
;731:/*
;732:==============
;733:CG_AddViewWeapon
;734:
;735:Add the weapon, and flash for the player's view
;736:==============
;737:*/
;738:void CG_AddViewWeapon( playerState_t *ps ) {
line 745
;739:	refEntity_t	hand;
;740:	centity_t	*cent;
;741:	clientInfo_t	*ci;
;742:	float		fovOffset;
;743:	vec3_t		angles;
;744:	weaponInfo_t	*weapon;
;745:	float	cgFov = cg_fov.value;
ADDRLP4 212
ADDRGP4 cg_fov+8
INDIRF4
ASGNF4
line 747
;746:
;747:	if (cgFov < 1)
ADDRLP4 212
INDIRF4
CNSTF4 1065353216
GEF4 $388
line 748
;748:	{
line 749
;749:		cgFov = 1;
ADDRLP4 212
CNSTF4 1065353216
ASGNF4
line 750
;750:	}
LABELV $388
line 751
;751:	if (cgFov > 97)
ADDRLP4 212
INDIRF4
CNSTF4 1120010240
LEF4 $390
line 752
;752:	{
line 753
;753:		cgFov = 97;
ADDRLP4 212
CNSTF4 1120010240
ASGNF4
line 754
;754:	}
LABELV $390
line 756
;755:
;756:	if ( ps->persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
CNSTI4 3
NEI4 $392
line 757
;757:		return;
ADDRGP4 $386
JUMPV
LABELV $392
line 760
;758:	}
;759:
;760:	if ( ps->pm_type == PM_INTERMISSION ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 6
NEI4 $394
line 761
;761:		return;
ADDRGP4 $386
JUMPV
LABELV $394
line 766
;762:	}
;763:
;764:	// no gun if in third person view or a camera is active
;765:	//if ( cg.renderingThirdPerson || cg.cameraMode) {
;766:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
EQI4 $396
line 767
;767:		return;
ADDRGP4 $386
JUMPV
LABELV $396
line 771
;768:	}
;769:
;770:	// allow the gun to be completely removed
;771:	if ( !cg_drawGun.integer || cg.predictedPlayerState.zoomMode) {
ADDRLP4 244
CNSTI4 0
ASGNI4
ADDRGP4 cg_drawGun+12
INDIRI4
ADDRLP4 244
INDIRI4
EQI4 $404
ADDRGP4 cg+96+1320
INDIRI4
ADDRLP4 244
INDIRI4
EQI4 $399
LABELV $404
line 774
;772:		vec3_t		origin;
;773:
;774:		if ( cg.predictedPlayerState.eFlags & EF_FIRING ) {
ADDRGP4 cg+96+108
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $386
line 776
;775:			// special hack for lightning gun...
;776:			VectorCopy( cg.refdef.vieworg, origin );
ADDRLP4 248
ADDRGP4 cg+3604+24
INDIRB
ASGNB 12
line 777
;777:			VectorMA( origin, -8, cg.refdef.viewaxis[2], origin );
ADDRLP4 260
CNSTF4 3238002688
ASGNF4
ADDRLP4 248
ADDRLP4 248
INDIRF4
ADDRLP4 260
INDIRF4
ADDRGP4 cg+3604+36+24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 248+4
ADDRLP4 248+4
INDIRF4
ADDRLP4 260
INDIRF4
ADDRGP4 cg+3604+36+24+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 248+8
ADDRLP4 248+8
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+3604+36+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 778
;778:			CG_LightningBolt( &cg_entities[ps->clientNum], origin );
CNSTI4 1920
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRLP4 248
ARGP4
ADDRGP4 CG_LightningBolt
CALLV
pop
line 779
;779:		}
line 780
;780:		return;
ADDRGP4 $386
JUMPV
LABELV $399
line 784
;781:	}
;782:
;783:	// don't draw if testing a gun model
;784:	if ( cg.testGun ) {
ADDRGP4 cg+13748
INDIRI4
CNSTI4 0
EQI4 $426
line 785
;785:		return;
ADDRGP4 $386
JUMPV
LABELV $426
line 789
;786:	}
;787:
;788:	// drop gun lower at higher fov
;789:	if ( cgFov > 90 ) {
ADDRLP4 212
INDIRF4
CNSTF4 1119092736
LEF4 $429
line 790
;790:		fovOffset = -0.2 * ( cgFov - 90 );
ADDRLP4 220
CNSTF4 3192704205
ADDRLP4 212
INDIRF4
CNSTF4 1119092736
SUBF4
MULF4
ASGNF4
line 791
;791:	} else {
ADDRGP4 $430
JUMPV
LABELV $429
line 792
;792:		fovOffset = 0;
ADDRLP4 220
CNSTF4 0
ASGNF4
line 793
;793:	}
LABELV $430
line 795
;794:
;795:	cent = &cg.predictedPlayerEntity;	// &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 216
ADDRGP4 cg+1464
ASGNP4
line 796
;796:	CG_RegisterWeapon( ps->weapon );
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_RegisterWeapon
CALLV
pop
line 797
;797:	weapon = &cg_weapons[ ps->weapon ];
ADDRLP4 236
CNSTI4 208
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 799
;798:
;799:	memset (&hand, 0, sizeof(hand));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 802
;800:
;801:	// set up gun position
;802:	CG_CalculateWeaponPosition( hand.origin, angles );
ADDRLP4 0+52
ARGP4
ADDRLP4 224
ARGP4
ADDRGP4 CG_CalculateWeaponPosition
CALLV
pop
line 804
;803:
;804:	VectorMA( hand.origin, cg_gun_x.value, cg.refdef.viewaxis[0], hand.origin );
ADDRLP4 0+52
ADDRLP4 0+52
INDIRF4
ADDRGP4 cg+3604+36
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+4
ADDRLP4 0+52+4
INDIRF4
ADDRGP4 cg+3604+36+4
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
ADDRGP4 cg+3604+36+8
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 805
;805:	VectorMA( hand.origin, cg_gun_y.value, cg.refdef.viewaxis[1], hand.origin );
ADDRLP4 0+52
ADDRLP4 0+52
INDIRF4
ADDRGP4 cg+3604+36+12
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+4
ADDRLP4 0+52+4
INDIRF4
ADDRGP4 cg+3604+36+12+4
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
ADDRGP4 cg+3604+36+12+8
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 806
;806:	VectorMA( hand.origin, (cg_gun_z.value+fovOffset), cg.refdef.viewaxis[2], hand.origin );
ADDRLP4 0+52
ADDRLP4 0+52
INDIRF4
ADDRGP4 cg+3604+36+24
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 220
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+4
ADDRLP4 0+52+4
INDIRF4
ADDRGP4 cg+3604+36+24+4
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 220
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
ADDRGP4 cg+3604+36+24+8
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 220
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 808
;807:
;808:	AnglesToAxis( angles, hand.axis );
ADDRLP4 224
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 811
;809:
;810:	// map torso animations to weapon animations
;811:	if ( cg_gun_frame.integer ) {
ADDRGP4 cg_gun_frame+12
INDIRI4
CNSTI4 0
EQI4 $503
line 813
;812:		// development tool
;813:		hand.frame = hand.oldframe = cg_gun_frame.integer;
ADDRLP4 248
ADDRGP4 cg_gun_frame+12
INDIRI4
ASGNI4
ADDRLP4 0+124
ADDRLP4 248
INDIRI4
ASGNI4
ADDRLP4 0+104
ADDRLP4 248
INDIRI4
ASGNI4
line 814
;814:		hand.backlerp = 0;
ADDRLP4 0+128
CNSTF4 0
ASGNF4
line 815
;815:	} else {
ADDRGP4 $504
JUMPV
LABELV $503
line 817
;816:		// get clientinfo for animation map
;817:		ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 240
CNSTI4 788
ADDRLP4 216
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 818
;818:		hand.frame = CG_MapTorsoToWeaponFrame( ci, cent->pe.torso.frame, cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT );
ADDRLP4 240
INDIRP4
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 716
ADDP4
INDIRI4
ARGI4
ADDRLP4 216
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ARGI4
ADDRLP4 252
ADDRGP4 CG_MapTorsoToWeaponFrame
CALLI4
ASGNI4
ADDRLP4 0+104
ADDRLP4 252
INDIRI4
ASGNI4
line 819
;819:		hand.oldframe = CG_MapTorsoToWeaponFrame( ci, cent->pe.torso.oldFrame, cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT );
ADDRLP4 240
INDIRP4
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 708
ADDP4
INDIRI4
ARGI4
ADDRLP4 216
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ARGI4
ADDRLP4 260
ADDRGP4 CG_MapTorsoToWeaponFrame
CALLI4
ASGNI4
ADDRLP4 0+124
ADDRLP4 260
INDIRI4
ASGNI4
line 820
;820:		hand.backlerp = cent->pe.torso.backlerp;
ADDRLP4 0+128
ADDRLP4 216
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
ASGNF4
line 823
;821:
;822:		// Handle the fringe situation where oldframe is invalid
;823:		if ( hand.frame == -1 )
ADDRLP4 0+104
INDIRI4
CNSTI4 -1
NEI4 $514
line 824
;824:		{
line 825
;825:			hand.frame = 0;
ADDRLP4 0+104
CNSTI4 0
ASGNI4
line 826
;826:			hand.oldframe = 0;
ADDRLP4 0+124
CNSTI4 0
ASGNI4
line 827
;827:			hand.backlerp = 0;
ADDRLP4 0+128
CNSTF4 0
ASGNF4
line 828
;828:		}
ADDRGP4 $515
JUMPV
LABELV $514
line 829
;829:		else if ( hand.oldframe == -1 )
ADDRLP4 0+124
INDIRI4
CNSTI4 -1
NEI4 $520
line 830
;830:		{
line 831
;831:			hand.oldframe = hand.frame;
ADDRLP4 0+124
ADDRLP4 0+104
INDIRI4
ASGNI4
line 832
;832:			hand.backlerp = 0;
ADDRLP4 0+128
CNSTF4 0
ASGNF4
line 833
;833:		}
LABELV $520
LABELV $515
line 834
;834:	}
LABELV $504
line 836
;835:
;836:	hand.hModel = weapon->handsModel;
ADDRLP4 0+8
ADDRLP4 236
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 837
;837:	hand.renderfx = RF_DEPTHHACK | RF_FIRST_PERSON;// | RF_MINLIGHT;
ADDRLP4 0+4
CNSTI4 12
ASGNI4
line 840
;838:
;839:	// add everything onto the hand
;840:	CG_AddPlayerWeapon( &hand, ps, &cg.predictedPlayerEntity, ps->persistant[PERS_TEAM], angles, qfalse );
ADDRLP4 0
ARGP4
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 248
INDIRP4
ARGP4
ADDRGP4 cg+1464
ARGP4
ADDRLP4 248
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 224
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_AddPlayerWeapon
CALLV
pop
line 841
;841:}
LABELV $386
endproc CG_AddViewWeapon 264 24
export CG_DrawIconBackground
proc CG_DrawIconBackground 56 20
line 856
;842:
;843:/*
;844:==============================================================================
;845:
;846:WEAPON SELECTION
;847:
;848:==============================================================================
;849:*/
;850:#define ICON_WEAPONS	0
;851:#define ICON_FORCE		1
;852:#define ICON_INVENTORY	2
;853:
;854:
;855:void CG_DrawIconBackground(void)
;856:{
line 859
;857:	int				height,xAdd,x2,y2,t;
;858:	int				prongLeftX,prongRightX;
;859:	float			inTime = cg.invenSelectTime+WEAPON_SELECT_TIME;
ADDRLP4 32
ADDRGP4 cg+13776
INDIRF4
CNSTF4 1152319488
ADDF4
ASGNF4
line 860
;860:	float			wpTime = cg.weaponSelectTime+WEAPON_SELECT_TIME;
ADDRLP4 36
ADDRGP4 cg+13360
INDIRI4
CNSTI4 1400
ADDI4
CVIF4 4
ASGNF4
line 861
;861:	float			fpTime = cg.forceSelectTime+WEAPON_SELECT_TIME;
ADDRLP4 40
ADDRGP4 cg+13780
INDIRF4
CNSTF4 1152319488
ADDF4
ASGNF4
line 863
;862:	qhandle_t		background;
;863:	int				drawType = cgs.media.weaponIconBackground;
ADDRLP4 8
ADDRGP4 cgs+70280+1228
INDIRI4
ASGNI4
line 864
;864:	int				prongsOn = cgs.media.weaponProngsOn;
ADDRLP4 28
ADDRGP4 cgs+70280+1236
INDIRI4
ASGNI4
line 867
;865:		
;866:	// don't display if dead
;867:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) 
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 0
GTI4 $537
line 868
;868:	{
line 869
;869:		return;
ADDRGP4 $529
JUMPV
LABELV $537
line 872
;870:	}
;871:
;872:	if (cg_hudFiles.integer)
ADDRGP4 cg_hudFiles+12
INDIRI4
CNSTI4 0
EQI4 $540
line 873
;873:	{ //simple hud
line 874
;874:		return;
ADDRGP4 $529
JUMPV
LABELV $540
line 877
;875:	}
;876:
;877:	x2 = 30;
ADDRLP4 0
CNSTI4 30
ASGNI4
line 878
;878:	y2 = SCREEN_HEIGHT-70;
ADDRLP4 4
CNSTI4 410
ASGNI4
line 880
;879:
;880:	prongLeftX =x2+37; 
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 37
ADDI4
ASGNI4
line 881
;881:	prongRightX =x2+544; 
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ASGNI4
line 883
;882:
;883:	if (inTime > wpTime)
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
LEF4 $543
line 884
;884:	{
line 885
;885:		drawType = cgs.media.inventoryIconBackground;
ADDRLP4 8
ADDRGP4 cgs+70280+1248
INDIRI4
ASGNI4
line 886
;886:		prongsOn = cgs.media.inventoryProngsOn;
ADDRLP4 28
ADDRGP4 cgs+70280+1252
INDIRI4
ASGNI4
line 887
;887:		cg.iconSelectTime = cg.invenSelectTime;
ADDRGP4 cg+13772
ADDRGP4 cg+13776
INDIRF4
ASGNF4
line 888
;888:	}
ADDRGP4 $544
JUMPV
LABELV $543
line 890
;889:	else
;890:	{
line 891
;891:		drawType = cgs.media.weaponIconBackground;
ADDRLP4 8
ADDRGP4 cgs+70280+1228
INDIRI4
ASGNI4
line 892
;892:		prongsOn = cgs.media.weaponProngsOn;
ADDRLP4 28
ADDRGP4 cgs+70280+1236
INDIRI4
ASGNI4
line 893
;893:		cg.iconSelectTime = cg.weaponSelectTime;
ADDRGP4 cg+13772
ADDRGP4 cg+13360
INDIRI4
CVIF4 4
ASGNF4
line 894
;894:	}
LABELV $544
line 896
;895:
;896:	if (fpTime > inTime && fpTime > wpTime)
ADDRLP4 40
INDIRF4
ADDRLP4 32
INDIRF4
LEF4 $557
ADDRLP4 40
INDIRF4
ADDRLP4 36
INDIRF4
LEF4 $557
line 897
;897:	{
line 898
;898:		drawType = cgs.media.forceIconBackground;
ADDRLP4 8
ADDRGP4 cgs+70280+1240
INDIRI4
ASGNI4
line 899
;899:		prongsOn = cgs.media.forceProngsOn;
ADDRLP4 28
ADDRGP4 cgs+70280+1244
INDIRI4
ASGNI4
line 900
;900:		cg.iconSelectTime = cg.forceSelectTime;
ADDRGP4 cg+13772
ADDRGP4 cg+13780
INDIRF4
ASGNF4
line 901
;901:	}
LABELV $557
line 903
;902:
;903:	if ((cg.iconSelectTime+WEAPON_SELECT_TIME)<cg.time)	// Time is up for the HUD to display
ADDRGP4 cg+13772
INDIRF4
CNSTF4 1152319488
ADDF4
ADDRGP4 cg+64
INDIRI4
CVIF4 4
GEF4 $565
line 904
;904:	{
line 905
;905:		if (cg.iconHUDActive)		// The time is up, but we still need to move the prongs back to their original position
ADDRGP4 cg+13764
INDIRI4
CNSTI4 0
EQI4 $569
line 906
;906:		{
line 907
;907:			t =  cg.time - (cg.iconSelectTime+WEAPON_SELECT_TIME);
ADDRLP4 48
ADDRGP4 cg+64
INDIRI4
CVIF4 4
ADDRGP4 cg+13772
INDIRF4
CNSTF4 1152319488
ADDF4
SUBF4
CVFI4 4
ASGNI4
line 908
;908:			cg.iconHUDPercent = t/ 130.0f;
ADDRGP4 cg+13768
ADDRLP4 48
INDIRI4
CVIF4 4
CNSTF4 1124204544
DIVF4
ASGNF4
line 909
;909:			cg.iconHUDPercent = 1 - cg.iconHUDPercent;
ADDRGP4 cg+13768
CNSTF4 1065353216
ADDRGP4 cg+13768
INDIRF4
SUBF4
ASGNF4
line 911
;910:
;911:			if (cg.iconHUDPercent<0)
ADDRGP4 cg+13768
INDIRF4
CNSTF4 0
GEF4 $577
line 912
;912:			{
line 913
;913:				cg.iconHUDActive = qfalse;
ADDRGP4 cg+13764
CNSTI4 0
ASGNI4
line 914
;914:				cg.iconHUDPercent=0;
ADDRGP4 cg+13768
CNSTF4 0
ASGNF4
line 915
;915:			}
LABELV $577
line 917
;916:
;917:			xAdd = (int) 8*cg.iconHUDPercent;
ADDRLP4 12
CNSTF4 1090519040
ADDRGP4 cg+13768
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 919
;918:
;919:			height = (int) (60.0f*cg.iconHUDPercent);
ADDRLP4 16
CNSTF4 1114636288
ADDRGP4 cg+13768
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 920
;920:			CG_DrawPic( x2+60, y2+30, 460, -height, drawType);	// Top half
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 30
ADDI4
CVIF4 4
ARGF4
CNSTF4 1139146752
ARGF4
ADDRLP4 16
INDIRI4
NEGI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 921
;921:			CG_DrawPic( x2+60, y2+30-2,460, height, drawType);	// Bottom half
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 30
ADDI4
CNSTI4 2
SUBI4
CVIF4 4
ARGF4
CNSTF4 1139146752
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 923
;922:
;923:		}
ADDRGP4 $570
JUMPV
LABELV $569
line 925
;924:		else
;925:		{
line 926
;926:			xAdd = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 927
;927:		}
LABELV $570
line 929
;928:
;929:		trap_R_SetColor(hudTintColor);					
ADDRGP4 hudTintColor
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 930
;930:		CG_DrawPic( prongLeftX+xAdd, y2-10, 40, 80, cgs.media.weaponProngsOff);
ADDRLP4 20
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 10
SUBI4
CVIF4 4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1117782016
ARGF4
ADDRGP4 cgs+70280+1232
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 931
;931:		CG_DrawPic( prongRightX-xAdd, y2-10, -40, 80, cgs.media.weaponProngsOff);
ADDRLP4 24
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 10
SUBI4
CVIF4 4
ARGF4
CNSTF4 3256877056
ARGF4
CNSTF4 1117782016
ARGF4
ADDRGP4 cgs+70280+1232
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 933
;932:
;933:		return;
ADDRGP4 $529
JUMPV
LABELV $565
line 935
;934:	}
;935:	prongLeftX =x2+37; 
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 37
ADDI4
ASGNI4
line 936
;936:	prongRightX =x2+544; 
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ASGNI4
line 938
;937:
;938:	if (!cg.iconHUDActive)
ADDRGP4 cg+13764
INDIRI4
CNSTI4 0
NEI4 $588
line 939
;939:	{
line 940
;940:		t = cg.time - cg.iconSelectTime;
ADDRLP4 48
ADDRGP4 cg+64
INDIRI4
CVIF4 4
ADDRGP4 cg+13772
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 941
;941:		cg.iconHUDPercent = t/ 130.0f;
ADDRGP4 cg+13768
ADDRLP4 48
INDIRI4
CVIF4 4
CNSTF4 1124204544
DIVF4
ASGNF4
line 944
;942:
;943:		// Calc how far into opening sequence we are
;944:		if (cg.iconHUDPercent>1)
ADDRGP4 cg+13768
INDIRF4
CNSTF4 1065353216
LEF4 $594
line 945
;945:		{
line 946
;946:			cg.iconHUDActive = qtrue;
ADDRGP4 cg+13764
CNSTI4 1
ASGNI4
line 947
;947:			cg.iconHUDPercent=1;
ADDRGP4 cg+13768
CNSTF4 1065353216
ASGNF4
line 948
;948:		}
ADDRGP4 $589
JUMPV
LABELV $594
line 949
;949:		else if (cg.iconHUDPercent<0)
ADDRGP4 cg+13768
INDIRF4
CNSTF4 0
GEF4 $589
line 950
;950:		{
line 951
;951:			cg.iconHUDPercent=0;
ADDRGP4 cg+13768
CNSTF4 0
ASGNF4
line 952
;952:		}
line 953
;953:	}
ADDRGP4 $589
JUMPV
LABELV $588
line 955
;954:	else
;955:	{
line 956
;956:		cg.iconHUDPercent=1;
ADDRGP4 cg+13768
CNSTF4 1065353216
ASGNF4
line 957
;957:	}
LABELV $589
line 959
;958:
;959:	trap_R_SetColor( colorTable[CT_WHITE] );					
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 960
;960:	height = (int) (60.0f*cg.iconHUDPercent);
ADDRLP4 16
CNSTF4 1114636288
ADDRGP4 cg+13768
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 961
;961:	CG_DrawPic( x2+60, y2+30, 460, -height, drawType);	// Top half
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 30
ADDI4
CVIF4 4
ARGF4
CNSTF4 1139146752
ARGF4
ADDRLP4 16
INDIRI4
NEGI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 962
;962:	CG_DrawPic( x2+60, y2+30-2,460, height, drawType);	// Bottom half
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 30
ADDI4
CNSTI4 2
SUBI4
CVIF4 4
ARGF4
CNSTF4 1139146752
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 972
;963:
;964:	// And now for the prongs
;965:/*	if ((cg.inventorySelectTime+WEAPON_SELECT_TIME)>cg.time)	
;966:	{
;967:		cgs.media.currentBackground = ICON_INVENTORY;
;968:		background = &cgs.media.inventoryProngsOn;
;969:	}
;970:	else if ((cg.weaponSelectTime+WEAPON_SELECT_TIME)>cg.time)	
;971:	{*/
;972:		cgs.media.currentBackground = ICON_WEAPONS;
ADDRGP4 cgs+70280+1224
CNSTI4 0
ASGNI4
line 973
;973:		background = prongsOn;
ADDRLP4 44
ADDRLP4 28
INDIRI4
ASGNI4
line 982
;974:/*	}
;975:	else 
;976:	{
;977:		cgs.media.currentBackground = ICON_FORCE;
;978:		background = &cgs.media.forceProngsOn;
;979:	}
;980:*/
;981:	// Side Prongs
;982:	trap_R_SetColor( colorTable[CT_WHITE]);					
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 983
;983:	xAdd = (int) 8*cg.iconHUDPercent;
ADDRLP4 12
CNSTF4 1090519040
ADDRGP4 cg+13768
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 984
;984:	CG_DrawPic( prongLeftX+xAdd, y2-10, 40, 80, background);
ADDRLP4 20
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 10
SUBI4
CVIF4 4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1117782016
ARGF4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 985
;985:	CG_DrawPic( prongRightX-xAdd, y2-10, -40, 80, background);
ADDRLP4 24
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 10
SUBI4
CVIF4 4
ARGF4
CNSTF4 3256877056
ARGF4
CNSTF4 1117782016
ARGF4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 987
;986:
;987:}
LABELV $529
endproc CG_DrawIconBackground 56 20
export CG_WeaponCheck
proc CG_WeaponCheck 12 0
line 990
;988:
;989:qboolean CG_WeaponCheck(int weap)
;990:{
line 991
;991:	if (cg.snap->ps.ammo[weaponData[weap].ammoIndex] < weaponData[weap].energyPerShot &&
ADDRLP4 0
CNSTI4 56
ADDRFP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
ADDRLP4 0
INDIRI4
ADDRGP4 weaponData
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 8
CNSTI4 452
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDRGP4 weaponData+8
ADDP4
INDIRI4
GEI4 $611
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDRGP4 weaponData+20
ADDP4
INDIRI4
GEI4 $611
line 993
;992:		cg.snap->ps.ammo[weaponData[weap].ammoIndex] < weaponData[weap].altEnergyPerShot)
;993:	{
line 994
;994:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $610
JUMPV
LABELV $611
line 997
;995:	}
;996:
;997:	return qtrue;
CNSTI4 1
RETI4
LABELV $610
endproc CG_WeaponCheck 12 0
proc CG_WeaponSelectable 12 0
line 1005
;998:}
;999:
;1000:/*
;1001:===============
;1002:CG_WeaponSelectable
;1003:===============
;1004:*/
;1005:static qboolean CG_WeaponSelectable( int i ) {
line 1009
;1006:	/*if ( !cg.snap->ps.ammo[weaponData[i].ammoIndex] ) {
;1007:		return qfalse;
;1008:	}*/
;1009:	if (!i)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $618
line 1010
;1010:	{
line 1011
;1011:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $617
JUMPV
LABELV $618
line 1014
;1012:	}
;1013:
;1014:	if (cg.predictedPlayerState.ammo[weaponData[i].ammoIndex] < weaponData[i].energyPerShot &&
ADDRLP4 0
CNSTI4 56
ADDRFP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
ADDRLP4 0
INDIRI4
ADDRGP4 weaponData
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 cg+96+408
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDRGP4 weaponData+8
ADDP4
INDIRI4
GEI4 $620
ADDRLP4 4
INDIRI4
ADDRGP4 cg+96+408
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDRGP4 weaponData+20
ADDP4
INDIRI4
GEI4 $620
line 1016
;1015:		cg.predictedPlayerState.ammo[weaponData[i].ammoIndex] < weaponData[i].altEnergyPerShot)
;1016:	{
line 1017
;1017:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $617
JUMPV
LABELV $620
line 1020
;1018:	}
;1019:
;1020:	if (i == WP_DET_PACK && cg.predictedPlayerState.ammo[weaponData[i].ammoIndex] < 1 &&
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 13
NEI4 $628
CNSTI4 56
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 weaponData
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+96+408
ADDP4
INDIRI4
CNSTI4 1
GEI4 $628
ADDRGP4 cg+96+628
INDIRI4
CNSTI4 0
NEI4 $628
line 1022
;1021:		!cg.predictedPlayerState.hasDetPackPlanted)
;1022:	{
line 1023
;1023:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $617
JUMPV
LABELV $628
line 1026
;1024:	}
;1025:
;1026:	if ( ! (cg.predictedPlayerState.stats[ STAT_WEAPONS ] & ( 1 << i ) ) ) {
ADDRGP4 cg+96+216+16
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $634
line 1027
;1027:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $617
JUMPV
LABELV $634
line 1030
;1028:	}
;1029:
;1030:	return qtrue;
CNSTI4 1
RETI4
LABELV $617
endproc CG_WeaponSelectable 12 0
lit
align 4
LABELV $752
byte 4 1063256064
byte 4 1060622041
byte 4 1039650521
byte 4 1065353216
export CG_DrawWeaponSelect
code
proc CG_DrawWeaponSelect 1112 20
line 1038
;1031:}
;1032:
;1033:/*
;1034:===================
;1035:CG_DrawWeaponSelect
;1036:===================
;1037:*/
;1038:void CG_DrawWeaponSelect( void ) {
line 1048
;1039:	int				i;
;1040:	int				bits;
;1041:	int				count;
;1042:	int				smallIconSize,bigIconSize;
;1043:	int				holdX,x,y,pad;
;1044:	int				sideLeftIconCnt,sideRightIconCnt;
;1045:	int				sideMax,holdCount,iconCnt;
;1046:	int				height;
;1047:
;1048:	if (cg.predictedPlayerState.emplacedIndex)
ADDRGP4 cg+96+596
INDIRI4
CNSTI4 0
EQI4 $640
line 1049
;1049:	{ //can't cycle when on a weapon
line 1050
;1050:		cg.weaponSelectTime = 0;
ADDRGP4 cg+13360
CNSTI4 0
ASGNI4
line 1051
;1051:	}
LABELV $640
line 1053
;1052:
;1053:	if ((cg.weaponSelectTime+WEAPON_SELECT_TIME)<cg.time)	// Time is up for the HUD to display
ADDRGP4 cg+13360
INDIRI4
CNSTI4 1400
ADDI4
ADDRGP4 cg+64
INDIRI4
GEI4 $645
line 1054
;1054:	{
line 1055
;1055:		return;
ADDRGP4 $639
JUMPV
LABELV $645
line 1059
;1056:	}
;1057:
;1058:	// don't display if dead
;1059:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) 
ADDRGP4 cg+96+216
INDIRI4
CNSTI4 0
GTI4 $649
line 1060
;1060:	{
line 1061
;1061:		return;
ADDRGP4 $639
JUMPV
LABELV $649
line 1065
;1062:	}
;1063:
;1064:	// showing weapon select clears pickup item display, but not the blend blob
;1065:	cg.itemPickupTime = 0;
ADDRGP4 cg+13352
CNSTI4 0
ASGNI4
line 1067
;1066:
;1067:	bits = cg.predictedPlayerState.stats[ STAT_WEAPONS ];
ADDRLP4 12
ADDRGP4 cg+96+216+16
INDIRI4
ASGNI4
line 1070
;1068:
;1069:	// count the number of weapons owned
;1070:	count = 0;
ADDRLP4 36
CNSTI4 0
ASGNI4
line 1072
;1071:
;1072:	if ( !CG_WeaponSelectable(cg.weaponSelect) &&
ADDRGP4 cg+3496
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $657
ADDRGP4 cg+3496
INDIRI4
CNSTI4 11
EQI4 $662
ADDRGP4 cg+3496
INDIRI4
CNSTI4 12
NEI4 $657
LABELV $662
line 1074
;1073:		(cg.weaponSelect == WP_THERMAL || cg.weaponSelect == WP_TRIP_MINE) )
;1074:	{ //display this weapon that we don't actually "have" as unhighlighted until it's deselected
line 1076
;1075:	  //since it's selected we must increase the count to display the proper number of valid selectable weapons
;1076:		count++;
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1077
;1077:	}
LABELV $657
line 1079
;1078:
;1079:	for ( i = 1 ; i < 16 ; i++ ) 
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $663
line 1080
;1080:	{
line 1081
;1081:		if ( bits & ( 1 << i ) ) 
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $667
line 1082
;1082:		{
line 1083
;1083:			if ( CG_WeaponSelectable(i) ||
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $671
ADDRLP4 0
INDIRI4
CNSTI4 11
EQI4 $669
ADDRLP4 0
INDIRI4
CNSTI4 12
EQI4 $669
LABELV $671
line 1085
;1084:				(i != WP_THERMAL && i != WP_TRIP_MINE) )
;1085:			{
line 1086
;1086:				count++;
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1087
;1087:			}
LABELV $669
line 1088
;1088:		}
LABELV $667
line 1089
;1089:	}
LABELV $664
line 1079
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $663
line 1091
;1090:
;1091:	if (count == 0)	// If no weapons, don't display
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $672
line 1092
;1092:	{
line 1093
;1093:		return;
ADDRGP4 $639
JUMPV
LABELV $672
line 1096
;1094:	}
;1095:
;1096:	sideMax = 3;	// Max number of icons on the side
ADDRLP4 56
CNSTI4 3
ASGNI4
line 1099
;1097:
;1098:	// Calculate how many icons will appear to either side of the center one
;1099:	holdCount = count - 1;	// -1 for the center icon
ADDRLP4 52
ADDRLP4 36
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1100
;1100:	if (holdCount == 0)			// No icons to either side
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $674
line 1101
;1101:	{
line 1102
;1102:		sideLeftIconCnt = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 1103
;1103:		sideRightIconCnt = 0;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 1104
;1104:	}
ADDRGP4 $675
JUMPV
LABELV $674
line 1105
;1105:	else if (count > (2*sideMax))	// Go to the max on each side
ADDRLP4 36
INDIRI4
ADDRLP4 56
INDIRI4
CNSTI4 1
LSHI4
LEI4 $676
line 1106
;1106:	{
line 1107
;1107:		sideLeftIconCnt = sideMax;
ADDRLP4 28
ADDRLP4 56
INDIRI4
ASGNI4
line 1108
;1108:		sideRightIconCnt = sideMax;
ADDRLP4 32
ADDRLP4 56
INDIRI4
ASGNI4
line 1109
;1109:	}
ADDRGP4 $677
JUMPV
LABELV $676
line 1111
;1110:	else							// Less than max, so do the calc
;1111:	{
line 1112
;1112:		sideLeftIconCnt = holdCount/2;
ADDRLP4 28
ADDRLP4 52
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1113
;1113:		sideRightIconCnt = holdCount - sideLeftIconCnt;
ADDRLP4 32
ADDRLP4 52
INDIRI4
ADDRLP4 28
INDIRI4
SUBI4
ASGNI4
line 1114
;1114:	}
LABELV $677
LABELV $675
line 1116
;1115:
;1116:	i = cg.weaponSelect - 1;
ADDRLP4 0
ADDRGP4 cg+3496
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1117
;1117:	if (i<1)
ADDRLP4 0
INDIRI4
CNSTI4 1
GEI4 $679
line 1118
;1118:	{
line 1119
;1119:		i = 13;
ADDRLP4 0
CNSTI4 13
ASGNI4
line 1120
;1120:	}
LABELV $679
line 1122
;1121:
;1122:	smallIconSize = 40;
ADDRLP4 8
CNSTI4 40
ASGNI4
line 1123
;1123:	bigIconSize = 80;
ADDRLP4 40
CNSTI4 80
ASGNI4
line 1124
;1124:	pad = 12;
ADDRLP4 20
CNSTI4 12
ASGNI4
line 1126
;1125:
;1126:	x = 320;
ADDRLP4 44
CNSTI4 320
ASGNI4
line 1127
;1127:	y = 410;
ADDRLP4 24
CNSTI4 410
ASGNI4
line 1135
;1128:
;1129:	// Background
;1130://	memcpy(calcColor, colorTable[CT_WHITE], sizeof(vec4_t));
;1131://	calcColor[3] = .35f;
;1132://	trap_R_SetColor( calcColor);					
;1133:
;1134:	// Left side ICONS
;1135:	trap_R_SetColor(colorTable[CT_WHITE]);
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1137
;1136:	// Work backwards from current icon
;1137:	holdX = x - ((bigIconSize/2) + pad + smallIconSize);
ADDRLP4 16
ADDRLP4 44
INDIRI4
ADDRLP4 40
INDIRI4
CNSTI4 2
DIVI4
ADDRLP4 20
INDIRI4
ADDI4
ADDRLP4 8
INDIRI4
ADDI4
SUBI4
ASGNI4
line 1138
;1138:	height = smallIconSize * 1;//cg.iconHUDPercent;
ADDRLP4 48
CNSTI4 1
ADDRLP4 8
INDIRI4
MULI4
ASGNI4
line 1140
;1139:
;1140:	for (iconCnt=1;iconCnt<(sideLeftIconCnt+1);i--)
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $685
JUMPV
LABELV $682
line 1141
;1141:	{
line 1142
;1142:		if (i<1)
ADDRLP4 0
INDIRI4
CNSTI4 1
GEI4 $686
line 1143
;1143:		{
line 1144
;1144:			i = 13;
ADDRLP4 0
CNSTI4 13
ASGNI4
line 1145
;1145:		}
LABELV $686
line 1147
;1146:
;1147:		if ( !(bits & ( 1 << i )))	// Does he have this weapon?
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $688
line 1148
;1148:		{
line 1149
;1149:			continue;
ADDRGP4 $683
JUMPV
LABELV $688
line 1152
;1150:		}
;1151:
;1152:		if ( !CG_WeaponSelectable(i) &&
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $690
ADDRLP4 0
INDIRI4
CNSTI4 11
EQI4 $692
ADDRLP4 0
INDIRI4
CNSTI4 12
NEI4 $690
LABELV $692
line 1154
;1153:			(i == WP_THERMAL || i == WP_TRIP_MINE) )
;1154:		{ //Don't show thermal and tripmine when out of them
line 1155
;1155:			continue;
ADDRGP4 $683
JUMPV
LABELV $690
line 1158
;1156:		}
;1157:
;1158:		++iconCnt;					// Good icon
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1160
;1159:
;1160:		if (cgs.media.weaponIcons[i])
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+940
ADDP4
INDIRI4
CNSTI4 0
EQI4 $693
line 1161
;1161:		{
line 1163
;1162:			weaponInfo_t	*weaponInfo;
;1163:			CG_RegisterWeapon( i );	
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterWeapon
CALLV
pop
line 1164
;1164:			weaponInfo = &cg_weapons[i];
ADDRLP4 72
CNSTI4 208
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 1166
;1165:
;1166:			trap_R_SetColor(colorTable[CT_WHITE]);
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1167
;1167:			if (!CG_WeaponCheck(i))
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 CG_WeaponCheck
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $698
line 1168
;1168:			{
line 1169
;1169:				CG_DrawPic( holdX, y+10, smallIconSize, smallIconSize, /*weaponInfo->weaponIconNoAmmo*/cgs.media.weaponIcons_NA[i] );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRI4
CNSTI4 10
ADDI4
CVIF4 4
ARGF4
ADDRLP4 80
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+1004
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1170
;1170:			}
ADDRGP4 $699
JUMPV
LABELV $698
line 1172
;1171:			else
;1172:			{
line 1173
;1173:				CG_DrawPic( holdX, y+10, smallIconSize, smallIconSize, /*weaponInfo->weaponIcon*/cgs.media.weaponIcons[i] );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRI4
CNSTI4 10
ADDI4
CVIF4 4
ARGF4
ADDRLP4 80
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+940
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1174
;1174:			}
LABELV $699
line 1176
;1175:
;1176:			holdX -= (smallIconSize+pad);
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 8
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
SUBI4
ASGNI4
line 1177
;1177:		}
LABELV $693
line 1178
;1178:	}
LABELV $683
line 1140
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $685
ADDRLP4 4
INDIRI4
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
LTI4 $682
line 1181
;1179:
;1180:	// Current Center Icon
;1181:	height = bigIconSize * cg.iconHUDPercent;
ADDRLP4 48
ADDRLP4 40
INDIRI4
CVIF4 4
ADDRGP4 cg+13768
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1182
;1182:	if (cgs.media.weaponIcons[cg.weaponSelect])
ADDRGP4 cg+3496
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+940
ADDP4
INDIRI4
CNSTI4 0
EQI4 $705
line 1183
;1183:	{
line 1185
;1184:		weaponInfo_t	*weaponInfo;
;1185:		CG_RegisterWeapon( cg.weaponSelect );	
ADDRGP4 cg+3496
INDIRI4
ARGI4
ADDRGP4 CG_RegisterWeapon
CALLV
pop
line 1186
;1186:		weaponInfo = &cg_weapons[cg.weaponSelect];
ADDRLP4 64
CNSTI4 208
ADDRGP4 cg+3496
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 1188
;1187:
;1188:		trap_R_SetColor( colorTable[CT_WHITE]);
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1189
;1189:		if (!CG_WeaponCheck(cg.weaponSelect))
ADDRGP4 cg+3496
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 CG_WeaponCheck
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $713
line 1190
;1190:		{
line 1191
;1191:			CG_DrawPic( x-(bigIconSize/2), (y-((bigIconSize-smallIconSize)/2))+10, bigIconSize, bigIconSize, cgs.media.weaponIcons_NA[cg.weaponSelect] );
ADDRLP4 76
CNSTI4 2
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 40
INDIRI4
ADDRLP4 76
INDIRI4
DIVI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRI4
ADDRLP4 40
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ADDRLP4 76
INDIRI4
DIVI4
SUBI4
CNSTI4 10
ADDI4
CVIF4 4
ARGF4
ADDRLP4 80
ADDRLP4 40
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRGP4 cg+3496
INDIRI4
ADDRLP4 76
INDIRI4
LSHI4
ADDRGP4 cgs+70280+1004
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1192
;1192:		}
ADDRGP4 $714
JUMPV
LABELV $713
line 1194
;1193:		else
;1194:		{
line 1195
;1195:			CG_DrawPic( x-(bigIconSize/2), (y-((bigIconSize-smallIconSize)/2))+10, bigIconSize, bigIconSize, cgs.media.weaponIcons[cg.weaponSelect] );
ADDRLP4 76
CNSTI4 2
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 40
INDIRI4
ADDRLP4 76
INDIRI4
DIVI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRI4
ADDRLP4 40
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ADDRLP4 76
INDIRI4
DIVI4
SUBI4
CNSTI4 10
ADDI4
CVIF4 4
ARGF4
ADDRLP4 80
ADDRLP4 40
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRGP4 cg+3496
INDIRI4
ADDRLP4 76
INDIRI4
LSHI4
ADDRGP4 cgs+70280+940
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1196
;1196:		}
LABELV $714
line 1197
;1197:	}
LABELV $705
line 1199
;1198:
;1199:	i = cg.weaponSelect + 1;
ADDRLP4 0
ADDRGP4 cg+3496
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1200
;1200:	if (i> 13)
ADDRLP4 0
INDIRI4
CNSTI4 13
LEI4 $723
line 1201
;1201:	{
line 1202
;1202:		i = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1203
;1203:	}
LABELV $723
line 1207
;1204:
;1205:	// Right side ICONS
;1206:	// Work forwards from current icon
;1207:	holdX = x + (bigIconSize/2) + pad;
ADDRLP4 16
ADDRLP4 44
INDIRI4
ADDRLP4 40
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ADDRLP4 20
INDIRI4
ADDI4
ASGNI4
line 1208
;1208:	height = smallIconSize * cg.iconHUDPercent;
ADDRLP4 48
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRGP4 cg+13768
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1209
;1209:	for (iconCnt=1;iconCnt<(sideRightIconCnt+1);i++)
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $729
JUMPV
LABELV $726
line 1210
;1210:	{
line 1211
;1211:		if (i>13)
ADDRLP4 0
INDIRI4
CNSTI4 13
LEI4 $730
line 1212
;1212:		{
line 1213
;1213:			i = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1214
;1214:		}
LABELV $730
line 1216
;1215:
;1216:		if ( !(bits & ( 1 << i )))	// Does he have this weapon?
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $732
line 1217
;1217:		{
line 1218
;1218:			continue;
ADDRGP4 $727
JUMPV
LABELV $732
line 1221
;1219:		}
;1220:
;1221:		if ( !CG_WeaponSelectable(i) &&
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $734
ADDRLP4 0
INDIRI4
CNSTI4 11
EQI4 $736
ADDRLP4 0
INDIRI4
CNSTI4 12
NEI4 $734
LABELV $736
line 1223
;1222:			(i == WP_THERMAL || i == WP_TRIP_MINE) )
;1223:		{ //Don't show thermal and tripmine when out of them
line 1224
;1224:			continue;
ADDRGP4 $727
JUMPV
LABELV $734
line 1227
;1225:		}
;1226:
;1227:		++iconCnt;					// Good icon
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1229
;1228:
;1229:		if (/*weaponData[i].weaponIcon[0]*/cgs.media.weaponIcons[i])
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+940
ADDP4
INDIRI4
CNSTI4 0
EQI4 $737
line 1230
;1230:		{
line 1232
;1231:			weaponInfo_t	*weaponInfo;
;1232:			CG_RegisterWeapon( i );	
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterWeapon
CALLV
pop
line 1233
;1233:			weaponInfo = &cg_weapons[i];
ADDRLP4 72
CNSTI4 208
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 1235
;1234:			// No ammo for this weapon?
;1235:			trap_R_SetColor( colorTable[CT_WHITE]);
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1236
;1236:			if (!CG_WeaponCheck(i))
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 CG_WeaponCheck
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $742
line 1237
;1237:			{
line 1238
;1238:				CG_DrawPic( holdX, y+10, smallIconSize, smallIconSize, cgs.media.weaponIcons_NA[i] );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRI4
CNSTI4 10
ADDI4
CVIF4 4
ARGF4
ADDRLP4 80
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+1004
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1239
;1239:			}
ADDRGP4 $743
JUMPV
LABELV $742
line 1241
;1240:			else
;1241:			{
line 1242
;1242:				CG_DrawPic( holdX, y+10, smallIconSize, smallIconSize, cgs.media.weaponIcons[i] );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRI4
CNSTI4 10
ADDI4
CVIF4 4
ARGF4
ADDRLP4 80
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+940
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1243
;1243:			}
LABELV $743
line 1246
;1244:
;1245:
;1246:			holdX += (smallIconSize+pad);
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 8
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ADDI4
ASGNI4
line 1247
;1247:		}
LABELV $737
line 1248
;1248:	}
LABELV $727
line 1209
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $729
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
LTI4 $726
line 1251
;1249:
;1250:	// draw the selected name
;1251:	if ( cg_weapons[ cg.weaponSelect ].item ) 
CNSTI4 208
ADDRGP4 cg+3496
INDIRI4
MULI4
ADDRGP4 cg_weapons+4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $748
line 1252
;1252:	{
line 1253
;1253:		vec4_t			textColor = { .875f, .718f, .121f, 1.0f };
ADDRLP4 64
ADDRGP4 $752
INDIRB
ASGNB 16
line 1256
;1254:		char	text[1024];
;1255:		
;1256:		if ( trap_SP_GetStringTextString( va("INGAME_%s",cg_weapons[ cg.weaponSelect ].item->classname), text, sizeof( text )))
ADDRGP4 $755
ARGP4
CNSTI4 208
ADDRGP4 cg+3496
INDIRI4
MULI4
ADDRGP4 cg_weapons+4
ADDP4
INDIRP4
INDIRP4
ARGP4
ADDRLP4 1104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1104
INDIRP4
ARGP4
ADDRLP4 80
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1108
ADDRGP4 trap_SP_GetStringTextString
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
EQI4 $753
line 1257
;1257:		{
line 1258
;1258:			UI_DrawProportionalString(320, y+45, text, UI_CENTER|UI_SMALLFONT, textColor);
CNSTI4 320
ARGI4
ADDRLP4 24
INDIRI4
CNSTI4 45
ADDI4
ARGI4
ADDRLP4 80
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 64
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 1259
;1259:		}
ADDRGP4 $754
JUMPV
LABELV $753
line 1261
;1260:		else
;1261:		{
line 1262
;1262:			UI_DrawProportionalString(320, y+45, cg_weapons[ cg.weaponSelect ].item->classname, UI_CENTER|UI_SMALLFONT, textColor);
CNSTI4 320
ARGI4
ADDRLP4 24
INDIRI4
CNSTI4 45
ADDI4
ARGI4
CNSTI4 208
ADDRGP4 cg+3496
INDIRI4
MULI4
ADDRGP4 cg_weapons+4
ADDP4
INDIRP4
INDIRP4
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 64
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 1263
;1263:		}
LABELV $754
line 1264
;1264:	}
LABELV $748
line 1266
;1265:
;1266:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1267
;1267:}
LABELV $639
endproc CG_DrawWeaponSelect 1112 20
export CG_NextWeapon_f
proc CG_NextWeapon_f 16 8
line 1275
;1268:
;1269:
;1270:/*
;1271:===============
;1272:CG_NextWeapon_f
;1273:===============
;1274:*/
;1275:void CG_NextWeapon_f( void ) {
line 1279
;1276:	int		i;
;1277:	int		original;
;1278:
;1279:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $761
line 1280
;1280:		return;
ADDRGP4 $760
JUMPV
LABELV $761
line 1282
;1281:	}
;1282:	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $764
line 1283
;1283:		return;
ADDRGP4 $760
JUMPV
LABELV $764
line 1286
;1284:	}
;1285:
;1286:	if (cg.snap->ps.emplacedIndex)
ADDRGP4 cg+36
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $767
line 1287
;1287:	{
line 1288
;1288:		return;
ADDRGP4 $760
JUMPV
LABELV $767
line 1291
;1289:	}
;1290:
;1291:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+13360
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1292
;1292:	original = cg.weaponSelect;
ADDRLP4 4
ADDRGP4 cg+3496
INDIRI4
ASGNI4
line 1294
;1293:
;1294:	for ( i = 0 ; i < 16 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $773
line 1295
;1295:		cg.weaponSelect++;
ADDRLP4 8
ADDRGP4 cg+3496
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1296
;1296:		if ( cg.weaponSelect == 16 ) {
ADDRGP4 cg+3496
INDIRI4
CNSTI4 16
NEI4 $778
line 1297
;1297:			cg.weaponSelect = 0;
ADDRGP4 cg+3496
CNSTI4 0
ASGNI4
line 1298
;1298:		}
LABELV $778
line 1302
;1299:	//	if ( cg.weaponSelect == WP_STUN_BATON ) {
;1300:	//		continue;		// never cycle to gauntlet
;1301:	//	}
;1302:		if ( CG_WeaponSelectable( cg.weaponSelect ) ) {
ADDRGP4 cg+3496
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $782
line 1303
;1303:			break;
ADDRGP4 $775
JUMPV
LABELV $782
line 1305
;1304:		}
;1305:	}
LABELV $774
line 1294
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $773
LABELV $775
line 1306
;1306:	if ( i == 16 ) {
ADDRLP4 0
INDIRI4
CNSTI4 16
NEI4 $785
line 1307
;1307:		cg.weaponSelect = original;
ADDRGP4 cg+3496
ADDRLP4 4
INDIRI4
ASGNI4
line 1308
;1308:	}
ADDRGP4 $786
JUMPV
LABELV $785
line 1310
;1309:	else
;1310:	{
line 1311
;1311:		trap_S_MuteSound(cg.snap->ps.clientNum, CHAN_WEAPON);
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_S_MuteSound
CALLV
pop
line 1312
;1312:	}
LABELV $786
line 1313
;1313:}
LABELV $760
endproc CG_NextWeapon_f 16 8
export CG_PrevWeapon_f
proc CG_PrevWeapon_f 16 8
line 1320
;1314:
;1315:/*
;1316:===============
;1317:CG_PrevWeapon_f
;1318:===============
;1319:*/
;1320:void CG_PrevWeapon_f( void ) {
line 1324
;1321:	int		i;
;1322:	int		original;
;1323:
;1324:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $790
line 1325
;1325:		return;
ADDRGP4 $789
JUMPV
LABELV $790
line 1327
;1326:	}
;1327:	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $793
line 1328
;1328:		return;
ADDRGP4 $789
JUMPV
LABELV $793
line 1331
;1329:	}
;1330:
;1331:	if (cg.snap->ps.emplacedIndex)
ADDRGP4 cg+36
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $796
line 1332
;1332:	{
line 1333
;1333:		return;
ADDRGP4 $789
JUMPV
LABELV $796
line 1336
;1334:	}
;1335:
;1336:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+13360
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1337
;1337:	original = cg.weaponSelect;
ADDRLP4 4
ADDRGP4 cg+3496
INDIRI4
ASGNI4
line 1339
;1338:
;1339:	for ( i = 0 ; i < 16 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $802
line 1340
;1340:		cg.weaponSelect--;
ADDRLP4 8
ADDRGP4 cg+3496
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1341
;1341:		if ( cg.weaponSelect == -1 ) {
ADDRGP4 cg+3496
INDIRI4
CNSTI4 -1
NEI4 $807
line 1342
;1342:			cg.weaponSelect = 15;
ADDRGP4 cg+3496
CNSTI4 15
ASGNI4
line 1343
;1343:		}
LABELV $807
line 1347
;1344:	//	if ( cg.weaponSelect == WP_STUN_BATON ) {
;1345:	//		continue;		// never cycle to gauntlet
;1346:	//	}
;1347:		if ( CG_WeaponSelectable( cg.weaponSelect ) ) {
ADDRGP4 cg+3496
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $811
line 1348
;1348:			break;
ADDRGP4 $804
JUMPV
LABELV $811
line 1350
;1349:		}
;1350:	}
LABELV $803
line 1339
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $802
LABELV $804
line 1351
;1351:	if ( i == 16 ) {
ADDRLP4 0
INDIRI4
CNSTI4 16
NEI4 $814
line 1352
;1352:		cg.weaponSelect = original;
ADDRGP4 cg+3496
ADDRLP4 4
INDIRI4
ASGNI4
line 1353
;1353:	}
ADDRGP4 $815
JUMPV
LABELV $814
line 1355
;1354:	else
;1355:	{
line 1356
;1356:		trap_S_MuteSound(cg.snap->ps.clientNum, CHAN_WEAPON);
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_S_MuteSound
CALLV
pop
line 1357
;1357:	}
LABELV $815
line 1358
;1358:}
LABELV $789
endproc CG_PrevWeapon_f 16 8
export CG_Weapon_f
proc CG_Weapon_f 32 8
line 1365
;1359:
;1360:/*
;1361:===============
;1362:CG_Weapon_f
;1363:===============
;1364:*/
;1365:void CG_Weapon_f( void ) {
line 1368
;1366:	int		num;
;1367:
;1368:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $819
line 1369
;1369:		return;
ADDRGP4 $818
JUMPV
LABELV $819
line 1371
;1370:	}
;1371:	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $822
line 1372
;1372:		return;
ADDRGP4 $818
JUMPV
LABELV $822
line 1375
;1373:	}
;1374:
;1375:	if (cg.snap->ps.emplacedIndex)
ADDRGP4 cg+36
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $825
line 1376
;1376:	{
line 1377
;1377:		return;
ADDRGP4 $818
JUMPV
LABELV $825
line 1380
;1378:	}
;1379:
;1380:	num = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1382
;1381:
;1382:	if ( num < 1 || num > 15 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $830
ADDRLP4 0
INDIRI4
CNSTI4 15
LEI4 $828
LABELV $830
line 1383
;1383:		return;
ADDRGP4 $818
JUMPV
LABELV $828
line 1386
;1384:	}
;1385:
;1386:	if (num == 1 && cg.snap->ps.weapon == WP_SABER)
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $831
ADDRGP4 cg+36
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
NEI4 $831
line 1387
;1387:	{
line 1388
;1388:		if (cg.snap->ps.weaponTime < 1)
ADDRGP4 cg+36
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1
GEI4 $818
line 1389
;1389:		{
line 1391
;1390:			//trap_SendClientCommand("sv_saberswitch");
;1391:			trap_SendConsoleCommand("sv_saberswitch");
ADDRGP4 $837
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1392
;1392:		}
line 1393
;1393:		return;
ADDRGP4 $818
JUMPV
LABELV $831
line 1397
;1394:	}
;1395:
;1396:	//rww - hack to make weapon numbers same as single player
;1397:	if (num > WP_STUN_BATON)
ADDRLP4 0
INDIRI4
CNSTI4 1
LEI4 $838
line 1398
;1398:	{
line 1399
;1399:		num++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1400
;1400:	}
ADDRGP4 $839
JUMPV
LABELV $838
line 1402
;1401:	else
;1402:	{
line 1403
;1403:		if (cg.snap->ps.stats[STAT_WEAPONS] & (1 << WP_SABER))
ADDRGP4 cg+36
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $840
line 1404
;1404:		{
line 1405
;1405:			num = WP_SABER;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1406
;1406:		}
ADDRGP4 $841
JUMPV
LABELV $840
line 1408
;1407:		else
;1408:		{
line 1409
;1409:			num = WP_STUN_BATON;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1410
;1410:		}
LABELV $841
line 1411
;1411:	}
LABELV $839
line 1413
;1412:
;1413:	if (num > WP_DET_PACK+1)
ADDRLP4 0
INDIRI4
CNSTI4 14
LEI4 $843
line 1414
;1414:	{ //other weapons are off limits due to not actually being weapon weapons
line 1415
;1415:		return;
ADDRGP4 $818
JUMPV
LABELV $843
line 1418
;1416:	}
;1417:
;1418:	if (num >= WP_THERMAL)
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $845
line 1419
;1419:	{
line 1420
;1420:		int prenum = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1421
;1421:		int loopback = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 1423
;1422:
;1423:		if (cg.snap->ps.weapon >= WP_THERMAL &&
ADDRLP4 24
CNSTI4 192
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
CNSTI4 11
LTI4 $847
ADDRGP4 cg+36
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
CNSTI4 13
GTI4 $847
line 1425
;1424:			cg.snap->ps.weapon <= WP_DET_PACK)
;1425:		{
line 1426
;1426:			num = cg.snap->ps.weapon;
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 1427
;1427:			prenum = num;
ADDRLP4 16
ADDRLP4 0
INDIRI4
ASGNI4
line 1428
;1428:			num++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1429
;1429:		}
ADDRGP4 $848
JUMPV
LABELV $847
line 1431
;1430:		else
;1431:		{
line 1432
;1432:			prenum = num;
ADDRLP4 16
ADDRLP4 0
INDIRI4
ASGNI4
line 1433
;1433:		}
LABELV $848
line 1435
;1434:
;1435:		if (num > WP_DET_PACK)
ADDRLP4 0
INDIRI4
CNSTI4 13
LEI4 $855
line 1436
;1436:		{
line 1437
;1437:			num = WP_THERMAL;
ADDRLP4 0
CNSTI4 11
ASGNI4
line 1438
;1438:		}
ADDRGP4 $855
JUMPV
LABELV $854
line 1441
;1439:
;1440:		while (prenum != num || !loopback)
;1441:		{
line 1442
;1442:			if (num > WP_DET_PACK)
ADDRLP4 0
INDIRI4
CNSTI4 13
LEI4 $857
line 1443
;1443:			{
line 1444
;1444:				num = WP_THERMAL;
ADDRLP4 0
CNSTI4 11
ASGNI4
line 1445
;1445:				loopback = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 1446
;1446:			}
LABELV $857
line 1448
;1447:
;1448:			if (CG_WeaponSelectable(num))
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $859
line 1449
;1449:			{
line 1450
;1450:				break;
ADDRGP4 $856
JUMPV
LABELV $859
line 1453
;1451:			}
;1452:
;1453:			if (num == prenum)
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $861
line 1454
;1454:			{
line 1455
;1455:				break;
ADDRGP4 $856
JUMPV
LABELV $861
line 1458
;1456:			}
;1457:
;1458:			num++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1459
;1459:		}
LABELV $855
line 1440
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $854
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $854
LABELV $856
line 1461
;1460:
;1461:		if (num > WP_DET_PACK)
ADDRLP4 0
INDIRI4
CNSTI4 13
LEI4 $863
line 1462
;1462:		{
line 1463
;1463:			num = WP_THERMAL;
ADDRLP4 0
CNSTI4 11
ASGNI4
line 1464
;1464:		}
LABELV $863
line 1465
;1465:	}
LABELV $845
line 1467
;1466:
;1467:	if (!CG_WeaponSelectable(num))
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $865
line 1468
;1468:	{
line 1469
;1469:		return;
ADDRGP4 $818
JUMPV
LABELV $865
line 1472
;1470:	}
;1471:
;1472:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+13360
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1474
;1473:
;1474:	if ( ! ( cg.snap->ps.stats[STAT_WEAPONS] & ( 1 << num ) ) )
ADDRGP4 cg+36
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $869
line 1475
;1475:	{
line 1476
;1476:		if (num == WP_SABER)
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $818
line 1477
;1477:		{ //don't have saber, try the stun baton on the same slot
line 1478
;1478:			num = WP_STUN_BATON;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1480
;1479:
;1480:			if ( ! ( cg.snap->ps.stats[STAT_WEAPONS] & ( 1 << num ) ) )
ADDRGP4 cg+36
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $873
line 1481
;1481:			{
line 1482
;1482:				return;
ADDRGP4 $818
JUMPV
line 1484
;1483:			}
;1484:		}
line 1486
;1485:		else
;1486:		{
line 1487
;1487:			return;		// don't have the weapon
LABELV $873
line 1489
;1488:		}
;1489:	}
LABELV $869
line 1491
;1490:
;1491:	if (cg.weaponSelect != num)
ADDRGP4 cg+3496
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $877
line 1492
;1492:	{
line 1493
;1493:		trap_S_MuteSound(cg.snap->ps.clientNum, CHAN_WEAPON);
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_S_MuteSound
CALLV
pop
line 1494
;1494:	}
LABELV $877
line 1496
;1495:
;1496:	cg.weaponSelect = num;
ADDRGP4 cg+3496
ADDRLP4 0
INDIRI4
ASGNI4
line 1497
;1497:}
LABELV $818
endproc CG_Weapon_f 32 8
export CG_OutOfAmmoChange
proc CG_OutOfAmmoChange 12 8
line 1507
;1498:
;1499:/*
;1500:===================
;1501:CG_OutOfAmmoChange
;1502:
;1503:The current weapon has just run out of ammo
;1504:===================
;1505:*/
;1506:void CG_OutOfAmmoChange( int oldWeapon )
;1507:{
line 1510
;1508:	int		i;
;1509:
;1510:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+13360
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1512
;1511:
;1512:	for ( i = WP_DET_PACK ; i > 0 ; i-- )	//We don't want the emplaced or turret
ADDRLP4 0
CNSTI4 13
ASGNI4
LABELV $885
line 1513
;1513:	{
line 1514
;1514:		if ( CG_WeaponSelectable( i ) )
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $889
line 1515
;1515:		{
line 1521
;1516:			/*
;1517:			if ( 1 == cg_autoswitch.integer && 
;1518:				( i == WP_TRIP_MINE || i == WP_DET_PACK || i == WP_THERMAL || i == WP_ROCKET_LAUNCHER) ) // safe weapon switch
;1519:			*/
;1520:			//rww - Don't we want to make sure i != one of these if autoswitch is 1 (safe)?
;1521:			if (cg_autoswitch.integer != 1 || (i != WP_TRIP_MINE && i != WP_DET_PACK && i != WP_THERMAL && i != WP_ROCKET_LAUNCHER))
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 1
NEI4 $894
ADDRLP4 0
INDIRI4
CNSTI4 12
EQI4 $891
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $891
ADDRLP4 0
INDIRI4
CNSTI4 11
EQI4 $891
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $891
LABELV $894
line 1522
;1522:			{
line 1523
;1523:				if (i != oldWeapon)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $895
line 1524
;1524:				{ //don't even do anything if we're just selecting the weapon we already have/had
line 1525
;1525:					cg.weaponSelect = i;
ADDRGP4 cg+3496
ADDRLP4 0
INDIRI4
ASGNI4
line 1526
;1526:					break;
ADDRGP4 $887
JUMPV
LABELV $895
line 1528
;1527:				}
;1528:			}
LABELV $891
line 1529
;1529:		}
LABELV $889
line 1530
;1530:	}
LABELV $886
line 1512
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $885
LABELV $887
line 1532
;1531:
;1532:	trap_S_MuteSound(cg.snap->ps.clientNum, CHAN_WEAPON);
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_S_MuteSound
CALLV
pop
line 1533
;1533:}
LABELV $882
endproc CG_OutOfAmmoChange 12 8
export CG_FireATST
proc CG_FireATST 8 16
line 1546
;1534:
;1535:
;1536:
;1537:/*
;1538:===================================================================================================
;1539:
;1540:WEAPON EVENTS
;1541:
;1542:===================================================================================================
;1543:*/
;1544:
;1545:void CG_FireATST(centity_t *cent, qboolean altFire)
;1546:{
line 1578
;1547://No muzzle flash for now?
;1548:#if 0
;1549:	int getMeBolt = 0;
;1550:	mdxaBone_t boltMatrix;
;1551:	vec3_t flashorigin, flashdir;
;1552:
;1553:	if (!cgs.clientinfo[cent->currentState.number].bolt_lhand)
;1554:	{
;1555:		return;
;1556:	}
;1557:
;1558:	if (altFire)
;1559:	{
;1560:		getMeBolt = cgs.clientinfo[cent->currentState.number].bolt_lhand;
;1561:	}
;1562:	else
;1563:	{
;1564:		getMeBolt = cgs.clientinfo[cent->currentState.number].bolt_rhand;
;1565:	}
;1566:
;1567: 	if (!(trap_G2API_GetBoltMatrix(cent->ghoul2, 0, getMeBolt, &boltMatrix, cent->lerpAngles, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale)))
;1568:	{
;1569:		return;
;1570:	}
;1571:			
;1572:	trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, ORIGIN, flashorigin);
;1573:	trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, POSITIVE_X, flashdir);
;1574:
;1575:	trap_FX_PlayEffectID(trap_FX_RegisterEffect("turret/muzzle_flash.efx"), flashorigin, flashdir);
;1576:#endif
;1577:
;1578:	trap_S_StartSound(NULL, cent->currentState.number, CHAN_WEAPON, trap_S_RegisterSound(va("sound/weapons/atst/ATSTfire1.wav"/*, Q_irand(1,4)*/)));
ADDRGP4 $900
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1579
;1579:}
LABELV $899
endproc CG_FireATST 8 16
export CG_GetClientWeaponMuzzleBoltPoint
proc CG_GetClientWeaponMuzzleBoltPoint 80 36
line 1582
;1580:
;1581:void CG_GetClientWeaponMuzzleBoltPoint(int clIndex, vec3_t to)
;1582:{
line 1586
;1583:	centity_t *cent;
;1584:	mdxaBone_t	boltMatrix;
;1585:
;1586:	if (clIndex < 0 || clIndex >= MAX_CLIENTS)
ADDRLP4 52
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $904
ADDRLP4 52
INDIRI4
CNSTI4 32
LTI4 $902
LABELV $904
line 1587
;1587:	{
line 1588
;1588:		return;
ADDRGP4 $901
JUMPV
LABELV $902
line 1591
;1589:	}
;1590:
;1591:	cent = &cg_entities[clIndex];
ADDRLP4 0
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1593
;1592:
;1593:	if (!cent || !cent->ghoul2 || !trap_G2_HaveWeGhoul2Models(cent->ghoul2) ||
ADDRLP4 60
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 60
INDIRU4
EQU4 $909
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRLP4 60
INDIRU4
EQU4 $909
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $909
ADDRLP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 72
ADDRGP4 trap_G2API_HasGhoul2ModelOnIndex
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $905
LABELV $909
line 1595
;1594:		!trap_G2API_HasGhoul2ModelOnIndex(&(cent->ghoul2), 1))
;1595:	{
line 1596
;1596:		return;
ADDRGP4 $901
JUMPV
LABELV $905
line 1599
;1597:	}
;1598:
;1599:	trap_G2API_GetBoltMatrix(cent->ghoul2, 1, 0, &boltMatrix, cent->turAngles, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1016
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 1600
;1600:	trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, ORIGIN, to);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 1601
;1601:}
LABELV $901
endproc CG_GetClientWeaponMuzzleBoltPoint 80 36
export CG_FireWeapon
proc CG_FireWeapon 20 16
line 1610
;1602:
;1603:/*
;1604:================
;1605:CG_FireWeapon
;1606:
;1607:Caused by an EV_FIRE_WEAPON event
;1608:================
;1609:*/
;1610:void CG_FireWeapon( centity_t *cent, qboolean altFire ) {
line 1615
;1611:	entityState_t *ent;
;1612:	int				c;
;1613:	weaponInfo_t	*weap;
;1614:
;1615:	if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $913
line 1616
;1616:	{
line 1617
;1617:		CG_FireATST(cent, altFire);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_FireATST
CALLV
pop
line 1618
;1618:		return;
ADDRGP4 $912
JUMPV
LABELV $913
line 1621
;1619:	}
;1620:
;1621:	ent = &cent->currentState;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 1622
;1622:	if ( ent->weapon == WP_NONE ) {
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
NEI4 $915
line 1623
;1623:		return;
ADDRGP4 $912
JUMPV
LABELV $915
line 1625
;1624:	}
;1625:	if ( ent->weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 16
LTI4 $917
line 1626
;1626:		CG_Error( "CG_FireWeapon: ent->weapon >= WP_NUM_WEAPONS" );
ADDRGP4 $919
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1627
;1627:		return;
ADDRGP4 $912
JUMPV
LABELV $917
line 1629
;1628:	}
;1629:	weap = &cg_weapons[ ent->weapon ];
ADDRLP4 4
CNSTI4 208
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 1633
;1630:
;1631:	// mark the entity as muzzle flashing, so when it is added it will
;1632:	// append the flash to the weapon model
;1633:	cent->muzzleFlashTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1635
;1634:
;1635:	if (cg.predictedPlayerState.clientNum == cent->currentState.number)
ADDRGP4 cg+96+144
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $921
line 1636
;1636:	{
line 1637
;1637:		if ((ent->weapon == WP_BRYAR_PISTOL && altFire) ||
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
NEI4 $928
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $929
LABELV $928
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 6
NEI4 $930
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $929
LABELV $930
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 8
NEI4 $925
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $925
LABELV $929
line 1640
;1638:			(ent->weapon == WP_BOWCASTER && !altFire) ||
;1639:			(ent->weapon == WP_DEMP2 && altFire))
;1640:		{
line 1641
;1641:			float val = ( cg.time - cent->currentState.constantLight ) * 0.001f;
ADDRLP4 12
CNSTF4 981668463
ADDRGP4 cg+64
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 1643
;1642:
;1643:			if (val > 3)
ADDRLP4 12
INDIRF4
CNSTF4 1077936128
LEF4 $932
line 1644
;1644:			{
line 1645
;1645:				val = 3;
ADDRLP4 12
CNSTF4 1077936128
ASGNF4
line 1646
;1646:			}
LABELV $932
line 1647
;1647:			if (val < 0.2)
ADDRLP4 12
INDIRF4
CNSTF4 1045220557
GEF4 $934
line 1648
;1648:			{
line 1649
;1649:				val = 0.2;
ADDRLP4 12
CNSTF4 1045220557
ASGNF4
line 1650
;1650:			}
LABELV $934
line 1652
;1651:
;1652:			val *= 2;
ADDRLP4 12
CNSTF4 1073741824
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 1654
;1653:
;1654:			CGCam_Shake( val, 250 );
ADDRLP4 12
INDIRF4
ARGF4
CNSTI4 250
ARGI4
ADDRGP4 CGCam_Shake
CALLV
pop
line 1655
;1655:		}
ADDRGP4 $926
JUMPV
LABELV $925
line 1656
;1656:		else if (ent->weapon == WP_ROCKET_LAUNCHER ||
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 10
EQI4 $939
ADDRLP4 12
INDIRI4
CNSTI4 7
NEI4 $940
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $939
LABELV $940
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 9
NEI4 $936
LABELV $939
line 1659
;1657:			(ent->weapon == WP_REPEATER && altFire) ||
;1658:			ent->weapon == WP_FLECHETTE)
;1659:		{
line 1660
;1660:			if (ent->weapon == WP_ROCKET_LAUNCHER)
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 10
NEI4 $941
line 1661
;1661:			{
line 1662
;1662:				CGCam_Shake(Q_irand(2, 3), 350);
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 16
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
CNSTI4 350
ARGI4
ADDRGP4 CGCam_Shake
CALLV
pop
line 1663
;1663:			}
ADDRGP4 $942
JUMPV
LABELV $941
line 1664
;1664:			else if (ent->weapon == WP_REPEATER)
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 7
NEI4 $943
line 1665
;1665:			{
line 1666
;1666:				CGCam_Shake(Q_irand(2, 3), 350);
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 16
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
CNSTI4 350
ARGI4
ADDRGP4 CGCam_Shake
CALLV
pop
line 1667
;1667:			}
ADDRGP4 $944
JUMPV
LABELV $943
line 1668
;1668:			else if (ent->weapon == WP_FLECHETTE)
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 9
NEI4 $945
line 1669
;1669:			{
line 1670
;1670:				if (altFire)
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $947
line 1671
;1671:				{
line 1672
;1672:					CGCam_Shake(Q_irand(2, 3), 350);
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 16
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
CNSTI4 350
ARGI4
ADDRGP4 CGCam_Shake
CALLV
pop
line 1673
;1673:				}
ADDRGP4 $948
JUMPV
LABELV $947
line 1675
;1674:				else
;1675:				{
line 1676
;1676:					CGCam_Shake(1.5, 250);
CNSTF4 1069547520
ARGF4
CNSTI4 250
ARGI4
ADDRGP4 CGCam_Shake
CALLV
pop
line 1677
;1677:				}
LABELV $948
line 1678
;1678:			}
LABELV $945
LABELV $944
LABELV $942
line 1679
;1679:		}
LABELV $936
LABELV $926
line 1680
;1680:	}
LABELV $921
line 1682
;1681:	// lightning gun only does this this on initial press
;1682:	if ( ent->weapon == WP_DEMP2 ) {
ADDRLP4 8
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 8
NEI4 $949
line 1683
;1683:		if ( cent->pe.lightningFiring ) {
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CNSTI4 0
EQI4 $951
line 1684
;1684:			return;
ADDRGP4 $912
JUMPV
LABELV $951
line 1686
;1685:		}
;1686:	}
LABELV $949
line 1689
;1687:
;1688:	// play quad sound if needed
;1689:	if ( cent->currentState.powerups & ( 1 << PW_QUAD ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $953
line 1691
;1690:		//trap_S_StartSound (NULL, cent->currentState.number, CHAN_ITEM, cgs.media.quadSound );
;1691:	}
LABELV $953
line 1695
;1692:
;1693:
;1694:	// play a sound
;1695:	if (altFire)
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $955
line 1696
;1696:	{
line 1698
;1697:		// play a sound
;1698:		for ( c = 0 ; c < 4 ; c++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $957
line 1699
;1699:			if ( !weap->altFlashSound[c] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 132
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $961
line 1700
;1700:				break;
ADDRGP4 $959
JUMPV
LABELV $961
line 1702
;1701:			}
;1702:		}
LABELV $958
line 1698
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $957
LABELV $959
line 1703
;1703:		if ( c > 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $956
line 1704
;1704:			c = rand() % c;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
MODI4
ASGNI4
line 1705
;1705:			if ( weap->altFlashSound[c] )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 132
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $956
line 1706
;1706:			{
line 1707
;1707:				trap_S_StartSound( NULL, ent->number, CHAN_WEAPON, weap->altFlashSound[c] );
CNSTP4 0
ARGP4
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 132
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1708
;1708:			}
line 1709
;1709:		}
line 1714
;1710://		if ( weap->altFlashSnd )
;1711://		{
;1712://			trap_S_StartSound( NULL, ent->number, CHAN_WEAPON, weap->altFlashSnd );
;1713://		}
;1714:	}
ADDRGP4 $956
JUMPV
LABELV $955
line 1716
;1715:	else
;1716:	{
line 1718
;1717:		// play a sound
;1718:		for ( c = 0 ; c < 4 ; c++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $967
line 1719
;1719:			if ( !weap->flashSound[c] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $971
line 1720
;1720:				break;
ADDRGP4 $969
JUMPV
LABELV $971
line 1722
;1721:			}
;1722:		}
LABELV $968
line 1718
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $967
LABELV $969
line 1723
;1723:		if ( c > 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $973
line 1724
;1724:			c = rand() % c;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
MODI4
ASGNI4
line 1725
;1725:			if ( weap->flashSound[c] )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $975
line 1726
;1726:			{
line 1727
;1727:				trap_S_StartSound( NULL, ent->number, CHAN_WEAPON, weap->flashSound[c] );
CNSTP4 0
ARGP4
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1728
;1728:			}
LABELV $975
line 1729
;1729:		}
LABELV $973
line 1730
;1730:	}
LABELV $956
line 1731
;1731:}
LABELV $912
endproc CG_FireWeapon 20 16
lit
align 4
LABELV $978
byte 4 0
byte 4 0
byte 4 1065353216
export CG_MissileHitWall
code
proc CG_MissileHitWall 24 12
line 1742
;1732:
;1733:
;1734:/*
;1735:=================
;1736:CG_MissileHitWall
;1737:
;1738:Caused by an EV_MISSILE_MISS event, or directly by local bullet tracing
;1739:=================
;1740:*/
;1741:void CG_MissileHitWall(int weapon, int clientNum, vec3_t origin, vec3_t dir, impactSound_t soundType, qboolean altFire, int charge) 
;1742:{
line 1744
;1743:	int parm;
;1744:	vec3_t up={0,0,1};
ADDRLP4 0
ADDRGP4 $978
INDIRB
ASGNB 12
line 1746
;1745:
;1746:	switch( weapon )
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 3
LTI4 $979
ADDRLP4 16
INDIRI4
CNSTI4 15
GTI4 $979
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1005-12
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1005
address $981
address $985
address $986
address $987
address $988
address $991
address $995
address $998
address $999
address $979
address $979
address $1004
address $984
code
line 1747
;1747:	{
LABELV $981
line 1749
;1748:	case WP_BRYAR_PISTOL:
;1749:		if ( altFire )
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $982
line 1750
;1750:		{
line 1751
;1751:			parm = charge;
ADDRLP4 12
ADDRFP4 24
INDIRI4
ASGNI4
line 1752
;1752:			FX_BryarAltHitWall( origin, dir, parm );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 FX_BryarAltHitWall
CALLV
pop
line 1753
;1753:		}
ADDRGP4 $980
JUMPV
LABELV $982
line 1755
;1754:		else
;1755:		{
line 1756
;1756:			FX_BryarHitWall( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_BryarHitWall
CALLV
pop
line 1757
;1757:		}
line 1758
;1758:		break;
ADDRGP4 $980
JUMPV
LABELV $984
line 1761
;1759:
;1760:	case WP_TURRET:
;1761:		FX_TurretHitWall( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_TurretHitWall
CALLV
pop
line 1762
;1762:		break;
ADDRGP4 $980
JUMPV
LABELV $985
line 1765
;1763:
;1764:	case WP_BLASTER:
;1765:		FX_BlasterWeaponHitWall( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_BlasterWeaponHitWall
CALLV
pop
line 1766
;1766:		break;
ADDRGP4 $980
JUMPV
LABELV $986
line 1769
;1767:
;1768:	case WP_DISRUPTOR:
;1769:		FX_DisruptorAltMiss( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_DisruptorAltMiss
CALLV
pop
line 1770
;1770:		break;
ADDRGP4 $980
JUMPV
LABELV $987
line 1773
;1771:
;1772:	case WP_BOWCASTER:
;1773:		FX_BowcasterHitWall( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_BowcasterHitWall
CALLV
pop
line 1774
;1774:		break;
ADDRGP4 $980
JUMPV
LABELV $988
line 1777
;1775:
;1776:	case WP_REPEATER:
;1777:		if ( altFire )
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $989
line 1778
;1778:		{
line 1779
;1779:			FX_RepeaterAltHitWall( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_RepeaterAltHitWall
CALLV
pop
line 1780
;1780:		}
ADDRGP4 $980
JUMPV
LABELV $989
line 1782
;1781:		else
;1782:		{
line 1783
;1783:			FX_RepeaterHitWall( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_RepeaterHitWall
CALLV
pop
line 1784
;1784:		}
line 1785
;1785:		break;
ADDRGP4 $980
JUMPV
LABELV $991
line 1788
;1786:
;1787:	case WP_DEMP2:
;1788:		if (altFire)
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $992
line 1789
;1789:		{
line 1790
;1790:			trap_FX_PlayEffectID(trap_FX_RegisterEffect("demp2/altDetonate.efx"), origin, dir);
ADDRGP4 $994
ARGP4
ADDRLP4 20
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1791
;1791:		}
ADDRGP4 $980
JUMPV
LABELV $992
line 1793
;1792:		else
;1793:		{
line 1794
;1794:			FX_DEMP2_HitWall( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_DEMP2_HitWall
CALLV
pop
line 1795
;1795:		}
line 1796
;1796:		break;
ADDRGP4 $980
JUMPV
LABELV $995
line 1805
;1797:
;1798:	case WP_FLECHETTE:
;1799:		/*if (altFire)
;1800:		{
;1801:			CG_SurfaceExplosion(origin, dir, 20.0f, 12.0f, qtrue);
;1802:		}
;1803:		else
;1804:		*/
;1805:		if (!altFire)
ADDRFP4 20
INDIRI4
CNSTI4 0
NEI4 $980
line 1806
;1806:		{
line 1807
;1807:			FX_FlechetteWeaponHitWall( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_FlechetteWeaponHitWall
CALLV
pop
line 1808
;1808:		}
line 1809
;1809:		break;
ADDRGP4 $980
JUMPV
LABELV $998
line 1812
;1810:
;1811:	case WP_ROCKET_LAUNCHER:
;1812:		FX_RocketHitWall( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_RocketHitWall
CALLV
pop
line 1813
;1813:		break;
ADDRGP4 $980
JUMPV
LABELV $999
line 1816
;1814:
;1815:	case WP_THERMAL:
;1816:		trap_FX_PlayEffectID( cgs.effects.thermalExplosionEffect, origin, dir );
ADDRGP4 cgs+71560+132
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1817
;1817:		trap_FX_PlayEffectID( cgs.effects.thermalShockwaveEffect, origin, up );
ADDRGP4 cgs+71560+136
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1818
;1818:		break;
ADDRGP4 $980
JUMPV
LABELV $1004
line 1821
;1819:
;1820:	case WP_EMPLACED_GUN:
;1821:		FX_BlasterWeaponHitWall( origin, dir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 FX_BlasterWeaponHitWall
CALLV
pop
line 1823
;1822:		//FIXME: Give it its own hit wall effect
;1823:		break;
LABELV $979
LABELV $980
line 1825
;1824:	}
;1825:}
LABELV $977
endproc CG_MissileHitWall 24 12
lit
align 4
LABELV $1008
byte 4 0
byte 4 0
byte 4 1065353216
export CG_MissileHitPlayer
code
proc CG_MissileHitPlayer 24 12
line 1834
;1826:
;1827:
;1828:/*
;1829:=================
;1830:CG_MissileHitPlayer
;1831:=================
;1832:*/
;1833:void CG_MissileHitPlayer(int weapon, vec3_t origin, vec3_t dir, int entityNum, qboolean altFire) 
;1834:{
line 1835
;1835:	qboolean	humanoid = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1836
;1836:	vec3_t up={0,0,1};
ADDRLP4 4
ADDRGP4 $1008
INDIRB
ASGNB 12
line 1856
;1837:
;1838:	/*
;1839:	// NOTENOTE Non-portable code from single player
;1840:	if ( cent->gent )
;1841:	{
;1842:		other = &g_entities[cent->gent->s.otherEntityNum];
;1843:
;1844:		if ( other->client && other->client->playerTeam == TEAM_BOTS )
;1845:		{
;1846:			humanoid = qfalse;
;1847:		}
;1848:	}
;1849:	*/	
;1850:
;1851:	// NOTENOTE No bleeding in this game
;1852://	CG_Bleed( origin, entityNum );
;1853:
;1854:	// some weapons will make an explosion with the blood, while
;1855:	// others will just make the blood
;1856:	switch ( weapon ) {
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 3
LTI4 $1010
ADDRLP4 16
INDIRI4
CNSTI4 15
GTI4 $1010
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1032-12
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1032
address $1011
address $1015
address $1016
address $1017
address $1018
address $1021
address $1024
address $1025
address $1026
address $1010
address $1010
address $1031
address $1014
code
LABELV $1011
line 1858
;1857:	case WP_BRYAR_PISTOL:
;1858:		if ( altFire )
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $1012
line 1859
;1859:		{
line 1860
;1860:			FX_BryarAltHitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_BryarAltHitPlayer
CALLV
pop
line 1861
;1861:		}
ADDRGP4 $1010
JUMPV
LABELV $1012
line 1863
;1862:		else
;1863:		{
line 1864
;1864:			FX_BryarHitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_BryarHitPlayer
CALLV
pop
line 1865
;1865:		}
line 1866
;1866:		break;
ADDRGP4 $1010
JUMPV
LABELV $1014
line 1869
;1867:
;1868:	case WP_TURRET:
;1869:		FX_TurretHitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_TurretHitPlayer
CALLV
pop
line 1870
;1870:		break;
ADDRGP4 $1010
JUMPV
LABELV $1015
line 1873
;1871:
;1872:	case WP_BLASTER:
;1873:		FX_BlasterWeaponHitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_BlasterWeaponHitPlayer
CALLV
pop
line 1874
;1874:		break;
ADDRGP4 $1010
JUMPV
LABELV $1016
line 1877
;1875:
;1876:	case WP_DISRUPTOR:
;1877:		FX_DisruptorAltHit( origin, dir);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 FX_DisruptorAltHit
CALLV
pop
line 1878
;1878:		break;
ADDRGP4 $1010
JUMPV
LABELV $1017
line 1881
;1879:
;1880:	case WP_BOWCASTER:
;1881:		FX_BowcasterHitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_BowcasterHitPlayer
CALLV
pop
line 1882
;1882:		break;
ADDRGP4 $1010
JUMPV
LABELV $1018
line 1885
;1883:
;1884:	case WP_REPEATER:
;1885:		if ( altFire )
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $1019
line 1886
;1886:		{
line 1887
;1887:			FX_RepeaterAltHitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_RepeaterAltHitPlayer
CALLV
pop
line 1888
;1888:		}
ADDRGP4 $1010
JUMPV
LABELV $1019
line 1890
;1889:		else
;1890:		{
line 1891
;1891:			FX_RepeaterHitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_RepeaterHitPlayer
CALLV
pop
line 1892
;1892:		}
line 1893
;1893:		break;
ADDRGP4 $1010
JUMPV
LABELV $1021
line 1905
;1894:
;1895:	case WP_DEMP2:
;1896:		// Do a full body effect here for some more feedback
;1897:		// NOTENOTE The chaining of the demp2 is not yet implemented.
;1898:		/*
;1899:		if ( other )
;1900:		{
;1901:			other->s.powerups |= ( 1 << PW_DISINT_1 );
;1902:			other->client->ps.powerups[PW_DISINT_1] = cg.time + 650;
;1903:		}
;1904:		*/
;1905:		if (altFire)
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $1022
line 1906
;1906:		{
line 1907
;1907:			trap_FX_PlayEffectID(trap_FX_RegisterEffect("demp2/altDetonate.efx"), origin, dir);
ADDRGP4 $994
ARGP4
ADDRLP4 20
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1908
;1908:		}
ADDRGP4 $1010
JUMPV
LABELV $1022
line 1910
;1909:		else
;1910:		{
line 1911
;1911:			FX_DEMP2_HitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_DEMP2_HitPlayer
CALLV
pop
line 1912
;1912:		}
line 1913
;1913:		break;
ADDRGP4 $1010
JUMPV
LABELV $1024
line 1916
;1914:
;1915:	case WP_FLECHETTE:
;1916:		FX_FlechetteWeaponHitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_FlechetteWeaponHitPlayer
CALLV
pop
line 1917
;1917:		break;
ADDRGP4 $1010
JUMPV
LABELV $1025
line 1920
;1918:
;1919:	case WP_ROCKET_LAUNCHER:
;1920:		FX_RocketHitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_RocketHitPlayer
CALLV
pop
line 1921
;1921:		break;
ADDRGP4 $1010
JUMPV
LABELV $1026
line 1924
;1922:
;1923:	case WP_THERMAL:
;1924:		trap_FX_PlayEffectID( cgs.effects.thermalExplosionEffect, origin, dir );
ADDRGP4 cgs+71560+132
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1925
;1925:		trap_FX_PlayEffectID( cgs.effects.thermalShockwaveEffect, origin, up );
ADDRGP4 cgs+71560+136
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1926
;1926:		break;
ADDRGP4 $1010
JUMPV
LABELV $1031
line 1929
;1927:	case WP_EMPLACED_GUN:
;1928:		//FIXME: Its own effect?
;1929:		FX_BlasterWeaponHitPlayer( origin, dir, humanoid );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 FX_BlasterWeaponHitPlayer
CALLV
pop
line 1930
;1930:		break;
line 1933
;1931:
;1932:	default:
;1933:		break;
LABELV $1010
line 1935
;1934:	}
;1935:}
LABELV $1007
endproc CG_MissileHitPlayer 24 12
export CG_Tracer
proc CG_Tracer 224 12
line 1952
;1936:
;1937:
;1938:/*
;1939:============================================================================
;1940:
;1941:BULLETS
;1942:
;1943:============================================================================
;1944:*/
;1945:
;1946:
;1947:/*
;1948:===============
;1949:CG_Tracer
;1950:===============
;1951:*/
;1952:void CG_Tracer( vec3_t source, vec3_t dest ) {
line 1961
;1953:	vec3_t		forward, right;
;1954:	polyVert_t	verts[4];
;1955:	vec3_t		line;
;1956:	float		len, begin, end;
;1957:	vec3_t		start, finish;
;1958:	vec3_t		midpoint;
;1959:
;1960:	// tracer
;1961:	VectorSubtract( dest, source, forward );
ADDRLP4 180
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
ADDRLP4 180
INDIRP4
INDIRF4
ADDRLP4 184
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 188
CNSTI4 4
ASGNI4
ADDRLP4 108+4
ADDRLP4 180
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRF4
ADDRLP4 184
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 192
CNSTI4 8
ASGNI4
ADDRLP4 108+8
ADDRFP4 4
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1962
;1962:	len = VectorNormalize( forward );
ADDRLP4 108
ARGP4
ADDRLP4 196
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 196
INDIRF4
ASGNF4
line 1965
;1963:
;1964:	// start at least a little ways from the muzzle
;1965:	if ( len < 100 ) {
ADDRLP4 164
INDIRF4
CNSTF4 1120403456
GEF4 $1037
line 1966
;1966:		return;
ADDRGP4 $1034
JUMPV
LABELV $1037
line 1968
;1967:	}
;1968:	begin = 50 + random() * (len - 60);
ADDRLP4 200
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 160
ADDRLP4 200
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 164
INDIRF4
CNSTF4 1114636288
SUBF4
MULF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 1969
;1969:	end = begin + cg_tracerLength.value;
ADDRLP4 156
ADDRLP4 160
INDIRF4
ADDRGP4 cg_tracerLength+8
INDIRF4
ADDF4
ASGNF4
line 1970
;1970:	if ( end > len ) {
ADDRLP4 156
INDIRF4
ADDRLP4 164
INDIRF4
LEF4 $1040
line 1971
;1971:		end = len;
ADDRLP4 156
ADDRLP4 164
INDIRF4
ASGNF4
line 1972
;1972:	}
LABELV $1040
line 1973
;1973:	VectorMA( source, begin, forward, start );
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
ADDRLP4 204
INDIRP4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 160
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 120+4
ADDRLP4 204
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 108+4
INDIRF4
ADDRLP4 160
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 120+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 108+8
INDIRF4
ADDRLP4 160
INDIRF4
MULF4
ADDF4
ASGNF4
line 1974
;1974:	VectorMA( source, end, forward, finish );
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
ADDRLP4 212
INDIRP4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 156
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 132+4
ADDRLP4 212
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 108+4
INDIRF4
ADDRLP4 156
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 132+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 108+8
INDIRF4
ADDRLP4 156
INDIRF4
MULF4
ADDF4
ASGNF4
line 1976
;1975:
;1976:	line[0] = DotProduct( forward, cg.refdef.viewaxis[1] );
ADDRLP4 144
ADDRLP4 108
INDIRF4
ADDRGP4 cg+3604+36+12
INDIRF4
MULF4
ADDRLP4 108+4
INDIRF4
ADDRGP4 cg+3604+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 108+8
INDIRF4
ADDRGP4 cg+3604+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1977
;1977:	line[1] = DotProduct( forward, cg.refdef.viewaxis[2] );
ADDRLP4 144+4
ADDRLP4 108
INDIRF4
ADDRGP4 cg+3604+36+24
INDIRF4
MULF4
ADDRLP4 108+4
INDIRF4
ADDRGP4 cg+3604+36+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 108+8
INDIRF4
ADDRGP4 cg+3604+36+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1979
;1978:
;1979:	VectorScale( cg.refdef.viewaxis[1], line[1], right );
ADDRLP4 96
ADDRGP4 cg+3604+36+12
INDIRF4
ADDRLP4 144+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 96+4
ADDRGP4 cg+3604+36+12+4
INDIRF4
ADDRLP4 144+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 96+8
ADDRGP4 cg+3604+36+12+8
INDIRF4
ADDRLP4 144+4
INDIRF4
MULF4
ASGNF4
line 1980
;1980:	VectorMA( right, -line[0], cg.refdef.viewaxis[2], right );
ADDRLP4 220
ADDRLP4 144
INDIRF4
NEGF4
ASGNF4
ADDRLP4 96
ADDRLP4 96
INDIRF4
ADDRGP4 cg+3604+36+24
INDIRF4
ADDRLP4 220
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg+3604+36+24+4
INDIRF4
ADDRLP4 220
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96+8
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg+3604+36+24+8
INDIRF4
ADDRLP4 144
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 1981
;1981:	VectorNormalize( right );
ADDRLP4 96
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1983
;1982:
;1983:	VectorMA( finish, cg_tracerWidth.value, right, verts[0].xyz );
ADDRLP4 0
ADDRLP4 132
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 132+4
INDIRF4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 132+8
INDIRF4
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1984
;1984:	verts[0].st[0] = 0;
ADDRLP4 0+12
CNSTF4 0
ASGNF4
line 1985
;1985:	verts[0].st[1] = 1;
ADDRLP4 0+12+4
CNSTF4 1065353216
ASGNF4
line 1986
;1986:	verts[0].modulate[0] = 255;
ADDRLP4 0+20
CNSTU1 255
ASGNU1
line 1987
;1987:	verts[0].modulate[1] = 255;
ADDRLP4 0+20+1
CNSTU1 255
ASGNU1
line 1988
;1988:	verts[0].modulate[2] = 255;
ADDRLP4 0+20+2
CNSTU1 255
ASGNU1
line 1989
;1989:	verts[0].modulate[3] = 255;
ADDRLP4 0+20+3
CNSTU1 255
ASGNU1
line 1991
;1990:
;1991:	VectorMA( finish, -cg_tracerWidth.value, right, verts[1].xyz );
ADDRLP4 0+24
ADDRLP4 132
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+24+4
ADDRLP4 132+4
INDIRF4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+24+8
ADDRLP4 132+8
INDIRF4
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 1992
;1992:	verts[1].st[0] = 1;
ADDRLP4 0+24+12
CNSTF4 1065353216
ASGNF4
line 1993
;1993:	verts[1].st[1] = 0;
ADDRLP4 0+24+12+4
CNSTF4 0
ASGNF4
line 1994
;1994:	verts[1].modulate[0] = 255;
ADDRLP4 0+24+20
CNSTU1 255
ASGNU1
line 1995
;1995:	verts[1].modulate[1] = 255;
ADDRLP4 0+24+20+1
CNSTU1 255
ASGNU1
line 1996
;1996:	verts[1].modulate[2] = 255;
ADDRLP4 0+24+20+2
CNSTU1 255
ASGNU1
line 1997
;1997:	verts[1].modulate[3] = 255;
ADDRLP4 0+24+20+3
CNSTU1 255
ASGNU1
line 1999
;1998:
;1999:	VectorMA( start, -cg_tracerWidth.value, right, verts[2].xyz );
ADDRLP4 0+48
ADDRLP4 120
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+48+4
ADDRLP4 120+4
INDIRF4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+48+8
ADDRLP4 120+8
INDIRF4
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 2000
;2000:	verts[2].st[0] = 1;
ADDRLP4 0+48+12
CNSTF4 1065353216
ASGNF4
line 2001
;2001:	verts[2].st[1] = 1;
ADDRLP4 0+48+12+4
CNSTF4 1065353216
ASGNF4
line 2002
;2002:	verts[2].modulate[0] = 255;
ADDRLP4 0+48+20
CNSTU1 255
ASGNU1
line 2003
;2003:	verts[2].modulate[1] = 255;
ADDRLP4 0+48+20+1
CNSTU1 255
ASGNU1
line 2004
;2004:	verts[2].modulate[2] = 255;
ADDRLP4 0+48+20+2
CNSTU1 255
ASGNU1
line 2005
;2005:	verts[2].modulate[3] = 255;
ADDRLP4 0+48+20+3
CNSTU1 255
ASGNU1
line 2007
;2006:
;2007:	VectorMA( start, cg_tracerWidth.value, right, verts[3].xyz );
ADDRLP4 0+72
ADDRLP4 120
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+72+4
ADDRLP4 120+4
INDIRF4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+72+8
ADDRLP4 120+8
INDIRF4
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2008
;2008:	verts[3].st[0] = 0;
ADDRLP4 0+72+12
CNSTF4 0
ASGNF4
line 2009
;2009:	verts[3].st[1] = 0;
ADDRLP4 0+72+12+4
CNSTF4 0
ASGNF4
line 2010
;2010:	verts[3].modulate[0] = 255;
ADDRLP4 0+72+20
CNSTU1 255
ASGNU1
line 2011
;2011:	verts[3].modulate[1] = 255;
ADDRLP4 0+72+20+1
CNSTU1 255
ASGNU1
line 2012
;2012:	verts[3].modulate[2] = 255;
ADDRLP4 0+72+20+2
CNSTU1 255
ASGNU1
line 2013
;2013:	verts[3].modulate[3] = 255;
ADDRLP4 0+72+20+3
CNSTU1 255
ASGNU1
line 2015
;2014:
;2015:	trap_R_AddPolyToScene( cgs.media.tracerShader, 4, verts );
ADDRGP4 cgs+70280+196
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 2017
;2016:
;2017:	midpoint[0] = ( start[0] + finish[0] ) * 0.5;
ADDRLP4 168
CNSTF4 1056964608
ADDRLP4 120
INDIRF4
ADDRLP4 132
INDIRF4
ADDF4
MULF4
ASGNF4
line 2018
;2018:	midpoint[1] = ( start[1] + finish[1] ) * 0.5;
ADDRLP4 168+4
CNSTF4 1056964608
ADDRLP4 120+4
INDIRF4
ADDRLP4 132+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 2019
;2019:	midpoint[2] = ( start[2] + finish[2] ) * 0.5;
ADDRLP4 168+8
CNSTF4 1056964608
ADDRLP4 120+8
INDIRF4
ADDRLP4 132+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 2024
;2020:
;2021:	// add the tracer sound
;2022:	//trap_S_StartSound( midpoint, ENTITYNUM_WORLD, CHAN_AUTO, cgs.media.tracerSound );
;2023:
;2024:}
LABELV $1034
endproc CG_Tracer 224 12
export CG_CalcMuzzlePoint
proc CG_CalcMuzzlePoint 92 16
line 2031
;2025:
;2026:/*
;2027:======================
;2028:CG_CalcMuzzlePoint
;2029:======================
;2030:*/
;2031:qboolean CG_CalcMuzzlePoint( int entityNum, vec3_t muzzle ) {
line 2037
;2032:	vec3_t		forward, right;
;2033:	vec3_t		gunpoint;
;2034:	centity_t	*cent;
;2035:	int			anim;
;2036:
;2037:	if ( entityNum == cg.snap->ps.clientNum )
ADDRFP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $1220
line 2038
;2038:	{ //I'm not exactly sure why we'd be rendering someone else's crosshair, but hey.
line 2039
;2039:		int weapontype = cg.snap->ps.weapon;
ADDRLP4 56
ADDRGP4 cg+36
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 2042
;2040:		vec3_t weaponMuzzle;
;2041:
;2042:		VectorCopy(WP_MuzzlePoint[weapontype], weaponMuzzle);
ADDRLP4 44
CNSTI4 12
ADDRLP4 56
INDIRI4
MULI4
ADDRGP4 WP_MuzzlePoint
ADDP4
INDIRB
ASGNB 12
line 2044
;2043:
;2044:		if (weapontype == WP_DISRUPTOR || weapontype == WP_STUN_BATON || weapontype == WP_SABER)
ADDRLP4 56
INDIRI4
CNSTI4 5
EQI4 $1227
ADDRLP4 56
INDIRI4
CNSTI4 1
EQI4 $1227
ADDRLP4 56
INDIRI4
CNSTI4 2
NEI4 $1224
LABELV $1227
line 2045
;2045:		{
line 2046
;2046:			VectorClear(weaponMuzzle);
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 44+8
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 44+4
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 44
ADDRLP4 64
INDIRF4
ASGNF4
line 2047
;2047:		}
LABELV $1224
line 2049
;2048:
;2049:		if (cg.snap->ps.usingATST)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1230
line 2050
;2050:		{
line 2051
;2051:			VectorClear(weaponMuzzle);
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 44+8
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 44+4
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 44
ADDRLP4 64
INDIRF4
ASGNF4
line 2052
;2052:			weaponMuzzle[0] = 16;
ADDRLP4 44
CNSTF4 1098907648
ASGNF4
line 2053
;2053:			weaponMuzzle[2] = 128;
ADDRLP4 44+8
CNSTF4 1124073472
ASGNF4
line 2054
;2054:		}
LABELV $1230
line 2056
;2055:
;2056:		if (cg.renderingThirdPerson)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
EQI4 $1236
line 2057
;2057:		{
line 2058
;2058:			VectorCopy( cg.predictedPlayerEntity.lerpOrigin, gunpoint );
ADDRLP4 32
ADDRGP4 cg+1464+928
INDIRB
ASGNB 12
line 2059
;2059:			AngleVectors( cg.predictedPlayerEntity.lerpAngles, forward, right, NULL );
ADDRGP4 cg+1464+940
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2060
;2060:		}
ADDRGP4 $1237
JUMPV
LABELV $1236
line 2062
;2061:		else
;2062:		{
line 2063
;2063:			VectorCopy( cg.refdef.vieworg, gunpoint );
ADDRLP4 32
ADDRGP4 cg+3604+24
INDIRB
ASGNB 12
line 2064
;2064:			AngleVectors( cg.refdefViewAngles, forward, right, NULL );
ADDRGP4 cg+3972
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2065
;2065:		}
LABELV $1237
line 2067
;2066:
;2067:		if (weapontype == WP_EMPLACED_GUN && cg.snap->ps.emplacedIndex)
ADDRLP4 56
INDIRI4
CNSTI4 14
NEI4 $1246
ADDRGP4 cg+36
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1246
line 2068
;2068:		{
line 2069
;2069:			centity_t *gunEnt = &cg_entities[cg.snap->ps.emplacedIndex];
ADDRLP4 64
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 2071
;2070:
;2071:			if (gunEnt)
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1250
line 2072
;2072:			{
line 2075
;2073:				vec3_t pitchConstraint;
;2074:
;2075:				VectorCopy(gunEnt->lerpOrigin, gunpoint);
ADDRLP4 32
ADDRLP4 64
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2076
;2076:				gunpoint[2] += 46;
ADDRLP4 32+8
ADDRLP4 32+8
INDIRF4
CNSTF4 1110966272
ADDF4
ASGNF4
line 2078
;2077:
;2078:				if (cg.renderingThirdPerson)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
EQI4 $1253
line 2079
;2079:				{
line 2080
;2080:					VectorCopy(cg.predictedPlayerEntity.lerpAngles, pitchConstraint);
ADDRLP4 68
ADDRGP4 cg+1464+940
INDIRB
ASGNB 12
line 2081
;2081:				}
ADDRGP4 $1254
JUMPV
LABELV $1253
line 2083
;2082:				else
;2083:				{
line 2084
;2084:					VectorCopy(cg.refdefViewAngles, pitchConstraint);
ADDRLP4 68
ADDRGP4 cg+3972
INDIRB
ASGNB 12
line 2085
;2085:				}
LABELV $1254
line 2087
;2086:
;2087:				if (pitchConstraint[PITCH] > 40)
ADDRLP4 68
INDIRF4
CNSTF4 1109393408
LEF4 $1259
line 2088
;2088:				{
line 2089
;2089:					pitchConstraint[PITCH] = 40;
ADDRLP4 68
CNSTF4 1109393408
ASGNF4
line 2090
;2090:				}
LABELV $1259
line 2091
;2091:				AngleVectors( pitchConstraint, forward, right, NULL );
ADDRLP4 68
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2092
;2092:			}
LABELV $1250
line 2093
;2093:		}
LABELV $1246
line 2095
;2094:
;2095:		VectorCopy(gunpoint, muzzle);
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRB
ASGNB 12
line 2097
;2096:
;2097:		VectorMA(muzzle, weaponMuzzle[0], forward, muzzle);
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 72
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDF4
ASGNF4
line 2098
;2098:		VectorMA(muzzle, weaponMuzzle[1], right, muzzle);
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 44+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 80
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 20+4
INDIRF4
ADDRLP4 44+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 20+8
INDIRF4
ADDRLP4 44+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2100
;2099:
;2100:		if (weapontype == WP_EMPLACED_GUN && cg.snap->ps.emplacedIndex)
ADDRLP4 56
INDIRI4
CNSTI4 14
NEI4 $1268
ADDRGP4 cg+36
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1268
line 2101
;2101:		{
line 2103
;2102:			//Do nothing
;2103:		}
ADDRGP4 $1269
JUMPV
LABELV $1268
line 2104
;2104:		else if (cg.renderingThirdPerson)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
EQI4 $1271
line 2105
;2105:		{
line 2106
;2106:			muzzle[2] += cg.snap->ps.viewheight + weaponMuzzle[2];
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 44+8
INDIRF4
ADDF4
ADDF4
ASGNF4
line 2107
;2107:		}
ADDRGP4 $1272
JUMPV
LABELV $1271
line 2109
;2108:		else
;2109:		{
line 2110
;2110:			muzzle[2] += weaponMuzzle[2];
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
ADDRLP4 44+8
INDIRF4
ADDF4
ASGNF4
line 2111
;2111:		}
LABELV $1272
LABELV $1269
line 2113
;2112:
;2113:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1219
JUMPV
LABELV $1220
line 2116
;2114:	}
;2115:
;2116:	cent = &cg_entities[entityNum];
ADDRLP4 12
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 2117
;2117:	if ( !cent->currentValid ) {
ADDRLP4 12
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1277
line 2118
;2118:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1219
JUMPV
LABELV $1277
line 2121
;2119:	}
;2120:
;2121:	VectorCopy( cent->currentState.pos.trBase, muzzle );
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 2123
;2122:
;2123:	AngleVectors( cent->currentState.apos.trBase, forward, NULL, NULL );
ADDRLP4 12
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 44
CNSTP4 0
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2124
;2124:	anim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 2125
;2125:	if ( anim == BOTH_CROUCH1WALK || anim == BOTH_CROUCH1IDLE ) {
ADDRLP4 16
INDIRI4
CNSTI4 698
EQI4 $1281
ADDRLP4 16
INDIRI4
CNSTI4 697
NEI4 $1279
LABELV $1281
line 2126
;2126:		muzzle[2] += CROUCH_VIEWHEIGHT;
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 2127
;2127:	} else {
ADDRGP4 $1280
JUMPV
LABELV $1279
line 2128
;2128:		muzzle[2] += DEFAULT_VIEWHEIGHT;
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1108344832
ADDF4
ASGNF4
line 2129
;2129:	}
LABELV $1280
line 2131
;2130:
;2131:	VectorMA( muzzle, 14, forward, muzzle );
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 56
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2133
;2132:
;2133:	return qtrue;
CNSTI4 1
RETI4
LABELV $1219
endproc CG_CalcMuzzlePoint 92 16
export CG_InitG2Weapons
proc CG_InitG2Weapons 20 28
line 2146
;2134:
;2135:}
;2136:
;2137:
;2138:
;2139:/*
;2140:Ghoul2 Insert Start
;2141:*/
;2142:
;2143:// create one instance of all the weapons we are going to use so we can just copy this info into each clients gun ghoul2 object in fast way
;2144:void *g2WeaponInstances[MAX_WEAPONS];
;2145:void CG_InitG2Weapons(void)
;2146:{
line 2147
;2147:	int i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2149
;2148:	gitem_t		*item;
;2149:	memset(g2WeaponInstances, 0, sizeof(g2WeaponInstances));
ADDRGP4 g2WeaponInstances
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2150
;2150:	for ( item = bg_itemlist + 1 ; item->classname ; item++ ) 
ADDRLP4 0
ADDRGP4 bg_itemlist+52
ASGNP4
ADDRGP4 $1288
JUMPV
LABELV $1285
line 2151
;2151:	{
line 2152
;2152:		if ( item->giType == IT_WEAPON )
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1290
line 2153
;2153:		{
line 2155
;2154:			// initialise model
;2155:			trap_G2API_InitGhoul2Model(&g2WeaponInstances[/*i*/item->giTag], item->world_model[0], 0, 0, 0, 0, 0);
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_G2API_InitGhoul2Model
CALLI4
pop
line 2157
;2156://			trap_G2API_InitGhoul2Model(&g2WeaponInstances[i], item->world_model[0],G_ModelIndex( item->world_model[0] ) , 0, 0, 0, 0);
;2157:			if (g2WeaponInstances[/*i*/item->giTag])
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1292
line 2158
;2158:			{
line 2160
;2159:				// indicate we will be bolted to model 0 (ie the player) on bolt 0 (always the right hand) when we get copied
;2160:				trap_G2API_SetBoltInfo(g2WeaponInstances[/*i*/item->giTag], 0, 0);
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoltInfo
CALLV
pop
line 2162
;2161:				// now set up the gun bolt on it
;2162:				trap_G2API_AddBolt(g2WeaponInstances[/*i*/item->giTag], 0, "*flash");
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1294
ARGP4
ADDRGP4 trap_G2API_AddBolt
CALLI4
pop
line 2163
;2163:				i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2164
;2164:			}
LABELV $1292
line 2165
;2165:			if (i == MAX_WEAPONS)
ADDRLP4 4
INDIRI4
CNSTI4 16
NEI4 $1295
line 2166
;2166:			{
line 2167
;2167:				assert(0);	
line 2168
;2168:				break;
ADDRGP4 $1287
JUMPV
LABELV $1295
line 2171
;2169:			}
;2170:			
;2171:		}
LABELV $1290
line 2172
;2172:	}
LABELV $1286
line 2150
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
LABELV $1288
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1285
LABELV $1287
line 2173
;2173:}
LABELV $1284
endproc CG_InitG2Weapons 20 28
export CG_ShutDownG2Weapons
proc CG_ShutDownG2Weapons 4 4
line 2177
;2174:
;2175:// clean out any g2 models we instanciated for copying purposes
;2176:void CG_ShutDownG2Weapons(void)
;2177:{
line 2179
;2178:	int i;
;2179:	for (i=0; i<MAX_WEAPONS; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1298
line 2180
;2180:	{
line 2181
;2181:		trap_G2API_CleanGhoul2Models(&g2WeaponInstances[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 2182
;2182:	}
LABELV $1299
line 2179
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $1298
line 2183
;2183:}
LABELV $1297
endproc CG_ShutDownG2Weapons 4 4
export CG_CopyG2WeaponInstance
proc CG_CopyG2WeaponInstance 4 16
line 2187
;2184:
;2185:// what ghoul2 model do we want to copy ?
;2186:void CG_CopyG2WeaponInstance(int weaponNum, void *toGhoul2)
;2187:{
line 2189
;2188:	//rww - the -1 is because there is no "weapon" for WP_NONE
;2189:	assert(weaponNum < MAX_WEAPONS);
line 2190
;2190:	if (g2WeaponInstances[weaponNum/*-1*/])
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1303
line 2191
;2191:	{
line 2192
;2192:		if (weaponNum == WP_EMPLACED_GUN)
ADDRFP4 0
INDIRI4
CNSTI4 14
NEI4 $1305
line 2193
;2193:		{ //a bit of a hack to remove gun model when using an emplaced weap
line 2194
;2194:			if (trap_G2API_HasGhoul2ModelOnIndex(&(toGhoul2), 1))
ADDRFP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 trap_G2API_HasGhoul2ModelOnIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1306
line 2195
;2195:			{
line 2196
;2196:				trap_G2API_RemoveGhoul2Model(&(toGhoul2), 1);
ADDRFP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_G2API_RemoveGhoul2Model
CALLI4
pop
line 2197
;2197:			}
line 2198
;2198:		}
ADDRGP4 $1306
JUMPV
LABELV $1305
line 2200
;2199:		else
;2200:		{
line 2201
;2201:			trap_G2API_CopySpecificGhoul2Model(g2WeaponInstances[weaponNum/*-1*/], 0, toGhoul2, 1); 
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_G2API_CopySpecificGhoul2Model
CALLV
pop
line 2202
;2202:		}
LABELV $1306
line 2203
;2203:	}
LABELV $1303
line 2204
;2204:}
LABELV $1302
endproc CG_CopyG2WeaponInstance 4 16
export CG_CheckPlayerG2Weapons
proc CG_CheckPlayerG2Weapons 32 16
line 2207
;2205:
;2206:void CG_CheckPlayerG2Weapons(playerState_t *ps, centity_t *cent) 
;2207:{
line 2209
;2208:	// should we change the gun model on this player?
;2209:	if (cent->currentState.saberInFlight)
ADDRFP4 4
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1310
line 2210
;2210:	{
line 2211
;2211:		cent->ghoul2weapon = g2WeaponInstances[WP_SABER];
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
ADDRGP4 g2WeaponInstances+8
INDIRP4
ASGNP4
line 2212
;2212:	}
LABELV $1310
line 2214
;2213:
;2214:	if (cent->currentState.eFlags & EF_DEAD)
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1313
line 2215
;2215:	{ //no updating weapons when dead
line 2216
;2216:		cent->ghoul2weapon = NULL;
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
CNSTP4 0
ASGNP4
line 2217
;2217:		return;
ADDRGP4 $1309
JUMPV
LABELV $1313
line 2220
;2218:	}
;2219:
;2220:	if (cent->torsoBolt)
ADDRFP4 4
INDIRP4
CNSTI4 1012
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1315
line 2221
;2221:	{ //got our limb cut off, no updating weapons until it's restored
line 2222
;2222:		cent->ghoul2weapon = NULL;
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
CNSTP4 0
ASGNP4
line 2223
;2223:		return;
ADDRGP4 $1309
JUMPV
LABELV $1315
line 2226
;2224:	}
;2225:
;2226:	if (ps && ps->usingATST)
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1317
ADDRLP4 0
INDIRP4
CNSTI4 1304
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1317
line 2227
;2227:	{
line 2228
;2228:		cent->ghoul2weapon = NULL;
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
CNSTP4 0
ASGNP4
line 2229
;2229:	}
LABELV $1317
line 2231
;2230:
;2231:	if (cent->isATST)
ADDRFP4 4
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1319
line 2232
;2232:	{
line 2233
;2233:		cent->ghoul2weapon = NULL;
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
CNSTP4 0
ASGNP4
line 2234
;2234:		return;
ADDRGP4 $1309
JUMPV
LABELV $1319
line 2237
;2235:	}
;2236:
;2237:	if (cent->ghoul2 && cent->ghoul2weapon != g2WeaponInstances[ps->weapon] &&
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1321
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
INDIRP4
CVPU4 4
EQU4 $1321
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
INDIRI4
NEI4 $1321
line 2239
;2238:		ps->clientNum == cent->currentState.number) //don't want spectator mode forcing one client's weapon instance over another's
;2239:	{
line 2240
;2240:		CG_CopyG2WeaponInstance(ps->weapon, cent->ghoul2);
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_CopyG2WeaponInstance
CALLV
pop
line 2241
;2241:		cent->ghoul2weapon = g2WeaponInstances[ps->weapon];
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
INDIRP4
ASGNP4
line 2242
;2242:		if (cent->weapon == WP_SABER && cg_entities[cent->currentState.number].weapon != ps->weapon && !ps->saberHolstered)
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 956
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1323
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 12
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+956
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
EQI4 $1323
ADDRLP4 16
INDIRP4
CNSTI4 1300
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1323
line 2243
;2243:		{ //switching away from the saber
line 2244
;2244:			trap_S_StartSound(cent->lerpOrigin, cent->currentState.number, CHAN_AUTO, trap_S_RegisterSound( "sound/weapons/saber/saberoffquick.wav" ));
ADDRGP4 $1326
ARGP4
ADDRLP4 20
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2245
;2245:		}
ADDRGP4 $1324
JUMPV
LABELV $1323
line 2246
;2246:		else if (ps->weapon == WP_SABER && cg_entities[cent->currentState.number].weapon != ps->weapon)
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 2
NEI4 $1327
CNSTI4 1920
ADDRFP4 4
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+956
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $1327
line 2247
;2247:		{ //switching to the saber
line 2248
;2248:			trap_S_StartSound(cent->lerpOrigin, cent->currentState.number, CHAN_AUTO, trap_S_RegisterSound( "sound/weapons/saber/saberon.wav" ));
ADDRGP4 $1330
ARGP4
ADDRLP4 24
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2249
;2249:		}
LABELV $1327
LABELV $1324
line 2250
;2250:		cent->weapon = ps->weapon;
ADDRFP4 4
INDIRP4
CNSTI4 956
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 2251
;2251:		cg_entities[cent->currentState.number].weapon = ps->weapon;
CNSTI4 1920
ADDRFP4 4
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+956
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 2252
;2252:	}
LABELV $1321
line 2253
;2253:}
LABELV $1309
endproc CG_CheckPlayerG2Weapons 32 16
import hudTintColor
import redhudtint
import bluehudtint
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
import FX_DisruptorHitPlayer
import FX_DisruptorHitWall
import FX_DisruptorAltHit
import FX_DisruptorAltMiss
import FX_DisruptorAltShot
import FX_DisruptorMainShot
import FX_BryarAltProjectileThink
import FX_BryarProjectileThink
bss
export g2WeaponInstances
align 4
LABELV g2WeaponInstances
skip 64
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
import CG_RegisterWeapon
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
LABELV $1330
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 47
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 115
char 1 47
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 47
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 111
char 1 110
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $1326
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 47
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 115
char 1 47
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 47
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 111
char 1 102
char 1 102
char 1 113
char 1 117
char 1 105
char 1 99
char 1 107
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $1294
char 1 42
char 1 102
char 1 108
char 1 97
char 1 115
char 1 104
char 1 0
align 1
LABELV $994
char 1 100
char 1 101
char 1 109
char 1 112
char 1 50
char 1 47
char 1 97
char 1 108
char 1 116
char 1 68
char 1 101
char 1 116
char 1 111
char 1 110
char 1 97
char 1 116
char 1 101
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $919
char 1 67
char 1 71
char 1 95
char 1 70
char 1 105
char 1 114
char 1 101
char 1 87
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 58
char 1 32
char 1 101
char 1 110
char 1 116
char 1 45
char 1 62
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 62
char 1 61
char 1 32
char 1 87
char 1 80
char 1 95
char 1 78
char 1 85
char 1 77
char 1 95
char 1 87
char 1 69
char 1 65
char 1 80
char 1 79
char 1 78
char 1 83
char 1 0
align 1
LABELV $900
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 47
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 115
char 1 47
char 1 97
char 1 116
char 1 115
char 1 116
char 1 47
char 1 65
char 1 84
char 1 83
char 1 84
char 1 102
char 1 105
char 1 114
char 1 101
char 1 49
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $837
char 1 115
char 1 118
char 1 95
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 115
char 1 119
char 1 105
char 1 116
char 1 99
char 1 104
char 1 0
align 1
LABELV $755
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 95
char 1 37
char 1 115
char 1 0
align 1
LABELV $282
char 1 116
char 1 97
char 1 103
char 1 95
char 1 102
char 1 108
char 1 97
char 1 115
char 1 104
char 1 0
align 1
LABELV $271
char 1 116
char 1 97
char 1 103
char 1 95
char 1 98
char 1 97
char 1 114
char 1 114
char 1 101
char 1 108
char 1 51
char 1 0
align 1
LABELV $270
char 1 116
char 1 97
char 1 103
char 1 95
char 1 98
char 1 97
char 1 114
char 1 114
char 1 101
char 1 108
char 1 50
char 1 0
align 1
LABELV $267
char 1 116
char 1 97
char 1 103
char 1 95
char 1 98
char 1 97
char 1 114
char 1 114
char 1 101
char 1 108
char 1 0
align 1
LABELV $261
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 115
char 1 50
char 1 47
char 1 115
char 1 116
char 1 117
char 1 110
char 1 95
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 47
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 95
char 1 98
char 1 97
char 1 114
char 1 114
char 1 101
char 1 108
char 1 51
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $259
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 115
char 1 50
char 1 47
char 1 115
char 1 116
char 1 117
char 1 110
char 1 95
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 47
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 95
char 1 98
char 1 97
char 1 114
char 1 114
char 1 101
char 1 108
char 1 50
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $255
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 115
char 1 50
char 1 47
char 1 115
char 1 116
char 1 117
char 1 110
char 1 95
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 47
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 95
char 1 98
char 1 97
char 1 114
char 1 114
char 1 101
char 1 108
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $240
char 1 116
char 1 97
char 1 103
char 1 95
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 0
align 1
LABELV $138
char 1 46
char 1 103
char 1 108
char 1 109
char 1 0
align 1
LABELV $125
char 1 67
char 1 71
char 1 95
char 1 82
char 1 101
char 1 103
char 1 105
char 1 115
char 1 116
char 1 101
char 1 114
char 1 73
char 1 116
char 1 101
char 1 109
char 1 86
char 1 105
char 1 115
char 1 117
char 1 97
char 1 108
char 1 115
char 1 58
char 1 32
char 1 105
char 1 116
char 1 101
char 1 109
char 1 78
char 1 117
char 1 109
char 1 32
char 1 37
char 1 100
char 1 32
char 1 111
char 1 117
char 1 116
char 1 32
char 1 111
char 1 102
char 1 32
char 1 114
char 1 97
char 1 110
char 1 103
char 1 101
char 1 32
char 1 91
char 1 48
char 1 45
char 1 37
char 1 100
char 1 93
char 1 0
