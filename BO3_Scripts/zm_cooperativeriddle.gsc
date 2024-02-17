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
#using scripts\zm\_zm_laststand;

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

#using scripts\zm\_zm_perks;
#insert scripts\zm\_zm_perks.gsh;
#using scripts\zm\_zm_perk_electric_cherry;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\zm\_zm_score;

//Powerups
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
#using scripts\zm\_zm_powerup_weapon_minigun;

//Custom Box
#using scripts\zm\_hb21_zm_magicbox;
#using scripts\zm\_zm_magicbox;

//Traps
#using scripts\zm\_zm_trap_electric;

//TELEPORT
#using scripts\shared\lui_shared;

//GROWING SOULBOX
#using scripts\zm\growing_soulbox;

//PARASITOS
#using scripts\zm\_zm_ai_wasp;

// NSZ Brutus
#using scripts\_NSZ\nsz_brutus;

//karosel
#using scripts\zm\weapon_karosel;

#using scripts\zm\zm_usermap;



//FX
#precache( "fx", "dlc1/castle/fx_fire_barrel_castle" );
//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{
	//PARASITOS
	level.dog_rounds_allowed = false;
	zm_ai_wasp::init();


	zm_usermap::main();

	//PARASITOS
	zm_ai_wasp::enable_wasp_rounds(); //para rondas normales
	// NSZ Brutus
	brutus::init(); 

	level._zombie_custom_add_weapons =&custom_add_weapons;
	
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	level.pathdist_type = PATHDIST_ORIGINAL;

	//GROW_SOUL
	grow_soul::init(  );

	//TELEPORT ZOMBIES
	thread teleport_zombies_init();
	//SCRIPTS MAPA
	level.player_starting_points = 500;
	level.perk_purchase_limit = 20;
	level.using_solo_revive = 1; //quick revive funciona siempre como para solo
	thread inventario_de_jugadores();
	thread zona_inicial();
	thread zona1();//objetos
	thread zona2();
	thread zona3(); //estatuas
	thread zona4();
	thread zona5(); //piano
	thread zone6(); //zona final
	thread map_completed();

	thread caida_jugador();
	
	//cargar FX
	thread cargar_fx();

	// set power ON
	thread set_power_ON();
	//EZ MODE
	thread activate_ez_mode();

	 //CUSTOM PACK A PUNCH CAMO
    level.pack_a_punch_camo_index = 138; 
    thread credit();

	//karosel
	weap_kar::init(  );

	level zm_perks::spare_change();
	thread perkmachine("trig_jg1","PERK_JUGGERNOG",2500,"Juggernog","specialty_armorvest");
	thread perkmachine("trig_dt1","DOUBLETAP2",2000,"Double Tap","specialty_doubletap2");
	thread perkmachine("trig_jg2","PERK_JUGGERNOG",2500,"Juggernog","specialty_armorvest");
	thread perkmachine("trig_dt2","DOUBLETAP2",2000,"Double Tap","specialty_doubletap2");
	thread perkmachine("trig_sc1","PERK_SLEIGHT_OF_HAND",3000,"Speed Cola","specialty_fastreload");
	thread perkmachine("trig_sc2","PERK_SLEIGHT_OF_HAND",3000,"Speed Cola","specialty_fastreload");
	thread perkmachine("trig_su1","PERK_STAMINUP",2000,"Stamin Up","specialty_staminup");
	thread perkmachine("trig_su2","PERK_STAMINUP",2000,"Stamin Up","specialty_staminup");
}

