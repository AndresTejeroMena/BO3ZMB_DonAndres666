#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;

#using scripts\shared\ai\zombie_utility;

#using scripts\zm\_zm_score;
#using scripts\zm\_zm_bgb;

//Perks
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;

#using scripts\zm\_zm_perk_electric_cherry;
#using scripts\zm\_zm_perk_widows_wine; 

#using scripts\zm\_zm_perk_bandolier_bandit;
#using scripts\zm\_zm_perk_blaze_phase;
#using scripts\zm\_zm_perk_dying_wish;
#using scripts\zm\_zm_perk_ethereal_razor;
#using scripts\zm\_zm_perk_phd_slider;
#using scripts\zm\_zm_perk_stone_cold_stronghold;
#using scripts\zm\_zm_perk_timeslip;
#using scripts\zm\_zm_perk_victorious_tortoise;
#using scripts\zm\_zm_perk_winters_wail;
#using scripts\zm\_zm_perk_zombshell;
#using scripts\zm\_zm_perk_blood_wolf_bite;


//Powerups
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
//#using scripts\zm\_zm_powerup_weapon_minigun;

//TELEPORT
#using scripts\shared\lui_shared;

//Traps
#using scripts\zm\_zm_trap_electric;

#using scripts\zm\zm_usermap;



	//almas
#using scripts\zm\growing_soulbox;

//Custom Powerups By ZoekMeMaar
#using scripts\_ZoekMeMaar\custom_powerup_free_packapunch_with_time;

#using scripts\zm\_zm_perks;
#insert scripts\zm\_zm_perks.gsh;

#using scripts\zm\_zm_ai_dogs;

//timegameplay
#using scripts\zm\ugxmods_timedgp;

// Sphynx's Console Commands
	#using scripts\Sphynx\_zm_subtitles;



#precache( "fx", "dlc1/castle/fx_rocket_exhaust_takeoff" );
#precache("xanim", "voltea_atras" );
#precache("xanim", "habla_izq_dch" );
#precache("xanim", "apagado" );//looping
#precache("xanim", "brinca" );
#precache("xanim", "enter_bus" );
#precache("xanim", "gira" );
#precache("xanim", "habla" );
#precache("xanim", "mira_abajo" );
#precache("xanim", "se_aloca" );
#precache("xanim", "se_despierta" );

