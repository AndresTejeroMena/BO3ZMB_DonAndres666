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

//Perks
#using scripts\zm\_zm_perks;
#insert scripts\zm\_zm_perks.gsh;
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

//Traps
#using scripts\zm\_zm_trap_electric;
//cosas
#using scripts\zm\custom_wallbuy;
//TELEPORT
#using scripts\shared\lui_shared;
//CREAR PUERTAS TODOS JUGADORES
#using scripts\zm\_zm_score;

//jump pads
#using scripts\_redspace\rs_o_jump_pad;

//Modo de tiempo
#using scripts\zm\ugxmods_timedgp;

//karosel
#using scripts\zm\weapon_karosel;

//futbol
#using scripts\zm\growing_soulbox;

//PARASITOS
#using scripts\zm\_zm_ai_wasp;
// NSZ Brutus
#using scripts\_NSZ\nsz_brutus;
// MECHZ ZOMBIE
//#using scripts\zm\_zm_ai_mechz;

#using scripts\zm\zm_usermap;

#precache( "fx", "explosions/fx_exp_generic_aerial_lg" );
#precache( "fx", "impacts/fx_bul_impact_armor_body_fatal" );
//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{
	//PARASITOS
	level.dog_rounds_allowed = false;
	zm_ai_wasp::init();
	// NSZ Brutus
	brutus::init(); 

	zm_usermap::main();
	
	level._zombie_custom_add_weapons =&custom_add_weapons;
	
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	level.pathdist_type = PATHDIST_ORIGINAL;

	//INITIAL THINGS
	//level.start_weapon = getWeapon("ar_damage_upgraded");
	level.dog_rounds_allowed = false; // BE AWARE - disables dog rounds
	level.perk_purchase_limit = 20;
	level.player_starting_points = 1000;
	level util::set_lighting_state(2);
	thread perkmachine("trig_electriccherry","PERK_ELECTRIC_CHERRY",2000,"Electric Cherry","specialty_electriccherry");
	thread perkmachine("trig_qr1","PERK_QUICK_REVIVE",1500,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr2","PERK_QUICK_REVIVE",1500,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr3","PERK_QUICK_REVIVE",1500,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr4","PERK_QUICK_REVIVE",1500,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr5","PERK_QUICK_REVIVE",1500,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr6","PERK_QUICK_REVIVE",1500,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr7","PERK_QUICK_REVIVE",1500,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr8","PERK_QUICK_REVIVE",1500,"Quick Revive","specialty_quickrevive");
	thread credit();
	
	    //CUSTOM PACK A PUNCH CAMO
    level.pack_a_punch_camo_index = 134; 
    level.pack_a_punch_camo_index_number_variants = 3;

	thread zonamedia();
	thread startzone_lights();
	
	//8 DOORS MODE
	thread gameplay_8doors();
	thread guia_challenge();
	thread ez_mode();

	thread tetris_init();
	thread go_to_bonus_room();

	//karosel
	weap_kar::init(  );

	

}

