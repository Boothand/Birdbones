export CG_RegisterWeapon
code
proc CG_RegisterWeapon 588 12
file "../cg_weaponinit.c"
line 14
;1://
;2:// cg_weaponinit.c -- events and effects dealing with weapons
;3:#include "cg_local.h"
;4:#include "fx_local.h"
;5:
;6:
;7:/*
;8:=================
;9:CG_RegisterWeapon
;10:
;11:The server says this item is used on this level
;12:=================
;13:*/
;14:void CG_RegisterWeapon( int weaponNum) {
line 21
;15:	weaponInfo_t	*weaponInfo;
;16:	gitem_t			*item, *ammo;
;17:	char			path[MAX_QPATH];
;18:	vec3_t			mins, maxs;
;19:	int				i;
;20:
;21:	weaponInfo = &cg_weapons[weaponNum];
ADDRLP4 8
CNSTI4 208
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 23
;22:
;23:	if ( weaponNum == 0 ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $121
line 24
;24:		return;
ADDRGP4 $120
JUMPV
LABELV $121
line 27
;25:	}
;26:
;27:	if ( weaponInfo->registered ) {
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $123
line 28
;28:		return;
ADDRGP4 $120
JUMPV
LABELV $123
line 31
;29:	}
;30:
;31:	memset( weaponInfo, 0, sizeof( *weaponInfo ) );
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 32
;32:	weaponInfo->registered = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 34
;33:
;34:	for ( item = bg_itemlist + 1 ; item->classname ; item++ ) {
ADDRLP4 4
ADDRGP4 bg_itemlist+52
ASGNP4
ADDRGP4 $128
JUMPV
LABELV $125
line 35
;35:		if ( item->giType == IT_WEAPON && item->giTag == weaponNum ) {
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $130
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $130
line 36
;36:			weaponInfo->item = item;
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 37
;37:			break;
ADDRGP4 $127
JUMPV
LABELV $130
line 39
;38:		}
;39:	}
LABELV $126
line 34
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
LABELV $128
ADDRLP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $125
LABELV $127
line 40
;40:	if ( !item->classname ) {
ADDRLP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $132
line 41
;41:		CG_Error( "Couldn't find weapon %i", weaponNum );
ADDRGP4 $134
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 42
;42:	}
LABELV $132
line 43
;43:	CG_RegisterItemVisuals( item - bg_itemlist );
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 46
;44:
;45:	// load cmodel before model so filecache works
;46:	weaponInfo->weaponModel = trap_R_RegisterModel( item->world_model[0] );
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 104
INDIRI4
ASGNI4
line 48
;47:	// load in-view model also
;48:	weaponInfo->viewModel = trap_R_RegisterModel(item->view_model);
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 108
INDIRI4
ASGNI4
line 51
;49:
;50:	// calc midpoint for rotation
;51:	trap_R_ModelBounds( weaponInfo->weaponModel, mins, maxs );
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 52
;52:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $135
line 53
;53:		weaponInfo->weaponMidpoint[i] = mins[i] + 0.5 * ( maxs[i] - mins[i] );
ADDRLP4 112
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 116
ADDRLP4 112
INDIRI4
ADDRLP4 16
ADDP4
INDIRF4
ASGNF4
ADDRLP4 112
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDP4
ADDRLP4 116
INDIRF4
CNSTF4 1056964608
ADDRLP4 112
INDIRI4
ADDRLP4 28
ADDP4
INDIRF4
ADDRLP4 116
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 54
;54:	}
LABELV $136
line 52
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $135
line 56
;55:
;56:	weaponInfo->weaponIcon = trap_R_RegisterShader( item->icon );
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 112
INDIRI4
ASGNI4
line 57
;57:	weaponInfo->ammoIcon = trap_R_RegisterShader( item->icon );
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 116
INDIRI4
ASGNI4
line 59
;58:
;59:	for ( ammo = bg_itemlist + 1 ; ammo->classname ; ammo++ ) {
ADDRLP4 12
ADDRGP4 bg_itemlist+52
ASGNP4
ADDRGP4 $142
JUMPV
LABELV $139
line 60
;60:		if ( ammo->giType == IT_AMMO && ammo->giTag == weaponNum ) {
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $144
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $144
line 61
;61:			break;
ADDRGP4 $141
JUMPV
LABELV $144
line 63
;62:		}
;63:	}
LABELV $140
line 59
ADDRLP4 12
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
LABELV $142
ADDRLP4 12
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $139
LABELV $141
line 64
;64:	if ( ammo->classname && ammo->world_model[0] ) {
ADDRLP4 124
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
INDIRP4
CVPU4 4
ADDRLP4 124
INDIRU4
EQU4 $146
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 124
INDIRU4
EQU4 $146
line 65
;65:		weaponInfo->ammoModel = trap_R_RegisterModel( ammo->world_model[0] );
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 128
INDIRI4
ASGNI4
line 66
;66:	}
LABELV $146
line 71
;67:
;68://	strcpy( path, item->view_model );
;69://	COM_StripExtension( path, path );
;70://	strcat( path, "_flash.md3" );
;71:	weaponInfo->flashModel = 0;//trap_R_RegisterModel( path );
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 73
;72:
;73:	if (weaponNum == WP_DISRUPTOR ||
ADDRLP4 128
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 5
EQI4 $152
ADDRLP4 128
INDIRI4
CNSTI4 9
EQI4 $152
ADDRLP4 128
INDIRI4
CNSTI4 7
EQI4 $152
ADDRLP4 128
INDIRI4
CNSTI4 10
NEI4 $148
LABELV $152
line 77
;74:		weaponNum == WP_FLECHETTE ||
;75:		weaponNum == WP_REPEATER ||
;76:		weaponNum == WP_ROCKET_LAUNCHER)
;77:	{
line 78
;78:		strcpy( path, item->view_model );
ADDRLP4 40
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 79
;79:		COM_StripExtension( path, path );
ADDRLP4 40
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 80
;80:		strcat( path, "_barrel.md3" );
ADDRLP4 40
ARGP4
ADDRGP4 $153
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 81
;81:		weaponInfo->barrelModel = trap_R_RegisterModel( path );
ADDRLP4 40
ARGP4
ADDRLP4 132
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 132
INDIRI4
ASGNI4
line 82
;82:	}
ADDRGP4 $149
JUMPV
LABELV $148
line 83
;83:	else if (weaponNum == WP_STUN_BATON)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $154
line 84
;84:	{ //only weapon with more than 1 barrel..
line 85
;85:		trap_R_RegisterModel("models/weapons2/stun_baton/baton_barrel.md3");
ADDRGP4 $156
ARGP4
ADDRGP4 trap_R_RegisterModel
CALLI4
pop
line 86
;86:		trap_R_RegisterModel("models/weapons2/stun_baton/baton_barrel2.md3");
ADDRGP4 $157
ARGP4
ADDRGP4 trap_R_RegisterModel
CALLI4
pop
line 87
;87:		trap_R_RegisterModel("models/weapons2/stun_baton/baton_barrel3.md3");
ADDRGP4 $158
ARGP4
ADDRGP4 trap_R_RegisterModel
CALLI4
pop
line 88
;88:	}
ADDRGP4 $155
JUMPV
LABELV $154
line 90
;89:	else
;90:	{
line 91
;91:		weaponInfo->barrelModel = 0;
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 92
;92:	}
LABELV $155
LABELV $149
line 94
;93:
;94:	if (weaponNum != WP_SABER)
ADDRFP4 0
INDIRI4
CNSTI4 2
EQI4 $159
line 95
;95:	{
line 96
;96:		strcpy( path, item->view_model );
ADDRLP4 40
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 97
;97:		COM_StripExtension( path, path );
ADDRLP4 40
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 98
;98:		strcat( path, "_hand.md3" );
ADDRLP4 40
ARGP4
ADDRGP4 $161
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 99
;99:		weaponInfo->handsModel = trap_R_RegisterModel( path );
ADDRLP4 40
ARGP4
ADDRLP4 132
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 132
INDIRI4
ASGNI4
line 100
;100:	}
ADDRGP4 $160
JUMPV
LABELV $159
line 102
;101:	else
;102:	{
line 103
;103:		weaponInfo->handsModel = 0;
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 104
;104:	}
LABELV $160
line 110
;105:
;106://	if ( !weaponInfo->handsModel ) {
;107://		weaponInfo->handsModel = trap_R_RegisterModel( "models/weapons2/shotgun/shotgun_hand.md3" );
;108://	}
;109:
;110:	cgs.effects.forceLightning		= trap_FX_RegisterEffect( "effects/force/lightning.efx" );
ADDRGP4 $164
ARGP4
ADDRLP4 132
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+144
ADDRLP4 132
INDIRI4
ASGNI4
line 111
;111:	cgs.effects.forceLightningWide	= trap_FX_RegisterEffect( "effects/force/lightningwide.efx" );
ADDRGP4 $167
ARGP4
ADDRLP4 136
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+148
ADDRLP4 136
INDIRI4
ASGNI4
line 113
;112:
;113:	cgs.effects.forceDrain		= trap_FX_RegisterEffect( "effects/mp/drain.efx" );
ADDRGP4 $170
ARGP4
ADDRLP4 140
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+152
ADDRLP4 140
INDIRI4
ASGNI4
line 114
;114:	cgs.effects.forceDrainWide	= trap_FX_RegisterEffect( "effects/mp/drainwide.efx" );
ADDRGP4 $173
ARGP4
ADDRLP4 144
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+156
ADDRLP4 144
INDIRI4
ASGNI4
line 115
;115:	cgs.effects.forceDrained	= trap_FX_RegisterEffect( "effects/mp/drainhit.efx");
ADDRGP4 $176
ARGP4
ADDRLP4 148
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+160
ADDRLP4 148
INDIRI4
ASGNI4
line 117
;116:
;117:	switch ( weaponNum ) {
ADDRLP4 152
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 1
LTI4 $177
ADDRLP4 152
INDIRI4
CNSTI4 14
GTI4 $177
ADDRLP4 152
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $411-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $411
address $179
address $187
address $190
address $222
address $240
address $286
address $299
address $318
address $342
address $361
address $377
address $395
address $403
address $222
code
LABELV $179
line 124
;118:	case WP_STUN_BATON:
;119:/*		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
;120:		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/saber/saberhum.wav" );
;121://		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/melee/fstatck.wav" );
;122:*/
;123:		//trap_R_RegisterShader( "gfx/effects/stunPass" );
;124:		trap_FX_RegisterEffect( "stunBaton/flesh_impact" );
ADDRGP4 $180
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 126
;125:		//TEMP
;126:		trap_S_RegisterSound( "sound/weapons/melee/punch1.mp3" );
ADDRGP4 $181
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 127
;127:		trap_S_RegisterSound( "sound/weapons/melee/punch2.mp3" );
ADDRGP4 $182
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 128
;128:		trap_S_RegisterSound( "sound/weapons/melee/punch3.mp3" );
ADDRGP4 $183
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 129
;129:		trap_S_RegisterSound( "sound/weapons/melee/punch4.mp3" );
ADDRGP4 $184
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 131
;130:
;131:		trap_S_RegisterSound( "sound/weapons/baton/idle.wav" );
ADDRGP4 $185
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 132
;132:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/baton/fire.mp3" );
ADDRGP4 $186
ARGP4
ADDRLP4 156
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 133
;133:		weaponInfo->altFlashSound[0] = trap_S_RegisterSound( "sound/weapons/baton/fire.mp3" );
ADDRGP4 $186
ARGP4
ADDRLP4 160
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 160
INDIRI4
ASGNI4
line 135
;134:
;135:		break;
ADDRGP4 $178
JUMPV
LABELV $187
line 137
;136:	case WP_SABER:
;137:		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTF4 1065353216
ASGNF4
line 138
;138:		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/saber/saberhum1.wav" );
ADDRGP4 $188
ARGP4
ADDRLP4 164
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 164
INDIRI4
ASGNI4
line 139
;139:		weaponInfo->missileModel		= trap_R_RegisterModel( "models/weapons2/saber/saber_w.glm" );
ADDRGP4 $189
ARGP4
ADDRLP4 168
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 168
INDIRI4
ASGNI4
line 140
;140:		break;
ADDRGP4 $178
JUMPV
LABELV $190
line 143
;141:
;142:	case WP_BRYAR_PISTOL:
;143:		weaponInfo->flashSound[0]		= trap_S_RegisterSound( "sound/weapons/bryar/fire.wav");
ADDRGP4 $191
ARGP4
ADDRLP4 172
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 172
INDIRI4
ASGNI4
line 144
;144:		weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 145
;145:		weaponInfo->chargeSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 146
;146:		weaponInfo->muzzleEffect		= trap_FX_RegisterEffect( "bryar/muzzle_flash" );
ADDRGP4 $192
ARGP4
ADDRLP4 176
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 176
INDIRI4
ASGNI4
line 147
;147:		weaponInfo->missileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 148
;148:		weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 149
;149:		weaponInfo->missileDlight		= 0;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 151
;150:		//weaponInfo->missileDlightColor= {0,0,0};
;151:		weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 152
;152:		weaponInfo->missileTrailFunc	= FX_BryarProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 FX_BryarProjectileThink
ASGNP4
line 154
;153:
;154:		weaponInfo->altFlashSound[0]	= trap_S_RegisterSound( "sound/weapons/bryar/alt_fire.wav");
ADDRGP4 $193
ARGP4
ADDRLP4 180
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 180
INDIRI4
ASGNI4
line 155
;155:		weaponInfo->altFiringSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 156
;156:		weaponInfo->altChargeSound		= trap_S_RegisterSound( "sound/weapons/bryar/altcharge.wav");
ADDRGP4 $194
ARGP4
ADDRLP4 184
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 184
INDIRI4
ASGNI4
line 157
;157:		weaponInfo->altMuzzleEffect		= trap_FX_RegisterEffect( "bryar/muzzle_flash" );
ADDRGP4 $192
ARGP4
ADDRLP4 188
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 188
INDIRI4
ASGNI4
line 158
;158:		weaponInfo->altMissileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 159
;159:		weaponInfo->altMissileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 160
;160:		weaponInfo->altMissileDlight	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 0
ASGNF4
line 162
;161:		//weaponInfo->altMissileDlightColor= {0,0,0};
;162:		weaponInfo->altMissileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 163
;163:		weaponInfo->altMissileTrailFunc = FX_BryarAltProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRGP4 FX_BryarAltProjectileThink
ASGNP4
line 165
;164:
;165:		cgs.effects.bryarShotEffect			= trap_FX_RegisterEffect( "bryar/shot" );
ADDRGP4 $196
ARGP4
ADDRLP4 192
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560
ADDRLP4 192
INDIRI4
ASGNI4
line 166
;166:		cgs.effects.bryarPowerupShotEffect	= trap_FX_RegisterEffect( "bryar/crackleShot" );
ADDRGP4 $199
ARGP4
ADDRLP4 196
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+4
ADDRLP4 196
INDIRI4
ASGNI4
line 167
;167:		cgs.effects.bryarWallImpactEffect	= trap_FX_RegisterEffect( "bryar/wall_impact" );
ADDRGP4 $202
ARGP4
ADDRLP4 200
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+8
ADDRLP4 200
INDIRI4
ASGNI4
line 168
;168:		cgs.effects.bryarWallImpactEffect2	= trap_FX_RegisterEffect( "bryar/wall_impact2" );
ADDRGP4 $205
ARGP4
ADDRLP4 204
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+12
ADDRLP4 204
INDIRI4
ASGNI4
line 169
;169:		cgs.effects.bryarWallImpactEffect3	= trap_FX_RegisterEffect( "bryar/wall_impact3" );
ADDRGP4 $208
ARGP4
ADDRLP4 208
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+16
ADDRLP4 208
INDIRI4
ASGNI4
line 170
;170:		cgs.effects.bryarFleshImpactEffect	= trap_FX_RegisterEffect( "bryar/flesh_impact" );
ADDRGP4 $211
ARGP4
ADDRLP4 212
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+20
ADDRLP4 212
INDIRI4
ASGNI4
line 171
;171:		cgs.effects.bryarDroidImpactEffect	= trap_FX_RegisterEffect( "bryar/droid_impact" );
ADDRGP4 $214
ARGP4
ADDRLP4 216
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+24
ADDRLP4 216
INDIRI4
ASGNI4
line 173
;172:
;173:		cgs.media.bryarFrontFlash = trap_R_RegisterShader( "gfx/effects/bryarFrontFlash" );
ADDRGP4 $217
ARGP4
ADDRLP4 220
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+70280+20
ADDRLP4 220
INDIRI4
ASGNI4
line 176
;174:
;175:		// Note these are temp shared effects
;176:		trap_FX_RegisterEffect("effects/blaster/deflect.efx");
ADDRGP4 $218
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 177
;177:		trap_FX_RegisterEffect("effects/blaster/wall_impact.efx");
ADDRGP4 $219
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 178
;178:		trap_FX_RegisterEffect("effects/blaster/flesh_impact.efx");
ADDRGP4 $220
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 179
;179:		trap_FX_RegisterEffect("effects/blaster/smoke_bolton.efx");
ADDRGP4 $221
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 181
;180:
;181:		break;
ADDRGP4 $178
JUMPV
LABELV $222
line 185
;182:
;183:	case WP_BLASTER:
;184:	case WP_EMPLACED_GUN: //rww - just use the same as this for now..
;185:		weaponInfo->flashSound[0]		= trap_S_RegisterSound( "sound/weapons/blaster/fire.wav");
ADDRGP4 $223
ARGP4
ADDRLP4 224
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 224
INDIRI4
ASGNI4
line 186
;186:		weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 187
;187:		weaponInfo->chargeSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 188
;188:		weaponInfo->muzzleEffect		= trap_FX_RegisterEffect( "blaster/muzzle_flash" );
ADDRGP4 $224
ARGP4
ADDRLP4 228
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 228
INDIRI4
ASGNI4
line 189
;189:		weaponInfo->missileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 190
;190:		weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 191
;191:		weaponInfo->missileDlight		= 0;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 193
;192://		weaponInfo->missileDlightColor	= {0,0,0};
;193:		weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 194
;194:		weaponInfo->missileTrailFunc	= FX_BlasterProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 FX_BlasterProjectileThink
ASGNP4
line 196
;195:
;196:		weaponInfo->altFlashSound[0]	= trap_S_RegisterSound( "sound/weapons/blaster/alt_fire.wav");
ADDRGP4 $225
ARGP4
ADDRLP4 232
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 232
INDIRI4
ASGNI4
line 197
;197:		weaponInfo->altFiringSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 198
;198:		weaponInfo->altChargeSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 199
;199:		weaponInfo->altMuzzleEffect		= trap_FX_RegisterEffect( "blaster/muzzle_flash" );
ADDRGP4 $224
ARGP4
ADDRLP4 236
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 236
INDIRI4
ASGNI4
line 200
;200:		weaponInfo->altMissileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 201
;201:		weaponInfo->altMissileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 202
;202:		weaponInfo->altMissileDlight	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 0
ASGNF4
line 204
;203://		weaponInfo->altMissileDlightColor= {0,0,0};
;204:		weaponInfo->altMissileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 205
;205:		weaponInfo->altMissileTrailFunc = FX_BlasterProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRGP4 FX_BlasterProjectileThink
ASGNP4
line 207
;206:
;207:		trap_FX_RegisterEffect( "blaster/deflect" );
ADDRGP4 $226
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 208
;208:		cgs.effects.blasterShotEffect			= trap_FX_RegisterEffect( "blaster/shot" );
ADDRGP4 $229
ARGP4
ADDRLP4 240
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+28
ADDRLP4 240
INDIRI4
ASGNI4
line 209
;209:		cgs.effects.blasterWallImpactEffect		= trap_FX_RegisterEffect( "blaster/wall_impact" );
ADDRGP4 $232
ARGP4
ADDRLP4 244
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+32
ADDRLP4 244
INDIRI4
ASGNI4
line 210
;210:		cgs.effects.blasterFleshImpactEffect	= trap_FX_RegisterEffect( "blaster/flesh_impact" );
ADDRGP4 $235
ARGP4
ADDRLP4 248
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+36
ADDRLP4 248
INDIRI4
ASGNI4
line 211
;211:		cgs.effects.blasterDroidImpactEffect	= trap_FX_RegisterEffect( "blaster/droid_impact" );
ADDRGP4 $238
ARGP4
ADDRLP4 252
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+40
ADDRLP4 252
INDIRI4
ASGNI4
line 212
;212:		trap_FX_RegisterEffect( "blaster/smoke_bolton" ); // note: this will be called game side
ADDRGP4 $239
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 213
;213:		break;
ADDRGP4 $178
JUMPV
LABELV $240
line 216
;214:
;215:	case WP_DISRUPTOR:
;216:		weaponInfo->flashSound[0]		= trap_S_RegisterSound( "sound/weapons/disruptor/fire.wav");
ADDRGP4 $241
ARGP4
ADDRLP4 256
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 217
;217:		weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 218
;218:		weaponInfo->chargeSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 219
;219:		weaponInfo->muzzleEffect		= trap_FX_RegisterEffect( "disruptor/muzzle_flash" );
ADDRGP4 $242
ARGP4
ADDRLP4 260
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 260
INDIRI4
ASGNI4
line 220
;220:		weaponInfo->missileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 221
;221:		weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 222
;222:		weaponInfo->missileDlight		= 0;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 224
;223://		weaponInfo->missileDlightColor	= {0,0,0};
;224:		weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 225
;225:		weaponInfo->missileTrailFunc	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
CNSTP4 0
ASGNP4
line 227
;226:
;227:		weaponInfo->altFlashSound[0]	= trap_S_RegisterSound( "sound/weapons/disruptor/alt_fire.wav");
ADDRGP4 $243
ARGP4
ADDRLP4 264
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 228
;228:		weaponInfo->altFiringSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 229
;229:		weaponInfo->altChargeSound		= trap_S_RegisterSound("sound/weapons/disruptor/altCharge.wav");
ADDRGP4 $244
ARGP4
ADDRLP4 268
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 230
;230:		weaponInfo->altMuzzleEffect		= trap_FX_RegisterEffect( "disruptor/muzzle_flash" );
ADDRGP4 $242
ARGP4
ADDRLP4 272
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 231
;231:		weaponInfo->altMissileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 232
;232:		weaponInfo->altMissileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 233
;233:		weaponInfo->altMissileDlight	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 0
ASGNF4
line 235
;234://		weaponInfo->altMissileDlightColor= {0,0,0};
;235:		weaponInfo->altMissileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 236
;236:		weaponInfo->altMissileTrailFunc = 0;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
CNSTP4 0
ASGNP4
line 238
;237:
;238:		cgs.effects.disruptorRingsEffect		= trap_FX_RegisterEffect( "disruptor/rings" );
ADDRGP4 $247
ARGP4
ADDRLP4 276
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+44
ADDRLP4 276
INDIRI4
ASGNI4
line 239
;239:		cgs.effects.disruptorProjectileEffect	= trap_FX_RegisterEffect( "disruptor/projectile" );
ADDRGP4 $250
ARGP4
ADDRLP4 280
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+48
ADDRLP4 280
INDIRI4
ASGNI4
line 240
;240:		cgs.effects.disruptorWallImpactEffect	= trap_FX_RegisterEffect( "disruptor/wall_impact" );
ADDRGP4 $253
ARGP4
ADDRLP4 284
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+52
ADDRLP4 284
INDIRI4
ASGNI4
line 241
;241:		cgs.effects.disruptorFleshImpactEffect	= trap_FX_RegisterEffect( "disruptor/flesh_impact" );
ADDRGP4 $256
ARGP4
ADDRLP4 288
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+56
ADDRLP4 288
INDIRI4
ASGNI4
line 242
;242:		cgs.effects.disruptorAltMissEffect		= trap_FX_RegisterEffect( "disruptor/alt_miss" );
ADDRGP4 $259
ARGP4
ADDRLP4 292
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+60
ADDRLP4 292
INDIRI4
ASGNI4
line 243
;243:		cgs.effects.disruptorAltHitEffect		= trap_FX_RegisterEffect( "disruptor/alt_hit" );
ADDRGP4 $262
ARGP4
ADDRLP4 296
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+64
ADDRLP4 296
INDIRI4
ASGNI4
line 245
;244:
;245:		trap_R_RegisterShader( "gfx/effects/redLine" );
ADDRGP4 $263
ARGP4
ADDRGP4 trap_R_RegisterShader
CALLI4
pop
line 246
;246:		trap_R_RegisterShader( "gfx/misc/whiteline2" );
ADDRGP4 $264
ARGP4
ADDRGP4 trap_R_RegisterShader
CALLI4
pop
line 247
;247:		trap_R_RegisterShader( "gfx/effects/smokeTrail" );
ADDRGP4 $265
ARGP4
ADDRGP4 trap_R_RegisterShader
CALLI4
pop
line 249
;248:
;249:		trap_S_RegisterSound("sound/weapons/disruptor/zoomstart.wav");
ADDRGP4 $266
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 250
;250:		trap_S_RegisterSound("sound/weapons/disruptor/zoomend.wav");
ADDRGP4 $267
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 253
;251:
;252:		// Disruptor gun zoom interface
;253:		cgs.media.disruptorMask			= trap_R_RegisterShader( "gfx/2d/cropCircle2");
ADDRGP4 $270
ARGP4
ADDRLP4 300
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+70280+516
ADDRLP4 300
INDIRI4
ASGNI4
line 254
;254:		cgs.media.disruptorInsert		= trap_R_RegisterShader( "gfx/2d/cropCircle");
ADDRGP4 $273
ARGP4
ADDRLP4 304
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+70280+520
ADDRLP4 304
INDIRI4
ASGNI4
line 255
;255:		cgs.media.disruptorLight		= trap_R_RegisterShader( "gfx/2d/cropCircleGlow" );
ADDRGP4 $276
ARGP4
ADDRLP4 308
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+70280+524
ADDRLP4 308
INDIRI4
ASGNI4
line 256
;256:		cgs.media.disruptorInsertTick	= trap_R_RegisterShader( "gfx/2d/insertTick" );
ADDRGP4 $279
ARGP4
ADDRLP4 312
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+70280+528
ADDRLP4 312
INDIRI4
ASGNI4
line 257
;257:		cgs.media.disruptorChargeShader	= trap_R_RegisterShaderNoMip("gfx/2d/crop_charge");
ADDRGP4 $282
ARGP4
ADDRLP4 316
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+70280+532
ADDRLP4 316
INDIRI4
ASGNI4
line 259
;258:
;259:		cgs.media.disruptorZoomLoop		= trap_S_RegisterSound( "sound/weapons/disruptor/zoomloop.wav" );
ADDRGP4 $285
ARGP4
ADDRLP4 320
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+70280+1276
ADDRLP4 320
INDIRI4
ASGNI4
line 260
;260:		break;
ADDRGP4 $178
JUMPV
LABELV $286
line 263
;261:
;262:	case WP_BOWCASTER:
;263:		weaponInfo->altFlashSound[0]		= trap_S_RegisterSound( "sound/weapons/bowcaster/fire.wav");
ADDRGP4 $287
ARGP4
ADDRLP4 324
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 324
INDIRI4
ASGNI4
line 264
;264:		weaponInfo->altFiringSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 265
;265:		weaponInfo->altChargeSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 266
;266:		weaponInfo->altMuzzleEffect		= trap_FX_RegisterEffect( "bowcaster/muzzle_flash" );
ADDRGP4 $288
ARGP4
ADDRLP4 328
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 328
INDIRI4
ASGNI4
line 267
;267:		weaponInfo->altMissileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 268
;268:		weaponInfo->altMissileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 269
;269:		weaponInfo->altMissileDlight		= 0;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 0
ASGNF4
line 271
;270://		weaponInfo->altMissileDlightColor	= {0,0,0};
;271:		weaponInfo->altMissileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 272
;272:		weaponInfo->altMissileTrailFunc	= FX_BowcasterProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRGP4 FX_BowcasterProjectileThink
ASGNP4
line 274
;273:
;274:		weaponInfo->flashSound[0]	= trap_S_RegisterSound( "sound/weapons/bowcaster/fire.wav");
ADDRGP4 $287
ARGP4
ADDRLP4 332
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 332
INDIRI4
ASGNI4
line 275
;275:		weaponInfo->firingSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 276
;276:		weaponInfo->chargeSound		= trap_S_RegisterSound( "sound/weapons/bowcaster/altcharge.wav");
ADDRGP4 $289
ARGP4
ADDRLP4 336
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 336
INDIRI4
ASGNI4
line 277
;277:		weaponInfo->muzzleEffect		= trap_FX_RegisterEffect( "bowcaster/muzzle_flash" );
ADDRGP4 $288
ARGP4
ADDRLP4 340
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 340
INDIRI4
ASGNI4
line 278
;278:		weaponInfo->missileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 279
;279:		weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 280
;280:		weaponInfo->missileDlight	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 282
;281://		weaponInfo->missileDlightColor= {0,0,0};
;282:		weaponInfo->missileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 283
;283:		weaponInfo->missileTrailFunc = FX_BowcasterAltProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 FX_BowcasterAltProjectileThink
ASGNP4
line 285
;284:
;285:		cgs.effects.bowcasterShotEffect		= trap_FX_RegisterEffect( "bowcaster/shot" );
ADDRGP4 $292
ARGP4
ADDRLP4 344
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+68
ADDRLP4 344
INDIRI4
ASGNI4
line 286
;286:		cgs.effects.bowcasterImpactEffect	= trap_FX_RegisterEffect( "bowcaster/explosion" );
ADDRGP4 $295
ARGP4
ADDRLP4 348
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+72
ADDRLP4 348
INDIRI4
ASGNI4
line 288
;287:
;288:		cgs.media.greenFrontFlash = trap_R_RegisterShader( "gfx/effects/greenFrontFlash" );
ADDRGP4 $298
ARGP4
ADDRLP4 352
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+70280+24
ADDRLP4 352
INDIRI4
ASGNI4
line 289
;289:		break;
ADDRGP4 $178
JUMPV
LABELV $299
line 292
;290:
;291:	case WP_REPEATER:
;292:		weaponInfo->flashSound[0]		= trap_S_RegisterSound( "sound/weapons/repeater/fire.wav");
ADDRGP4 $300
ARGP4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 356
INDIRI4
ASGNI4
line 293
;293:		weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 294
;294:		weaponInfo->chargeSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 295
;295:		weaponInfo->muzzleEffect		= trap_FX_RegisterEffect( "repeater/muzzle_flash" );
ADDRGP4 $301
ARGP4
ADDRLP4 360
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 360
INDIRI4
ASGNI4
line 296
;296:		weaponInfo->missileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 297
;297:		weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 298
;298:		weaponInfo->missileDlight		= 0;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 300
;299://		weaponInfo->missileDlightColor	= {0,0,0};
;300:		weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 301
;301:		weaponInfo->missileTrailFunc	= FX_RepeaterProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 FX_RepeaterProjectileThink
ASGNP4
line 303
;302:
;303:		weaponInfo->altFlashSound[0]	= trap_S_RegisterSound( "sound/weapons/repeater/alt_fire.wav");
ADDRGP4 $302
ARGP4
ADDRLP4 364
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 364
INDIRI4
ASGNI4
line 304
;304:		weaponInfo->altFiringSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 305
;305:		weaponInfo->altChargeSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 306
;306:		weaponInfo->altMuzzleEffect		= trap_FX_RegisterEffect( "repeater/muzzle_flash" );
ADDRGP4 $301
ARGP4
ADDRLP4 368
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 368
INDIRI4
ASGNI4
line 307
;307:		weaponInfo->altMissileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 308
;308:		weaponInfo->altMissileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 309
;309:		weaponInfo->altMissileDlight	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 0
ASGNF4
line 311
;310://		weaponInfo->altMissileDlightColor= {0,0,0};
;311:		weaponInfo->altMissileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 312
;312:		weaponInfo->altMissileTrailFunc = FX_RepeaterAltProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRGP4 FX_RepeaterAltProjectileThink
ASGNP4
line 314
;313:
;314:		cgs.effects.repeaterProjectileEffect	= trap_FX_RegisterEffect( "repeater/projectile" );
ADDRGP4 $305
ARGP4
ADDRLP4 372
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+76
ADDRLP4 372
INDIRI4
ASGNI4
line 315
;315:		cgs.effects.repeaterAltProjectileEffect	= trap_FX_RegisterEffect( "repeater/alt_projectile" );
ADDRGP4 $308
ARGP4
ADDRLP4 376
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+80
ADDRLP4 376
INDIRI4
ASGNI4
line 316
;316:		cgs.effects.repeaterWallImpactEffect	= trap_FX_RegisterEffect( "repeater/wall_impact" );
ADDRGP4 $311
ARGP4
ADDRLP4 380
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+84
ADDRLP4 380
INDIRI4
ASGNI4
line 317
;317:		cgs.effects.repeaterFleshImpactEffect	= trap_FX_RegisterEffect( "repeater/flesh_impact" );
ADDRGP4 $314
ARGP4
ADDRLP4 384
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+88
ADDRLP4 384
INDIRI4
ASGNI4
line 319
;318:		//cgs.effects.repeaterAltWallImpactEffect	= trap_FX_RegisterEffect( "repeater/alt_wall_impact" );
;319:		cgs.effects.repeaterAltWallImpactEffect	= trap_FX_RegisterEffect( "repeater/concussion" );
ADDRGP4 $317
ARGP4
ADDRLP4 388
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+92
ADDRLP4 388
INDIRI4
ASGNI4
line 320
;320:		break;
ADDRGP4 $178
JUMPV
LABELV $318
line 323
;321:
;322:	case WP_DEMP2:
;323:		weaponInfo->flashSound[0]		= trap_S_RegisterSound("sound/weapons/demp2/fire.wav");
ADDRGP4 $319
ARGP4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 392
INDIRI4
ASGNI4
line 324
;324:		weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 325
;325:		weaponInfo->chargeSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 326
;326:		weaponInfo->muzzleEffect		= trap_FX_RegisterEffect("demp2/muzzle_flash");
ADDRGP4 $320
ARGP4
ADDRLP4 396
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 396
INDIRI4
ASGNI4
line 327
;327:		weaponInfo->missileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 328
;328:		weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 329
;329:		weaponInfo->missileDlight		= 0;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 331
;330://		weaponInfo->missileDlightColor	= {0,0,0};
;331:		weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 332
;332:		weaponInfo->missileTrailFunc	= FX_DEMP2_ProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 FX_DEMP2_ProjectileThink
ASGNP4
line 334
;333:
;334:		weaponInfo->altFlashSound[0]	= trap_S_RegisterSound("sound/weapons/demp2/altfire.wav");
ADDRGP4 $321
ARGP4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 400
INDIRI4
ASGNI4
line 335
;335:		weaponInfo->altFiringSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 336
;336:		weaponInfo->altChargeSound		= trap_S_RegisterSound("sound/weapons/demp2/altCharge.wav");
ADDRGP4 $322
ARGP4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 404
INDIRI4
ASGNI4
line 337
;337:		weaponInfo->altMuzzleEffect		= trap_FX_RegisterEffect("demp2/muzzle_flash");
ADDRGP4 $320
ARGP4
ADDRLP4 408
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 408
INDIRI4
ASGNI4
line 338
;338:		weaponInfo->altMissileModel		= NULL_HANDLE;
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 339
;339:		weaponInfo->altMissileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 340
;340:		weaponInfo->altMissileDlight	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 0
ASGNF4
line 342
;341://		weaponInfo->altMissileDlightColor= {0,0,0};
;342:		weaponInfo->altMissileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 343
;343:		weaponInfo->altMissileTrailFunc = 0;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
CNSTP4 0
ASGNP4
line 345
;344:
;345:		cgs.effects.demp2ProjectileEffect		= trap_FX_RegisterEffect( "demp2/projectile" );
ADDRGP4 $325
ARGP4
ADDRLP4 412
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+96
ADDRLP4 412
INDIRI4
ASGNI4
line 346
;346:		cgs.effects.demp2WallImpactEffect		= trap_FX_RegisterEffect( "demp2/wall_impact" );
ADDRGP4 $328
ARGP4
ADDRLP4 416
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+100
ADDRLP4 416
INDIRI4
ASGNI4
line 347
;347:		cgs.effects.demp2FleshImpactEffect		= trap_FX_RegisterEffect( "demp2/flesh_impact" );
ADDRGP4 $331
ARGP4
ADDRLP4 420
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+104
ADDRLP4 420
INDIRI4
ASGNI4
line 349
;348:
;349:		trap_FX_RegisterEffect("demp2/altDetonate.efx");
ADDRGP4 $332
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 350
;350:		cgs.media.demp2Shell = trap_R_RegisterModel( "models/items/sphere.md3" );
ADDRGP4 $335
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+70280+920
ADDRLP4 424
INDIRI4
ASGNI4
line 351
;351:		cgs.media.demp2ShellShader = trap_R_RegisterShader( "gfx/effects/demp2shell" );
ADDRGP4 $338
ARGP4
ADDRLP4 428
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+70280+924
ADDRLP4 428
INDIRI4
ASGNI4
line 353
;352:
;353:		cgs.media.lightningFlash = trap_R_RegisterShader("gfx/misc/lightningFlash");
ADDRGP4 $341
ARGP4
ADDRLP4 432
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+70280+28
ADDRLP4 432
INDIRI4
ASGNI4
line 354
;354:		break;
ADDRGP4 $178
JUMPV
LABELV $342
line 357
;355:
;356:	case WP_FLECHETTE:
;357:		weaponInfo->flashSound[0]		= trap_S_RegisterSound( "sound/weapons/flechette/fire.wav");
ADDRGP4 $343
ARGP4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 436
INDIRI4
ASGNI4
line 358
;358:		weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 359
;359:		weaponInfo->chargeSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 360
;360:		weaponInfo->muzzleEffect		= trap_FX_RegisterEffect( "flechette/muzzle_flash" );
ADDRGP4 $344
ARGP4
ADDRLP4 440
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 440
INDIRI4
ASGNI4
line 361
;361:		weaponInfo->missileModel		= trap_R_RegisterModel("models/weapons2/golan_arms/projectileMain.md3");
ADDRGP4 $345
ARGP4
ADDRLP4 444
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 444
INDIRI4
ASGNI4
line 362
;362:		weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 363
;363:		weaponInfo->missileDlight		= 0;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 365
;364://		weaponInfo->missileDlightColor	= {0,0,0};
;365:		weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 366
;366:		weaponInfo->missileTrailFunc	= FX_FlechetteProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 FX_FlechetteProjectileThink
ASGNP4
line 368
;367:
;368:		weaponInfo->altFlashSound[0]	= trap_S_RegisterSound( "sound/weapons/flechette/alt_fire.wav");
ADDRGP4 $346
ARGP4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 448
INDIRI4
ASGNI4
line 369
;369:		weaponInfo->altFiringSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 370
;370:		weaponInfo->altChargeSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 371
;371:		weaponInfo->altMuzzleEffect		= trap_FX_RegisterEffect( "flechette/muzzle_flash" );
ADDRGP4 $344
ARGP4
ADDRLP4 452
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 452
INDIRI4
ASGNI4
line 372
;372:		weaponInfo->altMissileModel		= trap_R_RegisterModel( "models/weapons2/golan_arms/projectile.md3" );
ADDRGP4 $347
ARGP4
ADDRLP4 456
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 456
INDIRI4
ASGNI4
line 373
;373:		weaponInfo->altMissileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 374
;374:		weaponInfo->altMissileDlight	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 0
ASGNF4
line 376
;375://		weaponInfo->altMissileDlightColor= {0,0,0};
;376:		weaponInfo->altMissileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 377
;377:		weaponInfo->altMissileTrailFunc = FX_FlechetteAltProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRGP4 FX_FlechetteAltProjectileThink
ASGNP4
line 379
;378:
;379:		cgs.effects.flechetteShotEffect			= trap_FX_RegisterEffect( "flechette/shot" );
ADDRGP4 $350
ARGP4
ADDRLP4 460
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+108
ADDRLP4 460
INDIRI4
ASGNI4
line 380
;380:		cgs.effects.flechetteAltShotEffect		= trap_FX_RegisterEffect( "flechette/alt_shot" );
ADDRGP4 $353
ARGP4
ADDRLP4 464
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+112
ADDRLP4 464
INDIRI4
ASGNI4
line 381
;381:		cgs.effects.flechetteWallImpactEffect	= trap_FX_RegisterEffect( "flechette/wall_impact" );
ADDRGP4 $356
ARGP4
ADDRLP4 468
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+116
ADDRLP4 468
INDIRI4
ASGNI4
line 382
;382:		cgs.effects.flechetteFleshImpactEffect	= trap_FX_RegisterEffect( "flechette/flesh_impact" );
ADDRGP4 $359
ARGP4
ADDRLP4 472
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+120
ADDRLP4 472
INDIRI4
ASGNI4
line 384
;383:
;384:		trap_FX_RegisterEffect("flechette/alt_blow.efx");
ADDRGP4 $360
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 385
;385:		break;
ADDRGP4 $178
JUMPV
LABELV $361
line 388
;386:
;387:	case WP_ROCKET_LAUNCHER:
;388:		weaponInfo->flashSound[0]		= trap_S_RegisterSound( "sound/weapons/rocket/fire.wav");
ADDRGP4 $362
ARGP4
ADDRLP4 476
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 476
INDIRI4
ASGNI4
line 389
;389:		weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 390
;390:		weaponInfo->chargeSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 391
;391:		weaponInfo->muzzleEffect		= trap_FX_RegisterEffect( "rocket/muzzle_flash" );
ADDRGP4 $363
ARGP4
ADDRLP4 480
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 480
INDIRI4
ASGNI4
line 392
;392:		weaponInfo->missileModel		= trap_R_RegisterModel( "models/weapons2/merr_sonn/projectile.md3" );
ADDRGP4 $364
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 484
INDIRI4
ASGNI4
line 393
;393:		weaponInfo->missileSound		= trap_S_RegisterSound( "sound/weapons/rocket/missileloop.wav");
ADDRGP4 $365
ARGP4
ADDRLP4 488
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
ADDRLP4 488
INDIRI4
ASGNI4
line 394
;394:		weaponInfo->missileDlight		= 125;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1123680256
ASGNF4
line 395
;395:		VectorSet(weaponInfo->missileDlightColor, 1.0, 1.0, 0.5);
ADDRLP4 8
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1056964608
ASGNF4
line 396
;396:		weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 397
;397:		weaponInfo->missileTrailFunc	= FX_RocketProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 FX_RocketProjectileThink
ASGNP4
line 399
;398:
;399:		weaponInfo->altFlashSound[0]	= trap_S_RegisterSound( "sound/weapons/rocket/alt_fire.wav");
ADDRGP4 $366
ARGP4
ADDRLP4 492
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 492
INDIRI4
ASGNI4
line 400
;400:		weaponInfo->altFiringSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 401
;401:		weaponInfo->altChargeSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 402
;402:		weaponInfo->altMuzzleEffect		= trap_FX_RegisterEffect( "rocket/muzzle_flash" );
ADDRGP4 $363
ARGP4
ADDRLP4 496
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 496
INDIRI4
ASGNI4
line 403
;403:		weaponInfo->altMissileModel		= trap_R_RegisterModel( "models/weapons2/merr_sonn/projectile.md3" );
ADDRGP4 $364
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 500
INDIRI4
ASGNI4
line 404
;404:		weaponInfo->altMissileSound		= trap_S_RegisterSound( "sound/weapons/rocket/missileloop.wav");
ADDRGP4 $365
ARGP4
ADDRLP4 504
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 504
INDIRI4
ASGNI4
line 405
;405:		weaponInfo->altMissileDlight	= 125;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 1123680256
ASGNF4
line 406
;406:		VectorSet(weaponInfo->altMissileDlightColor, 1.0, 1.0, 0.5);
ADDRLP4 8
INDIRP4
CNSTI4 176
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1056964608
ASGNF4
line 407
;407:		weaponInfo->altMissileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 408
;408:		weaponInfo->altMissileTrailFunc = FX_RocketAltProjectileThink;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRGP4 FX_RocketAltProjectileThink
ASGNP4
line 410
;409:
;410:		cgs.effects.rocketShotEffect			= trap_FX_RegisterEffect( "rocket/shot" );
ADDRGP4 $369
ARGP4
ADDRLP4 508
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+124
ADDRLP4 508
INDIRI4
ASGNI4
line 411
;411:		cgs.effects.rocketExplosionEffect		= trap_FX_RegisterEffect( "rocket/explosion" );
ADDRGP4 $372
ARGP4
ADDRLP4 512
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+128
ADDRLP4 512
INDIRI4
ASGNI4
line 413
;412:	
;413:		trap_R_RegisterShaderNoMip( "gfx/2d/wedge" );
ADDRGP4 $373
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 414
;414:		trap_R_RegisterShaderNoMip( "gfx/2d/lock" );
ADDRGP4 $374
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 416
;415:
;416:		trap_S_RegisterSound( "sound/weapons/rocket/lock.wav" );
ADDRGP4 $375
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 417
;417:		trap_S_RegisterSound( "sound/weapons/rocket/tick.wav" );
ADDRGP4 $376
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 418
;418:		break;
ADDRGP4 $178
JUMPV
LABELV $377
line 421
;419:
;420:	case WP_THERMAL:
;421:		weaponInfo->flashSound[0]		= trap_S_RegisterSound( "sound/weapons/thermal/fire.wav");
ADDRGP4 $378
ARGP4
ADDRLP4 516
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 516
INDIRI4
ASGNI4
line 422
;422:		weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 423
;423:		weaponInfo->chargeSound			= trap_S_RegisterSound( "sound/weapons/thermal/charge.wav");
ADDRGP4 $379
ARGP4
ADDRLP4 520
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 520
INDIRI4
ASGNI4
line 424
;424:		weaponInfo->muzzleEffect		= NULL_FX;
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
CNSTI4 0
ASGNI4
line 425
;425:		weaponInfo->missileModel		= trap_R_RegisterModel( "models/weapons2/thermal/thermal_proj.md3" );
ADDRGP4 $380
ARGP4
ADDRLP4 524
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 524
INDIRI4
ASGNI4
line 426
;426:		weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 427
;427:		weaponInfo->missileDlight		= 0;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 429
;428://		weaponInfo->missileDlightColor	= {0,0,0};
;429:		weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 430
;430:		weaponInfo->missileTrailFunc	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
CNSTP4 0
ASGNP4
line 432
;431:
;432:		weaponInfo->altFlashSound[0]	= trap_S_RegisterSound( "sound/weapons/thermal/fire.wav");
ADDRGP4 $378
ARGP4
ADDRLP4 528
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 528
INDIRI4
ASGNI4
line 433
;433:		weaponInfo->altFiringSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 434
;434:		weaponInfo->altChargeSound		= trap_S_RegisterSound( "sound/weapons/thermal/charge.wav");
ADDRGP4 $379
ARGP4
ADDRLP4 532
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 532
INDIRI4
ASGNI4
line 435
;435:		weaponInfo->altMuzzleEffect		= NULL_FX;
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 436
;436:		weaponInfo->altMissileModel		= trap_R_RegisterModel( "models/weapons2/thermal/thermal_proj.md3" );
ADDRGP4 $380
ARGP4
ADDRLP4 536
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 536
INDIRI4
ASGNI4
line 437
;437:		weaponInfo->altMissileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 438
;438:		weaponInfo->altMissileDlight	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 0
ASGNF4
line 440
;439://		weaponInfo->altMissileDlightColor= {0,0,0};
;440:		weaponInfo->altMissileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 441
;441:		weaponInfo->altMissileTrailFunc = 0;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
CNSTP4 0
ASGNP4
line 443
;442:
;443:		cgs.effects.thermalExplosionEffect		= trap_FX_RegisterEffect( "thermal/explosion" );
ADDRGP4 $383
ARGP4
ADDRLP4 540
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+132
ADDRLP4 540
INDIRI4
ASGNI4
line 444
;444:		cgs.effects.thermalShockwaveEffect		= trap_FX_RegisterEffect( "thermal/shockwave" );
ADDRGP4 $386
ARGP4
ADDRLP4 544
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+136
ADDRLP4 544
INDIRI4
ASGNI4
line 446
;445:
;446:		cgs.media.grenadeBounce1		= trap_S_RegisterSound( "sound/weapons/thermal/bounce1.wav" );
ADDRGP4 $389
ARGP4
ADDRLP4 548
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+70280+692
ADDRLP4 548
INDIRI4
ASGNI4
line 447
;447:		cgs.media.grenadeBounce2		= trap_S_RegisterSound( "sound/weapons/thermal/bounce2.wav" );
ADDRGP4 $392
ARGP4
ADDRLP4 552
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+70280+696
ADDRLP4 552
INDIRI4
ASGNI4
line 449
;448:
;449:		trap_S_RegisterSound( "sound/weapons/thermal/thermloop.wav" );
ADDRGP4 $393
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 450
;450:		trap_S_RegisterSound( "sound/weapons/thermal/warning.wav" );
ADDRGP4 $394
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 452
;451:
;452:		break;
ADDRGP4 $178
JUMPV
LABELV $395
line 455
;453:
;454:	case WP_TRIP_MINE:
;455:		weaponInfo->flashSound[0]		= trap_S_RegisterSound( "sound/weapons/laser_trap/fire.wav");
ADDRGP4 $396
ARGP4
ADDRLP4 556
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 556
INDIRI4
ASGNI4
line 456
;456:		weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 457
;457:		weaponInfo->chargeSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 458
;458:		weaponInfo->muzzleEffect		= NULL_FX;
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
CNSTI4 0
ASGNI4
line 459
;459:		weaponInfo->missileModel		= 0;//trap_R_RegisterModel( "models/weapons2/laser_trap/laser_trap_w.md3" );
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 460
;460:		weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 461
;461:		weaponInfo->missileDlight		= 0;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 463
;462://		weaponInfo->missileDlightColor	= {0,0,0};
;463:		weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 464
;464:		weaponInfo->missileTrailFunc	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
CNSTP4 0
ASGNP4
line 466
;465:
;466:		weaponInfo->altFlashSound[0]	= trap_S_RegisterSound( "sound/weapons/laser_trap/fire.wav");
ADDRGP4 $396
ARGP4
ADDRLP4 560
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 560
INDIRI4
ASGNI4
line 467
;467:		weaponInfo->altFiringSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 468
;468:		weaponInfo->altChargeSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 469
;469:		weaponInfo->altMuzzleEffect		= NULL_FX;
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 470
;470:		weaponInfo->altMissileModel		= 0;//trap_R_RegisterModel( "models/weapons2/laser_trap/laser_trap_w.md3" );
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 471
;471:		weaponInfo->altMissileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 472
;472:		weaponInfo->altMissileDlight	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 0
ASGNF4
line 474
;473://		weaponInfo->altMissileDlightColor= {0,0,0};
;474:		weaponInfo->altMissileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 475
;475:		weaponInfo->altMissileTrailFunc = 0;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
CNSTP4 0
ASGNP4
line 477
;476:
;477:		cgs.effects.tripmineLaserFX = trap_FX_RegisterEffect("tripMine/laserMP.efx");
ADDRGP4 $399
ARGP4
ADDRLP4 564
ADDRGP4 trap_FX_RegisterEffect
CALLI4
ASGNI4
ADDRGP4 cgs+71560+140
ADDRLP4 564
INDIRI4
ASGNI4
line 479
;478:
;479:		trap_FX_RegisterEffect( "tripMine/explosion" );
ADDRGP4 $400
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 481
;480:		// NOTENOTE temp stuff
;481:		trap_S_RegisterSound( "sound/weapons/laser_trap/stick.wav" );
ADDRGP4 $401
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 482
;482:		trap_S_RegisterSound( "sound/weapons/laser_trap/warning.wav" );
ADDRGP4 $402
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 483
;483:		break;
ADDRGP4 $178
JUMPV
LABELV $403
line 486
;484:
;485:	case WP_DET_PACK:
;486:		weaponInfo->flashSound[0]		= trap_S_RegisterSound( "sound/weapons/detpack/fire.wav");
ADDRGP4 $404
ARGP4
ADDRLP4 568
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 568
INDIRI4
ASGNI4
line 487
;487:		weaponInfo->firingSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 488
;488:		weaponInfo->chargeSound			= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 489
;489:		weaponInfo->muzzleEffect		= NULL_FX;
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
CNSTI4 0
ASGNI4
line 490
;490:		weaponInfo->missileModel		= trap_R_RegisterModel( "models/weapons2/detpack/det_pack.md3" );
ADDRGP4 $405
ARGP4
ADDRLP4 572
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 572
INDIRI4
ASGNI4
line 491
;491:		weaponInfo->missileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 492
;492:		weaponInfo->missileDlight		= 0;
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 0
ASGNF4
line 494
;493://		weaponInfo->missileDlightColor	= {0,0,0};
;494:		weaponInfo->missileHitSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 495
;495:		weaponInfo->missileTrailFunc	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
CNSTP4 0
ASGNP4
line 497
;496:
;497:		weaponInfo->altFlashSound[0]	= trap_S_RegisterSound( "sound/weapons/detpack/fire.wav");
ADDRGP4 $404
ARGP4
ADDRLP4 576
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 576
INDIRI4
ASGNI4
line 498
;498:		weaponInfo->altFiringSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 499
;499:		weaponInfo->altChargeSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 500
;500:		weaponInfo->altMuzzleEffect		= NULL_FX;
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 501
;501:		weaponInfo->altMissileModel		= trap_R_RegisterModel( "models/weapons2/detpack/det_pack.md3" );
ADDRGP4 $405
ARGP4
ADDRLP4 580
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 580
INDIRI4
ASGNI4
line 502
;502:		weaponInfo->altMissileSound		= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 503
;503:		weaponInfo->altMissileDlight	= 0;
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 0
ASGNF4
line 505
;504://		weaponInfo->altMissileDlightColor= {0,0,0};
;505:		weaponInfo->altMissileHitSound	= NULL_SOUND;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 506
;506:		weaponInfo->altMissileTrailFunc = 0;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
CNSTP4 0
ASGNP4
line 508
;507:
;508:		trap_FX_RegisterEffect( "detpack/explosion.efx" );
ADDRGP4 $406
ARGP4
ADDRGP4 trap_FX_RegisterEffect
CALLI4
pop
line 510
;509:
;510:		trap_R_RegisterModel( "models/weapons2/detpack/det_pack.md3" );
ADDRGP4 $405
ARGP4
ADDRGP4 trap_R_RegisterModel
CALLI4
pop
line 511
;511:		trap_S_RegisterSound( "sound/weapons/detpack/stick.wav" );
ADDRGP4 $407
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 512
;512:		trap_S_RegisterSound( "sound/weapons/detpack/warning.wav" );
ADDRGP4 $408
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 513
;513:		trap_S_RegisterSound( "sound/weapons/explosions/explode5.wav" );
ADDRGP4 $409
ARGP4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 514
;514:		break;
ADDRGP4 $178
JUMPV
LABELV $177
line 517
;515:
;516:	 default:
;517:		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 1 );
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTF4 1065353216
ASGNF4
line 518
;518:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/rocket/rocklf1a.wav" );
ADDRGP4 $410
ARGP4
ADDRLP4 584
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 584
INDIRI4
ASGNI4
line 519
;519:		break;
LABELV $178
line 521
;520:	}
;521:}
LABELV $120
endproc CG_RegisterWeapon 588 12
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
LABELV $410
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
char 1 114
char 1 111
char 1 99
char 1 107
char 1 108
char 1 102
char 1 49
char 1 97
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $409
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
char 1 101
char 1 120
char 1 112
char 1 108
char 1 111
char 1 115
char 1 105
char 1 111
char 1 110
char 1 115
char 1 47
char 1 101
char 1 120
char 1 112
char 1 108
char 1 111
char 1 100
char 1 101
char 1 53
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $408
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
char 1 101
char 1 116
char 1 112
char 1 97
char 1 99
char 1 107
char 1 47
char 1 119
char 1 97
char 1 114
char 1 110
char 1 105
char 1 110
char 1 103
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $407
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
char 1 101
char 1 116
char 1 112
char 1 97
char 1 99
char 1 107
char 1 47
char 1 115
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
LABELV $406
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
LABELV $405
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
char 1 100
char 1 101
char 1 116
char 1 112
char 1 97
char 1 99
char 1 107
char 1 47
char 1 100
char 1 101
char 1 116
char 1 95
char 1 112
char 1 97
char 1 99
char 1 107
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $404
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
char 1 101
char 1 116
char 1 112
char 1 97
char 1 99
char 1 107
char 1 47
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $402
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
char 1 108
char 1 97
char 1 115
char 1 101
char 1 114
char 1 95
char 1 116
char 1 114
char 1 97
char 1 112
char 1 47
char 1 119
char 1 97
char 1 114
char 1 110
char 1 105
char 1 110
char 1 103
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $401
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
char 1 108
char 1 97
char 1 115
char 1 101
char 1 114
char 1 95
char 1 116
char 1 114
char 1 97
char 1 112
char 1 47
char 1 115
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
LABELV $400
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
char 1 0
align 1
LABELV $399
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
char 1 77
char 1 80
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $396
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
char 1 108
char 1 97
char 1 115
char 1 101
char 1 114
char 1 95
char 1 116
char 1 114
char 1 97
char 1 112
char 1 47
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $394
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
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 97
char 1 108
char 1 47
char 1 119
char 1 97
char 1 114
char 1 110
char 1 105
char 1 110
char 1 103
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $393
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
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 97
char 1 108
char 1 47
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 108
char 1 111
char 1 111
char 1 112
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $392
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
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 97
char 1 108
char 1 47
char 1 98
char 1 111
char 1 117
char 1 110
char 1 99
char 1 101
char 1 50
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $389
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
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 97
char 1 108
char 1 47
char 1 98
char 1 111
char 1 117
char 1 110
char 1 99
char 1 101
char 1 49
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $386
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 97
char 1 108
char 1 47
char 1 115
char 1 104
char 1 111
char 1 99
char 1 107
char 1 119
char 1 97
char 1 118
char 1 101
char 1 0
align 1
LABELV $383
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 97
char 1 108
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
char 1 0
align 1
LABELV $380
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
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 97
char 1 108
char 1 47
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 97
char 1 108
char 1 95
char 1 112
char 1 114
char 1 111
char 1 106
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $379
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
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 97
char 1 108
char 1 47
char 1 99
char 1 104
char 1 97
char 1 114
char 1 103
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $378
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
char 1 116
char 1 104
char 1 101
char 1 114
char 1 109
char 1 97
char 1 108
char 1 47
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $376
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
LABELV $375
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
LABELV $374
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
LABELV $373
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
LABELV $372
char 1 114
char 1 111
char 1 99
char 1 107
char 1 101
char 1 116
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
char 1 0
align 1
LABELV $369
char 1 114
char 1 111
char 1 99
char 1 107
char 1 101
char 1 116
char 1 47
char 1 115
char 1 104
char 1 111
char 1 116
char 1 0
align 1
LABELV $366
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
char 1 97
char 1 108
char 1 116
char 1 95
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $365
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
char 1 109
char 1 105
char 1 115
char 1 115
char 1 105
char 1 108
char 1 101
char 1 108
char 1 111
char 1 111
char 1 112
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $364
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
char 1 109
char 1 101
char 1 114
char 1 114
char 1 95
char 1 115
char 1 111
char 1 110
char 1 110
char 1 47
char 1 112
char 1 114
char 1 111
char 1 106
char 1 101
char 1 99
char 1 116
char 1 105
char 1 108
char 1 101
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $363
char 1 114
char 1 111
char 1 99
char 1 107
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
char 1 0
align 1
LABELV $362
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
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $360
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
LABELV $359
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
char 1 0
align 1
LABELV $356
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
char 1 0
align 1
LABELV $353
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
char 1 115
char 1 104
char 1 111
char 1 116
char 1 0
align 1
LABELV $350
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
char 1 115
char 1 104
char 1 111
char 1 116
char 1 0
align 1
LABELV $347
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
char 1 103
char 1 111
char 1 108
char 1 97
char 1 110
char 1 95
char 1 97
char 1 114
char 1 109
char 1 115
char 1 47
char 1 112
char 1 114
char 1 111
char 1 106
char 1 101
char 1 99
char 1 116
char 1 105
char 1 108
char 1 101
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $346
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
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $345
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
char 1 103
char 1 111
char 1 108
char 1 97
char 1 110
char 1 95
char 1 97
char 1 114
char 1 109
char 1 115
char 1 47
char 1 112
char 1 114
char 1 111
char 1 106
char 1 101
char 1 99
char 1 116
char 1 105
char 1 108
char 1 101
char 1 77
char 1 97
char 1 105
char 1 110
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $344
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
char 1 0
align 1
LABELV $343
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
char 1 108
char 1 101
char 1 99
char 1 104
char 1 101
char 1 116
char 1 116
char 1 101
char 1 47
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $341
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 108
char 1 105
char 1 103
char 1 104
char 1 116
char 1 110
char 1 105
char 1 110
char 1 103
char 1 70
char 1 108
char 1 97
char 1 115
char 1 104
char 1 0
align 1
LABELV $338
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
char 1 100
char 1 101
char 1 109
char 1 112
char 1 50
char 1 115
char 1 104
char 1 101
char 1 108
char 1 108
char 1 0
align 1
LABELV $335
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
char 1 115
char 1 112
char 1 104
char 1 101
char 1 114
char 1 101
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $332
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
LABELV $331
char 1 100
char 1 101
char 1 109
char 1 112
char 1 50
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
char 1 0
align 1
LABELV $328
char 1 100
char 1 101
char 1 109
char 1 112
char 1 50
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
char 1 0
align 1
LABELV $325
char 1 100
char 1 101
char 1 109
char 1 112
char 1 50
char 1 47
char 1 112
char 1 114
char 1 111
char 1 106
char 1 101
char 1 99
char 1 116
char 1 105
char 1 108
char 1 101
char 1 0
align 1
LABELV $322
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
char 1 101
char 1 109
char 1 112
char 1 50
char 1 47
char 1 97
char 1 108
char 1 116
char 1 67
char 1 104
char 1 97
char 1 114
char 1 103
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $321
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
char 1 101
char 1 109
char 1 112
char 1 50
char 1 47
char 1 97
char 1 108
char 1 116
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $320
char 1 100
char 1 101
char 1 109
char 1 112
char 1 50
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
char 1 0
align 1
LABELV $319
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
char 1 101
char 1 109
char 1 112
char 1 50
char 1 47
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $317
char 1 114
char 1 101
char 1 112
char 1 101
char 1 97
char 1 116
char 1 101
char 1 114
char 1 47
char 1 99
char 1 111
char 1 110
char 1 99
char 1 117
char 1 115
char 1 115
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $314
char 1 114
char 1 101
char 1 112
char 1 101
char 1 97
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
char 1 0
align 1
LABELV $311
char 1 114
char 1 101
char 1 112
char 1 101
char 1 97
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
char 1 0
align 1
LABELV $308
char 1 114
char 1 101
char 1 112
char 1 101
char 1 97
char 1 116
char 1 101
char 1 114
char 1 47
char 1 97
char 1 108
char 1 116
char 1 95
char 1 112
char 1 114
char 1 111
char 1 106
char 1 101
char 1 99
char 1 116
char 1 105
char 1 108
char 1 101
char 1 0
align 1
LABELV $305
char 1 114
char 1 101
char 1 112
char 1 101
char 1 97
char 1 116
char 1 101
char 1 114
char 1 47
char 1 112
char 1 114
char 1 111
char 1 106
char 1 101
char 1 99
char 1 116
char 1 105
char 1 108
char 1 101
char 1 0
align 1
LABELV $302
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
char 1 101
char 1 112
char 1 101
char 1 97
char 1 116
char 1 101
char 1 114
char 1 47
char 1 97
char 1 108
char 1 116
char 1 95
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $301
char 1 114
char 1 101
char 1 112
char 1 101
char 1 97
char 1 116
char 1 101
char 1 114
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
char 1 0
align 1
LABELV $300
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
char 1 101
char 1 112
char 1 101
char 1 97
char 1 116
char 1 101
char 1 114
char 1 47
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $298
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
char 1 103
char 1 114
char 1 101
char 1 101
char 1 110
char 1 70
char 1 114
char 1 111
char 1 110
char 1 116
char 1 70
char 1 108
char 1 97
char 1 115
char 1 104
char 1 0
align 1
LABELV $295
char 1 98
char 1 111
char 1 119
char 1 99
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
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
char 1 0
align 1
LABELV $292
char 1 98
char 1 111
char 1 119
char 1 99
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 115
char 1 104
char 1 111
char 1 116
char 1 0
align 1
LABELV $289
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
char 1 111
char 1 119
char 1 99
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 97
char 1 108
char 1 116
char 1 99
char 1 104
char 1 97
char 1 114
char 1 103
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $288
char 1 98
char 1 111
char 1 119
char 1 99
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
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
char 1 0
align 1
LABELV $287
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
char 1 111
char 1 119
char 1 99
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $285
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
char 1 108
char 1 111
char 1 111
char 1 112
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $282
char 1 103
char 1 102
char 1 120
char 1 47
char 1 50
char 1 100
char 1 47
char 1 99
char 1 114
char 1 111
char 1 112
char 1 95
char 1 99
char 1 104
char 1 97
char 1 114
char 1 103
char 1 101
char 1 0
align 1
LABELV $279
char 1 103
char 1 102
char 1 120
char 1 47
char 1 50
char 1 100
char 1 47
char 1 105
char 1 110
char 1 115
char 1 101
char 1 114
char 1 116
char 1 84
char 1 105
char 1 99
char 1 107
char 1 0
align 1
LABELV $276
char 1 103
char 1 102
char 1 120
char 1 47
char 1 50
char 1 100
char 1 47
char 1 99
char 1 114
char 1 111
char 1 112
char 1 67
char 1 105
char 1 114
char 1 99
char 1 108
char 1 101
char 1 71
char 1 108
char 1 111
char 1 119
char 1 0
align 1
LABELV $273
char 1 103
char 1 102
char 1 120
char 1 47
char 1 50
char 1 100
char 1 47
char 1 99
char 1 114
char 1 111
char 1 112
char 1 67
char 1 105
char 1 114
char 1 99
char 1 108
char 1 101
char 1 0
align 1
LABELV $270
char 1 103
char 1 102
char 1 120
char 1 47
char 1 50
char 1 100
char 1 47
char 1 99
char 1 114
char 1 111
char 1 112
char 1 67
char 1 105
char 1 114
char 1 99
char 1 108
char 1 101
char 1 50
char 1 0
align 1
LABELV $267
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
LABELV $266
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
LABELV $265
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
char 1 109
char 1 111
char 1 107
char 1 101
char 1 84
char 1 114
char 1 97
char 1 105
char 1 108
char 1 0
align 1
LABELV $264
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 105
char 1 115
char 1 99
char 1 47
char 1 119
char 1 104
char 1 105
char 1 116
char 1 101
char 1 108
char 1 105
char 1 110
char 1 101
char 1 50
char 1 0
align 1
LABELV $263
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
char 1 114
char 1 101
char 1 100
char 1 76
char 1 105
char 1 110
char 1 101
char 1 0
align 1
LABELV $262
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
char 1 97
char 1 108
char 1 116
char 1 95
char 1 104
char 1 105
char 1 116
char 1 0
align 1
LABELV $259
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
char 1 97
char 1 108
char 1 116
char 1 95
char 1 109
char 1 105
char 1 115
char 1 115
char 1 0
align 1
LABELV $256
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
char 1 0
align 1
LABELV $253
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
char 1 0
align 1
LABELV $250
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
char 1 112
char 1 114
char 1 111
char 1 106
char 1 101
char 1 99
char 1 116
char 1 105
char 1 108
char 1 101
char 1 0
align 1
LABELV $247
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
char 1 114
char 1 105
char 1 110
char 1 103
char 1 115
char 1 0
align 1
LABELV $244
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
char 1 97
char 1 108
char 1 116
char 1 67
char 1 104
char 1 97
char 1 114
char 1 103
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $243
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
char 1 97
char 1 108
char 1 116
char 1 95
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $242
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
char 1 0
align 1
LABELV $241
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
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $239
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
LABELV $238
char 1 98
char 1 108
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 100
char 1 114
char 1 111
char 1 105
char 1 100
char 1 95
char 1 105
char 1 109
char 1 112
char 1 97
char 1 99
char 1 116
char 1 0
align 1
LABELV $235
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
char 1 0
align 1
LABELV $232
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
char 1 0
align 1
LABELV $229
char 1 98
char 1 108
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 115
char 1 104
char 1 111
char 1 116
char 1 0
align 1
LABELV $226
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
char 1 0
align 1
LABELV $225
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
char 1 108
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 97
char 1 108
char 1 116
char 1 95
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $224
char 1 98
char 1 108
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
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
char 1 0
align 1
LABELV $223
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
char 1 108
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 47
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $221
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
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $220
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
LABELV $219
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
LABELV $218
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
LABELV $217
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
char 1 98
char 1 114
char 1 121
char 1 97
char 1 114
char 1 70
char 1 114
char 1 111
char 1 110
char 1 116
char 1 70
char 1 108
char 1 97
char 1 115
char 1 104
char 1 0
align 1
LABELV $214
char 1 98
char 1 114
char 1 121
char 1 97
char 1 114
char 1 47
char 1 100
char 1 114
char 1 111
char 1 105
char 1 100
char 1 95
char 1 105
char 1 109
char 1 112
char 1 97
char 1 99
char 1 116
char 1 0
align 1
LABELV $211
char 1 98
char 1 114
char 1 121
char 1 97
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
char 1 0
align 1
LABELV $208
char 1 98
char 1 114
char 1 121
char 1 97
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
char 1 51
char 1 0
align 1
LABELV $205
char 1 98
char 1 114
char 1 121
char 1 97
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
char 1 50
char 1 0
align 1
LABELV $202
char 1 98
char 1 114
char 1 121
char 1 97
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
char 1 0
align 1
LABELV $199
char 1 98
char 1 114
char 1 121
char 1 97
char 1 114
char 1 47
char 1 99
char 1 114
char 1 97
char 1 99
char 1 107
char 1 108
char 1 101
char 1 83
char 1 104
char 1 111
char 1 116
char 1 0
align 1
LABELV $196
char 1 98
char 1 114
char 1 121
char 1 97
char 1 114
char 1 47
char 1 115
char 1 104
char 1 111
char 1 116
char 1 0
align 1
LABELV $194
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
char 1 114
char 1 121
char 1 97
char 1 114
char 1 47
char 1 97
char 1 108
char 1 116
char 1 99
char 1 104
char 1 97
char 1 114
char 1 103
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $193
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
char 1 114
char 1 121
char 1 97
char 1 114
char 1 47
char 1 97
char 1 108
char 1 116
char 1 95
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $192
char 1 98
char 1 114
char 1 121
char 1 97
char 1 114
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
char 1 0
align 1
LABELV $191
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
char 1 114
char 1 121
char 1 97
char 1 114
char 1 47
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 119
char 1 97
char 1 118
char 1 0
align 1
LABELV $189
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
LABELV $188
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
LABELV $186
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
char 1 102
char 1 105
char 1 114
char 1 101
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $185
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
LABELV $184
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
char 1 109
char 1 101
char 1 108
char 1 101
char 1 101
char 1 47
char 1 112
char 1 117
char 1 110
char 1 99
char 1 104
char 1 52
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $183
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
char 1 109
char 1 101
char 1 108
char 1 101
char 1 101
char 1 47
char 1 112
char 1 117
char 1 110
char 1 99
char 1 104
char 1 51
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $182
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
char 1 109
char 1 101
char 1 108
char 1 101
char 1 101
char 1 47
char 1 112
char 1 117
char 1 110
char 1 99
char 1 104
char 1 50
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $181
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
char 1 109
char 1 101
char 1 108
char 1 101
char 1 101
char 1 47
char 1 112
char 1 117
char 1 110
char 1 99
char 1 104
char 1 49
char 1 46
char 1 109
char 1 112
char 1 51
char 1 0
align 1
LABELV $180
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
char 1 0
align 1
LABELV $176
char 1 101
char 1 102
char 1 102
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 100
char 1 114
char 1 97
char 1 105
char 1 110
char 1 104
char 1 105
char 1 116
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $173
char 1 101
char 1 102
char 1 102
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 100
char 1 114
char 1 97
char 1 105
char 1 110
char 1 119
char 1 105
char 1 100
char 1 101
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $170
char 1 101
char 1 102
char 1 102
char 1 101
char 1 99
char 1 116
char 1 115
char 1 47
char 1 109
char 1 112
char 1 47
char 1 100
char 1 114
char 1 97
char 1 105
char 1 110
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $167
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
char 1 47
char 1 108
char 1 105
char 1 103
char 1 104
char 1 116
char 1 110
char 1 105
char 1 110
char 1 103
char 1 119
char 1 105
char 1 100
char 1 101
char 1 46
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $164
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
char 1 47
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
char 1 101
char 1 102
char 1 120
char 1 0
align 1
LABELV $161
char 1 95
char 1 104
char 1 97
char 1 110
char 1 100
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $158
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
char 1 116
char 1 117
char 1 110
char 1 95
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 47
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 95
char 1 98
char 1 97
char 1 114
char 1 114
char 1 101
char 1 108
char 1 51
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $157
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
char 1 116
char 1 117
char 1 110
char 1 95
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 47
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 95
char 1 98
char 1 97
char 1 114
char 1 114
char 1 101
char 1 108
char 1 50
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $156
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
char 1 116
char 1 117
char 1 110
char 1 95
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 47
char 1 98
char 1 97
char 1 116
char 1 111
char 1 110
char 1 95
char 1 98
char 1 97
char 1 114
char 1 114
char 1 101
char 1 108
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $153
char 1 95
char 1 98
char 1 97
char 1 114
char 1 114
char 1 101
char 1 108
char 1 46
char 1 109
char 1 100
char 1 51
char 1 0
align 1
LABELV $134
char 1 67
char 1 111
char 1 117
char 1 108
char 1 100
char 1 110
char 1 39
char 1 116
char 1 32
char 1 102
char 1 105
char 1 110
char 1 100
char 1 32
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 32
char 1 37
char 1 105
char 1 0