#using_animtree("bus_tranzit");
//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{
	//CUSTOM HUD
	clientfield::register("world", "qr1", VERSION_SHIP, 1, "int");

	clientfield::register("world", "dt1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ec1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "jg1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sc1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "su1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sz1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "w1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ww1", VERSION_SHIP, 1, "int");

	clientfield::register("world", "dtt1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ect1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "jgt1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sct1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sut1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "szt1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "wt1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "wwt1", VERSION_SHIP, 1, "int");

	clientfield::register("world", "qr2", VERSION_SHIP, 1, "int");

	clientfield::register("world", "dt2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ec2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "jg2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sc2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "su2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sz2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "w2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ww2", VERSION_SHIP, 1, "int");

	clientfield::register("world", "dtt2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ect2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "jgt2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sct2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sut2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "szt2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "wt2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "wwt2", VERSION_SHIP, 1, "int");

	clientfield::register("world", "qr3", VERSION_SHIP, 1, "int");

	clientfield::register("world", "dt3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ec3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "jg3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sc3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "su3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sz3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "w3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ww3", VERSION_SHIP, 1, "int");

	clientfield::register("world", "dtt3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ect3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "jgt3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sct3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sut3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "szt3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "wt3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "wwt3", VERSION_SHIP, 1, "int");

	clientfield::register("world", "qr4", VERSION_SHIP, 1, "int");

	clientfield::register("world", "dt4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ec4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "jg4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sc4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "su4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sz4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "w4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ww4", VERSION_SHIP, 1, "int");

	clientfield::register("world", "dtt4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ect4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "jgt4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sct4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "sut4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "szt4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "wt4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "wwt4", VERSION_SHIP, 1, "int");

	clientfield::register("world", "ep1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ept1", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ep2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ept2", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ep3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ept3", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ep4", VERSION_SHIP, 1, "int");
	clientfield::register("world", "ept4", VERSION_SHIP, 1, "int");


	level.dog_rounds_allowed = false;
	zm_usermap::main();

	level._zombie_custom_add_weapons =&custom_add_weapons;
	
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	level.pathdist_type = PATHDIST_ORIGINAL;

	//time free pap
	level.temp_upgraded_time = 30;

	level.perk_purchase_limit = 20;
	level.player_starting_points = 0;
	level.start_weapon = getWeapon("t6_tac45");

	 //CUSTOM PACK A PUNCH CAMO
    level.pack_a_punch_camo_index =136; 

	//GROW_SOUL
	grow_soul::init(  );

	thread creditos();

	thread get_su_trigger();
	thread get_ec_trigger();
	thread get_jg_trigger();
	thread get_jgt_trigger();
	thread get_ww_trigger();
	thread get_wwt_trigger();
	thread get_dt_trigger();
	thread get_dtt_trigger();
	thread get_w_trigger();
	thread get_wt_trigger();
	thread get_sz_trigger();
	thread get_szt_trigger();
	thread get_sc_trigger();
	thread get_sct_trigger();

	thread slow_zombies_perk_trigger();
	thread slow_zombies_perk();

	thread sprint_zombies_perk_trigger();
	thread sprint_zombies_perk();

	thread extra_points_perk_trigger();
	thread extra_points_perk();

	thread lost_points_perk_trigger();
	thread lost_points_perk();

	thread troll_grenade_perk_trigger();
	//thread troll_grenade_perk();   se lama desde la otra funcion

	thread jumpscare_perk_trigger();
	thread jumpscare_perk();

	thread low_hp_perk_trigger();
	thread low_hp_perk();

	thread troll_electric_cherry_perk_trigger();
	//thread troll_electric_cherry_perk();  se lama desde la otra funcion

	thread hell_dog_perk_trigger();
	//thread hell_dog_perk();  se lama desde la otra funcion

	thread disable_sprint_perk_trigger();
	thread disable_sprint_perk();

	thread blood_wolf_bite_perk_trigger();

	thread lost_ammo_perk_trigger();
	//thread lost_ammo_perk();
	thread restaurantes();
	thread doors();

	thread intro_map();
	thread dont_press_button();
	thread player_down();

	thread show_quick_revive();
	thread spain();
	thread end_map();

	thread custom_weapons();
	thread ez_mode();
	thread troll_mode();

}

function usermap_test_zone_init()
{
	zm_zonemgr::add_adjacent_zone("start_zone","zone_1","zone_1_flag");
	zm_zonemgr::add_adjacent_zone("zone_1","zone_2","zone_2_flag");
	zm_zonemgr::add_adjacent_zone("zone_2","zone_3","zone_3_flag");
	zm_zonemgr::add_adjacent_zone("zone_3","zone_4","zone_4_flag");
	zm_zonemgr::add_adjacent_zone("zone_4","zone_5","zone_5_flag");
	zm_zonemgr::add_adjacent_zone("zone_5","zone_6","zone_6_flag");
	zm_zonemgr::add_adjacent_zone("zone_6","zone_7","zone_7_flag");
	zm_zonemgr::add_adjacent_zone("zone_7","zone_8","zone_8_flag");
	zm_zonemgr::add_adjacent_zone("zone_8","zone_9","zone_9_flag");
	zm_zonemgr::add_adjacent_zone("zone_9","zone_final","zone_10_flag");
	level flag::init( "always_on" );
	level flag::set( "always_on" );

}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}
function creditos()
{
	level flag::wait_till("initial_blackscreen_passed");
	iprintlnbold("This map was created by DonAndres_666, Enjoy!"); 
	flag::init( "power_on" ); 
    flag::set("power_on");
}

function slow_zombies_perk_trigger()
{
	trig = getEnt("SZ_trig","targetname");
	trig SetHintString("Slow Zombies Perk");
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_slow_zombies_perk[player_numb]= true;
		thread show_perk_hud(player_numb,"sz",1);
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_slow_zombies_perk[player_numb]= false;
		thread show_perk_hud(player_numb,"sz",0);
	}

}
function slow_zombies_perk()
{
	level.has_slow_zombies_perk[0]= false;
	level.has_slow_zombies_perk[1]= false;
	level.has_slow_zombies_perk[2]= false;
	level.has_slow_zombies_perk[3]= false;
	zm_utility::register_slowdown( "slow_zombie", 0.7, 0.3 );

	while(1)
            {
                a_zombies = getAITeamArray( level.zombie_team );
                 foreach(ai in a_zombies)
                   {
                   	foreach(player in getplayers() )
        				{
        					player_numb = player.characterindex; 
        					if (level.has_slow_zombies_perk[player_numb]== true)
        					{
        						if (player IsLookingAt(ai))
        						{
        						ai thread zm_utility::slowdown_ai( "slow_zombie" );
        						ai thread cercanos();
        						}
        					}	
        				}
           	       }
                wait 0.05;
            }
}
function cercanos()
{
	a_zombies = zombie_utility::get_round_enemy_array();
	a_zombies = util::get_array_of_closest( self.origin, a_zombies, undefined, undefined, 150 );		
		for ( i = 0; i < a_zombies.size; i++ )
			{
				a_zombies[ i ] thread zm_utility::slowdown_ai( "slow_zombie" );
			}
}


function sprint_zombies_perk_trigger()
{
	trig = getEnt("sprintzmb_trig","targetname");
	trig SetHintString("Sprint Zombies Perk");
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_sprint_zombies_perk[player_numb]= true;
		thread show_perk_hud(player_numb,"sut",1);
	}

}
function sprint_zombies_perk()
{
	level.has_sprint_zombies_perk[0]= false;
	level.has_sprint_zombies_perk[1]= false;
	level.has_sprint_zombies_perk[2]= false;
	level.has_sprint_zombies_perk[3]= false;

	while(1)
            {
                   	foreach(player in getplayers() )
        				{
        					player_numb = player.characterindex; 
        					if (level.has_sprint_zombies_perk[player_numb]== true)
        					{
        						level.zombie_init_done = &mpjw_make_sprinter;
        						break;
        					}	
        				}
                wait 0.05;
            }
}
function mpjw_make_sprinter()
{
    if ( isDefined( level.ptr_zombie_init_done ) )
        self [ [ level.ptr_zombie_init_done ] ]();
    
    self zombie_utility::set_zombie_run_cycle( "super_sprint" ); //"walk" "run" "sprint"
}

function get_su_trigger()
{
	trig = getEnt("get_su","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_su","targetname");
	level waittill ("almas_su_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to get Stamin Up. ^5Cost: 2000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 2000)&&(player HasPerk("specialty_staminup") == false ))
		{
			player thread minus_to_player_score_v2(2000);
			player zm_perks::give_perk(PERK_STAMINUP);
			thread show_perk_hud(player_numb,"su",1);
		}
		wait(1);
		
	}

}
function get_ec_trigger()
{
	trig = getEnt("get_ec","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_ec","targetname");
	level waittill ("almas_ec_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Disable Troll Electric Cherry and buy Electric Cherry ^5Cost: 2500pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 2500)&& (level.has_ec[player_numb]== false ))
		{
			player thread minus_to_player_score_v2(2500);
			level.has_troll_electric_cherry_perk[player_numb] = false;
			level.has_ec[player_numb]= true; 
			player zm_perks::give_perk(PERK_ELECTRIC_CHERRY);
			thread show_perk_hud(player_numb,"ec",1);
			thread show_perk_hud(player_numb,"ect",0);
		}
		wait(1);
		
	}

}
function get_jg_trigger()
{
	trig = getEnt("get_jg","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_jg","targetname");
	level waittill ("almas_jg_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Get Juggernog. ^5Cost: 2500pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 2500)&&(player HasPerk("specialty_armorvest") == false ))
		{
			player thread minus_to_player_score_v2(2500);
			player zm_perks::give_perk(PERK_JUGGERNOG);
			thread show_perk_hud(player_numb,"jg",1);
		}
		wait(1);
		
	}

}
function get_jgt_trigger()
{
	trig = getEnt("get_jgt","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_jg","targetname");
	level waittill ("almas_jg_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Disable Low HP Perk. ^5Cost: 5000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 5000)&&(level.has_low_hp_perk[player_numb] == true))
		{
			player thread minus_to_player_score_v2(5000);
			level.has_low_hp_perk[player_numb] = false;
			thread show_perk_hud(player_numb,"jgt",0);
		}
		wait(1);
		
	}

}
function get_ww_trigger()
{
	trig = getEnt("get_ww","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_ww","targetname");
	level waittill ("almas_ww_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Get Widow's Wine. ^5Cost: 4000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 4000)&&(player HasPerk("specialty_widowswine") == false ))
		{
			player thread minus_to_player_score_v2(4000);
			player zm_perks::give_perk(PERK_WIDOWS_WINE);
			thread show_perk_hud(player_numb,"ww",1);
		}
		wait(1);
		
	}

}
function get_wwt_trigger()
{
	trig = getEnt("get_wwt","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_ww","targetname");
	level waittill ("almas_ww_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Disable Troll Grenade Perk. ^5Cost: 4000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 4000)&& ( level.has_troll_grenade_perk[player_numb] == true))
		{
			player thread minus_to_player_score_v2(4000);
			level.has_troll_grenade_perk[player_numb] = false;
			thread show_perk_hud(player_numb,"wwt",0);
		}
		wait(1);
		
	}

}
function get_dt_trigger()
{
	trig = getEnt("get_dt","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_dt","targetname");
	level waittill ("almas_dt_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Get Double Tap. ^5Cost: 2000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 2000)&&(player HasPerk("specialty_doubletap2") == false ))
		{
			player thread minus_to_player_score_v2(2000);
			player zm_perks::give_perk(PERK_DOUBLETAP2);
			thread show_perk_hud(player_numb,"dt",1);
		}
		wait(1);
		
	}

}
function get_dtt_trigger()
{
	trig = getEnt("get_dtt","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_dt","targetname");
	level waittill ("almas_dt_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Disable Jump Scare Perk. ^5Cost: 5000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 5000) && (level.has_jumpscare_perk[player_numb] == true))
		{
			player thread minus_to_player_score_v2(5000);
			level.has_jumpscare_perk[player_numb] = false;
			thread show_perk_hud(player_numb,"dtt",0);
		}
		wait(1);
		
	}

}
function get_w_trigger()
{
	trig = getEnt("get_w","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_w","targetname");
	level waittill ("almas_w_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Get Blood Wolf Bite. ^5Cost: 2500pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 2500) && (level.has_blood_wolf_bite_perk[player_numb] == false))
		{
			player thread minus_to_player_score_v2(2500);
			level.has_blood_wolf_bite_perk[player_numb]= true;
			player thread blood_wolf_bite::give_custom_perk();
			thread show_perk_hud(player_numb,"w",1);
		}
		wait(1);
		
	}

}
function get_wt_trigger()
{
	trig = getEnt("get_wt","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_w","targetname");
	level waittill ("almas_w_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Disable Hell Dog Bite. ^5Cost: 4000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 4000) && (level.has_hell_dog_perk[player_numb] ==true))
		{
			player thread minus_to_player_score_v2(4000);
			level.has_hell_dog_perk[player_numb] = false;
			thread show_perk_hud(player_numb,"wt",0);
		}
		wait(1);
		
	}

}

function get_sz_trigger()
{
	trig = getEnt("get_sz","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_sz","targetname");
	level waittill ("almas_sz_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Get Slow Zombie Perk. ^5Cost: 4000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 4000) && (level.has_slow_zombies_perk[player_numb] == false))
		{
			player thread minus_to_player_score_v2(4000);
			level.has_slow_zombies_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"sz",1);
		}
		wait(1);
		
	}

}
function get_szt_trigger()
{
	trig = getEnt("get_szt","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_sz","targetname");
	level waittill ("almas_sz_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Disable Slow Player Perk. ^5Cost: 4000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 4000) && (level.has_disable_sprint_perk[player_numb] == true))
		{
			player thread minus_to_player_score_v2(4000);
			level.has_disable_sprint_perk[player_numb] = false;
			thread show_perk_hud(player_numb,"szt",0);
		}
		wait(1);
		
	}

}
function get_sc_trigger()
{
	trig = getEnt("get_sc","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_sc","targetname");
	level waittill ("almas_sc_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Get Speed Cola. ^5Cost: 3000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 3000)&&(player HasPerk("specialty_fastreload") == false ))
		{
			player thread minus_to_player_score_v2(3000);
			player zm_perks::give_perk(PERK_SLEIGHT_OF_HAND);
			thread show_perk_hud(player_numb,"sc",1);
		}
		wait(1);
		
	}

}
function get_sct_trigger()
{
	trig = getEnt("get_sct","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_sc","targetname");
	level waittill ("almas_sc_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to Disable Wasted Ammo Perk. ^5Cost: 5000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 5000) && (level.has_lost_ammo_perk[player_numb] == true))
		{
			player thread minus_to_player_score_v2(5000);
			level.has_lost_ammo_perk[player_numb] = false;
			thread show_perk_hud(player_numb,"sct",0);
		}
		wait(1);
		
	}

}



function extra_points_perk_trigger()
{
	trig = getEnt("extrapoints_trig","targetname");
	trig SetHintString("Collect the souls");
	trig SetCursorHint("HINT_NOICON");
	almas = getEnt("almas_ep","targetname");
	level waittill ("almas_ep_allgrowsouls");
	almas Delete();
	trig SetHintString("Hold ^3[{+activate}]^7 to get Extra Points Perk. ^5Cost: 4000pts");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if ((player.score >= 4000) && (level.has_extra_points_perk[player_numb] == false))
		{
			player thread minus_to_player_score_v2(4000);
			level.has_extra_points_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"ep",1);
			level.has_lost_points_perk[player_numb]= false;
			thread show_perk_hud(player_numb,"ept",0);
		}
		wait(1);
		
	}

}
function extra_points_perk()
{
	level.has_extra_points_perk[0]= false;
	level.has_extra_points_perk[1]= false;
	level.has_extra_points_perk[2]= false;
	level.has_extra_points_perk[3]= false;

	while(1)
            {

					level waittill ("end_of_round");
                   	foreach(player in getplayers() )
        				{
        					player_numb = player.characterindex; 
        					if (level.has_extra_points_perk[player_numb]== true)
        					{
        						puntos = player.score;
        						pts = puntos*0.1;
        						IPrintLnBold(player.playername + " has " + pts + " extra points!");
        						 player zm_score::add_to_player_score(pts);
        					}	
        				}
                
            }
}

