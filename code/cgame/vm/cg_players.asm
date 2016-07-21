data
export cg_customSoundNames
align 4
LABELV cg_customSoundNames
address $120
address $121
address $122
address $123
address $124
address $125
address $126
address $127
address $128
address $129
address $130
address $131
address $132
address $133
address $128
address $134
skip 64
export CG_CustomSound
code
proc CG_CustomSound 16 8
file "../cg_players.c"
line 35
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_players.c -- handle the media and animation for player entities
;4:#include "cg_local.h"
;5:#include "..\ghoul2\g2.h"
;6:
;7:extern stringID_table_t animTable [MAX_ANIMATIONS+1];
;8:
;9:char	*cg_customSoundNames[MAX_CUSTOM_SOUNDS] = {
;10:	"*death1.wav",
;11:	"*death2.wav",
;12:	"*death3.wav",
;13:	"*jump1.wav",
;14:	"*pain25.wav",
;15:	"*pain50.wav",
;16:	"*pain75.wav",
;17:	"*pain100.wav",
;18:	"*falling1.wav",
;19:	"*choke1.wav",
;20:	"*choke2.wav",
;21:	"*choke3.wav",
;22:	"*gasp.wav",
;23:	"*land1.wav",
;24:	"*falling1.wav",
;25:	"*taunt.wav"
;26:};
;27:
;28:
;29:/*
;30:================
;31:CG_CustomSound
;32:
;33:================
;34:*/
;35:sfxHandle_t	CG_CustomSound( int clientNum, const char *soundName ) {
line 39
;36:	clientInfo_t *ci;
;37:	int			i;
;38:
;39:	if ( soundName[0] != '*' ) {
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $136
line 40
;40:		return trap_S_RegisterSound( soundName );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $135
JUMPV
LABELV $136
line 43
;41:	}
;42:
;43:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $140
ADDRLP4 8
INDIRI4
CNSTI4 32
LTI4 $138
LABELV $140
line 44
;44:		clientNum = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 45
;45:	}
LABELV $138
line 46
;46:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 4
CNSTI4 788
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 48
;47:
;48:	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS && cg_customSoundNames[i] ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $145
JUMPV
LABELV $142
line 49
;49:		if ( !strcmp( soundName, cg_customSoundNames[i] ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $146
line 50
;50:			return ci->sounds[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 652
ADDP4
ADDP4
INDIRI4
RETI4
ADDRGP4 $135
JUMPV
LABELV $146
line 52
;51:		}
;52:	}
LABELV $143
line 48
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $145
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $148
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $142
LABELV $148
line 54
;53:
;54:	CG_Error( "Unknown custom sound: %s", soundName );
ADDRGP4 $149
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 55
;55:	return 0;
CNSTI4 0
RETI4
LABELV $135
endproc CG_CustomSound 16 8
export CG_NeedAnimSequence
proc CG_NeedAnimSequence 12 0
line 79
;56:}
;57:
;58:
;59:
;60:/*
;61:=============================================================================
;62:
;63:CLIENT INFO
;64:
;65:=============================================================================
;66:*/
;67:
;68:/*
;69:==========================
;70:CG_NeedAnimSequence
;71:
;72:Called to check if models are missing required animation sequences
;73:We do not list all used animations here but this check should eliminate
;74:a broad range of unsupported models. At least the ones that are included,
;75:which is all we really care about.
;76:==========================
;77:*/
;78:qboolean CG_NeedAnimSequence(int anim)
;79:{
line 80
;80:	if (anim >= BOTH_DEATH1 &&
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $151
ADDRLP4 0
INDIRI4
CNSTI4 20
GTI4 $151
line 82
;81:		anim <= BOTH_DEATH19)
;82:	{
line 83
;83:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $150
JUMPV
LABELV $151
line 86
;84:	}
;85:
;86:	if (anim >= BOTH_DISMEMBER_HEAD1 &&
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 80
LTI4 $153
ADDRLP4 4
INDIRI4
CNSTI4 85
GTI4 $153
line 88
;87:		anim <= BOTH_DISMEMBER_LARM)
;88:	{
line 89
;89:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $150
JUMPV
LABELV $153
line 92
;90:	}
;91:
;92:	if (anim >= BOTH_A1_T__B_ &&
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 126
LTI4 $155
ADDRLP4 8
INDIRI4
CNSTI4 535
GTI4 $155
line 94
;93:		anim <= BOTH_H1_S1_BR)
;94:	{
line 95
;95:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $150
JUMPV
LABELV $155
line 98
;96:	}
;97:
;98:	return qfalse;
CNSTI4 0
RETI4
LABELV $150
endproc CG_NeedAnimSequence 12 0
lit
align 4
LABELV $158
byte 4 0
byte 4 0
byte 4 0
code
proc CG_RegisterClientModelname 276 44
line 106
;99:}
;100:
;101:/*
;102:==========================
;103:CG_RegisterClientModelname
;104:==========================
;105:*/
;106:static qboolean CG_RegisterClientModelname( clientInfo_t *ci, const char *modelName, const char *skinName, const char *teamName, int clientNum ) {
line 111
;107:	int handle;
;108:	char		afilename[MAX_QPATH];
;109:	char		/**GLAName,*/ *slash;
;110:	char		GLAName[MAX_QPATH];
;111:	vec3_t	tempVec = {0,0,0};
ADDRLP4 68
ADDRGP4 $158
INDIRB
ASGNB 12
line 112
;112:	qboolean badModel = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 113
;113:	qboolean retriedAlready = qfalse;
ADDRLP4 148
CNSTI4 0
ASGNI4
LABELV $159
line 115
;114:retryModel:
;115:	if (ci->ATST && clientNum == -1)
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
CNSTI4 0
EQI4 $160
ADDRFP4 16
INDIRI4
CNSTI4 -1
NEI4 $160
line 116
;116:	{
line 117
;117:		Com_sprintf(ci->teamName, sizeof(ci->teamName), teamName);
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 118
;118:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $157
JUMPV
LABELV $160
line 121
;119:	}
;120:
;121:	if (badModel)
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $162
line 122
;122:	{
line 123
;123:		modelName = "kyle";
ADDRFP4 4
ADDRGP4 $164
ASGNP4
line 124
;124:		skinName = "default";
ADDRFP4 8
ADDRGP4 $165
ASGNP4
line 125
;125:		Com_Printf("WARNING: Attempted to load an unsupported multiplayer model! (bad or missing bone, or missing animation sequence)\n");
ADDRGP4 $166
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 127
;126:
;127:		badModel = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 128
;128:		retriedAlready = qtrue;
ADDRLP4 148
CNSTI4 1
ASGNI4
line 129
;129:	}
LABELV $162
line 132
;130:
;131:	// First things first.  If this is a ghoul2 model, then let's make sure we demolish this first.
;132:	if (ci->ghoul2Model && trap_G2_HaveWeGhoul2Models(ci->ghoul2Model))
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $167
ADDRLP4 156
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $167
line 133
;133:	{
line 134
;134:		trap_G2API_CleanGhoul2Models(&(ci->ghoul2Model));
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 135
;135:	}
LABELV $167
line 137
;136:
;137:	if (cgs.gametype >= GT_TEAM)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $169
line 138
;138:	{
line 139
;139:		if (ci->team == TEAM_RED)
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $172
line 140
;140:		{
line 141
;141:			Com_sprintf(ci->skinName, sizeof(ci->skinName), "red");
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $174
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 142
;142:			skinName = "red";
ADDRFP4 8
ADDRGP4 $174
ASGNP4
line 143
;143:		}
ADDRGP4 $173
JUMPV
LABELV $172
line 144
;144:		else if (ci->team == TEAM_BLUE)
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $175
line 145
;145:		{
line 146
;146:			Com_sprintf(ci->skinName, sizeof(ci->skinName), "blue");
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $177
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 147
;147:			skinName = "blue";
ADDRFP4 8
ADDRGP4 $177
ASGNP4
line 148
;148:		}
LABELV $175
LABELV $173
line 149
;149:	}
LABELV $169
line 151
;150:
;151:	if (clientNum != -1 && cg_entities[clientNum].currentState.teamowner && !cg_entities[clientNum].isATST)
ADDRLP4 164
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 -1
EQI4 $178
ADDRLP4 168
CNSTI4 1920
ADDRLP4 164
INDIRI4
MULI4
ASGNI4
ADDRLP4 172
CNSTI4 0
ASGNI4
ADDRLP4 168
INDIRI4
ADDRGP4 cg_entities+264
ADDP4
INDIRI4
ADDRLP4 172
INDIRI4
EQI4 $178
ADDRLP4 168
INDIRI4
ADDRGP4 cg_entities+1028
ADDP4
INDIRI4
ADDRLP4 172
INDIRI4
NEI4 $178
line 152
;152:	{
line 153
;153:		handle = trap_G2API_InitGhoul2Model(&ci->ghoul2Model, "models/players/atst/model.glm", 0, 0, 0, 0, 0);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
ARGP4
ADDRGP4 $182
ARGP4
ADDRLP4 176
CNSTI4 0
ASGNI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 trap_G2API_InitGhoul2Model
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 180
INDIRI4
ASGNI4
line 154
;154:	}
ADDRGP4 $179
JUMPV
LABELV $178
line 156
;155:	else
;156:	{
line 157
;157:		Com_sprintf( afilename, sizeof( afilename ), "models/players/%s/model.glm", modelName );
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $183
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 158
;158:		handle = trap_G2API_InitGhoul2Model(&ci->ghoul2Model, afilename, 0, trap_R_RegisterSkin(va("models/players/%s/model_%s.skin", modelName, skinName)), 0, 0, 0);
ADDRGP4 $184
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 184
CNSTI4 0
ASGNI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 180
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 188
ADDRGP4 trap_G2API_InitGhoul2Model
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 188
INDIRI4
ASGNI4
line 159
;159:	}
LABELV $179
line 160
;160:	if (handle<0)
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $185
line 161
;161:	{
line 162
;162:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $157
JUMPV
LABELV $185
line 165
;163:	}
;164:
;165:	if (clientNum != -1 && cg_entities[clientNum].currentState.teamowner && !cg_entities[clientNum].isATST)
ADDRLP4 176
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 -1
EQI4 $187
ADDRLP4 180
CNSTI4 1920
ADDRLP4 176
INDIRI4
MULI4
ASGNI4
ADDRLP4 184
CNSTI4 0
ASGNI4
ADDRLP4 180
INDIRI4
ADDRGP4 cg_entities+264
ADDP4
INDIRI4
ADDRLP4 184
INDIRI4
EQI4 $187
ADDRLP4 180
INDIRI4
ADDRGP4 cg_entities+1028
ADDP4
INDIRI4
ADDRLP4 184
INDIRI4
NEI4 $187
line 166
;166:	{
line 167
;167:		ci->torsoSkin = 0;
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
CNSTI4 0
ASGNI4
line 168
;168:		ci->ATST = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 1
ASGNI4
line 169
;169:	}
ADDRGP4 $188
JUMPV
LABELV $187
line 171
;170:	else
;171:	{
line 172
;172:		ci->torsoSkin = trap_R_RegisterSkin(va("models/players/%s/model_%s.skin", modelName, skinName));
ADDRGP4 $184
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 188
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
ADDRLP4 192
INDIRI4
ASGNI4
line 173
;173:		ci->ATST = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 0
ASGNI4
line 174
;174:	}
LABELV $188
line 178
;175:
;176:	// The model is now loaded.
;177:
;178:	GLAName[0] = 0;
ADDRLP4 80
CNSTI1 0
ASGNI1
line 180
;179:
;180:	if (!BGPAFtextLoaded)
ADDRGP4 BGPAFtextLoaded
INDIRI4
CNSTI4 0
NEI4 $191
line 181
;181:	{
line 182
;182:		trap_G2API_GetGLAName( ci->ghoul2Model, 0, GLAName);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 80
ARGP4
ADDRGP4 trap_G2API_GetGLAName
CALLV
pop
line 183
;183:		if (GLAName[0] == 0/*GLAName == NULL*/)
ADDRLP4 80
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $193
line 184
;184:		{
line 185
;185:			if (!BG_ParseAnimationFile("models/players/_humanoid/animation.cfg"))
ADDRGP4 $197
ARGP4
ADDRLP4 188
ADDRGP4 BG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
NEI4 $195
line 186
;186:			{
line 187
;187:				Com_Printf( "Failed to load animation file %s\n", afilename );
ADDRGP4 $198
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 188
;188:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $157
JUMPV
LABELV $195
line 190
;189:			}
;190:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $157
JUMPV
LABELV $193
line 192
;191:		}
;192:		Q_strncpyz( afilename, GLAName, sizeof( afilename ));
ADDRLP4 4
ARGP4
ADDRLP4 80
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 193
;193:		slash = Q_strrchr( afilename, '/' );
ADDRLP4 4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 188
ADDRGP4 Q_strrchr
CALLP4
ASGNP4
ADDRLP4 152
ADDRLP4 188
INDIRP4
ASGNP4
line 194
;194:		if ( slash )
ADDRLP4 152
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $199
line 195
;195:		{
line 196
;196:			strcpy(slash, "/animation.cfg");
ADDRLP4 152
INDIRP4
ARGP4
ADDRGP4 $201
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 197
;197:		}	// Now afilename holds just the path to the animation.cfg
ADDRGP4 $200
JUMPV
LABELV $199
line 199
;198:		else 
;199:		{	// Didn't find any slashes, this is a raw filename right in base (whish isn't a good thing)
line 200
;200:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $157
JUMPV
LABELV $200
line 216
;201:		}
;202:
;203:		/*
;204:		// Try to load the animation.cfg for this model then.
;205:		if ( !BG_ParseAnimationFile( afilename, ci->animations ) )
;206:		{	// The GLA's animations failed
;207:			if (!BG_ParseAnimationFile("models/players/_humanoid/animation.cfg", ci->animations))
;208:			{
;209:				Com_Printf( "Failed to load animation file %s\n", afilename );
;210:				return qfalse;
;211:			}
;212:		}
;213:		*/
;214:		//rww - For now, we'll just ignore what animation file it wants. In theory all multiplayer-supported models
;215:		//should want _humanoid/animation.cfg, so if it doesn't want that then throw it away
;216:		if (Q_stricmp(afilename, "models/players/_humanoid/animation.cfg"))
ADDRLP4 4
ARGP4
ADDRGP4 $197
ARGP4
ADDRLP4 192
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $202
line 217
;217:		{
line 218
;218:			Com_Printf( "Model does not use supported animation config.\n");
ADDRGP4 $204
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 219
;219:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $157
JUMPV
LABELV $202
line 221
;220:		}
;221:		else if (!BG_ParseAnimationFile("models/players/_humanoid/animation.cfg"))
ADDRGP4 $197
ARGP4
ADDRLP4 196
ADDRGP4 BG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
NEI4 $205
line 222
;222:		{
line 223
;223:			Com_Printf( "Failed to load animation file models/players/_humanoid/animation.cfg\n" );
ADDRGP4 $207
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 224
;224:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $157
JUMPV
LABELV $205
line 226
;225:		}
;226:		else if (!retriedAlready)
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $208
line 227
;227:		{
line 230
;228:			int i;
;229:
;230:			for(i = 0; i < MAX_ANIMATIONS; i++)
ADDRLP4 200
CNSTI4 0
ASGNI4
LABELV $210
line 231
;231:			{
line 232
;232:				if (!bgGlobalAnimations[i].firstFrame && !bgGlobalAnimations[i].numFrames && CG_NeedAnimSequence(i))
ADDRLP4 208
CNSTI4 28
ADDRLP4 200
INDIRI4
MULI4
ASGNI4
ADDRLP4 212
CNSTI4 0
ASGNI4
ADDRLP4 208
INDIRI4
ADDRGP4 bgGlobalAnimations
ADDP4
INDIRI4
ADDRLP4 212
INDIRI4
NEI4 $214
ADDRLP4 208
INDIRI4
ADDRGP4 bgGlobalAnimations+4
ADDP4
INDIRI4
ADDRLP4 212
INDIRI4
NEI4 $214
ADDRLP4 200
INDIRI4
ARGI4
ADDRLP4 216
ADDRGP4 CG_NeedAnimSequence
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
EQI4 $214
line 233
;233:				{ //using default for this animation so it obviously never got filled in.
line 235
;234:					//if it's a sequence that we need, this model must be an unsupported one.
;235:					badModel = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 236
;236:					goto retryModel;
ADDRGP4 $159
JUMPV
LABELV $214
line 238
;237:				}
;238:			}
LABELV $211
line 230
ADDRLP4 200
ADDRLP4 200
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 1089
LTI4 $210
line 239
;239:		}
LABELV $208
line 240
;240:	}
LABELV $191
line 242
;241:
;242:	if (clientNum != -1 && cg_entities[clientNum].currentState.teamowner && !cg_entities[clientNum].isATST)
ADDRLP4 188
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 -1
EQI4 $217
ADDRLP4 192
CNSTI4 1920
ADDRLP4 188
INDIRI4
MULI4
ASGNI4
ADDRLP4 196
CNSTI4 0
ASGNI4
ADDRLP4 192
INDIRI4
ADDRGP4 cg_entities+264
ADDP4
INDIRI4
ADDRLP4 196
INDIRI4
EQI4 $217
ADDRLP4 192
INDIRI4
ADDRGP4 cg_entities+1028
ADDP4
INDIRI4
ADDRLP4 196
INDIRI4
NEI4 $217
line 243
;243:	{
line 244
;244:		ci->torsoSkin = 0;
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
CNSTI4 0
ASGNI4
line 245
;245:		ci->bolt_rhand = trap_G2API_AddBolt(ci->ghoul2Model, 0, "*flash1");
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $221
ARGP4
ADDRLP4 204
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 200
INDIRP4
CNSTI4 512
ADDP4
ADDRLP4 204
INDIRI4
ASGNI4
line 246
;246:		trap_G2API_SetBoneAnim(ci->ghoul2Model, 0, "Model_root", 0, 12, BONE_ANIM_OVERRIDE_LOOP, 1.0f, cg.time, -1, -1);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 $222
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTI4 16
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
CNSTI4 -1
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 247
;247:		trap_G2API_SetBoneAngles(ci->ghoul2Model, 0, "l_clavical", tempVec, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, NULL, 0, cg.time);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 212
CNSTI4 0
ASGNI4
ADDRLP4 212
INDIRI4
ARGI4
ADDRGP4 $224
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
CNSTI4 6
ARGI4
CNSTI4 5
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 212
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 248
;248:		trap_G2API_SetBoneAngles(ci->ghoul2Model, 0, "r_clavical", tempVec, BONE_ANGLES_POSTMULT, POSITIVE_Z, NEGATIVE_Y, POSITIVE_X, NULL, 0, cg.time);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 216
CNSTI4 0
ASGNI4
ADDRLP4 216
INDIRI4
ARGI4
ADDRGP4 $226
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 220
CNSTI4 2
ASGNI4
ADDRLP4 220
INDIRI4
ARGI4
ADDRLP4 220
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTI4 1
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 216
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 250
;249:
;250:		ci->bolt_lhand = trap_G2API_AddBolt(ci->ghoul2Model, 0, "*flash2");
ADDRLP4 224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 224
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $228
ARGP4
ADDRLP4 228
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 224
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 228
INDIRI4
ASGNI4
line 251
;251:		ci->bolt_head = trap_G2API_AddBolt(ci->ghoul2Model, 0, "pelvis");
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 232
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $229
ARGP4
ADDRLP4 236
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 232
INDIRP4
CNSTI4 520
ADDP4
ADDRLP4 236
INDIRI4
ASGNI4
line 252
;252:	}
ADDRGP4 $218
JUMPV
LABELV $217
line 254
;253:	else
;254:	{
line 255
;255:		ci->bolt_rhand = trap_G2API_AddBolt(ci->ghoul2Model, 0, "*r_hand");
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $230
ARGP4
ADDRLP4 204
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 200
INDIRP4
CNSTI4 512
ADDP4
ADDRLP4 204
INDIRI4
ASGNI4
line 257
;256:		
;257:		if (!trap_G2API_SetBoneAnim(ci->ghoul2Model, 0, "model_root", 0, 12, BONE_ANIM_OVERRIDE_LOOP, 1.0f, cg.time, -1, -1))
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTI4 16
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
CNSTI4 -1
ARGI4
ADDRLP4 212
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
NEI4 $231
line 258
;258:		{
line 259
;259:			badModel = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 260
;260:		}
LABELV $231
line 262
;261:		
;262:		if (!trap_G2API_SetBoneAngles(ci->ghoul2Model, 0, "upper_lumbar", tempVec, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, NULL, 0, cg.time))
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 216
CNSTI4 0
ASGNI4
ADDRLP4 216
INDIRI4
ARGI4
ADDRGP4 $237
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
CNSTI4 6
ARGI4
CNSTI4 5
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 216
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 220
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 0
NEI4 $235
line 263
;263:		{
line 264
;264:			badModel = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 265
;265:		}
LABELV $235
line 267
;266:
;267:		if (!trap_G2API_SetBoneAngles(ci->ghoul2Model, 0, "cranium", tempVec, BONE_ANGLES_POSTMULT, POSITIVE_Z, NEGATIVE_Y, POSITIVE_X, NULL, 0, cg.time))
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 224
CNSTI4 0
ASGNI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRGP4 $241
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 228
CNSTI4 2
ASGNI4
ADDRLP4 228
INDIRI4
ARGI4
ADDRLP4 228
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTI4 1
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 224
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 232
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
NEI4 $239
line 268
;268:		{
line 269
;269:			badModel = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 270
;270:		}
LABELV $239
line 272
;271:
;272:		ci->bolt_lhand = trap_G2API_AddBolt(ci->ghoul2Model, 0, "*l_hand");
ADDRLP4 236
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 236
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $243
ARGP4
ADDRLP4 240
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 236
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 240
INDIRI4
ASGNI4
line 273
;273:		ci->bolt_head = trap_G2API_AddBolt(ci->ghoul2Model, 0, "*head_top");
ADDRLP4 244
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 244
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $244
ARGP4
ADDRLP4 248
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 244
INDIRP4
CNSTI4 520
ADDP4
ADDRLP4 248
INDIRI4
ASGNI4
line 275
;274:
;275:		ci->bolt_motion = trap_G2API_AddBolt(ci->ghoul2Model, 0, "Motion");
ADDRLP4 252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $245
ARGP4
ADDRLP4 256
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 252
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 278
;276:
;277:		//We need a lower lumbar bolt for footsteps
;278:		ci->bolt_llumbar = trap_G2API_AddBolt(ci->ghoul2Model, 0, "lower_lumbar");
ADDRLP4 260
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 260
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $246
ARGP4
ADDRLP4 264
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 260
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 280
;279:
;280:		if (ci->bolt_rhand == -1 || ci->bolt_lhand == -1 || ci->bolt_head == -1 || ci->bolt_motion == -1 || ci->bolt_llumbar == -1)
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
CNSTI4 -1
ASGNI4
ADDRLP4 268
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ADDRLP4 272
INDIRI4
EQI4 $252
ADDRLP4 268
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
ADDRLP4 272
INDIRI4
EQI4 $252
ADDRLP4 268
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRLP4 272
INDIRI4
EQI4 $252
ADDRLP4 268
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
ADDRLP4 272
INDIRI4
EQI4 $252
ADDRLP4 268
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRLP4 272
INDIRI4
NEI4 $247
LABELV $252
line 281
;281:		{
line 282
;282:			badModel = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 283
;283:		}
LABELV $247
line 285
;284:
;285:		if (badModel)
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $253
line 286
;286:		{
line 287
;287:			goto retryModel;
ADDRGP4 $159
JUMPV
LABELV $253
line 289
;288:		}
;289:	}
LABELV $218
line 293
;290:
;291://	ent->s.radius = 90;
;292:
;293:	if (clientNum != -1)
ADDRFP4 16
INDIRI4
CNSTI4 -1
EQI4 $255
line 294
;294:	{
line 295
;295:		if (cg_entities[clientNum].isATST)
CNSTI4 1920
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cg_entities+1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $257
line 296
;296:		{
line 299
;297:			animation_t *anim;
;298:
;299:			anim = &bgGlobalAnimations[ (cg_entities[clientNum].currentState.legsAnim & ~ANIM_TOGGLEBIT) ];
ADDRLP4 200
CNSTI4 28
CNSTI4 1920
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cg_entities+280
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
MULI4
ADDRGP4 bgGlobalAnimations
ADDP4
ASGNP4
line 301
;300:
;301:			if (anim)
ADDRLP4 200
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $261
line 302
;302:			{
line 303
;303:				int flags = BONE_ANIM_OVERRIDE_FREEZE;
ADDRLP4 204
CNSTI4 72
ASGNI4
line 304
;304:				int firstFrame = anim->firstFrame + anim->numFrames-1;
ADDRLP4 212
ADDRLP4 200
INDIRP4
ASGNP4
ADDRLP4 208
ADDRLP4 212
INDIRP4
INDIRI4
ADDRLP4 212
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 306
;305:
;306:				if (anim->loopFrames != -1)
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $263
line 307
;307:				{
line 308
;308:					flags = BONE_ANIM_OVERRIDE_LOOP;
ADDRLP4 204
CNSTI4 16
ASGNI4
line 309
;309:					firstFrame = anim->firstFrame;
ADDRLP4 208
ADDRLP4 200
INDIRP4
INDIRI4
ASGNI4
line 310
;310:				}
LABELV $263
line 313
;311:
;312:				//rww - Set the animation again because it just got reset due to the model change
;313:				trap_G2API_SetBoneAnim(ci->ghoul2Model, 0, "model_root", firstFrame, anim->firstFrame + anim->numFrames, flags, 1.0f, cg.time, -1, 150);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRLP4 216
ADDRLP4 200
INDIRP4
ASGNP4
ADDRLP4 216
INDIRP4
INDIRI4
ADDRLP4 216
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 204
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
CNSTI4 150
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 315
;314:
;315:				cg_entities[clientNum].currentState.legsAnim = 0;
CNSTI4 1920
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cg_entities+280
ADDP4
CNSTI4 0
ASGNI4
line 316
;316:			}
LABELV $261
line 318
;317:
;318:			anim = &bgGlobalAnimations[ (cg_entities[clientNum].currentState.torsoAnim & ~ANIM_TOGGLEBIT) ];
ADDRLP4 200
CNSTI4 28
CNSTI4 1920
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cg_entities+284
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
MULI4
ADDRGP4 bgGlobalAnimations
ADDP4
ASGNP4
line 320
;319:
;320:			if (anim)
ADDRLP4 200
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $268
line 321
;321:			{
line 322
;322:				int flags = BONE_ANIM_OVERRIDE_FREEZE;
ADDRLP4 204
CNSTI4 72
ASGNI4
line 323
;323:				int firstFrame = anim->firstFrame + anim->numFrames-1;
ADDRLP4 212
ADDRLP4 200
INDIRP4
ASGNP4
ADDRLP4 208
ADDRLP4 212
INDIRP4
INDIRI4
ADDRLP4 212
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 325
;324:
;325:				if (anim->loopFrames != -1)
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $270
line 326
;326:				{
line 327
;327:					flags = BONE_ANIM_OVERRIDE_LOOP;
ADDRLP4 204
CNSTI4 16
ASGNI4
line 328
;328:					firstFrame = anim->firstFrame;
ADDRLP4 208
ADDRLP4 200
INDIRP4
INDIRI4
ASGNI4
line 329
;329:				}
LABELV $270
line 332
;330:
;331:				//rww - Set the animation again because it just got reset due to the model change
;332:				trap_G2API_SetBoneAnim(ci->ghoul2Model, 0, "upper_lumbar", anim->firstFrame + anim->numFrames-1, anim->firstFrame + anim->numFrames, flags, 1.0f, cg.time, -1, 150);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $237
ARGP4
ADDRLP4 216
ADDRLP4 200
INDIRP4
ASGNP4
ADDRLP4 220
ADDRLP4 216
INDIRP4
INDIRI4
ADDRLP4 216
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 220
INDIRI4
ARGI4
ADDRLP4 204
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
CNSTI4 150
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 334
;333:
;334:				cg_entities[clientNum].currentState.torsoAnim = 0;
CNSTI4 1920
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cg_entities+284
ADDP4
CNSTI4 0
ASGNI4
line 335
;335:			}
LABELV $268
line 336
;336:		}
LABELV $257
line 346
;337:
;338:		/*
;339:		if (cg_entities[clientNum].ghoul2 && trap_G2_HaveWeGhoul2Models(cg_entities[clientNum].ghoul2))
;340:		{
;341:			trap_G2API_CleanGhoul2Models(&(cg_entities[clientNum].ghoul2));
;342:		}
;343:		trap_G2API_DuplicateGhoul2Instance(ci->ghoul2Model, &cg_entities[clientNum].ghoul2);	
;344:		*/
;345:
;346:		cg_entities[clientNum].ghoul2weapon = NULL;
CNSTI4 1920
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cg_entities+960
ADDP4
CNSTP4 0
ASGNP4
line 347
;347:	}
LABELV $255
line 349
;348:
;349:	Com_sprintf(ci->teamName, sizeof(ci->teamName), teamName);
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 352
;350:
;351:	// Model icon for drawing the portrait on screen
;352:	ci->modelIcon = trap_R_RegisterShaderNoMip ( va ( "models/players/%s/icon_%s", modelName, skinName ) );
ADDRGP4 $275
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 200
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 200
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
ADDRLP4 204
INDIRI4
ASGNI4
line 354
;353:
;354:	return qtrue;
CNSTI4 1
RETI4
LABELV $157
endproc CG_RegisterClientModelname 276 44
proc CG_ColorFromString 20 4
line 362
;355:}
;356:
;357:/*
;358:====================
;359:CG_ColorFromString
;360:====================
;361:*/
;362:static void CG_ColorFromString( const char *v, vec3_t color ) {
line 365
;363:	int val;
;364:
;365:	VectorClear( color );
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRF4
ASGNF4
line 367
;366:
;367:	val = atoi( v );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 369
;368:
;369:	if ( val < 1 || val > 7 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $279
ADDRLP4 0
INDIRI4
CNSTI4 7
LEI4 $277
LABELV $279
line 370
;370:		VectorSet( color, 1, 1, 1 );
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 371
;371:		return;
ADDRGP4 $276
JUMPV
LABELV $277
line 374
;372:	}
;373:
;374:	if ( val & 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $280
line 375
;375:		color[2] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 376
;376:	}
LABELV $280
line 377
;377:	if ( val & 2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $282
line 378
;378:		color[1] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 379
;379:	}
LABELV $282
line 380
;380:	if ( val & 4 ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $284
line 381
;381:		color[0] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
line 382
;382:	}
LABELV $284
line 383
;383:}
LABELV $276
endproc CG_ColorFromString 20 4
export CG_LoadClientInfo
proc CG_LoadClientInfo 1264 24
line 395
;384:
;385:#define DEFAULT_FEMALE_SOUNDPATH "chars/mp_generic_female/misc"//"chars/tavion/misc"
;386:#define DEFAULT_MALE_SOUNDPATH "chars/mp_generic_male/misc"//"chars/kyle/misc"
;387:/*
;388:===================
;389:CG_LoadClientInfo
;390:
;391:Load it now, taking the disk hits.
;392:This will usually be deferred to a safe time
;393:===================
;394:*/
;395:void CG_LoadClientInfo( clientInfo_t *ci ) {
line 401
;396:	const char	*dir, *fallback;
;397:	int			i, modelloaded;
;398:	const char	*s;
;399:	int			clientNum;
;400:	char		teamname[MAX_QPATH];
;401:	int			fLen = 0;
ADDRLP4 1180
CNSTI4 0
ASGNI4
line 404
;402:	char		soundpath[MAX_QPATH];
;403:	char		soundName[1024];
;404:	qboolean	isFemale = qfalse;
ADDRLP4 1100
CNSTI4 0
ASGNI4
line 407
;405:	fileHandle_t f;
;406:
;407:	clientNum = ci - cgs.clientinfo;
ADDRLP4 1096
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cgs+43008
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 788
DIVI4
ASGNI4
line 409
;408:
;409:	if (clientNum < 0 || clientNum >= MAX_CLIENTS)
ADDRLP4 1096
INDIRI4
CNSTI4 0
LTI4 $290
ADDRLP4 1096
INDIRI4
CNSTI4 32
LTI4 $288
LABELV $290
line 410
;410:	{
line 411
;411:		clientNum = -1;
ADDRLP4 1096
CNSTI4 -1
ASGNI4
line 412
;412:	}
LABELV $288
line 414
;413:
;414:	ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 0
ASGNI4
line 438
;415:
;416:	/*
;417:	if (ci->team == TEAM_SPECTATOR)
;418:	{
;419:		// reset any existing players and bodies, because they might be in bad
;420:		// frames for this new model
;421:		clientNum = ci - cgs.clientinfo;
;422:		for ( i = 0 ; i < MAX_GENTITIES ; i++ ) {
;423:			if ( cg_entities[i].currentState.clientNum == clientNum
;424:				&& cg_entities[i].currentState.eType == ET_PLAYER ) {
;425:				CG_ResetPlayerEntity( &cg_entities[i] );
;426:			}
;427:		}
;428:
;429:		if (ci->ghoul2Model && trap_G2_HaveWeGhoul2Models(ci->ghoul2Model))
;430:		{
;431:			trap_G2API_CleanGhoul2Models(&ci->ghoul2Model);
;432:		}
;433:
;434:		return;
;435:	}
;436:	*/
;437:
;438:	teamname[0] = 0;
ADDRLP4 1108
CNSTI1 0
ASGNI1
line 439
;439:	if( cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $291
line 440
;440:		if( ci->team == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $294
line 441
;441:			Q_strncpyz(teamname, cg_blueTeamName.string, sizeof(teamname) );
ADDRLP4 1108
ARGP4
ADDRGP4 cg_blueTeamName+16
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 442
;442:		} else {
ADDRGP4 $295
JUMPV
LABELV $294
line 443
;443:			Q_strncpyz(teamname, cg_redTeamName.string, sizeof(teamname) );
ADDRLP4 1108
ARGP4
ADDRGP4 cg_redTeamName+16
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 444
;444:		}
LABELV $295
line 445
;445:	}
LABELV $291
line 446
;446:	if( teamname[0] ) {
ADDRLP4 1108
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $298
line 447
;447:		strcat( teamname, "/" );
ADDRLP4 1108
ARGP4
ADDRGP4 $300
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 448
;448:	}
LABELV $298
line 449
;449:	modelloaded = qtrue;
ADDRLP4 1104
CNSTI4 1
ASGNI4
line 450
;450:	if ( !CG_RegisterClientModelname( ci, ci->modelName, ci->skinName, teamname, clientNum ) ) {
ADDRLP4 1192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1192
INDIRP4
ARGP4
ADDRLP4 1192
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 1192
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 1108
ARGP4
ADDRLP4 1096
INDIRI4
ARGI4
ADDRLP4 1196
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 1196
INDIRI4
CNSTI4 0
NEI4 $301
line 456
;451:		//CG_Error( "CG_RegisterClientModelname( %s, %s, %s, %s %s ) failed", ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname );
;452:		//rww - DO NOT error out here! Someone could just type in a nonsense model name and crash everyone's client.
;453:		//Give it a chance to load default model for this client instead.
;454:
;455:		// fall back to default team name
;456:		if( cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $303
line 458
;457:			// keep skin name
;458:			if( ci->team == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $306
line 459
;459:				Q_strncpyz(teamname, DEFAULT_BLUETEAM_NAME, sizeof(teamname) );
ADDRLP4 1108
ARGP4
ADDRGP4 $308
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 460
;460:			} else {
ADDRGP4 $307
JUMPV
LABELV $306
line 461
;461:				Q_strncpyz(teamname, DEFAULT_REDTEAM_NAME, sizeof(teamname) );
ADDRLP4 1108
ARGP4
ADDRGP4 $309
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 462
;462:			}
LABELV $307
line 463
;463:			if ( !CG_RegisterClientModelname( ci, DEFAULT_TEAM_MODEL, ci->skinName, teamname, -1 ) ) {
ADDRLP4 1200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1200
INDIRP4
ARGP4
ADDRGP4 $164
ARGP4
ADDRLP4 1200
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 1108
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 1204
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 1204
INDIRI4
CNSTI4 0
NEI4 $304
line 464
;464:				CG_Error( "DEFAULT_TEAM_MODEL / skin (%s/%s) failed to register", DEFAULT_TEAM_MODEL, ci->skinName );
ADDRGP4 $312
ARGP4
ADDRGP4 $164
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 465
;465:			}
line 466
;466:		} else {
ADDRGP4 $304
JUMPV
LABELV $303
line 467
;467:			if ( !CG_RegisterClientModelname( ci, DEFAULT_MODEL, "default", teamname, -1 ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $164
ARGP4
ADDRGP4 $165
ARGP4
ADDRLP4 1108
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 1200
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 1200
INDIRI4
CNSTI4 0
NEI4 $313
line 468
;468:				CG_Error( "DEFAULT_MODEL (%s) failed to register", DEFAULT_MODEL );
ADDRGP4 $315
ARGP4
ADDRGP4 $164
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 469
;469:			}
LABELV $313
line 470
;470:		}
LABELV $304
line 471
;471:		modelloaded = qfalse;
ADDRLP4 1104
CNSTI4 0
ASGNI4
line 472
;472:	}
LABELV $301
line 474
;473:
;474:	if (clientNum != -1 && ci->ghoul2Model && trap_G2_HaveWeGhoul2Models(ci->ghoul2Model))
ADDRLP4 1096
INDIRI4
CNSTI4 -1
EQI4 $316
ADDRLP4 1200
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1200
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $316
ADDRLP4 1200
INDIRP4
ARGP4
ADDRLP4 1204
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 1204
INDIRI4
CNSTI4 0
EQI4 $316
line 475
;475:	{
line 476
;476:		if (cg_entities[clientNum].ghoul2 && trap_G2_HaveWeGhoul2Models(cg_entities[clientNum].ghoul2))
ADDRLP4 1208
CNSTI4 1920
ADDRLP4 1096
INDIRI4
MULI4
ASGNI4
ADDRLP4 1208
INDIRI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $318
ADDRLP4 1208
INDIRI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
ARGP4
ADDRLP4 1212
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 1212
INDIRI4
CNSTI4 0
EQI4 $318
line 477
;477:		{
line 478
;478:			trap_G2API_CleanGhoul2Models(&cg_entities[clientNum].ghoul2);
CNSTI4 1920
ADDRLP4 1096
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 479
;479:		}
LABELV $318
line 480
;480:		trap_G2API_DuplicateGhoul2Instance(ci->ghoul2Model, &cg_entities[clientNum].ghoul2);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 1920
ADDRLP4 1096
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
ARGP4
ADDRGP4 trap_G2API_DuplicateGhoul2Instance
CALLV
pop
line 481
;481:	}
LABELV $316
line 483
;482:
;483:	ci->newAnims = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 0
ASGNI4
line 484
;484:	if ( ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRI4
CNSTI4 0
EQI4 $324
line 487
;485:		orientation_t tag;
;486:		// if the torso model has the "tag_flag"
;487:		if ( trap_R_LerpTag( &tag, ci->torsoModel, 0, 0, 1, "tag_flag" ) ) {
ADDRLP4 1208
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRI4
ARGI4
ADDRLP4 1256
CNSTI4 0
ASGNI4
ADDRLP4 1256
INDIRI4
ARGI4
ADDRLP4 1256
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 $328
ARGP4
ADDRLP4 1260
ADDRGP4 trap_R_LerpTag
CALLI4
ASGNI4
ADDRLP4 1260
INDIRI4
CNSTI4 0
EQI4 $326
line 488
;488:			ci->newAnims = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 1
ASGNI4
line 489
;489:		}
LABELV $326
line 490
;490:	}
LABELV $324
line 493
;491:
;492:	// sounds
;493:	dir = ci->modelName;
ADDRLP4 1172
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
line 494
;494:	fallback = DEFAULT_MALE_SOUNDPATH; //(cgs.gametype >= GT_TEAM) ? DEFAULT_TEAM_MODEL : DEFAULT_MODEL;
ADDRLP4 1176
ADDRGP4 $329
ASGNP4
line 496
;495:
;496:	fLen = trap_FS_FOpenFile(va("models/players/%s/sounds.cfg", dir), &f, FS_READ);
ADDRGP4 $330
ARGP4
ADDRLP4 1172
INDIRP4
ARGP4
ADDRLP4 1208
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1208
INDIRP4
ARGP4
ADDRLP4 1184
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1212
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1180
ADDRLP4 1212
INDIRI4
ASGNI4
line 498
;497:
;498:	soundpath[0] = 0;
ADDRLP4 1032
CNSTI1 0
ASGNI1
line 500
;499:
;500:	if (f)
ADDRLP4 1184
INDIRI4
CNSTI4 0
EQI4 $331
line 501
;501:	{
line 502
;502:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 504
;503:
;504:		trap_FS_Read(soundpath, fLen, f);
ADDRLP4 1032
ARGP4
ADDRLP4 1180
INDIRI4
ARGI4
ADDRLP4 1184
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 506
;505:
;506:		i = fLen;
ADDRLP4 0
ADDRLP4 1180
INDIRI4
ASGNI4
ADDRGP4 $334
JUMPV
LABELV $333
line 509
;507:
;508:		while (i >= 0 && soundpath[i] != '\n')
;509:		{
line 510
;510:			if (soundpath[i] == 'f')
ADDRLP4 0
INDIRI4
ADDRLP4 1032
ADDP4
INDIRI1
CVII4 1
CNSTI4 102
NEI4 $336
line 511
;511:			{
line 512
;512:				isFemale = qtrue;
ADDRLP4 1100
CNSTI4 1
ASGNI4
line 513
;513:			}
LABELV $336
line 515
;514:
;515:			i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 516
;516:		}
LABELV $334
line 508
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $338
ADDRLP4 0
INDIRI4
ADDRLP4 1032
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $333
LABELV $338
line 518
;517:
;518:		soundpath[i-1] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 1032-1
ADDP4
CNSTI1 0
ASGNI1
line 520
;519:
;520:		trap_FS_FCloseFile(f);
ADDRLP4 1184
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 521
;521:	}
LABELV $331
line 523
;522:
;523:	if (isFemale)
ADDRLP4 1100
INDIRI4
CNSTI4 0
EQI4 $340
line 524
;524:	{
line 525
;525:		ci->gender = GENDER_FEMALE;
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
CNSTI4 1
ASGNI4
line 526
;526:	}
ADDRGP4 $341
JUMPV
LABELV $340
line 528
;527:	else
;528:	{
line 529
;529:		ci->gender = GENDER_MALE;
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
CNSTI4 0
ASGNI4
line 530
;530:	}
LABELV $341
line 532
;531:
;532:	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $342
line 533
;533:		s = cg_customSoundNames[i];
ADDRLP4 1028
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ASGNP4
line 534
;534:		if ( !s ) {
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $346
line 535
;535:			break;
ADDRGP4 $344
JUMPV
LABELV $346
line 538
;536:		}
;537:
;538:		Com_sprintf(soundName, sizeof(soundName), "%s", s+1);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $348
ARGP4
ADDRLP4 1028
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 539
;539:		COM_StripExtension(soundName, soundName);
ADDRLP4 4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 544
;540:		//strip the extension because we might want .mp3's
;541:
;542:		//ci->sounds[i] = 0;
;543:		// if the model didn't load use the sounds of the default model
;544:		if (soundpath[0])
ADDRLP4 1032
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $349
line 545
;545:		{
line 546
;546:			ci->sounds[i] = trap_S_RegisterSound( va("sound/%s/%s", soundpath, soundName) );
ADDRGP4 $351
ARGP4
ADDRLP4 1032
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1216
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRLP4 1220
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
ADDP4
ADDRLP4 1220
INDIRI4
ASGNI4
line 548
;547:
;548:			if (!ci->sounds[i])
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $350
line 549
;549:			{
line 550
;550:				if (isFemale)
ADDRLP4 1100
INDIRI4
CNSTI4 0
EQI4 $354
line 551
;551:				{
line 552
;552:					ci->sounds[i] = trap_S_RegisterSound( va("sound/%s/%s", DEFAULT_FEMALE_SOUNDPATH, soundName) );
ADDRGP4 $351
ARGP4
ADDRGP4 $356
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1224
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1224
INDIRP4
ARGP4
ADDRLP4 1228
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
ADDP4
ADDRLP4 1228
INDIRI4
ASGNI4
line 553
;553:				}
ADDRGP4 $350
JUMPV
LABELV $354
line 555
;554:				else
;555:				{
line 556
;556:					ci->sounds[i] = trap_S_RegisterSound( va("sound/%s/%s", DEFAULT_MALE_SOUNDPATH, soundName) );
ADDRGP4 $351
ARGP4
ADDRGP4 $329
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1224
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1224
INDIRP4
ARGP4
ADDRLP4 1228
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
ADDP4
ADDRLP4 1228
INDIRI4
ASGNI4
line 557
;557:				}
line 558
;558:			}
line 559
;559:		}
ADDRGP4 $350
JUMPV
LABELV $349
line 561
;560:		else
;561:		{
line 562
;562:			if (modelloaded)
ADDRLP4 1104
INDIRI4
CNSTI4 0
EQI4 $357
line 563
;563:			{
line 564
;564:				ci->sounds[i] = trap_S_RegisterSound( va("sound/chars/%s/misc/%s", dir, soundName) );
ADDRGP4 $359
ARGP4
ADDRLP4 1172
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1216
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRLP4 1220
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
ADDP4
ADDRLP4 1220
INDIRI4
ASGNI4
line 565
;565:			}
LABELV $357
line 567
;566:
;567:			if ( !ci->sounds[i] )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $360
line 568
;568:			{
line 569
;569:				ci->sounds[i] = trap_S_RegisterSound( va("sound/%s/%s", fallback, soundName) );
ADDRGP4 $351
ARGP4
ADDRLP4 1176
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1216
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRLP4 1220
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
ADDP4
ADDRLP4 1220
INDIRI4
ASGNI4
line 570
;570:			}
LABELV $360
line 571
;571:		}
LABELV $350
line 572
;572:	}
LABELV $343
line 532
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $342
LABELV $344
line 574
;573:
;574:	ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 0
ASGNI4
line 578
;575:
;576:	// reset any existing players and bodies, because they might be in bad
;577:	// frames for this new model
;578:	clientNum = ci - cgs.clientinfo;
ADDRLP4 1096
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cgs+43008
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 788
DIVI4
ASGNI4
line 579
;579:	for ( i = 0 ; i < MAX_GENTITIES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $363
line 580
;580:		if ( cg_entities[i].currentState.clientNum == clientNum
ADDRLP4 1216
CNSTI4 1920
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 1216
INDIRI4
ADDRGP4 cg_entities+220
ADDP4
INDIRI4
ADDRLP4 1096
INDIRI4
NEI4 $367
ADDRLP4 1216
INDIRI4
ADDRGP4 cg_entities+4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $367
line 581
;581:			&& cg_entities[i].currentState.eType == ET_PLAYER ) {
line 582
;582:			CG_ResetPlayerEntity( &cg_entities[i] );
CNSTI4 1920
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 583
;583:		}
LABELV $367
line 584
;584:	}
LABELV $364
line 579
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $363
line 585
;585:}
LABELV $286
endproc CG_LoadClientInfo 1264 24
proc CG_CopyClientInfoModel 76 12
line 595
;586:
;587:
;588:
;589:
;590:/*
;591:======================
;592:CG_CopyClientInfoModel
;593:======================
;594:*/
;595:static void CG_CopyClientInfoModel( clientInfo_t *from, clientInfo_t *to ) {
line 596
;596:	VectorCopy( from->headOffset, to->headOffset );
ADDRLP4 0
CNSTI4 464
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 597
;597:	to->footsteps = from->footsteps;
ADDRLP4 4
CNSTI4 476
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 598
;598:	to->gender = from->gender;
ADDRLP4 8
CNSTI4 480
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 600
;599:
;600:	to->legsModel = from->legsModel;
ADDRLP4 12
CNSTI4 484
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 601
;601:	to->legsSkin = from->legsSkin;
ADDRLP4 16
CNSTI4 488
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 602
;602:	to->torsoModel = from->torsoModel;
ADDRLP4 20
CNSTI4 492
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 603
;603:	to->torsoSkin = from->torsoSkin;
ADDRLP4 24
CNSTI4 496
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 606
;604:	//to->headModel = from->headModel;
;605:	//to->headSkin = from->headSkin;
;606:	to->modelIcon = from->modelIcon;
ADDRLP4 28
CNSTI4 508
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 608
;607:
;608:	to->newAnims = from->newAnims;
ADDRLP4 32
CNSTI4 452
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 612
;609:
;610:	//to->ghoul2Model = from->ghoul2Model;
;611:	//rww - Trying to use the same ghoul2 pointer for two seperate clients == DISASTER
;612:	if (to->ghoul2Model && trap_G2_HaveWeGhoul2Models(to->ghoul2Model))
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $372
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $372
line 613
;613:	{
line 614
;614:		trap_G2API_CleanGhoul2Models(&to->ghoul2Model);
ADDRFP4 4
INDIRP4
CNSTI4 504
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 615
;615:	}
LABELV $372
line 616
;616:	if (from->ghoul2Model && trap_G2_HaveWeGhoul2Models(from->ghoul2Model))
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $374
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $374
line 617
;617:	{
line 618
;618:		trap_G2API_DuplicateGhoul2Instance(from->ghoul2Model, &to->ghoul2Model);
ADDRLP4 52
CNSTI4 504
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ARGP4
ADDRGP4 trap_G2API_DuplicateGhoul2Instance
CALLV
pop
line 619
;619:	}
LABELV $374
line 621
;620:
;621:	to->bolt_head = from->bolt_head;
ADDRLP4 52
CNSTI4 520
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 622
;622:	to->bolt_lhand = from->bolt_lhand;
ADDRLP4 56
CNSTI4 516
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 623
;623:	to->bolt_rhand = from->bolt_rhand;
ADDRLP4 60
CNSTI4 512
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 624
;624:	to->bolt_motion = from->bolt_motion;
ADDRLP4 64
CNSTI4 524
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 625
;625:	to->bolt_llumbar = from->bolt_llumbar;
ADDRLP4 68
CNSTI4 528
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 629
;626:
;627://	to->ATST = from->ATST;
;628:
;629:	memcpy( to->sounds, from->sounds, sizeof( to->sounds ) );
ADDRLP4 72
CNSTI4 652
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 630
;630:}
LABELV $371
endproc CG_CopyClientInfoModel 76 12
proc CG_ScanForExistingClientInfo 48 8
line 637
;631:
;632:/*
;633:======================
;634:CG_ScanForExistingClientInfo
;635:======================
;636:*/
;637:static qboolean CG_ScanForExistingClientInfo( clientInfo_t *ci ) {
line 641
;638:	int		i;
;639:	clientInfo_t	*match;
;640:
;641:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $380
JUMPV
LABELV $377
line 642
;642:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 788
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 643
;643:		if ( !match->infoValid ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $383
line 644
;644:			continue;
ADDRGP4 $378
JUMPV
LABELV $383
line 646
;645:		}
;646:		if ( match->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
CNSTI4 0
EQI4 $385
line 647
;647:			continue;
ADDRGP4 $378
JUMPV
LABELV $385
line 649
;648:		}
;649:		if ( !Q_stricmp( ci->modelName, match->modelName )
ADDRLP4 8
CNSTI4 160
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $387
ADDRLP4 16
CNSTI4 224
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $387
ADDRLP4 24
CNSTI4 384
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $387
ADDRLP4 32
CNSTI4 352
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $387
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $390
ADDRLP4 40
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
NEI4 $387
LABELV $390
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $387
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $387
line 658
;650:			&& !Q_stricmp( ci->skinName, match->skinName )
;651://			&& !Q_stricmp( ci->headModelName, match->headModelName )
;652://			&& !Q_stricmp( ci->headSkinName, match->headSkinName ) 
;653:			&& !Q_stricmp( ci->blueTeam, match->blueTeam ) 
;654:			&& !Q_stricmp( ci->redTeam, match->redTeam )
;655:			&& (cgs.gametype < GT_TEAM || ci->team == match->team) 
;656:			&& match->ghoul2Model
;657:			&& match->bolt_head) //if the bolts haven't been initialized, this "match" is useless to us
;658:		{
line 661
;659:			// this clientinfo is identical, so use it's handles
;660:
;661:			ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 0
ASGNI4
line 663
;662:
;663:			CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 665
;664:
;665:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $376
JUMPV
LABELV $387
line 667
;666:		}
;667:	}
LABELV $378
line 641
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $380
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+32988
INDIRI4
LTI4 $377
line 670
;668:
;669:	// nothing matches, so defer the load
;670:	return qfalse;
CNSTI4 0
RETI4
LABELV $376
endproc CG_ScanForExistingClientInfo 48 8
proc CG_SetDeferredClientInfo 36 8
line 681
;671:}
;672:
;673:/*
;674:======================
;675:CG_SetDeferredClientInfo
;676:
;677:We aren't going to load it now, so grab some other
;678:client's info to use until we have some spare time.
;679:======================
;680:*/
;681:static void CG_SetDeferredClientInfo( clientInfo_t *ci ) {
line 687
;682:	int		i;
;683:	clientInfo_t	*match;
;684:
;685:	// if someone else is already the same models and skins we
;686:	// can just load the client info
;687:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $395
JUMPV
LABELV $392
line 688
;688:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 788
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 689
;689:		if ( !match->infoValid || match->deferred ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $400
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $398
LABELV $400
line 690
;690:			continue;
ADDRGP4 $393
JUMPV
LABELV $398
line 692
;691:		}
;692:		if ( Q_stricmp( ci->skinName, match->skinName ) ||
ADDRLP4 16
CNSTI4 224
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $405
ADDRLP4 24
CNSTI4 160
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $405
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $401
ADDRLP4 32
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $401
LABELV $405
line 696
;693:			 Q_stricmp( ci->modelName, match->modelName ) ||
;694://			 Q_stricmp( ci->headModelName, match->headModelName ) ||
;695://			 Q_stricmp( ci->headSkinName, match->headSkinName ) ||
;696:			 (cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
line 697
;697:			continue;
ADDRGP4 $393
JUMPV
LABELV $401
line 700
;698:		}
;699:		// just load the real info cause it uses the same models and skins
;700:		CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 701
;701:		return;
ADDRGP4 $391
JUMPV
LABELV $393
line 687
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $395
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+32988
INDIRI4
LTI4 $392
line 705
;702:	}
;703:
;704:	// if we are in teamplay, only grab a model if the skin is correct
;705:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $406
line 706
;706:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $412
JUMPV
LABELV $409
line 707
;707:			match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 788
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 708
;708:			if ( !match->infoValid || match->deferred ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $417
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $415
LABELV $417
line 709
;709:				continue;
ADDRGP4 $410
JUMPV
LABELV $415
line 711
;710:			}
;711:			if ( Q_stricmp( ci->skinName, match->skinName ) ||
ADDRLP4 16
CNSTI4 224
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $421
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $418
ADDRLP4 24
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
EQI4 $418
LABELV $421
line 712
;712:				(cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
line 713
;713:				continue;
ADDRGP4 $410
JUMPV
LABELV $418
line 715
;714:			}
;715:			ci->deferred = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 1
ASGNI4
line 716
;716:			CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 717
;717:			return;
ADDRGP4 $391
JUMPV
LABELV $410
line 706
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $412
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+32988
INDIRI4
LTI4 $409
line 723
;718:		}
;719:		// load the full model, because we don't ever want to show
;720:		// an improper team skin.  This will cause a hitch for the first
;721:		// player, when the second enters.  Combat shouldn't be going on
;722:		// yet, so it shouldn't matter
;723:		CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 724
;724:		return;
ADDRGP4 $391
JUMPV
LABELV $406
line 728
;725:	}
;726:
;727:	// find the first valid clientinfo and grab its stuff
;728:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $425
JUMPV
LABELV $422
line 729
;729:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 788
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 730
;730:		if ( !match->infoValid ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $428
line 731
;731:			continue;
ADDRGP4 $423
JUMPV
LABELV $428
line 734
;732:		}
;733:
;734:		ci->deferred = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 1
ASGNI4
line 735
;735:		CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 736
;736:		return;
ADDRGP4 $391
JUMPV
LABELV $423
line 728
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $425
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+32988
INDIRI4
LTI4 $422
line 740
;737:	}
;738:
;739:	// we should never get here...
;740:	CG_Printf( "CG_SetDeferredClientInfo: no valid clients!\n" );
ADDRGP4 $430
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 742
;741:
;742:	CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 743
;743:}
LABELV $391
endproc CG_SetDeferredClientInfo 36 8
export CG_NewClientInfo
proc CG_NewClientInfo 980 40
line 750
;744:
;745:/*
;746:======================
;747:CG_NewClientInfo
;748:======================
;749:*/
;750:void CG_NewClientInfo( int clientNum, qboolean entitiesInitialized ) {
line 757
;751:	clientInfo_t *ci;
;752:	clientInfo_t newInfo;
;753:	const char	*configstring;
;754:	const char	*v;
;755:	char		*slash;
;756:	void *oldGhoul2;
;757:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 758
;758:	qboolean wasATST = qfalse;
ADDRLP4 804
CNSTI4 0
ASGNI4
line 760
;759:
;760:	ci = &cgs.clientinfo[clientNum];
ADDRLP4 800
CNSTI4 788
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 762
;761:
;762:	oldGhoul2 = ci->ghoul2Model;
ADDRLP4 812
ADDRLP4 800
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ASGNP4
line 764
;763:
;764:	configstring = CG_ConfigString( clientNum + CS_PLAYERS );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 816
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 796
ADDRLP4 816
INDIRP4
ASGNP4
line 765
;765:	if ( !configstring[0] ) {
ADDRLP4 796
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $433
line 766
;766:		memset( ci, 0, sizeof( *ci ) );
ADDRLP4 800
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ARGI4
ADDRGP4 memset
CALLP4
pop
line 767
;767:		return;		// player just left
ADDRGP4 $431
JUMPV
LABELV $433
line 770
;768:	}
;769:
;770:	if (ci)
ADDRLP4 800
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $435
line 771
;771:	{
line 772
;772:		wasATST = ci->ATST;
ADDRLP4 804
ADDRLP4 800
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
ASGNI4
line 773
;773:	}
LABELV $435
line 777
;774:
;775:	// build into a temp buffer so the defer checks can use
;776:	// the old value
;777:	memset( &newInfo, 0, sizeof( newInfo ) );
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ARGI4
ADDRGP4 memset
CALLP4
pop
line 780
;778:
;779:	// isolate the player's name
;780:	v = Info_ValueForKey(configstring, "n");
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $437
ARGP4
ADDRLP4 820
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 820
INDIRP4
ASGNP4
line 781
;781:	Q_strncpyz( newInfo.name, v, sizeof( newInfo.name ) );
ADDRLP4 4+4
ARGP4
ADDRLP4 792
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 784
;782:
;783:	// colors
;784:	v = Info_ValueForKey( configstring, "c1" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $440
ARGP4
ADDRLP4 824
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 824
INDIRP4
ASGNP4
line 785
;785:	CG_ColorFromString( v, newInfo.color1 );
ADDRLP4 792
INDIRP4
ARGP4
ADDRLP4 4+80
ARGP4
ADDRGP4 CG_ColorFromString
CALLV
pop
line 787
;786:
;787:	newInfo.icolor1 = atoi(v);
ADDRLP4 792
INDIRP4
ARGP4
ADDRLP4 828
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+104
ADDRLP4 828
INDIRI4
ASGNI4
line 789
;788:
;789:	v = Info_ValueForKey( configstring, "c2" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $443
ARGP4
ADDRLP4 832
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 832
INDIRP4
ASGNP4
line 790
;790:	CG_ColorFromString( v, newInfo.color2 );
ADDRLP4 792
INDIRP4
ARGP4
ADDRLP4 4+92
ARGP4
ADDRGP4 CG_ColorFromString
CALLV
pop
line 793
;791:
;792:	// bot skill
;793:	v = Info_ValueForKey( configstring, "skill" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $445
ARGP4
ADDRLP4 836
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 836
INDIRP4
ASGNP4
line 794
;794:	newInfo.botSkill = atoi( v );
ADDRLP4 792
INDIRP4
ARGP4
ADDRLP4 840
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+72
ADDRLP4 840
INDIRI4
ASGNI4
line 797
;795:
;796:	// handicap
;797:	v = Info_ValueForKey( configstring, "hc" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $447
ARGP4
ADDRLP4 844
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 844
INDIRP4
ASGNP4
line 798
;798:	newInfo.handicap = atoi( v );
ADDRLP4 792
INDIRP4
ARGP4
ADDRLP4 848
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+128
ADDRLP4 848
INDIRI4
ASGNI4
line 801
;799:
;800:	// wins
;801:	v = Info_ValueForKey( configstring, "w" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $449
ARGP4
ADDRLP4 852
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 852
INDIRP4
ASGNP4
line 802
;802:	newInfo.wins = atoi( v );
ADDRLP4 792
INDIRP4
ARGP4
ADDRLP4 856
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+132
ADDRLP4 856
INDIRI4
ASGNI4
line 805
;803:
;804:	// losses
;805:	v = Info_ValueForKey( configstring, "l" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $451
ARGP4
ADDRLP4 860
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 860
INDIRP4
ASGNP4
line 806
;806:	newInfo.losses = atoi( v );
ADDRLP4 792
INDIRP4
ARGP4
ADDRLP4 864
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+136
ADDRLP4 864
INDIRI4
ASGNI4
line 809
;807:
;808:	// team
;809:	v = Info_ValueForKey( configstring, "t" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $453
ARGP4
ADDRLP4 868
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 868
INDIRP4
ASGNP4
line 810
;810:	newInfo.team = atoi( v );
ADDRLP4 792
INDIRP4
ARGP4
ADDRLP4 872
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+68
ADDRLP4 872
INDIRI4
ASGNI4
line 813
;811:
;812:	// team task
;813:	v = Info_ValueForKey( configstring, "tt" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $455
ARGP4
ADDRLP4 876
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 876
INDIRP4
ASGNP4
line 814
;814:	newInfo.teamTask = atoi(v);
ADDRLP4 792
INDIRP4
ARGP4
ADDRLP4 880
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+140
ADDRLP4 880
INDIRI4
ASGNI4
line 817
;815:
;816:	// team leader
;817:	v = Info_ValueForKey( configstring, "tl" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $457
ARGP4
ADDRLP4 884
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 884
INDIRP4
ASGNP4
line 818
;818:	newInfo.teamLeader = atoi(v);
ADDRLP4 792
INDIRP4
ARGP4
ADDRLP4 888
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+144
ADDRLP4 888
INDIRI4
ASGNI4
line 820
;819:
;820:	v = Info_ValueForKey( configstring, "g_redteam" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $459
ARGP4
ADDRLP4 892
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 892
INDIRP4
ASGNP4
line 821
;821:	Q_strncpyz(newInfo.redTeam, v, MAX_TEAMNAME);
ADDRLP4 4+352
ARGP4
ADDRLP4 792
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 823
;822:
;823:	v = Info_ValueForKey( configstring, "g_blueteam" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $461
ARGP4
ADDRLP4 896
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 896
INDIRP4
ASGNP4
line 824
;824:	Q_strncpyz(newInfo.blueTeam, v, MAX_TEAMNAME);
ADDRLP4 4+384
ARGP4
ADDRLP4 792
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 827
;825:
;826:	// model
;827:	v = Info_ValueForKey( configstring, "model" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $463
ARGP4
ADDRLP4 900
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 900
INDIRP4
ASGNP4
line 828
;828:	if ( cg_forceModel.integer ) {
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $464
line 834
;829:		// forcemodel makes everyone use a single model
;830:		// to prevent load hitches
;831:		char modelStr[MAX_QPATH];
;832:		char *skin;
;833:
;834:		if( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $467
line 835
;835:			Q_strncpyz( newInfo.modelName, DEFAULT_TEAM_MODEL, sizeof( newInfo.modelName ) );
ADDRLP4 4+160
ARGP4
ADDRGP4 $164
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 836
;836:			Q_strncpyz( newInfo.skinName, "default", sizeof( newInfo.skinName ) );
ADDRLP4 4+224
ARGP4
ADDRGP4 $165
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 837
;837:		} else {
ADDRGP4 $468
JUMPV
LABELV $467
line 838
;838:			trap_Cvar_VariableStringBuffer( "model", modelStr, sizeof( modelStr ) );
ADDRGP4 $463
ARGP4
ADDRLP4 904
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 839
;839:			if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 904
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 972
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 968
ADDRLP4 972
INDIRP4
ASGNP4
ADDRLP4 972
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $474
line 840
;840:				skin = "default";
ADDRLP4 968
ADDRGP4 $165
ASGNP4
line 841
;841:			} else {
ADDRGP4 $475
JUMPV
LABELV $474
line 842
;842:				*skin++ = 0;
ADDRLP4 976
ADDRLP4 968
INDIRP4
ASGNP4
ADDRLP4 968
ADDRLP4 976
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 976
INDIRP4
CNSTI1 0
ASGNI1
line 843
;843:			}
LABELV $475
line 845
;844:
;845:			Q_strncpyz( newInfo.skinName, skin, sizeof( newInfo.skinName ) );
ADDRLP4 4+224
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 846
;846:			Q_strncpyz( newInfo.modelName, modelStr, sizeof( newInfo.modelName ) );
ADDRLP4 4+160
ARGP4
ADDRLP4 904
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 847
;847:		}
LABELV $468
line 849
;848:
;849:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $465
line 851
;850:			// keep skin name
;851:			slash = strchr( v, '/' );
ADDRLP4 792
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 972
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 808
ADDRLP4 972
INDIRP4
ASGNP4
line 852
;852:			if ( slash ) {
ADDRLP4 808
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $465
line 853
;853:				Q_strncpyz( newInfo.skinName, slash + 1, sizeof( newInfo.skinName ) );
ADDRLP4 4+224
ARGP4
ADDRLP4 808
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 854
;854:			}
line 855
;855:		}
line 856
;856:	} else {
ADDRGP4 $465
JUMPV
LABELV $464
line 857
;857:		Q_strncpyz( newInfo.modelName, v, sizeof( newInfo.modelName ) );
ADDRLP4 4+160
ARGP4
ADDRLP4 792
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 859
;858:
;859:		slash = strchr( newInfo.modelName, '/' );
ADDRLP4 4+160
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 904
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 808
ADDRLP4 904
INDIRP4
ASGNP4
line 860
;860:		if ( !slash ) {
ADDRLP4 808
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $490
line 862
;861:			// modelName didn not include a skin name
;862:			Q_strncpyz( newInfo.skinName, "default", sizeof( newInfo.skinName ) );
ADDRLP4 4+224
ARGP4
ADDRGP4 $165
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 863
;863:		} else {
ADDRGP4 $491
JUMPV
LABELV $490
line 864
;864:			Q_strncpyz( newInfo.skinName, slash + 1, sizeof( newInfo.skinName ) );
ADDRLP4 4+224
ARGP4
ADDRLP4 808
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 866
;865:			// truncate modelName
;866:			*slash = 0;
ADDRLP4 808
INDIRP4
CNSTI1 0
ASGNI1
line 867
;867:		}
LABELV $491
line 868
;868:	}
LABELV $465
line 916
;869:
;870:	// head model
;871:/*
;872:	v = Info_ValueForKey( configstring, "hmodel" );
;873:	if ( cg_forceModel.integer ) {
;874:		// forcemodel makes everyone use a single model
;875:		// to prevent load hitches
;876:		char modelStr[MAX_QPATH];
;877:		char *skin;
;878:
;879:		if( cgs.gametype >= GT_TEAM ) {
;880:			Q_strncpyz( newInfo.headModelName, DEFAULT_TEAM_MODEL, sizeof( newInfo.headModelName ) );
;881:			Q_strncpyz( newInfo.headSkinName, "default", sizeof( newInfo.headSkinName ) );
;882:		} else {
;883:			trap_Cvar_VariableStringBuffer( "headmodel", modelStr, sizeof( modelStr ) );
;884:			if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
;885:				skin = "default";
;886:			} else {
;887:				*skin++ = 0;
;888:			}
;889:
;890:			Q_strncpyz( newInfo.headSkinName, skin, sizeof( newInfo.headSkinName ) );
;891:			Q_strncpyz( newInfo.headModelName, modelStr, sizeof( newInfo.headModelName ) );
;892:		}
;893:
;894:		if ( cgs.gametype >= GT_TEAM ) {
;895:			// keep skin name
;896:			slash = strchr( v, '/' );
;897:			if ( slash ) {
;898:				Q_strncpyz( newInfo.headSkinName, slash + 1, sizeof( newInfo.headSkinName ) );
;899:			}
;900:		}
;901:	} else {
;902:		Q_strncpyz( newInfo.headModelName, v, sizeof( newInfo.headModelName ) );
;903:
;904:		slash = strchr( newInfo.headModelName, '/' );
;905:		if ( !slash ) {
;906:			// modelName didn not include a skin name
;907:			Q_strncpyz( newInfo.headSkinName, "default", sizeof( newInfo.headSkinName ) );
;908:		} else {
;909:			Q_strncpyz( newInfo.headSkinName, slash + 1, sizeof( newInfo.headSkinName ) );
;910:			// truncate modelName
;911:			*slash = 0;
;912:		}
;913:	}
;914:*/
;915:	// force powers
;916:	v = Info_ValueForKey( configstring, "forcepowers" );
ADDRLP4 796
INDIRP4
ARGP4
ADDRGP4 $496
ARGP4
ADDRLP4 904
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 792
ADDRLP4 904
INDIRP4
ASGNP4
line 917
;917:	Q_strncpyz( newInfo.forcePowers, v, sizeof( newInfo.forcePowers ) );
ADDRLP4 4+288
ARGP4
ADDRLP4 792
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 919
;918:
;919:	newInfo.ATST = wasATST;
ADDRLP4 4+500
ADDRLP4 804
INDIRI4
ASGNI4
line 921
;920:
;921:	if (cgs.gametype >= GT_TEAM)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $500
line 922
;922:	{
line 923
;923:		if (newInfo.team == TEAM_RED)
ADDRLP4 4+68
INDIRI4
CNSTI4 1
NEI4 $503
line 924
;924:		{
line 925
;925:			strcpy(newInfo.skinName, "red");
ADDRLP4 4+224
ARGP4
ADDRGP4 $174
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 927
;926://			strcpy(newInfo.headSkinName, "red");
;927:		}
LABELV $503
line 928
;928:		if (newInfo.team == TEAM_BLUE)
ADDRLP4 4+68
INDIRI4
CNSTI4 2
NEI4 $507
line 929
;929:		{
line 930
;930:			strcpy(newInfo.skinName, "blue");
ADDRLP4 4+224
ARGP4
ADDRGP4 $177
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 932
;931://			strcpy(newInfo.headSkinName, "blue");
;932:		}
LABELV $507
line 933
;933:	}
LABELV $500
line 937
;934:
;935:	// scan for an existing clientinfo that matches this modelname
;936:	// so we can avoid loading checks if possible
;937:	if ( !CG_ScanForExistingClientInfo( &newInfo ) ) {
ADDRLP4 4
ARGP4
ADDRLP4 908
ADDRGP4 CG_ScanForExistingClientInfo
CALLI4
ASGNI4
ADDRLP4 908
INDIRI4
CNSTI4 0
NEI4 $511
line 940
;938:		qboolean	forceDefer;
;939:
;940:		forceDefer = trap_MemoryRemaining() < 4000000;
ADDRLP4 920
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 920
INDIRI4
CNSTI4 4000000
GEI4 $514
ADDRLP4 916
CNSTI4 1
ASGNI4
ADDRGP4 $515
JUMPV
LABELV $514
ADDRLP4 916
CNSTI4 0
ASGNI4
LABELV $515
ADDRLP4 912
ADDRLP4 916
INDIRI4
ASGNI4
line 943
;941:
;942:		// if we are defering loads, just have it pick the first valid
;943:		if (cg.snap && cg.snap->ps.clientNum == clientNum && !forceDefer)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $516
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $516
ADDRLP4 912
INDIRI4
CNSTI4 0
NEI4 $516
line 944
;944:		{ //rww - don't defer your own client info ever, unless really low on memory
line 945
;945:			CG_LoadClientInfo( &newInfo );
ADDRLP4 4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 946
;946:		}
ADDRGP4 $517
JUMPV
LABELV $516
line 947
;947:		else if ( forceDefer || ( cg_deferPlayers.integer && !cg_buildScript.integer && !cg.loading ) ) {
ADDRLP4 924
CNSTI4 0
ASGNI4
ADDRLP4 912
INDIRI4
ADDRLP4 924
INDIRI4
NEI4 $525
ADDRGP4 cg_deferPlayers+12
INDIRI4
ADDRLP4 924
INDIRI4
EQI4 $520
ADDRGP4 cg_buildScript+12
INDIRI4
ADDRLP4 924
INDIRI4
NEI4 $520
ADDRGP4 cg+20
INDIRI4
ADDRLP4 924
INDIRI4
NEI4 $520
LABELV $525
line 949
;948:			// keep whatever they had if it won't violate team skins
;949:			CG_SetDeferredClientInfo( &newInfo );
ADDRLP4 4
ARGP4
ADDRGP4 CG_SetDeferredClientInfo
CALLV
pop
line 951
;950:			// if we are low on memory, leave them with this model
;951:			if ( forceDefer ) {
ADDRLP4 912
INDIRI4
CNSTI4 0
EQI4 $521
line 952
;952:				CG_Printf( "Memory is low.  Using deferred model.\n" );
ADDRGP4 $528
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 953
;953:				newInfo.deferred = qfalse;
ADDRLP4 4+448
CNSTI4 0
ASGNI4
line 954
;954:			}
line 955
;955:		} else {
ADDRGP4 $521
JUMPV
LABELV $520
line 956
;956:			CG_LoadClientInfo( &newInfo );
ADDRLP4 4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 957
;957:		}
LABELV $521
LABELV $517
line 958
;958:	}
LABELV $511
line 961
;959:
;960:	// replace whatever was there with the new one
;961:	newInfo.infoValid = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 962
;962:	*ci = newInfo;
ADDRLP4 800
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 788
ADDRGP4 $531
JUMPV
LABELV $530
line 966
;963:
;964:	//force a weapon change anyway, for all clients being rendered to the current client
;965:	while (i < MAX_CLIENTS)
;966:	{
line 967
;967:		cg_entities[i].ghoul2weapon = NULL;
CNSTI4 1920
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+960
ADDP4
CNSTP4 0
ASGNP4
line 968
;968:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 969
;969:	}
LABELV $531
line 965
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $530
line 972
;970:
;971:	// Check if the ghoul2 model changed in any way.  This is safer than assuming we have a legal cent shile loading info.
;972:	if (entitiesInitialized && ci->ghoul2Model && (oldGhoul2 != ci->ghoul2Model))
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $534
ADDRLP4 912
ADDRLP4 800
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 912
INDIRU4
CNSTU4 0
EQU4 $534
ADDRLP4 812
INDIRP4
CVPU4 4
ADDRLP4 912
INDIRU4
EQU4 $534
line 973
;973:	{	// Copy the new ghoul2 model to the centity.
line 977
;974:		animation_t *anim;
;975:		// First check if we have a ghoul2 model on the client entity.
;976:		
;977:		anim = &bgGlobalAnimations[ (cg_entities[clientNum].currentState.legsAnim & ~ANIM_TOGGLEBIT) ];
ADDRLP4 916
CNSTI4 28
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+280
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
MULI4
ADDRGP4 bgGlobalAnimations
ADDP4
ASGNP4
line 979
;978:
;979:		if (anim)
ADDRLP4 916
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $537
line 980
;980:		{
line 981
;981:			int flags = BONE_ANIM_OVERRIDE_FREEZE;
ADDRLP4 920
CNSTI4 72
ASGNI4
line 982
;982:			int firstFrame = anim->firstFrame + anim->numFrames-1;
ADDRLP4 924
ADDRLP4 916
INDIRP4
INDIRI4
ADDRLP4 916
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 984
;983:
;984:			if (anim->loopFrames != -1)
ADDRLP4 916
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $539
line 985
;985:			{
line 986
;986:				flags = BONE_ANIM_OVERRIDE_LOOP;
ADDRLP4 920
CNSTI4 16
ASGNI4
line 987
;987:				firstFrame = anim->firstFrame;
ADDRLP4 924
ADDRLP4 916
INDIRP4
INDIRI4
ASGNI4
line 988
;988:			}
LABELV $539
line 991
;989:
;990:			//rww - Set the animation again because it just got reset due to the model change
;991:			trap_G2API_SetBoneAnim(ci->ghoul2Model, 0, "model_root", firstFrame, anim->firstFrame + anim->numFrames, flags, 1.0f, cg.time, -1, 150);
ADDRLP4 800
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 924
INDIRI4
ARGI4
ADDRLP4 916
INDIRP4
INDIRI4
ADDRLP4 916
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 920
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
CNSTI4 150
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 993
;992:
;993:			cg_entities[clientNum].currentState.legsAnim = 0;
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+280
ADDP4
CNSTI4 0
ASGNI4
line 994
;994:		}
LABELV $537
line 996
;995:
;996:		anim = &bgGlobalAnimations[ (cg_entities[clientNum].currentState.torsoAnim & ~ANIM_TOGGLEBIT) ];
ADDRLP4 916
CNSTI4 28
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+284
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
MULI4
ADDRGP4 bgGlobalAnimations
ADDP4
ASGNP4
line 998
;997:
;998:		if (anim)
ADDRLP4 916
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $544
line 999
;999:		{
line 1000
;1000:			int flags = BONE_ANIM_OVERRIDE_FREEZE;
ADDRLP4 920
CNSTI4 72
ASGNI4
line 1001
;1001:			int firstFrame = anim->firstFrame + anim->numFrames-1;
ADDRLP4 924
ADDRLP4 916
INDIRP4
INDIRI4
ADDRLP4 916
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 1003
;1002:
;1003:			if (anim->loopFrames != -1)
ADDRLP4 916
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $546
line 1004
;1004:			{
line 1005
;1005:				flags = BONE_ANIM_OVERRIDE_LOOP;
ADDRLP4 920
CNSTI4 16
ASGNI4
line 1006
;1006:				firstFrame = anim->firstFrame;
ADDRLP4 924
ADDRLP4 916
INDIRP4
INDIRI4
ASGNI4
line 1007
;1007:			}
LABELV $546
line 1010
;1008:
;1009:			//rww - Set the animation again because it just got reset due to the model change
;1010:			trap_G2API_SetBoneAnim(ci->ghoul2Model, 0, "upper_lumbar", anim->firstFrame + anim->numFrames-1, anim->firstFrame + anim->numFrames, flags, 1.0f, cg.time, -1, 150);
ADDRLP4 800
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $237
ARGP4
ADDRLP4 936
ADDRLP4 916
INDIRP4
INDIRI4
ADDRLP4 916
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRLP4 936
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 936
INDIRI4
ARGI4
ADDRLP4 920
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
CNSTI4 150
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 1012
;1011:
;1012:			cg_entities[clientNum].currentState.torsoAnim = 0;
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+284
ADDP4
CNSTI4 0
ASGNI4
line 1013
;1013:		}
LABELV $544
line 1015
;1014:
;1015:		if (cg_entities[clientNum].ghoul2 && trap_G2_HaveWeGhoul2Models(cg_entities[clientNum].ghoul2))
ADDRLP4 920
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 920
INDIRI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $550
ADDRLP4 920
INDIRI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
ARGP4
ADDRLP4 924
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 924
INDIRI4
CNSTI4 0
EQI4 $550
line 1016
;1016:		{
line 1017
;1017:			trap_G2API_CleanGhoul2Models(&cg_entities[clientNum].ghoul2);
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 1018
;1018:		}
LABELV $550
line 1019
;1019:		trap_G2API_DuplicateGhoul2Instance(ci->ghoul2Model, &cg_entities[clientNum].ghoul2);
ADDRLP4 800
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
ARGP4
ADDRGP4 trap_G2API_DuplicateGhoul2Instance
CALLV
pop
line 1028
;1020:
;1021:		/*
;1022:		if (cg_entities[clientNum].currentState.weapon > WP_NONE)
;1023:		{
;1024:			CG_CopyG2WeaponInstance(cg_entities[clientNum].currentState.weapon, cg_entities[clientNum].ghoul2);
;1025:		}
;1026:		*/
;1027:		//It should catch this next update anyway. We just set all ghoul2weapon's to NULL above.
;1028:	}
LABELV $534
line 1040
;1029:	/*
;1030:	else if (ci->team == TEAM_SPECTATOR && cg_entities[clientNum].ghoul2 && trap_G2_HaveWeGhoul2Models(cg_entities[clientNum].ghoul2))
;1031:	{ //this shouldn't actually happen now because we are not trying to register models for spectators. But just in case.
;1032:		trap_G2API_CleanGhoul2Models(&cg_entities[clientNum].ghoul2);
;1033:		if (ci->ghoul2Model && trap_G2_HaveWeGhoul2Models(ci->ghoul2Model))
;1034:		{
;1035:			trap_G2API_DuplicateGhoul2Instance(ci->ghoul2Model, &cg_entities[clientNum].ghoul2);
;1036:		}
;1037:	}
;1038:	*/
;1039:
;1040:}
LABELV $431
endproc CG_NewClientInfo 980 40
data
export cgQueueLoad
align 4
LABELV cgQueueLoad
byte 4 0
export CG_ActualLoadDeferredPlayers
code
proc CG_ActualLoadDeferredPlayers 20 4
line 1052
;1041:
;1042:
;1043:qboolean cgQueueLoad = qfalse;
;1044:/*
;1045:======================
;1046:CG_ActualLoadDeferredPlayers
;1047:
;1048:Called at the beginning of CG_Player if cgQueueLoad is set.
;1049:======================
;1050:*/
;1051:void CG_ActualLoadDeferredPlayers( void )
;1052:{
line 1057
;1053:	int		i;
;1054:	clientInfo_t	*ci;
;1055:
;1056:	// scan for a deferred player to load
;1057:	for ( i = 0, ci = cgs.clientinfo ; i < cgs.maxclients ; i++, ci++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cgs+43008
ASGNP4
ADDRGP4 $560
JUMPV
LABELV $557
line 1058
;1058:		if ( ci->infoValid && ci->deferred ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $563
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $563
line 1060
;1059:			// if we are low on memory, leave it deferred
;1060:			if ( trap_MemoryRemaining() < 4000000 ) {
ADDRLP4 16
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 4000000
GEI4 $565
line 1061
;1061:				CG_Printf( "Memory is low.  Using deferred model.\n" );
ADDRGP4 $528
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1062
;1062:				ci->deferred = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 0
ASGNI4
line 1063
;1063:				continue;
ADDRGP4 $558
JUMPV
LABELV $565
line 1065
;1064:			}
;1065:			CG_LoadClientInfo( ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1067
;1066://			break;
;1067:		}
LABELV $563
line 1068
;1068:	}
LABELV $558
line 1057
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
ASGNP4
LABELV $560
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+32988
INDIRI4
LTI4 $557
line 1069
;1069:}
LABELV $556
endproc CG_ActualLoadDeferredPlayers 20 4
export CG_LoadDeferredPlayers
proc CG_LoadDeferredPlayers 0 0
line 1080
;1070:
;1071:/*
;1072:======================
;1073:CG_LoadDeferredPlayers
;1074:
;1075:Called each frame when a player is dead
;1076:and the scoreboard is up
;1077:so deferred players can be loaded
;1078:======================
;1079:*/
;1080:void CG_LoadDeferredPlayers( void ) {
line 1081
;1081:	cgQueueLoad = qtrue;
ADDRGP4 cgQueueLoad
CNSTI4 1
ASGNI4
line 1082
;1082:}
LABELV $567
endproc CG_LoadDeferredPlayers 0 0
export CG_InRoll
proc CG_InRoll 8 0
line 1095
;1083:
;1084:/*
;1085:=============================================================================
;1086:
;1087:PLAYER ANIMATION
;1088:
;1089:=============================================================================
;1090:*/
;1091:
;1092:static qboolean CG_FirstAnimFrame(clientInfo_t *ci, lerpFrame_t *lf, qboolean torsoOnly, float speedScale);
;1093:
;1094:qboolean CG_InRoll( centity_t *cent )
;1095:{
line 1096
;1096:	switch ( (cent->currentState.legsAnim&~ANIM_TOGGLEBIT) )
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 781
LTI4 $569
ADDRLP4 0
INDIRI4
CNSTI4 784
GTI4 $569
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $576-3124
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $576
address $572
address $572
address $572
address $572
code
line 1097
;1097:	{
LABELV $572
line 1102
;1098:	case BOTH_ROLL_F:
;1099:	case BOTH_ROLL_B:
;1100:	case BOTH_ROLL_R:
;1101:	case BOTH_ROLL_L:
;1102:		if ( cent->pe.legs.animationTime > cg.time )
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $570
line 1103
;1103:		{
line 1104
;1104:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $568
JUMPV
line 1106
;1105:		}
;1106:		break;
LABELV $569
LABELV $570
line 1108
;1107:	}
;1108:	return qfalse;
CNSTI4 0
RETI4
LABELV $568
endproc CG_InRoll 8 0
export CG_InRollAnim
proc CG_InRollAnim 8 0
line 1112
;1109:}
;1110:
;1111:qboolean CG_InRollAnim( centity_t *cent )
;1112:{
line 1113
;1113:	switch ( (cent->currentState.legsAnim&~ANIM_TOGGLEBIT) )
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 781
LTI4 $579
ADDRLP4 0
INDIRI4
CNSTI4 784
GTI4 $579
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $583-3124
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $583
address $582
address $582
address $582
address $582
code
line 1114
;1114:	{
LABELV $582
line 1119
;1115:	case BOTH_ROLL_F:
;1116:	case BOTH_ROLL_B:
;1117:	case BOTH_ROLL_R:
;1118:	case BOTH_ROLL_L:
;1119:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $578
JUMPV
LABELV $579
line 1121
;1120:	}
;1121:	return qfalse;
CNSTI4 0
RETI4
LABELV $578
endproc CG_InRollAnim 8 0
proc CG_SetLerpFrameAnimation 64 40
line 1131
;1122:}
;1123:
;1124:/*
;1125:===============
;1126:CG_SetLerpFrameAnimation
;1127:
;1128:may include ANIM_TOGGLEBIT
;1129:===============
;1130:*/
;1131:static void CG_SetLerpFrameAnimation( centity_t *cent, clientInfo_t *ci, lerpFrame_t *lf, int newAnimation, float animSpeedMult, qboolean torsoOnly) {
line 1134
;1132:	animation_t	*anim;
;1133:	float animSpeed;
;1134:	int	  flags=BONE_ANIM_OVERRIDE_FREEZE;
ADDRLP4 4
CNSTI4 72
ASGNI4
line 1135
;1135:	int oldAnim = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 1136
;1136:	int blendTime = 150;
ADDRLP4 16
CNSTI4 150
ASGNI4
line 1138
;1137:
;1138:	if (cent->currentState.number < MAX_CLIENTS &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 32
GEI4 $586
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $586
ADDRLP4 20
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $586
line 1141
;1139:		cent->currentState.teamowner &&
;1140:		!cent->isATST)
;1141:	{
line 1142
;1142:		return;
ADDRGP4 $585
JUMPV
LABELV $586
line 1145
;1143:	}
;1144:
;1145:	if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $588
line 1146
;1146:	{
line 1150
;1147:		vec3_t testVel;
;1148:		float fVel;
;1149:
;1150:		if (lf->animationNumber == BOTH_RUN1 ||
ADDRLP4 44
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 731
EQI4 $595
ADDRLP4 44
INDIRI4
CNSTI4 723
EQI4 $595
ADDRLP4 44
INDIRI4
CNSTI4 748
EQI4 $595
ADDRLP4 44
INDIRI4
CNSTI4 740
EQI4 $595
ADDRLP4 44
INDIRI4
CNSTI4 741
NEI4 $590
LABELV $595
line 1155
;1151:			lf->animationNumber == BOTH_WALK1 ||
;1152:			lf->animationNumber == BOTH_WALKBACK1 ||
;1153:			lf->animationNumber == BOTH_TURN_LEFT1 ||
;1154:			lf->animationNumber == BOTH_TURN_RIGHT1)
;1155:		{
line 1156
;1156:			if (cent->atstFootClang < cg.time)
ADDRFP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $596
line 1157
;1157:			{
line 1158
;1158:				if (rand() & 1)
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $599
line 1159
;1159:				{
line 1160
;1160:					trap_S_StartSound(NULL, cent->currentState.number, CHAN_AUTO, trap_S_RegisterSound("sound/chars/atst/ATSTstep1.wav"));
ADDRGP4 $601
ARGP4
ADDRLP4 52
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1161
;1161:				}
ADDRGP4 $600
JUMPV
LABELV $599
line 1163
;1162:				else
;1163:				{
line 1164
;1164:					trap_S_StartSound(NULL, cent->currentState.number, CHAN_AUTO, trap_S_RegisterSound("sound/chars/atst/ATSTstep2.wav"));
ADDRGP4 $602
ARGP4
ADDRLP4 52
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1165
;1165:				}
LABELV $600
line 1167
;1166:
;1167:				cent->atstFootClang = cg.time + 1300;
ADDRFP4 0
INDIRP4
CNSTI4 1032
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 1300
ADDI4
ASGNI4
line 1168
;1168:			}
LABELV $596
line 1169
;1169:		}
LABELV $590
line 1171
;1170:
;1171:		VectorCopy(cent->currentState.pos.trDelta, testVel);
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1173
;1172:
;1173:		fVel = VectorNormalize(testVel);
ADDRLP4 28
ARGP4
ADDRLP4 48
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 48
INDIRF4
ASGNF4
line 1175
;1174:
;1175:		if (cent->currentState.eFlags & EF_DEAD)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $604
line 1176
;1176:		{
line 1177
;1177:			if (lf->animationNumber != BOTH_DEATH1 &&
ADDRLP4 52
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $606
ADDRLP4 52
INDIRI4
CNSTI4 42
EQI4 $606
line 1179
;1178:				lf->animationNumber != BOTH_DEAD1)
;1179:			{
line 1180
;1180:				trap_S_StartSound(NULL, cent->currentState.number, CHAN_BODY, trap_S_RegisterSound("sound/chars/atst/ATSTcrash.wav"));
ADDRGP4 $608
ARGP4
ADDRLP4 56
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1181
;1181:			}
LABELV $606
line 1182
;1182:			newAnimation = BOTH_DEATH1;
ADDRFP4 12
CNSTI4 0
ASGNI4
line 1183
;1183:		}
ADDRGP4 $605
JUMPV
LABELV $604
line 1184
;1184:		else if (fVel > 0)
ADDRLP4 40
INDIRF4
CNSTF4 0
LEF4 $609
line 1185
;1185:		{
line 1186
;1186:			qboolean doNotSet = qfalse;
ADDRLP4 52
CNSTI4 0
ASGNI4
line 1188
;1187:
;1188:			if (fVel > 250)
ADDRLP4 40
INDIRF4
CNSTF4 1132068864
LEF4 $611
line 1189
;1189:			{
line 1190
;1190:				animSpeedMult = 1.2;
ADDRFP4 16
CNSTF4 1067030938
ASGNF4
line 1191
;1191:			}
ADDRGP4 $612
JUMPV
LABELV $611
line 1192
;1192:			else if (fVel > 200)
ADDRLP4 40
INDIRF4
CNSTF4 1128792064
LEF4 $613
line 1193
;1193:			{
line 1194
;1194:				animSpeedMult = 1;
ADDRFP4 16
CNSTF4 1065353216
ASGNF4
line 1195
;1195:			}
ADDRGP4 $614
JUMPV
LABELV $613
line 1196
;1196:			else if (fVel > 100)
ADDRLP4 40
INDIRF4
CNSTF4 1120403456
LEF4 $615
line 1197
;1197:			{
line 1198
;1198:				animSpeedMult = 0.9;
ADDRFP4 16
CNSTF4 1063675494
ASGNF4
line 1199
;1199:			}
ADDRGP4 $616
JUMPV
LABELV $615
line 1200
;1200:			else if (fVel > 0)
ADDRLP4 40
INDIRF4
CNSTF4 0
LEF4 $617
line 1201
;1201:			{
line 1202
;1202:				animSpeedMult = 0.8;
ADDRFP4 16
CNSTF4 1061997773
ASGNF4
line 1203
;1203:			}
ADDRGP4 $618
JUMPV
LABELV $617
line 1205
;1204:			else
;1205:			{
line 1206
;1206:				doNotSet = qtrue;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 1207
;1207:			}
LABELV $618
LABELV $616
LABELV $614
LABELV $612
line 1209
;1208:
;1209:			if (!doNotSet)
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $610
line 1210
;1210:			{
line 1211
;1211:				if ((cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) == BOTH_RUN1 ||
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 731
EQI4 $624
ADDRLP4 56
INDIRI4
CNSTI4 748
EQI4 $624
ADDRLP4 56
INDIRI4
CNSTI4 723
NEI4 $621
LABELV $624
line 1214
;1212:					(cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) == BOTH_WALKBACK1 ||
;1213:					(cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) == BOTH_WALK1)
;1214:				{
line 1215
;1215:					newAnimation = (cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT);
ADDRFP4 12
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 1216
;1216:				}
ADDRGP4 $610
JUMPV
LABELV $621
line 1218
;1217:				else
;1218:				{
line 1219
;1219:					newAnimation = BOTH_RUN1;
ADDRFP4 12
CNSTI4 731
ASGNI4
line 1220
;1220:				}
line 1221
;1221:			}
line 1222
;1222:		}
ADDRGP4 $610
JUMPV
LABELV $609
line 1223
;1223:		else if ((cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) == BOTH_RUN1START)
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
CNSTI4 732
NEI4 $625
line 1224
;1224:		{
line 1225
;1225:			if (lf->animationNumber != BOTH_RUN1START)
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 732
EQI4 $627
line 1226
;1226:			{
line 1227
;1227:				trap_S_StartSound(NULL, cent->currentState.number, CHAN_BODY, trap_S_RegisterSound("sound/chars/atst/ATSTstart.wav"));
ADDRGP4 $629
ARGP4
ADDRLP4 52
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1228
;1228:				cent->atstFootClang = cg.time + 650;
ADDRFP4 0
INDIRP4
CNSTI4 1032
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 650
ADDI4
ASGNI4
line 1229
;1229:			}
LABELV $627
line 1230
;1230:			newAnimation = BOTH_RUN1START;
ADDRFP4 12
CNSTI4 732
ASGNI4
line 1231
;1231:		}
ADDRGP4 $626
JUMPV
LABELV $625
line 1232
;1232:		else if (cent->pe.legs.yawing &&
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
CNSTI4 0
EQI4 $631
ADDRLP4 56
ADDRLP4 52
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 3248488448
LTF4 $633
ADDRLP4 56
INDIRF4
CNSTF4 1101004800
LEF4 $631
LABELV $633
line 1234
;1233:			(cent->pe.legs.yawSwingDif < -20 || cent->pe.legs.yawSwingDif > 20))
;1234:		{
line 1235
;1235:			if (cent->pe.legs.yawSwingDif > 0)
ADDRFP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
CNSTF4 0
LEF4 $634
line 1236
;1236:			{
line 1237
;1237:				newAnimation = BOTH_TURN_LEFT1;//BOTH_RUN1;
ADDRFP4 12
CNSTI4 740
ASGNI4
line 1238
;1238:				if (lf->animationNumber != BOTH_TURN_LEFT1)
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 740
EQI4 $635
line 1239
;1239:				{
line 1240
;1240:					cent->atstFootClang = cg.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 1032
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1241
;1241:				}
line 1242
;1242:			}
ADDRGP4 $635
JUMPV
LABELV $634
line 1244
;1243:			else
;1244:			{
line 1245
;1245:				newAnimation = BOTH_TURN_RIGHT1;//BOTH_RUN1;
ADDRFP4 12
CNSTI4 741
ASGNI4
line 1246
;1246:				if (lf->animationNumber != BOTH_TURN_RIGHT1)
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 741
EQI4 $639
line 1247
;1247:				{
line 1248
;1248:					cent->atstFootClang = cg.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 1032
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1249
;1249:				}
LABELV $639
line 1250
;1250:			}
LABELV $635
line 1251
;1251:			animSpeedMult = 0.7;
ADDRFP4 16
CNSTF4 1060320051
ASGNF4
line 1252
;1252:		}
ADDRGP4 $632
JUMPV
LABELV $631
line 1254
;1253:		else
;1254:		{
line 1255
;1255:			newAnimation = BOTH_STAND1;
ADDRFP4 12
CNSTI4 550
ASGNI4
line 1256
;1256:		}
LABELV $632
LABELV $626
LABELV $610
LABELV $605
line 1258
;1257:
;1258:		if (newAnimation != BOTH_STAND1 && newAnimation != BOTH_RUN1 &&
ADDRLP4 60
ADDRFP4 12
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 550
EQI4 $642
ADDRLP4 60
INDIRI4
CNSTI4 731
EQI4 $642
ADDRLP4 60
INDIRI4
CNSTI4 732
EQI4 $642
ADDRLP4 60
INDIRI4
CNSTI4 723
EQI4 $642
ADDRLP4 60
INDIRI4
CNSTI4 748
EQI4 $642
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $642
ADDRLP4 60
INDIRI4
CNSTI4 42
EQI4 $642
ADDRLP4 60
INDIRI4
CNSTI4 741
EQI4 $642
ADDRLP4 60
INDIRI4
CNSTI4 740
EQI4 $642
ADDRLP4 60
INDIRI4
CNSTI4 86
EQI4 $642
ADDRLP4 60
INDIRI4
CNSTI4 87
EQI4 $642
line 1264
;1259:			newAnimation != BOTH_RUN1START && newAnimation != BOTH_WALK1 &&
;1260:			newAnimation != BOTH_WALKBACK1 && newAnimation != BOTH_DEATH1 &&
;1261:			newAnimation != BOTH_DEAD1 && newAnimation != BOTH_TURN_RIGHT1 &&
;1262:			newAnimation != BOTH_TURN_LEFT1 && newAnimation != BOTH_PAIN1 &&
;1263:			newAnimation != BOTH_PAIN2)
;1264:		{ //not a valid anim for the ATST..
line 1265
;1265:			newAnimation = BOTH_RUN1;
ADDRFP4 12
CNSTI4 731
ASGNI4
line 1266
;1266:		}
LABELV $642
line 1268
;1267:
;1268:		if (lf->animationNumber == newAnimation)
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRFP4 12
INDIRI4
NEI4 $644
line 1269
;1269:		{
line 1270
;1270:			return;
ADDRGP4 $585
JUMPV
LABELV $644
line 1284
;1271:		}
;1272:
;1273://		if (lf->animationNumber != BOTH_STAND1 &&
;1274://			((lf->frame-lf->animation->firstFrame) < (lf->animation->numFrames/2)-8 ||
;1275://			(lf->frame-lf->animation->firstFrame) > (lf->animation->numFrames/2)+8))
;1276://		{
;1277://			return;
;1278://		}
;1279:	//	if (lf->animationNumber != BOTH_STAND1 &&
;1280:	//		!CG_FirstAnimFrame(ci, lf, torsoOnly, animSpeedMult))
;1281:	//	{
;1282:	//		return;
;1283:	//	}
;1284:	}
LABELV $588
line 1286
;1285:
;1286:	oldAnim = lf->animationNumber;
ADDRLP4 8
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
line 1288
;1287:
;1288:	lf->animationNumber = newAnimation;
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 12
INDIRI4
ASGNI4
line 1289
;1289:	newAnimation &= ~ANIM_TOGGLEBIT;
ADDRFP4 12
ADDRFP4 12
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 1291
;1290:
;1291:	if ( newAnimation < 0 || newAnimation >= MAX_TOTALANIMATIONS ) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $648
ADDRLP4 28
INDIRI4
CNSTI4 1090
LTI4 $646
LABELV $648
line 1292
;1292:		CG_Error( "Bad animation number: %i", newAnimation );
ADDRGP4 $649
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1293
;1293:	}
LABELV $646
line 1295
;1294:
;1295:	anim = &bgGlobalAnimations[ newAnimation ];
ADDRLP4 0
CNSTI4 28
ADDRFP4 12
INDIRI4
MULI4
ADDRGP4 bgGlobalAnimations
ADDP4
ASGNP4
line 1297
;1296:
;1297:	lf->animation = anim;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1298
;1298:	lf->animationTime = lf->frameTime + anim->initialLerp;
ADDRLP4 32
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 48
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1300
;1299:
;1300:	if ( cg_debugAnim.integer ) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $650
line 1301
;1301:		CG_Printf( "Anim: %i, '%s'\n", newAnimation, GetStringForID(animTable, newAnimation));
ADDRGP4 animTable
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 GetStringForID
CALLP4
ASGNP4
ADDRGP4 $653
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1302
;1302:	}
LABELV $650
line 1304
;1303:
;1304:	if (cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $654
line 1305
;1305:	{
line 1306
;1306:		animSpeed = 50.0f / anim->frameLerp;
ADDRLP4 12
CNSTF4 1112014848
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1307
;1307:		if (lf->animation->loopFrames != -1)
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $656
line 1308
;1308:		{
line 1309
;1309:			flags = BONE_ANIM_OVERRIDE_LOOP;
ADDRLP4 4
CNSTI4 16
ASGNI4
line 1310
;1310:		}
LABELV $656
line 1312
;1311:
;1312:		if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $658
line 1313
;1313:		{
line 1314
;1314:			if (animSpeed < 0.3)
ADDRLP4 12
INDIRF4
CNSTF4 1050253722
GEF4 $660
line 1315
;1315:			{
line 1316
;1316:				animSpeed = 0.3;
ADDRLP4 12
CNSTF4 1050253722
ASGNF4
line 1317
;1317:			}
LABELV $660
line 1319
;1318:
;1319:			if (newAnimation == BOTH_WALKBACK1)
ADDRFP4 12
INDIRI4
CNSTI4 748
NEI4 $662
line 1320
;1320:			{
line 1321
;1321:				animSpeed = 0.8;
ADDRLP4 12
CNSTF4 1061997773
ASGNF4
line 1322
;1322:			}
LABELV $662
line 1324
;1323:
;1324:			if (newAnimation != BOTH_DEATH1)
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $664
line 1325
;1325:			{
line 1326
;1326:				flags = BONE_ANIM_OVERRIDE_LOOP;
ADDRLP4 4
CNSTI4 16
ASGNI4
line 1327
;1327:			}
LABELV $664
line 1328
;1328:		}
LABELV $658
line 1330
;1329:
;1330:		if (cg_animBlend.integer)
ADDRGP4 cg_animBlend+12
INDIRI4
CNSTI4 0
EQI4 $666
line 1331
;1331:		{
line 1332
;1332:			flags |= BONE_ANIM_BLEND;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1333
;1333:		}
LABELV $666
line 1335
;1334:
;1335:		if (!cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
NEI4 $669
line 1336
;1336:		{
line 1337
;1337:			if (/*BG_FlippingAnim(newAnimation) ||*/ BG_InDeathAnim(newAnimation))
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 BG_InDeathAnim
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $671
line 1338
;1338:			{
line 1339
;1339:				flags &= ~BONE_ANIM_BLEND;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1340
;1340:			}
ADDRGP4 $672
JUMPV
LABELV $671
line 1341
;1341:			else if ( oldAnim != -1 &&
ADDRLP4 40
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 -1
EQI4 $673
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 BG_InDeathAnim
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $673
line 1343
;1342:				(/*BG_FlippingAnim(oldAnim) ||*/ BG_InDeathAnim(oldAnim)) )
;1343:			{
line 1344
;1344:				flags &= ~BONE_ANIM_BLEND;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1345
;1345:			}
LABELV $673
LABELV $672
line 1347
;1346:
;1347:			if (flags & BONE_ANIM_BLEND)
ADDRLP4 4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $675
line 1348
;1348:			{
line 1349
;1349:				if (BG_FlippingAnim(newAnimation))
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 BG_FlippingAnim
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $677
line 1350
;1350:				{
line 1351
;1351:					blendTime = 200;
ADDRLP4 16
CNSTI4 200
ASGNI4
line 1352
;1352:				}
ADDRGP4 $678
JUMPV
LABELV $677
line 1353
;1353:				else if ( oldAnim != -1 &&
ADDRLP4 52
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 -1
EQI4 $679
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 BG_FlippingAnim
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $679
line 1355
;1354:					(BG_FlippingAnim(oldAnim)) )
;1355:				{
line 1356
;1356:					blendTime = 200;
ADDRLP4 16
CNSTI4 200
ASGNI4
line 1357
;1357:				}
LABELV $679
LABELV $678
line 1358
;1358:			}
LABELV $675
line 1359
;1359:		}
LABELV $669
line 1361
;1360:
;1361:		animSpeed *= animSpeedMult;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 1363
;1362:
;1363:		if (torsoOnly)
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $681
line 1364
;1364:		{
line 1365
;1365:			lf->animationTorsoSpeed = animSpeedMult;
ADDRFP4 8
INDIRP4
CNSTI4 56
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 1366
;1366:		}
ADDRGP4 $682
JUMPV
LABELV $681
line 1368
;1367:		else
;1368:		{
line 1369
;1369:			lf->animationSpeed = animSpeedMult;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 1370
;1370:		}
LABELV $682
line 1372
;1371:
;1372:		if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $683
line 1373
;1373:		{
line 1374
;1374:			int atstBlend = 400;
ADDRLP4 36
CNSTI4 400
ASGNI4
line 1376
;1375:
;1376:			if (torsoOnly)
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $685
line 1377
;1377:			{
line 1378
;1378:				trap_G2API_SetBoneAnim(cent->ghoul2, 0, "pelvis", anim->firstFrame, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, atstBlend);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $229
ARGP4
ADDRLP4 44
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 1379
;1379:			}
ADDRGP4 $684
JUMPV
LABELV $685
line 1381
;1380:			else
;1381:			{
line 1382
;1382:				trap_G2API_SetBoneAnim(cent->ghoul2, 0, "model_root", anim->firstFrame, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, atstBlend);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 44
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 1383
;1383:			}
line 1384
;1384:		}
ADDRGP4 $684
JUMPV
LABELV $683
line 1386
;1385:		else
;1386:		{
line 1387
;1387:			if (torsoOnly)
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $689
line 1388
;1388:			{
line 1389
;1389:				trap_G2API_SetBoneAnim(cent->ghoul2, 0, "upper_lumbar", anim->firstFrame, anim->firstFrame + anim->numFrames, flags, animSpeed,cg.time, -1, blendTime);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $237
ARGP4
ADDRLP4 40
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 1390
;1390:				cgs.clientinfo[cent->currentState.number].torsoAnim = newAnimation;
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+784
ADDP4
ADDRFP4 12
INDIRI4
ASGNI4
line 1391
;1391:			}
ADDRGP4 $690
JUMPV
LABELV $689
line 1393
;1392:			else
;1393:			{
line 1394
;1394:				trap_G2API_SetBoneAnim(cent->ghoul2, 0, "model_root", anim->firstFrame, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, blendTime);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 40
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 1395
;1395:				cgs.clientinfo[cent->currentState.number].torsoAnim = newAnimation;
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+784
ADDP4
ADDRFP4 12
INDIRI4
ASGNI4
line 1396
;1396:				cgs.clientinfo[cent->currentState.number].legsAnim = newAnimation;
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+780
ADDP4
ADDRFP4 12
INDIRI4
ASGNI4
line 1397
;1397:			}
LABELV $690
line 1413
;1398:
;1399:			/*
;1400:			if ((cent->currentState.torsoAnim&~ANIM_TOGGLEBIT) == newAnimation &&
;1401:				!BG_FlippingAnim( cent->currentState.legsAnim ) &&
;1402:				!BG_SpinningSaberAnim( cent->currentState.legsAnim ) &&
;1403:				!BG_SpinningSaberAnim( cent->currentState.torsoAnim ) &&
;1404:				!BG_InSpecialJump( cent->currentState.legsAnim ) &&
;1405:				!BG_InSpecialJump( cent->currentState.torsoAnim ) &&
;1406:				!BG_InDeathAnim(cent->currentState.legsAnim) &&
;1407:				!BG_InDeathAnim(cent->currentState.torsoAnim) &&
;1408:				!CG_InRoll(cent) &&
;1409:				!BG_SaberInSpecial(cent->currentState.saberMove) &&
;1410:				!BG_SaberInSpecialAttack(cent->currentState.torsoAnim) &&
;1411:				!BG_SaberInSpecialAttack(cent->currentState.legsAnim) )
;1412:				*/
;1413:			if (cg.snap && cg.snap->ps.clientNum == cent->currentState.number)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $699
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $699
line 1414
;1414:			{ //go ahead and use the predicted state if you can.
line 1415
;1415:				if ((cg.predictedPlayerState.torsoAnim&~ANIM_TOGGLEBIT) == newAnimation)
ADDRGP4 cg+96+100
INDIRI4
CNSTI4 -2049
BANDI4
ADDRFP4 12
INDIRI4
NEI4 $700
line 1416
;1416:				{
line 1417
;1417:					trap_G2API_SetBoneAnim(cent->ghoul2, 0, "Motion", anim->firstFrame, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, blendTime);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $245
ARGP4
ADDRLP4 40
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 1418
;1418:				}
line 1419
;1419:			}
ADDRGP4 $700
JUMPV
LABELV $699
line 1421
;1420:			else
;1421:			{
line 1422
;1422:				if ((cent->currentState.torsoAnim&~ANIM_TOGGLEBIT) == newAnimation)
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ADDRFP4 12
INDIRI4
NEI4 $708
line 1423
;1423:				{
line 1424
;1424:					trap_G2API_SetBoneAnim(cent->ghoul2, 0, "Motion", anim->firstFrame, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, blendTime);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $245
ARGP4
ADDRLP4 40
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 1425
;1425:				}
LABELV $708
line 1426
;1426:			}
LABELV $700
line 1427
;1427:		}
LABELV $684
line 1428
;1428:	}
LABELV $654
line 1429
;1429:}
LABELV $585
endproc CG_SetLerpFrameAnimation 64 40
proc CG_FirstAnimFrame 4 0
line 1445
;1430:
;1431:
;1432:/*
;1433:===============
;1434:CG_FirstAnimFrame
;1435:
;1436:Returns true if the lerpframe is on its first frame of animation.
;1437:Otherwise false.
;1438:
;1439:This is used to scale an animation into higher-speed without restarting
;1440:the animation before it completes at normal speed, in the case of a looping
;1441:animation (such as the leg running anim).
;1442:===============
;1443:*/
;1444:static qboolean CG_FirstAnimFrame(clientInfo_t *ci, lerpFrame_t *lf, qboolean torsoOnly, float speedScale)
;1445:{
line 1446
;1446:	if (torsoOnly)
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $712
line 1447
;1447:	{
line 1448
;1448:		if (lf->animationTorsoSpeed == speedScale)
ADDRFP4 4
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
NEF4 $713
line 1449
;1449:		{
line 1450
;1450:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $711
JUMPV
line 1452
;1451:		}
;1452:	}
LABELV $712
line 1454
;1453:	else
;1454:	{
line 1455
;1455:		if (lf->animationSpeed == speedScale)
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
NEF4 $716
line 1456
;1456:		{
line 1457
;1457:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $711
JUMPV
LABELV $716
line 1459
;1458:		}
;1459:	}
LABELV $713
line 1461
;1460:
;1461:	if (lf->animation->numFrames < 2)
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
GEI4 $718
line 1462
;1462:	{
line 1463
;1463:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $711
JUMPV
LABELV $718
line 1466
;1464:	}
;1465:
;1466:	if (lf->animation->firstFrame == lf->frame)
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $720
line 1467
;1467:	{
line 1468
;1468:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $711
JUMPV
LABELV $720
line 1471
;1469:	}
;1470:
;1471:	return qfalse;
CNSTI4 0
RETI4
LABELV $711
endproc CG_FirstAnimFrame 4 0
export CG_InWalkingAnim
proc CG_InWalkingAnim 20 0
line 1483
;1472:}
;1473:
;1474:/*
;1475:===============
;1476:CG_InWalkingAnim
;1477:
;1478:Returns last frame to step on if the animation on the frame is desired for playing footstep sounds,
;1479:otherwise 0
;1480:===============
;1481:*/
;1482:int CG_InWalkingAnim(int animNum)
;1483:{
line 1484
;1484:	int anim = animNum;
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
line 1486
;1485:	
;1486:	anim &= ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 1488
;1487:
;1488:	if (anim == BOTH_WALL_RUN_RIGHT ||
ADDRLP4 0
INDIRI4
CNSTI4 820
EQI4 $725
ADDRLP4 0
INDIRI4
CNSTI4 823
NEI4 $723
LABELV $725
line 1490
;1489:		anim == BOTH_WALL_RUN_LEFT)
;1490:	{
line 1491
;1491:		return 8;
CNSTI4 8
RETI4
ADDRGP4 $722
JUMPV
LABELV $723
line 1494
;1492:	}
;1493:
;1494:	if (anim >= BOTH_WALK1 &&
ADDRLP4 0
INDIRI4
CNSTI4 723
LTI4 $726
ADDRLP4 0
INDIRI4
CNSTI4 746
GTI4 $726
line 1496
;1495:		anim <= BOTH_RUNAWAY1)
;1496:	{
line 1497
;1497:		if (anim == BOTH_RUN1)
ADDRLP4 0
INDIRI4
CNSTI4 731
NEI4 $728
line 1498
;1498:		{
line 1499
;1499:			return 18;//12;
CNSTI4 18
RETI4
ADDRGP4 $722
JUMPV
LABELV $728
line 1502
;1500:		}
;1501:		else
;1502:		{
line 1504
;1503:			//return 9;
;1504:			return 18;
CNSTI4 18
RETI4
ADDRGP4 $722
JUMPV
LABELV $726
line 1508
;1505:		}
;1506:	}
;1507:
;1508:	if (anim >= BOTH_WALKBACK1 &&
ADDRLP4 0
INDIRI4
CNSTI4 748
LTI4 $730
ADDRLP4 0
INDIRI4
CNSTI4 751
GTI4 $730
line 1510
;1509:		anim <= BOTH_RUNBACK2)
;1510:	{
line 1511
;1511:		if (anim == BOTH_WALKBACK1)
ADDRLP4 0
INDIRI4
CNSTI4 748
NEI4 $732
line 1512
;1512:		{
line 1513
;1513:			return 18;
CNSTI4 18
RETI4
ADDRGP4 $722
JUMPV
LABELV $732
line 1516
;1514:		}
;1515:		else
;1516:		{
line 1517
;1517:			return 9;
CNSTI4 9
RETI4
ADDRGP4 $722
JUMPV
LABELV $730
line 1521
;1518:		}
;1519:	}
;1520:
;1521:	if (anim >= LEGS_WALKBACK1 &&
ADDRLP4 0
INDIRI4
CNSTI4 1018
LTI4 $734
ADDRLP4 0
INDIRI4
CNSTI4 1021
GTI4 $734
line 1523
;1522:		anim <= LEGS_RUNBACK2)
;1523:	{
line 1524
;1524:		if (anim == LEGS_WALKBACK1)
ADDRLP4 0
INDIRI4
CNSTI4 1018
NEI4 $736
line 1525
;1525:		{
line 1526
;1526:			return 18;
CNSTI4 18
RETI4
ADDRGP4 $722
JUMPV
LABELV $736
line 1529
;1527:		}
;1528:		else
;1529:		{
line 1530
;1530:			return 9;
CNSTI4 9
RETI4
ADDRGP4 $722
JUMPV
LABELV $734
line 1534
;1531:		}
;1532:	}
;1533:
;1534:	return qfalse;
CNSTI4 0
RETI4
LABELV $722
endproc CG_InWalkingAnim 20 0
lit
align 4
LABELV $739
byte 4 3245342720
byte 4 3245342720
byte 4 3250585600
align 4
LABELV $740
byte 4 1097859072
byte 4 1097859072
byte 4 1109393408
code
proc CG_FootstepForSurface 1204 36
line 1541
;1535:}
;1536:
;1537:#define FOOTSTEP_GENERIC					1
;1538:#define FOOTSTEP_METAL						2
;1539:
;1540:static int CG_FootstepForSurface( centity_t *cent, int skip )
;1541:{
line 1544
;1542:	trace_t tr;
;1543:	vec3_t org, dOrg, legDir, bAngles;
;1544:	vec3_t playerMins = {-15, -15, DEFAULT_MINS_2};
ADDRLP4 1176
ADDRGP4 $739
INDIRB
ASGNB 12
line 1545
;1545:	vec3_t playerMaxs = {15, 15, DEFAULT_MAXS_2};
ADDRLP4 1188
ADDRGP4 $740
INDIRB
ASGNB 12
line 1555
;1546:	mdxaBone_t boltMatrix;
;1547:
;1548://	VectorCopy(ent->lerpOrigin, org);
;1549://	VectorCopy(org, dOrg);
;1550://	dOrg[2] -= 64; //should never have to go further than this because we're already onground
;1551:
;1552:	//We are now tracing off of a bolt point for footsteps, so that if we happen to be walking sideways on a wall we will
;1553:	//still play step sounds properly.
;1554:
;1555:	VectorCopy(cent->lerpAngles, bAngles);
ADDRLP4 1116
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 1556
;1556:	bAngles[PITCH] = 0;
ADDRLP4 1116
CNSTF4 0
ASGNF4
line 1558
;1557:
;1558:	trap_G2API_GetBoltMatrix_NoReconstruct( cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_llumbar, &boltMatrix, bAngles, cent->lerpOrigin, cg.time, /*cgs.gameModels*/0, cent->modelScale);
ADDRLP4 1200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1200
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ADDRLP4 1200
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+528
ADDP4
INDIRI4
ARGI4
ADDRLP4 1128
ARGP4
ADDRLP4 1116
ARGP4
ADDRLP4 1200
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 1200
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix_NoReconstruct
CALLI4
pop
line 1559
;1559:	trap_G2API_GiveMeVectorFromMatrix( &boltMatrix, ORIGIN, org );
ADDRLP4 1128
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 1560
;1560:	trap_G2API_GiveMeVectorFromMatrix( &boltMatrix, NEGATIVE_Y, legDir );
ADDRLP4 1128
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 1104
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 1562
;1561:
;1562:	dOrg[0] = org[0] + legDir[0]*64;
ADDRLP4 1092
ADDRLP4 0
INDIRF4
CNSTF4 1115684864
ADDRLP4 1104
INDIRF4
MULF4
ADDF4
ASGNF4
line 1563
;1563:	dOrg[1] = org[1] + legDir[1]*64;
ADDRLP4 1092+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1115684864
ADDRLP4 1104+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1564
;1564:	dOrg[2] = org[2] + legDir[2]*64;
ADDRLP4 1092+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
ADDRLP4 1104+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1568
;1565:
;1566:	//CG_TestLine(org, dOrg, 100, 0x0000ff, 3);
;1567:
;1568:	CG_Trace(&tr, org, playerMins, playerMaxs, dOrg, skip, MASK_PLAYERSOLID);
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1176
ARGP4
ADDRLP4 1188
ARGP4
ADDRLP4 1092
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 1570
;1569:
;1570:	if (tr.fraction == 1)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $750
line 1571
;1571:	{
line 1572
;1572:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $738
JUMPV
LABELV $750
line 1575
;1573:	}
;1574:
;1575:	if ( tr.surfaceFlags & SURF_NOSTEPS )
ADDRLP4 12+44
INDIRI4
CNSTI4 4194304
BANDI4
CNSTI4 0
EQI4 $753
line 1576
;1576:	{
line 1577
;1577:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $738
JUMPV
LABELV $753
line 1580
;1578:	}
;1579:
;1580:	if ( tr.surfaceFlags & SURF_METALSTEPS )
ADDRLP4 12+44
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $756
line 1581
;1581:	{
line 1582
;1582:		return FOOTSTEP_METAL;
CNSTI4 2
RETI4
ADDRGP4 $738
JUMPV
LABELV $756
line 1585
;1583:	}
;1584:
;1585:	return FOOTSTEP_GENERIC;
CNSTI4 1
RETI4
LABELV $738
endproc CG_FootstepForSurface 1204 36
export CG_FootStep
proc CG_FootStep 28 16
line 1589
;1586:}
;1587:
;1588:void CG_FootStep(centity_t *cent, clientInfo_t *ci, int anim)
;1589:{
line 1592
;1590:	int groundType;
;1591:
;1592:	if ((anim & ~ANIM_TOGGLEBIT) == BOTH_WALL_RUN_RIGHT ||
ADDRLP4 4
ADDRFP4 8
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 820
EQI4 $762
ADDRLP4 4
INDIRI4
CNSTI4 823
NEI4 $760
LABELV $762
line 1594
;1593:		(anim & ~ANIM_TOGGLEBIT) == BOTH_WALL_RUN_LEFT)
;1594:	{
line 1595
;1595:		groundType = FOOTSTEP_GENERIC;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1596
;1596:		goto skipCheck;
ADDRGP4 $763
JUMPV
LABELV $760
line 1599
;1597:	}
;1598:
;1599:	if (cent->currentState.groundEntityNum == ENTITYNUM_NONE)
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $764
line 1600
;1600:	{
line 1601
;1601:		return;
ADDRGP4 $759
JUMPV
LABELV $764
LABELV $763
line 1605
;1602:	}
;1603:
;1604:skipCheck:
;1605:	groundType = CG_FootstepForSurface(cent, cent->currentState.number);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1609
;1606:
;1607://skipCheck:
;1608:
;1609:	if (!groundType)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $766
line 1610
;1610:	{
line 1611
;1611:		return;
ADDRGP4 $759
JUMPV
LABELV $766
line 1614
;1612:	}
;1613:
;1614:	switch (groundType)
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $770
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $773
ADDRGP4 $769
JUMPV
line 1615
;1615:	{
LABELV $770
line 1617
;1616:	case FOOTSTEP_GENERIC:
;1617:		trap_S_StartSound (NULL, cent->currentState.number, CHAN_BODY, 
ADDRLP4 20
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 20
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 cgs+70280+616
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1619
;1618:			cgs.media.footsteps[ ci->footsteps ][rand()&3] );
;1619:		break;
ADDRGP4 $769
JUMPV
LABELV $773
line 1621
;1620:	case FOOTSTEP_METAL:
;1621:		trap_S_StartSound (NULL, cent->currentState.number, CHAN_BODY, 
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 24
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+616+32
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1623
;1622:			cgs.media.footsteps[ FOOTSTEP_METAL ][rand()&3] );
;1623:		break;
line 1625
;1624:	default:
;1625:		break;
LABELV $769
line 1627
;1626:	}
;1627:}
LABELV $759
endproc CG_FootStep 28 16
proc CG_RunLerpFrame 76 40
line 1637
;1628:/*
;1629:===============
;1630:CG_RunLerpFrame
;1631:
;1632:Sets cg.snap, cg.oldFrame, and cg.backlerp
;1633:cg.time should be between oldFrameTime and frameTime after exit
;1634:===============
;1635:*/
;1636:static void CG_RunLerpFrame( centity_t *cent, clientInfo_t *ci, lerpFrame_t *lf, int newAnimation, float speedScale, qboolean torsoOnly) 
;1637:{
line 1642
;1638:	int			f, numFrames;
;1639:	animation_t	*anim;
;1640:
;1641:	// debugging tool to get no animations
;1642:	if ( cg_animSpeed.integer == 0 ) {
ADDRGP4 cg_animSpeed+12
INDIRI4
CNSTI4 0
NEI4 $778
line 1643
;1643:		lf->oldFrame = lf->frame = lf->backlerp = 0;
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1644
;1644:		return;
ADDRGP4 $777
JUMPV
LABELV $778
line 1648
;1645:	}
;1646:
;1647:	// see if the animation sequence is switching
;1648:	if (cent->currentState.forceFrame)
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 0
EQI4 $781
line 1649
;1649:	{
line 1650
;1650:		int flags = BONE_ANIM_OVERRIDE_FREEZE; //|BONE_ANIM_BLEND;
ADDRLP4 12
CNSTI4 72
ASGNI4
line 1651
;1651:		float animSpeed = 1.0f;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 1652
;1652:		trap_G2API_SetBoneAnim(cent->ghoul2, 0, "upper_lumbar", cent->currentState.forceFrame, cent->currentState.forceFrame+1, flags, animSpeed, cg.time, -1, 150);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $237
ARGP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
CNSTI4 150
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 1653
;1653:		trap_G2API_SetBoneAnim(cent->ghoul2, 0, "model_root", cent->currentState.forceFrame, cent->currentState.forceFrame+1, flags, animSpeed, cg.time, -1, 150);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
CNSTI4 150
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 1654
;1654:		trap_G2API_SetBoneAnim(cent->ghoul2, 0, "Motion", cent->currentState.forceFrame, cent->currentState.forceFrame+1, flags, animSpeed, cg.time, -1, 150);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $245
ARGP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
CNSTI4 150
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 1656
;1655:
;1656:		lf->animationNumber = 0;
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 1657
;1657:	}
ADDRGP4 $782
JUMPV
LABELV $781
line 1658
;1658:	else if ( (newAnimation != lf->animationNumber || !lf->animation) || (CG_FirstAnimFrame(ci, lf, torsoOnly, speedScale)) ) 
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRFP4 12
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $788
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $788
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 16
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 CG_FirstAnimFrame
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $786
LABELV $788
line 1659
;1659:	{
line 1660
;1660:		CG_SetLerpFrameAnimation( cent, ci, lf, newAnimation, speedScale, torsoOnly);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1661
;1661:	}
ADDRGP4 $787
JUMPV
LABELV $786
line 1662
;1662:	else if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $789
line 1663
;1663:	{
line 1664
;1664:		if (cent->pe.legs.yawing != !lf->torsoYawing)
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
NEI4 $794
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $795
JUMPV
LABELV $794
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $795
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $791
line 1665
;1665:		{
line 1666
;1666:			CG_SetLerpFrameAnimation( cent, ci, lf, newAnimation, speedScale, torsoOnly);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1667
;1667:			lf->torsoYawing = cent->pe.legs.yawing;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
ASGNI4
line 1668
;1668:		}
LABELV $791
line 1669
;1669:	}
LABELV $789
LABELV $787
LABELV $782
line 1673
;1670:
;1671:	// if we have passed the current frame, move it to
;1672:	// oldFrame and calculate a new frame
;1673:	if ( cg.time >= lf->frameTime ) {
ADDRGP4 cg+64
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LTI4 $796
line 1674
;1674:		if (lf->oldFrame != lf->frame &&
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $799
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CNSTI4 644
ADDP4
CVPU4 4
NEU4 $799
line 1676
;1675:			lf == &(cent->pe.legs))
;1676:		{
line 1677
;1677:			int addFinalFrame = CG_InWalkingAnim(lf->animationNumber); //9;
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_InWalkingAnim
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 28
INDIRI4
ASGNI4
line 1679
;1678:
;1679:			if (!cent->isATST &&
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
NEI4 $801
ADDRLP4 32
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 820
EQI4 $803
ADDRLP4 32
INDIRI4
CNSTI4 823
NEI4 $801
LABELV $803
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $801
line 1682
;1680:				((lf->animationNumber&~ANIM_TOGGLEBIT) == BOTH_WALL_RUN_RIGHT || (lf->animationNumber&~ANIM_TOGGLEBIT) == BOTH_WALL_RUN_LEFT) &&
;1681:				addFinalFrame)
;1682:			{
line 1683
;1683:				if ( lf->frame >= (lf->animation->firstFrame+2) &&
ADDRLP4 36
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
LTI4 $804
ADDRLP4 36
INDIRP4
INDIRI4
ADDRLP4 40
INDIRI4
GEI4 $804
line 1685
;1684:					lf->oldFrame < (lf->animation->firstFrame+2))
;1685:				{
line 1686
;1686:					CG_FootStep(cent, ci, lf->animationNumber);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_FootStep
CALLV
pop
line 1687
;1687:				}
ADDRGP4 $802
JUMPV
LABELV $804
line 1688
;1688:				else if ( lf->frame >= (lf->animation->firstFrame+addFinalFrame) &&
ADDRLP4 44
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
ASGNI4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $806
ADDRLP4 44
INDIRP4
INDIRI4
ADDRLP4 48
INDIRI4
GEI4 $806
line 1690
;1689:					lf->oldFrame < (lf->animation->firstFrame+addFinalFrame))
;1690:				{
line 1691
;1691:					CG_FootStep(cent, ci, lf->animationNumber);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_FootStep
CALLV
pop
line 1692
;1692:				}
ADDRGP4 $802
JUMPV
LABELV $806
line 1693
;1693:				else if ( lf->frame >= (lf->animation->firstFrame+12) &&
ADDRLP4 52
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
LTI4 $808
ADDRLP4 52
INDIRP4
INDIRI4
ADDRLP4 56
INDIRI4
GEI4 $808
line 1695
;1694:					lf->oldFrame < (lf->animation->firstFrame+12))
;1695:				{
line 1696
;1696:					CG_FootStep(cent, ci, lf->animationNumber);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_FootStep
CALLV
pop
line 1697
;1697:				}
ADDRGP4 $802
JUMPV
LABELV $808
line 1698
;1698:				else if ( lf->frame >= (lf->animation->firstFrame+16) &&
ADDRLP4 60
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
LTI4 $810
ADDRLP4 60
INDIRP4
INDIRI4
ADDRLP4 64
INDIRI4
GEI4 $810
line 1700
;1699:					lf->oldFrame < (lf->animation->firstFrame+16))
;1700:				{
line 1701
;1701:					CG_FootStep(cent, ci, lf->animationNumber);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_FootStep
CALLV
pop
line 1702
;1702:				}
ADDRGP4 $802
JUMPV
LABELV $810
line 1703
;1703:				else if (lf->oldFrame > lf->frame && lf->frame > (lf->animation->firstFrame+1))
ADDRLP4 68
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 68
INDIRP4
INDIRI4
ADDRLP4 72
INDIRI4
LEI4 $802
ADDRLP4 72
INDIRI4
ADDRLP4 68
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
LEI4 $802
line 1704
;1704:				{ //missed one
line 1705
;1705:					CG_FootStep(cent, ci, lf->animationNumber);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_FootStep
CALLV
pop
line 1706
;1706:				}
line 1707
;1707:			}
ADDRGP4 $802
JUMPV
LABELV $801
line 1708
;1708:			else if (addFinalFrame && !cent->isATST)
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $814
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $814
line 1709
;1709:			{
line 1710
;1710:				if ( lf->frame >= (lf->animation->firstFrame+3) &&
ADDRLP4 40
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
LTI4 $816
ADDRLP4 40
INDIRP4
INDIRI4
ADDRLP4 44
INDIRI4
GEI4 $816
line 1712
;1711:					lf->oldFrame < (lf->animation->firstFrame+3))
;1712:				{
line 1713
;1713:					CG_FootStep(cent, ci, lf->animationNumber);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_FootStep
CALLV
pop
line 1714
;1714:				}
ADDRGP4 $817
JUMPV
LABELV $816
line 1715
;1715:				else if ( lf->frame >= (lf->animation->firstFrame+addFinalFrame) &&
ADDRLP4 48
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
ASGNI4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
LTI4 $818
ADDRLP4 48
INDIRP4
INDIRI4
ADDRLP4 52
INDIRI4
GEI4 $818
line 1717
;1716:					lf->oldFrame < (lf->animation->firstFrame+addFinalFrame))
;1717:				{
line 1718
;1718:					CG_FootStep(cent, ci, lf->animationNumber);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_FootStep
CALLV
pop
line 1719
;1719:				}
ADDRGP4 $819
JUMPV
LABELV $818
line 1720
;1720:				else if (lf->oldFrame > lf->frame && lf->frame > (lf->animation->firstFrame+1))
ADDRLP4 56
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRP4
INDIRI4
ADDRLP4 60
INDIRI4
LEI4 $820
ADDRLP4 60
INDIRI4
ADDRLP4 56
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
LEI4 $820
line 1721
;1721:				{ //missed one
line 1722
;1722:					CG_FootStep(cent, ci, lf->animationNumber);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_FootStep
CALLV
pop
line 1723
;1723:				}
LABELV $820
LABELV $819
LABELV $817
line 1724
;1724:			}
LABELV $814
LABELV $802
line 1725
;1725:		}
LABELV $799
line 1727
;1726:
;1727:		lf->oldFrame = lf->frame;
ADDRLP4 24
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1728
;1728:		lf->oldFrameTime = lf->frameTime;
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1731
;1729:
;1730:		// get the next frame based on the animation
;1731:		anim = lf->animation;
ADDRLP4 0
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
ASGNP4
line 1732
;1732:		if ( !anim->frameLerp ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $822
line 1733
;1733:			return;		// shouldn't happen
ADDRGP4 $777
JUMPV
LABELV $822
line 1736
;1734:		}
;1735:
;1736:		if ( cg.time < lf->animationTime ) {
ADDRGP4 cg+64
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
GEI4 $824
line 1737
;1737:			lf->frameTime = lf->animationTime;		// initial lerp
ADDRLP4 32
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ASGNI4
line 1738
;1738:		} else {
ADDRGP4 $825
JUMPV
LABELV $824
line 1739
;1739:			lf->frameTime = lf->oldFrameTime + anim->frameLerp;
ADDRLP4 32
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 12
ASGNI4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1740
;1740:		}
LABELV $825
line 1741
;1741:		f = ( lf->frameTime - lf->animationTime ) / anim->frameLerp;
ADDRLP4 32
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 12
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
SUBI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
DIVI4
ASGNI4
line 1742
;1742:		f *= speedScale;		// adjust for haste, etc
ADDRLP4 4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRFP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1744
;1743:
;1744:		numFrames = anim->numFrames;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1745
;1745:		if (anim->flipflop) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $827
line 1746
;1746:			numFrames *= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1747
;1747:		}
LABELV $827
line 1748
;1748:		if ( f >= numFrames ) {
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $829
line 1749
;1749:			f -= numFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1750
;1750:			if ( anim->loopFrames != -1 ) //Before 0 meant no loop
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $831
line 1751
;1751:			{
line 1752
;1752:				if(anim->numFrames - anim->loopFrames == 0)
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CNSTI4 0
NEI4 $833
line 1753
;1753:				{
line 1754
;1754:					f %= anim->numFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
MODI4
ASGNI4
line 1755
;1755:				}
ADDRGP4 $834
JUMPV
LABELV $833
line 1757
;1756:				else
;1757:				{
line 1758
;1758:					f %= (anim->numFrames - anim->loopFrames);
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
MODI4
ASGNI4
line 1759
;1759:				}
LABELV $834
line 1760
;1760:				f += anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1761
;1761:			} 
ADDRGP4 $832
JUMPV
LABELV $831
line 1763
;1762:			else 
;1763:			{
line 1764
;1764:				f = numFrames - 1;
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1767
;1765:				// the animation is stuck at the end, so it
;1766:				// can immediately transition to another sequence
;1767:				lf->frameTime = cg.time;
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1768
;1768:			}
LABELV $832
line 1769
;1769:		}
LABELV $829
line 1770
;1770:		if ( anim->reversed ) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $836
line 1771
;1771:			lf->frame = anim->firstFrame + anim->numFrames - 1 - f;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1772
;1772:		}
ADDRGP4 $837
JUMPV
LABELV $836
line 1773
;1773:		else if (anim->flipflop && f>=anim->numFrames) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $838
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $838
line 1774
;1774:			lf->frame = anim->firstFrame + anim->numFrames - 1 - (f%anim->numFrames);
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 48
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
ADDRLP4 48
INDIRI4
MODI4
SUBI4
ASGNI4
line 1775
;1775:		}
ADDRGP4 $839
JUMPV
LABELV $838
line 1776
;1776:		else {
line 1777
;1777:			lf->frame = anim->firstFrame + f;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1778
;1778:		}
LABELV $839
LABELV $837
line 1779
;1779:		if ( cg.time > lf->frameTime ) {
ADDRGP4 cg+64
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LEI4 $840
line 1780
;1780:			lf->frameTime = cg.time;
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1781
;1781:			if ( cg_debugAnim.integer ) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $844
line 1782
;1782:				CG_Printf( "Clamp lf->frameTime\n");
ADDRGP4 $847
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1783
;1783:			}
LABELV $844
line 1784
;1784:		}
LABELV $840
line 1785
;1785:	}
LABELV $796
line 1787
;1786:
;1787:	if ( lf->frameTime > cg.time + 200 ) {
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
CNSTI4 200
ADDI4
LEI4 $848
line 1788
;1788:		lf->frameTime = cg.time;
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1789
;1789:	}
LABELV $848
line 1791
;1790:
;1791:	if ( lf->oldFrameTime > cg.time ) {
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $852
line 1792
;1792:		lf->oldFrameTime = cg.time;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1793
;1793:	}
LABELV $852
line 1795
;1794:	// calculate current lerp value
;1795:	if ( lf->frameTime == lf->oldFrameTime ) {
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $856
line 1796
;1796:		lf->backlerp = 0;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 0
ASGNF4
line 1797
;1797:	} else {
ADDRGP4 $857
JUMPV
LABELV $856
line 1798
;1798:		lf->backlerp = 1.0 - (float)( cg.time - lf->oldFrameTime ) / ( lf->frameTime - lf->oldFrameTime );
ADDRLP4 24
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1065353216
ADDRGP4 cg+64
INDIRI4
ADDRLP4 28
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
SUBI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 1799
;1799:	}
LABELV $857
line 1800
;1800:}
LABELV $777
endproc CG_RunLerpFrame 76 40
proc CG_ClearLerpFrame 16 24
line 1808
;1801:
;1802:
;1803:/*
;1804:===============
;1805:CG_ClearLerpFrame
;1806:===============
;1807:*/
;1808:static void CG_ClearLerpFrame( centity_t *cent, clientInfo_t *ci, lerpFrame_t *lf, int animationNumber, qboolean torsoOnly) {
line 1809
;1809:	lf->frameTime = lf->oldFrameTime = cg.time;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4
ADDRGP4 cg+64
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1810
;1810:	CG_SetLerpFrameAnimation( cent, ci, lf, animationNumber, 1, torsoOnly );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1811
;1811:	lf->oldFrame = lf->frame = lf->animation->firstFrame;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1812
;1812:}
LABELV $859
endproc CG_ClearLerpFrame 16 24
proc CG_PlayerAnimation 16 24
line 1821
;1813:
;1814:
;1815:/*
;1816:===============
;1817:CG_PlayerAnimation
;1818:===============
;1819:*/
;1820:static void CG_PlayerAnimation( centity_t *cent, int *legsOld, int *legs, float *legsBackLerp,
;1821:						int *torsoOld, int *torso, float *torsoBackLerp ) {
line 1826
;1822:	clientInfo_t	*ci;
;1823:	int				clientNum;
;1824:	float			speedScale;
;1825:
;1826:	clientNum = cent->currentState.clientNum;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ASGNI4
line 1828
;1827:
;1828:	if ( cg_noPlayerAnims.integer ) {
ADDRGP4 cg_noPlayerAnims+12
INDIRI4
CNSTI4 0
EQI4 $862
line 1829
;1829:		*legsOld = *legs = *torsoOld = *torso = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1830
;1830:		return;
ADDRGP4 $861
JUMPV
LABELV $862
line 1833
;1831:	}
;1832:
;1833:	if (cent->currentState.forcePowersActive & (1 << FP_RAGE))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $865
line 1834
;1834:	{
line 1835
;1835:		speedScale = 1.3;
ADDRLP4 0
CNSTF4 1067869798
ASGNF4
line 1836
;1836:	}
ADDRGP4 $866
JUMPV
LABELV $865
line 1837
;1837:	else if (cent->currentState.forcePowersActive & (1 << FP_SPEED))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $867
line 1838
;1838:	{
line 1839
;1839:		speedScale = 1.7;
ADDRLP4 0
CNSTF4 1071225242
ASGNF4
line 1840
;1840:	}
ADDRGP4 $868
JUMPV
LABELV $867
line 1842
;1841:	else
;1842:	{
line 1843
;1843:		speedScale = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1844
;1844:	}
LABELV $868
LABELV $866
line 1846
;1845:
;1846:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 4
CNSTI4 788
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 1849
;1847:
;1848:	// do the shuffle turn frames locally
;1849:	if(0){//	if ( cent->pe.legs.yawing && ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) == TORSO_WEAPONREADY3) {
ADDRGP4 $870
JUMPV
line 1850
;1850:		CG_RunLerpFrame( cent, ci, &cent->pe.legs, LEGS_TURN1, speedScale, qfalse);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 644
ADDP4
ARGP4
CNSTI4 1022
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1851
;1851:	} else {
ADDRGP4 $871
JUMPV
LABELV $870
line 1852
;1852:		CG_RunLerpFrame( cent, ci, &cent->pe.legs, cent->currentState.legsAnim, speedScale, qfalse);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 644
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1853
;1853:	}
LABELV $871
line 1855
;1854:
;1855:	if (!(cent->currentState.forcePowersActive & (1 << FP_RAGE)))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $872
line 1856
;1856:	{ //don't affect torso anim speed unless raged
line 1857
;1857:		speedScale = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1858
;1858:	}
ADDRGP4 $873
JUMPV
LABELV $872
line 1860
;1859:	else
;1860:	{
line 1861
;1861:		speedScale = 1.7;
ADDRLP4 0
CNSTF4 1071225242
ASGNF4
line 1862
;1862:	}
LABELV $873
line 1864
;1863:
;1864:	*legsOld = cent->pe.legs.oldFrame;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
ASGNI4
line 1865
;1865:	*legs = cent->pe.legs.frame;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRI4
ASGNI4
line 1866
;1866:	*legsBackLerp = cent->pe.legs.backlerp;
ADDRFP4 12
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
ASGNF4
line 1868
;1867:
;1868:	CG_RunLerpFrame( cent, ci, &cent->pe.torso, cent->currentState.torsoAnim, speedScale, qtrue );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 708
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1870
;1869:
;1870:	*torsoOld = cent->pe.torso.oldFrame;
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRI4
ASGNI4
line 1871
;1871:	*torso = cent->pe.torso.frame;
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRI4
ASGNI4
line 1872
;1872:	*torsoBackLerp = cent->pe.torso.backlerp;
ADDRFP4 24
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
ASGNF4
line 1873
;1873:}
LABELV $861
endproc CG_PlayerAnimation 16 24
proc CG_SwingAngles 28 8
line 1892
;1874:
;1875:
;1876:
;1877:
;1878:/*
;1879:=============================================================================
;1880:
;1881:PLAYER ANGLES
;1882:
;1883:=============================================================================
;1884:*/
;1885:
;1886:/*
;1887:==================
;1888:CG_SwingAngles
;1889:==================
;1890:*/
;1891:static float CG_SwingAngles( float destination, float swingTolerance, float clampTolerance,
;1892:					float speed, float *angle, qboolean *swinging ) {
line 1897
;1893:	float	swing;
;1894:	float	move;
;1895:	float	scale;
;1896:
;1897:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $875
line 1899
;1898:		// see if a swing should be started
;1899:		swing = AngleSubtract( *angle, destination );
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1900
;1900:		if ( swing > swingTolerance || swing < -swingTolerance ) {
ADDRLP4 20
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
GTF4 $879
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
NEGF4
GEF4 $877
LABELV $879
line 1901
;1901:			*swinging = qtrue;
ADDRFP4 20
INDIRP4
CNSTI4 1
ASGNI4
line 1902
;1902:		}
LABELV $877
line 1903
;1903:	}
LABELV $875
line 1905
;1904:
;1905:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $880
line 1906
;1906:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $874
JUMPV
LABELV $880
line 1911
;1907:	}
;1908:	
;1909:	// modify the speed depending on the delta
;1910:	// so it doesn't seem so linear
;1911:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1912
;1912:	scale = fabs( swing );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 1913
;1913:	if ( scale < swingTolerance * 0.5 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
MULF4
GEF4 $882
line 1914
;1914:		scale = 0.5;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1915
;1915:	} else if ( scale < swingTolerance ) {
ADDRGP4 $883
JUMPV
LABELV $882
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
GEF4 $884
line 1916
;1916:		scale = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1917
;1917:	} else {
ADDRGP4 $885
JUMPV
LABELV $884
line 1918
;1918:		scale = 2.0;
ADDRLP4 4
CNSTF4 1073741824
ASGNF4
line 1919
;1919:	}
LABELV $885
LABELV $883
line 1922
;1920:
;1921:	// swing towards the destination angle
;1922:	if ( swing >= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LTF4 $886
line 1923
;1923:		move = cg.frametime * scale * speed;
ADDRLP4 8
ADDRGP4 cg+60
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 1924
;1924:		if ( move >= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
LTF4 $889
line 1925
;1925:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1926
;1926:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1927
;1927:		}
LABELV $889
line 1928
;1928:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1929
;1929:	} else if ( swing < 0 ) {
ADDRGP4 $887
JUMPV
LABELV $886
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $891
line 1930
;1930:		move = cg.frametime * scale * -speed;
ADDRLP4 8
ADDRGP4 cg+60
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
NEGF4
MULF4
ASGNF4
line 1931
;1931:		if ( move <= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $894
line 1932
;1932:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1933
;1933:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1934
;1934:		}
LABELV $894
line 1935
;1935:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1936
;1936:	}
LABELV $891
LABELV $887
line 1939
;1937:
;1938:	// clamp to no more than tolerance
;1939:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 1940
;1940:	if ( swing > clampTolerance ) {
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $896
line 1941
;1941:		*angle = AngleMod( destination - (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
SUBF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1942
;1942:	} else if ( swing < -clampTolerance ) {
ADDRGP4 $897
JUMPV
LABELV $896
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $898
line 1943
;1943:		*angle = AngleMod( destination + (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1944
;1944:	}
LABELV $898
LABELV $897
line 1946
;1945:
;1946:	return swing;
ADDRLP4 0
INDIRF4
RETF4
LABELV $874
endproc CG_SwingAngles 28 8
proc CG_SwingAnglesATST 36 8
line 1955
;1947:}
;1948:
;1949:/*
;1950:==================
;1951:CG_SwingAngles
;1952:==================
;1953:*/
;1954:static float CG_SwingAnglesATST( centity_t *cent, float destination, float swingTolerance, float clampTolerance,
;1955:					float speed, float *angle, qboolean *swinging ) {
line 1960
;1956:	float	swing;
;1957:	float	move;
;1958:	float	scale;
;1959:
;1960:	if ( !*swinging ) {
ADDRFP4 24
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $901
line 1962
;1961:		// see if a swing should be started
;1962:		swing = AngleSubtract( *angle, destination );
ADDRFP4 20
INDIRP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1963
;1963:		if ( swing > swingTolerance || swing < -swingTolerance ) {
ADDRLP4 20
ADDRFP4 8
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
GTF4 $905
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
NEGF4
GEF4 $903
LABELV $905
line 1964
;1964:			*swinging = qtrue;
ADDRFP4 24
INDIRP4
CNSTI4 1
ASGNI4
line 1965
;1965:		}
LABELV $903
line 1966
;1966:	}
LABELV $901
line 1968
;1967:
;1968:	if ( !*swinging ) {
ADDRFP4 24
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $906
line 1969
;1969:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $900
JUMPV
LABELV $906
line 1974
;1970:	}
;1971:	
;1972:	// modify the speed depending on the delta
;1973:	// so it doesn't seem so linear
;1974:	swing = AngleSubtract( destination, *angle );
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1975
;1975:	scale = fabs( swing );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 1976
;1976:	if ( scale < swingTolerance * 0.5 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 8
INDIRF4
MULF4
GEF4 $908
line 1977
;1977:		scale = 0.5;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1978
;1978:	} else if ( scale < swingTolerance ) {
ADDRGP4 $909
JUMPV
LABELV $908
ADDRLP4 4
INDIRF4
ADDRFP4 8
INDIRF4
GEF4 $910
line 1979
;1979:		scale = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1980
;1980:	} else {
ADDRGP4 $911
JUMPV
LABELV $910
line 1981
;1981:		scale = 2.0;
ADDRLP4 4
CNSTF4 1073741824
ASGNF4
line 1982
;1982:	}
LABELV $911
LABELV $909
line 1984
;1983:
;1984:	if (swing < 10 && swing > -10)
ADDRLP4 0
INDIRF4
CNSTF4 1092616192
GEF4 $912
ADDRLP4 0
INDIRF4
CNSTF4 3240099840
LEF4 $912
line 1985
;1985:	{
line 1986
;1986:		cent->atstSwinging = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1036
ADDP4
CNSTI4 0
ASGNI4
line 1987
;1987:	}
LABELV $912
line 1988
;1988:	if (swing < 60 && swing > -60 && !cent->atstSwinging)
ADDRLP4 0
INDIRF4
CNSTF4 1114636288
GEF4 $914
ADDRLP4 0
INDIRF4
CNSTF4 3262119936
LEF4 $914
ADDRFP4 0
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
CNSTI4 0
NEI4 $914
line 1989
;1989:	{
line 1990
;1990:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $900
JUMPV
LABELV $914
line 1993
;1991:	}
;1992:
;1993:	cent->atstSwinging = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1036
ADDP4
CNSTI4 1
ASGNI4
line 1996
;1994:
;1995:	// swing towards the destination angle
;1996:	if ( swing >= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LTF4 $916
line 1997
;1997:		move = cg.frametime * scale * speed;
ADDRLP4 8
ADDRGP4 cg+60
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 1998
;1998:		if ( move >= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
LTF4 $919
line 1999
;1999:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 2000
;2000:			*swinging = qfalse;
ADDRFP4 24
INDIRP4
CNSTI4 0
ASGNI4
line 2001
;2001:		}
LABELV $919
line 2002
;2002:		*angle = AngleMod( *angle + move );
ADDRLP4 28
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 32
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRF4
ASGNF4
line 2003
;2003:	} else if ( swing < 0 ) {
ADDRGP4 $917
JUMPV
LABELV $916
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $921
line 2004
;2004:		move = cg.frametime * scale * -speed;
ADDRLP4 8
ADDRGP4 cg+60
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
NEGF4
MULF4
ASGNF4
line 2005
;2005:		if ( move <= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $924
line 2006
;2006:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 2007
;2007:			*swinging = qfalse;
ADDRFP4 24
INDIRP4
CNSTI4 0
ASGNI4
line 2008
;2008:		}
LABELV $924
line 2009
;2009:		*angle = AngleMod( *angle + move );
ADDRLP4 28
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 32
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRF4
ASGNF4
line 2010
;2010:	}
LABELV $921
LABELV $917
line 2013
;2011:
;2012:	// clamp to no more than tolerance
;2013:	swing = AngleSubtract( destination, *angle );
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ASGNF4
line 2014
;2014:	if ( swing > clampTolerance ) {
ADDRLP4 0
INDIRF4
ADDRFP4 12
INDIRF4
LEF4 $926
line 2015
;2015:		*angle = AngleMod( destination - (clampTolerance - 1) );
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
SUBF4
SUBF4
ARGF4
ADDRLP4 32
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 20
INDIRP4
ADDRLP4 32
INDIRF4
ASGNF4
line 2016
;2016:	} else if ( swing < -clampTolerance ) {
ADDRGP4 $927
JUMPV
LABELV $926
ADDRLP4 0
INDIRF4
ADDRFP4 12
INDIRF4
NEGF4
GEF4 $928
line 2017
;2017:		*angle = AngleMod( destination + (clampTolerance - 1) );
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ARGF4
ADDRLP4 32
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 20
INDIRP4
ADDRLP4 32
INDIRF4
ASGNF4
line 2018
;2018:	}
LABELV $928
LABELV $927
line 2020
;2019:
;2020:	return swing;
ADDRLP4 0
INDIRF4
RETF4
LABELV $900
endproc CG_SwingAnglesATST 36 8
proc CG_AddPainTwitch 12 0
line 2028
;2021:}
;2022:
;2023:/*
;2024:=================
;2025:CG_AddPainTwitch
;2026:=================
;2027:*/
;2028:static void CG_AddPainTwitch( centity_t *cent, vec3_t torsoAngles ) {
line 2032
;2029:	int		t;
;2030:	float	f;
;2031:
;2032:	t = cg.time - cent->pe.painTime;
ADDRLP4 0
ADDRGP4 cg+64
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2033
;2033:	if ( t >= PAIN_TWITCH_TIME ) {
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $932
line 2034
;2034:		return;
ADDRGP4 $930
JUMPV
LABELV $932
line 2037
;2035:	}
;2036:
;2037:	f = 1.0 - (float)t / PAIN_TWITCH_TIME;
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 2039
;2038:
;2039:	if ( cent->pe.painDirection ) {
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CNSTI4 0
EQI4 $934
line 2040
;2040:		torsoAngles[ROLL] += 20 * f;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1101004800
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2041
;2041:	} else {
ADDRGP4 $935
JUMPV
LABELV $934
line 2042
;2042:		torsoAngles[ROLL] -= 20 * f;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1101004800
ADDRLP4 4
INDIRF4
MULF4
SUBF4
ASGNF4
line 2043
;2043:	}
LABELV $935
line 2044
;2044:}
LABELV $930
endproc CG_AddPainTwitch 12 0
export CG_G2SetBoneAngles
proc CG_G2SetBoneAngles 0 44
ADDRFP4 16
ADDRFP4 16
INDIRI4
ASGNI4
ADDRFP4 20
ADDRFP4 20
INDIRI4
ASGNI4
ADDRFP4 24
ADDRFP4 24
INDIRI4
ASGNI4
ADDRFP4 28
ADDRFP4 28
INDIRI4
ASGNI4
line 2068
;2045:
;2046:
;2047:typedef struct boneAngleParms_s {
;2048:	void *ghoul2;
;2049:	int modelIndex;
;2050:	char *boneName;
;2051:	vec3_t angles;
;2052:	int flags;
;2053:	int up;
;2054:	int right;
;2055:	int forward;
;2056:	qhandle_t *modelList;
;2057:	int blendTime;
;2058:	int currentTime;
;2059:
;2060:	qboolean refreshSet;
;2061:} boneAngleParms_t;
;2062:
;2063:boneAngleParms_t cgBoneAnglePostSet;
;2064:
;2065:void CG_G2SetBoneAngles(void *ghoul2, int modelIndex, const char *boneName, const vec3_t angles, const int flags,
;2066:								const int up, const int right, const int forward, qhandle_t *modelList,
;2067:								int blendTime , int currentTime )
;2068:{ //we want to hold off on setting the bone angles until the end of the frame, because every time we set
line 2093
;2069:  //them the entire skeleton has to be reconstructed.
;2070:#if 0
;2071:	//This function should ONLY be called from CG_Player() or a function that is called only within CG_Player().
;2072:	//At the end of the frame we will check to use this information to call SetBoneAngles
;2073:	memset(&cgBoneAnglePostSet, 0, sizeof(cgBoneAnglePostSet));
;2074:	cgBoneAnglePostSet.ghoul2 = ghoul2;
;2075:	cgBoneAnglePostSet.modelIndex = modelIndex;
;2076:	cgBoneAnglePostSet.boneName = (char *)boneName;
;2077:
;2078:	cgBoneAnglePostSet.angles[0] = angles[0];
;2079:	cgBoneAnglePostSet.angles[1] = angles[1];
;2080:	cgBoneAnglePostSet.angles[2] = angles[2];
;2081:
;2082:	cgBoneAnglePostSet.flags = flags;
;2083:	cgBoneAnglePostSet.up = up;
;2084:	cgBoneAnglePostSet.right = right;
;2085:	cgBoneAnglePostSet.forward = forward;
;2086:	cgBoneAnglePostSet.modelList = modelList;
;2087:	cgBoneAnglePostSet.blendTime = blendTime;
;2088:	cgBoneAnglePostSet.currentTime = currentTime;
;2089:
;2090:	cgBoneAnglePostSet.refreshSet = qtrue;
;2091:#endif
;2092:	//Unfortunately the above doesn't really work.
;2093:	trap_G2API_SetBoneAngles(ghoul2, modelIndex, boneName, angles, flags, up, right, forward, modelList,
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRFP4 40
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 2095
;2094:		blendTime, currentTime);
;2095:}
LABELV $936
endproc CG_G2SetBoneAngles 0 44
export CG_G2ClientSpineAngles
proc CG_G2ClientSpineAngles 216 36
line 2098
;2096:
;2097:void CG_G2ClientSpineAngles( centity_t *cent, vec3_t viewAngles, const vec3_t angles, vec3_t thoracicAngles, vec3_t ulAngles, vec3_t llAngles )
;2098:{
line 2099
;2099:	int ang = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2101
;2100:
;2101:	if (cent->isATST || cent->currentState.teamowner)
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $940
ADDRLP4 4
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $938
LABELV $940
line 2102
;2102:	{
line 2103
;2103:		return;
ADDRGP4 $937
JUMPV
LABELV $938
line 2106
;2104:	}
;2105:
;2106:	VectorClear(ulAngles);
ADDRLP4 12
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRF4
ASGNF4
line 2107
;2107:	VectorClear(llAngles);
ADDRLP4 20
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 2110
;2108:
;2109:	//cent->pe.torso.pitchAngle = viewAngles[PITCH];
;2110:	viewAngles[YAW] = AngleDelta( cent->lerpAngles[YAW], angles[YAW] );
ADDRFP4 0
INDIRP4
CNSTI4 944
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 AngleDelta
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 2113
;2111:	//cent->pe.torso.yawAngle = viewAngles[YAW];
;2112:
;2113:	if ( !BG_FlippingAnim( cent->currentState.legsAnim ) &&
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 BG_FlippingAnim
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 BG_SpinningSaberAnim
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 BG_SpinningSaberAnim
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 BG_InSpecialJump
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 BG_InSpecialJump
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 BG_InDeathAnim
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 BG_InDeathAnim
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_InRoll
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 CG_InRollAnim
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 BG_SaberInSpecial
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 BG_SaberInSpecialAttack
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $941
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 BG_SaberInSpecialAttack
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
NEI4 $941
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+780
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 BG_FlippingAnim
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $941
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+780
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 BG_SpinningSaberAnim
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $941
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+784
ADDP4
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 BG_SpinningSaberAnim
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $941
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+780
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 BG_InSpecialJump
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $941
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+784
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 BG_InSpecialJump
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $941
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+780
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 BG_InDeathAnim
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $941
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+784
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 BG_InDeathAnim
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $941
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+784
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BG_SaberInSpecialAttack
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $941
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+780
ADDP4
INDIRI4
ARGI4
ADDRLP4 116
ADDRGP4 BG_SaberInSpecialAttack
CALLI4
ASGNI4
ADDRLP4 120
CNSTI4 0
ASGNI4
ADDRLP4 116
INDIRI4
ADDRLP4 120
INDIRI4
NEI4 $941
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 120
INDIRI4
NEI4 $941
line 2145
;2114:		!BG_SpinningSaberAnim( cent->currentState.legsAnim ) &&
;2115:		!BG_SpinningSaberAnim( cent->currentState.torsoAnim ) &&
;2116:		!BG_InSpecialJump( cent->currentState.legsAnim ) &&
;2117:		!BG_InSpecialJump( cent->currentState.torsoAnim ) &&
;2118:		!BG_InDeathAnim(cent->currentState.legsAnim) &&
;2119:		!BG_InDeathAnim(cent->currentState.torsoAnim) &&
;2120:		!CG_InRoll(cent) &&
;2121:		!CG_InRollAnim(cent) &&
;2122:		!BG_SaberInSpecial(cent->currentState.saberMove) &&
;2123:		!BG_SaberInSpecialAttack(cent->currentState.torsoAnim) &&
;2124:		!BG_SaberInSpecialAttack(cent->currentState.legsAnim) &&
;2125:
;2126:		!BG_FlippingAnim( cgs.clientinfo[cent->currentState.number].legsAnim ) &&
;2127:		!BG_SpinningSaberAnim( cgs.clientinfo[cent->currentState.number].legsAnim ) &&
;2128:		!BG_SpinningSaberAnim( cgs.clientinfo[cent->currentState.number].torsoAnim ) &&
;2129:		!BG_InSpecialJump( cgs.clientinfo[cent->currentState.number].legsAnim ) &&
;2130:		!BG_InSpecialJump( cgs.clientinfo[cent->currentState.number].torsoAnim ) &&
;2131:		!BG_InDeathAnim(cgs.clientinfo[cent->currentState.number].legsAnim) &&
;2132:		!BG_InDeathAnim(cgs.clientinfo[cent->currentState.number].torsoAnim) &&
;2133:		!BG_SaberInSpecialAttack(cgs.clientinfo[cent->currentState.number].torsoAnim) &&
;2134:		!BG_SaberInSpecialAttack(cgs.clientinfo[cent->currentState.number].legsAnim) &&
;2135:
;2136:		/*
;2137:		!BG_FlippingAnim( cent->rootBone ) &&
;2138:		!BG_SpinningSaberAnim( cent->rootBone ) &&
;2139:		!BG_InSpecialJump( cent->rootBone ) &&
;2140:		!BG_InDeathAnim(cent->rootBone) &&
;2141:		!BG_SaberInSpecialAttack(cent->rootBone) &&
;2142:		*/
;2143:
;2144:		!(cent->currentState.eFlags & EF_DEAD) )
;2145:	{
line 2151
;2146:		//adjust for motion offset
;2147:		mdxaBone_t	boltMatrix;
;2148:		vec3_t		motionFwd, motionAngles;
;2149:
;2150:		//trap_G2API_GetBoltMatrix( cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_motion, &boltMatrix, vec3_origin, cent->lerpOrigin, cg.time, /*cgs.gameModels*/0, cent->modelScale);
;2151:		trap_G2API_GetBoltMatrix_NoReconstruct( cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_motion, &boltMatrix, vec3_origin, cent->lerpOrigin, cg.time, /*cgs.gameModels*/0, cent->modelScale);
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ADDRLP4 196
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+524
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 196
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 196
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix_NoReconstruct
CALLI4
pop
line 2154
;2152:	//	trap_G2API_GiveMeVectorFromMatrix( &boltMatrix, POSITIVE_X, motionFwd );
;2153:		//trap_G2API_GiveMeVectorFromMatrix( &boltMatrix, POSITIVE_Y, motionFwd );
;2154:		trap_G2API_GiveMeVectorFromMatrix( &boltMatrix, NEGATIVE_Y, motionFwd );
ADDRLP4 136
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 184
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 2156
;2155:
;2156:		vectoangles( motionFwd, motionAngles );
ADDRLP4 184
ARGP4
ADDRLP4 124
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2157
;2157:		for ( ang = 0; ang < 3; ang++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $964
line 2158
;2158:		{
line 2159
;2159:			viewAngles[ang] = AngleNormalize180( viewAngles[ang] - AngleNormalize180( motionAngles[ang] ) );
ADDRLP4 200
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 200
INDIRI4
ADDRLP4 124
ADDP4
INDIRF4
ARGF4
ADDRLP4 204
ADDRGP4 AngleNormalize180
CALLF4
ASGNF4
ADDRLP4 208
ADDRLP4 200
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
ASGNP4
ADDRLP4 208
INDIRP4
INDIRF4
ADDRLP4 204
INDIRF4
SUBF4
ARGF4
ADDRLP4 212
ADDRGP4 AngleNormalize180
CALLF4
ASGNF4
ADDRLP4 208
INDIRP4
ADDRLP4 212
INDIRF4
ASGNF4
line 2160
;2160:		}
LABELV $965
line 2157
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $964
line 2169
;2161:
;2162:		//Using NEGATIVE_Y and subtractinging 90 seems to magically fix our horrible contortion issues.
;2163:		//SP actually just uses NEGATIVE_Y without this. Unfortunately we have some sort of worthless
;2164:		//chunk of code in our GBM function that rotates the entire matrix 90 degrees before returning
;2165:		//a "proper" direction. SP does not have this. And I am not even going to consider changing it at
;2166:		//this point to match.
;2167:		//Com_Printf("Comp: %f %f %f\n", viewAngles[0], viewAngles[1], viewAngles[2]);
;2168:
;2169:		if (viewAngles[YAW] < -90)
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 3266576384
GEF4 $968
line 2170
;2170:		{
line 2171
;2171:			viewAngles[YAW] += 360;
ADDRLP4 200
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 200
INDIRP4
ADDRLP4 200
INDIRP4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 2172
;2172:		}
LABELV $968
line 2174
;2173:
;2174:		viewAngles[YAW] -= 90;
ADDRLP4 200
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 200
INDIRP4
ADDRLP4 200
INDIRP4
INDIRF4
CNSTF4 1119092736
SUBF4
ASGNF4
line 2175
;2175:	}
LABELV $941
line 2178
;2176:	//distribute the angles differently up the spine
;2177:	//NOTE: each of these distributions must add up to 1.0f
;2178:	thoracicAngles[PITCH] = 0;//viewAngles[PITCH]*0.20f;
ADDRFP4 12
INDIRP4
CNSTF4 0
ASGNF4
line 2179
;2179:	llAngles[PITCH] = 0;//viewAngles[PITCH]*0.40f;
ADDRFP4 20
INDIRP4
CNSTF4 0
ASGNF4
line 2180
;2180:	ulAngles[PITCH] = 0;//viewAngles[PITCH]*0.40f;
ADDRFP4 16
INDIRP4
CNSTF4 0
ASGNF4
line 2182
;2181:
;2182:	thoracicAngles[YAW] = viewAngles[YAW]*0.20f - (viewAngles[PITCH]*(viewAngles[YAW]*.020f));
ADDRLP4 124
CNSTI4 4
ASGNI4
ADDRLP4 128
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 132
ADDRLP4 128
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRFP4 12
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
CNSTF4 1045220557
ADDRLP4 132
INDIRF4
MULF4
ADDRLP4 128
INDIRP4
INDIRF4
CNSTF4 1017370378
ADDRLP4 132
INDIRF4
MULF4
MULF4
SUBF4
ASGNF4
line 2183
;2183:	ulAngles[YAW] = viewAngles[YAW]*0.25f - (viewAngles[PITCH]*(viewAngles[YAW]*.0005f));
ADDRLP4 136
CNSTI4 4
ASGNI4
ADDRLP4 140
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 140
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
CNSTF4 1048576000
ADDRLP4 144
INDIRF4
MULF4
ADDRLP4 140
INDIRP4
INDIRF4
CNSTF4 973279855
ADDRLP4 144
INDIRF4
MULF4
MULF4
SUBF4
ASGNF4
line 2184
;2184:	llAngles[YAW] = viewAngles[YAW]*0.25f - (viewAngles[PITCH]*(viewAngles[YAW]*.0005f));
ADDRLP4 148
CNSTI4 4
ASGNI4
ADDRLP4 152
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 156
ADDRLP4 152
INDIRP4
ADDRLP4 148
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRFP4 20
INDIRP4
ADDRLP4 148
INDIRI4
ADDP4
CNSTF4 1048576000
ADDRLP4 156
INDIRF4
MULF4
ADDRLP4 152
INDIRP4
INDIRF4
CNSTF4 973279855
ADDRLP4 156
INDIRF4
MULF4
MULF4
SUBF4
ASGNF4
line 2186
;2185:
;2186:	if (thoracicAngles[YAW] > 20)
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1101004800
LEF4 $970
line 2187
;2187:	{
line 2188
;2188:		thoracicAngles[YAW] = 20;
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1101004800
ASGNF4
line 2189
;2189:	}
LABELV $970
line 2190
;2190:	if (ulAngles[YAW] > 20)
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1101004800
LEF4 $972
line 2191
;2191:	{
line 2192
;2192:		ulAngles[YAW] = 20;
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1101004800
ASGNF4
line 2193
;2193:	}
LABELV $972
line 2194
;2194:	if (llAngles[YAW] > 20)
ADDRFP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1101004800
LEF4 $974
line 2195
;2195:	{
line 2196
;2196:		llAngles[YAW] = 20;
ADDRFP4 20
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1101004800
ASGNF4
line 2197
;2197:	}
LABELV $974
line 2199
;2198:
;2199:	thoracicAngles[ROLL] = viewAngles[ROLL]*0.20f;
ADDRLP4 160
CNSTI4 8
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
CNSTF4 1045220557
ADDRFP4 4
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
INDIRF4
MULF4
ASGNF4
line 2200
;2200:	ulAngles[ROLL] = viewAngles[ROLL]*0.35f;
ADDRLP4 164
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
CNSTF4 1051931443
ADDRFP4 4
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRF4
MULF4
ASGNF4
line 2201
;2201:	llAngles[ROLL] = viewAngles[ROLL]*0.45f;
ADDRLP4 168
CNSTI4 8
ASGNI4
ADDRFP4 20
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
CNSTF4 1055286886
ADDRFP4 4
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRF4
MULF4
ASGNF4
line 2203
;2202:	
;2203:	for ( ang = 0; ang < 3; ang++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $976
line 2204
;2204:	{
line 2205
;2205:		if (ulAngles[ang] < 0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 16
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $980
line 2206
;2206:		{
line 2207
;2207:			ulAngles[ang] += 360;
ADDRLP4 172
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 16
INDIRP4
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 2208
;2208:		}
LABELV $980
line 2209
;2209:	}
LABELV $977
line 2203
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $976
line 2218
;2210:
;2211:	//thoracic is added modified again by neckAngle calculations, so don't set it until then
;2212://	BG_G2SetBoneAngles( cent, cent->gent, cent->gent->upperLumbarBone, ulAngles, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.model_draw); 
;2213://	BG_G2SetBoneAngles( cent, cent->gent, cent->gent->lowerLumbarBone, llAngles, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.model_draw); 
;2214:
;2215://	trap_G2API_SetBoneAngles(cent->ghoul2, 0, "upper_lumbar", ulAngles, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
;2216://	trap_G2API_SetBoneAngles(cent->ghoul2, 0, "lower_lumbar", llAngles, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
;2217://	trap_G2API_SetBoneAngles(cent->ghoul2, 0, "thoracic", thoracicAngles, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
;2218:}
LABELV $937
endproc CG_G2ClientSpineAngles 216 36
data
align 4
LABELV $983
byte 4 0
byte 4 22
byte 4 45
byte 4 -22
byte 4 0
byte 4 22
byte 4 -45
byte 4 -22
lit
align 4
LABELV $984
byte 4 0
byte 4 0
byte 4 0
code
proc CG_G2PlayerAngles 264 44
line 2220
;2219:
;2220:static void CG_G2PlayerAngles( centity_t *cent, vec3_t legs[3], vec3_t legsAngles){
line 2228
;2221:	vec3_t		torsoAngles, headAngles;
;2222:	float		dest;
;2223:	static	int	movementOffsets[8] = { 0, 22, 45, -22, 0, 22, -45, -22 };
;2224:	vec3_t		velocity;
;2225:	float		speed; //, speed_dif, speed_desired;
;2226:	int			dir;
;2227:	vec3_t		velPos, velAng;
;2228:	int			adddir = 0;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 2230
;2229:	float		dif;
;2230:	float		degrees_negative = 0;
ADDRLP4 132
CNSTF4 0
ASGNF4
line 2231
;2231:	float		degrees_positive = 0;
ADDRLP4 136
CNSTF4 0
ASGNF4
line 2232
;2232:	vec3_t		ulAngles, llAngles, viewAngles, angles, thoracicAngles = {0,0,0};
ADDRLP4 60
ADDRGP4 $984
INDIRB
ASGNB 12
line 2234
;2233:
;2234:	VectorCopy( cent->lerpAngles, headAngles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 2235
;2235:	headAngles[YAW] = AngleMod( headAngles[YAW] );
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 148
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 148
INDIRF4
ASGNF4
line 2236
;2236:	VectorClear( legsAngles );
ADDRLP4 152
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 156
CNSTF4 0
ASGNF4
ADDRLP4 152
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 156
INDIRF4
ASGNF4
ADDRLP4 152
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 156
INDIRF4
ASGNF4
ADDRLP4 152
INDIRP4
ADDRLP4 156
INDIRF4
ASGNF4
line 2237
;2237:	VectorClear( torsoAngles );
ADDRLP4 160
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 160
INDIRF4
ASGNF4
line 2242
;2238:
;2239:	// --------- yaw -------------
;2240:
;2241:	// allow yaw to drift a bit
;2242:	if ((( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) != BOTH_STAND1) || 
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
CNSTI4 -2049
ASGNI4
ADDRLP4 164
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRLP4 168
INDIRI4
BANDI4
CNSTI4 550
NEI4 $991
ADDRLP4 164
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ADDRLP4 168
INDIRI4
BANDI4
ADDRLP4 164
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 WeaponReadyAnim
ADDP4
INDIRI4
EQI4 $989
LABELV $991
line 2244
;2243:			( cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT ) != WeaponReadyAnim[cent->currentState.weapon]  ) 
;2244:	{
line 2246
;2245:		// if not standing still, always point all in the same direction
;2246:		cent->pe.torso.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 1
ASGNI4
line 2247
;2247:		cent->pe.torso.pitching = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 1
ASGNI4
line 2248
;2248:		cent->pe.legs.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTI4 1
ASGNI4
line 2249
;2249:	}
LABELV $989
line 2252
;2250:
;2251:	// adjust legs for movement dir
;2252:	if ( cent->currentState.eFlags & EF_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $992
line 2254
;2253:		// don't let dead bodies twitch
;2254:		dir = 0;
ADDRLP4 112
CNSTI4 0
ASGNI4
line 2255
;2255:	} else {
ADDRGP4 $993
JUMPV
LABELV $992
line 2256
;2256:		dir = cent->currentState.angles2[YAW];
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2257
;2257:		if ( dir < 0 || dir > 7 ) {
ADDRLP4 112
INDIRI4
CNSTI4 0
LTI4 $996
ADDRLP4 112
INDIRI4
CNSTI4 7
LEI4 $994
LABELV $996
line 2258
;2258:			CG_Error( "Bad player movement angle" );
ADDRGP4 $997
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2259
;2259:		}
LABELV $994
line 2260
;2260:	}
LABELV $993
line 2261
;2261:	if (!cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
NEI4 $998
line 2262
;2262:	{
line 2263
;2263:		torsoAngles[YAW] = headAngles[YAW] + 0.25 * movementOffsets[ dir ];
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1048576000
ADDRLP4 112
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $983
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 2264
;2264:	}
ADDRGP4 $999
JUMPV
LABELV $998
line 2266
;2265:	else
;2266:	{
line 2267
;2267:		torsoAngles[YAW] = headAngles[YAW];
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 2268
;2268:	}
LABELV $999
line 2275
;2269:
;2270:	// torso
;2271://	CG_SwingAngles( torsoAngles[YAW], 25, 90, /*cg_swingSpeed.value*/ 0.3, &cent->pe.torso.yawAngle, &cent->pe.torso.yawing );
;2272://	torsoAngles[YAW] = cent->pe.torso.yawAngle;
;2273:
;2274:	//for now, turn torso instantly and let the legs swing to follow
;2275:	cent->pe.torso.yawAngle = torsoAngles[YAW];
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ADDRLP4 0+4
INDIRF4
ASGNF4
line 2279
;2276:
;2277:	// --------- pitch -------------
;2278:
;2279:	VectorCopy( cent->currentState.pos.trDelta, velocity );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 2280
;2280:	speed = VectorNormalize( velocity );
ADDRLP4 24
ARGP4
ADDRLP4 172
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 84
ADDRLP4 172
INDIRF4
ASGNF4
line 2282
;2281:
;2282:	if (!speed)
ADDRLP4 84
INDIRF4
CNSTF4 0
NEF4 $1005
line 2283
;2283:	{
line 2284
;2284:		torsoAngles[YAW] = headAngles[YAW];
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 2285
;2285:	}
LABELV $1005
line 2288
;2286:
;2287:	// only show a fraction of the pitch angle in the torso
;2288:	if ( headAngles[PITCH] > 180 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1127481344
LEF4 $1009
line 2289
;2289:		dest = (-360 + headAngles[PITCH]) * 0.75;
ADDRLP4 140
CNSTF4 1061158912
ADDRLP4 12
INDIRF4
CNSTF4 3283353600
ADDF4
MULF4
ASGNF4
line 2290
;2290:	} else {
ADDRGP4 $1010
JUMPV
LABELV $1009
line 2291
;2291:		dest = headAngles[PITCH] * 0.75;
ADDRLP4 140
CNSTF4 1061158912
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 2292
;2292:	}
LABELV $1010
line 2293
;2293:	CG_SwingAngles( dest, 15, 30, 0.1, &cent->pe.torso.pitchAngle, &cent->pe.torso.pitching );
ADDRLP4 140
INDIRF4
ARGF4
CNSTF4 1097859072
ARGF4
CNSTF4 1106247680
ARGF4
CNSTF4 1036831949
ARGF4
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 736
ADDP4
ARGP4
ADDRLP4 176
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLF4
pop
line 2294
;2294:	torsoAngles[PITCH] = cent->pe.torso.pitchAngle;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ASGNF4
line 2322
;2295:
;2296:	// --------- roll -------------
;2297:
;2298:
;2299:	// lean towards the direction of travel
;2300:
;2301:	/*
;2302:	speed_desired = cent->currentState.speed/4;
;2303:
;2304:	if (!speed)
;2305:	{
;2306:		speed_dif = 0;
;2307:	}
;2308:	else
;2309:	{
;2310:		speed_dif = (speed/speed_desired);
;2311:	}
;2312:
;2313:	if (speed_dif > 1)
;2314:	{
;2315:		speed_dif = 1;
;2316:	}
;2317:	else if (speed_dif < 0)
;2318:	{
;2319:		speed_dif = 0;
;2320:	}
;2321:	*/
;2322:	if ( speed ) {
ADDRLP4 84
INDIRF4
CNSTF4 0
EQF4 $1011
line 2326
;2323:		vec3_t	axis[3];
;2324:		float	side;
;2325:
;2326:		speed *= 0.05;
ADDRLP4 84
CNSTF4 1028443341
ADDRLP4 84
INDIRF4
MULF4
ASGNF4
line 2328
;2327:
;2328:		AnglesToAxis( legsAngles, axis );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 180
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2329
;2329:		side = speed * DotProduct( velocity, axis[1] );
ADDRLP4 216
ADDRLP4 84
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 180+12
INDIRF4
MULF4
ADDRLP4 24+4
INDIRF4
ADDRLP4 180+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 24+8
INDIRF4
ADDRLP4 180+12+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 2330
;2330:		legsAngles[ROLL] -= side;
ADDRLP4 220
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 220
INDIRP4
ADDRLP4 220
INDIRP4
INDIRF4
ADDRLP4 216
INDIRF4
SUBF4
ASGNF4
line 2332
;2331:
;2332:		side = speed * DotProduct( velocity, axis[0] );
ADDRLP4 216
ADDRLP4 84
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 180
INDIRF4
MULF4
ADDRLP4 24+4
INDIRF4
ADDRLP4 180+4
INDIRF4
MULF4
ADDF4
ADDRLP4 24+8
INDIRF4
ADDRLP4 180+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 2333
;2333:		legsAngles[PITCH] += side;
ADDRLP4 224
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 224
INDIRP4
ADDRLP4 224
INDIRP4
INDIRF4
ADDRLP4 216
INDIRF4
ADDF4
ASGNF4
line 2334
;2334:	}
LABELV $1011
line 2339
;2335:
;2336:	//legsAngles[YAW] = headAngles[YAW] + (movementOffsets[ dir ]*speed_dif);
;2337:
;2338:	//rww - crazy velocity-based leg angle calculation
;2339:	legsAngles[YAW] = headAngles[YAW];
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 2340
;2340:	velPos[0] = cent->lerpOrigin[0] + velocity[0];
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 2341
;2341:	velPos[1] = cent->lerpOrigin[1] + velocity[1];
ADDRLP4 36+4
ADDRFP4 0
INDIRP4
CNSTI4 932
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
line 2342
;2342:	velPos[2] = cent->lerpOrigin[2];// + velocity[2];
ADDRLP4 36+8
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
INDIRF4
ASGNF4
line 2344
;2343:
;2344:	if (cent->currentState.groundEntityNum == ENTITYNUM_NONE)
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $1028
line 2345
;2345:	{ //off the ground, no direction-based leg angles
line 2346
;2346:		VectorCopy(cent->lerpOrigin, velPos);
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2347
;2347:	}
LABELV $1028
line 2349
;2348:
;2349:	VectorSubtract(cent->lerpOrigin, velPos, velAng);
ADDRLP4 180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 180
INDIRP4
CNSTI4 928
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48+4
ADDRLP4 180
INDIRP4
CNSTI4 932
ADDP4
INDIRF4
ADDRLP4 36+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48+8
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
INDIRF4
ADDRLP4 36+8
INDIRF4
SUBF4
ASGNF4
line 2351
;2350:
;2351:	if (!VectorCompare(velAng, vec3_origin))
ADDRLP4 48
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 184
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
NEI4 $1034
line 2352
;2352:	{
line 2353
;2353:		vectoangles(velAng, velAng);
ADDRLP4 48
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2355
;2354:
;2355:		if (velAng[YAW] <= legsAngles[YAW])
ADDRLP4 48+4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
GTF4 $1036
line 2356
;2356:		{
line 2357
;2357:			degrees_negative = (legsAngles[YAW] - velAng[YAW]);
ADDRLP4 132
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 48+4
INDIRF4
SUBF4
ASGNF4
line 2358
;2358:			degrees_positive = (360 - legsAngles[YAW]) + velAng[YAW];
ADDRLP4 136
CNSTF4 1135869952
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ADDRLP4 48+4
INDIRF4
ADDF4
ASGNF4
line 2359
;2359:		}
ADDRGP4 $1037
JUMPV
LABELV $1036
line 2361
;2360:		else
;2361:		{
line 2362
;2362:			degrees_negative = legsAngles[YAW] + (360 - velAng[YAW]);
ADDRLP4 132
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1135869952
ADDRLP4 48+4
INDIRF4
SUBF4
ADDF4
ASGNF4
line 2363
;2363:			degrees_positive = (velAng[YAW] - legsAngles[YAW]);
ADDRLP4 136
ADDRLP4 48+4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2364
;2364:		}
LABELV $1037
line 2366
;2365:
;2366:		if (degrees_negative < degrees_positive)
ADDRLP4 132
INDIRF4
ADDRLP4 136
INDIRF4
GEF4 $1043
line 2367
;2367:		{
line 2368
;2368:			dif = degrees_negative;
ADDRLP4 116
ADDRLP4 132
INDIRF4
ASGNF4
line 2369
;2369:			adddir = 0;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 2370
;2370:		}
ADDRGP4 $1044
JUMPV
LABELV $1043
line 2372
;2371:		else
;2372:		{
line 2373
;2373:			dif = degrees_positive;
ADDRLP4 116
ADDRLP4 136
INDIRF4
ASGNF4
line 2374
;2374:			adddir = 1;
ADDRLP4 144
CNSTI4 1
ASGNI4
line 2375
;2375:		}
LABELV $1044
line 2377
;2376:
;2377:		if (dif > 90)
ADDRLP4 116
INDIRF4
CNSTF4 1119092736
LEF4 $1045
line 2378
;2378:		{
line 2379
;2379:			dif = (180 - dif);
ADDRLP4 116
CNSTF4 1127481344
ADDRLP4 116
INDIRF4
SUBF4
ASGNF4
line 2380
;2380:		}
LABELV $1045
line 2382
;2381:
;2382:		if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1047
line 2383
;2383:		{
line 2384
;2384:			if (dif > 360)
ADDRLP4 116
INDIRF4
CNSTF4 1135869952
LEF4 $1048
line 2385
;2385:			{
line 2386
;2386:				dif = 360;
ADDRLP4 116
CNSTF4 1135869952
ASGNF4
line 2387
;2387:			}
line 2388
;2388:		}
ADDRGP4 $1048
JUMPV
LABELV $1047
line 2390
;2389:		else
;2390:		{
line 2391
;2391:			if (dif > 60)
ADDRLP4 116
INDIRF4
CNSTF4 1114636288
LEF4 $1051
line 2392
;2392:			{
line 2393
;2393:				dif = 60;
ADDRLP4 116
CNSTF4 1114636288
ASGNF4
line 2394
;2394:			}
LABELV $1051
line 2395
;2395:		}
LABELV $1048
line 2398
;2396:
;2397:		//Slight hack for when playing is running backward
;2398:		if (dir == 3 || dir == 5)
ADDRLP4 112
INDIRI4
CNSTI4 3
EQI4 $1055
ADDRLP4 112
INDIRI4
CNSTI4 5
NEI4 $1053
LABELV $1055
line 2399
;2399:		{
line 2400
;2400:			dif = -dif;
ADDRLP4 116
ADDRLP4 116
INDIRF4
NEGF4
ASGNF4
line 2401
;2401:		}
LABELV $1053
line 2403
;2402:
;2403:		if (adddir)
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1056
line 2404
;2404:		{
line 2405
;2405:			legsAngles[YAW] -= dif;
ADDRLP4 192
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRF4
ADDRLP4 116
INDIRF4
SUBF4
ASGNF4
line 2406
;2406:		}
ADDRGP4 $1057
JUMPV
LABELV $1056
line 2408
;2407:		else
;2408:		{
line 2409
;2409:			legsAngles[YAW] += dif;
ADDRLP4 192
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRF4
ADDRLP4 116
INDIRF4
ADDF4
ASGNF4
line 2410
;2410:		}
LABELV $1057
line 2411
;2411:	}
LABELV $1034
line 2413
;2412:
;2413:	if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1058
line 2414
;2414:	{
line 2415
;2415:		cent->pe.legs.yawSwingDif = CG_SwingAnglesATST( cent, legsAngles[YAW], 40, 360, /*cg_swingSpeed.value*/ 0.05, &cent->pe.legs.yawAngle, &cent->pe.legs.yawing );
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1135869952
ARGF4
CNSTF4 1028443341
ARGF4
ADDRLP4 188
INDIRP4
CNSTI4 664
ADDP4
ARGP4
ADDRLP4 188
INDIRP4
CNSTI4 668
ADDP4
ARGP4
ADDRLP4 192
ADDRGP4 CG_SwingAnglesATST
CALLF4
ASGNF4
ADDRLP4 188
INDIRP4
CNSTI4 680
ADDP4
ADDRLP4 192
INDIRF4
ASGNF4
line 2416
;2416:	}
ADDRGP4 $1059
JUMPV
LABELV $1058
line 2418
;2417:	else
;2418:	{
line 2419
;2419:		if (!cg_swingAngles.integer)
ADDRGP4 cg_swingAngles+12
INDIRI4
CNSTI4 0
NEI4 $1060
line 2420
;2420:		{
line 2421
;2421:			cent->pe.legs.yawAngle = legsAngles[YAW];
ADDRFP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 2422
;2422:		}
ADDRGP4 $1061
JUMPV
LABELV $1060
line 2424
;2423:		else
;2424:		{
line 2425
;2425:			CG_SwingAngles( legsAngles[YAW], 40, 90, /*cg_swingSpeed.value*/ 0.3, &cent->pe.legs.yawAngle, &cent->pe.legs.yawing );
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1050253722
ARGF4
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
CNSTI4 664
ADDP4
ARGP4
ADDRLP4 188
INDIRP4
CNSTI4 668
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLF4
pop
line 2426
;2426:		}
LABELV $1061
line 2427
;2427:	}
LABELV $1059
line 2428
;2428:	legsAngles[YAW] = cent->pe.legs.yawAngle;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRF4
ASGNF4
line 2431
;2429:
;2430:	// pain twitch
;2431:	CG_AddPainTwitch( cent, torsoAngles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_AddPainTwitch
CALLV
pop
line 2433
;2432:
;2433:	legsAngles[ROLL] = 0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 2434
;2434:	torsoAngles[ROLL] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 2436
;2435:
;2436:	VectorCopy(legsAngles, cent->turAngles);
ADDRFP4 0
INDIRP4
CNSTI4 1016
ADDP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 2438
;2437:
;2438:	if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1064
line 2439
;2439:	{
line 2440
;2440:		legsAngles[ROLL] = 0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 2441
;2441:		legsAngles[PITCH] = 0;
ADDRFP4 8
INDIRP4
CNSTF4 0
ASGNF4
line 2442
;2442:	}
LABELV $1064
line 2445
;2443:
;2444:	// pull the angles back out of the hierarchial chain
;2445:	AnglesSubtract( headAngles, torsoAngles, headAngles );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 2446
;2446:	AnglesSubtract( torsoAngles, legsAngles, torsoAngles );
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 2447
;2447:	AnglesToAxis( legsAngles, legs );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2450
;2448:	// we assume that model 0 is the player model.
;2449:
;2450:	if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1066
line 2451
;2451:	{
line 2454
;2452:		vec3_t flatYaw;
;2453:
;2454:		flatYaw[YAW] = 0;//cent->lerpAngles[YAW];
ADDRLP4 188+4
CNSTF4 0
ASGNF4
line 2455
;2455:		flatYaw[ROLL] = 0;
ADDRLP4 188+8
CNSTF4 0
ASGNF4
line 2456
;2456:		flatYaw[PITCH] = 0;
ADDRLP4 188
CNSTF4 0
ASGNF4
line 2457
;2457:		CG_G2SetBoneAngles(cent->ghoul2, 0, "pelvis", flatYaw, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 200
CNSTI4 0
ASGNI4
ADDRLP4 200
INDIRI4
ARGI4
ADDRGP4 $229
ARGP4
ADDRLP4 188
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
ADDRLP4 200
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_G2SetBoneAngles
CALLV
pop
line 2459
;2458:
;2459:		CG_G2SetBoneAngles(cent->ghoul2, 0, "thoracic", torsoAngles, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 204
CNSTI4 0
ASGNI4
ADDRLP4 204
INDIRI4
ARGI4
ADDRGP4 $1072
ARGP4
ADDRLP4 0
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
ADDRLP4 204
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_G2SetBoneAngles
CALLV
pop
line 2461
;2460:
;2461:		return;
ADDRGP4 $982
JUMPV
LABELV $1066
line 2466
;2462:	}
;2463:
;2464://	trap_G2API_SetBoneAngles(cent->ghoul2, 0, "upper_lumbar", torsoAngles, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
;2465:
;2466:	VectorCopy( cent->lerpAngles, viewAngles );
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 2467
;2467:	viewAngles[YAW] = viewAngles[ROLL] = 0;
ADDRLP4 188
CNSTF4 0
ASGNF4
ADDRLP4 72+8
ADDRLP4 188
INDIRF4
ASGNF4
ADDRLP4 72+4
ADDRLP4 188
INDIRF4
ASGNF4
line 2468
;2468:	viewAngles[PITCH] *= 0.5;
ADDRLP4 72
CNSTF4 1056964608
ADDRLP4 72
INDIRF4
MULF4
ASGNF4
line 2470
;2469:
;2470:	VectorCopy( cent->lerpAngles, angles );
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 2471
;2471:	angles[PITCH] = 0;
ADDRLP4 120
CNSTF4 0
ASGNF4
line 2473
;2472:
;2473:	CG_G2ClientSpineAngles(cent, viewAngles, angles, thoracicAngles, ulAngles, llAngles);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 100
ARGP4
ADDRGP4 CG_G2ClientSpineAngles
CALLV
pop
line 2475
;2474:
;2475:	ulAngles[YAW] += torsoAngles[YAW]*0.3;
ADDRLP4 88+4
ADDRLP4 88+4
INDIRF4
CNSTF4 1050253722
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2476
;2476:	llAngles[YAW] += torsoAngles[YAW]*0.3;
ADDRLP4 100+4
ADDRLP4 100+4
INDIRF4
CNSTF4 1050253722
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2477
;2477:	thoracicAngles[YAW] += torsoAngles[YAW]*0.4;
ADDRLP4 60+4
ADDRLP4 60+4
INDIRF4
CNSTF4 1053609165
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2479
;2478:
;2479:	ulAngles[PITCH] = torsoAngles[PITCH]*0.3;
ADDRLP4 88
CNSTF4 1050253722
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 2480
;2480:	llAngles[PITCH] = torsoAngles[PITCH]*0.3;
ADDRLP4 100
CNSTF4 1050253722
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 2481
;2481:	thoracicAngles[PITCH] = torsoAngles[PITCH]*0.4;
ADDRLP4 60
CNSTF4 1053609165
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 2483
;2482:
;2483:	ulAngles[ROLL] += torsoAngles[ROLL]*0.3;
ADDRLP4 88+8
ADDRLP4 88+8
INDIRF4
CNSTF4 1050253722
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2484
;2484:	llAngles[ROLL] += torsoAngles[ROLL]*0.3;
ADDRLP4 100+8
ADDRLP4 100+8
INDIRF4
CNSTF4 1050253722
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2485
;2485:	thoracicAngles[ROLL] += torsoAngles[ROLL]*0.4;
ADDRLP4 60+8
ADDRLP4 60+8
INDIRF4
CNSTF4 1053609165
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2487
;2486:
;2487:	if ( cent->currentState.otherEntityNum2 && !(cent->currentState.eFlags & EF_DEAD) )
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
CNSTI4 0
ASGNI4
ADDRLP4 192
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRLP4 196
INDIRI4
EQI4 $1089
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 196
INDIRI4
NEI4 $1089
line 2488
;2488:	{ //using an emplaced gun
line 2489
;2489:		centity_t *empEnt = &cg_entities[cent->currentState.otherEntityNum2];
ADDRLP4 212
CNSTI4 1920
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 2492
;2490:		vec3_t headAng;
;2491:
;2492:		VectorClear(headAng);
ADDRLP4 216
CNSTF4 0
ASGNF4
ADDRLP4 200+8
ADDRLP4 216
INDIRF4
ASGNF4
ADDRLP4 200+4
ADDRLP4 216
INDIRF4
ASGNF4
ADDRLP4 200
ADDRLP4 216
INDIRF4
ASGNF4
line 2494
;2493:
;2494:		if (empEnt)
ADDRLP4 212
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1093
line 2495
;2495:		{
line 2498
;2496:			vec3_t dif, empOrg, originalAngle;
;2497:
;2498:			VectorCopy(cent->lerpAngles, originalAngle);
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 2500
;2499:
;2500:			VectorCopy(empEnt->lerpOrigin, empOrg);
ADDRLP4 232
ADDRLP4 212
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2502
;2501:
;2502:			empOrg[2] += 32;
ADDRLP4 232+8
ADDRLP4 232+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2504
;2503:
;2504:			VectorSubtract(empOrg, cent->lerpOrigin, dif);
ADDRLP4 256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
ADDRLP4 232
INDIRF4
ADDRLP4 256
INDIRP4
CNSTI4 928
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 220+4
ADDRLP4 232+4
INDIRF4
ADDRLP4 256
INDIRP4
CNSTI4 932
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 220+8
ADDRLP4 232+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2505
;2505:			VectorNormalize(dif);
ADDRLP4 220
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2506
;2506:			vectoangles(dif, dif);
ADDRLP4 220
ARGP4
ADDRLP4 220
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2508
;2507:			
;2508:			VectorCopy(dif, cent->lerpAngles);
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 220
INDIRB
ASGNB 12
line 2510
;2509:
;2510:			VectorCopy(cent->lerpAngles, legsAngles);
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 2512
;2511:
;2512:			VectorSubtract(originalAngle, cent->lerpAngles, headAng);
ADDRLP4 260
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
ADDRLP4 244
INDIRF4
ADDRLP4 260
INDIRP4
CNSTI4 940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 200+4
ADDRLP4 244+4
INDIRF4
ADDRLP4 260
INDIRP4
CNSTI4 944
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 200+8
ADDRLP4 244+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 948
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2514
;2513:
;2514:			headAng[PITCH] /= 3; //scale it down so that you can't bend your neck all the way back
ADDRLP4 200
ADDRLP4 200
INDIRF4
CNSTF4 1077936128
DIVF4
ASGNF4
line 2515
;2515:		}
ADDRGP4 $1094
JUMPV
LABELV $1093
line 2517
;2516:		else
;2517:		{
line 2518
;2518:			VectorClear(cent->lerpAngles);
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 224
CNSTF4 0
ASGNF4
ADDRLP4 220
INDIRP4
CNSTI4 948
ADDP4
ADDRLP4 224
INDIRF4
ASGNF4
ADDRLP4 220
INDIRP4
CNSTI4 944
ADDP4
ADDRLP4 224
INDIRF4
ASGNF4
ADDRLP4 220
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 224
INDIRF4
ASGNF4
line 2519
;2519:			VectorClear(legsAngles);
ADDRLP4 228
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 232
CNSTF4 0
ASGNF4
ADDRLP4 228
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 232
INDIRF4
ASGNF4
ADDRLP4 228
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 232
INDIRF4
ASGNF4
ADDRLP4 228
INDIRP4
ADDRLP4 232
INDIRF4
ASGNF4
line 2520
;2520:		}
LABELV $1094
line 2522
;2521:
;2522:		AnglesToAxis( legsAngles, legs );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2524
;2523:
;2524:		CG_G2SetBoneAngles(cent->ghoul2, 0, "upper_lumbar", vec3_origin, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 220
CNSTI4 0
ASGNI4
ADDRLP4 220
INDIRI4
ARGI4
ADDRGP4 $237
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
ADDRLP4 220
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_G2SetBoneAngles
CALLV
pop
line 2525
;2525:		CG_G2SetBoneAngles(cent->ghoul2, 0, "lower_lumbar", vec3_origin, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 224
CNSTI4 0
ASGNI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRGP4 $246
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
ADDRLP4 224
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_G2SetBoneAngles
CALLV
pop
line 2526
;2526:		CG_G2SetBoneAngles(cent->ghoul2, 0, "thoracic", vec3_origin, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 228
CNSTI4 0
ASGNI4
ADDRLP4 228
INDIRI4
ARGI4
ADDRGP4 $1072
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
ADDRLP4 228
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_G2SetBoneAngles
CALLV
pop
line 2528
;2527:
;2528:		CG_G2SetBoneAngles(cent->ghoul2, 0, "cervical", headAng, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 232
CNSTI4 0
ASGNI4
ADDRLP4 232
INDIRI4
ARGI4
ADDRGP4 $1110
ARGP4
ADDRLP4 200
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
ADDRLP4 232
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_G2SetBoneAngles
CALLV
pop
line 2529
;2529:	}
ADDRGP4 $1090
JUMPV
LABELV $1089
line 2531
;2530:	else
;2531:	{
line 2532
;2532:		CG_G2SetBoneAngles(cent->ghoul2, 0, "upper_lumbar", ulAngles, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 200
CNSTI4 0
ASGNI4
ADDRLP4 200
INDIRI4
ARGI4
ADDRGP4 $237
ARGP4
ADDRLP4 88
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
ADDRLP4 200
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_G2SetBoneAngles
CALLV
pop
line 2533
;2533:		CG_G2SetBoneAngles(cent->ghoul2, 0, "lower_lumbar", llAngles, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 204
CNSTI4 0
ASGNI4
ADDRLP4 204
INDIRI4
ARGI4
ADDRGP4 $246
ARGP4
ADDRLP4 100
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
ADDRLP4 204
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_G2SetBoneAngles
CALLV
pop
line 2534
;2534:		CG_G2SetBoneAngles(cent->ghoul2, 0, "thoracic", thoracicAngles, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time); 
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 $1072
ARGP4
ADDRLP4 60
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
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_G2SetBoneAngles
CALLV
pop
line 2535
;2535:		CG_G2SetBoneAngles(cent->ghoul2, 0, "cervical", vec3_origin, BONE_ANGLES_POSTMULT, POSITIVE_X, NEGATIVE_Y, NEGATIVE_Z, cgs.gameModels, 0, cg.time);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 212
CNSTI4 0
ASGNI4
ADDRLP4 212
INDIRI4
ARGI4
ADDRGP4 $1110
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
ADDRLP4 212
INDIRI4
ARGI4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 CG_G2SetBoneAngles
CALLV
pop
line 2536
;2536:	}
LABELV $1090
line 2539
;2537:
;2538:	//trap_G2API_SetBoneAngles(cent->ghoul2, 0, "cranium", headAngles, BONE_ANGLES_POSTMULT, POSITIVE_Z, NEGATIVE_Y, POSITIVE_X, cgs.gameModels, 0, cg.time); 
;2539:}
LABELV $982
endproc CG_G2PlayerAngles 264 44
proc CG_HasteTrail 40 48
line 2547
;2540://==========================================================================
;2541:
;2542:/*
;2543:===============
;2544:CG_HasteTrail
;2545:===============
;2546:*/
;2547:static void CG_HasteTrail( centity_t *cent ) {
line 2552
;2548:	localEntity_t	*smoke;
;2549:	vec3_t			origin;
;2550:	int				anim;
;2551:
;2552:	if ( cent->trailTime > cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $1122
line 2553
;2553:		return;
ADDRGP4 $1121
JUMPV
LABELV $1122
line 2555
;2554:	}
;2555:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 684
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 2556
;2556:	if ( anim != BOTH_RUN1 && anim != BOTH_RUNBACK1 ) {
ADDRLP4 12
INDIRI4
CNSTI4 731
EQI4 $1125
ADDRLP4 12
INDIRI4
CNSTI4 750
EQI4 $1125
line 2557
;2557:		return;
ADDRGP4 $1121
JUMPV
LABELV $1125
line 2560
;2558:	}
;2559:
;2560:	cent->trailTime += 100;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 2561
;2561:	if ( cent->trailTime < cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $1127
line 2562
;2562:		cent->trailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 2563
;2563:	}
LABELV $1127
line 2565
;2564:
;2565:	VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2566
;2566:	origin[2] -= 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2568
;2567:
;2568:	smoke = CG_SmokePuff( origin, vec3_origin, 
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 1140457472
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 cgs+70280+488
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 2578
;2569:				  8, 
;2570:				  1, 1, 1, 1,
;2571:				  500, 
;2572:				  cg.time,
;2573:				  0,
;2574:				  0,
;2575:				  cgs.media.hastePuffShader );
;2576:
;2577:	// use the optimized local entity add
;2578:	smoke->leType = LE_SCALE_FADE;
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 9
ASGNI4
line 2579
;2579:}
LABELV $1121
endproc CG_HasteTrail 40 48
proc CG_PlayerFlag 368 36
line 2665
;2580:
;2581:/*
;2582:===============
;2583:CG_DustTrail
;2584:===============
;2585:*/
;2586:/*
;2587:static void CG_DustTrail( centity_t *cent ) {
;2588:	int				anim;
;2589:	localEntity_t	*dust;
;2590:	vec3_t end, vel;
;2591:	trace_t tr;
;2592:
;2593:	if (!cg_enableDust.integer)
;2594:		return;
;2595:
;2596:	if ( cent->dustTrailTime > cg.time ) {
;2597:		return;
;2598:	}
;2599:
;2600:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
;2601:	if ( anim != LEGS_LANDB && anim != LEGS_LAND ) {
;2602:		return;
;2603:	}
;2604:
;2605:	cent->dustTrailTime += 40;
;2606:	if ( cent->dustTrailTime < cg.time ) {
;2607:		cent->dustTrailTime = cg.time;
;2608:	}
;2609:
;2610:	VectorCopy(cent->currentState.pos.trBase, end);
;2611:	end[2] -= 64;
;2612:	CG_Trace( &tr, cent->currentState.pos.trBase, NULL, NULL, end, cent->currentState.number, MASK_PLAYERSOLID );
;2613:
;2614:	if ( !(tr.surfaceFlags & SURF_DUST) )
;2615:		return;
;2616:
;2617:	VectorCopy( cent->currentState.pos.trBase, end );
;2618:	end[2] -= 16;
;2619:
;2620:	VectorSet(vel, 0, 0, -30);
;2621:	dust = CG_SmokePuff( end, vel,
;2622:				  24,
;2623:				  .8f, .8f, 0.7f, 0.33f,
;2624:				  500,
;2625:				  cg.time,
;2626:				  0,
;2627:				  0,
;2628:				  cgs.media.dustPuffShader );
;2629:}
;2630:*/
;2631:
;2632:/*
;2633:===============
;2634:CG_TrailItem
;2635:===============
;2636:*/
;2637:#if 0
;2638:static void CG_TrailItem( centity_t *cent, qhandle_t hModel ) {
;2639:	refEntity_t		ent;
;2640:	vec3_t			angles;
;2641:	vec3_t			axis[3];
;2642:
;2643:	VectorCopy( cent->lerpAngles, angles );
;2644:	angles[PITCH] = 0;
;2645:	angles[ROLL] = 0;
;2646:	AnglesToAxis( angles, axis );
;2647:
;2648:	memset( &ent, 0, sizeof( ent ) );
;2649:	VectorMA( cent->lerpOrigin, -16, axis[0], ent.origin );
;2650:	ent.origin[2] += 16;
;2651:	angles[YAW] += 90;
;2652:	AnglesToAxis( angles, ent.axis );
;2653:
;2654:	ent.hModel = hModel;
;2655:	trap_R_AddRefEntityToScene( &ent );
;2656:}
;2657:#endif
;2658:
;2659:
;2660:/*
;2661:===============
;2662:CG_PlayerFlag
;2663:===============
;2664:*/
;2665:static void CG_PlayerFlag( centity_t *cent, qhandle_t hModel ) {
line 2672
;2666:	refEntity_t		ent;
;2667:	vec3_t			angles;
;2668:	vec3_t			axis[3];
;2669:	vec3_t			boltOrg, tAng, getAng, right;
;2670:	mdxaBone_t		boltMatrix;
;2671:
;2672:	if (cent->currentState.number == cg.snap->ps.clientNum &&
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $1136
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $1136
line 2674
;2673:		!cg.renderingThirdPerson)
;2674:	{
line 2675
;2675:		return;
ADDRGP4 $1135
JUMPV
LABELV $1136
line 2678
;2676:	}
;2677:
;2678:	if (!cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1140
line 2679
;2679:	{
line 2680
;2680:		return;
ADDRGP4 $1135
JUMPV
LABELV $1140
line 2683
;2681:	}
;2682:
;2683:	VectorSet( tAng, cent->turAngles[PITCH], cent->turAngles[YAW], cent->turAngles[ROLL] );
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 224
ADDRLP4 356
INDIRP4
CNSTI4 1016
ADDP4
INDIRF4
ASGNF4
ADDRLP4 224+4
ADDRLP4 356
INDIRP4
CNSTI4 1020
ADDP4
INDIRF4
ASGNF4
ADDRLP4 224+8
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRF4
ASGNF4
line 2685
;2684:
;2685:	trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_llumbar, &boltMatrix, tAng, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ADDRLP4 360
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+528
ADDP4
INDIRI4
ARGI4
ADDRLP4 308
ARGP4
ADDRLP4 224
ARGP4
ADDRLP4 360
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 360
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 2686
;2686:	trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, ORIGIN, boltOrg);
ADDRLP4 308
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 212
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 2688
;2687:
;2688:	trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, POSITIVE_X, tAng);
ADDRLP4 308
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 224
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 2689
;2689:	vectoangles(tAng, tAng);
ADDRLP4 224
ARGP4
ADDRLP4 224
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2691
;2690:
;2691:	VectorCopy(cent->lerpAngles, angles);
ADDRLP4 236
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 2693
;2692:
;2693:	boltOrg[2] -= 12;
ADDRLP4 212+8
ADDRLP4 212+8
INDIRF4
CNSTF4 1094713344
SUBF4
ASGNF4
line 2694
;2694:	VectorSet(getAng, 0, cent->lerpAngles[1], 0);
ADDRLP4 284
CNSTF4 0
ASGNF4
ADDRLP4 284+4
ADDRFP4 0
INDIRP4
CNSTI4 944
ADDP4
INDIRF4
ASGNF4
ADDRLP4 284+8
CNSTF4 0
ASGNF4
line 2695
;2695:	AngleVectors(getAng, 0, right, 0);
ADDRLP4 284
ARGP4
ADDRLP4 364
CNSTP4 0
ASGNP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 296
ARGP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2696
;2696:	boltOrg[0] += right[0]*8;
ADDRLP4 212
ADDRLP4 212
INDIRF4
CNSTF4 1090519040
ADDRLP4 296
INDIRF4
MULF4
ADDF4
ASGNF4
line 2697
;2697:	boltOrg[1] += right[1]*8;
ADDRLP4 212+4
ADDRLP4 212+4
INDIRF4
CNSTF4 1090519040
ADDRLP4 296+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2698
;2698:	boltOrg[2] += right[2]*8;
ADDRLP4 212+8
ADDRLP4 212+8
INDIRF4
CNSTF4 1090519040
ADDRLP4 296+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2700
;2699:
;2700:	angles[PITCH] = -cent->lerpAngles[PITCH]/2-30;
ADDRLP4 236
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
CNSTF4 1106247680
SUBF4
ASGNF4
line 2701
;2701:	angles[YAW] = tAng[YAW]+270;
ADDRLP4 236+4
ADDRLP4 224+4
INDIRF4
CNSTF4 1132920832
ADDF4
ASGNF4
line 2703
;2702:
;2703:	AnglesToAxis(angles, axis);
ADDRLP4 236
ARGP4
ADDRLP4 248
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2705
;2704:
;2705:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2706
;2706:	VectorMA( boltOrg, 24, axis[0], ent.origin );
ADDRLP4 0+52
ADDRLP4 212
INDIRF4
CNSTF4 1103101952
ADDRLP4 248
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+4
ADDRLP4 212+4
INDIRF4
CNSTF4 1103101952
ADDRLP4 248+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+52+8
ADDRLP4 212+8
INDIRF4
CNSTF4 1103101952
ADDRLP4 248+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2708
;2707:
;2708:	angles[ROLL] += 20;
ADDRLP4 236+8
ADDRLP4 236+8
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 2709
;2709:	AnglesToAxis( angles, ent.axis );
ADDRLP4 236
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2711
;2710:
;2711:	ent.hModel = hModel;
ADDRLP4 0+8
ADDRFP4 4
INDIRI4
ASGNI4
line 2713
;2712:
;2713:	ent.modelScale[0] = 0.5;
ADDRLP4 0+196
CNSTF4 1056964608
ASGNF4
line 2714
;2714:	ent.modelScale[1] = 0.5;
ADDRLP4 0+196+4
CNSTF4 1056964608
ASGNF4
line 2715
;2715:	ent.modelScale[2] = 0.5;
ADDRLP4 0+196+8
CNSTF4 1056964608
ASGNF4
line 2716
;2716:	ScaleModelAxis(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 ScaleModelAxis
CALLV
pop
line 2727
;2717:
;2718:	/*
;2719:	if (cent->currentState.number == cg.snap->ps.clientNum)
;2720:	{ //If we're the current client (in third person), render the flag on our back transparently
;2721:		ent.renderfx |= RF_FORCE_ENT_ALPHA;
;2722:		ent.shaderRGBA[3] = 100;
;2723:	}
;2724:	*/
;2725:	//FIXME: Not doing this at the moment because sorting totally messes up
;2726:
;2727:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2728
;2728:}
LABELV $1135
endproc CG_PlayerFlag 368 36
proc CG_PlayerPowerups 16 20
line 2736
;2729:
;2730:
;2731:/*
;2732:===============
;2733:CG_PlayerPowerups
;2734:===============
;2735:*/
;2736:static void CG_PlayerPowerups( centity_t *cent, refEntity_t *torso ) {
line 2740
;2737:	int		powerups;
;2738:	clientInfo_t	*ci;
;2739:
;2740:	powerups = cent->currentState.powerups;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ASGNI4
line 2741
;2741:	if ( !powerups ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1175
line 2742
;2742:		return;
ADDRGP4 $1174
JUMPV
LABELV $1175
line 2746
;2743:	}
;2744:
;2745:	// quad gives a dlight
;2746:	if ( powerups & ( 1 << PW_QUAD ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1177
line 2747
;2747:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1 );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1045220557
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2748
;2748:	}
LABELV $1177
line 2750
;2749:
;2750:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 4
CNSTI4 788
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 2752
;2751:	// redflag
;2752:	if ( powerups & ( 1 << PW_REDFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1180
line 2753
;2753:		CG_PlayerFlag( cent, cgs.media.redFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+70280+36
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2754
;2754:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 1.0, 0.2f, 0.2f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 12
CNSTF4 1045220557
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2755
;2755:	}
LABELV $1180
line 2758
;2756:
;2757:	// blueflag
;2758:	if ( powerups & ( 1 << PW_BLUEFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1184
line 2759
;2759:		CG_PlayerFlag( cent, cgs.media.blueFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+70280+40
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2760
;2760:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1.0 );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1045220557
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2761
;2761:	}
LABELV $1184
line 2764
;2762:
;2763:	// neutralflag
;2764:	if ( powerups & ( 1 << PW_NEUTRALFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1188
line 2765
;2765:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 1.0, 1.0, 1.0 );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2766
;2766:	}
LABELV $1188
line 2769
;2767:
;2768:	// haste leaves smoke trails
;2769:	if ( powerups & ( 1 << PW_HASTE ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1190
line 2770
;2770:		CG_HasteTrail( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_HasteTrail
CALLV
pop
line 2771
;2771:	}
LABELV $1190
line 2772
;2772:}
LABELV $1174
endproc CG_PlayerPowerups 16 20
proc CG_PlayerFloatSprite 216 12
line 2782
;2773:
;2774:
;2775:/*
;2776:===============
;2777:CG_PlayerFloatSprite
;2778:
;2779:Float a sprite over the player's head
;2780:===============
;2781:*/
;2782:static void CG_PlayerFloatSprite( centity_t *cent, qhandle_t shader ) {
line 2786
;2783:	int				rf;
;2784:	refEntity_t		ent;
;2785:
;2786:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $1193
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $1193
line 2787
;2787:		rf = RF_THIRD_PERSON;		// only show in mirrors
ADDRLP4 212
CNSTI4 2
ASGNI4
line 2788
;2788:	} else {
ADDRGP4 $1194
JUMPV
LABELV $1193
line 2789
;2789:		rf = 0;
ADDRLP4 212
CNSTI4 0
ASGNI4
line 2790
;2790:	}
LABELV $1194
line 2792
;2791:
;2792:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2793
;2793:	VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2794
;2794:	ent.origin[2] += 48;
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 2795
;2795:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 2796
;2796:	ent.customShader = shader;
ADDRLP4 0+76
ADDRFP4 4
INDIRI4
ASGNI4
line 2797
;2797:	ent.radius = 10;
ADDRLP4 0+92
CNSTF4 1092616192
ASGNF4
line 2798
;2798:	ent.renderfx = rf;
ADDRLP4 0+4
ADDRLP4 212
INDIRI4
ASGNI4
line 2799
;2799:	ent.shaderRGBA[0] = 255;
ADDRLP4 0+80
CNSTU1 255
ASGNU1
line 2800
;2800:	ent.shaderRGBA[1] = 255;
ADDRLP4 0+80+1
CNSTU1 255
ASGNU1
line 2801
;2801:	ent.shaderRGBA[2] = 255;
ADDRLP4 0+80+2
CNSTU1 255
ASGNU1
line 2802
;2802:	ent.shaderRGBA[3] = 255;
ADDRLP4 0+80+3
CNSTU1 255
ASGNU1
line 2803
;2803:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2804
;2804:}
LABELV $1192
endproc CG_PlayerFloatSprite 216 12
lit
align 4
LABELV $1211
byte 4 3245342720
byte 4 3245342720
byte 4 0
align 4
LABELV $1212
byte 4 1097859072
byte 4 1097859072
byte 4 1073741824
code
proc CG_PlayerShadow 1136 44
line 2852
;2805:
;2806:
;2807:
;2808:/*
;2809:===============
;2810:CG_PlayerFloatSprite
;2811:
;2812:Same as above but allows custom RGBA values
;2813:===============
;2814:*/
;2815:#if 0
;2816:static void CG_PlayerFloatSpriteRGBA( centity_t *cent, qhandle_t shader, vec4_t rgba ) {
;2817:	int				rf;
;2818:	refEntity_t		ent;
;2819:
;2820:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson ) {
;2821:		rf = RF_THIRD_PERSON;		// only show in mirrors
;2822:	} else {
;2823:		rf = 0;
;2824:	}
;2825:
;2826:	memset( &ent, 0, sizeof( ent ) );
;2827:	VectorCopy( cent->lerpOrigin, ent.origin );
;2828:	ent.origin[2] += 48;
;2829:	ent.reType = RT_SPRITE;
;2830:	ent.customShader = shader;
;2831:	ent.radius = 10;
;2832:	ent.renderfx = rf;
;2833:	ent.shaderRGBA[0] = rgba[0];
;2834:	ent.shaderRGBA[1] = rgba[1];
;2835:	ent.shaderRGBA[2] = rgba[2];
;2836:	ent.shaderRGBA[3] = rgba[3];
;2837:	trap_R_AddRefEntityToScene( &ent );
;2838:}
;2839:#endif
;2840:
;2841:
;2842:/*
;2843:===============
;2844:CG_PlayerShadow
;2845:
;2846:Returns the Z component of the surface being shadowed
;2847:
;2848:  should it return a full plane instead of a Z?
;2849:===============
;2850:*/
;2851:#define	SHADOW_DISTANCE		128
;2852:static qboolean CG_PlayerShadow( centity_t *cent, float *shadowPlane ) {
line 2853
;2853:	vec3_t		end, mins = {-15, -15, 0}, maxs = {15, 15, 2};
ADDRLP4 1096
ADDRGP4 $1211
INDIRB
ASGNB 12
ADDRLP4 1108
ADDRGP4 $1212
INDIRB
ASGNB 12
line 2857
;2854:	trace_t		trace;
;2855:	float		alpha;
;2856:
;2857:	*shadowPlane = 0;
ADDRFP4 4
INDIRP4
CNSTF4 0
ASGNF4
line 2859
;2858:
;2859:	if ( cg_shadows.integer == 0 ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1213
line 2860
;2860:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1210
JUMPV
LABELV $1213
line 2863
;2861:	}
;2862:
;2863:	if (cent->currentState.eFlags & EF_DEAD)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1216
line 2864
;2864:	{
line 2865
;2865:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1210
JUMPV
LABELV $1216
line 2868
;2866:	}
;2867:
;2868:	if (CG_IsMindTricked(cent->currentState.trickedentindex,
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1120
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRLP4 1120
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ARGI4
ADDRLP4 1120
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
ARGI4
ADDRLP4 1120
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
ADDRLP4 1124
ADDRGP4 CG_IsMindTricked
CALLI4
ASGNI4
ADDRLP4 1124
INDIRI4
CNSTI4 0
EQI4 $1218
line 2873
;2869:		cent->currentState.trickedentindex2,
;2870:		cent->currentState.trickedentindex3,
;2871:		cent->currentState.trickedentindex4,
;2872:		cg.snap->ps.clientNum))
;2873:	{
line 2874
;2874:		return qfalse; //this entity is mind-tricking the current client, so don't render it
CNSTI4 0
RETI4
ADDRGP4 $1210
JUMPV
LABELV $1218
line 2878
;2875:	}
;2876:
;2877:	// send a trace down from the player to the ground
;2878:	VectorCopy( cent->lerpOrigin, end );
ADDRLP4 1084
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2879
;2879:	end[2] -= SHADOW_DISTANCE;
ADDRLP4 1084+8
ADDRLP4 1084+8
INDIRF4
CNSTF4 1124073472
SUBF4
ASGNF4
line 2881
;2880:
;2881:	trap_CM_BoxTrace( &trace, cent->lerpOrigin, end, mins, maxs, 0, MASK_PLAYERSOLID );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 1084
ARGP4
ADDRLP4 1096
ARGP4
ADDRLP4 1108
ARGP4
CNSTI4 0
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2884
;2882:
;2883:	// no shadow if too high
;2884:	if ( trace.fraction == 1.0 || trace.startsolid || trace.allsolid ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $1227
ADDRLP4 1128
CNSTI4 0
ASGNI4
ADDRLP4 0+4
INDIRI4
ADDRLP4 1128
INDIRI4
NEI4 $1227
ADDRLP4 0
INDIRI4
ADDRLP4 1128
INDIRI4
EQI4 $1222
LABELV $1227
line 2885
;2885:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1210
JUMPV
LABELV $1222
line 2888
;2886:	}
;2887:
;2888:	*shadowPlane = trace.endpos[2] + 1;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2890
;2889:
;2890:	if ( cg_shadows.integer != 1 ) {	// no mark for stencil or projection shadows
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 1
EQI4 $1230
line 2891
;2891:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1210
JUMPV
LABELV $1230
line 2895
;2892:	}
;2893:
;2894:	// fade the shadow out with height
;2895:	alpha = 1.0 - trace.fraction;
ADDRLP4 1080
CNSTF4 1065353216
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2902
;2896:
;2897:	// bk0101022 - hack / FPE - bogus planes?
;2898:	//assert( DotProduct( trace.plane.normal, trace.plane.normal ) != 0.0f ) 
;2899:
;2900:	// add the mark as a temporary, so it goes directly to the renderer
;2901:	// without taking a spot in the cg_marks array
;2902:	CG_ImpactMark( cgs.media.shadowMarkShader, trace.endpos, trace.plane.normal, 
ADDRGP4 cgs+70280+416
INDIRI4
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 0+24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRF4
ARGF4
ADDRLP4 1080
INDIRF4
ARGF4
ADDRLP4 1080
INDIRF4
ARGF4
ADDRLP4 1080
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTI4 0
ARGI4
CNSTF4 1103101952
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 2905
;2903:		cent->pe.legs.yawAngle, alpha,alpha,alpha,1, qfalse, 24, qtrue );
;2904:
;2905:	return qtrue;
CNSTI4 1
RETI4
LABELV $1210
endproc CG_PlayerShadow 1136 44
proc CG_PlayerSplash 1216 28
line 2916
;2906:}
;2907:
;2908:
;2909:/*
;2910:===============
;2911:CG_PlayerSplash
;2912:
;2913:Draw a mark at the water surface
;2914:===============
;2915:*/
;2916:static void CG_PlayerSplash( centity_t *cent ) {
line 2922
;2917:	vec3_t		start, end;
;2918:	trace_t		trace;
;2919:	int			contents;
;2920:	polyVert_t	verts[4];
;2921:
;2922:	if ( !cg_shadows.integer ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1239
line 2923
;2923:		return;
ADDRGP4 $1238
JUMPV
LABELV $1239
line 2926
;2924:	}
;2925:
;2926:	VectorCopy( cent->lerpOrigin, end );
ADDRLP4 1188
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2927
;2927:	end[2] -= 24;
ADDRLP4 1188+8
ADDRLP4 1188+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 2931
;2928:
;2929:	// if the feet aren't in liquid, don't make a mark
;2930:	// this won't handle moving water brushes, but they wouldn't draw right anyway...
;2931:	contents = trap_CM_PointContents( end, 0 );
ADDRLP4 1188
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1204
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 1200
ADDRLP4 1204
INDIRI4
ASGNI4
line 2932
;2932:	if ( !( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) ) {
ADDRLP4 1200
INDIRI4
CNSTI4 131078
BANDI4
CNSTI4 0
NEI4 $1243
line 2933
;2933:		return;
ADDRGP4 $1238
JUMPV
LABELV $1243
line 2936
;2934:	}
;2935:
;2936:	VectorCopy( cent->lerpOrigin, start );
ADDRLP4 1176
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2937
;2937:	start[2] += 32;
ADDRLP4 1176+8
ADDRLP4 1176+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2940
;2938:
;2939:	// if the head isn't out of liquid, don't make a mark
;2940:	contents = trap_CM_PointContents( start, 0 );
ADDRLP4 1176
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1208
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 1200
ADDRLP4 1208
INDIRI4
ASGNI4
line 2941
;2941:	if ( contents & ( CONTENTS_SOLID | CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
ADDRLP4 1200
INDIRI4
CNSTI4 131079
BANDI4
CNSTI4 0
EQI4 $1246
line 2942
;2942:		return;
ADDRGP4 $1238
JUMPV
LABELV $1246
line 2946
;2943:	}
;2944:
;2945:	// trace down to find the surface
;2946:	trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) );
ADDRLP4 96
ARGP4
ADDRLP4 1176
ARGP4
ADDRLP4 1188
ARGP4
ADDRLP4 1212
CNSTP4 0
ASGNP4
ADDRLP4 1212
INDIRP4
ARGP4
ADDRLP4 1212
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 131078
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2948
;2947:
;2948:	if ( trace.fraction == 1.0 ) {
ADDRLP4 96+8
INDIRF4
CNSTF4 1065353216
NEF4 $1248
line 2949
;2949:		return;
ADDRGP4 $1238
JUMPV
LABELV $1248
line 2953
;2950:	}
;2951:
;2952:	// create a mark polygon
;2953:	VectorCopy( trace.endpos, verts[0].xyz );
ADDRLP4 0
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2954
;2954:	verts[0].xyz[0] -= 32;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2955
;2955:	verts[0].xyz[1] -= 32;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2956
;2956:	verts[0].st[0] = 0;
ADDRLP4 0+12
CNSTF4 0
ASGNF4
line 2957
;2957:	verts[0].st[1] = 0;
ADDRLP4 0+12+4
CNSTF4 0
ASGNF4
line 2958
;2958:	verts[0].modulate[0] = 255;
ADDRLP4 0+20
CNSTU1 255
ASGNU1
line 2959
;2959:	verts[0].modulate[1] = 255;
ADDRLP4 0+20+1
CNSTU1 255
ASGNU1
line 2960
;2960:	verts[0].modulate[2] = 255;
ADDRLP4 0+20+2
CNSTU1 255
ASGNU1
line 2961
;2961:	verts[0].modulate[3] = 255;
ADDRLP4 0+20+3
CNSTU1 255
ASGNU1
line 2963
;2962:
;2963:	VectorCopy( trace.endpos, verts[1].xyz );
ADDRLP4 0+24
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2964
;2964:	verts[1].xyz[0] -= 32;
ADDRLP4 0+24
ADDRLP4 0+24
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2965
;2965:	verts[1].xyz[1] += 32;
ADDRLP4 0+24+4
ADDRLP4 0+24+4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2966
;2966:	verts[1].st[0] = 0;
ADDRLP4 0+24+12
CNSTF4 0
ASGNF4
line 2967
;2967:	verts[1].st[1] = 1;
ADDRLP4 0+24+12+4
CNSTF4 1065353216
ASGNF4
line 2968
;2968:	verts[1].modulate[0] = 255;
ADDRLP4 0+24+20
CNSTU1 255
ASGNU1
line 2969
;2969:	verts[1].modulate[1] = 255;
ADDRLP4 0+24+20+1
CNSTU1 255
ASGNU1
line 2970
;2970:	verts[1].modulate[2] = 255;
ADDRLP4 0+24+20+2
CNSTU1 255
ASGNU1
line 2971
;2971:	verts[1].modulate[3] = 255;
ADDRLP4 0+24+20+3
CNSTU1 255
ASGNU1
line 2973
;2972:
;2973:	VectorCopy( trace.endpos, verts[2].xyz );
ADDRLP4 0+48
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2974
;2974:	verts[2].xyz[0] += 32;
ADDRLP4 0+48
ADDRLP4 0+48
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2975
;2975:	verts[2].xyz[1] += 32;
ADDRLP4 0+48+4
ADDRLP4 0+48+4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2976
;2976:	verts[2].st[0] = 1;
ADDRLP4 0+48+12
CNSTF4 1065353216
ASGNF4
line 2977
;2977:	verts[2].st[1] = 1;
ADDRLP4 0+48+12+4
CNSTF4 1065353216
ASGNF4
line 2978
;2978:	verts[2].modulate[0] = 255;
ADDRLP4 0+48+20
CNSTU1 255
ASGNU1
line 2979
;2979:	verts[2].modulate[1] = 255;
ADDRLP4 0+48+20+1
CNSTU1 255
ASGNU1
line 2980
;2980:	verts[2].modulate[2] = 255;
ADDRLP4 0+48+20+2
CNSTU1 255
ASGNU1
line 2981
;2981:	verts[2].modulate[3] = 255;
ADDRLP4 0+48+20+3
CNSTU1 255
ASGNU1
line 2983
;2982:
;2983:	VectorCopy( trace.endpos, verts[3].xyz );
ADDRLP4 0+72
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2984
;2984:	verts[3].xyz[0] += 32;
ADDRLP4 0+72
ADDRLP4 0+72
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2985
;2985:	verts[3].xyz[1] -= 32;
ADDRLP4 0+72+4
ADDRLP4 0+72+4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2986
;2986:	verts[3].st[0] = 1;
ADDRLP4 0+72+12
CNSTF4 1065353216
ASGNF4
line 2987
;2987:	verts[3].st[1] = 0;
ADDRLP4 0+72+12+4
CNSTF4 0
ASGNF4
line 2988
;2988:	verts[3].modulate[0] = 255;
ADDRLP4 0+72+20
CNSTU1 255
ASGNU1
line 2989
;2989:	verts[3].modulate[1] = 255;
ADDRLP4 0+72+20+1
CNSTU1 255
ASGNU1
line 2990
;2990:	verts[3].modulate[2] = 255;
ADDRLP4 0+72+20+2
CNSTU1 255
ASGNU1
line 2991
;2991:	verts[3].modulate[3] = 255;
ADDRLP4 0+72+20+3
CNSTU1 255
ASGNU1
line 2993
;2992:
;2993:	trap_R_AddPolyToScene( cgs.media.wakeMarkShader, 4, verts );
ADDRGP4 cgs+70280+424
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 2994
;2994:}
LABELV $1238
endproc CG_PlayerSplash 1216 28
export CG_ForcePushBlur
proc CG_ForcePushBlur 28 4
line 2997
;2995:
;2996:void CG_ForcePushBlur( vec3_t org )
;2997:{
line 3000
;2998:	localEntity_t	*ex;
;2999:
;3000:	ex = CG_AllocLocalEntity();
ADDRLP4 4
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 3001
;3001:	ex->leType = LE_PUFF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 5
ASGNI4
line 3002
;3002:	ex->refEntity.reType = RT_SPRITE;
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
CNSTI4 2
ASGNI4
line 3003
;3003:	ex->radius = 2.0f;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
CNSTF4 1073741824
ASGNF4
line 3004
;3004:	ex->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3005
;3005:	ex->endTime = ex->startTime + 120;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 120
ADDI4
ASGNI4
line 3006
;3006:	VectorCopy( org, ex->pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 3007
;3007:	ex->pos.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3008
;3008:	ex->pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 2
ASGNI4
line 3009
;3009:	VectorScale( cg.refdef.viewaxis[1], 55, ex->pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1113325568
ADDRGP4 cg+3604+36+12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 1113325568
ADDRGP4 cg+3604+36+12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1113325568
ADDRGP4 cg+3604+36+12+8
INDIRF4
MULF4
ASGNF4
line 3011
;3010:		
;3011:	ex->color[0] = 24;
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 1103101952
ASGNF4
line 3012
;3012:	ex->color[1] = 32;
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTF4 1107296256
ASGNF4
line 3013
;3013:	ex->color[2] = 40;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1109393408
ASGNF4
line 3014
;3014:	ex->refEntity.customShader = trap_R_RegisterShader( "gfx/effects/forcePush" );
ADDRGP4 $1342
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 3016
;3015:
;3016:	ex = CG_AllocLocalEntity();
ADDRLP4 16
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 3017
;3017:	ex->leType = LE_PUFF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 5
ASGNI4
line 3018
;3018:	ex->refEntity.reType = RT_SPRITE;
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
CNSTI4 2
ASGNI4
line 3019
;3019:	ex->refEntity.rotation = 180.0f;
ADDRLP4 0
INDIRP4
CNSTI4 344
ADDP4
CNSTF4 1127481344
ASGNF4
line 3020
;3020:	ex->radius = 2.0f;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
CNSTF4 1073741824
ASGNF4
line 3021
;3021:	ex->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3022
;3022:	ex->endTime = ex->startTime + 120;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 120
ADDI4
ASGNI4
line 3023
;3023:	VectorCopy( org, ex->pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 3024
;3024:	ex->pos.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3025
;3025:	ex->pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 2
ASGNI4
line 3026
;3026:	VectorScale( cg.refdef.viewaxis[1], -55, ex->pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 3260809216
ADDRGP4 cg+3604+36+12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 3260809216
ADDRGP4 cg+3604+36+12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 3260809216
ADDRGP4 cg+3604+36+12+8
INDIRF4
MULF4
ASGNF4
line 3028
;3027:		
;3028:	ex->color[0] = 24;
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 1103101952
ASGNF4
line 3029
;3029:	ex->color[1] = 32;
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTF4 1107296256
ASGNF4
line 3030
;3030:	ex->color[2] = 40;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1109393408
ASGNF4
line 3031
;3031:	ex->refEntity.customShader = trap_R_RegisterShader( "gfx/effects/forcePush" );
ADDRGP4 $1342
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 3032
;3032:}
LABELV $1328
endproc CG_ForcePushBlur 28 4
export CG_ForceGripEffect
proc CG_ForceGripEffect 32 4
line 3035
;3033:
;3034:void CG_ForceGripEffect( vec3_t org )
;3035:{
line 3037
;3036:	localEntity_t	*ex;
;3037:	float wv = sin( cg.time * 0.004f ) * 0.08f + 0.1f;
CNSTF4 998445679
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 8
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1034147594
ADDRLP4 8
INDIRF4
MULF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 3039
;3038:
;3039:	ex = CG_AllocLocalEntity();
ADDRLP4 12
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 3040
;3040:	ex->leType = LE_PUFF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 5
ASGNI4
line 3041
;3041:	ex->refEntity.reType = RT_SPRITE;
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
CNSTI4 2
ASGNI4
line 3042
;3042:	ex->radius = 2.0f;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
CNSTF4 1073741824
ASGNF4
line 3043
;3043:	ex->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3044
;3044:	ex->endTime = ex->startTime + 120;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 120
ADDI4
ASGNI4
line 3045
;3045:	VectorCopy( org, ex->pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 3046
;3046:	ex->pos.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3047
;3047:	ex->pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 2
ASGNI4
line 3048
;3048:	VectorScale( cg.refdef.viewaxis[1], 55, ex->pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1113325568
ADDRGP4 cg+3604+36+12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 1113325568
ADDRGP4 cg+3604+36+12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1113325568
ADDRGP4 cg+3604+36+12+8
INDIRF4
MULF4
ASGNF4
line 3050
;3049:		
;3050:	ex->color[0] = 200+((wv*255));
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 1132396544
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1128792064
ADDF4
ASGNF4
line 3051
;3051:	if (ex->color[0] > 255)
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1132396544
LEF4 $1371
line 3052
;3052:	{
line 3053
;3053:		ex->color[0] = 255;
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 1132396544
ASGNF4
line 3054
;3054:	}
LABELV $1371
line 3055
;3055:	ex->color[1] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTF4 0
ASGNF4
line 3056
;3056:	ex->color[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 0
ASGNF4
line 3057
;3057:	ex->refEntity.customShader = trap_R_RegisterShader( "gfx/effects/forcePush" );
ADDRGP4 $1342
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 3059
;3058:
;3059:	ex = CG_AllocLocalEntity();
ADDRLP4 24
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 3060
;3060:	ex->leType = LE_PUFF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 5
ASGNI4
line 3061
;3061:	ex->refEntity.reType = RT_SPRITE;
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
CNSTI4 2
ASGNI4
line 3062
;3062:	ex->refEntity.rotation = 180.0f;
ADDRLP4 0
INDIRP4
CNSTI4 344
ADDP4
CNSTF4 1127481344
ASGNF4
line 3063
;3063:	ex->radius = 2.0f;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
CNSTF4 1073741824
ASGNF4
line 3064
;3064:	ex->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3065
;3065:	ex->endTime = ex->startTime + 120;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 120
ADDI4
ASGNI4
line 3066
;3066:	VectorCopy( org, ex->pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 3067
;3067:	ex->pos.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3068
;3068:	ex->pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 2
ASGNI4
line 3069
;3069:	VectorScale( cg.refdef.viewaxis[1], -55, ex->pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 3260809216
ADDRGP4 cg+3604+36+12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 3260809216
ADDRGP4 cg+3604+36+12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 3260809216
ADDRGP4 cg+3604+36+12+8
INDIRF4
MULF4
ASGNF4
line 3078
;3070:
;3071:	/*
;3072:	ex->color[0] = 200+((wv*255));
;3073:	if (ex->color[0] > 255)
;3074:	{
;3075:		ex->color[0] = 255;
;3076:	}
;3077:	*/
;3078:	ex->color[0] = 255;
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 1132396544
ASGNF4
line 3079
;3079:	ex->color[1] = 255;
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTF4 1132396544
ASGNF4
line 3080
;3080:	ex->color[2] = 255;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1132396544
ASGNF4
line 3081
;3081:	ex->refEntity.customShader = cgs.media.redSaberGlowShader;//trap_R_RegisterShader( "gfx/effects/forcePush" );
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
ADDRGP4 cgs+70280+116
INDIRI4
ASGNI4
line 3082
;3082:}
LABELV $1356
endproc CG_ForceGripEffect 32 4
export CG_AddRefEntityWithPowerups
proc CG_AddRefEntityWithPowerups 8 20
line 3093
;3083:
;3084:
;3085:/*
;3086:===============
;3087:CG_AddRefEntityWithPowerups
;3088:
;3089:Adds a piece with modifications or duplications for powerups
;3090:Also called by CG_Missile for quad rockets, but nobody can tell...
;3091:===============
;3092:*/
;3093:void CG_AddRefEntityWithPowerups( refEntity_t *ent, entityState_t *state, int team ) {
line 3095
;3094:
;3095:	if (CG_IsMindTricked(state->trickedentindex,
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
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
ADDRLP4 4
ADDRGP4 CG_IsMindTricked
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1389
line 3100
;3096:		state->trickedentindex2,
;3097:		state->trickedentindex3,
;3098:		state->trickedentindex4,
;3099:		cg.snap->ps.clientNum))
;3100:	{
line 3101
;3101:		return; //this entity is mind-tricking the current client, so don't render it
ADDRGP4 $1388
JUMPV
LABELV $1389
line 3104
;3102:	}
;3103:
;3104:	trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3106
;3105:
;3106:	if ( state->powerups & ( 1 << PW_QUAD ) )
ADDRFP4 4
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1392
line 3107
;3107:	{
line 3108
;3108:		if (team == TEAM_RED)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1394
line 3109
;3109:			ent->customShader = cgs.media.redQuadShader;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRGP4 cgs+70280+464
INDIRI4
ASGNI4
ADDRGP4 $1395
JUMPV
LABELV $1394
line 3111
;3110:		else
;3111:			ent->customShader = cgs.media.quadShader;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRGP4 cgs+70280+460
INDIRI4
ASGNI4
LABELV $1395
line 3112
;3112:		trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3113
;3113:	}
LABELV $1392
line 3114
;3114:	if ( state->powerups & ( 1 << PW_BATTLESUIT ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1400
line 3115
;3115:		ent->customShader = cgs.media.battleSuitShader;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRGP4 cgs+70280+480
INDIRI4
ASGNI4
line 3116
;3116:		trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3117
;3117:	}
LABELV $1400
line 3118
;3118:}
LABELV $1388
endproc CG_AddRefEntityWithPowerups 8 20
export CG_PlayerShieldHit
proc CG_PlayerShieldHit 24 8
line 3125
;3119:
;3120:#define MAX_SHIELD_TIME	2000.0
;3121:#define MIN_SHIELD_TIME	2000.0
;3122:
;3123:
;3124:void CG_PlayerShieldHit(int entitynum, vec3_t dir, int amount)
;3125:{
line 3129
;3126:	centity_t *cent;
;3127:	int	time;
;3128:
;3129:	if (entitynum<0 || entitynum >= MAX_CLIENTS)
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1407
ADDRLP4 8
INDIRI4
CNSTI4 32
LTI4 $1405
LABELV $1407
line 3130
;3130:	{
line 3131
;3131:		return;
ADDRGP4 $1404
JUMPV
LABELV $1405
line 3134
;3132:	}
;3133:
;3134:	cent = &cg_entities[entitynum];
ADDRLP4 0
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 3136
;3135:
;3136:	if (amount > 100)
ADDRFP4 8
INDIRI4
CNSTI4 100
LEI4 $1408
line 3137
;3137:	{
line 3138
;3138:		time = cg.time + MAX_SHIELD_TIME;		// 2 sec.
ADDRLP4 4
ADDRGP4 cg+64
INDIRI4
CVIF4 4
CNSTF4 1157234688
ADDF4
CVFI4 4
ASGNI4
line 3139
;3139:	}
ADDRGP4 $1409
JUMPV
LABELV $1408
line 3141
;3140:	else
;3141:	{
line 3142
;3142:		time = cg.time + 500 + amount*15;
ADDRLP4 4
ADDRGP4 cg+64
INDIRI4
CNSTI4 500
ADDI4
CNSTI4 15
ADDRFP4 8
INDIRI4
MULI4
ADDI4
ASGNI4
line 3143
;3143:	}
LABELV $1409
line 3145
;3144:
;3145:	if (time > cent->damageTime)
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
LEI4 $1412
line 3146
;3146:	{
line 3147
;3147:		cent->damageTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 3148
;3148:		VectorScale(dir, -1, dir);
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTF4 3212836864
ADDRLP4 12
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 16
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTF4 3212836864
ADDRLP4 16
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTF4 3212836864
ADDRLP4 20
INDIRP4
INDIRF4
MULF4
ASGNF4
line 3149
;3149:		vectoangles(dir, cent->damageAngles);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3150
;3150:	}
LABELV $1412
line 3151
;3151:}
LABELV $1404
endproc CG_PlayerShieldHit 24 8
export CG_DrawPlayerShield
proc CG_DrawPlayerShield 224 12
line 3155
;3152:
;3153:
;3154:void CG_DrawPlayerShield(centity_t *cent, vec3_t origin)
;3155:{
line 3161
;3156:	refEntity_t ent;
;3157:	int			alpha;
;3158:	float		scale;
;3159:	
;3160:	// Don't draw the shield when the player is dead.
;3161:	if (cent->currentState.eFlags & EF_DEAD)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1415
line 3162
;3162:	{
line 3163
;3163:		return;
ADDRGP4 $1414
JUMPV
LABELV $1415
line 3166
;3164:	}
;3165:
;3166:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3168
;3167:
;3168:	VectorCopy( origin, ent.origin );
ADDRLP4 0+52
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 3169
;3169:	ent.origin[2] += 10.0;
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 3170
;3170:	AnglesToAxis( cent->damageAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 3172
;3171:
;3172:	alpha = 255.0 * ((cent->damageTime - cg.time) / MIN_SHIELD_TIME) + random()*16;
ADDRLP4 220
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 216
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1157234688
DIVF4
MULF4
CNSTF4 1098907648
ADDRLP4 220
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 3173
;3173:	if (alpha>255)
ADDRLP4 216
INDIRI4
CNSTI4 255
LEI4 $1422
line 3174
;3174:		alpha=255;
ADDRLP4 216
CNSTI4 255
ASGNI4
LABELV $1422
line 3177
;3175:
;3176:	// Make it bigger, but tighter if more solid
;3177:	scale = 1.4 - ((float)alpha*(0.4/255.0));		// Range from 1.0 to 1.4
ADDRLP4 212
CNSTF4 1068708659
CNSTF4 986552935
ADDRLP4 216
INDIRI4
CVIF4 4
MULF4
SUBF4
ASGNF4
line 3178
;3178:	VectorScale( ent.axis[0], scale, ent.axis[0] );
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+4
ADDRLP4 0+12+4
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+8
ADDRLP4 0+12+8
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ASGNF4
line 3179
;3179:	VectorScale( ent.axis[1], scale, ent.axis[1] );
ADDRLP4 0+12+12
ADDRLP4 0+12+12
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+12+4
ADDRLP4 0+12+12+4
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+12+8
ADDRLP4 0+12+12+8
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ASGNF4
line 3180
;3180:	VectorScale( ent.axis[2], scale, ent.axis[2] );
ADDRLP4 0+12+24
ADDRLP4 0+12+24
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+24+4
ADDRLP4 0+12+24+4
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+24+8
ADDRLP4 0+12+24+8
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ASGNF4
line 3182
;3181:
;3182:	ent.hModel = cgs.media.halfShieldModel;
ADDRLP4 0+8
ADDRGP4 cgs+70280+912
INDIRI4
ASGNI4
line 3183
;3183:	ent.customShader = cgs.media.halfShieldShader;
ADDRLP4 0+76
ADDRGP4 cgs+70280+916
INDIRI4
ASGNI4
line 3184
;3184:	ent.shaderRGBA[0] = alpha;
ADDRLP4 0+80
ADDRLP4 216
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 3185
;3185:	ent.shaderRGBA[1] = alpha;
ADDRLP4 0+80+1
ADDRLP4 216
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 3186
;3186:	ent.shaderRGBA[2] = alpha;
ADDRLP4 0+80+2
ADDRLP4 216
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 3187
;3187:	ent.shaderRGBA[3] = 255;
ADDRLP4 0+80+3
CNSTU1 255
ASGNU1
line 3188
;3188:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3189
;3189:}
LABELV $1414
endproc CG_DrawPlayerShield 224 12
export CG_PlayerHitFX
proc CG_PlayerHitFX 4 8
line 3193
;3190:
;3191:
;3192:void CG_PlayerHitFX(centity_t *cent)
;3193:{
line 3197
;3194:	centity_t *curent;
;3195:
;3196:	// only do the below fx if the cent in question is...uh...me, and it's first person.
;3197:	if (cent->currentState.clientNum != cg.predictedPlayerState.clientNum || cg.renderingThirdPerson)
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ADDRGP4 cg+96+144
INDIRI4
NEI4 $1485
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
EQI4 $1480
LABELV $1485
line 3198
;3198:	{
line 3200
;3199:		// Get the NON-PREDICTED player entity, because the predicted one doesn't have the damage info on it.
;3200:		curent = &cg_entities[cent->currentState.number];
ADDRLP4 0
CNSTI4 1920
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 3202
;3201:
;3202:		if (curent->damageTime > cg.time)
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $1479
line 3203
;3203:		{
line 3204
;3204:			CG_DrawPlayerShield(curent, cent->lerpOrigin);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 CG_DrawPlayerShield
CALLV
pop
line 3205
;3205:		}
line 3207
;3206:
;3207:		return;
LABELV $1480
line 3209
;3208:	}
;3209:}
LABELV $1479
endproc CG_PlayerHitFX 4 8
export CG_LightVerts
proc CG_LightVerts 88 16
line 3219
;3210:
;3211:
;3212:
;3213:/*
;3214:=================
;3215:CG_LightVerts
;3216:=================
;3217:*/
;3218:int CG_LightVerts( vec3_t normal, int numVerts, polyVert_t *verts )
;3219:{
line 3226
;3220:	int				i, j;
;3221:	float			incoming;
;3222:	vec3_t			ambientLight;
;3223:	vec3_t			lightDir;
;3224:	vec3_t			directedLight;
;3225:
;3226:	trap_R_LightForPoint( verts[0].xyz, ambientLight, directedLight, lightDir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_LightForPoint
CALLI4
pop
line 3228
;3227:
;3228:	for (i = 0; i < numVerts; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1493
JUMPV
LABELV $1490
line 3229
;3229:		incoming = DotProduct (normal, lightDir);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3230
;3230:		if ( incoming <= 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $1496
line 3231
;3231:			verts[i].modulate[0] = ambientLight[0];
ADDRLP4 56
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 60
CNSTF4 1325400064
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
LTF4 $1499
ADDRLP4 52
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1500
JUMPV
LABELV $1499
ADDRLP4 52
ADDRLP4 56
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1500
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 52
INDIRU4
CVUU1 4
ASGNU1
line 3232
;3232:			verts[i].modulate[1] = ambientLight[1];
ADDRLP4 68
ADDRLP4 12+4
INDIRF4
ASGNF4
ADDRLP4 72
CNSTF4 1325400064
ASGNF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $1503
ADDRLP4 64
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1504
JUMPV
LABELV $1503
ADDRLP4 64
ADDRLP4 68
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1504
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 3233
;3233:			verts[i].modulate[2] = ambientLight[2];
ADDRLP4 80
ADDRLP4 12+8
INDIRF4
ASGNF4
ADDRLP4 84
CNSTF4 1325400064
ASGNF4
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
LTF4 $1507
ADDRLP4 76
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1508
JUMPV
LABELV $1507
ADDRLP4 76
ADDRLP4 80
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1508
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 76
INDIRU4
CVUU1 4
ASGNU1
line 3234
;3234:			verts[i].modulate[3] = 255;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 3235
;3235:			continue;
ADDRGP4 $1491
JUMPV
LABELV $1496
line 3237
;3236:		} 
;3237:		j = ( ambientLight[0] + incoming * directedLight[0] );
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 3238
;3238:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1509
line 3239
;3239:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 3240
;3240:		}
LABELV $1509
line 3241
;3241:		verts[i].modulate[0] = j;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 3243
;3242:
;3243:		j = ( ambientLight[1] + incoming * directedLight[1] );
ADDRLP4 0
ADDRLP4 12+4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 3244
;3244:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1513
line 3245
;3245:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 3246
;3246:		}
LABELV $1513
line 3247
;3247:		verts[i].modulate[1] = j;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 3249
;3248:
;3249:		j = ( ambientLight[2] + incoming * directedLight[2] );
ADDRLP4 0
ADDRLP4 12+8
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+8
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 3250
;3250:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1517
line 3251
;3251:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 3252
;3252:		}
LABELV $1517
line 3253
;3253:		verts[i].modulate[2] = j;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 3255
;3254:
;3255:		verts[i].modulate[3] = 255;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 3256
;3256:	}
LABELV $1491
line 3228
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1493
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $1490
line 3257
;3257:	return qtrue;
CNSTI4 1
RETI4
LABELV $1489
endproc CG_LightVerts 88 16
lit
align 4
LABELV $1520
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export CG_DoSaber
code
proc CG_DoSaber 313 20
line 3261
;3258:}
;3259:
;3260:void CG_DoSaber( vec3_t origin, vec3_t dir, float length, saber_colors_t color, int rfx )
;3261:{
line 3262
;3262:	vec3_t		mid, rgb={1,1,1};
ADDRLP4 212
ADDRGP4 $1520
INDIRB
ASGNB 12
line 3263
;3263:	qhandle_t	blade = 0, glow = 0;
ADDRLP4 240
CNSTI4 0
ASGNI4
ADDRLP4 244
CNSTI4 0
ASGNI4
line 3267
;3264:	refEntity_t saber;
;3265:	float radiusmult;
;3266:
;3267:	if ( length < 0.5f )
ADDRFP4 8
INDIRF4
CNSTF4 1056964608
GEF4 $1521
line 3268
;3268:	{
line 3270
;3269:		// if the thing is so short, just forget even adding me.
;3270:		return;
ADDRGP4 $1519
JUMPV
LABELV $1521
line 3274
;3271:	}
;3272:
;3273:	// Find the midpoint of the saber for lighting purposes
;3274:	VectorMA( origin, length * 0.5f, dir, mid );
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 256
CNSTF4 1056964608
ADDRFP4 8
INDIRF4
MULF4
ASGNF4
ADDRLP4 224
ADDRLP4 248
INDIRP4
INDIRF4
ADDRLP4 252
INDIRP4
INDIRF4
ADDRLP4 256
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 260
CNSTI4 4
ASGNI4
ADDRLP4 224+4
ADDRLP4 248
INDIRP4
ADDRLP4 260
INDIRI4
ADDP4
INDIRF4
ADDRLP4 252
INDIRP4
ADDRLP4 260
INDIRI4
ADDP4
INDIRF4
ADDRLP4 256
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 264
CNSTI4 8
ASGNI4
ADDRLP4 224+8
ADDRFP4 0
INDIRP4
ADDRLP4 264
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 264
INDIRI4
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRFP4 8
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 3276
;3275:
;3276:	switch( color )
ADDRLP4 268
ADDRFP4 12
INDIRI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
LTI4 $1525
ADDRLP4 268
INDIRI4
CNSTI4 5
GTI4 $1525
ADDRLP4 268
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1576
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1576
address $1528
address $1535
address $1542
address $1549
address $1556
address $1563
code
line 3277
;3277:	{
LABELV $1528
line 3279
;3278:		case SABER_RED:
;3279:			glow = cgs.media.redSaberGlowShader;
ADDRLP4 244
ADDRGP4 cgs+70280+116
INDIRI4
ASGNI4
line 3280
;3280:			blade = cgs.media.redSaberCoreShader;
ADDRLP4 240
ADDRGP4 cgs+70280+120
INDIRI4
ASGNI4
line 3281
;3281:			VectorSet( rgb, 1.0f, 0.2f, 0.2f );
ADDRLP4 212
CNSTF4 1065353216
ASGNF4
ADDRLP4 212+4
CNSTF4 1045220557
ASGNF4
ADDRLP4 212+8
CNSTF4 1045220557
ASGNF4
line 3282
;3282:			break;
ADDRGP4 $1526
JUMPV
LABELV $1535
line 3284
;3283:		case SABER_ORANGE:
;3284:			glow = cgs.media.orangeSaberGlowShader;
ADDRLP4 244
ADDRGP4 cgs+70280+124
INDIRI4
ASGNI4
line 3285
;3285:			blade = cgs.media.orangeSaberCoreShader;
ADDRLP4 240
ADDRGP4 cgs+70280+128
INDIRI4
ASGNI4
line 3286
;3286:			VectorSet( rgb, 1.0f, 0.5f, 0.1f );
ADDRLP4 212
CNSTF4 1065353216
ASGNF4
ADDRLP4 212+4
CNSTF4 1056964608
ASGNF4
ADDRLP4 212+8
CNSTF4 1036831949
ASGNF4
line 3287
;3287:			break;
ADDRGP4 $1526
JUMPV
LABELV $1542
line 3289
;3288:		case SABER_YELLOW:
;3289:			glow = cgs.media.yellowSaberGlowShader;
ADDRLP4 244
ADDRGP4 cgs+70280+132
INDIRI4
ASGNI4
line 3290
;3290:			blade = cgs.media.yellowSaberCoreShader;
ADDRLP4 240
ADDRGP4 cgs+70280+136
INDIRI4
ASGNI4
line 3291
;3291:			VectorSet( rgb, 1.0f, 1.0f, 0.2f );
ADDRLP4 276
CNSTF4 1065353216
ASGNF4
ADDRLP4 212
ADDRLP4 276
INDIRF4
ASGNF4
ADDRLP4 212+4
ADDRLP4 276
INDIRF4
ASGNF4
ADDRLP4 212+8
CNSTF4 1045220557
ASGNF4
line 3292
;3292:			break;
ADDRGP4 $1526
JUMPV
LABELV $1549
line 3294
;3293:		case SABER_GREEN:
;3294:			glow = cgs.media.greenSaberGlowShader;
ADDRLP4 244
ADDRGP4 cgs+70280+140
INDIRI4
ASGNI4
line 3295
;3295:			blade = cgs.media.greenSaberCoreShader;
ADDRLP4 240
ADDRGP4 cgs+70280+144
INDIRI4
ASGNI4
line 3296
;3296:			VectorSet( rgb, 0.2f, 1.0f, 0.2f );
ADDRLP4 212
CNSTF4 1045220557
ASGNF4
ADDRLP4 212+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 212+8
CNSTF4 1045220557
ASGNF4
line 3297
;3297:			break;
ADDRGP4 $1526
JUMPV
LABELV $1556
line 3299
;3298:		case SABER_BLUE:
;3299:			glow = cgs.media.blueSaberGlowShader;
ADDRLP4 244
ADDRGP4 cgs+70280+148
INDIRI4
ASGNI4
line 3300
;3300:			blade = cgs.media.blueSaberCoreShader;
ADDRLP4 240
ADDRGP4 cgs+70280+152
INDIRI4
ASGNI4
line 3301
;3301:			VectorSet( rgb, 0.2f, 0.4f, 1.0f );
ADDRLP4 212
CNSTF4 1045220557
ASGNF4
ADDRLP4 212+4
CNSTF4 1053609165
ASGNF4
ADDRLP4 212+8
CNSTF4 1065353216
ASGNF4
line 3302
;3302:			break;
ADDRGP4 $1526
JUMPV
LABELV $1563
line 3304
;3303:		case SABER_PURPLE:
;3304:			glow = cgs.media.purpleSaberGlowShader;
ADDRLP4 244
ADDRGP4 cgs+70280+156
INDIRI4
ASGNI4
line 3305
;3305:			blade = cgs.media.purpleSaberCoreShader;
ADDRLP4 240
ADDRGP4 cgs+70280+160
INDIRI4
ASGNI4
line 3306
;3306:			VectorSet( rgb, 0.9f, 0.2f, 1.0f );
ADDRLP4 212
CNSTF4 1063675494
ASGNF4
ADDRLP4 212+4
CNSTF4 1045220557
ASGNF4
ADDRLP4 212+8
CNSTF4 1065353216
ASGNF4
line 3307
;3307:			break;
ADDRGP4 $1526
JUMPV
LABELV $1525
line 3309
;3308:		default:
;3309:			glow = cgs.media.blueSaberGlowShader;
ADDRLP4 244
ADDRGP4 cgs+70280+148
INDIRI4
ASGNI4
line 3310
;3310:			blade = cgs.media.blueSaberCoreShader;
ADDRLP4 240
ADDRGP4 cgs+70280+152
INDIRI4
ASGNI4
line 3311
;3311:			VectorSet( rgb, 0.2f, 0.4f, 1.0f );
ADDRLP4 212
CNSTF4 1045220557
ASGNF4
ADDRLP4 212+4
CNSTF4 1053609165
ASGNF4
ADDRLP4 212+8
CNSTF4 1065353216
ASGNF4
line 3312
;3312:			break;
LABELV $1526
line 3316
;3313:	}
;3314:
;3315:	// always add a light because sabers cast a nice glow before they slice you in half!!  or something...
;3316:	trap_R_AddLightToScene( mid, (length*2.0f) + (random()*8.0f), rgb[0], rgb[1], rgb[2] );
ADDRLP4 276
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 224
ARGP4
CNSTF4 1073741824
ADDRFP4 8
INDIRF4
MULF4
CNSTF4 1090519040
ADDRLP4 276
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ARGF4
ADDRLP4 212
INDIRF4
ARGF4
ADDRLP4 212+4
INDIRF4
ARGF4
ADDRLP4 212+8
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 3318
;3317:
;3318:	memset( &saber, 0, sizeof( refEntity_t ));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3322
;3319:
;3320:	// Saber glow is it's own ref type because it uses a ton of sprites, otherwise it would eat up too many
;3321:	//	refEnts to do each glow blob individually
;3322:	saber.saberLength = length;
ADDRLP4 0+180
ADDRFP4 8
INDIRF4
ASGNF4
line 3326
;3323:
;3324:	// Jeff, I did this because I foolishly wished to have a bright halo as the saber is unleashed.  
;3325:	// It's not quite what I'd hoped tho.  If you have any ideas, go for it!  --Pat
;3326:	if (length < SABER_LENGTH_MAX)
ADDRFP4 8
INDIRF4
CNSTF4 1109393408
GEF4 $1580
line 3327
;3327:	{
line 3328
;3328:		radiusmult = 1.0 + (2.0 / length);		// Note this creates a curve, and length cannot be < 0.5.
ADDRLP4 236
CNSTF4 1073741824
ADDRFP4 8
INDIRF4
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3329
;3329:	}
ADDRGP4 $1581
JUMPV
LABELV $1580
line 3331
;3330:	else
;3331:	{
line 3332
;3332:		radiusmult = 1.0;
ADDRLP4 236
CNSTF4 1065353216
ASGNF4
line 3333
;3333:	}
LABELV $1581
line 3336
;3334:
;3335:
;3336:	saber.radius = (2.8 + crandom() * 0.2f)*radiusmult;
ADDRLP4 280
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+92
CNSTF4 1045220557
CNSTF4 1073741824
ADDRLP4 280
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
CNSTF4 1077097267
ADDF4
ADDRLP4 236
INDIRF4
MULF4
ASGNF4
line 3339
;3337:
;3338:
;3339:	VectorCopy( origin, saber.origin );
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 3340
;3340:	VectorCopy( dir, saber.axis[0] );
ADDRLP4 0+12
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 3341
;3341:	saber.reType = RT_SABER_GLOW;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 3342
;3342:	saber.customShader = glow;
ADDRLP4 0+76
ADDRLP4 244
INDIRI4
ASGNI4
line 3343
;3343:	saber.shaderRGBA[0] = saber.shaderRGBA[1] = saber.shaderRGBA[2] = saber.shaderRGBA[3] = 0xff;
ADDRLP4 284
CNSTU1 255
ASGNU1
ADDRLP4 0+80+3
ADDRLP4 284
INDIRU1
ASGNU1
ADDRLP4 0+80+2
ADDRLP4 284
INDIRU1
ASGNU1
ADDRLP4 0+80+1
ADDRLP4 284
INDIRU1
ASGNU1
ADDRLP4 0+80
ADDRLP4 284
INDIRU1
ASGNU1
line 3344
;3344:	saber.renderfx = rfx;
ADDRLP4 0+4
ADDRFP4 16
INDIRI4
ASGNI4
line 3346
;3345:
;3346:	trap_R_AddRefEntityToScene( &saber );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3349
;3347:
;3348:	// Do the hot core
;3349:	VectorMA( origin, length, dir, saber.origin );
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 288
CNSTI4 4
ASGNI4
ADDRLP4 0+52+4
ADDRFP4 0
INDIRP4
ADDRLP4 288
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 288
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 292
CNSTI4 8
ASGNI4
ADDRLP4 0+52+8
ADDRFP4 0
INDIRP4
ADDRLP4 292
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 292
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3350
;3350:	VectorMA( origin, -1, dir, saber.oldorigin );
ADDRLP4 0+64
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 3212836864
ADDRFP4 4
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 296
CNSTI4 4
ASGNI4
ADDRLP4 0+64+4
ADDRFP4 0
INDIRP4
ADDRLP4 296
INDIRI4
ADDP4
INDIRF4
CNSTF4 3212836864
ADDRFP4 4
INDIRP4
ADDRLP4 296
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 300
CNSTI4 8
ASGNI4
ADDRLP4 0+64+8
ADDRFP4 0
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
INDIRF4
CNSTF4 3212836864
ADDRFP4 4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 3354
;3351:
;3352:
;3353://	CG_TestLine(saber.origin, saber.oldorigin, 50, 0x000000ff, 3);
;3354:	saber.customShader = blade;
ADDRLP4 0+76
ADDRLP4 240
INDIRI4
ASGNI4
line 3355
;3355:	saber.reType = RT_LINE;
ADDRLP4 0
CNSTI4 8
ASGNI4
line 3356
;3356:	saber.radius = (1.0 + crandom() * 0.2f)*radiusmult;
ADDRLP4 304
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+92
CNSTF4 1045220557
CNSTF4 1073741824
ADDRLP4 304
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
CNSTF4 1065353216
ADDF4
ADDRLP4 236
INDIRF4
MULF4
ASGNF4
line 3358
;3357:
;3358:	saber.shaderTexCoord[0] = saber.shaderTexCoord[1] = 1.0f;
ADDRLP4 308
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+84+4
ADDRLP4 308
INDIRF4
ASGNF4
ADDRLP4 0+84
ADDRLP4 308
INDIRF4
ASGNF4
line 3359
;3359:	saber.shaderRGBA[0] = saber.shaderRGBA[1] = saber.shaderRGBA[2] = saber.shaderRGBA[3] = 0xff;
ADDRLP4 312
CNSTU1 255
ASGNU1
ADDRLP4 0+80+3
ADDRLP4 312
INDIRU1
ASGNU1
ADDRLP4 0+80+2
ADDRLP4 312
INDIRU1
ASGNU1
ADDRLP4 0+80+1
ADDRLP4 312
INDIRU1
ASGNU1
ADDRLP4 0+80
ADDRLP4 312
INDIRU1
ASGNU1
line 3361
;3360:
;3361:	trap_R_AddRefEntityToScene( &saber );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3362
;3362:}
LABELV $1519
endproc CG_DoSaber 313 20
export CG_GetTagWorldPosition
proc CG_GetTagWorldPosition 100 24
line 3370
;3363:
;3364://--------------------------------------------------------------
;3365:// CG_GetTagWorldPosition
;3366://
;3367:// Can pass in NULL for the axis
;3368://--------------------------------------------------------------
;3369:void CG_GetTagWorldPosition( refEntity_t *model, char *tag, vec3_t pos, vec3_t axis[3] )
;3370:{
line 3372
;3371:	orientation_t	orientation;
;3372:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3375
;3373:
;3374:	// Get the requested tag
;3375:	trap_R_LerpTag( &orientation, model->hModel, model->oldframe, model->frame,
ADDRLP4 4
ARGP4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
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
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 3378
;3376:		1.0f - model->backlerp, tag );
;3377:
;3378:	VectorCopy( model->origin, pos );
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRB
ASGNB 12
line 3379
;3379:	for ( i = 0 ; i < 3 ; i++ ) 
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1617
line 3380
;3380:	{
line 3381
;3381:		VectorMA( pos, orientation.origin[i], model->axis[i], pos );
ADDRLP4 56
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 60
CNSTI4 12
ASGNI4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 60
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
ADDRLP4 60
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
ADDRLP4 68
CNSTI4 4
ASGNI4
ADDRLP4 72
ADDRFP4 8
INDIRP4
ADDRLP4 68
INDIRI4
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
ADDRFP4 0
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ADDP4
ADDRLP4 68
INDIRI4
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
CNSTI4 8
ASGNI4
ADDRLP4 88
ADDRFP4 8
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
ASGNP4
ADDRLP4 92
CNSTI4 12
ASGNI4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
ADDRLP4 92
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
ADDP4
ADDRLP4 84
INDIRI4
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
line 3382
;3382:	}
LABELV $1618
line 3379
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1617
line 3384
;3383:
;3384:	if ( axis )
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1621
line 3385
;3385:	{
line 3386
;3386:		MatrixMultiply( orientation.axis, model->axis, axis );
ADDRLP4 4+12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 3387
;3387:	}
LABELV $1621
line 3388
;3388:}
LABELV $1616
endproc CG_GetTagWorldPosition 100 24
export CG_CreateSaberMarks
proc CG_CreateSaberMarks 6072 28
line 3395
;3389:
;3390:#define	MAX_MARK_FRAGMENTS	128
;3391:#define	MAX_MARK_POINTS		384
;3392:extern markPoly_t *CG_AllocMark();
;3393:
;3394:void CG_CreateSaberMarks( vec3_t start, vec3_t end, vec3_t normal )
;3395:{
line 3405
;3396://	byte			colors[4];
;3397:	int				i, j;
;3398:	int				numFragments;
;3399:	vec3_t			axis[3], originalPoints[4], mid;
;3400:	vec3_t			markPoints[MAX_MARK_POINTS], projection;
;3401:	polyVert_t		*v, verts[MAX_VERTS_ON_POLY];
;3402:	markPoly_t		*mark;
;3403:	markFragment_t	markFragments[MAX_MARK_FRAGMENTS], *mf;
;3404:
;3405:	float	radius = 0.65f;
ADDRLP4 4676
CNSTF4 1059481190
ASGNF4
line 3407
;3406:
;3407:	if ( !cg_addMarks.integer ) 
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 0
NEI4 $1625
line 3408
;3408:	{
line 3409
;3409:		return;
ADDRGP4 $1624
JUMPV
LABELV $1625
line 3412
;3410:	}
;3411:
;3412:	VectorSubtract( end, start, axis[1] );
ADDRLP4 16+12
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 6008
CNSTI4 4
ASGNI4
ADDRLP4 16+12+4
ADDRFP4 4
INDIRP4
ADDRLP4 6008
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 6008
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 6012
CNSTI4 8
ASGNI4
ADDRLP4 16+12+8
ADDRFP4 4
INDIRP4
ADDRLP4 6012
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 6012
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3413
;3413:	VectorNormalize( axis[1] );
ADDRLP4 16+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 3416
;3414:
;3415:	// create the texture axis
;3416:	VectorCopy( normal, axis[0] );
ADDRLP4 16
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 3417
;3417:	CrossProduct( axis[1], axis[0], axis[2] );
ADDRLP4 16+12
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 16+24
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 3420
;3418:
;3419:	// create the full polygon that we'll project
;3420:	for ( i = 0 ; i < 3 ; i++ ) 
ADDRLP4 60
CNSTI4 0
ASGNI4
LABELV $1636
line 3421
;3421:	{	// stretch a bit more in the direction that we are traveling in...  debateable as to whether this makes things better or worse
line 3422
;3422:		originalPoints[0][i] = start[i] - radius * axis[1][i] - radius * axis[2][i];
ADDRLP4 6016
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 6016
INDIRI4
ADDRLP4 4920
ADDP4
ADDRLP4 6016
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4676
INDIRF4
ADDRLP4 6016
INDIRI4
ADDRLP4 16+12
ADDP4
INDIRF4
MULF4
SUBF4
ADDRLP4 4676
INDIRF4
ADDRLP4 6016
INDIRI4
ADDRLP4 16+24
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 3423
;3423:		originalPoints[1][i] = end[i] + radius * axis[1][i] - radius * axis[2][i];
ADDRLP4 6024
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 6024
INDIRI4
ADDRLP4 4920+12
ADDP4
ADDRLP4 6024
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4676
INDIRF4
ADDRLP4 6024
INDIRI4
ADDRLP4 16+12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 4676
INDIRF4
ADDRLP4 6024
INDIRI4
ADDRLP4 16+24
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 3424
;3424:		originalPoints[2][i] = end[i] + radius * axis[1][i] + radius * axis[2][i];
ADDRLP4 6032
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 6032
INDIRI4
ADDRLP4 4920+24
ADDP4
ADDRLP4 6032
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4676
INDIRF4
ADDRLP4 6032
INDIRI4
ADDRLP4 16+12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 4676
INDIRF4
ADDRLP4 6032
INDIRI4
ADDRLP4 16+24
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 3425
;3425:		originalPoints[3][i] = start[i] - radius * axis[1][i] + radius * axis[2][i];
ADDRLP4 6040
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 6040
INDIRI4
ADDRLP4 4920+36
ADDP4
ADDRLP4 6040
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4676
INDIRF4
ADDRLP4 6040
INDIRI4
ADDRLP4 16+12
ADDP4
INDIRF4
MULF4
SUBF4
ADDRLP4 4676
INDIRF4
ADDRLP4 6040
INDIRI4
ADDRLP4 16+24
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 3426
;3426:	}
LABELV $1637
line 3420
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 3
LTI4 $1636
line 3428
;3427:
;3428:	VectorScale( normal, -1, projection );
ADDRLP4 6016
CNSTF4 3212836864
ASGNF4
ADDRLP4 6020
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4972
ADDRLP4 6016
INDIRF4
ADDRLP4 6020
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4972+4
ADDRLP4 6016
INDIRF4
ADDRLP4 6020
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4972+8
CNSTF4 3212836864
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 3431
;3429:
;3430:	// get the fragments
;3431:	numFragments = trap_CM_MarkFragments( 4, (const float (*)[3])originalPoints,
CNSTI4 4
ARGI4
ADDRLP4 4920
ARGP4
ADDRLP4 4972
ARGP4
CNSTI4 384
ARGI4
ADDRLP4 68
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 4984
ARGP4
ADDRLP4 6024
ADDRGP4 trap_CM_MarkFragments
CALLI4
ASGNI4
ADDRLP4 4968
ADDRLP4 6024
INDIRI4
ASGNI4
line 3435
;3432:					projection, MAX_MARK_POINTS, markPoints[0], MAX_MARK_FRAGMENTS, markFragments );
;3433:
;3434:
;3435:	for ( i = 0, mf = markFragments ; i < numFragments ; i++, mf++ ) 
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
ADDRLP4 4984
ASGNP4
ADDRGP4 $1656
JUMPV
LABELV $1653
line 3436
;3436:	{
line 3438
;3437:		// we have an upper limit on the complexity of polygons that we store persistantly
;3438:		if ( mf->numPoints > MAX_VERTS_ON_POLY ) 
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 10
LEI4 $1657
line 3439
;3439:		{
line 3440
;3440:			mf->numPoints = MAX_VERTS_ON_POLY;
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 3441
;3441:		}
LABELV $1657
line 3443
;3442:
;3443:		for ( j = 0, v = verts ; j < mf->numPoints ; j++, v++ ) 
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 12
ADDRLP4 4680
ASGNP4
ADDRGP4 $1662
JUMPV
LABELV $1659
line 3444
;3444:		{
line 3448
;3445:			vec3_t delta;
;3446:
;3447:			// Set up our texture coords, this may need some work 
;3448:			VectorCopy( markPoints[mf->firstPoint + j], v->xyz );
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDRLP4 56
INDIRP4
INDIRI4
ADDRLP4 52
INDIRI4
ADDI4
MULI4
ADDRLP4 68
ADDP4
INDIRB
ASGNB 12
line 3449
;3449:			VectorAdd( end, start, mid );
ADDRLP4 6040
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 6044
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 6040
INDIRP4
INDIRF4
ADDRLP4 6044
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 6048
CNSTI4 4
ASGNI4
ADDRLP4 0+4
ADDRLP4 6040
INDIRP4
ADDRLP4 6048
INDIRI4
ADDP4
INDIRF4
ADDRLP4 6044
INDIRP4
ADDRLP4 6048
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 6052
CNSTI4 8
ASGNI4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
ADDRLP4 6052
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 6052
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3450
;3450:			VectorScale( mid, 0.5f, mid );
ADDRLP4 6056
CNSTF4 1056964608
ASGNF4
ADDRLP4 0
ADDRLP4 6056
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 6056
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1056964608
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
line 3451
;3451:			VectorSubtract( v->xyz, mid, delta );
ADDRLP4 6028
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 6028+4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 6028+8
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 3453
;3452:
;3453:			v->st[0] = 0.5 + DotProduct( delta, axis[1] ) * (0.05f + random() * 0.03f); 
ADDRLP4 6064
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 6028
INDIRF4
ADDRLP4 16+12
INDIRF4
MULF4
ADDRLP4 6028+4
INDIRF4
ADDRLP4 16+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 6028+8
INDIRF4
ADDRLP4 16+12+8
INDIRF4
MULF4
ADDF4
CNSTF4 1022739087
ADDRLP4 6064
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1028443341
ADDF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 3454
;3454:			v->st[1] = 0.5 + DotProduct( delta, axis[2] ) * (0.15f + random() * 0.05f);	
ADDRLP4 6068
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 6028
INDIRF4
ADDRLP4 16+24
INDIRF4
MULF4
ADDRLP4 6028+4
INDIRF4
ADDRLP4 16+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 6028+8
INDIRF4
ADDRLP4 16+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 1028443341
ADDRLP4 6068
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1041865114
ADDF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 3455
;3455:		}
LABELV $1660
line 3443
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
LABELV $1662
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $1659
line 3458
;3456:
;3457:		// save it persistantly, do burn first
;3458:		mark = CG_AllocMark();
ADDRLP4 6028
ADDRGP4 CG_AllocMark
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 6028
INDIRP4
ASGNP4
line 3459
;3459:		mark->time = cg.time;
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3460
;3460:		mark->alphaFade = qtrue;
ADDRLP4 64
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 1
ASGNI4
line 3461
;3461:		mark->markShader = cgs.media.rivetMarkShader;
ADDRLP4 64
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cgs+70280+172
INDIRI4
ASGNI4
line 3462
;3462:		mark->poly.numVerts = mf->numPoints;
ADDRLP4 64
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 3463
;3463:		mark->color[0] = mark->color[1] = mark->color[2] = mark->color[3] = 255;
ADDRLP4 6036
CNSTF4 1132396544
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 6036
INDIRF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 6036
INDIRF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 6036
INDIRF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 6036
INDIRF4
ASGNF4
line 3464
;3464:		memcpy( mark->verts, verts, mf->numPoints * sizeof( verts[0] ) );
ADDRLP4 64
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 4680
ARGP4
CNSTU4 24
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIU4 4
MULU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3468
;3465:
;3466:		// And now do a glow pass
;3467:		// by moving the start time back, we can hack it to fade out way before the burn does
;3468:		mark = CG_AllocMark();
ADDRLP4 6040
ADDRGP4 CG_AllocMark
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 6040
INDIRP4
ASGNP4
line 3469
;3469:		mark->time = cg.time - 8500;
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 8500
SUBI4
ASGNI4
line 3470
;3470:		mark->alphaFade = qfalse;
ADDRLP4 64
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 3471
;3471:		mark->markShader = trap_R_RegisterShader("gfx/effects/saberDamageGlow" );
ADDRGP4 $1691
ARGP4
ADDRLP4 6044
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 6044
INDIRI4
ASGNI4
line 3472
;3472:		mark->poly.numVerts = mf->numPoints;
ADDRLP4 64
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 3473
;3473:		mark->color[0] = 215 + random() * 40.0f;
ADDRLP4 6048
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1109393408
ADDRLP4 6048
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1129775104
ADDF4
ASGNF4
line 3474
;3474:		mark->color[1] = 96 + random() * 32.0f;
ADDRLP4 6052
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1107296256
ADDRLP4 6052
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1119879168
ADDF4
ASGNF4
line 3475
;3475:		mark->color[2] = mark->color[3] = random()*15.0f;
ADDRLP4 6056
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 6064
CNSTF4 1097859072
ADDRLP4 6056
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 6064
INDIRF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 6064
INDIRF4
ASGNF4
line 3476
;3476:		memcpy( mark->verts, verts, mf->numPoints * sizeof( verts[0] ) );
ADDRLP4 64
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 4680
ARGP4
CNSTU4 24
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIU4 4
MULU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3477
;3477:	}
LABELV $1654
line 3435
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 56
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
LABELV $1656
ADDRLP4 60
INDIRI4
ADDRLP4 4968
INDIRI4
LTI4 $1653
line 3478
;3478:}
LABELV $1624
endproc CG_CreateSaberMarks 6072 28
lit
align 4
LABELV $1693
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1873
byte 4 1132396544
byte 4 1132396544
byte 4 1132396544
export CG_AddSaberBlade
code
proc CG_AddSaberBlade 1672 36
line 3484
;3479:
;3480:#define SABER_TRAIL_TIME	40.0f
;3481:#define FX_USE_ALPHA		0x08000000
;3482:
;3483:void CG_AddSaberBlade( centity_t *cent, centity_t *scent, refEntity_t *saber, int renderfx, int modelIndex, vec3_t origin, vec3_t angles, qboolean fromSaber)
;3484:{
line 3486
;3485:	vec3_t	org_, end, v,
;3486:			axis_[3] = {0,0,0, 0,0,0, 0,0,0};	// shut the compiler up
ADDRLP4 1136
ADDRGP4 $1693
INDIRB
ASGNB 36
line 3488
;3487:	trace_t	trace;
;3488:	int i = 0;
ADDRLP4 1080
CNSTI4 0
ASGNI4
line 3497
;3489:	float saberLen, dualSaberLen;
;3490:	float diff;
;3491:	clientInfo_t *client;
;3492:	centity_t *saberEnt;
;3493:	saberTrail_t *saberTrail;
;3494:	mdxaBone_t	boltMatrix;
;3495:	vec3_t futureAngles;
;3496:	effectTrailArgStruct_t fx;
;3497:	int scolor = 0;
ADDRLP4 1560
CNSTI4 0
ASGNI4
line 3499
;3498:	vec3_t otherPos, otherDir, otherEnd;
;3499:	float dualLen = 0.7;
ADDRLP4 1556
CNSTF4 1060320051
ASGNF4
line 3501
;3500:
;3501:	saberEnt = &cg_entities[cent->currentState.saberEntityNum];
ADDRLP4 1576
CNSTI4 1920
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 3504
;3502:
;3503:	if (/*cg.snap->ps.clientNum == cent->currentState.number && */
;3504:		cgs.clientinfo[ cent->currentState.clientNum ].team != TEAM_SPECTATOR &&
CNSTI4 788
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1694
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $1694
line 3506
;3505:		!(cg.snap->ps.pm_flags & PMF_FOLLOW))
;3506:	{
line 3507
;3507:		if (cent->saberLength < 1)
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1699
line 3508
;3508:		{
line 3509
;3509:			cent->saberLength = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1065353216
ASGNF4
line 3510
;3510:			cent->saberExtendTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3511
;3511:		}
LABELV $1699
line 3513
;3512:
;3513:		if (cent->saberLength < SABER_LENGTH_MAX)
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRF4
CNSTF4 1109393408
GEF4 $1702
line 3514
;3514:		{
line 3515
;3515:			cent->saberLength += (cg.time - cent->saberExtendTime)*0.05;
ADDRLP4 1632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1636
ADDRLP4 1632
INDIRP4
CNSTI4 1000
ADDP4
ASGNP4
ADDRLP4 1636
INDIRP4
ADDRLP4 1636
INDIRP4
INDIRF4
CNSTF4 1028443341
ADDRGP4 cg+64
INDIRI4
ADDRLP4 1632
INDIRP4
CNSTI4 1004
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 3516
;3516:		}
LABELV $1702
line 3518
;3517:
;3518:		if (cent->saberLength > SABER_LENGTH_MAX)
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRF4
CNSTF4 1109393408
LEF4 $1705
line 3519
;3519:		{
line 3520
;3520:			cent->saberLength = SABER_LENGTH_MAX;
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1109393408
ASGNF4
line 3521
;3521:		}
LABELV $1705
line 3523
;3522:
;3523:		cent->saberExtendTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3524
;3524:		saberLen = cent->saberLength;
ADDRLP4 1520
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRF4
ASGNF4
line 3525
;3525:	}
ADDRGP4 $1695
JUMPV
LABELV $1694
line 3527
;3526:	else
;3527:	{
line 3528
;3528:		saberLen = SABER_LENGTH_MAX;
ADDRLP4 1520
CNSTF4 1109393408
ASGNF4
line 3529
;3529:	}
LABELV $1695
line 3535
;3530:
;3531:/*
;3532:Ghoul2 Insert Start
;3533:*/
;3534:
;3535:	dualSaberLen = saberLen;
ADDRLP4 1552
ADDRLP4 1520
INDIRF4
ASGNF4
line 3537
;3536:
;3537:	if ((cent->currentState.eFlags & EF_DEAD) && !fromSaber)
ADDRLP4 1632
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 1632
INDIRI4
EQI4 $1708
ADDRFP4 28
INDIRI4
ADDRLP4 1632
INDIRI4
NEI4 $1708
line 3538
;3538:	{ //trying to draw a saber on a corpse? That's bad.
line 3539
;3539:		return;
ADDRGP4 $1692
JUMPV
LABELV $1708
line 3542
;3540:	}
;3541:
;3542:	futureAngles[YAW] = angles[YAW];
ADDRLP4 1564+4
ADDRFP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 3543
;3543:	futureAngles[PITCH] = angles[PITCH];
ADDRLP4 1564
ADDRFP4 24
INDIRP4
INDIRF4
ASGNF4
line 3544
;3544:	futureAngles[ROLL] = angles[ROLL];
ADDRLP4 1564+8
ADDRFP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 3547
;3545:
;3546:	// figure out where the actual model muzzle is
;3547:	if (fromSaber)
ADDRFP4 28
INDIRI4
CNSTI4 0
EQI4 $1712
line 3548
;3548:	{
line 3549
;3549:		trap_G2API_GetBoltMatrix(scent->ghoul2, 0, 0, &boltMatrix, futureAngles, origin, cg.time, cgs.gameModels, scent->modelScale);
ADDRLP4 1636
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1636
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 1640
CNSTI4 0
ASGNI4
ADDRLP4 1640
INDIRI4
ARGI4
ADDRLP4 1640
INDIRI4
ARGI4
ADDRLP4 1580
ARGP4
ADDRLP4 1564
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 1636
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 3550
;3550:	}
ADDRGP4 $1713
JUMPV
LABELV $1712
line 3552
;3551:	else
;3552:	{
line 3553
;3553:		trap_G2API_GetBoltMatrix(scent->ghoul2, 1, 0, &boltMatrix, futureAngles, origin, cg.time, cgs.gameModels, scent->modelScale);
ADDRLP4 1636
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1636
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1580
ARGP4
ADDRLP4 1564
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 1636
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 3554
;3554:	}
LABELV $1713
line 3556
;3555:	// work the matrix axis stuff into the original axis and origins used.
;3556:	trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, ORIGIN, org_);
ADDRLP4 1580
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1088
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 3557
;3557:	trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, NEGATIVE_Y, axis_[0]);
ADDRLP4 1580
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 1136
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 3559
;3558:
;3559:	if (!fromSaber && saberEnt)
ADDRFP4 28
INDIRI4
CNSTI4 0
NEI4 $1718
ADDRLP4 1576
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1718
line 3560
;3560:	{
line 3561
;3561:		VectorCopy(org_, saberEnt->currentState.pos.trBase);
ADDRLP4 1576
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 1088
INDIRB
ASGNB 12
line 3563
;3562:
;3563:		VectorCopy(axis_[0], saberEnt->currentState.apos.trBase);
ADDRLP4 1576
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 1136
INDIRB
ASGNB 12
line 3564
;3564:	}
LABELV $1718
line 3566
;3565:
;3566:	client = &cgs.clientinfo[cent->currentState.number];
ADDRLP4 1084
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 3568
;3567:
;3568:	if (!client)
ADDRLP4 1084
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1721
line 3569
;3569:	{ //something horrible has apparently happened
line 3570
;3570:		return;
ADDRGP4 $1692
JUMPV
LABELV $1721
line 3573
;3571:	}
;3572:
;3573:	if (cent->currentState.bolt2)
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1723
line 3574
;3574:	{
line 3575
;3575:		VectorMA( org_, saberLen*dualLen, axis_[0], end );
ADDRLP4 1636
ADDRLP4 1520
INDIRF4
ADDRLP4 1556
INDIRF4
MULF4
ASGNF4
ADDRLP4 1112
ADDRLP4 1088
INDIRF4
ADDRLP4 1136
INDIRF4
ADDRLP4 1636
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1112+4
ADDRLP4 1088+4
INDIRF4
ADDRLP4 1136+4
INDIRF4
ADDRLP4 1636
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1112+8
ADDRLP4 1088+8
INDIRF4
ADDRLP4 1136+8
INDIRF4
ADDRLP4 1520
INDIRF4
ADDRLP4 1556
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 3576
;3576:	}
ADDRGP4 $1724
JUMPV
LABELV $1723
line 3578
;3577:	else
;3578:	{
line 3579
;3579:		VectorMA( org_, saberLen, axis_[0], end );
ADDRLP4 1112
ADDRLP4 1088
INDIRF4
ADDRLP4 1136
INDIRF4
ADDRLP4 1520
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1112+4
ADDRLP4 1088+4
INDIRF4
ADDRLP4 1136+4
INDIRF4
ADDRLP4 1520
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1112+8
ADDRLP4 1088+8
INDIRF4
ADDRLP4 1136+8
INDIRF4
ADDRLP4 1520
INDIRF4
MULF4
ADDF4
ASGNF4
line 3580
;3580:	}
LABELV $1724
line 3582
;3581:	
;3582:	VectorAdd( end, axis_[0], end );
ADDRLP4 1112
ADDRLP4 1112
INDIRF4
ADDRLP4 1136
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1112+4
ADDRLP4 1112+4
INDIRF4
ADDRLP4 1136+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1112+8
ADDRLP4 1112+8
INDIRF4
ADDRLP4 1136+8
INDIRF4
ADDF4
ASGNF4
line 3584
;3583:
;3584:	if (cent->currentState.bolt2)
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1743
line 3585
;3585:	{
line 3586
;3586:		otherPos[0] = org_[0] - axis_[0][0]*12;
ADDRLP4 1124
ADDRLP4 1088
INDIRF4
CNSTF4 1094713344
ADDRLP4 1136
INDIRF4
MULF4
SUBF4
ASGNF4
line 3587
;3587:		otherPos[1] = org_[1] - axis_[0][1]*12;
ADDRLP4 1124+4
ADDRLP4 1088+4
INDIRF4
CNSTF4 1094713344
ADDRLP4 1136+4
INDIRF4
MULF4
SUBF4
ASGNF4
line 3588
;3588:		otherPos[2] = org_[2] - axis_[0][2]*12;
ADDRLP4 1124+8
ADDRLP4 1088+8
INDIRF4
CNSTF4 1094713344
ADDRLP4 1136+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 3590
;3589:
;3590:		otherDir[0] = -axis_[0][0];
ADDRLP4 1540
ADDRLP4 1136
INDIRF4
NEGF4
ASGNF4
line 3591
;3591:		otherDir[1] = -axis_[0][1];
ADDRLP4 1540+4
ADDRLP4 1136+4
INDIRF4
NEGF4
ASGNF4
line 3592
;3592:		otherDir[2] = -axis_[0][2];
ADDRLP4 1540+8
ADDRLP4 1136+8
INDIRF4
NEGF4
ASGNF4
line 3594
;3593:
;3594:		VectorMA( otherPos, dualSaberLen*dualLen, otherDir, otherEnd );
ADDRLP4 1636
ADDRLP4 1552
INDIRF4
ADDRLP4 1556
INDIRF4
MULF4
ASGNF4
ADDRLP4 1524
ADDRLP4 1124
INDIRF4
ADDRLP4 1540
INDIRF4
ADDRLP4 1636
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1524+4
ADDRLP4 1124+4
INDIRF4
ADDRLP4 1540+4
INDIRF4
ADDRLP4 1636
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1524+8
ADDRLP4 1124+8
INDIRF4
ADDRLP4 1540+8
INDIRF4
ADDRLP4 1552
INDIRF4
ADDRLP4 1556
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 3595
;3595:		VectorAdd( otherEnd, otherDir, otherEnd );
ADDRLP4 1524
ADDRLP4 1524
INDIRF4
ADDRLP4 1540
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1524+4
ADDRLP4 1524+4
INDIRF4
ADDRLP4 1540+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1524+8
ADDRLP4 1524+8
INDIRF4
ADDRLP4 1540+8
INDIRF4
ADDF4
ASGNF4
line 3596
;3596:	}
LABELV $1743
line 3598
;3597:
;3598:	scolor = cgs.clientinfo[cent->currentState.number].icolor1;
ADDRLP4 1560
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+104
ADDP4
INDIRI4
ASGNI4
line 3600
;3599:
;3600:	if (cgs.gametype >= GT_TEAM)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $1769
line 3601
;3601:	{
line 3602
;3602:		if (cgs.clientinfo[cent->currentState.number].team == TEAM_RED)
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1772
line 3603
;3603:		{
line 3604
;3604:			scolor = SABER_RED;
ADDRLP4 1560
CNSTI4 0
ASGNI4
line 3605
;3605:		}
ADDRGP4 $1773
JUMPV
LABELV $1772
line 3606
;3606:		else if (cgs.clientinfo[cent->currentState.number].team == TEAM_BLUE)
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1776
line 3607
;3607:		{
line 3608
;3608:			scolor = SABER_BLUE;
ADDRLP4 1560
CNSTI4 4
ASGNI4
line 3609
;3609:		}
LABELV $1776
LABELV $1773
line 3610
;3610:	}
LABELV $1769
line 3612
;3611:
;3612:	if (!cg_saberContact.integer)
ADDRGP4 cg_saberContact+12
INDIRI4
CNSTI4 0
NEI4 $1780
line 3613
;3613:	{ //if we don't have saber contact enabled, just add the blade and don't care what it's touching
line 3614
;3614:		goto CheckTrail;
ADDRGP4 $1783
JUMPV
LABELV $1780
line 3617
;3615:	}
;3616:
;3617:	for ( i = 0; i < 1; i++ )//was 2 because it would go through architecture and leave saber trails on either side of the brush - but still looks bad if we hit a corner, blade is still 8 longer than hit
ADDRLP4 1080
CNSTI4 0
ASGNI4
LABELV $1784
line 3618
;3618:	{
line 3619
;3619:		if ( i )
ADDRLP4 1080
INDIRI4
CNSTI4 0
EQI4 $1788
line 3620
;3620:		{//tracing from end to base
line 3621
;3621:			CG_Trace( &trace, end, NULL, NULL, org_, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 0
ARGP4
ADDRLP4 1112
ARGP4
ADDRLP4 1636
CNSTP4 0
ASGNP4
ADDRLP4 1636
INDIRP4
ARGP4
ADDRLP4 1636
INDIRP4
ARGP4
ADDRLP4 1088
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 3622
;3622:		}
ADDRGP4 $1789
JUMPV
LABELV $1788
line 3624
;3623:		else
;3624:		{//tracing from base to end
line 3625
;3625:			CG_Trace( &trace, org_, NULL, NULL, end, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 0
ARGP4
ADDRLP4 1088
ARGP4
ADDRLP4 1636
CNSTP4 0
ASGNP4
ADDRLP4 1636
INDIRP4
ARGP4
ADDRLP4 1636
INDIRP4
ARGP4
ADDRLP4 1112
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 3626
;3626:		}
LABELV $1789
line 3628
;3627:		
;3628:		if ( trace.fraction < 1.0f )
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $1790
line 3629
;3629:		{
line 3631
;3630:			vec3_t trDir;
;3631:			VectorCopy(trace.plane.normal, trDir);
ADDRLP4 1636
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3632
;3632:			if (!trDir[0] && !trDir[1] && !trDir[2])
ADDRLP4 1648
CNSTF4 0
ASGNF4
ADDRLP4 1636
INDIRF4
ADDRLP4 1648
INDIRF4
NEF4 $1794
ADDRLP4 1636+4
INDIRF4
ADDRLP4 1648
INDIRF4
NEF4 $1794
ADDRLP4 1636+8
INDIRF4
ADDRLP4 1648
INDIRF4
NEF4 $1794
line 3633
;3633:			{
line 3634
;3634:				trDir[1] = 1;
ADDRLP4 1636+4
CNSTF4 1065353216
ASGNF4
line 3635
;3635:			}
LABELV $1794
line 3636
;3636:			trap_FX_PlayEffectID( trap_FX_RegisterEffect("saber/spark.efx"), trace.endpos, trDir );
ADDRGP4 $1799
ARGP4
ADDRLP4 1652
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 1652
INDIRI4
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 1636
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 3639
;3637:
;3638:			//Stop saber? (it wouldn't look right if it was stuck through a thin wall and unable to hurt players on the other side)
;3639:			VectorSubtract(org_, trace.endpos, v);
ADDRLP4 1100
ADDRLP4 1088
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1100+4
ADDRLP4 1088+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1100+8
ADDRLP4 1088+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 3640
;3640:			saberLen = VectorLength(v);
ADDRLP4 1100
ARGP4
ADDRLP4 1656
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 1520
ADDRLP4 1656
INDIRF4
ASGNF4
line 3642
;3641:
;3642:			VectorCopy(trace.endpos, end);
ADDRLP4 1112
ADDRLP4 0+12
INDIRB
ASGNB 12
line 3644
;3643:
;3644:			if (cent->currentState.bolt2)
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1811
line 3645
;3645:			{
line 3646
;3646:				break;
ADDRGP4 $1786
JUMPV
LABELV $1811
line 3650
;3647:			}
;3648:			// All I need is a bool to mark whether I have a previous point to work with.
;3649:			//....come up with something better..
;3650:			if ( client->saberTrail.haveOldPos[i] )
ADDRLP4 1080
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1084
INDIRP4
CNSTI4 592
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1813
line 3651
;3651:			{
line 3652
;3652:				if ( trace.entityNum == ENTITYNUM_WORLD )
ADDRLP4 0+52
INDIRI4
CNSTI4 1022
NEI4 $1814
line 3653
;3653:				{//only put marks on architecture
line 3655
;3654:					// Let's do some cool burn/glowing mark bits!!!
;3655:					CG_CreateSaberMarks( client->saberTrail.oldPos[i], trace.endpos, trace.plane.normal );
CNSTI4 12
ADDRLP4 1080
INDIRI4
MULI4
ADDRLP4 1084
INDIRP4
CNSTI4 600
ADDP4
ADDP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 0+24
ARGP4
ADDRGP4 CG_CreateSaberMarks
CALLV
pop
line 3658
;3656:				
;3657:					//make a sound
;3658:					if ( cg.time - client->saberHitWallSoundDebounceTime >= 100 )
ADDRGP4 cg+64
INDIRI4
ADDRLP4 1084
INDIRP4
CNSTI4 648
ADDP4
INDIRI4
SUBI4
CNSTI4 100
LTI4 $1814
line 3659
;3659:					{//ugh, need to have a real sound debouncer... or do this game-side
line 3660
;3660:						client->saberHitWallSoundDebounceTime = cg.time;
ADDRLP4 1084
INDIRP4
CNSTI4 648
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3661
;3661:						trap_S_StartSound ( trace.endpos, -1, CHAN_WEAPON, trap_S_RegisterSound( va("sound/weapons/saber/saberhitwall%i", Q_irand(1, 3)) ) );
CNSTI4 1
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 1660
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRGP4 $1825
ARGP4
ADDRLP4 1660
INDIRI4
ARGI4
ADDRLP4 1664
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1664
INDIRP4
ARGP4
ADDRLP4 1668
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0+12
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 1668
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 3662
;3662:					}
line 3663
;3663:				}
line 3664
;3664:			}
ADDRGP4 $1814
JUMPV
LABELV $1813
line 3666
;3665:			else
;3666:			{
line 3668
;3667:				// if we impact next frame, we'll mark a slash mark
;3668:				client->saberTrail.haveOldPos[i] = qtrue;
ADDRLP4 1080
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1084
INDIRP4
CNSTI4 592
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 3671
;3669://				CG_ImpactMark( cgs.media.rivetMarkShader, client->saberTrail.oldPos[i], client->saberTrail.oldNormal[i],
;3670://						0.0f, 1.0f, 1.0f, 1.0f, 1.0f, qfalse, 1.1f, qfalse );
;3671:			}
LABELV $1814
line 3674
;3672:
;3673:			// stash point so we can connect-the-dots later
;3674:			VectorCopy( trace.endpos, client->saberTrail.oldPos[i] );
CNSTI4 12
ADDRLP4 1080
INDIRI4
MULI4
ADDRLP4 1084
INDIRP4
CNSTI4 600
ADDP4
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 3675
;3675:			VectorCopy( trace.plane.normal, client->saberTrail.oldNormal[i] );
CNSTI4 12
ADDRLP4 1080
INDIRI4
MULI4
ADDRLP4 1084
INDIRP4
CNSTI4 624
ADDP4
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3676
;3676:		}
ADDRGP4 $1791
JUMPV
LABELV $1790
line 3678
;3677:		else
;3678:		{
line 3679
;3679:			if (cent->currentState.bolt2)
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1828
line 3680
;3680:			{
line 3681
;3681:				break;
ADDRGP4 $1786
JUMPV
LABELV $1828
line 3684
;3682:			}
;3683:
;3684:			if ( client->saberTrail.haveOldPos[i] )
ADDRLP4 1080
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1084
INDIRP4
CNSTI4 592
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1830
line 3685
;3685:			{
line 3691
;3686:				// Hmmm, no impact this frame, but we have an old point
;3687:				// Let's put the mark there, we should use an endcap mark to close the line, but we 
;3688:				//	can probably just get away with a round mark
;3689://					CG_ImpactMark( cgs.media.rivetMarkShader, client->saberTrail.oldPos[i], client->saberTrail.oldNormal[i],
;3690://							0.0f, 1.0f, 1.0f, 1.0f, 1.0f, qfalse, 1.1f, qfalse );
;3691:			}
LABELV $1830
line 3694
;3692:
;3693:			// we aren't impacting, so turn off our mark tracking mechanism
;3694:			client->saberTrail.haveOldPos[i] = qfalse;
ADDRLP4 1080
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1084
INDIRP4
CNSTI4 592
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 3695
;3695:		}
LABELV $1791
line 3696
;3696:	}
LABELV $1785
line 3617
ADDRLP4 1080
ADDRLP4 1080
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 1
LTI4 $1784
LABELV $1786
line 3698
;3697:
;3698:	if (cent->currentState.bolt2)
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1832
line 3699
;3699:	{
line 3700
;3700:		for ( i = 0; i < 1; i++ )//was 2 because it would go through architecture and leave saber trails on either side of the brush - but still looks bad if we hit a corner, blade is still 8 longer than hit
ADDRLP4 1080
CNSTI4 0
ASGNI4
LABELV $1834
line 3701
;3701:		{
line 3702
;3702:			CG_Trace( &trace, otherPos, NULL, NULL, otherEnd, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 0
ARGP4
ADDRLP4 1124
ARGP4
ADDRLP4 1636
CNSTP4 0
ASGNP4
ADDRLP4 1636
INDIRP4
ARGP4
ADDRLP4 1636
INDIRP4
ARGP4
ADDRLP4 1524
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 3704
;3703:		
;3704:			if ( trace.fraction < 1.0f )
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $1838
line 3705
;3705:			{
line 3707
;3706:				vec3_t trDir;
;3707:				VectorCopy(trace.plane.normal, trDir);
ADDRLP4 1640
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3708
;3708:				if (!trDir[0] && !trDir[1] && !trDir[2])
ADDRLP4 1652
CNSTF4 0
ASGNF4
ADDRLP4 1640
INDIRF4
ADDRLP4 1652
INDIRF4
NEF4 $1842
ADDRLP4 1640+4
INDIRF4
ADDRLP4 1652
INDIRF4
NEF4 $1842
ADDRLP4 1640+8
INDIRF4
ADDRLP4 1652
INDIRF4
NEF4 $1842
line 3709
;3709:				{
line 3710
;3710:					trDir[1] = 1;
ADDRLP4 1640+4
CNSTF4 1065353216
ASGNF4
line 3711
;3711:				}
LABELV $1842
line 3713
;3712:
;3713:				trap_FX_PlayEffectID( trap_FX_RegisterEffect("saber/spark.efx"), trace.endpos, trDir );
ADDRGP4 $1799
ARGP4
ADDRLP4 1656
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 1656
INDIRI4
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 1640
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 3716
;3714:
;3715:				//Stop saber? (it wouldn't look right if it was stuck through a thin wall and unable to hurt players on the other side)
;3716:				VectorSubtract(otherPos, trace.endpos, v);
ADDRLP4 1100
ADDRLP4 1124
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1100+4
ADDRLP4 1124+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1100+8
ADDRLP4 1124+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 3717
;3717:				dualSaberLen = VectorLength(v);
ADDRLP4 1100
ARGP4
ADDRLP4 1660
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 1552
ADDRLP4 1660
INDIRF4
ASGNF4
line 3719
;3718:
;3719:				VectorCopy(trace.endpos, end);
ADDRLP4 1112
ADDRLP4 0+12
INDIRB
ASGNB 12
line 3720
;3720:			}
LABELV $1838
line 3721
;3721:		}
LABELV $1835
line 3700
ADDRLP4 1080
ADDRLP4 1080
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 1
LTI4 $1834
line 3722
;3722:	}
LABELV $1832
LABELV $1783
line 3725
;3723:CheckTrail:
;3724:
;3725:	if (!cg_saberTrail.integer)
ADDRGP4 cg_saberTrail+12
INDIRI4
CNSTI4 0
NEI4 $1858
line 3726
;3726:	{ //don't do the trail in this case
line 3727
;3727:		goto JustDoIt;
ADDRGP4 $1861
JUMPV
LABELV $1858
line 3730
;3728:	}
;3729:
;3730:	saberTrail = &client->saberTrail;
ADDRLP4 1536
ADDRLP4 1084
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
line 3734
;3731:
;3732:	// if we happen to be timescaled or running in a high framerate situation, we don't want to flood
;3733:	//	the system with very small trail slices...but perhaps doing it by distance would yield better results?
;3734:	if ( cg.time > saberTrail->lastTime + 2 ) // 2ms
ADDRGP4 cg+64
INDIRI4
ADDRLP4 1536
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
ADDI4
LEI4 $1862
line 3735
;3735:	{
line 3736
;3736:		if ( (saberMoveData[cent->currentState.saberMove].trailLength > 0 || ((cent->currentState.powerups & (1 << PW_SPEED) && cg_speedTrail.integer)) || cent->currentState.saberInFlight) && cg.time < saberTrail->lastTime + 2000 ) // if we have a stale segment, don't draw until we have a fresh one
ADDRLP4 1636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1640
CNSTI4 0
ASGNI4
CNSTI4 40
ADDRLP4 1636
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
MULI4
ADDRGP4 saberMoveData+36
ADDP4
INDIRI4
ADDRLP4 1640
INDIRI4
GTI4 $1871
ADDRLP4 1636
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
ADDRLP4 1640
INDIRI4
EQI4 $1872
ADDRGP4 cg_speedTrail+12
INDIRI4
ADDRLP4 1640
INDIRI4
NEI4 $1871
LABELV $1872
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1865
LABELV $1871
ADDRGP4 cg+64
INDIRI4
ADDRLP4 1536
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2000
ADDI4
GEI4 $1865
line 3737
;3737:		{
line 3738
;3738:			vec3_t	rgb1={255.0f,255.0f,255.0f};
ADDRLP4 1644
ADDRGP4 $1873
INDIRB
ASGNB 12
line 3740
;3739:
;3740:			switch( scolor )
ADDRLP4 1560
INDIRI4
CNSTI4 0
LTI4 $1874
ADDRLP4 1560
INDIRI4
CNSTI4 5
GTI4 $1874
ADDRLP4 1560
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1896
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1896
address $1876
address $1879
address $1882
address $1885
address $1888
address $1891
code
line 3741
;3741:			{
LABELV $1876
line 3743
;3742:				case SABER_RED:
;3743:					VectorSet( rgb1, 255.0f, 0.0f, 0.0f );
ADDRLP4 1644
CNSTF4 1132396544
ASGNF4
ADDRLP4 1644+4
CNSTF4 0
ASGNF4
ADDRLP4 1644+8
CNSTF4 0
ASGNF4
line 3744
;3744:					break;
ADDRGP4 $1875
JUMPV
LABELV $1879
line 3746
;3745:				case SABER_ORANGE:
;3746:					VectorSet( rgb1, 255.0f, 64.0f, 0.0f );
ADDRLP4 1644
CNSTF4 1132396544
ASGNF4
ADDRLP4 1644+4
CNSTF4 1115684864
ASGNF4
ADDRLP4 1644+8
CNSTF4 0
ASGNF4
line 3747
;3747:					break;
ADDRGP4 $1875
JUMPV
LABELV $1882
line 3749
;3748:				case SABER_YELLOW:
;3749:					VectorSet( rgb1, 255.0f, 255.0f, 0.0f );
ADDRLP4 1660
CNSTF4 1132396544
ASGNF4
ADDRLP4 1644
ADDRLP4 1660
INDIRF4
ASGNF4
ADDRLP4 1644+4
ADDRLP4 1660
INDIRF4
ASGNF4
ADDRLP4 1644+8
CNSTF4 0
ASGNF4
line 3750
;3750:					break;
ADDRGP4 $1875
JUMPV
LABELV $1885
line 3752
;3751:				case SABER_GREEN:
;3752:					VectorSet( rgb1, 0.0f, 255.0f, 0.0f );
ADDRLP4 1644
CNSTF4 0
ASGNF4
ADDRLP4 1644+4
CNSTF4 1132396544
ASGNF4
ADDRLP4 1644+8
CNSTF4 0
ASGNF4
line 3753
;3753:					break;
ADDRGP4 $1875
JUMPV
LABELV $1888
line 3755
;3754:				case SABER_BLUE:
;3755:					VectorSet( rgb1, 0.0f, 64.0f, 255.0f );
ADDRLP4 1644
CNSTF4 0
ASGNF4
ADDRLP4 1644+4
CNSTF4 1115684864
ASGNF4
ADDRLP4 1644+8
CNSTF4 1132396544
ASGNF4
line 3756
;3756:					break;
ADDRGP4 $1875
JUMPV
LABELV $1891
line 3758
;3757:				case SABER_PURPLE:
;3758:					VectorSet( rgb1, 220.0f, 0.0f, 255.0f );
ADDRLP4 1644
CNSTF4 1130102784
ASGNF4
ADDRLP4 1644+4
CNSTF4 0
ASGNF4
ADDRLP4 1644+8
CNSTF4 1132396544
ASGNF4
line 3759
;3759:					break;
ADDRGP4 $1875
JUMPV
LABELV $1874
line 3761
;3760:				default:
;3761:					VectorSet( rgb1, 0.0f, 64.0f, 255.0f );
ADDRLP4 1644
CNSTF4 0
ASGNF4
ADDRLP4 1644+4
CNSTF4 1115684864
ASGNF4
ADDRLP4 1644+8
CNSTF4 1132396544
ASGNF4
line 3762
;3762:					break;
LABELV $1875
line 3771
;3763:			}
;3764:
;3765:			//Here we will use the happy process of filling a struct in with arguments and passing it to a trap function
;3766:			//so that we can take the struct and fill in an actual CTrail type using the data within it once we get it
;3767:			//into the effects area
;3768:
;3769:			// Go from new muzzle to new end...then to old end...back down to old muzzle...finally
;3770:			//	connect back to the new muzzle...this is our trail quad
;3771:			VectorCopy( org_, fx.mVerts[0].origin );
ADDRLP4 1172
ADDRLP4 1088
INDIRB
ASGNB 12
line 3772
;3772:			VectorMA( end, 3.0f, axis_[0], fx.mVerts[1].origin );
ADDRLP4 1172+84
ADDRLP4 1112
INDIRF4
CNSTF4 1077936128
ADDRLP4 1136
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1172+84+4
ADDRLP4 1112+4
INDIRF4
CNSTF4 1077936128
ADDRLP4 1136+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1172+84+8
ADDRLP4 1112+8
INDIRF4
CNSTF4 1077936128
ADDRLP4 1136+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3774
;3773:
;3774:			VectorCopy( saberTrail->tip, fx.mVerts[2].origin );
ADDRLP4 1172+168
ADDRLP4 1536
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 3775
;3775:			VectorCopy( saberTrail->base, fx.mVerts[3].origin );
ADDRLP4 1172+252
ADDRLP4 1536
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 3777
;3776:
;3777:			diff = cg.time - saberTrail->lastTime;
ADDRLP4 1628
ADDRGP4 cg+64
INDIRI4
ADDRLP4 1536
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 3782
;3778:
;3779:			// I'm not sure that clipping this is really the best idea
;3780:			//This prevents the trail from showing at all in low framerate situations.
;3781:			//if ( diff <= SABER_TRAIL_TIME * 2 )
;3782:			{
line 3783
;3783:				float oldAlpha = 1.0f - ( diff / SABER_TRAIL_TIME );
ADDRLP4 1660
CNSTF4 1065353216
ADDRLP4 1628
INDIRF4
CNSTF4 1109393408
DIVF4
SUBF4
ASGNF4
line 3786
;3784:
;3785:				// New muzzle
;3786:				VectorCopy( rgb1, fx.mVerts[0].rgb );
ADDRLP4 1172+12
ADDRLP4 1644
INDIRB
ASGNB 12
line 3787
;3787:				fx.mVerts[0].alpha = 255.0f;
ADDRLP4 1172+48
CNSTF4 1132396544
ASGNF4
line 3789
;3788:
;3789:				fx.mVerts[0].ST[0] = 0.0f;
ADDRLP4 1172+60
CNSTF4 0
ASGNF4
line 3790
;3790:				fx.mVerts[0].ST[1] = 1.0f;
ADDRLP4 1172+60+4
CNSTF4 1065353216
ASGNF4
line 3791
;3791:				fx.mVerts[0].destST[0] = 1.0f;
ADDRLP4 1172+68
CNSTF4 1065353216
ASGNF4
line 3792
;3792:				fx.mVerts[0].destST[1] = 1.0f;
ADDRLP4 1172+68+4
CNSTF4 1065353216
ASGNF4
line 3795
;3793:
;3794:				// new tip
;3795:				VectorCopy( rgb1, fx.mVerts[1].rgb );
ADDRLP4 1172+84+12
ADDRLP4 1644
INDIRB
ASGNB 12
line 3796
;3796:				fx.mVerts[1].alpha = 255.0f;
ADDRLP4 1172+84+48
CNSTF4 1132396544
ASGNF4
line 3798
;3797:				
;3798:				fx.mVerts[1].ST[0] = 0.0f;
ADDRLP4 1172+84+60
CNSTF4 0
ASGNF4
line 3799
;3799:				fx.mVerts[1].ST[1] = 0.0f;
ADDRLP4 1172+84+60+4
CNSTF4 0
ASGNF4
line 3800
;3800:				fx.mVerts[1].destST[0] = 1.0f;
ADDRLP4 1172+84+68
CNSTF4 1065353216
ASGNF4
line 3801
;3801:				fx.mVerts[1].destST[1] = 0.0f;
ADDRLP4 1172+84+68+4
CNSTF4 0
ASGNF4
line 3804
;3802:
;3803:				// old tip
;3804:				VectorCopy( rgb1, fx.mVerts[2].rgb );
ADDRLP4 1172+168+12
ADDRLP4 1644
INDIRB
ASGNB 12
line 3805
;3805:				fx.mVerts[2].alpha = 255.0f;
ADDRLP4 1172+168+48
CNSTF4 1132396544
ASGNF4
line 3807
;3806:
;3807:				fx.mVerts[2].ST[0] = 1.0f - oldAlpha; // NOTE: this just happens to contain the value I want
ADDRLP4 1172+168+60
CNSTF4 1065353216
ADDRLP4 1660
INDIRF4
SUBF4
ASGNF4
line 3808
;3808:				fx.mVerts[2].ST[1] = 0.0f;
ADDRLP4 1172+168+60+4
CNSTF4 0
ASGNF4
line 3809
;3809:				fx.mVerts[2].destST[0] = 1.0f + fx.mVerts[2].ST[0];
ADDRLP4 1172+168+68
ADDRLP4 1172+168+60
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3810
;3810:				fx.mVerts[2].destST[1] = 0.0f;
ADDRLP4 1172+168+68+4
CNSTF4 0
ASGNF4
line 3813
;3811:
;3812:				// old muzzle
;3813:				VectorCopy( rgb1, fx.mVerts[3].rgb );
ADDRLP4 1172+252+12
ADDRLP4 1644
INDIRB
ASGNB 12
line 3814
;3814:				fx.mVerts[3].alpha = 255.0f;
ADDRLP4 1172+252+48
CNSTF4 1132396544
ASGNF4
line 3816
;3815:
;3816:				fx.mVerts[3].ST[0] = 1.0f - oldAlpha; // NOTE: this just happens to contain the value I want
ADDRLP4 1172+252+60
CNSTF4 1065353216
ADDRLP4 1660
INDIRF4
SUBF4
ASGNF4
line 3817
;3817:				fx.mVerts[3].ST[1] = 1.0f;
ADDRLP4 1172+252+60+4
CNSTF4 1065353216
ASGNF4
line 3818
;3818:				fx.mVerts[3].destST[0] = 1.0f + fx.mVerts[2].ST[0];
ADDRLP4 1172+252+68
ADDRLP4 1172+168+60
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3819
;3819:				fx.mVerts[3].destST[1] = 1.0f;
ADDRLP4 1172+252+68+4
CNSTF4 1065353216
ASGNF4
line 3821
;3820:		
;3821:				fx.mShader = cgs.media.saberBlurShader;
ADDRLP4 1172+336
ADDRGP4 cgs+70280+164
INDIRI4
ASGNI4
line 3822
;3822:				fx.mSetFlags = FX_USE_ALPHA;
ADDRLP4 1172+340
CNSTI4 134217728
ASGNI4
line 3823
;3823:				fx.mKillTime = SABER_TRAIL_TIME;
ADDRLP4 1172+344
CNSTI4 40
ASGNI4
line 3825
;3824:
;3825:				trap_FX_AddPrimitive(&fx);
ADDRLP4 1172
ARGP4
ADDRGP4 trap_FX_AddPrimitive
CALLV
pop
line 3826
;3826:			}
line 3828
;3827:
;3828:			if (cent->currentState.bolt2)
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1968
line 3829
;3829:			{
line 3830
;3830:				float oldAlpha = 1.0f - ( diff / SABER_TRAIL_TIME );
ADDRLP4 1660
CNSTF4 1065353216
ADDRLP4 1628
INDIRF4
CNSTF4 1109393408
DIVF4
SUBF4
ASGNF4
line 3832
;3831:
;3832:				VectorCopy( otherPos, fx.mVerts[0].origin );
ADDRLP4 1172
ADDRLP4 1124
INDIRB
ASGNB 12
line 3833
;3833:				VectorMA( otherEnd, 3.0f, otherDir, fx.mVerts[1].origin );
ADDRLP4 1172+84
ADDRLP4 1524
INDIRF4
CNSTF4 1077936128
ADDRLP4 1540
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1172+84+4
ADDRLP4 1524+4
INDIRF4
CNSTF4 1077936128
ADDRLP4 1540+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1172+84+8
ADDRLP4 1524+8
INDIRF4
CNSTF4 1077936128
ADDRLP4 1540+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3835
;3834:
;3835:				VectorCopy( saberTrail->dualtip, fx.mVerts[2].origin );
ADDRLP4 1172+168
ADDRLP4 1536
INDIRP4
CNSTI4 48
ADDP4
INDIRB
ASGNB 12
line 3836
;3836:				VectorCopy( saberTrail->dualbase, fx.mVerts[3].origin );
ADDRLP4 1172+252
ADDRLP4 1536
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 3839
;3837:
;3838:				// New muzzle
;3839:				VectorCopy( rgb1, fx.mVerts[0].rgb );
ADDRLP4 1172+12
ADDRLP4 1644
INDIRB
ASGNB 12
line 3840
;3840:				fx.mVerts[0].alpha = 255.0f;
ADDRLP4 1172+48
CNSTF4 1132396544
ASGNF4
line 3842
;3841:
;3842:				fx.mVerts[0].ST[0] = 0.0f;
ADDRLP4 1172+60
CNSTF4 0
ASGNF4
line 3843
;3843:				fx.mVerts[0].ST[1] = 1.0f;
ADDRLP4 1172+60+4
CNSTF4 1065353216
ASGNF4
line 3844
;3844:				fx.mVerts[0].destST[0] = 1.0f;
ADDRLP4 1172+68
CNSTF4 1065353216
ASGNF4
line 3845
;3845:				fx.mVerts[0].destST[1] = 1.0f;
ADDRLP4 1172+68+4
CNSTF4 1065353216
ASGNF4
line 3848
;3846:
;3847:				// new tip
;3848:				VectorCopy( rgb1, fx.mVerts[1].rgb );
ADDRLP4 1172+84+12
ADDRLP4 1644
INDIRB
ASGNB 12
line 3849
;3849:				fx.mVerts[1].alpha = 255.0f;
ADDRLP4 1172+84+48
CNSTF4 1132396544
ASGNF4
line 3851
;3850:				
;3851:				fx.mVerts[1].ST[0] = 0.0f;
ADDRLP4 1172+84+60
CNSTF4 0
ASGNF4
line 3852
;3852:				fx.mVerts[1].ST[1] = 0.0f;
ADDRLP4 1172+84+60+4
CNSTF4 0
ASGNF4
line 3853
;3853:				fx.mVerts[1].destST[0] = 1.0f;
ADDRLP4 1172+84+68
CNSTF4 1065353216
ASGNF4
line 3854
;3854:				fx.mVerts[1].destST[1] = 0.0f;
ADDRLP4 1172+84+68+4
CNSTF4 0
ASGNF4
line 3857
;3855:
;3856:				// old tip
;3857:				VectorCopy( rgb1, fx.mVerts[2].rgb );
ADDRLP4 1172+168+12
ADDRLP4 1644
INDIRB
ASGNB 12
line 3858
;3858:				fx.mVerts[2].alpha = 255.0f;
ADDRLP4 1172+168+48
CNSTF4 1132396544
ASGNF4
line 3860
;3859:
;3860:				fx.mVerts[2].ST[0] = 1.0f - oldAlpha; // NOTE: this just happens to contain the value I want
ADDRLP4 1172+168+60
CNSTF4 1065353216
ADDRLP4 1660
INDIRF4
SUBF4
ASGNF4
line 3861
;3861:				fx.mVerts[2].ST[1] = 0.0f;
ADDRLP4 1172+168+60+4
CNSTF4 0
ASGNF4
line 3862
;3862:				fx.mVerts[2].destST[0] = 1.0f + fx.mVerts[2].ST[0];
ADDRLP4 1172+168+68
ADDRLP4 1172+168+60
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3863
;3863:				fx.mVerts[2].destST[1] = 0.0f;
ADDRLP4 1172+168+68+4
CNSTF4 0
ASGNF4
line 3866
;3864:
;3865:				// old muzzle
;3866:				VectorCopy( rgb1, fx.mVerts[3].rgb );
ADDRLP4 1172+252+12
ADDRLP4 1644
INDIRB
ASGNB 12
line 3867
;3867:				fx.mVerts[3].alpha = 255.0f;
ADDRLP4 1172+252+48
CNSTF4 1132396544
ASGNF4
line 3869
;3868:
;3869:				fx.mVerts[3].ST[0] = 1.0f - oldAlpha; // NOTE: this just happens to contain the value I want
ADDRLP4 1172+252+60
CNSTF4 1065353216
ADDRLP4 1660
INDIRF4
SUBF4
ASGNF4
line 3870
;3870:				fx.mVerts[3].ST[1] = 1.0f;
ADDRLP4 1172+252+60+4
CNSTF4 1065353216
ASGNF4
line 3871
;3871:				fx.mVerts[3].destST[0] = 1.0f + fx.mVerts[2].ST[0];
ADDRLP4 1172+252+68
ADDRLP4 1172+168+60
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3872
;3872:				fx.mVerts[3].destST[1] = 1.0f;
ADDRLP4 1172+252+68+4
CNSTF4 1065353216
ASGNF4
line 3874
;3873:		
;3874:				fx.mShader = cgs.media.saberBlurShader;
ADDRLP4 1172+336
ADDRGP4 cgs+70280+164
INDIRI4
ASGNI4
line 3875
;3875:				fx.mSetFlags = FX_USE_ALPHA;
ADDRLP4 1172+340
CNSTI4 134217728
ASGNI4
line 3876
;3876:				fx.mKillTime = SABER_TRAIL_TIME;
ADDRLP4 1172+344
CNSTI4 40
ASGNI4
line 3878
;3877:
;3878:				trap_FX_AddPrimitive(&fx);
ADDRLP4 1172
ARGP4
ADDRGP4 trap_FX_AddPrimitive
CALLV
pop
line 3879
;3879:			}
LABELV $1968
line 3880
;3880:		}
LABELV $1865
line 3883
;3881:
;3882:		// we must always do this, even if we aren't active..otherwise we won't know where to pick up from
;3883:		VectorCopy( org_, saberTrail->base );
ADDRLP4 1536
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 1088
INDIRB
ASGNB 12
line 3884
;3884:		VectorMA( end, 3.0f, axis_[0], saberTrail->tip );
ADDRLP4 1536
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 1112
INDIRF4
CNSTF4 1077936128
ADDRLP4 1136
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1536
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 1112+4
INDIRF4
CNSTF4 1077936128
ADDRLP4 1136+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1536
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 1112+8
INDIRF4
CNSTF4 1077936128
ADDRLP4 1136+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3885
;3885:		saberTrail->lastTime = cg.time;
ADDRLP4 1536
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3887
;3886:
;3887:		if (cent->currentState.bolt2)
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2045
line 3888
;3888:		{
line 3889
;3889:			VectorCopy( otherPos, saberTrail->dualbase );
ADDRLP4 1536
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 1124
INDIRB
ASGNB 12
line 3890
;3890:			VectorMA( otherEnd, 3.0f, otherDir, saberTrail->dualtip );
ADDRLP4 1536
INDIRP4
CNSTI4 48
ADDP4
ADDRLP4 1524
INDIRF4
CNSTF4 1077936128
ADDRLP4 1540
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1536
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 1524+4
INDIRF4
CNSTF4 1077936128
ADDRLP4 1540+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1536
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 1524+8
INDIRF4
CNSTF4 1077936128
ADDRLP4 1540+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3891
;3891:		}
LABELV $2045
line 3892
;3892:	}
LABELV $1862
LABELV $1861
line 3896
;3893:
;3894:JustDoIt:
;3895:
;3896:	if (client && cent->currentState.bolt2)
ADDRLP4 1084
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2051
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2051
line 3897
;3897:	{
line 3898
;3898:		float sideOneLen = saberLen*dualLen;
ADDRLP4 1636
ADDRLP4 1520
INDIRF4
ADDRLP4 1556
INDIRF4
MULF4
ASGNF4
line 3899
;3899:		float sideTwoLen = dualSaberLen*dualLen;
ADDRLP4 1640
ADDRLP4 1552
INDIRF4
ADDRLP4 1556
INDIRF4
MULF4
ASGNF4
line 3901
;3900:
;3901:		if (sideOneLen < 1)
ADDRLP4 1636
INDIRF4
CNSTF4 1065353216
GEF4 $2053
line 3902
;3902:		{
line 3903
;3903:			sideOneLen = 1;
ADDRLP4 1636
CNSTF4 1065353216
ASGNF4
line 3904
;3904:		}
LABELV $2053
line 3906
;3905:		
;3906:		CG_DoSaber( org_, axis_[0], sideOneLen, scolor, renderfx );
ADDRLP4 1088
ARGP4
ADDRLP4 1136
ARGP4
ADDRLP4 1636
INDIRF4
ARGF4
ADDRLP4 1560
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DoSaber
CALLV
pop
line 3908
;3907:
;3908:		CG_DoSaber( otherPos, otherDir, sideTwoLen, scolor, renderfx );
ADDRLP4 1124
ARGP4
ADDRLP4 1540
ARGP4
ADDRLP4 1640
INDIRF4
ARGF4
ADDRLP4 1560
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DoSaber
CALLV
pop
line 3909
;3909:	}
ADDRGP4 $2052
JUMPV
LABELV $2051
line 3911
;3910:	else
;3911:	{
line 3914
;3912:		// Pass in the renderfx flags attached to the saber weapon model...this is done so that saber glows
;3913:		//	will get rendered properly in a mirror...not sure if this is necessary??
;3914:		CG_DoSaber( org_, axis_[0], saberLen, scolor, renderfx );
ADDRLP4 1088
ARGP4
ADDRLP4 1136
ARGP4
ADDRLP4 1520
INDIRF4
ARGF4
ADDRLP4 1560
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DoSaber
CALLV
pop
line 3915
;3915:	}
LABELV $2052
line 3916
;3916:}
LABELV $1692
endproc CG_AddSaberBlade 1672 36
export CG_IsMindTricked
proc CG_IsMindTricked 8 0
line 3919
;3917:
;3918:int CG_IsMindTricked(int trickIndex1, int trickIndex2, int trickIndex3, int trickIndex4, int client)
;3919:{
line 3921
;3920:	int checkIn;
;3921:	int sub = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3923
;3922:
;3923:	if (cg_entities[client].currentState.forcePowersActive & (1 << FP_SEE))
CNSTI4 1920
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cg_entities+240
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $2056
line 3924
;3924:	{
line 3925
;3925:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2055
JUMPV
LABELV $2056
line 3928
;3926:	}
;3927:
;3928:	if (client > 47)
ADDRFP4 16
INDIRI4
CNSTI4 47
LEI4 $2059
line 3929
;3929:	{
line 3930
;3930:		checkIn = trickIndex4;
ADDRLP4 4
ADDRFP4 12
INDIRI4
ASGNI4
line 3931
;3931:		sub = 48;
ADDRLP4 0
CNSTI4 48
ASGNI4
line 3932
;3932:	}
ADDRGP4 $2060
JUMPV
LABELV $2059
line 3933
;3933:	else if (client > 31)
ADDRFP4 16
INDIRI4
CNSTI4 31
LEI4 $2061
line 3934
;3934:	{
line 3935
;3935:		checkIn = trickIndex3;
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
line 3936
;3936:		sub = 32;
ADDRLP4 0
CNSTI4 32
ASGNI4
line 3937
;3937:	}
ADDRGP4 $2062
JUMPV
LABELV $2061
line 3938
;3938:	else if (client > 15)
ADDRFP4 16
INDIRI4
CNSTI4 15
LEI4 $2063
line 3939
;3939:	{
line 3940
;3940:		checkIn = trickIndex2;
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
line 3941
;3941:		sub = 16;
ADDRLP4 0
CNSTI4 16
ASGNI4
line 3942
;3942:	}
ADDRGP4 $2064
JUMPV
LABELV $2063
line 3944
;3943:	else
;3944:	{
line 3945
;3945:		checkIn = trickIndex1;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
line 3946
;3946:	}
LABELV $2064
LABELV $2062
LABELV $2060
line 3948
;3947:
;3948:	if (checkIn & (1 << (client-sub)))
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDRFP4 16
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2065
line 3949
;3949:	{
line 3950
;3950:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2055
JUMPV
LABELV $2065
line 3953
;3951:	}
;3952:	
;3953:	return 0;
CNSTI4 0
RETI4
LABELV $2055
endproc CG_IsMindTricked 8 0
export CG_DrawPlayerSphere
proc CG_DrawPlayerSphere 216 12
line 3959
;3954:}
;3955:
;3956:#define SPEED_TRAIL_DISTANCE 6
;3957:
;3958:void CG_DrawPlayerSphere(centity_t *cent, vec3_t origin, float scale, int shader)
;3959:{
line 3963
;3960:	refEntity_t ent;
;3961:	
;3962:	// Don't draw the shield when the player is dead.
;3963:	if (cent->currentState.eFlags & EF_DEAD)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2068
line 3964
;3964:	{
line 3965
;3965:		return;
ADDRGP4 $2067
JUMPV
LABELV $2068
line 3968
;3966:	}
;3967:
;3968:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3970
;3969:
;3970:	VectorCopy( origin, ent.origin );
ADDRLP4 0+52
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 3971
;3971:	ent.origin[2] += 9.0;
ADDRLP4 0+52+8
ADDRLP4 0+52+8
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 3973
;3972:
;3973:	VectorSubtract(cg.refdef.vieworg, ent.origin, ent.axis[0]);
ADDRLP4 0+12
ADDRGP4 cg+3604+24
INDIRF4
ADDRLP4 0+52
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+12+4
ADDRGP4 cg+3604+24+4
INDIRF4
ADDRLP4 0+52+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+12+8
ADDRGP4 cg+3604+24+8
INDIRF4
ADDRLP4 0+52+8
INDIRF4
SUBF4
ASGNF4
line 3974
;3974:	if (VectorNormalize(ent.axis[0]) <= 0.1f)
ADDRLP4 0+12
ARGP4
ADDRLP4 212
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 212
INDIRF4
CNSTF4 1036831949
GTF4 $2091
line 3975
;3975:	{	// Entity is right on vieworg.  quit.
line 3976
;3976:		return;
ADDRGP4 $2067
JUMPV
LABELV $2091
line 3979
;3977:	}
;3978:
;3979:	VectorCopy(cg.refdef.viewaxis[2], ent.axis[2]);
ADDRLP4 0+12+24
ADDRGP4 cg+3604+36+24
INDIRB
ASGNB 12
line 3980
;3980:	CrossProduct(ent.axis[0], ent.axis[2], ent.axis[1]);
ADDRLP4 0+12
ARGP4
ADDRLP4 0+12+24
ARGP4
ADDRLP4 0+12+12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 3982
;3981:
;3982:	VectorScale(ent.axis[0], scale, ent.axis[0]);
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+4
ADDRLP4 0+12+4
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+8
ADDRLP4 0+12+8
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ASGNF4
line 3983
;3983:	VectorScale(ent.axis[1], scale, ent.axis[1]);
ADDRLP4 0+12+12
ADDRLP4 0+12+12
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+12+4
ADDRLP4 0+12+12+4
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+12+12+8
ADDRLP4 0+12+12+8
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ASGNF4
line 3984
;3984:	VectorScale(ent.axis[2], -scale, ent.axis[2]);
ADDRLP4 0+12+24
ADDRLP4 0+12+24
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
MULF4
ASGNF4
ADDRLP4 0+12+24+4
ADDRLP4 0+12+24+4
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
MULF4
ASGNF4
ADDRLP4 0+12+24+8
ADDRLP4 0+12+24+8
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
MULF4
ASGNF4
line 3986
;3985:
;3986:	ent.hModel = cgs.media.halfShieldModel;
ADDRLP4 0+8
ADDRGP4 cgs+70280+912
INDIRI4
ASGNI4
line 3987
;3987:	ent.customShader = shader;	
ADDRLP4 0+76
ADDRFP4 12
INDIRI4
ASGNI4
line 3989
;3988:
;3989:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3990
;3990:}
LABELV $2067
endproc CG_DrawPlayerSphere 216 12
export CG_AddLightningBeam
proc CG_AddLightningBeam 276 4
line 3993
;3991:
;3992:void CG_AddLightningBeam(vec3_t start, vec3_t end)
;3993:{
line 4002
;3994:	vec3_t	dir, chaos,
;3995:			c1, c2,
;3996:			v1, v2;
;3997:	float	len,
;3998:			s1, s2, s3;
;3999:
;4000:	addbezierArgStruct_t b;
;4001:
;4002:	VectorCopy(start, b.start);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 4003
;4003:	VectorCopy(end, b.end);
ADDRLP4 0+12
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 4005
;4004:
;4005:	VectorSubtract( b.end, b.start, dir );
ADDRLP4 152
ADDRLP4 0+12
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 152+4
ADDRLP4 0+12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 152+8
ADDRLP4 0+12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 4006
;4006:	len = VectorNormalize( dir );
ADDRLP4 152
ARGP4
ADDRLP4 224
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 148
ADDRLP4 224
INDIRF4
ASGNF4
line 4009
;4007:
;4008:	// Get the base control points, we'll work from there
;4009:	VectorMA( b.start, 0.3333f * len, dir, c1 );
ADDRLP4 228
CNSTF4 1051371084
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 164
ADDRLP4 0
INDIRF4
ADDRLP4 152
INDIRF4
ADDRLP4 228
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 164+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 152+4
INDIRF4
ADDRLP4 228
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 164+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 152+8
INDIRF4
CNSTF4 1051371084
ADDRLP4 148
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 4010
;4010:	VectorMA( b.start, 0.6666f * len, dir, c2 );
ADDRLP4 232
CNSTF4 1059759692
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 176
ADDRLP4 0
INDIRF4
ADDRLP4 152
INDIRF4
ADDRLP4 232
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 176+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 152+4
INDIRF4
ADDRLP4 232
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 176+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 152+8
INDIRF4
CNSTF4 1059759692
ADDRLP4 148
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 4013
;4011:
;4012:	// get some chaos values that really aren't very chaotic :)
;4013:	s1 = sin( cg.time * 0.005f ) * 2 + crandom() * 0.2f;
CNSTF4 1000593162
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 236
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 240
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 188
CNSTF4 1073741824
ADDRLP4 236
INDIRF4
MULF4
CNSTF4 1045220557
CNSTF4 1073741824
ADDRLP4 240
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
ASGNF4
line 4014
;4014:	s2 = sin( cg.time * 0.001f );
CNSTF4 981668463
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 244
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 192
ADDRLP4 244
INDIRF4
ASGNF4
line 4015
;4015:	s3 = sin( cg.time * 0.011f );
CNSTF4 1010055512
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 248
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 196
ADDRLP4 248
INDIRF4
ASGNF4
line 4017
;4016:
;4017:	VectorSet( chaos, len * 0.01f * s1,
ADDRLP4 136
CNSTF4 1008981770
ADDRLP4 148
INDIRF4
MULF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 136+4
CNSTF4 1017370378
ADDRLP4 148
INDIRF4
MULF4
ADDRLP4 192
INDIRF4
MULF4
ASGNF4
ADDRLP4 136+8
CNSTF4 1025758986
ADDRLP4 148
INDIRF4
MULF4
ADDRLP4 188
INDIRF4
ADDRLP4 192
INDIRF4
ADDF4
ADDRLP4 196
INDIRF4
ADDF4
MULF4
ASGNF4
line 4021
;4018:						len * 0.02f * s2,
;4019:						len * 0.04f * (s1 + s2 + s3));
;4020:
;4021:	VectorAdd( c1, chaos, c1 );
ADDRLP4 164
ADDRLP4 164
INDIRF4
ADDRLP4 136
INDIRF4
ADDF4
ASGNF4
ADDRLP4 164+4
ADDRLP4 164+4
INDIRF4
ADDRLP4 136+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
ADDRLP4 136+8
INDIRF4
ADDF4
ASGNF4
line 4022
;4022:	VectorScale( chaos, 4.0f, v1 );
ADDRLP4 256
CNSTF4 1082130432
ASGNF4
ADDRLP4 200
ADDRLP4 256
INDIRF4
ADDRLP4 136
INDIRF4
MULF4
ASGNF4
ADDRLP4 200+4
ADDRLP4 256
INDIRF4
ADDRLP4 136+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 200+8
CNSTF4 1082130432
ADDRLP4 136+8
INDIRF4
MULF4
ASGNF4
line 4024
;4023:
;4024:	VectorSet( chaos, -len * 0.02f * s3,
ADDRLP4 136
CNSTF4 1017370378
ADDRLP4 148
INDIRF4
NEGF4
MULF4
ADDRLP4 196
INDIRF4
MULF4
ASGNF4
ADDRLP4 136+4
CNSTF4 1008981770
ADDRLP4 148
INDIRF4
MULF4
ADDRLP4 188
INDIRF4
ADDRLP4 192
INDIRF4
MULF4
MULF4
ASGNF4
ADDRLP4 136+8
CNSTF4 1017370378
ADDRLP4 148
INDIRF4
NEGF4
MULF4
ADDRLP4 188
INDIRF4
ADDRLP4 192
INDIRF4
ADDRLP4 196
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 4028
;4025:						len * 0.01f * (s1 * s2),
;4026:						-len * 0.02f * (s1 + s2 * s3));
;4027:
;4028:	VectorAdd( c2, chaos, c2 );
ADDRLP4 176
ADDRLP4 176
INDIRF4
ADDRLP4 136
INDIRF4
ADDF4
ASGNF4
ADDRLP4 176+4
ADDRLP4 176+4
INDIRF4
ADDRLP4 136+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 176+8
ADDRLP4 176+8
INDIRF4
ADDRLP4 136+8
INDIRF4
ADDF4
ASGNF4
line 4029
;4029:	VectorScale( chaos, 2.0f, v2 );
ADDRLP4 264
CNSTF4 1073741824
ASGNF4
ADDRLP4 212
ADDRLP4 264
INDIRF4
ADDRLP4 136
INDIRF4
MULF4
ASGNF4
ADDRLP4 212+4
ADDRLP4 264
INDIRF4
ADDRLP4 136+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 212+8
CNSTF4 1073741824
ADDRLP4 136+8
INDIRF4
MULF4
ASGNF4
line 4031
;4030:
;4031:	VectorSet( chaos, 1.0f, 1.0f, 1.0f );
ADDRLP4 268
CNSTF4 1065353216
ASGNF4
ADDRLP4 136
ADDRLP4 268
INDIRF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 268
INDIRF4
ASGNF4
ADDRLP4 136+8
CNSTF4 1065353216
ASGNF4
line 4033
;4032:
;4033:	VectorCopy(c1, b.control1);
ADDRLP4 0+24
ADDRLP4 164
INDIRB
ASGNB 12
line 4034
;4034:	VectorCopy(vec3_origin, b.control1Vel);
ADDRLP4 0+36
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 4035
;4035:	VectorCopy(c2, b.control2);
ADDRLP4 0+48
ADDRLP4 176
INDIRB
ASGNB 12
line 4036
;4036:	VectorCopy(vec3_origin, b.control2Vel);
ADDRLP4 0+60
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 4038
;4037:
;4038:	b.size1 = 6.0f;
ADDRLP4 0+72
CNSTF4 1086324736
ASGNF4
line 4039
;4039:	b.size2 = 6.0f;
ADDRLP4 0+76
CNSTF4 1086324736
ASGNF4
line 4040
;4040:	b.sizeParm = 0.0f;
ADDRLP4 0+80
CNSTF4 0
ASGNF4
line 4041
;4041:	b.alpha1 = 0.0f;
ADDRLP4 0+84
CNSTF4 0
ASGNF4
line 4042
;4042:	b.alpha2 = 0.2f;
ADDRLP4 0+88
CNSTF4 1045220557
ASGNF4
line 4043
;4043:	b.alphaParm = 0.5f;
ADDRLP4 0+92
CNSTF4 1056964608
ASGNF4
line 4050
;4044:	
;4045:	/*
;4046:	VectorCopy(WHITE, b.sRGB);
;4047:	VectorCopy(WHITE, b.eRGB);
;4048:	*/
;4049:
;4050:	b.sRGB[0] = 255;
ADDRLP4 0+96
CNSTF4 1132396544
ASGNF4
line 4051
;4051:	b.sRGB[1] = 255;
ADDRLP4 0+96+4
CNSTF4 1132396544
ASGNF4
line 4052
;4052:	b.sRGB[2] = 255;
ADDRLP4 0+96+8
CNSTF4 1132396544
ASGNF4
line 4053
;4053:	VectorCopy(b.sRGB, b.eRGB);
ADDRLP4 0+108
ADDRLP4 0+96
INDIRB
ASGNB 12
line 4055
;4054:
;4055:	b.rgbParm = 0.0f;
ADDRLP4 0+120
CNSTF4 0
ASGNF4
line 4056
;4056:	b.killTime = 50;
ADDRLP4 0+124
CNSTI4 50
ASGNI4
line 4057
;4057:	b.shader = trap_R_RegisterShader( "gfx/misc/electric2" );
ADDRGP4 $2222
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0+128
ADDRLP4 272
INDIRI4
ASGNI4
line 4058
;4058:	b.flags = 0x00000001; //FX_ALPHA_LINEAR
ADDRLP4 0+132
CNSTI4 1
ASGNI4
line 4060
;4059:
;4060:	trap_FX_AddBezier(&b);
ADDRLP4 0
ARGP4
ADDRGP4 trap_FX_AddBezier
CALLV
pop
line 4061
;4061:}
LABELV $2150
endproc CG_AddLightningBeam 276 4
export CG_AddRandomLightning
proc CG_AddRandomLightning 44 8
line 4064
;4062:
;4063:void CG_AddRandomLightning(vec3_t start, vec3_t end)
;4064:{
line 4067
;4065:	vec3_t inOrg, outOrg;
;4066:
;4067:	VectorCopy(start, inOrg);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 4068
;4068:	VectorCopy(end, outOrg);
ADDRLP4 12
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 4070
;4069:
;4070:	if ( rand() & 1 )
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2225
line 4071
;4071:	{
line 4072
;4072:		outOrg[0] += Q_irand(0, 24);
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 28
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 4073
;4073:		inOrg[0] += Q_irand(0, 8);
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
ADDRLP4 32
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 4074
;4074:	}
ADDRGP4 $2226
JUMPV
LABELV $2225
line 4076
;4075:	else
;4076:	{
line 4077
;4077:		outOrg[0] -= Q_irand(0, 24);
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 28
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 4078
;4078:		inOrg[0] -= Q_irand(0, 8);
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
ADDRLP4 32
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 4079
;4079:	}
LABELV $2226
line 4081
;4080:
;4081:	if ( rand() & 1 )
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2227
line 4082
;4082:	{
line 4083
;4083:		outOrg[1] += Q_irand(0, 24);
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 32
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 32
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 4084
;4084:		inOrg[1] += Q_irand(0, 8);
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
ADDRLP4 36
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 4085
;4085:	}
ADDRGP4 $2228
JUMPV
LABELV $2227
line 4087
;4086:	else
;4087:	{
line 4088
;4088:		outOrg[1] -= Q_irand(0, 24);
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 32
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 32
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 4089
;4089:		inOrg[1] -= Q_irand(0, 8);
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
ADDRLP4 36
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 4090
;4090:	}
LABELV $2228
line 4092
;4091:
;4092:	if ( rand() & 1 )
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2233
line 4093
;4093:	{
line 4094
;4094:		outOrg[2] += Q_irand(0, 50);
CNSTI4 0
ARGI4
CNSTI4 50
ARGI4
ADDRLP4 36
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 36
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 4095
;4095:		inOrg[2] += Q_irand(0, 40);
CNSTI4 0
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 40
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 40
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 4096
;4096:	}
ADDRGP4 $2234
JUMPV
LABELV $2233
line 4098
;4097:	else
;4098:	{
line 4099
;4099:		outOrg[2] -= Q_irand(0, 64);
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRLP4 36
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 36
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 4100
;4100:		inOrg[2] -= Q_irand(0, 40);
CNSTI4 0
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 40
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 40
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 4101
;4101:	}
LABELV $2234
line 4103
;4102:
;4103:	CG_AddLightningBeam(inOrg, outOrg);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CG_AddLightningBeam
CALLV
pop
line 4104
;4104:}
LABELV $2224
endproc CG_AddRandomLightning 44 8
export CG_ThereIsAMaster
proc CG_ThereIsAMaster 12 0
line 4109
;4105:
;4106:extern char *forceHolocronModels[];
;4107:
;4108:qboolean CG_ThereIsAMaster(void)
;4109:{
line 4110
;4110:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2241
JUMPV
LABELV $2240
line 4114
;4111:	centity_t *cent;
;4112:
;4113:	while (i < MAX_CLIENTS)
;4114:	{
line 4115
;4115:		cent = &cg_entities[i];
ADDRLP4 4
CNSTI4 1920
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 4117
;4116:
;4117:		if (cent && cent->currentState.isJediMaster)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2243
ADDRLP4 4
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2243
line 4118
;4118:		{
line 4119
;4119:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2239
JUMPV
LABELV $2243
line 4122
;4120:		}
;4121:
;4122:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4123
;4123:	}
LABELV $2241
line 4113
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $2240
line 4125
;4124:
;4125:	return qfalse;
CNSTI4 0
RETI4
LABELV $2239
endproc CG_ThereIsAMaster 12 0
export CG_Player
proc CG_Player 1356 44
line 4133
;4126:}
;4127:
;4128:/*
;4129:===============
;4130:CG_Player
;4131:===============
;4132:*/
;4133:void CG_Player( centity_t *cent ) {
line 4139
;4134:	clientInfo_t	*ci;
;4135:	refEntity_t		legs;
;4136:	refEntity_t		torso;
;4137:	int				clientNum;
;4138:	int				renderfx;
;4139:	qboolean		shadow = qfalse;
ADDRLP4 832
CNSTI4 0
ASGNI4
line 4140
;4140:	float			shadowPlane = 0;
ADDRLP4 536
CNSTF4 0
ASGNF4
line 4141
;4141:	qboolean		dead = qfalse;
ADDRLP4 864
CNSTI4 0
ASGNI4
line 4146
;4142:	vec3_t			rootAngles;
;4143:	refEntity_t		seeker;
;4144:	float			angle;
;4145:	vec3_t			angles, dir, elevated, enang, seekorg;
;4146:	int				iwantout = 0, successchange = 0;
ADDRLP4 768
CNSTI4 0
ASGNI4
ADDRLP4 860
CNSTI4 0
ASGNI4
line 4148
;4147:	int				team;
;4148:	float			prefig = 0;
ADDRLP4 844
CNSTF4 0
ASGNF4
line 4154
;4149:	centity_t		*enent;
;4150:	mdxaBone_t 		boltMatrix, lHandMatrix;
;4151:	vec3_t			efOrg;
;4152:	vec3_t			tDir;
;4153:	int				distVelBase;
;4154:	int				doAlpha = 0;
ADDRLP4 828
CNSTI4 0
ASGNI4
line 4155
;4155:	int				effectTimeLayer = 0;
ADDRLP4 756
CNSTI4 0
ASGNI4
line 4156
;4156:	qboolean		gotLHandMatrix = qfalse;
ADDRLP4 772
CNSTI4 0
ASGNI4
line 4157
;4157:	qboolean		g2HasWeapon = qfalse;
ADDRLP4 752
CNSTI4 0
ASGNI4
line 4159
;4158:
;4159:	if (cgQueueLoad)
ADDRGP4 cgQueueLoad
INDIRI4
CNSTI4 0
EQI4 $2246
line 4160
;4160:	{
line 4161
;4161:		CG_ActualLoadDeferredPlayers();
ADDRGP4 CG_ActualLoadDeferredPlayers
CALLV
pop
line 4162
;4162:		cgQueueLoad = qfalse;
ADDRGP4 cgQueueLoad
CNSTI4 0
ASGNI4
line 4163
;4163:	}
LABELV $2246
line 4168
;4164:
;4165:	// the client number is stored in clientNum.  It can't be derived
;4166:	// from the entity number, because a single client may have
;4167:	// multiple corpses on the level using the same clientinfo
;4168:	clientNum = cent->currentState.clientNum;
ADDRLP4 760
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ASGNI4
line 4169
;4169:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 760
INDIRI4
CNSTI4 0
LTI4 $2250
ADDRLP4 760
INDIRI4
CNSTI4 32
LTI4 $2248
LABELV $2250
line 4170
;4170:		CG_Error( "Bad clientNum on player entity");
ADDRGP4 $2251
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 4171
;4171:	}
LABELV $2248
line 4172
;4172:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 836
CNSTI4 788
ADDRLP4 760
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 4176
;4173:
;4174:	// it is possible to see corpses from disconnected players that may
;4175:	// not have valid clientinfo
;4176:	if ( !ci->infoValid ) {
ADDRLP4 836
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2253
line 4177
;4177:		return;
ADDRGP4 $2245
JUMPV
LABELV $2253
line 4180
;4178:	}
;4179:
;4180:	cent->ghoul2 = cg_entities[cent->currentState.number].ghoul2;
ADDRLP4 900
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 900
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 1920
ADDRLP4 900
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
ASGNP4
line 4182
;4181:
;4182:	if (!cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2256
line 4183
;4183:	{ //not ready yet?
line 4187
;4184:#ifdef _DEBUG
;4185:		Com_Printf("WARNING: Client %i has a null ghoul2 instance\n", cent->currentState.number);
;4186:#endif
;4187:		if (cgs.clientinfo[cent->currentState.number].ghoul2Model &&
ADDRLP4 904
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ASGNI4
ADDRLP4 904
INDIRI4
ADDRGP4 cgs+43008+504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2245
ADDRLP4 904
INDIRI4
ADDRGP4 cgs+43008+504
ADDP4
INDIRP4
ARGP4
ADDRLP4 908
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 908
INDIRI4
CNSTI4 0
EQI4 $2245
line 4189
;4188:			trap_G2_HaveWeGhoul2Models(cgs.clientinfo[cent->currentState.number].ghoul2Model))
;4189:		{
line 4193
;4190:#ifdef _DEBUG
;4191:			Com_Printf("Clientinfo instance was valid, duplicating for cent\n");
;4192:#endif
;4193:			trap_G2API_DuplicateGhoul2Instance(cgs.clientinfo[cent->currentState.number].ghoul2Model, &cent->ghoul2);
ADDRLP4 912
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 788
ADDRLP4 912
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+504
ADDP4
INDIRP4
ARGP4
ADDRLP4 912
INDIRP4
CNSTI4 952
ADDP4
ARGP4
ADDRGP4 trap_G2API_DuplicateGhoul2Instance
CALLV
pop
line 4194
;4194:			cg_entities[cent->currentState.number].ghoul2 = cent->ghoul2;
ADDRLP4 916
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 916
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
ADDRLP4 916
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ASGNP4
line 4195
;4195:		}
line 4196
;4196:		return;
ADDRGP4 $2245
JUMPV
LABELV $2256
line 4199
;4197:	}
;4198:
;4199:	g2HasWeapon = trap_G2API_HasGhoul2ModelOnIndex(&(cent->ghoul2), 1);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 904
ADDRGP4 trap_G2API_HasGhoul2ModelOnIndex
CALLI4
ASGNI4
ADDRLP4 752
ADDRLP4 904
INDIRI4
ASGNI4
line 4201
;4200:
;4201:	if (!g2HasWeapon)
ADDRLP4 752
INDIRI4
CNSTI4 0
NEI4 $2267
line 4202
;4202:	{ //force a redup of the weapon instance onto the client instance
line 4203
;4203:		cent->ghoul2weapon = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
CNSTP4 0
ASGNP4
line 4204
;4204:	}
LABELV $2267
line 4206
;4205:
;4206:	if (cent->torsoBolt && !(cent->currentState.eFlags & EF_DEAD))
ADDRLP4 908
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 912
CNSTI4 0
ASGNI4
ADDRLP4 908
INDIRP4
CNSTI4 1012
ADDP4
INDIRI4
ADDRLP4 912
INDIRI4
EQI4 $2269
ADDRLP4 908
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 912
INDIRI4
NEI4 $2269
line 4207
;4207:	{ //he's alive and has a limb missing still, reattach it and reset the weapon
line 4208
;4208:		CG_ReattachLimb(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ReattachLimb
CALLV
pop
line 4209
;4209:	}
LABELV $2269
line 4211
;4210:
;4211:	if (cent->currentState.teamowner && !cent->isATST)
ADDRLP4 916
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 920
CNSTI4 0
ASGNI4
ADDRLP4 916
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRLP4 920
INDIRI4
EQI4 $2271
ADDRLP4 916
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ADDRLP4 920
INDIRI4
NEI4 $2271
line 4212
;4212:	{
line 4213
;4213:		cg_entities[cent->currentState.number].currentState.teamowner = cent->currentState.teamowner;
ADDRLP4 924
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 924
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+264
ADDP4
ADDRLP4 924
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
line 4214
;4214:		cg_entities[cent->currentState.number].isATST = cent->isATST;
ADDRLP4 928
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 928
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+1028
ADDP4
ADDRLP4 928
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ASGNI4
line 4216
;4215:
;4216:		if (CG_RegisterClientModelname(&cgs.clientinfo[cent->currentState.number], cgs.clientinfo[cent->currentState.number].modelName, cgs.clientinfo[cent->currentState.number].skinName,
ADDRLP4 932
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 936
CNSTI4 788
ADDRLP4 932
INDIRI4
MULI4
ASGNI4
ADDRLP4 936
INDIRI4
ADDRGP4 cgs+43008
ADDP4
ARGP4
ADDRLP4 936
INDIRI4
ADDRGP4 cgs+43008+160
ADDP4
ARGP4
ADDRLP4 936
INDIRI4
ADDRGP4 cgs+43008+224
ADDP4
ARGP4
ADDRLP4 936
INDIRI4
ADDRGP4 cgs+43008+416
ADDP4
ARGP4
ADDRLP4 932
INDIRI4
ARGI4
ADDRLP4 940
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 940
INDIRI4
CNSTI4 0
EQI4 $2272
line 4218
;4217:			cgs.clientinfo[cent->currentState.number].teamName, cent->currentState.number))
;4218:		{
line 4219
;4219:			cent->isATST = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
CNSTI4 1
ASGNI4
line 4220
;4220:			cg_entities[cent->currentState.number].isATST = cent->isATST;
ADDRLP4 944
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 944
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+1028
ADDP4
ADDRLP4 944
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ASGNI4
line 4221
;4221:			return;
ADDRGP4 $2245
JUMPV
line 4223
;4222:		}
;4223:	}
LABELV $2271
line 4224
;4224:	else if (!cent->currentState.teamowner && cent->isATST)
ADDRLP4 924
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 928
CNSTI4 0
ASGNI4
ADDRLP4 924
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRLP4 928
INDIRI4
NEI4 $2285
ADDRLP4 924
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ADDRLP4 928
INDIRI4
EQI4 $2285
line 4225
;4225:	{
line 4226
;4226:		cg_entities[cent->currentState.number].currentState.teamowner = cent->currentState.teamowner;
ADDRLP4 932
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 932
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+264
ADDP4
ADDRLP4 932
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
line 4227
;4227:		cg_entities[cent->currentState.number].isATST = cent->isATST;
ADDRLP4 936
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 936
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+1028
ADDP4
ADDRLP4 936
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ASGNI4
line 4229
;4228:
;4229:		if (CG_RegisterClientModelname(&cgs.clientinfo[cent->currentState.number], cgs.clientinfo[cent->currentState.number].modelName, cgs.clientinfo[cent->currentState.number].skinName,
ADDRLP4 940
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 944
CNSTI4 788
ADDRLP4 940
INDIRI4
MULI4
ASGNI4
ADDRLP4 944
INDIRI4
ADDRGP4 cgs+43008
ADDP4
ARGP4
ADDRLP4 944
INDIRI4
ADDRGP4 cgs+43008+160
ADDP4
ARGP4
ADDRLP4 944
INDIRI4
ADDRGP4 cgs+43008+224
ADDP4
ARGP4
ADDRLP4 944
INDIRI4
ADDRGP4 cgs+43008+416
ADDP4
ARGP4
ADDRLP4 940
INDIRI4
ARGI4
ADDRLP4 948
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 0
EQI4 $2289
line 4231
;4230:			cgs.clientinfo[cent->currentState.number].teamName, cent->currentState.number))
;4231:		{
line 4232
;4232:			cent->isATST = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
CNSTI4 0
ASGNI4
line 4233
;4233:			cg_entities[cent->currentState.number].isATST = cent->isATST;
ADDRLP4 952
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 952
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+1028
ADDP4
ADDRLP4 952
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ASGNI4
line 4234
;4234:			return;
ADDRGP4 $2245
JUMPV
LABELV $2289
line 4236
;4235:		}
;4236:	}
LABELV $2285
LABELV $2272
line 4238
;4237:
;4238:	if (cent->currentState.number < MAX_CLIENTS &&
ADDRLP4 932
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 932
INDIRP4
INDIRI4
CNSTI4 32
GEI4 $2299
ADDRLP4 936
CNSTI4 0
ASGNI4
ADDRLP4 932
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRLP4 936
INDIRI4
EQI4 $2299
ADDRLP4 932
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ADDRLP4 936
INDIRI4
NEI4 $2299
line 4241
;4239:		cent->currentState.teamowner &&
;4240:		!cent->isATST)
;4241:	{
line 4242
;4242:		return;
ADDRGP4 $2245
JUMPV
LABELV $2299
line 4245
;4243:	}
;4244:
;4245:	if (!cent->trickAlphaTime || (cg.time - cent->trickAlphaTime) > 1000)
ADDRLP4 940
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
INDIRI4
ASGNI4
ADDRLP4 940
INDIRI4
CNSTI4 0
EQI4 $2304
ADDRGP4 cg+64
INDIRI4
ADDRLP4 940
INDIRI4
SUBI4
CNSTI4 1000
LEI4 $2301
LABELV $2304
line 4246
;4246:	{ //things got out of sync, perhaps a new client is trying to fill in this slot
line 4247
;4247:		cent->trickAlpha = 255;
ADDRFP4 0
INDIRP4
CNSTI4 1904
ADDP4
CNSTI4 255
ASGNI4
line 4248
;4248:		cent->trickAlphaTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4249
;4249:	}
LABELV $2301
line 4252
;4250:
;4251:	//If this client has tricked you.
;4252:	if (CG_IsMindTricked(cent->currentState.trickedentindex,
ADDRLP4 944
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 944
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRLP4 944
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ARGI4
ADDRLP4 944
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
ARGI4
ADDRLP4 944
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
ADDRLP4 948
ADDRGP4 CG_IsMindTricked
CALLI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 0
EQI4 $2306
line 4257
;4253:		cent->currentState.trickedentindex2,
;4254:		cent->currentState.trickedentindex3,
;4255:		cent->currentState.trickedentindex4,
;4256:		cg.snap->ps.clientNum))
;4257:	{
line 4258
;4258:		if (cent->trickAlpha > 1)
ADDRFP4 0
INDIRP4
CNSTI4 1904
ADDP4
INDIRI4
CNSTI4 1
LEI4 $2309
line 4259
;4259:		{
line 4260
;4260:			cent->trickAlpha -= (cg.time - cent->trickAlphaTime)*0.5;
ADDRLP4 952
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 956
ADDRLP4 952
INDIRP4
CNSTI4 1904
ADDP4
ASGNP4
ADDRLP4 956
INDIRP4
ADDRLP4 956
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1056964608
ADDRGP4 cg+64
INDIRI4
ADDRLP4 952
INDIRP4
CNSTI4 1908
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
SUBF4
CVFI4 4
ASGNI4
line 4261
;4261:			cent->trickAlphaTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4263
;4262:
;4263:			if (cent->trickAlpha < 0)
ADDRFP4 0
INDIRP4
CNSTI4 1904
ADDP4
INDIRI4
CNSTI4 0
GEI4 $2313
line 4264
;4264:			{
line 4265
;4265:				cent->trickAlpha = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1904
ADDP4
CNSTI4 0
ASGNI4
line 4266
;4266:			}
LABELV $2313
line 4268
;4267:
;4268:			doAlpha = 1;
ADDRLP4 828
CNSTI4 1
ASGNI4
line 4269
;4269:		}
ADDRGP4 $2307
JUMPV
LABELV $2309
line 4271
;4270:		else
;4271:		{
line 4272
;4272:			doAlpha = 1;
ADDRLP4 828
CNSTI4 1
ASGNI4
line 4273
;4273:			cent->trickAlpha = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1904
ADDP4
CNSTI4 1
ASGNI4
line 4274
;4274:			cent->trickAlphaTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4275
;4275:			iwantout = 1;
ADDRLP4 768
CNSTI4 1
ASGNI4
line 4276
;4276:		}
line 4277
;4277:	}
ADDRGP4 $2307
JUMPV
LABELV $2306
line 4279
;4278:	else
;4279:	{
line 4280
;4280:		if (cent->trickAlpha < 255)
ADDRFP4 0
INDIRP4
CNSTI4 1904
ADDP4
INDIRI4
CNSTI4 255
GEI4 $2316
line 4281
;4281:		{
line 4282
;4282:			cent->trickAlpha += (cg.time - cent->trickAlphaTime);
ADDRLP4 952
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 956
ADDRLP4 952
INDIRP4
CNSTI4 1904
ADDP4
ASGNP4
ADDRLP4 956
INDIRP4
ADDRLP4 956
INDIRP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
ADDRLP4 952
INDIRP4
CNSTI4 1908
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 4283
;4283:			cent->trickAlphaTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4285
;4284:
;4285:			if (cent->trickAlpha > 255)
ADDRFP4 0
INDIRP4
CNSTI4 1904
ADDP4
INDIRI4
CNSTI4 255
LEI4 $2320
line 4286
;4286:			{
line 4287
;4287:				cent->trickAlpha = 255;
ADDRFP4 0
INDIRP4
CNSTI4 1904
ADDP4
CNSTI4 255
ASGNI4
line 4288
;4288:			}
LABELV $2320
line 4290
;4289:
;4290:			doAlpha = 1;
ADDRLP4 828
CNSTI4 1
ASGNI4
line 4291
;4291:		}
ADDRGP4 $2317
JUMPV
LABELV $2316
line 4293
;4292:		else
;4293:		{
line 4294
;4294:			cent->trickAlpha = 255;
ADDRFP4 0
INDIRP4
CNSTI4 1904
ADDP4
CNSTI4 255
ASGNI4
line 4295
;4295:			cent->trickAlphaTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4296
;4296:		}
LABELV $2317
line 4297
;4297:	}
LABELV $2307
line 4300
;4298:
;4299:	// get the player model information
;4300:	renderfx = 0;
ADDRLP4 776
CNSTI4 0
ASGNI4
line 4301
;4301:	if ( cent->currentState.number == cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $2323
line 4302
;4302:		if (!cg.renderingThirdPerson) {
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $2326
line 4303
;4303:			renderfx = RF_THIRD_PERSON;			// only draw in mirrors
ADDRLP4 776
CNSTI4 2
ASGNI4
line 4304
;4304:		} else {
ADDRGP4 $2327
JUMPV
LABELV $2326
line 4305
;4305:			if (cg_cameraMode.integer) {
ADDRGP4 cg_cameraMode+12
INDIRI4
CNSTI4 0
EQI4 $2329
line 4306
;4306:				iwantout = 1;
ADDRLP4 768
CNSTI4 1
ASGNI4
line 4312
;4307:
;4308:				
;4309:				// goto minimal_add;
;4310:				
;4311:				// NOTENOTE Temporary
;4312:				return;
ADDRGP4 $2245
JUMPV
LABELV $2329
line 4314
;4313:			}
;4314:		}
LABELV $2327
line 4315
;4315:	}
LABELV $2323
line 4324
;4316:
;4317:	// Update the player's client entity information regarding weapons.
;4318:	// Explanation:  The entitystate has a weapond defined on it.  The cliententity does as well.
;4319:	// The cliententity's weapon tells us what the ghoul2 instance on the cliententity has bolted to it.
;4320:	// If the entitystate and cliententity weapons differ, then the state's needs to be copied to the client.
;4321:	// Save the old weapon, to verify that it is or is not the same as the new weapon.
;4322:	// rww - Make sure weapons don't get set BEFORE cent->ghoul2 is initialized or else we'll have no
;4323:	// weapon bolted on
;4324:	if (cent->currentState.saberInFlight)
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2332
line 4325
;4325:	{
line 4326
;4326:		cent->ghoul2weapon = g2WeaponInstances[WP_SABER];
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
ADDRGP4 g2WeaponInstances+8
INDIRP4
ASGNP4
line 4327
;4327:	}
LABELV $2332
line 4329
;4328:
;4329:	if (cent->ghoul2 && 
ADDRLP4 952
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 952
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2335
ADDRLP4 952
INDIRP4
CNSTI4 960
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 952
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
INDIRP4
CVPU4 4
EQU4 $2335
ADDRLP4 956
CNSTI4 0
ASGNI4
ADDRLP4 952
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 956
INDIRI4
NEI4 $2335
ADDRLP4 952
INDIRP4
CNSTI4 1012
ADDP4
INDIRI4
ADDRLP4 956
INDIRI4
NEI4 $2335
ADDRLP4 952
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ADDRLP4 956
INDIRI4
NEI4 $2335
line 4332
;4330:		cent->ghoul2weapon != g2WeaponInstances[cent->currentState.weapon] &&
;4331:		!(cent->currentState.eFlags & EF_DEAD) && !cent->torsoBolt && !cent->isATST)
;4332:	{
line 4333
;4333:		CG_CopyG2WeaponInstance(cent->currentState.weapon, cent->ghoul2);
ADDRLP4 960
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 960
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 960
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_CopyG2WeaponInstance
CALLV
pop
line 4335
;4334:
;4335:		if (!(cg.snap->ps.pm_flags & PMF_FOLLOW))
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $2337
line 4336
;4336:		{
line 4337
;4337:			if (cent->weapon == WP_SABER && cent->weapon != cent->currentState.weapon && !cent->currentState.shouldtarget)
ADDRLP4 964
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 968
ADDRLP4 964
INDIRP4
CNSTI4 956
ADDP4
INDIRI4
ASGNI4
ADDRLP4 968
INDIRI4
CNSTI4 2
NEI4 $2340
ADDRLP4 968
INDIRI4
ADDRLP4 964
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
EQI4 $2340
ADDRLP4 964
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2340
line 4338
;4338:			{ //switching away from the saber
line 4339
;4339:				trap_S_StartSound(cent->lerpOrigin, cent->currentState.number, CHAN_AUTO, trap_S_RegisterSound( "sound/weapons/saber/saberoffquick.wav" ));
ADDRGP4 $2342
ARGP4
ADDRLP4 972
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 976
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 976
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 976
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 972
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 4340
;4340:			}
ADDRGP4 $2341
JUMPV
LABELV $2340
line 4341
;4341:			else if (cent->currentState.weapon == WP_SABER && cent->weapon != cent->currentState.weapon)
ADDRLP4 972
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 976
ADDRLP4 972
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 976
INDIRI4
CNSTI4 2
NEI4 $2343
ADDRLP4 972
INDIRP4
CNSTI4 956
ADDP4
INDIRI4
ADDRLP4 976
INDIRI4
EQI4 $2343
line 4342
;4342:			{ //switching to the saber
line 4343
;4343:				trap_S_StartSound(cent->lerpOrigin, cent->currentState.number, CHAN_AUTO, trap_S_RegisterSound( "sound/weapons/saber/saberon.wav" ));
ADDRGP4 $2345
ARGP4
ADDRLP4 980
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 984
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 984
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 984
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 980
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 4344
;4344:			}
LABELV $2343
LABELV $2341
line 4345
;4345:		}
LABELV $2337
line 4347
;4346:
;4347:		cent->weapon = cent->currentState.weapon;
ADDRLP4 964
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 964
INDIRP4
CNSTI4 956
ADDP4
ADDRLP4 964
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
line 4348
;4348:		cent->ghoul2weapon = g2WeaponInstances[cent->currentState.weapon];
ADDRLP4 968
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 968
INDIRP4
CNSTI4 960
ADDP4
ADDRLP4 968
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
INDIRP4
ASGNP4
line 4349
;4349:	}
ADDRGP4 $2336
JUMPV
LABELV $2335
line 4350
;4350:	else if ((cent->currentState.eFlags & EF_DEAD) || cent->torsoBolt)
ADDRLP4 960
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 964
CNSTI4 0
ASGNI4
ADDRLP4 960
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 964
INDIRI4
NEI4 $2348
ADDRLP4 960
INDIRP4
CNSTI4 1012
ADDP4
INDIRI4
ADDRLP4 964
INDIRI4
EQI4 $2346
LABELV $2348
line 4351
;4351:	{
line 4352
;4352:		cent->ghoul2weapon = NULL; //be sure to update after respawning/getting limb regrown
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
CNSTP4 0
ASGNP4
line 4353
;4353:	}
LABELV $2346
LABELV $2336
line 4356
;4354:
;4355:	
;4356:	memset (&legs, 0, sizeof(legs));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4358
;4357:
;4358:	CG_SetGhoul2Info(&legs, cent);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetGhoul2Info
CALLV
pop
line 4360
;4359:
;4360:	VectorSet(legs.modelScale, 1,1,1);
ADDRLP4 0+196
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+196+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+196+8
CNSTF4 1065353216
ASGNF4
line 4361
;4361:	legs.radius = 64;
ADDRLP4 0+92
CNSTF4 1115684864
ASGNF4
line 4362
;4362:	VectorClear(legs.angles);
ADDRLP4 968
CNSTF4 0
ASGNF4
ADDRLP4 0+184+8
ADDRLP4 968
INDIRF4
ASGNF4
ADDRLP4 0+184+4
ADDRLP4 968
INDIRF4
ASGNF4
ADDRLP4 0+184
ADDRLP4 968
INDIRF4
ASGNF4
line 4364
;4363:
;4364:	if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2360
line 4365
;4365:	{
line 4366
;4366:		legs.radius = 400;
ADDRLP4 0+92
CNSTF4 1137180672
ASGNF4
line 4367
;4367:	}
LABELV $2360
line 4371
;4368:
;4369:// minimal_add:
;4370:
;4371:	team = cgs.clientinfo[ cent->currentState.clientNum ].team;
ADDRLP4 840
CNSTI4 788
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
ASGNI4
line 4373
;4372:
;4373:	if (cgs.gametype >= GT_TEAM && cg_drawFriend.integer &&
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $2365
ADDRGP4 cg_drawFriend+12
INDIRI4
CNSTI4 0
EQI4 $2365
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
EQI4 $2365
line 4375
;4374:		cent->currentState.number != cg.snap->ps.clientNum)			// Don't show a sprite above a player's own head in 3rd person.
;4375:	{	// If the view is either a spectator or on the same team as this character, show a symbol above their head.
line 4376
;4376:		if ((cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR || cg.snap->ps.persistant[PERS_TEAM] == team) &&
ADDRLP4 972
CNSTI4 336
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 972
INDIRI4
ADDP4
INDIRI4
CNSTI4 3
EQI4 $2374
ADDRGP4 cg+36
INDIRP4
ADDRLP4 972
INDIRI4
ADDP4
INDIRI4
ADDRLP4 840
INDIRI4
NEI4 $2370
LABELV $2374
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $2370
line 4378
;4377:			!(cent->currentState.eFlags & EF_DEAD))
;4378:		{
line 4379
;4379:			if (team == TEAM_RED)
ADDRLP4 840
INDIRI4
CNSTI4 1
NEI4 $2375
line 4380
;4380:			{
line 4381
;4381:				CG_PlayerFloatSprite( cent, cgs.media.teamRedShader);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+70280+176
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 4382
;4382:			}
ADDRGP4 $2376
JUMPV
LABELV $2375
line 4384
;4383:			else	// if (team == TEAM_BLUE)
;4384:			{
line 4385
;4385:				CG_PlayerFloatSprite( cent, cgs.media.teamBlueShader);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+70280+180
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 4386
;4386:			}
LABELV $2376
line 4387
;4387:		}
LABELV $2370
line 4388
;4388:	}
LABELV $2365
line 4390
;4389:
;4390:	if (cgs.gametype == GT_JEDIMASTER && cg_drawFriend.integer &&
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 2
NEI4 $2381
ADDRGP4 cg_drawFriend+12
INDIRI4
CNSTI4 0
EQI4 $2381
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
EQI4 $2381
line 4392
;4391:		cent->currentState.number != cg.snap->ps.clientNum)			// Don't show a sprite above a player's own head in 3rd person.
;4392:	{	// If the view is either a spectator or on the same team as this character, show a symbol above their head.
line 4393
;4393:		if ((cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR || cg.snap->ps.persistant[PERS_TEAM] == team) &&
ADDRLP4 972
CNSTI4 336
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 972
INDIRI4
ADDP4
INDIRI4
CNSTI4 3
EQI4 $2390
ADDRGP4 cg+36
INDIRP4
ADDRLP4 972
INDIRI4
ADDP4
INDIRI4
ADDRLP4 840
INDIRI4
NEI4 $2386
LABELV $2390
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $2386
line 4395
;4394:			!(cent->currentState.eFlags & EF_DEAD))
;4395:		{
line 4396
;4396:			if (CG_ThereIsAMaster())
ADDRLP4 976
ADDRGP4 CG_ThereIsAMaster
CALLI4
ASGNI4
ADDRLP4 976
INDIRI4
CNSTI4 0
EQI4 $2391
line 4397
;4397:			{
line 4398
;4398:				if (!cg.snap->ps.isJediMaster)
ADDRGP4 cg+36
INDIRP4
CNSTI4 648
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2393
line 4399
;4399:				{
line 4400
;4400:					if (!cent->currentState.isJediMaster)
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2396
line 4401
;4401:					{
line 4402
;4402:						CG_PlayerFloatSprite( cent, cgs.media.teamRedShader);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+70280+176
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 4403
;4403:					}
LABELV $2396
line 4404
;4404:				}
LABELV $2393
line 4405
;4405:			}
LABELV $2391
line 4406
;4406:		}
LABELV $2386
line 4407
;4407:	}
LABELV $2381
line 4409
;4408:
;4409:	if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2400
line 4410
;4410:	{
line 4411
;4411:		goto doEssentialOne;
ADDRGP4 $2402
JUMPV
LABELV $2400
line 4415
;4412:	}
;4413:
;4414:	// add the shadow
;4415:	shadow = CG_PlayerShadow( cent, &shadowPlane );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 536
ARGP4
ADDRLP4 972
ADDRGP4 CG_PlayerShadow
CALLI4
ASGNI4
ADDRLP4 832
ADDRLP4 972
INDIRI4
ASGNI4
line 4417
;4416:
;4417:	if ( (cent->currentState.eFlags & EF_SEEKERDRONE) || cent->currentState.genericenemyindex != -1 )
ADDRLP4 976
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 976
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1048576
BANDI4
CNSTI4 0
NEI4 $2405
ADDRLP4 976
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $2403
LABELV $2405
line 4418
;4418:	{
line 4419
;4419:		memset( &seeker, 0, sizeof(seeker) );
ADDRLP4 276
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4421
;4420:
;4421:		VectorCopy(cent->lerpOrigin, elevated);
ADDRLP4 224
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 4422
;4422:		elevated[2] += 40;
ADDRLP4 224+8
ADDRLP4 224+8
INDIRF4
CNSTF4 1109393408
ADDF4
ASGNF4
line 4424
;4423:
;4424:		VectorCopy( elevated, seeker.lightingOrigin );
ADDRLP4 276+108
ADDRLP4 224
INDIRB
ASGNB 12
line 4425
;4425:		seeker.shadowPlane = shadowPlane;
ADDRLP4 276+120
ADDRLP4 536
INDIRF4
ASGNF4
line 4426
;4426:		seeker.renderfx = 0; //renderfx;
ADDRLP4 276+4
CNSTI4 0
ASGNI4
line 4429
;4427:							 //don't show in first person?
;4428:
;4429:		angle = ((cg.time / 12) & 255) * (M_PI * 2) / 255;
ADDRLP4 236
CNSTF4 1086918619
ADDRGP4 cg+64
INDIRI4
CNSTI4 12
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
ASGNF4
line 4430
;4430:		dir[0] = cos(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 980
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 212
CNSTF4 1101004800
ADDRLP4 980
INDIRF4
MULF4
ASGNF4
line 4431
;4431:		dir[1] = sin(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 984
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 212+4
CNSTF4 1101004800
ADDRLP4 984
INDIRF4
MULF4
ASGNF4
line 4432
;4432:		dir[2] = cos(angle) * 5;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 988
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 212+8
CNSTF4 1084227584
ADDRLP4 988
INDIRF4
MULF4
ASGNF4
line 4433
;4433:		VectorAdd(elevated, dir, seeker.origin);
ADDRLP4 276+52
ADDRLP4 224
INDIRF4
ADDRLP4 212
INDIRF4
ADDF4
ASGNF4
ADDRLP4 276+52+4
ADDRLP4 224+4
INDIRF4
ADDRLP4 212+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 276+52+8
ADDRLP4 224+8
INDIRF4
ADDRLP4 212+8
INDIRF4
ADDF4
ASGNF4
line 4435
;4434:
;4435:		VectorCopy(seeker.origin, seekorg);
ADDRLP4 868
ADDRLP4 276+52
INDIRB
ASGNB 12
line 4437
;4436:
;4437:		if (cent->currentState.genericenemyindex > 1024)
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 1024
LEI4 $2423
line 4438
;4438:		{
line 4439
;4439:			prefig = (cent->currentState.genericenemyindex-cg.time)/80;
ADDRLP4 844
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
CNSTI4 80
DIVI4
CVIF4 4
ASGNF4
line 4441
;4440:
;4441:			if (prefig > 55)
ADDRLP4 844
INDIRF4
CNSTF4 1113325568
LEF4 $2426
line 4442
;4442:			{
line 4443
;4443:				prefig = 55;
ADDRLP4 844
CNSTF4 1113325568
ASGNF4
line 4444
;4444:			}
ADDRGP4 $2427
JUMPV
LABELV $2426
line 4445
;4445:			else if (prefig < 1)
ADDRLP4 844
INDIRF4
CNSTF4 1065353216
GEF4 $2428
line 4446
;4446:			{
line 4447
;4447:				prefig = 1;
ADDRLP4 844
CNSTF4 1065353216
ASGNF4
line 4448
;4448:			}
LABELV $2428
LABELV $2427
line 4450
;4449:
;4450:			elevated[2] -= 55-prefig;
ADDRLP4 224+8
ADDRLP4 224+8
INDIRF4
CNSTF4 1113325568
ADDRLP4 844
INDIRF4
SUBF4
SUBF4
ASGNF4
line 4452
;4451:
;4452:			angle = ((cg.time / 12) & 255) * (M_PI * 2) / 255;
ADDRLP4 236
CNSTF4 1086918619
ADDRGP4 cg+64
INDIRI4
CNSTI4 12
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
ASGNF4
line 4453
;4453:			dir[0] = cos(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 992
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 212
CNSTF4 1101004800
ADDRLP4 992
INDIRF4
MULF4
ASGNF4
line 4454
;4454:			dir[1] = sin(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 996
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 212+4
CNSTF4 1101004800
ADDRLP4 996
INDIRF4
MULF4
ASGNF4
line 4455
;4455:			dir[2] = cos(angle) * 5;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 1000
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 212+8
CNSTF4 1084227584
ADDRLP4 1000
INDIRF4
MULF4
ASGNF4
line 4456
;4456:			VectorAdd(elevated, dir, seeker.origin);
ADDRLP4 276+52
ADDRLP4 224
INDIRF4
ADDRLP4 212
INDIRF4
ADDF4
ASGNF4
ADDRLP4 276+52+4
ADDRLP4 224+4
INDIRF4
ADDRLP4 212+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 276+52+8
ADDRLP4 224+8
INDIRF4
ADDRLP4 212+8
INDIRF4
ADDF4
ASGNF4
line 4457
;4457:		}
ADDRGP4 $2424
JUMPV
LABELV $2423
line 4458
;4458:		else if (cent->currentState.genericenemyindex != ENTITYNUM_NONE && cent->currentState.genericenemyindex != -1)
ADDRLP4 992
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
ADDRLP4 992
INDIRI4
CNSTI4 1023
EQI4 $2443
ADDRLP4 992
INDIRI4
CNSTI4 -1
EQI4 $2443
line 4459
;4459:		{
line 4460
;4460:			enent = &cg_entities[cent->currentState.genericenemyindex];
ADDRLP4 880
CNSTI4 1920
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 4462
;4461:
;4462:			if (enent)
ADDRLP4 880
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2445
line 4463
;4463:			{
line 4464
;4464:				VectorSubtract(enent->lerpOrigin, seekorg, enang);
ADDRLP4 996
ADDRLP4 880
INDIRP4
ASGNP4
ADDRLP4 884
ADDRLP4 996
INDIRP4
CNSTI4 928
ADDP4
INDIRF4
ADDRLP4 868
INDIRF4
SUBF4
ASGNF4
ADDRLP4 884+4
ADDRLP4 996
INDIRP4
CNSTI4 932
ADDP4
INDIRF4
ADDRLP4 868+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 884+8
ADDRLP4 880
INDIRP4
CNSTI4 936
ADDP4
INDIRF4
ADDRLP4 868+8
INDIRF4
SUBF4
ASGNF4
line 4465
;4465:				VectorNormalize(enang);
ADDRLP4 884
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 4466
;4466:				vectoangles(enang, angles);
ADDRLP4 884
ARGP4
ADDRLP4 252
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4467
;4467:				successchange = 1;
ADDRLP4 860
CNSTI4 1
ASGNI4
line 4468
;4468:			}
LABELV $2445
line 4469
;4469:		}
LABELV $2443
LABELV $2424
line 4471
;4470:
;4471:		if (!successchange)
ADDRLP4 860
INDIRI4
CNSTI4 0
NEI4 $2451
line 4472
;4472:		{
line 4473
;4473:			angles[0] = sin(angle) * 30;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 996
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 252
CNSTF4 1106247680
ADDRLP4 996
INDIRF4
MULF4
ASGNF4
line 4474
;4474:			angles[1] = (angle * 180 / M_PI) + 90;
ADDRLP4 252+4
CNSTF4 1127481344
ADDRLP4 236
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 4475
;4475:			if (angles[1] > 360)
ADDRLP4 252+4
INDIRF4
CNSTF4 1135869952
LEF4 $2454
line 4476
;4476:				angles[1] -= 360;
ADDRLP4 252+4
ADDRLP4 252+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $2454
line 4477
;4477:			angles[2] = 0;
ADDRLP4 252+8
CNSTF4 0
ASGNF4
line 4478
;4478:		}
LABELV $2451
line 4480
;4479:
;4480:		AnglesToAxis( angles, seeker.axis );
ADDRLP4 252
ARGP4
ADDRLP4 276+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 4482
;4481:
;4482:		seeker.hModel = trap_R_RegisterModel("models/items/remote.md3");
ADDRGP4 $2461
ARGP4
ADDRLP4 996
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 276+8
ADDRLP4 996
INDIRI4
ASGNI4
line 4483
;4483:		trap_R_AddRefEntityToScene( &seeker );
ADDRLP4 276
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 4484
;4484:	}
LABELV $2403
LABELV $2402
line 4488
;4485:
;4486:doEssentialOne:
;4487:	// add a water splash if partially in and out of water
;4488:	CG_PlayerSplash( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSplash
CALLV
pop
line 4490
;4489:
;4490:	if ( cg_shadows.integer == 3 && shadow ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 3
NEI4 $2462
ADDRLP4 832
INDIRI4
CNSTI4 0
EQI4 $2462
line 4491
;4491:		renderfx |= RF_SHADOW_PLANE;
ADDRLP4 776
ADDRLP4 776
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 4492
;4492:	}
LABELV $2462
line 4493
;4493:	renderfx |= RF_LIGHTING_ORIGIN;			// use the same origin for all
ADDRLP4 776
ADDRLP4 776
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 4496
;4494:
;4495:	// if we've been hit, display proper fullscreen fx
;4496:	CG_PlayerHitFX(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerHitFX
CALLV
pop
line 4498
;4497:
;4498:	VectorCopy( cent->lerpOrigin, legs.origin );
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 4500
;4499:
;4500:	VectorCopy( cent->lerpOrigin, legs.lightingOrigin );
ADDRLP4 0+108
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 4501
;4501:	legs.shadowPlane = shadowPlane;
ADDRLP4 0+120
ADDRLP4 536
INDIRF4
ASGNF4
line 4502
;4502:	legs.renderfx = renderfx;
ADDRLP4 0+4
ADDRLP4 776
INDIRI4
ASGNI4
line 4503
;4503:	VectorCopy (legs.origin, legs.oldorigin);	// don't positionally lerp at all
ADDRLP4 0+64
ADDRLP4 0+52
INDIRB
ASGNB 12
line 4505
;4504:
;4505:	CG_G2PlayerAngles( cent, legs.axis, rootAngles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 848
ARGP4
ADDRGP4 CG_G2PlayerAngles
CALLV
pop
line 4513
;4506:
;4507:	//This call is mainly just to reconstruct the skeleton. But we'll get the left hand matrix while we're at it.
;4508:	//If we don't reconstruct the skeleton after setting the bone angles, we will get bad bolt points on the model
;4509:	//(e.g. the weapon model bolt will look "lagged") if there's no other GetBoltMatrix call for the rest of the
;4510:	//frame. Yes, this is stupid and needs to be fixed properly.
;4511:	//The current solution is to force it not to reconstruct the skeleton for the first GBM call in G2PlayerAngles.
;4512:	//It works and we end up only reconstructing it once, but it doesn't seem like the best solution.
;4513:	trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_lhand, &lHandMatrix, cent->turAngles, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 980
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 980
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ADDRLP4 980
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+516
ADDP4
INDIRI4
ARGI4
ADDRLP4 488
ARGP4
ADDRLP4 980
INDIRP4
CNSTI4 1016
ADDP4
ARGP4
ADDRLP4 980
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 980
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 4514
;4514:	gotLHandMatrix = qtrue;
ADDRLP4 772
CNSTI4 1
ASGNI4
line 4516
;4515:
;4516:	if (cent->currentState.eFlags & EF_DEAD)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2476
line 4517
;4517:	{
line 4518
;4518:		dead = qtrue;
ADDRLP4 864
CNSTI4 1
ASGNI4
line 4522
;4519:		//rww - since our angles are fixed when we're dead this shouldn't be an issue anyway
;4520:		//we need to render the dying/dead player because we are now spawning the body on respawn instead of death
;4521:		//return;
;4522:	}
LABELV $2476
line 4524
;4523:
;4524:	ScaleModelAxis(&legs);
ADDRLP4 0
ARGP4
ADDRGP4 ScaleModelAxis
CALLV
pop
line 4526
;4525:
;4526:	memset( &torso, 0, sizeof(torso) );
ADDRLP4 540
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4528
;4527:
;4528:	if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2478
line 4529
;4529:	{
line 4530
;4530:		goto doEssentialTwo;
ADDRGP4 $2480
JUMPV
LABELV $2478
line 4534
;4531:	}
;4532:
;4533:	//rww - force speed "trail" effect
;4534:	if (!(cent->currentState.powerups & (1 << PW_SPEED)) || doAlpha || !cg_speedTrail.integer)
ADDRLP4 984
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
ADDRLP4 984
INDIRI4
EQI4 $2485
ADDRLP4 828
INDIRI4
ADDRLP4 984
INDIRI4
NEI4 $2485
ADDRGP4 cg_speedTrail+12
INDIRI4
ADDRLP4 984
INDIRI4
NEI4 $2481
LABELV $2485
line 4535
;4535:	{
line 4536
;4536:		cent->frame_minus1_refreshed = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
CNSTI4 0
ASGNI4
line 4537
;4537:		cent->frame_minus2_refreshed = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1468
ADDP4
CNSTI4 0
ASGNI4
line 4538
;4538:	}
LABELV $2481
line 4540
;4539:
;4540:	if (cent->frame_minus1.ghoul2 != cent->ghoul2)
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 988
INDIRP4
CNSTI4 1248
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 988
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
EQU4 $2486
line 4541
;4541:	{
line 4542
;4542:		cent->frame_minus1_refreshed = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
CNSTI4 0
ASGNI4
line 4543
;4543:	}
LABELV $2486
line 4544
;4544:	if (cent->frame_minus2.ghoul2 != cent->ghoul2)
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 992
INDIRP4
CNSTI4 1460
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 992
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
EQU4 $2488
line 4545
;4545:	{
line 4546
;4546:		cent->frame_minus2_refreshed = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1468
ADDP4
CNSTI4 0
ASGNI4
line 4547
;4547:	}
LABELV $2488
line 4549
;4548:
;4549:	VectorCopy(cent->currentState.pos.trDelta, tDir);
ADDRLP4 264
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 4551
;4550:
;4551:	distVelBase = SPEED_TRAIL_DISTANCE*(VectorNormalize(tDir)*0.004);
ADDRLP4 264
ARGP4
ADDRLP4 996
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 764
CNSTF4 1086324736
CNSTF4 998445679
ADDRLP4 996
INDIRF4
MULF4
MULF4
CVFI4 4
ASGNI4
line 4553
;4552:
;4553:	if (cent->frame_minus1.ghoul2 && cent->frame_minus1_refreshed)
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
CNSTI4 1248
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2490
ADDRLP4 1000
INDIRP4
CNSTI4 1464
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2490
line 4554
;4554:	{
line 4555
;4555:		cent->frame_minus1.renderfx |= RF_FORCE_ENT_ALPHA;
ADDRLP4 1004
ADDRFP4 0
INDIRP4
CNSTI4 1044
ADDP4
ASGNP4
ADDRLP4 1004
INDIRP4
ADDRLP4 1004
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 4556
;4556:		cent->frame_minus1.shaderRGBA[3] = 100;
ADDRFP4 0
INDIRP4
CNSTI4 1123
ADDP4
CNSTU1 100
ASGNU1
line 4562
;4557:
;4558:		//rww - if the client gets a bad framerate we will only receive frame positions
;4559:		//once per frame anyway, so we might end up with speed trails very spread out.
;4560:		//in order to avoid that, we'll get the direction of the last trail from the player
;4561:		//and place the trail refent a set distance from the player location this frame
;4562:		VectorSubtract(cent->frame_minus1.origin, legs.origin, tDir);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264
ADDRLP4 1008
INDIRP4
CNSTI4 1092
ADDP4
INDIRF4
ADDRLP4 0+52
INDIRF4
SUBF4
ASGNF4
ADDRLP4 264+4
ADDRLP4 1008
INDIRP4
CNSTI4 1096
ADDP4
INDIRF4
ADDRLP4 0+52+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 264+8
ADDRFP4 0
INDIRP4
CNSTI4 1100
ADDP4
INDIRF4
ADDRLP4 0+52+8
INDIRF4
SUBF4
ASGNF4
line 4563
;4563:		VectorNormalize(tDir);
ADDRLP4 264
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 4565
;4564:
;4565:		cent->frame_minus1.origin[0] = legs.origin[0]+tDir[0]*distVelBase;
ADDRFP4 0
INDIRP4
CNSTI4 1092
ADDP4
ADDRLP4 0+52
INDIRF4
ADDRLP4 264
INDIRF4
ADDRLP4 764
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 4566
;4566:		cent->frame_minus1.origin[1] = legs.origin[1]+tDir[1]*distVelBase;
ADDRFP4 0
INDIRP4
CNSTI4 1096
ADDP4
ADDRLP4 0+52+4
INDIRF4
ADDRLP4 264+4
INDIRF4
ADDRLP4 764
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 4567
;4567:		cent->frame_minus1.origin[2] = legs.origin[2]+tDir[2]*distVelBase;
ADDRFP4 0
INDIRP4
CNSTI4 1100
ADDP4
ADDRLP4 0+52+8
INDIRF4
ADDRLP4 264+8
INDIRF4
ADDRLP4 764
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 4569
;4568:
;4569:		trap_R_AddRefEntityToScene(&cent->frame_minus1);
ADDRFP4 0
INDIRP4
CNSTI4 1040
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 4570
;4570:	}
LABELV $2490
line 4572
;4571:
;4572:	if (cent->frame_minus2.ghoul2 && cent->frame_minus2_refreshed)
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
CNSTI4 1460
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2506
ADDRLP4 1004
INDIRP4
CNSTI4 1468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2506
line 4573
;4573:	{
line 4574
;4574:		cent->frame_minus2.renderfx |= RF_FORCE_ENT_ALPHA;
ADDRLP4 1008
ADDRFP4 0
INDIRP4
CNSTI4 1256
ADDP4
ASGNP4
ADDRLP4 1008
INDIRP4
ADDRLP4 1008
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 4575
;4575:		cent->frame_minus2.shaderRGBA[3] = 50;
ADDRFP4 0
INDIRP4
CNSTI4 1335
ADDP4
CNSTU1 50
ASGNU1
line 4578
;4576:
;4577:		//Same as above but do it between trail points instead of the player and first trail entry
;4578:		VectorSubtract(cent->frame_minus2.origin, cent->frame_minus1.origin, tDir);
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264
ADDRLP4 1012
INDIRP4
CNSTI4 1304
ADDP4
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 1092
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 264+4
ADDRLP4 1012
INDIRP4
CNSTI4 1308
ADDP4
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 1096
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1016
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264+8
ADDRLP4 1016
INDIRP4
CNSTI4 1312
ADDP4
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 1100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4579
;4579:		VectorNormalize(tDir);
ADDRLP4 264
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 4581
;4580:
;4581:		cent->frame_minus2.origin[0] = cent->frame_minus1.origin[0]+tDir[0]*distVelBase;
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1020
INDIRP4
CNSTI4 1304
ADDP4
ADDRLP4 1020
INDIRP4
CNSTI4 1092
ADDP4
INDIRF4
ADDRLP4 264
INDIRF4
ADDRLP4 764
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 4582
;4582:		cent->frame_minus2.origin[1] = cent->frame_minus1.origin[1]+tDir[1]*distVelBase;
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 1308
ADDP4
ADDRLP4 1024
INDIRP4
CNSTI4 1096
ADDP4
INDIRF4
ADDRLP4 264+4
INDIRF4
ADDRLP4 764
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 4583
;4583:		cent->frame_minus2.origin[2] = cent->frame_minus1.origin[2]+tDir[2]*distVelBase;
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CNSTI4 1312
ADDP4
ADDRLP4 1028
INDIRP4
CNSTI4 1100
ADDP4
INDIRF4
ADDRLP4 264+8
INDIRF4
ADDRLP4 764
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 4585
;4584:
;4585:		trap_R_AddRefEntityToScene(&cent->frame_minus2);
ADDRFP4 0
INDIRP4
CNSTI4 1252
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 4586
;4586:	}
LABELV $2506
LABELV $2480
line 4589
;4587:
;4588:doEssentialTwo:
;4589:	VectorCopy(cent->turAngles, cg_entities[cent->currentState.number].turAngles);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 1008
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+1016
ADDP4
ADDRLP4 1008
INDIRP4
CNSTI4 1016
ADDP4
INDIRB
ASGNB 12
line 4590
;4590:	VectorCopy(legs.origin, cg_entities[cent->currentState.number].lerpOrigin);
CNSTI4 1920
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities+928
ADDP4
ADDRLP4 0+52
INDIRB
ASGNB 12
line 4593
;4591:
;4592:	// get the animation state (after rotation, to allow feet shuffle)
;4593:	CG_PlayerAnimation( cent, &legs.oldframe, &legs.frame, &legs.backlerp,
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+124
ARGP4
ADDRLP4 0+104
ARGP4
ADDRLP4 0+128
ARGP4
ADDRLP4 540+124
ARGP4
ADDRLP4 540+104
ARGP4
ADDRLP4 540+128
ARGP4
ADDRGP4 CG_PlayerAnimation
CALLV
pop
line 4596
;4594:		 &torso.oldframe, &torso.frame, &torso.backlerp );
;4595:
;4596:	if (cent->currentState.eFlags & EF_DEAD)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2521
line 4597
;4597:	{ //keep track of death anim frame for when we copy off the bodyqueue
line 4598
;4598:		cgs.clientinfo[cent->currentState.number].frame = cent->pe.torso.frame;
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 788
ADDRLP4 1012
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+76
ADDP4
ADDRLP4 1012
INDIRP4
CNSTI4 716
ADDP4
INDIRI4
ASGNI4
line 4599
;4599:	}
LABELV $2521
line 4608
;4600:
;4601:/*	if ( cent->gent->s.number == 0 && cg_thirdPersonAlpha.value < 1.0f )
;4602:	{
;4603:		ent.renderfx |= RF_ALPHA_FADE;
;4604:		ent.shaderRGBA[3] = (unsigned char)(cg_thirdPersonAlpha.value * 255.0f);
;4605:	}
;4606:*/
;4607:
;4608:	if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2525
line 4609
;4609:	{
line 4610
;4610:		goto doEssentialThree;
ADDRGP4 $2527
JUMPV
LABELV $2525
line 4616
;4611:	}
;4612:
;4613:	//rww - render effects multiple times to compensate for low framerate? This won't do much because
;4614:	//the effect still gets rendered in this frame and expires, possibly before the next frame. So
;4615:	//it is disabled for now (setting effectTimeLayer to 0 after one play)
;4616:	if (cent->trailTime < cg.time)
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
GEI4 $2528
line 4617
;4617:	{
line 4618
;4618:		cent->trailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4619
;4619:	}
LABELV $2528
line 4622
;4620:
;4621:	//compensate for up to 300ms
;4622:	effectTimeLayer = (300 - (cent->trailTime - cg.time));
ADDRLP4 756
CNSTI4 300
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
SUBI4
ASGNI4
line 4624
;4623:
;4624:	if (effectTimeLayer < 50)
ADDRLP4 756
INDIRI4
CNSTI4 50
GEI4 $2533
line 4625
;4625:	{ //play at least once
line 4626
;4626:		effectTimeLayer = 50;
ADDRLP4 756
CNSTI4 50
ASGNI4
line 4627
;4627:	}
LABELV $2533
line 4629
;4628:
;4629:	cent->trailTime = cg.time + 300;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 300
ADDI4
ASGNI4
line 4631
;4630:
;4631:	if (cent->currentState.activeForcePass > FORCE_LEVEL_3)
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 3
LEI4 $2536
line 4632
;4632:	{
line 4633
;4633:		int effectTimeLayerL = effectTimeLayer;
ADDRLP4 1012
ADDRLP4 756
INDIRI4
ASGNI4
line 4637
;4634:
;4635:		vec3_t axis[3];
;4636:		vec3_t tAng, fAng, fxDir;
;4637:		int realForceLev = (cent->currentState.activeForcePass - FORCE_LEVEL_3);
ADDRLP4 1016
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 3
SUBI4
ASGNI4
line 4639
;4638:
;4639:		VectorSet( tAng, cent->turAngles[PITCH], cent->turAngles[YAW], cent->turAngles[ROLL] );
ADDRLP4 1092
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1068
ADDRLP4 1092
INDIRP4
CNSTI4 1016
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1068+4
ADDRLP4 1092
INDIRP4
CNSTI4 1020
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1068+8
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRF4
ASGNF4
line 4641
;4640:
;4641:		VectorSet( fAng, cent->pe.torso.pitchAngle, cent->pe.torso.yawAngle, 0 );
ADDRLP4 1096
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
ADDRLP4 1096
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1056+4
ADDRLP4 1096
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1056+8
CNSTF4 0
ASGNF4
line 4643
;4642:
;4643:		AngleVectors( fAng, fxDir, NULL, NULL );
ADDRLP4 1056
ARGP4
ADDRLP4 1080
ARGP4
ADDRLP4 1100
CNSTP4 0
ASGNP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4646
;4644:
;4645:		//trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_lhand, &boltMatrix, tAng, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
;4646:		if (!gotLHandMatrix)
ADDRLP4 772
INDIRI4
CNSTI4 0
NEI4 $2542
line 4647
;4647:		{
line 4648
;4648:			trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_lhand, &lHandMatrix, cent->turAngles, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ADDRLP4 1104
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+516
ADDP4
INDIRI4
ARGI4
ADDRLP4 488
ARGP4
ADDRLP4 1104
INDIRP4
CNSTI4 1016
ADDP4
ARGP4
ADDRLP4 1104
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 1104
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 4649
;4649:			gotLHandMatrix = qtrue;
ADDRLP4 772
CNSTI4 1
ASGNI4
line 4650
;4650:		}
LABELV $2542
line 4652
;4651:
;4652:		efOrg[0] = lHandMatrix.matrix[0][3];
ADDRLP4 240
ADDRLP4 488+12
INDIRF4
ASGNF4
line 4653
;4653:		efOrg[1] = lHandMatrix.matrix[1][3];
ADDRLP4 240+4
ADDRLP4 488+16+12
INDIRF4
ASGNF4
line 4654
;4654:		efOrg[2] = lHandMatrix.matrix[2][3];
ADDRLP4 240+8
ADDRLP4 488+32+12
INDIRF4
ASGNF4
line 4656
;4655:
;4656:		AnglesToAxis( fAng, axis );
ADDRLP4 1056
ARGP4
ADDRLP4 1020
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
ADDRGP4 $2556
JUMPV
LABELV $2555
line 4659
;4657:	
;4658:		while (effectTimeLayerL > 0)
;4659:		{
line 4660
;4660:			if ( realForceLev > FORCE_LEVEL_2 )
ADDRLP4 1016
INDIRI4
CNSTI4 2
LEI4 $2558
line 4661
;4661:			{//arc
line 4663
;4662:				//trap_FX_PlayEffectID( cgs.effects.forceLightningWide, efOrg, fxDir );
;4663:				trap_FX_PlayEntityEffectID(cgs.effects.forceDrainWide, efOrg, axis, cent->boltInfo, cent->currentState.number);
ADDRGP4 cgs+71560+156
INDIRI4
ARGI4
ADDRLP4 240
ARGP4
ADDRLP4 1020
ARGP4
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
ARGI4
ADDRLP4 1104
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_FX_PlayEntityEffectID
CALLV
pop
line 4664
;4664:			}
ADDRGP4 $2559
JUMPV
LABELV $2558
line 4666
;4665:			else
;4666:			{//line
line 4668
;4667:				//trap_FX_PlayEffectID( cgs.effects.forceLightning, efOrg, fxDir );
;4668:				trap_FX_PlayEntityEffectID(cgs.effects.forceDrain, efOrg, axis, cent->boltInfo, cent->currentState.number);
ADDRGP4 cgs+71560+152
INDIRI4
ARGI4
ADDRLP4 240
ARGP4
ADDRLP4 1020
ARGP4
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
ARGI4
ADDRLP4 1104
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_FX_PlayEntityEffectID
CALLV
pop
line 4669
;4669:			}
LABELV $2559
line 4671
;4670:
;4671:			effectTimeLayerL = 0;//-= 50;
ADDRLP4 1012
CNSTI4 0
ASGNI4
line 4672
;4672:		}
LABELV $2556
line 4658
ADDRLP4 1012
INDIRI4
CNSTI4 0
GTI4 $2555
line 4681
;4673:
;4674:		/*
;4675:		if (cent->bolt4 < cg.time)
;4676:		{
;4677:			cent->bolt4 = cg.time + 100;
;4678:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_AUTO, trap_S_RegisterSound("sound/weapons/force/drain.wav") );
;4679:		}
;4680:		*/
;4681:	}
ADDRGP4 $2537
JUMPV
LABELV $2536
line 4682
;4682:	else if ( cent->currentState.activeForcePass )
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2564
line 4683
;4683:	{//doing the electrocuting
line 4684
;4684:		int effectTimeLayerL = effectTimeLayer;
ADDRLP4 1012
ADDRLP4 756
INDIRI4
ASGNI4
line 4688
;4685:
;4686:		vec3_t axis[3];
;4687:		vec3_t tAng, fAng, fxDir;
;4688:		VectorSet( tAng, cent->turAngles[PITCH], cent->turAngles[YAW], cent->turAngles[ROLL] );
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1064
ADDRLP4 1088
INDIRP4
CNSTI4 1016
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1064+4
ADDRLP4 1088
INDIRP4
CNSTI4 1020
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1064+8
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRF4
ASGNF4
line 4690
;4689:
;4690:		VectorSet( fAng, cent->pe.torso.pitchAngle, cent->pe.torso.yawAngle, 0 );
ADDRLP4 1092
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
ADDRLP4 1092
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1052+4
ADDRLP4 1092
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1052+8
CNSTF4 0
ASGNF4
line 4692
;4691:
;4692:		AngleVectors( fAng, fxDir, NULL, NULL );
ADDRLP4 1052
ARGP4
ADDRLP4 1076
ARGP4
ADDRLP4 1096
CNSTP4 0
ASGNP4
ADDRLP4 1096
INDIRP4
ARGP4
ADDRLP4 1096
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4695
;4693:
;4694:		//trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_lhand, &boltMatrix, tAng, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
;4695:		if (!gotLHandMatrix)
ADDRLP4 772
INDIRI4
CNSTI4 0
NEI4 $2570
line 4696
;4696:		{
line 4697
;4697:			trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_lhand, &lHandMatrix, cent->turAngles, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 1100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1100
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ADDRLP4 1100
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+516
ADDP4
INDIRI4
ARGI4
ADDRLP4 488
ARGP4
ADDRLP4 1100
INDIRP4
CNSTI4 1016
ADDP4
ARGP4
ADDRLP4 1100
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 1100
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 4698
;4698:			gotLHandMatrix = qtrue;
ADDRLP4 772
CNSTI4 1
ASGNI4
line 4699
;4699:		}
LABELV $2570
line 4701
;4700:
;4701:		efOrg[0] = lHandMatrix.matrix[0][3];
ADDRLP4 240
ADDRLP4 488+12
INDIRF4
ASGNF4
line 4702
;4702:		efOrg[1] = lHandMatrix.matrix[1][3];
ADDRLP4 240+4
ADDRLP4 488+16+12
INDIRF4
ASGNF4
line 4703
;4703:		efOrg[2] = lHandMatrix.matrix[2][3];
ADDRLP4 240+8
ADDRLP4 488+32+12
INDIRF4
ASGNF4
line 4705
;4704:
;4705:		AnglesToAxis( fAng, axis );
ADDRLP4 1052
ARGP4
ADDRLP4 1016
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
ADDRGP4 $2584
JUMPV
LABELV $2583
line 4708
;4706:	
;4707:		while (effectTimeLayerL > 0)
;4708:		{
line 4709
;4709:			if ( cent->currentState.activeForcePass > FORCE_LEVEL_2 )
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 2
LEI4 $2586
line 4710
;4710:			{//arc
line 4712
;4711:				//trap_FX_PlayEffectID( cgs.effects.forceLightningWide, efOrg, fxDir );
;4712:				trap_FX_PlayEntityEffectID(cgs.effects.forceLightningWide, efOrg, axis, cent->boltInfo, cent->currentState.number);
ADDRGP4 cgs+71560+148
INDIRI4
ARGI4
ADDRLP4 240
ARGP4
ADDRLP4 1016
ARGP4
ADDRLP4 1100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1100
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
ARGI4
ADDRLP4 1100
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_FX_PlayEntityEffectID
CALLV
pop
line 4713
;4713:			}
ADDRGP4 $2587
JUMPV
LABELV $2586
line 4715
;4714:			else
;4715:			{//line
line 4717
;4716:				//trap_FX_PlayEffectID( cgs.effects.forceLightning, efOrg, fxDir );
;4717:				trap_FX_PlayEntityEffectID(cgs.effects.forceLightning, efOrg, axis, cent->boltInfo, cent->currentState.number);
ADDRGP4 cgs+71560+144
INDIRI4
ARGI4
ADDRLP4 240
ARGP4
ADDRLP4 1016
ARGP4
ADDRLP4 1100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1100
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
ARGI4
ADDRLP4 1100
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_FX_PlayEntityEffectID
CALLV
pop
line 4718
;4718:			}
LABELV $2587
line 4720
;4719:
;4720:			effectTimeLayerL = 0;//-= 50;
ADDRLP4 1012
CNSTI4 0
ASGNI4
line 4721
;4721:		}
LABELV $2584
line 4707
ADDRLP4 1012
INDIRI4
CNSTI4 0
GTI4 $2583
line 4730
;4722:
;4723:		/*
;4724:		if (cent->bolt4 < cg.time)
;4725:		{
;4726:			cent->bolt4 = cg.time + 100;
;4727:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_AUTO, trap_S_RegisterSound("sound/weapons/force/lightning.wav") );
;4728:		}
;4729:		*/
;4730:	}
LABELV $2564
LABELV $2537
line 4732
;4731:
;4732:	if ( cent->currentState.powerups & (1 << PW_DISINT_4) )
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $2592
line 4733
;4733:	{
line 4736
;4734:		vec3_t tAng;
;4735:		//VectorSet( tAng, 0, cent->pe.torso.yawAngle, 0 );
;4736:		VectorSet( tAng, cent->turAngles[PITCH], cent->turAngles[YAW], cent->turAngles[ROLL] );
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
ADDRLP4 1024
INDIRP4
CNSTI4 1016
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1012+4
ADDRLP4 1024
INDIRP4
CNSTI4 1020
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1012+8
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRF4
ASGNF4
line 4739
;4737:
;4738:		//trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_lhand, &boltMatrix, tAng, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
;4739:		if (!gotLHandMatrix)
ADDRLP4 772
INDIRI4
CNSTI4 0
NEI4 $2596
line 4740
;4740:		{
line 4741
;4741:			trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_lhand, &lHandMatrix, cent->turAngles, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ADDRLP4 1028
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+516
ADDP4
INDIRI4
ARGI4
ADDRLP4 488
ARGP4
ADDRLP4 1028
INDIRP4
CNSTI4 1016
ADDP4
ARGP4
ADDRLP4 1028
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 1028
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 4742
;4742:			gotLHandMatrix = qtrue;
ADDRLP4 772
CNSTI4 1
ASGNI4
line 4743
;4743:		}
LABELV $2596
line 4745
;4744:
;4745:		efOrg[0] = lHandMatrix.matrix[0][3];
ADDRLP4 240
ADDRLP4 488+12
INDIRF4
ASGNF4
line 4746
;4746:		efOrg[1] = lHandMatrix.matrix[1][3];
ADDRLP4 240+4
ADDRLP4 488+16+12
INDIRF4
ASGNF4
line 4747
;4747:		efOrg[2] = lHandMatrix.matrix[2][3];
ADDRLP4 240+8
ADDRLP4 488+32+12
INDIRF4
ASGNF4
line 4749
;4748:
;4749:		if ( (cent->currentState.forcePowersActive & (1 << FP_GRIP)) &&
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
CNSTI4 0
ASGNI4
ADDRLP4 1028
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 1032
INDIRI4
EQI4 $2609
ADDRGP4 cg+88
INDIRI4
ADDRLP4 1032
INDIRI4
NEI4 $2613
ADDRLP4 1028
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
EQI4 $2609
LABELV $2613
line 4751
;4750:			(cg.renderingThirdPerson || cent->currentState.number != cg.snap->ps.clientNum) )
;4751:		{
line 4754
;4752:			vec3_t boltDir;
;4753:			vec3_t origBolt;
;4754:			VectorCopy(efOrg, origBolt);
ADDRLP4 1048
ADDRLP4 240
INDIRB
ASGNB 12
line 4755
;4755:			trap_G2API_GiveMeVectorFromMatrix( &lHandMatrix, NEGATIVE_Y, boltDir );
ADDRLP4 488
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 1036
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 4757
;4756:
;4757:			CG_ForceGripEffect( efOrg );
ADDRLP4 240
ARGP4
ADDRGP4 CG_ForceGripEffect
CALLV
pop
line 4758
;4758:			CG_ForceGripEffect( efOrg );
ADDRLP4 240
ARGP4
ADDRGP4 CG_ForceGripEffect
CALLV
pop
line 4761
;4759:
;4760:			//Render a scaled version of the model's hand with a n337 looking shader
;4761:			{
line 4766
;4762:				const char *rotateBone;
;4763:				char *limbName;
;4764:				char *limbCapName;
;4765:				vec3_t armAng;
;4766:				float wv = sin( cg.time * 0.003f ) * 0.08f + 0.1f;
CNSTF4 994352038
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 1088
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 1060
CNSTF4 1034147594
ADDRLP4 1088
INDIRF4
MULF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 4768
;4767:
;4768:				rotateBone = "lradius";
ADDRLP4 1076
ADDRGP4 $2615
ASGNP4
line 4769
;4769:				limbName = "l_arm";
ADDRLP4 1080
ADDRGP4 $2616
ASGNP4
line 4770
;4770:				limbCapName = "l_arm_cap_torso_off";
ADDRLP4 1084
ADDRGP4 $2617
ASGNP4
line 4772
;4771:
;4772:				if (cent->grip_arm.ghoul2 && trap_G2_HaveWeGhoul2Models(cent->grip_arm.ghoul2))
ADDRLP4 1092
ADDRFP4 0
INDIRP4
CNSTI4 1900
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1092
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2618
ADDRLP4 1092
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
EQI4 $2618
line 4773
;4773:				{
line 4774
;4774:					trap_G2API_CleanGhoul2Models(&(cent->grip_arm.ghoul2));
ADDRFP4 0
INDIRP4
CNSTI4 1900
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 4775
;4775:				}
LABELV $2618
line 4777
;4776:
;4777:				memset( &cent->grip_arm, 0, sizeof(cent->grip_arm) );
ADDRFP4 0
INDIRP4
CNSTI4 1692
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4779
;4778:
;4779:				VectorCopy(origBolt, efOrg);
ADDRLP4 240
ADDRLP4 1048
INDIRB
ASGNB 12
line 4780
;4780:				trap_G2API_GiveMeVectorFromMatrix( &lHandMatrix, NEGATIVE_Y, boltDir );
ADDRLP4 488
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 1036
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 4781
;4781:				efOrg[0] += boltDir[0]*8;
ADDRLP4 240
ADDRLP4 240
INDIRF4
CNSTF4 1090519040
ADDRLP4 1036
INDIRF4
MULF4
ADDF4
ASGNF4
line 4782
;4782:				efOrg[1] += boltDir[1]*8;
ADDRLP4 240+4
ADDRLP4 240+4
INDIRF4
CNSTF4 1090519040
ADDRLP4 1036+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 4783
;4783:				efOrg[2] += boltDir[2]*8;
ADDRLP4 240+8
ADDRLP4 240+8
INDIRF4
CNSTF4 1090519040
ADDRLP4 1036+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 4784
;4784:				trap_G2API_GiveMeVectorFromMatrix( &lHandMatrix, NEGATIVE_X, boltDir );
ADDRLP4 488
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 1036
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 4785
;4785:				efOrg[0] -= boltDir[0]*4;
ADDRLP4 240
ADDRLP4 240
INDIRF4
CNSTF4 1082130432
ADDRLP4 1036
INDIRF4
MULF4
SUBF4
ASGNF4
line 4786
;4786:				efOrg[1] -= boltDir[1]*4;
ADDRLP4 240+4
ADDRLP4 240+4
INDIRF4
CNSTF4 1082130432
ADDRLP4 1036+4
INDIRF4
MULF4
SUBF4
ASGNF4
line 4787
;4787:				efOrg[2] -= boltDir[2]*4;
ADDRLP4 240+8
ADDRLP4 240+8
INDIRF4
CNSTF4 1082130432
ADDRLP4 1036+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 4789
;4788:
;4789:				efOrg[2] += 8;
ADDRLP4 240+8
ADDRLP4 240+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 4791
;4790:
;4791:				VectorCopy(efOrg, cent->grip_arm.origin);
ADDRFP4 0
INDIRP4
CNSTI4 1744
ADDP4
ADDRLP4 240
INDIRB
ASGNB 12
line 4792
;4792:				VectorCopy(cent->grip_arm.origin, cent->grip_arm.lightingOrigin);
ADDRLP4 1100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1100
INDIRP4
CNSTI4 1800
ADDP4
ADDRLP4 1100
INDIRP4
CNSTI4 1744
ADDP4
INDIRB
ASGNB 12
line 4794
;4793:
;4794:				VectorCopy(cent->lerpAngles, armAng);
ADDRLP4 1064
ADDRFP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 4795
;4795:				armAng[ROLL] = -90;
ADDRLP4 1064+8
CNSTF4 3266576384
ASGNF4
line 4796
;4796:				AnglesToAxis(armAng, cent->grip_arm.axis);
ADDRLP4 1064
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1704
ADDP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 4798
;4797:				
;4798:				trap_G2API_DuplicateGhoul2Instance(cent->ghoul2, &cent->grip_arm.ghoul2);
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 1104
INDIRP4
CNSTI4 1900
ADDP4
ARGP4
ADDRGP4 trap_G2API_DuplicateGhoul2Instance
CALLV
pop
line 4800
;4799:
;4800:				trap_G2API_SetRootSurface(cent->grip_arm.ghoul2, 0, limbName);
ADDRFP4 0
INDIRP4
CNSTI4 1900
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRGP4 trap_G2API_SetRootSurface
CALLI4
pop
line 4801
;4801:				trap_G2API_SetNewOrigin(cent->grip_arm.ghoul2, trap_G2API_AddBolt(cent->grip_arm.ghoul2, 0, rotateBone));
ADDRFP4 0
INDIRP4
CNSTI4 1900
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1076
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1900
ADDP4
INDIRP4
ARGP4
ADDRLP4 1108
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetNewOrigin
CALLI4
pop
line 4802
;4802:				trap_G2API_SetSurfaceOnOff(cent->grip_arm.ghoul2, limbCapName, 0);
ADDRFP4 0
INDIRP4
CNSTI4 1900
ADDP4
INDIRP4
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_G2API_SetSurfaceOnOff
CALLI4
pop
line 4804
;4803:
;4804:				cent->grip_arm.modelScale[0] = 1;//+(wv*6);
ADDRFP4 0
INDIRP4
CNSTI4 1888
ADDP4
CNSTF4 1065353216
ASGNF4
line 4805
;4805:				cent->grip_arm.modelScale[1] = 1;//+(wv*6);
ADDRFP4 0
INDIRP4
CNSTI4 1892
ADDP4
CNSTF4 1065353216
ASGNF4
line 4806
;4806:				cent->grip_arm.modelScale[2] = 1;//+(wv*6);
ADDRFP4 0
INDIRP4
CNSTI4 1896
ADDP4
CNSTF4 1065353216
ASGNF4
line 4807
;4807:				ScaleModelAxis(&cent->grip_arm);
ADDRFP4 0
INDIRP4
CNSTI4 1692
ADDP4
ARGP4
ADDRGP4 ScaleModelAxis
CALLV
pop
line 4809
;4808:
;4809:				cent->grip_arm.radius = 64;
ADDRFP4 0
INDIRP4
CNSTI4 1784
ADDP4
CNSTF4 1115684864
ASGNF4
line 4811
;4810:
;4811:				cent->grip_arm.customShader = trap_R_RegisterShader( "gfx/misc/red_portashield" );
ADDRGP4 $2630
ARGP4
ADDRLP4 1112
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ADDRLP4 1112
INDIRI4
ASGNI4
line 4813
;4812:				
;4813:				cent->grip_arm.renderfx |= RF_RGB_TINT;
ADDRLP4 1116
ADDRFP4 0
INDIRP4
CNSTI4 1696
ADDP4
ASGNP4
ADDRLP4 1116
INDIRP4
ADDRLP4 1116
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 4814
;4814:				cent->grip_arm.shaderRGBA[0] = 255 - (wv*900);
ADDRLP4 1124
CNSTF4 1132396544
CNSTF4 1147207680
ADDRLP4 1060
INDIRF4
MULF4
SUBF4
ASGNF4
ADDRLP4 1128
CNSTF4 1325400064
ASGNF4
ADDRLP4 1124
INDIRF4
ADDRLP4 1128
INDIRF4
LTF4 $2632
ADDRLP4 1120
ADDRLP4 1124
INDIRF4
ADDRLP4 1128
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2633
JUMPV
LABELV $2632
ADDRLP4 1120
ADDRLP4 1124
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2633
ADDRFP4 0
INDIRP4
CNSTI4 1772
ADDP4
ADDRLP4 1120
INDIRU4
CVUU1 4
ASGNU1
line 4815
;4815:				if (cent->grip_arm.shaderRGBA[0] < 30)
ADDRFP4 0
INDIRP4
CNSTI4 1772
ADDP4
INDIRU1
CVUI4 1
CNSTI4 30
GEI4 $2634
line 4816
;4816:				{
line 4817
;4817:					cent->grip_arm.shaderRGBA[0] = 30;
ADDRFP4 0
INDIRP4
CNSTI4 1772
ADDP4
CNSTU1 30
ASGNU1
line 4818
;4818:				}
LABELV $2634
line 4819
;4819:				if (cent->grip_arm.shaderRGBA[0] > 255)
ADDRFP4 0
INDIRP4
CNSTI4 1772
ADDP4
INDIRU1
CVUI4 1
CNSTI4 255
LEI4 $2636
line 4820
;4820:				{
line 4821
;4821:					cent->grip_arm.shaderRGBA[0] = 255;
ADDRFP4 0
INDIRP4
CNSTI4 1772
ADDP4
CNSTU1 255
ASGNU1
line 4822
;4822:				}
LABELV $2636
line 4823
;4823:				cent->grip_arm.shaderRGBA[1] = cent->grip_arm.shaderRGBA[2] = cent->grip_arm.shaderRGBA[0];
ADDRLP4 1132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1136
ADDRLP4 1132
INDIRP4
CNSTI4 1772
ADDP4
INDIRU1
ASGNU1
ADDRLP4 1132
INDIRP4
CNSTI4 1774
ADDP4
ADDRLP4 1136
INDIRU1
ASGNU1
ADDRLP4 1132
INDIRP4
CNSTI4 1773
ADDP4
ADDRLP4 1136
INDIRU1
ASGNU1
line 4825
;4824:				
;4825:				trap_R_AddRefEntityToScene( &cent->grip_arm );
ADDRFP4 0
INDIRP4
CNSTI4 1692
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 4826
;4826:			}
line 4827
;4827:		}
ADDRGP4 $2610
JUMPV
LABELV $2609
line 4828
;4828:		else if (!(cent->currentState.forcePowersActive & (1 << FP_GRIP)))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $2638
line 4829
;4829:		{
line 4830
;4830:			CG_ForcePushBlur( efOrg );
ADDRLP4 240
ARGP4
ADDRGP4 CG_ForcePushBlur
CALLV
pop
line 4831
;4831:		}
LABELV $2638
LABELV $2610
line 4832
;4832:	}
LABELV $2592
line 4834
;4833:
;4834:	if (cent->currentState.weapon == WP_STUN_BATON && cent->currentState.number == cg.snap->ps.clientNum)
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2640
ADDRLP4 1012
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $2640
line 4835
;4835:	{
line 4836
;4836:		trap_S_AddLoopingSound( cent->currentState.number, cg.refdef.vieworg, vec3_origin, 
ADDRGP4 $2645
ARGP4
ADDRLP4 1016
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 cg+3604+24
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 1016
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 4838
;4837:			trap_S_RegisterSound( "sound/weapons/baton/idle.wav" ) );
;4838:	}
LABELV $2640
line 4842
;4839:
;4840:	//NOTE: All effects that should be visible during mindtrick should go above here
;4841:
;4842:	if (iwantout)
ADDRLP4 768
INDIRI4
CNSTI4 0
EQI4 $2646
line 4843
;4843:	{
line 4844
;4844:		goto stillDoSaber;
ADDRGP4 $2648
JUMPV
LABELV $2646
line 4847
;4845:		//return;
;4846:	}
;4847:	else if (doAlpha)
ADDRLP4 828
INDIRI4
CNSTI4 0
EQI4 $2649
line 4848
;4848:	{
line 4849
;4849:		legs.renderfx |= RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 4850
;4850:		legs.shaderRGBA[3] = cent->trickAlpha;
ADDRLP4 0+80+3
ADDRFP4 0
INDIRP4
CNSTI4 1904
ADDP4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 4852
;4851:
;4852:		if (legs.shaderRGBA[3] < 1)
ADDRLP4 0+80+3
INDIRU1
CVUI4 1
CNSTI4 1
GEI4 $2654
line 4853
;4853:		{ //don't cancel it out even if it's < 1
line 4854
;4854:			legs.shaderRGBA[3] = 1;
ADDRLP4 0+80+3
CNSTU1 1
ASGNU1
line 4855
;4855:		}
LABELV $2654
line 4856
;4856:	}
LABELV $2649
line 4858
;4857:
;4858:	if (cent->teamPowerEffectTime > cg.time)
ADDRFP4 0
INDIRP4
CNSTI4 1912
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $2660
line 4859
;4859:	{
line 4863
;4860:		vec4_t preCol;
;4861:		int preRFX;
;4862:
;4863:		preRFX = legs.renderfx;
ADDRLP4 1032
ADDRLP4 0+4
INDIRI4
ASGNI4
line 4865
;4864:
;4865:		legs.renderfx |= RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 4866
;4866:		legs.renderfx |= RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 4868
;4867:
;4868:		preCol[0] = legs.shaderRGBA[0];
ADDRLP4 1016
ADDRLP4 0+80
INDIRU1
CVUI4 1
CVIF4 4
ASGNF4
line 4869
;4869:		preCol[1] = legs.shaderRGBA[1];
ADDRLP4 1016+4
ADDRLP4 0+80+1
INDIRU1
CVUI4 1
CVIF4 4
ASGNF4
line 4870
;4870:		preCol[2] = legs.shaderRGBA[2];
ADDRLP4 1016+8
ADDRLP4 0+80+2
INDIRU1
CVUI4 1
CVIF4 4
ASGNF4
line 4871
;4871:		preCol[3] = legs.shaderRGBA[3];
ADDRLP4 1016+12
ADDRLP4 0+80+3
INDIRU1
CVUI4 1
CVIF4 4
ASGNF4
line 4873
;4872:
;4873:		if (cent->teamPowerType == 1)
ADDRFP4 0
INDIRP4
CNSTI4 1916
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2676
line 4874
;4874:		{ //heal
line 4875
;4875:			legs.shaderRGBA[0] = 0;
ADDRLP4 0+80
CNSTU1 0
ASGNU1
line 4876
;4876:			legs.shaderRGBA[1] = 255;
ADDRLP4 0+80+1
CNSTU1 255
ASGNU1
line 4877
;4877:			legs.shaderRGBA[2] = 0;
ADDRLP4 0+80+2
CNSTU1 0
ASGNU1
line 4878
;4878:		}
ADDRGP4 $2677
JUMPV
LABELV $2676
line 4879
;4879:		else if (cent->teamPowerType == 0)
ADDRFP4 0
INDIRP4
CNSTI4 1916
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2683
line 4880
;4880:		{ //regen
line 4881
;4881:			legs.shaderRGBA[0] = 0;
ADDRLP4 0+80
CNSTU1 0
ASGNU1
line 4882
;4882:			legs.shaderRGBA[1] = 0;
ADDRLP4 0+80+1
CNSTU1 0
ASGNU1
line 4883
;4883:			legs.shaderRGBA[2] = 255;
ADDRLP4 0+80+2
CNSTU1 255
ASGNU1
line 4884
;4884:		}
ADDRGP4 $2684
JUMPV
LABELV $2683
line 4886
;4885:		else
;4886:		{ //drain
line 4887
;4887:			legs.shaderRGBA[0] = 255;
ADDRLP4 0+80
CNSTU1 255
ASGNU1
line 4888
;4888:			legs.shaderRGBA[1] = 0;
ADDRLP4 0+80+1
CNSTU1 0
ASGNU1
line 4889
;4889:			legs.shaderRGBA[2] = 0;
ADDRLP4 0+80+2
CNSTU1 0
ASGNU1
line 4890
;4890:		}
LABELV $2684
LABELV $2677
line 4892
;4891:
;4892:		legs.shaderRGBA[3] = ((cent->teamPowerEffectTime - cg.time)/8);
ADDRLP4 0+80+3
ADDRFP4 0
INDIRP4
CNSTI4 1912
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
CNSTI4 8
DIVI4
CVIU4 4
CVUU1 4
ASGNU1
line 4894
;4893:
;4894:		legs.customShader = trap_R_RegisterShader( "powerups/ysalimarishell" );
ADDRGP4 $2699
ARGP4
ADDRLP4 1036
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0+76
ADDRLP4 1036
INDIRI4
ASGNI4
line 4895
;4895:		trap_R_AddRefEntityToScene(&legs);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 4897
;4896:
;4897:		legs.customShader = 0;
ADDRLP4 0+76
CNSTI4 0
ASGNI4
line 4898
;4898:		legs.renderfx = preRFX;
ADDRLP4 0+4
ADDRLP4 1032
INDIRI4
ASGNI4
line 4899
;4899:		legs.shaderRGBA[0] = preCol[0];
ADDRLP4 1044
ADDRLP4 1016
INDIRF4
ASGNF4
ADDRLP4 1048
CNSTF4 1325400064
ASGNF4
ADDRLP4 1044
INDIRF4
ADDRLP4 1048
INDIRF4
LTF4 $2704
ADDRLP4 1040
ADDRLP4 1044
INDIRF4
ADDRLP4 1048
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2705
JUMPV
LABELV $2704
ADDRLP4 1040
ADDRLP4 1044
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2705
ADDRLP4 0+80
ADDRLP4 1040
INDIRU4
CVUU1 4
ASGNU1
line 4900
;4900:		legs.shaderRGBA[1] = preCol[1];
ADDRLP4 1056
ADDRLP4 1016+4
INDIRF4
ASGNF4
ADDRLP4 1060
CNSTF4 1325400064
ASGNF4
ADDRLP4 1056
INDIRF4
ADDRLP4 1060
INDIRF4
LTF4 $2710
ADDRLP4 1052
ADDRLP4 1056
INDIRF4
ADDRLP4 1060
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2711
JUMPV
LABELV $2710
ADDRLP4 1052
ADDRLP4 1056
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2711
ADDRLP4 0+80+1
ADDRLP4 1052
INDIRU4
CVUU1 4
ASGNU1
line 4901
;4901:		legs.shaderRGBA[2] = preCol[2];
ADDRLP4 1068
ADDRLP4 1016+8
INDIRF4
ASGNF4
ADDRLP4 1072
CNSTF4 1325400064
ASGNF4
ADDRLP4 1068
INDIRF4
ADDRLP4 1072
INDIRF4
LTF4 $2716
ADDRLP4 1064
ADDRLP4 1068
INDIRF4
ADDRLP4 1072
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2717
JUMPV
LABELV $2716
ADDRLP4 1064
ADDRLP4 1068
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2717
ADDRLP4 0+80+2
ADDRLP4 1064
INDIRU4
CVUU1 4
ASGNU1
line 4902
;4902:		legs.shaderRGBA[3] = preCol[3];
ADDRLP4 1080
ADDRLP4 1016+12
INDIRF4
ASGNF4
ADDRLP4 1084
CNSTF4 1325400064
ASGNF4
ADDRLP4 1080
INDIRF4
ADDRLP4 1084
INDIRF4
LTF4 $2722
ADDRLP4 1076
ADDRLP4 1080
INDIRF4
ADDRLP4 1084
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2723
JUMPV
LABELV $2722
ADDRLP4 1076
ADDRLP4 1080
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2723
ADDRLP4 0+80+3
ADDRLP4 1076
INDIRU4
CVUU1 4
ASGNU1
line 4903
;4903:	}
LABELV $2660
line 4906
;4904:
;4905:	//If you've tricked this client.
;4906:	if (CG_IsMindTricked(cg.snap->ps.fd.forceMindtrickTargetIndex,
ADDRGP4 cg+36
INDIRP4
CNSTI4 1188
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1192
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1196
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1200
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 1016
ADDRGP4 CG_IsMindTricked
CALLI4
ASGNI4
ADDRLP4 1016
INDIRI4
CNSTI4 0
EQI4 $2724
line 4911
;4907:		cg.snap->ps.fd.forceMindtrickTargetIndex2,
;4908:		cg.snap->ps.fd.forceMindtrickTargetIndex3,
;4909:		cg.snap->ps.fd.forceMindtrickTargetIndex4,
;4910:		cent->currentState.number))
;4911:	{
line 4912
;4912:		if (cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2730
line 4913
;4913:		{
line 4917
;4914:			vec3_t efOrg;
;4915:			vec3_t tAng, fxAng;
;4916:			vec3_t axis[3];
;4917:			int effectTimeLayerC = effectTimeLayer;
ADDRLP4 1020
ADDRLP4 756
INDIRI4
ASGNI4
line 4921
;4918:			sharedBoltInterface_t fxObj;
;4919:
;4920:			//VectorSet( tAng, 0, cent->pe.torso.yawAngle, 0 );
;4921:			VectorSet( tAng, cent->turAngles[PITCH], cent->turAngles[YAW], cent->turAngles[ROLL] );
ADDRLP4 1152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1128
ADDRLP4 1152
INDIRP4
CNSTI4 1016
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1128+4
ADDRLP4 1152
INDIRP4
CNSTI4 1020
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1128+8
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRF4
ASGNF4
line 4923
;4922:
;4923:			trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_head, &boltMatrix, tAng, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1156
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ADDRLP4 1156
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+520
ADDP4
INDIRI4
ARGI4
ADDRLP4 780
ARGP4
ADDRLP4 1128
ARGP4
ADDRLP4 1156
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 1156
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 4925
;4924:
;4925:			trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, ORIGIN, efOrg);
ADDRLP4 780
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1060
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 4926
;4926:			trap_G2API_GiveMeVectorFromMatrix(&boltMatrix, NEGATIVE_Y, fxAng);
ADDRLP4 780
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 1140
ARGP4
ADDRGP4 trap_G2API_GiveMeVectorFromMatrix
CALLV
pop
line 4928
;4927:
;4928: 			axis[0][0] = boltMatrix.matrix[0][0];
ADDRLP4 1024
ADDRLP4 780
INDIRF4
ASGNF4
line 4929
;4929: 			axis[0][1] = boltMatrix.matrix[1][0];
ADDRLP4 1024+4
ADDRLP4 780+16
INDIRF4
ASGNF4
line 4930
;4930:		 	axis[0][2] = boltMatrix.matrix[2][0];
ADDRLP4 1024+8
ADDRLP4 780+32
INDIRF4
ASGNF4
line 4932
;4931:
;4932: 			axis[1][0] = boltMatrix.matrix[0][1];
ADDRLP4 1024+12
ADDRLP4 780+4
INDIRF4
ASGNF4
line 4933
;4933: 			axis[1][1] = boltMatrix.matrix[1][1];
ADDRLP4 1024+12+4
ADDRLP4 780+16+4
INDIRF4
ASGNF4
line 4934
;4934:		 	axis[1][2] = boltMatrix.matrix[2][1];
ADDRLP4 1024+12+8
ADDRLP4 780+32+4
INDIRF4
ASGNF4
line 4936
;4935:
;4936: 			axis[2][0] = boltMatrix.matrix[0][2];
ADDRLP4 1024+24
ADDRLP4 780+8
INDIRF4
ASGNF4
line 4937
;4937: 			axis[2][1] = boltMatrix.matrix[1][2];
ADDRLP4 1024+24+4
ADDRLP4 780+16+8
INDIRF4
ASGNF4
line 4938
;4938:		 	axis[2][2] = boltMatrix.matrix[2][2];
ADDRLP4 1024+24+8
ADDRLP4 780+32+8
INDIRF4
ASGNF4
line 4940
;4939:
;4940:			VectorCopy(/*efOrg*/cent->lerpOrigin, fxObj.origin);
ADDRLP4 1072+28
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 4941
;4941:			VectorCopy(/*fxAng*/tAng, fxObj.angles);
ADDRLP4 1072+16
ADDRLP4 1128
INDIRB
ASGNB 12
line 4942
;4942:			VectorCopy(cent->modelScale, fxObj.scale);
ADDRLP4 1072+40
ADDRFP4 0
INDIRP4
CNSTI4 964
ADDP4
INDIRB
ASGNB 12
line 4943
;4943:			fxObj.ghoul2 = cent->ghoul2;
ADDRLP4 1072+4
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ASGNP4
line 4944
;4944:			fxObj.isValid = 1;
ADDRLP4 1072
CNSTI4 1
ASGNI4
line 4945
;4945:			fxObj.modelNum = 0;
ADDRLP4 1072+8
CNSTI4 0
ASGNI4
line 4946
;4946:			fxObj.boltNum = cgs.clientinfo[cent->currentState.number].bolt_head;
ADDRLP4 1072+12
CNSTI4 788
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+520
ADDP4
INDIRI4
ASGNI4
line 4947
;4947:			fxObj.entNum = cent->currentState.number;
ADDRLP4 1072+52
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRGP4 $2772
JUMPV
LABELV $2771
line 4950
;4948:	
;4949:			while (effectTimeLayerC > 0)
;4950:			{
line 4951
;4951:				trap_FX_PlayEntityEffectID(trap_FX_RegisterEffect("force/confusion.efx"), efOrg, axis, cent->boltInfo, cent->currentState.number);
ADDRGP4 $2774
ARGP4
ADDRLP4 1160
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 1160
INDIRI4
ARGI4
ADDRLP4 1060
ARGP4
ADDRLP4 1024
ARGP4
ADDRLP4 1164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1164
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
ARGI4
ADDRLP4 1164
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_FX_PlayEntityEffectID
CALLV
pop
line 4957
;4952:
;4953:				//FIXME: Due to the horrible inefficiency involved in the current effect bolt process an effect with as many particles as this won't
;4954:				//work too happily. It also doesn't look a lot better due to the lag between origin updates with the effect bolt. If those issues
;4955:				//are ever resolved it should be switched over to BoltedEffect.
;4956:				//trap_FX_PlayBoltedEffectID(trap_FX_RegisterEffect("force/confusion.efx"), &fxObj);
;4957:				effectTimeLayerC = 0;//-= 50;
ADDRLP4 1020
CNSTI4 0
ASGNI4
line 4958
;4958:			}
LABELV $2772
line 4949
ADDRLP4 1020
INDIRI4
CNSTI4 0
GTI4 $2771
line 4959
;4959:		}
LABELV $2730
line 4960
;4960:	}
LABELV $2724
line 4962
;4961:
;4962:	if (cgs.gametype == GT_HOLOCRON && cent->currentState.time2 && (cg.renderingThirdPerson || cg.snap->ps.clientNum != cent->currentState.number))
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 1
NEI4 $2775
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRLP4 1020
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDRLP4 1024
INDIRI4
EQI4 $2775
ADDRGP4 cg+88
INDIRI4
ADDRLP4 1024
INDIRI4
NEI4 $2780
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRLP4 1020
INDIRP4
INDIRI4
EQI4 $2775
LABELV $2780
line 4963
;4963:	{
line 4964
;4964:		int i = 0;
ADDRLP4 1240
CNSTI4 0
ASGNI4
line 4965
;4965:		int renderedHolos = 0;
ADDRLP4 1244
CNSTI4 0
ASGNI4
ADDRGP4 $2782
JUMPV
LABELV $2781
line 4969
;4966:		refEntity_t		holoRef;
;4967:
;4968:		while (i < NUM_FORCE_POWERS && renderedHolos < 3)
;4969:		{
line 4970
;4970:			if (cent->currentState.time2 & (1 << i))
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 1240
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2784
line 4971
;4971:			{
line 4972
;4972:				memset( &holoRef, 0, sizeof(holoRef) );
ADDRLP4 1028
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4974
;4973:
;4974:				VectorCopy(cent->lerpOrigin, elevated);
ADDRLP4 224
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 4975
;4975:				elevated[2] += 8;
ADDRLP4 224+8
ADDRLP4 224+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 4977
;4976:
;4977:				VectorCopy( elevated, holoRef.lightingOrigin );
ADDRLP4 1028+108
ADDRLP4 224
INDIRB
ASGNB 12
line 4978
;4978:				holoRef.shadowPlane = shadowPlane;
ADDRLP4 1028+120
ADDRLP4 536
INDIRF4
ASGNF4
line 4979
;4979:				holoRef.renderfx = 0;//RF_THIRD_PERSON;
ADDRLP4 1028+4
CNSTI4 0
ASGNI4
line 4981
;4980:
;4981:				if (renderedHolos == 0)
ADDRLP4 1244
INDIRI4
CNSTI4 0
NEI4 $2790
line 4982
;4982:				{
line 4983
;4983:					angle = ((cg.time / 8) & 255) * (M_PI * 2) / 255;
ADDRLP4 236
CNSTF4 1086918619
ADDRGP4 cg+64
INDIRI4
CNSTI4 8
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
ASGNF4
line 4984
;4984:					dir[0] = cos(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 1248
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 212
CNSTF4 1101004800
ADDRLP4 1248
INDIRF4
MULF4
ASGNF4
line 4985
;4985:					dir[1] = sin(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 1252
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 212+4
CNSTF4 1101004800
ADDRLP4 1252
INDIRF4
MULF4
ASGNF4
line 4986
;4986:					dir[2] = cos(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 1256
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 212+8
CNSTF4 1101004800
ADDRLP4 1256
INDIRF4
MULF4
ASGNF4
line 4987
;4987:					VectorAdd(elevated, dir, holoRef.origin);
ADDRLP4 1028+52
ADDRLP4 224
INDIRF4
ADDRLP4 212
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1028+52+4
ADDRLP4 224+4
INDIRF4
ADDRLP4 212+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1028+52+8
ADDRLP4 224+8
INDIRF4
ADDRLP4 212+8
INDIRF4
ADDF4
ASGNF4
line 4989
;4988:
;4989:					angles[0] = sin(angle) * 30;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 1260
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 252
CNSTF4 1106247680
ADDRLP4 1260
INDIRF4
MULF4
ASGNF4
line 4990
;4990:					angles[1] = (angle * 180 / M_PI) + 90;
ADDRLP4 252+4
CNSTF4 1127481344
ADDRLP4 236
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 4991
;4991:					if (angles[1] > 360)
ADDRLP4 252+4
INDIRF4
CNSTF4 1135869952
LEF4 $2805
line 4992
;4992:						angles[1] -= 360;
ADDRLP4 252+4
ADDRLP4 252+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $2805
line 4993
;4993:					angles[2] = 0;
ADDRLP4 252+8
CNSTF4 0
ASGNF4
line 4994
;4994:					AnglesToAxis( angles, holoRef.axis );
ADDRLP4 252
ARGP4
ADDRLP4 1028+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 4995
;4995:				}
ADDRGP4 $2791
JUMPV
LABELV $2790
line 4996
;4996:				else if (renderedHolos == 1)
ADDRLP4 1244
INDIRI4
CNSTI4 1
NEI4 $2811
line 4997
;4997:				{
line 4998
;4998:					angle = ((cg.time / 8) & 255) * (M_PI * 2) / 255 + M_PI;
ADDRLP4 236
CNSTF4 1086918619
ADDRGP4 cg+64
INDIRI4
CNSTI4 8
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
CNSTF4 1078530011
ADDF4
ASGNF4
line 4999
;4999:					if (angle > M_PI * 2)
ADDRLP4 236
INDIRF4
CNSTF4 1086918619
LEF4 $2814
line 5000
;5000:						angle -= (float)M_PI * 2;
ADDRLP4 236
ADDRLP4 236
INDIRF4
CNSTF4 1086918619
SUBF4
ASGNF4
LABELV $2814
line 5001
;5001:					dir[0] = sin(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 1248
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 212
CNSTF4 1101004800
ADDRLP4 1248
INDIRF4
MULF4
ASGNF4
line 5002
;5002:					dir[1] = cos(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 1252
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 212+4
CNSTF4 1101004800
ADDRLP4 1252
INDIRF4
MULF4
ASGNF4
line 5003
;5003:					dir[2] = cos(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 1256
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 212+8
CNSTF4 1101004800
ADDRLP4 1256
INDIRF4
MULF4
ASGNF4
line 5004
;5004:					VectorAdd(elevated, dir, holoRef.origin);
ADDRLP4 1028+52
ADDRLP4 224
INDIRF4
ADDRLP4 212
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1028+52+4
ADDRLP4 224+4
INDIRF4
ADDRLP4 212+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1028+52+8
ADDRLP4 224+8
INDIRF4
ADDRLP4 212+8
INDIRF4
ADDF4
ASGNF4
line 5006
;5005:
;5006:					angles[0] = cos(angle - 0.5 * M_PI) * 30;
ADDRLP4 236
INDIRF4
CNSTF4 1070141403
SUBF4
ARGF4
ADDRLP4 1260
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 252
CNSTF4 1106247680
ADDRLP4 1260
INDIRF4
MULF4
ASGNF4
line 5007
;5007:					angles[1] = 360 - (angle * 180 / M_PI);
ADDRLP4 252+4
CNSTF4 1135869952
CNSTF4 1127481344
ADDRLP4 236
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
SUBF4
ASGNF4
line 5008
;5008:					if (angles[1] > 360)
ADDRLP4 252+4
INDIRF4
CNSTF4 1135869952
LEF4 $2828
line 5009
;5009:						angles[1] -= 360;
ADDRLP4 252+4
ADDRLP4 252+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $2828
line 5010
;5010:					angles[2] = 0;
ADDRLP4 252+8
CNSTF4 0
ASGNF4
line 5011
;5011:					AnglesToAxis( angles, holoRef.axis );
ADDRLP4 252
ARGP4
ADDRLP4 1028+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 5012
;5012:				}
ADDRGP4 $2812
JUMPV
LABELV $2811
line 5014
;5013:				else
;5014:				{
line 5015
;5015:					angle = ((cg.time / 6) & 255) * (M_PI * 2) / 255 + 0.5 * M_PI;
ADDRLP4 236
CNSTF4 1086918619
ADDRGP4 cg+64
INDIRI4
CNSTI4 6
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
CNSTF4 1070141403
ADDF4
ASGNF4
line 5016
;5016:					if (angle > M_PI * 2)
ADDRLP4 236
INDIRF4
CNSTF4 1086918619
LEF4 $2835
line 5017
;5017:						angle -= (float)M_PI * 2;
ADDRLP4 236
ADDRLP4 236
INDIRF4
CNSTF4 1086918619
SUBF4
ASGNF4
LABELV $2835
line 5018
;5018:					dir[0] = sin(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 1248
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 212
CNSTF4 1101004800
ADDRLP4 1248
INDIRF4
MULF4
ASGNF4
line 5019
;5019:					dir[1] = cos(angle) * 20;
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 1252
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 212+4
CNSTF4 1101004800
ADDRLP4 1252
INDIRF4
MULF4
ASGNF4
line 5020
;5020:					dir[2] = 0;
ADDRLP4 212+8
CNSTF4 0
ASGNF4
line 5021
;5021:					VectorAdd(elevated, dir, holoRef.origin);
ADDRLP4 1028+52
ADDRLP4 224
INDIRF4
ADDRLP4 212
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1028+52+4
ADDRLP4 224+4
INDIRF4
ADDRLP4 212+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1028+52+8
ADDRLP4 224+8
INDIRF4
ADDRLP4 212+8
INDIRF4
ADDF4
ASGNF4
line 5023
;5022:			
;5023:					VectorCopy(dir, holoRef.axis[1]);
ADDRLP4 1028+12+12
ADDRLP4 212
INDIRB
ASGNB 12
line 5024
;5024:					VectorNormalize(holoRef.axis[1]);
ADDRLP4 1028+12+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 5025
;5025:					VectorSet(holoRef.axis[2], 0, 0, 1);
ADDRLP4 1028+12+24
CNSTF4 0
ASGNF4
ADDRLP4 1028+12+24+4
CNSTF4 0
ASGNF4
ADDRLP4 1028+12+24+8
CNSTF4 1065353216
ASGNF4
line 5026
;5026:					CrossProduct(holoRef.axis[1], holoRef.axis[2], holoRef.axis[0]);
ADDRLP4 1028+12+12
ARGP4
ADDRLP4 1028+12+24
ARGP4
ADDRLP4 1028+12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 5027
;5027:				}
LABELV $2812
LABELV $2791
line 5029
;5028:
;5029:				holoRef.modelScale[0] = 0.5;
ADDRLP4 1028+196
CNSTF4 1056964608
ASGNF4
line 5030
;5030:				holoRef.modelScale[1] = 0.5;
ADDRLP4 1028+196+4
CNSTF4 1056964608
ASGNF4
line 5031
;5031:				holoRef.modelScale[2] = 0.5;
ADDRLP4 1028+196+8
CNSTF4 1056964608
ASGNF4
line 5032
;5032:				ScaleModelAxis(&holoRef);
ADDRLP4 1028
ARGP4
ADDRGP4 ScaleModelAxis
CALLV
pop
line 5034
;5033:
;5034:				{
line 5039
;5035:					float wv;
;5036:					addspriteArgStruct_t fxSArgs;
;5037:					vec3_t holoCenter;
;5038:
;5039:					holoCenter[0] = holoRef.origin[0] + holoRef.axis[2][0]*18;
ADDRLP4 1324
ADDRLP4 1028+52
INDIRF4
CNSTF4 1099956224
ADDRLP4 1028+12+24
INDIRF4
MULF4
ADDF4
ASGNF4
line 5040
;5040:					holoCenter[1] = holoRef.origin[1] + holoRef.axis[2][1]*18;
ADDRLP4 1324+4
ADDRLP4 1028+52+4
INDIRF4
CNSTF4 1099956224
ADDRLP4 1028+12+24+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 5041
;5041:					holoCenter[2] = holoRef.origin[2] + holoRef.axis[2][2]*18;
ADDRLP4 1324+8
ADDRLP4 1028+52+8
INDIRF4
CNSTF4 1099956224
ADDRLP4 1028+12+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 5043
;5042:
;5043:					wv = sin( cg.time * 0.004f ) * 0.08f + 0.1f;
CNSTF4 998445679
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 1336
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 1320
CNSTF4 1034147594
ADDRLP4 1336
INDIRF4
MULF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 5045
;5044:
;5045:					VectorCopy(holoCenter, fxSArgs.origin);
ADDRLP4 1248
ADDRLP4 1324
INDIRB
ASGNB 12
line 5046
;5046:					VectorClear(fxSArgs.vel);
ADDRLP4 1340
CNSTF4 0
ASGNF4
ADDRLP4 1248+12+8
ADDRLP4 1340
INDIRF4
ASGNF4
ADDRLP4 1248+12+4
ADDRLP4 1340
INDIRF4
ASGNF4
ADDRLP4 1248+12
ADDRLP4 1340
INDIRF4
ASGNF4
line 5047
;5047:					VectorClear(fxSArgs.accel);
ADDRLP4 1344
CNSTF4 0
ASGNF4
ADDRLP4 1248+24+8
ADDRLP4 1344
INDIRF4
ASGNF4
ADDRLP4 1248+24+4
ADDRLP4 1344
INDIRF4
ASGNF4
ADDRLP4 1248+24
ADDRLP4 1344
INDIRF4
ASGNF4
line 5048
;5048:					fxSArgs.scale = wv*60;
ADDRLP4 1248+36
CNSTF4 1114636288
ADDRLP4 1320
INDIRF4
MULF4
ASGNF4
line 5049
;5049:					fxSArgs.dscale = wv*60;
ADDRLP4 1248+40
CNSTF4 1114636288
ADDRLP4 1320
INDIRF4
MULF4
ASGNF4
line 5050
;5050:					fxSArgs.sAlpha = wv*12;
ADDRLP4 1248+44
CNSTF4 1094713344
ADDRLP4 1320
INDIRF4
MULF4
ASGNF4
line 5051
;5051:					fxSArgs.eAlpha = wv*12;
ADDRLP4 1248+48
CNSTF4 1094713344
ADDRLP4 1320
INDIRF4
MULF4
ASGNF4
line 5052
;5052:					fxSArgs.rotation = 0.0f;
ADDRLP4 1248+52
CNSTF4 0
ASGNF4
line 5053
;5053:					fxSArgs.bounce = 0.0f;
ADDRLP4 1248+56
CNSTF4 0
ASGNF4
line 5054
;5054:					fxSArgs.life = 1.0f;
ADDRLP4 1248+60
CNSTI4 1
ASGNI4
line 5056
;5055:
;5056:					fxSArgs.flags = 0x08000000|0x00000001;
ADDRLP4 1248+68
CNSTI4 134217729
ASGNI4
line 5058
;5057:
;5058:					if (forcePowerDarkLight[i] == FORCE_DARKSIDE)
ADDRLP4 1348
CNSTI4 2
ASGNI4
ADDRLP4 1240
INDIRI4
ADDRLP4 1348
INDIRI4
LSHI4
ADDRGP4 forcePowerDarkLight
ADDP4
INDIRI4
ADDRLP4 1348
INDIRI4
NEI4 $2904
line 5059
;5059:					{ //dark
line 5060
;5060:						fxSArgs.sAlpha *= 3;
ADDRLP4 1248+44
CNSTF4 1077936128
ADDRLP4 1248+44
INDIRF4
MULF4
ASGNF4
line 5061
;5061:						fxSArgs.eAlpha *= 3;
ADDRLP4 1248+48
CNSTF4 1077936128
ADDRLP4 1248+48
INDIRF4
MULF4
ASGNF4
line 5062
;5062:						fxSArgs.shader = cgs.media.redSaberGlowShader;
ADDRLP4 1248+64
ADDRGP4 cgs+70280+116
INDIRI4
ASGNI4
line 5063
;5063:						trap_FX_AddSprite(&fxSArgs);
ADDRLP4 1248
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 5064
;5064:					}
ADDRGP4 $2905
JUMPV
LABELV $2904
line 5065
;5065:					else if (forcePowerDarkLight[i] == FORCE_LIGHTSIDE)
ADDRLP4 1240
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 forcePowerDarkLight
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2911
line 5066
;5066:					{ //light
line 5067
;5067:						fxSArgs.sAlpha *= 1.5;
ADDRLP4 1248+44
CNSTF4 1069547520
ADDRLP4 1248+44
INDIRF4
MULF4
ASGNF4
line 5068
;5068:						fxSArgs.eAlpha *= 1.5;
ADDRLP4 1248+48
CNSTF4 1069547520
ADDRLP4 1248+48
INDIRF4
MULF4
ASGNF4
line 5069
;5069:						fxSArgs.shader = cgs.media.redSaberGlowShader;
ADDRLP4 1248+64
ADDRGP4 cgs+70280+116
INDIRI4
ASGNI4
line 5070
;5070:						trap_FX_AddSprite(&fxSArgs);
ADDRLP4 1248
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 5071
;5071:						fxSArgs.shader = cgs.media.greenSaberGlowShader;
ADDRLP4 1248+64
ADDRGP4 cgs+70280+140
INDIRI4
ASGNI4
line 5072
;5072:						trap_FX_AddSprite(&fxSArgs);
ADDRLP4 1248
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 5073
;5073:						fxSArgs.shader = cgs.media.blueSaberGlowShader;
ADDRLP4 1248+64
ADDRGP4 cgs+70280+148
INDIRI4
ASGNI4
line 5074
;5074:						trap_FX_AddSprite(&fxSArgs);
ADDRLP4 1248
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 5075
;5075:					}
ADDRGP4 $2912
JUMPV
LABELV $2911
line 5077
;5076:					else
;5077:					{ //neutral
line 5078
;5078:						if (i == FP_SABERATTACK ||
ADDRLP4 1240
INDIRI4
CNSTI4 15
EQI4 $2927
ADDRLP4 1240
INDIRI4
CNSTI4 16
EQI4 $2927
ADDRLP4 1240
INDIRI4
CNSTI4 17
NEI4 $2924
LABELV $2927
line 5081
;5079:							i == FP_SABERDEFEND ||
;5080:							i == FP_SABERTHROW)
;5081:						{ //saber power
line 5082
;5082:							fxSArgs.sAlpha *= 1.5;
ADDRLP4 1248+44
CNSTF4 1069547520
ADDRLP4 1248+44
INDIRF4
MULF4
ASGNF4
line 5083
;5083:							fxSArgs.eAlpha *= 1.5;
ADDRLP4 1248+48
CNSTF4 1069547520
ADDRLP4 1248+48
INDIRF4
MULF4
ASGNF4
line 5084
;5084:							fxSArgs.shader = cgs.media.greenSaberGlowShader;
ADDRLP4 1248+64
ADDRGP4 cgs+70280+140
INDIRI4
ASGNI4
line 5085
;5085:							trap_FX_AddSprite(&fxSArgs);
ADDRLP4 1248
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 5086
;5086:						}
ADDRGP4 $2925
JUMPV
LABELV $2924
line 5088
;5087:						else
;5088:						{
line 5089
;5089:							fxSArgs.sAlpha *= 0.5;
ADDRLP4 1248+44
CNSTF4 1056964608
ADDRLP4 1248+44
INDIRF4
MULF4
ASGNF4
line 5090
;5090:							fxSArgs.eAlpha *= 0.5;
ADDRLP4 1248+48
CNSTF4 1056964608
ADDRLP4 1248+48
INDIRF4
MULF4
ASGNF4
line 5091
;5091:							fxSArgs.shader = cgs.media.greenSaberGlowShader;
ADDRLP4 1248+64
ADDRGP4 cgs+70280+140
INDIRI4
ASGNI4
line 5092
;5092:							trap_FX_AddSprite(&fxSArgs);
ADDRLP4 1248
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 5093
;5093:							fxSArgs.shader = cgs.media.blueSaberGlowShader;
ADDRLP4 1248+64
ADDRGP4 cgs+70280+148
INDIRI4
ASGNI4
line 5094
;5094:							trap_FX_AddSprite(&fxSArgs);
ADDRLP4 1248
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 5095
;5095:						}
LABELV $2925
line 5096
;5096:					}
LABELV $2912
LABELV $2905
line 5097
;5097:				}
line 5099
;5098:
;5099:				holoRef.hModel = trap_R_RegisterModel(forceHolocronModels[i]);
ADDRLP4 1240
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 forceHolocronModels
ADDP4
INDIRP4
ARGP4
ADDRLP4 1248
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 1028+8
ADDRLP4 1248
INDIRI4
ASGNI4
line 5100
;5100:				trap_R_AddRefEntityToScene( &holoRef );
ADDRLP4 1028
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5102
;5101:
;5102:				renderedHolos++;
ADDRLP4 1244
ADDRLP4 1244
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5103
;5103:			}
LABELV $2784
line 5104
;5104:			i++;
ADDRLP4 1240
ADDRLP4 1240
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5105
;5105:		}
LABELV $2782
line 4968
ADDRLP4 1240
INDIRI4
CNSTI4 18
GEI4 $2942
ADDRLP4 1244
INDIRI4
CNSTI4 3
LTI4 $2781
LABELV $2942
line 5106
;5106:	}
LABELV $2775
line 5108
;5107:
;5108:	if ((cent->currentState.powerups & (1 << PW_YSALAMIRI)) ||
ADDRLP4 1028
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1032
CNSTI4 0
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 32768
BANDI4
ADDRLP4 1032
INDIRI4
NEI4 $2947
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $2943
ADDRLP4 1028
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 1032
INDIRI4
NEI4 $2947
ADDRLP4 1028
INDIRI4
CNSTI4 32
BANDI4
ADDRLP4 1032
INDIRI4
EQI4 $2943
LABELV $2947
line 5110
;5109:		(cgs.gametype == GT_CTY && ((cent->currentState.powerups & (1 << PW_REDFLAG)) || (cent->currentState.powerups & (1 << PW_BLUEFLAG)))) )
;5110:	{
line 5111
;5111:		if (cgs.gametype == GT_CTY && (cent->currentState.powerups & (1 << PW_REDFLAG)))
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $2948
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2948
line 5112
;5112:		{
line 5113
;5113:			CG_DrawPlayerSphere(cent, cent->lerpOrigin, 1.4, cgs.media.ysaliredShader );
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1036
INDIRP4
CNSTI4 928
ADDP4
ARGP4
CNSTF4 1068708659
ARGF4
ADDRGP4 cgs+70280+584
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerSphere
CALLV
pop
line 5114
;5114:		}
ADDRGP4 $2949
JUMPV
LABELV $2948
line 5115
;5115:		else if (cgs.gametype == GT_CTY && (cent->currentState.powerups & (1 << PW_BLUEFLAG)))
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $2953
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $2953
line 5116
;5116:		{
line 5117
;5117:			CG_DrawPlayerSphere(cent, cent->lerpOrigin, 1.4, cgs.media.ysaliblueShader );
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1036
INDIRP4
CNSTI4 928
ADDP4
ARGP4
CNSTF4 1068708659
ARGF4
ADDRGP4 cgs+70280+588
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerSphere
CALLV
pop
line 5118
;5118:		}
ADDRGP4 $2954
JUMPV
LABELV $2953
line 5120
;5119:		else
;5120:		{
line 5121
;5121:			CG_DrawPlayerSphere(cent, cent->lerpOrigin, 1.4, cgs.media.ysalimariShader );
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1036
INDIRP4
CNSTI4 928
ADDP4
ARGP4
CNSTF4 1068708659
ARGF4
ADDRGP4 cgs+70280+592
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerSphere
CALLV
pop
line 5122
;5122:		}
LABELV $2954
LABELV $2949
line 5123
;5123:	}
LABELV $2943
line 5125
;5124:	
;5125:	if (cent->currentState.powerups & (1 << PW_FORCE_BOON))
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $2960
line 5126
;5126:	{
line 5127
;5127:		CG_DrawPlayerSphere(cent, cent->lerpOrigin, 2.0, cgs.media.boonShader );
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1036
INDIRP4
CNSTI4 928
ADDP4
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 cgs+70280+596
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerSphere
CALLV
pop
line 5128
;5128:	}
LABELV $2960
line 5130
;5129:
;5130:	if (cent->currentState.powerups & (1 << PW_FORCE_ENLIGHTENED_DARK))
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $2964
line 5131
;5131:	{
line 5132
;5132:		CG_DrawPlayerSphere(cent, cent->lerpOrigin, 2.0, cgs.media.endarkenmentShader );
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1036
INDIRP4
CNSTI4 928
ADDP4
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 cgs+70280+600
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerSphere
CALLV
pop
line 5133
;5133:	}
ADDRGP4 $2965
JUMPV
LABELV $2964
line 5134
;5134:	else if (cent->currentState.powerups & (1 << PW_FORCE_ENLIGHTENED_LIGHT))
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $2968
line 5135
;5135:	{
line 5136
;5136:		CG_DrawPlayerSphere(cent, cent->lerpOrigin, 2.0, cgs.media.enlightenmentShader );
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1036
INDIRP4
CNSTI4 928
ADDP4
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 cgs+70280+604
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerSphere
CALLV
pop
line 5137
;5137:	}
LABELV $2968
LABELV $2965
line 5139
;5138:
;5139:	if (cent->currentState.eFlags & EF_INVULNERABLE)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 67108864
BANDI4
CNSTI4 0
EQI4 $2972
line 5140
;5140:	{
line 5141
;5141:		CG_DrawPlayerSphere(cent, cent->lerpOrigin, 1.4, cgs.media.invulnerabilityShader );
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1036
INDIRP4
CNSTI4 928
ADDP4
ARGP4
CNSTF4 1068708659
ARGF4
ADDRGP4 cgs+70280+608
INDIRI4
ARGI4
ADDRGP4 CG_DrawPlayerSphere
CALLV
pop
line 5142
;5142:	}
LABELV $2972
LABELV $2648
line 5144
;5143:stillDoSaber:
;5144:	if (cent->currentState.weapon == WP_SABER && !cent->currentState.shouldtarget)
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2976
ADDRLP4 1036
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2976
line 5145
;5145:	{
line 5146
;5146:		if (!cent->currentState.saberInFlight && !(cent->currentState.eFlags & EF_DEAD))
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1044
CNSTI4 0
ASGNI4
ADDRLP4 1040
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 1044
INDIRI4
NEI4 $2978
ADDRLP4 1040
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 1044
INDIRI4
NEI4 $2978
line 5147
;5147:		{
line 5148
;5148:			if (cg.snap->ps.clientNum == cent->currentState.number)
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $2980
line 5149
;5149:			{
line 5150
;5150:				trap_S_AddLoopingSound( cent->currentState.number, cg.refdef.vieworg, vec3_origin, 
ADDRGP4 $2985
ARGP4
ADDRLP4 1048
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 cg+3604+24
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 1048
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 5152
;5151:					trap_S_RegisterSound( "sound/weapons/saber/saberhum1.wav" ) );
;5152:			}
ADDRGP4 $2981
JUMPV
LABELV $2980
line 5154
;5153:			else
;5154:			{
line 5155
;5155:				trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRGP4 $2985
ARGP4
ADDRLP4 1048
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
INDIRI4
ARGI4
ADDRLP4 1052
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 1048
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 5157
;5156:					trap_S_RegisterSound( "sound/weapons/saber/saberhum1.wav" ) );
;5157:			}
LABELV $2981
line 5158
;5158:		}
LABELV $2978
line 5160
;5159:
;5160:		if (iwantout && !cent->currentState.saberInFlight)
ADDRLP4 1048
CNSTI4 0
ASGNI4
ADDRLP4 768
INDIRI4
ADDRLP4 1048
INDIRI4
EQI4 $2986
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 1048
INDIRI4
NEI4 $2986
line 5161
;5161:		{
line 5162
;5162:			if (cent->currentState.eFlags & EF_DEAD)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2992
line 5163
;5163:			{
line 5164
;5164:				if (cent->ghoul2 && cent->currentState.saberInFlight && g2HasWeapon)
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2992
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1052
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 1056
INDIRI4
EQI4 $2992
ADDRLP4 752
INDIRI4
ADDRLP4 1056
INDIRI4
EQI4 $2992
line 5165
;5165:				{ //special case, kill the saber on a freshly dead player if another source says to.
line 5166
;5166:					trap_G2API_RemoveGhoul2Model(&(cent->ghoul2), 1);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_G2API_RemoveGhoul2Model
CALLI4
pop
line 5167
;5167:					g2HasWeapon = qfalse;
ADDRLP4 752
CNSTI4 0
ASGNI4
line 5168
;5168:				}
line 5169
;5169:			}
line 5171
;5170:			//return;
;5171:			goto endOfCall;
ADDRGP4 $2992
JUMPV
LABELV $2986
line 5174
;5172:		}
;5173:
;5174:		if (cent->currentState.saberInFlight && cent->currentState.saberEntityNum)
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1052
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 1056
INDIRI4
EQI4 $2993
ADDRLP4 1052
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 1056
INDIRI4
EQI4 $2993
line 5175
;5175:		{
line 5178
;5176:			centity_t *saberEnt;
;5177:
;5178:			saberEnt = &cg_entities[cent->currentState.saberEntityNum];
ADDRLP4 1060
CNSTI4 1920
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 5180
;5179:
;5180:			if (/*!cent->bolt4 &&*/ g2HasWeapon)
ADDRLP4 752
INDIRI4
CNSTI4 0
EQI4 $2995
line 5181
;5181:			{ //saber is in flight, do not have it as a standard weapon model
line 5182
;5182:				trap_G2API_RemoveGhoul2Model(&(cent->ghoul2), 1);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_G2API_RemoveGhoul2Model
CALLI4
pop
line 5183
;5183:				g2HasWeapon = qfalse;
ADDRLP4 752
CNSTI4 0
ASGNI4
line 5187
;5184:
;5185:				//cent->bolt4 = 1;
;5186:
;5187:				saberEnt->currentState.pos.trTime = cg.time;
ADDRLP4 1060
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 5188
;5188:				saberEnt->currentState.apos.trTime = cg.time;
ADDRLP4 1060
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 5190
;5189:
;5190:				VectorCopy(saberEnt->currentState.pos.trBase, saberEnt->lerpOrigin);
ADDRLP4 1060
INDIRP4
CNSTI4 928
ADDP4
ADDRLP4 1060
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 5191
;5191:				VectorCopy(saberEnt->currentState.apos.trBase, saberEnt->lerpAngles);
ADDRLP4 1060
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 1060
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 5193
;5192:
;5193:				cent->bolt3 = saberEnt->currentState.apos.trBase[0];
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
ADDRLP4 1060
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 5194
;5194:				cent->bolt2 = 0;
ADDRFP4 0
INDIRP4
CNSTI4 988
ADDP4
CNSTI4 0
ASGNI4
line 5196
;5195:
;5196:				saberEnt->currentState.bolt2 = 123;
ADDRLP4 1060
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 123
ASGNI4
line 5198
;5197:
;5198:				if (saberEnt->ghoul2)
ADDRLP4 1060
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2999
line 5199
;5199:				{
line 5201
;5200:					// now set up the gun bolt on it
;5201:					trap_G2API_AddBolt(saberEnt->ghoul2, 0, "*flash");
ADDRLP4 1060
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $3001
ARGP4
ADDRGP4 trap_G2API_AddBolt
CALLI4
pop
line 5202
;5202:				}
ADDRGP4 $3000
JUMPV
LABELV $2999
line 5204
;5203:				else
;5204:				{
line 5205
;5205:					trap_G2API_InitGhoul2Model(&saberEnt->ghoul2, "models/weapons2/saber/saber_w.glm", 0, 0, 0, 0, 0);
ADDRLP4 1060
INDIRP4
CNSTI4 952
ADDP4
ARGP4
ADDRGP4 $3002
ARGP4
ADDRLP4 1072
CNSTI4 0
ASGNI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 trap_G2API_InitGhoul2Model
CALLI4
pop
line 5207
;5206:
;5207:					if (saberEnt->ghoul2)
ADDRLP4 1060
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3003
line 5208
;5208:					{
line 5209
;5209:						trap_G2API_AddBolt(saberEnt->ghoul2, 0, "*flash");
ADDRLP4 1060
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $3001
ARGP4
ADDRGP4 trap_G2API_AddBolt
CALLI4
pop
line 5212
;5210:						//cent->bolt4 = 2;
;5211:						
;5212:						VectorCopy(saberEnt->currentState.pos.trBase, saberEnt->lerpOrigin);
ADDRLP4 1060
INDIRP4
CNSTI4 928
ADDP4
ADDRLP4 1060
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 5213
;5213:						VectorCopy(saberEnt->currentState.apos.trBase, saberEnt->lerpAngles);
ADDRLP4 1060
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 1060
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 5214
;5214:						saberEnt->currentState.pos.trTime = cg.time;
ADDRLP4 1060
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 5215
;5215:						saberEnt->currentState.apos.trTime = cg.time;
ADDRLP4 1060
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 5216
;5216:					}
LABELV $3003
line 5217
;5217:				}
LABELV $3000
line 5218
;5218:			}
LABELV $2995
line 5228
;5219:			/*else if (cent->bolt4 != 2)
;5220:			{
;5221:				if (saberEnt->ghoul2)
;5222:				{
;5223:					trap_G2API_AddBolt(saberEnt->ghoul2, 0, "*flash");
;5224:					cent->bolt4 = 2;
;5225:				}
;5226:			}*/
;5227:
;5228:			if (saberEnt && saberEnt->ghoul2 /*&& cent->bolt4 == 2*/)
ADDRLP4 1068
CNSTU4 0
ASGNU4
ADDRLP4 1060
INDIRP4
CVPU4 4
ADDRLP4 1068
INDIRU4
EQU4 $2977
ADDRLP4 1060
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1068
INDIRU4
EQU4 $2977
line 5229
;5229:			{
line 5232
;5230:				vec3_t bladeAngles;
;5231:
;5232:				if (!cent->bolt2)
ADDRFP4 0
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3009
line 5233
;5233:				{
line 5234
;5234:					cent->bolt2 = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 988
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 5235
;5235:				}
LABELV $3009
line 5237
;5236:
;5237:				if (cent->bolt3 != 90)
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 90
EQI4 $3012
line 5238
;5238:				{
line 5239
;5239:					if (cent->bolt3 < 90)
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 90
GEI4 $3014
line 5240
;5240:					{
line 5241
;5241:						cent->bolt3 += (cg.time - cent->bolt2)*0.5;
ADDRLP4 1084
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
ADDRLP4 1084
INDIRP4
CNSTI4 992
ADDP4
ASGNP4
ADDRLP4 1088
INDIRP4
ADDRLP4 1088
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1056964608
ADDRGP4 cg+64
INDIRI4
ADDRLP4 1084
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 5243
;5242:
;5243:						if (cent->bolt3 > 90)
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 90
LEI4 $3015
line 5244
;5244:						{
line 5245
;5245:							cent->bolt3 = 90;
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 90
ASGNI4
line 5246
;5246:						}
line 5247
;5247:					}
ADDRGP4 $3015
JUMPV
LABELV $3014
line 5248
;5248:					else if (cent->bolt3 > 90)
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 90
LEI4 $3019
line 5249
;5249:					{
line 5250
;5250:						cent->bolt3 -= (cg.time - cent->bolt2)*0.5;
ADDRLP4 1084
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
ADDRLP4 1084
INDIRP4
CNSTI4 992
ADDP4
ASGNP4
ADDRLP4 1088
INDIRP4
ADDRLP4 1088
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1056964608
ADDRGP4 cg+64
INDIRI4
ADDRLP4 1084
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
SUBF4
CVFI4 4
ASGNI4
line 5252
;5251:
;5252:						if (cent->bolt3 < 90)
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 90
GEI4 $3022
line 5253
;5253:						{
line 5254
;5254:							cent->bolt3 = 90;
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 90
ASGNI4
line 5255
;5255:						}
LABELV $3022
line 5256
;5256:					}
LABELV $3019
LABELV $3015
line 5257
;5257:				}
LABELV $3012
line 5259
;5258:
;5259:				cent->bolt2 = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 988
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 5261
;5260:
;5261:				saberEnt->currentState.apos.trBase[0] = cent->bolt3;
ADDRLP4 1060
INDIRP4
CNSTI4 60
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 5262
;5262:				saberEnt->lerpAngles[0] = cent->bolt3;
ADDRLP4 1060
INDIRP4
CNSTI4 940
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 5264
;5263:
;5264:				if (!saberEnt->currentState.saberInFlight && saberEnt->currentState.bolt2 != 123)
ADDRLP4 1060
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3025
ADDRLP4 1060
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 123
EQI4 $3025
line 5265
;5265:				{ //owner is pulling is back
line 5268
;5266:					vec3_t owndir;
;5267:
;5268:					VectorSubtract(saberEnt->lerpOrigin, cent->lerpOrigin, owndir);
ADDRLP4 1104
CNSTI4 928
ASGNI4
ADDRLP4 1108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
ADDRLP4 1060
INDIRP4
ADDRLP4 1104
INDIRI4
ADDP4
INDIRF4
ADDRLP4 1108
INDIRP4
ADDRLP4 1104
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1112
CNSTI4 932
ASGNI4
ADDRLP4 1088+4
ADDRLP4 1060
INDIRP4
ADDRLP4 1112
INDIRI4
ADDP4
INDIRF4
ADDRLP4 1108
INDIRP4
ADDRLP4 1112
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1116
CNSTI4 936
ASGNI4
ADDRLP4 1088+8
ADDRLP4 1060
INDIRP4
ADDRLP4 1116
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 1116
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5269
;5269:					VectorNormalize(owndir);
ADDRLP4 1088
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 5271
;5270:
;5271:					vectoangles(owndir, owndir);
ADDRLP4 1088
ARGP4
ADDRLP4 1088
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 5273
;5272:
;5273:					owndir[0] += 90;
ADDRLP4 1088
ADDRLP4 1088
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 5275
;5274:
;5275:					VectorCopy(owndir, saberEnt->currentState.apos.trBase);
ADDRLP4 1060
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 1088
INDIRB
ASGNB 12
line 5276
;5276:					VectorCopy(owndir, saberEnt->lerpAngles);
ADDRLP4 1060
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 1088
INDIRB
ASGNB 12
line 5277
;5277:					VectorClear(saberEnt->currentState.apos.trDelta);
ADDRLP4 1124
CNSTF4 0
ASGNF4
ADDRLP4 1060
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 1124
INDIRF4
ASGNF4
ADDRLP4 1060
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 1124
INDIRF4
ASGNF4
ADDRLP4 1060
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 1124
INDIRF4
ASGNF4
line 5278
;5278:				}
LABELV $3025
line 5283
;5279:
;5280:				//We don't actually want to rely entirely on server updates to render the position of the saber, because we actually know generally where
;5281:				//it's going to be before the first position update even gets here, and it needs to start getting rendered the instant the saber model is
;5282:				//removed from the player hand. So we'll just render it manually and let normal rendering for the entity be ignored.
;5283:				if (!saberEnt->currentState.saberInFlight && saberEnt->currentState.bolt2 != 123)
ADDRLP4 1060
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3029
ADDRLP4 1060
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 123
EQI4 $3029
line 5284
;5284:				{ //tell it that we're a saber and to render the glow around our handle because we're being pulled back
line 5285
;5285:					saberEnt->bolt3 = 999;
ADDRLP4 1060
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 999
ASGNI4
line 5286
;5286:				}
LABELV $3029
line 5288
;5287:
;5288:				saberEnt->currentState.modelGhoul2 = 1;
ADDRLP4 1060
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 1
ASGNI4
line 5289
;5289:				CG_ManualEntityRender(saberEnt);
ADDRLP4 1060
INDIRP4
ARGP4
ADDRGP4 CG_ManualEntityRender
CALLV
pop
line 5290
;5290:				saberEnt->bolt3 = 0;
ADDRLP4 1060
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 0
ASGNI4
line 5291
;5291:				saberEnt->currentState.modelGhoul2 = 127;
ADDRLP4 1060
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 127
ASGNI4
line 5293
;5292:
;5293:				VectorCopy(saberEnt->lerpAngles, bladeAngles);
ADDRLP4 1072
ADDRLP4 1060
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 5294
;5294:				bladeAngles[ROLL] = 0;
ADDRLP4 1072+8
CNSTF4 0
ASGNF4
line 5295
;5295:				CG_AddSaberBlade(cent, saberEnt, NULL, 0, 0, saberEnt->lerpOrigin, bladeAngles, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1060
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 1096
CNSTI4 0
ASGNI4
ADDRLP4 1096
INDIRI4
ARGI4
ADDRLP4 1096
INDIRI4
ARGI4
ADDRLP4 1060
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 1072
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_AddSaberBlade
CALLV
pop
line 5298
;5296:
;5297:				//Make the player's hand glow while guiding the saber
;5298:				{
line 5303
;5299:					vec3_t tAng;
;5300:					float wv;
;5301:					addspriteArgStruct_t fxSArgs;
;5302:
;5303:					VectorSet( tAng, cent->turAngles[PITCH], cent->turAngles[YAW], cent->turAngles[ROLL] );
ADDRLP4 1188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1172
ADDRLP4 1188
INDIRP4
CNSTI4 1016
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1172+4
ADDRLP4 1188
INDIRP4
CNSTI4 1020
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1172+8
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRF4
ASGNF4
line 5305
;5304:
;5305:					trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cgs.clientinfo[cent->currentState.number].bolt_rhand, &boltMatrix, tAng, cent->lerpOrigin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 1192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1192
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 788
ADDRLP4 1192
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+512
ADDP4
INDIRI4
ARGI4
ADDRLP4 780
ARGP4
ADDRLP4 1172
ARGP4
ADDRLP4 1192
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 1192
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 5307
;5306:
;5307:					efOrg[0] = boltMatrix.matrix[0][3];
ADDRLP4 240
ADDRLP4 780+12
INDIRF4
ASGNF4
line 5308
;5308:					efOrg[1] = boltMatrix.matrix[1][3];
ADDRLP4 240+4
ADDRLP4 780+16+12
INDIRF4
ASGNF4
line 5309
;5309:					efOrg[2] = boltMatrix.matrix[2][3];
ADDRLP4 240+8
ADDRLP4 780+32+12
INDIRF4
ASGNF4
line 5311
;5310:
;5311:					wv = sin( cg.time * 0.003f ) * 0.08f + 0.1f;
CNSTF4 994352038
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 1196
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 1184
CNSTF4 1034147594
ADDRLP4 1196
INDIRF4
MULF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 5314
;5312:
;5313:					//trap_FX_AddSprite( NULL, efOrg, NULL, NULL, 8.0f, 8.0f, wv, wv, 0.0f, 0.0f, 1.0f, cgs.media.yellowSaberGlowShader, 0x08000000 );
;5314:					VectorCopy(efOrg, fxSArgs.origin);
ADDRLP4 1100
ADDRLP4 240
INDIRB
ASGNB 12
line 5315
;5315:					VectorClear(fxSArgs.vel);
ADDRLP4 1200
CNSTF4 0
ASGNF4
ADDRLP4 1100+12+8
ADDRLP4 1200
INDIRF4
ASGNF4
ADDRLP4 1100+12+4
ADDRLP4 1200
INDIRF4
ASGNF4
ADDRLP4 1100+12
ADDRLP4 1200
INDIRF4
ASGNF4
line 5316
;5316:					VectorClear(fxSArgs.accel);
ADDRLP4 1204
CNSTF4 0
ASGNF4
ADDRLP4 1100+24+8
ADDRLP4 1204
INDIRF4
ASGNF4
ADDRLP4 1100+24+4
ADDRLP4 1204
INDIRF4
ASGNF4
ADDRLP4 1100+24
ADDRLP4 1204
INDIRF4
ASGNF4
line 5317
;5317:					fxSArgs.scale = 8.0f;
ADDRLP4 1100+36
CNSTF4 1090519040
ASGNF4
line 5318
;5318:					fxSArgs.dscale = 8.0f;
ADDRLP4 1100+40
CNSTF4 1090519040
ASGNF4
line 5319
;5319:					fxSArgs.sAlpha = wv;
ADDRLP4 1100+44
ADDRLP4 1184
INDIRF4
ASGNF4
line 5320
;5320:					fxSArgs.eAlpha = wv;
ADDRLP4 1100+48
ADDRLP4 1184
INDIRF4
ASGNF4
line 5321
;5321:					fxSArgs.rotation = 0.0f;
ADDRLP4 1100+52
CNSTF4 0
ASGNF4
line 5322
;5322:					fxSArgs.bounce = 0.0f;
ADDRLP4 1100+56
CNSTF4 0
ASGNF4
line 5323
;5323:					fxSArgs.life = 1.0f;
ADDRLP4 1100+60
CNSTI4 1
ASGNI4
line 5324
;5324:					fxSArgs.shader = cgs.media.yellowDroppedSaberShader;
ADDRLP4 1100+64
ADDRGP4 cgs+70280+168
INDIRI4
ASGNI4
line 5325
;5325:					fxSArgs.flags = 0x08000000;
ADDRLP4 1100+68
CNSTI4 134217728
ASGNI4
line 5326
;5326:					trap_FX_AddSprite(&fxSArgs);
ADDRLP4 1100
ARGP4
ADDRGP4 trap_FX_AddSprite
CALLV
pop
line 5327
;5327:				}
line 5328
;5328:			}
line 5329
;5329:		}
ADDRGP4 $2977
JUMPV
LABELV $2993
line 5331
;5330:		else
;5331:		{
line 5334
;5332:			centity_t *saberEnt;
;5333:
;5334:			saberEnt = &cg_entities[cent->currentState.saberEntityNum];
ADDRLP4 1060
CNSTI4 1920
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 5336
;5335:
;5336:			if (/*cent->bolt4 && */!g2HasWeapon)
ADDRLP4 752
INDIRI4
CNSTI4 0
NEI4 $3067
line 5337
;5337:			{
line 5338
;5338:				trap_G2API_CopySpecificGhoul2Model(g2WeaponInstances[WP_SABER], 0, cent->ghoul2, 1);
ADDRGP4 g2WeaponInstances+8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_G2API_CopySpecificGhoul2Model
CALLV
pop
line 5340
;5339:
;5340:				if (saberEnt && saberEnt->ghoul2)
ADDRLP4 1064
ADDRLP4 1060
INDIRP4
ASGNP4
ADDRLP4 1068
CNSTU4 0
ASGNU4
ADDRLP4 1064
INDIRP4
CVPU4 4
ADDRLP4 1068
INDIRU4
EQU4 $3070
ADDRLP4 1064
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1068
INDIRU4
EQU4 $3070
line 5341
;5341:				{
line 5342
;5342:					trap_G2API_CleanGhoul2Models(&(saberEnt->ghoul2));
ADDRLP4 1060
INDIRP4
CNSTI4 952
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 5343
;5343:				}
LABELV $3070
line 5345
;5344:
;5345:				saberEnt->currentState.modelindex = 0;
ADDRLP4 1060
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 0
ASGNI4
line 5346
;5346:				saberEnt->ghoul2 = NULL;
ADDRLP4 1060
INDIRP4
CNSTI4 952
ADDP4
CNSTP4 0
ASGNP4
line 5347
;5347:				VectorClear(saberEnt->currentState.pos.trBase);
ADDRLP4 1072
ADDRLP4 1060
INDIRP4
ASGNP4
ADDRLP4 1076
CNSTF4 0
ASGNF4
ADDRLP4 1072
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 1076
INDIRF4
ASGNF4
ADDRLP4 1072
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 1076
INDIRF4
ASGNF4
ADDRLP4 1072
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 1076
INDIRF4
ASGNF4
line 5348
;5348:			}
LABELV $3067
line 5349
;5349:			CG_AddSaberBlade( cent, cent, NULL, 0, 0, legs.origin, rootAngles, qfalse);
ADDRLP4 1064
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRLP4 1064
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 1068
CNSTI4 0
ASGNI4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRLP4 0+52
ARGP4
ADDRLP4 848
ARGP4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 CG_AddSaberBlade
CALLV
pop
line 5350
;5350:			cent->bolt3 = 0;
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 0
ASGNI4
line 5351
;5351:			cent->bolt2 = 0;
ADDRFP4 0
INDIRP4
CNSTI4 988
ADDP4
CNSTI4 0
ASGNI4
line 5354
;5352:
;5353:			//cent->bolt4 = 0;
;5354:		}
line 5355
;5355:	}
ADDRGP4 $2977
JUMPV
LABELV $2976
line 5357
;5356:	else
;5357:	{
line 5358
;5358:		cent->saberLength = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 0
ASGNF4
line 5359
;5359:	}
LABELV $2977
line 5361
;5360:
;5361:	if (cent->currentState.eFlags & EF_DEAD)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $3073
line 5362
;5362:	{
line 5363
;5363:		if (cent->ghoul2 && cent->currentState.saberInFlight && g2HasWeapon)
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3075
ADDRLP4 1044
CNSTI4 0
ASGNI4
ADDRLP4 1040
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 1044
INDIRI4
EQI4 $3075
ADDRLP4 752
INDIRI4
ADDRLP4 1044
INDIRI4
EQI4 $3075
line 5364
;5364:		{ //special case, kill the saber on a freshly dead player if another source says to.
line 5365
;5365:			trap_G2API_RemoveGhoul2Model(&(cent->ghoul2), 1);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_G2API_RemoveGhoul2Model
CALLI4
pop
line 5366
;5366:			g2HasWeapon = qfalse;
ADDRLP4 752
CNSTI4 0
ASGNI4
line 5367
;5367:		}
LABELV $3075
line 5368
;5368:	}
LABELV $3073
line 5370
;5369:
;5370:	if (iwantout)
ADDRLP4 768
INDIRI4
CNSTI4 0
EQI4 $3077
line 5371
;5371:	{
line 5373
;5372:		//return;
;5373:		goto endOfCall;
ADDRGP4 $2992
JUMPV
LABELV $3077
line 5376
;5374:	}
;5375:
;5376:	if ((cg.snap->ps.fd.forcePowersActive & (1 << FP_SEE)) && cg.snap->ps.clientNum != cent->currentState.number)
ADDRGP4 cg+36
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $3079
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
EQI4 $3079
line 5377
;5377:	{
line 5378
;5378:		legs.shaderRGBA[0] = 255;
ADDRLP4 0+80
CNSTU1 255
ASGNU1
line 5379
;5379:		legs.shaderRGBA[1] = 255;
ADDRLP4 0+80+1
CNSTU1 255
ASGNU1
line 5380
;5380:		legs.shaderRGBA[2] = 0;
ADDRLP4 0+80+2
CNSTU1 0
ASGNU1
line 5381
;5381:		legs.renderfx |= RF_MINLIGHT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 5382
;5382:	}
LABELV $3079
line 5384
;5383:
;5384:	if (cg.snap->ps.duelInProgress /*&& cent->currentState.number != cg.snap->ps.clientNum*/)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3089
line 5385
;5385:	{ //I guess go ahead and glow your own client too in a duel
line 5386
;5386:		if (cent->currentState.number != cg.snap->ps.duelIndex &&
ADDRLP4 1040
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 1040
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1328
ADDP4
INDIRI4
EQI4 $3092
ADDRLP4 1040
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
EQI4 $3092
line 5388
;5387:			cent->currentState.number != cg.snap->ps.clientNum)
;5388:		{ //everyone not involved in the duel is drawn very dark
line 5389
;5389:			legs.shaderRGBA[0] = 50;
ADDRLP4 0+80
CNSTU1 50
ASGNU1
line 5390
;5390:			legs.shaderRGBA[1] = 50;
ADDRLP4 0+80+1
CNSTU1 50
ASGNU1
line 5391
;5391:			legs.shaderRGBA[2] = 50;
ADDRLP4 0+80+2
CNSTU1 50
ASGNU1
line 5392
;5392:			legs.renderfx |= RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 5393
;5393:		}
ADDRGP4 $3090
JUMPV
LABELV $3092
line 5395
;5394:		else
;5395:		{ //adjust the glow by how far away you are from your dueling partner
line 5398
;5396:			centity_t *duelEnt;
;5397:
;5398:			duelEnt = &cg_entities[cg.snap->ps.duelIndex];
ADDRLP4 1044
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 1328
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 5400
;5399:			
;5400:			if (duelEnt)
ADDRLP4 1044
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3090
line 5401
;5401:			{
line 5403
;5402:				vec3_t vecSub;
;5403:				float subLen = 0;
ADDRLP4 1048
CNSTF4 0
ASGNF4
line 5405
;5404:
;5405:				VectorSubtract(duelEnt->lerpOrigin, cg.snap->ps.origin, vecSub);
ADDRLP4 1064
ADDRLP4 1044
INDIRP4
ASGNP4
ADDRLP4 1052
ADDRLP4 1064
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
ADDRLP4 1052+4
ADDRLP4 1064
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
ADDRLP4 1052+8
ADDRLP4 1044
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
line 5406
;5406:				subLen = VectorLength(vecSub);
ADDRLP4 1052
ARGP4
ADDRLP4 1068
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 1048
ADDRLP4 1068
INDIRF4
ASGNF4
line 5408
;5407:
;5408:				if (subLen < 1)
ADDRLP4 1048
INDIRF4
CNSTF4 1065353216
GEF4 $3110
line 5409
;5409:				{
line 5410
;5410:					subLen = 1;
ADDRLP4 1048
CNSTF4 1065353216
ASGNF4
line 5411
;5411:				}
LABELV $3110
line 5413
;5412:
;5413:				if (subLen > 1020)
ADDRLP4 1048
INDIRF4
CNSTF4 1149173760
LEF4 $3112
line 5414
;5414:				{
line 5415
;5415:					subLen = 1020;
ADDRLP4 1048
CNSTF4 1149173760
ASGNF4
line 5416
;5416:				}
LABELV $3112
line 5418
;5417:
;5418:				legs.shaderRGBA[0] = 255 - subLen/4;
ADDRLP4 1076
CNSTF4 1132396544
ADDRLP4 1048
INDIRF4
CNSTF4 1082130432
DIVF4
SUBF4
ASGNF4
ADDRLP4 1080
CNSTF4 1325400064
ASGNF4
ADDRLP4 1076
INDIRF4
ADDRLP4 1080
INDIRF4
LTF4 $3116
ADDRLP4 1072
ADDRLP4 1076
INDIRF4
ADDRLP4 1080
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $3117
JUMPV
LABELV $3116
ADDRLP4 1072
ADDRLP4 1076
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $3117
ADDRLP4 0+80
ADDRLP4 1072
INDIRU4
CVUU1 4
ASGNU1
line 5419
;5419:				legs.shaderRGBA[1] = 255 - subLen/4;
ADDRLP4 1088
CNSTF4 1132396544
ADDRLP4 1048
INDIRF4
CNSTF4 1082130432
DIVF4
SUBF4
ASGNF4
ADDRLP4 1092
CNSTF4 1325400064
ASGNF4
ADDRLP4 1088
INDIRF4
ADDRLP4 1092
INDIRF4
LTF4 $3121
ADDRLP4 1084
ADDRLP4 1088
INDIRF4
ADDRLP4 1092
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $3122
JUMPV
LABELV $3121
ADDRLP4 1084
ADDRLP4 1088
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $3122
ADDRLP4 0+80+1
ADDRLP4 1084
INDIRU4
CVUU1 4
ASGNU1
line 5420
;5420:				legs.shaderRGBA[2] = 255 - subLen/4;
ADDRLP4 1100
CNSTF4 1132396544
ADDRLP4 1048
INDIRF4
CNSTF4 1082130432
DIVF4
SUBF4
ASGNF4
ADDRLP4 1104
CNSTF4 1325400064
ASGNF4
ADDRLP4 1100
INDIRF4
ADDRLP4 1104
INDIRF4
LTF4 $3126
ADDRLP4 1096
ADDRLP4 1100
INDIRF4
ADDRLP4 1104
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $3127
JUMPV
LABELV $3126
ADDRLP4 1096
ADDRLP4 1100
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $3127
ADDRLP4 0+80+2
ADDRLP4 1096
INDIRU4
CVUU1 4
ASGNU1
line 5422
;5421:
;5422:				if (legs.shaderRGBA[2] < 1) legs.shaderRGBA[2] = 1;
ADDRLP4 0+80+2
INDIRU1
CVUI4 1
CNSTI4 1
GEI4 $3128
ADDRLP4 0+80+2
CNSTU1 1
ASGNU1
LABELV $3128
line 5424
;5423:
;5424:				legs.renderfx &= ~RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 5425
;5425:				legs.renderfx &= ~RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 5426
;5426:				legs.customShader = cgs.media.forceShell;
ADDRLP4 0+76
ADDRGP4 cgs+70280+508
INDIRI4
ASGNI4
line 5428
;5427:		
;5428:				trap_R_AddRefEntityToScene( &legs );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5430
;5429:
;5430:				legs.customShader = 0;
ADDRLP4 0+76
CNSTI4 0
ASGNI4
line 5432
;5431:
;5432:				legs.shaderRGBA[0] = 255 - subLen/8;
ADDRLP4 1112
CNSTF4 1132396544
ADDRLP4 1048
INDIRF4
CNSTF4 1090519040
DIVF4
SUBF4
ASGNF4
ADDRLP4 1116
CNSTF4 1325400064
ASGNF4
ADDRLP4 1112
INDIRF4
ADDRLP4 1116
INDIRF4
LTF4 $3142
ADDRLP4 1108
ADDRLP4 1112
INDIRF4
ADDRLP4 1116
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $3143
JUMPV
LABELV $3142
ADDRLP4 1108
ADDRLP4 1112
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $3143
ADDRLP4 0+80
ADDRLP4 1108
INDIRU4
CVUU1 4
ASGNU1
line 5433
;5433:				legs.shaderRGBA[1] = 255 - subLen/8;
ADDRLP4 1124
CNSTF4 1132396544
ADDRLP4 1048
INDIRF4
CNSTF4 1090519040
DIVF4
SUBF4
ASGNF4
ADDRLP4 1128
CNSTF4 1325400064
ASGNF4
ADDRLP4 1124
INDIRF4
ADDRLP4 1128
INDIRF4
LTF4 $3147
ADDRLP4 1120
ADDRLP4 1124
INDIRF4
ADDRLP4 1128
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $3148
JUMPV
LABELV $3147
ADDRLP4 1120
ADDRLP4 1124
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $3148
ADDRLP4 0+80+1
ADDRLP4 1120
INDIRU4
CVUU1 4
ASGNU1
line 5434
;5434:				legs.shaderRGBA[2] = 255 - subLen/8;
ADDRLP4 1136
CNSTF4 1132396544
ADDRLP4 1048
INDIRF4
CNSTF4 1090519040
DIVF4
SUBF4
ASGNF4
ADDRLP4 1140
CNSTF4 1325400064
ASGNF4
ADDRLP4 1136
INDIRF4
ADDRLP4 1140
INDIRF4
LTF4 $3152
ADDRLP4 1132
ADDRLP4 1136
INDIRF4
ADDRLP4 1140
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $3153
JUMPV
LABELV $3152
ADDRLP4 1132
ADDRLP4 1136
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $3153
ADDRLP4 0+80+2
ADDRLP4 1132
INDIRU4
CVUU1 4
ASGNU1
line 5436
;5435:
;5436:				if (legs.shaderRGBA[2] < 1)
ADDRLP4 0+80+2
INDIRU1
CVUI4 1
CNSTI4 1
GEI4 $3154
line 5437
;5437:				{
line 5438
;5438:					legs.shaderRGBA[2] = 1;
ADDRLP4 0+80+2
CNSTU1 1
ASGNU1
line 5439
;5439:				}
LABELV $3154
line 5440
;5440:				if (legs.shaderRGBA[2] > 255)
ADDRLP4 0+80+2
INDIRU1
CVUI4 1
CNSTI4 255
LEI4 $3160
line 5441
;5441:				{
line 5442
;5442:					legs.shaderRGBA[2] = 255;
ADDRLP4 0+80+2
CNSTU1 255
ASGNU1
line 5443
;5443:				}
LABELV $3160
line 5445
;5444:
;5445:				if (subLen <= 1024)
ADDRLP4 1048
INDIRF4
CNSTF4 1149239296
GTF4 $3090
line 5446
;5446:				{
line 5447
;5447:					legs.renderfx |= RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 5448
;5448:				}
line 5449
;5449:			}
line 5450
;5450:		}
line 5451
;5451:	}
ADDRGP4 $3090
JUMPV
LABELV $3089
line 5453
;5452:	else
;5453:	{
line 5454
;5454:		if (cent->currentState.bolt1 && !(cent->currentState.eFlags & EF_DEAD) && cent->currentState.number != cg.snap->ps.clientNum && (!cg.snap->ps.duelInProgress || cg.snap->ps.duelIndex != cent->currentState.number))
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1044
CNSTI4 0
ASGNI4
ADDRLP4 1040
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRLP4 1044
INDIRI4
EQI4 $3169
ADDRLP4 1040
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 1044
INDIRI4
NEI4 $3169
ADDRLP4 1048
ADDRLP4 1040
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
EQI4 $3169
ADDRGP4 cg+36
INDIRP4
CNSTI4 1336
ADDP4
INDIRI4
ADDRLP4 1044
INDIRI4
EQI4 $3174
ADDRGP4 cg+36
INDIRP4
CNSTI4 1328
ADDP4
INDIRI4
ADDRLP4 1048
INDIRI4
EQI4 $3169
LABELV $3174
line 5455
;5455:		{
line 5456
;5456:			legs.shaderRGBA[0] = 50;
ADDRLP4 0+80
CNSTU1 50
ASGNU1
line 5457
;5457:			legs.shaderRGBA[1] = 50;
ADDRLP4 0+80+1
CNSTU1 50
ASGNU1
line 5458
;5458:			legs.shaderRGBA[2] = 50;
ADDRLP4 0+80+2
CNSTU1 50
ASGNU1
line 5459
;5459:			legs.renderfx |= RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 5460
;5460:		}
LABELV $3169
line 5461
;5461:	}
LABELV $3090
LABELV $2527
line 5463
;5462:doEssentialThree:
;5463:	if (cent->currentState.eFlags & EF_DISINTEGRATION)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 33554432
BANDI4
CNSTI4 0
EQI4 $3181
line 5464
;5464:	{
line 5468
;5465:		vec3_t tempAng, hitLoc;
;5466:		float tempLength;
;5467:
;5468:		if (!cent->dustTrailTime)
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3183
line 5469
;5469:		{
line 5470
;5470:			cent->dustTrailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 5471
;5471:			cent->miscTime = legs.frame;
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
ADDRLP4 0+104
INDIRI4
ASGNI4
line 5472
;5472:		}
LABELV $3183
line 5474
;5473:
;5474:		if ((cg.time - cent->dustTrailTime) > 1500)
ADDRGP4 cg+64
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
SUBI4
CNSTI4 1500
LEI4 $3187
line 5475
;5475:		{ //avoid rendering the entity after disintegration has finished anyway
line 5476
;5476:			goto endOfCall;
ADDRGP4 $2992
JUMPV
LABELV $3187
line 5479
;5477:		}
;5478:
;5479:		trap_G2API_SetBoneAnim(legs.ghoul2, 0, "model_root", cent->miscTime, cent->miscTime, BONE_ANIM_OVERRIDE_FREEZE, 1.0f, cg.time, cent->miscTime, -1);
ADDRLP4 0+208
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 1068
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRLP4 1068
INDIRI4
ARGI4
CNSTI4 72
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 1068
INDIRI4
CVIF4 4
ARGF4
CNSTI4 -1
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 5480
;5480:		trap_G2API_SetBoneAnim(legs.ghoul2, 0, "upper_lumbar", cent->miscTime, cent->miscTime, BONE_ANIM_OVERRIDE_FREEZE, 1.0f, cg.time, cent->miscTime, -1);
ADDRLP4 0+208
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $237
ARGP4
ADDRLP4 1072
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
CNSTI4 72
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
CVIF4 4
ARGF4
CNSTI4 -1
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 5481
;5481:		trap_G2API_SetBoneAnim(legs.ghoul2, 0, "Motion", cent->miscTime, cent->miscTime, BONE_ANIM_OVERRIDE_FREEZE, 1.0f, cg.time, cent->miscTime, -1);
ADDRLP4 0+208
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $245
ARGP4
ADDRLP4 1076
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1076
INDIRI4
ARGI4
ADDRLP4 1076
INDIRI4
ARGI4
CNSTI4 72
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 1076
INDIRI4
CVIF4 4
ARGF4
CNSTI4 -1
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 5483
;5482:
;5483:		VectorCopy(cent->currentState.origin2, hitLoc);
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 5485
;5484:
;5485:		VectorSubtract( hitLoc, legs.origin, legs.oldorigin );
ADDRLP4 0+64
ADDRLP4 1040
INDIRF4
ADDRLP4 0+52
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+64+4
ADDRLP4 1040+4
INDIRF4
ADDRLP4 0+52+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+64+8
ADDRLP4 1040+8
INDIRF4
ADDRLP4 0+52+8
INDIRF4
SUBF4
ASGNF4
line 5487
;5486:		
;5487:		tempLength = VectorNormalize( legs.oldorigin );
ADDRLP4 0+64
ARGP4
ADDRLP4 1080
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 1052
ADDRLP4 1080
INDIRF4
ASGNF4
line 5488
;5488:		vectoangles( legs.oldorigin, tempAng );
ADDRLP4 0+64
ARGP4
ADDRLP4 1056
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 5489
;5489:		tempAng[YAW] -= cent->lerpAngles[YAW];
ADDRLP4 1056+4
ADDRLP4 1056+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5490
;5490:		AngleVectors( tempAng, legs.oldorigin, NULL, NULL );
ADDRLP4 1056
ARGP4
ADDRLP4 0+64
ARGP4
ADDRLP4 1084
CNSTP4 0
ASGNP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 5491
;5491:		VectorScale( legs.oldorigin, tempLength, legs.oldorigin );
ADDRLP4 0+64
ADDRLP4 0+64
INDIRF4
ADDRLP4 1052
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+64+4
ADDRLP4 0+64+4
INDIRF4
ADDRLP4 1052
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+64+8
ADDRLP4 0+64+8
INDIRF4
ADDRLP4 1052
INDIRF4
MULF4
ASGNF4
line 5492
;5492:		legs.endTime = cent->dustTrailTime;
ADDRLP4 0+176
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 5501
;5493:
;5494:		//FIXME: Sorting is all wrong here, it can't decide if it should render this part or the outer body first
;5495:		/*
;5496:		legs.renderfx |= RF_DISINTEGRATE2;
;5497:		legs.customShader = cgs.media.disruptorShader;
;5498:		trap_R_AddRefEntityToScene( &legs );
;5499:		*/
;5500:
;5501:		legs.renderfx &= ~(RF_DISINTEGRATE2);
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -262145
BANDI4
ASGNI4
line 5502
;5502:		legs.renderfx |= (RF_DISINTEGRATE1);
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 5504
;5503:
;5504:		legs.customShader = 0;
ADDRLP4 0+76
CNSTI4 0
ASGNI4
line 5505
;5505:		trap_R_AddRefEntityToScene( &legs );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5507
;5506:
;5507:		goto endOfCall;
ADDRGP4 $2992
JUMPV
LABELV $3181
line 5510
;5508:	}
;5509:	else
;5510:	{
line 5511
;5511:		cent->dustTrailTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
CNSTI4 0
ASGNI4
line 5512
;5512:		cent->miscTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
CNSTI4 0
ASGNI4
line 5513
;5513:	}
line 5515
;5514:
;5515:	trap_R_AddRefEntityToScene(&legs);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5517
;5516:
;5517:	if (cent->isATST)
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3226
line 5518
;5518:	{
line 5520
;5519:		//return;
;5520:		goto endOfCall;
ADDRGP4 $2992
JUMPV
LABELV $3226
line 5523
;5521:	}
;5522:
;5523:	cent->frame_minus2 = cent->frame_minus1;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 1252
ADDP4
ADDRLP4 1040
INDIRP4
CNSTI4 1040
ADDP4
INDIRB
ASGNB 212
line 5524
;5524:	if (cent->frame_minus1_refreshed)
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3228
line 5525
;5525:	{
line 5526
;5526:		cent->frame_minus2_refreshed = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1468
ADDP4
CNSTI4 1
ASGNI4
line 5527
;5527:	}
LABELV $3228
line 5528
;5528:	cent->frame_minus1 = legs;
ADDRFP4 0
INDIRP4
CNSTI4 1040
ADDP4
ADDRLP4 0
INDIRB
ASGNB 212
line 5529
;5529:	cent->frame_minus1_refreshed = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
CNSTI4 1
ASGNI4
line 5531
;5530:
;5531:	if (!cent->frame_hold_refreshed && (cent->currentState.powerups & (1 << PW_SPEEDBURST)))
ADDRLP4 1044
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
CNSTI4 0
ASGNI4
ADDRLP4 1044
INDIRP4
CNSTI4 1688
ADDP4
INDIRI4
ADDRLP4 1048
INDIRI4
NEI4 $3230
ADDRLP4 1044
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 256
BANDI4
ADDRLP4 1048
INDIRI4
EQI4 $3230
line 5532
;5532:	{
line 5533
;5533:		cent->frame_hold_time = cg.time + 254;
ADDRFP4 0
INDIRP4
CNSTI4 1684
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 254
ADDI4
ASGNI4
line 5534
;5534:	}
LABELV $3230
line 5536
;5535:
;5536:	if (cent->frame_hold_time >= cg.time)
ADDRFP4 0
INDIRP4
CNSTI4 1684
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LTI4 $3233
line 5537
;5537:	{
line 5538
;5538:		if (!cent->frame_hold_refreshed)
ADDRFP4 0
INDIRP4
CNSTI4 1688
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3236
line 5539
;5539:		{ //We're taking the ghoul2 instance from the original refent and duplicating it onto our refent alias so that we can then freeze the frame and fade it for the effect
line 5540
;5540:			if (cent->frame_hold.ghoul2 && trap_G2_HaveWeGhoul2Models(cent->frame_hold.ghoul2) &&
ADDRLP4 1052
ADDRFP4 0
INDIRP4
CNSTI4 1680
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3238
ADDRLP4 1052
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $3238
ADDRLP4 1060
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1060
INDIRP4
CNSTI4 1680
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1060
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
EQU4 $3238
line 5542
;5541:				cent->frame_hold.ghoul2 != cent->ghoul2)
;5542:			{
line 5543
;5543:				trap_G2API_CleanGhoul2Models(&(cent->frame_hold.ghoul2));
ADDRFP4 0
INDIRP4
CNSTI4 1680
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 5544
;5544:			}
LABELV $3238
line 5545
;5545:			cent->frame_hold = legs;
ADDRFP4 0
INDIRP4
CNSTI4 1472
ADDP4
ADDRLP4 0
INDIRB
ASGNB 212
line 5546
;5546:			cent->frame_hold_refreshed = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1688
ADDP4
CNSTI4 1
ASGNI4
line 5547
;5547:			cent->frame_hold.ghoul2 = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1680
ADDP4
CNSTP4 0
ASGNP4
line 5549
;5548:	
;5549:			trap_G2API_DuplicateGhoul2Instance(cent->ghoul2, &cent->frame_hold.ghoul2);
ADDRLP4 1064
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 1064
INDIRP4
CNSTI4 1680
ADDP4
ARGP4
ADDRGP4 trap_G2API_DuplicateGhoul2Instance
CALLV
pop
line 5553
;5550:
;5551:			//Set the animation to the current frame and freeze on end
;5552:			//trap_G2API_SetBoneAnim(cent->frame_hold.ghoul2, 0, "model_root", cent->frame_hold.frame, cent->frame_hold.frame, BONE_ANIM_OVERRIDE_FREEZE, 1.0f, cg.time, cent->frame_hold.frame, -1);
;5553:			trap_G2API_SetBoneAnim(cent->frame_hold.ghoul2, 0, "model_root", cent->frame_hold.frame, cent->frame_hold.frame, 0, 1.0f, cg.time, cent->frame_hold.frame, -1);
ADDRLP4 1068
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1068
INDIRP4
CNSTI4 1680
ADDP4
INDIRP4
ARGP4
ADDRLP4 1072
CNSTI4 0
ASGNI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 1076
ADDRLP4 1068
INDIRP4
CNSTI4 1576
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1076
INDIRI4
ARGI4
ADDRLP4 1076
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRLP4 1076
INDIRI4
CVIF4 4
ARGF4
CNSTI4 -1
ARGI4
ADDRGP4 trap_G2API_SetBoneAnim
CALLI4
pop
line 5554
;5554:		}
LABELV $3236
line 5556
;5555:
;5556:		cent->frame_hold.renderfx |= RF_FORCE_ENT_ALPHA;
ADDRLP4 1052
ADDRFP4 0
INDIRP4
CNSTI4 1476
ADDP4
ASGNP4
ADDRLP4 1052
INDIRP4
ADDRLP4 1052
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 5557
;5557:		cent->frame_hold.shaderRGBA[3] = (cent->frame_hold_time - cg.time);
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 1555
ADDP4
ADDRLP4 1056
INDIRP4
CNSTI4 1684
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
CVIU4 4
CVUU1 4
ASGNU1
line 5558
;5558:		if (cent->frame_hold.shaderRGBA[3] > 254)
ADDRFP4 0
INDIRP4
CNSTI4 1555
ADDP4
INDIRU1
CVUI4 1
CNSTI4 254
LEI4 $3242
line 5559
;5559:		{
line 5560
;5560:			cent->frame_hold.shaderRGBA[3] = 254;
ADDRFP4 0
INDIRP4
CNSTI4 1555
ADDP4
CNSTU1 254
ASGNU1
line 5561
;5561:		}
LABELV $3242
line 5562
;5562:		if (cent->frame_hold.shaderRGBA[3] < 1)
ADDRFP4 0
INDIRP4
CNSTI4 1555
ADDP4
INDIRU1
CVUI4 1
CNSTI4 1
GEI4 $3244
line 5563
;5563:		{
line 5564
;5564:			cent->frame_hold.shaderRGBA[3] = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1555
ADDP4
CNSTU1 1
ASGNU1
line 5565
;5565:		}
LABELV $3244
line 5567
;5566:
;5567:		trap_R_AddRefEntityToScene(&cent->frame_hold);
ADDRFP4 0
INDIRP4
CNSTI4 1472
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5568
;5568:	}
ADDRGP4 $3234
JUMPV
LABELV $3233
line 5570
;5569:	else
;5570:	{
line 5571
;5571:		cent->frame_hold_refreshed = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1688
ADDP4
CNSTI4 0
ASGNI4
line 5572
;5572:	}
LABELV $3234
line 5577
;5573:
;5574:	//
;5575:	// add the gun / barrel / flash
;5576:	//
;5577:	if (cent->currentState.weapon != WP_EMPLACED_GUN)
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 14
EQI4 $3246
line 5578
;5578:	{
line 5579
;5579:		CG_AddPlayerWeapon( &legs, NULL, cent, ci->team, rootAngles, qtrue );
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 836
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 848
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_AddPlayerWeapon
CALLV
pop
line 5580
;5580:	}
LABELV $3246
line 5582
;5581:	// add powerups floating behind the player
;5582:	CG_PlayerPowerups( cent, &legs );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_PlayerPowerups
CALLV
pop
line 5584
;5583:
;5584:	if ((cent->currentState.forcePowersActive & (1 << FP_RAGE)) &&
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1052
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 256
BANDI4
ADDRLP4 1056
INDIRI4
EQI4 $3248
ADDRGP4 cg+88
INDIRI4
ADDRLP4 1056
INDIRI4
NEI4 $3252
ADDRLP4 1052
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
EQI4 $3248
LABELV $3252
line 5586
;5585:		(cg.renderingThirdPerson || cent->currentState.number != cg.snap->ps.clientNum))
;5586:	{
line 5588
;5587:		//legs.customShader = cgs.media.rageShader;
;5588:		legs.renderfx &= ~RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 5589
;5589:		legs.renderfx &= ~RF_MINLIGHT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 5591
;5590:
;5591:		legs.renderfx |= RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 5592
;5592:		legs.shaderRGBA[0] = 255;
ADDRLP4 0+80
CNSTU1 255
ASGNU1
line 5593
;5593:		legs.shaderRGBA[1] = legs.shaderRGBA[2] = 0;
ADDRLP4 1060
CNSTU1 0
ASGNU1
ADDRLP4 0+80+2
ADDRLP4 1060
INDIRU1
ASGNU1
ADDRLP4 0+80+1
ADDRLP4 1060
INDIRU1
ASGNU1
line 5594
;5594:		legs.shaderRGBA[3] = 255;
ADDRLP4 0+80+3
CNSTU1 255
ASGNU1
line 5596
;5595:
;5596:		if ( rand() & 1 )
ADDRLP4 1064
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $3263
line 5597
;5597:		{
line 5598
;5598:			legs.customShader = cgs.media.electricBodyShader;	
ADDRLP4 0+76
ADDRGP4 cgs+70280+408
INDIRI4
ASGNI4
line 5599
;5599:		}
ADDRGP4 $3264
JUMPV
LABELV $3263
line 5601
;5600:		else
;5601:		{
line 5602
;5602:			legs.customShader = cgs.media.electricBody2Shader;
ADDRLP4 0+76
ADDRGP4 cgs+70280+412
INDIRI4
ASGNI4
line 5603
;5603:		}
LABELV $3264
line 5605
;5604:
;5605:		trap_R_AddRefEntityToScene(&legs);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5606
;5606:	}
LABELV $3248
line 5608
;5607:
;5608:	if (!cg.snap->ps.duelInProgress && cent->currentState.bolt1 && !(cent->currentState.eFlags & EF_DEAD) && cent->currentState.number != cg.snap->ps.clientNum && (!cg.snap->ps.duelInProgress || cg.snap->ps.duelIndex != cent->currentState.number))
ADDRLP4 1060
CNSTI4 1336
ASGNI4
ADDRLP4 1064
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 1060
INDIRI4
ADDP4
INDIRI4
ADDRLP4 1064
INDIRI4
NEI4 $3271
ADDRLP4 1068
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1068
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRLP4 1064
INDIRI4
EQI4 $3271
ADDRLP4 1068
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 1064
INDIRI4
NEI4 $3271
ADDRLP4 1072
ADDRLP4 1068
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 1072
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
EQI4 $3271
ADDRGP4 cg+36
INDIRP4
ADDRLP4 1060
INDIRI4
ADDP4
INDIRI4
ADDRLP4 1064
INDIRI4
EQI4 $3277
ADDRGP4 cg+36
INDIRP4
CNSTI4 1328
ADDP4
INDIRI4
ADDRLP4 1072
INDIRI4
EQI4 $3271
LABELV $3277
line 5609
;5609:	{
line 5610
;5610:		legs.shaderRGBA[0] = 50;
ADDRLP4 0+80
CNSTU1 50
ASGNU1
line 5611
;5611:		legs.shaderRGBA[1] = 50;
ADDRLP4 0+80+1
CNSTU1 50
ASGNU1
line 5612
;5612:		legs.shaderRGBA[2] = 255;
ADDRLP4 0+80+2
CNSTU1 255
ASGNU1
line 5614
;5613:
;5614:		legs.renderfx &= ~RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 5615
;5615:		legs.renderfx &= ~RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 5616
;5616:		legs.customShader = cgs.media.forceSightBubble;
ADDRLP4 0+76
ADDRGP4 cgs+70280+504
INDIRI4
ASGNI4
line 5618
;5617:		
;5618:		trap_R_AddRefEntityToScene( &legs );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5619
;5619:	}
LABELV $3271
line 5623
;5620:
;5621:	//For now, these two are using the old shield shader. This is just so that you
;5622:	//can tell it apart from the JM/duel shaders, but it's still very obvious.
;5623:	if (cent->currentState.forcePowersActive & (1 << FP_PROTECT))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $3288
line 5624
;5624:	{ //aborb is represented by green..
line 5625
;5625:		legs.shaderRGBA[0] = 0;
ADDRLP4 0+80
CNSTU1 0
ASGNU1
line 5626
;5626:		legs.shaderRGBA[1] = 255;
ADDRLP4 0+80+1
CNSTU1 255
ASGNU1
line 5627
;5627:		legs.shaderRGBA[2] = 0;
ADDRLP4 0+80+2
CNSTU1 0
ASGNU1
line 5628
;5628:		legs.shaderRGBA[3] = 254;
ADDRLP4 0+80+3
CNSTU1 254
ASGNU1
line 5630
;5629:
;5630:		legs.renderfx &= ~RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 5631
;5631:		legs.renderfx &= ~RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 5632
;5632:		legs.customShader = cgs.media.playerShieldDamage;
ADDRLP4 0+76
ADDRGP4 cgs+70280+500
INDIRI4
ASGNI4
line 5634
;5633:		
;5634:		trap_R_AddRefEntityToScene( &legs );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5635
;5635:	}
LABELV $3288
line 5636
;5636:	if (cent->currentState.forcePowersActive & (1 << FP_ABSORB))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $3302
line 5637
;5637:	{ //aborb is represented by blue..
line 5638
;5638:		legs.shaderRGBA[0] = 0;
ADDRLP4 0+80
CNSTU1 0
ASGNU1
line 5639
;5639:		legs.shaderRGBA[1] = 0;
ADDRLP4 0+80+1
CNSTU1 0
ASGNU1
line 5640
;5640:		legs.shaderRGBA[2] = 255;
ADDRLP4 0+80+2
CNSTU1 255
ASGNU1
line 5641
;5641:		legs.shaderRGBA[3] = 254;
ADDRLP4 0+80+3
CNSTU1 254
ASGNU1
line 5643
;5642:
;5643:		legs.renderfx &= ~RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 5644
;5644:		legs.renderfx &= ~RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 5645
;5645:		legs.customShader = cgs.media.playerShieldDamage;
ADDRLP4 0+76
ADDRGP4 cgs+70280+500
INDIRI4
ASGNI4
line 5647
;5646:		
;5647:		trap_R_AddRefEntityToScene( &legs );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5648
;5648:	}
LABELV $3302
line 5650
;5649:
;5650:	if (cent->currentState.isJediMaster && cg.snap->ps.clientNum != cent->currentState.number)
ADDRLP4 1076
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1076
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3316
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRLP4 1076
INDIRP4
INDIRI4
EQI4 $3316
line 5651
;5651:	{
line 5652
;5652:		legs.shaderRGBA[0] = 100;
ADDRLP4 0+80
CNSTU1 100
ASGNU1
line 5653
;5653:		legs.shaderRGBA[1] = 100;
ADDRLP4 0+80+1
CNSTU1 100
ASGNU1
line 5654
;5654:		legs.shaderRGBA[2] = 255;
ADDRLP4 0+80+2
CNSTU1 255
ASGNU1
line 5656
;5655:
;5656:		legs.renderfx &= ~RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 5657
;5657:		legs.renderfx &= ~RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 5658
;5658:		legs.renderfx |= RF_NODEPTH;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 5659
;5659:		legs.customShader = cgs.media.forceShell;
ADDRLP4 0+76
ADDRGP4 cgs+70280+508
INDIRI4
ASGNI4
line 5661
;5660:		
;5661:		trap_R_AddRefEntityToScene( &legs );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5663
;5662:
;5663:		legs.renderfx &= ~RF_NODEPTH;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 5664
;5664:	}
LABELV $3316
line 5666
;5665:
;5666:	if ((cg.snap->ps.fd.forcePowersActive & (1 << FP_SEE)) && cg.snap->ps.clientNum != cent->currentState.number && cg_auraShell.integer)
ADDRLP4 1080
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
ADDRLP4 1080
INDIRI4
EQI4 $3331
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
EQI4 $3331
ADDRGP4 cg_auraShell+12
INDIRI4
ADDRLP4 1080
INDIRI4
EQI4 $3331
line 5667
;5667:	{
line 5668
;5668:		if (cgs.gametype >= GT_TEAM)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $3336
line 5669
;5669:		{	// A team game
line 5670
;5670:			switch(cgs.clientinfo[ cent->currentState.clientNum ].team)
ADDRLP4 1084
CNSTI4 788
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 1
EQI4 $3344
ADDRLP4 1084
INDIRI4
CNSTI4 2
EQI4 $3350
ADDRGP4 $3339
JUMPV
line 5671
;5671:			{
LABELV $3344
line 5673
;5672:			case TEAM_RED:
;5673:				legs.shaderRGBA[0] = 255;
ADDRLP4 0+80
CNSTU1 255
ASGNU1
line 5674
;5674:				legs.shaderRGBA[1] = 50;
ADDRLP4 0+80+1
CNSTU1 50
ASGNU1
line 5675
;5675:				legs.shaderRGBA[2] = 50;
ADDRLP4 0+80+2
CNSTU1 50
ASGNU1
line 5676
;5676:				break;
ADDRGP4 $3337
JUMPV
LABELV $3350
line 5678
;5677:			case TEAM_BLUE:
;5678:				legs.shaderRGBA[0] = 75;
ADDRLP4 0+80
CNSTU1 75
ASGNU1
line 5679
;5679:				legs.shaderRGBA[1] = 75;
ADDRLP4 0+80+1
CNSTU1 75
ASGNU1
line 5680
;5680:				legs.shaderRGBA[2] = 255;
ADDRLP4 0+80+2
CNSTU1 255
ASGNU1
line 5681
;5681:				break;
ADDRGP4 $3337
JUMPV
LABELV $3339
line 5684
;5682:
;5683:			default:
;5684:				legs.shaderRGBA[0] = 255;
ADDRLP4 0+80
CNSTU1 255
ASGNU1
line 5685
;5685:				legs.shaderRGBA[1] = 255;
ADDRLP4 0+80+1
CNSTU1 255
ASGNU1
line 5686
;5686:				legs.shaderRGBA[2] = 0;
ADDRLP4 0+80+2
CNSTU1 0
ASGNU1
line 5687
;5687:				break;
line 5689
;5688:			}
;5689:		}
ADDRGP4 $3337
JUMPV
LABELV $3336
line 5691
;5690:		else
;5691:		{	// Not a team game
line 5692
;5692:			legs.shaderRGBA[0] = 255;
ADDRLP4 0+80
CNSTU1 255
ASGNU1
line 5693
;5693:			legs.shaderRGBA[1] = 255;
ADDRLP4 0+80+1
CNSTU1 255
ASGNU1
line 5694
;5694:			legs.shaderRGBA[2] = 0;
ADDRLP4 0+80+2
CNSTU1 0
ASGNU1
line 5695
;5695:		}
LABELV $3337
line 5697
;5696:
;5697:/*		if (cg.snap->ps.fd.forcePowerLevel[FP_SEE] <= FORCE_LEVEL_1)
line 5703
;5698:		{
;5699:			legs.renderfx |= RF_MINLIGHT;
;5700:		}
;5701:		else
;5702:*/		{	// See through walls.
;5703:			legs.renderfx |= RF_MINLIGHT | RF_NODEPTH;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 17
BORI4
ASGNI4
line 5705
;5704:
;5705:			if (cg.snap->ps.fd.forcePowerLevel[FP_SEE] < FORCE_LEVEL_2)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
GEI4 $3367
line 5706
;5706:			{ //only level 2+ can see players through walls
line 5707
;5707:				legs.renderfx &= ~RF_NODEPTH;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 5708
;5708:			}
LABELV $3367
line 5709
;5709:		}
line 5711
;5710:
;5711:		legs.renderfx &= ~RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 5712
;5712:		legs.renderfx &= ~RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 5713
;5713:		legs.customShader = cgs.media.sightShell;
ADDRLP4 0+76
ADDRGP4 cgs+70280+512
INDIRI4
ASGNI4
line 5715
;5714:		
;5715:		trap_R_AddRefEntityToScene( &legs );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5716
;5716:	}
LABELV $3331
line 5720
;5717:
;5718:	// Electricity
;5719:	//------------------------------------------------
;5720:	if ( cent->currentState.emplacedOwner > cg.time ) 
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $3376
line 5721
;5721:	{
line 5722
;5722:		int	dif = cent->currentState.emplacedOwner - cg.time;
ADDRLP4 1084
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
ASGNI4
line 5724
;5723:
;5724:		if ( dif > 0 && random() > 0.4f )
ADDRLP4 1084
INDIRI4
CNSTI4 0
LEI4 $3380
ADDRLP4 1088
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1053609165
LEF4 $3380
line 5725
;5725:		{
line 5727
;5726:			// fade out over the last 500 ms
;5727:			int brightness = 255;
ADDRLP4 1092
CNSTI4 255
ASGNI4
line 5729
;5728:			
;5729:			if ( dif < 500 )
ADDRLP4 1084
INDIRI4
CNSTI4 500
GEI4 $3382
line 5730
;5730:			{
line 5731
;5731:				brightness = floor((dif - 500.0f) / 500.0f * 255.0f );
ADDRLP4 1096
CNSTF4 1140457472
ASGNF4
CNSTF4 1132396544
ADDRLP4 1084
INDIRI4
CVIF4 4
ADDRLP4 1096
INDIRF4
SUBF4
ADDRLP4 1096
INDIRF4
DIVF4
MULF4
ARGF4
ADDRLP4 1100
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 1092
ADDRLP4 1100
INDIRF4
CVFI4 4
ASGNI4
line 5732
;5732:			}
LABELV $3382
line 5734
;5733:
;5734:			legs.renderfx &= ~RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 5735
;5735:			legs.renderfx &= ~RF_MINLIGHT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 5737
;5736:
;5737:			legs.renderfx |= RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 5738
;5738:			legs.shaderRGBA[0] = legs.shaderRGBA[1] = legs.shaderRGBA[2] = brightness;
ADDRLP4 1096
ADDRLP4 1092
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
ADDRLP4 0+80+2
ADDRLP4 1096
INDIRU1
ASGNU1
ADDRLP4 0+80+1
ADDRLP4 1096
INDIRU1
ASGNU1
ADDRLP4 0+80
ADDRLP4 1096
INDIRU1
ASGNU1
line 5739
;5739:			legs.shaderRGBA[3] = 255;
ADDRLP4 0+80+3
CNSTU1 255
ASGNU1
line 5741
;5740:
;5741:			if ( rand() & 1 )
ADDRLP4 1100
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $3394
line 5742
;5742:			{
line 5743
;5743:				legs.customShader = cgs.media.electricBodyShader;	
ADDRLP4 0+76
ADDRGP4 cgs+70280+408
INDIRI4
ASGNI4
line 5744
;5744:			}
ADDRGP4 $3395
JUMPV
LABELV $3394
line 5746
;5745:			else
;5746:			{
line 5747
;5747:				legs.customShader = cgs.media.electricBody2Shader;
ADDRLP4 0+76
ADDRGP4 cgs+70280+412
INDIRI4
ASGNI4
line 5748
;5748:			}
LABELV $3395
line 5750
;5749:
;5750:			trap_R_AddRefEntityToScene( &legs );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5752
;5751:
;5752:			if ( random() > 0.9f )
ADDRLP4 1104
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1063675494
LEF4 $3402
line 5753
;5753:				trap_S_StartSound ( NULL, cent->currentState.number, CHAN_AUTO, cgs.media.crackleSound );
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+688
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
LABELV $3402
line 5754
;5754:		}
LABELV $3380
line 5755
;5755:	} 
LABELV $3376
line 5757
;5756:
;5757:	if (cent->currentState.powerups & (1 << PW_SHIELDHIT))
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $3406
line 5758
;5758:	{
line 5766
;5759:		/*
;5760:		legs.shaderRGBA[0] = legs.shaderRGBA[1] = legs.shaderRGBA[2] = 255.0f * 0.5f;//t;
;5761:		legs.shaderRGBA[3] = 255;
;5762:		legs.renderfx &= ~RF_ALPHA_FADE;
;5763:		legs.renderfx |= RF_RGB_TINT;
;5764:		*/
;5765:
;5766:		legs.shaderRGBA[0] = legs.shaderRGBA[1] = legs.shaderRGBA[2] = Q_irand(1, 255);
CNSTI4 1
ARGI4
CNSTI4 255
ARGI4
ADDRLP4 1084
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 1088
ADDRLP4 1084
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
ADDRLP4 0+80+2
ADDRLP4 1088
INDIRU1
ASGNU1
ADDRLP4 0+80+1
ADDRLP4 1088
INDIRU1
ASGNU1
ADDRLP4 0+80
ADDRLP4 1088
INDIRU1
ASGNU1
line 5768
;5767:
;5768:		legs.renderfx &= ~RF_FORCE_ENT_ALPHA;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 5769
;5769:		legs.renderfx &= ~RF_MINLIGHT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 5770
;5770:		legs.renderfx &= ~RF_RGB_TINT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 5771
;5771:		legs.customShader = cgs.media.playerShieldDamage;
ADDRLP4 0+76
ADDRGP4 cgs+70280+500
INDIRI4
ASGNI4
line 5773
;5772:		
;5773:		trap_R_AddRefEntityToScene( &legs );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 5774
;5774:	}
LABELV $3406
LABELV $2992
line 5777
;5775:endOfCall:
;5776:	
;5777:	if (cgBoneAnglePostSet.refreshSet)
ADDRGP4 cgBoneAnglePostSet+52
INDIRI4
CNSTI4 0
EQI4 $3419
line 5778
;5778:	{
line 5779
;5779:		trap_G2API_SetBoneAngles(cgBoneAnglePostSet.ghoul2, cgBoneAnglePostSet.modelIndex, cgBoneAnglePostSet.boneName,
ADDRGP4 cgBoneAnglePostSet
INDIRP4
ARGP4
ADDRGP4 cgBoneAnglePostSet+4
INDIRI4
ARGI4
ADDRGP4 cgBoneAnglePostSet+8
INDIRP4
ARGP4
ADDRGP4 cgBoneAnglePostSet+12
ARGP4
ADDRGP4 cgBoneAnglePostSet+24
INDIRI4
ARGI4
ADDRGP4 cgBoneAnglePostSet+28
INDIRI4
ARGI4
ADDRGP4 cgBoneAnglePostSet+32
INDIRI4
ARGI4
ADDRGP4 cgBoneAnglePostSet+36
INDIRI4
ARGI4
ADDRGP4 cgBoneAnglePostSet+40
INDIRP4
ARGP4
ADDRGP4 cgBoneAnglePostSet+44
INDIRI4
ARGI4
ADDRGP4 cgBoneAnglePostSet+48
INDIRI4
ARGI4
ADDRGP4 trap_G2API_SetBoneAngles
CALLI4
pop
line 5783
;5780:			cgBoneAnglePostSet.angles, cgBoneAnglePostSet.flags, cgBoneAnglePostSet.up, cgBoneAnglePostSet.right,
;5781:			cgBoneAnglePostSet.forward, cgBoneAnglePostSet.modelList, cgBoneAnglePostSet.blendTime, cgBoneAnglePostSet.currentTime);
;5782:
;5783:		cgBoneAnglePostSet.refreshSet = qfalse;
ADDRGP4 cgBoneAnglePostSet+52
CNSTI4 0
ASGNI4
line 5784
;5784:	}
LABELV $3419
line 5785
;5785:}
LABELV $2245
endproc CG_Player 1356 44
export CG_ResetPlayerEntity
proc CG_ResetPlayerEntity 56 20
line 5798
;5786:
;5787:
;5788://=====================================================================
;5789:
;5790:/*
;5791:===============
;5792:CG_ResetPlayerEntity
;5793:
;5794:A player just came into view or teleported, so reset all animation info
;5795:===============
;5796:*/
;5797:void CG_ResetPlayerEntity( centity_t *cent ) 
;5798:{
line 5799
;5799:	cent->errorTime = -99999;		// guarantee no error decay added
ADDRFP4 0
INDIRP4
CNSTI4 860
ADDP4
CNSTI4 -99999
ASGNI4
line 5800
;5800:	cent->extrapolated = qfalse;	
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
CNSTI4 0
ASGNI4
line 5802
;5801:
;5802:	CG_ClearLerpFrame( cent, &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.legs, cent->currentState.legsAnim, qfalse);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 788
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 644
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 5803
;5803:	CG_ClearLerpFrame( cent, &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.torso, cent->currentState.torsoAnim, qtrue);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 788
ADDRLP4 4
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 708
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 5805
;5804:
;5805:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
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
line 5806
;5806:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );
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
line 5808
;5807:
;5808:	VectorCopy( cent->lerpOrigin, cent->rawOrigin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 892
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 5809
;5809:	VectorCopy( cent->lerpAngles, cent->rawAngles );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 904
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 940
ADDP4
INDIRB
ASGNB 12
line 5811
;5810:
;5811:	memset( &cent->pe.legs, 0, sizeof( cent->pe.legs ) );
ADDRFP4 0
INDIRP4
CNSTI4 644
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5812
;5812:	cent->pe.legs.yawAngle = cent->rawAngles[YAW];
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 664
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 908
ADDP4
INDIRF4
ASGNF4
line 5813
;5813:	cent->pe.legs.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTI4 0
ASGNI4
line 5814
;5814:	cent->pe.legs.pitchAngle = 0;
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTF4 0
ASGNF4
line 5815
;5815:	cent->pe.legs.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
CNSTI4 0
ASGNI4
line 5817
;5816:
;5817:	memset( &cent->pe.torso, 0, sizeof( cent->pe.legs ) );
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5818
;5818:	cent->pe.torso.yawAngle = cent->rawAngles[YAW];
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 728
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 908
ADDP4
INDIRF4
ASGNF4
line 5819
;5819:	cent->pe.torso.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 0
ASGNI4
line 5820
;5820:	cent->pe.torso.pitchAngle = cent->rawAngles[PITCH];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 904
ADDP4
INDIRF4
ASGNF4
line 5821
;5821:	cent->pe.torso.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 0
ASGNI4
line 5823
;5822:
;5823:	if ((cent->ghoul2 == NULL) && trap_G2_HaveWeGhoul2Models(cgs.clientinfo[cent->currentState.clientNum].ghoul2Model))
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3438
CNSTI4 788
ADDRLP4 36
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+504
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $3438
line 5824
;5824:	{
line 5825
;5825:		trap_G2API_DuplicateGhoul2Instance(cgs.clientinfo[cent->currentState.clientNum].ghoul2Model, &cent->ghoul2);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 788
ADDRLP4 44
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+504
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 952
ADDP4
ARGP4
ADDRGP4 trap_G2API_DuplicateGhoul2Instance
CALLV
pop
line 5826
;5826:		CG_CopyG2WeaponInstance(cent->currentState.weapon, cgs.clientinfo[cent->currentState.clientNum].ghoul2Model);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
CNSTI4 788
ADDRLP4 48
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+504
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_CopyG2WeaponInstance
CALLV
pop
line 5827
;5827:		cent->weapon = cent->currentState.weapon;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 956
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
line 5828
;5828:	}
LABELV $3438
line 5830
;5829:
;5830:	if ( cg_debugPosition.integer ) {
ADDRGP4 cg_debugPosition+12
INDIRI4
CNSTI4 0
EQI4 $3446
line 5831
;5831:		CG_Printf("%i ResetPlayerEntity yaw=%i\n", cent->currentState.number, cent->pe.torso.yawAngle );
ADDRGP4 $3449
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 5832
;5832:	}
LABELV $3446
line 5833
;5833:}
LABELV $3433
endproc CG_ResetPlayerEntity 56 20
import forceHolocronModels
import CG_AllocMark
bss
export cgBoneAnglePostSet
align 4
LABELV cgBoneAnglePostSet
skip 56
import animTable
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
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
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
LABELV $3449
char 1 37
char 1 105
char 1 32
char 1 82
char 1 101
char 1 115
char 1 101
char 1 116
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 69
char 1 110
char 1 116
char 1 105
char 1 116
char 1 121
char 1 32
char 1 121
char 1 97
char 1 119
char 1 61
char 1 37
char 1 105
char 1 10
char 1 0
align 1
LABELV $3002
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
LABELV $3001
char 1 42
char 1 102
char 1 108
char 1 97
char 1 115
char 1 104
char 1 0
align 1
LABELV $2985
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
char 1 104
char 1 117
char 1 109
char 1 49
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $2774
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 47
char 1 99
char 1 111
char 1 110
char 1 102
char 1 117
char 1 115
char 1 105
char 1 111
char 1 110
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $2699
char 1 112
char 1 111
char 1 119
char 1 101
char 1 114
char 1 117
char 1 112
char 1 115
char 1 47
char 1 121
char 1 115
char 1 97
char 1 108
char 1 105
char 1 109
char 1 97
char 1 114
char 1 105
char 1 115
char 1 104
char 1 101
char 1 108
char 1 108
char 1 0
align 1
LABELV $2645
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
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 47
char 1 105
char 1 100
char 1 108
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $2630
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
LABELV $2617
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
LABELV $2616
char 1 108
char 1 95
char 1 97
char 1 114
char 1 109
char 1 0
align 1
LABELV $2615
char 1 108
char 1 114
char 1 97
char 1 100
char 1 105
char 1 117
char 1 115
char 1 0
align 1
LABELV $2461
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 105
char 1 116
char 1 101
char 1 109
char 1 115
char 1 47
char 1 114
char 1 101
char 1 109
char 1 111
char 1 116
char 1 101
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $2345
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
LABELV $2342
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
LABELV $2251
char 1 66
char 1 97
char 1 100
char 1 32
char 1 99
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 78
char 1 117
char 1 109
char 1 32
char 1 111
char 1 110
char 1 32
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 32
char 1 101
char 1 110
char 1 116
char 1 105
char 1 116
char 1 121
char 1 0
align 1
LABELV $2222
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 101
char 1 108
char 1 101
char 1 99
char 1 116
char 1 114
char 1 105
char 1 99
char 1 50
char 1 0
align 1
LABELV $1825
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
char 1 104
char 1 105
char 1 116
char 1 119
char 1 97
char 1 108
char 1 108
char 1 37
char 1 105
char 1 0
align 1
LABELV $1799
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 47
char 1 115
char 1 112
char 1 97
char 1 114
char 1 107
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1691
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
char 1 97
char 1 98
char 1 101
char 1 114
char 1 68
char 1 97
char 1 109
char 1 97
char 1 103
char 1 101
char 1 71
char 1 108
char 1 111
char 1 119
char 1 0
align 1
LABELV $1342
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
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 80
char 1 117
char 1 115
char 1 104
char 1 0
align 1
LABELV $1110
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
LABELV $1072
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
LABELV $997
char 1 66
char 1 97
char 1 100
char 1 32
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 32
char 1 109
char 1 111
char 1 118
char 1 101
char 1 109
char 1 101
char 1 110
char 1 116
char 1 32
char 1 97
char 1 110
char 1 103
char 1 108
char 1 101
char 1 0
align 1
LABELV $847
char 1 67
char 1 108
char 1 97
char 1 109
char 1 112
char 1 32
char 1 108
char 1 102
char 1 45
char 1 62
char 1 102
char 1 114
char 1 97
char 1 109
char 1 101
char 1 84
char 1 105
char 1 109
char 1 101
char 1 10
char 1 0
align 1
LABELV $653
char 1 65
char 1 110
char 1 105
char 1 109
char 1 58
char 1 32
char 1 37
char 1 105
char 1 44
char 1 32
char 1 39
char 1 37
char 1 115
char 1 39
char 1 10
char 1 0
align 1
LABELV $649
char 1 66
char 1 97
char 1 100
char 1 32
char 1 97
char 1 110
char 1 105
char 1 109
char 1 97
char 1 116
char 1 105
char 1 111
char 1 110
char 1 32
char 1 110
char 1 117
char 1 109
char 1 98
char 1 101
char 1 114
char 1 58
char 1 32
char 1 37
char 1 105
char 1 0
align 1
LABELV $629
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 47
char 1 99
char 1 104
char 1 97
char 1 114
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
char 1 115
char 1 116
char 1 97
char 1 114
char 1 116
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $608
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 47
char 1 99
char 1 104
char 1 97
char 1 114
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
char 1 99
char 1 114
char 1 97
char 1 115
char 1 104
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $602
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 47
char 1 99
char 1 104
char 1 97
char 1 114
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
char 1 115
char 1 116
char 1 101
char 1 112
char 1 50
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $601
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 47
char 1 99
char 1 104
char 1 97
char 1 114
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
char 1 115
char 1 116
char 1 101
char 1 112
char 1 49
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $528
char 1 77
char 1 101
char 1 109
char 1 111
char 1 114
char 1 121
char 1 32
char 1 105
char 1 115
char 1 32
char 1 108
char 1 111
char 1 119
char 1 46
char 1 32
char 1 32
char 1 85
char 1 115
char 1 105
char 1 110
char 1 103
char 1 32
char 1 100
char 1 101
char 1 102
char 1 101
char 1 114
char 1 114
char 1 101
char 1 100
char 1 32
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 46
char 1 10
char 1 0
align 1
LABELV $496
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 112
char 1 111
char 1 119
char 1 101
char 1 114
char 1 115
char 1 0
align 1
LABELV $463
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 0
align 1
LABELV $461
char 1 103
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $459
char 1 103
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $457
char 1 116
char 1 108
char 1 0
align 1
LABELV $455
char 1 116
char 1 116
char 1 0
align 1
LABELV $453
char 1 116
char 1 0
align 1
LABELV $451
char 1 108
char 1 0
align 1
LABELV $449
char 1 119
char 1 0
align 1
LABELV $447
char 1 104
char 1 99
char 1 0
align 1
LABELV $445
char 1 115
char 1 107
char 1 105
char 1 108
char 1 108
char 1 0
align 1
LABELV $443
char 1 99
char 1 50
char 1 0
align 1
LABELV $440
char 1 99
char 1 49
char 1 0
align 1
LABELV $437
char 1 110
char 1 0
align 1
LABELV $430
char 1 67
char 1 71
char 1 95
char 1 83
char 1 101
char 1 116
char 1 68
char 1 101
char 1 102
char 1 101
char 1 114
char 1 114
char 1 101
char 1 100
char 1 67
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 73
char 1 110
char 1 102
char 1 111
char 1 58
char 1 32
char 1 110
char 1 111
char 1 32
char 1 118
char 1 97
char 1 108
char 1 105
char 1 100
char 1 32
char 1 99
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 115
char 1 33
char 1 10
char 1 0
align 1
LABELV $359
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 47
char 1 99
char 1 104
char 1 97
char 1 114
char 1 115
char 1 47
char 1 37
char 1 115
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 37
char 1 115
char 1 0
align 1
LABELV $356
char 1 99
char 1 104
char 1 97
char 1 114
char 1 115
char 1 47
char 1 109
char 1 112
char 1 95
char 1 103
char 1 101
char 1 110
char 1 101
char 1 114
char 1 105
char 1 99
char 1 95
char 1 102
char 1 101
char 1 109
char 1 97
char 1 108
char 1 101
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 0
align 1
LABELV $351
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 47
char 1 37
char 1 115
char 1 47
char 1 37
char 1 115
char 1 0
align 1
LABELV $348
char 1 37
char 1 115
char 1 0
align 1
LABELV $330
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 37
char 1 115
char 1 47
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 115
char 1 46
char 1 99
char 1 102
char 1 103
char 1 0
align 1
LABELV $329
char 1 99
char 1 104
char 1 97
char 1 114
char 1 115
char 1 47
char 1 109
char 1 112
char 1 95
char 1 103
char 1 101
char 1 110
char 1 101
char 1 114
char 1 105
char 1 99
char 1 95
char 1 109
char 1 97
char 1 108
char 1 101
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 0
align 1
LABELV $328
char 1 116
char 1 97
char 1 103
char 1 95
char 1 102
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $315
char 1 68
char 1 69
char 1 70
char 1 65
char 1 85
char 1 76
char 1 84
char 1 95
char 1 77
char 1 79
char 1 68
char 1 69
char 1 76
char 1 32
char 1 40
char 1 37
char 1 115
char 1 41
char 1 32
char 1 102
char 1 97
char 1 105
char 1 108
char 1 101
char 1 100
char 1 32
char 1 116
char 1 111
char 1 32
char 1 114
char 1 101
char 1 103
char 1 105
char 1 115
char 1 116
char 1 101
char 1 114
char 1 0
align 1
LABELV $312
char 1 68
char 1 69
char 1 70
char 1 65
char 1 85
char 1 76
char 1 84
char 1 95
char 1 84
char 1 69
char 1 65
char 1 77
char 1 95
char 1 77
char 1 79
char 1 68
char 1 69
char 1 76
char 1 32
char 1 47
char 1 32
char 1 115
char 1 107
char 1 105
char 1 110
char 1 32
char 1 40
char 1 37
char 1 115
char 1 47
char 1 37
char 1 115
char 1 41
char 1 32
char 1 102
char 1 97
char 1 105
char 1 108
char 1 101
char 1 100
char 1 32
char 1 116
char 1 111
char 1 32
char 1 114
char 1 101
char 1 103
char 1 105
char 1 115
char 1 116
char 1 101
char 1 114
char 1 0
align 1
LABELV $309
char 1 69
char 1 109
char 1 112
char 1 105
char 1 114
char 1 101
char 1 0
align 1
LABELV $308
char 1 82
char 1 101
char 1 98
char 1 101
char 1 108
char 1 108
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $300
char 1 47
char 1 0
align 1
LABELV $275
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 37
char 1 115
char 1 47
char 1 105
char 1 99
char 1 111
char 1 110
char 1 95
char 1 37
char 1 115
char 1 0
align 1
LABELV $246
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
LABELV $245
char 1 77
char 1 111
char 1 116
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $244
char 1 42
char 1 104
char 1 101
char 1 97
char 1 100
char 1 95
char 1 116
char 1 111
char 1 112
char 1 0
align 1
LABELV $243
char 1 42
char 1 108
char 1 95
char 1 104
char 1 97
char 1 110
char 1 100
char 1 0
align 1
LABELV $241
char 1 99
char 1 114
char 1 97
char 1 110
char 1 105
char 1 117
char 1 109
char 1 0
align 1
LABELV $237
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
LABELV $233
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
LABELV $230
char 1 42
char 1 114
char 1 95
char 1 104
char 1 97
char 1 110
char 1 100
char 1 0
align 1
LABELV $229
char 1 112
char 1 101
char 1 108
char 1 118
char 1 105
char 1 115
char 1 0
align 1
LABELV $228
char 1 42
char 1 102
char 1 108
char 1 97
char 1 115
char 1 104
char 1 50
char 1 0
align 1
LABELV $226
char 1 114
char 1 95
char 1 99
char 1 108
char 1 97
char 1 118
char 1 105
char 1 99
char 1 97
char 1 108
char 1 0
align 1
LABELV $224
char 1 108
char 1 95
char 1 99
char 1 108
char 1 97
char 1 118
char 1 105
char 1 99
char 1 97
char 1 108
char 1 0
align 1
LABELV $222
char 1 77
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
LABELV $221
char 1 42
char 1 102
char 1 108
char 1 97
char 1 115
char 1 104
char 1 49
char 1 0
align 1
LABELV $207
char 1 70
char 1 97
char 1 105
char 1 108
char 1 101
char 1 100
char 1 32
char 1 116
char 1 111
char 1 32
char 1 108
char 1 111
char 1 97
char 1 100
char 1 32
char 1 97
char 1 110
char 1 105
char 1 109
char 1 97
char 1 116
char 1 105
char 1 111
char 1 110
char 1 32
char 1 102
char 1 105
char 1 108
char 1 101
char 1 32
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 95
char 1 104
char 1 117
char 1 109
char 1 97
char 1 110
char 1 111
char 1 105
char 1 100
char 1 47
char 1 97
char 1 110
char 1 105
char 1 109
char 1 97
char 1 116
char 1 105
char 1 111
char 1 110
char 1 46
char 1 99
char 1 102
char 1 103
char 1 10
char 1 0
align 1
LABELV $204
char 1 77
char 1 111
char 1 100
char 1 101
char 1 108
char 1 32
char 1 100
char 1 111
char 1 101
char 1 115
char 1 32
char 1 110
char 1 111
char 1 116
char 1 32
char 1 117
char 1 115
char 1 101
char 1 32
char 1 115
char 1 117
char 1 112
char 1 112
char 1 111
char 1 114
char 1 116
char 1 101
char 1 100
char 1 32
char 1 97
char 1 110
char 1 105
char 1 109
char 1 97
char 1 116
char 1 105
char 1 111
char 1 110
char 1 32
char 1 99
char 1 111
char 1 110
char 1 102
char 1 105
char 1 103
char 1 46
char 1 10
char 1 0
align 1
LABELV $201
char 1 47
char 1 97
char 1 110
char 1 105
char 1 109
char 1 97
char 1 116
char 1 105
char 1 111
char 1 110
char 1 46
char 1 99
char 1 102
char 1 103
char 1 0
align 1
LABELV $198
char 1 70
char 1 97
char 1 105
char 1 108
char 1 101
char 1 100
char 1 32
char 1 116
char 1 111
char 1 32
char 1 108
char 1 111
char 1 97
char 1 100
char 1 32
char 1 97
char 1 110
char 1 105
char 1 109
char 1 97
char 1 116
char 1 105
char 1 111
char 1 110
char 1 32
char 1 102
char 1 105
char 1 108
char 1 101
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $197
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 95
char 1 104
char 1 117
char 1 109
char 1 97
char 1 110
char 1 111
char 1 105
char 1 100
char 1 47
char 1 97
char 1 110
char 1 105
char 1 109
char 1 97
char 1 116
char 1 105
char 1 111
char 1 110
char 1 46
char 1 99
char 1 102
char 1 103
char 1 0
align 1
LABELV $184
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 37
char 1 115
char 1 47
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 95
char 1 37
char 1 115
char 1 46
char 1 115
char 1 107
char 1 105
char 1 110
char 1 0
align 1
LABELV $183
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 37
char 1 115
char 1 47
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 46
char 1 103
char 1 108
char 1 109
char 1 0
align 1
LABELV $182
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 97
char 1 116
char 1 115
char 1 116
char 1 47
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 46
char 1 103
char 1 108
char 1 109
char 1 0
align 1
LABELV $177
char 1 98
char 1 108
char 1 117
char 1 101
char 1 0
align 1
LABELV $174
char 1 114
char 1 101
char 1 100
char 1 0
align 1
LABELV $166
char 1 87
char 1 65
char 1 82
char 1 78
char 1 73
char 1 78
char 1 71
char 1 58
char 1 32
char 1 65
char 1 116
char 1 116
char 1 101
char 1 109
char 1 112
char 1 116
char 1 101
char 1 100
char 1 32
char 1 116
char 1 111
char 1 32
char 1 108
char 1 111
char 1 97
char 1 100
char 1 32
char 1 97
char 1 110
char 1 32
char 1 117
char 1 110
char 1 115
char 1 117
char 1 112
char 1 112
char 1 111
char 1 114
char 1 116
char 1 101
char 1 100
char 1 32
char 1 109
char 1 117
char 1 108
char 1 116
char 1 105
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 32
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 33
char 1 32
char 1 40
char 1 98
char 1 97
char 1 100
char 1 32
char 1 111
char 1 114
char 1 32
char 1 109
char 1 105
char 1 115
char 1 115
char 1 105
char 1 110
char 1 103
char 1 32
char 1 98
char 1 111
char 1 110
char 1 101
char 1 44
char 1 32
char 1 111
char 1 114
char 1 32
char 1 109
char 1 105
char 1 115
char 1 115
char 1 105
char 1 110
char 1 103
char 1 32
char 1 97
char 1 110
char 1 105
char 1 109
char 1 97
char 1 116
char 1 105
char 1 111
char 1 110
char 1 32
char 1 115
char 1 101
char 1 113
char 1 117
char 1 101
char 1 110
char 1 99
char 1 101
char 1 41
char 1 10
char 1 0
align 1
LABELV $165
char 1 100
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 0
align 1
LABELV $164
char 1 107
char 1 121
char 1 108
char 1 101
char 1 0
align 1
LABELV $149
char 1 85
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 32
char 1 99
char 1 117
char 1 115
char 1 116
char 1 111
char 1 109
char 1 32
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 58
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $134
char 1 42
char 1 116
char 1 97
char 1 117
char 1 110
char 1 116
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $133
char 1 42
char 1 108
char 1 97
char 1 110
char 1 100
char 1 49
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $132
char 1 42
char 1 103
char 1 97
char 1 115
char 1 112
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $131
char 1 42
char 1 99
char 1 104
char 1 111
char 1 107
char 1 101
char 1 51
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $130
char 1 42
char 1 99
char 1 104
char 1 111
char 1 107
char 1 101
char 1 50
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $129
char 1 42
char 1 99
char 1 104
char 1 111
char 1 107
char 1 101
char 1 49
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $128
char 1 42
char 1 102
char 1 97
char 1 108
char 1 108
char 1 105
char 1 110
char 1 103
char 1 49
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $127
char 1 42
char 1 112
char 1 97
char 1 105
char 1 110
char 1 49
char 1 48
char 1 48
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $126
char 1 42
char 1 112
char 1 97
char 1 105
char 1 110
char 1 55
char 1 53
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $125
char 1 42
char 1 112
char 1 97
char 1 105
char 1 110
char 1 53
char 1 48
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $124
char 1 42
char 1 112
char 1 97
char 1 105
char 1 110
char 1 50
char 1 53
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $123
char 1 42
char 1 106
char 1 117
char 1 109
char 1 112
char 1 49
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $122
char 1 42
char 1 100
char 1 101
char 1 97
char 1 116
char 1 104
char 1 51
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $121
char 1 42
char 1 100
char 1 101
char 1 97
char 1 116
char 1 104
char 1 50
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $120
char 1 42
char 1 100
char 1 101
char 1 97
char 1 116
char 1 104
char 1 49
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
