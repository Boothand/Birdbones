bss
align 1
LABELV $130
skip 64
export CG_PlaceString
code
proc CG_PlaceString 116 20
file "../cg_event.c"
line 25
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_event.c -- handle entity events at snapshot or playerstate transitions
;4:
;5:#include "cg_local.h"
;6:#include "fx_local.h"
;7:#include "..\ghoul2\g2.h"
;8:#include "../ui/ui_shared.h"
;9:
;10:// for the voice chats
;11:#include "../../ui/menudef.h"
;12://==========================================================================
;13:
;14:extern int g_saberFlashTime;
;15:extern vec3_t g_saberFlashPos;
;16:extern char *showPowersName[];
;17:
;18:/*
;19:===================
;20:CG_PlaceString
;21:
;22:Also called by scoreboard drawing
;23:===================
;24:*/
;25:const char	*CG_PlaceString( int rank ) {
line 36
;26:	static char	str[64];
;27:	char	*s, *t;
;28:	// number extenstions, eg 1st, 2nd, 3rd, 4th etc.
;29:	// note that the rules are different for french, but by changing the required strip strings they seem to work
;30:	char sST[10];
;31:	char sND[10];
;32:	char sRD[10];
;33:	char sTH[10];
;34:	char sTiedFor[64];	// german is much longer, super safe...
;35:
;36:	trap_SP_GetStringTextString("INGAMETEXT_NUMBER_ST",sST, sizeof(sST) );
ADDRGP4 $131
ARGP4
ADDRLP4 64
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 37
;37:	trap_SP_GetStringTextString("INGAMETEXT_NUMBER_ND",sND, sizeof(sND) );
ADDRGP4 $132
ARGP4
ADDRLP4 74
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 38
;38:	trap_SP_GetStringTextString("INGAMETEXT_NUMBER_RD",sRD, sizeof(sRD) );
ADDRGP4 $133
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 39
;39:	trap_SP_GetStringTextString("INGAMETEXT_NUMBER_TH",sTH, sizeof(sTH) );
ADDRGP4 $134
ARGP4
ADDRLP4 94
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 40
;40:	trap_SP_GetStringTextString("INGAMETEXT_TIED_FOR" ,sTiedFor,sizeof(sTiedFor) );
ADDRGP4 $135
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 41
;41:	strcat(sTiedFor," ");	// save worrying about translators adding spaces or not
ADDRLP4 0
ARGP4
ADDRGP4 $136
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 43
;42:
;43:	if ( rank & RANK_TIED_FLAG ) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $137
line 44
;44:		rank &= ~RANK_TIED_FLAG;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 45
;45:		t = sTiedFor;//"Tied for ";
ADDRLP4 108
ADDRLP4 0
ASGNP4
line 46
;46:	} else {
ADDRGP4 $138
JUMPV
LABELV $137
line 47
;47:		t = "";
ADDRLP4 108
ADDRGP4 $139
ASGNP4
line 48
;48:	}
LABELV $138
line 50
;49:
;50:	if ( rank == 1 ) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $140
line 51
;51:		s = va("1%s",sST);//S_COLOR_BLUE "1st" S_COLOR_WHITE;		// draw in blue
ADDRGP4 $142
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 112
INDIRP4
ASGNP4
line 52
;52:	} else if ( rank == 2 ) {
ADDRGP4 $141
JUMPV
LABELV $140
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $143
line 53
;53:		s = va("2%s",sND);//S_COLOR_RED "2nd" S_COLOR_WHITE;		// draw in red
ADDRGP4 $145
ARGP4
ADDRLP4 74
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 112
INDIRP4
ASGNP4
line 54
;54:	} else if ( rank == 3 ) {
ADDRGP4 $144
JUMPV
LABELV $143
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $146
line 55
;55:		s = va("3%s",sRD);//S_COLOR_YELLOW "3rd" S_COLOR_WHITE;		// draw in yellow
ADDRGP4 $148
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 112
INDIRP4
ASGNP4
line 56
;56:	} else if ( rank == 11 ) {
ADDRGP4 $147
JUMPV
LABELV $146
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $149
line 57
;57:		s = va("11%s",sTH);
ADDRGP4 $151
ARGP4
ADDRLP4 94
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 112
INDIRP4
ASGNP4
line 58
;58:	} else if ( rank == 12 ) {
ADDRGP4 $150
JUMPV
LABELV $149
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $152
line 59
;59:		s = va("12%s",sTH);
ADDRGP4 $154
ARGP4
ADDRLP4 94
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 112
INDIRP4
ASGNP4
line 60
;60:	} else if ( rank == 13 ) {
ADDRGP4 $153
JUMPV
LABELV $152
ADDRFP4 0
INDIRI4
CNSTI4 13
NEI4 $155
line 61
;61:		s = va("13%s",sTH);
ADDRGP4 $157
ARGP4
ADDRLP4 94
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 112
INDIRP4
ASGNP4
line 62
;62:	} else if ( rank % 10 == 1 ) {
ADDRGP4 $156
JUMPV
LABELV $155
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $158
line 63
;63:		s = va("%i%s", rank,sST);
ADDRGP4 $160
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 64
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 112
INDIRP4
ASGNP4
line 64
;64:	} else if ( rank % 10 == 2 ) {
ADDRGP4 $159
JUMPV
LABELV $158
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
NEI4 $161
line 65
;65:		s = va("%i%s", rank,sND);
ADDRGP4 $160
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 74
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 112
INDIRP4
ASGNP4
line 66
;66:	} else if ( rank % 10 == 3 ) {
ADDRGP4 $162
JUMPV
LABELV $161
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 3
NEI4 $163
line 67
;67:		s = va("%i%s", rank,sRD);
ADDRGP4 $160
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 84
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 112
INDIRP4
ASGNP4
line 68
;68:	} else {
ADDRGP4 $164
JUMPV
LABELV $163
line 69
;69:		s = va("%i%s", rank,sTH);
ADDRGP4 $160
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 94
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 112
INDIRP4
ASGNP4
line 70
;70:	}
LABELV $164
LABELV $162
LABELV $159
LABELV $156
LABELV $153
LABELV $150
LABELV $147
LABELV $144
LABELV $141
line 72
;71:
;72:	Com_sprintf( str, sizeof( str ), "%s%s", t, s );
ADDRGP4 $130
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $165
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 73
;73:	return str;
ADDRGP4 $130
RETP4
LABELV $129
endproc CG_PlaceString 116 20
proc CG_Obituary 1168 24
line 83
;74:}
;75:
;76:qboolean CG_ThereIsAMaster(void);
;77:
;78:/*
;79:=============
;80:CG_Obituary
;81:=============
;82:*/
;83:static void CG_Obituary( entityState_t *ent ) {
line 94
;84:	int			mod;
;85:	int			target, attacker;
;86:	char		*message;
;87:	const char	*targetInfo;
;88:	const char	*attackerInfo;
;89:	char		targetName[32];
;90:	char		attackerName[32];
;91:	gender_t	gender;
;92:	clientInfo_t	*ci;
;93:
;94:	target = ent->otherEntityNum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 95
;95:	attacker = ent->otherEntityNum2;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 96
;96:	mod = ent->eventParm;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ASGNI4
line 98
;97:
;98:	if ( target < 0 || target >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $169
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $167
LABELV $169
line 99
;99:		CG_Error( "CG_Obituary: target out of range" );
ADDRGP4 $170
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 100
;100:	}
LABELV $167
line 101
;101:	ci = &cgs.clientinfo[target];
ADDRLP4 88
CNSTI4 788
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 103
;102:
;103:	if ( attacker < 0 || attacker >= MAX_CLIENTS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $174
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $172
LABELV $174
line 104
;104:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 105
;105:		attackerInfo = NULL;
ADDRLP4 52
CNSTP4 0
ASGNP4
line 106
;106:	} else {
ADDRGP4 $173
JUMPV
LABELV $172
line 107
;107:		attackerInfo = CG_ConfigString( CS_PLAYERS + attacker );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 104
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 104
INDIRP4
ASGNP4
line 108
;108:	}
LABELV $173
line 110
;109:
;110:	targetInfo = CG_ConfigString( CS_PLAYERS + target );
ADDRLP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 104
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 104
INDIRP4
ASGNP4
line 111
;111:	if ( !targetInfo ) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $175
line 112
;112:		return;
ADDRGP4 $166
JUMPV
LABELV $175
line 114
;113:	}
;114:	Q_strncpyz( targetName, Info_ValueForKey( targetInfo, "n" ), sizeof(targetName) - 2);
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 $177
ARGP4
ADDRLP4 108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 115
;115:	strcat( targetName, S_COLOR_WHITE );
ADDRLP4 12
ARGP4
ADDRGP4 $178
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 119
;116:
;117:	// check for single client messages
;118:
;119:	switch( mod ) {
ADDRLP4 44
INDIRI4
CNSTI4 29
LTI4 $179
ADDRLP4 44
INDIRI4
CNSTI4 37
GTI4 $179
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $183-116
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $183
address $181
address $181
address $181
address $181
address $179
address $181
address $181
address $181
address $181
code
LABELV $181
line 128
;120:	case MOD_SUICIDE:
;121:	case MOD_FALLING:
;122:	case MOD_CRUSH:
;123:	case MOD_WATER:
;124:	case MOD_SLIME:
;125:	case MOD_LAVA:
;126:	case MOD_TARGET_LASER:
;127:	case MOD_TRIGGER_HURT:
;128:		message = "DIED_GENERIC";
ADDRLP4 8
ADDRGP4 $182
ASGNP4
line 129
;129:		break;
ADDRGP4 $180
JUMPV
LABELV $179
line 131
;130:	default:
;131:		message = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 132
;132:		break;
LABELV $180
line 136
;133:	}
;134:
;135:	// Attacker killed themselves.  Ridicule them for it.
;136:	if (attacker == target) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $185
line 137
;137:		gender = ci->gender;
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
line 138
;138:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 4
LTI4 $187
ADDRLP4 44
INDIRI4
CNSTI4 34
GTI4 $187
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $228-16
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $228
address $189
address $189
address $189
address $189
address $189
address $189
address $189
address $189
address $189
address $197
address $205
address $187
address $189
address $197
address $197
address $197
address $197
address $197
address $197
address $197
address $197
address $197
address $197
address $187
address $187
address $187
address $187
address $187
address $187
address $187
address $213
code
LABELV $189
line 149
;139:		case MOD_BRYAR_PISTOL:
;140:		case MOD_BRYAR_PISTOL_ALT:
;141:		case MOD_BLASTER:
;142:		case MOD_DISRUPTOR:
;143:		case MOD_DISRUPTOR_SPLASH:
;144:		case MOD_DISRUPTOR_SNIPER:
;145:		case MOD_BOWCASTER:
;146:		case MOD_REPEATER:
;147:		case MOD_REPEATER_ALT:
;148:		case MOD_FLECHETTE:
;149:			if ( gender == GENDER_FEMALE )
ADDRLP4 92
INDIRI4
CNSTI4 1
NEI4 $190
line 150
;150:				message = "SUICIDE_SHOT_FEMALE";
ADDRLP4 8
ADDRGP4 $192
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $190
line 151
;151:			else if ( gender == GENDER_NEUTER )
ADDRLP4 92
INDIRI4
CNSTI4 2
NEI4 $193
line 152
;152:				message = "SUICIDE_SHOT_GENDERLESS";
ADDRLP4 8
ADDRGP4 $195
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $193
line 154
;153:			else
;154:				message = "SUICIDE_SHOT_MALE";
ADDRLP4 8
ADDRGP4 $196
ASGNP4
line 155
;155:			break;
ADDRGP4 $188
JUMPV
LABELV $197
line 167
;156:		case MOD_REPEATER_ALT_SPLASH:
;157:		case MOD_FLECHETTE_ALT_SPLASH:
;158:		case MOD_ROCKET:
;159:		case MOD_ROCKET_SPLASH:
;160:		case MOD_ROCKET_HOMING:
;161:		case MOD_ROCKET_HOMING_SPLASH:
;162:		case MOD_THERMAL:
;163:		case MOD_THERMAL_SPLASH:
;164:		case MOD_TRIP_MINE_SPLASH:
;165:		case MOD_TIMED_MINE_SPLASH:
;166:		case MOD_DET_PACK_SPLASH:
;167:			if ( gender == GENDER_FEMALE )
ADDRLP4 92
INDIRI4
CNSTI4 1
NEI4 $198
line 168
;168:				message = "SUICIDE_EXPLOSIVES_FEMALE";
ADDRLP4 8
ADDRGP4 $200
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $198
line 169
;169:			else if ( gender == GENDER_NEUTER )
ADDRLP4 92
INDIRI4
CNSTI4 2
NEI4 $201
line 170
;170:				message = "SUICIDE_EXPLOSIVES_GENDERLESS";
ADDRLP4 8
ADDRGP4 $203
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $201
line 172
;171:			else
;172:				message = "SUICIDE_EXPLOSIVES_MALE";
ADDRLP4 8
ADDRGP4 $204
ASGNP4
line 173
;173:			break;
ADDRGP4 $188
JUMPV
LABELV $205
line 175
;174:		case MOD_DEMP2:
;175:			if ( gender == GENDER_FEMALE )
ADDRLP4 92
INDIRI4
CNSTI4 1
NEI4 $206
line 176
;176:				message = "SUICIDE_ELECTROCUTED_FEMALE";
ADDRLP4 8
ADDRGP4 $208
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $206
line 177
;177:			else if ( gender == GENDER_NEUTER )
ADDRLP4 92
INDIRI4
CNSTI4 2
NEI4 $209
line 178
;178:				message = "SUICIDE_ELECTROCUTED_GENDERLESS";
ADDRLP4 8
ADDRGP4 $211
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $209
line 180
;179:			else
;180:				message = "SUICIDE_ELECTROCUTED_MALE";
ADDRLP4 8
ADDRGP4 $212
ASGNP4
line 181
;181:			break;
ADDRGP4 $188
JUMPV
LABELV $213
line 183
;182:		case MOD_FALLING:
;183:			if ( gender == GENDER_FEMALE )
ADDRLP4 92
INDIRI4
CNSTI4 1
NEI4 $214
line 184
;184:				message = "SUICIDE_FALLDEATH_FEMALE";
ADDRLP4 8
ADDRGP4 $216
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $214
line 185
;185:			else if ( gender == GENDER_NEUTER )
ADDRLP4 92
INDIRI4
CNSTI4 2
NEI4 $217
line 186
;186:				message = "SUICIDE_FALLDEATH_GENDERLESS";
ADDRLP4 8
ADDRGP4 $219
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $217
line 188
;187:			else
;188:				message = "SUICIDE_FALLDEATH_MALE";
ADDRLP4 8
ADDRGP4 $220
ASGNP4
line 189
;189:			break;
ADDRGP4 $188
JUMPV
LABELV $187
line 191
;190:		default:
;191:			if ( gender == GENDER_FEMALE )
ADDRLP4 92
INDIRI4
CNSTI4 1
NEI4 $221
line 192
;192:				message = "SUICIDE_GENERICDEATH_FEMALE";
ADDRLP4 8
ADDRGP4 $223
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $221
line 193
;193:			else if ( gender == GENDER_NEUTER )
ADDRLP4 92
INDIRI4
CNSTI4 2
NEI4 $224
line 194
;194:				message = "SUICIDE_GENERICDEATH_GENDERLESS";
ADDRLP4 8
ADDRGP4 $226
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $224
line 196
;195:			else
;196:				message = "SUICIDE_GENERICDEATH_MALE";
ADDRLP4 8
ADDRGP4 $227
ASGNP4
line 197
;197:			break;
LABELV $188
line 199
;198:		}
;199:	}
LABELV $185
line 201
;200:
;201:	if (target != attacker && target < MAX_CLIENTS && attacker < MAX_CLIENTS)
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $230
ADDRLP4 124
CNSTI4 32
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 124
INDIRI4
GEI4 $230
ADDRLP4 0
INDIRI4
ADDRLP4 124
INDIRI4
GEI4 $230
line 202
;202:	{
line 203
;203:		goto clientkilled;
ADDRGP4 $232
JUMPV
LABELV $230
line 206
;204:	}
;205:
;206:	if (message) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $233
line 207
;207:		gender = ci->gender;
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
line 209
;208:
;209:		if (!message[0])
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $235
line 210
;210:		{
line 211
;211:			if ( gender == GENDER_FEMALE )
ADDRLP4 92
INDIRI4
CNSTI4 1
NEI4 $237
line 212
;212:				message = "SUICIDE_GENERICDEATH_FEMALE";
ADDRLP4 8
ADDRGP4 $223
ASGNP4
ADDRGP4 $238
JUMPV
LABELV $237
line 213
;213:			else if ( gender == GENDER_NEUTER )
ADDRLP4 92
INDIRI4
CNSTI4 2
NEI4 $239
line 214
;214:				message = "SUICIDE_GENERICDEATH_GENDERLESS";
ADDRLP4 8
ADDRGP4 $226
ASGNP4
ADDRGP4 $240
JUMPV
LABELV $239
line 216
;215:			else
;216:				message = "SUICIDE_GENERICDEATH_MALE";
ADDRLP4 8
ADDRGP4 $227
ASGNP4
LABELV $240
LABELV $238
line 217
;217:		}
LABELV $235
line 218
;218:		message = (char *)CG_GetStripEdString("INGAMETEXT", message);
ADDRGP4 $241
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 128
INDIRP4
ASGNP4
line 220
;219:
;220:		CG_Printf( "%s %s\n", targetName, message);
ADDRGP4 $242
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 221
;221:		return;
ADDRGP4 $166
JUMPV
LABELV $233
LABELV $232
line 227
;222:	}
;223:
;224:clientkilled:
;225:
;226:	// check for kill messages from the current clientNum
;227:	if ( attacker == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $243
line 230
;228:		char	*s;
;229:
;230:		if ( cgs.gametype < GT_TEAM && cgs.gametype != GT_TOURNAMENT ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
GEI4 $246
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 3
EQI4 $246
line 231
;231:			if (cgs.gametype == GT_JEDIMASTER &&
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 2
NEI4 $250
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $250
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ADDRLP4 132
INDIRI4
NEI4 $250
ADDRGP4 cg+36
INDIRP4
CNSTI4 648
ADDP4
INDIRI4
ADDRLP4 132
INDIRI4
NEI4 $250
ADDRLP4 136
ADDRGP4 CG_ThereIsAMaster
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $250
line 236
;232:				attacker < MAX_CLIENTS &&
;233:				!ent->isJediMaster &&
;234:				!cg.snap->ps.isJediMaster &&
;235:				CG_ThereIsAMaster())
;236:			{
line 239
;237:				char part1[512];
;238:				char part2[512];
;239:				trap_SP_GetStringTextString("INGAMETEXT_KILLED_MESSAGE", part1, sizeof(part1));
ADDRGP4 $254
ARGP4
ADDRLP4 140
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 240
;240:				trap_SP_GetStringTextString("INGAMETEXT_JMKILLED_NOTJM", part2, sizeof(part2));
ADDRGP4 $255
ARGP4
ADDRLP4 652
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 241
;241:				s = va("%s %s\n%s\n", part1, targetName, part2);
ADDRGP4 $256
ARGP4
ADDRLP4 140
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 652
ARGP4
ADDRLP4 1164
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 128
ADDRLP4 1164
INDIRP4
ASGNP4
line 242
;242:			}
ADDRGP4 $247
JUMPV
LABELV $250
line 243
;243:			else if (cgs.gametype == GT_JEDIMASTER &&
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 2
NEI4 $257
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $257
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
NEI4 $257
ADDRGP4 cg+36
INDIRP4
CNSTI4 648
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
NEI4 $257
line 247
;244:				attacker < MAX_CLIENTS &&
;245:				!ent->isJediMaster &&
;246:				!cg.snap->ps.isJediMaster)
;247:			{ //no JM, saber must be out
line 249
;248:				char part1[512];
;249:				trap_SP_GetStringTextString("INGAMETEXT_KILLED_MESSAGE", part1, sizeof(part1));
ADDRGP4 $254
ARGP4
ADDRLP4 144
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 256
;250:				/*
;251:				kmsg1 = "for 0 points.\nGo for the saber!";
;252:				strcpy(part2, kmsg1);
;253:
;254:				s = va("%s %s %s\n", part1, targetName, part2);
;255:				*/
;256:				s = va("%s %s\n", part1, targetName);
ADDRGP4 $242
ARGP4
ADDRLP4 144
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 656
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 128
ADDRLP4 656
INDIRP4
ASGNP4
line 257
;257:			}
ADDRGP4 $247
JUMPV
LABELV $257
line 259
;258:			else
;259:			{
line 262
;260:				char sPlaceWith[256];
;261:				char sKilledStr[256];
;262:				trap_SP_GetStringTextString("INGAMETEXT_PLACE_WITH",     sPlaceWith, sizeof(sPlaceWith));
ADDRGP4 $261
ARGP4
ADDRLP4 144
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 263
;263:				trap_SP_GetStringTextString("INGAMETEXT_KILLED_MESSAGE", sKilledStr, sizeof(sKilledStr));
ADDRGP4 $254
ARGP4
ADDRLP4 400
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 265
;264:
;265:				s = va("%s %s.\n%s %s %i.", sKilledStr, targetName, 
ADDRGP4 cg+36
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 656
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $262
ARGP4
ADDRLP4 400
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 656
INDIRP4
ARGP4
ADDRLP4 144
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
ARGI4
ADDRLP4 660
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 128
ADDRLP4 660
INDIRP4
ASGNP4
line 269
;266:					CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ), 
;267:					sPlaceWith,
;268:					cg.snap->ps.persistant[PERS_SCORE] );
;269:			}
line 270
;270:		} else {
ADDRGP4 $247
JUMPV
LABELV $246
line 272
;271:			char sKilledStr[256];
;272:			trap_SP_GetStringTextString("INGAMETEXT_KILLED_MESSAGE", sKilledStr, sizeof(sKilledStr));
ADDRGP4 $254
ARGP4
ADDRLP4 132
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 273
;273:			s = va("%s %s", sKilledStr, targetName );
ADDRGP4 $265
ARGP4
ADDRLP4 132
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 388
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 128
ADDRLP4 388
INDIRP4
ASGNP4
line 274
;274:		}
LABELV $247
line 275
;275:		if (!(cg_singlePlayerActive.integer && cg_cameraOrbit.integer)) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 cg_singlePlayerActive+12
INDIRI4
ADDRLP4 132
INDIRI4
EQI4 $270
ADDRGP4 cg_cameraOrbit+12
INDIRI4
ADDRLP4 132
INDIRI4
NEI4 $266
LABELV $270
line 276
;276:			CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRLP4 128
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 277
;277:		} 
LABELV $266
line 279
;278:		// print the text message as well
;279:	}
LABELV $243
line 282
;280:
;281:	// check for double client messages
;282:	if ( !attackerInfo ) {
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $271
line 283
;283:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 284
;284:		strcpy( attackerName, "noname" );
ADDRLP4 56
ARGP4
ADDRGP4 $273
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 285
;285:	} else {
ADDRGP4 $272
JUMPV
LABELV $271
line 286
;286:		Q_strncpyz( attackerName, Info_ValueForKey( attackerInfo, "n" ), sizeof(attackerName) - 2);
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 $177
ARGP4
ADDRLP4 128
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 287
;287:		strcat( attackerName, S_COLOR_WHITE );
ADDRLP4 56
ARGP4
ADDRGP4 $178
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 289
;288:		// check for kill messages about the current clientNum
;289:		if ( target == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $274
line 290
;290:			Q_strncpyz( cg.killerName, attackerName, sizeof( cg.killerName ) );
ADDRGP4 cg+6984
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 291
;291:		}
LABELV $274
line 292
;292:	}
LABELV $272
line 294
;293:
;294:	if ( attacker != ENTITYNUM_WORLD ) {
ADDRLP4 0
INDIRI4
CNSTI4 1022
EQI4 $279
line 295
;295:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 1
LTI4 $281
ADDRLP4 44
INDIRI4
CNSTI4 37
GTI4 $281
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $332-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $332
address $283
address $285
address $287
address $289
address $289
address $291
address $293
address $293
address $295
address $297
address $299
address $301
address $301
address $303
address $303
address $305
address $307
address $309
address $309
address $311
address $311
address $313
address $313
address $315
address $317
address $319
address $321
address $323
address $281
address $281
address $281
address $327
address $325
address $329
address $281
address $281
address $331
code
LABELV $283
line 297
;296:		case MOD_STUN_BATON:
;297:			message = "KILLED_STUN";
ADDRLP4 8
ADDRGP4 $284
ASGNP4
line 298
;298:			break;
ADDRGP4 $282
JUMPV
LABELV $285
line 300
;299:		case MOD_MELEE:
;300:			message = "KILLED_MELEE";
ADDRLP4 8
ADDRGP4 $286
ASGNP4
line 301
;301:			break;
ADDRGP4 $282
JUMPV
LABELV $287
line 303
;302:		case MOD_SABER:
;303:			message = "KILLED_SABER";
ADDRLP4 8
ADDRGP4 $288
ASGNP4
line 304
;304:			break;
ADDRGP4 $282
JUMPV
LABELV $289
line 307
;305:		case MOD_BRYAR_PISTOL:
;306:		case MOD_BRYAR_PISTOL_ALT:
;307:			message = "KILLED_BRYAR";
ADDRLP4 8
ADDRGP4 $290
ASGNP4
line 308
;308:			break;
ADDRGP4 $282
JUMPV
LABELV $291
line 310
;309:		case MOD_BLASTER:
;310:			message = "KILLED_BLASTER";
ADDRLP4 8
ADDRGP4 $292
ASGNP4
line 311
;311:			break;
ADDRGP4 $282
JUMPV
LABELV $293
line 314
;312:		case MOD_DISRUPTOR:
;313:		case MOD_DISRUPTOR_SPLASH:
;314:			message = "KILLED_DISRUPTOR";
ADDRLP4 8
ADDRGP4 $294
ASGNP4
line 315
;315:			break;
ADDRGP4 $282
JUMPV
LABELV $295
line 317
;316:		case MOD_DISRUPTOR_SNIPER:
;317:			message = "KILLED_DISRUPTORSNIPE";
ADDRLP4 8
ADDRGP4 $296
ASGNP4
line 318
;318:			break;
ADDRGP4 $282
JUMPV
LABELV $297
line 320
;319:		case MOD_BOWCASTER:
;320:			message = "KILLED_BOWCASTER";
ADDRLP4 8
ADDRGP4 $298
ASGNP4
line 321
;321:			break;
ADDRGP4 $282
JUMPV
LABELV $299
line 323
;322:		case MOD_REPEATER:
;323:			message = "KILLED_REPEATER";
ADDRLP4 8
ADDRGP4 $300
ASGNP4
line 324
;324:			break;
ADDRGP4 $282
JUMPV
LABELV $301
line 327
;325:		case MOD_REPEATER_ALT:
;326:		case MOD_REPEATER_ALT_SPLASH:
;327:			message = "KILLED_REPEATERALT";
ADDRLP4 8
ADDRGP4 $302
ASGNP4
line 328
;328:			break;
ADDRGP4 $282
JUMPV
LABELV $303
line 331
;329:		case MOD_DEMP2:
;330:		case MOD_DEMP2_ALT:
;331:			message = "KILLED_DEMP2";
ADDRLP4 8
ADDRGP4 $304
ASGNP4
line 332
;332:			break;
ADDRGP4 $282
JUMPV
LABELV $305
line 334
;333:		case MOD_FLECHETTE:
;334:			message = "KILLED_FLECHETTE";
ADDRLP4 8
ADDRGP4 $306
ASGNP4
line 335
;335:			break;
ADDRGP4 $282
JUMPV
LABELV $307
line 337
;336:		case MOD_FLECHETTE_ALT_SPLASH:
;337:			message = "KILLED_FLECHETTE_MINE";
ADDRLP4 8
ADDRGP4 $308
ASGNP4
line 338
;338:			break;
ADDRGP4 $282
JUMPV
LABELV $309
line 341
;339:		case MOD_ROCKET:
;340:		case MOD_ROCKET_SPLASH:
;341:			message = "KILLED_ROCKET";
ADDRLP4 8
ADDRGP4 $310
ASGNP4
line 342
;342:			break;
ADDRGP4 $282
JUMPV
LABELV $311
line 345
;343:		case MOD_ROCKET_HOMING:
;344:		case MOD_ROCKET_HOMING_SPLASH:
;345:			message = "KILLED_ROCKET_HOMING";
ADDRLP4 8
ADDRGP4 $312
ASGNP4
line 346
;346:			break;
ADDRGP4 $282
JUMPV
LABELV $313
line 349
;347:		case MOD_THERMAL:
;348:		case MOD_THERMAL_SPLASH:
;349:			message = "KILLED_THERMAL";
ADDRLP4 8
ADDRGP4 $314
ASGNP4
line 350
;350:			break;
ADDRGP4 $282
JUMPV
LABELV $315
line 352
;351:		case MOD_TRIP_MINE_SPLASH:
;352:			message = "KILLED_TRIPMINE";
ADDRLP4 8
ADDRGP4 $316
ASGNP4
line 353
;353:			break;
ADDRGP4 $282
JUMPV
LABELV $317
line 355
;354:		case MOD_TIMED_MINE_SPLASH:
;355:			message = "KILLED_TRIPMINE_TIMED";
ADDRLP4 8
ADDRGP4 $318
ASGNP4
line 356
;356:			break;
ADDRGP4 $282
JUMPV
LABELV $319
line 358
;357:		case MOD_DET_PACK_SPLASH:
;358:			message = "KILLED_DETPACK";
ADDRLP4 8
ADDRGP4 $320
ASGNP4
line 359
;359:			break;
ADDRGP4 $282
JUMPV
LABELV $321
line 361
;360:		case MOD_FORCE_DARK:
;361:			message = "KILLED_DARKFORCE";
ADDRLP4 8
ADDRGP4 $322
ASGNP4
line 362
;362:			break;
ADDRGP4 $282
JUMPV
LABELV $323
line 364
;363:		case MOD_SENTRY:
;364:			message = "KILLED_SENTRY";
ADDRLP4 8
ADDRGP4 $324
ASGNP4
line 365
;365:			break;
ADDRGP4 $282
JUMPV
LABELV $325
line 367
;366:		case MOD_TELEFRAG:
;367:			message = "KILLED_TELEFRAG";
ADDRLP4 8
ADDRGP4 $326
ASGNP4
line 368
;368:			break;
ADDRGP4 $282
JUMPV
LABELV $327
line 370
;369:		case MOD_CRUSH:
;370:			message = "KILLED_GENERIC";//"KILLED_FORCETOSS";
ADDRLP4 8
ADDRGP4 $328
ASGNP4
line 371
;371:			break;
ADDRGP4 $282
JUMPV
LABELV $329
line 373
;372:		case MOD_FALLING:
;373:			message = "KILLED_FORCETOSS";
ADDRLP4 8
ADDRGP4 $330
ASGNP4
line 374
;374:			break;
ADDRGP4 $282
JUMPV
LABELV $331
line 376
;375:		case MOD_TRIGGER_HURT:
;376:			message = "KILLED_GENERIC";//"KILLED_FORCETOSS";
ADDRLP4 8
ADDRGP4 $328
ASGNP4
line 377
;377:			break;
ADDRGP4 $282
JUMPV
LABELV $281
line 379
;378:		default:
;379:			message = "KILLED_GENERIC";
ADDRLP4 8
ADDRGP4 $328
ASGNP4
line 380
;380:			break;
LABELV $282
line 383
;381:		}
;382:
;383:		if (message) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $334
line 384
;384:			message = (char *)CG_GetStripEdString("INGAMETEXT", message);
ADDRGP4 $241
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 132
INDIRP4
ASGNP4
line 386
;385:
;386:			CG_Printf( "%s %s %s\n", 
ADDRGP4 $336
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 388
;387:				targetName, message, attackerName);
;388:			return;
ADDRGP4 $166
JUMPV
LABELV $334
line 390
;389:		}
;390:	}
LABELV $279
line 393
;391:
;392:	// we don't know what it was
;393:	CG_Printf( "%s %s\n", targetName, (char *)CG_GetStripEdString("INGAMETEXT", "DIED_GENERIC") );
ADDRGP4 $241
ARGP4
ADDRGP4 $182
ARGP4
ADDRLP4 128
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRGP4 $242
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 394
;394:}
LABELV $166
endproc CG_Obituary 1168 24
export CG_ToggleBinoculars
proc CG_ToggleBinoculars 0 16
line 399
;395:
;396://==========================================================================
;397:
;398:void CG_ToggleBinoculars(centity_t *cent, int forceZoom)
;399:{
line 400
;400:	if (cent->currentState.number != cg.snap->ps.clientNum)
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
EQI4 $338
line 401
;401:	{
line 402
;402:		return;
ADDRGP4 $337
JUMPV
LABELV $338
line 405
;403:	}
;404:
;405:	if (cg.snap->ps.weaponstate != WEAPON_READY)
ADDRGP4 cg+36
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
EQI4 $341
line 406
;406:	{ //So we can't fool it and reactivate while switching to the saber or something.
line 407
;407:		return;
ADDRGP4 $337
JUMPV
LABELV $341
line 410
;408:	}
;409:
;410:	if (cg.snap->ps.weapon == WP_SABER)
ADDRGP4 cg+36
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
NEI4 $344
line 411
;411:	{ //No.
line 412
;412:		return;
ADDRGP4 $337
JUMPV
LABELV $344
line 415
;413:	}
;414:
;415:	if (forceZoom)
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $347
line 416
;416:	{
line 417
;417:		if (forceZoom == 2)
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $349
line 418
;418:		{
line 419
;419:			cg.snap->ps.zoomMode = 0;
ADDRGP4 cg+36
INDIRP4
CNSTI4 1364
ADDP4
CNSTI4 0
ASGNI4
line 420
;420:		}
ADDRGP4 $350
JUMPV
LABELV $349
line 421
;421:		else if (forceZoom == 1)
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $352
line 422
;422:		{
line 423
;423:			cg.snap->ps.zoomMode = 2;
ADDRGP4 cg+36
INDIRP4
CNSTI4 1364
ADDP4
CNSTI4 2
ASGNI4
line 424
;424:		}
LABELV $352
LABELV $350
line 425
;425:	}
LABELV $347
line 427
;426:
;427:	if (cg.snap->ps.zoomMode == 0)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1364
ADDP4
INDIRI4
CNSTI4 0
NEI4 $355
line 428
;428:	{
line 429
;429:		trap_S_StartSound( NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.media.zoomStart );
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+1264
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 430
;430:	}
ADDRGP4 $356
JUMPV
LABELV $355
line 431
;431:	else if (cg.snap->ps.zoomMode == 2)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1364
ADDP4
INDIRI4
CNSTI4 2
NEI4 $361
line 432
;432:	{
line 433
;433:		trap_S_StartSound( NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.media.zoomEnd );
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+1272
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 434
;434:	}
LABELV $361
LABELV $356
line 435
;435:}
LABELV $337
endproc CG_ToggleBinoculars 0 16
proc CG_UseItem 32 16
line 442
;436:
;437:/*
;438:===============
;439:CG_UseItem
;440:===============
;441:*/
;442:static void CG_UseItem( centity_t *cent ) {
line 448
;443:	clientInfo_t *ci;
;444:	int			itemNum, clientNum;
;445:	gitem_t		*item;
;446:	entityState_t *es;
;447:
;448:	es = &cent->currentState;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 450
;449:	
;450:	itemNum = (es->event & ~EV_EVENT_BITS) - EV_USE_ITEM0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 40
SUBI4
ASGNI4
line 451
;451:	if ( itemNum < 0 || itemNum > HI_NUM_HOLDABLE ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $370
ADDRLP4 0
INDIRI4
CNSTI4 7
LEI4 $368
LABELV $370
line 452
;452:		itemNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 453
;453:	}
LABELV $368
line 456
;454:
;455:	// print a message if the local player
;456:	if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $371
line 457
;457:		if ( !itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $374
line 459
;458:			//CG_CenterPrint( "No item to use", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
;459:		} else {
ADDRGP4 $375
JUMPV
LABELV $374
line 460
;460:			item = BG_FindItemForHoldable( itemNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForHoldable
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 24
INDIRP4
ASGNP4
line 461
;461:		}
LABELV $375
line 462
;462:	}
LABELV $371
line 464
;463:
;464:	switch ( itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $377
ADDRLP4 0
INDIRI4
CNSTI4 6
GTI4 $377
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $391
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $391
address $377
address $380
address $377
address $384
address $377
address $379
address $377
code
line 468
;465:	default:
;466:	case HI_NONE:
;467:		//trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useNothingSound );
;468:		break;
LABELV $379
line 471
;469:
;470:	case HI_BINOCULARS:
;471:		CG_ToggleBinoculars(cent, es->eventParm);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ToggleBinoculars
CALLV
pop
line 472
;472:		break;
ADDRGP4 $377
JUMPV
LABELV $380
line 475
;473:
;474:	case HI_SEEKER:
;475:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.deploySeeker );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+780
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 476
;476:		break;
ADDRGP4 $377
JUMPV
line 481
;477:
;478:	case HI_SHIELD:
;479:	case HI_DATAPAD:
;480:	case HI_SENTRY_GUN:
;481:		break;
LABELV $384
line 485
;482:
;483://	case HI_MEDKIT:
;484:	case HI_MEDPAC:
;485:		clientNum = cent->currentState.clientNum;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ASGNI4
line 486
;486:		if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 28
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $385
ADDRLP4 28
INDIRI4
CNSTI4 32
GEI4 $385
line 487
;487:			ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 16
CNSTI4 788
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 488
;488:			ci->medkitUsageTime = cg.time;
ADDRLP4 16
INDIRP4
CNSTI4 152
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 489
;489:		}
LABELV $385
line 490
;490:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.medkitSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+784
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 491
;491:		break;
LABELV $377
line 494
;492:	}
;493:
;494:	if (cg.snap && cg.snap->ps.clientNum == cent->currentState.number && itemNum != HI_BINOCULARS)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $392
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $392
ADDRLP4 0
INDIRI4
CNSTI4 5
EQI4 $392
line 495
;495:	{ //if not using binoculars, we just used that item up, so switch
line 496
;496:		BG_CycleInven(&cg.snap->ps, 1);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_CycleInven
CALLV
pop
line 497
;497:		cg.itemSelect = -1; //update the client-side selection display
ADDRGP4 cg+3504
CNSTI4 -1
ASGNI4
line 498
;498:	}
LABELV $392
line 499
;499:}
LABELV $367
endproc CG_UseItem 32 16
proc CG_ItemPickup 1044 12
line 509
;500:
;501:
;502:/*
;503:================
;504:CG_ItemPickup
;505:
;506:A new item was picked up this frame
;507:================
;508:*/
;509:static void CG_ItemPickup( int itemNum ) {
line 510
;510:	cg.itemPickup = itemNum;
ADDRGP4 cg+13348
ADDRFP4 0
INDIRI4
ASGNI4
line 511
;511:	cg.itemPickupTime = cg.time;
ADDRGP4 cg+13352
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 512
;512:	cg.itemPickupBlendTime = cg.time;
ADDRGP4 cg+13356
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 514
;513:	// see if it should be the grabbed weapon
;514:	if ( cg.snap && bg_itemlist[itemNum].giType == IT_WEAPON ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $404
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $404
line 521
;515:
;516:		// 0 == no switching
;517:		// 1 == automatically switch to best SAFE weapon
;518:		// 2 == automatically switch to best weapon, safe or otherwise
;519:		// 3 == if not saber, automatically switch to best weapon, safe or otherwise
;520:
;521:		if (0 == cg_autoswitch.integer)
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 0
NEI4 $408
line 522
;522:		{
line 524
;523:			// don't switch
;524:		}
ADDRGP4 $409
JUMPV
LABELV $408
line 525
;525:		else if ( cg_autoswitch.integer == 1)
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 1
NEI4 $411
line 526
;526:		{ //only autoselect if not explosive ("safe")
line 527
;527:			if (bg_itemlist[itemNum].giTag != WP_TRIP_MINE &&
ADDRLP4 0
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 12
EQI4 $412
ADDRLP4 0
INDIRI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 13
EQI4 $412
ADDRLP4 0
INDIRI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 11
EQI4 $412
ADDRLP4 0
INDIRI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 10
EQI4 $412
ADDRLP4 4
CNSTI4 192
ASGNI4
ADDRLP4 0
INDIRI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
LEI4 $412
ADDRGP4 cg+36
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $412
line 533
;528:				bg_itemlist[itemNum].giTag != WP_DET_PACK &&
;529:				bg_itemlist[itemNum].giTag != WP_THERMAL &&
;530:				bg_itemlist[itemNum].giTag != WP_ROCKET_LAUNCHER &&
;531:				bg_itemlist[itemNum].giTag > cg.snap->ps.weapon &&
;532:				cg.snap->ps.weapon != WP_SABER)
;533:			{
line 534
;534:				if (!cg.snap->ps.emplacedIndex)
ADDRGP4 cg+36
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
NEI4 $423
line 535
;535:				{
line 536
;536:					cg.weaponSelectTime = cg.time;
ADDRGP4 cg+13360
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 537
;537:				}
LABELV $423
line 538
;538:				cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+3496
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 539
;539:			}
line 540
;540:		}
ADDRGP4 $412
JUMPV
LABELV $411
line 541
;541:		else if ( cg_autoswitch.integer == 2)
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 2
NEI4 $430
line 542
;542:		{ //autoselect if better
line 543
;543:			if (bg_itemlist[itemNum].giTag > cg.snap->ps.weapon &&
ADDRLP4 0
CNSTI4 192
ASGNI4
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
LEI4 $433
ADDRGP4 cg+36
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $433
line 545
;544:				cg.snap->ps.weapon != WP_SABER)
;545:			{
line 546
;546:				if (!cg.snap->ps.emplacedIndex)
ADDRGP4 cg+36
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
NEI4 $438
line 547
;547:				{
line 548
;548:					cg.weaponSelectTime = cg.time;
ADDRGP4 cg+13360
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 549
;549:				}
LABELV $438
line 550
;550:				cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+3496
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 551
;551:			}
LABELV $433
line 552
;552:		}
LABELV $430
LABELV $412
LABELV $409
line 568
;553:		/*
;554:		else if ( cg_autoswitch.integer == 3)
;555:		{ //autoselect if better and not using the saber as a weapon
;556:			if (bg_itemlist[itemNum].giTag > cg.snap->ps.weapon &&
;557:				cg.snap->ps.weapon != WP_SABER)
;558:			{
;559:				if (!cg.snap->ps.emplacedIndex)
;560:				{
;561:					cg.weaponSelectTime = cg.time;
;562:				}
;563:				cg.weaponSelect = bg_itemlist[itemNum].giTag;
;564:			}
;565:		}
;566:		*/
;567:		//No longer required - just not switching ever if using saber
;568:	}
LABELV $404
line 571
;569:
;570:	//rww - print pickup messages
;571:	if (bg_itemlist[itemNum].classname && bg_itemlist[itemNum].classname[0] &&
ADDRLP4 0
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
ADDRLP4 0
INDIRI4
ADDRGP4 bg_itemlist
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $445
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $445
ADDRLP4 0
INDIRI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $450
ADDRLP4 0
INDIRI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 4
EQI4 $445
ADDRLP4 0
INDIRI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 5
EQI4 $445
LABELV $450
line 573
;572:		(bg_itemlist[itemNum].giType != IT_TEAM || (bg_itemlist[itemNum].giTag != PW_REDFLAG && bg_itemlist[itemNum].giTag != PW_BLUEFLAG)) )
;573:	{ //don't print messages for flags, they have their own pickup event broadcasts
line 576
;574:		char	text[1024];
;575:
;576:		if ( trap_SP_GetStringTextString( va("INGAME_%s",bg_itemlist[itemNum].classname), text, sizeof( text )))
ADDRGP4 $453
ARGP4
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1036
ADDRGP4 trap_SP_GetStringTextString
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $451
line 577
;577:		{
line 578
;578:			Com_Printf("%s %s\n", CG_GetStripEdString("INGAMETEXT", "PICKUPLINE"), text);
ADDRGP4 $241
ARGP4
ADDRGP4 $454
ARGP4
ADDRLP4 1040
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRGP4 $242
ARGP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 579
;579:		}
ADDRGP4 $452
JUMPV
LABELV $451
line 581
;580:		else
;581:		{
line 582
;582:			Com_Printf("%s %s\n", CG_GetStripEdString("INGAMETEXT", "PICKUPLINE"), bg_itemlist[itemNum].classname);
ADDRGP4 $241
ARGP4
ADDRGP4 $454
ARGP4
ADDRLP4 1040
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRGP4 $242
ARGP4
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 583
;583:		}
LABELV $452
line 584
;584:	}
LABELV $445
line 585
;585:}
LABELV $398
endproc CG_ItemPickup 1044 12
export CG_PainEvent
proc CG_PainEvent 12 16
line 595
;586:
;587:
;588:/*
;589:================
;590:CG_PainEvent
;591:
;592:Also called by playerstate transition
;593:================
;594:*/
;595:void CG_PainEvent( centity_t *cent, int health ) {
line 599
;596:	char	*snd;
;597:
;598:	// don't do more than two pain sounds a second
;599:	if ( cg.time - cent->pe.painTime < 500 ) {
ADDRGP4 cg+64
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
SUBI4
CNSTI4 500
GEI4 $456
line 600
;600:		return;
ADDRGP4 $455
JUMPV
LABELV $456
line 603
;601:	}
;602:
;603:	if ( health < 25 ) {
ADDRFP4 4
INDIRI4
CNSTI4 25
GEI4 $459
line 604
;604:		snd = "*pain25.wav";
ADDRLP4 0
ADDRGP4 $461
ASGNP4
line 605
;605:	} else if ( health < 50 ) {
ADDRGP4 $460
JUMPV
LABELV $459
ADDRFP4 4
INDIRI4
CNSTI4 50
GEI4 $462
line 606
;606:		snd = "*pain50.wav";
ADDRLP4 0
ADDRGP4 $464
ASGNP4
line 607
;607:	} else if ( health < 75 ) {
ADDRGP4 $463
JUMPV
LABELV $462
ADDRFP4 4
INDIRI4
CNSTI4 75
GEI4 $465
line 608
;608:		snd = "*pain75.wav";
ADDRLP4 0
ADDRGP4 $467
ASGNP4
line 609
;609:	} else {
ADDRGP4 $466
JUMPV
LABELV $465
line 610
;610:		snd = "*pain100.wav";
ADDRLP4 0
ADDRGP4 $468
ASGNP4
line 611
;611:	}
LABELV $466
LABELV $463
LABELV $460
line 612
;612:	trap_S_StartSound( NULL, cent->currentState.number, CHAN_VOICE, 
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 616
;613:		CG_CustomSound( cent->currentState.number, snd ) );
;614:
;615:	// save pain time for programitic twitch animation
;616:	cent->pe.painTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 836
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 617
;617:	cent->pe.painDirection	^= 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 618
;618:}
LABELV $455
endproc CG_PainEvent 12 16
export CG_ReattachLimb
proc CG_ReattachLimb 16 12
line 621
;619:
;620:void CG_ReattachLimb(centity_t *source)
;621:{
line 625
;622:	char *limbName;
;623:	char *stubCapName;
;624:
;625:	switch (source->torsoBolt)
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1012
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 10
LTI4 $471
ADDRLP4 8
INDIRI4
CNSTI4 15
GTI4 $471
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $492-40
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $492
address $474
address $477
address $480
address $483
address $486
address $489
code
line 626
;626:	{
LABELV $474
line 628
;627:	case G2_MODELPART_HEAD:
;628:		limbName = "head";
ADDRLP4 0
ADDRGP4 $475
ASGNP4
line 629
;629:		stubCapName = "torso_cap_head_off";
ADDRLP4 4
ADDRGP4 $476
ASGNP4
line 630
;630:		break;
ADDRGP4 $472
JUMPV
LABELV $477
line 632
;631:	case G2_MODELPART_WAIST:
;632:		limbName = "torso";
ADDRLP4 0
ADDRGP4 $478
ASGNP4
line 633
;633:		stubCapName = "hips_cap_torso_off";
ADDRLP4 4
ADDRGP4 $479
ASGNP4
line 634
;634:		break;
ADDRGP4 $472
JUMPV
LABELV $480
line 636
;635:	case G2_MODELPART_LARM:
;636:		limbName = "l_arm";
ADDRLP4 0
ADDRGP4 $481
ASGNP4
line 637
;637:		stubCapName = "torso_cap_l_arm_off";
ADDRLP4 4
ADDRGP4 $482
ASGNP4
line 638
;638:		break;
ADDRGP4 $472
JUMPV
LABELV $483
line 640
;639:	case G2_MODELPART_RARM:
;640:		limbName = "r_arm";
ADDRLP4 0
ADDRGP4 $484
ASGNP4
line 641
;641:		stubCapName = "torso_cap_r_arm_off";
ADDRLP4 4
ADDRGP4 $485
ASGNP4
line 642
;642:		break;
ADDRGP4 $472
JUMPV
LABELV $486
line 644
;643:	case G2_MODELPART_LLEG:
;644:		limbName = "l_leg";
ADDRLP4 0
ADDRGP4 $487
ASGNP4
line 645
;645:		stubCapName = "hips_cap_l_leg_off";
ADDRLP4 4
ADDRGP4 $488
ASGNP4
line 646
;646:		break;
ADDRGP4 $472
JUMPV
LABELV $489
line 648
;647:	case G2_MODELPART_RLEG:
;648:		limbName = "r_leg";
ADDRLP4 0
ADDRGP4 $490
ASGNP4
line 649
;649:		stubCapName = "hips_cap_r_leg_off";
ADDRLP4 4
ADDRGP4 $491
ASGNP4
line 650
;650:		break;
ADDRGP4 $472
JUMPV
LABELV $471
line 652
;651:	default:
;652:		limbName = "r_leg";
ADDRLP4 0
ADDRGP4 $490
ASGNP4
line 653
;653:		stubCapName = "hips_cap_r_leg_off";
ADDRLP4 4
ADDRGP4 $491
ASGNP4
line 654
;654:		break;
LABELV $472
line 657
;655:	}
;656:
;657:	trap_G2API_SetSurfaceOnOff(source->ghoul2, limbName, 0);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_G2API_SetSurfaceOnOff
CALLI4
pop
line 658
;658:	trap_G2API_SetSurfaceOnOff(source->ghoul2, stubCapName, 0x00000100);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_G2API_SetSurfaceOnOff
CALLI4
pop
line 660
;659:
;660:	source->torsoBolt = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1012
ADDP4
CNSTI4 0
ASGNI4
line 662
;661:
;662:	source->ghoul2weapon = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
CNSTP4 0
ASGNP4
line 663
;663:}
LABELV $470
endproc CG_ReattachLimb 16 12
proc CG_BodyQueueCopy 64 40
line 666
;664:
;665:static void CG_BodyQueueCopy(centity_t *cent, int clientNum, int knownWeapon)
;666:{
line 670
;667:	centity_t		*source;
;668:	animation_t		*anim;
;669:	float			animSpeed;
;670:	int				flags=BONE_ANIM_OVERRIDE_FREEZE;
ADDRLP4 12
CNSTI4 72
ASGNI4
line 673
;671:	clientInfo_t	*ci;
;672:
;673:	if (cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $495
line 674
;674:	{
line 675
;675:		trap_G2API_CleanGhoul2Models(&cent->ghoul2);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 676
;676:	}
LABELV $495
line 678
;677:
;678:	if (clientNum < 0 || clientNum >= MAX_CLIENTS)
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $499
ADDRLP4 20
INDIRI4
CNSTI4 32
LTI4 $497
LABELV $499
line 679
;679:	{
line 680
;680:		return;
ADDRGP4 $494
JUMPV
LABELV $497
line 683
;681:	}
;682:
;683:	source = &cg_entities[ clientNum ];
ADDRLP4 4
CNSTI4 1920
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 684
;684:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 16
CNSTI4 788
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 686
;685:
;686:	if (!source)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $501
line 687
;687:	{
line 688
;688:		return;
ADDRGP4 $494
JUMPV
LABELV $501
line 691
;689:	}
;690:
;691:	if (!source->ghoul2)
ADDRLP4 4
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $503
line 692
;692:	{
line 693
;693:		return;
ADDRGP4 $494
JUMPV
LABELV $503
line 696
;694:	}
;695:
;696:	cent->isATST = source->isATST;
ADDRLP4 24
CNSTI4 1028
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 698
;697:
;698:	cent->dustTrailTime = source->dustTrailTime;
ADDRLP4 28
CNSTI4 616
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 700
;699:
;700:	trap_G2API_DuplicateGhoul2Instance(source->ghoul2, &cent->ghoul2);
ADDRLP4 32
CNSTI4 952
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ARGP4
ADDRGP4 trap_G2API_DuplicateGhoul2Instance
CALLV
pop
line 703
;701:
;702:	//either force the weapon from when we died or remove it if it was a dropped weapon
;703:	if (knownWeapon > WP_BRYAR_PISTOL && trap_G2API_HasGhoul2ModelOnIndex(&(cent->ghoul2), 1))
ADDRFP4 8
INDIRI4
CNSTI4 3
LEI4 $505
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 trap_G2API_HasGhoul2ModelOnIndex
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $505
line 704
;704:	{
line 705
;705:		trap_G2API_RemoveGhoul2Model(&(cent->ghoul2), 1);
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
line 706
;706:	}
ADDRGP4 $506
JUMPV
LABELV $505
line 707
;707:	else if (trap_G2API_HasGhoul2ModelOnIndex(&(cent->ghoul2), 1))
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 trap_G2API_HasGhoul2ModelOnIndex
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $507
line 708
;708:	{
line 709
;709:		trap_G2API_CopySpecificGhoul2Model(g2WeaponInstances[knownWeapon], 0, cent->ghoul2, 1);
ADDRFP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g2WeaponInstances
ADDP4
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
line 710
;710:	}
LABELV $507
LABELV $506
line 712
;711:
;712:	anim = &bgGlobalAnimations[ cent->currentState.torsoAnim ];
ADDRLP4 0
CNSTI4 28
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
MULI4
ADDRGP4 bgGlobalAnimations
ADDP4
ASGNP4
line 713
;713:	animSpeed = 50.0f / anim->frameLerp;
ADDRLP4 8
CNSTF4 1112014848
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 716
;714:
;715:	//this will just set us to the last frame of the animation, in theory
;716:	if (source->isATST)
ADDRLP4 4
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $509
line 717
;717:	{
line 718
;718:		int aNum = cgs.clientinfo[source->currentState.number].frame+1;
ADDRLP4 44
CNSTI4 788
ADDRLP4 4
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+76
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 719
;719:		anim = &bgGlobalAnimations[ BOTH_DEAD1 ];
ADDRLP4 0
ADDRGP4 bgGlobalAnimations+1176
ASGNP4
line 720
;720:		animSpeed = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 722
;721:
;722:		flags &= ~BONE_ANIM_OVERRIDE_LOOP;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
ADDRGP4 $515
JUMPV
LABELV $514
line 725
;723:
;724:		while (aNum >= anim->firstFrame+anim->numFrames)
;725:		{
line 726
;726:			aNum--;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 727
;727:		}
LABELV $515
line 724
ADDRLP4 44
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
GEI4 $514
line 729
;728:
;729:		trap_G2API_SetBoneAnim(cent->ghoul2, 0, "pelvis", aNum, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, 150);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $517
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
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
line 730
;730:	}
ADDRGP4 $510
JUMPV
LABELV $509
line 732
;731:	else
;732:	{
line 733
;733:		int aNum = cgs.clientinfo[source->currentState.number].frame+1;
ADDRLP4 44
CNSTI4 788
ADDRLP4 4
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+76
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $522
JUMPV
LABELV $521
line 736
;734:
;735:		while (aNum >= anim->firstFrame+anim->numFrames)
;736:		{
line 737
;737:			aNum--;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 738
;738:		}
LABELV $522
line 735
ADDRLP4 44
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
GEI4 $521
line 740
;739:
;740:		if (aNum < anim->firstFrame-1)
ADDRLP4 44
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $524
line 741
;741:		{ //wrong animation...?
line 742
;742:			aNum = (anim->firstFrame+anim->numFrames)-1;
ADDRLP4 44
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
ASGNI4
line 743
;743:		}
LABELV $524
line 750
;744:
;745:		//if (!cgs.clientinfo[source->currentState.number].frame || (cent->currentState.torsoAnim&~ANIM_TOGGLEBIT) != (source->currentState.torsoAnim&~ANIM_TOGGLEBIT) )
;746:		//{
;747:		//	aNum = (anim->firstFrame+anim->numFrames)-1;
;748:		//}
;749:
;750:		trap_G2API_SetBoneAnim(cent->ghoul2, 0, "upper_lumbar", aNum, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, 150);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $526
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
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
line 751
;751:		trap_G2API_SetBoneAnim(cent->ghoul2, 0, "model_root", aNum, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, 150);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $528
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
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
line 752
;752:		trap_G2API_SetBoneAnim(cent->ghoul2, 0, "Motion", aNum, anim->firstFrame + anim->numFrames, flags, animSpeed, cg.time, -1, 150);
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $530
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
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
line 753
;753:	}
LABELV $510
line 756
;754:
;755:	//After we create the bodyqueue, regenerate any limbs on the real instance
;756:	if (source->torsoBolt)
ADDRLP4 4
INDIRP4
CNSTI4 1012
ADDP4
INDIRI4
CNSTI4 0
EQI4 $532
line 757
;757:	{
line 758
;758:		CG_ReattachLimb(source);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CG_ReattachLimb
CALLV
pop
line 759
;759:	}
LABELV $532
line 760
;760:}
LABELV $494
endproc CG_BodyQueueCopy 64 40
export CG_TeamName
proc CG_TeamName 0 0
line 763
;761:
;762:const char *CG_TeamName(int team)
;763:{
line 764
;764:	if (team==TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $535
line 765
;765:		return "RED";
ADDRGP4 $537
RETP4
ADDRGP4 $534
JUMPV
LABELV $535
line 766
;766:	else if (team==TEAM_BLUE)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $538
line 767
;767:		return "BLUE";
ADDRGP4 $540
RETP4
ADDRGP4 $534
JUMPV
LABELV $538
line 768
;768:	else if (team==TEAM_SPECTATOR)
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $541
line 769
;769:		return "SPECTATOR";
ADDRGP4 $543
RETP4
ADDRGP4 $534
JUMPV
LABELV $541
line 770
;770:	return "FREE";
ADDRGP4 $544
RETP4
LABELV $534
endproc CG_TeamName 0 0
export CG_PrintCTFMessage
proc CG_PrintCTFMessage 1076 20
line 774
;771:}
;772:
;773:void CG_PrintCTFMessage(clientInfo_t *ci, const char *teamName, int ctfMessage)
;774:{
line 776
;775:	char printMsg[1024];
;776:	char *refName = NULL;
ADDRLP4 1028
CNSTP4 0
ASGNP4
line 777
;777:	const char *stripEdString = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 779
;778:
;779:	switch (ctfMessage)
ADDRLP4 1032
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
LTI4 $545
ADDRLP4 1032
INDIRI4
CNSTI4 4
GTI4 $545
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $558
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $558
address $548
address $550
address $552
address $554
address $556
code
line 780
;780:	{
LABELV $548
line 782
;781:	case CTFMESSAGE_FRAGGED_FLAG_CARRIER:
;782:		refName = "FRAGGED_FLAG_CARRIER";
ADDRLP4 1028
ADDRGP4 $549
ASGNP4
line 783
;783:		break;
ADDRGP4 $547
JUMPV
LABELV $550
line 785
;784:	case CTFMESSAGE_FLAG_RETURNED:
;785:		refName = "FLAG_RETURNED";
ADDRLP4 1028
ADDRGP4 $551
ASGNP4
line 786
;786:		break;
ADDRGP4 $547
JUMPV
LABELV $552
line 788
;787:	case CTFMESSAGE_PLAYER_RETURNED_FLAG:
;788:		refName = "PLAYER_RETURNED_FLAG";
ADDRLP4 1028
ADDRGP4 $553
ASGNP4
line 789
;789:		break;
ADDRGP4 $547
JUMPV
LABELV $554
line 791
;790:	case CTFMESSAGE_PLAYER_CAPTURED_FLAG:
;791:		refName = "PLAYER_CAPTURED_FLAG";
ADDRLP4 1028
ADDRGP4 $555
ASGNP4
line 792
;792:		break;
ADDRGP4 $547
JUMPV
LABELV $556
line 794
;793:	case CTFMESSAGE_PLAYER_GOT_FLAG:
;794:		refName = "PLAYER_GOT_FLAG";
ADDRLP4 1028
ADDRGP4 $557
ASGNP4
line 795
;795:		break;
line 797
;796:	default:
;797:		return;
LABELV $547
line 800
;798:	}
;799:
;800:	stripEdString = CG_GetStripEdString("INGAMETEXT", refName);
ADDRGP4 $241
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1036
INDIRP4
ASGNP4
line 802
;801:
;802:	if (!stripEdString || !stripEdString[0])
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $561
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $559
LABELV $561
line 803
;803:	{
line 804
;804:		return;
ADDRGP4 $545
JUMPV
LABELV $559
line 807
;805:	}
;806:
;807:	if (teamName && teamName[0])
ADDRLP4 1044
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1044
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $562
ADDRLP4 1044
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $562
line 808
;808:	{
line 809
;809:		const char *f = strstr(stripEdString, "%s");
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $564
ARGP4
ADDRLP4 1052
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1048
ADDRLP4 1052
INDIRP4
ASGNP4
line 811
;810:
;811:		if (f)
ADDRLP4 1048
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $565
line 812
;812:		{
line 813
;813:			int strLen = 0;
ADDRLP4 1060
CNSTI4 0
ASGNI4
line 814
;814:			int i = 0;
ADDRLP4 1056
CNSTI4 0
ASGNI4
line 816
;815:
;816:			if (ci)
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $571
line 817
;817:			{
line 818
;818:				Com_sprintf(printMsg, sizeof(printMsg), "%s ", ci->name);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $569
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 819
;819:				strLen = strlen(printMsg);
ADDRLP4 4
ARGP4
ADDRLP4 1064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1064
INDIRI4
ASGNI4
line 820
;820:			}
ADDRGP4 $571
JUMPV
LABELV $570
line 823
;821:
;822:			while (stripEdString[i] && i < 512)
;823:			{
line 824
;824:				if (stripEdString[i] == '%' &&
ADDRLP4 1056
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 37
NEI4 $573
ADDRLP4 1056
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 115
NEI4 $573
line 826
;825:					stripEdString[i+1] == 's')
;826:				{
line 827
;827:					printMsg[strLen] = '\0';
ADDRLP4 1060
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 828
;828:					Q_strcat(printMsg, sizeof(printMsg), teamName);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 829
;829:					strLen = strlen(printMsg);
ADDRLP4 4
ARGP4
ADDRLP4 1072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1072
INDIRI4
ASGNI4
line 831
;830:
;831:					i++;
ADDRLP4 1056
ADDRLP4 1056
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 832
;832:				}
ADDRGP4 $574
JUMPV
LABELV $573
line 834
;833:				else
;834:				{
line 835
;835:					printMsg[strLen] = stripEdString[i];
ADDRLP4 1060
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 1056
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 836
;836:					strLen++;
ADDRLP4 1060
ADDRLP4 1060
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 837
;837:				}
LABELV $574
line 839
;838:
;839:				i++;
ADDRLP4 1056
ADDRLP4 1056
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 840
;840:			}
LABELV $571
line 822
ADDRLP4 1056
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $575
ADDRLP4 1056
INDIRI4
CNSTI4 512
LTI4 $570
LABELV $575
line 842
;841:
;842:			printMsg[strLen] = '\0';
ADDRLP4 1060
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 844
;843:
;844:			goto doPrint;
ADDRGP4 $576
JUMPV
LABELV $565
line 846
;845:		}
;846:	}
LABELV $562
line 848
;847:
;848:	if (ci)
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $577
line 849
;849:	{
line 850
;850:		Com_sprintf(printMsg, sizeof(printMsg), "%s %s", ci->name, stripEdString);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $265
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 851
;851:	}
ADDRGP4 $578
JUMPV
LABELV $577
line 853
;852:	else
;853:	{
line 854
;854:		Com_sprintf(printMsg, sizeof(printMsg), "%s", stripEdString);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $564
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 855
;855:	}
LABELV $578
LABELV $576
line 858
;856:
;857:doPrint:
;858:	Com_Printf("%s\n", printMsg);
ADDRGP4 $579
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 859
;859:}
LABELV $545
endproc CG_PrintCTFMessage 1076 20
export CG_GetCTFMessageEvent
proc CG_GetCTFMessageEvent 20 12
line 862
;860:
;861:void CG_GetCTFMessageEvent(entityState_t *es)
;862:{
line 863
;863:	int clIndex = es->trickedentindex;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 864
;864:	int teamIndex = es->trickedentindex2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ASGNI4
line 865
;865:	clientInfo_t *ci = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 866
;866:	const char *teamName = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 868
;867:
;868:	if (clIndex < MAX_CLIENTS)
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $581
line 869
;869:	{
line 870
;870:		ci = &cgs.clientinfo[clIndex];
ADDRLP4 8
CNSTI4 788
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 871
;871:	}
LABELV $581
line 873
;872:
;873:	if (teamIndex < 50)
ADDRLP4 4
INDIRI4
CNSTI4 50
GEI4 $584
line 874
;874:	{
line 875
;875:		teamName = CG_TeamName(teamIndex);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 CG_TeamName
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 876
;876:	}
LABELV $584
line 878
;877:
;878:	CG_PrintCTFMessage(ci, teamName, es->eventParm);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PrintCTFMessage
CALLV
pop
line 879
;879:}
LABELV $580
endproc CG_GetCTFMessageEvent 20 12
export DoFall
proc DoFall 8 16
line 882
;880:
;881:void DoFall(centity_t *cent, entityState_t *es, int clientNum)
;882:{
line 883
;883:	int delta = es->eventParm;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ASGNI4
line 885
;884:
;885:	if (cent->currentState.eFlags & EF_DEAD)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $587
line 886
;886:	{ //corpses crack into the ground ^_^
line 887
;887:		if (delta > 25)
ADDRLP4 0
INDIRI4
CNSTI4 25
LEI4 $589
line 888
;888:		{
line 889
;889:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.fallSound );
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+728
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 890
;890:		}
ADDRGP4 $588
JUMPV
LABELV $589
line 892
;891:		else
;892:		{
line 893
;893:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, trap_S_RegisterSound( "sound/movers/objects/objectHit.wav" ) );
ADDRGP4 $593
ARGP4
ADDRLP4 4
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 894
;894:		}
line 895
;895:	}
ADDRGP4 $588
JUMPV
LABELV $587
line 896
;896:	else if (delta > 50)
ADDRLP4 0
INDIRI4
CNSTI4 50
LEI4 $594
line 897
;897:	{
line 898
;898:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.fallSound );
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+728
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 899
;899:		trap_S_StartSound( NULL, cent->currentState.number, CHAN_VOICE, 
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $598
ARGP4
ADDRLP4 4
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 901
;900:			CG_CustomSound( cent->currentState.number, "*land1.wav" ) );
;901:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 836
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 902
;902:	}
ADDRGP4 $595
JUMPV
LABELV $594
line 903
;903:	else if (delta > 44)
ADDRLP4 0
INDIRI4
CNSTI4 44
LEI4 $600
line 904
;904:	{
line 905
;905:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.fallSound );
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+728
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 906
;906:		trap_S_StartSound( NULL, cent->currentState.number, CHAN_VOICE, 
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $598
ARGP4
ADDRLP4 4
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 908
;907:			CG_CustomSound( cent->currentState.number, "*land1.wav" ) );
;908:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 836
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 909
;909:	}
ADDRGP4 $601
JUMPV
LABELV $600
line 911
;910:	else
;911:	{
line 912
;912:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.landSound );
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+724
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 913
;913:	}
LABELV $601
LABELV $595
LABELV $588
line 915
;914:	
;915:	if ( clientNum == cg.predictedPlayerState.clientNum )
ADDRFP4 8
INDIRI4
ADDRGP4 cg+96+144
INDIRI4
NEI4 $607
line 916
;916:	{
line 918
;917:		// smooth landing z changes
;918:		cg.landChange = -delta;
ADDRGP4 cg+3488
ADDRLP4 0
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 919
;919:		if (cg.landChange > 32)
ADDRGP4 cg+3488
INDIRF4
CNSTF4 1107296256
LEF4 $612
line 920
;920:		{
line 921
;921:			cg.landChange = 32;
ADDRGP4 cg+3488
CNSTF4 1107296256
ASGNF4
line 922
;922:		}
LABELV $612
line 923
;923:		if (cg.landChange < -32)
ADDRGP4 cg+3488
INDIRF4
CNSTF4 3254779904
GEF4 $616
line 924
;924:		{
line 925
;925:			cg.landChange = -32;
ADDRGP4 cg+3488
CNSTF4 3254779904
ASGNF4
line 926
;926:		}
LABELV $616
line 927
;927:		cg.landTime = cg.time;
ADDRGP4 cg+3492
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 928
;928:	}
LABELV $607
line 929
;929:}
LABELV $586
endproc DoFall 8 16
export CG_InClientBitflags
proc CG_InClientBitflags 8 0
line 932
;930:
;931:int CG_InClientBitflags(entityState_t *ent, int client)
;932:{
line 934
;933:	int checkIn;
;934:	int sub = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 936
;935:
;936:	if (client > 47)
ADDRFP4 4
INDIRI4
CNSTI4 47
LEI4 $623
line 937
;937:	{
line 938
;938:		checkIn = ent->trickedentindex4;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 939
;939:		sub = 48;
ADDRLP4 0
CNSTI4 48
ASGNI4
line 940
;940:	}
ADDRGP4 $624
JUMPV
LABELV $623
line 941
;941:	else if (client > 31)
ADDRFP4 4
INDIRI4
CNSTI4 31
LEI4 $625
line 942
;942:	{
line 943
;943:		checkIn = ent->trickedentindex3;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
ASGNI4
line 944
;944:		sub = 32;
ADDRLP4 0
CNSTI4 32
ASGNI4
line 945
;945:	}
ADDRGP4 $626
JUMPV
LABELV $625
line 946
;946:	else if (client > 15)
ADDRFP4 4
INDIRI4
CNSTI4 15
LEI4 $627
line 947
;947:	{
line 948
;948:		checkIn = ent->trickedentindex2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ASGNI4
line 949
;949:		sub = 16;
ADDRLP4 0
CNSTI4 16
ASGNI4
line 950
;950:	}
ADDRGP4 $628
JUMPV
LABELV $627
line 952
;951:	else
;952:	{
line 953
;953:		checkIn = ent->trickedentindex;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 954
;954:	}
LABELV $628
LABELV $626
LABELV $624
line 956
;955:
;956:	if (checkIn & (1 << (client-sub)))
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $629
line 957
;957:	{
line 958
;958:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $622
JUMPV
LABELV $629
line 961
;959:	}
;960:	
;961:	return 0;
CNSTI4 0
RETI4
LABELV $622
endproc CG_InClientBitflags 8 0
lit
align 4
LABELV $1053
byte 4 3245342720
byte 4 3245342720
byte 4 3246391296
align 4
LABELV $1054
byte 4 1097859072
byte 4 1097859072
byte 4 1109393408
align 4
LABELV $1295
byte 4 3245342720
byte 4 3245342720
byte 4 3246391296
align 4
LABELV $1296
byte 4 1097859072
byte 4 1097859072
byte 4 1109393408
align 4
LABELV $1313
byte 4 3245342720
byte 4 3245342720
byte 4 3246391296
align 4
LABELV $1314
byte 4 1097859072
byte 4 1097859072
byte 4 1109393408
export CG_EntityEvent
code
proc CG_EntityEvent 1248 36
line 973
;962:}
;963:
;964:/*
;965:==============
;966:CG_EntityEvent
;967:
;968:An entity has an event value
;969:also called by CG_CheckPlayerstateEvents
;970:==============
;971:*/
;972:#define	DEBUGNAME(x) if(cg_debugEvents.integer){CG_Printf(x"\n");}
;973:void CG_EntityEvent( centity_t *cent, vec3_t position ) {
line 980
;974:	entityState_t	*es;
;975:	int				event;
;976:	vec3_t			dir;
;977:	const char		*s;
;978:	int				clientNum;
;979:	clientInfo_t	*ci;
;980:	int				eID = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 981
;981:	int				isnd = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 984
;982:	centity_t		*cl_ent;
;983:
;984:	es = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 985
;985:	event = es->event & ~EV_EVENT_BITS;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 987
;986:
;987:	if ( cg_debugEvents.integer ) {
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $632
line 988
;988:		CG_Printf( "ent:%3i  event:%3i ", es->number, event );
ADDRGP4 $635
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 989
;989:	}
LABELV $632
line 991
;990:
;991:	if ( !event ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $636
line 992
;992:		DEBUGNAME("ZEROEVENT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $631
ADDRGP4 $641
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 993
;993:		return;
ADDRGP4 $631
JUMPV
LABELV $636
line 996
;994:	}
;995:
;996:	clientNum = es->clientNum;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ASGNI4
line 997
;997:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $644
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $642
LABELV $644
line 998
;998:		clientNum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 999
;999:	}
LABELV $642
line 1000
;1000:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 36
CNSTI4 788
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 1002
;1001:
;1002:	switch ( event ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $646
ADDRLP4 8
INDIRI4
CNSTI4 109
GTI4 $646
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1739-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1739
address $648
address $655
address $665
address $676
address $687
address $698
address $718
address $718
address $718
address $718
address $709
address $748
address $753
address $770
address $776
address $831
address $838
address $845
address $852
address $858
address $910
address $924
address $938
address $945
address $983
address $996
address $1002
address $1022
address $1043
address $1049
address $1069
address $1089
address $1109
address $1116
address $1123
address $1136
address $1160
address $1182
address $646
address $1192
address $1197
address $1202
address $1207
address $1212
address $1217
address $1222
address $1227
address $1232
address $1237
address $1242
address $1247
address $1252
address $1257
address $1262
address $646
address $1267
address $1332
address $1325
address $1290
address $1308
address $1340
address $1413
address $1439
address $1474
address $1490
address $1499
address $1516
address $1527
address $1585
address $1594
address $1599
address $1604
address $1418
address $1425
address $1432
address $646
address $1621
address $1629
address $1629
address $1629
address $1640
address $1645
address $1656
address $1667
address $1677
address $1345
address $1350
address $1355
address $1360
address $1365
address $1377
address $1388
address $1401
address $1407
address $1696
address $1705
address $1714
address $1719
address $1724
address $1691
address $1682
address $789
address $795
address $801
address $807
address $813
address $819
address $825
address $1729
code
LABELV $648
line 1007
;1003:	//
;1004:	// movement generated events
;1005:	//
;1006:	case EV_CLIENTJOIN:
;1007:		DEBUGNAME("EV_CLIENTJOIN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $649
ADDRGP4 $652
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $649
line 1010
;1008:
;1009:		//Slight hack to force a local reinit of client entity on join.
;1010:		cl_ent = &cg_entities[es->eventParm];
ADDRLP4 32
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1012
;1011:
;1012:		if (cl_ent)
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $647
line 1013
;1013:		{
line 1014
;1014:			cl_ent->isATST = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1028
ADDP4
CNSTI4 0
ASGNI4
line 1015
;1015:			cl_ent->atstFootClang = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 0
ASGNI4
line 1016
;1016:			cl_ent->atstSwinging = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1036
ADDP4
CNSTI4 0
ASGNI4
line 1017
;1017:			cl_ent->torsoBolt = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1012
ADDP4
CNSTI4 0
ASGNI4
line 1018
;1018:			cl_ent->bolt1 = 0;
ADDRLP4 32
INDIRP4
CNSTI4 984
ADDP4
CNSTI4 0
ASGNI4
line 1019
;1019:			cl_ent->bolt2 = 0;
ADDRLP4 32
INDIRP4
CNSTI4 988
ADDP4
CNSTI4 0
ASGNI4
line 1020
;1020:			cl_ent->bolt3 = 0;
ADDRLP4 32
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 0
ASGNI4
line 1021
;1021:			cl_ent->bolt4 = 0;
ADDRLP4 32
INDIRP4
CNSTI4 996
ADDP4
CNSTI4 0
ASGNI4
line 1022
;1022:			cl_ent->saberLength = SABER_LENGTH_MAX;
ADDRLP4 32
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1109393408
ASGNF4
line 1023
;1023:			cl_ent->saberExtendTime = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1004
ADDP4
CNSTI4 0
ASGNI4
line 1024
;1024:			cl_ent->boltInfo = 0;
ADDRLP4 32
INDIRP4
CNSTI4 980
ADDP4
CNSTI4 0
ASGNI4
line 1025
;1025:			cl_ent->frame_minus1_refreshed = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1464
ADDP4
CNSTI4 0
ASGNI4
line 1026
;1026:			cl_ent->frame_minus2_refreshed = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1468
ADDP4
CNSTI4 0
ASGNI4
line 1027
;1027:			cl_ent->frame_hold_time = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1684
ADDP4
CNSTI4 0
ASGNI4
line 1028
;1028:			cl_ent->frame_hold_refreshed = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1688
ADDP4
CNSTI4 0
ASGNI4
line 1029
;1029:			cl_ent->trickAlpha = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1904
ADDP4
CNSTI4 0
ASGNI4
line 1030
;1030:			cl_ent->trickAlphaTime = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1908
ADDP4
CNSTI4 0
ASGNI4
line 1031
;1031:			cl_ent->ghoul2weapon = NULL;
ADDRLP4 32
INDIRP4
CNSTI4 960
ADDP4
CNSTP4 0
ASGNP4
line 1032
;1032:			cl_ent->weapon = WP_NONE;
ADDRLP4 32
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 0
ASGNI4
line 1033
;1033:			cl_ent->teamPowerEffectTime = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1912
ADDP4
CNSTI4 0
ASGNI4
line 1034
;1034:			cl_ent->teamPowerType = 0;
ADDRLP4 32
INDIRP4
CNSTI4 1916
ADDP4
CNSTI4 0
ASGNI4
line 1035
;1035:		}
line 1036
;1036:		break;
ADDRGP4 $647
JUMPV
LABELV $655
line 1039
;1037:
;1038:	case EV_FOOTSTEP:
;1039:		DEBUGNAME("EV_FOOTSTEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $656
ADDRGP4 $659
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $656
line 1040
;1040:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $647
line 1041
;1041:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 52
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 36
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
line 1043
;1042:				cgs.media.footsteps[ ci->footsteps ][rand()&3] );
;1043:		}
line 1044
;1044:		break;
ADDRGP4 $647
JUMPV
LABELV $665
line 1046
;1045:	case EV_FOOTSTEP_METAL:
;1046:		DEBUGNAME("EV_FOOTSTEP_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $666
ADDRGP4 $669
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $666
line 1047
;1047:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $647
line 1048
;1048:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 52
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+616+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1050
;1049:				cgs.media.footsteps[ FOOTSTEP_METAL ][rand()&3] );
;1050:		}
line 1051
;1051:		break;
ADDRGP4 $647
JUMPV
LABELV $676
line 1053
;1052:	case EV_FOOTSPLASH:
;1053:		DEBUGNAME("EV_FOOTSPLASH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $677
ADDRGP4 $680
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $677
line 1054
;1054:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $647
line 1055
;1055:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 52
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
line 1057
;1056:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;1057:		}
line 1058
;1058:		break;
ADDRGP4 $647
JUMPV
LABELV $687
line 1060
;1059:	case EV_FOOTWADE:
;1060:		DEBUGNAME("EV_FOOTWADE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $688
ADDRGP4 $691
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $688
line 1061
;1061:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $647
line 1062
;1062:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 52
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
line 1064
;1063:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;1064:		}
line 1065
;1065:		break;
ADDRGP4 $647
JUMPV
LABELV $698
line 1067
;1066:	case EV_SWIM:
;1067:		DEBUGNAME("EV_SWIM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $699
ADDRGP4 $702
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $699
line 1068
;1068:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $647
line 1069
;1069:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 52
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
line 1071
;1070:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;1071:		}
line 1072
;1072:		break;
ADDRGP4 $647
JUMPV
LABELV $709
line 1076
;1073:
;1074:
;1075:	case EV_FALL:
;1076:		DEBUGNAME("EV_FALL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $710
ADDRGP4 $713
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $710
line 1077
;1077:		if (es->number == cg.snap->ps.clientNum && cg.snap->ps.fallingToDeath)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $714
ADDRGP4 cg+36
INDIRP4
CNSTI4 1384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $714
line 1078
;1078:		{
line 1079
;1079:			break;
ADDRGP4 $647
JUMPV
LABELV $714
line 1081
;1080:		}
;1081:		DoFall(cent, es, clientNum);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 DoFall
CALLV
pop
line 1082
;1082:		break;
ADDRGP4 $647
JUMPV
LABELV $718
line 1087
;1083:	case EV_STEP_4:
;1084:	case EV_STEP_8:
;1085:	case EV_STEP_12:
;1086:	case EV_STEP_16:		// smooth out step up transitions
;1087:		DEBUGNAME("EV_STEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $719
ADDRGP4 $722
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $719
line 1088
;1088:	{
line 1093
;1089:		float	oldStep;
;1090:		int		delta;
;1091:		int		step;
;1092:
;1093:		if ( clientNum != cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+96+144
INDIRI4
EQI4 $723
line 1094
;1094:			break;
ADDRGP4 $647
JUMPV
LABELV $723
line 1097
;1095:		}
;1096:		// if we are interpolating, we don't need to smooth steps
;1097:		if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ||
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 cg+8
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $735
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 64
INDIRI4
NEI4 $735
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $735
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $727
LABELV $735
line 1098
;1098:			cg_nopredict.integer || cg_synchronousClients.integer ) {
line 1099
;1099:			break;
ADDRGP4 $647
JUMPV
LABELV $727
line 1102
;1100:		}
;1101:		// check for stepping up before a previous step is completed
;1102:		delta = cg.time - cg.stepTime;
ADDRLP4 52
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+3476
INDIRI4
SUBI4
ASGNI4
line 1103
;1103:		if (delta < STEP_TIME) {
ADDRLP4 52
INDIRI4
CNSTI4 200
GEI4 $738
line 1104
;1104:			oldStep = cg.stepChange * (STEP_TIME - delta) / STEP_TIME;
ADDRLP4 56
ADDRGP4 cg+3472
INDIRF4
CNSTI4 200
ADDRLP4 52
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 1105
;1105:		} else {
ADDRGP4 $739
JUMPV
LABELV $738
line 1106
;1106:			oldStep = 0;
ADDRLP4 56
CNSTF4 0
ASGNF4
line 1107
;1107:		}
LABELV $739
line 1110
;1108:
;1109:		// add this amount
;1110:		step = 4 * (event - EV_STEP_4 + 1 );
ADDRLP4 60
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 28
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 1111
;1111:		cg.stepChange = oldStep + step;
ADDRGP4 cg+3472
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1112
;1112:		if ( cg.stepChange > MAX_STEP_CHANGE ) {
ADDRGP4 cg+3472
INDIRF4
CNSTF4 1107296256
LEF4 $742
line 1113
;1113:			cg.stepChange = MAX_STEP_CHANGE;
ADDRGP4 cg+3472
CNSTF4 1107296256
ASGNF4
line 1114
;1114:		}
LABELV $742
line 1115
;1115:		cg.stepTime = cg.time;
ADDRGP4 cg+3476
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1116
;1116:		break;
ADDRGP4 $647
JUMPV
LABELV $748
line 1120
;1117:	}
;1118:
;1119:	case EV_JUMP_PAD:
;1120:		DEBUGNAME("EV_JUMP_PAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $647
ADDRGP4 $752
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1121
;1121:		break;
ADDRGP4 $647
JUMPV
LABELV $753
line 1124
;1122:
;1123:	case EV_PRIVATE_DUEL:
;1124:		DEBUGNAME("EV_PRIVATE_DUEL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $754
ADDRGP4 $757
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $754
line 1126
;1125:
;1126:		if (cg.snap->ps.clientNum != es->number)
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
EQI4 $758
line 1127
;1127:		{
line 1128
;1128:			break;
ADDRGP4 $647
JUMPV
LABELV $758
line 1131
;1129:		}
;1130:
;1131:		if (es->eventParm)
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
EQI4 $761
line 1132
;1132:		{ //starting the duel
line 1133
;1133:			if (es->eventParm == 2)
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 2
NEI4 $763
line 1134
;1134:			{
line 1135
;1135:				CG_CenterPrint( CG_GetStripEdString("SVINGAME", "BEGIN_DUEL"), 120, GIANTCHAR_WIDTH*2 );				
ADDRGP4 $765
ARGP4
ADDRGP4 $766
ARGP4
ADDRLP4 52
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 120
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1136
;1136:				trap_S_StartLocalSound( cgs.media.countFightSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+70280+864
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1137
;1137:			}
ADDRGP4 $647
JUMPV
LABELV $763
line 1139
;1138:			else
;1139:			{
line 1140
;1140:				trap_S_StartBackgroundTrack( "music/mp/duel.mp3", "music/mp/duel.mp3", qfalse );
ADDRLP4 52
ADDRGP4 $769
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_StartBackgroundTrack
CALLV
pop
line 1141
;1141:			}
line 1142
;1142:		}
ADDRGP4 $647
JUMPV
LABELV $761
line 1144
;1143:		else
;1144:		{ //ending the duel
line 1145
;1145:			CG_StartMusic(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 CG_StartMusic
CALLV
pop
line 1146
;1146:		}
line 1147
;1147:		break;
ADDRGP4 $647
JUMPV
LABELV $770
line 1150
;1148:
;1149:	case EV_JUMP:
;1150:		DEBUGNAME("EV_JUMP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $771
ADDRGP4 $774
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $771
line 1151
;1151:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $775
ARGP4
ADDRLP4 52
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1152
;1152:		break;
ADDRGP4 $647
JUMPV
LABELV $776
line 1154
;1153:	case EV_ROLL:
;1154:		DEBUGNAME("EV_ROLL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $777
ADDRGP4 $780
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $777
line 1155
;1155:		if (es->number == cg.snap->ps.clientNum && cg.snap->ps.fallingToDeath)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $781
ADDRGP4 cg+36
INDIRP4
CNSTI4 1384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $781
line 1156
;1156:		{
line 1157
;1157:			break;
ADDRGP4 $647
JUMPV
LABELV $781
line 1159
;1158:		}
;1159:		if (es->eventParm)
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
EQI4 $785
line 1160
;1160:		{ //fall-roll-in-one event
line 1161
;1161:			DoFall(cent, es, clientNum);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 DoFall
CALLV
pop
line 1162
;1162:		}
LABELV $785
line 1164
;1163:
;1164:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $775
ARGP4
ADDRLP4 56
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1165
;1165:		trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.rollSound  );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+70280+764
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1168
;1166:
;1167:		//FIXME: need some sort of body impact on ground sound and maybe kick up some dust?
;1168:		break;
ADDRGP4 $647
JUMPV
LABELV $789
line 1171
;1169:
;1170:	case EV_TAUNT:
;1171:		DEBUGNAME("EV_TAUNT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $790
ADDRGP4 $793
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $790
line 1172
;1172:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*taunt.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $794
ARGP4
ADDRLP4 60
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1173
;1173:		break;
ADDRGP4 $647
JUMPV
LABELV $795
line 1175
;1174:	case EV_TAUNT_YES:
;1175:		DEBUGNAME("EV_TAUNT_YES");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $796
ADDRGP4 $799
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $796
line 1176
;1176:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_YES);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $800
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 1177
;1177:		break;
ADDRGP4 $647
JUMPV
LABELV $801
line 1179
;1178:	case EV_TAUNT_NO:
;1179:		DEBUGNAME("EV_TAUNT_NO");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $802
ADDRGP4 $805
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $802
line 1180
;1180:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_NO);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $806
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 1181
;1181:		break;
ADDRGP4 $647
JUMPV
LABELV $807
line 1183
;1182:	case EV_TAUNT_FOLLOWME:
;1183:		DEBUGNAME("EV_TAUNT_FOLLOWME");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $808
ADDRGP4 $811
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $808
line 1184
;1184:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_FOLLOWME);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $812
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 1185
;1185:		break;
ADDRGP4 $647
JUMPV
LABELV $813
line 1187
;1186:	case EV_TAUNT_GETFLAG:
;1187:		DEBUGNAME("EV_TAUNT_GETFLAG");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $814
ADDRGP4 $817
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $814
line 1188
;1188:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONGETFLAG);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $818
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 1189
;1189:		break;
ADDRGP4 $647
JUMPV
LABELV $819
line 1191
;1190:	case EV_TAUNT_GUARDBASE:
;1191:		DEBUGNAME("EV_TAUNT_GUARDBASE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $820
ADDRGP4 $823
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $820
line 1192
;1192:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONDEFENSE);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $824
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 1193
;1193:		break;
ADDRGP4 $647
JUMPV
LABELV $825
line 1195
;1194:	case EV_TAUNT_PATROL:
;1195:		DEBUGNAME("EV_TAUNT_PATROL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $826
ADDRGP4 $829
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $826
line 1196
;1196:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONPATROL);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $830
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 1197
;1197:		break;
ADDRGP4 $647
JUMPV
LABELV $831
line 1199
;1198:	case EV_WATER_TOUCH:
;1199:		DEBUGNAME("EV_WATER_TOUCH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $832
ADDRGP4 $835
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $832
line 1200
;1200:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+768
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1201
;1201:		break;
ADDRGP4 $647
JUMPV
LABELV $838
line 1203
;1202:	case EV_WATER_LEAVE:
;1203:		DEBUGNAME("EV_WATER_LEAVE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $839
ADDRGP4 $842
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $839
line 1204
;1204:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+772
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1205
;1205:		break;
ADDRGP4 $647
JUMPV
LABELV $845
line 1207
;1206:	case EV_WATER_UNDER:
;1207:		DEBUGNAME("EV_WATER_UNDER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $846
ADDRGP4 $849
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $846
line 1208
;1208:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrUnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+776
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1209
;1209:		break;
ADDRGP4 $647
JUMPV
LABELV $852
line 1211
;1210:	case EV_WATER_CLEAR:
;1211:		DEBUGNAME("EV_WATER_CLEAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $853
ADDRGP4 $856
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $853
line 1212
;1212:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*gasp.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $857
ARGP4
ADDRLP4 64
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1213
;1213:		break;
ADDRGP4 $647
JUMPV
LABELV $858
line 1216
;1214:
;1215:	case EV_ITEM_PICKUP:
;1216:		DEBUGNAME("EV_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $859
ADDRGP4 $862
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $859
line 1217
;1217:		{
line 1220
;1218:			gitem_t	*item;
;1219:			int		index;
;1220:			qboolean	newindex = qfalse;
ADDRLP4 68
CNSTI4 0
ASGNI4
line 1222
;1221:
;1222:			index = cg_entities[es->eventParm].currentState.modelindex;		// player predicted
ADDRLP4 72
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+212
ADDP4
INDIRI4
ASGNI4
line 1224
;1223:
;1224:			if (index < 1 && cg_entities[es->eventParm].currentState.isJediMaster)
ADDRLP4 72
INDIRI4
CNSTI4 1
GEI4 $864
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+244
ADDP4
INDIRI4
CNSTI4 0
EQI4 $864
line 1225
;1225:			{ //a holocron most likely
line 1226
;1226:				index = cg_entities[es->eventParm].currentState.trickedentindex4;
ADDRLP4 72
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+160
ADDP4
INDIRI4
ASGNI4
line 1227
;1227:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.holocronPickup );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+1260
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1229
;1228:								
;1229:				if (es->number == cg.snap->ps.clientNum && showPowersName[index])
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $870
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 showPowersName
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $870
line 1230
;1230:				{
line 1231
;1231:					const char *strText = CG_GetStripEdString("INGAMETEXT", "PICKUPLINE");
ADDRGP4 $241
ARGP4
ADDRGP4 $454
ARGP4
ADDRLP4 84
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 84
INDIRP4
ASGNP4
line 1234
;1232:
;1233:					//Com_Printf("%s %s\n", strText, showPowersName[index]);
;1234:					CG_CenterPrint( va("%s %s\n", strText, CG_GetStripEdString("INGAME",showPowersName[index])), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $873
ARGP4
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 showPowersName
ADDP4
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRGP4 $242
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1235
;1235:				}
LABELV $870
line 1238
;1236:
;1237:				//Show the player their force selection bar in case picking the holocron up changed the current selection
;1238:				if (index != FP_SABERATTACK && index != FP_SABERDEFEND && index != FP_SABERTHROW &&
ADDRLP4 80
ADDRLP4 72
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 15
EQI4 $874
ADDRLP4 80
INDIRI4
CNSTI4 16
EQI4 $874
ADDRLP4 80
INDIRI4
CNSTI4 17
EQI4 $874
ADDRLP4 84
CNSTI4 1
ASGNI4
ADDRLP4 80
INDIRI4
ADDRLP4 84
INDIRI4
EQI4 $874
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $874
ADDRLP4 88
CNSTI4 884
ASGNI4
ADDRLP4 80
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
EQI4 $880
ADDRGP4 cg+36
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $874
LABELV $880
line 1242
;1239:					index != FP_LEVITATION &&
;1240:					es->number == cg.snap->ps.clientNum &&
;1241:					(index == cg.snap->ps.fd.forcePowerSelected || !(cg.snap->ps.fd.forcePowersActive & (1 << cg.snap->ps.fd.forcePowerSelected))))
;1242:				{
line 1243
;1243:					if (cg.forceSelect != index)
ADDRGP4 cg+3500
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $881
line 1244
;1244:					{
line 1245
;1245:						cg.forceSelect = index;
ADDRGP4 cg+3500
ADDRLP4 72
INDIRI4
ASGNI4
line 1246
;1246:						newindex = qtrue;
ADDRLP4 68
CNSTI4 1
ASGNI4
line 1247
;1247:					}
LABELV $881
line 1248
;1248:				}
LABELV $874
line 1250
;1249:
;1250:				if (es->number == cg.snap->ps.clientNum && newindex)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $647
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $647
line 1251
;1251:				{
line 1252
;1252:					if (cg.forceSelectTime < cg.time)
ADDRGP4 cg+13780
INDIRF4
ADDRGP4 cg+64
INDIRI4
CVIF4 4
GEF4 $647
line 1253
;1253:					{
line 1254
;1254:						cg.forceSelectTime = cg.time;
ADDRGP4 cg+13780
ADDRGP4 cg+64
INDIRI4
CVIF4 4
ASGNF4
line 1255
;1255:					}
line 1256
;1256:				}
line 1258
;1257:
;1258:				break;
ADDRGP4 $647
JUMPV
LABELV $864
line 1261
;1259:			}
;1260:
;1261:			if (cg_entities[es->eventParm].weapon >= cg.time)
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+956
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LTI4 $894
line 1262
;1262:			{ //rww - an unfortunately necessary hack to prevent double item pickups
line 1263
;1263:				break;
ADDRGP4 $647
JUMPV
LABELV $894
line 1270
;1264:			}
;1265:
;1266:			//Hopefully even if this entity is somehow removed and replaced with, say, another
;1267:			//item, this time will have expired by the time that item needs to be picked up.
;1268:			//Of course, it's quite possible this will fail miserably, so if you've got a better
;1269:			//solution then please do use it.
;1270:			cg_entities[es->eventParm].weapon = cg.time+500;
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+956
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1272
;1271:
;1272:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 80
ADDRLP4 72
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 1
LTI4 $902
ADDRLP4 80
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $900
LABELV $902
line 1273
;1273:				break;
ADDRGP4 $647
JUMPV
LABELV $900
line 1275
;1274:			}
;1275:			item = &bg_itemlist[ index ];
ADDRLP4 76
CNSTI4 52
ADDRLP4 72
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 1277
;1276:
;1277:			if ( /*item->giType != IT_POWERUP && */item->giType != IT_TEAM) {
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $903
line 1278
;1278:				if (item->pickup_sound && item->pickup_sound[0])
ADDRLP4 84
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $905
ADDRLP4 84
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $905
line 1279
;1279:				{
line 1280
;1280:					trap_S_StartSound (NULL, es->number, CHAN_AUTO,	trap_S_RegisterSound( item->pickup_sound ) );
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1281
;1281:				}
LABELV $905
line 1282
;1282:			}
LABELV $903
line 1285
;1283:
;1284:			// show icon and name on status bar
;1285:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $647
line 1286
;1286:				CG_ItemPickup( index );
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 1287
;1287:			}
line 1288
;1288:		}
line 1289
;1289:		break;
ADDRGP4 $647
JUMPV
LABELV $910
line 1292
;1290:
;1291:	case EV_GLOBAL_ITEM_PICKUP:
;1292:		DEBUGNAME("EV_GLOBAL_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $911
ADDRGP4 $914
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $911
line 1293
;1293:		{
line 1297
;1294:			gitem_t	*item;
;1295:			int		index;
;1296:
;1297:			index = es->eventParm;		// player predicted
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ASGNI4
line 1299
;1298:
;1299:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 76
ADDRLP4 68
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 1
LTI4 $917
ADDRLP4 76
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $915
LABELV $917
line 1300
;1300:				break;
ADDRGP4 $647
JUMPV
LABELV $915
line 1302
;1301:			}
;1302:			item = &bg_itemlist[ index ];
ADDRLP4 72
CNSTI4 52
ADDRLP4 68
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 1304
;1303:			// powerup pickups are global
;1304:			if( item->pickup_sound && item->pickup_sound[0] ) {
ADDRLP4 80
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $918
ADDRLP4 80
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $918
line 1305
;1305:				trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, trap_S_RegisterSound( item->pickup_sound) );
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1306
;1306:			}
LABELV $918
line 1309
;1307:
;1308:			// show icon and name on status bar
;1309:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $647
line 1310
;1310:				CG_ItemPickup( index );
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 1311
;1311:			}
line 1312
;1312:		}
line 1313
;1313:		break;
ADDRGP4 $647
JUMPV
LABELV $924
line 1319
;1314:
;1315:	//
;1316:	// weapon events
;1317:	//
;1318:	case EV_NOAMMO:
;1319:		DEBUGNAME("EV_NOAMMO");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $925
ADDRGP4 $928
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $925
line 1321
;1320://		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound );
;1321:		if ( es->number == cg.snap->ps.clientNum )
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $647
line 1322
;1322:		{
line 1323
;1323:			int weap = 0;
ADDRLP4 68
CNSTI4 0
ASGNI4
line 1325
;1324:
;1325:			if (es->eventParm && es->eventParm < WP_NUM_WEAPONS)
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $932
ADDRLP4 72
INDIRI4
CNSTI4 16
GEI4 $932
line 1326
;1326:			{
line 1327
;1327:				cg.snap->ps.stats[STAT_WEAPONS] &= ~(1 << es->eventParm);
ADDRLP4 76
ADDRGP4 cg+36
INDIRP4
CNSTI4 276
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
LSHI4
BCOMI4
BANDI4
ASGNI4
line 1328
;1328:				weap = cg.snap->ps.weapon;
ADDRLP4 68
ADDRGP4 cg+36
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 1329
;1329:			}
ADDRGP4 $933
JUMPV
LABELV $932
line 1330
;1330:			else if (es->eventParm)
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
EQI4 $936
line 1331
;1331:			{
line 1332
;1332:				weap = (es->eventParm-WP_NUM_WEAPONS);
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 1333
;1333:			}
LABELV $936
LABELV $933
line 1334
;1334:			CG_OutOfAmmoChange(weap);
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 1335
;1335:		}
line 1336
;1336:		break;
ADDRGP4 $647
JUMPV
LABELV $938
line 1338
;1337:	case EV_CHANGE_WEAPON:
;1338:		DEBUGNAME("EV_CHANGE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $939
ADDRGP4 $942
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $939
line 1339
;1339:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.selectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+612
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1340
;1340:		break;
ADDRGP4 $647
JUMPV
LABELV $945
line 1342
;1341:	case EV_FIRE_WEAPON:
;1342:		DEBUGNAME("EV_FIRE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $946
ADDRGP4 $949
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $946
line 1343
;1343:		if (cent->currentState.number >= MAX_CLIENTS)
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 32
LTI4 $950
line 1344
;1344:		{ //special case for turret firing
line 1348
;1345:			vec3_t gunpoint, gunangle;
;1346:			mdxaBone_t matrix;
;1347:
;1348:			weaponInfo_t *weaponInfo = &cg_weapons[WP_TURRET];
ADDRLP4 68
ADDRGP4 cg_weapons+3120
ASGNP4
line 1350
;1349:
;1350:			if ( !weaponInfo->registered )
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $953
line 1351
;1351:			{
line 1352
;1352:				memset( weaponInfo, 0, sizeof( *weaponInfo ) );
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1354
;1353:
;1354:				weaponInfo->flashSound[0]		= NULL_SOUND;
ADDRLP4 68
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 0
ASGNI4
line 1355
;1355:				weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 1356
;1356:				weaponInfo->chargeSound			= NULL_SOUND;
ADDRLP4 68
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 1357
;1357:				weaponInfo->muzzleEffect		= NULL_HANDLE;
ADDRLP4 68
INDIRP4
CNSTI4 92
ADDP4
CNSTI4 0
ASGNI4
line 1358
;1358:				weaponInfo->missileModel		= NULL_HANDLE;
ADDRLP4 68
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 1359
;1359:				weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 68
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 1360
;1360:				weaponInfo->missileDlight		= 0;
ADDRLP4 68
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 1361
;1361:				weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 68
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 1362
;1362:				weaponInfo->missileTrailFunc	= FX_TurretProjectileThink;
ADDRLP4 68
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 FX_TurretProjectileThink
ASGNP4
line 1364
;1363:
;1364:				trap_FX_RegisterEffect("effects/blaster/wall_impact.efx");
ADDRGP4 $955
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 1365
;1365:				trap_FX_RegisterEffect("effects/blaster/flesh_impact.efx");
ADDRGP4 $956
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 1367
;1366:
;1367:				weaponInfo->registered = qtrue;
ADDRLP4 68
INDIRP4
CNSTI4 1
ASGNI4
line 1368
;1368:			}
LABELV $953
line 1370
;1369:
;1370:			if (cent->ghoul2)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $647
line 1371
;1371:			{
line 1372
;1372:				if (!cent->bolt1)
ADDRFP4 0
INDIRP4
CNSTI4 984
ADDP4
INDIRI4
CNSTI4 0
NEI4 $959
line 1373
;1373:				{
line 1374
;1374:					cent->bolt1 = trap_G2API_AddBolt(cent->ghoul2, 0, "*flash01");
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $961
ARGP4
ADDRLP4 148
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 144
INDIRP4
CNSTI4 984
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 1375
;1375:				}
LABELV $959
line 1376
;1376:				if (!cent->bolt2)
ADDRFP4 0
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
CNSTI4 0
NEI4 $958
line 1377
;1377:				{
line 1378
;1378:					cent->bolt2 = trap_G2API_AddBolt(cent->ghoul2, 0, "*flash02");
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $964
ARGP4
ADDRLP4 148
ADDRGP4 trap_G2API_AddBolt
CALLI4
ASGNI4
ADDRLP4 144
INDIRP4
CNSTI4 988
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 1379
;1379:				}
line 1380
;1380:			}
line 1382
;1381:			else
;1382:			{
line 1383
;1383:				break;
LABELV $958
line 1386
;1384:			}
;1385:
;1386:			if (cent->currentState.eventParm)
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
EQI4 $965
line 1387
;1387:			{
line 1388
;1388:				trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cent->bolt2, &matrix, cent->currentState.angles, cent->currentState.origin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 144
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 1389
;1389:			}
ADDRGP4 $966
JUMPV
LABELV $965
line 1391
;1390:			else
;1391:			{
line 1392
;1392:				trap_G2API_GetBoltMatrix(cent->ghoul2, 0, cent->bolt1, &matrix, cent->currentState.angles, cent->currentState.origin, cg.time, cgs.gameModels, cent->modelScale);
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 952
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 144
INDIRP4
CNSTI4 984
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 cg+64
INDIRI4
ARGI4
ADDRGP4 cgs+36348
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 964
ADDP4
ARGP4
ADDRGP4 trap_G2API_GetBoltMatrix
CALLI4
pop
line 1393
;1393:			}
LABELV $966
line 1395
;1394:
;1395:			gunpoint[0] = matrix.matrix[0][3];
ADDRLP4 120
ADDRLP4 72+12
INDIRF4
ASGNF4
line 1396
;1396:			gunpoint[1] = matrix.matrix[1][3];
ADDRLP4 120+4
ADDRLP4 72+16+12
INDIRF4
ASGNF4
line 1397
;1397:			gunpoint[2] = matrix.matrix[2][3];
ADDRLP4 120+8
ADDRLP4 72+32+12
INDIRF4
ASGNF4
line 1399
;1398:
;1399:			gunangle[0] = -matrix.matrix[0][0];
ADDRLP4 132
ADDRLP4 72
INDIRF4
NEGF4
ASGNF4
line 1400
;1400:			gunangle[1] = -matrix.matrix[1][0];
ADDRLP4 132+4
ADDRLP4 72+16
INDIRF4
NEGF4
ASGNF4
line 1401
;1401:			gunangle[2] = -matrix.matrix[2][0];
ADDRLP4 132+8
ADDRLP4 72+32
INDIRF4
NEGF4
ASGNF4
line 1403
;1402:
;1403:			trap_FX_PlayEffectID(trap_FX_RegisterEffect( "effects/turret/muzzle_flash.efx" ), gunpoint, gunangle);
ADDRGP4 $982
ARGP4
ADDRLP4 144
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRLP4 120
ARGP4
ADDRLP4 132
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1404
;1404:		}
ADDRGP4 $647
JUMPV
LABELV $950
line 1406
;1405:		else
;1406:		{
line 1407
;1407:			CG_FireWeapon( cent, qfalse );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 1408
;1408:		}
line 1409
;1409:		break;
ADDRGP4 $647
JUMPV
LABELV $983
line 1412
;1410:
;1411:	case EV_ALT_FIRE:
;1412:		DEBUGNAME("EV_ALT_FIRE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $984
ADDRGP4 $987
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $984
line 1413
;1413:		CG_FireWeapon( cent, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 1416
;1414:
;1415:		//if you just exploded your detpacks and you have no ammo left for them, autoswitch
;1416:		if ( cg.snap->ps.clientNum == cent->currentState.number &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $647
ADDRGP4 cg+36
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 13
NEI4 $647
line 1418
;1417:			cg.snap->ps.weapon == WP_DET_PACK )
;1418:		{
line 1419
;1419:			if (cg.snap->ps.ammo[weaponData[WP_DET_PACK].ammoIndex] == 0) 
ADDRGP4 weaponData+728
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 452
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $647
line 1420
;1420:			{
line 1421
;1421:				CG_OutOfAmmoChange(WP_DET_PACK);
CNSTI4 13
ARGI4
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 1422
;1422:			}
line 1423
;1423:		}
line 1425
;1424:
;1425:		break;
ADDRGP4 $647
JUMPV
LABELV $996
line 1428
;1426:
;1427:	case EV_SABER_ATTACK:
;1428:		DEBUGNAME("EV_SABER_ATTACK");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $997
ADDRGP4 $1000
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $997
line 1429
;1429:		trap_S_StartSound(es->pos.trBase, es->number, CHAN_WEAPON, trap_S_RegisterSound(va("sound/weapons/saber/saberhup%i.wav", Q_irand(1, 8))));
CNSTI4 1
ARGI4
CNSTI4 8
ARGI4
ADDRLP4 68
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRGP4 $1001
ARGP4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1430
;1430:		break;
ADDRGP4 $647
JUMPV
LABELV $1002
line 1433
;1431:
;1432:	case EV_SABER_HIT:
;1433:		DEBUGNAME("EV_SABER_HIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1003
ADDRGP4 $1006
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1003
line 1434
;1434:		if (es->eventParm)
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1007
line 1435
;1435:		{ //hit a person
line 1437
;1436:			vec3_t fxDir;
;1437:			VectorCopy(es->angles, fxDir);
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1438
;1438:			if (!fxDir[0] && !fxDir[1] && !fxDir[2])
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 84
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1009
ADDRLP4 84+4
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1009
ADDRLP4 84+8
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1009
line 1439
;1439:			{
line 1440
;1440:				fxDir[1] = 1;
ADDRLP4 84+4
CNSTF4 1065353216
ASGNF4
line 1441
;1441:			}
LABELV $1009
line 1442
;1442:			trap_S_StartSound(es->origin, es->number, CHAN_AUTO, trap_S_RegisterSound("sound/weapons/saber/saberhit.wav"));
ADDRGP4 $1014
ARGP4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1443
;1443:			trap_FX_PlayEffectID( trap_FX_RegisterEffect("saber/blood_sparks.efx"), es->origin, fxDir );
ADDRGP4 $1015
ARGP4
ADDRLP4 108
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 84
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1444
;1444:		}
ADDRGP4 $647
JUMPV
LABELV $1007
line 1446
;1445:		else
;1446:		{ //hit something else
line 1448
;1447:			vec3_t fxDir;
;1448:			VectorCopy(es->angles, fxDir);
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1449
;1449:			if (!fxDir[0] && !fxDir[1] && !fxDir[2])
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 84
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1016
ADDRLP4 84+4
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1016
ADDRLP4 84+8
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1016
line 1450
;1450:			{
line 1451
;1451:				fxDir[1] = 1;
ADDRLP4 84+4
CNSTF4 1065353216
ASGNF4
line 1452
;1452:			}			
LABELV $1016
line 1453
;1453:			trap_S_StartSound(es->origin, es->number, CHAN_AUTO, trap_S_RegisterSound("sound/weapons/saber/saberhit.wav"));
ADDRGP4 $1014
ARGP4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1454
;1454:			trap_FX_PlayEffectID( trap_FX_RegisterEffect("saber/spark.efx"), es->origin, fxDir );
ADDRGP4 $1021
ARGP4
ADDRLP4 108
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 84
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1455
;1455:		}
line 1456
;1456:		break;
ADDRGP4 $647
JUMPV
LABELV $1022
line 1459
;1457:
;1458:	case EV_SABER_BLOCK:
;1459:		DEBUGNAME("EV_SABER_BLOCK");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1023
ADDRGP4 $1026
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1023
line 1461
;1460:
;1461:		if (es->eventParm)
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1027
line 1462
;1462:		{ //saber block
line 1464
;1463:			vec3_t fxDir;
;1464:			VectorCopy(es->angles, fxDir);
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1465
;1465:			if (!fxDir[0] && !fxDir[1] && !fxDir[2])
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 84
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1029
ADDRLP4 84+4
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1029
ADDRLP4 84+8
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1029
line 1466
;1466:			{
line 1467
;1467:				fxDir[1] = 1;
ADDRLP4 84+4
CNSTF4 1065353216
ASGNF4
line 1468
;1468:			}
LABELV $1029
line 1469
;1469:			trap_S_StartSound(es->origin, es->number, CHAN_AUTO, trap_S_RegisterSound(va( "sound/weapons/saber/saberblock%d.wav", Q_irand(1, 9) )));
CNSTI4 1
ARGI4
CNSTI4 9
ARGI4
ADDRLP4 100
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRGP4 $1034
ARGP4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1470
;1470:			trap_FX_PlayEffectID( trap_FX_RegisterEffect("saber/saber_block.efx"), es->origin, fxDir );
ADDRGP4 $1035
ARGP4
ADDRLP4 116
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 84
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1472
;1471:
;1472:			g_saberFlashTime = cg.time-50;
ADDRGP4 g_saberFlashTime
ADDRGP4 cg+64
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 1473
;1473:			VectorCopy( es->origin, g_saberFlashPos );
ADDRGP4 g_saberFlashPos
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1474
;1474:		}
ADDRGP4 $647
JUMPV
LABELV $1027
line 1476
;1475:		else
;1476:		{ //projectile block
line 1478
;1477:			vec3_t fxDir;
;1478:			VectorCopy(es->angles, fxDir);
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1479
;1479:			if (!fxDir[0] && !fxDir[1] && !fxDir[2])
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 84
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1037
ADDRLP4 84+4
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1037
ADDRLP4 84+8
INDIRF4
ADDRLP4 96
INDIRF4
NEF4 $1037
line 1480
;1480:			{
line 1481
;1481:				fxDir[1] = 1;
ADDRLP4 84+4
CNSTF4 1065353216
ASGNF4
line 1482
;1482:			}
LABELV $1037
line 1483
;1483:			trap_FX_PlayEffectID(trap_FX_RegisterEffect("blaster/deflect.efx"), es->origin, fxDir);
ADDRGP4 $1042
ARGP4
ADDRLP4 100
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 84
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1484
;1484:		}
line 1485
;1485:		break;
ADDRGP4 $647
JUMPV
LABELV $1043
line 1488
;1486:
;1487:	case EV_SABER_UNHOLSTER:
;1488:		DEBUGNAME("EV_SABER_UNHOLSTER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1044
ADDRGP4 $1047
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1044
line 1489
;1489:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, trap_S_RegisterSound( "sound/weapons/saber/saberon.wav" ) );
ADDRGP4 $1048
ARGP4
ADDRLP4 84
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1490
;1490:		break;
ADDRGP4 $647
JUMPV
LABELV $1049
line 1493
;1491:
;1492:	case EV_BECOME_JEDIMASTER:
;1493:		DEBUGNAME("EV_SABER_UNHOLSTER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1050
ADDRGP4 $1047
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1050
line 1494
;1494:		{
line 1496
;1495:			trace_t tr;
;1496:			vec3_t playerMins = {-15, -15, DEFAULT_MINS_2+8};
ADDRLP4 88
ADDRGP4 $1053
INDIRB
ASGNB 12
line 1497
;1497:			vec3_t playerMaxs = {15, 15, DEFAULT_MAXS_2};
ADDRLP4 100
ADDRGP4 $1054
INDIRB
ASGNB 12
line 1500
;1498:			vec3_t ang, pos, dpos;
;1499:
;1500:			VectorClear(ang);
ADDRLP4 1228
CNSTF4 0
ASGNF4
ADDRLP4 112+8
ADDRLP4 1228
INDIRF4
ASGNF4
ADDRLP4 112+4
ADDRLP4 1228
INDIRF4
ASGNF4
ADDRLP4 112
ADDRLP4 1228
INDIRF4
ASGNF4
line 1501
;1501:			ang[ROLL] = 1;
ADDRLP4 112+8
CNSTF4 1065353216
ASGNF4
line 1503
;1502:
;1503:			VectorCopy(position, dpos);
ADDRLP4 1204
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1504
;1504:			dpos[2] -= 4096;
ADDRLP4 1204+8
ADDRLP4 1204+8
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 1506
;1505:
;1506:			CG_Trace(&tr, position, playerMins, playerMaxs, dpos, es->number, MASK_SOLID);
ADDRLP4 124
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 100
ARGP4
ADDRLP4 1204
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 1507
;1507:			VectorCopy(tr.endpos, pos);
ADDRLP4 1216
ADDRLP4 124+12
INDIRB
ASGNB 12
line 1509
;1508:			
;1509:			if (tr.fraction == 1)
ADDRLP4 124+8
INDIRF4
CNSTF4 1065353216
NEF4 $1060
line 1510
;1510:			{
line 1511
;1511:				break;
ADDRGP4 $647
JUMPV
LABELV $1060
line 1513
;1512:			}
;1513:			trap_FX_PlayEffectID(trap_FX_RegisterEffect("mp/jedispawn.efx"), pos, ang);
ADDRGP4 $1063
ARGP4
ADDRLP4 1232
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
ARGI4
ADDRLP4 1216
ARGP4
ADDRLP4 112
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1515
;1514:
;1515:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, trap_S_RegisterSound( "sound/weapons/saber/saberon.wav" ) );
ADDRGP4 $1048
ARGP4
ADDRLP4 1236
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1236
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1517
;1516:
;1517:			if (cg.snap->ps.clientNum == es->number)
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
NEI4 $647
line 1518
;1518:			{
line 1519
;1519:				trap_S_StartLocalSound(cgs.media.happyMusic, CHAN_LOCAL);
ADDRGP4 cgs+70280+844
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1520
;1520:				CGCam_SetMusicMult(0.3, 5000);
CNSTF4 1050253722
ARGF4
CNSTI4 5000
ARGI4
ADDRGP4 CGCam_SetMusicMult
CALLV
pop
line 1521
;1521:			}
line 1522
;1522:		}
line 1523
;1523:		break;
ADDRGP4 $647
JUMPV
LABELV $1069
line 1526
;1524:
;1525:	case EV_DISRUPTOR_MAIN_SHOT:
;1526:		DEBUGNAME("EV_DISRUPTOR_MAIN_SHOT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1070
ADDRGP4 $1073
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1070
line 1527
;1527:		if (cent->currentState.eventParm != cg.snap->ps.clientNum ||
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $1078
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
EQI4 $1074
LABELV $1078
line 1529
;1528:			cg.renderingThirdPerson)
;1529:		{ //h4q3ry
line 1530
;1530:			CG_GetClientWeaponMuzzleBoltPoint(cent->currentState.eventParm, cent->currentState.origin2);
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRGP4 CG_GetClientWeaponMuzzleBoltPoint
CALLV
pop
line 1531
;1531:		}
ADDRGP4 $1075
JUMPV
LABELV $1074
line 1533
;1532:		else
;1533:		{
line 1534
;1534:			if (cg.lastFPFlashPoint[0] ||cg.lastFPFlashPoint[1] || cg.lastFPFlashPoint[2])
ADDRLP4 88
CNSTF4 0
ASGNF4
ADDRGP4 cg+13784
INDIRF4
ADDRLP4 88
INDIRF4
NEF4 $1087
ADDRGP4 cg+13784+4
INDIRF4
ADDRLP4 88
INDIRF4
NEF4 $1087
ADDRGP4 cg+13784+8
INDIRF4
ADDRLP4 88
INDIRF4
EQF4 $1079
LABELV $1087
line 1535
;1535:			{ //get the position of the muzzle flash for the first person weapon model from the last frame
line 1536
;1536:				VectorCopy(cg.lastFPFlashPoint, cent->currentState.origin2);
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 cg+13784
INDIRB
ASGNB 12
line 1537
;1537:			}
LABELV $1079
line 1538
;1538:		}
LABELV $1075
line 1539
;1539:		FX_DisruptorMainShot( cent->currentState.origin2, cent->lerpOrigin ); 
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 FX_DisruptorMainShot
CALLV
pop
line 1540
;1540:		break;
ADDRGP4 $647
JUMPV
LABELV $1089
line 1543
;1541:
;1542:	case EV_DISRUPTOR_SNIPER_SHOT:
;1543:		DEBUGNAME("EV_DISRUPTOR_SNIPER_SHOT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1090
ADDRGP4 $1093
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1090
line 1544
;1544:		if (cent->currentState.eventParm != cg.snap->ps.clientNum ||
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $1098
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
EQI4 $1094
LABELV $1098
line 1546
;1545:			cg.renderingThirdPerson)
;1546:		{ //h4q3ry
line 1547
;1547:			CG_GetClientWeaponMuzzleBoltPoint(cent->currentState.eventParm, cent->currentState.origin2);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 92
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRGP4 CG_GetClientWeaponMuzzleBoltPoint
CALLV
pop
line 1548
;1548:		}
ADDRGP4 $1095
JUMPV
LABELV $1094
line 1550
;1549:		else
;1550:		{
line 1551
;1551:			if (cg.lastFPFlashPoint[0] ||cg.lastFPFlashPoint[1] || cg.lastFPFlashPoint[2])
ADDRLP4 92
CNSTF4 0
ASGNF4
ADDRGP4 cg+13784
INDIRF4
ADDRLP4 92
INDIRF4
NEF4 $1107
ADDRGP4 cg+13784+4
INDIRF4
ADDRLP4 92
INDIRF4
NEF4 $1107
ADDRGP4 cg+13784+8
INDIRF4
ADDRLP4 92
INDIRF4
EQF4 $1099
LABELV $1107
line 1552
;1552:			{ //get the position of the muzzle flash for the first person weapon model from the last frame
line 1553
;1553:				VectorCopy(cg.lastFPFlashPoint, cent->currentState.origin2);
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 cg+13784
INDIRB
ASGNB 12
line 1554
;1554:			}
LABELV $1099
line 1555
;1555:		}
LABELV $1095
line 1556
;1556:		FX_DisruptorAltShot( cent->currentState.origin2, cent->lerpOrigin, cent->currentState.shouldtarget );
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ARGI4
ADDRGP4 FX_DisruptorAltShot
CALLV
pop
line 1557
;1557:		break;
ADDRGP4 $647
JUMPV
LABELV $1109
line 1560
;1558:
;1559:	case EV_DISRUPTOR_SNIPER_MISS:
;1560:		DEBUGNAME("EV_DISRUPTOR_SNIPER_MISS");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1110
ADDRGP4 $1113
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1110
line 1561
;1561:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1562
;1562:		if (es->weapon)
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1114
line 1563
;1563:		{ //primary
line 1564
;1564:			FX_DisruptorHitWall( cent->lerpOrigin, dir );
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 FX_DisruptorHitWall
CALLV
pop
line 1565
;1565:		}
ADDRGP4 $647
JUMPV
LABELV $1114
line 1567
;1566:		else
;1567:		{ //secondary
line 1568
;1568:			FX_DisruptorAltMiss( cent->lerpOrigin, dir );
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 FX_DisruptorAltMiss
CALLV
pop
line 1569
;1569:		}
line 1570
;1570:		break;
ADDRGP4 $647
JUMPV
LABELV $1116
line 1573
;1571:
;1572:	case EV_DISRUPTOR_HIT:
;1573:		DEBUGNAME("EV_DISRUPTOR_HIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1117
ADDRGP4 $1120
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1117
line 1574
;1574:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1575
;1575:		if (es->weapon)
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1121
line 1576
;1576:		{ //client
line 1577
;1577:			FX_DisruptorHitPlayer( cent->lerpOrigin, dir, qtrue );
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 FX_DisruptorHitPlayer
CALLV
pop
line 1578
;1578:		}
ADDRGP4 $647
JUMPV
LABELV $1121
line 1580
;1579:		else
;1580:		{ //non-client
line 1581
;1581:			FX_DisruptorHitWall( cent->lerpOrigin, dir );
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 FX_DisruptorHitWall
CALLV
pop
line 1582
;1582:		}
line 1583
;1583:		break;
ADDRGP4 $647
JUMPV
LABELV $1123
line 1586
;1584:
;1585:	case EV_DISRUPTOR_ZOOMSOUND:
;1586:		DEBUGNAME("EV_DISRUPTOR_ZOOMSOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1124
ADDRGP4 $1127
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1124
line 1587
;1587:		if (es->number == cg.snap->ps.clientNum)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $647
line 1588
;1588:		{
line 1589
;1589:			if (cg.snap->ps.zoomMode)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1364
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1131
line 1590
;1590:			{
line 1591
;1591:				trap_S_StartLocalSound(trap_S_RegisterSound("sound/weapons/disruptor/zoomstart.wav"), CHAN_AUTO);
ADDRGP4 $1134
ARGP4
ADDRLP4 96
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1592
;1592:			}
ADDRGP4 $647
JUMPV
LABELV $1131
line 1594
;1593:			else
;1594:			{
line 1595
;1595:				trap_S_StartLocalSound(trap_S_RegisterSound("sound/weapons/disruptor/zoomend.wav"), CHAN_AUTO);
ADDRGP4 $1135
ARGP4
ADDRLP4 96
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1596
;1596:			}
line 1597
;1597:		}
line 1598
;1598:		break;
ADDRGP4 $647
JUMPV
LABELV $1136
line 1600
;1599:	case EV_PREDEFSOUND:
;1600:		DEBUGNAME("EV_PREDEFSOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1137
ADDRGP4 $1140
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1137
line 1601
;1601:		{
line 1602
;1602:			int sID = -1;
ADDRLP4 96
CNSTI4 -1
ASGNI4
line 1604
;1603:
;1604:			switch (es->eventParm)
ADDRLP4 100
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 1
LTI4 $1142
ADDRLP4 100
INDIRI4
CNSTI4 6
GTI4 $1142
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1156-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1156
address $1144
address $1146
address $1148
address $1150
address $1152
address $1154
code
line 1605
;1605:			{
LABELV $1144
line 1607
;1606:			case PDSOUND_PROTECTHIT:
;1607:				sID = trap_S_RegisterSound("sound/weapons/force/protecthit.mp3");
ADDRGP4 $1145
ARGP4
ADDRLP4 108
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 108
INDIRI4
ASGNI4
line 1608
;1608:				break;
ADDRGP4 $1142
JUMPV
LABELV $1146
line 1610
;1609:			case PDSOUND_PROTECT:
;1610:				sID = trap_S_RegisterSound("sound/weapons/force/protect.mp3");
ADDRGP4 $1147
ARGP4
ADDRLP4 112
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 112
INDIRI4
ASGNI4
line 1611
;1611:				break;
ADDRGP4 $1142
JUMPV
LABELV $1148
line 1613
;1612:			case PDSOUND_ABSORBHIT:
;1613:				sID = trap_S_RegisterSound("sound/weapons/force/absorbhit.mp3");
ADDRGP4 $1149
ARGP4
ADDRLP4 116
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 116
INDIRI4
ASGNI4
line 1614
;1614:				break;
ADDRGP4 $1142
JUMPV
LABELV $1150
line 1616
;1615:			case PDSOUND_ABSORB:
;1616:				sID = trap_S_RegisterSound("sound/weapons/force/absorb.mp3");
ADDRGP4 $1151
ARGP4
ADDRLP4 120
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 120
INDIRI4
ASGNI4
line 1617
;1617:				break;
ADDRGP4 $1142
JUMPV
LABELV $1152
line 1619
;1618:			case PDSOUND_FORCEJUMP:
;1619:				sID = trap_S_RegisterSound("sound/weapons/force/jump.mp3");
ADDRGP4 $1153
ARGP4
ADDRLP4 124
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 124
INDIRI4
ASGNI4
line 1620
;1620:				break;
ADDRGP4 $1142
JUMPV
LABELV $1154
line 1622
;1621:			case PDSOUND_FORCEGRIP:
;1622:				sID = trap_S_RegisterSound("sound/weapons/force/grip.mp3");
ADDRGP4 $1155
ARGP4
ADDRLP4 128
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 128
INDIRI4
ASGNI4
line 1623
;1623:				break;
line 1625
;1624:			default:
;1625:				break;
LABELV $1142
line 1628
;1626:			}
;1627:
;1628:			if (sID != 1)
ADDRLP4 96
INDIRI4
CNSTI4 1
EQI4 $647
line 1629
;1629:			{
line 1630
;1630:				trap_S_StartSound(es->origin, es->number, CHAN_AUTO, sID);
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1631
;1631:			}
line 1632
;1632:		}
line 1633
;1633:		break;
ADDRGP4 $647
JUMPV
LABELV $1160
line 1636
;1634:
;1635:	case EV_TEAM_POWER:
;1636:		DEBUGNAME("EV_TEAM_POWER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1161
ADDRGP4 $1164
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1161
line 1637
;1637:		{
line 1638
;1638:			int clnum = 0;
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRGP4 $1166
JUMPV
LABELV $1165
line 1641
;1639:
;1640:			while (clnum < MAX_CLIENTS)
;1641:			{
line 1642
;1642:				if (CG_InClientBitflags(es, clnum))
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 96
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 CG_InClientBitflags
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $1168
line 1643
;1643:				{
line 1644
;1644:					if (es->eventParm == 1)
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1170
line 1645
;1645:					{ //eventParm 1 is heal
line 1646
;1646:						trap_S_StartSound (NULL, clnum, CHAN_AUTO, cgs.media.teamHealSound );
CNSTP4 0
ARGP4
ADDRLP4 96
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+700
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1647
;1647:						cg_entities[clnum].teamPowerEffectTime = cg.time + 1000;
CNSTI4 1920
ADDRLP4 96
INDIRI4
MULI4
ADDRGP4 cg_entities+1912
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1648
;1648:						cg_entities[clnum].teamPowerType = 1;
CNSTI4 1920
ADDRLP4 96
INDIRI4
MULI4
ADDRGP4 cg_entities+1916
ADDP4
CNSTI4 1
ASGNI4
line 1649
;1649:					}
ADDRGP4 $1171
JUMPV
LABELV $1170
line 1651
;1650:					else
;1651:					{ //eventParm 2 is force regen
line 1652
;1652:						trap_S_StartSound (NULL, clnum, CHAN_AUTO, cgs.media.teamRegenSound );
CNSTP4 0
ARGP4
ADDRLP4 96
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+704
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1653
;1653:						cg_entities[clnum].teamPowerEffectTime = cg.time + 1000;
CNSTI4 1920
ADDRLP4 96
INDIRI4
MULI4
ADDRGP4 cg_entities+1912
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1654
;1654:						cg_entities[clnum].teamPowerType = 0;
CNSTI4 1920
ADDRLP4 96
INDIRI4
MULI4
ADDRGP4 cg_entities+1916
ADDP4
CNSTI4 0
ASGNI4
line 1655
;1655:					}
LABELV $1171
line 1656
;1656:				}
LABELV $1168
line 1657
;1657:				clnum++;
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1658
;1658:			}
LABELV $1166
line 1640
ADDRLP4 96
INDIRI4
CNSTI4 32
LTI4 $1165
line 1659
;1659:		}
line 1660
;1660:		break;
ADDRGP4 $647
JUMPV
LABELV $1182
line 1663
;1661:
;1662:	case EV_SCREENSHAKE:
;1663:		DEBUGNAME("EV_SCREENSHAKE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1183
ADDRGP4 $1186
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1183
line 1664
;1664:		if (!es->modelindex || cg.predictedPlayerState.clientNum == es->modelindex-1)
ADDRLP4 96
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1191
ADDRGP4 cg+96+144
INDIRI4
ADDRLP4 96
INDIRI4
CNSTI4 1
SUBI4
NEI4 $647
LABELV $1191
line 1665
;1665:		{
line 1666
;1666:			CGCam_Shake(es->angles[0], es->time);
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CGCam_Shake
CALLV
pop
line 1667
;1667:		}
line 1668
;1668:		break;
ADDRGP4 $647
JUMPV
LABELV $1192
line 1670
;1669:	case EV_USE_ITEM0:
;1670:		DEBUGNAME("EV_USE_ITEM0");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1193
ADDRGP4 $1196
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1193
line 1671
;1671:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1672
;1672:		break;
ADDRGP4 $647
JUMPV
LABELV $1197
line 1674
;1673:	case EV_USE_ITEM1:
;1674:		DEBUGNAME("EV_USE_ITEM1");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1198
ADDRGP4 $1201
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1198
line 1675
;1675:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1676
;1676:		break;
ADDRGP4 $647
JUMPV
LABELV $1202
line 1678
;1677:	case EV_USE_ITEM2:
;1678:		DEBUGNAME("EV_USE_ITEM2");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1203
ADDRGP4 $1206
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1203
line 1679
;1679:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1680
;1680:		break;
ADDRGP4 $647
JUMPV
LABELV $1207
line 1682
;1681:	case EV_USE_ITEM3:
;1682:		DEBUGNAME("EV_USE_ITEM3");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1208
ADDRGP4 $1211
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1208
line 1683
;1683:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1684
;1684:		break;
ADDRGP4 $647
JUMPV
LABELV $1212
line 1686
;1685:	case EV_USE_ITEM4:
;1686:		DEBUGNAME("EV_USE_ITEM4");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1213
ADDRGP4 $1216
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1213
line 1687
;1687:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1688
;1688:		break;
ADDRGP4 $647
JUMPV
LABELV $1217
line 1690
;1689:	case EV_USE_ITEM5:
;1690:		DEBUGNAME("EV_USE_ITEM5");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1218
ADDRGP4 $1221
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1218
line 1691
;1691:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1692
;1692:		break;
ADDRGP4 $647
JUMPV
LABELV $1222
line 1694
;1693:	case EV_USE_ITEM6:
;1694:		DEBUGNAME("EV_USE_ITEM6");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1223
ADDRGP4 $1226
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1223
line 1695
;1695:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1696
;1696:		break;
ADDRGP4 $647
JUMPV
LABELV $1227
line 1698
;1697:	case EV_USE_ITEM7:
;1698:		DEBUGNAME("EV_USE_ITEM7");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1228
ADDRGP4 $1231
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1228
line 1699
;1699:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1700
;1700:		break;
ADDRGP4 $647
JUMPV
LABELV $1232
line 1702
;1701:	case EV_USE_ITEM8:
;1702:		DEBUGNAME("EV_USE_ITEM8");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1233
ADDRGP4 $1236
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1233
line 1703
;1703:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1704
;1704:		break;
ADDRGP4 $647
JUMPV
LABELV $1237
line 1706
;1705:	case EV_USE_ITEM9:
;1706:		DEBUGNAME("EV_USE_ITEM9");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1238
ADDRGP4 $1241
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1238
line 1707
;1707:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1708
;1708:		break;
ADDRGP4 $647
JUMPV
LABELV $1242
line 1710
;1709:	case EV_USE_ITEM10:
;1710:		DEBUGNAME("EV_USE_ITEM10");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1243
ADDRGP4 $1246
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1243
line 1711
;1711:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1712
;1712:		break;
ADDRGP4 $647
JUMPV
LABELV $1247
line 1714
;1713:	case EV_USE_ITEM11:
;1714:		DEBUGNAME("EV_USE_ITEM11");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1248
ADDRGP4 $1251
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1248
line 1715
;1715:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1716
;1716:		break;
ADDRGP4 $647
JUMPV
LABELV $1252
line 1718
;1717:	case EV_USE_ITEM12:
;1718:		DEBUGNAME("EV_USE_ITEM12");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1253
ADDRGP4 $1256
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1253
line 1719
;1719:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1720
;1720:		break;
ADDRGP4 $647
JUMPV
LABELV $1257
line 1722
;1721:	case EV_USE_ITEM13:
;1722:		DEBUGNAME("EV_USE_ITEM13");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1258
ADDRGP4 $1261
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1258
line 1723
;1723:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1724
;1724:		break;
ADDRGP4 $647
JUMPV
LABELV $1262
line 1726
;1725:	case EV_USE_ITEM14:
;1726:		DEBUGNAME("EV_USE_ITEM14");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1263
ADDRGP4 $1266
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1263
line 1727
;1727:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1728
;1728:		break;
ADDRGP4 $647
JUMPV
LABELV $1267
line 1731
;1729:
;1730:	case EV_ITEMUSEFAIL:
;1731:		DEBUGNAME("EV_ITEMUSEFAIL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1268
ADDRGP4 $1271
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1268
line 1732
;1732:		if (cg.snap->ps.clientNum == es->number)
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
NEI4 $647
line 1733
;1733:		{
line 1734
;1734:			char *stripedref = NULL;
ADDRLP4 100
CNSTP4 0
ASGNP4
line 1736
;1735:
;1736:			switch(es->eventParm)
ADDRLP4 104
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 1
LTI4 $1276
ADDRLP4 104
INDIRI4
CNSTI4 4
GTI4 $1276
ADDRLP4 104
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1286-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1286
address $1278
address $1280
address $1282
address $1284
code
line 1737
;1737:			{
LABELV $1278
line 1739
;1738:			case SENTRY_NOROOM:
;1739:				stripedref = (char *)CG_GetStripEdString("INGAMETEXT", "SENTRY_NOROOM");
ADDRGP4 $241
ARGP4
ADDRGP4 $1279
ARGP4
ADDRLP4 112
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 100
ADDRLP4 112
INDIRP4
ASGNP4
line 1740
;1740:				break;
ADDRGP4 $1276
JUMPV
LABELV $1280
line 1742
;1741:			case SENTRY_ALREADYPLACED:
;1742:				stripedref = (char *)CG_GetStripEdString("INGAMETEXT", "SENTRY_ALREADYPLACED");
ADDRGP4 $241
ARGP4
ADDRGP4 $1281
ARGP4
ADDRLP4 116
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 100
ADDRLP4 116
INDIRP4
ASGNP4
line 1743
;1743:				break;
ADDRGP4 $1276
JUMPV
LABELV $1282
line 1745
;1744:			case SHIELD_NOROOM:
;1745:				stripedref = (char *)CG_GetStripEdString("INGAMETEXT", "SHIELD_NOROOM");
ADDRGP4 $241
ARGP4
ADDRGP4 $1283
ARGP4
ADDRLP4 120
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 100
ADDRLP4 120
INDIRP4
ASGNP4
line 1746
;1746:				break;
ADDRGP4 $1276
JUMPV
LABELV $1284
line 1748
;1747:			case SEEKER_ALREADYDEPLOYED:
;1748:				stripedref = (char *)CG_GetStripEdString("INGAMETEXT", "SEEKER_ALREADYDEPLOYED");
ADDRGP4 $241
ARGP4
ADDRGP4 $1285
ARGP4
ADDRLP4 124
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 100
ADDRLP4 124
INDIRP4
ASGNP4
line 1749
;1749:				break;
line 1751
;1750:			default:
;1751:				break;
LABELV $1276
line 1754
;1752:			}
;1753:
;1754:			if (!stripedref)
ADDRLP4 100
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1288
line 1755
;1755:			{
line 1756
;1756:				break;
ADDRGP4 $647
JUMPV
LABELV $1288
line 1759
;1757:			}
;1758:
;1759:			Com_Printf("%s\n", stripedref);
ADDRGP4 $579
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1760
;1760:		}
line 1761
;1761:		break;
ADDRGP4 $647
JUMPV
LABELV $1290
line 1769
;1762:
;1763:	//=================================================================
;1764:
;1765:	//
;1766:	// other events
;1767:	//
;1768:	case EV_PLAYER_TELEPORT_IN:
;1769:		DEBUGNAME("EV_PLAYER_TELEPORT_IN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1291
ADDRGP4 $1294
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1291
line 1770
;1770:		{
line 1772
;1771:			trace_t tr;
;1772:			vec3_t playerMins = {-15, -15, DEFAULT_MINS_2+8};
ADDRLP4 100
ADDRGP4 $1295
INDIRB
ASGNB 12
line 1773
;1773:			vec3_t playerMaxs = {15, 15, DEFAULT_MAXS_2};
ADDRLP4 112
ADDRGP4 $1296
INDIRB
ASGNB 12
line 1776
;1774:			vec3_t ang, pos, dpos;
;1775:
;1776:			VectorClear(ang);
ADDRLP4 1240
CNSTF4 0
ASGNF4
ADDRLP4 124+8
ADDRLP4 1240
INDIRF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 1240
INDIRF4
ASGNF4
ADDRLP4 124
ADDRLP4 1240
INDIRF4
ASGNF4
line 1777
;1777:			ang[ROLL] = 1;
ADDRLP4 124+8
CNSTF4 1065353216
ASGNF4
line 1779
;1778:
;1779:			VectorCopy(position, dpos);
ADDRLP4 1216
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1780
;1780:			dpos[2] -= 4096;
ADDRLP4 1216+8
ADDRLP4 1216+8
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 1782
;1781:
;1782:			CG_Trace(&tr, position, playerMins, playerMaxs, dpos, es->number, MASK_SOLID);
ADDRLP4 136
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 100
ARGP4
ADDRLP4 112
ARGP4
ADDRLP4 1216
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 1783
;1783:			VectorCopy(tr.endpos, pos);
ADDRLP4 1228
ADDRLP4 136+12
INDIRB
ASGNB 12
line 1785
;1784:			
;1785:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+708
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1787
;1786:
;1787:			if (tr.fraction == 1)
ADDRLP4 136+8
INDIRF4
CNSTF4 1065353216
NEF4 $1304
line 1788
;1788:			{
line 1789
;1789:				break;
ADDRGP4 $647
JUMPV
LABELV $1304
line 1791
;1790:			}
;1791:			trap_FX_PlayEffectID(trap_FX_RegisterEffect("mp/spawn.efx"), pos, ang);
ADDRGP4 $1307
ARGP4
ADDRLP4 1244
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 1244
INDIRI4
ARGI4
ADDRLP4 1228
ARGP4
ADDRLP4 124
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1792
;1792:		}
line 1793
;1793:		break;
ADDRGP4 $647
JUMPV
LABELV $1308
line 1796
;1794:
;1795:	case EV_PLAYER_TELEPORT_OUT:
;1796:		DEBUGNAME("EV_PLAYER_TELEPORT_OUT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1309
ADDRGP4 $1312
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1309
line 1797
;1797:		{
line 1799
;1798:			trace_t tr;
;1799:			vec3_t playerMins = {-15, -15, DEFAULT_MINS_2+8};
ADDRLP4 100
ADDRGP4 $1313
INDIRB
ASGNB 12
line 1800
;1800:			vec3_t playerMaxs = {15, 15, DEFAULT_MAXS_2};
ADDRLP4 112
ADDRGP4 $1314
INDIRB
ASGNB 12
line 1803
;1801:			vec3_t ang, pos, dpos;
;1802:
;1803:			VectorClear(ang);
ADDRLP4 1240
CNSTF4 0
ASGNF4
ADDRLP4 124+8
ADDRLP4 1240
INDIRF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 1240
INDIRF4
ASGNF4
ADDRLP4 124
ADDRLP4 1240
INDIRF4
ASGNF4
line 1804
;1804:			ang[ROLL] = 1;
ADDRLP4 124+8
CNSTF4 1065353216
ASGNF4
line 1806
;1805:
;1806:			VectorCopy(position, dpos);
ADDRLP4 1216
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1807
;1807:			dpos[2] -= 4096;
ADDRLP4 1216+8
ADDRLP4 1216+8
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 1809
;1808:
;1809:			CG_Trace(&tr, position, playerMins, playerMaxs, dpos, es->number, MASK_SOLID);
ADDRLP4 136
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 100
ARGP4
ADDRLP4 112
ARGP4
ADDRLP4 1216
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 1810
;1810:			VectorCopy(tr.endpos, pos);
ADDRLP4 1228
ADDRLP4 136+12
INDIRB
ASGNB 12
line 1812
;1811:
;1812:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+712
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1814
;1813:
;1814:			if (tr.fraction == 1)
ADDRLP4 136+8
INDIRF4
CNSTF4 1065353216
NEF4 $1322
line 1815
;1815:			{
line 1816
;1816:				break;
ADDRGP4 $647
JUMPV
LABELV $1322
line 1818
;1817:			}
;1818:			trap_FX_PlayEffectID(trap_FX_RegisterEffect("mp/spawn.efx"), pos, ang);
ADDRGP4 $1307
ARGP4
ADDRLP4 1244
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 1244
INDIRI4
ARGI4
ADDRLP4 1228
ARGP4
ADDRLP4 124
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 1819
;1819:		}
line 1820
;1820:		break;
ADDRGP4 $647
JUMPV
LABELV $1325
line 1823
;1821:
;1822:	case EV_ITEM_POP:
;1823:		DEBUGNAME("EV_ITEM_POP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1326
ADDRGP4 $1329
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1326
line 1824
;1824:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+716
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1825
;1825:		break;
ADDRGP4 $647
JUMPV
LABELV $1332
line 1827
;1826:	case EV_ITEM_RESPAWN:
;1827:		DEBUGNAME("EV_ITEM_RESPAWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1333
ADDRGP4 $1336
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1333
line 1828
;1828:		cent->miscTime = cg.time;	// scale up from this
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 1829
;1829:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+716
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1830
;1830:		break;
ADDRGP4 $647
JUMPV
LABELV $1340
line 1833
;1831:
;1832:	case EV_GRENADE_BOUNCE:
;1833:		DEBUGNAME("EV_GRENADE_BOUNCE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $647
ADDRGP4 $1344
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1835
;1834:		//Do something here?
;1835:		break;
ADDRGP4 $647
JUMPV
LABELV $1345
line 1838
;1836:
;1837:	case EV_SCOREPLUM:
;1838:		DEBUGNAME("EV_SCOREPLUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1346
ADDRGP4 $1349
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1346
line 1839
;1839:		CG_ScorePlum( cent->currentState.otherEntityNum, cent->lerpOrigin, cent->currentState.time );
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ScorePlum
CALLV
pop
line 1840
;1840:		break;
ADDRGP4 $647
JUMPV
LABELV $1350
line 1843
;1841:
;1842:	case EV_CTFMESSAGE:
;1843:		DEBUGNAME("EV_CTFMESSAGE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1351
ADDRGP4 $1354
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1351
line 1844
;1844:		CG_GetCTFMessageEvent(es);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_GetCTFMessageEvent
CALLV
pop
line 1845
;1845:		break;
ADDRGP4 $647
JUMPV
LABELV $1355
line 1851
;1846:
;1847:	//
;1848:	// saga gameplay events
;1849:	//
;1850:	case EV_SAGA_ROUNDOVER:
;1851:		DEBUGNAME("EV_SAGA_ROUNDOVER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1356
ADDRGP4 $1359
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1356
line 1852
;1852:		CG_SagaRoundOver(&cg_entities[cent->currentState.weapon], cent->currentState.eventParm);
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 104
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRLP4 104
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_SagaRoundOver
CALLV
pop
line 1853
;1853:		break;
ADDRGP4 $647
JUMPV
LABELV $1360
line 1855
;1854:	case EV_SAGA_OBJECTIVECOMPLETE:
;1855:		DEBUGNAME("EV_SAGA_OBJECTIVECOMPLETE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1361
ADDRGP4 $1364
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1361
line 1856
;1856:		CG_SagaObjectiveCompleted(&cg_entities[cent->currentState.weapon], cent->currentState.eventParm, cent->currentState.trickedentindex);
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1920
ADDRLP4 108
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRLP4 108
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_SagaObjectiveCompleted
CALLV
pop
line 1857
;1857:		break;
ADDRGP4 $647
JUMPV
LABELV $1365
line 1860
;1858:
;1859:	case EV_DESTROY_GHOUL2_INSTANCE:
;1860:		DEBUGNAME("EV_DESTROY_GHOUL2_INSTANCE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1366
ADDRGP4 $1369
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1366
line 1861
;1861:		if (cg_entities[es->eventParm].ghoul2 && trap_G2_HaveWeGhoul2Models(cg_entities[es->eventParm].ghoul2))
ADDRLP4 112
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ASGNI4
ADDRLP4 112
INDIRI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $647
ADDRLP4 112
INDIRI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $647
line 1862
;1862:		{
line 1863
;1863:			if (es->eventParm < MAX_CLIENTS)
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 32
GEI4 $1374
line 1864
;1864:			{ //You try to do very bad thing!
line 1868
;1865:#ifdef _DEBUG
;1866:				Com_Printf("WARNING: Tried to kill a client ghoul2 instance with a server event!\n");
;1867:#endif
;1868:				break;
ADDRGP4 $647
JUMPV
LABELV $1374
line 1870
;1869:			}
;1870:			trap_G2API_CleanGhoul2Models(&(cg_entities[es->eventParm].ghoul2));
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
ARGP4
ADDRGP4 trap_G2API_CleanGhoul2Models
CALLV
pop
line 1871
;1871:		}
line 1872
;1872:		break;
ADDRGP4 $647
JUMPV
LABELV $1377
line 1875
;1873:
;1874:	case EV_DESTROY_WEAPON_MODEL:
;1875:		DEBUGNAME("EV_DESTROY_WEAPON_MODEL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1378
ADDRGP4 $1381
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1378
line 1876
;1876:		if (cg_entities[es->eventParm].ghoul2 && trap_G2_HaveWeGhoul2Models(cg_entities[es->eventParm].ghoul2) &&
ADDRLP4 120
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ASGNI4
ADDRLP4 120
INDIRI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $647
ADDRLP4 120
INDIRI4
ADDRGP4 cg_entities+952
ADDP4
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 trap_G2_HaveWeGhoul2Models
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $647
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 128
ADDRGP4 trap_G2API_HasGhoul2ModelOnIndex
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
EQI4 $647
line 1878
;1877:			trap_G2API_HasGhoul2ModelOnIndex(&(cg_entities[es->eventParm].ghoul2), 1))
;1878:		{
line 1879
;1879:			trap_G2API_RemoveGhoul2Model(&(cg_entities[es->eventParm].ghoul2), 1);
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+952
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_G2API_RemoveGhoul2Model
CALLI4
pop
line 1880
;1880:		}
line 1881
;1881:		break;
ADDRGP4 $647
JUMPV
LABELV $1388
line 1884
;1882:
;1883:	case EV_GIVE_NEW_RANK:
;1884:		DEBUGNAME("EV_GIVE_NEW_RANK");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1389
ADDRGP4 $1392
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1389
line 1885
;1885:		if (es->trickedentindex == cg.snap->ps.clientNum)
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
NEI4 $647
line 1886
;1886:		{
line 1887
;1887:			trap_Cvar_Set("ui_rankChange", va("%i", es->eventParm));
ADDRGP4 $1397
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1396
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1889
;1888:
;1889:			trap_Cvar_Set("ui_myteam", va("%i", es->bolt2));
ADDRGP4 $1397
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1398
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1891
;1890:
;1891:			if (!( trap_Key_GetCatcher() & KEYCATCH_UI ) && !es->bolt1)
ADDRLP4 140
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 144
INDIRI4
NEI4 $647
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRLP4 144
INDIRI4
NEI4 $647
line 1892
;1892:			{
line 1893
;1893:				trap_OpenUIMenu(3);
CNSTI4 3
ARGI4
ADDRGP4 trap_OpenUIMenu
CALLV
pop
line 1894
;1894:			}
line 1895
;1895:		}
line 1896
;1896:		break;
ADDRGP4 $647
JUMPV
LABELV $1401
line 1899
;1897:
;1898:	case EV_SET_FREE_SABER:
;1899:		DEBUGNAME("EV_SET_FREE_SABER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1402
ADDRGP4 $1405
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1402
line 1901
;1900:
;1901:		trap_Cvar_Set("ui_freeSaber", va("%i", es->eventParm));
ADDRGP4 $1397
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1406
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1902
;1902:		break;
ADDRGP4 $647
JUMPV
LABELV $1407
line 1905
;1903:
;1904:	case EV_SET_FORCE_DISABLE:
;1905:		DEBUGNAME("EV_SET_FORCE_DISABLE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1408
ADDRGP4 $1411
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1408
line 1907
;1906:
;1907:		trap_Cvar_Set("ui_forcePowerDisable", va("%i", es->eventParm));
ADDRGP4 $1397
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1412
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1908
;1908:		break;
ADDRGP4 $647
JUMPV
LABELV $1413
line 1914
;1909:
;1910:	//
;1911:	// missile impacts
;1912:	//
;1913:	case EV_MISSILE_STICK:
;1914:		DEBUGNAME("EV_MISSILE_STICK");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $647
ADDRGP4 $1417
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1916
;1915://		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.missileStick );
;1916:		break;
ADDRGP4 $647
JUMPV
LABELV $1418
line 1919
;1917:
;1918:	case EV_MISSILE_HIT:
;1919:		DEBUGNAME("EV_MISSILE_HIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1419
ADDRGP4 $1422
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1419
line 1920
;1920:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1921
;1921:		if (cent->currentState.eFlags & EF_ALT_FIRING)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1423
line 1922
;1922:		{
line 1923
;1923:			CG_MissileHitPlayer( es->weapon, position, dir, es->otherEntityNum, qtrue);
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 1924
;1924:		}
ADDRGP4 $647
JUMPV
LABELV $1423
line 1926
;1925:		else
;1926:		{
line 1927
;1927:			CG_MissileHitPlayer( es->weapon, position, dir, es->otherEntityNum, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 1928
;1928:		}
line 1929
;1929:		break;
ADDRGP4 $647
JUMPV
LABELV $1425
line 1932
;1930:
;1931:	case EV_MISSILE_MISS:
;1932:		DEBUGNAME("EV_MISSILE_MISS");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1426
ADDRGP4 $1429
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1426
line 1933
;1933:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1934
;1934:		if (cent->currentState.eFlags & EF_ALT_FIRING)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1430
line 1935
;1935:		{
line 1936
;1936:			CG_MissileHitWall(es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT, qtrue, es->generic1);
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 144
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1937
;1937:		}
ADDRGP4 $647
JUMPV
LABELV $1430
line 1939
;1938:		else
;1939:		{
line 1940
;1940:			CG_MissileHitWall(es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT, qfalse, 0);
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRLP4 140
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1941
;1941:		}
line 1942
;1942:		break;
ADDRGP4 $647
JUMPV
LABELV $1432
line 1945
;1943:
;1944:	case EV_MISSILE_MISS_METAL:
;1945:		DEBUGNAME("EV_MISSILE_MISS_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1433
ADDRGP4 $1436
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1433
line 1946
;1946:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1947
;1947:		if (cent->currentState.eFlags & EF_ALT_FIRING)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1437
line 1948
;1948:		{
line 1949
;1949:			CG_MissileHitWall(es->weapon, 0, position, dir, IMPACTSOUND_METAL, qtrue, es->generic1);
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 144
CNSTI4 1
ASGNI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1950
;1950:		}
ADDRGP4 $647
JUMPV
LABELV $1437
line 1952
;1951:		else
;1952:		{
line 1953
;1953:			CG_MissileHitWall(es->weapon, 0, position, dir, IMPACTSOUND_METAL, qfalse, 0);
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRLP4 140
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1954
;1954:		}
line 1955
;1955:		break;
ADDRGP4 $647
JUMPV
LABELV $1439
line 1958
;1956:
;1957:	case EV_PLAY_EFFECT:
;1958:		DEBUGNAME("EV_PLAY_EFFECT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1440
ADDRGP4 $1443
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1440
line 1959
;1959:		switch(es->eventParm)
ADDRLP4 140
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 1
LTI4 $1444
ADDRLP4 140
INDIRI4
CNSTI4 9
GTI4 $1444
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1465-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1465
address $1447
address $1449
address $1451
address $1453
address $1455
address $1457
address $1459
address $1461
address $1463
code
line 1960
;1960:		{ //it isn't a hack, it's ingenuity!
LABELV $1447
line 1962
;1961:		case EFFECT_SMOKE:
;1962:			eID = trap_FX_RegisterEffect("emplaced/dead_smoke.efx");
ADDRGP4 $1448
ARGP4
ADDRLP4 148
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 148
INDIRI4
ASGNI4
line 1963
;1963:			break;
ADDRGP4 $1445
JUMPV
LABELV $1449
line 1965
;1964:		case EFFECT_EXPLOSION:
;1965:			eID = trap_FX_RegisterEffect("emplaced/explode.efx");
ADDRGP4 $1450
ARGP4
ADDRLP4 152
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 152
INDIRI4
ASGNI4
line 1966
;1966:			break;
ADDRGP4 $1445
JUMPV
LABELV $1451
line 1968
;1967:		case EFFECT_EXPLOSION_PAS:
;1968:			eID = trap_FX_RegisterEffect("turret/explode.efx");
ADDRGP4 $1452
ARGP4
ADDRLP4 156
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 156
INDIRI4
ASGNI4
line 1969
;1969:			break;
ADDRGP4 $1445
JUMPV
LABELV $1453
line 1971
;1970:		case EFFECT_SPARK_EXPLOSION:
;1971:			eID = trap_FX_RegisterEffect("spark_explosion.efx");
ADDRGP4 $1454
ARGP4
ADDRLP4 160
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 160
INDIRI4
ASGNI4
line 1972
;1972:			break;
ADDRGP4 $1445
JUMPV
LABELV $1455
line 1974
;1973:		case EFFECT_EXPLOSION_TRIPMINE:
;1974:			eID = trap_FX_RegisterEffect("tripMine/explosion.efx");
ADDRGP4 $1456
ARGP4
ADDRLP4 164
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 164
INDIRI4
ASGNI4
line 1975
;1975:			break;
ADDRGP4 $1445
JUMPV
LABELV $1457
line 1977
;1976:		case EFFECT_EXPLOSION_DETPACK:
;1977:			eID = trap_FX_RegisterEffect("detpack/explosion.efx");
ADDRGP4 $1458
ARGP4
ADDRLP4 168
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 168
INDIRI4
ASGNI4
line 1978
;1978:			break;
ADDRGP4 $1445
JUMPV
LABELV $1459
line 1980
;1979:		case EFFECT_EXPLOSION_FLECHETTE:
;1980:			eID = trap_FX_RegisterEffect("flechette/alt_blow.efx");
ADDRGP4 $1460
ARGP4
ADDRLP4 172
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 172
INDIRI4
ASGNI4
line 1981
;1981:			break;
ADDRGP4 $1445
JUMPV
LABELV $1461
line 1983
;1982:		case EFFECT_STUNHIT:
;1983:			eID = trap_FX_RegisterEffect("stunBaton/flesh_impact.efx");
ADDRGP4 $1462
ARGP4
ADDRLP4 176
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 176
INDIRI4
ASGNI4
line 1984
;1984:			break;
ADDRGP4 $1445
JUMPV
LABELV $1463
line 1986
;1985:		case EFFECT_EXPLOSION_DEMP2ALT:
;1986:			FX_DEMP2_AltDetonate( cent->lerpOrigin, es->weapon );
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 FX_DEMP2_AltDetonate
CALLV
pop
line 1987
;1987:			eID = trap_FX_RegisterEffect("demp2/altDetonate.efx");
ADDRGP4 $1464
ARGP4
ADDRLP4 180
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 180
INDIRI4
ASGNI4
line 1988
;1988:			break;
ADDRGP4 $1445
JUMPV
LABELV $1444
line 1990
;1989:		default:
;1990:			eID = -1;
ADDRLP4 28
CNSTI4 -1
ASGNI4
line 1991
;1991:			break;
LABELV $1445
line 1994
;1992:		}
;1993:
;1994:		if (eID != -1)
ADDRLP4 28
INDIRI4
CNSTI4 -1
EQI4 $647
line 1995
;1995:		{
line 1998
;1996:			vec3_t fxDir;
;1997:
;1998:			VectorCopy(es->angles, fxDir);
ADDRLP4 148
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 2000
;1999:
;2000:			if (!fxDir[0] && !fxDir[1] && !fxDir[2])
ADDRLP4 160
CNSTF4 0
ASGNF4
ADDRLP4 148
INDIRF4
ADDRLP4 160
INDIRF4
NEF4 $1469
ADDRLP4 148+4
INDIRF4
ADDRLP4 160
INDIRF4
NEF4 $1469
ADDRLP4 148+8
INDIRF4
ADDRLP4 160
INDIRF4
NEF4 $1469
line 2001
;2001:			{
line 2002
;2002:				fxDir[1] = 1;
ADDRLP4 148+4
CNSTF4 1065353216
ASGNF4
line 2003
;2003:			}
LABELV $1469
line 2005
;2004:
;2005:			trap_FX_PlayEffectID(eID, es->origin, fxDir);
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 2006
;2006:		}
line 2007
;2007:		break;
ADDRGP4 $647
JUMPV
LABELV $1474
line 2010
;2008:
;2009:	case EV_PLAY_EFFECT_ID:
;2010:		DEBUGNAME("EV_PLAY_EFFECT_ID");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1475
ADDRGP4 $1478
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1475
line 2011
;2011:		{
line 2014
;2012:			vec3_t fxDir;
;2013:
;2014:			AngleVectors(es->angles, fxDir, 0, 0);
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 148
ARGP4
ADDRLP4 160
CNSTP4 0
ASGNP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2016
;2015:			
;2016:			if (!fxDir[0] && !fxDir[1] && !fxDir[2])
ADDRLP4 164
CNSTF4 0
ASGNF4
ADDRLP4 148
INDIRF4
ADDRLP4 164
INDIRF4
NEF4 $1479
ADDRLP4 148+4
INDIRF4
ADDRLP4 164
INDIRF4
NEF4 $1479
ADDRLP4 148+8
INDIRF4
ADDRLP4 164
INDIRF4
NEF4 $1479
line 2017
;2017:			{
line 2018
;2018:				fxDir[1] = 1;
ADDRLP4 148+4
CNSTF4 1065353216
ASGNF4
line 2019
;2019:			}
LABELV $1479
line 2021
;2020:
;2021:			if ( cgs.gameEffects[ es->eventParm ] )
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+38396
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1484
line 2022
;2022:			{
line 2023
;2023:				trap_FX_PlayEffectID(cgs.gameEffects[es->eventParm], es->origin, fxDir );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+38396
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 2024
;2024:			}
ADDRGP4 $647
JUMPV
LABELV $1484
line 2026
;2025:			else
;2026:			{
line 2027
;2027:				s = CG_ConfigString( CS_EFFECTS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 768
ADDI4
ARGI4
ADDRLP4 168
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 168
INDIRP4
ASGNP4
line 2028
;2028:				if (s && s[0])
ADDRLP4 172
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $647
ADDRLP4 172
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $647
line 2029
;2029:				{
line 2030
;2030:					trap_FX_PlayEffectID(trap_FX_RegisterEffect(s), es->origin, fxDir );
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_FX_PlayEffectID
CALLV
pop
line 2031
;2031:				}
line 2032
;2032:			}
line 2033
;2033:		}
line 2034
;2034:		break;
ADDRGP4 $647
JUMPV
LABELV $1490
line 2037
;2035:
;2036:	case EV_MUTE_SOUND:
;2037:		DEBUGNAME("EV_MUTE_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1491
ADDRGP4 $1494
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1491
line 2038
;2038:		if (cg_entities[es->trickedentindex2].currentState.eFlags & EF_SOUNDTRACKER)
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+8
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $1495
line 2039
;2039:		{
line 2040
;2040:			cg_entities[es->trickedentindex2].currentState.eFlags -= EF_SOUNDTRACKER;
ADDRLP4 148
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+8
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
CNSTI4 8388608
SUBI4
ASGNI4
line 2041
;2041:		}
LABELV $1495
line 2042
;2042:		trap_S_MuteSound(es->trickedentindex2, es->trickedentindex);
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_MuteSound
CALLV
pop
line 2043
;2043:		trap_S_StopLoopingSound(es->trickedentindex2);
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 2044
;2044:		break;
ADDRGP4 $647
JUMPV
LABELV $1499
line 2047
;2045:
;2046:	case EV_GENERAL_SOUND:
;2047:		DEBUGNAME("EV_GENERAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1500
ADDRGP4 $1503
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1500
line 2048
;2048:		if (es->saberEntityNum == TRACK_CHANNEL_2 || es->saberEntityNum == TRACK_CHANNEL_3 ||
ADDRLP4 152
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 52
EQI4 $1507
ADDRLP4 152
INDIRI4
CNSTI4 53
EQI4 $1507
ADDRLP4 152
INDIRI4
CNSTI4 55
NEI4 $1504
LABELV $1507
line 2050
;2049:			es->saberEntityNum == TRACK_CHANNEL_5)
;2050:		{ //channels 2 and 3 are for speed and rage, 5 for sight
line 2051
;2051:			if ( cgs.gameSounds[ es->eventParm ] )
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
CNSTI4 0
EQI4 $647
line 2052
;2052:			{
line 2053
;2053:				trap_S_AddRealLoopingSound(es->number, es->pos.trBase, vec3_origin, cgs.gameSounds[ es->eventParm ] );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
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
ADDRGP4 trap_S_AddRealLoopingSound
CALLV
pop
line 2054
;2054:			}
line 2055
;2055:		}
ADDRGP4 $647
JUMPV
LABELV $1504
line 2057
;2056:		else
;2057:		{
line 2058
;2058:			if ( cgs.gameSounds[ es->eventParm ] ) {
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
CNSTI4 0
EQI4 $1512
line 2059
;2059:				trap_S_StartSound (NULL, es->number, CHAN_VOICE, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
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
line 2060
;2060:			} else {
ADDRGP4 $647
JUMPV
LABELV $1512
line 2061
;2061:				s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 156
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 156
INDIRP4
ASGNP4
line 2062
;2062:				trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 160
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2063
;2063:			}
line 2064
;2064:		}
line 2065
;2065:		break;
ADDRGP4 $647
JUMPV
LABELV $1516
line 2068
;2066:
;2067:	case EV_GLOBAL_SOUND:	// play from the player's head so it never diminishes
;2068:		DEBUGNAME("EV_GLOBAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1517
ADDRGP4 $1520
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1517
line 2069
;2069:		if ( cgs.gameSounds[ es->eventParm ] ) {
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
CNSTI4 0
EQI4 $1521
line 2070
;2070:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 0
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
line 2071
;2071:		} else {
ADDRGP4 $647
JUMPV
LABELV $1521
line 2072
;2072:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 156
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 156
INDIRP4
ASGNP4
line 2073
;2073:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 160
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2074
;2074:		}
line 2075
;2075:		break;
ADDRGP4 $647
JUMPV
LABELV $1527
line 2078
;2076:
;2077:	case EV_GLOBAL_TEAM_SOUND:	// play from the player's head so it never diminishes
;2078:		{
line 2079
;2079:			DEBUGNAME("EV_GLOBAL_TEAM_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1528
ADDRGP4 $1531
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1528
line 2080
;2080:			switch( es->eventParm ) {
ADDRLP4 156
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $647
ADDRLP4 156
INDIRI4
CNSTI4 10
GTI4 $647
ADDRLP4 156
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1584
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1584
address $647
address $647
address $1537
address $1545
address $1553
address $1561
address $1569
address $1572
address $1575
address $1578
address $1581
code
line 2083
;2081:				case GTS_RED_CAPTURE: // CTF: red team captured the blue flag, 1FCTF: red team captured the neutral flag
;2082:					//CG_AddBufferedSound( cgs.media.redScoredSound );
;2083:					break;
line 2086
;2084:				case GTS_BLUE_CAPTURE: // CTF: blue team captured the red flag, 1FCTF: blue team captured the neutral flag
;2085:					//CG_AddBufferedSound( cgs.media.blueScoredSound );
;2086:					break;
LABELV $1537
line 2088
;2087:				case GTS_RED_RETURN: // CTF: blue flag returned, 1FCTF: never used
;2088:					if (cgs.gametype == GT_CTY)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $1538
line 2089
;2089:					{
line 2090
;2090:						CG_AddBufferedSound( cgs.media.blueYsalReturnedSound );
ADDRGP4 cgs+70280+828
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2091
;2091:					}
ADDRGP4 $647
JUMPV
LABELV $1538
line 2093
;2092:					else
;2093:					{
line 2094
;2094:						CG_AddBufferedSound( cgs.media.blueFlagReturnedSound );
ADDRGP4 cgs+70280+812
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2095
;2095:					}
line 2096
;2096:					break;
ADDRGP4 $647
JUMPV
LABELV $1545
line 2098
;2097:				case GTS_BLUE_RETURN: // CTF red flag returned, 1FCTF: neutral flag returned
;2098:					if (cgs.gametype == GT_CTY)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $1546
line 2099
;2099:					{
line 2100
;2100:						CG_AddBufferedSound( cgs.media.redYsalReturnedSound );
ADDRGP4 cgs+70280+824
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2101
;2101:					}
ADDRGP4 $647
JUMPV
LABELV $1546
line 2103
;2102:					else
;2103:					{
line 2104
;2104:						CG_AddBufferedSound( cgs.media.redFlagReturnedSound );
ADDRGP4 cgs+70280+808
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2105
;2105:					}
line 2106
;2106:					break;
ADDRGP4 $647
JUMPV
LABELV $1553
line 2110
;2107:
;2108:				case GTS_RED_TAKEN: // CTF: red team took blue flag, 1FCTF: blue team took the neutral flag
;2109:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;2110:					if (cgs.gametype == GT_CTY)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $1554
line 2111
;2111:					{
line 2112
;2112:						CG_AddBufferedSound( cgs.media.redTookYsalSound );
ADDRGP4 cgs+70280+832
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2113
;2113:					}
ADDRGP4 $647
JUMPV
LABELV $1554
line 2115
;2114:					else
;2115:					{
line 2116
;2116:					 	CG_AddBufferedSound( cgs.media.redTookFlagSound );
ADDRGP4 cgs+70280+816
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2117
;2117:					}
line 2118
;2118:					break;
ADDRGP4 $647
JUMPV
LABELV $1561
line 2121
;2119:				case GTS_BLUE_TAKEN: // CTF: blue team took the red flag, 1FCTF red team took the neutral flag
;2120:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;2121:					if (cgs.gametype == GT_CTY)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $1562
line 2122
;2122:					{
line 2123
;2123:						CG_AddBufferedSound( cgs.media.blueTookYsalSound );
ADDRGP4 cgs+70280+836
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2124
;2124:					}
ADDRGP4 $647
JUMPV
LABELV $1562
line 2126
;2125:					else
;2126:					{
line 2127
;2127:						CG_AddBufferedSound( cgs.media.blueTookFlagSound );
ADDRGP4 cgs+70280+820
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2128
;2128:					}
line 2129
;2129:					break;
ADDRGP4 $647
JUMPV
LABELV $1569
line 2131
;2130:				case GTS_REDTEAM_SCORED:
;2131:					CG_AddBufferedSound(cgs.media.redScoredSound);
ADDRGP4 cgs+70280+788
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2132
;2132:					break;
ADDRGP4 $647
JUMPV
LABELV $1572
line 2134
;2133:				case GTS_BLUETEAM_SCORED:
;2134:					CG_AddBufferedSound(cgs.media.blueScoredSound);
ADDRGP4 cgs+70280+792
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2135
;2135:					break;
ADDRGP4 $647
JUMPV
LABELV $1575
line 2137
;2136:				case GTS_REDTEAM_TOOK_LEAD:
;2137:					CG_AddBufferedSound(cgs.media.redLeadsSound);
ADDRGP4 cgs+70280+796
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2138
;2138:					break;
ADDRGP4 $647
JUMPV
LABELV $1578
line 2140
;2139:				case GTS_BLUETEAM_TOOK_LEAD:
;2140:					CG_AddBufferedSound(cgs.media.blueLeadsSound);
ADDRGP4 cgs+70280+800
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2141
;2141:					break;
ADDRGP4 $647
JUMPV
LABELV $1581
line 2143
;2142:				case GTS_TEAMS_ARE_TIED:
;2143:					CG_AddBufferedSound( cgs.media.teamsTiedSound );
ADDRGP4 cgs+70280+804
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 2144
;2144:					break;
line 2146
;2145:				default:
;2146:					break;
line 2148
;2147:			}
;2148:			break;
ADDRGP4 $647
JUMPV
LABELV $1585
line 2152
;2149:		}
;2150:
;2151:	case EV_ENTITY_SOUND:
;2152:		DEBUGNAME("EV_ENTITY_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1586
ADDRGP4 $1589
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1586
line 2154
;2153:		//somewhat of a hack - weapon is the caller entity's index, trickedentindex is the proper sound channel
;2154:		if ( cgs.gameSounds[ es->eventParm ] ) {
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
CNSTI4 0
EQI4 $1590
line 2155
;2155:			trap_S_StartSound (NULL, es->weapon, es->trickedentindex, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
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
line 2156
;2156:		} else {
ADDRGP4 $647
JUMPV
LABELV $1590
line 2157
;2157:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 156
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 156
INDIRP4
ASGNP4
line 2158
;2158:			trap_S_StartSound (NULL, es->weapon, es->trickedentindex, CG_CustomSound( es->weapon, s ) );
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2159
;2159:		}
line 2160
;2160:		break;
ADDRGP4 $647
JUMPV
LABELV $1594
line 2163
;2161:
;2162:	case EV_PLAY_ROFF:
;2163:		DEBUGNAME("EV_PLAY_ROFF");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1595
ADDRGP4 $1598
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1595
line 2164
;2164:		trap_ROFF_Play(es->weapon, es->eventParm, es->trickedentindex);
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_ROFF_Play
CALLI4
pop
line 2165
;2165:		break;
ADDRGP4 $647
JUMPV
LABELV $1599
line 2168
;2166:
;2167:	case EV_GLASS_SHATTER:
;2168:		DEBUGNAME("EV_GLASS_SHATTER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1600
ADDRGP4 $1603
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1600
line 2169
;2169:		CG_GlassShatter(es->genericenemyindex, es->origin, es->angles, es->trickedentindex, es->pos.trTime);
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
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
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_GlassShatter
CALLV
pop
line 2170
;2170:		break;
ADDRGP4 $647
JUMPV
LABELV $1604
line 2173
;2171:
;2172:	case EV_DEBRIS:
;2173:		DEBUGNAME("EV_DEBRIS");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1605
ADDRGP4 $1608
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1605
line 2174
;2174:		if (es->weapon)
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1609
line 2175
;2175:		{
line 2176
;2176:			if (cgs.gameSounds[es->weapon])
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37372
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1611
line 2177
;2177:			{
line 2178
;2178:				isnd = cgs.gameSounds[es->weapon];
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37372
ADDP4
INDIRI4
ASGNI4
line 2179
;2179:			}
ADDRGP4 $1610
JUMPV
LABELV $1611
line 2181
;2180:			else
;2181:			{
line 2182
;2182:				s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 164
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 164
INDIRP4
ASGNP4
line 2183
;2183:				isnd = CG_CustomSound( es->number, s );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 168
INDIRI4
ASGNI4
line 2184
;2184:			}
line 2185
;2185:		}
ADDRGP4 $1610
JUMPV
LABELV $1609
line 2187
;2186:		else
;2187:		{
line 2188
;2188:			isnd = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2189
;2189:		}
LABELV $1610
line 2191
;2190:
;2191:		if (es->trickedentindex > 0)
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1615
line 2192
;2192:		{
line 2193
;2193:			if (cgs.gameModels[es->trickedentindex])
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1617
line 2194
;2194:			{
line 2195
;2195:				CG_CreateDebris(es->number, es->pos.trBase, es->angles, es->origin, isnd, cgs.gameModels[es->trickedentindex]);
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36348
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_CreateDebris
CALLV
pop
line 2196
;2196:			}
ADDRGP4 $647
JUMPV
LABELV $1617
line 2198
;2197:			else
;2198:			{ //default to "rock" type
line 2199
;2199:				CG_CreateDebris(es->number, es->pos.trBase, es->angles, es->origin, isnd, -1);
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
ADDRGP4 CG_CreateDebris
CALLV
pop
line 2200
;2200:			}
line 2201
;2201:		}
ADDRGP4 $647
JUMPV
LABELV $1615
line 2203
;2202:		else
;2203:		{
line 2204
;2204:			CG_CreateDebris(es->number, es->pos.trBase, es->angles, es->origin, isnd, es->trickedentindex);
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_CreateDebris
CALLV
pop
line 2205
;2205:		}
line 2206
;2206:		break;
ADDRGP4 $647
JUMPV
LABELV $1621
line 2211
;2207:
;2208:	case EV_PAIN:
;2209:		// local player sounds are triggered in CG_CheckLocalSounds,
;2210:		// so ignore events on the player
;2211:		DEBUGNAME("EV_PAIN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1622
ADDRGP4 $1625
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1622
line 2212
;2212:		if ( cent->currentState.number != cg.snap->ps.clientNum ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
EQI4 $647
line 2213
;2213:			CG_PainEvent( cent, es->eventParm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 2214
;2214:		}
line 2215
;2215:		break;
ADDRGP4 $647
JUMPV
LABELV $1629
line 2220
;2216:
;2217:	case EV_DEATH1:
;2218:	case EV_DEATH2:
;2219:	case EV_DEATH3:
;2220:		DEBUGNAME("EV_DEATHx");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1630
ADDRGP4 $1633
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1630
line 2221
;2221:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, 
ADDRGP4 $1634
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 78
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 164
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 168
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2223
;2222:				CG_CustomSound( es->number, va("*death%i.wav", event - EV_DEATH1 + 1) ) );
;2223:		if (es->eventParm && es->number == cg.snap->ps.clientNum)
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
EQI4 $647
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $647
line 2224
;2224:		{
line 2225
;2225:			trap_S_StartLocalSound(cgs.media.dramaticFailure, CHAN_LOCAL);
ADDRGP4 cgs+70280+848
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2226
;2226:			CGCam_SetMusicMult(0.3, 5000);
CNSTF4 1050253722
ARGF4
CNSTI4 5000
ARGI4
ADDRGP4 CGCam_SetMusicMult
CALLV
pop
line 2227
;2227:		}
line 2228
;2228:		break;
ADDRGP4 $647
JUMPV
LABELV $1640
line 2232
;2229:
;2230:
;2231:	case EV_OBITUARY:
;2232:		DEBUGNAME("EV_OBITUARY");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1641
ADDRGP4 $1644
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1641
line 2233
;2233:		CG_Obituary( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Obituary
CALLV
pop
line 2234
;2234:		break;
ADDRGP4 $647
JUMPV
LABELV $1645
line 2240
;2235:
;2236:	//
;2237:	// powerup events
;2238:	//
;2239:	case EV_POWERUP_QUAD:
;2240:		DEBUGNAME("EV_POWERUP_QUAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1646
ADDRGP4 $1649
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1646
line 2241
;2241:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $647
line 2242
;2242:			cg.powerupActive = PW_QUAD;
ADDRGP4 cg+13092
CNSTI4 1
ASGNI4
line 2243
;2243:			cg.powerupTime = cg.time;
ADDRGP4 cg+13096
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 2244
;2244:		}
line 2246
;2245:		//trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.quadSound );
;2246:		break;
ADDRGP4 $647
JUMPV
LABELV $1656
line 2248
;2247:	case EV_POWERUP_BATTLESUIT:
;2248:		DEBUGNAME("EV_POWERUP_BATTLESUIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1657
ADDRGP4 $1660
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1657
line 2249
;2249:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $647
line 2250
;2250:			cg.powerupActive = PW_BATTLESUIT;
ADDRGP4 cg+13092
CNSTI4 2
ASGNI4
line 2251
;2251:			cg.powerupTime = cg.time;
ADDRGP4 cg+13096
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 2252
;2252:		}
line 2254
;2253:		//trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.protectSound );
;2254:		break;
ADDRGP4 $647
JUMPV
LABELV $1667
line 2257
;2255:
;2256:	case EV_FORCE_DRAINED:
;2257:		DEBUGNAME("EV_FORCE_DRAINED");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1668
ADDRGP4 $1671
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1668
line 2258
;2258:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 2260
;2259:		//FX_ForceDrained(position, dir);
;2260:		trap_S_StartSound (NULL, es->owner, CHAN_AUTO, cgs.media.drainSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+70280+840
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2261
;2261:		cg_entities[es->owner].teamPowerEffectTime = cg.time + 1000;
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+1912
ADDP4
ADDRGP4 cg+64
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 2262
;2262:		cg_entities[es->owner].teamPowerType = 2;
CNSTI4 1920
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+1916
ADDP4
CNSTI4 2
ASGNI4
line 2263
;2263:		break;
ADDRGP4 $647
JUMPV
LABELV $1677
line 2266
;2264:
;2265:	case EV_GIB_PLAYER:
;2266:		DEBUGNAME("EV_GIB_PLAYER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1678
ADDRGP4 $1681
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1678
line 2268
;2267:		//trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.gibSound );
;2268:		CG_GibPlayer( cent->lerpOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 2269
;2269:		break;
ADDRGP4 $647
JUMPV
LABELV $1682
line 2272
;2270:
;2271:	case EV_STARTLOOPINGSOUND:
;2272:		DEBUGNAME("EV_STARTLOOPINGSOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1683
ADDRGP4 $1686
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1683
line 2273
;2273:		if ( cgs.gameSounds[ es->eventParm ] )
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
CNSTI4 0
EQI4 $1687
line 2274
;2274:		{
line 2275
;2275:			isnd = cgs.gameSounds[es->eventParm];
ADDRLP4 12
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
ASGNI4
line 2276
;2276:		}
ADDRGP4 $1688
JUMPV
LABELV $1687
line 2278
;2277:		else
;2278:		{
line 2279
;2279:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 176
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 176
INDIRP4
ASGNP4
line 2280
;2280:			isnd = CG_CustomSound(es->number, s);
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 180
INDIRI4
ASGNI4
line 2281
;2281:		}
LABELV $1688
line 2283
;2282:
;2283:		trap_S_AddRealLoopingSound( es->number, es->pos.trBase, vec3_origin, isnd );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_AddRealLoopingSound
CALLV
pop
line 2284
;2284:		es->loopSound = isnd;
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 2285
;2285:		break;
ADDRGP4 $647
JUMPV
LABELV $1691
line 2288
;2286:
;2287:	case EV_STOPLOOPINGSOUND:
;2288:		DEBUGNAME("EV_STOPLOOPINGSOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1692
ADDRGP4 $1695
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1692
line 2289
;2289:		trap_S_StopLoopingSound( es->number );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 2290
;2290:		es->loopSound = 0;
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 0
ASGNI4
line 2291
;2291:		break;
ADDRGP4 $647
JUMPV
LABELV $1696
line 2294
;2292:
;2293:	case EV_WEAPON_CHARGE:
;2294:		DEBUGNAME("EV_WEAPON_CHARGE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1697
ADDRGP4 $1700
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1697
line 2295
;2295:		assert(es->eventParm > WP_NONE && es->eventParm < WP_NUM_WEAPONS);
line 2296
;2296:		if (cg_weapons[es->eventParm].chargeSound)
CNSTI4 208
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+88
ADDP4
INDIRI4
CNSTI4 0
EQI4 $647
line 2297
;2297:		{
line 2298
;2298:			trap_S_StartSound(NULL, es->number, CHAN_WEAPON, cg_weapons[es->eventParm].chargeSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 208
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+88
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2299
;2299:		}
line 2300
;2300:		break;
ADDRGP4 $647
JUMPV
LABELV $1705
line 2303
;2301:
;2302:	case EV_WEAPON_CHARGE_ALT:
;2303:		DEBUGNAME("EV_WEAPON_CHARGE_ALT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1706
ADDRGP4 $1709
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1706
line 2304
;2304:		assert(es->eventParm > WP_NONE && es->eventParm < WP_NUM_WEAPONS);
line 2305
;2305:		if (cg_weapons[es->eventParm].altChargeSound)
CNSTI4 208
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+152
ADDP4
INDIRI4
CNSTI4 0
EQI4 $647
line 2306
;2306:		{
line 2307
;2307:			trap_S_StartSound(NULL, es->number, CHAN_WEAPON, cg_weapons[es->eventParm].altChargeSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 208
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+152
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2308
;2308:		}
line 2309
;2309:		break;
ADDRGP4 $647
JUMPV
LABELV $1714
line 2312
;2310:
;2311:	case EV_SHIELD_HIT:
;2312:		DEBUGNAME("EV_SHIELD_HIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1715
ADDRGP4 $1718
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1715
line 2313
;2313:		ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 2314
;2314:		CG_PlayerShieldHit(es->otherEntityNum, dir, es->time2);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PlayerShieldHit
CALLV
pop
line 2315
;2315:		break;
ADDRGP4 $647
JUMPV
LABELV $1719
line 2318
;2316:
;2317:	case EV_DEBUG_LINE:
;2318:		DEBUGNAME("EV_DEBUG_LINE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1720
ADDRGP4 $1723
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1720
line 2319
;2319:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 2320
;2320:		break;
ADDRGP4 $647
JUMPV
LABELV $1724
line 2323
;2321:
;2322:	case EV_TESTLINE:
;2323:		DEBUGNAME("EV_TESTLINE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1725
ADDRGP4 $1728
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1725
line 2324
;2324:		CG_TestLine(es->origin, es->origin2, es->time2, es->weapon, 1);
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CVIU4 4
ARGU4
CNSTI4 1
ARGI4
ADDRGP4 CG_TestLine
CALLV
pop
line 2325
;2325:		break;
ADDRGP4 $647
JUMPV
LABELV $1729
line 2328
;2326:
;2327:	case EV_BODY_QUEUE_COPY:
;2328:		DEBUGNAME("EV_BODY_QUEUE_COPY");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1730
ADDRGP4 $1733
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1730
line 2329
;2329:		CG_BodyQueueCopy(cent, es->eventParm, es->weapon);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_BodyQueueCopy
CALLV
pop
line 2330
;2330:		break;
ADDRGP4 $647
JUMPV
LABELV $646
line 2333
;2331:
;2332:	default:
;2333:		DEBUGNAME("UNKNOWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1734
ADDRGP4 $1737
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1734
line 2334
;2334:		CG_Error( "Unknown event: %i", event );
ADDRGP4 $1738
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 2335
;2335:		break;
LABELV $647
line 2338
;2336:	}
;2337:
;2338:}
LABELV $631
endproc CG_EntityEvent 1248 36
export CG_CheckEvents
proc CG_CheckEvents 8 12
line 2347
;2339:
;2340:
;2341:/*
;2342:==============
;2343:CG_CheckEvents
;2344:
;2345:==============
;2346:*/
;2347:void CG_CheckEvents( centity_t *cent ) {
line 2349
;2348:	// check for event-only entities
;2349:	if ( cent->currentState.eType > ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 16
LEI4 $1742
line 2350
;2350:		if ( cent->previousEvent ) {
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1744
line 2351
;2351:			return;	// already fired
ADDRGP4 $1741
JUMPV
LABELV $1744
line 2354
;2352:		}
;2353:		// if this is a player event set the entity number of the client entity number
;2354:		if ( cent->currentState.eFlags & EF_PLAYER_EVENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1746
line 2355
;2355:			cent->currentState.number = cent->currentState.otherEntityNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 2356
;2356:		}
LABELV $1746
line 2358
;2357:
;2358:		cent->previousEvent = 1;
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
CNSTI4 1
ASGNI4
line 2360
;2359:
;2360:		cent->currentState.event = cent->currentState.eType - ET_EVENTS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 2361
;2361:	} else {
ADDRGP4 $1743
JUMPV
LABELV $1742
line 2363
;2362:		// check for events riding with another entity
;2363:		if ( cent->currentState.event == cent->previousEvent ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
NEI4 $1748
line 2364
;2364:			return;
ADDRGP4 $1741
JUMPV
LABELV $1748
line 2366
;2365:		}
;2366:		cent->previousEvent = cent->currentState.event;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 604
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
ASGNI4
line 2367
;2367:		if ( ( cent->currentState.event & ~EV_EVENT_BITS ) == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 0
NEI4 $1750
line 2368
;2368:			return;
ADDRGP4 $1741
JUMPV
LABELV $1750
line 2370
;2369:		}
;2370:	}
LABELV $1743
line 2373
;2371:
;2372:	// calculate the position at exactly the frame time
;2373:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
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
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2374
;2374:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 2376
;2375:
;2376:	CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
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
line 2377
;2377:}
LABELV $1741
endproc CG_CheckEvents 8 12
import CG_ThereIsAMaster
import showPowersName
import g_saberFlashPos
import g_saberFlashTime
import trap_SP_Register
import trap_SP_RegisterServer
import trap_PC_RemoveAllGlobalDefines
import trap_PC_LoadGlobalDefines
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Controls_SetConfig
import Controls_GetConfig
import UI_OutOfMemory
import UI_InitMemory
import UI_Alloc
import Display_CacheAll
import Menu_SetFeederSelection
import Menu_Paint
import Menus_CloseAll
import LerpColor
import Display_HandleKey
import Menus_CloseByName
import Menus_ShowByName
import Menus_FindByName
import Menus_OpenByName
import Display_KeyBindPending
import Display_CursorType
import Display_MouseMove
import Display_CaptureItem
import Display_GetContext
import Menus_Activate
import Menus_AnyFullScreenVisible
import Menu_Reset
import Menus_ActivateByName
import Menu_PaintAll
import Menu_New
import Menu_Count
import PC_Script_Parse
import PC_String_Parse
import PC_Rect_Parse
import PC_Int_Parse
import PC_Color_Parse
import PC_Float_Parse
import Script_Parse
import String_Parse
import Rect_Parse
import Int_Parse
import Color_Parse
import Float_Parse
import Menu_ScrollFeeder
import Menu_HandleMouseMove
import Menu_HandleKey
import Menu_GetFocused
import Menu_PostParse
import Item_Init
import Menu_Init
import Display_ExpandMacros
import Init_Display
import String_Report
import String_Init
import String_Alloc
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
LABELV $1738
char 1 85
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 32
char 1 101
char 1 118
char 1 101
char 1 110
char 1 116
char 1 58
char 1 32
char 1 37
char 1 105
char 1 0
align 1
LABELV $1737
char 1 85
char 1 78
char 1 75
char 1 78
char 1 79
char 1 87
char 1 78
char 1 10
char 1 0
align 1
LABELV $1733
char 1 69
char 1 86
char 1 95
char 1 66
char 1 79
char 1 68
char 1 89
char 1 95
char 1 81
char 1 85
char 1 69
char 1 85
char 1 69
char 1 95
char 1 67
char 1 79
char 1 80
char 1 89
char 1 10
char 1 0
align 1
LABELV $1728
char 1 69
char 1 86
char 1 95
char 1 84
char 1 69
char 1 83
char 1 84
char 1 76
char 1 73
char 1 78
char 1 69
char 1 10
char 1 0
align 1
LABELV $1723
char 1 69
char 1 86
char 1 95
char 1 68
char 1 69
char 1 66
char 1 85
char 1 71
char 1 95
char 1 76
char 1 73
char 1 78
char 1 69
char 1 10
char 1 0
align 1
LABELV $1718
char 1 69
char 1 86
char 1 95
char 1 83
char 1 72
char 1 73
char 1 69
char 1 76
char 1 68
char 1 95
char 1 72
char 1 73
char 1 84
char 1 10
char 1 0
align 1
LABELV $1709
char 1 69
char 1 86
char 1 95
char 1 87
char 1 69
char 1 65
char 1 80
char 1 79
char 1 78
char 1 95
char 1 67
char 1 72
char 1 65
char 1 82
char 1 71
char 1 69
char 1 95
char 1 65
char 1 76
char 1 84
char 1 10
char 1 0
align 1
LABELV $1700
char 1 69
char 1 86
char 1 95
char 1 87
char 1 69
char 1 65
char 1 80
char 1 79
char 1 78
char 1 95
char 1 67
char 1 72
char 1 65
char 1 82
char 1 71
char 1 69
char 1 10
char 1 0
align 1
LABELV $1695
char 1 69
char 1 86
char 1 95
char 1 83
char 1 84
char 1 79
char 1 80
char 1 76
char 1 79
char 1 79
char 1 80
char 1 73
char 1 78
char 1 71
char 1 83
char 1 79
char 1 85
char 1 78
char 1 68
char 1 10
char 1 0
align 1
LABELV $1686
char 1 69
char 1 86
char 1 95
char 1 83
char 1 84
char 1 65
char 1 82
char 1 84
char 1 76
char 1 79
char 1 79
char 1 80
char 1 73
char 1 78
char 1 71
char 1 83
char 1 79
char 1 85
char 1 78
char 1 68
char 1 10
char 1 0
align 1
LABELV $1681
char 1 69
char 1 86
char 1 95
char 1 71
char 1 73
char 1 66
char 1 95
char 1 80
char 1 76
char 1 65
char 1 89
char 1 69
char 1 82
char 1 10
char 1 0
align 1
LABELV $1671
char 1 69
char 1 86
char 1 95
char 1 70
char 1 79
char 1 82
char 1 67
char 1 69
char 1 95
char 1 68
char 1 82
char 1 65
char 1 73
char 1 78
char 1 69
char 1 68
char 1 10
char 1 0
align 1
LABELV $1660
char 1 69
char 1 86
char 1 95
char 1 80
char 1 79
char 1 87
char 1 69
char 1 82
char 1 85
char 1 80
char 1 95
char 1 66
char 1 65
char 1 84
char 1 84
char 1 76
char 1 69
char 1 83
char 1 85
char 1 73
char 1 84
char 1 10
char 1 0
align 1
LABELV $1649
char 1 69
char 1 86
char 1 95
char 1 80
char 1 79
char 1 87
char 1 69
char 1 82
char 1 85
char 1 80
char 1 95
char 1 81
char 1 85
char 1 65
char 1 68
char 1 10
char 1 0
align 1
LABELV $1644
char 1 69
char 1 86
char 1 95
char 1 79
char 1 66
char 1 73
char 1 84
char 1 85
char 1 65
char 1 82
char 1 89
char 1 10
char 1 0
align 1
LABELV $1634
char 1 42
char 1 100
char 1 101
char 1 97
char 1 116
char 1 104
char 1 37
char 1 105
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $1633
char 1 69
char 1 86
char 1 95
char 1 68
char 1 69
char 1 65
char 1 84
char 1 72
char 1 120
char 1 10
char 1 0
align 1
LABELV $1625
char 1 69
char 1 86
char 1 95
char 1 80
char 1 65
char 1 73
char 1 78
char 1 10
char 1 0
align 1
LABELV $1608
char 1 69
char 1 86
char 1 95
char 1 68
char 1 69
char 1 66
char 1 82
char 1 73
char 1 83
char 1 10
char 1 0
align 1
LABELV $1603
char 1 69
char 1 86
char 1 95
char 1 71
char 1 76
char 1 65
char 1 83
char 1 83
char 1 95
char 1 83
char 1 72
char 1 65
char 1 84
char 1 84
char 1 69
char 1 82
char 1 10
char 1 0
align 1
LABELV $1598
char 1 69
char 1 86
char 1 95
char 1 80
char 1 76
char 1 65
char 1 89
char 1 95
char 1 82
char 1 79
char 1 70
char 1 70
char 1 10
char 1 0
align 1
LABELV $1589
char 1 69
char 1 86
char 1 95
char 1 69
char 1 78
char 1 84
char 1 73
char 1 84
char 1 89
char 1 95
char 1 83
char 1 79
char 1 85
char 1 78
char 1 68
char 1 10
char 1 0
align 1
LABELV $1531
char 1 69
char 1 86
char 1 95
char 1 71
char 1 76
char 1 79
char 1 66
char 1 65
char 1 76
char 1 95
char 1 84
char 1 69
char 1 65
char 1 77
char 1 95
char 1 83
char 1 79
char 1 85
char 1 78
char 1 68
char 1 10
char 1 0
align 1
LABELV $1520
char 1 69
char 1 86
char 1 95
char 1 71
char 1 76
char 1 79
char 1 66
char 1 65
char 1 76
char 1 95
char 1 83
char 1 79
char 1 85
char 1 78
char 1 68
char 1 10
char 1 0
align 1
LABELV $1503
char 1 69
char 1 86
char 1 95
char 1 71
char 1 69
char 1 78
char 1 69
char 1 82
char 1 65
char 1 76
char 1 95
char 1 83
char 1 79
char 1 85
char 1 78
char 1 68
char 1 10
char 1 0
align 1
LABELV $1494
char 1 69
char 1 86
char 1 95
char 1 77
char 1 85
char 1 84
char 1 69
char 1 95
char 1 83
char 1 79
char 1 85
char 1 78
char 1 68
char 1 10
char 1 0
align 1
LABELV $1478
char 1 69
char 1 86
char 1 95
char 1 80
char 1 76
char 1 65
char 1 89
char 1 95
char 1 69
char 1 70
char 1 70
char 1 69
char 1 67
char 1 84
char 1 95
char 1 73
char 1 68
char 1 10
char 1 0
align 1
LABELV $1464
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
LABELV $1462
char 1 115
char 1 116
char 1 117
char 1 110
char 1 66
char 1 97
char 1 116
char 1 111
char 1 110
char 1 47
char 1 102
char 1 108
char 1 101
char 1 115
char 1 104
char 1 95
char 1 105
char 1 109
char 1 112
char 1 97
char 1 99
char 1 116
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1460
char 1 102
char 1 108
char 1 101
char 1 99
char 1 104
char 1 101
char 1 116
char 1 116
char 1 101
char 1 47
char 1 97
char 1 108
char 1 116
char 1 95
char 1 98
char 1 108
char 1 111
char 1 119
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1458
char 1 100
char 1 101
char 1 116
char 1 112
char 1 97
char 1 99
char 1 107
char 1 47
char 1 101
char 1 120
char 1 112
char 1 108
char 1 111
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
LABELV $1456
char 1 116
char 1 114
char 1 105
char 1 112
char 1 77
char 1 105
char 1 110
char 1 101
char 1 47
char 1 101
char 1 120
char 1 112
char 1 108
char 1 111
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
LABELV $1454
char 1 115
char 1 112
char 1 97
char 1 114
char 1 107
char 1 95
char 1 101
char 1 120
char 1 112
char 1 108
char 1 111
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
LABELV $1452
char 1 116
char 1 117
char 1 114
char 1 114
char 1 101
char 1 116
char 1 47
char 1 101
char 1 120
char 1 112
char 1 108
char 1 111
char 1 100
char 1 101
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1450
char 1 101
char 1 109
char 1 112
char 1 108
char 1 97
char 1 99
char 1 101
char 1 100
char 1 47
char 1 101
char 1 120
char 1 112
char 1 108
char 1 111
char 1 100
char 1 101
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1448
char 1 101
char 1 109
char 1 112
char 1 108
char 1 97
char 1 99
char 1 101
char 1 100
char 1 47
char 1 100
char 1 101
char 1 97
char 1 100
char 1 95
char 1 115
char 1 109
char 1 111
char 1 107
char 1 101
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1443
char 1 69
char 1 86
char 1 95
char 1 80
char 1 76
char 1 65
char 1 89
char 1 95
char 1 69
char 1 70
char 1 70
char 1 69
char 1 67
char 1 84
char 1 10
char 1 0
align 1
LABELV $1436
char 1 69
char 1 86
char 1 95
char 1 77
char 1 73
char 1 83
char 1 83
char 1 73
char 1 76
char 1 69
char 1 95
char 1 77
char 1 73
char 1 83
char 1 83
char 1 95
char 1 77
char 1 69
char 1 84
char 1 65
char 1 76
char 1 10
char 1 0
align 1
LABELV $1429
char 1 69
char 1 86
char 1 95
char 1 77
char 1 73
char 1 83
char 1 83
char 1 73
char 1 76
char 1 69
char 1 95
char 1 77
char 1 73
char 1 83
char 1 83
char 1 10
char 1 0
align 1
LABELV $1422
char 1 69
char 1 86
char 1 95
char 1 77
char 1 73
char 1 83
char 1 83
char 1 73
char 1 76
char 1 69
char 1 95
char 1 72
char 1 73
char 1 84
char 1 10
char 1 0
align 1
LABELV $1417
char 1 69
char 1 86
char 1 95
char 1 77
char 1 73
char 1 83
char 1 83
char 1 73
char 1 76
char 1 69
char 1 95
char 1 83
char 1 84
char 1 73
char 1 67
char 1 75
char 1 10
char 1 0
align 1
LABELV $1412
char 1 117
char 1 105
char 1 95
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 80
char 1 111
char 1 119
char 1 101
char 1 114
char 1 68
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $1411
char 1 69
char 1 86
char 1 95
char 1 83
char 1 69
char 1 84
char 1 95
char 1 70
char 1 79
char 1 82
char 1 67
char 1 69
char 1 95
char 1 68
char 1 73
char 1 83
char 1 65
char 1 66
char 1 76
char 1 69
char 1 10
char 1 0
align 1
LABELV $1406
char 1 117
char 1 105
char 1 95
char 1 102
char 1 114
char 1 101
char 1 101
char 1 83
char 1 97
char 1 98
char 1 101
char 1 114
char 1 0
align 1
LABELV $1405
char 1 69
char 1 86
char 1 95
char 1 83
char 1 69
char 1 84
char 1 95
char 1 70
char 1 82
char 1 69
char 1 69
char 1 95
char 1 83
char 1 65
char 1 66
char 1 69
char 1 82
char 1 10
char 1 0
align 1
LABELV $1398
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
LABELV $1397
char 1 37
char 1 105
char 1 0
align 1
LABELV $1396
char 1 117
char 1 105
char 1 95
char 1 114
char 1 97
char 1 110
char 1 107
char 1 67
char 1 104
char 1 97
char 1 110
char 1 103
char 1 101
char 1 0
align 1
LABELV $1392
char 1 69
char 1 86
char 1 95
char 1 71
char 1 73
char 1 86
char 1 69
char 1 95
char 1 78
char 1 69
char 1 87
char 1 95
char 1 82
char 1 65
char 1 78
char 1 75
char 1 10
char 1 0
align 1
LABELV $1381
char 1 69
char 1 86
char 1 95
char 1 68
char 1 69
char 1 83
char 1 84
char 1 82
char 1 79
char 1 89
char 1 95
char 1 87
char 1 69
char 1 65
char 1 80
char 1 79
char 1 78
char 1 95
char 1 77
char 1 79
char 1 68
char 1 69
char 1 76
char 1 10
char 1 0
align 1
LABELV $1369
char 1 69
char 1 86
char 1 95
char 1 68
char 1 69
char 1 83
char 1 84
char 1 82
char 1 79
char 1 89
char 1 95
char 1 71
char 1 72
char 1 79
char 1 85
char 1 76
char 1 50
char 1 95
char 1 73
char 1 78
char 1 83
char 1 84
char 1 65
char 1 78
char 1 67
char 1 69
char 1 10
char 1 0
align 1
LABELV $1364
char 1 69
char 1 86
char 1 95
char 1 83
char 1 65
char 1 71
char 1 65
char 1 95
char 1 79
char 1 66
char 1 74
char 1 69
char 1 67
char 1 84
char 1 73
char 1 86
char 1 69
char 1 67
char 1 79
char 1 77
char 1 80
char 1 76
char 1 69
char 1 84
char 1 69
char 1 10
char 1 0
align 1
LABELV $1359
char 1 69
char 1 86
char 1 95
char 1 83
char 1 65
char 1 71
char 1 65
char 1 95
char 1 82
char 1 79
char 1 85
char 1 78
char 1 68
char 1 79
char 1 86
char 1 69
char 1 82
char 1 10
char 1 0
align 1
LABELV $1354
char 1 69
char 1 86
char 1 95
char 1 67
char 1 84
char 1 70
char 1 77
char 1 69
char 1 83
char 1 83
char 1 65
char 1 71
char 1 69
char 1 10
char 1 0
align 1
LABELV $1349
char 1 69
char 1 86
char 1 95
char 1 83
char 1 67
char 1 79
char 1 82
char 1 69
char 1 80
char 1 76
char 1 85
char 1 77
char 1 10
char 1 0
align 1
LABELV $1344
char 1 69
char 1 86
char 1 95
char 1 71
char 1 82
char 1 69
char 1 78
char 1 65
char 1 68
char 1 69
char 1 95
char 1 66
char 1 79
char 1 85
char 1 78
char 1 67
char 1 69
char 1 10
char 1 0
align 1
LABELV $1336
char 1 69
char 1 86
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 82
char 1 69
char 1 83
char 1 80
char 1 65
char 1 87
char 1 78
char 1 10
char 1 0
align 1
LABELV $1329
char 1 69
char 1 86
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 80
char 1 79
char 1 80
char 1 10
char 1 0
align 1
LABELV $1312
char 1 69
char 1 86
char 1 95
char 1 80
char 1 76
char 1 65
char 1 89
char 1 69
char 1 82
char 1 95
char 1 84
char 1 69
char 1 76
char 1 69
char 1 80
char 1 79
char 1 82
char 1 84
char 1 95
char 1 79
char 1 85
char 1 84
char 1 10
char 1 0
align 1
LABELV $1307
char 1 109
char 1 112
char 1 47
char 1 115
char 1 112
char 1 97
char 1 119
char 1 110
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1294
char 1 69
char 1 86
char 1 95
char 1 80
char 1 76
char 1 65
char 1 89
char 1 69
char 1 82
char 1 95
char 1 84
char 1 69
char 1 76
char 1 69
char 1 80
char 1 79
char 1 82
char 1 84
char 1 95
char 1 73
char 1 78
char 1 10
char 1 0
align 1
LABELV $1285
char 1 83
char 1 69
char 1 69
char 1 75
char 1 69
char 1 82
char 1 95
char 1 65
char 1 76
char 1 82
char 1 69
char 1 65
char 1 68
char 1 89
char 1 68
char 1 69
char 1 80
char 1 76
char 1 79
char 1 89
char 1 69
char 1 68
char 1 0
align 1
LABELV $1283
char 1 83
char 1 72
char 1 73
char 1 69
char 1 76
char 1 68
char 1 95
char 1 78
char 1 79
char 1 82
char 1 79
char 1 79
char 1 77
char 1 0
align 1
LABELV $1281
char 1 83
char 1 69
char 1 78
char 1 84
char 1 82
char 1 89
char 1 95
char 1 65
char 1 76
char 1 82
char 1 69
char 1 65
char 1 68
char 1 89
char 1 80
char 1 76
char 1 65
char 1 67
char 1 69
char 1 68
char 1 0
align 1
LABELV $1279
char 1 83
char 1 69
char 1 78
char 1 84
char 1 82
char 1 89
char 1 95
char 1 78
char 1 79
char 1 82
char 1 79
char 1 79
char 1 77
char 1 0
align 1
LABELV $1271
char 1 69
char 1 86
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 85
char 1 83
char 1 69
char 1 70
char 1 65
char 1 73
char 1 76
char 1 10
char 1 0
align 1
LABELV $1266
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 49
char 1 52
char 1 10
char 1 0
align 1
LABELV $1261
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 49
char 1 51
char 1 10
char 1 0
align 1
LABELV $1256
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 49
char 1 50
char 1 10
char 1 0
align 1
LABELV $1251
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 49
char 1 49
char 1 10
char 1 0
align 1
LABELV $1246
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 49
char 1 48
char 1 10
char 1 0
align 1
LABELV $1241
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 57
char 1 10
char 1 0
align 1
LABELV $1236
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 56
char 1 10
char 1 0
align 1
LABELV $1231
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 55
char 1 10
char 1 0
align 1
LABELV $1226
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 54
char 1 10
char 1 0
align 1
LABELV $1221
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 53
char 1 10
char 1 0
align 1
LABELV $1216
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 52
char 1 10
char 1 0
align 1
LABELV $1211
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 51
char 1 10
char 1 0
align 1
LABELV $1206
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 50
char 1 10
char 1 0
align 1
LABELV $1201
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 49
char 1 10
char 1 0
align 1
LABELV $1196
char 1 69
char 1 86
char 1 95
char 1 85
char 1 83
char 1 69
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 48
char 1 10
char 1 0
align 1
LABELV $1186
char 1 69
char 1 86
char 1 95
char 1 83
char 1 67
char 1 82
char 1 69
char 1 69
char 1 78
char 1 83
char 1 72
char 1 65
char 1 75
char 1 69
char 1 10
char 1 0
align 1
LABELV $1164
char 1 69
char 1 86
char 1 95
char 1 84
char 1 69
char 1 65
char 1 77
char 1 95
char 1 80
char 1 79
char 1 87
char 1 69
char 1 82
char 1 10
char 1 0
align 1
LABELV $1155
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
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 47
char 1 103
char 1 114
char 1 105
char 1 112
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $1153
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
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 47
char 1 106
char 1 117
char 1 109
char 1 112
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $1151
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
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 47
char 1 97
char 1 98
char 1 115
char 1 111
char 1 114
char 1 98
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $1149
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
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 47
char 1 97
char 1 98
char 1 115
char 1 111
char 1 114
char 1 98
char 1 104
char 1 105
char 1 116
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $1147
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
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 47
char 1 112
char 1 114
char 1 111
char 1 116
char 1 101
char 1 99
char 1 116
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $1145
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
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 47
char 1 112
char 1 114
char 1 111
char 1 116
char 1 101
char 1 99
char 1 116
char 1 104
char 1 105
char 1 116
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $1140
char 1 69
char 1 86
char 1 95
char 1 80
char 1 82
char 1 69
char 1 68
char 1 69
char 1 70
char 1 83
char 1 79
char 1 85
char 1 78
char 1 68
char 1 10
char 1 0
align 1
LABELV $1135
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
char 1 100
char 1 105
char 1 115
char 1 114
char 1 117
char 1 112
char 1 116
char 1 111
char 1 114
char 1 47
char 1 122
char 1 111
char 1 111
char 1 109
char 1 101
char 1 110
char 1 100
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $1134
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
char 1 100
char 1 105
char 1 115
char 1 114
char 1 117
char 1 112
char 1 116
char 1 111
char 1 114
char 1 47
char 1 122
char 1 111
char 1 111
char 1 109
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
LABELV $1127
char 1 69
char 1 86
char 1 95
char 1 68
char 1 73
char 1 83
char 1 82
char 1 85
char 1 80
char 1 84
char 1 79
char 1 82
char 1 95
char 1 90
char 1 79
char 1 79
char 1 77
char 1 83
char 1 79
char 1 85
char 1 78
char 1 68
char 1 10
char 1 0
align 1
LABELV $1120
char 1 69
char 1 86
char 1 95
char 1 68
char 1 73
char 1 83
char 1 82
char 1 85
char 1 80
char 1 84
char 1 79
char 1 82
char 1 95
char 1 72
char 1 73
char 1 84
char 1 10
char 1 0
align 1
LABELV $1113
char 1 69
char 1 86
char 1 95
char 1 68
char 1 73
char 1 83
char 1 82
char 1 85
char 1 80
char 1 84
char 1 79
char 1 82
char 1 95
char 1 83
char 1 78
char 1 73
char 1 80
char 1 69
char 1 82
char 1 95
char 1 77
char 1 73
char 1 83
char 1 83
char 1 10
char 1 0
align 1
LABELV $1093
char 1 69
char 1 86
char 1 95
char 1 68
char 1 73
char 1 83
char 1 82
char 1 85
char 1 80
char 1 84
char 1 79
char 1 82
char 1 95
char 1 83
char 1 78
char 1 73
char 1 80
char 1 69
char 1 82
char 1 95
char 1 83
char 1 72
char 1 79
char 1 84
char 1 10
char 1 0
align 1
LABELV $1073
char 1 69
char 1 86
char 1 95
char 1 68
char 1 73
char 1 83
char 1 82
char 1 85
char 1 80
char 1 84
char 1 79
char 1 82
char 1 95
char 1 77
char 1 65
char 1 73
char 1 78
char 1 95
char 1 83
char 1 72
char 1 79
char 1 84
char 1 10
char 1 0
align 1
LABELV $1063
char 1 109
char 1 112
char 1 47
char 1 106
char 1 101
char 1 100
char 1 105
char 1 115
char 1 112
char 1 97
char 1 119
char 1 110
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1048
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
LABELV $1047
char 1 69
char 1 86
char 1 95
char 1 83
char 1 65
char 1 66
char 1 69
char 1 82
char 1 95
char 1 85
char 1 78
char 1 72
char 1 79
char 1 76
char 1 83
char 1 84
char 1 69
char 1 82
char 1 10
char 1 0
align 1
LABELV $1042
char 1 98
char 1 108
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 100
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1035
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
char 1 98
char 1 108
char 1 111
char 1 99
char 1 107
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1034
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
char 1 98
char 1 108
char 1 111
char 1 99
char 1 107
char 1 37
char 1 100
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $1026
char 1 69
char 1 86
char 1 95
char 1 83
char 1 65
char 1 66
char 1 69
char 1 82
char 1 95
char 1 66
char 1 76
char 1 79
char 1 67
char 1 75
char 1 10
char 1 0
align 1
LABELV $1021
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
LABELV $1015
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 47
char 1 98
char 1 108
char 1 111
char 1 111
char 1 100
char 1 95
char 1 115
char 1 112
char 1 97
char 1 114
char 1 107
char 1 115
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $1014
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
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $1006
char 1 69
char 1 86
char 1 95
char 1 83
char 1 65
char 1 66
char 1 69
char 1 82
char 1 95
char 1 72
char 1 73
char 1 84
char 1 10
char 1 0
align 1
LABELV $1001
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
char 1 112
char 1 37
char 1 105
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $1000
char 1 69
char 1 86
char 1 95
char 1 83
char 1 65
char 1 66
char 1 69
char 1 82
char 1 95
char 1 65
char 1 84
char 1 84
char 1 65
char 1 67
char 1 75
char 1 10
char 1 0
align 1
LABELV $987
char 1 69
char 1 86
char 1 95
char 1 65
char 1 76
char 1 84
char 1 95
char 1 70
char 1 73
char 1 82
char 1 69
char 1 10
char 1 0
align 1
LABELV $982
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
char 1 47
char 1 109
char 1 117
char 1 122
char 1 122
char 1 108
char 1 101
char 1 95
char 1 102
char 1 108
char 1 97
char 1 115
char 1 104
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $964
char 1 42
char 1 102
char 1 108
char 1 97
char 1 115
char 1 104
char 1 48
char 1 50
char 1 0
align 1
LABELV $961
char 1 42
char 1 102
char 1 108
char 1 97
char 1 115
char 1 104
char 1 48
char 1 49
char 1 0
align 1
LABELV $956
char 1 101
char 1 102
char 1 102
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 98
char 1 108
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 102
char 1 108
char 1 101
char 1 115
char 1 104
char 1 95
char 1 105
char 1 109
char 1 112
char 1 97
char 1 99
char 1 116
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $955
char 1 101
char 1 102
char 1 102
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 98
char 1 108
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 119
char 1 97
char 1 108
char 1 108
char 1 95
char 1 105
char 1 109
char 1 112
char 1 97
char 1 99
char 1 116
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $949
char 1 69
char 1 86
char 1 95
char 1 70
char 1 73
char 1 82
char 1 69
char 1 95
char 1 87
char 1 69
char 1 65
char 1 80
char 1 79
char 1 78
char 1 10
char 1 0
align 1
LABELV $942
char 1 69
char 1 86
char 1 95
char 1 67
char 1 72
char 1 65
char 1 78
char 1 71
char 1 69
char 1 95
char 1 87
char 1 69
char 1 65
char 1 80
char 1 79
char 1 78
char 1 10
char 1 0
align 1
LABELV $928
char 1 69
char 1 86
char 1 95
char 1 78
char 1 79
char 1 65
char 1 77
char 1 77
char 1 79
char 1 10
char 1 0
align 1
LABELV $914
char 1 69
char 1 86
char 1 95
char 1 71
char 1 76
char 1 79
char 1 66
char 1 65
char 1 76
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 80
char 1 73
char 1 67
char 1 75
char 1 85
char 1 80
char 1 10
char 1 0
align 1
LABELV $873
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 0
align 1
LABELV $862
char 1 69
char 1 86
char 1 95
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 80
char 1 73
char 1 67
char 1 75
char 1 85
char 1 80
char 1 10
char 1 0
align 1
LABELV $857
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
LABELV $856
char 1 69
char 1 86
char 1 95
char 1 87
char 1 65
char 1 84
char 1 69
char 1 82
char 1 95
char 1 67
char 1 76
char 1 69
char 1 65
char 1 82
char 1 10
char 1 0
align 1
LABELV $849
char 1 69
char 1 86
char 1 95
char 1 87
char 1 65
char 1 84
char 1 69
char 1 82
char 1 95
char 1 85
char 1 78
char 1 68
char 1 69
char 1 82
char 1 10
char 1 0
align 1
LABELV $842
char 1 69
char 1 86
char 1 95
char 1 87
char 1 65
char 1 84
char 1 69
char 1 82
char 1 95
char 1 76
char 1 69
char 1 65
char 1 86
char 1 69
char 1 10
char 1 0
align 1
LABELV $835
char 1 69
char 1 86
char 1 95
char 1 87
char 1 65
char 1 84
char 1 69
char 1 82
char 1 95
char 1 84
char 1 79
char 1 85
char 1 67
char 1 72
char 1 10
char 1 0
align 1
LABELV $830
char 1 111
char 1 110
char 1 112
char 1 97
char 1 116
char 1 114
char 1 111
char 1 108
char 1 0
align 1
LABELV $829
char 1 69
char 1 86
char 1 95
char 1 84
char 1 65
char 1 85
char 1 78
char 1 84
char 1 95
char 1 80
char 1 65
char 1 84
char 1 82
char 1 79
char 1 76
char 1 10
char 1 0
align 1
LABELV $824
char 1 111
char 1 110
char 1 100
char 1 101
char 1 102
char 1 101
char 1 110
char 1 115
char 1 101
char 1 0
align 1
LABELV $823
char 1 69
char 1 86
char 1 95
char 1 84
char 1 65
char 1 85
char 1 78
char 1 84
char 1 95
char 1 71
char 1 85
char 1 65
char 1 82
char 1 68
char 1 66
char 1 65
char 1 83
char 1 69
char 1 10
char 1 0
align 1
LABELV $818
char 1 111
char 1 110
char 1 103
char 1 101
char 1 116
char 1 102
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $817
char 1 69
char 1 86
char 1 95
char 1 84
char 1 65
char 1 85
char 1 78
char 1 84
char 1 95
char 1 71
char 1 69
char 1 84
char 1 70
char 1 76
char 1 65
char 1 71
char 1 10
char 1 0
align 1
LABELV $812
char 1 102
char 1 111
char 1 108
char 1 108
char 1 111
char 1 119
char 1 109
char 1 101
char 1 0
align 1
LABELV $811
char 1 69
char 1 86
char 1 95
char 1 84
char 1 65
char 1 85
char 1 78
char 1 84
char 1 95
char 1 70
char 1 79
char 1 76
char 1 76
char 1 79
char 1 87
char 1 77
char 1 69
char 1 10
char 1 0
align 1
LABELV $806
char 1 110
char 1 111
char 1 0
align 1
LABELV $805
char 1 69
char 1 86
char 1 95
char 1 84
char 1 65
char 1 85
char 1 78
char 1 84
char 1 95
char 1 78
char 1 79
char 1 10
char 1 0
align 1
LABELV $800
char 1 121
char 1 101
char 1 115
char 1 0
align 1
LABELV $799
char 1 69
char 1 86
char 1 95
char 1 84
char 1 65
char 1 85
char 1 78
char 1 84
char 1 95
char 1 89
char 1 69
char 1 83
char 1 10
char 1 0
align 1
LABELV $794
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
LABELV $793
char 1 69
char 1 86
char 1 95
char 1 84
char 1 65
char 1 85
char 1 78
char 1 84
char 1 10
char 1 0
align 1
LABELV $780
char 1 69
char 1 86
char 1 95
char 1 82
char 1 79
char 1 76
char 1 76
char 1 10
char 1 0
align 1
LABELV $775
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
LABELV $774
char 1 69
char 1 86
char 1 95
char 1 74
char 1 85
char 1 77
char 1 80
char 1 10
char 1 0
align 1
LABELV $769
char 1 109
char 1 117
char 1 115
char 1 105
char 1 99
char 1 47
char 1 109
char 1 112
char 1 47
char 1 100
char 1 117
char 1 101
char 1 108
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $766
char 1 66
char 1 69
char 1 71
char 1 73
char 1 78
char 1 95
char 1 68
char 1 85
char 1 69
char 1 76
char 1 0
align 1
LABELV $765
char 1 83
char 1 86
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 0
align 1
LABELV $757
char 1 69
char 1 86
char 1 95
char 1 80
char 1 82
char 1 73
char 1 86
char 1 65
char 1 84
char 1 69
char 1 95
char 1 68
char 1 85
char 1 69
char 1 76
char 1 10
char 1 0
align 1
LABELV $752
char 1 69
char 1 86
char 1 95
char 1 74
char 1 85
char 1 77
char 1 80
char 1 95
char 1 80
char 1 65
char 1 68
char 1 10
char 1 0
align 1
LABELV $722
char 1 69
char 1 86
char 1 95
char 1 83
char 1 84
char 1 69
char 1 80
char 1 10
char 1 0
align 1
LABELV $713
char 1 69
char 1 86
char 1 95
char 1 70
char 1 65
char 1 76
char 1 76
char 1 10
char 1 0
align 1
LABELV $702
char 1 69
char 1 86
char 1 95
char 1 83
char 1 87
char 1 73
char 1 77
char 1 10
char 1 0
align 1
LABELV $691
char 1 69
char 1 86
char 1 95
char 1 70
char 1 79
char 1 79
char 1 84
char 1 87
char 1 65
char 1 68
char 1 69
char 1 10
char 1 0
align 1
LABELV $680
char 1 69
char 1 86
char 1 95
char 1 70
char 1 79
char 1 79
char 1 84
char 1 83
char 1 80
char 1 76
char 1 65
char 1 83
char 1 72
char 1 10
char 1 0
align 1
LABELV $669
char 1 69
char 1 86
char 1 95
char 1 70
char 1 79
char 1 79
char 1 84
char 1 83
char 1 84
char 1 69
char 1 80
char 1 95
char 1 77
char 1 69
char 1 84
char 1 65
char 1 76
char 1 10
char 1 0
align 1
LABELV $659
char 1 69
char 1 86
char 1 95
char 1 70
char 1 79
char 1 79
char 1 84
char 1 83
char 1 84
char 1 69
char 1 80
char 1 10
char 1 0
align 1
LABELV $652
char 1 69
char 1 86
char 1 95
char 1 67
char 1 76
char 1 73
char 1 69
char 1 78
char 1 84
char 1 74
char 1 79
char 1 73
char 1 78
char 1 10
char 1 0
align 1
LABELV $641
char 1 90
char 1 69
char 1 82
char 1 79
char 1 69
char 1 86
char 1 69
char 1 78
char 1 84
char 1 10
char 1 0
align 1
LABELV $635
char 1 101
char 1 110
char 1 116
char 1 58
char 1 37
char 1 51
char 1 105
char 1 32
char 1 32
char 1 101
char 1 118
char 1 101
char 1 110
char 1 116
char 1 58
char 1 37
char 1 51
char 1 105
char 1 32
char 1 0
align 1
LABELV $598
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
LABELV $593
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 47
char 1 109
char 1 111
char 1 118
char 1 101
char 1 114
char 1 115
char 1 47
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 72
char 1 105
char 1 116
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $579
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $569
char 1 37
char 1 115
char 1 32
char 1 0
align 1
LABELV $564
char 1 37
char 1 115
char 1 0
align 1
LABELV $557
char 1 80
char 1 76
char 1 65
char 1 89
char 1 69
char 1 82
char 1 95
char 1 71
char 1 79
char 1 84
char 1 95
char 1 70
char 1 76
char 1 65
char 1 71
char 1 0
align 1
LABELV $555
char 1 80
char 1 76
char 1 65
char 1 89
char 1 69
char 1 82
char 1 95
char 1 67
char 1 65
char 1 80
char 1 84
char 1 85
char 1 82
char 1 69
char 1 68
char 1 95
char 1 70
char 1 76
char 1 65
char 1 71
char 1 0
align 1
LABELV $553
char 1 80
char 1 76
char 1 65
char 1 89
char 1 69
char 1 82
char 1 95
char 1 82
char 1 69
char 1 84
char 1 85
char 1 82
char 1 78
char 1 69
char 1 68
char 1 95
char 1 70
char 1 76
char 1 65
char 1 71
char 1 0
align 1
LABELV $551
char 1 70
char 1 76
char 1 65
char 1 71
char 1 95
char 1 82
char 1 69
char 1 84
char 1 85
char 1 82
char 1 78
char 1 69
char 1 68
char 1 0
align 1
LABELV $549
char 1 70
char 1 82
char 1 65
char 1 71
char 1 71
char 1 69
char 1 68
char 1 95
char 1 70
char 1 76
char 1 65
char 1 71
char 1 95
char 1 67
char 1 65
char 1 82
char 1 82
char 1 73
char 1 69
char 1 82
char 1 0
align 1
LABELV $544
char 1 70
char 1 82
char 1 69
char 1 69
char 1 0
align 1
LABELV $543
char 1 83
char 1 80
char 1 69
char 1 67
char 1 84
char 1 65
char 1 84
char 1 79
char 1 82
char 1 0
align 1
LABELV $540
char 1 66
char 1 76
char 1 85
char 1 69
char 1 0
align 1
LABELV $537
char 1 82
char 1 69
char 1 68
char 1 0
align 1
LABELV $530
char 1 77
char 1 111
char 1 116
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $528
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
LABELV $526
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
LABELV $517
char 1 112
char 1 101
char 1 108
char 1 118
char 1 105
char 1 115
char 1 0
align 1
LABELV $491
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
LABELV $490
char 1 114
char 1 95
char 1 108
char 1 101
char 1 103
char 1 0
align 1
LABELV $488
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
LABELV $487
char 1 108
char 1 95
char 1 108
char 1 101
char 1 103
char 1 0
align 1
LABELV $485
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
LABELV $484
char 1 114
char 1 95
char 1 97
char 1 114
char 1 109
char 1 0
align 1
LABELV $482
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
LABELV $481
char 1 108
char 1 95
char 1 97
char 1 114
char 1 109
char 1 0
align 1
LABELV $479
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
LABELV $478
char 1 116
char 1 111
char 1 114
char 1 115
char 1 111
char 1 0
align 1
LABELV $476
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
LABELV $475
char 1 104
char 1 101
char 1 97
char 1 100
char 1 0
align 1
LABELV $468
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
LABELV $467
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
LABELV $464
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
LABELV $461
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
LABELV $454
char 1 80
char 1 73
char 1 67
char 1 75
char 1 85
char 1 80
char 1 76
char 1 73
char 1 78
char 1 69
char 1 0
align 1
LABELV $453
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
LABELV $336
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $330
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 70
char 1 79
char 1 82
char 1 67
char 1 69
char 1 84
char 1 79
char 1 83
char 1 83
char 1 0
align 1
LABELV $328
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 71
char 1 69
char 1 78
char 1 69
char 1 82
char 1 73
char 1 67
char 1 0
align 1
LABELV $326
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 84
char 1 69
char 1 76
char 1 69
char 1 70
char 1 82
char 1 65
char 1 71
char 1 0
align 1
LABELV $324
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 83
char 1 69
char 1 78
char 1 84
char 1 82
char 1 89
char 1 0
align 1
LABELV $322
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 68
char 1 65
char 1 82
char 1 75
char 1 70
char 1 79
char 1 82
char 1 67
char 1 69
char 1 0
align 1
LABELV $320
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 68
char 1 69
char 1 84
char 1 80
char 1 65
char 1 67
char 1 75
char 1 0
align 1
LABELV $318
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 84
char 1 82
char 1 73
char 1 80
char 1 77
char 1 73
char 1 78
char 1 69
char 1 95
char 1 84
char 1 73
char 1 77
char 1 69
char 1 68
char 1 0
align 1
LABELV $316
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 84
char 1 82
char 1 73
char 1 80
char 1 77
char 1 73
char 1 78
char 1 69
char 1 0
align 1
LABELV $314
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 84
char 1 72
char 1 69
char 1 82
char 1 77
char 1 65
char 1 76
char 1 0
align 1
LABELV $312
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 82
char 1 79
char 1 67
char 1 75
char 1 69
char 1 84
char 1 95
char 1 72
char 1 79
char 1 77
char 1 73
char 1 78
char 1 71
char 1 0
align 1
LABELV $310
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 82
char 1 79
char 1 67
char 1 75
char 1 69
char 1 84
char 1 0
align 1
LABELV $308
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 70
char 1 76
char 1 69
char 1 67
char 1 72
char 1 69
char 1 84
char 1 84
char 1 69
char 1 95
char 1 77
char 1 73
char 1 78
char 1 69
char 1 0
align 1
LABELV $306
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 70
char 1 76
char 1 69
char 1 67
char 1 72
char 1 69
char 1 84
char 1 84
char 1 69
char 1 0
align 1
LABELV $304
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 68
char 1 69
char 1 77
char 1 80
char 1 50
char 1 0
align 1
LABELV $302
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 82
char 1 69
char 1 80
char 1 69
char 1 65
char 1 84
char 1 69
char 1 82
char 1 65
char 1 76
char 1 84
char 1 0
align 1
LABELV $300
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 82
char 1 69
char 1 80
char 1 69
char 1 65
char 1 84
char 1 69
char 1 82
char 1 0
align 1
LABELV $298
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 66
char 1 79
char 1 87
char 1 67
char 1 65
char 1 83
char 1 84
char 1 69
char 1 82
char 1 0
align 1
LABELV $296
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 68
char 1 73
char 1 83
char 1 82
char 1 85
char 1 80
char 1 84
char 1 79
char 1 82
char 1 83
char 1 78
char 1 73
char 1 80
char 1 69
char 1 0
align 1
LABELV $294
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 68
char 1 73
char 1 83
char 1 82
char 1 85
char 1 80
char 1 84
char 1 79
char 1 82
char 1 0
align 1
LABELV $292
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 66
char 1 76
char 1 65
char 1 83
char 1 84
char 1 69
char 1 82
char 1 0
align 1
LABELV $290
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 66
char 1 82
char 1 89
char 1 65
char 1 82
char 1 0
align 1
LABELV $288
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 83
char 1 65
char 1 66
char 1 69
char 1 82
char 1 0
align 1
LABELV $286
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 77
char 1 69
char 1 76
char 1 69
char 1 69
char 1 0
align 1
LABELV $284
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 83
char 1 84
char 1 85
char 1 78
char 1 0
align 1
LABELV $273
char 1 110
char 1 111
char 1 110
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $265
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $262
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 46
char 1 10
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 32
char 1 37
char 1 105
char 1 46
char 1 0
align 1
LABELV $261
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 95
char 1 80
char 1 76
char 1 65
char 1 67
char 1 69
char 1 95
char 1 87
char 1 73
char 1 84
char 1 72
char 1 0
align 1
LABELV $256
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 10
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $255
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 95
char 1 74
char 1 77
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 78
char 1 79
char 1 84
char 1 74
char 1 77
char 1 0
align 1
LABELV $254
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 95
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 95
char 1 77
char 1 69
char 1 83
char 1 83
char 1 65
char 1 71
char 1 69
char 1 0
align 1
LABELV $242
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $241
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 0
align 1
LABELV $227
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 71
char 1 69
char 1 78
char 1 69
char 1 82
char 1 73
char 1 67
char 1 68
char 1 69
char 1 65
char 1 84
char 1 72
char 1 95
char 1 77
char 1 65
char 1 76
char 1 69
char 1 0
align 1
LABELV $226
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 71
char 1 69
char 1 78
char 1 69
char 1 82
char 1 73
char 1 67
char 1 68
char 1 69
char 1 65
char 1 84
char 1 72
char 1 95
char 1 71
char 1 69
char 1 78
char 1 68
char 1 69
char 1 82
char 1 76
char 1 69
char 1 83
char 1 83
char 1 0
align 1
LABELV $223
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 71
char 1 69
char 1 78
char 1 69
char 1 82
char 1 73
char 1 67
char 1 68
char 1 69
char 1 65
char 1 84
char 1 72
char 1 95
char 1 70
char 1 69
char 1 77
char 1 65
char 1 76
char 1 69
char 1 0
align 1
LABELV $220
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 70
char 1 65
char 1 76
char 1 76
char 1 68
char 1 69
char 1 65
char 1 84
char 1 72
char 1 95
char 1 77
char 1 65
char 1 76
char 1 69
char 1 0
align 1
LABELV $219
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 70
char 1 65
char 1 76
char 1 76
char 1 68
char 1 69
char 1 65
char 1 84
char 1 72
char 1 95
char 1 71
char 1 69
char 1 78
char 1 68
char 1 69
char 1 82
char 1 76
char 1 69
char 1 83
char 1 83
char 1 0
align 1
LABELV $216
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 70
char 1 65
char 1 76
char 1 76
char 1 68
char 1 69
char 1 65
char 1 84
char 1 72
char 1 95
char 1 70
char 1 69
char 1 77
char 1 65
char 1 76
char 1 69
char 1 0
align 1
LABELV $212
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 69
char 1 76
char 1 69
char 1 67
char 1 84
char 1 82
char 1 79
char 1 67
char 1 85
char 1 84
char 1 69
char 1 68
char 1 95
char 1 77
char 1 65
char 1 76
char 1 69
char 1 0
align 1
LABELV $211
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 69
char 1 76
char 1 69
char 1 67
char 1 84
char 1 82
char 1 79
char 1 67
char 1 85
char 1 84
char 1 69
char 1 68
char 1 95
char 1 71
char 1 69
char 1 78
char 1 68
char 1 69
char 1 82
char 1 76
char 1 69
char 1 83
char 1 83
char 1 0
align 1
LABELV $208
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 69
char 1 76
char 1 69
char 1 67
char 1 84
char 1 82
char 1 79
char 1 67
char 1 85
char 1 84
char 1 69
char 1 68
char 1 95
char 1 70
char 1 69
char 1 77
char 1 65
char 1 76
char 1 69
char 1 0
align 1
LABELV $204
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 69
char 1 88
char 1 80
char 1 76
char 1 79
char 1 83
char 1 73
char 1 86
char 1 69
char 1 83
char 1 95
char 1 77
char 1 65
char 1 76
char 1 69
char 1 0
align 1
LABELV $203
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 69
char 1 88
char 1 80
char 1 76
char 1 79
char 1 83
char 1 73
char 1 86
char 1 69
char 1 83
char 1 95
char 1 71
char 1 69
char 1 78
char 1 68
char 1 69
char 1 82
char 1 76
char 1 69
char 1 83
char 1 83
char 1 0
align 1
LABELV $200
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 69
char 1 88
char 1 80
char 1 76
char 1 79
char 1 83
char 1 73
char 1 86
char 1 69
char 1 83
char 1 95
char 1 70
char 1 69
char 1 77
char 1 65
char 1 76
char 1 69
char 1 0
align 1
LABELV $196
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 83
char 1 72
char 1 79
char 1 84
char 1 95
char 1 77
char 1 65
char 1 76
char 1 69
char 1 0
align 1
LABELV $195
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 83
char 1 72
char 1 79
char 1 84
char 1 95
char 1 71
char 1 69
char 1 78
char 1 68
char 1 69
char 1 82
char 1 76
char 1 69
char 1 83
char 1 83
char 1 0
align 1
LABELV $192
char 1 83
char 1 85
char 1 73
char 1 67
char 1 73
char 1 68
char 1 69
char 1 95
char 1 83
char 1 72
char 1 79
char 1 84
char 1 95
char 1 70
char 1 69
char 1 77
char 1 65
char 1 76
char 1 69
char 1 0
align 1
LABELV $182
char 1 68
char 1 73
char 1 69
char 1 68
char 1 95
char 1 71
char 1 69
char 1 78
char 1 69
char 1 82
char 1 73
char 1 67
char 1 0
align 1
LABELV $178
char 1 94
char 1 55
char 1 0
align 1
LABELV $177
char 1 110
char 1 0
align 1
LABELV $170
char 1 67
char 1 71
char 1 95
char 1 79
char 1 98
char 1 105
char 1 116
char 1 117
char 1 97
char 1 114
char 1 121
char 1 58
char 1 32
char 1 116
char 1 97
char 1 114
char 1 103
char 1 101
char 1 116
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
char 1 0
align 1
LABELV $165
char 1 37
char 1 115
char 1 37
char 1 115
char 1 0
align 1
LABELV $160
char 1 37
char 1 105
char 1 37
char 1 115
char 1 0
align 1
LABELV $157
char 1 49
char 1 51
char 1 37
char 1 115
char 1 0
align 1
LABELV $154
char 1 49
char 1 50
char 1 37
char 1 115
char 1 0
align 1
LABELV $151
char 1 49
char 1 49
char 1 37
char 1 115
char 1 0
align 1
LABELV $148
char 1 51
char 1 37
char 1 115
char 1 0
align 1
LABELV $145
char 1 50
char 1 37
char 1 115
char 1 0
align 1
LABELV $142
char 1 49
char 1 37
char 1 115
char 1 0
align 1
LABELV $139
char 1 0
align 1
LABELV $136
char 1 32
char 1 0
align 1
LABELV $135
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 95
char 1 84
char 1 73
char 1 69
char 1 68
char 1 95
char 1 70
char 1 79
char 1 82
char 1 0
align 1
LABELV $134
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 95
char 1 78
char 1 85
char 1 77
char 1 66
char 1 69
char 1 82
char 1 95
char 1 84
char 1 72
char 1 0
align 1
LABELV $133
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 95
char 1 78
char 1 85
char 1 77
char 1 66
char 1 69
char 1 82
char 1 95
char 1 82
char 1 68
char 1 0
align 1
LABELV $132
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 95
char 1 78
char 1 85
char 1 77
char 1 66
char 1 69
char 1 82
char 1 95
char 1 78
char 1 68
char 1 0
align 1
LABELV $131
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 95
char 1 78
char 1 85
char 1 77
char 1 66
char 1 69
char 1 82
char 1 95
char 1 83
char 1 84
char 1 0