function lost_points_perk_trigger()
{
	trig = getEnt("lostpoints_trig","targetname");
	trig SetHintString("Lost Points Perk");
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_lost_points_perk[player_numb]= true;
		thread show_perk_hud(player_numb,"ept",1);
		level.has_extra_points_perk[player_numb]= false;
		thread show_perk_hud(player_numb,"ep",0);
	}

}
function lost_points_perk()
{
	level.has_lost_points_perk[0]= false;
	level.has_lost_points_perk[1]= false;
	level.has_lost_points_perk[2]= false;
	level.has_lost_points_perk[3]= false;

	while(1)
            {

					level waittill ("end_of_round");
                   	foreach(player in getplayers() )
        				{
        					player_numb = player.characterindex; 
        					if (level.has_lost_points_perk[player_numb]== true)
        					{
        						puntos = player.score;
        						pts = puntos*0.1;
        						pts = zm_utility::round_up_score( pts, 10 );
        						IPrintLnBold(player.playername + " has lost " + pts + " points!");

								WAIT_SERVER_FRAME;
        						 player thread minus_to_player_score_v2(pts);
        					}	
        				}
                
            }
}
function minus_to_player_score_v2( points, b_add_to_total = true, str_awarded_by = "" )
{
	if( !isdefined( points ) || level.intermission )
	{
		return;
	}

	points = zm_utility::round_up_score( points, 10 );

	// bgb can intercept the points; all the points will be added to score_total regardless
	n_points_to_add_to_currency = bgb::add_to_player_score_override( points, str_awarded_by );
	
	self.score -= n_points_to_add_to_currency;
	self.pers["score"] = self.score;
	self IncrementPlayerStat("scoreSpent", n_points_to_add_to_currency);
	level notify( "spent_points", self, points );
	
	if( b_add_to_total )
	{
		self.score_total -= points;
		level.score_total -= points; // also add to all players' running total score
	}
	
}


function troll_grenade_perk_trigger()
{
	trig = getEnt("trollgrenade_trig","targetname");
	trig SetHintString("Troll Grenade Perk");
	trig SetCursorHint("HINT_NOICON");

	level.has_troll_grenade_perk[0]= false;
	level.has_troll_grenade_perk[1]= false;
	level.has_troll_grenade_perk[2]= false;
	level.has_troll_grenade_perk[3]= false;

	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_troll_grenade_perk[player_numb]= true;
		thread show_perk_hud(player_numb,"wwt",1);
		thread troll_grenade_perk(player);
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_troll_grenade_perk[player_numb]= false;
		thread show_perk_hud(player_numb,"wwt",0);
	}

}
function troll_grenade_perk(player)
{
	while(1)
	{
		WAIT_SERVER_FRAME;
		t = RandomIntRange(50,140 + 1); //(min result, max rasult + 1)
		//IPrintLnBold(t);
		wait(t);
		if (level.has_troll_grenade_perk[player.characterindex] == false)
        {
        	break;
        }
        player MagicGrenadeType( getWeapon( "frag_grenade" ), player.origin, vectorScale( ( 0, 0, -1 ), 300 ), 2 );
        //IPrintLnBold("troll grenade!!");

        
	}
	
}


function jumpscare_perk_trigger()
{
	trig = getEnt("jumpscare_trigger","targetname");
	trig SetHintString("JumpScare Perk");
	trig SetCursorHint("HINT_NOICON");

	level.has_jumpscare_perk[0]= false;
	level.has_jumpscare_perk[1]= false;
	level.has_jumpscare_perk[2]= false;
	level.has_jumpscare_perk[3]= false;

	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_jumpscare_perk[player_numb]= true;
		thread show_perk_hud(player_numb,"dtt",1);
		 
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_jumpscare_perk[player_numb]= false;		
		thread show_perk_hud(player_numb,"dtt",0);

	}

}
function jumpscare_perk()
{
	while(1)
	{
		WAIT_SERVER_FRAME;
		t = RandomIntRange(100,200); //(min result, max rasult + 1)
		wait(t);
		foreach(player in getplayers() )
		{
			if (level.has_jumpscare_perk[player.characterindex] == true)
       			 {
        			player thread do_jumpscare();
      			 }
		}
        
	}
	
}

function do_jumpscare()
{
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	
	jumpscare_overlay SetShader( "nsz_jumpscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	
	self PlayLocalSound( "nsz_jumpscare" ); 
	wait(2); 
	jumpscare_overlay FadeOverTime( 4 ); 
	jumpscare_overlay.alpha = 0; 
	wait( 4 ); 
	jumpscare_overlay destroy(); 
}

function low_hp_perk_trigger()
{
	trig = getEnt("1hp_trig","targetname");
	trig SetHintString("Low HP Perk");
	trig SetCursorHint("HINT_NOICON");

	level.has_low_hp_perk[0]= false;
	level.has_low_hp_perk[1]= false;
	level.has_low_hp_perk[2]= false;
	level.has_low_hp_perk[3]= false;

	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_low_hp_perk[player_numb]= true;
		thread show_perk_hud(player_numb,"jgt",1);
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_low_hp_perk[player_numb]= false;
		thread show_perk_hud(player_numb,"jgt",0);

	}

}
function low_hp_perk()
{
	while(1)
	{
		level waittill ("end_of_round");
		foreach(player in getplayers() )
		{
			if (level.has_low_hp_perk[player.characterindex] == true)
       			 {
       			 	player PlaySoundToPlayer( "troll_jug_alarma", player );
      			 }
		}
		wait(5);
		foreach(player in getplayers() )
		{
			if (level.has_low_hp_perk[player.characterindex] == true)
       			 {
       			 	player.health = 1;
      			 }
		}
        
	}
	
}

