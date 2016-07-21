export CG_TestModel_f
code
proc CG_TestModel_f 36 12
file "../cg_view.c"
line 58
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_view.c -- setup all the parameters (position, angle, etc)
;4:// for a 3D rendering
;5:#include "cg_local.h"
;6:
;7:#if !defined(CL_LIGHT_H_INC)
;8:	#include "cg_lights.h"
;9:#endif
;10:
;11:#define MASK_CAMERACLIP (MASK_SOLID|CONTENTS_PLAYERCLIP)
;12:#define CAMERA_SIZE	4
;13:
;14:
;15:/*
;16:=============================================================================
;17:
;18:  MODEL TESTING
;19:
;20:The viewthing and gun positioning tools from Q2 have been integrated and
;21:enhanced into a single model testing facility.
;22:
;23:Model viewing can begin with either "testmodel <modelname>" or "testgun <modelname>".
;24:
;25:The names must be the full pathname after the basedir, like 
;26:"models/weapons/v_launch/tris.md3" or "players/male/tris.md3"
;27:
;28:Testmodel will create a fake entity 100 units in front of the current view
;29:position, directly facing the viewer.  It will remain immobile, so you can
;30:move around it to view it from different angles.
;31:
;32:Testgun will cause the model to follow the player around and supress the real
;33:view weapon model.  The default frame 0 of most guns is completely off screen,
;34:so you will probably have to cycle a couple frames to see it.
;35:
;36:"nextframe", "prevframe", "nextskin", and "prevskin" commands will change the
;37:frame or skin of the testmodel.  These are bound to F5, F6, F7, and F8 in
;38:q3default.cfg.
;39:
;40:If a gun is being tested, the "gun_x", "gun_y", and "gun_z" variables will let
;41:you adjust the positioning.
;42:
;43:Note that none of the model testing features update while the game is paused, so
;44:it may be convenient to test with deathmatch set to 1 so that bringing down the
;45:console doesn't pause the game.
;46:
;47:=============================================================================
;48:*/
;49:
;50:/*
;51:=================
;52:CG_TestModel_f
;53:
;54:Creates an entity in front of the current position, which
;55:can then be moved around
;56:=================
;57:*/
;58:void CG_TestModel_f (void) {
line 61
;59:	vec3_t		angles;
;60:
;61:	memset( &cg.testModelEntity, 0, sizeof(cg.testModelEntity) );
ADDRGP4 cg+13472
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 62
;62:	if ( trap_Argc() < 2 ) {
ADDRLP4 12
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
GEI4 $124
line 63
;63:		return;
ADDRGP4 $121
JUMPV
LABELV $124
line 66
;64:	}
;65:
;66:	Q_strncpyz (cg.testModelName, CG_Argv( 1 ), MAX_QPATH );
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRGP4 cg+13684
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 67
;67:	cg.testModelEntity.hModel = trap_R_RegisterModel( cg.testModelName );
ADDRGP4 cg+13684
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cg+13472+8
ADDRLP4 20
INDIRI4
ASGNI4
line 69
;68:
;69:	if ( trap_Argc() == 3 ) {
ADDRLP4 24
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 3
NEI4 $130
line 70
;70:		cg.testModelEntity.backlerp = atof( CG_Argv( 2 ) );
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 cg+13472+128
ADDRLP4 32
INDIRF4
ASGNF4
line 71
;71:		cg.testModelEntity.frame = 1;
ADDRGP4 cg+13472+104
CNSTI4 1
ASGNI4
line 72
;72:		cg.testModelEntity.oldframe = 0;
ADDRGP4 cg+13472+124
CNSTI4 0
ASGNI4
line 73
;73:	}
LABELV $130
line 74
;74:	if (! cg.testModelEntity.hModel ) {
ADDRGP4 cg+13472+8
INDIRI4
CNSTI4 0
NEI4 $138
line 75
;75:		CG_Printf( "Can't register model\n" );
ADDRGP4 $142
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 76
;76:		return;
ADDRGP4 $121
JUMPV
LABELV $138
line 79
;77:	}
;78:
;79:	VectorMA( cg.refdef.vieworg, 100, cg.refdef.viewaxis[0], cg.testModelEntity.origin );
ADDRGP4 cg+13472+52
ADDRGP4 cg+3604+24
INDIRF4
CNSTF4 1120403456
ADDRGP4 cg+3604+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+13472+52+4
ADDRGP4 cg+3604+24+4
INDIRF4
CNSTF4 1120403456
ADDRGP4 cg+3604+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+13472+52+8
ADDRGP4 cg+3604+24+8
INDIRF4
CNSTF4 1120403456
ADDRGP4 cg+3604+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 81
;80:
;81:	angles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 82
;82:	angles[YAW] = 180 + cg.refdefViewAngles[1];
ADDRLP4 0+4
ADDRGP4 cg+3972+4
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 83
;83:	angles[ROLL] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 85
;84:
;85:	AnglesToAxis( angles, cg.testModelEntity.axis );
ADDRLP4 0
ARGP4
ADDRGP4 cg+13472+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 86
;86:	cg.testGun = qfalse;
ADDRGP4 cg+13748
CNSTI4 0
ASGNI4
line 87
;87:}
LABELV $121
endproc CG_TestModel_f 36 12
export CG_TestGun_f
proc CG_TestGun_f 0 0
line 96
;88:
;89:/*
;90:=================
;91:CG_TestGun_f
;92:
;93:Replaces the current view weapon with the given model
;94:=================
;95:*/
;96:void CG_TestGun_f (void) {
line 97
;97:	CG_TestModel_f();
ADDRGP4 CG_TestModel_f
CALLV
pop
line 98
;98:	cg.testGun = qtrue;
ADDRGP4 cg+13748
CNSTI4 1
ASGNI4
line 102
;99:	//cg.testModelEntity.renderfx = RF_MINLIGHT | RF_DEPTHHACK | RF_FIRST_PERSON;
;100:
;101:	// rww - 9-13-01 [1-26-01-sof2]
;102:	cg.testModelEntity.renderfx = RF_DEPTHHACK | RF_FIRST_PERSON;
ADDRGP4 cg+13472+4
CNSTI4 12
ASGNI4
line 103
;103:}
LABELV $174
endproc CG_TestGun_f 0 0
export CG_TestModelNextFrame_f
proc CG_TestModelNextFrame_f 4 8
line 106
;104:
;105:
;106:void CG_TestModelNextFrame_f (void) {
line 107
;107:	cg.testModelEntity.frame++;
ADDRLP4 0
ADDRGP4 cg+13472+104
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 108
;108:	CG_Printf( "frame %i\n", cg.testModelEntity.frame );
ADDRGP4 $181
ARGP4
ADDRGP4 cg+13472+104
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 109
;109:}
LABELV $178
endproc CG_TestModelNextFrame_f 4 8
export CG_TestModelPrevFrame_f
proc CG_TestModelPrevFrame_f 4 8
line 111
;110:
;111:void CG_TestModelPrevFrame_f (void) {
line 112
;112:	cg.testModelEntity.frame--;
ADDRLP4 0
ADDRGP4 cg+13472+104
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 113
;113:	if ( cg.testModelEntity.frame < 0 ) {
ADDRGP4 cg+13472+104
INDIRI4
CNSTI4 0
GEI4 $187
line 114
;114:		cg.testModelEntity.frame = 0;
ADDRGP4 cg+13472+104
CNSTI4 0
ASGNI4
line 115
;115:	}
LABELV $187
line 116
;116:	CG_Printf( "frame %i\n", cg.testModelEntity.frame );
ADDRGP4 $181
ARGP4
ADDRGP4 cg+13472+104
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 117
;117:}
LABELV $184
endproc CG_TestModelPrevFrame_f 4 8
export CG_TestModelNextSkin_f
proc CG_TestModelNextSkin_f 4 8
line 119
;118:
;119:void CG_TestModelNextSkin_f (void) {
line 120
;120:	cg.testModelEntity.skinNum++;
ADDRLP4 0
ADDRGP4 cg+13472+132
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 121
;121:	CG_Printf( "skin %i\n", cg.testModelEntity.skinNum );
ADDRGP4 $198
ARGP4
ADDRGP4 cg+13472+132
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 122
;122:}
LABELV $195
endproc CG_TestModelNextSkin_f 4 8
export CG_TestModelPrevSkin_f
proc CG_TestModelPrevSkin_f 4 8
line 124
;123:
;124:void CG_TestModelPrevSkin_f (void) {
line 125
;125:	cg.testModelEntity.skinNum--;
ADDRLP4 0
ADDRGP4 cg+13472+132
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 126
;126:	if ( cg.testModelEntity.skinNum < 0 ) {
ADDRGP4 cg+13472+132
INDIRI4
CNSTI4 0
GEI4 $204
line 127
;127:		cg.testModelEntity.skinNum = 0;
ADDRGP4 cg+13472+132
CNSTI4 0
ASGNI4
line 128
;128:	}
LABELV $204
line 129
;129:	CG_Printf( "skin %i\n", cg.testModelEntity.skinNum );
ADDRGP4 $198
ARGP4
ADDRGP4 cg+13472+132
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 130
;130:}
LABELV $201
endproc CG_TestModelPrevSkin_f 4 8
proc CG_AddTestModel 32 4
line 132
;131:
;132:static void CG_AddTestModel (void) {
line 136
;133:	int		i;
;134:
;135:	// re-register the model, because the level may have changed
;136:	cg.testModelEntity.hModel = trap_R_RegisterModel( cg.testModelName );
ADDRGP4 cg+13684
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cg+13472+8
ADDRLP4 4
INDIRI4
ASGNI4
line 137
;137:	if (! cg.testModelEntity.hModel ) {
ADDRGP4 cg+13472+8
INDIRI4
CNSTI4 0
NEI4 $216
line 138
;138:		CG_Printf ("Can't register model\n");
ADDRGP4 $142
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 139
;139:		return;
ADDRGP4 $212
JUMPV
LABELV $216
line 143
;140:	}
;141:
;142:	// if testing a gun, set the origin reletive to the view origin
;143:	if ( cg.testGun ) {
ADDRGP4 cg+13748
INDIRI4
CNSTI4 0
EQI4 $220
line 144
;144:		VectorCopy( cg.refdef.vieworg, cg.testModelEntity.origin );
ADDRGP4 cg+13472+52
ADDRGP4 cg+3604+24
INDIRB
ASGNB 12
line 145
;145:		VectorCopy( cg.refdef.viewaxis[0], cg.testModelEntity.axis[0] );
ADDRGP4 cg+13472+12
ADDRGP4 cg+3604+36
INDIRB
ASGNB 12
line 146
;146:		VectorCopy( cg.refdef.viewaxis[1], cg.testModelEntity.axis[1] );
ADDRGP4 cg+13472+12+12
ADDRGP4 cg+3604+36+12
INDIRB
ASGNB 12
line 147
;147:		VectorCopy( cg.refdef.viewaxis[2], cg.testModelEntity.axis[2] );
ADDRGP4 cg+13472+12+24
ADDRGP4 cg+3604+36+24
INDIRB
ASGNB 12
line 150
;148:
;149:		// allow the position to be adjusted
;150:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $243
line 151
;151:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[0][i] * cg_gun_x.value;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 cg+13472+52
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 8
INDIRI4
ADDRGP4 cg+3604+36
ADDP4
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 152
;152:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[1][i] * cg_gun_y.value;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
ADDRLP4 16
INDIRI4
ADDRGP4 cg+13472+52
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 16
INDIRI4
ADDRGP4 cg+3604+36+12
ADDP4
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 153
;153:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[2][i] * cg_gun_z.value;
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
ADDRLP4 24
INDIRI4
ADDRGP4 cg+13472+52
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 24
INDIRI4
ADDRGP4 cg+3604+36+24
ADDP4
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 154
;154:		}
LABELV $244
line 150
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $243
line 155
;155:	}
LABELV $220
line 157
;156:
;157:	trap_R_AddRefEntityToScene( &cg.testModelEntity );
ADDRGP4 cg+13472
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 158
;158:}
LABELV $212
endproc CG_AddTestModel 32 4
proc CG_CalcVrect 12 8
line 172
;159:
;160:
;161:
;162://============================================================================
;163:
;164:
;165:/*
;166:=================
;167:CG_CalcVrect
;168:
;169:Sets the coordinates of the rendered window
;170:=================
;171:*/
;172:static void CG_CalcVrect (void) {
line 176
;173:	int		size;
;174:
;175:	// the intermission should allways be full screen
;176:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 6
NEI4 $266
line 177
;177:		size = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 178
;178:	} else {
ADDRGP4 $267
JUMPV
LABELV $266
line 180
;179:		// bound normal viewsize
;180:		if (cg_viewsize.integer < 30) {
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 30
GEI4 $269
line 181
;181:			trap_Cvar_Set ("cg_viewsize","30");
ADDRGP4 $272
ARGP4
ADDRGP4 $273
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 182
;182:			size = 30;
ADDRLP4 0
CNSTI4 30
ASGNI4
line 183
;183:		} else if (cg_viewsize.integer > 100) {
ADDRGP4 $270
JUMPV
LABELV $269
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 100
LEI4 $274
line 184
;184:			trap_Cvar_Set ("cg_viewsize","100");
ADDRGP4 $272
ARGP4
ADDRGP4 $277
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 185
;185:			size = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 186
;186:		} else {
ADDRGP4 $275
JUMPV
LABELV $274
line 187
;187:			size = cg_viewsize.integer;
ADDRLP4 0
ADDRGP4 cg_viewsize+12
INDIRI4
ASGNI4
line 188
;188:		}
LABELV $275
LABELV $270
line 190
;189:
;190:	}
LABELV $267
line 191
;191:	cg.refdef.width = cgs.glconfig.vidWidth*size/100;
ADDRGP4 cg+3604+8
ADDRGP4 cgs+21604+11304
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 192
;192:	cg.refdef.width &= ~1;
ADDRLP4 4
ADDRGP4 cg+3604+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 194
;193:
;194:	cg.refdef.height = cgs.glconfig.vidHeight*size/100;
ADDRGP4 cg+3604+12
ADDRGP4 cgs+21604+11308
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 195
;195:	cg.refdef.height &= ~1;
ADDRLP4 8
ADDRGP4 cg+3604+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 197
;196:
;197:	cg.refdef.x = (cgs.glconfig.vidWidth - cg.refdef.width)/2;
ADDRGP4 cg+3604
ADDRGP4 cgs+21604+11304
INDIRI4
ADDRGP4 cg+3604+8
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 198
;198:	cg.refdef.y = (cgs.glconfig.vidHeight - cg.refdef.height)/2;
ADDRGP4 cg+3604+4
ADDRGP4 cgs+21604+11308
INDIRI4
ADDRGP4 cg+3604+12
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 199
;199:}
LABELV $265
endproc CG_CalcVrect 12 8
proc CG_StepOffset 8 0
line 206
;200:
;201://==============================================================================
;202:
;203://==============================================================================
;204://==============================================================================
;205:// this causes a compiler bug on mac MrC compiler
;206:static void CG_StepOffset( void ) {
line 210
;207:	int		timeDelta;
;208:	
;209:	// smooth out stair climbing
;210:	timeDelta = cg.time - cg.stepTime;
ADDRLP4 0
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+3476
INDIRI4
SUBI4
ASGNI4
line 211
;211:	if ( timeDelta < STEP_TIME ) {
ADDRLP4 0
INDIRI4
CNSTI4 200
GEI4 $305
line 212
;212:		cg.refdef.vieworg[2] -= cg.stepChange 
ADDRLP4 4
ADDRGP4 cg+3604+24+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+3472
INDIRF4
CNSTI4 200
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 214
;213:			* (STEP_TIME - timeDelta) / STEP_TIME;
;214:	}
LABELV $305
line 215
;215:}
LABELV $302
endproc CG_StepOffset 8 0
data
align 4
LABELV cameramins
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV cameramaxs
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
export cameraCurTarget
align 4
LABELV cameraCurTarget
byte 4 0
byte 4 0
byte 4 0
export cameraCurLoc
align 4
LABELV cameraCurLoc
byte 4 0
byte 4 0
byte 4 0
export cameraOldLoc
align 4
LABELV cameraOldLoc
byte 4 0
byte 4 0
byte 4 0
export cameraNewLoc
align 4
LABELV cameraNewLoc
byte 4 0
byte 4 0
byte 4 0
export cameraLastFrame
align 4
LABELV cameraLastFrame
byte 4 0
export cameraLastYaw
align 4
LABELV cameraLastYaw
byte 4 0
export cameraStiffFactor
align 4
LABELV cameraStiffFactor
byte 4 0
code
proc CG_CalcIdealThirdPersonViewTarget 12 0
line 256
;216:
;217:#define CAMERA_DAMP_INTERVAL	50
;218:
;219:static vec3_t	cameramins = { -CAMERA_SIZE, -CAMERA_SIZE, -CAMERA_SIZE };
;220:static vec3_t	cameramaxs = { CAMERA_SIZE, CAMERA_SIZE, CAMERA_SIZE };
;221:vec3_t	camerafwd, cameraup;
;222:
;223:vec3_t	cameraFocusAngles,			cameraFocusLoc;
;224:vec3_t	cameraIdealTarget,			cameraIdealLoc;
;225:vec3_t	cameraCurTarget={0,0,0},	cameraCurLoc={0,0,0};
;226:vec3_t	cameraOldLoc={0,0,0},		cameraNewLoc={0,0,0};
;227:int		cameraLastFrame=0;
;228:
;229:float	cameraLastYaw=0;
;230:float	cameraStiffFactor=0.0f;
;231:
;232:/*
;233:===============
;234:Notes on the camera viewpoint in and out...
;235:
;236:cg.refdef.vieworg
;237:--at the start of the function holds the player actor's origin (center of player model).
;238:--it is set to the final view location of the camera at the end of the camera code.
;239:cg.refdefViewAngles
;240:--at the start holds the client's view angles
;241:--it is set to the final view angle of the camera at the end of the camera code.
;242:
;243:===============
;244:*/
;245:  
;246:extern qboolean gCGHasFallVector;
;247:extern vec3_t gCGFallVector;
;248:
;249:/*
;250:===============
;251:CG_CalcTargetThirdPersonViewLocation
;252:
;253:===============
;254:*/
;255:static void CG_CalcIdealThirdPersonViewTarget(void)
;256:{
line 257
;257:	float thirdPersonVertOffset = cg_thirdPersonVertOffset.value;
ADDRLP4 0
ADDRGP4 cg_thirdPersonVertOffset+8
INDIRF4
ASGNF4
line 259
;258:
;259:	if (cg.snap && cg.snap->ps.usingATST)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $313
ADDRGP4 cg+36
INDIRP4
CNSTI4 1348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $313
line 260
;260:	{
line 261
;261:		thirdPersonVertOffset = 200;
ADDRLP4 0
CNSTF4 1128792064
ASGNF4
line 262
;262:	}
LABELV $313
line 265
;263:
;264:	// Initialize IdealTarget
;265:	if (gCGHasFallVector)
ADDRGP4 gCGHasFallVector
INDIRI4
CNSTI4 0
EQI4 $317
line 266
;266:	{
line 267
;267:		VectorCopy(gCGFallVector, cameraFocusLoc);
ADDRGP4 cameraFocusLoc
ADDRGP4 gCGFallVector
INDIRB
ASGNB 12
line 268
;268:	}
ADDRGP4 $318
JUMPV
LABELV $317
line 270
;269:	else
;270:	{
line 271
;271:		VectorCopy(cg.refdef.vieworg, cameraFocusLoc);
ADDRGP4 cameraFocusLoc
ADDRGP4 cg+3604+24
INDIRB
ASGNB 12
line 272
;272:	}
LABELV $318
line 275
;273:
;274:	// Add in the new viewheight
;275:	cameraFocusLoc[2] += cg.snap->ps.viewheight;
ADDRLP4 4
ADDRGP4 cameraFocusLoc+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 281
;276:
;277:	// Add in a vertical offset from the viewpoint, which puts the actual target above the head, regardless of angle.
;278://	VectorMA(cameraFocusLoc, thirdPersonVertOffset, cameraup, cameraIdealTarget);
;279:	
;280:	// Add in a vertical offset from the viewpoint, which puts the actual target above the head, regardless of angle.
;281:	VectorCopy( cameraFocusLoc, cameraIdealTarget );
ADDRGP4 cameraIdealTarget
ADDRGP4 cameraFocusLoc
INDIRB
ASGNB 12
line 282
;282:	cameraIdealTarget[2] += cg_thirdPersonVertOffset.value;
ADDRLP4 8
ADDRGP4 cameraIdealTarget+8
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 cg_thirdPersonVertOffset+8
INDIRF4
ADDF4
ASGNF4
line 284
;283:	//VectorMA(cameraFocusLoc, cg_thirdPersonVertOffset.value, cameraup, cameraIdealTarget);
;284:}
LABELV $311
endproc CG_CalcIdealThirdPersonViewTarget 12 0
proc CG_CalcIdealThirdPersonViewLocation 8 0
line 295
;285:
;286:	
;287:
;288:/*
;289:===============
;290:CG_CalcTargetThirdPersonViewLocation
;291:
;292:===============
;293:*/
;294:static void CG_CalcIdealThirdPersonViewLocation(void)
;295:{
line 296
;296:	float thirdPersonRange = cg_thirdPersonRange.value;
ADDRLP4 0
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
ASGNF4
line 298
;297:
;298:	if (cg.snap && cg.snap->ps.usingATST)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $327
ADDRGP4 cg+36
INDIRP4
CNSTI4 1348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $327
line 299
;299:	{
line 300
;300:		thirdPersonRange = 300;
ADDRLP4 0
CNSTF4 1133903872
ASGNF4
line 301
;301:	}
LABELV $327
line 303
;302:
;303:	VectorMA(cameraIdealTarget, -(thirdPersonRange), camerafwd, cameraIdealLoc);
ADDRLP4 4
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRGP4 cameraIdealLoc
ADDRGP4 cameraIdealTarget
INDIRF4
ADDRGP4 camerafwd
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cameraIdealLoc+4
ADDRGP4 cameraIdealTarget+4
INDIRF4
ADDRGP4 camerafwd+4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cameraIdealLoc+8
ADDRGP4 cameraIdealTarget+8
INDIRF4
ADDRGP4 camerafwd+8
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 304
;304:}
LABELV $325
endproc CG_CalcIdealThirdPersonViewLocation 8 0
proc CG_ResetThirdPersonViewDamp 1080 28
line 309
;305:
;306:
;307:
;308:static void CG_ResetThirdPersonViewDamp(void)
;309:{
line 313
;310:	trace_t trace;
;311:
;312:	// Cap the pitch within reasonable limits
;313:	if (cameraFocusAngles[PITCH] > 89.0)
ADDRGP4 cameraFocusAngles
INDIRF4
CNSTF4 1118961664
LEF4 $338
line 314
;314:	{
line 315
;315:		cameraFocusAngles[PITCH] = 89.0;
ADDRGP4 cameraFocusAngles
CNSTF4 1118961664
ASGNF4
line 316
;316:	}
ADDRGP4 $339
JUMPV
LABELV $338
line 317
;317:	else if (cameraFocusAngles[PITCH] < -89.0)
ADDRGP4 cameraFocusAngles
INDIRF4
CNSTF4 3266445312
GEF4 $340
line 318
;318:	{
line 319
;319:		cameraFocusAngles[PITCH] = -89.0;
ADDRGP4 cameraFocusAngles
CNSTF4 3266445312
ASGNF4
line 320
;320:	}
LABELV $340
LABELV $339
line 322
;321:
;322:	AngleVectors(cameraFocusAngles, camerafwd, NULL, cameraup);
ADDRGP4 cameraFocusAngles
ARGP4
ADDRGP4 camerafwd
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 cameraup
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 325
;323:
;324:	// Set the cameraIdealTarget
;325:	CG_CalcIdealThirdPersonViewTarget();
ADDRGP4 CG_CalcIdealThirdPersonViewTarget
CALLV
pop
line 328
;326:
;327:	// Set the cameraIdealLoc
;328:	CG_CalcIdealThirdPersonViewLocation();
ADDRGP4 CG_CalcIdealThirdPersonViewLocation
CALLV
pop
line 331
;329:
;330:	// Now, we just set everything to the new positions.
;331:	VectorCopy(cameraIdealLoc, cameraCurLoc);
ADDRGP4 cameraCurLoc
ADDRGP4 cameraIdealLoc
INDIRB
ASGNB 12
line 332
;332:	VectorCopy(cameraIdealTarget, cameraCurTarget);
ADDRGP4 cameraCurTarget
ADDRGP4 cameraIdealTarget
INDIRB
ASGNB 12
line 335
;333:
;334:	// First thing we do is trace from the first person viewpoint out to the new target location.
;335:	CG_Trace(&trace, cameraFocusLoc, cameramins, cameramaxs, cameraCurTarget, cg.snap->ps.clientNum, MASK_CAMERACLIP);
ADDRLP4 0
ARGP4
ADDRGP4 cameraFocusLoc
ARGP4
ADDRGP4 cameramins
ARGP4
ADDRGP4 cameramaxs
ARGP4
ADDRGP4 cameraCurTarget
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 336
;336:	if (trace.fraction <= 1.0)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GTF4 $343
line 337
;337:	{
line 338
;338:		VectorCopy(trace.endpos, cameraCurTarget);
ADDRGP4 cameraCurTarget
ADDRLP4 0+12
INDIRB
ASGNB 12
line 339
;339:	}
LABELV $343
line 342
;340:
;341:	// Now we trace from the new target location to the new view location, to make sure there is nothing in the way.
;342:	CG_Trace(&trace, cameraCurTarget, cameramins, cameramaxs, cameraCurLoc, cg.snap->ps.clientNum, MASK_CAMERACLIP);
ADDRLP4 0
ARGP4
ADDRGP4 cameraCurTarget
ARGP4
ADDRGP4 cameramins
ARGP4
ADDRGP4 cameramaxs
ARGP4
ADDRGP4 cameraCurLoc
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 343
;343:	if (trace.fraction <= 1.0)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GTF4 $348
line 344
;344:	{
line 345
;345:		VectorCopy(trace.endpos, cameraCurLoc);
ADDRGP4 cameraCurLoc
ADDRLP4 0+12
INDIRB
ASGNB 12
line 346
;346:	}
LABELV $348
line 348
;347:
;348:	cameraLastFrame = cg.time;
ADDRGP4 cameraLastFrame
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 349
;349:	cameraLastYaw = cameraFocusAngles[YAW];
ADDRGP4 cameraLastYaw
ADDRGP4 cameraFocusAngles+4
INDIRF4
ASGNF4
line 350
;350:	cameraStiffFactor = 0.0f;
ADDRGP4 cameraStiffFactor
CNSTF4 0
ASGNF4
line 351
;351:}
LABELV $337
endproc CG_ResetThirdPersonViewDamp 1080 28
proc CG_UpdateThirdPersonTargetDamp 1112 28
line 355
;352:
;353:// This is called every frame.
;354:static void CG_UpdateThirdPersonTargetDamp(void)
;355:{
line 362
;356:	trace_t trace;
;357:	vec3_t	targetdiff;
;358:	float	dampfactor, dtime, ratio;
;359:
;360:	// Set the cameraIdealTarget
;361:	// Automatically get the ideal target, to avoid jittering.
;362:	CG_CalcIdealThirdPersonViewTarget();
ADDRGP4 CG_CalcIdealThirdPersonViewTarget
CALLV
pop
line 364
;363:
;364:	if (cg_thirdPersonTargetDamp.value>=1.0)
ADDRGP4 cg_thirdPersonTargetDamp+8
INDIRF4
CNSTF4 1065353216
LTF4 $355
line 365
;365:	{	// No damping.
line 366
;366:		VectorCopy(cameraIdealTarget, cameraCurTarget);
ADDRGP4 cameraCurTarget
ADDRGP4 cameraIdealTarget
INDIRB
ASGNB 12
line 367
;367:	}
ADDRGP4 $356
JUMPV
LABELV $355
line 368
;368:	else if (cg_thirdPersonTargetDamp.value>=0.0)
ADDRGP4 cg_thirdPersonTargetDamp+8
INDIRF4
CNSTF4 0
LTF4 $358
line 369
;369:	{	
line 371
;370:		// Calculate the difference from the current position to the new one.
;371:		VectorSubtract(cameraIdealTarget, cameraCurTarget, targetdiff);
ADDRLP4 1080
ADDRGP4 cameraIdealTarget
INDIRF4
ADDRGP4 cameraCurTarget
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1080+4
ADDRGP4 cameraIdealTarget+4
INDIRF4
ADDRGP4 cameraCurTarget+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1080+8
ADDRGP4 cameraIdealTarget+8
INDIRF4
ADDRGP4 cameraCurTarget+8
INDIRF4
SUBF4
ASGNF4
line 375
;372:
;373:		// Now we calculate how much of the difference we cover in the time allotted.
;374:		// The equation is (Damp)^(time)
;375:		dampfactor = 1.0-cg_thirdPersonTargetDamp.value;	// We must exponent the amount LEFT rather than the amount bled off
ADDRLP4 1096
CNSTF4 1065353216
ADDRGP4 cg_thirdPersonTargetDamp+8
INDIRF4
SUBF4
ASGNF4
line 376
;376:		dtime = (float)(cg.time-cameraLastFrame) * (1.0/(float)CAMERA_DAMP_INTERVAL);	// Our dampfactor is geared towards a time interval equal to "1".
ADDRLP4 1100
CNSTF4 1017370378
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cameraLastFrame
INDIRI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 380
;377:
;378:		// Note that since there are a finite number of "practical" delta millisecond values possible, 
;379:		// the ratio should be initialized into a chart ultimately.
;380:		ratio = powf(dampfactor, dtime);
ADDRLP4 1096
INDIRF4
ARGF4
ADDRLP4 1100
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 1104
ADDRGP4 powf
CALLF4
ASGNF4
ADDRLP4 1092
ADDRLP4 1104
INDIRF4
ASGNF4
line 383
;381:		
;382:		// This value is how much distance is "left" from the ideal.
;383:		VectorMA(cameraIdealTarget, -ratio, targetdiff, cameraCurTarget);
ADDRLP4 1108
ADDRLP4 1092
INDIRF4
NEGF4
ASGNF4
ADDRGP4 cameraCurTarget
ADDRGP4 cameraIdealTarget
INDIRF4
ADDRLP4 1080
INDIRF4
ADDRLP4 1108
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cameraCurTarget+4
ADDRGP4 cameraIdealTarget+4
INDIRF4
ADDRLP4 1080+4
INDIRF4
ADDRLP4 1108
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cameraCurTarget+8
ADDRGP4 cameraIdealTarget+8
INDIRF4
ADDRLP4 1080+8
INDIRF4
ADDRLP4 1092
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 385
;384:		/////////////////////////////////////////////////////////////////////////////////////////////////////////
;385:	}
LABELV $358
LABELV $356
line 390
;386:
;387:	// Now we trace to see if the new location is cool or not.
;388:
;389:	// First thing we do is trace from the first person viewpoint out to the new target location.
;390:	CG_Trace(&trace, cameraFocusLoc, cameramins, cameramaxs, cameraCurTarget, cg.snap->ps.clientNum, MASK_CAMERACLIP);
ADDRLP4 0
ARGP4
ADDRGP4 cameraFocusLoc
ARGP4
ADDRGP4 cameramins
ARGP4
ADDRGP4 cameramaxs
ARGP4
ADDRGP4 cameraCurTarget
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 391
;391:	if (trace.fraction < 1.0)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $376
line 392
;392:	{
line 393
;393:		VectorCopy(trace.endpos, cameraCurTarget);
ADDRGP4 cameraCurTarget
ADDRLP4 0+12
INDIRB
ASGNB 12
line 394
;394:	}
LABELV $376
line 400
;395:
;396:	// Note that previously there was an upper limit to the number of physics traces that are done through the world
;397:	// for the sake of camera collision, since it wasn't calced per frame.  Now it is calculated every frame.
;398:	// This has the benefit that the camera is a lot smoother now (before it lerped between tested points),
;399:	// however two full volume traces each frame is a bit scary to think about.
;400:}
LABELV $354
endproc CG_UpdateThirdPersonTargetDamp 1112 28
proc CG_UpdateThirdPersonCameraDamp 1120 28
line 404
;401:
;402:// This can be called every interval, at the user's discretion.
;403:static void CG_UpdateThirdPersonCameraDamp(void)
;404:{
line 410
;405:	trace_t trace;
;406:	vec3_t	locdiff;
;407:	float dampfactor, dtime, ratio;
;408:
;409:	// Set the cameraIdealLoc
;410:	CG_CalcIdealThirdPersonViewLocation();
ADDRGP4 CG_CalcIdealThirdPersonViewLocation
CALLV
pop
line 414
;411:	
;412:	
;413:	// First thing we do is calculate the appropriate damping factor for the camera.
;414:	dampfactor=0.0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 415
;415:	if (cg_thirdPersonCameraDamp.value != 0.0)
ADDRGP4 cg_thirdPersonCameraDamp+8
INDIRF4
CNSTF4 0
EQF4 $381
line 416
;416:	{
line 420
;417:		double pitch;
;418:
;419:		// Note that the camera pitch has already been capped off to 89.
;420:		pitch = Q_fabs(cameraFocusAngles[PITCH]);
ADDRGP4 cameraFocusAngles
INDIRF4
ARGF4
ADDRLP4 1108
ADDRGP4 Q_fabs
CALLF4
ASGNF4
ADDRLP4 1104
ADDRLP4 1108
INDIRF4
ASGNF4
line 423
;421:
;422:		// The higher the pitch, the larger the factor, so as you look up, it damps a lot less.
;423:		pitch /= 89.0;	
ADDRLP4 1104
ADDRLP4 1104
INDIRF4
CNSTF4 1118961664
DIVF4
ASGNF4
line 424
;424:		dampfactor = (1.0-cg_thirdPersonCameraDamp.value)*(pitch*pitch);
ADDRLP4 1112
ADDRLP4 1104
INDIRF4
ASGNF4
ADDRLP4 0
CNSTF4 1065353216
ADDRGP4 cg_thirdPersonCameraDamp+8
INDIRF4
SUBF4
ADDRLP4 1112
INDIRF4
ADDRLP4 1112
INDIRF4
MULF4
MULF4
ASGNF4
line 426
;425:
;426:		dampfactor += cg_thirdPersonCameraDamp.value;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 cg_thirdPersonCameraDamp+8
INDIRF4
ADDF4
ASGNF4
line 429
;427:
;428:		// Now we also multiply in the stiff factor, so that faster yaw changes are stiffer.
;429:		if (cameraStiffFactor > 0.0f)
ADDRGP4 cameraStiffFactor
INDIRF4
CNSTF4 0
LEF4 $386
line 430
;430:		{	// The cameraStiffFactor is how much of the remaining damp below 1 should be shaved off, i.e. approach 1 as stiffening increases.
line 431
;431:			dampfactor += (1.0-dampfactor)*cameraStiffFactor;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
SUBF4
ADDRGP4 cameraStiffFactor
INDIRF4
MULF4
ADDF4
ASGNF4
line 432
;432:		}
LABELV $386
line 433
;433:	}
LABELV $381
line 435
;434:
;435:	if (dampfactor>=1.0)
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
LTF4 $388
line 436
;436:	{	// No damping.
line 437
;437:		VectorCopy(cameraIdealLoc, cameraCurLoc);
ADDRGP4 cameraCurLoc
ADDRGP4 cameraIdealLoc
INDIRB
ASGNB 12
line 438
;438:	}
ADDRGP4 $389
JUMPV
LABELV $388
line 439
;439:	else if (dampfactor>=0.0)
ADDRLP4 0
INDIRF4
CNSTF4 0
LTF4 $390
line 440
;440:	{	
line 442
;441:		// Calculate the difference from the current position to the new one.
;442:		VectorSubtract(cameraIdealLoc, cameraCurLoc, locdiff);
ADDRLP4 1084
ADDRGP4 cameraIdealLoc
INDIRF4
ADDRGP4 cameraCurLoc
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1084+4
ADDRGP4 cameraIdealLoc+4
INDIRF4
ADDRGP4 cameraCurLoc+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1084+8
ADDRGP4 cameraIdealLoc+8
INDIRF4
ADDRGP4 cameraCurLoc+8
INDIRF4
SUBF4
ASGNF4
line 446
;443:
;444:		// Now we calculate how much of the difference we cover in the time allotted.
;445:		// The equation is (Damp)^(time)
;446:		dampfactor = 1.0-dampfactor;	// We must exponent the amount LEFT rather than the amount bled off
ADDRLP4 0
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 447
;447:		dtime = (float)(cg.time-cameraLastFrame) * (1.0/(float)CAMERA_DAMP_INTERVAL);	// Our dampfactor is geared towards a time interval equal to "1".
ADDRLP4 1100
CNSTF4 1017370378
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cameraLastFrame
INDIRI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 451
;448:
;449:		// Note that since there are a finite number of "practical" delta millisecond values possible, 
;450:		// the ratio should be initialized into a chart ultimately.
;451:		ratio = powf(dampfactor, dtime);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 1100
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 1104
ADDRGP4 powf
CALLF4
ASGNF4
ADDRLP4 1096
ADDRLP4 1104
INDIRF4
ASGNF4
line 454
;452:		
;453:		// This value is how much distance is "left" from the ideal.
;454:		VectorMA(cameraIdealLoc, -ratio, locdiff, cameraCurLoc);
ADDRLP4 1108
ADDRLP4 1096
INDIRF4
NEGF4
ASGNF4
ADDRGP4 cameraCurLoc
ADDRGP4 cameraIdealLoc
INDIRF4
ADDRLP4 1084
INDIRF4
ADDRLP4 1108
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cameraCurLoc+4
ADDRGP4 cameraIdealLoc+4
INDIRF4
ADDRLP4 1084+4
INDIRF4
ADDRLP4 1108
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cameraCurLoc+8
ADDRGP4 cameraIdealLoc+8
INDIRF4
ADDRLP4 1084+8
INDIRF4
ADDRLP4 1096
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 456
;455:		/////////////////////////////////////////////////////////////////////////////////////////////////////////
;456:	}
LABELV $390
LABELV $389
line 459
;457:
;458:	// Now we trace from the new target location to the new view location, to make sure there is nothing in the way.
;459:	CG_Trace(&trace, cameraCurTarget, cameramins, cameramaxs, cameraCurLoc, cg.snap->ps.clientNum, MASK_CAMERACLIP);
ADDRLP4 4
ARGP4
ADDRGP4 cameraCurTarget
ARGP4
ADDRGP4 cameramins
ARGP4
ADDRGP4 cameramaxs
ARGP4
ADDRGP4 cameraCurLoc
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 461
;460:
;461:	if (trace.fraction < 1.0)
ADDRLP4 4+8
INDIRF4
CNSTF4 1065353216
GEF4 $406
line 462
;462:	{
line 463
;463:		VectorCopy( trace.endpos, cameraCurLoc );
ADDRGP4 cameraCurLoc
ADDRLP4 4+12
INDIRB
ASGNB 12
line 483
;464:
;465:		//FIXME: when the trace hits movers, it gets very very jaggy... ?
;466:		/*
;467:		//this doesn't actually help any
;468:		if ( trace.entityNum != ENTITYNUM_WORLD )
;469:		{
;470:			centity_t *cent = &cg_entities[trace.entityNum];
;471:			gentity_t *gent = &g_entities[trace.entityNum];
;472:			if ( cent != NULL && gent != NULL )
;473:			{
;474:				if ( cent->currentState.pos.trType == TR_LINEAR || cent->currentState.pos.trType == TR_LINEAR_STOP )
;475:				{
;476:					vec3_t	diff;
;477:					VectorSubtract( cent->lerpOrigin, gent->currentOrigin, diff );
;478:					VectorAdd( cameraCurLoc, diff, cameraCurLoc );
;479:				}
;480:			}
;481:		}
;482:		*/
;483:	}
LABELV $406
line 489
;484:
;485:	// Note that previously there was an upper limit to the number of physics traces that are done through the world
;486:	// for the sake of camera collision, since it wasn't calced per frame.  Now it is calculated every frame.
;487:	// This has the benefit that the camera is a lot smoother now (before it lerped between tested points),
;488:	// however two full volume traces each frame is a bit scary to think about.
;489:}
LABELV $380
endproc CG_UpdateThirdPersonCameraDamp 1120 28
proc CG_OffsetThirdPersonView 36 16
line 502
;490:
;491:
;492:
;493:
;494:/*
;495:===============`
;496:CG_OffsetThirdPersonView
;497:
;498:===============
;499:*/
;500:extern vmCvar_t cg_thirdPersonHorzOffset;
;501:static void CG_OffsetThirdPersonView( void ) 
;502:{
line 504
;503:	vec3_t diff;
;504:	float thirdPersonHorzOffset = cg_thirdPersonHorzOffset.value;
ADDRLP4 12
ADDRGP4 cg_thirdPersonHorzOffset+8
INDIRF4
ASGNF4
line 507
;505:	float deltayaw;
;506:
;507:	cameraStiffFactor = 0.0;
ADDRGP4 cameraStiffFactor
CNSTF4 0
ASGNF4
line 510
;508:
;509:	// Set camera viewing direction.
;510:	VectorCopy( cg.refdefViewAngles, cameraFocusAngles );
ADDRGP4 cameraFocusAngles
ADDRGP4 cg+3972
INDIRB
ASGNB 12
line 513
;511:
;512:	// if dead, look at killer
;513:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) 
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 0
GTI4 $413
line 514
;514:	{
line 515
;515:		cameraFocusAngles[YAW] = cg.snap->ps.stats[STAT_DEAD_YAW];
ADDRGP4 cameraFocusAngles+4
ADDRGP4 cg+36
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 516
;516:	}
ADDRGP4 $414
JUMPV
LABELV $413
line 518
;517:	else
;518:	{	// Add in the third Person Angle.
line 519
;519:		cameraFocusAngles[YAW] += cg_thirdPersonAngle.value;
ADDRLP4 20
ADDRGP4 cameraFocusAngles+4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
ADDF4
ASGNF4
line 520
;520:		cameraFocusAngles[PITCH] += cg_thirdPersonPitchOffset.value;
ADDRLP4 24
ADDRGP4 cameraFocusAngles
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRGP4 cg_thirdPersonPitchOffset+8
INDIRF4
ADDF4
ASGNF4
line 521
;521:	}
LABELV $414
line 526
;522:
;523:	// The next thing to do is to see if we need to calculate a new camera target location.
;524:
;525:	// If we went back in time for some reason, or if we just started, reset the sample.
;526:	if (cameraLastFrame == 0 || cameraLastFrame > cg.time)
ADDRLP4 20
ADDRGP4 cameraLastFrame
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $424
ADDRLP4 20
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $421
LABELV $424
line 527
;527:	{
line 528
;528:		CG_ResetThirdPersonViewDamp();
ADDRGP4 CG_ResetThirdPersonViewDamp
CALLV
pop
line 529
;529:	}
ADDRGP4 $422
JUMPV
LABELV $421
line 531
;530:	else
;531:	{
line 533
;532:		// Cap the pitch within reasonable limits
;533:		if (cameraFocusAngles[PITCH] > 80.0)
ADDRGP4 cameraFocusAngles
INDIRF4
CNSTF4 1117782016
LEF4 $425
line 534
;534:		{
line 535
;535:			cameraFocusAngles[PITCH] = 80.0;
ADDRGP4 cameraFocusAngles
CNSTF4 1117782016
ASGNF4
line 536
;536:		}
ADDRGP4 $426
JUMPV
LABELV $425
line 537
;537:		else if (cameraFocusAngles[PITCH] < -80.0)
ADDRGP4 cameraFocusAngles
INDIRF4
CNSTF4 3265265664
GEF4 $427
line 538
;538:		{
line 539
;539:			cameraFocusAngles[PITCH] = -80.0;
ADDRGP4 cameraFocusAngles
CNSTF4 3265265664
ASGNF4
line 540
;540:		}
LABELV $427
LABELV $426
line 542
;541:
;542:		AngleVectors(cameraFocusAngles, camerafwd, NULL, cameraup);
ADDRGP4 cameraFocusAngles
ARGP4
ADDRGP4 camerafwd
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 cameraup
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 544
;543:
;544:		deltayaw = fabs(cameraFocusAngles[YAW] - cameraLastYaw);
ADDRGP4 cameraFocusAngles+4
INDIRF4
ADDRGP4 cameraLastYaw
INDIRF4
SUBF4
ARGF4
ADDRLP4 24
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 24
INDIRF4
ASGNF4
line 545
;545:		if (deltayaw > 180.0f)
ADDRLP4 16
INDIRF4
CNSTF4 1127481344
LEF4 $430
line 546
;546:		{ // Normalize this angle so that it is between 0 and 180.
line 547
;547:			deltayaw = fabs(deltayaw - 360.0f);
ADDRLP4 16
INDIRF4
CNSTF4 1135869952
SUBF4
ARGF4
ADDRLP4 28
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 28
INDIRF4
ASGNF4
line 548
;548:		}
LABELV $430
line 549
;549:		cameraStiffFactor = deltayaw / (float)(cg.time-cameraLastFrame);
ADDRGP4 cameraStiffFactor
ADDRLP4 16
INDIRF4
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cameraLastFrame
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 550
;550:		if (cameraStiffFactor < 1.0)
ADDRGP4 cameraStiffFactor
INDIRF4
CNSTF4 1065353216
GEF4 $433
line 551
;551:		{
line 552
;552:			cameraStiffFactor = 0.0;
ADDRGP4 cameraStiffFactor
CNSTF4 0
ASGNF4
line 553
;553:		}
ADDRGP4 $434
JUMPV
LABELV $433
line 554
;554:		else if (cameraStiffFactor > 2.5)
ADDRGP4 cameraStiffFactor
INDIRF4
CNSTF4 1075838976
LEF4 $435
line 555
;555:		{
line 556
;556:			cameraStiffFactor = 0.75;
ADDRGP4 cameraStiffFactor
CNSTF4 1061158912
ASGNF4
line 557
;557:		}
ADDRGP4 $436
JUMPV
LABELV $435
line 559
;558:		else
;559:		{	// 1 to 2 scales from 0.0 to 0.5
line 560
;560:			cameraStiffFactor = (cameraStiffFactor-1.0f)*0.5f;
ADDRLP4 28
ADDRGP4 cameraStiffFactor
ASGNP4
ADDRLP4 28
INDIRP4
CNSTF4 1056964608
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
MULF4
ASGNF4
line 561
;561:		}
LABELV $436
LABELV $434
line 562
;562:		cameraLastYaw = cameraFocusAngles[YAW];
ADDRGP4 cameraLastYaw
ADDRGP4 cameraFocusAngles+4
INDIRF4
ASGNF4
line 565
;563:
;564:		// Move the target to the new location.
;565:		CG_UpdateThirdPersonTargetDamp();
ADDRGP4 CG_UpdateThirdPersonTargetDamp
CALLV
pop
line 566
;566:		CG_UpdateThirdPersonCameraDamp();
ADDRGP4 CG_UpdateThirdPersonCameraDamp
CALLV
pop
line 567
;567:	}
LABELV $422
line 576
;568:
;569:	// Now interestingly, the Quake method is to calculate a target focus point above the player, and point the camera at it.
;570:	// We won't do that for now.
;571:
;572:	// We must now take the angle taken from the camera target and location.
;573:	/*VectorSubtract(cameraCurTarget, cameraCurLoc, diff);
;574:	VectorNormalize(diff);
;575:	vectoangles(diff, cg.refdefViewAngles);*/
;576:	VectorSubtract(cameraCurTarget, cameraCurLoc, diff);
ADDRLP4 0
ADDRGP4 cameraCurTarget
INDIRF4
ADDRGP4 cameraCurLoc
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 cameraCurTarget+4
INDIRF4
ADDRGP4 cameraCurLoc+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 cameraCurTarget+8
INDIRF4
ADDRGP4 cameraCurLoc+8
INDIRF4
SUBF4
ASGNF4
line 577
;577:	{
line 578
;578:		float dist = VectorNormalize(diff);
ADDRLP4 0
ARGP4
ADDRLP4 28
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 28
INDIRF4
ASGNF4
line 580
;579:		//under normal circumstances, should never be 0.00000 and so on.
;580:		if ( !dist || (diff[0] == 0 || diff[1] == 0) )
ADDRLP4 32
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRF4
ADDRLP4 32
INDIRF4
EQF4 $448
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRF4
EQF4 $448
ADDRLP4 0+4
INDIRF4
ADDRLP4 32
INDIRF4
NEF4 $444
LABELV $448
line 581
;581:		{//must be hitting something, need some value to calc angles, so use cam forward
line 582
;582:			VectorCopy( camerafwd, diff );
ADDRLP4 0
ADDRGP4 camerafwd
INDIRB
ASGNB 12
line 583
;583:		}
LABELV $444
line 584
;584:	}
line 585
;585:	vectoangles(diff, cg.refdefViewAngles);
ADDRLP4 0
ARGP4
ADDRGP4 cg+3972
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 588
;586:
;587:	// Temp: just move the camera to the side a bit
;588:	if ( thirdPersonHorzOffset != 0.0f )
ADDRLP4 12
INDIRF4
CNSTF4 0
EQF4 $450
line 589
;589:	{
line 590
;590:		AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
ADDRGP4 cg+3972
ARGP4
ADDRGP4 cg+3604+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 591
;591:		VectorMA( cameraCurLoc, thirdPersonHorzOffset, cg.refdef.viewaxis[1], cameraCurLoc );
ADDRLP4 24
ADDRGP4 cameraCurLoc
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRGP4 cg+3604+36+12
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cameraCurLoc+4
ADDRGP4 cameraCurLoc+4
INDIRF4
ADDRGP4 cg+3604+36+12+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cameraCurLoc+8
ADDRGP4 cameraCurLoc+8
INDIRF4
ADDRGP4 cg+3604+36+12+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 592
;592:	}
LABELV $450
line 595
;593:
;594:	// ...and of course we should copy the new view location to the proper spot too.
;595:	VectorCopy(cameraCurLoc, cg.refdef.vieworg);
ADDRGP4 cg+3604+24
ADDRGP4 cameraCurLoc
INDIRB
ASGNB 12
line 597
;596:
;597:	cameraLastFrame=cg.time;
ADDRGP4 cameraLastFrame
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 598
;598:}
LABELV $410
endproc CG_OffsetThirdPersonView 36 16
proc CG_OffsetFirstPersonView 96 0
line 699
;599:
;600:
;601:
;602:/*
;603:===============
;604:CG_OffsetThirdPersonView
;605:
;606:===============
;607:*//*
;608:#define	FOCUS_DISTANCE	512
;609:static void CG_OffsetThirdPersonView( void ) {
;610:	vec3_t		forward, right, up;
;611:	vec3_t		view;
;612:	vec3_t		focusAngles;
;613:	trace_t		trace;
;614:	static vec3_t	mins = { -4, -4, -4 };
;615:	static vec3_t	maxs = { 4, 4, 4 };
;616:	vec3_t		focusPoint;
;617:	float		focusDist;
;618:	float		forwardScale, sideScale;
;619:
;620:	cg.refdef.vieworg[2] += cg.predictedPlayerState.viewheight;
;621:
;622:	VectorCopy( cg.refdefViewAngles, focusAngles );
;623:
;624:	// if dead, look at killer
;625:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
;626:		focusAngles[YAW] = cg.predictedPlayerState.stats[STAT_DEAD_YAW];
;627:		cg.refdefViewAngles[YAW] = cg.predictedPlayerState.stats[STAT_DEAD_YAW];
;628:	}
;629:
;630:	if ( focusAngles[PITCH] > 45 ) {
;631:		focusAngles[PITCH] = 45;		// don't go too far overhead
;632:	}
;633:	AngleVectors( focusAngles, forward, NULL, NULL );
;634:
;635:	VectorMA( cg.refdef.vieworg, FOCUS_DISTANCE, forward, focusPoint );
;636:
;637:	VectorCopy( cg.refdef.vieworg, view );
;638:
;639:	view[2] += 8;
;640:
;641:	cg.refdefViewAngles[PITCH] *= 0.5;
;642:
;643:	AngleVectors( cg.refdefViewAngles, forward, right, up );
;644:
;645:	forwardScale = cos( cg_thirdPersonAngle.value / 180 * M_PI );
;646:	sideScale = sin( cg_thirdPersonAngle.value / 180 * M_PI );
;647:	VectorMA( view, -cg_thirdPersonRange.value * forwardScale, forward, view );
;648:	VectorMA( view, -cg_thirdPersonRange.value * sideScale, right, view );
;649:
;650:	// trace a ray from the origin to the viewpoint to make sure the view isn't
;651:	// in a solid block.  Use an 8 by 8 block to prevent the view from near clipping anything
;652:
;653:	if (!cg_cameraMode.integer) {
;654:		CG_Trace( &trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_CAMERACLIP);
;655:
;656:		if ( trace.fraction != 1.0 ) {
;657:			VectorCopy( trace.endpos, view );
;658:			view[2] += (1.0 - trace.fraction) * 32;
;659:			// try another trace to this position, because a tunnel may have the ceiling
;660:			// close enogh that this is poking out
;661:
;662:			CG_Trace( &trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_CAMERACLIP);
;663:			VectorCopy( trace.endpos, view );
;664:		}
;665:	}
;666:
;667:
;668:	VectorCopy( view, cg.refdef.vieworg );
;669:
;670:	// select pitch to look at focus point from vieword
;671:	VectorSubtract( focusPoint, cg.refdef.vieworg, focusPoint );
;672:	focusDist = sqrt( focusPoint[0] * focusPoint[0] + focusPoint[1] * focusPoint[1] );
;673:	if ( focusDist < 1 ) {
;674:		focusDist = 1;	// should never happen
;675:	}
;676:	cg.refdefViewAngles[PITCH] = -180 / M_PI * atan2( focusPoint[2], focusDist );
;677:	cg.refdefViewAngles[YAW] -= cg_thirdPersonAngle.value;
;678:}
;679:
;680:
;681:// this causes a compiler bug on mac MrC compiler
;682:static void CG_StepOffset( void ) {
;683:	int		timeDelta;
;684:	
;685:	// smooth out stair climbing
;686:	timeDelta = cg.time - cg.stepTime;
;687:	if ( timeDelta < STEP_TIME ) {
;688:		cg.refdef.vieworg[2] -= cg.stepChange 
;689:			* (STEP_TIME - timeDelta) / STEP_TIME;
;690:	}
;691:}*/
;692:
;693:/*
;694:===============
;695:CG_OffsetFirstPersonView
;696:
;697:===============
;698:*/
;699:static void CG_OffsetFirstPersonView( void ) {
line 710
;700:	float			*origin;
;701:	float			*angles;
;702:	float			bob;
;703:	float			ratio;
;704:	float			delta;
;705:	float			speed;
;706:	float			f;
;707:	vec3_t			predictedVelocity;
;708:	int				timeDelta;
;709:	
;710:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 6
NEI4 $474
line 711
;711:		return;
ADDRGP4 $473
JUMPV
LABELV $474
line 714
;712:	}
;713:
;714:	origin = cg.refdef.vieworg;
ADDRLP4 8
ADDRGP4 cg+3604+24
ASGNP4
line 715
;715:	angles = cg.refdefViewAngles;
ADDRLP4 4
ADDRGP4 cg+3972
ASGNP4
line 718
;716:
;717:	// if dead, fix the angle and don't add any kick
;718:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 0
GTI4 $480
line 719
;719:		angles[ROLL] = 40;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1109393408
ASGNF4
line 720
;720:		angles[PITCH] = -15;
ADDRLP4 4
INDIRP4
CNSTF4 3245342720
ASGNF4
line 721
;721:		angles[YAW] = cg.snap->ps.stats[STAT_DEAD_YAW];
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 722
;722:		origin[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 44
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRGP4 cg+96+168
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 723
;723:		return;
ADDRGP4 $473
JUMPV
LABELV $480
line 727
;724:	}
;725:
;726:	// add angles based on weapon kick
;727:	VectorAdd (angles, cg.kick_angles, angles);
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+13428
INDIRF4
ADDF4
ASGNF4
ADDRLP4 48
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRGP4 cg+13428+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 52
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRGP4 cg+13428+8
INDIRF4
ADDF4
ASGNF4
line 730
;728:
;729:	// add angles based on damage kick
;730:	if ( cg.damageTime ) {
ADDRGP4 cg+13372
INDIRF4
CNSTF4 0
EQF4 $491
line 731
;731:		ratio = cg.time - cg.damageTime;
ADDRLP4 32
ADDRGP4 cg+64
INDIRI4
CVIF4 4
ADDRGP4 cg+13372
INDIRF4
SUBF4
ASGNF4
line 732
;732:		if ( ratio < DAMAGE_DEFLECT_TIME ) {
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $496
line 733
;733:			ratio /= DAMAGE_DEFLECT_TIME;
ADDRLP4 32
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
DIVF4
ASGNF4
line 734
;734:			angles[PITCH] += ratio * cg.v_dmg_pitch;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+13420
INDIRF4
MULF4
ADDF4
ASGNF4
line 735
;735:			angles[ROLL] += ratio * cg.v_dmg_roll;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+13424
INDIRF4
MULF4
ADDF4
ASGNF4
line 736
;736:		} else {
ADDRGP4 $497
JUMPV
LABELV $496
line 737
;737:			ratio = 1.0 - ( ratio - DAMAGE_DEFLECT_TIME ) / DAMAGE_RETURN_TIME;
ADDRLP4 32
CNSTF4 1065353216
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
SUBF4
CNSTF4 1137180672
DIVF4
SUBF4
ASGNF4
line 738
;738:			if ( ratio > 0 ) {
ADDRLP4 32
INDIRF4
CNSTF4 0
LEF4 $500
line 739
;739:				angles[PITCH] += ratio * cg.v_dmg_pitch;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+13420
INDIRF4
MULF4
ADDF4
ASGNF4
line 740
;740:				angles[ROLL] += ratio * cg.v_dmg_roll;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+13424
INDIRF4
MULF4
ADDF4
ASGNF4
line 741
;741:			}
LABELV $500
line 742
;742:		}
LABELV $497
line 743
;743:	}
LABELV $491
line 754
;744:
;745:	// add pitch based on fall kick
;746:#if 0
;747:	ratio = ( cg.time - cg.landTime) / FALL_TIME;
;748:	if (ratio < 0)
;749:		ratio = 0;
;750:	angles[PITCH] += ratio * cg.fall_value;
;751:#endif
;752:
;753:	// add angles based on velocity
;754:	VectorCopy( cg.predictedPlayerState.velocity, predictedVelocity );
ADDRLP4 12
ADDRGP4 cg+96+32
INDIRB
ASGNB 12
line 756
;755:
;756:	delta = DotProduct ( predictedVelocity, cg.refdef.viewaxis[0]);
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRGP4 cg+3604+36
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+3604+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+3604+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 757
;757:	angles[PITCH] += delta * cg_runpitch.value;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRGP4 cg_runpitch+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 759
;758:	
;759:	delta = DotProduct ( predictedVelocity, cg.refdef.viewaxis[1]);
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRGP4 cg+3604+36+12
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+3604+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+3604+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 760
;760:	angles[ROLL] -= delta * cg_runroll.value;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRGP4 cg_runroll+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 765
;761:
;762:	// add angles based on bob
;763:
;764:	// make sure the bob is visible even at low speeds
;765:	speed = cg.xyspeed > 200 ? cg.xyspeed : 200;
ADDRGP4 cg+13460
INDIRF4
CNSTF4 1128792064
LEF4 $534
ADDRLP4 64
ADDRGP4 cg+13460
INDIRF4
ASGNF4
ADDRGP4 $535
JUMPV
LABELV $534
ADDRLP4 64
CNSTF4 1128792064
ASGNF4
LABELV $535
ADDRLP4 28
ADDRLP4 64
INDIRF4
ASGNF4
line 767
;766:
;767:	delta = cg.bobfracsin * cg_bobpitch.value * speed;
ADDRLP4 0
ADDRGP4 cg+13452
INDIRF4
ADDRGP4 cg_bobpitch+8
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 768
;768:	if (cg.predictedPlayerState.pm_flags & PMF_DUCKED)
ADDRGP4 cg+96+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $538
line 769
;769:		delta *= 3;		// crouching
ADDRLP4 0
CNSTF4 1077936128
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
LABELV $538
line 770
;770:	angles[PITCH] += delta;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 771
;771:	delta = cg.bobfracsin * cg_bobroll.value * speed;
ADDRLP4 0
ADDRGP4 cg+13452
INDIRF4
ADDRGP4 cg_bobroll+8
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 772
;772:	if (cg.predictedPlayerState.pm_flags & PMF_DUCKED)
ADDRGP4 cg+96+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $544
line 773
;773:		delta *= 3;		// crouching accentuates roll
ADDRLP4 0
CNSTF4 1077936128
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
LABELV $544
line 774
;774:	if (cg.bobcycle & 1)
ADDRGP4 cg+13456
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $548
line 775
;775:		delta = -delta;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
LABELV $548
line 776
;776:	angles[ROLL] += delta;
ADDRLP4 72
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 781
;777:
;778://===================================
;779:
;780:	// add view height
;781:	origin[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 76
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRGP4 cg+96+168
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 784
;782:
;783:	// smooth out duck height changes
;784:	timeDelta = cg.time - cg.duckTime;
ADDRLP4 36
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+3484
INDIRI4
SUBI4
ASGNI4
line 785
;785:	if ( timeDelta < DUCK_TIME) {
ADDRLP4 36
INDIRI4
CNSTI4 100
GEI4 $555
line 786
;786:		cg.refdef.vieworg[2] -= cg.duckChange 
ADDRLP4 80
ADDRGP4 cg+3604+24+8
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRGP4 cg+3480
INDIRF4
CNSTI4 100
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1120403456
DIVF4
SUBF4
ASGNF4
line 788
;787:			* (DUCK_TIME - timeDelta) / DUCK_TIME;
;788:	}
LABELV $555
line 791
;789:
;790:	// add bob height
;791:	bob = cg.bobfracsin * cg.xyspeed * cg_bobup.value;
ADDRLP4 24
ADDRGP4 cg+13452
INDIRF4
ADDRGP4 cg+13460
INDIRF4
MULF4
ADDRGP4 cg_bobup+8
INDIRF4
MULF4
ASGNF4
line 792
;792:	if (bob > 6) {
ADDRLP4 24
INDIRF4
CNSTF4 1086324736
LEF4 $564
line 793
;793:		bob = 6;
ADDRLP4 24
CNSTF4 1086324736
ASGNF4
line 794
;794:	}
LABELV $564
line 796
;795:
;796:	origin[2] += bob;
ADDRLP4 80
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 800
;797:
;798:
;799:	// add fall height
;800:	delta = cg.time - cg.landTime;
ADDRLP4 0
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+3492
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 801
;801:	if ( delta < LAND_DEFLECT_TIME ) {
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
GEF4 $568
line 802
;802:		f = delta / LAND_DEFLECT_TIME;
ADDRLP4 40
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
DIVF4
ASGNF4
line 803
;803:		cg.refdef.vieworg[2] += cg.landChange * f;
ADDRLP4 84
ADDRGP4 cg+3604+24+8
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRGP4 cg+3488
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
line 804
;804:	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
ADDRGP4 $569
JUMPV
LABELV $568
ADDRLP4 0
INDIRF4
CNSTF4 1138819072
GEF4 $574
line 805
;805:		delta -= LAND_DEFLECT_TIME;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
SUBF4
ASGNF4
line 806
;806:		f = 1.0 - ( delta / LAND_RETURN_TIME );
ADDRLP4 40
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
CNSTF4 1133903872
DIVF4
SUBF4
ASGNF4
line 807
;807:		cg.refdef.vieworg[2] += cg.landChange * f;
ADDRLP4 84
ADDRGP4 cg+3604+24+8
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRGP4 cg+3488
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
line 808
;808:	}
LABELV $574
LABELV $569
line 811
;809:
;810:	// add step offset
;811:	CG_StepOffset();
ADDRGP4 CG_StepOffset
CALLV
pop
line 815
;812:
;813:	// add kick offset
;814:
;815:	VectorAdd (origin, cg.kick_origin, origin);
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 cg+13440
INDIRF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
ADDRGP4 cg+13440+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 92
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRGP4 cg+13440+8
INDIRF4
ADDF4
ASGNF4
line 829
;816:
;817:	// pivot the eye based on a neck length
;818:#if 0
;819:	{
;820:#define	NECK_LENGTH		8
;821:	vec3_t			forward, up;
;822: 
;823:	cg.refdef.vieworg[2] -= NECK_LENGTH;
;824:	AngleVectors( cg.refdefViewAngles, forward, NULL, up );
;825:	VectorMA( cg.refdef.vieworg, 3, forward, cg.refdef.vieworg );
;826:	VectorMA( cg.refdef.vieworg, NECK_LENGTH, up, cg.refdef.vieworg );
;827:	}
;828:#endif
;829:}
LABELV $473
endproc CG_OffsetFirstPersonView 96 0
export CG_ZoomDown_f
proc CG_ZoomDown_f 0 0
line 833
;830:
;831://======================================================================
;832:
;833:void CG_ZoomDown_f( void ) { 
line 834
;834:	if ( cg.zoomed ) {
ADDRGP4 cg+3996
INDIRI4
CNSTI4 0
EQI4 $586
line 835
;835:		return;
ADDRGP4 $585
JUMPV
LABELV $586
line 837
;836:	}
;837:	cg.zoomed = qtrue;
ADDRGP4 cg+3996
CNSTI4 1
ASGNI4
line 838
;838:	cg.zoomTime = cg.time;
ADDRGP4 cg+4000
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 839
;839:}
LABELV $585
endproc CG_ZoomDown_f 0 0
export CG_ZoomUp_f
proc CG_ZoomUp_f 0 0
line 841
;840:
;841:void CG_ZoomUp_f( void ) { 
line 842
;842:	if ( !cg.zoomed ) {
ADDRGP4 cg+3996
INDIRI4
CNSTI4 0
NEI4 $593
line 843
;843:		return;
ADDRGP4 $592
JUMPV
LABELV $593
line 845
;844:	}
;845:	cg.zoomed = qfalse;
ADDRGP4 cg+3996
CNSTI4 0
ASGNI4
line 846
;846:	cg.zoomTime = cg.time;
ADDRGP4 cg+4000
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 847
;847:}
LABELV $592
endproc CG_ZoomUp_f 0 0
export CG_CalcFOVFromX
proc CG_CalcFOVFromX 20 8
line 862
;848:
;849:
;850:
;851:/*
;852:====================
;853:CG_CalcFovFromX
;854:
;855:Calcs Y FOV from given X FOV
;856:====================
;857:*/
;858:#define	WAVE_AMPLITUDE	1
;859:#define	WAVE_FREQUENCY	0.4
;860:
;861:qboolean CG_CalcFOVFromX( float fov_x ) 
;862:{
line 870
;863:	float	x;
;864://	float	phase;
;865://	float	v;
;866://	int		contents;
;867:	float	fov_y;
;868:	qboolean	inwater;
;869:
;870:	x = cg.refdef.width / tan( fov_x / 360 * M_PI );
CNSTF4 1078530011
ADDRFP4 0
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
ARGF4
ADDRLP4 12
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 4
ADDRGP4 cg+3604+8
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
DIVF4
ASGNF4
line 871
;871:	fov_y = atan2( cg.refdef.height, x );
ADDRGP4 cg+3604+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 872
;872:	fov_y = fov_y * 360 / M_PI;
ADDRLP4 0
CNSTF4 1135869952
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 895
;873:
;874:	// there's a problem with this, it only takes the leafbrushes into account, not the entity brushes,
;875:	//	so if you give slime/water etc properties to a func_door area brush in order to move the whole water 
;876:	//	level up/down this doesn't take into account the door position, so warps the view the whole time
;877:	//	whether the water is up or not. Fortunately there's only one slime area in Trek that you can be under,
;878:	//	so lose it...
;879:#if 0
;880:/*
;881:	// warp if underwater
;882:	contents = CG_PointContents( cg.refdef.vieworg, -1 );
;883:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ){
;884:		phase = cg.time / 1000.0 * WAVE_FREQUENCY * M_PI * 2;
;885:		v = WAVE_AMPLITUDE * sin( phase );
;886:		fov_x += v;
;887:		fov_y -= v;
;888:		inwater = qtrue;
;889:	}
;890:	else {
;891:		inwater = qfalse;
;892:	}
;893:*/
;894:#else
;895:	inwater = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 900
;896:#endif
;897:
;898:
;899:	// set it
;900:	cg.refdef.fov_x = fov_x;
ADDRGP4 cg+3604+16
ADDRFP4 0
INDIRF4
ASGNF4
line 901
;901:	cg.refdef.fov_y = fov_y;
ADDRGP4 cg+3604+20
ADDRLP4 0
INDIRF4
ASGNF4
line 903
;902:
;903:	return (inwater);
ADDRLP4 8
INDIRI4
RETI4
LABELV $599
endproc CG_CalcFOVFromX 20 8
data
align 4
LABELV $651
byte 4 0
code
proc CG_CalcFov 52 16
line 917
;904:}
;905:
;906:/*
;907:====================
;908:CG_CalcFov
;909:
;910:Fixed fov at intermissions, otherwise account for fov variable and zooms.
;911:====================
;912:*/
;913:#define	WAVE_AMPLITUDE	1
;914:#define	WAVE_FREQUENCY	0.4
;915:float zoomFov; //this has to be global client-side
;916:
;917:static int CG_CalcFov( void ) {
line 925
;918:	float	x;
;919:	float	phase;
;920:	float	v;
;921:	int		contents;
;922:	float	fov_x, fov_y;
;923:	float	f;
;924:	int		inwater;
;925:	float	cgFov = cg_fov.value;
ADDRLP4 0
ADDRGP4 cg_fov+8
INDIRF4
ASGNF4
line 927
;926:
;927:	if (cgFov < 1)
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $610
line 928
;928:	{
line 929
;929:		cgFov = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 930
;930:	}
LABELV $610
line 931
;931:	if (cgFov > 97)
ADDRLP4 0
INDIRF4
CNSTF4 1120010240
LEF4 $612
line 932
;932:	{
line 933
;933:		cgFov = 97;
ADDRLP4 0
CNSTF4 1120010240
ASGNF4
line 934
;934:	}
LABELV $612
line 936
;935:
;936:	if ( cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+96+4
INDIRI4
CNSTI4 6
NEI4 $614
line 938
;937:		// if in intermission, use a fixed value
;938:		fov_x = 80;//90;
ADDRLP4 4
CNSTF4 1117782016
ASGNF4
line 939
;939:	} else {
ADDRGP4 $615
JUMPV
LABELV $614
line 941
;940:		// user selectable
;941:		if ( cgs.dmflags & DF_FIXED_FOV ) {
ADDRGP4 cgs+32964
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $618
line 943
;942:			// dmflag to prevent wide fov for all clients
;943:			fov_x = 80;//90;
ADDRLP4 4
CNSTF4 1117782016
ASGNF4
line 944
;944:		} else {
ADDRGP4 $619
JUMPV
LABELV $618
line 945
;945:			fov_x = cgFov;
ADDRLP4 4
ADDRLP4 0
INDIRF4
ASGNF4
line 946
;946:			if ( fov_x < 1 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
GEF4 $621
line 947
;947:				fov_x = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 948
;948:			} else if ( fov_x > 160 ) {
ADDRGP4 $622
JUMPV
LABELV $621
ADDRLP4 4
INDIRF4
CNSTF4 1126170624
LEF4 $623
line 949
;949:				fov_x = 160;
ADDRLP4 4
CNSTF4 1126170624
ASGNF4
line 950
;950:			}
LABELV $623
LABELV $622
line 951
;951:		}
LABELV $619
line 953
;952:
;953:		if (cg.predictedPlayerState.zoomMode == 2)
ADDRGP4 cg+96+1320
INDIRI4
CNSTI4 2
NEI4 $625
line 954
;954:		{ //binoculars
line 955
;955:			if (zoomFov > 40.0f)
ADDRGP4 zoomFov
INDIRF4
CNSTF4 1109393408
LEF4 $629
line 956
;956:			{
line 957
;957:				zoomFov -= cg.frametime * 0.075f;
ADDRLP4 36
ADDRGP4 zoomFov
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1033476506
ADDRGP4 cg+60
INDIRI4
CVIF4 4
MULF4
SUBF4
ASGNF4
line 959
;958:
;959:				if (zoomFov < 40.0f)
ADDRGP4 zoomFov
INDIRF4
CNSTF4 1109393408
GEF4 $632
line 960
;960:				{
line 961
;961:					zoomFov = 40.0f;
ADDRGP4 zoomFov
CNSTF4 1109393408
ASGNF4
line 962
;962:				}
ADDRGP4 $633
JUMPV
LABELV $632
line 963
;963:				else if (zoomFov > cgFov)
ADDRGP4 zoomFov
INDIRF4
ADDRLP4 0
INDIRF4
LEF4 $634
line 964
;964:				{
line 965
;965:					zoomFov = cgFov;
ADDRGP4 zoomFov
ADDRLP4 0
INDIRF4
ASGNF4
line 966
;966:				}
LABELV $634
LABELV $633
line 967
;967:			}
LABELV $629
line 969
;968:
;969:			fov_x = zoomFov;
ADDRLP4 4
ADDRGP4 zoomFov
INDIRF4
ASGNF4
line 970
;970:		}
ADDRGP4 $626
JUMPV
LABELV $625
line 971
;971:		else if (cg.predictedPlayerState.zoomMode)
ADDRGP4 cg+96+1320
INDIRI4
CNSTI4 0
EQI4 $636
line 972
;972:		{
line 973
;973:			if (!cg.predictedPlayerState.zoomLocked)
ADDRGP4 cg+96+1328
INDIRI4
CNSTI4 0
NEI4 $640
line 974
;974:			{
line 975
;975:				if (zoomFov > 50)
ADDRGP4 zoomFov
INDIRF4
CNSTF4 1112014848
LEF4 $644
line 976
;976:				{ //Now starting out at nearly half zoomed in
line 977
;977:					zoomFov = 50;
ADDRGP4 zoomFov
CNSTF4 1112014848
ASGNF4
line 978
;978:				}
LABELV $644
line 979
;979:				zoomFov -= cg.frametime * 0.035f;//0.075f;
ADDRLP4 36
ADDRGP4 zoomFov
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1024416809
ADDRGP4 cg+60
INDIRI4
CVIF4 4
MULF4
SUBF4
ASGNF4
line 981
;980:
;981:				if (zoomFov < MAX_ZOOM_FOV)
ADDRGP4 zoomFov
INDIRF4
CNSTF4 1077936128
GEF4 $647
line 982
;982:				{
line 983
;983:					zoomFov = MAX_ZOOM_FOV;
ADDRGP4 zoomFov
CNSTF4 1077936128
ASGNF4
line 984
;984:				}
ADDRGP4 $648
JUMPV
LABELV $647
line 985
;985:				else if (zoomFov > cgFov)
ADDRGP4 zoomFov
INDIRF4
ADDRLP4 0
INDIRF4
LEF4 $649
line 986
;986:				{
line 987
;987:					zoomFov = cgFov;
ADDRGP4 zoomFov
ADDRLP4 0
INDIRF4
ASGNF4
line 988
;988:				}
ADDRGP4 $650
JUMPV
LABELV $649
line 990
;989:				else
;990:				{	// Still zooming
line 993
;991:					static zoomSoundTime = 0;
;992:
;993:					if (zoomSoundTime < cg.time || zoomSoundTime > cg.time + 10000)
ADDRLP4 40
ADDRGP4 $651
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
ADDRGP4 cg+64
INDIRI4
LTI4 $656
ADDRLP4 40
INDIRI4
ADDRGP4 cg+64
INDIRI4
CNSTI4 10000
ADDI4
LEI4 $652
LABELV $656
line 994
;994:					{
line 995
;995:						trap_S_StartSound(cg.refdef.vieworg, ENTITYNUM_WORLD, CHAN_LOCAL, cgs.media.disruptorZoomLoop);
ADDRGP4 cg+3604+24
ARGP4
CNSTI4 1022
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+70280+1276
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 996
;996:						zoomSoundTime = cg.time + 300;
ADDRGP4 $651
ADDRGP4 cg+64
INDIRI4
CNSTI4 300
ADDI4
ASGNI4
line 997
;997:					}
LABELV $652
line 998
;998:				}
LABELV $650
LABELV $648
line 999
;999:			}
LABELV $640
line 1001
;1000:
;1001:			fov_x = zoomFov;
ADDRLP4 4
ADDRGP4 zoomFov
INDIRF4
ASGNF4
line 1002
;1002:		}
ADDRGP4 $637
JUMPV
LABELV $636
line 1004
;1003:		else 
;1004:		{
line 1005
;1005:			zoomFov = 80;
ADDRGP4 zoomFov
CNSTF4 1117782016
ASGNF4
line 1007
;1006:
;1007:			f = ( cg.time - cg.predictedPlayerState.zoomTime ) / ZOOM_OUT_TIME;
ADDRLP4 32
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+96+1324
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1120403456
DIVF4
ASGNF4
line 1008
;1008:			if ( f > 1.0 ) 
ADDRLP4 32
INDIRF4
CNSTF4 1065353216
LEF4 $665
line 1009
;1009:			{
line 1010
;1010:				fov_x = fov_x;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ASGNF4
line 1011
;1011:			} 
ADDRGP4 $666
JUMPV
LABELV $665
line 1013
;1012:			else 
;1013:			{
line 1014
;1014:				fov_x = cg.predictedPlayerState.zoomFov + f * ( fov_x - cg.predictedPlayerState.zoomFov );
ADDRLP4 4
ADDRGP4 cg+96+1332
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 cg+96+1332
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1015
;1015:			}
LABELV $666
line 1016
;1016:		}
LABELV $637
LABELV $626
line 1017
;1017:	}
LABELV $615
line 1019
;1018:
;1019:	x = cg.refdef.width / tan( fov_x / 360 * M_PI );
CNSTF4 1078530011
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 12
ADDRGP4 cg+3604+8
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
DIVF4
ASGNF4
line 1020
;1020:	fov_y = atan2( cg.refdef.height, x );
ADDRGP4 cg+3604+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 40
INDIRF4
ASGNF4
line 1021
;1021:	fov_y = fov_y * 360 / M_PI;
ADDRLP4 8
CNSTF4 1135869952
ADDRLP4 8
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 1024
;1022:
;1023:	// warp if underwater
;1024:	contents = CG_PointContents( cg.refdef.vieworg, -1 );
ADDRGP4 cg+3604+24
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 44
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 44
INDIRI4
ASGNI4
line 1025
;1025:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ){
ADDRLP4 16
INDIRI4
CNSTI4 131078
BANDI4
CNSTI4 0
EQI4 $677
line 1026
;1026:		phase = cg.time / 1000.0 * WAVE_FREQUENCY * M_PI * 2;
ADDRLP4 28
CNSTF4 1073741824
CNSTF4 1078530011
CNSTF4 1053609165
ADDRGP4 cg+64
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
MULF4
MULF4
MULF4
ASGNF4
line 1027
;1027:		v = WAVE_AMPLITUDE * sin( phase );
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 24
CNSTF4 1065353216
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 1028
;1028:		fov_x += v;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 1029
;1029:		fov_y -= v;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
ASGNF4
line 1030
;1030:		inwater = qtrue;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 1031
;1031:	}
ADDRGP4 $678
JUMPV
LABELV $677
line 1032
;1032:	else {
line 1033
;1033:		inwater = qfalse;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 1034
;1034:	}
LABELV $678
line 1038
;1035:
;1036:
;1037:	// set it
;1038:	cg.refdef.fov_x = fov_x;
ADDRGP4 cg+3604+16
ADDRLP4 4
INDIRF4
ASGNF4
line 1039
;1039:	cg.refdef.fov_y = fov_y;
ADDRGP4 cg+3604+20
ADDRLP4 8
INDIRF4
ASGNF4
line 1041
;1040:
;1041:	if (cg.predictedPlayerState.zoomMode)
ADDRGP4 cg+96+1320
INDIRI4
CNSTI4 0
EQI4 $684
line 1042
;1042:	{
line 1043
;1043:		cg.zoomSensitivity = zoomFov/cgFov;
ADDRGP4 cg+4004
ADDRGP4 zoomFov
INDIRF4
ADDRLP4 0
INDIRF4
DIVF4
ASGNF4
line 1044
;1044:	}
ADDRGP4 $685
JUMPV
LABELV $684
line 1045
;1045:	else if ( !cg.zoomed ) {
ADDRGP4 cg+3996
INDIRI4
CNSTI4 0
NEI4 $689
line 1046
;1046:		cg.zoomSensitivity = 1;
ADDRGP4 cg+4004
CNSTF4 1065353216
ASGNF4
line 1047
;1047:	} else {
ADDRGP4 $690
JUMPV
LABELV $689
line 1048
;1048:		cg.zoomSensitivity = cg.refdef.fov_y / 75.0;
ADDRGP4 cg+4004
ADDRGP4 cg+3604+20
INDIRF4
CNSTF4 1117126656
DIVF4
ASGNF4
line 1049
;1049:	}
LABELV $690
LABELV $685
line 1051
;1050:
;1051:	return inwater;
ADDRLP4 20
INDIRI4
RETI4
LABELV $608
endproc CG_CalcFov 52 16
proc CG_DamageBlendBlob 260 12
line 1062
;1052:}
;1053:
;1054:
;1055:/*
;1056:===============
;1057:CG_DamageBlendBlob
;1058:
;1059:===============
;1060:*/
;1061:static void CG_DamageBlendBlob( void ) 
;1062:{
line 1067
;1063:	int			t;
;1064:	int			maxTime;
;1065:	refEntity_t		ent;
;1066:
;1067:	if ( !cg.damageValue ) {
ADDRGP4 cg+13384
INDIRF4
CNSTF4 0
NEF4 $697
line 1068
;1068:		return;
ADDRGP4 $696
JUMPV
LABELV $697
line 1071
;1069:	}
;1070:
;1071:	maxTime = DAMAGE_TIME;
ADDRLP4 216
CNSTI4 500
ASGNI4
line 1072
;1072:	t = cg.time - cg.damageTime;
ADDRLP4 212
ADDRGP4 cg+64
INDIRI4
CVIF4 4
ADDRGP4 cg+13372
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 1073
;1073:	if ( t <= 0 || t >= maxTime ) {
ADDRLP4 212
INDIRI4
CNSTI4 0
LEI4 $704
ADDRLP4 212
INDIRI4
ADDRLP4 216
INDIRI4
LTI4 $702
LABELV $704
line 1074
;1074:		return;
ADDRGP4 $696
JUMPV
LABELV $702
line 1077
;1075:	}
;1076:
;1077:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1078
;1078:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1079
;1079:	ent.renderfx = RF_FIRST_PERSON;
ADDRLP4 0+4
CNSTI4 4
ASGNI4
line 1081
;1080:
;1081:	VectorMA( cg.refdef.vieworg, 8, cg.refdef.viewaxis[0], ent.origin );
ADDRLP4 0+52
ADDRGP4 cg+3604+24
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+3604+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+4
ADDRGP4 cg+3604+24+4
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+3604+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+8
ADDRGP4 cg+3604+24+8
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+3604+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1082
;1082:	VectorMA( ent.origin, cg.damageX * -8, cg.refdef.viewaxis[1], ent.origin );
ADDRLP4 0+52
ADDRLP4 0+52
INDIRF4
ADDRGP4 cg+3604+36+12
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+13376
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+4
ADDRLP4 0+52+4
INDIRF4
ADDRGP4 cg+3604+36+12+4
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+13376
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
ADDRGP4 cg+3604+36+12+8
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+13376
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1083
;1083:	VectorMA( ent.origin, cg.damageY * 8, cg.refdef.viewaxis[2], ent.origin );
ADDRLP4 0+52
ADDRLP4 0+52
INDIRF4
ADDRGP4 cg+3604+36+24
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+13380
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+4
ADDRLP4 0+52+4
INDIRF4
ADDRGP4 cg+3604+36+24+4
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+13380
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
ADDRGP4 cg+3604+36+24+8
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+13380
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1085
;1084:
;1085:	ent.radius = cg.damageValue * 3 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 0+92
CNSTF4 1077936128
ADDRGP4 cg+13384
INDIRF4
MULF4
CNSTF4 1065353216
ADDRLP4 212
INDIRI4
CVIF4 4
ADDRLP4 216
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
line 1087
;1086:
;1087:	if (cg.snap->ps.damageType == 0)
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 0
NEI4 $777
line 1088
;1088:	{ //pure health
line 1089
;1089:		ent.customShader = cgs.media.viewPainShader;
ADDRLP4 0+76
ADDRGP4 cgs+70280+448
INDIRI4
ASGNI4
line 1090
;1090:		ent.shaderRGBA[0] = 180 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 228
CNSTF4 1127481344
CNSTF4 1065353216
ADDRLP4 212
INDIRI4
CVIF4 4
ADDRLP4 216
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 232
CNSTF4 1325400064
ASGNF4
ADDRLP4 228
INDIRF4
ADDRLP4 232
INDIRF4
LTF4 $785
ADDRLP4 224
ADDRLP4 228
INDIRF4
ADDRLP4 232
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $786
JUMPV
LABELV $785
ADDRLP4 224
ADDRLP4 228
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $786
ADDRLP4 0+80
ADDRLP4 224
INDIRU4
CVUU1 4
ASGNU1
line 1091
;1091:		ent.shaderRGBA[1] = 50 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 240
CNSTF4 1112014848
CNSTF4 1065353216
ADDRLP4 212
INDIRI4
CVIF4 4
ADDRLP4 216
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 244
CNSTF4 1325400064
ASGNF4
ADDRLP4 240
INDIRF4
ADDRLP4 244
INDIRF4
LTF4 $790
ADDRLP4 236
ADDRLP4 240
INDIRF4
ADDRLP4 244
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $791
JUMPV
LABELV $790
ADDRLP4 236
ADDRLP4 240
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $791
ADDRLP4 0+80+1
ADDRLP4 236
INDIRU4
CVUU1 4
ASGNU1
line 1092
;1092:		ent.shaderRGBA[2] = 50 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 252
CNSTF4 1112014848
CNSTF4 1065353216
ADDRLP4 212
INDIRI4
CVIF4 4
ADDRLP4 216
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 256
CNSTF4 1325400064
ASGNF4
ADDRLP4 252
INDIRF4
ADDRLP4 256
INDIRF4
LTF4 $795
ADDRLP4 248
ADDRLP4 252
INDIRF4
ADDRLP4 256
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $796
JUMPV
LABELV $795
ADDRLP4 248
ADDRLP4 252
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $796
ADDRLP4 0+80+2
ADDRLP4 248
INDIRU4
CVUU1 4
ASGNU1
line 1093
;1093:		ent.shaderRGBA[3] = 255;
ADDRLP4 0+80+3
CNSTU1 255
ASGNU1
line 1094
;1094:	}
ADDRGP4 $778
JUMPV
LABELV $777
line 1095
;1095:	else if (cg.snap->ps.damageType == 1)
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 1
NEI4 $799
line 1096
;1096:	{ //pure shields
line 1097
;1097:		ent.customShader = cgs.media.viewPainShader_Shields;
ADDRLP4 0+76
ADDRGP4 cgs+70280+452
INDIRI4
ASGNI4
line 1098
;1098:		ent.shaderRGBA[0] = 50 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 228
CNSTF4 1112014848
CNSTF4 1065353216
ADDRLP4 212
INDIRI4
CVIF4 4
ADDRLP4 216
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 232
CNSTF4 1325400064
ASGNF4
ADDRLP4 228
INDIRF4
ADDRLP4 232
INDIRF4
LTF4 $807
ADDRLP4 224
ADDRLP4 228
INDIRF4
ADDRLP4 232
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $808
JUMPV
LABELV $807
ADDRLP4 224
ADDRLP4 228
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $808
ADDRLP4 0+80
ADDRLP4 224
INDIRU4
CVUU1 4
ASGNU1
line 1099
;1099:		ent.shaderRGBA[1] = 180 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 240
CNSTF4 1127481344
CNSTF4 1065353216
ADDRLP4 212
INDIRI4
CVIF4 4
ADDRLP4 216
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 244
CNSTF4 1325400064
ASGNF4
ADDRLP4 240
INDIRF4
ADDRLP4 244
INDIRF4
LTF4 $812
ADDRLP4 236
ADDRLP4 240
INDIRF4
ADDRLP4 244
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $813
JUMPV
LABELV $812
ADDRLP4 236
ADDRLP4 240
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $813
ADDRLP4 0+80+1
ADDRLP4 236
INDIRU4
CVUU1 4
ASGNU1
line 1100
;1100:		ent.shaderRGBA[2] = 50 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 252
CNSTF4 1112014848
CNSTF4 1065353216
ADDRLP4 212
INDIRI4
CVIF4 4
ADDRLP4 216
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 256
CNSTF4 1325400064
ASGNF4
ADDRLP4 252
INDIRF4
ADDRLP4 256
INDIRF4
LTF4 $817
ADDRLP4 248
ADDRLP4 252
INDIRF4
ADDRLP4 256
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $818
JUMPV
LABELV $817
ADDRLP4 248
ADDRLP4 252
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $818
ADDRLP4 0+80+2
ADDRLP4 248
INDIRU4
CVUU1 4
ASGNU1
line 1101
;1101:		ent.shaderRGBA[3] = 255;
ADDRLP4 0+80+3
CNSTU1 255
ASGNU1
line 1102
;1102:	}
ADDRGP4 $800
JUMPV
LABELV $799
line 1104
;1103:	else
;1104:	{ //shields and health
line 1105
;1105:		ent.customShader = cgs.media.viewPainShader_ShieldsAndHealth;
ADDRLP4 0+76
ADDRGP4 cgs+70280+456
INDIRI4
ASGNI4
line 1106
;1106:		ent.shaderRGBA[0] = 180 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 228
CNSTF4 1127481344
CNSTF4 1065353216
ADDRLP4 212
INDIRI4
CVIF4 4
ADDRLP4 216
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 232
CNSTF4 1325400064
ASGNF4
ADDRLP4 228
INDIRF4
ADDRLP4 232
INDIRF4
LTF4 $826
ADDRLP4 224
ADDRLP4 228
INDIRF4
ADDRLP4 232
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $827
JUMPV
LABELV $826
ADDRLP4 224
ADDRLP4 228
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $827
ADDRLP4 0+80
ADDRLP4 224
INDIRU4
CVUU1 4
ASGNU1
line 1107
;1107:		ent.shaderRGBA[1] = 180 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 240
CNSTF4 1127481344
CNSTF4 1065353216
ADDRLP4 212
INDIRI4
CVIF4 4
ADDRLP4 216
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 244
CNSTF4 1325400064
ASGNF4
ADDRLP4 240
INDIRF4
ADDRLP4 244
INDIRF4
LTF4 $831
ADDRLP4 236
ADDRLP4 240
INDIRF4
ADDRLP4 244
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $832
JUMPV
LABELV $831
ADDRLP4 236
ADDRLP4 240
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $832
ADDRLP4 0+80+1
ADDRLP4 236
INDIRU4
CVUU1 4
ASGNU1
line 1108
;1108:		ent.shaderRGBA[2] = 50 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 252
CNSTF4 1112014848
CNSTF4 1065353216
ADDRLP4 212
INDIRI4
CVIF4 4
ADDRLP4 216
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 256
CNSTF4 1325400064
ASGNF4
ADDRLP4 252
INDIRF4
ADDRLP4 256
INDIRF4
LTF4 $836
ADDRLP4 248
ADDRLP4 252
INDIRF4
ADDRLP4 256
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $837
JUMPV
LABELV $836
ADDRLP4 248
ADDRLP4 252
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $837
ADDRLP4 0+80+2
ADDRLP4 248
INDIRU4
CVUU1 4
ASGNU1
line 1109
;1109:		ent.shaderRGBA[3] = 255;
ADDRLP4 0+80+3
CNSTU1 255
ASGNU1
line 1110
;1110:	}
LABELV $800
LABELV $778
line 1111
;1111:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1112
;1112:}
LABELV $696
endproc CG_DamageBlendBlob 260 12
export CheckOutOfConstrict
proc CheckOutOfConstrict 20 0
line 1115
;1113:
;1114:qboolean CheckOutOfConstrict(float curAng)
;1115:{
line 1118
;1116:	float degrees_negative, degrees_positive;
;1117:
;1118:	float angle_ideal = cg.constrictValue;
ADDRLP4 4
ADDRGP4 cg+3984
INDIRF4
ASGNF4
line 1119
;1119:	float angle_current = curAng;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
line 1121
;1120:
;1121:	float angle_dif = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1123
;1122:
;1123:	if (angle_current < 0)
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $842
line 1124
;1124:	{
line 1125
;1125:		angle_current += 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 1126
;1126:	}
LABELV $842
line 1127
;1127:	if (angle_current > 360)
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
LEF4 $844
line 1128
;1128:	{
line 1129
;1129:		angle_current -= 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 1130
;1130:	}
LABELV $844
line 1132
;1131:
;1132:	if (cg.doConstrict <= cg.time)
ADDRGP4 cg+3992
INDIRI4
ADDRGP4 cg+64
INDIRI4
GTI4 $846
line 1133
;1133:	{
line 1134
;1134:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $840
JUMPV
LABELV $846
line 1137
;1135:	}
;1136:
;1137:	if (angle_ideal <= angle_current)
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $850
line 1138
;1138:	{
line 1139
;1139:		degrees_negative = (angle_current - angle_ideal);
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 1141
;1140:
;1141:		degrees_positive = (360 - angle_current) + angle_ideal;
ADDRLP4 16
CNSTF4 1135869952
ADDRLP4 0
INDIRF4
SUBF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 1142
;1142:	}
ADDRGP4 $851
JUMPV
LABELV $850
line 1144
;1143:	else
;1144:	{
line 1145
;1145:		degrees_negative = angle_current + (360 - angle_ideal);
ADDRLP4 12
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDRLP4 4
INDIRF4
SUBF4
ADDF4
ASGNF4
line 1147
;1146:
;1147:		degrees_positive = (angle_ideal - angle_current);
ADDRLP4 16
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 1148
;1148:	}
LABELV $851
line 1150
;1149:
;1150:	if (degrees_negative < degrees_positive)
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
GEF4 $852
line 1151
;1151:	{
line 1152
;1152:		angle_dif = degrees_negative;
ADDRLP4 8
ADDRLP4 12
INDIRF4
ASGNF4
line 1153
;1153:	}
ADDRGP4 $853
JUMPV
LABELV $852
line 1155
;1154:	else
;1155:	{
line 1156
;1156:		angle_dif = degrees_positive;
ADDRLP4 8
ADDRLP4 16
INDIRF4
ASGNF4
line 1157
;1157:	}
LABELV $853
line 1159
;1158:
;1159:	if (angle_dif > 60)
ADDRLP4 8
INDIRF4
CNSTF4 1114636288
LEF4 $854
line 1160
;1160:	{
line 1161
;1161:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $840
JUMPV
LABELV $854
line 1164
;1162:	}
;1163:
;1164:	return qfalse;
CNSTI4 0
RETI4
LABELV $840
endproc CheckOutOfConstrict 20 0
proc CG_CalcViewValues 40 12
line 1174
;1165:}
;1166:
;1167:/*
;1168:===============
;1169:CG_CalcViewValues
;1170:
;1171:Sets cg.refdef view values
;1172:===============
;1173:*/
;1174:static int CG_CalcViewValues( void ) {
line 1177
;1175:	playerState_t	*ps;
;1176:
;1177:	memset( &cg.refdef, 0, sizeof( cg.refdef ) );
ADDRGP4 cg+3604
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1184
;1178:
;1179:	// strings for in game rendering
;1180:	// Q_strncpyz( cg.refdef.text[0], "Park Ranger", sizeof(cg.refdef.text[0]) );
;1181:	// Q_strncpyz( cg.refdef.text[1], "19", sizeof(cg.refdef.text[1]) );
;1182:
;1183:	// calculate size of 3D view
;1184:	CG_CalcVrect();
ADDRGP4 CG_CalcVrect
CALLV
pop
line 1186
;1185:
;1186:	ps = &cg.predictedPlayerState;
ADDRLP4 0
ADDRGP4 cg+96
ASGNP4
line 1202
;1187:/*
;1188:	if (cg.cameraMode) {
;1189:		vec3_t origin, angles;
;1190:		if (trap_getCameraInfo(cg.time, &origin, &angles)) {
;1191:			VectorCopy(origin, cg.refdef.vieworg);
;1192:			angles[ROLL] = 0;
;1193:			VectorCopy(angles, cg.refdefViewAngles);
;1194:			AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
;1195:			return CG_CalcFov();
;1196:		} else {
;1197:			cg.cameraMode = qfalse;
;1198:		}
;1199:	}
;1200:*/
;1201:	// intermission view
;1202:	if ( ps->pm_type == PM_INTERMISSION ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 6
NEI4 $860
line 1203
;1203:		VectorCopy( ps->origin, cg.refdef.vieworg );
ADDRGP4 cg+3604+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1204
;1204:		VectorCopy( ps->viewangles, cg.refdefViewAngles );
ADDRGP4 cg+3972
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRB
ASGNB 12
line 1205
;1205:		AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
ADDRGP4 cg+3972
ARGP4
ADDRGP4 cg+3604+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1206
;1206:		return CG_CalcFov();
ADDRLP4 4
ADDRGP4 CG_CalcFov
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $856
JUMPV
LABELV $860
line 1209
;1207:	}
;1208:
;1209:	cg.bobcycle = ( ps->bobCycle & 128 ) >> 7;
ADDRGP4 cg+13456
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 7
RSHI4
ASGNI4
line 1210
;1210:	cg.bobfracsin = fabs( sin( ( ps->bobCycle & 127 ) / 127.0 * M_PI ) );
CNSTF4 1078530011
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 127
BANDI4
CVIF4 4
CNSTF4 1123942400
DIVF4
MULF4
ARGF4
ADDRLP4 4
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRGP4 cg+13452
ADDRLP4 8
INDIRF4
ASGNF4
line 1211
;1211:	cg.xyspeed = sqrt( ps->velocity[0] * ps->velocity[0] +
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRGP4 cg+13460
ADDRLP4 24
INDIRF4
ASGNF4
line 1214
;1212:		ps->velocity[1] * ps->velocity[1] );
;1213:
;1214:	if (cg.xyspeed > 270)
ADDRGP4 cg+13460
INDIRF4
CNSTF4 1132920832
LEF4 $871
line 1215
;1215:	{
line 1216
;1216:		cg.xyspeed = 270;
ADDRGP4 cg+13460
CNSTF4 1132920832
ASGNF4
line 1217
;1217:	}
LABELV $871
line 1219
;1218:
;1219:	VectorCopy( ps->origin, cg.refdef.vieworg );
ADDRGP4 cg+3604+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1220
;1220:	VectorCopy( ps->viewangles, cg.refdefViewAngles );
ADDRGP4 cg+3972
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRB
ASGNB 12
line 1222
;1221:
;1222:	if (cg_cameraOrbit.integer) {
ADDRGP4 cg_cameraOrbit+12
INDIRI4
CNSTI4 0
EQI4 $878
line 1223
;1223:		if (cg.time > cg.nextOrbitTime) {
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+13464
INDIRI4
LEI4 $881
line 1224
;1224:			cg.nextOrbitTime = cg.time + cg_cameraOrbitDelay.integer;
ADDRGP4 cg+13464
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg_cameraOrbitDelay+12
INDIRI4
ADDI4
ASGNI4
line 1225
;1225:			cg_thirdPersonAngle.value += cg_cameraOrbit.value;
ADDRLP4 28
ADDRGP4 cg_thirdPersonAngle+8
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRGP4 cg_cameraOrbit+8
INDIRF4
ADDF4
ASGNF4
line 1226
;1226:		}
LABELV $881
line 1227
;1227:	}
LABELV $878
line 1229
;1228:	// add error decay
;1229:	if ( cg_errorDecay.value > 0 ) {
ADDRGP4 cg_errorDecay+8
INDIRF4
CNSTF4 0
LEF4 $890
line 1233
;1230:		int		t;
;1231:		float	f;
;1232:
;1233:		t = cg.time - cg.predictedErrorTime;
ADDRLP4 32
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+3388
INDIRI4
SUBI4
ASGNI4
line 1234
;1234:		f = ( cg_errorDecay.value - t ) / cg_errorDecay.value;
ADDRLP4 28
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 32
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 1235
;1235:		if ( f > 0 && f < 1 ) {
ADDRLP4 36
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 0
LEF4 $897
ADDRLP4 36
INDIRF4
CNSTF4 1065353216
GEF4 $897
line 1236
;1236:			VectorMA( cg.refdef.vieworg, f, cg.predictedError, cg.refdef.vieworg );
ADDRGP4 cg+3604+24
ADDRGP4 cg+3604+24
INDIRF4
ADDRGP4 cg+3392
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+3604+24+4
ADDRGP4 cg+3604+24+4
INDIRF4
ADDRGP4 cg+3392+4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+3604+24+8
ADDRGP4 cg+3604+24+8
INDIRF4
ADDRGP4 cg+3392+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
line 1237
;1237:		} else {
ADDRGP4 $898
JUMPV
LABELV $897
line 1238
;1238:			cg.predictedErrorTime = 0;
ADDRGP4 cg+3388
CNSTI4 0
ASGNI4
line 1239
;1239:		}
LABELV $898
line 1240
;1240:	}
LABELV $890
line 1242
;1241:
;1242:	if ( cg.renderingThirdPerson && !cg.snap->ps.zoomMode) {
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 cg+88
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $921
ADDRGP4 cg+36
INDIRP4
CNSTI4 1364
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $921
line 1244
;1243:		// back away from character
;1244:		CG_OffsetThirdPersonView();
ADDRGP4 CG_OffsetThirdPersonView
CALLV
pop
line 1245
;1245:	} else {
ADDRGP4 $922
JUMPV
LABELV $921
line 1247
;1246:		// offset for local bobbing and kicks
;1247:		CG_OffsetFirstPersonView();
ADDRGP4 CG_OffsetFirstPersonView
CALLV
pop
line 1248
;1248:	}
LABELV $922
line 1251
;1249:
;1250:	// position eye reletive to origin
;1251:	AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
ADDRGP4 cg+3972
ARGP4
ADDRGP4 cg+3604+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1253
;1252:
;1253:	if ( cg.hyperspace ) {
ADDRGP4 cg+92
INDIRI4
CNSTI4 0
EQI4 $928
line 1254
;1254:		cg.refdef.rdflags |= RDF_NOWORLDMODEL | RDF_HYPERSPACE;
ADDRLP4 32
ADDRGP4 cg+3604+76
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 5
BORI4
ASGNI4
line 1255
;1255:	}
LABELV $928
line 1258
;1256:
;1257:	// field of view
;1258:	return CG_CalcFov();
ADDRLP4 32
ADDRGP4 CG_CalcFov
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
RETI4
LABELV $856
endproc CG_CalcViewValues 40 12
proc CG_PowerupTimerSounds 16 0
line 1267
;1259:}
;1260:
;1261:
;1262:/*
;1263:=====================
;1264:CG_PowerupTimerSounds
;1265:=====================
;1266:*/
;1267:static void CG_PowerupTimerSounds( void ) {
line 1272
;1268:	int		i;
;1269:	int		t;
;1270:
;1271:	// powerup timers going away
;1272:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $934
line 1273
;1273:		t = cg.snap->ps.powerups[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1274
;1274:		if ( t <= cg.time ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+64
INDIRI4
GTI4 $939
line 1275
;1275:			continue;
ADDRGP4 $935
JUMPV
LABELV $939
line 1277
;1276:		}
;1277:		if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $942
line 1278
;1278:			continue;
ADDRGP4 $935
JUMPV
LABELV $942
line 1280
;1279:		}
;1280:		if ( ( t - cg.time ) / POWERUP_BLINK_TIME != ( t - cg.oldTime ) / POWERUP_BLINK_TIME ) {
ADDRLP4 12
CNSTI4 1000
ASGNI4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
ADDRLP4 12
INDIRI4
DIVI4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+68
INDIRI4
SUBI4
ADDRLP4 12
INDIRI4
DIVI4
EQI4 $945
line 1282
;1281:			//trap_S_StartSound( NULL, cg.snap->ps.clientNum, CHAN_ITEM, cgs.media.wearOffSound );
;1282:		}
LABELV $945
line 1283
;1283:	}
LABELV $935
line 1272
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 16
LTI4 $934
line 1284
;1284:}
LABELV $933
endproc CG_PowerupTimerSounds 16 0
export CG_AddBufferedSound
proc CG_AddBufferedSound 4 0
line 1291
;1285:
;1286:/*
;1287:=====================
;1288:CG_AddBufferedSound
;1289:=====================
;1290:*/
;1291:void CG_AddBufferedSound( sfxHandle_t sfx ) {
line 1292
;1292:	if ( !sfx )
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $950
line 1293
;1293:		return;
ADDRGP4 $949
JUMPV
LABELV $950
line 1294
;1294:	cg.soundBuffer[cg.soundBufferIn] = sfx;
ADDRGP4 cg+13236
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+13248
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1295
;1295:	cg.soundBufferIn = (cg.soundBufferIn + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+13236
ADDRGP4 cg+13236
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 1296
;1296:	if (cg.soundBufferIn == cg.soundBufferOut) {
ADDRGP4 cg+13236
INDIRI4
ADDRGP4 cg+13240
INDIRI4
NEI4 $956
line 1297
;1297:		cg.soundBufferOut++;
ADDRLP4 0
ADDRGP4 cg+13240
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1298
;1298:	}
LABELV $956
line 1299
;1299:}
LABELV $949
endproc CG_AddBufferedSound 4 0
proc CG_PlayBufferedSounds 0 8
line 1306
;1300:
;1301:/*
;1302:=====================
;1303:CG_PlayBufferedSounds
;1304:=====================
;1305:*/
;1306:static void CG_PlayBufferedSounds( void ) {
line 1307
;1307:	if ( cg.soundTime < cg.time ) {
ADDRGP4 cg+13244
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $962
line 1308
;1308:		if (cg.soundBufferOut != cg.soundBufferIn && cg.soundBuffer[cg.soundBufferOut]) {
ADDRGP4 cg+13240
INDIRI4
ADDRGP4 cg+13236
INDIRI4
EQI4 $966
ADDRGP4 cg+13240
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+13248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $966
line 1309
;1309:			trap_S_StartLocalSound(cg.soundBuffer[cg.soundBufferOut], CHAN_ANNOUNCER);
ADDRGP4 cg+13240
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+13248
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1310
;1310:			cg.soundBuffer[cg.soundBufferOut] = 0;
ADDRGP4 cg+13240
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+13248
ADDP4
CNSTI4 0
ASGNI4
line 1311
;1311:			cg.soundBufferOut = (cg.soundBufferOut + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+13240
ADDRGP4 cg+13240
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 1312
;1312:			cg.soundTime = cg.time + 750;
ADDRGP4 cg+13244
ADDRGP4 cg+64
INDIRI4
CNSTI4 750
ADDI4
ASGNI4
line 1313
;1313:		}
LABELV $966
line 1314
;1314:	}
LABELV $962
line 1315
;1315:}
LABELV $961
endproc CG_PlayBufferedSounds 0 8
export CG_UpdateSoundTrackers
proc CG_UpdateSoundTrackers 16 8
line 1318
;1316:
;1317:void CG_UpdateSoundTrackers()
;1318:{
line 1322
;1319:	int num;
;1320:	centity_t *cent;
;1321:
;1322:	for ( num = 0 ; num < ENTITYNUM_NONE ; num++ )
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $981
line 1323
;1323:	{
line 1324
;1324:		cent = &cg_entities[num];
ADDRLP4 0
CNSTI4 1920
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1326
;1325:
;1326:		if (cent && cent->currentState.eFlags & EF_SOUNDTRACKER)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $985
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $985
line 1327
;1327:		{ //keep sound for this entity updated in accordance with its attached entity at all times
line 1328
;1328:			if (cg.snap && cent->currentState.trickedentindex == cg.snap->ps.clientNum)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $987
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $987
line 1329
;1329:			{ //this is actually the player, so center the sound origin right on top of us
line 1330
;1330:				VectorCopy(cg.refdef.vieworg, cent->lerpOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 928
ADDP4
ADDRGP4 cg+3604+24
INDIRB
ASGNB 12
line 1331
;1331:				trap_S_UpdateEntityPosition( cent->currentState.number, cent->lerpOrigin );
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
line 1332
;1332:			}
ADDRGP4 $988
JUMPV
LABELV $987
line 1334
;1333:			else
;1334:			{
line 1335
;1335:				trap_S_UpdateEntityPosition( cent->currentState.number, cg_entities[cent->currentState.trickedentindex].lerpOrigin );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+928
ADDP4
ARGP4
ADDRGP4 trap_S_UpdateEntityPosition
CALLV
pop
line 1336
;1336:			}
LABELV $988
line 1337
;1337:		}
LABELV $985
line 1338
;1338:	}
LABELV $982
line 1322
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1023
LTI4 $981
line 1339
;1339:}
LABELV $980
endproc CG_UpdateSoundTrackers 16 8
export CG_SE_UpdateShake
proc CG_SE_UpdateShake 52 0
line 1354
;1340:
;1341://=========================================================================
;1342:
;1343:/*
;1344:================================
;1345:Screen Effect stuff starts here
;1346:================================
;1347:*/
;1348:#define	CAMERA_DEFAULT_FOV			90.0f
;1349:#define MAX_SHAKE_INTENSITY			16.0f
;1350:
;1351:cgscreffects_t cgScreenEffects;
;1352:
;1353:void CG_SE_UpdateShake( vec3_t origin, vec3_t angles )
;1354:{
line 1359
;1355:	vec3_t	moveDir;
;1356:	float	intensity_scale, intensity;
;1357:	int		i;
;1358:
;1359:	if ( cgScreenEffects.shake_duration <= 0 )
ADDRGP4 cgScreenEffects+12
INDIRI4
CNSTI4 0
GTI4 $995
line 1360
;1360:		return;
ADDRGP4 $994
JUMPV
LABELV $995
line 1362
;1361:
;1362:	if ( cg.time > ( cgScreenEffects.shake_start + cgScreenEffects.shake_duration ) )
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgScreenEffects+16
INDIRI4
ADDRGP4 cgScreenEffects+12
INDIRI4
ADDI4
LEI4 $998
line 1363
;1363:	{
line 1364
;1364:		cgScreenEffects.shake_intensity = 0;
ADDRGP4 cgScreenEffects+8
CNSTF4 0
ASGNF4
line 1365
;1365:		cgScreenEffects.shake_duration = 0;
ADDRGP4 cgScreenEffects+12
CNSTI4 0
ASGNI4
line 1366
;1366:		cgScreenEffects.shake_start = 0;
ADDRGP4 cgScreenEffects+16
CNSTI4 0
ASGNI4
line 1367
;1367:		return;
ADDRGP4 $994
JUMPV
LABELV $998
line 1370
;1368:	}
;1369:
;1370:	cgScreenEffects.FOV = CAMERA_DEFAULT_FOV;
ADDRGP4 cgScreenEffects
CNSTF4 1119092736
ASGNF4
line 1371
;1371:	cgScreenEffects.FOV2 = CAMERA_DEFAULT_FOV;
ADDRGP4 cgScreenEffects+4
CNSTF4 1119092736
ASGNF4
line 1374
;1372:
;1373:	//intensity_scale now also takes into account FOV with 90.0 as normal
;1374:	intensity_scale = 1.0f - ( (float) ( cg.time - cgScreenEffects.shake_start ) / (float) cgScreenEffects.shake_duration ) * (((cgScreenEffects.FOV+cgScreenEffects.FOV2)/2.0f)/90.0f);
ADDRLP4 20
CNSTF4 1065353216
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgScreenEffects+16
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cgScreenEffects+12
INDIRI4
CVIF4 4
DIVF4
ADDRGP4 cgScreenEffects
INDIRF4
ADDRGP4 cgScreenEffects+4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
CNSTF4 1119092736
DIVF4
MULF4
SUBF4
ASGNF4
line 1376
;1375:
;1376:	intensity = cgScreenEffects.shake_intensity * intensity_scale;
ADDRLP4 16
ADDRGP4 cgScreenEffects+8
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 1378
;1377:
;1378:	for ( i = 0; i < 3; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1012
line 1379
;1379:	{
line 1380
;1380:		moveDir[i] = ( crandom() * intensity );
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1073741824
ADDRLP4 24
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 1381
;1381:	}
LABELV $1013
line 1378
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1012
line 1384
;1382:
;1383:	//Move the camera
;1384:	VectorAdd( origin, moveDir, origin );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 1386
;1385:
;1386:	for ( i=0; i < 2; i++ ) // Don't do ROLL
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1018
line 1387
;1387:		moveDir[i] = ( crandom() * intensity );
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1073741824
ADDRLP4 36
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
LABELV $1019
line 1386
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $1018
line 1390
;1388:
;1389:	//Move the angles
;1390:	VectorAdd( angles, moveDir, angles );
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 1391
;1391:}
LABELV $994
endproc CG_SE_UpdateShake 52 0
export CG_SE_UpdateMusic
proc CG_SE_UpdateMusic 516 16
line 1394
;1392:
;1393:void CG_SE_UpdateMusic(void)
;1394:{
line 1395
;1395:	if (cgScreenEffects.music_volume_multiplier < 0.1)
ADDRGP4 cgScreenEffects+20
INDIRF4
CNSTF4 1036831949
GEF4 $1025
line 1396
;1396:	{
line 1397
;1397:		cgScreenEffects.music_volume_multiplier = 1.0;
ADDRGP4 cgScreenEffects+20
CNSTF4 1065353216
ASGNF4
line 1398
;1398:		return;
ADDRGP4 $1024
JUMPV
LABELV $1025
line 1401
;1399:	}
;1400:
;1401:	if (cgScreenEffects.music_volume_time < cg.time)
ADDRGP4 cgScreenEffects+24
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $1029
line 1402
;1402:	{
line 1403
;1403:		if (cgScreenEffects.music_volume_multiplier != 1.0 || cgScreenEffects.music_volume_set)
ADDRGP4 cgScreenEffects+20
INDIRF4
CNSTF4 1065353216
NEF4 $1037
ADDRGP4 cgScreenEffects+28
INDIRI4
CNSTI4 0
EQI4 $1024
LABELV $1037
line 1404
;1404:		{
line 1407
;1405:			char musMultStr[512];
;1406:
;1407:			cgScreenEffects.music_volume_multiplier += 0.1;
ADDRLP4 512
ADDRGP4 cgScreenEffects+20
ASGNP4
ADDRLP4 512
INDIRP4
ADDRLP4 512
INDIRP4
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1408
;1408:			if (cgScreenEffects.music_volume_multiplier > 1.0)
ADDRGP4 cgScreenEffects+20
INDIRF4
CNSTF4 1065353216
LEF4 $1039
line 1409
;1409:			{
line 1410
;1410:				cgScreenEffects.music_volume_multiplier = 1.0;
ADDRGP4 cgScreenEffects+20
CNSTF4 1065353216
ASGNF4
line 1411
;1411:			}
LABELV $1039
line 1413
;1412:
;1413:			Com_sprintf(musMultStr, sizeof(musMultStr), "%f", cgScreenEffects.music_volume_multiplier);
ADDRLP4 0
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 $1043
ARGP4
ADDRGP4 cgScreenEffects+20
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
line 1414
;1414:			trap_Cvar_Set("s_musicMult", musMultStr);
ADDRGP4 $1045
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1416
;1415:
;1416:			if (cgScreenEffects.music_volume_multiplier == 1.0)
ADDRGP4 cgScreenEffects+20
INDIRF4
CNSTF4 1065353216
NEF4 $1046
line 1417
;1417:			{
line 1418
;1418:				cgScreenEffects.music_volume_set = qfalse;
ADDRGP4 cgScreenEffects+28
CNSTI4 0
ASGNI4
line 1419
;1419:			}
ADDRGP4 $1024
JUMPV
LABELV $1046
line 1421
;1420:			else
;1421:			{
line 1422
;1422:				cgScreenEffects.music_volume_time = cg.time + 200;
ADDRGP4 cgScreenEffects+24
ADDRGP4 cg+64
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1423
;1423:			}
line 1424
;1424:		}
line 1426
;1425:
;1426:		return;
ADDRGP4 $1024
JUMPV
LABELV $1029
line 1429
;1427:	}
;1428:
;1429:	if (!cgScreenEffects.music_volume_set)
ADDRGP4 cgScreenEffects+28
INDIRI4
CNSTI4 0
NEI4 $1052
line 1430
;1430:	{ //if the volume_time is >= cg.time, we should have a volume multiplier set
line 1433
;1431:		char musMultStr[512];
;1432:
;1433:		Com_sprintf(musMultStr, sizeof(musMultStr), "%f", cgScreenEffects.music_volume_multiplier);
ADDRLP4 0
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 $1043
ARGP4
ADDRGP4 cgScreenEffects+20
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
line 1434
;1434:		trap_Cvar_Set("s_musicMult", musMultStr);
ADDRGP4 $1045
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1435
;1435:		cgScreenEffects.music_volume_set = qtrue;
ADDRGP4 cgScreenEffects+28
CNSTI4 1
ASGNI4
line 1436
;1436:	}
LABELV $1052
line 1437
;1437:}
LABELV $1024
endproc CG_SE_UpdateMusic 516 16
export CG_CalcScreenEffects
proc CG_CalcScreenEffects 0 8
line 1447
;1438:
;1439:/*
;1440:=================
;1441:CG_CalcScreenEffects
;1442:
;1443:Currently just for screen shaking (and music volume management)
;1444:=================
;1445:*/
;1446:void CG_CalcScreenEffects(void)
;1447:{
line 1448
;1448:	CG_SE_UpdateShake(cg.refdef.vieworg, cg.refdefViewAngles);
ADDRGP4 cg+3604+24
ARGP4
ADDRGP4 cg+3972
ARGP4
ADDRGP4 CG_SE_UpdateShake
CALLV
pop
line 1449
;1449:	CG_SE_UpdateMusic();
ADDRGP4 CG_SE_UpdateMusic
CALLV
pop
line 1450
;1450:}
LABELV $1057
endproc CG_CalcScreenEffects 0 8
export CGCam_Shake
proc CGCam_Shake 0 0
line 1453
;1451:
;1452:void CGCam_Shake( float intensity, int duration )
;1453:{
line 1454
;1454:	if ( intensity > MAX_SHAKE_INTENSITY )
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
LEF4 $1062
line 1455
;1455:		intensity = MAX_SHAKE_INTENSITY;
ADDRFP4 0
CNSTF4 1098907648
ASGNF4
LABELV $1062
line 1457
;1456:
;1457:	cgScreenEffects.shake_intensity = intensity;
ADDRGP4 cgScreenEffects+8
ADDRFP4 0
INDIRF4
ASGNF4
line 1458
;1458:	cgScreenEffects.shake_duration = duration;
ADDRGP4 cgScreenEffects+12
ADDRFP4 4
INDIRI4
ASGNI4
line 1459
;1459:	cgScreenEffects.shake_start = cg.time;
ADDRGP4 cgScreenEffects+16
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1460
;1460:}
LABELV $1061
endproc CGCam_Shake 0 0
export CGCam_SetMusicMult
proc CGCam_SetMusicMult 0 0
line 1463
;1461:
;1462:void CGCam_SetMusicMult( float multiplier, int duration )
;1463:{
line 1464
;1464:	if (multiplier < 0.1f)
ADDRFP4 0
INDIRF4
CNSTF4 1036831949
GEF4 $1069
line 1465
;1465:	{
line 1466
;1466:		multiplier = 0.1f;
ADDRFP4 0
CNSTF4 1036831949
ASGNF4
line 1467
;1467:	}
LABELV $1069
line 1469
;1468:
;1469:	if (multiplier > 1.0f)
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
LEF4 $1071
line 1470
;1470:	{
line 1471
;1471:		multiplier = 1.0f;
ADDRFP4 0
CNSTF4 1065353216
ASGNF4
line 1472
;1472:	}
LABELV $1071
line 1474
;1473:
;1474:	cgScreenEffects.music_volume_multiplier = multiplier;
ADDRGP4 cgScreenEffects+20
ADDRFP4 0
INDIRF4
ASGNF4
line 1475
;1475:	cgScreenEffects.music_volume_time = cg.time + duration;
ADDRGP4 cgScreenEffects+24
ADDRGP4 cg+64
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 1476
;1476:	cgScreenEffects.music_volume_set = qfalse;
ADDRGP4 cgScreenEffects+28
CNSTI4 0
ASGNI4
line 1477
;1477:}
LABELV $1068
endproc CGCam_SetMusicMult 0 0
export CG_DrawActiveFrame
proc CG_DrawActiveFrame 36 16
line 1492
;1478:
;1479:/*
;1480:================================
;1481:Screen Effect stuff ends here
;1482:================================
;1483:*/
;1484:
;1485:/*
;1486:=================
;1487:CG_DrawActiveFrame
;1488:
;1489:Generates and draws a game scene and status information at the given time.
;1490:=================
;1491:*/
;1492:void CG_DrawActiveFrame( int serverTime, stereoFrame_t stereoView, qboolean demoPlayback ) {
line 1495
;1493:	int		inwater;
;1494:
;1495:	cg.time = serverTime;
ADDRGP4 cg+64
ADDRFP4 0
INDIRI4
ASGNI4
line 1496
;1496:	cg.demoPlayback = demoPlayback;
ADDRGP4 cg+8
ADDRFP4 8
INDIRI4
ASGNI4
line 1498
;1497:
;1498:	if (cg.snap && ui_myteam.integer != cg.snap->ps.persistant[PERS_TEAM])
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1080
ADDRGP4 ui_myteam+12
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
EQI4 $1080
line 1499
;1499:	{
line 1500
;1500:		trap_Cvar_Set ( "ui_myteam", va("%i", cg.snap->ps.persistant[PERS_TEAM]) );
ADDRGP4 $1086
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1085
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1501
;1501:	}
LABELV $1080
line 1504
;1502:
;1503:	// update cvars
;1504:	CG_UpdateCvars();
ADDRGP4 CG_UpdateCvars
CALLV
pop
line 1508
;1505:
;1506:	// if we are only updating the screen as a loading
;1507:	// pacifier, don't even try to read snapshots
;1508:	if ( cg.infoScreenText[0] != 0 ) {
ADDRGP4 cg+4008
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1088
line 1509
;1509:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 1510
;1510:		return;
ADDRGP4 $1077
JUMPV
LABELV $1088
line 1513
;1511:	}
;1512:
;1513:	trap_FX_AdjustTime( cg.time, cg.refdef.vieworg, cg.refdef.viewaxis );
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cg+3604+24
ARGP4
ADDRGP4 cg+3604+36
ARGP4
ADDRGP4 trap_FX_AdjustTime
CALLV
pop
line 1515
;1514:
;1515:	CG_RunLightStyles();
ADDRGP4 CG_RunLightStyles
CALLV
pop
line 1519
;1516:
;1517:	// any looped sounds will be respecified as entities
;1518:	// are added to the render list
;1519:	trap_S_ClearLoopingSounds(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 1522
;1520:
;1521:	// clear all the render lists
;1522:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 1525
;1523:
;1524:	// set up cg.snap and possibly cg.nextSnap
;1525:	CG_ProcessSnapshots();
ADDRGP4 CG_ProcessSnapshots
CALLV
pop
line 1527
;1526:
;1527:	trap_ROFF_UpdateEntities();
ADDRGP4 trap_ROFF_UpdateEntities
CALLV
pop
line 1531
;1528:
;1529:	// if we haven't received any snapshots yet, all
;1530:	// we can draw is the information screen
;1531:	if ( !cg.snap || ( cg.snap->snapFlags & SNAPFLAG_NOT_ACTIVE ) ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1100
ADDRGP4 cg+36
INDIRP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1096
LABELV $1100
line 1532
;1532:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 1533
;1533:		return;
ADDRGP4 $1077
JUMPV
LABELV $1096
line 1537
;1534:	}
;1535:
;1536:	// let the client system know what our weapon and zoom settings are
;1537:	if (cg.snap && cg.snap->ps.saberLockTime > cg.time)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1101
ADDRGP4 cg+36
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $1101
line 1538
;1538:	{
line 1539
;1539:		trap_SetUserCmdValue( cg.weaponSelect, 0.01, cg.forceSelect, cg.itemSelect );
ADDRGP4 cg+3496
INDIRI4
ARGI4
CNSTF4 1008981770
ARGF4
ADDRGP4 cg+3500
INDIRI4
ARGI4
ADDRGP4 cg+3504
INDIRI4
ARGI4
ADDRGP4 trap_SetUserCmdValue
CALLV
pop
line 1540
;1540:	}
ADDRGP4 $1102
JUMPV
LABELV $1101
line 1541
;1541:	else if (cg.snap && cg.snap->ps.usingATST)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1109
ADDRGP4 cg+36
INDIRP4
CNSTI4 1348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1109
line 1542
;1542:	{
line 1543
;1543:		trap_SetUserCmdValue( cg.weaponSelect, 0.2, cg.forceSelect, cg.itemSelect );
ADDRGP4 cg+3496
INDIRI4
ARGI4
CNSTF4 1045220557
ARGF4
ADDRGP4 cg+3500
INDIRI4
ARGI4
ADDRGP4 cg+3504
INDIRI4
ARGI4
ADDRGP4 trap_SetUserCmdValue
CALLV
pop
line 1544
;1544:	}
ADDRGP4 $1110
JUMPV
LABELV $1109
line 1546
;1545:	else
;1546:	{
line 1547
;1547:		trap_SetUserCmdValue( cg.weaponSelect, cg.zoomSensitivity, cg.forceSelect, cg.itemSelect );
ADDRGP4 cg+3496
INDIRI4
ARGI4
ADDRGP4 cg+4004
INDIRF4
ARGF4
ADDRGP4 cg+3500
INDIRI4
ARGI4
ADDRGP4 cg+3504
INDIRI4
ARGI4
ADDRGP4 trap_SetUserCmdValue
CALLV
pop
line 1548
;1548:	}
LABELV $1110
LABELV $1102
line 1551
;1549:
;1550:	// this counter will be bumped for every valid scene we generate
;1551:	cg.clientFrame++;
ADDRLP4 4
ADDRGP4 cg
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1554
;1552:
;1553:	// update cg.predictedPlayerState
;1554:	CG_PredictPlayerState();
ADDRGP4 CG_PredictPlayerState
CALLV
pop
line 1557
;1555:
;1556:	// decide on third person view
;1557:	cg.renderingThirdPerson = cg_thirdPerson.integer || (cg.snap->ps.stats[STAT_HEALTH] <= 0);
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 cg_thirdPerson+12
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1126
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
GTI4 $1124
LABELV $1126
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $1125
JUMPV
LABELV $1124
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1125
ADDRGP4 cg+88
ADDRLP4 8
INDIRI4
ASGNI4
line 1559
;1558:
;1559:	if (cg.snap->ps.stats[STAT_HEALTH] > 0 && (cg.predictedPlayerState.weapon == WP_SABER || cg.predictedPlayerState.usingATST ||
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
LEI4 $1127
ADDRGP4 cg+96+148
INDIRI4
CNSTI4 2
EQI4 $1140
ADDRGP4 cg+96+1304
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $1140
ADDRGP4 cg+96+1236
INDIRI4
CNSTI4 8
EQI4 $1140
ADDRGP4 cg+96+1340
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1127
LABELV $1140
line 1561
;1560:		cg.predictedPlayerState.forceHandExtend == HANDEXTEND_KNOCKDOWN || cg.predictedPlayerState.fallingToDeath))
;1561:	{
line 1562
;1562:		cg.renderingThirdPerson = 1;
ADDRGP4 cg+88
CNSTI4 1
ASGNI4
line 1563
;1563:	}
ADDRGP4 $1128
JUMPV
LABELV $1127
line 1564
;1564:	else if (cg.snap->ps.zoomMode)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1364
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1142
line 1565
;1565:	{ //always force first person when zoomed
line 1566
;1566:		cg.renderingThirdPerson = 0;
ADDRGP4 cg+88
CNSTI4 0
ASGNI4
line 1567
;1567:	}
LABELV $1142
LABELV $1128
line 1570
;1568:
;1569:	// build cg.refdef
;1570:	inwater = CG_CalcViewValues();
ADDRLP4 20
ADDRGP4 CG_CalcViewValues
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 1572
;1571:
;1572:	CG_CalcScreenEffects();
ADDRGP4 CG_CalcScreenEffects
CALLV
pop
line 1575
;1573:
;1574:	// first person blend blobs, done after AnglesToAxis
;1575:	if ( !cg.renderingThirdPerson ) {
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $1146
line 1576
;1576:		CG_DamageBlendBlob();
ADDRGP4 CG_DamageBlendBlob
CALLV
pop
line 1577
;1577:	}
LABELV $1146
line 1580
;1578:
;1579:	// build the render lists
;1580:	if ( !cg.hyperspace ) {
ADDRGP4 cg+92
INDIRI4
CNSTI4 0
NEI4 $1149
line 1581
;1581:		CG_AddPacketEntities();			// adter calcViewValues, so predicted player state is correct
ADDRGP4 CG_AddPacketEntities
CALLV
pop
line 1582
;1582:		CG_AddMarks();
ADDRGP4 CG_AddMarks
CALLV
pop
line 1583
;1583:		CG_AddParticles ();
ADDRGP4 CG_AddParticles
CALLV
pop
line 1584
;1584:		CG_AddLocalEntities();
ADDRGP4 CG_AddLocalEntities
CALLV
pop
line 1585
;1585:	}
LABELV $1149
line 1586
;1586:	CG_AddViewWeapon( &cg.predictedPlayerState );
ADDRGP4 cg+96
ARGP4
ADDRGP4 CG_AddViewWeapon
CALLV
pop
line 1588
;1587:
;1588:	if ( !cg.hyperspace) 
ADDRGP4 cg+92
INDIRI4
CNSTI4 0
NEI4 $1153
line 1589
;1589:	{
line 1590
;1590:		trap_FX_AddScheduledEffects();
ADDRGP4 trap_FX_AddScheduledEffects
CALLV
pop
line 1591
;1591:	}
LABELV $1153
line 1594
;1592:
;1593:	// add buffered sounds
;1594:	CG_PlayBufferedSounds();
ADDRGP4 CG_PlayBufferedSounds
CALLV
pop
line 1597
;1595:
;1596:	// play buffered voice chats
;1597:	CG_PlayBufferedVoiceChats();
ADDRGP4 CG_PlayBufferedVoiceChats
CALLV
pop
line 1600
;1598:
;1599:	// finish up the rest of the refdef
;1600:	if ( cg.testModelEntity.hModel ) {
ADDRGP4 cg+13472+8
INDIRI4
CNSTI4 0
EQI4 $1156
line 1601
;1601:		CG_AddTestModel();
ADDRGP4 CG_AddTestModel
CALLV
pop
line 1602
;1602:	}
LABELV $1156
line 1603
;1603:	cg.refdef.time = cg.time;
ADDRGP4 cg+3604+72
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1604
;1604:	memcpy( cg.refdef.areamask, cg.snap->areamask, sizeof( cg.refdef.areamask ) );
ADDRGP4 cg+3604+80
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1607
;1605:
;1606:	// warning sounds when powerup is wearing off
;1607:	CG_PowerupTimerSounds();
ADDRGP4 CG_PowerupTimerSounds
CALLV
pop
line 1610
;1608:
;1609:	// if there are any entities flagged as sound trackers and attached to other entities, update their sound pos
;1610:	CG_UpdateSoundTrackers();
ADDRGP4 CG_UpdateSoundTrackers
CALLV
pop
line 1612
;1611:
;1612:	if (gCGHasFallVector)
ADDRGP4 gCGHasFallVector
INDIRI4
CNSTI4 0
EQI4 $1168
line 1613
;1613:	{
line 1616
;1614:		vec3_t lookAng;
;1615:
;1616:		VectorSubtract(cg.snap->ps.origin, cg.refdef.vieworg, lookAng);
ADDRLP4 24
ADDRGP4 cg+36
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRGP4 cg+3604+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRGP4 cg+36
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 cg+3604+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRGP4 cg+36
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRGP4 cg+3604+24+8
INDIRF4
SUBF4
ASGNF4
line 1617
;1617:		VectorNormalize(lookAng);
ADDRLP4 24
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1618
;1618:		vectoangles(lookAng, lookAng);
ADDRLP4 24
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1620
;1619:
;1620:		VectorCopy(gCGFallVector, cg.refdef.vieworg);
ADDRGP4 cg+3604+24
ADDRGP4 gCGFallVector
INDIRB
ASGNB 12
line 1621
;1621:		AnglesToAxis(lookAng, cg.refdef.viewaxis);
ADDRLP4 24
ARGP4
ADDRGP4 cg+3604+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1622
;1622:	}
LABELV $1168
line 1625
;1623:
;1624:	// update audio positions
;1625:	trap_S_Respatialize( cg.snap->ps.clientNum, cg.refdef.vieworg, cg.refdef.viewaxis, inwater );
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+3604+24
ARGP4
ADDRGP4 cg+3604+36
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_S_Respatialize
CALLV
pop
line 1628
;1626:
;1627:	// make sure the lagometerSample and frame timing isn't done twice when in stereo
;1628:	if ( stereoView != STEREO_RIGHT ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
EQI4 $1192
line 1629
;1629:		cg.frametime = cg.time - cg.oldTime;
ADDRGP4 cg+60
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+68
INDIRI4
SUBI4
ASGNI4
line 1630
;1630:		if ( cg.frametime < 0 ) {
ADDRGP4 cg+60
INDIRI4
CNSTI4 0
GEI4 $1197
line 1631
;1631:			cg.frametime = 0;
ADDRGP4 cg+60
CNSTI4 0
ASGNI4
line 1632
;1632:		}
LABELV $1197
line 1633
;1633:		cg.oldTime = cg.time;
ADDRGP4 cg+68
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1634
;1634:		CG_AddLagometerFrameInfo();
ADDRGP4 CG_AddLagometerFrameInfo
CALLV
pop
line 1635
;1635:	}
LABELV $1192
line 1636
;1636:	if (cg_timescale.value != cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
EQF4 $1203
line 1637
;1637:		if (cg_timescale.value < cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
GEF4 $1207
line 1638
;1638:			cg_timescale.value += cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
ADDRLP4 24
ADDRGP4 cg_timescale+8
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
ADDRGP4 cg+60
INDIRI4
CVIF4 4
MULF4
CNSTF4 1148846080
DIVF4
ADDF4
ASGNF4
line 1639
;1639:			if (cg_timescale.value > cg_timescaleFadeEnd.value)
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
LEF4 $1208
line 1640
;1640:				cg_timescale.value = cg_timescaleFadeEnd.value;
ADDRGP4 cg_timescale+8
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
ASGNF4
line 1641
;1641:		}
ADDRGP4 $1208
JUMPV
LABELV $1207
line 1642
;1642:		else {
line 1643
;1643:			cg_timescale.value -= cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
ADDRLP4 24
ADDRGP4 cg_timescale+8
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
ADDRGP4 cg+60
INDIRI4
CVIF4 4
MULF4
CNSTF4 1148846080
DIVF4
SUBF4
ASGNF4
line 1644
;1644:			if (cg_timescale.value < cg_timescaleFadeEnd.value)
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
GEF4 $1223
line 1645
;1645:				cg_timescale.value = cg_timescaleFadeEnd.value;
ADDRGP4 cg_timescale+8
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
ASGNF4
LABELV $1223
line 1646
;1646:		}
LABELV $1208
line 1647
;1647:		if (cg_timescaleFadeSpeed.value) {
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
CNSTF4 0
EQF4 $1229
line 1648
;1648:			trap_Cvar_Set("timescale", va("%f", cg_timescale.value));
ADDRGP4 $1043
ARGP4
ADDRGP4 cg_timescale+8
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1232
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1649
;1649:		}
LABELV $1229
line 1650
;1650:	}
LABELV $1203
line 1653
;1651:
;1652:	// actually issue the rendering calls
;1653:	CG_DrawActive( stereoView );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawActive
CALLV
pop
line 1655
;1654:
;1655:	if ( cg_stats.integer ) {
ADDRGP4 cg_stats+12
INDIRI4
CNSTI4 0
EQI4 $1234
line 1656
;1656:		CG_Printf( "cg.clientFrame:%i\n", cg.clientFrame );
ADDRGP4 $1237
ARGP4
ADDRGP4 cg
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1657
;1657:	}
LABELV $1234
line 1658
;1658:}
LABELV $1077
endproc CG_DrawActiveFrame 36 16
bss
export zoomFov
align 4
LABELV zoomFov
skip 4
import gCGFallVector
import gCGHasFallVector
export cameraIdealLoc
align 4
LABELV cameraIdealLoc
skip 12
export cameraIdealTarget
align 4
LABELV cameraIdealTarget
skip 12
export cameraFocusLoc
align 4
LABELV cameraFocusLoc
skip 12
export cameraFocusAngles
align 4
LABELV cameraFocusAngles
skip 12
export cameraup
align 4
LABELV cameraup
skip 12
export camerafwd
align 4
LABELV camerafwd
skip 12
import CG_SetLightstyle
import CG_RunLightStyles
import CG_ClearLightStyles
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
export cgScreenEffects
align 4
LABELV cgScreenEffects
skip 32
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
LABELV $1237
char 1 99
char 1 103
char 1 46
char 1 99
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 70
char 1 114
char 1 97
char 1 109
char 1 101
char 1 58
char 1 37
char 1 105
char 1 10
char 1 0
align 1
LABELV $1232
char 1 116
char 1 105
char 1 109
char 1 101
char 1 115
char 1 99
char 1 97
char 1 108
char 1 101
char 1 0
align 1
LABELV $1086
char 1 37
char 1 105
char 1 0
align 1
LABELV $1085
char 1 117
char 1 105
char 1 95
char 1 109
char 1 121
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $1045
char 1 115
char 1 95
char 1 109
char 1 117
char 1 115
char 1 105
char 1 99
char 1 77
char 1 117
char 1 108
char 1 116
char 1 0
align 1
LABELV $1043
char 1 37
char 1 102
char 1 0
align 1
LABELV $277
char 1 49
char 1 48
char 1 48
char 1 0
align 1
LABELV $273
char 1 51
char 1 48
char 1 0
align 1
LABELV $272
char 1 99
char 1 103
char 1 95
char 1 118
char 1 105
char 1 101
char 1 119
char 1 115
char 1 105
char 1 122
char 1 101
char 1 0
align 1
LABELV $198
char 1 115
char 1 107
char 1 105
char 1 110
char 1 32
char 1 37
char 1 105
char 1 10
char 1 0
align 1
LABELV $181
char 1 102
char 1 114
char 1 97
char 1 109
char 1 101
char 1 32
char 1 37
char 1 105
char 1 10
char 1 0
align 1
LABELV $142
char 1 67
char 1 97
char 1 110
char 1 39
char 1 116
char 1 32
char 1 114
char 1 101
char 1 103
char 1 105
char 1 115
char 1 116
char 1 101
char 1 114
char 1 32
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 10
char 1 0
