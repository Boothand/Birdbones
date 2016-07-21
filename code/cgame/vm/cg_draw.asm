data
export menuScoreboard
align 4
LABELV menuScoreboard
byte 4 0
export bluehudtint
align 4
LABELV bluehudtint
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
byte 4 1065353216
export redhudtint
align 4
LABELV redhudtint
byte 4 1065353216
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
export showPowersName
align 4
LABELV showPowersName
address $129
address $130
address $131
address $132
address $133
address $134
address $135
address $136
address $137
address $138
address $139
address $140
address $141
address $142
address $143
address $144
address $145
address $146
byte 4 0
export MenuFontToHandle
code
proc MenuFontToHandle 4 0
file "../cg_draw.c"
line 56
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_draw.c -- draw all of the graphical elements during
;4:// active (after loading) gameplay
;5:
;6:#include "cg_local.h"
;7:
;8:#include "../ui/ui_shared.h"
;9:
;10:qboolean CG_WorldCoordToScreenCoordFloat(vec3_t worldCoord, float *x, float *y);
;11:qboolean CG_CalcMuzzlePoint( int entityNum, vec3_t muzzle );
;12:
;13:// used for scoreboard
;14:extern displayContextDef_t cgDC;
;15:menuDef_t *menuScoreboard = NULL;
;16:vec4_t	bluehudtint = {0.5, 0.5, 1.0, 1.0};
;17:vec4_t	redhudtint = {1.0, 0.5, 0.5, 1.0};
;18:float	*hudTintColor;
;19:
;20:int sortedTeamPlayers[TEAM_MAXOVERLAY];
;21:int	numSortedTeamPlayers;
;22:
;23:int lastvalidlockdif;
;24:
;25:extern float zoomFov; //this has to be global client-side
;26:
;27:char systemChat[256];
;28:char teamChat1[256];
;29:char teamChat2[256];
;30:
;31:char *showPowersName[] = 
;32:{
;33:	"HEAL2",//FP_HEAL
;34:	"JUMP2",//FP_LEVITATION
;35:	"SPEED2",//FP_SPEED
;36:	"PUSH2",//FP_PUSH
;37:	"PULL2",//FP_PULL
;38:	"MINDTRICK2",//FP_TELEPTAHY
;39:	"GRIP2",//FP_GRIP
;40:	"LIGHTNING2",//FP_LIGHTNING
;41:	"DARK_RAGE2",//FP_RAGE
;42:	"PROTECT2",//FP_PROTECT
;43:	"ABSORB2",//FP_ABSORB
;44:	"TEAM_HEAL2",//FP_TEAM_HEAL
;45:	"TEAM_REPLENISH2",//FP_TEAM_FORCE
;46:	"DRAIN2",//FP_DRAIN
;47:	"SEEING2",//FP_SEE
;48:	"SABER_OFFENSE2",//FP_SABERATTACK
;49:	"SABER_DEFENSE2",//FP_SABERDEFEND
;50:	"SABER_THROW2",//FP_SABERTHROW
;51:	NULL
;52:};
;53:
;54:
;55:int MenuFontToHandle(int iMenuFont)
;56:{
line 57
;57:	switch (iMenuFont)
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $150
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $153
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $156
ADDRGP4 $148
JUMPV
line 58
;58:	{
LABELV $150
line 59
;59:		case FONT_SMALL:	return cgDC.Assets.qhSmallFont;
ADDRGP4 cgDC+252+12
INDIRI4
RETI4
ADDRGP4 $147
JUMPV
LABELV $153
line 60
;60:		case FONT_MEDIUM:	return cgDC.Assets.qhMediumFont;
ADDRGP4 cgDC+252+16
INDIRI4
RETI4
ADDRGP4 $147
JUMPV
LABELV $156
line 61
;61:		case FONT_LARGE:	return cgDC.Assets.qhBigFont;
ADDRGP4 cgDC+252+20
INDIRI4
RETI4
ADDRGP4 $147
JUMPV
LABELV $148
line 64
;62:	}
;63:
;64:	return cgDC.Assets.qhMediumFont;
ADDRGP4 cgDC+252+16
INDIRI4
RETI4
LABELV $147
endproc MenuFontToHandle 4 0
export CG_Text_Width
proc CG_Text_Width 12 12
line 68
;65:}
;66:
;67:int CG_Text_Width(const char *text, float scale, int iMenuFont) 
;68:{
line 69
;69:	int iFontIndex = MenuFontToHandle(iMenuFont);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 MenuFontToHandle
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 71
;70:
;71:	return trap_R_Font_StrLenPixels(text, iFontIndex, scale);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 trap_R_Font_StrLenPixels
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $161
endproc CG_Text_Width 12 12
export CG_Text_Height
proc CG_Text_Height 12 8
line 75
;72:}
;73:
;74:int CG_Text_Height(const char *text, float scale, int iMenuFont) 
;75:{
line 76
;76:	int iFontIndex = MenuFontToHandle(iMenuFont);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 MenuFontToHandle
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 78
;77:
;78:	return trap_R_Font_HeightPixels(iFontIndex, scale);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 trap_R_Font_HeightPixels
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $162
endproc CG_Text_Height 12 8
export CG_Text_Paint
proc CG_Text_Paint 20 28
line 83
;79:}
;80:
;81:#include "../qcommon/qfiles.h"	// for STYLE_BLINK etc
;82:void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style, int iMenuFont) 
;83:{
line 84
;84:	int iStyleOR = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 85
;85:	int iFontIndex = MenuFontToHandle(iMenuFont);
ADDRFP4 32
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 MenuFontToHandle
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 87
;86:	
;87:	switch (style)
ADDRLP4 12
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $196
ADDRLP4 12
INDIRI4
CNSTI4 6
GTI4 $196
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $205
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $205
address $198
address $199
address $200
address $201
address $202
address $203
address $204
code
line 88
;88:	{
LABELV $198
line 89
;89:	case  ITEM_TEXTSTYLE_NORMAL:			iStyleOR = 0;break;					// JK2 normal text
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $197
JUMPV
LABELV $199
line 90
;90:	case  ITEM_TEXTSTYLE_BLINK:				iStyleOR = STYLE_BLINK;break;		// JK2 fast blinking
ADDRLP4 0
CNSTI4 1073741824
ASGNI4
ADDRGP4 $197
JUMPV
LABELV $200
line 91
;91:	case  ITEM_TEXTSTYLE_PULSE:				iStyleOR = STYLE_BLINK;break;		// JK2 slow pulsing
ADDRLP4 0
CNSTI4 1073741824
ASGNI4
ADDRGP4 $197
JUMPV
LABELV $201
line 92
;92:	case  ITEM_TEXTSTYLE_SHADOWED:			iStyleOR = (int)STYLE_DROPSHADOW;break;	// JK2 drop shadow ( need a color for this )
ADDRLP4 0
CNSTU4 2147483648
CVUI4 4
ASGNI4
ADDRGP4 $197
JUMPV
LABELV $202
line 93
;93:	case  ITEM_TEXTSTYLE_OUTLINED:			iStyleOR = (int)STYLE_DROPSHADOW;break;	// JK2 drop shadow ( need a color for this )
ADDRLP4 0
CNSTU4 2147483648
CVUI4 4
ASGNI4
ADDRGP4 $197
JUMPV
LABELV $203
line 94
;94:	case  ITEM_TEXTSTYLE_OUTLINESHADOWED:	iStyleOR = (int)STYLE_DROPSHADOW;break;	// JK2 drop shadow ( need a color for this )
ADDRLP4 0
CNSTU4 2147483648
CVUI4 4
ASGNI4
ADDRGP4 $197
JUMPV
LABELV $204
line 95
;95:	case  ITEM_TEXTSTYLE_SHADOWEDMORE:		iStyleOR = (int)STYLE_DROPSHADOW;break;	// JK2 drop shadow ( need a color for this )
ADDRLP4 0
CNSTU4 2147483648
CVUI4 4
ASGNI4
LABELV $196
LABELV $197
line 98
;96:	}
;97:
;98:	trap_R_Font_DrawString(	x,		// int ox
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
BORI4
ARGI4
ADDRFP4 24
INDIRI4
CNSTI4 0
NEI4 $207
ADDRLP4 16
CNSTI4 -1
ASGNI4
ADDRGP4 $208
JUMPV
LABELV $207
ADDRLP4 16
ADDRFP4 24
INDIRI4
ASGNI4
LABELV $208
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 trap_R_Font_DrawString
CALLV
pop
line 106
;99:							y,		// int oy
;100:							text,	// const char *text
;101:							color,	// paletteRGBA_c c
;102:							iStyleOR | iFontIndex,	// const int iFontHandle
;103:							!limit?-1:limit,		// iCharLimit (-1 = none)
;104:							scale	// const float scale = 1.0f
;105:							);
;106:}
LABELV $195
endproc CG_Text_Paint 20 28
data
align 4
LABELV $210
byte 4 1
code
proc CG_DrawZoomMask 96 36
line 165
;107:
;108:/*
;109:qboolean CG_WorldCoordToScreenCoord(vec3_t worldCoord, int *x, int *y)
;110:
;111:  Take any world coord and convert it to a 2D virtual 640x480 screen coord
;112:*/
;113:/*
;114:qboolean CG_WorldCoordToScreenCoordFloat(vec3_t worldCoord, float *x, float *y)
;115:{
;116:	int	xcenter, ycenter;
;117:	vec3_t	local, transformed;
;118:
;119://	xcenter = cg.refdef.width / 2;//gives screen coords adjusted for resolution
;120://	ycenter = cg.refdef.height / 2;//gives screen coords adjusted for resolution
;121:	
;122:	//NOTE: did it this way because most draw functions expect virtual 640x480 coords
;123:	//	and adjust them for current resolution
;124:	xcenter = 640 / 2;//gives screen coords in virtual 640x480, to be adjusted when drawn
;125:	ycenter = 480 / 2;//gives screen coords in virtual 640x480, to be adjusted when drawn
;126:
;127:	VectorSubtract (worldCoord, cg.refdef.vieworg, local);
;128:
;129:	transformed[0] = DotProduct(local,vright);
;130:	transformed[1] = DotProduct(local,vup);
;131:	transformed[2] = DotProduct(local,vfwd);		
;132:
;133:	// Make sure Z is not negative.
;134:	if(transformed[2] < 0.01)
;135:	{
;136:		return qfalse;
;137:	}
;138:	// Simple convert to screen coords.
;139:	float xzi = xcenter / transformed[2] * (90.0/cg.refdef.fov_x);
;140:	float yzi = ycenter / transformed[2] * (90.0/cg.refdef.fov_y);
;141:
;142:	*x = xcenter + xzi * transformed[0];
;143:	*y = ycenter - yzi * transformed[1];
;144:
;145:	return qtrue;
;146:}
;147:
;148:qboolean CG_WorldCoordToScreenCoord( vec3_t worldCoord, int *x, int *y )
;149:{
;150:	float	xF, yF;
;151:	qboolean retVal = CG_WorldCoordToScreenCoordFloat( worldCoord, &xF, &yF );
;152:	*x = (int)xF;
;153:	*y = (int)yF;
;154:	return retVal;
;155:}
;156:*/
;157:
;158:/*
;159:================
;160:CG_DrawZoomMask
;161:
;162:================
;163:*/
;164:static void CG_DrawZoomMask( void )
;165:{
line 176
;166:	vec4_t		color1;
;167:	float		level;
;168:	static qboolean	flip = qtrue;
;169:
;170://	int ammo = cg_entities[0].gent->client->ps.ammo[weaponData[cent->currentState.weapon].ammoIndex];
;171:	float cx, cy;
;172://	int val[5];
;173:	float max, fi;
;174:
;175:	// Check for Binocular specific zooming since we'll want to render different bits in each case
;176:	if ( cg.predictedPlayerState.zoomMode == 2 )
ADDRGP4 cg+96+1320
INDIRI4
CNSTI4 2
NEI4 $211
line 177
;177:	{
line 182
;178:		int val, i;
;179:		float off;
;180:
;181:		// zoom level
;182:		level = (float)(80.0f - cg.predictedPlayerState.zoomFov) / 80.0f;
ADDRLP4 48
CNSTF4 1117782016
ASGNF4
ADDRLP4 32
ADDRLP4 48
INDIRF4
ADDRGP4 cg+96+1332
INDIRF4
SUBF4
ADDRLP4 48
INDIRF4
DIVF4
ASGNF4
line 185
;183:
;184:		// ...so we'll clamp it
;185:		if ( level < 0.0f )
ADDRLP4 32
INDIRF4
CNSTF4 0
GEF4 $217
line 186
;186:		{
line 187
;187:			level = 0.0f;
ADDRLP4 32
CNSTF4 0
ASGNF4
line 188
;188:		}
ADDRGP4 $218
JUMPV
LABELV $217
line 189
;189:		else if ( level > 1.0f )
ADDRLP4 32
INDIRF4
CNSTF4 1065353216
LEF4 $219
line 190
;190:		{
line 191
;191:			level = 1.0f;
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
line 192
;192:		}
LABELV $219
LABELV $218
line 195
;193:
;194:		// Using a magic number to convert the zoom level to scale amount
;195:		level *= 162.0f;
ADDRLP4 32
CNSTF4 1126301696
ADDRLP4 32
INDIRF4
MULF4
ASGNF4
line 198
;196:
;197:		// draw blue tinted distortion mask, trying to make it as small as is necessary to fill in the viewable area
;198:		trap_R_SetColor( colorTable[CT_WHITE] );
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 199
;199:		CG_DrawPic( 34, 48, 570, 362, cgs.media.binocularStatic );
CNSTF4 1107820544
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1141800960
ARGF4
CNSTF4 1135935488
ARGF4
ADDRGP4 cgs+70280+552
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 202
;200:	
;201:		// Black out the area behind the numbers
;202:		trap_R_SetColor( colorTable[CT_BLACK]);
ADDRGP4 colorTable+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 203
;203:		CG_DrawPic( 212, 367, 200, 40, cgs.media.whiteShader );
CNSTF4 1129578496
ARGF4
CNSTF4 1136099328
ARGF4
CNSTF4 1128792064
ARGF4
CNSTF4 1109393408
ARGF4
ADDRGP4 cgs+70280+4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 206
;204:
;205:		// Numbers should be kind of greenish
;206:		color1[0] = 0.2f;
ADDRLP4 0
CNSTF4 1045220557
ASGNF4
line 207
;207:		color1[1] = 0.4f;
ADDRLP4 0+4
CNSTF4 1053609165
ASGNF4
line 208
;208:		color1[2] = 0.2f;
ADDRLP4 0+8
CNSTF4 1045220557
ASGNF4
line 209
;209:		color1[3] = 0.3f;
ADDRLP4 0+12
CNSTF4 1050253722
ASGNF4
line 210
;210:		trap_R_SetColor( color1 );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 214
;211:
;212:		// Draw scrolling numbers, use intervals 10 units apart--sorry, this section of code is just kind of hacked
;213:		//	up with a bunch of magic numbers.....
;214:		val = ((int)((cg.refdefViewAngles[YAW] + 180) / 10)) * 10;
ADDRLP4 40
CNSTI4 10
ADDRGP4 cg+3972+4
INDIRF4
CNSTF4 1127481344
ADDF4
CNSTF4 1092616192
DIVF4
CVFI4 4
MULI4
ASGNI4
line 215
;215:		off = (cg.refdefViewAngles[YAW] + 180) - val;
ADDRLP4 44
ADDRGP4 cg+3972+4
INDIRF4
CNSTF4 1127481344
ADDF4
ADDRLP4 40
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 217
;216:
;217:		for ( i = -10; i < 30; i += 10 )
ADDRLP4 36
CNSTI4 -10
ASGNI4
LABELV $234
line 218
;218:		{
line 219
;219:			val -= 10;
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 10
SUBI4
ASGNI4
line 221
;220:
;221:			if ( val < 0 )
ADDRLP4 40
INDIRI4
CNSTI4 0
GEI4 $238
line 222
;222:			{
line 223
;223:				val += 360;
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 360
ADDI4
ASGNI4
line 224
;224:			}
LABELV $238
line 228
;225:
;226:			// we only want to draw the very far left one some of the time, if it's too far to the left it will
;227:			//	poke outside the mask.
;228:			if (( off > 3.0f && i == -10 ) || i > -10 )
ADDRLP4 44
INDIRF4
CNSTF4 1077936128
LEF4 $243
ADDRLP4 36
INDIRI4
CNSTI4 -10
EQI4 $242
LABELV $243
ADDRLP4 36
INDIRI4
CNSTI4 -10
LEI4 $240
LABELV $242
line 229
;229:			{
line 231
;230:				// draw the value, but add 200 just to bump the range up...arbitrary, so change it if you like
;231:				CG_DrawNumField( 155 + i * 10 + off * 10, 374, 3, val + 200, 24, 14, NUM_FONT_CHUNKY, qtrue );
CNSTI4 10
ADDRLP4 36
INDIRI4
MULI4
CNSTI4 155
ADDI4
CVIF4 4
CNSTF4 1092616192
ADDRLP4 44
INDIRF4
MULF4
ADDF4
CVFI4 4
ARGI4
CNSTI4 374
ARGI4
ADDRLP4 52
CNSTI4 3
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 200
ADDI4
ARGI4
CNSTI4 24
ARGI4
CNSTI4 14
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawNumField
CALLV
pop
line 232
;232:				CG_DrawPic( 245 + (i-1) * 10 + off * 10, 376, 6, 6, cgs.media.whiteShader );
ADDRLP4 56
CNSTI4 10
ASGNI4
ADDRLP4 56
INDIRI4
ADDRLP4 36
INDIRI4
MULI4
ADDRLP4 56
INDIRI4
SUBI4
CNSTI4 245
ADDI4
CVIF4 4
CNSTF4 1092616192
ADDRLP4 44
INDIRF4
MULF4
ADDF4
ARGF4
CNSTF4 1136394240
ARGF4
ADDRLP4 60
CNSTF4 1086324736
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+70280+4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 233
;233:			}
LABELV $240
line 234
;234:		}
LABELV $235
line 217
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 30
LTI4 $234
line 236
;235:
;236:		CG_DrawPic( 212, 367, 200, 28, cgs.media.binocularOverlay );
CNSTF4 1129578496
ARGF4
CNSTF4 1136099328
ARGF4
CNSTF4 1128792064
ARGF4
CNSTF4 1105199104
ARGF4
ADDRGP4 cgs+70280+556
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 238
;237:
;238:		color1[0] = sin( cg.time * 0.01f ) * 0.5f + 0.5f;
CNSTF4 1008981770
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 52
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1056964608
ADDRLP4 52
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 239
;239:		color1[0] = color1[0] * color1[0];
ADDRLP4 56
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 56
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ASGNF4
line 240
;240:		color1[1] = color1[0];
ADDRLP4 0+4
ADDRLP4 0
INDIRF4
ASGNF4
line 241
;241:		color1[2] = color1[0];
ADDRLP4 0+8
ADDRLP4 0
INDIRF4
ASGNF4
line 242
;242:		color1[3] = 1.0f;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 244
;243:
;244:		trap_R_SetColor( color1 );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 246
;245:
;246:		CG_DrawPic( 82, 94, 16, 16, cgs.media.binocularCircle );
CNSTF4 1118044160
ARGF4
CNSTF4 1119617024
ARGF4
ADDRLP4 60
CNSTF4 1098907648
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+70280+536
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 249
;247:
;248:		// Flickery color
;249:		color1[0] = 0.7f + crandom() * 0.1f;
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1036831949
CNSTF4 1073741824
ADDRLP4 64
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
CNSTF4 1060320051
ADDF4
ASGNF4
line 250
;250:		color1[1] = 0.8f + crandom() * 0.1f;
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1036831949
CNSTF4 1073741824
ADDRLP4 68
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
CNSTF4 1061997773
ADDF4
ASGNF4
line 251
;251:		color1[2] = 0.7f + crandom() * 0.1f;
ADDRLP4 72
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1036831949
CNSTF4 1073741824
ADDRLP4 72
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
CNSTF4 1060320051
ADDF4
ASGNF4
line 252
;252:		color1[3] = 1.0f;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 253
;253:		trap_R_SetColor( color1 );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 255
;254:	
;255:		CG_DrawPic( 0, 0, 640, 480, cgs.media.binocularMask );
ADDRLP4 76
CNSTF4 0
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRGP4 cgs+70280+540
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 257
;256:
;257:		CG_DrawPic( 4, 282 - level, 16, 16, cgs.media.binocularArrow );
CNSTF4 1082130432
ARGF4
CNSTF4 1133314048
ADDRLP4 32
INDIRF4
SUBF4
ARGF4
ADDRLP4 80
CNSTF4 1098907648
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRGP4 cgs+70280+544
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 260
;258:
;259:		// The top triangle bit randomly flips 
;260:		if ( flip )
ADDRGP4 $210
INDIRI4
CNSTI4 0
EQI4 $261
line 261
;261:		{
line 262
;262:			CG_DrawPic( 330, 60, -26, -30, cgs.media.binocularTri );
CNSTF4 1134886912
ARGF4
CNSTF4 1114636288
ARGF4
CNSTF4 3251634176
ARGF4
CNSTF4 3253731328
ARGF4
ADDRGP4 cgs+70280+548
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 263
;263:		}
ADDRGP4 $262
JUMPV
LABELV $261
line 265
;264:		else
;265:		{
line 266
;266:			CG_DrawPic( 307, 40, 26, 30, cgs.media.binocularTri );
CNSTF4 1134133248
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1104150528
ARGF4
CNSTF4 1106247680
ARGF4
ADDRGP4 cgs+70280+548
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 267
;267:		}
LABELV $262
line 269
;268:
;269:		if ( random() > 0.98f && ( cg.time & 1024 ))
ADDRLP4 84
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1065017672
LEF4 $212
ADDRGP4 cg+64
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $212
line 270
;270:		{
line 271
;271:			flip = !flip;
ADDRLP4 92
ADDRGP4 $210
ASGNP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $271
ADDRLP4 88
CNSTI4 1
ASGNI4
ADDRGP4 $272
JUMPV
LABELV $271
ADDRLP4 88
CNSTI4 0
ASGNI4
LABELV $272
ADDRLP4 92
INDIRP4
ADDRLP4 88
INDIRI4
ASGNI4
line 272
;272:		}
line 273
;273:	}
ADDRGP4 $212
JUMPV
LABELV $211
line 274
;274:	else if ( cg.predictedPlayerState.zoomMode)
ADDRGP4 cg+96+1320
INDIRI4
CNSTI4 0
EQI4 $273
line 275
;275:	{
line 277
;276:		// disruptor zoom mode
;277:		level = (float)(50.0f - zoomFov) / 50.0f;//(float)(80.0f - zoomFov) / 80.0f;
ADDRLP4 36
CNSTF4 1112014848
ASGNF4
ADDRLP4 32
ADDRLP4 36
INDIRF4
ADDRGP4 zoomFov
INDIRF4
SUBF4
ADDRLP4 36
INDIRF4
DIVF4
ASGNF4
line 280
;278:
;279:		// ...so we'll clamp it
;280:		if ( level < 0.0f )
ADDRLP4 32
INDIRF4
CNSTF4 0
GEF4 $277
line 281
;281:		{
line 282
;282:			level = 0.0f;
ADDRLP4 32
CNSTF4 0
ASGNF4
line 283
;283:		}
ADDRGP4 $278
JUMPV
LABELV $277
line 284
;284:		else if ( level > 1.0f )
ADDRLP4 32
INDIRF4
CNSTF4 1065353216
LEF4 $279
line 285
;285:		{
line 286
;286:			level = 1.0f;
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
line 287
;287:		}
LABELV $279
LABELV $278
line 290
;288:
;289:		// Using a magic number to convert the zoom level to a rotation amount that correlates more or less with the zoom artwork. 
;290:		level *= 103.0f;
ADDRLP4 32
CNSTF4 1120796672
ADDRLP4 32
INDIRF4
MULF4
ASGNF4
line 293
;291:
;292:		// Draw target mask
;293:		trap_R_SetColor( colorTable[CT_WHITE] );
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 294
;294:		CG_DrawPic( 0, 0, 640, 480, cgs.media.disruptorMask );
ADDRLP4 40
CNSTF4 0
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRGP4 cgs+70280+516
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 297
;295:
;296:		// apparently 99.0f is the full zoom level
;297:		if ( level >= 99 )
ADDRLP4 32
INDIRF4
CNSTF4 1120272384
LTF4 $284
line 298
;298:		{
line 300
;299:			// Fully zoomed, so make the rotating insert pulse
;300:			color1[0] = 1.0f; 
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 301
;301:			color1[1] = 1.0f;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 302
;302:			color1[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 303
;303:			color1[3] = 0.7f + sin( cg.time * 0.01f ) * 0.3f;
CNSTF4 1008981770
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 44
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+12
CNSTF4 1050253722
ADDRLP4 44
INDIRF4
MULF4
CNSTF4 1060320051
ADDF4
ASGNF4
line 305
;304:
;305:			trap_R_SetColor( color1 );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 306
;306:		}
LABELV $284
line 309
;307:
;308:		// Draw rotating insert
;309:		CG_DrawRotatePic2( 320, 240, 640, 480, -level, cgs.media.disruptorInsert );
CNSTF4 1134559232
ARGF4
CNSTF4 1131413504
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRLP4 32
INDIRF4
NEGF4
ARGF4
ADDRGP4 cgs+70280+520
INDIRI4
ARGI4
ADDRGP4 CG_DrawRotatePic2
CALLV
pop
line 337
;310:
;311:		// Increase the light levels under the center of the target
;312://		CG_DrawPic( 198, 118, 246, 246, cgs.media.disruptorLight );
;313:
;314:		// weirdness.....converting ammo to a base five number scale just to be geeky.
;315:/*		val[0] = ammo % 5;
;316:		val[1] = (ammo / 5) % 5;
;317:		val[2] = (ammo / 25) % 5;
;318:		val[3] = (ammo / 125) % 5;
;319:		val[4] = (ammo / 625) % 5;
;320:		
;321:		color1[0] = 0.2f;
;322:		color1[1] = 0.55f + crandom() * 0.1f;
;323:		color1[2] = 0.5f + crandom() * 0.1f;
;324:		color1[3] = 1.0f;
;325:		trap_R_SetColor( color1 );
;326:
;327:		for ( int t = 0; t < 5; t++ )
;328:		{
;329:			cx = 320 + sin( (t*10+45)/57.296f ) * 192;
;330:			cy = 240 + cos( (t*10+45)/57.296f ) * 192;
;331:
;332:			CG_DrawRotatePic2( cx, cy, 24, 38, 45 - t * 10, trap_R_RegisterShader( va("gfx/2d/char%d",val[4-t] )));
;333:		}
;334:*/
;335:		//max = ( cg_entities[0].gent->health / 100.0f );
;336:
;337:		max = cg.snap->ps.ammo[weaponData[WP_DISRUPTOR].ammoIndex] / (float)ammoData[weaponData[WP_DISRUPTOR].ammoIndex].max;
ADDRLP4 44
CNSTI4 2
ASGNI4
ADDRLP4 28
ADDRGP4 weaponData+280
INDIRI4
ADDRLP4 44
INDIRI4
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 452
ADDP4
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 weaponData+280
INDIRI4
ADDRLP4 44
INDIRI4
LSHI4
ADDRGP4 ammoData
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 338
;338:		if ( max > 1.0f )
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
LEF4 $295
line 339
;339:		{
line 340
;340:			max = 1.0f;
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
line 341
;341:		}
LABELV $295
line 343
;342:
;343:		color1[0] = (1.0f - max) * 2.0f; 
ADDRLP4 0
CNSTF4 1073741824
CNSTF4 1065353216
ADDRLP4 28
INDIRF4
SUBF4
MULF4
ASGNF4
line 344
;344:		color1[1] = max * 1.5f;
ADDRLP4 0+4
CNSTF4 1069547520
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 345
;345:		color1[2] = 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 346
;346:		color1[3] = 1.0f;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 349
;347:
;348:		// If we are low on health, make us flash
;349:		if ( max < 0.15f && ( cg.time & 512 ))
ADDRLP4 28
INDIRF4
CNSTF4 1041865114
GEF4 $300
ADDRGP4 cg+64
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $300
line 350
;350:		{
line 351
;351:			VectorClear( color1 );
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 48
INDIRF4
ASGNF4
line 352
;352:		}
LABELV $300
line 354
;353:
;354:		if ( color1[0] > 1.0f )
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
LEF4 $305
line 355
;355:		{
line 356
;356:			color1[0] = 1.0f;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 357
;357:		}
LABELV $305
line 359
;358:
;359:		if ( color1[1] > 1.0f )
ADDRLP4 0+4
INDIRF4
CNSTF4 1065353216
LEF4 $307
line 360
;360:		{
line 361
;361:			color1[1] = 1.0f;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 362
;362:		}
LABELV $307
line 364
;363:
;364:		trap_R_SetColor( color1 );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 366
;365:
;366:		max *= 58.0f;
ADDRLP4 28
CNSTF4 1114112000
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 368
;367:
;368:		for (fi = 18.5f; fi <= 18.5f + max; fi+= 3 ) // going from 15 to 45 degrees, with 5 degree increments
ADDRLP4 16
CNSTF4 1100218368
ASGNF4
ADDRGP4 $314
JUMPV
LABELV $311
line 369
;369:		{
line 370
;370:			cx = 320 + sin( (fi+90.0f)/57.296f ) * 190;
ADDRLP4 16
INDIRF4
CNSTF4 1119092736
ADDF4
CNSTF4 1113927451
DIVF4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 20
CNSTF4 1128136704
ADDRLP4 48
INDIRF4
MULF4
CNSTF4 1134559232
ADDF4
ASGNF4
line 371
;371:			cy = 240 + cos( (fi+90.0f)/57.296f ) * 190;
ADDRLP4 16
INDIRF4
CNSTF4 1119092736
ADDF4
CNSTF4 1113927451
DIVF4
ARGF4
ADDRLP4 52
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 24
CNSTF4 1128136704
ADDRLP4 52
INDIRF4
MULF4
CNSTF4 1131413504
ADDF4
ASGNF4
line 373
;372:
;373:			CG_DrawRotatePic2( cx, cy, 12, 24, 90 - fi, cgs.media.disruptorInsertTick );
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
CNSTF4 1094713344
ARGF4
CNSTF4 1103101952
ARGF4
CNSTF4 1119092736
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
ADDRGP4 cgs+70280+528
INDIRI4
ARGI4
ADDRGP4 CG_DrawRotatePic2
CALLV
pop
line 374
;374:		}
LABELV $312
line 368
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
LABELV $314
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1100218368
ADDF4
LEF4 $311
line 376
;375:
;376:		if ( cg.predictedPlayerState.weaponstate == WEAPON_CHARGING_ALT )
ADDRGP4 cg+96+152
INDIRI4
CNSTI4 5
NEI4 $317
line 377
;377:		{
line 378
;378:			trap_R_SetColor( colorTable[CT_WHITE] );
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 381
;379:
;380:			// draw the charge level
;381:			max = ( cg.time - cg.predictedPlayerState.weaponChargeTime ) / ( 50.0f * 30.0f ); // bad hardcodedness 50 is disruptor charge unit and 30 is max charge units allowed.
ADDRLP4 28
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+96+48
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1153138688
DIVF4
ASGNF4
line 383
;382:
;383:			if ( max > 1.0f )
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
LEF4 $325
line 384
;384:			{
line 385
;385:				max = 1.0f;
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
line 386
;386:			}
LABELV $325
line 388
;387:
;388:			trap_R_DrawStretchPic(257, 435, 134*max, 34, 0, 0, max, 1, cgs.media.disruptorChargeShader);
CNSTF4 1132494848
ARGF4
CNSTF4 1138327552
ARGF4
CNSTF4 1124466688
ADDRLP4 28
INDIRF4
MULF4
ARGF4
CNSTF4 1107820544
ARGF4
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 cgs+70280+532
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 389
;389:		}
LABELV $317
line 393
;390://		trap_R_SetColor( colorTable[CT_WHITE] );
;391://		CG_DrawPic( 0, 0, 640, 480, cgs.media.disruptorMask );
;392:
;393:	}
LABELV $273
LABELV $212
line 394
;394:}
LABELV $209
endproc CG_DrawZoomMask 96 36
export CG_Draw3DModel
proc CG_Draw3DModel 584 12
line 403
;395:
;396:
;397:/*
;398:================
;399:CG_Draw3DModel
;400:
;401:================
;402:*/
;403:void CG_Draw3DModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles ) {
line 407
;404:	refdef_t		refdef;
;405:	refEntity_t		ent;
;406:
;407:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
ADDRLP4 580
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 580
INDIRI4
EQI4 $334
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 580
INDIRI4
NEI4 $330
LABELV $334
line 408
;408:		return;
ADDRGP4 $329
JUMPV
LABELV $330
line 411
;409:	}
;410:
;411:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 413
;412:
;413:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 414
;414:	AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 415
;415:	VectorCopy( origin, ent.origin );
ADDRLP4 368+52
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 416
;416:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 417
;417:	ent.customSkin = skin;
ADDRLP4 368+136
ADDRFP4 20
INDIRI4
ASGNI4
line 418
;418:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 420
;419:
;420:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 422
;421:
;422:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 424
;423:
;424:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 425
;425:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 427
;426:
;427:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 428
;428:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 429
;429:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 430
;430:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 432
;431:
;432:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 434
;433:
;434:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 435
;435:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 436
;436:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 437
;437:}
LABELV $329
endproc CG_Draw3DModel 584 12
export CG_DrawHead
proc CG_DrawHead 4 20
line 447
;438:
;439:/*
;440:================
;441:CG_DrawHead
;442:
;443:Used for both the status bar and the scoreboard
;444:================
;445:*/
;446:void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles ) 
;447:{
line 450
;448:	clientInfo_t	*ci;
;449:
;450:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
CNSTI4 788
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 452
;451:
;452:	CG_DrawPic( x, y, w, h, ci->modelIcon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 455
;453:
;454:	// if they are deferred, draw a cross out
;455:	if ( ci->deferred ) 
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
CNSTI4 0
EQI4 $351
line 456
;456:	{
line 457
;457:		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 cgs+70280+108
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 458
;458:	}
LABELV $351
line 459
;459:}
LABELV $349
endproc CG_DrawHead 4 20
export CG_DrawFlagModel
proc CG_DrawFlagModel 72 32
line 468
;460:
;461:/*
;462:================
;463:CG_DrawFlagModel
;464:
;465:Used for both the status bar and the scoreboard
;466:================
;467:*/
;468:void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D ) {
line 475
;469:	qhandle_t		cm;
;470:	float			len;
;471:	vec3_t			origin, angles;
;472:	vec3_t			mins, maxs;
;473:	qhandle_t		handle;
;474:
;475:	if ( !force2D && cg_draw3dIcons.integer ) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $356
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $356
line 477
;476:
;477:		VectorClear( angles );
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 64
INDIRF4
ASGNF4
line 479
;478:
;479:		cm = cgs.media.redFlagModel;
ADDRLP4 48
ADDRGP4 cgs+70280+36
INDIRI4
ASGNI4
line 482
;480:
;481:		// offset the origin y and z to center the flag
;482:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 484
;483:
;484:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 12+8
CNSTF4 3204448256
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 485
;485:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 12+4
CNSTF4 1056964608
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 489
;486:
;487:		// calculate distance so the flag nearly fills the box
;488:		// assume heads are taller than wide
;489:		len = 0.5 * ( maxs[2] - mins[2] );		
ADDRLP4 52
CNSTF4 1056964608
ADDRLP4 36+8
INDIRF4
ADDRLP4 24+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 490
;490:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 12
ADDRLP4 52
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 492
;491:
;492:		angles[YAW] = 60 * sin( cg.time / 2000.0 );;
ADDRGP4 cg+64
INDIRI4
CVIF4 4
CNSTF4 1157234688
DIVF4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+4
CNSTF4 1114636288
ADDRLP4 68
INDIRF4
MULF4
ASGNF4
line 494
;493:
;494:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $373
line 495
;495:			handle = cgs.media.redFlagModel;
ADDRLP4 56
ADDRGP4 cgs+70280+36
INDIRI4
ASGNI4
line 496
;496:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $374
JUMPV
LABELV $373
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $377
line 497
;497:			handle = cgs.media.blueFlagModel;
ADDRLP4 56
ADDRGP4 cgs+70280+40
INDIRI4
ASGNI4
line 498
;498:		} else if( team == TEAM_FREE ) {
ADDRGP4 $378
JUMPV
LABELV $377
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $355
line 499
;499:			handle = cgs.media.neutralFlagModel;
ADDRLP4 56
ADDRGP4 cgs+70280+44
INDIRI4
ASGNI4
line 500
;500:		} else {
line 501
;501:			return;
LABELV $382
LABELV $378
LABELV $374
line 503
;502:		}
;503:		CG_Draw3DModel( x, y, w, h, handle, 0, origin, angles );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 504
;504:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $357
JUMPV
LABELV $356
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $385
line 507
;505:		gitem_t *item;
;506:
;507:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $388
line 508
;508:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 4
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 509
;509:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $389
JUMPV
LABELV $388
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $390
line 510
;510:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 5
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 511
;511:		} else if( team == TEAM_FREE ) {
ADDRGP4 $391
JUMPV
LABELV $390
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $355
line 512
;512:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 6
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 513
;513:		} else {
line 514
;514:			return;
LABELV $393
LABELV $391
LABELV $389
line 516
;515:		}
;516:		if (item) {
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $394
line 517
;517:		  CG_DrawPic( x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 56
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 518
;518:		}
LABELV $394
line 519
;519:	}
LABELV $385
LABELV $357
line 520
;520:}
LABELV $355
endproc CG_DrawFlagModel 72 32
export DrawAmmo
proc DrawAmmo 8 0
line 528
;521:
;522:/*
;523:================
;524:DrawAmmo
;525:================
;526:*/
;527:void DrawAmmo()
;528:{
line 531
;529:	int x, y;
;530:
;531:	x = SCREEN_WIDTH-80;
ADDRLP4 0
CNSTI4 560
ASGNI4
line 532
;532:	y = SCREEN_HEIGHT-80;
ADDRLP4 4
CNSTI4 400
ASGNI4
line 534
;533:
;534:}
LABELV $397
endproc DrawAmmo 8 0
export CG_DrawHUDLeftFrame1
proc CG_DrawHUDLeftFrame1 4 20
line 542
;535:
;536:/*
;537:================
;538:CG_DrawHUDLeftFrame1
;539:================
;540:*/
;541:void CG_DrawHUDLeftFrame1(int x,int y)
;542:{
line 544
;543:	// Inner gray wire frame
;544:	trap_R_SetColor( hudTintColor );
ADDRGP4 hudTintColor
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 545
;545:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDInnerLeft );			
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
CNSTF4 1117782016
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1256
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 546
;546:}
LABELV $398
endproc CG_DrawHUDLeftFrame1 4 20
export CG_DrawHUDLeftFrame2
proc CG_DrawHUDLeftFrame2 4 20
line 554
;547:
;548:/*
;549:================
;550:CG_DrawHUDLeftFrame2
;551:================
;552:*/
;553:void CG_DrawHUDLeftFrame2(int x,int y)
;554:{
line 556
;555:	// Inner gray wire frame
;556:	trap_R_SetColor( hudTintColor );
ADDRGP4 hudTintColor
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 557
;557:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDLeftFrame );		// Metal frame
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
CNSTF4 1117782016
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1172
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 558
;558:}
LABELV $401
endproc CG_DrawHUDLeftFrame2 4 20
export DrawHealthArmor
proc DrawHealthArmor 72 32
line 566
;559:
;560:/*
;561:================
;562:DrawHealthArmor
;563:================
;564:*/
;565:void DrawHealthArmor(int x,int y)
;566:{
line 574
;567:	vec4_t calcColor;
;568:	float	armorPercent,hold,healthPercent;
;569:	playerState_t	*ps;
;570:
;571:	int healthAmt;
;572:	int armorAmt;
;573:
;574:	ps = &cg.snap->ps;
ADDRLP4 20
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 576
;575:
;576:	healthAmt = ps->stats[STAT_HEALTH];
ADDRLP4 32
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
ASGNI4
line 577
;577:	armorAmt = ps->stats[STAT_ARMOR];
ADDRLP4 28
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
line 579
;578:
;579:	if (healthAmt > ps->stats[STAT_MAX_HEALTH])
ADDRLP4 32
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
LEI4 $406
line 580
;580:	{
line 581
;581:		healthAmt = ps->stats[STAT_MAX_HEALTH];
ADDRLP4 32
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 582
;582:	}
LABELV $406
line 584
;583:
;584:	if (armorAmt > 100)
ADDRLP4 28
INDIRI4
CNSTI4 100
LEI4 $408
line 585
;585:	{
line 586
;586:		armorAmt = 100;
ADDRLP4 28
CNSTI4 100
ASGNI4
line 587
;587:	}
LABELV $408
line 589
;588:
;589:	trap_R_SetColor( colorTable[CT_WHITE] );
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 590
;590:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDLeftFrame );		// Circular black background
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 40
CNSTF4 1117782016
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1172
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 593
;591:
;592:	//	Outer Armor circular
;593:	memcpy(calcColor, colorTable[CT_GREEN], sizeof(vec4_t));
ADDRLP4 0
ARGP4
ADDRGP4 colorTable+48
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 595
;594:
;595:	hold = armorAmt-(ps->stats[STAT_MAX_HEALTH]/2);
ADDRLP4 36
ADDRLP4 28
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ASGNF4
line 596
;596:	armorPercent = (float) hold/(ps->stats[STAT_MAX_HEALTH]/2);
ADDRLP4 16
ADDRLP4 36
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
DIVF4
ASGNF4
line 597
;597:	if (armorPercent <0)
ADDRLP4 16
INDIRF4
CNSTF4 0
GEF4 $414
line 598
;598:	{
line 599
;599:		armorPercent = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 600
;600:	}
LABELV $414
line 601
;601:	calcColor[0] *= armorPercent;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 602
;602:	calcColor[1] *= armorPercent;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 603
;603:	calcColor[2] *= armorPercent;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 604
;604:	trap_R_SetColor( calcColor);					
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 605
;605:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDArmor1 );			
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 44
CNSTF4 1117782016
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1176
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 608
;606:
;607:	// Inner Armor circular
;608:	if (armorPercent>0)
ADDRLP4 16
INDIRF4
CNSTF4 0
LEF4 $420
line 609
;609:	{
line 610
;610:		armorPercent = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 611
;611:	}
ADDRGP4 $421
JUMPV
LABELV $420
line 613
;612:	else
;613:	{
line 614
;614:		armorPercent = (float) armorAmt/(ps->stats[STAT_MAX_HEALTH]/2);
ADDRLP4 16
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
DIVF4
ASGNF4
line 615
;615:	}
LABELV $421
line 616
;616:	memcpy(calcColor, colorTable[CT_GREEN], sizeof(vec4_t));
ADDRLP4 0
ARGP4
ADDRGP4 colorTable+48
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 617
;617:	calcColor[0] *= armorPercent;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 618
;618:	calcColor[1] *= armorPercent;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 619
;619:	calcColor[2] *= armorPercent;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 620
;620:	trap_R_SetColor( calcColor);					
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 621
;621:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDArmor2 );			//	Inner Armor circular
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 48
CNSTF4 1117782016
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1180
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 623
;622:
;623:	if (ps->stats[STAT_ARMOR])	// Is there armor? Draw the HUD Armor TIC
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 0
EQI4 $427
line 624
;624:	{
line 626
;625:		// Make tic flash if inner armor is at 50% (25% of full armor)
;626:		if (armorPercent<.5)		// Do whatever the flash timer says
ADDRLP4 16
INDIRF4
CNSTF4 1056964608
GEF4 $429
line 627
;627:		{
line 628
;628:			if (cg.HUDTickFlashTime < cg.time)			// Flip at the same time
ADDRGP4 cg+13752
INDIRF4
ADDRGP4 cg+64
INDIRI4
CVIF4 4
GEF4 $428
line 629
;629:			{
line 630
;630:				cg.HUDTickFlashTime = cg.time + 100;
ADDRGP4 cg+13752
ADDRGP4 cg+64
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 631
;631:				if (cg.HUDArmorFlag)
ADDRGP4 cg+13756
INDIRI4
CNSTI4 0
EQI4 $437
line 632
;632:				{
line 633
;633:					cg.HUDArmorFlag = qfalse;
ADDRGP4 cg+13756
CNSTI4 0
ASGNI4
line 634
;634:				}
ADDRGP4 $428
JUMPV
LABELV $437
line 636
;635:				else
;636:				{
line 637
;637:					cg.HUDArmorFlag = qtrue;
ADDRGP4 cg+13756
CNSTI4 1
ASGNI4
line 638
;638:				}
line 639
;639:			}
line 640
;640:		}
ADDRGP4 $428
JUMPV
LABELV $429
line 642
;641:		else
;642:		{
line 643
;643:			cg.HUDArmorFlag=qtrue;
ADDRGP4 cg+13756
CNSTI4 1
ASGNI4
line 644
;644:		}
line 645
;645:	}
ADDRGP4 $428
JUMPV
LABELV $427
line 647
;646:	else						// No armor? Don't show it.
;647:	{
line 648
;648:		cg.HUDArmorFlag=qfalse;
ADDRGP4 cg+13756
CNSTI4 0
ASGNI4
line 649
;649:	}
LABELV $428
line 651
;650:
;651:	memcpy(calcColor, colorTable[CT_RED], sizeof(vec4_t));
ADDRLP4 0
ARGP4
ADDRGP4 colorTable+32
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 652
;652:	healthPercent = (float) healthAmt/ps->stats[STAT_MAX_HEALTH];
ADDRLP4 24
ADDRLP4 32
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 653
;653:	calcColor[0] *= healthPercent;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 654
;654:	calcColor[1] *= healthPercent;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 655
;655:	calcColor[2] *= healthPercent;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 656
;656:	trap_R_SetColor( calcColor);					
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 657
;657:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDHealth );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 52
CNSTF4 1117782016
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 660
;658:
;659:	// Make tic flash if health is at 20% of full
;660:	if (healthPercent>.20)
ADDRLP4 24
INDIRF4
CNSTF4 1045220557
LEF4 $449
line 661
;661:	{
line 662
;662:		cg.HUDHealthFlag=qtrue;
ADDRGP4 cg+13760
CNSTI4 1
ASGNI4
line 663
;663:	}
ADDRGP4 $450
JUMPV
LABELV $449
line 665
;664:	else
;665:	{
line 666
;666:		if (cg.HUDTickFlashTime < cg.time)			// Flip at the same time
ADDRGP4 cg+13752
INDIRF4
ADDRGP4 cg+64
INDIRI4
CVIF4 4
GEF4 $452
line 667
;667:		{
line 668
;668:			cg.HUDTickFlashTime = cg.time + 100;
ADDRGP4 cg+13752
ADDRGP4 cg+64
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 670
;669:
;670:			if ((armorPercent>0) && (armorPercent<.5))		// Keep the tics in sync if flashing
ADDRLP4 16
INDIRF4
CNSTF4 0
LEF4 $458
ADDRLP4 16
INDIRF4
CNSTF4 1056964608
GEF4 $458
line 671
;671:			{
line 672
;672:				cg.HUDHealthFlag=cg.HUDArmorFlag;
ADDRGP4 cg+13760
ADDRGP4 cg+13756
INDIRI4
ASGNI4
line 673
;673:			}
ADDRGP4 $459
JUMPV
LABELV $458
line 675
;674:			else
;675:			{
line 676
;676:				if (cg.HUDHealthFlag)
ADDRGP4 cg+13760
INDIRI4
CNSTI4 0
EQI4 $462
line 677
;677:				{
line 678
;678:					cg.HUDHealthFlag = qfalse;
ADDRGP4 cg+13760
CNSTI4 0
ASGNI4
line 679
;679:				}
ADDRGP4 $463
JUMPV
LABELV $462
line 681
;680:				else
;681:				{
line 682
;682:					cg.HUDHealthFlag = qtrue;
ADDRGP4 cg+13760
CNSTI4 1
ASGNI4
line 683
;683:				}
LABELV $463
line 684
;684:			}
LABELV $459
line 685
;685:		}
LABELV $452
line 686
;686:	}
LABELV $450
line 689
;687:
;688:	// Draw the ticks
;689:	if (cg.HUDHealthFlag)
ADDRGP4 cg+13760
INDIRI4
CNSTI4 0
EQI4 $467
line 690
;690:	{
line 691
;691:		trap_R_SetColor( colorTable[CT_RED] );					
ADDRGP4 colorTable+32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 692
;692:		CG_DrawPic(   x, y, 80, 80, cgs.media.HUDHealthTic );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
CNSTF4 1117782016
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1188
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 693
;693:	}
LABELV $467
line 695
;694:
;695:	if (cg.HUDArmorFlag)
ADDRGP4 cg+13756
INDIRI4
CNSTI4 0
EQI4 $473
line 696
;696:	{
line 697
;697:		trap_R_SetColor( colorTable[CT_GREEN] );					
ADDRGP4 colorTable+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 698
;698:		CG_DrawPic(   x, y, 80, 80, cgs.media.HUDArmorTic );		//	
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
CNSTF4 1117782016
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1192
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 699
;699:	}
LABELV $473
line 701
;700:
;701:	trap_R_SetColor(hudTintColor);
ADDRGP4 hudTintColor
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 702
;702:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDLeftStatic );		//	
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
CNSTF4 1117782016
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1196
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 704
;703:
;704:	trap_R_SetColor( colorTable[CT_RED] );	
ADDRGP4 colorTable+32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 705
;705:	CG_DrawNumField (x + 16, y + 40, 3, ps->stats[STAT_HEALTH], 14, 18, 
ADDRFP4 0
INDIRI4
CNSTI4 16
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 40
ADDI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
ARGI4
CNSTI4 14
ARGI4
CNSTI4 18
ARGI4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawNumField
CALLV
pop
line 708
;706:		NUM_FONT_SMALL,qfalse);
;707:
;708:	trap_R_SetColor( colorTable[CT_GREEN] );	
ADDRGP4 colorTable+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 709
;709:	CG_DrawNumField (x + 18 + 14, y + 40 + 14, 3, ps->stats[STAT_ARMOR], 14, 18, 
ADDRLP4 60
CNSTI4 18
ASGNI4
ADDRLP4 64
CNSTI4 14
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 60
INDIRI4
ADDI4
ADDRLP4 64
INDIRI4
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 40
ADDI4
ADDRLP4 64
INDIRI4
ADDI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawNumField
CALLV
pop
line 712
;710:		NUM_FONT_SMALL,qfalse);
;711:
;712:	trap_R_SetColor(hudTintColor );
ADDRGP4 hudTintColor
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 713
;713:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDLeft );			// Metal frame
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 68
CNSTF4 1117782016
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1200
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 714
;714:}
LABELV $404
endproc DrawHealthArmor 72 32
export CG_DrawHealth
proc CG_DrawHealth 36 32
line 722
;715:
;716:/*
;717:================
;718:CG_DrawHealth
;719:================
;720:*/
;721:void CG_DrawHealth(int x,int y)
;722:{
line 728
;723:	vec4_t calcColor;
;724:	float	healthPercent;
;725:	playerState_t	*ps;
;726:	int healthAmt;
;727:
;728:	ps = &cg.snap->ps;
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 730
;729:
;730:	healthAmt = ps->stats[STAT_HEALTH];
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
ASGNI4
line 732
;731:
;732:	if (healthAmt > ps->stats[STAT_MAX_HEALTH])
ADDRLP4 24
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
LEI4 $487
line 733
;733:	{
line 734
;734:		healthAmt = ps->stats[STAT_MAX_HEALTH];
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 735
;735:	}
LABELV $487
line 737
;736:
;737:	memcpy(calcColor, colorTable[CT_HUD_RED], sizeof(vec4_t));
ADDRLP4 4
ARGP4
ADDRGP4 colorTable+1008
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 738
;738:	healthPercent = (float) healthAmt/ps->stats[STAT_MAX_HEALTH];
ADDRLP4 20
ADDRLP4 24
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 739
;739:	calcColor[0] *= healthPercent;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 740
;740:	calcColor[1] *= healthPercent;
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 741
;741:	calcColor[2] *= healthPercent;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 742
;742:	trap_R_SetColor( calcColor);					
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 743
;743:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDHealth );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
CNSTF4 1117782016
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 746
;744:
;745:	// Draw the ticks
;746:	if (cg.HUDHealthFlag)
ADDRGP4 cg+13760
INDIRI4
CNSTI4 0
EQI4 $494
line 747
;747:	{
line 748
;748:		trap_R_SetColor( colorTable[CT_HUD_RED] );					
ADDRGP4 colorTable+1008
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 749
;749:		CG_DrawPic(   x, y, 80, 80, cgs.media.HUDHealthTic );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
CNSTF4 1117782016
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1188
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 750
;750:	}
LABELV $494
line 752
;751:
;752:	trap_R_SetColor( colorTable[CT_HUD_RED] );	
ADDRGP4 colorTable+1008
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 753
;753:	CG_DrawNumField (x + 16, y + 40, 3, ps->stats[STAT_HEALTH], 6, 12, 
ADDRFP4 0
INDIRI4
CNSTI4 16
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 40
ADDI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTI4 12
ARGI4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawNumField
CALLV
pop
line 756
;754:		NUM_FONT_SMALL,qfalse);
;755:
;756:}
LABELV $485
endproc CG_DrawHealth 36 32
export CG_DrawArmor
proc CG_DrawArmor 44 32
line 764
;757:
;758:/*
;759:================
;760:CG_DrawArmor
;761:================
;762:*/
;763:void CG_DrawArmor(int x,int y)
;764:{
line 770
;765:	vec4_t			calcColor;
;766:	float			armorPercent,hold;
;767:	playerState_t	*ps;
;768:	int				armor;
;769:
;770:	ps = &cg.snap->ps;
ADDRLP4 20
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 773
;771:
;772:	//	Outer Armor circular
;773:	memcpy(calcColor, colorTable[CT_HUD_GREEN], sizeof(vec4_t));
ADDRLP4 4
ARGP4
ADDRGP4 colorTable+992
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 775
;774:
;775:	armor =ps->stats[STAT_ARMOR];
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
line 777
;776:	
;777:	if (armor> ps->stats[STAT_MAX_HEALTH])
ADDRLP4 24
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
LEI4 $504
line 778
;778:	{
line 779
;779:		armor = ps->stats[STAT_MAX_HEALTH];
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 780
;780:	}
LABELV $504
line 782
;781:
;782:	hold = armor-(ps->stats[STAT_MAX_HEALTH]/2);
ADDRLP4 28
ADDRLP4 24
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ASGNF4
line 783
;783:	armorPercent = (float) hold/(ps->stats[STAT_MAX_HEALTH]/2);
ADDRLP4 0
ADDRLP4 28
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
DIVF4
ASGNF4
line 784
;784:	if (armorPercent <0)
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $506
line 785
;785:	{
line 786
;786:		armorPercent = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 787
;787:	}
LABELV $506
line 788
;788:	calcColor[0] *= armorPercent;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 789
;789:	calcColor[1] *= armorPercent;
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 790
;790:	calcColor[2] *= armorPercent;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 791
;791:	trap_R_SetColor( calcColor);					
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 792
;792:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDArmor1 );			
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
CNSTF4 1117782016
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1176
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 795
;793:
;794:	// Inner Armor circular
;795:	if (armorPercent>0)
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $512
line 796
;796:	{
line 797
;797:		armorPercent = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 798
;798:	}
ADDRGP4 $513
JUMPV
LABELV $512
line 800
;799:	else
;800:	{
line 801
;801:		armorPercent = (float) ps->stats[STAT_ARMOR]/(ps->stats[STAT_MAX_HEALTH]/2);
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
DIVF4
ASGNF4
line 802
;802:	}
LABELV $513
line 803
;803:	memcpy(calcColor, colorTable[CT_HUD_GREEN], sizeof(vec4_t));
ADDRLP4 4
ARGP4
ADDRGP4 colorTable+992
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 804
;804:	calcColor[0] *= armorPercent;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 805
;805:	calcColor[1] *= armorPercent;
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 806
;806:	calcColor[2] *= armorPercent;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 807
;807:	trap_R_SetColor( calcColor);					
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 808
;808:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDArmor2 );			//	Inner Armor circular
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
CNSTF4 1117782016
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1180
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 810
;809:
;810:	if (ps->stats[STAT_ARMOR])	// Is there armor? Draw the HUD Armor TIC
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 0
EQI4 $519
line 811
;811:	{
line 813
;812:		// Make tic flash if inner armor is at 50% (25% of full armor)
;813:		if (armorPercent<.5)		// Do whatever the flash timer says
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $521
line 814
;814:		{
line 815
;815:			if (cg.HUDTickFlashTime < cg.time)			// Flip at the same time
ADDRGP4 cg+13752
INDIRF4
ADDRGP4 cg+64
INDIRI4
CVIF4 4
GEF4 $520
line 816
;816:			{
line 817
;817:				cg.HUDTickFlashTime = cg.time + 100;
ADDRGP4 cg+13752
ADDRGP4 cg+64
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 818
;818:				if (cg.HUDArmorFlag)
ADDRGP4 cg+13756
INDIRI4
CNSTI4 0
EQI4 $529
line 819
;819:				{
line 820
;820:					cg.HUDArmorFlag = qfalse;
ADDRGP4 cg+13756
CNSTI4 0
ASGNI4
line 821
;821:				}
ADDRGP4 $520
JUMPV
LABELV $529
line 823
;822:				else
;823:				{
line 824
;824:					cg.HUDArmorFlag = qtrue;
ADDRGP4 cg+13756
CNSTI4 1
ASGNI4
line 825
;825:				}
line 826
;826:			}
line 827
;827:		}
ADDRGP4 $520
JUMPV
LABELV $521
line 829
;828:		else
;829:		{
line 830
;830:			cg.HUDArmorFlag=qtrue;
ADDRGP4 cg+13756
CNSTI4 1
ASGNI4
line 831
;831:		}
line 832
;832:	}
ADDRGP4 $520
JUMPV
LABELV $519
line 834
;833:	else						// No armor? Don't show it.
;834:	{
line 835
;835:		cg.HUDArmorFlag=qfalse;
ADDRGP4 cg+13756
CNSTI4 0
ASGNI4
line 836
;836:	}
LABELV $520
line 838
;837:
;838:	if (cg.HUDArmorFlag)
ADDRGP4 cg+13756
INDIRI4
CNSTI4 0
EQI4 $536
line 839
;839:	{
line 840
;840:		trap_R_SetColor( colorTable[CT_HUD_GREEN] );					
ADDRGP4 colorTable+992
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 841
;841:		CG_DrawPic(   x, y, 80, 80, cgs.media.HUDArmorTic );		
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 40
CNSTF4 1117782016
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1192
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 842
;842:	}
LABELV $536
line 844
;843:
;844:	trap_R_SetColor( colorTable[CT_HUD_GREEN] );	
ADDRGP4 colorTable+992
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 845
;845:	CG_DrawNumField (x + 18 + 14, y + 40 + 14, 3, ps->stats[STAT_ARMOR], 6, 12, 
ADDRLP4 40
CNSTI4 14
ASGNI4
ADDRFP4 0
INDIRI4
CNSTI4 18
ADDI4
ADDRLP4 40
INDIRI4
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 40
ADDI4
ADDRLP4 40
INDIRI4
ADDI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTI4 12
ARGI4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawNumField
CALLV
pop
line 848
;846:		NUM_FONT_SMALL,qfalse);
;847:
;848:}
LABELV $501
endproc CG_DrawArmor 44 32
export CG_DrawHUDRightFrame1
proc CG_DrawHUDRightFrame1 4 20
line 856
;849:
;850:/*
;851:================
;852:CG_DrawHUDRightFrame1
;853:================
;854:*/
;855:void CG_DrawHUDRightFrame1(int x,int y)
;856:{
line 857
;857:	trap_R_SetColor( hudTintColor );
ADDRGP4 hudTintColor
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 859
;858:	// Inner gray wire frame
;859:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDInnerRight );		// 
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
CNSTF4 1117782016
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1220
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 860
;860:}
LABELV $543
endproc CG_DrawHUDRightFrame1 4 20
export CG_DrawHUDRightFrame2
proc CG_DrawHUDRightFrame2 4 20
line 868
;861:
;862:/*
;863:================
;864:CG_DrawHUDRightFrame2
;865:================
;866:*/
;867:void CG_DrawHUDRightFrame2(int x,int y)
;868:{
line 869
;869:	trap_R_SetColor( hudTintColor );
ADDRGP4 hudTintColor
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 870
;870:	CG_DrawPic(   x, y, 80, 80, cgs.media.HUDRightFrame );		// Metal frame
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
CNSTF4 1117782016
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+70280+1216
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 871
;871:}
LABELV $546
endproc CG_DrawHUDRightFrame2 4 20
proc CG_DrawAmmo 44 32
line 879
;872:
;873:/*
;874:================
;875:CG_DrawAmmo
;876:================
;877:*/
;878:static void CG_DrawAmmo(centity_t	*cent,int x,int y)
;879:{
line 886
;880:	playerState_t	*ps;
;881:	int			numColor_i;
;882:	int			i;
;883:	vec4_t		calcColor;
;884:	float		value,inc,percent;
;885:
;886:	ps = &cg.snap->ps;
ADDRLP4 32
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 888
;887:
;888:	if (!cent->currentState.weapon ) // We don't have a weapon right now
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
NEI4 $551
line 889
;889:	{
line 890
;890:		return;
ADDRGP4 $549
JUMPV
LABELV $551
line 893
;891:	}
;892:
;893:	if ( cent->currentState.weapon == WP_SABER )
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 2
NEI4 $553
line 894
;894:	{
line 895
;895:		trap_R_SetColor( colorTable[CT_WHITE] );
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 897
;896:		// don't need to draw ammo, but we will draw the current saber style in this window
;897:		switch ( cg.predictedPlayerState.fd.saberDrawAnimLevel )
ADDRLP4 40
ADDRGP4 cg+96+760+460
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
EQI4 $561
ADDRLP4 40
INDIRI4
CNSTI4 2
EQI4 $564
ADDRLP4 40
INDIRI4
CNSTI4 3
EQI4 $567
ADDRGP4 $549
JUMPV
line 898
;898:		{
LABELV $561
line 900
;899:		case 1://FORCE_LEVEL_1:
;900:			CG_DrawPic( x, y, 80, 40, cgs.media.HUDSaberStyle1 );
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1117782016
ARGF4
CNSTF4 1109393408
ARGF4
ADDRGP4 cgs+70280+1204
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 901
;901:			break;
ADDRGP4 $549
JUMPV
LABELV $564
line 903
;902:		case 2://FORCE_LEVEL_2:
;903:			CG_DrawPic( x, y, 80, 40, cgs.media.HUDSaberStyle2 );
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1117782016
ARGF4
CNSTF4 1109393408
ARGF4
ADDRGP4 cgs+70280+1208
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 904
;904:			break;
ADDRGP4 $549
JUMPV
LABELV $567
line 906
;905:		case 3://FORCE_LEVEL_3:
;906:			CG_DrawPic( x, y, 80, 40, cgs.media.HUDSaberStyle3 );
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1117782016
ARGF4
CNSTF4 1109393408
ARGF4
ADDRGP4 cgs+70280+1212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 907
;907:			break;
line 909
;908:		}
;909:		return;
ADDRGP4 $549
JUMPV
LABELV $553
line 912
;910:	}
;911:	else
;912:	{
line 913
;913:		value = ps->ammo[weaponData[cent->currentState.weapon].ammoIndex];
ADDRLP4 4
CNSTI4 56
ADDRFP4 0
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
ADDRLP4 32
INDIRP4
CNSTI4 408
ADDP4
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 914
;914:	}
line 916
;915:
;916:	if (value < 0)	// No ammo
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $570
line 917
;917:	{
line 918
;918:		return;
ADDRGP4 $549
JUMPV
LABELV $570
line 962
;919:	}
;920:
;921:
;922:	//
;923:	// ammo
;924:	//
;925:/*	if (cg.oldammo < value)
;926:	{
;927:		cg.oldAmmoTime = cg.time + 200;
;928:	}
;929:
;930:	cg.oldammo = value;
;931:*/
;932:	// Firing or reloading?
;933:/*	if (( pm->ps->weaponstate == WEAPON_FIRING
;934:		&& cg.predictedPlayerState.weaponTime > 100 ))
;935:	{
;936:		numColor_i = CT_LTGREY;
;937:	} */
;938:	// Overcharged?
;939://	else if ( cent->gent->s.powerups & ( 1 << PW_WEAPON_OVERCHARGE ) )
;940://	{
;941://		numColor_i = CT_WHITE;
;942://	}
;943://	else 
;944://	{
;945://		if ( value > 0 ) 
;946://		{
;947://			if (cg.oldAmmoTime > cg.time)
;948://			{
;949://				numColor_i = CT_YELLOW;
;950://			}
;951://			else
;952://			{
;953://				numColor_i = CT_HUD_ORANGE;
;954://			}
;955://		} 
;956://		else 
;957://		{
;958://			numColor_i = CT_RED;
;959://		}
;960://	}
;961:
;962:	numColor_i = CT_HUD_ORANGE;
ADDRLP4 36
CNSTI4 66
ASGNI4
line 964
;963:
;964:	trap_R_SetColor( colorTable[numColor_i] );	
ADDRLP4 36
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 colorTable
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 965
;965:	CG_DrawNumField (x + 30, y + 26, 3, value, 6, 12, NUM_FONT_SMALL,qfalse);
ADDRFP4 4
INDIRI4
CNSTI4 30
ADDI4
ARGI4
ADDRFP4 8
INDIRI4
CNSTI4 26
ADDI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
CNSTI4 6
ARGI4
CNSTI4 12
ARGI4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawNumField
CALLV
pop
line 970
;966:
;967:
;968://cg.snap->ps.ammo[weaponData[cg.snap->ps.weapon].ammoIndex]
;969:
;970:	inc = (float) ammoData[weaponData[cent->currentState.weapon].ammoIndex].max / MAX_TICS;
ADDRLP4 24
CNSTI4 56
ADDRFP4 0
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
ADDRGP4 ammoData
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1096810496
DIVF4
ASGNF4
line 971
;971:	value =ps->ammo[weaponData[cent->currentState.weapon].ammoIndex];
ADDRLP4 4
CNSTI4 56
ADDRFP4 0
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
ADDRLP4 32
INDIRP4
CNSTI4 408
ADDP4
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 973
;972:
;973:	for (i=MAX_TICS-1;i>=0;i--)
ADDRLP4 0
CNSTI4 13
ASGNI4
LABELV $572
line 974
;974:	{
line 976
;975:
;976:		if (value <= 0)	// partial tic
ADDRLP4 4
INDIRF4
CNSTF4 0
GTF4 $576
line 977
;977:		{
line 978
;978:			memcpy(calcColor, colorTable[CT_BLACK], sizeof(vec4_t));
ADDRLP4 8
ARGP4
ADDRGP4 colorTable+16
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 979
;979:		}
ADDRGP4 $577
JUMPV
LABELV $576
line 980
;980:		else if (value < inc)	// partial tic
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
GEF4 $579
line 981
;981:		{
line 982
;982:			memcpy(calcColor, colorTable[CT_WHITE], sizeof(vec4_t));
ADDRLP4 8
ARGP4
ADDRGP4 colorTable+128
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 983
;983:			percent = value / inc;
ADDRLP4 28
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
DIVF4
ASGNF4
line 984
;984:			calcColor[0] *= percent;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 985
;985:			calcColor[1] *= percent;
ADDRLP4 8+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 986
;986:			calcColor[2] *= percent;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 987
;987:		}
ADDRGP4 $580
JUMPV
LABELV $579
line 989
;988:		else
;989:		{
line 990
;990:			memcpy(calcColor, colorTable[CT_WHITE], sizeof(vec4_t));
ADDRLP4 8
ARGP4
ADDRGP4 colorTable+128
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 991
;991:		}
LABELV $580
LABELV $577
line 993
;992:
;993:		trap_R_SetColor( calcColor);
ADDRLP4 8
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 994
;994:		CG_DrawPic( x + ammoTicPos[i].x, 
ADDRLP4 40
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 40
INDIRI4
ADDRGP4 ammoTicPos
ADDP4
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
ADDRLP4 40
INDIRI4
ADDRGP4 ammoTicPos+4
ADDP4
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 40
INDIRI4
ADDRGP4 ammoTicPos+8
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 40
INDIRI4
ADDRGP4 ammoTicPos+12
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 40
INDIRI4
ADDRGP4 ammoTicPos+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1000
;995:			y + ammoTicPos[i].y, 
;996:			ammoTicPos[i].width, 
;997:			ammoTicPos[i].height, 
;998:			ammoTicPos[i].tic );
;999:
;1000:		value -= inc;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
ASGNF4
line 1001
;1001:	}
LABELV $573
line 973
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $572
line 1003
;1002:
;1003:}
LABELV $549
endproc CG_DrawAmmo 44 32
export CG_DrawForcePower
proc CG_DrawForcePower 36 20
line 1011
;1004:
;1005:/*
;1006:================
;1007:CG_DrawForcePower
;1008:================
;1009:*/
;1010:void CG_DrawForcePower(int x,int y)
;1011:{
line 1016
;1012:	int			i;
;1013:	vec4_t		calcColor;
;1014:	float		value,inc,percent;
;1015:
;1016:	inc = (float)  100 / MAX_TICS;
ADDRLP4 24
CNSTF4 1088721481
ASGNF4
line 1017
;1017:	value = cg.snap->ps.fd.forcePower;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 964
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1019
;1018:
;1019:	for (i=MAX_TICS-1;i>=0;i--)
ADDRLP4 0
CNSTI4 13
ASGNI4
LABELV $591
line 1020
;1020:	{
line 1022
;1021:
;1022:		if (value <= 0)	// partial tic
ADDRLP4 4
INDIRF4
CNSTF4 0
GTF4 $595
line 1023
;1023:		{
line 1024
;1024:			memcpy(calcColor, colorTable[CT_BLACK], sizeof(vec4_t));
ADDRLP4 8
ARGP4
ADDRGP4 colorTable+16
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1025
;1025:		}
ADDRGP4 $596
JUMPV
LABELV $595
line 1026
;1026:		else if (value < inc)	// partial tic
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
GEF4 $598
line 1027
;1027:		{
line 1028
;1028:			memcpy(calcColor, colorTable[CT_WHITE], sizeof(vec4_t));
ADDRLP4 8
ARGP4
ADDRGP4 colorTable+128
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1029
;1029:			percent = value / inc;
ADDRLP4 28
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
DIVF4
ASGNF4
line 1030
;1030:			calcColor[0] *= percent;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1031
;1031:			calcColor[1] *= percent;
ADDRLP4 8+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1032
;1032:			calcColor[2] *= percent;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1033
;1033:		}
ADDRGP4 $599
JUMPV
LABELV $598
line 1035
;1034:		else
;1035:		{
line 1036
;1036:			memcpy(calcColor, colorTable[CT_WHITE], sizeof(vec4_t));
ADDRLP4 8
ARGP4
ADDRGP4 colorTable+128
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1037
;1037:		}
LABELV $599
LABELV $596
line 1039
;1038:
;1039:		trap_R_SetColor( calcColor);
ADDRLP4 8
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1040
;1040:		CG_DrawPic( x + forceTicPos[i].x, 
ADDRLP4 32
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 32
INDIRI4
ADDRGP4 forceTicPos
ADDP4
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
ADDRLP4 32
INDIRI4
ADDRGP4 forceTicPos+4
ADDP4
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRI4
ADDRGP4 forceTicPos+8
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRI4
ADDRGP4 forceTicPos+12
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRI4
ADDRGP4 forceTicPos+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1046
;1041:			y + forceTicPos[i].y, 
;1042:			forceTicPos[i].width, 
;1043:			forceTicPos[i].height, 
;1044:			forceTicPos[i].tic );
;1045:
;1046:		value -= inc;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
ASGNF4
line 1047
;1047:	}
LABELV $592
line 1019
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $591
line 1048
;1048:}
LABELV $589
endproc CG_DrawForcePower 36 20
export CG_DrawHUD
proc CG_DrawHUD 128 24
line 1056
;1049:
;1050:/*
;1051:================
;1052:CG_DrawHUD
;1053:================
;1054:*/
;1055:void CG_DrawHUD(centity_t	*cent)
;1056:{
line 1057
;1057:	menuDef_t	*menuHUD = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 1058
;1058:	const char *scoreStr = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 1062
;1059:	int	scoreBias;
;1060:	char scoreBiasStr[16];
;1061:
;1062:	if (cg_hudFiles.integer)
ADDRGP4 cg_hudFiles+12
INDIRI4
CNSTI4 0
EQI4 $609
line 1063
;1063:	{
line 1064
;1064:		int x = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 1065
;1065:		int y = SCREEN_HEIGHT-80;
ADDRLP4 32
CNSTI4 400
ASGNI4
line 1067
;1066:		char ammoString[64];
;1067:		int weapX = x;
ADDRLP4 36
ADDRLP4 28
INDIRI4
ASGNI4
line 1069
;1068:
;1069:		UI_DrawProportionalString( x+16, y+40, va( "%i", cg.snap->ps.stats[STAT_HEALTH] ),
ADDRGP4 $612
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRI4
CNSTI4 16
ADDI4
ARGI4
ADDRLP4 32
INDIRI4
CNSTI4 40
ADDI4
ARGI4
ADDRLP4 104
INDIRP4
ARGP4
CNSTI4 2064
ARGI4
ADDRGP4 colorTable+1008
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 1072
;1070:			UI_SMALLFONT|UI_DROPSHADOW, colorTable[CT_HUD_RED] );
;1071:
;1072:		UI_DrawProportionalString( x+18+14, y+40+14, va( "%i", cg.snap->ps.stats[STAT_ARMOR] ),
ADDRGP4 $612
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 112
CNSTI4 14
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 18
ADDI4
ADDRLP4 112
INDIRI4
ADDI4
ARGI4
ADDRLP4 32
INDIRI4
CNSTI4 40
ADDI4
ADDRLP4 112
INDIRI4
ADDI4
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
CNSTI4 2064
ARGI4
ADDRGP4 colorTable+992
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 1075
;1073:			UI_SMALLFONT|UI_DROPSHADOW, colorTable[CT_HUD_GREEN] );
;1074:
;1075:		if (cg.snap->ps.weapon == WP_SABER)
ADDRGP4 cg+36
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
NEI4 $617
line 1076
;1076:		{
line 1077
;1077:			if (cg.snap->ps.fd.saberDrawAnimLevel == FORCE_LEVEL_3)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1264
ADDP4
INDIRI4
CNSTI4 3
NEI4 $620
line 1078
;1078:			{
line 1079
;1079:				Com_sprintf(ammoString, sizeof(ammoString), "STRONG");
ADDRLP4 40
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $623
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1080
;1080:				weapX += 16;
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1081
;1081:			}
ADDRGP4 $618
JUMPV
LABELV $620
line 1082
;1082:			else if (cg.snap->ps.fd.saberDrawAnimLevel == FORCE_LEVEL_2)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1264
ADDP4
INDIRI4
CNSTI4 2
NEI4 $624
line 1083
;1083:			{
line 1084
;1084:				Com_sprintf(ammoString, sizeof(ammoString), "MEDIUM");
ADDRLP4 40
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $627
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1085
;1085:				weapX += 16;
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1086
;1086:			}
ADDRGP4 $618
JUMPV
LABELV $624
line 1088
;1087:			else
;1088:			{
line 1089
;1089:				Com_sprintf(ammoString, sizeof(ammoString), "FAST");
ADDRLP4 40
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $628
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1090
;1090:			}
line 1091
;1091:		}
ADDRGP4 $618
JUMPV
LABELV $617
line 1093
;1092:		else
;1093:		{
line 1094
;1094:			Com_sprintf(ammoString, sizeof(ammoString), "%i", cg.snap->ps.ammo[weaponData[cent->currentState.weapon].ammoIndex]);
ADDRLP4 40
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $612
ARGP4
CNSTI4 56
ADDRFP4 0
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
ADDRGP4 cg+36
INDIRP4
CNSTI4 452
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1095
;1095:		}
LABELV $618
line 1097
;1096:		
;1097:		UI_DrawProportionalString( SCREEN_WIDTH-(weapX+16+32), y+40, va( "%s", ammoString ),
ADDRGP4 $630
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 116
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 640
ADDRLP4 36
INDIRI4
CNSTI4 16
ADDI4
CNSTI4 32
ADDI4
SUBI4
ARGI4
ADDRLP4 32
INDIRI4
CNSTI4 40
ADDI4
ARGI4
ADDRLP4 116
INDIRP4
ARGP4
CNSTI4 2064
ARGI4
ADDRGP4 colorTable+1056
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 1100
;1098:			UI_SMALLFONT|UI_DROPSHADOW, colorTable[CT_HUD_ORANGE] );
;1099:
;1100:		UI_DrawProportionalString( SCREEN_WIDTH-(x+18+14+32), y+40+14, va( "%i", cg.snap->ps.fd.forcePower),
ADDRGP4 $612
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 964
ADDP4
INDIRI4
ARGI4
ADDRLP4 120
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 124
CNSTI4 14
ASGNI4
CNSTI4 640
ADDRLP4 28
INDIRI4
CNSTI4 18
ADDI4
ADDRLP4 124
INDIRI4
ADDI4
CNSTI4 32
ADDI4
SUBI4
ARGI4
ADDRLP4 32
INDIRI4
CNSTI4 40
ADDI4
ADDRLP4 124
INDIRI4
ADDI4
ARGI4
ADDRLP4 120
INDIRP4
ARGP4
CNSTI4 2064
ARGI4
ADDRGP4 colorTable+1024
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 1103
;1101:			UI_SMALLFONT|UI_DROPSHADOW, colorTable[CT_ICON_BLUE] );
;1102:
;1103:		return;
ADDRGP4 $608
JUMPV
LABELV $609
line 1106
;1104:	}
;1105:
;1106:	if (cgs.gametype >= GT_TEAM)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $634
line 1107
;1107:	{	// tint the hud items based on team
line 1108
;1108:		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED )
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 1
NEI4 $637
line 1109
;1109:			hudTintColor = redhudtint;
ADDRGP4 hudTintColor
ADDRGP4 redhudtint
ASGNP4
ADDRGP4 $635
JUMPV
LABELV $637
line 1110
;1110:		else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 2
NEI4 $640
line 1111
;1111:			hudTintColor = bluehudtint;
ADDRGP4 hudTintColor
ADDRGP4 bluehudtint
ASGNP4
ADDRGP4 $635
JUMPV
LABELV $640
line 1113
;1112:		else // If we're not on a team for whatever reason, leave things as they are.
;1113:			hudTintColor = colorTable[CT_WHITE];
ADDRGP4 hudTintColor
ADDRGP4 colorTable+128
ASGNP4
line 1114
;1114:	}
ADDRGP4 $635
JUMPV
LABELV $634
line 1116
;1115:	else
;1116:	{	// tint the hud items white (dont' tint)
line 1117
;1117:		hudTintColor = colorTable[CT_WHITE];
ADDRGP4 hudTintColor
ADDRGP4 colorTable+128
ASGNP4
line 1118
;1118:	}
LABELV $635
line 1120
;1119:
;1120:	menuHUD = Menus_FindByName("lefthud");
ADDRGP4 $645
ARGP4
ADDRLP4 28
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 1121
;1121:	if (menuHUD)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $646
line 1122
;1122:	{
line 1123
;1123:		CG_DrawHUDLeftFrame1(menuHUD->window.rect.x,menuHUD->window.rect.y);
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawHUDLeftFrame1
CALLV
pop
line 1124
;1124:		CG_DrawArmor(menuHUD->window.rect.x,menuHUD->window.rect.y);
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawArmor
CALLV
pop
line 1125
;1125:		CG_DrawHealth(menuHUD->window.rect.x,menuHUD->window.rect.y);
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawHealth
CALLV
pop
line 1126
;1126:		CG_DrawHUDLeftFrame2(menuHUD->window.rect.x,menuHUD->window.rect.y);
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawHUDLeftFrame2
CALLV
pop
line 1127
;1127:	}
ADDRGP4 $647
JUMPV
LABELV $646
line 1129
;1128:	else
;1129:	{ //Apparently we failed to get proper coordinates from the menu, so resort to manually inputting them.
line 1130
;1130:		CG_DrawHUDLeftFrame1(0,SCREEN_HEIGHT-80);
CNSTI4 0
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 CG_DrawHUDLeftFrame1
CALLV
pop
line 1131
;1131:		CG_DrawArmor(0,SCREEN_HEIGHT-80);
CNSTI4 0
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 CG_DrawArmor
CALLV
pop
line 1132
;1132:		CG_DrawHealth(0,SCREEN_HEIGHT-80);
CNSTI4 0
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 CG_DrawHealth
CALLV
pop
line 1133
;1133:		CG_DrawHUDLeftFrame2(0,SCREEN_HEIGHT-80);
CNSTI4 0
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 CG_DrawHUDLeftFrame2
CALLV
pop
line 1134
;1134:	}
LABELV $647
line 1137
;1135:
;1136:	//scoreStr = va("Score: %i", cgs.clientinfo[cg.snap->ps.clientNum].score);
;1137:	if (0 && cgs.gametype < GT_TEAM )
ADDRGP4 $648
JUMPV
line 1138
;1138:	{	// This is a teamless mode, draw the score bias.
line 1139
;1139:		scoreBias = cg.snap->ps.persistant[PERS_SCORE] - cgs.scores1;
ADDRLP4 8
ADDRGP4 cg+36
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
ADDRGP4 cgs+36308
INDIRI4
SUBI4
ASGNI4
line 1140
;1140:		if (scoreBias == 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $653
line 1141
;1141:		{	// We are the leader!
line 1142
;1142:			if (cgs.scores2 <= 0)
ADDRGP4 cgs+36312
INDIRI4
CNSTI4 0
GTI4 $655
line 1143
;1143:			{	// Nobody to be ahead of yet.
line 1144
;1144:				Com_sprintf(scoreBiasStr, sizeof(scoreBiasStr), "");
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $658
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1145
;1145:			}
ADDRGP4 $654
JUMPV
LABELV $655
line 1147
;1146:			else
;1147:			{
line 1148
;1148:				scoreBias = cg.snap->ps.persistant[PERS_SCORE] - cgs.scores2;
ADDRLP4 8
ADDRGP4 cg+36
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
ADDRGP4 cgs+36312
INDIRI4
SUBI4
ASGNI4
line 1149
;1149:				if (scoreBias == 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $661
line 1150
;1150:				{
line 1151
;1151:					Com_sprintf(scoreBiasStr, sizeof(scoreBiasStr), " (Tie)");
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $663
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1152
;1152:				}
ADDRGP4 $654
JUMPV
LABELV $661
line 1154
;1153:				else
;1154:				{
line 1155
;1155:					Com_sprintf(scoreBiasStr, sizeof(scoreBiasStr), " (+%d)", scoreBias);
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $664
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1156
;1156:				}
line 1157
;1157:			}
line 1158
;1158:		}
ADDRGP4 $654
JUMPV
LABELV $653
line 1160
;1159:		else // if (scoreBias < 0)
;1160:		{	// We are behind!
line 1161
;1161:			Com_sprintf(scoreBiasStr, sizeof(scoreBiasStr), " (%d)", scoreBias);
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $665
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1162
;1162:		}
LABELV $654
line 1163
;1163:		scoreStr = va("Score: %i%s", cg.snap->ps.persistant[PERS_SCORE], scoreBiasStr);
ADDRGP4 $666
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 1164
;1164:	}
ADDRGP4 $649
JUMPV
LABELV $648
line 1166
;1165:	else
;1166:	{	// Don't draw a bias.
line 1167
;1167:		scoreStr = va("Score: %i", cg.snap->ps.persistant[PERS_SCORE]);
ADDRGP4 $668
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 1168
;1168:	}
LABELV $649
line 1169
;1169:	UI_DrawScaledProportionalString(SCREEN_WIDTH-124/*(strlen(scoreStr)*20.5)*/, SCREEN_HEIGHT-23, scoreStr, UI_RIGHT|UI_DROPSHADOW, colorTable[CT_WHITE], 0.7);
CNSTI4 516
ARGI4
CNSTI4 457
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 2050
ARGI4
ADDRGP4 colorTable+128
ARGP4
CNSTF4 1060320051
ARGF4
ADDRGP4 UI_DrawScaledProportionalString
CALLV
pop
line 1171
;1170:
;1171:	menuHUD = Menus_FindByName("righthud");
ADDRGP4 $671
ARGP4
ADDRLP4 32
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 1172
;1172:	if (menuHUD)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $672
line 1173
;1173:	{
line 1174
;1174:		CG_DrawHUDRightFrame1(menuHUD->window.rect.x,menuHUD->window.rect.y);
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawHUDRightFrame1
CALLV
pop
line 1175
;1175:		CG_DrawForcePower(menuHUD->window.rect.x,menuHUD->window.rect.y);
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawForcePower
CALLV
pop
line 1176
;1176:		CG_DrawAmmo(cent,menuHUD->window.rect.x,menuHUD->window.rect.y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawAmmo
CALLV
pop
line 1177
;1177:		CG_DrawHUDRightFrame2(menuHUD->window.rect.x,menuHUD->window.rect.y);
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawHUDRightFrame2
CALLV
pop
line 1179
;1178:
;1179:	}
ADDRGP4 $673
JUMPV
LABELV $672
line 1181
;1180:	else
;1181:	{ //Apparently we failed to get proper coordinates from the menu, so resort to manually inputting them.
line 1182
;1182:		CG_DrawHUDRightFrame1(SCREEN_WIDTH-80,SCREEN_HEIGHT-80);
CNSTI4 560
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 CG_DrawHUDRightFrame1
CALLV
pop
line 1183
;1183:		CG_DrawForcePower(SCREEN_WIDTH-80,SCREEN_HEIGHT-80);
CNSTI4 560
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 CG_DrawForcePower
CALLV
pop
line 1184
;1184:		CG_DrawAmmo(cent,SCREEN_WIDTH-80,SCREEN_HEIGHT-80);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 560
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 CG_DrawAmmo
CALLV
pop
line 1185
;1185:		CG_DrawHUDRightFrame2(SCREEN_WIDTH-80,SCREEN_HEIGHT-80);
CNSTI4 560
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 CG_DrawHUDRightFrame2
CALLV
pop
line 1186
;1186:	}
LABELV $673
line 1187
;1187:}
LABELV $608
endproc CG_DrawHUD 128 24
export ForcePower_Valid
proc ForcePower_Valid 4 0
line 1192
;1188:
;1189:#define MAX_SHOWPOWERS NUM_FORCE_POWERS
;1190:
;1191:qboolean ForcePower_Valid(int i)
;1192:{
line 1193
;1193:	if (i == FP_LEVITATION ||
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $679
ADDRLP4 0
INDIRI4
CNSTI4 15
EQI4 $679
ADDRLP4 0
INDIRI4
CNSTI4 16
EQI4 $679
ADDRLP4 0
INDIRI4
CNSTI4 17
NEI4 $675
LABELV $679
line 1197
;1194:		i == FP_SABERATTACK ||
;1195:		i == FP_SABERDEFEND ||
;1196:		i == FP_SABERTHROW)
;1197:	{
line 1198
;1198:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $674
JUMPV
LABELV $675
line 1201
;1199:	}
;1200:
;1201:	if (cg.snap->ps.fd.forcePowersKnown & (1 << i))
ADDRGP4 cg+36
INDIRP4
CNSTI4 876
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $680
line 1202
;1202:	{
line 1203
;1203:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $674
JUMPV
LABELV $680
line 1206
;1204:	}
;1205:	
;1206:	return qfalse;
CNSTI4 0
RETI4
LABELV $674
endproc ForcePower_Valid 4 0
export CG_DrawForceSelect
proc CG_DrawForceSelect 108 20
line 1215
;1207:}
;1208:
;1209:/*
;1210:===================
;1211:CG_DrawForceSelect
;1212:===================
;1213:*/
;1214:void CG_DrawForceSelect( void ) 
;1215:{
line 1224
;1216:	int		i;
;1217:	int		count;
;1218:	int		smallIconSize,bigIconSize;
;1219:	int		holdX,x,y,x2,y2,pad,length;
;1220:	int		sideLeftIconCnt,sideRightIconCnt;
;1221:	int		sideMax,holdCount,iconCnt;
;1222:
;1223:
;1224:	x2 = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
line 1225
;1225:	y2 = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 1228
;1226:
;1227:	// don't display if dead
;1228:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) 
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 0
GTI4 $684
line 1229
;1229:	{
line 1230
;1230:		return;
ADDRGP4 $683
JUMPV
LABELV $684
line 1233
;1231:	}
;1232:
;1233:	if ((cg.forceSelectTime+WEAPON_SELECT_TIME)<cg.time)	// Time is up for the HUD to display
ADDRGP4 cg+13780
INDIRF4
CNSTF4 1152319488
ADDF4
ADDRGP4 cg+64
INDIRI4
CVIF4 4
GEF4 $687
line 1234
;1234:	{
line 1235
;1235:		cg.forceSelect = cg.snap->ps.fd.forcePowerSelected;
ADDRGP4 cg+3500
ADDRGP4 cg+36
INDIRP4
CNSTI4 884
ADDP4
INDIRI4
ASGNI4
line 1236
;1236:		return;
ADDRGP4 $683
JUMPV
LABELV $687
line 1239
;1237:	}
;1238:
;1239:	if (!cg.snap->ps.fd.forcePowersKnown)
ADDRGP4 cg+36
INDIRP4
CNSTI4 876
ADDP4
INDIRI4
CNSTI4 0
NEI4 $693
line 1240
;1240:	{
line 1241
;1241:		return;
ADDRGP4 $683
JUMPV
LABELV $693
line 1245
;1242:	}
;1243:
;1244:	// count the number of powers owned
;1245:	count = 0;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 1247
;1246:
;1247:	for (i=0;i < NUM_FORCE_POWERS;++i)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $696
line 1248
;1248:	{
line 1249
;1249:		if (ForcePower_Valid(i))
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 ForcePower_Valid
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $700
line 1250
;1250:		{
line 1251
;1251:			count++;
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1252
;1252:		}
LABELV $700
line 1253
;1253:	}
LABELV $697
line 1247
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 18
LTI4 $696
line 1255
;1254:
;1255:	if (count == 0)	// If no force powers, don't display
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $702
line 1256
;1256:	{
line 1257
;1257:		return;
ADDRGP4 $683
JUMPV
LABELV $702
line 1260
;1258:	}
;1259:
;1260:	sideMax = 3;	// Max number of icons on the side
ADDRLP4 48
CNSTI4 3
ASGNI4
line 1263
;1261:
;1262:	// Calculate how many icons will appear to either side of the center one
;1263:	holdCount = count - 1;	// -1 for the center icon
ADDRLP4 44
ADDRLP4 32
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1264
;1264:	if (holdCount == 0)			// No icons to either side
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $704
line 1265
;1265:	{
line 1266
;1266:		sideLeftIconCnt = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 1267
;1267:		sideRightIconCnt = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 1268
;1268:	}
ADDRGP4 $705
JUMPV
LABELV $704
line 1269
;1269:	else if (count > (2*sideMax))	// Go to the max on each side
ADDRLP4 32
INDIRI4
ADDRLP4 48
INDIRI4
CNSTI4 1
LSHI4
LEI4 $706
line 1270
;1270:	{
line 1271
;1271:		sideLeftIconCnt = sideMax;
ADDRLP4 20
ADDRLP4 48
INDIRI4
ASGNI4
line 1272
;1272:		sideRightIconCnt = sideMax;
ADDRLP4 24
ADDRLP4 48
INDIRI4
ASGNI4
line 1273
;1273:	}
ADDRGP4 $707
JUMPV
LABELV $706
line 1275
;1274:	else							// Less than max, so do the calc
;1275:	{
line 1276
;1276:		sideLeftIconCnt = holdCount/2;
ADDRLP4 20
ADDRLP4 44
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1277
;1277:		sideRightIconCnt = holdCount - sideLeftIconCnt;
ADDRLP4 24
ADDRLP4 44
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1278
;1278:	}
LABELV $707
LABELV $705
line 1280
;1279:
;1280:	smallIconSize = 30;
ADDRLP4 8
CNSTI4 30
ASGNI4
line 1281
;1281:	bigIconSize = 60;
ADDRLP4 36
CNSTI4 60
ASGNI4
line 1282
;1282:	pad = 12;
ADDRLP4 16
CNSTI4 12
ASGNI4
line 1284
;1283:
;1284:	x = 320;
ADDRLP4 40
CNSTI4 320
ASGNI4
line 1285
;1285:	y = 425;
ADDRLP4 28
CNSTI4 425
ASGNI4
line 1288
;1286:
;1287:	// Background
;1288:	length = (sideLeftIconCnt * smallIconSize) + (sideLeftIconCnt*pad) +
ADDRLP4 60
ADDRLP4 20
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 20
INDIRI4
ADDRLP4 16
INDIRI4
MULI4
ADDI4
ADDRLP4 36
INDIRI4
ADDI4
ADDRLP4 24
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDI4
ADDRLP4 24
INDIRI4
ADDRLP4 16
INDIRI4
MULI4
ADDI4
CNSTI4 12
ADDI4
ASGNI4
line 1291
;1289:			bigIconSize + (sideRightIconCnt * smallIconSize) + (sideRightIconCnt*pad) + 12;
;1290:	
;1291:	i = BG_ProperForceIndex(cg.forceSelect) - 1;
ADDRGP4 cg+3500
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 BG_ProperForceIndex
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 80
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1292
;1292:	if (i < 0)
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $709
line 1293
;1293:	{
line 1294
;1294:		i = MAX_SHOWPOWERS;
ADDRLP4 0
CNSTI4 18
ASGNI4
line 1295
;1295:	}
LABELV $709
line 1297
;1296:
;1297:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1299
;1298:	// Work backwards from current icon
;1299:	holdX = x - ((bigIconSize/2) + pad + smallIconSize);
ADDRLP4 12
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 2
DIVI4
ADDRLP4 16
INDIRI4
ADDI4
ADDRLP4 8
INDIRI4
ADDI4
SUBI4
ASGNI4
line 1300
;1300:	for (iconCnt=1;iconCnt<(sideLeftIconCnt+1);i--)
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $714
JUMPV
LABELV $711
line 1301
;1301:	{
line 1302
;1302:		if (i < 0)
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $715
line 1303
;1303:		{
line 1304
;1304:			i = MAX_SHOWPOWERS;
ADDRLP4 0
CNSTI4 18
ASGNI4
line 1305
;1305:		}
LABELV $715
line 1307
;1306:
;1307:		if (!ForcePower_Valid(forcePowerSorted[i]))	// Does he have this power?
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 forcePowerSorted
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 ForcePower_Valid
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $717
line 1308
;1308:		{
line 1309
;1309:			continue;
ADDRGP4 $712
JUMPV
LABELV $717
line 1312
;1310:		}
;1311:
;1312:		++iconCnt;					// Good icon
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1314
;1313:
;1314:		if (cgs.media.forcePowerIcons[forcePowerSorted[i]])
ADDRLP4 88
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 88
INDIRI4
LSHI4
ADDRGP4 forcePowerSorted
ADDP4
INDIRI4
ADDRLP4 88
INDIRI4
LSHI4
ADDRGP4 cgs+70280+1096
ADDP4
INDIRI4
CNSTI4 0
EQI4 $719
line 1315
;1315:		{
line 1316
;1316:			CG_DrawPic( holdX, y, smallIconSize, smallIconSize, cgs.media.forcePowerIcons[forcePowerSorted[i]] ); 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 92
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 92
INDIRF4
ARGF4
ADDRLP4 92
INDIRF4
ARGF4
ADDRLP4 96
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 96
INDIRI4
LSHI4
ADDRGP4 forcePowerSorted
ADDP4
INDIRI4
ADDRLP4 96
INDIRI4
LSHI4
ADDRGP4 cgs+70280+1096
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1317
;1317:			holdX -= (smallIconSize+pad);
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
ADDI4
SUBI4
ASGNI4
line 1318
;1318:		}
LABELV $719
line 1319
;1319:	}
LABELV $712
line 1300
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $714
ADDRLP4 4
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
LTI4 $711
line 1321
;1320:
;1321:	if (ForcePower_Valid(cg.forceSelect))
ADDRGP4 cg+3500
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 ForcePower_Valid
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $725
line 1322
;1322:	{
line 1324
;1323:		// Current Center Icon
;1324:		if (cgs.media.forcePowerIcons[cg.forceSelect])
ADDRGP4 cg+3500
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+1096
ADDP4
INDIRI4
CNSTI4 0
EQI4 $728
line 1325
;1325:		{
line 1326
;1326:			CG_DrawPic( x-(bigIconSize/2), (y-((bigIconSize-smallIconSize)/2)), bigIconSize, bigIconSize, cgs.media.forcePowerIcons[cg.forceSelect] ); //only cache the icon for display
ADDRLP4 92
CNSTI4 2
ASGNI4
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 92
INDIRI4
DIVI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ADDRLP4 92
INDIRI4
DIVI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 96
ADDRLP4 36
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRGP4 cg+3500
INDIRI4
ADDRLP4 92
INDIRI4
LSHI4
ADDRGP4 cgs+70280+1096
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1327
;1327:		}
LABELV $728
line 1328
;1328:	}
LABELV $725
line 1330
;1329:
;1330:	i = BG_ProperForceIndex(cg.forceSelect) + 1;
ADDRGP4 cg+3500
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 BG_ProperForceIndex
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1331
;1331:	if (i>MAX_SHOWPOWERS)
ADDRLP4 0
INDIRI4
CNSTI4 18
LEI4 $737
line 1332
;1332:	{
line 1333
;1333:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1334
;1334:	}
LABELV $737
line 1337
;1335:
;1336:	// Work forwards from current icon
;1337:	holdX = x + (bigIconSize/2) + pad;
ADDRLP4 12
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ADDRLP4 16
INDIRI4
ADDI4
ASGNI4
line 1338
;1338:	for (iconCnt=1;iconCnt<(sideRightIconCnt+1);i++)
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $742
JUMPV
LABELV $739
line 1339
;1339:	{
line 1340
;1340:		if (i>MAX_SHOWPOWERS)
ADDRLP4 0
INDIRI4
CNSTI4 18
LEI4 $743
line 1341
;1341:		{
line 1342
;1342:			i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1343
;1343:		}
LABELV $743
line 1345
;1344:
;1345:		if (!ForcePower_Valid(forcePowerSorted[i]))	// Does he have this power?
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 forcePowerSorted
ADDP4
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 ForcePower_Valid
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $745
line 1346
;1346:		{
line 1347
;1347:			continue;
ADDRGP4 $740
JUMPV
LABELV $745
line 1350
;1348:		}
;1349:
;1350:		++iconCnt;					// Good icon
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1352
;1351:
;1352:		if (cgs.media.forcePowerIcons[forcePowerSorted[i]])
ADDRLP4 96
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 96
INDIRI4
LSHI4
ADDRGP4 forcePowerSorted
ADDP4
INDIRI4
ADDRLP4 96
INDIRI4
LSHI4
ADDRGP4 cgs+70280+1096
ADDP4
INDIRI4
CNSTI4 0
EQI4 $747
line 1353
;1353:		{
line 1354
;1354:			CG_DrawPic( holdX, y, smallIconSize, smallIconSize, cgs.media.forcePowerIcons[forcePowerSorted[i]] ); //only cache the icon for display
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 100
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 100
INDIRF4
ARGF4
ADDRLP4 100
INDIRF4
ARGF4
ADDRLP4 104
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 104
INDIRI4
LSHI4
ADDRGP4 forcePowerSorted
ADDP4
INDIRI4
ADDRLP4 104
INDIRI4
LSHI4
ADDRGP4 cgs+70280+1096
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1355
;1355:			holdX += (smallIconSize+pad);
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
ADDI4
ADDI4
ASGNI4
line 1356
;1356:		}
LABELV $747
line 1357
;1357:	}
LABELV $740
line 1338
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $742
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
LTI4 $739
line 1359
;1358:
;1359:	if ( showPowersName[cg.forceSelect] ) 
ADDRGP4 cg+3500
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 showPowersName
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $753
line 1360
;1360:	{
line 1361
;1361:		UI_DrawProportionalString(320, y + 30, CG_GetStripEdString("INGAME", showPowersName[cg.forceSelect]), UI_CENTER | UI_SMALLFONT, colorTable[CT_ICON_BLUE]);
ADDRGP4 $756
ARGP4
ADDRGP4 cg+3500
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 showPowersName
ADDP4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
CNSTI4 320
ARGI4
ADDRLP4 28
INDIRI4
CNSTI4 30
ADDI4
ARGI4
ADDRLP4 92
INDIRP4
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorTable+1024
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 1362
;1362:	}
LABELV $753
line 1363
;1363:}
LABELV $683
endproc CG_DrawForceSelect 108 20
lit
align 4
LABELV $828
byte 4 1050656375
byte 4 1061158912
byte 4 1058994651
byte 4 1065353216
export CG_DrawInvenSelect
code
proc CG_DrawInvenSelect 1136 20
line 1371
;1364:
;1365:/*
;1366:===================
;1367:CG_DrawInventorySelect
;1368:===================
;1369:*/
;1370:void CG_DrawInvenSelect( void ) 
;1371:{
line 1382
;1372:	int				i;
;1373:	int				sideMax,holdCount,iconCnt;
;1374:	int				smallIconSize,bigIconSize;
;1375:	int				sideLeftIconCnt,sideRightIconCnt;
;1376:	int				count;
;1377:	int				holdX,x,y,y2,pad;
;1378:	int				height;
;1379:	float			addX;
;1380:
;1381:	// don't display if dead
;1382:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) 
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 0
GTI4 $760
line 1383
;1383:	{
line 1384
;1384:		return;
ADDRGP4 $759
JUMPV
LABELV $760
line 1387
;1385:	}
;1386:
;1387:	if ((cg.invenSelectTime+WEAPON_SELECT_TIME)<cg.time)	// Time is up for the HUD to display
ADDRGP4 cg+13776
INDIRF4
CNSTF4 1152319488
ADDF4
ADDRGP4 cg+64
INDIRI4
CVIF4 4
GEF4 $763
line 1388
;1388:	{
line 1389
;1389:		return;
ADDRGP4 $759
JUMPV
LABELV $763
line 1392
;1390:	}
;1391:
;1392:	if (!cg.snap->ps.stats[STAT_HOLDABLE_ITEM] || !cg.snap->ps.stats[STAT_HOLDABLE_ITEMS])
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $771
ADDRGP4 cg+36
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $767
LABELV $771
line 1393
;1393:	{
line 1394
;1394:		return;
ADDRGP4 $759
JUMPV
LABELV $767
line 1397
;1395:	}
;1396:
;1397:	if (cg.itemSelect == -1)
ADDRGP4 cg+3504
INDIRI4
CNSTI4 -1
NEI4 $772
line 1398
;1398:	{
line 1399
;1399:		cg.itemSelect = bg_itemlist[cg.snap->ps.stats[STAT_HOLDABLE_ITEM]].giTag;
ADDRGP4 cg+3504
CNSTI4 52
ADDRGP4 cg+36
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 1400
;1400:	}
LABELV $772
line 1405
;1401:
;1402://const int bits = cg.snap->ps.stats[ STAT_ITEMS ];
;1403:
;1404:	// count the number of items owned
;1405:	count = 0;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 1406
;1406:	for ( i = 0 ; i < HI_NUM_HOLDABLE ; i++ ) 
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $778
line 1407
;1407:	{
line 1409
;1408:		if (/*CG_InventorySelectable(i) && inv_icons[i]*/
;1409:			(cg.snap->ps.stats[STAT_HOLDABLE_ITEMS] & (1 << i)) ) 
ADDRGP4 cg+36
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $782
line 1410
;1410:		{
line 1411
;1411:			count++;
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1412
;1412:		}
LABELV $782
line 1413
;1413:	}
LABELV $779
line 1406
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 7
LTI4 $778
line 1415
;1414:
;1415:	if (!count)
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $785
line 1416
;1416:	{
line 1417
;1417:		y2 = 0; //err?
ADDRLP4 60
CNSTI4 0
ASGNI4
line 1418
;1418:		UI_DrawProportionalString(320, y2 + 22, "EMPTY INVENTORY", UI_CENTER | UI_SMALLFONT, colorTable[CT_ICON_BLUE]);
CNSTI4 320
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 22
ADDI4
ARGI4
ADDRGP4 $787
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorTable+1024
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 1419
;1419:		return;
ADDRGP4 $759
JUMPV
LABELV $785
line 1422
;1420:	}
;1421:
;1422:	sideMax = 3;	// Max number of icons on the side
ADDRLP4 56
CNSTI4 3
ASGNI4
line 1425
;1423:
;1424:	// Calculate how many icons will appear to either side of the center one
;1425:	holdCount = count - 1;	// -1 for the center icon
ADDRLP4 48
ADDRLP4 32
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1426
;1426:	if (holdCount == 0)			// No icons to either side
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $789
line 1427
;1427:	{
line 1428
;1428:		sideLeftIconCnt = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 1429
;1429:		sideRightIconCnt = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 1430
;1430:	}
ADDRGP4 $790
JUMPV
LABELV $789
line 1431
;1431:	else if (count > (2*sideMax))	// Go to the max on each side
ADDRLP4 32
INDIRI4
ADDRLP4 56
INDIRI4
CNSTI4 1
LSHI4
LEI4 $791
line 1432
;1432:	{
line 1433
;1433:		sideLeftIconCnt = sideMax;
ADDRLP4 24
ADDRLP4 56
INDIRI4
ASGNI4
line 1434
;1434:		sideRightIconCnt = sideMax;
ADDRLP4 28
ADDRLP4 56
INDIRI4
ASGNI4
line 1435
;1435:	}
ADDRGP4 $792
JUMPV
LABELV $791
line 1437
;1436:	else							// Less than max, so do the calc
;1437:	{
line 1438
;1438:		sideLeftIconCnt = holdCount/2;
ADDRLP4 24
ADDRLP4 48
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1439
;1439:		sideRightIconCnt = holdCount - sideLeftIconCnt;
ADDRLP4 28
ADDRLP4 48
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 1440
;1440:	}
LABELV $792
LABELV $790
line 1442
;1441:
;1442:	i = cg.itemSelect - 1;
ADDRLP4 0
ADDRGP4 cg+3504
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1443
;1443:	if (i<0)
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $794
line 1444
;1444:	{
line 1445
;1445:		i = HI_NUM_HOLDABLE-1;
ADDRLP4 0
CNSTI4 6
ASGNI4
line 1446
;1446:	}
LABELV $794
line 1448
;1447:
;1448:	smallIconSize = 40;
ADDRLP4 8
CNSTI4 40
ASGNI4
line 1449
;1449:	bigIconSize = 80;
ADDRLP4 36
CNSTI4 80
ASGNI4
line 1450
;1450:	pad = 16;
ADDRLP4 16
CNSTI4 16
ASGNI4
line 1452
;1451:
;1452:	x = 320;
ADDRLP4 40
CNSTI4 320
ASGNI4
line 1453
;1453:	y = 410;
ADDRLP4 20
CNSTI4 410
ASGNI4
line 1457
;1454:
;1455:	// Left side ICONS
;1456:	// Work backwards from current icon
;1457:	holdX = x - ((bigIconSize/2) + pad + smallIconSize);
ADDRLP4 12
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 2
DIVI4
ADDRLP4 16
INDIRI4
ADDI4
ADDRLP4 8
INDIRI4
ADDI4
SUBI4
ASGNI4
line 1458
;1458:	height = smallIconSize * cg.iconHUDPercent;
ADDRLP4 44
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRGP4 cg+13768
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1459
;1459:	addX = (float) smallIconSize * .75;
ADDRLP4 52
CNSTF4 1061158912
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1461
;1460:
;1461:	for (iconCnt=0;iconCnt<sideLeftIconCnt;i--)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $800
JUMPV
LABELV $797
line 1462
;1462:	{
line 1463
;1463:		if (i<0)
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $801
line 1464
;1464:		{
line 1465
;1465:			i = HI_NUM_HOLDABLE-1;
ADDRLP4 0
CNSTI4 6
ASGNI4
line 1466
;1466:		}
LABELV $801
line 1468
;1467:
;1468:		if ( !(cg.snap->ps.stats[STAT_HOLDABLE_ITEMS] & (1 << i)) || i == cg.itemSelect )
ADDRGP4 cg+36
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $807
ADDRLP4 0
INDIRI4
ADDRGP4 cg+3504
INDIRI4
NEI4 $803
LABELV $807
line 1469
;1469:		{
line 1470
;1470:			continue;
ADDRGP4 $798
JUMPV
LABELV $803
line 1473
;1471:		}
;1472:
;1473:		++iconCnt;					// Good icon
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1475
;1474:
;1475:		if (cgs.media.invenIcons[i])
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+1068
ADDP4
INDIRI4
CNSTI4 0
EQI4 $808
line 1476
;1476:		{
line 1477
;1477:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1478
;1478:			CG_DrawPic( holdX, y+10, smallIconSize, smallIconSize, cgs.media.invenIcons[i] );
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRI4
CNSTI4 10
ADDI4
CVIF4 4
ARGF4
ADDRLP4 72
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+1068
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1480
;1479:
;1480:			trap_R_SetColor(colorTable[CT_ICON_BLUE]);
ADDRGP4 colorTable+1024
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1485
;1481:			/*CG_DrawNumField (holdX + addX, y + smallIconSize, 2, cg.snap->ps.inventory[i], 6, 12, 
;1482:				NUM_FONT_SMALL,qfalse);
;1483:				*/
;1484:
;1485:			holdX -= (smallIconSize+pad);
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
ADDI4
SUBI4
ASGNI4
line 1486
;1486:		}
LABELV $808
line 1487
;1487:	}
LABELV $798
line 1461
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $800
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $797
line 1490
;1488:
;1489:	// Current Center Icon
;1490:	height = bigIconSize * cg.iconHUDPercent;
ADDRLP4 44
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRGP4 cg+13768
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1491
;1491:	if (cgs.media.invenIcons[cg.itemSelect])
ADDRGP4 cg+3504
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+1068
ADDP4
INDIRI4
CNSTI4 0
EQI4 $816
line 1492
;1492:	{
line 1494
;1493:		int itemNdex;
;1494:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1495
;1495:		CG_DrawPic( x-(bigIconSize/2), (y-((bigIconSize-smallIconSize)/2))+10, bigIconSize, bigIconSize, cgs.media.invenIcons[cg.itemSelect] );
ADDRLP4 76
CNSTI4 2
ASGNI4
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 76
INDIRI4
DIVI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRI4
ADDRLP4 36
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
ADDRLP4 36
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRGP4 cg+3504
INDIRI4
ADDRLP4 76
INDIRI4
LSHI4
ADDRGP4 cgs+70280+1068
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1496
;1496:		addX = (float) bigIconSize * .75;
ADDRLP4 52
CNSTF4 1061158912
ADDRLP4 36
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1497
;1497:		trap_R_SetColor(colorTable[CT_ICON_BLUE]);
ADDRGP4 colorTable+1024
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1501
;1498:		/*CG_DrawNumField ((x-(bigIconSize/2)) + addX, y, 2, cg.snap->ps.inventory[cg.inventorySelect], 6, 12, 
;1499:			NUM_FONT_SMALL,qfalse);*/
;1500:
;1501:		itemNdex = BG_GetItemIndexByTag(cg.itemSelect, IT_HOLDABLE);
ADDRGP4 cg+3504
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 84
ADDRGP4 BG_GetItemIndexByTag
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 84
INDIRI4
ASGNI4
line 1502
;1502:		if (bg_itemlist[itemNdex].classname)
CNSTI4 52
ADDRLP4 68
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $826
line 1503
;1503:		{
line 1504
;1504:			vec4_t	textColor = { .312f, .75f, .621f, 1.0f };
ADDRLP4 88
ADDRGP4 $828
INDIRB
ASGNB 16
line 1507
;1505:			char	text[1024];
;1506:			
;1507:			if ( trap_SP_GetStringTextString( va("INGAME_%s",bg_itemlist[itemNdex].classname), text, sizeof( text )))
ADDRGP4 $831
ARGP4
CNSTI4 52
ADDRLP4 68
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
INDIRP4
ARGP4
ADDRLP4 1128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1128
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1132
ADDRGP4 trap_SP_GetStringTextString
CALLI4
ASGNI4
ADDRLP4 1132
INDIRI4
CNSTI4 0
EQI4 $829
line 1508
;1508:			{
line 1509
;1509:				UI_DrawProportionalString(320, y+45, text, UI_CENTER | UI_SMALLFONT, textColor);
CNSTI4 320
ARGI4
ADDRLP4 20
INDIRI4
CNSTI4 45
ADDI4
ARGI4
ADDRLP4 104
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 88
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 1510
;1510:			}
ADDRGP4 $830
JUMPV
LABELV $829
line 1512
;1511:			else
;1512:			{
line 1513
;1513:				UI_DrawProportionalString(320, y+45, bg_itemlist[itemNdex].classname, UI_CENTER | UI_SMALLFONT, textColor);
CNSTI4 320
ARGI4
ADDRLP4 20
INDIRI4
CNSTI4 45
ADDI4
ARGI4
CNSTI4 52
ADDRLP4 68
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
INDIRP4
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 88
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 1514
;1514:			}
LABELV $830
line 1515
;1515:		}
LABELV $826
line 1516
;1516:	}
LABELV $816
line 1518
;1517:
;1518:	i = cg.itemSelect + 1;
ADDRLP4 0
ADDRGP4 cg+3504
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1519
;1519:	if (i> HI_NUM_HOLDABLE-1)
ADDRLP4 0
INDIRI4
CNSTI4 6
LEI4 $833
line 1520
;1520:	{
line 1521
;1521:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1522
;1522:	}
LABELV $833
line 1526
;1523:
;1524:	// Right side ICONS
;1525:	// Work forwards from current icon
;1526:	holdX = x + (bigIconSize/2) + pad;
ADDRLP4 12
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ADDRLP4 16
INDIRI4
ADDI4
ASGNI4
line 1527
;1527:	height = smallIconSize * cg.iconHUDPercent;
ADDRLP4 44
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRGP4 cg+13768
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1528
;1528:	addX = (float) smallIconSize * .75;
ADDRLP4 52
CNSTF4 1061158912
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1529
;1529:	for (iconCnt=0;iconCnt<sideRightIconCnt;i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $839
JUMPV
LABELV $836
line 1530
;1530:	{
line 1531
;1531:		if (i> HI_NUM_HOLDABLE-1)
ADDRLP4 0
INDIRI4
CNSTI4 6
LEI4 $840
line 1532
;1532:		{
line 1533
;1533:			i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1534
;1534:		}
LABELV $840
line 1536
;1535:
;1536:		if ( !(cg.snap->ps.stats[STAT_HOLDABLE_ITEMS] & (1 << i)) || i == cg.itemSelect )
ADDRGP4 cg+36
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $846
ADDRLP4 0
INDIRI4
ADDRGP4 cg+3504
INDIRI4
NEI4 $842
LABELV $846
line 1537
;1537:		{
line 1538
;1538:			continue;
ADDRGP4 $837
JUMPV
LABELV $842
line 1541
;1539:		}
;1540:
;1541:		++iconCnt;					// Good icon
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1543
;1542:
;1543:		if (cgs.media.invenIcons[i])
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+1068
ADDP4
INDIRI4
CNSTI4 0
EQI4 $847
line 1544
;1544:		{
line 1545
;1545:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1546
;1546:			CG_DrawPic( holdX, y+10, smallIconSize, smallIconSize, cgs.media.invenIcons[i] );
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRI4
CNSTI4 10
ADDI4
CVIF4 4
ARGF4
ADDRLP4 72
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+1068
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1548
;1547:
;1548:			trap_R_SetColor(colorTable[CT_ICON_BLUE]);
ADDRGP4 colorTable+1024
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1552
;1549:			/*CG_DrawNumField (holdX + addX, y + smallIconSize, 2, cg.snap->ps.inventory[i], 6, 12, 
;1550:				NUM_FONT_SMALL,qfalse);*/
;1551:
;1552:			holdX += (smallIconSize+pad);
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
ADDI4
ADDI4
ASGNI4
line 1553
;1553:		}
LABELV $847
line 1554
;1554:	}
LABELV $837
line 1529
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $839
ADDRLP4 4
INDIRI4
ADDRLP4 28
INDIRI4
LTI4 $836
line 1555
;1555:}
LABELV $759
endproc CG_DrawInvenSelect 1136 20
proc CG_DrawStats 4 4
line 1564
;1556:
;1557:/*
;1558:================
;1559:CG_DrawStats
;1560:
;1561:================
;1562:*/
;1563:static void CG_DrawStats( void ) 
;1564:{
line 1574
;1565:	centity_t		*cent;
;1566:/*	playerState_t	*ps;
;1567:	vec3_t			angles;
;1568://	vec3_t		origin;
;1569:
;1570:	if ( cg_drawStatus.integer == 0 ) {
;1571:		return;
;1572:	}
;1573:*/
;1574:	cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 0
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
line 1587
;1575:/*	ps = &cg.snap->ps;
;1576:
;1577:	VectorClear( angles );
;1578:
;1579:	// Do start
;1580:	if (!cg.interfaceStartupDone)
;1581:	{
;1582:		CG_InterfaceStartup();
;1583:	}
;1584:
;1585:	cgi_UI_MenuPaintAll();*/
;1586:
;1587:	CG_DrawHUD(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_DrawHUD
CALLV
pop
line 1593
;1588:	/*CG_DrawArmor(cent);
;1589:	CG_DrawHealth(cent);
;1590:	CG_DrawAmmo(cent);
;1591:
;1592:	CG_DrawTalk(cent);*/
;1593:}
LABELV $854
endproc CG_DrawStats 4 4
export CG_DrawTeamBackground
proc CG_DrawTeamBackground 16 20
line 1603
;1594:
;1595:
;1596:/*
;1597:================
;1598:CG_DrawTeamBackground
;1599:
;1600:================
;1601:*/
;1602:void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team )
;1603:{
line 1606
;1604:	vec4_t		hcolor;
;1605:
;1606:	hcolor[3] = alpha;
ADDRLP4 0+12
ADDRFP4 16
INDIRF4
ASGNF4
line 1607
;1607:	if ( team == TEAM_RED ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
NEI4 $858
line 1608
;1608:		hcolor[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1609
;1609:		hcolor[1] = .2f;
ADDRLP4 0+4
CNSTF4 1045220557
ASGNF4
line 1610
;1610:		hcolor[2] = .2f;
ADDRLP4 0+8
CNSTF4 1045220557
ASGNF4
line 1611
;1611:	} else if ( team == TEAM_BLUE ) {
ADDRGP4 $859
JUMPV
LABELV $858
ADDRFP4 20
INDIRI4
CNSTI4 2
NEI4 $856
line 1612
;1612:		hcolor[0] = .2f;
ADDRLP4 0
CNSTF4 1045220557
ASGNF4
line 1613
;1613:		hcolor[1] = .2f;
ADDRLP4 0+4
CNSTF4 1045220557
ASGNF4
line 1614
;1614:		hcolor[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 1615
;1615:	} else {
line 1616
;1616:		return;
LABELV $863
LABELV $859
line 1620
;1617:	}
;1618://	trap_R_SetColor( hcolor );
;1619:
;1620:	CG_FillRect ( x, y, w, h, hcolor );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1622
;1621://	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
;1622:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1623
;1623:}
LABELV $856
endproc CG_DrawTeamBackground 16 20
proc CG_DrawMiniScoreboard 84 36
line 1640
;1624:
;1625:
;1626:/*
;1627:===========================================================================================
;1628:
;1629:  UPPER RIGHT CORNER
;1630:
;1631:===========================================================================================
;1632:*/
;1633:
;1634:/*
;1635:================
;1636:CG_DrawMiniScoreboard
;1637:================
;1638:*/
;1639:static float CG_DrawMiniScoreboard ( float y ) 
;1640:{
line 1643
;1641:	char temp[MAX_QPATH];
;1642:
;1643:	if ( !cg_drawScores.integer )
ADDRGP4 cg_drawScores+12
INDIRI4
CNSTI4 0
NEI4 $867
line 1644
;1644:	{
line 1645
;1645:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $866
JUMPV
LABELV $867
line 1648
;1646:	}
;1647:
;1648:	if ( cgs.gametype >= GT_TEAM )
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $870
line 1649
;1649:	{
line 1650
;1650:		strcpy ( temp, "Red: " );
ADDRLP4 0
ARGP4
ADDRGP4 $873
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1651
;1651:		Q_strcat ( temp, MAX_QPATH, cgs.scores1==SCORE_NOT_PRESENT?"-":(va("%i",cgs.scores1)) );
ADDRGP4 cgs+36308
INDIRI4
CNSTI4 -9999
NEI4 $878
ADDRLP4 64
ADDRGP4 $875
ASGNP4
ADDRGP4 $879
JUMPV
LABELV $878
ADDRGP4 $612
ARGP4
ADDRGP4 cgs+36308
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
LABELV $879
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1652
;1652:		Q_strcat ( temp, MAX_QPATH, " Blue: " );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $880
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1653
;1653:		Q_strcat ( temp, MAX_QPATH, cgs.scores2==SCORE_NOT_PRESENT?"-":(va("%i",cgs.scores2)) );
ADDRGP4 cgs+36312
INDIRI4
CNSTI4 -9999
NEI4 $884
ADDRLP4 72
ADDRGP4 $875
ASGNP4
ADDRGP4 $885
JUMPV
LABELV $884
ADDRGP4 $612
ARGP4
ADDRGP4 cgs+36312
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 76
INDIRP4
ASGNP4
LABELV $885
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1655
;1654:
;1655:		CG_Text_Paint( 630 - CG_Text_Width ( temp, 0.7f, FONT_MEDIUM ), y, 0.7f, colorWhite, temp, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE, FONT_MEDIUM );
ADDRLP4 0
ARGP4
CNSTF4 1060320051
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 80
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
CNSTI4 630
ADDRLP4 80
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1060320051
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 0
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1656
;1656:		y += 15;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1657
;1657:	}
LABELV $870
line 1659
;1658:	else
;1659:	{
line 1671
;1660:		/*
;1661:		strcpy ( temp, "1st: " );
;1662:		Q_strcat ( temp, MAX_QPATH, cgs.scores1==SCORE_NOT_PRESENT?"-":(va("%i",cgs.scores1)) );
;1663:		
;1664:		Q_strcat ( temp, MAX_QPATH, " 2nd: " );
;1665:		Q_strcat ( temp, MAX_QPATH, cgs.scores2==SCORE_NOT_PRESENT?"-":(va("%i",cgs.scores2)) );
;1666:		
;1667:		CG_Text_Paint( 630 - CG_Text_Width ( temp, 0.7f, FONT_SMALL ), y, 0.7f, colorWhite, temp, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE, FONT_MEDIUM );
;1668:		y += 15;
;1669:		*/
;1670:		//rww - no longer doing this. Since the attacker now shows who is first, we print the score there.
;1671:	}		
LABELV $871
line 1674
;1672:	
;1673:
;1674:	return y;
ADDRFP4 0
INDIRF4
RETF4
LABELV $866
endproc CG_DrawMiniScoreboard 84 36
proc CG_DrawEnemyInfo 44 36
line 1683
;1675:}
;1676:
;1677:/*
;1678:================
;1679:CG_DrawEnemyInfo
;1680:================
;1681:*/
;1682:static float CG_DrawEnemyInfo ( float y ) 
;1683:{
line 1689
;1684:	float		size;
;1685:	int			clientNum;
;1686:	const char	*title;
;1687:	clientInfo_t	*ci;
;1688:
;1689:	if ( !cg_drawEnemyInfo.integer ) 
ADDRGP4 cg_drawEnemyInfo+12
INDIRI4
CNSTI4 0
NEI4 $887
line 1690
;1690:	{
line 1691
;1691:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $886
JUMPV
LABELV $887
line 1694
;1692:	}
;1693:
;1694:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) 
ADDRGP4 cg+96+216
INDIRI4
CNSTI4 0
GTI4 $890
line 1695
;1695:	{
line 1696
;1696:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $886
JUMPV
LABELV $890
line 1699
;1697:	}
;1698:	
;1699:	if ( cgs.gametype == GT_JEDIMASTER )
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 2
NEI4 $894
line 1700
;1700:	{
line 1702
;1701:		//title = "Jedi Master";
;1702:		title = CG_GetStripEdString("INGAMETEXT", "MASTERY7");
ADDRGP4 $897
ARGP4
ADDRGP4 $898
ARGP4
ADDRLP4 16
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 1703
;1703:		clientNum = cgs.jediMaster;
ADDRLP4 12
ADDRGP4 cgs+36316
INDIRI4
ASGNI4
line 1705
;1704:
;1705:		if ( clientNum < 0 )
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $895
line 1706
;1706:		{
line 1709
;1707:			//return y;
;1708://			title = "Get Saber!";
;1709:			title = CG_GetStripEdString("INGAMETEXT", "GET_SABER");
ADDRGP4 $897
ARGP4
ADDRGP4 $902
ARGP4
ADDRLP4 20
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 1712
;1710:
;1711:
;1712:			size = ICON_SIZE * 1.25;
ADDRLP4 0
CNSTF4 1114636288
ASGNF4
line 1713
;1713:			y += 5;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 1715
;1714:
;1715:			CG_DrawPic( 640 - size - 12, y, size, size, cgs.media.weaponIcons[WP_SABER] );
CNSTF4 1142947840
ADDRLP4 0
INDIRF4
SUBF4
CNSTF4 1094713344
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+70280+940+8
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1717
;1716:
;1717:			y += size;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 1724
;1718:
;1719:			/*
;1720:			CG_Text_Paint( 630 - CG_Text_Width ( ci->name, 0.7f, FONT_MEDIUM ), y, 0.7f, colorWhite, ci->name, 0, 0, 0, FONT_MEDIUM );
;1721:			y += 15;
;1722:			*/
;1723:
;1724:			CG_Text_Paint( 630 - CG_Text_Width ( title, 0.7f, FONT_MEDIUM ), y, 0.7f, colorWhite, title, 0, 0, 0, FONT_MEDIUM );
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1060320051
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
CNSTI4 630
ADDRLP4 28
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1060320051
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1726
;1725:
;1726:			return y + BIGCHAR_HEIGHT + 2;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1073741824
ADDF4
RETF4
ADDRGP4 $886
JUMPV
line 1728
;1727:		}
;1728:	}
LABELV $894
line 1729
;1729:	else if ( cg.snap->ps.duelInProgress )
ADDRGP4 cg+36
INDIRP4
CNSTI4 1336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $906
line 1730
;1730:	{
line 1732
;1731://		title = "Dueling";
;1732:		title = CG_GetStripEdString("INGAMETEXT", "DUELING");
ADDRGP4 $897
ARGP4
ADDRGP4 $909
ARGP4
ADDRLP4 16
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 1733
;1733:		clientNum = cg.snap->ps.duelIndex;
ADDRLP4 12
ADDRGP4 cg+36
INDIRP4
CNSTI4 1328
ADDP4
INDIRI4
ASGNI4
line 1734
;1734:	}
ADDRGP4 $907
JUMPV
LABELV $906
line 1735
;1735:	else if ( cgs.gametype == GT_TOURNAMENT && cgs.clientinfo[cg.snap->ps.clientNum].team != TEAM_SPECTATOR)
ADDRLP4 16
CNSTI4 3
ASGNI4
ADDRGP4 cgs+32960
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $911
CNSTI4 788
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $911
line 1736
;1736:	{
line 1738
;1737://		title = "Dueling";
;1738:		title = CG_GetStripEdString("INGAMETEXT", "DUELING");
ADDRGP4 $897
ARGP4
ADDRGP4 $909
ARGP4
ADDRLP4 20
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 1739
;1739:		if (cg.snap->ps.clientNum == cgs.duelist1)
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRGP4 cgs+36324
INDIRI4
NEI4 $917
line 1740
;1740:		{
line 1741
;1741:			clientNum = cgs.duelist2;
ADDRLP4 12
ADDRGP4 cgs+36328
INDIRI4
ASGNI4
line 1742
;1742:		}
ADDRGP4 $912
JUMPV
LABELV $917
line 1743
;1743:		else if (cg.snap->ps.clientNum == cgs.duelist2)
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ADDRGP4 cgs+36328
INDIRI4
NEI4 $922
line 1744
;1744:		{
line 1745
;1745:			clientNum = cgs.duelist1;
ADDRLP4 12
ADDRGP4 cgs+36324
INDIRI4
ASGNI4
line 1746
;1746:		}
ADDRGP4 $912
JUMPV
LABELV $922
line 1748
;1747:		else
;1748:		{
line 1749
;1749:			return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $886
JUMPV
line 1751
;1750:		}
;1751:	}
LABELV $911
line 1753
;1752:	else
;1753:	{
line 1770
;1754:		/*
;1755:		title = "Attacker";
;1756:		clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
;1757:
;1758:		if ( clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum ) 
;1759:		{
;1760:			return y;
;1761:		}
;1762:
;1763:		if ( cg.time - cg.attackerTime > ATTACKER_HEAD_TIME ) 
;1764:		{
;1765:			cg.attackerTime = 0;
;1766:			return y;
;1767:		}
;1768:		*/
;1769:		//As of current, we don't want to draw the attacker. Instead, draw whoever is in first place.
;1770:		if (cgs.duelWinner < 0 || cgs.duelWinner >= MAX_CLIENTS)
ADDRGP4 cgs+36320
INDIRI4
CNSTI4 0
LTI4 $931
ADDRGP4 cgs+36320
INDIRI4
CNSTI4 32
LTI4 $927
LABELV $931
line 1771
;1771:		{
line 1772
;1772:			return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $886
JUMPV
LABELV $927
line 1776
;1773:		}
;1774:
;1775:
;1776:		title = va("%s: %i",CG_GetStripEdString("INGAMETEXT", "LEADER"), cgs.scores1);
ADDRGP4 $897
ARGP4
ADDRGP4 $933
ARGP4
ADDRLP4 20
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRGP4 $932
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 cgs+36308
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 1788
;1777:
;1778:		/*
;1779:		if (cgs.scores1 == 1)
;1780:		{
;1781:			title = va("%i kill", cgs.scores1);
;1782:		}
;1783:		else
;1784:		{
;1785:			title = va("%i kills", cgs.scores1);
;1786:		}
;1787:		*/
;1788:		clientNum = cgs.duelWinner;
ADDRLP4 12
ADDRGP4 cgs+36320
INDIRI4
ASGNI4
line 1789
;1789:	}
LABELV $912
LABELV $907
LABELV $895
line 1791
;1790:
;1791:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 4
CNSTI4 788
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 1793
;1792:
;1793:	if (!ci || !ci->modelIcon)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $939
ADDRLP4 4
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
CNSTI4 0
NEI4 $937
LABELV $939
line 1794
;1794:	{
line 1795
;1795:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $886
JUMPV
LABELV $937
line 1798
;1796:	}
;1797:
;1798:	size = ICON_SIZE * 1.25;
ADDRLP4 0
CNSTF4 1114636288
ASGNF4
line 1799
;1799:	y += 5;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 1801
;1800:
;1801:	CG_DrawPic( 640 - size - 5, y, size, size, ci->modelIcon );
CNSTF4 1142947840
ADDRLP4 0
INDIRF4
SUBF4
CNSTF4 1084227584
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1803
;1802:
;1803:	y += size;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 1805
;1804:
;1805:	CG_Text_Paint( 630 - CG_Text_Width ( ci->name, 0.7f, FONT_MEDIUM ), y, 0.7f, colorWhite, ci->name, 0, 0, 0, FONT_MEDIUM );
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
CNSTF4 1060320051
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
CNSTI4 630
ADDRLP4 28
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1060320051
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1807
;1806:
;1807:	y += 15;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1808
;1808:	CG_Text_Paint( 630 - CG_Text_Width ( title, 0.7f, FONT_MEDIUM ), y, 0.7f, colorWhite, title, 0, 0, 0, FONT_MEDIUM );
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1060320051
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 36
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
CNSTI4 630
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1060320051
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1810
;1809:
;1810:	return y + BIGCHAR_HEIGHT + 2;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1073741824
ADDF4
RETF4
LABELV $886
endproc CG_DrawEnemyInfo 44 36
proc CG_DrawSnapshot 16 16
line 1818
;1811:}
;1812:
;1813:/*
;1814:==================
;1815:CG_DrawSnapshot
;1816:==================
;1817:*/
;1818:static float CG_DrawSnapshot( float y ) {
line 1822
;1819:	char		*s;
;1820:	int			w;
;1821:
;1822:	s = va( "time:%i snap:%i cmd:%i", cg.snap->serverTime, 
ADDRGP4 $941
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+32948
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1824
;1823:		cg.latestSnapshotNum, cgs.serverCommandSequence );
;1824:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1826
;1825:
;1826:	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1828
;1827:
;1828:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $940
endproc CG_DrawSnapshot 16 16
bss
align 4
LABELV $946
skip 16
align 4
LABELV $947
skip 4
align 4
LABELV $948
skip 4
code
proc CG_DrawFPS 44 16
line 1837
;1829:}
;1830:
;1831:/*
;1832:==================
;1833:CG_DrawFPS
;1834:==================
;1835:*/
;1836:#define	FPS_FRAMES	4
;1837:static float CG_DrawFPS( float y ) {
line 1849
;1838:	char		*s;
;1839:	int			w;
;1840:	static int	previousTimes[FPS_FRAMES];
;1841:	static int	index;
;1842:	int		i, total;
;1843:	int		fps;
;1844:	static	int	previous;
;1845:	int		t, frameTime;
;1846:
;1847:	// don't use serverTime, because that will be drifting to
;1848:	// correct for internet lag changes, timescales, timedemos, etc
;1849:	t = trap_Milliseconds();
ADDRLP4 28
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
line 1850
;1850:	frameTime = t - previous;
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 $948
INDIRI4
SUBI4
ASGNI4
line 1851
;1851:	previous = t;
ADDRGP4 $948
ADDRLP4 8
INDIRI4
ASGNI4
line 1853
;1852:
;1853:	previousTimes[index % FPS_FRAMES] = frameTime;
ADDRGP4 $947
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $946
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1854
;1854:	index++;
ADDRLP4 32
ADDRGP4 $947
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1855
;1855:	if ( index > FPS_FRAMES ) {
ADDRGP4 $947
INDIRI4
CNSTI4 4
LEI4 $949
line 1857
;1856:		// average multiple frames together to smooth changes out a bit
;1857:		total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1858
;1858:		for ( i = 0 ; i < FPS_FRAMES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $951
line 1859
;1859:			total += previousTimes[i];
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $946
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1860
;1860:		}
LABELV $952
line 1858
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $951
line 1861
;1861:		if ( !total ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $955
line 1862
;1862:			total = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1863
;1863:		}
LABELV $955
line 1864
;1864:		fps = 1000 * FPS_FRAMES / total;
ADDRLP4 24
CNSTI4 4000
ADDRLP4 4
INDIRI4
DIVI4
ASGNI4
line 1866
;1865:
;1866:		s = va( "%ifps", fps );
ADDRGP4 $957
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 1867
;1867:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1869
;1868:
;1869:		CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 20
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1870
;1870:	}
LABELV $949
line 1872
;1871:
;1872:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $945
endproc CG_DrawFPS 44 16
proc CG_DrawTimer 32 16
line 1880
;1873:}
;1874:
;1875:/*
;1876:=================
;1877:CG_DrawTimer
;1878:=================
;1879:*/
;1880:static float CG_DrawTimer( float y ) {
line 1886
;1881:	char		*s;
;1882:	int			w;
;1883:	int			mins, seconds, tens;
;1884:	int			msec;
;1885:
;1886:	msec = cg.time - cgs.levelStartTime;
ADDRLP4 20
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgs+36304
INDIRI4
SUBI4
ASGNI4
line 1888
;1887:
;1888:	seconds = msec / 1000;
ADDRLP4 0
ADDRLP4 20
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 1889
;1889:	mins = seconds / 60;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1890
;1890:	seconds -= mins * 60;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDRLP4 8
INDIRI4
MULI4
SUBI4
ASGNI4
line 1891
;1891:	tens = seconds / 10;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 1892
;1892:	seconds -= tens * 10;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 10
ADDRLP4 12
INDIRI4
MULI4
SUBI4
ASGNI4
line 1894
;1893:
;1894:	s = va( "%i:%i%i", mins, tens, seconds );
ADDRGP4 $961
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 1895
;1895:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 28
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1897
;1896:
;1897:	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1899
;1898:
;1899:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $958
endproc CG_DrawTimer 32 16
proc CG_DrawTeamOverlay 148 36
line 1909
;1900:}
;1901:
;1902:
;1903:/*
;1904:=================
;1905:CG_DrawTeamOverlay
;1906:=================
;1907:*/
;1908:
;1909:static float CG_DrawTeamOverlay( float y, qboolean right, qboolean upper ) {
line 1921
;1910:	int x, w, h, xx;
;1911:	int i, j, len;
;1912:	const char *p;
;1913:	vec4_t		hcolor;
;1914:	int pwidth, lwidth;
;1915:	int plyrs;
;1916:	char st[16];
;1917:	clientInfo_t *ci;
;1918:	gitem_t	*item;
;1919:	int ret_y, count;
;1920:
;1921:	if ( !cg_drawTeamOverlay.integer ) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
NEI4 $963
line 1922
;1922:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $962
JUMPV
LABELV $963
line 1925
;1923:	}
;1924:
;1925:	if ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE ) {
ADDRLP4 92
CNSTI4 336
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $966
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $966
line 1926
;1926:		return y; // Not on any team
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $962
JUMPV
LABELV $966
line 1929
;1927:	}
;1928:
;1929:	plyrs = 0;
ADDRLP4 76
CNSTI4 0
ASGNI4
line 1932
;1930:
;1931:	// max player name width
;1932:	pwidth = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 1933
;1933:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
ADDRGP4 numSortedTeamPlayers
INDIRI4
CNSTI4 8
LEI4 $971
ADDRLP4 96
CNSTI4 8
ASGNI4
ADDRGP4 $972
JUMPV
LABELV $971
ADDRLP4 96
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
LABELV $972
ADDRLP4 48
ADDRLP4 96
INDIRI4
ASGNI4
line 1934
;1934:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $976
JUMPV
LABELV $973
line 1935
;1935:		ci = cgs.clientinfo + sortedTeamPlayers[i];
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
line 1936
;1936:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $978
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
NEI4 $978
line 1937
;1937:			plyrs++;
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1938
;1938:			len = CG_DrawStrlen(ci->name);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 104
INDIRI4
ASGNI4
line 1939
;1939:			if (len > pwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $981
line 1940
;1940:				pwidth = len;
ADDRLP4 56
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $981
line 1941
;1941:		}
LABELV $978
line 1942
;1942:	}
LABELV $974
line 1934
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $976
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $973
line 1944
;1943:
;1944:	if (!plyrs)
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $983
line 1945
;1945:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $962
JUMPV
LABELV $983
line 1947
;1946:
;1947:	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
ADDRLP4 56
INDIRI4
CNSTI4 12
LEI4 $985
line 1948
;1948:		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;
ADDRLP4 56
CNSTI4 12
ASGNI4
LABELV $985
line 1951
;1949:
;1950:	// max location name width
;1951:	lwidth = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 1952
;1952:	for (i = 1; i < MAX_LOCATIONS; i++) {
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $987
line 1953
;1953:		p = CG_ConfigString(CS_LOCATIONS + i);
ADDRLP4 8
INDIRI4
CNSTI4 640
ADDI4
ARGI4
ADDRLP4 100
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 100
INDIRP4
ASGNP4
line 1954
;1954:		if (p && *p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $991
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $991
line 1955
;1955:			len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 108
INDIRI4
ASGNI4
line 1956
;1956:			if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $993
line 1957
;1957:				lwidth = len;
ADDRLP4 44
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $993
line 1958
;1958:		}
LABELV $991
line 1959
;1959:	}
LABELV $988
line 1952
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $987
line 1961
;1960:
;1961:	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
ADDRLP4 44
INDIRI4
CNSTI4 16
LEI4 $995
line 1962
;1962:		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;
ADDRLP4 44
CNSTI4 16
ASGNI4
LABELV $995
line 1964
;1963:
;1964:	w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;
ADDRLP4 80
ADDRLP4 56
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
CNSTI4 3
LSHI4
CNSTI4 32
ADDI4
CNSTI4 56
ADDI4
ASGNI4
line 1966
;1965:
;1966:	if ( right )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $997
line 1967
;1967:		x = 640 - w;
ADDRLP4 52
CNSTI4 640
ADDRLP4 80
INDIRI4
SUBI4
ASGNI4
ADDRGP4 $998
JUMPV
LABELV $997
line 1969
;1968:	else
;1969:		x = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
LABELV $998
line 1971
;1970:
;1971:	h = plyrs * TINYCHAR_HEIGHT;
ADDRLP4 84
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1973
;1972:
;1973:	if ( upper ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $999
line 1974
;1974:		ret_y = y + h;
ADDRLP4 88
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ASGNI4
line 1975
;1975:	} else {
ADDRGP4 $1000
JUMPV
LABELV $999
line 1976
;1976:		y -= h;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1977
;1977:		ret_y = y;
ADDRLP4 88
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 1978
;1978:	}
LABELV $1000
line 1980
;1979:
;1980:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1001
line 1981
;1981:		hcolor[0] = 1.0f;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 1982
;1982:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 1983
;1983:		hcolor[2] = 0.0f;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 1984
;1984:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1985
;1985:	} else { // if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 $1002
JUMPV
LABELV $1001
line 1986
;1986:		hcolor[0] = 0.0f;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 1987
;1987:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 1988
;1988:		hcolor[2] = 1.0f;
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 1989
;1989:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1990
;1990:	}
LABELV $1002
line 1991
;1991:	trap_R_SetColor( hcolor );
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1992
;1992:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRLP4 52
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 84
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+70280+104
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1993
;1993:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1995
;1994:
;1995:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1015
JUMPV
LABELV $1012
line 1996
;1996:		ci = cgs.clientinfo + sortedTeamPlayers[i];
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
line 1997
;1997:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1017
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
NEI4 $1017
line 1999
;1998:
;1999:			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
ADDRLP4 104
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 104
INDIRF4
ASGNF4
line 2001
;2000:
;2001:			xx = x + TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 2003
;2002:
;2003:			CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 112
CNSTI4 8
ASGNI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
CNSTI4 12
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2007
;2004:				ci->name, hcolor, qfalse, qfalse,
;2005:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH);
;2006:
;2007:			if (lwidth) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $1023
line 2008
;2008:				p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 640
ADDI4
ARGI4
ADDRLP4 116
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 116
INDIRP4
ASGNP4
line 2009
;2009:				if (!p || !*p)
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1027
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1025
LABELV $1027
line 2010
;2010:					p = "unknown";
ADDRLP4 20
ADDRGP4 $1028
ASGNP4
LABELV $1025
line 2011
;2011:				len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 124
INDIRI4
ASGNI4
line 2012
;2012:				if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $1029
line 2013
;2013:					len = lwidth;
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
LABELV $1029
line 2017
;2014:
;2015://				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth + 
;2016://					((lwidth/2 - len/2) * TINYCHAR_WIDTH);
;2017:				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 16
ADDI4
ADDRLP4 56
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 2018
;2018:				CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2021
;2019:					p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
;2020:					TEAM_OVERLAY_MAXLOCATION_WIDTH);
;2021:			}
LABELV $1023
line 2023
;2022:
;2023:			CG_GetColorForHealth( ci->health, ci->armor, hcolor );
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
ADDRLP4 24
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 2025
;2024:
;2025:			Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);
ADDRLP4 60
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $1031
ARGP4
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
ADDRGP4 Com_sprintf
CALLV
pop
line 2027
;2026:
;2027:			xx = x + TINYCHAR_WIDTH * 3 + 
ADDRLP4 124
CNSTI4 3
ASGNI4
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 24
ADDI4
ADDRLP4 56
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ADDRLP4 44
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ASGNI4
line 2030
;2028:				TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;
;2029:
;2030:			CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2035
;2031:				st, hcolor, qfalse, qfalse,
;2032:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0 );
;2033:
;2034:			// draw weapon icon
;2035:			xx += TINYCHAR_WIDTH * 3;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 2037
;2036:
;2037:			if ( cg_weapons[ci->curWeapon].weaponIcon ) {
CNSTI4 208
ADDRLP4 4
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+56
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1032
line 2038
;2038:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 136
CNSTF4 1090519040
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
CNSTI4 208
ADDRLP4 4
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+56
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2040
;2039:					cg_weapons[ci->curWeapon].weaponIcon );
;2040:			} else {
ADDRGP4 $1033
JUMPV
LABELV $1032
line 2041
;2041:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 136
CNSTF4 1090519040
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRGP4 cgs+70280+108
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2043
;2042:					cgs.media.deferShader );
;2043:			}
LABELV $1033
line 2046
;2044:
;2045:			// Draw powerup icons
;2046:			if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $1038
line 2047
;2047:				xx = x;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 2048
;2048:			} else {
ADDRGP4 $1039
JUMPV
LABELV $1038
line 2049
;2049:				xx = x + w - TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
CNSTI4 8
SUBI4
ASGNI4
line 2050
;2050:			}
LABELV $1039
line 2051
;2051:			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1040
line 2052
;2052:				if (ci->powerups & (1 << j)) {
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
EQI4 $1044
line 2054
;2053:
;2054:					item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 136
INDIRP4
ASGNP4
line 2056
;2055:
;2056:					if (item) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1046
line 2057
;2057:						CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 144
CNSTF4 1090519040
ASGNF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2059
;2058:						trap_R_RegisterShader( item->icon ) );
;2059:						if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $1048
line 2060
;2060:							xx -= TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 2061
;2061:						} else {
ADDRGP4 $1049
JUMPV
LABELV $1048
line 2062
;2062:							xx += TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 2063
;2063:						}
LABELV $1049
line 2064
;2064:					}
LABELV $1046
line 2065
;2065:				}
LABELV $1044
line 2066
;2066:			}
LABELV $1041
line 2051
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LEI4 $1040
line 2068
;2067:
;2068:			y += TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2069
;2069:		}
LABELV $1017
line 2070
;2070:	}
LABELV $1013
line 1995
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1015
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $1012
line 2072
;2071:
;2072:	return ret_y;
ADDRLP4 88
INDIRI4
CVIF4 4
RETF4
LABELV $962
endproc CG_DrawTeamOverlay 148 36
proc CG_DrawPowerupIcons 44 20
line 2078
;2073://#endif
;2074:}
;2075:
;2076:
;2077:static void CG_DrawPowerupIcons(int y)
;2078:{
line 2080
;2079:	int j;
;2080:	int ico_size = 64;
ADDRLP4 4
CNSTI4 64
ASGNI4
line 2084
;2081:	//int y = ico_size/2;
;2082:	gitem_t	*item;
;2083:
;2084:	if (!cg.snap)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1051
line 2085
;2085:	{
line 2086
;2086:		return;
ADDRGP4 $1050
JUMPV
LABELV $1051
line 2089
;2087:	}
;2088:
;2089:	y += 16;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 2091
;2090:
;2091:	for (j = 0; j <= PW_NUM_POWERUPS; j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1054
line 2092
;2092:	{
line 2093
;2093:		if (cg.snap->ps.powerups[j] > cg.time)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $1058
line 2094
;2094:		{
line 2095
;2095:			int secondsleft = (cg.snap->ps.powerups[j] - cg.time)/1000;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2097
;2096:
;2097:			item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 2099
;2098:
;2099:			if (item)
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1064
line 2100
;2100:			{
line 2101
;2101:				int icoShader = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2102
;2102:				if (cgs.gametype == GT_CTY && (j == PW_REDFLAG || j == PW_BLUEFLAG))
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $1066
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $1069
ADDRLP4 0
INDIRI4
CNSTI4 5
NEI4 $1066
LABELV $1069
line 2103
;2103:				{
line 2104
;2104:					if (j == PW_REDFLAG)
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $1070
line 2105
;2105:					{
line 2106
;2106:						icoShader = trap_R_RegisterShaderNoMip( "gfx/hud/mpi_rflag_ys" );
ADDRGP4 $1072
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 28
INDIRI4
ASGNI4
line 2107
;2107:					}
ADDRGP4 $1067
JUMPV
LABELV $1070
line 2109
;2108:					else
;2109:					{
line 2110
;2110:						icoShader = trap_R_RegisterShaderNoMip( "gfx/hud/mpi_bflag_ys" );
ADDRGP4 $1073
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 28
INDIRI4
ASGNI4
line 2111
;2111:					}
line 2112
;2112:				}
ADDRGP4 $1067
JUMPV
LABELV $1066
line 2114
;2113:				else
;2114:				{
line 2115
;2115:					icoShader = trap_R_RegisterShader( item->icon );
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 28
INDIRI4
ASGNI4
line 2116
;2116:				}
LABELV $1067
line 2118
;2117:
;2118:				CG_DrawPic( (640-(ico_size*1.1)), y, ico_size, ico_size, icoShader );
ADDRLP4 28
ADDRLP4 4
INDIRI4
CVIF4 4
ASGNF4
CNSTF4 1142947840
CNSTF4 1066192077
ADDRLP4 28
INDIRF4
MULF4
SUBF4
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2120
;2119:	
;2120:				y += ico_size;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 2122
;2121:
;2122:				if (j != PW_REDFLAG && j != PW_BLUEFLAG && secondsleft < 999)
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $1074
ADDRLP4 0
INDIRI4
CNSTI4 5
EQI4 $1074
ADDRLP4 12
INDIRI4
CNSTI4 999
GEI4 $1074
line 2123
;2123:				{
line 2124
;2124:					UI_DrawProportionalString((640-(ico_size*1.1))+(ico_size/2), y-8, va("%i", secondsleft), UI_CENTER | UI_BIGFONT | UI_DROPSHADOW, colorTable[CT_WHITE]);
ADDRGP4 $612
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
CNSTF4 1142947840
CNSTF4 1066192077
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
SUBF4
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
ADDF4
CVFI4 4
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 8
SUBI4
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
CNSTI4 2081
ARGI4
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 2125
;2125:				}
LABELV $1074
line 2127
;2126:
;2127:				y += (ico_size/3);
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 3
DIVI4
ADDI4
ASGNI4
line 2128
;2128:			}
LABELV $1064
line 2129
;2129:		}
LABELV $1058
line 2130
;2130:	}
LABELV $1055
line 2091
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LEI4 $1054
line 2131
;2131:}
LABELV $1050
endproc CG_DrawPowerupIcons 44 20
proc CG_DrawUpperRight 12 12
line 2140
;2132:
;2133:
;2134:/*
;2135:=====================
;2136:CG_DrawUpperRight
;2137:
;2138:=====================
;2139:*/
;2140:static void CG_DrawUpperRight( void ) {
line 2143
;2141:	float	y;
;2142:
;2143:	y = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2145
;2144:
;2145:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 1 ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $1078
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 1
NEI4 $1078
line 2146
;2146:		y = CG_DrawTeamOverlay( y, qtrue, qtrue );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 2147
;2147:	} 
LABELV $1078
line 2148
;2148:	if ( cg_drawSnapshot.integer ) {
ADDRGP4 cg_drawSnapshot+12
INDIRI4
CNSTI4 0
EQI4 $1082
line 2149
;2149:		y = CG_DrawSnapshot( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawSnapshot
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 2150
;2150:	}
LABELV $1082
line 2151
;2151:	if ( cg_drawFPS.integer ) {
ADDRGP4 cg_drawFPS+12
INDIRI4
CNSTI4 0
EQI4 $1085
line 2152
;2152:		y = CG_DrawFPS( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawFPS
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 2153
;2153:	}
LABELV $1085
line 2154
;2154:	if ( cg_drawTimer.integer ) {
ADDRGP4 cg_drawTimer+12
INDIRI4
CNSTI4 0
EQI4 $1088
line 2155
;2155:		y = CG_DrawTimer( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawTimer
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 2156
;2156:	}
LABELV $1088
line 2158
;2157:	
;2158:	y = CG_DrawEnemyInfo ( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawEnemyInfo
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 2160
;2159:
;2160:	y = CG_DrawMiniScoreboard ( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawMiniScoreboard
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 2162
;2161:
;2162:	CG_DrawPowerupIcons(y);
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawPowerupIcons
CALLV
pop
line 2163
;2163:}
LABELV $1077
endproc CG_DrawUpperRight 12 12
export CG_AddLagometerFrameInfo
proc CG_AddLagometerFrameInfo 8 0
line 2268
;2164:
;2165:/*
;2166:===================
;2167:CG_DrawReward
;2168:===================
;2169:*/
;2170:#ifdef JK2AWARDS
;2171:static void CG_DrawReward( void ) { 
;2172:	float	*color;
;2173:	int		i, count;
;2174:	float	x, y;
;2175:	char	buf[32];
;2176:
;2177:	if ( !cg_drawRewards.integer ) {
;2178:		return;
;2179:	}
;2180:
;2181:	color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
;2182:	if ( !color ) {
;2183:		if (cg.rewardStack > 0) {
;2184:			for(i = 0; i < cg.rewardStack; i++) {
;2185:				cg.rewardSound[i] = cg.rewardSound[i+1];
;2186:				cg.rewardShader[i] = cg.rewardShader[i+1];
;2187:				cg.rewardCount[i] = cg.rewardCount[i+1];
;2188:			}
;2189:			cg.rewardTime = cg.time;
;2190:			cg.rewardStack--;
;2191:			color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
;2192:			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
;2193:		} else {
;2194:			return;
;2195:		}
;2196:	}
;2197:
;2198:	trap_R_SetColor( color );
;2199:
;2200:	/*
;2201:	count = cg.rewardCount[0]/10;				// number of big rewards to draw
;2202:
;2203:	if (count) {
;2204:		y = 4;
;2205:		x = 320 - count * ICON_SIZE;
;2206:		for ( i = 0 ; i < count ; i++ ) {
;2207:			CG_DrawPic( x, y, (ICON_SIZE*2)-4, (ICON_SIZE*2)-4, cg.rewardShader[0] );
;2208:			x += (ICON_SIZE*2);
;2209:		}
;2210:	}
;2211:
;2212:	count = cg.rewardCount[0] - count*10;		// number of small rewards to draw
;2213:	*/
;2214:
;2215:	if ( cg.rewardCount[0] >= 10 ) {
;2216:		y = 56;
;2217:		x = 320 - ICON_SIZE/2;
;2218:		CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
;2219:		Com_sprintf(buf, sizeof(buf), "%d", cg.rewardCount[0]);
;2220:		x = ( SCREEN_WIDTH - SMALLCHAR_WIDTH * CG_DrawStrlen( buf ) ) / 2;
;2221:		CG_DrawStringExt( x, y+ICON_SIZE, buf, color, qfalse, qtrue,
;2222:								SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0 );
;2223:	}
;2224:	else {
;2225:
;2226:		count = cg.rewardCount[0];
;2227:
;2228:		y = 56;
;2229:		x = 320 - count * ICON_SIZE/2;
;2230:		for ( i = 0 ; i < count ; i++ ) {
;2231:			CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
;2232:			x += ICON_SIZE;
;2233:		}
;2234:	}
;2235:	trap_R_SetColor( NULL );
;2236:}
;2237:#endif
;2238:
;2239:
;2240:/*
;2241:===============================================================================
;2242:
;2243:LAGOMETER
;2244:
;2245:===============================================================================
;2246:*/
;2247:
;2248:#define	LAG_SAMPLES		128
;2249:
;2250:
;2251:typedef struct {
;2252:	int		frameSamples[LAG_SAMPLES];
;2253:	int		frameCount;
;2254:	int		snapshotFlags[LAG_SAMPLES];
;2255:	int		snapshotSamples[LAG_SAMPLES];
;2256:	int		snapshotCount;
;2257:} lagometer_t;
;2258:
;2259:lagometer_t		lagometer;
;2260:
;2261:/*
;2262:==============
;2263:CG_AddLagometerFrameInfo
;2264:
;2265:Adds the current interpolate / extrapolate bar for this frame
;2266:==============
;2267:*/
;2268:void CG_AddLagometerFrameInfo( void ) {
line 2271
;2269:	int			offset;
;2270:
;2271:	offset = cg.time - cg.latestSnapshotTime;
ADDRLP4 0
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+32
INDIRI4
SUBI4
ASGNI4
line 2272
;2272:	lagometer.frameSamples[ lagometer.frameCount & ( LAG_SAMPLES - 1) ] = offset;
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2273
;2273:	lagometer.frameCount++;
ADDRLP4 4
ADDRGP4 lagometer+512
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2274
;2274:}
LABELV $1092
endproc CG_AddLagometerFrameInfo 8 0
export CG_AddLagometerSnapshotInfo
proc CG_AddLagometerSnapshotInfo 4 0
line 2286
;2275:
;2276:/*
;2277:==============
;2278:CG_AddLagometerSnapshotInfo
;2279:
;2280:Each time a snapshot is received, log its ping time and
;2281:the number of snapshots that were dropped before it.
;2282:
;2283:Pass NULL for a dropped packet.
;2284:==============
;2285:*/
;2286:void CG_AddLagometerSnapshotInfo( snapshot_t *snap ) {
line 2288
;2287:	// dropped packet
;2288:	if ( !snap ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1098
line 2289
;2289:		lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = -1;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
CNSTI4 -1
ASGNI4
line 2290
;2290:		lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2291
;2291:		return;
ADDRGP4 $1097
JUMPV
LABELV $1098
line 2295
;2292:	}
;2293:
;2294:	// add this snapshot's info
;2295:	lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->ping;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2296
;2296:	lagometer.snapshotFlags[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->snapFlags;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 2297
;2297:	lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2298
;2298:}
LABELV $1097
endproc CG_AddLagometerSnapshotInfo 4 0
proc CG_DrawDisconnect 72 20
line 2307
;2299:
;2300:/*
;2301:==============
;2302:CG_DrawDisconnect
;2303:
;2304:Should we draw something differnet for long lag vs no packets?
;2305:==============
;2306:*/
;2307:static void CG_DrawDisconnect( void ) {
line 2314
;2308:	float		x, y;
;2309:	int			cmdNum;
;2310:	usercmd_t	cmd;
;2311:	const char		*s;
;2312:	int			w;  // bk010215 - FIXME char message[1024];
;2313:
;2314:	if (cg.mMapChange)
ADDRGP4 cg+48
INDIRI4
CNSTI4 0
EQI4 $1109
line 2315
;2315:	{			
line 2316
;2316:		s = CG_GetStripEdString("INGAMETEXT", "SERVER_CHANGING_MAPS");	// s = "Server Changing Maps";			
ADDRGP4 $897
ARGP4
ADDRGP4 $1112
ARGP4
ADDRLP4 48
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
line 2317
;2317:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2318
;2318:		CG_DrawBigString( 320 - w/2, 100, s, 1.0F);
CNSTI4 320
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2320
;2319:
;2320:		s = CG_GetStripEdString("INGAMETEXT", "PLEASE_WAIT");	// s = "Please wait...";
ADDRGP4 $897
ARGP4
ADDRGP4 $1113
ARGP4
ADDRLP4 56
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 2321
;2321:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2322
;2322:		CG_DrawBigString( 320 - w/2, 200, s, 1.0F);
CNSTI4 320
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 200
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2323
;2323:		return;
ADDRGP4 $1108
JUMPV
LABELV $1109
line 2327
;2324:	}
;2325:
;2326:	// draw the phone jack if we are completely past our buffers
;2327:	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
ADDRLP4 48
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 48
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2328
;2328:	trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 2329
;2329:	if ( cmd.serverTime <= cg.snap->ps.commandTime
ADDRLP4 52
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $1118
ADDRLP4 52
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $1114
LABELV $1118
line 2330
;2330:		|| cmd.serverTime > cg.time ) {	// special check for map_restart // bk 0102165 - FIXME
line 2331
;2331:		return;
ADDRGP4 $1108
JUMPV
LABELV $1114
line 2335
;2332:	}
;2333:
;2334:	// also add text in center of screen
;2335:	s = CG_GetStripEdString("INGAMETEXT", "CONNECTION_INTERRUPTED"); // s = "Connection Interrupted"; // bk 010215 - FIXME
ADDRGP4 $897
ARGP4
ADDRGP4 $1119
ARGP4
ADDRLP4 56
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 2336
;2336:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2337
;2337:	CG_DrawBigString( 320 - w/2, 100, s, 1.0F);
CNSTI4 320
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2340
;2338:
;2339:	// blink the icon
;2340:	if ( ( cg.time >> 9 ) & 1 ) {
ADDRGP4 cg+64
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1120
line 2341
;2341:		return;
ADDRGP4 $1108
JUMPV
LABELV $1120
line 2344
;2342:	}
;2343:
;2344:	x = 640 - 48;
ADDRLP4 36
CNSTF4 1142161408
ASGNF4
line 2345
;2345:	y = 480 - 48;
ADDRLP4 40
CNSTF4 1138229248
ASGNF4
line 2347
;2346:
;2347:	CG_DrawPic( x, y, 48, 48, trap_R_RegisterShader("gfx/2d/net.tga" ) );
ADDRGP4 $1123
ARGP4
ADDRLP4 64
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 68
CNSTF4 1111490560
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2348
;2348:}
LABELV $1108
endproc CG_DrawDisconnect 72 20
proc CG_DrawLagometer 68 36
line 2359
;2349:
;2350:
;2351:#define	MAX_LAGOMETER_PING	900
;2352:#define	MAX_LAGOMETER_RANGE	300
;2353:
;2354:/*
;2355:==============
;2356:CG_DrawLagometer
;2357:==============
;2358:*/
;2359:static void CG_DrawLagometer( void ) {
line 2366
;2360:	int		a, x, y, i;
;2361:	float	v;
;2362:	float	ax, ay, aw, ah, mid, range;
;2363:	int		color;
;2364:	float	vscale;
;2365:
;2366:	if ( !cg_lagometer.integer || cgs.localServer ) {
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRGP4 cg_lagometer+12
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $1129
ADDRGP4 cgs+32956
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $1125
LABELV $1129
line 2367
;2367:		CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 2368
;2368:		return;
ADDRGP4 $1124
JUMPV
LABELV $1125
line 2374
;2369:	}
;2370:
;2371:	//
;2372:	// draw the graph
;2373:	//
;2374:	x = 640 - 48;
ADDRLP4 44
CNSTI4 592
ASGNI4
line 2375
;2375:	y = 480 - 144;
ADDRLP4 48
CNSTI4 336
ASGNI4
line 2377
;2376:
;2377:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2378
;2378:	CG_DrawPic( x, y, 48, 48, cgs.media.lagometerShader );
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 48
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
CNSTF4 1111490560
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cgs+70280+240
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2380
;2379:
;2380:	ax = x;
ADDRLP4 28
ADDRLP4 44
INDIRI4
CVIF4 4
ASGNF4
line 2381
;2381:	ay = y;
ADDRLP4 36
ADDRLP4 48
INDIRI4
CVIF4 4
ASGNF4
line 2382
;2382:	aw = 48;
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
line 2383
;2383:	ah = 48;
ADDRLP4 32
CNSTF4 1111490560
ASGNF4
line 2385
;2384:
;2385:	color = -1;
ADDRLP4 20
CNSTI4 -1
ASGNI4
line 2386
;2386:	range = ah / 3;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1077936128
DIVF4
ASGNF4
line 2387
;2387:	mid = ay + range;
ADDRLP4 40
ADDRLP4 36
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
line 2389
;2388:
;2389:	vscale = range / MAX_LAGOMETER_RANGE;
ADDRLP4 24
ADDRLP4 16
INDIRF4
CNSTF4 1133903872
DIVF4
ASGNF4
line 2392
;2390:
;2391:	// draw the frame interpoalte / extrapolate graph
;2392:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1135
JUMPV
LABELV $1132
line 2393
;2393:		i = ( lagometer.frameCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 2394
;2394:		v = lagometer.frameSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2395
;2395:		v *= vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 2396
;2396:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1137
line 2397
;2397:			if ( color != 1 ) {
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $1139
line 2398
;2398:				color = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 2399
;2399:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2400
;2400:			}
LABELV $1139
line 2401
;2401:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1142
line 2402
;2402:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2403
;2403:			}
LABELV $1142
line 2404
;2404:			trap_R_DrawStretchPic ( ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+70280+4
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2405
;2405:		} else if ( v < 0 ) {
ADDRGP4 $1138
JUMPV
LABELV $1137
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $1146
line 2406
;2406:			if ( color != 2 ) {
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $1148
line 2407
;2407:				color = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 2408
;2408:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_BLUE)] );
ADDRGP4 g_color_table+64
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2409
;2409:			}
LABELV $1148
line 2410
;2410:			v = -v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
line 2411
;2411:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1151
line 2412
;2412:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2413
;2413:			}
LABELV $1151
line 2414
;2414:			trap_R_DrawStretchPic( ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+70280+4
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2415
;2415:		}
LABELV $1146
LABELV $1138
line 2416
;2416:	}
LABELV $1133
line 2392
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1135
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $1132
line 2419
;2417:
;2418:	// draw the snapshot latency / drop graph
;2419:	range = ah / 2;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2420
;2420:	vscale = range / MAX_LAGOMETER_PING;
ADDRLP4 24
ADDRLP4 16
INDIRF4
CNSTF4 1147207680
DIVF4
ASGNF4
line 2422
;2421:
;2422:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1158
JUMPV
LABELV $1155
line 2423
;2423:		i = ( lagometer.snapshotCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 2424
;2424:		v = lagometer.snapshotSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2425
;2425:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1161
line 2426
;2426:			if ( lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED ) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1163
line 2427
;2427:				if ( color != 5 ) {
ADDRLP4 20
INDIRI4
CNSTI4 5
EQI4 $1164
line 2428
;2428:					color = 5;	// YELLOW for rate delay
ADDRLP4 20
CNSTI4 5
ASGNI4
line 2429
;2429:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2430
;2430:				}
line 2431
;2431:			} else {
ADDRGP4 $1164
JUMPV
LABELV $1163
line 2432
;2432:				if ( color != 3 ) {
ADDRLP4 20
INDIRI4
CNSTI4 3
EQI4 $1169
line 2433
;2433:					color = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 2434
;2434:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_GREEN)] );
ADDRGP4 g_color_table+32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2435
;2435:				}
LABELV $1169
line 2436
;2436:			}
LABELV $1164
line 2437
;2437:			v = v * vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 2438
;2438:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1172
line 2439
;2439:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2440
;2440:			}
LABELV $1172
line 2441
;2441:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+70280+4
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2442
;2442:		} else if ( v < 0 ) {
ADDRGP4 $1162
JUMPV
LABELV $1161
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $1176
line 2443
;2443:			if ( color != 4 ) {
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $1178
line 2444
;2444:				color = 4;		// RED for dropped snapshots
ADDRLP4 20
CNSTI4 4
ASGNI4
line 2445
;2445:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_RED)] );
ADDRGP4 g_color_table+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2446
;2446:			}
LABELV $1178
line 2447
;2447:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+70280+4
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2448
;2448:		}
LABELV $1176
LABELV $1162
line 2449
;2449:	}
LABELV $1156
line 2422
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1158
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $1155
line 2451
;2450:
;2451:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2453
;2452:
;2453:	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $1187
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $1183
LABELV $1187
line 2454
;2454:		CG_DrawBigString( ax, ay, "snc", 1.0 );
ADDRLP4 28
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 $1188
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2455
;2455:	}
LABELV $1183
line 2457
;2456:
;2457:	CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 2458
;2458:}
LABELV $1124
endproc CG_DrawLagometer 68 36
export CG_CenterPrint
proc CG_CenterPrint 8 12
line 2479
;2459:
;2460:
;2461:
;2462:/*
;2463:===============================================================================
;2464:
;2465:CENTER PRINTING
;2466:
;2467:===============================================================================
;2468:*/
;2469:
;2470:
;2471:/*
;2472:==============
;2473:CG_CenterPrint
;2474:
;2475:Called for important messages that should stay in the center of the screen
;2476:for a few moments
;2477:==============
;2478:*/
;2479:void CG_CenterPrint( const char *str, int y, int charWidth ) {
line 2482
;2480:	char	*s;
;2481:
;2482:	Q_strncpyz( cg.centerPrint, str, sizeof(cg.centerPrint) );
ADDRGP4 cg+12048
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2484
;2483:
;2484:	cg.centerPrintTime = cg.time;
ADDRGP4 cg+12036
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 2485
;2485:	cg.centerPrintY = y;
ADDRGP4 cg+12044
ADDRFP4 4
INDIRI4
ASGNI4
line 2486
;2486:	cg.centerPrintCharWidth = charWidth;
ADDRGP4 cg+12040
ADDRFP4 8
INDIRI4
ASGNI4
line 2489
;2487:
;2488:	// count the number of lines for centering
;2489:	cg.centerPrintLines = 1;
ADDRGP4 cg+13072
CNSTI4 1
ASGNI4
line 2490
;2490:	s = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+12048
ASGNP4
ADDRGP4 $1199
JUMPV
LABELV $1198
line 2491
;2491:	while( *s ) {
line 2492
;2492:		if (*s == '\n')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $1201
line 2493
;2493:			cg.centerPrintLines++;
ADDRLP4 4
ADDRGP4 cg+13072
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1201
line 2494
;2494:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2495
;2495:	}
LABELV $1199
line 2491
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1198
line 2496
;2496:}
LABELV $1189
endproc CG_CenterPrint 8 12
proc CG_DrawCenterString 1072 36
line 2504
;2497:
;2498:
;2499:/*
;2500:===================
;2501:CG_DrawCenterString
;2502:===================
;2503:*/
;2504:static void CG_DrawCenterString( void ) {
line 2510
;2505:	char	*start;
;2506:	int		l;
;2507:	int		x, y, w;
;2508:	int h;
;2509:	float	*color;
;2510:	const float scale = 1.0; //0.5
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 2512
;2511:
;2512:	if ( !cg.centerPrintTime ) {
ADDRGP4 cg+12036
INDIRI4
CNSTI4 0
NEI4 $1205
line 2513
;2513:		return;
ADDRGP4 $1204
JUMPV
LABELV $1205
line 2516
;2514:	}
;2515:
;2516:	color = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value );
ADDRGP4 cg+12036
INDIRI4
ARGI4
CNSTF4 1148846080
ADDRGP4 cg_centertime+8
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRLP4 32
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 32
INDIRP4
ASGNP4
line 2517
;2517:	if ( !color ) {
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1210
line 2518
;2518:		return;
ADDRGP4 $1204
JUMPV
LABELV $1210
line 2521
;2519:	}
;2520:
;2521:	trap_R_SetColor( color );
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2523
;2522:
;2523:	start = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+12048
ASGNP4
line 2525
;2524:
;2525:	y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;
ADDRLP4 16
ADDRGP4 cg+12044
INDIRI4
ADDRGP4 cg+13072
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
ADDRGP4 $1216
JUMPV
LABELV $1215
line 2527
;2526:
;2527:	while ( 1 ) {
line 2530
;2528:		char linebuffer[1024];
;2529:
;2530:		for ( l = 0; l < 50; l++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1218
line 2531
;2531:			if ( !start[l] || start[l] == '\n' ) {
ADDRLP4 1060
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $1224
ADDRLP4 1060
INDIRI4
CNSTI4 10
NEI4 $1222
LABELV $1224
line 2532
;2532:				break;
ADDRGP4 $1220
JUMPV
LABELV $1222
line 2534
;2533:			}
;2534:			linebuffer[l] = start[l];
ADDRLP4 4
INDIRI4
ADDRLP4 36
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 2535
;2535:		}
LABELV $1219
line 2530
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 50
LTI4 $1218
LABELV $1220
line 2536
;2536:		linebuffer[l] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 36
ADDP4
CNSTI1 0
ASGNI1
line 2538
;2537:
;2538:		w = CG_Text_Width(linebuffer, scale, FONT_MEDIUM);
ADDRLP4 36
ARGP4
ADDRLP4 8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 1060
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 1060
INDIRI4
ASGNI4
line 2539
;2539:		h = CG_Text_Height(linebuffer, scale, FONT_MEDIUM);
ADDRLP4 36
ARGP4
ADDRLP4 8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 1064
ADDRGP4 CG_Text_Height
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 1064
INDIRI4
ASGNI4
line 2540
;2540:		x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 20
CNSTI4 640
ADDRLP4 24
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 2541
;2541:		CG_Text_Paint(x, y + h, scale, color, linebuffer, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE, FONT_MEDIUM);
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 2542
;2542:		y += h + 6;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 6
ADDI4
ADDI4
ASGNI4
ADDRGP4 $1226
JUMPV
LABELV $1225
line 2544
;2543:
;2544:		while ( *start && ( *start != '\n' ) ) {
line 2545
;2545:			start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2546
;2546:		}
LABELV $1226
line 2544
ADDRLP4 1068
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
EQI4 $1228
ADDRLP4 1068
INDIRI4
CNSTI4 10
NEI4 $1225
LABELV $1228
line 2547
;2547:		if ( !*start ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1229
line 2548
;2548:			break;
ADDRGP4 $1217
JUMPV
LABELV $1229
line 2550
;2549:		}
;2550:		start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2551
;2551:	}
LABELV $1216
line 2527
ADDRGP4 $1215
JUMPV
LABELV $1217
line 2553
;2552:
;2553:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2554
;2554:}
LABELV $1204
endproc CG_DrawCenterString 1072 36
lit
align 4
LABELV $1254
byte 4 0
byte 4 0
byte 4 0
byte 4 0
code
proc CG_DrawCrosshair 68 36
line 2572
;2555:
;2556:
;2557:
;2558:/*
;2559:================================================================================
;2560:
;2561:CROSSHAIR
;2562:
;2563:================================================================================
;2564:*/
;2565:
;2566:
;2567:/*
;2568:=================
;2569:CG_DrawCrosshair
;2570:=================
;2571:*/
;2572:static void CG_DrawCrosshair( vec3_t worldPoint, int chEntValid ) {
line 2578
;2573:	float		w, h;
;2574:	qhandle_t	hShader;
;2575:	float		f;
;2576:	float		x, y;
;2577:
;2578:	if ( !cg_drawCrosshair.integer ) 
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $1232
line 2579
;2579:	{
line 2580
;2580:		return;
ADDRGP4 $1231
JUMPV
LABELV $1232
line 2583
;2581:	}
;2582:
;2583:	if (cg.snap->ps.fallingToDeath)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1235
line 2584
;2584:	{
line 2585
;2585:		return;
ADDRGP4 $1231
JUMPV
LABELV $1235
line 2588
;2586:	}
;2587:
;2588:	if ( cg.predictedPlayerState.zoomMode != 0 )
ADDRGP4 cg+96+1320
INDIRI4
CNSTI4 0
EQI4 $1238
line 2589
;2589:	{//not while scoped
line 2590
;2590:		return;
ADDRGP4 $1231
JUMPV
LABELV $1238
line 2593
;2591:	}
;2592:
;2593:	if ( cg_crosshairHealth.integer )
ADDRGP4 cg_crosshairHealth+12
INDIRI4
CNSTI4 0
EQI4 $1242
line 2594
;2594:	{
line 2597
;2595:		vec4_t		hcolor;
;2596:
;2597:		CG_ColorForHealth( hcolor );
ADDRLP4 24
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 2598
;2598:		trap_R_SetColor( hcolor );
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2599
;2599:	}
ADDRGP4 $1243
JUMPV
LABELV $1242
line 2601
;2600:	else
;2601:	{
line 2603
;2602:		//set color based on what kind of ent is under crosshair
;2603:		if ( cg.crosshairClientNum >= ENTITYNUM_WORLD )
ADDRGP4 cg+13084
INDIRI4
CNSTI4 1022
LTI4 $1245
line 2604
;2604:		{
line 2605
;2605:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2606
;2606:		}
ADDRGP4 $1246
JUMPV
LABELV $1245
line 2607
;2607:		else if (chEntValid && (cg_entities[cg.crosshairClientNum].currentState.number < MAX_CLIENTS || cg_entities[cg.crosshairClientNum].currentState.shouldtarget))
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1248
ADDRLP4 28
CNSTI4 1920
ASGNI4
ADDRLP4 28
INDIRI4
ADDRGP4 cg+13084
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
INDIRI4
CNSTI4 32
LTI4 $1253
ADDRLP4 28
INDIRI4
ADDRGP4 cg+13084
INDIRI4
MULI4
ADDRGP4 cg_entities+268
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1248
LABELV $1253
line 2608
;2608:		{
line 2609
;2609:			vec4_t	ecolor = {0,0,0,0};
ADDRLP4 32
ADDRGP4 $1254
INDIRB
ASGNB 16
line 2610
;2610:			centity_t *crossEnt = &cg_entities[cg.crosshairClientNum];
ADDRLP4 48
CNSTI4 1920
ADDRGP4 cg+13084
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 2612
;2611:
;2612:			if ( crossEnt->currentState.number < MAX_CLIENTS )
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 32
GEI4 $1256
line 2613
;2613:			{
line 2614
;2614:				if (cgs.gametype >= GT_TEAM &&
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $1258
ADDRLP4 52
CNSTI4 788
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 48
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
NEI4 $1258
line 2616
;2615:					cgs.clientinfo[crossEnt->currentState.number].team == cgs.clientinfo[cg.snap->ps.clientNum].team )
;2616:				{
line 2618
;2617:					//Allies are green
;2618:					ecolor[0] = 0.0;//R
ADDRLP4 32
CNSTF4 0
ASGNF4
line 2619
;2619:					ecolor[1] = 1.0;//G
ADDRLP4 32+4
CNSTF4 1065353216
ASGNF4
line 2620
;2620:					ecolor[2] = 0.0;//B
ADDRLP4 32+8
CNSTF4 0
ASGNF4
line 2621
;2621:				}
ADDRGP4 $1259
JUMPV
LABELV $1258
line 2623
;2622:				else
;2623:				{
line 2625
;2624:					//Enemies are red
;2625:					ecolor[0] = 1.0;//R
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
line 2626
;2626:					ecolor[1] = 0.0;//G
ADDRLP4 32+4
CNSTF4 0
ASGNF4
line 2627
;2627:					ecolor[2] = 0.0;//B
ADDRLP4 32+8
CNSTF4 0
ASGNF4
line 2628
;2628:				}
LABELV $1259
line 2630
;2629:
;2630:				if (cg.snap->ps.duelInProgress)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1270
line 2631
;2631:				{
line 2632
;2632:					if (crossEnt->currentState.number != cg.snap->ps.duelIndex)
ADDRLP4 48
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1328
ADDP4
INDIRI4
EQI4 $1257
line 2633
;2633:					{ //grey out crosshair for everyone but your foe if you're in a duel
line 2634
;2634:						ecolor[0] = 0.4;
ADDRLP4 32
CNSTF4 1053609165
ASGNF4
line 2635
;2635:						ecolor[1] = 0.4;
ADDRLP4 32+4
CNSTF4 1053609165
ASGNF4
line 2636
;2636:						ecolor[2] = 0.4;
ADDRLP4 32+8
CNSTF4 1053609165
ASGNF4
line 2637
;2637:					}
line 2638
;2638:				}
ADDRGP4 $1257
JUMPV
LABELV $1270
line 2639
;2639:				else if (crossEnt->currentState.bolt1)
ADDRLP4 48
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1257
line 2640
;2640:				{ //this fellow is in a duel. We just checked if we were in a duel above, so
line 2642
;2641:				  //this means we aren't and he is. Which of course means our crosshair greys out over him.
;2642:					ecolor[0] = 0.4;
ADDRLP4 32
CNSTF4 1053609165
ASGNF4
line 2643
;2643:					ecolor[1] = 0.4;
ADDRLP4 32+4
CNSTF4 1053609165
ASGNF4
line 2644
;2644:					ecolor[2] = 0.4;
ADDRLP4 32+8
CNSTF4 1053609165
ASGNF4
line 2645
;2645:				}
line 2646
;2646:			}
ADDRGP4 $1257
JUMPV
LABELV $1256
line 2647
;2647:			else if (crossEnt->currentState.shouldtarget)
ADDRLP4 48
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1282
line 2648
;2648:			{
line 2650
;2649:				//VectorCopy( crossEnt->startRGBA, ecolor );
;2650:				if ( !ecolor[0] && !ecolor[1] && !ecolor[2] )
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 52
INDIRF4
NEF4 $1284
ADDRLP4 32+4
INDIRF4
ADDRLP4 52
INDIRF4
NEF4 $1284
ADDRLP4 32+8
INDIRF4
ADDRLP4 52
INDIRF4
NEF4 $1284
line 2651
;2651:				{
line 2653
;2652:					// We really don't want black, so set it to yellow
;2653:					ecolor[0] = 1.0F;//R
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
line 2654
;2654:					ecolor[1] = 0.8F;//G
ADDRLP4 32+4
CNSTF4 1061997773
ASGNF4
line 2655
;2655:					ecolor[2] = 0.3F;//B
ADDRLP4 32+8
CNSTF4 1050253722
ASGNF4
line 2656
;2656:				}
LABELV $1284
line 2658
;2657:
;2658:				if (crossEnt->currentState.owner == cg.snap->ps.clientNum ||
ADDRLP4 56
ADDRLP4 48
INDIRP4
ASGNP4
ADDRLP4 60
CNSTI4 188
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
EQI4 $1297
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $1290
ADDRLP4 56
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
CNSTI4 788
ADDRGP4 cg+36
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
NEI4 $1290
LABELV $1297
line 2660
;2659:					(cgs.gametype >= GT_TEAM && crossEnt->currentState.teamowner == cgs.clientinfo[cg.snap->ps.clientNum].team))
;2660:				{
line 2661
;2661:					ecolor[0] = 0.0;//R
ADDRLP4 32
CNSTF4 0
ASGNF4
line 2662
;2662:					ecolor[1] = 1.0;//G
ADDRLP4 32+4
CNSTF4 1065353216
ASGNF4
line 2663
;2663:					ecolor[2] = 0.0;//B
ADDRLP4 32+8
CNSTF4 0
ASGNF4
line 2664
;2664:				}
ADDRGP4 $1291
JUMPV
LABELV $1290
line 2665
;2665:				else if (crossEnt->currentState.teamowner == 16 ||
ADDRLP4 64
ADDRLP4 48
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 16
EQI4 $1306
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $1300
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $1300
ADDRLP4 64
INDIRI4
CNSTI4 788
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
EQI4 $1300
LABELV $1306
line 2667
;2666:					(cgs.gametype >= GT_TEAM && crossEnt->currentState.teamowner && crossEnt->currentState.teamowner != cgs.clientinfo[cg.snap->ps.clientNum].team))
;2667:				{
line 2668
;2668:					ecolor[0] = 1.0;//R
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
line 2669
;2669:					ecolor[1] = 0.0;//G
ADDRLP4 32+4
CNSTF4 0
ASGNF4
line 2670
;2670:					ecolor[2] = 0.0;//B
ADDRLP4 32+8
CNSTF4 0
ASGNF4
line 2671
;2671:				}
LABELV $1300
LABELV $1291
line 2672
;2672:			}
LABELV $1282
LABELV $1257
line 2674
;2673:
;2674:			ecolor[3] = 1.0;
ADDRLP4 32+12
CNSTF4 1065353216
ASGNF4
line 2676
;2675:
;2676:			trap_R_SetColor( ecolor );
ADDRLP4 32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2677
;2677:		}
LABELV $1248
LABELV $1246
line 2678
;2678:	}
LABELV $1243
line 2680
;2679:
;2680:	w = h = cg_crosshairSize.value;
ADDRLP4 24
ADDRGP4 cg_crosshairSize+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 2683
;2681:
;2682:	// pulse the size of the crosshair when picking up items
;2683:	f = cg.time - cg.itemPickupBlendTime;
ADDRLP4 0
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+13356
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2684
;2684:	if ( f > 0 && f < ITEM_BLOB_TIME ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1313
ADDRLP4 0
INDIRF4
CNSTF4 1128792064
GEF4 $1313
line 2685
;2685:		f /= ITEM_BLOB_TIME;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 2686
;2686:		w *= ( 1 + f );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2687
;2687:		h *= ( 1 + f );
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2688
;2688:	}
LABELV $1313
line 2690
;2689:
;2690:	if ( worldPoint && VectorLength( worldPoint ) )
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1315
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 0
EQF4 $1315
line 2691
;2691:	{
line 2692
;2692:		if ( !CG_WorldCoordToScreenCoordFloat( worldPoint, &x, &y ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 40
ADDRGP4 CG_WorldCoordToScreenCoordFloat
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $1317
line 2693
;2693:		{//off screen, don't draw it
line 2694
;2694:			return;
ADDRGP4 $1231
JUMPV
LABELV $1317
line 2696
;2695:		}
;2696:		x -= 320;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1134559232
SUBF4
ASGNF4
line 2697
;2697:		y -= 240;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1131413504
SUBF4
ASGNF4
line 2698
;2698:	}
ADDRGP4 $1316
JUMPV
LABELV $1315
line 2700
;2699:	else
;2700:	{
line 2701
;2701:		x = cg_crosshairX.integer;
ADDRLP4 12
ADDRGP4 cg_crosshairX+12
INDIRI4
CVIF4 4
ASGNF4
line 2702
;2702:		y = cg_crosshairY.integer;
ADDRLP4 16
ADDRGP4 cg_crosshairY+12
INDIRI4
CVIF4 4
ASGNF4
line 2703
;2703:	}
LABELV $1316
line 2705
;2704:
;2705:	hShader = cgs.media.crosshairShader[ cg_drawCrosshair.integer % NUM_CROSSHAIRS ];
ADDRLP4 20
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+70280+200
ADDP4
INDIRI4
ASGNI4
line 2707
;2706:
;2707:	trap_R_DrawStretchPic( x + cg.refdef.x + 0.5 * (640 - w), 
ADDRLP4 40
CNSTF4 1056964608
ASGNF4
ADDRLP4 12
INDIRF4
ADDRGP4 cg+3604
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 40
INDIRF4
CNSTF4 1142947840
ADDRLP4 4
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRGP4 cg+3604+4
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 40
INDIRF4
CNSTF4 1139802112
ADDRLP4 8
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2710
;2708:		y + cg.refdef.y + 0.5 * (480 - h), 
;2709:		w, h, 0, 0, 1, 1, hShader );
;2710:}
LABELV $1231
endproc CG_DrawCrosshair 68 36
export CG_WorldCoordToScreenCoordFloat
proc CG_WorldCoordToScreenCoordFloat 80 16
line 2713
;2711:
;2712:qboolean CG_WorldCoordToScreenCoordFloat(vec3_t worldCoord, float *x, float *y)
;2713:{
line 2727
;2714:	int	xcenter, ycenter;
;2715:	vec3_t	local, transformed;
;2716:	vec3_t	vfwd;
;2717:	vec3_t	vright;
;2718:	vec3_t	vup;
;2719:	float xzi;
;2720:	float yzi;
;2721:
;2722://	xcenter = cg.refdef.width / 2;//gives screen coords adjusted for resolution
;2723://	ycenter = cg.refdef.height / 2;//gives screen coords adjusted for resolution
;2724:	
;2725:	//NOTE: did it this way because most draw functions expect virtual 640x480 coords
;2726:	//	and adjust them for current resolution
;2727:	xcenter = 640 / 2;//gives screen coords in virtual 640x480, to be adjusted when drawn
ADDRLP4 60
CNSTI4 320
ASGNI4
line 2728
;2728:	ycenter = 480 / 2;//gives screen coords in virtual 640x480, to be adjusted when drawn
ADDRLP4 64
CNSTI4 240
ASGNI4
line 2730
;2729:
;2730:	AngleVectors (cg.refdefViewAngles, vfwd, vright, vup);
ADDRGP4 cg+3972
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2732
;2731:
;2732:	VectorSubtract (worldCoord, cg.refdef.vieworg, local);
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 76
INDIRP4
INDIRF4
ADDRGP4 cg+3604+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 cg+3604+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 cg+3604+24+8
INDIRF4
SUBF4
ASGNF4
line 2734
;2733:
;2734:	transformed[0] = DotProduct(local,vright);
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2735
;2735:	transformed[1] = DotProduct(local,vup);
ADDRLP4 12+4
ADDRLP4 0
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2736
;2736:	transformed[2] = DotProduct(local,vfwd);		
ADDRLP4 12+8
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2739
;2737:
;2738:	// Make sure Z is not negative.
;2739:	if(transformed[2] < 0.01)
ADDRLP4 12+8
INDIRF4
CNSTF4 1008981770
GEF4 $1353
line 2740
;2740:	{
line 2741
;2741:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1327
JUMPV
LABELV $1353
line 2744
;2742:	}
;2743:
;2744:	xzi = xcenter / transformed[2] * (90.0/cg.refdef.fov_x);
ADDRLP4 68
ADDRLP4 60
INDIRI4
CVIF4 4
ADDRLP4 12+8
INDIRF4
DIVF4
CNSTF4 1119092736
ADDRGP4 cg+3604+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 2745
;2745:	yzi = ycenter / transformed[2] * (90.0/cg.refdef.fov_y);
ADDRLP4 72
ADDRLP4 64
INDIRI4
CVIF4 4
ADDRLP4 12+8
INDIRF4
DIVF4
CNSTF4 1119092736
ADDRGP4 cg+3604+20
INDIRF4
DIVF4
MULF4
ASGNF4
line 2747
;2746:
;2747:	*x = xcenter + xzi * transformed[0];
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
CVIF4 4
ADDRLP4 68
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 2748
;2748:	*y = ycenter - yzi * transformed[1];
ADDRFP4 8
INDIRP4
ADDRLP4 64
INDIRI4
CVIF4 4
ADDRLP4 72
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
SUBF4
ASGNF4
line 2750
;2749:
;2750:	return qtrue;
CNSTI4 1
RETI4
LABELV $1327
endproc CG_WorldCoordToScreenCoordFloat 80 16
export CG_WorldCoordToScreenCoord
proc CG_WorldCoordToScreenCoord 16 12
line 2754
;2751:}
;2752:
;2753:qboolean CG_WorldCoordToScreenCoord( vec3_t worldCoord, int *x, int *y )
;2754:{
line 2756
;2755:	float	xF, yF;
;2756:	qboolean retVal = CG_WorldCoordToScreenCoordFloat( worldCoord, &xF, &yF );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 CG_WorldCoordToScreenCoordFloat
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 2757
;2757:	*x = (int)xF;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 2758
;2758:	*y = (int)yF;
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 2759
;2759:	return retVal;
ADDRLP4 8
INDIRI4
RETI4
LABELV $1363
endproc CG_WorldCoordToScreenCoord 16 12
data
export g_saberFlashTime
align 4
LABELV g_saberFlashTime
byte 4 0
export g_saberFlashPos
align 4
LABELV g_saberFlashPos
byte 4 0
byte 4 0
byte 4 0
export CG_SaberClashFlare
code
proc CG_SaberClashFlare 1164 28
line 2770
;2760:}
;2761:
;2762:/*
;2763:====================
;2764:CG_SaberClashFlare
;2765:====================
;2766:*/
;2767:int g_saberFlashTime = 0;
;2768:vec3_t g_saberFlashPos = {0, 0, 0};
;2769:void CG_SaberClashFlare( void ) 
;2770:{
line 2771
;2771:	int				t, maxTime = 150;
ADDRLP4 36
CNSTI4 150
ASGNI4
line 2778
;2772:	vec3_t dif;
;2773:	vec3_t color;
;2774:	int x,y;
;2775:	float v, len;
;2776:	trace_t tr;
;2777:
;2778:	t = cg.time - g_saberFlashTime;
ADDRLP4 16
ADDRGP4 cg+64
INDIRI4
ADDRGP4 g_saberFlashTime
INDIRI4
SUBI4
ASGNI4
line 2780
;2779:
;2780:	if ( t <= 0 || t >= maxTime ) 
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $1368
ADDRLP4 16
INDIRI4
ADDRLP4 36
INDIRI4
LTI4 $1366
LABELV $1368
line 2781
;2781:	{
line 2782
;2782:		return;
ADDRGP4 $1364
JUMPV
LABELV $1366
line 2786
;2783:	}
;2784:
;2785:	// Don't do clashes for things that are behind us
;2786:	VectorSubtract( g_saberFlashPos, cg.refdef.vieworg, dif );
ADDRLP4 0
ADDRGP4 g_saberFlashPos
INDIRF4
ADDRGP4 cg+3604+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 g_saberFlashPos+4
INDIRF4
ADDRGP4 cg+3604+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 g_saberFlashPos+8
INDIRF4
ADDRGP4 cg+3604+24+8
INDIRF4
SUBF4
ASGNF4
line 2788
;2787:
;2788:	if ( DotProduct( dif, cg.refdef.viewaxis[0] ) < 0.2 )
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
CNSTF4 1045220557
GEF4 $1381
line 2789
;2789:	{
line 2790
;2790:		return;
ADDRGP4 $1364
JUMPV
LABELV $1381
line 2793
;2791:	}
;2792:
;2793:	CG_Trace( &tr, cg.refdef.vieworg, NULL, NULL, g_saberFlashPos, -1, CONTENTS_SOLID );
ADDRLP4 48
ARGP4
ADDRGP4 cg+3604+24
ARGP4
ADDRLP4 1132
CNSTP4 0
ASGNP4
ADDRLP4 1132
INDIRP4
ARGP4
ADDRLP4 1132
INDIRP4
ARGP4
ADDRGP4 g_saberFlashPos
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 2795
;2794:
;2795:	if ( tr.fraction < 1.0f )
ADDRLP4 48+8
INDIRF4
CNSTF4 1065353216
GEF4 $1395
line 2796
;2796:	{
line 2797
;2797:		return;
ADDRGP4 $1364
JUMPV
LABELV $1395
line 2800
;2798:	}
;2799:
;2800:	len = VectorNormalize( dif );
ADDRLP4 0
ARGP4
ADDRLP4 1136
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 1136
INDIRF4
ASGNF4
line 2803
;2801:
;2802:	// clamp to a known range
;2803:	if ( len > 800 )
ADDRLP4 32
INDIRF4
CNSTF4 1145569280
LEF4 $1398
line 2804
;2804:	{
line 2805
;2805:		len = 800;
ADDRLP4 32
CNSTF4 1145569280
ASGNF4
line 2806
;2806:	}
LABELV $1398
line 2808
;2807:
;2808:	v = ( 1.0f - ((float)t / maxTime )) * ((1.0f - ( len / 800.0f )) * 2.0f + 0.35f);
ADDRLP4 1140
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
ADDRLP4 1140
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRI4
CVIF4 4
DIVF4
SUBF4
CNSTF4 1073741824
ADDRLP4 1140
INDIRF4
ADDRLP4 32
INDIRF4
CNSTF4 1145569280
DIVF4
SUBF4
MULF4
CNSTF4 1051931443
ADDF4
MULF4
ASGNF4
line 2810
;2809:
;2810:	CG_WorldCoordToScreenCoord( g_saberFlashPos, &x, &y );
ADDRGP4 g_saberFlashPos
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 CG_WorldCoordToScreenCoord
CALLI4
pop
line 2812
;2811:
;2812:	VectorSet( color, 0.8f, 0.8f, 0.8f );
ADDRLP4 1144
CNSTF4 1061997773
ASGNF4
ADDRLP4 20
ADDRLP4 1144
INDIRF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 1144
INDIRF4
ASGNF4
ADDRLP4 20+8
CNSTF4 1061997773
ASGNF4
line 2813
;2813:	trap_R_SetColor( color );
ADDRLP4 20
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2815
;2814:
;2815:	CG_DrawPic( x - ( v * 300 ), y - ( v * 300 ),
ADDRGP4 $1402
ARGP4
ADDRLP4 1148
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 1156
CNSTF4 1133903872
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 40
INDIRI4
CVIF4 4
ADDRLP4 1156
INDIRF4
SUBF4
ARGF4
ADDRLP4 44
INDIRI4
CVIF4 4
ADDRLP4 1156
INDIRF4
SUBF4
ARGF4
ADDRLP4 1160
CNSTF4 1142292480
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 1160
INDIRF4
ARGF4
ADDRLP4 1160
INDIRF4
ARGF4
ADDRLP4 1148
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2818
;2816:				v * 600, v * 600,
;2817:				trap_R_RegisterShader( "gfx/effects/saberFlare" ));
;2818:}
LABELV $1364
endproc CG_SaberClashFlare 1164 28
proc CG_DrawHolocronIcons 28 20
line 2823
;2819:
;2820://--------------------------------------------------------------
;2821:static void CG_DrawHolocronIcons(void)
;2822://--------------------------------------------------------------
;2823:{
line 2824
;2824:	int icon_size = 40;
ADDRLP4 8
CNSTI4 40
ASGNI4
line 2825
;2825:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2826
;2826:	int startx = 10;
ADDRLP4 12
CNSTI4 10
ASGNI4
line 2827
;2827:	int starty = 10;//SCREEN_HEIGHT - icon_size*3;
ADDRLP4 4
CNSTI4 10
ASGNI4
line 2829
;2828:
;2829:	int endx = icon_size;
ADDRLP4 16
ADDRLP4 8
INDIRI4
ASGNI4
line 2830
;2830:	int endy = icon_size;
ADDRLP4 20
ADDRLP4 8
INDIRI4
ASGNI4
line 2832
;2831:
;2832:	if (cg.snap->ps.zoomMode)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1364
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1404
line 2833
;2833:	{ //don't display over zoom mask
line 2834
;2834:		return;
ADDRGP4 $1403
JUMPV
LABELV $1404
line 2837
;2835:	}
;2836:
;2837:	if (cgs.clientinfo[cg.snap->ps.clientNum].team == TEAM_SPECTATOR)
CNSTI4 788
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1413
line 2838
;2838:	{
line 2839
;2839:		return;
ADDRGP4 $1403
JUMPV
LABELV $1412
line 2843
;2840:	}
;2841:
;2842:	while (i < NUM_FORCE_POWERS)
;2843:	{
line 2844
;2844:		if (cg.snap->ps.holocronBits & (1 << forcePowerSorted[i]))
ADDRGP4 cg+36
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 forcePowerSorted
ADDP4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $1415
line 2845
;2845:		{
line 2846
;2846:			CG_DrawPic( startx, starty, endx, endy, cgs.media.forcePowerIcons[forcePowerSorted[i]]);
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
LSHI4
ADDRGP4 forcePowerSorted
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
LSHI4
ADDRGP4 cgs+70280+1096
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2847
;2847:			starty += (icon_size+2); //+2 for spacing
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 2848
;2848:			if ((starty+icon_size) >= SCREEN_HEIGHT-80)
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
CNSTI4 400
LTI4 $1420
line 2849
;2849:			{
line 2850
;2850:				starty = 10;//SCREEN_HEIGHT - icon_size*3;
ADDRLP4 4
CNSTI4 10
ASGNI4
line 2851
;2851:				startx += (icon_size+2);
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 2852
;2852:			}
LABELV $1420
line 2853
;2853:		}
LABELV $1415
line 2855
;2854:
;2855:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2856
;2856:	}
LABELV $1413
line 2842
ADDRLP4 0
INDIRI4
CNSTI4 18
LTI4 $1412
line 2857
;2857:}
LABELV $1403
endproc CG_DrawHolocronIcons 28 20
proc CG_IsDurationPower 4 0
line 2860
;2858:
;2859:static qboolean CG_IsDurationPower(int power)
;2860:{
line 2861
;2861:	if (power == FP_HEAL ||
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1430
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $1430
ADDRLP4 0
INDIRI4
CNSTI4 5
EQI4 $1430
ADDRLP4 0
INDIRI4
CNSTI4 8
EQI4 $1430
ADDRLP4 0
INDIRI4
CNSTI4 9
EQI4 $1430
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $1430
ADDRLP4 0
INDIRI4
CNSTI4 14
NEI4 $1423
LABELV $1430
line 2868
;2862:		power == FP_SPEED ||
;2863:		power == FP_TELEPATHY ||
;2864:		power == FP_RAGE ||
;2865:		power == FP_PROTECT ||
;2866:		power == FP_ABSORB ||
;2867:		power == FP_SEE)
;2868:	{
line 2869
;2869:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1422
JUMPV
LABELV $1423
line 2872
;2870:	}
;2871:
;2872:	return qfalse;
CNSTI4 0
RETI4
LABELV $1422
endproc CG_IsDurationPower 4 0
proc CG_DrawActivePowers 36 20
line 2878
;2873:}
;2874:
;2875://--------------------------------------------------------------
;2876:static void CG_DrawActivePowers(void)
;2877://--------------------------------------------------------------
;2878:{
line 2879
;2879:	int icon_size = 40;
ADDRLP4 4
CNSTI4 40
ASGNI4
line 2880
;2880:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2881
;2881:	int startx = icon_size*2+16;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
CNSTI4 16
ADDI4
ASGNI4
line 2882
;2882:	int starty = SCREEN_HEIGHT - icon_size*2;
ADDRLP4 12
CNSTI4 480
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
SUBI4
ASGNI4
line 2884
;2883:
;2884:	int endx = icon_size;
ADDRLP4 16
ADDRLP4 4
INDIRI4
ASGNI4
line 2885
;2885:	int endy = icon_size;
ADDRLP4 20
ADDRLP4 4
INDIRI4
ASGNI4
line 2887
;2886:
;2887:	if (cg.snap->ps.zoomMode)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1364
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1432
line 2888
;2888:	{ //don't display over zoom mask
line 2889
;2889:		return;
ADDRGP4 $1431
JUMPV
LABELV $1432
line 2892
;2890:	}
;2891:
;2892:	if (cgs.clientinfo[cg.snap->ps.clientNum].team == TEAM_SPECTATOR)
CNSTI4 788
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1441
line 2893
;2893:	{
line 2894
;2894:		return;
ADDRGP4 $1431
JUMPV
LABELV $1440
line 2898
;2895:	}
;2896:
;2897:	while (i < NUM_FORCE_POWERS)
;2898:	{
line 2899
;2899:		if ((cg.snap->ps.fd.forcePowersActive & (1 << forcePowerSorted[i])) &&
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 forcePowerSorted
ADDP4
INDIRI4
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 24
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $1443
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_IsDurationPower
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $1443
line 2901
;2900:			CG_IsDurationPower(forcePowerSorted[i]))
;2901:		{
line 2902
;2902:			CG_DrawPic( startx, starty, endx, endy, cgs.media.forcePowerIcons[forcePowerSorted[i]]);
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
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 32
INDIRI4
LSHI4
ADDRGP4 forcePowerSorted
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
LSHI4
ADDRGP4 cgs+70280+1096
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2903
;2903:			startx += (icon_size+2); //+2 for spacing
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 2904
;2904:			if ((startx+icon_size) >= SCREEN_WIDTH-80)
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
CNSTI4 560
LTI4 $1448
line 2905
;2905:			{
line 2906
;2906:				startx = icon_size*2+16;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
CNSTI4 16
ADDI4
ASGNI4
line 2907
;2907:				starty += (icon_size+2);
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 2908
;2908:			}
LABELV $1448
line 2909
;2909:		}
LABELV $1443
line 2911
;2910:
;2911:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2912
;2912:	}
LABELV $1441
line 2897
ADDRLP4 0
INDIRI4
CNSTI4 18
LTI4 $1440
line 2915
;2913:
;2914:	//additionally, draw an icon force force rage recovery
;2915:	if (cg.snap->ps.fd.forceRageRecoveryTime > cg.time)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1204
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $1450
line 2916
;2916:	{
line 2917
;2917:		CG_DrawPic( startx, starty, endx, endy, cgs.media.rageRecShader);
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
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+70280+1168
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2918
;2918:	}
LABELV $1450
line 2919
;2919:}
LABELV $1431
endproc CG_DrawActivePowers 36 20
data
align 4
LABELV $1457
byte 4 0
lit
align 4
LABELV $1458
byte 4 0
byte 4 0
byte 4 0
byte 4 0
code
proc CG_DrawRocketLocking 88 24
line 2924
;2920:
;2921://--------------------------------------------------------------
;2922:static void CG_DrawRocketLocking( int lockEntNum, int lockTime )
;2923://--------------------------------------------------------------
;2924:{
line 2928
;2925:	int		cx, cy;
;2926:	vec3_t	org;
;2927:	static	int oldDif = 0;
;2928:	centity_t *cent = &cg_entities[lockEntNum];
ADDRLP4 32
CNSTI4 1920
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 2929
;2929:	vec4_t color={0.0f,0.0f,0.0f,0.0f};
ADDRLP4 0
ADDRGP4 $1458
INDIRB
ASGNB 16
line 2930
;2930:	int dif = ( cg.time - cg.snap->ps.rocketLockTime ) / ( 1200.0f / /*8.0f*/16.0f );
ADDRLP4 20
ADDRGP4 cg+64
INDIRI4
CVIF4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
SUBF4
CNSTF4 1117126656
DIVF4
CVFI4 4
ASGNI4
line 2933
;2931:	int i;
;2932:
;2933:	if (!cg.snap->ps.rocketLockTime)
ADDRGP4 cg+36
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
CNSTF4 0
NEF4 $1461
line 2934
;2934:	{
line 2935
;2935:		return;
ADDRGP4 $1456
JUMPV
LABELV $1461
line 2938
;2936:	}
;2937:
;2938:	if (cgs.clientinfo[cg.snap->ps.clientNum].team == TEAM_SPECTATOR)
CNSTI4 788
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1464
line 2939
;2939:	{
line 2940
;2940:		return;
ADDRGP4 $1456
JUMPV
LABELV $1464
line 2945
;2941:	}
;2942:
;2943:	//We can't check to see in pmove if players are on the same team, so we resort
;2944:	//to just not drawing the lock if a teammate is the locked on ent
;2945:	if (cg.snap->ps.rocketLockIndex >= 0 &&
ADDRLP4 48
CNSTI4 624
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1469
ADDRGP4 cg+36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
CNSTI4 32
GEI4 $1469
line 2947
;2946:		cg.snap->ps.rocketLockIndex < MAX_CLIENTS)
;2947:	{
line 2948
;2948:		if (cgs.clientinfo[cg.snap->ps.rocketLockIndex].team == cgs.clientinfo[cg.snap->ps.clientNum].team)
ADDRLP4 52
CNSTI4 788
ASGNI4
ADDRLP4 52
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
NEI4 $1473
line 2949
;2949:		{
line 2950
;2950:			if (cgs.gametype >= GT_TEAM)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $1481
line 2951
;2951:			{
line 2952
;2952:				return;
ADDRGP4 $1456
JUMPV
LABELV $1481
line 2954
;2953:			}
;2954:		}
LABELV $1473
line 2955
;2955:	}
LABELV $1469
line 2957
;2956:
;2957:	if (cg.snap->ps.rocketLockTime != -1)
ADDRGP4 cg+36
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
CNSTF4 3212836864
EQF4 $1484
line 2958
;2958:	{
line 2959
;2959:		lastvalidlockdif = dif;
ADDRGP4 lastvalidlockdif
ADDRLP4 20
INDIRI4
ASGNI4
line 2960
;2960:	}
ADDRGP4 $1485
JUMPV
LABELV $1484
line 2962
;2961:	else
;2962:	{
line 2963
;2963:		dif = lastvalidlockdif;
ADDRLP4 20
ADDRGP4 lastvalidlockdif
INDIRI4
ASGNI4
line 2964
;2964:	}
LABELV $1485
line 2966
;2965:
;2966:	if ( !cent )
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1487
line 2967
;2967:	{
line 2968
;2968:		return;
ADDRGP4 $1456
JUMPV
LABELV $1487
line 2971
;2969:	}
;2970:
;2971:	VectorCopy( cent->lerpOrigin, org );
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 928
ADDP4
INDIRB
ASGNB 12
line 2973
;2972:
;2973:	if ( CG_WorldCoordToScreenCoord( org, &cx, &cy ))
ADDRLP4 36
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 52
ADDRGP4 CG_WorldCoordToScreenCoord
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $1489
line 2974
;2974:	{
line 2976
;2975:		// we care about distance from enemy to eye, so this is good enough
;2976:		float sz = Distance( cent->lerpOrigin, cg.refdef.vieworg ) / 1024.0f; 
ADDRLP4 32
INDIRP4
CNSTI4 928
ADDP4
ARGP4
ADDRGP4 cg+3604+24
ARGP4
ADDRLP4 60
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 60
INDIRF4
CNSTF4 1149239296
DIVF4
ASGNF4
line 2978
;2977:		
;2978:		if ( sz > 1.0f )
ADDRLP4 56
INDIRF4
CNSTF4 1065353216
LEF4 $1493
line 2979
;2979:		{
line 2980
;2980:			sz = 1.0f;
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
line 2981
;2981:		}
ADDRGP4 $1494
JUMPV
LABELV $1493
line 2982
;2982:		else if ( sz < 0.0f )
ADDRLP4 56
INDIRF4
CNSTF4 0
GEF4 $1495
line 2983
;2983:		{
line 2984
;2984:			sz = 0.0f;
ADDRLP4 56
CNSTF4 0
ASGNF4
line 2985
;2985:		}
LABELV $1495
LABELV $1494
line 2987
;2986:
;2987:		sz = (1.0f - sz) * (1.0f - sz) * 32 + 6;
ADDRLP4 64
CNSTF4 1065353216
ADDRLP4 56
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56
CNSTF4 1107296256
ADDRLP4 64
INDIRF4
ADDRLP4 64
INDIRF4
MULF4
MULF4
CNSTF4 1086324736
ADDF4
ASGNF4
line 2989
;2988:
;2989:		cy += sz * 0.5f;
ADDRLP4 24
ADDRLP4 24
INDIRI4
CVIF4 4
CNSTF4 1056964608
ADDRLP4 56
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2991
;2990:		
;2991:		if ( dif < 0 )
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1497
line 2992
;2992:		{
line 2993
;2993:			oldDif = 0;
ADDRGP4 $1457
CNSTI4 0
ASGNI4
line 2994
;2994:			return;
ADDRGP4 $1456
JUMPV
LABELV $1497
line 2996
;2995:		}
;2996:		else if ( dif > 8 )
ADDRLP4 20
INDIRI4
CNSTI4 8
LEI4 $1499
line 2997
;2997:		{
line 2998
;2998:			dif = 8;
ADDRLP4 20
CNSTI4 8
ASGNI4
line 2999
;2999:		}
LABELV $1499
line 3002
;3000:
;3001:		// do sounds
;3002:		if ( oldDif != dif )
ADDRGP4 $1457
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $1501
line 3003
;3003:		{
line 3004
;3004:			if ( dif == 8 )
ADDRLP4 20
INDIRI4
CNSTI4 8
NEI4 $1503
line 3005
;3005:			{
line 3006
;3006:				trap_S_StartSound( org, 0, CHAN_AUTO, trap_S_RegisterSound( "sound/weapons/rocket/lock.wav" ));
ADDRGP4 $1505
ARGP4
ADDRLP4 68
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 36
ARGP4
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 3007
;3007:			}
ADDRGP4 $1504
JUMPV
LABELV $1503
line 3009
;3008:			else
;3009:			{
line 3010
;3010:				trap_S_StartSound( org, 0, CHAN_AUTO, trap_S_RegisterSound( "sound/weapons/rocket/tick.wav" ));
ADDRGP4 $1506
ARGP4
ADDRLP4 68
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 36
ARGP4
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 3011
;3011:			}
LABELV $1504
line 3012
;3012:		}
LABELV $1501
line 3014
;3013:
;3014:		oldDif = dif;
ADDRGP4 $1457
ADDRLP4 20
INDIRI4
ASGNI4
line 3016
;3015:
;3016:		for ( i = 0; i < dif; i++ )
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $1510
JUMPV
LABELV $1507
line 3017
;3017:		{
line 3018
;3018:			color[0] = 1.0f;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 3019
;3019:			color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 3020
;3020:			color[2] = 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 3021
;3021:			color[3] = 0.1f * i + 0.2f;
ADDRLP4 0+12
CNSTF4 1036831949
ADDRLP4 16
INDIRI4
CVIF4 4
MULF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 3023
;3022:
;3023:			trap_R_SetColor( color );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3026
;3024:
;3025:			// our slices are offset by about 45 degrees.
;3026:			CG_DrawRotatePic( cx - sz, cy - sz, sz, sz, i * 45.0f, trap_R_RegisterShaderNoMip( "gfx/2d/wedge" ));
ADDRGP4 $1514
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRLP4 56
INDIRF4
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ADDRLP4 56
INDIRF4
SUBF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1110704128
ADDRLP4 16
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 CG_DrawRotatePic
CALLV
pop
line 3027
;3027:		}
LABELV $1508
line 3016
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1510
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $1507
line 3030
;3028:
;3029:		// we are locked and loaded baby
;3030:		if ( dif == 8 )
ADDRLP4 20
INDIRI4
CNSTI4 8
NEI4 $1515
line 3031
;3031:		{
line 3032
;3032:			color[0] = color[1] = color[2] = sin( cg.time * 0.05f ) * 0.5f + 0.5f;
CNSTF4 1028443341
ADDRGP4 cg+64
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 72
CNSTF4 1056964608
ADDRLP4 68
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 72
INDIRF4
ASGNF4
line 3033
;3033:			color[3] = 1.0f; // this art is additive, so the alpha value does nothing
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 3035
;3034:
;3035:			trap_R_SetColor( color );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3037
;3036:
;3037:			CG_DrawPic( cx - sz, cy - sz * 2, sz * 2, sz * 2, trap_R_RegisterShaderNoMip( "gfx/2d/lock" ));
ADDRGP4 $1521
ARGP4
ADDRLP4 76
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRLP4 56
INDIRF4
SUBF4
ARGF4
ADDRLP4 84
CNSTF4 1073741824
ADDRLP4 56
INDIRF4
MULF4
ASGNF4
ADDRLP4 24
INDIRI4
CVIF4 4
ADDRLP4 84
INDIRF4
SUBF4
ARGF4
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 3038
;3038:		}
LABELV $1515
line 3039
;3039:	}
LABELV $1489
line 3040
;3040:}
LABELV $1456
endproc CG_DrawRocketLocking 88 24
proc CG_ScanForCrosshairEntity 1156 28
line 3047
;3041:
;3042:/*
;3043:=================
;3044:CG_ScanForCrosshairEntity
;3045:=================
;3046:*/
;3047:static void CG_ScanForCrosshairEntity( void ) {
line 3052
;3048:	trace_t		trace;
;3049:	vec3_t		start, end;
;3050:	int			content;
;3051:
;3052:	if ( cg_dynamicCrosshair.integer )
ADDRGP4 cg_dynamicCrosshair+12
INDIRI4
CNSTI4 0
EQI4 $1523
line 3053
;3053:	{
line 3067
;3054:		vec3_t d_f, d_rt, d_up;
;3055:		/*
;3056:		if ( cg.snap->ps.weapon == WP_NONE || 
;3057:			cg.snap->ps.weapon == WP_SABER || 
;3058:			cg.snap->ps.weapon == WP_STUN_BATON)
;3059:		{
;3060:			VectorCopy( cg.refdef.vieworg, start );
;3061:			AngleVectors( cg.refdefViewAngles, d_f, d_rt, d_up );
;3062:		}
;3063:		else
;3064:		*/
;3065:		//For now we still want to draw the crosshair in relation to the player's world coordinates
;3066:		//even if we have a melee weapon/no weapon.
;3067:		{
line 3068
;3068:			if (cg.snap && cg.snap->ps.weapon == WP_EMPLACED_GUN && cg.snap->ps.emplacedIndex)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1526
ADDRGP4 cg+36
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 14
NEI4 $1526
ADDRGP4 cg+36
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1526
line 3069
;3069:			{
line 3072
;3070:				vec3_t pitchConstraint;
;3071:
;3072:				VectorCopy(cg.refdefViewAngles, pitchConstraint);
ADDRLP4 1144
ADDRGP4 cg+3972
INDIRB
ASGNB 12
line 3074
;3073:
;3074:				if (cg.renderingThirdPerson)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
EQI4 $1532
line 3075
;3075:				{
line 3076
;3076:					VectorCopy(cg.predictedPlayerState.viewangles, pitchConstraint);
ADDRLP4 1144
ADDRGP4 cg+96+156
INDIRB
ASGNB 12
line 3077
;3077:				}
ADDRGP4 $1533
JUMPV
LABELV $1532
line 3079
;3078:				else
;3079:				{
line 3080
;3080:					VectorCopy(cg.refdefViewAngles, pitchConstraint);
ADDRLP4 1144
ADDRGP4 cg+3972
INDIRB
ASGNB 12
line 3081
;3081:				}
LABELV $1533
line 3083
;3082:
;3083:				if (pitchConstraint[PITCH] > 40)
ADDRLP4 1144
INDIRF4
CNSTF4 1109393408
LEF4 $1538
line 3084
;3084:				{
line 3085
;3085:					pitchConstraint[PITCH] = 40;
ADDRLP4 1144
CNSTF4 1109393408
ASGNF4
line 3086
;3086:				}
LABELV $1538
line 3088
;3087:
;3088:				AngleVectors( pitchConstraint, d_f, d_rt, d_up );
ADDRLP4 1144
ARGP4
ADDRLP4 1108
ARGP4
ADDRLP4 1120
ARGP4
ADDRLP4 1132
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3089
;3089:			}
ADDRGP4 $1527
JUMPV
LABELV $1526
line 3091
;3090:			else
;3091:			{
line 3094
;3092:				vec3_t pitchConstraint;
;3093:
;3094:				if (cg.renderingThirdPerson)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
EQI4 $1540
line 3095
;3095:				{
line 3096
;3096:					VectorCopy(cg.predictedPlayerState.viewangles, pitchConstraint);
ADDRLP4 1144
ADDRGP4 cg+96+156
INDIRB
ASGNB 12
line 3097
;3097:				}
ADDRGP4 $1541
JUMPV
LABELV $1540
line 3099
;3098:				else
;3099:				{
line 3100
;3100:					VectorCopy(cg.refdefViewAngles, pitchConstraint);
ADDRLP4 1144
ADDRGP4 cg+3972
INDIRB
ASGNB 12
line 3101
;3101:				}
LABELV $1541
line 3103
;3102:
;3103:				AngleVectors( pitchConstraint, d_f, d_rt, d_up );
ADDRLP4 1144
ARGP4
ADDRLP4 1108
ARGP4
ADDRLP4 1120
ARGP4
ADDRLP4 1132
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3104
;3104:			}
LABELV $1527
line 3105
;3105:			CG_CalcMuzzlePoint(cg.snap->ps.clientNum, start);
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
ADDRLP4 1080
ARGP4
ADDRGP4 CG_CalcMuzzlePoint
CALLI4
pop
line 3106
;3106:		}
line 3109
;3107:
;3108:		//FIXME: increase this?  Increase when zoom in?
;3109:		VectorMA( start, 4096, d_f, end );//was 8192
ADDRLP4 1144
CNSTF4 1166016512
ASGNF4
ADDRLP4 1092
ADDRLP4 1080
INDIRF4
ADDRLP4 1144
INDIRF4
ADDRLP4 1108
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1092+4
ADDRLP4 1080+4
INDIRF4
ADDRLP4 1144
INDIRF4
ADDRLP4 1108+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1092+8
ADDRLP4 1080+8
INDIRF4
CNSTF4 1166016512
ADDRLP4 1108+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3110
;3110:	}
ADDRGP4 $1524
JUMPV
LABELV $1523
line 3112
;3111:	else
;3112:	{
line 3113
;3113:		VectorCopy( cg.refdef.vieworg, start );
ADDRLP4 1080
ADDRGP4 cg+3604+24
INDIRB
ASGNB 12
line 3114
;3114:		VectorMA( start, 131072, cg.refdef.viewaxis[0], end );
ADDRLP4 1108
CNSTF4 1207959552
ASGNF4
ADDRLP4 1092
ADDRLP4 1080
INDIRF4
ADDRLP4 1108
INDIRF4
ADDRGP4 cg+3604+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1092+4
ADDRLP4 1080+4
INDIRF4
ADDRLP4 1108
INDIRF4
ADDRGP4 cg+3604+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 1092+8
ADDRLP4 1080+8
INDIRF4
CNSTF4 1207959552
ADDRGP4 cg+3604+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3115
;3115:	}
LABELV $1524
line 3117
;3116:
;3117:	CG_Trace( &trace, start, vec3_origin, vec3_origin, end, 
ADDRLP4 0
ARGP4
ADDRLP4 1080
ARGP4
ADDRLP4 1108
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRLP4 1092
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
CNSTI4 257
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 3120
;3118:		cg.snap->ps.clientNum, CONTENTS_SOLID|CONTENTS_BODY );
;3119:
;3120:	if (trace.entityNum < MAX_CLIENTS)
ADDRLP4 0+52
INDIRI4
CNSTI4 32
GEI4 $1568
line 3121
;3121:	{
line 3122
;3122:		if (CG_IsMindTricked(cg_entities[trace.entityNum].currentState.trickedentindex,
ADDRLP4 1112
CNSTI4 1920
ASGNI4
ADDRLP4 1112
INDIRI4
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 cg_entities+148
ADDP4
INDIRI4
ARGI4
ADDRLP4 1112
INDIRI4
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 cg_entities+152
ADDP4
INDIRI4
ARGI4
ADDRLP4 1112
INDIRI4
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 cg_entities+156
ADDP4
INDIRI4
ARGI4
ADDRLP4 1112
INDIRI4
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 cg_entities+160
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
ADDRLP4 1116
ADDRGP4 CG_IsMindTricked
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
EQI4 $1571
line 3127
;3123:			cg_entities[trace.entityNum].currentState.trickedentindex2,
;3124:			cg_entities[trace.entityNum].currentState.trickedentindex3,
;3125:			cg_entities[trace.entityNum].currentState.trickedentindex4,
;3126:			cg.snap->ps.clientNum))
;3127:		{
line 3128
;3128:			if (cg.crosshairClientNum == trace.entityNum)
ADDRGP4 cg+13084
INDIRI4
ADDRLP4 0+52
INDIRI4
NEI4 $1582
line 3129
;3129:			{
line 3130
;3130:				cg.crosshairClientNum = ENTITYNUM_NONE;
ADDRGP4 cg+13084
CNSTI4 1023
ASGNI4
line 3131
;3131:				cg.crosshairClientTime = 0;
ADDRGP4 cg+13088
CNSTI4 0
ASGNI4
line 3132
;3132:			}
LABELV $1582
line 3134
;3133:
;3134:			CG_DrawCrosshair(trace.endpos, 0);
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 3136
;3135:
;3136:			return; //this entity is mind-tricking the current client, so don't render it
ADDRGP4 $1522
JUMPV
LABELV $1571
line 3138
;3137:		}
;3138:	}
LABELV $1568
line 3140
;3139:
;3140:	if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR)
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1589
line 3141
;3141:	{
line 3142
;3142:		if (trace.entityNum < /*MAX_CLIENTS*/ENTITYNUM_WORLD)
ADDRLP4 0+52
INDIRI4
CNSTI4 1022
GEI4 $1592
line 3143
;3143:		{
line 3144
;3144:			CG_DrawCrosshair(trace.endpos, 1);
ADDRLP4 0+12
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 3145
;3145:		}
ADDRGP4 $1593
JUMPV
LABELV $1592
line 3147
;3146:		else
;3147:		{
line 3148
;3148:			CG_DrawCrosshair(trace.endpos, 0);
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 3149
;3149:		}
LABELV $1593
line 3150
;3150:	}
LABELV $1589
line 3157
;3151:
;3152://	if ( trace.entityNum >= MAX_CLIENTS ) {
;3153://		return;
;3154://	}
;3155:
;3156:	// if the player is in fog, don't show it
;3157:	content = trap_CM_PointContents( trace.endpos, 0 );
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1112
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 1104
ADDRLP4 1112
INDIRI4
ASGNI4
line 3158
;3158:	if ( content & CONTENTS_FOG ) {
ADDRLP4 1104
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1598
line 3159
;3159:		return;
ADDRGP4 $1522
JUMPV
LABELV $1598
line 3162
;3160:	}
;3161:
;3162:	if ( trace.entityNum >= MAX_CLIENTS ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 32
LTI4 $1600
line 3163
;3163:		cg.crosshairClientNum = trace.entityNum;
ADDRGP4 cg+13084
ADDRLP4 0+52
INDIRI4
ASGNI4
line 3164
;3164:		cg.crosshairClientTime = cg.time;
ADDRGP4 cg+13088
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3165
;3165:		return;
ADDRGP4 $1522
JUMPV
LABELV $1600
line 3169
;3166:	}
;3167:
;3168:	// update the fade timer
;3169:	cg.crosshairClientNum = trace.entityNum;
ADDRGP4 cg+13084
ADDRLP4 0+52
INDIRI4
ASGNI4
line 3170
;3170:	cg.crosshairClientTime = cg.time;
ADDRGP4 cg+13088
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3171
;3171:}
LABELV $1522
endproc CG_ScanForCrosshairEntity 1156 28
proc CG_DrawCrosshairNames 32 20
line 3179
;3172:
;3173:
;3174:/*
;3175:=====================
;3176:CG_DrawCrosshairNames
;3177:=====================
;3178:*/
;3179:static void CG_DrawCrosshairNames( void ) {
line 3185
;3180:	float		*color;
;3181:	vec4_t		tcolor;
;3182:	char		*name;
;3183:	int			baseColor;
;3184:
;3185:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $1612
line 3186
;3186:		return;
ADDRGP4 $1611
JUMPV
LABELV $1612
line 3190
;3187:	}
;3188:
;3189:	// scan the known entities to see if the crosshair is sighted on one
;3190:	CG_ScanForCrosshairEntity();
ADDRGP4 CG_ScanForCrosshairEntity
CALLV
pop
line 3192
;3191:
;3192:	if ( !cg_drawCrosshairNames.integer ) {
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
CNSTI4 0
NEI4 $1615
line 3193
;3193:		return;
ADDRGP4 $1611
JUMPV
LABELV $1615
line 3197
;3194:	}
;3195:	//rww - still do the trace, our dynamic crosshair depends on it
;3196:
;3197:	if (cg.crosshairClientNum >= MAX_CLIENTS)
ADDRGP4 cg+13084
INDIRI4
CNSTI4 32
LTI4 $1618
line 3198
;3198:	{
line 3199
;3199:		return;
ADDRGP4 $1611
JUMPV
LABELV $1618
line 3203
;3200:	}
;3201:
;3202:	// draw the name of the player being looked at
;3203:	color = CG_FadeColor( cg.crosshairClientTime, 1000 );
ADDRGP4 cg+13088
INDIRI4
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 28
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 28
INDIRP4
ASGNP4
line 3204
;3204:	if ( !color ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1622
line 3205
;3205:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3206
;3206:		return;
ADDRGP4 $1611
JUMPV
LABELV $1622
line 3209
;3207:	}
;3208:
;3209:	name = cgs.clientinfo[ cg.crosshairClientNum ].name;
ADDRLP4 24
CNSTI4 788
ADDRGP4 cg+13084
INDIRI4
MULI4
ADDRGP4 cgs+43008+4
ADDP4
ASGNP4
line 3211
;3210:
;3211:	if (cgs.gametype >= GT_TEAM)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
LTI4 $1627
line 3212
;3212:	{
line 3213
;3213:		if (cgs.clientinfo[cg.crosshairClientNum].team == TEAM_RED)
CNSTI4 788
ADDRGP4 cg+13084
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1630
line 3214
;3214:		{
line 3215
;3215:			baseColor = CT_RED;
ADDRLP4 16
CNSTI4 2
ASGNI4
line 3216
;3216:		}
ADDRGP4 $1628
JUMPV
LABELV $1630
line 3218
;3217:		else
;3218:		{
line 3219
;3219:			baseColor = CT_BLUE;
ADDRLP4 16
CNSTI4 4
ASGNI4
line 3220
;3220:		}
line 3233
;3221:
;3222:		/*
;3223:		//For now instead of team-based we'll make it oriented based on which team we're on
;3224:		if (cgs.clientinfo[cg.crosshairClientNum].team == cgs.clientinfo[cg.snap->ps.clientNum].team)
;3225:		{
;3226:			baseColor = CT_GREEN;
;3227:		}
;3228:		else
;3229:		{
;3230:			baseColor = CT_RED;
;3231:		}
;3232:		*/
;3233:	}
ADDRGP4 $1628
JUMPV
LABELV $1627
line 3235
;3234:	else
;3235:	{
line 3237
;3236:		//baseColor = CT_WHITE;
;3237:		baseColor = CT_RED; //just make it red in nonteam modes since everyone is hostile and crosshair will be red on them too
ADDRLP4 16
CNSTI4 2
ASGNI4
line 3238
;3238:	}
LABELV $1628
line 3240
;3239:
;3240:	if (cg.snap->ps.duelInProgress)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1635
line 3241
;3241:	{
line 3242
;3242:		if (cg.crosshairClientNum != cg.snap->ps.duelIndex)
ADDRGP4 cg+13084
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1328
ADDP4
INDIRI4
EQI4 $1636
line 3243
;3243:		{ //grey out crosshair for everyone but your foe if you're in a duel
line 3244
;3244:			baseColor = CT_BLACK;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 3245
;3245:		}
line 3246
;3246:	}
ADDRGP4 $1636
JUMPV
LABELV $1635
line 3247
;3247:	else if (cg_entities[cg.crosshairClientNum].currentState.bolt1)
CNSTI4 1920
ADDRGP4 cg+13084
INDIRI4
MULI4
ADDRGP4 cg_entities+140
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1642
line 3248
;3248:	{ //this fellow is in a duel. We just checked if we were in a duel above, so
line 3250
;3249:	  //this means we aren't and he is. Which of course means our crosshair greys out over him.
;3250:		baseColor = CT_BLACK;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 3251
;3251:	}
LABELV $1642
LABELV $1636
line 3253
;3252:
;3253:	tcolor[0] = colorTable[baseColor][0];
ADDRLP4 0
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 colorTable
ADDP4
INDIRF4
ASGNF4
line 3254
;3254:	tcolor[1] = colorTable[baseColor][1];
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 colorTable+4
ADDP4
INDIRF4
ASGNF4
line 3255
;3255:	tcolor[2] = colorTable[baseColor][2];
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 colorTable+8
ADDP4
INDIRF4
ASGNF4
line 3256
;3256:	tcolor[3] = color[3]*0.5f;
ADDRLP4 0+12
CNSTF4 1056964608
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ASGNF4
line 3258
;3257:
;3258:	UI_DrawProportionalString(320, 170, name, UI_CENTER, tcolor);
CNSTI4 320
ARGI4
CNSTI4 170
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 3260
;3259:
;3260:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3261
;3261:}
LABELV $1611
endproc CG_DrawCrosshairNames 32 20
proc CG_DrawSpectator 1076 36
line 3272
;3262:
;3263:
;3264://==============================================================================
;3265:
;3266:/*
;3267:=================
;3268:CG_DrawSpectator
;3269:=================
;3270:*/
;3271:static void CG_DrawSpectator(void) 
;3272:{	
line 3274
;3273:	const char* s;
;3274:	s = CG_GetStripEdString("INGAMETEXT", "SPECTATOR");
ADDRGP4 $897
ARGP4
ADDRGP4 $1652
ARGP4
ADDRLP4 4
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 3275
;3275:	if (cgs.gametype == GT_TOURNAMENT &&
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 3
NEI4 $1653
ADDRLP4 8
CNSTI4 -1
ASGNI4
ADDRGP4 cgs+36324
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $1653
ADDRGP4 cgs+36328
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $1653
line 3278
;3276:		cgs.duelist1 != -1 &&
;3277:		cgs.duelist2 != -1)
;3278:	{
line 3280
;3279:		char text[1024];
;3280:		int size = 64;
ADDRLP4 12
CNSTI4 64
ASGNI4
line 3282
;3281:
;3282:		Com_sprintf(text, sizeof(text), "%s %s %s", cgs.clientinfo[cgs.duelist1].name, CG_GetStripEdString("INGAMETEXT", "SPECHUD_VERSUS"), cgs.clientinfo[cgs.duelist2].name);
ADDRGP4 $897
ARGP4
ADDRGP4 $1662
ARGP4
ADDRLP4 1040
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1658
ARGP4
ADDRLP4 1044
CNSTI4 788
ASGNI4
ADDRLP4 1044
INDIRI4
ADDRGP4 cgs+36324
INDIRI4
MULI4
ADDRGP4 cgs+43008+4
ADDP4
ARGP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
INDIRI4
ADDRGP4 cgs+36328
INDIRI4
MULI4
ADDRGP4 cgs+43008+4
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3283
;3283:		CG_Text_Paint ( 320 - CG_Text_Width ( text, 1.0f, 3 ) / 2, 420, 1.0f, colorWhite, text, 0, 0, 0, 3 );
ADDRLP4 16
ARGP4
CNSTF4 1065353216
ARGF4
CNSTI4 3
ARGI4
ADDRLP4 1048
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
CNSTI4 320
ADDRLP4 1048
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1137836032
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 16
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 1052
CNSTI4 0
ASGNI4
ADDRLP4 1052
INDIRI4
ARGI4
ADDRLP4 1052
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 3286
;3284:
;3285:
;3286:		if (cgs.clientinfo[cgs.duelist1].modelIcon &&
ADDRLP4 1056
CNSTI4 788
ASGNI4
ADDRLP4 1060
CNSTI4 0
ASGNI4
ADDRLP4 1056
INDIRI4
ADDRGP4 cgs+36324
INDIRI4
MULI4
ADDRGP4 cgs+43008+508
ADDP4
INDIRI4
ADDRLP4 1060
INDIRI4
EQI4 $1654
ADDRLP4 1056
INDIRI4
ADDRGP4 cgs+36328
INDIRI4
MULI4
ADDRGP4 cgs+43008+508
ADDP4
INDIRI4
ADDRLP4 1060
INDIRI4
EQI4 $1654
line 3288
;3287:			cgs.clientinfo[cgs.duelist2].modelIcon)
;3288:		{
line 3289
;3289:			trap_R_SetColor( colorTable[CT_WHITE] );
ADDRGP4 colorTable+128
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3290
;3290:			CG_DrawPic( 10, SCREEN_HEIGHT-(size*1.5), size, size, cgs.clientinfo[cgs.duelist1].modelIcon );
CNSTF4 1092616192
ARGF4
ADDRLP4 1064
ADDRLP4 12
INDIRI4
CVIF4 4
ASGNF4
CNSTF4 1139802112
CNSTF4 1069547520
ADDRLP4 1064
INDIRF4
MULF4
SUBF4
ARGF4
ADDRLP4 1064
INDIRF4
ARGF4
ADDRLP4 1064
INDIRF4
ARGF4
CNSTI4 788
ADDRGP4 cgs+36324
INDIRI4
MULI4
ADDRGP4 cgs+43008+508
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 3291
;3291:			CG_DrawPic( SCREEN_WIDTH-size-10, SCREEN_HEIGHT-(size*1.5), size, size, cgs.clientinfo[cgs.duelist2].modelIcon );
ADDRLP4 1068
ADDRLP4 12
INDIRI4
ASGNI4
CNSTI4 640
ADDRLP4 1068
INDIRI4
SUBI4
CNSTI4 10
SUBI4
CVIF4 4
ARGF4
ADDRLP4 1072
ADDRLP4 1068
INDIRI4
CVIF4 4
ASGNF4
CNSTF4 1139802112
CNSTF4 1069547520
ADDRLP4 1072
INDIRF4
MULF4
SUBF4
ARGF4
ADDRLP4 1072
INDIRF4
ARGF4
ADDRLP4 1072
INDIRF4
ARGF4
CNSTI4 788
ADDRGP4 cgs+36328
INDIRI4
MULI4
ADDRGP4 cgs+43008+508
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 3292
;3292:		}
line 3293
;3293:	}
ADDRGP4 $1654
JUMPV
LABELV $1653
line 3295
;3294:	else
;3295:	{
line 3296
;3296:		CG_Text_Paint ( 320 - CG_Text_Width ( s, 1.0f, 3 ) / 2, 420, 1.0f, colorWhite, s, 0, 0, 0, 3 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
CNSTI4 3
ARGI4
ADDRLP4 12
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
CNSTI4 320
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1137836032
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 3297
;3297:	}
LABELV $1654
line 3299
;3298:
;3299:	if ( cgs.gametype == GT_TOURNAMENT ) 
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 3
NEI4 $1681
line 3300
;3300:	{
line 3301
;3301:		s = CG_GetStripEdString("INGAMETEXT", "WAITING_TO_PLAY");	// "waiting to play";
ADDRGP4 $897
ARGP4
ADDRGP4 $1684
ARGP4
ADDRLP4 12
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 3302
;3302:		CG_Text_Paint ( 320 - CG_Text_Width ( s, 1.0f, 3 ) / 2, 440, 1.0f, colorWhite, s, 0, 0, 0, 3 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
CNSTI4 3
ARGI4
ADDRLP4 16
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
CNSTI4 320
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1138491392
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 3303
;3303:	}
ADDRGP4 $1682
JUMPV
LABELV $1681
line 3305
;3304:	else //if ( cgs.gametype >= GT_TEAM ) 
;3305:	{
line 3307
;3306:		//s = "press ESC and use the JOIN menu to play";
;3307:		s = CG_GetStripEdString("INGAMETEXT", "SPEC_CHOOSEJOIN");
ADDRGP4 $897
ARGP4
ADDRGP4 $1685
ARGP4
ADDRLP4 12
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 3308
;3308:		CG_Text_Paint ( 320 - CG_Text_Width ( s, 1.0f, 3 ) / 2, 440, 1.0f, colorWhite, s, 0, 0, 0, 3 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
CNSTI4 3
ARGI4
ADDRLP4 16
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
CNSTI4 320
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1138491392
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 3309
;3309:	}
LABELV $1682
line 3310
;3310:}
LABELV $1651
endproc CG_DrawSpectator 1076 36
proc CG_DrawVote 56 28
line 3317
;3311:
;3312:/*
;3313:=================
;3314:CG_DrawVote
;3315:=================
;3316:*/
;3317:static void CG_DrawVote(void) {
line 3323
;3318:	const char	*s;
;3319:	int		sec;
;3320:	char sYes[20];
;3321:	char sNo[20];
;3322:
;3323:	if ( !cgs.voteTime ) {
ADDRGP4 cgs+33184
INDIRI4
CNSTI4 0
NEI4 $1687
line 3324
;3324:		return;
ADDRGP4 $1686
JUMPV
LABELV $1687
line 3328
;3325:	}
;3326:
;3327:	// play a talk beep whenever it is modified
;3328:	if ( cgs.voteModified ) {
ADDRGP4 cgs+33196
INDIRI4
CNSTI4 0
EQI4 $1690
line 3329
;3329:		cgs.voteModified = qfalse;
ADDRGP4 cgs+33196
CNSTI4 0
ASGNI4
line 3331
;3330://		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
;3331:	}
LABELV $1690
line 3333
;3332:
;3333:	sec = ( VOTE_TIME - ( cg.time - cgs.voteTime ) ) / 1000;
ADDRLP4 4
CNSTI4 30000
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgs+33184
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3334
;3334:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1696
line 3335
;3335:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3336
;3336:	}
LABELV $1696
line 3338
;3337:
;3338:	trap_SP_GetStringTextString("MENUS0_YES", sYes, sizeof(sYes) );
ADDRGP4 $1698
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 3339
;3339:	trap_SP_GetStringTextString("MENUS0_NO",  sNo,  sizeof(sNo) );
ADDRGP4 $1699
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 3341
;3340:
;3341:	s = va("VOTE(%i):%s %s:%i %s:%i", sec, cgs.voteString, sYes, cgs.voteYes, sNo, cgs.voteNo);
ADDRGP4 $1700
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+33200
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 cgs+33188
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 cgs+33192
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
line 3342
;3342:	CG_DrawSmallString( 4, 58, s, 1.0F );
CNSTI4 4
ARGI4
CNSTI4 58
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 3343
;3343:	s = CG_GetStripEdString("INGAMETEXT", "OR_PRESS_ESC_THEN_CLICK_VOTE");	//	s = "or press ESC then click Vote";
ADDRGP4 $897
ARGP4
ADDRGP4 $1704
ARGP4
ADDRLP4 52
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 3344
;3344:	CG_DrawSmallString( 4, 58 + SMALLCHAR_HEIGHT + 2, s, 1.0F );
CNSTI4 4
ARGI4
CNSTI4 76
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 3345
;3345:}
LABELV $1686
endproc CG_DrawVote 56 28
proc CG_DrawTeamVote 300 20
line 3352
;3346:
;3347:/*
;3348:=================
;3349:CG_DrawTeamVote
;3350:=================
;3351:*/
;3352:static void CG_DrawTeamVote(void) {
line 3356
;3353:	char	*s;
;3354:	int		sec, cs_offset;
;3355:
;3356:	if ( cgs.clientinfo->team == TEAM_RED )
ADDRGP4 cgs+43008+68
INDIRI4
CNSTI4 1
NEI4 $1706
line 3357
;3357:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1707
JUMPV
LABELV $1706
line 3358
;3358:	else if ( cgs.clientinfo->team == TEAM_BLUE )
ADDRGP4 cgs+43008+68
INDIRI4
CNSTI4 2
NEI4 $1705
line 3359
;3359:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3361
;3360:	else
;3361:		return;
LABELV $1711
LABELV $1707
line 3363
;3362:
;3363:	if ( !cgs.teamVoteTime[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34224
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1714
line 3364
;3364:		return;
ADDRGP4 $1705
JUMPV
LABELV $1714
line 3368
;3365:	}
;3366:
;3367:	// play a talk beep whenever it is modified
;3368:	if ( cgs.teamVoteModified[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1717
line 3369
;3369:		cgs.teamVoteModified[cs_offset] = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34248
ADDP4
CNSTI4 0
ASGNI4
line 3371
;3370://		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
;3371:	}
LABELV $1717
line 3373
;3372:
;3373:	sec = ( VOTE_TIME - ( cg.time - cgs.teamVoteTime[cs_offset] ) ) / 1000;
ADDRLP4 4
CNSTI4 30000
ADDRGP4 cg+64
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34224
ADDP4
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3374
;3374:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1723
line 3375
;3375:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3376
;3376:	}
LABELV $1723
line 3377
;3377:	if (strstr(cgs.teamVoteString[cs_offset], "leader"))
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+34256
ADDP4
ARGP4
ADDRGP4 $1728
ARGP4
ADDRLP4 12
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1725
line 3378
;3378:	{
line 3379
;3379:		int i = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $1730
JUMPV
LABELV $1729
line 3382
;3380:
;3381:		while (cgs.teamVoteString[cs_offset][i] && cgs.teamVoteString[cs_offset][i] != ' ')
;3382:		{
line 3383
;3383:			i++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3384
;3384:		}
LABELV $1730
line 3381
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 24
INDIRI4
ADDRGP4 cgs+34256
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1734
ADDRLP4 16
INDIRI4
ADDRLP4 24
INDIRI4
ADDRGP4 cgs+34256
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $1729
LABELV $1734
line 3386
;3385:
;3386:		if (cgs.teamVoteString[cs_offset][i] == ' ')
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+34256
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $1735
line 3387
;3387:		{
line 3388
;3388:			int voteIndex = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 3391
;3389:			char voteIndexStr[256];
;3390:
;3391:			i++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $1739
JUMPV
LABELV $1738
line 3394
;3392:
;3393:			while (cgs.teamVoteString[cs_offset][i])
;3394:			{
line 3395
;3395:				voteIndexStr[voteIndex] = cgs.teamVoteString[cs_offset][i];
ADDRLP4 28
INDIRI4
ADDRLP4 32
ADDP4
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+34256
ADDP4
ADDP4
INDIRI1
ASGNI1
line 3396
;3396:				voteIndex++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3397
;3397:				i++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3398
;3398:			}
LABELV $1739
line 3393
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+34256
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1738
line 3399
;3399:			voteIndexStr[voteIndex] = 0;
ADDRLP4 28
INDIRI4
ADDRLP4 32
ADDP4
CNSTI1 0
ASGNI1
line 3401
;3400:
;3401:			voteIndex = atoi(voteIndexStr);
ADDRLP4 32
ARGP4
ADDRLP4 288
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 288
INDIRI4
ASGNI4
line 3403
;3402:
;3403:			s = va("TEAMVOTE(%i):(Make %s the new team leader) yes:%i no:%i", sec, cgs.clientinfo[voteIndex].name,
ADDRGP4 $1743
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 788
ADDRLP4 28
INDIRI4
MULI4
ADDRGP4 cgs+43008+4
ADDP4
ARGP4
ADDRLP4 292
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 292
INDIRI4
ADDRGP4 cgs+34232
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
INDIRI4
ADDRGP4 cgs+34240
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 296
INDIRP4
ASGNP4
line 3405
;3404:									cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;3405:		}
ADDRGP4 $1726
JUMPV
LABELV $1735
line 3407
;3406:		else
;3407:		{
line 3408
;3408:			s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
ADDRGP4 $1748
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+34256
ADDP4
ARGP4
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+34232
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+34240
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
ASGNP4
line 3410
;3409:									cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;3410:		}
line 3411
;3411:	}
ADDRGP4 $1726
JUMPV
LABELV $1725
line 3413
;3412:	else
;3413:	{
line 3414
;3414:		s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
ADDRGP4 $1748
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+34256
ADDP4
ARGP4
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 cgs+34232
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ADDRGP4 cgs+34240
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 3416
;3415:								cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;3416:	}
LABELV $1726
line 3417
;3417:	CG_DrawSmallString( 4, 90, s, 1.0F );
CNSTI4 4
ARGI4
CNSTI4 90
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 3418
;3418:}
LABELV $1705
endproc CG_DrawTeamVote 300 20
proc CG_DrawScoreboard 4 0
line 3420
;3419:
;3420:static qboolean CG_DrawScoreboard() {
line 3421
;3421:	return CG_DrawOldScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawOldScoreboard
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $1755
endproc CG_DrawScoreboard 4 0
proc CG_DrawIntermission 4 0
line 3493
;3422:#if 0
;3423:	static qboolean firstTime = qtrue;
;3424:	float fade, *fadeColor;
;3425:
;3426:	if (menuScoreboard) {
;3427:		menuScoreboard->window.flags &= ~WINDOW_FORCED;
;3428:	}
;3429:	if (cg_paused.integer) {
;3430:		cg.deferredPlayerLoading = 0;
;3431:		firstTime = qtrue;
;3432:		return qfalse;
;3433:	}
;3434:
;3435:	// should never happen in Team Arena
;3436:	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;3437:		cg.deferredPlayerLoading = 0;
;3438:		firstTime = qtrue;
;3439:		return qfalse;
;3440:	}
;3441:
;3442:	// don't draw scoreboard during death while warmup up
;3443:	if ( cg.warmup && !cg.showScores ) {
;3444:		return qfalse;
;3445:	}
;3446:
;3447:	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;3448:		fade = 1.0;
;3449:		fadeColor = colorWhite;
;3450:	} else {
;3451:		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );
;3452:		if ( !fadeColor ) {
;3453:			// next time scoreboard comes up, don't print killer
;3454:			cg.deferredPlayerLoading = 0;
;3455:			cg.killerName[0] = 0;
;3456:			firstTime = qtrue;
;3457:			return qfalse;
;3458:		}
;3459:		fade = *fadeColor;
;3460:	}																					  
;3461:
;3462:
;3463:	if (menuScoreboard == NULL) {
;3464:		if ( cgs.gametype >= GT_TEAM ) {
;3465:			menuScoreboard = Menus_FindByName("teamscore_menu");
;3466:		} else {
;3467:			menuScoreboard = Menus_FindByName("score_menu");
;3468:		}
;3469:	}
;3470:
;3471:	if (menuScoreboard) {
;3472:		if (firstTime) {
;3473:			CG_SetScoreSelection(menuScoreboard);
;3474:			firstTime = qfalse;
;3475:		}
;3476:		Menu_Paint(menuScoreboard, qtrue);
;3477:	}
;3478:
;3479:	// load any models that have been deferred
;3480:	if ( ++cg.deferredPlayerLoading > 10 ) {
;3481:		CG_LoadDeferredPlayers();
;3482:	}
;3483:
;3484:	return qtrue;
;3485:#endif
;3486:}
;3487:
;3488:/*
;3489:=================
;3490:CG_DrawIntermission
;3491:=================
;3492:*/
;3493:static void CG_DrawIntermission( void ) {
line 3499
;3494://	int key;
;3495:	//if (cg_singlePlayer.integer) {
;3496:	//	CG_DrawCenterString();
;3497:	//	return;
;3498:	//}
;3499:	cg.scoreFadeTime = cg.time;
ADDRGP4 cg+6980
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3500
;3500:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+6976
ADDRLP4 0
INDIRI4
ASGNI4
line 3501
;3501:}
LABELV $1756
endproc CG_DrawIntermission 4 0
proc CG_DrawFollow 32 36
line 3509
;3502:
;3503:/*
;3504:=================
;3505:CG_DrawFollow
;3506:=================
;3507:*/
;3508:static qboolean CG_DrawFollow( void ) 
;3509:{
line 3512
;3510:	const char	*s;
;3511:
;3512:	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) ) 
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $1761
line 3513
;3513:	{
line 3514
;3514:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1760
JUMPV
LABELV $1761
line 3518
;3515:	}
;3516:
;3517://	s = "following";
;3518:	s = CG_GetStripEdString("INGAMETEXT", "FOLLOWING");
ADDRGP4 $897
ARGP4
ADDRGP4 $1764
ARGP4
ADDRLP4 4
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 3519
;3519:	CG_Text_Paint ( 320 - CG_Text_Width ( s, 1.0f, FONT_MEDIUM ) / 2, 60, 1.0f, colorWhite, s, 0, 0, 0, FONT_MEDIUM );
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 8
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 12
CNSTI4 2
ASGNI4
CNSTI4 320
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1114636288
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 3521
;3520:
;3521:	s = cgs.clientinfo[ cg.snap->ps.clientNum ].name;
ADDRLP4 0
CNSTI4 788
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+4
ADDP4
ASGNP4
line 3522
;3522:	CG_Text_Paint ( 320 - CG_Text_Width ( s, 2.0f, FONT_MEDIUM ) / 2, 80, 2.0f, colorWhite, s, 0, 0, 0, FONT_MEDIUM );
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1073741824
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 20
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 24
CNSTI4 2
ASGNI4
CNSTI4 320
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1117782016
ARGF4
CNSTF4 1073741824
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 0
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
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 3524
;3523:
;3524:	return qtrue;
CNSTI4 1
RETI4
LABELV $1760
endproc CG_DrawFollow 32 36
proc CG_DrawAmmoWarning 0 0
line 3560
;3525:}
;3526:
;3527:#if 0
;3528:static void CG_DrawTemporaryStats()
;3529:{ //placeholder for testing (draws ammo and force power)
;3530:	char s[512];
;3531:
;3532:	if (!cg.snap)
;3533:	{
;3534:		return;
;3535:	}
;3536:
;3537:	sprintf(s, "Force: %i", cg.snap->ps.fd.forcePower);
;3538:
;3539:	CG_DrawBigString(SCREEN_WIDTH-164, SCREEN_HEIGHT-128, s, 1.0f);
;3540:
;3541:	sprintf(s, "Ammo: %i", cg.snap->ps.ammo[weaponData[cg.snap->ps.weapon].ammoIndex]);
;3542:
;3543:	CG_DrawBigString(SCREEN_WIDTH-164, SCREEN_HEIGHT-112, s, 1.0f);
;3544:
;3545:	sprintf(s, "Health: %i", cg.snap->ps.stats[STAT_HEALTH]);
;3546:
;3547:	CG_DrawBigString(8, SCREEN_HEIGHT-128, s, 1.0f);
;3548:
;3549:	sprintf(s, "Armor: %i", cg.snap->ps.stats[STAT_ARMOR]);
;3550:
;3551:	CG_DrawBigString(8, SCREEN_HEIGHT-112, s, 1.0f);
;3552:}
;3553:#endif
;3554:
;3555:/*
;3556:=================
;3557:CG_DrawAmmoWarning
;3558:=================
;3559:*/
;3560:static void CG_DrawAmmoWarning( void ) {
line 3586
;3561:#if 0
;3562:	const char	*s;
;3563:	int			w;
;3564:
;3565:	if (!cg_drawStatus.integer)
;3566:	{
;3567:		return;
;3568:	}
;3569:
;3570:	if ( cg_drawAmmoWarning.integer == 0 ) {
;3571:		return;
;3572:	}
;3573:
;3574:	if ( !cg.lowAmmoWarning ) {
;3575:		return;
;3576:	}
;3577:
;3578:	if ( cg.lowAmmoWarning == 2 ) {
;3579:		s = "OUT OF AMMO";
;3580:	} else {
;3581:		s = "LOW AMMO WARNING";
;3582:	}
;3583:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
;3584:	CG_DrawBigString(320 - w / 2, 64, s, 1.0F);
;3585:#endif
;3586:}
LABELV $1768
endproc CG_DrawAmmoWarning 0 0
proc CG_DrawWarmup 52 36
line 3595
;3587:
;3588:
;3589:
;3590:/*
;3591:=================
;3592:CG_DrawWarmup
;3593:=================
;3594:*/
;3595:static void CG_DrawWarmup( void ) {
line 3604
;3596:	int			w;
;3597:	int			sec;
;3598:	int			i;
;3599:	float scale;
;3600:	clientInfo_t	*ci1, *ci2;
;3601:	int			cw;
;3602:	const char	*s;
;3603:
;3604:	sec = cg.warmup;
ADDRLP4 4
ADDRGP4 cg+13340
INDIRI4
ASGNI4
line 3605
;3605:	if ( !sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1771
line 3606
;3606:		return;
ADDRGP4 $1769
JUMPV
LABELV $1771
line 3609
;3607:	}
;3608:
;3609:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1773
line 3611
;3610://		s = "Waiting for players";		
;3611:		s = CG_GetStripEdString("INGAMETEXT", "WAITING_FOR_PLAYERS");
ADDRGP4 $897
ARGP4
ADDRGP4 $1775
ARGP4
ADDRLP4 32
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 3612
;3612:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 36
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 3613
;3613:		CG_DrawBigString(320 - w / 2, 24, s, 1.0F);
CNSTI4 320
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 3614
;3614:		cg.warmupCount = 0;
ADDRGP4 cg+13344
CNSTI4 0
ASGNI4
line 3615
;3615:		return;
ADDRGP4 $1769
JUMPV
LABELV $1773
line 3618
;3616:	}
;3617:
;3618:	if (cgs.gametype == GT_TOURNAMENT) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 3
NEI4 $1777
line 3620
;3619:		// find the two active players
;3620:		ci1 = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 3621
;3621:		ci2 = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 3622
;3622:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1783
JUMPV
LABELV $1780
line 3623
;3623:			if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE ) {
ADDRLP4 32
CNSTI4 788
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+43008
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $1785
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1785
line 3624
;3624:				if ( !ci1 ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1790
line 3625
;3625:					ci1 = &cgs.clientinfo[i];
ADDRLP4 12
CNSTI4 788
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 3626
;3626:				} else {
ADDRGP4 $1791
JUMPV
LABELV $1790
line 3627
;3627:					ci2 = &cgs.clientinfo[i];
ADDRLP4 24
CNSTI4 788
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+43008
ADDP4
ASGNP4
line 3628
;3628:				}
LABELV $1791
line 3629
;3629:			}
LABELV $1785
line 3630
;3630:		}
LABELV $1781
line 3622
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1783
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+32988
INDIRI4
LTI4 $1780
line 3632
;3631:
;3632:		if ( ci1 && ci2 ) {
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1778
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1778
line 3633
;3633:			s = va( "%s vs %s", ci1->name, ci2->name );
ADDRGP4 $1796
ARGP4
ADDRLP4 36
CNSTI4 4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
ASGNP4
line 3634
;3634:			w = CG_Text_Width(s, 0.6f, FONT_MEDIUM);
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1058642330
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 44
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 44
INDIRI4
ASGNI4
line 3635
;3635:			CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE,FONT_MEDIUM);
ADDRLP4 48
CNSTI4 2
ASGNI4
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 48
INDIRI4
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1114636288
ARGF4
CNSTF4 1058642330
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 3636
;3636:		}
line 3637
;3637:	} else {
ADDRGP4 $1778
JUMPV
LABELV $1777
line 3638
;3638:		if ( cgs.gametype == GT_FFA ) {
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 0
NEI4 $1797
line 3639
;3639:			s = "Free For All";
ADDRLP4 8
ADDRGP4 $1800
ASGNP4
line 3640
;3640:		} else if ( cgs.gametype == GT_HOLOCRON ) {
ADDRGP4 $1798
JUMPV
LABELV $1797
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 1
NEI4 $1801
line 3641
;3641:			s = "Holocron FFA";
ADDRLP4 8
ADDRGP4 $1804
ASGNP4
line 3642
;3642:		} else if ( cgs.gametype == GT_JEDIMASTER ) {
ADDRGP4 $1802
JUMPV
LABELV $1801
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 2
NEI4 $1805
line 3643
;3643:			s = "Jedi Master";
ADDRLP4 8
ADDRGP4 $1808
ASGNP4
line 3644
;3644:		} else if ( cgs.gametype == GT_TEAM ) {
ADDRGP4 $1806
JUMPV
LABELV $1805
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 5
NEI4 $1809
line 3645
;3645:			s = "Team FFA";
ADDRLP4 8
ADDRGP4 $1812
ASGNP4
line 3646
;3646:		} else if ( cgs.gametype == GT_SAGA ) {
ADDRGP4 $1810
JUMPV
LABELV $1809
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 6
NEI4 $1813
line 3647
;3647:			s = "N/A";
ADDRLP4 8
ADDRGP4 $1816
ASGNP4
line 3648
;3648:		} else if ( cgs.gametype == GT_CTF ) {
ADDRGP4 $1814
JUMPV
LABELV $1813
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
NEI4 $1817
line 3649
;3649:			s = "Capture the Flag";
ADDRLP4 8
ADDRGP4 $1820
ASGNP4
line 3650
;3650:		} else if ( cgs.gametype == GT_CTY ) {
ADDRGP4 $1818
JUMPV
LABELV $1817
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $1821
line 3651
;3651:			s = "Capture the Ysalamiri";
ADDRLP4 8
ADDRGP4 $1824
ASGNP4
line 3652
;3652:		} else {
ADDRGP4 $1822
JUMPV
LABELV $1821
line 3653
;3653:			s = "";
ADDRLP4 8
ADDRGP4 $658
ASGNP4
line 3654
;3654:		}
LABELV $1822
LABELV $1818
LABELV $1814
LABELV $1810
LABELV $1806
LABELV $1802
LABELV $1798
line 3655
;3655:		w = CG_Text_Width(s, 1.5f, FONT_MEDIUM);
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1069547520
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 32
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 3656
;3656:		CG_Text_Paint(320 - w / 2, 90, 1.5f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE,FONT_MEDIUM);
ADDRLP4 36
CNSTI4 2
ASGNI4
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 36
INDIRI4
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1069547520
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 3657
;3657:	}
LABELV $1778
line 3659
;3658:
;3659:	sec = ( sec - cg.time ) / 1000;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRGP4 cg+64
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3660
;3660:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1826
line 3661
;3661:		cg.warmup = 0;
ADDRGP4 cg+13340
CNSTI4 0
ASGNI4
line 3662
;3662:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3663
;3663:	}
LABELV $1826
line 3665
;3664://	s = va( "Starts in: %i", sec + 1 );
;3665:	s = va( "%s: %i",CG_GetStripEdString("INGAMETEXT", "STARTS_IN"), sec + 1 );
ADDRGP4 $897
ARGP4
ADDRGP4 $1829
ARGP4
ADDRLP4 32
ADDRGP4 CG_GetStripEdString
CALLP4
ASGNP4
ADDRGP4 $932
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
ASGNP4
line 3666
;3666:	if ( sec != cg.warmupCount ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+13344
INDIRI4
EQI4 $1830
line 3667
;3667:		cg.warmupCount = sec;
ADDRGP4 cg+13344
ADDRLP4 4
INDIRI4
ASGNI4
line 3668
;3668:		switch ( sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1836
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $1839
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $1842
ADDRGP4 $1835
JUMPV
LABELV $1836
line 3670
;3669:		case 0:
;3670:			trap_S_StartLocalSound( cgs.media.count1Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+70280+860
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3671
;3671:			break;
ADDRGP4 $1835
JUMPV
LABELV $1839
line 3673
;3672:		case 1:
;3673:			trap_S_StartLocalSound( cgs.media.count2Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+70280+856
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3674
;3674:			break;
ADDRGP4 $1835
JUMPV
LABELV $1842
line 3676
;3675:		case 2:
;3676:			trap_S_StartLocalSound( cgs.media.count3Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+70280+852
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3677
;3677:			break;
line 3679
;3678:		default:
;3679:			break;
LABELV $1835
line 3681
;3680:		}
;3681:	}
LABELV $1830
line 3682
;3682:	scale = 0.45f;
ADDRLP4 20
CNSTF4 1055286886
ASGNF4
line 3683
;3683:	switch ( cg.warmupCount ) {
ADDRLP4 40
ADDRGP4 cg+13344
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $1848
ADDRLP4 40
INDIRI4
CNSTI4 1
EQI4 $1849
ADDRLP4 40
INDIRI4
CNSTI4 2
EQI4 $1850
ADDRGP4 $1845
JUMPV
LABELV $1848
line 3685
;3684:	case 0:
;3685:		cw = 28;
ADDRLP4 28
CNSTI4 28
ASGNI4
line 3686
;3686:		scale = 1.25f;
ADDRLP4 20
CNSTF4 1067450368
ASGNF4
line 3687
;3687:		break;
ADDRGP4 $1846
JUMPV
LABELV $1849
line 3689
;3688:	case 1:
;3689:		cw = 24;
ADDRLP4 28
CNSTI4 24
ASGNI4
line 3690
;3690:		scale = 1.15f;
ADDRLP4 20
CNSTF4 1066611507
ASGNF4
line 3691
;3691:		break;
ADDRGP4 $1846
JUMPV
LABELV $1850
line 3693
;3692:	case 2:
;3693:		cw = 20;
ADDRLP4 28
CNSTI4 20
ASGNI4
line 3694
;3694:		scale = 1.05f;
ADDRLP4 20
CNSTF4 1065772646
ASGNF4
line 3695
;3695:		break;
ADDRGP4 $1846
JUMPV
LABELV $1845
line 3697
;3696:	default:
;3697:		cw = 16;
ADDRLP4 28
CNSTI4 16
ASGNI4
line 3698
;3698:		scale = 0.9f;
ADDRLP4 20
CNSTF4 1063675494
ASGNF4
line 3699
;3699:		break;
LABELV $1846
line 3702
;3700:	}
;3701:
;3702:	w = CG_Text_Width(s, scale, FONT_MEDIUM);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 44
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 44
INDIRI4
ASGNI4
line 3703
;3703:	CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE, FONT_MEDIUM);
ADDRLP4 48
CNSTI4 2
ASGNI4
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 48
INDIRI4
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1123680256
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 3704
;3704:}
LABELV $1769
endproc CG_DrawWarmup 52 36
export CG_DrawTimedMenus
proc CG_DrawTimedMenus 4 8
line 3712
;3705:
;3706://==================================================================================
;3707:/* 
;3708:=================
;3709:CG_DrawTimedMenus
;3710:=================
;3711:*/
;3712:void CG_DrawTimedMenus() {
line 3713
;3713:	if (cg.voiceTime) {
ADDRGP4 cg+13104
INDIRI4
CNSTI4 0
EQI4 $1852
line 3714
;3714:		int t = cg.time - cg.voiceTime;
ADDRLP4 0
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+13104
INDIRI4
SUBI4
ASGNI4
line 3715
;3715:		if ( t > 2500 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2500
LEI4 $1857
line 3716
;3716:			Menus_CloseByName("voiceMenu");
ADDRGP4 $1859
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 3717
;3717:			trap_Cvar_Set("cl_conXOffset", "0");
ADDRGP4 $1860
ARGP4
ADDRGP4 $1861
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3718
;3718:			cg.voiceTime = 0;
ADDRGP4 cg+13104
CNSTI4 0
ASGNI4
line 3719
;3719:		}
LABELV $1857
line 3720
;3720:	}
LABELV $1852
line 3721
;3721:}
LABELV $1851
endproc CG_DrawTimedMenus 4 8
export CG_DrawFlagStatus
proc CG_DrawFlagStatus 32 20
line 3724
;3722:
;3723:void CG_DrawFlagStatus()
;3724:{
line 3725
;3725:	int myFlagTakenShader = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3726
;3726:	int theirFlagShader = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 3727
;3727:	int team = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3728
;3728:	int startDrawPos = 2;
ADDRLP4 16
CNSTI4 2
ASGNI4
line 3729
;3729:	int ico_size = 32;
ADDRLP4 0
CNSTI4 32
ASGNI4
line 3731
;3730:
;3731:	if (!cg.snap)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1864
line 3732
;3732:	{
line 3733
;3733:		return;
ADDRGP4 $1863
JUMPV
LABELV $1864
line 3736
;3734:	}
;3735:
;3736:	if (cgs.gametype != GT_CTF && cgs.gametype != GT_CTY)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 7
EQI4 $1867
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
EQI4 $1867
line 3737
;3737:	{
line 3738
;3738:		return;
ADDRGP4 $1863
JUMPV
LABELV $1867
line 3741
;3739:	}
;3740:
;3741:	team = cg.snap->ps.persistant[PERS_TEAM];
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
ASGNI4
line 3743
;3742:
;3743:	if (cgs.gametype == GT_CTY)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 8
NEI4 $1872
line 3744
;3744:	{
line 3745
;3745:		if (team == TEAM_RED)
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $1875
line 3746
;3746:		{
line 3747
;3747:			myFlagTakenShader = trap_R_RegisterShaderNoMip( "gfx/hud/mpi_rflag_x" );
ADDRGP4 $1877
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 3748
;3748:			theirFlagShader = trap_R_RegisterShaderNoMip( "gfx/hud/mpi_bflag_ys" );
ADDRGP4 $1073
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 3749
;3749:		}
ADDRGP4 $1873
JUMPV
LABELV $1875
line 3751
;3750:		else
;3751:		{
line 3752
;3752:			myFlagTakenShader = trap_R_RegisterShaderNoMip( "gfx/hud/mpi_bflag_x" );
ADDRGP4 $1878
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 3753
;3753:			theirFlagShader = trap_R_RegisterShaderNoMip( "gfx/hud/mpi_rflag_ys" );
ADDRGP4 $1072
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 3754
;3754:		}
line 3755
;3755:	}
ADDRGP4 $1873
JUMPV
LABELV $1872
line 3757
;3756:	else
;3757:	{
line 3758
;3758:		if (team == TEAM_RED)
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $1879
line 3759
;3759:		{
line 3760
;3760:			myFlagTakenShader = trap_R_RegisterShaderNoMip( "gfx/hud/mpi_rflag_x" );
ADDRGP4 $1877
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 3761
;3761:			theirFlagShader = trap_R_RegisterShaderNoMip( "gfx/hud/mpi_bflag" );
ADDRGP4 $1881
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 3762
;3762:		}
ADDRGP4 $1880
JUMPV
LABELV $1879
line 3764
;3763:		else
;3764:		{
line 3765
;3765:			myFlagTakenShader = trap_R_RegisterShaderNoMip( "gfx/hud/mpi_bflag_x" );
ADDRGP4 $1878
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 3766
;3766:			theirFlagShader = trap_R_RegisterShaderNoMip( "gfx/hud/mpi_rflag" );
ADDRGP4 $1882
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 3767
;3767:		}
LABELV $1880
line 3768
;3768:	}
LABELV $1873
line 3770
;3769:
;3770:	if (CG_YourTeamHasFlag())
ADDRLP4 20
ADDRGP4 CG_YourTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1883
line 3771
;3771:	{
line 3772
;3772:		CG_DrawPic( startDrawPos, 365, ico_size, ico_size, theirFlagShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1136033792
ARGF4
ADDRLP4 24
ADDRLP4 0
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 3773
;3773:		startDrawPos += ico_size+2;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 3774
;3774:	}
LABELV $1883
line 3776
;3775:
;3776:	if (CG_OtherTeamHasFlag())
ADDRLP4 24
ADDRGP4 CG_OtherTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1885
line 3777
;3777:	{
line 3778
;3778:		CG_DrawPic( startDrawPos, 365, ico_size, ico_size, myFlagTakenShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1136033792
ARGF4
ADDRLP4 28
ADDRLP4 0
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 3779
;3779:	}
LABELV $1885
line 3780
;3780:}
LABELV $1863
endproc CG_DrawFlagStatus 32 20
data
export cgRageTime
align 4
LABELV cgRageTime
byte 4 0
export cgRageFadeTime
align 4
LABELV cgRageFadeTime
byte 4 0
export cgRageFadeVal
align 4
LABELV cgRageFadeVal
byte 4 0
export cgRageRecTime
align 4
LABELV cgRageRecTime
byte 4 0
export cgRageRecFadeTime
align 4
LABELV cgRageRecFadeTime
byte 4 0
export cgRageRecFadeVal
align 4
LABELV cgRageRecFadeVal
byte 4 0
export cgAbsorbTime
align 4
LABELV cgAbsorbTime
byte 4 0
export cgAbsorbFadeTime
align 4
LABELV cgAbsorbFadeTime
byte 4 0
export cgAbsorbFadeVal
align 4
LABELV cgAbsorbFadeVal
byte 4 0
export cgProtectTime
align 4
LABELV cgProtectTime
byte 4 0
export cgProtectFadeTime
align 4
LABELV cgProtectFadeTime
byte 4 0
export cgProtectFadeVal
align 4
LABELV cgProtectFadeVal
byte 4 0
export cgYsalTime
align 4
LABELV cgYsalTime
byte 4 0
export cgYsalFadeTime
align 4
LABELV cgYsalFadeTime
byte 4 0
export cgYsalFadeVal
align 4
LABELV cgYsalFadeVal
byte 4 0
export gCGHasFallVector
align 4
LABELV gCGHasFallVector
byte 4 0
code
proc CG_Draw2D 68 24
line 3810
;3781:
;3782:int cgRageTime = 0;
;3783:int cgRageFadeTime = 0;
;3784:float cgRageFadeVal = 0;
;3785:
;3786:int cgRageRecTime = 0;
;3787:int cgRageRecFadeTime = 0;
;3788:float cgRageRecFadeVal = 0;
;3789:
;3790:int cgAbsorbTime = 0;
;3791:int cgAbsorbFadeTime = 0;
;3792:float cgAbsorbFadeVal = 0;
;3793:
;3794:int cgProtectTime = 0;
;3795:int cgProtectFadeTime = 0;
;3796:float cgProtectFadeVal = 0;
;3797:
;3798:int cgYsalTime = 0;
;3799:int cgYsalFadeTime = 0;
;3800:float cgYsalFadeVal = 0;
;3801:
;3802:qboolean gCGHasFallVector = qfalse;
;3803:vec3_t gCGFallVector;
;3804:
;3805:/*
;3806:=================
;3807:CG_Draw2D
;3808:=================
;3809:*/
;3810:static void CG_Draw2D( void ) {
line 3811
;3811:	float			inTime = cg.invenSelectTime+WEAPON_SELECT_TIME;
ADDRLP4 40
ADDRGP4 cg+13776
INDIRF4
CNSTF4 1152319488
ADDF4
ASGNF4
line 3812
;3812:	float			wpTime = cg.weaponSelectTime+WEAPON_SELECT_TIME;
ADDRLP4 44
ADDRGP4 cg+13360
INDIRI4
CNSTI4 1400
ADDI4
CVIF4 4
ASGNF4
line 3814
;3813:	float			bestTime;
;3814:	int				drawSelect = 0;
ADDRLP4 36
CNSTI4 0
ASGNI4
line 3818
;3815:	float			fallTime, rageTime, rageRecTime, absorbTime, protectTime, ysalTime;
;3816:	vec4_t			hcolor;
;3817:
;3818:	if (cgs.orderPending && cg.time > cgs.orderTime) {
ADDRGP4 cgs+70224
INDIRI4
CNSTI4 0
EQI4 $1890
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgs+70228
INDIRI4
LEI4 $1890
line 3819
;3819:		CG_CheckOrderPending();
ADDRGP4 CG_CheckOrderPending
CALLV
pop
line 3820
;3820:	}
LABELV $1890
line 3822
;3821:	// if we are taking a levelshot for the menu, don't draw anything
;3822:	if ( cg.levelShot ) {
ADDRGP4 cg+12
INDIRI4
CNSTI4 0
EQI4 $1895
line 3823
;3823:		return;
ADDRGP4 $1887
JUMPV
LABELV $1895
line 3826
;3824:	}
;3825:
;3826:	if (cgs.clientinfo[cg.snap->ps.clientNum].team == TEAM_SPECTATOR)
CNSTI4 788
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1898
line 3827
;3827:	{
line 3828
;3828:		cgRageTime = 0;
ADDRGP4 cgRageTime
CNSTI4 0
ASGNI4
line 3829
;3829:		cgRageFadeTime = 0;
ADDRGP4 cgRageFadeTime
CNSTI4 0
ASGNI4
line 3830
;3830:		cgRageFadeVal = 0;
ADDRGP4 cgRageFadeVal
CNSTF4 0
ASGNF4
line 3832
;3831:
;3832:		cgRageRecTime = 0;
ADDRGP4 cgRageRecTime
CNSTI4 0
ASGNI4
line 3833
;3833:		cgRageRecFadeTime = 0;
ADDRGP4 cgRageRecFadeTime
CNSTI4 0
ASGNI4
line 3834
;3834:		cgRageRecFadeVal = 0;
ADDRGP4 cgRageRecFadeVal
CNSTF4 0
ASGNF4
line 3836
;3835:
;3836:		cgAbsorbTime = 0;
ADDRGP4 cgAbsorbTime
CNSTI4 0
ASGNI4
line 3837
;3837:		cgAbsorbFadeTime = 0;
ADDRGP4 cgAbsorbFadeTime
CNSTI4 0
ASGNI4
line 3838
;3838:		cgAbsorbFadeVal = 0;
ADDRGP4 cgAbsorbFadeVal
CNSTF4 0
ASGNF4
line 3840
;3839:
;3840:		cgProtectTime = 0;
ADDRGP4 cgProtectTime
CNSTI4 0
ASGNI4
line 3841
;3841:		cgProtectFadeTime = 0;
ADDRGP4 cgProtectFadeTime
CNSTI4 0
ASGNI4
line 3842
;3842:		cgProtectFadeVal = 0;
ADDRGP4 cgProtectFadeVal
CNSTF4 0
ASGNF4
line 3844
;3843:
;3844:		cgYsalTime = 0;
ADDRGP4 cgYsalTime
CNSTI4 0
ASGNI4
line 3845
;3845:		cgYsalFadeTime = 0;
ADDRGP4 cgYsalFadeTime
CNSTI4 0
ASGNI4
line 3846
;3846:		cgYsalFadeVal = 0;
ADDRGP4 cgYsalFadeVal
CNSTF4 0
ASGNF4
line 3847
;3847:	}
LABELV $1898
line 3849
;3848:
;3849:	if ( cg_draw2D.integer == 0 ) {
ADDRGP4 cg_draw2D+12
INDIRI4
CNSTI4 0
NEI4 $1903
line 3850
;3850:		return;
ADDRGP4 $1887
JUMPV
LABELV $1903
line 3853
;3851:	}
;3852:
;3853:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 6
NEI4 $1906
line 3854
;3854:		CG_DrawIntermission();
ADDRGP4 CG_DrawIntermission
CALLV
pop
line 3855
;3855:		return;
ADDRGP4 $1887
JUMPV
LABELV $1906
line 3858
;3856:	}
;3857:
;3858:	if (cgs.clientinfo[cg.snap->ps.clientNum].team != TEAM_SPECTATOR)
CNSTI4 788
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+43008+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1909
line 3859
;3859:	{
line 3860
;3860:		if (cg.snap->ps.fd.forcePowersActive & (1 << FP_RAGE))
ADDRGP4 cg+36
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1914
line 3861
;3861:		{
line 3862
;3862:			if (!cgRageTime)
ADDRGP4 cgRageTime
INDIRI4
CNSTI4 0
NEI4 $1917
line 3863
;3863:			{
line 3864
;3864:				cgRageTime = cg.time;
ADDRGP4 cgRageTime
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3865
;3865:			}
LABELV $1917
line 3867
;3866:			
;3867:			rageTime = (float)(cg.time - cgRageTime);
ADDRLP4 20
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgRageTime
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 3869
;3868:			
;3869:			rageTime /= 9000;
ADDRLP4 20
ADDRLP4 20
INDIRF4
CNSTF4 1175232512
DIVF4
ASGNF4
line 3871
;3870:			
;3871:			if (rageTime < 0)
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $1921
line 3872
;3872:			{
line 3873
;3873:				rageTime = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 3874
;3874:			}
LABELV $1921
line 3875
;3875:			if (rageTime > 0.15)
ADDRLP4 20
INDIRF4
CNSTF4 1041865114
LEF4 $1923
line 3876
;3876:			{
line 3877
;3877:				rageTime = 0.15;
ADDRLP4 20
CNSTF4 1041865114
ASGNF4
line 3878
;3878:			}
LABELV $1923
line 3880
;3879:			
;3880:			hcolor[3] = rageTime;
ADDRLP4 0+12
ADDRLP4 20
INDIRF4
ASGNF4
line 3881
;3881:			hcolor[0] = 0.7;
ADDRLP4 0
CNSTF4 1060320051
ASGNF4
line 3882
;3882:			hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 3883
;3883:			hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 3885
;3884:			
;3885:			if (!cg.renderingThirdPerson)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $1928
line 3886
;3886:			{
line 3887
;3887:				CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 3888
;3888:			}
LABELV $1928
line 3890
;3889:			
;3890:			cgRageFadeTime = 0;
ADDRGP4 cgRageFadeTime
CNSTI4 0
ASGNI4
line 3891
;3891:			cgRageFadeVal = 0;
ADDRGP4 cgRageFadeVal
CNSTF4 0
ASGNF4
line 3892
;3892:		}
ADDRGP4 $1915
JUMPV
LABELV $1914
line 3893
;3893:		else if (cgRageTime)
ADDRGP4 cgRageTime
INDIRI4
CNSTI4 0
EQI4 $1931
line 3894
;3894:		{
line 3895
;3895:			if (!cgRageFadeTime)
ADDRGP4 cgRageFadeTime
INDIRI4
CNSTI4 0
NEI4 $1933
line 3896
;3896:			{
line 3897
;3897:				cgRageFadeTime = cg.time;
ADDRGP4 cgRageFadeTime
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3898
;3898:				cgRageFadeVal = 0.15;
ADDRGP4 cgRageFadeVal
CNSTF4 1041865114
ASGNF4
line 3899
;3899:			}
LABELV $1933
line 3901
;3900:			
;3901:			rageTime = cgRageFadeVal;
ADDRLP4 20
ADDRGP4 cgRageFadeVal
INDIRF4
ASGNF4
line 3903
;3902:			
;3903:			cgRageFadeVal -= (cg.time - cgRageFadeTime)*0.000005;
ADDRLP4 56
ADDRGP4 cgRageFadeVal
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 916964780
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgRageFadeTime
INDIRI4
SUBI4
CVIF4 4
MULF4
SUBF4
ASGNF4
line 3905
;3904:			
;3905:			if (rageTime < 0)
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $1937
line 3906
;3906:			{
line 3907
;3907:				rageTime = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 3908
;3908:			}
LABELV $1937
line 3909
;3909:			if (rageTime > 0.15)
ADDRLP4 20
INDIRF4
CNSTF4 1041865114
LEF4 $1939
line 3910
;3910:			{
line 3911
;3911:				rageTime = 0.15;
ADDRLP4 20
CNSTF4 1041865114
ASGNF4
line 3912
;3912:			}
LABELV $1939
line 3914
;3913:			
;3914:			if (cg.snap->ps.fd.forceRageRecoveryTime > cg.time)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1204
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $1941
line 3915
;3915:			{
line 3916
;3916:				float checkRageRecTime = rageTime;
ADDRLP4 60
ADDRLP4 20
INDIRF4
ASGNF4
line 3918
;3917:				
;3918:				if (checkRageRecTime < 0.15)
ADDRLP4 60
INDIRF4
CNSTF4 1041865114
GEF4 $1945
line 3919
;3919:				{
line 3920
;3920:					checkRageRecTime = 0.15;
ADDRLP4 60
CNSTF4 1041865114
ASGNF4
line 3921
;3921:				}
LABELV $1945
line 3923
;3922:				
;3923:				hcolor[3] = checkRageRecTime;
ADDRLP4 0+12
ADDRLP4 60
INDIRF4
ASGNF4
line 3924
;3924:				hcolor[0] = rageTime*4;
ADDRLP4 0
CNSTF4 1082130432
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 3925
;3925:				if (hcolor[0] < 0.2)
ADDRLP4 0
INDIRF4
CNSTF4 1045220557
GEF4 $1948
line 3926
;3926:				{
line 3927
;3927:					hcolor[0] = 0.2;
ADDRLP4 0
CNSTF4 1045220557
ASGNF4
line 3928
;3928:				}
LABELV $1948
line 3929
;3929:				hcolor[1] = 0.2;
ADDRLP4 0+4
CNSTF4 1045220557
ASGNF4
line 3930
;3930:				hcolor[2] = 0.2;
ADDRLP4 0+8
CNSTF4 1045220557
ASGNF4
line 3931
;3931:			}
ADDRGP4 $1942
JUMPV
LABELV $1941
line 3933
;3932:			else
;3933:			{
line 3934
;3934:				hcolor[3] = rageTime;
ADDRLP4 0+12
ADDRLP4 20
INDIRF4
ASGNF4
line 3935
;3935:				hcolor[0] = 0.7;
ADDRLP4 0
CNSTF4 1060320051
ASGNF4
line 3936
;3936:				hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 3937
;3937:				hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 3938
;3938:			}
LABELV $1942
line 3940
;3939:			
;3940:			if (!cg.renderingThirdPerson && rageTime)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $1955
ADDRLP4 20
INDIRF4
CNSTF4 0
EQF4 $1955
line 3941
;3941:			{
line 3942
;3942:				CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 3943
;3943:			}
ADDRGP4 $1932
JUMPV
LABELV $1955
line 3945
;3944:			else
;3945:			{
line 3946
;3946:				if (cg.snap->ps.fd.forceRageRecoveryTime > cg.time)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1204
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $1958
line 3947
;3947:				{
line 3948
;3948:					hcolor[3] = 0.15;
ADDRLP4 0+12
CNSTF4 1041865114
ASGNF4
line 3949
;3949:					hcolor[0] = 0.2;
ADDRLP4 0
CNSTF4 1045220557
ASGNF4
line 3950
;3950:					hcolor[1] = 0.2;
ADDRLP4 0+4
CNSTF4 1045220557
ASGNF4
line 3951
;3951:					hcolor[2] = 0.2;
ADDRLP4 0+8
CNSTF4 1045220557
ASGNF4
line 3952
;3952:					CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 3953
;3953:				}
LABELV $1958
line 3954
;3954:				cgRageTime = 0;
ADDRGP4 cgRageTime
CNSTI4 0
ASGNI4
line 3955
;3955:			}
line 3956
;3956:		}
ADDRGP4 $1932
JUMPV
LABELV $1931
line 3957
;3957:		else if (cg.snap->ps.fd.forceRageRecoveryTime > cg.time)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1204
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $1965
line 3958
;3958:		{
line 3959
;3959:			if (!cgRageRecTime)
ADDRGP4 cgRageRecTime
INDIRI4
CNSTI4 0
NEI4 $1969
line 3960
;3960:			{
line 3961
;3961:				cgRageRecTime = cg.time;
ADDRGP4 cgRageRecTime
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3962
;3962:			}
LABELV $1969
line 3964
;3963:			
;3964:			rageRecTime = (float)(cg.time - cgRageRecTime);
ADDRLP4 48
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgRageRecTime
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 3966
;3965:			
;3966:			rageRecTime /= 9000;
ADDRLP4 48
ADDRLP4 48
INDIRF4
CNSTF4 1175232512
DIVF4
ASGNF4
line 3968
;3967:			
;3968:			if (rageRecTime < 0.15)//0)
ADDRLP4 48
INDIRF4
CNSTF4 1041865114
GEF4 $1973
line 3969
;3969:			{
line 3970
;3970:				rageRecTime = 0.15;//0;
ADDRLP4 48
CNSTF4 1041865114
ASGNF4
line 3971
;3971:			}
LABELV $1973
line 3972
;3972:			if (rageRecTime > 0.15)
ADDRLP4 48
INDIRF4
CNSTF4 1041865114
LEF4 $1975
line 3973
;3973:			{
line 3974
;3974:				rageRecTime = 0.15;
ADDRLP4 48
CNSTF4 1041865114
ASGNF4
line 3975
;3975:			}
LABELV $1975
line 3977
;3976:			
;3977:			hcolor[3] = rageRecTime;
ADDRLP4 0+12
ADDRLP4 48
INDIRF4
ASGNF4
line 3978
;3978:			hcolor[0] = 0.2;
ADDRLP4 0
CNSTF4 1045220557
ASGNF4
line 3979
;3979:			hcolor[1] = 0.2;
ADDRLP4 0+4
CNSTF4 1045220557
ASGNF4
line 3980
;3980:			hcolor[2] = 0.2;
ADDRLP4 0+8
CNSTF4 1045220557
ASGNF4
line 3982
;3981:			
;3982:			if (!cg.renderingThirdPerson)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $1980
line 3983
;3983:			{
line 3984
;3984:				CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 3985
;3985:			}
LABELV $1980
line 3987
;3986:			
;3987:			cgRageRecFadeTime = 0;
ADDRGP4 cgRageRecFadeTime
CNSTI4 0
ASGNI4
line 3988
;3988:			cgRageRecFadeVal = 0;
ADDRGP4 cgRageRecFadeVal
CNSTF4 0
ASGNF4
line 3989
;3989:		}
ADDRGP4 $1966
JUMPV
LABELV $1965
line 3990
;3990:		else if (cgRageRecTime)
ADDRGP4 cgRageRecTime
INDIRI4
CNSTI4 0
EQI4 $1983
line 3991
;3991:		{
line 3992
;3992:			if (!cgRageRecFadeTime)
ADDRGP4 cgRageRecFadeTime
INDIRI4
CNSTI4 0
NEI4 $1985
line 3993
;3993:			{
line 3994
;3994:				cgRageRecFadeTime = cg.time;
ADDRGP4 cgRageRecFadeTime
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 3995
;3995:				cgRageRecFadeVal = 0.15;
ADDRGP4 cgRageRecFadeVal
CNSTF4 1041865114
ASGNF4
line 3996
;3996:			}
LABELV $1985
line 3998
;3997:			
;3998:			rageRecTime = cgRageRecFadeVal;
ADDRLP4 48
ADDRGP4 cgRageRecFadeVal
INDIRF4
ASGNF4
line 4000
;3999:			
;4000:			cgRageRecFadeVal -= (cg.time - cgRageRecFadeTime)*0.000005;
ADDRLP4 56
ADDRGP4 cgRageRecFadeVal
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 916964780
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgRageRecFadeTime
INDIRI4
SUBI4
CVIF4 4
MULF4
SUBF4
ASGNF4
line 4002
;4001:			
;4002:			if (rageRecTime < 0)
ADDRLP4 48
INDIRF4
CNSTF4 0
GEF4 $1989
line 4003
;4003:			{
line 4004
;4004:				rageRecTime = 0;
ADDRLP4 48
CNSTF4 0
ASGNF4
line 4005
;4005:			}
LABELV $1989
line 4006
;4006:			if (rageRecTime > 0.15)
ADDRLP4 48
INDIRF4
CNSTF4 1041865114
LEF4 $1991
line 4007
;4007:			{
line 4008
;4008:				rageRecTime = 0.15;
ADDRLP4 48
CNSTF4 1041865114
ASGNF4
line 4009
;4009:			}
LABELV $1991
line 4011
;4010:			
;4011:			hcolor[3] = rageRecTime;
ADDRLP4 0+12
ADDRLP4 48
INDIRF4
ASGNF4
line 4012
;4012:			hcolor[0] = 0.2;
ADDRLP4 0
CNSTF4 1045220557
ASGNF4
line 4013
;4013:			hcolor[1] = 0.2;
ADDRLP4 0+4
CNSTF4 1045220557
ASGNF4
line 4014
;4014:			hcolor[2] = 0.2;
ADDRLP4 0+8
CNSTF4 1045220557
ASGNF4
line 4016
;4015:			
;4016:			if (!cg.renderingThirdPerson && rageRecTime)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $1996
ADDRLP4 48
INDIRF4
CNSTF4 0
EQF4 $1996
line 4017
;4017:			{
line 4018
;4018:				CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 4019
;4019:			}
ADDRGP4 $1997
JUMPV
LABELV $1996
line 4021
;4020:			else
;4021:			{
line 4022
;4022:				cgRageRecTime = 0;
ADDRGP4 cgRageRecTime
CNSTI4 0
ASGNI4
line 4023
;4023:			}
LABELV $1997
line 4024
;4024:		}
LABELV $1983
LABELV $1966
LABELV $1932
LABELV $1915
line 4026
;4025:		
;4026:		if (cg.snap->ps.fd.forcePowersActive & (1 << FP_ABSORB))
ADDRGP4 cg+36
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1999
line 4027
;4027:		{
line 4028
;4028:			if (!cgAbsorbTime)
ADDRGP4 cgAbsorbTime
INDIRI4
CNSTI4 0
NEI4 $2002
line 4029
;4029:			{
line 4030
;4030:				cgAbsorbTime = cg.time;
ADDRGP4 cgAbsorbTime
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4031
;4031:			}
LABELV $2002
line 4033
;4032:			
;4033:			absorbTime = (float)(cg.time - cgAbsorbTime);
ADDRLP4 24
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgAbsorbTime
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 4035
;4034:			
;4035:			absorbTime /= 9000;
ADDRLP4 24
ADDRLP4 24
INDIRF4
CNSTF4 1175232512
DIVF4
ASGNF4
line 4037
;4036:			
;4037:			if (absorbTime < 0)
ADDRLP4 24
INDIRF4
CNSTF4 0
GEF4 $2006
line 4038
;4038:			{
line 4039
;4039:				absorbTime = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 4040
;4040:			}
LABELV $2006
line 4041
;4041:			if (absorbTime > 0.15)
ADDRLP4 24
INDIRF4
CNSTF4 1041865114
LEF4 $2008
line 4042
;4042:			{
line 4043
;4043:				absorbTime = 0.15;
ADDRLP4 24
CNSTF4 1041865114
ASGNF4
line 4044
;4044:			}
LABELV $2008
line 4046
;4045:			
;4046:			hcolor[3] = absorbTime/2;
ADDRLP4 0+12
ADDRLP4 24
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4047
;4047:			hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4048
;4048:			hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 4049
;4049:			hcolor[2] = 0.7;
ADDRLP4 0+8
CNSTF4 1060320051
ASGNF4
line 4051
;4050:			
;4051:			if (!cg.renderingThirdPerson)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $2013
line 4052
;4052:			{
line 4053
;4053:				CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 4054
;4054:			}
LABELV $2013
line 4056
;4055:			
;4056:			cgAbsorbFadeTime = 0;
ADDRGP4 cgAbsorbFadeTime
CNSTI4 0
ASGNI4
line 4057
;4057:			cgAbsorbFadeVal = 0;
ADDRGP4 cgAbsorbFadeVal
CNSTF4 0
ASGNF4
line 4058
;4058:		}
ADDRGP4 $2000
JUMPV
LABELV $1999
line 4059
;4059:		else if (cgAbsorbTime)
ADDRGP4 cgAbsorbTime
INDIRI4
CNSTI4 0
EQI4 $2016
line 4060
;4060:		{
line 4061
;4061:			if (!cgAbsorbFadeTime)
ADDRGP4 cgAbsorbFadeTime
INDIRI4
CNSTI4 0
NEI4 $2018
line 4062
;4062:			{
line 4063
;4063:				cgAbsorbFadeTime = cg.time;
ADDRGP4 cgAbsorbFadeTime
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4064
;4064:				cgAbsorbFadeVal = 0.15;
ADDRGP4 cgAbsorbFadeVal
CNSTF4 1041865114
ASGNF4
line 4065
;4065:			}
LABELV $2018
line 4067
;4066:			
;4067:			absorbTime = cgAbsorbFadeVal;
ADDRLP4 24
ADDRGP4 cgAbsorbFadeVal
INDIRF4
ASGNF4
line 4069
;4068:			
;4069:			cgAbsorbFadeVal -= (cg.time - cgAbsorbFadeTime)*0.000005;
ADDRLP4 56
ADDRGP4 cgAbsorbFadeVal
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 916964780
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgAbsorbFadeTime
INDIRI4
SUBI4
CVIF4 4
MULF4
SUBF4
ASGNF4
line 4071
;4070:			
;4071:			if (absorbTime < 0)
ADDRLP4 24
INDIRF4
CNSTF4 0
GEF4 $2022
line 4072
;4072:			{
line 4073
;4073:				absorbTime = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 4074
;4074:			}
LABELV $2022
line 4075
;4075:			if (absorbTime > 0.15)
ADDRLP4 24
INDIRF4
CNSTF4 1041865114
LEF4 $2024
line 4076
;4076:			{
line 4077
;4077:				absorbTime = 0.15;
ADDRLP4 24
CNSTF4 1041865114
ASGNF4
line 4078
;4078:			}
LABELV $2024
line 4080
;4079:			
;4080:			hcolor[3] = absorbTime/2;
ADDRLP4 0+12
ADDRLP4 24
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4081
;4081:			hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4082
;4082:			hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 4083
;4083:			hcolor[2] = 0.7;
ADDRLP4 0+8
CNSTF4 1060320051
ASGNF4
line 4085
;4084:			
;4085:			if (!cg.renderingThirdPerson && absorbTime)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $2029
ADDRLP4 24
INDIRF4
CNSTF4 0
EQF4 $2029
line 4086
;4086:			{
line 4087
;4087:				CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 4088
;4088:			}
ADDRGP4 $2030
JUMPV
LABELV $2029
line 4090
;4089:			else
;4090:			{
line 4091
;4091:				cgAbsorbTime = 0;
ADDRGP4 cgAbsorbTime
CNSTI4 0
ASGNI4
line 4092
;4092:			}
LABELV $2030
line 4093
;4093:		}
LABELV $2016
LABELV $2000
line 4095
;4094:		
;4095:		if (cg.snap->ps.fd.forcePowersActive & (1 << FP_PROTECT))
ADDRGP4 cg+36
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $2032
line 4096
;4096:		{
line 4097
;4097:			if (!cgProtectTime)
ADDRGP4 cgProtectTime
INDIRI4
CNSTI4 0
NEI4 $2035
line 4098
;4098:			{
line 4099
;4099:				cgProtectTime = cg.time;
ADDRGP4 cgProtectTime
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4100
;4100:			}
LABELV $2035
line 4102
;4101:			
;4102:			protectTime = (float)(cg.time - cgProtectTime);
ADDRLP4 28
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgProtectTime
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 4104
;4103:			
;4104:			protectTime /= 9000;
ADDRLP4 28
ADDRLP4 28
INDIRF4
CNSTF4 1175232512
DIVF4
ASGNF4
line 4106
;4105:			
;4106:			if (protectTime < 0)
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $2039
line 4107
;4107:			{
line 4108
;4108:				protectTime = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
line 4109
;4109:			}
LABELV $2039
line 4110
;4110:			if (protectTime > 0.15)
ADDRLP4 28
INDIRF4
CNSTF4 1041865114
LEF4 $2041
line 4111
;4111:			{
line 4112
;4112:				protectTime = 0.15;
ADDRLP4 28
CNSTF4 1041865114
ASGNF4
line 4113
;4113:			}
LABELV $2041
line 4115
;4114:			
;4115:			hcolor[3] = protectTime/2;
ADDRLP4 0+12
ADDRLP4 28
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4116
;4116:			hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4117
;4117:			hcolor[1] = 0.7;
ADDRLP4 0+4
CNSTF4 1060320051
ASGNF4
line 4118
;4118:			hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4120
;4119:			
;4120:			if (!cg.renderingThirdPerson)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $2046
line 4121
;4121:			{
line 4122
;4122:				CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 4123
;4123:			}
LABELV $2046
line 4125
;4124:			
;4125:			cgProtectFadeTime = 0;
ADDRGP4 cgProtectFadeTime
CNSTI4 0
ASGNI4
line 4126
;4126:			cgProtectFadeVal = 0;
ADDRGP4 cgProtectFadeVal
CNSTF4 0
ASGNF4
line 4127
;4127:		}
ADDRGP4 $2033
JUMPV
LABELV $2032
line 4128
;4128:		else if (cgProtectTime)
ADDRGP4 cgProtectTime
INDIRI4
CNSTI4 0
EQI4 $2049
line 4129
;4129:		{
line 4130
;4130:			if (!cgProtectFadeTime)
ADDRGP4 cgProtectFadeTime
INDIRI4
CNSTI4 0
NEI4 $2051
line 4131
;4131:			{
line 4132
;4132:				cgProtectFadeTime = cg.time;
ADDRGP4 cgProtectFadeTime
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4133
;4133:				cgProtectFadeVal = 0.15;
ADDRGP4 cgProtectFadeVal
CNSTF4 1041865114
ASGNF4
line 4134
;4134:			}
LABELV $2051
line 4136
;4135:			
;4136:			protectTime = cgProtectFadeVal;
ADDRLP4 28
ADDRGP4 cgProtectFadeVal
INDIRF4
ASGNF4
line 4138
;4137:			
;4138:			cgProtectFadeVal -= (cg.time - cgProtectFadeTime)*0.000005;
ADDRLP4 56
ADDRGP4 cgProtectFadeVal
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 916964780
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgProtectFadeTime
INDIRI4
SUBI4
CVIF4 4
MULF4
SUBF4
ASGNF4
line 4140
;4139:			
;4140:			if (protectTime < 0)
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $2055
line 4141
;4141:			{
line 4142
;4142:				protectTime = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
line 4143
;4143:			}
LABELV $2055
line 4144
;4144:			if (protectTime > 0.15)
ADDRLP4 28
INDIRF4
CNSTF4 1041865114
LEF4 $2057
line 4145
;4145:			{
line 4146
;4146:				protectTime = 0.15;
ADDRLP4 28
CNSTF4 1041865114
ASGNF4
line 4147
;4147:			}
LABELV $2057
line 4149
;4148:			
;4149:			hcolor[3] = protectTime/2;
ADDRLP4 0+12
ADDRLP4 28
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4150
;4150:			hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4151
;4151:			hcolor[1] = 0.7;
ADDRLP4 0+4
CNSTF4 1060320051
ASGNF4
line 4152
;4152:			hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4154
;4153:			
;4154:			if (!cg.renderingThirdPerson && protectTime)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $2062
ADDRLP4 28
INDIRF4
CNSTF4 0
EQF4 $2062
line 4155
;4155:			{
line 4156
;4156:				CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 4157
;4157:			}
ADDRGP4 $2063
JUMPV
LABELV $2062
line 4159
;4158:			else
;4159:			{
line 4160
;4160:				cgProtectTime = 0;
ADDRGP4 cgProtectTime
CNSTI4 0
ASGNI4
line 4161
;4161:			}
LABELV $2063
line 4162
;4162:		}
LABELV $2049
LABELV $2033
line 4164
;4163:		
;4164:		if (cg.snap->ps.rocketLockIndex != MAX_CLIENTS && (cg.time - cg.snap->ps.rocketLockTime) > 0)
ADDRGP4 cg+36
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 32
EQI4 $2065
ADDRGP4 cg+64
INDIRI4
CVIF4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
SUBF4
CNSTF4 0
LEF4 $2065
line 4165
;4165:		{
line 4166
;4166:			CG_DrawRocketLocking( cg.snap->ps.rocketLockIndex, cg.snap->ps.rocketLockTime );
ADDRGP4 cg+36
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawRocketLocking
CALLV
pop
line 4167
;4167:		}
LABELV $2065
line 4169
;4168:		
;4169:		if (BG_HasYsalamiri(cgs.gametype, &cg.snap->ps))
ADDRGP4 cgs+32960
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 BG_HasYsalamiri
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $2072
line 4170
;4170:		{
line 4171
;4171:			if (!cgYsalTime)
ADDRGP4 cgYsalTime
INDIRI4
CNSTI4 0
NEI4 $2076
line 4172
;4172:			{
line 4173
;4173:				cgYsalTime = cg.time;
ADDRGP4 cgYsalTime
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4174
;4174:			}
LABELV $2076
line 4176
;4175:			
;4176:			ysalTime = (float)(cg.time - cgYsalTime);
ADDRLP4 32
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgYsalTime
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 4178
;4177:			
;4178:			ysalTime /= 9000;
ADDRLP4 32
ADDRLP4 32
INDIRF4
CNSTF4 1175232512
DIVF4
ASGNF4
line 4180
;4179:			
;4180:			if (ysalTime < 0)
ADDRLP4 32
INDIRF4
CNSTF4 0
GEF4 $2080
line 4181
;4181:			{
line 4182
;4182:				ysalTime = 0;
ADDRLP4 32
CNSTF4 0
ASGNF4
line 4183
;4183:			}
LABELV $2080
line 4184
;4184:			if (ysalTime > 0.15)
ADDRLP4 32
INDIRF4
CNSTF4 1041865114
LEF4 $2082
line 4185
;4185:			{
line 4186
;4186:				ysalTime = 0.15;
ADDRLP4 32
CNSTF4 1041865114
ASGNF4
line 4187
;4187:			}
LABELV $2082
line 4189
;4188:			
;4189:			hcolor[3] = ysalTime/2;
ADDRLP4 0+12
ADDRLP4 32
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4190
;4190:			hcolor[0] = 0.7;
ADDRLP4 0
CNSTF4 1060320051
ASGNF4
line 4191
;4191:			hcolor[1] = 0.7;
ADDRLP4 0+4
CNSTF4 1060320051
ASGNF4
line 4192
;4192:			hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4194
;4193:			
;4194:			if (!cg.renderingThirdPerson)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $2087
line 4195
;4195:			{
line 4196
;4196:				CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 4197
;4197:			}
LABELV $2087
line 4199
;4198:			
;4199:			cgYsalFadeTime = 0;
ADDRGP4 cgYsalFadeTime
CNSTI4 0
ASGNI4
line 4200
;4200:			cgYsalFadeVal = 0;
ADDRGP4 cgYsalFadeVal
CNSTF4 0
ASGNF4
line 4201
;4201:		}
ADDRGP4 $2073
JUMPV
LABELV $2072
line 4202
;4202:		else if (cgYsalTime)
ADDRGP4 cgYsalTime
INDIRI4
CNSTI4 0
EQI4 $2090
line 4203
;4203:		{
line 4204
;4204:			if (!cgYsalFadeTime)
ADDRGP4 cgYsalFadeTime
INDIRI4
CNSTI4 0
NEI4 $2092
line 4205
;4205:			{
line 4206
;4206:				cgYsalFadeTime = cg.time;
ADDRGP4 cgYsalFadeTime
ADDRGP4 cg+64
INDIRI4
ASGNI4
line 4207
;4207:				cgYsalFadeVal = 0.15;
ADDRGP4 cgYsalFadeVal
CNSTF4 1041865114
ASGNF4
line 4208
;4208:			}
LABELV $2092
line 4210
;4209:			
;4210:			ysalTime = cgYsalFadeVal;
ADDRLP4 32
ADDRGP4 cgYsalFadeVal
INDIRF4
ASGNF4
line 4212
;4211:			
;4212:			cgYsalFadeVal -= (cg.time - cgYsalFadeTime)*0.000005;
ADDRLP4 60
ADDRGP4 cgYsalFadeVal
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTF4 916964780
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cgYsalFadeTime
INDIRI4
SUBI4
CVIF4 4
MULF4
SUBF4
ASGNF4
line 4214
;4213:			
;4214:			if (ysalTime < 0)
ADDRLP4 32
INDIRF4
CNSTF4 0
GEF4 $2096
line 4215
;4215:			{
line 4216
;4216:				ysalTime = 0;
ADDRLP4 32
CNSTF4 0
ASGNF4
line 4217
;4217:			}
LABELV $2096
line 4218
;4218:			if (ysalTime > 0.15)
ADDRLP4 32
INDIRF4
CNSTF4 1041865114
LEF4 $2098
line 4219
;4219:			{
line 4220
;4220:				ysalTime = 0.15;
ADDRLP4 32
CNSTF4 1041865114
ASGNF4
line 4221
;4221:			}
LABELV $2098
line 4223
;4222:			
;4223:			hcolor[3] = ysalTime/2;
ADDRLP4 0+12
ADDRLP4 32
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4224
;4224:			hcolor[0] = 0.7;
ADDRLP4 0
CNSTF4 1060320051
ASGNF4
line 4225
;4225:			hcolor[1] = 0.7;
ADDRLP4 0+4
CNSTF4 1060320051
ASGNF4
line 4226
;4226:			hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4228
;4227:			
;4228:			if (!cg.renderingThirdPerson && ysalTime)
ADDRGP4 cg+88
INDIRI4
CNSTI4 0
NEI4 $2103
ADDRLP4 32
INDIRF4
CNSTF4 0
EQF4 $2103
line 4229
;4229:			{
line 4230
;4230:				CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 4231
;4231:			}
ADDRGP4 $2104
JUMPV
LABELV $2103
line 4233
;4232:			else
;4233:			{
line 4234
;4234:				cgYsalTime = 0;
ADDRGP4 cgYsalTime
CNSTI4 0
ASGNI4
line 4235
;4235:			}
LABELV $2104
line 4236
;4236:		}
LABELV $2090
LABELV $2073
line 4237
;4237:	}
LABELV $1909
line 4239
;4238:
;4239:	if (cg.snap->ps.rocketLockIndex != MAX_CLIENTS && (cg.time - cg.snap->ps.rocketLockTime) > 0)
ADDRGP4 cg+36
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 32
EQI4 $2106
ADDRGP4 cg+64
INDIRI4
CVIF4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
SUBF4
CNSTF4 0
LEF4 $2106
line 4240
;4240:	{
line 4241
;4241:		CG_DrawRocketLocking( cg.snap->ps.rocketLockIndex, cg.snap->ps.rocketLockTime );
ADDRGP4 cg+36
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_DrawRocketLocking
CALLV
pop
line 4242
;4242:	}
LABELV $2106
line 4244
;4243:
;4244:	if (cg.snap->ps.holocronBits)
ADDRGP4 cg+36
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2113
line 4245
;4245:	{
line 4246
;4246:		CG_DrawHolocronIcons();
ADDRGP4 CG_DrawHolocronIcons
CALLV
pop
line 4247
;4247:	}
LABELV $2113
line 4248
;4248:	if (cg.snap->ps.fd.forcePowersActive || cg.snap->ps.fd.forceRageRecoveryTime > cg.time)
ADDRGP4 cg+36
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2121
ADDRGP4 cg+36
INDIRP4
CNSTI4 1204
ADDP4
INDIRI4
ADDRGP4 cg+64
INDIRI4
LEI4 $2116
LABELV $2121
line 4249
;4249:	{
line 4250
;4250:		CG_DrawActivePowers();
ADDRGP4 CG_DrawActivePowers
CALLV
pop
line 4251
;4251:	}
LABELV $2116
line 4254
;4252:
;4253:	// Draw this before the text so that any text won't get clipped off
;4254:	CG_DrawZoomMask();
ADDRGP4 CG_DrawZoomMask
CALLV
pop
line 4261
;4255:
;4256:/*
;4257:	if (cg.cameraMode) {
;4258:		return;
;4259:	}
;4260:*/
;4261:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2122
line 4262
;4262:		CG_DrawSpectator();
ADDRGP4 CG_DrawSpectator
CALLV
pop
line 4263
;4263:		CG_DrawCrosshair(NULL, 0);
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 4264
;4264:		CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 4265
;4265:	} else {
ADDRGP4 $2123
JUMPV
LABELV $2122
line 4267
;4266:		// don't draw any status if dead or the scoreboard is being explicitly shown
;4267:		if ( !cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0 ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 cg+6972
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $2125
ADDRGP4 cg+36
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $2125
line 4269
;4268:
;4269:			if ( /*cg_drawStatus.integer*/0 ) {
ADDRGP4 $2129
JUMPV
line 4271
;4270:				//Reenable if stats are drawn with menu system again
;4271:				Menu_PaintAll();
ADDRGP4 Menu_PaintAll
CALLV
pop
line 4272
;4272:				CG_DrawTimedMenus();
ADDRGP4 CG_DrawTimedMenus
CALLV
pop
line 4273
;4273:			}
LABELV $2129
line 4277
;4274:      
;4275:			//CG_DrawTemporaryStats();
;4276:
;4277:			CG_DrawAmmoWarning();
ADDRGP4 CG_DrawAmmoWarning
CALLV
pop
line 4279
;4278:
;4279:			CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 4281
;4280:
;4281:			if (cg_drawStatus.integer)
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
EQI4 $2131
line 4282
;4282:			{
line 4283
;4283:				CG_DrawIconBackground();
ADDRGP4 CG_DrawIconBackground
CALLV
pop
line 4284
;4284:			}
LABELV $2131
line 4286
;4285:
;4286:			if (inTime > wpTime)
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LEF4 $2134
line 4287
;4287:			{
line 4288
;4288:				drawSelect = 1;
ADDRLP4 36
CNSTI4 1
ASGNI4
line 4289
;4289:				bestTime = cg.invenSelectTime;
ADDRLP4 52
ADDRGP4 cg+13776
INDIRF4
ASGNF4
line 4290
;4290:			}
ADDRGP4 $2135
JUMPV
LABELV $2134
line 4292
;4291:			else //only draw the most recent since they're drawn in the same place
;4292:			{
line 4293
;4293:				drawSelect = 2;
ADDRLP4 36
CNSTI4 2
ASGNI4
line 4294
;4294:				bestTime = cg.weaponSelectTime;
ADDRLP4 52
ADDRGP4 cg+13360
INDIRI4
CVIF4 4
ASGNF4
line 4295
;4295:			}
LABELV $2135
line 4297
;4296:
;4297:			if (cg.forceSelectTime > bestTime)
ADDRGP4 cg+13780
INDIRF4
ADDRLP4 52
INDIRF4
LEF4 $2138
line 4298
;4298:			{
line 4299
;4299:				drawSelect = 3;
ADDRLP4 36
CNSTI4 3
ASGNI4
line 4300
;4300:			}
LABELV $2138
line 4302
;4301:
;4302:			switch(drawSelect)
ADDRLP4 60
ADDRLP4 36
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 1
EQI4 $2143
ADDRLP4 60
INDIRI4
CNSTI4 2
EQI4 $2144
ADDRLP4 60
INDIRI4
CNSTI4 3
EQI4 $2145
ADDRGP4 $2142
JUMPV
line 4303
;4303:			{
LABELV $2143
line 4305
;4304:			case 1:
;4305:				CG_DrawInvenSelect();
ADDRGP4 CG_DrawInvenSelect
CALLV
pop
line 4306
;4306:				break;
ADDRGP4 $2142
JUMPV
LABELV $2144
line 4308
;4307:			case 2:
;4308:				CG_DrawWeaponSelect();
ADDRGP4 CG_DrawWeaponSelect
CALLV
pop
line 4309
;4309:				break;
ADDRGP4 $2142
JUMPV
LABELV $2145
line 4311
;4310:			case 3:
;4311:				CG_DrawForceSelect();
ADDRGP4 CG_DrawForceSelect
CALLV
pop
line 4312
;4312:				break;
line 4314
;4313:			default:
;4314:				break;
LABELV $2142
line 4317
;4315:			}
;4316:
;4317:			if (cg_drawStatus.integer)
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
EQI4 $2146
line 4318
;4318:			{
line 4322
;4319:				//Powerups now done with upperright stuff
;4320:				//CG_DrawPowerupIcons();
;4321:
;4322:				CG_DrawFlagStatus();
ADDRGP4 CG_DrawFlagStatus
CALLV
pop
line 4323
;4323:			}
LABELV $2146
line 4325
;4324:
;4325:			CG_SaberClashFlare();
ADDRGP4 CG_SaberClashFlare
CALLV
pop
line 4327
;4326:
;4327:			if (cg_drawStatus.integer)
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
EQI4 $2149
line 4328
;4328:			{
line 4329
;4329:				CG_DrawStats();
ADDRGP4 CG_DrawStats
CALLV
pop
line 4330
;4330:			}
LABELV $2149
line 4334
;4331:
;4332:			//Do we want to use this system again at some point?
;4333:			//CG_DrawReward();
;4334:		}
LABELV $2125
line 4336
;4335:    
;4336:	}
LABELV $2123
line 4338
;4337:
;4338:	if (cg.snap->ps.fallingToDeath)
ADDRGP4 cg+36
INDIRP4
CNSTI4 1384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2152
line 4339
;4339:	{
line 4340
;4340:		fallTime = (float)(cg.time - cg.snap->ps.fallingToDeath);
ADDRLP4 16
ADDRGP4 cg+64
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 1384
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 4342
;4341:
;4342:		fallTime /= (FALL_FADE_TIME/2);
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1153138688
DIVF4
ASGNF4
line 4344
;4343:
;4344:		if (fallTime < 0)
ADDRLP4 16
INDIRF4
CNSTF4 0
GEF4 $2157
line 4345
;4345:		{
line 4346
;4346:			fallTime = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 4347
;4347:		}
LABELV $2157
line 4348
;4348:		if (fallTime > 1)
ADDRLP4 16
INDIRF4
CNSTF4 1065353216
LEF4 $2159
line 4349
;4349:		{
line 4350
;4350:			fallTime = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 4351
;4351:		}
LABELV $2159
line 4353
;4352:
;4353:		hcolor[3] = fallTime;
ADDRLP4 0+12
ADDRLP4 16
INDIRF4
ASGNF4
line 4354
;4354:		hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4355
;4355:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 4356
;4356:		hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4358
;4357:
;4358:		CG_DrawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH*SCREEN_HEIGHT, hcolor);
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
CNSTF4 1217789952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 4360
;4359:
;4360:		if (!gCGHasFallVector)
ADDRGP4 gCGHasFallVector
INDIRI4
CNSTI4 0
NEI4 $2153
line 4361
;4361:		{
line 4362
;4362:			VectorCopy(cg.snap->ps.origin, gCGFallVector);
ADDRGP4 gCGFallVector
ADDRGP4 cg+36
INDIRP4
CNSTI4 64
ADDP4
INDIRB
ASGNB 12
line 4363
;4363:			gCGHasFallVector = qtrue;
ADDRGP4 gCGHasFallVector
CNSTI4 1
ASGNI4
line 4364
;4364:		}
line 4365
;4365:	}
ADDRGP4 $2153
JUMPV
LABELV $2152
line 4367
;4366:	else
;4367:	{
line 4368
;4368:		if (gCGHasFallVector)
ADDRGP4 gCGHasFallVector
INDIRI4
CNSTI4 0
EQI4 $2167
line 4369
;4369:		{
line 4370
;4370:			gCGHasFallVector = qfalse;
ADDRGP4 gCGHasFallVector
CNSTI4 0
ASGNI4
line 4371
;4371:			VectorClear(gCGFallVector);
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRGP4 gCGFallVector+8
ADDRLP4 56
INDIRF4
ASGNF4
ADDRGP4 gCGFallVector+4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRGP4 gCGFallVector
ADDRLP4 56
INDIRF4
ASGNF4
line 4372
;4372:		}
LABELV $2167
line 4373
;4373:	}
LABELV $2153
line 4375
;4374:
;4375:	CG_DrawVote();
ADDRGP4 CG_DrawVote
CALLV
pop
line 4376
;4376:	CG_DrawTeamVote();
ADDRGP4 CG_DrawTeamVote
CALLV
pop
line 4378
;4377:
;4378:	CG_DrawLagometer();
ADDRGP4 CG_DrawLagometer
CALLV
pop
line 4380
;4379:
;4380:	if (!cg_paused.integer) {
ADDRGP4 cg_paused+12
INDIRI4
CNSTI4 0
NEI4 $2171
line 4381
;4381:		CG_DrawUpperRight();
ADDRGP4 CG_DrawUpperRight
CALLV
pop
line 4382
;4382:	}
LABELV $2171
line 4384
;4383:
;4384:	if ( !CG_DrawFollow() ) {
ADDRLP4 56
ADDRGP4 CG_DrawFollow
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $2174
line 4385
;4385:		CG_DrawWarmup();
ADDRGP4 CG_DrawWarmup
CALLV
pop
line 4386
;4386:	}
LABELV $2174
line 4389
;4387:
;4388:	// don't draw center string if scoreboard is up
;4389:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 60
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+6976
ADDRLP4 60
INDIRI4
ASGNI4
line 4390
;4390:	if ( !cg.scoreBoardShowing) {
ADDRGP4 cg+6976
INDIRI4
CNSTI4 0
NEI4 $2177
line 4391
;4391:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 4392
;4392:	}
LABELV $2177
line 4393
;4393:}
LABELV $1887
endproc CG_Draw2D 68 24
proc CG_DrawTourneyScoreboard 0 0
line 4396
;4394:
;4395:
;4396:static void CG_DrawTourneyScoreboard() {
line 4397
;4397:}
LABELV $2180
endproc CG_DrawTourneyScoreboard 0 0
export CG_DrawActive
proc CG_DrawActive 24 4
line 4406
;4398:
;4399:/*
;4400:=====================
;4401:CG_DrawActive
;4402:
;4403:Perform all drawing needed to completely fill the screen
;4404:=====================
;4405:*/
;4406:void CG_DrawActive( stereoFrame_t stereoView ) {
line 4411
;4407:	float		separation;
;4408:	vec3_t		baseOrg;
;4409:
;4410:	// optionally draw the info screen instead
;4411:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2182
line 4412
;4412:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 4413
;4413:		return;
ADDRGP4 $2181
JUMPV
LABELV $2182
line 4417
;4414:	}
;4415:
;4416:	// optionally draw the tournement scoreboard instead
;4417:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2185
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $2185
line 4418
;4418:		( cg.snap->ps.pm_flags & PMF_SCOREBOARD ) ) {
line 4419
;4419:		CG_DrawTourneyScoreboard();
ADDRGP4 CG_DrawTourneyScoreboard
CALLV
pop
line 4420
;4420:		return;
ADDRGP4 $2181
JUMPV
LABELV $2185
line 4423
;4421:	}
;4422:
;4423:	switch ( stereoView ) {
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $2192
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $2193
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $2195
ADDRGP4 $2189
JUMPV
LABELV $2192
line 4425
;4424:	case STEREO_CENTER:
;4425:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4426
;4426:		break;
ADDRGP4 $2190
JUMPV
LABELV $2193
line 4428
;4427:	case STEREO_LEFT:
;4428:		separation = -cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4429
;4429:		break;
ADDRGP4 $2190
JUMPV
LABELV $2195
line 4431
;4430:	case STEREO_RIGHT:
;4431:		separation = cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4432
;4432:		break;
ADDRGP4 $2190
JUMPV
LABELV $2189
line 4434
;4433:	default:
;4434:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4435
;4435:		CG_Error( "CG_DrawActive: Undefined stereoView" );
ADDRGP4 $2197
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 4436
;4436:	}
LABELV $2190
line 4440
;4437:
;4438:
;4439:	// clear around the rendered view if sized down
;4440:	CG_TileClear();
ADDRGP4 CG_TileClear
CALLV
pop
line 4443
;4441:
;4442:	// offset vieworg appropriately if we're doing stereo separation
;4443:	VectorCopy( cg.refdef.vieworg, baseOrg );
ADDRLP4 4
ADDRGP4 cg+3604+24
INDIRB
ASGNB 12
line 4444
;4444:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $2200
line 4445
;4445:		VectorMA( cg.refdef.vieworg, -separation, cg.refdef.viewaxis[1], cg.refdef.vieworg );
ADDRGP4 cg+3604+24
ADDRGP4 cg+3604+24
INDIRF4
ADDRGP4 cg+3604+36+12
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+3604+24+4
ADDRGP4 cg+3604+24+4
INDIRF4
ADDRGP4 cg+3604+36+12+4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+3604+24+8
ADDRGP4 cg+3604+24+8
INDIRF4
ADDRGP4 cg+3604+36+12+8
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 4446
;4446:	}
LABELV $2200
line 4449
;4447:
;4448:	// draw 3D view
;4449:	trap_R_RenderScene( &cg.refdef );
ADDRGP4 cg+3604
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 4452
;4450:
;4451:	// restore original viewpoint if running stereo
;4452:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $2230
line 4453
;4453:		VectorCopy( baseOrg, cg.refdef.vieworg );
ADDRGP4 cg+3604+24
ADDRLP4 4
INDIRB
ASGNB 12
line 4454
;4454:	}
LABELV $2230
line 4457
;4455:
;4456:	// draw status bar and other floating elements
;4457: 	CG_Draw2D();
ADDRGP4 CG_Draw2D
CALLV
pop
line 4458
;4458:}
LABELV $2181
endproc CG_DrawActive 24 4
bss
export gCGFallVector
align 4
LABELV gCGFallVector
skip 12
export lagometer
align 4
LABELV lagometer
skip 1544
import zoomFov
export lastvalidlockdif
align 4
LABELV lastvalidlockdif
skip 4
export hudTintColor
align 4
LABELV hudTintColor
skip 4
import cgDC
import CG_CalcMuzzlePoint
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
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
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
import CG_OwnerDraw
export teamChat2
align 1
LABELV teamChat2
skip 256
export teamChat1
align 1
LABELV teamChat1
skip 256
export systemChat
align 1
LABELV systemChat
skip 256
import drawTeamOverlayModificationCount
export numSortedTeamPlayers
align 4
LABELV numSortedTeamPlayers
skip 4
export sortedTeamPlayers
align 4
LABELV sortedTeamPlayers
skip 128
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
LABELV $2197
char 1 67
char 1 71
char 1 95
char 1 68
char 1 114
char 1 97
char 1 119
char 1 65
char 1 99
char 1 116
char 1 105
char 1 118
char 1 101
char 1 58
char 1 32
char 1 85
char 1 110
char 1 100
char 1 101
char 1 102
char 1 105
char 1 110
char 1 101
char 1 100
char 1 32
char 1 115
char 1 116
char 1 101
char 1 114
char 1 101
char 1 111
char 1 86
char 1 105
char 1 101
char 1 119
char 1 0
align 1
LABELV $1882
char 1 103
char 1 102
char 1 120
char 1 47
char 1 104
char 1 117
char 1 100
char 1 47
char 1 109
char 1 112
char 1 105
char 1 95
char 1 114
char 1 102
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $1881
char 1 103
char 1 102
char 1 120
char 1 47
char 1 104
char 1 117
char 1 100
char 1 47
char 1 109
char 1 112
char 1 105
char 1 95
char 1 98
char 1 102
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $1878
char 1 103
char 1 102
char 1 120
char 1 47
char 1 104
char 1 117
char 1 100
char 1 47
char 1 109
char 1 112
char 1 105
char 1 95
char 1 98
char 1 102
char 1 108
char 1 97
char 1 103
char 1 95
char 1 120
char 1 0
align 1
LABELV $1877
char 1 103
char 1 102
char 1 120
char 1 47
char 1 104
char 1 117
char 1 100
char 1 47
char 1 109
char 1 112
char 1 105
char 1 95
char 1 114
char 1 102
char 1 108
char 1 97
char 1 103
char 1 95
char 1 120
char 1 0
align 1
LABELV $1861
char 1 48
char 1 0
align 1
LABELV $1860
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
LABELV $1859
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
LABELV $1829
char 1 83
char 1 84
char 1 65
char 1 82
char 1 84
char 1 83
char 1 95
char 1 73
char 1 78
char 1 0
align 1
LABELV $1824
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
LABELV $1820
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
LABELV $1816
char 1 78
char 1 47
char 1 65
char 1 0
align 1
LABELV $1812
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
LABELV $1808
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
LABELV $1804
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
LABELV $1800
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
LABELV $1796
char 1 37
char 1 115
char 1 32
char 1 118
char 1 115
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $1775
char 1 87
char 1 65
char 1 73
char 1 84
char 1 73
char 1 78
char 1 71
char 1 95
char 1 70
char 1 79
char 1 82
char 1 95
char 1 80
char 1 76
char 1 65
char 1 89
char 1 69
char 1 82
char 1 83
char 1 0
align 1
LABELV $1764
char 1 70
char 1 79
char 1 76
char 1 76
char 1 79
char 1 87
char 1 73
char 1 78
char 1 71
char 1 0
align 1
LABELV $1748
char 1 84
char 1 69
char 1 65
char 1 77
char 1 86
char 1 79
char 1 84
char 1 69
char 1 40
char 1 37
char 1 105
char 1 41
char 1 58
char 1 37
char 1 115
char 1 32
char 1 121
char 1 101
char 1 115
char 1 58
char 1 37
char 1 105
char 1 32
char 1 110
char 1 111
char 1 58
char 1 37
char 1 105
char 1 0
align 1
LABELV $1743
char 1 84
char 1 69
char 1 65
char 1 77
char 1 86
char 1 79
char 1 84
char 1 69
char 1 40
char 1 37
char 1 105
char 1 41
char 1 58
char 1 40
char 1 77
char 1 97
char 1 107
char 1 101
char 1 32
char 1 37
char 1 115
char 1 32
char 1 116
char 1 104
char 1 101
char 1 32
char 1 110
char 1 101
char 1 119
char 1 32
char 1 116
char 1 101
char 1 97
char 1 109
char 1 32
char 1 108
char 1 101
char 1 97
char 1 100
char 1 101
char 1 114
char 1 41
char 1 32
char 1 121
char 1 101
char 1 115
char 1 58
char 1 37
char 1 105
char 1 32
char 1 110
char 1 111
char 1 58
char 1 37
char 1 105
char 1 0
align 1
LABELV $1728
char 1 108
char 1 101
char 1 97
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $1704
char 1 79
char 1 82
char 1 95
char 1 80
char 1 82
char 1 69
char 1 83
char 1 83
char 1 95
char 1 69
char 1 83
char 1 67
char 1 95
char 1 84
char 1 72
char 1 69
char 1 78
char 1 95
char 1 67
char 1 76
char 1 73
char 1 67
char 1 75
char 1 95
char 1 86
char 1 79
char 1 84
char 1 69
char 1 0
align 1
LABELV $1700
char 1 86
char 1 79
char 1 84
char 1 69
char 1 40
char 1 37
char 1 105
char 1 41
char 1 58
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 58
char 1 37
char 1 105
char 1 32
char 1 37
char 1 115
char 1 58
char 1 37
char 1 105
char 1 0
align 1
LABELV $1699
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 48
char 1 95
char 1 78
char 1 79
char 1 0
align 1
LABELV $1698
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 48
char 1 95
char 1 89
char 1 69
char 1 83
char 1 0
align 1
LABELV $1685
char 1 83
char 1 80
char 1 69
char 1 67
char 1 95
char 1 67
char 1 72
char 1 79
char 1 79
char 1 83
char 1 69
char 1 74
char 1 79
char 1 73
char 1 78
char 1 0
align 1
LABELV $1684
char 1 87
char 1 65
char 1 73
char 1 84
char 1 73
char 1 78
char 1 71
char 1 95
char 1 84
char 1 79
char 1 95
char 1 80
char 1 76
char 1 65
char 1 89
char 1 0
align 1
LABELV $1662
char 1 83
char 1 80
char 1 69
char 1 67
char 1 72
char 1 85
char 1 68
char 1 95
char 1 86
char 1 69
char 1 82
char 1 83
char 1 85
char 1 83
char 1 0
align 1
LABELV $1658
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $1652
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
LABELV $1521
char 1 103
char 1 102
char 1 120
char 1 47
char 1 50
char 1 100
char 1 47
char 1 108
char 1 111
char 1 99
char 1 107
char 1 0
align 1
LABELV $1514
char 1 103
char 1 102
char 1 120
char 1 47
char 1 50
char 1 100
char 1 47
char 1 119
char 1 101
char 1 100
char 1 103
char 1 101
char 1 0
align 1
LABELV $1506
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
char 1 114
char 1 111
char 1 99
char 1 107
char 1 101
char 1 116
char 1 47
char 1 116
char 1 105
char 1 99
char 1 107
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $1505
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
char 1 114
char 1 111
char 1 99
char 1 107
char 1 101
char 1 116
char 1 47
char 1 108
char 1 111
char 1 99
char 1 107
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $1402
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
char 1 70
char 1 108
char 1 97
char 1 114
char 1 101
char 1 0
align 1
LABELV $1188
char 1 115
char 1 110
char 1 99
char 1 0
align 1
LABELV $1123
char 1 103
char 1 102
char 1 120
char 1 47
char 1 50
char 1 100
char 1 47
char 1 110
char 1 101
char 1 116
char 1 46
char 1 116
char 1 103
char 1 97
char 1 0
align 1
LABELV $1119
char 1 67
char 1 79
char 1 78
char 1 78
char 1 69
char 1 67
char 1 84
char 1 73
char 1 79
char 1 78
char 1 95
char 1 73
char 1 78
char 1 84
char 1 69
char 1 82
char 1 82
char 1 85
char 1 80
char 1 84
char 1 69
char 1 68
char 1 0
align 1
LABELV $1113
char 1 80
char 1 76
char 1 69
char 1 65
char 1 83
char 1 69
char 1 95
char 1 87
char 1 65
char 1 73
char 1 84
char 1 0
align 1
LABELV $1112
char 1 83
char 1 69
char 1 82
char 1 86
char 1 69
char 1 82
char 1 95
char 1 67
char 1 72
char 1 65
char 1 78
char 1 71
char 1 73
char 1 78
char 1 71
char 1 95
char 1 77
char 1 65
char 1 80
char 1 83
char 1 0
align 1
LABELV $1073
char 1 103
char 1 102
char 1 120
char 1 47
char 1 104
char 1 117
char 1 100
char 1 47
char 1 109
char 1 112
char 1 105
char 1 95
char 1 98
char 1 102
char 1 108
char 1 97
char 1 103
char 1 95
char 1 121
char 1 115
char 1 0
align 1
LABELV $1072
char 1 103
char 1 102
char 1 120
char 1 47
char 1 104
char 1 117
char 1 100
char 1 47
char 1 109
char 1 112
char 1 105
char 1 95
char 1 114
char 1 102
char 1 108
char 1 97
char 1 103
char 1 95
char 1 121
char 1 115
char 1 0
align 1
LABELV $1031
char 1 37
char 1 51
char 1 105
char 1 32
char 1 37
char 1 51
char 1 105
char 1 0
align 1
LABELV $1028
char 1 117
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 0
align 1
LABELV $961
char 1 37
char 1 105
char 1 58
char 1 37
char 1 105
char 1 37
char 1 105
char 1 0
align 1
LABELV $957
char 1 37
char 1 105
char 1 102
char 1 112
char 1 115
char 1 0
align 1
LABELV $941
char 1 116
char 1 105
char 1 109
char 1 101
char 1 58
char 1 37
char 1 105
char 1 32
char 1 115
char 1 110
char 1 97
char 1 112
char 1 58
char 1 37
char 1 105
char 1 32
char 1 99
char 1 109
char 1 100
char 1 58
char 1 37
char 1 105
char 1 0
align 1
LABELV $933
char 1 76
char 1 69
char 1 65
char 1 68
char 1 69
char 1 82
char 1 0
align 1
LABELV $932
char 1 37
char 1 115
char 1 58
char 1 32
char 1 37
char 1 105
char 1 0
align 1
LABELV $909
char 1 68
char 1 85
char 1 69
char 1 76
char 1 73
char 1 78
char 1 71
char 1 0
align 1
LABELV $902
char 1 71
char 1 69
char 1 84
char 1 95
char 1 83
char 1 65
char 1 66
char 1 69
char 1 82
char 1 0
align 1
LABELV $898
char 1 77
char 1 65
char 1 83
char 1 84
char 1 69
char 1 82
char 1 89
char 1 55
char 1 0
align 1
LABELV $897
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
LABELV $880
char 1 32
char 1 66
char 1 108
char 1 117
char 1 101
char 1 58
char 1 32
char 1 0
align 1
LABELV $875
char 1 45
char 1 0
align 1
LABELV $873
char 1 82
char 1 101
char 1 100
char 1 58
char 1 32
char 1 0
align 1
LABELV $831
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
LABELV $787
char 1 69
char 1 77
char 1 80
char 1 84
char 1 89
char 1 32
char 1 73
char 1 78
char 1 86
char 1 69
char 1 78
char 1 84
char 1 79
char 1 82
char 1 89
char 1 0
align 1
LABELV $756
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 0
align 1
LABELV $671
char 1 114
char 1 105
char 1 103
char 1 104
char 1 116
char 1 104
char 1 117
char 1 100
char 1 0
align 1
LABELV $668
char 1 83
char 1 99
char 1 111
char 1 114
char 1 101
char 1 58
char 1 32
char 1 37
char 1 105
char 1 0
align 1
LABELV $666
char 1 83
char 1 99
char 1 111
char 1 114
char 1 101
char 1 58
char 1 32
char 1 37
char 1 105
char 1 37
char 1 115
char 1 0
align 1
LABELV $665
char 1 32
char 1 40
char 1 37
char 1 100
char 1 41
char 1 0
align 1
LABELV $664
char 1 32
char 1 40
char 1 43
char 1 37
char 1 100
char 1 41
char 1 0
align 1
LABELV $663
char 1 32
char 1 40
char 1 84
char 1 105
char 1 101
char 1 41
char 1 0
align 1
LABELV $658
char 1 0
align 1
LABELV $645
char 1 108
char 1 101
char 1 102
char 1 116
char 1 104
char 1 117
char 1 100
char 1 0
align 1
LABELV $630
char 1 37
char 1 115
char 1 0
align 1
LABELV $628
char 1 70
char 1 65
char 1 83
char 1 84
char 1 0
align 1
LABELV $627
char 1 77
char 1 69
char 1 68
char 1 73
char 1 85
char 1 77
char 1 0
align 1
LABELV $623
char 1 83
char 1 84
char 1 82
char 1 79
char 1 78
char 1 71
char 1 0
align 1
LABELV $612
char 1 37
char 1 105
char 1 0
align 1
LABELV $146
char 1 83
char 1 65
char 1 66
char 1 69
char 1 82
char 1 95
char 1 84
char 1 72
char 1 82
char 1 79
char 1 87
char 1 50
char 1 0
align 1
LABELV $145
char 1 83
char 1 65
char 1 66
char 1 69
char 1 82
char 1 95
char 1 68
char 1 69
char 1 70
char 1 69
char 1 78
char 1 83
char 1 69
char 1 50
char 1 0
align 1
LABELV $144
char 1 83
char 1 65
char 1 66
char 1 69
char 1 82
char 1 95
char 1 79
char 1 70
char 1 70
char 1 69
char 1 78
char 1 83
char 1 69
char 1 50
char 1 0
align 1
LABELV $143
char 1 83
char 1 69
char 1 69
char 1 73
char 1 78
char 1 71
char 1 50
char 1 0
align 1
LABELV $142
char 1 68
char 1 82
char 1 65
char 1 73
char 1 78
char 1 50
char 1 0
align 1
LABELV $141
char 1 84
char 1 69
char 1 65
char 1 77
char 1 95
char 1 82
char 1 69
char 1 80
char 1 76
char 1 69
char 1 78
char 1 73
char 1 83
char 1 72
char 1 50
char 1 0
align 1
LABELV $140
char 1 84
char 1 69
char 1 65
char 1 77
char 1 95
char 1 72
char 1 69
char 1 65
char 1 76
char 1 50
char 1 0
align 1
LABELV $139
char 1 65
char 1 66
char 1 83
char 1 79
char 1 82
char 1 66
char 1 50
char 1 0
align 1
LABELV $138
char 1 80
char 1 82
char 1 79
char 1 84
char 1 69
char 1 67
char 1 84
char 1 50
char 1 0
align 1
LABELV $137
char 1 68
char 1 65
char 1 82
char 1 75
char 1 95
char 1 82
char 1 65
char 1 71
char 1 69
char 1 50
char 1 0
align 1
LABELV $136
char 1 76
char 1 73
char 1 71
char 1 72
char 1 84
char 1 78
char 1 73
char 1 78
char 1 71
char 1 50
char 1 0
align 1
LABELV $135
char 1 71
char 1 82
char 1 73
char 1 80
char 1 50
char 1 0
align 1
LABELV $134
char 1 77
char 1 73
char 1 78
char 1 68
char 1 84
char 1 82
char 1 73
char 1 67
char 1 75
char 1 50
char 1 0
align 1
LABELV $133
char 1 80
char 1 85
char 1 76
char 1 76
char 1 50
char 1 0
align 1
LABELV $132
char 1 80
char 1 85
char 1 83
char 1 72
char 1 50
char 1 0
align 1
LABELV $131
char 1 83
char 1 80
char 1 69
char 1 69
char 1 68
char 1 50
char 1 0
align 1
LABELV $130
char 1 74
char 1 85
char 1 77
char 1 80
char 1 50
char 1 0
align 1
LABELV $129
char 1 72
char 1 69
char 1 65
char 1 76
char 1 50
char 1 0