function troll_electric_cherry_perk_trigger()
{
	trig = getEnt("troll_electric_trig","targetname");
	trig SetHintString("Troll Electric Cherry Perk");
	trig SetCursorHint("HINT_NOICON");

	level.has_troll_electric_cherry_perk[0]= false;
	level.has_troll_electric_cherry_perk[1]= false;
	level.has_troll_electric_cherry_perk[2]= false;
	level.has_troll_electric_cherry_perk[3]= false;

	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		IPrintLnBold(player_numb);
		if (level.has_troll_electric_cherry_perk[player_numb]== true)
		{
			changeit = true;
		}
		else
		{
			level.has_troll_electric_cherry_perk[player_numb]= true;
			thread troll_electric_cherry_perk(player);
			player zm_perks::give_perk(PERK_ELECTRIC_CHERRY);
			thread show_perk_hud(player_numb,"ect",1);
		}
		if (changeit == true)
		{
			changeit = false;
			level.has_troll_electric_cherry_perk[player_numb]= false;
			thread show_perk_hud(player_numb,"ect",0);
		}
		wait(1);
		
	}

}
function troll_electric_cherry_perk(player)
{

		player_numb = player.characterindex; 

	while(1)
	{
		player waittill("reload_start");
		if (level.has_troll_electric_cherry_perk[player_numb]== true)
		{
			player SetMoveSpeedScale(0.4);
        	wait(1.2);
        	player SetMoveSpeedScale( 1 );
        }
	}
	
}


function hell_dog_perk_trigger()
{
	level flag::wait_till("initial_blackscreen_passed");
	trig = getEnt("hell_dog_trig","targetname");
	trig SetHintString("Hell Dog Perk");
	trig SetCursorHint("HINT_NOICON");
	

	level.has_hell_dog_perk[0]= false;
	level.has_hell_dog_perk[1]= false;
	level.has_hell_dog_perk[2]= false;
	level.has_hell_dog_perk[3]= false;


	foreach(player in getplayers() )
		{thread hell_dog_perk(player);}
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_hell_dog_perk[player_numb]= true;
		thread show_perk_hud(player_numb,"wt",1);


		wait(1);

		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_hell_dog_perk[player_numb]= false;
		thread show_perk_hud(player_numb,"wt",0);


		wait(1);
		
	}

}
function hell_dog_perk(player)
{

		player_numb = player.characterindex; 

	while(1)
	{
		wait(1);
		
			t = RandomIntRange(50,140); //(min result, max rasult + 1)

			wait(t);
			kills_num = player.kills+1;

			while(1)
			{
				WAIT_SERVER_FRAME;
				if(kills_num<= player.kills)
				{
					break;
				}
			}

		if (level.has_hell_dog_perk[player_numb]== true)
		{

			level.dog_health = 1000;
			   for( i=0;i<4;i++ ) //3 dogs will spawn at once
				{
					level thread zm_ai_dogs::special_dog_spawn( 1, undefined, undefined);
				}
        }
	}
	
}



function disable_sprint_perk_trigger()
{
	trig = getEnt("dis_sprint_trig","targetname");
	trig SetHintString("Disable Sprint Perk");
	trig SetCursorHint("HINT_NOICON");

	level.has_disable_sprint_perk[0]= false;
	level.has_disable_sprint_perk[1]= false;
	level.has_disable_sprint_perk[2]= false;
	level.has_disable_sprint_perk[3]= false;

	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if (level.has_disable_sprint_perk[player.characterindex] == false)
		{
			level.has_disable_sprint_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"szt",1);
	
		}
		else
		{
			level.has_disable_sprint_perk[player.characterindex] = false;
			thread show_perk_hud(player_numb,"szt",0);	
		}
	}

}
function disable_sprint_perk()
{
	while(1)
	{
		wait(1);
		foreach(player in getplayers() )
		{
			if (level.has_disable_sprint_perk[player.characterindex] == true)
       			 {
       			 	player AllowSprint(false);
      			 }
      			 else
      			 {
      			 	player AllowSprint(true);
      			 }
		}
		
        
	}
	
}

function blood_wolf_bite_perk_trigger()
{
	trig = getEnt("bwb_trig","targetname");
	trig SetHintString("Blood wolf bite Perk");
	trig SetCursorHint("HINT_NOICON");

	level.has_blood_wolf_bite_perk[0]= false;
	level.has_blood_wolf_bite_perk[1]= false;
	level.has_blood_wolf_bite_perk[2]= false;
	level.has_blood_wolf_bite_perk[3]= false;
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if (level.has_blood_wolf_bite_perk[player.characterindex] == false)
		{
			level.has_blood_wolf_bite_perk[player_numb]= true;
			player thread blood_wolf_bite::give_custom_perk();
			thread show_perk_hud(player_numb,"w",1);
	
		}
		else
		{
			level.has_blood_wolf_bite_perk[player.characterindex] = false;
			player thread blood_wolf_bite::take_custom_perk();
			thread show_perk_hud(player_numb,"w",0);
	
		}
	}
}

function lost_ammo_perk_trigger()
{
	trig = getEnt("lost_ammo_trig","targetname");
	trig SetHintString("Lost Ammo Perk");
	trig SetCursorHint("HINT_NOICON");

	level.has_lost_ammo_perk[0]= false;
	level.has_lost_ammo_perk[1]= false;
	level.has_lost_ammo_perk[2]= false;
	level.has_lost_ammo_perk[3]= false;
	level flag::wait_till("initial_blackscreen_passed");
	foreach(player in getplayers() )
		{ thread lost_ammo_perk(player); }

	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		if (level.has_lost_ammo_perk[player.characterindex] == false)
		{
			level.has_lost_ammo_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"sct",1);
	
	
		}
		else
		{
			level.has_lost_ammo_perk[player.characterindex] = false;
			thread show_perk_hud(player_numb,"sct",0);
	
		}
	}

}
function lost_ammo_perk(player)
{
	while(1)
	{
		WAIT_SERVER_FRAME;
		ammo = player GetWeaponAmmoClip(player GetCurrentWeapon());
		wait(0.1);
		if (player IsReloading())
		{
			weapon = player GetCurrentWeapon();
			if (level.has_lost_ammo_perk[player.characterindex] == true)
			{
	
				
				while(player IsReloading())
				{
					WAIT_SERVER_FRAME;
					continue;
				}
				stock = player GetWeaponAmmoStock(weapon);
			
				player SetWeaponAmmoStock(weapon,stock-ammo);

			}
		}

        
	}
	
}

//////////////////////////////
//////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////

function show_perk_hud(player_numb,notification,on_off)//on = 1 off = 0
{
	playernumber_hud = player_numb + 1;
	notificacion_hud = notification +  playernumber_hud;
	clientfield::set(notificacion_hud,on_off);

}


///////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

function restaurantes()
{
	thread restaurante("ep","dialogo_playa");
	thread restaurante("su","dialogo_turk");
	thread restaurante("ec","dialogo_irish");
	thread restaurante("jg","dialogo_disco");
	thread restaurante("ww","dialogo_oktober");
	thread restaurante("dt","dialogo_china");
	thread restaurante("w","dialogo_mexico");
	thread restaurante("sz","dialogo_usa");
	thread restaurante("sc","dialogo_italia");
}