function usermap_test_zone_init()
{
	zm_zonemgr::add_adjacent_zone("start_zone","zone2","startflag");
	zm_zonemgr::add_adjacent_zone("zone2","zone3","zone3flag");
	zm_zonemgr::add_adjacent_zone("zone3","zone4","zone4flag");
	zm_zonemgr::add_adjacent_zone("zone4","zone5_1","zone5flag");
	zm_zonemgr::add_adjacent_zone("zone5_2","zone5_1");
	zm_zonemgr::add_adjacent_zone("zone5_2","zone5_3");
	zm_zonemgr::add_adjacent_zone("zonefalse","zone5_1","zone6flag");
	zm_zonemgr::add_adjacent_zone("zonefalse","zone6");

	level flag::init( "always_on" );
	level flag::set( "always_on" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}


//funciones
 function credit()
{
	level flag::wait_till("initial_blackscreen_passed");
	iprintlnbold("This map was created by DonAndres_666, Enjoy!"); 
	  wait(3);
	iprintlnbold("You can adjust the volume of music on the options menu, sound, music volume.");
}
function set_power_ON()
{
	flag::init( "power_on" ); 
    flag::set("power_on");

    flag::init( "startflag" ); 
    flag::set("startflag");

    level flag::wait_till("initial_blackscreen_passed");

	////////////////////// TESTEO ////////////////////////////////////////////
      //   level notify ("acertijo_1_resuelto");
     //    level notify ("acertijo_2_resuelto");
     //     level notify ("iniciarzona2"); 		////para testear
    //      level notify ("start_zone3");
     //   level notify ("start_zone4");
     //    level notify ("start_zone5");
      //   level notify ("acertijo_5_resuelto");
	////////////////////// TESTEO /////////////////////////////////////////
}
function apply_fire_sale_to_chest()
{
	// if we're using the elaborate chest-leaving anims, wait for it to be over before showing the chest again
	if(self.zbarrier GetZBarrierPieceState(1) == "closing")
	{
		while(self.zbarrier GetZBarrierPieceState(1) == "closing")
		{
			wait (0.1);
		}
		self.zbarrier waittill("left");
	}
	
	wait 0.1; // need extra wait to be able to correctly set the zbarrier
	
	self thread zm_magicbox::show_chest();
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



function cargar_fx()
{
	level.effect["fuego"] = "dlc1/castle/fx_fire_barrel_castle";
}
function ShouldTakeGun(){
	wSize = self GetWeaponsListPrimaries().size;
	if(wSize<2) return false;
	if(wSize<3 && self HasPerk("specialty_additionalprimaryweapon")) return false;
	return true;
}

function give_this_weapon(weapon,player)
{
    if(!player HasWeapon(weapon)){
			if(player thread ShouldTakeGun()) player TakeWeapon(player GetCurrentWeapon());
			player GiveWeapon(weapon);
			player SwitchToWeapon(weapon);
			player zm_weapons::weapon_give(getweapon(weapon));
		}else{
			player GiveMaxAmmo(weapon);
			player SwitchToWeapon(weapon);
		}
	

}

function cargar_almas(system)
{
	if (level.EZmodeON == false)
	{
		grow_soul::SetUpReward(system);  //esto es para activar las almas del pulsador 1
		grow_soul::WatchZombies();
	}
}

function inventario_de_jugadores()
{
	level flag::wait_till("initial_blackscreen_passed");
	player = GetPlayers();
	level.player0name = player[0].playername;
	level.player1name = player[1].playername;
	level.player2name = player[2].playername;
	level.player3name = player[3].playername;

	level.player0have = "nothing";
	level.player1have = "nothing";
	level.player2have = "nothing";
	level.player3have = "nothing";

}

function player_can_take_item(itemname,model,trig) 

{
	while(1)
	{

	trig waittill("trigger", player);	
	if (player.playername == level.player0name)
	{
		if (level.player0have == "nothing")
		{
			level.player0have = itemname;
			IPrintLnBold(player.playername, " took a new item:");
			IPrintLnBold(level.player0have);
			model SetInvisibleToAll();
			trig SetInvisibleToAll();
			break;
		}
		else
		{
			IPrintLnBold(player.playername, " allready has another item.");
		}
	}
	if (player.playername == level.player1name)
	{
		if (level.player1have == "nothing")
		{
			level.player1have = itemname;
			IPrintLnBold(player.playername, "took a new item:");
			IPrintLnBold(level.player1have);
			model SetInvisibleToAll();
			trig SetInvisibleToAll();
			break;
		}
		else
		{
			IPrintLnBold(player.playername, " allready has another item.");
		}
	}
	if (player.playername == level.player2name)
	{
		if (level.player2have == "nothing")
		{
			level.player2have = itemname;
			IPrintLnBold(player.playername, "took a new item:");
			IPrintLnBold(level.player2have);
			model SetInvisibleToAll();
			trig SetInvisibleToAll();
			break;
		}
		else
		{
			IPrintLnBold(player.playername, " allready has another item.");
		}
	}
	if (player.playername == level.player3name)
	{
		if (level.player3have == "nothing")
		{
			level.player3have = itemname;
			IPrintLnBold(player.playername, "took a new item:");
			IPrintLnBold(level.player3have);
			model SetInvisibleToAll();
			trig SetInvisibleToAll();
			break;
		}
		else
		{
			IPrintLnBold(player.playername, " allready has another item.");
		}
	}

	}

}
function playsoundok(sound)
{
	level.playSoundLocation PlaySound(sound);
	players = GetPlayers();
		for (i = 0;i<players.size;i++)

		{
		players[i] PlayLocalSound(sound);
		}
}

function teleport_to(destination_name)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destination = struct::get(destination_name, "targetname" ); 
	

        self setorigin( destination.origin );
        self setplayerangles( destination.angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}

function activate_ez_mode()
{
	level.EZmodeON = false;
	trig = getEnt("trig_ez", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to activate EZ MODE (no zombies)"); 
	trig SetCursorHint("HINT_NOICON");
	trig waittill("trigger", player);
	IPrintLnBold("EZ MODE was activated, Zombies has been disabled.")
	SetHintString( "EZ MODE was activated, Zombies has been disabled."); 
	//Clear zombies
    zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
    //Stop Spawning
    level flag::clear( "spawn_zombies" );


    level.EZmodeON = true;
    level notify ("grow_soul1_allgrowsouls");
}
function teleport_zombies_init()
	{
		teleport_trig = GetEntArray( "teleport_zombies", "targetname" );
		for (i = 0; i < teleport_trig.size; i++)
		{
			teleport_trig[i] thread teleport_zombies();
		}
	}

	function teleport_zombies()
	{
		teleport_destination = GetEnt( self.target, "targetname" );
		while(1)
		{
			zombs = getaispeciesarray("axis","all");
			for(k=0;k<zombs.size;k++)
			{
				if( zombs[k] IsTouching( self ) )
				{
					zombs[k] ForceTeleport( teleport_destination.origin );
				}
			}
			wait(0.01);
		}
	}
/////////////////////////////////////////////////////////////////
//////////////ZONA INICIAL    ZONA INICIAL   //////////////////////////
/////////////////////////////////////////////////////////////////
function zona_inicial()
{
	thread dar_arma("pistol_burst","rk5");
	thread dar_arma("ar_marksman","sheiva");
	thread dar_arma("shotgun_pump","KRM-262");
	thread broma_raygun();
	thread repartir_jugadores();
	thread monkey();
}
function dar_arma(weap,nombre_arma)
{
	trig = getEnt(nombre_arma, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take weapon"); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		
		player TakeWeapon(player GetCurrentWeapon());
		player zm_weapons::weapon_give(getweapon(weap));
	}
	
}
function broma_raygun()
{
	trig = getEnt("raygun", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take weapon"); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		thread playsoundok("risasid");
		wait(5);
	}
	
}

function repartir_jugadores()
{
	level flag::wait_till("initial_blackscreen_passed");

		thread teleports_1_jugador_primer_reto("trig_1p_1","model_1p_1","dest_1p_1");
		thread teleports_1_jugador_primer_reto("trig_1p_2","model_1p_2","dest_1p_2");
		thread teleports_1_jugador("trig_1p_3","model_1p_3","dest_1p_3");
		thread teleports_1_jugador("trig_1p_4","model_1p_4","dest_1p_4");
		thread teleports_1_jugador("trig_1p_5","model_1p_5","dest_1p_5");
		thread teleports_1_jugador("trig_1p_6","model_1p_6","dest_1p_6");


	wait(2);
	players = GetPlayers();
	numb_players = players.size;
	if (numb_players == 1)
	{
		thread modo_1_jugador();
		level notify ("es 1 jugador");
		model1 = getEnt("model_1p_1", "targetname");
		model2 = getEnt("model_1p_2", "targetname");

			model1 SetVisibleToAll();
			model2 SetVisibleToAll();
		corazon1 = getEnt("corazon1", "targetname");
		corazon2 = getEnt("corazon2", "targetname");
		trigger_revive_1 = getEnt("trigger_revive_1", "targetname");
		trigger_revive_2 = getEnt("trigger_revive_2", "targetname");
		corazon1 Delete();
		corazon2 Delete();
		trigger_revive_1 Delete();
		trigger_revive_2 Delete();

	}
	if (numb_players == 2)
	{
		thread modo_2_jugadores();
			//TRIGGER PARA REVIVIR JUGADORES
	thread revive_all_player("trigger_revive_1");
	thread revive_all_player("trigger_revive_2");
	}
	if (numb_players == 3)
	{
		thread modo_3_jugadores();
			//TRIGGER PARA REVIVIR JUGADORES
	thread revive_all_player("trigger_revive_1");
	thread revive_all_player("trigger_revive_2");
	}
	if (numb_players == 4)
	{
		thread modo_4_jugadores();
			//TRIGGER PARA REVIVIR JUGADORES
	thread revive_all_player("trigger_revive_1");
	thread revive_all_player("trigger_revive_2");
	}

	trig = getEnt("start_teleport", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to start the gameplay"); 
	trig SetCursorHint("HINT_NOICON");
	trig waittill("trigger", player);
	level notify ("start_the_challenge");

}
function teleport_players_start_challenge(i)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("start_challenge_teleport_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}
function modo_1_jugador()
{
	level waittill ("start_the_challenge");
	i = RandomIntRange(0,4); //(min result, max rasult + 1) randomizar el destino entre 0 y 3
	players = GetPlayers();
	players[0] thread teleport_players_start_challenge(i);
	thread borrar_zona_inicial();
}
function modo_2_jugadores()
{
	level waittill ("start_the_challenge");
	random = RandomIntRange(0,2); //random entre 0 y 1
	players = GetPlayers();
	if (random == 0)
	{
		players[0] thread teleport_players_start_challenge(0);
		players[1] thread teleport_players_start_challenge(2);
		thread player_island(0,players[0]);
		thread player_island(2,players[1]);
		thread borrar_zona_inicial();
	}
	else
	{
		players[0] thread teleport_players_start_challenge(2);
		players[1] thread teleport_players_start_challenge(0);
		thread player_island(2,players[0]);
		thread player_island(0,players[1]);
		thread borrar_zona_inicial();
	}
}
function modo_3_jugadores()
{
	level waittill ("start_the_challenge");
	j1 = RandomIntRange(0,4); //random entre 0 y 3
	
	while(1)
	{
		j2 = RandomIntRange(0,4);
		if (j1 != j2)
		{
			break;
		}
		wait(0.05);
	}
	while(1)
	{
		j3 = RandomIntRange(0,4);
		if ((j1 != j3) && (j2 != j3))
		{
			break;
		}
		wait(0.05);
	}
	players = GetPlayers();
	players[0] thread teleport_players_start_challenge(j1);
	players[1] thread teleport_players_start_challenge(j2);
	players[2] thread teleport_players_start_challenge(j3);
	thread player_island(j1,players[0]);
	thread player_island(j2,players[1]);
	thread player_island(j3,players[2]);
	thread borrar_zona_inicial();
}
function modo_4_jugadores()
{
	level waittill ("start_the_challenge");
	j1 = RandomIntRange(0,4); //random entre 0 y 3
	
	while(1)
	{
		j2 = RandomIntRange(0,4);
		if (j1 != j2)
		{
			break;
		}
		wait(0.05);
	}
	while(1)
	{
		j3 = RandomIntRange(0,4);
		if ((j1 != j3) && (j2 != j3))
		{
			break;
		}
		wait(0.05);
	}
	while(1)
	{
		j4 = RandomIntRange(0,4);
		if ((j1 != j4) && (j2 != j4) && (j3 != j4))
		{
			break;
		}
		wait(0.05);
	}
	players = GetPlayers();
	players[0] thread teleport_players_start_challenge(j1);
	players[1] thread teleport_players_start_challenge(j2);
	players[2] thread teleport_players_start_challenge(j3);
	players[3] thread teleport_players_start_challenge(j4);
	thread player_island(j1,players[0]);
	thread player_island(j2,players[1]);
	thread player_island(j3,players[2]);
	thread player_island(j4,players[3]);
	thread borrar_zona_inicial();
}

function borrar_zona_inicial()
{
	wait(1);
	  for( i = 1; i < 15; i++ ) //set up a for loop for all the rocks (6)
	 {
	 	borrable[i] = getEnt("borrable_" + i, "targetname");
	 	borrable[i] SetInvisibleToAll();
	 }
}

function teleports_1_jugador_primer_reto(trigger_name,model_name,destination_name)
{
	trig = getEnt(trigger_name, "targetname");
	model = getEnt(model_name, "targetname");
	destination = struct::get(destination_name, "targetname" ); 
	trig SetHintString( "Press and Hold ^3&&1^7 to teleport you to the other island" ); 
	trig SetCursorHint("HINT_NOICON");

	model SetInvisibleToAll();
	trig SetInvisibleToAll();
	level.esunjugador = false;
	level waittill("es 1 jugador");
	level.esunjugador = true;
	
	trig SetVisibleToAll();

	while(1)
	{
		trig waittill("trigger", player);
		if (level.player0have == "nothing")
		{
			player thread teleport_to(destination_name);
		}
		else
		{
			IPrintLnBold("You cant be teleported with an item. Let it first.");
		}
	}
}
function teleports_1_jugador(trigger_name,model_name,destination_name)
{
	trig = getEnt(trigger_name, "targetname");
	model = getEnt(model_name, "targetname");
	destination = struct::get(destination_name, "targetname" ); 
	trig SetHintString( "Press and Hold ^3&&1^7 to teleport you to the other island" ); 
	trig SetCursorHint("HINT_NOICON");

	model SetInvisibleToAll();
	trig SetInvisibleToAll();
	level.esunjugador = false;
	level waittill("es 1 jugador");
	level.esunjugador = true;
	
	trig SetVisibleToAll();

	while(1)
	{
		trig waittill("trigger", player);
			player thread teleport_to(destination_name);
		
	}
}
function revive_all_player(triggername)
{

    trigger = GetEnt(triggername, "targetname");

    trigger SetHintString( "Hold ^3&&1^7 to revive all players (clear points)" );
    trigger SetCursorHint( "HINT_NOICON" );

    while(1)
        {
        trigger waittill("trigger", player);
        players = GetPlayers();
        foreach( player in players )
            {
            if( IsDefined(player laststand::player_is_in_laststand() == true ))
            if( player laststand::player_is_in_laststand() == true )
                {
                player playsound("flash");
                player RevivePlayer();
                player.score = 0; 
                player zm_laststand::auto_revive(player, 0);
                wait 0.5;
                break;
                }
            if( IsDefined(player laststand::player_is_in_laststand() == false ))
            if( player laststand::player_is_in_laststand() == false )
                {
                trigger SetHintString( "All players alive" );
                wait 1;
                trigger SetHintString( "Hold ^3&&1^7 to revive all players (clear points)" );
                }
            }
        }
}
function monkey()
{
	trig = GetEnt("monkey_trigger", "targetname");

    trig SetHintString( "Hold ^3&&1^7 to interact" );
    trig SetCursorHint( "HINT_NOICON" );
    while(1)
    {
    	trig waittill("trigger", player);
    	PlaySoundAtPosition("monkeyid",trig.origin);
    	wait(4);
    }
}
/////////////////////////////////////////////////////////////////
//////////////ZONA 1    ZONA 1    ZONA1//////////////////////////
/////////////////////////////////////////////////////////////////
function zona1()
{
	thread take_axe_floor();
	thread take_pico_floor();
	thread axe_table_1();
	thread pico_table_1();
	thread pala_table_1();
	thread lingote_table_1();
	thread madera_table_1();
	thread calavera_table_1();
	thread tibia_table_1();
	thread oro_table_1();
	thread rueda_table_1();
	thread mesa_1();
	thread axe_table_2();
	thread pico_table_2();
	thread pala_table_2();
	thread lingote_table_2();
	thread madera_table_2();
	thread calavera_table_2();
	thread tibia_table_2();
	thread oro_table_2();
	thread rueda_table_2();
	thread mesa_2();
	thread carrito();

	thread crear_pala();
	thread escombros();

	thread acertijos();

	thread maxammo("spawn_maxammo_1","max_ammo1");
	thread maxammo("spawn_maxammo_2","max_ammo2");
	thread maxammo("spawn_maxammo_3","max_ammo3");

}

function maxammo(spawn_name,trigger_name)
{
	trig = getEnt(trigger_name, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to MAX AMMO. Cost: 1000 pts" ); 
	trig SetCursorHint("HINT_NOICON");
	max_ammo_spawn = struct::get(spawn_name, "targetname");
	while(1)
	{
		trig waittill("trigger", player);
		if(player.score >= 1000)
        {
            player.score -= 1000;
			max_ammo_spawn thread zm_powerups::specific_powerup_drop("full_ammo", max_ammo_spawn.origin);
		}
	}
}
function take_axe_floor()
{
	model = getEnt("hachamodel", "targetname");
	trig = getEnt("trigg_hacha", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take AXE" ); 
	trig SetCursorHint("HINT_NOICON");
	thread player_can_take_item("AXE",model,trig);	
	
}
function take_pico_floor()
{
	model = getEnt("picomodel", "targetname");
	trig = getEnt("trigg_pico", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take PICK" ); 
	trig SetCursorHint("HINT_NOICON");
	thread player_can_take_item("PICK",model,trig);	
	
}
/////////////////COGER COSAS MESAS //////////////////////
function axe_table_1()
{
	model = getEnt("model_hacha_1", "targetname");
	trig = getEnt("coger_hacha_1", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take AXE. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_hacha_en_mesa_1");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("AXE",model,trig);

	}
}
function pico_table_1()
{
	model = getEnt("model_pico_1", "targetname");
	trig = getEnt("coger_pico_1", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take PICK. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_pico_en_mesa_1");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("PICK",model,trig);

	}
}
function pala_table_1()
{
	model = getEnt("model_pala_1", "targetname");
	trig = getEnt("coger_pala_1", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take SHOVEL. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_pala_en_mesa_1");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("SHOVEL",model,trig);

	}
}
function lingote_table_1()
{
	model = getEnt("model_lingote_1", "targetname");
	trig = getEnt("coger_lingote_1", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take METAL. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_lingote_en_mesa_1");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("METAL",model,trig);

	}
}
function madera_table_1()
{
	model = getEnt("model_madera_1", "targetname");
	trig = getEnt("coger_madera_1", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take WOOD. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_madera_en_mesa_1");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("WOOD",model,trig);

	}
}
function calavera_table_1()
{
	model = getEnt("model_calavera_1", "targetname");
	trig = getEnt("coger_calavera_1", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take SKULL. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_calavera_en_mesa_1");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("SKULL",model,trig);

	}
}
function tibia_table_1()
{
	model = getEnt("model_hueso_1", "targetname");
	trig = getEnt("coger_tibia_1", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take SHINBONE. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_tibia_en_mesa_1");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("SHINBONE",model,trig);

	}
}
function oro_table_1()
{
	model = getEnt("model_oro_1", "targetname");
	trig = getEnt("coger_oro_1", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take GOLD. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_oro_en_mesa_1");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("GOLD",model,trig);

	}
}
function rueda_table_1()
{
	model = getEnt("model_rueda_1", "targetname");
	trig = getEnt("coger_rueda_1", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take WHEEL. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_rueda_en_mesa_1");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("WHEEL",model,trig);

	}
}


function axe_table_2()
{
	model = getEnt("model_hacha_2", "targetname");
	trig = getEnt("coger_hacha_2", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take AXE. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_hacha_en_mesa_2");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("AXE",model,trig);

	}
}
function pico_table_2()
{
	model = getEnt("model_pico_2", "targetname");
	trig = getEnt("coger_pico_2", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take PICK. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_pico_en_mesa_2");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("PICK",model,trig);

	}
}
function pala_table_2()
{
	model = getEnt("model_pala_2", "targetname");
	trig = getEnt("coger_pala_2", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take SHOVEL. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_pala_en_mesa_2");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("SHOVEL",model,trig);

	}
}
function lingote_table_2()
{
	model = getEnt("model_lingote_2", "targetname");
	trig = getEnt("coger_lingote_2", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take METAL. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_lingote_en_mesa_2");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("METAL",model,trig);

	}
}
function madera_table_2()
{
	model = getEnt("model_madera_2", "targetname");
	trig = getEnt("coger_madera_2", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take WOOD. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_madera_en_mesa_2");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("WOOD",model,trig);

	}
}
function calavera_table_2()
{
	model = getEnt("model_calavera_2", "targetname");
	trig = getEnt("coger_calavera_2", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take SKULL. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_calavera_en_mesa_2");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("SKULL",model,trig);

	}
}
function tibia_table_2()
{
	model = getEnt("model_hueso_2", "targetname");
	trig = getEnt("coger_tibia_2", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take SHINBONE. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_tibia_en_mesa_2");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("SHINBONE",model,trig);

	}
}
function oro_table_2()
{
	model = getEnt("model_oro_2", "targetname");
	trig = getEnt("coger_oro_2", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take GOLD. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_oro_en_mesa_2");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("GOLD",model,trig);

	}
}
function rueda_table_2()
{
	model = getEnt("model_rueda_2", "targetname");
	trig = getEnt("coger_rueda_2", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take WHEEL. Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	while(1)
	{		
		level waittill("hay_rueda_en_mesa_2");
		trig SetVisibleToAll();
		model SetVisibleToAll();
		thread player_can_take_item("WHEEL",model,trig);

	}
}



/////////////////////////////// DEJAR COSAS EN MESAS ////////////////////////////////
function mesa_1()
{
	trig = getEnt("trigger_dejar_mesa_1", "targetname");
	trig SetHintString( "Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
	trig waittill( "damage", damage, player, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		if (mod == "MOD_MELEE")
		{	
			if (player.playername == level.player0name)
			{
				if (level.player0have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player0have == "AXE")
				{
					IPrintLnBold(player.playername, " let an AXE.");
					level.player0have = "nothing";
					level notify ("hay_hacha_en_mesa_1");
				}
				if (level.player0have == "PICK")
				{
					IPrintLnBold(player.playername, " let a PICK.");
					level.player0have = "nothing";
					level notify ("hay_pico_en_mesa_1");
				}
				if (level.player0have == "SHOVEL")
				{
					IPrintLnBold(player.playername, " let a SHOVEL.");
					level.player0have = "nothing";
					level notify ("hay_pala_en_mesa_1");
				}
				if (level.player0have == "METAL")
				{
					IPrintLnBold(player.playername, " let  METAL.");
					level.player0have = "nothing";
					level notify ("hay_lingote_en_mesa_1");
				}
				if (level.player0have == "WOOD")
				{
					IPrintLnBold(player.playername, " let WOOD.");
					level.player0have = "nothing";
					level notify ("hay_madera_en_mesa_1");
				}
				if (level.player0have == "SKULL")
				{
					IPrintLnBold(player.playername, " let a SKULL.");
					level.player0have = "nothing";
					level notify ("hay_calavera_en_mesa_1");
				}
				if (level.player0have == "SHINBONE")
				{
					IPrintLnBold(player.playername, " let a SHINBONE.");
					level.player0have = "nothing";
					level notify ("hay_tibia_en_mesa_1");
				}
				if (level.player0have == "GOLD")
				{
					IPrintLnBold(player.playername, " let  GOLD.");
					level.player0have = "nothing";
					level notify ("hay_oro_en_mesa_1");
				}
				if (level.player0have == "WHEEL")
				{
					IPrintLnBold(player.playername, " let a WHEEL.");
					level.player0have = "nothing";
					level notify ("hay_rueda_en_mesa_1");
				}
			}
			if (player.playername == level.player1name)
			{
				if (level.player1have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player1have == "AXE")
				{
					IPrintLnBold(player.playername, " let an AXE.");
					level.player1have = "nothing";
					level notify ("hay_hacha_en_mesa_1");
				}
				if (level.player1have == "PICK")
				{
					IPrintLnBold(player.playername, " let a PICK.");
					level.player1have = "nothing";
					level notify ("hay_pico_en_mesa_1");
				}
				if (level.player1have == "SHOVEL")
				{
					IPrintLnBold(player.playername, " let a SHOVEL.");
					level.player1have = "nothing";
					level notify ("hay_pala_en_mesa_1");
				}
				if (level.player1have == "METAL")
				{
					IPrintLnBold(player.playername, " let  METAL.");
					level.player1have = "nothing";
					level notify ("hay_lingote_en_mesa_1");
				}
				if (level.player1have == "WOOD")
				{
					IPrintLnBold(player.playername, " let  WOOD.");
					level.player1have = "nothing";
					level notify ("hay_madera_en_mesa_1");
				}
				if (level.player1have == "SKULL")
				{
					IPrintLnBold(player.playername, " let a SKULL.");
					level.player1have = "nothing";
					level notify ("hay_calavera_en_mesa_1");
				}
				if (level.player1have == "SHINBONE")
				{
					IPrintLnBold(player.playername, " let a SHINBONE.");
					level.player1have = "nothing";
					level notify ("hay_tibia_en_mesa_1");
				}
				if (level.player1have == "GOLD")
				{
					IPrintLnBold(player.playername, " let  GOLD.");
					level.player1have = "nothing";
					level notify ("hay_oro_en_mesa_1");
				}
				if (level.player1have == "WHEEL")
				{
					IPrintLnBold(player.playername, " let a WHEEL.");
					level.player1have = "nothing";
					level notify ("hay_rueda_en_mesa_1");
				}
			}
			if (player.playername == level.player2name)
			{
				if (level.player2have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player2have == "AXE")
				{
					IPrintLnBold(player.playername, " let an AXE.");
					level.player2have= "nothing";
					level notify ("hay_hacha_en_mesa_1");
				}
				if (level.player2have == "PICK")
				{
					IPrintLnBold(player.playername, " let a PICK.");
					level.player2have = "nothing";
					level notify ("hay_pico_en_mesa_1");
				}
				if (level.player2have == "SHOVEL")
				{
					IPrintLnBold(player.playername, " let a SHOVEL.");
					level.player2have = "nothing";
					level notify ("hay_pala_en_mesa_1");
				}
				if (level.player2have == "METAL")
				{
					IPrintLnBold(player.playername, " let  METAL.");
					level.player2have = "nothing";
					level notify ("hay_lingote_en_mesa_1");
				}
				if (level.player2have == "WOOD")
				{
					IPrintLnBold(player.playername, " let  WOOD.");
					level.player2have = "nothing";
					level notify ("hay_madera_en_mesa_1");
				}
				if (level.player2have == "SKULL")
				{
					IPrintLnBold(player.playername, " let a SKULL.");
					level.player2have = "nothing";
					level notify ("hay_calavera_en_mesa_1");
				}
				if (level.player2have == "SHINBONE")
				{
					IPrintLnBold(player.playername, " let a SHINBONE.");
					level.player2have = "nothing";
					level notify ("hay_tibia_en_mesa_1");
				}
				if (level.player2have == "GOLD")
				{
					IPrintLnBold(player.playername, " let  GOLD.");
					level.player2have = "nothing";
					level notify ("hay_oro_en_mesa_1");
				}
				if (level.player2have == "WHEEL")
				{
					IPrintLnBold(player.playername, " let a WHEEL.");
					level.player2have = "nothing";
					level notify ("hay_rueda_en_mesa_1");
				}
			}
			if (player.playername == level.player3name)
			{
				if (level.player3have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player3have == "AXE")
				{
					IPrintLnBold(player.playername, " let an AXE.");
					level.player3have = "nothing";
					level notify ("hay_hacha_en_mesa_1");
				}
				if (level.player3have == "PICK")
				{
					IPrintLnBold(player.playername, " let a PICK.");
					level.player3have = "nothing";
					level notify ("hay_pico_en_mesa_1");
				}
				if (level.player3have == "SHOVEL")
				{
					IPrintLnBold(player.playername, " let a SHOVEL.");
					level.player3have = "nothing";
					level notify ("hay_pala_en_mesa_1");
				}
				if (level.player3have == "METAL")
				{
					IPrintLnBold(player.playername, " let  METAL.");
					level.player3have = "nothing";
					level notify ("hay_lingote_en_mesa_1");
				}
				if (level.player3have == "WOOD")
				{
					IPrintLnBold(player.playername, " let  WOOD.");
					level.player3have = "nothing";
					level notify ("hay_madera_en_mesa_1");
				}

				if (level.player3have == "SKULL")
				{
					IPrintLnBold(player.playername, " let a SKULL.");
					level.player3have = "nothing";
					level notify ("hay_calavera_en_mesa_1");
				}
				if (level.player3have == "SHINBONE")
				{
					IPrintLnBold(player.playername, " let a SHINBONE.");
					level.player3have = "nothing";
					level notify ("hay_tibia_en_mesa_1");
				}
				if (level.player3have == "GOLD")
				{
					IPrintLnBold(player.playername, " let GOLD.");
					level.player3have = "nothing";
					level notify ("hay_oro_en_mesa_1");
				}
				if (level.player3have == "WHEEL")
				{
					IPrintLnBold(player.playername, " let a WHEEL.");
					level.player3have = "nothing";
					level notify ("hay_rueda_en_mesa_1");
				}
			}
		}
	}
}
function mesa_2()
{
	trig = getEnt("trigger_dejar_mesa_2", "targetname");
	trig SetHintString( "Use Knife to let an item" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
	trig waittill( "damage", damage, player, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		if (mod == "MOD_MELEE")
		{	
			if (player.playername == level.player0name)
			{
				if (level.player0have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player0have == "AXE")
				{
					IPrintLnBold(player.playername, " let an AXE.");
					level.player0have = "nothing";
					level notify ("hay_hacha_en_mesa_2");
				}
				if (level.player0have == "PICK")
				{
					IPrintLnBold(player.playername, " let a PICK.");
					level.player0have = "nothing";
					level notify ("hay_pico_en_mesa_2");
				}
				if (level.player0have == "SHOVEL")
				{
					IPrintLnBold(player.playername, " let a SHOVEL.");
					level.player0have = "nothing";
					level notify ("hay_pala_en_mesa_2");
				}
				if (level.player0have == "METAL")
				{
					IPrintLnBold(player.playername, " let METAL.");
					level.player0have = "nothing";
					level notify ("hay_lingote_en_mesa_2");
				}
				if (level.player0have == "WOOD")
				{
					IPrintLnBold(player.playername, " let WOOD.");
					level.player0have = "nothing";
					level notify ("hay_madera_en_mesa_2");
				}
				if (level.player0have == "SKULL")
				{
					IPrintLnBold(player.playername, " let a SKULL.");
					level.player0have = "nothing";
					level notify ("hay_calavera_en_mesa_2");
				}
				if (level.player0have == "SHINBONE")
				{
					IPrintLnBold(player.playername, " let a SHINBONE.");
					level.player0have = "nothing";
					level notify ("hay_tibia_en_mesa_2");
				}
				if (level.player0have == "GOLD")
				{
					IPrintLnBold(player.playername, " let GOLD.");
					level.player0have = "nothing";
					level notify ("hay_oro_en_mesa_2");
				}
				if (level.player0have == "WHEEL")
				{
					IPrintLnBold(player.playername, " let a WHEEL.");
					level.player0have = "nothing";
					level notify ("hay_rueda_en_mesa_2");
				}
			}
			if (player.playername == level.player1name)
			{
				if (level.player1have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player1have == "AXE")
				{
					IPrintLnBold(player.playername, " let an AXE.");
					level.player1have = "nothing";
					level notify ("hay_hacha_en_mesa_2");
				}
				if (level.player1have == "PICK")
				{
					IPrintLnBold(player.playername, " let a PICK.");
					level.player1have = "nothing";
					level notify ("hay_pico_en_mesa_2");
				}
				if (level.player1have == "SHOVEL")
				{
					IPrintLnBold(player.playername, " let a SHOVEL.");
					level.player1have = "nothing";
					level notify ("hay_pala_en_mesa_2");
				}
				if (level.player1have == "METAL")
				{
					IPrintLnBold(player.playername, " let METAL.");
					level.player1have = "nothing";
					level notify ("hay_lingote_en_mesa_2");
				}
				if (level.player1have == "WOOD")
				{
					IPrintLnBold(player.playername, " let WOOD.");
					level.player1have = "nothing";
					level notify ("hay_madera_en_mesa_2");
				}
				if (level.player1have == "SKULL")
				{
					IPrintLnBold(player.playername, " let a SKULL.");
					level.player1have = "nothing";
					level notify ("hay_calavera_en_mesa_2");
				}
				if (level.player1have == "SHINBONE")
				{
					IPrintLnBold(player.playername, " let a SHINBONE.");
					level.player1have = "nothing";
					level notify ("hay_tibia_en_mesa_2");
				}
				if (level.player1have == "GOLD")
				{
					IPrintLnBold(player.playername, " let GOLD.");
					level.player1have = "nothing";
					level notify ("hay_oro_en_mesa_2");
				}
				if (level.player1have == "WHEEL")
				{
					IPrintLnBold(player.playername, " let a WHEEL.");
					level.player1have = "nothing";
					level notify ("hay_rueda_en_mesa_2");
				}
			}
			if (player.playername == level.player2name)
			{
				if (level.player2have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player2have == "AXE")
				{
					IPrintLnBold(player.playername, " let an AXE.");
					level.player2have= "nothing";
					level notify ("hay_hacha_en_mesa_2");
				}
				if (level.player2have == "PICK")
				{
					IPrintLnBold(player.playername, " let a PICK.");
					level.player2have = "nothing";
					level notify ("hay_pico_en_mesa_2");
				}
				if (level.player2have == "SHOVEL")
				{
					IPrintLnBold(player.playername, " let a SHOVEL.");
					level.player2have = "nothing";
					level notify ("hay_pala_en_mesa_2");
				}
				if (level.player2have == "METAL")
				{
					IPrintLnBold(player.playername, " let METAL.");
					level.player2have = "nothing";
					level notify ("hay_lingote_en_mesa_2");
				}
				if (level.player2have == "WOOD")
				{
					IPrintLnBold(player.playername, " let WOOD.");
					level.player2have = "nothing";
					level notify ("hay_madera_en_mesa_2");
				}
				if (level.player2have == "SKULL")
				{
					IPrintLnBold(player.playername, " let a SKULL.");
					level.player2have = "nothing";
					level notify ("hay_calavera_en_mesa_2");
				}
				if (level.player2have == "SHINBONE")
				{
					IPrintLnBold(player.playername, " let a SHINBONE.");
					level.player2have = "nothing";
					level notify ("hay_tibia_en_mesa_2");
				}
				if (level.player2have == "GOLD")
				{
					IPrintLnBold(player.playername, " let GOLD.");
					level.player2have = "nothing";
					level notify ("hay_oro_en_mesa_2");
				}
				if (level.player2have == "WHEEL")
				{
					IPrintLnBold(player.playername, " let a WHEEL.");
					level.player2have = "nothing";
					level notify ("hay_rueda_en_mesa_2");
				}
			}
			if (player.playername == level.player3name)
			{
				if (level.player3have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player3have == "AXE")
				{
					IPrintLnBold(player.playername, " let an AXE.");
					level.player3have = "nothing";
					level notify ("hay_hacha_en_mesa_2");
				}
				if (level.player3have == "PICK")
				{
					IPrintLnBold(player.playername, " let a PICK.");
					level.player3have = "nothing";
					level notify ("hay_pico_en_mesa_2");
				}
				if (level.player3have == "SHOVEL")
				{
					IPrintLnBold(player.playername, " let a SHOVEL.");
					level.player3have = "nothing";
					level notify ("hay_pala_en_mesa_2");
				}
				if (level.player3have == "METAL")
				{
					IPrintLnBold(player.playername, " let METAL.");
					level.player3have = "nothing";
					level notify ("hay_lingote_en_mesa_2");
				}
				if (level.player3have == "WOOD")
				{
					IPrintLnBold(player.playername, " let WOOD.");
					level.player3have = "nothing";
					level notify ("hay_madera_en_mesa_2");
				}
				if (level.player3have == "SKULL")
				{
					IPrintLnBold(player.playername, " let a SKULL.");
					level.player3have = "nothing";
					level notify ("hay_calavera_en_mesa_2");
				}
				if (level.player3have == "SHINBONE")
				{
					IPrintLnBold(player.playername, " let a SHINBONE.");
					level.player3have = "nothing";
					level notify ("hay_tibia_en_mesa_2");
				}
				if (level.player3have == "GOLD")
				{
					IPrintLnBold(player.playername, " let GOLD.");
					level.player3have = "nothing";
					level notify ("hay_oro_en_mesa_2");
				}
				if (level.player3have == "WHEEL")
				{
					IPrintLnBold(player.playername, " let a WHEEL.");
					level.player3have = "nothing";
					level notify ("hay_rueda_en_mesa_2");
				}
			}
		}
	}
}
/////////////////////////////// CARRITO ////////////////////////////////
function carrito()
{
	level.carrohave = "nothing";
	thread movimiento_carro();
}
function carrito_posicion_1()
{
	self endon ("carro en marcha");
	dejar_en_carro_1 = getEnt("dejar_en_carro_1", "targetname");
	dejar_en_carro_1 SetHintString( "Press and Hold ^3&&1^7 to let/take an item on the cart" ); 
	dejar_en_carro_1 SetCursorHint("HINT_NOICON");
	dejar_en_carro_1 SetVisibleToAll();
	
	while(1)
	{
		dejar_en_carro_1 waittill("trigger", player);
		evit_bug = 0;

		//SI EL CARRO LLEVA ALGO
		if (level.carrohave != "nothing")
		{
			if (player.playername == level.player0name)
			{
				if (level.player0have != "nothing")
				{
					IPrintLnBold(player.playername, " allready have another item.");
				}
				else
				{
					level.player0have = level.carrohave;
					level.carrohave = "nothing";
					IPrintLnBold(player.playername, " take an item of the cart:");
					IPrintLnBold(level.player0have);
					evit_bug = 1;
				}
			}
			if (player.playername == level.player1name)
			{
				if (level.player1have != "nothing")
				{
					IPrintLnBold(player.playername, " allready have another item.");
				}
				else
				{
					level.player1have = level.carrohave;
					level.carrohave = "nothing";
					IPrintLnBold(player.playername, " take an item of the cart:");
					IPrintLnBold(level.player1have);
					evit_bug = 1;
				}
			}
			if (player.playername == level.player2name)
			{
				if (level.player2have != "nothing")
				{
					IPrintLnBold(player.playername, " allready have another item.");
				}
				else
				{
					level.player2have = level.carrohave;
					level.carrohave = "nothing";
					IPrintLnBold(player.playername, " take an item of the cart:");
					IPrintLnBold(level.player2have);
					evit_bug = 1;
				}
			}
			if (player.playername == level.player3name)
			{
				if (level.player3have != "nothing")
				{
					IPrintLnBold(player.playername, " allready have another item.");
				}
				else
				{
					level.player3have = level.carrohave;
					level.carrohave = "nothing";
					IPrintLnBold(player.playername, " take an item of the cart:");
					IPrintLnBold(level.player3have);
					evit_bug = 1;
				}
			}
		}




		//SI EL CARRO ESTA VACIO

		
		if ((level.carrohave == "nothing") && (evit_bug == 0))
		{
			if (player.playername == level.player0name)
			{
				if (level.player0have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				else
				{
					level.carrohave = level.player0have;
					level.player0have = "nothing";
					IPrintLnBold(player.playername, " let an item on the cart:");
					IPrintLnBold(level.carrohave);

				}
			}
			if (player.playername == level.player1name)
			{
				if (level.player1have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				else
				{
					level.carrohave = level.player1have;
					level.player1have = "nothing";
					IPrintLnBold(player.playername, " let an item on the cart:");
					IPrintLnBold(level.carrohave);

				}
			}
			if (player.playername == level.player2name)
			{
				if (level.player2have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				else
				{
					level.carrohave = level.player2have;
					level.player2have = "nothing";
					IPrintLnBold(player.playername, " let an item on the cart:");
					IPrintLnBold(level.carrohave);

				}
			}
			if (player.playername == level.player3name)
			{
				if (level.player3have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				else
				{
					level.carrohave = level.player3have;
					level.player3have = "nothing";
					IPrintLnBold(player.playername, " let an item on the cart:");
					IPrintLnBold(level.carrohave);

				}
			}
		}
	}
}
function carrito_posicion_2()
{
	self endon ("carro en marcha");
	dejar_en_carro_2 = getEnt("dejar_en_carro_2", "targetname");
	dejar_en_carro_2 SetHintString( "Press and Hold ^3&&1^7 to let/take an item on the cart" ); 
	dejar_en_carro_2 SetCursorHint("HINT_NOICON");
	dejar_en_carro_2 SetVisibleToAll();
	
	while(1)
	{
		dejar_en_carro_2 waittill("trigger", player);	
		evit_bug = 0;

		//SI EL CARRO LLEVA ALGO
		if (level.carrohave != "nothing")
		{
			if (player.playername == level.player0name)
			{
				if (level.player0have != "nothing")
				{
					IPrintLnBold(player.playername, " allready have another item.");
				}
				else
				{
					level.player0have = level.carrohave;
					level.carrohave = "nothing";
					IPrintLnBold(player.playername, " take an item of the cart:");
					IPrintLnBold(level.player0have);
					evit_bug = 1;
				}
			}
			if (player.playername == level.player1name)
			{
				if (level.player1have != "nothing")
				{
					IPrintLnBold(player.playername, " allready have another item.");
				}
				else
				{
					level.player1have = level.carrohave;
					level.carrohave = "nothing";
					IPrintLnBold(player.playername, " take an item of the cart:");
					IPrintLnBold(level.player1have);
					evit_bug = 1;
				}
			}
			if (player.playername == level.player2name)
			{
				if (level.player2have != "nothing")
				{
					IPrintLnBold(player.playername, " allready have another item.");
				}
				else
				{
					level.player2have = level.carrohave;
					level.carrohave = "nothing";
					IPrintLnBold(player.playername, " take an item of the cart:");
					IPrintLnBold(level.player2have);
					evit_bug = 1;
				}
			}
			if (player.playername == level.player3name)
			{
				if (level.player3have != "nothing")
				{
					IPrintLnBold(player.playername, " allready have another item.");
				}
				else
				{
					level.player3have = level.carrohave;
					level.carrohave = "nothing";
					IPrintLnBold(player.playername, " take an item of the cart:");
					IPrintLnBold(level.player3have);
					evit_bug = 1;
				}
			}
		}




		//SI EL CARRO ESTA VACIO

		if ((level.carrohave == "nothing") && (evit_bug == 0))
		{
			if (player.playername == level.player0name)
			{
				if (level.player0have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				else
				{
					level.carrohave = level.player0have;
					level.player0have = "nothing";
					IPrintLnBold(player.playername, " let an item on the cart:");
					IPrintLnBold(level.carrohave);

				}
			}
			if (player.playername == level.player1name)
			{
				if (level.player1have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				else
				{
					level.carrohave = level.player1have;
					level.player1have = "nothing";
					IPrintLnBold(player.playername, " let an item on the cart:");
					IPrintLnBold(level.carrohave);

				}
			}
			if (player.playername == level.player2name)
			{
				if (level.player2have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				else
				{
					level.carrohave = level.player2have;
					level.player2have = "nothing";
					IPrintLnBold(player.playername, " let an item on the cart:");
					IPrintLnBold(level.carrohave);

				}
			}
			if (player.playername == level.player3name)
			{
				if (level.player3have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				else
				{
					level.carrohave = level.player3have;
					level.player3have = "nothing";
					IPrintLnBold(player.playername, " let an item on the cart:");
					IPrintLnBold(level.carrohave);

				}
			}
		}
	}
}


function movimiento_carro()
{
	activar_carro_1 = getEnt("activar_carro_1", "targetname");
	activar_carro_1 SetHintString( "Charge it with souls" ); 
	activar_carro_1 SetCursorHint("HINT_NOICON");
	
	activar_carro_2 = getEnt("activar_carro_2", "targetname");
	activar_carro_2 SetHintString( "Charge it with souls" ); 
	activar_carro_2 SetCursorHint("HINT_NOICON");
	activar_carro_2 SetInvisibleToAll();

	dejar_en_carro_1 = getEnt("dejar_en_carro_1", "targetname");
	dejar_en_carro_2 = getEnt("dejar_en_carro_2", "targetname");
	dejar_en_carro_2 SetInvisibleToAll();

	thread carrito_posicion_1();



	while(1)
	{
	thread cargar_almas("grow_soul1"); //esto es para activar las almas del pulsador 1
	
	if (level.EzmodeON == false)
	{level waittill ("grow_soul1_allgrowsouls");}
	

	activar_carro_1 SetHintString( "Press and Hold ^3&&1^7 to move the cart" ); 
	activar_carro_1 waittill("trigger", player);

	activar_carro_1 SetHintString( "Charge it with souls" );
	activar_carro_1 SetInvisibleToAll();
	dejar_en_carro_1 SetInvisibleToAll();
	level notify ("carro en marcha");
	carrito = getEnt("carro", "targetname");
	carrito MoveY(824,4,1.5,1.5);
	carrito PlaySound("carritoid");
	wait(4.2);
	//carrito StopLoopSound("carritoid");

	thread carrito_posicion_2();
	activar_carro_2 SetVisibleToAll();
	dejar_en_carro_2 SetVisibleToAll();

	thread cargar_almas("grow_soul2");

	if (level.EzmodeON == false)
	{level waittill ("grow_soul2_allgrowsouls");}

	activar_carro_2 SetHintString( "Press and Hold ^3&&1^7 to move the cart" ); 
	activar_carro_2 waittill("trigger", player);

	activar_carro_2 SetHintString( "Charge it with souls" );
	activar_carro_2 SetInvisibleToAll();
	dejar_en_carro_2 SetInvisibleToAll();
	level notify ("carro en marcha");
	carrito = getEnt("carro", "targetname");
	carrito MoveY(-824,4,1.5,1.5);
	carrito PlaySound("carritoid");
	wait(4.2);
	//carrito StopLoopSound("carritoid");

	thread carrito_posicion_1();
	activar_carro_1 SetVisibleToAll();
	dejar_en_carro_2 SetVisibleToAll();
	}

}

/////////////////////// CREAR PALA  /////////////////////////

function crear_pala()
{
   for( i = 1; i < 7; i++ ) //set up a for loop for all the rocks (6)
	 {
	 	thread destructible_rock(i);
	 }
	thread useful_rock();
	for( i = 1; i < 3; i++ ) //set up a for loop for all the trees (2)
	 {
	 	thread destructible_tree(i);
	 }

	thread horno();
}

function destructible_rock(i)
{
	model = getEnt("rock_" + i , "targetname");
	trig = getEnt("trig_rock_" + i, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		location = player.origin;
		if (player.playername == level.player0name)
			{
				if (level.player0have == "PICK")
				{
					PlaySoundAtPosition("picoid",location);
					wait(2);
					model Delete();
					trig SetHintString( "Nothing useful here" );
					wait(2);
					trig Delete();
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player1name)
			{
				if (level.player1have == "PICK")
				{
					PlaySoundAtPosition("picoid",location);
					wait(2);
					model Delete();
					trig SetHintString( "Nothing useful here" );
					wait(2);
					trig Delete();
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player2name)
			{
				if (level.player2have == "PICK")
				{
					PlaySoundAtPosition("picoid",location);
					wait(2);
					model Delete();
					trig SetHintString( "Nothing useful here" );
					wait(2);
					trig Delete();
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player3name)
			{
				if (level.player3have == "PICK")
				{
					PlaySoundAtPosition("picoid",location);
					wait(2);
					model Delete();
					trig SetHintString( "Nothing useful here" );
					wait(2);
					trig Delete();
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
	}
}
function useful_rock()
{
	lingote = getEnt("lingote_suelo" , "targetname");
	rock = getEnt("rock_good" , "targetname");
	trig = getEnt("trig_rock_good", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		location = player.origin;
		if (player.playername == level.player0name)
			{
				if (level.player0have == "PICK")
				{
					PlaySoundAtPosition("picoid",location);
					wait(2);
					rock Delete();
					trig SetHintString( "Press and Hold ^3&&1^7 to take metal" );
					thread player_can_take_item("METAL",lingote,trig);
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player1name)
			{
				if (level.player1have == "PICK")
				{
					PlaySoundAtPosition("picoid",location);
					wait(2);
					rock Delete();
					trig SetHintString( "Press and Hold ^3&&1^7 to take metal" );
					thread player_can_take_item("METAL",lingote,trig);
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player2name)
			{
				if (level.player2have == "PICK")
				{
					PlaySoundAtPosition("picoid",location);
					wait(2);
					rock Delete();
					trig SetHintString( "Press and Hold ^3&&1^7 to take metal" );
					thread player_can_take_item("METAL",lingote,trig);
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player3name)
			{
				if (level.player3have == "PICK")
				{
					PlaySoundAtPosition("picoid",location);
					wait(2);
					rock Delete();
					trig SetHintString( "Press and Hold ^3&&1^7 to take metal" );
					thread player_can_take_item("METAL",lingote,trig);
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
	}
}

function destructible_tree(i)
{
	level.arbolcaido = false;
	arbol = getEnt("arbol_" + i , "targetname");
	troncos = getEnt("troncos_" + i , "targetname");
	troncos SetInvisibleToAll();
	clip = getEnt("clip_arbol_" + i , "targetname");
	trig = getEnt("trig_arbol_" + i, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		location = player.origin;

		if (level.arbolcaido == true)
		{
			IPrintLnBold("Bro, you already have wood, it is not necessary to destroy the entire ecosystem");
			trig Delete();     /// si tiras un arbol que con el otro no puedas hacer nada
			break;
		}

		if (player.playername == level.player0name)
			{
				if (level.player0have == "AXE")
				{
					PlaySoundAtPosition("hachaid",location);
					wait(2);
					arbol.shadow_casting = false;
					arbol Delete();
					clip Delete();
					troncos SetVisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to take wood" );
					thread player_can_take_item("WOOD",troncos,trig);
					level.arbolcaido = true;
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player1name)
			{
				if (level.player1have == "AXE")
				{
					PlaySoundAtPosition("hachaid",location);
					wait(2);
					arbol Delete();
					clip Delete();
					troncos SetVisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to take wood" );
					thread player_can_take_item("WOOD",troncos,trig);
					level.arbolcaido = true;
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player2name)
			{
				if (level.player2have == "AXE")
				{
					PlaySoundAtPosition("hachaid",location);
					wait(2);
					arbol Delete();
					clip Delete();
					troncos SetVisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to take wood" );
					thread player_can_take_item("WOOD",troncos,trig);
					level.arbolcaido = true;
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player3name)
			{
				if (level.player3have == "AXE")
				{
					PlaySoundAtPosition("hachaid",location);
					wait(2);
					arbol Delete();
					clip Delete();
					troncos SetVisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to take wood" );
					thread player_can_take_item("WOOD",troncos,trig);
					level.arbolcaido = true;
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
	}
}

function horno()
{
	thread fuego_horno();
	thread items_horno();
	thread hacer_pala();
}

function fuego_horno()
{
	level.horno_on = false;
	trig = getEnt("trig_horno", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	puerta_horno = getEnt("puerta_horno", "targetname");
	while(1)
	{
		trig waittill("trigger", player);
		if (player.playername == level.player0name)
			{
				if (level.player0have == "WOOD")
				{					
					PlayFX(level.effect["fuego"],(-2159,-986.5,70));
					puerta_horno PlayLoopSound("fireid");
					level.player0have = "nothing";
					IPrintLnBold(player.playername," lit a fire");
					level.horno_on = true;
					break;
				}
				
			}
		if (player.playername == level.player1name)
			{
				if (level.player1have == "WOOD")
				{
					PlayFX(level.effect["fuego"],(-2159,-986.5,70));
					puerta_horno PlayLoopSound("fireid");
					level.player1have = "nothing";
					IPrintLnBold(player.playername," lit a fire");
					level.horno_on = true;
					break;
				}
				
			}
		if (player.playername == level.player2name)
			{
				if (level.player2have == "WOOD")
				{
					PlayFX(level.effect["fuego"],(-2159,-986.5,70));
					puerta_horno PlayLoopSound("fireid");
					level.player2have = "nothing";
					IPrintLnBold(player.playername," lit a fire");
					level.horno_on = true;
					break;
				}
				
			}
		if (player.playername == level.player3name)
			{
				if (level.player3have == "WOOD")
				{
					PlayFX(level.effect["fuego"],(-2159,-986.5,70));
					puerta_horno PlayLoopSound("fireid");
					level.player3have = "nothing";
					IPrintLnBold(player.playername," lit a fire");
					level.horno_on = true;
					break;
				}
				
			}
	}
}
function items_horno()
{
	level.horno_metal = false;
	trig = getEnt("trig_horno", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	horno_metal = getEnt("horno_metal", "targetname");
	
	while(1)
	{
		trig waittill("trigger", player);


		if (player.playername == level.player0name)
			{
				if (level.player0have == "METAL")
				{
					
					level.player0have = "nothing";
					IPrintLnBold(player.playername, " had a good idea!");
					trig SetHintString( "Now we need some fire..." ); 
					level.horno_metal = true;
					horno_metal SetVisibleToAll();
					break;
				}
				if ((level.player0have != "METAL") && (level.player0have != "WOOD"))
				{
					IPrintLnBold(player.playername, " it is not such a good idea!");
				}
			}

		if (player.playername == level.player1name)
			{
				if (level.player1have == "METAL")
				{
					
					level.player1have = "nothing";
					IPrintLnBold(player.playername, " had a good idea!");
					trig SetHintString( "Now we need some fire..." ); 
					level.horno_metal = true;
					horno_metal SetVisibleToAll();
					break;
				}
				if ((level.player1have != "METAL") && (level.player1have != "WOOD"))
				{
					IPrintLnBold(player.playername, " it is not such a good idea!");
				}
			}
		if (player.playername == level.player2name)
			{
				if (level.player2have == "METAL")
				{
					
					level.player2have = "nothing";
					IPrintLnBold(player.playername, " had a good idea!");
					trig SetHintString( "Now we need some fire..." ); 
					level.horno_metal = true;
					horno_metal SetVisibleToAll();
					break;
				}
				if ((level.player2have != "METAL") && (level.player2have != "WOOD"))
				{
					IPrintLnBold(player.playername, " it is not such a good idea!");
				}
			}
		if (player.playername == level.player3name)
			{
				if (level.player3have == "METAL")
				{
					
					level.player3have = "nothing";
					IPrintLnBold(player.playername, " had a good idea!");
					trig SetHintString( "Now we need some fire..." ); 
					level.horno_metal = true;
					horno_metal SetVisibleToAll();
					break;
				}
				if ((level.player3have != "METAL") && (level.player3have != "WOOD"))
				{
					IPrintLnBold(player.playername, " it is not such a good idea!");
				}
			}
				
		
	}
}
function hacer_pala()
{
	horno_pala = getEnt("horno_pala", "targetname");
	horno_metal = getEnt("horno_metal", "targetname");
	horno_pala SetInvisibleToAll();
	horno_metal SetInvisibleToAll();
	trig = getEnt("trig_horno", "targetname");
	puerta = getEnt("puerta_horno", "targetname");

	while(1)
	{
		if ((level.horno_on == true) && (level.horno_metal == true))
		{
			trig SetHintString( "Press and Hold ^3&&1^7 to close the furnace" ); 
			trig waittill("trigger", player);
			trig SetHintString( "waiting...." );
			puerta MoveTo((-2175.34,-972.931,71.25),2);
			puerta RotateTo((0,90,0),2);
			wait(2);
			horno_metal SetInvisibleToAll();
			if (level.EzmodeON == false)
			{level waittill( "start_of_round" );}

			puerta MoveTo((-2175.34,-972.995,71.25),2);
			puerta RotateTo((0,200,0),2);
			wait(2);
			horno_pala SetVisibleToAll();
			horno_pala MoveY(21,2);
			wait(2);
			trig SetHintString( "Press and Hold ^3&&1^7 to take the shovel");
			thread player_can_take_item("SHOVEL",horno_pala,trig);
			break;
		}
		wait(0.2);
	}

}

/////////////////////////// Cavar con la pala  ////////////////////////////////////////
function escombros()
{
	thread escombro("calavera_escombros","calavera_suelo","SKULL","trig_calavera","Press and Hold ^3&&1^7 to take SKULL");
	thread escombro("tibia_escombros","hueso_suelo","SHINBONE","trig_tibia","Press and Hold ^3&&1^7 to take SHINBONE");
	thread escombro("oro_escombros","oro_suelo","GOLD","trig_oro","Press and Hold ^3&&1^7 to take GOLD");
	thread escombro("rueda_escombros","rueda_suelo","WHEEL","trig_rueda","Press and Hold ^3&&1^7 to take WHEEL");

}

function escombro(escombroname,modelname,itemname,triggername, triggertxt)
{
	trig = getEnt(triggername, "targetname");
	escombro = getEnt(escombroname, "targetname");
	model = getEnt(modelname, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		location = player.origin;
		if (player.playername == level.player0name)
			{
				if (level.player0have == "SHOVEL")
				{
					PlaySoundAtPosition("palaid",location);
					wait(2);
					escombro Delete();
					trig SetHintString(triggertxt);
					thread player_can_take_item(itemname,model,trig); 
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player1name)
			{
				if (level.player1have == "SHOVEL")
				{
					PlaySoundAtPosition("palaid",location);
					wait(2);
					escombro Delete();
					trig SetHintString(triggertxt);
					thread player_can_take_item(itemname,model,trig); 
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player2name)
			{
				if (level.player2have == "SHOVEL")
				{
					PlaySoundAtPosition("palaid",location);
					wait(2);
					escombro Delete();
					trig SetHintString(triggertxt);
					thread player_can_take_item(itemname,model,trig); 
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
		if (player.playername == level.player3name)
			{
				if (level.player3have == "SHOVEL")
				{
					PlaySoundAtPosition("palaid",location);
					wait(2);
					escombro Delete();
					trig SetHintString(triggertxt);
					thread player_can_take_item(itemname,model,trig); 
					break;
				}
				else
				{
					IPrintLnBold("At this moment you cant do nothing with it");

				}
			}
	}
}

//////////////////////////// ACERTIJOS ///////////////////////////////////
function acertijos()
{
	thread numero_a();
	thread numero_b();
	thread numero_c();
	thread numero_d();
	thread numero_e();
	thread numero_f();

	thread iniciar_solucion();

	thread bascula();
}

function numero_a()
{
	//inicializar
	for( i = 0; i < 10; i++ ) //set up a for loop for all the rocks (6)
	 {
	 	a[i] = getEnt("a" + i, "targetname");
	 	a[i] SetInvisibleToAll();
	 }
	 a[0] SetVisibleToAll();
	 level.number_a = 0;	 
	trig = getEnt("trig_a", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		a[level.number_a] SetInvisibleToAll();
		level.number_a ++;
		if (level.number_a == 10)
		{
			level.number_a = 0;
		}
		a[level.number_a] SetVisibleToAll();

	}
}
function numero_b()
{
	//inicializar
	for( i = 0; i < 10; i++ ) //set up a for loop for all the rocks (6)
	 {
	 	b[i] = getEnt("b" + i, "targetname");
	 	b[i] SetInvisibleToAll();
	 }
	 b[0] SetVisibleToAll();
	 level.number_b = 0;	 
	trig = getEnt("trig_b", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		b[level.number_b] SetInvisibleToAll();
		level.number_b ++;
		if (level.number_b == 10)
		{
			level.number_b = 0;
		}
		b[level.number_b] SetVisibleToAll();

	}
}
function numero_c()
{
	//inicializar
	for( i = 0; i < 10; i++ ) //set up a for loop for all the rocks (6)
	 {
	 	c[i] = getEnt("c" + i, "targetname");
	 	c[i] SetInvisibleToAll();
	 }
	 c[0] SetVisibleToAll();
	 level.number_c = 0;	 
	trig = getEnt("trig_c", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
	c[level.number_c] SetInvisibleToAll();
		level.number_c ++;
		if (level.number_c == 10)
		{
			level.number_c = 0;
		}
		c[level.number_c] SetVisibleToAll();

	}
}
function numero_d()
{
	//inicializar
	for( i = 0; i < 10; i++ ) //set up a for loop for all the rocks (6)
	 {
	 d[i] = getEnt("d" + i, "targetname");
	 	d[i] SetInvisibleToAll();
	 }
	 d[0] SetVisibleToAll();
	 level.number_d = 0;	 
	trig = getEnt("trig_d", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		d[level.number_d] SetInvisibleToAll();
		level.number_d ++;
		if (level.number_d == 10)
		{
			level.number_d = 0;
		}
		d[level.number_d] SetVisibleToAll();

	}
}
function numero_e()
{
	//inicializar
	for( i = 0; i < 10; i++ ) //set up a for loop for all the rocks (6)
	 {
	 	e[i] = getEnt("e" + i, "targetname");
	 	e[i] SetInvisibleToAll();
	 }
	 e[0] SetVisibleToAll();
	 level.number_e = 0;	 
	trig = getEnt("trig_e", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		e[level.number_e] SetInvisibleToAll();
		level.number_e ++;
		if (level.number_e == 10)
		{
			level.number_e = 0;
		}
		e[level.number_e] SetVisibleToAll();

	}
}
function numero_f()
{
	//inicializar
	for( i = 0; i < 10; i++ ) //set up a for loop for all the rocks (6)
	 {
	 	f[i] = getEnt("f" + i, "targetname");
	 	f[i] SetInvisibleToAll();
	 }
	 f[0] SetVisibleToAll();
	 level.number_f = 0;	 
	trig = getEnt("trig_f", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to interact" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		f[level.number_f] SetInvisibleToAll();
		level.number_f ++;
		if (level.number_f == 10)
		{
			level.number_f = 0;
		}
		f[level.number_f] SetVisibleToAll();

	}
}



function iniciar_solucion()
{
	//objetos de calculos
	level.peso_calavera = RandomIntRange(1,4); //(min result, max rasult + 1)
	level.peso_tibia = RandomIntRange(1,4); //(min result, max rasult + 1)   //max = 3x2 + 3 = 9 OK

	level.peso_rueda = RandomIntRange(1,10); //(min result, max rasult + 1)

	level.peso_1_lingote = RandomIntRange(1,4); //(min result, max rasult + 1) //3 lingotes max = 3x3 = 9 OK

	



	//resto de objetos
	level.peso_hacha = RandomIntRange(1,9);
	level.peso_pico = RandomIntRange(1,9);
	level.peso_pala = RandomIntRange(1,9);
	level.peso_metal = RandomIntRange(1,9);
	level.peso_madera = RandomIntRange(1,9);
	level.peso_oro = (level.peso_1_lingote * 6);

	//soluciones

	level.solucion_a = level.peso_calavera + 2*level.peso_tibia;
	level.solucion_b = level.peso_rueda;
	level.solucion_c = 3*level.peso_1_lingote;

	level.solucion_def = ((level.peso_calavera * level.peso_rueda) + (level.peso_1_lingote * 6));
	level.isla1_acertijos_completados = 0;
	thread comprobar_solucion1();
	thread comprobar_solucion2();

	
}
function comprobar_solucion1()
{
	while(1)
	{
		if ((level.number_a == level.solucion_a) && (level.number_b == level.solucion_b) && (level.number_c == level.solucion_c))
		{
			level notify ("acertijo_1_resuelto");
			level.isla1_acertijos_completados ++;
			break;
		}
		wait(0.5);
	}
}
function comprobar_solucion2()
{
	while(1)
	{
		check_solucion = ((level.number_d * 100) + (level.number_e * 10) + (level.number_f));
		if (level.solucion_def == check_solucion)
		{
			level notify ("acertijo_2_resuelto");
			level.isla1_acertijos_completados ++;
			break;
		}
		wait(0.5);
	}
}


function bascula()
{
	bascula_hacha = getEnt("bascula_hacha", "targetname");
	bascula_hacha SetInvisibleToAll();
	bascula_pico = getEnt("bascula_pico", "targetname");
	bascula_pico SetInvisibleToAll();
	bascula_pala = getEnt("bascula_pala", "targetname");
	bascula_pala SetInvisibleToAll();
	bascula_metal = getEnt("bascula_metal", "targetname");
	bascula_metal SetInvisibleToAll();
	bascula_madera = getEnt("bascula_madera", "targetname");
	bascula_madera SetInvisibleToAll();
	bascula_oro = getEnt("bascula_oro", "targetname");
	bascula_oro SetInvisibleToAll();
	bascula_rueda = getEnt("bascula_rueda", "targetname");
	bascula_rueda SetInvisibleToAll();
	bascula_calavera = getEnt("bascula_calavera", "targetname");
	bascula_calavera SetInvisibleToAll();
	bascula_tibia = getEnt("bascula_tibia", "targetname");
	bascula_tibia SetInvisibleToAll();

	trig = getEnt("trig_bascula", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		{
			if (player.playername == level.player0name)
			{
				if (level.player0have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player0have == "AXE")
				{
					trig SetHintString( level.peso_hacha + "kg");
					bascula_hacha SetVisibleToAll();
					wait(2);
					bascula_hacha SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player0have == "PICK")
				{
					trig SetHintString( level.peso_pico + "kg");
					bascula_pico SetVisibleToAll();
					wait(2);
					bascula_pico SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player0have == "SHOVEL")
				{
					trig SetHintString( level.peso_pala + "kg");
					bascula_pala SetVisibleToAll();
					wait(2);
					bascula_pala SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player0have == "METAL")
				{
					trig SetHintString( level.peso_metal + "kg");
					bascula_metal SetVisibleToAll();
					wait(2);
					bascula_metal SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player0have == "WOOD")
				{
					trig SetHintString( level.peso_madera + "kg");
					bascula_madera SetVisibleToAll();
					wait(2);
					bascula_madera SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player0have == "SKULL")
				{
					trig SetHintString( level.peso_calavera + "kg");
					bascula_calavera SetVisibleToAll();
					wait(2);
					bascula_calavera SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player0have == "SHINBONE")
				{
					trig SetHintString( level.peso_tibia + "kg");
					bascula_tibia SetVisibleToAll();
					wait(2);
					bascula_tibia SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player0have == "GOLD")
				{
					trig SetHintString( level.peso_oro + "kg");
					bascula_oro SetVisibleToAll();
					wait(2);
					bascula_oro SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player0have == "WHEEL")
				{
					trig SetHintString( level.peso_rueda + "kg");
					bascula_rueda SetVisibleToAll();
					wait(2);
					bascula_rueda SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
			}
			if (player.playername == level.player1name)
			{
				if (level.player1have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't have any item.");
				}
				
				if (level.player1have == "AXE")
				{
					trig SetHintString( level.peso_hacha + "kg");
					bascula_hacha SetVisibleToAll();
					wait(2);
					bascula_hacha SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player1have == "PICK")
				{
					trig SetHintString( level.peso_pico + "kg");
					bascula_pico SetVisibleToAll();
					wait(2);
					bascula_pico SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player1have == "SHOVEL")
				{
					trig SetHintString( level.peso_pala + "kg");
					bascula_pala SetVisibleToAll();
					wait(2);
					bascula_pala SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player1have == "METAL")
				{
					trig SetHintString( level.peso_metal + "kg");
					bascula_metal SetVisibleToAll();
					wait(2);
					bascula_metal SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player1have == "WOOD")
				{
					trig SetHintString( level.peso_madera + "kg");
					bascula_madera SetVisibleToAll();
					wait(2);
					bascula_madera SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player1have == "SKULL")
				{
					trig SetHintString( level.peso_calavera + "kg");
					bascula_calavera SetVisibleToAll();
					wait(2);
					bascula_calavera SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player1have == "SHINBONE")
				{
					trig SetHintString( level.peso_tibia + "kg");
					bascula_tibia SetVisibleToAll();
					wait(2);
					bascula_tibia SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player1have == "GOLD")
				{
					trig SetHintString( level.peso_oro + "kg");
					bascula_oro SetVisibleToAll();
					wait(2);
					bascula_oro SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player1have == "WHEEL")
				{
					trig SetHintString( level.peso_rueda + "kg");
					bascula_rueda SetVisibleToAll();
					wait(2);
					bascula_rueda SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
			}
			if (player.playername == level.player02name)
			{
				if (level.player02have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player02have == "AXE")
				{
					trig SetHintString( level.peso_hacha + "kg");
					bascula_hacha SetVisibleToAll();
					wait(2);
					bascula_hacha SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player02have == "PICK")
				{
					trig SetHintString( level.peso_pico + "kg");
					bascula_pico SetVisibleToAll();
					wait(2);
					bascula_pico SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player02have == "SHOVEL")
				{
					trig SetHintString( level.peso_pala + "kg");
					bascula_pala SetVisibleToAll();
					wait(2);
					bascula_pala SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player02have == "METAL")
				{
					trig SetHintString( level.peso_metal + "kg");
					bascula_metal SetVisibleToAll();
					wait(2);
					bascula_metal SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player02have == "WOOD")
				{
					trig SetHintString( level.peso_madera + "kg");
					bascula_madera SetVisibleToAll();
					wait(2);
					bascula_madera SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player02have == "SKULL")
				{
					trig SetHintString( level.peso_calavera + "kg");
					bascula_calavera SetVisibleToAll();
					wait(2);
					bascula_calavera SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player02have == "SHINBONE")
				{
					trig SetHintString( level.peso_tibia + "kg");
					bascula_tibia SetVisibleToAll();
					wait(2);
					bascula_tibia SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player2have == "GOLD")
				{
					trig SetHintString( level.peso_oro + "kg");
					bascula_oro SetVisibleToAll();
					wait(2);
					bascula_oro SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player02have == "WHEEL")
				{
					trig SetHintString( level.peso_rueda + "kg");
					bascula_rueda SetVisibleToAll();
					wait(2);
					bascula_rueda SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
			}
			if (player.playername == level.player3name)
			{
				if (level.player3have == "nothing")
				{
					IPrintLnBold(player.playername, " hasn't any item.");
				}
				
				if (level.player3have == "AXE")
				{
					trig SetHintString( level.peso_hacha + "kg");
					bascula_hacha SetVisibleToAll();
					wait(2);
					bascula_hacha SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player3have == "PICK")
				{
					trig SetHintString( level.peso_pico + "kg");
					bascula_pico SetVisibleToAll();
					wait(2);
					bascula_pico SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player3have == "SHOVEL")
				{
					trig SetHintString( level.peso_pala + "kg");
					bascula_pala SetVisibleToAll();
					wait(2);
					bascula_pala SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player3have == "METAL")
				{
					trig SetHintString( level.peso_metal + "kg");
					bascula_metal SetVisibleToAll();
					wait(2);
					bascula_metal SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player3have == "WOOD")
				{
					trig SetHintString( level.peso_madera + "kg");
					bascula_madera SetVisibleToAll();
					wait(2);
					bascula_madera SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player3have == "SKULL")
				{
					trig SetHintString( level.peso_calavera + "kg");
					bascula_calavera SetVisibleToAll();
					wait(2);
					bascula_calavera SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player3have == "SHINBONE")
				{
					trig SetHintString( level.peso_tibia + "kg");
					bascula_tibia SetVisibleToAll();
					wait(2);
					bascula_tibia SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player3have == "GOLD")
				{
					trig SetHintString( level.peso_oro + "kg");
					bascula_oro SetVisibleToAll();
					wait(2);
					bascula_oro SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
				if (level.player3have == "WHEEL")
				{
					trig SetHintString( level.peso_rueda + "kg");
					bascula_rueda SetVisibleToAll();
					wait(2);
					bascula_rueda SetInvisibleToAll();
					trig SetHintString( "Press and Hold ^3&&1^7 to weigh your item." ); 
				}
			}
		}
	}
}


/////////////////////////////////////////////////////////////////
//////////////ZONA 2    ZONA 2   ZONA 2 //////////////////////////
/////////////////////////////////////////////////////////////////

function zona2()
{
	thread iniciar_isla_2_1();
	thread iniciar_isla_2_2();
	thread iniciar_isla_2();
	level.iniciarisla2 = 0;
	thread iniciar_zona3();
}
function iniciar_isla_2_1()
{
	level waittill ("acertijo_1_resuelto");
	puente = getEnt("bridge1", "targetname");
	clippuente = getEnt("clip_bridge_1", "targetname");
	thread playsoundok("puenteid");
	puente MoveTo((-2754,-721,-0.26),3);
	puente RotateTo((0,270,0),3);
	wait(2);
	clippuente Delete();
	level.iniciarisla2 ++;
	if (level.iniciarisla2 == 1)
	{
		IPrintLnBold("Open both bridges to continue");
	}
	if (level.iniciarisla2 == 2)
	{
		wait(1);
		level notify ("iniciarzona2");
	}
	
}
function iniciar_isla_2_2()
{
	level waittill ("acertijo_2_resuelto");
	puente = getEnt("bridge2", "targetname");
	clippuente = getEnt("clip_bridge_2", "targetname");
	thread playsoundok("puenteid");
	puente MoveTo((-2755,843,9),3);
	puente RotateTo((0,270,0),3);
	wait(2);
	clippuente Delete();
	level.iniciarisla2 ++;
	if (level.iniciarisla2 == 1)
	{
		IPrintLnBold("Open both bridges to continue");
	}
	if (level.iniciarisla2 == 2)
	{
		wait(1);
		level notify ("iniciarzona2");
	}
	
}
function iniciar_isla_2()
{
	for (i = 1;i<5;i++)
	{
		perk[i] = getEnt("perk" + i, "targetname");
		perk[i] SetInvisibleToAll();
	}
	armas_pared = getEnt("armas_pared", "targetname");
	armas_pared SetInvisibleToAll();
	bloques = getEnt("isla2_1", "targetname");
	bloques SetInvisibleToAll();
	bridge3 = getEnt("bridge3", "targetname");
	bridge3 SetInvisibleToAll();
	bridge4 = getEnt("bridge4", "targetname");
	bridge4 SetInvisibleToAll();
	paredinvisible = getEnt("paredinvisible_isla2", "targetname");
	level.isla1_acertijos_completados = 0;
	level waittill ("iniciarzona2");
	
	armas_pared SetVisibleToAll();
	paredinvisible Delete();
	bloques SetVisibleToAll();
	bridge3 SetVisibleToAll();
	bridge4 SetVisibleToAll();
	for (i = 1;i<5;i++)
	{
		perk[i] = getEnt("perk" + i, "targetname");
		perk[i] SetVisibleToAll();
	}
	trig_bridge3 = getEnt("trig_bridge3", "targetname");
	trig_bridge4 = getEnt("trig_bridge4", "targetname");
	trig_bridge3 SetHintString( "Sourvive 2 more Rounds" ); 
	trig_bridge4 SetHintString( "Sourvive 2 more Rounds" ); 
	trig_bridge3 SetCursorHint("HINT_NOICON");
	trig_bridge4 SetCursorHint("HINT_NOICON");

	if (level.EzmodeON == false)
	{level waittill( "start_of_round" );}
	trig_bridge3 SetHintString( "Sourvive 1 more Round" ); 
	trig_bridge4 SetHintString( "Sourvive 1 more Round" ); 
	wait(10);
	if (level.EzmodeON == false)
	{level waittill( "start_of_round" );}
	trig_bridge3 Delete();
	trig_bridge4 Delete();
	level notify ("start_zone3");

}
function iniciar_zona3()
{
	level waittill ("start_zone3");
	
	flag::init( "zone3flag" );
    flag::set("zone3flag");

    puente3 = getEnt("bridge3", "targetname");
	clippuente3 = getEnt("clip_bridge_3", "targetname");
	puente4 = getEnt("bridge4", "targetname");
	clippuente4 = getEnt("clip_bridge_4", "targetname");
	thread playsoundok("puenteid");
	puente3 MoveTo((-3361,-315.25,-2.7),3);
	puente3 RotateTo((0,270,0),3);
	puente4 MoveTo((-3361,463.25,-3),3);
	puente4 RotateTo((0,270,0),3);
	wait(2);
	clippuente3 Delete();
	clippuente4 Delete();
}

/////////////////////////////////////////////////////////////////
//////////////ZONA 3    ZONA 3   ZONA 3 //////////////////////////
/////////////////////////////////////////////////////////////////

function zona3()
{
	/////hacer invisible las vainas
	model_1p_3 = getEnt("model_1p_3", "targetname");
	model_1p_4 = getEnt("model_1p_4", "targetname");
	elefante = getEnt("elefante", "targetname");
	leon = getEnt("leon", "targetname");
	pajaro = getEnt("pajaro", "targetname");
	tortuga = getEnt("tortuga", "targetname");
	if (level.esunjugador == true)
	{
		model_1p_3 SetInvisibleToAll();
		model_1p_4 SetInvisibleToAll();
	}
	elefante SetInvisibleToAll();
	leon  SetInvisibleToAll();
	pajaro SetInvisibleToAll();
	tortuga SetInvisibleToAll();
	for (i = 0;i<4;i++)
	{
		isla[i] = getEnt("isla3_" + i, "targetname");
		isla[i] SetInvisibleToAll();
	}


	level waittill ("start_zone3");

	///hacer visible las vainas
	if (level.esunjugador == true)
	{
		model_1p_3 SetVisibleToAll();
		model_1p_4 SetVisibleToAll();
	}
	elefante SetVisibleToAll();
	leon  SetVisibleToAll();
	pajaro SetVisibleToAll();
	tortuga SetVisibleToAll();
	for (i = 0;i<4;i++)
	{
		isla[i] SetVisibleToAll();
	}

	level.grow_soul_start_scale = 1;//starting scale of model
	level.grow_soul_growth = 0.01;//growth per zombie
	level.grow_soul_size = 1.15;//how big you want it to get scale wise
	thread cargar_almas("almas_leon");
	thread cargar_almas("almas_pajaro");
	thread cargar_almas("almas_tortuga");
	thread cargar_almas("almas_elefante");
	thread leon();
	thread pajaro();
	thread elefante();
	thread tortuga();
	thread check_zona3();
}
function leon()
{
	trig = getEnt("trig_leon", "targetname");
	trig SetHintString( "Charge it with souls." ); 
	trig SetCursorHint("HINT_NOICON");

	if (level.EzmodeON == false)
	{level waittill ("almas_leon_allgrowsouls");}

	trig SetHintString( "Press and Hold ^3&&1^7 to rotate." ); 
	almas = getEnt("almas_leon", "targetname");
	almas Delete();

	model = getEnt("leon", "targetname");
	clip = getEnt("clip_leon", "targetname");

	pos_actual = 0;
	pos_deseada = 90;
	level.leon_colocado = false;

	while(1)
	{
		trig waittill("trigger", player);
		model PlaySound("girar_estatuaid");
		pos_nueva = pos_actual + 45;
		model RotateYaw(45,2);
		clip RotateYaw(45,2);	
		wait(2);
		pos_actual = pos_nueva;
		if (pos_actual == 360)
		{
			pos_actual = 0;
		}

		if (pos_actual == pos_deseada)
		{
			level.leon_colocado = true;
			
		}
		if (pos_actual != pos_deseada)
		{
			level.leon_colocado = false;
		}
	}
}
function pajaro()
{
	trig = getEnt("trig_pajaro", "targetname");
	trig SetHintString( "Charge it with souls." ); 
	trig SetCursorHint("HINT_NOICON");

	if (level.EzmodeON == false)
	{level waittill ("almas_pajaro_allgrowsouls");}

	trig SetHintString( "Press and Hold ^3&&1^7 to rotate." ); 
	almas = getEnt("almas_pajaro", "targetname");
	almas Delete();

	model = getEnt("pajaro", "targetname");
	clip = getEnt("clip_pajaro", "targetname");

	pos_actual = 0;
	pos_deseada = 225;
	level.pajaro_colocado = false;
	
	while(1)
	{
		trig waittill("trigger", player);
		model PlaySound("girar_estatuaid");
		pos_nueva = pos_actual + 45;
		model RotateYaw(45,2);
		clip RotateYaw(45,2);	
		wait(2);
		pos_actual = pos_nueva;
		if (pos_actual == 360)
		{
			pos_actual = 0;
		}

		if (pos_actual == pos_deseada)
		{
			level.pajaro_colocado = true;
			
		}
		if (pos_actual != pos_deseada)
		{
			level.pajaro_colocado = false;
		}
	}
}
function elefante()
{
	trig = getEnt("trig_elefante", "targetname");
	trig SetHintString( "Charge it with souls." ); 
	trig SetCursorHint("HINT_NOICON");

	if (level.EzmodeON == false)
	{level waittill ("almas_elefante_allgrowsouls");}

	trig SetHintString( "Press and Hold ^3&&1^7 to rotate." ); 
	almas = getEnt("almas_elefante", "targetname");
	almas Delete();

	model = getEnt("elefante", "targetname");
	clip = getEnt("clip_elefante", "targetname");

	pos_actual = 0;
	pos_deseada = 225;
	level.elefante_colocado = false;
	
	while(1)
	{
		trig waittill("trigger", player);
		model PlaySound("girar_estatuaid");
		pos_nueva = pos_actual + 45;
		model RotateYaw(45,2);
		clip RotateYaw(45,2);	
		wait(2);
		pos_actual = pos_nueva;
		if (pos_actual == 360)
		{
			pos_actual = 0;
		}

		if (pos_actual == pos_deseada)
		{
			level.elefante_colocado = true;
			
		}
		if (pos_actual != pos_deseada)
		{
			level.elefante_colocado = false;
		}
	}
}
function tortuga()
{
	trig = getEnt("trig_tortuga", "targetname");
	trig SetHintString( "Charge it with souls." ); 
	trig SetCursorHint("HINT_NOICON");

	if (level.EzmodeON == false)
	{level waittill ("almas_tortuga_allgrowsouls");}

	trig SetHintString( "Press and Hold ^3&&1^7 to rotate." ); 
	almas = getEnt("almas_tortuga", "targetname");
	almas Delete();

	model = getEnt("tortuga", "targetname");
	clip = getEnt("clip_tortuga", "targetname");

	pos_actual = 90;
	pos_deseada = 225;
	level.tortuga_colocado = false;
	
	while(1)
	{
		trig waittill("trigger", player);
		model PlaySound("girar_estatuaid");
		pos_nueva = pos_actual + 45;
		model RotateYaw(45,2);
		clip RotateYaw(45,2);	
		wait(2);
		pos_actual = pos_nueva;
		if (pos_actual == 360)
		{
			pos_actual = 0;
		}

		if (pos_actual == pos_deseada)
		{
			level.tortuga_colocado = true;
			
		}
		if (pos_actual != pos_deseada)
		{
			level.tortuga_colocado = false;
		}
	}
}

function check_zona3()
{
	while(1)
	{
		wait(0.5);
		
		if ((level.leon_colocado == true) && (level.pajaro_colocado == true) && (level.tortuga_colocado == true) && (level.elefante_colocado == true))
		{
			level notify ("start_zone4");
			
			break;
		}
		
	}
}

/////////////////////////////////////////////////////////////////
//////////////ZONA 4    ZONA 4   ZONA 4 //////////////////////////
/////////////////////////////////////////////////////////////////

function zona4()
{
	//hacer invisibles 
	for (i = 1;i<70;i++)
	{
		z4[i] = getEnt("z4_" + i, "targetname");
		z4[i] SetInvisibleToAll();
	}
	for (i = 5;i<9;i++)
	{
		perk[i] = getEnt("perk" + i, "targetname");
		perk[i] SetInvisibleToAll();
	}
	piano = getEnt("piano", "targetname");
	piano SetInvisibleToAll();
	caja0 = getEnt("caja0", "targetname");//oculta para que no se vea el rayo
	caja1 = getEnt("caja1", "targetname");
	caja2 = getEnt("caja2", "targetname");
	caja2 SetInvisibleToAll();
	caja0 SetInvisibleToAll();
	caja1 SetInvisibleToAll();
	level waittill ("start_zone4");

	flag::init( "zone4flag" ); 
    flag::set("zone4flag");

	thread playsoundok("uncharted_deadid");
	for (i = 1;i<10;i++)
	{
		z4[i] SetVisibleToAll();
		wait(0.75);						//efecto escaleras construyendose
	}
	for (i = 10;i<70;i++)
	{
		z4[i] SetVisibleToAll();
	}
	caja2 SetVisibleToAll();
	caja1 SetVisibleToAll();
	piano SetVisibleToAll();
	for (i = 5;i<9;i++)
	{
		perk[i] = getEnt("perk" + i, "targetname");
		perk[i] SetVisibleToAll();
	}
	for ( i = 0; i < level.chests.size; i++ )
	{
		show_firesale_box = level.chests[i] [[level._zombiemode_check_firesale_loc_valid_func]]();

		if ( show_firesale_box )
		{
			level.chests[i].zombie_cost = 950;

			if ( level.chest_index != i )
			{
				level.chests[i].was_temp = true;
				if ( IS_TRUE( level.chests[i].hidden ) )
				{
					level.chests[i] thread apply_fire_sale_to_chest();
				}
			}
		}
	}
	 level.zombie_vars["zombie_powerup_fire_sale_on"] = true;
	level.zombie_vars["zombie_powerup_fire_sale_time"] = undefined;



	clip3 = getEnt("door3", "targetname");
	clip4 = getEnt("door4", "targetname");
	trig_door3 = getEnt("trig_door3", "targetname");
	trig_door4 = getEnt("trig_door4", "targetname");
	trig_door3 SetHintString( "Sourvive 2 more Rounds" ); 
	trig_door4 SetHintString( "Sourvive 2 more Rounds" ); 
	trig_door3 SetCursorHint("HINT_NOICON");
	trig_door4 SetCursorHint("HINT_NOICON");

	if (level.EzmodeON == false)
	{level waittill( "start_of_round" );}
	trig_door3 SetHintString( "Sourvive 1 more Round" ); 
	trig_door4 SetHintString( "Sourvive 1 more Round" ); 
	wait(10);
	if (level.EzmodeON == false)
	{level waittill( "start_of_round" );}
	trig_door3 Delete();
	trig_door4 Delete();

	clip3 Delete();
	clip4 Delete();
	z4[17] Delete();
	z4[18] Delete();// BORRAR PUERTA Y CLIPS DE PUERTAS
	z4[19] Delete();
	z4[20] Delete();
	level notify ("start_zone5");
	flag::init( "zone5flag" ); 
    flag::set("zone5flag");

}

/////////////////////////////////////////////////////////////////
//////////////ZONA 5    ZONA 5   ZONA 5 //////////////////////////
/////////////////////////////////////////////////////////////////

function zona5()
{
	thread esconder_todos_colores();
	tick_amarillo = getEnt("tick_amarillo", "targetname");
	tick_rojo = getEnt("tick_rojo", "targetname");
	tick_azul = getEnt("tick_azul", "targetname");
	tick_amarillo SetInvisibleToAll();
	tick_rojo SetInvisibleToAll();
	tick_azul SetInvisibleToAll();
	model_1p_5 = getEnt("model_1p_5", "targetname");
	model_1p_6 = getEnt("model_1p_6", "targetname");
	if (level.esunjugador == true)
	{
		model_1p_5 SetInvisibleToAll();
		model_1p_6 SetInvisibleToAll();
	}

	level waittill("start_zone5");

	if (level.esunjugador == true)
	{
		model_1p_5 SetVisibleToAll();
		model_1p_6 SetVisibleToAll();
	}
	thread nota("C4");
	thread nota("D4");
	thread nota("E4");
	thread nota("F4");
	thread nota("G4");
	thread nota("A4");
	thread nota("B4");
	thread nota("C5");
	thread nota("D5");
	thread nota("E5");
	thread nota("F5");
	thread nota("G5");
	thread nota("A5");
	thread nota("B5");
	thread nota("C6");
	thread nota("D6");
	thread nota("E6");
	thread check_song();
	thread fail_note();
	thread pistas_colores();
}
function nota(note)
{
	trig = getEnt(note, "targetname");
	trig SetHintString("Hold ^3&&1^7 to play note: " + note); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		level.nota_tocada = note;
		level notify("nota_tocada");
		thread playsoundok(note);
		wait(0.5);
	}
}
function fail_note()
{
	while(1)
	{
	level waittill ("fail_note");
	wait(0.5);
	thread playsoundok("failid");
	thread check_song();
	}
}
function check_song()
{
	level waittill("nota_tocada");
	if (level.nota_tocada != "B5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "B4")
	{
		level notify ("fail_note");
		break;
	}
 /////////////////////////////////////////////
	level waittill("nota_tocada");
	if (level.nota_tocada != "B5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "B4")
	{
		level notify ("fail_note");
		break;
	}
 //////////////////////////////////////////////
	level waittill("nota_tocada");
	if (level.nota_tocada != "B5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
 //////////////////////////////////////////////	
 //////////////////////////////////////////////
	level waittill("nota_tocada");
	if (level.nota_tocada != "B5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "B4")
	{
		level notify ("fail_note");
		break;
	}
 /////////////////////////////////////////////
	level waittill("nota_tocada");
	if (level.nota_tocada != "B5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "B4")
	{
		level notify ("fail_note");
		break;
	}
 //////////////////////////////////////////////
	level waittill("nota_tocada");
	if (level.nota_tocada != "B5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
 //////////////////////////////////////////////
 //////////////////////////////////////////////	
	level waittill("nota_tocada");
	if (level.nota_tocada != "C6")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "C5")
	{
		level notify ("fail_note");
		break;
	}
 /////////////////////////////////////////////
	level waittill("nota_tocada");
	if (level.nota_tocada != "C6")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "C5")
	{
		level notify ("fail_note");
		break;
	}
 //////////////////////////////////////////////
	level waittill("nota_tocada");
	if (level.nota_tocada != "C6")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
 //////////////////////////////////////////////
 //////////////////////////////////////////////	
	level waittill("nota_tocada");
	if (level.nota_tocada != "D6")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "C5")
	{
		level notify ("fail_note");
		break;
	}
 //////////////////////////////////////////////
 //////////////////////////////////////////////	
	level waittill("nota_tocada");
	if (level.nota_tocada != "C6")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "C5")
	{
		level notify ("fail_note");
		break;
	}
 /////////////////////////////////////////////
 //////////////////////////////////////////////
	level waittill("nota_tocada");
	if (level.nota_tocada != "C6")
	{
		level notify ("fail_note");
		break;
	}
	level waittill("nota_tocada");
	if (level.nota_tocada != "E5")
	{
		level notify ("fail_note");
		break;
	}
	else
	{
		wait(0.5);
		thread playsoundok("zombies_songid");
		wait(10);
		level notify ("acertijo_5_resuelto");
			
	}
}
function pistas_colores()
{
	thread activar_desactivar_amarillo();
	thread activar_desactivar_azul();
	thread activar_desactivar_rojo();
	thread mostrar_colores();
}

function activar_desactivar_amarillo()
{
	tick = getEnt("tick_amarillo", "targetname");
	trig = getEnt("trig_amarillo", "targetname");
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		tick SetInvisibleToAll();
		level.amarillo_ON = false;
		trig SetHintString("Hold ^3&&1^7 to activate yellow");
		trig waittill("trigger", player);
		tick SetVisibleToAll();
		trig SetHintString("Hold ^3&&1^7 to desactivate yellow");
		level.amarillo_ON = true;
		trig waittill("trigger", player);
		
	}

}
function activar_desactivar_azul()
{
	tick = getEnt("tick_azul", "targetname");
	trig = getEnt("trig_azul", "targetname");
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		tick SetInvisibleToAll();
		level.azul_ON = false;
		trig SetHintString("Hold ^3&&1^7 to activate blue");
		trig waittill("trigger", player);
		tick SetVisibleToAll();
		trig SetHintString("Hold ^3&&1^7 to desactivate blue");
		level.azul_ON = true;
		trig waittill("trigger", player);
		
	}

}
function activar_desactivar_rojo()
{
	tick = getEnt("tick_rojo", "targetname");
	trig = getEnt("trig_rojo", "targetname");
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		tick SetInvisibleToAll();
		level.rojo_ON = false;
		trig SetHintString("Hold ^3&&1^7 to activate red");
		trig waittill("trigger", player);
		tick SetVisibleToAll();
		trig SetHintString("Hold ^3&&1^7 to desactivate red");
		level.rojo_ON = true;
		trig waittill("trigger", player);
		
	}

}
function mostrar_colores()
{
	rojo = getEnt("rojo", "targetname");
	azul = getEnt("azul", "targetname");
	amarillo = getEnt("amarillo", "targetname");
	verde = getEnt("verde", "targetname");
	naranja = getEnt("naranja", "targetname");
	morado = getEnt("morado", "targetname");
	negro = getEnt("negro", "targetname");
	blanco = getEnt("blanco", "targetname");
	thread esconder_todos_colores();
	while(1)
	{
		wait(0.5);
		if ((level.azul_ON == true) && (level.amarillo_ON == false) && (level.rojo_ON == false))
		{
			thread esconder_todos_colores();
			azul SetVisibleToAll();
		}
		if ((level.azul_ON == false) && (level.amarillo_ON == true) && (level.rojo_ON == false))
		{
			thread esconder_todos_colores();
			amarillo SetVisibleToAll();
		}
		if ((level.azul_ON == false) && (level.amarillo_ON == false) && (level.rojo_ON == true))
		{
			thread esconder_todos_colores();
			rojo SetVisibleToAll();
		}
		if ((level.azul_ON == true) && (level.amarillo_ON == true) && (level.rojo_ON == false))
		{
			thread esconder_todos_colores();
			verde SetVisibleToAll();
		}
		if ((level.azul_ON == true) && (level.amarillo_ON == false) && (level.rojo_ON == true))
		{
			thread esconder_todos_colores();
			morado SetVisibleToAll();
		}
		if ((level.azul_ON == false) && (level.amarillo_ON == true) && (level.rojo_ON == true))
		{
			thread esconder_todos_colores();
			naranja SetVisibleToAll();
		}
		if ((level.azul_ON == false) && (level.amarillo_ON == false) && (level.rojo_ON == false))
		{
			thread esconder_todos_colores();
			negro SetVisibleToAll();
		}
		if ((level.azul_ON == true) && (level.amarillo_ON == true) && (level.rojo_ON == true))
		{
			thread esconder_todos_colores();
			blanco SetVisibleToAll();
		}
	}
}
function esconder_todos_colores()
{
	rojo = getEnt("rojo", "targetname");
	azul = getEnt("azul", "targetname");
	amarillo = getEnt("amarillo", "targetname");
	verde = getEnt("verde", "targetname");
	naranja = getEnt("naranja", "targetname");
	morado = getEnt("morado", "targetname");
	negro = getEnt("negro", "targetname");
	blanco = getEnt("blanco", "targetname");
	rojo SetInvisibleToAll();
	azul SetInvisibleToAll();
	amarillo SetInvisibleToAll();
	verde SetInvisibleToAll();
	naranja SetInvisibleToAll();
	morado SetInvisibleToAll();
	negro SetInvisibleToAll();
	blanco SetInvisibleToAll();
}

/////////////////////////////////////////////////////////////////
//////////////ZONA 6    ZONA 6   ZONA 6 //////////////////////////
/////////////////////////////////////////////////////////////////

function zone6()
{
		//hacer invisibles

	for (i = 1; i < 4; i++)
	{
		juggernog = GetEnt("juggernog" + i, "targetname");
		deadshot = GetEnt("deadshot" + i, "targetname");
		staminup = GetEnt("staminup" + i, "targetname");
		quickrevive = GetEnt("quickrevive" + i, "targetname");
		speedcola = GetEnt("speedcola" + i, "targetname");
		mulekick = GetEnt("mulekick" + i, "targetname");
		monkey = GetEnt("monkey" + i, "targetname");
		pap = GetEnt("pap" + i, "targetname");
		juggernog  SetInvisibleToAll();
		deadshot SetInvisibleToAll();
		staminup  SetInvisibleToAll();
		quickrevive SetInvisibleToAll();
		speedcola  SetInvisibleToAll();
		mulekick  SetInvisibleToAll();
		monkey  SetInvisibleToAll();
		pap  SetInvisibleToAll();
	}








	level waittill ("acertijo_5_resuelto");
	//hacer visible



	//activar teleports
	thread teleport_final("teleport_final_1");
	thread teleport_final("teleport_final_2");

	//iniciar zona6
		flag::init( "zone6flag" ); 
    	flag::set("zone6flag");
    	piano = getEnt("piano", "targetname");
    	piano MoveZ(90,3);
    	PlaySoundAtPosition("girar_estatuaid", piano.origin);
    	puertaiz = getEnt("z4_62", "targetname");
    	puertaiz MoveTo((-6631,796,85),6);
    	puertaiz RotateTo((0,358,0),6);
    	
    	puertadch = getEnt("z4_63", "targetname");
    	puertadch MoveTo((-6631,895,85),6);
    	puertadch RotateTo((0,4,0),6);
    	clip_puerta_final = getEnt("clip_puerta_final", "targetname");
    	clip_puerta_final Delete();	


    	//funciones
    	thread acertijo_final();

}
function teleport_final(triggername)
{
	trig = getEnt(triggername, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to be teleported to the final riddle"); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
	if (player.playername == level.player0name)
	{
		player thread teleport_to("s_teleport_0");
	}
	if (player.playername == level.player1name)
	{
		player thread teleport_to("s_teleport_1");
	}
	if (player.playername == level.player2name)
	{
		player thread teleport_to("s_teleport_2");
	}
	if (player.playername == level.player3name)
	{
		player thread teleport_to("s_teleport_3");
	}
	}

}

function acertijo_final()
{
	thread init_logos();
	thread rotar_logos();
	thread controlador("right");
	thread controlador("left");
	thread controlador("up");
	thread controlador("down");
	thread controlador("turn");
	thread mira();
	thread juego_final();
	thread fin();

}

function init_logos()
{
	/*
	level.logo[(ijk)]
	i = fila
	j = columna
	k = 1 -> que logo es
	  = 2 -> true(normal), false(girado)
	  = 3 -> true(no objetivo), false(objetivo)
	
	*/
	level.logo[(111)] = "juggernog";
	level.logo[(121)] = "deadshot";
	level.logo[(131)] = "pap";
	level.logo[(141)] = "staminup";
	level.logo[(151)] = "quickrevive";

	level.logo[(211)] = "monkey";
	level.logo[(221)] = "deadshot";
	level.logo[(231)] = "monkey";
	level.logo[(241)] = "juggernog";
	level.logo[(251)] = "staminup";

	level.logo[(311)] = "pap";
	level.logo[(321)] = "speedcola";
	level.logo[(331)] = "pap";
	level.logo[(341)] = "quickrevive";
	level.logo[(351)] = "juggernog";

	level.logo[(411)] = "speedcola";
	level.logo[(421)] = "staminup";
	level.logo[(431)] = "quickrevive";
	level.logo[(441)] = "mulekick";
	level.logo[(451)] = "monkey";

	level.logo[(511)] = "deadshot";
	level.logo[(521)] = "juggernog";
	level.logo[(531)] = "mulekick";
	level.logo[(541)] = "staminup";
	level.logo[(551)] = "pap";

	for (i = 0; i < 6; i++)
	{
		for (j = 0; j < 6; j++)
		{
			number = (i*100)+(j*10)+2;
			level.logo[number] = true;
		}
	}

	for (i = 0; i < 6; i++)
	{
		for (j = 0; j < 6; j++)
		{
			number = (i*100)+(j*10)+3;
			level.logo[number] = false;
		}
	}
}

function rotar_logos()
{
	while(1)
	{
		wait(1);
	for (i = 0; i < 6; i++)
	{
		for (j = 0; j < 6; j++)
		{
			number = (i*100)+(j*10)+2;
			if (level.logo[number] == false)
			{				
				a = (10*i) + j;
				tabla[a] = GetEnt("logo_" + a, "targetname");
				tabla[a] RotateTo((0,180,0),1);
			}
			if (level.logo[number] == true)
			{
				a = (10*i) + j;
				tabla[a] = GetEnt("logo_" + a, "targetname");
				tabla[a] RotateTo((0,0,0),1);
			}
			
		}
	}
	}
}
function controlador(direccion)
{
	trig = getEnt(direccion, "targetname");
	trig SetHintString(direccion); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
		level.orden_mira = direccion;		
	}
}
function mira()
{
	i = 3;
	j = 3; //al inicio la mira esta en la posicion (3,3)
	level.orden_mira ="_";
	while(1)
	{
		wait(0.05);
		if (level.orden_mira == "down")
		{
			level.orden_mira ="_";
			if (i != 5)
			{
				i ++;
				thread move_mira(i,j);
			}
		}
		if (level.orden_mira == "up")
		{
			level.orden_mira ="_";
			if (i != 1)
			{
				i --;
				thread move_mira(i,j);
			}
		}
		if (level.orden_mira == "right")
		{
			level.orden_mira ="_";
			if (j != 5)
			{
				j ++;
				thread move_mira(i,j);
			}
		}
		if (level.orden_mira == "left")
		{
			level.orden_mira ="_";
			if (j != 1)
			{
				j --;
				thread move_mira(i,j);
			}
		}
		if (level.orden_mira == "turn")
		{
			level.orden_mira ="_";
			number = (i*100)+(j*10)+2;
			mira = getEnt("mira", "targetname");
			PlaySoundAtPosition("girar_estatuaid", mira.origin);

			if (level.logo[number] == false)
			{				
				level.logo[number] = true;
				
			}
			else
			{
				level.logo[number] = false;
				
			}
		}
	}
}
function move_mira(x,z)
{
	mira = getEnt("mira", "targetname");

	for (i = 0; i < 6; i++)
	{
		for (j = 0; j < 6; j++)
		{
			a = (10*i) + j;
			tabla[a] = GetEnt("logo_" + a, "targetname");
		}
	}
	number = (x*10) + z; // a que destino va la mira
	mira MoveTo(tabla[number].origin,0.2);
}

function juego_final()
{
	//objetivo 1
	level.i_objetivo1 = RandomIntRange(2,5); 
	level.j_objetivo1 = RandomIntRange(2,5); 
	level.objetivo1 = (level.i_objetivo1 * 10) + level.j_objetivo1;

	//objetivo 2
	while(1)
	{
		wait(0.05);
		level.i_objetivo2 = RandomIntRange(2,5); 
		level.j_objetivo2 = RandomIntRange(2,5); 
		level.objetivo2 = (level.i_objetivo2 * 10) + level.j_objetivo2;
		if (level.objetivo2 != level.objetivo1)
		{
			break;
		}
	}

	//objetivo 3
	while(1)
	{
		wait(0.05);
		level.i_objetivo3 = RandomIntRange(2,5); 
		level.j_objetivo3 = RandomIntRange(2,5); 
		level.objetivo3 = (level.i_objetivo3 * 10) + level.j_objetivo3;
		if ((level.objetivo3 != level.objetivo1) && (level.objetivo3 != level.objetivo2))
		{
			break;
		}
	}
	/*
	level.logo[(ijk)]
	i = fila
	j = columna
	k = 1 -> que logo es
	  = 2 -> true(normal), false(girado)
	  = 3 -> true(no objetivo), false(objetivo)
	
	*/

	//definir cuales son los objetivos
	for (i = 0; i < 6; i++)
	{
		for (j = 0; j < 6; j++)
		{
			number = (i*100)+(j*10)+3;
			level.logo[number] = true;
		}
	}

	number1 = (level.objetivo1 * 10) + 3;
	number2 = (level.objetivo2 * 10) + 3;
	number3 = (level.objetivo3 * 10) + 3;
	level.logo[number1] = false;
	level.logo[number2] = false;
	level.logo[number3] = false;



	thread mostrar_pistas(1,level.objetivo1);
	thread mostrar_pistas(2,level.objetivo2);
	thread mostrar_pistas(3,level.objetivo3);
	thread check_final_solution();

}

function mostrar_pistas(n,numero_objetivo)
{
	
	down_numero = numero_objetivo + 10;
	up_numero = numero_objetivo - 10;
	right_numero = numero_objetivo + 1;
	left_numero = numero_objetivo - 1;

	down_logo = (down_numero * 10) + 1;
	up_logo = (up_numero * 10) + 1;
	right_logo = (right_numero * 10) + 1;
	left_logo = (left_numero * 10) + 1;

	thread trigger_muestra_logo(n,"pista_down_",level.logo[down_logo]);
	thread trigger_muestra_logo(n,"pista_up_",level.logo[up_logo]);
	thread trigger_muestra_logo(n,"pista_right_",level.logo[right_logo]);
	thread trigger_muestra_logo(n,"pista_left_",level.logo[left_logo]);
}
function trigger_muestra_logo(n,triggername,logo)
{
	self endon ("final_challenge_completed");
	triggernametxt = triggername + n ;
	modelname = logo + n;

	trig = getEnt(triggernametxt, "targetname");
	model = getEnt(modelname, "targetname");

	while(1)
	{
		model SetInvisibleToAll();
		trig waittill("trigger", player);
		model SetVisibleToAll();
		wait(1);
	}

}

function check_final_solution()
{
	number1 = (level.objetivo1 * 10) + 2;
	number2 = (level.objetivo2 * 10) + 2;
	number3 = (level.objetivo3 * 10) + 2;
	while(1)
	{
		wait(0.05);
		numero_de_girados = 0;
		for (i = 0; i < 6; i++)
			{
				for (j = 0; j < 6; j++)
				{
					number = (i*100)+(j*10)+2;
					if (level.logo[number] == false)
					{
						numero_de_girados ++;
					}
				}
			}
		if (numero_de_girados == 3)
		{
			if ((level.logo[number1] == false) && (level.logo[number2] == false) && (level.logo[number3] == false))
			{
				wait(1.1); //dar tiempo a que gire
				
				level notify ("final_challenge_completed");
				break;
			}
		}

	}
}

function fin()
{
	level waittill ("final_challenge_completed");
	thread playsoundok("uncharted_soundtrackid");
	if (level.EzmodeON == false)
	{
		//Clear zombies
    zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
        wait(10);
        level thread brutus::spawn_brutus();
        wait(0.1);
        level thread brutus::spawn_brutus();
        wait(0.1);
        level thread brutus::spawn_brutus();
        wait(95);
        level notify ("map_completed");
        while(1)
        {
        	wait(45);
        	level thread brutus::spawn_brutus();
        }
	}
	else
	{
		wait(105);
		level notify ("map_completed");
	}
}

function map_completed()
{
	trig = getEnt("end_game", "targetname");
	trig SetHintString("Press and Hold ^3&&1^7 to end the game. (30k pts)"); 
	trig SetCursorHint("HINT_NOICON");
	trig SetInvisibleToAll();
	level waittill ("map_completed");
	IPrintLnBold("Congratulations! Left lion is the end of the map.");
	trig SetVisibleToAll();
	if (level.EzmodeON == true)
	{
		trig SetHintString("Press and Hold ^3&&1^7 to end the game!"); 
		trig waittill("trigger", player);
		level.custom_game_over_hud_elem = &function_f7b7d070;
		wait(0.5);
		level notify("end_game");
	}
	else
	{
		while(1)
		{
			trig waittill("trigger", player);
			if (player.score > 30000)
			{
				player.score -= 30000;
				level.custom_game_over_hud_elem = &function_f7b7d070;
				wait(0.5);
				level notify("end_game");
			}
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
	game_over SetText("Congratulations!");

	game_over FadeOverTime( 1 );
	game_over.alpha = 1;
	if ( player isSplitScreen() )
	{
		game_over.fontScale = 2;
		game_over.y += 40;
	}
}

////////////////////////////////////////////////////////////////////////////////////
/////////////////// FUNCIONES DE CAIDA  ////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

function caida_jugador()
{
	thread caida1();
	thread caida2();

}
function caida1()
{
	trig = getEnt("fall_trigger", "targetname");
	while(1)
	{
		trig waittill("trigger", player);
		player thread teleport_to("fall_spawn");
		wait(1);
	}
}
function caida2()
{
	trig = getEnt("fall_trigger2", "targetname");
	while(1)
	{
		trig waittill("trigger", player);
		player thread teleport_to("fall_spawn2");
		wait(1);
	}
}
function player_island(i,theplayer)
{
	if ((i==0) ||(i==1))
	{
		//es de la isla 1
		trig2 = getEnt("isla2_zone", "targetname");
		while(1)
		{
			trig2 waittill("trigger", player);
			if (player == theplayer)
			{
				wait(0.5);
				player thread teleport_players_start_challenge(i);
			}
		}
	}
	if ((i==2) ||(i==3))
	{
		//es de la isla 2
		trig1 = getEnt("isla1_zone", "targetname");
		while(1)
		{
			trig1 waittill("trigger", player);
			if (player == theplayer)
			{
				wait(0.5);
				player thread teleport_players_start_challenge(i);
			}
		}
	}
}