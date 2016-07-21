export CG_TargetCommand_f
code
proc CG_TargetCommand_f 20 12
file "../cg_consolecmds.c"
line 12
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_consolecmds.c -- text commands typed in at the local console, or
;4:// executed by a key binding
;5:
;6:#include "cg_local.h"
;7:#include "../ui/ui_shared.h"
;8:extern menuDef_t *menuScoreboard;
;9:
;10:
;11:
;12:void CG_TargetCommand_f( void ) {
line 16
;13:	int		targetNum;
;14:	char	test[4];
;15:
;16:	targetNum = CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 17
;17:	if (!targetNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $130
line 18
;18:		return;
ADDRGP4 $129
JUMPV
LABELV $130
line 21
;19:	}
;20:
;21:	trap_Argv( 1, test, 4 );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 22
;22:	trap_SendConsoleCommand( va( "gc %i %i", targetNum, atoi( test ) ) );
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $132
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 23
;23:}
LABELV $129
endproc CG_TargetCommand_f 20 12
proc CG_SizeUp_f 4 8
line 34
;24:
;25:
;26:
;27:/*
;28:=================
;29:CG_SizeUp_f
;30:
;31:Keybinding command
;32:=================
;33:*/
;34:static void CG_SizeUp_f (void) {
line 35
;35:	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer+10)));
ADDRGP4 $135
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
ADDI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $134
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 36
;36:}
LABELV $133
endproc CG_SizeUp_f 4 8
proc CG_SizeDown_f 4 8
line 46
;37:
;38:
;39:/*
;40:=================
;41:CG_SizeDown_f
;42:
;43:Keybinding command
;44:=================
;45:*/
;46:static void CG_SizeDown_f (void) {
line 47
;47:	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer-10)));
ADDRGP4 $135
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
SUBI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $134
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 48
;48:}
LABELV $137
endproc CG_SizeDown_f 4 8
proc CG_Viewpos_f 0 24
line 58
;49:
;50:
;51:/*
;52:=============
;53:CG_Viewpos_f
;54:
;55:Debugging command to print the current position
;56:=============
;57:*/
;58:static void CG_Viewpos_f (void) {
line 59
;59:	CG_Printf ("%s (%i %i %i) : %i\n", cgs.mapname, (int)cg.refdef.vieworg[0],
ADDRGP4 $140
ARGP4
ADDRGP4 cgs+32992
ARGP4
ADDRGP4 cg+3604+24
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+3604+24+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+3604+24+8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+3972+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 62
;60:		(int)cg.refdef.vieworg[1], (int)cg.refdef.vieworg[2], 
;61:		(int)cg.refdefViewAngles[YAW]);
;62:}
LABELV $139
endproc CG_Viewpos_f 0 24
proc CG_ScoresDown_f 0 4
line 65
;63:
;64:
;65:static void CG_ScoresDown_f( void ) {
line 67
;66:
;67:	CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 68
;68:	if ( cg.scoresRequestTime + 2000 < cg.time ) {
ADDRGP4 cg+5032
INDIRI4
CNSTI4 2000
ADDI4
ADDRGP4 cg+64
INDIRI4
GEI4 $153
line 71
;69:		// the scores are more than two seconds out of data,
;70:		// so request new ones
;71:		cg.scoresRequestTime = cg.time;
ADDRGP4 cg+5032
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 72
;72:		trap_SendClientCommand( "score" );
ADDRGP4 $159
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 76
;73:
;74:		// leave the current scores up if they were already
;75:		// displayed, but if this is the first hit, clear them out
;76:		if ( !cg.showScores ) {
ADDRGP4 cg+6972
INDIRI4
CNSTI4 0
NEI4 $154
line 77
;77:			cg.showScores = qtrue;
ADDRGP4 cg+6972
CNSTI4 1
ASGNI4
line 78
;78:			cg.numScores = 0;
ADDRGP4 cg+5036
CNSTI4 0
ASGNI4
line 79
;79:		}
line 80
;80:	} else {
ADDRGP4 $154
JUMPV
LABELV $153
line 83
;81:		// show the cached contents even if they just pressed if it
;82:		// is within two seconds
;83:		cg.showScores = qtrue;
ADDRGP4 cg+6972
CNSTI4 1
ASGNI4
line 84
;84:	}
LABELV $154
line 85
;85:}
LABELV $152
endproc CG_ScoresDown_f 0 4
proc CG_ScoresUp_f 0 0
line 87
;86:
;87:static void CG_ScoresUp_f( void ) {
line 88
;88:	if ( cg.showScores ) {
ADDRGP4 cg+6972
INDIRI4
CNSTI4 0
EQI4 $167
line 89
;89:		cg.showScores = qfalse;
ADDRGP4 cg+6972
CNSTI4 0
ASGNI4
line 90
;90:		cg.scoreFadeTime = cg.time;
ADDRGP4 cg+6980
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 91
;91:	}
LABELV $167
line 92
;92:}
LABELV $166
endproc CG_ScoresUp_f 0 0
proc CG_scrollScoresDown_f 0 12
line 97
;93:
;94:extern menuDef_t *menuScoreboard;
;95:void Menu_Reset();			// FIXME: add to right include file
;96:
;97:static void CG_scrollScoresDown_f( void) {
line 98
;98:	if (menuScoreboard && cg.scoreBoardShowing) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $174
ADDRGP4 cg+6976
INDIRI4
CNSTI4 0
EQI4 $174
line 99
;99:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qtrue);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 11
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 100
;100:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qtrue);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 5
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 101
;101:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qtrue);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 6
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 102
;102:	}
LABELV $174
line 103
;103:}
LABELV $173
endproc CG_scrollScoresDown_f 0 12
proc CG_scrollScoresUp_f 0 12
line 106
;104:
;105:
;106:static void CG_scrollScoresUp_f( void) {
line 107
;107:	if (menuScoreboard && cg.scoreBoardShowing) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $178
ADDRGP4 cg+6976
INDIRI4
CNSTI4 0
EQI4 $178
line 108
;108:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qfalse);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 11
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 109
;109:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qfalse);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 5
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 110
;110:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qfalse);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 6
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 111
;111:	}
LABELV $178
line 112
;112:}
LABELV $177
endproc CG_scrollScoresUp_f 0 12
proc CG_spWin_f 0 12
line 115
;113:
;114:
;115:static void CG_spWin_f( void) {
line 116
;116:	trap_Cvar_Set("cg_cameraOrbit", "2");
ADDRGP4 $182
ARGP4
ADDRGP4 $183
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 117
;117:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
ADDRGP4 $184
ARGP4
ADDRGP4 $185
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 118
;118:	trap_Cvar_Set("cg_thirdPerson", "1");
ADDRGP4 $186
ARGP4
ADDRGP4 $187
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 119
;119:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
ADDRGP4 $188
ARGP4
ADDRGP4 $189
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 120
;120:	trap_Cvar_Set("cg_thirdPersonRange", "100");
ADDRGP4 $190
ARGP4
ADDRGP4 $191
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 121
;121:	CG_AddBufferedSound(cgs.media.winnerSound);
ADDRGP4 cgs+70280+680
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 123
;122:	//trap_S_StartLocalSound(cgs.media.winnerSound, CHAN_ANNOUNCER);
;123:	CG_CenterPrint("YOU WIN!", SCREEN_HEIGHT * .30, 0);
ADDRGP4 $194
ARGP4
CNSTI4 144
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 124
;124:}
LABELV $181
endproc CG_spWin_f 0 12
proc CG_spLose_f 0 12
line 126
;125:
;126:static void CG_spLose_f( void) {
line 127
;127:	trap_Cvar_Set("cg_cameraOrbit", "2");
ADDRGP4 $182
ARGP4
ADDRGP4 $183
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 128
;128:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
ADDRGP4 $184
ARGP4
ADDRGP4 $185
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 129
;129:	trap_Cvar_Set("cg_thirdPerson", "1");
ADDRGP4 $186
ARGP4
ADDRGP4 $187
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 130
;130:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
ADDRGP4 $188
ARGP4
ADDRGP4 $189
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 131
;131:	trap_Cvar_Set("cg_thirdPersonRange", "100");
ADDRGP4 $190
ARGP4
ADDRGP4 $191
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 132
;132:	CG_AddBufferedSound(cgs.media.loserSound);
ADDRGP4 cgs+70280+684
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 134
;133:	//trap_S_StartLocalSound(cgs.media.loserSound, CHAN_ANNOUNCER);
;134:	CG_CenterPrint("YOU LOSE...", SCREEN_HEIGHT * .30, 0);
ADDRGP4 $198
ARGP4
CNSTI4 144
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 135
;135:}
LABELV $195
endproc CG_spLose_f 0 12
proc CG_TellTarget_f 264 20
line 138
;136:
;137:
;138:static void CG_TellTarget_f( void ) {
line 143
;139:	int		clientNum;
;140:	char	command[128];
;141:	char	message[128];
;142:
;143:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 144
;144:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $200
line 145
;145:		return;
ADDRGP4 $199
JUMPV
LABELV $200
line 148
;146:	}
;147:
;148:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 149
;149:	Com_sprintf( command, 128, "tell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $202
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 150
;150:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 151
;151:}
LABELV $199
endproc CG_TellTarget_f 264 20
proc CG_TellAttacker_f 264 20
line 153
;152:
;153:static void CG_TellAttacker_f( void ) {
line 158
;154:	int		clientNum;
;155:	char	command[128];
;156:	char	message[128];
;157:
;158:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 159
;159:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $204
line 160
;160:		return;
ADDRGP4 $203
JUMPV
LABELV $204
line 163
;161:	}
;162:
;163:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 164
;164:	Com_sprintf( command, 128, "tell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $202
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 165
;165:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 166
;166:}
LABELV $203
endproc CG_TellAttacker_f 264 20
proc CG_VoiceTellTarget_f 264 20
line 168
;167:
;168:static void CG_VoiceTellTarget_f( void ) {
line 173
;169:	int		clientNum;
;170:	char	command[128];
;171:	char	message[128];
;172:
;173:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 174
;174:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $207
line 175
;175:		return;
ADDRGP4 $206
JUMPV
LABELV $207
line 178
;176:	}
;177:
;178:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 179
;179:	Com_sprintf( command, 128, "vtell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $209
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 180
;180:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 181
;181:}
LABELV $206
endproc CG_VoiceTellTarget_f 264 20
proc CG_VoiceTellAttacker_f 264 20
line 183
;182:
;183:static void CG_VoiceTellAttacker_f( void ) {
line 188
;184:	int		clientNum;
;185:	char	command[128];
;186:	char	message[128];
;187:
;188:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 189
;189:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $211
line 190
;190:		return;
ADDRGP4 $210
JUMPV
LABELV $211
line 193
;191:	}
;192:
;193:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 194
;194:	Com_sprintf( command, 128, "vtell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $209
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 195
;195:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 196
;196:}
LABELV $210
endproc CG_VoiceTellAttacker_f 264 20
proc CG_NextTeamMember_f 0 0
line 198
;197:
;198:static void CG_NextTeamMember_f( void ) {
line 199
;199:  CG_SelectNextPlayer();
ADDRGP4 CG_SelectNextPlayer
CALLV
pop
line 200
;200:}
LABELV $213
endproc CG_NextTeamMember_f 0 0
proc CG_PrevTeamMember_f 0 0
line 202
;201:
;202:static void CG_PrevTeamMember_f( void ) {
line 203
;203:  CG_SelectPrevPlayer();
ADDRGP4 CG_SelectPrevPlayer
CALLV
pop
line 204
;204:}
LABELV $214
endproc CG_PrevTeamMember_f 0 0
proc CG_NextOrder_f 16 0
line 208
;205:
;206:// ASS U ME's enumeration order as far as task specific orders, OFFENSE is zero, CAMP is last
;207://
;208:static void CG_NextOrder_f( void ) {
line 209
;209:	clientInfo_t *ci = cgs.clientinfo + cg.snap->ps.clientNum;
ADDRLP4 0
CNSTI4 788
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 210
;210:	if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $218
line 211
;211:		if (!ci->teamLeader && sortedTeamPlayers[cg_currentSelectedPlayer.integer] != cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
NEI4 $220
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
EQI4 $220
line 212
;212:			return;
ADDRGP4 $215
JUMPV
LABELV $220
line 214
;213:		}
;214:	}
LABELV $218
line 215
;215:	if (cgs.currentOrder < TEAMTASK_CAMP) {
ADDRGP4 cgs+70220
INDIRI4
CNSTI4 7
GEI4 $224
line 216
;216:		cgs.currentOrder++;
ADDRLP4 4
ADDRGP4 cgs+70220
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 218
;217:
;218:		if (cgs.currentOrder == TEAMTASK_RETRIEVE) {
ADDRGP4 cgs+70220
INDIRI4
CNSTI4 5
NEI4 $228
line 219
;219:			if (!CG_OtherTeamHasFlag()) {
ADDRLP4 8
ADDRGP4 CG_OtherTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $231
line 220
;220:				cgs.currentOrder++;
ADDRLP4 12
ADDRGP4 cgs+70220
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 221
;221:			}
LABELV $231
line 222
;222:		}
LABELV $228
line 224
;223:
;224:		if (cgs.currentOrder == TEAMTASK_ESCORT) {
ADDRGP4 cgs+70220
INDIRI4
CNSTI4 6
NEI4 $225
line 225
;225:			if (!CG_YourTeamHasFlag()) {
ADDRLP4 8
ADDRGP4 CG_YourTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $225
line 226
;226:				cgs.currentOrder++;
ADDRLP4 12
ADDRGP4 cgs+70220
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 227
;227:			}
line 228
;228:		}
line 230
;229:
;230:	} else {
ADDRGP4 $225
JUMPV
LABELV $224
line 231
;231:		cgs.currentOrder = TEAMTASK_OFFENSE;
ADDRGP4 cgs+70220
CNSTI4 1
ASGNI4
line 232
;232:	}
LABELV $225
line 233
;233:	cgs.orderPending = qtrue;
ADDRGP4 cgs+70224
CNSTI4 1
ASGNI4
line 234
;234:	cgs.orderTime = cg.time + 3000;
ADDRGP4 cgs+70228
ADDRGP4 cg+64
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 235
;235:}
LABELV $215
endproc CG_NextOrder_f 16 0
proc CG_ConfirmOrder_f 8 12
line 238
;236:
;237:
;238:static void CG_ConfirmOrder_f (void ) {
line 239
;239:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_YES));
ADDRGP4 $245
ARGP4
ADDRGP4 cgs+70244
INDIRI4
ARGI4
ADDRGP4 $247
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 240
;240:	trap_SendConsoleCommand("+button5; wait; -button5");
ADDRGP4 $248
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 241
;241:	if (cg.time < cgs.acceptOrderTime) {
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgs+70236
INDIRI4
GEI4 $249
line 242
;242:		trap_SendClientCommand(va("teamtask %d\n", cgs.acceptTask));
ADDRGP4 $253
ARGP4
ADDRGP4 cgs+70240
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 243
;243:		cgs.acceptOrderTime = 0;
ADDRGP4 cgs+70236
CNSTI4 0
ASGNI4
line 244
;244:	}
LABELV $249
line 245
;245:}
LABELV $244
endproc CG_ConfirmOrder_f 8 12
proc CG_DenyOrder_f 4 12
line 247
;246:
;247:static void CG_DenyOrder_f (void ) {
line 248
;248:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_NO));
ADDRGP4 $245
ARGP4
ADDRGP4 cgs+70244
INDIRI4
ARGI4
ADDRGP4 $258
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 249
;249:	trap_SendConsoleCommand("+button6; wait; -button6");
ADDRGP4 $259
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 250
;250:	if (cg.time < cgs.acceptOrderTime) {
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgs+70236
INDIRI4
GEI4 $260
line 251
;251:		cgs.acceptOrderTime = 0;
ADDRGP4 cgs+70236
CNSTI4 0
ASGNI4
line 252
;252:	}
LABELV $260
line 253
;253:}
LABELV $256
endproc CG_DenyOrder_f 4 12
proc CG_TaskOffense_f 4 8
line 255
;254:
;255:static void CG_TaskOffense_f (void ) {
line 256
;256:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_CTY) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
EQI4 $270
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $266
LABELV $270
line 257
;257:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONGETFLAG));
ADDRGP4 $271
ARGP4
ADDRGP4 $272
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 258
;258:	} else {
ADDRGP4 $267
JUMPV
LABELV $266
line 259
;259:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONOFFENSE));
ADDRGP4 $271
ARGP4
ADDRGP4 $273
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 260
;260:	}
LABELV $267
line 261
;261:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_OFFENSE));
ADDRGP4 $253
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 262
;262:}
LABELV $265
endproc CG_TaskOffense_f 4 8
proc CG_TaskDefense_f 8 8
line 264
;263:
;264:static void CG_TaskDefense_f (void ) {
line 265
;265:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONDEFENSE));
ADDRGP4 $271
ARGP4
ADDRGP4 $275
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 266
;266:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_DEFENSE));
ADDRGP4 $253
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 267
;267:}
LABELV $274
endproc CG_TaskDefense_f 8 8
proc CG_TaskPatrol_f 8 8
line 269
;268:
;269:static void CG_TaskPatrol_f (void ) {
line 270
;270:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONPATROL));
ADDRGP4 $271
ARGP4
ADDRGP4 $277
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 271
;271:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_PATROL));
ADDRGP4 $253
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 272
;272:}
LABELV $276
endproc CG_TaskPatrol_f 8 8
proc CG_TaskCamp_f 8 8
line 274
;273:
;274:static void CG_TaskCamp_f (void ) {
line 275
;275:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONCAMPING));
ADDRGP4 $271
ARGP4
ADDRGP4 $279
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 276
;276:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_CAMP));
ADDRGP4 $253
ARGP4
CNSTI4 7
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 277
;277:}
LABELV $278
endproc CG_TaskCamp_f 8 8
proc CG_TaskFollow_f 8 8
line 279
;278:
;279:static void CG_TaskFollow_f (void ) {
line 280
;280:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOW));
ADDRGP4 $271
ARGP4
ADDRGP4 $281
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 281
;281:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_FOLLOW));
ADDRGP4 $253
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 282
;282:}
LABELV $280
endproc CG_TaskFollow_f 8 8
proc CG_TaskRetrieve_f 8 8
line 284
;283:
;284:static void CG_TaskRetrieve_f (void ) {
line 285
;285:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONRETURNFLAG));
ADDRGP4 $271
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 286
;286:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_RETRIEVE));
ADDRGP4 $253
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 287
;287:}
LABELV $282
endproc CG_TaskRetrieve_f 8 8
proc CG_TaskEscort_f 8 8
line 289
;288:
;289:static void CG_TaskEscort_f (void ) {
line 290
;290:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOWCARRIER));
ADDRGP4 $271
ARGP4
ADDRGP4 $285
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 291
;291:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_ESCORT));
ADDRGP4 $253
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 292
;292:}
LABELV $284
endproc CG_TaskEscort_f 8 8
proc CG_TaskOwnFlag_f 4 8
line 294
;293:
;294:static void CG_TaskOwnFlag_f (void ) {
line 295
;295:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_IHAVEFLAG));
ADDRGP4 $271
ARGP4
ADDRGP4 $287
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 296
;296:}
LABELV $286
endproc CG_TaskOwnFlag_f 4 8
proc CG_TauntKillInsult_f 0 4
line 298
;297:
;298:static void CG_TauntKillInsult_f (void ) {
line 299
;299:	trap_SendConsoleCommand("cmd vsay kill_insult\n");
ADDRGP4 $289
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 300
;300:}
LABELV $288
endproc CG_TauntKillInsult_f 0 4
proc CG_TauntPraise_f 0 4
line 302
;301:
;302:static void CG_TauntPraise_f (void ) {
line 303
;303:	trap_SendConsoleCommand("cmd vsay praise\n");
ADDRGP4 $291
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 304
;304:}
LABELV $290
endproc CG_TauntPraise_f 0 4
proc CG_TauntTaunt_f 0 4
line 306
;305:
;306:static void CG_TauntTaunt_f (void ) {
line 307
;307:	trap_SendConsoleCommand("cmd vtaunt\n");
ADDRGP4 $293
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 308
;308:}
LABELV $292
endproc CG_TauntTaunt_f 0 4
proc CG_TauntDeathInsult_f 0 4
line 310
;309:
;310:static void CG_TauntDeathInsult_f (void ) {
line 311
;311:	trap_SendConsoleCommand("cmd vsay death_insult\n");
ADDRGP4 $295
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 312
;312:}
LABELV $294
endproc CG_TauntDeathInsult_f 0 4
proc CG_TauntGauntlet_f 0 4
line 314
;313:
;314:static void CG_TauntGauntlet_f (void ) {
line 315
;315:	trap_SendConsoleCommand("cmd vsay kill_guantlet\n");
ADDRGP4 $297
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 316
;316:}
LABELV $296
endproc CG_TauntGauntlet_f 0 4
proc CG_TaskSuicide_f 136 16
line 318
;317:
;318:static void CG_TaskSuicide_f (void ) {
line 322
;319:	int		clientNum;
;320:	char	command[128];
;321:
;322:	clientNum = CG_CrosshairPlayer();
ADDRLP4 132
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 132
INDIRI4
ASGNI4
line 323
;323:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $299
line 324
;324:		return;
ADDRGP4 $298
JUMPV
LABELV $299
line 327
;325:	}
;326:
;327:	Com_sprintf( command, 128, "tell %i suicide", clientNum );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $301
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 328
;328:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 329
;329:}
LABELV $298
endproc CG_TaskSuicide_f 136 16
proc CG_StartOrbit_f 1028 12
line 369
;330:
;331:
;332:
;333:/*
;334:==================
;335:CG_TeamMenu_f
;336:==================
;337:*/
;338:/*
;339:static void CG_TeamMenu_f( void ) {
;340:  if (trap_Key_GetCatcher() & KEYCATCH_CGAME) {
;341:    CG_EventHandling(CGAME_EVENT_NONE);
;342:    trap_Key_SetCatcher(0);
;343:  } else {
;344:    CG_EventHandling(CGAME_EVENT_TEAMMENU);
;345:    //trap_Key_SetCatcher(KEYCATCH_CGAME);
;346:  }
;347:}
;348:*/
;349:
;350:/*
;351:==================
;352:CG_EditHud_f
;353:==================
;354:*/
;355:/*
;356:static void CG_EditHud_f( void ) {
;357:  //cls.keyCatchers ^= KEYCATCH_CGAME;
;358:  //VM_Call (cgvm, CG_EVENT_HANDLING, (cls.keyCatchers & KEYCATCH_CGAME) ? CGAME_EVENT_EDITHUD : CGAME_EVENT_NONE);
;359:}
;360:*/
;361:
;362:
;363:/*
;364:==================
;365:CG_StartOrbit_f
;366:==================
;367:*/
;368:
;369:static void CG_StartOrbit_f( void ) {
line 372
;370:	char var[MAX_TOKEN_CHARS];
;371:
;372:	trap_Cvar_VariableStringBuffer( "developer", var, sizeof( var ) );
ADDRGP4 $303
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 373
;373:	if ( !atoi(var) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1024
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
NEI4 $304
line 374
;374:		return;
ADDRGP4 $302
JUMPV
LABELV $304
line 376
;375:	}
;376:	if (cg_cameraOrbit.value != 0) {
ADDRGP4 cg_cameraOrbit+8
INDIRF4
CNSTF4 0
EQF4 $306
line 377
;377:		trap_Cvar_Set ("cg_cameraOrbit", "0");
ADDRGP4 $182
ARGP4
ADDRGP4 $189
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 378
;378:		trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $186
ARGP4
ADDRGP4 $189
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 379
;379:	} else {
ADDRGP4 $307
JUMPV
LABELV $306
line 380
;380:		trap_Cvar_Set("cg_cameraOrbit", "5");
ADDRGP4 $182
ARGP4
ADDRGP4 $309
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 381
;381:		trap_Cvar_Set("cg_thirdPerson", "1");
ADDRGP4 $186
ARGP4
ADDRGP4 $187
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 382
;382:		trap_Cvar_Set("cg_thirdPersonAngle", "0");
ADDRGP4 $188
ARGP4
ADDRGP4 $189
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 383
;383:		trap_Cvar_Set("cg_thirdPersonRange", "100");
ADDRGP4 $190
ARGP4
ADDRGP4 $191
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 384
;384:	}
LABELV $307
line 385
;385:}
LABELV $302
endproc CG_StartOrbit_f 1028 12
data
align 4
LABELV commands
address $311
address CG_TestGun_f
address $312
address CG_TestModel_f
address $313
address CG_TestModelNextFrame_f
address $314
address CG_TestModelPrevFrame_f
address $315
address CG_TestModelNextSkin_f
address $316
address CG_TestModelPrevSkin_f
address $317
address CG_Viewpos_f
address $318
address CG_ScoresDown_f
address $319
address CG_ScoresUp_f
address $320
address CG_SizeUp_f
address $321
address CG_SizeDown_f
address $322
address CG_NextWeapon_f
address $323
address CG_PrevWeapon_f
address $324
address CG_Weapon_f
address $325
address CG_TellTarget_f
address $326
address CG_TellAttacker_f
address $327
address CG_VoiceTellTarget_f
address $328
address CG_VoiceTellAttacker_f
address $329
address CG_TargetCommand_f
address $330
address CG_NextTeamMember_f
address $331
address CG_PrevTeamMember_f
address $332
address CG_NextOrder_f
address $333
address CG_ConfirmOrder_f
address $334
address CG_DenyOrder_f
address $335
address CG_TaskOffense_f
address $336
address CG_TaskDefense_f
address $337
address CG_TaskPatrol_f
address $338
address CG_TaskCamp_f
address $339
address CG_TaskFollow_f
address $340
address CG_TaskRetrieve_f
address $341
address CG_TaskEscort_f
address $342
address CG_TaskSuicide_f
address $343
address CG_TaskOwnFlag_f
address $344
address CG_TauntKillInsult_f
address $345
address CG_TauntPraise_f
address $346
address CG_TauntTaunt_f
address $347
address CG_TauntDeathInsult_f
address $348
address CG_TauntGauntlet_f
address $349
address CG_spWin_f
address $350
address CG_spLose_f
address $351
address CG_scrollScoresDown_f
address $352
address CG_scrollScoresUp_f
address $353
address CG_StartOrbit_f
address $354
address CG_LoadDeferredPlayers
address $355
address CG_NextInventory_f
address $356
address CG_PrevInventory_f
address $357
address CG_NextForcePower_f
address $358
address CG_PrevForcePower_f
export CG_ConsoleCommand
code
proc CG_ConsoleCommand 16 8
line 467
;386:
;387:/*
;388:static void CG_Camera_f( void ) {
;389:	char name[1024];
;390:	trap_Argv( 1, name, sizeof(name));
;391:	if (trap_loadCamera(name)) {
;392:		cg.cameraMode = qtrue;
;393:		trap_startCamera(cg.time);
;394:	} else {
;395:		CG_Printf ("Unable to load camera %s\n",name);
;396:	}
;397:}
;398:*/
;399:
;400:
;401:typedef struct {
;402:	char	*cmd;
;403:	void	(*function)(void);
;404:} consoleCommand_t;
;405:
;406:static consoleCommand_t	commands[] = {
;407:	{ "testgun", CG_TestGun_f },
;408:	{ "testmodel", CG_TestModel_f },
;409:	{ "nextframe", CG_TestModelNextFrame_f },
;410:	{ "prevframe", CG_TestModelPrevFrame_f },
;411:	{ "nextskin", CG_TestModelNextSkin_f },
;412:	{ "prevskin", CG_TestModelPrevSkin_f },
;413:	{ "viewpos", CG_Viewpos_f },
;414:	{ "+scores", CG_ScoresDown_f },
;415:	{ "-scores", CG_ScoresUp_f },
;416:	{ "sizeup", CG_SizeUp_f },
;417:	{ "sizedown", CG_SizeDown_f },
;418:	{ "weapnext", CG_NextWeapon_f },
;419:	{ "weapprev", CG_PrevWeapon_f },
;420:	{ "weapon", CG_Weapon_f },
;421:	{ "tell_target", CG_TellTarget_f },
;422:	{ "tell_attacker", CG_TellAttacker_f },
;423:	{ "vtell_target", CG_VoiceTellTarget_f },
;424:	{ "vtell_attacker", CG_VoiceTellAttacker_f },
;425:	{ "tcmd", CG_TargetCommand_f },
;426:	{ "nextTeamMember", CG_NextTeamMember_f },
;427:	{ "prevTeamMember", CG_PrevTeamMember_f },
;428:	{ "nextOrder", CG_NextOrder_f },
;429:	{ "confirmOrder", CG_ConfirmOrder_f },
;430:	{ "denyOrder", CG_DenyOrder_f },
;431:	{ "taskOffense", CG_TaskOffense_f },
;432:	{ "taskDefense", CG_TaskDefense_f },
;433:	{ "taskPatrol", CG_TaskPatrol_f },
;434:	{ "taskCamp", CG_TaskCamp_f },
;435:	{ "taskFollow", CG_TaskFollow_f },
;436:	{ "taskRetrieve", CG_TaskRetrieve_f },
;437:	{ "taskEscort", CG_TaskEscort_f },
;438:	{ "taskSuicide", CG_TaskSuicide_f },
;439:	{ "taskOwnFlag", CG_TaskOwnFlag_f },
;440:	{ "tauntKillInsult", CG_TauntKillInsult_f },
;441:	{ "tauntPraise", CG_TauntPraise_f },
;442:	{ "tauntTaunt", CG_TauntTaunt_f },
;443:	{ "tauntDeathInsult", CG_TauntDeathInsult_f },
;444:	{ "tauntGauntlet", CG_TauntGauntlet_f },
;445:	{ "spWin", CG_spWin_f },
;446:	{ "spLose", CG_spLose_f },
;447:	{ "scoresDown", CG_scrollScoresDown_f },
;448:	{ "scoresUp", CG_scrollScoresUp_f },
;449:	{ "startOrbit", CG_StartOrbit_f },
;450:	//{ "camera", CG_Camera_f },
;451:	{ "loaddeferred", CG_LoadDeferredPlayers },
;452:	{ "invnext", CG_NextInventory_f },
;453:	{ "invprev", CG_PrevInventory_f },
;454:	{ "forcenext", CG_NextForcePower_f },
;455:	{ "forceprev", CG_PrevForcePower_f }
;456:};
;457:
;458:
;459:/*
;460:=================
;461:CG_ConsoleCommand
;462:
;463:The string has been tokenized and can be retrieved with
;464:Cmd_Argc() / Cmd_Argv()
;465:=================
;466:*/
;467:qboolean CG_ConsoleCommand( void ) {
line 471
;468:	const char	*cmd;
;469:	int		i;
;470:
;471:	cmd = CG_Argv(0);
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 473
;472:
;473:	for ( i = 0 ; i < sizeof( commands ) / sizeof( commands[0] ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $363
JUMPV
LABELV $360
line 474
;474:		if ( !Q_stricmp( cmd, commands[i].cmd ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $364
line 475
;475:			commands[i].function();
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands+4
ADDP4
INDIRP4
CALLV
pop
line 476
;476:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $359
JUMPV
LABELV $364
line 478
;477:		}
;478:	}
LABELV $361
line 473
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $363
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 48
LTU4 $360
line 480
;479:
;480:	return qfalse;
CNSTI4 0
RETI4
LABELV $359
endproc CG_ConsoleCommand 16 8
export CG_InitConsoleCommands
proc CG_InitConsoleCommands 4 4
line 492
;481:}
;482:
;483:
;484:/*
;485:=================
;486:CG_InitConsoleCommands
;487:
;488:Let the client system know about all of our commands
;489:so it can perform tab completion
;490:=================
;491:*/
;492:void CG_InitConsoleCommands( void ) {
line 495
;493:	int		i;
;494:
;495:	for ( i = 0 ; i < sizeof( commands ) / sizeof( commands[0] ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $371
JUMPV
LABELV $368
line 496
;496:		trap_AddCommand( commands[i].cmd );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 497
;497:	}
LABELV $369
line 495
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $371
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 48
LTU4 $368
line 503
;498:
;499:	//
;500:	// the game server will interpret these commands, which will be automatically
;501:	// forwarded to the server after they are not recognized locally
;502:	//
;503:	trap_AddCommand ("forcechanged");
ADDRGP4 $372
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 504
;504:	trap_AddCommand ("sv_invnext");
ADDRGP4 $373
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 505
;505:	trap_AddCommand ("sv_invprev");
ADDRGP4 $374
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 506
;506:	trap_AddCommand ("sv_forcenext");
ADDRGP4 $375
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 507
;507:	trap_AddCommand ("sv_forceprev");
ADDRGP4 $376
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 508
;508:	trap_AddCommand ("sv_saberswitch");
ADDRGP4 $377
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 509
;509:	trap_AddCommand ("engage_duel");
ADDRGP4 $378
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 510
;510:	trap_AddCommand ("force_heal");
ADDRGP4 $379
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 511
;511:	trap_AddCommand ("force_speed");
ADDRGP4 $380
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 512
;512:	trap_AddCommand ("force_throw");
ADDRGP4 $381
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 513
;513:	trap_AddCommand ("force_pull");
ADDRGP4 $382
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 514
;514:	trap_AddCommand ("force_distract");
ADDRGP4 $383
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 515
;515:	trap_AddCommand ("force_rage");
ADDRGP4 $384
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 516
;516:	trap_AddCommand ("force_protect");
ADDRGP4 $385
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 517
;517:	trap_AddCommand ("force_absorb");
ADDRGP4 $386
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 518
;518:	trap_AddCommand ("force_healother");
ADDRGP4 $387
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 519
;519:	trap_AddCommand ("force_forcepowerother");
ADDRGP4 $388
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 520
;520:	trap_AddCommand ("force_seeing");
ADDRGP4 $389
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 521
;521:	trap_AddCommand ("use_seeker");
ADDRGP4 $390
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 522
;522:	trap_AddCommand ("use_field");
ADDRGP4 $391
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 523
;523:	trap_AddCommand ("use_bacta");
ADDRGP4 $392
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 524
;524:	trap_AddCommand ("use_electrobinoculars");
ADDRGP4 $393
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 525
;525:	trap_AddCommand ("zoom");
ADDRGP4 $394
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 526
;526:	trap_AddCommand ("use_sentry");
ADDRGP4 $395
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 527
;527:	trap_AddCommand ("bot_order");
ADDRGP4 $396
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 528
;528:	trap_AddCommand ("saberAttackCycle");
ADDRGP4 $397
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 529
;529:	trap_AddCommand ("kill");
ADDRGP4 $398
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 530
;530:	trap_AddCommand ("say");
ADDRGP4 $399
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 531
;531:	trap_AddCommand ("say_team");
ADDRGP4 $400
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 532
;532:	trap_AddCommand ("tell");
ADDRGP4 $401
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 533
;533:	trap_AddCommand ("vsay");
ADDRGP4 $402
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 534
;534:	trap_AddCommand ("vsay_team");
ADDRGP4 $403
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 535
;535:	trap_AddCommand ("vtell");
ADDRGP4 $404
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 536
;536:	trap_AddCommand ("vtaunt");
ADDRGP4 $405
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 537
;537:	trap_AddCommand ("vosay");
ADDRGP4 $406
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 538
;538:	trap_AddCommand ("vosay_team");
ADDRGP4 $407
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 539
;539:	trap_AddCommand ("votell");
ADDRGP4 $408
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 540
;540:	trap_AddCommand ("give");
ADDRGP4 $409
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 541
;541:	trap_AddCommand ("god");
ADDRGP4 $410
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 542
;542:	trap_AddCommand ("notarget");
ADDRGP4 $411
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 543
;543:	trap_AddCommand ("noclip");
ADDRGP4 $412
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 544
;544:	trap_AddCommand ("team");
ADDRGP4 $413
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 545
;545:	trap_AddCommand ("follow");
ADDRGP4 $414
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 546
;546:	trap_AddCommand ("levelshot");
ADDRGP4 $415
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 547
;547:	trap_AddCommand ("addbot");
ADDRGP4 $416
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 548
;548:	trap_AddCommand ("setviewpos");
ADDRGP4 $417
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 549
;549:	trap_AddCommand ("callvote");
ADDRGP4 $418
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 550
;550:	trap_AddCommand ("vote");
ADDRGP4 $419
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 551
;551:	trap_AddCommand ("callteamvote");
ADDRGP4 $420
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 552
;552:	trap_AddCommand ("teamvote");
ADDRGP4 $421
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 553
;553:	trap_AddCommand ("stats");
ADDRGP4 $422
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 554
;554:	trap_AddCommand ("teamtask");
ADDRGP4 $423
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 555
;555:	trap_AddCommand ("loaddefered");	// spelled wrong, but not changing for demo
ADDRGP4 $424
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 556
;556:}
LABELV $367
endproc CG_InitConsoleCommands 4 4
import menuScoreboard
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
LABELV $424
char 1 108
char 1 111
char 1 97
char 1 100
char 1 100
char 1 101
char 1 102
char 1 101
char 1 114
char 1 101
char 1 100
char 1 0
align 1
LABELV $423
char 1 116
char 1 101
char 1 97
char 1 109
char 1 116
char 1 97
char 1 115
char 1 107
char 1 0
align 1
LABELV $422
char 1 115
char 1 116
char 1 97
char 1 116
char 1 115
char 1 0
align 1
LABELV $421
char 1 116
char 1 101
char 1 97
char 1 109
char 1 118
char 1 111
char 1 116
char 1 101
char 1 0
align 1
LABELV $420
char 1 99
char 1 97
char 1 108
char 1 108
char 1 116
char 1 101
char 1 97
char 1 109
char 1 118
char 1 111
char 1 116
char 1 101
char 1 0
align 1
LABELV $419
char 1 118
char 1 111
char 1 116
char 1 101
char 1 0
align 1
LABELV $418
char 1 99
char 1 97
char 1 108
char 1 108
char 1 118
char 1 111
char 1 116
char 1 101
char 1 0
align 1
LABELV $417
char 1 115
char 1 101
char 1 116
char 1 118
char 1 105
char 1 101
char 1 119
char 1 112
char 1 111
char 1 115
char 1 0
align 1
LABELV $416
char 1 97
char 1 100
char 1 100
char 1 98
char 1 111
char 1 116
char 1 0
align 1
LABELV $415
char 1 108
char 1 101
char 1 118
char 1 101
char 1 108
char 1 115
char 1 104
char 1 111
char 1 116
char 1 0
align 1
LABELV $414
char 1 102
char 1 111
char 1 108
char 1 108
char 1 111
char 1 119
char 1 0
align 1
LABELV $413
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $412
char 1 110
char 1 111
char 1 99
char 1 108
char 1 105
char 1 112
char 1 0
align 1
LABELV $411
char 1 110
char 1 111
char 1 116
char 1 97
char 1 114
char 1 103
char 1 101
char 1 116
char 1 0
align 1
LABELV $410
char 1 103
char 1 111
char 1 100
char 1 0
align 1
LABELV $409
char 1 103
char 1 105
char 1 118
char 1 101
char 1 0
align 1
LABELV $408
char 1 118
char 1 111
char 1 116
char 1 101
char 1 108
char 1 108
char 1 0
align 1
LABELV $407
char 1 118
char 1 111
char 1 115
char 1 97
char 1 121
char 1 95
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $406
char 1 118
char 1 111
char 1 115
char 1 97
char 1 121
char 1 0
align 1
LABELV $405
char 1 118
char 1 116
char 1 97
char 1 117
char 1 110
char 1 116
char 1 0
align 1
LABELV $404
char 1 118
char 1 116
char 1 101
char 1 108
char 1 108
char 1 0
align 1
LABELV $403
char 1 118
char 1 115
char 1 97
char 1 121
char 1 95
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $402
char 1 118
char 1 115
char 1 97
char 1 121
char 1 0
align 1
LABELV $401
char 1 116
char 1 101
char 1 108
char 1 108
char 1 0
align 1
LABELV $400
char 1 115
char 1 97
char 1 121
char 1 95
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $399
char 1 115
char 1 97
char 1 121
char 1 0
align 1
LABELV $398
char 1 107
char 1 105
char 1 108
char 1 108
char 1 0
align 1
LABELV $397
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 65
char 1 116
char 1 116
char 1 97
char 1 99
char 1 107
char 1 67
char 1 121
char 1 99
char 1 108
char 1 101
char 1 0
align 1
LABELV $396
char 1 98
char 1 111
char 1 116
char 1 95
char 1 111
char 1 114
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $395
char 1 117
char 1 115
char 1 101
char 1 95
char 1 115
char 1 101
char 1 110
char 1 116
char 1 114
char 1 121
char 1 0
align 1
LABELV $394
char 1 122
char 1 111
char 1 111
char 1 109
char 1 0
align 1
LABELV $393
char 1 117
char 1 115
char 1 101
char 1 95
char 1 101
char 1 108
char 1 101
char 1 99
char 1 116
char 1 114
char 1 111
char 1 98
char 1 105
char 1 110
char 1 111
char 1 99
char 1 117
char 1 108
char 1 97
char 1 114
char 1 115
char 1 0
align 1
LABELV $392
char 1 117
char 1 115
char 1 101
char 1 95
char 1 98
char 1 97
char 1 99
char 1 116
char 1 97
char 1 0
align 1
LABELV $391
char 1 117
char 1 115
char 1 101
char 1 95
char 1 102
char 1 105
char 1 101
char 1 108
char 1 100
char 1 0
align 1
LABELV $390
char 1 117
char 1 115
char 1 101
char 1 95
char 1 115
char 1 101
char 1 101
char 1 107
char 1 101
char 1 114
char 1 0
align 1
LABELV $389
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 115
char 1 101
char 1 101
char 1 105
char 1 110
char 1 103
char 1 0
align 1
LABELV $388
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
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
char 1 111
char 1 116
char 1 104
char 1 101
char 1 114
char 1 0
align 1
LABELV $387
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
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
char 1 0
align 1
LABELV $386
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 97
char 1 98
char 1 115
char 1 111
char 1 114
char 1 98
char 1 0
align 1
LABELV $385
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 112
char 1 114
char 1 111
char 1 116
char 1 101
char 1 99
char 1 116
char 1 0
align 1
LABELV $384
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 114
char 1 97
char 1 103
char 1 101
char 1 0
align 1
LABELV $383
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 100
char 1 105
char 1 115
char 1 116
char 1 114
char 1 97
char 1 99
char 1 116
char 1 0
align 1
LABELV $382
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
char 1 0
align 1
LABELV $381
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 116
char 1 104
char 1 114
char 1 111
char 1 119
char 1 0
align 1
LABELV $380
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
char 1 0
align 1
LABELV $379
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 104
char 1 101
char 1 97
char 1 108
char 1 0
align 1
LABELV $378
char 1 101
char 1 110
char 1 103
char 1 97
char 1 103
char 1 101
char 1 95
char 1 100
char 1 117
char 1 101
char 1 108
char 1 0
align 1
LABELV $377
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
LABELV $376
char 1 115
char 1 118
char 1 95
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 112
char 1 114
char 1 101
char 1 118
char 1 0
align 1
LABELV $375
char 1 115
char 1 118
char 1 95
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 110
char 1 101
char 1 120
char 1 116
char 1 0
align 1
LABELV $374
char 1 115
char 1 118
char 1 95
char 1 105
char 1 110
char 1 118
char 1 112
char 1 114
char 1 101
char 1 118
char 1 0
align 1
LABELV $373
char 1 115
char 1 118
char 1 95
char 1 105
char 1 110
char 1 118
char 1 110
char 1 101
char 1 120
char 1 116
char 1 0
align 1
LABELV $372
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 99
char 1 104
char 1 97
char 1 110
char 1 103
char 1 101
char 1 100
char 1 0
align 1
LABELV $358
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 112
char 1 114
char 1 101
char 1 118
char 1 0
align 1
LABELV $357
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 110
char 1 101
char 1 120
char 1 116
char 1 0
align 1
LABELV $356
char 1 105
char 1 110
char 1 118
char 1 112
char 1 114
char 1 101
char 1 118
char 1 0
align 1
LABELV $355
char 1 105
char 1 110
char 1 118
char 1 110
char 1 101
char 1 120
char 1 116
char 1 0
align 1
LABELV $354
char 1 108
char 1 111
char 1 97
char 1 100
char 1 100
char 1 101
char 1 102
char 1 101
char 1 114
char 1 114
char 1 101
char 1 100
char 1 0
align 1
LABELV $353
char 1 115
char 1 116
char 1 97
char 1 114
char 1 116
char 1 79
char 1 114
char 1 98
char 1 105
char 1 116
char 1 0
align 1
LABELV $352
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 85
char 1 112
char 1 0
align 1
LABELV $351
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 68
char 1 111
char 1 119
char 1 110
char 1 0
align 1
LABELV $350
char 1 115
char 1 112
char 1 76
char 1 111
char 1 115
char 1 101
char 1 0
align 1
LABELV $349
char 1 115
char 1 112
char 1 87
char 1 105
char 1 110
char 1 0
align 1
LABELV $348
char 1 116
char 1 97
char 1 117
char 1 110
char 1 116
char 1 71
char 1 97
char 1 117
char 1 110
char 1 116
char 1 108
char 1 101
char 1 116
char 1 0
align 1
LABELV $347
char 1 116
char 1 97
char 1 117
char 1 110
char 1 116
char 1 68
char 1 101
char 1 97
char 1 116
char 1 104
char 1 73
char 1 110
char 1 115
char 1 117
char 1 108
char 1 116
char 1 0
align 1
LABELV $346
char 1 116
char 1 97
char 1 117
char 1 110
char 1 116
char 1 84
char 1 97
char 1 117
char 1 110
char 1 116
char 1 0
align 1
LABELV $345
char 1 116
char 1 97
char 1 117
char 1 110
char 1 116
char 1 80
char 1 114
char 1 97
char 1 105
char 1 115
char 1 101
char 1 0
align 1
LABELV $344
char 1 116
char 1 97
char 1 117
char 1 110
char 1 116
char 1 75
char 1 105
char 1 108
char 1 108
char 1 73
char 1 110
char 1 115
char 1 117
char 1 108
char 1 116
char 1 0
align 1
LABELV $343
char 1 116
char 1 97
char 1 115
char 1 107
char 1 79
char 1 119
char 1 110
char 1 70
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $342
char 1 116
char 1 97
char 1 115
char 1 107
char 1 83
char 1 117
char 1 105
char 1 99
char 1 105
char 1 100
char 1 101
char 1 0
align 1
LABELV $341
char 1 116
char 1 97
char 1 115
char 1 107
char 1 69
char 1 115
char 1 99
char 1 111
char 1 114
char 1 116
char 1 0
align 1
LABELV $340
char 1 116
char 1 97
char 1 115
char 1 107
char 1 82
char 1 101
char 1 116
char 1 114
char 1 105
char 1 101
char 1 118
char 1 101
char 1 0
align 1
LABELV $339
char 1 116
char 1 97
char 1 115
char 1 107
char 1 70
char 1 111
char 1 108
char 1 108
char 1 111
char 1 119
char 1 0
align 1
LABELV $338
char 1 116
char 1 97
char 1 115
char 1 107
char 1 67
char 1 97
char 1 109
char 1 112
char 1 0
align 1
LABELV $337
char 1 116
char 1 97
char 1 115
char 1 107
char 1 80
char 1 97
char 1 116
char 1 114
char 1 111
char 1 108
char 1 0
align 1
LABELV $336
char 1 116
char 1 97
char 1 115
char 1 107
char 1 68
char 1 101
char 1 102
char 1 101
char 1 110
char 1 115
char 1 101
char 1 0
align 1
LABELV $335
char 1 116
char 1 97
char 1 115
char 1 107
char 1 79
char 1 102
char 1 102
char 1 101
char 1 110
char 1 115
char 1 101
char 1 0
align 1
LABELV $334
char 1 100
char 1 101
char 1 110
char 1 121
char 1 79
char 1 114
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $333
char 1 99
char 1 111
char 1 110
char 1 102
char 1 105
char 1 114
char 1 109
char 1 79
char 1 114
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $332
char 1 110
char 1 101
char 1 120
char 1 116
char 1 79
char 1 114
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $331
char 1 112
char 1 114
char 1 101
char 1 118
char 1 84
char 1 101
char 1 97
char 1 109
char 1 77
char 1 101
char 1 109
char 1 98
char 1 101
char 1 114
char 1 0
align 1
LABELV $330
char 1 110
char 1 101
char 1 120
char 1 116
char 1 84
char 1 101
char 1 97
char 1 109
char 1 77
char 1 101
char 1 109
char 1 98
char 1 101
char 1 114
char 1 0
align 1
LABELV $329
char 1 116
char 1 99
char 1 109
char 1 100
char 1 0
align 1
LABELV $328
char 1 118
char 1 116
char 1 101
char 1 108
char 1 108
char 1 95
char 1 97
char 1 116
char 1 116
char 1 97
char 1 99
char 1 107
char 1 101
char 1 114
char 1 0
align 1
LABELV $327
char 1 118
char 1 116
char 1 101
char 1 108
char 1 108
char 1 95
char 1 116
char 1 97
char 1 114
char 1 103
char 1 101
char 1 116
char 1 0
align 1
LABELV $326
char 1 116
char 1 101
char 1 108
char 1 108
char 1 95
char 1 97
char 1 116
char 1 116
char 1 97
char 1 99
char 1 107
char 1 101
char 1 114
char 1 0
align 1
LABELV $325
char 1 116
char 1 101
char 1 108
char 1 108
char 1 95
char 1 116
char 1 97
char 1 114
char 1 103
char 1 101
char 1 116
char 1 0
align 1
LABELV $324
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 0
align 1
LABELV $323
char 1 119
char 1 101
char 1 97
char 1 112
char 1 112
char 1 114
char 1 101
char 1 118
char 1 0
align 1
LABELV $322
char 1 119
char 1 101
char 1 97
char 1 112
char 1 110
char 1 101
char 1 120
char 1 116
char 1 0
align 1
LABELV $321
char 1 115
char 1 105
char 1 122
char 1 101
char 1 100
char 1 111
char 1 119
char 1 110
char 1 0
align 1
LABELV $320
char 1 115
char 1 105
char 1 122
char 1 101
char 1 117
char 1 112
char 1 0
align 1
LABELV $319
char 1 45
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 0
align 1
LABELV $318
char 1 43
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 0
align 1
LABELV $317
char 1 118
char 1 105
char 1 101
char 1 119
char 1 112
char 1 111
char 1 115
char 1 0
align 1
LABELV $316
char 1 112
char 1 114
char 1 101
char 1 118
char 1 115
char 1 107
char 1 105
char 1 110
char 1 0
align 1
LABELV $315
char 1 110
char 1 101
char 1 120
char 1 116
char 1 115
char 1 107
char 1 105
char 1 110
char 1 0
align 1
LABELV $314
char 1 112
char 1 114
char 1 101
char 1 118
char 1 102
char 1 114
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $313
char 1 110
char 1 101
char 1 120
char 1 116
char 1 102
char 1 114
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $312
char 1 116
char 1 101
char 1 115
char 1 116
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 0
align 1
LABELV $311
char 1 116
char 1 101
char 1 115
char 1 116
char 1 103
char 1 117
char 1 110
char 1 0
align 1
LABELV $309
char 1 53
char 1 0
align 1
LABELV $303
char 1 100
char 1 101
char 1 118
char 1 101
char 1 108
char 1 111
char 1 112
char 1 101
char 1 114
char 1 0
align 1
LABELV $301
char 1 116
char 1 101
char 1 108
char 1 108
char 1 32
char 1 37
char 1 105
char 1 32
char 1 115
char 1 117
char 1 105
char 1 99
char 1 105
char 1 100
char 1 101
char 1 0
align 1
LABELV $297
char 1 99
char 1 109
char 1 100
char 1 32
char 1 118
char 1 115
char 1 97
char 1 121
char 1 32
char 1 107
char 1 105
char 1 108
char 1 108
char 1 95
char 1 103
char 1 117
char 1 97
char 1 110
char 1 116
char 1 108
char 1 101
char 1 116
char 1 10
char 1 0
align 1
LABELV $295
char 1 99
char 1 109
char 1 100
char 1 32
char 1 118
char 1 115
char 1 97
char 1 121
char 1 32
char 1 100
char 1 101
char 1 97
char 1 116
char 1 104
char 1 95
char 1 105
char 1 110
char 1 115
char 1 117
char 1 108
char 1 116
char 1 10
char 1 0
align 1
LABELV $293
char 1 99
char 1 109
char 1 100
char 1 32
char 1 118
char 1 116
char 1 97
char 1 117
char 1 110
char 1 116
char 1 10
char 1 0
align 1
LABELV $291
char 1 99
char 1 109
char 1 100
char 1 32
char 1 118
char 1 115
char 1 97
char 1 121
char 1 32
char 1 112
char 1 114
char 1 97
char 1 105
char 1 115
char 1 101
char 1 10
char 1 0
align 1
LABELV $289
char 1 99
char 1 109
char 1 100
char 1 32
char 1 118
char 1 115
char 1 97
char 1 121
char 1 32
char 1 107
char 1 105
char 1 108
char 1 108
char 1 95
char 1 105
char 1 110
char 1 115
char 1 117
char 1 108
char 1 116
char 1 10
char 1 0
align 1
LABELV $287
char 1 105
char 1 104
char 1 97
char 1 118
char 1 101
char 1 102
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $285
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
LABELV $283
char 1 111
char 1 110
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
LABELV $281
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
LABELV $279
char 1 111
char 1 110
char 1 99
char 1 97
char 1 109
char 1 112
char 1 0
align 1
LABELV $277
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
LABELV $275
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
LABELV $273
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
align 1
LABELV $272
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
LABELV $271
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
LABELV $259
char 1 43
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 54
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
char 1 54
char 1 0
align 1
LABELV $258
char 1 110
char 1 111
char 1 0
align 1
LABELV $253
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
char 1 100
char 1 10
char 1 0
align 1
LABELV $248
char 1 43
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 53
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
char 1 53
char 1 0
align 1
LABELV $247
char 1 121
char 1 101
char 1 115
char 1 0
align 1
LABELV $245
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
LABELV $209
char 1 118
char 1 116
char 1 101
char 1 108
char 1 108
char 1 32
char 1 37
char 1 105
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $202
char 1 116
char 1 101
char 1 108
char 1 108
char 1 32
char 1 37
char 1 105
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $198
char 1 89
char 1 79
char 1 85
char 1 32
char 1 76
char 1 79
char 1 83
char 1 69
char 1 46
char 1 46
char 1 46
char 1 0
align 1
LABELV $194
char 1 89
char 1 79
char 1 85
char 1 32
char 1 87
char 1 73
char 1 78
char 1 33
char 1 0
align 1
LABELV $191
char 1 49
char 1 48
char 1 48
char 1 0
align 1
LABELV $190
char 1 99
char 1 103
char 1 95
char 1 116
char 1 104
char 1 105
char 1 114
char 1 100
char 1 80
char 1 101
char 1 114
char 1 115
char 1 111
char 1 110
char 1 82
char 1 97
char 1 110
char 1 103
char 1 101
char 1 0
align 1
LABELV $189
char 1 48
char 1 0
align 1
LABELV $188
char 1 99
char 1 103
char 1 95
char 1 116
char 1 104
char 1 105
char 1 114
char 1 100
char 1 80
char 1 101
char 1 114
char 1 115
char 1 111
char 1 110
char 1 65
char 1 110
char 1 103
char 1 108
char 1 101
char 1 0
align 1
LABELV $187
char 1 49
char 1 0
align 1
LABELV $186
char 1 99
char 1 103
char 1 95
char 1 116
char 1 104
char 1 105
char 1 114
char 1 100
char 1 80
char 1 101
char 1 114
char 1 115
char 1 111
char 1 110
char 1 0
align 1
LABELV $185
char 1 51
char 1 53
char 1 0
align 1
LABELV $184
char 1 99
char 1 103
char 1 95
char 1 99
char 1 97
char 1 109
char 1 101
char 1 114
char 1 97
char 1 79
char 1 114
char 1 98
char 1 105
char 1 116
char 1 68
char 1 101
char 1 108
char 1 97
char 1 121
char 1 0
align 1
LABELV $183
char 1 50
char 1 0
align 1
LABELV $182
char 1 99
char 1 103
char 1 95
char 1 99
char 1 97
char 1 109
char 1 101
char 1 114
char 1 97
char 1 79
char 1 114
char 1 98
char 1 105
char 1 116
char 1 0
align 1
LABELV $159
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 0
align 1
LABELV $140
char 1 37
char 1 115
char 1 32
char 1 40
char 1 37
char 1 105
char 1 32
char 1 37
char 1 105
char 1 32
char 1 37
char 1 105
char 1 41
char 1 32
char 1 58
char 1 32
char 1 37
char 1 105
char 1 10
char 1 0
align 1
LABELV $135
char 1 37
char 1 105
char 1 0
align 1
LABELV $134
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
LABELV $132
char 1 103
char 1 99
char 1 32
char 1 37
char 1 105
char 1 32
char 1 37
char 1 105
char 1 0
