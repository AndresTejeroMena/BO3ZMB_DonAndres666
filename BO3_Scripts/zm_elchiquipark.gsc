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
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;

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


#using scripts\zm\_zm_perk_electric_cherry;
#using scripts\zm\_zm_perk_widows_wine; 

#using scripts\zm\_zm_bgb;

//Powerups
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
//#using scripts\zm\_zm_powerup_weapon_minigun;

#using scripts\zm\_zm_perks;
#insert scripts\zm\_zm_perks.gsh;
#using scripts\shared\ai\zombie_death;
#using scripts\zm\_zm_score;

//almas
#using scripts\zm\growing_soulbox;

//Traps
#using scripts\zm\_zm_trap_electric;



// DER WUNDERFIZZ
#using scripts\zm\_zm_perk_random;

#using scripts\zm\zm_usermap;

#precache( "fx", "dlc4/genesis/fx_summon_circle_rune_glow" );

//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{
	level.dog_rounds_allowed = false;
	zm_usermap::main();


	zm_perk_random::include_perk_in_random_rotation( "specialty_quickrevive" );
zm_perk_random::include_perk_in_random_rotation( "specialty_armorvest" );
zm_perk_random::include_perk_in_random_rotation( "specialty_doubletap2" );
zm_perk_random::include_perk_in_random_rotation( "specialty_fastreload" );
zm_perk_random::include_perk_in_random_rotation( "specialty_deadshot" );
zm_perk_random::include_perk_in_random_rotation( "specialty_phdflopper" );
zm_perk_random::include_perk_in_random_rotation( "specialty_staminup" );
zm_perk_random::include_perk_in_random_rotation( "specialty_additionalprimaryweapon" );
zm_perk_random::include_perk_in_random_rotation( "specialty_tombstone" );
zm_perk_random::include_perk_in_random_rotation( "specialty_whoswho" );
zm_perk_random::include_perk_in_random_rotation( "specialty_electriccherry" );
zm_perk_random::include_perk_in_random_rotation( "specialty_vultureaid" );
zm_perk_random::include_perk_in_random_rotation( "specialty_widowswine" );


	level.dog_rounds_allowed = false;
	level.perk_purchase_limit = 20;
	level.player_starting_points = 500;//almas tmbn
	level.start_weapon = getWeapon("h1_usp45");
	//level.start_weapon = getWeapon("ar_damage_upgraded");
	
	level._zombie_custom_add_weapons =&custom_add_weapons;
	
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	level.pathdist_type = PATHDIST_ORIGINAL;

	//velocidad de spawn
	level thread spawn_sped();

	//GROW_SOUL
	grow_soul::init(  );

	
	level.dog_rounds_allowed = false;

	//cosas del mapa
	level thread creditos();
	level thread puertas_mapa();

	level thread rotate_fans();
	level thread rotar();
	level thread setas();
	level thread barras();
	level thread gravity_zone();
	level thread bolas();
	level thread jetpack();
	level thread rampa();
	level thread punos();

	thread generators();
	level thread desafio_power();
	level thread pap_race();
	level thread challenges();
	level thread final_challenge();

	level thread end_map();
	level thread end_of_round();
	level thread bajo_mapa();

		 //CUSTOM PACK A PUNCH CAMO
    level.pack_a_punch_camo_index = 17; 
	//puntos por agacharte
	level zm_perks::spare_change();
	thread perkmachine("trig_electriccherry","PERK_ELECTRIC_CHERRY",2000,"Electric Cherry","specialty_electriccherry","specialty_electriccherry_power_on");
	thread perkmachine("trig_coz","PERK_ADDITIONAL_PRIMARY_WEAPON",3000,"Mule Kick","specialty_additionalprimaryweapon","specialty_additionalprimaryweapon_power_on");
	thread perkmachine("trig_widows","PERK_WIDOWS_WINE",3000,"Widows Wine","specialty_widowswine","specialty_widowswine_power_on");

	thread perkmachine("trig_speedcola","PERK_SLEIGHT_OF_HAND",3000,"Speed Cola","specialty_fastreload","specialty_fastreload_power_on");
	thread perkmachine("trig_staminup","PERK_STAMINUP",2000,"Stamin Up","specialty_staminup","specialty_staminup_power_on");
	thread perkmachine("trig_doubletap","PERK_DOUBLETAP2",2000,"Double Tap","specialty_doubletap2","doubletap_on");
	thread perkmachine("trig_jugger","PERK_JUGGERNOG",2500,"Juggernog","specialty_armorvest","specialty_armorvest_power_on");
	
	//thread perkmachine("trig_wolf","PERK_BLOOD_WOLF_BITE",3000,"Blood Wolf Bite","specialty_bloodwolf_zombies","specialty_bloodwolf_zombies_power_on");
	//TEST
	thread testing();
}

