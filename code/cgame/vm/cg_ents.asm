export CG_PositionEntityOnTag
code
proc CG_PositionEntityOnTag 96 24
file "../cg_ents.c"
line 26
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_ents.c -- present snapshot entities, happens every single frame
;4:
;5:#include "cg_local.h"
;6:/*
;7:Ghoul2 Insert Start
;8:*/
;9:#include "..\game\q_shared.h"
;10:#include "..\ghoul2\g2.h"
;11:/*
;12:Ghoul2 Insert end
;13:*/
;14:
;15:static void CG_Missile( centity_t *cent );
;16:
;17:/*
;18:======================
;19:CG_PositionEntityOnTag
;20:
;21:Modifies the entities position and axis by the given
;22:tag location
;23:======================
;24:*/
;25:void CG_PositionEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;26:							qhandle_t parentModel, char *tagName ) {
line 31
;27:	int				i;
;28:	orientation_t	lerped;
;29:	
;30:	// lerp the tag
;31:	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 52
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 35
;32:		1.0 - parent->backlerp, tagName );
;33:
;34:	// FIXME: allow origin offsets along tag?
;35:	VectorCopy( parent->origin, entity->origin );
ADDRLP4 56
CNSTI4 52
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 36
;36:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $121
line 37
;37:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 64
CNSTI4 12
ASGNI4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 64
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ASGNP4
ADDRLP4 76
CNSTI4 12
ASGNI4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 76
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 88
CNSTI4 12
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 88
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 38
;38:	}
LABELV $122
line 36
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $121
line 41
;39:
;40:	// had to cast away the const to avoid compiler problems...
;41:	MatrixMultiply( lerped.axis, ((refEntity_t *)parent)->axis, entity->axis );
ADDRLP4 4+12
ARGP4
ADDRLP4 60
CNSTI4 12
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 42
;42:	entity->backlerp = parent->backlerp;
ADDRLP4 64
CNSTI4 128
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 43
;43:}
LABELV $120
endproc CG_PositionEntityOnTag 96 24
export CG_PositionRotatedEntityOnTag
proc CG_PositionRotatedEntityOnTag 132 24
line 55
;44:
;45:
;46:/*
;47:======================
;48:CG_PositionRotatedEntityOnTag
;49:
;50:Modifies the entities position and axis by the given
;51:tag location
;52:======================
;53:*/
;54:void CG_PositionRotatedEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;55:							qhandle_t parentModel, char *tagName ) {
line 62
;56:	int				i;
;57:	orientation_t	lerped;
;58:	vec3_t			tempAxis[3];
;59:
;60://AxisClear( entity->axis );
;61:	// lerp the tag
;62:	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 88
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 66
;63:		1.0 - parent->backlerp, tagName );
;64:
;65:	// FIXME: allow origin offsets along tag?
;66:	VectorCopy( parent->origin, entity->origin );
ADDRLP4 92
CNSTI4 52
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 67
;67:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $127
line 68
;68:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 100
CNSTI4 12
ASGNI4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRF4
ADDRLP4 100
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ASGNP4
ADDRLP4 112
CNSTI4 12
ASGNI4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 112
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 124
CNSTI4 12
ASGNI4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRF4
ADDRLP4 124
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 69
;69:	}
LABELV $128
line 67
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $127
line 72
;70:
;71:	// had to cast away the const to avoid compiler problems...
;72:	MatrixMultiply( entity->axis, lerped.axis, tempAxis );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 73
;73:	MatrixMultiply( tempAxis, ((refEntity_t *)parent)->axis, entity->axis );
ADDRLP4 52
ARGP4
ADDRLP4 96
CNSTI4 12
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 96
INDIRI4
ADDP
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 74
;74:}
LABELV $126
endproc CG_PositionRotatedEntityOnTag 132 24
export CG_SetEntitySoundPosition
proc CG_SetEntitySoundPosition 24 8
line 93
;75:
;76:
;77:
;78:/*
;79:==========================================================================
;80:
;81:FUNCTIONS CALLED EACH FRAME
;82:
;83:==========================================================================
;84:*/
;85:
;86:/*
;87:======================
;88:CG_SetEntitySoundPosition
;89:
;90:Also called by event processing code
;91:======================
;92:*/
;93:void CG_SetEntitySoundPosition( centity_t *cent ) {
line 94
;94:	if ( cent->currentState.solid == SOLID_BMODEL )
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $133
line 95
;95:	{
line 99
;96:		vec3_t	origin;
;97:		float	*v;
;98:
;99:		v = cgs.inlineModelMidpoints[ cent->currentState.modelindex ];
ADDRLP4 12
CNSTI4 12
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+39936
ADDP4
ASGNP4
line 100
;100:		VectorAdd( cent->lerpOrigin, v, origin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 928
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
CNSTI4 932
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 101
;101:		trap_S_UpdateEntityPosition( cent->currentState.number, origin );
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_S_UpdateEntityPosition
CALLV
pop
line 102
;102:	}
ADDRGP4 $134
JUMPV
LABELV $133
line 104
;103:	else
;104:	{
line 105
;105:		trap_S_UpdateEntityPosition( cent->currentState.number, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 trap_S_UpdateEntityPosition
CALLV
pop
line 106
;106:	}
LABELV $134
line 107
;107:}
LABELV $132
endproc CG_SetEntitySoundPosition 24 8
proc CG_EntityEffects 28 20
line 116
;108:
;109:/*
;110:==================
;111:CG_EntityEffects
;112:
;113:Add continuous entity effects, like local entity emission and lighting
;114:==================
;115:*/
;116:static void CG_EntityEffects( centity_t *cent ) {
line 119
;117:
;118:	// update sound origins
;119:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 122
;120:
;121:	// add loop sound
;122:	if ( cent->currentState.loopSound ) {
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 0
EQI4 $139
line 124
;123:		//rww - doors and things with looping sounds have a crazy origin (being brush models and all)
;124:		if ( cent->currentState.solid == SOLID_BMODEL )
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $141
line 125
;125:		{
line 129
;126:			vec3_t	origin;
;127:			float	*v;
;128:
;129:			v = cgs.inlineModelMidpoints[ cent->currentState.modelindex ];
ADDRLP4 12
CNSTI4 12
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+39936
ADDP4
ASGNP4
line 130
;130:			VectorAdd( cent->lerpOrigin, v, origin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 928
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
CNSTI4 932
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 131
;131:			trap_S_AddLoopingSound( cent->currentState.number, origin, vec3_origin, 
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37372
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 133
;132:				cgs.gameSounds[ cent->currentState.loopSound ] );
;133:		}
ADDRGP4 $142
JUMPV
LABELV $141
line 134
;134:		else if (cent->currentState.eType != ET_SPEAKER) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
EQI4 $147
line 135
;135:			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37372
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 137
;136:				cgs.gameSounds[ cent->currentState.loopSound ] );
;137:		} else {
ADDRGP4 $148
JUMPV
LABELV $147
line 138
;138:			trap_S_AddRealLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37372
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddRealLoopingSound
CALLV
pop
line 140
;139:				cgs.gameSounds[ cent->currentState.loopSound ] );
;140:		}
LABELV $148
LABELV $142
line 141
;141:	}
LABELV $139
line 145
;142:
;143:
;144:	// constant light glow
;145:	if ( cent->currentState.constantLight ) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
EQI4 $151
line 149
;146:		int		cl;
;147:		int		i, r, g, b;
;148:
;149:		cl = cent->currentState.constantLight;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 150
;150:		r = cl & 255;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 151
;151:		g = ( cl >> 8 ) & 255;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 152
;152:		b = ( cl >> 16 ) & 255;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 153
;153:		i = ( ( cl >> 24 ) & 255 ) * 4;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 255
BANDI4
CNSTI4 2
LSHI4
ASGNI4
line 154
;154:		trap_R_AddLightToScene( cent->lerpOrigin, i, r, g, b );
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 155
;155:	}
LABELV $151
line 157
;156:
;157:}
LABELV $138
endproc CG_EntityEffects 28 20
export FX_AddOrientedLine
proc FX_AddOrientedLine 16 8
line 161
;158:
;159:localEntity_t *FX_AddOrientedLine(vec3_t start, vec3_t end, vec3_t normal, float stScale, float scale,
;160:								  float dscale, float startalpha, float endalpha, float killTime, qhandle_t shader)
;161:{
line 171
;162:	localEntity_t	*le;
;163:	
;164:#ifdef _DEBUG
;165:	if (!shader)
;166:	{
;167:		Com_Printf("FX_AddLine: NULL shader\n");
;168:	}
;169:#endif
;170:
;171:	le = CG_AllocLocalEntity();
ADDRLP4 4
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 172
;172:	le->leType = LE_OLINE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 11
ASGNI4
line 174
;173:
;174:	le->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 175
;175:	le->endTime = le->startTime + killTime;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ADDRFP4 32
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 176
;176:	le->data.line.width = scale;
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 177
;177:	le->data.line.dwidth = dscale;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
ADDRFP4 20
INDIRF4
ASGNF4
line 179
;178:
;179:	le->alpha = startalpha;
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRFP4 24
INDIRF4
ASGNF4
line 180
;180:	le->dalpha = endalpha - startalpha;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRFP4 28
INDIRF4
ADDRFP4 24
INDIRF4
SUBF4
ASGNF4
line 182
;181:
;182:	le->refEntity.data.line.stscale = stScale;
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
ADDRFP4 12
INDIRF4
ASGNF4
line 183
;183:	le->refEntity.data.line.width = scale;
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 185
;184:
;185:	le->refEntity.customShader = shader;
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
ADDRFP4 36
INDIRI4
ASGNI4
line 188
;186:
;187:	// set origin
;188:	VectorCopy ( start, le->refEntity.origin);
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 189
;189:	VectorCopy ( end, le->refEntity.oldorigin );
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 191
;190:
;191:	AxisClear(le->refEntity.axis);
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 192
;192:	VectorCopy( normal, le->refEntity.axis[0] );
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 193
;193:	RotateAroundDirection( le->refEntity.axis, 0); // le->refEntity.data.sprite.rotation );	This is roll in quad land
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 195
;194:
;195:	le->refEntity.shaderRGBA[0] = 0xff;
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
CNSTU1 255
ASGNU1
line 196
;196:	le->refEntity.shaderRGBA[1] = 0xff;
ADDRLP4 0
INDIRP4
CNSTI4 329
ADDP4
CNSTU1 255
ASGNU1
line 197
;197:	le->refEntity.shaderRGBA[2] = 0xff;
ADDRLP4 0
INDIRP4
CNSTI4 330
ADDP4
CNSTU1 255
ASGNU1
line 198
;198:	le->refEntity.shaderRGBA[3] = 0xff;
ADDRLP4 0
INDIRP4
CNSTI4 331
ADDP4
CNSTU1 255
ASGNU1
line 200
;199:
;200:	le->color[0] = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 1065353216
ASGNF4
line 201
;201:	le->color[1] = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTF4 1065353216
ASGNF4
line 202
;202:	le->color[2] = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1065353216
ASGNF4
line 203
;203:	le->color[3] = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 136
ADDP4
CNSTF4 1065353216
ASGNF4
line 204
;204:	le->lifeRate = 1.0 / ( le->endTime - le->startTime );
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1065353216
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 206
;205:
;206:	return(le);
ADDRLP4 0
INDIRP4
RETP4
LABELV $153
endproc FX_AddOrientedLine 16 8
export FX_DrawPortableShield
proc FX_DrawPortableShield 1104 40
line 210
;207:}
;208:
;209:void FX_DrawPortableShield(centity_t *cent)
;210:{
line 220
;211:	//rww - this code differs a bit from the draw code in EF, I don't know why I had to do
;212:	//it this way yet it worked in EF the other way.
;213:
;214:	int				xaxis, height, posWidth, negWidth, team;
;215:	vec3_t			start, end, normal;
;216:	localEntity_t	*le;
;217:	qhandle_t		shader;
;218:	char			buf[1024];
;219:
;220:	trap_Cvar_VariableStringBuffer("cl_paused", buf, sizeof(buf));
ADDRGP4 $156
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 222
;221:
;222:	if (atoi(buf))
ADDRLP4 40
ARGP4
ADDRLP4 1088
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
EQI4 $157
line 223
;223:	{ //rww - fix to keep from rendering repeatedly while HUD menu is up
line 224
;224:		return;
ADDRGP4 $155
JUMPV
LABELV $157
line 227
;225:	}
;226:
;227:	if (cent->currentState.eFlags & EF_NODRAW)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $159
line 228
;228:	{
line 229
;229:		return;
ADDRGP4 $155
JUMPV
LABELV $159
line 233
;230:	}
;231:
;232:	// decode the data stored in time2
;233:	xaxis = ((cent->currentState.time2 >> 24) & 1);
ADDRLP4 1064
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 234
;234:	height = ((cent->currentState.time2 >> 16) & 255);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 235
;235:	posWidth = ((cent->currentState.time2 >> 8) & 255);
ADDRLP4 1068
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 236
;236:	negWidth = (cent->currentState.time2 & 255);
ADDRLP4 1072
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 238
;237:
;238:	team = (cent->currentState.otherEntityNum2);
ADDRLP4 1076
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 240
;239:
;240:	VectorClear(normal);
ADDRLP4 1092
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 1092
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1092
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 1092
INDIRF4
ASGNF4
line 242
;241:
;242:	VectorCopy(cent->lerpOrigin, start);
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 243
;243:	VectorCopy(cent->lerpOrigin, end);
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 245
;244:
;245:	if (xaxis) // drawing along x-axis
ADDRLP4 1064
INDIRI4
CNSTI4 0
EQI4 $163
line 246
;246:	{
line 247
;247:		start[0] -= negWidth;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 1072
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 248
;248:		end[0] += posWidth;
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 1068
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 249
;249:	}
ADDRGP4 $164
JUMPV
LABELV $163
line 251
;250:	else
;251:	{
line 252
;252:		start[1] -= negWidth;
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 1072
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 253
;253:		end[1] += posWidth;
ADDRLP4 28+4
ADDRLP4 28+4
INDIRF4
ADDRLP4 1068
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 254
;254:	}
LABELV $164
line 256
;255:
;256:	normal[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 257
;257:	normal[1] = 1;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 259
;258:
;259:	start[2] += height/2;
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
ADDF4
ASGNF4
line 260
;260:	end[2] += height/2;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
ADDF4
ASGNF4
line 262
;261:
;262:	if (team == TEAM_RED)
ADDRLP4 1076
INDIRI4
CNSTI4 1
NEI4 $170
line 263
;263:	{
line 264
;264:		if (cent->currentState.trickedentindex)
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
EQI4 $172
line 265
;265:		{
line 266
;266:			shader = trap_R_RegisterShader( "gfx/misc/red_dmgshield" );
ADDRGP4 $174
ARGP4
ADDRLP4 1096
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 1080
ADDRLP4 1096
INDIRI4
ASGNI4
line 267
;267:		}
ADDRGP4 $171
JUMPV
LABELV $172
line 269
;268:		else
;269:		{
line 270
;270:			shader = trap_R_RegisterShader( "gfx/misc/red_portashield" );
ADDRGP4 $175
ARGP4
ADDRLP4 1096
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 1080
ADDRLP4 1096
INDIRI4
ASGNI4
line 271
;271:		}
line 272
;272:	}
ADDRGP4 $171
JUMPV
LABELV $170
line 274
;273:	else
;274:	{
line 275
;275:		if (cent->currentState.trickedentindex)
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
EQI4 $176
line 276
;276:		{
line 277
;277:			shader = trap_R_RegisterShader( "gfx/misc/blue_dmgshield" );
ADDRGP4 $178
ARGP4
ADDRLP4 1096
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 1080
ADDRLP4 1096
INDIRI4
ASGNI4
line 278
;278:		}
ADDRGP4 $177
JUMPV
LABELV $176
line 280
;279:		else
;280:		{
line 281
;281:			shader = trap_R_RegisterShader( "gfx/misc/blue_portashield" );
ADDRGP4 $179
ARGP4
ADDRLP4 1096
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 1080
ADDRLP4 1096
INDIRI4
ASGNI4
line 282
;282:		}
LABELV $177
line 283
;283:	}
LABELV $171
line 285
;284:
;285:	le = FX_AddOrientedLine(start, end, normal, 1.0f, height, 0.0f, 1.0f, 1.0f, 50.0, shader);
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1096
CNSTF4 1065353216
ASGNF4
ADDRLP4 1096
INDIRF4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 1096
INDIRF4
ARGF4
ADDRLP4 1096
INDIRF4
ARGF4
CNSTF4 1112014848
ARGF4
ADDRLP4 1080
INDIRI4
ARGI4
ADDRLP4 1100
ADDRGP4 FX_AddOrientedLine
CALLP4
ASGNP4
ADDRLP4 1084
ADDRLP4 1100
INDIRP4
ASGNP4
line 286
;286:}
LABELV $155
endproc FX_DrawPortableShield 1104 40
export CG_Special
proc CG_Special 4 4
line 293
;287:
;288:/*
;289:==================
;290:CG_Special
;291:==================
;292:*/
;293:void CG_Special( centity_t *cent ) {
line 296
;294:	entityState_t		*s1;
;295:
;296:	s1 = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 298
;297:
;298:	if (!s1)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $181
line 299
;299:	{
line 300
;300:		return;
ADDRGP4 $180
JUMPV
LABELV $181
line 304
;301:	}
;302:
;303:	// if set to invisible, skip
;304:	if (!s1->modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
NEI4 $183
line 305
;305:		return;
ADDRGP4 $180
JUMPV
LABELV $183
line 308
;306:	}
;307:
;308:	if (s1->modelindex == HI_SHIELD) 
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
NEI4 $185
line 309
;309:	{	// The portable shield should go through a different rendering function.
line 310
;310:		FX_DrawPortableShield(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 FX_DrawPortableShield
CALLV
pop
line 311
;311:		return;
LABELV $185
line 313
;312:	}
;313:}
LABELV $180
endproc CG_Special 4 4
export CG_SetGhoul2Info
proc CG_SetGhoul2Info 0 0
line 321
;314:
;315:/*
;316:Ghoul2 Insert Start
;317:*/
;318:
;319:// Copy the ghoul2 data into the ref ent correctly
;320:void CG_SetGhoul2Info( refEntity_t *ent, centity_t *cent)
;321:{
line 323
;322:
;323:	ent->ghoul2 = cent->ghoul2;
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ASGNP4
line 324
;324:	VectorCopy( cent->modelScale, ent->modelScale);
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 964
ADDP4
INDIRB
ASGNB 12
line 325
;325:	ent->radius = cent->radius;
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRF4
ASGNF4
line 326
;326:	VectorCopy (cent->lerpAngles, ent->angles);
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 327
;327:}
LABELV $187
endproc CG_SetGhoul2Info 0 0
export CG_CreateBBRefEnts
proc CG_CreateBBRefEnts 0 0
line 333
;328:
;329:
;330:
;331:// create 8 new points on screen around a model so we can see it's bounding box
;332:void CG_CreateBBRefEnts(entityState_t *s1, vec3_t origin )
;333:{
line 398
;334:/* 
;335://g2r
;336:#if _DEBUG
;337:	refEntity_t		point[8];
;338:	int				i;
;339:	vec3_t			angles = {0,0,0};
;340:
;341:	for (i=0; i<8; i++)
;342:	{
;343:		memset (&point[i], 0, sizeof(refEntity_t));
;344:		point[i].reType = RT_SPRITE;
;345:		point[i].radius = 1;
;346:		point[i].customShader = trap_R_RegisterShader("textures/tests/circle");
;347:		point[i].shaderRGBA[0] = 255;
;348:		point[i].shaderRGBA[1] = 255;
;349:		point[i].shaderRGBA[2] = 255;
;350:		point[i].shaderRGBA[3] = 255;
;351:
;352:		AnglesToAxis( angles, point[i].axis );
;353:
;354:		// now, we need to put the correct origins into each origin from the mins and max's
;355:		switch(i)
;356:		{
;357:		case 0:
;358:			VectorCopy(s1->mins, point[i].origin);
;359:   			break;
;360:		case 1:
;361:			VectorCopy(s1->mins, point[i].origin);
;362:			point[i].origin[0] = s1->maxs[0];
;363:   			break;
;364:		case 2:
;365:			VectorCopy(s1->mins, point[i].origin);
;366:			point[i].origin[1] = s1->maxs[1];
;367:   			break;
;368:		case 3:
;369:			VectorCopy(s1->mins, point[i].origin);
;370:			point[i].origin[0] = s1->maxs[0];
;371:			point[i].origin[1] = s1->maxs[1];
;372:   			break;
;373:		case 4:
;374:			VectorCopy(s1->maxs, point[i].origin);
;375:   			break;
;376:		case 5:
;377:			VectorCopy(s1->maxs, point[i].origin);
;378:			point[i].origin[0] = s1->mins[0];
;379:   			break;
;380:		case 6:
;381:			VectorCopy(s1->maxs, point[i].origin);
;382:			point[i].origin[1] = s1->mins[1];
;383:   			break;
;384:		case 7:
;385:			VectorCopy(s1->maxs, point[i].origin);
;386:			point[i].origin[0] = s1->mins[0];
;387:			point[i].origin[1] = s1->mins[1];
;388:   			break;
;389:		}
;390:
;391:		// add the original origin to each point and then stuff them out there
;392:		VectorAdd(point[i].origin, origin, point[i].origin);
;393:
;394:		trap_R_AddRefEntityToScene (&point[i]);
;395:	}
;396:#endif
;397:	*/
;398:}
LABELV $188
endproc CG_CreateBBRefEnts 0 0
export G2_BoltToGhoul2Model
proc G2_BoltToGhoul2Model 68 36
line 402
;399:
;400:// write in the axis and stuff
;401:void G2_BoltToGhoul2Model(centity_t *cent, refEntity_t *ent)
;402:{
line 404
;403:		// extract the wraith ID from the bolt info
;404:	int modelNum = cent->boltInfo >> MODEL_SHIFT;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
CNSTI4 10
RSHI4
ASGNI4
line 405
;405:	int boltNum	= cent->boltInfo >> BOLT_SHIFT;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
ASGNI4
line 406
;406:	int	entNum = cent->boltInfo >> ENTITY_SHIFT;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
CNSTI4 20
RSHI4
ASGNI4
line 409
;407: 	mdxaBone_t 		boltMatrix;
;408:	
;409:	modelNum &= MODEL_AND;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1023
BANDI4
ASGNI4
line 410
;410:	boltNum &= BOLT_AND;
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 1023
BANDI4
ASGNI4
line 411
;411:	entNum &= ENTITY_AND;
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 4095
BANDI4
ASGNI4
line 415
;412:
;413:
;414:	//NOTENOTE I put this here because the cgs.gamemodels array no longer gets initialized.
;415:	assert(0);		
line 419
;416:
;417:
;418: 	// go away and get me the bolt position for this frame please
;419:	trap_G2API_GetBoltMatrix(cent->ghoul2, modelNum, boltNum, &boltMatrix, cg_entities[entNum].currentState.angles, cg_entities[entNum].currentState.origin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 64
CNSTI4 1920
ADDRLP4 48
INDIRI4
MULI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRGP4 cg_entities+116
ADDP4
ARGP4
ADDRLP4 64
INDIRI4
ADDRGP4 cg_entities+92
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 422
;420:
;421:	// set up the axis and origin we need for the actual effect spawning
;422: 	ent->origin[0] = boltMatrix.matrix[0][3];
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 0+12
INDIRF4
ASGNF4
line 423
;423: 	ent->origin[1] = boltMatrix.matrix[1][3];
ADDRFP4 4
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 0+16+12
INDIRF4
ASGNF4
line 424
;424: 	ent->origin[2] = boltMatrix.matrix[2][3];
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 0+32+12
INDIRF4
ASGNF4
line 426
;425:
;426: 	ent->axis[0][0] = boltMatrix.matrix[0][0];
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
line 427
;427: 	ent->axis[0][1] = boltMatrix.matrix[1][0];
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0+16
INDIRF4
ASGNF4
line 428
;428: 	ent->axis[0][2] = boltMatrix.matrix[2][0];
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0+32
INDIRF4
ASGNF4
line 430
;429:
;430: 	ent->axis[1][0] = boltMatrix.matrix[0][1];
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 0+4
INDIRF4
ASGNF4
line 431
;431: 	ent->axis[1][1] = boltMatrix.matrix[1][1];
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 0+16+4
INDIRF4
ASGNF4
line 432
;432: 	ent->axis[1][2] = boltMatrix.matrix[2][1];
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 0+32+4
INDIRF4
ASGNF4
line 434
;433:
;434: 	ent->axis[2][0] = boltMatrix.matrix[0][2];
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0+8
INDIRF4
ASGNF4
line 435
;435: 	ent->axis[2][1] = boltMatrix.matrix[1][2];
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+16+8
INDIRF4
ASGNF4
line 436
;436: 	ent->axis[2][2] = boltMatrix.matrix[2][2];
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+32+8
INDIRF4
ASGNF4
line 437
;437:}
LABELV $189
endproc G2_BoltToGhoul2Model 68 36
export ScaleModelAxis
proc ScaleModelAxis 36 0
line 441
;438:
;439:void ScaleModelAxis(refEntity_t	*ent)
;440:
;441:{		// scale the model should we need to
line 442
;442:		if (ent->modelScale[0] && ent->modelScale[0] != 1.0f)
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $212
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $212
line 443
;443:		{
line 444
;444:			VectorScale( ent->axis[0], ent->modelScale[0] , ent->axis[0] );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
MULF4
ASGNF4
line 445
;445:			ent->nonNormalizedAxes = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 1
ASGNI4
line 446
;446:		}
LABELV $212
line 447
;447:		if (ent->modelScale[1] && ent->modelScale[1] != 1.0f)
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $214
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
EQF4 $214
line 448
;448:		{
line 449
;449:			VectorScale( ent->axis[1], ent->modelScale[1] , ent->axis[1] );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
MULF4
ASGNF4
line 450
;450:			ent->nonNormalizedAxes = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 1
ASGNI4
line 451
;451:		}
LABELV $214
line 452
;452:		if (ent->modelScale[2] && ent->modelScale[2] != 1.0f)
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
INDIRF4
CNSTF4 0
EQF4 $216
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
EQF4 $216
line 453
;453:		{
line 454
;454:			VectorScale( ent->axis[2], ent->modelScale[2] , ent->axis[2] );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
MULF4
ASGNF4
line 455
;455:			ent->nonNormalizedAxes = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 1
ASGNI4
line 456
;456:		}
LABELV $216
line 457
;457:}
LABELV $211
endproc ScaleModelAxis 36 0
data
export forceHolocronModels
align 4
LABELV forceHolocronModels
address $218
address $219
address $220
address $221
address $222
address $223
address $224
address $225
address $226
address $227
address $228
address $229
address $230
address $231
address $232
address $233
address $234
address $235
code
proc CG_General 464 44
line 488
;458:/*
;459:Ghoul2 Insert End
;460:*/
;461:
;462:char *forceHolocronModels[] = {
;463:	"models/map_objects/mp/lt_heal.md3",		//FP_HEAL,
;464:	"models/map_objects/mp/force_jump.md3",		//FP_LEVITATION,
;465:	"models/map_objects/mp/force_speed.md3",	//FP_SPEED,
;466:	"models/map_objects/mp/force_push.md3",		//FP_PUSH,
;467:	"models/map_objects/mp/force_pull.md3",		//FP_PULL,
;468:	"models/map_objects/mp/lt_telepathy.md3",	//FP_TELEPATHY,
;469:	"models/map_objects/mp/dk_grip.md3",		//FP_GRIP,
;470:	"models/map_objects/mp/dk_lightning.md3",	//FP_LIGHTNING,
;471:	"models/map_objects/mp/dk_rage.md3",		//FP_RAGE,
;472:	"models/map_objects/mp/lt_protect.md3",		//FP_PROTECT,
;473:	"models/map_objects/mp/lt_absorb.md3",		//FP_ABSORB,
;474:	"models/map_objects/mp/lt_healother.md3",	//FP_TEAM_HEAL,
;475:	"models/map_objects/mp/dk_powerother.md3",	//FP_TEAM_FORCE,
;476:	"models/map_objects/mp/dk_drain.md3",		//FP_DRAIN,
;477:	"models/map_objects/mp/force_sight.md3",	//FP_SEE,
;478:	"models/map_objects/mp/saber_attack.md3",	//FP_SABERATTACK,
;479:	"models/map_objects/mp/saber_defend.md3",	//FP_SABERDEFEND,
;480:	"models/map_objects/mp/saber_throw.md3"		//FP_SABERTHROW
;481:};
;482:
;483:/*
;484:==================
;485:CG_General
;486:==================
;487:*/
;488:static void CG_General( centity_t *cent ) {
line 496
;489:	refEntity_t			ent;
;490:	entityState_t		*s1;
;491:	float				val;
;492:	int					beamID;
;493:	vec3_t				beamOrg;
;494:	mdxaBone_t			matrix;
;495:
;496:	if (cent->currentState.modelGhoul2 == 127)
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 127
NEI4 $237
line 497
;497:	{ //not ready to be drawn or initialized..
line 498
;498:		return;
ADDRGP4 $236
JUMPV
LABELV $237
line 501
;499:	}
;500:
;501:	if (cent->ghoul2 && !cent->currentState.modelGhoul2 && cent->currentState.eType != ET_BODY &&
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $239
ADDRLP4 284
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $239
ADDRLP4 284
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 15
EQI4 $239
ADDRLP4 284
INDIRP4
INDIRI4
CNSTI4 32
LTI4 $239
line 503
;502:		cent->currentState.number >= MAX_CLIENTS)
;503:	{ //this is a bad thing
line 504
;504:		if (trap_G2_HaveWeGhoul2Models(cent->ghoul2))
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 288
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $241
line 505
;505:		{
line 506
;506:			trap_G2API_CleanGhoul2Models(&(cent->ghoul2));
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 507
;507:		}
LABELV $241
line 508
;508:	}
LABELV $239
line 510
;509:
;510:	if (cent->currentState.modelGhoul2 >= G2_MODELPART_HEAD &&
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
ADDRLP4 288
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 10
LTI4 $243
ADDRLP4 292
INDIRI4
CNSTI4 15
GTI4 $243
ADDRLP4 288
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 32
GEI4 $243
ADDRLP4 288
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 50
NEI4 $243
line 514
;511:		cent->currentState.modelGhoul2 <= G2_MODELPART_RLEG &&
;512:		cent->currentState.modelindex < MAX_CLIENTS &&
;513:		cent->currentState.weapon == G2_MODEL_PART)
;514:	{ //special case for client limbs
line 515
;515:		centity_t *clEnt = &cg_entities[cent->currentState.modelindex];
ADDRLP4 296
CNSTI4 1920
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 516
;516:		int dismember_settings = cg_dismember.integer;
ADDRLP4 300
ADDRGP4 cg_dismember+12
INDIRI4
ASGNI4
line 518
;517:
;518:		if (!dismember_settings)
ADDRLP4 300
INDIRI4
CNSTI4 0
NEI4 $246
line 519
;519:		{ //This client does not wish to see dismemberment.
line 520
;520:			return;
ADDRGP4 $236
JUMPV
LABELV $246
line 523
;521:		}
;522:
;523:		if (dismember_settings < 2 && (cent->currentState.modelGhoul2 == G2_MODELPART_HEAD || cent->currentState.modelGhoul2 == G2_MODELPART_WAIST))
ADDRLP4 300
INDIRI4
CNSTI4 2
GEI4 $248
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 10
EQI4 $250
ADDRLP4 304
INDIRI4
CNSTI4 11
NEI4 $248
LABELV $250
line 524
;524:		{ //dismember settings are not high enough to display decaps and torso slashes
line 525
;525:			return;
ADDRGP4 $236
JUMPV
LABELV $248
line 528
;526:		}
;527:
;528:		if (!cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $251
line 529
;529:		{
line 540
;530:			const char *limbBone;
;531:			const char *rotateBone;
;532:			char *limbName;
;533:			char *limbCapName;
;534:			char *stubCapName;
;535:			char *limbTagName;
;536:			char *stubTagName;
;537:			int limb_anim;
;538:			int newBolt;
;539:
;540:			if (clEnt && clEnt->torsoBolt)
ADDRLP4 296
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $253
ADDRLP4 296
INDIRP4
CNSTI4 1012
ADDP4
INDIRI4
CNSTI4 0
EQI4 $253
line 541
;541:			{ //already have a limb missing!
line 542
;542:				return;
ADDRGP4 $236
JUMPV
LABELV $253
line 546
;543:			}
;544:
;545:
;546:			if (clEnt && !(clEnt->currentState.eFlags & EF_DEAD))
ADDRLP4 296
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $255
ADDRLP4 296
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $255
line 547
;547:			{ //death flag hasn't made it through yet for the limb owner, we cannot create the limb until he's flagged as dead
line 548
;548:				return;
ADDRGP4 $236
JUMPV
LABELV $255
line 551
;549:			}
;550:
;551:			cent->bolt4 = -1;
ADDRFP4 0
INDIRP4
CNSTI4 996
ADDP4
CNSTI4 -1
ASGNI4
line 552
;552:			cent->trailTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 554
;553:
;554:			switch (cent->currentState.modelGhoul2)
ADDRLP4 352
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 10
LTI4 $257
ADDRLP4 352
INDIRI4
CNSTI4 15
GTI4 $257
ADDRLP4 352
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $308-40
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $308
address $260
address $268
address $276
address $284
address $292
address $300
code
line 555
;555:			{
LABELV $260
line 557
;556:			case G2_MODELPART_HEAD:
;557:				limbBone = "cervical";
ADDRLP4 340
ADDRGP4 $261
ASGNP4
line 558
;558:				rotateBone = "cranium";
ADDRLP4 316
ADDRGP4 $262
ASGNP4
line 559
;559:				limbName = "head";
ADDRLP4 312
ADDRGP4 $263
ASGNP4
line 560
;560:				limbCapName = "head_cap_torso_off";
ADDRLP4 320
ADDRGP4 $264
ASGNP4
line 561
;561:				stubCapName = "torso_cap_head_off";
ADDRLP4 324
ADDRGP4 $265
ASGNP4
line 562
;562:				limbTagName = "*head_cap_torso";
ADDRLP4 328
ADDRGP4 $266
ASGNP4
line 563
;563:				stubTagName = "*torso_cap_head";
ADDRLP4 332
ADDRGP4 $267
ASGNP4
line 564
;564:				limb_anim = BOTH_DISMEMBER_HEAD1;
ADDRLP4 336
CNSTI4 80
ASGNI4
line 565
;565:				break;
ADDRGP4 $258
JUMPV
LABELV $268
line 567
;566:			case G2_MODELPART_WAIST:
;567:				limbBone = "pelvis";
ADDRLP4 340
ADDRGP4 $269
ASGNP4
line 568
;568:				rotateBone = "thoracic";
ADDRLP4 316
ADDRGP4 $270
ASGNP4
line 569
;569:				limbName = "torso";
ADDRLP4 312
ADDRGP4 $271
ASGNP4
line 570
;570:				limbCapName = "torso_cap_hips_off";
ADDRLP4 320
ADDRGP4 $272
ASGNP4
line 571
;571:				stubCapName = "hips_cap_torso_off";
ADDRLP4 324
ADDRGP4 $273
ASGNP4
line 572
;572:				limbTagName = "*torso_cap_hips";
ADDRLP4 328
ADDRGP4 $274
ASGNP4
line 573
;573:				stubTagName = "*hips_cap_torso";
ADDRLP4 332
ADDRGP4 $275
ASGNP4
line 574
;574:				limb_anim = BOTH_DISMEMBER_TORSO1;
ADDRLP4 336
CNSTI4 81
ASGNI4
line 575
;575:				break;
ADDRGP4 $258
JUMPV
LABELV $276
line 577
;576:			case G2_MODELPART_LARM:
;577:				limbBone = "lhumerus";
ADDRLP4 340
ADDRGP4 $277
ASGNP4
line 578
;578:				rotateBone = "lradius";
ADDRLP4 316
ADDRGP4 $278
ASGNP4
line 579
;579:				limbName = "l_arm";
ADDRLP4 312
ADDRGP4 $279
ASGNP4
line 580
;580:				limbCapName = "l_arm_cap_torso_off";
ADDRLP4 320
ADDRGP4 $280
ASGNP4
line 581
;581:				stubCapName = "torso_cap_l_arm_off";
ADDRLP4 324
ADDRGP4 $281
ASGNP4
line 582
;582:				limbTagName = "*l_arm_cap_torso";
ADDRLP4 328
ADDRGP4 $282
ASGNP4
line 583
;583:				stubTagName = "*torso_cap_l_arm";
ADDRLP4 332
ADDRGP4 $283
ASGNP4
line 584
;584:				limb_anim = BOTH_DISMEMBER_LARM;
ADDRLP4 336
CNSTI4 85
ASGNI4
line 585
;585:				break;
ADDRGP4 $258
JUMPV
LABELV $284
line 587
;586:			case G2_MODELPART_RARM:
;587:				limbBone = "rhumerus";
ADDRLP4 340
ADDRGP4 $285
ASGNP4
line 588
;588:				rotateBone = "rradius";
ADDRLP4 316
ADDRGP4 $286
ASGNP4
line 589
;589:				limbName = "r_arm";
ADDRLP4 312
ADDRGP4 $287
ASGNP4
line 590
;590:				limbCapName = "r_arm_cap_torso_off";
ADDRLP4 320
ADDRGP4 $288
ASGNP4
line 591
;591:				stubCapName = "torso_cap_r_arm_off";
ADDRLP4 324
ADDRGP4 $289
ASGNP4
line 592
;592:				limbTagName = "*r_arm_cap_torso";
ADDRLP4 328
ADDRGP4 $290
ASGNP4
line 593
;593:				stubTagName = "*torso_cap_r_arm";
ADDRLP4 332
ADDRGP4 $291
ASGNP4
line 594
;594:				limb_anim = BOTH_DISMEMBER_RARM;
ADDRLP4 336
CNSTI4 84
ASGNI4
line 595
;595:				break;
ADDRGP4 $258
JUMPV
LABELV $292
line 597
;596:			case G2_MODELPART_LLEG:
;597:				limbBone = "lfemurYZ";
ADDRLP4 340
ADDRGP4 $293
ASGNP4
line 598
;598:				rotateBone = "ltibia";
ADDRLP4 316
ADDRGP4 $294
ASGNP4
line 599
;599:				limbName = "l_leg";
ADDRLP4 312
ADDRGP4 $295
ASGNP4
line 600
;600:				limbCapName = "l_leg_cap_hips_off";
ADDRLP4 320
ADDRGP4 $296
ASGNP4
line 601
;601:				stubCapName = "hips_cap_l_leg_off";
ADDRLP4 324
ADDRGP4 $297
ASGNP4
line 602
;602:				limbTagName = "*l_leg_cap_hips";
ADDRLP4 328
ADDRGP4 $298
ASGNP4
line 603
;603:				stubTagName = "*hips_cap_l_leg";
ADDRLP4 332
ADDRGP4 $299
ASGNP4
line 604
;604:				limb_anim = BOTH_DISMEMBER_LLEG;
ADDRLP4 336
CNSTI4 82
ASGNI4
line 605
;605:				break;
ADDRGP4 $258
JUMPV
LABELV $300
line 607
;606:			case G2_MODELPART_RLEG:
;607:				limbBone = "rfemurYZ";
ADDRLP4 340
ADDRGP4 $301
ASGNP4
line 608
;608:				rotateBone = "rtibia";
ADDRLP4 316
ADDRGP4 $302
ASGNP4
line 609
;609:				limbName = "r_leg";
ADDRLP4 312
ADDRGP4 $303
ASGNP4
line 610
;610:				limbCapName = "r_leg_cap_hips_off";
ADDRLP4 320
ADDRGP4 $304
ASGNP4
line 611
;611:				stubCapName = "hips_cap_r_leg_off";
ADDRLP4 324
ADDRGP4 $305
ASGNP4
line 612
;612:				limbTagName = "*r_leg_cap_hips";
ADDRLP4 328
ADDRGP4 $306
ASGNP4
line 613
;613:				stubTagName = "*hips_cap_r_leg";
ADDRLP4 332
ADDRGP4 $307
ASGNP4
line 614
;614:				limb_anim = BOTH_DISMEMBER_RLEG;
ADDRLP4 336
CNSTI4 83
ASGNI4
line 615
;615:				break;
ADDRGP4 $258
JUMPV
LABELV $257
line 617
;616:			default:
;617:				limbBone = "rfemurYZ";
ADDRLP4 340
ADDRGP4 $301
ASGNP4
line 618
;618:				rotateBone = "rtibia";
ADDRLP4 316
ADDRGP4 $302
ASGNP4
line 619
;619:				limbName = "r_leg";
ADDRLP4 312
ADDRGP4 $303
ASGNP4
line 620
;620:				limbCapName = "r_leg_cap_hips_off";
ADDRLP4 320
ADDRGP4 $304
ASGNP4
line 621
;621:				stubCapName = "hips_cap_r_leg_off";
ADDRLP4 324
ADDRGP4 $305
ASGNP4
line 622
;622:				limbTagName = "*r_leg_cap_hips";
ADDRLP4 328
ADDRGP4 $306
ASGNP4
line 623
;623:				stubTagName = "*hips_cap_r_leg";
ADDRLP4 332
ADDRGP4 $307
ASGNP4
line 624
;624:				limb_anim = BOTH_DISMEMBER_RLEG;
ADDRLP4 336
CNSTI4 83
ASGNI4
line 625
;625:				break;
LABELV $258
line 628
;626:			}
;627:
;628:			if (clEnt && clEnt->ghoul2)
ADDRLP4 364
CNSTU4 0
ASGNU4
ADDRLP4 296
INDIRP4
CVPU4 4
ADDRLP4 364
INDIRU4
EQU4 $310
ADDRLP4 296
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 364
INDIRU4
EQU4 $310
line 629
;629:			{
line 630
;630:				animation_t		*anim = NULL;
ADDRLP4 368
CNSTP4 0
ASGNP4
line 632
;631:				float			animSpeed;
;632:				int				flags=BONE_ANIM_OVERRIDE_FREEZE;
ADDRLP4 372
CNSTI4 72
ASGNI4
line 635
;633:				clientInfo_t	*ci;
;634:
;635:				ci = &cgs.clientinfo[ clEnt->currentState.number ];
ADDRLP4 376
CNSTI4 788
ADDRLP4 296
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 637
;636:
;637:				if (ci)
ADDRLP4 376
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $313
line 638
;638:				{
line 646
;639:					/*
;640:					if (cent->currentState.modelGhoul2 == G2_MODELPART_WAIST)
;641:					{
;642:						anim = &ci->animations[ cent->currentState.modelindex2 ];
;643:					}
;644:					else
;645:					*/
;646:					{
line 647
;647:						anim = &bgGlobalAnimations[ limb_anim ];
ADDRLP4 368
CNSTI4 28
ADDRLP4 336
INDIRI4
MULI4
ADDRGP4 bgGlobalAnimations
ADDP4
ASGNP4
line 648
;648:					}
line 649
;649:				}
LABELV $313
line 651
;650:
;651:				trap_G2API_DuplicateGhoul2Instance(clEnt->ghoul2, &cent->ghoul2);
ADDRLP4 384
CNSTI4 952
ASGNI4
ADDRLP4 296
INDIRP4
ADDRLP4 384
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 384
INDIRI4
ADDP4
ARGP4
ADDRGP4 trap_G2API_DuplicateGhoul2Instance
CALLV
pop
line 653
;652:
;653:				if (anim)
ADDRLP4 368
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $315
line 654
;654:				{
line 655
;655:					animSpeed = 50.0f / anim->frameLerp;
ADDRLP4 380
CNSTF4 1112014848
ADDRLP4 368
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 657
;656:
;657:					if (cent->currentState.modelGhoul2 == G2_MODELPART_WAIST)
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 11
NEI4 $317
line 658
;658:					{
line 659
;659:						trap_G2API_SetBoneAnim(cent->ghoul2, 0, "upper_lumbar", anim->firstFrame, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, 0);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 388
CNSTI4 0
ASGNI4
ADDRLP4 388
INDIRI4
ARGI4
ADDRGP4 $319
ARGP4
ADDRLP4 392
ADDRLP4 368
INDIRP4
ASGNP4
ADDRLP4 396
ADDRLP4 392
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 396
INDIRI4
ARGI4
ADDRLP4 396
INDIRI4
ADDRLP4 392
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 372
INDIRI4
ARGI4
ADDRLP4 380
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRLP4 388
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 660
;660:						trap_G2API_SetBoneAnim(cent->ghoul2, 0, "model_root", anim->firstFrame, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, 0);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 400
CNSTI4 0
ASGNI4
ADDRLP4 400
INDIRI4
ARGI4
ADDRGP4 $321
ARGP4
ADDRLP4 404
ADDRLP4 368
INDIRP4
ASGNP4
ADDRLP4 408
ADDRLP4 404
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 408
INDIRI4
ARGI4
ADDRLP4 408
INDIRI4
ADDRLP4 404
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 372
INDIRI4
ARGI4
ADDRLP4 380
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRLP4 400
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 661
;661:					}
ADDRGP4 $318
JUMPV
LABELV $317
line 663
;662:					else
;663:					{
line 664
;664:						trap_G2API_SetBoneAnim(cent->ghoul2, 0, "upper_lumbar", anim->firstFrame + anim->numFrames-1, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, 0);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 388
CNSTI4 0
ASGNI4
ADDRLP4 388
INDIRI4
ARGI4
ADDRGP4 $319
ARGP4
ADDRLP4 392
ADDRLP4 368
INDIRP4
ASGNP4
ADDRLP4 396
ADDRLP4 392
INDIRP4
INDIRI4
ADDRLP4 392
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRLP4 396
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 396
INDIRI4
ARGI4
ADDRLP4 372
INDIRI4
ARGI4
ADDRLP4 380
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRLP4 388
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 665
;665:						trap_G2API_SetBoneAnim(cent->ghoul2, 0, "model_root", anim->firstFrame + anim->numFrames-1, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, 0);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 400
CNSTI4 0
ASGNI4
ADDRLP4 400
INDIRI4
ARGI4
ADDRGP4 $321
ARGP4
ADDRLP4 404
ADDRLP4 368
INDIRP4
ASGNP4
ADDRLP4 408
ADDRLP4 404
INDIRP4
INDIRI4
ADDRLP4 404
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRLP4 408
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 408
INDIRI4
ARGI4
ADDRLP4 372
INDIRI4
ARGI4
ADDRLP4 380
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRLP4 400
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 666
;666:					}
LABELV $318
line 667
;667:				}
LABELV $315
line 668
;668:			}
LABELV $310
line 670
;669:
;670:			if (!cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $325
line 671
;671:			{
line 672
;672:				return;
ADDRGP4 $236
JUMPV
LABELV $325
line 675
;673:			}
;674:
;675:			newBolt = trap_G2API_AddBolt( cent->ghoul2, 0, limbTagName );
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 368
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 308
ADDRLP4 368
INDIRI4
ASGNI4
line 676
;676:			if ( newBolt != -1 )
ADDRLP4 308
INDIRI4
CNSTI4 -1
EQI4 $327
line 677
;677:			{
line 680
;678:				vec3_t boltOrg, boltAng;
;679:
;680:				trap_G2API_GetBoltMatrix(cent->ghoul2, 0, newBolt, &matrix, cent->lerpAngles, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 396
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 396
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 236
ARGP4
ADDRLP4 396
INDIRP4
CNSTI4 940
ADDP4
ARGP4
ADDRLP4 396
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 396
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 682
;681:
;682:				trap_G2API_GiveMeVectorFromMatrix(&matrix, ORIGIN, boltOrg);
ADDRLP4 236
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 372
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 683
;683:				trap_G2API_GiveMeVectorFromMatrix(&matrix, NEGATIVE_Y, boltAng);
ADDRLP4 236
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 384
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 685
;684:
;685:				trap_FX_PlayEffectID(trap_FX_RegisterEffect("blaster/smoke_bolton"), boltOrg, boltAng);
ADDRGP4 $331
ARGP4
ADDRLP4 400
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 400
INDIRI4
ARGI4
ADDRLP4 372
ARGP4
ADDRLP4 384
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 686
;686:			}
LABELV $327
line 688
;687:
;688:			cent->bolt4 = newBolt;
ADDRFP4 0
INDIRP4
CNSTI4 996
ADDP4
ADDRLP4 308
INDIRI4
ASGNI4
line 690
;689:
;690:			trap_G2API_SetRootSurface(cent->ghoul2, 0, limbName);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 312
INDIRP4
ARGP4
ADDRGP4 trap_G2API_SetRootSurface
CALLI4
pop
line 692
;691:
;692:			trap_G2API_SetNewOrigin(cent->ghoul2, trap_G2API_AddBolt(cent->ghoul2, 0, rotateBone));
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 316
INDIRP4
ARGP4
ADDRLP4 372
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 372
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetNewOrigin
CALLI4
pop
line 694
;693:
;694:			trap_G2API_SetSurfaceOnOff(cent->ghoul2, limbCapName, 0);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 320
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_G2API_SetSurfaceOnOff
CALLI4
pop
line 696
;695:
;696:			trap_G2API_SetSurfaceOnOff(clEnt->ghoul2, limbName, 0x00000100);
ADDRLP4 296
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 312
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_G2API_SetSurfaceOnOff
CALLI4
pop
line 697
;697:			trap_G2API_SetSurfaceOnOff(clEnt->ghoul2, stubCapName, 0);
ADDRLP4 296
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 324
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_G2API_SetSurfaceOnOff
CALLI4
pop
line 699
;698:
;699:			newBolt = trap_G2API_AddBolt( clEnt->ghoul2, 0, stubTagName );
ADDRLP4 296
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 332
INDIRP4
ARGP4
ADDRLP4 376
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 308
ADDRLP4 376
INDIRI4
ASGNI4
line 700
;700:			if ( newBolt != -1 )
ADDRLP4 308
INDIRI4
CNSTI4 -1
EQI4 $332
line 701
;701:			{
line 704
;702:				vec3_t boltOrg, boltAng;
;703:
;704:				trap_G2API_GetBoltMatrix(clEnt->ghoul2, 0, newBolt, &matrix, clEnt->lerpAngles, clEnt->lerpOrigin, cg.time, cgs.gameModels, clEnt->modelScale);
ADDRLP4 296
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 236
ARGP4
ADDRLP4 296
INDIRP4
CNSTI4 940
ADDP4
ARGP4
ADDRLP4 296
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 296
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 706
;705:
;706:				trap_G2API_GiveMeVectorFromMatrix(&matrix, ORIGIN, boltOrg);
ADDRLP4 236
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 380
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 707
;707:				trap_G2API_GiveMeVectorFromMatrix(&matrix, NEGATIVE_Y, boltAng);
ADDRLP4 236
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 392
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 709
;708:
;709:				trap_FX_PlayEffectID(trap_FX_RegisterEffect("blaster/smoke_bolton"), boltOrg, boltAng);
ADDRGP4 $331
ARGP4
ADDRLP4 408
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 408
INDIRI4
ARGI4
ADDRLP4 380
ARGP4
ADDRLP4 392
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 710
;710:			}
LABELV $332
line 712
;711:
;712:			if (cent->currentState.modelGhoul2 == G2_MODELPART_RARM || cent->currentState.modelGhoul2 == G2_MODELPART_WAIST)
ADDRLP4 380
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 13
EQI4 $338
ADDRLP4 380
INDIRI4
CNSTI4 11
NEI4 $336
LABELV $338
line 713
;713:			{ //Cut his weapon holding arm off, so remove the weapon
line 714
;714:				if (trap_G2API_HasGhoul2ModelOnIndex(&(clEnt->ghoul2), 1))
ADDRLP4 296
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 384
ADDRGP4 trap_G2API_HasGhoul2ModelOnIndex
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $339
line 715
;715:				{
line 716
;716:					trap_G2API_RemoveGhoul2Model(&(clEnt->ghoul2), 1);
ADDRLP4 296
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_G2API_RemoveGhoul2Model
CALLI4
pop
line 717
;717:				}
LABELV $339
line 718
;718:			}
LABELV $336
line 720
;719:
;720:			clEnt->torsoBolt = cent->currentState.modelGhoul2; //reinit model after copying limbless one to queue
ADDRLP4 296
INDIRP4
CNSTI4 1012
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 722
;721:
;722:			return;
ADDRGP4 $236
JUMPV
LABELV $251
line 725
;723:		}
;724:
;725:		if (cent->ghoul2 && cent->bolt4 != -1 && cent->trailTime < cg.time)
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $341
ADDRLP4 308
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $341
ADDRLP4 308
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $341
line 726
;726:		{
line 727
;727:			if ( cent->bolt4 != -1 && 
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 312
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $344
ADDRLP4 316
CNSTF4 0
ASGNF4
ADDRLP4 312
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 316
INDIRF4
NEF4 $347
ADDRLP4 312
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 316
INDIRF4
NEF4 $347
ADDRLP4 312
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ADDRLP4 316
INDIRF4
EQF4 $344
LABELV $347
line 729
;728:				(cent->currentState.pos.trDelta[0] || cent->currentState.pos.trDelta[1] || cent->currentState.pos.trDelta[2]) )
;729:			{
line 732
;730:				vec3_t boltOrg, boltAng;
;731:
;732:				trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cent->bolt4, &matrix, cent->lerpAngles, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 344
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
ARGI4
ADDRLP4 236
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 940
ADDP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 734
;733:
;734:				trap_G2API_GiveMeVectorFromMatrix(&matrix, ORIGIN, boltOrg);
ADDRLP4 236
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 320
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 735
;735:				trap_G2API_GiveMeVectorFromMatrix(&matrix, NEGATIVE_Y, boltAng);
ADDRLP4 236
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 332
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 737
;736:
;737:				trap_FX_PlayEffectID(trap_FX_RegisterEffect("blaster/smoke_bolton"), boltOrg, boltAng);
ADDRGP4 $331
ARGP4
ADDRLP4 348
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
ARGI4
ADDRLP4 320
ARGP4
ADDRLP4 332
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 739
;738:
;739:				cent->trailTime = cg.time + 400;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 400
ADDI4
ASGNI4
line 740
;740:			}
LABELV $344
line 741
;741:		}
LABELV $341
line 743
;742:
;743:		ent.radius = cent->currentState.g2radius;
ADDRLP4 0+92
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 744
;744:		ent.hModel = 0;
ADDRLP4 0+8
CNSTI4 0
ASGNI4
line 745
;745:	}
LABELV $243
line 747
;746:
;747:	if (cent->currentState.number >= MAX_CLIENTS &&
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
INDIRI4
CNSTI4 32
LTI4 $353
ADDRLP4 296
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 19
NEI4 $353
line 749
;748:		cent->currentState.activeForcePass == NUM_FORCE_POWERS+1)
;749:	{
line 754
;750:		centity_t			*empOwn;
;751:		vec3_t				empAngles, empOrg, anglesToOwner;
;752:		float				angle_ideal, angle_current, angle_dif;
;753:		float				degrees_positive, degrees_negative;
;754:		int					overturn = 0;
ADDRLP4 336
CNSTI4 0
ASGNI4
line 756
;755:
;756:		empOwn = &cg_entities[cent->currentState.emplacedOwner];
ADDRLP4 312
CNSTI4 1920
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 758
;757:
;758:		if (empOwn)
ADDRLP4 312
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $355
line 759
;759:		{
line 761
;760:		
;761:			if (cg.snap->ps.clientNum == empOwn->currentState.number &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRLP4 312
INDIRP4
INDIRI4
NEI4 $357
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $357
line 763
;762:				!cg.renderingThirdPerson)
;763:			{
line 764
;764:				VectorCopy(cg.refdefViewAngles, empAngles);
ADDRLP4 300
ADDRGP4 cg+3972
INDIRB
ASGNB 12
line 765
;765:				VectorCopy(cg.refdef.vieworg, empOrg);
ADDRLP4 340
ADDRGP4 cg+3604+24
INDIRB
ASGNB 12
line 766
;766:			}
ADDRGP4 $358
JUMPV
LABELV $357
line 768
;767:			else
;768:			{
line 769
;769:				VectorCopy(empOwn->lerpAngles, empAngles);
ADDRLP4 300
ADDRLP4 312
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 770
;770:				VectorCopy(empOwn->lerpOrigin, empOrg);
ADDRLP4 340
ADDRLP4 312
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 771
;771:			}
LABELV $358
line 773
;772:
;773:			VectorSubtract(cent->lerpOrigin, empOrg, anglesToOwner);
ADDRLP4 364
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 316
ADDRLP4 364
INDIRP4
CNSTI4 928
ADDP4
INDIRF4
ADDRLP4 340
INDIRF4
SUBF4
ASGNF4
ADDRLP4 316+4
ADDRLP4 364
INDIRP4
CNSTI4 932
ADDP4
INDIRF4
ADDRLP4 340+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 316+8
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
INDIRF4
ADDRLP4 340+8
INDIRF4
SUBF4
ASGNF4
line 775
;774:
;775:			vectoangles(anglesToOwner, anglesToOwner);
ADDRLP4 316
ARGP4
ADDRLP4 316
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 777
;776:
;777:			if (empAngles[PITCH] > 40)
ADDRLP4 300
INDIRF4
CNSTF4 1109393408
LEF4 $368
line 778
;778:			{
line 779
;779:				empAngles[PITCH] = 40;
ADDRLP4 300
CNSTF4 1109393408
ASGNF4
line 780
;780:			}
LABELV $368
line 782
;781:
;782:			angle_ideal = empAngles[YAW];
ADDRLP4 328
ADDRLP4 300+4
INDIRF4
ASGNF4
line 783
;783:			angle_current = anglesToOwner[YAW];
ADDRLP4 332
ADDRLP4 316+4
INDIRF4
ASGNF4
line 785
;784:
;785:			if (angle_current < 0)
ADDRLP4 332
INDIRF4
CNSTF4 0
GEF4 $372
line 786
;786:			{
line 787
;787:				angle_current += 360;
ADDRLP4 332
ADDRLP4 332
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 788
;788:			}
LABELV $372
line 789
;789:			if (angle_current > 360)
ADDRLP4 332
INDIRF4
CNSTF4 1135869952
LEF4 $374
line 790
;790:			{
line 791
;791:				angle_current -= 360;
ADDRLP4 332
ADDRLP4 332
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 792
;792:			}
LABELV $374
line 793
;793:			if (angle_ideal < 0)
ADDRLP4 328
INDIRF4
CNSTF4 0
GEF4 $376
line 794
;794:			{
line 795
;795:				angle_ideal += 360;
ADDRLP4 328
ADDRLP4 328
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 796
;796:			}
LABELV $376
line 797
;797:			if (angle_ideal > 360)
ADDRLP4 328
INDIRF4
CNSTF4 1135869952
LEF4 $378
line 798
;798:			{
line 799
;799:				angle_ideal -= 360;
ADDRLP4 328
ADDRLP4 328
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 800
;800:			}
LABELV $378
line 802
;801:
;802:			if (angle_ideal <= angle_current)
ADDRLP4 328
INDIRF4
ADDRLP4 332
INDIRF4
GTF4 $380
line 803
;803:			{
line 804
;804:				degrees_negative = (angle_current - angle_ideal);
ADDRLP4 356
ADDRLP4 332
INDIRF4
ADDRLP4 328
INDIRF4
SUBF4
ASGNF4
line 806
;805:
;806:				degrees_positive = (360 - angle_current) + angle_ideal;
ADDRLP4 360
CNSTF4 1135869952
ADDRLP4 332
INDIRF4
SUBF4
ADDRLP4 328
INDIRF4
ADDF4
ASGNF4
line 807
;807:			}
ADDRGP4 $381
JUMPV
LABELV $380
line 809
;808:			else
;809:			{
line 810
;810:				degrees_negative = angle_current + (360 - angle_ideal);
ADDRLP4 356
ADDRLP4 332
INDIRF4
CNSTF4 1135869952
ADDRLP4 328
INDIRF4
SUBF4
ADDF4
ASGNF4
line 812
;811:
;812:				degrees_positive = (angle_ideal - angle_current);
ADDRLP4 360
ADDRLP4 328
INDIRF4
ADDRLP4 332
INDIRF4
SUBF4
ASGNF4
line 813
;813:			}
LABELV $381
line 815
;814:
;815:			if (degrees_negative < degrees_positive)
ADDRLP4 356
INDIRF4
ADDRLP4 360
INDIRF4
GEF4 $382
line 816
;816:			{
line 817
;817:				angle_dif = degrees_negative;
ADDRLP4 352
ADDRLP4 356
INDIRF4
ASGNF4
line 818
;818:			}
ADDRGP4 $383
JUMPV
LABELV $382
line 820
;819:			else
;820:			{
line 821
;821:				angle_dif = degrees_positive;
ADDRLP4 352
ADDRLP4 360
INDIRF4
ASGNF4
line 822
;822:			}
LABELV $383
line 824
;823:
;824:			if (cg.snap->ps.clientNum == empOwn->currentState.number)
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRLP4 312
INDIRP4
INDIRI4
NEI4 $384
line 825
;825:			{
line 826
;826:				cg.constrictValue = anglesToOwner[YAW];
ADDRGP4 cg+3984
ADDRLP4 316+4
INDIRF4
ASGNF4
line 828
;827:
;828:				cg.doConstrict = cg.time + 50;
ADDRGP4 cg+3992
ADDRGP4 cg+64
INDIRI4
CNSTI4 50
ADDI4
ASGNI4
line 829
;829:			}
LABELV $384
line 831
;830:
;831:			if (angle_dif > 90)
ADDRLP4 352
INDIRF4
CNSTF4 1119092736
LEF4 $391
line 832
;832:			{
line 833
;833:				overturn = 1;
ADDRLP4 336
CNSTI4 1
ASGNI4
line 835
;834:
;835:				if (angle_dif == degrees_negative)
ADDRLP4 352
INDIRF4
ADDRLP4 356
INDIRF4
NEF4 $393
line 836
;836:				{
line 837
;837:					empAngles[YAW] += (angle_dif - 90);
ADDRLP4 300+4
ADDRLP4 300+4
INDIRF4
ADDRLP4 352
INDIRF4
CNSTF4 1119092736
SUBF4
ADDF4
ASGNF4
line 838
;838:				}
ADDRGP4 $392
JUMPV
LABELV $393
line 840
;839:				else
;840:				{
line 841
;841:					empAngles[YAW] -= (angle_dif - 90);
ADDRLP4 300+4
ADDRLP4 300+4
INDIRF4
ADDRLP4 352
INDIRF4
CNSTF4 1119092736
SUBF4
SUBF4
ASGNF4
line 842
;842:				}
line 843
;843:			}
ADDRGP4 $392
JUMPV
LABELV $391
line 844
;844:			else if (angle_dif > 80)
ADDRLP4 352
INDIRF4
CNSTF4 1117782016
LEF4 $397
line 845
;845:			{
line 846
;846:				overturn = 2;
ADDRLP4 336
CNSTI4 2
ASGNI4
line 847
;847:			}
LABELV $397
LABELV $392
line 849
;848:
;849:			if (!overturn && cg.snap->ps.clientNum == empOwn->currentState.number)
ADDRLP4 336
INDIRI4
CNSTI4 0
NEI4 $399
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRLP4 312
INDIRP4
INDIRI4
NEI4 $399
line 850
;850:			{
line 851
;851:				float plusExt = anglesToOwner[YAW]+70;
ADDRLP4 368
ADDRLP4 316+4
INDIRF4
CNSTF4 1116471296
ADDF4
ASGNF4
line 852
;852:				float minusExt = anglesToOwner[YAW]-70;
ADDRLP4 372
ADDRLP4 316+4
INDIRF4
CNSTF4 1116471296
SUBF4
ASGNF4
line 854
;853:
;854:				if (plusExt > 360)
ADDRLP4 368
INDIRF4
CNSTF4 1135869952
LEF4 $404
line 855
;855:				{
line 856
;856:					plusExt -= 360;
ADDRLP4 368
ADDRLP4 368
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 857
;857:				}
LABELV $404
line 858
;858:				if (minusExt < 0)
ADDRLP4 372
INDIRF4
CNSTF4 0
GEF4 $406
line 859
;859:				{
line 860
;860:					minusExt += 360;
ADDRLP4 372
ADDRLP4 372
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 861
;861:				}
LABELV $406
line 863
;862:
;863:				trap_SetClientTurnExtent(minusExt, plusExt, cg.time+5000);
ADDRLP4 372
INDIRF4
ARGF4
ADDRLP4 368
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
CNSTI4 5000
ADDI4
ARGI4
ADDRGP4 trap_SetClientTurnExtent
CALLV
pop
line 865
;864:
;865:				VectorCopy(empAngles, cent->turAngles);
ADDRFP4 0
INDIRP4
CNSTI4 1016
ADDP4
ADDRLP4 300
INDIRB
ASGNB 12
line 866
;866:			}
ADDRGP4 $400
JUMPV
LABELV $399
line 867
;867:			else if (cg.snap->ps.clientNum == empOwn->currentState.number)
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRLP4 312
INDIRP4
INDIRI4
NEI4 $409
line 868
;868:			{
line 869
;869:				trap_SetClientForceAngle(cg.time+5000, cent->turAngles);
ADDRGP4 cg+64
INDIRI4
CNSTI4 5000
ADDI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 1016
ADDP4
ARGP4
ADDRGP4 trap_SetClientForceAngle
CALLV
pop
line 870
;870:			}
LABELV $409
LABELV $400
line 874
;871:
;872:		//	empAngles[PITCH] -= 160;
;873:
;874:			if (empAngles[PITCH] < 0)
ADDRLP4 300
INDIRF4
CNSTF4 0
GEF4 $413
line 875
;875:			{
line 876
;876:				empAngles[PITCH] += 360;
ADDRLP4 300
ADDRLP4 300
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 877
;877:			}
LABELV $413
line 878
;878:			if (empAngles[YAW] < 0)
ADDRLP4 300+4
INDIRF4
CNSTF4 0
GEF4 $415
line 879
;879:			{
line 880
;880:				empAngles[YAW] += 360;
ADDRLP4 300+4
ADDRLP4 300+4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 881
;881:			}
LABELV $415
line 883
;882:
;883:			empAngles[YAW] -= cent->currentState.angles[YAW]; //slight hack so that upper rotated half looks right on angled turrets
ADDRLP4 300+4
ADDRLP4 300+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
SUBF4
ASGNF4
line 905
;884:
;885:			//AngleVectors(empAngles, NULL, NULL, up);
;886:
;887:			//empAngles[ROLL] = -empAngles[YAW];
;888:			//empAngles[YAW] = 0;
;889:
;890:			//trap_G2API_SetBoneAngles(cent->ghoul2, 0, "swivel_bone", empAngles, BONE_ANGLES_REPLACE, POSITIVE_Z, NEGATIVE_X, NEGATIVE_Y, NULL, 0, cg.time);
;891:			//trap_G2API_SetBoneAngles(cent->ghoul2, 0, "swivel_bone", empAngles, BONE_ANGLES_REPLACE, POSITIVE_Z, POSITIVE_X, POSITIVE_Y, NULL, 0, cg.time);
;892:
;893:			//constrict the pitch angles of the turret but not the player view
;894:			/*
;895:			if (empAngles[PITCH] < 170)
;896:			{
;897:				empAngles[PITCH] = 170;
;898:			}
;899:			if (empAngles[PITCH] > 240)
;900:			{
;901:				empAngles[PITCH] = 240;
;902:			}
;903:			*/
;904:
;905:			trap_G2API_SetBoneAngles( cent->ghoul2, 0, /*"swivel_bone"*/"Bone02", empAngles, BONE_ANGLES_REPLACE, NEGATIVE_Y, NEGATIVE_X, POSITIVE_Z, NULL, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 368
CNSTI4 0
ASGNI4
ADDRLP4 368
INDIRI4
ARGI4
ADDRGP4 $420
ARGP4
ADDRLP4 300
ARGP4
ADDRLP4 372
CNSTI4 4
ASGNI4
ADDRLP4 372
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 372
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 368
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 907
;906:			//trap_G2API_SetBoneAngles( cent->ghoul2, 0, "swivel_bone", empAngles, BONE_ANGLES_POSTMULT, POSITIVE_Y, POSITIVE_Z, POSITIVE_X, NULL, 0, cg.time); 
;907:		}
LABELV $355
line 908
;908:	}
LABELV $353
line 910
;909:
;910:	s1 = &cent->currentState;
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
line 915
;911:/*
;912:Ghoul2 Insert Start
;913:*/
;914:	// if set to invisible, skip
;915:	if ((!s1->modelindex) && !(trap_G2_HaveWeGhoul2Models(cent->ghoul2))) 
ADDRLP4 212
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
NEI4 $422
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
NEI4 $422
line 916
;916:	{
line 917
;917:		return;
ADDRGP4 $236
JUMPV
LABELV $422
line 923
;918:	}
;919:/*
;920:Ghoul2 Insert End
;921:*/
;922:
;923:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 927
;924:
;925:	// set frame
;926:
;927:	ent.frame = s1->frame;
ADDRLP4 0+104
ADDRLP4 212
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
ASGNI4
line 928
;928:	ent.oldframe = ent.frame;
ADDRLP4 0+124
ADDRLP4 0+104
INDIRI4
ASGNI4
line 929
;929:	ent.backlerp = 0;
ADDRLP4 0+128
CNSTF4 0
ASGNF4
line 934
;930:
;931:/*
;932:Ghoul2 Insert Start
;933:*/
;934:	CG_SetGhoul2Info(&ent, cent);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetGhoul2Info
CALLV
pop
line 939
;935:
;936:/*
;937:Ghoul2 Insert End
;938:*/
;939:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 940
;940:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+64
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 942
;941:
;942:	if (cent->currentState.modelGhoul2)
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
EQI4 $430
line 943
;943:	{ //If the game says this guy uses a ghoul2 model and the g2 instance handle is null, then initialize it
line 944
;944:		if (!cent->ghoul2 && !cent->currentState.bolt1)
ADDRLP4 304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 304
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $432
ADDRLP4 304
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 0
NEI4 $432
line 945
;945:		{
line 946
;946:			trap_G2API_InitGhoul2Model(&cent->ghoul2, CG_ConfigString( CS_MODELS+cent->currentState.modelindex ), 0, 0, 0, 0, 0);
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 32
ADDI4
ARGI4
ADDRLP4 308
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
ADDRLP4 308
INDIRP4
ARGP4
ADDRLP4 312
CNSTI4 0
ASGNI4
ADDRLP4 312
INDIRI4
ARGI4
ADDRLP4 312
INDIRI4
ARGI4
ADDRLP4 312
INDIRI4
ARGI4
ADDRLP4 312
INDIRI4
ARGI4
ADDRLP4 312
INDIRI4
ARGI4
ADDRGP4 trap_G2API_InitGhoul2Model
CALLI4
pop
line 947
;947:		}
ADDRGP4 $433
JUMPV
LABELV $432
line 948
;948:		else if (cent->currentState.bolt1)
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 0
EQI4 $434
line 949
;949:		{
line 950
;950:			TurretClientRun(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TurretClientRun
CALLV
pop
line 951
;951:		}
LABELV $434
LABELV $433
line 953
;952:
;953:		if (cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $436
line 954
;954:		{ //give us a proper radius
line 955
;955:			ent.radius = cent->currentState.g2radius;
ADDRLP4 0+92
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 956
;956:		}
LABELV $436
line 957
;957:	}
LABELV $430
line 959
;958:
;959:	if (s1->eType == ET_BODY)
ADDRLP4 212
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 15
NEI4 $439
line 960
;960:	{ //bodies should have a radius as well
line 961
;961:		ent.radius = cent->currentState.g2radius;
ADDRLP4 0+92
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 963
;962:
;963:		if (cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $442
line 964
;964:		{ //all bodies should already have a ghoul2 instance. Use it to set the torso/head angles to 0.
line 965
;965:			if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $444
line 966
;966:			{
line 967
;967:				trap_G2API_SetBoneAngles(cent->ghoul2, 0, "pelvis", vec3_origin, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 100, cg.time);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $269
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
CNSTI4 6
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+36348
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 968
;968:				ent.radius = 250;
ADDRLP4 0+92
CNSTF4 1132068864
ASGNF4
line 969
;969:			}
ADDRGP4 $445
JUMPV
LABELV $444
line 971
;970:			else
;971:			{
line 972
;972:				cent->lerpAngles[PITCH] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
CNSTF4 0
ASGNF4
line 973
;973:				cent->lerpAngles[ROLL] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 948
ADDP4
CNSTF4 0
ASGNF4
line 974
;974:				trap_G2API_SetBoneAngles(cent->ghoul2, 0, "pelvis", vec3_origin, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 304
CNSTI4 0
ASGNI4
ADDRLP4 304
INDIRI4
ARGI4
ADDRGP4 $269
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
CNSTI4 6
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 304
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 975
;975:				trap_G2API_SetBoneAngles(cent->ghoul2, 0, "thoracic", vec3_origin, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 308
CNSTI4 0
ASGNI4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $270
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
CNSTI4 6
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 976
;976:				trap_G2API_SetBoneAngles(cent->ghoul2, 0, "upper_lumbar", vec3_origin, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 100, cg.time);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $319
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
CNSTI4 6
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+36348
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 977
;977:				trap_G2API_SetBoneAngles(cent->ghoul2, 0, "lower_lumbar", vec3_origin, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 100, cg.time);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $455
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
CNSTI4 6
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+36348
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 978
;978:				trap_G2API_SetBoneAngles(cent->ghoul2, 0, "cranium", vec3_origin, BONE_ANGLES_POSTMULT, POSITIVE_Z, NEGATIVE_Y, POSITIVE_X, cgs.gameModels, 100, cg.time);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $262
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 312
CNSTI4 2
ASGNI4
ADDRLP4 312
INDIRI4
ARGI4
ADDRLP4 312
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+36348
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 979
;979:			}
LABELV $445
line 980
;980:		}
LABELV $442
line 981
;981:	}
LABELV $439
line 983
;982:
;983:	if (s1->eType == ET_HOLOCRON && s1->modelindex < -100)
ADDRLP4 212
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
NEI4 $460
ADDRLP4 212
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 -100
GEI4 $460
line 984
;984:	{ //special render, it's a holocron
line 986
;985:		//Using actual models now:
;986:		ent.hModel = trap_R_RegisterModel(forceHolocronModels[s1->modelindex+128]);
ADDRLP4 212
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 forceHolocronModels+512
ADDP4
INDIRP4
ARGP4
ADDRLP4 308
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 308
INDIRI4
ASGNI4
line 989
;987:
;988:		//Rotate them
;989:		VectorCopy( cg.autoAngles, cent->lerpAngles );
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
ADDRGP4 cg+3508
INDIRB
ASGNB 12
line 990
;990:		AxisCopy( cg.autoAxis, ent.axis );
ADDRGP4 cg+3520
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 991
;991:	}
ADDRGP4 $461
JUMPV
LABELV $460
line 993
;992:	else
;993:	{
line 994
;994:		ent.hModel = cgs.gameModels[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 212
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36348
ADDP4
INDIRI4
ASGNI4
line 995
;995:	}
LABELV $461
line 998
;996:
;997:	// player model
;998:	if (s1->number == cg.snap->ps.clientNum) {
ADDRLP4 212
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $469
line 999
;999:		ent.renderfx |= RF_THIRD_PERSON;	// only draw from mirrors
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1000
;1000:	}
LABELV $469
line 1011
;1001:/*
;1002:Ghoul2 Insert Start
;1003:*/
;1004:	// are we bolted to a Ghoul2 model?
;1005:/* 
;1006://g2r	if (s1->boltInfo)
;1007:	{
;1008:		G2_BoltToGhoul2Model(s1, &ent);
;1009:	}
;1010:	else */
;1011:	{
line 1013
;1012:		// convert angles to axis
;1013:		AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1014
;1014:	}
line 1019
;1015:
;1016:/*
;1017:Ghoul2 Insert End
;1018:*/
;1019:	if ( cent->currentState.time > cg.time && cent->currentState.weapon == WP_EMPLACED_GUN )
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $474
ADDRLP4 308
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 14
NEI4 $474
line 1020
;1020:	{
line 1022
;1021:		// make the gun pulse red to warn about it exploding
;1022:		val = (1.0f - (float)(cent->currentState.time - cg.time) / 3200.0f ) * 0.3f;
ADDRLP4 232
CNSTF4 1050253722
CNSTF4 1065353216
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1162346496
DIVF4
SUBF4
MULF4
ASGNF4
line 1024
;1023:
;1024:		ent.customShader = trap_R_RegisterShader( "gfx/effects/turretflashdie" );
ADDRGP4 $479
ARGP4
ADDRLP4 312
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0+76
ADDRLP4 312
INDIRI4
ASGNI4
line 1025
;1025:		ent.shaderRGBA[0] = (sin( cg.time * 0.04f ) * val * 0.4f + val) * 255;
CNSTF4 1025758986
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 320
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 324
ADDRLP4 232
INDIRF4
ASGNF4
ADDRLP4 328
CNSTF4 1132396544
CNSTF4 1053609165
ADDRLP4 320
INDIRF4
ADDRLP4 324
INDIRF4
MULF4
MULF4
ADDRLP4 324
INDIRF4
ADDF4
MULF4
ASGNF4
ADDRLP4 332
CNSTF4 1325400064
ASGNF4
ADDRLP4 328
INDIRF4
ADDRLP4 332
INDIRF4
LTF4 $483
ADDRLP4 316
ADDRLP4 328
INDIRF4
ADDRLP4 332
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $484
JUMPV
LABELV $483
ADDRLP4 316
ADDRLP4 328
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $484
ADDRLP4 0+80
ADDRLP4 316
INDIRU4
CVUU1 4
ASGNU1
line 1026
;1026:		ent.shaderRGBA[1] = ent.shaderRGBA[2] = 0;
ADDRLP4 336
CNSTU1 0
ASGNU1
ADDRLP4 0+80+2
ADDRLP4 336
INDIRU1
ASGNU1
ADDRLP4 0+80+1
ADDRLP4 336
INDIRU1
ASGNU1
line 1028
;1027:
;1028:		ent.shaderRGBA[3] = 100;
ADDRLP4 0+80+3
CNSTU1 100
ASGNU1
line 1029
;1029:		trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1030
;1030:		ent.customShader = 0;
ADDRLP4 0+76
CNSTI4 0
ASGNI4
line 1031
;1031:	}
ADDRGP4 $475
JUMPV
LABELV $474
line 1032
;1032:	else if ( cent->currentState.time == -1 && cent->currentState.weapon == WP_EMPLACED_GUN)
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 312
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $492
ADDRLP4 312
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 14
NEI4 $492
line 1033
;1033:	{
line 1034
;1034:		ent.customShader = trap_R_RegisterShader( "models/map_objects/imp_mine/turret_chair_dmg.tga" );
ADDRGP4 $495
ARGP4
ADDRLP4 316
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0+76
ADDRLP4 316
INDIRI4
ASGNI4
line 1036
;1035:		//trap_R_AddRefEntityToScene( &ent );
;1036:	}
LABELV $492
LABELV $475
line 1038
;1037:
;1038:	if ((cent->currentState.eFlags & EF_DISINTEGRATION) && cent->currentState.eType == ET_BODY)
ADDRLP4 316
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 316
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 33554432
BANDI4
CNSTI4 0
EQI4 $496
ADDRLP4 316
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 15
NEI4 $496
line 1039
;1039:	{
line 1043
;1040:		vec3_t tempAng, hitLoc;
;1041:		float tempLength;
;1042:
;1043:		if (!cent->dustTrailTime)
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
NEI4 $498
line 1044
;1044:		{
line 1045
;1045:			cent->dustTrailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1046
;1046:		}
LABELV $498
line 1048
;1047:
;1048:		VectorCopy(cent->currentState.origin2, hitLoc);
ADDRLP4 320
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 1050
;1049:
;1050:		VectorSubtract( hitLoc, ent.origin, ent.oldorigin );
ADDRLP4 0+64
ADDRLP4 320
INDIRF4
ADDRLP4 0+52
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+64+4
ADDRLP4 320+4
INDIRF4
ADDRLP4 0+52+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+64+8
ADDRLP4 320+8
INDIRF4
ADDRLP4 0+52+8
INDIRF4
SUBF4
ASGNF4
line 1052
;1051:		
;1052:		tempLength = VectorNormalize( ent.oldorigin );
ADDRLP4 0+64
ARGP4
ADDRLP4 348
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 332
ADDRLP4 348
INDIRF4
ASGNF4
line 1053
;1053:		vectoangles( ent.oldorigin, tempAng );
ADDRLP4 0+64
ARGP4
ADDRLP4 336
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1054
;1054:		tempAng[YAW] -= cent->lerpAngles[YAW];
ADDRLP4 336+4
ADDRLP4 336+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1055
;1055:		AngleVectors( tempAng, ent.oldorigin, NULL, NULL );
ADDRLP4 336
ARGP4
ADDRLP4 0+64
ARGP4
ADDRLP4 352
CNSTP4 0
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1056
;1056:		VectorScale( ent.oldorigin, tempLength, ent.oldorigin );
ADDRLP4 0+64
ADDRLP4 0+64
INDIRF4
ADDRLP4 332
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+64+4
ADDRLP4 0+64+4
INDIRF4
ADDRLP4 332
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+64+8
ADDRLP4 0+64+8
INDIRF4
ADDRLP4 332
INDIRF4
MULF4
ASGNF4
line 1058
;1057:
;1058:		ent.endTime = cent->dustTrailTime;
ADDRLP4 0+176
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1067
;1059:
;1060:		/*
;1061:		ent.renderfx |= RF_DISINTEGRATE2;
;1062:
;1063:		ent.customShader = cgs.media.disruptorShader;
;1064:		trap_R_AddRefEntityToScene( &ent );
;1065:		*/
;1066:
;1067:		ent.renderfx &= ~(RF_DISINTEGRATE2);
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -262145
BANDI4
ASGNI4
line 1068
;1068:		ent.renderfx |= (RF_DISINTEGRATE1);
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 1069
;1069:		ent.customShader = 0;
ADDRLP4 0+76
CNSTI4 0
ASGNI4
line 1070
;1070:		trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1072
;1071:
;1072:		return;
ADDRGP4 $236
JUMPV
LABELV $496
line 1074
;1073:	}
;1074:	else if (cent->currentState.eType == ET_BODY)
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 15
NEI4 $531
line 1075
;1075:	{
line 1076
;1076:		cent->dustTrailTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
CNSTI4 0
ASGNI4
line 1077
;1077:	}
LABELV $531
line 1080
;1078:
;1079:	// add to refresh list
;1080:	trap_R_AddRefEntityToScene (&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1082
;1081:
;1082:	if (cent->bolt3 == 999)
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 999
NEI4 $533
line 1083
;1083:	{ //this is an in-flight saber being rendered manually
line 1091
;1084:		vec3_t org;
;1085:		float wv;
;1086:		int i;
;1087:		addspriteArgStruct_t fxSArgs;
;1088:		//refEntity_t sRef;
;1089:		//memcpy( &sRef, &ent, sizeof( sRef ) );
;1090:
;1091:		ent.customShader = cgs.media.solidWhite;
ADDRLP4 0+76
ADDRGP4 cgs+70280+576
INDIRI4
ASGNI4
line 1092
;1092:		ent.renderfx = RF_RGB_TINT;
ADDRLP4 0+4
CNSTI4 2048
ASGNI4
line 1093
;1093:		wv = sin( cg.time * 0.003f ) * 0.08f + 0.1f;
CNSTF4 994352038
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 412
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 408
CNSTF4 1034147594
ADDRLP4 412
INDIRF4
MULF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1094
;1094:		ent.shaderRGBA[0] = wv * 255;
ADDRLP4 420
CNSTF4 1132396544
ADDRLP4 408
INDIRF4
MULF4
ASGNF4
ADDRLP4 424
CNSTF4 1325400064
ASGNF4
ADDRLP4 420
INDIRF4
ADDRLP4 424
INDIRF4
LTF4 $542
ADDRLP4 416
ADDRLP4 420
INDIRF4
ADDRLP4 424
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $543
JUMPV
LABELV $542
ADDRLP4 416
ADDRLP4 420
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $543
ADDRLP4 0+80
ADDRLP4 416
INDIRU4
CVUU1 4
ASGNU1
line 1095
;1095:		ent.shaderRGBA[1] = wv * 255;
ADDRLP4 432
CNSTF4 1132396544
ADDRLP4 408
INDIRF4
MULF4
ASGNF4
ADDRLP4 436
CNSTF4 1325400064
ASGNF4
ADDRLP4 432
INDIRF4
ADDRLP4 436
INDIRF4
LTF4 $547
ADDRLP4 428
ADDRLP4 432
INDIRF4
ADDRLP4 436
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $548
JUMPV
LABELV $547
ADDRLP4 428
ADDRLP4 432
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $548
ADDRLP4 0+80+1
ADDRLP4 428
INDIRU4
CVUU1 4
ASGNU1
line 1096
;1096:		ent.shaderRGBA[2] = wv * 0;
ADDRLP4 444
CNSTF4 0
ADDRLP4 408
INDIRF4
MULF4
ASGNF4
ADDRLP4 448
CNSTF4 1325400064
ASGNF4
ADDRLP4 444
INDIRF4
ADDRLP4 448
INDIRF4
LTF4 $552
ADDRLP4 440
ADDRLP4 444
INDIRF4
ADDRLP4 448
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $553
JUMPV
LABELV $552
ADDRLP4 440
ADDRLP4 444
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $553
ADDRLP4 0+80+2
ADDRLP4 440
INDIRU4
CVUU1 4
ASGNU1
line 1097
;1097:		trap_R_AddRefEntityToScene (&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1099
;1098:
;1099:		for ( i = -4; i < 10; i += 1 )
ADDRLP4 392
CNSTI4 -4
ASGNI4
LABELV $554
line 1100
;1100:		{
line 1101
;1101:			VectorMA( ent.origin, -i, ent.axis[2], org );
ADDRLP4 452
ADDRLP4 392
INDIRI4
NEGI4
CVIF4 4
ASGNF4
ADDRLP4 396
ADDRLP4 0+52
INDIRF4
ADDRLP4 0+12+24
INDIRF4
ADDRLP4 452
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 396+4
ADDRLP4 0+52+4
INDIRF4
ADDRLP4 0+12+24+4
INDIRF4
ADDRLP4 452
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 396+8
ADDRLP4 0+52+8
INDIRF4
ADDRLP4 0+12+24+8
INDIRF4
ADDRLP4 392
INDIRI4
NEGI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 1103
;1102:
;1103:			VectorCopy(org, fxSArgs.origin);
ADDRLP4 320
ADDRLP4 396
INDIRB
ASGNB 12
line 1104
;1104:			VectorClear(fxSArgs.vel);
ADDRLP4 456
CNSTF4 0
ASGNF4
ADDRLP4 320+12+8
ADDRLP4 456
INDIRF4
ASGNF4
ADDRLP4 320+12+4
ADDRLP4 456
INDIRF4
ASGNF4
ADDRLP4 320+12
ADDRLP4 456
INDIRF4
ASGNF4
line 1105
;1105:			VectorClear(fxSArgs.accel);
ADDRLP4 460
CNSTF4 0
ASGNF4
ADDRLP4 320+24+8
ADDRLP4 460
INDIRF4
ASGNF4
ADDRLP4 320+24+4
ADDRLP4 460
INDIRF4
ASGNF4
ADDRLP4 320+24
ADDRLP4 460
INDIRF4
ASGNF4
line 1106
;1106:			fxSArgs.scale = 5.5f;
ADDRLP4 320+36
CNSTF4 1085276160
ASGNF4
line 1107
;1107:			fxSArgs.dscale = 5.5f;
ADDRLP4 320+40
CNSTF4 1085276160
ASGNF4
line 1108
;1108:			fxSArgs.sAlpha = wv;
ADDRLP4 320+44
ADDRLP4 408
INDIRF4
ASGNF4
line 1109
;1109:			fxSArgs.eAlpha = wv;
ADDRLP4 320+48
ADDRLP4 408
INDIRF4
ASGNF4
line 1110
;1110:			fxSArgs.rotation = 0.0f;
ADDRLP4 320+52
CNSTF4 0
ASGNF4
line 1111
;1111:			fxSArgs.bounce = 0.0f;
ADDRLP4 320+56
CNSTF4 0
ASGNF4
line 1112
;1112:			fxSArgs.life = 1.0f;
ADDRLP4 320+60
CNSTI4 1
ASGNI4
line 1113
;1113:			fxSArgs.shader = cgs.media.yellowDroppedSaberShader;
ADDRLP4 320+64
ADDRGP4 cgs+70280+168
INDIRI4
ASGNI4
line 1114
;1114:			fxSArgs.flags = 0x08000000;
ADDRLP4 320+68
CNSTI4 134217728
ASGNI4
line 1117
;1115:
;1116:			//trap_FX_AddSprite( org, NULL, NULL, 5.5f, 5.5f, wv, wv, 0.0f, 0.0f, 1.0f, cgs.media.yellowSaberGlowShader, 0x08000000 );
;1117:			trap_FX_AddSprite(&fxSArgs);
ADDRLP4 320
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 1118
;1118:		}
LABELV $555
line 1099
ADDRLP4 392
ADDRLP4 392
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 392
INDIRI4
CNSTI4 10
LTI4 $554
line 1119
;1119:	}
ADDRGP4 $534
JUMPV
LABELV $533
line 1120
;1120:	else if (cent->currentState.trickedentindex3)
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $594
line 1121
;1121:	{ //holocron special effects
line 1128
;1122:		vec3_t org;
;1123:		float wv;
;1124:		addspriteArgStruct_t fxSArgs;
;1125:		//refEntity_t sRef;
;1126:		//memcpy( &sRef, &ent, sizeof( sRef ) );
;1127:
;1128:		ent.customShader = cgs.media.solidWhite;
ADDRLP4 0+76
ADDRGP4 cgs+70280+576
INDIRI4
ASGNI4
line 1129
;1129:		ent.renderfx = RF_RGB_TINT;
ADDRLP4 0+4
CNSTI4 2048
ASGNI4
line 1130
;1130:		wv = sin( cg.time * 0.005f ) * 0.08f + 0.1f; //* 0.08f + 0.1f;
CNSTF4 1000593162
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 408
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 392
CNSTF4 1034147594
ADDRLP4 408
INDIRF4
MULF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1132
;1131:
;1132:		if (cent->currentState.trickedentindex3 == 1)
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 1
NEI4 $601
line 1133
;1133:		{ //dark
line 1134
;1134:			ent.shaderRGBA[0] = wv*255;
ADDRLP4 416
CNSTF4 1132396544
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
ADDRLP4 420
CNSTF4 1325400064
ASGNF4
ADDRLP4 416
INDIRF4
ADDRLP4 420
INDIRF4
LTF4 $605
ADDRLP4 412
ADDRLP4 416
INDIRF4
ADDRLP4 420
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $606
JUMPV
LABELV $605
ADDRLP4 412
ADDRLP4 416
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $606
ADDRLP4 0+80
ADDRLP4 412
INDIRU4
CVUU1 4
ASGNU1
line 1135
;1135:			ent.shaderRGBA[1] = 0;
ADDRLP4 0+80+1
CNSTU1 0
ASGNU1
line 1136
;1136:			ent.shaderRGBA[2] = 0;
ADDRLP4 0+80+2
CNSTU1 0
ASGNU1
line 1137
;1137:		}
ADDRGP4 $602
JUMPV
LABELV $601
line 1138
;1138:		else if (cent->currentState.trickedentindex3 == 2)
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 2
NEI4 $611
line 1139
;1139:		{ //light
line 1140
;1140:			ent.shaderRGBA[0] = wv*255;
ADDRLP4 416
CNSTF4 1132396544
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
ADDRLP4 420
CNSTF4 1325400064
ASGNF4
ADDRLP4 416
INDIRF4
ADDRLP4 420
INDIRF4
LTF4 $615
ADDRLP4 412
ADDRLP4 416
INDIRF4
ADDRLP4 420
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $616
JUMPV
LABELV $615
ADDRLP4 412
ADDRLP4 416
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $616
ADDRLP4 0+80
ADDRLP4 412
INDIRU4
CVUU1 4
ASGNU1
line 1141
;1141:			ent.shaderRGBA[1] = wv*255;
ADDRLP4 428
CNSTF4 1132396544
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
ADDRLP4 432
CNSTF4 1325400064
ASGNF4
ADDRLP4 428
INDIRF4
ADDRLP4 432
INDIRF4
LTF4 $620
ADDRLP4 424
ADDRLP4 428
INDIRF4
ADDRLP4 432
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $621
JUMPV
LABELV $620
ADDRLP4 424
ADDRLP4 428
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $621
ADDRLP4 0+80+1
ADDRLP4 424
INDIRU4
CVUU1 4
ASGNU1
line 1142
;1142:			ent.shaderRGBA[2] = wv*255;
ADDRLP4 440
CNSTF4 1132396544
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
ADDRLP4 444
CNSTF4 1325400064
ASGNF4
ADDRLP4 440
INDIRF4
ADDRLP4 444
INDIRF4
LTF4 $625
ADDRLP4 436
ADDRLP4 440
INDIRF4
ADDRLP4 444
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $626
JUMPV
LABELV $625
ADDRLP4 436
ADDRLP4 440
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $626
ADDRLP4 0+80+2
ADDRLP4 436
INDIRU4
CVUU1 4
ASGNU1
line 1143
;1143:		}
ADDRGP4 $612
JUMPV
LABELV $611
line 1145
;1144:		else
;1145:		{ //neutral
line 1146
;1146:			if ((s1->modelindex+128) == FP_SABERATTACK ||
ADDRLP4 412
ADDRLP4 212
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 128
ADDI4
ASGNI4
ADDRLP4 412
INDIRI4
CNSTI4 15
EQI4 $630
ADDRLP4 412
INDIRI4
CNSTI4 16
EQI4 $630
ADDRLP4 412
INDIRI4
CNSTI4 17
NEI4 $627
LABELV $630
line 1149
;1147:				(s1->modelindex+128) == FP_SABERDEFEND ||
;1148:				(s1->modelindex+128) == FP_SABERTHROW)
;1149:			{ //saber power
line 1150
;1150:				ent.shaderRGBA[0] = 0;
ADDRLP4 0+80
CNSTU1 0
ASGNU1
line 1151
;1151:				ent.shaderRGBA[1] = wv*255;
ADDRLP4 420
CNSTF4 1132396544
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
ADDRLP4 424
CNSTF4 1325400064
ASGNF4
ADDRLP4 420
INDIRF4
ADDRLP4 424
INDIRF4
LTF4 $635
ADDRLP4 416
ADDRLP4 420
INDIRF4
ADDRLP4 424
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $636
JUMPV
LABELV $635
ADDRLP4 416
ADDRLP4 420
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $636
ADDRLP4 0+80+1
ADDRLP4 416
INDIRU4
CVUU1 4
ASGNU1
line 1152
;1152:				ent.shaderRGBA[2] = 0;
ADDRLP4 0+80+2
CNSTU1 0
ASGNU1
line 1153
;1153:			}
ADDRGP4 $628
JUMPV
LABELV $627
line 1155
;1154:			else
;1155:			{
line 1156
;1156:				ent.shaderRGBA[0] = 0;
ADDRLP4 0+80
CNSTU1 0
ASGNU1
line 1157
;1157:				ent.shaderRGBA[1] = wv*255;
ADDRLP4 420
CNSTF4 1132396544
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
ADDRLP4 424
CNSTF4 1325400064
ASGNF4
ADDRLP4 420
INDIRF4
ADDRLP4 424
INDIRF4
LTF4 $643
ADDRLP4 416
ADDRLP4 420
INDIRF4
ADDRLP4 424
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $644
JUMPV
LABELV $643
ADDRLP4 416
ADDRLP4 420
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $644
ADDRLP4 0+80+1
ADDRLP4 416
INDIRU4
CVUU1 4
ASGNU1
line 1158
;1158:				ent.shaderRGBA[2] = wv*255;
ADDRLP4 432
CNSTF4 1132396544
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
ADDRLP4 436
CNSTF4 1325400064
ASGNF4
ADDRLP4 432
INDIRF4
ADDRLP4 436
INDIRF4
LTF4 $648
ADDRLP4 428
ADDRLP4 432
INDIRF4
ADDRLP4 436
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $649
JUMPV
LABELV $648
ADDRLP4 428
ADDRLP4 432
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $649
ADDRLP4 0+80+2
ADDRLP4 428
INDIRU4
CVUU1 4
ASGNU1
line 1159
;1159:			}
LABELV $628
line 1160
;1160:		}
LABELV $612
LABELV $602
line 1162
;1161:
;1162:		ent.modelScale[0] = 1.1;
ADDRLP4 0+196
CNSTF4 1066192077
ASGNF4
line 1163
;1163:		ent.modelScale[1] = 1.1;
ADDRLP4 0+196+4
CNSTF4 1066192077
ASGNF4
line 1164
;1164:		ent.modelScale[2] = 1.1;
ADDRLP4 0+196+8
CNSTF4 1066192077
ASGNF4
line 1166
;1165:
;1166:		ent.origin[2] -= 2;
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1167
;1167:		ScaleModelAxis(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 ScaleModelAxis
CALLV
pop
line 1169
;1168:
;1169:		trap_R_AddRefEntityToScene (&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1171
;1170:		
;1171:		VectorMA( ent.origin, 1, ent.axis[2], org );
ADDRLP4 412
CNSTF4 1065353216
ASGNF4
ADDRLP4 396
ADDRLP4 0+52
INDIRF4
ADDRLP4 412
INDIRF4
ADDRLP4 0+12+24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 396+4
ADDRLP4 0+52+4
INDIRF4
ADDRLP4 412
INDIRF4
ADDRLP4 0+12+24+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 396+8
ADDRLP4 0+52+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+12+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1173
;1172:
;1173:		org[2] += 18;
ADDRLP4 396+8
ADDRLP4 396+8
INDIRF4
CNSTF4 1099956224
ADDF4
ASGNF4
line 1175
;1174:
;1175:		wv = sin( cg.time * 0.002f ) * 0.08f + 0.1f; //* 0.08f + 0.1f;
CNSTF4 990057071
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 416
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 392
CNSTF4 1034147594
ADDRLP4 416
INDIRF4
MULF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1177
;1176:
;1177:		VectorCopy(org, fxSArgs.origin);
ADDRLP4 320
ADDRLP4 396
INDIRB
ASGNB 12
line 1178
;1178:		VectorClear(fxSArgs.vel);
ADDRLP4 420
CNSTF4 0
ASGNF4
ADDRLP4 320+12+8
ADDRLP4 420
INDIRF4
ASGNF4
ADDRLP4 320+12+4
ADDRLP4 420
INDIRF4
ASGNF4
ADDRLP4 320+12
ADDRLP4 420
INDIRF4
ASGNF4
line 1179
;1179:		VectorClear(fxSArgs.accel);
ADDRLP4 424
CNSTF4 0
ASGNF4
ADDRLP4 320+24+8
ADDRLP4 424
INDIRF4
ASGNF4
ADDRLP4 320+24+4
ADDRLP4 424
INDIRF4
ASGNF4
ADDRLP4 320+24
ADDRLP4 424
INDIRF4
ASGNF4
line 1180
;1180:		fxSArgs.scale = wv*120;//16.0f;
ADDRLP4 320+36
CNSTF4 1123024896
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
line 1181
;1181:		fxSArgs.dscale = wv*120;//16.0f;
ADDRLP4 320+40
CNSTF4 1123024896
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
line 1182
;1182:		fxSArgs.sAlpha = wv*12;
ADDRLP4 320+44
CNSTF4 1094713344
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
line 1183
;1183:		fxSArgs.eAlpha = wv*12;
ADDRLP4 320+48
CNSTF4 1094713344
ADDRLP4 392
INDIRF4
MULF4
ASGNF4
line 1184
;1184:		fxSArgs.rotation = 0.0f;
ADDRLP4 320+52
CNSTF4 0
ASGNF4
line 1185
;1185:		fxSArgs.bounce = 0.0f;
ADDRLP4 320+56
CNSTF4 0
ASGNF4
line 1186
;1186:		fxSArgs.life = 1.0f;
ADDRLP4 320+60
CNSTI4 1
ASGNI4
line 1188
;1187:
;1188:		fxSArgs.flags = 0x08000000|0x00000001;
ADDRLP4 320+68
CNSTI4 134217729
ASGNI4
line 1190
;1189:
;1190:		if (cent->currentState.trickedentindex3 == 1)
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 1
NEI4 $692
line 1191
;1191:		{ //dark
line 1192
;1192:			fxSArgs.sAlpha *= 3;
ADDRLP4 320+44
CNSTF4 1077936128
ADDRLP4 320+44
INDIRF4
MULF4
ASGNF4
line 1193
;1193:			fxSArgs.eAlpha *= 3;
ADDRLP4 320+48
CNSTF4 1077936128
ADDRLP4 320+48
INDIRF4
MULF4
ASGNF4
line 1194
;1194:			fxSArgs.shader = cgs.media.redSaberGlowShader;
ADDRLP4 320+64
ADDRGP4 cgs+70280+116
INDIRI4
ASGNI4
line 1195
;1195:			trap_FX_AddSprite(&fxSArgs);
ADDRLP4 320
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 1196
;1196:		}
ADDRGP4 $693
JUMPV
LABELV $692
line 1197
;1197:		else if (cent->currentState.trickedentindex3 == 2)
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 2
NEI4 $699
line 1198
;1198:		{ //light
line 1199
;1199:			fxSArgs.sAlpha *= 1.5;
ADDRLP4 320+44
CNSTF4 1069547520
ADDRLP4 320+44
INDIRF4
MULF4
ASGNF4
line 1200
;1200:			fxSArgs.eAlpha *= 1.5;
ADDRLP4 320+48
CNSTF4 1069547520
ADDRLP4 320+48
INDIRF4
MULF4
ASGNF4
line 1201
;1201:			fxSArgs.shader = cgs.media.redSaberGlowShader;
ADDRLP4 320+64
ADDRGP4 cgs+70280+116
INDIRI4
ASGNI4
line 1202
;1202:			trap_FX_AddSprite(&fxSArgs);
ADDRLP4 320
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 1203
;1203:			fxSArgs.shader = cgs.media.greenSaberGlowShader;
ADDRLP4 320+64
ADDRGP4 cgs+70280+140
INDIRI4
ASGNI4
line 1204
;1204:			trap_FX_AddSprite(&fxSArgs);
ADDRLP4 320
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 1205
;1205:			fxSArgs.shader = cgs.media.blueSaberGlowShader;
ADDRLP4 320+64
ADDRGP4 cgs+70280+148
INDIRI4
ASGNI4
line 1206
;1206:			trap_FX_AddSprite(&fxSArgs);
ADDRLP4 320
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 1207
;1207:		}
ADDRGP4 $700
JUMPV
LABELV $699
line 1209
;1208:		else
;1209:		{ //neutral
line 1210
;1210:			if ((s1->modelindex+128) == FP_SABERATTACK ||
ADDRLP4 428
ADDRLP4 212
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 128
ADDI4
ASGNI4
ADDRLP4 428
INDIRI4
CNSTI4 15
EQI4 $715
ADDRLP4 428
INDIRI4
CNSTI4 16
EQI4 $715
ADDRLP4 428
INDIRI4
CNSTI4 17
NEI4 $712
LABELV $715
line 1213
;1211:				(s1->modelindex+128) == FP_SABERDEFEND ||
;1212:				(s1->modelindex+128) == FP_SABERTHROW)
;1213:			{ //saber power
line 1214
;1214:				fxSArgs.sAlpha *= 1.5;
ADDRLP4 320+44
CNSTF4 1069547520
ADDRLP4 320+44
INDIRF4
MULF4
ASGNF4
line 1215
;1215:				fxSArgs.eAlpha *= 1.5;
ADDRLP4 320+48
CNSTF4 1069547520
ADDRLP4 320+48
INDIRF4
MULF4
ASGNF4
line 1216
;1216:				fxSArgs.shader = cgs.media.greenSaberGlowShader;
ADDRLP4 320+64
ADDRGP4 cgs+70280+140
INDIRI4
ASGNI4
line 1217
;1217:				trap_FX_AddSprite(&fxSArgs);
ADDRLP4 320
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 1218
;1218:			}
ADDRGP4 $713
JUMPV
LABELV $712
line 1220
;1219:			else
;1220:			{
line 1221
;1221:				fxSArgs.sAlpha *= 0.5;
ADDRLP4 320+44
CNSTF4 1056964608
ADDRLP4 320+44
INDIRF4
MULF4
ASGNF4
line 1222
;1222:				fxSArgs.eAlpha *= 0.5;
ADDRLP4 320+48
CNSTF4 1056964608
ADDRLP4 320+48
INDIRF4
MULF4
ASGNF4
line 1223
;1223:				fxSArgs.shader = cgs.media.greenSaberGlowShader;
ADDRLP4 320+64
ADDRGP4 cgs+70280+140
INDIRI4
ASGNI4
line 1224
;1224:				trap_FX_AddSprite(&fxSArgs);
ADDRLP4 320
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 1225
;1225:				fxSArgs.shader = cgs.media.blueSaberGlowShader;
ADDRLP4 320+64
ADDRGP4 cgs+70280+148
INDIRI4
ASGNI4
line 1226
;1226:				trap_FX_AddSprite(&fxSArgs);
ADDRLP4 320
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 1227
;1227:			}
LABELV $713
line 1228
;1228:		}
LABELV $700
LABELV $693
line 1229
;1229:	}
LABELV $594
LABELV $534
line 1231
;1230:
;1231:	if ( cent->currentState.time == -1 && cent->currentState.weapon == WP_TRIP_MINE && (cent->currentState.eFlags & EF_FIRING) )
ADDRLP4 320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 320
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $729
ADDRLP4 320
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
NEI4 $729
ADDRLP4 320
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $729
line 1232
;1232:	{ //if force sight is active, render the laser multiple times up to the force sight level to increase visibility
line 1233
;1233:		int i = 0;
ADDRLP4 324
CNSTI4 0
ASGNI4
line 1235
;1234:
;1235:		VectorMA( ent.origin, 6.6f, ent.axis[0], beamOrg );// forward
ADDRLP4 328
CNSTF4 1087583027
ASGNF4
ADDRLP4 216
ADDRLP4 0+52
INDIRF4
ADDRLP4 328
INDIRF4
ADDRLP4 0+12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 216+4
ADDRLP4 0+52+4
INDIRF4
ADDRLP4 328
INDIRF4
ADDRLP4 0+12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 216+8
ADDRLP4 0+52+8
INDIRF4
CNSTF4 1087583027
ADDRLP4 0+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1236
;1236:		beamID = cgs.effects.tripmineLaserFX;
ADDRLP4 228
ADDRGP4 cgs+71560+140
INDIRI4
ASGNI4
line 1238
;1237:
;1238:		if (cg.snap->ps.fd.forcePowersActive & (1 << FP_SEE))
ADDRGP4 cg+36
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $745
line 1239
;1239:		{
line 1240
;1240:			i = cg.snap->ps.fd.forcePowerLevel[FP_SEE];
ADDRLP4 324
ADDRGP4 cg+36
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $750
JUMPV
LABELV $749
line 1243
;1241:
;1242:			while (i > 0)
;1243:			{
line 1244
;1244:				trap_FX_PlayEffectID( beamID, beamOrg, cent->currentState.pos.trDelta );
ADDRLP4 228
INDIRI4
ARGI4
ADDRLP4 216
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1245
;1245:				trap_FX_PlayEffectID( beamID, beamOrg, cent->currentState.pos.trDelta );
ADDRLP4 228
INDIRI4
ARGI4
ADDRLP4 216
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1246
;1246:				i--;
ADDRLP4 324
ADDRLP4 324
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1247
;1247:			}
LABELV $750
line 1242
ADDRLP4 324
INDIRI4
CNSTI4 0
GTI4 $749
line 1248
;1248:		}
LABELV $745
line 1250
;1249:
;1250:		trap_FX_PlayEffectID( beamID, beamOrg, cent->currentState.pos.trDelta );
ADDRLP4 228
INDIRI4
ARGI4
ADDRLP4 216
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1251
;1251:	}
LABELV $729
line 1256
;1252:/*
;1253:Ghoul2 Insert Start
;1254:*/
;1255:
;1256:	if (cg_debugBB.integer)
ADDRGP4 cg_debugBB+12
INDIRI4
CNSTI4 0
EQI4 $752
line 1257
;1257:	{
line 1258
;1258:		CG_CreateBBRefEnts(s1, cent->lerpOrigin);
ADDRLP4 212
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 CG_CreateBBRefEnts
CALLV
pop
line 1259
;1259:	}
LABELV $752
line 1263
;1260:/*
;1261:Ghoul2 Insert End
;1262:*/
;1263:}
LABELV $236
endproc CG_General 464 44
proc CG_Speaker 16 16
line 1272
;1264:
;1265:/*
;1266:==================
;1267:CG_Speaker
;1268:
;1269:Speaker entities can automatically play sounds
;1270:==================
;1271:*/
;1272:static void CG_Speaker( centity_t *cent ) {
line 1273
;1273:	if (cent->currentState.trickedentindex)
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
EQI4 $756
line 1274
;1274:	{
line 1275
;1275:		trap_S_StopLoopingSound(cent->currentState.number);
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 1276
;1276:	}
LABELV $756
line 1278
;1277:
;1278:	if ( ! cent->currentState.clientNum ) {	// FIXME: use something other than clientNum...
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CNSTI4 0
NEI4 $758
line 1279
;1279:		return;		// not auto triggering
ADDRGP4 $755
JUMPV
LABELV $758
line 1282
;1280:	}
;1281:
;1282:	if ( cg.time < cent->miscTime ) {
ADDRGP4 cg+64
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
GEI4 $760
line 1283
;1283:		return;
ADDRGP4 $755
JUMPV
LABELV $760
line 1286
;1284:	}
;1285:
;1286:	trap_S_StartSound (NULL, cent->currentState.number, CHAN_ITEM, cgs.gameSounds[cent->currentState.eventParm] );
CNSTP4 0
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37372
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1290
;1287:
;1288:	//	ent->s.frame = ent->wait * 10;
;1289:	//	ent->s.clientNum = ent->random * 10;
;1290:	cent->miscTime = cg.time + cent->currentState.frame * 100 + cent->currentState.clientNum * 100 * crandom();
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 100
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 620
ADDP4
ADDRGP4 cg+64
INDIRI4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
MULI4
ADDI4
CVIF4 4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
CVIF4 4
CNSTF4 1073741824
ADDRLP4 4
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 1291
;1291:}
LABELV $755
endproc CG_Speaker 16 16
export CG_GreyItem
proc CG_GreyItem 4 0
line 1294
;1292:
;1293:qboolean CG_GreyItem(int type, int tag, int plSide)
;1294:{
line 1295
;1295:	if (type == IT_POWERUP &&
ADDRFP4 0
INDIRI4
CNSTI4 5
NEI4 $766
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
EQI4 $768
ADDRLP4 0
INDIRI4
CNSTI4 13
NEI4 $766
LABELV $768
line 1297
;1296:		(tag == PW_FORCE_ENLIGHTENED_LIGHT || tag == PW_FORCE_ENLIGHTENED_DARK))
;1297:	{
line 1298
;1298:		if (plSide == FORCE_LIGHTSIDE)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $769
line 1299
;1299:		{
line 1300
;1300:			if (tag == PW_FORCE_ENLIGHTENED_DARK)
ADDRFP4 4
INDIRI4
CNSTI4 13
NEI4 $770
line 1301
;1301:			{
line 1302
;1302:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $765
JUMPV
line 1304
;1303:			}
;1304:		}
LABELV $769
line 1305
;1305:		else if (plSide == FORCE_DARKSIDE)
ADDRFP4 8
INDIRI4
CNSTI4 2
NEI4 $773
line 1306
;1306:		{
line 1307
;1307:			if (tag == PW_FORCE_ENLIGHTENED_LIGHT)
ADDRFP4 4
INDIRI4
CNSTI4 12
NEI4 $775
line 1308
;1308:			{
line 1309
;1309:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $765
JUMPV
LABELV $775
line 1311
;1310:			}
;1311:		}
LABELV $773
LABELV $770
line 1312
;1312:	}
LABELV $766
line 1314
;1313:
;1314:	return qfalse;
CNSTI4 0
RETI4
LABELV $765
endproc CG_GreyItem 4 0
proc CG_Item 312 12
line 1322
;1315:}
;1316:
;1317:/*
;1318:==================
;1319:CG_Item
;1320:==================
;1321:*/
;1322:static void CG_Item( centity_t *cent ) {
line 1330
;1323:	refEntity_t		ent;
;1324:	entityState_t	*es;
;1325:	gitem_t			*item;
;1326:	int				msec;
;1327:	float			scale;
;1328:	weaponInfo_t	*wi;
;1329:
;1330:	es = &cent->currentState;
ADDRLP4 216
ADDRFP4 0
INDIRP4
ASGNP4
line 1331
;1331:	if ( es->modelindex >= bg_numItems ) {
ADDRLP4 216
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $778
line 1332
;1332:		CG_Error( "Bad item index %i on entity", es->modelindex );
ADDRGP4 $780
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1333
;1333:	}
LABELV $778
line 1339
;1334:
;1335:/*
;1336:Ghoul2 Insert Start
;1337:*/
;1338:
;1339:	if ((es->eFlags & EF_NODRAW) && (es->eFlags & EF_ITEMPLACEHOLDER))
ADDRLP4 232
ADDRLP4 216
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 236
CNSTI4 0
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 236
INDIRI4
EQI4 $781
ADDRLP4 232
INDIRI4
CNSTI4 4194304
BANDI4
ADDRLP4 236
INDIRI4
EQI4 $781
line 1340
;1340:	{
line 1341
;1341:		es->eFlags &= ~EF_NODRAW;
ADDRLP4 240
ADDRLP4 216
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 240
INDIRP4
ADDRLP4 240
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1342
;1342:	}
LABELV $781
line 1344
;1343:
;1344:	if ( !es->modelindex ) 
ADDRLP4 216
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
NEI4 $783
line 1345
;1345:	{
line 1346
;1346:		return;
ADDRGP4 $777
JUMPV
LABELV $783
line 1349
;1347:	}
;1348:
;1349:	item = &bg_itemlist[ es->modelindex ];
ADDRLP4 212
CNSTI4 52
ADDRLP4 216
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 1351
;1350:
;1351:	if ((item->giType == IT_WEAPON || item->giType == IT_POWERUP) &&
ADDRLP4 240
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 240
INDIRI4
CNSTI4 1
EQI4 $788
ADDRLP4 240
INDIRI4
CNSTI4 5
NEI4 $785
LABELV $788
ADDRLP4 244
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
ADDRLP4 244
INDIRI4
NEI4 $785
ADDRGP4 cg_simpleItems+12
INDIRI4
ADDRLP4 244
INDIRI4
NEI4 $785
line 1354
;1352:		!(cent->currentState.eFlags & EF_DROPPEDWEAPON) &&
;1353:		!cg_simpleItems.integer)
;1354:	{
line 1358
;1355:		vec3_t uNorm;
;1356:		qboolean doGrey;
;1357:		
;1358:		VectorClear(uNorm);
ADDRLP4 264
CNSTF4 0
ASGNF4
ADDRLP4 248+8
ADDRLP4 264
INDIRF4
ASGNF4
ADDRLP4 248+4
ADDRLP4 264
INDIRF4
ASGNF4
ADDRLP4 248
ADDRLP4 264
INDIRF4
ASGNF4
line 1360
;1359:
;1360:		uNorm[2] = 1;
ADDRLP4 248+8
CNSTF4 1065353216
ASGNF4
line 1362
;1361:
;1362:		memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1364
;1363:
;1364:		ent.customShader = 0;
ADDRLP4 0+76
CNSTI4 0
ASGNI4
line 1365
;1365:		VectorCopy(cent->lerpOrigin, ent.origin);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 1366
;1366:		VectorCopy( cent->currentState.angles, cent->lerpAngles );
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 268
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1367
;1367:		AnglesToAxis(cent->lerpAngles, ent.axis);
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1368
;1368:		ent.hModel = cgs.media.itemHoloModel;
ADDRLP4 0+8
ADDRGP4 cgs+70280+32
INDIRI4
ASGNI4
line 1370
;1369:
;1370:		doGrey = CG_GreyItem(item->giType, item->giTag, cg.snap->ps.fd.forceSide);
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
ARGI4
ADDRLP4 276
ADDRGP4 CG_GreyItem
CALLI4
ASGNI4
ADDRLP4 260
ADDRLP4 276
INDIRI4
ASGNI4
line 1372
;1371:
;1372:		if (doGrey)
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $799
line 1373
;1373:		{
line 1374
;1374:			ent.renderfx |= RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 1376
;1375:
;1376:			ent.shaderRGBA[0] = 150;
ADDRLP4 0+80
CNSTU1 150
ASGNU1
line 1377
;1377:			ent.shaderRGBA[1] = 150;
ADDRLP4 0+80+1
CNSTU1 150
ASGNU1
line 1378
;1378:			ent.shaderRGBA[2] = 150;
ADDRLP4 0+80+2
CNSTU1 150
ASGNU1
line 1379
;1379:		}
LABELV $799
line 1381
;1380:
;1381:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1383
;1382:
;1383:		if (!doGrey)
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $807
line 1384
;1384:		{
line 1385
;1385:			trap_FX_PlayEffectID(trap_FX_RegisterEffect("mp/itemcone.efx"), ent.origin, uNorm);
ADDRGP4 $809
ARGP4
ADDRLP4 280
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRLP4 0+52
ARGP4
ADDRLP4 248
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1386
;1386:		}
LABELV $807
line 1387
;1387:	}
LABELV $785
line 1390
;1388:
;1389:	// if set to invisible, skip
;1390:	if ( ( es->eFlags & EF_NODRAW ) ) 
ADDRLP4 216
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $811
line 1391
;1391:	{
line 1392
;1392:		return;
ADDRGP4 $777
JUMPV
LABELV $811
line 1398
;1393:	}
;1394:/*
;1395:Ghoul2 Insert End
;1396:*/
;1397:
;1398:	if ( cg_simpleItems.integer && item->giType != IT_TEAM ) {
ADDRGP4 cg_simpleItems+12
INDIRI4
CNSTI4 0
EQI4 $813
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $813
line 1399
;1399:		memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1400
;1400:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1401
;1401:		VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 1402
;1402:		ent.radius = 14;
ADDRLP4 0+92
CNSTF4 1096810496
ASGNF4
line 1403
;1403:		ent.customShader = cg_items[es->modelindex].icon;
ADDRLP4 0+76
CNSTI4 56
ADDRLP4 216
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ASGNI4
line 1404
;1404:		ent.shaderRGBA[0] = 255;
ADDRLP4 0+80
CNSTU1 255
ASGNU1
line 1405
;1405:		ent.shaderRGBA[1] = 255;
ADDRLP4 0+80+1
CNSTU1 255
ASGNU1
line 1406
;1406:		ent.shaderRGBA[2] = 255;
ADDRLP4 0+80+2
CNSTU1 255
ASGNU1
line 1408
;1407:
;1408:		ent.origin[2] += 16;
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1410
;1409:
;1410:		if (item->giType != IT_POWERUP || item->giTag != PW_FORCE_BOON)
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $829
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 14
EQI4 $827
LABELV $829
line 1411
;1411:		{
line 1412
;1412:			ent.renderfx |= RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1413
;1413:		}
LABELV $827
line 1415
;1414:
;1415:		if ( es->eFlags & EF_ITEMPLACEHOLDER )
ADDRLP4 216
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4194304
BANDI4
CNSTI4 0
EQI4 $831
line 1416
;1416:		{
line 1417
;1417:			if (item->giType == IT_POWERUP && item->giTag == PW_FORCE_BOON)
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $833
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 14
NEI4 $833
line 1418
;1418:			{
line 1419
;1419:				return;
ADDRGP4 $777
JUMPV
LABELV $833
line 1421
;1420:			}
;1421:			ent.shaderRGBA[0] = 200;
ADDRLP4 0+80
CNSTU1 200
ASGNU1
line 1422
;1422:			ent.shaderRGBA[1] = 200;
ADDRLP4 0+80+1
CNSTU1 200
ASGNU1
line 1423
;1423:			ent.shaderRGBA[2] = 200;
ADDRLP4 0+80+2
CNSTU1 200
ASGNU1
line 1424
;1424:			ent.shaderRGBA[3] = 150 + sin(cg.time*0.01)*30;
CNSTF4 1008981770
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 260
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 264
CNSTF4 1106247680
ADDRLP4 260
INDIRF4
MULF4
CNSTF4 1125515264
ADDF4
ASGNF4
ADDRLP4 268
CNSTF4 1325400064
ASGNF4
ADDRLP4 264
INDIRF4
ADDRLP4 268
INDIRF4
LTF4 $844
ADDRLP4 256
ADDRLP4 264
INDIRF4
ADDRLP4 268
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $845
JUMPV
LABELV $844
ADDRLP4 256
ADDRLP4 264
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $845
ADDRLP4 0+80+3
ADDRLP4 256
INDIRU4
CVUU1 4
ASGNU1
line 1425
;1425:		}
ADDRGP4 $832
JUMPV
LABELV $831
line 1427
;1426:		else
;1427:		{
line 1428
;1428:			ent.shaderRGBA[3] = 255;
ADDRLP4 0+80+3
CNSTU1 255
ASGNU1
line 1429
;1429:		}
LABELV $832
line 1431
;1430:
;1431:		if (CG_GreyItem(item->giType, item->giTag, cg.snap->ps.fd.forceSide))
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ADDRGP4 CG_GreyItem
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
EQI4 $848
line 1432
;1432:		{
line 1433
;1433:			ent.shaderRGBA[0] = 100;
ADDRLP4 0+80
CNSTU1 100
ASGNU1
line 1434
;1434:			ent.shaderRGBA[1] = 100;
ADDRLP4 0+80+1
CNSTU1 100
ASGNU1
line 1435
;1435:			ent.shaderRGBA[2] = 100;
ADDRLP4 0+80+2
CNSTU1 100
ASGNU1
line 1437
;1436:
;1437:			ent.shaderRGBA[3] = 200;
ADDRLP4 0+80+3
CNSTU1 200
ASGNU1
line 1439
;1438:
;1439:			if (item->giTag == PW_FORCE_ENLIGHTENED_LIGHT)
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $858
line 1440
;1440:			{
line 1441
;1441:				ent.customShader = trap_R_RegisterShader("gfx/misc/mp_light_enlight_disable");
ADDRGP4 $861
ARGP4
ADDRLP4 260
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0+76
ADDRLP4 260
INDIRI4
ASGNI4
line 1442
;1442:			}
ADDRGP4 $859
JUMPV
LABELV $858
line 1444
;1443:			else
;1444:			{
line 1445
;1445:				ent.customShader = trap_R_RegisterShader("gfx/misc/mp_dark_enlight_disable");
ADDRGP4 $863
ARGP4
ADDRLP4 260
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0+76
ADDRLP4 260
INDIRI4
ASGNI4
line 1446
;1446:			}
LABELV $859
line 1447
;1447:		}
LABELV $848
line 1448
;1448:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1449
;1449:		return;
ADDRGP4 $777
JUMPV
LABELV $813
line 1452
;1450:	}
;1451:
;1452:	if ((item->giType == IT_WEAPON || item->giType == IT_POWERUP) &&
ADDRLP4 248
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 1
EQI4 $866
ADDRLP4 248
INDIRI4
CNSTI4 5
NEI4 $864
LABELV $866
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
CNSTI4 0
NEI4 $864
line 1454
;1453:		!(cent->currentState.eFlags & EF_DROPPEDWEAPON))
;1454:	{
line 1455
;1455:		cent->lerpOrigin[2] += 16;
ADDRLP4 252
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 252
INDIRP4
ADDRLP4 252
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1456
;1456:	}
LABELV $864
line 1458
;1457:
;1458:	if ((!(cent->currentState.eFlags & EF_DROPPEDWEAPON) || item->giType == IT_POWERUP) &&
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
CNSTI4 0
EQI4 $869
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $867
LABELV $869
ADDRLP4 252
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 252
INDIRI4
CNSTI4 1
EQI4 $870
ADDRLP4 252
INDIRI4
CNSTI4 5
NEI4 $867
LABELV $870
line 1460
;1459:		(item->giType == IT_WEAPON || item->giType == IT_POWERUP))
;1460:	{
line 1462
;1461:		// items bob up and down continuously
;1462:		scale = 0.005 + cent->currentState.number * 0.00001;
ADDRLP4 228
CNSTF4 925353388
ADDRFP4 0
INDIRP4
INDIRI4
CVIF4 4
MULF4
CNSTF4 1000593162
ADDF4
ASGNF4
line 1463
;1463:		cent->lerpOrigin[2] += 4 + cos( ( cg.time + 1000 ) *  scale ) * 4;
ADDRGP4 cg+64
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
ADDRLP4 228
INDIRF4
MULF4
ARGF4
ADDRLP4 256
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 260
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 260
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 256
INDIRF4
MULF4
CNSTF4 1082130432
ADDF4
ADDF4
ASGNF4
line 1464
;1464:	}
ADDRGP4 $868
JUMPV
LABELV $867
line 1466
;1465:	else
;1466:	{
line 1467
;1467:		if (item->giType == IT_HOLDABLE)
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 6
NEI4 $872
line 1468
;1468:		{
line 1469
;1469:			if (item->giTag == HI_SEEKER)
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
NEI4 $874
line 1470
;1470:			{
line 1471
;1471:				cent->lerpOrigin[2] += 5;
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 256
INDIRP4
ADDRLP4 256
INDIRP4
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 1472
;1472:			}
LABELV $874
line 1473
;1473:			if (item->giTag == HI_SHIELD)
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $876
line 1474
;1474:			{
line 1475
;1475:				cent->lerpOrigin[2] += 2;
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 256
INDIRP4
ADDRLP4 256
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 1476
;1476:			}
LABELV $876
line 1477
;1477:			if (item->giTag == HI_BINOCULARS)
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 5
NEI4 $878
line 1478
;1478:			{
line 1479
;1479:				cent->lerpOrigin[2] += 2;
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 256
INDIRP4
ADDRLP4 256
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 1480
;1480:			}
LABELV $878
line 1481
;1481:		}
LABELV $872
line 1482
;1482:		if (item->giType == IT_HEALTH)
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 4
NEI4 $880
line 1483
;1483:		{
line 1484
;1484:			cent->lerpOrigin[2] += 2;
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 256
INDIRP4
ADDRLP4 256
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 1485
;1485:		}
LABELV $880
line 1486
;1486:		if (item->giType == IT_ARMOR)
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $882
line 1487
;1487:		{
line 1488
;1488:			if (item->quantity == 100)
ADDRLP4 212
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
NEI4 $884
line 1489
;1489:			{
line 1490
;1490:				cent->lerpOrigin[2] += 7;
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 256
INDIRP4
ADDRLP4 256
INDIRP4
INDIRF4
CNSTF4 1088421888
ADDF4
ASGNF4
line 1491
;1491:			}
LABELV $884
line 1492
;1492:		}
LABELV $882
line 1493
;1493:	}
LABELV $868
line 1495
;1494:
;1495:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1497
;1496:
;1497:	if ( (!(cent->currentState.eFlags & EF_DROPPEDWEAPON) || item->giType == IT_POWERUP) &&
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
CNSTI4 0
EQI4 $888
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $886
LABELV $888
ADDRLP4 256
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 1
EQI4 $889
ADDRLP4 256
INDIRI4
CNSTI4 5
NEI4 $886
LABELV $889
line 1499
;1498:		(item->giType == IT_WEAPON || item->giType == IT_POWERUP) )
;1499:	{ //only weapons and powerups rotate now
line 1501
;1500:		// autorotate at one of two speeds
;1501:		VectorCopy( cg.autoAngles, cent->lerpAngles );
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
ADDRGP4 cg+3508
INDIRB
ASGNB 12
line 1502
;1502:		AxisCopy( cg.autoAxis, ent.axis );
ADDRGP4 cg+3520
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 1503
;1503:	}
ADDRGP4 $887
JUMPV
LABELV $886
line 1505
;1504:	else
;1505:	{
line 1506
;1506:		VectorCopy( cent->currentState.angles, cent->lerpAngles );
ADDRLP4 260
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 260
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 260
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1507
;1507:		AnglesToAxis(cent->lerpAngles, ent.axis);
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1508
;1508:	}
LABELV $887
line 1510
;1509:
;1510:	wi = NULL;
ADDRLP4 220
CNSTP4 0
ASGNP4
line 1514
;1511:	// the weapons have their origin where they attatch to player
;1512:	// models, so we need to offset them or they will rotate
;1513:	// eccentricly
;1514:	if (!(cent->currentState.eFlags & EF_DROPPEDWEAPON))
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
CNSTI4 0
NEI4 $894
line 1515
;1515:	{
line 1516
;1516:		if ( item->giType == IT_WEAPON ) {
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $895
line 1517
;1517:			wi = &cg_weapons[item->giTag];
ADDRLP4 220
CNSTI4 208
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 1518
;1518:			cent->lerpOrigin[0] -= 
ADDRLP4 260
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 260
INDIRP4
INDIRF4
ADDRLP4 220
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+12
INDIRF4
MULF4
ADDRLP4 220
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+12+12
INDIRF4
MULF4
ADDF4
ADDRLP4 220
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0+12+24
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 1522
;1519:				wi->weaponMidpoint[0] * ent.axis[0][0] +
;1520:				wi->weaponMidpoint[1] * ent.axis[1][0] +
;1521:				wi->weaponMidpoint[2] * ent.axis[2][0];
;1522:			cent->lerpOrigin[1] -= 
ADDRLP4 268
ADDRFP4 0
INDIRP4
CNSTI4 932
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ADDRLP4 268
INDIRP4
INDIRF4
ADDRLP4 220
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
MULF4
ADDRLP4 220
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+12+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 220
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0+12+24+4
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 1526
;1523:				wi->weaponMidpoint[0] * ent.axis[0][1] +
;1524:				wi->weaponMidpoint[1] * ent.axis[1][1] +
;1525:				wi->weaponMidpoint[2] * ent.axis[2][1];
;1526:			cent->lerpOrigin[2] -= 
ADDRLP4 276
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 276
INDIRP4
ADDRLP4 276
INDIRP4
INDIRF4
ADDRLP4 220
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+12+8
INDIRF4
MULF4
ADDRLP4 220
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+12+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 220
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0+12+24+8
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 1531
;1527:				wi->weaponMidpoint[0] * ent.axis[0][2] +
;1528:				wi->weaponMidpoint[1] * ent.axis[1][2] +
;1529:				wi->weaponMidpoint[2] * ent.axis[2][2];
;1530:
;1531:			cent->lerpOrigin[2] += 8;	// an extra height boost
ADDRLP4 284
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
ADDRLP4 284
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1532
;1532:		}
line 1533
;1533:	}
ADDRGP4 $895
JUMPV
LABELV $894
line 1535
;1534:	else
;1535:	{
line 1536
;1536:		wi = &cg_weapons[item->giTag];
ADDRLP4 220
CNSTI4 208
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 1538
;1537:
;1538:		switch(item->giTag)
ADDRLP4 260
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 4
LTI4 $919
ADDRLP4 260
INDIRI4
CNSTI4 13
GTI4 $919
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $932-16
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $932
address $922
address $923
address $924
address $925
address $926
address $927
address $928
address $929
address $930
address $931
code
line 1539
;1539:		{
LABELV $922
line 1541
;1540:		case WP_BLASTER:
;1541:			cent->lerpOrigin[2] -= 12;
ADDRLP4 268
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ADDRLP4 268
INDIRP4
INDIRF4
CNSTF4 1094713344
SUBF4
ASGNF4
line 1542
;1542:			break;
ADDRGP4 $920
JUMPV
LABELV $923
line 1544
;1543:		case WP_DISRUPTOR:
;1544:			cent->lerpOrigin[2] -= 13;
ADDRLP4 272
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 272
INDIRP4
ADDRLP4 272
INDIRP4
INDIRF4
CNSTF4 1095761920
SUBF4
ASGNF4
line 1545
;1545:			break;
ADDRGP4 $920
JUMPV
LABELV $924
line 1547
;1546:		case WP_BOWCASTER:
;1547:			cent->lerpOrigin[2] -= 16;
ADDRLP4 276
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 276
INDIRP4
ADDRLP4 276
INDIRP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1548
;1548:			break;
ADDRGP4 $920
JUMPV
LABELV $925
line 1550
;1549:		case WP_REPEATER:
;1550:			cent->lerpOrigin[2] -= 12;
ADDRLP4 280
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
INDIRF4
CNSTF4 1094713344
SUBF4
ASGNF4
line 1551
;1551:			break;
ADDRGP4 $920
JUMPV
LABELV $926
line 1553
;1552:		case WP_DEMP2:
;1553:			cent->lerpOrigin[2] -= 10;
ADDRLP4 284
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
ADDRLP4 284
INDIRP4
INDIRF4
CNSTF4 1092616192
SUBF4
ASGNF4
line 1554
;1554:			break;
ADDRGP4 $920
JUMPV
LABELV $927
line 1556
;1555:		case WP_FLECHETTE:
;1556:			cent->lerpOrigin[2] -= 6;
ADDRLP4 288
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 288
INDIRP4
ADDRLP4 288
INDIRP4
INDIRF4
CNSTF4 1086324736
SUBF4
ASGNF4
line 1557
;1557:			break;
ADDRGP4 $920
JUMPV
LABELV $928
line 1559
;1558:		case WP_ROCKET_LAUNCHER:
;1559:			cent->lerpOrigin[2] -= 11;
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 292
INDIRP4
ADDRLP4 292
INDIRP4
INDIRF4
CNSTF4 1093664768
SUBF4
ASGNF4
line 1560
;1560:			break;
ADDRGP4 $920
JUMPV
LABELV $929
line 1562
;1561:		case WP_THERMAL:
;1562:			cent->lerpOrigin[2] -= 12;
ADDRLP4 296
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 296
INDIRP4
ADDRLP4 296
INDIRP4
INDIRF4
CNSTF4 1094713344
SUBF4
ASGNF4
line 1563
;1563:			break;
ADDRGP4 $920
JUMPV
LABELV $930
line 1565
;1564:		case WP_TRIP_MINE:
;1565:			cent->lerpOrigin[2] -= 16;
ADDRLP4 300
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 300
INDIRP4
ADDRLP4 300
INDIRP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1566
;1566:			break;
ADDRGP4 $920
JUMPV
LABELV $931
line 1568
;1567:		case WP_DET_PACK:
;1568:			cent->lerpOrigin[2] -= 16;
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 304
INDIRP4
ADDRLP4 304
INDIRP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1569
;1569:			break;
ADDRGP4 $920
JUMPV
LABELV $919
line 1571
;1570:		default:
;1571:			cent->lerpOrigin[2] -= 8;
ADDRLP4 308
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ASGNP4
ADDRLP4 308
INDIRP4
ADDRLP4 308
INDIRP4
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1572
;1572:			break;
LABELV $920
line 1574
;1573:		}
;1574:	}
LABELV $895
line 1576
;1575:
;1576:	ent.hModel = cg_items[es->modelindex].models[0];
ADDRLP4 0+8
CNSTI4 56
ADDRLP4 216
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+4
ADDP4
INDIRI4
ASGNI4
line 1580
;1577:/*
;1578:Ghoul2 Insert Start
;1579:*/
;1580:	ent.ghoul2 = cg_items[es->modelindex].g2Models[0];
ADDRLP4 0+208
CNSTI4 56
ADDRLP4 216
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+24
ADDP4
INDIRP4
ASGNP4
line 1581
;1581:	ent.radius = cg_items[es->modelindex].radius[0];
ADDRLP4 0+92
CNSTI4 56
ADDRLP4 216
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+40
ADDP4
INDIRF4
ASGNF4
line 1582
;1582:	VectorCopy (cent->lerpAngles, ent.angles);
ADDRLP4 0+184
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 1586
;1583:/*
;1584:Ghoul2 Insert End
;1585:*/
;1586:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 1587
;1587:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+64
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 1589
;1588:
;1589:	ent.nonNormalizedAxes = qfalse;
ADDRLP4 0+48
CNSTI4 0
ASGNI4
line 1593
;1590:
;1591:	// if just respawned, slowly scale up
;1592:	
;1593:	msec = cg.time - cent->miscTime;
ADDRLP4 224
ADDRGP4 cg+64
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1595
;1594:
;1595:	if (CG_GreyItem(item->giType, item->giTag, cg.snap->ps.fd.forceSide))
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1220
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ADDRGP4 CG_GreyItem
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $945
line 1596
;1596:	{
line 1597
;1597:		ent.renderfx |= RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 1599
;1598:
;1599:		ent.shaderRGBA[0] = 150;
ADDRLP4 0+80
CNSTU1 150
ASGNU1
line 1600
;1600:		ent.shaderRGBA[1] = 150;
ADDRLP4 0+80+1
CNSTU1 150
ASGNU1
line 1601
;1601:		ent.shaderRGBA[2] = 150;
ADDRLP4 0+80+2
CNSTU1 150
ASGNU1
line 1603
;1602:
;1603:		ent.renderfx |= RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1605
;1604:
;1605:		ent.shaderRGBA[3] = 200;
ADDRLP4 0+80+3
CNSTU1 200
ASGNU1
line 1607
;1606:
;1607:		if (item->giTag == PW_FORCE_ENLIGHTENED_LIGHT)
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $957
line 1608
;1608:		{
line 1609
;1609:			ent.customShader = trap_R_RegisterShader("gfx/misc/mp_light_enlight_disable");
ADDRGP4 $861
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0+76
ADDRLP4 268
INDIRI4
ASGNI4
line 1610
;1610:		}
ADDRGP4 $958
JUMPV
LABELV $957
line 1612
;1611:		else
;1612:		{
line 1613
;1613:			ent.customShader = trap_R_RegisterShader("gfx/misc/mp_dark_enlight_disable");
ADDRGP4 $863
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0+76
ADDRLP4 268
INDIRI4
ASGNI4
line 1614
;1614:		}
LABELV $958
line 1616
;1615:
;1616:		trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1617
;1617:		return;
ADDRGP4 $777
JUMPV
LABELV $945
line 1620
;1618:	}
;1619:
;1620:	if ( es->eFlags & EF_ITEMPLACEHOLDER )		// item has been picked up
ADDRLP4 216
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4194304
BANDI4
CNSTI4 0
EQI4 $961
line 1621
;1621:	{
line 1622
;1622:		if ( es->eFlags & EF_DEAD )				// if item had been droped, don't show at all
ADDRLP4 216
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $963
line 1623
;1623:			return;
ADDRGP4 $777
JUMPV
LABELV $963
line 1625
;1624:
;1625:		ent.renderfx |= RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 1626
;1626:		ent.shaderRGBA[0] = 0;
ADDRLP4 0+80
CNSTU1 0
ASGNU1
line 1627
;1627:		ent.shaderRGBA[1] = 200;
ADDRLP4 0+80+1
CNSTU1 200
ASGNU1
line 1628
;1628:		ent.shaderRGBA[2] = 85;
ADDRLP4 0+80+2
CNSTU1 85
ASGNU1
line 1629
;1629:		ent.customShader = cgs.media.itemRespawningPlaceholder;
ADDRLP4 0+76
ADDRGP4 cgs+70280+492
INDIRI4
ASGNI4
line 1630
;1630:	}
LABELV $961
line 1633
;1631:
;1632:	// increase the size of the weapons when they are presented as items
;1633:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $974
line 1634
;1634:		VectorScale( ent.axis[0], 1.5, ent.axis[0] );
ADDRLP4 0+12
CNSTF4 1069547520
ADDRLP4 0+12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+4
CNSTF4 1069547520
ADDRLP4 0+12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+8
CNSTF4 1069547520
ADDRLP4 0+12+8
INDIRF4
MULF4
ASGNF4
line 1635
;1635:		VectorScale( ent.axis[1], 1.5, ent.axis[1] );
ADDRLP4 0+12+12
CNSTF4 1069547520
ADDRLP4 0+12+12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+12+4
CNSTF4 1069547520
ADDRLP4 0+12+12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+12+8
CNSTF4 1069547520
ADDRLP4 0+12+12+8
INDIRF4
MULF4
ASGNF4
line 1636
;1636:		VectorScale( ent.axis[2], 1.5, ent.axis[2] );
ADDRLP4 0+12+24
CNSTF4 1069547520
ADDRLP4 0+12+24
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+24+4
CNSTF4 1069547520
ADDRLP4 0+12+24+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+24+8
CNSTF4 1069547520
ADDRLP4 0+12+24+8
INDIRF4
MULF4
ASGNF4
line 1637
;1637:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+48
CNSTI4 1
ASGNI4
line 1639
;1638:		//trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.weaponHoverSound );
;1639:	}
LABELV $974
line 1641
;1640:
;1641:	if (!(cent->currentState.eFlags & EF_DROPPEDWEAPON) &&
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
CNSTI4 0
NEI4 $1019
ADDRLP4 268
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 1
EQI4 $1021
ADDRLP4 268
INDIRI4
CNSTI4 5
NEI4 $1019
LABELV $1021
line 1643
;1642:		(item->giType == IT_WEAPON || item->giType == IT_POWERUP))
;1643:	{
line 1644
;1644:		ent.renderfx |= RF_MINLIGHT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1645
;1645:	}
LABELV $1019
line 1647
;1646:
;1647:	if (item->giType != IT_TEAM && msec >= 0 && msec < ITEM_SCALEUP_TIME && !(es->eFlags & EF_ITEMPLACEHOLDER) && !(es->eFlags & EF_DROPPEDWEAPON)) 
ADDRLP4 272
CNSTI4 8
ASGNI4
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 272
INDIRI4
EQI4 $1023
ADDRLP4 280
CNSTI4 0
ASGNI4
ADDRLP4 224
INDIRI4
ADDRLP4 280
INDIRI4
LTI4 $1023
ADDRLP4 224
INDIRI4
CNSTI4 1000
GEI4 $1023
ADDRLP4 284
ADDRLP4 216
INDIRP4
ADDRLP4 272
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 4194304
BANDI4
ADDRLP4 280
INDIRI4
NEI4 $1023
ADDRLP4 284
INDIRI4
CNSTI4 16777216
BANDI4
ADDRLP4 280
INDIRI4
NEI4 $1023
line 1648
;1648:	{	// if just respawned, fade in, but don't do this for flags.
line 1652
;1649:		float alpha;
;1650:		int a;
;1651:		
;1652:		alpha = (float)msec / ITEM_SCALEUP_TIME;
ADDRLP4 292
ADDRLP4 224
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 1653
;1653:		a = alpha * 255.0;
ADDRLP4 288
CNSTF4 1132396544
ADDRLP4 292
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1654
;1654:		if (a <= 0)
ADDRLP4 288
INDIRI4
CNSTI4 0
GTI4 $1025
line 1655
;1655:			a=1;
ADDRLP4 288
CNSTI4 1
ASGNI4
LABELV $1025
line 1657
;1656:
;1657:		ent.shaderRGBA[3] = a;
ADDRLP4 0+80+3
ADDRLP4 288
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 1658
;1658:		if (item->giType != IT_POWERUP || item->giTag != PW_FORCE_BOON)
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1031
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 14
EQI4 $1029
LABELV $1031
line 1659
;1659:		{ //boon model uses a different blending mode for the sprite inside and doesn't look proper with this method
line 1660
;1660:			ent.renderfx |= RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1661
;1661:		}
LABELV $1029
line 1662
;1662:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1664
;1663:		
;1664:		ent.renderfx &= ~RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 1670
;1665:	
;1666:		// Now draw the static shader over it.
;1667:		// Alpha in over half the time, out over half.
;1668:		
;1669:		//alpha = sin(M_PI*alpha);
;1670:		a = alpha * 255.0;
ADDRLP4 288
CNSTF4 1132396544
ADDRLP4 292
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1672
;1671:
;1672:		a = 255 - a;
ADDRLP4 288
CNSTI4 255
ADDRLP4 288
INDIRI4
SUBI4
ASGNI4
line 1674
;1673:
;1674:		if (a <= 0)
ADDRLP4 288
INDIRI4
CNSTI4 0
GTI4 $1034
line 1675
;1675:			a=1;
ADDRLP4 288
CNSTI4 1
ASGNI4
LABELV $1034
line 1676
;1676:		if (a > 255)
ADDRLP4 288
INDIRI4
CNSTI4 255
LEI4 $1036
line 1677
;1677:			a=255;
ADDRLP4 288
CNSTI4 255
ASGNI4
LABELV $1036
line 1679
;1678:
;1679:		ent.customShader = cgs.media.itemRespawningRezOut;
ADDRLP4 0+76
ADDRGP4 cgs+70280+496
INDIRI4
ASGNI4
line 1698
;1680:
;1681:		/*
;1682:		ent.shaderRGBA[0] = 0;
;1683:		ent.shaderRGBA[1] = a;
;1684:		ent.shaderRGBA[2] = a-100;
;1685:
;1686:		if (ent.shaderRGBA[2] < 0)
;1687:		{
;1688:			ent.shaderRGBA[2] = 0;
;1689:		}
;1690:		*/
;1691:
;1692:		/*
;1693:		ent.shaderRGBA[0] =
;1694:		ent.shaderRGBA[1] =
;1695:		ent.shaderRGBA[2] = a;
;1696:		*/
;1697:
;1698:		ent.renderfx |= RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 1699
;1699:		ent.shaderRGBA[0] = 0;
ADDRLP4 0+80
CNSTU1 0
ASGNU1
line 1700
;1700:		ent.shaderRGBA[1] = 200;
ADDRLP4 0+80+1
CNSTU1 200
ASGNU1
line 1701
;1701:		ent.shaderRGBA[2] = 85;
ADDRLP4 0+80+2
CNSTU1 85
ASGNU1
line 1703
;1702:
;1703:		trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1704
;1704:	}
ADDRGP4 $1024
JUMPV
LABELV $1023
line 1706
;1705:	else
;1706:	{	// add to refresh list  -- normal item
line 1707
;1707:		if (item->giType == IT_TEAM &&
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1047
ADDRLP4 292
ADDRLP4 212
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 4
EQI4 $1049
ADDRLP4 292
INDIRI4
CNSTI4 5
NEI4 $1047
LABELV $1049
line 1709
;1708:			(item->giTag == PW_REDFLAG || item->giTag == PW_BLUEFLAG))
;1709:		{
line 1710
;1710:			ent.modelScale[0] = 0.7;
ADDRLP4 0+196
CNSTF4 1060320051
ASGNF4
line 1711
;1711:			ent.modelScale[1] = 0.7;
ADDRLP4 0+196+4
CNSTF4 1060320051
ASGNF4
line 1712
;1712:			ent.modelScale[2] = 0.7;
ADDRLP4 0+196+8
CNSTF4 1060320051
ASGNF4
line 1713
;1713:			ScaleModelAxis(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 ScaleModelAxis
CALLV
pop
line 1714
;1714:		}
LABELV $1047
line 1715
;1715:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1716
;1716:	}
LABELV $1024
line 1743
;1717:
;1718:	//rww - As far as I can see, this is useless.
;1719:	/*
;1720:	if ( item->giType == IT_WEAPON && wi->barrelModel ) {
;1721:		refEntity_t	barrel;
;1722:
;1723:		memset( &barrel, 0, sizeof( barrel ) );
;1724:
;1725:		barrel.hModel = wi->barrelModel;
;1726:
;1727:		VectorCopy( ent.lightingOrigin, barrel.lightingOrigin );
;1728:		barrel.shadowPlane = ent.shadowPlane;
;1729:		barrel.renderfx = ent.renderfx;
;1730:
;1731:		barrel.customShader = ent.customShader;
;1732:
;1733:		CG_PositionRotatedEntityOnTag( &barrel, &ent, wi->weaponModel, "tag_barrel" );
;1734:
;1735:		AxisCopy( ent.axis, barrel.axis );
;1736:		barrel.nonNormalizedAxes = ent.nonNormalizedAxes;
;1737:
;1738:		trap_R_AddRefEntityToScene( &barrel );
;1739:	}
;1740:	*/
;1741:
;1742:	// accompanying rings / spheres for powerups
;1743:	if ( !cg_simpleItems.integer ) 
ADDRGP4 cg_simpleItems+12
INDIRI4
CNSTI4 0
NEI4 $1055
line 1744
;1744:	{
line 1747
;1745:		vec3_t spinAngles;
;1746:
;1747:		VectorClear( spinAngles );
ADDRLP4 300
CNSTF4 0
ASGNF4
ADDRLP4 288+8
ADDRLP4 300
INDIRF4
ASGNF4
ADDRLP4 288+4
ADDRLP4 300
INDIRF4
ASGNF4
ADDRLP4 288
ADDRLP4 300
INDIRF4
ASGNF4
line 1749
;1748:
;1749:		if ( item->giType == IT_HEALTH || item->giType == IT_POWERUP )
ADDRLP4 304
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 4
EQI4 $1062
ADDRLP4 304
INDIRI4
CNSTI4 5
NEI4 $1060
LABELV $1062
line 1750
;1750:		{
line 1751
;1751:			if ( ( ent.hModel = cg_items[es->modelindex].models[1] ) != 0 )
ADDRLP4 308
CNSTI4 56
ADDRLP4 216
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+4+4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 308
INDIRI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $1063
line 1752
;1752:			{
line 1753
;1753:				if ( item->giType == IT_POWERUP )
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1068
line 1754
;1754:				{
line 1755
;1755:					ent.origin[2] += 12;
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 1756
;1756:					spinAngles[1] = ( cg.time & 1023 ) * 360 / -1024.0f;
ADDRLP4 288+4
CNSTI4 360
ADDRGP4 cg+64
INDIRI4
CNSTI4 1023
BANDI4
MULI4
CVIF4 4
CNSTF4 3296722944
DIVF4
ASGNF4
line 1757
;1757:				}
LABELV $1068
line 1758
;1758:				AnglesToAxis( spinAngles, ent.axis );
ADDRLP4 288
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1760
;1759:				
;1760:				trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1761
;1761:			}
LABELV $1063
line 1762
;1762:		}
LABELV $1060
line 1763
;1763:	}
LABELV $1055
line 1764
;1764:}
LABELV $777
endproc CG_Item 312 12
proc CG_Missile 376 28
line 1773
;1765:
;1766://============================================================================
;1767:
;1768:/*
;1769:===============
;1770:CG_Missile
;1771:===============
;1772:*/
;1773:static void CG_Missile( centity_t *cent ) {
line 1779
;1774:	refEntity_t			ent;
;1775:	entityState_t		*s1;
;1776:	const weaponInfo_t		*weapon;
;1777://	int	col;
;1778:
;1779:	s1 = &cent->currentState;
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
line 1780
;1780:	if ( s1->weapon > WP_NUM_WEAPONS && s1->weapon != G2_MODEL_PART ) {
ADDRLP4 220
ADDRLP4 212
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 16
LEI4 $1076
ADDRLP4 220
INDIRI4
CNSTI4 50
EQI4 $1076
line 1781
;1781:		s1->weapon = 0;
ADDRLP4 212
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 0
ASGNI4
line 1782
;1782:	}
LABELV $1076
line 1784
;1783:
;1784:	if (cent->ghoul2 && s1->weapon == G2_MODEL_PART)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1078
ADDRLP4 212
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 50
NEI4 $1078
line 1785
;1785:	{
line 1786
;1786:		weapon = &cg_weapons[WP_SABER];
ADDRLP4 216
ADDRGP4 cg_weapons+416
ASGNP4
line 1787
;1787:	}
ADDRGP4 $1079
JUMPV
LABELV $1078
line 1789
;1788:	else
;1789:	{
line 1790
;1790:		weapon = &cg_weapons[s1->weapon];
ADDRLP4 216
CNSTI4 208
ADDRLP4 212
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 1791
;1791:	}
LABELV $1079
line 1793
;1792:
;1793:	if (s1->weapon == WP_SABER)
ADDRLP4 212
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1081
line 1794
;1794:	{
line 1795
;1795:		if (!cent->ghoul2 && !(s1->eFlags & EF_NODRAW))
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1083
ADDRLP4 212
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $1083
line 1796
;1796:		{
line 1797
;1797:			trap_G2API_InitGhoul2Model(&cent->ghoul2, "models/weapons2/saber/saber_w.glm", 0, 0, 0, 0, 0);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
ADDRGP4 $1085
ARGP4
ADDRLP4 224
CNSTI4 0
ASGNI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRGP4 trap_G2API_InitGhoul2Model
CALLI4
pop
line 1798
;1798:			return;
ADDRGP4 $1075
JUMPV
LABELV $1083
line 1800
;1799:		}
;1800:		else if (s1->eFlags & EF_NODRAW)
ADDRLP4 212
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1086
line 1801
;1801:		{
line 1802
;1802:			return;
ADDRGP4 $1075
JUMPV
LABELV $1086
line 1804
;1803:		}
;1804:	}
LABELV $1081
line 1806
;1805:
;1806:	if (cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1088
line 1807
;1807:	{ //give us a proper radius
line 1808
;1808:		ent.radius = cent->currentState.g2radius;
ADDRLP4 0+92
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1809
;1809:	}
LABELV $1088
line 1812
;1810:
;1811:	// calculate the axis
;1812:	VectorCopy( s1->angles, cent->lerpAngles);
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 212
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1814
;1813:
;1814:	if ( cent->currentState.eFlags & EF_ALT_FIRING )
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1091
line 1815
;1815:	{
line 1817
;1816:		// add trails
;1817:		if ( weapon->altMissileTrailFunc )  
ADDRLP4 216
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1093
line 1818
;1818:			weapon->altMissileTrailFunc( cent, weapon );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLV
pop
LABELV $1093
line 1821
;1819:
;1820:		// add dynamic light
;1821:		if ( weapon->altMissileDlight ) 
ADDRLP4 216
INDIRP4
CNSTI4 172
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1095
line 1822
;1822:		{
line 1823
;1823:			trap_R_AddLightToScene(cent->lerpOrigin, weapon->altMissileDlight, 
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 172
ADDP4
INDIRF4
ARGF4
ADDRLP4 216
INDIRP4
CNSTI4 176
ADDP4
INDIRF4
ARGF4
ADDRLP4 216
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 216
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 1825
;1824:				weapon->altMissileDlightColor[0], weapon->altMissileDlightColor[1], weapon->altMissileDlightColor[2] );
;1825:		}
LABELV $1095
line 1828
;1826:
;1827:		// add missile sound
;1828:		if ( weapon->altMissileSound ) {
ADDRLP4 216
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1097
line 1831
;1829:			vec3_t	velocity;
;1830:
;1831:			BG_EvaluateTrajectoryDelta( &cent->currentState.pos, cg.time, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 228
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 1833
;1832:
;1833:			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, velocity, weapon->altMissileSound );
ADDRLP4 240
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 240
INDIRP4
INDIRI4
ARGI4
ADDRLP4 240
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 1834
;1834:		}
LABELV $1097
line 1837
;1835:
;1836:		//Don't draw something without a model
;1837:		if ( weapon->altMissileModel == NULL_HANDLE )
ADDRLP4 216
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1092
line 1838
;1838:			return;
ADDRGP4 $1075
JUMPV
line 1839
;1839:	}
LABELV $1091
line 1841
;1840:	else
;1841:	{
line 1843
;1842:		// add trails
;1843:		if ( weapon->missileTrailFunc )  
ADDRLP4 216
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1102
line 1844
;1844:			weapon->missileTrailFunc( cent, weapon );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
LABELV $1102
line 1847
;1845:
;1846:		// add dynamic light
;1847:		if ( weapon->missileDlight ) 
ADDRLP4 216
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1104
line 1848
;1848:		{
line 1849
;1849:			trap_R_AddLightToScene(cent->lerpOrigin, weapon->missileDlight, 
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ARGF4
ADDRLP4 216
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ARGF4
ADDRLP4 216
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ARGF4
ADDRLP4 216
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 1851
;1850:				weapon->missileDlightColor[0], weapon->missileDlightColor[1], weapon->missileDlightColor[2] );
;1851:		}
LABELV $1104
line 1854
;1852:
;1853:		// add missile sound
;1854:		if ( weapon->missileSound ) 
ADDRLP4 216
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1106
line 1855
;1855:		{
line 1858
;1856:			vec3_t	velocity;
;1857:
;1858:			BG_EvaluateTrajectoryDelta( &cent->currentState.pos, cg.time, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 228
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 1860
;1859:
;1860:			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, velocity, weapon->missileSound );
ADDRLP4 240
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 240
INDIRP4
INDIRI4
ARGI4
ADDRLP4 240
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 1861
;1861:		}
LABELV $1106
line 1864
;1862:
;1863:		//Don't draw something without a model
;1864:		if ( weapon->missileModel == NULL_HANDLE && s1->weapon != WP_SABER && s1->weapon != G2_MODEL_PART ) //saber uses ghoul2 model, doesn't matter
ADDRLP4 216
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1109
ADDRLP4 228
ADDRLP4 212
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 228
INDIRI4
CNSTI4 2
EQI4 $1109
ADDRLP4 228
INDIRI4
CNSTI4 50
EQI4 $1109
line 1865
;1865:			return;
ADDRGP4 $1075
JUMPV
LABELV $1109
line 1866
;1866:	}
LABELV $1092
line 1869
;1867:
;1868:	// create the render entity
;1869:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1870
;1870:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 1871
;1871:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+64
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 1875
;1872:/*
;1873:Ghoul2 Insert Start
;1874:*/
;1875:	CG_SetGhoul2Info(&ent, cent);  
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetGhoul2Info
CALLV
pop
line 1882
;1876:
;1877:/*
;1878:Ghoul2 Insert End
;1879:*/
;1880:
;1881:	// flicker between two skins
;1882:	ent.skinNum = cg.clientFrame & 1;
ADDRLP4 0+132
ADDRGP4 cg
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 1883
;1883:	ent.renderfx = /*weapon->missileRenderfx | */RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 1885
;1884:
;1885:	if (s1->weapon != WP_SABER && s1->weapon != G2_MODEL_PART)
ADDRLP4 224
ADDRLP4 212
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 2
EQI4 $1115
ADDRLP4 224
INDIRI4
CNSTI4 50
EQI4 $1115
line 1886
;1886:	{
line 1889
;1887:		//if ( cent->currentState.eFlags | EF_ALT_FIRING )
;1888:		//rww - why was this like this?
;1889:		if ( cent->currentState.eFlags & EF_ALT_FIRING )
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1117
line 1890
;1890:		{
line 1891
;1891:			ent.hModel = weapon->altMissileModel;
ADDRLP4 0+8
ADDRLP4 216
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 1892
;1892:		}
ADDRGP4 $1118
JUMPV
LABELV $1117
line 1894
;1893:		else
;1894:		{
line 1895
;1895:			ent.hModel = weapon->missileModel;
ADDRLP4 0+8
ADDRLP4 216
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ASGNI4
line 1896
;1896:		}
LABELV $1118
line 1897
;1897:	}
LABELV $1115
line 1900
;1898:
;1899:	// spin as it moves
;1900:	if ( s1->apos.trType != TR_INTERPOLATE )
ADDRLP4 212
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1121
line 1901
;1901:	{
line 1903
;1902:		// convert direction of travel into axis
;1903:		if ( VectorNormalize2( s1->pos.trDelta, ent.axis[0] ) == 0 ) {
ADDRLP4 212
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 228
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 228
INDIRF4
CNSTF4 0
NEF4 $1123
line 1904
;1904:			ent.axis[0][2] = 1;
ADDRLP4 0+12+8
CNSTF4 1065353216
ASGNF4
line 1905
;1905:		}
LABELV $1123
line 1908
;1906:
;1907:		// spin as it moves
;1908:		if ( s1->pos.trType != TR_STATIONARY ) 
ADDRLP4 212
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1128
line 1909
;1909:		{
line 1910
;1910:			if ( s1->eFlags & EF_MISSILE_STICK )
ADDRLP4 212
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $1130
line 1911
;1911:			{
line 1912
;1912:				RotateAroundDirection( ent.axis, cg.time * 0.5f );//Did this so regular missiles don't get broken
ADDRLP4 0+12
ARGP4
CNSTF4 1056964608
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 1913
;1913:			}
ADDRGP4 $1122
JUMPV
LABELV $1130
line 1915
;1914:			else
;1915:			{
line 1916
;1916:				RotateAroundDirection( ent.axis, cg.time * 0.25f );//JFM:FLOAT FIX
ADDRLP4 0+12
ARGP4
CNSTF4 1048576000
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 1917
;1917:			}
line 1918
;1918:		} 
ADDRGP4 $1122
JUMPV
LABELV $1128
line 1920
;1919:		else 
;1920:		{
line 1921
;1921:			if ( s1->eFlags & EF_MISSILE_STICK )
ADDRLP4 212
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $1136
line 1922
;1922:			{
line 1923
;1923:				RotateAroundDirection( ent.axis, (float)s1->pos.trTime * 0.5f );
ADDRLP4 0+12
ARGP4
CNSTF4 1056964608
ADDRLP4 212
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 1924
;1924:			}
ADDRGP4 $1122
JUMPV
LABELV $1136
line 1926
;1925:			else
;1926:			{
line 1927
;1927:				RotateAroundDirection( ent.axis, (float)s1->time );
ADDRLP4 0+12
ARGP4
ADDRLP4 212
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 1928
;1928:			}
line 1929
;1929:		}
line 1930
;1930:	}
ADDRGP4 $1122
JUMPV
LABELV $1121
line 1932
;1931:	else
;1932:	{
line 1933
;1933:		AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1934
;1934:	}
LABELV $1122
line 1936
;1935:
;1936:	if (s1->weapon == WP_SABER)
ADDRLP4 212
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1141
line 1937
;1937:	{
line 1938
;1938:		ent.radius = s1->g2radius;
ADDRLP4 0+92
ADDRLP4 212
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1939
;1939:	}
LABELV $1141
line 1942
;1940:
;1941:	// add to refresh list, possibly with quad glow
;1942:	CG_AddRefEntityWithPowerups( &ent, s1, TEAM_FREE );
ADDRLP4 0
ARGP4
ADDRLP4 212
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 1944
;1943:
;1944:	if (s1->weapon == WP_SABER && cgs.gametype == GT_JEDIMASTER)
ADDRLP4 228
CNSTI4 2
ASGNI4
ADDRLP4 212
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRLP4 228
INDIRI4
NEI4 $1144
ADDRGP4 cgs+32960
INDIRI4
ADDRLP4 228
INDIRI4
NEI4 $1144
line 1945
;1945:	{ //in jedimaster always make the saber glow when on the ground
line 1953
;1946:		vec3_t org;
;1947:		float wv;
;1948:		int i;
;1949:		addspriteArgStruct_t fxSArgs;
;1950:		//refEntity_t sRef;
;1951:		//memcpy( &sRef, &ent, sizeof( sRef ) );
;1952:
;1953:		ent.customShader = cgs.media.solidWhite;
ADDRLP4 0+76
ADDRGP4 cgs+70280+576
INDIRI4
ASGNI4
line 1954
;1954:		ent.renderfx = RF_RGB_TINT;
ADDRLP4 0+4
CNSTI4 2048
ASGNI4
line 1955
;1955:		wv = sin( cg.time * 0.003f ) * 0.08f + 0.1f;
CNSTF4 994352038
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 324
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 320
CNSTF4 1034147594
ADDRLP4 324
INDIRF4
MULF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1956
;1956:		ent.shaderRGBA[0] = wv * 255;
ADDRLP4 332
CNSTF4 1132396544
ADDRLP4 320
INDIRF4
MULF4
ASGNF4
ADDRLP4 336
CNSTF4 1325400064
ASGNF4
ADDRLP4 332
INDIRF4
ADDRLP4 336
INDIRF4
LTF4 $1154
ADDRLP4 328
ADDRLP4 332
INDIRF4
ADDRLP4 336
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1155
JUMPV
LABELV $1154
ADDRLP4 328
ADDRLP4 332
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1155
ADDRLP4 0+80
ADDRLP4 328
INDIRU4
CVUU1 4
ASGNU1
line 1957
;1957:		ent.shaderRGBA[1] = wv * 255;
ADDRLP4 344
CNSTF4 1132396544
ADDRLP4 320
INDIRF4
MULF4
ASGNF4
ADDRLP4 348
CNSTF4 1325400064
ASGNF4
ADDRLP4 344
INDIRF4
ADDRLP4 348
INDIRF4
LTF4 $1159
ADDRLP4 340
ADDRLP4 344
INDIRF4
ADDRLP4 348
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1160
JUMPV
LABELV $1159
ADDRLP4 340
ADDRLP4 344
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1160
ADDRLP4 0+80+1
ADDRLP4 340
INDIRU4
CVUU1 4
ASGNU1
line 1958
;1958:		ent.shaderRGBA[2] = wv * 0;
ADDRLP4 356
CNSTF4 0
ADDRLP4 320
INDIRF4
MULF4
ASGNF4
ADDRLP4 360
CNSTF4 1325400064
ASGNF4
ADDRLP4 356
INDIRF4
ADDRLP4 360
INDIRF4
LTF4 $1164
ADDRLP4 352
ADDRLP4 356
INDIRF4
ADDRLP4 360
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1165
JUMPV
LABELV $1164
ADDRLP4 352
ADDRLP4 356
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1165
ADDRLP4 0+80+2
ADDRLP4 352
INDIRU4
CVUU1 4
ASGNU1
line 1959
;1959:		trap_R_AddRefEntityToScene (&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1961
;1960:
;1961:		for ( i = -4; i < 10; i += 1 )
ADDRLP4 304
CNSTI4 -4
ASGNI4
LABELV $1166
line 1962
;1962:		{
line 1963
;1963:			VectorMA( ent.origin, -i, ent.axis[2], org );
ADDRLP4 364
ADDRLP4 304
INDIRI4
NEGI4
CVIF4 4
ASGNF4
ADDRLP4 308
ADDRLP4 0+52
INDIRF4
ADDRLP4 0+12+24
INDIRF4
ADDRLP4 364
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 308+4
ADDRLP4 0+52+4
INDIRF4
ADDRLP4 0+12+24+4
INDIRF4
ADDRLP4 364
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 308+8
ADDRLP4 0+52+8
INDIRF4
ADDRLP4 0+12+24+8
INDIRF4
ADDRLP4 304
INDIRI4
NEGI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 1965
;1964:
;1965:			VectorCopy(org, fxSArgs.origin);
ADDRLP4 232
ADDRLP4 308
INDIRB
ASGNB 12
line 1966
;1966:			VectorClear(fxSArgs.vel);
ADDRLP4 368
CNSTF4 0
ASGNF4
ADDRLP4 232+12+8
ADDRLP4 368
INDIRF4
ASGNF4
ADDRLP4 232+12+4
ADDRLP4 368
INDIRF4
ASGNF4
ADDRLP4 232+12
ADDRLP4 368
INDIRF4
ASGNF4
line 1967
;1967:			VectorClear(fxSArgs.accel);
ADDRLP4 372
CNSTF4 0
ASGNF4
ADDRLP4 232+24+8
ADDRLP4 372
INDIRF4
ASGNF4
ADDRLP4 232+24+4
ADDRLP4 372
INDIRF4
ASGNF4
ADDRLP4 232+24
ADDRLP4 372
INDIRF4
ASGNF4
line 1968
;1968:			fxSArgs.scale = 5.5f;
ADDRLP4 232+36
CNSTF4 1085276160
ASGNF4
line 1969
;1969:			fxSArgs.dscale = 5.5f;
ADDRLP4 232+40
CNSTF4 1085276160
ASGNF4
line 1970
;1970:			fxSArgs.sAlpha = wv;
ADDRLP4 232+44
ADDRLP4 320
INDIRF4
ASGNF4
line 1971
;1971:			fxSArgs.eAlpha = wv;
ADDRLP4 232+48
ADDRLP4 320
INDIRF4
ASGNF4
line 1972
;1972:			fxSArgs.rotation = 0.0f;
ADDRLP4 232+52
CNSTF4 0
ASGNF4
line 1973
;1973:			fxSArgs.bounce = 0.0f;
ADDRLP4 232+56
CNSTF4 0
ASGNF4
line 1974
;1974:			fxSArgs.life = 1.0f;
ADDRLP4 232+60
CNSTI4 1
ASGNI4
line 1975
;1975:			fxSArgs.shader = cgs.media.yellowDroppedSaberShader;
ADDRLP4 232+64
ADDRGP4 cgs+70280+168
INDIRI4
ASGNI4
line 1976
;1976:			fxSArgs.flags = 0x08000000;
ADDRLP4 232+68
CNSTI4 134217728
ASGNI4
line 1979
;1977:
;1978:			//trap_FX_AddSprite( org, NULL, NULL, 5.5f, 5.5f, wv, wv, 0.0f, 0.0f, 1.0f, cgs.media.yellowSaberGlowShader, 0x08000000 );
;1979:			trap_FX_AddSprite(&fxSArgs);
ADDRLP4 232
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 1980
;1980:		}
LABELV $1167
line 1961
ADDRLP4 304
ADDRLP4 304
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 10
LTI4 $1166
line 1982
;1981:
;1982:		if (cgs.gametype == GT_JEDIMASTER)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 2
NEI4 $1206
line 1983
;1983:		{
line 1984
;1984:			ent.shaderRGBA[0] = 255;
ADDRLP4 0+80
CNSTU1 255
ASGNU1
line 1985
;1985:			ent.shaderRGBA[1] = 255;
ADDRLP4 0+80+1
CNSTU1 255
ASGNU1
line 1986
;1986:			ent.shaderRGBA[2] = 0;
ADDRLP4 0+80+2
CNSTU1 0
ASGNU1
line 1988
;1987:
;1988:			ent.renderfx |= RF_DEPTHHACK;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1989
;1989:			ent.customShader = cgs.media.forceSightBubble;
ADDRLP4 0+76
ADDRGP4 cgs+70280+504
INDIRI4
ASGNI4
line 1991
;1990:		
;1991:			trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1992
;1992:		}
LABELV $1206
line 1993
;1993:	}
LABELV $1144
line 1995
;1994:
;1995:	if ( s1->eFlags & EF_FIRING )
ADDRLP4 212
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1218
line 1996
;1996:	{//special code for adding the beam to the attached tripwire mine
line 1999
;1997:		vec3_t	beamOrg;
;1998:
;1999:		VectorMA( ent.origin, 8, ent.axis[0], beamOrg );// forward
ADDRLP4 244
CNSTF4 1090519040
ASGNF4
ADDRLP4 232
ADDRLP4 0+52
INDIRF4
ADDRLP4 244
INDIRF4
ADDRLP4 0+12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 232+4
ADDRLP4 0+52+4
INDIRF4
ADDRLP4 244
INDIRF4
ADDRLP4 0+12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 232+8
ADDRLP4 0+52+8
INDIRF4
CNSTF4 1090519040
ADDRLP4 0+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2000
;2000:		trap_FX_PlayEffect( "tripMine/laser.efx", beamOrg, ent.axis[0] );
ADDRGP4 $1232
ARGP4
ADDRLP4 232
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 trap_FX_PlayEffect
CALLV
pop
line 2001
;2001:	}
LABELV $1218
line 2002
;2002:}
LABELV $1075
endproc CG_Missile 376 28
proc CG_Mover 216 12
line 2009
;2003:
;2004:/*
;2005:===============
;2006:CG_Mover
;2007:===============
;2008:*/
;2009:static void CG_Mover( centity_t *cent ) {
line 2013
;2010:	refEntity_t			ent;
;2011:	entityState_t		*s1;
;2012:
;2013:	s1 = &cent->currentState;
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
line 2016
;2014:
;2015:	// create the render entity
;2016:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2017
;2017:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2018
;2018:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+64
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2019
;2019:	AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2021
;2020:
;2021:	ent.renderfx = RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 2026
;2022:/*
;2023:Ghoul2 Insert Start
;2024:*/
;2025:
;2026:	CG_SetGhoul2Info(&ent, cent);  
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetGhoul2Info
CALLV
pop
line 2031
;2027:/*
;2028:Ghoul2 Insert End
;2029:*/
;2030:	// flicker between two skins (FIXME?)
;2031:	ent.skinNum = ( cg.time >> 6 ) & 1;
ADDRLP4 0+132
ADDRGP4 cg+64
INDIRI4
CNSTI4 6
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 2034
;2032:
;2033:	// get the model, either as a bmodel or a modelindex
;2034:	if ( s1->solid == SOLID_BMODEL ) 
ADDRLP4 212
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $1241
line 2035
;2035:	{
line 2036
;2036:		ent.hModel = cgs.inlineDrawModel[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 212
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+38912
ADDP4
INDIRI4
ASGNI4
line 2037
;2037:	} 
ADDRGP4 $1242
JUMPV
LABELV $1241
line 2039
;2038:	else 
;2039:	{
line 2040
;2040:		ent.hModel = cgs.gameModels[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 212
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36348
ADDP4
INDIRI4
ASGNI4
line 2041
;2041:	}
LABELV $1242
line 2044
;2042:
;2043:	// add to refresh list
;2044:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2047
;2045:
;2046:	// add the secondary model
;2047:	if ( s1->modelindex2 ) 
ADDRLP4 212
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1247
line 2048
;2048:	{
line 2049
;2049:		ent.skinNum = 0;
ADDRLP4 0+132
CNSTI4 0
ASGNI4
line 2050
;2050:		ent.hModel = cgs.gameModels[s1->modelindex2];
ADDRLP4 0+8
ADDRLP4 212
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36348
ADDP4
INDIRI4
ASGNI4
line 2051
;2051:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2052
;2052:	}
LABELV $1247
line 2054
;2053:
;2054:}
LABELV $1234
endproc CG_Mover 216 12
export CG_Beam
proc CG_Beam 216 12
line 2063
;2055:
;2056:/*
;2057:===============
;2058:CG_Beam
;2059:
;2060:Also called as an event
;2061:===============
;2062:*/
;2063:void CG_Beam( centity_t *cent ) {
line 2067
;2064:	refEntity_t			ent;
;2065:	entityState_t		*s1;
;2066:
;2067:	s1 = &cent->currentState;
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
line 2070
;2068:
;2069:	// create the render entity
;2070:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2071
;2071:	VectorCopy( s1->pos.trBase, ent.origin );
ADDRLP4 0+52
ADDRLP4 212
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 2072
;2072:	VectorCopy( s1->origin2, ent.oldorigin );
ADDRLP4 0+64
ADDRLP4 212
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 2073
;2073:	AxisClear( ent.axis );
ADDRLP4 0+12
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 2074
;2074:	ent.reType = RT_BEAM;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 2076
;2075:
;2076:	ent.renderfx = RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 2080
;2077:/*
;2078:Ghoul2 Insert Start
;2079:*/
;2080:	CG_SetGhoul2Info(&ent, cent);  
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetGhoul2Info
CALLV
pop
line 2086
;2081:
;2082:/*
;2083:Ghoul2 Insert End
;2084:*/
;2085:	// add to refresh list
;2086:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2087
;2087:}
LABELV $1252
endproc CG_Beam 216 12
proc CG_Portal 216 12
line 2095
;2088:
;2089:
;2090:/*
;2091:===============
;2092:CG_Portal
;2093:===============
;2094:*/
;2095:static void CG_Portal( centity_t *cent ) {
line 2099
;2096:	refEntity_t			ent;
;2097:	entityState_t		*s1;
;2098:
;2099:	s1 = &cent->currentState;
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
line 2102
;2100:
;2101:	// create the render entity
;2102:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2103
;2103:	VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2104
;2104:	VectorCopy( s1->origin2, ent.oldorigin );
ADDRLP4 0+64
ADDRLP4 212
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 2105
;2105:	ByteToDir( s1->eventParm, ent.axis[0] );
ADDRLP4 212
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 0+12
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 2106
;2106:	PerpendicularVector( ent.axis[1], ent.axis[0] );
ADDRLP4 0+12+12
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 2110
;2107:
;2108:	// negating this tends to get the directions like they want
;2109:	// we really should have a camera roll value
;2110:	VectorSubtract( vec3_origin, ent.axis[1], ent.axis[1] );
ADDRLP4 0+12+12
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0+12+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+12+12+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+12+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+12+12+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+12+12+8
INDIRF4
SUBF4
ASGNF4
line 2112
;2111:
;2112:	CrossProduct( ent.axis[0], ent.axis[1], ent.axis[2] );
ADDRLP4 0+12
ARGP4
ADDRLP4 0+12+12
ARGP4
ADDRLP4 0+12+24
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2113
;2113:	ent.reType = RT_PORTALSURFACE;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 2114
;2114:	ent.oldframe = s1->powerups;
ADDRLP4 0+124
ADDRLP4 212
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ASGNI4
line 2115
;2115:	ent.frame = s1->frame;		// rotation speed
ADDRLP4 0+104
ADDRLP4 212
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
ASGNI4
line 2116
;2116:	ent.skinNum = s1->clientNum/256.0 * 360;	// roll offset
ADDRLP4 0+132
CNSTF4 1135869952
ADDRLP4 212
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
MULF4
CVFI4 4
ASGNI4
line 2120
;2117:/*
;2118:Ghoul2 Insert Start
;2119:*/
;2120:	CG_SetGhoul2Info(&ent, cent);  
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetGhoul2Info
CALLV
pop
line 2125
;2121:/*
;2122:Ghoul2 Insert End
;2123:*/
;2124:	// add to refresh list
;2125:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2126
;2126:}
LABELV $1257
endproc CG_Portal 216 12
export CG_AdjustPositionForMover
proc CG_AdjustPositionForMover 88 12
line 2136
;2127:
;2128:
;2129:/*
;2130:=========================
;2131:CG_AdjustPositionForMover
;2132:
;2133:Also called by client movement prediction code
;2134:=========================
;2135:*/
;2136:void CG_AdjustPositionForMover( const vec3_t in, int moverNum, int fromTime, int toTime, vec3_t out ) {
line 2141
;2137:	centity_t	*cent;
;2138:	vec3_t	oldOrigin, origin, deltaOrigin;
;2139:	vec3_t	oldAngles, angles, deltaAngles;
;2140:
;2141:	if ( moverNum <= 0 || moverNum >= ENTITYNUM_MAX_NORMAL ) {
ADDRLP4 76
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
LEI4 $1293
ADDRLP4 76
INDIRI4
CNSTI4 1022
LTI4 $1291
LABELV $1293
line 2142
;2142:		VectorCopy( in, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 2143
;2143:		return;
ADDRGP4 $1290
JUMPV
LABELV $1291
line 2146
;2144:	}
;2145:
;2146:	cent = &cg_entities[ moverNum ];
ADDRLP4 0
CNSTI4 1920
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 2147
;2147:	if ( cent->currentState.eType != ET_MOVER ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 6
EQI4 $1294
line 2148
;2148:		VectorCopy( in, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 2149
;2149:		return;
ADDRGP4 $1290
JUMPV
LABELV $1294
line 2152
;2150:	}
;2151:
;2152:	BG_EvaluateTrajectory( &cent->currentState.pos, fromTime, oldOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2153
;2153:	BG_EvaluateTrajectory( &cent->currentState.apos, fromTime, oldAngles );
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2155
;2154:
;2155:	BG_EvaluateTrajectory( &cent->currentState.pos, toTime, origin );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2156
;2156:	BG_EvaluateTrajectory( &cent->currentState.apos, toTime, angles );
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2158
;2157:
;2158:	VectorSubtract( origin, oldOrigin, deltaOrigin );
ADDRLP4 4
ADDRLP4 28
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 28+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 2159
;2159:	VectorSubtract( angles, oldAngles, deltaAngles );
ADDRLP4 64
ADDRLP4 52
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 52+4
INDIRF4
ADDRLP4 40+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 52+8
INDIRF4
ADDRLP4 40+8
INDIRF4
SUBF4
ASGNF4
line 2161
;2160:
;2161:	VectorAdd( in, deltaOrigin, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 80
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 2164
;2162:
;2163:	// FIXME: origin change when on a rotating object
;2164:}
LABELV $1290
endproc CG_AdjustPositionForMover 88 12
proc LerpBoneAngleOverrides 0 0
line 2170
;2165:
;2166:/*
;2167:Ghoul2 Insert Start
;2168:*/
;2169:static void LerpBoneAngleOverrides( centity_t *cent)
;2170:{
line 2172
;2171:	
;2172:}
LABELV $1310
endproc LerpBoneAngleOverrides 0 0
proc CG_InterpolateEntityPosition 44 12
line 2181
;2173:/*
;2174:Ghoul2 Insert End
;2175:*/
;2176:/*
;2177:=============================
;2178:CG_InterpolateEntityPosition
;2179:=============================
;2180:*/
;2181:static void CG_InterpolateEntityPosition( centity_t *cent ) {
line 2187
;2182:	vec3_t		current, next;
;2183:	float		f;
;2184:
;2185:	// it would be an internal error to find an entity that interpolates without
;2186:	// a snapshot ahead of the current one
;2187:	if ( cg.nextSnap == NULL ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1312
line 2188
;2188:		CG_Error( "CG_InterpoateEntityPosition: cg.nextSnap == NULL" );
ADDRGP4 $1315
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2189
;2189:	}
LABELV $1312
line 2191
;2190:
;2191:	f = cg.frameInterpolation;
ADDRLP4 24
ADDRGP4 cg+44
INDIRF4
ASGNF4
line 2195
;2192:
;2193:	// this will linearize a sine or parabolic curve, but it is important
;2194:	// to not extrapolate player positions if more recent data is available
;2195:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, current );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2196
;2196:	BG_EvaluateTrajectory( &cent->nextState.pos, cg.nextSnap->serverTime, next );
ADDRFP4 0
INDIRP4
CNSTI4 308
ADDP4
ARGP4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2198
;2197:
;2198:	cent->lerpOrigin[0] = current[0] + f * ( next[0] - current[0] );
ADDRLP4 28
ADDRLP4 0
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 2199
;2199:	cent->lerpOrigin[1] = current[1] + f * ( next[1] - current[1] );
ADDRFP4 0
INDIRP4
CNSTI4 932
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 2200
;2200:	cent->lerpOrigin[2] = current[2] + f * ( next[2] - current[2] );
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 2202
;2201:
;2202:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.snap->serverTime, current );
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2203
;2203:	BG_EvaluateTrajectory( &cent->nextState.apos, cg.nextSnap->serverTime, next );
ADDRFP4 0
INDIRP4
CNSTI4 344
ADDP4
ARGP4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2205
;2204:
;2205:	cent->lerpAngles[0] = LerpAngle( current[0], next[0], f );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 2206
;2206:	cent->lerpAngles[1] = LerpAngle( current[1], next[1], f );
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 944
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
line 2207
;2207:	cent->lerpAngles[2] = LerpAngle( current[2], next[2], f );
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 948
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
line 2213
;2208:/*
;2209:Ghoul2 Insert Start
;2210:*/
;2211:		// now the nasty stuff - this will interpolate all ghoul2 models bone angle overrides per model attached to this cent
;2212://	if (cent->currentState.ghoul2.size())
;2213:	{
line 2214
;2214:		LerpBoneAngleOverrides(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 LerpBoneAngleOverrides
CALLV
pop
line 2215
;2215:	}
line 2219
;2216:/*
;2217:Ghoul2 Insert End
;2218:*/
;2219:}
LABELV $1311
endproc CG_InterpolateEntityPosition 44 12
export CG_CalcEntityLerpPositions
proc CG_CalcEntityLerpPositions 24 20
line 2227
;2220:
;2221:/*
;2222:===============
;2223:CG_CalcEntityLerpPositions
;2224:
;2225:===============
;2226:*/
;2227:void CG_CalcEntityLerpPositions( centity_t *cent ) {
line 2230
;2228:
;2229:	// if this player does not want to see extrapolated players
;2230:	if ( !cg_smoothClients.integer ) {
ADDRGP4 cg_smoothClients+12
INDIRI4
CNSTI4 0
NEI4 $1332
line 2232
;2231:		// make sure the clients use TR_INTERPOLATE
;2232:		if ( cent->currentState.number < MAX_CLIENTS ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 32
GEI4 $1335
line 2233
;2233:			cent->currentState.pos.trType = TR_INTERPOLATE;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 1
ASGNI4
line 2234
;2234:			cent->nextState.pos.trType = TR_INTERPOLATE;
ADDRFP4 0
INDIRP4
CNSTI4 308
ADDP4
CNSTI4 1
ASGNI4
line 2235
;2235:		}
LABELV $1335
line 2236
;2236:	}
LABELV $1332
line 2238
;2237:
;2238:	if ( cent->interpolate && cent->currentState.pos.trType == TR_INTERPOLATE ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1337
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1337
line 2239
;2239:		CG_InterpolateEntityPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_InterpolateEntityPosition
CALLV
pop
line 2240
;2240:		return;
ADDRGP4 $1331
JUMPV
LABELV $1337
line 2245
;2241:	}
;2242:
;2243:	// first see if we can interpolate between two snaps for
;2244:	// linear extrapolated clients
;2245:	if ( cent->interpolate && cent->currentState.pos.trType == TR_LINEAR_STOP &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1339
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1339
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 32
GEI4 $1339
line 2246
;2246:											cent->currentState.number < MAX_CLIENTS) {
line 2247
;2247:		CG_InterpolateEntityPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_InterpolateEntityPosition
CALLV
pop
line 2248
;2248:		return;
ADDRGP4 $1331
JUMPV
LABELV $1339
line 2252
;2249:	}
;2250:
;2251:	// just use the current frame and evaluate as best we can
;2252:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2253
;2253:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 940
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2257
;2254:
;2255:	// adjust for riding a mover if it wasn't rolled into the predicted
;2256:	// player state
;2257:	if ( cent != &cg.predictedPlayerEntity ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cg+1464
CVPU4 4
EQU4 $1343
line 2258
;2258:		CG_AdjustPositionForMover( cent->lerpOrigin, cent->currentState.groundEntityNum, 
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 928
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 2260
;2259:		cg.snap->serverTime, cg.time, cent->lerpOrigin );
;2260:	}
LABELV $1343
line 2266
;2261:/*
;2262:Ghoul2 Insert Start
;2263:*/
;2264:	// now the nasty stuff - this will interpolate all ghoul2 models bone angle overrides per model attached to this cent
;2265://	if (cent->currentState.ghoul2.size())
;2266:	{
line 2267
;2267:		LerpBoneAngleOverrides(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 LerpBoneAngleOverrides
CALLV
pop
line 2268
;2268:	}
line 2272
;2269:/*
;2270:Ghoul2 Insert End
;2271:*/
;2272:}
LABELV $1331
endproc CG_CalcEntityLerpPositions 24 20
proc CG_TeamBase 212 12
line 2279
;2273:
;2274:/*
;2275:===============
;2276:CG_TeamBase
;2277:===============
;2278:*/
;2279:static void CG_TeamBase( centity_t *cent ) {
line 2281
;2280:	refEntity_t model;
;2281:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_CTY ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
EQI4 $1353
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $1349
LABELV $1353
line 2283
;2282:		// show the flag base
;2283:		memset(&model, 0, sizeof(model));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2284
;2284:		model.reType = RT_MODEL;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2285
;2285:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
ADDRLP4 0+108
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2286
;2286:		VectorCopy( cent->lerpOrigin, model.origin );
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2287
;2287:		AnglesToAxis( cent->currentState.angles, model.axis );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2288
;2288:		if ( cent->currentState.modelindex == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1357
line 2289
;2289:			model.hModel = cgs.media.redFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+70280+84
INDIRI4
ASGNI4
line 2290
;2290:		}
ADDRGP4 $1358
JUMPV
LABELV $1357
line 2291
;2291:		else if ( cent->currentState.modelindex == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1362
line 2292
;2292:			model.hModel = cgs.media.blueFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+70280+88
INDIRI4
ASGNI4
line 2293
;2293:		}
ADDRGP4 $1363
JUMPV
LABELV $1362
line 2294
;2294:		else {
line 2295
;2295:			model.hModel = cgs.media.neutralFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+70280+92
INDIRI4
ASGNI4
line 2296
;2296:		}
LABELV $1363
LABELV $1358
line 2297
;2297:		trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2298
;2298:	}
LABELV $1349
line 2299
;2299:}
LABELV $1348
endproc CG_TeamBase 212 12
proc CG_AddCEntity 12 12
line 2307
;2300:
;2301:/*
;2302:===============
;2303:CG_AddCEntity
;2304:
;2305:===============
;2306:*/
;2307:static void CG_AddCEntity( centity_t *cent ) {
line 2309
;2308:	// event-only entities will have been dealt with already
;2309:	if ( cent->currentState.eType >= ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 16
LTI4 $1371
line 2310
;2310:		return;
ADDRGP4 $1370
JUMPV
LABELV $1371
line 2314
;2311:	}
;2312:
;2313:	// calculate the current origin
;2314:	CG_CalcEntityLerpPositions( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 2317
;2315:
;2316:	// add automatic effects
;2317:	CG_EntityEffects( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_EntityEffects
CALLV
pop
line 2323
;2318:/*
;2319:Ghoul2 Insert Start
;2320:*/
;2321:
;2322:	// do this before we copy the data to refEnts
;2323:	if (trap_G2_HaveWeGhoul2Models(cent->ghoul2))
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1373
line 2324
;2324:	{
line 2325
;2325:		trap_G2_SetGhoul2ModelIndexes(cent->ghoul2, cgs.gameModels, cgs.skins);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRGP4 cgs+36348
ARGP4
ADDRGP4 cgs+38652
ARGP4
ADDRGP4 trap_G2_SetGhoul2ModelIndexes
CALLV
pop
line 2326
;2326:	}
LABELV $1373
line 2331
;2327:
;2328:/*
;2329:Ghoul2 Insert End
;2330:*/
;2331:	switch ( cent->currentState.eType ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1377
ADDRLP4 4
INDIRI4
CNSTI4 15
GTI4 $1377
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1394
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1394
address $1382
address $1383
address $1384
address $1385
address $1386
address $1387
address $1388
address $1389
address $1390
address $1391
address $1378
address $1378
address $1378
address $1377
address $1392
address $1393
code
LABELV $1377
line 2333
;2332:	default:
;2333:		CG_Error( "Bad entity type: %i\n", cent->currentState.eType );
ADDRGP4 $1380
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 2334
;2334:		break;
ADDRGP4 $1378
JUMPV
line 2338
;2335:	case ET_INVISIBLE:
;2336:	case ET_PUSH_TRIGGER:
;2337:	case ET_TELEPORT_TRIGGER:
;2338:		break;
LABELV $1382
line 2340
;2339:	case ET_GENERAL:
;2340:		CG_General( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_General
CALLV
pop
line 2341
;2341:		break;
ADDRGP4 $1378
JUMPV
LABELV $1383
line 2343
;2342:	case ET_PLAYER:
;2343:		CG_Player( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Player
CALLV
pop
line 2344
;2344:		break;
ADDRGP4 $1378
JUMPV
LABELV $1384
line 2346
;2345:	case ET_ITEM:
;2346:		CG_Item( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Item
CALLV
pop
line 2347
;2347:		break;
ADDRGP4 $1378
JUMPV
LABELV $1385
line 2349
;2348:	case ET_MISSILE:
;2349:		CG_Missile( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Missile
CALLV
pop
line 2350
;2350:		break;
ADDRGP4 $1378
JUMPV
LABELV $1386
line 2352
;2351:	case ET_SPECIAL:
;2352:		CG_Special( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Special
CALLV
pop
line 2353
;2353:		break;
ADDRGP4 $1378
JUMPV
LABELV $1387
line 2355
;2354:	case ET_HOLOCRON:
;2355:		CG_General( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_General
CALLV
pop
line 2356
;2356:		break;
ADDRGP4 $1378
JUMPV
LABELV $1388
line 2358
;2357:	case ET_MOVER:
;2358:		CG_Mover( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Mover
CALLV
pop
line 2359
;2359:		break;
ADDRGP4 $1378
JUMPV
LABELV $1389
line 2361
;2360:	case ET_BEAM:
;2361:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 2362
;2362:		break;
ADDRGP4 $1378
JUMPV
LABELV $1390
line 2364
;2363:	case ET_PORTAL:
;2364:		CG_Portal( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Portal
CALLV
pop
line 2365
;2365:		break;
ADDRGP4 $1378
JUMPV
LABELV $1391
line 2367
;2366:	case ET_SPEAKER:
;2367:		CG_Speaker( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Speaker
CALLV
pop
line 2368
;2368:		break;
ADDRGP4 $1378
JUMPV
LABELV $1392
line 2370
;2369:	case ET_TEAM:
;2370:		CG_TeamBase( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_TeamBase
CALLV
pop
line 2371
;2371:		break;
ADDRGP4 $1378
JUMPV
LABELV $1393
line 2373
;2372:	case ET_BODY:
;2373:		CG_General( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_General
CALLV
pop
line 2374
;2374:		break;
LABELV $1378
line 2376
;2375:	}
;2376:}
LABELV $1370
endproc CG_AddCEntity 12 12
export CG_ManualEntityRender
proc CG_ManualEntityRender 0 4
line 2379
;2377:
;2378:void CG_ManualEntityRender(centity_t *cent)
;2379:{
line 2380
;2380:	CG_AddCEntity(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 2381
;2381:}
LABELV $1395
endproc CG_ManualEntityRender 0 4
export CG_AddPacketEntities
proc CG_AddPacketEntities 20 12
line 2389
;2382:
;2383:/*
;2384:===============
;2385:CG_AddPacketEntities
;2386:
;2387:===============
;2388:*/
;2389:void CG_AddPacketEntities( void ) {
line 2395
;2390:	int					num;
;2391:	centity_t			*cent;
;2392:	playerState_t		*ps;
;2393:
;2394:	// set cg.frameInterpolation
;2395:	if ( cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1397
line 2398
;2396:		int		delta;
;2397:
;2398:		delta = (cg.nextSnap->serverTime - cg.snap->serverTime);
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 12
ADDRGP4 cg+40
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
SUBI4
ASGNI4
line 2399
;2399:		if ( delta == 0 ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1402
line 2400
;2400:			cg.frameInterpolation = 0;
ADDRGP4 cg+44
CNSTF4 0
ASGNF4
line 2401
;2401:		} else {
ADDRGP4 $1398
JUMPV
LABELV $1402
line 2402
;2402:			cg.frameInterpolation = (float)( cg.time - cg.snap->serverTime ) / delta;
ADDRGP4 cg+44
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 12
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 2403
;2403:		}
line 2404
;2404:	} else {
ADDRGP4 $1398
JUMPV
LABELV $1397
line 2405
;2405:		cg.frameInterpolation = 0;	// actually, it should never be used, because 
ADDRGP4 cg+44
CNSTF4 0
ASGNF4
line 2407
;2406:									// no entities should be marked as interpolating
;2407:	}
LABELV $1398
line 2410
;2408:
;2409:	// the auto-rotating items will all have the same axis
;2410:	cg.autoAngles[0] = 0;
ADDRGP4 cg+3508
CNSTF4 0
ASGNF4
line 2411
;2411:	cg.autoAngles[1] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRGP4 cg+3508+4
CNSTI4 360
ADDRGP4 cg+64
INDIRI4
CNSTI4 2047
BANDI4
MULI4
CVIF4 4
CNSTF4 1157627904
DIVF4
ASGNF4
line 2412
;2412:	cg.autoAngles[2] = 0;
ADDRGP4 cg+3508+8
CNSTF4 0
ASGNF4
line 2414
;2413:
;2414:	cg.autoAnglesFast[0] = 0;
ADDRGP4 cg+3556
CNSTF4 0
ASGNF4
line 2415
;2415:	cg.autoAnglesFast[1] = ( cg.time & 1023 ) * 360 / 1024.0f;
ADDRGP4 cg+3556+4
CNSTI4 360
ADDRGP4 cg+64
INDIRI4
CNSTI4 1023
BANDI4
MULI4
CVIF4 4
CNSTF4 1149239296
DIVF4
ASGNF4
line 2416
;2416:	cg.autoAnglesFast[2] = 0;
ADDRGP4 cg+3556+8
CNSTF4 0
ASGNF4
line 2418
;2417:
;2418:	AnglesToAxis( cg.autoAngles, cg.autoAxis );
ADDRGP4 cg+3508
ARGP4
ADDRGP4 cg+3520
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2419
;2419:	AnglesToAxis( cg.autoAnglesFast, cg.autoAxisFast );
ADDRGP4 cg+3556
ARGP4
ADDRGP4 cg+3568
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2422
;2420:
;2421:	// generate and add the entity from the playerstate
;2422:	ps = &cg.predictedPlayerState;
ADDRLP4 8
ADDRGP4 cg+96
ASGNP4
line 2428
;2423:
;2424:	//rww - update the g2 pointer BEFORE the weapons, otherwise bad things could happen
;2425:	//FIXME: These two pointers seem to differ sometimes, they shouldn't, should they?
;2426:	//the one on predictedPlayerEntity also seems to often be invalid, so it can't be
;2427:	//reliably checked and cleared.
;2428:	cg.predictedPlayerEntity.ghoul2 = cg_entities[ cg.snap->ps.clientNum].ghoul2;
ADDRGP4 cg+1464+952
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
ASGNP4
line 2429
;2429:	CG_CheckPlayerG2Weapons(ps, &cg.predictedPlayerEntity);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 cg+1464
ARGP4
ADDRGP4 CG_CheckPlayerG2Weapons
CALLV
pop
line 2430
;2430:	BG_PlayerStateToEntityState( ps, &cg.predictedPlayerEntity.currentState, qfalse );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 cg+1464
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 2433
;2431:	
;2432:	// add in the Ghoul2 stuff.
;2433:	VectorCopy( cg_entities[ cg.snap->ps.clientNum].modelScale, cg.predictedPlayerEntity.modelScale);
ADDRGP4 cg+1464+964
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+964
ADDP4
INDIRB
ASGNB 12
line 2434
;2434:	cg.predictedPlayerEntity.radius = cg_entities[ cg.snap->ps.clientNum].radius;
ADDRGP4 cg+1464+976
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+976
ADDP4
INDIRF4
ASGNF4
line 2436
;2435:
;2436:	CG_AddCEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+1464
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 2439
;2437:
;2438:	// lerp the non-predicted value for lightning gun origins
;2439:	CG_CalcEntityLerpPositions( &cg_entities[ cg.snap->ps.clientNum ] );
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
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 2442
;2440:
;2441:	// add each entity sent over by the server
;2442:	for ( num = 0 ; num < cg.snap->numEntities ; num++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1445
JUMPV
LABELV $1442
line 2444
;2443:		// Don't re-add ents that have been predicted.
;2444:		if (cg.snap->entities[ num ].number != cg.snap->ps.clientNum)
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
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
EQI4 $1447
line 2445
;2445:		{
line 2446
;2446:			cent = &cg_entities[ cg.snap->entities[ num ].number ];
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
line 2447
;2447:			CG_AddCEntity( cent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 2448
;2448:		}
LABELV $1447
line 2449
;2449:	}
LABELV $1443
line 2442
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1445
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1412
ADDP4
INDIRI4
LTI4 $1442
line 2450
;2450:}
LABELV $1396
endproc CG_AddPacketEntities 20 12
export CG_ROFF_NotetrackCallback
proc CG_ROFF_NotetrackCallback 1736 16
line 2453
;2451:
;2452:void CG_ROFF_NotetrackCallback( centity_t *cent, const char *notetrack)
;2453:{
line 2454
;2454:	int i = 0, r = 0, objectID = 0, anglesGathered = 0, posoffsetGathered = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 516
CNSTI4 0
ASGNI4
ADDRLP4 1372
CNSTI4 0
ASGNI4
ADDRLP4 1368
CNSTI4 0
ASGNI4
ADDRLP4 584
CNSTI4 0
ASGNI4
line 2460
;2455:	char type[256];
;2456:	char argument[512];
;2457:	char addlArg[512];
;2458:	char errMsg[256];
;2459:	char t[64];
;2460:	int addlArgs = 0;
ADDRLP4 1388
CNSTI4 0
ASGNI4
line 2463
;2461:	vec3_t parsedAngles, parsedOffset, useAngles, useOrigin, forward, right, up;
;2462:
;2463:	if (!cent || !notetrack)
ADDRLP4 1708
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 1708
INDIRU4
EQU4 $1455
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 1708
INDIRU4
NEU4 $1457
LABELV $1455
line 2464
;2464:	{
line 2465
;2465:		return;
ADDRGP4 $1452
JUMPV
LABELV $1456
line 2471
;2466:	}
;2467:
;2468:	//notetrack = "effect effects/explosion1.efx 0+0+64 0-0-1";
;2469:
;2470:	while (notetrack[i] && notetrack[i] != ' ')
;2471:	{
line 2472
;2472:		type[i] = notetrack[i];
ADDRLP4 0
INDIRI4
ADDRLP4 600
ADDP4
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 2473
;2473:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2474
;2474:	}
LABELV $1457
line 2470
ADDRLP4 1712
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1712
INDIRI4
CNSTI4 0
EQI4 $1459
ADDRLP4 1712
INDIRI4
CNSTI4 32
NEI4 $1456
LABELV $1459
line 2476
;2475:
;2476:	type[i] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 600
ADDP4
CNSTI1 0
ASGNI1
line 2478
;2477:
;2478:	if (notetrack[i] != ' ')
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $1460
line 2479
;2479:	{ //didn't pass in a valid notetrack type, or forgot the argument for it
line 2480
;2480:		return;
ADDRGP4 $1452
JUMPV
LABELV $1460
line 2483
;2481:	}
;2482:
;2483:	i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $1463
JUMPV
LABELV $1462
line 2486
;2484:
;2485:	while (notetrack[i] && notetrack[i] != ' ')
;2486:	{
line 2487
;2487:		argument[r] = notetrack[i];
ADDRLP4 516
INDIRI4
ADDRLP4 856
ADDP4
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 2488
;2488:		r++;
ADDRLP4 516
ADDRLP4 516
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2489
;2489:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2490
;2490:	}
LABELV $1463
line 2485
ADDRLP4 1716
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1716
INDIRI4
CNSTI4 0
EQI4 $1465
ADDRLP4 1716
INDIRI4
CNSTI4 32
NEI4 $1462
LABELV $1465
line 2491
;2491:	argument[r] = '\0';
ADDRLP4 516
INDIRI4
ADDRLP4 856
ADDP4
CNSTI1 0
ASGNI1
line 2493
;2492:
;2493:	if (!r)
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $1466
line 2494
;2494:	{
line 2495
;2495:		return;
ADDRGP4 $1452
JUMPV
LABELV $1466
line 2498
;2496:	}
;2497:
;2498:	if (notetrack[i] == ' ')
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $1468
line 2499
;2499:	{ //additional arguments...
line 2500
;2500:		addlArgs = 1;
ADDRLP4 1388
CNSTI4 1
ASGNI4
line 2502
;2501:
;2502:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2503
;2503:		r = 0;
ADDRLP4 516
CNSTI4 0
ASGNI4
ADDRGP4 $1471
JUMPV
LABELV $1470
line 2505
;2504:		while (notetrack[i])
;2505:		{
line 2506
;2506:			addlArg[r] = notetrack[i];
ADDRLP4 516
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 2507
;2507:			r++;
ADDRLP4 516
ADDRLP4 516
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2508
;2508:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2509
;2509:		}
LABELV $1471
line 2504
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1470
line 2510
;2510:		addlArg[r] = '\0';
ADDRLP4 516
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 2511
;2511:	}
LABELV $1468
line 2513
;2512:
;2513:	if (strcmp(type, "effect") == 0)
ADDRLP4 600
ARGP4
ADDRGP4 $1475
ARGP4
ADDRLP4 1720
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1720
INDIRI4
CNSTI4 0
NEI4 $1473
line 2514
;2514:	{
line 2515
;2515:		if (!addlArgs)
ADDRLP4 1388
INDIRI4
CNSTI4 0
NEI4 $1476
line 2516
;2516:		{
line 2519
;2517:			//sprintf(errMsg, "Offset position argument for 'effect' type is invalid.");
;2518:			//goto functionend;
;2519:			VectorClear(parsedOffset);
ADDRLP4 1724
CNSTF4 0
ASGNF4
ADDRLP4 588+8
ADDRLP4 1724
INDIRF4
ASGNF4
ADDRLP4 588+4
ADDRLP4 1724
INDIRF4
ASGNF4
ADDRLP4 588
ADDRLP4 1724
INDIRF4
ASGNF4
line 2520
;2520:			goto defaultoffsetposition;
ADDRGP4 $1480
JUMPV
LABELV $1476
line 2523
;2521:		}
;2522:
;2523:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1482
JUMPV
LABELV $1481
line 2526
;2524:
;2525:		while (posoffsetGathered < 3)
;2526:		{
line 2527
;2527:			r = 0;
ADDRLP4 516
CNSTI4 0
ASGNI4
ADDRGP4 $1485
JUMPV
LABELV $1484
line 2529
;2528:			while (addlArg[i] && addlArg[i] != '+' && addlArg[i] != ' ')
;2529:			{
line 2530
;2530:				t[r] = addlArg[i];
ADDRLP4 516
INDIRI4
ADDRLP4 520
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
ASGNI1
line 2531
;2531:				r++;
ADDRLP4 516
ADDRLP4 516
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2532
;2532:				i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2533
;2533:			}
LABELV $1485
line 2528
ADDRLP4 1724
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1724
INDIRI4
CNSTI4 0
EQI4 $1488
ADDRLP4 1724
INDIRI4
CNSTI4 43
EQI4 $1488
ADDRLP4 1724
INDIRI4
CNSTI4 32
NEI4 $1484
LABELV $1488
line 2534
;2534:			t[r] = '\0';
ADDRLP4 516
INDIRI4
ADDRLP4 520
ADDP4
CNSTI1 0
ASGNI1
line 2535
;2535:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2536
;2536:			if (!r)
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $1489
line 2537
;2537:			{ //failure..
line 2540
;2538:				//sprintf(errMsg, "Offset position argument for 'effect' type is invalid.");
;2539:				//goto functionend;
;2540:				VectorClear(parsedOffset);
ADDRLP4 1728
CNSTF4 0
ASGNF4
ADDRLP4 588+8
ADDRLP4 1728
INDIRF4
ASGNF4
ADDRLP4 588+4
ADDRLP4 1728
INDIRF4
ASGNF4
ADDRLP4 588
ADDRLP4 1728
INDIRF4
ASGNF4
line 2541
;2541:				i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2542
;2542:				goto defaultoffsetposition;
ADDRGP4 $1480
JUMPV
LABELV $1489
line 2544
;2543:			}
;2544:			parsedOffset[posoffsetGathered] = atof(t);
ADDRLP4 520
ARGP4
ADDRLP4 1728
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 584
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 588
ADDP4
ADDRLP4 1728
INDIRF4
ASGNF4
line 2545
;2545:			posoffsetGathered++;
ADDRLP4 584
ADDRLP4 584
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2546
;2546:		}
LABELV $1482
line 2525
ADDRLP4 584
INDIRI4
CNSTI4 3
LTI4 $1481
line 2548
;2547:
;2548:		if (posoffsetGathered < 3)
ADDRLP4 584
INDIRI4
CNSTI4 3
GEI4 $1493
line 2549
;2549:		{
line 2550
;2550:			Com_sprintf(errMsg, sizeof(errMsg), "Offset position argument for 'effect' type is invalid.");
ADDRLP4 1392
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1495
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2551
;2551:			goto functionend;
ADDRGP4 $1496
JUMPV
LABELV $1493
line 2554
;2552:		}
;2553:
;2554:		i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2556
;2555:
;2556:		if (addlArg[i] != ' ')
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $1497
line 2557
;2557:		{
line 2558
;2558:			addlArgs = 0;
ADDRLP4 1388
CNSTI4 0
ASGNI4
line 2559
;2559:		}
LABELV $1497
LABELV $1480
line 2563
;2560:
;2561:defaultoffsetposition:
;2562:
;2563:		objectID = trap_FX_RegisterEffect(argument);
ADDRLP4 856
ARGP4
ADDRLP4 1724
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 1372
ADDRLP4 1724
INDIRI4
ASGNI4
line 2565
;2564:
;2565:		if (objectID)
ADDRLP4 1372
INDIRI4
CNSTI4 0
EQI4 $1452
line 2566
;2566:		{
line 2567
;2567:			if (addlArgs)
ADDRLP4 1388
INDIRI4
CNSTI4 0
EQI4 $1501
line 2568
;2568:			{ //if there is an additional argument for an effect it is expected to be XANGLE-YANGLE-ZANGLE
line 2569
;2569:				i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $1504
JUMPV
LABELV $1503
line 2571
;2570:				while (anglesGathered < 3)
;2571:				{
line 2572
;2572:					r = 0;
ADDRLP4 516
CNSTI4 0
ASGNI4
ADDRGP4 $1507
JUMPV
LABELV $1506
line 2574
;2573:					while (addlArg[i] && addlArg[i] != '-')
;2574:					{
line 2575
;2575:						t[r] = addlArg[i];
ADDRLP4 516
INDIRI4
ADDRLP4 520
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
ASGNI1
line 2576
;2576:						r++;
ADDRLP4 516
ADDRLP4 516
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2577
;2577:						i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2578
;2578:					}
LABELV $1507
line 2573
ADDRLP4 1728
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1728
INDIRI4
CNSTI4 0
EQI4 $1509
ADDRLP4 1728
INDIRI4
CNSTI4 45
NEI4 $1506
LABELV $1509
line 2579
;2579:					t[r] = '\0';
ADDRLP4 516
INDIRI4
ADDRLP4 520
ADDP4
CNSTI1 0
ASGNI1
line 2580
;2580:					i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2582
;2581:
;2582:					if (!r)
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $1510
line 2583
;2583:					{ //failed to get a new part of the vector
line 2584
;2584:						anglesGathered = 0;
ADDRLP4 1368
CNSTI4 0
ASGNI4
line 2585
;2585:						break;
ADDRGP4 $1505
JUMPV
LABELV $1510
line 2588
;2586:					}
;2587:
;2588:					parsedAngles[anglesGathered] = atof(t);
ADDRLP4 520
ARGP4
ADDRLP4 1732
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1368
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1648
ADDP4
ADDRLP4 1732
INDIRF4
ASGNF4
line 2589
;2589:					anglesGathered++;
ADDRLP4 1368
ADDRLP4 1368
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2590
;2590:				}
LABELV $1504
line 2570
ADDRLP4 1368
INDIRI4
CNSTI4 3
LTI4 $1503
LABELV $1505
line 2592
;2591:
;2592:				if (anglesGathered)
ADDRLP4 1368
INDIRI4
CNSTI4 0
EQI4 $1512
line 2593
;2593:				{
line 2594
;2594:					VectorCopy(parsedAngles, useAngles);
ADDRLP4 1696
ADDRLP4 1648
INDIRB
ASGNB 12
line 2595
;2595:				}
ADDRGP4 $1502
JUMPV
LABELV $1512
line 2597
;2596:				else
;2597:				{ //failed to parse angles from the extra argument provided..
line 2598
;2598:					VectorCopy(cent->lerpAngles, useAngles);
ADDRLP4 1696
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 2599
;2599:				}
line 2600
;2600:			}
ADDRGP4 $1502
JUMPV
LABELV $1501
line 2602
;2601:			else
;2602:			{ //if no constant angles, play in direction entity is facing
line 2603
;2603:				VectorCopy(cent->lerpAngles, useAngles);
ADDRLP4 1696
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 2604
;2604:			}
LABELV $1502
line 2606
;2605:
;2606:			AngleVectors(useAngles, forward, right, up);
ADDRLP4 1696
ARGP4
ADDRLP4 1660
ARGP4
ADDRLP4 1672
ARGP4
ADDRLP4 1684
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2608
;2607:
;2608:			VectorCopy(cent->lerpOrigin, useOrigin);
ADDRLP4 1376
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2611
;2609:
;2610:			//forward
;2611:			useOrigin[0] += forward[0]*parsedOffset[0];
ADDRLP4 1376
ADDRLP4 1376
INDIRF4
ADDRLP4 1660
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ADDF4
ASGNF4
line 2612
;2612:			useOrigin[1] += forward[1]*parsedOffset[0];
ADDRLP4 1376+4
ADDRLP4 1376+4
INDIRF4
ADDRLP4 1660+4
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ADDF4
ASGNF4
line 2613
;2613:			useOrigin[2] += forward[2]*parsedOffset[0];
ADDRLP4 1376+8
ADDRLP4 1376+8
INDIRF4
ADDRLP4 1660+8
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ADDF4
ASGNF4
line 2616
;2614:
;2615:			//right
;2616:			useOrigin[0] += right[0]*parsedOffset[1];
ADDRLP4 1376
ADDRLP4 1376
INDIRF4
ADDRLP4 1672
INDIRF4
ADDRLP4 588+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2617
;2617:			useOrigin[1] += right[1]*parsedOffset[1];
ADDRLP4 1376+4
ADDRLP4 1376+4
INDIRF4
ADDRLP4 1672+4
INDIRF4
ADDRLP4 588+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2618
;2618:			useOrigin[2] += right[2]*parsedOffset[1];
ADDRLP4 1376+8
ADDRLP4 1376+8
INDIRF4
ADDRLP4 1672+8
INDIRF4
ADDRLP4 588+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2621
;2619:
;2620:			//up
;2621:			useOrigin[0] += up[0]*parsedOffset[2];
ADDRLP4 1376
ADDRLP4 1376
INDIRF4
ADDRLP4 1684
INDIRF4
ADDRLP4 588+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2622
;2622:			useOrigin[1] += up[1]*parsedOffset[2];
ADDRLP4 1376+4
ADDRLP4 1376+4
INDIRF4
ADDRLP4 1684+4
INDIRF4
ADDRLP4 588+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2623
;2623:			useOrigin[2] += up[2]*parsedOffset[2];
ADDRLP4 1376+8
ADDRLP4 1376+8
INDIRF4
ADDRLP4 1684+8
INDIRF4
ADDRLP4 588+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2625
;2624:
;2625:			trap_FX_PlayEffectID(objectID, useOrigin, useAngles);
ADDRLP4 1372
INDIRI4
ARGI4
ADDRLP4 1376
ARGP4
ADDRLP4 1696
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 2626
;2626:		}
line 2627
;2627:	}
ADDRGP4 $1452
JUMPV
LABELV $1473
line 2628
;2628:	else if (strcmp(type, "sound") == 0)
ADDRLP4 600
ARGP4
ADDRGP4 $1534
ARGP4
ADDRLP4 1724
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1724
INDIRI4
CNSTI4 0
NEI4 $1532
line 2629
;2629:	{
line 2630
;2630:		objectID = trap_S_RegisterSound(argument);
ADDRLP4 856
ARGP4
ADDRLP4 1728
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 1372
ADDRLP4 1728
INDIRI4
ASGNI4
line 2631
;2631:		trap_S_StartSound(cent->lerpOrigin, cent->currentState.number, CHAN_BODY, objectID);
ADDRLP4 1732
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1732
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 1732
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 1372
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2632
;2632:	}
ADDRGP4 $1452
JUMPV
LABELV $1532
line 2633
;2633:	else if (strcmp(type, "loop") == 0)
ADDRLP4 600
ARGP4
ADDRGP4 $1537
ARGP4
ADDRLP4 1728
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1728
INDIRI4
CNSTI4 0
NEI4 $1535
line 2634
;2634:	{ //handled server-side
line 2635
;2635:		return;
ADDRGP4 $1452
JUMPV
LABELV $1535
line 2639
;2636:	}
;2637:	//else if ...
;2638:	else
;2639:	{
line 2640
;2640:		if (type[0])
ADDRLP4 600
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1538
line 2641
;2641:		{
line 2642
;2642:			Com_Printf("^3Warning: \"%s\" is an invalid ROFF notetrack function\n", type);
ADDRGP4 $1540
ARGP4
ADDRLP4 600
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 2643
;2643:		}
ADDRGP4 $1452
JUMPV
LABELV $1538
line 2645
;2644:		else
;2645:		{
line 2646
;2646:			Com_Printf("^3Warning: Notetrack is missing function and/or arguments\n");
ADDRGP4 $1541
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 2647
;2647:		}
line 2648
;2648:	}
line 2650
;2649:
;2650:	return;
ADDRGP4 $1452
JUMPV
LABELV $1496
line 2653
;2651:
;2652:functionend:
;2653:	Com_Printf("^3Type-specific notetrack error: %s\n", errMsg);
ADDRGP4 $1542
ARGP4
ADDRLP4 1392
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 2654
;2654:	return;
LABELV $1452
endproc CG_ROFF_NotetrackCallback 1736 16
import g2WeaponInstances
import CG_CheckPlayerG2Weapons
import CG_CopyG2WeaponInstance
import CG_ShutDownG2Weapons
import CG_InitG2Weapons
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
LABELV $1542
char 1 94
char 1 51
char 1 84
char 1 121
char 1 112
char 1 101
char 1 45
char 1 115
char 1 112
char 1 101
char 1 99
char 1 105
char 1 102
char 1 105
char 1 99
char 1 32
char 1 110
char 1 111
char 1 116
char 1 101
char 1 116
char 1 114
char 1 97
char 1 99
char 1 107
char 1 32
char 1 101
char 1 114
char 1 114
char 1 111
char 1 114
char 1 58
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $1541
char 1 94
char 1 51
char 1 87
char 1 97
char 1 114
char 1 110
char 1 105
char 1 110
char 1 103
char 1 58
char 1 32
char 1 78
char 1 111
char 1 116
char 1 101
char 1 116
char 1 114
char 1 97
char 1 99
char 1 107
char 1 32
char 1 105
char 1 115
char 1 32
char 1 109
char 1 105
char 1 115
char 1 115
char 1 105
char 1 110
char 1 103
char 1 32
char 1 102
char 1 117
char 1 110
char 1 99
char 1 116
char 1 105
char 1 111
char 1 110
char 1 32
char 1 97
char 1 110
char 1 100
char 1 47
char 1 111
char 1 114
char 1 32
char 1 97
char 1 114
char 1 103
char 1 117
char 1 109
char 1 101
char 1 110
char 1 116
char 1 115
char 1 10
char 1 0
align 1
LABELV $1540
char 1 94
char 1 51
char 1 87
char 1 97
char 1 114
char 1 110
char 1 105
char 1 110
char 1 103
char 1 58
char 1 32
char 1 34
char 1 37
char 1 115
char 1 34
char 1 32
char 1 105
char 1 115
char 1 32
char 1 97
char 1 110
char 1 32
char 1 105
char 1 110
char 1 118
char 1 97
char 1 108
char 1 105
char 1 100
char 1 32
char 1 82
char 1 79
char 1 70
char 1 70
char 1 32
char 1 110
char 1 111
char 1 116
char 1 101
char 1 116
char 1 114
char 1 97
char 1 99
char 1 107
char 1 32
char 1 102
char 1 117
char 1 110
char 1 99
char 1 116
char 1 105
char 1 111
char 1 110
char 1 10
char 1 0
align 1
LABELV $1537
char 1 108
char 1 111
char 1 111
char 1 112
char 1 0
align 1
LABELV $1534
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $1495
char 1 79
char 1 102
char 1 102
char 1 115
char 1 101
char 1 116
char 1 32
char 1 112
char 1 111
char 1 115
char 1 105
char 1 116
char 1 105
char 1 111
char 1 110
char 1 32
char 1 97
char 1 114
char 1 103
char 1 117
char 1 109
char 1 101
char 1 110
char 1 116
char 1 32
char 1 102
char 1 111
char 1 114
char 1 32
char 1 39
char 1 101
char 1 102
char 1 102
char 1 101
char 1 99
char 1 116
char 1 39
char 1 32
char 1 116
char 1 121
char 1 112
char 1 101
char 1 32
char 1 105
char 1 115
char 1 32
char 1 105
char 1 110
char 1 118
char 1 97
char 1 108
char 1 105
char 1 100
char 1 46
char 1 0
align 1
LABELV $1475
char 1 101
char 1 102
char 1 102
char 1 101
char 1 99
char 1 116
char 1 0
align 1
LABELV $1380
char 1 66
char 1 97
char 1 100
char 1 32
char 1 101
char 1 110
char 1 116
char 1 105
char 1 116
char 1 121
char 1 32
char 1 116
char 1 121
char 1 112
char 1 101
char 1 58
char 1 32
char 1 37
char 1 105
char 1 10
char 1 0
align 1
LABELV $1315
char 1 67
char 1 71
char 1 95
char 1 73
char 1 110
char 1 116
char 1 101
char 1 114
char 1 112
char 1 111
char 1 97
char 1 116
char 1 101
char 1 69
char 1 110
char 1 116
char 1 105
char 1 116
char 1 121
char 1 80
char 1 111
char 1 115
char 1 105
char 1 116
char 1 105
char 1 111
char 1 110
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
LABELV $1232
char 1 116
char 1 114
char 1 105
char 1 112
char 1 77
char 1 105
char 1 110
char 1 101
char 1 47
char 1 108
char 1 97
char 1 115
char 1 101
char 1 114
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1085
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
char 1 95
char 1 119
char 1 46
char 1 103
char 1 108
char 1 109
char 1 0
align 1
LABELV $863
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 109
char 1 112
char 1 95
char 1 100
char 1 97
char 1 114
char 1 107
char 1 95
char 1 101
char 1 110
char 1 108
char 1 105
char 1 103
char 1 104
char 1 116
char 1 95
char 1 100
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $861
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 109
char 1 112
char 1 95
char 1 108
char 1 105
char 1 103
char 1 104
char 1 116
char 1 95
char 1 101
char 1 110
char 1 108
char 1 105
char 1 103
char 1 104
char 1 116
char 1 95
char 1 100
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $809
char 1 109
char 1 112
char 1 47
char 1 105
char 1 116
char 1 101
char 1 109
char 1 99
char 1 111
char 1 110
char 1 101
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $780
char 1 66
char 1 97
char 1 100
char 1 32
char 1 105
char 1 116
char 1 101
char 1 109
char 1 32
char 1 105
char 1 110
char 1 100
char 1 101
char 1 120
char 1 32
char 1 37
char 1 105
char 1 32
char 1 111
char 1 110
char 1 32
char 1 101
char 1 110
char 1 116
char 1 105
char 1 116
char 1 121
char 1 0
align 1
LABELV $495
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 105
char 1 109
char 1 112
char 1 95
char 1 109
char 1 105
char 1 110
char 1 101
char 1 47
char 1 116
char 1 117
char 1 114
char 1 114
char 1 101
char 1 116
char 1 95
char 1 99
char 1 104
char 1 97
char 1 105
char 1 114
char 1 95
char 1 100
char 1 109
char 1 103
char 1 46
char 1 116
char 1 103
char 1 97
char 1 0
align 1
LABELV $479
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
char 1 116
char 1 117
char 1 114
char 1 114
char 1 101
char 1 116
char 1 102
char 1 108
char 1 97
char 1 115
char 1 104
char 1 100
char 1 105
char 1 101
char 1 0
align 1
LABELV $455
char 1 108
char 1 111
char 1 119
char 1 101
char 1 114
char 1 95
char 1 108
char 1 117
char 1 109
char 1 98
char 1 97
char 1 114
char 1 0
align 1
LABELV $420
char 1 66
char 1 111
char 1 110
char 1 101
char 1 48
char 1 50
char 1 0
align 1
LABELV $331
char 1 98
char 1 108
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 115
char 1 109
char 1 111
char 1 107
char 1 101
char 1 95
char 1 98
char 1 111
char 1 108
char 1 116
char 1 111
char 1 110
char 1 0
align 1
LABELV $321
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 95
char 1 114
char 1 111
char 1 111
char 1 116
char 1 0
align 1
LABELV $319
char 1 117
char 1 112
char 1 112
char 1 101
char 1 114
char 1 95
char 1 108
char 1 117
char 1 109
char 1 98
char 1 97
char 1 114
char 1 0
align 1
LABELV $307
char 1 42
char 1 104
char 1 105
char 1 112
char 1 115
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 114
char 1 95
char 1 108
char 1 101
char 1 103
char 1 0
align 1
LABELV $306
char 1 42
char 1 114
char 1 95
char 1 108
char 1 101
char 1 103
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 104
char 1 105
char 1 112
char 1 115
char 1 0
align 1
LABELV $305
char 1 104
char 1 105
char 1 112
char 1 115
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 114
char 1 95
char 1 108
char 1 101
char 1 103
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $304
char 1 114
char 1 95
char 1 108
char 1 101
char 1 103
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 104
char 1 105
char 1 112
char 1 115
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $303
char 1 114
char 1 95
char 1 108
char 1 101
char 1 103
char 1 0
align 1
LABELV $302
char 1 114
char 1 116
char 1 105
char 1 98
char 1 105
char 1 97
char 1 0
align 1
LABELV $301
char 1 114
char 1 102
char 1 101
char 1 109
char 1 117
char 1 114
char 1 89
char 1 90
char 1 0
align 1
LABELV $299
char 1 42
char 1 104
char 1 105
char 1 112
char 1 115
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 108
char 1 95
char 1 108
char 1 101
char 1 103
char 1 0
align 1
LABELV $298
char 1 42
char 1 108
char 1 95
char 1 108
char 1 101
char 1 103
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 104
char 1 105
char 1 112
char 1 115
char 1 0
align 1
LABELV $297
char 1 104
char 1 105
char 1 112
char 1 115
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 108
char 1 95
char 1 108
char 1 101
char 1 103
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $296
char 1 108
char 1 95
char 1 108
char 1 101
char 1 103
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 104
char 1 105
char 1 112
char 1 115
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $295
char 1 108
char 1 95
char 1 108
char 1 101
char 1 103
char 1 0
align 1
LABELV $294
char 1 108
char 1 116
char 1 105
char 1 98
char 1 105
char 1 97
char 1 0
align 1
LABELV $293
char 1 108
char 1 102
char 1 101
char 1 109
char 1 117
char 1 114
char 1 89
char 1 90
char 1 0
align 1
LABELV $291
char 1 42
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 114
char 1 95
char 1 97
char 1 114
char 1 109
char 1 0
align 1
LABELV $290
char 1 42
char 1 114
char 1 95
char 1 97
char 1 114
char 1 109
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 0
align 1
LABELV $289
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 114
char 1 95
char 1 97
char 1 114
char 1 109
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $288
char 1 114
char 1 95
char 1 97
char 1 114
char 1 109
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $287
char 1 114
char 1 95
char 1 97
char 1 114
char 1 109
char 1 0
align 1
LABELV $286
char 1 114
char 1 114
char 1 97
char 1 100
char 1 105
char 1 117
char 1 115
char 1 0
align 1
LABELV $285
char 1 114
char 1 104
char 1 117
char 1 109
char 1 101
char 1 114
char 1 117
char 1 115
char 1 0
align 1
LABELV $283
char 1 42
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 108
char 1 95
char 1 97
char 1 114
char 1 109
char 1 0
align 1
LABELV $282
char 1 42
char 1 108
char 1 95
char 1 97
char 1 114
char 1 109
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 0
align 1
LABELV $281
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 108
char 1 95
char 1 97
char 1 114
char 1 109
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $280
char 1 108
char 1 95
char 1 97
char 1 114
char 1 109
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $279
char 1 108
char 1 95
char 1 97
char 1 114
char 1 109
char 1 0
align 1
LABELV $278
char 1 108
char 1 114
char 1 97
char 1 100
char 1 105
char 1 117
char 1 115
char 1 0
align 1
LABELV $277
char 1 108
char 1 104
char 1 117
char 1 109
char 1 101
char 1 114
char 1 117
char 1 115
char 1 0
align 1
LABELV $275
char 1 42
char 1 104
char 1 105
char 1 112
char 1 115
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 0
align 1
LABELV $274
char 1 42
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 104
char 1 105
char 1 112
char 1 115
char 1 0
align 1
LABELV $273
char 1 104
char 1 105
char 1 112
char 1 115
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $272
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 104
char 1 105
char 1 112
char 1 115
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $271
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 0
align 1
LABELV $270
char 1 116
char 1 104
char 1 111
char 1 114
char 1 97
char 1 99
char 1 105
char 1 99
char 1 0
align 1
LABELV $269
char 1 112
char 1 101
char 1 108
char 1 118
char 1 105
char 1 115
char 1 0
align 1
LABELV $267
char 1 42
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 104
char 1 101
char 1 97
char 1 100
char 1 0
align 1
LABELV $266
char 1 42
char 1 104
char 1 101
char 1 97
char 1 100
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 0
align 1
LABELV $265
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 104
char 1 101
char 1 97
char 1 100
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $264
char 1 104
char 1 101
char 1 97
char 1 100
char 1 95
char 1 99
char 1 97
char 1 112
char 1 95
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 95
char 1 111
char 1 102
char 1 102
char 1 0
align 1
LABELV $263
char 1 104
char 1 101
char 1 97
char 1 100
char 1 0
align 1
LABELV $262
char 1 99
char 1 114
char 1 97
char 1 110
char 1 105
char 1 117
char 1 109
char 1 0
align 1
LABELV $261
char 1 99
char 1 101
char 1 114
char 1 118
char 1 105
char 1 99
char 1 97
char 1 108
char 1 0
align 1
LABELV $235
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 95
char 1 116
char 1 104
char 1 114
char 1 111
char 1 119
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $234
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 95
char 1 100
char 1 101
char 1 102
char 1 101
char 1 110
char 1 100
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $233
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 95
char 1 97
char 1 116
char 1 116
char 1 97
char 1 99
char 1 107
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $232
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 115
char 1 105
char 1 103
char 1 104
char 1 116
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $231
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 100
char 1 107
char 1 95
char 1 100
char 1 114
char 1 97
char 1 105
char 1 110
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $230
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 100
char 1 107
char 1 95
char 1 112
char 1 111
char 1 119
char 1 101
char 1 114
char 1 111
char 1 116
char 1 104
char 1 101
char 1 114
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $229
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 108
char 1 116
char 1 95
char 1 104
char 1 101
char 1 97
char 1 108
char 1 111
char 1 116
char 1 104
char 1 101
char 1 114
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $228
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 108
char 1 116
char 1 95
char 1 97
char 1 98
char 1 115
char 1 111
char 1 114
char 1 98
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $227
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 108
char 1 116
char 1 95
char 1 112
char 1 114
char 1 111
char 1 116
char 1 101
char 1 99
char 1 116
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $226
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 100
char 1 107
char 1 95
char 1 114
char 1 97
char 1 103
char 1 101
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $225
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 100
char 1 107
char 1 95
char 1 108
char 1 105
char 1 103
char 1 104
char 1 116
char 1 110
char 1 105
char 1 110
char 1 103
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $224
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 100
char 1 107
char 1 95
char 1 103
char 1 114
char 1 105
char 1 112
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $223
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 108
char 1 116
char 1 95
char 1 116
char 1 101
char 1 108
char 1 101
char 1 112
char 1 97
char 1 116
char 1 104
char 1 121
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $222
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 112
char 1 117
char 1 108
char 1 108
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $221
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 112
char 1 117
char 1 115
char 1 104
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $220
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 115
char 1 112
char 1 101
char 1 101
char 1 100
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $219
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 106
char 1 117
char 1 109
char 1 112
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $218
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 109
char 1 97
char 1 112
char 1 95
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 108
char 1 116
char 1 95
char 1 104
char 1 101
char 1 97
char 1 108
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $179
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 98
char 1 108
char 1 117
char 1 101
char 1 95
char 1 112
char 1 111
char 1 114
char 1 116
char 1 97
char 1 115
char 1 104
char 1 105
char 1 101
char 1 108
char 1 100
char 1 0
align 1
LABELV $178
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 98
char 1 108
char 1 117
char 1 101
char 1 95
char 1 100
char 1 109
char 1 103
char 1 115
char 1 104
char 1 105
char 1 101
char 1 108
char 1 100
char 1 0
align 1
LABELV $175
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 114
char 1 101
char 1 100
char 1 95
char 1 112
char 1 111
char 1 114
char 1 116
char 1 97
char 1 115
char 1 104
char 1 105
char 1 101
char 1 108
char 1 100
char 1 0
align 1
LABELV $174
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 114
char 1 101
char 1 100
char 1 95
char 1 100
char 1 109
char 1 103
char 1 115
char 1 104
char 1 105
char 1 101
char 1 108
char 1 100
char 1 0
align 1
LABELV $156
char 1 99
char 1 108
char 1 95
char 1 112
char 1 97
char 1 117
char 1 115
char 1 101
char 1 100
char 1 0