function restaurante(perk,dialogo)
{
	trig_1 = getEnt("trig_normal_" + perk,"targetname");
	trig_1 SetHintString("Hold ^3[{+activate}]^7 to select your drink");
	trig_1 SetCursorHint("HINT_NOICON");
	trig_1 SetInvisibleToAll();

	trig_2 = getEnt("trig_troll_" + perk,"targetname");
	trig_2 SetHintString("Hold ^3[{+activate}]^7 to select your drink");
	trig_2 SetCursorHint("HINT_NOICON");
	trig_2 SetInvisibleToAll();

	trig_multiple = getEnt("llegada_" + perk,"targetname");
	bebida_n = getEnt("normal_" + perk,"targetname");
	bebida_t = getEnt("troll_" + perk,"targetname");

	model = getEnt("ted_"+ perk, "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "apagado", model.origin , model.angles, %apagado);

    bebida_n MoveZ(-15,0.1);
    bebida_t MoveZ(-15,0.1);

    
    trig_multiple waittill( "trigger", player );
	level.grow_soul_start_scale = 1;//starting scale of model
	level.grow_soul_growth = 0.01;//growth per zombie
	level.grow_soul_size = 1.5;//how big you want it to get scale wise
	thread cargar_almas("almas_" + perk);

    thread ted_anims(model,dialogo);
    thread radio(perk);
    level waittill("ted_charla_end");
    trig_1 SetVisibleToAll();
    trig_2 SetVisibleToAll();
    if (level.ez_mode == false)
    {
    	i = RandomIntRange(0,2); //(min result, max rasult + 1) randomizar el destino entre 0 y 3
    	if(i==0)
   	  {
   		 	thread wait_all_players_drink(perk,trig_1,trig_2,bebida_n,bebida_t);
  	  }
   		 else
  	  {
   		 	thread wait_all_players_drink(perk,trig_2,trig_1,bebida_n,bebida_t);
  	  }
    }
    else
    {
    	thread wait_all_players_drink(perk,trig_1,trig_2,bebida_n,bebida_t);
    }
    
   

}

function ted_anims(model,dialogo)
{
	level flag::clear( "spawn_zombies" );
	 model StopAnimScripted();
    	model AnimScripted( "se_despierta", model.origin , model.angles, %se_despierta);
    	wait(2);
    	thread hud_text_ted(dialogo);
    	model AnimScripted( "habla", model.origin , model.angles, %habla);
    	PlaySoundAtPosition(dialogo,model.origin);
    	level flag::clear( "spawn_zombies" );
    	wait(3);
    	model AnimScripted( "habla_izq_dch", model.origin , model.angles, %habla_izq_dch);
    	wait(6);
    	level flag::clear( "spawn_zombies" );
    	level notify ("ted_charla_end");
    	level.esperando_eleccion = true;
    	while(1)
    	{
    		model AnimScripted( "mira_abajo", model.origin , model.angles, %mira_abajo);
    		wait(2.5);
    		model AnimScripted( "brinca", model.origin , model.angles, %brinca);
    		wait(2.4);
    	}

}
function wait_all_players_drink(perk,trig_n,trig_t,bebida_n,bebida_t)
{
	bebida_n MoveZ(15,1,0.2,0.5);
    bebida_t MoveZ(15,1,0.2,0.5);
    level.esperando_eleccion = true;
    wait(1);
    thread trig_normal(trig_n);
    thread trig_troll(trig_t);
    wait(0.5);
    while(1)
    {
    	WAIT_SERVER_FRAME;
    	players_en_espera = 0;
    	foreach(player in getplayers() )
		{
			if (level.trig_normal_player[player.characterindex] =="espera")
			{
				players_en_espera ++;
			}
		}
		if (players_en_espera == 0)
		{
			level.esperando_eleccion = false;
			break;
		}
	}
	foreach(player in getplayers() )
		{
			thread give_perk_to_player(player,perk);
		}
		trig_n Delete();
		trig_t Delete();
		level notify ("start_zone_"+perk);

}
function trig_normal(trig)
{
	level.trig_normal_player[0]="";
	level.trig_normal_player[0]="";
	level.trig_normal_player[0]="";
	level.trig_normal_player[0]="";

	foreach(player in getplayers() )
	{
		level.trig_normal_player[player.characterindex]="espera";
	}
	while(level.esperando_eleccion == true)
	{
		trig waittill( "trigger", player );
		level.trig_normal_player[player.characterindex]="normal";
		IPrintLnBold(player.playername + "has selected a drink");
	}

}

function trig_troll(trig)
{
	level.trig_normal_player[0]="";
	level.trig_normal_player[0]="";
	level.trig_normal_player[0]="";
	level.trig_normal_player[0]="";

	foreach(player in getplayers() )
	{
		level.trig_normal_player[player.characterindex]="espera";
	}
	while(level.esperando_eleccion == true)
	{
		trig waittill( "trigger", player );
		level.trig_normal_player[player.characterindex]="troll";
		IPrintLnBold(player.playername + "has selected a drink");
	}

}

function give_perk_to_player(player,perk)
{
	player_numb = player.characterindex; 
	if (perk == "ep")	//EXTRA POINTS PERK
	{
		if(level.trig_normal_player[player.characterindex]=="normal")
		{
			
			level.has_extra_points_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"ep",1);
			level.has_lost_points_perk[player_numb]= false;
			thread show_perk_hud(player_numb,"ept",0);
		}
		if(level.trig_normal_player[player.characterindex]=="troll")
		{
			 
			level.has_lost_points_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"ept",1);
			level.has_extra_points_perk[player_numb]= false;
			thread show_perk_hud(player_numb,"ep",0);
		}
	}
	if (perk == "su")	//stamin Up
	{
		if(level.trig_normal_player[player.characterindex]=="normal")
		{
			
			player zm_perks::give_perk(PERK_STAMINUP);
			thread show_perk_hud(player_numb,"su",1);
		}
		if(level.trig_normal_player[player.characterindex]=="troll")
		{
			
			level.has_sprint_zombies_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"sut",1);
		}
	}
	if (perk == "ec")	//electric cherry
	{
		if(level.trig_normal_player[player.characterindex]=="normal")
		{
			
			player zm_perks::give_perk(PERK_ELECTRIC_CHERRY);
			thread show_perk_hud(player_numb,"ec",1);
			level.has_ec[player_numb]= true; 
		}
		if(level.trig_normal_player[player.characterindex]=="troll")
		{
			
			level.has_troll_electric_cherry_perk[player_numb]= true;
			thread troll_electric_cherry_perk(player);
			player zm_perks::give_perk(PERK_ELECTRIC_CHERRY);
			thread show_perk_hud(player_numb,"ect",1);
			level.has_ec[player_numb]= false; 
		}
	}
	if (perk == "jg")	//jugger
	{
		if(level.trig_normal_player[player.characterindex]=="normal")
		{
			
			player zm_perks::give_perk(PERK_JUGGERNOG);
			thread show_perk_hud(player_numb,"jg",1);
		}
		if(level.trig_normal_player[player.characterindex]=="troll")
		{
			
			level.has_low_hp_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"jgt",1);
		}
	}
	if (perk == "ww")	//widows wine
	{
		if(level.trig_normal_player[player.characterindex]=="normal")
		{
			
			player zm_perks::give_perk(PERK_WIDOWS_WINE);
			thread show_perk_hud(player_numb,"ww",1);
		}
		if(level.trig_normal_player[player.characterindex]=="troll")
		{
			
			level.has_troll_grenade_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"wwt",1);
			thread troll_grenade_perk(player);
		}
	}
	if (perk == "dt")	//double tap
	{
		if(level.trig_normal_player[player.characterindex]=="normal")
		{
			
			player zm_perks::give_perk(PERK_DOUBLETAP2);
			thread show_perk_hud(player_numb,"dt",1);
		}
		if(level.trig_normal_player[player.characterindex]=="troll")
		{ 
			level.has_jumpscare_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"dtt",1);
		}
	}
	if (perk == "w")	//wolf
	{
		if(level.trig_normal_player[player.characterindex]=="normal")
		{
			
			level.has_blood_wolf_bite_perk[player_numb]= true;
			player thread blood_wolf_bite::give_custom_perk();
			thread show_perk_hud(player_numb,"w",1);
		}
		if(level.trig_normal_player[player.characterindex]=="troll")
		{  
			level.has_hell_dog_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"wt",1);
		}
	}
	if (perk == "sz")	//slow zombies
	{
		if(level.trig_normal_player[player.characterindex]=="normal")
		{
			
			level.has_slow_zombies_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"sz",1);
		}
		if(level.trig_normal_player[player.characterindex]=="troll")
		{  
			level.has_disable_sprint_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"szt",1);
		}
	}
	if (perk == "sc")	//speed cola
	{
		if(level.trig_normal_player[player.characterindex]=="normal")
		{
			
			player zm_perks::give_perk(PERK_SLEIGHT_OF_HAND);
			thread show_perk_hud(player_numb,"sc",1);
		}
		if(level.trig_normal_player[player.characterindex]=="troll")
		{  
			level.has_lost_ammo_perk[player_numb]= true;
			thread show_perk_hud(player_numb,"sct",1);
		}
	}
}

