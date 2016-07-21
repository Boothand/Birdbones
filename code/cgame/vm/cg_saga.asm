export CGSagaGetValueGroup
code
proc CGSagaGetValueGroup 44 8
file "../cg_saga.c"
line 15
;1:#include "cg_local.h"
;2:#include "bg_saga.h"
;3:
;4:#define DEFAULT_WIN_OBJECTIVE		"sound/chars/kyle/prototype/personal.mp3"
;5:#define DEFAULT_LOSE_OBJECTIVE		"sound/chars/kyle/prototype/isntworking.mp3"
;6:
;7:#define DEFAULT_WIN_ROUND			"sound/chars/kyle/prototype/personal.mp3"
;8:#define DEFAULT_LOSE_ROUND			"sound/chars/kyle/prototype/isntworking.mp3"
;9:
;10:char		cg_saga_info[MAX_SAGA_INFO_SIZE];
;11:int			cg_saga_valid;
;12:
;13://The following two functions are very cheap parsing functions
;14:int CGSagaGetValueGroup(char *buf, char *group, char *outbuf)
;15:{
line 21
;16:	char *place, *placesecond;
;17:	int iplace;
;18:	int failure;
;19:	int i;
;20:	int startpoint, startletter;
;21:	int subg = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 23
;22:
;23:	i = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 25
;24:
;25:	iplace = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 27
;26:
;27:	place = strstr(buf, group);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 29
;28:
;29:	if (!place)
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $121
line 30
;30:	{
line 31
;31:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $120
JUMPV
LABELV $121
line 34
;32:	}
;33:
;34:	startpoint = place - buf + strlen(group) + 1;
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 36
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ASGNI4
line 35
;35:	startletter = (place - buf) - 1;
ADDRLP4 20
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
SUBI4
ASGNI4
line 37
;36:
;37:	failure = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $123
line 40
;38:
;39:	while (buf[startpoint+1] != '{' || buf[startletter] != '\n')
;40:	{
line 41
;41:		placesecond = strstr(place+1, group);
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 43
;42:
;43:		if (placesecond)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $126
line 44
;44:		{
line 45
;45:			startpoint += (placesecond - place);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDI4
ASGNI4
line 46
;46:			startletter += (placesecond - place);
ADDRLP4 20
ADDRLP4 20
INDIRI4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDI4
ASGNI4
line 47
;47:			place = placesecond;
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
line 48
;48:		}
ADDRGP4 $127
JUMPV
LABELV $126
line 50
;49:		else
;50:		{
line 51
;51:			failure = 1;
ADDRLP4 24
CNSTI4 1
ASGNI4
line 52
;52:			break;
ADDRGP4 $125
JUMPV
LABELV $127
line 54
;53:		}
;54:	}
LABELV $124
line 39
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 40
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $123
ADDRLP4 20
INDIRI4
ADDRLP4 40
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $123
LABELV $125
line 56
;55:
;56:	if (failure)
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $131
line 57
;57:	{
line 58
;58:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $120
JUMPV
LABELV $130
line 65
;59:	}
;60:
;61:	//we have found the proper group name if we made it here, so find the opening brace and read into the outbuf
;62:	//until hitting the end brace
;63:
;64:	while (buf[startpoint] != '{')
;65:	{
line 66
;66:		startpoint++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 67
;67:	}
LABELV $131
line 64
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $130
line 69
;68:
;69:	startpoint++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $134
JUMPV
LABELV $133
line 72
;70:
;71:	while (buf[startpoint] != '}' || subg)
;72:	{
line 73
;73:		if (buf[startpoint] == '{')
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $136
line 74
;74:		{
line 75
;75:			subg++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 76
;76:		}
ADDRGP4 $137
JUMPV
LABELV $136
line 77
;77:		else if (buf[startpoint] == '}')
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $138
line 78
;78:		{
line 79
;79:			subg--;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 80
;80:		}
LABELV $138
LABELV $137
line 81
;81:		outbuf[i] = buf[startpoint];
ADDRLP4 12
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 82
;82:		i++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 83
;83:		startpoint++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 84
;84:	}
LABELV $134
line 71
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $133
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $133
line 85
;85:	outbuf[i] = '\0';
ADDRLP4 12
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 87
;86:
;87:	return 1;
CNSTI4 1
RETI4
LABELV $120
endproc CGSagaGetValueGroup 44 8
export CGSagaGetPairedValue
proc CGSagaGetPairedValue 64 8
line 91
;88:}
;89:
;90:int CGSagaGetPairedValue(char *buf, char *key, char *outbuf, int inquotes)
;91:{
line 96
;92:	char *place, *placesecond;
;93:	int startpoint, startletter;
;94:	int i, found;
;95:
;96:	if (!buf || !key || !outbuf)
ADDRLP4 24
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRU4
EQU4 $144
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRU4
EQU4 $144
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRU4
NEU4 $141
LABELV $144
line 97
;97:	{
line 98
;98:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $140
JUMPV
LABELV $141
line 101
;99:	}
;100:
;101:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $146
JUMPV
LABELV $145
line 104
;102:
;103:	while (buf[i] && buf[i] != '\0')
;104:	{
line 105
;105:		if (buf[i] == '/')
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $148
line 106
;106:		{
line 107
;107:			if (buf[i+1] && buf[i+1] != '\0' && buf[i+1] == '/')
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $150
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $150
ADDRLP4 28
INDIRI4
CNSTI4 47
NEI4 $150
line 108
;108:			{
ADDRGP4 $153
JUMPV
LABELV $152
line 110
;109:				while (buf[i] != '\n')
;110:				{
line 111
;111:					buf[i] = '/';
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 47
ASGNI1
line 112
;112:					i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 113
;113:				}
LABELV $153
line 109
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $152
line 114
;114:			}
LABELV $150
line 115
;115:		}
LABELV $148
line 116
;116:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 117
;117:	}
LABELV $146
line 103
ADDRLP4 28
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $155
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $145
LABELV $155
line 119
;118:
;119:	place = strstr(buf, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 36
INDIRP4
ASGNP4
line 121
;120:
;121:	if (!place)
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $156
line 122
;122:	{
line 123
;123:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $140
JUMPV
LABELV $156
line 126
;124:	}
;125:	//tab == 9
;126:	startpoint = place - buf + strlen(key);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 40
INDIRI4
ADDI4
ASGNI4
line 127
;127:	startletter = (place - buf) - 1;
ADDRLP4 8
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
SUBI4
ASGNI4
line 129
;128:
;129:	found = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $159
JUMPV
LABELV $158
line 132
;130:
;131:	while (!found)
;132:	{
line 133
;133:		if (startletter == 0 || !buf[startletter] || buf[startletter] == '\0' || buf[startletter] == 9 || buf[startletter] == ' ' || buf[startletter] == '\n')
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $167
ADDRLP4 52
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $167
ADDRLP4 52
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $167
ADDRLP4 52
INDIRI4
CNSTI4 9
EQI4 $167
ADDRLP4 52
INDIRI4
CNSTI4 32
EQI4 $167
ADDRLP4 52
INDIRI4
CNSTI4 10
NEI4 $161
LABELV $167
line 134
;134:		{
line 135
;135:			if (buf[startpoint] == '\0' || buf[startpoint] == 9 || buf[startpoint] == ' ' || buf[startpoint] == '\n')
ADDRLP4 56
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $172
ADDRLP4 56
INDIRI4
CNSTI4 9
EQI4 $172
ADDRLP4 56
INDIRI4
CNSTI4 32
EQI4 $172
ADDRLP4 56
INDIRI4
CNSTI4 10
NEI4 $168
LABELV $172
line 136
;136:			{
line 137
;137:				found = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 138
;138:				break;
ADDRGP4 $160
JUMPV
LABELV $168
line 140
;139:			}
;140:		}
LABELV $161
line 142
;141:
;142:		placesecond = strstr(place+1, key);
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 56
INDIRP4
ASGNP4
line 144
;143:
;144:		if (placesecond)
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $173
line 145
;145:		{
line 146
;146:			startpoint += placesecond - place;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDI4
ASGNI4
line 147
;147:			startletter += placesecond - place;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDI4
ASGNI4
line 148
;148:			place = placesecond;
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 149
;149:		}
ADDRGP4 $174
JUMPV
LABELV $173
line 151
;150:		else
;151:		{
line 152
;152:			place = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 153
;153:			break;
ADDRGP4 $160
JUMPV
LABELV $174
line 156
;154:		}
;155:
;156:	}
LABELV $159
line 131
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $158
LABELV $160
line 158
;157:
;158:	if (!found || !place || !buf[startpoint] || buf[startpoint] == '\0')
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $179
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $179
ADDRLP4 48
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $179
ADDRLP4 48
INDIRI4
ADDRLP4 44
INDIRI4
NEI4 $181
LABELV $179
line 159
;159:	{
line 160
;160:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $140
JUMPV
LABELV $180
line 164
;161:	}
;162:
;163:	while (buf[startpoint] == ' ' || buf[startpoint] == 9 || buf[startpoint] == '\n')
;164:	{
line 165
;165:		startpoint++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 166
;166:	}
LABELV $181
line 163
ADDRLP4 52
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 32
EQI4 $180
ADDRLP4 52
INDIRI4
CNSTI4 9
EQI4 $180
ADDRLP4 52
INDIRI4
CNSTI4 10
EQI4 $180
line 168
;167:
;168:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 170
;169:
;170:	if (inquotes)
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $190
line 171
;171:	{
ADDRGP4 $186
JUMPV
LABELV $185
line 173
;172:		while (buf[startpoint] && buf[startpoint] != '\"')
;173:		{
line 174
;174:			startpoint++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 175
;175:		}
LABELV $186
line 172
ADDRLP4 56
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $188
ADDRLP4 56
INDIRI4
CNSTI4 34
NEI4 $185
LABELV $188
line 177
;176:
;177:		startpoint++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 178
;178:	}
ADDRGP4 $190
JUMPV
LABELV $189
line 181
;179:
;180:	while (buf[startpoint] && buf[startpoint] != '\0' && buf[startpoint] != '\n')
;181:	{
line 182
;182:		outbuf[i] = buf[startpoint];
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 183
;183:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 184
;184:		startpoint++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 186
;185:
;186:		if (inquotes && buf[startpoint] == '\"')
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $192
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 34
NEI4 $192
line 187
;187:		{
line 188
;188:			break;
ADDRGP4 $191
JUMPV
LABELV $192
line 190
;189:		}
;190:	}
LABELV $190
line 180
ADDRLP4 56
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $195
ADDRLP4 56
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $195
ADDRLP4 56
INDIRI4
CNSTI4 10
NEI4 $189
LABELV $195
LABELV $191
line 192
;191:
;192:	outbuf[i] = '\0';
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 194
;193:
;194:	return 1;
CNSTI4 1
RETI4
LABELV $140
endproc CGSagaGetPairedValue 64 8
export CG_InitSagaMode
proc CG_InitSagaMode 544 16
line 198
;195:}
;196:
;197:void CG_InitSagaMode(void)
;198:{
line 200
;199:	char			levelname[512];
;200:	int				len = 0;
ADDRLP4 516
CNSTI4 0
ASGNI4
line 201
;201:	int				i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 204
;202:	fileHandle_t	f;
;203:
;204:	if (cgs.gametype != GT_SAGA)
ADDRGP4 cgs+32960
INDIRI4
CNSTI4 6
EQI4 $197
line 205
;205:	{
line 206
;206:		goto failure;
ADDRGP4 $200
JUMPV
LABELV $197
line 209
;207:	}
;208:
;209:	Com_sprintf(levelname, sizeof(levelname), "%s\0", cgs.mapname);
ADDRLP4 4
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 $201
ARGP4
ADDRGP4 cgs+32992
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 211
;210:
;211:	i = strlen(levelname)-1;
ADDRLP4 4
ARGP4
ADDRLP4 524
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 524
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $204
JUMPV
LABELV $203
line 214
;212:
;213:	while (i > 0 && levelname[i] && levelname[i] != '.')
;214:	{
line 215
;215:		i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 216
;216:	}
LABELV $204
line 213
ADDRLP4 532
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 532
INDIRI4
LEI4 $207
ADDRLP4 536
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 536
INDIRI4
ADDRLP4 532
INDIRI4
EQI4 $207
ADDRLP4 536
INDIRI4
CNSTI4 46
NEI4 $203
LABELV $207
line 218
;217:
;218:	if (!i)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $208
line 219
;219:	{
line 220
;220:		goto failure;
ADDRGP4 $200
JUMPV
LABELV $208
line 223
;221:	}
;222:
;223:	levelname[i] = '\0'; //kill the ".bsp"
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 225
;224:
;225:	Com_sprintf(levelname, sizeof(levelname), "%s.saga\0", levelname); 
ADDRLP4 4
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 227
;226:
;227:	if (!levelname || !levelname[0])
ADDRLP4 4
CVPU4 4
CNSTU4 0
EQU4 $213
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $211
LABELV $213
line 228
;228:	{
line 229
;229:		goto failure;
ADDRGP4 $200
JUMPV
LABELV $211
line 232
;230:	}
;231:
;232:	len = trap_FS_FOpenFile(levelname, &f, FS_READ);
ADDRLP4 4
ARGP4
ADDRLP4 520
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 540
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 516
ADDRLP4 540
INDIRI4
ASGNI4
line 234
;233:
;234:	if (!f || len >= MAX_SAGA_INFO_SIZE)
ADDRLP4 520
INDIRI4
CNSTI4 0
EQI4 $216
ADDRLP4 516
INDIRI4
CNSTI4 8192
LTI4 $214
LABELV $216
line 235
;235:	{
line 236
;236:		goto failure;
ADDRGP4 $200
JUMPV
LABELV $214
line 239
;237:	}
;238:
;239:	trap_FS_Read(cg_saga_info, len, f);
ADDRGP4 cg_saga_info
ARGP4
ADDRLP4 516
INDIRI4
ARGI4
ADDRLP4 520
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 241
;240:
;241:	cg_saga_valid = 1;
ADDRGP4 cg_saga_valid
CNSTI4 1
ASGNI4
line 243
;242:
;243:	return;
ADDRGP4 $196
JUMPV
LABELV $200
line 246
;244:
;245:failure:
;246:	cg_saga_valid = 0;
ADDRGP4 cg_saga_valid
CNSTI4 0
ASGNI4
line 247
;247:}
LABELV $196
endproc CG_InitSagaMode 544 16
export CG_SagaRoundOver
proc CG_SagaRoundOver 10324 16
line 250
;248:
;249:void CG_SagaRoundOver(centity_t *ent, int won)
;250:{
line 256
;251:	int				myTeam;
;252:	char			teamstr[64];
;253:	char			objectives[MAX_SAGA_INFO_SIZE];
;254:	char			appstring[1024];
;255:	char			soundstr[1024];
;256:	int				success = 0;
ADDRLP4 8260
CNSTI4 0
ASGNI4
line 258
;257:
;258:	if (!cg_saga_valid)
ADDRGP4 cg_saga_valid
INDIRI4
CNSTI4 0
NEI4 $218
line 259
;259:	{
line 260
;260:		Com_Printf("ERROR: Saga data does not exist on client!\n");
ADDRGP4 $220
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 261
;261:		return;
ADDRGP4 $217
JUMPV
LABELV $218
line 264
;262:	}
;263:
;264:	if (!cg.snap)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $221
line 265
;265:	{
line 266
;266:		return; //yikes
ADDRGP4 $217
JUMPV
LABELV $221
line 269
;267:	}
;268:
;269:	myTeam = cg.snap->ps.persistant[PERS_TEAM];
ADDRLP4 64
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
ASGNI4
line 271
;270:
;271:	if (myTeam == TEAM_SPECTATOR)
ADDRLP4 64
INDIRI4
CNSTI4 3
NEI4 $225
line 272
;272:	{
line 273
;273:		return;
ADDRGP4 $217
JUMPV
LABELV $225
line 276
;274:	}
;275:
;276:	if (myTeam == SAGATEAM_IMPERIAL)
ADDRLP4 64
INDIRI4
CNSTI4 1
NEI4 $227
line 277
;277:	{
line 278
;278:		Com_sprintf(teamstr, sizeof(teamstr), "Imperial");
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $229
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 279
;279:	}
ADDRGP4 $228
JUMPV
LABELV $227
line 281
;280:	else
;281:	{
line 282
;282:		Com_sprintf(teamstr, sizeof(teamstr), "Rebel");
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $230
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 283
;283:	}
LABELV $228
line 285
;284:
;285:	if (CGSagaGetValueGroup(cg_saga_info, teamstr, objectives))
ADDRGP4 cg_saga_info
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 10312
ADDRGP4 CGSagaGetValueGroup
CALLI4
ASGNI4
ADDRLP4 10312
INDIRI4
CNSTI4 0
EQI4 $231
line 286
;286:	{
line 287
;287:		if (won == myTeam)
ADDRFP4 4
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $233
line 288
;288:		{
line 289
;289:			success = CGSagaGetPairedValue(objectives, "wonround", appstring, 1);
ADDRLP4 68
ARGP4
ADDRGP4 $235
ARGP4
ADDRLP4 8264
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 10316
ADDRGP4 CGSagaGetPairedValue
CALLI4
ASGNI4
ADDRLP4 8260
ADDRLP4 10316
INDIRI4
ASGNI4
line 290
;290:		}
ADDRGP4 $234
JUMPV
LABELV $233
line 292
;291:		else
;292:		{
line 293
;293:			success = CGSagaGetPairedValue(objectives, "lostround", appstring, 1);
ADDRLP4 68
ARGP4
ADDRGP4 $236
ARGP4
ADDRLP4 8264
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 10316
ADDRGP4 CGSagaGetPairedValue
CALLI4
ASGNI4
ADDRLP4 8260
ADDRLP4 10316
INDIRI4
ASGNI4
line 294
;294:		}
LABELV $234
line 296
;295:
;296:		if (success)
ADDRLP4 8260
INDIRI4
CNSTI4 0
EQI4 $237
line 297
;297:		{
line 298
;298:			Com_Printf("%s\n", appstring);
ADDRGP4 $239
ARGP4
ADDRLP4 8264
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 299
;299:		}
LABELV $237
line 301
;300:
;301:		if (myTeam == won)
ADDRLP4 64
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $240
line 302
;302:		{
line 303
;303:			Com_sprintf(teamstr, sizeof(teamstr), "roundover_sound_wewon");
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $242
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 304
;304:		}
ADDRGP4 $241
JUMPV
LABELV $240
line 306
;305:		else
;306:		{
line 307
;307:			Com_sprintf(teamstr, sizeof(teamstr), "roundover_sound_welost");
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $243
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 308
;308:		}
LABELV $241
line 310
;309:
;310:		if (CGSagaGetPairedValue(objectives, teamstr, appstring, 1))
ADDRLP4 68
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8264
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 10316
ADDRGP4 CGSagaGetPairedValue
CALLI4
ASGNI4
ADDRLP4 10316
INDIRI4
CNSTI4 0
EQI4 $244
line 311
;311:		{
line 312
;312:			Com_sprintf(soundstr, sizeof(soundstr), appstring);
ADDRLP4 9288
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 8264
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 313
;313:		}
ADDRGP4 $245
JUMPV
LABELV $244
line 315
;314:		else
;315:		{
line 316
;316:			if (myTeam != won)
ADDRLP4 64
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $246
line 317
;317:			{
line 318
;318:				Com_sprintf(soundstr, sizeof(soundstr), DEFAULT_LOSE_ROUND);
ADDRLP4 9288
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $248
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 319
;319:			}
ADDRGP4 $247
JUMPV
LABELV $246
line 321
;320:			else
;321:			{
line 322
;322:				Com_sprintf(soundstr, sizeof(soundstr), DEFAULT_WIN_ROUND);
ADDRLP4 9288
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $249
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 323
;323:			}
LABELV $247
line 324
;324:		}
LABELV $245
line 326
;325:
;326:		trap_S_StartLocalSound(trap_S_RegisterSound(soundstr), CHAN_ANNOUNCER);
ADDRLP4 9288
ARGP4
ADDRLP4 10320
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 10320
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 328
;327:		//Com_Printf("Play sound: %s\n", soundstr);
;328:	}
LABELV $231
line 329
;329:}
LABELV $217
endproc CG_SagaRoundOver 10324 16
export CG_SagaObjectiveCompleted
proc CG_SagaObjectiveCompleted 18784 16
line 332
;330:
;331:void CG_SagaObjectiveCompleted(centity_t *ent, int won, int objectivenum)
;332:{
line 340
;333:	int				myTeam;
;334:	char			teamstr[64];
;335:	char			objstr[256];
;336:	char			objectives[MAX_SAGA_INFO_SIZE];
;337:	char			foundobjective[MAX_SAGA_INFO_SIZE];
;338:	char			appstring[1024];
;339:	char			soundstr[1024];
;340:	int				success = 0;
ADDRLP4 8524
CNSTI4 0
ASGNI4
line 341
;341:	int				i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 342
;342:	int				i_r = 0;
ADDRLP4 8196
CNSTI4 0
ASGNI4
line 344
;343:
;344:	if (!cg_saga_valid)
ADDRGP4 cg_saga_valid
INDIRI4
CNSTI4 0
NEI4 $251
line 345
;345:	{
line 346
;346:		Com_Printf("ERROR: Saga data does not exist on client!\n");
ADDRGP4 $220
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 347
;347:		return;
ADDRGP4 $250
JUMPV
LABELV $251
line 350
;348:	}
;349:
;350:	if (!cg.snap)
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $253
line 351
;351:	{
line 352
;352:		return; //yikes
ADDRGP4 $250
JUMPV
LABELV $253
line 355
;353:	}
;354:
;355:	myTeam = cg.snap->ps.persistant[PERS_TEAM];
ADDRLP4 8264
ADDRGP4 cg+36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
ASGNI4
line 357
;356:
;357:	if (myTeam == TEAM_SPECTATOR)
ADDRLP4 8264
INDIRI4
CNSTI4 3
NEI4 $257
line 358
;358:	{
line 359
;359:		return;
ADDRGP4 $250
JUMPV
LABELV $257
line 362
;360:	}
;361:
;362:	if (won == SAGATEAM_IMPERIAL)
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $259
line 363
;363:	{
line 364
;364:		Com_sprintf(teamstr, sizeof(teamstr), "Imperial");
ADDRLP4 8200
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $229
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 365
;365:	}
ADDRGP4 $260
JUMPV
LABELV $259
line 367
;366:	else
;367:	{
line 368
;368:		Com_sprintf(teamstr, sizeof(teamstr), "Rebel");
ADDRLP4 8200
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $230
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 369
;369:	}
LABELV $260
line 371
;370:
;371:	if (CGSagaGetValueGroup(cg_saga_info, teamstr, objectives))
ADDRGP4 cg_saga_info
ARGP4
ADDRLP4 8200
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 18768
ADDRGP4 CGSagaGetValueGroup
CALLI4
ASGNI4
ADDRLP4 18768
INDIRI4
CNSTI4 0
EQI4 $261
line 372
;372:	{
line 373
;373:		Com_sprintf(objstr, sizeof(objstr), "Objective%i", objectivenum);
ADDRLP4 8268
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $263
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $265
JUMPV
LABELV $264
line 376
;374:
;375:		while (objectives[i])
;376:		{
line 377
;377:			if (objectives[i] != 9)
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 9
EQI4 $267
line 378
;378:			{
line 379
;379:				objectives[i_r] = objectives[i];
ADDRLP4 8196
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
ASGNI1
line 380
;380:				i_r++;
ADDRLP4 8196
ADDRLP4 8196
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 381
;381:			}
LABELV $267
line 383
;382:
;383:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 384
;384:		}
LABELV $265
line 375
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $264
line 385
;385:		objectives[i_r] = '\0';
ADDRLP4 8196
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 387
;386:
;387:		if (CGSagaGetValueGroup(objectives, objstr, foundobjective))
ADDRLP4 4
ARGP4
ADDRLP4 8268
ARGP4
ADDRLP4 8528
ARGP4
ADDRLP4 18772
ADDRGP4 CGSagaGetValueGroup
CALLI4
ASGNI4
ADDRLP4 18772
INDIRI4
CNSTI4 0
EQI4 $269
line 388
;388:		{
line 389
;389:			if (myTeam == SAGATEAM_IMPERIAL)
ADDRLP4 8264
INDIRI4
CNSTI4 1
NEI4 $271
line 390
;390:			{
line 391
;391:				success = CGSagaGetPairedValue(foundobjective, "message_imperial", appstring, 1);
ADDRLP4 8528
ARGP4
ADDRGP4 $273
ARGP4
ADDRLP4 16720
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 18776
ADDRGP4 CGSagaGetPairedValue
CALLI4
ASGNI4
ADDRLP4 8524
ADDRLP4 18776
INDIRI4
ASGNI4
line 392
;392:			}
ADDRGP4 $272
JUMPV
LABELV $271
line 394
;393:			else
;394:			{
line 395
;395:				success = CGSagaGetPairedValue(foundobjective, "message_rebel", appstring, 1);
ADDRLP4 8528
ARGP4
ADDRGP4 $274
ARGP4
ADDRLP4 16720
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 18776
ADDRGP4 CGSagaGetPairedValue
CALLI4
ASGNI4
ADDRLP4 8524
ADDRLP4 18776
INDIRI4
ASGNI4
line 396
;396:			}
LABELV $272
line 398
;397:
;398:			if (success)
ADDRLP4 8524
INDIRI4
CNSTI4 0
EQI4 $275
line 399
;399:			{
line 400
;400:				Com_Printf("%s\n", appstring);
ADDRGP4 $239
ARGP4
ADDRLP4 16720
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 401
;401:			}
LABELV $275
line 403
;402:
;403:			if (myTeam == SAGATEAM_IMPERIAL)
ADDRLP4 8264
INDIRI4
CNSTI4 1
NEI4 $277
line 404
;404:			{
line 405
;405:				Com_sprintf(teamstr, sizeof(teamstr), "sound_imperial");
ADDRLP4 8200
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $279
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 406
;406:			}
ADDRGP4 $278
JUMPV
LABELV $277
line 408
;407:			else
;408:			{
line 409
;409:				Com_sprintf(teamstr, sizeof(teamstr), "sound_rebel");
ADDRLP4 8200
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $280
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 410
;410:			}
LABELV $278
line 412
;411:
;412:			if (CGSagaGetPairedValue(foundobjective, teamstr, appstring, 1))
ADDRLP4 8528
ARGP4
ADDRLP4 8200
ARGP4
ADDRLP4 16720
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 18776
ADDRGP4 CGSagaGetPairedValue
CALLI4
ASGNI4
ADDRLP4 18776
INDIRI4
CNSTI4 0
EQI4 $281
line 413
;413:			{
line 414
;414:				Com_sprintf(soundstr, sizeof(soundstr), appstring);
ADDRLP4 17744
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 16720
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 415
;415:			}
ADDRGP4 $282
JUMPV
LABELV $281
line 417
;416:			else
;417:			{
line 418
;418:				if (myTeam != won)
ADDRLP4 8264
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $283
line 419
;419:				{
line 420
;420:					Com_sprintf(soundstr, sizeof(soundstr), DEFAULT_LOSE_OBJECTIVE);
ADDRLP4 17744
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $248
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 421
;421:				}
ADDRGP4 $284
JUMPV
LABELV $283
line 423
;422:				else
;423:				{
line 424
;424:					Com_sprintf(soundstr, sizeof(soundstr), DEFAULT_WIN_OBJECTIVE);
ADDRLP4 17744
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $249
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 425
;425:				}
LABELV $284
line 426
;426:			}
LABELV $282
line 428
;427:
;428:			trap_S_StartLocalSound(trap_S_RegisterSound(soundstr), CHAN_ANNOUNCER);
ADDRLP4 17744
ARGP4
ADDRLP4 18780
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 18780
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 430
;429:			//Com_Printf("Play sound: %s\n", soundstr);
;430:		}
LABELV $269
line 431
;431:	}
LABELV $261
line 432
;432:}
LABELV $250
endproc CG_SagaObjectiveCompleted 18784 16
bss
export cg_saga_valid
align 4
LABELV cg_saga_valid
skip 4
export cg_saga_info
align 1
LABELV cg_saga_info
skip 8192
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
LABELV $280
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 95
char 1 114
char 1 101
char 1 98
char 1 101
char 1 108
char 1 0
align 1
LABELV $279
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 95
char 1 105
char 1 109
char 1 112
char 1 101
char 1 114
char 1 105
char 1 97
char 1 108
char 1 0
align 1
LABELV $274
char 1 109
char 1 101
char 1 115
char 1 115
char 1 97
char 1 103
char 1 101
char 1 95
char 1 114
char 1 101
char 1 98
char 1 101
char 1 108
char 1 0
align 1
LABELV $273
char 1 109
char 1 101
char 1 115
char 1 115
char 1 97
char 1 103
char 1 101
char 1 95
char 1 105
char 1 109
char 1 112
char 1 101
char 1 114
char 1 105
char 1 97
char 1 108
char 1 0
align 1
LABELV $263
char 1 79
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 105
char 1 118
char 1 101
char 1 37
char 1 105
char 1 0
align 1
LABELV $249
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
char 1 107
char 1 121
char 1 108
char 1 101
char 1 47
char 1 112
char 1 114
char 1 111
char 1 116
char 1 111
char 1 116
char 1 121
char 1 112
char 1 101
char 1 47
char 1 112
char 1 101
char 1 114
char 1 115
char 1 111
char 1 110
char 1 97
char 1 108
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $248
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
char 1 107
char 1 121
char 1 108
char 1 101
char 1 47
char 1 112
char 1 114
char 1 111
char 1 116
char 1 111
char 1 116
char 1 121
char 1 112
char 1 101
char 1 47
char 1 105
char 1 115
char 1 110
char 1 116
char 1 119
char 1 111
char 1 114
char 1 107
char 1 105
char 1 110
char 1 103
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $243
char 1 114
char 1 111
char 1 117
char 1 110
char 1 100
char 1 111
char 1 118
char 1 101
char 1 114
char 1 95
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 95
char 1 119
char 1 101
char 1 108
char 1 111
char 1 115
char 1 116
char 1 0
align 1
LABELV $242
char 1 114
char 1 111
char 1 117
char 1 110
char 1 100
char 1 111
char 1 118
char 1 101
char 1 114
char 1 95
char 1 115
char 1 111
char 1 117
char 1 110
char 1 100
char 1 95
char 1 119
char 1 101
char 1 119
char 1 111
char 1 110
char 1 0
align 1
LABELV $239
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $236
char 1 108
char 1 111
char 1 115
char 1 116
char 1 114
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $235
char 1 119
char 1 111
char 1 110
char 1 114
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $230
char 1 82
char 1 101
char 1 98
char 1 101
char 1 108
char 1 0
align 1
LABELV $229
char 1 73
char 1 109
char 1 112
char 1 101
char 1 114
char 1 105
char 1 97
char 1 108
char 1 0
align 1
LABELV $220
char 1 69
char 1 82
char 1 82
char 1 79
char 1 82
char 1 58
char 1 32
char 1 83
char 1 97
char 1 103
char 1 97
char 1 32
char 1 100
char 1 97
char 1 116
char 1 97
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
char 1 101
char 1 120
char 1 105
char 1 115
char 1 116
char 1 32
char 1 111
char 1 110
char 1 32
char 1 99
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 33
char 1 10
char 1 0
align 1
LABELV $210
char 1 37
char 1 115
char 1 46
char 1 115
char 1 97
char 1 103
char 1 97
char 1 0
char 1 0
align 1
LABELV $201
char 1 37
char 1 115
char 1 0
char 1 0
