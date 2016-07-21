export CG_BuildSolidList
code
proc CG_BuildSolidList 28 0
file "../cg_predict.c"
line 26
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_predict.c -- this file generates cg.predictedPlayerState by either
;4:// interpolating between snapshots from the server or locally predicting
;5:// ahead the client's movement.
;6:// It also handles local physics interaction, like fragments bouncing off walls
;7:
;8:#include "cg_local.h"
;9:
;10:static	pmove_t		cg_pmove;
;11:
;12:static	int			cg_numSolidEntities;
;13:static	centity_t	*cg_solidEntities[MAX_ENTITIES_IN_SNAPSHOT];
;14:static	int			cg_numTriggerEntities;
;15:static	centity_t	*cg_triggerEntities[MAX_ENTITIES_IN_SNAPSHOT];
;16:
;17:/*
;18:====================
;19:CG_BuildSolidList
;20:
;21:When a new cg.snap has been set, this function builds a sublist
;22:of the entities that are actually solid, to make for more
;23:efficient collision detection
;24:====================
;25:*/
;26:void CG_BuildSolidList( void ) {
line 32
;27:	int			i;
;28:	centity_t	*cent;
;29:	snapshot_t	*snap;
;30:	entityState_t	*ent;
;31:
;32:	cg_numSolidEntities = 0;
ADDRGP4 cg_numSolidEntities
CNSTI4 0
ASGNI4
line 33
;33:	cg_numTriggerEntities = 0;
ADDRGP4 cg_numTriggerEntities
CNSTI4 0
ASGNI4
line 35
;34:
;35:	if ( cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $121
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 cg+56
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $121
ADDRGP4 cg+52
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $121
line 36
;36:		snap = cg.nextSnap;
ADDRLP4 12
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 37
;37:	} else {
ADDRGP4 $122
JUMPV
LABELV $121
line 38
;38:		snap = cg.snap;
ADDRLP4 12
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 39
;39:	}
LABELV $122
line 41
;40:
;41:	for ( i = 0 ; i < snap->numEntities ; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $131
JUMPV
LABELV $128
line 42
;42:		cent = &cg_entities[ snap->entities[ i ].number ];
ADDRLP4 0
CNSTI4 1920
CNSTI4 296
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 1416
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 43
;43:		ent = &cent->currentState;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 45
;44:
;45:		if ( ent->eType == ET_ITEM || ent->eType == ET_PUSH_TRIGGER || ent->eType == ET_TELEPORT_TRIGGER ) {
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $135
ADDRLP4 20
INDIRI4
CNSTI4 10
EQI4 $135
ADDRLP4 20
INDIRI4
CNSTI4 11
NEI4 $132
LABELV $135
line 46
;46:			cg_triggerEntities[cg_numTriggerEntities] = cent;
ADDRGP4 cg_numTriggerEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 47
;47:			cg_numTriggerEntities++;
ADDRLP4 24
ADDRGP4 cg_numTriggerEntities
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 48
;48:			continue;
ADDRGP4 $129
JUMPV
LABELV $132
line 51
;49:		}
;50:
;51:		if ( cent->nextState.solid ) {
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 0
EQI4 $136
line 52
;52:			cg_solidEntities[cg_numSolidEntities] = cent;
ADDRGP4 cg_numSolidEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 53
;53:			cg_numSolidEntities++;
ADDRLP4 24
ADDRGP4 cg_numSolidEntities
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 54
;54:			continue;
LABELV $136
line 56
;55:		}
;56:	}
LABELV $129
line 41
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $131
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 1412
ADDP4
INDIRI4
LTI4 $128
line 57
;57:}
LABELV $120
endproc CG_BuildSolidList 28 0
proc CG_ClipMoveToEntities 1176 36
line 66
;58:
;59:/*
;60:====================
;61:CG_ClipMoveToEntities
;62:
;63:====================
;64:*/
;65:static void CG_ClipMoveToEntities ( const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end,
;66:							int skipNumber, int mask, trace_t *tr ) {
line 75
;67:	int			i, x, zd, zu;
;68:	trace_t		trace;
;69:	entityState_t	*ent;
;70:	clipHandle_t 	cmodel;
;71:	vec3_t		bmins, bmaxs;
;72:	vec3_t		origin, angles;
;73:	centity_t	*cent;
;74:
;75:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 1088
CNSTI4 0
ASGNI4
ADDRGP4 $142
JUMPV
LABELV $139
line 76
;76:		cent = cg_solidEntities[ i ];
ADDRLP4 1084
ADDRLP4 1088
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 77
;77:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 1084
INDIRP4
ASGNP4
line 79
;78:
;79:		if ( ent->number == skipNumber ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 16
INDIRI4
NEI4 $143
line 80
;80:			continue;
ADDRGP4 $140
JUMPV
LABELV $143
line 83
;81:		}
;82:
;83:		if (ent->number > MAX_CLIENTS && cg.snap && ent->genericenemyindex && (ent->genericenemyindex-1024) == cg.snap->ps.clientNum)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 32
LEI4 $145
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $145
ADDRLP4 1160
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1160
INDIRI4
CNSTI4 0
EQI4 $145
ADDRLP4 1160
INDIRI4
CNSTI4 1024
SUBI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $145
line 84
;84:		{ //rww - method of keeping objects from colliding in client-prediction (in case of ownership)
line 85
;85:			continue;
ADDRGP4 $140
JUMPV
LABELV $145
line 88
;86:		}
;87:
;88:		if ( ent->solid == SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $149
line 90
;89:			// special value for bmodel
;90:			cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ARGI4
ADDRLP4 1164
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 1092
ADDRLP4 1164
INDIRI4
ASGNI4
line 91
;91:			VectorCopy( cent->lerpAngles, angles );
ADDRLP4 1132
ADDRLP4 1084
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 92
;92:			BG_EvaluateTrajectory( &cent->currentState.pos, cg.physicsTime, origin );
ADDRLP4 1084
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+72
INDIRI4
ARGI4
ADDRLP4 1120
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 93
;93:		} else {
ADDRGP4 $150
JUMPV
LABELV $149
line 95
;94:			// encoded bbox
;95:			x = (ent->solid & 255);
ADDRLP4 1144
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 96
;96:			zd = ((ent->solid>>8) & 255);
ADDRLP4 1148
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 97
;97:			zu = ((ent->solid>>16) & 255) - 32;
ADDRLP4 1152
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CNSTI4 32
SUBI4
ASGNI4
line 99
;98:
;99:			bmins[0] = bmins[1] = -x;
ADDRLP4 1164
ADDRLP4 1144
INDIRI4
NEGI4
CVIF4 4
ASGNF4
ADDRLP4 1096+4
ADDRLP4 1164
INDIRF4
ASGNF4
ADDRLP4 1096
ADDRLP4 1164
INDIRF4
ASGNF4
line 100
;100:			bmaxs[0] = bmaxs[1] = x;
ADDRLP4 1168
ADDRLP4 1144
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 1108+4
ADDRLP4 1168
INDIRF4
ASGNF4
ADDRLP4 1108
ADDRLP4 1168
INDIRF4
ASGNF4
line 101
;101:			bmins[2] = -zd;
ADDRLP4 1096+8
ADDRLP4 1148
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 102
;102:			bmaxs[2] = zu;
ADDRLP4 1108+8
ADDRLP4 1152
INDIRI4
CVIF4 4
ASGNF4
line 104
;103:
;104:			cmodel = trap_CM_TempBoxModel( bmins, bmaxs );
ADDRLP4 1096
ARGP4
ADDRLP4 1108
ARGP4
ADDRLP4 1172
ADDRGP4 trap_CM_TempBoxModel
CALLI4
ASGNI4
ADDRLP4 1092
ADDRLP4 1172
INDIRI4
ASGNI4
line 105
;105:			VectorCopy( vec3_origin, angles );
ADDRLP4 1132
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 106
;106:			VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 1120
ADDRLP4 1084
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 107
;107:		}
LABELV $150
line 110
;108:
;109:
;110:		trap_CM_TransformedBoxTrace ( &trace, start, end,
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1092
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 1120
ARGP4
ADDRLP4 1132
ARGP4
ADDRGP4 trap_CM_TransformedBoxTrace
CALLV
pop
line 113
;111:			mins, maxs, cmodel,  mask, origin, angles);
;112:
;113:		if (trace.allsolid || trace.fraction < tr->fraction) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $159
ADDRLP4 4+8
INDIRF4
ADDRFP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GEF4 $156
LABELV $159
line 114
;114:			trace.entityNum = ent->number;
ADDRLP4 4+52
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 115
;115:			*tr = trace;
ADDRFP4 24
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 1080
line 116
;116:		} else if (trace.startsolid) {
ADDRGP4 $157
JUMPV
LABELV $156
ADDRLP4 4+4
INDIRI4
CNSTI4 0
EQI4 $161
line 117
;117:			tr->startsolid = qtrue;
ADDRFP4 24
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 118
;118:		}
LABELV $161
LABELV $157
line 119
;119:		if ( tr->allsolid ) {
ADDRFP4 24
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $164
line 120
;120:			return;
ADDRGP4 $138
JUMPV
LABELV $164
line 122
;121:		}
;122:	}
LABELV $140
line 75
ADDRLP4 1088
ADDRLP4 1088
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $142
ADDRLP4 1088
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $139
line 123
;123:}
LABELV $138
endproc CG_ClipMoveToEntities 1176 36
export CG_Trace
proc CG_Trace 1084 28
line 131
;124:
;125:/*
;126:================
;127:CG_Trace
;128:================
;129:*/
;130:void	CG_Trace( trace_t *result, const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end, 
;131:					 int skipNumber, int mask ) {
line 134
;132:	trace_t	t;
;133:
;134:	trap_CM_BoxTrace ( &t, start, end, mins, maxs, 0, mask);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 135
;135:	t.entityNum = t.fraction != 1.0 ? ENTITYNUM_WORLD : ENTITYNUM_NONE;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $170
ADDRLP4 1080
CNSTI4 1022
ASGNI4
ADDRGP4 $171
JUMPV
LABELV $170
ADDRLP4 1080
CNSTI4 1023
ASGNI4
LABELV $171
ADDRLP4 0+52
ADDRLP4 1080
INDIRI4
ASGNI4
line 137
;136:	// check all other solid models
;137:	CG_ClipMoveToEntities (start, mins, maxs, end, skipNumber, mask, &t);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ClipMoveToEntities
CALLV
pop
line 139
;138:
;139:	*result = t;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 1080
line 140
;140:}
LABELV $166
endproc CG_Trace 1084 28
export CG_PointContents
proc CG_PointContents 36 16
line 147
;141:
;142:/*
;143:================
;144:CG_PointContents
;145:================
;146:*/
;147:int		CG_PointContents( const vec3_t point, int passEntityNum ) {
line 154
;148:	int			i;
;149:	entityState_t	*ent;
;150:	centity_t	*cent;
;151:	clipHandle_t cmodel;
;152:	int			contents;
;153:
;154:	contents = trap_CM_PointContents (point, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 156
;155:
;156:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $176
JUMPV
LABELV $173
line 157
;157:		cent = cg_solidEntities[ i ];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 159
;158:
;159:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 161
;160:
;161:		if ( ent->number == passEntityNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $177
line 162
;162:			continue;
ADDRGP4 $174
JUMPV
LABELV $177
line 165
;163:		}
;164:
;165:		if (ent->solid != SOLID_BMODEL) { // special value for bmodel
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $179
line 166
;166:			continue;
ADDRGP4 $174
JUMPV
LABELV $179
line 169
;167:		}
;168:
;169:		cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 170
;170:		if ( !cmodel ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $181
line 171
;171:			continue;
ADDRGP4 $174
JUMPV
LABELV $181
line 174
;172:		}
;173:
;174:		contents |= trap_CM_TransformedPointContents( point, cmodel, ent->origin, ent->angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_CM_TransformedPointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
BORI4
ASGNI4
line 175
;175:	}
LABELV $174
line 156
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $176
ADDRLP4 4
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $173
line 177
;176:
;177:	return contents;
ADDRLP4 16
INDIRI4
RETI4
LABELV $172
endproc CG_PointContents 36 16
proc CG_InterpolatePlayerState 64 12
line 189
;178:}
;179:
;180:
;181:/*
;182:========================
;183:CG_InterpolatePlayerState
;184:
;185:Generates cg.predictedPlayerState by interpolating between
;186:cg.snap->player_state and cg.nextFrame->player_state
;187:========================
;188:*/
;189:static void CG_InterpolatePlayerState( qboolean grabAngles ) {
line 195
;190:	float			f;
;191:	int				i;
;192:	playerState_t	*out;
;193:	snapshot_t		*prev, *next;
;194:
;195:	out = &cg.predictedPlayerState;
ADDRLP4 12
ADDRGP4 cg+96
ASGNP4
line 196
;196:	prev = cg.snap;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 197
;197:	next = cg.nextSnap;
ADDRLP4 8
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 199
;198:
;199:	*out = cg.snap->ps;
ADDRLP4 12
INDIRP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 1368
line 202
;200:
;201:	// if we are still allowing local input, short circuit the view angles
;202:	if ( grabAngles ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $188
line 206
;203:		usercmd_t	cmd;
;204:		int			cmdNum;
;205:
;206:		cmdNum = trap_GetCurrentCmdNumber();
ADDRLP4 52
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 52
INDIRI4
ASGNI4
line 207
;207:		trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 209
;208:
;209:		PM_UpdateViewAngles( out, &cmd );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 210
;210:	}
LABELV $188
line 213
;211:
;212:	// if the next frame is a teleport, we can't lerp to it
;213:	if ( cg.nextFrameTeleport ) {
ADDRGP4 cg+56
INDIRI4
CNSTI4 0
EQI4 $190
line 214
;214:		return;
ADDRGP4 $183
JUMPV
LABELV $190
line 217
;215:	}
;216:
;217:	if ( !next || next->serverTime <= prev->serverTime ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $195
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
GTI4 $193
LABELV $195
line 218
;218:		return;
ADDRGP4 $183
JUMPV
LABELV $193
line 221
;219:	}
;220:
;221:	f = (float)( cg.time - prev->serverTime ) / ( next->serverTime - prev->serverTime );
ADDRLP4 28
CNSTI4 8
ASGNI4
ADDRLP4 32
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
ADDRGP4 cg+64
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 223
;222:
;223:	i = next->ps.bobCycle;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
line 224
;224:	if ( i < prev->ps.bobCycle ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
GEI4 $197
line 225
;225:		i += 256;		// handle wraparound
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
ADDI4
ASGNI4
line 226
;226:	}
LABELV $197
line 227
;227:	out->bobCycle = prev->ps.bobCycle + f * ( i - prev->ps.bobCycle );
ADDRLP4 36
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 229
;228:
;229:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $199
line 230
;230:		out->origin[i] = prev->ps.origin[i] + f * (next->ps.origin[i] - prev->ps.origin[i] );
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 44
CNSTI4 64
ASGNI4
ADDRLP4 48
ADDRLP4 40
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ADDRLP4 48
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 40
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDP4
INDIRF4
ADDRLP4 48
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 231
;231:		if ( !grabAngles ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $203
line 232
;232:			out->viewangles[i] = LerpAngle( 
ADDRLP4 52
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
CNSTI4 200
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRLP4 52
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 156
ADDP4
ADDP4
ADDRLP4 60
INDIRF4
ASGNF4
line 234
;233:				prev->ps.viewangles[i], next->ps.viewangles[i], f );
;234:		}
LABELV $203
line 235
;235:		out->velocity[i] = prev->ps.velocity[i] + 
ADDRLP4 52
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
CNSTI4 76
ASGNI4
ADDRLP4 60
ADDRLP4 52
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 60
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 52
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 237
;236:			f * (next->ps.velocity[i] - prev->ps.velocity[i] );
;237:	}
LABELV $200
line 229
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $199
line 239
;238:
;239:}
LABELV $183
endproc CG_InterpolatePlayerState 64 12
proc CG_TouchItem 28 12
line 246
;240:
;241:/*
;242:===================
;243:CG_TouchItem
;244:===================
;245:*/
;246:static void CG_TouchItem( centity_t *cent ) {
line 249
;247:	gitem_t		*item;
;248:
;249:	if ( !cg_predictItems.integer ) {
ADDRGP4 cg_predictItems+12
INDIRI4
CNSTI4 0
NEI4 $206
line 250
;250:		return;
ADDRGP4 $205
JUMPV
LABELV $206
line 252
;251:	}
;252:	if ( !BG_PlayerTouchesItem( &cg.predictedPlayerState, &cent->currentState, cg.time ) ) {
ADDRGP4 cg+96
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $209
line 253
;253:		return;
ADDRGP4 $205
JUMPV
LABELV $209
line 256
;254:	}
;255:
;256:	if (cent->currentState.eFlags & EF_ITEMPLACEHOLDER)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4194304
BANDI4
CNSTI4 0
EQI4 $213
line 257
;257:	{
line 258
;258:		return;
ADDRGP4 $205
JUMPV
LABELV $213
line 261
;259:	}
;260:
;261:	if (cent->currentState.eFlags & EF_NODRAW)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $215
line 262
;262:	{
line 263
;263:		return;
ADDRGP4 $205
JUMPV
LABELV $215
line 267
;264:	}
;265:
;266:	// never pick an item up twice in a prediction
;267:	if ( cent->miscTime == cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
NEI4 $217
line 268
;268:		return;
ADDRGP4 $205
JUMPV
LABELV $217
line 271
;269:	}
;270:
;271:	if ( !BG_CanItemBeGrabbed( cgs.gametype, &cent->currentState, &cg.predictedPlayerState ) ) {
ADDRGP4 cgs+32960
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+96
ARGP4
ADDRLP4 8
ADDRGP4 BG_CanItemBeGrabbed
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $220
line 272
;272:		return;		// can't hold it
ADDRGP4 $205
JUMPV
LABELV $220
line 275
;273:	}
;274:
;275:	item = &bg_itemlist[ cent->currentState.modelindex ];
ADDRLP4 0
CNSTI4 52
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 312
;276:
;277:	//Currently there is no reliable way of knowing if the client has touched a certain item before another if they are next to each other, or rather
;278:	//if the server has touched them in the same order. This results often in grabbing an item in the prediction and the server giving you the other
;279:	//item. So for now prediction of armor, health, and ammo is disabled.
;280:/*
;281:	if (item->giType == IT_ARMOR)
;282:	{ //rww - this will be stomped next update, but it's set so that we don't try to pick up two shields in one prediction and have the server cancel one
;283:	//	cg.predictedPlayerState.stats[STAT_ARMOR] += item->quantity;
;284:
;285:		//FIXME: This can't be predicted properly at the moment
;286:		return;
;287:	}
;288:
;289:	if (item->giType == IT_HEALTH)
;290:	{ //same as above, for health
;291:	//	cg.predictedPlayerState.stats[STAT_HEALTH] += item->quantity;
;292:
;293:		//FIXME: This can't be predicted properly at the moment
;294:		return;
;295:	}
;296:
;297:	if (item->giType == IT_AMMO)
;298:	{ //same as above, for ammo
;299:	//	cg.predictedPlayerState.ammo[item->giTag] += item->quantity;
;300:
;301:		//FIXME: This can't be predicted properly at the moment
;302:		return;
;303:	}
;304:
;305:	if (item->giType == IT_HOLDABLE)
;306:	{ //same as above, for holdables
;307:	//	cg.predictedPlayerState.stats[STAT_HOLDABLE_ITEMS] |= (1 << item->giTag);
;308:	}
;309:*/
;310:	// Special case for flags.  
;311:	// We don't predict touching our own flag
;312:	if( cgs.gametype == GT_CTF || cgs.gametype == GT_CTY ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
EQI4 $228
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $224
LABELV $228
line 313
;313:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_RED &&
ADDRGP4 cg+96+280+12
INDIRI4
CNSTI4 1
NEI4 $229
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 4
NEI4 $229
line 315
;314:			item->giTag == PW_REDFLAG)
;315:			return;
ADDRGP4 $205
JUMPV
LABELV $229
line 316
;316:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_BLUE &&
ADDRGP4 cg+96+280+12
INDIRI4
CNSTI4 2
NEI4 $234
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 5
NEI4 $234
line 318
;317:			item->giTag == PW_BLUEFLAG)
;318:			return;
ADDRGP4 $205
JUMPV
LABELV $234
line 319
;319:	}
LABELV $224
line 321
;320:
;321:	if (item->giType == IT_POWERUP &&
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $239
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 12
EQI4 $241
ADDRLP4 16
INDIRI4
CNSTI4 13
NEI4 $239
LABELV $241
line 323
;322:		(item->giTag == PW_FORCE_ENLIGHTENED_LIGHT || item->giTag == PW_FORCE_ENLIGHTENED_DARK))
;323:	{
line 324
;324:		if (item->giTag == PW_FORCE_ENLIGHTENED_LIGHT)
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $242
line 325
;325:		{
line 326
;326:			if (cg.predictedPlayerState.fd.forceSide != FORCE_LIGHTSIDE)
ADDRGP4 cg+96+760+416
INDIRI4
CNSTI4 1
EQI4 $243
line 327
;327:			{
line 328
;328:				return;
ADDRGP4 $205
JUMPV
line 330
;329:			}
;330:		}
LABELV $242
line 332
;331:		else
;332:		{
line 333
;333:			if (cg.predictedPlayerState.fd.forceSide != FORCE_DARKSIDE)
ADDRGP4 cg+96+760+416
INDIRI4
CNSTI4 2
EQI4 $249
line 334
;334:			{
line 335
;335:				return;
ADDRGP4 $205
JUMPV
LABELV $249
line 337
;336:			}
;337:		}
LABELV $243
line 338
;338:	}
LABELV $239
line 342
;339:
;340:
;341:	// grab it
;342:	BG_AddPredictableEventToPlayerstate( EV_ITEM_PICKUP, cent->currentState.number , &cg.predictedPlayerState);
CNSTI4 20
ARGI4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 cg+96
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 345
;343:
;344:	// remove it from the frame so it won't be drawn
;345:	cent->currentState.eFlags |= EF_NODRAW;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 348
;346:
;347:	// don't touch it again this prediction
;348:	cent->miscTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 351
;349:
;350:	// if its a weapon, give them some predicted ammo so the autoswitch will work
;351:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $256
line 352
;352:		cg.predictedPlayerState.stats[ STAT_WEAPONS ] |= 1 << item->giTag;
ADDRLP4 24
ADDRGP4 cg+96+216+16
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 353
;353:		if ( !cg.predictedPlayerState.ammo[ item->giTag ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+96+408
ADDP4
INDIRI4
CNSTI4 0
NEI4 $261
line 354
;354:			cg.predictedPlayerState.ammo[ item->giTag ] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+96+408
ADDP4
CNSTI4 1
ASGNI4
line 355
;355:		}
LABELV $261
line 356
;356:	}
LABELV $256
line 357
;357:}
LABELV $205
endproc CG_TouchItem 28 12
proc CG_TouchTriggerPrediction 1112 28
line 367
;358:
;359:
;360:/*
;361:=========================
;362:CG_TouchTriggerPrediction
;363:
;364:Predict push triggers and items
;365:=========================
;366:*/
;367:static void CG_TouchTriggerPrediction( void ) {
line 376
;368:	int			i;
;369:	trace_t		trace;
;370:	entityState_t	*ent;
;371:	clipHandle_t cmodel;
;372:	centity_t	*cent;
;373:	qboolean	spectator;
;374:
;375:	// dead clients don't activate triggers
;376:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+96+216
INDIRI4
CNSTI4 0
GTI4 $268
line 377
;377:		return;
ADDRGP4 $267
JUMPV
LABELV $268
line 380
;378:	}
;379:
;380:	spectator = ( cg.predictedPlayerState.pm_type == PM_SPECTATOR );
ADDRGP4 cg+96+4
INDIRI4
CNSTI4 3
NEI4 $275
ADDRLP4 1100
CNSTI4 1
ASGNI4
ADDRGP4 $276
JUMPV
LABELV $275
ADDRLP4 1100
CNSTI4 0
ASGNI4
LABELV $276
ADDRLP4 1096
ADDRLP4 1100
INDIRI4
ASGNI4
line 382
;381:
;382:	if ( cg.predictedPlayerState.pm_type != PM_NORMAL && cg.predictedPlayerState.pm_type != PM_FLOAT && !spectator ) {
ADDRLP4 1104
CNSTI4 0
ASGNI4
ADDRGP4 cg+96+4
INDIRI4
ADDRLP4 1104
INDIRI4
EQI4 $277
ADDRGP4 cg+96+4
INDIRI4
CNSTI4 1
EQI4 $277
ADDRLP4 1096
INDIRI4
ADDRLP4 1104
INDIRI4
NEI4 $277
line 383
;383:		return;
ADDRGP4 $267
JUMPV
LABELV $277
line 386
;384:	}
;385:
;386:	for ( i = 0 ; i < cg_numTriggerEntities ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $286
JUMPV
LABELV $283
line 387
;387:		cent = cg_triggerEntities[ i ];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
INDIRP4
ASGNP4
line 388
;388:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 390
;389:
;390:		if ( ent->eType == ET_ITEM && !spectator ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $287
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $287
line 391
;391:			CG_TouchItem( cent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_TouchItem
CALLV
pop
line 392
;392:			continue;
ADDRGP4 $284
JUMPV
LABELV $287
line 395
;393:		}
;394:
;395:		if ( ent->solid != SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $289
line 396
;396:			continue;
ADDRGP4 $284
JUMPV
LABELV $289
line 399
;397:		}
;398:
;399:		cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ARGI4
ADDRLP4 1108
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1108
INDIRI4
ASGNI4
line 400
;400:		if ( !cmodel ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $291
line 401
;401:			continue;
ADDRGP4 $284
JUMPV
LABELV $291
line 404
;402:		}
;403:
;404:		trap_CM_BoxTrace( &trace, cg.predictedPlayerState.origin, cg.predictedPlayerState.origin, 
ADDRLP4 16
ARGP4
ADDRGP4 cg+96+20
ARGP4
ADDRGP4 cg+96+20
ARGP4
ADDRGP4 cg_pmove+188
ARGP4
ADDRGP4 cg_pmove+200
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 407
;405:			cg_pmove.mins, cg_pmove.maxs, cmodel, -1 );
;406:
;407:		if ( !trace.startsolid ) {
ADDRLP4 16+4
INDIRI4
CNSTI4 0
NEI4 $299
line 408
;408:			continue;
ADDRGP4 $284
JUMPV
LABELV $299
line 411
;409:		}
;410:
;411:		if ( ent->eType == ET_TELEPORT_TRIGGER ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 11
NEI4 $302
line 412
;412:			cg.hyperspace = qtrue;
ADDRGP4 cg+92
CNSTI4 1
ASGNI4
line 413
;413:		} else if ( ent->eType == ET_PUSH_TRIGGER ) {
ADDRGP4 $303
JUMPV
LABELV $302
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 10
NEI4 $305
line 414
;414:			BG_TouchJumpPad( &cg.predictedPlayerState, ent );
ADDRGP4 cg+96
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BG_TouchJumpPad
CALLV
pop
line 415
;415:		}
LABELV $305
LABELV $303
line 416
;416:	}
LABELV $284
line 386
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $286
ADDRLP4 4
INDIRI4
ADDRGP4 cg_numTriggerEntities
INDIRI4
LTI4 $283
line 419
;417:
;418:	// if we didn't touch a jump pad this pmove frame
;419:	if ( cg.predictedPlayerState.jumppad_frame != cg.predictedPlayerState.pmove_framecount ) {
ADDRGP4 cg+96+492
INDIRI4
ADDRGP4 cg+96+488
INDIRI4
EQI4 $308
line 420
;420:		cg.predictedPlayerState.jumppad_frame = 0;
ADDRGP4 cg+96+492
CNSTI4 0
ASGNI4
line 421
;421:		cg.predictedPlayerState.jumppad_ent = 0;
ADDRGP4 cg+96+480
CNSTI4 0
ASGNI4
line 422
;422:	}
LABELV $308
line 423
;423:}
LABELV $267
endproc CG_TouchTriggerPrediction 1112 28
export CG_EntityStateToPlayerState
proc CG_EntityStateToPlayerState 4 0
line 425
;424:
;425:void CG_EntityStateToPlayerState( entityState_t *s, playerState_t *ps ) {
line 428
;426:	int		i;
;427:
;428:	ps->clientNum = s->number;
ADDRFP4 4
INDIRP4
CNSTI4 144
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 430
;429:
;430:	VectorCopy( s->pos.trBase, ps->origin );
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 432
;431:
;432:	VectorCopy( s->pos.trDelta, ps->velocity );
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 434
;433:
;434:	VectorCopy( s->apos.trBase, ps->viewangles );
ADDRFP4 4
INDIRP4
CNSTI4 156
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 436
;435:
;436:	ps->fd.forceMindtrickTargetIndex = s->trickedentindex;
ADDRFP4 4
INDIRP4
CNSTI4 1144
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 437
;437:	ps->fd.forceMindtrickTargetIndex2 = s->trickedentindex2;
ADDRFP4 4
INDIRP4
CNSTI4 1148
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ASGNI4
line 438
;438:	ps->fd.forceMindtrickTargetIndex3 = s->trickedentindex3;
ADDRFP4 4
INDIRP4
CNSTI4 1152
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
ASGNI4
line 439
;439:	ps->fd.forceMindtrickTargetIndex4 = s->trickedentindex4;
ADDRFP4 4
INDIRP4
CNSTI4 1156
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 441
;440:
;441:	ps->saberLockFrame = s->forceFrame;
ADDRFP4 4
INDIRP4
CNSTI4 532
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ASGNI4
line 443
;442:
;443:	ps->electrifyTime = s->emplacedOwner;
ADDRFP4 4
INDIRP4
CNSTI4 728
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 445
;444:
;445:	ps->speed = s->speed;
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 447
;446:
;447:	ps->genericEnemyIndex = s->genericenemyindex;
ADDRFP4 4
INDIRP4
CNSTI4 612
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 449
;448:
;449:	ps->activeForcePass = s->activeForcePass;
ADDRFP4 4
INDIRP4
CNSTI4 624
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
line 451
;450:
;451:	ps->movementDir = s->angles2[YAW];
ADDRFP4 4
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 452
;452:	ps->legsAnim = s->legsAnim;
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ASGNI4
line 453
;453:	ps->torsoAnim = s->torsoAnim;
ADDRFP4 4
INDIRP4
CNSTI4 100
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ASGNI4
line 454
;454:	ps->clientNum = s->clientNum;
ADDRFP4 4
INDIRP4
CNSTI4 144
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ASGNI4
line 456
;455:
;456:	ps->eFlags = s->eFlags;
ADDRFP4 4
INDIRP4
CNSTI4 108
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 458
;457:
;458:	ps->saberInFlight = s->saberInFlight;
ADDRFP4 4
INDIRP4
CNSTI4 504
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ASGNI4
line 459
;459:	ps->saberEntityNum = s->saberEntityNum;
ADDRFP4 4
INDIRP4
CNSTI4 544
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 460
;460:	ps->saberMove = s->saberMove;
ADDRFP4 4
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
line 461
;461:	ps->fd.forcePowersActive = s->forcePowersActive;
ADDRFP4 4
INDIRP4
CNSTI4 836
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
ASGNI4
line 463
;462:
;463:	if (s->bolt1)
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 0
EQI4 $319
line 464
;464:	{
line 465
;465:		ps->duelInProgress = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1292
ADDP4
CNSTI4 1
ASGNI4
line 466
;466:	}
ADDRGP4 $320
JUMPV
LABELV $319
line 468
;467:	else
;468:	{
line 469
;469:		ps->duelInProgress = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 1292
ADDP4
CNSTI4 0
ASGNI4
line 470
;470:	}
LABELV $320
line 472
;471:
;472:	if (s->bolt2)
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $321
line 473
;473:	{
line 474
;474:		ps->dualBlade = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1352
ADDP4
CNSTI4 1
ASGNI4
line 475
;475:	}
ADDRGP4 $322
JUMPV
LABELV $321
line 477
;476:	else
;477:	{
line 478
;478:		ps->dualBlade = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 1352
ADDP4
CNSTI4 0
ASGNI4
line 479
;479:	}
LABELV $322
line 481
;480:
;481:	ps->emplacedIndex = s->otherEntityNum2;
ADDRFP4 4
INDIRP4
CNSTI4 596
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 483
;482:
;483:	ps->saberHolstered = s->shouldtarget; //reuse bool in entitystate for players differently
ADDRFP4 4
INDIRP4
CNSTI4 1300
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 484
;484:	ps->usingATST = s->teamowner;
ADDRFP4 4
INDIRP4
CNSTI4 1304
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
line 492
;485:
;486:	/*
;487:	if (ps->genericEnemyIndex != -1)
;488:	{
;489:		s->eFlags |= EF_SEEKERDRONE;
;490:	}
;491:	*/
;492:	ps->genericEnemyIndex = -1; //no real option for this
ADDRFP4 4
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 -1
ASGNI4
line 495
;493:
;494:	//The client has no knowledge of health levels (except for the client entity)
;495:	if (s->eFlags & EF_DEAD)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $323
line 496
;496:	{
line 497
;497:		ps->stats[STAT_HEALTH] = 0;
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
CNSTI4 0
ASGNI4
line 498
;498:	}
ADDRGP4 $324
JUMPV
LABELV $323
line 500
;499:	else
;500:	{
line 501
;501:		ps->stats[STAT_HEALTH] = 100;
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
CNSTI4 100
ASGNI4
line 502
;502:	}
LABELV $324
line 522
;503:
;504:	/*
;505:	if ( ps->externalEvent ) {
;506:		s->event = ps->externalEvent;
;507:		s->eventParm = ps->externalEventParm;
;508:	} else if ( ps->entityEventSequence < ps->eventSequence ) {
;509:		int		seq;
;510:
;511:		if ( ps->entityEventSequence < ps->eventSequence - MAX_PS_EVENTS) {
;512:			ps->entityEventSequence = ps->eventSequence - MAX_PS_EVENTS;
;513:		}
;514:		seq = ps->entityEventSequence & (MAX_PS_EVENTS-1);
;515:		s->event = ps->events[ seq ] | ( ( ps->entityEventSequence & 3 ) << 8 );
;516:		s->eventParm = ps->eventParms[ seq ];
;517:		ps->entityEventSequence++;
;518:	}
;519:	*/
;520:	//Eh.
;521:
;522:	ps->weapon = s->weapon;
ADDRFP4 4
INDIRP4
CNSTI4 148
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
line 523
;523:	ps->groundEntityNum = s->groundEntityNum;
ADDRFP4 4
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 525
;524:
;525:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $325
line 526
;526:		if (s->powerups & (1 << i))
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $329
line 527
;527:		{
line 528
;528:			ps->powerups[i] = 30;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 344
ADDP4
ADDP4
CNSTI4 30
ASGNI4
line 529
;529:		}
ADDRGP4 $330
JUMPV
LABELV $329
line 531
;530:		else
;531:		{
line 532
;532:			ps->powerups[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 344
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 533
;533:		}
LABELV $330
line 534
;534:	}
LABELV $326
line 525
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $325
line 536
;535:
;536:	ps->loopSound = s->loopSound;
ADDRFP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 537
;537:	ps->generic1 = s->generic1;
ADDRFP4 4
INDIRP4
CNSTI4 472
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ASGNI4
line 538
;538:}
LABELV $318
endproc CG_EntityStateToPlayerState 4 0
export CG_PredictPlayerState
proc CG_PredictPlayerState 1508 20
line 568
;539:
;540:playerState_t cgSendPS[MAX_CLIENTS];
;541:
;542:/*
;543:=================
;544:CG_PredictPlayerState
;545:
;546:Generates cg.predictedPlayerState for the current cg.time
;547:cg.predictedPlayerState is guaranteed to be valid after exiting.
;548:
;549:For demo playback, this will be an interpolation between two valid
;550:playerState_t.
;551:
;552:For normal gameplay, it will be the result of predicted usercmd_t on
;553:top of the most recent playerState_t received from the server.
;554:
;555:Each new snapshot will usually have one or more new usercmd over the last,
;556:but we simulate all unacknowledged commands each time, not just the new ones.
;557:This means that on an internet connection, quite a few pmoves may be issued
;558:each frame.
;559:
;560:OPTIMIZE: don't re-simulate unless the newly arrived snapshot playerState_t
;561:differs from the predicted one.  Would require saving all intermediate
;562:playerState_t during prediction.
;563:
;564:We detect prediction errors and allow them to be decayed off over several frames
;565:to ease the jerk.
;566:=================
;567:*/
;568:void CG_PredictPlayerState( void ) {
line 575
;569:	int			cmdNum, current, i;
;570:	playerState_t	oldPlayerState;
;571:	qboolean	moved;
;572:	usercmd_t	oldestCmd;
;573:	usercmd_t	latestCmd;
;574:
;575:	cg.hyperspace = qfalse;	// will be set if touching a trigger_teleport
ADDRGP4 cg+92
CNSTI4 0
ASGNI4
line 580
;576:
;577:	// if this is the first frame we must guarantee
;578:	// predictedPlayerState is valid even if there is some
;579:	// other error condition
;580:	if ( !cg.validPPS ) {
ADDRGP4 cg+3384
INDIRI4
CNSTI4 0
NEI4 $333
line 581
;581:		cg.validPPS = qtrue;
ADDRGP4 cg+3384
CNSTI4 1
ASGNI4
line 582
;582:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+96
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 1368
line 583
;583:	}
LABELV $333
line 586
;584:
;585:	// demo playback just copies the moves
;586:	if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRLP4 1440
CNSTI4 0
ASGNI4
ADDRGP4 cg+8
INDIRI4
ADDRLP4 1440
INDIRI4
NEI4 $343
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 1440
INDIRI4
EQI4 $339
LABELV $343
line 587
;587:		CG_InterpolatePlayerState( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 588
;588:		return;
ADDRGP4 $331
JUMPV
LABELV $339
line 592
;589:	}
;590:
;591:	// non-predicting local movement will grab the latest angles
;592:	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
ADDRLP4 1444
CNSTI4 0
ASGNI4
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 1444
INDIRI4
NEI4 $348
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 1444
INDIRI4
EQI4 $344
LABELV $348
line 593
;593:		CG_InterpolatePlayerState( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 594
;594:		return;
ADDRGP4 $331
JUMPV
LABELV $344
line 598
;595:	}
;596:
;597:	// prepare for pmove
;598:	cg_pmove.ps = &cg.predictedPlayerState;
ADDRGP4 cg_pmove
ADDRGP4 cg+96
ASGNP4
line 599
;599:	cg_pmove.trace = CG_Trace;
ADDRGP4 cg_pmove+240
ADDRGP4 CG_Trace
ASGNP4
line 600
;600:	cg_pmove.pointcontents = CG_PointContents;
ADDRGP4 cg_pmove+244
ADDRGP4 CG_PointContents
ASGNP4
line 601
;601:	if ( cg_pmove.ps->pm_type == PM_DEAD ) {
ADDRLP4 1448
CNSTI4 4
ASGNI4
ADDRGP4 cg_pmove
INDIRP4
ADDRLP4 1448
INDIRI4
ADDP4
INDIRI4
ADDRLP4 1448
INDIRI4
NEI4 $352
line 602
;602:		cg_pmove.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRGP4 cg_pmove+32
CNSTI4 17
ASGNI4
line 603
;603:	}
ADDRGP4 $353
JUMPV
LABELV $352
line 604
;604:	else {
line 605
;605:		cg_pmove.tracemask = MASK_PLAYERSOLID;
ADDRGP4 cg_pmove+32
CNSTI4 273
ASGNI4
line 606
;606:	}
LABELV $353
line 607
;607:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 3
NEI4 $356
line 608
;608:		cg_pmove.tracemask &= ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 1452
ADDRGP4 cg_pmove+32
ASGNP4
ADDRLP4 1452
INDIRP4
ADDRLP4 1452
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 609
;609:	}
LABELV $356
line 610
;610:	cg_pmove.noFootsteps = ( cgs.dmflags & DF_NO_FOOTSTEPS ) > 0;
ADDRGP4 cgs+32964
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
LEI4 $363
ADDRLP4 1452
CNSTI4 1
ASGNI4
ADDRGP4 $364
JUMPV
LABELV $363
ADDRLP4 1452
CNSTI4 0
ASGNI4
LABELV $364
ADDRGP4 cg_pmove+40
ADDRLP4 1452
INDIRI4
ASGNI4
line 613
;611:
;612:	// save the state before the pmove so we can detect transitions
;613:	oldPlayerState = cg.predictedPlayerState;
ADDRLP4 8
ADDRGP4 cg+96
INDIRB
ASGNB 1368
line 615
;614:
;615:	current = trap_GetCurrentCmdNumber();
ADDRLP4 1456
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 1376
ADDRLP4 1456
INDIRI4
ASGNI4
line 620
;616:
;617:	// if we don't have the commands right after the snapshot, we
;618:	// can't accurately predict a current position, so just freeze at
;619:	// the last good position we had
;620:	cmdNum = current - CMD_BACKUP + 1;
ADDRLP4 4
ADDRLP4 1376
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 621
;621:	trap_GetUserCmd( cmdNum, &oldestCmd );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1412
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 622
;622:	if ( oldestCmd.serverTime > cg.snap->ps.commandTime 
ADDRLP4 1460
ADDRLP4 1412
INDIRI4
ASGNI4
ADDRLP4 1460
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $366
ADDRLP4 1460
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $366
line 623
;623:		&& oldestCmd.serverTime < cg.time ) {	// special check for map_restart
line 624
;624:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $331
line 625
;625:			CG_Printf ("exceeded PACKET_BACKUP on commands\n");
ADDRGP4 $373
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 626
;626:		}
line 627
;627:		return;
ADDRGP4 $331
JUMPV
LABELV $366
line 631
;628:	}
;629:
;630:	// get the latest command so we can know which commands are from previous map_restarts
;631:	trap_GetUserCmd( current, &latestCmd );
ADDRLP4 1376
INDIRI4
ARGI4
ADDRLP4 1384
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 637
;632:
;633:	// get the most recent information we have, even if
;634:	// the server time is beyond our current cg.time,
;635:	// because predicted player positions are going to 
;636:	// be ahead of everything else anyway
;637:	if ( cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $374
ADDRLP4 1464
CNSTI4 0
ASGNI4
ADDRGP4 cg+56
INDIRI4
ADDRLP4 1464
INDIRI4
NEI4 $374
ADDRGP4 cg+52
INDIRI4
ADDRLP4 1464
INDIRI4
NEI4 $374
line 638
;638:		cg.predictedPlayerState = cg.nextSnap->ps;
ADDRGP4 cg+96
ADDRGP4 cg+40
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 1368
line 639
;639:		cg.physicsTime = cg.nextSnap->serverTime;
ADDRGP4 cg+72
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 640
;640:	} else {
ADDRGP4 $375
JUMPV
LABELV $374
line 641
;641:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+96
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 1368
line 642
;642:		cg.physicsTime = cg.snap->serverTime;
ADDRGP4 cg+72
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 643
;643:	}
LABELV $375
line 645
;644:
;645:	if ( pmove_msec.integer < 8 ) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 8
GEI4 $387
line 646
;646:		trap_Cvar_Set("pmove_msec", "8");
ADDRGP4 $390
ARGP4
ADDRGP4 $391
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 647
;647:	}
ADDRGP4 $388
JUMPV
LABELV $387
line 648
;648:	else if (pmove_msec.integer > 33) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 33
LEI4 $392
line 649
;649:		trap_Cvar_Set("pmove_msec", "33");
ADDRGP4 $390
ARGP4
ADDRGP4 $395
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 650
;650:	}
LABELV $392
LABELV $388
line 652
;651:
;652:	cg_pmove.pmove_fixed = pmove_fixed.integer;// | cg_pmove_fixed.integer;
ADDRGP4 cg_pmove+232
ADDRGP4 pmove_fixed+12
INDIRI4
ASGNI4
line 653
;653:	cg_pmove.pmove_msec = pmove_msec.integer;
ADDRGP4 cg_pmove+236
ADDRGP4 pmove_msec+12
INDIRI4
ASGNI4
line 656
;654:
;655:	// run cmds
;656:	moved = qfalse;
ADDRLP4 1380
CNSTI4 0
ASGNI4
line 657
;657:	for ( cmdNum = current - CMD_BACKUP + 1 ; cmdNum <= current ; cmdNum++ ) {
ADDRLP4 4
ADDRLP4 1376
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $403
JUMPV
LABELV $400
line 659
;658:		// get the command
;659:		trap_GetUserCmd( cmdNum, &cg_pmove.cmd );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 661
;660:
;661:		if ( cg_pmove.pmove_fixed ) {
ADDRGP4 cg_pmove+232
INDIRI4
CNSTI4 0
EQI4 $405
line 662
;662:			PM_UpdateViewAngles( cg_pmove.ps, &cg_pmove.cmd );
ADDRGP4 cg_pmove
INDIRP4
ARGP4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 663
;663:		}
LABELV $405
line 666
;664:
;665:		// don't do anything if the time is before the snapshot player time
;666:		if ( cg_pmove.cmd.serverTime <= cg.predictedPlayerState.commandTime ) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg+96
INDIRI4
GTI4 $409
line 667
;667:			continue;
ADDRGP4 $401
JUMPV
LABELV $409
line 671
;668:		}
;669:
;670:		// don't do anything if the command was from a previous map_restart
;671:		if ( cg_pmove.cmd.serverTime > latestCmd.serverTime ) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRLP4 1384
INDIRI4
LEI4 $413
line 672
;672:			continue;
ADDRGP4 $401
JUMPV
LABELV $413
line 680
;673:		}
;674:
;675:		// check for a prediction error from last frame
;676:		// on a lan, this will often be the exact value
;677:		// from the snapshot, but on a wan we will have
;678:		// to predict several commands to get to the point
;679:		// we want to compare
;680:		if ( cg.predictedPlayerState.commandTime == oldPlayerState.commandTime ) {
ADDRGP4 cg+96
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $416
line 684
;681:			vec3_t	delta;
;682:			float	len;
;683:
;684:			if ( cg.thisFrameTeleport ) {
ADDRGP4 cg+52
INDIRI4
CNSTI4 0
EQI4 $419
line 686
;685:				// a teleport will not cause an error decay
;686:				VectorClear( cg.predictedError );
ADDRLP4 1484
CNSTF4 0
ASGNF4
ADDRGP4 cg+3392+8
ADDRLP4 1484
INDIRF4
ASGNF4
ADDRGP4 cg+3392+4
ADDRLP4 1484
INDIRF4
ASGNF4
ADDRGP4 cg+3392
ADDRLP4 1484
INDIRF4
ASGNF4
line 687
;687:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $427
line 688
;688:					CG_Printf( "PredictionTeleport\n" );
ADDRGP4 $430
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 689
;689:				}
LABELV $427
line 690
;690:				cg.thisFrameTeleport = qfalse;
ADDRGP4 cg+52
CNSTI4 0
ASGNI4
line 691
;691:			} else {
ADDRGP4 $420
JUMPV
LABELV $419
line 693
;692:				vec3_t	adjusted;
;693:				CG_AdjustPositionForMover( cg.predictedPlayerState.origin, 
ADDRGP4 cg+96+20
ARGP4
ADDRGP4 cg+96+84
INDIRI4
ARGI4
ADDRGP4 cg+72
INDIRI4
ARGI4
ADDRGP4 cg+68
INDIRI4
ARGI4
ADDRLP4 1484
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 696
;694:					cg.predictedPlayerState.groundEntityNum, cg.physicsTime, cg.oldTime, adjusted );
;695:
;696:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $438
line 697
;697:					if (!VectorCompare( oldPlayerState.origin, adjusted )) {
ADDRLP4 8+20
ARGP4
ADDRLP4 1484
ARGP4
ADDRLP4 1496
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 1496
INDIRI4
CNSTI4 0
NEI4 $441
line 698
;698:						CG_Printf("prediction error\n");
ADDRGP4 $444
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 699
;699:					}
LABELV $441
line 700
;700:				}
LABELV $438
line 701
;701:				VectorSubtract( oldPlayerState.origin, adjusted, delta );
ADDRLP4 1468
ADDRLP4 8+20
INDIRF4
ADDRLP4 1484
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1468+4
ADDRLP4 8+20+4
INDIRF4
ADDRLP4 1484+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1468+8
ADDRLP4 8+20+8
INDIRF4
ADDRLP4 1484+8
INDIRF4
SUBF4
ASGNF4
line 702
;702:				len = VectorLength( delta );
ADDRLP4 1468
ARGP4
ADDRLP4 1496
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 1480
ADDRLP4 1496
INDIRF4
ASGNF4
line 703
;703:				if ( len > 0.1 ) {
ADDRLP4 1480
INDIRF4
CNSTF4 1036831949
LEF4 $454
line 704
;704:					if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $456
line 705
;705:						CG_Printf("Prediction miss: %f\n", len);
ADDRGP4 $459
ARGP4
ADDRLP4 1480
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 706
;706:					}
LABELV $456
line 707
;707:					if ( cg_errorDecay.integer ) {
ADDRGP4 cg_errorDecay+12
INDIRI4
CNSTI4 0
EQI4 $460
line 711
;708:						int		t;
;709:						float	f;
;710:
;711:						t = cg.time - cg.predictedErrorTime;
ADDRLP4 1504
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+3388
INDIRI4
SUBI4
ASGNI4
line 712
;712:						f = ( cg_errorDecay.value - t ) / cg_errorDecay.value;
ADDRLP4 1500
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 1504
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 713
;713:						if ( f < 0 ) {
ADDRLP4 1500
INDIRF4
CNSTF4 0
GEF4 $467
line 714
;714:							f = 0;
ADDRLP4 1500
CNSTF4 0
ASGNF4
line 715
;715:						}
LABELV $467
line 716
;716:						if ( f > 0 && cg_showmiss.integer ) {
ADDRLP4 1500
INDIRF4
CNSTF4 0
LEF4 $469
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $469
line 717
;717:							CG_Printf("Double prediction decay: %f\n", f);
ADDRGP4 $472
ARGP4
ADDRLP4 1500
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 718
;718:						}
LABELV $469
line 719
;719:						VectorScale( cg.predictedError, f, cg.predictedError );
ADDRGP4 cg+3392
ADDRGP4 cg+3392
INDIRF4
ADDRLP4 1500
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+3392+4
ADDRGP4 cg+3392+4
INDIRF4
ADDRLP4 1500
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+3392+8
ADDRGP4 cg+3392+8
INDIRF4
ADDRLP4 1500
INDIRF4
MULF4
ASGNF4
line 720
;720:					} else {
ADDRGP4 $461
JUMPV
LABELV $460
line 721
;721:						VectorClear( cg.predictedError );
ADDRLP4 1500
CNSTF4 0
ASGNF4
ADDRGP4 cg+3392+8
ADDRLP4 1500
INDIRF4
ASGNF4
ADDRGP4 cg+3392+4
ADDRLP4 1500
INDIRF4
ASGNF4
ADDRGP4 cg+3392
ADDRLP4 1500
INDIRF4
ASGNF4
line 722
;722:					}
LABELV $461
line 723
;723:					VectorAdd( delta, cg.predictedError, cg.predictedError );
ADDRGP4 cg+3392
ADDRLP4 1468
INDIRF4
ADDRGP4 cg+3392
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+3392+4
ADDRLP4 1468+4
INDIRF4
ADDRGP4 cg+3392+4
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+3392+8
ADDRLP4 1468+8
INDIRF4
ADDRGP4 cg+3392+8
INDIRF4
ADDF4
ASGNF4
line 724
;724:					cg.predictedErrorTime = cg.oldTime;
ADDRGP4 cg+3388
ADDRGP4 cg+68
INDIRI4
ASGNI4
line 725
;725:				}
LABELV $454
line 726
;726:			}
LABELV $420
line 727
;727:		}
LABELV $416
line 729
;728:
;729:		if ( cg_pmove.pmove_fixed ) {
ADDRGP4 cg_pmove+232
INDIRI4
CNSTI4 0
EQI4 $502
line 730
;730:			cg_pmove.cmd.serverTime = ((cg_pmove.cmd.serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
ADDRGP4 cg_pmove+4
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 pmove_msec+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRGP4 pmove_msec+12
INDIRI4
DIVI4
ADDRGP4 pmove_msec+12
INDIRI4
MULI4
ASGNI4
line 731
;731:		}
LABELV $502
line 733
;732:
;733:		cg_pmove.animations = bgGlobalAnimations;
ADDRGP4 cg_pmove+224
ADDRGP4 bgGlobalAnimations
ASGNP4
line 735
;734:
;735:		cg_pmove.gametype = cgs.gametype;
ADDRGP4 cg_pmove+220
ADDRGP4 cgs+32960
INDIRI4
ASGNI4
line 737
;736:
;737:		for ( i = 0 ; i < MAX_CLIENTS ; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $513
line 738
;738:		{
line 739
;739:			memset(&cgSendPS[i], 0, sizeof(cgSendPS[i]));
ADDRLP4 1468
CNSTI4 1368
ASGNI4
ADDRLP4 1468
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgSendPS
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1468
INDIRI4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 740
;740:			CG_EntityStateToPlayerState(&cg_entities[i].currentState, &cgSendPS[i]);
CNSTI4 1920
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
CNSTI4 1368
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgSendPS
ADDP4
ARGP4
ADDRGP4 CG_EntityStateToPlayerState
CALLV
pop
line 741
;741:			cg_pmove.bgClients[i] = &cgSendPS[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_pmove+248
ADDP4
CNSTI4 1368
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgSendPS
ADDP4
ASGNP4
line 742
;742:		}
LABELV $514
line 737
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $513
line 744
;743:
;744:		if (cg.snap && cg.snap->ps.saberLockTime > cg.time)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $518
ADDRGP4 cg+36
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $518
line 745
;745:		{
line 746
;746:			centity_t *blockOpp = &cg_entities[cg.snap->ps.saberLockEnemy];
ADDRLP4 1468
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 748
;747:
;748:			if (blockOpp)
ADDRLP4 1468
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $524
line 749
;749:			{
line 752
;750:				vec3_t lockDir, lockAng;
;751:
;752:				VectorSubtract( blockOpp->lerpOrigin, cg.snap->ps.origin, lockDir );
ADDRLP4 1472
ADDRLP4 1468
INDIRP4
CNSTI4 928
ADDP4
INDIRF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1472+4
ADDRLP4 1468
INDIRP4
CNSTI4 932
ADDP4
INDIRF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1472+8
ADDRLP4 1468
INDIRP4
CNSTI4 936
ADDP4
INDIRF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
SUBF4
ASGNF4
line 754
;753:				//lockAng[YAW] = vectoyaw( defDir );
;754:				vectoangles(lockDir, lockAng);
ADDRLP4 1472
ARGP4
ADDRLP4 1484
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 756
;755:
;756:				VectorCopy(lockAng, cg_pmove.ps->viewangles);
ADDRGP4 cg_pmove
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 1484
INDIRB
ASGNB 12
line 757
;757:			}
LABELV $524
line 758
;758:		}
LABELV $518
line 760
;759:
;760:		Pmove (&cg_pmove);
ADDRGP4 cg_pmove
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 762
;761:
;762:		for ( i = 0 ; i < MAX_CLIENTS ; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $531
line 763
;763:		{
line 764
;764:			cg_entities[i].currentState.torsoAnim = cgSendPS[i].torsoAnim;
CNSTI4 1920
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+284
ADDP4
CNSTI4 1368
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgSendPS+100
ADDP4
INDIRI4
ASGNI4
line 765
;765:			cg_entities[i].currentState.legsAnim = cgSendPS[i].legsAnim;
CNSTI4 1920
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+280
ADDP4
CNSTI4 1368
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgSendPS+92
ADDP4
INDIRI4
ASGNI4
line 766
;766:			cg_entities[i].currentState.forceFrame = cgSendPS[i].saberLockFrame;
CNSTI4 1920
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+288
ADDP4
CNSTI4 1368
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgSendPS+532
ADDP4
INDIRI4
ASGNI4
line 767
;767:			cg_entities[i].currentState.saberMove = cgSendPS[i].saberMove;
CNSTI4 1920
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+236
ADDP4
CNSTI4 1368
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgSendPS+512
ADDP4
INDIRI4
ASGNI4
line 768
;768:		}
LABELV $532
line 762
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $531
line 770
;769:
;770:		moved = qtrue;
ADDRLP4 1380
CNSTI4 1
ASGNI4
line 773
;771:
;772:		// add push trigger movement effects
;773:		CG_TouchTriggerPrediction();
ADDRGP4 CG_TouchTriggerPrediction
CALLV
pop
line 777
;774:
;775:		// check for predictable events that changed from previous predictions
;776:		//CG_CheckChangedPredictableEvents(&cg.predictedPlayerState);
;777:	}
LABELV $401
line 657
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $403
ADDRLP4 4
INDIRI4
ADDRLP4 1376
INDIRI4
LEI4 $400
line 779
;778:
;779:	if ( cg_showmiss.integer > 1 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $543
line 780
;780:		CG_Printf( "[%i : %i] ", cg_pmove.cmd.serverTime, cg.time );
ADDRGP4 $546
ARGP4
ADDRGP4 cg_pmove+4
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 781
;781:	}
LABELV $543
line 783
;782:
;783:	if ( !moved ) {
ADDRLP4 1380
INDIRI4
CNSTI4 0
NEI4 $549
line 784
;784:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $331
line 785
;785:			CG_Printf( "not moved\n" );
ADDRGP4 $554
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 786
;786:		}
line 787
;787:		return;
ADDRGP4 $331
JUMPV
LABELV $549
line 791
;788:	}
;789:
;790:	// adjust for the movement of the groundentity
;791:	CG_AdjustPositionForMover( cg.predictedPlayerState.origin, 
ADDRGP4 cg+96+20
ARGP4
ADDRGP4 cg+96+84
INDIRI4
ARGI4
ADDRGP4 cg+72
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cg+96+20
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 795
;792:		cg.predictedPlayerState.groundEntityNum, 
;793:		cg.physicsTime, cg.time, cg.predictedPlayerState.origin );
;794:
;795:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $563
line 796
;796:		if (cg.predictedPlayerState.eventSequence > oldPlayerState.eventSequence + MAX_PS_EVENTS) {
ADDRGP4 cg+96+112
INDIRI4
ADDRLP4 8+112
INDIRI4
CNSTI4 2
ADDI4
LEI4 $566
line 797
;797:			CG_Printf("WARNING: dropped event\n");
ADDRGP4 $571
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 798
;798:		}
LABELV $566
line 799
;799:	}
LABELV $563
line 802
;800:
;801:	// fire events and other transition triggered things
;802:	CG_TransitionPlayerState( &cg.predictedPlayerState, &oldPlayerState );
ADDRGP4 cg+96
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_TransitionPlayerState
CALLV
pop
line 804
;803:
;804:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $573
line 805
;805:		if (cg.eventSequence > cg.predictedPlayerState.eventSequence) {
ADDRGP4 cg+3404
INDIRI4
ADDRGP4 cg+96+112
INDIRI4
LEI4 $576
line 806
;806:			CG_Printf("WARNING: double event\n");
ADDRGP4 $581
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 807
;807:			cg.eventSequence = cg.predictedPlayerState.eventSequence;
ADDRGP4 cg+3404
ADDRGP4 cg+96+112
INDIRI4
ASGNI4
line 808
;808:		}
LABELV $576
line 809
;809:	}
LABELV $573
line 810
;810:}
LABELV $331
endproc CG_PredictPlayerState 1508 20
bss
export cgSendPS
align 4
LABELV cgSendPS
skip 43776
align 4
LABELV cg_triggerEntities
skip 1024
align 4
LABELV cg_numTriggerEntities
skip 4
align 4
LABELV cg_solidEntities
skip 1024
align 4
LABELV cg_numSolidEntities
skip 4
align 4
LABELV cg_pmove
skip 376
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
LABELV $581
char 1 87
char 1 65
char 1 82
char 1 78
char 1 73
char 1 78
char 1 71
char 1 58
char 1 32
char 1 100
char 1 111
char 1 117
char 1 98
char 1 108
char 1 101
char 1 32
char 1 101
char 1 118
char 1 101
char 1 110
char 1 116
char 1 10
char 1 0
align 1
LABELV $571
char 1 87
char 1 65
char 1 82
char 1 78
char 1 73
char 1 78
char 1 71
char 1 58
char 1 32
char 1 100
char 1 114
char 1 111
char 1 112
char 1 112
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
align 1
LABELV $554
char 1 110
char 1 111
char 1 116
char 1 32
char 1 109
char 1 111
char 1 118
char 1 101
char 1 100
char 1 10
char 1 0
align 1
LABELV $546
char 1 91
char 1 37
char 1 105
char 1 32
char 1 58
char 1 32
char 1 37
char 1 105
char 1 93
char 1 32
char 1 0
align 1
LABELV $472
char 1 68
char 1 111
char 1 117
char 1 98
char 1 108
char 1 101
char 1 32
char 1 112
char 1 114
char 1 101
char 1 100
char 1 105
char 1 99
char 1 116
char 1 105
char 1 111
char 1 110
char 1 32
char 1 100
char 1 101
char 1 99
char 1 97
char 1 121
char 1 58
char 1 32
char 1 37
char 1 102
char 1 10
char 1 0
align 1
LABELV $459
char 1 80
char 1 114
char 1 101
char 1 100
char 1 105
char 1 99
char 1 116
char 1 105
char 1 111
char 1 110
char 1 32
char 1 109
char 1 105
char 1 115
char 1 115
char 1 58
char 1 32
char 1 37
char 1 102
char 1 10
char 1 0
align 1
LABELV $444
char 1 112
char 1 114
char 1 101
char 1 100
char 1 105
char 1 99
char 1 116
char 1 105
char 1 111
char 1 110
char 1 32
char 1 101
char 1 114
char 1 114
char 1 111
char 1 114
char 1 10
char 1 0
align 1
LABELV $430
char 1 80
char 1 114
char 1 101
char 1 100
char 1 105
char 1 99
char 1 116
char 1 105
char 1 111
char 1 110
char 1 84
char 1 101
char 1 108
char 1 101
char 1 112
char 1 111
char 1 114
char 1 116
char 1 10
char 1 0
align 1
LABELV $395
char 1 51
char 1 51
char 1 0
align 1
LABELV $391
char 1 56
char 1 0
align 1
LABELV $390
char 1 112
char 1 109
char 1 111
char 1 118
char 1 101
char 1 95
char 1 109
char 1 115
char 1 101
char 1 99
char 1 0
align 1
LABELV $373
char 1 101
char 1 120
char 1 99
char 1 101
char 1 101
char 1 100
char 1 101
char 1 100
char 1 32
char 1 80
char 1 65
char 1 67
char 1 75
char 1 69
char 1 84
char 1 95
char 1 66
char 1 65
char 1 67
char 1 75
char 1 85
char 1 80
char 1 32
char 1 111
char 1 110
char 1 32
char 1 99
char 1 111
char 1 109
char 1 109
char 1 97
char 1 110
char 1 100
char 1 115
char 1 10
char 1 0