function usermap_test_zone_init()
{
	zm_zonemgr::add_adjacent_zone("start_zone","zonamedia","zonamediaflag");
	zm_zonemgr::add_adjacent_zone("zonamedia","zone_futbol1","futbolflag");

	zm_zonemgr::add_adjacent_zone("zone_futbol1","zone_futbol3");
	zm_zonemgr::add_adjacent_zone("zone_futbol5","zone_futbol3");
	zm_zonemgr::add_adjacent_zone("zone_futbol5","zone_futbol7");
	zm_zonemgr::add_adjacent_zone("zone_futbol12","zone_futbol4");
	zm_zonemgr::add_adjacent_zone("zone_futbol4","zone_futbol6");
	zm_zonemgr::add_adjacent_zone("zone_futbol6","zone_futbol8");
	zm_zonemgr::add_adjacent_zone("zone_futbol1","zone_futbol2");
	zm_zonemgr::add_adjacent_zone("zone_futbol3","zone_futbol4");
	zm_zonemgr::add_adjacent_zone("zone_futbol5","zone_futbol6");
	zm_zonemgr::add_adjacent_zone("zone_futbol7","zone_futbol8");
	zm_zonemgr::add_adjacent_zone("zone_futbol1","zone_futbol4");
	zm_zonemgr::add_adjacent_zone("zone_futbol1","zone_futbol4");
	zm_zonemgr::add_adjacent_zone("zone_futbol5","zone_futbol4");
	zm_zonemgr::add_adjacent_zone("zone_futbol2","zone_futbol3");
	zm_zonemgr::add_adjacent_zone("zone_futbol6","zone_futbol3");

	zm_zonemgr::add_adjacent_zone("zonamedia","zone_tetris4","tetrisflag");
	zm_zonemgr::add_adjacent_zone("zone_tetris4","zone_tetris3");
	zm_zonemgr::add_adjacent_zone("zone_tetris2","zone_tetris3");
	zm_zonemgr::add_adjacent_zone("zone_tetris2","zone_tetris1");

	zm_zonemgr::add_adjacent_zone("zonamedia","zone_spaceinvaders","spaceinvadersflag");

	zm_zonemgr::add_adjacent_zone("zonamedia","zone_ms1","msflag");
	zm_zonemgr::add_adjacent_zone("zone_ms2","zone_ms1","ms_cascosflag");
	zm_zonemgr::add_adjacent_zone("zone_ms2","zone_ms3");
	zm_zonemgr::add_adjacent_zone("zone_ms3","zone_ms4","ms_rampaflag");
	zm_zonemgr::add_adjacent_zone("zone_ms4","zone_ms5");

	zm_zonemgr::add_adjacent_zone("zonamedia","zone_frogger","froggerflag");

	zm_zonemgr::add_adjacent_zone("zonamedia","zone_dk_out","dkflag");
	zm_zonemgr::add_adjacent_zone("zone_dk_1","zone_dk_out");
	zm_zonemgr::add_adjacent_zone("zone_dk_2","zone_dk_out");
	zm_zonemgr::add_adjacent_zone("zone_dk_3","zone_dk_out");
	zm_zonemgr::add_adjacent_zone("zone_dk_4","zone_dk_out"); //asi solo salen en los pisos de arriba

	zm_zonemgr::add_adjacent_zone("zonamedia","zone_1943","1943flag");

	zm_zonemgr::add_adjacent_zone("zonamedia","zone_pacman","pacmanflag");

	level flag::init( "always_on" );
	level flag::set( "always_on" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

function zonamedia()
{
    trigg = getEnt("trigger_zonamedia", "targetname");
    trigg waittill("trigger", action); 
    action IPrintLnBold("zonamedia activada");
         flag::init( "zonamediaflag" );
            flag::set("zonamediaflag");
//////////////////////////////////////////////////////////////////
          //  flag::init( "pacmanflag" ); //////PARA TESTEAAAAAAR!!!!!
          //  flag::set("pacmanflag");
///////////////////////////////////////////////////////////////
 }

 function credit()
{
	level flag::wait_till("initial_blackscreen_passed");
	iprintlnbold("This map was created by DonAndres_666, Enjoy!"); 
	  wait(3);
	iprintlnbold("You can adjust the volume of music on the options menu, sound, music volume. No Copyright Music.");
	wait(2);
	iprintlnbold("Use ez mode to learn each challenge and then try to compleat the whole map. You have guides before each challenge on a retro machine. And tips on the workshop description."); 
}

function startzone_lights()
{
    trigg = getEnt("start_zone_trigger_multiple", "targetname");
   while(1)
   {
    trigg waittill("trigger",player);
    level util::set_lighting_state(2);
    wait(10);
   }
} 
function playsoundok(sound)
{
	level.playSoundLocation PlaySound(sound);
	players = GetPlayers();
		for (i = 0;i<players.size;i++)

		{
		players[i] PlayLocalSound(sound);}
}

function banda_sonora(song,end_song,entity)
{
	sound_location	= getEnt(entity, "targetname");

	sound_location PlayLoopSound(song);
		level waittill(end_song);
	sound_location StopLoopSound();
	
	
}
function perkmachine(trigger,perk,cost,perkname,specialtyperk)
{
	trig = getEnt(trigger, "targetname");
	
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{	
        trig SetHintString( "Press and Hold ^3&&1^7 to get " + perkname + " Cost:" + cost); 
        
        foreach(player in getplayers() )
        {
            if(player HasPerk(specialtyperk))
                trig SetHintStringForPlayer(player,"");
        }
        trig waittill("trigger", player);
        if(player.score < cost || player HasPerk(specialtyperk))
        {
            PlaySoundAtPosition("cc_hack_fail", trig.origin);
            wait 0.1;
            continue;
        }

        player zm_score::minus_to_player_score(cost);
        thread zm_perks::vending_trigger_post_think(player, specialtyperk);
    

	}
	/*
	specialty_quickrevive
	specialty_doubletap2
	specialty_armorvest
	specialty_fastreload
	specialty_deadshot
	specialty_phdflopper
	specialty_staminup
	specialty_additionalprimaryweapon
	specialty_tombstone
	specialty_whoswho
	specialty_electriccherry
	specialty_vultureaid
	specialty_widowswine
	*/
}
function rotateobject(model)
{
	while(1)
	{
		model RotateYaw(360,0.7);
		wait(1.2);
	}
}

function cdoor(door,clip,trigger,cost,despl)
{
	
	while(1)
	{
		trigger SetHintString( "Press and Hold ^3&&1^7 to Start the challenge" ); 
		trigger SetCursorHint("HINT_NOICON");
		trigger waittill( "trigger", player ); 
		if( trigger doorAllPlayersPresent() )
				{
					player zm_score::minus_to_player_score( cost );
					trigger SetHintString(""); 
					door MoveZ(despl, 1, 0.3, 0.3);
					clip MoveZ(despl, 1, 0.3, 0.3);	
					trigger Delete();
				}
				else
				{
					trigger SetHintString( "All Players Must Be Nearby" ); 
					wait(1); 
				}
			
		
	}
}
function doorAllPlayersPresent()
{
	players = getplayers(); 
	foreach( player in players )
	{
		if( Distance(self.origin, player.origin) >= 200 )
			return false; 
	}
	return true;
}

function guia_challenge()
{
	for (i = 1;i<9;i++)
		{
			trig[i] = getEnt("trig_guia_" + i , "targetname");
			model[i] = getEnt("model_guia_" + i , "targetname");
			thread cartelito_guia(trig[i],model[i]);
		}
}
function cartelito_guia(trig,model)
{
	trig SetHintString( "Press and Hold ^3&&1^7 to Show you the guide" ); 
	trig SetCursorHint("HINT_NOICON");
	trig waittill( "trigger", player );
	trig Delete();
	model Delete();
}

function teleport_players_frogger(i)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("frog_teleport_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}
function teleport_players_dk(i)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("dk_teleport_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}
function teleport_players_to_bonus(i)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("bonus_teleport_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
 }   

function teleport_players_1943(i)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("1943_teleport_central_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
 }   
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 ///////////////////FUTBOL FUTBOL FUTBOL///////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function futbol()
{	ball = getEnt("grow_soul", "targetname");
	ball_clip = getEnt("ball_clip", "targetname");
	trig_ball = getEnt("trig_ball", "targetname");	
	trig_ball EnableLinkTo();
	trig_ball LinkTo(ball);
	ball_clip EnableLinkTo();
	ball_clip LinkTo(ball);
	level.passcompleted = 0;
	thread futbolplayers(ball);
	thread remateactivo(ball);
	thread limites_del_campo(ball);
	thread soccer_complete();
	while(1)
	{
		level waittill (level.kick_the_ball == 1);
		trig_ball waittill( "damage", damage, player, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel ); 
		 if(mod != "MOD_GRENADE_SPLASH")  
		 {
			if (mod != "MOD_PROJECTILE_SPLASH")
			{				
				thread ballkick(player,ball);
				level.nombredelgoleador = player.playername;
	
				wait(5);
				grow_soul::SetUpReward("grow_soul");  //esto es para activar de nuevo las almas
				grow_soul::WatchZombies();
			}
		}			
	}
}
function ballkick(player,ball)
{
	player_location = player.origin;
	ball_location = ball.origin;
	vector = ball_location - player_location;
	modulo = Sqrt((vector[0]*vector[0])+(vector[1]*vector[1]));
	
	moveball = 600; //distance that ball moves
	vectorf = (vector[0] * moveball / modulo,vector[1] * moveball / modulo,0);	
	final_ball_position = ball_location + vectorf;

	ball MoveTo(final_ball_position,1.5,0.1,0.9);
	ball PlaySound("chutarid");
	
}

function limites_del_campo(ball)
{
	banderin_superior = getEnt("banderin_superior", "targetname");
	banderin_inferior = getEnt("banderin_inferior", "targetname");
	limite_inferior = banderin_inferior.origin;
	limite_superior = banderin_superior.origin;
	while (0.2)
	{
		ball_location = ball.origin;
		if (( ball_location[0] >= limite_superior[0]) && (level.defense_paused == true))
		{
			ball MoveTo((limite_superior[0]+10,ball_location[1],ball_location[2]),0.3,0.1,0.1);
			wait(0.2);
		}
		if ( ball_location[1] >= limite_superior[1])
		{
			ball MoveTo((ball_location[0],limite_superior[1]-5,ball_location[2]),0.3,0.1,0.1);
			wait(0.2);
		}
		if ( ball_location[0] <= limite_inferior[0])
		{
			ball MoveTo((limite_inferior[0]+5,ball_location[1],ball_location[2]),0.3,0.1,0.1);
			wait(0.2);
		}
		if ( ball_location[1] <= limite_inferior[1]) 
		{
			ball MoveTo((ball_location[0],limite_inferior[1]+5,ball_location[2]),0.3,0.1,0.1);
			wait(0.2);
		}
	
		wait(0.1);
	}
}
function futbolplayers(ball)
{	level.passcompleted = 0;
	ball_origen = ball.origin;
	level.defense_paused = 0;
	if (level.isEZmode == true)
	{
		IPrintLnBold("GUIDE: pass the ball to your teammates (blue shirt) before beating the defender (the zombie with a hat)");
	}
	thread goalkeeper("portero",ball);
	thread passtheball("teamate1",ball);
	thread passtheball("teamate2",ball);
	thread passtheball("teamate3",ball);
	thread defender("defender1",ball_origen,ball,3);
	level waittill("3 teammate");
	if (level.isEZmode == true)
	{
		IPrintLnBold("GUIDE: pass the ball to your teammates (blue shirt) before beating the defender (the zombie with a hat)");
	}
	ball_origen = ball.origin;
	thread passtheball("teamate4",ball);
	thread passtheball("teamate5",ball);
	thread passtheball("teamate6",ball);
	thread passtheball("teamate7",ball);
	thread defender("defender2",ball_origen,ball,7);
	level waittill("7 teammate");
	if (level.isEZmode == true)
	{
		IPrintLnBold("GUIDE: pass the ball to your teammates (blue shirt) before beating the defender (the zombie with a hat)");
	}
	ball_origen = ball.origin;
	thread passtheball("teamate8",ball);
	thread passtheball("teamate9",ball);
	thread defender("defender3",ball_origen,ball,9);
	level waittill("9 teammate");
	if (level.isEZmode == true)
	{
		IPrintLnBold("GUIDE: pass the ball to your teammate (blue shirt) and finish the ball when he passes it to you.");
	}
	ball_origen = ball.origin;
	thread banda("teamate10",ball);
	thread banda("teamate11",ball);
	thread defender("defender4",ball_origen,ball,15);
	thread goal(ball);
}

function  passtheball(teamate,ball)
{

	teamate_model = getEnt(teamate, "targetname");
	teamate_location = teamate_model.origin;
	while(0.3)
	{
		ball_location = ball.origin;
		if (Distance(teamate_location,ball_location) <= 50)
		{
			pass_location = (teamate_location[0],teamate_location[1],ball_location[2]);
			ball MoveTo(pass_location,0.5,0.2,0.2);
			level.passcompleted ++;  
			wait(2);
			teamate_model Delete();
			if (level.passcompleted == 3)
			{
				level notify ("3 teammate");
				thread playsoundok("pase2id");
			}
			if (level.passcompleted == 7)
			{
				level notify ("7 teammate");
				thread playsoundok("pase2id");
			}
			if (level.passcompleted == 9)
			{
				level notify ("9 teammate");
				thread playsoundok("pase2id");
			}
			if ( (level.passcompleted != 3) && (level.passcompleted != 7) && (level.passcompleted != 9))
			{
				thread playsoundok("pase1id");
			}
			break;
		}
		wait(0.1);
	}
}

function defender(defensor,origen_ball,ball,passtokill)
{

	defender_model = getEnt(defensor, "targetname");
	defender_location = defender_model.origin;
	while(1)
	{
		ball_location = ball.origin;
		if((defender_location[0] - ball_location[0] < 0) && (level.defense_paused == 0))
		{	
			wait(1.5);					//esperamos a que la bola se pare
			ball_location = ball.origin; 
			defender_model MoveTo((ball_location[0]+15,ball_location[1],ball_location[2]),1,0.2,0.2);
			wait(1);
			defender_model RotateTo((30,180,0),0.8,0.3,0.1);
			wait(1);
			defender_model RotateTo((-10,180,0),0.3,0.1,0.1);
			wait(0.2);
			ball MoveTo(origen_ball,1.5,0.3,0.3);
			wait(0.2);
			defender_model MoveTo(defender_location,2,0.2,0.2);
			defender_model RotateTo((0,180,0),0.8,0.3,0.1);
			IPrintLnBold("The defender has taken the ball from you, try passing the ball to the players in front of him.");
			wait(2);
		}
		if (level.passcompleted == passtokill)
		{
			defender_model Delete();
			break;
		}
		wait(0.1);
	}
}

function banda(teamate,ball)
{
	level.centred = 0;
	teamate_model = getEnt(teamate, "targetname");
	teamate_location = teamate_model.origin;
	while(0.3)
	{
		ball_location = ball.origin;
		if (Distance(teamate_location,ball_location) <= 50)
		{
		pass_location = (teamate_location[0],teamate_location[1],ball_location[2]);
			ball MoveTo(pass_location,0.5,0.2,0.2);
			level.defense_paused = true;
			IPrintLnBold("Watch the pass! kick the ball when it's moving");
			wait(0.5);
			teamate_model MoveX(540,2,0.6,0.3);
			ball MoveX(540,2,0.6,0.3);
			
			wait(2);
			level.centred = true;
			if (teamate == "teamate10")
			{
			ball MoveTo((5454,1913,1196),3,0.2,1);
			}
			if (teamate == "teamate11")
			{
				ball MoveTo((5454,1047,1196),3,0.2,1);
			}
			wait(2);
			teamate_model MoveTo(teamate_location,2,1,1);
			wait(1);
			level.centred = false;
			wait(1);
			level.defense_paused = false;
			

		}
		wait(0.1);
	}		
}
function remateactivo(ball)
{
	trig_ball = getEnt("trig_ball", "targetname");	
	level.remateactivado = false;
	thread remate(ball);
	while(0.25)
	{
		trig_ball waittill("trigger", player); 
		level.nombredelgoleador = player.playername;
		level.remateactivado = true;
		level.rematador = player;
		//IPrintLnBold("remate");
		wait(0.2);
		level.remateactivado = false;
	}	
	
}
function remate(ball)
{
	
	while(0.15)
	{
		if((level.remateactivado == true) && (level.centred == true))
		{
			thread ballkick(level.rematador,ball);
			//IPrintLnBold("rematador");
		}
		wait(0.1);
	}
}

function goalkeeper(portero, ball)
{
	portero_model = getEnt(portero, "targetname");
	thread paradon(portero_model,ball);
	while(1)
	{
		portero_model MoveY(130,1,0.1,0.1);
		wait(1);
		portero_model MoveY(-130,1,0.1,0.1);
		wait(1);
	}

}
function paradon(portero_model,ball)
{
	while(0.1)
	{
		level.nogoal = false;
		portero_location = portero_model.origin;
		ball_location = ball.origin;
		palo1 = getEnt("palo1", "targetname");
		palo2 = getEnt("palo2", "targetname");
		fuera1 = getEnt("fuera1", "targetname");
		fuera2 = getEnt("fuera2", "targetname");
		if ((ball_location[0] <= 5820) && (ball_location[0] >= 5760) && ( level.defense_paused == true))
		{
			if((ball_location[1] <= portero_location[1] + 30) && (ball_location[1] >= portero_location[1] - 30))
			{
				ball MoveTo((5575,1498,ball_location[2]),0.5,0.1,0.3);
				level.centred = false;
				//IPrintLnBold("paradon");
				ball PlaySound("chutarid");
				level.nogoal = true;
				wait(0.5);
				level.nogoal = false;
			}
			
		}
		if ((ball IsTouching (palo1)) && (level.nogoal == false))//palos
			{
				ball MoveTo((5575,1498,ball_location[2]),0.5,0.1,0.3);
				level.centred = false;
				//IPrintLnBold("palo");
				ball PlaySound("paloid");
				level.nogoal = true;
				wait(2);
				level.nogoal = false;
			}
		if ((ball IsTouching (palo2)) && (level.nogoal == false)) //palos
			{
				ball MoveTo((5575,1498,ball_location[2]),0.5,0.1,0.3);
				level.centred = false;
				//IPrintLnBold("palo");
				ball PlaySound("paloid");
				level.nogoal = true;
				wait(2);
				level.nogoal = false;
			}
		if ((ball IsTouching (fuera1)) && (level.nogoal == false)) //palos
			{
				ball MoveTo(ball_location,0.5,0.1,0.3);
				level.centred = false;
				//IPrintLnBold("fuera");
				level.nogoal = true;
				wait(2);
				level.nogoal = false;
			}
		if ((ball IsTouching (fuera2)) && (level.nogoal == false)) //palos
			{
				ball MoveTo(ball_location,0.5,0.1,0.3);
				level.centred = false;
				//IPrintLnBold("fuera");
				level.nogoal = true;
				wait(2);
				level.nogoal = false;
			}


		wait(0.1);
	}
}


function goal(ball)
{
	goal = getEnt("goal", "targetname");
	while(0.1)
	{
		if (ball IsTouching (goal))
		{
			if (level.nogoal == false)
			{
					//level.effect["gol_explosion"] = "explosions/fx_exp_rocket_concrete_sm";
					level.effect["gol_explosion"] = "explosions/fx_exp_generic_aerial_lg";
				PlayFX(level.effect["gol_explosion"],ball.origin);
				
				PlaySoundAtPosition("golid",ball.origin);
				IPrintLnBold(level.nombredelgoleador, " SCORED!!");
				level.passcompleted = 15; //para borrar al ultimo defensa
				level notify ("soccer_complete");
				level.number_of_challenges_completed ++;
				wait(0.1);
				ball Delete();

				wait(2);
			}
		}
		wait(0.1);
	}
}
function soccer_complete()
{	
	model = getEnt("teleport_soccer_complete", "targetname");
	trig = getEnt("trigger_soccer_complete", "targetname");
	model MoveZ(-1000,0.2);
	trig SetInvisibleToAll();
	level waittill ("soccer_complete");
	model MoveZ(1000,0.2);
	trig SetVisibleToAll();
	thread trig_teleport_to_start_zone(trig);
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////TETRIS   TETRIS   TETRIS ///////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function tetris_init()
{
	 for( i = 1; i < 54; i++ ) //set up a for loop for all the movil tetris parts
        {
        pieza = getEnt(i, "targetname");
        pieza MoveX(7000,0.5,0.2,0.2);
        
      
        }
 }
function tetris()
{	
	level.tetrisfin = false;
	thread tetris_dead();
	thread tetris_complete();
	iprintlnbold("You can adjust the volume of music on the options menu, sound, music volume. No Copyright Music.");

//waittill("tetris_empieza");

		level.playSoundLocation PlaySound("tetrisid"); // Change "sephiroth" to the name of your soundalias.
		thread tetris_luces();
		players = GetPlayers();
		for (i = 0;i<players.size;i++)

		{
		players[i] PlayLocalSound( "tetrisid");}

		
	
      for( i = 1; i < 54; i++ ) //set up a for loop for all the movil tetris parts
        {
        pieza = getEnt(i, "targetname");
        wait(3.2);
        
        pieza MoveX(-7000,8,0.2,0.2);
    	}
    	level.tetrisfin = true;

}
function tetris_luces()
{
	wait(66);
	level util::set_lighting_state(1);
	wait(27.5); 
	for( i = 1; i < 66; i++ ) //set up a for loop for all the tetris parts
        {
        pieza[i] = getEnt(i, "targetname");
        pieza[i] SetInvisibleToAll();
        pieza_location[i] = pieza[i].origin;
    	}
    	players = GetPlayers();
    while(0.5)
    {
    	for (j = 0;j<players.size;j++)

		{
		player_location[j] = players[j].origin;
		}
			for( i = 1; i < 66; i++ ) //set up a for loop for all the tetris parts
       		 {
       		 	pieza_location[i] = pieza[i].origin;
       		 	if ((Distance(pieza_location[i],player_location[0]) <= 250) || (Distance(pieza_location[i],player_location[1]) <= 250) || (Distance(pieza_location[i],player_location[2]) <= 250) || (Distance(pieza_location[i],player_location[3]) <= 250))
       		 	{
       		 		pieza[i] SetVisibleToAll();
       		 	}
       		 	else
       		 	{
       		 		pieza[i] SetInvisibleToAll();
       		 	}
       		 }
		
	
		if (level.tetrisfin == true)
		{
			break;
		}	
		wait(0.2);
    }
    
    for( i = 1; i < 66; i++ ) //set up a for loop for all the tetris parts
        {
        	pieza[i] SetVisibleToAll();
        }

}

function tetris_dead()
{
	    
		trig = getEnt("tetris_dead", "targetname");

	  	while(1)
	  	{
	 
	  		 trig waittill("trigger", player);
	  		 	wait(1.5);
	  		 	
	  		 	player thread tetris_teleport_dead();
	  	      
       	}
}
function tetris_teleport_dead()
{
				respawn = struct::get("tetris_respawn", "targetname");
	            self setorigin( respawn.origin );
        		self setplayerangles( respawn.angles );
        		self FreezeControls(true);
       			 wait(1);
       			 self FreezeControls( false );
       			
}

function tetris_complete()
{
	trig = getEnt("trigger_tetris_complete", "targetname");
	level.number_of_challenges_completed ++;
	thread trig_teleport_to_start_zone(trig);
	trig waittill("trigger", player);
	level notify ("tetris_complete");

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// SPACE INVADERS    SPACE INVADERS ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function spaceinvaders()
{
	level util::set_lighting_state(1);
	level.number_of_invaders_dead = 0;
	level.si_state = "attacking";
	if (level.isEZmode == true)
	{
		IPrintLnBold("TIP: you can go behind the stairs to have more space");
	}
	thread movimiento_si();
	thread kill_si();
	thread pantalla_si();
	level waittill("shield_on");
	level.si_state = "reactors";
	thread shield_on();
	if (level.isEZmode == true)
	{
		IPrintLnBold("GUIDE: the bellboys are at the end of the corridor going up the stairs");
	}
	level waittill("shield_of");
	if (level.isEZmode == true)
	{
		IPrintLnBold("TIP: you can go behind the stairs to have more space");
	}
	level.si_state = "attacking";
	level waittill("ez_invaders_dead");
	if (level.isEZmode == true)
	{
		IPrintLnBold("TIP: lern the boss movement pattern");
	}
	thread hard_invader_movement();
	level waittill("si_boss_dead");
	level.si_state = "si_gg";
	level.number_of_challenges_completed ++;		
}

function movimiento_si()
{
	
	while(1)
	{
	for( i = 1; i <4; i++ ) //set up a for loop for all space invaders
        {
        	
			thread mover_naves(200,0);
			wait(1.3);
		}
		
		thread mover_naves(0,-130);
		wait(1.3);

	for( i = 1; i <6; i++ ) //set up a for loop for all space invaders
        {
			thread mover_naves(-200,0);
			wait(1.3);
		}
		
		thread mover_naves(0,-130);
		wait(1.3);

	for( i = 1; i <7; i++ ) //set up a for loop for all space invaders
        {
			thread mover_naves(200,0);
			wait(1.3);
		}

		thread mover_naves(0,-130);
		wait(1.3);

	for( i = 1; i <7; i++ ) //set up a for loop for all space invaders
        {
			thread mover_naves(-200,0);
			wait(1.3);
		}

		thread mover_naves(0,-130);
		wait(1.3);

		for( i = 1; i <7; i++ ) //set up a for loop for all space invaders
        {
			thread mover_naves(200,0);
			wait(1.3);
		}

		thread mover_naves(0,-130);
		wait(1.3);

	for( i = 1; i <5; i++ ) //set up a for loop for all space invaders
        {
			thread mover_naves(-200,0);
			wait(1.3);
		}

		thread mover_naves(0,650);
		wait(1.3);
	}
}

function mover_naves(mov_lateral,mov_vertical)
{
	for( j = 1; j < 33; j++ ) //set up a for loop for all space invaders
        {
        si_model[j] = getEnt("sm_" + j, "targetname");
        si_trigger[j] = getEnt("st_" + j, "targetname");
        si_trigger[j] EnableLinkTo();
		si_trigger[j] LinkTo(si_model[j]);

		if (mov_lateral != 0)
		{si_model[j] MoveY(mov_lateral,0.3,0.1,0.1);}

		if (mov_vertical != 0)
		{si_model[j] MoveZ(mov_vertical,0.3,0.1,0.1);}
		
		}
}
function kill_si()
{
	for( j = 1; j < 33; j++ ) //set up a for loop for all space invaders
        {
        si_model[j] = getEnt("sm_" + j, "targetname");
        //si_trigger[j] = getEnt("st_" + j, "targetname");
        
		si_model[j] thread kill_one_si();
		}

}

function kill_one_si()
{
	while(1)
    {	
    	self SetCanDamage(1);
        self waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
        
       
        if(weapon == GetWeapon("launcher_standard") && (mod == "MOD_PROJECTILE") ) // Weapon you want the player to have when shot
        {
        	wait(0.2);
           self Delete();
          thread playsoundok("si_hitid");
           // trigg Delete();
            level.number_of_invaders_dead ++;

            if (level.number_of_invaders_dead == 32)
			{
				level notify ("ez_invaders_dead");	//avisar que se han matado a los 32 invaders
			}
			 if (level.number_of_invaders_dead == 16)
			{
				level notify ("shield_on");	//avisar que se ha activado el escudo
			}

            break;
        }
    }
}

function shield_on()
{	
	level.botonpulsado = 0;
	thread boton1();
	thread boton2();
	IPrintLnBold("Our Reactors Have been attacked!! Shield Protection Activated, Repair reactors to keep fighting!");
	shield = getEnt("shield", "targetname"); 
	shield MoveZ(1400,4,0.1,1.5);
	shieldbm = getEnt("shieldbm", "targetname"); 
	shieldbm MoveZ(1400,4,0.1,1.5);
	thread playsoundok("alarmaid");
	while(1)
	{
		wait(1);
		if (level.botonpulsado >= 2) 
		{
			shield MoveZ(-1400,4,0.1,0.1);
			shieldbm MoveZ(-1400,4,0.1,0.1);
			IPrintLnBold("Reactors have been fixed. Shield desactivated");
			level notify("shield_of");
			break;
		}
	}

}
function boton1()
{
	boton1 = getEnt("si_boton1", "targetname"); 
	boton1 SetHintString("^2Hold [{+activate}] To Activate Right Reactor");
	boton1 SetCursorHint("HINT_NOICON");
	boton1 waittill ("trigger", player);
	boton1 Delete();
	level.botonpulsado ++;
}
function boton2()
{
	boton2 = getEnt("si_boton2", "targetname"); 
	boton2 SetHintString("^2Hold [{+activate}] To Activate Left Reactor");
	boton2 SetCursorHint("HINT_NOICON");
	boton2 waittill ("trigger", player);
	boton2 Delete();
	level.botonpulsado ++;
}
function hard_invader_movement()
{
	boss = getEnt("si_boss", "targetname");
	boss thread hard_invader_life();
	pos_1 = (745,-5519,1200);
	pos_2 = (745,-6091,1200);
	pos_3 = (745,-6767,1200);
	pos_4 = (745,-5519,1502.25);
	pos_5 = (745,-6091,1502.25);
	pos_6 = (745,-6767,1502.25);
	pos_7 = (745,-5519,1814.75);
	pos_8 = (745,-6091,1814.75);
	pos_9 = (745,-6767,1814.75);
	self endon( "si_boss_dead" ); 
	while(1)
	{
		boss MoveTo(pos_5,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
		boss MoveTo(pos_7,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
		boss MoveTo(pos_9,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
		boss MoveTo(pos_3,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
		boss MoveTo(pos_5,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
		boss MoveTo(pos_1,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
		boss MoveTo(pos_4,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
		boss MoveTo(pos_1,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
		boss MoveTo(pos_6,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
		boss MoveTo(pos_2,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
		boss MoveTo(pos_8,0.3,0.1,0.1);
		thread playsoundok("si_movimientoid");
		wait(1);
	}
}
function hard_invader_life()
{
	level.number_of_si_hits = 0;
	while(1)
	{
		self SetCanDamage(1);
        self waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );

        if(weapon == GetWeapon("launcher_standard") && (mod == "MOD_PROJECTILE") ) // Weapon you want the player to have when shot
        {
        	level.number_of_si_hits ++;
        	thread playsoundok("si_hitid");
        }

        if (level.number_of_si_hits >= 3 )
        {
        	self Delete();
        	level notify ("si_boss_dead");
        	break;
        	
		}
    }
}
function pantalla_si()
{	
	trig = getEnt("trigger_si_complete", "targetname");
	fondosi = getEnt("fondo1", "targetname");
	fondoattack = getEnt("fondo2", "targetname");
	fondoreactores = getEnt("fondo3", "targetname");
	fondogg = getEnt("fondo4", "targetname");

	while(1)
	{
		fondoattack SetInvisibleToAll();
		fondoreactores SetInvisibleToAll();
		fondogg SetInvisibleToAll();
		fondosi SetVisibleToAll();
		wait(2);
		if(level.si_state == "attacking")
		{
			fondosi SetInvisibleToAll();
			fondoattack SetVisibleToAll();
			wait(2);
		}
		if(level.si_state == "reactors")
		{
			fondosi SetInvisibleToAll();
			fondoreactores SetVisibleToAll();
			wait(2);
		}
		if(level.si_state == "si_gg")
		{
			fondosi SetInvisibleToAll();
			fondogg SetVisibleToAll();
			
			thread trig_teleport_to_start_zone(trig);
			level notify ("si_complete");


			wait(2);
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////// METAL SLUG     METAL SLUG //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function metalslug()
{
	thread soldiers();
	thread rampa_ms();
	thread puerta1_ms();
	thread puerta2_ms();
	thread minigunbuild();
	thread vtol();
	thread ms_fall();
	thread prisioners();
	thread ms_completed();
	wait(2);
	thread playsoundok("ms_mision1id");
}

function soldiers()
{
	level.number_of_soldiers_dead = 0;
	thread soldado_caido("soldier1","tri_soldier_1");
	thread soldado_caido("soldier2","tri_soldier_2");
	thread soldado_caido("soldier3","tri_soldier_3");
	thread soldado_caido("soldier4","tri_soldier_4");
	thread soldado_caido("soldier5","tri_soldier_5");
	for( j = 1; j < 6; j++ ) 
        {
       		thread casco(j);
       	}
       	thread valla_soldados();
    while(1)
    {
    	wait(0.5);
    	if (level.number_of_soldiers_dead == 5)
    	{	
    		wait(1);
    		level notify ("5 soldados muertos");
    		break;
    	}
    }
}
function soldado_caido(nombre_soldado,nombre_trigger)
{
	soldado = getEnt(nombre_soldado, "targetname");
	trigger_damage = getEnt(nombre_trigger, "targetname");
	trigger_damage waittill( "damage", damage, player, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
			thread playsoundok("hitmarkerid");
			soldado Delete();
			trigger_damage Delete();
			level.number_of_soldiers_dead ++;
			thread playsoundok("ms_soldierid");

}
function casco(i)
{
	 casco_model = getEnt("casco_" + i, "targetname");
	 casco_model SetInvisibleToAll();
	 while(1)
	 {
	 	wait(0.5);
	 	if (level.number_of_soldiers_dead == i)
	 		{
	 			casco_model SetVisibleToAll();
	 			break;
	 		}
	 }
	 level waittill("5 soldados muertos");
	 casco_model MoveZ(-200, 3,0.5,0.5);
}
function valla_soldados()
{
	for( j = 1; j < 10; j++ ) 
        {
			valla[j] = getEnt("ms_valla_" + j, "targetname");
		}
	valla[9]  SetHintString("Maybe with all the helmets...");
	valla[9] SetCursorHint("HINT_NOICON");
	level waittill("5 soldados muertos");
			flag::init( "ms_cascosflag" );
            flag::set("ms_cascosflag");
	for( j = 1; j < 10; j++ ) 
        {
			valla[j] MoveZ(-200, 3,0.5,0.5);
		}
		valla[9] Delete();
}

function rampa_ms()
{
	rampa = getEnt("msrampa_model", "targetname");
	rampa_bm = getEnt("rampa_brm", "targetname");
	pilar = getEnt("pilar", "targetname");
	pilar_bm = getEnt("pilar_bm", "targetname");
	rampa_bm SetInvisibleToAll();
	trigger_columna = getEnt("columna", "targetname");
	for( j = 0; j < 33; j++ ) //set up a for loop for all space invaders
        { 
			trigger_columna waittill("trigger", player);
			thread playsoundok("hitmarkerid");
		}

	
	
    pilar Delete();
    pilar_bm Delete();
    rampa MoveTo( (7417.68,5002.51,1708.89),0.8,0.4,0.1) ;  
    rampa RotateTo((38.05,285.6,-64.25),0.8,0.4,0.1) ;  
    rampa_bm SetVisibleToAll();	
    flag::init( "ms_rampaflag" );
    flag::set("ms_rampaflag");
 
}

function puerta1_ms()
{
	model = getEnt("ms_puerta1", "targetname");
	bm = getEnt("ms_bmpuerta1", "targetname");
	trigger_damage= getEnt("tr_puerta1", "targetname");
	trigger_damage waittill("trigger", player);
	model Delete();
	bm Delete();
}
function puerta2_ms()
{
	model = getEnt("ms_puerta3", "targetname");
	bm = getEnt("ms_bmpuerta3", "targetname");
	trigger_damage= getEnt("tr_puerta3", "targetname");
	trigger_damage waittill("trigger", player);
	model Delete();
	bm Delete();
}
function ms_fall()
{
	trig = getEnt("ms_fall", "targetname");
	while(1)
	  	{
	 
	  		 trig waittill("trigger", player);
	  		 	wait(1.5);
	  		 	
	  		 	player thread ms_teleport_dead();
	  	      
       	}
}
function ms_teleport_dead()
{
				respawn = struct::get("ms_respawn", "targetname");
	            self setorigin( respawn.origin );
        		self setplayerangles( respawn.angles );
        		self FreezeControls(true);
       			 wait(1);
       			 self FreezeControls( false );
       			
}

function vtol()
{
	vtol = getEnt("vtol", "targetname");
	vtol_actionate = getEnt("vtolactionate", "targetname");
	vtol_actionate waittill("trigger", player);
	thread vtol_sound(vtol);
	vtol MoveZ (265,2,0.1,1);
	wait(2);
	vtol MoveX(-425,2,0.1,1);
	thread vtol_dispara(vtol);
	vtol thread vtol_life();
	thread playsoundok("ms_finalmisionid");
	
}
function vtol_dispara(model)
{
	level.effect["vtol_shot"] = "impacts/fx_bul_impact_armor_body_fatal";
	level.effect["gol_explosion"] = "explosions/fx_exp_generic_aerial_lg";
	thread vtol_damage();
	self endon( "vtol_dead" );
		while(0.1)
		{	
			
			PlayFX(level.effect["vtol_shot"],(9973,5282,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5262,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5222,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5202,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5182,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5152,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5122,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5082,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5052,2169));
			wait(0.2);
			
			PlayFX(level.effect["vtol_shot"],(9973,5052,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5082,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5122,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5152,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5182,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5222,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5252,2169));
			wait(0.2);
			PlayFX(level.effect["vtol_shot"],(9973,5282,2169));
			wait(0.2);
		}
}
function vtol_damage() //to players
{
	level waittill ( "vtol_dead");
	vtol_hurt = getEnt("vtol_hurt", "targetname");
	vtol_hurt Delete();
}
function vtol_sound(vtol)
{
	vtol PlayLoopSound("helicopterid");
	wait(2);
	PlaySoundAtPosition("minigun_start_2sid",vtol.origin);
	wait(2);
	vtol PlayLoopSound("minigun_loopid");
	level waittill("vtol_dead");

		vtol StopLoopSound("minigun_loopid");
		PlayFX(level.effect["gol_explosion"],vtol.origin);
		thread playsoundok("explosionid");
		vtol MoveTo((10524,5194,2085),0.6,0.1,0.1);
		vtol RotateTo((340,180,0),0.3,0.1,0.1);
		wait(0.6);

		vtol_door = getEnt("vtol_door", "targetname");
		PlayFX(level.effect["gol_explosion"],vtol_door.origin);
		thread playsoundok("explosionid");
		vtol_door Delete();
		vtol StopLoopSound("helicopterid");

		wait(0.2);
		PlayFX(level.effect["gol_explosion"],vtol.origin);
		thread playsoundok("explosionid");
		vtol Delete();
		wait(1);
		IPrintLnBold("Safe bunker opened!");


		
		
}
function vtol_life()
{
	damage_acumulated = 0;
	while(1)
	{	

		self SetCanDamage(1);
        self waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
        if (weapon == GetWeapon("minigun") )
        {
        	damage_acumulated = (damage_acumulated + damage);
        	thread playsoundok("hitmarkerid");

       		if (damage_acumulated == 100000)
       		{	
       			level notify ("vtol_dead");
       			break;
       		}
       	}	 

    }
}

function minigunbuild()
{
	level.minigunparts = 0;
	thread minigun_part("minigun_box_1","minigun_part_1","minigun_trig_1","damage_box_1");
	thread minigun_part("minigun_box_2","minigun_part_2","minigun_trig_2","damage_box_2");
	thread minigun_part("minigun_box_3","minigun_part_3","minigun_trig_3","damage_box_3");
	thread minigun_table();

}

function minigun_part(box_name,part_name,trig_name,damage_trig)
{
	mini_part = getEnt(part_name, "targetname");
	box = getEnt(box_name, "targetname");
	trigger_damage = getEnt(damage_trig, "targetname");
	trigger = getEnt(trig_name, "targetname");
	trigger_damage SetCursorHint("HINT_NOICON");
	trigger SetCursorHint("HINT_NOICON");
	
	mini_part SetInvisibleToAll();
	trigger_damage waittill("trigger", player);

	box Delete();
	mini_part SetVisibleToAll();

	
	trigger SetHintString("^2Hold [{+activate}] To pick minigun part");
	
	trigger waittill("trigger", player);

	level.minigunparts ++;
	mini_part Delete();
	trigger delete();

}
function minigun_table()
{
	model = getEnt("minigun_model", "targetname");
	trig = getEnt("make_minigun", "targetname");
	trig SetHintString("You need 3 minigun parts to build it");
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	while(1)
	{
		wait(1);
		if (level.minigunparts == 3)
		{
			trig SetHintString("^2Hold [{+activate}] To build Minigun");
			trig waittill("trigger", player);
			model SetVisibleToAll();
			minigun_spawn = struct::get( "minigun_spawn", "targetname" );
			while(1)
			{
				trig SetHintString("^2Hold [{+activate}] Get Minigun");
				trig waittill("trigger", player);
				minigun_spawn thread zm_powerups::specific_powerup_drop("minigun", minigun_spawn.origin);
				trig SetHintString("Recharging...");
				wait(25);
			}
		}
	}

}

function prisioners()
{
		level.number_of_prisioners_safe = 0;
	 for( i = 1; i < 7; i++ ) //set up a for loop for all the prisioners (6)
	 {
	 	thread safe_a_prisioner(i);
	 }
	 while(1)
	 {
	 	wait(0.5);
	 	if (level.number_of_prisioners_safe == 6)
	 	{break;}
	 }
	 level notify ("ms_complete");
}
function safe_a_prisioner(i)
{
	prisioner = getEnt("ms_prisioner_" + i, "targetname");
	libre = getEnt("ms_libre_" + i, "targetname");
	texto = getEnt("ms_texto_" + i, "targetname");
	trigger_damage = getEnt("trig_prisioner_" + i, "targetname");
	texto SetHintString("Cut the rope to set me free!");
	texto SetCursorHint("HINT_NOICON");
	trigger_damage SetCursorHint("HINT_NOICON");
	libre SetInvisibleToAll();

	while(1)
	{
		 trigger_damage waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		if (mod == "MOD_MELEE")
		{
			prisioner Delete();
			trigger_damage Delete();
			thread playsoundok("ms_thankyouid");
			level.number_of_prisioners_safe ++;
			IPrintLnBold(level.number_of_prisioners_safe, "/6 Prisioners Rescued");
			libre SetVisibleToAll();
			texto Delete();
			break;
		}
	}
}
function ms_completed()
{
	trigger = getEnt("ms_end", "targetname");
	trigger SetHintString("You need to save all the prisioners to complete the mission!");
	trigger SetCursorHint("HINT_NOICON");
	level waittill ("ms_complete");
	level.number_of_challenges_completed ++;
	thread trig_teleport_to_start_zone(trigger);

}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////  FROGGER  FROGGER  FROGGER ///////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function frogger()
{
	thread movimiento_frogger();
	thread frogger_ptsextra();
	thread frogger_complete();
	if (level.isEZmode == true)
	{
		IPrintLnBold("GUIDE: You must get the frog at the start of the highway");
	}
}
function recorrido(distancia,time)
{
	self MoveY(distancia,time,0.1,0.1); //distancia 2250
	wait(time);
	self SetInvisibleToAll();
	wait(0.1);
	self MoveY(-distancia,0.3,0.1,0.1);
	wait(0.4);
	self SetVisibleToAll();
}
function recorrido_coches(distancia,time)	//se hace distinto por un bug
{
	self MoveY(distancia,time,0.1,0.1); //distancia 2250
	wait(time);
	self MoveZ(-300,0.5,0.2,0.2);
	wait(0.6);
	self MoveY(-distancia,0.5,0.1,0.1);
	wait(0.6);
	self MoveZ(300,0.5,0.2,0.2);
}

function movimiento_frogger()
{
	thread car_a();
	thread car_b();
	thread car_c();
	thread car_d();
	thread water_e();
	thread water_f();
	thread water_g();
	thread water_h();
	thread water_i();
	thread fall_in_water();
	thread frogger_player_down();
	thread setup_frogger();
	
}
		function car_a()
		{
			for( i = 1; i < 7; i++ ) 
				 {car_a[i] = getEnt("fa" + i, "targetname");
				 trigger[i] = getEnt("tfa" + i, "targetname");
					thread atropello(trigger[i]);
				}
			while(1)
			{
				for( i = 1; i < 7; i++ )
				{
					trigger[i] EnableLinkTo();
					trigger[i] LinkTo(car_a[i]);
					car_a[i] thread recorrido_coches(2250,10);
					//trigger[i] thread recorrido(2250,10);
					wait(3);
				}
			}
		}
		function car_b()
		{
			for( i = 1; i < 5; i++ ) 
				 {car_b[i] = getEnt("fb" + i, "targetname");
				 trigger[i] = getEnt("tfb" + i, "targetname");
					thread atropello(trigger[i]);
				}
			while(1)
			{
				for( i = 1; i < 5; i++ )
				{				
					trigger[i] EnableLinkTo();
					trigger[i] LinkTo(car_b[i]);
					car_b[i] thread recorrido_coches(2250,6);
					//trigger[i] thread recorrido(2250,10);
					wait(4);
				}
			}
		}
		function car_c()
		{
			for( i = 1; i < 6; i++ ) 
				 {car_c[i] = getEnt("fc" + i, "targetname");
				 trigger[i] = getEnt("tfc" + i, "targetname");
					thread atropello(trigger[i]);
				}
					
			while(1)
			{
				for( i = 1; i < 6; i++ )
				{
					trigger[i] EnableLinkTo();
					trigger[i] LinkTo(car_c[i]);
					car_c[i] thread recorrido_coches(-2250,8);
					//trigger[i] thread recorrido(-2250,10);
					wait(2.4);
				}
			}
		}
		function car_d()
		{
			for( i = 1; i < 5; i++ ) 
				 {car_d[i] = getEnt("fd" + i, "targetname");
				 trigger[i] = getEnt("tfd" + i, "targetname");
					thread atropello(trigger[i]);
					}
			while(1)
			{
				for( i = 1; i < 5; i++ )
				{
					trigger[i] EnableLinkTo();
					trigger[i] LinkTo(car_d[i]);
					car_d[i] thread recorrido_coches(2250,10);
					//trigger[i] thread recorrido(2250,10);
					wait(4);
				}
			}
		}
		function water_e()
		{
			for( i = 1; i < 5; i++ ) 
				 {model_e[i] = getEnt("fe" + i, "targetname");
					bmodel_e[i] = getEnt("b_fe" + i, "targetname");
				
				}

			while(1)
			{
				for( i = 1; i < 5; i++ )
				{
					model_e[i] thread recorrido(2250,8);
					bmodel_e[i] thread recorrido(2250,8);
					wait(4);
				}
			}
		}
		function water_f()
		{
			for( i = 1; i < 4; i++ ) 
				 {model_f[i] = getEnt("ff" + i, "targetname");
				 bmodel_f[i] = getEnt("b_ff" + i, "targetname");
				 
				}
			while(1)
			{
				for( i = 1; i < 4; i++ )
				{
					model_f[i] thread recorrido(-2250,10);
					bmodel_f[i] thread recorrido(-2250,10);
					wait(4);
				}
			}
		}
		function water_g()
		{
			for( i = 1; i < 4; i++ ) 
				 {model_g[i] = getEnt("fg" + i, "targetname");
				 bmodel_g[i] = getEnt("b_fg" + i, "targetname");
				 
				}
			while(1)
			{
				for( i = 1; i < 4; i++ )
				{
					model_g[i] thread recorrido(2250,6);				
					bmodel_g[i] thread recorrido(2250,6);
					wait(4);
				}
			}
		}
		function water_h()
		{
			for( i = 1; i < 4; i++ ) 
				 {model_h[i] = getEnt("fh" + i, "targetname");
				 bmodel_h[i] = getEnt("b_fh" + i, "targetname");
				 
				}
			while(1)
			{
				for( i = 1; i < 4; i++ )
				{
					model_h[i] thread recorrido(-2250,12);
					bmodel_h[i] thread recorrido(-2250,12);
					wait(5);
				}
			}
		}
		function water_i()
		{
			for( i = 1; i < 4; i++ ) 
				 {model_i[i] = getEnt("fi" + i, "targetname");
				 bmodel_i[i] = getEnt("b_fi" + i, "targetname");
				 
				}
			while(1)
			{
				for( i = 1; i < 4; i++ )
				{
					model_i[i] thread recorrido(2250,10);
					bmodel_i[i] thread recorrido(2250,10);
					wait(4);
				}
			}
		}

function fall_in_water()
{
	frogger_water = getEnt("frogger_water", "targetname");
	while(1)
	{	
		frogger_water waittill( "trigger", player );
		
			 IPrintLnBold(player.playername," fell into the water.");
			 level notify("frogger_fail");
			 thread playsoundok("frogger_deadid");
			 wait(3);
			
		
	}
}
function atropello(trigger)
{
	
	while(0.1)
	{
		trigger waittill( "trigger", player );
					IPrintLnBold(player.playername," has been run over.");
					level notify("frogger_fail");
					thread playsoundok("frogger_deadid");
					wait(3);
			
		
	}
}
function frogger_player_down()
{
		while(1)
		{
			foreach(player in GetPlayers())
			{
                 if(player laststand::player_is_in_laststand())
                 {
                     if ((level.player_with_the_frog == player) && (level.rana_en_pilar == 0))
                     {
						IPrintLnBold(player.playername," lost the frog.");
						level.rana_en_pilar = 1;
                     }
                     
                 }
            }
            wait(0.5);
        }
}
function setup_frogger()
{
	level.rana_en_pilar = 1;
	level.number_of_frogs = 0;
	thread frogger_contador_vidas();
	thread frogger_impactos_permitidos();
	thread frogger_teleporter();
	frog = getEnt("frog", "targetname");
	trigger_frog = getEnt("trigger_frog", "targetname");
	for( i = 1; i < 6; i++ )
				{
					trigger_frog_give[i] = getEnt("trig_frog_" + i, "targetname");
					frog_cartel[i] = getEnt("frog_" + i, "targetname");
					thread entregar_rana(frog_cartel[i],trigger_frog_give[i]);
				}
	
	thread coger_frog(frog,trigger_frog);

}

function coger_frog(model,trig)
{
	while(1)
	{
		if (level.rana_en_pilar == 1)
		{	
			model SetVisibleToAll();
			trig SetHintString("Hold [{+activate}] To take the Frog");
			trig SetCursorHint("HINT_NOICON");
			trig waittill( "trigger", player );
			level.player_with_the_frog = player;
			level.player_with_the_frog_name = player.name;
			IPrintLnBold(level.player_with_the_frog_name, " has the frog");
			thread playsoundok("frogger_startid");
			model SetInvisibleToAll();
			level.rana_en_pilar = 0;
		}
		if (level.rana_en_pilar == 0)
		{
			trig SetHintString(level.player_with_the_frog_name," has the frog");
		}
		wait(0.5);
	}
}
function entregar_rana(cartel,trig)
{
	while(1)
	{
			cartel SetInvisibleToAll();
			trig SetHintString("Hold [{+activate}] To Place the Frog");
			trig SetCursorHint("HINT_NOICON");
			trig waittill( "trigger", player );
				if ((level.player_with_the_frog == player) && (level.rana_en_pilar == 0))
				{
					cartel SetVisibleToAll();
					trig SetInvisibleToAll();
					level.rana_en_pilar = 1;
					level.number_of_frogs ++;
					thread playsoundok("frogger_goodid");
					level waittill ("frogger_reseted");			//cuando se resetea el nivel
					level.number_of_frogs = 0;
					level.rana_en_pilar = 1;
					trig SetVisibleToAll();
				}
				else
				{
					IPrintLnBold(player.name, " doesn't have the frog");
				}

	}
}
function frogger_teleporter()
{
	
	while(1)
	{
		level waittill("frogger_fail");
		level.rana_en_pilar = 1;
		players = GetPlayers();
        for( i = 0; i < players.size; i++ ) //set up a for loop for player size
        {
        	if(players[i] laststand::player_is_in_laststand() == false)
            {
        		players[i] thread teleport_players_frogger(i);
        	}
        }
    }
}
function frogger_complete()
{
	model = getEnt("teleport_frogger_complete", "targetname");
	trig = getEnt("trigger_frogger_complete", "targetname");
	trig SetInvisibleToAll();
	model MoveZ(-1000,0.2);
	trig MoveZ(-1000,0,2);
	while(1)
	{
		wait(0.3);
		if (level.number_of_frogs == 3)
		{
			level notify ("frogger_complete");
			trig SetVisibleToAll();
			IPrintLnBold("Congratulations! teleporter is ready. Or you can place all frogs to earn 5000pts ");
			level.number_of_challenges_completed ++;
				model MoveZ(1000,0.2);
				trig MoveZ(1000,0,2);
			thread trig_teleport_to_start_zone(trig);
			trig waittill ( "trigger", player );
			level notify ("frogger_end");
			break;
		}
	}
}
function frogger_ptsextra()
{
	while(1)
	{
		wait(0.3);
		
		if (level.number_of_frogs == 5)
		{
			foreach(player in getplayers() )
       		{
            player.score += 5000;
        	}
        	IPrintLnBold("Perfect!! Everybody earn 5000pts");
			break;
		}
	}
}

function frogger_contador_vidas()
{
	self endon ("frogger_end");
	wait(1); //que primero se active frooger_impactos _permitidos
	while(1)
	{
		IPrintLnBold(level.impactos_permitidos_frogger," lives to restart level.");
		level waittill ("frogger_fail");
		level.impactos_permitidos_frogger --;
		if (level.impactos_permitidos_frogger == 0)
		{
			IPrintLnBold(" 0 lives :( Level Restarted");
			level.impactos_permitidos_frogger = 3;
			level notify("frogger_reseted");
			wait(1);
		}
	}
	
	

}
function frogger_impactos_permitidos()
{
	level.impactos_permitidos_frogger = 3;
	trigger = getEnt("trig_vidas_frogger", "targetname");

	while(1)
	{
		trigger SetHintString( "Actual lives: ",level.impactos_permitidos_frogger,". Use 1000 pts to get an extra live." ); 
		trigger SetCursorHint("HINT_NOICON");
		trigger waittill( "trigger", player ); 
		if(player.score >= 1000)
            {
					player.score -= 1000;
					level.impactos_permitidos_frogger ++;
					IPrintLnBold("Actual lives: ",level.impactos_permitidos_frogger);										
			}	
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////// DONKEY KONG   ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function donkey_kong()
{
	thread donkey_kong_gravity();
	thread donkey_kong_pantalla();
	thread setup_barriles();
	thread dk_suelo();
	thread dk_teleporter();
	thread salida_dk();
	thread dk_complete();
	thread dk_help();
	if (level.isEZmode == true)
	{
		IPrintLnBold("TIP: wait for nukes or minigun to climb");
	}
	
}
function donkey_kong_gravity()
{	set_gravity_off = getEnt("set_gravity_off", "targetname");
	set_gravity_change = getEnt("set_gravity_change", "targetname");
	set_gravity_change waittill( "trigger", player );
	SetGravity(500);
	SetJumpHeight (100);
	thread dk_players_hited();
	players = GetPlayers();
        for( i = 0; i < players.size; i++ ) //set up a for loop for player size
        {
           players[i] thread dk_jump_sound(); 
        }
	
	set_gravity_off waittill( "trigger", player );
	SetGravity(800);
	SetJumpHeight (39);
}
function donkey_kong_pantalla()
{	
	self endon ("dk_complete");
	while(1)
	{
		players = GetPlayers();
        for( i = 0; i < players.size; i++ )
        	{
        		thread game_2d_screen_player(i,players[i]);
        	}
       	wait(0.3);
	}
}

function game_2d_screen_player(i,player)
{
	model = getEnt("pixel_player" + i, "targetname");
	location = player.origin;
	position = (location[0],-460,location[2]+24.5);
	model MoveTo(position,0.3,0.1,0.1);
	
}


function setup_barriles()
{
	for( i = 1; i < 9; i++ )
	{
		barril = getEnt("barril_" + i, "targetname");
		trigger = getEnt("barrilt_" + i, "targetname");
		barril SetInvisibleToAll();
		thread hit_barril(trigger);
		trigger EnableLinkTo();
		trigger LinkTo(barril);
		barril MoveTo((-2334.5,877.5,1367.25),0.4,0.1,0.1);
		
	}
	thread dk_moves();
	thread dk_moves_2d();
}

function dk_moves()
{
	dk_celebra1 = getEnt("dk_celebra1", "targetname");
	dk_celebra2 = getEnt("dk_celebra2", "targetname");
	dk_barril1 = getEnt("dk_barril1", "targetname");
	dk_barril2 = getEnt("dk_barril2", "targetname");
	dk_barril3 = getEnt("dk_barril3", "targetname");
	while(1)
	{
		dk_celebra1 SetVisibleToAll();
		dk_celebra2 SetInvisibleToAll();
		dk_barril1 SetInvisibleToAll();
		dk_barril2 SetInvisibleToAll();
		dk_barril3 SetInvisibleToAll();
		wait(0.7);
		dk_celebra1 SetInvisibleToAll();
		dk_celebra2 SetVisibleToAll();
		wait(0.7);
		dk_celebra1 SetVisibleToAll();
		dk_celebra2 SetInvisibleToAll();
		wait(0.7);
		dk_celebra1 SetInvisibleToAll();
		dk_celebra2 SetVisibleToAll();
		wait(0.7);
		dk_celebra2 SetInvisibleToAll();
		dk_barril1 SetVisibleToAll();
		wait(0.7);
		dk_barril1 SetInvisibleToAll();
		dk_barril2 SetVisibleToAll();
		wait(0.7);
		dk_barril2 SetInvisibleToAll();
		dk_barril3 SetVisibleToAll();
		thread lanza_siguiente_barril();
		wait(0.7);
	}
}
function dk_moves_2d()
{
	dk_celebra1 = getEnt("dk_celebra1a", "targetname");
	dk_celebra2 = getEnt("dk_celebra2a", "targetname");
	dk_barril1 = getEnt("dk_barril1a", "targetname");
	dk_barril2 = getEnt("dk_barril2a", "targetname");
	dk_barril3 = getEnt("dk_barril3a", "targetname");
	level.numero_barril = 1;
	wait(0.3);
	while(1)
	{
		dk_celebra1 SetVisibleToAll();
		dk_celebra2 SetInvisibleToAll();
		dk_barril1 SetInvisibleToAll();
		dk_barril2 SetInvisibleToAll();
		dk_barril3 SetInvisibleToAll();
		wait(0.7);
		dk_celebra1 SetInvisibleToAll();
		dk_celebra2 SetVisibleToAll();
		wait(0.7);
		dk_celebra1 SetVisibleToAll();
		dk_celebra2 SetInvisibleToAll();
		wait(0.7);
		dk_celebra1 SetInvisibleToAll();
		dk_celebra2 SetVisibleToAll();
		wait(0.7);
		dk_celebra2 SetInvisibleToAll();
		dk_barril1 SetVisibleToAll();
		wait(0.7);
		dk_barril1 SetInvisibleToAll();
		dk_barril2 SetVisibleToAll();
		wait(0.7);
		dk_barril2 SetInvisibleToAll();
		dk_barril3 SetVisibleToAll();
		wait(0.3);
		//thread lanza_siguiente_barril();
		wait(0.4);
	}	
}

function lanza_siguiente_barril()
{
	i = level.numero_barril;
	barril = getEnt("barril_" + i, "targetname");
	trigger = getEnt("barrilt_" + i, "targetname");
	barril_2d = getEnt("barril2d_" + i, "targetname");
	trigger EnableLinkTo();
	trigger LinkTo(barril);
	thread recorrido_barril(barril);
	thread recorrido_barril_2d(barril_2d);

	wait(0.1);
	level.numero_barril ++;
	if (level.numero_barril == 9)
	{
		level.numero_barril = 1;
	}
}
function recorrido_barril(barril)
{
	//barril SetVisibleToAll();
	barril MoveTo((-6072.25,877.5,1367.25),0.3,0.1,0.1);
	wait(0.3);
	barril MoveTo((-7414,877.5,1294.7),4,0.1,0.1);
	wait(4);
	barril MoveTo((-7414.25,877.5,1178.5),0.6,0.1,0.1);
	wait(0.6);

	barril MoveTo((-5896.25,877.5,1096.25),4,0.1,0.1);
	wait(4);
	barril MoveTo((-5896.25,877.5,974.25),0.6,0.1,0.1);
	wait(0.6);

	barril MoveTo((-7360.2,877.5,895),4,0.1,0.1);
	wait(4);
	barril MoveTo((-7360.5,877.5,765.75),0.6,0.1,0.1);
	wait(0.6);

	barril MoveTo((-5912.75,877.5,691.75),4,0.1,0.1);
	wait(4);
	barril MoveTo((-5912.75,877.5,565.75),0.6,0.1,0.1);
	wait(0.6);

	barril MoveTo((-7360.75,877.5,445),4,0.1,0.1);
	wait(4);
	barril MoveTo((-7659,877.5,237.5),0.6,0.1,0.1);
	wait(0.6);
	//barril SetInvisibleToAll();
	barril MoveTo((-6072.25,900,45),0.3,0.1,0.1);
	wait(0.3);
	barril MoveTo((-2334.5,900,45),0.3,0.1,0.1);
	wait(0.3);
	barril MoveTo((-2334.5,877.5,1367.25),0.3,0.1,0.1);
	wait(0.3);
	
}
function recorrido_barril_2d(barril)
{
	wait(0.3); //compensar retraso pantalla 2d
	//barril SetVisibleToAll();
	barril MoveTo((-6072.25,-467.25,1367.25),0.3,0.1,0.1);
	wait(0.3);
	barril MoveTo((-7414,-467.25,1294.7),4,0.1,0.1);
	wait(4);
	barril MoveTo((-7414.25,-467.25,1178.5),0.6,0.1,0.1);
	wait(0.6);

	barril MoveTo((-5896.25,-467.25,1096.25),4,0.1,0.1);
	wait(4);
	barril MoveTo((-5896.25,-467.25,974.25),0.6,0.1,0.1);
	wait(0.6);

	barril MoveTo((-7360.2,-467.25,895),4,0.1,0.1);
	wait(4);
	barril MoveTo((-7360.5,-467.25,765.75),0.6,0.1,0.1);
	wait(0.6);

	barril MoveTo((-5912.75,-467.25,691.75),4,0.1,0.1);
	wait(4);
	barril MoveTo((-5912.75,-467.25,565.75),0.6,0.1,0.1);
	wait(0.6);

	barril MoveTo((-7360.75,-467.25,445),4,0.1,0.1);
	wait(4);
	barril MoveTo((-7659,-467.25,237.5),0.6,0.1,0.1);
	wait(0.6);
	//barril SetInvisibleToAll();
	barril MoveTo((-6072.25,-500.25,45),0.3,0.1,0.1);
	wait(0.3);
	barril MoveTo((-2334.5,-500,45),0.3,0.1,0.1);
	wait(0.3);
	barril MoveTo((-2334.5,-467.25,1367.25),0.3,0.1,0.1);
	wait(0.3);
	
}

function hit_barril(trigger)
{
	self endon ("peach_done");
	while(1)
	{
		trigger waittill( "trigger", player );
		IPrintLnBold(player.playername, " collided with a barrel");
		level notify("dk_fail" + player.playername);
		wait(3);
	}
} 
function dk_suelo()
{
	while(1)
	{
		trigger = getEnt("dk_suelo", "targetname");
		trigger waittill( "trigger", player );
		IPrintLnBold(player.playername, " fell down");
		level notify("dk_fail" + player.playername);
		wait(3);
	}
}
function dk_players_hited()
{	
		
	players = GetPlayers();
        for( i = 0; i < players.size; i++ )
        	{
        		thread dk_zombie_hit(players[i]);
        	}
}

function dk_zombie_hit(player)
{
	self endon ("dk_help");
	self endon ("peach_done");
	last_health = player.health;
	while(1)
	{	
		new_health = player.health;
		if (new_health < last_health)
		{
			IPrintLnBold(player.playername," was hited");
			level notify ("dk_fail" + player.playername);
		}
		last_health = new_health;
		wait(0.5);
	}
}

function dk_teleporter()
{
	players = GetPlayers();
        for( i = 0; i < players.size; i++ ) //set up a for loop for player size
        {
        	thread dk_teleporter_player(players[i].playername,players[i],i);
        }
    
}
function dk_teleporter_player(name_of_the_player,jugador,i)
{
	self endon ("dk_complete");
	while(1)
	{
		level waittill("dk_fail" + name_of_the_player);
        	if(jugador laststand::player_is_in_laststand() == false)
            {
        		jugador thread teleport_players_dk(i);
        	}
    }
}
function salida_dk()
{
		
		ladder_brush= getEnt("ladder_brush", "targetname");
		ladder_clip= getEnt("ladder_clip", "targetname");
		peach_model= getEnt("peach_model", "targetname");
		trigger = getEnt("peach_trigger", "targetname");
		ladder_brush SetInvisibleToAll();
		
		trigger SetCursorHint("HINT_NOICON");

	while(1)
	{
		trigger SetHintString( "Press and Hold ^3&&1^7 to Save the princess" ); 
		trigger waittill( "trigger", player ); 				
					ladder_brush SetVisibleToAll();
					ladder_clip Delete();
					peach_model Delete();	
					trigger Delete();
					thread dk_premios();
					level notify ("peach_done");	
					IPrintLnBold("You saved the princess!")	;		
	}
}


function dk_premios()
{
	thread dk_pulsador();
	level notify ("en_premios_ya");
}

function dk_pulsador()
{
	pulsador= getEnt("dk_bonus", "targetname");
	pulsador SetCursorHint("HINT_NOICON"); 
	players = GetPlayers();
	
        for( i = 0; i < players.size; i++ ) //set up a for loop for player size
        {
        	level.dk_bonus_player = players[i];
        	pulsador SetHintString(players[i].playername + " press and Hold ^3&&1^7 to Start bonus game. There is one try per player" );
        		thread girar_ruleta1();
				thread girar_ruleta2();
				thread girar_ruleta3();
while(1){
        	pulsador waittill( "trigger", player ); 
        	if (level.dk_bonus_player == player) 
        		{break;}
        } 
        	level notify("dk_bonus_start");
           	
        	IPrintLnBold(player.playername + " is playing the bonus game. Good Luck!");
        	pulsador SetHintString( "Press and Hold ^3&&1^7 to Stop the first item" );
while(1){
        	pulsador waittill( "trigger", player ); 
        	if (level.dk_bonus_player == player) 
        		{break;}
        }
        	level notify("dk_bonus_stop_1");
        	pulsador SetHintString( "Press and Hold ^3&&1^7 to Stop the second item" );

while(1){
        	pulsador waittill( "trigger", player ); 
        	if (level.dk_bonus_player == player) 
        		{break;}
        }
        	level notify("dk_bonus_stop_2");
        	pulsador SetHintString( "Press and Hold ^3&&1^7 to Stop the third item" );

while(1){
        	pulsador waittill( "trigger", player ); 
        	if (level.dk_bonus_player == player) 
        		{break;}
        }
        	level notify("dk_bonus_stop_3");
        	pulsador SetHintString( "" );
        	thread check_dk_bonus(level.dk_bonus_player);
        	

        }

level notify ("dk_open_teleport");      
while(1)
	{
		pulsador SetHintString( "Press and Hold ^3&&1^7 to Start bonus game. Cost: 2000pts" );
		pulsador waittill( "trigger", player );
        		thread girar_ruleta1();
				thread girar_ruleta2();
				thread girar_ruleta3();
       wait(1); 	 
     if(player.score >= 2000)
        {
            player.score -= 2000;
           	level notify("dk_bonus_start");
           	level.dk_bonus_player = player;
        	IPrintLnBold(player.playername, " is playing the bonus game. Good Luck!");
        	pulsador SetHintString( "Press and Hold ^3&&1^7 to Stop the first item" );
	while(1){
        	pulsador waittill( "trigger", player ); 
        	if (level.dk_bonus_player == player) 
        		{break;}
        }
        	level notify("dk_bonus_stop_1");
        	pulsador SetHintString( "Press and Hold ^3&&1^7 to Stop the second item" );

	while(1){
        	pulsador waittill( "trigger", player ); 
        	if (level.dk_bonus_player == player) 
        		{break;}
        }
        	level notify("dk_bonus_stop_2");
        	pulsador SetHintString( "Press and Hold ^3&&1^7 to Stop the third item" );

	while(1){
        	pulsador waittill( "trigger", player ); 
        	if (level.dk_bonus_player == player) 
        		{break;}
        }
        	level notify("dk_bonus_stop_3");
        	pulsador SetHintString( "" );
        	thread check_dk_bonus(level.dk_bonus_player);
        	
        }
	}

}

function girar_ruleta1()
{
	ruleta[1] = getEnt("ruleta1_1", "targetname");
	ruleta[2] = getEnt("ruleta1_2", "targetname");
	ruleta[3] = getEnt("ruleta1_3", "targetname");
	ruleta[2] SetInvisibleToAll();
	ruleta[3] SetInvisibleToAll();
	level waittill("dk_bonus_start");
	ruleta[1] SetInvisibleToAll();

	self endon( "dk_bonus_stop_1" ); 
	while(1)
	{
		for( i = 1; i < 4; i++ )
		{
			ruleta[i] SetVisibleToAll();
			wait(0.2);
			ruleta[i] SetInvisibleToAll();
			level.ruleta1_muestra = i;
		}
	}


}
function girar_ruleta2()
{
	ruleta[1] = getEnt("ruleta2_1", "targetname");
	ruleta[2] = getEnt("ruleta2_2", "targetname");
	ruleta[3] = getEnt("ruleta2_3", "targetname");
	ruleta[1] SetInvisibleToAll();
	ruleta[3] SetInvisibleToAll();
	level waittill("dk_bonus_start");
	ruleta[2] SetInvisibleToAll();

	self endon( "dk_bonus_stop_2" ); 
	while(1)
	{
		for( i = 1; i < 4; i++ )
		{
			ruleta[i] SetVisibleToAll();
			wait(0.2);
			ruleta[i] SetInvisibleToAll();
			level.ruleta2_muestra = i;
		}
	}

}
function girar_ruleta3()
{
	ruleta[1] = getEnt("ruleta3_1", "targetname");
	ruleta[2] = getEnt("ruleta3_2", "targetname");
	ruleta[3] = getEnt("ruleta3_3", "targetname");
	ruleta[2] SetInvisibleToAll();
	ruleta[1] SetInvisibleToAll();
	level waittill("dk_bonus_start");
	ruleta[3] SetInvisibleToAll();

	self endon( "dk_bonus_stop_3" ); 
	while(1)
	{
		for( i = 1; i < 4; i++ )
		{
			ruleta[i] SetVisibleToAll();
			wait(0.2);
			ruleta[i] SetInvisibleToAll();
			level.ruleta3_muestra = i;
		}
	}

}
function check_dk_bonus(player)
{	
	there_is_bonus = false;
	if ((level.ruleta1_muestra == 1) && (level.ruleta2_muestra == 1) && (level.ruleta3_muestra == 1))
	{
		level notify ("dk_bonus_seta");
		IPrintLnBold("1UP! (Quick revive) Say thank you to ",player.playername);
		players = GetPlayers();
		for(i = 0; i < players.size; i++) 
		{
			players[i] zm_perks::give_perk(PERK_QUICK_REVIVE);
		}
		there_is_bonus = true;

	}
	if ((level.ruleta1_muestra == 2) && (level.ruleta2_muestra == 2) && (level.ruleta3_muestra == 2))
	{
		level notify ("dk_bonus_star");
		
		IPrintLnBold("Shield Unlocked! Say thank you to ",player.playername);
		model = getEnt("jaula_escudo", "targetname");
		bm = getEnt("bm_jaula_escudo", "targetname");
		model Delete();
		bm Delete();
		there_is_bonus = true;
	}
	if ((level.ruleta1_muestra == 3) && (level.ruleta2_muestra == 3) && (level.ruleta3_muestra == 3))
	{
		level notify ("dk_bonus_flor");		
		IPrintLnBold("Monkeys Unlocked! Say thank you to ",player.playername);
		model = getEnt("jaula_mono", "targetname");
		bm = getEnt("bm_jaula_mono", "targetname");
		model Delete();
		bm Delete();
		there_is_bonus = true;
	}
	if (there_is_bonus == false)
	{
		player.score += 1000;
		IPrintLnBold(player.playername," earned 1000 points");
	}
	level notify ("dk_bonus_given");
}

function dk_jump_sound()
{
	level endon ("dk_complete");
	while(1)
	{
		if (self JumpButtonPressed())
		{
		PlaySoundAtPosition("mariobros_jumpid",self.origin);
		wait(1);
		}
	wait(0.2);
	}
}

function dk_complete()
{	
	model = getEnt("teleporter_dk_complete", "targetname");
	trig = getEnt("trigger_dk_complete", "targetname");
	model MoveX(1000,0.2);
	trig MoveX(1000,0,2);
	level waittill ("dk_open_teleport");
	level.number_of_challenges_completed ++;
	model MoveX(-1000,0.2);
	trig MoveX(-1000,0,2);
	thread trig_teleport_to_start_zone(trig);
	level notify ("dk_complete");
}

function go_to_bonus_room()
{
	tapa = GetEnt("tapa_dk", "targetname");
	pared = GetEnt("dk_no_pasar", "targetname");
	tapa SetInvisibleToAll();
	pared SetInvisibleToAll();
	trig = GetEnt("trigbonusroom", "targetname");
	trig SetCursorHint("HINT_NOICON"); 
	trig SetHintString( "Complete the challenge to unlock this teleporter" );
	level waittill ("dk_complete");
	pared SetVisibleToAll();
	while(1)
	{
		trig SetHintString( "Press and Hold ^3&&1^7 to teleprt players To the bonus Room" );
		trig waittill("trigger", player);
		tapa SetVisibleToAll();
		players = GetPlayers();
        for( i = 0; i < players.size; i++ ) //set up a for loop for player size
        {
        	if(players[i] laststand::player_is_in_laststand() == false)
            {
        		players[i] thread teleport_players_to_bonus(i);
        	}
        }
	}
	
}
function dk_help()
{
	self endon ("en_premios_ya");
	model = getEnt("model_help", "targetname");
	trig = getEnt("help_trigger", "targetname");
	trig SetCursorHint("HINT_NOICON"); 
	trig SetHintString( "Press and Hold ^3&&1^7 to disable reset by zombie impact. Cost: 5000pts per player" );
	model SetInvisibleToAll();
	trig SetInvisibleToAll();
	wait(300);
	thread playsoundok("setamarioid");
	IPrintLnBold("It seems that it is difficult for you. A help has appeared on the first beam");
	model SetVisibleToAll();
	trig SetVisibleToAll();

	players = GetPlayers();
	numb_players = players.size;
	cost = numb_players * 5000;
	pago = 0;

	while(1)
	{
		trig SetHintString( "Disable teleportation by impact with zombie. Cost: 5000pts per player. ");
		trig waittill("trigger", player);
		if(player.score >= 5000)
            {
                player.score -= 5000;
                pagonuevo = pago + 5000;
                pago = pagonuevo; 
                queda = cost - pago;
                if (queda != 0)
                {
                	IPrintLnBold( queda , "pts to get it");
                }               
            }
        if(pago >= cost)
        {
        	trig Delete();
        	model Delete();
        	break;
        }
	}
	thread playsoundok("setamarioid");
	level notify ("dk_help");
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////  1943      1943      1943 /////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function air_1943()
{
	thread teleporter_1943();
	//thread banda_sonora("1943id","1943_complete");
	thread fall_1943();
	thread impactos_permitidos();
	thread complete_1943();
	thread max_ammo_1943();
	thread reset_1943_level();
	iprintlnbold("You can adjust the volume of music on the options menu, sound, music volume. No Copyright Music.");

	for( i = 1; i < 17; i++ )
		{
			avioneta[i] = getEnt("avionetas_" + i, "targetname");
			
			avioneta[i] thread check_impacts("ataque_avionetas_done");
		}
	for( i = 1; i < 9; i++ )
		{
			avion[i] = getEnt("vtol_" + i, "targetname");
			
			avion[i] thread check_impacts("ataque_vtol_done");
		}
	for( i = 1; i < 12; i++ )
		{
			wavion[i] = getEnt("warthog_" + i, "targetname");
			
			wavion[i] thread check_impacts("ataque_warthog_done");
		}
	for( i = 1; i < 10; i++ )
		{
			gavion[i] = getEnt("ataque_girado_" + i, "targetname");
			
			gavion[i] thread check_impacts("ataque_girado_done");
		}
	for( i = 1; i < 11; i++ )
		{
			cavion[i] = getEnt("caza_" + i, "targetname");
			
			cavion[i] thread check_impacts("ataque_cazas_done");
		}
	
}

function spawn_parasitos_infinitos()
{
	self endon ("1943_fail");
	self endon ("1943_complete");
	while(1)
	{
		players = GetPlayers();
		zm_ai_wasp::special_wasp_spawn();
		wait(3);
	}
}
function spawn_parasitos_round()
{
	players = GetPlayers();
	number_of_parasitos = 6;
	for( i = 0; i < number_of_parasitos; i++ ) 
        {
        	zm_ai_wasp::special_wasp_spawn();
        	wait(1);
        }
}

function teleporter_1943()
{
	self endon ("1943_complete");
	trig = getEnt("trig_tele_1943", "targetname");
	trig SetCursorHint("HINT_NOICON"); 
	trig SetHintString( "Press and Hold ^3&&1^7 to Start Challenge" );
	while(1)
	{
		trig waittill("trigger", player);
		
		players = GetPlayers();
        for( i = 0; i < players.size; i++ ) //set up a for loop for player size
        {
        	if(players[i] laststand::player_is_in_laststand() == false)
            {
        		players[i] thread teleport_players_plane(i);
        	}
        }
        wait(2);
        thread ataque_aviones();
		thread jugadores_1943();
		thread contador_vidas();
		thread banda_sonora("1943id","1943_end_song","music_1943");
    }
}
function jugadores_1943()
{
	players = GetPlayers();
        for( i = 0; i < players.size; i++ ) //set up a for loop for player size
        {
        	thread movimiento_avion(i);
        }

}
function movimiento_avion(i) 
{	
	avion = getEnt("model_avion" + i, "targetname");
	bm = getEnt("bm_avion" + i, "targetname");
	girar_dch = getEnt("av_dcha_" + i, "targetname");
	girar_izq = getEnt("av_izq_" + i, "targetname");
	hitbox = getEnt("plane_hitbox_" + i, "targetname");
	bm EnableLinkTo();
	bm LinkTo(avion);
	girar_izq EnableLinkTo();
	girar_izq LinkTo(avion);
	girar_dch EnableLinkTo();
	girar_dch LinkTo(avion);
	hitbox EnableLinkTo();
	hitbox LinkTo(avion);
	avion PlayLoopSound("helicopterid");
	thread mover_dcha(i,avion);
	thread mover_izq(i,avion);
	avion thread reset_avion_position();


}
function mover_dcha(i,avion)
{
	girar_dch = getEnt("av_dcha_" + i, "targetname");
	while(1)
	{
		girar_dch waittill("trigger", player);
		posicion = avion.origin;		
		if(posicion[1] >=14380)
		{
			avion MoveY(-300,0.3);
		}
		wait(0.3);

	}
}

function mover_izq(i,avion)
{
	girar_izq = getEnt("av_izq_" + i, "targetname");
	while(1)
	{
		girar_izq waittill("trigger", player);
		posicion = avion.origin;
		if(posicion[1] <=20086)
		{
			avion MoveY(300,0.3);
		}
	
		wait(0.3);

	}
}

function ataque_aviones()
{
	self endon("1943_fail");
	IPrintLnBold("You can move your ship by standing on the wings");
	wait(6);
	thread spawn_parasitos_round();
	wait(10);
	thread ataque_avionetas();
	level waittill("ataque_avionetas_done");
	wait(4);
	thread ataque_vtol();
	level waittill("ataque_vtol_done");
	wait(4);
	thread ataque_warthog();
	level waittill("ataque_warthog_done");
	wait(4);
	thread ataque_girado();
	level waittill("ataque_girado_done");
	wait(4);
	thread ataque_cazas();
	level waittill("ataque_cazas_done");
	wait(4);

	level notify ("1943_complete");

}
function reset_avion_position()
{
	origen = self.origin;
	level waittill("1943_fail");
	wait(0.5);
	self MoveTo(origen,0.5);

}

function ataque_avionetas()
{	
	self endon("1943_fail");
	for( i = 1; i < 17; i++ )
		{
			avioneta[i] = getEnt("avionetas_" + i, "targetname");
			avioneta[i] thread reset_avion_position();
		}
		for( i = 1; i < 17; i++ )
		{
			avioneta[i]  MoveX(-37224,20);
		}
		thread playsoundok("sosid");
		wait(20);
		thread spawn_parasitos_round();
		for( i = 1; i < 17; i++ )
		{
			avioneta[i]  MoveZ(-4740,1);
		}
		wait(1);
		for( i = 1; i < 17; i++ )
		{
			avioneta[i]  MoveX(37224,1);
		}
		wait(1);
		for( i = 1; i < 17; i++ )
		{
			avioneta[i]  MoveZ(4740,1);
		}
		wait(1);
		level notify ("ataque_avionetas_done");
}

function ataque_vtol()
{	
	self endon("1943_fail");
	for( i = 1; i < 9; i++ )
		{
			avion[i] = getEnt("vtol_" + i, "targetname");
			avion[i] thread reset_avion_position();
		}
		for( i = 1; i < 9; i++ )
		{
			avion[i] MoveX(-32548,20);
		}
		thread playsoundok("sosid");
		wait(20);
		thread spawn_parasitos_round();
		for( i = 1; i < 9; i++ )
		{
			avion[i]  MoveZ(-5130,1);
		}
		wait(1);
		for( i = 1; i < 9; i++ )
		{
			avion[i]  MoveX(32548,1);
		}
		wait(1);
		for( i = 1; i < 9; i++ )
		{
			avion[i]  MoveZ(5130,1);
		}
		level notify ("ataque_vtol_done");
}

function ataque_warthog()
{	
	self endon("1943_fail");
	for( i = 1; i < 12; i++ )
		{
			avion[i] = getEnt("warthog_" + i, "targetname");
			avion[i] thread reset_avion_position();
		}
		thread playsoundok("sosid");
		avion[1] MoveX(-37224,8);
		avion[5] MoveX(-37224,8);
		wait(10);
		thread playsoundok("sosid");
		avion[2] MoveX(-37224,8);
		avion[4] MoveX(-37224,8);
		wait(5);
		thread playsoundok("sosid");
		avion[3] MoveX(-37224,8);
		wait(8);
		thread playsoundok("sosid");
		avion[6] MoveX(-37224,8);
		avion[7] MoveX(-37224,8);
		wait(5);
		thread playsoundok("sosid");
		avion[10] MoveX(-37224,8);
		avion[11] MoveX(-37224,8);
		wait(5);
		thread playsoundok("sosid");
		avion[8] MoveX(-37224,8);
		avion[9] MoveX(-37224,8);
		wait(8);
		thread spawn_parasitos_round();
		for( i = 1; i < 12; i++ )
		{
			avion[i] MoveZ(-5130,1);
		}
		wait(1);
		for( i = 1; i < 12; i++ )
		{
			avion[i] MoveX(37224,1);
		}
		wait(1);
		for( i = 1; i < 12; i++ )
		{
			avion[i] MoveZ(5130,1);
		}
		wait(1);
		level notify ("ataque_warthog_done");
}
function ataque_girado()
{	
	self endon("1943_fail");
	for( i = 1; i < 10; i++ )
		{
			avion[i] = getEnt("ataque_girado_" + i, "targetname");
			avion[i] thread reset_avion_position();
		}

		avion[1] MoveTo((-6638,16367,4752.75),4);
		avion[2] MoveTo((-6620,15313,4752.75),4);
		avion[3] MoveTo((-6620,14187,4752.75),4);
		thread playsoundok("sosid");
		wait(4);
		avion[1] MoveTo((-10693,20112,4752.75),4);
		avion[2] MoveTo((-10693,19058,4752.75),4);
		avion[3] MoveTo((-10693,17932,4752.75),4);
		wait(4);
		avion[1] MoveTo((-15417.5,16367,4752.75),4);
		avion[2] MoveTo((-15417.5,15313,4752.75),4);
		avion[3] MoveTo((-15417.5,14187,4752.75),4);

		wait(4);
		avion[1] MoveTo((-25392,20112,4752.75),4);
		avion[2] MoveTo((-25392,19058,4752.75),4);
		avion[3] MoveTo((-25392,17932,4752.75),4);
		wait(4);


		avion[4] MoveTo((-6638,20112,4752.75),4);
		avion[5] MoveTo((-6638,19058,4752.75),4);
		avion[6] MoveTo((-6638,17932,4752.75),4);
		thread playsoundok("sosid");
		wait(4);
		avion[4] MoveTo((-10693,16367,4752.75),4);

		avion[5] MoveTo((-10693,15313,4752.75),4);
		avion[6] MoveTo((-10693,14187,4752.75),4);
		wait(4);

		avion[4] MoveTo((-15417.5,20112,4752.75),4);
		avion[5] MoveTo((-15417.5,19058,4752.75),4);
		avion[6] MoveTo((-15417.5,17932,4752.75),4);
		wait(4);
		avion[4] MoveTo((-25392,16367,4752.75),4);
		avion[5] MoveTo((-25392,15313,4752.75),4);
		avion[6] MoveTo((-25392,14187,4752.75),4);

		wait(4);


		avion[8] MoveX(-25045,16);
		avion[7] MoveTo((-6638,18352,4752.75),4);
		avion[9] MoveTo((-6638,16110,4752.75),4);
		thread playsoundok("sosid");
		wait(4);
		avion[7] MoveTo((-10693,20217,4752.75),4);
		avion[9] MoveTo((-10693,14140,4752.75),4);

		wait(4);
		avion[7] MoveTo((-15417.5,18352,4752.75),4);
		avion[9] MoveTo((-15417.5,16110,4752.75),4);

		wait(4);
		avion[7] MoveTo((-25392,20217,4752.75),4);
		avion[9] MoveTo((-25392,14140,4752.75),4);

		wait(4);
		thread spawn_parasitos_round();


		for( i = 1; i < 10; i++ )
		{
			avion[i] MoveZ(-5130,1);
		}
		wait(1);
		for( i = 1; i < 10; i++ )
		{
			avion[i] MoveX(25045,1);
		}
		wait(1);
		for( i = 1; i < 10; i++ )
		{
			avion[i] MoveZ(5130,1);
		}
		wait(1);
		level notify ("ataque_girado_done");
}
function ataque_cazas()
{	
	self endon("1943_fail");
	for( i = 1; i < 11; i++ )
		{
			avion[i] = getEnt("caza_" + i, "targetname");
			avion[i] thread reset_avion_position();
		}
		for( i = 1; i < 11; i++ )
		{
			avion[i] MoveX(-33292,5);
		}
		wait(5);
		thread playsoundok("fast_sosid");
		avion[4] thread caza_ataca();
		avion[6] thread caza_ataca();
		wait(5);
		thread playsoundok("fast_sosid");
		avion[5] thread caza_ataca();
		avion[7] thread caza_ataca();
		avion[10] thread caza_ataca();
		wait(5);
		thread playsoundok("fast_sosid");
		avion[4] thread caza_ataca();
		avion[6] thread caza_ataca();
		wait(5);
		thread playsoundok("fast_sosid");
		avion[1] thread caza_ataca();
		avion[3] thread caza_ataca();
		wait(5);
		thread playsoundok("fast_sosid");
		avion[2] thread caza_ataca();
		avion[8] thread caza_ataca();
		avion[9] thread caza_ataca();
		avion[10] thread caza_ataca();
		wait(5);
		thread playsoundok("fast_sosid");
		avion[4] thread caza_ataca();
		avion[5] thread caza_ataca();
		avion[6] thread caza_ataca();
		avion[7] thread caza_ataca();
		wait(8);
		thread playsoundok("fast_sosid");
		avion[1] thread caza_ataca();
		avion[2] thread caza_ataca();
		avion[3] thread caza_ataca();
		wait(10.5);
		thread playsoundok("fast_sosid");
		avion[4] thread caza_ataca();
		avion[7] thread caza_ataca();
		avion[8] thread caza_ataca();
		avion[9] thread caza_ataca();
		avion[10] thread caza_ataca();
		wait(10.5);
		thread playsoundok("fast_sosid");
		avion[1] thread caza_ataca();
		avion[2] thread caza_ataca();
		avion[3] thread caza_ataca();
		avion[6] thread caza_ataca();
		avion[5] thread caza_ataca();
		wait(10.5);
		thread playsoundok("fast_sosid");
		avion[8] thread caza_ataca();
		avion[9] thread caza_ataca();
		avion[3] thread caza_ataca();
		avion[4] thread caza_ataca();
		avion[7] thread caza_ataca();
		avion[6] thread caza_ataca();
		avion[5] thread caza_ataca();
		wait(10.5);
		for( i = 1; i <11; i++ )
		{
			avion[i] MoveX(33292,10);
		}
		thread spawn_parasitos_round();
		wait(4);

		level notify ("ataque_cazas_done");
}
function caza_ataca()
{
	self MoveZ(100,0.5);
	wait(0.5);
	self MoveZ(-200,0.5);
	wait(0.5);
	self MoveZ(100,0.5);
	wait(1.5);
	self MoveX(-10900,2);
	wait(2);
	self MoveZ(-700,0.5);
	wait(0.5);
	self MoveX(10900,3);
	wait(3);
	self MoveZ(700,2);
	wait(2);

}

function check_impacts(endon_notification)
{
	
	
	for( i = 0; i < 4; i++ )
		{
			hitbox[i] = getEnt("plane_hitbox_" + i, "targetname");
		}
	while(1)
	{
		players = GetPlayers();
		for (i = 0;i<players.size;i++)
		{
			if(self IsTouching (hitbox[i]))
			{
				level notify ("1943_impact");
			IPrintLnBold(players[i].playername, " crashed");
			wait(2);
			}
		}
		wait(0.1);
	}
}

function fall_1943()
{
	while(1)
	{
		trigger = getEnt("fall_1943", "targetname");
		trigger waittill( "trigger", player );
		IPrintLnBold(player.playername, " fell down");
		wait(2);
		level notify("1943_fail");
		wait(3);
	}
}
function contador_vidas()
{
	self endon ("1943_fail");
	vidas_actuales = level.impactos_permitidos;
	while(1)
	{
		IPrintLnBold(vidas_actuales," impacts to restart level.");
		level waittill ("1943_impact");
		vidas_actuales --;
		if (vidas_actuales == 0)
		{break;}
	}
	level notify("1943_fail");

}
function impactos_permitidos()
{
	level.impactos_permitidos = 3;
	trigger = getEnt("trig_impactos_permitidos", "targetname");

	while(1)
	{
		trigger SetHintString( "Current Ship Shield: Level ",level.impactos_permitidos,". Use 1000 pts to improve it." ); 
		trigger SetCursorHint("HINT_NOICON");
		trigger waittill( "trigger", player ); 
		if(player.score >= 1000)
            {
					player.score -= 1000;
					level.impactos_permitidos ++;
					IPrintLnBold("The ship can now take ",level.impactos_permitidos," hits!");										
			}	
	}
}
function teleport_players_plane(i)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("1943_teleport_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}
function max_ammo_1943()
{
	max_ammo_spawn = struct::get("max_ammo_spawn", "targetname");
	trig = getEnt("max_ammo_1943", "targetname");
	trig SetCursorHint("HINT_NOICON"); 
	trig SetHintString( "Press and Hold ^3&&1^7 to Get a Free Max Ammo" );
	while(1)
	{
		trig waittill("trigger", player);
		max_ammo_spawn thread zm_powerups::specific_powerup_drop("full_ammo", max_ammo_spawn.origin);
	}
}
function complete_1943()
{
	level waittill("1943_complete");
	level.number_of_challenges_completed ++;
	level notify("1943_end_song");
		players = GetPlayers();
        for( i = 0; i < players.size; i++ ) //set up a for loop for player size
        {
        		players[i] thread teleport_players_1943(i);
        }
       IPrintLnBold("Congratulations! Level Completed");
       trig = getEnt("trig_tele_1943", "targetname");
		thread trig_teleport_to_start_zone(trig);
		

}
function reset_1943_level()
{	
	while(1)
	{
	level waittill("1943_fail");
		level notify("1943_end_song");
		players = GetPlayers();
        for( i = 0; i < players.size; i++ ) //set up a for loop for player size
        {
        		players[i] thread teleport_players_1943(i);
        }
        zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
       IPrintLnBold("Level Restarted.");
	}

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// PAC MAN      PAC MAN     PAC MAN   ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function pacman()
{
	level util::set_lighting_state(1);
	level.number_of_fruit_recolected = 0;

	for( i = 1; i < 7; i++ ) //set up a for loop for player size
        {
        		trig_cereza = getEnt("trig_cereza_" + i, "targetname");
        		trig_fresa = getEnt("trig_fresa_" + i, "targetname");
        		trig_naranja = getEnt("trig_naranja_" + i, "targetname");
        		cereza = getEnt("cereza_" + i, "targetname");
        		fresa = getEnt("fresa_" + i, "targetname");
        		naranja = getEnt("naranja_" + i, "targetname");
        		trig_cereza SetInvisibleToAll();
        		trig_fresa SetInvisibleToAll();
        		trig_naranja SetInvisibleToAll();
        		cereza SetInvisibleToAll();
        		fresa SetInvisibleToAll();
        		naranja SetInvisibleToAll();
        }

     thread teleporter_pacman1();
     thread teleporter_pacman2();
     thread pacman_complete();

    //juego
    thread playsoundok("pacman_roundid");
	thread cerezas();
	level waittill ("cerezas_complete");

	thread playsoundok("pacman_musicid");
	level thread brutus::spawn_brutus();
	level waittill("brutus_is_dead");
	wait(2);
	thread playsoundok("pacman_roundid");
	thread fresas();
	level waittill ("fresas_complete");

	thread playsoundok("pacman_musicid");
	level thread brutus::spawn_brutus();
	level waittill("brutus_is_dead");
	wait(2);
	thread playsoundok("pacman_roundid");
	thread naranjas();
	level waittill ("naranjas_complete");

	thread playsoundok("pacman_musicid");
	level thread brutus::spawn_brutus();
	level waittill("brutus_is_dead");
	level notify("pacman_complete");
	level.number_of_challenges_completed ++;
	
}


function coger_fruta(trig,model)
{
	trig waittill("trigger", player);
	trig Delete();
	model Delete();
	thread playsoundok("pacman_fruitid");
	level.number_of_fruit_recolected ++;
}

function cerezas()
{
	level.cereza_a = RandomIntRange(1,7); //(min result, max rasult + 1)
	while(1)
	{
		level.cereza_b = RandomIntRange(1,7); //(min result, max rasult + 1)
		wait(0.05);
		if (level.cereza_b != level.cereza_a)
			{break;}
	}
	while(1)
	{
		level.cereza_c = RandomIntRange(1,7); //(min result, max rasult + 1)
		wait(0.05);
		if ((level.cereza_c != level.cereza_a) && (level.cereza_c != level.cereza_b))
			{break;}
	}

	
	for( i = 1; i < 7; i++ ) //set up a for loop for player size
        {
        		trig[i] = getEnt("trig_cereza_" + i, "targetname");
        		model[i] = getEnt("cereza_" + i, "targetname");
        }
    trig[level.cereza_a] SetVisibleToAll();
    trig[level.cereza_b] SetVisibleToAll();
    trig[level.cereza_c] SetVisibleToAll();
    model[level.cereza_a] SetVisibleToAll();
    model[level.cereza_b] SetVisibleToAll();
    model[level.cereza_c] SetVisibleToAll();
    thread rotateobject(model[level.cereza_a]);
    thread rotateobject(model[level.cereza_b]);
    thread rotateobject(model[level.cereza_c]);
    thread coger_fruta(trig[level.cereza_a],model[level.cereza_a]);
    thread coger_fruta(trig[level.cereza_b],model[level.cereza_b]);
    thread coger_fruta(trig[level.cereza_c],model[level.cereza_c]);
    while(1)
    {
    	wait(0.5);
    	if(level.number_of_fruit_recolected == 3)
    		{break;}
    }
    level notify("cerezas_complete");
}

function fresas()
{
	level.fresa_a = RandomIntRange(1,7); //(min result, max rasult + 1)
	while(1)
	{
		level.fresa_b = RandomIntRange(1,7); //(min result, max rasult + 1)
		wait(0.05);
		if (level.fresa_b != level.fresa_a)
			{break;}
	}
	while(1)
	{
		level.fresa_c = RandomIntRange(1,7); //(min result, max rasult + 1)
		wait(0.05);
		if ((level.fresa_c != level.fresa_a) && (level.fresa_c != level.fresa_b))
			{break;}
	}

	
	for( i = 1; i < 7; i++ ) //set up a for loop for player size
        {
        		trig[i] = getEnt("trig_fresa_" + i, "targetname");
        		model[i] = getEnt("fresa_" + i, "targetname");
        }
    trig[level.fresa_a] SetVisibleToAll();
    trig[level.fresa_b] SetVisibleToAll();
    trig[level.fresa_c] SetVisibleToAll();
    model[level.fresa_a] SetVisibleToAll();
    model[level.fresa_b] SetVisibleToAll();
    model[level.fresa_c] SetVisibleToAll();
    thread rotateobject(model[level.fresa_a]);
    thread rotateobject(model[level.fresa_b]);
    thread rotateobject(model[level.fresa_c]);
    thread coger_fruta(trig[level.fresa_a],model[level.fresa_a]);
    thread coger_fruta(trig[level.fresa_b],model[level.fresa_b]);
    thread coger_fruta(trig[level.fresa_c],model[level.fresa_c]);
    while(1)
    {
    	wait(0.5);
    	if(level.number_of_fruit_recolected == 6)
    		{break;}
    }
    level notify("fresas_complete");
}

function naranjas()
{
	level.naranja_a = RandomIntRange(1,7); //(min result, max rasult + 1)
	while(1)
	{
		level.naranja_b = RandomIntRange(1,7); //(min result, max rasult + 1)
		wait(0.05);
		if (level.naranja_b != level.naranja_a)
			{break;}
	}
	while(1)
	{
		level.naranja_c = RandomIntRange(1,7); //(min result, max rasult + 1)
		wait(0.05);
		if ((level.naranja_c != level.naranja_a) && (level.naranja_c != level.naranja_b))
			{break;}
	}

	
	for( i = 1; i < 7; i++ ) //set up a for loop for player size
        {
        		trig[i] = getEnt("trig_naranja_" + i, "targetname");
        		model[i] = getEnt("naranja_" + i, "targetname");
        }
    trig[level.naranja_a] SetVisibleToAll();
    trig[level.naranja_b] SetVisibleToAll();
    trig[level.naranja_c] SetVisibleToAll();
    model[level.naranja_a] SetVisibleToAll();
    model[level.naranja_b] SetVisibleToAll();
    model[level.naranja_c] SetVisibleToAll();
    thread rotateobject(model[level.naranja_a]);
    thread rotateobject(model[level.naranja_b]);
    thread rotateobject(model[level.naranja_c]);
    thread coger_fruta(trig[level.naranja_a],model[level.naranja_a]);
    thread coger_fruta(trig[level.naranja_b],model[level.naranja_b]);
    thread coger_fruta(trig[level.naranja_c],model[level.naranja_c]);
    while(1)
    {
    	wait(0.5);
    	if(level.number_of_fruit_recolected == 9)
    		{break;}
    }
    level notify("naranjas_complete");
}
function teleporter_pacman1()
{
	trig = getEnt("pacman_dcha_trigg" , "targetname");
	i = 0;
	while(1)
	{
		trig waittill("trigger", player);
		i ++;
		if (i == 4)
		{
			i = 0;
		}
		player thread teleport_player_to_pacman_izq(i);
	}
}
function teleporter_pacman2()
{
	trig = getEnt("pacman_izq_trigg" , "targetname");
	i = 0;
	while(1)
	{
		trig waittill("trigger", player);
		i ++;
		if (i == 4)
		{
			i = 0;
		}
		player thread teleport_player_to_pacman_dcha(i);
	}
}

function teleport_player_to_pacman_izq(i)
{
   
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("pcman_izq_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}

function teleport_player_to_pacman_dcha(i)
{
   
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("pcman_dcha_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}

function pacman_complete()
{	
	model = getEnt("teleport_pacman_complete", "targetname");
	trig = getEnt("trigger_pacman_complete", "targetname");
	trig SetInvisibleToAll();
	model MoveZ(-1000,0.2);
	trig MoveZ(-1000,0,2);
	level waittill ("pacman_complete");
	trig SetVisibleToAll();
	IPrintLnBold("Find the teeporter");
	model MoveZ(1000,0.2);
	trig MoveZ(1000,0,2);
	thread trig_teleport_to_start_zone(trig);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// 8 DOORS CHALLENGE GAMEPLAY   ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function gameplay_8doors()
{
	level.number_of_challenges_completed = 0;
	thread recompensas();
	thread teleport_to_challenges();
	thread keydoors();
	thread exec_endgame();

}

function recompensas()
{
	thread recompensa("p1a","p1b","soccer_complete");
	thread recompensa("p2a","p2b","tetris_complete");
	thread recompensa("p3a","p3b","si_complete");
	thread recompensa("p4a","p4b","ms_complete");
	thread recompensa("p5a","p5b","frogger_complete");
	thread recompensa("p6a","p6b","dk_complete");
	thread recompensa("p7a","p7b","1943_complete");
	thread recompensa("p8a","p8b","pacman_complete");

	thread unlock_pap();


}
function recompensa(caja1,caja2,mensaje_notificacion)
{
	level waittill (mensaje_notificacion);
	caja1 = getEnt( caja1 , "targetname");
	caja2 = getEnt( caja2 , "targetname");
	caja1 Delete();
	caja2 Delete();
}

function unlock_pap()
{
	pap = getEnt( "pap" , "targetname");
	trig = getEnt( "start_zone_trigger_multiple" , "targetname");
	while(1)
	{
		wait(1);
		if (level.number_of_challenges_completed == 5)
		{
			pap Delete();
			trig waittill( "trigger", player );
			IPrintLnBold("5/8 chgallenges completed. PAP unlocked!");
			thread playsoundok("challengecompletedid");
			break;
		}
	}
}

function teleport_to_challenges()
{
	// i=1 kick off
	// i=2 tetris
	// i=3 si
	// i=4 ms
	// i=5 frogger
	// i=6 dk
	// i=7 1943
	// i=8 pacman
	thread teleport_players_to(1,"kcik_off_teleport_");
	thread teleport_players_to(2,"tetris_teleport_");
	thread teleport_players_to(3,"si_teleport_");
	thread teleport_players_to(4,"ms_teleport_");
	thread teleport_players_to(5,"frog_teleport_");
	thread teleport_players_to(6,"dk_teleport_");
	thread teleport_players_to(7,"1943_teleport_central_");
	thread teleport_players_to(8,"pacman_teleport_");
}
function teleport_players_to(i,destinos)
{
	trig = getEnt( "trig_telep_" + i , "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to Teleport All players to the Challenge" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );
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
                             
              players = GetPlayers();
               for( j = 0; j < players.size; j++ ) //set up a for loop for player size
                   {                			
                        players[j] thread teleport_player_to(j,destinos);          			
                  }
                  thread activar_juego(i);
              break;
       }
       else
       {
        IPrintLnBold("All players must be alive");
       }

    }
    wait(5);

    while(1)
	{
		trig waittill( "trigger", player );

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
                             
              players = GetPlayers();
               for( j = 0; j < players.size; j++ ) //set up a for loop for player size
                   {    
            			
                        players[j] thread teleport_player_to(j,destinos);   
                            			
                  }
       }
       else
       {
        IPrintLnBold("All players must be alive");
       }

    }
	
}
function teleport_player_to(i,destinos)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
    	lugar = destinos + i ;
        destinations[i] = struct::get(lugar, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}

function activar_juego(i)
{
	//futbol
	if (i == 1)
	{
	level.kick_the_ball = 0;
	thread futbol();
	grow_soul::init(  );
	flag::init( "futbolflag" );
    flag::set( "futbolflag" );  
	}

	//tetris
	if (i == 2)
	{
	thread tetris();
	flag::init( "tetrisflag" );
    flag::set( "tetrisflag" );
	}
	//spaceinvaders
	if (i == 3)
	{
	thread spaceinvaders();
	flag::init( "spaceinvadersflag" );
    flag::set( "spaceinvadersflag" );
	}

	//metalslug
	if (i == 4)
	{
	thread metalslug();
	flag::init( "msflag" );
    flag::set( "msflag" );
	}

	//frogger
	if (i == 5)
	{
	thread frogger();
	flag::init( "froggerflag" );
    flag::set( "froggerflag" );
	}

	//donkey kong
	if (i == 6)
	{
	thread donkey_kong();
	flag::init( "dkflag" );
    flag::set( "dkflag" );
	}

	//1943
	if (i == 7)
	{
	thread air_1943();
	flag::init( "1943flag" );
    flag::set( "1943flag" );
	}

	//pac man
	if (i == 8)
	{
	thread pacman();
	flag::init( "pacmanflag" );
    flag::set( "pacmanflag" );
	}
}

function trig_teleport_to_start_zone(trig)
{
	trig SetHintString( "Press and Hold ^3&&1^7 to Teleport All players to the Start Room" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );
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
                             
              players = GetPlayers();
               for( i = 0; i < players.size; i++ ) //set up a for loop for player size
                   {    
                        players[i] thread teleport_players_to_startroom(i);          			
                  }
              level.have_key = true;
       }
       else
       {
        IPrintLnBold("All players must be alive");
       }

    }
}
function teleport_players_to_startroom(i)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("startroom_teleport_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}



function keydoors()
{
	level.have_key = true;

	for (i = 1;i<9;i++) //there are 8 doors
	{
		thread key_door_number(i);
	}

}

function key_door_number(i)
{
    pulsador = GetEnt("trig_key_door" + i , "targetname");
    pulsador SetHintString("^2Hold [{+activate}] To Select this Challenge");
    pulsador SetCursorHint("HINT_NOICON");

    door = GetEnt("key_door" + i, "targetname");
    have_door = true;
    while(1)
    {    	
    	pulsador waittill("trigger", player);
    	
     	if (level.have_key == true)
       {
            door Delete();
            pulsador Delete();
            level.have_key = false;
            have_door = false;
       }
       if(have_door == false)
       {
        break;
       }
        if (level.have_key == false)
       {
        IPrintLnBold("You must complete another challenge");
       }
        wait(1);
   
    }
}

//ENDGAME
function exec_endgame()
{  
	trigg = GetEnt("start_zone_end", "targetname");
	thread end_game_trigger();
	while(1)
    {
       if (level.number_of_challenges_completed == 8)
      {
        wait(2);
		trigg waittill("trigger",player);
           players = GetPlayers();
             for( i = 0; i < players.size; i++ ) //set up a for loop for player size
             {
            	players[i] thread teleport_players_to_endroom(i); 
             }  
             thread mostrar_tiempo_transcurrido(); 
             level util::set_lighting_state(1);
             break; 
      }
    wait(2);
    }
}
function teleport_players_to_endroom(i)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("end_zone_teleport_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}
function mostrar_tiempo_transcurrido()
{
	horas = level.tgTimerTime.hours;
	min = level.tgTimerTime.minutes;
	sec = level.tgTimerTime.seconds;
	if (level.isEZmode == false)
	{
	while(1)
		{
		IPrintLnBold("Your Time: ",horas,"h ",min,"´ ",sec,"´´ ");
		wait(3);
		}
	}
	if (level.isEZmode == true)
	{
		while(1)
		{
			IPrintLnBold("You did it but you're still millennial. Complete the map in normal mode to record your time and became a real Retro Gamer!");
			wait(3);
		}
	}
}
function end_game_trigger()
{
	  trig = getEnt("end_game_trigger", "targetname");
	  trig SetHintString( "Press and Hold ^3&&1^7 to end the game" ); 
	  trig SetCursorHint("HINT_NOICON");
	  trig waittill("trigger",player);
	  level notify("end_game");
	 
}

function ez_mode()
{
	  level.isEZmode = false;
	 for( i = 0; i < 26; i++ ) 
             {
             	guia[i] = getEnt("guia" + i, "targetname");
	 			//guia[i] SetInvisibleToAll();
	 		  }

	  trig = getEnt("ez_mode", "targetname");
	  trig SetHintString( "Press and Hold ^3&&1^7 to activate CRYING MILLENNIAL mode. (EZ mode and GUIDE)" ); 
	  trig SetCursorHint("HINT_NOICON");
	  trig waittill("trigger",player);
	  trig SetHintString( "Press and Hold ^3&&1^7 again. You cannot reverse it and your time will not be recorded" );
	  trig waittill("trigger",player); 
	  level notify("ez_mode");
	  level.isEZmode = true;
	  thread playsoundok("challengecompletedid");
	  IPrintLnBold("CRYING MILLENNIAL MODE has been activated.");
	  IPrintLnBold("+500000pts and merk machines unlocked.");

	  for( i = 0; i < 26; i++ ) 
             {
             	guia[i] = getEnt("guia" + i, "targetname");
             	//guia[i] SetVisibleToAll();
             }
             guia[10] SetVisibleToAll();
             guia[12] SetVisibleToAll();
             guia[13] SetVisibleToAll();
             guia[14] SetVisibleToAll();
             guia[15] SetVisibleToAll();
             guia[17] SetVisibleToAll();

	  players = GetPlayers();
	  for( i = 0; i < players.size; i++ ) //set up a for loop for player size
             {
            	players[i].score += 500000; 
             }  
	for( i = 0; i < 9; i++ ) //set up a for loop for player size
             {
				caja1a = getEnt( "p1a" , "targetname");
				caja1b = getEnt( "p1b" , "targetname");
				caja2a = getEnt( "p2a" , "targetname");
				caja2b = getEnt( "p2b" , "targetname");
				caja3a = getEnt( "p3a" , "targetname");
				caja3b = getEnt( "p3b" , "targetname");
				caja4a = getEnt( "p4a" , "targetname");
				caja4b = getEnt( "p4b" , "targetname");
				caja5a = getEnt( "p5a" , "targetname");
				caja5b = getEnt( "p5b" , "targetname");
				caja6a = getEnt( "p6a" , "targetname");
				caja6b = getEnt( "p6b" , "targetname");
				caja7a = getEnt( "p7a" , "targetname");
				caja7b = getEnt( "p7b" , "targetname");
				caja8a = getEnt( "p8a" , "targetname");
				caja8b = getEnt( "p8b" , "targetname");
				caja1a Delete();
				caja1b Delete();
				caja2a Delete();
				caja2b Delete();
				caja3a Delete();
				caja3b Delete();
				caja4a Delete();
				caja4b Delete();
				caja5a Delete();
				caja5b Delete();
				caja6a Delete();
				caja6b Delete();
				caja7a Delete();
				caja7b Delete();
				caja8a Delete();
				caja8b Delete();
			}
}