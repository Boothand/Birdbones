code
proc CG_ResetEntity 8 4
file "../cg_snapshot.c"
line 15
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_snapshot.c -- things that happen on snapshot transition,
;4:// not necessarily every single rendered frame
;5:
;6:#include "cg_local.h"
;7:
;8:
;9:
;10:/*
;11:==================
;12:CG_ResetEntity
;13:==================
;14:*/
;15:static void CG_ResetEntity( centity_t *cent ) {
line 18
;16:	// if the previous snapshot this entity was updated in is at least
;17:	// an event window back in time then we can reset the previous event
;18:	if ( cent->snapShotTime < cg.time - EVENT_VALID_MSEC ) {
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
CNSTI4 300
SUBI4
GEI4 $121
line 19
;19:		cent->previousEvent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
CNSTI4 0
ASGNI4
line 20
;20:	}
LABELV $121
line 22
;21:
;22:	cent->trailTime = cg.snap->serverTime;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 24
;23:
;24:	VectorCopy (cent->currentState.origin, cent->lerpOrigin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 928
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 25
;25:	VectorCopy (cent->currentState.angles, cent->lerpAngles);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 26
;26:	if ( cent->currentState.eType == ET_PLAYER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $125
line 27
;27:		CG_ResetPlayerEntity( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 28
;28:	}
LABELV $125
line 29
;29:}
LABELV $120
endproc CG_ResetEntity 8 4
proc CG_TransitionEntity 4 4
line 38
;30:
;31:/*
;32:===============
;33:CG_TransitionEntity
;34:
;35:cent->nextState is moved to cent->currentState and events are fired
;36:===============
;37:*/
;38:static void CG_TransitionEntity( centity_t *cent ) {
line 39
;39:	cent->currentState = cent->nextState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRB
ASGNB 296
line 40
;40:	cent->currentValid = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
CNSTI4 1
ASGNI4
line 43
;41:
;42:	// reset if the entity wasn't in the last frame or was teleported
;43:	if ( !cent->interpolate ) {
ADDRFP4 0
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
CNSTI4 0
NEI4 $128
line 44
;44:		CG_ResetEntity( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ResetEntity
CALLV
pop
line 45
;45:	}
LABELV $128
line 48
;46:
;47:	// clear the next state.  if will be set by the next CG_SetNextSnap
;48:	cent->interpolate = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 592
ADDP4
CNSTI4 0
ASGNI4
line 51
;49:
;50:	// check for events
;51:	CG_CheckEvents( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CheckEvents
CALLV
pop
line 52
;52:}
LABELV $127
endproc CG_TransitionEntity 4 4
export CG_SetInitialSnapshot
proc CG_SetInitialSnapshot 24 12
line 66
;53:
;54:
;55:/*
;56:==================
;57:CG_SetInitialSnapshot
;58:
;59:This will only happen on the very first snapshot, or
;60:on tourney restarts.  All other times will use 
;61:CG_TransitionSnapshot instead.
;62:
;63:FIXME: Also called by map_restart?
;64:==================
;65:*/
;66:void CG_SetInitialSnapshot( snapshot_t *snap ) {
line 71
;67:	int				i;
;68:	centity_t		*cent;
;69:	entityState_t	*state;
;70:
;71:	cg.snap = snap; 
ADDRGP4 cg+36
ADDRFP4 0
INDIRP4
ASGNP4
line 73
;72:
;73:	if ((cg_entities[snap->ps.clientNum].ghoul2 == NULL) && trap_G2_HaveWeGhoul2Models(cgs.clientinfo[snap->ps.clientNum].ghoul2Model))
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
CNSTI4 1920
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $132
CNSTI4 788
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 cgs+43008+504
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $132
line 74
;74:	{
line 75
;75:		trap_G2API_DuplicateGhoul2Instance(cgs.clientinfo[snap->ps.clientNum].ghoul2Model, &cg_entities[snap->ps.clientNum].ghoul2);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
CNSTI4 788
ADDRLP4 20
INDIRI4
MULI4
ADDRGP4 cgs+43008+504
ADDP4
INDIRP4
ARGP4
CNSTI4 1920
ADDRLP4 20
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
ARGP4
ADDRGP4 trap_G2API_DuplicateGhoul2Instance
CALLV
pop
line 76
;76:		CG_CopyG2WeaponInstance(FIRST_WEAPON, cg_entities[snap->ps.clientNum].ghoul2);
CNSTI4 3
ARGI4
CNSTI4 1920
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_CopyG2WeaponInstance
CALLV
pop
line 77
;77:	}
LABELV $132
line 78
;78:	BG_PlayerStateToEntityState( &snap->ps, &cg_entities[ snap->ps.clientNum ].currentState, qfalse );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 1920
ADDRLP4 20
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 81
;79:
;80:	// sort out solid entities
;81:	CG_BuildSolidList();
ADDRGP4 CG_BuildSolidList
CALLV
pop
line 83
;82:
;83:	CG_ExecuteNewServerCommands( snap->serverCommandSequence );
ADDRFP4 0
INDIRP4
CNSTI4 77196
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ExecuteNewServerCommands
CALLV
pop
line 87
;84:
;85:	// set our local weapon selection pointer to
;86:	// what the server has indicated the current weapon is
;87:	CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 89
;88:
;89:	for ( i = 0 ; i < cg.snap->numEntities ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $144
JUMPV
LABELV $141
line 90
;90:		state = &cg.snap->entities[ i ];
ADDRLP4 8
CNSTI4 296
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1416
ADDP4
ADDP4
ASGNP4
line 91
;91:		cent = &cg_entities[ state->number ];
ADDRLP4 0
CNSTI4 1920
ADDRLP4 8
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 93
;92:
;93:		memcpy(&cent->currentState, state, sizeof(entityState_t));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 296
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 95
;94:		//cent->currentState = *state;
;95:		cent->interpolate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
CNSTI4 0
ASGNI4
line 96
;96:		cent->currentValid = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
CNSTI4 1
ASGNI4
line 98
;97:
;98:		CG_ResetEntity( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ResetEntity
CALLV
pop
line 101
;99:
;100:		// check for events
;101:		CG_CheckEvents( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CheckEvents
CALLV
pop
line 102
;102:	}
LABELV $142
line 89
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $144
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1412
ADDP4
INDIRI4
LTI4 $141
line 103
;103:}
LABELV $130
endproc CG_SetInitialSnapshot 24 12
proc CG_TransitionSnapshot 28 12
line 113
;104:
;105:
;106:/*
;107:===================
;108:CG_TransitionSnapshot
;109:
;110:The transition point from snap to nextSnap has passed
;111:===================
;112:*/
;113:static void CG_TransitionSnapshot( void ) {
line 118
;114:	centity_t			*cent;
;115:	snapshot_t			*oldFrame;
;116:	int					i;
;117:
;118:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $148
line 119
;119:		CG_Error( "CG_TransitionSnapshot: NULL cg.snap" );
ADDRGP4 $151
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 120
;120:	}
LABELV $148
line 121
;121:	if ( !cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $152
line 122
;122:		CG_Error( "CG_TransitionSnapshot: NULL cg.nextSnap" );
ADDRGP4 $155
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 123
;123:	}
LABELV $152
line 126
;124:
;125:	// execute any server string commands before transitioning entities
;126:	CG_ExecuteNewServerCommands( cg.nextSnap->serverCommandSequence );
ADDRGP4 cg+40
INDIRP4
CNSTI4 77196
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ExecuteNewServerCommands
CALLV
pop
line 129
;127:
;128:	// if we had a map_restart, set everthing with initial
;129:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $157
line 130
;130:	}
LABELV $157
line 133
;131:
;132:	// clear the currentValid flag for all entities in the existing snapshot
;133:	for ( i = 0 ; i < cg.snap->numEntities ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $163
JUMPV
LABELV $160
line 134
;134:		cent = &cg_entities[ cg.snap->entities[ i ].number ];
ADDRLP4 4
CNSTI4 1920
CNSTI4 296
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1416
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 135
;135:		cent->currentValid = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 596
ADDP4
CNSTI4 0
ASGNI4
line 136
;136:	}
LABELV $161
line 133
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $163
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1412
ADDP4
INDIRI4
LTI4 $160
line 139
;137:
;138:	// move nextSnap to snap and do the transitions
;139:	oldFrame = cg.snap;
ADDRLP4 8
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 140
;140:	cg.snap = cg.nextSnap;
ADDRGP4 cg+36
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 142
;141:
;142:	CG_CheckPlayerG2Weapons(&cg.snap->ps, &cg_entities[cg.snap->ps.clientNum]);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_CheckPlayerG2Weapons
CALLV
pop
line 143
;143:	BG_PlayerStateToEntityState( &cg.snap->ps, &cg_entities[ cg.snap->ps.clientNum ].currentState, qfalse );
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 144
;144:	cg_entities[ cg.snap->ps.clientNum ].interpolate = qfalse;
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+592
ADDP4
CNSTI4 0
ASGNI4
line 146
;145:
;146:	for ( i = 0 ; i < cg.snap->numEntities ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $178
JUMPV
LABELV $175
line 147
;147:		cent = &cg_entities[ cg.snap->entities[ i ].number ];
ADDRLP4 4
CNSTI4 1920
CNSTI4 296
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1416
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 148
;148:		CG_TransitionEntity( cent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CG_TransitionEntity
CALLV
pop
line 151
;149:
;150:		// remember time of snapshot this entity was last updated in
;151:		cent->snapShotTime = cg.snap->serverTime;
ADDRLP4 4
INDIRP4
CNSTI4 640
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 152
;152:	}
LABELV $176
line 146
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $178
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1412
ADDP4
INDIRI4
LTI4 $175
line 154
;153:
;154:	cg.nextSnap = NULL;
ADDRGP4 cg+40
CNSTP4 0
ASGNP4
line 157
;155:
;156:	// check for playerstate transition events
;157:	if ( oldFrame ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $183
line 160
;158:		playerState_t	*ops, *ps;
;159:
;160:		ops = &oldFrame->ps;
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 161
;161:		ps = &cg.snap->ps;
ADDRLP4 16
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 163
;162:		// teleporting checks are irrespective of prediction
;163:		if ( ( ps->eFlags ^ ops->eFlags ) & EF_TELEPORT_BIT ) {
ADDRLP4 20
CNSTI4 108
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $186
line 164
;164:			cg.thisFrameTeleport = qtrue;	// will be cleared by prediction code
ADDRGP4 cg+52
CNSTI4 1
ASGNI4
line 165
;165:		}
LABELV $186
line 169
;166:
;167:		// if we are not doing client side movement prediction for any
;168:		// reason, then the client events and view changes will be issued now
;169:		if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW)
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 cg+8
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $197
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 24
INDIRI4
NEI4 $197
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $197
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $189
LABELV $197
line 170
;170:			|| cg_nopredict.integer || cg_synchronousClients.integer ) {
line 171
;171:			CG_TransitionPlayerState( ps, ops );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_TransitionPlayerState
CALLV
pop
line 172
;172:		}
LABELV $189
line 173
;173:	}
LABELV $183
line 175
;174:
;175:}
LABELV $147
endproc CG_TransitionSnapshot 28 12
proc CG_SetNextSnap 32 12
line 185
;176:
;177:
;178:/*
;179:===================
;180:CG_SetNextSnap
;181:
;182:A new snapshot has just been read in from the client system.
;183:===================
;184:*/
;185:static void CG_SetNextSnap( snapshot_t *snap ) {
line 190
;186:	int					num;
;187:	entityState_t		*es;
;188:	centity_t			*cent;
;189:
;190:	cg.nextSnap = snap;
ADDRGP4 cg+40
ADDRFP4 0
INDIRP4
ASGNP4
line 192
;191:
;192:	CG_CheckPlayerG2Weapons(&cg.snap->ps, &cg_entities[cg.snap->ps.clientNum]);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_CheckPlayerG2Weapons
CALLV
pop
line 193
;193:	BG_PlayerStateToEntityState( &snap->ps, &cg_entities[ snap->ps.clientNum ].nextState, qfalse );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 1920
ADDRLP4 12
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+296
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 194
;194:	cg_entities[ cg.snap->ps.clientNum ].interpolate = qtrue;
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+592
ADDP4
CNSTI4 1
ASGNI4
line 197
;195:
;196:	// check for extrapolation errors
;197:	for ( num = 0 ; num < snap->numEntities ; num++ ) 
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $208
JUMPV
LABELV $205
line 198
;198:	{
line 199
;199:		es = &snap->entities[num];
ADDRLP4 4
CNSTI4 296
ADDRLP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 1416
ADDP4
ADDP4
ASGNP4
line 200
;200:		cent = &cg_entities[ es->number ];
ADDRLP4 0
CNSTI4 1920
ADDRLP4 4
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 202
;201:
;202:		memcpy(&cent->nextState, es, sizeof(entityState_t));
ADDRLP4 16
CNSTI4 296
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 207
;203:		//cent->nextState = *es;
;204:
;205:		// if this frame is a teleport, or the entity wasn't in the
;206:		// previous frame, don't interpolate
;207:		if ( !cent->currentValid || ( ( cent->currentState.eFlags ^ es->eFlags ) & EF_TELEPORT_BIT )  ) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $211
ADDRLP4 28
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
ADDRLP4 24
INDIRI4
EQI4 $209
LABELV $211
line 208
;208:			cent->interpolate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
CNSTI4 0
ASGNI4
line 209
;209:		} else {
ADDRGP4 $210
JUMPV
LABELV $209
line 210
;210:			cent->interpolate = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
CNSTI4 1
ASGNI4
line 211
;211:		}
LABELV $210
line 212
;212:	}
LABELV $206
line 197
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $208
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
INDIRI4
LTI4 $205
line 216
;213:
;214:	// if the next frame is a teleport for the playerstate, we
;215:	// can't interpolate during demos
;216:	if ( cg.snap && ( ( snap->ps.eFlags ^ cg.snap->ps.eFlags ) & EF_TELEPORT_BIT ) ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $212
ADDRLP4 16
CNSTI4 152
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $212
line 217
;217:		cg.nextFrameTeleport = qtrue;
ADDRGP4 cg+56
CNSTI4 1
ASGNI4
line 218
;218:	} else {
ADDRGP4 $213
JUMPV
LABELV $212
line 219
;219:		cg.nextFrameTeleport = qfalse;
ADDRGP4 cg+56
CNSTI4 0
ASGNI4
line 220
;220:	}
LABELV $213
line 223
;221:
;222:	// if changing follow mode, don't interpolate
;223:	if ( cg.nextSnap->ps.clientNum != cg.snap->ps.clientNum ) {
ADDRLP4 20
CNSTI4 188
ASGNI4
ADDRGP4 cg+40
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
EQI4 $218
line 224
;224:		cg.nextFrameTeleport = qtrue;
ADDRGP4 cg+56
CNSTI4 1
ASGNI4
line 225
;225:	}
LABELV $218
line 228
;226:
;227:	// if changing server restarts, don't interpolate
;228:	if ( ( cg.nextSnap->snapFlags ^ cg.snap->snapFlags ) & SNAPFLAG_SERVERCOUNT ) {
ADDRGP4 cg+40
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $223
line 229
;229:		cg.nextFrameTeleport = qtrue;
ADDRGP4 cg+56
CNSTI4 1
ASGNI4
line 230
;230:	}
LABELV $223
line 233
;231:
;232:	// sort out solid entities
;233:	CG_BuildSolidList();
ADDRGP4 CG_BuildSolidList
CALLV
pop
line 234
;234:}
LABELV $198
endproc CG_SetNextSnap 32 12
proc CG_ReadNextSnapshot 20 12
line 247
;235:
;236:
;237:/*
;238:========================
;239:CG_ReadNextSnapshot
;240:
;241:This is the only place new snapshots are requested
;242:This may increment cgs.processedSnapshotNum multiple
;243:times if the client system fails to return a
;244:valid snapshot.
;245:========================
;246:*/
;247:static snapshot_t *CG_ReadNextSnapshot( void ) {
line 251
;248:	qboolean	r;
;249:	snapshot_t	*dest;
;250:
;251:	if ( cg.latestSnapshotNum > cgs.processedSnapshotNum + 1000 ) {
ADDRGP4 cg+28
INDIRI4
ADDRGP4 cgs+32952
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $237
line 252
;252:		CG_Printf( "WARNING: CG_ReadNextSnapshot: way out of range, %i > %i", 
ADDRGP4 $233
ARGP4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+32952
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 254
;253:			cg.latestSnapshotNum, cgs.processedSnapshotNum );
;254:	}
ADDRGP4 $237
JUMPV
LABELV $236
line 256
;255:
;256:	while ( cgs.processedSnapshotNum < cg.latestSnapshotNum ) {
line 258
;257:		// decide which of the two slots to load it into
;258:		if ( cg.snap == &cg.activeSnapshots[0] ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
ADDRGP4 cg+13800
CVPU4 4
NEU4 $241
line 259
;259:			dest = &cg.activeSnapshots[1];
ADDRLP4 0
ADDRGP4 cg+13800+77200
ASGNP4
line 260
;260:		} else {
ADDRGP4 $242
JUMPV
LABELV $241
line 261
;261:			dest = &cg.activeSnapshots[0];
ADDRLP4 0
ADDRGP4 cg+13800
ASGNP4
line 262
;262:		}
LABELV $242
line 265
;263:
;264:		// try to read the snapshot from the client system
;265:		cgs.processedSnapshotNum++;
ADDRLP4 8
ADDRGP4 cgs+32952
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 266
;266:		r = trap_GetSnapshot( cgs.processedSnapshotNum, dest );
ADDRGP4 cgs+32952
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_GetSnapshot
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 269
;267:
;268:		// FIXME: why would trap_GetSnapshot return a snapshot with the same server time
;269:		if ( cg.snap && r && dest->serverTime == cg.snap->serverTime ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $250
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $250
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
NEI4 $250
line 271
;270:			//continue;
;271:		}
LABELV $250
line 274
;272:
;273:		// if it succeeded, return
;274:		if ( r ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $254
line 275
;275:			CG_AddLagometerSnapshotInfo( dest );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddLagometerSnapshotInfo
CALLV
pop
line 276
;276:			return dest;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $228
JUMPV
LABELV $254
line 285
;277:		}
;278:
;279:		// a GetSnapshot will return failure if the snapshot
;280:		// never arrived, or  is so old that its entities
;281:		// have been shoved off the end of the circular
;282:		// buffer in the client system.
;283:
;284:		// record as a dropped packet
;285:		CG_AddLagometerSnapshotInfo( NULL );
CNSTP4 0
ARGP4
ADDRGP4 CG_AddLagometerSnapshotInfo
CALLV
pop
line 289
;286:
;287:		// If there are additional snapshots, continue trying to
;288:		// read them.
;289:	}
LABELV $237
line 256
ADDRGP4 cgs+32952
INDIRI4
ADDRGP4 cg+28
INDIRI4
LTI4 $236
line 292
;290:
;291:	// nothing left to read
;292:	return NULL;
CNSTP4 0
RETP4
LABELV $228
endproc CG_ReadNextSnapshot 20 12
export CG_ProcessSnapshots
proc CG_ProcessSnapshots 16 8
line 315
;293:}
;294:
;295:
;296:/*
;297:============
;298:CG_ProcessSnapshots
;299:
;300:We are trying to set up a renderable view, so determine
;301:what the simulated time is, and try to get snapshots
;302:both before and after that time if available.
;303:
;304:If we don't have a valid cg.snap after exiting this function,
;305:then a 3D game view cannot be rendered.  This should only happen
;306:right after the initial connection.  After cg.snap has been valid
;307:once, it will never turn invalid.
;308:
;309:Even if cg.snap is valid, cg.nextSnap may not be, if the snapshot
;310:hasn't arrived yet (it becomes an extrapolating situation instead
;311:of an interpolating one)
;312:
;313:============
;314:*/
;315:void CG_ProcessSnapshots( void ) {
line 320
;316:	snapshot_t		*snap;
;317:	int				n;
;318:
;319:	// see what the latest snapshot the client system has is
;320:	trap_GetCurrentSnapshotNumber( &n, &cg.latestSnapshotTime );
ADDRLP4 4
ARGP4
ADDRGP4 cg+32
ARGP4
ADDRGP4 trap_GetCurrentSnapshotNumber
CALLV
pop
line 321
;321:	if ( n != cg.latestSnapshotNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+28
INDIRI4
EQI4 $267
line 322
;322:		if ( n < cg.latestSnapshotNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+28
INDIRI4
GEI4 $261
line 324
;323:			// this should never happen
;324:			CG_Error( "CG_ProcessSnapshots: n < cg.latestSnapshotNum" );
ADDRGP4 $264
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 325
;325:		}
LABELV $261
line 326
;326:		cg.latestSnapshotNum = n;
ADDRGP4 cg+28
ADDRLP4 4
INDIRI4
ASGNI4
line 327
;327:	}
ADDRGP4 $267
JUMPV
LABELV $266
line 332
;328:
;329:	// If we have yet to receive a snapshot, check for it.
;330:	// Once we have gotten the first snapshot, cg.snap will
;331:	// always have valid data for the rest of the game
;332:	while ( !cg.snap ) {
line 333
;333:		snap = CG_ReadNextSnapshot();
ADDRLP4 8
ADDRGP4 CG_ReadNextSnapshot
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 334
;334:		if ( !snap ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $270
line 336
;335:			// we can't continue until we get a snapshot
;336:			return;
ADDRGP4 $256
JUMPV
LABELV $270
line 341
;337:		}
;338:
;339:		// set our weapon selection to what
;340:		// the playerstate is currently using
;341:		if ( !( snap->snapFlags & SNAPFLAG_NOT_ACTIVE ) ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $272
line 342
;342:			CG_SetInitialSnapshot( snap );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetInitialSnapshot
CALLV
pop
line 343
;343:		}
LABELV $272
line 344
;344:	}
LABELV $267
line 332
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $266
LABELV $274
line 349
;345:
;346:	// loop until we either have a valid nextSnap with a serverTime
;347:	// greater than cg.time to interpolate towards, or we run
;348:	// out of available snapshots
;349:	do {
line 351
;350:		// if we don't have a nextframe, try and read a new one in
;351:		if ( !cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $277
line 352
;352:			snap = CG_ReadNextSnapshot();
ADDRLP4 8
ADDRGP4 CG_ReadNextSnapshot
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 356
;353:
;354:			// if we still don't have a nextframe, we will just have to
;355:			// extrapolate
;356:			if ( !snap ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $280
line 357
;357:				break;
ADDRGP4 $276
JUMPV
LABELV $280
line 360
;358:			}
;359:
;360:			CG_SetNextSnap( snap );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetNextSnap
CALLV
pop
line 364
;361:
;362:
;363:			// if time went backwards, we have a level restart
;364:			if ( cg.nextSnap->serverTime < cg.snap->serverTime ) {
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRGP4 cg+40
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
GEI4 $282
line 365
;365:				CG_Error( "CG_ProcessSnapshots: Server time went backwards" );
ADDRGP4 $286
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 366
;366:			}
LABELV $282
line 367
;367:		}
LABELV $277
line 370
;368:
;369:		// if our time is < nextFrame's, we have a nice interpolating state
;370:		if ( cg.time >= cg.snap->serverTime && cg.time < cg.nextSnap->serverTime ) {
ADDRLP4 8
CNSTI4 8
ASGNI4
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
LTI4 $287
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+40
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
GEI4 $287
line 371
;371:			break;
ADDRGP4 $276
JUMPV
LABELV $287
line 375
;372:		}
;373:
;374:		// we have passed the transition from nextFrame to frame
;375:		CG_TransitionSnapshot();
ADDRGP4 CG_TransitionSnapshot
CALLV
pop
line 376
;376:	} while ( 1 );
LABELV $275
ADDRGP4 $274
JUMPV
LABELV $276
line 379
;377:
;378:	// assert our valid conditions upon exiting
;379:	if ( cg.snap == NULL ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $293
line 380
;380:		CG_Error( "CG_ProcessSnapshots: cg.snap == NULL" );
ADDRGP4 $296
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 381
;381:	}
LABELV $293
line 382
;382:	if ( cg.time < cg.snap->serverTime ) {
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
GEI4 $297
line 384
;383:		// this can happen right after a vid_restart
;384:		cg.time = cg.snap->serverTime;
ADDRGP4 cg+64
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 385
;385:	}
LABELV $297
line 386
;386:	if ( cg.nextSnap != NULL && cg.nextSnap->serverTime <= cg.time ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $303
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
GTI4 $303
line 387
;387:		CG_Error( "CG_ProcessSnapshots: cg.nextSnap->serverTime <= cg.time" );
ADDRGP4 $308
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 388
;388:	}
LABELV $303
line 390
;389:
;390:}
LABELV $256
endproc CG_ProcessSnapshots 16 8
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
LABELV $308
char 1 67
char 1 71
char 1 95
char 1 80
char 1 114
char 1 111
char 1 99
char 1 101
char 1 115
char 1 115
char 1 83
char 1 110
char 1 97
char 1 112
char 1 115
char 1 104
char 1 111
char 1 116
char 1 115
char 1 58
char 1 32
char 1 99
char 1 103
char 1 46
char 1 110
char 1 101
char 1 120
char 1 116
char 1 83
char 1 110
char 1 97
char 1 112
char 1 45
char 1 62
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 84
char 1 105
char 1 109
char 1 101
char 1 32
char 1 60
char 1 61
char 1 32
char 1 99
char 1 103
char 1 46
char 1 116
char 1 105
char 1 109
char 1 101
char 1 0
align 1
LABELV $296
char 1 67
char 1 71
char 1 95
char 1 80
char 1 114
char 1 111
char 1 99
char 1 101
char 1 115
char 1 115
char 1 83
char 1 110
char 1 97
char 1 112
char 1 115
char 1 104
char 1 111
char 1 116
char 1 115
char 1 58
char 1 32
char 1 99
char 1 103
char 1 46
char 1 115
char 1 110
char 1 97
char 1 112
char 1 32
char 1 61
char 1 61
char 1 32
char 1 78
char 1 85
char 1 76
char 1 76
char 1 0
align 1
LABELV $286
char 1 67
char 1 71
char 1 95
char 1 80
char 1 114
char 1 111
char 1 99
char 1 101
char 1 115
char 1 115
char 1 83
char 1 110
char 1 97
char 1 112
char 1 115
char 1 104
char 1 111
char 1 116
char 1 115
char 1 58
char 1 32
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 32
char 1 116
char 1 105
char 1 109
char 1 101
char 1 32
char 1 119
char 1 101
char 1 110
char 1 116
char 1 32
char 1 98
char 1 97
char 1 99
char 1 107
char 1 119
char 1 97
char 1 114
char 1 100
char 1 115
char 1 0
align 1
LABELV $264
char 1 67
char 1 71
char 1 95
char 1 80
char 1 114
char 1 111
char 1 99
char 1 101
char 1 115
char 1 115
char 1 83
char 1 110
char 1 97
char 1 112
char 1 115
char 1 104
char 1 111
char 1 116
char 1 115
char 1 58
char 1 32
char 1 110
char 1 32
char 1 60
char 1 32
char 1 99
char 1 103
char 1 46
char 1 108
char 1 97
char 1 116
char 1 101
char 1 115
char 1 116
char 1 83
char 1 110
char 1 97
char 1 112
char 1 115
char 1 104
char 1 111
char 1 116
char 1 78
char 1 117
char 1 109
char 1 0
align 1
LABELV $233
char 1 87
char 1 65
char 1 82
char 1 78
char 1 73
char 1 78
char 1 71
char 1 58
char 1 32
char 1 67
char 1 71
char 1 95
char 1 82
char 1 101
char 1 97
char 1 100
char 1 78
char 1 101
char 1 120
char 1 116
char 1 83
char 1 110
char 1 97
char 1 112
char 1 115
char 1 104
char 1 111
char 1 116
char 1 58
char 1 32
char 1 119
char 1 97
char 1 121
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
char 1 44
char 1 32
char 1 37
char 1 105
char 1 32
char 1 62
char 1 32
char 1 37
char 1 105
char 1 0
align 1
LABELV $155
char 1 67
char 1 71
char 1 95
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 105
char 1 116
char 1 105
char 1 111
char 1 110
char 1 83
char 1 110
char 1 97
char 1 112
char 1 115
char 1 104
char 1 111
char 1 116
char 1 58
char 1 32
char 1 78
char 1 85
char 1 76
char 1 76
char 1 32
char 1 99
char 1 103
char 1 46
char 1 110
char 1 101
char 1 120
char 1 116
char 1 83
char 1 110
char 1 97
char 1 112
char 1 0
align 1
LABELV $151
char 1 67
char 1 71
char 1 95
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 105
char 1 116
char 1 105
char 1 111
char 1 110
char 1 83
char 1 110
char 1 97
char 1 112
char 1 115
char 1 104
char 1 111
char 1 116
char 1 58
char 1 32
char 1 78
char 1 85
char 1 76
char 1 76
char 1 32
char 1 99
char 1 103
char 1 46
char 1 115
char 1 110
char 1 97
char 1 112
char 1 0