////////////////////////////////////////
///////////////////////////////////////
/////////////DOOORS   DOOORS   DOORS////////////////////////////
//////////////////////////////////////////

function doors()
{
	thread door(2,2000,"start_zone_ep");//el numero de puerta es a la zona k abre
	thread door(3,4000,"start_zone_su");//la notificacion es de la zona anterior a esa puerta
	thread door(4,6000,"start_zone_ec");//es para activar el trigger cuando empiezan a salir zmbs en esa zona
	thread door(5,8000,"start_zone_jg");
	thread door(6,10000,"start_zone_ww");
	thread door(7,10000,"start_zone_dt");
	thread door(8,10000,"start_zone_w");
	thread door(9,10000,"start_zone_sz");
	thread door(10,20000,"start_zone_sc");
}
function door(number_door,price,notification_previa)
{
	centro_izq = getEnt("centro_izq","targetname");
	centro_dcha = getEnt("centro_dcha","targetname");
	trig = getEnt("trig_door_" + number_door,"targetname");
	trig SetHintString("Hold ^3[{+activate}]^7 to open door. ^5Cost: "+ price);
	trig SetCursorHint("HINT_NOICON");
	trig SetInvisibleToAll();

	izq = getEnt("izq_" + number_door,"targetname");
	dcha = getEnt("dcha_"+ number_door,"targetname");
	clip = getEnt("clip_"+ number_door,"targetname");

	level waittill(notification_previa);
	//Start zombies spawn
		level flag::set( "spawn_zombies" );
		level.infinite_spawn_on = true; 

	trig SetVisibleToAll();
	while(1)
	{
		trig waittill( "trigger", player );
		
		if (player.score >=price)
		{
			pagador = player;
			jugadoresmuertos = 0;
      		  players = GetPlayers();
        		 foreach(player in players)
        		    {
        		        if(player.sessionstate == "spectator")
       		         {
       		             jugadoresmuertos ++; 
      		          }
      		      } 
     		        foreach(player in GetPlayers()){
     		            if(player laststand::player_is_in_laststand()){
     		                jugadoresmuertos ++;
    		                   }
    		              }
    		      
   		      if (jugadoresmuertos == 0)
   		        {
   		        	
   		             izq EnableLinkTo();
					 izq LinkTo(centro_izq);    
					 dcha EnableLinkTo();
					 dcha LinkTo(centro_dcha);   
					 centro_izq RotatePitch(-90,2);
					 centro_dcha RotatePitch(90,2);
					 pagador.score -= price;
					flag::init("zone_"+number_door+"_flag");
    				flag::set("zone_"+number_door+"_flag");
    				clip Delete();

    				//kill zombies
    				level.infinite_spawn_on = false; 
					zombies = zombie_utility::get_round_enemy_array();
        			if ( isdefined( zombies ) )
        			{
        			    array::run_all( zombies, &Kill );
        			}
    				//Stop Spawning
    				level flag::clear( "spawn_zombies" );

    				wait(2.1);
    				dcha Unlink();
    				izq Unlink();
    				centro_dcha Unlink();
    				centro_izq Unlink();
    				trig Delete();
    				break;


              
    		    }
    		   else
    		   {
    		    IPrintLnBold("All players must be alive");
    		   }
		}

    }

}


function radio(perk)
{
	level flag::wait_till("initial_blackscreen_passed");
	radios = GetEntArray("radios_" + perk,"targetname");
	//thread stopradio(radios,radio_model,song);
		if (perk == "ep"){song="caribe_music";}
		if (perk == "su"){song="turk_music";}
		if (perk == "ec"){song="irish_music";}
		if (perk == "jg"){song="party_music";}
		if (perk == "ww"){song="oktoberfest_music";}
		if (perk == "dt"){song="china_music";}
		if (perk == "w"){song="rancheras_music";}
		if (perk == "sz"){song="rockusa_music";}
		if (perk == "sc"){song="italian_music";}
		if (perk == "spain"){song="spain_music";}

		if (perk == "ep"){wait_time = 1029;}
		if (perk == "su"){wait_time = 438;}
		if (perk == "ec"){wait_time = 584;}
		if (perk == "jg"){wait_time = 1168;}
		if (perk == "ww"){wait_time = 861;}
		if (perk == "dt"){wait_time = 620;}
		if (perk == "w"){wait_time = 1264;}
		if (perk == "sz"){wait_time = 885;}
		if (perk == "sc"){wait_time = 413;}
		if (perk == "spain"){wait_time = 749;}

			while(1)
			{
				 foreach(radio in radios)
				{
					PlaySoundAtPosition(song,radio.origin);
				}
				wait(wait_time);
				WAIT_SERVER_FRAME;
				
			}
 	 

	
        
}


function cargar_almas(system)
{
		grow_soul::SetUpReward(system);  //esto es para activar las almas del pulsador 1
		grow_soul::WatchZombies();
}


function intro_map()
{

	//kill zombies
    level.infinite_spawn_on = false; 
	zombies = zombie_utility::get_round_enemy_array();
     if ( isdefined( zombies ) )
       {
           array::run_all( zombies, &Kill );
      	}
   	//Stop Spawning
   	level flag::clear( "spawn_zombies" );

	trig_tele = getEnt("trig_tele","targetname");
	trig_tele SetHintString("Hold ^3[{+activate}]^7 to start game ");
	trig_tele SetCursorHint("HINT_NOICON");

	trig_tele SetInvisibleToAll();

	teleport_model = getEnt("teleport_model","targetname");
	teleport_model MoveZ(-60,0.2);

	trig = getEnt("activate_start_ted","targetname");

	model = getEnt("ted_start", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "apagado", model.origin , model.angles, %apagado);

    radio = getEnt("radio_intro","targetname");
    level flag::wait_till("initial_blackscreen_passed");
    PlaySoundAtPosition("troll_music",radio.origin);

     trig waittill( "trigger", player );
     thread intro_anims(model);
     wait(29);

    teleport_model MoveZ(60,1);
    wait(1);
    trig_tele SetVisibleToAll();
    flag::init("zone_1_flag");
    flag::set("zone_1_flag");


    trig_tele waittill( "trigger", player );
    brush_inicio = getEnt("brush_inicio","targetname");
    brush_inicio Delete();
    teleport_model Delete();
    model Delete();

        players = GetPlayers();
        for( i = 0; i < players.size; i++ ) //set up a for loop for player size
        {
        players[i] thread teleport_players(i);
        }
        trig_tele Delete();
        radio Delete();
        gallina = getEnt("gallina", "targetname");
        gallina Delete();
        calabera = getEnt("calabera", "targetname");
        calabera Delete();

	
}
function teleport_players(i)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get( "s_teleport_" + i, "targetname" ); 
	//4 structs in radiant with targetnames "s_teleport_0" "s_teleport_1" "s_teleport_2" "s_teleport_3"   

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}

