data
export drawTeamOverlayModificationCount
align 4
LABELV drawTeamOverlayModificationCount
byte 4 -1
export CG_InitTeamChat
code
proc CG_InitTeamChat 0 12
file "../cg_newDraw.c"
line 17
;1:#include "cg_local.h"
;2:#include "../ui/ui_shared.h"
;3:
;4:extern displayContextDef_t cgDC;
;5:
;6:
;7:// set in CG_ParseTeamInfo
;8:
;9://static int sortedTeamPlayers[TEAM_MAXOVERLAY];
;10://static int numSortedTeamPlayers;
;11:int drawTeamOverlayModificationCount = -1;
;12:
;13://static char systemChat[256];
;14://static char teamChat1[256];
;15://static char teamChat2[256];
;16:
;17:void CG_InitTeamChat(void) {
line 18
;18:  memset(teamChat1, 0, sizeof(teamChat1));
ADDRGP4 teamChat1
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 19
;19:  memset(teamChat2, 0, sizeof(teamChat2));
ADDRGP4 teamChat2
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 20
;20:  memset(systemChat, 0, sizeof(systemChat));
ADDRGP4 systemChat
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 21
;21:}
LABELV $129
endproc CG_InitTeamChat 0 12
export CG_SetPrintString
proc CG_SetPrintString 0 8
line 23
;22:
;23:void CG_SetPrintString(int type, const char *p) {
line 24
;24:  if (type == SYSTEM_PRINT) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $131
line 25
;25:    strcpy(systemChat, p);
ADDRGP4 systemChat
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 26
;26:  } else {
ADDRGP4 $132
JUMPV
LABELV $131
line 27
;27:    strcpy(teamChat2, teamChat1);
ADDRGP4 teamChat2
ARGP4
ADDRGP4 teamChat1
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 28
;28:    strcpy(teamChat1, p);
ADDRGP4 teamChat1
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 29
;29:  }
LABELV $132
line 30
;30:}
LABELV $130
endproc CG_SetPrintString 0 8
export CG_CheckOrderPending
proc CG_CheckOrderPending 28 12
line 32
;31:
;32:void CG_CheckOrderPending(void) {
line 33
;33:	if (cgs.gametype < GT_CTF) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
GEI4 $134
line 34
;34:		return;
ADDRGP4 $133
JUMPV
LABELV $134
line 36
;35:	}
;36:	if (cgs.orderPending) {
ADDRGP4 cgs+70224
INDIRI4
CNSTI4 0
EQI4 $137
line 39
;37:		//clientInfo_t *ci = cgs.clientinfo + sortedTeamPlayers[cg_currentSelectedPlayer.integer];
;38:		const char *p1, *p2, *b;
;39:		p1 = p2 = b = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 40
;40:		switch (cgs.currentOrder) {
ADDRLP4 16
ADDRGP4 cgs+70220
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $140
ADDRLP4 16
INDIRI4
CNSTI4 7
GTI4 $140
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $168-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $168
address $143
address $147
address $151
address $155
address $162
address $165
address $159
code
LABELV $143
line 42
;41:			case TEAMTASK_OFFENSE:
;42:				p1 = VOICECHAT_ONOFFENSE;
ADDRLP4 8
ADDRGP4 $144
ASGNP4
line 43
;43:				p2 = VOICECHAT_OFFENSE;
ADDRLP4 4
ADDRGP4 $145
ASGNP4
line 44
;44:				b = "+button7; wait; -button7";
ADDRLP4 0
ADDRGP4 $146
ASGNP4
line 45
;45:			break;
ADDRGP4 $141
JUMPV
LABELV $147
line 47
;46:			case TEAMTASK_DEFENSE:
;47:				p1 = VOICECHAT_ONDEFENSE;
ADDRLP4 8
ADDRGP4 $148
ASGNP4
line 48
;48:				p2 = VOICECHAT_DEFEND;
ADDRLP4 4
ADDRGP4 $149
ASGNP4
line 49
;49:				b = "+button8; wait; -button8";
ADDRLP4 0
ADDRGP4 $150
ASGNP4
line 50
;50:			break;					
ADDRGP4 $141
JUMPV
LABELV $151
line 52
;51:			case TEAMTASK_PATROL:
;52:				p1 = VOICECHAT_ONPATROL;
ADDRLP4 8
ADDRGP4 $152
ASGNP4
line 53
;53:				p2 = VOICECHAT_PATROL;
ADDRLP4 4
ADDRGP4 $153
ASGNP4
line 54
;54:				b = "+button9; wait; -button9";
ADDRLP4 0
ADDRGP4 $154
ASGNP4
line 55
;55:			break;
ADDRGP4 $141
JUMPV
LABELV $155
line 57
;56:			case TEAMTASK_FOLLOW: 
;57:				p1 = VOICECHAT_ONFOLLOW;
ADDRLP4 8
ADDRGP4 $156
ASGNP4
line 58
;58:				p2 = VOICECHAT_FOLLOWME;
ADDRLP4 4
ADDRGP4 $157
ASGNP4
line 59
;59:				b = "+button10; wait; -button10";
ADDRLP4 0
ADDRGP4 $158
ASGNP4
line 60
;60:			break;
ADDRGP4 $141
JUMPV
LABELV $159
line 62
;61:			case TEAMTASK_CAMP:
;62:				p1 = VOICECHAT_ONCAMPING;
ADDRLP4 8
ADDRGP4 $160
ASGNP4
line 63
;63:				p2 = VOICECHAT_CAMP;
ADDRLP4 4
ADDRGP4 $161
ASGNP4
line 64
;64:			break;
ADDRGP4 $141
JUMPV
LABELV $162
line 66
;65:			case TEAMTASK_RETRIEVE:
;66:				p1 = VOICECHAT_ONGETFLAG;
ADDRLP4 8
ADDRGP4 $163
ASGNP4
line 67
;67:				p2 = VOICECHAT_RETURNFLAG;
ADDRLP4 4
ADDRGP4 $164
ASGNP4
line 68
;68:			break;
ADDRGP4 $141
JUMPV
LABELV $165
line 70
;69:			case TEAMTASK_ESCORT:
;70:				p1 = VOICECHAT_ONFOLLOWCARRIER;
ADDRLP4 8
ADDRGP4 $166
ASGNP4
line 71
;71:				p2 = VOICECHAT_FOLLOWFLAGCARRIER;
ADDRLP4 4
ADDRGP4 $167
ASGNP4
line 72
;72:			break;
LABELV $140
LABELV $141
line 75
;73:		}
;74:
;75:		if (cg_currentSelectedPlayer.integer == numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
NEI4 $170
line 77
;76:			// to everyone
;77:			trap_SendConsoleCommand(va("cmd vsay_team %s\n", p2));
ADDRGP4 $173
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 78
;78:		} else {
ADDRGP4 $171
JUMPV
LABELV $170
line 80
;79:			// for the player self
;80:			if (sortedTeamPlayers[cg_currentSelectedPlayer.integer] == cg.snap->ps.clientNum && p1) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $174
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $174
line 81
;81:				trap_SendConsoleCommand(va("teamtask %i\n", cgs.currentOrder));
ADDRGP4 $178
ARGP4
ADDRGP4 cgs+70220
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 83
;82:				//trap_SendConsoleCommand(va("cmd say_team %s\n", p2));
;83:				trap_SendConsoleCommand(va("cmd vsay_team %s\n", p1));
ADDRGP4 $173
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 84
;84:			} else if (p2) {
ADDRGP4 $175
JUMPV
LABELV $174
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $180
line 86
;85:				//trap_SendConsoleCommand(va("cmd say_team %s, %s\n", ci->name,p));
;86:				trap_SendConsoleCommand(va("cmd vtell %d %s\n", sortedTeamPlayers[cg_currentSelectedPlayer.integer], p2));
ADDRGP4 $182
ARGP4
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 87
;87:			}
LABELV $180
LABELV $175
line 88
;88:		}
LABELV $171
line 89
;89:		if (b) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $184
line 90
;90:			trap_SendConsoleCommand(b);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 91
;91:		}
LABELV $184
line 92
;92:		cgs.orderPending = qfalse;
ADDRGP4 cgs+70224
CNSTI4 0
ASGNI4
line 93
;93:	}
LABELV $137
line 94
;94:}
LABELV $133
endproc CG_CheckOrderPending 28 12
proc CG_SetSelectedPlayerName 8 8
line 96
;95:
;96:static void CG_SetSelectedPlayerName() {
line 97
;97:  if (cg_currentSelectedPlayer.integer >= 0 && cg_currentSelectedPlayer.integer < numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 0
LTI4 $188
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
GEI4 $188
line 98
;98:		clientInfo_t *ci = cgs.clientinfo + sortedTeamPlayers[cg_currentSelectedPlayer.integer];
ADDRLP4 0
CNSTI4 788
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 99
;99:	  if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $189
line 100
;100:			trap_Cvar_Set("cg_selectedPlayerName", ci->name);
ADDRGP4 $196
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 101
;101:			trap_Cvar_Set("cg_selectedPlayer", va("%d", sortedTeamPlayers[cg_currentSelectedPlayer.integer]));
ADDRGP4 $198
ARGP4
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $197
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 102
;102:			cgs.currentOrder = ci->teamTask;
ADDRGP4 cgs+70220
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 103
;103:	  }
line 104
;104:	} else {
ADDRGP4 $189
JUMPV
LABELV $188
line 105
;105:		trap_Cvar_Set("cg_selectedPlayerName", "Everyone");
ADDRGP4 $196
ARGP4
ADDRGP4 $201
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 106
;106:	}
LABELV $189
line 107
;107:}
LABELV $187
endproc CG_SetSelectedPlayerName 8 8
export CG_GetSelectedPlayer
proc CG_GetSelectedPlayer 0 0
line 108
;108:int CG_GetSelectedPlayer() {
line 109
;109:	if (cg_currentSelectedPlayer.integer < 0 || cg_currentSelectedPlayer.integer >= numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 0
LTI4 $207
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
LTI4 $203
LABELV $207
line 110
;110:		cg_currentSelectedPlayer.integer = 0;
ADDRGP4 cg_currentSelectedPlayer+12
CNSTI4 0
ASGNI4
line 111
;111:	}
LABELV $203
line 112
;112:	return cg_currentSelectedPlayer.integer;
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
RETI4
LABELV $202
endproc CG_GetSelectedPlayer 0 0
export CG_SelectNextPlayer
proc CG_SelectNextPlayer 4 0
line 115
;113:}
;114:
;115:void CG_SelectNextPlayer(void) {
line 116
;116:	CG_CheckOrderPending();
ADDRGP4 CG_CheckOrderPending
CALLV
pop
line 117
;117:	if (cg_currentSelectedPlayer.integer >= 0 && cg_currentSelectedPlayer.integer < numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 0
LTI4 $211
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
GEI4 $211
line 118
;118:		cg_currentSelectedPlayer.integer++;
ADDRLP4 0
ADDRGP4 cg_currentSelectedPlayer+12
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 119
;119:	} else {
ADDRGP4 $212
JUMPV
LABELV $211
line 120
;120:		cg_currentSelectedPlayer.integer = 0;
ADDRGP4 cg_currentSelectedPlayer+12
CNSTI4 0
ASGNI4
line 121
;121:	}
LABELV $212
line 122
;122:	CG_SetSelectedPlayerName();
ADDRGP4 CG_SetSelectedPlayerName
CALLV
pop
line 123
;123:}
LABELV $210
endproc CG_SelectNextPlayer 4 0
export CG_SelectPrevPlayer
proc CG_SelectPrevPlayer 4 0
line 125
;124:
;125:void CG_SelectPrevPlayer(void) {
line 126
;126:	CG_CheckOrderPending();
ADDRGP4 CG_CheckOrderPending
CALLV
pop
line 127
;127:	if (cg_currentSelectedPlayer.integer > 0 && cg_currentSelectedPlayer.integer < numSortedTeamPlayers) {
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 0
LEI4 $218
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
GEI4 $218
line 128
;128:		cg_currentSelectedPlayer.integer--;
ADDRLP4 0
ADDRGP4 cg_currentSelectedPlayer+12
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 129
;129:	} else {
ADDRGP4 $219
JUMPV
LABELV $218
line 130
;130:		cg_currentSelectedPlayer.integer = numSortedTeamPlayers;
ADDRGP4 cg_currentSelectedPlayer+12
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
line 131
;131:	}
LABELV $219
line 132
;132:	CG_SetSelectedPlayerName();
ADDRGP4 CG_SetSelectedPlayerName
CALLV
pop
line 133
;133:}
LABELV $217
endproc CG_SelectPrevPlayer 4 0
export CG_StatusHandle
proc CG_StatusHandle 8 0
line 136
;134:
;135:
;136:qhandle_t CG_StatusHandle(int task) {
line 137
;137:	qhandle_t h = cgs.media.assaultShader;
ADDRLP4 0
ADDRGP4 cgs+70280+872
INDIRI4
ASGNI4
line 138
;138:	switch (task) {
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $227
ADDRLP4 4
INDIRI4
CNSTI4 7
GTI4 $227
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $252-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $252
address $229
address $232
address $235
address $238
address $244
address $247
address $241
code
LABELV $229
line 140
;139:		case TEAMTASK_OFFENSE :
;140:			h = cgs.media.assaultShader;
ADDRLP4 0
ADDRGP4 cgs+70280+872
INDIRI4
ASGNI4
line 141
;141:			break;
ADDRGP4 $228
JUMPV
LABELV $232
line 143
;142:		case TEAMTASK_DEFENSE :
;143:			h = cgs.media.defendShader;
ADDRLP4 0
ADDRGP4 cgs+70280+884
INDIRI4
ASGNI4
line 144
;144:			break;
ADDRGP4 $228
JUMPV
LABELV $235
line 146
;145:		case TEAMTASK_PATROL :
;146:			h = cgs.media.patrolShader;
ADDRLP4 0
ADDRGP4 cgs+70280+868
INDIRI4
ASGNI4
line 147
;147:			break;
ADDRGP4 $228
JUMPV
LABELV $238
line 149
;148:		case TEAMTASK_FOLLOW :
;149:			h = cgs.media.followShader;
ADDRLP4 0
ADDRGP4 cgs+70280+880
INDIRI4
ASGNI4
line 150
;150:			break;
ADDRGP4 $228
JUMPV
LABELV $241
line 152
;151:		case TEAMTASK_CAMP :
;152:			h = cgs.media.campShader;
ADDRLP4 0
ADDRGP4 cgs+70280+876
INDIRI4
ASGNI4
line 153
;153:			break;
ADDRGP4 $228
JUMPV
LABELV $244
line 155
;154:		case TEAMTASK_RETRIEVE :
;155:			h = cgs.media.retrieveShader; 
ADDRLP4 0
ADDRGP4 cgs+70280+892
INDIRI4
ASGNI4
line 156
;156:			break;
ADDRGP4 $228
JUMPV
LABELV $247
line 158
;157:		case TEAMTASK_ESCORT :
;158:			h = cgs.media.escortShader; 
ADDRLP4 0
ADDRGP4 cgs+70280+896
INDIRI4
ASGNI4
line 159
;159:			break;
ADDRGP4 $228
JUMPV
LABELV $227
line 161
;160:		default : 
;161:			h = cgs.media.assaultShader;
ADDRLP4 0
ADDRGP4 cgs+70280+872
INDIRI4
ASGNI4
line 162
;162:			break;
LABELV $228
line 164
;163:	}
;164:	return h;
ADDRLP4 0
INDIRI4
RETI4
LABELV $224
endproc CG_StatusHandle 8 0
export CG_GetValue
proc CG_GetValue 44 0
line 168
;165:}
;166:
;167:
;168:float CG_GetValue(int ownerDraw) {
line 173
;169:	centity_t	*cent;
;170: 	clientInfo_t *ci;
;171:	playerState_t	*ps;
;172:
;173:  cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 4
CNSTI4 1920
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 174
;174:	ps = &cg.snap->ps;
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 176
;175:
;176:  switch (ownerDraw) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 27
EQI4 $272
ADDRLP4 16
CNSTI4 28
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $270
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
GTI4 $276
LABELV $275
ADDRLP4 20
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 2
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $263
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $269
ADDRLP4 20
INDIRI4
CNSTI4 6
EQI4 $264
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $258
LABELV $277
ADDRFP4 0
INDIRI4
CNSTI4 20
EQI4 $267
ADDRGP4 $258
JUMPV
LABELV $276
ADDRLP4 28
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 32
CNSTI4 40
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $259
ADDRLP4 28
INDIRI4
CNSTI4 41
EQI4 $261
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $258
LABELV $278
ADDRFP4 0
INDIRI4
CNSTI4 70
EQI4 $274
ADDRGP4 $258
JUMPV
LABELV $259
line 178
;177:  case CG_SELECTEDPLAYER_ARMOR:
;178:    ci = cgs.clientinfo + sortedTeamPlayers[CG_GetSelectedPlayer()];
ADDRLP4 36
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 8
CNSTI4 788
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 179
;179:    return ci->armor;
ADDRLP4 8
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $254
JUMPV
line 180
;180:    break;
LABELV $261
line 182
;181:  case CG_SELECTEDPLAYER_HEALTH:
;182:    ci = cgs.clientinfo + sortedTeamPlayers[CG_GetSelectedPlayer()];
ADDRLP4 40
ADDRGP4 CG_GetSelectedPlayer
CALLI4
ASGNI4
ADDRLP4 8
CNSTI4 788
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 183
;183:    return ci->health;
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $254
JUMPV
line 184
;184:    break;
LABELV $263
line 186
;185:  case CG_PLAYER_ARMOR_VALUE:
;186:		return ps->stats[STAT_ARMOR];
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $254
JUMPV
line 187
;187:    break;
LABELV $264
line 189
;188:  case CG_PLAYER_AMMO_VALUE:
;189:		if ( cent->currentState.weapon ) 
ADDRLP4 4
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
EQI4 $258
line 190
;190:		{
line 191
;191:			return ps->ammo[weaponData[cent->currentState.weapon].ammoIndex];
CNSTI4 56
ADDRLP4 4
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
MULI4
ADDRGP4 weaponData
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $254
JUMPV
line 193
;192:		}
;193:    break;
LABELV $267
line 195
;194:  case CG_PLAYER_SCORE:
;195:	  return cg.snap->ps.persistant[PERS_SCORE];
ADDRGP4 cg+36
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $254
JUMPV
line 196
;196:    break;
LABELV $269
line 198
;197:  case CG_PLAYER_HEALTH:
;198:		return ps->stats[STAT_HEALTH];
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $254
JUMPV
line 199
;199:    break;
LABELV $270
line 201
;200:  case CG_RED_SCORE:
;201:		return cgs.scores1;
ADDRGP4 cgs+36308
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $254
JUMPV
line 202
;202:    break;
LABELV $272
line 204
;203:  case CG_BLUE_SCORE:
;204:		return cgs.scores2;
ADDRGP4 cgs+36312
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $254
JUMPV
line 205
;205:    break;
LABELV $274
line 207
;206:  case CG_PLAYER_FORCE_VALUE:
;207:		return ps->fd.forcePower;
ADDRLP4 0
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $254
JUMPV
line 208
;208:    break;
line 210
;209:  default:
;210:    break;
LABELV $258
line 212
;211:  }
;212:	return -1;
CNSTF4 3212836864
RETF4
LABELV $254
endproc CG_GetValue 44 0
export CG_OtherTeamHasFlag
proc CG_OtherTeamHasFlag 8 0
line 215
;213:}
;214:
;215:qboolean CG_OtherTeamHasFlag(void) {
line 216
;216:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_CTY) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
EQI4 $284
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $280
LABELV $284
line 217
;217:		int team = cg.snap->ps.persistant[PERS_TEAM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
ASGNI4
line 218
;218:		if (team == TEAM_RED && cgs.redflag == FLAG_TAKEN) {
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $286
ADDRGP4 cgs+36332
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $286
line 219
;219:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $279
JUMPV
LABELV $286
line 220
;220:		} else if (team == TEAM_BLUE && cgs.blueflag == FLAG_TAKEN) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $289
ADDRGP4 cgs+36336
INDIRI4
CNSTI4 1
NEI4 $289
line 221
;221:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $279
JUMPV
LABELV $289
line 222
;222:		} else {
line 223
;223:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $279
JUMPV
LABELV $280
line 226
;224:		}
;225:	}
;226:	return qfalse;
CNSTI4 0
RETI4
LABELV $279
endproc CG_OtherTeamHasFlag 8 0
export CG_YourTeamHasFlag
proc CG_YourTeamHasFlag 8 0
line 229
;227:}
;228:
;229:qboolean CG_YourTeamHasFlag(void) {
line 230
;230:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_CTY) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
EQI4 $297
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $293
LABELV $297
line 231
;231:		int team = cg.snap->ps.persistant[PERS_TEAM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
ASGNI4
line 232
;232:		if (team == TEAM_RED && cgs.blueflag == FLAG_TAKEN) {
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $299
ADDRGP4 cgs+36336
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $299
line 233
;233:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $292
JUMPV
LABELV $299
line 234
;234:		} else if (team == TEAM_BLUE && cgs.redflag == FLAG_TAKEN) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $302
ADDRGP4 cgs+36332
INDIRI4
CNSTI4 1
NEI4 $302
line 235
;235:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $292
JUMPV
LABELV $302
line 236
;236:		} else {
line 237
;237:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $292
JUMPV
LABELV $293
line 240
;238:		}
;239:	}
;240:	return qfalse;
CNSTI4 0
RETI4
LABELV $292
endproc CG_YourTeamHasFlag 8 0
export CG_OwnerDrawVisible
proc CG_OwnerDrawVisible 4 0
line 245
;241:}
;242:
;243:// THINKABOUTME: should these be exclusive or inclusive.. 
;244:// 
;245:qboolean CG_OwnerDrawVisible(int flags) {
line 247
;246:
;247:	if (flags & CG_SHOW_TEAMINFO) {
ADDRFP4 0
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $306
line 248
;248:		return (cg_currentSelectedPlayer.integer == numSortedTeamPlayers);
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
NEI4 $310
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $311
JUMPV
LABELV $310
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $311
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $305
JUMPV
LABELV $306
line 251
;249:	}
;250:
;251:	if (flags & CG_SHOW_NOTEAMINFO) {
ADDRFP4 0
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $312
line 252
;252:		return !(cg_currentSelectedPlayer.integer == numSortedTeamPlayers);
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
EQI4 $316
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $317
JUMPV
LABELV $316
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $317
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $305
JUMPV
LABELV $312
line 255
;253:	}
;254:
;255:	if (flags & CG_SHOW_OTHERTEAMHASFLAG) {
ADDRFP4 0
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $318
line 256
;256:		return CG_OtherTeamHasFlag();
ADDRLP4 0
ADDRGP4 CG_OtherTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $305
JUMPV
LABELV $318
line 259
;257:	}
;258:
;259:	if (flags & CG_SHOW_YOURTEAMHASENEMYFLAG) {
ADDRFP4 0
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $320
line 260
;260:		return CG_YourTeamHasFlag();
ADDRLP4 0
ADDRGP4 CG_YourTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $305
JUMPV
LABELV $320
line 263
;261:	}
;262:
;263:	if (flags & (CG_SHOW_BLUE_TEAM_HAS_REDFLAG | CG_SHOW_RED_TEAM_HAS_BLUEFLAG)) {
ADDRFP4 0
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $322
line 264
;264:		if (flags & CG_SHOW_BLUE_TEAM_HAS_REDFLAG && (cgs.redflag == FLAG_TAKEN || cgs.flagStatus == FLAG_TAKEN_RED)) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 0
INDIRI4
BANDI4
CNSTI4 0
EQI4 $324
ADDRGP4 cgs+36332
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $328
ADDRGP4 cgs+36340
INDIRI4
CNSTI4 2
NEI4 $324
LABELV $328
line 265
;265:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $324
line 266
;266:		} else if (flags & CG_SHOW_RED_TEAM_HAS_BLUEFLAG && (cgs.blueflag == FLAG_TAKEN || cgs.flagStatus == FLAG_TAKEN_BLUE)) {
ADDRFP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $329
ADDRGP4 cgs+36336
INDIRI4
CNSTI4 1
EQI4 $333
ADDRGP4 cgs+36340
INDIRI4
CNSTI4 3
NEI4 $329
LABELV $333
line 267
;267:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $329
line 269
;268:		}
;269:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $305
JUMPV
LABELV $322
line 272
;270:	}
;271:
;272:	if (flags & CG_SHOW_ANYTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $334
line 273
;273:		if( cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $336
line 274
;274:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $336
line 276
;275:		}
;276:	}
LABELV $334
line 278
;277:
;278:	if (flags & CG_SHOW_ANYNONTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $339
line 279
;279:		if( cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
GEI4 $341
line 280
;280:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $341
line 282
;281:		}
;282:	}
LABELV $339
line 284
;283:
;284:	if (flags & CG_SHOW_CTF) {
ADDRFP4 0
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $344
line 285
;285:		if( cgs.gametype == GT_CTF || cgs.gametype == GT_CTY ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
EQI4 $350
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $346
LABELV $350
line 286
;286:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $346
line 288
;287:		}
;288:	}
LABELV $344
line 290
;289:
;290:	if (flags & CG_SHOW_HEALTHCRITICAL) {
ADDRFP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $351
line 291
;291:		if (cg.snap->ps.stats[STAT_HEALTH] < 25) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 25
GEI4 $353
line 292
;292:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $353
line 294
;293:		}
;294:	}
LABELV $351
line 296
;295:
;296:	if (flags & CG_SHOW_HEALTHOK) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $356
line 297
;297:		if (cg.snap->ps.stats[STAT_HEALTH] >= 25) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 25
LTI4 $358
line 298
;298:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $358
line 300
;299:		}
;300:	}
LABELV $356
line 302
;301:
;302:	if (flags & CG_SHOW_SINGLEPLAYER) {
ADDRFP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $361
line 303
;303:		if( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 4
NEI4 $363
line 304
;304:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $363
line 306
;305:		}
;306:	}
LABELV $361
line 308
;307:
;308:	if (flags & CG_SHOW_TOURNAMENT) {
ADDRFP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $366
line 309
;309:		if( cgs.gametype == GT_TOURNAMENT ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 3
NEI4 $368
line 310
;310:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $368
line 312
;311:		}
;312:	}
LABELV $366
line 314
;313:
;314:	if (flags & CG_SHOW_DURINGINCOMINGVOICE) {
ADDRFP4 0
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $371
line 315
;315:	}
LABELV $371
line 317
;316:
;317:	if (flags & CG_SHOW_IF_PLAYER_HAS_FLAG) {
ADDRFP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $373
line 318
;318:		if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 404
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $381
ADDRGP4 cg+36
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $381
ADDRGP4 cg+36
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $375
LABELV $381
line 319
;319:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $375
line 321
;320:		}
;321:	}
LABELV $373
line 322
;322:	return qfalse;
CNSTI4 0
RETI4
LABELV $305
endproc CG_OwnerDrawVisible 4 0
data
align 4
LABELV $383
address $384
export CG_GetKillerText
code
proc CG_GetKillerText 8 12
line 326
;323:}
;324:
;325:
;326:const char *CG_GetKillerText(void) {
line 328
;327:	static const char *s = "";
;328:	if ( cg.killerName[0] ) {
ADDRGP4 cg+6984
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $385
line 329
;329:		s = va("%s %s", CG_GetStripEdString("INGAMETEXT", "KILLEDBY"), cg.killerName );
ADDRGP4 $389
ARGP4
ADDRGP4 $390
ARGP4
ADDRLP4 0
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRGP4 $388
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 cg+6984
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $383
ADDRLP4 4
INDIRP4
ASGNP4
line 330
;330:	}
LABELV $385
line 331
;331:	return s;
ADDRGP4 $383
INDIRP4
RETP4
LABELV $382
endproc CG_GetKillerText 8 12
data
align 4
LABELV $393
address $384
export CG_GetGameStatusText
code
proc CG_GetGameStatusText 264 16
line 335
;332:}
;333:
;334:
;335:const char *CG_GetGameStatusText(void) {
line 337
;336:	static const char *s = "";
;337:	if ( cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
GEI4 $394
line 338
;338:		if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR ) 
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 3
EQI4 $395
line 339
;339:		{
line 341
;340:			char sPlaceWith[256];
;341:			trap_SP_GetStringTextString("INGAMETEXT_PLACE_WITH", sPlaceWith, sizeof(sPlaceWith));
ADDRGP4 $400
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 343
;342:
;343:			s = va("%s %s %i",CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ), sPlaceWith, cg.snap->ps.persistant[PERS_SCORE] );
ADDRGP4 cg+36
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 256
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $401
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $393
ADDRLP4 260
INDIRP4
ASGNP4
line 344
;344:		}
line 345
;345:	} else {
ADDRGP4 $395
JUMPV
LABELV $394
line 346
;346:		if ( cg.teamScores[0] == cg.teamScores[1] ) {
ADDRGP4 cg+5044
INDIRI4
ADDRGP4 cg+5044+4
INDIRI4
NEI4 $404
line 347
;347:			s = va("Teams are tied at %i", cg.teamScores[0] );
ADDRGP4 $409
ARGP4
ADDRGP4 cg+5044
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $393
ADDRLP4 0
INDIRP4
ASGNP4
line 348
;348:		} else if ( cg.teamScores[0] >= cg.teamScores[1] ) {
ADDRGP4 $405
JUMPV
LABELV $404
ADDRGP4 cg+5044
INDIRI4
ADDRGP4 cg+5044+4
INDIRI4
LTI4 $411
line 349
;349:			s = va("Red leads Blue, %i to %i", cg.teamScores[0], cg.teamScores[1] );
ADDRGP4 $416
ARGP4
ADDRGP4 cg+5044
INDIRI4
ARGI4
ADDRGP4 cg+5044+4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $393
ADDRLP4 0
INDIRP4
ASGNP4
line 350
;350:		} else {
ADDRGP4 $412
JUMPV
LABELV $411
line 351
;351:			s = va("Blue leads Red, %i to %i", cg.teamScores[1], cg.teamScores[0] );
ADDRGP4 $420
ARGP4
ADDRGP4 cg+5044+4
INDIRI4
ARGI4
ADDRGP4 cg+5044
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $393
ADDRLP4 0
INDIRP4
ASGNP4
line 352
;352:		}
LABELV $412
LABELV $405
line 353
;353:	}
LABELV $395
line 354
;354:	return s;
ADDRGP4 $393
INDIRP4
RETP4
LABELV $392
endproc CG_GetGameStatusText 264 16
export CG_GameTypeString
proc CG_GameTypeString 0 0
line 357
;355:}
;356:	
;357:const char *CG_GameTypeString(void) {
line 358
;358:	if ( cgs.gametype == GT_FFA ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 0
NEI4 $425
line 359
;359:		return "Free For All";
ADDRGP4 $428
RETP4
ADDRGP4 $424
JUMPV
LABELV $425
line 360
;360:	} else if ( cgs.gametype == GT_HOLOCRON ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 1
NEI4 $429
line 361
;361:		return "Holocron FFA";
ADDRGP4 $432
RETP4
ADDRGP4 $424
JUMPV
LABELV $429
line 362
;362:	} else if ( cgs.gametype == GT_JEDIMASTER ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 2
NEI4 $433
line 363
;363:		return "Jedi Master";
ADDRGP4 $436
RETP4
ADDRGP4 $424
JUMPV
LABELV $433
line 364
;364:	} else if ( cgs.gametype == GT_TEAM ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
NEI4 $437
line 365
;365:		return "Team FFA";
ADDRGP4 $440
RETP4
ADDRGP4 $424
JUMPV
LABELV $437
line 366
;366:	} else if ( cgs.gametype == GT_SAGA ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 6
NEI4 $441
line 367
;367:		return "N/A";
ADDRGP4 $444
RETP4
ADDRGP4 $424
JUMPV
LABELV $441
line 368
;368:	} else if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
NEI4 $445
line 369
;369:		return "Capture the Flag";
ADDRGP4 $448
RETP4
ADDRGP4 $424
JUMPV
LABELV $445
line 370
;370:	} else if ( cgs.gametype == GT_CTY ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $449
line 371
;371:		return "Capture the Ysalamiri";
ADDRGP4 $452
RETP4
ADDRGP4 $424
JUMPV
LABELV $449
line 373
;372:	}
;373:	return "";
ADDRGP4 $384
RETP4
LABELV $424
endproc CG_GameTypeString 0 0
lit
align 1
LABELV $456
char 1 0
skip 4095
code
proc CG_Text_Paint_Limit 4140 36
line 381
;374:}
;375:						 
;376:extern int MenuFontToHandle(int iMenuFont);
;377:
;378:// maxX param is initially an X limit, but is also used as feedback. 0 = text was clipped to fit within, else maxX = next pos
;379://
;380:static void CG_Text_Paint_Limit(float *maxX, float x, float y, float scale, vec4_t color, const char* text, float adjust, int limit, int iMenuFont) 
;381:{
line 384
;382:	// this is kinda dirty, but...
;383:	//
;384:	int iFontIndex = MenuFontToHandle(iMenuFont);
ADDRFP4 32
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 MenuFontToHandle
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 387
;385:	
;386:	//float fMax = *maxX;
;387:	int iPixelLen = trap_R_Font_StrLenPixels(text, iFontIndex, scale);
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 trap_R_Font_StrLenPixels
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 388
;388:	if (x + iPixelLen > *maxX)
ADDRFP4 4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDF4
ADDRFP4 0
INDIRP4
INDIRF4
LEF4 $454
line 389
;389:	{
line 393
;390:		// whole text won't fit, so we need to print just the amount that does...
;391:		//  Ok, this is slow and tacky, but only called occasionally, and it works...
;392:		//
;393:		char sTemp[4096]={0};	// lazy assumption
ADDRLP4 24
ADDRGP4 $456
INDIRB
ASGNB 4096
line 394
;394:		const char *psText = text;
ADDRLP4 4120
ADDRFP4 20
INDIRP4
ASGNP4
line 395
;395:		char *psOut = &sTemp[0];
ADDRLP4 16
ADDRLP4 24
ASGNP4
line 396
;396:		char *psOutLastGood = psOut;
ADDRLP4 4124
ADDRLP4 16
INDIRP4
ASGNP4
ADDRGP4 $458
JUMPV
LABELV $457
line 402
;397:		unsigned int uiLetter;
;398:
;399:		while (*psText && (x + trap_R_Font_StrLenPixels(sTemp, iFontIndex, scale)<=*maxX) 
;400:			   && psOut < &sTemp[sizeof(sTemp)-1]	// sanity
;401:				)
;402:		{
line 403
;403:			psOutLastGood = psOut;
ADDRLP4 4124
ADDRLP4 16
INDIRP4
ASGNP4
line 405
;404:			
;405:			uiLetter = trap_AnyLanguage_ReadCharFromString(&psText);
ADDRLP4 4120
ARGP4
ADDRLP4 4128
ADDRGP4 trap_AnyLanguage_ReadCharFromString
CALLU4
ASGNU4
ADDRLP4 20
ADDRLP4 4128
INDIRU4
ASGNU4
line 406
;406:			if (uiLetter > 255)
ADDRLP4 20
INDIRU4
CNSTU4 255
LEU4 $461
line 407
;407:			{
line 408
;408:				*psOut++ = uiLetter>>8;
ADDRLP4 4132
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 4132
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4132
INDIRP4
ADDRLP4 20
INDIRU4
CNSTI4 8
RSHU4
CVUI4 4
CVII1 4
ASGNI1
line 409
;409:				*psOut++ = uiLetter&0xFF;
ADDRLP4 4136
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 4136
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4136
INDIRP4
ADDRLP4 20
INDIRU4
CNSTU4 255
BANDU4
CVUI4 4
CVII1 4
ASGNI1
line 410
;410:			}
ADDRGP4 $462
JUMPV
LABELV $461
line 412
;411:			else
;412:			{
line 413
;413:				*psOut++ = uiLetter&0xFF;
ADDRLP4 4132
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 4132
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4132
INDIRP4
ADDRLP4 20
INDIRU4
CNSTU4 255
BANDU4
CVUI4 4
CVII1 4
ASGNI1
line 414
;414:			}
LABELV $462
line 415
;415:		}
LABELV $458
line 399
ADDRLP4 4120
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $464
ADDRLP4 24
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 4128
ADDRGP4 trap_R_Font_StrLenPixels
CALLI4
ASGNI4
ADDRFP4 4
INDIRF4
ADDRLP4 4128
INDIRI4
CVIF4 4
ADDF4
ADDRFP4 0
INDIRP4
INDIRF4
GTF4 $464
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 24+4095
CVPU4 4
LTU4 $457
LABELV $464
line 416
;416:		*psOutLastGood = '\0';
ADDRLP4 4124
INDIRP4
CNSTI1 0
ASGNI1
line 418
;417:
;418:		*maxX = 0;	// feedback
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 419
;419:		CG_Text_Paint(x, y, scale, color, sTemp, adjust, limit, ITEM_TEXTSTYLE_NORMAL, iMenuFont);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRFP4 24
INDIRF4
ARGF4
ADDRFP4 28
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 32
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 420
;420:	}
ADDRGP4 $455
JUMPV
LABELV $454
line 422
;421:	else
;422:	{
line 425
;423:		// whole text fits fine, so print it all...
;424:		//
;425:		*maxX = x + iPixelLen;	// feedback the next position, as the caller expects		
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 426
;426:		CG_Text_Paint(x, y, scale, color, text, adjust, limit, ITEM_TEXTSTYLE_NORMAL, iMenuFont);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 24
INDIRF4
ARGF4
ADDRFP4 28
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 32
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 427
;427:	}
LABELV $455
line 428
;428:}
LABELV $453
endproc CG_Text_Paint_Limit 4140 36
export CG_DrawNewTeamInfo
proc CG_DrawNewTeamInfo 100 36
line 434
;429:
;430:
;431:
;432:#define PIC_WIDTH 12
;433:
;434:void CG_DrawNewTeamInfo(rectDef_t *rect, float text_x, float text_y, float scale, vec4_t color, qhandle_t shader) {
line 446
;435:	int xx;
;436:	float y;
;437:	int i, j, len, count;
;438:	const char *p;
;439:	vec4_t		hcolor;
;440:	float pwidth, lwidth, maxx, leftOver;
;441:	clientInfo_t *ci;
;442:	gitem_t	*item;
;443:	qhandle_t h;
;444:
;445:	// max player name width
;446:	pwidth = 0;
ADDRLP4 64
CNSTF4 0
ASGNF4
line 447
;447:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
ADDRGP4 numSortedTeamPlayers
INDIRI4
CNSTI4 8
LEI4 $467
ADDRLP4 72
CNSTI4 8
ASGNI4
ADDRGP4 $468
JUMPV
LABELV $467
ADDRLP4 72
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
LABELV $468
ADDRLP4 32
ADDRLP4 72
INDIRI4
ASGNI4
line 448
;448:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $472
JUMPV
LABELV $469
line 449
;449:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 788
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 450
;450:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $474
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
NEI4 $474
line 451
;451:			len = CG_Text_Width( ci->name, scale, 0);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 80
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 80
INDIRI4
ASGNI4
line 452
;452:			if (len > pwidth)
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRLP4 64
INDIRF4
LEF4 $477
line 453
;453:				pwidth = len;
ADDRLP4 64
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
LABELV $477
line 454
;454:		}
LABELV $474
line 455
;455:	}
LABELV $470
line 448
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $472
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $469
line 458
;456:
;457:	// max location name width
;458:	lwidth = 0;
ADDRLP4 68
CNSTF4 0
ASGNF4
line 459
;459:	for (i = 1; i < MAX_LOCATIONS; i++) {
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $479
line 460
;460:		p = CG_ConfigString(CS_LOCATIONS + i);
ADDRLP4 8
INDIRI4
CNSTI4 640
ADDI4
ARGI4
ADDRLP4 76
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 76
INDIRP4
ASGNP4
line 461
;461:		if (p && *p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $483
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $483
line 462
;462:			len = CG_Text_Width(p, scale, 0);
ADDRLP4 20
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 84
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 84
INDIRI4
ASGNI4
line 463
;463:			if (len > lwidth)
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRLP4 68
INDIRF4
LEF4 $485
line 464
;464:				lwidth = len;
ADDRLP4 68
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
LABELV $485
line 465
;465:		}
LABELV $483
line 466
;466:	}
LABELV $480
line 459
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $479
line 468
;467:
;468:	y = rect->y;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 470
;469:
;470:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $490
JUMPV
LABELV $487
line 471
;471:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 788
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 472
;472:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $492
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
NEI4 $492
line 474
;473:
;474:			xx = rect->x + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 475
;475:			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $495
line 476
;476:				if (ci->powerups & (1 << j)) {
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $499
line 478
;477:
;478:					item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 80
INDIRP4
ASGNP4
line 480
;479:
;480:					if (item) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $501
line 481
;481:						CG_DrawPic( xx, y, PIC_WIDTH, PIC_WIDTH, trap_R_RegisterShader( item->icon ) );
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 88
CNSTF4 1094713344
ASGNF4
ADDRLP4 88
INDIRF4
ARGF4
ADDRLP4 88
INDIRF4
ARGF4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 482
;482:						xx += PIC_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
line 483
;483:					}
LABELV $501
line 484
;484:				}
LABELV $499
line 485
;485:			}
LABELV $496
line 475
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LEI4 $495
line 488
;486:
;487:			// FIXME: max of 3 powerups shown properly
;488:			xx = rect->x + (PIC_WIDTH * 3) + 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1108344832
ADDF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ASGNI4
line 490
;489:
;490:			CG_GetColorForHealth( ci->health, ci->armor, hcolor );
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 491
;491:			trap_R_SetColor(hcolor);
ADDRLP4 48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 492
;492:			CG_DrawPic( xx, y + 1, PIC_WIDTH - 2, PIC_WIDTH - 2, cgs.media.heartShader );
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 84
CNSTF4 1092616192
ASGNF4
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 84
INDIRF4
ARGF4
ADDRGP4 cgs+70280+580
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 498
;493:
;494:			//Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);
;495:			//CG_Text_Paint(xx, y + text_y, scale, hcolor, st, 0, 0); 
;496:
;497:			// draw weapon icon
;498:			xx += PIC_WIDTH + 1;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 13
ADDI4
ASGNI4
line 509
;499:
;500:// weapon used is not that useful, use the space for task
;501:#if 0
;502:			if ( cg_weapons[ci->curWeapon].weaponIcon ) {
;503:				CG_DrawPic( xx, y, PIC_WIDTH, PIC_WIDTH, cg_weapons[ci->curWeapon].weaponIcon );
;504:			} else {
;505:				CG_DrawPic( xx, y, PIC_WIDTH, PIC_WIDTH, cgs.media.deferShader );
;506:			}
;507:#endif
;508:
;509:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 510
;510:			if (cgs.orderPending) {
ADDRGP4 cgs+70224
INDIRI4
CNSTI4 0
EQI4 $505
line 512
;511:				// blink the icon
;512:				if ( cg.time > cgs.orderTime - 2500 && (cg.time >> 9 ) & 1 ) {
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgs+70228
INDIRI4
CNSTI4 2500
SUBI4
LEI4 $508
ADDRGP4 cg+64
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $508
line 513
;513:					h = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 514
;514:				} else {
ADDRGP4 $506
JUMPV
LABELV $508
line 515
;515:					h = CG_StatusHandle(cgs.currentOrder);
ADDRGP4 cgs+70220
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 CG_StatusHandle
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 88
INDIRI4
ASGNI4
line 516
;516:				}
line 517
;517:			}	else {
ADDRGP4 $506
JUMPV
LABELV $505
line 518
;518:				h = CG_StatusHandle(ci->teamTask);
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 CG_StatusHandle
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 88
INDIRI4
ASGNI4
line 519
;519:			}
LABELV $506
line 521
;520:
;521:			if (h) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $514
line 522
;522:				CG_DrawPic( xx, y, PIC_WIDTH, PIC_WIDTH, h);
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 88
CNSTF4 1094713344
ASGNF4
ADDRLP4 88
INDIRF4
ARGF4
ADDRLP4 88
INDIRF4
ARGF4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 523
;523:			}
LABELV $514
line 525
;524:
;525:			xx += PIC_WIDTH + 1;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 13
ADDI4
ASGNI4
line 527
;526:
;527:			leftOver = rect->w - xx;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 528
;528:			maxx = xx + leftOver / 3;
ADDRLP4 36
ADDRLP4 12
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
CNSTF4 1077936128
DIVF4
ADDF4
ASGNF4
line 532
;529:
;530:
;531:
;532:			CG_Text_Paint_Limit(&maxx, xx, y + text_y, scale, color, ci->name, 0, 0, FONT_MEDIUM); 
ADDRLP4 36
ARGP4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 CG_Text_Paint_Limit
CALLV
pop
line 534
;533:
;534:			p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 640
ADDI4
ARGI4
ADDRLP4 88
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 88
INDIRP4
ASGNP4
line 535
;535:			if (!p || !*p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $518
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $516
LABELV $518
line 536
;536:				p = "unknown";
ADDRLP4 20
ADDRGP4 $519
ASGNP4
line 537
;537:			}
LABELV $516
line 539
;538:
;539:			xx += leftOver / 3 + 2;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
CNSTF4 1077936128
DIVF4
CNSTF4 1073741824
ADDF4
ADDF4
CVFI4 4
ASGNI4
line 540
;540:			maxx = rect->w - 4;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1082130432
SUBF4
ASGNF4
line 542
;541:
;542:			CG_Text_Paint_Limit(&maxx, xx, y + text_y, scale, color, p, 0, 0, FONT_MEDIUM); 
ADDRLP4 36
ARGP4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 CG_Text_Paint_Limit
CALLV
pop
line 543
;543:			y += text_y + 2;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1073741824
ADDF4
ADDF4
ASGNF4
line 544
;544:			if ( y + text_y + 2 > rect->y + rect->h ) {
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
CNSTF4 1073741824
ADDF4
ADDRLP4 96
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
LEF4 $520
line 545
;545:				break;
ADDRGP4 $489
JUMPV
LABELV $520
line 548
;546:			}
;547:
;548:		}
LABELV $492
line 549
;549:	}
LABELV $488
line 470
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $490
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $487
LABELV $489
line 550
;550:}
LABELV $465
endproc CG_DrawNewTeamInfo 100 36
export CG_DrawTeamSpectators
proc CG_DrawTeamSpectators 24 36
line 553
;551:
;552:
;553:void CG_DrawTeamSpectators(rectDef_t *rect, float scale, vec4_t color, qhandle_t shader) {
line 554
;554:	if (cg.spectatorLen) {
ADDRGP4 cg+8040
INDIRI4
CNSTI4 0
EQI4 $523
line 557
;555:		float maxX;
;556:
;557:		if (cg.spectatorWidth == -1) {
ADDRGP4 cg+8044
INDIRF4
CNSTF4 3212836864
NEF4 $526
line 558
;558:			cg.spectatorWidth = 0;
ADDRGP4 cg+8044
CNSTF4 0
ASGNF4
line 559
;559:			cg.spectatorPaintX = rect->x + 1;
ADDRGP4 cg+8052
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 560
;560:			cg.spectatorPaintX2 = -1;
ADDRGP4 cg+8056
CNSTI4 -1
ASGNI4
line 561
;561:		}
LABELV $526
line 563
;562:
;563:		if (cg.spectatorOffset > cg.spectatorLen) {
ADDRGP4 cg+8060
INDIRI4
ADDRGP4 cg+8040
INDIRI4
LEI4 $532
line 564
;564:			cg.spectatorOffset = 0;
ADDRGP4 cg+8060
CNSTI4 0
ASGNI4
line 565
;565:			cg.spectatorPaintX = rect->x + 1;
ADDRGP4 cg+8052
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 566
;566:			cg.spectatorPaintX2 = -1;
ADDRGP4 cg+8056
CNSTI4 -1
ASGNI4
line 567
;567:		}
LABELV $532
line 569
;568:
;569:		if (cg.time > cg.spectatorTime) {
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+8048
INDIRI4
LEI4 $539
line 570
;570:			cg.spectatorTime = cg.time + 10;
ADDRGP4 cg+8048
ADDRGP4 cg+64
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 571
;571:			if (cg.spectatorPaintX <= rect->x + 2) {
ADDRGP4 cg+8052
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
GTF4 $545
line 572
;572:				if (cg.spectatorOffset < cg.spectatorLen) {
ADDRGP4 cg+8060
INDIRI4
ADDRGP4 cg+8040
INDIRI4
GEI4 $548
line 573
;573:					cg.spectatorPaintX += CG_Text_Width(&cg.spectatorList[cg.spectatorOffset], scale, 1) - 1;
ADDRGP4 cg+8060
INDIRI4
ADDRGP4 cg+7016
ADDP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 8
ADDRGP4 cg+8052
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ADDI4
ASGNI4
line 574
;574:					cg.spectatorOffset++;
ADDRLP4 12
ADDRGP4 cg+8060
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 575
;575:				} else {
ADDRGP4 $546
JUMPV
LABELV $548
line 576
;576:					cg.spectatorOffset = 0;
ADDRGP4 cg+8060
CNSTI4 0
ASGNI4
line 577
;577:					if (cg.spectatorPaintX2 >= 0) {
ADDRGP4 cg+8056
INDIRI4
CNSTI4 0
LTI4 $557
line 578
;578:						cg.spectatorPaintX = cg.spectatorPaintX2;
ADDRGP4 cg+8052
ADDRGP4 cg+8056
INDIRI4
ASGNI4
line 579
;579:					} else {
ADDRGP4 $558
JUMPV
LABELV $557
line 580
;580:						cg.spectatorPaintX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 cg+8052
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
CVFI4 4
ASGNI4
line 581
;581:					}
LABELV $558
line 582
;582:					cg.spectatorPaintX2 = -1;
ADDRGP4 cg+8056
CNSTI4 -1
ASGNI4
line 583
;583:				}
line 584
;584:			} else {
ADDRGP4 $546
JUMPV
LABELV $545
line 585
;585:				cg.spectatorPaintX--;
ADDRLP4 4
ADDRGP4 cg+8052
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 586
;586:				if (cg.spectatorPaintX2 >= 0) {
ADDRGP4 cg+8056
INDIRI4
CNSTI4 0
LTI4 $565
line 587
;587:					cg.spectatorPaintX2--;
ADDRLP4 8
ADDRGP4 cg+8056
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 588
;588:				}
LABELV $565
line 589
;589:			}
LABELV $546
line 590
;590:		}
LABELV $539
line 592
;591:
;592:		maxX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 593
;593:		CG_Text_Paint_Limit(&maxX, cg.spectatorPaintX, rect->y + rect->h - 3, scale, color, &cg.spectatorList[cg.spectatorOffset], 0, 0, FONT_MEDIUM); 
ADDRLP4 0
ARGP4
ADDRGP4 cg+8052
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1077936128
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 cg+8060
INDIRI4
ADDRGP4 cg+7016
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 CG_Text_Paint_Limit
CALLV
pop
line 594
;594:		if (cg.spectatorPaintX2 >= 0) {
ADDRGP4 cg+8056
INDIRI4
CNSTI4 0
LTI4 $572
line 595
;595:			float maxX2 = rect->x + rect->w - 2;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 596
;596:			CG_Text_Paint_Limit(&maxX2, cg.spectatorPaintX2, rect->y + rect->h - 3, scale, color, cg.spectatorList, 0, cg.spectatorOffset, FONT_MEDIUM); 
ADDRLP4 12
ARGP4
ADDRGP4 cg+8056
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1077936128
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 cg+7016
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 cg+8060
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 CG_Text_Paint_Limit
CALLV
pop
line 597
;597:		}
LABELV $572
line 598
;598:		if (cg.spectatorOffset && maxX > 0) {
ADDRGP4 cg+8060
INDIRI4
CNSTI4 0
EQI4 $578
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $578
line 600
;599:			// if we have an offset ( we are skipping the first part of the string ) and we fit the string
;600:			if (cg.spectatorPaintX2 == -1) {
ADDRGP4 cg+8056
INDIRI4
CNSTI4 -1
NEI4 $579
line 601
;601:						cg.spectatorPaintX2 = rect->x + rect->w - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 cg+8056
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
CVFI4 4
ASGNI4
line 602
;602:			}
line 603
;603:		} else {
ADDRGP4 $579
JUMPV
LABELV $578
line 604
;604:			cg.spectatorPaintX2 = -1;
ADDRGP4 cg+8056
CNSTI4 -1
ASGNI4
line 605
;605:		}
LABELV $579
line 607
;606:
;607:	}
LABELV $523
line 608
;608:}
LABELV $522
endproc CG_DrawTeamSpectators 24 36
export CG_DrawMedal
proc CG_DrawMedal 32 36
line 612
;609:
;610:
;611:
;612:void CG_DrawMedal(int ownerDraw, rectDef_t *rect, float scale, vec4_t color, qhandle_t shader) {
line 613
;613:	score_t *score = &cg.scores[cg.selectedScore];
ADDRLP4 8
CNSTI4 60
ADDRGP4 cg+5040
INDIRI4
MULI4
ADDRGP4 cg+5052
ADDP4
ASGNP4
line 614
;614:	float value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 615
;615:	char *text = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 616
;616:	color[3] = 0.25;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1048576000
ASGNF4
line 618
;617:
;618:	switch (ownerDraw) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 53
LTI4 $589
ADDRLP4 12
INDIRI4
CNSTI4 59
GTI4 $599
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $600-212
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $600
address $591
address $592
address $593
address $594
address $595
address $596
address $597
code
LABELV $599
ADDRFP4 0
INDIRI4
CNSTI4 69
EQI4 $598
ADDRGP4 $589
JUMPV
LABELV $591
line 620
;619:		case CG_ACCURACY:
;620:			value = score->accuracy;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 621
;621:			break;
ADDRGP4 $590
JUMPV
LABELV $592
line 623
;622:		case CG_ASSISTS:
;623:			value = score->assistCount;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 624
;624:			break;
ADDRGP4 $590
JUMPV
LABELV $593
line 626
;625:		case CG_DEFEND:
;626:			value = score->defendCount;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 627
;627:			break;
ADDRGP4 $590
JUMPV
LABELV $594
line 629
;628:		case CG_EXCELLENT:
;629:			value = score->excellentCount;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 630
;630:			break;
ADDRGP4 $590
JUMPV
LABELV $595
line 632
;631:		case CG_IMPRESSIVE:
;632:			value = score->impressiveCount;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 633
;633:			break;
ADDRGP4 $590
JUMPV
LABELV $596
line 635
;634:		case CG_PERFECT:
;635:			value = score->perfect;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 636
;636:			break;
ADDRGP4 $590
JUMPV
LABELV $597
line 638
;637:		case CG_GAUNTLET:
;638:			value = score->guantletCount;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 639
;639:			break;
ADDRGP4 $590
JUMPV
LABELV $598
line 641
;640:		case CG_CAPTURES:
;641:			value = score->captures;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 642
;642:			break;
LABELV $589
LABELV $590
line 645
;643:	}
;644:
;645:	if (value > 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $602
line 646
;646:		if (ownerDraw != CG_PERFECT) {
ADDRFP4 0
INDIRI4
CNSTI4 58
EQI4 $604
line 647
;647:			if (ownerDraw == CG_ACCURACY) {
ADDRFP4 0
INDIRI4
CNSTI4 53
NEI4 $606
line 648
;648:				text = va("%i%%", (int)value);
ADDRGP4 $608
ARGP4
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 649
;649:				if (value > 50) {
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
LEF4 $605
line 650
;650:					color[3] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 651
;651:				}
line 652
;652:			} else {
ADDRGP4 $605
JUMPV
LABELV $606
line 653
;653:				text = va("%i", (int)value);
ADDRGP4 $611
ARGP4
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 654
;654:				color[3] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 655
;655:			}
line 656
;656:		} else {
ADDRGP4 $605
JUMPV
LABELV $604
line 657
;657:			if (value) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $612
line 658
;658:				color[3] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 659
;659:			}
LABELV $612
line 660
;660:			text = "Wow";
ADDRLP4 4
ADDRGP4 $614
ASGNP4
line 661
;661:		}
LABELV $605
line 662
;662:	}
LABELV $602
line 664
;663:
;664:	trap_R_SetColor(color);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 665
;665:	CG_DrawPic( rect->x, rect->y, rect->w, rect->h, shader );
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 667
;666:
;667:	if (text) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $615
line 668
;668:		color[3] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 669
;669:		value = CG_Text_Width(text, scale, 0);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
CVIF4 4
ASGNF4
line 670
;670:		CG_Text_Paint(rect->x + (rect->w - value) / 2, rect->y + rect->h + 10 , scale, color, text, 0, 0, 0, FONT_MEDIUM); 
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
CNSTF4 1073741824
DIVF4
ADDF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1092616192
ADDF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 671
;671:	}
LABELV $615
line 672
;672:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 674
;673:
;674:}
LABELV $586
endproc CG_DrawMedal 32 36
export CG_OwnerDraw
proc CG_OwnerDraw 0 0
line 678
;675:
;676:	
;677://
;678:void CG_OwnerDraw(float x, float y, float w, float h, float text_x, float text_y, int ownerDraw, int ownerDrawFlags, int align, float special, float scale, vec4_t color, qhandle_t shader, int textStyle,int font) {
line 861
;679:
;680://Ignore all this, at least for now. May put some stat stuff back in menu files later.
;681:#if 0
;682:	rectDef_t rect;
;683:
;684:  if ( cg_drawStatus.integer == 0 ) {
;685:		return;
;686:	}
;687:
;688:	//if (ownerDrawFlags != 0 && !CG_OwnerDrawVisible(ownerDrawFlags)) {
;689:	//	return;
;690:	//}
;691:
;692:  rect.x = x;
;693:  rect.y = y;
;694:  rect.w = w;
;695:  rect.h = h;
;696:
;697:  switch (ownerDraw) {
;698:  case CG_PLAYER_ARMOR_ICON:
;699:    CG_DrawPlayerArmorIcon(&rect, ownerDrawFlags & CG_SHOW_2DONLY);
;700:    break;
;701:  case CG_PLAYER_ARMOR_ICON2D:
;702:    CG_DrawPlayerArmorIcon(&rect, qtrue);
;703:    break;
;704:  case CG_PLAYER_ARMOR_VALUE:
;705:    CG_DrawPlayerArmorValue(&rect, scale, color, shader, textStyle);
;706:    break;
;707:  case CG_PLAYER_FORCE_VALUE:
;708:    CG_DrawPlayerForceValue(&rect, scale, color, shader, textStyle);
;709:	return ;
;710:  case CG_PLAYER_AMMO_ICON:
;711:    CG_DrawPlayerAmmoIcon(&rect, ownerDrawFlags & CG_SHOW_2DONLY);
;712:    break;
;713:  case CG_PLAYER_AMMO_ICON2D:
;714:    CG_DrawPlayerAmmoIcon(&rect, qtrue);
;715:    break;
;716:  case CG_PLAYER_AMMO_VALUE:
;717:    CG_DrawPlayerAmmoValue(&rect, scale, color, shader, textStyle);
;718:    break;
;719:  case CG_SELECTEDPLAYER_HEAD:
;720:    CG_DrawSelectedPlayerHead(&rect, ownerDrawFlags & CG_SHOW_2DONLY, qfalse);
;721:    break;
;722:  case CG_VOICE_HEAD:
;723:    CG_DrawSelectedPlayerHead(&rect, ownerDrawFlags & CG_SHOW_2DONLY, qtrue);
;724:    break;
;725:  case CG_VOICE_NAME:
;726:    CG_DrawSelectedPlayerName(&rect, scale, color, qtrue, textStyle);
;727:    break;
;728:  case CG_SELECTEDPLAYER_STATUS:
;729:    CG_DrawSelectedPlayerStatus(&rect);
;730:    break;
;731:  case CG_SELECTEDPLAYER_ARMOR:
;732:    CG_DrawSelectedPlayerArmor(&rect, scale, color, shader, textStyle);
;733:    break;
;734:  case CG_SELECTEDPLAYER_HEALTH:
;735:    CG_DrawSelectedPlayerHealth(&rect, scale, color, shader, textStyle);
;736:    break;
;737:  case CG_SELECTEDPLAYER_NAME:
;738:    CG_DrawSelectedPlayerName(&rect, scale, color, qfalse, textStyle);
;739:    break;
;740:  case CG_SELECTEDPLAYER_LOCATION:
;741:    CG_DrawSelectedPlayerLocation(&rect, scale, color, textStyle);
;742:    break;
;743:  case CG_SELECTEDPLAYER_WEAPON:
;744:    CG_DrawSelectedPlayerWeapon(&rect);
;745:    break;
;746:  case CG_SELECTEDPLAYER_POWERUP:
;747:    CG_DrawSelectedPlayerPowerup(&rect, ownerDrawFlags & CG_SHOW_2DONLY);
;748:    break;
;749:  case CG_PLAYER_HEAD:
;750:    CG_DrawPlayerHead(&rect, ownerDrawFlags & CG_SHOW_2DONLY);
;751:    break;
;752:  case CG_PLAYER_ITEM:
;753:    CG_DrawPlayerItem(&rect, scale, ownerDrawFlags & CG_SHOW_2DONLY);
;754:    break;
;755:  case CG_PLAYER_SCORE:
;756:    CG_DrawPlayerScore(&rect, scale, color, shader, textStyle);
;757:    break;
;758:  case CG_PLAYER_HEALTH:
;759:    CG_DrawPlayerHealth(&rect, scale, color, shader, textStyle);
;760:    break;
;761:  case CG_RED_SCORE:
;762:    CG_DrawRedScore(&rect, scale, color, shader, textStyle);
;763:    break;
;764:  case CG_BLUE_SCORE:
;765:    CG_DrawBlueScore(&rect, scale, color, shader, textStyle);
;766:    break;
;767:  case CG_RED_NAME:
;768:    CG_DrawRedName(&rect, scale, color, textStyle);
;769:    break;
;770:  case CG_BLUE_NAME:
;771:    CG_DrawBlueName(&rect, scale, color, textStyle);
;772:    break;
;773:  case CG_BLUE_FLAGHEAD:
;774:    CG_DrawBlueFlagHead(&rect);
;775:    break;
;776:  case CG_BLUE_FLAGSTATUS:
;777:    CG_DrawBlueFlagStatus(&rect, shader);
;778:    break;
;779:  case CG_BLUE_FLAGNAME:
;780:    CG_DrawBlueFlagName(&rect, scale, color, textStyle);
;781:    break;
;782:  case CG_RED_FLAGHEAD:
;783:    CG_DrawRedFlagHead(&rect);
;784:    break;
;785:  case CG_RED_FLAGSTATUS:
;786:    CG_DrawRedFlagStatus(&rect, shader);
;787:    break;
;788:  case CG_RED_FLAGNAME:
;789:    CG_DrawRedFlagName(&rect, scale, color, textStyle);
;790:    break;
;791:  case CG_PLAYER_LOCATION:
;792:    CG_DrawPlayerLocation(&rect, scale, color, textStyle);
;793:    break;
;794:  case CG_TEAM_COLOR:
;795:    CG_DrawTeamColor(&rect, color);
;796:    break;
;797:  case CG_CTF_POWERUP:
;798:    CG_DrawCTFPowerUp(&rect);
;799:    break;
;800:  case CG_AREA_POWERUP:
;801:		CG_DrawAreaPowerUp(&rect, align, special, scale, color);
;802:    break;
;803:  case CG_PLAYER_STATUS:
;804:    CG_DrawPlayerStatus(&rect);
;805:    break;
;806:  case CG_PLAYER_HASFLAG:
;807:    CG_DrawPlayerHasFlag(&rect, qfalse);
;808:    break;
;809:  case CG_PLAYER_HASFLAG2D:
;810:    CG_DrawPlayerHasFlag(&rect, qtrue);
;811:    break;
;812:  case CG_AREA_SYSTEMCHAT:
;813:    CG_DrawAreaSystemChat(&rect, scale, color, shader);
;814:    break;
;815:  case CG_AREA_TEAMCHAT:
;816:    CG_DrawAreaTeamChat(&rect, scale, color, shader);
;817:    break;
;818:  case CG_AREA_CHAT:
;819:    CG_DrawAreaChat(&rect, scale, color, shader);
;820:    break;
;821:  case CG_GAME_TYPE:
;822:    CG_DrawGameType(&rect, scale, color, shader, textStyle);
;823:    break;
;824:  case CG_GAME_STATUS:
;825:    CG_DrawGameStatus(&rect, scale, color, shader, textStyle);
;826:		break;
;827:  case CG_KILLER:
;828:    CG_DrawKiller(&rect, scale, color, shader, textStyle);
;829:		break;
;830:	case CG_ACCURACY:
;831:	case CG_ASSISTS:
;832:	case CG_DEFEND:
;833:	case CG_EXCELLENT:
;834:	case CG_IMPRESSIVE:
;835:	case CG_PERFECT:
;836:	case CG_GAUNTLET:
;837:	case CG_CAPTURES:
;838:		CG_DrawMedal(ownerDraw, &rect, scale, color, shader);
;839:		break;
;840:  case CG_SPECTATORS:
;841:		CG_DrawTeamSpectators(&rect, scale, color, shader);
;842:		break;
;843:  case CG_TEAMINFO:
;844:		if (cg_currentSelectedPlayer.integer == numSortedTeamPlayers) {
;845:			CG_DrawNewTeamInfo(&rect, text_x, text_y, scale, color, shader);
;846:		}
;847:		break;
;848:  case CG_CAPFRAGLIMIT:
;849:    CG_DrawCapFragLimit(&rect, scale, color, shader, textStyle);
;850:		break;
;851:  case CG_1STPLACE:
;852:    CG_Draw1stPlace(&rect, scale, color, shader, textStyle);
;853:		break;
;854:  case CG_2NDPLACE:
;855:    CG_Draw2ndPlace(&rect, scale, color, shader, textStyle);
;856:		break;
;857:  default:
;858:    break;
;859:  }
;860:#endif
;861:}
LABELV $617
endproc CG_OwnerDraw 0 0
export CG_MouseEvent
proc CG_MouseEvent 16 12
line 863
;862:
;863:void CG_MouseEvent(int x, int y) {
line 866
;864:	int n;
;865:
;866:	if ( (cg.predictedPlayerState.pm_type == PM_NORMAL || cg.predictedPlayerState.pm_type == PM_FLOAT || cg.predictedPlayerState.pm_type == PM_SPECTATOR) && cg.showScores == qfalse) {
ADDRGP4 cg+96+4
INDIRI4
CNSTI4 0
EQI4 $629
ADDRGP4 cg+96+4
INDIRI4
CNSTI4 1
EQI4 $629
ADDRGP4 cg+96+4
INDIRI4
CNSTI4 3
NEI4 $619
LABELV $629
ADDRGP4 cg+6972
INDIRI4
CNSTI4 0
NEI4 $619
line 867
;867:    trap_Key_SetCatcher(0);
CNSTI4 0
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 868
;868:		return;
ADDRGP4 $618
JUMPV
LABELV $619
line 871
;869:	}
;870:
;871:	cgs.cursorX+= x;
ADDRLP4 4
ADDRGP4 cgs+70192
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
ASGNI4
line 872
;872:	if (cgs.cursorX < 0)
ADDRGP4 cgs+70192
INDIRI4
CNSTI4 0
GEI4 $631
line 873
;873:		cgs.cursorX = 0;
ADDRGP4 cgs+70192
CNSTI4 0
ASGNI4
ADDRGP4 $632
JUMPV
LABELV $631
line 874
;874:	else if (cgs.cursorX > 640)
ADDRGP4 cgs+70192
INDIRI4
CNSTI4 640
LEI4 $635
line 875
;875:		cgs.cursorX = 640;
ADDRGP4 cgs+70192
CNSTI4 640
ASGNI4
LABELV $635
LABELV $632
line 877
;876:
;877:	cgs.cursorY += y;
ADDRLP4 8
ADDRGP4 cgs+70196
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 878
;878:	if (cgs.cursorY < 0)
ADDRGP4 cgs+70196
INDIRI4
CNSTI4 0
GEI4 $640
line 879
;879:		cgs.cursorY = 0;
ADDRGP4 cgs+70196
CNSTI4 0
ASGNI4
ADDRGP4 $641
JUMPV
LABELV $640
line 880
;880:	else if (cgs.cursorY > 480)
ADDRGP4 cgs+70196
INDIRI4
CNSTI4 480
LEI4 $644
line 881
;881:		cgs.cursorY = 480;
ADDRGP4 cgs+70196
CNSTI4 480
ASGNI4
LABELV $644
LABELV $641
line 883
;882:
;883:	n = Display_CursorType(cgs.cursorX, cgs.cursorY);
ADDRGP4 cgs+70192
INDIRI4
ARGI4
ADDRGP4 cgs+70196
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Display_CursorType
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 884
;884:	cgs.activeCursor = 0;
ADDRGP4 cgs+70216
CNSTI4 0
ASGNI4
line 885
;885:	if (n == CURSOR_ARROW) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $651
line 886
;886:		cgs.activeCursor = cgs.media.selectCursor;
ADDRGP4 cgs+70216
ADDRGP4 cgs+70280+932
INDIRI4
ASGNI4
line 887
;887:	} else if (n == CURSOR_SIZER) {
ADDRGP4 $652
JUMPV
LABELV $651
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $656
line 888
;888:		cgs.activeCursor = cgs.media.sizeCursor;
ADDRGP4 cgs+70216
ADDRGP4 cgs+70280+936
INDIRI4
ASGNI4
line 889
;889:	}
LABELV $656
LABELV $652
line 891
;890:
;891:  if (cgs.capturedItem) {
ADDRGP4 cgs+70212
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $661
line 892
;892:	  Display_MouseMove(cgs.capturedItem, x, y);
ADDRGP4 cgs+70212
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 893
;893:  } else {
ADDRGP4 $662
JUMPV
LABELV $661
line 894
;894:	  Display_MouseMove(NULL, cgs.cursorX, cgs.cursorY);
CNSTP4 0
ARGP4
ADDRGP4 cgs+70192
INDIRI4
ARGI4
ADDRGP4 cgs+70196
INDIRI4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 895
;895:  }
LABELV $662
line 897
;896:
;897:}
LABELV $618
endproc CG_MouseEvent 16 12
export CG_HideTeamMenu
proc CG_HideTeamMenu 0 4
line 905
;898:
;899:/*
;900:==================
;901:CG_HideTeamMenus
;902:==================
;903:
;904:*/
;905:void CG_HideTeamMenu() {
line 906
;906:  Menus_CloseByName("teamMenu");
ADDRGP4 $668
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 907
;907:  Menus_CloseByName("getMenu");
ADDRGP4 $669
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 908
;908:}
LABELV $667
endproc CG_HideTeamMenu 0 4
export CG_ShowTeamMenu
proc CG_ShowTeamMenu 0 4
line 916
;909:
;910:/*
;911:==================
;912:CG_ShowTeamMenus
;913:==================
;914:
;915:*/
;916:void CG_ShowTeamMenu() {
line 917
;917:  Menus_OpenByName("teamMenu");
ADDRGP4 $668
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 918
;918:}
LABELV $670
endproc CG_ShowTeamMenu 0 4
export CG_EventHandling
proc CG_EventHandling 0 0
line 932
;919:
;920:
;921:
;922:
;923:/*
;924:==================
;925:CG_EventHandling
;926:==================
;927: type 0 - no event handling
;928:      1 - team menu
;929:      2 - hud editor
;930:
;931:*/
;932:void CG_EventHandling(int type) {
line 933
;933:	cgs.eventHandling = type;
ADDRGP4 cgs+70200
ADDRFP4 0
INDIRI4
ASGNI4
line 934
;934:  if (type == CGAME_EVENT_NONE) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $673
line 935
;935:    CG_HideTeamMenu();
ADDRGP4 CG_HideTeamMenu
CALLV
pop
line 936
;936:  } else if (type == CGAME_EVENT_TEAMMENU) {
ADDRGP4 $674
JUMPV
LABELV $673
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $675
line 938
;937:    //CG_ShowTeamMenu();
;938:  } else if (type == CGAME_EVENT_SCOREBOARD) {
ADDRGP4 $676
JUMPV
LABELV $675
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $677
line 939
;939:  }
LABELV $677
LABELV $676
LABELV $674
line 941
;940:
;941:}
LABELV $671
endproc CG_EventHandling 0 0
export CG_KeyEvent
proc CG_KeyEvent 8 16
line 945
;942:
;943:
;944:
;945:void CG_KeyEvent(int key, qboolean down) {
line 947
;946:
;947:	if (!down) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $680
line 948
;948:		return;
ADDRGP4 $679
JUMPV
LABELV $680
line 951
;949:	}
;950:
;951:	if ( cg.predictedPlayerState.pm_type == PM_NORMAL || cg.predictedPlayerState.pm_type == PM_NORMAL || (cg.predictedPlayerState.pm_type == PM_SPECTATOR && cg.showScores == qfalse)) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 cg+96+4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $692
ADDRGP4 cg+96+4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $692
ADDRGP4 cg+96+4
INDIRI4
CNSTI4 3
NEI4 $682
ADDRGP4 cg+6972
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $682
LABELV $692
line 952
;952:		CG_EventHandling(CGAME_EVENT_NONE);
CNSTI4 0
ARGI4
ADDRGP4 CG_EventHandling
CALLV
pop
line 953
;953:    trap_Key_SetCatcher(0);
CNSTI4 0
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 954
;954:		return;
ADDRGP4 $679
JUMPV
LABELV $682
line 965
;955:	}
;956:
;957:  //if (key == trap_Key_GetKey("teamMenu") || !Display_CaptureItem(cgs.cursorX, cgs.cursorY)) {
;958:    // if we see this then we should always be visible
;959:  //  CG_EventHandling(CGAME_EVENT_NONE);
;960:  //  trap_Key_SetCatcher(0);
;961:  //}
;962:
;963:
;964:
;965:  Display_HandleKey(key, down, cgs.cursorX, cgs.cursorY);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+70192
INDIRI4
ARGI4
ADDRGP4 cgs+70196
INDIRI4
ARGI4
ADDRGP4 Display_HandleKey
CALLV
pop
line 967
;966:
;967:	if (cgs.capturedItem) {
ADDRGP4 cgs+70212
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $695
line 968
;968:		cgs.capturedItem = NULL;
ADDRGP4 cgs+70212
CNSTP4 0
ASGNP4
line 969
;969:	}	else {
ADDRGP4 $696
JUMPV
LABELV $695
line 970
;970:		if (key == K_MOUSE2 && down) {
ADDRFP4 0
INDIRI4
CNSTI4 179
NEI4 $699
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $699
line 971
;971:			cgs.capturedItem = Display_CaptureItem(cgs.cursorX, cgs.cursorY);
ADDRGP4 cgs+70192
INDIRI4
ARGI4
ADDRGP4 cgs+70196
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Display_CaptureItem
CALLP4
ASGNP4
ADDRGP4 cgs+70212
ADDRLP4 4
INDIRP4
ASGNP4
line 972
;972:		}
LABELV $699
line 973
;973:	}
LABELV $696
line 974
;974:}
LABELV $679
endproc CG_KeyEvent 8 16
export CG_ClientNumFromName
proc CG_ClientNumFromName 12 8
line 976
;975:
;976:int CG_ClientNumFromName(const char *p) {
line 978
;977:  int i;
;978:  for (i = 0; i < cgs.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $708
JUMPV
LABELV $705
line 979
;979:    if (cgs.clientinfo[i].infoValid && Q_stricmp(cgs.clientinfo[i].name, p) == 0) {
ADDRLP4 4
CNSTI4 788
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+43008
ADDP4
INDIRI4
CNSTI4 0
EQI4 $710
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+43008+4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $710
line 980
;980:      return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $704
JUMPV
LABELV $710
line 982
;981:    }
;982:  }
LABELV $706
line 978
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $708
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+32988
INDIRI4
LTI4 $705
line 983
;983:  return -1;
CNSTI4 -1
RETI4
LABELV $704
endproc CG_ClientNumFromName 12 8
export CG_ShowResponseHead
proc CG_ShowResponseHead 0 8
line 986
;984:}
;985:
;986:void CG_ShowResponseHead(void) {
line 987
;987:  Menus_OpenByName("voiceMenu");
ADDRGP4 $716
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 988
;988:	trap_Cvar_Set("cl_conXOffset", "72");
ADDRGP4 $717
ARGP4
ADDRGP4 $718
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 989
;989:	cg.voiceTime = cg.time;
ADDRGP4 cg+13104
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 990
;990:}
LABELV $715
endproc CG_ShowResponseHead 0 8
export CG_RunMenuScript
proc CG_RunMenuScript 0 0
line 992
;991:
;992:void CG_RunMenuScript(char **args) {
line 993
;993:}
LABELV $721
endproc CG_RunMenuScript 0 0
export CG_DeferMenuScript
proc CG_DeferMenuScript 0 0
line 996
;994:
;995:qboolean CG_DeferMenuScript (char **args) 
;996:{
line 997
;997:	return qfalse;
CNSTI4 0
RETI4
LABELV $722
endproc CG_DeferMenuScript 0 0
export CG_GetTeamColor
proc CG_GetTeamColor 8 0
line 1000
;998:}
;999:
;1000:void CG_GetTeamColor(vec4_t *color) {
line 1001
;1001:  if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 1
NEI4 $724
line 1002
;1002:    (*color)[0] = 1.0f;
ADDRFP4 0
INDIRP4
CNSTF4 1065353216
ASGNF4
line 1003
;1003:    (*color)[3] = 0.25f;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1048576000
ASGNF4
line 1004
;1004:    (*color)[1] = (*color)[2] = 0.0f;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1005
;1005:  } else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 $725
JUMPV
LABELV $724
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 2
NEI4 $727
line 1006
;1006:    (*color)[0] = (*color)[1] = 0.0f;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1007
;1007:    (*color)[2] = 1.0f;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 1008
;1008:    (*color)[3] = 0.25f;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1048576000
ASGNF4
line 1009
;1009:  } else {
ADDRGP4 $728
JUMPV
LABELV $727
line 1010
;1010:    (*color)[0] = (*color)[2] = 0.0f;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1011
;1011:    (*color)[1] = 0.17f;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1043207291
ASGNF4
line 1012
;1012:    (*color)[3] = 0.25f;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1048576000
ASGNF4
line 1013
;1013:	}
LABELV $728
LABELV $725
line 1014
;1014:}
LABELV $723
endproc CG_GetTeamColor 8 0
import MenuFontToHandle
import cgDC
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
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
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
LABELV $718
char 1 55
char 1 50
char 1 0
align 1
LABELV $717
char 1 99
char 1 108
char 1 95
char 1 99
char 1 111
char 1 110
char 1 88
char 1 79
char 1 102
char 1 102
char 1 115
char 1 101
char 1 116
char 1 0
align 1
LABELV $716
char 1 118
char 1 111
char 1 105
char 1 99
char 1 101
char 1 77
char 1 101
char 1 110
char 1 117
char 1 0
align 1
LABELV $669
char 1 103
char 1 101
char 1 116
char 1 77
char 1 101
char 1 110
char 1 117
char 1 0
align 1
LABELV $668
char 1 116
char 1 101
char 1 97
char 1 109
char 1 77
char 1 101
char 1 110
char 1 117
char 1 0
align 1
LABELV $614
char 1 87
char 1 111
char 1 119
char 1 0
align 1
LABELV $611
char 1 37
char 1 105
char 1 0
align 1
LABELV $608
char 1 37
char 1 105
char 1 37
char 1 37
char 1 0
align 1
LABELV $519
char 1 117
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 0
align 1
LABELV $452
char 1 67
char 1 97
char 1 112
char 1 116
char 1 117
char 1 114
char 1 101
char 1 32
char 1 116
char 1 104
char 1 101
char 1 32
char 1 89
char 1 115
char 1 97
char 1 108
char 1 97
char 1 109
char 1 105
char 1 114
char 1 105
char 1 0
align 1
LABELV $448
char 1 67
char 1 97
char 1 112
char 1 116
char 1 117
char 1 114
char 1 101
char 1 32
char 1 116
char 1 104
char 1 101
char 1 32
char 1 70
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $444
char 1 78
char 1 47
char 1 65
char 1 0
align 1
LABELV $440
char 1 84
char 1 101
char 1 97
char 1 109
char 1 32
char 1 70
char 1 70
char 1 65
char 1 0
align 1
LABELV $436
char 1 74
char 1 101
char 1 100
char 1 105
char 1 32
char 1 77
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 0
align 1
LABELV $432
char 1 72
char 1 111
char 1 108
char 1 111
char 1 99
char 1 114
char 1 111
char 1 110
char 1 32
char 1 70
char 1 70
char 1 65
char 1 0
align 1
LABELV $428
char 1 70
char 1 114
char 1 101
char 1 101
char 1 32
char 1 70
char 1 111
char 1 114
char 1 32
char 1 65
char 1 108
char 1 108
char 1 0
align 1
LABELV $420
char 1 66
char 1 108
char 1 117
char 1 101
char 1 32
char 1 108
char 1 101
char 1 97
char 1 100
char 1 115
char 1 32
char 1 82
char 1 101
char 1 100
char 1 44
char 1 32
char 1 37
char 1 105
char 1 32
char 1 116
char 1 111
char 1 32
char 1 37
char 1 105
char 1 0
align 1
LABELV $416
char 1 82
char 1 101
char 1 100
char 1 32
char 1 108
char 1 101
char 1 97
char 1 100
char 1 115
char 1 32
char 1 66
char 1 108
char 1 117
char 1 101
char 1 44
char 1 32
char 1 37
char 1 105
char 1 32
char 1 116
char 1 111
char 1 32
char 1 37
char 1 105
char 1 0
align 1
LABELV $409
char 1 84
char 1 101
char 1 97
char 1 109
char 1 115
char 1 32
char 1 97
char 1 114
char 1 101
char 1 32
char 1 116
char 1 105
char 1 101
char 1 100
char 1 32
char 1 97
char 1 116
char 1 32
char 1 37
char 1 105
char 1 0
align 1
LABELV $401
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 32
char 1 37
char 1 105
char 1 0
align 1
LABELV $400
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
LABELV $390
char 1 75
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 66
char 1 89
char 1 0
align 1
LABELV $389
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
LABELV $388
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $384
char 1 0
align 1
LABELV $201
char 1 69
char 1 118
char 1 101
char 1 114
char 1 121
char 1 111
char 1 110
char 1 101
char 1 0
align 1
LABELV $198
char 1 37
char 1 100
char 1 0
align 1
LABELV $197
char 1 99
char 1 103
char 1 95
char 1 115
char 1 101
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 0
align 1
LABELV $196
char 1 99
char 1 103
char 1 95
char 1 115
char 1 101
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $182
char 1 99
char 1 109
char 1 100
char 1 32
char 1 118
char 1 116
char 1 101
char 1 108
char 1 108
char 1 32
char 1 37
char 1 100
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $178
char 1 116
char 1 101
char 1 97
char 1 109
char 1 116
char 1 97
char 1 115
char 1 107
char 1 32
char 1 37
char 1 105
char 1 10
char 1 0
align 1
LABELV $173
char 1 99
char 1 109
char 1 100
char 1 32
char 1 118
char 1 115
char 1 97
char 1 121
char 1 95
char 1 116
char 1 101
char 1 97
char 1 109
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $167
char 1 102
char 1 111
char 1 108
char 1 108
char 1 111
char 1 119
char 1 102
char 1 108
char 1 97
char 1 103
char 1 99
char 1 97
char 1 114
char 1 114
char 1 105
char 1 101
char 1 114
char 1 0
align 1
LABELV $166
char 1 111
char 1 110
char 1 102
char 1 111
char 1 108
char 1 108
char 1 111
char 1 119
char 1 99
char 1 97
char 1 114
char 1 114
char 1 105
char 1 101
char 1 114
char 1 0
align 1
LABELV $164
char 1 114
char 1 101
char 1 116
char 1 117
char 1 114
char 1 110
char 1 102
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $163
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
LABELV $161
char 1 99
char 1 97
char 1 109
char 1 112
char 1 0
align 1
LABELV $160
char 1 111
char 1 110
char 1 99
char 1 97
char 1 109
char 1 112
char 1 0
align 1
LABELV $158
char 1 43
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 49
char 1 48
char 1 59
char 1 32
char 1 119
char 1 97
char 1 105
char 1 116
char 1 59
char 1 32
char 1 45
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 49
char 1 48
char 1 0
align 1
LABELV $157
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
LABELV $156
char 1 111
char 1 110
char 1 102
char 1 111
char 1 108
char 1 108
char 1 111
char 1 119
char 1 0
align 1
LABELV $154
char 1 43
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 57
char 1 59
char 1 32
char 1 119
char 1 97
char 1 105
char 1 116
char 1 59
char 1 32
char 1 45
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 57
char 1 0
align 1
LABELV $153
char 1 112
char 1 97
char 1 116
char 1 114
char 1 111
char 1 108
char 1 0
align 1
LABELV $152
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
LABELV $150
char 1 43
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 56
char 1 59
char 1 32
char 1 119
char 1 97
char 1 105
char 1 116
char 1 59
char 1 32
char 1 45
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 56
char 1 0
align 1
LABELV $149
char 1 100
char 1 101
char 1 102
char 1 101
char 1 110
char 1 100
char 1 0
align 1
LABELV $148
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
LABELV $146
char 1 43
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 55
char 1 59
char 1 32
char 1 119
char 1 97
char 1 105
char 1 116
char 1 59
char 1 32
char 1 45
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 55
char 1 0
align 1
LABELV $145
char 1 111
char 1 102
char 1 102
char 1 101
char 1 110
char 1 115
char 1 101
char 1 0
align 1
LABELV $144
char 1 111
char 1 110
char 1 111
char 1 102
char 1 102
char 1 101
char 1 110
char 1 115
char 1 101
char 1 0
