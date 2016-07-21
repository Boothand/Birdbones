data
align 4
LABELV captureFunc
byte 4 0
align 4
LABELV captureData
byte 4 0
align 4
LABELV itemCapture
byte 4 0
export DC
align 4
LABELV DC
byte 4 0
align 4
LABELV g_waitingForKey
byte 4 0
align 4
LABELV g_editingField
byte 4 0
align 4
LABELV g_bindItem
byte 4 0
align 4
LABELV g_editItem
byte 4 0
export menuCount
align 4
LABELV menuCount
byte 4 0
export openMenuCount
align 4
LABELV openMenuCount
byte 4 0
align 4
LABELV debugMode
byte 4 0
align 4
LABELV lastListBoxClickTime
byte 4 0
export itemFlags
align 4
LABELV itemFlags
address $60
byte 4 8
byte 4 0
byte 4 0
export styles
align 4
LABELV styles
address $61
address $62
address $63
address $64
address $65
address $66
byte 4 0
export alignment
align 4
LABELV alignment
address $67
address $68
address $69
byte 4 0
export types
align 4
LABELV types
address $70
address $71
address $72
address $73
address $74
address $75
address $76
address $77
address $78
address $79
address $80
address $81
address $82
address $83
address $84
byte 4 0
export UI_Alloc
code
proc UI_Alloc 8 4
file "../../ui/ui_shared.c"
line 125
;1:// 
;2:// string allocation/managment
;3:
;4:#include "ui_shared.h"
;5:
;6:#define SCROLL_TIME_START					500
;7:#define SCROLL_TIME_ADJUST				150
;8:#define SCROLL_TIME_ADJUSTOFFSET	40
;9:#define SCROLL_TIME_FLOOR					20
;10:
;11:typedef struct scrollInfo_s {
;12:	int nextScrollTime;
;13:	int nextAdjustTime;
;14:	int adjustValue;
;15:	int scrollKey;
;16:	float xStart;
;17:	float yStart;
;18:	itemDef_t *item;
;19:	qboolean scrollDir;
;20:} scrollInfo_t;
;21:
;22:static scrollInfo_t scrollInfo;
;23:
;24:static void (*captureFunc) (void *p) = 0;
;25:static void *captureData = NULL;
;26:static itemDef_t *itemCapture = NULL;   // item that has the mouse captured ( if any )
;27:
;28:displayContextDef_t *DC = NULL;
;29:
;30:static qboolean g_waitingForKey = qfalse;
;31:static qboolean g_editingField = qfalse;
;32:
;33:static itemDef_t *g_bindItem = NULL;
;34:static itemDef_t *g_editItem = NULL;
;35:
;36:menuDef_t Menus[MAX_MENUS];      // defined menus
;37:int menuCount = 0;               // how many
;38:
;39:menuDef_t *menuStack[MAX_OPEN_MENUS];
;40:int openMenuCount = 0;
;41:
;42:static qboolean debugMode = qfalse;
;43:
;44:#define DOUBLE_CLICK_DELAY 300
;45:static int lastListBoxClickTime = 0;
;46:
;47:void Item_RunScript(itemDef_t *item, const char *s);
;48:void Item_SetupKeywordHash(void);
;49:void Menu_SetupKeywordHash(void);
;50:int BindingIDFromName(const char *name);
;51:qboolean Item_Bind_HandleKey(itemDef_t *item, int key, qboolean down);
;52:itemDef_t *Menu_SetPrevCursorItem(menuDef_t *menu);
;53:itemDef_t *Menu_SetNextCursorItem(menuDef_t *menu);
;54:static qboolean Menu_OverActiveItem(menuDef_t *menu, float x, float y);
;55:static void Item_TextScroll_BuildLines ( itemDef_t* item );
;56:
;57:#ifdef CGAME
;58:#define MEM_POOL_SIZE  128 * 1024
;59:#else
;60://#define MEM_POOL_SIZE  1024 * 1024
;61:#define MEM_POOL_SIZE  2048 * 1024
;62:#endif
;63:
;64:static char		memoryPool[MEM_POOL_SIZE];
;65:static int		allocPoint, outOfMemory;
;66:
;67:
;68:typedef struct  itemFlagsDef_s {
;69:	char *string;
;70:	int value;
;71:}	itemFlagsDef_t;
;72:
;73:itemFlagsDef_t itemFlags [] = {
;74:"WINDOW_INACTIVE",		WINDOW_INACTIVE,
;75:NULL,					(int) NULL
;76:};
;77:
;78:char *styles [] = {
;79:"WINDOW_STYLE_EMPTY",
;80:"WINDOW_STYLE_FILLED",
;81:"WINDOW_STYLE_GRADIENT",
;82:"WINDOW_STYLE_SHADER",
;83:"WINDOW_STYLE_TEAMCOLOR",
;84:"WINDOW_STYLE_CINEMATIC",
;85:NULL
;86:};
;87:
;88:char *alignment [] = {
;89:"ITEM_ALIGN_LEFT",
;90:"ITEM_ALIGN_CENTER",
;91:"ITEM_ALIGN_RIGHT",
;92:NULL
;93:};
;94:
;95:char *types [] = {
;96:"ITEM_TYPE_TEXT",
;97:"ITEM_TYPE_BUTTON",
;98:"ITEM_TYPE_RADIOBUTTON",
;99:"ITEM_TYPE_CHECKBOX",
;100:"ITEM_TYPE_EDITFIELD",
;101:"ITEM_TYPE_COMBO",
;102:"ITEM_TYPE_LISTBOX",
;103:"ITEM_TYPE_MODEL",
;104:"ITEM_TYPE_OWNERDRAW",
;105:"ITEM_TYPE_NUMERICFIELD",
;106:"ITEM_TYPE_SLIDER",
;107:"ITEM_TYPE_YESNO",
;108:"ITEM_TYPE_MULTI",
;109:"ITEM_TYPE_BIND",
;110:"ITEM_TYPE_TEXTSCROLL",
;111:NULL
;112:};
;113:
;114:
;115:extern int MenuFontToHandle(int iMenuFont);
;116:
;117:
;118:
;119:
;120:/*
;121:===============
;122:UI_Alloc
;123:===============
;124:*/				  
;125:void *UI_Alloc( int size ) {
line 128
;126:	char	*p; 
;127:
;128:	if ( allocPoint + size > MEM_POOL_SIZE ) {
ADDRGP4 allocPoint
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
CNSTI4 131072
LEI4 $86
line 129
;129:		outOfMemory = qtrue;
ADDRGP4 outOfMemory
CNSTI4 1
ASGNI4
line 130
;130:		if (DC->Print) {
ADDRGP4 DC
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $88
line 131
;131:			DC->Print("UI_Alloc: Failure. Out of memory!\n");
ADDRGP4 $90
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
CALLV
pop
line 132
;132:		}
LABELV $88
line 134
;133:    //DC->trap_Print(S_COLOR_YELLOW"WARNING: UI Out of Memory!\n");
;134:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $85
JUMPV
LABELV $86
line 137
;135:	}
;136:
;137:	p = &memoryPool[allocPoint];
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
ADDRGP4 memoryPool
ADDP4
ASGNP4
line 139
;138:
;139:	allocPoint += ( size + 15 ) & ~15;
ADDRLP4 4
ADDRGP4 allocPoint
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
CNSTI4 15
ADDI4
CNSTI4 -16
BANDI4
ADDI4
ASGNI4
line 141
;140:
;141:	return p;
ADDRLP4 0
INDIRP4
RETP4
LABELV $85
endproc UI_Alloc 8 4
export UI_InitMemory
proc UI_InitMemory 0 0
line 149
;142:}
;143:
;144:/*
;145:===============
;146:UI_InitMemory
;147:===============
;148:*/
;149:void UI_InitMemory( void ) {
line 150
;150:	allocPoint = 0;
ADDRGP4 allocPoint
CNSTI4 0
ASGNI4
line 151
;151:	outOfMemory = qfalse;
ADDRGP4 outOfMemory
CNSTI4 0
ASGNI4
line 152
;152:}
LABELV $91
endproc UI_InitMemory 0 0
export UI_OutOfMemory
proc UI_OutOfMemory 0 0
line 154
;153:
;154:qboolean UI_OutOfMemory() {
line 155
;155:	return outOfMemory;
ADDRGP4 outOfMemory
INDIRI4
RETI4
LABELV $92
endproc UI_OutOfMemory 0 0
proc hashForString 16 4
line 168
;156:}
;157:
;158:
;159:
;160:
;161:
;162:#define HASH_TABLE_SIZE 2048
;163:/*
;164:================
;165:return a hash value for the string
;166:================
;167:*/
;168:static long hashForString(const char *str) {
line 173
;169:	int		i;
;170:	long	hash;
;171:	char	letter;
;172:
;173:	hash = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 174
;174:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $95
JUMPV
LABELV $94
line 175
;175:	while (str[i] != '\0') {
line 176
;176:		letter = tolower(str[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CVII1 4
ASGNI1
line 177
;177:		hash+=(long)(letter)*(i+119);
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI1
CVII4 1
ADDRLP4 0
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
line 178
;178:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 179
;179:	}
LABELV $95
line 175
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $94
line 180
;180:	hash &= (HASH_TABLE_SIZE-1);
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 2047
BANDI4
ASGNI4
line 181
;181:	return hash;
ADDRLP4 8
INDIRI4
RETI4
LABELV $93
endproc hashForString 16 4
data
align 4
LABELV strPoolIndex
byte 4 0
align 4
LABELV strHandleCount
byte 4 0
align 4
LABELV $98
address $99
export String_Alloc
code
proc String_Alloc 44 8
line 196
;182:}
;183:
;184:typedef struct stringDef_s {
;185:	struct stringDef_s *next;
;186:	const char *str;
;187:} stringDef_t;
;188:
;189:static int strPoolIndex = 0;
;190:static char strPool[STRING_POOL_SIZE];
;191:
;192:static int strHandleCount = 0;
;193:static stringDef_t *strHandle[HASH_TABLE_SIZE];
;194:
;195:
;196:const char *String_Alloc(const char *p) {
line 202
;197:	int len;
;198:	long hash;
;199:	stringDef_t *str, *last;
;200:	static const char *staticNULL = "";
;201:
;202:	if (p == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $100
line 203
;203:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $97
JUMPV
LABELV $100
line 206
;204:	}
;205:
;206:	if (*p == 0) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $102
line 207
;207:		return staticNULL;
ADDRGP4 $98
INDIRP4
RETP4
ADDRGP4 $97
JUMPV
LABELV $102
line 210
;208:	}
;209:
;210:	hash = hashForString(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 hashForString
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 212
;211:
;212:	str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $105
JUMPV
LABELV $104
line 213
;213:	while (str) {
line 214
;214:		if (strcmp(p, str->str) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $107
line 215
;215:			return str->str;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
RETP4
ADDRGP4 $97
JUMPV
LABELV $107
line 217
;216:		}
;217:		str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 218
;218:	}
LABELV $105
line 213
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $104
line 220
;219:
;220:	len = strlen(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 221
;221:	if (len + strPoolIndex + 1 < STRING_POOL_SIZE) {
ADDRLP4 12
INDIRI4
ADDRGP4 strPoolIndex
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 131072
GEI4 $109
line 222
;222:		int ph = strPoolIndex;
ADDRLP4 24
ADDRGP4 strPoolIndex
INDIRI4
ASGNI4
line 223
;223:		strcpy(&strPool[strPoolIndex], p);
ADDRGP4 strPoolIndex
INDIRI4
ADDRGP4 strPool
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 224
;224:		strPoolIndex += len + 1;
ADDRLP4 28
ADDRGP4 strPoolIndex
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 226
;225:
;226:		str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
line 227
;227:		last = str;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $112
JUMPV
LABELV $111
line 228
;228:		while (str && str->next) {
line 229
;229:			last = str;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 230
;230:			str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 231
;231:		}
LABELV $112
line 228
ADDRLP4 36
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 36
INDIRU4
EQU4 $114
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRLP4 36
INDIRU4
NEU4 $111
LABELV $114
line 233
;232:
;233:		str  = UI_Alloc(sizeof(stringDef_t));
CNSTI4 8
ARGI4
ADDRLP4 40
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 234
;234:		str->next = NULL;
ADDRLP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 235
;235:		str->str = &strPool[ph];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
ASGNP4
line 236
;236:		if (last) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $115
line 237
;237:			last->next = str;
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 238
;238:		} else {
ADDRGP4 $116
JUMPV
LABELV $115
line 239
;239:			strHandle[hash] = str;
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 240
;240:		}
LABELV $116
line 241
;241:		return &strPool[ph];
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
RETP4
ADDRGP4 $97
JUMPV
LABELV $109
line 243
;242:	}
;243:	return NULL;
CNSTP4 0
RETP4
LABELV $97
endproc String_Alloc 44 8
export String_Report
proc String_Report 4 16
line 246
;244:}
;245:
;246:void String_Report() {
line 248
;247:	float f;
;248:	Com_Printf("Memory/String Pool Info\n");
ADDRGP4 $118
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 249
;249:	Com_Printf("----------------\n");
ADDRGP4 $119
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 250
;250:	f = strPoolIndex;
ADDRLP4 0
ADDRGP4 strPoolIndex
INDIRI4
CVIF4 4
ASGNF4
line 251
;251:	f /= STRING_POOL_SIZE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1207959552
DIVF4
ASGNF4
line 252
;252:	f *= 100;
ADDRLP4 0
CNSTF4 1120403456
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 253
;253:	Com_Printf("String Pool is %.1f%% full, %i bytes out of %i used.\n", f, strPoolIndex, STRING_POOL_SIZE);
ADDRGP4 $120
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 strPoolIndex
INDIRI4
ARGI4
CNSTI4 131072
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 254
;254:	f = allocPoint;
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
CVIF4 4
ASGNF4
line 255
;255:	f /= MEM_POOL_SIZE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1207959552
DIVF4
ASGNF4
line 256
;256:	f *= 100;
ADDRLP4 0
CNSTF4 1120403456
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 257
;257:	Com_Printf("Memory Pool is %.1f%% full, %i bytes out of %i used.\n", f, allocPoint, MEM_POOL_SIZE);
ADDRGP4 $121
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 allocPoint
INDIRI4
ARGI4
CNSTI4 131072
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 258
;258:}
LABELV $117
endproc String_Report 4 16
export String_Init
proc String_Init 12 0
line 265
;259:
;260:/*
;261:=================
;262:String_Init
;263:=================
;264:*/
;265:void String_Init() {
line 267
;266:	int i;
;267:	for (i = 0; i < HASH_TABLE_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $123
line 268
;268:		strHandle[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
CNSTP4 0
ASGNP4
line 269
;269:	}
LABELV $124
line 267
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2048
LTI4 $123
line 270
;270:	strHandleCount = 0;
ADDRGP4 strHandleCount
CNSTI4 0
ASGNI4
line 271
;271:	strPoolIndex = 0;
ADDRGP4 strPoolIndex
CNSTI4 0
ASGNI4
line 272
;272:	menuCount = 0;
ADDRGP4 menuCount
CNSTI4 0
ASGNI4
line 273
;273:	openMenuCount = 0;
ADDRGP4 openMenuCount
CNSTI4 0
ASGNI4
line 274
;274:	UI_InitMemory();
ADDRGP4 UI_InitMemory
CALLV
pop
line 275
;275:	Item_SetupKeywordHash();
ADDRGP4 Item_SetupKeywordHash
CALLV
pop
line 276
;276:	Menu_SetupKeywordHash();
ADDRGP4 Menu_SetupKeywordHash
CALLV
pop
line 277
;277:	if (DC && DC->getBindingBuf) {
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $127
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $127
line 278
;278:		Controls_GetConfig();
ADDRGP4 Controls_GetConfig
CALLV
pop
line 279
;279:	}
LABELV $127
line 280
;280:}
LABELV $122
endproc String_Init 12 0
bss
align 1
LABELV $130
skip 4096
export PC_SourceWarning
code
proc PC_SourceWarning 136 16
line 287
;281:
;282:/*
;283:=================
;284:PC_SourceWarning
;285:=================
;286:*/
;287:void PC_SourceWarning(int handle, char *format, ...) {
line 293
;288:	int line;
;289:	char filename[128];
;290:	va_list argptr;
;291:	static char string[4096];
;292:
;293:	va_start (argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 294
;294:	vsprintf (string, format, argptr);
ADDRGP4 $130
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 295
;295:	va_end (argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 297
;296:
;297:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 298
;298:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 299
;299:	trap_PC_SourceFileAndLine(handle, filename, &line);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_PC_SourceFileAndLine
CALLI4
pop
line 301
;300:
;301:	Com_Printf(S_COLOR_YELLOW "WARNING: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $132
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $130
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 302
;302:}
LABELV $129
endproc PC_SourceWarning 136 16
bss
align 1
LABELV $134
skip 4096
export PC_SourceError
code
proc PC_SourceError 136 16
line 309
;303:
;304:/*
;305:=================
;306:PC_SourceError
;307:=================
;308:*/
;309:void PC_SourceError(int handle, char *format, ...) {
line 315
;310:	int line;
;311:	char filename[128];
;312:	va_list argptr;
;313:	static char string[4096];
;314:
;315:	va_start (argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 316
;316:	vsprintf (string, format, argptr);
ADDRGP4 $134
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 317
;317:	va_end (argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 319
;318:
;319:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 320
;320:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 321
;321:	trap_PC_SourceFileAndLine(handle, filename, &line);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_PC_SourceFileAndLine
CALLI4
pop
line 323
;322:
;323:	Com_Printf(S_COLOR_RED "ERROR: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $136
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $134
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 324
;324:}
LABELV $133
endproc PC_SourceError 136 16
export LerpColor
proc LerpColor 12 0
line 332
;325:
;326:/*
;327:=================
;328:LerpColor
;329:=================
;330:*/
;331:void LerpColor(vec4_t a, vec4_t b, vec4_t c, float t)
;332:{
line 336
;333:	int i;
;334:
;335:	// lerp and clamp each component
;336:	for (i=0; i<4; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $138
line 337
;337:	{
line 338
;338:		c[i] = a[i] + t*(b[i]-a[i]);
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 8
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 339
;339:		if (c[i] < 0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $142
line 340
;340:			c[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $143
JUMPV
LABELV $142
line 341
;341:		else if (c[i] > 1.0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $144
line 342
;342:			c[i] = 1.0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $144
LABELV $143
line 343
;343:	}
LABELV $139
line 336
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $138
line 344
;344:}
LABELV $137
endproc LerpColor 12 0
export Float_Parse
proc Float_Parse 16 8
line 351
;345:
;346:/*
;347:=================
;348:Float_Parse
;349:=================
;350:*/
;351:qboolean Float_Parse(char **p, float *f) {
line 353
;352:	char	*token;
;353:	token = COM_ParseExt((const char **)p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 354
;354:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $147
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $147
line 355
;355:		*f = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 356
;356:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $146
JUMPV
LABELV $147
line 357
;357:	} else {
line 358
;358:		return qfalse;
CNSTI4 0
RETI4
LABELV $146
endproc Float_Parse 16 8
export PC_Float_Parse
proc PC_Float_Parse 1052 12
line 367
;359:	}
;360:}
;361:
;362:/*
;363:=================
;364:PC_Float_Parse
;365:=================
;366:*/
;367:qboolean PC_Float_Parse(int handle, float *f) {
line 369
;368:	pc_token_t token;
;369:	int negative = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 371
;370:
;371:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $150
line 372
;372:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $150
line 373
;373:	if (token.string[0] == '-') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $152
line 374
;374:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $155
line 375
;375:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $155
line 376
;376:		negative = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 377
;377:	}
LABELV $152
line 378
;378:	if (token.type != TT_NUMBER) {
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $157
line 379
;379:		PC_SourceError(handle, "expected float but found %s\n", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $159
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 380
;380:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $157
line 382
;381:	}
;382:	if (negative)
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $161
line 383
;383:		*f = -token.floatvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12
INDIRF4
NEGF4
ASGNF4
ADDRGP4 $162
JUMPV
LABELV $161
line 385
;384:	else
;385:		*f = token.floatvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12
INDIRF4
ASGNF4
LABELV $162
line 386
;386:	return qtrue;
CNSTI4 1
RETI4
LABELV $149
endproc PC_Float_Parse 1052 12
export Color_Parse
proc Color_Parse 12 8
line 394
;387:}
;388:
;389:/*
;390:=================
;391:Color_Parse
;392:=================
;393:*/
;394:qboolean Color_Parse(char **p, vec4_t *c) {
line 398
;395:	int i;
;396:	float f;
;397:
;398:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $166
line 399
;399:		if (!Float_Parse(p, &f)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $170
line 400
;400:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $165
JUMPV
LABELV $170
line 402
;401:		}
;402:		(*c)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 403
;403:	}
LABELV $167
line 398
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $166
line 404
;404:	return qtrue;
CNSTI4 1
RETI4
LABELV $165
endproc Color_Parse 12 8
export PC_Color_Parse
proc PC_Color_Parse 12 8
line 412
;405:}
;406:
;407:/*
;408:=================
;409:PC_Color_Parse
;410:=================
;411:*/
;412:qboolean PC_Color_Parse(int handle, vec4_t *c) {
line 416
;413:	int i;
;414:	float f;
;415:
;416:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $173
line 417
;417:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $177
line 418
;418:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $172
JUMPV
LABELV $177
line 420
;419:		}
;420:		(*c)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 421
;421:	}
LABELV $174
line 416
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $173
line 422
;422:	return qtrue;
CNSTI4 1
RETI4
LABELV $172
endproc PC_Color_Parse 12 8
export Int_Parse
proc Int_Parse 16 8
line 430
;423:}
;424:
;425:/*
;426:=================
;427:Int_Parse
;428:=================
;429:*/
;430:qboolean Int_Parse(char **p, int *i) {
line 432
;431:	char	*token;
;432:	token = COM_ParseExt((const char **)p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 434
;433:
;434:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $180
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $180
line 435
;435:		*i = atoi(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 436
;436:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $179
JUMPV
LABELV $180
line 437
;437:	} else {
line 438
;438:		return qfalse;
CNSTI4 0
RETI4
LABELV $179
endproc Int_Parse 16 8
export PC_Int_Parse
proc PC_Int_Parse 1052 12
line 447
;439:	}
;440:}
;441:
;442:/*
;443:=================
;444:PC_Int_Parse
;445:=================
;446:*/
;447:qboolean PC_Int_Parse(int handle, int *i) {
line 449
;448:	pc_token_t token;
;449:	int negative = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 451
;450:
;451:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $183
line 452
;452:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $183
line 453
;453:	if (token.string[0] == '-') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $185
line 454
;454:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $188
line 455
;455:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $188
line 456
;456:		negative = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 457
;457:	}
LABELV $185
line 458
;458:	if (token.type != TT_NUMBER) {
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $190
line 459
;459:		PC_SourceError(handle, "expected integer but found %s\n", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $192
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 460
;460:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $190
line 462
;461:	}
;462:	*i = token.intvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+8
INDIRI4
ASGNI4
line 463
;463:	if (negative)
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $195
line 464
;464:		*i = - *i;
ADDRLP4 1048
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
NEGI4
ASGNI4
LABELV $195
line 465
;465:	return qtrue;
CNSTI4 1
RETI4
LABELV $182
endproc PC_Int_Parse 1052 12
export Rect_Parse
proc Rect_Parse 16 8
line 473
;466:}
;467:
;468:/*
;469:=================
;470:Rect_Parse
;471:=================
;472:*/
;473:qboolean Rect_Parse(char **p, rectDef_t *r) {
line 474
;474:	if (Float_Parse(p, &r->x)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $198
line 475
;475:		if (Float_Parse(p, &r->y)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $200
line 476
;476:			if (Float_Parse(p, &r->w)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $202
line 477
;477:				if (Float_Parse(p, &r->h)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $204
line 478
;478:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $197
JUMPV
LABELV $204
line 480
;479:				}
;480:			}
LABELV $202
line 481
;481:		}
LABELV $200
line 482
;482:	}
LABELV $198
line 483
;483:	return qfalse;
CNSTI4 0
RETI4
LABELV $197
endproc Rect_Parse 16 8
export PC_Rect_Parse
proc PC_Rect_Parse 16 8
line 491
;484:}
;485:
;486:/*
;487:=================
;488:PC_Rect_Parse
;489:=================
;490:*/
;491:qboolean PC_Rect_Parse(int handle, rectDef_t *r) {
line 492
;492:	if (PC_Float_Parse(handle, &r->x)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $207
line 493
;493:		if (PC_Float_Parse(handle, &r->y)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $209
line 494
;494:			if (PC_Float_Parse(handle, &r->w)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $211
line 495
;495:				if (PC_Float_Parse(handle, &r->h)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $213
line 496
;496:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $206
JUMPV
LABELV $213
line 498
;497:				}
;498:			}
LABELV $211
line 499
;499:		}
LABELV $209
line 500
;500:	}
LABELV $207
line 501
;501:	return qfalse;
CNSTI4 0
RETI4
LABELV $206
endproc PC_Rect_Parse 16 8
export String_Parse
proc String_Parse 16 8
line 509
;502:}
;503:
;504:/*
;505:=================
;506:String_Parse
;507:=================
;508:*/
;509:qboolean String_Parse(char **p, const char **out) {
line 512
;510:	char *token;
;511:
;512:	token = COM_ParseExt((const char **)p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 513
;513:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $216
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $216
line 514
;514:		*(out) = String_Alloc(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRP4
ASGNP4
line 515
;515:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $215
JUMPV
LABELV $216
line 517
;516:	}
;517:	return qfalse;
CNSTI4 0
RETI4
LABELV $215
endproc String_Parse 16 8
data
align 4
LABELV $219
address $220
export PC_String_Parse
code
proc PC_String_Parse 5152 12
line 526
;518:}
;519:
;520:/*
;521:=================
;522:PC_String_Parse
;523:=================
;524:*/
;525:qboolean PC_String_Parse(int handle, const char **out) 
;526:{
line 530
;527:	static char*	squiggy = "}";
;528:	pc_token_t		token;
;529:
;530:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1040
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $221
line 531
;531:	{
line 532
;532:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $218
JUMPV
LABELV $221
line 535
;533:	}
;534:
;535:	if (token.string[0] == '@')	// Is it a localized text?
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 64
NEI4 $223
line 536
;536:	{
line 539
;537:		char *temp;
;538:		char	text[MAX_STRING_CHARS*4];
;539:		temp = &token.string[0];
ADDRLP4 5140
ADDRLP4 0+16
ASGNP4
line 543
;540:		
;541:									// The +1 is to offset the @ at the beginning of the text
;542://		trap_SP_GetStringTextString(va("%s_%s",stripedFile,(temp+1)), text, sizeof(text));
;543:		trap_SP_GetStringTextString(                        temp+1  , text, sizeof(text));	// findmeste
ADDRLP4 5140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1044
ARGP4
CNSTI4 4096
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 545
;544:
;545:		if (text[0] == 0)		// Couldn't find it
ADDRLP4 1044
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $227
line 546
;546:		{
line 547
;547:			Com_Printf(va(S_COLOR_YELLOW "Unable to locate StripEd text '%s'\n", token.string));
ADDRGP4 $229
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 5144
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 5144
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 548
;548:			*(out) = String_Alloc( token.string );
ADDRLP4 0+16
ARGP4
ADDRLP4 5148
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 5148
INDIRP4
ASGNP4
line 549
;549:		} 
ADDRGP4 $224
JUMPV
LABELV $227
line 551
;550:		else 
;551:		{
line 552
;552:			*(out) = String_Alloc(text);
ADDRLP4 1044
ARGP4
ADDRLP4 5144
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 5144
INDIRP4
ASGNP4
line 553
;553:		}
line 554
;554:	}
ADDRGP4 $224
JUMPV
LABELV $223
line 556
;555:	else
;556:	{
line 558
;557:		// Save some memory by not return the end squiggy as an allocated string
;558:		if ( !Q_stricmp ( token.string, "}" ) )
ADDRLP4 0+16
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $232
line 559
;559:		{
line 560
;560:			*(out) = squiggy;
ADDRFP4 4
INDIRP4
ADDRGP4 $219
INDIRP4
ASGNP4
line 561
;561:		}
ADDRGP4 $233
JUMPV
LABELV $232
line 563
;562:		else
;563:		{
line 564
;564:			*(out) = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1048
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 1048
INDIRP4
ASGNP4
line 565
;565:		}
LABELV $233
line 566
;566:	}
LABELV $224
line 568
;567:
;568:	return qtrue;
CNSTI4 1
RETI4
LABELV $218
endproc PC_String_Parse 5152 12
export PC_Script_Parse
proc PC_Script_Parse 3108 12
line 576
;569:}
;570:
;571:/*
;572:=================
;573:PC_Script_Parse
;574:=================
;575:*/
;576:qboolean PC_Script_Parse(int handle, const char **out) {
line 580
;577:	char script[2048];
;578:	pc_token_t token;
;579:
;580:	script[0] = 0;
ADDRLP4 1040
CNSTI1 0
ASGNI1
line 584
;581:	// scripts start with { and have ; separated command lists.. commands are command, arg.. 
;582:	// basically we want everything between the { } as it will be interpreted at run time
;583:  
;584:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 3088
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 3088
INDIRI4
CNSTI4 0
NEI4 $237
line 585
;585:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $236
JUMPV
LABELV $237
line 586
;586:	if (Q_stricmp(token.string, "{") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $242
ARGP4
ADDRLP4 3092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 3092
INDIRI4
CNSTI4 0
EQI4 $244
line 587
;587:	    return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $236
JUMPV
LABELV $243
line 590
;588:	}
;589:
;590:	while ( 1 ) {
line 591
;591:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 3096
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 3096
INDIRI4
CNSTI4 0
NEI4 $246
line 592
;592:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $236
JUMPV
LABELV $246
line 594
;593:
;594:		if (Q_stricmp(token.string, "}") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 3100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 3100
INDIRI4
CNSTI4 0
NEI4 $248
line 595
;595:			*out = String_Alloc(script);
ADDRLP4 1040
ARGP4
ADDRLP4 3104
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 3104
INDIRP4
ASGNP4
line 596
;596:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $236
JUMPV
LABELV $248
line 599
;597:		}
;598:
;599:		if (token.string[1] != '\0') {
ADDRLP4 0+16+1
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $251
line 600
;600:			Q_strcat(script, 2048, va("\"%s\"", token.string));
ADDRGP4 $255
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 3104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1040
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 3104
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 601
;601:		} else {
ADDRGP4 $252
JUMPV
LABELV $251
line 602
;602:			Q_strcat(script, 2048, token.string);
ADDRLP4 1040
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 0+16
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 603
;603:		}
LABELV $252
line 604
;604:		Q_strcat(script, 2048, " ");
ADDRLP4 1040
ARGP4
CNSTI4 2048
ARGI4
ADDRGP4 $258
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 605
;605:	}
LABELV $244
line 590
ADDRGP4 $243
JUMPV
line 606
;606:	return qfalse; 	// bk001105 - LCC   missing return value
CNSTI4 0
RETI4
LABELV $236
endproc PC_Script_Parse 3108 12
export Init_Display
proc Init_Display 0 0
line 619
;607:}
;608:
;609:// display, window, menu, item code
;610:// 
;611:
;612:/*
;613:==================
;614:Init_Display
;615:
;616:Initializes the display with a structure to all the drawing routines
;617: ==================
;618:*/
;619:void Init_Display(displayContextDef_t *dc) {
line 620
;620:	DC = dc;
ADDRGP4 DC
ADDRFP4 0
INDIRP4
ASGNP4
line 621
;621:}
LABELV $259
endproc Init_Display 0 0
export GradientBar_Paint
proc GradientBar_Paint 12 20
line 627
;622:
;623:
;624:
;625:// type and style painting 
;626:
;627:void GradientBar_Paint(rectDef_t *rect, vec4_t color) {
line 629
;628:	// gradient bar takes two paints
;629:	DC->setColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 630
;630:	DC->drawHandlePic(rect->x, rect->y, rect->w, rect->h, DC->Assets.gradientBar);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
CALLV
pop
line 631
;631:	DC->setColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 632
;632:}
LABELV $260
endproc GradientBar_Paint 12 20
export Window_Init
proc Window_Init 8 12
line 643
;633:
;634:
;635:/*
;636:==================
;637:Window_Init
;638:
;639:Initializes a window structure ( windowDef_t ) with defaults
;640: 
;641:==================
;642:*/
;643:void Window_Init(Window *w) {
line 644
;644:	memset(w, 0, sizeof(windowDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 180
ARGI4
ADDRGP4 memset
CALLP4
pop
line 645
;645:	w->borderSize = 1;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1065353216
ASGNF4
line 646
;646:	w->foreColor[0] = w->foreColor[1] = w->foreColor[2] = w->foreColor[3] = 1.0;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 647
;647:	w->cinematic = -1;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 648
;648:}
LABELV $261
endproc Window_Init 8 12
export Fade
proc Fade 8 0
line 650
;649:
;650:void Fade(int *flags, float *f, float clamp, int *nextTime, int offsetTime, qboolean bFlags, float fadeAmount) {
line 651
;651:  if (*flags & (WINDOW_FADINGOUT | WINDOW_FADINGIN)) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 96
BANDI4
CNSTI4 0
EQI4 $263
line 652
;652:    if (DC->realTime > *nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRFP4 12
INDIRP4
INDIRI4
LEI4 $265
line 653
;653:      *nextTime = DC->realTime + offsetTime;
ADDRFP4 12
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRFP4 16
INDIRI4
ADDI4
ASGNI4
line 654
;654:      if (*flags & WINDOW_FADINGOUT) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $267
line 655
;655:        *f -= fadeAmount;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 24
INDIRF4
SUBF4
ASGNF4
line 656
;656:        if (bFlags && *f <= 0.0) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $268
ADDRFP4 4
INDIRP4
INDIRF4
CNSTF4 0
GTF4 $268
line 657
;657:          *flags &= ~(WINDOW_FADINGOUT | WINDOW_VISIBLE);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -37
BANDI4
ASGNI4
line 658
;658:        }
line 659
;659:      } else {
ADDRGP4 $268
JUMPV
LABELV $267
line 660
;660:        *f += fadeAmount;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 24
INDIRF4
ADDF4
ASGNF4
line 661
;661:        if (*f >= clamp) {
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRF4
LTF4 $271
line 662
;662:          *f = clamp;
ADDRFP4 4
INDIRP4
ADDRFP4 8
INDIRF4
ASGNF4
line 663
;663:          if (bFlags) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $273
line 664
;664:            *flags &= ~WINDOW_FADINGIN;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 665
;665:          }
LABELV $273
line 666
;666:        }
LABELV $271
line 667
;667:      }
LABELV $268
line 668
;668:    }
LABELV $265
line 669
;669:  }
LABELV $263
line 670
;670:}
LABELV $262
endproc Fade 8 0
export Window_Paint
proc Window_Paint 60 28
line 675
;671:
;672:
;673:
;674:void Window_Paint(Window *w, float fadeAmount, float fadeClamp, float fadeCycle) 
;675:{
line 678
;676:	//float bordersize = 0;
;677:	vec4_t color;
;678:	rectDef_t fillRect = w->rect;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 681
;679:
;680:
;681:	if (debugMode) 
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $276
line 682
;682:	{
line 683
;683:		color[0] = color[1] = color[2] = color[3] = 1;
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 16+12
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 32
INDIRF4
ASGNF4
line 684
;684:		DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, 1, color);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 685
;685:	}
LABELV $276
line 687
;686:
;687:	if (w == NULL || (w->style == 0 && w->border == 0)) 
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $283
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $281
ADDRLP4 32
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $281
LABELV $283
line 688
;688:	{
line 689
;689:		return;
ADDRGP4 $275
JUMPV
LABELV $281
line 692
;690:	}
;691:
;692:	if (w->border != 0) 
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $284
line 693
;693:	{
line 694
;694:		fillRect.x += w->borderSize;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 695
;695:		fillRect.y += w->borderSize;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 696
;696:		fillRect.w -= w->borderSize + 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
SUBF4
ASGNF4
line 697
;697:		fillRect.h -= w->borderSize + 1;
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
SUBF4
ASGNF4
line 698
;698:	}
LABELV $284
line 700
;699:
;700:	if (w->style == WINDOW_STYLE_FILLED) 
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 1
NEI4 $289
line 701
;701:	{
line 703
;702:		// box, but possible a shader that needs filled
;703:		if (w->background) 
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $291
line 704
;704:		{
line 705
;705:			Fade(&w->flags, &w->backColor[3], fadeClamp, &w->nextTime, fadeCycle, qtrue, fadeAmount);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 140
ADDP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRFP4 12
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 706
;706:			DC->setColor(w->backColor);
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 707
;707:			DC->drawHandlePic(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->background);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 708
;708:			DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 709
;709:		} 
ADDRGP4 $290
JUMPV
LABELV $291
line 711
;710:		else 
;711:		{
line 712
;712:			DC->fillRect(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->backColor);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 713
;713:		}
line 714
;714:	} 
ADDRGP4 $290
JUMPV
LABELV $289
line 715
;715:	else if (w->style == WINDOW_STYLE_GRADIENT) 
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $299
line 716
;716:	{
line 717
;717:		GradientBar_Paint(&fillRect, w->backColor);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 719
;718:	// gradient bar
;719:	} 
ADDRGP4 $300
JUMPV
LABELV $299
line 720
;720:	else if (w->style == WINDOW_STYLE_SHADER) 
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 3
NEI4 $301
line 721
;721:	{
line 722
;722:		if (w->flags & WINDOW_FORECOLORSET) 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $303
line 723
;723:		{
line 724
;724:			DC->setColor(w->foreColor);
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 725
;725:		}
LABELV $303
line 726
;726:		DC->drawHandlePic(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->background);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 727
;727:		DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 728
;728:	} 
ADDRGP4 $302
JUMPV
LABELV $301
line 729
;729:	else if (w->style == WINDOW_STYLE_TEAMCOLOR) 
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $308
line 730
;730:	{
line 731
;731:		if (DC->getTeamColor) 
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $309
line 732
;732:		{
line 733
;733:			DC->getTeamColor(&color);
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLV
pop
line 734
;734:			DC->fillRect(fillRect.x, fillRect.y, fillRect.w, fillRect.h, color);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 735
;735:		}
line 736
;736:	} 
ADDRGP4 $309
JUMPV
LABELV $308
line 737
;737:	else if (w->style == WINDOW_STYLE_CINEMATIC) 
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $315
line 738
;738:	{
line 739
;739:		if (w->cinematic == -1) 
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $317
line 740
;740:		{
line 741
;741:			w->cinematic = DC->playCinematic(w->cinematicName, fillRect.x, fillRect.y, fillRect.w, fillRect.h);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
CNSTI4 204
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 742
;742:			if (w->cinematic == -1) 
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $322
line 743
;743:			{
line 744
;744:				w->cinematic = -2;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -2
ASGNI4
line 745
;745:			}
LABELV $322
line 746
;746:		} 
LABELV $317
line 747
;747:		if (w->cinematic >= 0) 
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $324
line 748
;748:		{
line 749
;749:			DC->runCinematicFrame(w->cinematic);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 750
;750:			DC->drawCinematic(w->cinematic, fillRect.x, fillRect.y, fillRect.w, fillRect.h);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRP4
CALLV
pop
line 751
;751:		}
LABELV $324
line 752
;752:	}
LABELV $315
LABELV $309
LABELV $302
LABELV $300
LABELV $290
line 754
;753:
;754:	if (w->border == WINDOW_BORDER_FULL) 
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 1
NEI4 $329
line 755
;755:	{
line 758
;756:		// full
;757:		// HACK HACK HACK
;758:		if (w->style == WINDOW_STYLE_TEAMCOLOR) 
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $331
line 759
;759:		{
line 760
;760:			if (color[0] > 0) 
ADDRLP4 16
INDIRF4
CNSTF4 0
LEF4 $333
line 761
;761:			{				
line 763
;762:				// red
;763:				color[0] = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 764
;764:				color[1] = color[2] = .5;
ADDRLP4 40
CNSTF4 1056964608
ASGNF4
ADDRLP4 16+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 40
INDIRF4
ASGNF4
line 765
;765:			} 
ADDRGP4 $334
JUMPV
LABELV $333
line 767
;766:			else 
;767:			{
line 768
;768:				color[2] = 1;
ADDRLP4 16+8
CNSTF4 1065353216
ASGNF4
line 769
;769:				color[0] = color[1] = .5;
ADDRLP4 40
CNSTF4 1056964608
ASGNF4
ADDRLP4 16+4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 40
INDIRF4
ASGNF4
line 770
;770:			}
LABELV $334
line 771
;771:			color[3] = 1;
ADDRLP4 16+12
CNSTF4 1065353216
ASGNF4
line 772
;772:			DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, color);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 773
;773:		} 
ADDRGP4 $330
JUMPV
LABELV $331
line 775
;774:		else 
;775:		{
line 776
;776:			DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, w->borderColor);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 777
;777:		}
line 778
;778:	} 
ADDRGP4 $330
JUMPV
LABELV $329
line 779
;779:	else if (w->border == WINDOW_BORDER_HORZ) 
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 2
NEI4 $340
line 780
;780:	{
line 782
;781:		// top/bottom
;782:		DC->setColor(w->borderColor);
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 783
;783:		DC->drawTopBottom(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 784
;784:		DC->setColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 785
;785:	} 
ADDRGP4 $341
JUMPV
LABELV $340
line 786
;786:	else if (w->border == WINDOW_BORDER_VERT) 
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 3
NEI4 $342
line 787
;787:	{
line 789
;788:		// left right
;789:		DC->setColor(w->borderColor);
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 790
;790:		DC->drawSides(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CALLV
pop
line 791
;791:		DC->setColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 792
;792:	} 
ADDRGP4 $343
JUMPV
LABELV $342
line 793
;793:	else if (w->border == WINDOW_BORDER_KCGRADIENT) 
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 4
NEI4 $344
line 794
;794:	{
line 796
;795:		// this is just two gradient bars along each horz edge
;796:		rectDef_t r = w->rect;
ADDRLP4 40
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 797
;797:		r.h = w->borderSize;
ADDRLP4 40+12
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ASGNF4
line 798
;798:		GradientBar_Paint(&r, w->borderColor);
ADDRLP4 40
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 799
;799:		r.y = w->rect.y + w->rect.h - 1;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40+4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 800
;800:		GradientBar_Paint(&r, w->borderColor);
ADDRLP4 40
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 801
;801:	}
LABELV $344
LABELV $343
LABELV $341
LABELV $330
line 802
;802:}
LABELV $275
endproc Window_Paint 60 28
export Item_SetScreenCoords
proc Item_SetScreenCoords 24 4
line 806
;803:
;804:
;805:void Item_SetScreenCoords(itemDef_t *item, float x, float y) 
;806:{ 
line 807
;807:	if (item == NULL) 
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $349
line 808
;808:	{
line 809
;809:		return;
ADDRGP4 $348
JUMPV
LABELV $349
line 812
;810:	}
;811:
;812:	if (item->window.border != 0) 
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $351
line 813
;813:	{
line 814
;814:		x += item->window.borderSize;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 815
;815:		y += item->window.borderSize;
ADDRFP4 8
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 816
;816:	}
LABELV $351
line 818
;817:
;818:	item->window.rect.x = x + item->window.rectClient.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRFP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDF4
ASGNF4
line 819
;819:	item->window.rect.y = y + item->window.rectClient.y;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 820
;820:	item->window.rect.w = item->window.rectClient.w;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 821
;821:	item->window.rect.h = item->window.rectClient.h;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 824
;822:
;823:	// force the text rects to recompute
;824:	item->textRect.w = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 0
ASGNF4
line 825
;825:	item->textRect.h = 0;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
line 827
;826:
;827:	switch ( item->type)
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 14
EQI4 $356
ADDRGP4 $353
JUMPV
line 828
;828:	{
LABELV $356
line 830
;829:		case ITEM_TYPE_TEXTSCROLL:
;830:		{
line 831
;831:			textScrollDef_t *scrollPtr = (textScrollDef_t*)item->typeData;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 832
;832:			if ( scrollPtr )
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $357
line 833
;833:			{
line 834
;834:				scrollPtr->startPos = 0;
ADDRLP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 835
;835:				scrollPtr->endPos = 0;
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 836
;836:			}
LABELV $357
line 838
;837:
;838:			Item_TextScroll_BuildLines ( item );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_TextScroll_BuildLines
CALLV
pop
line 840
;839:
;840:			break;
LABELV $353
LABELV $354
line 843
;841:		}
;842:	}
;843:}
LABELV $348
endproc Item_SetScreenCoords 24 4
export Item_UpdatePosition
proc Item_UpdatePosition 20 12
line 846
;844:
;845:// FIXME: consolidate this with nearby stuff
;846:void Item_UpdatePosition(itemDef_t *item) {
line 850
;847:  float x, y;
;848:  menuDef_t *menu;
;849:  
;850:  if (item == NULL || item->parent == NULL) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $362
ADDRLP4 12
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
NEU4 $360
LABELV $362
line 851
;851:    return;
ADDRGP4 $359
JUMPV
LABELV $360
line 854
;852:  }
;853:
;854:  menu = item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 856
;855:
;856:  x = menu->window.rect.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
line 857
;857:  y = menu->window.rect.y;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 859
;858:  
;859:  if (menu->window.border != 0) {
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $363
line 860
;860:    x += menu->window.borderSize;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 861
;861:    y += menu->window.borderSize;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 862
;862:  }
LABELV $363
line 864
;863:
;864:  Item_SetScreenCoords(item, x, y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 Item_SetScreenCoords
CALLV
pop
line 866
;865:
;866:}
LABELV $359
endproc Item_UpdatePosition 20 12
export Menu_UpdatePosition
proc Menu_UpdatePosition 12 12
line 869
;867:
;868:// menus
;869:void Menu_UpdatePosition(menuDef_t *menu) {
line 873
;870:  int i;
;871:  float x, y;
;872:
;873:  if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $366
line 874
;874:    return;
ADDRGP4 $365
JUMPV
LABELV $366
line 877
;875:  }
;876:  
;877:  x = menu->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 878
;878:  y = menu->window.rect.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 879
;879:  if (menu->window.border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $368
line 880
;880:    x += menu->window.borderSize;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 881
;881:    y += menu->window.borderSize;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 882
;882:  }
LABELV $368
line 884
;883:
;884:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $373
JUMPV
LABELV $370
line 885
;885:    Item_SetScreenCoords(menu->items[i], x, y);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 Item_SetScreenCoords
CALLV
pop
line 886
;886:  }
LABELV $371
line 884
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $373
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $370
line 887
;887:}
LABELV $365
endproc Menu_UpdatePosition 12 12
export Menu_PostParse
proc Menu_PostParse 0 4
line 889
;888:
;889:void Menu_PostParse(menuDef_t *menu) {
line 890
;890:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $375
line 891
;891:		return;
ADDRGP4 $374
JUMPV
LABELV $375
line 893
;892:	}
;893:	if (menu->fullScreen) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $377
line 894
;894:		menu->window.rect.x = 0;
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 895
;895:		menu->window.rect.y = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 896
;896:		menu->window.rect.w = 640;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1142947840
ASGNF4
line 897
;897:		menu->window.rect.h = 480;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1139802112
ASGNF4
line 898
;898:	}
LABELV $377
line 899
;899:	Menu_UpdatePosition(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_UpdatePosition
CALLV
pop
line 900
;900:}
LABELV $374
endproc Menu_PostParse 0 4
export Menu_ClearFocus
proc Menu_ClearFocus 20 8
line 902
;901:
;902:itemDef_t *Menu_ClearFocus(menuDef_t *menu) {
line 904
;903:  int i;
;904:  itemDef_t *ret = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 906
;905:
;906:  if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $380
line 907
;907:    return NULL;
CNSTP4 0
RETP4
ADDRGP4 $379
JUMPV
LABELV $380
line 910
;908:  }
;909:
;910:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $385
JUMPV
LABELV $382
line 911
;911:    if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 8
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
BANDI4
CNSTI4 0
EQI4 $386
line 912
;912:      ret = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 913
;913:    } 
LABELV $386
line 914
;914:    menu->items[i]->window.flags &= ~WINDOW_HASFOCUS;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 915
;915:    if (menu->items[i]->leaveFocus) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $388
line 916
;916:      Item_RunScript(menu->items[i], menu->items[i]->leaveFocus);
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 917
;917:    }
LABELV $388
line 918
;918:  }
LABELV $383
line 910
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $385
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $382
line 920
;919: 
;920:  return ret;
ADDRLP4 4
INDIRP4
RETP4
LABELV $379
endproc Menu_ClearFocus 20 8
export IsVisible
proc IsVisible 12 0
line 923
;921:}
;922:
;923:qboolean IsVisible(int flags) {
line 924
;924:  return (flags & WINDOW_VISIBLE && !(flags & WINDOW_FADINGOUT));
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $392
ADDRLP4 4
INDIRI4
CNSTI4 32
BANDI4
ADDRLP4 8
INDIRI4
NEI4 $392
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $393
JUMPV
LABELV $392
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $393
ADDRLP4 0
INDIRI4
RETI4
LABELV $390
endproc IsVisible 12 0
export Rect_ContainsPoint
proc Rect_ContainsPoint 20 0
line 927
;925:}
;926:
;927:qboolean Rect_ContainsPoint(rectDef_t *rect, float x, float y) {
line 928
;928:  if (rect) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $395
line 929
;929:    if (x > rect->x && x < rect->x + rect->w && y > rect->y && y < rect->y + rect->h) {
ADDRLP4 0
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $397
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
GEF4 $397
ADDRLP4 12
ADDRFP4 8
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $397
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
GEF4 $397
line 930
;930:      return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $394
JUMPV
LABELV $397
line 932
;931:    }
;932:  }
LABELV $395
line 933
;933:  return qfalse;
CNSTI4 0
RETI4
LABELV $394
endproc Rect_ContainsPoint 20 0
export Menu_ItemsMatchingGroup
proc Menu_ItemsMatchingGroup 20 8
line 936
;934:}
;935:
;936:int Menu_ItemsMatchingGroup(menuDef_t *menu, const char *name) {
line 938
;937:  int i;
;938:  int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 939
;939:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $403
JUMPV
LABELV $400
line 940
;940:    if (Q_stricmp(menu->items[i]->window.name, name) == 0 || (menu->items[i]->window.group && Q_stricmp(menu->items[i]->window.group, name) == 0)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $406
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $404
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $404
LABELV $406
line 941
;941:      count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 942
;942:    } 
LABELV $404
line 943
;943:  }
LABELV $401
line 939
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $403
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $400
line 944
;944:  return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $399
endproc Menu_ItemsMatchingGroup 20 8
export Menu_GetMatchingItemByNumber
proc Menu_GetMatchingItemByNumber 20 8
line 947
;945:}
;946:
;947:itemDef_t *Menu_GetMatchingItemByNumber(menuDef_t *menu, int index, const char *name) {
line 949
;948:  int i;
;949:  int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 950
;950:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $411
JUMPV
LABELV $408
line 951
;951:    if (Q_stricmp(menu->items[i]->window.name, name) == 0 || (menu->items[i]->window.group && Q_stricmp(menu->items[i]->window.group, name) == 0)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $414
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $412
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $412
LABELV $414
line 952
;952:      if (count == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $415
line 953
;953:        return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $407
JUMPV
LABELV $415
line 955
;954:      }
;955:      count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 956
;956:    } 
LABELV $412
line 957
;957:  }
LABELV $409
line 950
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $411
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $408
line 958
;958:  return NULL;
CNSTP4 0
RETP4
LABELV $407
endproc Menu_GetMatchingItemByNumber 20 8
export Script_SetColor
proc Script_SetColor 36 8
line 962
;959:}
;960:
;961:qboolean Script_SetColor ( itemDef_t *item, char **args ) 
;962:{
line 969
;963:	const char *name;
;964:	int i;
;965:	float f;
;966:	vec4_t *out;
;967:	
;968:	// expecting type of color to set and 4 args for the color
;969:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $418
line 970
;970:	{
line 971
;971:		out = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 972
;972:		if (Q_stricmp(name, "backcolor") == 0) 
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $422
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $420
line 973
;973:		{
line 974
;974:			out = &item->window.backColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ASGNP4
line 975
;975:			item->window.flags |= WINDOW_BACKCOLORSET;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 4194304
BORI4
ASGNI4
line 976
;976:		} 
ADDRGP4 $421
JUMPV
LABELV $420
line 977
;977:		else if (Q_stricmp(name, "forecolor") == 0) 
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $425
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $423
line 978
;978:		{
line 979
;979:			out = &item->window.foreColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
line 980
;980:			item->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 981
;981:		} 
ADDRGP4 $424
JUMPV
LABELV $423
line 982
;982:		else if (Q_stricmp(name, "bordercolor") == 0) 
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $428
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $426
line 983
;983:		{
line 984
;984:			out = &item->window.borderColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ASGNP4
line 985
;985:		}
LABELV $426
LABELV $424
LABELV $421
line 987
;986:
;987:		if (out) 
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $429
line 988
;988:		{
line 989
;989:			for (i = 0; i < 4; i++) 
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $431
line 990
;990:			{
line 991
;991:				if (!Float_Parse(args, &f)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $435
line 992
;992:				{
line 993
;993:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $417
JUMPV
LABELV $435
line 995
;994:				}
;995:			(*out)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 996
;996:			}
LABELV $432
line 989
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $431
line 997
;997:		}
LABELV $429
line 998
;998:	}
LABELV $418
line 1000
;999:
;1000:	return qtrue;
CNSTI4 1
RETI4
LABELV $417
endproc Script_SetColor 36 8
export Script_SetAsset
proc Script_SetAsset 8 8
line 1004
;1001:}
;1002:
;1003:qboolean Script_SetAsset(itemDef_t *item, char **args) 
;1004:{
line 1007
;1005:	const char *name;
;1006:	// expecting name to set asset to
;1007:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $438
line 1008
;1008:	{
line 1010
;1009:		// check for a model 
;1010:		if (item->type == ITEM_TYPE_MODEL) 
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 7
NEI4 $440
line 1011
;1011:		{
line 1012
;1012:		}
LABELV $440
line 1013
;1013:	}
LABELV $438
line 1014
;1014:	return qtrue;
CNSTI4 1
RETI4
LABELV $437
endproc Script_SetAsset 8 8
export Script_SetBackground
proc Script_SetBackground 12 8
line 1018
;1015:}
;1016:
;1017:qboolean Script_SetBackground(itemDef_t *item, char **args) 
;1018:{
line 1021
;1019:	const char *name;
;1020:	// expecting name to set asset to
;1021:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $443
line 1022
;1022:	{
line 1023
;1023:		item->window.background = DC->registerShaderNoMip(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1024
;1024:	}
LABELV $443
line 1025
;1025:	return qtrue;
CNSTI4 1
RETI4
LABELV $442
endproc Script_SetBackground 12 8
export Menu_FindItemByName
proc Menu_FindItemByName 12 8
line 1029
;1026:}
;1027:
;1028:
;1029:itemDef_t *Menu_FindItemByName(menuDef_t *menu, const char *p) {
line 1031
;1030:  int i;
;1031:  if (menu == NULL || p == NULL) {
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $448
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
NEU4 $446
LABELV $448
line 1032
;1032:    return NULL;
CNSTP4 0
RETP4
ADDRGP4 $445
JUMPV
LABELV $446
line 1035
;1033:  }
;1034:
;1035:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $452
JUMPV
LABELV $449
line 1036
;1036:    if (Q_stricmp(p, menu->items[i]->window.name) == 0) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $453
line 1037
;1037:      return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $445
JUMPV
LABELV $453
line 1039
;1038:    }
;1039:  }
LABELV $450
line 1035
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $452
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $449
line 1041
;1040:
;1041:  return NULL;
CNSTP4 0
RETP4
LABELV $445
endproc Menu_FindItemByName 12 8
export Script_SetTeamColor
proc Script_SetTeamColor 24 4
line 1045
;1042:}
;1043:
;1044:qboolean Script_SetTeamColor(itemDef_t *item, char **args) 
;1045:{
line 1046
;1046:	if (DC->getTeamColor) 
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $456
line 1047
;1047:	{
line 1050
;1048:		int i;
;1049:		vec4_t color;
;1050:		DC->getTeamColor(&color);
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLV
pop
line 1051
;1051:		for (i = 0; i < 4; i++) 
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $458
line 1052
;1052:		{
line 1053
;1053:			item->window.backColor[i] = color[i];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 20
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 1054
;1054:		}
LABELV $459
line 1051
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $458
line 1055
;1055:	}
LABELV $456
line 1056
;1056:	return qtrue;
CNSTI4 1
RETI4
LABELV $455
endproc Script_SetTeamColor 24 4
export Script_SetItemColor
proc Script_SetItemColor 80 12
line 1060
;1057:}
;1058:
;1059:qboolean Script_SetItemColor(itemDef_t *item, char **args) 
;1060:{
line 1068
;1061:	const char *itemname;
;1062:	const char *name;
;1063:	vec4_t color;
;1064:	int i;
;1065:	vec4_t *out;
;1066:
;1067:	// expecting type of color to set and 4 args for the color
;1068:	if (String_Parse(args, &itemname) && String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 32
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $463
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 36
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $463
line 1069
;1069:	{
line 1072
;1070:		itemDef_t	*item2;
;1071:		int			j;
;1072:		int			count = Menu_ItemsMatchingGroup(item->parent, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 52
INDIRI4
ASGNI4
line 1074
;1073:
;1074:		if (!Color_Parse(args, &color)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 56
ADDRGP4 Color_Parse
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $465
line 1075
;1075:		{
line 1076
;1076:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $462
JUMPV
LABELV $465
line 1079
;1077:		}
;1078:
;1079:		for (j = 0; j < count; j++) 
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $470
JUMPV
LABELV $467
line 1080
;1080:		{
line 1081
;1081:			item2 = Menu_GetMatchingItemByNumber(item->parent, j, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 60
INDIRP4
ASGNP4
line 1082
;1082:			if (item2 != NULL) 
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $471
line 1083
;1083:			{
line 1084
;1084:				out = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 1085
;1085:				if (Q_stricmp(name, "backcolor") == 0) 
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $422
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $473
line 1086
;1086:				{
line 1087
;1087:					out = &item2->window.backColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 128
ADDP4
ASGNP4
line 1088
;1088:				} 
ADDRGP4 $474
JUMPV
LABELV $473
line 1089
;1089:				else if (Q_stricmp(name, "forecolor") == 0) 
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $425
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $475
line 1090
;1090:				{
line 1091
;1091:					out = &item2->window.foreColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
line 1092
;1092:					item2->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 72
ADDRLP4 44
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 1093
;1093:				} 
ADDRGP4 $476
JUMPV
LABELV $475
line 1094
;1094:				else if (Q_stricmp(name, "bordercolor") == 0) 
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $428
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $477
line 1095
;1095:				{
line 1096
;1096:					out = &item2->window.borderColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 144
ADDP4
ASGNP4
line 1097
;1097:				}
LABELV $477
LABELV $476
LABELV $474
line 1099
;1098:
;1099:				if (out) 
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $479
line 1100
;1100:				{
line 1101
;1101:					for (i = 0; i < 4; i++) 
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $481
line 1102
;1102:					{
line 1103
;1103:						(*out)[i] = color[i];
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 76
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 76
INDIRI4
ADDRLP4 8
ADDP4
INDIRF4
ASGNF4
line 1104
;1104:					}
LABELV $482
line 1101
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $481
line 1105
;1105:				}
LABELV $479
line 1106
;1106:			}
LABELV $471
line 1107
;1107:		}
LABELV $468
line 1079
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $470
ADDRLP4 40
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $467
line 1108
;1108:	}
LABELV $463
line 1110
;1109:
;1110:	return qtrue;
CNSTI4 1
RETI4
LABELV $462
endproc Script_SetItemColor 80 12
export Script_SetItemRect
proc Script_SetItemRect 52 12
line 1114
;1111:}
;1112:
;1113:qboolean Script_SetItemRect(itemDef_t *item, char **args) 
;1114:{
line 1120
;1115:	const char *itemname;
;1116:	rectDef_t *out;
;1117:	rectDef_t rect;
;1118:
;1119:	// expecting type of color to set and 4 args for the color
;1120:	if (String_Parse(args, &itemname)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $486
line 1121
;1121:	{
line 1124
;1122:		itemDef_t *item2;
;1123:		int j;
;1124:		int count = Menu_ItemsMatchingGroup(item->parent, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
line 1126
;1125:
;1126:		if (!Rect_Parse(args, &rect)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRGP4 Rect_Parse
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $488
line 1127
;1127:		{
line 1128
;1128:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $485
JUMPV
LABELV $488
line 1131
;1129:		}
;1130:
;1131:		for (j = 0; j < count; j++) 
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $493
JUMPV
LABELV $490
line 1132
;1132:		{
line 1133
;1133:			item2 = Menu_GetMatchingItemByNumber(item->parent, j, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 48
INDIRP4
ASGNP4
line 1134
;1134:			if (item2 != NULL) 
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $494
line 1135
;1135:			{
line 1136
;1136:				out = &item2->window.rect;
ADDRLP4 20
ADDRLP4 28
INDIRP4
ASGNP4
line 1138
;1137:
;1138:				if (out) 
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $496
line 1139
;1139:				{
line 1140
;1140:					item2->window.rect.x = rect.x;
ADDRLP4 28
INDIRP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1141
;1141:					item2->window.rect.y = rect.y;
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4+4
INDIRF4
ASGNF4
line 1142
;1142:					item2->window.rect.w = rect.w;
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4+8
INDIRF4
ASGNF4
line 1143
;1143:					item2->window.rect.h = rect.h;					
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4+12
INDIRF4
ASGNF4
line 1144
;1144:				}
LABELV $496
line 1145
;1145:			}
LABELV $494
line 1146
;1146:		}
LABELV $491
line 1131
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $493
ADDRLP4 32
INDIRI4
ADDRLP4 36
INDIRI4
LTI4 $490
line 1147
;1147:	}
LABELV $486
line 1148
;1148:	return qtrue;
CNSTI4 1
RETI4
LABELV $485
endproc Script_SetItemRect 52 12
export Menu_ShowItemByName
proc Menu_ShowItemByName 24 12
line 1152
;1149:}
;1150:
;1151:
;1152:void Menu_ShowItemByName(menuDef_t *menu, const char *p, qboolean bShow) {
line 1155
;1153:	itemDef_t *item;
;1154:	int i;
;1155:	int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1156
;1156:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $505
JUMPV
LABELV $502
line 1157
;1157:		item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1158
;1158:		if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $506
line 1159
;1159:			if (bShow) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $508
line 1160
;1160:				item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 1161
;1161:			} else {
ADDRGP4 $509
JUMPV
LABELV $508
line 1162
;1162:				item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 1164
;1163:				// stop cinematics playing in the window
;1164:				if (item->window.cinematic >= 0) {
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $510
line 1165
;1165:					DC->stopCinematic(item->window.cinematic);
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRP4
CALLV
pop
line 1166
;1166:					item->window.cinematic = -1;
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 1167
;1167:				}
LABELV $510
line 1168
;1168:			}
LABELV $509
line 1169
;1169:		}
LABELV $506
line 1170
;1170:	}
LABELV $503
line 1156
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $505
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $502
line 1171
;1171:}
LABELV $501
endproc Menu_ShowItemByName 24 12
export Menu_FadeItemByName
proc Menu_FadeItemByName 32 12
line 1173
;1172:
;1173:void Menu_FadeItemByName(menuDef_t *menu, const char *p, qboolean fadeOut) {
line 1176
;1174:  itemDef_t *item;
;1175:  int i;
;1176:  int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1177
;1177:  for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $516
JUMPV
LABELV $513
line 1178
;1178:    item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1179
;1179:    if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $517
line 1180
;1180:      if (fadeOut) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $519
line 1181
;1181:        item->window.flags |= (WINDOW_FADINGOUT | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 36
BORI4
ASGNI4
line 1182
;1182:        item->window.flags &= ~WINDOW_FADINGIN;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 1183
;1183:      } else {
ADDRGP4 $520
JUMPV
LABELV $519
line 1184
;1184:        item->window.flags |= (WINDOW_VISIBLE | WINDOW_FADINGIN);
ADDRLP4 20
CNSTI4 68
ASGNI4
ADDRLP4 24
ADDRLP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
ADDRLP4 20
INDIRI4
BORI4
ASGNI4
line 1185
;1185:        item->window.flags &= ~WINDOW_FADINGOUT;
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 1186
;1186:      }
LABELV $520
line 1187
;1187:    }
LABELV $517
line 1188
;1188:  }
LABELV $514
line 1177
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $516
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $513
line 1189
;1189:}
LABELV $512
endproc Menu_FadeItemByName 32 12
export Menus_FindByName
proc Menus_FindByName 8 8
line 1191
;1190:
;1191:menuDef_t *Menus_FindByName(const char *p) {
line 1193
;1192:  int i;
;1193:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $525
JUMPV
LABELV $522
line 1194
;1194:    if (Q_stricmp(Menus[i].window.name, p) == 0) {
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+32
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $526
line 1195
;1195:      return &Menus[i];
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $521
JUMPV
LABELV $526
line 1197
;1196:    } 
;1197:  }
LABELV $523
line 1193
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $525
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $522
line 1198
;1198:  return NULL;
CNSTP4 0
RETP4
LABELV $521
endproc Menus_FindByName 8 8
export Menus_ShowByName
proc Menus_ShowByName 8 4
line 1201
;1199:}
;1200:
;1201:void Menus_ShowByName(const char *p) {
line 1202
;1202:	menuDef_t *menu = Menus_FindByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1203
;1203:	if (menu) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $530
line 1204
;1204:		Menus_Activate(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 1205
;1205:	}
LABELV $530
line 1206
;1206:}
LABELV $529
endproc Menus_ShowByName 8 4
export Menus_OpenByName
proc Menus_OpenByName 0 4
line 1208
;1207:
;1208:void Menus_OpenByName(const char *p) {
line 1209
;1209:  Menus_ActivateByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 1210
;1210:}
LABELV $532
endproc Menus_OpenByName 0 4
proc Menu_RunCloseScript 572 8
line 1212
;1211:
;1212:static void Menu_RunCloseScript(menuDef_t *menu) {
line 1213
;1213:	if (menu && menu->window.flags & WINDOW_VISIBLE && menu->onClose) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $534
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $534
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $534
line 1215
;1214:		itemDef_t item;
;1215:    item.parent = menu;
ADDRLP4 8+240
ADDRFP4 0
INDIRP4
ASGNP4
line 1216
;1216:    Item_RunScript(&item, menu->onClose);
ADDRLP4 8
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1217
;1217:	}
LABELV $534
line 1218
;1218:}
LABELV $533
endproc Menu_RunCloseScript 572 8
export Menus_CloseByName
proc Menus_CloseByName 20 4
line 1221
;1219:
;1220:void Menus_CloseByName ( const char *p )
;1221:{
line 1222
;1222:	menuDef_t *menu = Menus_FindByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1225
;1223:	
;1224:	// If the menu wasnt found just exit
;1225:	if (menu == NULL) 
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $538
line 1226
;1226:	{
line 1227
;1227:		return;
ADDRGP4 $537
JUMPV
LABELV $538
line 1231
;1228:	}
;1229:
;1230:	// Run the close script for the menu
;1231:	Menu_RunCloseScript(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 1234
;1232:
;1233:	// If this window had the focus then take it away
;1234:	if ( menu->window.flags & WINDOW_HASFOCUS )
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $540
line 1235
;1235:	{	
line 1238
;1236:		// If there is something still in the open menu list then
;1237:		// set it to have focus now
;1238:		if ( openMenuCount )
ADDRGP4 openMenuCount
INDIRI4
CNSTI4 0
EQI4 $542
line 1239
;1239:		{
line 1242
;1240:			// Subtract one from the open menu count to prepare to
;1241:			// remove the top menu from the list
;1242:			openMenuCount -= 1;
ADDRLP4 8
ADDRGP4 openMenuCount
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1245
;1243:
;1244:			// Set the top menu to have focus now
;1245:			menuStack[openMenuCount]->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 16
ADDRGP4 openMenuCount
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRGP4 menuStack
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
BORI4
ASGNI4
line 1248
;1246:
;1247:			// Remove the top menu from the list
;1248:			menuStack[openMenuCount] = NULL;
ADDRGP4 openMenuCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 menuStack
ADDP4
CNSTP4 0
ASGNP4
line 1249
;1249:		}
LABELV $542
line 1250
;1250:	}
LABELV $540
line 1253
;1251:
;1252:	// Window is now invisible and doenst have focus
;1253:	menu->window.flags &= ~(WINDOW_VISIBLE | WINDOW_HASFOCUS);
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 1254
;1254:}
LABELV $537
endproc Menus_CloseByName 20 4
data
export FPMessageTime
align 4
LABELV FPMessageTime
byte 4 0
export Menus_CloseAll
code
proc Menus_CloseAll 8 4
line 1259
;1255:
;1256:int FPMessageTime = 0;
;1257:
;1258:void Menus_CloseAll() 
;1259:{
line 1262
;1260:	int i;
;1261:	
;1262:	g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 1264
;1263:	
;1264:	for (i = 0; i < menuCount; i++) 
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $548
JUMPV
LABELV $545
line 1265
;1265:	{
line 1266
;1266:		Menu_RunCloseScript ( &Menus[i] );
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 1267
;1267:		Menus[i].window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 4
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 1268
;1268:	}
LABELV $546
line 1264
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $548
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $545
line 1271
;1269:
;1270:	// Clear the menu stack
;1271:	openMenuCount = 0;
ADDRGP4 openMenuCount
CNSTI4 0
ASGNI4
line 1273
;1272:
;1273:	FPMessageTime = 0;
ADDRGP4 FPMessageTime
CNSTI4 0
ASGNI4
line 1274
;1274:}
LABELV $544
endproc Menus_CloseAll 8 4
export Script_Show
proc Script_Show 8 12
line 1277
;1275:
;1276:qboolean Script_Show(itemDef_t *item, char **args) 
;1277:{
line 1279
;1278:	const char *name;
;1279:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $551
line 1280
;1280:	{
line 1281
;1281:		Menu_ShowItemByName(item->parent, name, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1282
;1282:	}
LABELV $551
line 1283
;1283:	return qtrue;
CNSTI4 1
RETI4
LABELV $550
endproc Script_Show 8 12
export Script_Hide
proc Script_Hide 8 12
line 1287
;1284:}
;1285:
;1286:qboolean Script_Hide(itemDef_t *item, char **args) 
;1287:{
line 1289
;1288:	const char *name;
;1289:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $554
line 1290
;1290:	{
line 1291
;1291:		Menu_ShowItemByName(item->parent, name, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1292
;1292:	}
LABELV $554
line 1293
;1293:	return qtrue;
CNSTI4 1
RETI4
LABELV $553
endproc Script_Hide 8 12
export Script_FadeIn
proc Script_FadeIn 8 12
line 1297
;1294:}
;1295:
;1296:qboolean Script_FadeIn(itemDef_t *item, char **args) 
;1297:{
line 1299
;1298:	const char *name;
;1299:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $557
line 1300
;1300:	{
line 1301
;1301:		Menu_FadeItemByName(item->parent, name, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_FadeItemByName
CALLV
pop
line 1302
;1302:	}
LABELV $557
line 1304
;1303:
;1304:	return qtrue;
CNSTI4 1
RETI4
LABELV $556
endproc Script_FadeIn 8 12
export Script_FadeOut
proc Script_FadeOut 8 12
line 1308
;1305:}
;1306:
;1307:qboolean Script_FadeOut(itemDef_t *item, char **args) 
;1308:{
line 1310
;1309:	const char *name;
;1310:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $560
line 1311
;1311:	{
line 1312
;1312:		Menu_FadeItemByName(item->parent, name, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_FadeItemByName
CALLV
pop
line 1313
;1313:	}
LABELV $560
line 1314
;1314:	return qtrue;
CNSTI4 1
RETI4
LABELV $559
endproc Script_FadeOut 8 12
export Script_Open
proc Script_Open 8 8
line 1318
;1315:}
;1316:
;1317:qboolean Script_Open(itemDef_t *item, char **args) 
;1318:{
line 1320
;1319:	const char *name;
;1320:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $563
line 1321
;1321:	{
line 1322
;1322:		Menus_OpenByName(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1323
;1323:	}
LABELV $563
line 1324
;1324:	return qtrue;
CNSTI4 1
RETI4
LABELV $562
endproc Script_Open 8 8
export Script_Close
proc Script_Close 12 8
line 1328
;1325:}
;1326:
;1327:qboolean Script_Close(itemDef_t *item, char **args) 
;1328:{
line 1330
;1329:	const char *name;
;1330:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $566
line 1331
;1331:	{
line 1332
;1332:		if (Q_stricmp(name, "all") == 0)
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $570
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $568
line 1333
;1333:		{
line 1334
;1334:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 1335
;1335:		}
ADDRGP4 $569
JUMPV
LABELV $568
line 1337
;1336:		else
;1337:		{
line 1338
;1338:			Menus_CloseByName(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 1339
;1339:		}
LABELV $569
line 1340
;1340:	}
LABELV $566
line 1341
;1341:	return qtrue;
CNSTI4 1
RETI4
LABELV $565
endproc Script_Close 12 8
export Menu_TransitionItemByName
proc Menu_TransitionItemByName 56 12
line 1344
;1342:}
;1343:
;1344:void Menu_TransitionItemByName(menuDef_t *menu, const char *p, rectDef_t rectFrom, rectDef_t rectTo, int time, float amt) {
line 1347
;1345:  itemDef_t *item;
;1346:  int i;
;1347:  int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1348
;1348:  for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $575
JUMPV
LABELV $572
line 1349
;1349:    item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1350
;1350:    if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $576
line 1351
;1351:      item->window.flags |= (WINDOW_INTRANSITION | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 260
BORI4
ASGNI4
line 1352
;1352:      item->window.offsetTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 1353
;1353:			memcpy(&item->window.rectClient, &rectFrom, sizeof(rectDef_t));
ADDRLP4 24
CNSTI4 16
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1354
;1354:			memcpy(&item->window.rectEffects, &rectTo, sizeof(rectDef_t));
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1355
;1355:			item->window.rectEffects2.x = abs(rectTo.x - rectFrom.x) / amt;
ADDRFP4 12
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 28
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1356
;1356:			item->window.rectEffects2.y = abs(rectTo.y - rectFrom.y) / amt;
ADDRLP4 32
CNSTI4 4
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 36
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1357
;1357:			item->window.rectEffects2.w = abs(rectTo.w - rectFrom.w) / amt;
ADDRLP4 40
CNSTI4 8
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 44
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 44
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1358
;1358:			item->window.rectEffects2.h = abs(rectTo.h - rectFrom.h) / amt;
ADDRLP4 48
CNSTI4 12
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 52
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRLP4 52
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1359
;1359:      Item_UpdatePosition(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 1360
;1360:    }
LABELV $576
line 1361
;1361:  }
LABELV $573
line 1348
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $575
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $572
line 1362
;1362:}
LABELV $571
endproc Menu_TransitionItemByName 56 12
data
export ui_deferredScriptItem
align 4
LABELV ui_deferredScriptItem
byte 4 0
export Script_Defer
code
proc Script_Defer 4 12
line 1378
;1363:
;1364:#define MAX_DEFERRED_SCRIPT		2048
;1365:
;1366:char		ui_deferredScript [ MAX_DEFERRED_SCRIPT ];
;1367:itemDef_t*	ui_deferredScriptItem = NULL;
;1368:
;1369:/*
;1370:=================
;1371:Script_Defer
;1372:
;1373:Defers the rest of the script based on the defer condition.  The deferred
;1374:portion of the script can later be run with the "rundeferred"
;1375:=================
;1376:*/
;1377:qboolean Script_Defer ( itemDef_t* item, char **args )
;1378:{
line 1380
;1379:	// Should the script be deferred?
;1380:	if ( DC->deferScript ( (char**)args ) )
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $579
line 1381
;1381:	{
line 1383
;1382:		// Need the item the script was being run on
;1383:		ui_deferredScriptItem = item;
ADDRGP4 ui_deferredScriptItem
ADDRFP4 0
INDIRP4
ASGNP4
line 1386
;1384:
;1385:		// Save the rest of the script
;1386:		Q_strncpyz ( ui_deferredScript, *args, MAX_DEFERRED_SCRIPT );
ADDRGP4 ui_deferredScript
ARGP4
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
CNSTI4 2048
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1389
;1387:
;1388:		// No more running
;1389:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $578
JUMPV
LABELV $579
line 1393
;1390:	}
;1391:
;1392:	// Keep running the script, its ok
;1393:	return qtrue;
CNSTI4 1
RETI4
LABELV $578
endproc Script_Defer 4 12
export Script_RunDeferred
proc Script_RunDeferred 0 8
line 1405
;1394:}
;1395:
;1396:/*
;1397:=================
;1398:Script_RunDeferred
;1399:
;1400:Runs the last deferred script, there can only be one script deferred at a 
;1401:time so be careful of recursion
;1402:=================
;1403:*/
;1404:qboolean Script_RunDeferred ( itemDef_t* item, char **args )
;1405:{
line 1407
;1406:	// Make sure there is something to run.
;1407:	if ( !ui_deferredScript[0] || !ui_deferredScriptItem )
ADDRGP4 ui_deferredScript
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $584
ADDRGP4 ui_deferredScriptItem
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $582
LABELV $584
line 1408
;1408:	{
line 1409
;1409:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $581
JUMPV
LABELV $582
line 1413
;1410:	}
;1411:
;1412:	// Run the deferred script now
;1413:	Item_RunScript ( ui_deferredScriptItem, ui_deferredScript );
ADDRGP4 ui_deferredScriptItem
INDIRP4
ARGP4
ADDRGP4 ui_deferredScript
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1415
;1414:
;1415:	return qtrue;
CNSTI4 1
RETI4
LABELV $581
endproc Script_RunDeferred 0 8
export Script_Transition
proc Script_Transition 96 24
line 1419
;1416:}
;1417:
;1418:qboolean Script_Transition(itemDef_t *item, char **args) 
;1419:{
line 1425
;1420:	const char *name;
;1421:	rectDef_t rectFrom, rectTo;
;1422:	int time;
;1423:	float amt;
;1424:
;1425:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $586
line 1426
;1426:	{
line 1427
;1427:	    if ( Rect_Parse(args, &rectFrom) && Rect_Parse(args, &rectTo) && Int_Parse(args, &time) && Float_Parse(args, &amt)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 48
ADDRGP4 Rect_Parse
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $588
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 52
ADDRGP4 Rect_Parse
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $588
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 56
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $588
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 60
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $588
line 1428
;1428:		{
line 1429
;1429:			Menu_TransitionItemByName(item->parent, name, rectFrom, rectTo, time, amt);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRLP4 4
INDIRB
ASGNB 16
ADDRLP4 64
ARGP4
ADDRLP4 80
ADDRLP4 20
INDIRB
ASGNB 16
ADDRLP4 80
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 Menu_TransitionItemByName
CALLV
pop
line 1430
;1430:		}
LABELV $588
line 1431
;1431:	}
LABELV $586
line 1433
;1432:
;1433:	return qtrue;
CNSTI4 1
RETI4
LABELV $585
endproc Script_Transition 96 24
export Menu_OrbitItemByName
proc Menu_OrbitItemByName 24 12
line 1437
;1434:}
;1435:
;1436:void Menu_OrbitItemByName(menuDef_t *menu, const char *p, float x, float y, float cx, float cy, int time) 
;1437:{
line 1440
;1438:  itemDef_t *item;
;1439:  int i;
;1440:  int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1441
;1441:  for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $594
JUMPV
LABELV $591
line 1442
;1442:    item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1443
;1443:    if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $595
line 1444
;1444:      item->window.flags |= (WINDOW_ORBITING | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 65540
BORI4
ASGNI4
line 1445
;1445:      item->window.offsetTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 24
INDIRI4
ASGNI4
line 1446
;1446:      item->window.rectEffects.x = cx;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 1447
;1447:      item->window.rectEffects.y = cy;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRFP4 20
INDIRF4
ASGNF4
line 1448
;1448:      item->window.rectClient.x = x;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 1449
;1449:      item->window.rectClient.y = y;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 12
INDIRF4
ASGNF4
line 1450
;1450:      Item_UpdatePosition(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 1451
;1451:    }
LABELV $595
line 1452
;1452:  }
LABELV $592
line 1441
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $594
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $591
line 1453
;1453:}
LABELV $590
endproc Menu_OrbitItemByName 24 12
export Script_Orbit
proc Script_Orbit 48 28
line 1456
;1454:
;1455:qboolean Script_Orbit(itemDef_t *item, char **args) 
;1456:{
line 1461
;1457:	const char *name;
;1458:	float cx, cy, x, y;
;1459:	int time;
;1460:
;1461:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $598
line 1462
;1462:	{
line 1463
;1463:		if ( Float_Parse(args, &x) && Float_Parse(args, &y) && Float_Parse(args, &cx) && Float_Parse(args, &cy) && Int_Parse(args, &time) ) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $600
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $600
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $600
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $600
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 44
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $600
line 1464
;1464:		{
line 1465
;1465:			Menu_OrbitItemByName(item->parent, name, x, y, cx, cy, time);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 Menu_OrbitItemByName
CALLV
pop
line 1466
;1466:		}
LABELV $600
line 1467
;1467:	}
LABELV $598
line 1469
;1468:
;1469:	return qtrue;
CNSTI4 1
RETI4
LABELV $597
endproc Script_Orbit 48 28
export Script_SetFocus
proc Script_SetFocus 36 8
line 1473
;1470:}
;1471:
;1472:qboolean Script_SetFocus(itemDef_t *item, char **args) 
;1473:{
line 1477
;1474:  const char *name;
;1475:  itemDef_t *focusItem;
;1476:
;1477:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $603
line 1478
;1478:    focusItem = Menu_FindItemByName(item->parent, name);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_FindItemByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1479
;1479:    if (focusItem && !(focusItem->window.flags & WINDOW_DECORATION) && !(focusItem->window.flags & WINDOW_HASFOCUS)) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $605
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 24
INDIRI4
NEI4 $605
ADDRLP4 20
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 24
INDIRI4
NEI4 $605
line 1480
;1480:      Menu_ClearFocus(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRGP4 Menu_ClearFocus
CALLP4
pop
line 1481
;1481:      focusItem->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1482
;1482:      if (focusItem->onFocus) {
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $607
line 1483
;1483:        Item_RunScript(focusItem, focusItem->onFocus);
ADDRLP4 32
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1484
;1484:      }
LABELV $607
line 1485
;1485:      if (DC->Assets.itemFocusSound) {
ADDRGP4 DC
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $609
line 1486
;1486:        DC->startLocalSound( DC->Assets.itemFocusSound, CHAN_LOCAL_SOUND );
ADDRLP4 32
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 1487
;1487:      }
LABELV $609
line 1488
;1488:    }
LABELV $605
line 1489
;1489:  }
LABELV $603
line 1491
;1490:
;1491:	return qtrue;
CNSTI4 1
RETI4
LABELV $602
endproc Script_SetFocus 36 8
export Script_SetPlayerModel
proc Script_SetPlayerModel 8 8
line 1495
;1492:}
;1493:
;1494:qboolean Script_SetPlayerModel(itemDef_t *item, char **args) 
;1495:{
line 1497
;1496:	const char *name;
;1497:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $612
line 1498
;1498:	{
line 1499
;1499:		DC->setCVar("team_model", name);
ADDRGP4 $614
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 1500
;1500:	}
LABELV $612
line 1502
;1501:
;1502:	return qtrue;
CNSTI4 1
RETI4
LABELV $611
endproc Script_SetPlayerModel 8 8
export Script_SetPlayerHead
proc Script_SetPlayerHead 8 8
line 1506
;1503:}
;1504:
;1505:qboolean Script_SetPlayerHead(itemDef_t *item, char **args) 
;1506:{
line 1508
;1507:	const char *name;
;1508:	if (String_Parse(args, &name)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $616
line 1509
;1509:	{
line 1510
;1510:		DC->setCVar("team_headmodel", name);
ADDRGP4 $618
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 1511
;1511:	}
LABELV $616
line 1512
;1512:	return qtrue;
CNSTI4 1
RETI4
LABELV $615
endproc Script_SetPlayerHead 8 8
export Script_SetCvar
proc Script_SetCvar 16 8
line 1516
;1513:}
;1514:
;1515:qboolean Script_SetCvar(itemDef_t *item, char **args) 
;1516:{
line 1518
;1517:	const char *cvar, *val;
;1518:	if (String_Parse(args, &cvar) && String_Parse(args, &val)) 
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $620
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $620
line 1519
;1519:	{
line 1520
;1520:		DC->setCVar(cvar, val);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 1521
;1521:	}
LABELV $620
line 1522
;1522:	return qtrue;
CNSTI4 1
RETI4
LABELV $619
endproc Script_SetCvar 16 8
export Script_SetCvarToCvar
proc Script_SetCvarToCvar 1040 12
line 1525
;1523:}
;1524:
;1525:qboolean Script_SetCvarToCvar(itemDef_t *item, char **args) {
line 1527
;1526:	const char *cvar, *val;
;1527:	if (String_Parse(args, &cvar) && String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $623
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $623
line 1529
;1528:		char cvarBuf[1024];
;1529:		DC->getCVarString(val, cvarBuf, sizeof(cvarBuf));
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1530
;1530:		DC->setCVar(cvar, cvarBuf);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 1531
;1531:	}
LABELV $623
line 1532
;1532:	return qtrue;
CNSTI4 1
RETI4
LABELV $622
endproc Script_SetCvarToCvar 1040 12
export Script_Exec
proc Script_Exec 12 8
line 1535
;1533:}
;1534:
;1535:qboolean Script_Exec(itemDef_t *item, char **args) {
line 1537
;1536:	const char *val;
;1537:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $626
line 1538
;1538:		DC->executeText(EXEC_APPEND, va("%s ; ", val));
ADDRGP4 $628
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 172
ADDP4
INDIRP4
CALLV
pop
line 1539
;1539:	}
LABELV $626
line 1540
;1540:	return qtrue;
CNSTI4 1
RETI4
LABELV $625
endproc Script_Exec 12 8
export Script_Play
proc Script_Play 12 8
line 1543
;1541:}
;1542:
;1543:qboolean Script_Play(itemDef_t *item, char **args) {
line 1545
;1544:	const char *val;
;1545:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $630
line 1546
;1546:		DC->startLocalSound(DC->registerSound(val), CHAN_AUTO);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 192
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 1547
;1547:	}
LABELV $630
line 1548
;1548:	return qtrue;
CNSTI4 1
RETI4
LABELV $629
endproc Script_Play 12 8
export Script_playLooped
proc Script_playLooped 12 12
line 1551
;1549:}
;1550:
;1551:qboolean Script_playLooped(itemDef_t *item, char **args) {
line 1553
;1552:	const char *val;
;1553:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $633
line 1554
;1554:		DC->stopBackgroundTrack();
ADDRGP4 DC
INDIRP4
CNSTI4 200
ADDP4
INDIRP4
CALLV
pop
line 1555
;1555:		DC->startBackgroundTrack(val, val, qfalse);
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 196
ADDP4
INDIRP4
CALLV
pop
line 1556
;1556:	}
LABELV $633
line 1557
;1557:	return qtrue;
CNSTI4 1
RETI4
LABELV $632
endproc Script_playLooped 12 12
data
export commandList
align 4
LABELV commandList
address $635
address Script_FadeIn
address $636
address Script_FadeOut
address $637
address Script_Show
address $638
address Script_Hide
address $639
address Script_SetColor
address $640
address Script_Open
address $641
address Script_Close
address $642
address Script_SetAsset
address $643
address Script_SetBackground
address $644
address Script_SetItemColor
address $645
address Script_SetItemRect
address $646
address Script_SetTeamColor
address $647
address Script_SetFocus
address $648
address Script_SetPlayerModel
address $649
address Script_SetPlayerHead
address $650
address Script_Transition
address $651
address Script_SetCvar
address $652
address Script_SetCvarToCvar
address $653
address Script_Exec
address $654
address Script_Play
address $655
address Script_playLooped
address $656
address Script_Orbit
address $657
address Script_Defer
address $658
address Script_RunDeferred
export scriptCommandCount
align 4
LABELV scriptCommandCount
byte 4 24
export Item_RunScript
code
proc Item_RunScript 2088 12
line 1593
;1558:}
;1559:
;1560:
;1561:commandDef_t commandList[] =
;1562:{
;1563:  {"fadein", &Script_FadeIn},                   // group/name
;1564:  {"fadeout", &Script_FadeOut},                 // group/name
;1565:  {"show", &Script_Show},                       // group/name
;1566:  {"hide", &Script_Hide},                       // group/name
;1567:  {"setcolor", &Script_SetColor},               // works on this
;1568:  {"open", &Script_Open},                       // nenu
;1569:  {"close", &Script_Close},                     // menu
;1570:  {"setasset", &Script_SetAsset},               // works on this
;1571:  {"setbackground", &Script_SetBackground},     // works on this
;1572:  {"setitemcolor", &Script_SetItemColor},       // group/name
;1573:  {"setitemrect", &Script_SetItemRect},			// group/name
;1574:  {"setteamcolor", &Script_SetTeamColor},       // sets this background color to team color
;1575:  {"setfocus", &Script_SetFocus},               // sets focus
;1576:  {"setplayermodel", &Script_SetPlayerModel},   // sets model
;1577:  {"setplayerhead", &Script_SetPlayerHead},     // sets head
;1578:  {"transition", &Script_Transition},           // group/name
;1579:  {"setcvar", &Script_SetCvar},					// name
;1580:  {"setcvartocvar", &Script_SetCvarToCvar},     // name
;1581:  {"exec", &Script_Exec},						// group/name
;1582:  {"play", &Script_Play},						// group/name
;1583:  {"playlooped", &Script_playLooped},           // group/name
;1584:  {"orbit", &Script_Orbit},                     // group/name
;1585:  {"defer",			&Script_Defer},				// 
;1586:  {"rundeferred",	&Script_RunDeferred},		//
;1587:};
;1588:
;1589:int scriptCommandCount = sizeof(commandList) / sizeof(commandDef_t);
;1590:
;1591:
;1592:void Item_RunScript(itemDef_t *item, const char *s) 
;1593:{
line 1598
;1594:	char script[2048], *p;
;1595:	int i;
;1596:	qboolean bRan;
;1597:	
;1598:	script[0] = 0;
ADDRLP4 12
CNSTI1 0
ASGNI1
line 1600
;1599:	
;1600:	if (item && s && s[0]) 
ADDRLP4 2060
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 2060
INDIRU4
EQU4 $660
ADDRLP4 2064
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 2064
INDIRP4
CVPU4 4
ADDRLP4 2060
INDIRU4
EQU4 $660
ADDRLP4 2064
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $660
line 1601
;1601:	{
line 1602
;1602:		Q_strcat(script, 2048, s);
ADDRLP4 12
ARGP4
CNSTI4 2048
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1603
;1603:		p = script;
ADDRLP4 8
ADDRLP4 12
ASGNP4
ADDRGP4 $663
JUMPV
LABELV $662
line 1606
;1604:		
;1605:		while (1) 
;1606:		{
line 1610
;1607:			const char *command;
;1608:
;1609:			// expect command then arguments, ; ends command, NULL ends script
;1610:			if (!String_Parse(&p, &command)) 
ADDRLP4 8
ARGP4
ADDRLP4 2068
ARGP4
ADDRLP4 2072
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
NEI4 $665
line 1611
;1611:			{
line 1612
;1612:				return;
ADDRGP4 $659
JUMPV
LABELV $665
line 1615
;1613:			}
;1614:
;1615:			if (command[0] == ';' && command[1] == '\0') 
ADDRLP4 2076
ADDRLP4 2068
INDIRP4
ASGNP4
ADDRLP4 2076
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $667
ADDRLP4 2076
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $667
line 1616
;1616:			{
line 1617
;1617:				continue;
ADDRGP4 $663
JUMPV
LABELV $667
line 1620
;1618:			}
;1619:
;1620:			bRan = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1621
;1621:			for (i = 0; i < scriptCommandCount; i++) 
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $672
JUMPV
LABELV $669
line 1622
;1622:			{
line 1623
;1623:				if (Q_stricmp(command, commandList[i].name) == 0) 
ADDRLP4 2068
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commandList
ADDP4
INDIRP4
ARGP4
ADDRLP4 2080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2080
INDIRI4
CNSTI4 0
NEI4 $673
line 1624
;1624:				{
line 1626
;1625:					// Allow a script command to stop processing the script
;1626:					if ( !commandList[i].handler(item, &p) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 2084
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commandList+4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 0
NEI4 $675
line 1627
;1627:					{
line 1628
;1628:						return;
ADDRGP4 $659
JUMPV
LABELV $675
line 1631
;1629:					}
;1630:
;1631:					bRan = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1632
;1632:					break;
ADDRGP4 $671
JUMPV
LABELV $673
line 1634
;1633:				}
;1634:			}
LABELV $670
line 1621
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $672
ADDRLP4 0
INDIRI4
ADDRGP4 scriptCommandCount
INDIRI4
LTI4 $669
LABELV $671
line 1637
;1635:
;1636:			// not in our auto list, pass to handler
;1637:			if (!bRan) 
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $678
line 1638
;1638:			{
line 1639
;1639:				DC->runScript(&p);
ADDRLP4 8
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 100
ADDP4
INDIRP4
CALLV
pop
line 1640
;1640:			}
LABELV $678
line 1641
;1641:		}
LABELV $663
line 1605
ADDRGP4 $662
JUMPV
line 1642
;1642:	}
LABELV $660
line 1643
;1643:}
LABELV $659
endproc Item_RunScript 2088 12
export Item_EnableShowViaCvar
proc Item_EnableShowViaCvar 4136 12
line 1646
;1644:
;1645:
;1646:qboolean Item_EnableShowViaCvar(itemDef_t *item, int flag) {
line 1648
;1647:  char script[2048], *p;
;1648:  if (item && item->enableCvar && *item->enableCvar && item->cvarTest && *item->cvarTest) {
ADDRLP4 2052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2056
CNSTU4 0
ASGNU4
ADDRLP4 2052
INDIRP4
CVPU4 4
ADDRLP4 2056
INDIRU4
EQU4 $681
ADDRLP4 2060
ADDRLP4 2052
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ASGNP4
ADDRLP4 2060
INDIRP4
CVPU4 4
ADDRLP4 2056
INDIRU4
EQU4 $681
ADDRLP4 2064
CNSTI4 0
ASGNI4
ADDRLP4 2060
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 2064
INDIRI4
EQI4 $681
ADDRLP4 2068
ADDRLP4 2052
INDIRP4
CNSTI4 280
ADDP4
INDIRP4
ASGNP4
ADDRLP4 2068
INDIRP4
CVPU4 4
ADDRLP4 2056
INDIRU4
EQU4 $681
ADDRLP4 2068
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 2064
INDIRI4
EQI4 $681
line 1650
;1649:		char buff[2048];
;1650:	  DC->getCVarString(item->cvarTest, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRP4
ARGP4
ADDRLP4 2072
ARGP4
CNSTI4 2048
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1652
;1651:
;1652:    Q_strncpyz(script, item->enableCvar, 2048);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
CNSTI4 2048
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1653
;1653:    p = script;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $684
JUMPV
LABELV $683
line 1654
;1654:    while (1) {
line 1657
;1655:      const char *val;
;1656:      // expect value then ; or NULL, NULL ends list
;1657:      if (!String_Parse(&p, &val)) {
ADDRLP4 0
ARGP4
ADDRLP4 4120
ARGP4
ADDRLP4 4124
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4124
INDIRI4
CNSTI4 0
NEI4 $686
line 1658
;1658:				return (item->cvarFlags & flag) ? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $689
ADDRLP4 4128
CNSTI4 0
ASGNI4
ADDRGP4 $690
JUMPV
LABELV $689
ADDRLP4 4128
CNSTI4 1
ASGNI4
LABELV $690
ADDRLP4 4128
INDIRI4
RETI4
ADDRGP4 $680
JUMPV
LABELV $686
line 1661
;1659:      }
;1660:
;1661:      if (val[0] == ';' && val[1] == '\0') {
ADDRLP4 4128
ADDRLP4 4120
INDIRP4
ASGNP4
ADDRLP4 4128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $691
ADDRLP4 4128
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $691
line 1662
;1662:        continue;
ADDRGP4 $684
JUMPV
LABELV $691
line 1666
;1663:      }
;1664:
;1665:			// enable it if any of the values are true
;1666:			if (item->cvarFlags & flag) {
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $693
line 1667
;1667:        if (Q_stricmp(buff, val) == 0) {
ADDRLP4 2072
ARGP4
ADDRLP4 4120
INDIRP4
ARGP4
ADDRLP4 4132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4132
INDIRI4
CNSTI4 0
NEI4 $694
line 1668
;1668:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $680
JUMPV
line 1670
;1669:				}
;1670:			} else {
LABELV $693
line 1672
;1671:				// disable it if any of the values are true
;1672:        if (Q_stricmp(buff, val) == 0) {
ADDRLP4 2072
ARGP4
ADDRLP4 4120
INDIRP4
ARGP4
ADDRLP4 4132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4132
INDIRI4
CNSTI4 0
NEI4 $697
line 1673
;1673:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $680
JUMPV
LABELV $697
line 1675
;1674:				}
;1675:			}
LABELV $694
line 1677
;1676:
;1677:    }
LABELV $684
line 1654
ADDRGP4 $683
JUMPV
line 1678
;1678:		return (item->cvarFlags & flag) ? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $700
ADDRLP4 4120
CNSTI4 0
ASGNI4
ADDRGP4 $701
JUMPV
LABELV $700
ADDRLP4 4120
CNSTI4 1
ASGNI4
LABELV $701
ADDRLP4 4120
INDIRI4
RETI4
ADDRGP4 $680
JUMPV
LABELV $681
line 1680
;1679:  }
;1680:	return qtrue;
CNSTI4 1
RETI4
LABELV $680
endproc Item_EnableShowViaCvar 4136 12
export Item_SetFocus
proc Item_SetFocus 80 12
line 1685
;1681:}
;1682:
;1683:
;1684:// will optionaly set focus to this item 
;1685:qboolean Item_SetFocus(itemDef_t *item, float x, float y) {
line 1688
;1686:	int i;
;1687:	itemDef_t *oldFocus;
;1688:	sfxHandle_t *sfx = &DC->Assets.itemFocusSound;
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 340
ADDP4
ASGNP4
line 1689
;1689:	qboolean playSound = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1692
;1690:	menuDef_t *parent; // bk001206: = (menuDef_t*)item->parent;
;1691:	// sanity check, non-null, not a decoration and does not already have the focus
;1692:	if (item == NULL || item->window.flags & WINDOW_DECORATION || item->window.flags & WINDOW_HASFOCUS || !(item->window.flags & WINDOW_VISIBLE)) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $707
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $707
ADDRLP4 24
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $707
ADDRLP4 24
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $703
LABELV $707
line 1693
;1693:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $702
JUMPV
LABELV $703
line 1697
;1694:	}
;1695:
;1696:	// bk001206 - this can be NULL.
;1697:	parent = (menuDef_t*)item->parent; 
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 1700
;1698:      
;1699:	// items can be enabled and disabled based on cvars
;1700:	if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $708
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $708
line 1701
;1701:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $702
JUMPV
LABELV $708
line 1704
;1702:	}
;1703:
;1704:	if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $710
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 44
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $710
line 1705
;1705:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $702
JUMPV
LABELV $710
line 1708
;1706:	}
;1707:
;1708:	oldFocus = Menu_ClearFocus(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Menu_ClearFocus
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 48
INDIRP4
ASGNP4
line 1710
;1709:
;1710:	if (item->type == ITEM_TYPE_TEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $712
line 1712
;1711:		rectDef_t r;
;1712:		r = item->textRect;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 1713
;1713:		r.y -= r.h;
ADDRLP4 52+4
ADDRLP4 52+4
INDIRF4
ADDRLP4 52+12
INDIRF4
SUBF4
ASGNF4
line 1714
;1714:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 52
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $716
line 1715
;1715:			item->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1716
;1716:			if (item->focusSound) {
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
CNSTI4 0
EQI4 $718
line 1717
;1717:				sfx = &item->focusSound;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
line 1718
;1718:			}
LABELV $718
line 1719
;1719:			playSound = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1720
;1720:		} else {
ADDRGP4 $713
JUMPV
LABELV $716
line 1721
;1721:			if (oldFocus) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $713
line 1722
;1722:				oldFocus->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 72
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1723
;1723:				if (oldFocus->onFocus) {
ADDRLP4 16
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $713
line 1724
;1724:					Item_RunScript(oldFocus, oldFocus->onFocus);
ADDRLP4 76
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1725
;1725:				}
line 1726
;1726:			}
line 1727
;1727:		}
line 1728
;1728:	} else {
ADDRGP4 $713
JUMPV
LABELV $712
line 1729
;1729:	    item->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1730
;1730:		if (item->onFocus) {
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $724
line 1731
;1731:			Item_RunScript(item, item->onFocus);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1732
;1732:		}
LABELV $724
line 1733
;1733:		if (item->focusSound) {
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
CNSTI4 0
EQI4 $726
line 1734
;1734:			sfx = &item->focusSound;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
line 1735
;1735:		}
LABELV $726
line 1736
;1736:		playSound = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1737
;1737:	}
LABELV $713
line 1739
;1738:
;1739:	if (playSound && sfx) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $728
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $728
line 1740
;1740:		DC->startLocalSound( *sfx, CHAN_LOCAL_SOUND );
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 1741
;1741:	}
LABELV $728
line 1743
;1742:
;1743:	for (i = 0; i < parent->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $733
JUMPV
LABELV $730
line 1744
;1744:		if (parent->items[i] == item) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $734
line 1745
;1745:			parent->cursorItem = i;
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1746
;1746:			break;
ADDRGP4 $732
JUMPV
LABELV $734
line 1748
;1747:		}
;1748:	}
LABELV $731
line 1743
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $733
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $730
LABELV $732
line 1750
;1749:
;1750:	return qtrue;
CNSTI4 1
RETI4
LABELV $702
endproc Item_SetFocus 80 12
export Item_TextScroll_MaxScroll
proc Item_TextScroll_MaxScroll 12 0
line 1754
;1751:}
;1752:
;1753:int Item_TextScroll_MaxScroll ( itemDef_t *item ) 
;1754:{
line 1755
;1755:	textScrollDef_t *scrollPtr = (textScrollDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 1757
;1756:	
;1757:	int count = scrollPtr->lineCount;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 1758
;1758:	int max   = count - (int)(item->window.rect.h / scrollPtr->lineHeight) + 1;
ADDRLP4 4
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
DIVF4
CVFI4 4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1760
;1759:
;1760:	if (max < 0) 
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $737
line 1761
;1761:	{
line 1762
;1762:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $736
JUMPV
LABELV $737
line 1765
;1763:	}
;1764:
;1765:	return max;
ADDRLP4 4
INDIRI4
RETI4
LABELV $736
endproc Item_TextScroll_MaxScroll 12 0
export Item_TextScroll_ThumbPosition
proc Item_TextScroll_ThumbPosition 20 4
line 1769
;1766:}
;1767:
;1768:int Item_TextScroll_ThumbPosition ( itemDef_t *item ) 
;1769:{
line 1771
;1770:	float max, pos, size;
;1771:	textScrollDef_t *scrollPtr = (textScrollDef_t*)item->typeData;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 1773
;1772:
;1773:	max  = Item_TextScroll_MaxScroll ( item );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_TextScroll_MaxScroll
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1774
;1774:	size = item->window.rect.h - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1776
;1775:
;1776:	if (max > 0) 
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $740
line 1777
;1777:	{
line 1778
;1778:		pos = (size-SCROLLBAR_SIZE) / (float) max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 1779
;1779:	} 
ADDRGP4 $741
JUMPV
LABELV $740
line 1781
;1780:	else 
;1781:	{
line 1782
;1782:		pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1783
;1783:	}
LABELV $741
line 1785
;1784:	
;1785:	pos *= scrollPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1787
;1786:	
;1787:	return item->window.rect.y + 1 + SCROLLBAR_SIZE + pos;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1098907648
ADDF4
ADDRLP4 0
INDIRF4
ADDF4
CVFI4 4
RETI4
LABELV $739
endproc Item_TextScroll_ThumbPosition 20 4
export Item_TextScroll_ThumbDrawPosition
proc Item_TextScroll_ThumbDrawPosition 24 4
line 1791
;1788:}
;1789:
;1790:int Item_TextScroll_ThumbDrawPosition ( itemDef_t *item ) 
;1791:{
line 1794
;1792:	int min, max;
;1793:
;1794:	if (itemCapture == item) 
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $743
line 1795
;1795:	{
line 1796
;1796:		min = item->window.rect.y + SCROLLBAR_SIZE + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1797
;1797:		max = item->window.rect.y + item->window.rect.h - 2*SCROLLBAR_SIZE - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
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
CNSTF4 1107296256
SUBF4
CNSTF4 1065353216
SUBF4
CVFI4 4
ASGNI4
line 1799
;1798:
;1799:		if (DC->cursory >= min + SCROLLBAR_SIZE/2 && DC->cursory <= max + SCROLLBAR_SIZE/2) 
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 16
CNSTF4 1090519040
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
LTF4 $745
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
GTF4 $745
line 1800
;1800:		{
line 1801
;1801:			return DC->cursory - SCROLLBAR_SIZE/2;
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $742
JUMPV
LABELV $745
line 1804
;1802:		}
;1803:
;1804:		return Item_TextScroll_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_TextScroll_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $742
JUMPV
LABELV $743
line 1807
;1805:	}
;1806:
;1807:	return Item_TextScroll_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Item_TextScroll_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $742
endproc Item_TextScroll_ThumbDrawPosition 24 4
export Item_TextScroll_OverLB
proc Item_TextScroll_OverLB 68 12
line 1811
;1808:}
;1809:
;1810:int Item_TextScroll_OverLB ( itemDef_t *item, float x, float y ) 
;1811:{
line 1817
;1812:	rectDef_t		r;
;1813:	textScrollDef_t *scrollPtr;
;1814:	int				thumbstart;
;1815:	int				count;
;1816:
;1817:	scrollPtr = (textScrollDef_t*)item->typeData;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 1818
;1818:	count     = scrollPtr->lineCount;
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 1820
;1819:
;1820:	r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1821
;1821:	r.y = item->window.rect.y;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1822
;1822:	r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 32
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 32
INDIRF4
ASGNF4
line 1823
;1823:	if (Rect_ContainsPoint(&r, x, y)) 
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $751
line 1824
;1824:	{
line 1825
;1825:		return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $747
JUMPV
LABELV $751
line 1828
;1826:	}
;1827:
;1828:	r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1829
;1829:	if (Rect_ContainsPoint(&r, x, y)) 
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $754
line 1830
;1830:	{
line 1831
;1831:		return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $747
JUMPV
LABELV $754
line 1834
;1832:	}
;1833:
;1834:	thumbstart = Item_TextScroll_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Item_TextScroll_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 48
INDIRI4
ASGNI4
line 1835
;1835:	r.y = thumbstart;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1836
;1836:	if (Rect_ContainsPoint(&r, x, y)) 
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $757
line 1837
;1837:	{
line 1838
;1838:		return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $747
JUMPV
LABELV $757
line 1841
;1839:	}
;1840:
;1841:	r.y = item->window.rect.y + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1842
;1842:	r.h = thumbstart - r.y;
ADDRLP4 0+12
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
line 1843
;1843:	if (Rect_ContainsPoint(&r, x, y)) 
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $762
line 1844
;1844:	{
line 1845
;1845:		return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $747
JUMPV
LABELV $762
line 1848
;1846:	}
;1847:
;1848:	r.y = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1849
;1849:	r.h = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+12
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1850
;1850:	if (Rect_ContainsPoint(&r, x, y)) 
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $766
line 1851
;1851:	{
line 1852
;1852:		return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $747
JUMPV
LABELV $766
line 1855
;1853:	}
;1854:
;1855:	return 0;
CNSTI4 0
RETI4
LABELV $747
endproc Item_TextScroll_OverLB 68 12
export Item_TextScroll_MouseEnter
proc Item_TextScroll_MouseEnter 16 12
line 1859
;1856:}
;1857:
;1858:void Item_TextScroll_MouseEnter (itemDef_t *item, float x, float y) 
;1859:{
line 1860
;1860:	item->window.flags &= ~(WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -63489
BANDI4
ASGNI4
line 1861
;1861:	item->window.flags |= Item_TextScroll_OverLB(item, x, y);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 Item_TextScroll_OverLB
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
BORI4
ASGNI4
line 1862
;1862:}
LABELV $768
endproc Item_TextScroll_MouseEnter 16 12
export Item_TextScroll_HandleKey
proc Item_TextScroll_HandleKey 60 12
line 1865
;1863:
;1864:qboolean Item_TextScroll_HandleKey ( itemDef_t *item, int key, qboolean down, qboolean force) 
;1865:{
line 1866
;1866:	textScrollDef_t *scrollPtr = (textScrollDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 1870
;1867:	int				max;
;1868:	int				viewmax;
;1869:
;1870:	if (force || (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS)) 
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $772
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $770
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 20
INDIRI4
EQI4 $770
LABELV $772
line 1871
;1871:	{
line 1872
;1872:		max = Item_TextScroll_MaxScroll(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Item_TextScroll_MaxScroll
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
line 1874
;1873:
;1874:		viewmax = (item->window.rect.h / scrollPtr->lineHeight);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1875
;1875:		if ( key == K_UPARROW || key == K_KP_UPARROW ) 
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 132
EQI4 $775
ADDRLP4 28
INDIRI4
CNSTI4 161
NEI4 $773
LABELV $775
line 1876
;1876:		{
line 1877
;1877:			scrollPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1878
;1878:			if (scrollPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $776
line 1879
;1879:			{
line 1880
;1880:				scrollPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1881
;1881:			}
LABELV $776
line 1882
;1882:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $773
line 1885
;1883:		}
;1884:
;1885:		if ( key == K_DOWNARROW || key == K_KP_DOWNARROW ) 
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 133
EQI4 $780
ADDRLP4 32
INDIRI4
CNSTI4 167
NEI4 $778
LABELV $780
line 1886
;1886:		{
line 1887
;1887:			scrollPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1888
;1888:			if (scrollPtr->startPos > max)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $781
line 1889
;1889:			{
line 1890
;1890:				scrollPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1891
;1891:			}
LABELV $781
line 1893
;1892:
;1893:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $778
line 1897
;1894:		}
;1895:
;1896:		// mouse hit
;1897:		if (key == K_MOUSE1 || key == K_MOUSE2) 
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 178
EQI4 $785
ADDRLP4 36
INDIRI4
CNSTI4 179
NEI4 $783
LABELV $785
line 1898
;1898:		{
line 1899
;1899:			if (item->window.flags & WINDOW_LB_LEFTARROW) 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $786
line 1900
;1900:			{
line 1901
;1901:				scrollPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1902
;1902:				if (scrollPtr->startPos < 0) 
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $787
line 1903
;1903:				{
line 1904
;1904:					scrollPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1905
;1905:				}
line 1906
;1906:			} 
ADDRGP4 $787
JUMPV
LABELV $786
line 1907
;1907:			else if (item->window.flags & WINDOW_LB_RIGHTARROW) 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $790
line 1908
;1908:			{
line 1910
;1909:				// one down
;1910:				scrollPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1911
;1911:				if (scrollPtr->startPos > max) 
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $791
line 1912
;1912:				{
line 1913
;1913:					scrollPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1914
;1914:				}
line 1915
;1915:			} 
ADDRGP4 $791
JUMPV
LABELV $790
line 1916
;1916:			else if (item->window.flags & WINDOW_LB_PGUP) 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $794
line 1917
;1917:			{
line 1919
;1918:				// page up
;1919:				scrollPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1920
;1920:				if (scrollPtr->startPos < 0) 
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $795
line 1921
;1921:				{
line 1922
;1922:					scrollPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1923
;1923:				}
line 1924
;1924:			} 
ADDRGP4 $795
JUMPV
LABELV $794
line 1925
;1925:			else if (item->window.flags & WINDOW_LB_PGDN) 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $798
line 1926
;1926:			{
line 1928
;1927:				// page down
;1928:				scrollPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1929
;1929:				if (scrollPtr->startPos > max) 
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $799
line 1930
;1930:				{
line 1931
;1931:					scrollPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1932
;1932:				}
line 1933
;1933:			} 
ADDRGP4 $799
JUMPV
LABELV $798
line 1934
;1934:			else if (item->window.flags & WINDOW_LB_THUMB) 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $802
line 1935
;1935:			{
line 1937
;1936:				// Display_SetCaptureItem(item);
;1937:			} 
LABELV $802
LABELV $799
LABELV $795
LABELV $791
LABELV $787
line 1939
;1938:
;1939:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $783
line 1942
;1940:		}
;1941:
;1942:		if ( key == K_HOME || key == K_KP_HOME) 
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 143
EQI4 $806
ADDRLP4 40
INDIRI4
CNSTI4 160
NEI4 $804
LABELV $806
line 1943
;1943:		{
line 1945
;1944:			// home
;1945:			scrollPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1946
;1946:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $804
line 1948
;1947:		}
;1948:		if ( key == K_END || key == K_KP_END) 
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 144
EQI4 $809
ADDRLP4 44
INDIRI4
CNSTI4 166
NEI4 $807
LABELV $809
line 1949
;1949:		{
line 1951
;1950:			// end
;1951:			scrollPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1952
;1952:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $807
line 1954
;1953:		}
;1954:		if (key == K_PGUP || key == K_KP_PGUP ) 
ADDRLP4 48
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 142
EQI4 $812
ADDRLP4 48
INDIRI4
CNSTI4 162
NEI4 $810
LABELV $812
line 1955
;1955:		{
line 1956
;1956:			scrollPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1957
;1957:			if (scrollPtr->startPos < 0) 
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $813
line 1958
;1958:			{
line 1959
;1959:					scrollPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1960
;1960:			}
LABELV $813
line 1962
;1961:
;1962:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $810
line 1964
;1963:		}
;1964:		if ( key == K_PGDN || key == K_KP_PGDN ) 
ADDRLP4 52
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 141
EQI4 $817
ADDRLP4 52
INDIRI4
CNSTI4 168
NEI4 $815
LABELV $817
line 1965
;1965:		{
line 1966
;1966:			scrollPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1967
;1967:			if (scrollPtr->startPos > max) 
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $818
line 1968
;1968:			{
line 1969
;1969:				scrollPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1970
;1970:			}
LABELV $818
line 1971
;1971:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $815
line 1973
;1972:		}
;1973:	}
LABELV $770
line 1975
;1974:
;1975:	return qfalse;
CNSTI4 0
RETI4
LABELV $769
endproc Item_TextScroll_HandleKey 60 12
export Item_ListBox_MaxScroll
proc Item_ListBox_MaxScroll 16 4
line 1978
;1976:}
;1977:
;1978:int Item_ListBox_MaxScroll(itemDef_t *item) {
line 1979
;1979:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 1980
;1980:	int count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1983
;1981:	int max;
;1982:
;1983:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $821
line 1984
;1984:		max = count - (item->window.rect.w / listPtr->elementWidth) + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
DIVF4
SUBF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1985
;1985:	}
ADDRGP4 $822
JUMPV
LABELV $821
line 1986
;1986:	else {
line 1987
;1987:		max = count - (item->window.rect.h / listPtr->elementHeight) + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
SUBF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1988
;1988:	}
LABELV $822
line 1989
;1989:	if (max < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $823
line 1990
;1990:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $820
JUMPV
LABELV $823
line 1992
;1991:	}
;1992:	return max;
ADDRLP4 0
INDIRI4
RETI4
LABELV $820
endproc Item_ListBox_MaxScroll 16 4
export Item_ListBox_ThumbPosition
proc Item_ListBox_ThumbPosition 20 4
line 1995
;1993:}
;1994:
;1995:int Item_ListBox_ThumbPosition(itemDef_t *item) {
line 1997
;1996:	float max, pos, size;
;1997:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 1999
;1998:
;1999:	max = Item_ListBox_MaxScroll(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 2000
;2000:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $826
line 2001
;2001:		size = item->window.rect.w - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2002
;2002:		if (max > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $828
line 2003
;2003:			pos = (size-SCROLLBAR_SIZE) / (float) max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 2004
;2004:		} else {
ADDRGP4 $829
JUMPV
LABELV $828
line 2005
;2005:			pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2006
;2006:		}
LABELV $829
line 2007
;2007:		pos *= listPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 2008
;2008:		return item->window.rect.x + 1 + SCROLLBAR_SIZE + pos;
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1098907648
ADDF4
ADDRLP4 0
INDIRF4
ADDF4
CVFI4 4
RETI4
ADDRGP4 $825
JUMPV
LABELV $826
line 2010
;2009:	}
;2010:	else {
line 2011
;2011:		size = item->window.rect.h - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2012
;2012:		if (max > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $830
line 2013
;2013:			pos = (size-SCROLLBAR_SIZE) / (float) max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 2014
;2014:		} else {
ADDRGP4 $831
JUMPV
LABELV $830
line 2015
;2015:			pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2016
;2016:		}
LABELV $831
line 2017
;2017:		pos *= listPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 2018
;2018:		return item->window.rect.y + 1 + SCROLLBAR_SIZE + pos;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1098907648
ADDF4
ADDRLP4 0
INDIRF4
ADDF4
CVFI4 4
RETI4
LABELV $825
endproc Item_ListBox_ThumbPosition 20 4
export Item_ListBox_ThumbDrawPosition
proc Item_ListBox_ThumbDrawPosition 24 4
line 2022
;2019:	}
;2020:}
;2021:
;2022:int Item_ListBox_ThumbDrawPosition(itemDef_t *item) {
line 2025
;2023:	int min, max;
;2024:
;2025:	if (itemCapture == item) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $833
line 2026
;2026:		if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $835
line 2027
;2027:			min = item->window.rect.x + SCROLLBAR_SIZE + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 2028
;2028:			max = item->window.rect.x + item->window.rect.w - 2*SCROLLBAR_SIZE - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1107296256
SUBF4
CNSTF4 1065353216
SUBF4
CVFI4 4
ASGNI4
line 2029
;2029:			if (DC->cursorx >= min + SCROLLBAR_SIZE/2 && DC->cursorx <= max + SCROLLBAR_SIZE/2) {
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 16
CNSTF4 1090519040
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
LTF4 $837
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
GTF4 $837
line 2030
;2030:				return DC->cursorx - SCROLLBAR_SIZE/2;
ADDRGP4 DC
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $832
JUMPV
LABELV $837
line 2032
;2031:			}
;2032:			else {
line 2033
;2033:				return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $832
JUMPV
LABELV $835
line 2036
;2034:			}
;2035:		}
;2036:		else {
line 2037
;2037:			min = item->window.rect.y + SCROLLBAR_SIZE + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 2038
;2038:			max = item->window.rect.y + item->window.rect.h - 2*SCROLLBAR_SIZE - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
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
CNSTF4 1107296256
SUBF4
CNSTF4 1065353216
SUBF4
CVFI4 4
ASGNI4
line 2039
;2039:			if (DC->cursory >= min + SCROLLBAR_SIZE/2 && DC->cursory <= max + SCROLLBAR_SIZE/2) {
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 16
CNSTF4 1090519040
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
LTF4 $839
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
GTF4 $839
line 2040
;2040:				return DC->cursory - SCROLLBAR_SIZE/2;
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $832
JUMPV
LABELV $839
line 2042
;2041:			}
;2042:			else {
line 2043
;2043:				return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $832
JUMPV
LABELV $833
line 2047
;2044:			}
;2045:		}
;2046:	}
;2047:	else {
line 2048
;2048:		return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $832
endproc Item_ListBox_ThumbDrawPosition 24 4
export Item_Slider_ThumbPosition
proc Item_Slider_ThumbPosition 28 4
line 2052
;2049:	}
;2050:}
;2051:
;2052:float Item_Slider_ThumbPosition(itemDef_t *item) {
line 2054
;2053:	float value, range, x;
;2054:	editFieldDef_t *editDef = item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2056
;2055:
;2056:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $842
line 2057
;2057:		x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2058
;2058:	} else {
ADDRGP4 $843
JUMPV
LABELV $842
line 2059
;2059:		x = item->window.rect.x;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2060
;2060:	}
LABELV $843
line 2062
;2061:
;2062:	if (editDef == NULL && item->cvar) {
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
NEU4 $844
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $844
line 2063
;2063:		return x;
ADDRLP4 8
INDIRF4
RETF4
ADDRGP4 $841
JUMPV
LABELV $844
line 2066
;2064:	}
;2065:
;2066:	value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 2068
;2067:
;2068:	if (value < editDef->minVal) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
GEF4 $846
line 2069
;2069:		value = editDef->minVal;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
line 2070
;2070:	} else if (value > editDef->maxVal) {
ADDRGP4 $847
JUMPV
LABELV $846
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
LEF4 $848
line 2071
;2071:		value = editDef->maxVal;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 2072
;2072:	}
LABELV $848
LABELV $847
line 2074
;2073:
;2074:	range = editDef->maxVal - editDef->minVal;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 2075
;2075:	value -= editDef->minVal;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 2076
;2076:	value /= range;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
DIVF4
ASGNF4
line 2078
;2077:	//value /= (editDef->maxVal - editDef->minVal);
;2078:	value *= SLIDER_WIDTH;
ADDRLP4 0
CNSTF4 1119879168
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 2079
;2079:	x += value;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 2082
;2080:	// vm fuckage
;2081:	//x = x + (((float)value / editDef->maxVal) * SLIDER_WIDTH);
;2082:	return x;
ADDRLP4 8
INDIRF4
RETF4
LABELV $841
endproc Item_Slider_ThumbPosition 28 4
export Item_Slider_OverSlider
proc Item_Slider_OverSlider 24 12
line 2085
;2083:}
;2084:
;2085:int Item_Slider_OverSlider(itemDef_t *item, float x, float y) {
line 2088
;2086:	rectDef_t r;
;2087:
;2088:	r.x = Item_Slider_ThumbPosition(item) - (SLIDER_THUMB_WIDTH / 2);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_Slider_ThumbPosition
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CNSTF4 1086324736
SUBF4
ASGNF4
line 2089
;2089:	r.y = item->window.rect.y - 2;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2090
;2090:	r.w = SLIDER_THUMB_WIDTH;
ADDRLP4 0+8
CNSTF4 1094713344
ASGNF4
line 2091
;2091:	r.h = SLIDER_THUMB_HEIGHT;
ADDRLP4 0+12
CNSTF4 1101004800
ASGNF4
line 2093
;2092:
;2093:	if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $854
line 2094
;2094:		return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $850
JUMPV
LABELV $854
line 2096
;2095:	}
;2096:	return 0;
CNSTI4 0
RETI4
LABELV $850
endproc Item_Slider_OverSlider 24 12
export Item_ListBox_OverLB
proc Item_ListBox_OverLB 72 12
line 2099
;2097:}
;2098:
;2099:int Item_ListBox_OverLB(itemDef_t *item, float x, float y) {
line 2105
;2100:	rectDef_t r;
;2101:	listBoxDef_t *listPtr;
;2102:	int thumbstart;
;2103:	int count;
;2104:
;2105:	count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 28
INDIRI4
ASGNI4
line 2106
;2106:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2107
;2107:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $857
line 2109
;2108:		// check if on left arrow
;2109:		r.x = item->window.rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2110
;2110:		r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2111
;2111:		r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 36
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
ASGNF4
line 2112
;2112:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $862
line 2113
;2113:			return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $856
JUMPV
LABELV $862
line 2116
;2114:		}
;2115:		// check if on right arrow
;2116:		r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2117
;2117:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $864
line 2118
;2118:			return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $856
JUMPV
LABELV $864
line 2121
;2119:		}
;2120:		// check if on thumb
;2121:		thumbstart = Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 52
INDIRI4
ASGNI4
line 2122
;2122:		r.x = thumbstart;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 2123
;2123:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $866
line 2124
;2124:			return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $856
JUMPV
LABELV $866
line 2126
;2125:		}
;2126:		r.x = item->window.rect.x + SCROLLBAR_SIZE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2127
;2127:		r.w = thumbstart - r.x;
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 2128
;2128:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $869
line 2129
;2129:			return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $856
JUMPV
LABELV $869
line 2131
;2130:		}
;2131:		r.x = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2132
;2132:		r.w = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2133
;2133:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $858
line 2134
;2134:			return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $856
JUMPV
line 2136
;2135:		}
;2136:	} else {
LABELV $857
line 2137
;2137:		r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2138
;2138:		r.y = item->window.rect.y;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 2139
;2139:		r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 36
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
ASGNF4
line 2140
;2140:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $877
line 2141
;2141:			return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $856
JUMPV
LABELV $877
line 2143
;2142:		}
;2143:		r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2144
;2144:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $880
line 2145
;2145:			return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $856
JUMPV
LABELV $880
line 2147
;2146:		}
;2147:		thumbstart = Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 52
INDIRI4
ASGNI4
line 2148
;2148:		r.y = thumbstart;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 2149
;2149:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $883
line 2150
;2150:			return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $856
JUMPV
LABELV $883
line 2152
;2151:		}
;2152:		r.y = item->window.rect.y + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2153
;2153:		r.h = thumbstart - r.y;
ADDRLP4 0+12
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
line 2154
;2154:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $888
line 2155
;2155:			return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $856
JUMPV
LABELV $888
line 2157
;2156:		}
;2157:		r.y = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2158
;2158:		r.h = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+12
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2159
;2159:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $892
line 2160
;2160:			return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $856
JUMPV
LABELV $892
line 2162
;2161:		}
;2162:	}
LABELV $858
line 2163
;2163:	return 0;
CNSTI4 0
RETI4
LABELV $856
endproc Item_ListBox_OverLB 72 12
export Item_ListBox_MouseEnter
proc Item_ListBox_MouseEnter 56 12
line 2168
;2164:}
;2165:
;2166:
;2167:void Item_ListBox_MouseEnter(itemDef_t *item, float x, float y) 
;2168:{
line 2170
;2169:	rectDef_t r;
;2170:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2172
;2171:        
;2172:	item->window.flags &= ~(WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -63489
BANDI4
ASGNI4
line 2173
;2173:	item->window.flags |= Item_ListBox_OverLB(item, x, y);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Item_ListBox_OverLB
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 28
INDIRI4
BORI4
ASGNI4
line 2175
;2174:
;2175:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $895
line 2176
;2176:		if (!(item->window.flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN))) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 63488
BANDI4
CNSTI4 0
NEI4 $896
line 2178
;2177:			// check for selection hit as we have exausted buttons and thumb
;2178:			if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $896
line 2179
;2179:				r.x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2180
;2180:				r.y = item->window.rect.y;
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 2181
;2181:				r.h = item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2182
;2182:				r.w = item->window.rect.w - listPtr->drawPadding;
ADDRLP4 36
CNSTI4 8
ASGNI4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2183
;2183:				if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $896
line 2184
;2184:					listPtr->cursorPos =  (int)((x - r.x) / listPtr->elementWidth)  + listPtr->startPos;
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 44
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
DIVF4
CVFI4 4
ADDRLP4 44
INDIRP4
INDIRI4
ADDI4
ASGNI4
line 2185
;2185:					if (listPtr->cursorPos >= listPtr->endPos) {
ADDRLP4 48
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $896
line 2186
;2186:						listPtr->cursorPos = listPtr->endPos;
ADDRLP4 52
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2187
;2187:					}
line 2188
;2188:				}
line 2189
;2189:			} else {
line 2191
;2190:				// text hit.. 
;2191:			}
line 2192
;2192:		}
line 2193
;2193:	} else if (!(item->window.flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN))) {
ADDRGP4 $896
JUMPV
LABELV $895
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 63488
BANDI4
CNSTI4 0
NEI4 $908
line 2194
;2194:		r.x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2195
;2195:		r.y = item->window.rect.y;
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 2196
;2196:		r.w = item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2197
;2197:		r.h = item->window.rect.h - listPtr->drawPadding;
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2198
;2198:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $913
line 2199
;2199:			listPtr->cursorPos =  (int)((y - 2 - r.y) / listPtr->elementHeight)  + listPtr->startPos;
ADDRLP4 40
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRF4
CNSTF4 1073741824
SUBF4
ADDRLP4 4+4
INDIRF4
SUBF4
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
CVFI4 4
ADDRLP4 40
INDIRP4
INDIRI4
ADDI4
ASGNI4
line 2200
;2200:			if (listPtr->cursorPos > listPtr->endPos) {
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $916
line 2201
;2201:				listPtr->cursorPos = listPtr->endPos;
ADDRLP4 48
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2202
;2202:			}
LABELV $916
line 2203
;2203:		}
LABELV $913
line 2204
;2204:	}
LABELV $908
LABELV $896
line 2205
;2205:}
LABELV $894
endproc Item_ListBox_MouseEnter 56 12
export Item_MouseEnter
proc Item_MouseEnter 44 12
line 2207
;2206:
;2207:void Item_MouseEnter(itemDef_t *item, float x, float y) {
line 2209
;2208:	rectDef_t r;
;2209:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $919
line 2210
;2210:		r = item->textRect;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 2211
;2211:		r.y -= r.h;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
line 2215
;2212:		// in the text rect?
;2213:
;2214:		// items can be enabled and disabled based on cvars
;2215:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $923
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $923
line 2216
;2216:			return;
ADDRGP4 $918
JUMPV
LABELV $923
line 2219
;2217:		}
;2218:
;2219:		if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $925
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 28
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $925
line 2220
;2220:			return;
ADDRGP4 $918
JUMPV
LABELV $925
line 2223
;2221:		}
;2222:
;2223:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $927
line 2224
;2224:			if (!(item->window.flags & WINDOW_MOUSEOVERTEXT)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $929
line 2225
;2225:				Item_RunScript(item, item->mouseEnterText);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 248
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2226
;2226:				item->window.flags |= WINDOW_MOUSEOVERTEXT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 2227
;2227:			}
LABELV $929
line 2228
;2228:			if (!(item->window.flags & WINDOW_MOUSEOVER)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $928
line 2229
;2229:				Item_RunScript(item, item->mouseEnter);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2230
;2230:				item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 2231
;2231:			}
line 2233
;2232:
;2233:		} else {
ADDRGP4 $928
JUMPV
LABELV $927
line 2235
;2234:			// not in the text rect
;2235:			if (item->window.flags & WINDOW_MOUSEOVERTEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $933
line 2237
;2236:				// if we were
;2237:				Item_RunScript(item, item->mouseExitText);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 252
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2238
;2238:				item->window.flags &= ~WINDOW_MOUSEOVERTEXT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2239
;2239:			}
LABELV $933
line 2240
;2240:			if (!(item->window.flags & WINDOW_MOUSEOVER)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $935
line 2241
;2241:				Item_RunScript(item, item->mouseEnter);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2242
;2242:				item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 2243
;2243:			}
LABELV $935
line 2245
;2244:
;2245:			if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $937
line 2246
;2246:				Item_ListBox_MouseEnter(item, x, y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Item_ListBox_MouseEnter
CALLV
pop
line 2247
;2247:			}
ADDRGP4 $938
JUMPV
LABELV $937
line 2248
;2248:			else if ( item->type == ITEM_TYPE_TEXTSCROLL )
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 14
NEI4 $939
line 2249
;2249:			{
line 2250
;2250:				Item_TextScroll_MouseEnter ( item, x, y );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Item_TextScroll_MouseEnter
CALLV
pop
line 2251
;2251:			}
LABELV $939
LABELV $938
line 2252
;2252:		}
LABELV $928
line 2253
;2253:	}
LABELV $919
line 2254
;2254:}
LABELV $918
endproc Item_MouseEnter 44 12
export Item_MouseLeave
proc Item_MouseLeave 8 8
line 2256
;2255:
;2256:void Item_MouseLeave(itemDef_t *item) {
line 2257
;2257:  if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $942
line 2258
;2258:    if (item->window.flags & WINDOW_MOUSEOVERTEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $944
line 2259
;2259:      Item_RunScript(item, item->mouseExitText);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2260
;2260:      item->window.flags &= ~WINDOW_MOUSEOVERTEXT;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2261
;2261:    }
LABELV $944
line 2262
;2262:    Item_RunScript(item, item->mouseExit);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2263
;2263:    item->window.flags &= ~(WINDOW_LB_RIGHTARROW | WINDOW_LB_LEFTARROW);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -6145
BANDI4
ASGNI4
line 2264
;2264:  }
LABELV $942
line 2265
;2265:}
LABELV $941
endproc Item_MouseLeave 8 8
export Menu_HitTest
proc Menu_HitTest 8 12
line 2267
;2266:
;2267:itemDef_t *Menu_HitTest(menuDef_t *menu, float x, float y) {
line 2269
;2268:  int i;
;2269:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $950
JUMPV
LABELV $947
line 2270
;2270:    if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $951
line 2271
;2271:      return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $946
JUMPV
LABELV $951
line 2273
;2272:    }
;2273:  }
LABELV $948
line 2269
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $950
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $947
line 2274
;2274:  return NULL;
CNSTP4 0
RETP4
LABELV $946
endproc Menu_HitTest 8 12
export Item_SetMouseOver
proc Item_SetMouseOver 4 0
line 2277
;2275:}
;2276:
;2277:void Item_SetMouseOver(itemDef_t *item, qboolean focus) {
line 2278
;2278:  if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $954
line 2279
;2279:    if (focus) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $956
line 2280
;2280:      item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 2281
;2281:    } else {
ADDRGP4 $957
JUMPV
LABELV $956
line 2282
;2282:      item->window.flags &= ~WINDOW_MOUSEOVER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 2283
;2283:    }
LABELV $957
line 2284
;2284:  }
LABELV $954
line 2285
;2285:}
LABELV $953
endproc Item_SetMouseOver 4 0
export Item_OwnerDraw_HandleKey
proc Item_OwnerDraw_HandleKey 12 16
line 2288
;2286:
;2287:
;2288:qboolean Item_OwnerDraw_HandleKey(itemDef_t *item, int key) {
line 2289
;2289:  if (item && DC->ownerDrawHandleKey) {
ADDRLP4 0
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRU4
EQU4 $959
ADDRGP4 DC
INDIRP4
CNSTI4 140
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRU4
EQU4 $959
line 2290
;2290:    return DC->ownerDrawHandleKey(item->window.ownerDraw, item->window.ownerDrawFlags, &item->special, key);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 540
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 140
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $958
JUMPV
LABELV $959
line 2292
;2291:  }
;2292:  return qfalse;
CNSTI4 0
RETI4
LABELV $958
endproc Item_OwnerDraw_HandleKey 12 16
export Item_ListBox_HandleKey
proc Item_ListBox_HandleKey 72 12
line 2295
;2293:}
;2294:
;2295:qboolean Item_ListBox_HandleKey(itemDef_t *item, int key, qboolean down, qboolean force) {
line 2296
;2296:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2297
;2297:	int count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 2300
;2298:	int max, viewmax;
;2299:
;2300:	if (force || (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS)) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $964
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $962
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 28
INDIRI4
EQI4 $962
LABELV $964
line 2301
;2301:		max = Item_ListBox_MaxScroll(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 2302
;2302:		if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $965
line 2303
;2303:			viewmax = (item->window.rect.w / listPtr->elementWidth);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 2304
;2304:			if ( key == K_LEFTARROW || key == K_KP_LEFTARROW ) 
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 134
EQI4 $969
ADDRLP4 36
INDIRI4
CNSTI4 163
NEI4 $967
LABELV $969
line 2305
;2305:			{
line 2306
;2306:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $970
line 2307
;2307:					listPtr->cursorPos--;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2308
;2308:					if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $972
line 2309
;2309:						listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 2310
;2310:					}
LABELV $972
line 2311
;2311:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $974
line 2312
;2312:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2313
;2313:					}
LABELV $974
line 2314
;2314:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $976
line 2315
;2315:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2316
;2316:					}
LABELV $976
line 2317
;2317:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2318
;2318:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLI4
pop
line 2319
;2319:				}
ADDRGP4 $971
JUMPV
LABELV $970
line 2320
;2320:				else {
line 2321
;2321:					listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2322
;2322:					if (listPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $978
line 2323
;2323:						listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
LABELV $978
line 2324
;2324:				}
LABELV $971
line 2325
;2325:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $961
JUMPV
LABELV $967
line 2327
;2326:			}
;2327:			if ( key == K_RIGHTARROW || key == K_KP_RIGHTARROW ) 
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 135
EQI4 $982
ADDRLP4 40
INDIRI4
CNSTI4 165
NEI4 $966
LABELV $982
line 2328
;2328:			{
line 2329
;2329:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $983
line 2330
;2330:					listPtr->cursorPos++;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2331
;2331:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $985
line 2332
;2332:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2333
;2333:					}
LABELV $985
line 2334
;2334:					if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $987
line 2335
;2335:						listPtr->cursorPos = count-1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2336
;2336:					}
LABELV $987
line 2337
;2337:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $989
line 2338
;2338:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2339
;2339:					}
LABELV $989
line 2340
;2340:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2341
;2341:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLI4
pop
line 2342
;2342:				}
ADDRGP4 $984
JUMPV
LABELV $983
line 2343
;2343:				else {
line 2344
;2344:					listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2345
;2345:					if (listPtr->startPos >= count)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $991
line 2346
;2346:						listPtr->startPos = count-1;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $991
line 2347
;2347:				}
LABELV $984
line 2348
;2348:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $961
JUMPV
line 2350
;2349:			}
;2350:		}
LABELV $965
line 2351
;2351:		else {
line 2352
;2352:			viewmax = (item->window.rect.h / listPtr->elementHeight);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 2353
;2353:			if ( key == K_UPARROW || key == K_KP_UPARROW ) 
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 132
EQI4 $995
ADDRLP4 36
INDIRI4
CNSTI4 161
NEI4 $993
LABELV $995
line 2354
;2354:			{
line 2355
;2355:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $996
line 2356
;2356:					listPtr->cursorPos--;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2357
;2357:					if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $998
line 2358
;2358:						listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 2359
;2359:					}
LABELV $998
line 2360
;2360:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $1000
line 2361
;2361:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2362
;2362:					}
LABELV $1000
line 2363
;2363:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $1002
line 2364
;2364:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2365
;2365:					}
LABELV $1002
line 2366
;2366:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2367
;2367:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLI4
pop
line 2368
;2368:				}
ADDRGP4 $997
JUMPV
LABELV $996
line 2369
;2369:				else {
line 2370
;2370:					listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2371
;2371:					if (listPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $1004
line 2372
;2372:						listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1004
line 2373
;2373:				}
LABELV $997
line 2374
;2374:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $961
JUMPV
LABELV $993
line 2376
;2375:			}
;2376:			if ( key == K_DOWNARROW || key == K_KP_DOWNARROW ) 
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 133
EQI4 $1008
ADDRLP4 40
INDIRI4
CNSTI4 167
NEI4 $1006
LABELV $1008
line 2377
;2377:			{
line 2378
;2378:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1009
line 2379
;2379:					listPtr->cursorPos++;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2380
;2380:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $1011
line 2381
;2381:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2382
;2382:					}
LABELV $1011
line 2383
;2383:					if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1013
line 2384
;2384:						listPtr->cursorPos = count-1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2385
;2385:					}
LABELV $1013
line 2386
;2386:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $1015
line 2387
;2387:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2388
;2388:					}
LABELV $1015
line 2389
;2389:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2390
;2390:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLI4
pop
line 2391
;2391:				}
ADDRGP4 $1010
JUMPV
LABELV $1009
line 2392
;2392:				else {
line 2393
;2393:					listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2394
;2394:					if (listPtr->startPos > max)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $1017
line 2395
;2395:						listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
LABELV $1017
line 2396
;2396:				}
LABELV $1010
line 2397
;2397:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $961
JUMPV
LABELV $1006
line 2399
;2398:			}
;2399:		}
LABELV $966
line 2401
;2400:		// mouse hit
;2401:		if (key == K_MOUSE1 || key == K_MOUSE2) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 178
EQI4 $1021
ADDRLP4 36
INDIRI4
CNSTI4 179
NEI4 $1019
LABELV $1021
line 2402
;2402:			if (item->window.flags & WINDOW_LB_LEFTARROW) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1022
line 2403
;2403:				listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2404
;2404:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $1023
line 2405
;2405:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 2406
;2406:				}
line 2407
;2407:			} else if (item->window.flags & WINDOW_LB_RIGHTARROW) {
ADDRGP4 $1023
JUMPV
LABELV $1022
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1026
line 2409
;2408:				// one down
;2409:				listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2410
;2410:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $1027
line 2411
;2411:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 2412
;2412:				}
line 2413
;2413:			} else if (item->window.flags & WINDOW_LB_PGUP) {
ADDRGP4 $1027
JUMPV
LABELV $1026
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $1030
line 2415
;2414:				// page up
;2415:				listPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 2416
;2416:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $1031
line 2417
;2417:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 2418
;2418:				}
line 2419
;2419:			} else if (item->window.flags & WINDOW_LB_PGDN) {
ADDRGP4 $1031
JUMPV
LABELV $1030
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $1034
line 2421
;2420:				// page down
;2421:				listPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 2422
;2422:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $1035
line 2423
;2423:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 2424
;2424:				}
line 2425
;2425:			} else if (item->window.flags & WINDOW_LB_THUMB) {
ADDRGP4 $1035
JUMPV
LABELV $1034
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1038
line 2427
;2426:				// Display_SetCaptureItem(item);
;2427:			} else {
ADDRGP4 $1039
JUMPV
LABELV $1038
line 2429
;2428:				// select an item
;2429:				if (DC->realTime < lastListBoxClickTime && listPtr->doubleClick) {
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRGP4 lastListBoxClickTime
INDIRI4
GEI4 $1040
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1040
line 2430
;2430:					Item_RunScript(item, listPtr->doubleClick);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2431
;2431:				}
LABELV $1040
line 2432
;2432:				lastListBoxClickTime = DC->realTime + DOUBLE_CLICK_DELAY;
ADDRGP4 lastListBoxClickTime
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 300
ADDI4
ASGNI4
line 2433
;2433:				if (item->cursorPos != listPtr->cursorPos) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
EQI4 $1042
line 2434
;2434:					int prePos = item->cursorPos;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ASGNI4
line 2436
;2435:					
;2436:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2438
;2437:
;2438:					if (!DC->feederSelection(item->special, item->cursorPos))
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $1044
line 2439
;2439:					{
line 2440
;2440:						item->cursorPos = listPtr->cursorPos = prePos;
ADDRLP4 52
ADDRLP4 40
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 2441
;2441:					}
LABELV $1044
line 2442
;2442:				}
LABELV $1042
line 2443
;2443:			}
LABELV $1039
LABELV $1035
LABELV $1031
LABELV $1027
LABELV $1023
line 2444
;2444:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $961
JUMPV
LABELV $1019
line 2446
;2445:		}
;2446:		if ( key == K_HOME || key == K_KP_HOME) {
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 143
EQI4 $1048
ADDRLP4 40
INDIRI4
CNSTI4 160
NEI4 $1046
LABELV $1048
line 2448
;2447:			// home
;2448:			listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 2449
;2449:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $961
JUMPV
LABELV $1046
line 2451
;2450:		}
;2451:		if ( key == K_END || key == K_KP_END) {
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 144
EQI4 $1051
ADDRLP4 44
INDIRI4
CNSTI4 166
NEI4 $1049
LABELV $1051
line 2453
;2452:			// end
;2453:			listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 2454
;2454:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $961
JUMPV
LABELV $1049
line 2456
;2455:		}
;2456:		if (key == K_PGUP || key == K_KP_PGUP ) {
ADDRLP4 48
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 142
EQI4 $1054
ADDRLP4 48
INDIRI4
CNSTI4 162
NEI4 $1052
LABELV $1054
line 2458
;2457:			// page up
;2458:			if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1055
line 2459
;2459:				listPtr->cursorPos -= viewmax;
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 2460
;2460:				if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1057
line 2461
;2461:					listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 2462
;2462:				}
LABELV $1057
line 2463
;2463:				if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $1059
line 2464
;2464:					listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2465
;2465:				}
LABELV $1059
line 2466
;2466:				if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $1061
line 2467
;2467:					listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2468
;2468:				}
LABELV $1061
line 2469
;2469:				item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2470
;2470:				DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLI4
pop
line 2471
;2471:			}
ADDRGP4 $1056
JUMPV
LABELV $1055
line 2472
;2472:			else {
line 2473
;2473:				listPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 2474
;2474:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $1063
line 2475
;2475:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 2476
;2476:				}
LABELV $1063
line 2477
;2477:			}
LABELV $1056
line 2478
;2478:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $961
JUMPV
LABELV $1052
line 2480
;2479:		}
;2480:		if ( key == K_PGDN || key == K_KP_PGDN ) {
ADDRLP4 52
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 141
EQI4 $1067
ADDRLP4 52
INDIRI4
CNSTI4 168
NEI4 $1065
LABELV $1067
line 2482
;2481:			// page down
;2482:			if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1068
line 2483
;2483:				listPtr->cursorPos += viewmax;
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 2484
;2484:				if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $1070
line 2485
;2485:					listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2486
;2486:				}
LABELV $1070
line 2487
;2487:				if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1072
line 2488
;2488:					listPtr->cursorPos = count-1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2489
;2489:				}
LABELV $1072
line 2490
;2490:				if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $1074
line 2491
;2491:					listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2492
;2492:				}
LABELV $1074
line 2493
;2493:				item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2494
;2494:				DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLI4
pop
line 2495
;2495:			}
ADDRGP4 $1069
JUMPV
LABELV $1068
line 2496
;2496:			else {
line 2497
;2497:				listPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 2498
;2498:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $1076
line 2499
;2499:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 2500
;2500:				}
LABELV $1076
line 2501
;2501:			}
LABELV $1069
line 2502
;2502:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $961
JUMPV
LABELV $1065
line 2504
;2503:		}
;2504:	}
LABELV $962
line 2505
;2505:	return qfalse;
CNSTI4 0
RETI4
LABELV $961
endproc Item_ListBox_HandleKey 72 12
export Item_YesNo_HandleKey
proc Item_YesNo_HandleKey 32 12
line 2508
;2506:}
;2507:
;2508:qboolean Item_YesNo_HandleKey(itemDef_t *item, int key) {
line 2510
;2509:
;2510:  if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS && item->cvar) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $1079
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $1079
ADDRLP4 12
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1079
line 2511
;2511:		if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
EQI4 $1085
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $1085
ADDRLP4 16
INDIRI4
CNSTI4 179
EQI4 $1085
ADDRLP4 16
INDIRI4
CNSTI4 180
NEI4 $1081
LABELV $1085
line 2512
;2512:	    DC->setCVar(item->cvar, va("%i", !DC->getCVarValue(item->cvar)));
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 0
NEF4 $1088
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $1089
JUMPV
LABELV $1088
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $1089
ADDRGP4 $1086
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 2513
;2513:		  return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1078
JUMPV
LABELV $1081
line 2515
;2514:		}
;2515:  }
LABELV $1079
line 2517
;2516:
;2517:  return qfalse;
CNSTI4 0
RETI4
LABELV $1078
endproc Item_YesNo_HandleKey 32 12
export Item_Multi_CountSettings
proc Item_Multi_CountSettings 4 0
line 2521
;2518:
;2519:}
;2520:
;2521:int Item_Multi_CountSettings(itemDef_t *item) {
line 2522
;2522:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2523
;2523:	if (multiPtr == NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1091
line 2524
;2524:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1090
JUMPV
LABELV $1091
line 2526
;2525:	}
;2526:	return multiPtr->count;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
RETI4
LABELV $1090
endproc Item_Multi_CountSettings 4 0
export Item_Multi_FindCvarByValue
proc Item_Multi_FindCvarByValue 2064 12
line 2529
;2527:}
;2528:
;2529:int Item_Multi_FindCvarByValue(itemDef_t *item) {
line 2531
;2530:	char buff[2048];
;2531:	float value = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 2533
;2532:	int i;
;2533:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2534
;2534:	if (multiPtr) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1094
line 2535
;2535:		if (multiPtr->strDef) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1096
line 2536
;2536:	    DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 2048
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 2537
;2537:		} else {
ADDRGP4 $1097
JUMPV
LABELV $1096
line 2538
;2538:			value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 2060
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 2060
INDIRF4
ASGNF4
line 2539
;2539:		}
LABELV $1097
line 2540
;2540:		for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1101
JUMPV
LABELV $1098
line 2541
;2541:			if (multiPtr->strDef) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1102
line 2542
;2542:				if (Q_stricmp(buff, multiPtr->cvarStr[i]) == 0) {
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 2060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
NEI4 $1103
line 2543
;2543:					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1093
JUMPV
line 2545
;2544:				}
;2545:			} else {
LABELV $1102
line 2546
;2546: 				if (multiPtr->cvarValue[i] == value) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $1106
line 2547
;2547: 					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1093
JUMPV
LABELV $1106
line 2549
;2548: 				}
;2549: 			}
LABELV $1103
line 2550
;2550: 		}
LABELV $1099
line 2540
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1101
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $1098
line 2551
;2551:	}
LABELV $1094
line 2552
;2552:	return 0;
CNSTI4 0
RETI4
LABELV $1093
endproc Item_Multi_FindCvarByValue 2064 12
export Item_Multi_Setting
proc Item_Multi_Setting 2064 12
line 2555
;2553:}
;2554:
;2555:const char *Item_Multi_Setting(itemDef_t *item) {
line 2557
;2556:	char buff[2048];
;2557:	float value = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 2559
;2558:	int i;
;2559:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2560
;2560:	if (multiPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1109
line 2561
;2561:		if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1111
line 2562
;2562:	    DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 2048
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 2563
;2563:		} else {
ADDRGP4 $1112
JUMPV
LABELV $1111
line 2564
;2564:			value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 2060
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 2060
INDIRF4
ASGNF4
line 2565
;2565:		}
LABELV $1112
line 2566
;2566:		for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1116
JUMPV
LABELV $1113
line 2567
;2567:			if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1117
line 2568
;2568:				if (Q_stricmp(buff, multiPtr->cvarStr[i]) == 0) {
ADDRLP4 12
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 2060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
NEI4 $1118
line 2569
;2569:					return multiPtr->cvarList[i];
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1108
JUMPV
line 2571
;2570:				}
;2571:			} else {
LABELV $1117
line 2572
;2572: 				if (multiPtr->cvarValue[i] == value) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $1121
line 2573
;2573:					return multiPtr->cvarList[i];
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1108
JUMPV
LABELV $1121
line 2575
;2574: 				}
;2575: 			}
LABELV $1118
line 2576
;2576: 		}
LABELV $1114
line 2566
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1116
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $1113
line 2577
;2577:	}
LABELV $1109
line 2578
;2578:	return "";
ADDRGP4 $99
RETP4
LABELV $1108
endproc Item_Multi_Setting 2064 12
export Item_Multi_HandleKey
proc Item_Multi_HandleKey 56 12
line 2581
;2579:}
;2580:
;2581:qboolean Item_Multi_HandleKey(itemDef_t *item, int key) {
line 2582
;2582:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2583
;2583:	if (multiPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1124
line 2584
;2584:	  if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS && item->cvar) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1126
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 12
INDIRI4
EQI4 $1126
ADDRLP4 16
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1126
line 2585
;2585:			if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 178
EQI4 $1132
ADDRLP4 20
INDIRI4
CNSTI4 13
EQI4 $1132
ADDRLP4 20
INDIRI4
CNSTI4 179
EQI4 $1132
ADDRLP4 20
INDIRI4
CNSTI4 180
NEI4 $1128
LABELV $1132
line 2586
;2586:				int current = Item_Multi_FindCvarByValue(item) + 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 Item_Multi_FindCvarByValue
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2587
;2587:				int max = Item_Multi_CountSettings(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_Multi_CountSettings
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 36
INDIRI4
ASGNI4
line 2588
;2588:				if ( current < 0 || current >= max ) {
ADDRLP4 40
ADDRLP4 24
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
LTI4 $1135
ADDRLP4 40
INDIRI4
ADDRLP4 28
INDIRI4
LTI4 $1133
LABELV $1135
line 2589
;2589:					current = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 2590
;2590:				}
LABELV $1133
line 2591
;2591:				if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1136
line 2592
;2592:					DC->setCVar(item->cvar, multiPtr->cvarStr[current]);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 2593
;2593:				} else {
ADDRGP4 $1137
JUMPV
LABELV $1136
line 2594
;2594:					float value = multiPtr->cvarValue[current];
ADDRLP4 44
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ASGNF4
line 2595
;2595:					if (((float)((int) value)) == value) {
ADDRLP4 48
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
CVFI4 4
CVIF4 4
ADDRLP4 48
INDIRF4
NEF4 $1138
line 2596
;2596:						DC->setCVar(item->cvar, va("%i", (int) value ));
ADDRGP4 $1086
ARGP4
ADDRLP4 44
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 2597
;2597:					}
ADDRGP4 $1139
JUMPV
LABELV $1138
line 2598
;2598:					else {
line 2599
;2599:						DC->setCVar(item->cvar, va("%f", value ));
ADDRGP4 $1140
ARGP4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 2600
;2600:					}
LABELV $1139
line 2601
;2601:				}
LABELV $1137
line 2602
;2602:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1123
JUMPV
LABELV $1128
line 2604
;2603:			}
;2604:		}
LABELV $1126
line 2605
;2605:	}
LABELV $1124
line 2606
;2606:  return qfalse;
CNSTI4 0
RETI4
LABELV $1123
endproc Item_Multi_HandleKey 56 12
export Item_TextField_HandleKey
proc Item_TextField_HandleKey 2100 12
line 2609
;2607:}
;2608:
;2609:qboolean Item_TextField_HandleKey(itemDef_t *item, int key) {
line 2612
;2610:	char buff[2048];
;2611:	int len;
;2612:	itemDef_t *newItem = NULL;
ADDRLP4 2052
CNSTP4 0
ASGNP4
line 2613
;2613:	editFieldDef_t *editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2615
;2614:
;2615:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1142
line 2617
;2616:
;2617:		buff[0] = 0;
ADDRLP4 4
CNSTI1 0
ASGNI1
line 2618
;2618:		DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 2048
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 2619
;2619:		len = strlen(buff);
ADDRLP4 4
ARGP4
ADDRLP4 2060
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2056
ADDRLP4 2060
INDIRI4
ASGNI4
line 2620
;2620:		if (editPtr->maxChars && len > editPtr->maxChars) {
ADDRLP4 2064
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2064
INDIRI4
CNSTI4 0
EQI4 $1144
ADDRLP4 2056
INDIRI4
ADDRLP4 2064
INDIRI4
LEI4 $1144
line 2621
;2621:			len = editPtr->maxChars;
ADDRLP4 2056
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 2622
;2622:		}
LABELV $1144
line 2623
;2623:		if ( key & K_CHAR_FLAG ) {
ADDRFP4 4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1146
line 2624
;2624:			key &= ~K_CHAR_FLAG;
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 2627
;2625:
;2626:
;2627:			if (key == 'h' - 'a' + 1 )	{	// ctrl-h is backspace
ADDRFP4 4
INDIRI4
CNSTI4 8
NEI4 $1148
line 2628
;2628:				if ( item->cursorPos > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1150
line 2629
;2629:					memmove( &buff[item->cursorPos - 1], &buff[item->cursorPos], len + 1 - item->cursorPos);
ADDRLP4 2068
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2068
INDIRI4
ADDRLP4 4-1
ADDP4
ARGP4
ADDRLP4 2068
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 2056
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 2068
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2630
;2630:					item->cursorPos--;
ADDRLP4 2072
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ASGNP4
ADDRLP4 2072
INDIRP4
ADDRLP4 2072
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2631
;2631:					if (item->cursorPos < editPtr->paintOffset) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
GEI4 $1153
line 2632
;2632:						editPtr->paintOffset--;
ADDRLP4 2076
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 2076
INDIRP4
ADDRLP4 2076
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2633
;2633:					}
LABELV $1153
line 2634
;2634:				}
LABELV $1150
line 2635
;2635:				DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 2636
;2636:	    		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1148
line 2643
;2637:			}
;2638:
;2639:
;2640:			//
;2641:			// ignore any non printable chars
;2642:			//
;2643:			if ( key < 32 || !item->cvar) {
ADDRFP4 4
INDIRI4
CNSTI4 32
LTI4 $1157
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1155
LABELV $1157
line 2644
;2644:			    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1155
line 2647
;2645:		    }
;2646:
;2647:			if (item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1158
line 2648
;2648:				if (key < '0' || key > '9') {
ADDRLP4 2068
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 48
LTI4 $1162
ADDRLP4 2068
INDIRI4
CNSTI4 57
LEI4 $1160
LABELV $1162
line 2649
;2649:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1160
line 2651
;2650:				}
;2651:			}
LABELV $1158
line 2653
;2652:
;2653:			if (!DC->getOverstrikeMode()) {
ADDRLP4 2068
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $1163
line 2654
;2654:				if (( len == MAX_EDITFIELD - 1 ) || (editPtr->maxChars && len >= editPtr->maxChars)) {
ADDRLP4 2072
ADDRLP4 2056
INDIRI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 255
EQI4 $1167
ADDRLP4 2076
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
EQI4 $1165
ADDRLP4 2072
INDIRI4
ADDRLP4 2076
INDIRI4
LTI4 $1165
LABELV $1167
line 2655
;2655:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1165
line 2657
;2656:				}
;2657:				memmove( &buff[item->cursorPos + 1], &buff[item->cursorPos], len + 1 - item->cursorPos );
ADDRLP4 2080
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2080
INDIRI4
ADDRLP4 4+1
ADDP4
ARGP4
ADDRLP4 2080
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 2056
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 2080
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2658
;2658:			} else {
ADDRGP4 $1164
JUMPV
LABELV $1163
line 2659
;2659:				if (editPtr->maxChars && item->cursorPos >= editPtr->maxChars) {
ADDRLP4 2072
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
EQI4 $1169
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 2072
INDIRI4
LTI4 $1169
line 2660
;2660:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1169
line 2662
;2661:				}
;2662:			}
LABELV $1164
line 2664
;2663:
;2664:			buff[item->cursorPos] = key;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 2667
;2665:
;2666:			//rww - nul-terminate!
;2667:			if (item->cursorPos+1 < 2048)
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 2048
GEI4 $1171
line 2668
;2668:			{
line 2669
;2669:				buff[item->cursorPos+1] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 4+1
ADDP4
CNSTI1 0
ASGNI1
line 2670
;2670:			}
ADDRGP4 $1172
JUMPV
LABELV $1171
line 2672
;2671:			else
;2672:			{
line 2673
;2673:				buff[item->cursorPos] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 2674
;2674:			}
LABELV $1172
line 2676
;2675:
;2676:			DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 2678
;2677:
;2678:			if (item->cursorPos < len + 1) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 2056
INDIRI4
CNSTI4 1
ADDI4
GEI4 $1147
line 2679
;2679:				item->cursorPos++;
ADDRLP4 2072
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ASGNP4
ADDRLP4 2072
INDIRP4
ADDRLP4 2072
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2680
;2680:				if (editPtr->maxPaintChars && item->cursorPos > editPtr->maxPaintChars) {
ADDRLP4 2076
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
EQI4 $1147
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 2076
INDIRI4
LEI4 $1147
line 2681
;2681:					editPtr->paintOffset++;
ADDRLP4 2080
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 2080
INDIRP4
ADDRLP4 2080
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2682
;2682:				}
line 2683
;2683:			}
line 2685
;2684:
;2685:		} else {
ADDRGP4 $1147
JUMPV
LABELV $1146
line 2687
;2686:
;2687:			if ( key == K_DEL || key == K_KP_DEL ) {
ADDRLP4 2068
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 140
EQI4 $1180
ADDRLP4 2068
INDIRI4
CNSTI4 171
NEI4 $1178
LABELV $1180
line 2688
;2688:				if ( item->cursorPos < len ) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 2056
INDIRI4
GEI4 $1181
line 2689
;2689:					memmove( buff + item->cursorPos, buff + item->cursorPos + 1, len - item->cursorPos);
ADDRLP4 2072
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2072
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 2072
INDIRI4
ADDRLP4 4+1
ADDP4
ARGP4
ADDRLP4 2056
INDIRI4
ADDRLP4 2072
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2690
;2690:					DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 2691
;2691:				}
LABELV $1181
line 2692
;2692:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1178
line 2695
;2693:			}
;2694:
;2695:			if ( key == K_RIGHTARROW || key == K_KP_RIGHTARROW ) 
ADDRLP4 2072
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 135
EQI4 $1186
ADDRLP4 2072
INDIRI4
CNSTI4 165
NEI4 $1184
LABELV $1186
line 2696
;2696:			{
line 2697
;2697:				if (editPtr->maxPaintChars && item->cursorPos >= editPtr->maxPaintChars && item->cursorPos < len) {
ADDRLP4 2076
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
EQI4 $1187
ADDRLP4 2080
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2080
INDIRI4
ADDRLP4 2076
INDIRI4
LTI4 $1187
ADDRLP4 2080
INDIRI4
ADDRLP4 2056
INDIRI4
GEI4 $1187
line 2698
;2698:					item->cursorPos++;
ADDRLP4 2084
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ASGNP4
ADDRLP4 2084
INDIRP4
ADDRLP4 2084
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2699
;2699:					editPtr->paintOffset++;
ADDRLP4 2088
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 2088
INDIRP4
ADDRLP4 2088
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2700
;2700:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1187
line 2702
;2701:				}
;2702:				if (item->cursorPos < len) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 2056
INDIRI4
GEI4 $1189
line 2703
;2703:					item->cursorPos++;
ADDRLP4 2084
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ASGNP4
ADDRLP4 2084
INDIRP4
ADDRLP4 2084
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2704
;2704:				} 
LABELV $1189
line 2705
;2705:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1184
line 2708
;2706:			}
;2707:
;2708:			if ( key == K_LEFTARROW || key == K_KP_LEFTARROW ) 
ADDRLP4 2076
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 134
EQI4 $1193
ADDRLP4 2076
INDIRI4
CNSTI4 163
NEI4 $1191
LABELV $1193
line 2709
;2709:			{
line 2710
;2710:				if ( item->cursorPos > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1194
line 2711
;2711:					item->cursorPos--;
ADDRLP4 2080
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ASGNP4
ADDRLP4 2080
INDIRP4
ADDRLP4 2080
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2712
;2712:				}
LABELV $1194
line 2713
;2713:				if (item->cursorPos < editPtr->paintOffset) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
GEI4 $1196
line 2714
;2714:					editPtr->paintOffset--;
ADDRLP4 2080
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 2080
INDIRP4
ADDRLP4 2080
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2715
;2715:				}
LABELV $1196
line 2716
;2716:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1191
line 2719
;2717:			}
;2718:
;2719:			if ( key == K_HOME || key == K_KP_HOME) {// || ( tolower(key) == 'a' && trap_Key_IsDown( K_CTRL ) ) ) {
ADDRLP4 2080
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2080
INDIRI4
CNSTI4 143
EQI4 $1200
ADDRLP4 2080
INDIRI4
CNSTI4 160
NEI4 $1198
LABELV $1200
line 2720
;2720:				item->cursorPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
line 2721
;2721:				editPtr->paintOffset = 0;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 2722
;2722:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1198
line 2725
;2723:			}
;2724:
;2725:			if ( key == K_END || key == K_KP_END)  {// ( tolower(key) == 'e' && trap_Key_IsDown( K_CTRL ) ) ) {
ADDRLP4 2084
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 144
EQI4 $1203
ADDRLP4 2084
INDIRI4
CNSTI4 166
NEI4 $1201
LABELV $1203
line 2726
;2726:				item->cursorPos = len;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 2056
INDIRI4
ASGNI4
line 2727
;2727:				if(item->cursorPos > editPtr->maxPaintChars) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LEI4 $1204
line 2728
;2728:					editPtr->paintOffset = len - editPtr->maxPaintChars;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 2056
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2729
;2729:				}
LABELV $1204
line 2730
;2730:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1201
line 2733
;2731:			}
;2732:
;2733:			if ( key == K_INS || key == K_KP_INS ) {
ADDRLP4 2088
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2088
INDIRI4
CNSTI4 139
EQI4 $1208
ADDRLP4 2088
INDIRI4
CNSTI4 170
NEI4 $1206
LABELV $1208
line 2734
;2734:				DC->setOverstrikeMode(!DC->getOverstrikeMode());
ADDRLP4 2096
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 2096
INDIRI4
CNSTI4 0
NEI4 $1210
ADDRLP4 2092
CNSTI4 1
ASGNI4
ADDRGP4 $1211
JUMPV
LABELV $1210
ADDRLP4 2092
CNSTI4 0
ASGNI4
LABELV $1211
ADDRLP4 2092
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLV
pop
line 2735
;2735:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1206
line 2737
;2736:			}
;2737:		}
LABELV $1147
line 2739
;2738:
;2739:		if (key == K_TAB || key == K_DOWNARROW || key == K_KP_DOWNARROW) {
ADDRLP4 2068
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 9
EQI4 $1215
ADDRLP4 2068
INDIRI4
CNSTI4 133
EQI4 $1215
ADDRLP4 2068
INDIRI4
CNSTI4 167
NEI4 $1212
LABELV $1215
line 2740
;2740:			newItem = Menu_SetNextCursorItem(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 2072
ADDRGP4 Menu_SetNextCursorItem
CALLP4
ASGNP4
ADDRLP4 2052
ADDRLP4 2072
INDIRP4
ASGNP4
line 2741
;2741:			if (newItem && (newItem->type == ITEM_TYPE_EDITFIELD || newItem->type == ITEM_TYPE_NUMERICFIELD)) {
ADDRLP4 2052
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1216
ADDRLP4 2080
ADDRLP4 2052
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2080
INDIRI4
CNSTI4 4
EQI4 $1218
ADDRLP4 2080
INDIRI4
CNSTI4 9
NEI4 $1216
LABELV $1218
line 2742
;2742:				g_editItem = newItem;
ADDRGP4 g_editItem
ADDRLP4 2052
INDIRP4
ASGNP4
line 2743
;2743:			}
LABELV $1216
line 2744
;2744:		}
LABELV $1212
line 2746
;2745:
;2746:		if (key == K_UPARROW || key == K_KP_UPARROW) {
ADDRLP4 2072
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 132
EQI4 $1221
ADDRLP4 2072
INDIRI4
CNSTI4 161
NEI4 $1219
LABELV $1221
line 2747
;2747:			newItem = Menu_SetPrevCursorItem(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 Menu_SetPrevCursorItem
CALLP4
ASGNP4
ADDRLP4 2052
ADDRLP4 2076
INDIRP4
ASGNP4
line 2748
;2748:			if (newItem && (newItem->type == ITEM_TYPE_EDITFIELD || newItem->type == ITEM_TYPE_NUMERICFIELD)) {
ADDRLP4 2052
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1222
ADDRLP4 2084
ADDRLP4 2052
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 4
EQI4 $1224
ADDRLP4 2084
INDIRI4
CNSTI4 9
NEI4 $1222
LABELV $1224
line 2749
;2749:				g_editItem = newItem;
ADDRGP4 g_editItem
ADDRLP4 2052
INDIRP4
ASGNP4
line 2750
;2750:			}
LABELV $1222
line 2751
;2751:		}
LABELV $1219
line 2753
;2752:
;2753:		if ( key == K_ENTER || key == K_KP_ENTER || key == K_ESCAPE)  {
ADDRLP4 2076
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 13
EQI4 $1228
ADDRLP4 2076
INDIRI4
CNSTI4 169
EQI4 $1228
ADDRLP4 2076
INDIRI4
CNSTI4 27
NEI4 $1225
LABELV $1228
line 2754
;2754:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1225
line 2757
;2755:		}
;2756:
;2757:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1141
JUMPV
LABELV $1142
line 2759
;2758:	}
;2759:	return qfalse;
CNSTI4 0
RETI4
LABELV $1141
endproc Item_TextField_HandleKey 2100 12
proc Scroll_TextScroll_AutoFunc 12 16
line 2764
;2760:
;2761:}
;2762:
;2763:static void Scroll_TextScroll_AutoFunc (void *p) 
;2764:{
line 2765
;2765:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2767
;2766:
;2767:	if (DC->realTime > si->nextScrollTime) 
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1230
line 2768
;2768:	{ 
line 2772
;2769:		// need to scroll which is done by simulating a click to the item
;2770:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2771:		// so it calls it directly
;2772:		Item_TextScroll_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Item_TextScroll_HandleKey
CALLI4
pop
line 2773
;2773:		si->nextScrollTime = DC->realTime + si->adjustValue; 
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2774
;2774:	}
LABELV $1230
line 2776
;2775:
;2776:	if (DC->realTime > si->nextAdjustTime) 
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1232
line 2777
;2777:	{
line 2778
;2778:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2779
;2779:		if (si->adjustValue > SCROLL_TIME_FLOOR) 
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1234
line 2780
;2780:		{
line 2781
;2781:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 2782
;2782:		}
LABELV $1234
line 2783
;2783:	}
LABELV $1232
line 2784
;2784:}
LABELV $1229
endproc Scroll_TextScroll_AutoFunc 12 16
proc Scroll_TextScroll_ThumbFunc 40 16
line 2787
;2785:
;2786:static void Scroll_TextScroll_ThumbFunc(void *p) 
;2787:{
line 2788
;2788:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2793
;2789:	rectDef_t	 r;
;2790:	int			 pos;
;2791:	int			 max;
;2792:
;2793:	textScrollDef_t *scrollPtr = (textScrollDef_t*)si->item->typeData;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2795
;2794:
;2795:	if (DC->cursory != si->yStart) 
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
EQF4 $1237
line 2796
;2796:	{
line 2797
;2797:		r.x = si->item->window.rect.x + si->item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 2798
;2798:		r.y = si->item->window.rect.y + SCROLLBAR_SIZE + 1;
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2799
;2799:		r.h = si->item->window.rect.h - (SCROLLBAR_SIZE*2) - 2;
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2800
;2800:		r.w = SCROLLBAR_SIZE;
ADDRLP4 4+8
CNSTF4 1098907648
ASGNF4
line 2801
;2801:		max = Item_TextScroll_MaxScroll(si->item);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_TextScroll_MaxScroll
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 36
INDIRI4
ASGNI4
line 2803
;2802:		//
;2803:		pos = (DC->cursory - r.y - SCROLLBAR_SIZE/2) * max / (r.h - SCROLLBAR_SIZE);
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4+4
INDIRF4
SUBF4
CNSTF4 1090519040
SUBF4
ADDRLP4 28
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4+12
INDIRF4
CNSTF4 1098907648
SUBF4
DIVF4
CVFI4 4
ASGNI4
line 2804
;2804:		if (pos < 0) 
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1244
line 2805
;2805:		{
line 2806
;2806:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2807
;2807:		}
ADDRGP4 $1245
JUMPV
LABELV $1244
line 2808
;2808:		else if (pos > max) 
ADDRLP4 20
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $1246
line 2809
;2809:		{
line 2810
;2810:			pos = max;
ADDRLP4 20
ADDRLP4 28
INDIRI4
ASGNI4
line 2811
;2811:		}
LABELV $1246
LABELV $1245
line 2813
;2812:
;2813:		scrollPtr->startPos = pos;
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2814
;2814:		si->yStart = DC->cursory;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2815
;2815:	}
LABELV $1237
line 2817
;2816:
;2817:	if (DC->realTime > si->nextScrollTime) 
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1248
line 2818
;2818:	{ 
line 2822
;2819:		// need to scroll which is done by simulating a click to the item
;2820:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2821:		// so it calls it directly
;2822:		Item_TextScroll_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Item_TextScroll_HandleKey
CALLI4
pop
line 2823
;2823:		si->nextScrollTime = DC->realTime + si->adjustValue; 
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2824
;2824:	}
LABELV $1248
line 2826
;2825:
;2826:	if (DC->realTime > si->nextAdjustTime) 
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1250
line 2827
;2827:	{
line 2828
;2828:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2829
;2829:		if (si->adjustValue > SCROLL_TIME_FLOOR) 
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1252
line 2830
;2830:		{
line 2831
;2831:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 2832
;2832:		}
LABELV $1252
line 2833
;2833:	}
LABELV $1250
line 2834
;2834:}
LABELV $1236
endproc Scroll_TextScroll_ThumbFunc 40 16
proc Scroll_ListBox_AutoFunc 12 16
line 2836
;2835:
;2836:static void Scroll_ListBox_AutoFunc(void *p) {
line 2837
;2837:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2838
;2838:	if (DC->realTime > si->nextScrollTime) { 
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1255
line 2842
;2839:		// need to scroll which is done by simulating a click to the item
;2840:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2841:		// so it calls it directly
;2842:		Item_ListBox_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 2843
;2843:		si->nextScrollTime = DC->realTime + si->adjustValue; 
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2844
;2844:	}
LABELV $1255
line 2846
;2845:
;2846:	if (DC->realTime > si->nextAdjustTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1257
line 2847
;2847:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2848
;2848:		if (si->adjustValue > SCROLL_TIME_FLOOR) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1259
line 2849
;2849:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 2850
;2850:		}
LABELV $1259
line 2851
;2851:	}
LABELV $1257
line 2852
;2852:}
LABELV $1254
endproc Scroll_ListBox_AutoFunc 12 16
proc Scroll_ListBox_ThumbFunc 40 16
line 2854
;2853:
;2854:static void Scroll_ListBox_ThumbFunc(void *p) {
line 2855
;2855:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2859
;2856:	rectDef_t r;
;2857:	int pos, max;
;2858:
;2859:	listBoxDef_t *listPtr = (listBoxDef_t*)si->item->typeData;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2860
;2860:	if (si->item->window.flags & WINDOW_HORIZONTAL) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1262
line 2861
;2861:		if (DC->cursorx == si->xStart) {
ADDRGP4 DC
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
NEF4 $1264
line 2862
;2862:			return;
ADDRGP4 $1261
JUMPV
LABELV $1264
line 2864
;2863:		}
;2864:		r.x = si->item->window.rect.x + SCROLLBAR_SIZE + 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2865
;2865:		r.y = si->item->window.rect.y + si->item->window.rect.h - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 2866
;2866:		r.h = SCROLLBAR_SIZE;
ADDRLP4 4+12
CNSTF4 1098907648
ASGNF4
line 2867
;2867:		r.w = si->item->window.rect.w - (SCROLLBAR_SIZE*2) - 2;
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2868
;2868:		max = Item_ListBox_MaxScroll(si->item);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 2870
;2869:		//
;2870:		pos = (DC->cursorx - r.x - SCROLLBAR_SIZE/2) * max / (r.w - SCROLLBAR_SIZE);
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
SUBF4
CNSTF4 1090519040
SUBF4
ADDRLP4 24
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4+8
INDIRF4
CNSTF4 1098907648
SUBF4
DIVF4
CVFI4 4
ASGNI4
line 2871
;2871:		if (pos < 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1270
line 2872
;2872:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2873
;2873:		}
ADDRGP4 $1271
JUMPV
LABELV $1270
line 2874
;2874:		else if (pos > max) {
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1272
line 2875
;2875:			pos = max;
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 2876
;2876:		}
LABELV $1272
LABELV $1271
line 2877
;2877:		listPtr->startPos = pos;
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2878
;2878:		si->xStart = DC->cursorx;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2879
;2879:	}
ADDRGP4 $1263
JUMPV
LABELV $1262
line 2880
;2880:	else if (DC->cursory != si->yStart) {
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
EQF4 $1274
line 2882
;2881:
;2882:		r.x = si->item->window.rect.x + si->item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 2883
;2883:		r.y = si->item->window.rect.y + SCROLLBAR_SIZE + 1;
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2884
;2884:		r.h = si->item->window.rect.h - (SCROLLBAR_SIZE*2) - 2;
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2885
;2885:		r.w = SCROLLBAR_SIZE;
ADDRLP4 4+8
CNSTF4 1098907648
ASGNF4
line 2886
;2886:		max = Item_ListBox_MaxScroll(si->item);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 2888
;2887:		//
;2888:		pos = (DC->cursory - r.y - SCROLLBAR_SIZE/2) * max / (r.h - SCROLLBAR_SIZE);
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4+4
INDIRF4
SUBF4
CNSTF4 1090519040
SUBF4
ADDRLP4 24
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4+12
INDIRF4
CNSTF4 1098907648
SUBF4
DIVF4
CVFI4 4
ASGNI4
line 2889
;2889:		if (pos < 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1281
line 2890
;2890:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2891
;2891:		}
ADDRGP4 $1282
JUMPV
LABELV $1281
line 2892
;2892:		else if (pos > max) {
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1283
line 2893
;2893:			pos = max;
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 2894
;2894:		}
LABELV $1283
LABELV $1282
line 2895
;2895:		listPtr->startPos = pos;
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2896
;2896:		si->yStart = DC->cursory;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2897
;2897:	}
LABELV $1274
LABELV $1263
line 2899
;2898:
;2899:	if (DC->realTime > si->nextScrollTime) { 
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1285
line 2903
;2900:		// need to scroll which is done by simulating a click to the item
;2901:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2902:		// so it calls it directly
;2903:		Item_ListBox_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 2904
;2904:		si->nextScrollTime = DC->realTime + si->adjustValue; 
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2905
;2905:	}
LABELV $1285
line 2907
;2906:
;2907:	if (DC->realTime > si->nextAdjustTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1287
line 2908
;2908:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2909
;2909:		if (si->adjustValue > SCROLL_TIME_FLOOR) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1289
line 2910
;2910:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 2911
;2911:		}
LABELV $1289
line 2912
;2912:	}
LABELV $1287
line 2913
;2913:}
LABELV $1261
endproc Scroll_ListBox_ThumbFunc 40 16
proc Scroll_Slider_ThumbFunc 28 8
line 2915
;2914:
;2915:static void Scroll_Slider_ThumbFunc(void *p) {
line 2917
;2916:	float x, value, cursorx;
;2917:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2918
;2918:	editFieldDef_t *editDef = si->item->typeData;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 2920
;2919:
;2920:	if (si->item->text) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1292
line 2921
;2921:		x = si->item->textRect.x + si->item->textRect.w + 8;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2922
;2922:	} else {
ADDRGP4 $1293
JUMPV
LABELV $1292
line 2923
;2923:		x = si->item->window.rect.x;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
ASGNF4
line 2924
;2924:	}
LABELV $1293
line 2926
;2925:
;2926:	cursorx = DC->cursorx;
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2928
;2927:
;2928:	if (cursorx < x) {
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $1294
line 2929
;2929:		cursorx = x;
ADDRLP4 12
ADDRLP4 8
INDIRF4
ASGNF4
line 2930
;2930:	} else if (cursorx > x + SLIDER_WIDTH) {
ADDRGP4 $1295
JUMPV
LABELV $1294
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1119879168
ADDF4
LEF4 $1296
line 2931
;2931:		cursorx = x + SLIDER_WIDTH;
ADDRLP4 12
ADDRLP4 8
INDIRF4
CNSTF4 1119879168
ADDF4
ASGNF4
line 2932
;2932:	}
LABELV $1296
LABELV $1295
line 2933
;2933:	value = cursorx - x;
ADDRLP4 4
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 2934
;2934:	value /= SLIDER_WIDTH;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1119879168
DIVF4
ASGNF4
line 2935
;2935:	value *= (editDef->maxVal - editDef->minVal);
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
SUBF4
MULF4
ASGNF4
line 2936
;2936:	value += editDef->minVal;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 2937
;2937:	DC->setCVar(si->item->cvar, va("%f", value));
ADDRGP4 $1140
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 2938
;2938:}
LABELV $1291
endproc Scroll_Slider_ThumbFunc 28 8
export Item_StartCapture
proc Item_StartCapture 28 12
line 2941
;2939:
;2940:void Item_StartCapture(itemDef_t *item, int key) 
;2941:{
line 2943
;2942:	int flags;
;2943:	switch (item->type) 
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $1299
ADDRLP4 4
INDIRI4
CNSTI4 10
GTI4 $1343
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1344-16
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1344
address $1302
address $1299
address $1302
address $1299
address $1299
address $1302
address $1336
code
LABELV $1343
ADDRLP4 4
INDIRI4
CNSTI4 14
EQI4 $1319
ADDRGP4 $1299
JUMPV
line 2944
;2944:	{
LABELV $1302
line 2948
;2945:	    case ITEM_TYPE_EDITFIELD:
;2946:		case ITEM_TYPE_NUMERICFIELD:
;2947:		case ITEM_TYPE_LISTBOX:
;2948:		{
line 2949
;2949:			flags = Item_ListBox_OverLB(item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
ADDRGP4 Item_ListBox_OverLB
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 2950
;2950:			if (flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW)) {
ADDRLP4 0
INDIRI4
CNSTI4 6144
BANDI4
CNSTI4 0
EQI4 $1303
line 2951
;2951:				scrollInfo.nextScrollTime = DC->realTime + SCROLL_TIME_START;
ADDRGP4 scrollInfo
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2952
;2952:				scrollInfo.nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRGP4 scrollInfo+4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2953
;2953:				scrollInfo.adjustValue = SCROLL_TIME_START;
ADDRGP4 scrollInfo+8
CNSTI4 500
ASGNI4
line 2954
;2954:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2955
;2955:				scrollInfo.scrollDir = (flags & WINDOW_LB_LEFTARROW) ? qtrue : qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1310
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $1311
JUMPV
LABELV $1310
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $1311
ADDRGP4 scrollInfo+28
ADDRLP4 20
INDIRI4
ASGNI4
line 2956
;2956:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2957
;2957:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2958
;2958:				captureFunc = &Scroll_ListBox_AutoFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_ListBox_AutoFunc
ASGNP4
line 2959
;2959:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2960
;2960:			} else if (flags & WINDOW_LB_THUMB) {
ADDRGP4 $1300
JUMPV
LABELV $1303
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1300
line 2961
;2961:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2962
;2962:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2963
;2963:				scrollInfo.xStart = DC->cursorx;
ADDRGP4 scrollInfo+16
ADDRGP4 DC
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2964
;2964:				scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2965
;2965:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2966
;2966:				captureFunc = &Scroll_ListBox_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_ListBox_ThumbFunc
ASGNP4
line 2967
;2967:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2968
;2968:			}
line 2969
;2969:			break;
ADDRGP4 $1300
JUMPV
LABELV $1319
line 2973
;2970:		}
;2971:
;2972:		case ITEM_TYPE_TEXTSCROLL:
;2973:			flags = Item_TextScroll_OverLB (item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
ADDRGP4 Item_TextScroll_OverLB
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 2974
;2974:			if (flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW)) 
ADDRLP4 0
INDIRI4
CNSTI4 6144
BANDI4
CNSTI4 0
EQI4 $1320
line 2975
;2975:			{
line 2976
;2976:				scrollInfo.nextScrollTime = DC->realTime + SCROLL_TIME_START;
ADDRGP4 scrollInfo
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2977
;2977:				scrollInfo.nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRGP4 scrollInfo+4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2978
;2978:				scrollInfo.adjustValue = SCROLL_TIME_START;
ADDRGP4 scrollInfo+8
CNSTI4 500
ASGNI4
line 2979
;2979:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2980
;2980:				scrollInfo.scrollDir = (flags & WINDOW_LB_LEFTARROW) ? qtrue : qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1327
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $1328
JUMPV
LABELV $1327
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $1328
ADDRGP4 scrollInfo+28
ADDRLP4 20
INDIRI4
ASGNI4
line 2981
;2981:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2982
;2982:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2983
;2983:				captureFunc = &Scroll_TextScroll_AutoFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_TextScroll_AutoFunc
ASGNP4
line 2984
;2984:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2985
;2985:			} 
ADDRGP4 $1300
JUMPV
LABELV $1320
line 2986
;2986:			else if (flags & WINDOW_LB_THUMB) 
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1300
line 2987
;2987:			{
line 2988
;2988:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2989
;2989:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2990
;2990:				scrollInfo.xStart = DC->cursorx;
ADDRGP4 scrollInfo+16
ADDRGP4 DC
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2991
;2991:				scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2992
;2992:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2993
;2993:				captureFunc = &Scroll_TextScroll_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_TextScroll_ThumbFunc
ASGNP4
line 2994
;2994:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2995
;2995:			}
line 2996
;2996:			break;
ADDRGP4 $1300
JUMPV
LABELV $1336
line 2999
;2997:
;2998:		case ITEM_TYPE_SLIDER:
;2999:		{
line 3000
;3000:			flags = Item_Slider_OverSlider(item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Item_Slider_OverSlider
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 3001
;3001:			if (flags & WINDOW_LB_THUMB) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1300
line 3002
;3002:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 3003
;3003:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 3004
;3004:				scrollInfo.xStart = DC->cursorx;
ADDRGP4 scrollInfo+16
ADDRGP4 DC
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 3005
;3005:				scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 3006
;3006:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 3007
;3007:				captureFunc = &Scroll_Slider_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_Slider_ThumbFunc
ASGNP4
line 3008
;3008:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 3009
;3009:			}
line 3010
;3010:			break;
LABELV $1299
LABELV $1300
line 3013
;3011:		}
;3012:	}
;3013:}
LABELV $1298
endproc Item_StartCapture 28 12
export Item_StopCapture
proc Item_StopCapture 0 0
line 3015
;3014:
;3015:void Item_StopCapture(itemDef_t *item) {
line 3017
;3016:
;3017:}
LABELV $1346
endproc Item_StopCapture 0 0
export Item_Slider_HandleKey
proc Item_Slider_HandleKey 68 12
line 3019
;3018:
;3019:qboolean Item_Slider_HandleKey(itemDef_t *item, int key, qboolean down) {
line 3023
;3020:	float x, value, width, work;
;3021:
;3022:	//DC->Print("slider handle key\n");
;3023:	if (item->window.flags & WINDOW_HASFOCUS && item->cvar && Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1348
ADDRLP4 16
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1348
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1348
line 3024
;3024:		if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 178
EQI4 $1354
ADDRLP4 28
INDIRI4
CNSTI4 13
EQI4 $1354
ADDRLP4 28
INDIRI4
CNSTI4 179
EQI4 $1354
ADDRLP4 28
INDIRI4
CNSTI4 180
NEI4 $1350
LABELV $1354
line 3025
;3025:			editFieldDef_t *editDef = item->typeData;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 3026
;3026:			if (editDef) {
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1355
line 3028
;3027:				rectDef_t testRect;
;3028:				width = SLIDER_WIDTH;
ADDRLP4 8
CNSTF4 1119879168
ASGNF4
line 3029
;3029:				if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1357
line 3030
;3030:					x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3031
;3031:				} else {
ADDRGP4 $1358
JUMPV
LABELV $1357
line 3032
;3032:					x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 3033
;3033:				}
LABELV $1358
line 3035
;3034:
;3035:				testRect = item->window.rect;
ADDRLP4 36
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 3036
;3036:				testRect.x = x;
ADDRLP4 36
ADDRLP4 4
INDIRF4
ASGNF4
line 3037
;3037:				value = (float)SLIDER_THUMB_WIDTH / 2;
ADDRLP4 0
CNSTF4 1086324736
ASGNF4
line 3038
;3038:				testRect.x -= value;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 3040
;3039:				//DC->Print("slider x: %f\n", testRect.x);
;3040:				testRect.w = (SLIDER_WIDTH + (float)SLIDER_THUMB_WIDTH / 2);
ADDRLP4 36+8
CNSTF4 1120665600
ASGNF4
line 3042
;3041:				//DC->Print("slider w: %f\n", testRect.w);
;3042:				if (Rect_ContainsPoint(&testRect, DC->cursorx, DC->cursory)) {
ADDRLP4 36
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $1360
line 3043
;3043:					work = DC->cursorx - x;
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 3044
;3044:					value = work / width;
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 3045
;3045:					value *= (editDef->maxVal - editDef->minVal);
ADDRLP4 60
ADDRLP4 32
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRF4
SUBF4
MULF4
ASGNF4
line 3048
;3046:					// vm fuckage
;3047:					// value = (((float)(DC->cursorx - x)/ SLIDER_WIDTH) * (editDef->maxVal - editDef->minVal));
;3048:					value += editDef->minVal;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 3049
;3049:					DC->setCVar(item->cvar, va("%f", value));
ADDRGP4 $1140
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLV
pop
line 3050
;3050:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1347
JUMPV
LABELV $1360
line 3052
;3051:				}
;3052:			}
LABELV $1355
line 3053
;3053:		}
LABELV $1350
line 3054
;3054:	}
LABELV $1348
line 3055
;3055:	DC->Print("slider handle key exit\n");
ADDRGP4 $1362
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
CALLV
pop
line 3056
;3056:	return qfalse;
CNSTI4 0
RETI4
LABELV $1347
endproc Item_Slider_HandleKey 68 12
export Item_HandleKey
proc Item_HandleKey 40 16
line 3060
;3057:}
;3058:
;3059:
;3060:qboolean Item_HandleKey(itemDef_t *item, int key, qboolean down) {
line 3062
;3061:
;3062:	if (itemCapture) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1364
line 3063
;3063:		Item_StopCapture(itemCapture);
ADDRGP4 itemCapture
INDIRP4
ARGP4
ADDRGP4 Item_StopCapture
CALLV
pop
line 3064
;3064:		itemCapture = NULL;
ADDRGP4 itemCapture
CNSTP4 0
ASGNP4
line 3065
;3065:		captureFunc = 0;
ADDRGP4 captureFunc
CNSTP4 0
ASGNP4
line 3066
;3066:		captureData = NULL;
ADDRGP4 captureData
CNSTP4 0
ASGNP4
line 3067
;3067:	} else {
ADDRGP4 $1365
JUMPV
LABELV $1364
line 3069
;3068:	  // bk001206 - parentheses
;3069:		if ( down && ( key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3 ) ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1366
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1369
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1369
ADDRLP4 0
INDIRI4
CNSTI4 180
NEI4 $1366
LABELV $1369
line 3070
;3070:			Item_StartCapture(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Item_StartCapture
CALLV
pop
line 3071
;3071:		}
LABELV $1366
line 3072
;3072:	}
LABELV $1365
line 3074
;3073:
;3074:	if (!down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1370
line 3075
;3075:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1363
JUMPV
LABELV $1370
line 3078
;3076:	}
;3077:
;3078:  switch (item->type) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $1372
ADDRLP4 0
INDIRI4
CNSTI4 14
GTI4 $1372
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1393-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1393
address $1375
address $1376
address $1377
address $1378
address $1385
address $1386
address $1372
address $1390
address $1378
address $1392
address $1388
address $1389
address $1391
address $1387
code
LABELV $1375
line 3080
;3079:    case ITEM_TYPE_BUTTON:
;3080:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1363
JUMPV
line 3081
;3081:      break;
LABELV $1376
line 3083
;3082:    case ITEM_TYPE_RADIOBUTTON:
;3083:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1363
JUMPV
line 3084
;3084:      break;
LABELV $1377
line 3086
;3085:    case ITEM_TYPE_CHECKBOX:
;3086:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1363
JUMPV
line 3087
;3087:      break;
LABELV $1378
line 3090
;3088:    case ITEM_TYPE_EDITFIELD:
;3089:    case ITEM_TYPE_NUMERICFIELD:
;3090:		if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER)
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 178
EQI4 $1382
ADDRLP4 8
INDIRI4
CNSTI4 179
EQI4 $1382
ADDRLP4 8
INDIRI4
CNSTI4 13
NEI4 $1379
LABELV $1382
line 3091
;3091:		{
line 3092
;3092:			editFieldDef_t *editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 3094
;3093:
;3094:			if (item->cvar && editPtr)
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $1383
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $1383
line 3095
;3095:			{
line 3096
;3096:				editPtr->paintOffset = 0;
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 3097
;3097:			}
LABELV $1383
line 3100
;3098:
;3099:      //return Item_TextField_HandleKey(item, key);
;3100:		}
LABELV $1379
line 3101
;3101:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1363
JUMPV
line 3102
;3102:      break;
LABELV $1385
line 3104
;3103:    case ITEM_TYPE_COMBO:
;3104:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1363
JUMPV
line 3105
;3105:      break;
LABELV $1386
line 3107
;3106:    case ITEM_TYPE_LISTBOX:
;3107:      return Item_ListBox_HandleKey(item, key, down, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 Item_ListBox_HandleKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $1363
JUMPV
line 3108
;3108:      break;
LABELV $1387
line 3110
;3109:	case ITEM_TYPE_TEXTSCROLL:
;3110:      return Item_TextScroll_HandleKey(item, key, down, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 16
ADDRGP4 Item_TextScroll_HandleKey
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $1363
JUMPV
line 3111
;3111:      break;
LABELV $1388
line 3113
;3112:    case ITEM_TYPE_YESNO:
;3113:      return Item_YesNo_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Item_YesNo_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $1363
JUMPV
line 3114
;3114:      break;
LABELV $1389
line 3116
;3115:    case ITEM_TYPE_MULTI:
;3116:      return Item_Multi_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Item_Multi_HandleKey
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $1363
JUMPV
line 3117
;3117:      break;
LABELV $1390
line 3119
;3118:    case ITEM_TYPE_OWNERDRAW:
;3119:      return Item_OwnerDraw_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Item_OwnerDraw_HandleKey
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $1363
JUMPV
line 3120
;3120:      break;
LABELV $1391
line 3122
;3121:    case ITEM_TYPE_BIND:
;3122:			return Item_Bind_HandleKey(item, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 Item_Bind_HandleKey
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
RETI4
ADDRGP4 $1363
JUMPV
line 3123
;3123:      break;
LABELV $1392
line 3125
;3124:    case ITEM_TYPE_SLIDER:
;3125:      return Item_Slider_HandleKey(item, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Item_Slider_HandleKey
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
RETI4
ADDRGP4 $1363
JUMPV
line 3126
;3126:      break;
LABELV $1372
line 3131
;3127:    //case ITEM_TYPE_IMAGE:
;3128:    //  Item_Image_Paint(item);
;3129:    //  break;
;3130:    default:
;3131:      return qfalse;
CNSTI4 0
RETI4
line 3132
;3132:      break;
LABELV $1363
endproc Item_HandleKey 40 16
export Item_Action
proc Item_Action 4 8
line 3138
;3133:  }
;3134:
;3135:  //return qfalse;
;3136:}
;3137:
;3138:void Item_Action(itemDef_t *item) {
line 3139
;3139:  if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1396
line 3140
;3140:    Item_RunScript(item, item->action);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 3141
;3141:  }
LABELV $1396
line 3142
;3142:}
LABELV $1395
endproc Item_Action 4 8
export Menu_SetPrevCursorItem
proc Menu_SetPrevCursorItem 44 12
line 3144
;3143:
;3144:itemDef_t *Menu_SetPrevCursorItem(menuDef_t *menu) {
line 3145
;3145:  qboolean wrapped = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3146
;3146:	int oldCursor = menu->cursorItem;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 3148
;3147:  
;3148:  if (menu->cursorItem < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1402
line 3149
;3149:    menu->cursorItem = menu->itemCount-1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3150
;3150:    wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3151
;3151:  } 
ADDRGP4 $1402
JUMPV
LABELV $1401
line 3153
;3152:
;3153:  while (menu->cursorItem > -1) {
line 3155
;3154:    
;3155:    menu->cursorItem--;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3156
;3156:    if (menu->cursorItem < 0 && !wrapped) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
GEI4 $1404
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1404
line 3157
;3157:      wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3158
;3158:      menu->cursorItem = menu->itemCount -1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3159
;3159:    }
LABELV $1404
line 3161
;3160:
;3161:		if (Item_SetFocus(menu->items[menu->cursorItem], DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1406
line 3162
;3162:			Menu_HandleMouseMove(menu, menu->items[menu->cursorItem]->window.rect.x + 1, menu->items[menu->cursorItem]->window.rect.y + 1);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 3163
;3163:      return menu->items[menu->cursorItem];
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1398
JUMPV
LABELV $1406
line 3165
;3164:    }
;3165:  }
LABELV $1402
line 3153
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -1
GTI4 $1401
line 3166
;3166:	menu->cursorItem = oldCursor;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 3167
;3167:	return NULL;
CNSTP4 0
RETP4
LABELV $1398
endproc Menu_SetPrevCursorItem 44 12
export Menu_SetNextCursorItem
proc Menu_SetNextCursorItem 44 12
line 3171
;3168:
;3169:}
;3170:
;3171:itemDef_t *Menu_SetNextCursorItem(menuDef_t *menu) {
line 3173
;3172:
;3173:  qboolean wrapped = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3174
;3174:	int oldCursor = menu->cursorItem;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 3177
;3175:
;3176:
;3177:  if (menu->cursorItem == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1412
line 3178
;3178:    menu->cursorItem = 0;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 0
ASGNI4
line 3179
;3179:    wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3180
;3180:  }
ADDRGP4 $1412
JUMPV
LABELV $1411
line 3182
;3181:
;3182:  while (menu->cursorItem < menu->itemCount) {
line 3184
;3183:
;3184:    menu->cursorItem++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3185
;3185:    if (menu->cursorItem >= menu->itemCount && !wrapped) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1414
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1414
line 3186
;3186:      wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3187
;3187:      menu->cursorItem = 0;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 0
ASGNI4
line 3188
;3188:    }
LABELV $1414
line 3189
;3189:		if (Item_SetFocus(menu->items[menu->cursorItem], DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1416
line 3190
;3190:			Menu_HandleMouseMove(menu, menu->items[menu->cursorItem]->window.rect.x + 1, menu->items[menu->cursorItem]->window.rect.y + 1);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 3191
;3191:      return menu->items[menu->cursorItem];
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1408
JUMPV
LABELV $1416
line 3194
;3192:    }
;3193:    
;3194:  }
LABELV $1412
line 3182
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1411
line 3196
;3195:
;3196:	menu->cursorItem = oldCursor;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 3197
;3197:	return NULL;
CNSTP4 0
RETP4
LABELV $1408
endproc Menu_SetNextCursorItem 44 12
proc Window_CloseCinematic 4 4
line 3200
;3198:}
;3199:
;3200:static void Window_CloseCinematic(windowDef_t *window) {
line 3201
;3201:	if (window->style == WINDOW_STYLE_CINEMATIC && window->cinematic >= 0) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1419
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1419
line 3202
;3202:		DC->stopCinematic(window->cinematic);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRP4
CALLV
pop
line 3203
;3203:		window->cinematic = -1;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 3204
;3204:	}
LABELV $1419
line 3205
;3205:}
LABELV $1418
endproc Window_CloseCinematic 4 4
proc Menu_CloseCinematics 4 4
line 3207
;3206:
;3207:static void Menu_CloseCinematics(menuDef_t *menu) {
line 3208
;3208:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1422
line 3210
;3209:		int i;
;3210:		Window_CloseCinematic(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CloseCinematic
CALLV
pop
line 3211
;3211:	  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1427
JUMPV
LABELV $1424
line 3212
;3212:		  Window_CloseCinematic(&menu->items[i]->window);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Window_CloseCinematic
CALLV
pop
line 3213
;3213:			if (menu->items[i]->type == ITEM_TYPE_OWNERDRAW) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1428
line 3214
;3214:				DC->stopCinematic(0-menu->items[i]->window.ownerDraw);
CNSTI4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRP4
CALLV
pop
line 3215
;3215:			}
LABELV $1428
line 3216
;3216:	  }
LABELV $1425
line 3211
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1427
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1424
line 3217
;3217:	}
LABELV $1422
line 3218
;3218:}
LABELV $1421
endproc Menu_CloseCinematics 4 4
proc Display_CloseCinematics 4 4
line 3220
;3219:
;3220:static void Display_CloseCinematics() {
line 3222
;3221:	int i;
;3222:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1434
JUMPV
LABELV $1431
line 3223
;3223:		Menu_CloseCinematics(&Menus[i]);
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_CloseCinematics
CALLV
pop
line 3224
;3224:	}
LABELV $1432
line 3222
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1434
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1431
line 3225
;3225:}
LABELV $1430
endproc Display_CloseCinematics 4 4
export Menus_Activate
proc Menus_Activate 568 12
line 3227
;3226:
;3227:void  Menus_Activate(menuDef_t *menu) {
line 3228
;3228:	menu->window.flags |= (WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 6
BORI4
ASGNI4
line 3229
;3229:	if (menu->onOpen) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1436
line 3231
;3230:		itemDef_t item;
;3231:		item.parent = menu;
ADDRLP4 4+240
ADDRFP4 0
INDIRP4
ASGNP4
line 3232
;3232:		Item_RunScript(&item, menu->onOpen);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 3233
;3233:	}
LABELV $1436
line 3235
;3234:
;3235:	if (menu->soundName && *menu->soundName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1439
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1439
line 3237
;3236://		DC->stopBackgroundTrack();					// you don't want to do this since it will reset s_rawend
;3237:		DC->startBackgroundTrack(menu->soundName, menu->soundName, qfalse);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 196
ADDP4
INDIRP4
CALLV
pop
line 3238
;3238:	}
LABELV $1439
line 3240
;3239:
;3240:	menu->appearanceTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1316
ADDP4
CNSTF4 0
ASGNF4
line 3241
;3241:	Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 3243
;3242:
;3243:}
LABELV $1435
endproc Menus_Activate 568 12
export Display_VisibleMenuCount
proc Display_VisibleMenuCount 8 0
line 3245
;3244:
;3245:int Display_VisibleMenuCount() {
line 3247
;3246:	int i, count;
;3247:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3248
;3248:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1445
JUMPV
LABELV $1442
line 3249
;3249:		if (Menus[i].window.flags & (WINDOW_FORCED | WINDOW_VISIBLE)) {
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
EQI4 $1446
line 3250
;3250:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3251
;3251:		}
LABELV $1446
line 3252
;3252:	}
LABELV $1443
line 3248
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1445
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1442
line 3253
;3253:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $1441
endproc Display_VisibleMenuCount 8 0
export Menus_HandleOOBClick
proc Menus_HandleOOBClick 24 12
line 3256
;3254:}
;3255:
;3256:void Menus_HandleOOBClick(menuDef_t *menu, int key, qboolean down) {
line 3257
;3257:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1450
line 3262
;3258:		int i;
;3259:		// basically the behaviour we are looking for is if there are windows in the stack.. see if 
;3260:		// the cursor is within any of them.. if not close them otherwise activate them and pass the 
;3261:		// key on.. force a mouse move to activate focus and script stuff 
;3262:		if (down && menu->window.flags & WINDOW_OOB_CLICK) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $1452
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $1452
line 3263
;3263:			Menu_RunCloseScript(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 3264
;3264:			menu->window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 3265
;3265:		}
LABELV $1452
line 3267
;3266:
;3267:		for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1457
JUMPV
LABELV $1454
line 3268
;3268:			if (Menu_OverActiveItem(&Menus[i], DC->cursorx, DC->cursory)) {
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
ADDRGP4 Menu_OverActiveItem
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1458
line 3269
;3269:				Menu_RunCloseScript(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 3270
;3270:				menu->window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 3271
;3271:				Menus_Activate(&Menus[i]);
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 3272
;3272:				Menu_HandleMouseMove(&Menus[i], DC->cursorx, DC->cursory);
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 3273
;3273:				Menu_HandleKey(&Menus[i], key, down);
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Menu_HandleKey
CALLV
pop
line 3274
;3274:			}
LABELV $1458
line 3275
;3275:		}
LABELV $1455
line 3267
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1457
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1454
line 3277
;3276:
;3277:		if (Display_VisibleMenuCount() == 0) {
ADDRLP4 8
ADDRGP4 Display_VisibleMenuCount
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1460
line 3278
;3278:			if (DC->Pause) {
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1462
line 3279
;3279:				DC->Pause(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 3280
;3280:			}
LABELV $1462
line 3281
;3281:		}
LABELV $1460
line 3282
;3282:		Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 3283
;3283:	}
LABELV $1450
line 3284
;3284:}
LABELV $1449
endproc Menus_HandleOOBClick 24 12
bss
align 4
LABELV $1465
skip 16
code
proc Item_CorrectedTextRect 4 12
line 3286
;3285:
;3286:static rectDef_t *Item_CorrectedTextRect(itemDef_t *item) {
line 3288
;3287:	static rectDef_t rect;
;3288:	memset(&rect, 0, sizeof(rectDef_t));
ADDRGP4 $1465
ARGP4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3289
;3289:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1466
line 3290
;3290:		rect = item->textRect;
ADDRGP4 $1465
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 3291
;3291:		if (rect.w) {
ADDRGP4 $1465+8
INDIRF4
CNSTF4 0
EQF4 $1468
line 3292
;3292:			rect.y -= rect.h;
ADDRLP4 0
ADDRGP4 $1465+4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 $1465+12
INDIRF4
SUBF4
ASGNF4
line 3293
;3293:		}
LABELV $1468
line 3294
;3294:	}
LABELV $1466
line 3295
;3295:	return &rect;
ADDRGP4 $1465
RETP4
LABELV $1464
endproc Item_CorrectedTextRect 4 12
data
align 4
LABELV $1494
byte 4 0
export Menu_HandleKey
code
proc Menu_HandleKey 652 12
line 3298
;3296:}
;3297:
;3298:void Menu_HandleKey(menuDef_t *menu, int key, qboolean down) {
line 3300
;3299:	int i;
;3300:	itemDef_t *item = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 3301
;3301:	qboolean inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3303
;3302:
;3303:	if (inHandler) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1474
line 3304
;3304:		return;
ADDRGP4 $1473
JUMPV
LABELV $1474
line 3307
;3305:	}
;3306:
;3307:	inHandler = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 3308
;3308:	if (g_waitingForKey && down) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 g_waitingForKey
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1476
ADDRFP4 8
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1476
line 3309
;3309:		Item_Bind_HandleKey(g_bindItem, key, down);
ADDRGP4 g_bindItem
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Item_Bind_HandleKey
CALLI4
pop
line 3310
;3310:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3311
;3311:		return;
ADDRGP4 $1473
JUMPV
LABELV $1476
line 3314
;3312:	}
;3313:
;3314:	if (g_editingField && down) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 g_editingField
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1478
ADDRFP4 8
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1478
line 3315
;3315:		if (!Item_TextField_HandleKey(g_editItem, key)) {
ADDRGP4 g_editItem
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Item_TextField_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $1480
line 3316
;3316:			g_editingField = qfalse;
ADDRGP4 g_editingField
CNSTI4 0
ASGNI4
line 3317
;3317:			g_editItem = NULL;
ADDRGP4 g_editItem
CNSTP4 0
ASGNP4
line 3318
;3318:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3319
;3319:			return;
ADDRGP4 $1473
JUMPV
LABELV $1480
line 3320
;3320:		} else if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 24
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 178
EQI4 $1485
ADDRLP4 24
INDIRI4
CNSTI4 179
EQI4 $1485
ADDRLP4 24
INDIRI4
CNSTI4 180
NEI4 $1482
LABELV $1485
line 3321
;3321:			g_editingField = qfalse;
ADDRGP4 g_editingField
CNSTI4 0
ASGNI4
line 3322
;3322:			g_editItem = NULL;
ADDRGP4 g_editItem
CNSTP4 0
ASGNP4
line 3323
;3323:			Display_MouseMove(NULL, DC->cursorx, DC->cursory);
CNSTP4 0
ARGP4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 3324
;3324:		} else if (key == K_TAB || key == K_UPARROW || key == K_DOWNARROW) {
ADDRGP4 $1483
JUMPV
LABELV $1482
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 9
EQI4 $1489
ADDRLP4 28
INDIRI4
CNSTI4 132
EQI4 $1489
ADDRLP4 28
INDIRI4
CNSTI4 133
NEI4 $1486
LABELV $1489
line 3325
;3325:			return;
ADDRGP4 $1473
JUMPV
LABELV $1486
LABELV $1483
line 3327
;3326:		}
;3327:	}
LABELV $1478
line 3329
;3328:
;3329:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1490
line 3330
;3330:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3331
;3331:		return;
ADDRGP4 $1473
JUMPV
LABELV $1490
line 3335
;3332:	}
;3333:
;3334:		// see if the mouse is within the window bounds and if so is this a mouse click
;3335:	if (down && !(menu->window.flags & WINDOW_POPUP) && !Rect_ContainsPoint(&menu->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $1492
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
ADDRLP4 20
INDIRI4
NEI4 $1492
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $1492
line 3338
;3336:		static qboolean inHandleKey = qfalse;
;3337:		// bk001206 - parentheses
;3338:		if (!inHandleKey && ( key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3 ) ) {
ADDRGP4 $1494
INDIRI4
CNSTI4 0
NEI4 $1495
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 178
EQI4 $1498
ADDRLP4 36
INDIRI4
CNSTI4 179
EQI4 $1498
ADDRLP4 36
INDIRI4
CNSTI4 180
NEI4 $1495
LABELV $1498
line 3339
;3339:			inHandleKey = qtrue;
ADDRGP4 $1494
CNSTI4 1
ASGNI4
line 3340
;3340:			Menus_HandleOOBClick(menu, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Menus_HandleOOBClick
CALLV
pop
line 3341
;3341:			inHandleKey = qfalse;
ADDRGP4 $1494
CNSTI4 0
ASGNI4
line 3342
;3342:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3343
;3343:			return;
ADDRGP4 $1473
JUMPV
LABELV $1495
line 3345
;3344:		}
;3345:	}
LABELV $1492
line 3348
;3346:
;3347:	// get the item with focus
;3348:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1502
JUMPV
LABELV $1499
line 3349
;3349:		if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 36
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 36
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
BANDI4
CNSTI4 0
EQI4 $1503
line 3350
;3350:			item = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 3351
;3351:		}
LABELV $1503
line 3352
;3352:	}
LABELV $1500
line 3348
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1502
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1499
line 3354
;3353:
;3354:	if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1505
line 3355
;3355:		if (Item_HandleKey(item, key, down)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Item_HandleKey
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1507
line 3356
;3356:			Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 3357
;3357:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3358
;3358:			return;
ADDRGP4 $1473
JUMPV
LABELV $1507
line 3360
;3359:		}
;3360:	}
LABELV $1505
line 3362
;3361:
;3362:	if (!down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1509
line 3363
;3363:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3364
;3364:		return;
ADDRGP4 $1473
JUMPV
LABELV $1509
line 3368
;3365:	}
;3366:
;3367:	// default handling
;3368:	switch ( key ) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 155
EQI4 $1513
ADDRLP4 40
CNSTI4 156
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $1517
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
GTI4 $1549
LABELV $1548
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
CNSTI4 13
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $1542
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
GTI4 $1551
LABELV $1550
ADDRFP4 4
INDIRI4
CNSTI4 9
EQI4 $1526
ADDRGP4 $1511
JUMPV
LABELV $1551
ADDRLP4 52
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 56
CNSTI4 27
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $1522
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
LTI4 $1511
LABELV $1552
ADDRLP4 60
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 132
EQI4 $1521
ADDRLP4 60
INDIRI4
CNSTI4 133
EQI4 $1526
ADDRGP4 $1511
JUMPV
LABELV $1549
ADDRLP4 64
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 167
EQI4 $1526
ADDRLP4 68
CNSTI4 169
ASGNI4
ADDRLP4 64
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $1542
ADDRLP4 64
INDIRI4
ADDRLP4 68
INDIRI4
GTI4 $1554
LABELV $1553
ADDRFP4 4
INDIRI4
CNSTI4 161
EQI4 $1521
ADDRGP4 $1511
JUMPV
LABELV $1554
ADDRLP4 72
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 178
LTI4 $1511
ADDRLP4 72
INDIRI4
CNSTI4 188
GTI4 $1555
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1556-712
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1556
address $1527
address $1527
address $1511
address $1511
address $1511
address $1511
address $1511
address $1512
address $1512
address $1512
address $1512
code
LABELV $1555
ADDRLP4 76
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 217
LTI4 $1511
ADDRLP4 76
INDIRI4
CNSTI4 232
GTI4 $1511
ADDRLP4 76
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1558-868
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1558
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
address $1512
code
LABELV $1513
line 3371
;3369:
;3370:		case K_F11:
;3371:			if (DC->getCVarValue("developer")) {
ADDRGP4 $1516
ARGP4
ADDRLP4 80
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 80
INDIRF4
CNSTF4 0
EQF4 $1512
line 3372
;3372:				debugMode ^= 1;
ADDRLP4 84
ADDRGP4 debugMode
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 3373
;3373:			}
line 3374
;3374:			break;
ADDRGP4 $1512
JUMPV
LABELV $1517
line 3377
;3375:
;3376:		case K_F12:
;3377:			if (DC->getCVarValue("developer")) {
ADDRGP4 $1516
ARGP4
ADDRLP4 84
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 84
INDIRF4
CNSTF4 0
EQF4 $1512
line 3378
;3378:				DC->executeText(EXEC_APPEND, "screenshot\n");
CNSTI4 2
ARGI4
ADDRGP4 $1520
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 172
ADDP4
INDIRP4
CALLV
pop
line 3379
;3379:			}
line 3380
;3380:			break;
ADDRGP4 $1512
JUMPV
LABELV $1521
line 3383
;3381:		case K_KP_UPARROW:
;3382:		case K_UPARROW:
;3383:			Menu_SetPrevCursorItem(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_SetPrevCursorItem
CALLP4
pop
line 3384
;3384:			break;
ADDRGP4 $1512
JUMPV
LABELV $1522
line 3387
;3385:
;3386:		case K_ESCAPE:
;3387:			if (!g_waitingForKey && menu->onESC) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $1523
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1523
line 3389
;3388:				itemDef_t it;
;3389:		    it.parent = menu;
ADDRLP4 88+240
ADDRFP4 0
INDIRP4
ASGNP4
line 3390
;3390:		    Item_RunScript(&it, menu->onESC);
ADDRLP4 88
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 3391
;3391:			}
LABELV $1523
line 3392
;3392:		    g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 3393
;3393:			break;
ADDRGP4 $1512
JUMPV
LABELV $1526
line 3397
;3394:		case K_TAB:
;3395:		case K_KP_DOWNARROW:
;3396:		case K_DOWNARROW:
;3397:			Menu_SetNextCursorItem(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_SetNextCursorItem
CALLP4
pop
line 3398
;3398:			break;
ADDRGP4 $1512
JUMPV
LABELV $1527
line 3402
;3399:
;3400:		case K_MOUSE1:
;3401:		case K_MOUSE2:
;3402:			if (item) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1512
line 3403
;3403:				if (item->type == ITEM_TYPE_TEXT) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1530
line 3404
;3404:					if (Rect_ContainsPoint(Item_CorrectedTextRect(item), DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 96
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1512
line 3405
;3405:						Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 3406
;3406:					}
line 3407
;3407:				} else if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRGP4 $1512
JUMPV
LABELV $1530
ADDRLP4 88
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 4
EQI4 $1536
ADDRLP4 88
INDIRI4
CNSTI4 9
NEI4 $1534
LABELV $1536
line 3408
;3408:					if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 96
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1512
line 3409
;3409:						item->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
line 3410
;3410:						g_editingField = qtrue;
ADDRGP4 g_editingField
CNSTI4 1
ASGNI4
line 3411
;3411:						g_editItem = item;
ADDRGP4 g_editItem
ADDRLP4 4
INDIRP4
ASGNP4
line 3412
;3412:						DC->setOverstrikeMode(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLV
pop
line 3413
;3413:					}
line 3414
;3414:				} else {
ADDRGP4 $1512
JUMPV
LABELV $1534
line 3415
;3415:					if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 96
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1512
line 3416
;3416:						Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 3417
;3417:					}
line 3418
;3418:				}
line 3419
;3419:			}
line 3420
;3420:			break;
ADDRGP4 $1512
JUMPV
line 3442
;3421:
;3422:		case K_JOY1:
;3423:		case K_JOY2:
;3424:		case K_JOY3:
;3425:		case K_JOY4:
;3426:		case K_AUX1:
;3427:		case K_AUX2:
;3428:		case K_AUX3:
;3429:		case K_AUX4:
;3430:		case K_AUX5:
;3431:		case K_AUX6:
;3432:		case K_AUX7:
;3433:		case K_AUX8:
;3434:		case K_AUX9:
;3435:		case K_AUX10:
;3436:		case K_AUX11:
;3437:		case K_AUX12:
;3438:		case K_AUX13:
;3439:		case K_AUX14:
;3440:		case K_AUX15:
;3441:		case K_AUX16:
;3442:			break;
LABELV $1542
line 3445
;3443:		case K_KP_ENTER:
;3444:		case K_ENTER:
;3445:			if (item) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1512
line 3446
;3446:				if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRLP4 88
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 4
EQI4 $1547
ADDRLP4 88
INDIRI4
CNSTI4 9
NEI4 $1545
LABELV $1547
line 3447
;3447:					item->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
line 3448
;3448:					g_editingField = qtrue;
ADDRGP4 g_editingField
CNSTI4 1
ASGNI4
line 3449
;3449:					g_editItem = item;
ADDRGP4 g_editItem
ADDRLP4 4
INDIRP4
ASGNP4
line 3450
;3450:					DC->setOverstrikeMode(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLV
pop
line 3451
;3451:				} else {
ADDRGP4 $1512
JUMPV
LABELV $1545
line 3452
;3452:						Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 3453
;3453:				}
line 3454
;3454:			}
line 3455
;3455:			break;
LABELV $1511
LABELV $1512
line 3457
;3456:	}
;3457:	inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3458
;3458:}
LABELV $1473
endproc Menu_HandleKey 652 12
export ToWindowCoords
proc ToWindowCoords 8 0
line 3460
;3459:
;3460:void ToWindowCoords(float *x, float *y, windowDef_t *window) {
line 3461
;3461:	if (window->border != 0) {
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1561
line 3462
;3462:		*x += window->borderSize;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3463
;3463:		*y += window->borderSize;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3464
;3464:	} 
LABELV $1561
line 3465
;3465:	*x += window->rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 3466
;3466:	*y += window->rect.y;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3467
;3467:}
LABELV $1560
endproc ToWindowCoords 8 0
export Rect_ToWindowCoords
proc Rect_ToWindowCoords 4 12
line 3469
;3468:
;3469:void Rect_ToWindowCoords(rectDef_t *rect, windowDef_t *window) {
line 3470
;3470:	ToWindowCoords(&rect->x, &rect->y, window);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 3471
;3471:}
LABELV $1563
endproc Rect_ToWindowCoords 4 12
export Item_SetTextExtents
proc Item_SetTextExtents 300 12
line 3473
;3472:
;3473:void Item_SetTextExtents(itemDef_t *item, int *width, int *height, const char *text) {
line 3474
;3474:	const char *textPtr = (text) ? text : item->text;
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1566
ADDRLP4 4
ADDRFP4 12
INDIRP4
ASGNP4
ADDRGP4 $1567
JUMPV
LABELV $1566
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
LABELV $1567
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 3476
;3475:
;3476:	if (textPtr == NULL ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1568
line 3477
;3477:		return;
ADDRGP4 $1564
JUMPV
LABELV $1568
line 3480
;3478:	}
;3479:
;3480:	*width = item->textRect.w;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 3481
;3481:	*height = item->textRect.h;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 3484
;3482:
;3483:	// keeps us from computing the widths and heights more than once
;3484:	if (*width == 0 || (item->type == ITEM_TYPE_OWNERDRAW && item->textalignment == ITEM_ALIGN_CENTER)) {
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1572
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1570
ADDRLP4 8
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1570
LABELV $1572
line 3485
;3485:		int originalWidth = DC->textWidth(/*item->text*/textPtr, item->textscale, item->iMenuFont);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 3487
;3486:
;3487:		if (item->type == ITEM_TYPE_OWNERDRAW && (item->textalignment == ITEM_ALIGN_CENTER || item->textalignment == ITEM_ALIGN_RIGHT)) 
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1573
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $1575
ADDRLP4 28
INDIRI4
CNSTI4 2
NEI4 $1573
LABELV $1575
line 3488
;3488:		{
line 3489
;3489:			originalWidth += DC->ownerDrawWidth(item->window.ownerDraw, item->textscale);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
CNSTI4 188
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 36
INDIRI4
ADDI4
ASGNI4
line 3490
;3490:		} 
ADDRGP4 $1574
JUMPV
LABELV $1573
line 3491
;3491:		else if (item->type == ITEM_TYPE_EDITFIELD && item->textalignment == ITEM_ALIGN_CENTER && item->cvar) 
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1576
ADDRLP4 32
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1576
ADDRLP4 32
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1576
line 3492
;3492:		{
line 3494
;3493:			char buff[256];
;3494:			DC->getCVarString(item->cvar, buff, 256);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 3495
;3495:			originalWidth += DC->textWidth(buff, item->textscale, item->iMenuFont);
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 296
INDIRI4
ADDI4
ASGNI4
line 3496
;3496:		}
LABELV $1576
LABELV $1574
line 3498
;3497:
;3498:		*width = DC->textWidth(textPtr, item->textscale, item->iMenuFont);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ASGNI4
line 3499
;3499:		*height = DC->textHeight(textPtr, item->textscale, item->iMenuFont);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 DC
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 48
INDIRI4
ASGNI4
line 3500
;3500:		item->textRect.w = *width;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 3501
;3501:		item->textRect.h = *height;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 3502
;3502:		item->textRect.x = item->textalignx;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ASGNF4
line 3503
;3503:		item->textRect.y = item->textaligny;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ASGNF4
line 3504
;3504:		if (item->textalignment == ITEM_ALIGN_RIGHT) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1578
line 3505
;3505:			item->textRect.x = item->textalignx - originalWidth;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 3506
;3506:		} else if (item->textalignment == ITEM_ALIGN_CENTER) {
ADDRGP4 $1579
JUMPV
LABELV $1578
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1580
line 3507
;3507:			item->textRect.x = item->textalignx - originalWidth / 2;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ASGNF4
line 3508
;3508:		}
LABELV $1580
LABELV $1579
line 3510
;3509:
;3510:		ToWindowCoords(&item->textRect.x, &item->textRect.y, &item->window);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 3511
;3511:	}
LABELV $1570
line 3512
;3512:}
LABELV $1564
endproc Item_SetTextExtents 300 12
export Item_TextColor
proc Item_TextColor 60 28
line 3514
;3513:
;3514:void Item_TextColor(itemDef_t *item, vec4_t *newColor) {
line 3516
;3515:	vec4_t lowLight;
;3516:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 3518
;3517:
;3518:	Fade(&item->window.flags, &item->window.foreColor[3], parent->fadeClamp, &item->window.nextTime, parent->fadeCycle, qtrue, parent->fadeAmount);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 3520
;3519:
;3520:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1583
line 3521
;3521:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 3522
;3522:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 4+4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 3523
;3523:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 4+8
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 3524
;3524:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 4+12
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 3525
;3525:		LerpColor(parent->focusColor,lowLight,*newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1056964608
ADDRLP4 28
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3526
;3526:	} else if (item->textStyle == ITEM_TEXTSTYLE_BLINK && !((DC->realTime/BLINK_DIVISOR) & 1)) {
ADDRGP4 $1584
JUMPV
LABELV $1583
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $1588
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 200
DIVI4
ADDRLP4 28
INDIRI4
BANDI4
CNSTI4 0
NEI4 $1588
line 3527
;3527:		lowLight[0] = 0.8 * item->window.foreColor[0]; 
ADDRLP4 4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
MULF4
ASGNF4
line 3528
;3528:		lowLight[1] = 0.8 * item->window.foreColor[1]; 
ADDRLP4 4+4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
MULF4
ASGNF4
line 3529
;3529:		lowLight[2] = 0.8 * item->window.foreColor[2]; 
ADDRLP4 4+8
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
line 3530
;3530:		lowLight[3] = 0.8 * item->window.foreColor[3]; 
ADDRLP4 4+12
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
MULF4
ASGNF4
line 3531
;3531:		LerpColor(item->window.foreColor,lowLight,*newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 32
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1056964608
ADDRLP4 32
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3532
;3532:	} else {
ADDRGP4 $1589
JUMPV
LABELV $1588
line 3533
;3533:		memcpy(newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3535
;3534:		// items can be enabled and disabled based on cvars
;3535:	}
LABELV $1589
LABELV $1584
line 3537
;3536:
;3537:	if (item->enableCvar && *item->enableCvar && item->cvarTest && *item->cvarTest) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
CNSTU4 0
ASGNU4
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $1593
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
EQI4 $1593
ADDRLP4 48
ADDRLP4 32
INDIRP4
CNSTI4 280
ADDP4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $1593
ADDRLP4 48
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
EQI4 $1593
line 3538
;3538:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1595
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $1595
line 3539
;3539:			memcpy(newColor, &parent->disableColor, sizeof(vec4_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3540
;3540:		}
LABELV $1595
line 3541
;3541:	}
LABELV $1593
line 3542
;3542:}
LABELV $1582
endproc Item_TextColor 60 28
export Item_Text_AutoWrapped_Paint
proc Item_Text_AutoWrapped_Paint 4176 36
line 3544
;3543:
;3544:void Item_Text_AutoWrapped_Paint(itemDef_t *item) {
line 3552
;3545:	char text[2048];
;3546:	const char *p, *textPtr, *newLinePtr;
;3547:	char buff[2048];
;3548:	int width, height, len, textWidth, newLine, newLineWidth;
;3549:	float y;
;3550:	vec4_t color;
;3551:
;3552:	textWidth = 0;
ADDRLP4 2056
CNSTI4 0
ASGNI4
line 3553
;3553:	newLinePtr = NULL;
ADDRLP4 2068
CNSTP4 0
ASGNP4
line 3555
;3554:
;3555:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1598
line 3556
;3556:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1600
line 3557
;3557:			return;
ADDRGP4 $1597
JUMPV
LABELV $1600
line 3559
;3558:		}
;3559:		else {
line 3560
;3560:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 2104
ARGP4
CNSTI4 2048
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 3561
;3561:			textPtr = text;
ADDRLP4 2080
ADDRLP4 2104
ASGNP4
line 3562
;3562:		}
line 3563
;3563:	}
ADDRGP4 $1599
JUMPV
LABELV $1598
line 3564
;3564:	else {
line 3565
;3565:		textPtr = item->text;
ADDRLP4 2080
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 3566
;3566:	}
LABELV $1599
line 3567
;3567:	if (*textPtr == '\0') {
ADDRLP4 2080
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1602
line 3568
;3568:		return;
ADDRGP4 $1597
JUMPV
LABELV $1602
line 3570
;3569:	}
;3570:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 2084
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 3571
;3571:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 2100
ARGP4
ADDRLP4 2076
ARGP4
ADDRLP4 2080
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 3573
;3572:
;3573:	y = item->textaligny;
ADDRLP4 2072
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ASGNF4
line 3574
;3574:	len = 0;
ADDRLP4 2052
CNSTI4 0
ASGNI4
line 3575
;3575:	buff[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 3576
;3576:	newLine = 0;
ADDRLP4 2060
CNSTI4 0
ASGNI4
line 3577
;3577:	newLineWidth = 0;
ADDRLP4 2064
CNSTI4 0
ASGNI4
line 3578
;3578:	p = textPtr;
ADDRLP4 0
ADDRLP4 2080
INDIRP4
ASGNP4
ADDRGP4 $1605
JUMPV
LABELV $1604
line 3579
;3579:	while (p) {
line 3580
;3580:		if (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\0') {
ADDRLP4 4152
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4152
INDIRI4
CNSTI4 32
EQI4 $1611
ADDRLP4 4152
INDIRI4
CNSTI4 9
EQI4 $1611
ADDRLP4 4152
INDIRI4
CNSTI4 10
EQI4 $1611
ADDRLP4 4152
INDIRI4
CNSTI4 0
NEI4 $1607
LABELV $1611
line 3581
;3581:			newLine = len;
ADDRLP4 2060
ADDRLP4 2052
INDIRI4
ASGNI4
line 3582
;3582:			newLinePtr = p+1;
ADDRLP4 2068
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 3583
;3583:			newLineWidth = textWidth;
ADDRLP4 2064
ADDRLP4 2056
INDIRI4
ASGNI4
line 3584
;3584:		}
LABELV $1607
line 3585
;3585:		textWidth = DC->textWidth(buff, item->textscale, 0);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 4156
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 2056
ADDRLP4 4156
INDIRI4
ASGNI4
line 3586
;3586:		if ( (newLine && textWidth > item->window.rect.w) || *p == '\n' || *p == '\0') {
ADDRLP4 2060
INDIRI4
CNSTI4 0
EQI4 $1615
ADDRLP4 2056
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GTF4 $1616
LABELV $1615
ADDRLP4 4160
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4160
INDIRI4
CNSTI4 10
EQI4 $1616
ADDRLP4 4160
INDIRI4
CNSTI4 0
NEI4 $1612
LABELV $1616
line 3587
;3587:			if (len) {
ADDRLP4 2052
INDIRI4
CNSTI4 0
EQI4 $1617
line 3588
;3588:				if (item->textalignment == ITEM_ALIGN_LEFT) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1619
line 3589
;3589:					item->textRect.x = item->textalignx;
ADDRLP4 4164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4164
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 4164
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ASGNF4
line 3590
;3590:				} else if (item->textalignment == ITEM_ALIGN_RIGHT) {
ADDRGP4 $1620
JUMPV
LABELV $1619
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1621
line 3591
;3591:					item->textRect.x = item->textalignx - newLineWidth;
ADDRLP4 4164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4164
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 4164
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 2064
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 3592
;3592:				} else if (item->textalignment == ITEM_ALIGN_CENTER) {
ADDRGP4 $1622
JUMPV
LABELV $1621
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1623
line 3593
;3593:					item->textRect.x = item->textalignx - newLineWidth / 2;
ADDRLP4 4164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4164
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 4164
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 2064
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ASGNF4
line 3594
;3594:				}
LABELV $1623
LABELV $1622
LABELV $1620
line 3595
;3595:				item->textRect.y = y;
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 2072
INDIRF4
ASGNF4
line 3596
;3596:				ToWindowCoords(&item->textRect.x, &item->textRect.y, &item->window);
ADDRLP4 4164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4164
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4164
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 4164
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 3598
;3597:				//
;3598:				buff[newLine] = '\0';
ADDRLP4 2060
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 3599
;3599:				DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, buff, 0, 0, item->textStyle, item->iMenuFont);
ADDRLP4 4168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4168
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 4168
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 4168
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 2084
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 4168
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 4168
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3600
;3600:			}
LABELV $1617
line 3601
;3601:			if (*p == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1625
line 3602
;3602:				break;
ADDRGP4 $1606
JUMPV
LABELV $1625
line 3605
;3603:			}
;3604:			//
;3605:			y += height + 5;
ADDRLP4 2072
ADDRLP4 2072
INDIRF4
ADDRLP4 2076
INDIRI4
CNSTI4 5
ADDI4
CVIF4 4
ADDF4
ASGNF4
line 3606
;3606:			p = newLinePtr;
ADDRLP4 0
ADDRLP4 2068
INDIRP4
ASGNP4
line 3607
;3607:			len = 0;
ADDRLP4 2052
CNSTI4 0
ASGNI4
line 3608
;3608:			newLine = 0;
ADDRLP4 2060
CNSTI4 0
ASGNI4
line 3609
;3609:			newLineWidth = 0;
ADDRLP4 2064
CNSTI4 0
ASGNI4
line 3610
;3610:			continue;
ADDRGP4 $1605
JUMPV
LABELV $1612
line 3612
;3611:		}
;3612:		buff[len++] = *p++;
ADDRLP4 4164
ADDRLP4 2052
INDIRI4
ASGNI4
ADDRLP4 4172
CNSTI4 1
ASGNI4
ADDRLP4 2052
ADDRLP4 4164
INDIRI4
ADDRLP4 4172
INDIRI4
ADDI4
ASGNI4
ADDRLP4 4168
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4168
INDIRP4
ADDRLP4 4172
INDIRI4
ADDP4
ASGNP4
ADDRLP4 4164
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 4168
INDIRP4
INDIRI1
ASGNI1
line 3613
;3613:		buff[len] = '\0';
ADDRLP4 2052
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 3614
;3614:	}
LABELV $1605
line 3579
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1604
LABELV $1606
line 3615
;3615:}
LABELV $1597
endproc Item_Text_AutoWrapped_Paint 4176 36
export Item_Text_Wrapped_Paint
proc Item_Text_Wrapped_Paint 2112 36
line 3617
;3616:
;3617:void Item_Text_Wrapped_Paint(itemDef_t *item) {
line 3628
;3618:	char text[1024];
;3619:	const char *p, *start, *textPtr;
;3620:	char buff[1024];
;3621:	int width, height;
;3622:	float x, y;
;3623:	vec4_t color;
;3624:
;3625:	// now paint the text and/or any optional images
;3626:	// default to left
;3627:
;3628:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1628
line 3629
;3629:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1630
line 3630
;3630:			return;
ADDRGP4 $1627
JUMPV
LABELV $1630
line 3632
;3631:		}
;3632:		else {
line 3633
;3633:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 1068
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 3634
;3634:			textPtr = text;
ADDRLP4 1060
ADDRLP4 1068
ASGNP4
line 3635
;3635:		}
line 3636
;3636:	}
ADDRGP4 $1629
JUMPV
LABELV $1628
line 3637
;3637:	else {
line 3638
;3638:		textPtr = item->text;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 3639
;3639:	}
LABELV $1629
line 3640
;3640:	if (*textPtr == '\0') {
ADDRLP4 1060
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1632
line 3641
;3641:		return;
ADDRGP4 $1627
JUMPV
LABELV $1632
line 3644
;3642:	}
;3643:
;3644:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1040
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 3645
;3645:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1064
ARGP4
ADDRLP4 1056
ARGP4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 3647
;3646:
;3647:	x = item->textRect.x;
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ASGNF4
line 3648
;3648:	y = item->textRect.y;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ASGNF4
line 3649
;3649:	start = textPtr;
ADDRLP4 4
ADDRLP4 1060
INDIRP4
ASGNP4
line 3650
;3650:	p = strchr(textPtr, '\r');
ADDRLP4 1060
INDIRP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 2092
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2092
INDIRP4
ASGNP4
ADDRGP4 $1635
JUMPV
LABELV $1634
line 3651
;3651:	while (p && *p) {
line 3652
;3652:		strncpy(buff, start, p-start+1);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 3653
;3653:		buff[p-start] = '\0';
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 3654
;3654:		DC->drawText(x, y, item->textscale, color, buff, 0, 0, item->textStyle, item->iMenuFont);
ADDRLP4 1036
INDIRF4
ARGF4
ADDRLP4 1032
INDIRF4
ARGF4
ADDRLP4 2100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2100
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ARGP4
ADDRLP4 8
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2100
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 2100
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3655
;3655:		y += height + 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRF4
ADDRLP4 1056
INDIRI4
CNSTI4 2
ADDI4
CVIF4 4
ADDF4
ASGNF4
line 3656
;3656:		start += p - start + 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
line 3657
;3657:		p = strchr(p+1, '\r');
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 2108
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2108
INDIRP4
ASGNP4
line 3658
;3658:	}
LABELV $1635
line 3651
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1637
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1634
LABELV $1637
line 3659
;3659:	DC->drawText(x, y, item->textscale, color, start, 0, 0, item->textStyle, item->iMenuFont);
ADDRLP4 1036
INDIRF4
ARGF4
ADDRLP4 1032
INDIRF4
ARGF4
ADDRLP4 2100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2100
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2100
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 2100
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3660
;3660:}
LABELV $1627
endproc Item_Text_Wrapped_Paint 2112 36
export Item_Text_Paint
proc Item_Text_Paint 1060 36
line 3662
;3661:
;3662:void Item_Text_Paint(itemDef_t *item) {
line 3668
;3663:	char text[1024];
;3664:	const char *textPtr;
;3665:	int height, width;
;3666:	vec4_t color;
;3667:
;3668:	if (item->window.flags & WINDOW_WRAPPED) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $1639
line 3669
;3669:		Item_Text_Wrapped_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Wrapped_Paint
CALLV
pop
line 3670
;3670:		return;
ADDRGP4 $1638
JUMPV
LABELV $1639
line 3672
;3671:	}
;3672:	if (item->window.flags & WINDOW_AUTOWRAPPED) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $1641
line 3673
;3673:		Item_Text_AutoWrapped_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_AutoWrapped_Paint
CALLV
pop
line 3674
;3674:		return;
ADDRGP4 $1638
JUMPV
LABELV $1641
line 3677
;3675:	}
;3676:
;3677:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1643
line 3678
;3678:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1645
line 3679
;3679:			return;
ADDRGP4 $1638
JUMPV
LABELV $1645
line 3681
;3680:		}
;3681:		else {
line 3682
;3682:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 3683
;3683:			textPtr = text;
ADDRLP4 0
ADDRLP4 28
ASGNP4
line 3684
;3684:		}
line 3685
;3685:	}
ADDRGP4 $1644
JUMPV
LABELV $1643
line 3686
;3686:	else {
line 3687
;3687:		textPtr = item->text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 3688
;3688:	}
LABELV $1644
line 3691
;3689:
;3690:	// this needs to go here as it sets extents for cvar types as well
;3691:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 3693
;3692:
;3693:	if (*textPtr == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1647
line 3694
;3694:		return;
ADDRGP4 $1638
JUMPV
LABELV $1647
line 3698
;3695:	}
;3696:
;3697:
;3698:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 3730
;3699:
;3700:	//FIXME: this is a fucking mess
;3701:/*
;3702:	adjust = 0;
;3703:	if (item->textStyle == ITEM_TEXTSTYLE_OUTLINED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;3704:		adjust = 0.5;
;3705:	}
;3706:
;3707:	if (item->textStyle == ITEM_TEXTSTYLE_SHADOWED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;3708:		Fade(&item->window.flags, &DC->Assets.shadowColor[3], DC->Assets.fadeClamp, &item->window.nextTime, DC->Assets.fadeCycle, qfalse);
;3709:		DC->drawText(item->textRect.x + DC->Assets.shadowX, item->textRect.y + DC->Assets.shadowY, item->textscale, DC->Assets.shadowColor, textPtr, adjust);
;3710:	}
;3711:*/
;3712:
;3713:
;3714://	if (item->textStyle == ITEM_TEXTSTYLE_OUTLINED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;3715://		Fade(&item->window.flags, &item->window.outlineColor[3], DC->Assets.fadeClamp, &item->window.nextTime, DC->Assets.fadeCycle, qfalse);
;3716://		/*
;3717://		Text_Paint(item->textRect.x-1, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;3718://		Text_Paint(item->textRect.x, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;3719://		Text_Paint(item->textRect.x+1, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;3720://		Text_Paint(item->textRect.x-1, item->textRect.y, item->textscale, item->window.foreColor, textPtr, adjust);
;3721://		Text_Paint(item->textRect.x+1, item->textRect.y, item->textscale, item->window.foreColor, textPtr, adjust);
;3722://		Text_Paint(item->textRect.x-1, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;3723://		Text_Paint(item->textRect.x, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;3724://		Text_Paint(item->textRect.x+1, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;3725://		*/
;3726://		DC->drawText(item->textRect.x - 1, item->textRect.y + 1, item->textscale * 1.02, item->window.outlineColor, textPtr, adjust);
;3727://	}
;3728:
;3729://DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, textPtr, 0, 0, item->textStyle);
;3730:	DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, textPtr, 0, 0, item->textStyle, item->iMenuFont);
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 1052
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1052
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 1052
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 1052
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3732
;3731:
;3732:	if (item->text2)	// Is there a second line of text?
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1649
line 3733
;3733:	{
line 3734
;3734:		Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 3736
;3735://		DC->drawText(item->textRect.x + item->text2alignx, item->textRect.y + item->text2aligny, item->textscale, color, item->text2, 0, 0, item->textStyle);
;3736:		DC->drawText(item->textRect.x + item->text2alignx, item->textRect.y + item->text2aligny, item->textscale, color, item->text2, 0, 0, item->textStyle,item->iMenuFont);
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 1056
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 1056
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ADDRLP4 1056
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 1056
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 1056
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 1056
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 1056
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3737
;3737:	}
LABELV $1649
line 3739
;3738:
;3739:}
LABELV $1638
endproc Item_Text_Paint 1060 36
export Item_TextField_Paint
proc Item_TextField_Paint 1104 40
line 3746
;3740:
;3741:
;3742:
;3743://float			trap_Cvar_VariableValue( const char *var_name );
;3744://void			trap_Cvar_VariableStringBuffer( const char *var_name, char *buffer, int bufsize );
;3745:
;3746:void Item_TextField_Paint(itemDef_t *item) {
line 3750
;3747:	char buff[1024];
;3748:	vec4_t newColor, lowLight;
;3749:	int offset;
;3750:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 3751
;3751:	editFieldDef_t *editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 3753
;3752:
;3753:	Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3755
;3754:
;3755:	buff[0] = '\0';
ADDRLP4 8
CNSTI1 0
ASGNI1
line 3757
;3756:
;3757:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1652
line 3758
;3758:		DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 3759
;3759:	} 
LABELV $1652
line 3761
;3760:
;3761:	parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 3763
;3762:
;3763:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1654
line 3764
;3764:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 1032
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 3765
;3765:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 1032+4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 3766
;3766:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 1032+8
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 3767
;3767:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 1032+12
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 3768
;3768:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 1068
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 1032
ARGP4
ADDRLP4 1048
ARGP4
CNSTF4 1056964608
ADDRLP4 1068
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3769
;3769:	} else {
ADDRGP4 $1655
JUMPV
LABELV $1654
line 3770
;3770:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 1048
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3771
;3771:	}
LABELV $1655
line 3773
;3772:
;3773:	offset = (item->text && *item->text) ? 8 : 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1660
ADDRLP4 1072
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1660
ADDRLP4 1068
CNSTI4 8
ASGNI4
ADDRGP4 $1661
JUMPV
LABELV $1660
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $1661
ADDRLP4 1064
ADDRLP4 1068
INDIRI4
ASGNI4
line 3774
;3774:	if (item->window.flags & WINDOW_HASFOCUS && g_editingField) {
ADDRLP4 1076
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 1076
INDIRI4
EQI4 $1662
ADDRGP4 g_editingField
INDIRI4
ADDRLP4 1076
INDIRI4
EQI4 $1662
line 3775
;3775:		char cursor = DC->getOverstrikeMode() ? '_' : '|';
ADDRLP4 1088
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
EQI4 $1665
ADDRLP4 1084
CNSTI4 95
ASGNI4
ADDRGP4 $1666
JUMPV
LABELV $1665
ADDRLP4 1084
CNSTI4 124
ASGNI4
LABELV $1666
ADDRLP4 1080
ADDRLP4 1084
INDIRI4
CVII1 4
ASGNI1
line 3776
;3776:		DC->drawTextWithCursor(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, item->cursorPos - editPtr->paintOffset , cursor, editPtr->maxPaintChars, item->textStyle, item->iMenuFont);
ADDRLP4 1092
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1092
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 1092
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ADDRLP4 1064
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1092
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1092
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1048
ARGP4
ADDRLP4 1100
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1100
INDIRI4
ADDRLP4 8
ADDP4
ARGP4
ADDRLP4 1092
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 1100
INDIRI4
SUBI4
ARGI4
ADDRLP4 1080
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 1092
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 1092
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 124
ADDP4
INDIRP4
CALLV
pop
line 3777
;3777:	} else {
ADDRGP4 $1663
JUMPV
LABELV $1662
line 3779
;3778://		DC->drawText(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, 0, editPtr->maxPaintChars, item->textStyle);
;3779:		DC->drawText(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, 0, editPtr->maxPaintChars, item->textStyle,item->iMenuFont);
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 1080
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ADDRLP4 1064
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1080
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1080
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1048
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRLP4 8
ADDP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 1080
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 1080
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3780
;3780:	}
LABELV $1663
line 3781
;3781:}
LABELV $1651
endproc Item_TextField_Paint 1104 40
export Item_YesNo_Paint
proc Item_YesNo_Paint 100 36
line 3783
;3782:
;3783:void Item_YesNo_Paint(itemDef_t *item) {
line 3788
;3784:	char	sYES[20];
;3785:	char	sNO[20];
;3786:	vec4_t newColor, lowLight;
;3787:	float value;
;3788:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 3790
;3789:
;3790:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1669
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 80
ADDRLP4 84
INDIRF4
ASGNF4
ADDRGP4 $1670
JUMPV
LABELV $1669
ADDRLP4 80
CNSTF4 0
ASGNF4
LABELV $1670
ADDRLP4 76
ADDRLP4 80
INDIRF4
ASGNF4
line 3792
;3791:
;3792:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1671
line 3793
;3793:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 44
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 3794
;3794:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 44+4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 3795
;3795:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 44+8
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 3796
;3796:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 44+12
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 3797
;3797:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 88
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 60
ARGP4
CNSTF4 1056964608
ADDRLP4 88
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3798
;3798:	} else {
ADDRGP4 $1672
JUMPV
LABELV $1671
line 3799
;3799:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 60
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3800
;3800:	}
LABELV $1672
line 3803
;3801:
;3802:
;3803:	trap_SP_GetStringTextString("MENUS0_YES",sYES, sizeof(sYES));
ADDRGP4 $1676
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 3804
;3804:	trap_SP_GetStringTextString("MENUS0_NO", sNO,  sizeof(sNO));
ADDRGP4 $1677
ARGP4
ADDRLP4 24
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 3806
;3805:
;3806:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1678
line 3807
;3807:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3809
;3808://		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, (value != 0) ? sYES : sNO, 0, 0, item->textStyle);
;3809:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, (value != 0) ? sYES : sNO, 0, 0, item->textStyle,item->iMenuFont);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
ARGP4
ADDRLP4 76
INDIRF4
CNSTF4 0
EQF4 $1681
ADDRLP4 88
ADDRLP4 4
ASGNP4
ADDRGP4 $1682
JUMPV
LABELV $1681
ADDRLP4 88
ADDRLP4 24
ASGNP4
LABELV $1682
ADDRLP4 88
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3810
;3810:	} else {
ADDRGP4 $1679
JUMPV
LABELV $1678
line 3812
;3811://		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, (value != 0) ? sYES : sNO, 0, 0, item->textStyle);
;3812:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, (value != 0) ? sYES : sNO, 0, 0, item->textStyle,item->iMenuFont);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
ARGP4
ADDRLP4 76
INDIRF4
CNSTF4 0
EQF4 $1684
ADDRLP4 88
ADDRLP4 4
ASGNP4
ADDRGP4 $1685
JUMPV
LABELV $1684
ADDRLP4 88
ADDRLP4 24
ASGNP4
LABELV $1685
ADDRLP4 88
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3813
;3813:	}
LABELV $1679
line 3814
;3814:}
LABELV $1667
endproc Item_YesNo_Paint 100 36
export Item_Multi_Paint
proc Item_Multi_Paint 48 36
line 3816
;3815:
;3816:void Item_Multi_Paint(itemDef_t *item) {
line 3818
;3817:	vec4_t newColor, lowLight;
;3818:	const char *text = "";
ADDRLP4 4
ADDRGP4 $99
ASGNP4
line 3819
;3819:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 3821
;3820:
;3821:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1687
line 3822
;3822:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 8
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 3823
;3823:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 8+4
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 3824
;3824:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 8+8
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 3825
;3825:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 8+12
CNSTF4 1061997773
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 3826
;3826:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 40
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 24
ARGP4
CNSTF4 1056964608
ADDRLP4 40
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3827
;3827:	} else {
ADDRGP4 $1688
JUMPV
LABELV $1687
line 3828
;3828:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3829
;3829:	}
LABELV $1688
line 3831
;3830:
;3831:	text = Item_Multi_Setting(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Item_Multi_Setting
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 3833
;3832:
;3833:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1692
line 3834
;3834:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3836
;3835://		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle);
;3836:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle,item->iMenuFont);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3837
;3837:	} else {
ADDRGP4 $1693
JUMPV
LABELV $1692
line 3839
;3838://		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle);
;3839:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle,item->iMenuFont);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3840
;3840:	}
LABELV $1693
line 3841
;3841:}
LABELV $1686
endproc Item_Multi_Paint 48 36
data
align 4
LABELV g_bindings
address $1696
byte 4 9
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1697
byte 4 13
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1698
byte 4 138
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1699
byte 4 132
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1700
byte 4 133
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1701
byte 4 44
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1702
byte 4 46
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1703
byte 4 32
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1704
byte 4 99
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1705
byte 4 134
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1706
byte 4 135
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1707
byte 4 136
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1708
byte 4 141
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1709
byte 4 140
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1710
byte 4 47
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1711
byte 4 144
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1712
byte 4 49
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1713
byte 4 50
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1714
byte 4 51
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1715
byte 4 52
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1716
byte 4 53
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1717
byte 4 54
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1718
byte 4 55
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1719
byte 4 56
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1720
byte 4 57
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1721
byte 4 48
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1722
byte 4 108
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1723
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1724
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1725
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1726
byte 4 137
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1727
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1728
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1729
byte 4 104
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1730
byte 4 117
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1731
byte 4 91
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1732
byte 4 93
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1733
byte 4 119
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1734
byte 4 114
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1735
byte 4 116
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1736
byte 4 121
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1737
byte 4 110
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1738
byte 4 111
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1739
byte 4 100
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1740
byte 4 112
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1741
byte 4 99
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1742
byte 4 102
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1743
byte 4 118
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1744
byte 4 101
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1745
byte 4 105
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1746
byte 4 107
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1747
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1748
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1749
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1750
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1751
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1752
byte 4 139
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1753
byte 4 140
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1754
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1755
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1756
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1757
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1728
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1758
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1759
byte 4 145
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1760
byte 4 146
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1761
byte 4 147
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1762
byte 4 148
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1763
byte 4 149
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1764
byte 4 150
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1765
byte 4 151
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1766
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1767
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1768
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1769
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1770
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1771
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1772
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1773
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1774
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1775
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1776
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1777
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1778
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1779
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1780
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1781
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1782
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1783
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
lit
align 4
LABELV g_bindCount
byte 4 89
code
proc Controls_GetKeyAssignment 276 12
line 3967
;3842:
;3843:
;3844:typedef struct {
;3845:	char	*command;
;3846:	int		id;
;3847:	int		defaultbind1;
;3848:	int		defaultbind2;
;3849:	int		bind1;
;3850:	int		bind2;
;3851:} bind_t;
;3852:
;3853:typedef struct
;3854:{
;3855:	char*	name;
;3856:	float	defaultvalue;
;3857:	float	value;	
;3858:} configcvar_t;
;3859:
;3860:
;3861:static bind_t g_bindings[] = 
;3862:{
;3863:	{"+scores",			 K_TAB,				-1,		-1, -1},
;3864:	{"+button2",		 K_ENTER,			-1,		-1, -1},
;3865:	{"+speed", 			 K_SHIFT,			-1,		-1,	-1},
;3866:	{"+forward", 		 K_UPARROW,			-1,		-1, -1},
;3867:	{"+back", 			 K_DOWNARROW,		-1,		-1, -1},
;3868:	{"+moveleft",		 ',',				-1,		-1, -1},
;3869:	{"+moveright", 		 '.',				-1,		-1, -1},
;3870:	{"+moveup",			 K_SPACE,			-1,		-1, -1},
;3871:	{"+movedown",		 'c',				-1,		-1, -1},
;3872:	{"+left", 			 K_LEFTARROW,		-1,		-1, -1},
;3873:	{"+right", 			 K_RIGHTARROW,		-1,		-1, -1},
;3874:	{"+strafe", 		 K_ALT,				-1,		-1, -1},
;3875:	{"+lookup", 		 K_PGDN,			-1,		-1, -1},
;3876:	{"+lookdown",	 	 K_DEL,				-1,		-1, -1},
;3877:	{"+mlook", 			 '/',				-1,		-1, -1},
;3878:	{"centerview",		 K_END,				-1,		-1, -1},
;3879://	{"+zoom", 			 -1,				-1,		-1, -1},
;3880:	{"weapon 1",		 '1',				-1,		-1, -1},
;3881:	{"weapon 2",		 '2',				-1,		-1, -1},
;3882:	{"weapon 3",		 '3',				-1,		-1, -1},
;3883:	{"weapon 4",		 '4',				-1,		-1, -1},
;3884:	{"weapon 5",		 '5',				-1,		-1, -1},
;3885:	{"weapon 6",		 '6',				-1,		-1, -1},
;3886:	{"weapon 7",		 '7',				-1,		-1, -1},
;3887:	{"weapon 8",		 '8',				-1,		-1, -1},
;3888:	{"weapon 9",		 '9',				-1,		-1, -1},
;3889:	{"weapon 10",		 '0',				-1,		-1, -1},
;3890:	{"saberAttackCycle", 'l',				-1,		-1, -1},
;3891:	{"weapon 11",		 -1,				-1,		-1, -1},
;3892:	{"weapon 12",		 -1,				-1,		-1, -1},
;3893:	{"weapon 13",		 -1,				-1,		-1, -1},
;3894:	{"+attack", 		 K_CTRL,			-1,		-1, -1},
;3895:	{"+altattack", 		-1,					-1,		-1,	-1},
;3896:	{"+use",			-1,					-1,		-1, -1},
;3897:	{"engage_duel",		'h',				-1,		-1, -1},
;3898:	{"+taunt",			'u',				-1,		-1, -1},
;3899:	{"weapprev",		 '[',				-1,		-1, -1},
;3900:	{"weapnext", 		 ']',				-1,		-1, -1},
;3901:	{"prevTeamMember",	'w',				-1,		-1, -1},
;3902:	{"nextTeamMember",	'r',				-1,		-1, -1},
;3903:	{"nextOrder",		't',				-1,		-1, -1},
;3904:	{"confirmOrder",	'y',				-1,		-1, -1},
;3905:	{"denyOrder",		'n',				-1,		-1, -1},
;3906:	{"taskOffense",		'o',				-1,		-1, -1},
;3907:	{"taskDefense",		'd',				-1,		-1, -1},
;3908:	{"taskPatrol",		'p',				-1,		-1, -1},
;3909:	{"taskCamp",		'c',				-1,		-1, -1},
;3910:	{"taskFollow",		'f',				-1,		-1, -1},
;3911:	{"taskRetrieve",	'v',				-1,		-1, -1},
;3912:	{"taskEscort",		'e',				-1,		-1, -1},
;3913:	{"taskOwnFlag",		'i',				-1,		-1, -1},
;3914:	{"taskSuicide",		'k',				-1,		-1, -1},
;3915:	{"tauntKillInsult", -1,					-1,		-1, -1},
;3916:	{"tauntPraise",		-1,					-1,		-1, -1},
;3917:	{"tauntTaunt",		-1,					-1,		-1, -1},
;3918:	{"tauntDeathInsult",-1,					-1,		-1, -1},
;3919:	{"tauntGauntlet",	-1,					-1,		-1, -1},
;3920:	{"scoresUp",		K_INS,			-1,		-1, -1},
;3921:	{"scoresDown",		K_DEL,			-1,		-1, -1},
;3922:	{"messagemode",		-1,					-1,		-1, -1},
;3923:	{"messagemode2",	-1,					-1,		-1, -1},
;3924:	{"messagemode3",	-1,					-1,		-1, -1},
;3925:	{"messagemode4",	-1,					-1,		-1, -1},
;3926:	{"+use",			-1,					-1,		-1,	-1},
;3927:	{"+force_jump",		-1,					-1,		-1,	-1},
;3928:	{"force_throw",		K_F1,				-1,		-1,	-1},
;3929:	{"force_pull",		K_F2,				-1,		-1,	-1},
;3930:	{"force_speed",		K_F3,				-1,		-1,	-1},
;3931:	{"force_distract",	K_F4,				-1,		-1,	-1},
;3932:	{"force_heal",		K_F5,				-1,		-1,	-1},
;3933:	{"+force_grip",		K_F6,				-1,		-1,	-1},
;3934:	{"+force_lightning",K_F7,				-1,		-1,	-1},
;3935://mp only
;3936:	{"+force_drain",	-1,					-1,		-1,	-1},
;3937:	{"force_rage",		-1,					-1,		-1,	-1},
;3938:	{"force_protect",	-1,					-1,		-1,	-1},
;3939:	{"force_absorb",	-1,					-1,		-1,	-1},
;3940:	{"force_healother",	-1,					-1,		-1,	-1},
;3941:	{"force_forcepowerother",	-1,			-1,		-1,	-1},
;3942:	{"force_seeing",	-1,					-1,		-1,	-1},
;3943:
;3944:	{"+useforce",		-1,					-1,		-1,	-1},
;3945:	{"forcenext",		-1,					-1,		-1,	-1},
;3946:	{"forceprev",		-1,					-1,		-1,	-1},
;3947:	{"invnext",			-1,					-1,		-1,	-1},
;3948:	{"invprev",			-1,					-1,		-1,	-1},
;3949:	{"use_seeker",		-1,					-1,		-1,	-1},
;3950:	{"use_field",		-1,					-1,		-1,	-1},
;3951:	{"use_bacta",		-1,					-1,		-1,	-1},
;3952:	{"use_electrobinoculars",	-1,			-1,		-1,	-1},
;3953:	{"use_sentry",		-1,					-1,		-1,	-1},
;3954:	{"cg_thirdperson !",-1,					-1,		-1,	-1},
;3955:
;3956:};
;3957:
;3958:
;3959:static const int g_bindCount = sizeof(g_bindings) / sizeof(bind_t);
;3960:
;3961:/*
;3962:=================
;3963:Controls_GetKeyAssignment
;3964:=================
;3965:*/
;3966:static void Controls_GetKeyAssignment (char *command, int *twokeys)
;3967:{
line 3972
;3968:	int		count;
;3969:	int		j;
;3970:	char	b[256];
;3971:
;3972:	twokeys[0] = twokeys[1] = -1;
ADDRLP4 264
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 268
CNSTI4 -1
ASGNI4
ADDRLP4 264
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
ADDRLP4 264
INDIRP4
ADDRLP4 268
INDIRI4
ASGNI4
line 3973
;3973:	count = 0;
ADDRLP4 260
CNSTI4 0
ASGNI4
line 3975
;3974:
;3975:	for ( j = 0; j < 256; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1785
line 3976
;3976:	{
line 3977
;3977:		DC->getBindingBuf( j, b, 256 );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 164
ADDP4
INDIRP4
CALLV
pop
line 3978
;3978:		if ( *b == 0 ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1789
line 3979
;3979:			continue;
ADDRGP4 $1786
JUMPV
LABELV $1789
line 3981
;3980:		}
;3981:		if ( !Q_stricmp( b, command ) ) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $1791
line 3982
;3982:			twokeys[count] = j;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 3983
;3983:			count++;
ADDRLP4 260
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3984
;3984:			if (count == 2) {
ADDRLP4 260
INDIRI4
CNSTI4 2
NEI4 $1793
line 3985
;3985:				break;
ADDRGP4 $1787
JUMPV
LABELV $1793
line 3987
;3986:			}
;3987:		}
LABELV $1791
line 3988
;3988:	}
LABELV $1786
line 3975
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $1785
LABELV $1787
line 3989
;3989:}
LABELV $1784
endproc Controls_GetKeyAssignment 276 12
export Controls_GetConfig
proc Controls_GetConfig 12 8
line 3997
;3990:
;3991:/*
;3992:=================
;3993:Controls_GetConfig
;3994:=================
;3995:*/
;3996:void Controls_GetConfig( void )
;3997:{
line 4002
;3998:	int		i;
;3999:	int		twokeys[2];
;4000:
;4001:	// iterate each command, get its numeric binding
;4002:	for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1799
JUMPV
LABELV $1796
line 4003
;4003:	{
line 4005
;4004:
;4005:		Controls_GetKeyAssignment(g_bindings[i].command, twokeys);
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Controls_GetKeyAssignment
CALLV
pop
line 4007
;4006:
;4007:		g_bindings[i].bind1 = twokeys[0];
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 4008
;4008:		g_bindings[i].bind2 = twokeys[1];
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
ADDRLP4 4+4
INDIRI4
ASGNI4
line 4009
;4009:	}
LABELV $1797
line 4002
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1799
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1796
line 4019
;4010:
;4011:	//s_controls.invertmouse.curvalue  = DC->getCVarValue( "m_pitch" ) < 0;
;4012:	//s_controls.smoothmouse.curvalue  = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "m_filter" ) );
;4013:	//s_controls.alwaysrun.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_run" ) );
;4014:	//s_controls.autoswitch.curvalue   = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cg_autoswitch" ) );
;4015:	//s_controls.sensitivity.curvalue  = UI_ClampCvar( 2, 30, Controls_GetCvarValue( "sensitivity" ) );
;4016:	//s_controls.joyenable.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "in_joystick" ) );
;4017:	//s_controls.joythreshold.curvalue = UI_ClampCvar( 0.05, 0.75, Controls_GetCvarValue( "joy_threshold" ) );
;4018:	//s_controls.freelook.curvalue     = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_freelook" ) );
;4019:}
LABELV $1795
endproc Controls_GetConfig 12 8
export Controls_SetConfig
proc Controls_SetConfig 12 8
line 4027
;4020:
;4021:/*
;4022:=================
;4023:Controls_SetConfig
;4024:=================
;4025:*/
;4026:void Controls_SetConfig(qboolean restart)
;4027:{
line 4031
;4028:	int		i;
;4029:
;4030:	// iterate each command, get its numeric binding
;4031:	for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1807
JUMPV
LABELV $1804
line 4032
;4032:	{
line 4033
;4033:		if (g_bindings[i].bind1 != -1)
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1808
line 4034
;4034:		{	
line 4035
;4035:			DC->setBinding( g_bindings[i].bind1, g_bindings[i].command );
ADDRLP4 4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLV
pop
line 4037
;4036:
;4037:			if (g_bindings[i].bind2 != -1)
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1812
line 4038
;4038:				DC->setBinding( g_bindings[i].bind2, g_bindings[i].command );
ADDRLP4 8
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLV
pop
LABELV $1812
line 4039
;4039:		}
LABELV $1808
line 4040
;4040:	}
LABELV $1805
line 4031
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1807
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1804
line 4057
;4041:
;4042:	//if ( s_controls.invertmouse.curvalue )
;4043:	//	DC->setCVar("m_pitch", va("%f),-fabs( DC->getCVarValue( "m_pitch" ) ) );
;4044:	//else
;4045:	//	trap_Cvar_SetValue( "m_pitch", fabs( trap_Cvar_VariableValue( "m_pitch" ) ) );
;4046:
;4047:	//trap_Cvar_SetValue( "m_filter", s_controls.smoothmouse.curvalue );
;4048:	//trap_Cvar_SetValue( "cl_run", s_controls.alwaysrun.curvalue );
;4049:	//trap_Cvar_SetValue( "cg_autoswitch", s_controls.autoswitch.curvalue );
;4050:	//trap_Cvar_SetValue( "sensitivity", s_controls.sensitivity.curvalue );
;4051:	//trap_Cvar_SetValue( "in_joystick", s_controls.joyenable.curvalue );
;4052:	//trap_Cvar_SetValue( "joy_threshold", s_controls.joythreshold.curvalue );
;4053:	//trap_Cvar_SetValue( "cl_freelook", s_controls.freelook.curvalue );
;4054://
;4055://	DC->executeText(EXEC_APPEND, "in_restart\n");
;4056:// ^--this is bad, it shows the cursor during map load, if you need to, add it as an exec cmd to use_joy or something.
;4057:}
LABELV $1803
endproc Controls_SetConfig 12 8
export BindingIDFromName
proc BindingIDFromName 8 8
line 4060
;4058:
;4059:
;4060:int BindingIDFromName(const char *name) {
line 4062
;4061:	int i;
;4062:  for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1820
JUMPV
LABELV $1817
line 4063
;4063:	{
line 4064
;4064:		if (Q_stricmp(name, g_bindings[i].command) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1821
line 4065
;4065:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1816
JUMPV
LABELV $1821
line 4067
;4066:		}
;4067:	}
LABELV $1818
line 4062
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1820
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1817
line 4068
;4068:	return -1;
CNSTI4 -1
RETI4
LABELV $1816
endproc BindingIDFromName 8 8
export BindingFromName
proc BindingFromName 52 12
line 4074
;4069:}
;4070:
;4071:char g_nameBind1[32];
;4072:char g_nameBind2[32];
;4073:
;4074:void BindingFromName(const char *cvar) {
line 4080
;4075:	int		i, b1, b2;
;4076:	char	sOR[32];
;4077:
;4078:
;4079:	// iterate each command, set its default binding
;4080:	for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1827
JUMPV
LABELV $1824
line 4081
;4081:	{
line 4082
;4082:		if (Q_stricmp(cvar, g_bindings[i].command) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $1828
line 4083
;4083:			b1 = g_bindings[i].bind1;
ADDRLP4 4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ASGNI4
line 4084
;4084:			if (b1 == -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $1831
line 4085
;4085:				break;
ADDRGP4 $1826
JUMPV
LABELV $1831
line 4087
;4086:			}
;4087:				DC->keynumToStringBuf( b1, g_nameBind1, 32 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 g_nameBind1
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 160
ADDP4
INDIRP4
CALLV
pop
line 4088
;4088:				Q_strupr(g_nameBind1);
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 4090
;4089:
;4090:				b2 = g_bindings[i].bind2;
ADDRLP4 8
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ASGNI4
line 4091
;4091:				if (b2 != -1)
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $1823
line 4092
;4092:				{
line 4093
;4093:					DC->keynumToStringBuf( b2, g_nameBind2, 32 );
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 g_nameBind2
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 160
ADDP4
INDIRP4
CALLV
pop
line 4094
;4094:					Q_strupr(g_nameBind2);
ADDRGP4 g_nameBind2
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 4096
;4095:
;4096:					trap_SP_GetStringTextString("MENUS3_KEYBIND_OR",sOR, sizeof(sOR));
ADDRGP4 $1836
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 4098
;4097:
;4098:					strcat( g_nameBind1, va(" %s ",sOR));
ADDRGP4 $1837
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 g_nameBind1
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 4099
;4099:					strcat( g_nameBind1, g_nameBind2 );
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 g_nameBind2
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 4100
;4100:				}
line 4101
;4101:			return;
ADDRGP4 $1823
JUMPV
LABELV $1828
line 4103
;4102:		}
;4103:	}
LABELV $1825
line 4080
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1827
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1824
LABELV $1826
line 4104
;4104:	strcpy(g_nameBind1, "???");
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 $1838
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 4105
;4105:}
LABELV $1823
endproc BindingFromName 52 12
export Item_Slider_Paint
proc Item_Slider_Paint 68 20
line 4107
;4106:
;4107:void Item_Slider_Paint(itemDef_t *item) {
line 4110
;4108:	vec4_t newColor, lowLight;
;4109:	float x, y, value;
;4110:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4112
;4111:
;4112:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1841
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 52
INDIRF4
ASGNF4
ADDRGP4 $1842
JUMPV
LABELV $1841
ADDRLP4 48
CNSTF4 0
ASGNF4
LABELV $1842
ADDRLP4 44
ADDRLP4 48
INDIRF4
ASGNF4
line 4114
;4113:
;4114:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1843
line 4115
;4115:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 12
CNSTF4 1061997773
ADDRLP4 4
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 4116
;4116:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 12+4
CNSTF4 1061997773
ADDRLP4 4
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 4117
;4117:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 12+8
CNSTF4 1061997773
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 4118
;4118:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 12+12
CNSTF4 1061997773
ADDRLP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 4119
;4119:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 56
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ARGP4
CNSTF4 1056964608
ADDRLP4 56
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 4120
;4120:	} else {
ADDRGP4 $1844
JUMPV
LABELV $1843
line 4121
;4121:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4122
;4122:	}
LABELV $1844
line 4124
;4123:
;4124:	y = item->window.rect.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 4125
;4125:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1848
line 4126
;4126:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 4127
;4127:		x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 4128
;4128:	} else {
ADDRGP4 $1849
JUMPV
LABELV $1848
line 4129
;4129:		x = item->window.rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 4130
;4130:	}
LABELV $1849
line 4131
;4131:	DC->setColor(newColor);
ADDRLP4 28
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 4132
;4132:	DC->drawHandlePic( x, y, SLIDER_WIDTH, SLIDER_HEIGHT, DC->Assets.sliderBar );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1119879168
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4134
;4133:
;4134:	x = Item_Slider_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Item_Slider_ThumbPosition
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 60
INDIRF4
ASGNF4
line 4135
;4135:	DC->drawHandlePic( x - (SLIDER_THUMB_WIDTH / 2), y - 2, SLIDER_THUMB_WIDTH, SLIDER_THUMB_HEIGHT, DC->Assets.sliderThumb );
ADDRLP4 0
INDIRF4
CNSTF4 1086324736
SUBF4
ARGF4
ADDRLP4 8
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
CNSTF4 1094713344
ARGF4
CNSTF4 1101004800
ARGF4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4137
;4136:
;4137:}
LABELV $1839
endproc Item_Slider_Paint 68 20
export Item_Bind_Paint
proc Item_Bind_Paint 96 36
line 4140
;4138:
;4139:void Item_Bind_Paint(itemDef_t *item) 
;4140:{
line 4143
;4141:	vec4_t newColor, lowLight;
;4142:	float value;
;4143:	int maxChars = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 4148
;4144:	float	textScale,textWidth;
;4145:	int		textHeight,yAdj,startingXPos;
;4146:
;4147:
;4148:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4149
;4149:	editFieldDef_t *editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 4150
;4150:	if (editPtr) 
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1851
line 4151
;4151:	{
line 4152
;4152:		maxChars = editPtr->maxPaintChars;
ADDRLP4 28
ADDRLP4 36
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 4153
;4153:	}
LABELV $1851
line 4155
;4154:
;4155:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1854
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 72
INDIRF4
ASGNF4
ADDRGP4 $1855
JUMPV
LABELV $1854
ADDRLP4 68
CNSTF4 0
ASGNF4
LABELV $1855
ADDRLP4 56
ADDRLP4 68
INDIRF4
ASGNF4
line 4157
;4156:
;4157:	if (item->window.flags & WINDOW_HASFOCUS) 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1856
line 4158
;4158:	{
line 4159
;4159:		if (g_bindItem == item) 
ADDRGP4 g_bindItem
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $1858
line 4160
;4160:		{
line 4161
;4161:			lowLight[0] = 0.8f * 1.0f;
ADDRLP4 12
CNSTF4 1061997773
ASGNF4
line 4162
;4162:			lowLight[1] = 0.8f * 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 4163
;4163:			lowLight[2] = 0.8f * 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 4164
;4164:			lowLight[3] = 0.8f * 1.0f;
ADDRLP4 12+12
CNSTF4 1061997773
ASGNF4
line 4165
;4165:		} 
ADDRGP4 $1859
JUMPV
LABELV $1858
line 4167
;4166:		else 
;4167:		{
line 4168
;4168:			lowLight[0] = 0.8f * parent->focusColor[0]; 
ADDRLP4 12
CNSTF4 1061997773
ADDRLP4 32
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 4169
;4169:			lowLight[1] = 0.8f * parent->focusColor[1]; 
ADDRLP4 12+4
CNSTF4 1061997773
ADDRLP4 32
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 4170
;4170:			lowLight[2] = 0.8f * parent->focusColor[2]; 
ADDRLP4 12+8
CNSTF4 1061997773
ADDRLP4 32
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 4171
;4171:			lowLight[3] = 0.8f * parent->focusColor[3]; 
ADDRLP4 12+12
CNSTF4 1061997773
ADDRLP4 32
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 4172
;4172:		}
LABELV $1859
line 4173
;4173:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 76
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 40
ARGP4
CNSTF4 1056964608
ADDRLP4 76
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 4174
;4174:	} 
ADDRGP4 $1857
JUMPV
LABELV $1856
line 4176
;4175:	else 
;4176:	{
line 4177
;4177:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 40
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4178
;4178:	}
LABELV $1857
line 4180
;4179:
;4180:	if (item->text) 
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1866
line 4181
;4181:	{
line 4182
;4182:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 4183
;4183:		BindingFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRGP4 BindingFromName
CALLV
pop
line 4186
;4184:
;4185:		// If the text runs past the limit bring the scale down until it fits.
;4186:		textScale = item->textscale;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 4187
;4187:		textWidth = DC->textWidth(g_nameBind1,(float) textScale, item->iMenuFont);
ADDRGP4 g_nameBind1
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 76
INDIRI4
CVIF4 4
ASGNF4
line 4188
;4188:		startingXPos = (item->textRect.x + item->textRect.w + 8);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 80
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
CVFI4 4
ASGNI4
ADDRGP4 $1869
JUMPV
LABELV $1868
line 4191
;4189:
;4190:		while ((startingXPos + textWidth) >= SCREEN_WIDTH)
;4191:		{
line 4192
;4192:			textScale -= .05f;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1028443341
SUBF4
ASGNF4
line 4193
;4193:			textWidth = DC->textWidth(g_nameBind1,(float) textScale, item->iMenuFont);
ADDRGP4 g_nameBind1
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 84
INDIRI4
CVIF4 4
ASGNF4
line 4194
;4194:		}
LABELV $1869
line 4190
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
ADDF4
CNSTF4 1142947840
GEF4 $1868
line 4197
;4195:
;4196:		// Try to adjust it's y placement if the scale has changed.
;4197:		yAdj = 0;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 4198
;4198:		if (textScale != item->textscale)
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
EQF4 $1871
line 4199
;4199:		{
line 4200
;4200:			textHeight = DC->textHeight(g_nameBind1, item->textscale, item->iMenuFont);
ADDRGP4 g_nameBind1
ARGP4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 84
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 DC
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 64
ADDRLP4 88
INDIRI4
ASGNI4
line 4201
;4201:			yAdj = textHeight - DC->textHeight(g_nameBind1, textScale, item->iMenuFont);
ADDRGP4 g_nameBind1
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 DC
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 64
INDIRI4
ADDRLP4 92
INDIRI4
SUBI4
ASGNI4
line 4202
;4202:		}
LABELV $1871
line 4204
;4203:
;4204:		DC->drawText(startingXPos, item->textRect.y + yAdj, textScale, newColor, g_nameBind1, 0, maxChars, item->textStyle,item->iMenuFont);
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ADDRLP4 60
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 40
ARGP4
ADDRGP4 g_nameBind1
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 84
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4205
;4205:	} 
ADDRGP4 $1867
JUMPV
LABELV $1866
line 4207
;4206:	else 
;4207:	{
line 4208
;4208:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, (value != 0) ? "FIXME" : "FIXME", 0, maxChars, item->textStyle,item->iMenuFont);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 80
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 80
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
ARGP4
ADDRLP4 56
INDIRF4
CNSTF4 0
EQF4 $1875
ADDRLP4 76
ADDRGP4 $1873
ASGNP4
ADDRGP4 $1876
JUMPV
LABELV $1875
ADDRLP4 76
ADDRGP4 $1873
ASGNP4
LABELV $1876
ADDRLP4 76
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4209
;4209:	}
LABELV $1867
line 4210
;4210:}
LABELV $1850
endproc Item_Bind_Paint 96 36
export Display_KeyBindPending
proc Display_KeyBindPending 0 0
line 4212
;4211:
;4212:qboolean Display_KeyBindPending() {
line 4213
;4213:	return g_waitingForKey;
ADDRGP4 g_waitingForKey
INDIRI4
RETI4
LABELV $1877
endproc Display_KeyBindPending 0 0
export Item_Bind_HandleKey
proc Item_Bind_HandleKey 32 12
line 4216
;4214:}
;4215:
;4216:qboolean Item_Bind_HandleKey(itemDef_t *item, int key, qboolean down) {
line 4220
;4217:	int			id;
;4218:	int			i;
;4219:
;4220:	if (key == K_MOUSE1 && Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && !g_waitingForKey)
ADDRFP4 4
INDIRI4
CNSTI4 178
NEI4 $1879
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1879
ADDRGP4 g_waitingForKey
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $1879
line 4221
;4221:	{
line 4222
;4222:		if (down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1881
line 4223
;4223:			g_waitingForKey = qtrue;
ADDRGP4 g_waitingForKey
CNSTI4 1
ASGNI4
line 4224
;4224:			g_bindItem = item;
ADDRGP4 g_bindItem
ADDRFP4 0
INDIRP4
ASGNP4
line 4225
;4225:		}
LABELV $1881
line 4226
;4226:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1878
JUMPV
LABELV $1879
line 4228
;4227:	}
;4228:	else if (key == K_ENTER && !g_waitingForKey)
ADDRFP4 4
INDIRI4
CNSTI4 13
NEI4 $1883
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $1883
line 4229
;4229:	{
line 4230
;4230:		if (down) 
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1885
line 4231
;4231:		{
line 4232
;4232:			g_waitingForKey = qtrue;
ADDRGP4 g_waitingForKey
CNSTI4 1
ASGNI4
line 4233
;4233:			g_bindItem = item;
ADDRGP4 g_bindItem
ADDRFP4 0
INDIRP4
ASGNP4
line 4234
;4234:		}
LABELV $1885
line 4235
;4235:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1878
JUMPV
LABELV $1883
line 4238
;4236:	}
;4237:	else
;4238:	{
line 4239
;4239:		if (!g_waitingForKey || g_bindItem == NULL) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
EQI4 $1889
ADDRGP4 g_bindItem
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1887
LABELV $1889
line 4240
;4240:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1878
JUMPV
LABELV $1887
line 4243
;4241:		}
;4242:
;4243:		if (key & K_CHAR_FLAG) {
ADDRFP4 4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1890
line 4244
;4244:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1878
JUMPV
LABELV $1890
line 4247
;4245:		}
;4246:
;4247:		switch (key)
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 96
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1908
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
GTI4 $1910
LABELV $1909
ADDRFP4 4
INDIRI4
CNSTI4 27
EQI4 $1894
ADDRGP4 $1892
JUMPV
LABELV $1910
ADDRFP4 4
INDIRI4
CNSTI4 127
EQI4 $1895
ADDRGP4 $1892
JUMPV
line 4248
;4248:		{
LABELV $1894
line 4250
;4249:			case K_ESCAPE:
;4250:				g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 4251
;4251:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1878
JUMPV
LABELV $1895
line 4254
;4252:	
;4253:			case K_BACKSPACE:
;4254:				id = BindingIDFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 BindingIDFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
ASGNI4
line 4255
;4255:				if (id != -1) 
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1896
line 4256
;4256:				{
line 4257
;4257:					if ( g_bindings[id].bind1 != -1 )
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1898
line 4258
;4258:					{
line 4259
;4259:						DC->setBinding ( g_bindings[id].bind1, "" );
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $99
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLV
pop
line 4260
;4260:					}
LABELV $1898
line 4262
;4261:					
;4262:					if ( g_bindings[id].bind2 != -1 )
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1902
line 4263
;4263:					{
line 4264
;4264:						DC->setBinding ( g_bindings[id].bind2, "" );
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 $99
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLV
pop
line 4265
;4265:					}
LABELV $1902
line 4267
;4266:								
;4267:					g_bindings[id].bind1 = -1;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 4268
;4268:					g_bindings[id].bind2 = -1;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 4269
;4269:				}
LABELV $1896
line 4270
;4270:				Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 4271
;4271:				g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 4272
;4272:				g_bindItem = NULL;
ADDRGP4 g_bindItem
CNSTP4 0
ASGNP4
line 4273
;4273:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1878
JUMPV
LABELV $1908
line 4276
;4274:
;4275:			case '`':
;4276:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1878
JUMPV
LABELV $1892
line 4278
;4277:		}
;4278:	}
line 4280
;4279:
;4280:	if (key != -1)
ADDRFP4 4
INDIRI4
CNSTI4 -1
EQI4 $1911
line 4281
;4281:	{
line 4283
;4282:
;4283:		for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1916
JUMPV
LABELV $1913
line 4284
;4284:		{
line 4286
;4285:
;4286:			if (g_bindings[i].bind2 == key) {
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1917
line 4287
;4287:				g_bindings[i].bind2 = -1;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 4288
;4288:			}
LABELV $1917
line 4290
;4289:
;4290:			if (g_bindings[i].bind1 == key)
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1921
line 4291
;4291:			{
line 4292
;4292:				g_bindings[i].bind1 = g_bindings[i].bind2;
ADDRLP4 20
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 20
INDIRI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ASGNI4
line 4293
;4293:				g_bindings[i].bind2 = -1;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 4294
;4294:			}
LABELV $1921
line 4295
;4295:		}
LABELV $1914
line 4283
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1916
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1913
line 4296
;4296:	}
LABELV $1911
line 4299
;4297:
;4298:
;4299:	id = BindingIDFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BindingIDFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 4301
;4300:
;4301:	if (id != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1927
line 4302
;4302:		if (key == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 -1
NEI4 $1929
line 4303
;4303:			if( g_bindings[id].bind1 != -1 ) {
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1931
line 4304
;4304:				DC->setBinding( g_bindings[id].bind1, "" );
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $99
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLV
pop
line 4305
;4305:				g_bindings[id].bind1 = -1;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 4306
;4306:			}
LABELV $1931
line 4307
;4307:			if( g_bindings[id].bind2 != -1 ) {
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1930
line 4308
;4308:				DC->setBinding( g_bindings[id].bind2, "" );
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 $99
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLV
pop
line 4309
;4309:				g_bindings[id].bind2 = -1;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 4310
;4310:			}
line 4311
;4311:		}
ADDRGP4 $1930
JUMPV
LABELV $1929
line 4312
;4312:		else if (g_bindings[id].bind1 == -1) {
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1941
line 4313
;4313:			g_bindings[id].bind1 = key;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 4314
;4314:		}
ADDRGP4 $1942
JUMPV
LABELV $1941
line 4315
;4315:		else if (g_bindings[id].bind1 != key && g_bindings[id].bind2 == -1) {
ADDRLP4 24
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $1945
ADDRLP4 24
INDIRI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1945
line 4316
;4316:			g_bindings[id].bind2 = key;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 4317
;4317:		}
ADDRGP4 $1946
JUMPV
LABELV $1945
line 4318
;4318:		else {
line 4319
;4319:			DC->setBinding( g_bindings[id].bind1, "" );
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $99
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLV
pop
line 4320
;4320:			DC->setBinding( g_bindings[id].bind2, "" );
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 $99
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLV
pop
line 4321
;4321:			g_bindings[id].bind1 = key;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 4322
;4322:			g_bindings[id].bind2 = -1;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 4323
;4323:		}						
LABELV $1946
LABELV $1942
LABELV $1930
line 4324
;4324:	}
LABELV $1927
line 4326
;4325:
;4326:	Controls_SetConfig(qtrue);	
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 4327
;4327:	g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 4329
;4328:
;4329:	return qtrue;
CNSTI4 1
RETI4
LABELV $1878
endproc Item_Bind_HandleKey 32 12
export Item_Model_Paint
proc Item_Model_Paint 656 12
line 4333
;4330:}
;4331:
;4332:void Item_Model_Paint(itemDef_t *item) 
;4333:{
line 4339
;4334:	float x, y, w, h;
;4335:	refdef_t refdef;
;4336:	refEntity_t		ent;
;4337:	vec3_t			mins, maxs, origin;
;4338:	vec3_t			angles;
;4339:	modelDef_t *modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 580
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 4341
;4340:
;4341:	if (modelPtr == NULL) 
ADDRLP4 580
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1955
line 4342
;4342:	{
line 4343
;4343:		return;
ADDRGP4 $1954
JUMPV
LABELV $1955
line 4347
;4344:	}
;4345:
;4346:	// setup the refdef
;4347:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4348
;4348:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 4349
;4349:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 4350
;4350:	x = item->window.rect.x+1;
ADDRLP4 640
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4351
;4351:	y = item->window.rect.y+1;
ADDRLP4 644
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4352
;4352:	w = item->window.rect.w-2;
ADDRLP4 632
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 4353
;4353:	h = item->window.rect.h-2;
ADDRLP4 636
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 4355
;4354:
;4355:	refdef.x = x * DC->xscale;
ADDRLP4 0
ADDRLP4 640
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 4356
;4356:	refdef.y = y * DC->yscale;
ADDRLP4 0+4
ADDRLP4 644
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 4357
;4357:	refdef.width = w * DC->xscale;
ADDRLP4 0+8
ADDRLP4 632
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 4358
;4358:	refdef.height = h * DC->yscale;
ADDRLP4 0+12
ADDRLP4 636
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 4360
;4359:
;4360:	DC->modelBounds( item->asset, mins, maxs );
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ARGI4
ADDRLP4 608
ARGP4
ADDRLP4 620
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
CALLV
pop
line 4362
;4361:
;4362:	origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 584+8
CNSTF4 3204448256
ADDRLP4 608+8
INDIRF4
ADDRLP4 620+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 4363
;4363:	origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 584+4
CNSTF4 1056964608
ADDRLP4 608+4
INDIRF4
ADDRLP4 620+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 4366
;4364:
;4365:	// calculate distance so the model nearly fills the box
;4366:	if (qtrue) 
line 4367
;4367:	{
line 4368
;4368:		float len = 0.5 * ( maxs[2] - mins[2] );		
ADDRLP4 648
CNSTF4 1056964608
ADDRLP4 620+8
INDIRF4
ADDRLP4 608+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 4369
;4369:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 584
ADDRLP4 648
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 4371
;4370:		//origin[0] = len / tan(w/2);
;4371:	} 
ADDRGP4 $1969
JUMPV
LABELV $1968
line 4373
;4372:	else 
;4373:	{
line 4374
;4374:		origin[0] = item->textscale;
ADDRLP4 584
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 4375
;4375:	}
LABELV $1969
line 4376
;4376:	refdef.fov_x = (modelPtr->fov_x) ? modelPtr->fov_x : w;
ADDRLP4 580
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1974
ADDRLP4 648
ADDRLP4 580
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1975
JUMPV
LABELV $1974
ADDRLP4 648
ADDRLP4 632
INDIRF4
ASGNF4
LABELV $1975
ADDRLP4 0+16
ADDRLP4 648
INDIRF4
ASGNF4
line 4377
;4377:	refdef.fov_y = (modelPtr->fov_y) ? modelPtr->fov_y : h;
ADDRLP4 580
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1978
ADDRLP4 652
ADDRLP4 580
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1979
JUMPV
LABELV $1978
ADDRLP4 652
ADDRLP4 636
INDIRF4
ASGNF4
LABELV $1979
ADDRLP4 0+20
ADDRLP4 652
INDIRF4
ASGNF4
line 4379
;4378:
;4379:	refdef.fov_x = 45;
ADDRLP4 0+16
CNSTF4 1110704128
ASGNF4
line 4380
;4380:	refdef.fov_y = 45;
ADDRLP4 0+20
CNSTF4 1110704128
ASGNF4
line 4387
;4381:
;4382:	//refdef.fov_x = (int)((float)refdef.width / 640.0f * 90.0f);
;4383:	//xx = refdef.width / tan( refdef.fov_x / 360 * M_PI );
;4384:	//refdef.fov_y = atan2( refdef.height, xx );
;4385:	//refdef.fov_y *= ( 360 / M_PI );
;4386:
;4387:	DC->clearScene();
ADDRGP4 DC
INDIRP4
CNSTI4 52
ADDP4
INDIRP4
CALLV
pop
line 4389
;4388:
;4389:	refdef.time = DC->realTime;
ADDRLP4 0+72
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 4393
;4390:
;4391:	// add the model
;4392:
;4393:	memset( &ent, 0, sizeof(ent) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4410
;4394:
;4395:	//adjust = 5.0 * sin( (float)uis.realtime / 500 );
;4396:	//adjust = 360 % (int)((float)uis.realtime / 1000);
;4397:	//VectorSet( angles, 0, 0, 1 );
;4398:
;4399:	// use item storage to track
;4400:/*	if (modelPtr->rotationSpeed) 
;4401:	{
;4402:		if (DC->realTime > item->window.nextTime) 
;4403:		{
;4404:			item->window.nextTime = DC->realTime + modelPtr->rotationSpeed;
;4405:			modelPtr->angle = (int)(modelPtr->angle + 1) % 360;
;4406:		}
;4407:	}
;4408:	VectorSet( angles, 0, modelPtr->angle, 0 );
;4409:*/
;4410:	VectorSet( angles, 0, (float)(refdef.time/20.0f), 0);
ADDRLP4 596
CNSTF4 0
ASGNF4
ADDRLP4 596+4
ADDRLP4 0+72
INDIRI4
CVIF4 4
CNSTF4 1101004800
DIVF4
ASGNF4
ADDRLP4 596+8
CNSTF4 0
ASGNF4
line 4412
;4411:
;4412:	AnglesToAxis( angles, ent.axis );
ADDRLP4 596
ARGP4
ADDRLP4 368+12
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 4414
;4413:
;4414:	ent.hModel = item->asset;
ADDRLP4 368+8
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ASGNI4
line 4415
;4415:	VectorCopy( origin, ent.origin );
ADDRLP4 368+52
ADDRLP4 584
INDIRB
ASGNB 12
line 4416
;4416:	VectorCopy( origin, ent.lightingOrigin );
ADDRLP4 368+108
ADDRLP4 584
INDIRB
ASGNB 12
line 4417
;4417:	ent.renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
ADDRLP4 368+4
CNSTI4 192
ASGNI4
line 4418
;4418:	VectorCopy( ent.origin, ent.oldorigin );
ADDRLP4 368+64
ADDRLP4 368+52
INDIRB
ASGNB 12
line 4420
;4419:
;4420:	DC->addRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
CALLV
pop
line 4421
;4421:	DC->renderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CALLV
pop
line 4423
;4422:
;4423:}
LABELV $1954
endproc Item_Model_Paint 656 12
export Item_Image_Paint
proc Item_Image_Paint 16 20
line 4426
;4424:
;4425:
;4426:void Item_Image_Paint(itemDef_t *item) {
line 4427
;4427:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1994
line 4428
;4428:		return;
ADDRGP4 $1993
JUMPV
LABELV $1994
line 4430
;4429:	}
;4430:	DC->drawHandlePic(item->window.rect.x+1, item->window.rect.y+1, item->window.rect.w-2, item->window.rect.h-2, item->asset);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ARGF4
ADDRLP4 8
CNSTI4 8
ASGNI4
ADDRLP4 12
CNSTF4 1073741824
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRP4
CALLV
pop
line 4431
;4431:}
LABELV $1993
endproc Item_Image_Paint 16 20
export Item_TextScroll_Paint
proc Item_TextScroll_Paint 80 36
line 4434
;4432:
;4433:void Item_TextScroll_Paint(itemDef_t *item) 
;4434:{
line 4437
;4435:	float x, y, size, count, thumb;
;4436:	int	  i;
;4437:	textScrollDef_t *scrollPtr = (textScrollDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 4439
;4438:
;4439:	count = scrollPtr->lineCount;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 4442
;4440:
;4441:	// draw scrollbar to right side of the window
;4442:	x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 4443
;4443:	y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4444
;4444:	DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowUp);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 32
CNSTF4 1098907648
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4445
;4445:	y += SCROLLBAR_SIZE - 1;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 4447
;4446:
;4447:	scrollPtr->endPos = scrollPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 4448
;4448:	size = item->window.rect.h - (SCROLLBAR_SIZE * 2);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 4449
;4449:	DC->drawHandlePic(x, y, SCROLLBAR_SIZE, size+1, DC->Assets.scrollBar);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4450
;4450:	y += size - 1;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 4451
;4451:	DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowDown);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 48
CNSTF4 1098907648
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4454
;4452:	
;4453:	// thumb
;4454:	thumb = Item_TextScroll_ThumbDrawPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 Item_TextScroll_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 56
INDIRI4
CVIF4 4
ASGNF4
line 4455
;4455:	if (thumb > y - SCROLLBAR_SIZE - 1) 
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $1997
line 4456
;4456:	{
line 4457
;4457:		thumb = y - SCROLLBAR_SIZE - 1;
ADDRLP4 24
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 4458
;4458:	}
LABELV $1997
line 4459
;4459:	DC->drawHandlePic(x, thumb, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
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
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4462
;4460:
;4461:	// adjust size for item painting
;4462:	size = item->window.rect.h - 2;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 4463
;4463:	x	 = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4464
;4464:	y	 = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4466
;4465:
;4466:	for (i = scrollPtr->startPos; i < count; i++) 
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRGP4 $2002
JUMPV
LABELV $1999
line 4467
;4467:	{
line 4470
;4468:		char *text;
;4469:
;4470:		text = scrollPtr->lines[i];
ADDRLP4 68
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDP4
INDIRP4
ASGNP4
line 4471
;4471:		if (!text) 
ADDRLP4 68
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2003
line 4472
;4472:		{
line 4473
;4473:			continue;
ADDRGP4 $2000
JUMPV
LABELV $2003
line 4476
;4474:		}
;4475:
;4476:		DC->drawText(x + 4, y, item->textscale, item->window.foreColor, text, 0, 0, item->textStyle, item->iMenuFont);
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4478
;4477:
;4478:		size -= scrollPtr->lineHeight;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4479
;4479:		if (size < scrollPtr->lineHeight) 
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GEF4 $2005
line 4480
;4480:		{
line 4481
;4481:			scrollPtr->drawPadding = scrollPtr->lineHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 4482
;4482:			break;
ADDRGP4 $2001
JUMPV
LABELV $2005
line 4485
;4483:		}
;4484:
;4485:		scrollPtr->endPos++;
ADDRLP4 76
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4486
;4486:		y += scrollPtr->lineHeight;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4487
;4487:	}
LABELV $2000
line 4466
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2002
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRF4
LTF4 $1999
LABELV $2001
line 4488
;4488:}
LABELV $1996
endproc Item_TextScroll_Paint 80 36
export Item_ListBox_Paint
proc Item_ListBox_Paint 104 36
line 4490
;4489:
;4490:void Item_ListBox_Paint(itemDef_t *item) {
line 4494
;4491:	float x, y, size, count, i, thumb;
;4492:	qhandle_t image;
;4493:	qhandle_t optionalImage;
;4494:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 4500
;4495:
;4496:	// the listbox is horizontal or vertical and has a fixed size scroll bar going either direction
;4497:	// elements are enumerated from the DC and either text or image handles are acquired from the DC as well
;4498:	// textscale is used to size the text, textalignx and textaligny are used to size image elements
;4499:	// there is no clipping available so only the last completely visible item is painted
;4500:	count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 36
INDIRI4
CVIF4 4
ASGNF4
line 4502
;4501:	// default is vertical if horizontal flag is not here
;4502:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2008
line 4507
;4503:		const char *text;
;4504:
;4505:		// draw scrollbar in bottom of the window
;4506:		// bar
;4507:		x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4508
;4508:		y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE - 1;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 4509
;4509:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowLeft);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 48
CNSTF4 1098907648
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4510
;4510:		x += SCROLLBAR_SIZE - 1;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 4511
;4511:		size = item->window.rect.w - (SCROLLBAR_SIZE * 2);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 4512
;4512:		DC->drawHandlePic(x, y, size+1, SCROLLBAR_SIZE, DC->Assets.scrollBar);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4513
;4513:		x += size - 1;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 4514
;4514:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowRight);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
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
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4516
;4515:		// thumb
;4516:		thumb = Item_ListBox_ThumbDrawPosition(item);//Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 Item_ListBox_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 68
INDIRI4
CVIF4 4
ASGNF4
line 4517
;4517:		if (thumb > x - SCROLLBAR_SIZE - 1) {
ADDRLP4 32
INDIRF4
ADDRLP4 16
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $2010
line 4518
;4518:			thumb = x - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 16
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 4519
;4519:		}
LABELV $2010
line 4520
;4520:		DC->drawHandlePic(thumb, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb);
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 72
CNSTF4 1098907648
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 76
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4522
;4521:		//
;4522:		listPtr->endPos = listPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 4523
;4523:		size = item->window.rect.w - 2;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 4526
;4524:		// items
;4525:		// size contains max available space
;4526:		if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2012
line 4528
;4527:			// fit = 0;
;4528:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4529
;4529:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4530
;4530:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $2017
JUMPV
LABELV $2014
line 4533
;4531:				// always draw at least one
;4532:				// which may overdraw the box if it is too small for the element
;4533:				image = DC->feederItemImage(item->special, i);
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 84
ADDRGP4 DC
INDIRP4
CNSTI4 152
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 84
INDIRI4
ASGNI4
line 4534
;4534:				if (image) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2018
line 4535
;4535:					DC->drawHandlePic(x+1, y+1, listPtr->elementWidth - 2, listPtr->elementHeight - 2, image);
ADDRLP4 88
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 88
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 88
INDIRF4
ADDF4
ARGF4
ADDRLP4 96
CNSTF4 1073741824
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4536
;4536:				}
LABELV $2018
line 4538
;4537:
;4538:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CVIF4 4
NEF4 $2020
line 4539
;4539:					DC->drawRect(x, y, listPtr->elementWidth-1, listPtr->elementHeight-1, item->window.borderSize, item->window.borderColor);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 92
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
SUBF4
ARGF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 96
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 4540
;4540:				}
LABELV $2020
line 4542
;4541:
;4542:				size -= listPtr->elementWidth;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4543
;4543:				if (size < listPtr->elementWidth) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
GEF4 $2022
line 4544
;4544:					listPtr->drawPadding = size; //listPtr->elementWidth - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 4545
;4545:					break;
ADDRGP4 $2013
JUMPV
LABELV $2022
line 4547
;4546:				}
;4547:				x += listPtr->elementWidth;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4548
;4548:				listPtr->endPos++;
ADDRLP4 88
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4550
;4549:				// fit++;
;4550:			}
LABELV $2015
line 4530
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $2017
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $2014
line 4551
;4551:		} else {
LABELV $2012
line 4553
;4552:			//
;4553:		}
LABELV $2013
line 4555
;4554:
;4555:		text = DC->feederItemText(item->special, item->cursorPos, 0, &optionalImage);
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 84
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 88
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 88
INDIRP4
ASGNP4
line 4556
;4556:		if (text) 
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2009
line 4557
;4557:		{
line 4558
;4558:			DC->drawText(item->window.rect.x, item->window.rect.y+item->window.rect.h, item->textscale, item->window.foreColor, text, 0, 0, item->textStyle, item->iMenuFont);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
INDIRF4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 92
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 92
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4559
;4559:		}
line 4560
;4560:	} else {
ADDRGP4 $2009
JUMPV
LABELV $2008
line 4562
;4561:		// draw scrollbar to right side of the window
;4562:		x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 4563
;4563:		y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4564
;4564:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowUp);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 44
CNSTF4 1098907648
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4565
;4565:		y += SCROLLBAR_SIZE - 1;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 4567
;4566:
;4567:		listPtr->endPos = listPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 4568
;4568:		size = item->window.rect.h - (SCROLLBAR_SIZE * 2);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 4569
;4569:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, size+1, DC->Assets.scrollBar);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4570
;4570:		y += size - 1;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 4571
;4571:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowDown);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
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
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4573
;4572:		// thumb
;4573:		thumb = Item_ListBox_ThumbDrawPosition(item);//Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 Item_ListBox_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 68
INDIRI4
CVIF4 4
ASGNF4
line 4574
;4574:		if (thumb > y - SCROLLBAR_SIZE - 1) {
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $2026
line 4575
;4575:			thumb = y - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 4576
;4576:		}
LABELV $2026
line 4577
;4577:		DC->drawHandlePic(x, thumb, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 72
CNSTF4 1098907648
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 76
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4580
;4578:
;4579:		// adjust size for item painting
;4580:		size = item->window.rect.h - 2;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 4581
;4581:		if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2028
line 4583
;4582:			// fit = 0;
;4583:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4584
;4584:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4585
;4585:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $2033
JUMPV
LABELV $2030
line 4588
;4586:				// always draw at least one
;4587:				// which may overdraw the box if it is too small for the element
;4588:				image = DC->feederItemImage(item->special, i);
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 80
ADDRGP4 DC
INDIRP4
CNSTI4 152
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 80
INDIRI4
ASGNI4
line 4589
;4589:				if (image) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2034
line 4590
;4590:					DC->drawHandlePic(x+1, y+1, listPtr->elementWidth - 2, listPtr->elementHeight - 2, image);
ADDRLP4 84
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 92
CNSTF4 1073741824
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4591
;4591:				}
LABELV $2034
line 4593
;4592:
;4593:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CVIF4 4
NEF4 $2036
line 4594
;4594:					DC->drawRect(x, y, listPtr->elementWidth - 1, listPtr->elementHeight - 1, item->window.borderSize, item->window.borderColor);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 88
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
SUBF4
ARGF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 4595
;4595:				}
LABELV $2036
line 4597
;4596:
;4597:				listPtr->endPos++;
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4598
;4598:				size -= listPtr->elementWidth;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4599
;4599:				if (size < listPtr->elementHeight) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GEF4 $2038
line 4600
;4600:					listPtr->drawPadding = listPtr->elementHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 4601
;4601:					break;
ADDRGP4 $2029
JUMPV
LABELV $2038
line 4603
;4602:				}
;4603:				y += listPtr->elementHeight;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4605
;4604:				// fit++;
;4605:			}
LABELV $2031
line 4585
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $2033
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $2030
line 4606
;4606:		} else {
ADDRGP4 $2029
JUMPV
LABELV $2028
line 4607
;4607:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4608
;4608:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4609
;4609:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $2043
JUMPV
LABELV $2040
line 4614
;4610:				const char *text;
;4611:				// always draw at least one
;4612:				// which may overdraw the box if it is too small for the element
;4613:
;4614:				if (listPtr->numColumns > 0) {
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2044
line 4617
;4615:					int j;
;4616:
;4617:					for (j = 0; j < listPtr->numColumns; j++) {
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRGP4 $2049
JUMPV
LABELV $2046
line 4618
;4618:						text = DC->feederItemText(item->special, i, j, &optionalImage);
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 88
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 88
INDIRP4
ASGNP4
line 4619
;4619:						if (optionalImage >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $2050
line 4620
;4620:							DC->drawHandlePic(x + 4 + listPtr->columnInfo[j].pos, y - 1 + listPtr->elementHeight / 2, listPtr->columnInfo[j].width, listPtr->columnInfo[j].width, optionalImage);
ADDRLP4 96
CNSTI4 12
ADDRLP4 84
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 96
INDIRP4
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
SUBF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1073741824
DIVF4
ADDF4
ARGF4
ADDRLP4 100
ADDRLP4 96
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 100
INDIRF4
ARGF4
ADDRLP4 100
INDIRF4
ARGF4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4621
;4621:						} 
ADDRGP4 $2051
JUMPV
LABELV $2050
line 4622
;4622:						else if (text) 
ADDRLP4 80
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2052
line 4623
;4623:						{
line 4625
;4624://							DC->drawText(x + 4 + listPtr->columnInfo[j].pos, y + listPtr->elementHeight, item->textscale, item->window.foreColor, text, 0, listPtr->columnInfo[j].maxChars, item->textStyle);
;4625:							DC->drawText(x + 4 + listPtr->columnInfo[j].pos, y, item->textscale, item->window.foreColor, text, 0, listPtr->columnInfo[j].maxChars, item->textStyle, item->iMenuFont);
ADDRLP4 92
CNSTI4 12
ADDRLP4 84
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 92
INDIRP4
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 96
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 92
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4626
;4626:						}
LABELV $2052
LABELV $2051
line 4627
;4627:					}
LABELV $2047
line 4617
ADDRLP4 84
ADDRLP4 84
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2049
ADDRLP4 84
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
LTI4 $2046
line 4628
;4628:				} 
ADDRGP4 $2045
JUMPV
LABELV $2044
line 4630
;4629:				else 
;4630:				{
line 4631
;4631:					text = DC->feederItemText(item->special, i, 0, &optionalImage);
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 84
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 84
INDIRP4
ASGNP4
line 4632
;4632:					if (optionalImage >= 0) 
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $2054
line 4633
;4633:					{
line 4635
;4634:						//DC->drawHandlePic(x + 4 + listPtr->elementHeight, y, listPtr->columnInfo[j].width, listPtr->columnInfo[j].width, optionalImage);
;4635:					} 
ADDRGP4 $2055
JUMPV
LABELV $2054
line 4636
;4636:					else if (text) 
ADDRLP4 80
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2056
line 4637
;4637:					{
line 4639
;4638://						DC->drawText(x + 4, y + listPtr->elementHeight, item->textscale, item->window.foreColor, text, 0, 0, item->textStyle);
;4639:						DC->drawText(x + 4, y, item->textscale, item->window.foreColor, text, 0, 0, item->textStyle, item->iMenuFont);
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4640
;4640:					}
LABELV $2056
LABELV $2055
line 4641
;4641:				}
LABELV $2045
line 4643
;4642:
;4643:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CVIF4 4
NEF4 $2058
line 4644
;4644:					DC->fillRect(x + 2, y + 2, item->window.rect.w - SCROLLBAR_SIZE - 4, listPtr->elementHeight, item->window.outlineColor);
ADDRLP4 84
CNSTF4 1073741824
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 4645
;4645:				}
LABELV $2058
line 4647
;4646:
;4647:				size -= listPtr->elementHeight;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4648
;4648:				if (size < listPtr->elementHeight) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GEF4 $2060
line 4649
;4649:					listPtr->drawPadding = listPtr->elementHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 4650
;4650:					break;
ADDRGP4 $2042
JUMPV
LABELV $2060
line 4652
;4651:				}
;4652:				listPtr->endPos++;
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4653
;4653:				y += listPtr->elementHeight;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4655
;4654:				// fit++;
;4655:			}
LABELV $2041
line 4609
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $2043
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $2040
LABELV $2042
line 4656
;4656:		}
LABELV $2029
line 4657
;4657:	}
LABELV $2009
line 4658
;4658:}
LABELV $2007
endproc Item_ListBox_Paint 104 36
export Item_OwnerDraw_Paint
proc Item_OwnerDraw_Paint 68 60
line 4661
;4659:
;4660:
;4661:void Item_OwnerDraw_Paint(itemDef_t *item) {
line 4664
;4662:  menuDef_t *parent;
;4663:
;4664:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2063
line 4665
;4665:		return;
ADDRGP4 $2062
JUMPV
LABELV $2063
line 4667
;4666:	}
;4667:  parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4669
;4668:
;4669:	if (DC->ownerDrawItem) {
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2065
line 4671
;4670:		vec4_t color, lowLight;
;4671:		menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4672
;4672:		Fade(&item->window.flags, &item->window.foreColor[3], parent->fadeClamp, &item->window.nextTime, parent->fadeCycle, qtrue, parent->fadeAmount);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 4673
;4673:		memcpy(&color, &item->window.foreColor, sizeof(color));
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4674
;4674:		if (item->numColors > 0 && DC->getValue) {
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2067
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2067
line 4677
;4675:			// if the value is within one of the ranges then set color to that, otherwise leave at default
;4676:			int i;
;4677:			float f = DC->getValue(item->window.ownerDraw);
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 56
INDIRF4
ASGNF4
line 4678
;4678:			for (i = 0; i < item->numColors; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRGP4 $2072
JUMPV
LABELV $2069
line 4679
;4679:				if (f >= item->colorRanges[i].low && f <= item->colorRanges[i].high) {
ADDRLP4 64
CNSTI4 24
ADDRLP4 48
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
ADDP4
ASGNP4
ADDRLP4 52
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
LTF4 $2073
ADDRLP4 52
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GTF4 $2073
line 4680
;4680:					memcpy(&color, &item->colorRanges[i].color, sizeof(color));
ADDRLP4 4
ARGP4
CNSTI4 24
ADDRLP4 48
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4681
;4681:					break;
ADDRGP4 $2071
JUMPV
LABELV $2073
line 4683
;4682:				}
;4683:			}
LABELV $2070
line 4678
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2072
ADDRLP4 48
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
LTI4 $2069
LABELV $2071
line 4684
;4684:		}
LABELV $2067
line 4686
;4685:
;4686:		if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2075
line 4687
;4687:			lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 24
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
MULF4
ASGNF4
line 4688
;4688:			lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 24+4
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
MULF4
ASGNF4
line 4689
;4689:			lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 24+8
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
MULF4
ASGNF4
line 4690
;4690:			lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 24+12
CNSTF4 1061997773
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
MULF4
ASGNF4
line 4691
;4691:			LerpColor(parent->focusColor,lowLight,color,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 1056964608
ADDRLP4 48
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 4692
;4692:		} else if (item->textStyle == ITEM_TEXTSTYLE_BLINK && !((DC->realTime/BLINK_DIVISOR) & 1)) {
ADDRGP4 $2076
JUMPV
LABELV $2075
ADDRLP4 48
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $2080
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 200
DIVI4
ADDRLP4 48
INDIRI4
BANDI4
CNSTI4 0
NEI4 $2080
line 4693
;4693:			lowLight[0] = 0.8 * item->window.foreColor[0]; 
ADDRLP4 24
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
MULF4
ASGNF4
line 4694
;4694:			lowLight[1] = 0.8 * item->window.foreColor[1]; 
ADDRLP4 24+4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
MULF4
ASGNF4
line 4695
;4695:			lowLight[2] = 0.8 * item->window.foreColor[2]; 
ADDRLP4 24+8
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
line 4696
;4696:			lowLight[3] = 0.8 * item->window.foreColor[3]; 
ADDRLP4 24+12
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
MULF4
ASGNF4
line 4697
;4697:			LerpColor(item->window.foreColor,lowLight,color,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 52
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 1056964608
ADDRLP4 52
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 4698
;4698:		}
LABELV $2080
LABELV $2076
line 4700
;4699:
;4700:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $2085
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $2085
line 4701
;4701:		  memcpy(color, parent->disableColor, sizeof(vec4_t)); // bk001207 - FIXME: Com_Memcpy
ADDRLP4 4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4702
;4702:		}
LABELV $2085
line 4704
;4703:	
;4704:		if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2087
line 4705
;4705:			Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 4706
;4706:				if (item->text[0]) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2089
line 4708
;4707:					// +8 is an offset kludge to properly align owner draw items that have text combined with them
;4708:					DC->ownerDrawItem(item->textRect.x + item->textRect.w + 8, item->window.rect.y, item->window.rect.w, item->window.rect.h, 0, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle,item->iMenuFont);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 4709
;4709:				} else {
ADDRGP4 $2088
JUMPV
LABELV $2089
line 4710
;4710:					DC->ownerDrawItem(item->textRect.x + item->textRect.w, item->window.rect.y, item->window.rect.w, item->window.rect.h, 0, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle,item->iMenuFont);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 4711
;4711:				}
line 4712
;4712:			} else {
ADDRGP4 $2088
JUMPV
LABELV $2087
line 4713
;4713:			DC->ownerDrawItem(item->window.rect.x, item->window.rect.y, item->window.rect.w, item->window.rect.h, item->textalignx, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle,item->iMenuFont);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 4714
;4714:		}
LABELV $2088
line 4715
;4715:	}
LABELV $2065
line 4716
;4716:}
LABELV $2062
endproc Item_OwnerDraw_Paint 68 60
lit
align 4
LABELV $2092
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export Item_Paint
code
proc Item_Paint 108 36
line 4720
;4717:
;4718:
;4719:void Item_Paint(itemDef_t *item) 
;4720:{
line 4722
;4721:	vec4_t		red;
;4722:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4724
;4723:	int			xPos,textWidth;
;4724:	vec4_t		color = {1, 1, 1, 1};
ADDRLP4 28
ADDRGP4 $2092
INDIRB
ASGNB 16
line 4726
;4725:
;4726:	red[0] = red[3] = 1;
ADDRLP4 44
CNSTF4 1065353216
ASGNF4
ADDRLP4 4+12
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 44
INDIRF4
ASGNF4
line 4727
;4727:	red[1] = red[2] = 0;
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 4+8
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 48
INDIRF4
ASGNF4
line 4729
;4728:
;4729:	if (item == NULL) 
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2096
line 4730
;4730:	{
line 4731
;4731:		return;
ADDRGP4 $2091
JUMPV
LABELV $2096
line 4734
;4732:	}
;4733:
;4734:	if (item->window.flags & WINDOW_ORBITING) 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $2098
line 4735
;4735:	{
line 4736
;4736:		if (DC->realTime > item->window.nextTime) 
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $2100
line 4737
;4737:		{
line 4740
;4738:			float rx, ry, a, c, s, w, h;
;4739:      
;4740:			item->window.nextTime = DC->realTime + item->window.offsetTime;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 80
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDI4
ASGNI4
line 4742
;4741:			// translate
;4742:			w = item->window.rectClient.w / 2;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4743
;4743:			h = item->window.rectClient.h / 2;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4744
;4744:			rx = item->window.rectClient.x + w - item->window.rectEffects.x;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 84
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ADDRLP4 84
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4745
;4745:			ry = item->window.rectClient.y + h - item->window.rectEffects.y;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 88
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
ADDRLP4 88
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4746
;4746:			a = 3 * M_PI / 180;
ADDRLP4 60
CNSTF4 1029076816
ASGNF4
line 4747
;4747:			c = cos(a);
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 92
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 64
ADDRLP4 92
INDIRF4
ASGNF4
line 4748
;4748:			s = sin(a);
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 96
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 96
INDIRF4
ASGNF4
line 4749
;4749:			item->window.rectClient.x = (rx * c - ry * s) + item->window.rectEffects.x - w;
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 52
INDIRF4
ADDRLP4 64
INDIRF4
MULF4
ADDRLP4 56
INDIRF4
ADDRLP4 68
INDIRF4
MULF4
SUBF4
ADDRLP4 100
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDF4
ADDRLP4 72
INDIRF4
SUBF4
ASGNF4
line 4750
;4750:			item->window.rectClient.y = (rx * s + ry * c) + item->window.rectEffects.y - h;
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 52
INDIRF4
ADDRLP4 68
INDIRF4
MULF4
ADDRLP4 56
INDIRF4
ADDRLP4 64
INDIRF4
MULF4
ADDF4
ADDRLP4 104
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDF4
ADDRLP4 76
INDIRF4
SUBF4
ASGNF4
line 4751
;4751:			Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 4752
;4752:		}
LABELV $2100
line 4753
;4753:	}
LABELV $2098
line 4756
;4754:
;4755:
;4756:  if (item->window.flags & WINDOW_INTRANSITION) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $2102
line 4757
;4757:    if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $2104
line 4758
;4758:      int done = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
line 4759
;4759:      item->window.nextTime = DC->realTime + item->window.offsetTime;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ADDRLP4 56
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDI4
ASGNI4
line 4761
;4760:			// transition the x,y
;4761:			if (item->window.rectClient.x == item->window.rectEffects.x) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEF4 $2106
line 4762
;4762:				done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4763
;4763:			} else {
ADDRGP4 $2107
JUMPV
LABELV $2106
line 4764
;4764:				if (item->window.rectClient.x < item->window.rectEffects.x) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
GEF4 $2108
line 4765
;4765:					item->window.rectClient.x += item->window.rectEffects2.x;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4766
;4766:					if (item->window.rectClient.x > item->window.rectEffects.x) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
LEF4 $2109
line 4767
;4767:						item->window.rectClient.x = item->window.rectEffects.x;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
line 4768
;4768:						done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4769
;4769:					}
line 4770
;4770:				} else {
ADDRGP4 $2109
JUMPV
LABELV $2108
line 4771
;4771:					item->window.rectClient.x -= item->window.rectEffects2.x;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4772
;4772:					if (item->window.rectClient.x < item->window.rectEffects.x) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
GEF4 $2112
line 4773
;4773:						item->window.rectClient.x = item->window.rectEffects.x;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
line 4774
;4774:						done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4775
;4775:					}
LABELV $2112
line 4776
;4776:				}
LABELV $2109
line 4777
;4777:			}
LABELV $2107
line 4778
;4778:			if (item->window.rectClient.y == item->window.rectEffects.y) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEF4 $2114
line 4779
;4779:				done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4780
;4780:			} else {
ADDRGP4 $2115
JUMPV
LABELV $2114
line 4781
;4781:				if (item->window.rectClient.y < item->window.rectEffects.y) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
GEF4 $2116
line 4782
;4782:					item->window.rectClient.y += item->window.rectEffects2.y;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4783
;4783:					if (item->window.rectClient.y > item->window.rectEffects.y) {
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
LEF4 $2117
line 4784
;4784:						item->window.rectClient.y = item->window.rectEffects.y;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 4785
;4785:						done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4786
;4786:					}
line 4787
;4787:				} else {
ADDRGP4 $2117
JUMPV
LABELV $2116
line 4788
;4788:					item->window.rectClient.y -= item->window.rectEffects2.y;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4789
;4789:					if (item->window.rectClient.y < item->window.rectEffects.y) {
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
GEF4 $2120
line 4790
;4790:						item->window.rectClient.y = item->window.rectEffects.y;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 4791
;4791:						done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4792
;4792:					}
LABELV $2120
line 4793
;4793:				}
LABELV $2117
line 4794
;4794:			}
LABELV $2115
line 4795
;4795:			if (item->window.rectClient.w == item->window.rectEffects.w) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
NEF4 $2122
line 4796
;4796:				done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4797
;4797:			} else {
ADDRGP4 $2123
JUMPV
LABELV $2122
line 4798
;4798:				if (item->window.rectClient.w < item->window.rectEffects.w) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
GEF4 $2124
line 4799
;4799:					item->window.rectClient.w += item->window.rectEffects2.w;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 76
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4800
;4800:					if (item->window.rectClient.w > item->window.rectEffects.w) {
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
LEF4 $2125
line 4801
;4801:						item->window.rectClient.w = item->window.rectEffects.w;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 4802
;4802:						done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4803
;4803:					}
line 4804
;4804:				} else {
ADDRGP4 $2125
JUMPV
LABELV $2124
line 4805
;4805:					item->window.rectClient.w -= item->window.rectEffects2.w;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 76
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4806
;4806:					if (item->window.rectClient.w < item->window.rectEffects.w) {
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
GEF4 $2128
line 4807
;4807:						item->window.rectClient.w = item->window.rectEffects.w;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 4808
;4808:						done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4809
;4809:					}
LABELV $2128
line 4810
;4810:				}
LABELV $2125
line 4811
;4811:			}
LABELV $2123
line 4812
;4812:			if (item->window.rectClient.h == item->window.rectEffects.h) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
NEF4 $2130
line 4813
;4813:				done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4814
;4814:			} else {
ADDRGP4 $2131
JUMPV
LABELV $2130
line 4815
;4815:				if (item->window.rectClient.h < item->window.rectEffects.h) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
GEF4 $2132
line 4816
;4816:					item->window.rectClient.h += item->window.rectEffects2.h;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4817
;4817:					if (item->window.rectClient.h > item->window.rectEffects.h) {
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
LEF4 $2133
line 4818
;4818:						item->window.rectClient.h = item->window.rectEffects.h;
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 4819
;4819:						done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4820
;4820:					}
line 4821
;4821:				} else {
ADDRGP4 $2133
JUMPV
LABELV $2132
line 4822
;4822:					item->window.rectClient.h -= item->window.rectEffects2.h;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4823
;4823:					if (item->window.rectClient.h < item->window.rectEffects.h) {
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
GEF4 $2136
line 4824
;4824:						item->window.rectClient.h = item->window.rectEffects.h;
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 4825
;4825:						done++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4826
;4826:					}
LABELV $2136
line 4827
;4827:				}
LABELV $2133
line 4828
;4828:			}
LABELV $2131
line 4830
;4829:
;4830:      Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 4832
;4831:
;4832:      if (done == 4) {
ADDRLP4 52
INDIRI4
CNSTI4 4
NEI4 $2138
line 4833
;4833:        item->window.flags &= ~WINDOW_INTRANSITION;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 4834
;4834:      }
LABELV $2138
line 4836
;4835:
;4836:    }
LABELV $2104
line 4837
;4837:  }
LABELV $2102
line 4839
;4838:
;4839:	if (item->window.ownerDrawFlags && DC->ownerDrawVisible) {
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2140
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2140
line 4840
;4840:		if (!DC->ownerDrawVisible(item->window.ownerDrawFlags)) {
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $2142
line 4841
;4841:			item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 4842
;4842:		} else {
ADDRGP4 $2143
JUMPV
LABELV $2142
line 4843
;4843:			item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 4844
;4844:		}
LABELV $2143
line 4845
;4845:	}
LABELV $2140
line 4847
;4846:
;4847:	if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE)) {
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $2144
line 4848
;4848:		if (!Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 52
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $2146
line 4849
;4849:			return;
ADDRGP4 $2091
JUMPV
LABELV $2146
line 4851
;4850:		}
;4851:	}
LABELV $2144
line 4853
;4852:
;4853:  if (item->window.flags & WINDOW_TIMEDVISIBLE) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $2148
line 4855
;4854:
;4855:	}
LABELV $2148
line 4857
;4856:
;4857:	if (!(item->window.flags & WINDOW_VISIBLE)) 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $2150
line 4858
;4858:	{
line 4859
;4859:		return;
ADDRGP4 $2091
JUMPV
LABELV $2150
line 4862
;4860:	}
;4861:
;4862:	if ((item->window.flags & WINDOW_MOUSEOVER))
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2152
line 4863
;4863:	{
line 4864
;4864:		if (item->descText && !Display_KeyBindPending())
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2154
ADDRLP4 52
ADDRGP4 Display_KeyBindPending
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $2154
line 4865
;4865:		{
line 4867
;4866:			// Make DOUBLY sure that this item should have desctext.
;4867:		    if (!Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $2156
line 4868
;4868:			{	// It isn't something that should, because it isn't live anymore.
line 4869
;4869:				item->window.flags &= ~WINDOW_MOUSEOVER;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 4870
;4870:			}
ADDRGP4 $2157
JUMPV
LABELV $2156
line 4872
;4871:			else
;4872:			{	// Draw the desctext
line 4873
;4873:				const char *textPtr = item->descText;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRP4
ASGNP4
line 4875
;4874:
;4875:				Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 4877
;4876:
;4877:				{// stupid C language
line 4878
;4878:					float fDescScale = parent->descScale ? parent->descScale : 1;
ADDRLP4 0
INDIRP4
CNSTI4 1312
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2159
ADDRLP4 80
ADDRLP4 0
INDIRP4
CNSTI4 1312
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $2160
JUMPV
LABELV $2159
ADDRLP4 80
CNSTF4 1065353216
ASGNF4
LABELV $2160
ADDRLP4 68
ADDRLP4 80
INDIRF4
ASGNF4
line 4879
;4879:					float fDescScaleCopy = fDescScale;
ADDRLP4 72
ADDRLP4 68
INDIRF4
ASGNF4
line 4880
;4880:					int iYadj = 0;
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRGP4 $2162
JUMPV
LABELV $2161
line 4882
;4881:					while (1)
;4882:					{
line 4883
;4883:						textWidth = DC->textWidth(textPtr,fDescScale, FONT_MEDIUM);
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 84
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 84
INDIRI4
ASGNI4
line 4885
;4884:
;4885:						if (parent->descAlignment == ITEM_ALIGN_RIGHT)
ADDRLP4 0
INDIRP4
CNSTI4 1308
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2164
line 4886
;4886:						{
line 4887
;4887:							xPos = parent->descX - textWidth;	// Right justify
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 1284
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 4888
;4888:						}
ADDRGP4 $2165
JUMPV
LABELV $2164
line 4889
;4889:						else if (parent->descAlignment == ITEM_ALIGN_CENTER)
ADDRLP4 0
INDIRP4
CNSTI4 1308
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2166
line 4890
;4890:						{
line 4891
;4891:							xPos = parent->descX - (textWidth/2);	// Center justify
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 1284
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 4892
;4892:						}
ADDRGP4 $2167
JUMPV
LABELV $2166
line 4894
;4893:						else										// Left justify	
;4894:						{
line 4895
;4895:							xPos = parent->descX;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 1284
ADDP4
INDIRI4
ASGNI4
line 4896
;4896:						}
LABELV $2167
LABELV $2165
line 4898
;4897:
;4898:						if (parent->descAlignment == ITEM_ALIGN_CENTER)
ADDRLP4 0
INDIRP4
CNSTI4 1308
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2168
line 4899
;4899:						{
line 4902
;4900:							// only this one will auto-shrink the scale until we eventually fit...
;4901:							//
;4902:							if (xPos + textWidth > (SCREEN_WIDTH-4)) {
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
CNSTI4 636
LEI4 $2170
line 4903
;4903:								fDescScale -= 0.001f;
ADDRLP4 68
ADDRLP4 68
INDIRF4
CNSTF4 981668463
SUBF4
ASGNF4
line 4904
;4904:								continue;
ADDRGP4 $2162
JUMPV
LABELV $2170
line 4906
;4905:							}
;4906:						}
LABELV $2168
line 4910
;4907:
;4908:						// Try to adjust it's y placement if the scale has changed...
;4909:						//
;4910:						if (fDescScale != fDescScaleCopy)
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
EQF4 $2172
line 4911
;4911:						{
line 4912
;4912:							int iOriginalTextHeight = DC->textHeight(textPtr, fDescScaleCopy, FONT_MEDIUM);
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 72
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 92
ADDRGP4 DC
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 92
INDIRI4
ASGNI4
line 4913
;4913:							iYadj = iOriginalTextHeight - DC->textHeight(textPtr, fDescScale, FONT_MEDIUM);
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRLP4 96
ADDRGP4 DC
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 76
ADDRLP4 88
INDIRI4
ADDRLP4 96
INDIRI4
SUBI4
ASGNI4
line 4914
;4914:						}
LABELV $2172
line 4916
;4915:
;4916:						DC->drawText(xPos, parent->descY + iYadj, fDescScale, parent->descColor, textPtr, 0, 0, item->textStyle, FONT_MEDIUM);
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1288
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1292
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4917
;4917:						break;
ADDRGP4 $2163
JUMPV
LABELV $2162
line 4881
ADDRGP4 $2161
JUMPV
LABELV $2163
line 4919
;4918:					}
;4919:				}
line 4920
;4920:			}
LABELV $2157
line 4921
;4921:		}
LABELV $2154
line 4922
;4922:	}
LABELV $2152
line 4925
;4923:
;4924:  // paint the rect first.. 
;4925:  Window_Paint(&item->window, parent->fadeAmount , parent->fadeClamp, parent->fadeCycle);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Window_Paint
CALLV
pop
line 4927
;4926:
;4927:  if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $2174
line 4929
;4928:		vec4_t color;
;4929:		rectDef_t *r = Item_CorrectedTextRect(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 56
ADDRLP4 76
INDIRP4
ASGNP4
line 4930
;4930:    color[1] = color[3] = 1;
ADDRLP4 80
CNSTF4 1065353216
ASGNF4
ADDRLP4 60+12
ADDRLP4 80
INDIRF4
ASGNF4
ADDRLP4 60+4
ADDRLP4 80
INDIRF4
ASGNF4
line 4931
;4931:    color[0] = color[2] = 0;
ADDRLP4 84
CNSTF4 0
ASGNF4
ADDRLP4 60+8
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 60
ADDRLP4 84
INDIRF4
ASGNF4
line 4932
;4932:    DC->drawRect(r->x, r->y, r->w, r->h, 1, color);
ADDRLP4 56
INDIRP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 60
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 4933
;4933:  }
LABELV $2174
line 4937
;4934:
;4935:  //DC->drawRect(item->window.rect.x, item->window.rect.y, item->window.rect.w, item->window.rect.h, 1, red);
;4936:
;4937:  switch (item->type) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
LTI4 $2180
ADDRLP4 56
INDIRI4
CNSTI4 14
GTI4 $2180
ADDRLP4 56
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2195
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2195
address $2183
address $2183
address $2180
address $2180
address $2186
address $2180
address $2188
address $2190
address $2182
address $2186
address $2194
address $2191
address $2192
address $2193
address $2189
code
LABELV $2182
line 4939
;4938:    case ITEM_TYPE_OWNERDRAW:
;4939:      Item_OwnerDraw_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_OwnerDraw_Paint
CALLV
pop
line 4940
;4940:      break;
ADDRGP4 $2180
JUMPV
LABELV $2183
line 4943
;4941:    case ITEM_TYPE_TEXT:
;4942:    case ITEM_TYPE_BUTTON:
;4943:      Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 4944
;4944:      break;
ADDRGP4 $2180
JUMPV
line 4946
;4945:    case ITEM_TYPE_RADIOBUTTON:
;4946:      break;
line 4948
;4947:    case ITEM_TYPE_CHECKBOX:
;4948:      break;
LABELV $2186
line 4951
;4949:    case ITEM_TYPE_EDITFIELD:
;4950:    case ITEM_TYPE_NUMERICFIELD:
;4951:      Item_TextField_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_TextField_Paint
CALLV
pop
line 4952
;4952:      break;
ADDRGP4 $2180
JUMPV
line 4954
;4953:    case ITEM_TYPE_COMBO:
;4954:      break;
LABELV $2188
line 4956
;4955:    case ITEM_TYPE_LISTBOX:
;4956:      Item_ListBox_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ListBox_Paint
CALLV
pop
line 4957
;4957:      break;
ADDRGP4 $2180
JUMPV
LABELV $2189
line 4959
;4958:	case ITEM_TYPE_TEXTSCROLL:
;4959:	  Item_TextScroll_Paint ( item );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_TextScroll_Paint
CALLV
pop
line 4960
;4960:	  break;
ADDRGP4 $2180
JUMPV
LABELV $2190
line 4965
;4961:    //case ITEM_TYPE_IMAGE:
;4962:    //  Item_Image_Paint(item);
;4963:    //  break;
;4964:    case ITEM_TYPE_MODEL:
;4965:      Item_Model_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Model_Paint
CALLV
pop
line 4966
;4966:      break;
ADDRGP4 $2180
JUMPV
LABELV $2191
line 4968
;4967:    case ITEM_TYPE_YESNO:
;4968:      Item_YesNo_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_YesNo_Paint
CALLV
pop
line 4969
;4969:      break;
ADDRGP4 $2180
JUMPV
LABELV $2192
line 4971
;4970:    case ITEM_TYPE_MULTI:
;4971:      Item_Multi_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Multi_Paint
CALLV
pop
line 4972
;4972:      break;
ADDRGP4 $2180
JUMPV
LABELV $2193
line 4974
;4973:    case ITEM_TYPE_BIND:
;4974:      Item_Bind_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Bind_Paint
CALLV
pop
line 4975
;4975:      break;
ADDRGP4 $2180
JUMPV
LABELV $2194
line 4977
;4976:    case ITEM_TYPE_SLIDER:
;4977:      Item_Slider_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Slider_Paint
CALLV
pop
line 4978
;4978:      break;
line 4980
;4979:    default:
;4980:      break;
LABELV $2180
line 4983
;4981:  }
;4982:
;4983:}
LABELV $2091
endproc Item_Paint 108 36
export Menu_Init
proc Menu_Init 0 12
line 4985
;4984:
;4985:void Menu_Init(menuDef_t *menu) {
line 4986
;4986:	memset(menu, 0, sizeof(menuDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1328
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4987
;4987:	menu->cursorItem = -1;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 -1
ASGNI4
line 4988
;4988:	menu->fadeAmount = DC->Assets.fadeAmount;
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ASGNF4
line 4989
;4989:	menu->fadeClamp = DC->Assets.fadeClamp;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 344
ADDP4
INDIRF4
ASGNF4
line 4990
;4990:	menu->fadeCycle = DC->Assets.fadeCycle;
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ASGNI4
line 4991
;4991:	Window_Init(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_Init
CALLV
pop
line 4992
;4992:}
LABELV $2196
endproc Menu_Init 0 12
export Menu_GetFocusedItem
proc Menu_GetFocusedItem 8 0
line 4994
;4993:
;4994:itemDef_t *Menu_GetFocusedItem(menuDef_t *menu) {
line 4996
;4995:  int i;
;4996:  if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2198
line 4997
;4997:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2203
JUMPV
LABELV $2200
line 4998
;4998:      if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 4
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $2204
line 4999
;4999:        return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $2197
JUMPV
LABELV $2204
line 5001
;5000:      }
;5001:    }
LABELV $2201
line 4997
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2203
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2200
line 5002
;5002:  }
LABELV $2198
line 5003
;5003:  return NULL;
CNSTP4 0
RETP4
LABELV $2197
endproc Menu_GetFocusedItem 8 0
export Menu_GetFocused
proc Menu_GetFocused 12 0
line 5006
;5004:}
;5005:
;5006:menuDef_t *Menu_GetFocused() {
line 5008
;5007:  int i;
;5008:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2210
JUMPV
LABELV $2207
line 5009
;5009:    if (Menus[i].window.flags & WINDOW_HASFOCUS && Menus[i].window.flags & WINDOW_VISIBLE) {
ADDRLP4 4
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $2211
ADDRLP4 4
INDIRI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $2211
line 5010
;5010:      return &Menus[i];
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $2206
JUMPV
LABELV $2211
line 5012
;5011:    }
;5012:  }
LABELV $2208
line 5008
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2210
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2207
line 5013
;5013:  return NULL;
CNSTP4 0
RETP4
LABELV $2206
endproc Menu_GetFocused 12 0
export Menu_ScrollFeeder
proc Menu_ScrollFeeder 12 16
line 5016
;5014:}
;5015:
;5016:void Menu_ScrollFeeder(menuDef_t *menu, int feeder, qboolean down) {
line 5017
;5017:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2216
line 5019
;5018:		int i;
;5019:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2221
JUMPV
LABELV $2218
line 5020
;5020:			if (menu->items[i]->special == feeder) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
NEF4 $2222
line 5021
;5021:				Item_ListBox_HandleKey(menu->items[i], (down) ? K_DOWNARROW : K_UPARROW, qtrue, qtrue);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $2225
ADDRLP4 4
CNSTI4 133
ASGNI4
ADDRGP4 $2226
JUMPV
LABELV $2225
ADDRLP4 4
CNSTI4 132
ASGNI4
LABELV $2226
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 5022
;5022:				return;
ADDRGP4 $2215
JUMPV
LABELV $2222
line 5024
;5023:			}
;5024:		}
LABELV $2219
line 5019
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2221
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2218
line 5025
;5025:	}
LABELV $2216
line 5026
;5026:}
LABELV $2215
endproc Menu_ScrollFeeder 12 16
export Menu_SetFeederSelection
proc Menu_SetFeederSelection 8 8
line 5030
;5027:
;5028:
;5029:
;5030:void Menu_SetFeederSelection(menuDef_t *menu, int feeder, int index, const char *name) {
line 5031
;5031:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2228
line 5032
;5032:		if (name == NULL) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2230
line 5033
;5033:			menu = Menu_GetFocused();
ADDRLP4 0
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
line 5034
;5034:		} else {
ADDRGP4 $2231
JUMPV
LABELV $2230
line 5035
;5035:			menu = Menus_FindByName(name);
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
line 5036
;5036:		}
LABELV $2231
line 5037
;5037:	}
LABELV $2228
line 5039
;5038:
;5039:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2232
line 5041
;5040:		int i;
;5041:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2237
JUMPV
LABELV $2234
line 5042
;5042:			if (menu->items[i]->special == feeder) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
NEF4 $2238
line 5043
;5043:				if (index == 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $2240
line 5044
;5044:					listBoxDef_t *listPtr = (listBoxDef_t*)menu->items[i]->typeData;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5045
;5045:					listPtr->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 5046
;5046:					listPtr->startPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 5047
;5047:				}
LABELV $2240
line 5048
;5048:				menu->items[i]->cursorPos = index;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 544
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 5049
;5049:				DC->feederSelection(menu->items[i]->special, menu->items[i]->cursorPos);
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 540
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLI4
pop
line 5050
;5050:				return;
ADDRGP4 $2227
JUMPV
LABELV $2238
line 5052
;5051:			}
;5052:		}
LABELV $2235
line 5041
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2237
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2234
line 5053
;5053:	}
LABELV $2232
line 5054
;5054:}
LABELV $2227
endproc Menu_SetFeederSelection 8 8
export Menus_AnyFullScreenVisible
proc Menus_AnyFullScreenVisible 12 0
line 5056
;5055:
;5056:qboolean Menus_AnyFullScreenVisible() {
line 5058
;5057:  int i;
;5058:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2246
JUMPV
LABELV $2243
line 5059
;5059:    if (Menus[i].window.flags & WINDOW_VISIBLE && Menus[i].fullScreen) {
ADDRLP4 4
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $2247
ADDRLP4 4
INDIRI4
ADDRGP4 Menus+184
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2247
line 5060
;5060:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2242
JUMPV
LABELV $2247
line 5062
;5061:    }
;5062:  }
LABELV $2244
line 5058
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2246
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2243
line 5063
;5063:  return qfalse;
CNSTI4 0
RETI4
LABELV $2242
endproc Menus_AnyFullScreenVisible 12 0
export Menus_ActivateByName
proc Menus_ActivateByName 28 12
line 5066
;5064:}
;5065:
;5066:menuDef_t *Menus_ActivateByName(const char *p) {
line 5068
;5067:  int i;
;5068:  menuDef_t *m = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 5069
;5069:	menuDef_t *focus = Menu_GetFocused();
ADDRLP4 12
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 5070
;5070:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2255
JUMPV
LABELV $2252
line 5071
;5071:    if (Q_stricmp(Menus[i].window.name, p) == 0) {
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+32
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $2256
line 5072
;5072:	    m = &Menus[i];
ADDRLP4 4
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ASGNP4
line 5073
;5073:			Menus_Activate(m);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 5074
;5074:			if (openMenuCount < MAX_OPEN_MENUS && focus != NULL) {
ADDRGP4 openMenuCount
INDIRI4
CNSTI4 16
GEI4 $2257
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2257
line 5075
;5075:				menuStack[openMenuCount++] = focus;
ADDRLP4 24
ADDRGP4 openMenuCount
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 menuStack
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 5076
;5076:			}
line 5077
;5077:    } else {
ADDRGP4 $2257
JUMPV
LABELV $2256
line 5078
;5078:      Menus[i].window.flags &= ~WINDOW_HASFOCUS;
ADDRLP4 20
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 5079
;5079:    }
LABELV $2257
line 5080
;5080:  }
LABELV $2253
line 5070
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2255
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2252
line 5081
;5081:	Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 5084
;5082:
;5083:	// Want to handle a mouse move on the new menu in case your already over an item
;5084:	Menu_HandleMouseMove ( m, DC->cursorx, DC->cursory );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 5086
;5085:
;5086:	return m;
ADDRLP4 4
INDIRP4
RETP4
LABELV $2251
endproc Menus_ActivateByName 28 12
export Item_Init
proc Item_Init 0 12
line 5090
;5087:}
;5088:
;5089:
;5090:void Item_Init(itemDef_t *item) {
line 5091
;5091:	memset(item, 0, sizeof(itemDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 564
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5092
;5092:	item->textscale = 0.55f;
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
CNSTF4 1057803469
ASGNF4
line 5093
;5093:	Window_Init(&item->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_Init
CALLV
pop
line 5094
;5094:}
LABELV $2262
endproc Item_Init 0 12
export Menu_HandleMouseMove
proc Menu_HandleMouseMove 52 12
line 5096
;5095:
;5096:void Menu_HandleMouseMove(menuDef_t *menu, float x, float y) {
line 5098
;5097:  int i, pass;
;5098:  qboolean focusSet = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 5101
;5099:
;5100:  itemDef_t *overItem;
;5101:  if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2264
line 5102
;5102:    return;
ADDRGP4 $2263
JUMPV
LABELV $2264
line 5105
;5103:  }
;5104:
;5105:  if (!(menu->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $2266
line 5106
;5106:    return;
ADDRGP4 $2263
JUMPV
LABELV $2266
line 5109
;5107:  }
;5108:
;5109:	if (itemCapture) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2268
line 5111
;5110:		//Item_MouseMove(itemCapture, x, y);
;5111:		return;
ADDRGP4 $2263
JUMPV
LABELV $2268
line 5114
;5112:	}
;5113:
;5114:	if (g_waitingForKey || g_editingField) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 g_waitingForKey
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $2272
ADDRGP4 g_editingField
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $2270
LABELV $2272
line 5115
;5115:		return;
ADDRGP4 $2263
JUMPV
LABELV $2270
line 5120
;5116:	}
;5117:
;5118:  // FIXME: this is the whole issue of focus vs. mouse over.. 
;5119:  // need a better overall solution as i don't like going through everything twice
;5120:  for (pass = 0; pass < 2; pass++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2273
line 5121
;5121:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2280
JUMPV
LABELV $2277
line 5125
;5122:      // turn off focus each item
;5123:      // menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;5124:
;5125:      if (!(menu->items[i]->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $2281
line 5126
;5126:        continue;
ADDRGP4 $2278
JUMPV
LABELV $2281
line 5130
;5127:      }
;5128:
;5129:			// items can be enabled and disabled based on cvars
;5130:			if (menu->items[i]->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(menu->items[i], CVAR_ENABLE)) {
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $2283
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 24
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $2283
line 5131
;5131:				continue;
ADDRGP4 $2278
JUMPV
LABELV $2283
line 5134
;5132:			}
;5133:
;5134:			if (menu->items[i]->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(menu->items[i], CVAR_SHOW)) {
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $2285
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 32
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $2285
line 5135
;5135:				continue;
ADDRGP4 $2278
JUMPV
LABELV $2285
line 5140
;5136:			}
;5137:
;5138:
;5139:
;5140:      if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2287
line 5141
;5141:				if (pass == 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $2288
line 5142
;5142:					overItem = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 5143
;5143:					if (overItem->type == ITEM_TYPE_TEXT && overItem->text) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2291
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2291
line 5144
;5144:						if (!Rect_ContainsPoint(Item_CorrectedTextRect(overItem), x, y)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $2293
line 5145
;5145:							continue;
ADDRGP4 $2278
JUMPV
LABELV $2293
line 5147
;5146:						}
;5147:					}
LABELV $2291
line 5149
;5148:					// if we are over an item
;5149:					if (IsVisible(overItem->window.flags)) {
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 IsVisible
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $2288
line 5151
;5150:						// different one
;5151:						Item_MouseEnter(overItem, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Item_MouseEnter
CALLV
pop
line 5155
;5152:						// Item_SetMouseOver(overItem, qtrue);
;5153:
;5154:						// if item is not a decoration see if it can take focus
;5155:						if (!focusSet) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2288
line 5156
;5156:							focusSet = Item_SetFocus(overItem, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 5157
;5157:						}
line 5158
;5158:					}
line 5159
;5159:				}
line 5160
;5160:      } else if (menu->items[i]->window.flags & WINDOW_MOUSEOVER) {
ADDRGP4 $2288
JUMPV
LABELV $2287
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2299
line 5161
;5161:          Item_MouseLeave(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_MouseLeave
CALLV
pop
line 5162
;5162:          Item_SetMouseOver(menu->items[i], qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Item_SetMouseOver
CALLV
pop
line 5163
;5163:      }
LABELV $2299
LABELV $2288
line 5164
;5164:    }
LABELV $2278
line 5121
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2280
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2277
line 5165
;5165:  }
LABELV $2274
line 5120
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LTI4 $2273
line 5167
;5166:
;5167:}
LABELV $2263
endproc Menu_HandleMouseMove 52 12
export Menu_Paint
proc Menu_Paint 48 24
line 5169
;5168:
;5169:void Menu_Paint(menuDef_t *menu, qboolean forcePaint) {
line 5172
;5170:	int i;
;5171:
;5172:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2302
line 5173
;5173:		return;
ADDRGP4 $2301
JUMPV
LABELV $2302
line 5176
;5174:	}
;5175:
;5176:	if (!(menu->window.flags & WINDOW_VISIBLE) &&  !forcePaint) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 4
INDIRI4
NEI4 $2304
ADDRFP4 4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $2304
line 5177
;5177:		return;
ADDRGP4 $2301
JUMPV
LABELV $2304
line 5180
;5178:	}
;5179:
;5180:	if (menu->window.ownerDrawFlags && DC->ownerDrawVisible && !DC->ownerDrawVisible(menu->window.ownerDrawFlags)) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2306
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2306
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $2306
line 5181
;5181:		return;
ADDRGP4 $2301
JUMPV
LABELV $2306
line 5184
;5182:	}
;5183:	
;5184:	if (forcePaint) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $2308
line 5185
;5185:		menu->window.flags |= WINDOW_FORCED;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1048576
BORI4
ASGNI4
line 5186
;5186:	}
LABELV $2308
line 5189
;5187:
;5188:	// draw the background if necessary
;5189:	if (menu->fullScreen) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2310
line 5192
;5190:		// implies a background shader
;5191:		// FIXME: make sure we have a default shader if fullscreen is set with no background
;5192:		DC->drawHandlePic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, menu->window.background );
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 5193
;5193:	} else if (menu->window.background) {
ADDRGP4 $2311
JUMPV
LABELV $2310
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2312
line 5196
;5194:		// this allows a background shader without being full screen
;5195:		//UI_DrawHandlePic(menu->window.rect.x, menu->window.rect.y, menu->window.rect.w, menu->window.rect.h, menu->backgroundShader);
;5196:	}
LABELV $2312
LABELV $2311
line 5199
;5197:
;5198:	// paint the background and or border
;5199:	Window_Paint(&menu->window, menu->fadeAmount, menu->fadeClamp, menu->fadeCycle );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Window_Paint
CALLV
pop
line 5202
;5200:
;5201:	// Loop through all items for the menu and paint them
;5202:	for (i = 0; i < menu->itemCount; i++) 
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2317
JUMPV
LABELV $2314
line 5203
;5203:	{
line 5204
;5204:		if (!menu->items[i]->appearanceSlot)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2318
line 5205
;5205:		{
line 5206
;5206:			Item_Paint(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Paint
CALLV
pop
line 5207
;5207:		}
ADDRGP4 $2319
JUMPV
LABELV $2318
line 5209
;5208:		else // Timed order of appearance
;5209:		{
line 5210
;5210:			if (menu->appearanceTime < DC->realTime)	// Time to show another item
ADDRFP4 0
INDIRP4
CNSTI4 1316
ADDP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CVIF4 4
GEF4 $2320
line 5211
;5211:			{
line 5212
;5212:				menu->appearanceTime = DC->realTime + menu->appearanceIncrement;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 1316
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 24
INDIRP4
CNSTI4 1324
ADDP4
INDIRF4
ADDF4
ASGNF4
line 5213
;5213:				menu->appearanceCnt++;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 1320
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5214
;5214:			}
LABELV $2320
line 5216
;5215:
;5216:			if (menu->items[i]->appearanceSlot<=menu->appearanceCnt)
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 1320
ADDP4
INDIRI4
GTI4 $2322
line 5217
;5217:			{
line 5218
;5218:				Item_Paint(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Paint
CALLV
pop
line 5219
;5219:			}
LABELV $2322
line 5220
;5220:		}
LABELV $2319
line 5221
;5221:	}
LABELV $2315
line 5202
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2317
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2314
line 5223
;5222:
;5223:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $2324
line 5225
;5224:		vec4_t color;
;5225:		color[0] = color[2] = color[3] = 1;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 40
INDIRF4
ASGNF4
line 5226
;5226:		color[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 5227
;5227:		DC->drawRect(menu->window.rect.x, menu->window.rect.y, menu->window.rect.w, menu->window.rect.h, 1, color);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 24
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 5228
;5228:	}
LABELV $2324
line 5229
;5229:}
LABELV $2301
endproc Menu_Paint 48 24
export Item_ValidateTypeData
proc Item_ValidateTypeData 8 12
line 5237
;5230:
;5231:/*
;5232:===============
;5233:Item_ValidateTypeData
;5234:===============
;5235:*/
;5236:void Item_ValidateTypeData(itemDef_t *item) 
;5237:{
line 5238
;5238:	if (item->typeData) 
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2330
line 5239
;5239:	{
line 5240
;5240:		return;
ADDRGP4 $2329
JUMPV
LABELV $2330
line 5243
;5241:	}
;5242:
;5243:	if (item->type == ITEM_TYPE_LISTBOX) 
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2332
line 5244
;5244:	{
line 5245
;5245:		item->typeData = UI_Alloc(sizeof(listBoxDef_t));
CNSTI4 232
ARGI4
ADDRLP4 0
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 5246
;5246:		memset(item->typeData, 0, sizeof(listBoxDef_t));
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 232
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5247
;5247:	}
ADDRGP4 $2333
JUMPV
LABELV $2332
line 5248
;5248:	else if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD || item->type == ITEM_TYPE_YESNO || item->type == ITEM_TYPE_BIND || item->type == ITEM_TYPE_SLIDER || item->type == ITEM_TYPE_TEXT) 
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $2340
ADDRLP4 0
INDIRI4
CNSTI4 9
EQI4 $2340
ADDRLP4 0
INDIRI4
CNSTI4 11
EQI4 $2340
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2340
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $2340
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2334
LABELV $2340
line 5249
;5249:	{
line 5250
;5250:		item->typeData = UI_Alloc(sizeof(editFieldDef_t));
CNSTI4 28
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5251
;5251:		memset(item->typeData, 0, sizeof(editFieldDef_t));
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 28
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5252
;5252:		if (item->type == ITEM_TYPE_EDITFIELD) 
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
NEI4 $2335
line 5253
;5253:		{
line 5254
;5254:			if (!((editFieldDef_t *) item->typeData)->maxPaintChars) 
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2335
line 5255
;5255:			{
line 5256
;5256:				((editFieldDef_t *) item->typeData)->maxPaintChars = MAX_EDITFIELD;
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 256
ASGNI4
line 5257
;5257:			}
line 5258
;5258:		}
line 5259
;5259:	} 
ADDRGP4 $2335
JUMPV
LABELV $2334
line 5260
;5260:	else if (item->type == ITEM_TYPE_MULTI) 
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 12
NEI4 $2345
line 5261
;5261:	{
line 5262
;5262:		item->typeData = UI_Alloc(sizeof(multiDef_t));
CNSTI4 392
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5263
;5263:	} 
ADDRGP4 $2346
JUMPV
LABELV $2345
line 5264
;5264:	else if (item->type == ITEM_TYPE_MODEL) 
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 7
NEI4 $2347
line 5265
;5265:	{
line 5266
;5266:		item->typeData = UI_Alloc(sizeof(modelDef_t));
CNSTI4 28
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5267
;5267:	}
ADDRGP4 $2348
JUMPV
LABELV $2347
line 5268
;5268:	else if (item->type == ITEM_TYPE_TEXTSCROLL )
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 14
NEI4 $2349
line 5269
;5269:	{
line 5270
;5270:		item->typeData = UI_Alloc(sizeof(textScrollDef_t));
CNSTI4 1048
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5271
;5271:	}
LABELV $2349
LABELV $2348
LABELV $2346
LABELV $2335
LABELV $2333
line 5272
;5272:}
LABELV $2329
endproc Item_ValidateTypeData 8 12
export KeywordHash_Key
proc KeywordHash_Key 20 0
line 5289
;5273:
;5274:/*
;5275:===============
;5276:Keyword Hash
;5277:===============
;5278:*/
;5279:
;5280:#define KEYWORDHASH_SIZE	512
;5281:
;5282:typedef struct keywordHash_s
;5283:{
;5284:	char *keyword;
;5285:	qboolean (*func)(itemDef_t *item, int handle);
;5286:	struct keywordHash_s *next;
;5287:} keywordHash_t;
;5288:
;5289:int KeywordHash_Key(char *keyword) {
line 5292
;5290:	int register hash, i;
;5291:
;5292:	hash = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 5293
;5293:	for (i = 0; keyword[i] != '\0'; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2355
JUMPV
LABELV $2352
line 5294
;5294:		if (keyword[i] >= 'A' && keyword[i] <= 'Z')
ADDRLP4 8
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 65
LTI4 $2356
ADDRLP4 8
INDIRI4
CNSTI4 90
GTI4 $2356
line 5295
;5295:			hash += (keyword[i] + ('a' - 'A')) * (119 + i);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
ADDRLP4 4
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
ADDRGP4 $2357
JUMPV
LABELV $2356
line 5297
;5296:		else
;5297:			hash += keyword[i] * (119 + i);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
LABELV $2357
line 5298
;5298:	}
LABELV $2353
line 5293
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2355
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2352
line 5299
;5299:	hash = (hash ^ (hash >> 10) ^ (hash >> 20)) & (KEYWORDHASH_SIZE-1);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 10
RSHI4
BXORI4
ADDRLP4 0
INDIRI4
CNSTI4 20
RSHI4
BXORI4
CNSTI4 511
BANDI4
ASGNI4
line 5300
;5300:	return hash;
ADDRLP4 0
INDIRI4
RETI4
LABELV $2351
endproc KeywordHash_Key 20 0
export KeywordHash_Add
proc KeywordHash_Add 8 4
line 5303
;5301:}
;5302:
;5303:void KeywordHash_Add(keywordHash_t *table[], keywordHash_t *key) {
line 5306
;5304:	int hash;
;5305:
;5306:	hash = KeywordHash_Key(key->keyword);
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 KeywordHash_Key
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 5312
;5307:/*
;5308:	if (table[hash]) {
;5309:		int collision = qtrue;
;5310:	}
;5311:*/
;5312:	key->next = table[hash];
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 5313
;5313:	table[hash] = key;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 5314
;5314:}
LABELV $2358
endproc KeywordHash_Add 8 4
export KeywordHash_Find
proc KeywordHash_Find 16 8
line 5317
;5315:
;5316:keywordHash_t *KeywordHash_Find(keywordHash_t *table[], char *keyword)
;5317:{
line 5321
;5318:	keywordHash_t *key;
;5319:	int hash;
;5320:
;5321:	hash = KeywordHash_Key(keyword);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 KeywordHash_Key
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 5322
;5322:	for (key = table[hash]; key; key = key->next) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $2363
JUMPV
LABELV $2360
line 5323
;5323:		if (!Q_stricmp(key->keyword, keyword))
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2364
line 5324
;5324:			return key;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $2359
JUMPV
LABELV $2364
line 5325
;5325:	}
LABELV $2361
line 5322
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
LABELV $2363
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2360
line 5326
;5326:	return NULL;
CNSTP4 0
RETP4
LABELV $2359
endproc KeywordHash_Find 16 8
export ItemParse_name
proc ItemParse_name 4 8
line 5336
;5327:}
;5328:
;5329:/*
;5330:===============
;5331:Item Keyword Parse functions
;5332:===============
;5333:*/
;5334:
;5335:// name <string>
;5336:qboolean ItemParse_name( itemDef_t *item, int handle ) {
line 5337
;5337:	if (!PC_String_Parse(handle, &item->window.name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2367
line 5338
;5338:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2366
JUMPV
LABELV $2367
line 5340
;5339:	}
;5340:	return qtrue;
CNSTI4 1
RETI4
LABELV $2366
endproc ItemParse_name 4 8
export ItemParse_focusSound
proc ItemParse_focusSound 12 8
line 5344
;5341:}
;5342:
;5343:// name <string>
;5344:qboolean ItemParse_focusSound( itemDef_t *item, int handle ) {
line 5346
;5345:	const char *temp;
;5346:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2370
line 5347
;5347:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2369
JUMPV
LABELV $2370
line 5349
;5348:	}
;5349:	item->focusSound = DC->registerSound(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 192
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 5350
;5350:	return qtrue;
CNSTI4 1
RETI4
LABELV $2369
endproc ItemParse_focusSound 12 8
export ItemParse_text
proc ItemParse_text 4 8
line 5355
;5351:}
;5352:
;5353:
;5354:// text <string>
;5355:qboolean ItemParse_text( itemDef_t *item, int handle ) {
line 5356
;5356:	if (!PC_String_Parse(handle, &item->text)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2373
line 5357
;5357:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2372
JUMPV
LABELV $2373
line 5359
;5358:	}
;5359:	return qtrue;
CNSTI4 1
RETI4
LABELV $2372
endproc ItemParse_text 4 8
export ItemParse_descText
proc ItemParse_descText 4 8
line 5369
;5360:}
;5361:
;5362:/*
;5363:===============
;5364:ItemParse_descText 
;5365:	text <string>
;5366:===============
;5367:*/
;5368:qboolean ItemParse_descText( itemDef_t *item, int handle) 
;5369:{
line 5371
;5370:
;5371:	if (!PC_String_Parse(handle, &item->descText))
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2376
line 5372
;5372:	{
line 5373
;5373:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2375
JUMPV
LABELV $2376
line 5376
;5374:	}
;5375:
;5376:	return qtrue;
CNSTI4 1
RETI4
LABELV $2375
endproc ItemParse_descText 4 8
export ItemParse_text2
proc ItemParse_text2 4 8
line 5388
;5377:
;5378:}
;5379:
;5380:
;5381:/*
;5382:===============
;5383:ItemParse_text 
;5384:	text <string>
;5385:===============
;5386:*/
;5387:qboolean ItemParse_text2( itemDef_t *item, int handle) 
;5388:{
line 5390
;5389:
;5390:	if (!PC_String_Parse(handle, &item->text2))
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2379
line 5391
;5391:	{
line 5392
;5392:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2378
JUMPV
LABELV $2379
line 5395
;5393:	}
;5394:
;5395:	return qtrue;
CNSTI4 1
RETI4
LABELV $2378
endproc ItemParse_text2 4 8
export ItemParse_text2alignx
proc ItemParse_text2alignx 4 8
line 5405
;5396:
;5397:}
;5398:
;5399:/*
;5400:===============
;5401:ItemParse_text2alignx 
;5402:===============
;5403:*/
;5404:qboolean ItemParse_text2alignx( itemDef_t *item, int handle) 
;5405:{
line 5406
;5406:	if (!PC_Float_Parse(handle, &item->text2alignx)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2382
line 5407
;5407:	{
line 5408
;5408:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2381
JUMPV
LABELV $2382
line 5410
;5409:	}
;5410:	return qtrue;
CNSTI4 1
RETI4
LABELV $2381
endproc ItemParse_text2alignx 4 8
export ItemParse_text2aligny
proc ItemParse_text2aligny 4 8
line 5419
;5411:}
;5412:
;5413:/*
;5414:===============
;5415:ItemParse_text2aligny 
;5416:===============
;5417:*/
;5418:qboolean ItemParse_text2aligny( itemDef_t *item, int handle) 
;5419:{
line 5420
;5420:	if (!PC_Float_Parse(handle, &item->text2aligny)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2385
line 5421
;5421:	{
line 5422
;5422:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2384
JUMPV
LABELV $2385
line 5424
;5423:	}
;5424:	return qtrue;
CNSTI4 1
RETI4
LABELV $2384
endproc ItemParse_text2aligny 4 8
export ItemParse_group
proc ItemParse_group 4 8
line 5428
;5425:}
;5426:
;5427:// group <string>
;5428:qboolean ItemParse_group( itemDef_t *item, int handle ) {
line 5429
;5429:	if (!PC_String_Parse(handle, &item->window.group)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2388
line 5430
;5430:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2387
JUMPV
LABELV $2388
line 5432
;5431:	}
;5432:	return qtrue;
CNSTI4 1
RETI4
LABELV $2387
endproc ItemParse_group 4 8
export ItemParse_asset_model
proc ItemParse_asset_model 20 8
line 5436
;5433:}
;5434:
;5435:// asset_model <string>
;5436:qboolean ItemParse_asset_model( itemDef_t *item, int handle ) {
line 5439
;5437:	const char *temp;
;5438:	modelDef_t *modelPtr;
;5439:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5440
;5440:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5442
;5441:
;5442:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2391
line 5443
;5443:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2390
JUMPV
LABELV $2391
line 5445
;5444:	}
;5445:	item->asset = DC->registerModel(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 5446
;5446:	modelPtr->angle = rand() % 360;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 16
INDIRI4
CNSTI4 360
MODI4
ASGNI4
line 5447
;5447:	return qtrue;
CNSTI4 1
RETI4
LABELV $2390
endproc ItemParse_asset_model 20 8
export ItemParse_asset_shader
proc ItemParse_asset_shader 12 8
line 5451
;5448:}
;5449:
;5450:// asset_shader <string>
;5451:qboolean ItemParse_asset_shader( itemDef_t *item, int handle ) {
line 5454
;5452:	const char *temp;
;5453:
;5454:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2394
line 5455
;5455:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2393
JUMPV
LABELV $2394
line 5457
;5456:	}
;5457:	item->asset = DC->registerShaderNoMip(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 5458
;5458:	return qtrue;
CNSTI4 1
RETI4
LABELV $2393
endproc ItemParse_asset_shader 12 8
export ItemParse_model_origin
proc ItemParse_model_origin 16 8
line 5462
;5459:}
;5460:
;5461:// model_origin <number> <number> <number>
;5462:qboolean ItemParse_model_origin( itemDef_t *item, int handle ) {
line 5464
;5463:	modelDef_t *modelPtr;
;5464:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5465
;5465:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5467
;5466:
;5467:	if (PC_Float_Parse(handle, &modelPtr->origin[0])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2397
line 5468
;5468:		if (PC_Float_Parse(handle, &modelPtr->origin[1])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2399
line 5469
;5469:			if (PC_Float_Parse(handle, &modelPtr->origin[2])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2401
line 5470
;5470:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2396
JUMPV
LABELV $2401
line 5472
;5471:			}
;5472:		}
LABELV $2399
line 5473
;5473:	}
LABELV $2397
line 5474
;5474:	return qfalse;
CNSTI4 0
RETI4
LABELV $2396
endproc ItemParse_model_origin 16 8
export ItemParse_model_fovx
proc ItemParse_model_fovx 8 8
line 5478
;5475:}
;5476:
;5477:// model_fovx <number>
;5478:qboolean ItemParse_model_fovx( itemDef_t *item, int handle ) {
line 5480
;5479:	modelDef_t *modelPtr;
;5480:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5481
;5481:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5483
;5482:
;5483:	if (!PC_Float_Parse(handle, &modelPtr->fov_x)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2404
line 5484
;5484:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2403
JUMPV
LABELV $2404
line 5486
;5485:	}
;5486:	return qtrue;
CNSTI4 1
RETI4
LABELV $2403
endproc ItemParse_model_fovx 8 8
export ItemParse_model_fovy
proc ItemParse_model_fovy 8 8
line 5490
;5487:}
;5488:
;5489:// model_fovy <number>
;5490:qboolean ItemParse_model_fovy( itemDef_t *item, int handle ) {
line 5492
;5491:	modelDef_t *modelPtr;
;5492:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5493
;5493:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5495
;5494:
;5495:	if (!PC_Float_Parse(handle, &modelPtr->fov_y)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2407
line 5496
;5496:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2406
JUMPV
LABELV $2407
line 5498
;5497:	}
;5498:	return qtrue;
CNSTI4 1
RETI4
LABELV $2406
endproc ItemParse_model_fovy 8 8
export ItemParse_model_rotation
proc ItemParse_model_rotation 8 8
line 5502
;5499:}
;5500:
;5501:// model_rotation <integer>
;5502:qboolean ItemParse_model_rotation( itemDef_t *item, int handle ) {
line 5504
;5503:	modelDef_t *modelPtr;
;5504:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5505
;5505:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5507
;5506:
;5507:	if (!PC_Int_Parse(handle, &modelPtr->rotationSpeed)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2410
line 5508
;5508:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2409
JUMPV
LABELV $2410
line 5510
;5509:	}
;5510:	return qtrue;
CNSTI4 1
RETI4
LABELV $2409
endproc ItemParse_model_rotation 8 8
export ItemParse_model_angle
proc ItemParse_model_angle 8 8
line 5514
;5511:}
;5512:
;5513:// model_angle <integer>
;5514:qboolean ItemParse_model_angle( itemDef_t *item, int handle ) {
line 5516
;5515:	modelDef_t *modelPtr;
;5516:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5517
;5517:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5519
;5518:
;5519:	if (!PC_Int_Parse(handle, &modelPtr->angle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2413
line 5520
;5520:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2412
JUMPV
LABELV $2413
line 5522
;5521:	}
;5522:	return qtrue;
CNSTI4 1
RETI4
LABELV $2412
endproc ItemParse_model_angle 8 8
export ItemParse_rect
proc ItemParse_rect 4 8
line 5526
;5523:}
;5524:
;5525:// rect <rectangle>
;5526:qboolean ItemParse_rect( itemDef_t *item, int handle ) {
line 5527
;5527:	if (!PC_Rect_Parse(handle, &item->window.rectClient)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Rect_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2416
line 5528
;5528:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2415
JUMPV
LABELV $2416
line 5530
;5529:	}
;5530:	return qtrue;
CNSTI4 1
RETI4
LABELV $2415
endproc ItemParse_rect 4 8
export ItemParse_flag
proc ItemParse_flag 20 8
line 5540
;5531:}
;5532:
;5533:/*
;5534:===============
;5535:ItemParse_flag
;5536:	style <integer>
;5537:===============
;5538:*/
;5539:qboolean ItemParse_flag( itemDef_t *item, int handle) 
;5540:{
line 5544
;5541:	int		i;
;5542:	char	*tempStr;
;5543:
;5544:	if (!PC_String_Parse(handle, (const char **)&tempStr))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2419
line 5545
;5545:	{
line 5546
;5546:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2418
JUMPV
LABELV $2419
line 5549
;5547:	}
;5548:
;5549:	i=0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2422
JUMPV
LABELV $2421
line 5551
;5550:	while (styles[i])
;5551:	{
line 5552
;5552:		if (Q_stricmp(tempStr,itemFlags[i].string)==0)
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 itemFlags
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
NEI4 $2424
line 5553
;5553:		{
line 5554
;5554:			item->window.flags |= itemFlags[i].value;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 itemFlags+4
ADDP4
INDIRI4
BORI4
ASGNI4
line 5555
;5555:			break;
ADDRGP4 $2423
JUMPV
LABELV $2424
line 5557
;5556:		}
;5557:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5558
;5558:	}
LABELV $2422
line 5550
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 styles
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2421
LABELV $2423
line 5560
;5559:
;5560:	if (itemFlags[i].string == NULL)
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 itemFlags
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2427
line 5561
;5561:	{
line 5562
;5562:		Com_Printf(va( S_COLOR_YELLOW "Unknown item style value '%s'",tempStr));
ADDRGP4 $2429
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5563
;5563:	}
LABELV $2427
line 5565
;5564:
;5565:	return qtrue;
CNSTI4 1
RETI4
LABELV $2418
endproc ItemParse_flag 20 8
export ItemParse_style
proc ItemParse_style 4 8
line 5575
;5566:}
;5567:
;5568:/*
;5569:===============
;5570:ItemParse_style 
;5571:	style <integer>
;5572:===============
;5573:*/
;5574:qboolean ItemParse_style( itemDef_t *item, int handle) 
;5575:{
line 5576
;5576:	if (!PC_Int_Parse(handle, &item->window.style))
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2431
line 5577
;5577:	{
line 5578
;5578:		Com_Printf(S_COLOR_YELLOW "Unknown item style value");
ADDRGP4 $2433
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5579
;5579:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2430
JUMPV
LABELV $2431
line 5582
;5580:	}
;5581:
;5582:	return qtrue;
CNSTI4 1
RETI4
LABELV $2430
endproc ItemParse_style 4 8
export ItemParse_decoration
proc ItemParse_decoration 4 0
line 5587
;5583:}
;5584:
;5585:
;5586:// decoration
;5587:qboolean ItemParse_decoration( itemDef_t *item, int handle ) {
line 5588
;5588:	item->window.flags |= WINDOW_DECORATION;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 5589
;5589:	return qtrue;
CNSTI4 1
RETI4
LABELV $2434
endproc ItemParse_decoration 4 0
export ItemParse_notselectable
proc ItemParse_notselectable 4 4
line 5593
;5590:}
;5591:
;5592:// notselectable
;5593:qboolean ItemParse_notselectable( itemDef_t *item, int handle ) {
line 5595
;5594:	listBoxDef_t *listPtr;
;5595:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5596
;5596:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5597
;5597:	if (item->type == ITEM_TYPE_LISTBOX && listPtr) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2436
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2436
line 5598
;5598:		listPtr->notselectable = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 1
ASGNI4
line 5599
;5599:	}
LABELV $2436
line 5600
;5600:	return qtrue;
CNSTI4 1
RETI4
LABELV $2435
endproc ItemParse_notselectable 4 4
export ItemParse_wrapped
proc ItemParse_wrapped 4 0
line 5604
;5601:}
;5602:
;5603:// manually wrapped
;5604:qboolean ItemParse_wrapped( itemDef_t *item, int handle ) {
line 5605
;5605:	item->window.flags |= WINDOW_WRAPPED;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 262144
BORI4
ASGNI4
line 5606
;5606:	return qtrue;
CNSTI4 1
RETI4
LABELV $2438
endproc ItemParse_wrapped 4 0
export ItemParse_autowrapped
proc ItemParse_autowrapped 4 0
line 5610
;5607:}
;5608:
;5609:// auto wrapped
;5610:qboolean ItemParse_autowrapped( itemDef_t *item, int handle ) {
line 5611
;5611:	item->window.flags |= WINDOW_AUTOWRAPPED;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 524288
BORI4
ASGNI4
line 5612
;5612:	return qtrue;
CNSTI4 1
RETI4
LABELV $2439
endproc ItemParse_autowrapped 4 0
export ItemParse_horizontalscroll
proc ItemParse_horizontalscroll 4 0
line 5617
;5613:}
;5614:
;5615:
;5616:// horizontalscroll
;5617:qboolean ItemParse_horizontalscroll( itemDef_t *item, int handle ) {
line 5618
;5618:	item->window.flags |= WINDOW_HORIZONTAL;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 5619
;5619:	return qtrue;
CNSTI4 1
RETI4
LABELV $2440
endproc ItemParse_horizontalscroll 4 0
export ItemParse_type
proc ItemParse_type 4 8
line 5629
;5620:}
;5621:
;5622:/*
;5623:===============
;5624:ItemParse_type 
;5625:	type <integer>
;5626:===============
;5627:*/
;5628:qboolean ItemParse_type( itemDef_t *item, int handle  ) 
;5629:{
line 5632
;5630://	int		i,holdInt;
;5631:
;5632:	if (!PC_Int_Parse(handle, &item->type)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2442
line 5633
;5633:	{
line 5634
;5634:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2441
JUMPV
LABELV $2442
line 5636
;5635:	}
;5636:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5637
;5637:	return qtrue;
CNSTI4 1
RETI4
LABELV $2441
endproc ItemParse_type 4 8
export ItemParse_elementwidth
proc ItemParse_elementwidth 8 8
line 5642
;5638:}
;5639:
;5640:// elementwidth, used for listbox image elements
;5641:// uses textalignx for storage
;5642:qboolean ItemParse_elementwidth( itemDef_t *item, int handle ) {
line 5645
;5643:	listBoxDef_t *listPtr;
;5644:
;5645:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5646
;5646:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5647
;5647:	if (!PC_Float_Parse(handle, &listPtr->elementWidth)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2445
line 5648
;5648:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2444
JUMPV
LABELV $2445
line 5650
;5649:	}
;5650:	return qtrue;
CNSTI4 1
RETI4
LABELV $2444
endproc ItemParse_elementwidth 8 8
export ItemParse_elementheight
proc ItemParse_elementheight 8 8
line 5655
;5651:}
;5652:
;5653:// elementheight, used for listbox image elements
;5654:// uses textaligny for storage
;5655:qboolean ItemParse_elementheight( itemDef_t *item, int handle ) {
line 5658
;5656:	listBoxDef_t *listPtr;
;5657:
;5658:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5659
;5659:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5660
;5660:	if (!PC_Float_Parse(handle, &listPtr->elementHeight)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2448
line 5661
;5661:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2447
JUMPV
LABELV $2448
line 5663
;5662:	}
;5663:	return qtrue;
CNSTI4 1
RETI4
LABELV $2447
endproc ItemParse_elementheight 8 8
export ItemParse_feeder
proc ItemParse_feeder 4 8
line 5667
;5664:}
;5665:
;5666:// feeder <float>
;5667:qboolean ItemParse_feeder( itemDef_t *item, int handle ) {
line 5668
;5668:	if (!PC_Float_Parse(handle, &item->special)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2451
line 5669
;5669:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2450
JUMPV
LABELV $2451
line 5671
;5670:	}
;5671:	return qtrue;
CNSTI4 1
RETI4
LABELV $2450
endproc ItemParse_feeder 4 8
export ItemParse_elementtype
proc ItemParse_elementtype 8 8
line 5676
;5672:}
;5673:
;5674:// elementtype, used to specify what type of elements a listbox contains
;5675:// uses textstyle for storage
;5676:qboolean ItemParse_elementtype( itemDef_t *item, int handle ) {
line 5679
;5677:	listBoxDef_t *listPtr;
;5678:
;5679:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5680
;5680:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2454
line 5681
;5681:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2453
JUMPV
LABELV $2454
line 5682
;5682:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5683
;5683:	if (!PC_Int_Parse(handle, &listPtr->elementStyle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2456
line 5684
;5684:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2453
JUMPV
LABELV $2456
line 5686
;5685:	}
;5686:	return qtrue;
CNSTI4 1
RETI4
LABELV $2453
endproc ItemParse_elementtype 8 8
export ItemParse_columns
proc ItemParse_columns 40 8
line 5690
;5687:}
;5688:
;5689:// columns sets a number of columns and an x pos and width per.. 
;5690:qboolean ItemParse_columns( itemDef_t *item, int handle ) {
line 5694
;5691:	int num, i;
;5692:	listBoxDef_t *listPtr;
;5693:
;5694:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5695
;5695:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2459
line 5696
;5696:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2458
JUMPV
LABELV $2459
line 5697
;5697:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5698
;5698:	if (PC_Int_Parse(handle, &num)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 12
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2461
line 5699
;5699:		if (num > MAX_LB_COLUMNS) {
ADDRLP4 8
INDIRI4
CNSTI4 16
LEI4 $2463
line 5700
;5700:			num = MAX_LB_COLUMNS;
ADDRLP4 8
CNSTI4 16
ASGNI4
line 5701
;5701:		}
LABELV $2463
line 5702
;5702:		listPtr->numColumns = num;
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 5703
;5703:		for (i = 0; i < num; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2468
JUMPV
LABELV $2465
line 5706
;5704:			int pos, width, maxChars;
;5705:
;5706:			if (PC_Int_Parse(handle, &pos) && PC_Int_Parse(handle, &width) && PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2469
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 32
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2469
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2469
line 5707
;5707:				listPtr->columnInfo[i].pos = pos;
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5708
;5708:				listPtr->columnInfo[i].width = width;
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 5709
;5709:				listPtr->columnInfo[i].maxChars = maxChars;
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 5710
;5710:			} else {
ADDRGP4 $2470
JUMPV
LABELV $2469
line 5711
;5711:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2458
JUMPV
LABELV $2470
line 5713
;5712:			}
;5713:		}
LABELV $2466
line 5703
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2468
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $2465
line 5714
;5714:	} else {
ADDRGP4 $2462
JUMPV
LABELV $2461
line 5715
;5715:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2458
JUMPV
LABELV $2462
line 5717
;5716:	}
;5717:	return qtrue;
CNSTI4 1
RETI4
LABELV $2458
endproc ItemParse_columns 40 8
export ItemParse_border
proc ItemParse_border 4 8
line 5720
;5718:}
;5719:
;5720:qboolean ItemParse_border( itemDef_t *item, int handle ) {
line 5721
;5721:	if (!PC_Int_Parse(handle, &item->window.border)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2472
line 5722
;5722:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2471
JUMPV
LABELV $2472
line 5724
;5723:	}
;5724:	return qtrue;
CNSTI4 1
RETI4
LABELV $2471
endproc ItemParse_border 4 8
export ItemParse_bordersize
proc ItemParse_bordersize 4 8
line 5727
;5725:}
;5726:
;5727:qboolean ItemParse_bordersize( itemDef_t *item, int handle ) {
line 5728
;5728:	if (!PC_Float_Parse(handle, &item->window.borderSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2475
line 5729
;5729:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2474
JUMPV
LABELV $2475
line 5731
;5730:	}
;5731:	return qtrue;
CNSTI4 1
RETI4
LABELV $2474
endproc ItemParse_bordersize 4 8
export ItemParse_visible
proc ItemParse_visible 12 8
line 5734
;5732:}
;5733:
;5734:qboolean ItemParse_visible( itemDef_t *item, int handle ) {
line 5737
;5735:	int i;
;5736:
;5737:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2478
line 5738
;5738:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2477
JUMPV
LABELV $2478
line 5740
;5739:	}
;5740:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2480
line 5741
;5741:		item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 5742
;5742:	}
LABELV $2480
line 5743
;5743:	return qtrue;
CNSTI4 1
RETI4
LABELV $2477
endproc ItemParse_visible 12 8
export ItemParse_ownerdraw
proc ItemParse_ownerdraw 4 8
line 5746
;5744:}
;5745:
;5746:qboolean ItemParse_ownerdraw( itemDef_t *item, int handle ) {
line 5747
;5747:	if (!PC_Int_Parse(handle, &item->window.ownerDraw)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2483
line 5748
;5748:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2482
JUMPV
LABELV $2483
line 5750
;5749:	}
;5750:	item->type = ITEM_TYPE_OWNERDRAW;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 8
ASGNI4
line 5751
;5751:	return qtrue;
CNSTI4 1
RETI4
LABELV $2482
endproc ItemParse_ownerdraw 4 8
export ItemParse_align
proc ItemParse_align 4 8
line 5754
;5752:}
;5753:
;5754:qboolean ItemParse_align( itemDef_t *item, int handle ) {
line 5755
;5755:	if (!PC_Int_Parse(handle, &item->alignment)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2486
line 5756
;5756:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2485
JUMPV
LABELV $2486
line 5758
;5757:	}
;5758:	return qtrue;
CNSTI4 1
RETI4
LABELV $2485
endproc ItemParse_align 4 8
export ItemParse_textalign
proc ItemParse_textalign 4 8
line 5767
;5759:}
;5760:
;5761:/*
;5762:===============
;5763:ItemParse_textalign 
;5764:===============
;5765:*/
;5766:qboolean ItemParse_textalign( itemDef_t *item, int handle ) 
;5767:{
line 5768
;5768:	if (!PC_Int_Parse(handle, &item->textalignment)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2489
line 5769
;5769:	{
line 5770
;5770:		Com_Printf(S_COLOR_YELLOW "Unknown text alignment value");
ADDRGP4 $2491
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5772
;5771:	
;5772:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2488
JUMPV
LABELV $2489
line 5775
;5773:	}
;5774:
;5775:	return qtrue;
CNSTI4 1
RETI4
LABELV $2488
endproc ItemParse_textalign 4 8
export ItemParse_textalignx
proc ItemParse_textalignx 4 8
line 5778
;5776:}
;5777:
;5778:qboolean ItemParse_textalignx( itemDef_t *item, int handle ) {
line 5779
;5779:	if (!PC_Float_Parse(handle, &item->textalignx)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2493
line 5780
;5780:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2492
JUMPV
LABELV $2493
line 5782
;5781:	}
;5782:	return qtrue;
CNSTI4 1
RETI4
LABELV $2492
endproc ItemParse_textalignx 4 8
export ItemParse_textaligny
proc ItemParse_textaligny 4 8
line 5785
;5783:}
;5784:
;5785:qboolean ItemParse_textaligny( itemDef_t *item, int handle ) {
line 5786
;5786:	if (!PC_Float_Parse(handle, &item->textaligny)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2496
line 5787
;5787:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2495
JUMPV
LABELV $2496
line 5789
;5788:	}
;5789:	return qtrue;
CNSTI4 1
RETI4
LABELV $2495
endproc ItemParse_textaligny 4 8
export ItemParse_textscale
proc ItemParse_textscale 4 8
line 5792
;5790:}
;5791:
;5792:qboolean ItemParse_textscale( itemDef_t *item, int handle ) {
line 5793
;5793:	if (!PC_Float_Parse(handle, &item->textscale)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2499
line 5794
;5794:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2498
JUMPV
LABELV $2499
line 5796
;5795:	}
;5796:	return qtrue;
CNSTI4 1
RETI4
LABELV $2498
endproc ItemParse_textscale 4 8
export ItemParse_textstyle
proc ItemParse_textstyle 4 8
line 5799
;5797:}
;5798:
;5799:qboolean ItemParse_textstyle( itemDef_t *item, int handle ) {
line 5800
;5800:	if (!PC_Int_Parse(handle, &item->textStyle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2502
line 5801
;5801:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2501
JUMPV
LABELV $2502
line 5803
;5802:	}
;5803:	return qtrue;
CNSTI4 1
RETI4
LABELV $2501
endproc ItemParse_textstyle 4 8
export ItemParse_backcolor
proc ItemParse_backcolor 12 8
line 5806
;5804:}
;5805:
;5806:qboolean ItemParse_backcolor( itemDef_t *item, int handle ) {
line 5810
;5807:	int i;
;5808:	float f;
;5809:
;5810:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2505
line 5811
;5811:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2509
line 5812
;5812:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2504
JUMPV
LABELV $2509
line 5814
;5813:		}
;5814:		item->window.backColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5815
;5815:	}
LABELV $2506
line 5810
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2505
line 5816
;5816:	return qtrue;
CNSTI4 1
RETI4
LABELV $2504
endproc ItemParse_backcolor 12 8
export ItemParse_forecolor
proc ItemParse_forecolor 16 8
line 5819
;5817:}
;5818:
;5819:qboolean ItemParse_forecolor( itemDef_t *item, int handle ) {
line 5823
;5820:	int i;
;5821:	float f;
;5822:
;5823:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2512
line 5824
;5824:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2516
line 5825
;5825:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2511
JUMPV
LABELV $2516
line 5827
;5826:		}
;5827:		item->window.foreColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5828
;5828:		item->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 5829
;5829:	}
LABELV $2513
line 5823
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2512
line 5830
;5830:	return qtrue;
CNSTI4 1
RETI4
LABELV $2511
endproc ItemParse_forecolor 16 8
export ItemParse_bordercolor
proc ItemParse_bordercolor 12 8
line 5833
;5831:}
;5832:
;5833:qboolean ItemParse_bordercolor( itemDef_t *item, int handle ) {
line 5837
;5834:	int i;
;5835:	float f;
;5836:
;5837:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2519
line 5838
;5838:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2523
line 5839
;5839:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2518
JUMPV
LABELV $2523
line 5841
;5840:		}
;5841:		item->window.borderColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5842
;5842:	}
LABELV $2520
line 5837
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2519
line 5843
;5843:	return qtrue;
CNSTI4 1
RETI4
LABELV $2518
endproc ItemParse_bordercolor 12 8
export ItemParse_outlinecolor
proc ItemParse_outlinecolor 4 8
line 5846
;5844:}
;5845:
;5846:qboolean ItemParse_outlinecolor( itemDef_t *item, int handle ) {
line 5847
;5847:	if (!PC_Color_Parse(handle, &item->window.outlineColor)){
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2526
line 5848
;5848:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2525
JUMPV
LABELV $2526
line 5850
;5849:	}
;5850:	return qtrue;
CNSTI4 1
RETI4
LABELV $2525
endproc ItemParse_outlinecolor 4 8
export ItemParse_background
proc ItemParse_background 12 8
line 5853
;5851:}
;5852:
;5853:qboolean ItemParse_background( itemDef_t *item, int handle ) {
line 5856
;5854:	const char *temp;
;5855:
;5856:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2529
line 5857
;5857:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2528
JUMPV
LABELV $2529
line 5859
;5858:	}
;5859:	item->window.background = DC->registerShaderNoMip(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 5860
;5860:	return qtrue;
CNSTI4 1
RETI4
LABELV $2528
endproc ItemParse_background 12 8
export ItemParse_cinematic
proc ItemParse_cinematic 4 8
line 5863
;5861:}
;5862:
;5863:qboolean ItemParse_cinematic( itemDef_t *item, int handle ) {
line 5864
;5864:	if (!PC_String_Parse(handle, &item->window.cinematicName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2532
line 5865
;5865:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2531
JUMPV
LABELV $2532
line 5867
;5866:	}
;5867:	return qtrue;
CNSTI4 1
RETI4
LABELV $2531
endproc ItemParse_cinematic 4 8
export ItemParse_doubleClick
proc ItemParse_doubleClick 8 8
line 5870
;5868:}
;5869:
;5870:qboolean ItemParse_doubleClick( itemDef_t *item, int handle ) {
line 5873
;5871:	listBoxDef_t *listPtr;
;5872:
;5873:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5874
;5874:	if (!item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2535
line 5875
;5875:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2534
JUMPV
LABELV $2535
line 5878
;5876:	}
;5877:
;5878:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5880
;5879:
;5880:	if (!PC_Script_Parse(handle, &listPtr->doubleClick)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2537
line 5881
;5881:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2534
JUMPV
LABELV $2537
line 5883
;5882:	}
;5883:	return qtrue;
CNSTI4 1
RETI4
LABELV $2534
endproc ItemParse_doubleClick 8 8
export ItemParse_onFocus
proc ItemParse_onFocus 4 8
line 5886
;5884:}
;5885:
;5886:qboolean ItemParse_onFocus( itemDef_t *item, int handle ) {
line 5887
;5887:	if (!PC_Script_Parse(handle, &item->onFocus)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2540
line 5888
;5888:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2539
JUMPV
LABELV $2540
line 5890
;5889:	}
;5890:	return qtrue;
CNSTI4 1
RETI4
LABELV $2539
endproc ItemParse_onFocus 4 8
export ItemParse_leaveFocus
proc ItemParse_leaveFocus 4 8
line 5893
;5891:}
;5892:
;5893:qboolean ItemParse_leaveFocus( itemDef_t *item, int handle ) {
line 5894
;5894:	if (!PC_Script_Parse(handle, &item->leaveFocus)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2543
line 5895
;5895:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2542
JUMPV
LABELV $2543
line 5897
;5896:	}
;5897:	return qtrue;
CNSTI4 1
RETI4
LABELV $2542
endproc ItemParse_leaveFocus 4 8
export ItemParse_mouseEnter
proc ItemParse_mouseEnter 4 8
line 5900
;5898:}
;5899:
;5900:qboolean ItemParse_mouseEnter( itemDef_t *item, int handle ) {
line 5901
;5901:	if (!PC_Script_Parse(handle, &item->mouseEnter)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2546
line 5902
;5902:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2545
JUMPV
LABELV $2546
line 5904
;5903:	}
;5904:	return qtrue;
CNSTI4 1
RETI4
LABELV $2545
endproc ItemParse_mouseEnter 4 8
export ItemParse_mouseExit
proc ItemParse_mouseExit 4 8
line 5907
;5905:}
;5906:
;5907:qboolean ItemParse_mouseExit( itemDef_t *item, int handle ) {
line 5908
;5908:	if (!PC_Script_Parse(handle, &item->mouseExit)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2549
line 5909
;5909:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2548
JUMPV
LABELV $2549
line 5911
;5910:	}
;5911:	return qtrue;
CNSTI4 1
RETI4
LABELV $2548
endproc ItemParse_mouseExit 4 8
export ItemParse_mouseEnterText
proc ItemParse_mouseEnterText 4 8
line 5914
;5912:}
;5913:
;5914:qboolean ItemParse_mouseEnterText( itemDef_t *item, int handle ) {
line 5915
;5915:	if (!PC_Script_Parse(handle, &item->mouseEnterText)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2552
line 5916
;5916:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2551
JUMPV
LABELV $2552
line 5918
;5917:	}
;5918:	return qtrue;
CNSTI4 1
RETI4
LABELV $2551
endproc ItemParse_mouseEnterText 4 8
export ItemParse_mouseExitText
proc ItemParse_mouseExitText 4 8
line 5921
;5919:}
;5920:
;5921:qboolean ItemParse_mouseExitText( itemDef_t *item, int handle ) {
line 5922
;5922:	if (!PC_Script_Parse(handle, &item->mouseExitText)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2555
line 5923
;5923:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2554
JUMPV
LABELV $2555
line 5925
;5924:	}
;5925:	return qtrue;
CNSTI4 1
RETI4
LABELV $2554
endproc ItemParse_mouseExitText 4 8
export ItemParse_action
proc ItemParse_action 4 8
line 5928
;5926:}
;5927:
;5928:qboolean ItemParse_action( itemDef_t *item, int handle ) {
line 5929
;5929:	if (!PC_Script_Parse(handle, &item->action)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2558
line 5930
;5930:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2557
JUMPV
LABELV $2558
line 5932
;5931:	}
;5932:	return qtrue;
CNSTI4 1
RETI4
LABELV $2557
endproc ItemParse_action 4 8
export ItemParse_special
proc ItemParse_special 4 8
line 5935
;5933:}
;5934:
;5935:qboolean ItemParse_special( itemDef_t *item, int handle ) {
line 5936
;5936:	if (!PC_Float_Parse(handle, &item->special)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2561
line 5937
;5937:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2560
JUMPV
LABELV $2561
line 5939
;5938:	}
;5939:	return qtrue;
CNSTI4 1
RETI4
LABELV $2560
endproc ItemParse_special 4 8
export ItemParse_cvarTest
proc ItemParse_cvarTest 4 8
line 5942
;5940:}
;5941:
;5942:qboolean ItemParse_cvarTest( itemDef_t *item, int handle ) {
line 5943
;5943:	if (!PC_String_Parse(handle, &item->cvarTest)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2564
line 5944
;5944:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2563
JUMPV
LABELV $2564
line 5946
;5945:	}
;5946:	return qtrue;
CNSTI4 1
RETI4
LABELV $2563
endproc ItemParse_cvarTest 4 8
export ItemParse_cvar
proc ItemParse_cvar 24 8
line 5950
;5947:}
;5948:
;5949:qboolean ItemParse_cvar( itemDef_t *item, int handle ) 
;5950:{
line 5951
;5951:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5952
;5952:	if (!PC_String_Parse(handle, &item->cvar)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2567
line 5953
;5953:	{
line 5954
;5954:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2566
JUMPV
LABELV $2567
line 5957
;5955:	}
;5956:
;5957:	if ( item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2569
line 5958
;5958:	{
line 5961
;5959:		editFieldDef_t *editPtr;
;5960:
;5961:		switch ( item->type )
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $2574
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $2571
LABELV $2575
ADDRLP4 8
INDIRI4
CNSTI4 4
LTI4 $2571
ADDRLP4 8
INDIRI4
CNSTI4 13
GTI4 $2571
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2576-16
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2576
address $2574
address $2571
address $2571
address $2571
address $2571
address $2574
address $2574
address $2574
address $2571
address $2574
code
line 5962
;5962:		{
LABELV $2574
line 5969
;5963:			case ITEM_TYPE_EDITFIELD:
;5964:			case ITEM_TYPE_NUMERICFIELD:
;5965:			case ITEM_TYPE_YESNO:
;5966:			case ITEM_TYPE_BIND:
;5967:			case ITEM_TYPE_SLIDER:
;5968:			case ITEM_TYPE_TEXT:
;5969:				editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 5970
;5970:				editPtr->minVal = -1;
ADDRLP4 4
INDIRP4
CNSTF4 3212836864
ASGNF4
line 5971
;5971:				editPtr->maxVal = -1;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 3212836864
ASGNF4
line 5972
;5972:				editPtr->defVal = -1;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 3212836864
ASGNF4
line 5973
;5973:				break;
LABELV $2571
LABELV $2572
line 5975
;5974:		}
;5975:	}
LABELV $2569
line 5976
;5976:	return qtrue;
CNSTI4 1
RETI4
LABELV $2566
endproc ItemParse_cvar 24 8
export ItemParse_font
proc ItemParse_font 4 8
line 5980
;5977:}
;5978:
;5979:qboolean ItemParse_font( itemDef_t *item, int handle ) 
;5980:{
line 5981
;5981:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5982
;5982:	if (!PC_Int_Parse(handle, &item->iMenuFont)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2579
line 5983
;5983:	{
line 5984
;5984:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2578
JUMPV
LABELV $2579
line 5986
;5985:	}
;5986:	return qtrue;
CNSTI4 1
RETI4
LABELV $2578
endproc ItemParse_font 4 8
export ItemParse_maxChars
proc ItemParse_maxChars 12 8
line 5990
;5987:}
;5988:
;5989:
;5990:qboolean ItemParse_maxChars( itemDef_t *item, int handle ) {
line 5994
;5991:	editFieldDef_t *editPtr;
;5992:	int maxChars;
;5993:
;5994:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5995
;5995:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2582
line 5996
;5996:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2581
JUMPV
LABELV $2582
line 5998
;5997:
;5998:	if (!PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2584
line 5999
;5999:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2581
JUMPV
LABELV $2584
line 6001
;6000:	}
;6001:	editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 6002
;6002:	editPtr->maxChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 6003
;6003:	return qtrue;
CNSTI4 1
RETI4
LABELV $2581
endproc ItemParse_maxChars 12 8
export ItemParse_maxPaintChars
proc ItemParse_maxPaintChars 12 8
line 6006
;6004:}
;6005:
;6006:qboolean ItemParse_maxPaintChars( itemDef_t *item, int handle ) {
line 6010
;6007:	editFieldDef_t *editPtr;
;6008:	int maxChars;
;6009:
;6010:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6011
;6011:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2587
line 6012
;6012:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2586
JUMPV
LABELV $2587
line 6014
;6013:
;6014:	if (!PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2589
line 6015
;6015:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2586
JUMPV
LABELV $2589
line 6017
;6016:	}
;6017:	editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 6018
;6018:	editPtr->maxPaintChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 6019
;6019:	return qtrue;
CNSTI4 1
RETI4
LABELV $2586
endproc ItemParse_maxPaintChars 12 8
export ItemParse_maxLineChars
proc ItemParse_maxLineChars 12 8
line 6023
;6020:}
;6021:
;6022:qboolean ItemParse_maxLineChars( itemDef_t *item, int handle ) 
;6023:{
line 6027
;6024:	textScrollDef_t *scrollPtr;
;6025:	int				maxChars;
;6026:
;6027:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6028
;6028:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2592
line 6029
;6029:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2591
JUMPV
LABELV $2592
line 6031
;6030:
;6031:	if (!PC_Int_Parse(handle, &maxChars)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2594
line 6032
;6032:	{
line 6033
;6033:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2591
JUMPV
LABELV $2594
line 6036
;6034:	}
;6035:
;6036:	scrollPtr = (textScrollDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 6037
;6037:	scrollPtr->maxLineChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 6039
;6038:
;6039:	return qtrue;
CNSTI4 1
RETI4
LABELV $2591
endproc ItemParse_maxLineChars 12 8
export ItemParse_lineHeight
proc ItemParse_lineHeight 12 8
line 6043
;6040:}
;6041:
;6042:qboolean ItemParse_lineHeight( itemDef_t *item, int handle ) 
;6043:{
line 6047
;6044:	textScrollDef_t *scrollPtr;
;6045:	int				height;
;6046:
;6047:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6048
;6048:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2597
line 6049
;6049:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2596
JUMPV
LABELV $2597
line 6051
;6050:
;6051:	if (!PC_Int_Parse(handle, &height)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2599
line 6052
;6052:	{
line 6053
;6053:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2596
JUMPV
LABELV $2599
line 6056
;6054:	}
;6055:
;6056:	scrollPtr = (textScrollDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 6057
;6057:	scrollPtr->lineHeight = height;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRI4
CVIF4 4
ASGNF4
line 6059
;6058:
;6059:	return qtrue;
CNSTI4 1
RETI4
LABELV $2596
endproc ItemParse_lineHeight 12 8
export ItemParse_cvarFloat
proc ItemParse_cvarFloat 20 8
line 6062
;6060:}
;6061:
;6062:qboolean ItemParse_cvarFloat( itemDef_t *item, int handle ) {
line 6065
;6063:	editFieldDef_t *editPtr;
;6064:
;6065:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6066
;6066:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2602
line 6067
;6067:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2601
JUMPV
LABELV $2602
line 6068
;6068:	editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 6069
;6069:	if (PC_String_Parse(handle, &item->cvar) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2604
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2604
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2604
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $2604
line 6072
;6070:		PC_Float_Parse(handle, &editPtr->defVal) &&
;6071:		PC_Float_Parse(handle, &editPtr->minVal) &&
;6072:		PC_Float_Parse(handle, &editPtr->maxVal)) {
line 6073
;6073:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2601
JUMPV
LABELV $2604
line 6075
;6074:	}
;6075:	return qfalse;
CNSTI4 0
RETI4
LABELV $2601
endproc ItemParse_cvarFloat 20 8
export ItemParse_cvarStrList
proc ItemParse_cvarStrList 1068 8
line 6078
;6076:}
;6077:
;6078:qboolean ItemParse_cvarStrList( itemDef_t *item, int handle ) {
line 6083
;6079:	pc_token_t token;
;6080:	multiDef_t *multiPtr;
;6081:	int pass;
;6082:	
;6083:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6084
;6084:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2607
line 6085
;6085:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2606
JUMPV
LABELV $2607
line 6086
;6086:	multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 6087
;6087:	multiPtr->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 6088
;6088:	multiPtr->strDef = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 1
ASGNI4
line 6090
;6089:
;6090:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2609
line 6091
;6091:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2606
JUMPV
LABELV $2609
line 6092
;6092:	if (*token.string != '{') {
ADDRLP4 8+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2611
line 6093
;6093:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2606
JUMPV
LABELV $2611
line 6096
;6094:	}
;6095:
;6096:	pass = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2615
JUMPV
LABELV $2614
line 6097
;6097:	while ( 1 ) {
line 6104
;6098:		char* psString;
;6099:
;6100://		if (!trap_PC_ReadToken(handle, &token)) {
;6101://			PC_SourceError(handle, "end of file inside menu item\n");
;6102://			return qfalse;
;6103://		}		   
;6104:		if (!PC_String_Parse(handle, (const char **)&psString)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 1052
ARGP4
ADDRLP4 1056
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2617
line 6105
;6105:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2619
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 6106
;6106:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2606
JUMPV
LABELV $2617
line 6110
;6107:		}
;6108:
;6109:		//a normal StringAlloc ptr
;6110:		if ((int)psString > 0)	
ADDRLP4 1052
INDIRP4
CVPU4 4
CVUI4 4
CNSTI4 0
LEI4 $2620
line 6111
;6111:		{
line 6112
;6112:			if (*psString == '}') {
ADDRLP4 1052
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2622
line 6113
;6113:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2606
JUMPV
LABELV $2622
line 6116
;6114:			}
;6115:
;6116:			if (*psString == ',' || *psString == ';') {
ADDRLP4 1060
ADDRLP4 1052
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 44
EQI4 $2626
ADDRLP4 1060
INDIRI4
CNSTI4 59
NEI4 $2624
LABELV $2626
line 6117
;6117:				continue;
ADDRGP4 $2615
JUMPV
LABELV $2624
line 6119
;6118:			}
;6119:		}
LABELV $2620
line 6121
;6120:
;6121:		if (pass == 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2627
line 6122
;6122:			multiPtr->cvarList[multiPtr->count] = psString;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
ADDRLP4 1052
INDIRP4
ASGNP4
line 6123
;6123:			pass = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 6124
;6124:		} else {
ADDRGP4 $2628
JUMPV
LABELV $2627
line 6125
;6125:			multiPtr->cvarStr[multiPtr->count] = psString;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 1052
INDIRP4
ASGNP4
line 6126
;6126:			pass = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 6127
;6127:			multiPtr->count++;
ADDRLP4 1064
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1064
INDIRP4
ADDRLP4 1064
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6128
;6128:			if (multiPtr->count >= MAX_MULTI_CVARS) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2629
line 6129
;6129:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2606
JUMPV
LABELV $2629
line 6131
;6130:			}
;6131:		}
LABELV $2628
line 6133
;6132:
;6133:	}
LABELV $2615
line 6097
ADDRGP4 $2614
JUMPV
line 6134
;6134:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2606
endproc ItemParse_cvarStrList 1068 8
export ItemParse_cvarFloatList
proc ItemParse_cvarFloatList 1072 8
line 6138
;6135:}
;6136:
;6137:qboolean ItemParse_cvarFloatList( itemDef_t *item, int handle ) 
;6138:{
line 6142
;6139:	pc_token_t token;
;6140:	multiDef_t *multiPtr;
;6141:	
;6142:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6143
;6143:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2632
line 6144
;6144:	{
line 6145
;6145:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2631
JUMPV
LABELV $2632
line 6148
;6146:	}
;6147:	
;6148:	multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 6149
;6149:	multiPtr->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 6150
;6150:	multiPtr->strDef = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 0
ASGNI4
line 6152
;6151:
;6152:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2634
line 6153
;6153:	{
line 6154
;6154:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2631
JUMPV
LABELV $2634
line 6157
;6155:	}
;6156:	
;6157:	if (*token.string != '{') 
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2640
line 6158
;6158:	{
line 6159
;6159:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2631
JUMPV
LABELV $2639
line 6163
;6160:	}
;6161:
;6162:	while ( 1 ) 
;6163:	{
line 6166
;6164:		char* string;
;6165:
;6166:		if ( !PC_String_Parse ( handle, (const char **)&string ) )
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 1048
ARGP4
ADDRLP4 1052
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $2642
line 6167
;6167:		{
line 6168
;6168:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2619
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 6169
;6169:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2631
JUMPV
LABELV $2642
line 6173
;6170:		}
;6171:			
;6172:		//a normal StringAlloc ptr
;6173:		if ((int)string > 0)	
ADDRLP4 1048
INDIRP4
CVPU4 4
CVUI4 4
CNSTI4 0
LEI4 $2644
line 6174
;6174:		{
line 6175
;6175:			if (*string == '}') 
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2646
line 6176
;6176:			{
line 6177
;6177:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2631
JUMPV
LABELV $2646
line 6180
;6178:			}
;6179:
;6180:			if (*string == ',' || *string == ';') 
ADDRLP4 1056
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 44
EQI4 $2650
ADDRLP4 1056
INDIRI4
CNSTI4 59
NEI4 $2648
LABELV $2650
line 6181
;6181:			{
line 6182
;6182:				continue;
ADDRGP4 $2640
JUMPV
LABELV $2648
line 6184
;6183:			}
;6184:		}
LABELV $2644
line 6186
;6185:
;6186:		multiPtr->cvarList[multiPtr->count] = string;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
ADDRLP4 1048
INDIRP4
ASGNP4
line 6187
;6187:		if (!PC_Float_Parse(handle, &multiPtr->cvarValue[multiPtr->count])) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
ARGP4
ADDRLP4 1064
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2651
line 6188
;6188:		{
line 6189
;6189:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2631
JUMPV
LABELV $2651
line 6192
;6190:		}
;6191:
;6192:		multiPtr->count++;
ADDRLP4 1068
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1068
INDIRP4
ADDRLP4 1068
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6193
;6193:		if (multiPtr->count >= MAX_MULTI_CVARS) 
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2653
line 6194
;6194:		{
line 6195
;6195:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2631
JUMPV
LABELV $2653
line 6198
;6196:		}
;6197:
;6198:	}
LABELV $2640
line 6162
ADDRGP4 $2639
JUMPV
line 6199
;6199:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2631
endproc ItemParse_cvarFloatList 1072 8
export ItemParse_addColorRange
proc ItemParse_addColorRange 48 12
line 6204
;6200:}
;6201:
;6202:
;6203:
;6204:qboolean ItemParse_addColorRange( itemDef_t *item, int handle ) {
line 6207
;6205:	colorRangeDef_t color;
;6206:
;6207:	if (PC_Float_Parse(handle, &color.low) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0+16
ARGP4
ADDRLP4 24
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2656
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0+20
ARGP4
ADDRLP4 28
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2656
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2656
line 6209
;6208:		PC_Float_Parse(handle, &color.high) &&
;6209:		PC_Color_Parse(handle, &color.color) ) {
line 6210
;6210:		if (item->numColors < MAX_COLOR_RANGES) {
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 10
GEI4 $2660
line 6211
;6211:			memcpy(&item->colorRanges[item->numColors], &color, sizeof(color));
ADDRLP4 36
CNSTI4 24
ASGNI4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
MULI4
ADDRLP4 40
INDIRP4
CNSTI4 300
ADDP4
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 6212
;6212:			item->numColors++;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6213
;6213:		}
LABELV $2660
line 6214
;6214:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2655
JUMPV
LABELV $2656
line 6216
;6215:	}
;6216:	return qfalse;
CNSTI4 0
RETI4
LABELV $2655
endproc ItemParse_addColorRange 48 12
export ItemParse_ownerdrawFlag
proc ItemParse_ownerdrawFlag 12 8
line 6219
;6217:}
;6218:
;6219:qboolean ItemParse_ownerdrawFlag( itemDef_t *item, int handle ) {
line 6221
;6220:	int i;
;6221:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2663
line 6222
;6222:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2662
JUMPV
LABELV $2663
line 6224
;6223:	}
;6224:	item->window.ownerDrawFlags |= i;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 6225
;6225:	return qtrue;
CNSTI4 1
RETI4
LABELV $2662
endproc ItemParse_ownerdrawFlag 12 8
export ItemParse_enableCvar
proc ItemParse_enableCvar 4 8
line 6228
;6226:}
;6227:
;6228:qboolean ItemParse_enableCvar( itemDef_t *item, int handle ) {
line 6229
;6229:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2666
line 6230
;6230:		item->cvarFlags = CVAR_ENABLE;
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
CNSTI4 1
ASGNI4
line 6231
;6231:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2665
JUMPV
LABELV $2666
line 6233
;6232:	}
;6233:	return qfalse;
CNSTI4 0
RETI4
LABELV $2665
endproc ItemParse_enableCvar 4 8
export ItemParse_disableCvar
proc ItemParse_disableCvar 4 8
line 6236
;6234:}
;6235:
;6236:qboolean ItemParse_disableCvar( itemDef_t *item, int handle ) {
line 6237
;6237:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2669
line 6238
;6238:		item->cvarFlags = CVAR_DISABLE;
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
CNSTI4 2
ASGNI4
line 6239
;6239:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2668
JUMPV
LABELV $2669
line 6241
;6240:	}
;6241:	return qfalse;
CNSTI4 0
RETI4
LABELV $2668
endproc ItemParse_disableCvar 4 8
export ItemParse_showCvar
proc ItemParse_showCvar 4 8
line 6244
;6242:}
;6243:
;6244:qboolean ItemParse_showCvar( itemDef_t *item, int handle ) {
line 6245
;6245:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2672
line 6246
;6246:		item->cvarFlags = CVAR_SHOW;
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
CNSTI4 4
ASGNI4
line 6247
;6247:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2671
JUMPV
LABELV $2672
line 6249
;6248:	}
;6249:	return qfalse;
CNSTI4 0
RETI4
LABELV $2671
endproc ItemParse_showCvar 4 8
export ItemParse_hideCvar
proc ItemParse_hideCvar 4 8
line 6252
;6250:}
;6251:
;6252:qboolean ItemParse_hideCvar( itemDef_t *item, int handle ) {
line 6253
;6253:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2675
line 6254
;6254:		item->cvarFlags = CVAR_HIDE;
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
CNSTI4 8
ASGNI4
line 6255
;6255:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2674
JUMPV
LABELV $2675
line 6257
;6256:	}
;6257:	return qfalse;
CNSTI4 0
RETI4
LABELV $2674
endproc ItemParse_hideCvar 4 8
export ItemParse_Appearance_slot
proc ItemParse_Appearance_slot 4 8
line 6266
;6258:}
;6259:
;6260:/*
;6261:===============
;6262:ItemParse_align 
;6263:===============
;6264:*/
;6265:qboolean ItemParse_Appearance_slot( itemDef_t *item, int handle ) 
;6266:{
line 6267
;6267:	if (!PC_Int_Parse(handle, &item->appearanceSlot))
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2678
line 6268
;6268:	{
line 6269
;6269:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2677
JUMPV
LABELV $2678
line 6271
;6270:	}
;6271:	return qtrue;
CNSTI4 1
RETI4
LABELV $2677
endproc ItemParse_Appearance_slot 4 8
data
export itemParseKeywords
align 4
LABELV itemParseKeywords
address $2680
address ItemParse_action
byte 4 0
address $2681
address ItemParse_addColorRange
byte 4 0
address $2682
address ItemParse_align
byte 4 0
address $2683
address ItemParse_autowrapped
byte 4 0
address $2684
address ItemParse_Appearance_slot
byte 4 0
address $2685
address ItemParse_asset_model
byte 4 0
address $2686
address ItemParse_asset_shader
byte 4 0
address $422
address ItemParse_backcolor
byte 4 0
address $2687
address ItemParse_background
byte 4 0
address $2688
address ItemParse_border
byte 4 0
address $428
address ItemParse_bordercolor
byte 4 0
address $2689
address ItemParse_bordersize
byte 4 0
address $2690
address ItemParse_cinematic
byte 4 0
address $2691
address ItemParse_columns
byte 4 0
address $2692
address ItemParse_cvar
byte 4 0
address $2693
address ItemParse_cvarFloat
byte 4 0
address $2694
address ItemParse_cvarFloatList
byte 4 0
address $2695
address ItemParse_cvarStrList
byte 4 0
address $2696
address ItemParse_cvarTest
byte 4 0
address $2697
address ItemParse_descText
byte 4 0
address $2698
address ItemParse_decoration
byte 4 0
address $2699
address ItemParse_disableCvar
byte 4 0
address $2700
address ItemParse_doubleClick
byte 4 0
address $2701
address ItemParse_elementheight
byte 4 0
address $2702
address ItemParse_elementtype
byte 4 0
address $2703
address ItemParse_elementwidth
byte 4 0
address $2704
address ItemParse_enableCvar
byte 4 0
address $2705
address ItemParse_feeder
byte 4 0
address $2706
address ItemParse_flag
byte 4 0
address $2707
address ItemParse_focusSound
byte 4 0
address $2708
address ItemParse_font
byte 4 0
address $425
address ItemParse_forecolor
byte 4 0
address $2709
address ItemParse_group
byte 4 0
address $2710
address ItemParse_hideCvar
byte 4 0
address $2711
address ItemParse_horizontalscroll
byte 4 0
address $2712
address ItemParse_leaveFocus
byte 4 0
address $2713
address ItemParse_maxChars
byte 4 0
address $2714
address ItemParse_maxPaintChars
byte 4 0
address $2715
address ItemParse_model_angle
byte 4 0
address $2716
address ItemParse_model_fovx
byte 4 0
address $2717
address ItemParse_model_fovy
byte 4 0
address $2718
address ItemParse_model_origin
byte 4 0
address $2719
address ItemParse_model_rotation
byte 4 0
address $2720
address ItemParse_mouseEnter
byte 4 0
address $2721
address ItemParse_mouseEnterText
byte 4 0
address $2722
address ItemParse_mouseExit
byte 4 0
address $2723
address ItemParse_mouseExitText
byte 4 0
address $2724
address ItemParse_name
byte 4 0
address $2725
address ItemParse_notselectable
byte 4 0
address $2726
address ItemParse_onFocus
byte 4 0
address $2727
address ItemParse_outlinecolor
byte 4 0
address $2728
address ItemParse_ownerdraw
byte 4 0
address $2729
address ItemParse_ownerdrawFlag
byte 4 0
address $2730
address ItemParse_rect
byte 4 0
address $2731
address ItemParse_showCvar
byte 4 0
address $2732
address ItemParse_special
byte 4 0
address $2733
address ItemParse_style
byte 4 0
address $2734
address ItemParse_text
byte 4 0
address $2735
address ItemParse_textalign
byte 4 0
address $2736
address ItemParse_textalignx
byte 4 0
address $2737
address ItemParse_textaligny
byte 4 0
address $2738
address ItemParse_textscale
byte 4 0
address $2739
address ItemParse_textstyle
byte 4 0
address $2740
address ItemParse_text2
byte 4 0
address $2741
address ItemParse_text2alignx
byte 4 0
address $2742
address ItemParse_text2aligny
byte 4 0
address $2743
address ItemParse_type
byte 4 0
address $2744
address ItemParse_visible
byte 4 0
address $2745
address ItemParse_wrapped
byte 4 0
address $2746
address ItemParse_maxLineChars
byte 4 0
address $2747
address ItemParse_lineHeight
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export Item_SetupKeywordHash
code
proc Item_SetupKeywordHash 4 12
line 6360
;6272:}
;6273:
;6274:
;6275:keywordHash_t itemParseKeywords[] = {
;6276:	{"action",			ItemParse_action,			NULL	},
;6277:	{"addColorRange",	ItemParse_addColorRange,	NULL	},
;6278:	{"align",			ItemParse_align,			NULL	},
;6279:	{"autowrapped",		ItemParse_autowrapped,		NULL	},
;6280:	{"appearance_slot",	ItemParse_Appearance_slot,	NULL	},
;6281:	{"asset_model",		ItemParse_asset_model,		NULL	},
;6282:	{"asset_shader",	ItemParse_asset_shader,		NULL	},
;6283:	{"backcolor",		ItemParse_backcolor,		NULL	},
;6284:	{"background",		ItemParse_background,		NULL	},
;6285:	{"border",			ItemParse_border,			NULL	},
;6286:	{"bordercolor",		ItemParse_bordercolor,		NULL	},
;6287:	{"bordersize",		ItemParse_bordersize,		NULL	},
;6288:	{"cinematic",		ItemParse_cinematic,		NULL	},
;6289:	{"columns",			ItemParse_columns,			NULL	},
;6290:	{"cvar",			ItemParse_cvar,				NULL	},
;6291:	{"cvarFloat",		ItemParse_cvarFloat,		NULL	},
;6292:	{"cvarFloatList",	ItemParse_cvarFloatList,	NULL	},
;6293:	{"cvarStrList",		ItemParse_cvarStrList,		NULL	},
;6294:	{"cvarTest",		ItemParse_cvarTest,			NULL	},
;6295:	{"desctext",		ItemParse_descText,			NULL	},
;6296:	{"decoration",		ItemParse_decoration,		NULL	},
;6297:	{"disableCvar",		ItemParse_disableCvar,		NULL	},
;6298:	{"doubleclick",		ItemParse_doubleClick,		NULL	},
;6299:	{"elementheight",	ItemParse_elementheight,	NULL	},
;6300:	{"elementtype",		ItemParse_elementtype,		NULL	},
;6301:	{"elementwidth",	ItemParse_elementwidth,		NULL	},
;6302:	{"enableCvar",		ItemParse_enableCvar,		NULL	},
;6303:	{"feeder",			ItemParse_feeder,			NULL	},
;6304:	{"flag",			ItemParse_flag,				NULL	},
;6305:	{"focusSound",		ItemParse_focusSound,		NULL	},
;6306:	{"font",			ItemParse_font,				NULL	},
;6307:	{"forecolor",		ItemParse_forecolor,		NULL	},
;6308:	{"group",			ItemParse_group,			NULL	},
;6309:	{"hideCvar",		ItemParse_hideCvar,			NULL	},
;6310:	{"horizontalscroll", ItemParse_horizontalscroll, NULL	},
;6311:	{"leaveFocus",		ItemParse_leaveFocus,		NULL	},
;6312:	{"maxChars",		ItemParse_maxChars,			NULL	},
;6313:	{"maxPaintChars",	ItemParse_maxPaintChars,	NULL	},
;6314:	{"model_angle",		ItemParse_model_angle,		NULL	},
;6315:	{"model_fovx",		ItemParse_model_fovx,		NULL	},
;6316:	{"model_fovy",		ItemParse_model_fovy,		NULL	},
;6317:	{"model_origin",	ItemParse_model_origin,		NULL	},
;6318:	{"model_rotation",	ItemParse_model_rotation,	NULL	},
;6319:	{"mouseEnter",		ItemParse_mouseEnter,		NULL	},
;6320:	{"mouseEnterText",	ItemParse_mouseEnterText,	NULL	},
;6321:	{"mouseExit",		ItemParse_mouseExit,		NULL	},
;6322:	{"mouseExitText",	ItemParse_mouseExitText,	NULL	},
;6323:	{"name",			ItemParse_name,				NULL	},
;6324:	{"notselectable",	ItemParse_notselectable,	NULL	},
;6325:	{"onFocus",			ItemParse_onFocus,			NULL	},
;6326:	{"outlinecolor",	ItemParse_outlinecolor,		NULL	},
;6327:	{"ownerdraw",		ItemParse_ownerdraw,		NULL	},
;6328:	{"ownerdrawFlag",	ItemParse_ownerdrawFlag,	NULL	},
;6329:	{"rect",			ItemParse_rect,				NULL	},
;6330:	{"showCvar",		ItemParse_showCvar,			NULL	},
;6331:	{"special",			ItemParse_special,			NULL	},
;6332:	{"style",			ItemParse_style,			NULL	},
;6333:	{"text",			ItemParse_text,				NULL	},
;6334:	{"textalign",		ItemParse_textalign,		NULL	},
;6335:	{"textalignx",		ItemParse_textalignx,		NULL	},
;6336:	{"textaligny",		ItemParse_textaligny,		NULL	},
;6337:	{"textscale",		ItemParse_textscale,		NULL	},
;6338:	{"textstyle",		ItemParse_textstyle,		NULL	},
;6339:	{"text2",			ItemParse_text2,			NULL	},
;6340:	{"text2alignx",		ItemParse_text2alignx,		NULL	},
;6341:	{"text2aligny",		ItemParse_text2aligny,		NULL	},
;6342:	{"type",			ItemParse_type,				NULL	},
;6343:	{"visible",			ItemParse_visible,			NULL	},
;6344:	{"wrapped",			ItemParse_wrapped,			NULL	},
;6345:
;6346:	// Text scroll specific
;6347:	{"maxLineChars",	ItemParse_maxLineChars,		NULL	},
;6348:	{"lineHeight",		ItemParse_lineHeight,		NULL	},
;6349:
;6350:	{0,					0,							0		}
;6351:};
;6352:
;6353:keywordHash_t *itemParseKeywordHash[KEYWORDHASH_SIZE];
;6354:
;6355:/*
;6356:===============
;6357:Item_SetupKeywordHash
;6358:===============
;6359:*/
;6360:void Item_SetupKeywordHash(void) {
line 6363
;6361:	int i;
;6362:
;6363:	memset(itemParseKeywordHash, 0, sizeof(itemParseKeywordHash));
ADDRGP4 itemParseKeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 6364
;6364:	for (i = 0; itemParseKeywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2752
JUMPV
LABELV $2749
line 6365
;6365:		KeywordHash_Add(itemParseKeywordHash, &itemParseKeywords[i]);
ADDRGP4 itemParseKeywordHash
ARGP4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 itemParseKeywords
ADDP4
ARGP4
ADDRGP4 KeywordHash_Add
CALLV
pop
line 6366
;6366:	}
LABELV $2750
line 6364
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2752
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 itemParseKeywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2749
line 6367
;6367:}
LABELV $2748
endproc Item_SetupKeywordHash 4 12
export Item_Parse
proc Item_Parse 1060 12
line 6374
;6368:
;6369:/*
;6370:===============
;6371:Item_Parse
;6372:===============
;6373:*/
;6374:qboolean Item_Parse(int handle, itemDef_t *item) {
line 6379
;6375:	pc_token_t token;
;6376:	keywordHash_t *key;
;6377:
;6378:
;6379:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2754
line 6380
;6380:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2753
JUMPV
LABELV $2754
line 6381
;6381:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2760
line 6382
;6382:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2753
JUMPV
LABELV $2759
line 6384
;6383:	}
;6384:	while ( 1 ) {
line 6385
;6385:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2762
line 6386
;6386:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2619
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 6387
;6387:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2753
JUMPV
LABELV $2762
line 6390
;6388:		}
;6389:
;6390:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2764
line 6391
;6391:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2753
JUMPV
LABELV $2764
line 6394
;6392:		}
;6393:
;6394:		key = KeywordHash_Find(itemParseKeywordHash, token.string);
ADDRGP4 itemParseKeywordHash
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 1052
ADDRGP4 KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1052
INDIRP4
ASGNP4
line 6395
;6395:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2768
line 6396
;6396:			PC_SourceError(handle, "unknown menu item keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2770
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 6397
;6397:			continue;
ADDRGP4 $2760
JUMPV
LABELV $2768
line 6399
;6398:		}
;6399:		if ( !key->func(item, handle) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRLP4 1040
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2772
line 6400
;6400:			PC_SourceError(handle, "couldn't parse menu item keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2774
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 6401
;6401:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2753
JUMPV
LABELV $2772
line 6403
;6402:		}
;6403:	}
LABELV $2760
line 6384
ADDRGP4 $2759
JUMPV
line 6404
;6404:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2753
endproc Item_Parse 1060 12
proc Item_TextScroll_BuildLines 56 12
line 6408
;6405:}
;6406:
;6407:static void Item_TextScroll_BuildLines ( itemDef_t* item )
;6408:{
line 6409
;6409:	textScrollDef_t* scrollPtr = (textScrollDef_t*) item->typeData;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 6416
;6410:	int				 width;
;6411:	char*			 lineStart;
;6412:	char*			 lineEnd;
;6413:	float			 w;
;6414:	float			 cw;
;6415:
;6416:	scrollPtr->lineCount = 0;
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 6417
;6417:	width = scrollPtr->maxLineChars;
ADDRLP4 20
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 6418
;6418:	lineStart = (char*)item->text;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 6419
;6419:	lineEnd   = lineStart;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 6420
;6420:	w		  = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRGP4 $2778
JUMPV
LABELV $2777
line 6424
;6421:
;6422:	// Keep going as long as there are more lines
;6423:	while ( scrollPtr->lineCount < MAX_TEXTSCROLL_LINES )
;6424:	{
line 6426
;6425:		// End of the road
;6426:		if ( *lineEnd == '\0')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2780
line 6427
;6427:		{
line 6428
;6428:			if ( lineStart < lineEnd )
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
GEU4 $2779
line 6429
;6429:			{
line 6430
;6430:				scrollPtr->lines[ scrollPtr->lineCount++ ] = lineStart;
ADDRLP4 28
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 28
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRP4
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 6431
;6431:			}
line 6433
;6432:
;6433:			break;
ADDRGP4 $2779
JUMPV
LABELV $2780
line 6437
;6434:		}
;6435:
;6436:		// Force a line end if its a '\n'
;6437:		else if ( *lineEnd == '\n' )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $2784
line 6438
;6438:		{
line 6439
;6439:			*lineEnd = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 6440
;6440:			scrollPtr->lines[ scrollPtr->lineCount++ ] = lineStart;
ADDRLP4 28
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 28
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRP4
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 6441
;6441:			lineStart = lineEnd + 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6442
;6442:			lineEnd   = lineStart;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 6443
;6443:			w = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 6444
;6444:			continue;
ADDRGP4 $2778
JUMPV
LABELV $2784
line 6448
;6445:		}
;6446:
;6447:		// Get the current character width 
;6448:		cw = DC->textWidth ( va("%c", *lineEnd), item->textscale, item->iMenuFont );
ADDRGP4 $2786
ARGP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 32
INDIRI4
CVIF4 4
ASGNF4
line 6451
;6449:
;6450:		// Past the end of the boundary?
;6451:		if ( w + cw > (item->window.rect.w - SCROLLBAR_SIZE - 10) )
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1092616192
SUBF4
LEF4 $2787
line 6452
;6452:		{
ADDRGP4 $2790
JUMPV
LABELV $2789
line 6455
;6453:			// Past the end so backtrack to the word boundary
;6454:			while ( *lineEnd != ' ' && *lineEnd != '\t' && lineEnd > lineStart )
;6455:			{
line 6456
;6456:				lineEnd--;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 -1
ADDP4
ASGNP4
line 6457
;6457:			}					
LABELV $2790
line 6454
ADDRLP4 40
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 32
EQI4 $2793
ADDRLP4 40
INDIRI4
CNSTI4 9
EQI4 $2793
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
GTU4 $2789
LABELV $2793
line 6459
;6458:
;6459:			*lineEnd = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 6460
;6460:			scrollPtr->lines[ scrollPtr->lineCount++ ] = lineStart;
ADDRLP4 48
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 44
ADDRLP4 48
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRP4
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 6463
;6461:
;6462:			// Skip any whitespaces
;6463:			lineEnd++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $2795
JUMPV
LABELV $2794
line 6465
;6464:			while ( (*lineEnd == ' ' || *lineEnd == '\t') && *lineEnd )
;6465:			{
line 6466
;6466:				lineEnd++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6467
;6467:			}
LABELV $2795
line 6464
ADDRLP4 52
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 32
EQI4 $2798
ADDRLP4 52
INDIRI4
CNSTI4 9
NEI4 $2797
LABELV $2798
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2794
LABELV $2797
line 6469
;6468:
;6469:			lineStart = lineEnd;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 6470
;6470:			w = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 6471
;6471:		}
ADDRGP4 $2788
JUMPV
LABELV $2787
line 6473
;6472:		else
;6473:		{
line 6474
;6474:			w += cw;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
line 6475
;6475:			lineEnd++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6476
;6476:		}
LABELV $2788
line 6477
;6477:	}
LABELV $2778
line 6423
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 256
LTI4 $2777
LABELV $2779
line 6478
;6478:}
LABELV $2776
endproc Item_TextScroll_BuildLines 56 12
export Item_InitControls
proc Item_InitControls 8 0
line 6483
;6479:
;6480:// Item_InitControls
;6481:// init's special control types
;6482:void Item_InitControls(itemDef_t *item) 
;6483:{
line 6484
;6484:	if (item == NULL) 
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2800
line 6485
;6485:	{
line 6486
;6486:		return;
ADDRGP4 $2799
JUMPV
LABELV $2800
line 6489
;6487:	}
;6488:
;6489:	switch ( item->type )
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
EQI4 $2805
ADDRGP4 $2802
JUMPV
line 6490
;6490:	{
LABELV $2805
line 6492
;6491:		case ITEM_TYPE_LISTBOX:
;6492:		{
line 6493
;6493:			listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRP4
ASGNP4
line 6494
;6494:			item->cursorPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
line 6495
;6495:			if (listPtr) 
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2803
line 6496
;6496:			{
line 6497
;6497:				listPtr->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 6498
;6498:				listPtr->startPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 6499
;6499:				listPtr->endPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 6500
;6500:				listPtr->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 6501
;6501:			}
line 6503
;6502:
;6503:			break;
LABELV $2802
LABELV $2803
line 6506
;6504:		}
;6505:	}
;6506:}
LABELV $2799
endproc Item_InitControls 8 0
export MenuParse_font
proc MenuParse_font 16 8
line 6514
;6507:
;6508:/*
;6509:===============
;6510:Menu Keyword Parse functions
;6511:===============
;6512:*/
;6513:
;6514:qboolean MenuParse_font( itemDef_t *item, int handle ) {
line 6515
;6515:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6516
;6516:	if (!PC_String_Parse(handle, &menu->font)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2809
line 6517
;6517:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2808
JUMPV
LABELV $2809
line 6519
;6518:	}
;6519:	if (!DC->Assets.fontRegistered) {
ADDRGP4 DC
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2811
line 6521
;6520:		//DC->registerFont(menu->font, 48, &DC->Assets.textFont);
;6521:		DC->Assets.qhMediumFont = DC->RegisterFont(menu->font);
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 268
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 6522
;6522:		DC->Assets.fontRegistered = qtrue;
ADDRGP4 DC
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 1
ASGNI4
line 6523
;6523:	}
LABELV $2811
line 6524
;6524:	return qtrue;
CNSTI4 1
RETI4
LABELV $2808
endproc MenuParse_font 16 8
export MenuParse_name
proc MenuParse_name 12 8
line 6527
;6525:}
;6526:
;6527:qboolean MenuParse_name( itemDef_t *item, int handle ) {
line 6528
;6528:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6529
;6529:	if (!PC_String_Parse(handle, &menu->window.name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2814
line 6530
;6530:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2813
JUMPV
LABELV $2814
line 6532
;6531:	}
;6532:	if (Q_stricmp(menu->window.name, "main") == 0) {
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRGP4 $2818
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2816
line 6535
;6533:		// default main as having focus
;6534:		//menu->window.flags |= WINDOW_HASFOCUS;
;6535:	}
LABELV $2816
line 6536
;6536:	return qtrue;
CNSTI4 1
RETI4
LABELV $2813
endproc MenuParse_name 12 8
export MenuParse_fullscreen
proc MenuParse_fullscreen 8 8
line 6539
;6537:}
;6538:
;6539:qboolean MenuParse_fullscreen( itemDef_t *item, int handle ) {
line 6540
;6540:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6541
;6541:	if (!PC_Int_Parse(handle, (int*) &menu->fullScreen)) { // bk001206 - cast qboolean
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2820
line 6542
;6542:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2819
JUMPV
LABELV $2820
line 6544
;6543:	}
;6544:	return qtrue;
CNSTI4 1
RETI4
LABELV $2819
endproc MenuParse_fullscreen 8 8
export MenuParse_rect
proc MenuParse_rect 8 8
line 6547
;6545:}
;6546:
;6547:qboolean MenuParse_rect( itemDef_t *item, int handle ) {
line 6548
;6548:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6549
;6549:	if (!PC_Rect_Parse(handle, &menu->window.rect)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Rect_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2823
line 6550
;6550:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2822
JUMPV
LABELV $2823
line 6552
;6551:	}
;6552:	return qtrue;
CNSTI4 1
RETI4
LABELV $2822
endproc MenuParse_rect 8 8
export MenuParse_style
proc MenuParse_style 8 8
line 6561
;6553:}
;6554:
;6555:/*
;6556:=================
;6557:MenuParse_style
;6558:=================
;6559:*/
;6560:qboolean MenuParse_style( itemDef_t *item, int handle) 
;6561:{
line 6562
;6562:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6564
;6563:
;6564:	if (!PC_Int_Parse(handle, &menu->window.style))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2826
line 6565
;6565:	{
line 6566
;6566:		Com_Printf(S_COLOR_YELLOW "Unknown menu style value");
ADDRGP4 $2828
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 6567
;6567:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2825
JUMPV
LABELV $2826
line 6570
;6568:	}
;6569:
;6570:	return qtrue;
CNSTI4 1
RETI4
LABELV $2825
endproc MenuParse_style 8 8
export MenuParse_visible
proc MenuParse_visible 16 8
line 6573
;6571:}
;6572:
;6573:qboolean MenuParse_visible( itemDef_t *item, int handle ) {
line 6575
;6574:	int i;
;6575:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 6577
;6576:
;6577:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2830
line 6578
;6578:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2829
JUMPV
LABELV $2830
line 6580
;6579:	}
;6580:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2832
line 6581
;6581:		menu->window.flags |= WINDOW_VISIBLE;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 6582
;6582:	}
LABELV $2832
line 6583
;6583:	return qtrue;
CNSTI4 1
RETI4
LABELV $2829
endproc MenuParse_visible 16 8
export MenuParse_onOpen
proc MenuParse_onOpen 8 8
line 6586
;6584:}
;6585:
;6586:qboolean MenuParse_onOpen( itemDef_t *item, int handle ) {
line 6587
;6587:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6588
;6588:	if (!PC_Script_Parse(handle, &menu->onOpen)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2835
line 6589
;6589:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2834
JUMPV
LABELV $2835
line 6591
;6590:	}
;6591:	return qtrue;
CNSTI4 1
RETI4
LABELV $2834
endproc MenuParse_onOpen 8 8
export MenuParse_onClose
proc MenuParse_onClose 8 8
line 6594
;6592:}
;6593:
;6594:qboolean MenuParse_onClose( itemDef_t *item, int handle ) {
line 6595
;6595:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6596
;6596:	if (!PC_Script_Parse(handle, &menu->onClose)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2838
line 6597
;6597:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2837
JUMPV
LABELV $2838
line 6599
;6598:	}
;6599:	return qtrue;
CNSTI4 1
RETI4
LABELV $2837
endproc MenuParse_onClose 8 8
export MenuParse_onESC
proc MenuParse_onESC 8 8
line 6602
;6600:}
;6601:
;6602:qboolean MenuParse_onESC( itemDef_t *item, int handle ) {
line 6603
;6603:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6604
;6604:	if (!PC_Script_Parse(handle, &menu->onESC)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2841
line 6605
;6605:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2840
JUMPV
LABELV $2841
line 6607
;6606:	}
;6607:	return qtrue;
CNSTI4 1
RETI4
LABELV $2840
endproc MenuParse_onESC 8 8
export MenuParse_border
proc MenuParse_border 8 8
line 6612
;6608:}
;6609:
;6610:
;6611:
;6612:qboolean MenuParse_border( itemDef_t *item, int handle ) {
line 6613
;6613:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6614
;6614:	if (!PC_Int_Parse(handle, &menu->window.border)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2844
line 6615
;6615:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2843
JUMPV
LABELV $2844
line 6617
;6616:	}
;6617:	return qtrue;
CNSTI4 1
RETI4
LABELV $2843
endproc MenuParse_border 8 8
export MenuParse_borderSize
proc MenuParse_borderSize 8 8
line 6620
;6618:}
;6619:
;6620:qboolean MenuParse_borderSize( itemDef_t *item, int handle ) {
line 6621
;6621:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6622
;6622:	if (!PC_Float_Parse(handle, &menu->window.borderSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2847
line 6623
;6623:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2846
JUMPV
LABELV $2847
line 6625
;6624:	}
;6625:	return qtrue;
CNSTI4 1
RETI4
LABELV $2846
endproc MenuParse_borderSize 8 8
export MenuParse_backcolor
proc MenuParse_backcolor 16 8
line 6628
;6626:}
;6627:
;6628:qboolean MenuParse_backcolor( itemDef_t *item, int handle ) {
line 6631
;6629:	int i;
;6630:	float f;
;6631:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 6633
;6632:
;6633:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2850
line 6634
;6634:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2854
line 6635
;6635:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2849
JUMPV
LABELV $2854
line 6637
;6636:		}
;6637:		menu->window.backColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 6638
;6638:	}
LABELV $2851
line 6633
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2850
line 6639
;6639:	return qtrue;
CNSTI4 1
RETI4
LABELV $2849
endproc MenuParse_backcolor 16 8
export MenuParse_descAlignment
proc MenuParse_descAlignment 8 8
line 6648
;6640:}
;6641:
;6642:/*
;6643:=================
;6644:MenuParse_descAlignment
;6645:=================
;6646:*/
;6647:qboolean MenuParse_descAlignment( itemDef_t *item, int handle ) 
;6648:{
line 6649
;6649:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6651
;6650:
;6651:	if (!PC_Int_Parse(handle, &menu->descAlignment)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1308
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2857
line 6652
;6652:	{
line 6653
;6653:		Com_Printf(S_COLOR_YELLOW "Unknown desc alignment value");
ADDRGP4 $2859
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 6654
;6654:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2856
JUMPV
LABELV $2857
line 6657
;6655:	}
;6656:
;6657:	return qtrue;
CNSTI4 1
RETI4
LABELV $2856
endproc MenuParse_descAlignment 8 8
export MenuParse_descX
proc MenuParse_descX 8 8
line 6666
;6658:}
;6659:
;6660:/*
;6661:=================
;6662:MenuParse_descX
;6663:=================
;6664:*/
;6665:qboolean MenuParse_descX( itemDef_t *item, int handle ) 
;6666:{
line 6667
;6667:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6669
;6668:
;6669:	if (!PC_Int_Parse(handle, &menu->descX))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1284
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2861
line 6670
;6670:	{
line 6671
;6671:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2860
JUMPV
LABELV $2861
line 6673
;6672:	}
;6673:	return qtrue;
CNSTI4 1
RETI4
LABELV $2860
endproc MenuParse_descX 8 8
export MenuParse_descY
proc MenuParse_descY 8 8
line 6682
;6674:}
;6675:
;6676:/*
;6677:=================
;6678:MenuParse_descY
;6679:=================
;6680:*/
;6681:qboolean MenuParse_descY( itemDef_t *item, int handle ) 
;6682:{
line 6683
;6683:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6685
;6684:
;6685:	if (!PC_Int_Parse(handle, &menu->descY))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1288
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2864
line 6686
;6686:	{
line 6687
;6687:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2863
JUMPV
LABELV $2864
line 6689
;6688:	}
;6689:	return qtrue;
CNSTI4 1
RETI4
LABELV $2863
endproc MenuParse_descY 8 8
export MenuParse_descScale
proc MenuParse_descScale 8 8
line 6698
;6690:}
;6691:
;6692:/*
;6693:=================
;6694:MenuParse_descScale
;6695:=================
;6696:*/
;6697:qboolean MenuParse_descScale( itemDef_t *item, int handle) 
;6698:{
line 6699
;6699:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6701
;6700:
;6701:	if (!PC_Float_Parse(handle, &menu->descScale)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1312
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2867
line 6702
;6702:	{
line 6703
;6703:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2866
JUMPV
LABELV $2867
line 6705
;6704:	}
;6705:	return qtrue;
CNSTI4 1
RETI4
LABELV $2866
endproc MenuParse_descScale 8 8
export MenuParse_descColor
proc MenuParse_descColor 16 8
line 6714
;6706:}
;6707:
;6708:/*
;6709:=================
;6710:MenuParse_descColor
;6711:=================
;6712:*/
;6713:qboolean MenuParse_descColor( itemDef_t *item, int handle) 
;6714:{
line 6717
;6715:	int i;
;6716:	float f;
;6717:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 6719
;6718:
;6719:	for (i = 0; i < 4; i++) 
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2870
line 6720
;6720:	{
line 6721
;6721:		if (!PC_Float_Parse(handle, &f)) 
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2874
line 6722
;6722:		{
line 6723
;6723:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2869
JUMPV
LABELV $2874
line 6725
;6724:		}
;6725:		menu->descColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 1292
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 6726
;6726:	}
LABELV $2871
line 6719
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2870
line 6727
;6727:	return qtrue;
CNSTI4 1
RETI4
LABELV $2869
endproc MenuParse_descColor 16 8
export MenuParse_forecolor
proc MenuParse_forecolor 20 8
line 6730
;6728:}
;6729:
;6730:qboolean MenuParse_forecolor( itemDef_t *item, int handle ) {
line 6733
;6731:	int i;
;6732:	float f;
;6733:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 6735
;6734:
;6735:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2877
line 6736
;6736:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2881
line 6737
;6737:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2876
JUMPV
LABELV $2881
line 6739
;6738:		}
;6739:		menu->window.foreColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 6740
;6740:		menu->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 6741
;6741:	}
LABELV $2878
line 6735
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2877
line 6742
;6742:	return qtrue;
CNSTI4 1
RETI4
LABELV $2876
endproc MenuParse_forecolor 20 8
export MenuParse_bordercolor
proc MenuParse_bordercolor 16 8
line 6745
;6743:}
;6744:
;6745:qboolean MenuParse_bordercolor( itemDef_t *item, int handle ) {
line 6748
;6746:	int i;
;6747:	float f;
;6748:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 6750
;6749:
;6750:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2884
line 6751
;6751:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2888
line 6752
;6752:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2883
JUMPV
LABELV $2888
line 6754
;6753:		}
;6754:		menu->window.borderColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 6755
;6755:	}
LABELV $2885
line 6750
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2884
line 6756
;6756:	return qtrue;
CNSTI4 1
RETI4
LABELV $2883
endproc MenuParse_bordercolor 16 8
export MenuParse_focuscolor
proc MenuParse_focuscolor 16 8
line 6759
;6757:}
;6758:
;6759:qboolean MenuParse_focuscolor( itemDef_t *item, int handle ) {
line 6762
;6760:	int i;
;6761:	float f;
;6762:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 6764
;6763:
;6764:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2891
line 6765
;6765:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2895
line 6766
;6766:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2890
JUMPV
LABELV $2895
line 6768
;6767:		}
;6768:		menu->focusColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 228
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 6769
;6769:	}
LABELV $2892
line 6764
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2891
line 6770
;6770:	return qtrue;
CNSTI4 1
RETI4
LABELV $2890
endproc MenuParse_focuscolor 16 8
export MenuParse_disablecolor
proc MenuParse_disablecolor 16 8
line 6773
;6771:}
;6772:
;6773:qboolean MenuParse_disablecolor( itemDef_t *item, int handle ) {
line 6776
;6774:	int i;
;6775:	float f;
;6776:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 6777
;6777:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2898
line 6778
;6778:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2902
line 6779
;6779:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2897
JUMPV
LABELV $2902
line 6781
;6780:		}
;6781:		menu->disableColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 244
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 6782
;6782:	}
LABELV $2899
line 6777
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2898
line 6783
;6783:	return qtrue;
CNSTI4 1
RETI4
LABELV $2897
endproc MenuParse_disablecolor 16 8
export MenuParse_outlinecolor
proc MenuParse_outlinecolor 8 8
line 6787
;6784:}
;6785:
;6786:
;6787:qboolean MenuParse_outlinecolor( itemDef_t *item, int handle ) {
line 6788
;6788:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6789
;6789:	if (!PC_Color_Parse(handle, &menu->window.outlineColor)){
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2905
line 6790
;6790:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2904
JUMPV
LABELV $2905
line 6792
;6791:	}
;6792:	return qtrue;
CNSTI4 1
RETI4
LABELV $2904
endproc MenuParse_outlinecolor 8 8
export MenuParse_background
proc MenuParse_background 16 8
line 6795
;6793:}
;6794:
;6795:qboolean MenuParse_background( itemDef_t *item, int handle ) {
line 6797
;6796:	const char *buff;
;6797:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 6799
;6798:
;6799:	if (!PC_String_Parse(handle, &buff)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2908
line 6800
;6800:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2907
JUMPV
LABELV $2908
line 6802
;6801:	}
;6802:	menu->window.background = DC->registerShaderNoMip(buff);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 6803
;6803:	return qtrue;
CNSTI4 1
RETI4
LABELV $2907
endproc MenuParse_background 16 8
export MenuParse_cinematic
proc MenuParse_cinematic 8 8
line 6806
;6804:}
;6805:
;6806:qboolean MenuParse_cinematic( itemDef_t *item, int handle ) {
line 6807
;6807:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6809
;6808:
;6809:	if (!PC_String_Parse(handle, &menu->window.cinematicName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2911
line 6810
;6810:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2910
JUMPV
LABELV $2911
line 6812
;6811:	}
;6812:	return qtrue;
CNSTI4 1
RETI4
LABELV $2910
endproc MenuParse_cinematic 8 8
export MenuParse_ownerdrawFlag
proc MenuParse_ownerdrawFlag 16 8
line 6815
;6813:}
;6814:
;6815:qboolean MenuParse_ownerdrawFlag( itemDef_t *item, int handle ) {
line 6817
;6816:	int i;
;6817:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 6819
;6818:
;6819:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2914
line 6820
;6820:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2913
JUMPV
LABELV $2914
line 6822
;6821:	}
;6822:	menu->window.ownerDrawFlags |= i;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 6823
;6823:	return qtrue;
CNSTI4 1
RETI4
LABELV $2913
endproc MenuParse_ownerdrawFlag 16 8
export MenuParse_ownerdraw
proc MenuParse_ownerdraw 8 8
line 6826
;6824:}
;6825:
;6826:qboolean MenuParse_ownerdraw( itemDef_t *item, int handle ) {
line 6827
;6827:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6829
;6828:
;6829:	if (!PC_Int_Parse(handle, &menu->window.ownerDraw)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2917
line 6830
;6830:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2916
JUMPV
LABELV $2917
line 6832
;6831:	}
;6832:	return qtrue;
CNSTI4 1
RETI4
LABELV $2916
endproc MenuParse_ownerdraw 8 8
export MenuParse_popup
proc MenuParse_popup 8 0
line 6837
;6833:}
;6834:
;6835:
;6836:// decoration
;6837:qboolean MenuParse_popup( itemDef_t *item, int handle ) {
line 6838
;6838:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6839
;6839:	menu->window.flags |= WINDOW_POPUP;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2097152
BORI4
ASGNI4
line 6840
;6840:	return qtrue;
CNSTI4 1
RETI4
LABELV $2919
endproc MenuParse_popup 8 0
export MenuParse_outOfBounds
proc MenuParse_outOfBounds 8 0
line 6844
;6841:}
;6842:
;6843:
;6844:qboolean MenuParse_outOfBounds( itemDef_t *item, int handle ) {
line 6845
;6845:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6847
;6846:
;6847:	menu->window.flags |= WINDOW_OOB_CLICK;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 6848
;6848:	return qtrue;
CNSTI4 1
RETI4
LABELV $2920
endproc MenuParse_outOfBounds 8 0
export MenuParse_soundLoop
proc MenuParse_soundLoop 8 8
line 6851
;6849:}
;6850:
;6851:qboolean MenuParse_soundLoop( itemDef_t *item, int handle ) {
line 6852
;6852:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6854
;6853:
;6854:	if (!PC_String_Parse(handle, &menu->soundName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2922
line 6855
;6855:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2921
JUMPV
LABELV $2922
line 6857
;6856:	}
;6857:	return qtrue;
CNSTI4 1
RETI4
LABELV $2921
endproc MenuParse_soundLoop 8 8
export MenuParse_fadeClamp
proc MenuParse_fadeClamp 8 8
line 6860
;6858:}
;6859:
;6860:qboolean MenuParse_fadeClamp( itemDef_t *item, int handle ) {
line 6861
;6861:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6863
;6862:
;6863:	if (!PC_Float_Parse(handle, &menu->fadeClamp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2925
line 6864
;6864:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2924
JUMPV
LABELV $2925
line 6866
;6865:	}
;6866:	return qtrue;
CNSTI4 1
RETI4
LABELV $2924
endproc MenuParse_fadeClamp 8 8
export MenuParse_fadeAmount
proc MenuParse_fadeAmount 8 8
line 6869
;6867:}
;6868:
;6869:qboolean MenuParse_fadeAmount( itemDef_t *item, int handle ) {
line 6870
;6870:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6872
;6871:
;6872:	if (!PC_Float_Parse(handle, &menu->fadeAmount)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2928
line 6873
;6873:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2927
JUMPV
LABELV $2928
line 6875
;6874:	}
;6875:	return qtrue;
CNSTI4 1
RETI4
LABELV $2927
endproc MenuParse_fadeAmount 8 8
export MenuParse_fadeCycle
proc MenuParse_fadeCycle 8 8
line 6879
;6876:}
;6877:
;6878:
;6879:qboolean MenuParse_fadeCycle( itemDef_t *item, int handle ) {
line 6880
;6880:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6882
;6881:
;6882:	if (!PC_Int_Parse(handle, &menu->fadeCycle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2931
line 6883
;6883:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2930
JUMPV
LABELV $2931
line 6885
;6884:	}
;6885:	return qtrue;
CNSTI4 1
RETI4
LABELV $2930
endproc MenuParse_fadeCycle 8 8
export MenuParse_itemDef
proc MenuParse_itemDef 40 8
line 6889
;6886:}
;6887:
;6888:
;6889:qboolean MenuParse_itemDef( itemDef_t *item, int handle ) {
line 6890
;6890:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6891
;6891:	if (menu->itemCount < MAX_MENUITEMS) {
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 256
GEI4 $2934
line 6892
;6892:		menu->items[menu->itemCount] = UI_Alloc(sizeof(itemDef_t));
CNSTI4 564
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 6893
;6893:		Item_Init(menu->items[menu->itemCount]);
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Init
CALLV
pop
line 6894
;6894:		if (!Item_Parse(handle, menu->items[menu->itemCount])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2936
line 6895
;6895:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2933
JUMPV
LABELV $2936
line 6897
;6896:		}
;6897:		Item_InitControls(menu->items[menu->itemCount]);
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_InitControls
CALLV
pop
line 6898
;6898:		menu->items[menu->itemCount++]->parent = menu;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 32
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRP4
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 240
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 6899
;6899:	}
LABELV $2934
line 6900
;6900:	return qtrue;
CNSTI4 1
RETI4
LABELV $2933
endproc MenuParse_itemDef 40 8
export MenuParse_appearanceIncrement
proc MenuParse_appearanceIncrement 8 8
line 6908
;6901:}
;6902:/*
;6903:=================
;6904:MenuParse_focuscolor
;6905:=================
;6906:*/
;6907:qboolean MenuParse_appearanceIncrement( itemDef_t *item, int handle ) 
;6908:{
line 6909
;6909:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 6911
;6910:
;6911:	if (!PC_Float_Parse(handle, &menu->appearanceIncrement))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1324
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2939
line 6912
;6912:	{
line 6913
;6913:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2938
JUMPV
LABELV $2939
line 6915
;6914:	}
;6915:	return qtrue;
CNSTI4 1
RETI4
LABELV $2938
endproc MenuParse_appearanceIncrement 8 8
data
export menuParseKeywords
align 4
LABELV menuParseKeywords
address $2941
address MenuParse_appearanceIncrement
byte 4 0
address $422
address MenuParse_backcolor
byte 4 0
address $2687
address MenuParse_background
byte 4 0
address $2688
address MenuParse_border
byte 4 0
address $428
address MenuParse_bordercolor
byte 4 0
address $2942
address MenuParse_borderSize
byte 4 0
address $2690
address MenuParse_cinematic
byte 4 0
address $2943
address MenuParse_descAlignment
byte 4 0
address $2944
address MenuParse_descColor
byte 4 0
address $2945
address MenuParse_descX
byte 4 0
address $2946
address MenuParse_descY
byte 4 0
address $2947
address MenuParse_descScale
byte 4 0
address $2948
address MenuParse_disablecolor
byte 4 0
address $2949
address MenuParse_fadeAmount
byte 4 0
address $2950
address MenuParse_fadeClamp
byte 4 0
address $2951
address MenuParse_fadeCycle
byte 4 0
address $2952
address MenuParse_focuscolor
byte 4 0
address $2708
address MenuParse_font
byte 4 0
address $425
address MenuParse_forecolor
byte 4 0
address $2953
address MenuParse_fullscreen
byte 4 0
address $2954
address MenuParse_itemDef
byte 4 0
address $2724
address MenuParse_name
byte 4 0
address $2955
address MenuParse_onClose
byte 4 0
address $2956
address MenuParse_onESC
byte 4 0
address $2957
address MenuParse_outOfBounds
byte 4 0
address $2958
address MenuParse_onOpen
byte 4 0
address $2727
address MenuParse_outlinecolor
byte 4 0
address $2728
address MenuParse_ownerdraw
byte 4 0
address $2729
address MenuParse_ownerdrawFlag
byte 4 0
address $2959
address MenuParse_popup
byte 4 0
address $2730
address MenuParse_rect
byte 4 0
address $2960
address MenuParse_soundLoop
byte 4 0
address $2733
address MenuParse_style
byte 4 0
address $2744
address MenuParse_visible
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export Menu_SetupKeywordHash
code
proc Menu_SetupKeywordHash 4 12
line 6963
;6916:}
;6917:
;6918:keywordHash_t menuParseKeywords[] = {
;6919:	{"appearanceIncrement",	MenuParse_appearanceIncrement,	NULL	},
;6920:	{"backcolor",			MenuParse_backcolor,	NULL	},
;6921:	{"background",			MenuParse_background,	NULL	},
;6922:	{"border",				MenuParse_border,		NULL	},
;6923:	{"bordercolor",			MenuParse_bordercolor,	NULL	},
;6924:	{"borderSize",			MenuParse_borderSize,	NULL	},
;6925:	{"cinematic",			MenuParse_cinematic,	NULL	},
;6926:	{"descAlignment",		MenuParse_descAlignment,NULL	},
;6927:	{"desccolor",			MenuParse_descColor,	NULL	},
;6928:	{"descX",				MenuParse_descX,		NULL	},
;6929:	{"descY",				MenuParse_descY,		NULL	},
;6930:	{"descScale",			MenuParse_descScale,	NULL	},
;6931:	{"disablecolor",		MenuParse_disablecolor, NULL	},
;6932:	{"fadeAmount",			MenuParse_fadeAmount,	NULL	},
;6933:	{"fadeClamp",			MenuParse_fadeClamp,	NULL	},
;6934:	{"fadeCycle",			MenuParse_fadeCycle,	NULL	},
;6935:	{"focuscolor",			MenuParse_focuscolor,	NULL	},
;6936:	{"font",				MenuParse_font,			NULL	},
;6937:	{"forecolor",			MenuParse_forecolor,	NULL	},
;6938:	{"fullscreen",			MenuParse_fullscreen,	NULL	},
;6939:	{"itemDef",				MenuParse_itemDef,		NULL	},
;6940:	{"name",				MenuParse_name,			NULL	},
;6941:	{"onClose",				MenuParse_onClose,		NULL	},
;6942:	{"onESC",				MenuParse_onESC,		NULL	},
;6943:	{"outOfBoundsClick",	MenuParse_outOfBounds,	NULL	},
;6944:	{"onOpen",				MenuParse_onOpen,		NULL	},
;6945:	{"outlinecolor",		MenuParse_outlinecolor, NULL	},
;6946:	{"ownerdraw",			MenuParse_ownerdraw,	NULL	},
;6947:	{"ownerdrawFlag",		MenuParse_ownerdrawFlag,NULL	},
;6948:	{"popup",				MenuParse_popup,		NULL	},
;6949:	{"rect",				MenuParse_rect,			NULL	},
;6950:	{"soundLoop",			MenuParse_soundLoop,	NULL	},
;6951:	{"style",				MenuParse_style,		NULL	},
;6952:	{"visible",				MenuParse_visible,		NULL	},
;6953:	{0,						0,						0		}
;6954:};
;6955:
;6956:keywordHash_t *menuParseKeywordHash[KEYWORDHASH_SIZE];
;6957:
;6958:/*
;6959:===============
;6960:Menu_SetupKeywordHash
;6961:===============
;6962:*/
;6963:void Menu_SetupKeywordHash(void) {
line 6966
;6964:	int i;
;6965:
;6966:	memset(menuParseKeywordHash, 0, sizeof(menuParseKeywordHash));
ADDRGP4 menuParseKeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 6967
;6967:	for (i = 0; menuParseKeywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2965
JUMPV
LABELV $2962
line 6968
;6968:		KeywordHash_Add(menuParseKeywordHash, &menuParseKeywords[i]);
ADDRGP4 menuParseKeywordHash
ARGP4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 menuParseKeywords
ADDP4
ARGP4
ADDRGP4 KeywordHash_Add
CALLV
pop
line 6969
;6969:	}
LABELV $2963
line 6967
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2965
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 menuParseKeywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2962
line 6970
;6970:}
LABELV $2961
endproc Menu_SetupKeywordHash 4 12
export Menu_Parse
proc Menu_Parse 1060 12
line 6977
;6971:
;6972:/*
;6973:===============
;6974:Menu_Parse
;6975:===============
;6976:*/
;6977:qboolean Menu_Parse(int handle, menuDef_t *menu) {
line 6981
;6978:	pc_token_t token;
;6979:	keywordHash_t *key;
;6980:
;6981:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2967
line 6982
;6982:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2966
JUMPV
LABELV $2967
line 6983
;6983:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2973
line 6984
;6984:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2966
JUMPV
LABELV $2972
line 6987
;6985:	}
;6986:    
;6987:	while ( 1 ) {
line 6988
;6988:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2975
line 6989
;6989:			PC_SourceError(handle, "end of file inside menu\n");
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2977
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 6990
;6990:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2966
JUMPV
LABELV $2975
line 6993
;6991:		}
;6992:
;6993:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2978
line 6994
;6994:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2966
JUMPV
LABELV $2978
line 6997
;6995:		}
;6996:
;6997:		key = KeywordHash_Find(menuParseKeywordHash, token.string);
ADDRGP4 menuParseKeywordHash
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 1052
ADDRGP4 KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1052
INDIRP4
ASGNP4
line 6998
;6998:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2982
line 6999
;6999:			PC_SourceError(handle, "unknown menu keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2984
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 7000
;7000:			continue;
ADDRGP4 $2973
JUMPV
LABELV $2982
line 7002
;7001:		}
;7002:		if ( !key->func((itemDef_t*)menu, handle) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRLP4 1040
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2986
line 7003
;7003:			PC_SourceError(handle, "couldn't parse menu keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2988
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 7004
;7004:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2966
JUMPV
LABELV $2986
line 7006
;7005:		}
;7006:	}
LABELV $2973
line 6987
ADDRGP4 $2972
JUMPV
line 7007
;7007:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2966
endproc Menu_Parse 1060 12
export Menu_New
proc Menu_New 12 8
line 7015
;7008:}
;7009:
;7010:/*
;7011:===============
;7012:Menu_New
;7013:===============
;7014:*/
;7015:void Menu_New(int handle) {
line 7016
;7016:	menuDef_t *menu = &Menus[menuCount];
ADDRLP4 0
CNSTI4 1328
ADDRGP4 menuCount
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ASGNP4
line 7018
;7017:
;7018:	if (menuCount < MAX_MENUS) {
ADDRGP4 menuCount
INDIRI4
CNSTI4 64
GEI4 $2991
line 7019
;7019:		Menu_Init(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_Init
CALLV
pop
line 7020
;7020:		if (Menu_Parse(handle, menu)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menu_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2993
line 7021
;7021:			Menu_PostParse(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_PostParse
CALLV
pop
line 7022
;7022:			menuCount++;
ADDRLP4 8
ADDRGP4 menuCount
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 7023
;7023:		}
LABELV $2993
line 7024
;7024:	}
LABELV $2991
line 7025
;7025:}
LABELV $2990
endproc Menu_New 12 8
export Menu_Count
proc Menu_Count 0 0
line 7027
;7026:
;7027:int Menu_Count() {
line 7028
;7028:	return menuCount;
ADDRGP4 menuCount
INDIRI4
RETI4
LABELV $2995
endproc Menu_Count 0 0
lit
align 4
LABELV $3005
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export Menu_PaintAll
code
proc Menu_PaintAll 44 36
line 7031
;7029:}
;7030:
;7031:void Menu_PaintAll() {
line 7033
;7032:	int i;
;7033:	if (captureFunc) {
ADDRGP4 captureFunc
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2997
line 7034
;7034:		captureFunc(captureData);
ADDRGP4 captureData
INDIRP4
ARGP4
ADDRGP4 captureFunc
INDIRP4
CALLV
pop
line 7035
;7035:	}
LABELV $2997
line 7037
;7036:
;7037:	for (i = 0; i < Menu_Count(); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3002
JUMPV
LABELV $2999
line 7038
;7038:		Menu_Paint(&Menus[i], qfalse);
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_Paint
CALLV
pop
line 7039
;7039:	}
LABELV $3000
line 7037
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3002
ADDRLP4 4
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $2999
line 7041
;7040:
;7041:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $3003
line 7042
;7042:		vec4_t v = {1, 1, 1, 1};
ADDRLP4 8
ADDRGP4 $3005
INDIRB
ASGNB 16
line 7043
;7043:		DC->drawText(5, 25, .5, v, va("fps: %f", DC->FPS), 0, 0, 0, 0);
ADDRGP4 $3006
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 11804
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTF4 1084227584
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1056964608
ARGF4
ADDRLP4 8
ARGP4
ADDRLP4 24
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
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 7044
;7044:		DC->drawText(5, 45, .5, v, va("x: %d  y:%d", DC->cursorx,DC->cursory), 0, 0, 0, 0);
ADDRGP4 $3007
ARGP4
ADDRLP4 32
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
CNSTF4 1084227584
ARGF4
CNSTF4 1110704128
ARGF4
CNSTF4 1056964608
ARGF4
ADDRLP4 8
ARGP4
ADDRLP4 36
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
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 7045
;7045:	}
LABELV $3003
line 7046
;7046:}
LABELV $2996
endproc Menu_PaintAll 44 36
export Menu_Reset
proc Menu_Reset 0 0
line 7048
;7047:
;7048:void Menu_Reset() {
line 7049
;7049:	menuCount = 0;
ADDRGP4 menuCount
CNSTI4 0
ASGNI4
line 7050
;7050:}
LABELV $3008
endproc Menu_Reset 0 0
export Display_GetContext
proc Display_GetContext 0 0
line 7052
;7051:
;7052:displayContextDef_t *Display_GetContext() {
line 7053
;7053:	return DC;
ADDRGP4 DC
INDIRP4
RETP4
LABELV $3009
endproc Display_GetContext 0 0
export Display_CaptureItem
proc Display_CaptureItem 8 12
line 7056
;7054:}
;7055: 
;7056:void *Display_CaptureItem(int x, int y) {
line 7059
;7057:	int i;
;7058:
;7059:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3014
JUMPV
LABELV $3011
line 7062
;7060:		// turn off focus each item
;7061:		// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;7062:		if (Rect_ContainsPoint(&Menus[i].window.rect, x, y)) {
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $3015
line 7063
;7063:			return &Menus[i];
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $3010
JUMPV
LABELV $3015
line 7065
;7064:		}
;7065:	}
LABELV $3012
line 7059
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3014
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $3011
line 7066
;7066:	return NULL;
CNSTP4 0
RETP4
LABELV $3010
endproc Display_CaptureItem 8 12
export Display_MouseMove
proc Display_MouseMove 16 12
line 7071
;7067:}
;7068:
;7069:
;7070:// FIXME: 
;7071:qboolean Display_MouseMove(void *p, int x, int y) {
line 7073
;7072:	int i;
;7073:	menuDef_t *menu = p;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 7075
;7074:
;7075:	if (menu == NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3018
line 7076
;7076:    menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 7077
;7077:		if (menu) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3020
line 7078
;7078:			if (menu->window.flags & WINDOW_POPUP) {
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $3022
line 7079
;7079:				Menu_HandleMouseMove(menu, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 7080
;7080:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3017
JUMPV
LABELV $3022
line 7082
;7081:			}
;7082:		}
LABELV $3020
line 7083
;7083:		for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3027
JUMPV
LABELV $3024
line 7084
;7084:			Menu_HandleMouseMove(&Menus[i], x, y);
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 7085
;7085:		}
LABELV $3025
line 7083
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3027
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $3024
line 7086
;7086:	} else {
ADDRGP4 $3019
JUMPV
LABELV $3018
line 7087
;7087:		menu->window.rect.x += x;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 7088
;7088:		menu->window.rect.y += y;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRFP4 8
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 7089
;7089:		Menu_UpdatePosition(menu);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menu_UpdatePosition
CALLV
pop
line 7090
;7090:	}
LABELV $3019
line 7091
;7091: 	return qtrue;
CNSTI4 1
RETI4
LABELV $3017
endproc Display_MouseMove 16 12
export Display_CursorType
proc Display_CursorType 28 12
line 7095
;7092:
;7093:}
;7094:
;7095:int Display_CursorType(int x, int y) {
line 7097
;7096:	int i;
;7097:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3032
JUMPV
LABELV $3029
line 7099
;7098:		rectDef_t r2;
;7099:		r2.x = Menus[i].window.rect.x - 3;
ADDRLP4 4
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
line 7100
;7100:		r2.y = Menus[i].window.rect.y - 3;
ADDRLP4 4+4
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus+4
ADDP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
line 7101
;7101:		r2.w = r2.h = 7;
ADDRLP4 20
CNSTF4 1088421888
ASGNF4
ADDRLP4 4+12
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 20
INDIRF4
ASGNF4
line 7102
;7102:		if (Rect_ContainsPoint(&r2, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3037
line 7103
;7103:			return CURSOR_SIZER;
CNSTI4 4
RETI4
ADDRGP4 $3028
JUMPV
LABELV $3037
line 7105
;7104:		}
;7105:	}
LABELV $3030
line 7097
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3032
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $3029
line 7106
;7106:	return CURSOR_ARROW;
CNSTI4 2
RETI4
LABELV $3028
endproc Display_CursorType 28 12
export Display_HandleKey
proc Display_HandleKey 12 12
line 7110
;7107:}
;7108:
;7109:
;7110:void Display_HandleKey(int key, qboolean down, int x, int y) {
line 7111
;7111:	menuDef_t *menu = Display_CaptureItem(x, y);
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Display_CaptureItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 7112
;7112:	if (menu == NULL) {  
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3040
line 7113
;7113:		menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 7114
;7114:	}
LABELV $3040
line 7115
;7115:	if (menu) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3042
line 7116
;7116:		Menu_HandleKey(menu, key, down );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Menu_HandleKey
CALLV
pop
line 7117
;7117:	}
LABELV $3042
line 7118
;7118:}
LABELV $3039
endproc Display_HandleKey 12 12
proc Window_CacheContents 12 20
line 7120
;7119:
;7120:static void Window_CacheContents(windowDef_t *window) {
line 7121
;7121:	if (window) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3045
line 7122
;7122:		if (window->cinematicName) {
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3047
line 7123
;7123:			int cin = DC->playCinematic(window->cinematicName, 0, 0, 0, 0);
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 204
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 7124
;7124:			DC->stopCinematic(cin);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRP4
CALLV
pop
line 7125
;7125:		}
LABELV $3047
line 7126
;7126:	}
LABELV $3045
line 7127
;7127:}
LABELV $3044
endproc Window_CacheContents 12 20
proc Item_CacheContents 0 4
line 7130
;7128:
;7129:
;7130:static void Item_CacheContents(itemDef_t *item) {
line 7131
;7131:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3050
line 7132
;7132:		Window_CacheContents(&item->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CacheContents
CALLV
pop
line 7133
;7133:	}
LABELV $3050
line 7135
;7134:
;7135:}
LABELV $3049
endproc Item_CacheContents 0 4
proc Menu_CacheContents 8 4
line 7137
;7136:
;7137:static void Menu_CacheContents(menuDef_t *menu) {
line 7138
;7138:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3053
line 7140
;7139:		int i;
;7140:		Window_CacheContents(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CacheContents
CALLV
pop
line 7141
;7141:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3058
JUMPV
LABELV $3055
line 7142
;7142:			Item_CacheContents(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_CacheContents
CALLV
pop
line 7143
;7143:		}
LABELV $3056
line 7141
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3058
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $3055
line 7145
;7144:
;7145:		if (menu->soundName && *menu->soundName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3059
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3059
line 7146
;7146:			DC->registerSound(menu->soundName);
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 192
ADDP4
INDIRP4
CALLI4
pop
line 7147
;7147:		}
LABELV $3059
line 7148
;7148:	}
LABELV $3053
line 7150
;7149:
;7150:}
LABELV $3052
endproc Menu_CacheContents 8 4
export Display_CacheAll
proc Display_CacheAll 4 4
line 7152
;7151:
;7152:void Display_CacheAll() {
line 7154
;7153:	int i;
;7154:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3065
JUMPV
LABELV $3062
line 7155
;7155:		Menu_CacheContents(&Menus[i]);
CNSTI4 1328
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_CacheContents
CALLV
pop
line 7156
;7156:	}
LABELV $3063
line 7154
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3065
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $3062
line 7157
;7157:}
LABELV $3061
endproc Display_CacheAll 4 4
proc Menu_OverActiveItem 32 12
line 7160
;7158:
;7159:
;7160:static qboolean Menu_OverActiveItem(menuDef_t *menu, float x, float y) {
line 7161
;7161: 	if (menu && menu->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED)) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3067
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
EQI4 $3067
line 7162
;7162:		if (Rect_ContainsPoint(&menu->window.rect, x, y)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $3069
line 7164
;7163:			int i;
;7164:			for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $3074
JUMPV
LABELV $3071
line 7168
;7165:				// turn off focus each item
;7166:				// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;7167:
;7168:				if (!(menu->items[i]->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $3075
line 7169
;7169:					continue;
ADDRGP4 $3072
JUMPV
LABELV $3075
line 7172
;7170:				}
;7171:
;7172:				if (menu->items[i]->window.flags & WINDOW_DECORATION) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $3077
line 7173
;7173:					continue;
ADDRGP4 $3072
JUMPV
LABELV $3077
line 7176
;7174:				}
;7175:
;7176:				if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $3079
line 7177
;7177:					itemDef_t *overItem = menu->items[i];
ADDRLP4 16
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 7178
;7178:					if (overItem->type == ITEM_TYPE_TEXT && overItem->text) {
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3081
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3081
line 7179
;7179:						if (Rect_ContainsPoint(Item_CorrectedTextRect(overItem), x, y)) {
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $3072
line 7180
;7180:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3066
JUMPV
line 7181
;7181:						} else {
line 7182
;7182:							continue;
LABELV $3081
line 7184
;7183:						}
;7184:					} else {
line 7185
;7185:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3066
JUMPV
LABELV $3079
line 7188
;7186:					}
;7187:				}
;7188:			}
LABELV $3072
line 7164
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3074
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $3071
line 7190
;7189:
;7190:		}
LABELV $3069
line 7191
;7191:	}
LABELV $3067
line 7192
;7192:	return qfalse;
CNSTI4 0
RETI4
LABELV $3066
endproc Menu_OverActiveItem 32 12
bss
export menuParseKeywordHash
align 4
LABELV menuParseKeywordHash
skip 2048
export itemParseKeywordHash
align 4
LABELV itemParseKeywordHash
skip 2048
export g_nameBind2
align 1
LABELV g_nameBind2
skip 32
export g_nameBind1
align 1
LABELV g_nameBind1
skip 32
export ui_deferredScript
align 1
LABELV ui_deferredScript
skip 2048
align 4
LABELV strHandle
skip 8192
align 1
LABELV strPool
skip 131072
import MenuFontToHandle
align 4
LABELV outOfMemory
skip 4
align 4
LABELV allocPoint
skip 4
align 1
LABELV memoryPool
skip 131072
export menuStack
align 4
LABELV menuStack
skip 64
export Menus
align 4
LABELV Menus
skip 84992
align 4
LABELV scrollInfo
skip 32
import trap_SP_GetStringTextString
import trap_SP_Register
import trap_SP_RegisterServer
import trap_PC_RemoveAllGlobalDefines
import trap_PC_LoadGlobalDefines
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Script_Parse
import Display_ExpandMacros
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
LABELV $3007
char 1 120
char 1 58
char 1 32
char 1 37
char 1 100
char 1 32
char 1 32
char 1 121
char 1 58
char 1 37
char 1 100
char 1 0
align 1
LABELV $3006
char 1 102
char 1 112
char 1 115
char 1 58
char 1 32
char 1 37
char 1 102
char 1 0
align 1
LABELV $2988
char 1 99
char 1 111
char 1 117
char 1 108
char 1 100
char 1 110
char 1 39
char 1 116
char 1 32
char 1 112
char 1 97
char 1 114
char 1 115
char 1 101
char 1 32
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 107
char 1 101
char 1 121
char 1 119
char 1 111
char 1 114
char 1 100
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $2984
char 1 117
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 32
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 107
char 1 101
char 1 121
char 1 119
char 1 111
char 1 114
char 1 100
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $2977
char 1 101
char 1 110
char 1 100
char 1 32
char 1 111
char 1 102
char 1 32
char 1 102
char 1 105
char 1 108
char 1 101
char 1 32
char 1 105
char 1 110
char 1 115
char 1 105
char 1 100
char 1 101
char 1 32
char 1 109
char 1 101
char 1 110
char 1 117
char 1 10
char 1 0
align 1
LABELV $2960
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 76
char 1 111
char 1 111
char 1 112
char 1 0
align 1
LABELV $2959
char 1 112
char 1 111
char 1 112
char 1 117
char 1 112
char 1 0
align 1
LABELV $2958
char 1 111
char 1 110
char 1 79
char 1 112
char 1 101
char 1 110
char 1 0
align 1
LABELV $2957
char 1 111
char 1 117
char 1 116
char 1 79
char 1 102
char 1 66
char 1 111
char 1 117
char 1 110
char 1 100
char 1 115
char 1 67
char 1 108
char 1 105
char 1 99
char 1 107
char 1 0
align 1
LABELV $2956
char 1 111
char 1 110
char 1 69
char 1 83
char 1 67
char 1 0
align 1
LABELV $2955
char 1 111
char 1 110
char 1 67
char 1 108
char 1 111
char 1 115
char 1 101
char 1 0
align 1
LABELV $2954
char 1 105
char 1 116
char 1 101
char 1 109
char 1 68
char 1 101
char 1 102
char 1 0
align 1
LABELV $2953
char 1 102
char 1 117
char 1 108
char 1 108
char 1 115
char 1 99
char 1 114
char 1 101
char 1 101
char 1 110
char 1 0
align 1
LABELV $2952
char 1 102
char 1 111
char 1 99
char 1 117
char 1 115
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $2951
char 1 102
char 1 97
char 1 100
char 1 101
char 1 67
char 1 121
char 1 99
char 1 108
char 1 101
char 1 0
align 1
LABELV $2950
char 1 102
char 1 97
char 1 100
char 1 101
char 1 67
char 1 108
char 1 97
char 1 109
char 1 112
char 1 0
align 1
LABELV $2949
char 1 102
char 1 97
char 1 100
char 1 101
char 1 65
char 1 109
char 1 111
char 1 117
char 1 110
char 1 116
char 1 0
align 1
LABELV $2948
char 1 100
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $2947
char 1 100
char 1 101
char 1 115
char 1 99
char 1 83
char 1 99
char 1 97
char 1 108
char 1 101
char 1 0
align 1
LABELV $2946
char 1 100
char 1 101
char 1 115
char 1 99
char 1 89
char 1 0
align 1
LABELV $2945
char 1 100
char 1 101
char 1 115
char 1 99
char 1 88
char 1 0
align 1
LABELV $2944
char 1 100
char 1 101
char 1 115
char 1 99
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $2943
char 1 100
char 1 101
char 1 115
char 1 99
char 1 65
char 1 108
char 1 105
char 1 103
char 1 110
char 1 109
char 1 101
char 1 110
char 1 116
char 1 0
align 1
LABELV $2942
char 1 98
char 1 111
char 1 114
char 1 100
char 1 101
char 1 114
char 1 83
char 1 105
char 1 122
char 1 101
char 1 0
align 1
LABELV $2941
char 1 97
char 1 112
char 1 112
char 1 101
char 1 97
char 1 114
char 1 97
char 1 110
char 1 99
char 1 101
char 1 73
char 1 110
char 1 99
char 1 114
char 1 101
char 1 109
char 1 101
char 1 110
char 1 116
char 1 0
align 1
LABELV $2859
char 1 94
char 1 51
char 1 85
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 32
char 1 100
char 1 101
char 1 115
char 1 99
char 1 32
char 1 97
char 1 108
char 1 105
char 1 103
char 1 110
char 1 109
char 1 101
char 1 110
char 1 116
char 1 32
char 1 118
char 1 97
char 1 108
char 1 117
char 1 101
char 1 0
align 1
LABELV $2828
char 1 94
char 1 51
char 1 85
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 32
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 115
char 1 116
char 1 121
char 1 108
char 1 101
char 1 32
char 1 118
char 1 97
char 1 108
char 1 117
char 1 101
char 1 0
align 1
LABELV $2818
char 1 109
char 1 97
char 1 105
char 1 110
char 1 0
align 1
LABELV $2786
char 1 37
char 1 99
char 1 0
align 1
LABELV $2774
char 1 99
char 1 111
char 1 117
char 1 108
char 1 100
char 1 110
char 1 39
char 1 116
char 1 32
char 1 112
char 1 97
char 1 114
char 1 115
char 1 101
char 1 32
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 105
char 1 116
char 1 101
char 1 109
char 1 32
char 1 107
char 1 101
char 1 121
char 1 119
char 1 111
char 1 114
char 1 100
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $2770
char 1 117
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 32
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 105
char 1 116
char 1 101
char 1 109
char 1 32
char 1 107
char 1 101
char 1 121
char 1 119
char 1 111
char 1 114
char 1 100
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $2747
char 1 108
char 1 105
char 1 110
char 1 101
char 1 72
char 1 101
char 1 105
char 1 103
char 1 104
char 1 116
char 1 0
align 1
LABELV $2746
char 1 109
char 1 97
char 1 120
char 1 76
char 1 105
char 1 110
char 1 101
char 1 67
char 1 104
char 1 97
char 1 114
char 1 115
char 1 0
align 1
LABELV $2745
char 1 119
char 1 114
char 1 97
char 1 112
char 1 112
char 1 101
char 1 100
char 1 0
align 1
LABELV $2744
char 1 118
char 1 105
char 1 115
char 1 105
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $2743
char 1 116
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $2742
char 1 116
char 1 101
char 1 120
char 1 116
char 1 50
char 1 97
char 1 108
char 1 105
char 1 103
char 1 110
char 1 121
char 1 0
align 1
LABELV $2741
char 1 116
char 1 101
char 1 120
char 1 116
char 1 50
char 1 97
char 1 108
char 1 105
char 1 103
char 1 110
char 1 120
char 1 0
align 1
LABELV $2740
char 1 116
char 1 101
char 1 120
char 1 116
char 1 50
char 1 0
align 1
LABELV $2739
char 1 116
char 1 101
char 1 120
char 1 116
char 1 115
char 1 116
char 1 121
char 1 108
char 1 101
char 1 0
align 1
LABELV $2738
char 1 116
char 1 101
char 1 120
char 1 116
char 1 115
char 1 99
char 1 97
char 1 108
char 1 101
char 1 0
align 1
LABELV $2737
char 1 116
char 1 101
char 1 120
char 1 116
char 1 97
char 1 108
char 1 105
char 1 103
char 1 110
char 1 121
char 1 0
align 1
LABELV $2736
char 1 116
char 1 101
char 1 120
char 1 116
char 1 97
char 1 108
char 1 105
char 1 103
char 1 110
char 1 120
char 1 0
align 1
LABELV $2735
char 1 116
char 1 101
char 1 120
char 1 116
char 1 97
char 1 108
char 1 105
char 1 103
char 1 110
char 1 0
align 1
LABELV $2734
char 1 116
char 1 101
char 1 120
char 1 116
char 1 0
align 1
LABELV $2733
char 1 115
char 1 116
char 1 121
char 1 108
char 1 101
char 1 0
align 1
LABELV $2732
char 1 115
char 1 112
char 1 101
char 1 99
char 1 105
char 1 97
char 1 108
char 1 0
align 1
LABELV $2731
char 1 115
char 1 104
char 1 111
char 1 119
char 1 67
char 1 118
char 1 97
char 1 114
char 1 0
align 1
LABELV $2730
char 1 114
char 1 101
char 1 99
char 1 116
char 1 0
align 1
LABELV $2729
char 1 111
char 1 119
char 1 110
char 1 101
char 1 114
char 1 100
char 1 114
char 1 97
char 1 119
char 1 70
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $2728
char 1 111
char 1 119
char 1 110
char 1 101
char 1 114
char 1 100
char 1 114
char 1 97
char 1 119
char 1 0
align 1
LABELV $2727
char 1 111
char 1 117
char 1 116
char 1 108
char 1 105
char 1 110
char 1 101
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $2726
char 1 111
char 1 110
char 1 70
char 1 111
char 1 99
char 1 117
char 1 115
char 1 0
align 1
LABELV $2725
char 1 110
char 1 111
char 1 116
char 1 115
char 1 101
char 1 108
char 1 101
char 1 99
char 1 116
char 1 97
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $2724
char 1 110
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2723
char 1 109
char 1 111
char 1 117
char 1 115
char 1 101
char 1 69
char 1 120
char 1 105
char 1 116
char 1 84
char 1 101
char 1 120
char 1 116
char 1 0
align 1
LABELV $2722
char 1 109
char 1 111
char 1 117
char 1 115
char 1 101
char 1 69
char 1 120
char 1 105
char 1 116
char 1 0
align 1
LABELV $2721
char 1 109
char 1 111
char 1 117
char 1 115
char 1 101
char 1 69
char 1 110
char 1 116
char 1 101
char 1 114
char 1 84
char 1 101
char 1 120
char 1 116
char 1 0
align 1
LABELV $2720
char 1 109
char 1 111
char 1 117
char 1 115
char 1 101
char 1 69
char 1 110
char 1 116
char 1 101
char 1 114
char 1 0
align 1
LABELV $2719
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 95
char 1 114
char 1 111
char 1 116
char 1 97
char 1 116
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $2718
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 95
char 1 111
char 1 114
char 1 105
char 1 103
char 1 105
char 1 110
char 1 0
align 1
LABELV $2717
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 95
char 1 102
char 1 111
char 1 118
char 1 121
char 1 0
align 1
LABELV $2716
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 95
char 1 102
char 1 111
char 1 118
char 1 120
char 1 0
align 1
LABELV $2715
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 95
char 1 97
char 1 110
char 1 103
char 1 108
char 1 101
char 1 0
align 1
LABELV $2714
char 1 109
char 1 97
char 1 120
char 1 80
char 1 97
char 1 105
char 1 110
char 1 116
char 1 67
char 1 104
char 1 97
char 1 114
char 1 115
char 1 0
align 1
LABELV $2713
char 1 109
char 1 97
char 1 120
char 1 67
char 1 104
char 1 97
char 1 114
char 1 115
char 1 0
align 1
LABELV $2712
char 1 108
char 1 101
char 1 97
char 1 118
char 1 101
char 1 70
char 1 111
char 1 99
char 1 117
char 1 115
char 1 0
align 1
LABELV $2711
char 1 104
char 1 111
char 1 114
char 1 105
char 1 122
char 1 111
char 1 110
char 1 116
char 1 97
char 1 108
char 1 115
char 1 99
char 1 114
char 1 111
char 1 108
char 1 108
char 1 0
align 1
LABELV $2710
char 1 104
char 1 105
char 1 100
char 1 101
char 1 67
char 1 118
char 1 97
char 1 114
char 1 0
align 1
LABELV $2709
char 1 103
char 1 114
char 1 111
char 1 117
char 1 112
char 1 0
align 1
LABELV $2708
char 1 102
char 1 111
char 1 110
char 1 116
char 1 0
align 1
LABELV $2707
char 1 102
char 1 111
char 1 99
char 1 117
char 1 115
char 1 83
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $2706
char 1 102
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $2705
char 1 102
char 1 101
char 1 101
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $2704
char 1 101
char 1 110
char 1 97
char 1 98
char 1 108
char 1 101
char 1 67
char 1 118
char 1 97
char 1 114
char 1 0
align 1
LABELV $2703
char 1 101
char 1 108
char 1 101
char 1 109
char 1 101
char 1 110
char 1 116
char 1 119
char 1 105
char 1 100
char 1 116
char 1 104
char 1 0
align 1
LABELV $2702
char 1 101
char 1 108
char 1 101
char 1 109
char 1 101
char 1 110
char 1 116
char 1 116
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $2701
char 1 101
char 1 108
char 1 101
char 1 109
char 1 101
char 1 110
char 1 116
char 1 104
char 1 101
char 1 105
char 1 103
char 1 104
char 1 116
char 1 0
align 1
LABELV $2700
char 1 100
char 1 111
char 1 117
char 1 98
char 1 108
char 1 101
char 1 99
char 1 108
char 1 105
char 1 99
char 1 107
char 1 0
align 1
LABELV $2699
char 1 100
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 67
char 1 118
char 1 97
char 1 114
char 1 0
align 1
LABELV $2698
char 1 100
char 1 101
char 1 99
char 1 111
char 1 114
char 1 97
char 1 116
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $2697
char 1 100
char 1 101
char 1 115
char 1 99
char 1 116
char 1 101
char 1 120
char 1 116
char 1 0
align 1
LABELV $2696
char 1 99
char 1 118
char 1 97
char 1 114
char 1 84
char 1 101
char 1 115
char 1 116
char 1 0
align 1
LABELV $2695
char 1 99
char 1 118
char 1 97
char 1 114
char 1 83
char 1 116
char 1 114
char 1 76
char 1 105
char 1 115
char 1 116
char 1 0
align 1
LABELV $2694
char 1 99
char 1 118
char 1 97
char 1 114
char 1 70
char 1 108
char 1 111
char 1 97
char 1 116
char 1 76
char 1 105
char 1 115
char 1 116
char 1 0
align 1
LABELV $2693
char 1 99
char 1 118
char 1 97
char 1 114
char 1 70
char 1 108
char 1 111
char 1 97
char 1 116
char 1 0
align 1
LABELV $2692
char 1 99
char 1 118
char 1 97
char 1 114
char 1 0
align 1
LABELV $2691
char 1 99
char 1 111
char 1 108
char 1 117
char 1 109
char 1 110
char 1 115
char 1 0
align 1
LABELV $2690
char 1 99
char 1 105
char 1 110
char 1 101
char 1 109
char 1 97
char 1 116
char 1 105
char 1 99
char 1 0
align 1
LABELV $2689
char 1 98
char 1 111
char 1 114
char 1 100
char 1 101
char 1 114
char 1 115
char 1 105
char 1 122
char 1 101
char 1 0
align 1
LABELV $2688
char 1 98
char 1 111
char 1 114
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $2687
char 1 98
char 1 97
char 1 99
char 1 107
char 1 103
char 1 114
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $2686
char 1 97
char 1 115
char 1 115
char 1 101
char 1 116
char 1 95
char 1 115
char 1 104
char 1 97
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $2685
char 1 97
char 1 115
char 1 115
char 1 101
char 1 116
char 1 95
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 0
align 1
LABELV $2684
char 1 97
char 1 112
char 1 112
char 1 101
char 1 97
char 1 114
char 1 97
char 1 110
char 1 99
char 1 101
char 1 95
char 1 115
char 1 108
char 1 111
char 1 116
char 1 0
align 1
LABELV $2683
char 1 97
char 1 117
char 1 116
char 1 111
char 1 119
char 1 114
char 1 97
char 1 112
char 1 112
char 1 101
char 1 100
char 1 0
align 1
LABELV $2682
char 1 97
char 1 108
char 1 105
char 1 103
char 1 110
char 1 0
align 1
LABELV $2681
char 1 97
char 1 100
char 1 100
char 1 67
char 1 111
char 1 108
char 1 111
char 1 114
char 1 82
char 1 97
char 1 110
char 1 103
char 1 101
char 1 0
align 1
LABELV $2680
char 1 97
char 1 99
char 1 116
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $2619
char 1 101
char 1 110
char 1 100
char 1 32
char 1 111
char 1 102
char 1 32
char 1 102
char 1 105
char 1 108
char 1 101
char 1 32
char 1 105
char 1 110
char 1 115
char 1 105
char 1 100
char 1 101
char 1 32
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 105
char 1 116
char 1 101
char 1 109
char 1 10
char 1 0
align 1
LABELV $2491
char 1 94
char 1 51
char 1 85
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 32
char 1 116
char 1 101
char 1 120
char 1 116
char 1 32
char 1 97
char 1 108
char 1 105
char 1 103
char 1 110
char 1 109
char 1 101
char 1 110
char 1 116
char 1 32
char 1 118
char 1 97
char 1 108
char 1 117
char 1 101
char 1 0
align 1
LABELV $2433
char 1 94
char 1 51
char 1 85
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 32
char 1 105
char 1 116
char 1 101
char 1 109
char 1 32
char 1 115
char 1 116
char 1 121
char 1 108
char 1 101
char 1 32
char 1 118
char 1 97
char 1 108
char 1 117
char 1 101
char 1 0
align 1
LABELV $2429
char 1 94
char 1 51
char 1 85
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 32
char 1 105
char 1 116
char 1 101
char 1 109
char 1 32
char 1 115
char 1 116
char 1 121
char 1 108
char 1 101
char 1 32
char 1 118
char 1 97
char 1 108
char 1 117
char 1 101
char 1 32
char 1 39
char 1 37
char 1 115
char 1 39
char 1 0
align 1
LABELV $1873
char 1 70
char 1 73
char 1 88
char 1 77
char 1 69
char 1 0
align 1
LABELV $1838
char 1 63
char 1 63
char 1 63
char 1 0
align 1
LABELV $1837
char 1 32
char 1 37
char 1 115
char 1 32
char 1 0
align 1
LABELV $1836
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 51
char 1 95
char 1 75
char 1 69
char 1 89
char 1 66
char 1 73
char 1 78
char 1 68
char 1 95
char 1 79
char 1 82
char 1 0
align 1
LABELV $1783
char 1 99
char 1 103
char 1 95
char 1 116
char 1 104
char 1 105
char 1 114
char 1 100
char 1 112
char 1 101
char 1 114
char 1 115
char 1 111
char 1 110
char 1 32
char 1 33
char 1 0
align 1
LABELV $1782
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
LABELV $1781
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
LABELV $1780
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
LABELV $1779
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
LABELV $1778
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
LABELV $1777
char 1 105
char 1 110
char 1 118
char 1 112
char 1 114
char 1 101
char 1 118
char 1 0
align 1
LABELV $1776
char 1 105
char 1 110
char 1 118
char 1 110
char 1 101
char 1 120
char 1 116
char 1 0
align 1
LABELV $1775
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
LABELV $1774
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
LABELV $1773
char 1 43
char 1 117
char 1 115
char 1 101
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 0
align 1
LABELV $1772
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
LABELV $1771
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
LABELV $1770
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
LABELV $1769
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
LABELV $1768
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
LABELV $1767
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
LABELV $1766
char 1 43
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 100
char 1 114
char 1 97
char 1 105
char 1 110
char 1 0
align 1
LABELV $1765
char 1 43
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
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
char 1 0
align 1
LABELV $1764
char 1 43
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 95
char 1 103
char 1 114
char 1 105
char 1 112
char 1 0
align 1
LABELV $1763
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
LABELV $1762
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
LABELV $1761
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
LABELV $1760
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
LABELV $1759
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
LABELV $1758
char 1 43
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
char 1 0
align 1
LABELV $1757
char 1 109
char 1 101
char 1 115
char 1 115
char 1 97
char 1 103
char 1 101
char 1 109
char 1 111
char 1 100
char 1 101
char 1 52
char 1 0
align 1
LABELV $1756
char 1 109
char 1 101
char 1 115
char 1 115
char 1 97
char 1 103
char 1 101
char 1 109
char 1 111
char 1 100
char 1 101
char 1 51
char 1 0
align 1
LABELV $1755
char 1 109
char 1 101
char 1 115
char 1 115
char 1 97
char 1 103
char 1 101
char 1 109
char 1 111
char 1 100
char 1 101
char 1 50
char 1 0
align 1
LABELV $1754
char 1 109
char 1 101
char 1 115
char 1 115
char 1 97
char 1 103
char 1 101
char 1 109
char 1 111
char 1 100
char 1 101
char 1 0
align 1
LABELV $1753
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
LABELV $1752
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
LABELV $1751
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
LABELV $1750
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
LABELV $1749
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
LABELV $1748
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
LABELV $1747
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
LABELV $1746
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
LABELV $1745
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
LABELV $1744
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
LABELV $1743
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
LABELV $1742
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
LABELV $1741
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
LABELV $1740
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
LABELV $1739
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
LABELV $1738
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
LABELV $1737
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
LABELV $1736
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
LABELV $1735
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
LABELV $1734
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
LABELV $1733
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
LABELV $1732
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
LABELV $1731
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
LABELV $1730
char 1 43
char 1 116
char 1 97
char 1 117
char 1 110
char 1 116
char 1 0
align 1
LABELV $1729
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
LABELV $1728
char 1 43
char 1 117
char 1 115
char 1 101
char 1 0
align 1
LABELV $1727
char 1 43
char 1 97
char 1 108
char 1 116
char 1 97
char 1 116
char 1 116
char 1 97
char 1 99
char 1 107
char 1 0
align 1
LABELV $1726
char 1 43
char 1 97
char 1 116
char 1 116
char 1 97
char 1 99
char 1 107
char 1 0
align 1
LABELV $1725
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 49
char 1 51
char 1 0
align 1
LABELV $1724
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 49
char 1 50
char 1 0
align 1
LABELV $1723
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 49
char 1 49
char 1 0
align 1
LABELV $1722
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
LABELV $1721
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 49
char 1 48
char 1 0
align 1
LABELV $1720
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 57
char 1 0
align 1
LABELV $1719
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 56
char 1 0
align 1
LABELV $1718
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 55
char 1 0
align 1
LABELV $1717
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 54
char 1 0
align 1
LABELV $1716
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 53
char 1 0
align 1
LABELV $1715
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 52
char 1 0
align 1
LABELV $1714
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 51
char 1 0
align 1
LABELV $1713
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 50
char 1 0
align 1
LABELV $1712
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 49
char 1 0
align 1
LABELV $1711
char 1 99
char 1 101
char 1 110
char 1 116
char 1 101
char 1 114
char 1 118
char 1 105
char 1 101
char 1 119
char 1 0
align 1
LABELV $1710
char 1 43
char 1 109
char 1 108
char 1 111
char 1 111
char 1 107
char 1 0
align 1
LABELV $1709
char 1 43
char 1 108
char 1 111
char 1 111
char 1 107
char 1 100
char 1 111
char 1 119
char 1 110
char 1 0
align 1
LABELV $1708
char 1 43
char 1 108
char 1 111
char 1 111
char 1 107
char 1 117
char 1 112
char 1 0
align 1
LABELV $1707
char 1 43
char 1 115
char 1 116
char 1 114
char 1 97
char 1 102
char 1 101
char 1 0
align 1
LABELV $1706
char 1 43
char 1 114
char 1 105
char 1 103
char 1 104
char 1 116
char 1 0
align 1
LABELV $1705
char 1 43
char 1 108
char 1 101
char 1 102
char 1 116
char 1 0
align 1
LABELV $1704
char 1 43
char 1 109
char 1 111
char 1 118
char 1 101
char 1 100
char 1 111
char 1 119
char 1 110
char 1 0
align 1
LABELV $1703
char 1 43
char 1 109
char 1 111
char 1 118
char 1 101
char 1 117
char 1 112
char 1 0
align 1
LABELV $1702
char 1 43
char 1 109
char 1 111
char 1 118
char 1 101
char 1 114
char 1 105
char 1 103
char 1 104
char 1 116
char 1 0
align 1
LABELV $1701
char 1 43
char 1 109
char 1 111
char 1 118
char 1 101
char 1 108
char 1 101
char 1 102
char 1 116
char 1 0
align 1
LABELV $1700
char 1 43
char 1 98
char 1 97
char 1 99
char 1 107
char 1 0
align 1
LABELV $1699
char 1 43
char 1 102
char 1 111
char 1 114
char 1 119
char 1 97
char 1 114
char 1 100
char 1 0
align 1
LABELV $1698
char 1 43
char 1 115
char 1 112
char 1 101
char 1 101
char 1 100
char 1 0
align 1
LABELV $1697
char 1 43
char 1 98
char 1 117
char 1 116
char 1 116
char 1 111
char 1 110
char 1 50
char 1 0
align 1
LABELV $1696
char 1 43
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 0
align 1
LABELV $1677
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
LABELV $1676
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
LABELV $1520
char 1 115
char 1 99
char 1 114
char 1 101
char 1 101
char 1 110
char 1 115
char 1 104
char 1 111
char 1 116
char 1 10
char 1 0
align 1
LABELV $1516
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
LABELV $1362
char 1 115
char 1 108
char 1 105
char 1 100
char 1 101
char 1 114
char 1 32
char 1 104
char 1 97
char 1 110
char 1 100
char 1 108
char 1 101
char 1 32
char 1 107
char 1 101
char 1 121
char 1 32
char 1 101
char 1 120
char 1 105
char 1 116
char 1 10
char 1 0
align 1
LABELV $1140
char 1 37
char 1 102
char 1 0
align 1
LABELV $1086
char 1 37
char 1 105
char 1 0
align 1
LABELV $658
char 1 114
char 1 117
char 1 110
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
LABELV $657
char 1 100
char 1 101
char 1 102
char 1 101
char 1 114
char 1 0
align 1
LABELV $656
char 1 111
char 1 114
char 1 98
char 1 105
char 1 116
char 1 0
align 1
LABELV $655
char 1 112
char 1 108
char 1 97
char 1 121
char 1 108
char 1 111
char 1 111
char 1 112
char 1 101
char 1 100
char 1 0
align 1
LABELV $654
char 1 112
char 1 108
char 1 97
char 1 121
char 1 0
align 1
LABELV $653
char 1 101
char 1 120
char 1 101
char 1 99
char 1 0
align 1
LABELV $652
char 1 115
char 1 101
char 1 116
char 1 99
char 1 118
char 1 97
char 1 114
char 1 116
char 1 111
char 1 99
char 1 118
char 1 97
char 1 114
char 1 0
align 1
LABELV $651
char 1 115
char 1 101
char 1 116
char 1 99
char 1 118
char 1 97
char 1 114
char 1 0
align 1
LABELV $650
char 1 116
char 1 114
char 1 97
char 1 110
char 1 115
char 1 105
char 1 116
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $649
char 1 115
char 1 101
char 1 116
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 104
char 1 101
char 1 97
char 1 100
char 1 0
align 1
LABELV $648
char 1 115
char 1 101
char 1 116
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 0
align 1
LABELV $647
char 1 115
char 1 101
char 1 116
char 1 102
char 1 111
char 1 99
char 1 117
char 1 115
char 1 0
align 1
LABELV $646
char 1 115
char 1 101
char 1 116
char 1 116
char 1 101
char 1 97
char 1 109
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $645
char 1 115
char 1 101
char 1 116
char 1 105
char 1 116
char 1 101
char 1 109
char 1 114
char 1 101
char 1 99
char 1 116
char 1 0
align 1
LABELV $644
char 1 115
char 1 101
char 1 116
char 1 105
char 1 116
char 1 101
char 1 109
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $643
char 1 115
char 1 101
char 1 116
char 1 98
char 1 97
char 1 99
char 1 107
char 1 103
char 1 114
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $642
char 1 115
char 1 101
char 1 116
char 1 97
char 1 115
char 1 115
char 1 101
char 1 116
char 1 0
align 1
LABELV $641
char 1 99
char 1 108
char 1 111
char 1 115
char 1 101
char 1 0
align 1
LABELV $640
char 1 111
char 1 112
char 1 101
char 1 110
char 1 0
align 1
LABELV $639
char 1 115
char 1 101
char 1 116
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $638
char 1 104
char 1 105
char 1 100
char 1 101
char 1 0
align 1
LABELV $637
char 1 115
char 1 104
char 1 111
char 1 119
char 1 0
align 1
LABELV $636
char 1 102
char 1 97
char 1 100
char 1 101
char 1 111
char 1 117
char 1 116
char 1 0
align 1
LABELV $635
char 1 102
char 1 97
char 1 100
char 1 101
char 1 105
char 1 110
char 1 0
align 1
LABELV $628
char 1 37
char 1 115
char 1 32
char 1 59
char 1 32
char 1 0
align 1
LABELV $618
char 1 116
char 1 101
char 1 97
char 1 109
char 1 95
char 1 104
char 1 101
char 1 97
char 1 100
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 0
align 1
LABELV $614
char 1 116
char 1 101
char 1 97
char 1 109
char 1 95
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 0
align 1
LABELV $570
char 1 97
char 1 108
char 1 108
char 1 0
align 1
LABELV $428
char 1 98
char 1 111
char 1 114
char 1 100
char 1 101
char 1 114
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $425
char 1 102
char 1 111
char 1 114
char 1 101
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $422
char 1 98
char 1 97
char 1 99
char 1 107
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $258
char 1 32
char 1 0
align 1
LABELV $255
char 1 34
char 1 37
char 1 115
char 1 34
char 1 0
align 1
LABELV $242
char 1 123
char 1 0
align 1
LABELV $229
char 1 94
char 1 51
char 1 85
char 1 110
char 1 97
char 1 98
char 1 108
char 1 101
char 1 32
char 1 116
char 1 111
char 1 32
char 1 108
char 1 111
char 1 99
char 1 97
char 1 116
char 1 101
char 1 32
char 1 83
char 1 116
char 1 114
char 1 105
char 1 112
char 1 69
char 1 100
char 1 32
char 1 116
char 1 101
char 1 120
char 1 116
char 1 32
char 1 39
char 1 37
char 1 115
char 1 39
char 1 10
char 1 0
align 1
LABELV $220
char 1 125
char 1 0
align 1
LABELV $192
char 1 101
char 1 120
char 1 112
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 105
char 1 110
char 1 116
char 1 101
char 1 103
char 1 101
char 1 114
char 1 32
char 1 98
char 1 117
char 1 116
char 1 32
char 1 102
char 1 111
char 1 117
char 1 110
char 1 100
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $159
char 1 101
char 1 120
char 1 112
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 102
char 1 108
char 1 111
char 1 97
char 1 116
char 1 32
char 1 98
char 1 117
char 1 116
char 1 32
char 1 102
char 1 111
char 1 117
char 1 110
char 1 100
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $136
char 1 94
char 1 49
char 1 69
char 1 82
char 1 82
char 1 79
char 1 82
char 1 58
char 1 32
char 1 37
char 1 115
char 1 44
char 1 32
char 1 108
char 1 105
char 1 110
char 1 101
char 1 32
char 1 37
char 1 100
char 1 58
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $132
char 1 94
char 1 51
char 1 87
char 1 65
char 1 82
char 1 78
char 1 73
char 1 78
char 1 71
char 1 58
char 1 32
char 1 37
char 1 115
char 1 44
char 1 32
char 1 108
char 1 105
char 1 110
char 1 101
char 1 32
char 1 37
char 1 100
char 1 58
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $121
char 1 77
char 1 101
char 1 109
char 1 111
char 1 114
char 1 121
char 1 32
char 1 80
char 1 111
char 1 111
char 1 108
char 1 32
char 1 105
char 1 115
char 1 32
char 1 37
char 1 46
char 1 49
char 1 102
char 1 37
char 1 37
char 1 32
char 1 102
char 1 117
char 1 108
char 1 108
char 1 44
char 1 32
char 1 37
char 1 105
char 1 32
char 1 98
char 1 121
char 1 116
char 1 101
char 1 115
char 1 32
char 1 111
char 1 117
char 1 116
char 1 32
char 1 111
char 1 102
char 1 32
char 1 37
char 1 105
char 1 32
char 1 117
char 1 115
char 1 101
char 1 100
char 1 46
char 1 10
char 1 0
align 1
LABELV $120
char 1 83
char 1 116
char 1 114
char 1 105
char 1 110
char 1 103
char 1 32
char 1 80
char 1 111
char 1 111
char 1 108
char 1 32
char 1 105
char 1 115
char 1 32
char 1 37
char 1 46
char 1 49
char 1 102
char 1 37
char 1 37
char 1 32
char 1 102
char 1 117
char 1 108
char 1 108
char 1 44
char 1 32
char 1 37
char 1 105
char 1 32
char 1 98
char 1 121
char 1 116
char 1 101
char 1 115
char 1 32
char 1 111
char 1 117
char 1 116
char 1 32
char 1 111
char 1 102
char 1 32
char 1 37
char 1 105
char 1 32
char 1 117
char 1 115
char 1 101
char 1 100
char 1 46
char 1 10
char 1 0
align 1
LABELV $119
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 45
char 1 10
char 1 0
align 1
LABELV $118
char 1 77
char 1 101
char 1 109
char 1 111
char 1 114
char 1 121
char 1 47
char 1 83
char 1 116
char 1 114
char 1 105
char 1 110
char 1 103
char 1 32
char 1 80
char 1 111
char 1 111
char 1 108
char 1 32
char 1 73
char 1 110
char 1 102
char 1 111
char 1 10
char 1 0
align 1
LABELV $99
char 1 0
align 1
LABELV $90
char 1 85
char 1 73
char 1 95
char 1 65
char 1 108
char 1 108
char 1 111
char 1 99
char 1 58
char 1 32
char 1 70
char 1 97
char 1 105
char 1 108
char 1 117
char 1 114
char 1 101
char 1 46
char 1 32
char 1 79
char 1 117
char 1 116
char 1 32
char 1 111
char 1 102
char 1 32
char 1 109
char 1 101
char 1 109
char 1 111
char 1 114
char 1 121
char 1 33
char 1 10
char 1 0
align 1
LABELV $84
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 84
char 1 69
char 1 88
char 1 84
char 1 83
char 1 67
char 1 82
char 1 79
char 1 76
char 1 76
char 1 0
align 1
LABELV $83
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 66
char 1 73
char 1 78
char 1 68
char 1 0
align 1
LABELV $82
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 77
char 1 85
char 1 76
char 1 84
char 1 73
char 1 0
align 1
LABELV $81
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 89
char 1 69
char 1 83
char 1 78
char 1 79
char 1 0
align 1
LABELV $80
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 83
char 1 76
char 1 73
char 1 68
char 1 69
char 1 82
char 1 0
align 1
LABELV $79
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 78
char 1 85
char 1 77
char 1 69
char 1 82
char 1 73
char 1 67
char 1 70
char 1 73
char 1 69
char 1 76
char 1 68
char 1 0
align 1
LABELV $78
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 79
char 1 87
char 1 78
char 1 69
char 1 82
char 1 68
char 1 82
char 1 65
char 1 87
char 1 0
align 1
LABELV $77
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 77
char 1 79
char 1 68
char 1 69
char 1 76
char 1 0
align 1
LABELV $76
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 76
char 1 73
char 1 83
char 1 84
char 1 66
char 1 79
char 1 88
char 1 0
align 1
LABELV $75
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 67
char 1 79
char 1 77
char 1 66
char 1 79
char 1 0
align 1
LABELV $74
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 69
char 1 68
char 1 73
char 1 84
char 1 70
char 1 73
char 1 69
char 1 76
char 1 68
char 1 0
align 1
LABELV $73
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 67
char 1 72
char 1 69
char 1 67
char 1 75
char 1 66
char 1 79
char 1 88
char 1 0
align 1
LABELV $72
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 82
char 1 65
char 1 68
char 1 73
char 1 79
char 1 66
char 1 85
char 1 84
char 1 84
char 1 79
char 1 78
char 1 0
align 1
LABELV $71
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 66
char 1 85
char 1 84
char 1 84
char 1 79
char 1 78
char 1 0
align 1
LABELV $70
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 84
char 1 89
char 1 80
char 1 69
char 1 95
char 1 84
char 1 69
char 1 88
char 1 84
char 1 0
align 1
LABELV $69
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 65
char 1 76
char 1 73
char 1 71
char 1 78
char 1 95
char 1 82
char 1 73
char 1 71
char 1 72
char 1 84
char 1 0
align 1
LABELV $68
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 65
char 1 76
char 1 73
char 1 71
char 1 78
char 1 95
char 1 67
char 1 69
char 1 78
char 1 84
char 1 69
char 1 82
char 1 0
align 1
LABELV $67
char 1 73
char 1 84
char 1 69
char 1 77
char 1 95
char 1 65
char 1 76
char 1 73
char 1 71
char 1 78
char 1 95
char 1 76
char 1 69
char 1 70
char 1 84
char 1 0
align 1
LABELV $66
char 1 87
char 1 73
char 1 78
char 1 68
char 1 79
char 1 87
char 1 95
char 1 83
char 1 84
char 1 89
char 1 76
char 1 69
char 1 95
char 1 67
char 1 73
char 1 78
char 1 69
char 1 77
char 1 65
char 1 84
char 1 73
char 1 67
char 1 0
align 1
LABELV $65
char 1 87
char 1 73
char 1 78
char 1 68
char 1 79
char 1 87
char 1 95
char 1 83
char 1 84
char 1 89
char 1 76
char 1 69
char 1 95
char 1 84
char 1 69
char 1 65
char 1 77
char 1 67
char 1 79
char 1 76
char 1 79
char 1 82
char 1 0
align 1
LABELV $64
char 1 87
char 1 73
char 1 78
char 1 68
char 1 79
char 1 87
char 1 95
char 1 83
char 1 84
char 1 89
char 1 76
char 1 69
char 1 95
char 1 83
char 1 72
char 1 65
char 1 68
char 1 69
char 1 82
char 1 0
align 1
LABELV $63
char 1 87
char 1 73
char 1 78
char 1 68
char 1 79
char 1 87
char 1 95
char 1 83
char 1 84
char 1 89
char 1 76
char 1 69
char 1 95
char 1 71
char 1 82
char 1 65
char 1 68
char 1 73
char 1 69
char 1 78
char 1 84
char 1 0
align 1
LABELV $62
char 1 87
char 1 73
char 1 78
char 1 68
char 1 79
char 1 87
char 1 95
char 1 83
char 1 84
char 1 89
char 1 76
char 1 69
char 1 95
char 1 70
char 1 73
char 1 76
char 1 76
char 1 69
char 1 68
char 1 0
align 1
LABELV $61
char 1 87
char 1 73
char 1 78
char 1 68
char 1 79
char 1 87
char 1 95
char 1 83
char 1 84
char 1 89
char 1 76
char 1 69
char 1 95
char 1 69
char 1 77
char 1 80
char 1 84
char 1 89
char 1 0
align 1
LABELV $60
char 1 87
char 1 73
char 1 78
char 1 68
char 1 79
char 1 87
char 1 95
char 1 73
char 1 78
char 1 65
char 1 67
char 1 84
char 1 73
char 1 86
char 1 69
char 1 0