function intro_anims(model)
{
	 model StopAnimScripted();
    	model AnimScripted( "se_despierta", model.origin , model.angles, %se_despierta);
    	thread CreateIntroText("^1IF YOU CANT HEAR TED-> Set voice volumen chanel to 100", 300,320,1.5,8,2);
    	wait(2);
    	thread CreateIntroText("^6 T.E.D.D: ^7Welcome to the new custom zombie experience", 300,75,2,3,1);
    	model AnimScripted( "habla", model.origin , model.angles, %habla);
    	PlaySoundAtPosition("intro1",model.origin);
    	wait(3);
    	model AnimScripted( "habla_izq_dch", model.origin , model.angles, %habla_izq_dch);
    	thread CreateIntroText("^6 T.E.D.D: ^7My name is TED,", 300,75,2,6,1);
    	thread CreateIntroText("and i'm here to explain you the basics you need to know", 300,55,2,6,1);
    	thread CreateIntroText("to play this map created by DonAndres", 300,35,2,6,1);
    	wait(6);
    	model AnimScripted( "mira_abajo", model.origin , model.angles, %mira_abajo);
    		wait(2.5);
    	thread CreateIntroText("^6 T.E.D.D: ^7On this map you will find different food stalls ", 300,75,2,3,1);
    	model AnimScripted( "habla", model.origin , model.angles, %habla);
    	PlaySoundAtPosition("intro2",model.origin);
    	wait(3);
    	thread CreateIntroText("^6 T.E.D.D: ^7There they will give you a choice between two drinks", 300,75,2,3,1);
    	model AnimScripted( "habla", model.origin , model.angles, %habla);
    	PlaySoundAtPosition("intro3",model.origin);
    	wait(3);
    	thread CreateIntroText("^6 T.E.D.D: ^7Be very careful with your decision,", 300,75,2,6,1);
    	thread CreateIntroText("one of the drinks will give you a positive effect,", 300,55,2,6,1);
    	thread CreateIntroText("however, the other will give you a troll effect", 300,35,2,6,1);
    	model AnimScripted( "habla_izq_dch", model.origin , model.angles, %habla_izq_dch);
    	PlaySoundAtPosition("intro4",model.origin);
    	wait(6);
    	thread CreateIntroText("^6 T.E.D.D: ^7Check the inventory to see your perks( Press TAB )", 300,75,2,3,1);
    	model AnimScripted( "habla", model.origin , model.angles, %habla);
    	wait(0.2);
    	PlaySoundAtPosition("intro6",model.origin);
    	wait(2.8);
    	model AnimScripted( "mira_abajo", model.origin , model.angles, %mira_abajo);
    		wait(2.5);
    	thread CreateIntroText("^6 T.E.D.D: ^7One last warning before we start,", 300,75,2,6,1);
    	thread CreateIntroText("we are not responsible for copyright (not this music),", 300,55,2,6,1);
    	thread CreateIntroText("so if you are streaming set the music volume to zero", 300,35,2,6,1);
    	model AnimScripted( "habla_izq_dch", model.origin , model.angles, %habla_izq_dch);
    	PlaySoundAtPosition("intro5",model.origin);
    	wait(6);
    	while(1)
    	{
    		model AnimScripted( "mira_abajo", model.origin , model.angles, %mira_abajo);
    		wait(2.5);
    		model AnimScripted( "brinca", model.origin , model.angles, %brinca);
    		wait(2.4);
    	}
}





function dont_press_button()
{
	trig = getEnt("troll_button","targetname");
	trig SetHintString("Hold ^3[{+activate}]^7 to press the button ");
	trig SetCursorHint("HINT_NOICON");
	trig waittill( "trigger", player );
	IPrintLnBold("Oh NO! This button activated the 64 zombies mode");
	level.zombie_actor_limit = 62;
    level.zombie_ai_limit = 62;
}

function player_down()
{
		while(1)
		{
			foreach(player in GetPlayers())
			{
                 if(player laststand::player_is_in_laststand())
                 {
                     pn = player.characterindex;
                     thread show_perk_hud(pn,"ep",0);
                     level.has_extra_points_perk[pn] = false;
                     thread show_perk_hud(pn,"su",0);
                     thread show_perk_hud(pn,"ec",0);
                     thread show_perk_hud(pn,"ect",0);
                     level.has_troll_electric_cherry_perk[pn] = false;
                     level.has_ec[pn]= false; 
                     thread show_perk_hud(pn,"jg",0);
                     thread show_perk_hud(pn,"ww",0);
                     thread show_perk_hud(pn,"dt",0);
                     thread show_perk_hud(pn,"w",0);
                     player thread blood_wolf_bite::take_custom_perk();
                     level.has_blood_wolf_bite_perk[pn] = false;
                     thread show_perk_hud(pn,"sz",0);
                     level.has_slow_zombies_perk[pn] = false;
                     thread show_perk_hud(pn,"szt",0);
                     level.has_disable_sprint_perk[pn] = false;
                     thread show_perk_hud(pn,"sc",0);


                     
                 }
            }
            wait(0.5);
        }
}

function show_quick_revive()
{
	while(1)
	{
		wait(1);
		foreach(player in GetPlayers())
			{
				pn = player.characterindex;
				if(player HasPerk("specialty_quickrevive"))
				{
					thread show_perk_hud(pn,"qr",1);
				}
				else
				{
					thread show_perk_hud(pn,"qr",0);
				}
			}
	}
}

function CreateIntroText(text, align_x, align_y, font_scale, time, fade_time)
{
    hud = NewHudElem();
    hud.foreground = true;
    hud.fontScale = font_scale;
    hud.sort = 1;
    hud.hidewheninmenu = false;
    hud.alignX = "left";
    hud.alignY = "bottom";
    hud.horzAlign = "left";
    hud.vertAlign = "bottom";
    hud.x = align_x;
    hud.y = hud.y - align_y;
    hud.alpha = 1;
    hud SetText(text);
    wait(time - fade_time);
    hud fadeOverTime(fade_time);
    hud.alpha = 0;
    wait(fade_time);
    hud Destroy();
}

function hud_text_ted(dialogo)
{
	if (dialogo == "dialogo_playa")
	{
		txt1 = "Hola! welcome to 'El Chiringuito'";
		txt2 = "Who wants a drink?";
		txt3 = "we have a lot of variety, but be careful with the quantities,";
		txt4 = "balconing is not allowed";
	}
	if (dialogo == "dialogo_turk")
	{
		txt1 = "Welcome my friend, welcome to my restaurant";
		txt2 = "Do you want kebab?";
		txt3 = "If you prefer I can also offer you something to drink,";
		txt4 = "what do you prefer?";
	}
	if (dialogo == "dialogo_irish")
	{
		txt1 = "Hiya,welcome to this irish pub";
		txt2 = "We have music, beer, beer, and more beer,";
		txt3 = "so, do you want a pint?";
		txt4 = "";
	}
	if (dialogo == "dialogo_disco")
	{
		txt1 = "hey hey hey! Look who's here";
		txt2 = "Turn up the music!";
		txt3 = "we have company and they come to give it their all.";
		txt4 = "What do you want to drink?";
	}
	if (dialogo == "dialogo_oktober")
	{
		txt1 = "Ein prosit, welcome to the oktoberfest";
		txt2 = "You can order something to eat, ";
		txt3 = "but I'm sure you came for the beer,";
		txt4 = "so let's toast together";
	}
	if (dialogo == "dialogo_china")
	{
		txt1 = "Ni hao, welcome to my restaurant";
		txt2 = "What do you want to drink?";
		txt3 = "we have a lot of variety, do you want something to drink?";
		txt4 = "Choose wisely";
	}
	if (dialogo == "dialogo_mexico")
	{
		txt1 = "Arriba mexico cabrones! Sean bienvenidos";
		txt2 = "do you want a burrito or a taco?";
		txt3 = "I'd better put you some tequila.";
		txt4 = "Andale cabron, suban esas rancheritas!";
	}
	if (dialogo == "dialogo_usa")
	{
		txt1 = "Hello how are you?, welcome";
		txt2 = "We have very healthy food like hamburgers, fries, milkshakes.";
		txt3 = "what's up? I'm talking about mental health.";
		txt4 = "";
	}
	if (dialogo == "dialogo_italia")
	{
		txt1 = "Ciao amico, benvenuto nel mio ristorante";
		txt2 = "Ohhh mamma mia,";
		txt3 = "Do you want pizza, spaghetti, cannelloni? ";
		txt4 = "Can I offer you something to drink?";
	}
		if (dialogo == "dialogo_spain")
	{
		txt1 = "Bravo!, you have completed the map";
		txt2 = "We have a gift for you,";
		txt3 = "you can use it to kill zombies";
		txt4 = "if you do it right you will surely hear some Ole!";
	}

	thread CreateIntroText("^6 T.E.D.D: ^7" + txt1, 300,75,2,3,1);
	wait(3);
	thread CreateIntroText("^6 T.E.D.D: ^7"+txt2, 300,75,2,6,1);
    thread CreateIntroText(txt3, 300,55,2,6,1);
    thread CreateIntroText(txt4, 300,35,2,6,1);
    wait(6);


}

