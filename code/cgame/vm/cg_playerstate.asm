export CG_CheckAmmo
code
proc CG_CheckAmmo 0 0
file "../cg_playerstate.c"
line 17
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_playerstate.c -- this file acts on changes in a new playerState_t
;4:// With normal play, this will be done after local prediction, but when
;5:// following another player or playing back a demo, it will be checked
;6:// when the snapshot transitions like all the other entities
;7:
;8:#include "cg_local.h"
;9:
;10:/*
;11:==============
;12:CG_CheckAmmo
;13:
;14:If the ammo has gone low enough to generate the warning, play a sound
;15:==============
;16:*/
;17:void CG_CheckAmmo( void ) {
line 76
;18:#if 0
;19:	int		i;
;20:	int		total;
;21:	int		previous;
;22:	int		weapons;
;23:
;24:	// see about how many seconds of ammo we have remaining
;25:	weapons = cg.snap->ps.stats[ STAT_WEAPONS ];
;26:	total = 0;
;27:	for ( i = WP_BRYAR_PISTOL; i < WP_NUM_WEAPONS ; i++ ) {
;28:		if ( ! ( weapons & ( 1 << i ) ) ) {
;29:			continue;
;30:		}
;31:		switch ( i ) 
;32:		{
;33:		case WP_BRYAR_PISTOL:
;34:		case WP_BLASTER:
;35:		case WP_DISRUPTOR:
;36:		case WP_BOWCASTER:
;37:		case WP_REPEATER:
;38:		case WP_DEMP2:
;39:		case WP_FLECHETTE:
;40:		case WP_ROCKET_LAUNCHER:
;41:		case WP_THERMAL:
;42:		case WP_TRIP_MINE:
;43:		case WP_DET_PACK:
;44:		case WP_EMPLACED_GUN:
;45:			total += cg.snap->ps.ammo[weaponData[i].ammoIndex] * 1000;
;46:			break;
;47:		default:
;48:			total += cg.snap->ps.ammo[weaponData[i].ammoIndex] * 200;
;49:			break;
;50:		}
;51:		if ( total >= 5000 ) {
;52:			cg.lowAmmoWarning = 0;
;53:			return;
;54:		}
;55:	}
;56:
;57:	previous = cg.lowAmmoWarning;
;58:
;59:	if ( total == 0 ) {
;60:		cg.lowAmmoWarning = 2;
;61:	} else {
;62:		cg.lowAmmoWarning = 1;
;63:	}
;64:
;65:	if (cg.snap->ps.weapon == WP_SABER)
;66:	{
;67:		cg.lowAmmoWarning = 0;
;68:	}
;69:
;70:	// play a sound on transitions
;71:	if ( cg.lowAmmoWarning != previous ) {
;72:		trap_S_StartLocalSound( cgs.media.noAmmoSound, CHAN_LOCAL_SOUND );
;73:	}
;74:#endif
;75:	//disabled silly ammo warning stuff for now
;76:}
LABELV $120
endproc CG_CheckAmmo 0 0
export CG_DamageFeedback
proc CG_DamageFeedback 72 16
line 83
;77:
;78:/*
;79:==============
;80:CG_DamageFeedback
;81:==============
;82:*/
;83:void CG_DamageFeedback( int yawByte, int pitchByte, int damage ) {
line 94
;84:	float		left, front, up;
;85:	float		kick;
;86:	int			health;
;87:	float		scale;
;88:	vec3_t		dir;
;89:	vec3_t		angles;
;90:	float		dist;
;91:	float		yaw, pitch;
;92:
;93:	// show the attacking player's head and name in corner
;94:	cg.attackerTime = cg.time;
ADDRGP4 cg+13100
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 97
;95:
;96:	// the lower on health you are, the greater the view kick will be
;97:	health = cg.snap->ps.stats[STAT_HEALTH];
ADDRLP4 20
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ASGNI4
line 98
;98:	if ( health < 40 ) {
ADDRLP4 20
INDIRI4
CNSTI4 40
GEI4 $125
line 99
;99:		scale = 1;
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
line 100
;100:	} else {
ADDRGP4 $126
JUMPV
LABELV $125
line 101
;101:		scale = 40.0 / health;
ADDRLP4 28
CNSTF4 1109393408
ADDRLP4 20
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 102
;102:	}
LABELV $126
line 103
;103:	kick = damage * scale;
ADDRLP4 12
ADDRFP4 8
INDIRI4
CVIF4 4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 105
;104:
;105:	if (kick < 5)
ADDRLP4 12
INDIRF4
CNSTF4 1084227584
GEF4 $127
line 106
;106:		kick = 5;
ADDRLP4 12
CNSTF4 1084227584
ASGNF4
LABELV $127
line 107
;107:	if (kick > 10)
ADDRLP4 12
INDIRF4
CNSTF4 1092616192
LEF4 $129
line 108
;108:		kick = 10;
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
LABELV $129
line 111
;109:
;110:	// if yaw and pitch are both 255, make the damage always centered (falling, etc)
;111:	if ( yawByte == 255 && pitchByte == 255 ) {
ADDRLP4 60
CNSTI4 255
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $131
ADDRFP4 4
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $131
line 112
;112:		cg.damageX = 0;
ADDRGP4 cg+13376
CNSTF4 0
ASGNF4
line 113
;113:		cg.damageY = 0;
ADDRGP4 cg+13380
CNSTF4 0
ASGNF4
line 114
;114:		cg.v_dmg_roll = 0;
ADDRGP4 cg+13424
CNSTF4 0
ASGNF4
line 115
;115:		cg.v_dmg_pitch = -kick;
ADDRGP4 cg+13420
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
line 116
;116:	} else {
ADDRGP4 $132
JUMPV
LABELV $131
line 118
;117:		// positional
;118:		pitch = pitchByte / 255.0 * 360;
ADDRLP4 56
CNSTF4 1135869952
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1132396544
DIVF4
MULF4
ASGNF4
line 119
;119:		yaw = yawByte / 255.0 * 360;
ADDRLP4 52
CNSTF4 1135869952
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1132396544
DIVF4
MULF4
ASGNF4
line 121
;120:
;121:		angles[PITCH] = pitch;
ADDRLP4 32
ADDRLP4 56
INDIRF4
ASGNF4
line 122
;122:		angles[YAW] = yaw;
ADDRLP4 32+4
ADDRLP4 52
INDIRF4
ASGNF4
line 123
;123:		angles[ROLL] = 0;
ADDRLP4 32+8
CNSTF4 0
ASGNF4
line 125
;124:
;125:		AngleVectors( angles, dir, NULL, NULL );
ADDRLP4 32
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 64
CNSTP4 0
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 126
;126:		VectorSubtract( vec3_origin, dir, dir );
ADDRLP4 0
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 128
;127:
;128:		front = DotProduct (dir, cg.refdef.viewaxis[0] );
ADDRLP4 16
ADDRLP4 0
INDIRF4
ADDRGP4 cg+3604+36
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+3604+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+3604+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 129
;129:		left = DotProduct (dir, cg.refdef.viewaxis[1] );
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRGP4 cg+3604+36+12
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+3604+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+3604+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 130
;130:		up = DotProduct (dir, cg.refdef.viewaxis[2] );
ADDRLP4 48
ADDRLP4 0
INDIRF4
ADDRGP4 cg+3604+36+24
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+3604+36+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+3604+36+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 132
;131:
;132:		dir[0] = front;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 133
;133:		dir[1] = left;
ADDRLP4 0+4
ADDRLP4 24
INDIRF4
ASGNF4
line 134
;134:		dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 135
;135:		dist = VectorLength( dir );
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 68
INDIRF4
ASGNF4
line 136
;136:		if ( dist < 0.1 ) {
ADDRLP4 44
INDIRF4
CNSTF4 1036831949
GEF4 $183
line 137
;137:			dist = 0.1f;
ADDRLP4 44
CNSTF4 1036831949
ASGNF4
line 138
;138:		}
LABELV $183
line 140
;139:
;140:		cg.v_dmg_roll = kick * left;
ADDRGP4 cg+13424
ADDRLP4 12
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 142
;141:		
;142:		cg.v_dmg_pitch = -kick * front;
ADDRGP4 cg+13420
ADDRLP4 12
INDIRF4
NEGF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 144
;143:
;144:		if ( front <= 0.1 ) {
ADDRLP4 16
INDIRF4
CNSTF4 1036831949
GTF4 $187
line 145
;145:			front = 0.1f;
ADDRLP4 16
CNSTF4 1036831949
ASGNF4
line 146
;146:		}
LABELV $187
line 147
;147:		cg.damageX = -left / front;
ADDRGP4 cg+13376
ADDRLP4 24
INDIRF4
NEGF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
line 148
;148:		cg.damageY = up / dist;
ADDRGP4 cg+13380
ADDRLP4 48
INDIRF4
ADDRLP4 44
INDIRF4
DIVF4
ASGNF4
line 149
;149:	}
LABELV $132
line 152
;150:
;151:	// clamp the position
;152:	if ( cg.damageX > 1.0 ) {
ADDRGP4 cg+13376
INDIRF4
CNSTF4 1065353216
LEF4 $191
line 153
;153:		cg.damageX = 1.0;
ADDRGP4 cg+13376
CNSTF4 1065353216
ASGNF4
line 154
;154:	}
LABELV $191
line 155
;155:	if ( cg.damageX < - 1.0 ) {
ADDRGP4 cg+13376
INDIRF4
CNSTF4 3212836864
GEF4 $195
line 156
;156:		cg.damageX = -1.0;
ADDRGP4 cg+13376
CNSTF4 3212836864
ASGNF4
line 157
;157:	}
LABELV $195
line 159
;158:
;159:	if ( cg.damageY > 1.0 ) {
ADDRGP4 cg+13380
INDIRF4
CNSTF4 1065353216
LEF4 $199
line 160
;160:		cg.damageY = 1.0;
ADDRGP4 cg+13380
CNSTF4 1065353216
ASGNF4
line 161
;161:	}
LABELV $199
line 162
;162:	if ( cg.damageY < - 1.0 ) {
ADDRGP4 cg+13380
INDIRF4
CNSTF4 3212836864
GEF4 $203
line 163
;163:		cg.damageY = -1.0;
ADDRGP4 cg+13380
CNSTF4 3212836864
ASGNF4
line 164
;164:	}
LABELV $203
line 167
;165:
;166:	// don't let the screen flashes vary as much
;167:	if ( kick > 10 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1092616192
LEF4 $207
line 168
;168:		kick = 10;
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
line 169
;169:	}
LABELV $207
line 170
;170:	cg.damageValue = kick;
ADDRGP4 cg+13384
ADDRLP4 12
INDIRF4
ASGNF4
line 171
;171:	cg.v_dmg_time = cg.time + DAMAGE_TIME;
ADDRGP4 cg+13416
ADDRGP4 cg+64
INDIRI4
CNSTI4 500
ADDI4
CVIF4 4
ASGNF4
line 172
;172:	cg.damageTime = cg.snap->serverTime;
ADDRGP4 cg+13372
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 173
;173:}
LABELV $121
endproc CG_DamageFeedback 72 16
export CG_Respawn
proc CG_Respawn 0 0
line 185
;174:
;175:
;176:
;177:
;178:/*
;179:================
;180:CG_Respawn
;181:
;182:A respawn happened this snapshot
;183:================
;184:*/
;185:void CG_Respawn( void ) {
line 187
;186:	// no error decay on player movement
;187:	cg.thisFrameTeleport = qtrue;
ADDRGP4 cg+52
CNSTI4 1
ASGNI4
line 190
;188:
;189:	// display weapons available
;190:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+13360
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 193
;191:
;192:	// select the weapon the server says we are using
;193:	cg.weaponSelect = cg.snap->ps.weapon;
ADDRGP4 cg+3496
ADDRGP4 cg+36
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 194
;194:}
LABELV $214
endproc CG_Respawn 0 0
export CG_CheckPlayerstateEvents
proc CG_CheckPlayerstateEvents 52 8
line 203
;195:
;196:extern char *eventnames[];
;197:
;198:/*
;199:==============
;200:CG_CheckPlayerstateEvents
;201:==============
;202:*/
;203:void CG_CheckPlayerstateEvents( playerState_t *ps, playerState_t *ops ) {
line 208
;204:	int			i;
;205:	int			event;
;206:	centity_t	*cent;
;207:
;208:	if ( ps->externalEvent && ps->externalEvent != ops->externalEvent ) {
ADDRLP4 12
CNSTI4 132
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $221
ADDRLP4 16
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
EQI4 $221
line 209
;209:		cent = &cg_entities[ ps->clientNum ];
ADDRLP4 4
CNSTI4 1920
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 210
;210:		cent->currentState.event = ps->externalEvent;
ADDRLP4 4
INDIRP4
CNSTI4 252
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ASGNI4
line 211
;211:		cent->currentState.eventParm = ps->externalEventParm;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
ASGNI4
line 212
;212:		CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 213
;213:	}
LABELV $221
line 215
;214:
;215:	cent = &cg.predictedPlayerEntity; // cg_entities[ ps->clientNum ];
ADDRLP4 4
ADDRGP4 cg+1464
ASGNP4
line 217
;216:	// go through the predictable events buffer
;217:	for ( i = ps->eventSequence - MAX_PS_EVENTS ; i < ps->eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
ADDRGP4 $227
JUMPV
LABELV $224
line 219
;218:		// if we have a new predictable event
;219:		if ( i >= ops->eventSequence
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 28
INDIRI4
GEI4 $230
ADDRLP4 32
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
LEI4 $228
ADDRLP4 36
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 32
INDIRI4
LSHI4
ASGNI4
ADDRLP4 40
CNSTI4 116
ASGNI4
ADDRLP4 36
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 24
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $228
LABELV $230
line 222
;220:			// or the server told us to play another event instead of a predicted event we already issued
;221:			// or something the server told us changed our prediction causing a different event
;222:			|| (i > ops->eventSequence - MAX_PS_EVENTS && ps->events[i & (MAX_PS_EVENTS-1)] != ops->events[i & (MAX_PS_EVENTS-1)]) ) {
line 224
;223:
;224:			event = ps->events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDP4
INDIRI4
ASGNI4
line 225
;225:			cent->currentState.event = event;
ADDRLP4 4
INDIRP4
CNSTI4 252
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 226
;226:			cent->currentState.eventParm = ps->eventParms[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
ADDP4
INDIRI4
ASGNI4
line 227
;227:			CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 229
;228:
;229:			cg.predictableEvents[ i & (MAX_PREDICTED_EVENTS-1) ] = event;
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cg+3408
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 231
;230:
;231:			cg.eventSequence++;
ADDRLP4 48
ADDRGP4 cg+3404
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 232
;232:		}
LABELV $228
line 233
;233:	}
LABELV $225
line 217
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $227
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
LTI4 $224
line 234
;234:}
LABELV $220
endproc CG_CheckPlayerstateEvents 52 8
export CG_CheckChangedPredictableEvents
proc CG_CheckChangedPredictableEvents 24 8
line 241
;235:
;236:/*
;237:==================
;238:CG_CheckChangedPredictableEvents
;239:==================
;240:*/
;241:void CG_CheckChangedPredictableEvents( playerState_t *ps ) {
line 246
;242:	int i;
;243:	int event;
;244:	centity_t	*cent;
;245:
;246:	cent = &cg.predictedPlayerEntity;
ADDRLP4 4
ADDRGP4 cg+1464
ASGNP4
line 247
;247:	for ( i = ps->eventSequence - MAX_PS_EVENTS ; i < ps->eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
ADDRGP4 $238
JUMPV
LABELV $235
line 249
;248:		//
;249:		if (i >= cg.eventSequence) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+3404
INDIRI4
LTI4 $239
line 250
;250:			continue;
ADDRGP4 $236
JUMPV
LABELV $239
line 253
;251:		}
;252:		// if this event is not further back in than the maximum predictable events we remember
;253:		if (i > cg.eventSequence - MAX_PREDICTED_EVENTS) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+3404
INDIRI4
CNSTI4 16
SUBI4
LEI4 $242
line 255
;254:			// if the new playerstate event is different from a previously predicted one
;255:			if ( ps->events[i & (MAX_PS_EVENTS-1)] != cg.predictableEvents[i & (MAX_PREDICTED_EVENTS-1) ] ) {
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRGP4 cg+3408
ADDP4
INDIRI4
EQI4 $245
line 257
;256:
;257:				event = ps->events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDP4
INDIRI4
ASGNI4
line 258
;258:				cent->currentState.event = event;
ADDRLP4 4
INDIRP4
CNSTI4 252
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 259
;259:				cent->currentState.eventParm = ps->eventParms[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
ADDP4
INDIRI4
ASGNI4
line 260
;260:				CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 262
;261:
;262:				cg.predictableEvents[ i & (MAX_PREDICTED_EVENTS-1) ] = event;
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cg+3408
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 264
;263:
;264:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $249
line 265
;265:					CG_Printf("WARNING: changed predicted event\n");
ADDRGP4 $252
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 266
;266:				}
LABELV $249
line 267
;267:			}
LABELV $245
line 268
;268:		}
LABELV $242
line 269
;269:	}
LABELV $236
line 247
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $238
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
LTI4 $235
line 270
;270:}
LABELV $233
endproc CG_CheckChangedPredictableEvents 24 8
data
export cgAnnouncerTime
align 4
LABELV cgAnnouncerTime
byte 4 0
export CG_CheckLocalSounds
code
proc CG_CheckLocalSounds 44 8
line 295
;271:
;272:/*
;273:==================
;274:pushReward
;275:==================
;276:*/
;277:#ifdef JK2AWARDS
;278:static void pushReward(sfxHandle_t sfx, qhandle_t shader, int rewardCount) {
;279:	if (cg.rewardStack < (MAX_REWARDSTACK-1)) {
;280:		cg.rewardStack++;
;281:		cg.rewardSound[cg.rewardStack] = sfx;
;282:		cg.rewardShader[cg.rewardStack] = shader;
;283:		cg.rewardCount[cg.rewardStack] = rewardCount;
;284:	}
;285:}
;286:#endif
;287:
;288:int cgAnnouncerTime = 0; //to prevent announce sounds from playing on top of each other
;289:
;290:/*
;291:==================
;292:CG_CheckLocalSounds
;293:==================
;294:*/
;295:void CG_CheckLocalSounds( playerState_t *ps, playerState_t *ops ) {
line 302
;296:	int			highScore, health, armor, reward;
;297:#ifdef JK2AWARDS
;298:	sfxHandle_t sfx;
;299:#endif
;300:
;301:	// don't play the sounds if the player just changed teams
;302:	if ( ps->persistant[PERS_TEAM] != ops->persistant[PERS_TEAM] ) {
ADDRLP4 16
CNSTI4 292
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
EQI4 $254
line 303
;303:		return;
ADDRGP4 $253
JUMPV
LABELV $254
line 307
;304:	}
;305:
;306:	// hit changes
;307:	if ( ps->persistant[PERS_HITS] > ops->persistant[PERS_HITS] ) {
ADDRLP4 20
CNSTI4 284
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
LEI4 $256
line 308
;308:		armor  = ps->persistant[PERS_ATTACKEE_ARMOR] & 0xff;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 308
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 309
;309:		health = ps->persistant[PERS_ATTACKEE_ARMOR] >> 8;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 308
ADDP4
INDIRI4
CNSTI4 8
RSHI4
ASGNI4
line 311
;310:
;311:		if (armor > health/2)
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 2
DIVI4
LEI4 $257
line 312
;312:		{	// We also hit shields along the way, so consider them "pierced".
line 314
;313://			trap_S_StartLocalSound( cgs.media.shieldPierceSound, CHAN_LOCAL_SOUND );
;314:		}
line 316
;315:		else
;316:		{	// Shields didn't really stand in our way.
line 318
;317://			trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
;318:		}
line 330
;319:
;320:		//FIXME: Hit sounds?
;321:		/*
;322:		if (armor > 50 ) {
;323:			trap_S_StartLocalSound( cgs.media.hitSoundHighArmor, CHAN_LOCAL_SOUND );
;324:		} else if (armor || health > 100) {
;325:			trap_S_StartLocalSound( cgs.media.hitSoundLowArmor, CHAN_LOCAL_SOUND );
;326:		} else {
;327:			trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
;328:		}
;329:		*/
;330:	} else if ( ps->persistant[PERS_HITS] < ops->persistant[PERS_HITS] ) {
ADDRGP4 $257
JUMPV
LABELV $256
ADDRLP4 24
CNSTI4 284
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
GEI4 $260
line 332
;331:		//trap_S_StartLocalSound( cgs.media.hitTeamSound, CHAN_LOCAL_SOUND );
;332:	}
LABELV $260
LABELV $257
line 335
;333:
;334:	// health changes of more than -3 should make pain sounds
;335:	if ( ps->stats[STAT_HEALTH] < (ops->stats[STAT_HEALTH] - 3)) {
ADDRLP4 28
CNSTI4 216
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
CNSTI4 3
SUBI4
GEI4 $262
line 336
;336:		if ( ps->stats[STAT_HEALTH] > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 0
LEI4 $264
line 337
;337:			CG_PainEvent( &cg.predictedPlayerEntity, ps->stats[STAT_HEALTH] );
ADDRGP4 cg+1464
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 338
;338:		}
LABELV $264
line 339
;339:	}
LABELV $262
line 342
;340:
;341:	// if we are going into the intermission, don't start any voices
;342:	if ( cg.intermissionStarted ) {
ADDRGP4 cg+24
INDIRI4
CNSTI4 0
EQI4 $267
line 343
;343:		return;
ADDRGP4 $253
JUMPV
LABELV $267
line 396
;344:	}
;345:
;346:#ifdef JK2AWARDS
;347:	// reward sounds
;348:	reward = qfalse;
;349:	if (ps->persistant[PERS_CAPTURES] != ops->persistant[PERS_CAPTURES]) {
;350:		pushReward(cgs.media.captureAwardSound, cgs.media.medalCapture, ps->persistant[PERS_CAPTURES]);
;351:		reward = qtrue;
;352:		//Com_Printf("capture\n");
;353:	}
;354:	if (ps->persistant[PERS_IMPRESSIVE_COUNT] != ops->persistant[PERS_IMPRESSIVE_COUNT]) {
;355:		sfx = cgs.media.impressiveSound;
;356:
;357:		pushReward(sfx, cgs.media.medalImpressive, ps->persistant[PERS_IMPRESSIVE_COUNT]);
;358:		reward = qtrue;
;359:		//Com_Printf("impressive\n");
;360:	}
;361:	if (ps->persistant[PERS_EXCELLENT_COUNT] != ops->persistant[PERS_EXCELLENT_COUNT]) {
;362:		sfx = cgs.media.excellentSound;
;363:		pushReward(sfx, cgs.media.medalExcellent, ps->persistant[PERS_EXCELLENT_COUNT]);
;364:		reward = qtrue;
;365:		//Com_Printf("excellent\n");
;366:	}
;367:	if (ps->persistant[PERS_GAUNTLET_FRAG_COUNT] != ops->persistant[PERS_GAUNTLET_FRAG_COUNT]) {
;368:		sfx = cgs.media.humiliationSound;
;369:		pushReward(sfx, cgs.media.medalGauntlet, ps->persistant[PERS_GAUNTLET_FRAG_COUNT]);
;370:		reward = qtrue;
;371:		//Com_Printf("guantlet frag\n");
;372:	}
;373:	if (ps->persistant[PERS_DEFEND_COUNT] != ops->persistant[PERS_DEFEND_COUNT]) {
;374:		pushReward(cgs.media.defendSound, cgs.media.medalDefend, ps->persistant[PERS_DEFEND_COUNT]);
;375:		reward = qtrue;
;376:		//Com_Printf("defend\n");
;377:	}
;378:	if (ps->persistant[PERS_ASSIST_COUNT] != ops->persistant[PERS_ASSIST_COUNT]) {
;379:		//pushReward(cgs.media.assistSound, cgs.media.medalAssist, ps->persistant[PERS_ASSIST_COUNT]);
;380:		//reward = qtrue;
;381:		//Com_Printf("assist\n");
;382:	}
;383:	// if any of the player event bits changed
;384:	if (ps->persistant[PERS_PLAYEREVENTS] != ops->persistant[PERS_PLAYEREVENTS]) {
;385:		if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_DENIEDREWARD) !=
;386:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_DENIEDREWARD)) {
;387:			trap_S_StartLocalSound( cgs.media.deniedSound, CHAN_ANNOUNCER );
;388:		}
;389:		else if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_GAUNTLETREWARD) !=
;390:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_GAUNTLETREWARD)) {
;391:			trap_S_StartLocalSound( cgs.media.humiliationSound, CHAN_ANNOUNCER );
;392:		}
;393:		reward = qtrue;
;394:	}
;395:#else
;396:	reward = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 399
;397:#endif
;398:	// lead changes
;399:	if (!reward && cgAnnouncerTime < cg.time) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $270
ADDRGP4 cgAnnouncerTime
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $270
line 401
;400:		//
;401:		if ( !cg.warmup ) {
ADDRGP4 cg+13340
INDIRI4
CNSTI4 0
NEI4 $273
line 403
;402:			// never play lead changes during warmup
;403:			if ( ps->persistant[PERS_RANK] != ops->persistant[PERS_RANK] ) {
ADDRLP4 32
CNSTI4 288
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $276
line 404
;404:				if ( cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
GEI4 $278
line 405
;405:					if (  ps->persistant[PERS_RANK] == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 0
NEI4 $281
line 406
;406:						CG_AddBufferedSound(cgs.media.takenLeadSound);
ADDRGP4 cgs+70280+752
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 407
;407:						cgAnnouncerTime = cg.time + 3000;
ADDRGP4 cgAnnouncerTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 408
;408:					} else if ( ps->persistant[PERS_RANK] == RANK_TIED_FLAG ) {
ADDRGP4 $282
JUMPV
LABELV $281
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 16384
NEI4 $286
line 410
;409:						//CG_AddBufferedSound(cgs.media.tiedLeadSound);
;410:					} else if ( ( ops->persistant[PERS_RANK] & ~RANK_TIED_FLAG ) == 0 ) {
ADDRGP4 $287
JUMPV
LABELV $286
ADDRFP4 4
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 -16385
BANDI4
CNSTI4 0
NEI4 $288
line 413
;411:						//rww - only bother saying this if you have more than 1 kill already.
;412:						//joining the server and hearing "the force is not with you" is silly.
;413:						if (ps->persistant[PERS_SCORE] > 0)
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
LEI4 $290
line 414
;414:						{
line 415
;415:							CG_AddBufferedSound(cgs.media.lostLeadSound);
ADDRGP4 cgs+70280+760
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 416
;416:							cgAnnouncerTime = cg.time + 3000;
ADDRGP4 cgAnnouncerTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 417
;417:						}
LABELV $290
line 418
;418:					}
LABELV $288
LABELV $287
LABELV $282
line 419
;419:				}
LABELV $278
line 420
;420:			}
LABELV $276
line 421
;421:		}
LABELV $273
line 422
;422:	}
LABELV $270
line 425
;423:
;424:	// timelimit warnings
;425:	if ( cgs.timelimit > 0 && cgAnnouncerTime < cg.time ) {
ADDRGP4 cgs+32984
INDIRI4
CNSTI4 0
LEI4 $295
ADDRGP4 cgAnnouncerTime
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $295
line 428
;426:		int		msec;
;427:
;428:		msec = cg.time - cgs.levelStartTime;
ADDRLP4 32
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgs+36304
INDIRI4
SUBI4
ASGNI4
line 429
;429:		if ( !( cg.timelimitWarnings & 4 ) && msec > ( cgs.timelimit * 60 + 2 ) * 1000 ) {
ADDRGP4 cg+76
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $301
ADDRLP4 32
INDIRI4
CNSTI4 1000
CNSTI4 60
ADDRGP4 cgs+32984
INDIRI4
MULI4
MULI4
CNSTI4 2000
ADDI4
LEI4 $301
line 430
;430:			cg.timelimitWarnings |= 1 | 2 | 4;
ADDRLP4 36
ADDRGP4 cg+76
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 432
;431:			//trap_S_StartLocalSound( cgs.media.suddenDeathSound, CHAN_ANNOUNCER );
;432:		}
ADDRGP4 $302
JUMPV
LABELV $301
line 433
;433:		else if ( !( cg.timelimitWarnings & 2 ) && msec > (cgs.timelimit - 1) * 60 * 1000 ) {
ADDRGP4 cg+76
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $306
ADDRLP4 32
INDIRI4
CNSTI4 1000
CNSTI4 60
ADDRGP4 cgs+32984
INDIRI4
MULI4
MULI4
CNSTI4 60000
SUBI4
LEI4 $306
line 434
;434:			cg.timelimitWarnings |= 1 | 2;
ADDRLP4 36
ADDRGP4 cg+76
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 3
BORI4
ASGNI4
line 435
;435:			trap_S_StartLocalSound( cgs.media.oneMinuteSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+70280+732
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 436
;436:			cgAnnouncerTime = cg.time + 3000;
ADDRGP4 cgAnnouncerTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 437
;437:		}
ADDRGP4 $307
JUMPV
LABELV $306
line 438
;438:		else if ( cgs.timelimit > 5 && !( cg.timelimitWarnings & 1 ) && msec > (cgs.timelimit - 5) * 60 * 1000 ) {
ADDRGP4 cgs+32984
INDIRI4
CNSTI4 5
LEI4 $314
ADDRGP4 cg+76
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $314
ADDRLP4 32
INDIRI4
CNSTI4 1000
CNSTI4 60
ADDRGP4 cgs+32984
INDIRI4
MULI4
MULI4
CNSTI4 300000
SUBI4
LEI4 $314
line 439
;439:			cg.timelimitWarnings |= 1;
ADDRLP4 36
ADDRGP4 cg+76
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 440
;440:			trap_S_StartLocalSound( cgs.media.fiveMinuteSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+70280+736
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 441
;441:			cgAnnouncerTime = cg.time + 3000;
ADDRGP4 cgAnnouncerTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 442
;442:		}
LABELV $314
LABELV $307
LABELV $302
line 443
;443:	}
LABELV $295
line 446
;444:
;445:	// fraglimit warnings
;446:	if ( cgs.fraglimit > 0 && cgs.gametype < GT_CTF && cgs.gametype != GT_TOURNAMENT && cgAnnouncerTime < cg.time) {
ADDRGP4 cgs+32972
INDIRI4
CNSTI4 0
LEI4 $323
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
GEI4 $323
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 3
EQI4 $323
ADDRGP4 cgAnnouncerTime
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $323
line 447
;447:		highScore = cgs.scores1;
ADDRLP4 4
ADDRGP4 cgs+36308
INDIRI4
ASGNI4
line 448
;448:		if ( !( cg.fraglimitWarnings & 4 ) && highScore == (cgs.fraglimit - 1) ) {
ADDRGP4 cg+80
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $330
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+32972
INDIRI4
CNSTI4 1
SUBI4
NEI4 $330
line 449
;449:			cg.fraglimitWarnings |= 1 | 2 | 4;
ADDRLP4 32
ADDRGP4 cg+80
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 450
;450:			CG_AddBufferedSound(cgs.media.oneFragSound);
ADDRGP4 cgs+70280+748
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 451
;451:			cgAnnouncerTime = cg.time + 3000;
ADDRGP4 cgAnnouncerTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 452
;452:		}
ADDRGP4 $331
JUMPV
LABELV $330
line 453
;453:		else if ( cgs.fraglimit > 2 && !( cg.fraglimitWarnings & 2 ) && highScore == (cgs.fraglimit - 2) ) {
ADDRLP4 32
CNSTI4 2
ASGNI4
ADDRGP4 cgs+32972
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $338
ADDRGP4 cg+80
INDIRI4
ADDRLP4 32
INDIRI4
BANDI4
CNSTI4 0
NEI4 $338
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+32972
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
NEI4 $338
line 454
;454:			cg.fraglimitWarnings |= 1 | 2;
ADDRLP4 36
ADDRGP4 cg+80
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 3
BORI4
ASGNI4
line 455
;455:			CG_AddBufferedSound(cgs.media.twoFragSound);
ADDRGP4 cgs+70280+744
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 456
;456:			cgAnnouncerTime = cg.time + 3000;
ADDRGP4 cgAnnouncerTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 457
;457:		}
ADDRGP4 $339
JUMPV
LABELV $338
line 458
;458:		else if ( cgs.fraglimit > 3 && !( cg.fraglimitWarnings & 1 ) && highScore == (cgs.fraglimit - 3) ) {
ADDRLP4 36
CNSTI4 3
ASGNI4
ADDRGP4 cgs+32972
INDIRI4
ADDRLP4 36
INDIRI4
LEI4 $347
ADDRGP4 cg+80
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $347
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+32972
INDIRI4
ADDRLP4 36
INDIRI4
SUBI4
NEI4 $347
line 459
;459:			cg.fraglimitWarnings |= 1;
ADDRLP4 40
ADDRGP4 cg+80
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 460
;460:			CG_AddBufferedSound(cgs.media.threeFragSound);
ADDRGP4 cgs+70280+740
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 461
;461:			cgAnnouncerTime = cg.time + 3000;
ADDRGP4 cgAnnouncerTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 462
;462:		}
LABELV $347
LABELV $339
LABELV $331
line 463
;463:	}
LABELV $323
line 464
;464:}
LABELV $253
endproc CG_CheckLocalSounds 44 8
export CG_TransitionPlayerState
proc CG_TransitionPlayerState 24 12
line 472
;465:
;466:/*
;467:===============
;468:CG_TransitionPlayerState
;469:
;470:===============
;471:*/
;472:void CG_TransitionPlayerState( playerState_t *ps, playerState_t *ops ) {
line 474
;473:	// check for changing follow mode
;474:	if ( ps->clientNum != ops->clientNum ) {
ADDRLP4 0
CNSTI4 144
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
EQI4 $357
line 475
;475:		cg.thisFrameTeleport = qtrue;
ADDRGP4 cg+52
CNSTI4 1
ASGNI4
line 477
;476:		// make sure we don't get any unwanted transition effects
;477:		*ops = *ps;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 1368
line 478
;478:	}
LABELV $357
line 481
;479:
;480:	// damage events (player is getting wounded)
;481:	if ( ps->damageEvent != ops->damageEvent && ps->damageCount ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 172
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
EQI4 $360
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $360
line 482
;482:		CG_DamageFeedback( ps->damageYaw, ps->damagePitch, ps->damageCount );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DamageFeedback
CALLV
pop
line 483
;483:	}
LABELV $360
line 486
;484:
;485:	// respawning
;486:	if ( ps->persistant[PERS_SPAWN_COUNT] != ops->persistant[PERS_SPAWN_COUNT] ) {
ADDRLP4 12
CNSTI4 296
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
EQI4 $362
line 487
;487:		CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 488
;488:	}
LABELV $362
line 490
;489:
;490:	if ( cg.mapRestart ) {
ADDRGP4 cg+84
INDIRI4
CNSTI4 0
EQI4 $364
line 491
;491:		CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 492
;492:		cg.mapRestart = qfalse;
ADDRGP4 cg+84
CNSTI4 0
ASGNI4
line 493
;493:	}
LABELV $364
line 495
;494:
;495:	if ( cg.snap->ps.pm_type != PM_INTERMISSION 
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 6
EQI4 $368
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
CNSTI4 3
EQI4 $368
line 496
;496:		&& ps->persistant[PERS_TEAM] != TEAM_SPECTATOR ) {
line 497
;497:		CG_CheckLocalSounds( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CheckLocalSounds
CALLV
pop
line 498
;498:	}
LABELV $368
line 501
;499:
;500:	// check for going low on ammo
;501:	CG_CheckAmmo();
ADDRGP4 CG_CheckAmmo
CALLV
pop
line 504
;502:
;503:	// run events
;504:	CG_CheckPlayerstateEvents( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CheckPlayerstateEvents
CALLV
pop
line 507
;505:
;506:	// smooth the ducking viewheight change
;507:	if ( ps->viewheight != ops->viewheight ) {
ADDRLP4 16
CNSTI4 168
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
EQI4 $371
line 508
;508:		cg.duckChange = ps->viewheight - ops->viewheight;
ADDRLP4 20
CNSTI4 168
ASGNI4
ADDRGP4 cg+3480
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 509
;509:		cg.duckTime = cg.time;
ADDRGP4 cg+3484
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 510
;510:	}
LABELV $371
line 511
;511:}
LABELV $356
endproc CG_TransitionPlayerState 24 12
import eventnames
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
LABELV $252
char 1 87
char 1 65
char 1 82
char 1 78
char 1 73
char 1 78
char 1 71
char 1 58
char 1 32
char 1 99
char 1 104
char 1 97
char 1 110
char 1 103
char 1 101
char 1 100
char 1 32
char 1 112
char 1 114
char 1 101
char 1 100
char 1 105
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 101
char 1 118
char 1 101
char 1 110
char 1 116
char 1 10
char 1 0
