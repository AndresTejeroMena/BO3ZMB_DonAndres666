#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm_weapons;

//Perks
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;

//Powerups
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;

//Traps
#using scripts\zm\_zm_trap_electric;

#using scripts\zm\zm_usermap;

#using scripts\zm\zm_flashlight;

function main()
{
//________________________________________[HUD]________________________________________//	
    clientfield::register( "clientuimodel", "zmhud.playerHealth", VERSION_SHIP, 7, "float", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    LuiLoad( "ui.uieditor.menus.hud.t7hud_zm_madgaz" );
	LuiLoad( "ui.uieditor.widgets._mg_hud._mg_powerup_icons" );
//________________________________________[HUD]________________________________________//
	zm_usermap::main();

//________________________________________[HUD]________________________________________//
    	level.aat["zm_aat_blast_furnace"].icon = "_mg_blastfurance_aat";
    	level.aat["zm_aat_dead_wire"].icon = "_mg_deadwire_aat";
    	level.aat["zm_aat_fire_works"].icon = "_mg_fireworks_aat";
    	level.aat["zm_aat_thunder_wall"].icon = "_mg_thunderwall_aat";
    	level.aat["zm_aat_turned"].icon = "_mg_turned_aat";
//________________________________________[HUD]________________________________________//

	callback::on_localclient_connect( &on_player_connect ); //Wait for the player to connect 
    util::waitforclient( 0 );

	include_weapons();
	
	util::waitforclient( 0 );
}

function include_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

function on_player_connect( localclientnum ) 
{   
	cam_01 = GetEnt( localclientnum, "cam_01", "targetname" );// add your script origin targetname
	cam_01 SetExtraCam( 0, 1920, 1080 ); //  add cam number / Activates the camera so it will be displayed on screen. 
	thread check_reloj( localclientnum );
	thread valor("reloj_hora_d",6);
	thread valor("reloj_hora",6);
	thread valor("reloj_min_d",7);
	thread valor("reloj_min",7);
}  
function check_reloj(clientNum)
{
	model = GetEnt(clientNum, "puerta_reloj", "targetname");
	while(1)
	{
		level waittill("check_reloj");
		wait(0.3);
		curr_time = GetSystemTime();
		hours = curr_time[0];
		minutes = curr_time[1];
		seconds = curr_time[2];
		//iprintlnbold(hours + ":" + minutes + ":" + seconds);
		hora = (level.valor_hora["reloj_hora_d"]*10)+level.valor_hora["reloj_hora"];
		min = (level.valor_hora["reloj_min_d"]*10)+level.valor_hora["reloj_min"];

		if (hora == hours)
		{
			if (min == minutes)
			{
				iprintlnbold("puzzle completed");
				break;
			}
		}

	}
	model MoveZ(50,2);
}
function valor(notif,valor_inicial)
{
	level.valor_hora[notif] = valor_inicial;
	while(1)
	{
		level waittill(notif);
		level.valor_hora[notif] ++;
		if (level.valor_hora[notif] >= 10)
		{
			level.valor_hora[notif] = 0;
		}
	}
}