function spain()
{
	trig_tele = getEnt("iniesta","targetname");
	trig_tele SetHintString("El Gol de Iniesta ");
	trig_tele SetCursorHint("HINT_NOICON");

	trig_tele = getEnt("nadal","targetname");
	trig_tele SetHintString("Rafael Nadal ");
	trig_tele SetCursorHint("HINT_NOICON");

	trig_tele = getEnt("sevilla","targetname");
	trig_tele SetHintString("Plaza de Espana, Sevilla");
	trig_tele SetCursorHint("HINT_NOICON");

	trig_tele = getEnt("zaragoza","targetname");
	trig_tele SetHintString("Basilica del Pilar, Zaragoza");
	trig_tele SetCursorHint("HINT_NOICON");

	trig_tele = getEnt("barcelona","targetname");
	trig_tele SetHintString("Barcelona");
	trig_tele SetCursorHint("HINT_NOICON");

	trig_tele = getEnt("segovia","targetname");
	trig_tele SetHintString("Acueducto de Segovia, Segovia");
	trig_tele SetCursorHint("HINT_NOICON");

	trig_tele = getEnt("navarra","targetname");
	trig_tele SetHintString("San Fermines, Pamplona");
	trig_tele SetCursorHint("HINT_NOICON");

	trig_tele = getEnt("valencia","targetname");
	trig_tele SetHintString("Ciudad de las artes y las ciencias, Valencia");
	trig_tele SetCursorHint("HINT_NOICON");

	trig_tele = getEnt("picos","targetname");
	trig_tele SetHintString("Picos de Europa, Asturias Leon y Cantabria");
	trig_tele SetCursorHint("HINT_NOICON");

	trig_tele = getEnt("menorca","targetname");
	trig_tele SetHintString("Isla de Menorca");
	trig_tele SetCursorHint("HINT_NOICON");


	trig_multiple = getEnt("llegada_spain","targetname");
	trig_guitar = getEnt("trig_guitar","targetname");
	trig_guitar SetHintString("Hold ^3[{+activate}]^7 to get GUITARRITA");
	trig_guitar SetCursorHint("HINT_NOICON");
	trig_guitar SetInvisibleToAll();	
	guitarra = getEnt("guitarra", "targetname");
	guitarra MoveZ(-30,1);
	model = getEnt("ted_spain", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "apagado", model.origin , model.angles, %apagado);
    
    trig_multiple waittill( "trigger", player );

    thread ted_anims(model,"dialogo_spain");
    thread radio("spain");
    level waittill("ted_charla_end");

    guitarra MoveZ(30,1);
    wait(1);
    trig_guitar SetVisibleToAll();

     while(1)
		{
			trig_guitar waittill("trigger", player);
			level notify ("end_open");
		
			player TakeWeapon(player GetCurrentWeapon());
			player zm_weapons::weapon_give(getweapon("bo3_melee_bat"));
		}


}


/////////////////////////////////////////
/////////////END END END /////////////
////////////////////////////////////////
function end_map()
{
	trig = getEnt("end_trig", "targetname");	
	model1 = getEnt("end_model1", "targetname");	
	model2 = getEnt("end_model2", "targetname");	
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString("Come back Later");

	trig SetInvisibleToAll();
	model1 SetInvisibleToAll();
	model2 SetInvisibleToAll();

	level waittill ("end_open");
	IPrintLnBold("Now you can find the end of the map!");
	//Start zombies spawn
		level flag::set( "spawn_zombies" );
		level.infinite_spawn_on = true; 

	trig SetVisibleToAll();
	model1 SetVisibleToAll();
	model2 SetVisibleToAll();
	trig SetHintString("Press and Hold ^3&&1^7 to end the game. (Total players points: 40k pts)"); 

	while(1)
		{
			trig waittill("trigger", player);
			puntos_tot = 0;
			foreach(player in getplayers() )
        	{
        		puntos_tot += player.score;
        	}
			if (puntos_tot > 40000)
			{
				
				level.custom_game_over_hud_elem = &function_f7b7d070;
				wait(0.5);
				level notify("end_game");
			}
		}


}


function function_f7b7d070(player, game_over, survived)
{
    game_over.alignX = "center";
	game_over.alignY = "middle";
	game_over.horzAlign = "center";
	game_over.vertAlign = "middle";
	game_over.y -= 130;
	game_over.foreground = true;
	game_over.fontScale = 3;
	game_over.alpha = 0;
	game_over.color = ( 1.0, 1.0, 1.0 );
	game_over.hidewheninmenu = true;
	game_over SetText("Thx for playing. Support my maps on workshop to keep me motivated. DonAndres_666 ");

	game_over FadeOverTime( 1 );
	game_over.alpha = 1;
	if ( player isSplitScreen() )
	{
		game_over.fontScale = 2;
		game_over.y += 40;
	}
}

function custom_weapons()
{
    level flag::wait_till("initial_blackscreen_passed");
    wait(10);
	foreach(player in getplayers() )
	{
		thread extra_points_weapon(player);
	}
	
}

function extra_points_weapon(player)
{
	a = player.kills+1;
	ballistic = GetWeapon("t9_ballistic_knife");
	ballistic_up = GetWeapon("t9_ballistic_knife_up");
	guitarra = GetWeapon("bo3_melee_bat");
	while(1)
	{
		
		kills = player.kills;
		if (kills >= a)
		{
			weapon = player GetCurrentWeapon();
			if (weapon == ballistic)
			{
				player zm_score::add_to_player_score(400);
			}
			if (weapon == ballistic_up)
			{
				player zm_score::add_to_player_score(600);
			}
			if (weapon == guitarra)
			{
				player zm_score::add_to_player_score(300);
			}
			a= player.kills + 1;
		}
		wait(0.1);

	}
}


function ez_mode()
{
	level.ez_mode = false;
	trig = getEnt("ez_mode", "targetname");			
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString("Press and Hold ^3&&1^7 to activate EZ mode. Every EZ game has troll perks on the same site");
	trig waittill("trigger", player);
	IPrintLnBold("Easy mode activated");
	level.ez_mode = true;

}

function troll_mode()
{
	trig = getEnt("troll_mode", "targetname");			
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString("Press and Hold ^3&&1^7 to activate Troll mode. You start with all troll perks activated");
	trig waittill("trigger", player);
	IPrintLnBold("Troll mode activated");
	foreach(player in getplayers() )
	{
		level.trig_normal_player[player.characterindex]="troll";
		wait(0.2);
		thread give_perk_to_player(player,"ep");
		thread give_perk_to_player(player,"su");
		thread give_perk_to_player(player,"ec");
		thread give_perk_to_player(player,"jg");
		thread give_perk_to_player(player,"ww");
		thread give_perk_to_player(player,"dt");
		thread give_perk_to_player(player,"w");
		thread give_perk_to_player(player,"sz");
		thread give_perk_to_player(player,"sc");
	}
	
}