function usermap_test_zone_init()
{
	zm_zonemgr::add_adjacent_zone("start_zone","zone_1","startflag");
	zm_zonemgr::add_adjacent_zone("start_zone","zone_down","startflag");

	zm_zonemgr::add_adjacent_zone("zone_2","zone_1","flag12");
	zm_zonemgr::add_adjacent_zone("zone_2","zone_3a","flag23");
	zm_zonemgr::add_adjacent_zone("zone_3a","zone_3b");

	zm_zonemgr::add_adjacent_zone("zone_4","zone_1","flag14");
	zm_zonemgr::add_adjacent_zone("zone_4","zone_5a","flag45");
	zm_zonemgr::add_adjacent_zone("zone_5b","zone_5a","flag45");

	zm_zonemgr::add_adjacent_zone("zone_6","zone_1","flag16");
	zm_zonemgr::add_adjacent_zone("zone_6","zone_6g","flag16");
	zm_zonemgr::add_adjacent_zone("zone_6","zone_6b","flag16");
	zm_zonemgr::add_adjacent_zone("zone_6c","zone_6b","flag16");
	zm_zonemgr::add_adjacent_zone("zone_6","zone_7","flag67");
	zm_zonemgr::add_adjacent_zone("zone_6c","zone_7","flag67");

	zm_zonemgr::add_adjacent_zone("zone_8a","zone_7","flag78");
	zm_zonemgr::add_adjacent_zone("zone_8a","zone_8b");

	zm_zonemgr::add_adjacent_zone("zone_9a","zone_7","flag79");
	zm_zonemgr::add_adjacent_zone("zone_9a","zone_9b");

	zm_zonemgr::add_adjacent_zone("zone_10","zone_8b","flag810");
	zm_zonemgr::add_adjacent_zone("zone_10","zone_9b","flag910");
	zm_zonemgr::add_adjacent_zone("zone_10","zone_11","flag1011");

	zm_zonemgr::add_adjacent_zone("zone_3b","zone_11","flag311");
	zm_zonemgr::add_adjacent_zone("zone_5b","zone_11","flag511");
	zm_zonemgr::add_adjacent_zone("zone_6","zone_11","flag611");

	level flag::init( "always_on" );
	level flag::set( "always_on" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

function testing()
{
	level flag::wait_till("initial_blackscreen_passed");
	
	/*wait(2);
	flag::init( "flag67" );
    flag::set("flag67");
    puente = getEnt("puente", "targetname");
	puente_centro = getEnt("puente_centro", "targetname");
	puente EnableLinkTo();
	puente LinkTo(puente_centro);
	puente_centro RotateRoll(-90,2,0.8,0.8);
	puente_centro RotateRoll(90,2,0.8,0.8);
	
    level notify  ("all doors opened");

    level notify ("generator done");
    wait(0.2);
    level notify ("generator done");
    wait(0.2);
    level notify ("generator done");
    wait(0.2);
    level notify ("generator done");


				f
				wait(2);
				pap_box = getEnt("caja_pap" ,"targetname");
				pap_box Delete();

				level notify ("pap_unlocked");
				level notify ("desafios_hechos");
				wait (2);
				 level notify ("Deasert Eagle Challenge Done");
				 level notify ("Ranger Challenge Done");*/
    
}
function creditos()
{
	level flag::wait_till("initial_blackscreen_passed");
	iprintlnbold("This map was created by DonAndres_666, Enjoy!"); 
	wait(0.5);
	iprintlnbold("Modified Music, NO COPYRIGHT"); 
}
function playsoundok(sound)
{
	level.playSoundLocation PlaySound(sound);
	players = GetPlayers();
		for (i = 0;i<players.size;i++)

		{
		players[i] PlayLocalSound(sound);}
}

function perkmachine(trigger,perk,cost,perkname,specialtyperk,power_on_message)
{
	trig = getEnt(trigger, "targetname");
	
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString("Need Power"); 
	level waittill(power_on_message);
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
//PUERTAS MAPA
function puertas_mapa()
{
	level flag::wait_till("initial_blackscreen_passed");
	thread puerta("start_door","start_trigger_door",750,"startflag");
	thread puerta("door12","trig_12",750,"flag12");
	thread puerta("door23","trig_23",1000,"flag23");
	thread puerta("door14","trig_14",750,"flag14");
	thread puerta("door45","trig_45",1000,"flag45");

	thread puerta("door16","trig_16",1750,"flag16");
	thread puerta("door78","trig_78",2000,"flag78");
	thread puerta("door79","trig_79",2000,"flag79");


	thread puerta("door810","trig_810",1250,"flag810");
	thread puerta("door910","trig_910",1250,"flag910");
	thread puerta_final("door1011","trig_1011",1500,"flag1011");
	thread electic_doors();
	thread arreglo_ai_navmesh();

}
function puerta_final(bloque_name,trig_name,pts,flag_name)
{
	
		bloque_a = getEnt(bloque_name + "a","targetname");
		bloque_b = getEnt(bloque_name + "b","targetname");
		bloque_c = getEnt(bloque_name + "c","targetname");
		trig = getEnt(trig_name,"targetname");
		trig SetHintString("You need activate all generators");
		trig SetCursorHint("HINT_NOICON");
		level waittill ("generator done");
		wait(2);
		level waittill ("generator done");
		wait(2);
		level waittill ("generator done");
		wait(2);
		level waittill ("generator done");
	
		thread playsoundok("challengecompletedid");
		IPrintLnBold("All generators has been activated");

		trig SetHintString("^2Hold [{+activate}] To Open It. ^3Cost:" + pts + "pts");
		trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		wait(0.1);
		trig waittill( "trigger", player );
		if (player.score >= pts)
			{
				player.score -= pts;
				flag::init(flag_name);
    			flag::set(flag_name);
    			level notify (flag_name);
    			bloque_a Delete();
    			bloque_b Delete();
    			bloque_c Delete();
    			trig Delete();
    			PlaySoundAtPosition("globoid",player.origin);

			}
	}

	
}
function puerta(bloque_name,trig_name,pts,flag_name)
{
	
	bloque_a = getEnt(bloque_name + "a","targetname");
	bloque_b = getEnt(bloque_name + "b","targetname");
	bloque_c = getEnt(bloque_name + "c","targetname");
	bloque_c DisconnectPaths(2,true);
	trig = getEnt(trig_name,"targetname");
	trig SetHintString("^2Hold [{+activate}] To Open It. ^3Cost:" + pts + "pts");
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		wait(0.1);
		trig waittill( "trigger", player );
		if (player.score > pts)
			{
				player.score -= pts;
				flag::init(flag_name);
    			flag::set(flag_name);
    			bloque_c ConnectPaths();
    			bloque_a Delete();
    			bloque_b Delete();
    			bloque_c Delete();
    			trig Delete();
    			PlaySoundAtPosition("globoid",player.origin);
			}
	}
}

function electic_doors()
{
	level waittill("power_on");
	level notify ("flag611");
	level notify ("flag311");
	level notify ("flag511");
	flag::init( "flag611" );
    flag::set("flag611");
    flag::init( "flag311" );
    flag::set("flag311");
    flag::init( "flag511" );
    flag::set("flag511");

	for(i=0;i<13;i++)
	{
		door[i] = getEnt("ed" + i,"targetname");
		door[i] Delete();
	}
}
//Rotar objetos (zeroy)
function rotate_fans()
{
	rotate_obj = getentarray("rotate_model","targetname");
	
	if(isdefined(rotate_obj))
		{
	 		for(i=0;i<rotate_obj.size;i++)
  				rotate_obj[i] thread rotate();
		}
}

function rotate()
{
	if (!isdefined(self.speed))
 		self.speed = 0.5;

	while(true)
		{
			if (self.script_noteworthy == "z")
  				self rotateYaw(360,self.speed);

  			else if (self.script_noteworthy == "z2")
  				self rotateYaw(-360,self.speed);

 			else if (self.script_noteworthy == "x")
  				self rotateRoll(360,self.speed);

 			else if (self.script_noteworthy == "y")
  				self rotatePitch(360,self.speed);

			wait ((self.speed)-0.1);
		}
}
//Rotar Objetos (mio)
function rotar()
{
	level flag::wait_till("initial_blackscreen_passed");
	thread rotalo("palosuperior","centro_palo1",5,360);
	thread rotalo("paloinferior","centro_palo2",3,-360);
	thread rotalo("palosuperior_clip","centro_palo1_clip",5,360);
	thread rotalo("paloinferior_clip","centro_palo2_clip",3,-360);
	thread rotalo("puerta1","centro_puerta1",3,-360);
	thread rotalo("puerta2","centro_puerta2",3,360);
	thread rotalo("puerta3","centro_puerta3",3,-360);
	thread rotalo("puerta4","centro_puerta4",3,360);
}

function rotalo(nombre,centro_nombre,velocidad,giro)
{
	objeto = getEnt(nombre, "targetname");
	centro = getEnt(centro_nombre, "targetname");
	objeto EnableLinkTo();
	objeto LinkTo(centro);
	while(1)
	{
		centro RotateYaw(giro,velocidad);
		wait ((velocidad)-0.1);
	}
}

//SETAS
function setas()
{
	level flag::wait_till("initial_blackscreen_passed");
	thread movimiento_setas("1",5,3);
	wait(1);
	thread movimiento_setas("3",6,4);
	thread movimiento_setas("2",2,3);
	wait(2);
	thread movimiento_setas("4",3,1);
}

function movimiento_setas(nombre,tiempo_arriba,tiempo_abajo)
{
	seta = getEnt("seta" + nombre, "targetname");
	seta_ = getEnt("seta_" + nombre, "targetname");
	seta_ EnableLinkTo();
	seta_ LinkTo(seta);  //Porque no le habia dado a AddSelectedBrushes en Radiant y se bugeaba
	while(1)
	{
		seta MoveZ(-60,2);
		wait(2);
		wait(tiempo_abajo);
		seta MoveZ(60,2);
		wait(2);
		wait(tiempo_arriba);
	}
}

//Barras
function barras()
{
	level flag::wait_till("initial_blackscreen_passed");
	thread movimiento_barra("barra1",5);
	wait(0.5);
	thread movimiento_barra("barra3",2);
	wait(0.5);
	thread movimiento_barra("barra5",3);
	wait(0.5);
	thread movimiento_barra("barra6",5);
	wait(0.5);
	thread movimiento_barra("barra4",2.5);
	wait(0.5);
	thread movimiento_barra("barra2",5);
}
function movimiento_barra(nombre,tiempo_movimiento)
{
	barra = getEnt(nombre, "targetname");
	while(1)
	{
		barra MoveY(-296,tiempo_movimiento);
		wait(tiempo_movimiento);
		barra MoveY(296,tiempo_movimiento);
		wait(tiempo_movimiento);
	}

}

//gravity zone
function gravity_zone()
{
	level flag::wait_till("initial_blackscreen_passed");
	SetDvar("doublejump_enabled", 1);
    SetDvar("wallrun_enabled", 1);
    SetGravity( 800 );
    thread is_gravity_zone();
	thread isnt_gravity_zone("isnt_gravity_zone1");
	thread isnt_gravity_zone("isnt_gravity_zone2");

	foreach(player in GetPlayers())
			{player thread check_gravity_zone();}

}
function is_gravity_zone()
{
	trig = getEnt("is_gravity_zone", "targetname");
	while(1)
	{
		trig waittill( "trigger", player );
		level notify ("IsGravityZone"+ player.playername);	
		player SetPlayerGravity(400);	
		WAIT_SERVER_FRAME;
	}
}
function isnt_gravity_zone(zona)
{
	trig = getEnt(zona, "targetname");
	while(1)
	{
		trig waittill( "trigger", player );
		level notify ("isntGravityZone" + player.playername);
		player SetPlayerGravity(800);
	player ClearPlayerGravity();
		player AllowWallRun(false);
		player AllowDoubleJump(false);
		player SetDoubleJumpEnergy(0);
		WAIT_SERVER_FRAME;
		

	}
}
function check_gravity_zone()
{
	self SetPlayerGravity(800);
	self ClearPlayerGravity();
	self AllowWallRun(false);
	self AllowDoubleJump(false);
	self SetDoubleJumpEnergy(0);
	self.vuelo = false;
	clientnumb = self.characterindex; 
	name = self.playername;
	trig = getEnt("is_gravity_zone", "targetname");
	//level waittill (name + "hasjetpack");
	while(1)
	{
		text = self.playername + " reload jetpack";
		level waittill (text); //espera recarga jetpack
		self thread tiempo_vuelo();
		wait(0.05);
		IPrintLnBold(level.texto[self]);
		while(level.vuelo[clientnumb] == true)
		{
			if (self IsTouching(trig))
			{
				level notify(self.playername);
				self SetPlayerGravity(400);
				self AllowWallRun(true);
				self SetDoubleJumpEnergy(100);
				self AllowDoubleJump(true);
			}
			else
			{
			self SetPlayerGravity(800);
	self ClearPlayerGravity();

			self AllowWallRun(false);
			self AllowDoubleJump(false);
			self SetDoubleJumpEnergy(0);
			}
			WAIT_SERVER_FRAME;
		}
	WAIT_SERVER_FRAME;
			


	}
	
}
function tiempo_vuelo()
{
	clientnumb = self.characterindex;
	level.vuelo[clientnumb] = true;
	level waittill (self.playername);
	self PlayLocalSound("start_jetpack");
	wait(5);
	IPrintLnBold(self.playername + " jetpack battery: 50%");
	wait(2.5);
	IPrintLnBold(self.playername + " jetpack battery: 25%");
	wait(2.5);
	level.vuelo[clientnumb] = false;
	IPrintLnBold(self.playername + " jetpack battery: 0%");
	self SetPlayerGravity(800);
	self ClearPlayerGravity();
	self AllowWallRun(false);
	self AllowDoubleJump(false);
	self SetDoubleJumpEnergy(0);
}

//jetpack
function jetpack()
{
	level.jetpack_parts = 0;
	thread jetpack_part("jetpack_part1","trig_jetpack1");
	thread jetpack_part("jetpack_part2","trig_jetpack2");
	thread jetpack_part("jetpack_part3","trig_jetpack3");
	thread jetpack_table();
}
function jetpack_part(name,trigger)
{
	model = getEnt(name , "targetname");
	trig = getEnt(trigger , "targetname");
	trig SetHintString("^2Hold [{+activate}] To pick up jetpack part");
	trig SetCursorHint("HINT_NOICON");
	trig waittill("trigger", player);
	thread playsoundok("monedaid");
	model Delete();
	trig Delete();
	level.jetpack_parts ++;
	if (level.jetpack_parts == 3)
	{
		level notify ("jetpack ready");
	}
}
function jetpack_table()
{
	model1 = getEnt("jetpack1" , "targetname");
	model2 = getEnt("jetpack2" , "targetname");
	model3 = getEnt("jetpack3" , "targetname");
	model1 SetInvisibleToAll();
	model2 SetInvisibleToAll();
	model3 SetInvisibleToAll();
	trig = getEnt("jetpack_table" , "targetname");
	trig SetHintString("Aditional jetpack parts Required");
	trig SetCursorHint("HINT_NOICON");
	level waittill ( "jetpack ready");

	trig SetHintString("^2Hold [{+activate}] To build the JETPACK");
	trig waittill("trigger", player);
	model1 SetVisibleToAll();
	model2 SetVisibleToAll();
	model3 SetVisibleToAll();

	wait(1);

	trig SetHintString("^2Hold [{+activate}] To Reload Jetpack ^5(JETPACK ONLY WORKS ON LOW GRAVITY ZONE)");
	while(1)
	{
		trig waittill("trigger", player);
		text = player.playername + " reload jetpack";
		IPrintLnBold(text);
		level notify(text);
	}

}
//bolas
function bolas()
{
	level flag::wait_till("initial_blackscreen_passed");
	n = 0.7;
	thread bola("1");
	wait(n);
	thread bola("4");
	wait(n);
	thread bola("3");
	wait(n);
	thread bola("2");
	wait(n);
	thread bola("5");
	wait(n);

}
function bola(i)
{
	model = getEnt("bola" + i, "targetname");
	cuerda = getEnt("cuerda" + i, "targetname");
	clip = getEnt("clip_bolas" + i, "targetname");
	eje = getEnt("centro_bola" + i, "targetname");
	model EnableLinkTo();
	model LinkTo(eje);
	cuerda EnableLinkTo();
	cuerda LinkTo(eje);
	clip EnableLinkTo();
	clip LinkTo(eje);
	eje RotatePitch(60,2,0.8,0.8);
	wait(1.9);
	while(1)
	{
		eje RotatePitch(-120,2,0.8,0.8);
		wait(1.9);
		eje RotatePitch(120,2,0.8,0.8);
		wait(1.9);

	}

}


//rampa
function rampa()//-670/6 = 111.5
{
	rampa = getEnt("rampa", "targetname");
	slick = getEnt("slick", "targetname");
	bandera_otra_cara = getEnt("bandera_otra_cara", "targetname");
	almas = getEnt("almas_rampa", "targetname");
	pathzombies = getEnt("pathzombies", "targetname");
	mono = getEnt("mono", "targetname");
	jaula = getEnt("jaula", "targetname");
	jaula_clip = getEnt("jaula_clip", "targetname");

	puente = getEnt("puente", "targetname");
	puente_centro = getEnt("puente_centro", "targetname");
	puente EnableLinkTo();
	puente LinkTo(puente_centro);
	puente_centro RotateRoll(-90,2,0.8,0.8);
	
	//rampa MoveZ(-670,0.1);
	//bandera_otra_cara MoveZ(-670,0.1);
	//almas MoveZ(-670,0.1);

	for (i = 1;i<7;i++)
	{
		level.grow_soul_start_scale = 0.1;//starting scale of model
		level.grow_soul_growth = 0.01;//growth per zombie
		level.grow_soul_size = 0.18;//how big you want it to get scale wise
		thread cargar_almas("almas_rampa");

		level waittill ("almas_rampa_allgrowsouls");
		
		almas PlaySound("monedaid");
		rampa MoveZ(111.5,2);
		mono MoveZ(111.5,2);
		jaula MoveZ(111.5,2);
		jaula_clip MoveZ(111.5,2);
		bandera_otra_cara MoveZ(111.5,2);
		almas MoveZ(111.5,2);
		slick MoveZ(111.5,2);
		wait(2);
	}
	puente_centro RotateRoll(90,2,0.8,0.8);
	flag::init( "flag67" );
    flag::set("flag67");
    level.grow_soul_start_scale = 0.1;//starting scale of model
	level.grow_soul_growth = 0.01;//growth per zombie
	level.grow_soul_size = 0.3;//how big you want it to get scale wise
	thread cargar_almas("almas_rampa");

	level waittill ("almas_rampa_allgrowsouls");
	jaula Delete();
	jaula_clip Delete();
	tapa = getEnt("tapa", "targetname");
	tapa Delete();
	almas Delete();

}

function cargar_almas(system)
{
		grow_soul::SetUpReward(system);  //esto es para activar las almas del pulsador 1
		grow_soul::WatchZombies();
}

//PUÑOS
function punos()
{
	level flag::wait_till("initial_blackscreen_passed");
	thread movimiento_punos("boxeo1","boxeo_clip1",62);
	thread movimiento_punos("boxeo2","boxeo_clip2",62);
	thread movimiento_punos("boxeo3","boxeo_clip3",-62);
	thread movimiento_punos("boxeo4","boxeo_clip4",-62);
}
function movimiento_punos(nombre_model,nombre_clip,movimiento) //62
{
	model = getEnt(nombre_model, "targetname");
	clip = getEnt(nombre_clip, "targetname");
	while(1)
	{
		model MoveX(movimiento,0.3);
		clip MoveX(movimiento,0.3);
		wait(0.3);
		wait(2);
		model MoveX(-movimiento,3);
		clip MoveX(-movimiento,3);
		wait(3);
		wait(5);
	}
}


/////////////////////////////////////////////////////////////////////////////
///////////////////GENERATORS GENERATORS GENERATORS ///////////////////////
/////////////////////////////////////////////////////////////////////////////
function generators()
{
	level flag::wait_till("initial_blackscreen_passed");
	thread generatorspeedcola();
	thread generatorstaminup();
	thread generatorjugger();
	thread generatordoubletap();
}
function generatorspeedcola()
{
	trig = getEnt("trig_sc","targetname");
	trig SetHintString("^2SPEED COLA GENERATOR ^5Challenge: ^1Hit both targets while you slide down.");
	trig SetCursorHint("HINT_NOICON");
	players = getplayers();
	foreach( player in players )
	{
		player thread challenge_dianas();
		player thread hit_diana1();
		player thread hit_diana2();
	}
	level waittill ("specialty_fastreload_power_on");
	level notify ("generator done");
	thread playsoundok("activate_attackable_win");
	generator = getEnt("generator_sc","targetname");
	generator PlayLoopSound("activate_attackable_loop");

}

function hit_diana1()
{
	trig = getEnt("diana1","targetname");
	slide2 = getEnt("slide2","targetname");
	slide1 = getEnt("slide1","targetname");
	while(1)
	{
		trig waittill( "damage", damage, player, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
			thread playsoundok("hitmarkerid");
			if ((player == self) && ((self IsTouching(slide1) || self IsTouching(slide2))))
			{				
				level notify(self.playername + "hit_diana");
				level.dianasdadas[self.characterindex] ++;
				wait(3);
				
			}
	}
}
function hit_diana2()
{
	trig = getEnt("diana2","targetname");
	slide2 = getEnt("slide2","targetname");
	slide1 = getEnt("slide1","targetname");
	while(1)
	{
		trig waittill( "damage", damage, player, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
			thread playsoundok("hitmarkerid");
			if ((player == self) && ((self IsTouching(slide1) || self IsTouching(slide2))))
			{				
				level notify(self.playername + "hit_diana");
				level.dianasdadas[self.characterindex] ++;
				wait(3);
				
			}
	}
}

function challenge_dianas()
{
	level.dianasdadas[self.characterindex] = 0;
	slide2 = getEnt("slide2","targetname");
	slide1 = getEnt("slide1","targetname");
	while(1)
	{
		while (self IsTouching(slide1) || self IsTouching(slide2))
		{
			
			if (level.dianasdadas[self.characterindex] == 2)
			{
				level notify( "specialty_fastreload_power_on" );
				
			}
			WAIT_SERVER_FRAME;
			
		}
		level.dianasdadas[self.characterindex] = 0;
		WAIT_SERVER_FRAME;

	}
}


//////////////////////////////////////////////////////////

function generatorstaminup()
{
	trig = getEnt("trig_su","targetname");
	trig SetHintString("^2STAMIN UP GENERATOR ^5Challenge: ^1Hold [{+activate}] to start, cross the platform without falling into the water and come back and press [{+activate}] again ");
	trig SetCursorHint("HINT_NOICON");
	players = getplayers();
	foreach( player in players )
	{
		player thread caeagua("water1");
		player thread caeagua("water2");
		player thread cruzapuente();
		player thread pulsador_su(trig);
	}
	thread su_complete();
	while (1)
	{
		trig waittill( "trigger", player ); 
		thread doing_su_challenge(player);
		level.isdoingchallenge = player;
		thread start_crono(player,trig);
		level waittill ("reto inactivo");
		
	}
}
function doing_su_challenge(player)
{
	
	self endon ("reto inactivo");
	level waittill (player.playername + "otro_lado");
	level waittill (player.playername + "boton");
	level notify ("specialty_staminup_power_on");


}
function start_crono(player,trig)
{
	self endon ("reto inactivo");
	for (i = 10;i>0;i--)
		{
			IPrintLnBold(player.playername + " has " + i + " seconds left");
			wait(1);
		}
		IPrintLnBold("Time Over");
	level notify ("reto inactivo");

	
}
function cruzapuente()
{
	otro_lado = getEnt("otro_lado","targetname");
	otro_lado SetCursorHint("HINT_NOICON");
	while(1)
	{
		if (self IsTouching(otro_lado)) 
		{
			level notify(self.playername + "otro_lado");
		}
		WAIT_SERVER_FRAME;

	}
}
function caeagua(trigger)
{
	trig = getEnt(trigger,"targetname");
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		WAIT_SERVER_FRAME;
		if ((self IsTouching(trig)) && (level.isdoingchallenge == self))
		{
			level notify ("reto inactivo");
		}
	}
}
function pulsador_su(trig)
{
	
	while(1)
	{
		WAIT_SERVER_FRAME;
		trig waittill( "trigger", player ); 
		if (player == self)
		{
			level notify(player.playername + "boton");
		}
	}
}

function su_complete()
{
	level waittill ("specialty_staminup_power_on");
	level notify ("generator done");
	thread playsoundok("activate_attackable_win");
	generator = getEnt("generator_su","targetname");
	generator PlayLoopSound("activate_attackable_loop");
}

//////////////////////////////////////////////////////////

function generatordoubletap()
{
	trig = getEnt("trig_dt","targetname");
	trig SetHintString("^2DOUBLE TAP GENERATOR ^5Challenge: ^1Hold [{+activate}] to start, and collect all coins ");
	trig SetCursorHint("HINT_NOICON");
	level.numero_intentos_dt = 0;
	thread dt_complete();
	for (i = 1;i<8;i++)
					{
						moneda[i] = getEnt("moneda_" + i,"targetname");
						moneda[i] SetInvisibleToAll();
						trig[i] = getEnt("trig_moneda_" + i,"targetname");
						trig[i] SetCursorHint("HINT_NOICON");
					}
	while (1)
	{
		trig waittill( "trigger", player ); 
		thread doing_dt_challenge(player);
		level.isdoing_dt_challenge = player;
		thread start_crono_dt(player);
		level waittill ("end_dt_time");
		for (i = 1;i<8;i++)
					{
						moneda[i] = getEnt("moneda_" + i,"targetname");
						moneda[i] SetInvisibleToAll();
						trig[i] = getEnt("trig_moneda_" + i,"targetname");
					}
		
	}
}
function doing_dt_challenge(player)
{
	self endon ("end_dt_time");
	level.coins_recolected = 0;
	for (i = 1;i<8;i++)
					{
						moneda[i] = getEnt("moneda_" + i,"targetname");
						trig[i] = getEnt("trig_moneda_" + i,"targetname");
						moneda[i] SetVisibleToAll();
						thread coin_function(moneda[i],trig[i]);
					}
	while(1)
	{
		if (level.coins_recolected >=7)
		{
			level notify( "doubletap_on" );
			level notify ("end_dt_time");
		}
		WAIT_SERVER_FRAME;
	}
}
function coin_function(moneda,trig)
{
	self endon ("end_dt_time");
	while(1)
	{
		trig waittill( "trigger", player ); 
		if (player == level.isdoing_dt_challenge)
		{
			level.coins_recolected ++;
			PlaySoundAtPosition("monedaid", player.origin);
			moneda SetInvisibleToAll();
			break;

		}
	}
}
function start_crono_dt(player)
{
	self endon ("end_dt_time");
	level.numero_intentos_dt ++;

	for (i = 10;i>0;i--)
		{
			IPrintLnBold(player.playername + " has " + i + " seconds left");
			wait(1.05);
		}
		IPrintLnBold("Time Over");
	if (level.numero_intentos_dt>3)
	{
		IPrintLnBold("TIP: Try without jumping, just run following the correct direction.");
	}
	level notify ("end_dt_time");

	
}

function dt_complete()
{
	level waittill ("doubletap_on");
	level notify ("generator done");
	thread playsoundok("activate_attackable_win");
	generator = getEnt("generator_dt","targetname");
	generator PlayLoopSound("activate_attackable_loop");
}

//////////////////////////////////////////////////////////

function generatorjugger()
{
	trig = getEnt("trig_jug","targetname");
	trig SetHintString("^2JUGGERNOG GENERATOR ^5Challenge: ^1All players must sourvive together an entire round in this blue floor zone");
	trig SetCursorHint("HINT_NOICON");
	players = getplayers();
	foreach( player in players )
	{
		player thread check_zone_jug();
	}
	thread jug_complete();
	while(1)
	{
		level waittill("start_of_round");
		thread mision_jug();
	}
}
function check_zone_jug()
{
	trig1 = getEnt("zona_mision_1","targetname");
	trig1 SetCursorHint("HINT_NOICON");
	trig2 = getEnt("zona_mision_2","targetname");
	trig2 SetCursorHint("HINT_NOICON");
	while(1)
	{
		WAIT_SERVER_FRAME;
		if ((self IsTouching(trig1)) || (self IsTouching(trig2)))
		{
			WAIT_SERVER_FRAME;
		}
		else
		{
			level notify("jug_mision_fail");
		}
	}
}

function mision_jug()
{
	self endon ("jug_mision_fail");
	level waittill ("end_of_round");
	level notify( "specialty_armorvest_power_on" );
}

function jug_complete()
{
	level waittill ("specialty_armorvest_power_on");
	level notify ("generator done");
	thread playsoundok("activate_attackable_win");
	generator = getEnt("generator_jug","targetname");
	generator PlayLoopSound("activate_attackable_loop");
}

////////////////////////////////////////////////////////////////////////////////
//////////////////////LUZ LUZ LUZ/////////////////////////////////////&/
////////////////////////////////////////////////////////////

function desafio_power()
{
	trig = getEnt("trig_power","targetname");
	trig SetHintString("^2Hold [{+activate}] To Open Black Doors ^3(Survive 1 min)");
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player ); 
		if( trig doorAllPlayersPresent() )
				{
					trig SetHintString("Survive");
					level notify ("test_power_on");
					thread banda_sonora("wipeout_soundtrack","power_on");
					level.infinite_spawn_on = true; 
					thread spawn_infinite_zombies();
					IPrintLnBold("Sourvive!");
					wait(35);
					IPrintLnBold("30 seconds to end");
					wait(20);
					IPrintLnBold("10 seconds to end");
					wait(10);
					IPrintLnBold("Objetive Comleted");
					level.infinite_spawn_on = false;


					trig Delete();
					trig = getEnt("trig_power","targetname");
					for (i = 1;i<16;i++)
					{
						puerta[i] = getEnt("puerta_final" + i,"targetname");
						Puerta[i] Delete();
					}
					//thread playsoundok("challengecompletedid");

					palanca = getEnt("palanca_power","targetname");
					centro = getEnt("giro_palanca_power","targetname");
					palanca EnableLinkTo();
					palanca LinkTo(centro);
					palanca RotateRoll(90,2,0.8,0.8);
					level notify ("all doors opened");
					level notify( "specialty_additionalprimaryweapon_power_on" );
					level notify( "specialty_widowswine_power_on" );
					level notify( "specialty_electriccherry_power_on" );
					level notify( "specialty_bloodwolf_zombies_power_on" );
					flag::init( "power_on" ); 
    				flag::set("power_on");
    				/*flag::init( "flag311" ); 
    				flag::set("flag311");
    				flag::init( "flag511" ); 
    				flag::set("flag511");
    				flag::init( "flag611" ); 
    				flag::set("flag611");*/
					break;


					
				}
				else
				{
					trig SetHintString( "All Players Must Be Nearby" ); 
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


function spawn_infinite_zombies()
{
    spawner = GetEnt("zombie_spawner","script_noteworthy");

        while(level.infinite_spawn_on == true)
            {

            while(level.infinite_spawn_on == true && zombie_utility::get_current_zombie_count() <= level.zombie_actor_limit)
                    {

                                
                                zombie = zombie_utility::spawn_zombie( spawner );
                                zombie.is_spawned = true;
                                wait 1;         

                    }
                wait 0.1;

            }

    a_zombies = getAITeamArray( level.zombie_team );
        foreach(ai in a_zombies)
        {
            if(isdefined(ai.is_spawned))
            {
                ai DoDamage(ai.health + 666,ai.origin);
                ai thread zombie_death::flame_death_fx();

            }
            wait 0.05;
        }
         
}


//////////////////////////////////////////////////////////////////////
//////////////PAP RACE        PAP RACE        PAP RACE ///////////////
//////////////////////////////////////////////////////////////////////

function pap_race()
{
	start_circle = getEnt("race_start","targetname");
	start_circle SetInvisibleToAll();
	trig = getEnt("start_race_trigger","targetname");
	trig SetHintString("^3Hold [{+activate}] To Start Time Trial (Complete the circuit following the arrows) ");
	trig SetCursorHint("HINT_NOICON");
	trig SetInvisibleToAll();

	for (i = 1;i<14;i++)
					{
						flecha[i] = getEnt("ruta_" + i,"targetname");
						trig[i] = getEnt("trig_ruta_" + i,"targetname");
						flecha[i] SetInvisibleToAll();
						trig[i] SetInvisibleToAll();
					}

	level waittill ("all doors opened");
	level waittill("end_of_round");
	start_circle SetVisibleToAll();
	trig SetVisibleToAll();
	level.carrera_done = false;

	while(1)
	{
		trig SetHintString("^3Hold [{+activate}] To Start Time Trial (Complete the circuit following the arrows) ");
		trig waittill( "trigger", player );
		trig SetHintString(player.playername + " is racing!");
		IPrintLnBold(player.playername + " is racing!");
		numero= 70;
		thread comienzo_carrera(player);
	
		while(1)
		{
			wait(1);
			numero --;
			IPrintLnBold(numero + " seconds left");
			if (level.carrera_done == true)
			{break;}
			if (numero == 0)
			{
				level notify ("race_fail");
				break;
			}
	
		}
		if (level.carrera_done == true)
			{break;}
	
	}
	trig Delete();
	start_circle SetInvisibleToAll();


}

function comienzo_carrera(player_race)
{
	self endon ("race_fail");
	thread banda_sonora("wipeout_song","race_fail");
	for (i = 1;i<14;i++)
					{
						flecha[i] = getEnt("ruta_" + i,"targetname");
						trig[i] = getEnt("trig_ruta_" + i,"targetname");
						flecha[i] SetInvisibleToAll();
						trig[i] SetInvisibleToAll();
					}
	for (i = 1;i<14;i++)
					{
						flecha[i] SetVisibleToAll();
						trig[i] SetVisibleToAll();
						while(1)
						{
							trig[i] waittill( "trigger", player );
							if (player == player_race)
							{break;}
						}

						flecha[i] SetInvisibleToAll();
						trig[i] SetInvisibleToAll();
						thread playsoundok("monedaid");
					}
	level.carrera_done = true;
	IPrintLnBold("Congratulations! PAP Unlocked!");
	pap_box = getEnt("caja_pap" ,"targetname");
	pap_box Delete();
	level notify ("pap_unlocked");
	level notify ("race_fail"); //para parar la musica
	thread playsoundok("challengecompletedid");

}

////////////////////////////////////////////////////////////////////////////
///////////////////// CHALLENGES  CHALLENGES  CHALLENGES ///////////////////
////////////////////////////////////////////////////////////////////////////

function challenges()
{
	level flag::wait_till("initial_blackscreen_passed");
	thread rotar_botellas("bot","bot_centro",2,360);
	thread rotalo("mini","mini_centro",4,360);

	thread desafio_deagle();
	thread desafio_ranger();
	
}
function rotar_botellas(nombre,centro_nombre,velocidad,giro)
{
	
	centro = getEnt(centro_nombre, "targetname");
	for (i = 1;i<7;i++)
	{
		objeto[i] = getEnt(nombre + i, "targetname");
		objeto[i] EnableLinkTo();
		objeto[i] LinkTo(centro);
	}
	
	while(1)
	{
		centro RotateYaw(giro,velocidad);
		wait ((velocidad)-0.1);
	}
}
function desafio_deagle()
{
	trig = getEnt("trig_perks", "targetname");
	
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString("Come back Later"); 
	level waittill ("pap_unlocked");
	level waittill("end_of_round");

	foreach(player in getplayers() )
        {
        	player thread kill_count(50,"h1_deagle","h1_deagle_rdw_up","Deasert Eagle Challenge Done",trig," enemies with Desert Eagle(You can PAP it)");
        }
        level waittill ("Deasert Eagle Challenge Done");
        level.challengescompleted ++;
        if (level.challengescompleted == 2)
        {
        	level notify("desafios_hechos");
        }
        trig SetHintString("Press and Hold ^3&&1^7 to get Free Perkaholic"); 
        while(1)
        {
        	trig SetHintString("Press and Hold ^3&&1^7 to get Free Perkaholic"); 
			trig waittill("trigger", player);
			/*player zm_perks::give_perk(PERK_ELECTRIC_CHERRY);
			player zm_perks::give_perk(PERK_DOUBLETAP2);
			player zm_perks::give_perk(PERK_ADDITIONAL_PRIMARY_WEAPON);
			player zm_perks::give_perk(PERK_QUICK_REVIVE);
			player zm_perks::give_perk(PERK_SLEIGHT_OF_HAND);
			player zm_perks::give_perk(PERK_STAMINUP);
			player zm_perks::give_perk(PERK_JUGGERNOG);
			player zm_perks::give_perk(PERK_DEAD_SHOT);
			player zm_perks::give_perk(PERK_WIDOWS_WINE);*/
			player bgb::give( "zm_bgb_perkaholic" );
        }
}
function desafio_ranger()
{
	trig = getEnt("trig_mini", "targetname");
	
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString("Come back Later"); 
	level waittill ("pap_unlocked");
	level waittill("end_of_round");

	foreach(player in getplayers() )
        {
        	player thread kill_count(50,"h1_ranger_rdw","h1_ranger_rdw_up","Ranger Challenge Done",trig," enemies with Ranger(You can PAP it)");
        }
        level waittill ("Ranger Challenge Done");
        level.challengescompleted ++;
        if (level.challengescompleted == 2)
        {
        	level notify("desafios_hechos");
        }
        trig SetHintString("Press and Hold ^3&&1^7 to get M134 MINIGUN (It Take your current weapon)"); 
        while(1)
		{
			trig SetHintString("Press and Hold ^3&&1^7 to get M134 MINIGUN (It Take your current weapon)");
			trig waittill("trigger", player);
		
			player TakeWeapon(player GetCurrentWeapon());
			player zm_weapons::weapon_give(getweapon("h1_minigun"));
		}
}

function kill_count(num_objetivo,nombre_arma,nombre_arma_mejorada,notificacion,trig,txt_trig)
{
	level.kill_objetivo_count[nombre_arma] = num_objetivo;
	trig SetHintString("Kill " + level.kill_objetivo_count[nombre_arma] + txt_trig );
	arma = GetWeapon(nombre_arma);
	nombre_arma_up = nombre_arma + "_up";
	arma_up = GetWeapon(nombre_arma_mejorada);
	while(1)
	{
		self waittill("zom_kill");
		arma_actual = self GetCurrentWeapon();
		
		if ((arma == arma_actual)||(arma_up == arma_actual))
		{
			level.kill_objetivo_count[nombre_arma] --;
			trig SetHintString("Kill " + level.kill_objetivo_count[nombre_arma] + txt_trig);
			
			if(level.kill_objetivo_count[nombre_arma] <=0)
			{
				IPrintLnBold(notificacion);
				level notify (notificacion);
				break;
			}
			//IPrintLnBold(level.kill_objetivo_count[nombre_arma]);
		}
		
	}
}



//////////////////////////////////////////////////////////////////////////
////////////////////////// FINAL CHALLENGE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////

function final_challenge()
{
	for (i = 0;i<7;i++)
	{
		bandera[i]	= getEnt("banderin_" + i, "targetname");
		suelo[i] = getEnt("suelob_" + i, "targetname");
		bandera[i] SetInvisibleToAll();
		suelo[i] SetInvisibleToAll();
		trig[i] = getEnt("tb_" + i, "targetname");
		trig[i] SetCursorHint("HINT_NOICON");
		trig[i] SetHintString(""); 
		trig[i] SetInvisibleToAll();
		info[i] = getEnt("info" + i, "targetname");
		info[i] SetInvisibleToAll();
		info[i] MoveZ(-400,0.1);
	}
	level waittill ("desafios_hechos");
	level waittill ("end_of_round");
	bandera[0] SetVisibleToAll();
	trig[0] SetVisibleToAll();
	trig[0] SetHintString("^3Hold [{+activate}] to take the flag. Find where you can plant it. ^5 INFINITE ZOMBIES WILL SPAWN"); 
	trig[0] waittill("trigger", player);
	trig[0] SetInvisibleToAll();
	bandera[0] SetInvisibleToAll();
	level.infinite_spawn_on = true; 
	thread spawn_infinite_zombies();
	for (i = 1;i<7;i++)
	{
		trig[i] SetVisibleToAll();
		trig[i] SetHintString("Hold [{+activate}] to plant the flag");
		suelo[i] SetVisibleToAll(); 
		PlayFX("dlc4/genesis/fx_summon_circle_rune_glow",suelo[i].origin);
		trig[i] waittill("trigger", player);
		bandera[i] SetVisibleToAll();
		trig[i] SetHintString("Charge it with souls");

		level.grow_soul_start_scale = 1;//starting scale of model
		level.grow_soul_growth = 0.01;//growth per zombie
		level.grow_soul_size = 1.4;//how big you want it to get scale wise
		almas = ("banderin_" + i);
		thread cargar_almas(almas);
		mensaje = (almas + "_allgrowsouls");
		level waittill (mensaje);
		IPrintLnBold("Take a breath, ZOMBIE SPAWNS OFF");

		level.infinite_spawn_on = false; 
		zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
    	//Stop Spawning
    	level flag::clear( "spawn_zombies" );
    	wait(0.5);
    	thread playsoundok("estatuasid");
    	info[i] SetVisibleToAll();
    	info[i] MoveZ(400,3);
		trig[i] SetHintString("^3Hold [{+activate}] to take the flag. Find where you can plant it. ^5 INFINITE ZOMBIES WILL SPAWN");
		trig[i] waittill("trigger", player);
		bandera[i] Delete();
		suelo[i] Delete();
		trig[i] Delete();

		//Start zombies spawn
		level flag::set( "spawn_zombies" );
		level.infinite_spawn_on = true; 
		thread spawn_infinite_zombies();
	}
	suelo[0] SetVisibleToAll();
	trig[0] SetVisibleToAll();
	trig[0] SetHintString("^3Hold [{+activate}] to plant the flag"); 
	trig[0] waittill("trigger", player);
	level notify("end open");
	bandera[0] SetVisibleToAll();
	while(1)
	{
		trig[0] SetHintString("^3Hold [{+activate}] to STOP ZOMBIE SPAWNS. So you can read posters");
		trig[0] waittill("trigger", player); 
		level.infinite_spawn_on = false; 
		zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
    	//Stop Spawning
    	level flag::clear( "spawn_zombies" );
    	trig[0] SetHintString("^3Hold [{+activate}] to SPAWN INFINITE ZOMBIES AGAIN.");
    	trig[0] waittill("trigger", player); 
    	//Start zombies spawn
		level flag::set( "spawn_zombies" );
		level.infinite_spawn_on = true; 
		thread spawn_infinite_zombies();
	}
}

/////////////////////////////////////////////////
////////////OTROS ///////////////////////////
/////////////////////////////////////////////
function banda_sonora(sound,end_song)
{
	sound_location	= getEnt("sound_location", "targetname");

	level.playSoundLocation PlaySound(sound);
	players = GetPlayers();
		for (i = 0;i<players.size;i++)

		{
		players[i] PlayLocalSound(sound);}
	level waittill(end_song);

	for (i = 0;i<players.size;i++)

		{
		players[i] StopLocalSound(sound);}
	
}
function end_of_round()
{
	/*while(1)
	{
		level waittill ("end_of_round");
		level playsoundok("ms")
	}*/
}

function arreglo_ai_navmesh()
{/*
	suelo = getEnt("suelo", "targetname");	
	sueloa = getEnt("sueloa", "targetname");
	suelo Solid();
	//suelo MoveZ(150,0.3);
	level waittill("power_on");
	//suelo MoveZ(-150,0.3);
	suelo NotSolid();
	wait(0.5);
	suelo ConnectPaths();*/
	thread eliminar("desbio_511","flag1011");
	thread eliminar("desbio_311","flag1011");
	thread eliminar("desbio_extra","flag1011");
	thread eliminar("desbio_16","flag16");
}
function eliminar(model,flag)
{
	level waittill(flag);
	modelo = getEnt(model, "targetname");
	modelo Delete();
}

function bajo_mapa()
{
	    
		trig = getEnt("bajo_mapa", "targetname");

	  	while(1)
	  	{
	 
	  		 trig waittill("trigger", player);
	  		 	wait(1.5);
	  		 	
	  		 	player thread bajo_mapa_teleport();
	  	      
       	}
}
function bajo_mapa_teleport()
{
				respawn = struct::get("bajo_mapa_respawn", "targetname");
	            self setorigin( respawn.origin );
        		self setplayerangles( respawn.angles );
        		self FreezeControls(true);
       			 wait(1);
       			 self FreezeControls( false );
       			
}


function spawn_sped()
{
    level waittill( "start_of_round" );
    wait(1);
    level waittill( "start_of_round" );
    level waittill( "end_of_round");
    IPrintLnBold("FROM NOW, ZOMBIES ARE GOING TO SPRINT!");
    level.zombie_init_done = &mpjw_make_sprinter;
}

function mpjw_make_sprinter()
{
    if ( isDefined( level.ptr_zombie_init_done ) )
        self [ [ level.ptr_zombie_init_done ] ]();
    
    self zombie_utility::set_zombie_run_cycle( "sprint" ); //"walk" "run" "sprint"
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


	level.challengescompleted =0;
	level waittill ("end open");

	IPrintLnBold("Now you can find the end of the map");
	thread playsoundok("challengecompletedid");
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

