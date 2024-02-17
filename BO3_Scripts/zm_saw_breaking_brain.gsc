#using scripts\codescripts\struct;

#using scripts\zm\_zm_spawner;
#using scripts\shared\spawner_shared;

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

#using scripts\zm\logical\perks\_zm_perk_milk;

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

#using scripts\zm\zm_usermap;

#using scripts\lilrobot\_inspectable_weapons;
#using scripts\shared\ai\zombie_death;

#using scripts\zm\zm_flashlight;

//cinematica
#using scripts\shared\lui_shared;
//cellbreaker
#using scripts\zm\zm_cellbreaker;
//automatic door
#using scripts\zm\sliding_door;

#using scripts\shared\hud_util_shared;

#using scripts\zm\_zm_perks;

// WW2 Power Switch
#using scripts\fanatic\ww2\ww2_power_switch;

#using scripts\zm\zm_ammo_buy;

//tranzit lava
#using scripts\zm\transit_lava;

//checkpoint
#using scripts\shared\laststand_shared;
#using scripts\zm\_zm_laststand;

#precache("xanim", "cadenas_idle_bunker_tortura_abre");
#using_animtree("saw_map");

#precache("xanim", "johon_krammer_idle");
#using_animtree("saw_map");

#precache("xanim", "puerta_idle_bunker_tortura_abre");
#using_animtree("saw_map");

#precache("xanim", "cadenas_bunker_tortura_abre" );
#using_animtree("saw_map");

#precache("xanim", "puerta_bunker_tortura_abre" );
#using_animtree("saw_map");

#precache("xanim", "cabeza_tortura_muerte" );
#using_animtree("saw_map");

#precache("xanim", "cabeza_tortura_idle");
#using_animtree("saw_map");

#precache("xanim", "ai_bot_saw_gillotina");
#using_animtree("saw_map");

#precache("xanim", "cucarachas_andando");
#using_animtree("saw_map");

#precache("xanim", "pighead_revisando_loop");
#using_animtree("saw_map");

#precache("xanim", "pendulo");
#using_animtree("saw_map");

#precache("xanim", "jigsaw_habla_colgado" );
#using_animtree("saw_map");

#precache("xanim", "ai_bot_saw_idle" );
#using_animtree("saw_map");

#precache("xanim", "ai_bot_saw_corre" );
#using_animtree("saw_map");

#precache("xanim", "anim_puerta_boss_abierto" );
#using_animtree("saw_map");

#precache("xanim", "anim_puerta_boss_cerrado" );
#using_animtree("saw_map");


#precache("xanim", "jigsaw_triciclo" );
#using_animtree("saw_map");
#precache("xanim", "jigsaw_triciclo_billy" );
#using_animtree("saw_map");

#precache("xanim", "bot_1_idle" );
#using_animtree("saw_map");
#precache("xanim", "bot_1_electrificado" );
#using_animtree("saw_map");
#precache("xanim", "bot_1_muerte_electrica" );
#using_animtree("saw_map");
#precache("xanim", "trampa1_agua" );
#using_animtree("saw_map");
#precache("xanim", "trampa2_agua" );
#using_animtree("saw_map");
#precache("xanim", "trampa3_agua" );
#using_animtree("saw_map");
#precache("xanim", "trampa4_agua" );
#using_animtree("saw_map");
#precache("xanim", "trampa5_agua" );
#using_animtree("saw_map");
#precache("xanim", "trampa5a_agua" );
#using_animtree("saw_map");
#precache("xanim", "trampa7_agua" );
#using_animtree("saw_map");
#precache("xanim", "trampa8_agua_muerte" );
#using_animtree("saw_map");
#precache("xanim", "victima1_colgado_loop" );
#using_animtree("saw_map");
#precache("xanim", "victima1_muerte_de_pendulo" );
#using_animtree("saw_map");
#precache("xanim", "ai_bot_saw_muere" );
#using_animtree("saw_map");

#precache("xanim", "saw_pasiente1_loop");
#using_animtree("saw_map");

#precache("xanim", "saw_pasiente1_trampa_osos");
#using_animtree("saw_map");

#precache("xanim", "saw_trampa1_loop_colgado");
#using_animtree("saw_map");

#precache("xanim", "saw_trampa1_loop_colgado_muere");
#using_animtree("saw_map");

#precache("xanim", "saw_pasiente1_loop_parado");
#using_animtree("saw_map");

#precache("xanim", "zmb_tower_elec_lever_reverse" );
#using_animtree("saw_map");
#precache("xanim", "zmb_tower_elec_lever_pull" );
#using_animtree("saw_map");


#precache("xanim", "saw_trampa1_loop_colgado" );
#using_animtree("saw_map");

//ganzua
#precache( "material", "ganzua0" ); 
#precache( "material", "ganzua1" );
#precache( "material", "ganzua2" );
#precache( "material", "ganzua3" );
#precache( "material", "ganzua_error" );
//hud intro
#precache( "material", "saw_hudintro1" );
#precache( "material", "saw_hudintro2" );
#precache( "material", "saw_hudintro3" );
#precache( "material", "saw_hudintro4" );
#precache( "material", "saw_hudintro5" );

//fuego
#precache( "fx", "dlc3/stalingrad/fx_fire_inferno_tall_1_evb_md_stalingrad" );
#precache( "fx", "dlc5/cosmo/fx_weather_lightning_cheap_tower_impact");

//CHeckpoint
#precache( "material", "checkpoint_saw" );

//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{
	inspectable::add_inspectable_weapon( GetWeapon("iw8_357"), 4.66 );
    inspectable::add_inspectable_weapon( GetWeapon("iw8_357_up"), 4.66 );
    inspectable::add_inspectable_weapon( GetWeapon("s2_win21"), 4.33 );
    inspectable::add_inspectable_weapon( GetWeapon("s2_win21_up"), 4.33 );
    inspectable::add_inspectable_weapon( GetWeapon("t9_nailgun"), 4.7 );
    inspectable::add_inspectable_weapon( GetWeapon("t9_nailgun_up"), 4.7 );

//________________________________________[HUD]________________________________________//
	clientfield::register( "clientuimodel", "zmhud.playerHealth", VERSION_SHIP, 7, "float" ); //gsc hud stuff aboce usermap::main
	callback::on_spawned( &playerSetupHud );
//________________________________________[HUD]________________________________________//
	zm_usermap::main();


	startingWeapon = "t9_me_knife_american";
    weapon = getWeapon(startingWeapon);
    level.start_weapon = (weapon);
	
	level._zombie_custom_add_weapons =&custom_add_weapons;

	thread hud_intro();
    thread sin_regeneracion_de_vida();
	thread sala_1();
	thread puzzle_nueve_valvulas();
	thread reloj();
	thread puzzle_luz();
	thread puzzle_espejo();
	thread minibossfight();
	thread sin_granadas();
	thread puzzle_jaulas();
	thread puertas_primer_pasillo();
	thread sustos_laberinto();

	thread pikup357();
	thread llave_iglesa();
	thread axe_saw();
	// WW2 Power Switch
    ww2_power_switch::init();

    level.musicplay = false;
	thread musicplaying();

	//GANZUA
	thread ganzua(1);//puerta con ganzua numero 1
	thread ganzua(2);//puerta con ganzua numero 1
	thread ganzua(3);//puerta con ganzua numero 1
	thread get_ganzuas();
	thread check_botones();
	thread premios();
	
	thread puerta_animada();
	thread puzzle_pecados_capitales();
	thread snote();

	thread quitar_tablones_laberinto();
	thread fuego_laberinto();
	thread llaves_laberinto();
	thread init_keycard();
	

	thread telefonos();

	thread cabezas_billy();
	thread billy_triciclo();

	thread check_points();
	thread spawnear_zombies_zona();
	thread zonas_corren();

	thread creditos();

	zm_ammo_buy::main();

	thread bossfight();

	sliding_door::init(  );
	thread teleport_zombies_init();

	spawner::add_archetype_spawn_function( "zombie", &eye_fx );
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	level.pathdist_type = PATHDIST_ORIGINAL;

	level.no_powerups = true;

	level thread zm_utility::zombie_goto_round( 25 );

	model = getEnt("john_revisa_juego", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %pighead_revisando_loop);

    model = getEnt("john", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %johon_krammer_idle);

	model = getEnt("cabeza", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %cabeza_tortura_idle);

    model = getEnt("puerta", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %puerta_idle_bunker_tortura_abre);

    model = getEnt("cadenas", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %cadenas_idle_bunker_tortura_abre);

    model = getEnt("cucarachas1", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %cucarachas_andando);

    model = getEnt("cucarachas2", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %cucarachas_andando);

    model = getEnt("cucarachas3", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %cucarachas_andando);

    model = getEnt("cucarachas4", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %cucarachas_andando);

    model = getEnt("pendulo", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %pendulo);

    tom_incorporado = getEnt("tom_incorporado", "targetname");
	tom_incorporado useanimtree(#animtree);
    tom_incorporado AnimScripted( "ai_bot_saw_idle", tom_incorporado.origin , tom_incorporado.angles, %ai_bot_saw_idle);
    tom_incorporado SetInvisibleToAll();

    tom_telefonos = getEnt("tom_telefonos", "targetname");
	tom_telefonos useanimtree(#animtree);
    tom_telefonos AnimScripted( "ai_bot_saw_idle", tom_telefonos.origin , tom_telefonos.angles, %ai_bot_saw_idle);
    tom_telefonos SetInvisibleToAll();

    tom_entra_relojes = getEnt("tom_entra_relojes", "targetname");
    tom_entra_relojes SetInvisibleToAll();

    tom_despedida = getEnt("tom_despedida", "targetname");
	tom_despedida useanimtree(#animtree);
    tom_despedida AnimScripted( "ai_bot_saw_idle", tom_despedida.origin , tom_despedida.angles, %ai_bot_saw_idle);
    tom_despedida SetInvisibleToAll();

    tom_sale = getEnt("tom_sale", "targetname");
    tom_sale SetInvisibleToAll();

    model = getEnt("tom_tumbado", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %ai_bot_saw_gillotina);

    model = getEnt("bot3", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %saw_trampa1_loop_colgado);

    model = getEnt("john_idle", "targetname");
    model useanimtree(#animtree);
    model AnimScripted( "optionalNotify", model.origin , model.angles, %johon_krammer_idle);
}

function usermap_test_zone_init()
{
	zm_zonemgr::add_adjacent_zone("start_zone","boss_zone","boss_flag");
	level flag::init( "always_on" );
	level flag::set( "always_on" );
    flag::init("boss_flag");
    flag::set("boss_flag");
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

function sin_regeneracion_de_vida()
{
    level flag::wait_till("initial_blackscreen_passed");
    curaciones = GetEntArray("curacion", "targetname");
    foreach (curacion in curaciones)
    {
        thread sistema_curacion(curacion);
    }
    while(1)
    {
        WAIT_SERVER_FRAME;
        foreach(player in getplayers())
        {
            player.hurtAgain = true;
        }
    }
}

function eye_fx()
{
	self.no_eye_glow = true;
}

function sistema_curacion(trig)
{
	trig SetHintString( "Press and Hold ^3&&1^7 to heal you" );  
	trig SetCursorHint("HINT_NOICON");
	model = getEnt(trig.target, "targetname");
	while(1)
	{
		trig waittill( "trigger", player );
		if (player.health < player.maxHealth)
		{
			player notify("clear_red_flashing_overlay"); 
			player.health = player.maxHealth;
			model SetInvisibleToAll();
			trig SetInvisibleToAll();
			wait(150);
			model SetVisibleToAll();
			trig SetVisibleToAll();
		}
	}
	
}

function sin_granadas()
{
    level flag::wait_till("initial_blackscreen_passed");
    foreach(player in getplayers())
    {
        player DisableOffhandWeapons();
    }
}

function pikup357()
{
	revolver357 = getEnt("revolver357","targetname");
	trig_weap = getEnt("weapon_pickup","targetname");

    trig_weap waittill("trigger",player);
    weapon = GetWeapon("iw8_357");
    armas = player GetWeaponsListPrimaries();
	if (armas.size >= 2)
	{		
		player TakeWeapon(player GetCurrentWeapon());
	}
    player GiveWeapon(weapon);
    player SwitchToWeapon(weapon);

    revolver357 Delete();
    trig_weap Delete();

}

function llave_iglesa()
{
	llave_ig = getEnt("llave_igl","targetname");
	trig_weap_igl = getEnt("weapon_pickup_igl","targetname");

    trig_weap_igl waittill("trigger",player);

    weapon = GetWeapon("melee_wrench");
    armas = player GetWeaponsListPrimaries();
	if (armas.size >= 2)
	{		
		player TakeWeapon(player GetCurrentWeapon());
	}
    player GiveWeapon(weapon);
    player SwitchToWeapon(weapon);

    llave_ig Delete();
    trig_weap_igl Delete();

}

function axe_saw()
{
	axe_we = getEnt("axe","targetname");
	trig_weap_axe = getEnt("weapon_pickup_axe","targetname");
    trig_weap_axe SetHintString( "Hold ^3&&1^7 to activate mechanism" ); 

    trig_weap_axe waittill("trigger",player);

    weapon = GetWeapon("melee_fireaxe");
    armas = player GetWeaponsListPrimaries();
	if (armas.size >= 2)
	{		
		player TakeWeapon(player GetCurrentWeapon());
	}
    player GiveWeapon(weapon);
    player SwitchToWeapon(weapon);

    axe_we Delete();
    trig_weap_axe Delete();

}

//________________________________________[HUD]________________________________________//
function playerSetupHud()
{
    self.shield = 0;
    level waittill("initial_blackscreen_passed");
    self thread playerHealthUpdate();
}

function playerHealthUpdate()
{
    self endon("disconnect");
    level endon( "game_ended" );

    self notify("healthWatchStart");
    self endon("healthWatchStart");

    self clientfield::set_player_uimodel( "zmhud.playerHealth", 1 );

    lastHealth = self.health;
  
    while(1)
    {
        if(self laststand::player_is_in_laststand())
        {
            lastHealth = 0;
            self clientfield::set_player_uimodel( "zmhud.playerHealth", -1 );
        }
        else if(lastHealth != self.health)
        {
            lastHealth = self.health;
            scaledHealth = scalePlayerHealth(0, self.maxhealth, self.health, 0, 100);
            self clientfield::set_player_uimodel( "zmhud.playerHealth", scaledHealth/100 );
        }

        wait 0.05;
    }
}

function scalePlayerHealth(min, max, current, newMin, newMax)
{
    if(min > max || newmin > newMin) return;

    temp = (current - min) / (max - min);
    scaledResult = temp * (newMax - newMin) + newMin ;
    return scaledResult;
}
//________________________________________[HUD]________________________________________//
function playsoundok(sound)
{
	level.playSoundLocation PlaySound(sound);
	players = GetPlayers();
		for (i = 0;i<players.size;i++)

		{
		players[i] PlayLocalSound(sound);}
}
function codigo_numerico(nombre,numero_inicial)
{
	for( i = 0; i < 10; i++ )
	{
		array = GetEntArray("num"+i, "targetname");  //targetname el numero  target el identificativo
		foreach (num in array)
		{
			if (num.target == nombre)
			{
				numero[i] = num;
				numero[i] SetInvisibleToAll();
			}
			
		}
		
	}
	numero[numero_inicial] SetVisibleToAll();
	level.numero_mostrado[nombre] = numero_inicial;

	trig = getEnt(nombre, "targetname");
	trig SetHintString( "" );  
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );
		PlaySoundAtPosition("cambiar_numero",trig.origin);
		prev = level.numero_mostrado[nombre];
		level.numero_mostrado[nombre] ++;
		if (level.numero_mostrado[nombre] >= 10){level.numero_mostrado[nombre] = 0;}
		numero[level.numero_mostrado[nombre]] SetVisibleToAll();
		numero[prev] SetInvisibleToAll();
		wait(0.3);
	}


}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// PUZZLE TELEFONOS 			PUZZLE TELEFONOS             PUZZLE TELEFONOS 	
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
function telefonos()
{
	level flag::wait_till("initial_blackscreen_passed");
	trig = getEnt("trig_sala_telefono", "targetname");
	puerta_laberinto_de_abierta = getEnt("puerta_laberinto_de_abierta", "targetname");
	puerta_laberinto_iz_abierta = getEnt("puerta_laberinto_iz_abierta", "targetname");
	puerta_laberinto_de_abierta SetInvisibleToAll();
	puerta_laberinto_iz_abierta SetInvisibleToAll();

	puerta = getEnt("sala_telefono", "targetname");
	DIST = 200;       // <-- ajustar al mapa
	puerta_salida_tom_abierta = getEnt("puerta_salida_tom_abierta", "targetname");
	puerta_salida_tom_abierta SetInvisibleToAll();
	level waittill("subir_puerta_telefonos");
	puerta MoveZ(DIST,4);
	PlaySoundAtPosition("puerta_garaje",puerta.origin);
	txt1 = "^4 TOM: ^7Oh! Thank you for saving me. What the hell is this?  ";
	txt2 = "What kind of twisted mind designed this tramps?... thank you again. ";
	txt3 = "Take this, it will be useful for us.";
	txt4 = "";
	if (level.idioma == "SPANISH")
	{
		txt1 = "^4 TOM: ^7Oh! Gracias por salvarme. ¿Qué demonios es esto?  ";
		txt2 = "¿Qué mente enferma ha diseñado estas trampas?...Gracias de nuevo.";
		txt3 = "Toma esto. Nos será util.";
		txt4 = "";
	}
	thread crear_texto(txt1,txt2,txt3,txt4,13);

	thread control_telefonos();

	while(1)
	{
		trig waittill( "trigger", player );
		count = 0;
		n = 0;
		foreach(player in getplayers())
		{
			n++;
			if (player IsTouching(trig))
			{
				count ++;
			}
		}
		if (n == count)
		{
			foreach(player in getplayers())
			{
				n++;
				if (player IsTouching(trig))
				{
					count ++;
				}
			}
			if (n == count)
			{
				
				array::thread_all( GetPlayers(), &cinematica_telefonos, self );
				wait(1);
				puerta MoveZ(-DIST,1);
				PlaySoundAtPosition("puerta_garaje",puerta.origin);
				break;
			}
		}
	}
	//AHORA LOS JUGADORES ESTAN CERRADOS EN LA SALA DE LOS TELEFONOS
	thread cronometro_pista_telefonos();
	thread telefonos_molestos();
	wait(4);
	thread sonar_tono(1);
	level.ha_superado_algun_telefono=false;
	while(1)
	{
		WAIT_SERVER_FRAME;
		if(level.control_telefonos[1]==1)
		{
			if(level.control_telefonos[2]==2)
			{
				if(level.control_telefonos[3]==1)
				{
					if(level.control_telefonos[4]==3)
					{
						if(level.control_telefonos[5]==2)
						{
							level notify ("fin_sonido");
							break;
						}
					}
				}
			}
		}
	}
	thread sonar_tono(2);
	wait(2);
	while(1)
	{
		WAIT_SERVER_FRAME;
		if(level.control_telefonos[1]==2)
		{
			if(level.control_telefonos[2]==1)
			{
				if(level.control_telefonos[3]==1)
				{
					if(level.control_telefonos[4]==3)
					{
						if(level.control_telefonos[5]==2)
						{
							level notify ("fin_sonido");
							break;
						}
					}
				}
			}
		}
	}
	level.ha_superado_algun_telefono=true;
	thread sonar_tono(3);
	wait(2);
	while(1)
	{
		WAIT_SERVER_FRAME;
		if(level.control_telefonos[1]==1)
		{
			if(level.control_telefonos[2]==3)
			{
				if(level.control_telefonos[3]==3)
				{
					if(level.control_telefonos[4]==3)
					{
						if(level.control_telefonos[5]==2)
						{
							level notify ("fin_sonido");
							break;
						}
					}
				}
			}
		}
	}
	thread sonar_tono(4);
	wait(2);
	while(1)
	{
		WAIT_SERVER_FRAME;
		if(level.control_telefonos[1]==3)
		{
			if(level.control_telefonos[2]==1)
			{
				if(level.control_telefonos[3]==1)
				{
					if(level.control_telefonos[4]==1)
					{
						if(level.control_telefonos[5]==2)
						{
							level notify ("fin_sonido");
							break;
						}
					}
				}
			}
		}
	}
	level notify("fin_puzzle_telefonos");
	wait(2);
	array::thread_all( GetPlayers(), &cinematica_salida_telefonos, self );
	wait(1);
		txt1 = "^1 JIGSAW: ^7Hello, players. You've formed a good team, but nothing lasts forever. ";
		txt2 = "Tom, if you want to retrieve your daughter, it's better ";
		txt3 = "that you go through that door alone.";
		txt4 = "";
		if (level.idioma == "SPANISH")
		{
		txt1 = "^1 JIGSAW: ^7Hola, jugadores. Habeis formado un buen equipo, pero nada dura para siempre. ";
		txt2 = "Tom, si quieres recuperar a tu hija, es mejor ";
		txt3 = "que cruces tu solo por esa puerta.";
		txt4 = "";
		}
		thread crear_texto(txt1,txt2,txt3,txt4,8);
		wait(8);
		txt1 = "^1 JIGSAW: ^7However, the rest of you must enter in the maze, find the key, retrace your steps, ";
		txt2 = "and you will discover the door that will lead you to the next challenge. ";
		txt3 = "The game continues.";
		txt4 = "";
		if (level.idioma == "SPANISH")
		{
		txt1 = "^1 JIGSAW: ^7Sin embargo, los demas debeis entrar en el laberinto, encontrar la llave, ";
		txt2 = "regresar por donde habeis venido y encontrareis la puerta que os llevará al proximo reto. ";
		txt3 = "El juego continua...";
		txt4 = "";
		}
		thread crear_texto(txt1,txt2,txt3,txt4,10);
	level waittill("tom5");
		txt1 = "^4 TOM: ^7I think I'm going to listen to him. I don't want to end up";
		txt2 = "trapped like before. I hope to see you again, good luck on your way.";
		txt3 = "";
		txt4 = "";
		if (level.idioma == "SPANISH")
		{
		txt1 = "^4 TOM: ^7Creo que voy a hacerle caso. No quiero acabar atrapado ";
		txt2 = "como antes. Espero volver a verte de nuevo, buena suerte en tu camino. ";
		txt3 = "";
		txt4 = "";
		}
		thread crear_texto(txt1,txt2,txt3,txt4,8);
	level waittill ("abrir_puerta_tom");
	puerta_salida_tom = getEnt("puerta_salida_tom", "targetname");
	origin_inicial = puerta_salida_tom.origin;
	angles_inicial = puerta_salida_tom.angles;
	puerta_salida_tom MoveTo(puerta_salida_tom_abierta.origin,1);	
	puerta_salida_tom RotateTo(puerta_salida_tom_abierta.angles,1);
	PlaySoundAtPosition("abrir_puerta",puerta_salida_tom.origin);
	wait(2);
	puerta_salida_tom MoveTo(origin_inicial,1);	
	puerta_salida_tom RotateTo(angles_inicial,1);
	level waittill ("subir_puerta_laberinto");
	puerta_laberinto_de = getEnt("puerta_laberinto_de", "targetname");
	puerta_laberinto_iz = getEnt("puerta_laberinto_iz", "targetname");
	clip_puerta_laberinto_de = getEnt("clip_puerta_laberinto_de", "targetname");
	clip_puerta_laberinto_iz = getEnt("clip_puerta_laberinto_iz", "targetname");

					clip_puerta_laberinto_de EnableLinkTo();
					clip_puerta_laberinto_de LinkTo(puerta_laberinto_de);
					puerta_laberinto_de MoveTo(puerta_laberinto_de_abierta.origin,1);
					puerta_laberinto_de RotateTo(puerta_laberinto_de_abierta.angles,1);

					clip_puerta_laberinto_iz EnableLinkTo();
					clip_puerta_laberinto_iz LinkTo(puerta_laberinto_iz);
					puerta_laberinto_iz MoveTo(puerta_laberinto_iz_abierta.origin,1);
					puerta_laberinto_iz RotateTo(puerta_laberinto_iz_abierta.angles,1);
					PlaySoundAtPosition("abrir_puerta",puerta_laberinto_iz.origin);

	PlaySoundAtPosition("puerta_madera",puerta_laberinto_iz.origin);
	level waittill ("subir_salida_telefonos");
	puerta MoveZ(DIST,1); 
	//clip MoveZ(DIST,1); 
}

function telefonos_molestos()
{	
	self endon ("fin_puzzle_telefonos");
	telefonos = GetEntArray("telefono", "targetname");
	while(1)
	{
		i = RandomIntRange(0,telefonos.size); //(min result, max rasult + 1) 
		PlaySoundAtPosition("telefono_clasico",telefonos[i].origin);
		wait(3);
	}

}
function sonar_tono(i)
{
	self endon ("fin_sonido");
	while(1)
	{
		trig = getEnt("trig_telefono_3", "targetname");
		PlaySoundAtPosition("telefono"+i,trig.origin);
		wait(5);
	}
}
function control_telefonos()
{
	thread barra_control_telefonos(1);
	thread barra_control_telefonos(2);
	thread barra_control_telefonos(3);
	thread barra_control_telefonos(4);
	thread barra_control_telefonos(5);
}
function barra_control_telefonos(i)
{
	trig = getEnt("trig_telefono_"+i, "targetname");
	trig SetHintString( "" );
	trig SetCursorHint("HINT_NOICON");
	b1on = getEnt("b_on_1_"+i, "targetname");	
	b2on = getEnt("b_on_2_"+i, "targetname");
	b3on = getEnt("b_on_3_"+i, "targetname");
	b1off = getEnt("b_off_1_"+i, "targetname");	
	b2off = getEnt("b_off_2_"+i, "targetname");
	b3off = getEnt("b_off_3_"+i, "targetname");
	b1on SetInvisibleToAll();
	b2on SetInvisibleToAll();
	b3on SetInvisibleToAll();


	level.control_telefonos[i]=0;

	while(1)
	{
		trig waittill( "trigger", player );
			PlaySoundAtPosition("seleccionar",trig.origin);
		b1on SetVisibleToAll();
		level.control_telefonos[i] ++;
		wait(0.2);
		trig waittill( "trigger", player );
			PlaySoundAtPosition("seleccionar",trig.origin);
		b2on SetVisibleToAll();
		level.control_telefonos[i] ++;
		wait(0.2);
		trig waittill( "trigger", player );
			PlaySoundAtPosition("seleccionar",trig.origin);
		b3on SetVisibleToAll();
		level.control_telefonos[i] ++;
		wait(0.2);
		trig waittill( "trigger", player );
			PlaySoundAtPosition("seleccionar",trig.origin);
		b1on SetInvisibleToAll();
		b2on SetInvisibleToAll();
		b3on SetInvisibleToAll();
		level.control_telefonos[i] = 0;
		wait(0.2);
	}


}

function cronometro_pista_telefonos()
{
	self endon ("fin_puzzle_telefonos");
	wait(12);
	tom_telefonos = getEnt("tom_telefonos", "targetname");
	PlaySoundAtPosition("tom3",tom_telefonos.origin);
	txt1 = "^4 TOM: ^7These phones are driving me crazy! I can't think!";
	txt2 = "";
	txt3 = "";
	txt4 = "";
	if (level.idioma == "SPANISH")
		{
		txt1 = "^4 TOM: ^7¡Estos telefonos me estan volviendo loco, no puedo pensar!";
		txt2 = "";
		txt3 = "";
		txt4 = "";
		}
	thread crear_texto(txt1,txt2,txt3,txt4,4);
	wait(50);
	if (level.ha_superado_algun_telefono == false)
	{
		PlaySoundAtPosition("tom4",tom_telefonos.origin);
		txt1 = "^4 TOM: ^7Hey, I think it has something to do with those beeps.";
		txt2 = "There are 5 beeps, just like the buttons here.";
		txt3 = "Maybe it's about the pitch, like some are higher and others are lower.";
		txt4 = "";
		if (level.idioma == "SPANISH")
		{
		txt1 = "^4 TOM: ^7Hey, creo que tiene que ver con esos pitidos. ";
		txt2 = "Hay 5 pitidos, justo como el numero de botones aqui.";
		txt3 = "Quizas tiene algo que ver con el tono, unos son mas agudos y otros mas graves...";
		txt4 = "";
		}
		thread crear_texto(txt1,txt2,txt3,txt4,18);
	}
	
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// CINEMATICAS 			CINEMATICAS             CINEMATICAS 	
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
function cinematica_jisaw_colgado()
{
	level.es_cinematica = true;
	//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }

	cin_1 = struct::get("cin_colgado_1", "targetname");
	cin_2 = struct::get("cin_colgado_2", "targetname");
	cin_3 = struct::get("cin_colgado_3", "targetname");
	cin_4 = struct::get("cin_colgado_4", "targetname");
	cin_5 = struct::get("cin_colgado_5", "targetname");

	self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
    self CameraActivate(true);
    self FreezeControls(true);
	self PlayLocalSound("jisaw2");
	self StartCameraTween(1);
	self CameraSetLookAt(cin_1);
    self CameraSetPosition(cin_1.origin, cin_1.angles);
    wait(1);
    self StartCameraTween(13);
	self CameraSetLookAt(cin_5);
    self CameraSetPosition(cin_5.origin, cin_5.angles);
    wait(13);
    self PlayLocalSound("atado1");
    self StartCameraTween(2);
	self CameraSetLookAt(cin_2);
    self CameraSetPosition(cin_2.origin, cin_2.angles);
    wait(3);
    self StartCameraTween(2);
    self CameraSetLookAt(cin_3);
    self CameraSetPosition(cin_3.origin, cin_3.angles);
    wait(3);
    self StartCameraTween(2);
    self CameraSetLookAt(cin_4);
    self CameraSetPosition(cin_4.origin, cin_4.angles);
    wait(3);
    self StartCameraTween(2);
    self CameraSetLookAt(cin_5);
    self CameraSetPosition(cin_5.origin, cin_5.angles);
    wait(3);
    self CameraSetPosition(self GetTagOrigin("j_head").origin, self GetTagOrigin("j_head").angles);
	self CameraActivate(false);
	self FreezeControls(false);
	level.es_cinematica = false;
}
function cinematica_tortura()
{
	level.es_cinematica = true;
	//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }

	cin_1 = struct::get("cin_tortura_1", "targetname");
	cin_2 = struct::get("cin_tortura_2", "targetname");
	cin_3 = struct::get("cin_tortura_3", "targetname");
	cin_4 = struct::get("cin_tortura_4", "targetname");
	self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
    self CameraActivate(true);
    self FreezeControls(true);
	
	self StartCameraTween(1);
	self CameraSetLookAt(cin_1);
    self CameraSetPosition(cin_1.origin, cin_1.angles);
    wait(1);
    self PlayLocalSound("jisaw4");
    self StartCameraTween(6);
	self CameraSetLookAt(cin_2);
    self CameraSetPosition(cin_2.origin, cin_2.angles);
    wait(5);
    self PlayLocalSound("atado4");
    wait(1);
    self StartCameraTween(1);
    self CameraSetLookAt(cin_3);
    self CameraSetPosition(cin_3.origin, cin_3.angles);
    wait(1);
    self StartCameraTween(12);
    self CameraSetLookAt(cin_4);
    self CameraSetPosition(cin_4.origin, cin_4.angles);
    wait(12);
    self CameraSetPosition(self GetTagOrigin("j_head").origin, self GetTagOrigin("j_head").angles);
	self CameraActivate(false);
	self FreezeControls(false);

	clip_puerta_tortura = getEnt("clip_puerta_tortura", "targetname");
	clip_puerta_tortura Delete();

	level.es_cinematica = false;
}
function cinematica_telefonos()
{
	level.es_cinematica = true;
	//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }

	cin_1 = struct::get("cin_1", "targetname");
	cin_2 = struct::get("cin_2", "targetname");
	cin_3 = struct::get("cin_3", "targetname");
	tom_incorporado = getEnt("tom_incorporado", "targetname");
	tom_incorporado SetInvisibleToAll();
	tom_entra_relojes = getEnt("tom_entra_relojes", "targetname");
    tom_entra_relojes SetVisibleToAll();
    tom_entra_relojes useanimtree(#animtree);
    tom_entra_relojes AnimScripted( "ai_bot_saw_corre", tom_entra_relojes.origin , tom_entra_relojes.angles, %ai_bot_saw_corre);

    self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
    self CameraActivate(true);
    self FreezeControls(true);
	
	self StartCameraTween(1);
	self CameraSetLookAt(cin_1);
    self CameraSetPosition(cin_1.origin, cin_1.angles);
	
	wait 2;
	
	self StartCameraTween(3);
	self CameraSetLookAt(cin_2);
    self CameraSetPosition(cin_2.origin, cin_2.angles);

    tom_telefonos = getEnt("tom_telefonos", "targetname");
    tom_telefonos SetVisibleToAll();
    tom_entra_relojes SetInvisibleToAll();
	wait 5;
	self StartCameraTween(3);
	self CameraSetLookAt(cin_3);
    self CameraSetPosition(cin_3.origin, cin_3.angles);

   wait 4;

	
	//self lui::screen_fade_in(1);
    self CameraSetPosition(self GetTagOrigin("j_head").origin, self GetTagOrigin("j_head").angles);
	self CameraActivate(false);
	self FreezeControls(false);


	level.es_cinematica = false;
}
function cinematica_salida_telefonos()
{
	level.es_cinematica = true;
	//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }

	cin_1 = struct::get("cin_tel_1", "targetname");
	cin_2 = struct::get("cin_tel_2", "targetname");
	cin_3 = struct::get("cin_tel_3", "targetname");
	cin_4 = struct::get("cin_tel_4", "targetname");
	cin_5 = struct::get("cin_tel_5", "targetname");
	cin_6 = struct::get("cin_tel_6", "targetname");

    self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
    self CameraActivate(true);
    self FreezeControls(true);
	
	self StartCameraTween(1);
	self CameraSetLookAt(cin_1);
    self CameraSetPosition(cin_1.origin, cin_1.angles);
	
	wait 1;
	self PlayLocalSound("jisaw5");
	self StartCameraTween(19);
	self CameraSetLookAt(cin_2);
    self CameraSetPosition(cin_2.origin, cin_2.angles);

    tom_despedida = getEnt("tom_despedida", "targetname");
    tom_despedida SetVisibleToAll();
    tom_telefonos = getEnt("tom_telefonos", "targetname");
    tom_telefonos SetInvisibleToAll();
    i = self.characterindex;
    destinations[i] = struct::get( "despedida_teleport_" + i, "targetname" ); 
    self setorigin( destinations[i].origin );
    self setplayerangles( destinations[i].angles );

    wait 19;
    level notify ("tom5");
    self PlayLocalSound("tom5");
	self StartCameraTween(1);
	self CameraSetLookAt(cin_3);
    self CameraSetPosition(cin_3.origin, cin_3.angles);
    wait 1;
	self StartCameraTween(9);
	self CameraSetLookAt(cin_4);
    self CameraSetPosition(cin_4.origin, cin_4.angles);
    wait 9;
	self StartCameraTween(2);
	self CameraSetLookAt(cin_5);
    self CameraSetPosition(cin_5.origin, cin_5.angles);

    wait(1);
    level notify ("abrir_puerta_tom");
    wait(1);
    tom_despedida SetInvisibleToAll();
    tom_sale = getEnt("tom_sale", "targetname");
    tom_sale SetVisibleToAll();
    tom_sale useanimtree(#animtree);
    tom_sale AnimScripted( "ai_bot_saw_corre", tom_sale.origin , tom_sale.angles, %ai_bot_saw_corre);

   wait 3;
   self StartCameraTween(0.5);
	self CameraSetLookAt(cin_6);
    self CameraSetPosition(cin_6.origin, cin_6.angles);
    wait(0.5);
    level notify ("subir_puerta_laberinto");
    wait(2);

	
	//self lui::screen_fade_in(1);
    self CameraSetPosition(self GetTagOrigin("j_head").origin, self GetTagOrigin("j_head").angles);
	self CameraActivate(false);
	self FreezeControls(false);
	level notify ("subir_salida_telefonos");

	level.es_cinematica = false;

}
function cinematica_minibossfight()
{
	level.es_cinematica = true;
	//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }

	cin_1 = struct::get("cin_mini_1", "targetname");
	cin_2 = struct::get("cin_mini_2", "targetname");
	cin_3 = struct::get("cin_mini_3", "targetname");
	cin_4 = struct::get("cin_mini_4", "targetname");
	self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
    self CameraActivate(true);
    self FreezeControls(true);
	
	self StartCameraTween(1);
	self CameraSetLookAt(cin_1);
    self CameraSetPosition(cin_1.origin, cin_1.angles);
    wait(1);
    self StartCameraTween(3);
	self CameraSetLookAt(cin_2);
    self CameraSetPosition(cin_2.origin, cin_2.angles);
    wait(3);
    self StartCameraTween(3);
    self CameraSetLookAt(cin_3);
    self CameraSetPosition(cin_3.origin, cin_3.angles);
    wait(3);
    self StartCameraTween(5);
    self CameraSetLookAt(cin_4);
    self CameraSetPosition(cin_4.origin, cin_4.angles);
    wait(5);
    self StartCameraTween(7);
    self CameraSetLookAt(cin_1);
    self CameraSetPosition(cin_1.origin, cin_1.angles);
    wait(8);
    self CameraSetPosition(self GetTagOrigin("j_head").origin, self GetTagOrigin("j_head").angles);
	self CameraActivate(false);
	self FreezeControls(false);
	level notify ("spawn_brutus");

	level.es_cinematica = false;
}
function cinematica_minibossfight2()
{
	level.es_cinematica = true;
	//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }

	tom_tumbado = getEnt("tom_tumbado", "targetname");
	tom_incorporado = getEnt("tom_incorporado", "targetname");
	cin_5 = struct::get("cin_mini_5", "targetname");
	cin_6 = struct::get("cin_mini_6", "targetname");
	cin_7 = struct::get("cin_mini_7", "targetname");

	self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
    self CameraActivate(true);
    self FreezeControls(true);
    self StartCameraTween(1);
    self CameraSetLookAt(cin_5);
    self CameraSetPosition(cin_5.origin, cin_5.angles);
    wait(1);
    self StartCameraTween(4);
    self CameraSetLookAt(cin_6);
    self CameraSetPosition(cin_6.origin, cin_6.angles);
    wait(4);
    self StartCameraTween(2);
    self CameraSetLookAt(cin_7);
    self CameraSetPosition(cin_7.origin, cin_7.angles);
    wait(2);
    level notify("subir_puerta_telefonos");
    self PlayLocalSound("tom2");
    tom_incorporado SetVisibleToAll();
    tom_tumbado SetInvisibleToAll();
    i = self.characterindex;
    destinations[i] = struct::get( "miniboss_teleport_" + i, "targetname" ); 
    self setorigin( destinations[i].origin );
    self setplayerangles( destinations[i].angles );
    wait(2);
    self CameraSetPosition(self GetTagOrigin("j_head").origin, self GetTagOrigin("j_head").angles);
	self CameraActivate(false);
	wait(10);
	self FreezeControls(false);
	thread zm_perks::vending_trigger_post_think(self, "specialty_staminup");
	level.es_cinematica = false;
}
function cinematica_bossfight()
{
	level.es_cinematica = true;
	//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
	cin_1 = struct::get("cin_boss_1", "targetname");
	cin_2 = struct::get("cin_boss_2", "targetname");
	cin_3 = struct::get("cin_boss_3", "targetname");
	cin_4 = struct::get("cin_boss_4", "targetname");
	cin_5 = struct::get("cin_boss_5", "targetname");
	cin_6 = struct::get("cin_boss_6", "targetname");
    self PlayLocalSound("jisaw6");
	self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
    self CameraActivate(true);
    self FreezeControls(true);
	
	self StartCameraTween(5);
	self CameraSetLookAt(cin_1);
    self CameraSetPosition(cin_1.origin, cin_1.angles);
    wait(5);
    self StartCameraTween(5);
	self CameraSetLookAt(cin_2);
    self CameraSetPosition(cin_2.origin, cin_2.angles);
    wait(5);
    self StartCameraTween(5);
    self CameraSetLookAt(cin_3);
    self CameraSetPosition(cin_3.origin, cin_3.angles);
    wait(5);
    self StartCameraTween(5);
    self CameraSetLookAt(cin_4);
    self CameraSetPosition(cin_4.origin, cin_4.angles);
    wait(5);
    self StartCameraTween(7);
    self CameraSetLookAt(cin_5);
    self CameraSetPosition(cin_5.origin, cin_5.angles);
    wait(7);
    self StartCameraTween(7);
    self CameraSetLookAt(cin_6);
    self CameraSetPosition(cin_6.origin, cin_6.angles);
    wait(7);
    self CameraSetPosition(self GetTagOrigin("j_head").origin, self GetTagOrigin("j_head").angles);
	self CameraActivate(false);
	self FreezeControls(false);
	level notify ("empieza_bossfight");
	level.es_cinematica = false;
	
}
function cinematica_luces()
{
	level.es_cinematica = true;
	//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
	cin_1 = struct::get("cin_luces_1", "targetname");
	cin_2 = struct::get("cin_luces_2", "targetname");
	cin_3 = struct::get("cin_luces_3", "targetname");
	cin_4 = struct::get("cin_luces_4", "targetname");
	cin_5 = struct::get("cin_luces_5", "targetname");
	cin_6 = struct::get("cin_luces_6", "targetname");
    self PlayLocalSound("jisaw7");
	self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
    self CameraActivate(true);
    self FreezeControls(true);
	
	self StartCameraTween(1);
	self CameraSetLookAt(cin_1);
    self CameraSetPosition(cin_1.origin, cin_1.angles);
    wait(1);
    self StartCameraTween(4);
	self CameraSetLookAt(cin_2);
    self CameraSetPosition(cin_2.origin, cin_2.angles);
    wait(4);
    self StartCameraTween(5);
    self CameraSetLookAt(cin_3);
    self CameraSetPosition(cin_3.origin, cin_3.angles);
    wait(5);
    self StartCameraTween(5);
    self CameraSetLookAt(cin_4);
    self CameraSetPosition(cin_4.origin, cin_4.angles);
    wait(5);
    self StartCameraTween(3);
    self CameraSetLookAt(cin_5);
    self CameraSetPosition(cin_5.origin, cin_5.angles);
    wait(3);
    self CameraSetPosition(self GetTagOrigin("j_head").origin, self GetTagOrigin("j_head").angles);
	self CameraActivate(false);
	self FreezeControls(false);
	level.es_cinematica = false;
	
}
function cinematica_final()
{
	level.es_cinematica = true;
	//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
	cin_1 = struct::get("cin_final_1", "targetname");
	cin_2 = struct::get("cin_final_2", "targetname");
	cin_3 = struct::get("cin_final_3", "targetname");
	cin_4 = struct::get("cin_final_4", "targetname");
	cin_5 = struct::get("cin_final_5", "targetname");
	cin_6 = struct::get("cin_final_6", "targetname");
	cin_7 = struct::get("cin_final_7", "targetname");
	self PlayLocalSound("musica_creditos");
	self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
    self CameraActivate(true);
    self FreezeControls(true);
	level notify ("creditos_finales");
	self StartCameraTween(1);
	self CameraSetLookAt(cin_1);
    self CameraSetPosition(cin_1.origin, cin_1.angles);
    wait(3);
    self StartCameraTween(2);
	self CameraSetLookAt(cin_2);
    self CameraSetPosition(cin_2.origin, cin_2.angles);
    wait(2);
    level notify ("subtitulos_finales");
    self PlayLocalSound("jisaw8");
    self StartCameraTween(8);
    self CameraSetLookAt(cin_3);
    self CameraSetPosition(cin_3.origin, cin_3.angles);
    wait(8);
    //donandres
    self CameraSetLookAt(cin_4);
    self CameraSetPosition(cin_4.origin, cin_4.angles);
    wait(0.1);
    self StartCameraTween(5);
    self CameraSetLookAt(cin_5);
    self CameraSetPosition(cin_5.origin, cin_5.angles);
    wait(5);
    //brack
    self CameraSetLookAt(cin_6);
    self CameraSetPosition(cin_6.origin, cin_6.angles);
    wait(0.1);
    self StartCameraTween(5);
    self CameraSetLookAt(cin_7);
    self CameraSetPosition(cin_7.origin, cin_7.angles);
    wait(5);

	level notify ("escribir_supervivientes");
	/*
    self CameraSetPosition(self GetTagOrigin("j_head").origin, self GetTagOrigin("j_head").angles);
	self CameraActivate(false);
	self FreezeControls(false);*/
	level.es_cinematica = false;
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// SALA 1		SALA 1		SALA 1		SALA 1
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
function sala_1()
{
	tapa_i = getEnt("tapa_retrete_i", "targetname");
	tapa_f = getEnt("tapa_retrete_f", "targetname");
	tapa_f SetInvisibleToAll();
	grabacion = getEnt("grabacion", "targetname");

	trig_damage = getEnt("damage_retrete", "targetname");
	trig_grabacion = getEnt("trig_grabacion", "targetname");
	trig_grabacion SetHintString( "" );
	trig_grabacion SetCursorHint("HINT_NOICON");
	trig_reproductor = getEnt("trig_reproductor", "targetname");
	trig_reproductor SetHintString( "" );
	trig_reproductor SetCursorHint("HINT_NOICON");

	trig_damage waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
	tapa_i MoveTo(tapa_f.origin,0.4);
	tapa_i RotateTo(tapa_f.angles,0.4);
	trig_damage Delete();
	PlaySoundAtPosition("vater",trig_grabacion.origin);

	trig_grabacion waittill( "trigger", player );
	grabacion Delete();
	PlaySoundAtPosition("objeto",trig_grabacion.origin);

	while(1)
	{
		trig_reproductor waittill( "trigger", player );
		PlaySoundAtPosition("jisaw1",trig_reproductor.origin);
		txt1 = "^1 JIGSAW: ^7Hello player. You've been playing Call of Duty Zombies maps for a long time.";
		txt2 = "Many people do this, some enjoy the experience, while others don't";
		txt3 = "and leave without leaving a comment or a like on the map ";
		txt4 = "and all the effort and time put into each map goes unrewarded.";
		if (level.idioma == "SPANISH")
		{
		txt1 = "^1 JIGSAW: ^7Hola jugador. LLevas mucho tiempo jugando mapas de Call of Duty Zombies.";
		txt2 = "Mucha gente lo hace, algunos disfrutan la experiencia, otros no tanto";
		txt3 = "y se van sin dejar un comentario o un like en el mapa";
		txt4 = "y todo el esfuerzo y tiempo puesto en cada mapa se va sin recompensa.";
		}
		thread crear_texto(txt1,txt2,txt3,txt4,12);
		wait(12);
		txt1 = "^1 JIGSAW: ^7You must learn to appreciate what you have.";
		txt2 = "Time in this world is very important. ";
		txt3 = "you won't be able to leave here until you realize the importance of time.";
		txt4 = "";
		if (level.idioma == "SPANISH")
		{
		txt1 = "^1 JIGSAW: ^7Debes aprender a apreciar lo que tienes,";
		txt2 = "tu tiempo en este mundo es muy importante.";
		txt3 = "No podrás salir de aqui hasta que te des cuenta de la importancia de";
		txt4 = "tu tiempo";
		}
		thread crear_texto(txt1,txt2,txt3,txt4,12);
		wait(12);
	}
}


//////PUZZLE NUEVE VALVULAS/////////////////////////////////////////////////////

function puzzle_nueve_valvulas()
{
	for (i = 1;i<10;i++)
	{
		thread solucion_nueve_valvulas(i);
		thread control_nueve_valvulas(i);
	}
	level flag::wait_till("initial_blackscreen_passed");
	wait(1);
	while(1)
	{
		WAIT_SERVER_FRAME;
		trues = 0;
		for (i = 1;i<10;i++)
		{
			if (level.solucion_nueve_valvulas[i] == level.nueve_valvulas[i])
			{
				trues ++;
			}
		}
		if (trues == 9)
		{
			break;
		}
	}
	puerta = getEnt("puerta_nueve_valvulas", "targetname");
	clip = getEnt("clip_nueve_valvulas", "targetname");
	puerta MoveX(135,2);
	clip MoveX(135,2);
	PlaySoundAtPosition("puerta_pesada",puerta.origin);
}
function solucion_nueve_valvulas(i)
{
	model = GetEnt( "pista_manecillas_"+i, "targetname" );
	
	t=0;
	t = RandomIntRange(0,4); //(min result, max rasult + 1)	
	level.solucion_nueve_valvulas[i]=t;
	while(1)
	{
		if (t==0)
		{
			break;
		}
		else
		{
			model RotateRoll(-90,0.1);
			wait(0.2);
			t --;
		}
	}
}
function control_nueve_valvulas(i)
{
	model = GetEnt( "manecilla_"+i, "targetname" );
	trig = GetEnt( "trig_manecilla_"+i, "targetname" );
	trig SetHintString( "" );
	trig SetCursorHint("HINT_NOICON");
	
	level flag::wait_till("initial_blackscreen_passed");
	level.nueve_valvulas[i]=0;
	while(1)
	{
		trig waittill( "trigger", player );
		level.nueve_valvulas[i] ++;
		model RotatePitch(90,0.4);
		PlaySoundAtPosition("rotar_valvula",model.origin);
		wait(0.5);

		trig waittill( "trigger", player );
		level.nueve_valvulas[i] ++;
		model RotatePitch(90,0.4);
		PlaySoundAtPosition("rotar_valvula",model.origin);
		wait(0.5);

		trig waittill( "trigger", player );
		level.nueve_valvulas[i] ++;
		model RotatePitch(90,0.4);
		PlaySoundAtPosition("rotar_valvula",model.origin);
		wait(0.5);

		trig waittill( "trigger", player );
		level.nueve_valvulas[i] = 0;
		model RotatePitch(90,0.4);
		PlaySoundAtPosition("rotar_valvula",model.origin);
		wait(0.5);
	}

}
//////PUZZLE RELOJ///////////////////////////////////////////////////////////////

function reloj()
{
	thread codigo_numerico_reloj("reloj_hora_d",6);
	thread codigo_numerico_reloj("reloj_hora",6);
	thread codigo_numerico_reloj("reloj_min_d",7);
	thread codigo_numerico_reloj("reloj_min",7);

}
function codigo_numerico_reloj(nombre,numero_inicial)
{
	for( i = 0; i < 10; i++ )
	{
		array = GetEntArray("num"+i, "targetname");  //targetname el numero  target el identificativo
		foreach (num in array)
		{
			if (num.target == nombre)
			{
				numero[i] = num;
				numero[i] SetInvisibleToAll();
			}
			
		}
		
	}
	numero[numero_inicial] SetVisibleToAll();
	level.numero_mostrado[nombre] = numero_inicial;

	trig = getEnt(nombre, "targetname");
	trig SetHintString( "" );  
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );
		PlaySoundAtPosition("cambiar_numero",trig.origin);
		level util::clientnotify(nombre);
		level util::clientnotify("check_reloj");
		prev = level.numero_mostrado[nombre];
		level.numero_mostrado[nombre] ++;
		if (level.numero_mostrado[nombre] >= 10){level.numero_mostrado[nombre] = 0;}
		numero[level.numero_mostrado[nombre]] SetVisibleToAll();
		numero[prev] SetInvisibleToAll();
		wait(0.3);
	}


}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// SALA 2		SALA 2		SALA 2		SALA 2
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////PUZZLE ESPEJO 
function puzzle_espejo()
{
	level flag::wait_till("initial_blackscreen_passed");
	abierta = getEnt("puerta_espejos_abierta", "targetname");
	abierta SetInvisibleToAll();
	thread puerta_espejo(1);
	thread puerta_espejo(2);
	thread puerta_espejo(3);
	thread codigo_numerico("cn_espejo_1",0);
	thread codigo_numerico("cn_espejo_2",0);
	thread codigo_numerico("cn_espejo_3",0);
	wait(1);
	while(1)
	{
		WAIT_SERVER_FRAME;
		if(level.numero_mostrado["cn_espejo_1"] == 6)
		{
			if(level.numero_mostrado["cn_espejo_2"] == 5)
			{
				if(level.numero_mostrado["cn_espejo_3"] == 6)
				{
					cerrada = getEnt("puerta_espejos_cerrada", "targetname");
					clip = getEnt("puerta_espejos_clip", "targetname");
					clip EnableLinkTo();
					clip LinkTo(cerrada);
					cerrada MoveTo(abierta.origin,1);
					cerrada RotateTo(abierta.angles,1);
					PlaySoundAtPosition("abrir_puerta",cerrada.origin);
					trig = getEnt("trig_cinematica_colgado", "targetname");
					trig waittill( "trigger", player );
					thread cronometro_pista_papeles();
					array::thread_all( GetPlayers(), &cinematica_jisaw_colgado, self );
					model = getEnt("jigsaw_colgado", "targetname");
					model useanimtree(#animtree);
    				model AnimScripted( "jigsaw_habla_colgado", model.origin , model.angles, %jigsaw_habla_colgado);

					txt1 = "^1 JIGSAW: ^7Up until now, you've shown yourself to be an intelligent person. ";
					txt2 = "However, you haven't worked under pressure. ";
					txt3 = "People under pressure make different decisions.";
					txt4 = "Now, the life of a person is under your responsibility.";
					if (level.idioma == "SPANISH")
					{
					txt1 = "^1 JIGSAW: ^7Hasta ahora has demostrado ser una persona inteligente.";
					txt2 = "Sin embargo, no has trabajado bajo presión.";
					txt3 = "La gente bajo presión toma decisiones diferentes.";
					txt4 = "Ahora la vida de una persona esta bajo tu responsabilidad.";
					}
					thread crear_texto(txt1,txt2,txt3,txt4,12);
					wait(12);

					txt1 = "^1 JIGSAW: ^7He is tied up in front of the door that leads to the exit. ";
					txt2 = "If you cut the chains, he will die. If you manage to solve the two ";
					txt3 = "puzzles in the room, you can free him from his suffering ";
					txt4 = "and open the door to continue the game. Good luck.";
					if (level.idioma == "SPANISH")
					{
					txt1 = "^1 JIGSAW: ^7Él está encadenado en esa puerta que lleva a la salida.";
					txt2 = "Si cortas las cadenas, morirá. Si consigues resolver los dos puzzles ";
					txt3 = "de la habitación, podrás liberarlo de su sufrimiento";
					txt4 = "y abrir la puerta para continuar con el juego. Buena suerte.";
					}
					thread crear_texto(txt1,txt2,txt3,txt4,11);
					wait(11);
					model StopAnimScripted();
					break;
				}
			}
		}
	}

}
function puerta_espejo(i)
{
	foreach(player in getplayers())
    {
		player thread mostrar_ocultar_numero_puerta(i);
	}
	trig = getEnt("trig_puerta_"+i, "targetname");
	trig SetHintString( "" );
	trig SetCursorHint("HINT_NOICON");
	puerta_cerrada = getEnt("puerta_cerrada_"+i, "targetname");
	puerta_abierta = getEnt("puerta_abierta_"+i, "targetname");
	puerta_clip = getEnt("puerta_clip_"+i, "targetname");

	puerta_cerrada SetInvisibleToAll();
	level.puerta_cerrada[i] = false;

	abierta_ori = puerta_abierta.origin;
	abierta_ang = puerta_abierta.angles;
	puerta_clip EnableLinkTo();
	puerta_clip LinkTo(puerta_abierta);

	while(1)
	{
		trig waittill( "trigger", player );
		puerta_abierta MoveTo(puerta_cerrada.origin,0.5);
		puerta_abierta RotateTo(puerta_cerrada.angles,0.5);
		PlaySoundAtPosition("puerta_madera",puerta_abierta.origin);
		wait(0.6);
		level.puerta_cerrada[i] = true;
		trig waittill( "trigger", player );
		puerta_abierta MoveTo(abierta_ori,0.5);
		puerta_abierta RotateTo(abierta_ang,0.5);
		PlaySoundAtPosition("puerta_madera",puerta_abierta.origin);
		wait(0.6);
		level.puerta_cerrada[i] = false;
	}
}
function mostrar_ocultar_numero_puerta(i)
{
	numero= getEnt("numero_puerta_"+i, "targetname");
	numero SetInvisibleToAll();

	trig = getEnt("posicion_espejo", "targetname");
	espejo = getEnt("espejo", "targetname");
	while(1)
    {
        WAIT_SERVER_FRAME;
        if (self IsTouching(trig)) {a=true;}
        else {a=false;}
        //a=true;
        if(self zm_utility::is_player_looking_at(espejo.origin, 0.85, true, self)) {b=true;}
        else {b=false;}
        //b=true;

        if(level.puerta_cerrada[i] == true) {c=true;}
        else {c=false;}
        //c=true;

        if ((a==true)&&(b==true)&&(c == true))
        {
            numero SetVisibleToPlayer(self);          
        }
        else
        {
        	numero SetInvisibleToPlayer(self);
        }
    }
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// SALA 3		SALA 3		SALA 3		SALA 3
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////// PECADOS CAPITALES 
function puzzle_pecados_capitales()
{
	level.rueda_1 = array("rojo","rosa","azul","morado","gris","amarillo","verde","rojo","rosa","azul","morado","gris","amarillo","verde");
	level.rueda_2 = array("morado","verde","azul","amarillo","rosa","gris","rojo","morado","verde","azul","amarillo","rosa","gris","rojo");
	level.rueda_3 = array("amarillo","rosa","gris","rojo","morado","verde","azul","amarillo","rosa","gris","rojo","morado","verde","azul");
	level.rueda_4 = array("amarillo","morado","verde","gris","rojo","rosa","azul","amarillo","morado","verde","gris","rojo","rosa","azul");
	level.rueda_5 = array("rojo","amarillo","azul","verde","morado","rosa","gris","rojo","amarillo","azul","verde","morado","rosa","gris");
	level.rueda_6 = array("morado","gris","verde","rojo","amarillo","azul","rosa","morado","gris","verde","rojo","amarillo","azul","rosa");
	level.rueda_7 = array("rojo","amarillo","morado","rosa","azul","verde","gris","rojo","amarillo","morado","rosa","azul","verde","gris");
	level.rueda_8 = array("azul","rosa","morado","verde","rojo","gris","amarillo","azul","rosa","morado","verde","rojo","gris","amarillo");

	for( i = 1; i < 9; i++ )
	{
		level.rueda_giros[i] = 0;
		thread girar_rueda_pecados(i);
	}

	while(1)
	{
		WAIT_SERVER_FRAME;
		correctos = 0;
		//Checkear combinacion con rueda central
		if (level.rueda_1[0+level.rueda_giros[1]] == level.rueda_5[0+level.rueda_giros[5]]) {correctos ++;}
		if (level.rueda_1[1+level.rueda_giros[1]] == level.rueda_6[1+level.rueda_giros[6]]) {correctos ++;}
		if (level.rueda_1[2+level.rueda_giros[1]] == level.rueda_7[2+level.rueda_giros[7]]) {correctos ++;}
		if (level.rueda_1[3+level.rueda_giros[1]] == level.rueda_8[3+level.rueda_giros[8]]) {correctos ++;}
		if (level.rueda_1[4+level.rueda_giros[1]] == level.rueda_2[4+level.rueda_giros[2]]) {correctos ++;}
		if (level.rueda_1[5+level.rueda_giros[1]] == level.rueda_3[5+level.rueda_giros[3]]) {correctos ++;}
		if (level.rueda_1[6+level.rueda_giros[1]] == level.rueda_4[6+level.rueda_giros[4]]) {correctos ++;}
		//Checkear combinacion entre ruedas exteriores
		if (level.rueda_2[3+level.rueda_giros[2]] == level.rueda_3[6+level.rueda_giros[3]]) {correctos ++;}
		if (level.rueda_3[4+level.rueda_giros[3]] == level.rueda_4[0+level.rueda_giros[4]]) {correctos ++;}
		if (level.rueda_4[5+level.rueda_giros[4]] == level.rueda_5[1+level.rueda_giros[5]]) {correctos ++;}
		if (level.rueda_5[6+level.rueda_giros[5]] == level.rueda_6[2+level.rueda_giros[6]]) {correctos ++;}
		if (level.rueda_6[0+level.rueda_giros[6]] == level.rueda_7[3+level.rueda_giros[7]]) {correctos ++;}
		if (level.rueda_7[1+level.rueda_giros[7]] == level.rueda_8[4+level.rueda_giros[8]]) {correctos ++;}
		if (level.rueda_8[2+level.rueda_giros[8]] == level.rueda_2[5+level.rueda_giros[2]]) {correctos ++;}

		
		if (correctos >= 14)
		{
			break;
		}
	}
	level notify ("pecados_completo");
	//PONER SONIDO
	IPrintLnBold("PUZZLE COMPLETED");
}

function girar_rueda_pecados(i)
{
	self endon ("pecados_completo");
	trig = getEnt("trig_pecado_"+i, "targetname");
	//trig SetHintString( "Hold ^3&&1^7 to activate mechanism" );  
	//trig SetCursorHint("HINT_NOICON");
	rueda = getEnt("rueda_pecado_"+i, "targetname");

	while(1)
	{
		trig waittill( "trigger", player );
		rueda RotatePitch(-360/7,0.4);
		PlaySoundAtPosition("girar_puzzle",rueda.origin);
		wait(0.6);
		level.rueda_giros[i] ++;
		if (level.rueda_giros[i]>=7)
		{
			level.rueda_giros[i] = 0;
		}
	}
}


////////////////////////////////////// SNOTE 			
function snote()
{
	trig = getEnt("trig_snote", "targetname");
	trig SetHintString( "" );
	trig SetCursorHint("HINT_NOICON");
	snote_tapa = getEnt("snote_tapa", "targetname");
	snote_giro = getEnt("snote_giro", "targetname");
	snote = getEnt("snote", "targetname");
	snote_tapa EnableLinkTo();
	snote_tapa LinkTo(snote_giro);

	while(1)
	{
		trig waittill( "trigger", player );
		players = GetPlayers();
		if (players.size <= 1)
		{
			thread slow_down_zombies();
		}
		player FreezeControlsAllowLook( true );
		snote_giro RotateRoll(-90,0.5);
		PlaySoundAtPosition("abrir_caja",snote_giro.origin);
		wait(0.5);
		snote MoveZ(8,0.5);
		wait(0.7);
		thread CreatesnoteTextForPlayer(player,"^4Rotate it with these buttons: ^2[{+melee}], [{+gostand}], [{+weapnext_inventory}]^4.Press ^2[{+activate}]^4 to skip", 300,75,1.5);
		thread mover_snote(snote,player);
		level waittill("use_botton_pressed");
		player FreezeControlsAllowLook( false );
		level notify ("snote_out");
		level notify ("stop_slow_zombies");
		snote MoveZ(-8,0.5);
		wait(0.4);
		snote_giro RotateRoll(90,0.5);
		PlaySoundAtPosition("abrir_caja",snote_giro.origin);
		wait(0.5);
	}


}
function mover_snote(snote,player)
{
	self endon ("snote_out");
	while(1)
	{
		WAIT_SERVER_FRAME;
		while( player MeleeButtonPressed() )
			{
				snote RotateRoll(20,0.2);
				wait(0.15);
			}
		while( player JumpButtonPressed() )
			{
				snote RotatePitch(-20,0.2);
				wait(0.15);
			}
		while( player WeaponSwitchButtonPressed() )
			{
				snote RotateYaw(-20,0.2);
				wait(0.15);
			}
		while( player UseButtonPressed() )
			{
				level notify("use_botton_pressed");
				WAIT_SERVER_FRAME;
			}
	}
}
function slow_down_zombies()
{
		self endon ("stop_slow_zombies");
		zm_utility::register_slowdown( "slow_zombie", 0.1, 0.3 );
		while(1)
            {
                a_zombies = getAITeamArray( level.zombie_team );
        		for ( i = 0; i < a_zombies.size; i++ )
				{
					a_zombies[ i ] thread zm_utility::slowdown_ai( "slow_zombie" );
				}
				wait(0.3);
            }
}
function CreatesnoteTextForPlayer(player,text, align_x, align_y, font_scale)
{
    hud = NewScoreHudElem(player);
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
    level waittill ("snote_out");
    hud fadeOverTime(0.1);
    hud.alpha = 0;
    wait(0.1);
    hud Destroy();
}

////////////////////////////////////////////// PUERTA ANIMADA 
function puerta_animada()
{
    level flag::wait_till("initial_blackscreen_passed");
    thread puzzle_bombillas("trig_bomb_yellow_d","bomb_yellow_1");
    thread puzzle_bombillas("trig_bomb_yellow_u","bomb_yellow_");
    thread puzzle_bombillas("trig_bomb_purple","bomb_purple_");
    thread puzzle_bombillas("trig_bomb_blue_d","bomb_blue_1");
    thread puzzle_bombillas("trig_bomb_blue_u","bomb_blue_");
    
    level waittill ("pecados_completo");
    while(1)
    {
        WAIT_SERVER_FRAME;
        if(level.bombillas["bomb_yellow_1"]== 1)
        {
            if(level.bombillas["bomb_yellow_"]== 1)
            {
                if(level.bombillas["bomb_purple_"]== 8)
                {
                    if(level.bombillas["bomb_blue_1"]== 2)
                    {
                        if(level.bombillas["bomb_blue_"]== 8)
                        {
                            level notify("sala_puzzles_completada");
                            array::thread_all( GetPlayers(), &cinematica_tortura, self );
                            cabeza = getEnt("cabeza", "targetname");
                            cabeza useanimtree(#animtree);
                            cabeza AnimScripted( "cabeza_tortura_muerte", cabeza.origin , cabeza.angles, %cabeza_tortura_muerte);

                            puerta = getEnt("puerta", "targetname");
                            puerta useanimtree(#animtree);
                            puerta AnimScripted( "puerta_bunker_tortura_abre", puerta.origin , puerta.angles, %puerta_bunker_tortura_abre);

                            cadenas = getEnt("cadenas", "targetname");
                            cadenas useanimtree(#animtree);
                            cadenas AnimScripted( "cadenas_bunker_tortura_abre", cadenas.origin , cadenas.angles, %cadenas_bunker_tortura_abre);

                            wait(1);
                            txt1 = "^1 JIGSAW: ^7Very well, as I promised you, the doors would open ";
							txt2 = "to continue the game. I also promised I would end ";
							txt3 = "your suffering, didn't I?";
							txt4 = "";
							if (level.idioma == "SPANISH")
							{
							txt1 = "^1 JIGSAW: ^7Muy bien, como te prometí, las puertas se abrirán";
							txt2 = "para continuar con el juego. También te prometi que acabaría";
							txt3 = "con tu sufrimiento, ¿no?";
							txt4 = "";
							}
							thread crear_texto(txt1,txt2,txt3,txt4,7);                           

                            break;
                        }
                    }

                }
            }
        }
    }

}
function cronometro_pista_papeles()
{
	self endon ("sala_puzzles_completada");
	wait(30);
	cabeza = getEnt("cabeza", "targetname");
	PlaySoundAtPosition("atado2",cabeza.origin);
	txt1 = "^2 JOHN: ^7Please, please, please, you have to help me. I trust you. Please ";
	txt2 = "";
	txt3 = "";
	txt4 = "";
	if (level.idioma == "SPANISH")
		{
		txt1 = "^2 JOHN: ^7Por favor, por favor, tienes que ayudarme! Confio en ti! Por favor!";
		txt2 = "";
		txt3 = "";
		txt4 = "";
		}
	thread crear_texto(txt1,txt2,txt3,txt4,8);
	wait(70);
	PlaySoundAtPosition("atado3",cabeza.origin);
	txt1 = "^2 JOHN: ^7Hey! There are some papers on the table, ";
	txt2 = " there are things written down. See if you can find something useful.";
	txt3 = "";
	txt4 = "";
	if (level.idioma == "SPANISH")
		{
		txt1 = "^2 JOHN: ^7Hey! Hay unos papeles en las mesas,";
		txt2 = "tienen cosas escritas. Mira a ver si puedes encontrar algo útil.";
		txt3 = "";
		txt4 = "";
		}
	thread crear_texto(txt1,txt2,txt3,txt4,8);
}
function puzzle_bombillas(trigname,bombname)
{
	trig = getEnt(trigname, "targetname");
	trig SetHintString( "" );
	trig SetCursorHint("HINT_NOICON");
	for (i = 1;i<10;i++)
	{
		bon[i] = getEnt(bombname + i, "targetname");
		bon[i] SetInvisibleToAll();
	}

	level.bombillas[bombname]=0;

	while(1)
	{
		trig waittill( "trigger", player );
		PlaySoundAtPosition("seleccionar",trig.origin);
		if (level.bombillas[bombname]>=9)
		{
			for (i = 1;i<10;i++)
			{
				bon[i] SetInvisibleToAll();
			}
			level.bombillas[bombname]=0;
		}
		else
		{
			level.bombillas[bombname] ++;
			bon[level.bombillas[bombname]] SetVisibleToAll();
		}
	}
}

function ganzua(i)
{
	level flag::wait_till("initial_blackscreen_passed");
		ganzua_trig = GetEnt("ganzua_trig_"+i,"targetname");
		door_model = GetEnt("door_ganzua_"+i,"targetname");
		door_abierta = GetEnt("door_ganzua_abierta_"+i,"targetname");
		door_abierta SetInvisibleToAll();
		door_clip = GetEnt("ganzua_clip_"+i,"targetname");
		level.ganzua_resuelto[i]=false;
		ganzua_trig SetHintString( "Hold ^3[{+activate}]^7 to use ganzua " ); 
		ganzua_trig SetCursorHint("HINT_NOICON");
		array_button = array("use","jump","melee","weaponswitch"); 
		button[1] = array::random(array_button);
		button[2] = array::random(array_button);
		button[3] = array::random(array_button);


		while(1)
		{
			ganzua_trig waittill( "trigger", player );	
			if (level.has_ganzua[player.playername]== true)
			{
				ganzua_trig SetHintString( "Try to open the door by combining these buttons: [{+melee}], [{+weapnext_inventory}], [{+activate}], [{+gostand}]" ); 
				thread CreateGanzuaTextForPlayer(player,"^4Try to open the door by combining these buttons: ^2[{+melee}], [{+weapnext_inventory}], [{+activate}], [{+gostand}]", 300,75,1.5);
				player FreezeControlsAllowLook( true );
				  ganzua_trig SetVisibleToAll();
				wait(0.5);
				IPrintLnBold("Try to open it");
				thread slow_down_zombies_near_to(player);
				thread check_codigo(player,button[1],button[2],button[3],ganzua_trig,i);
				level waittill (player.playername + "_code_checked");
				if (level.ganzua_resuelto[i]==true)
				{
					player PlayLocalSound("acierto_ganzua");
					player FreezeControlsAllowLook( false );
					level notify ("end_ganzua_mode_" + player.playername);
					PlaySoundAtPosition("caja_fuerte",door_model.origin);
					door_clip EnableLinkTo();
					door_clip LinkTo(door_model);
					door_model MoveTo(door_abierta.origin,0.5);
					door_model RotateTo(door_abierta.angles,0.5);
					notif = "ganzua_resuelto"+i;
					level notify(notif);
					//PONER SONIDO
					break;
				}
				else
				{
					player PlayLocalSound("fallo_ganzua");
					player thread show_ganzua_image_hud("ganzua_error");

				}
			}
			else
			{
				IPrintLnBold(player.playername + " hasn't lockpick");
			}
			player FreezeControlsAllowLook( false );
			ganzua_trig SetHintString( "Hold ^3[{+activate}]^7 to use ganzua " ); 
			level notify ("end_ganzua_mode_" + player.playername);
			wait(0.3);//para que si pulsas cuadrado y falla no vuelvas a checkear directamente
		}
	
}
	function check_codigo(player,button1,button2,button3,ganzua_trig,i)
	{
		wait(0.3);
		//IPrintLnBold(button1 + button2 + button3);
		player thread show_ganzua_image_hud("ganzua0");
		level waittill (player.playername + "button_pressed");
		if (level.button_pressed[player.playername]== button1)
		{
			player PlayLocalSound("acierto_ganzua");
			player thread show_ganzua_image_hud("ganzua1");
			level waittill (player.playername + "button_pressed");
			if (level.button_pressed[player.playername]== button2)
			{
				player PlayLocalSound("acierto_ganzua");
				player thread show_ganzua_image_hud("ganzua2");
				level waittill (player.playername + "button_pressed");
				if (level.button_pressed[player.playername]== button3)
				{
					player PlayLocalSound("acierto_ganzua");
					player thread show_ganzua_image_hud("ganzua3");
					level.ganzua_resuelto[i]=true;
				}
			}
		} 
		level notify (player.playername + "_code_checked");

	}

	

	function slow_down_zombies_near_to(player)
	{
		self endon ("end_ganzua_mode_" + player.playername);
		zm_utility::register_slowdown( "slow_zombie", 0.1, 0.3 );
		while(1)
            {
                a_zombies = getAITeamArray( level.zombie_team );
				a_zombies = util::get_array_of_closest( player.origin, a_zombies, undefined, undefined, 400 );
        		for ( i = 0; i < a_zombies.size; i++ )
				{
					a_zombies[ i ] thread zm_utility::slowdown_ai( "slow_zombie" );
				}
				wait(0.3);
            }
	}
	function get_ganzuas()
	{
		level flag::wait_till("initial_blackscreen_passed");
		foreach (player in GetPlayers())
		{
			level.has_ganzua[player.playername]= false;
		}
		for ( i = 1; i < 5; i++ )
		{
			thread get_ganzua(i);
		}
	}
	function get_ganzua(i)
	{
		
		while(1)
		{
			model = getEnt("ganzua_"+i, "targetname");
			trig = getEnt("trig_get_ganzua_"+i, "targetname");
			trig SetHintString( "" );  
			trig SetCursorHint("HINT_NOICON");
			trig waittill( "trigger", player );
			if(level.has_ganzua[player.playername]== false)
			{
				PlaySoundAtPosition("objeto",trig.origin);
				IPrintLnBold(player.playername + " get a lockpick");
				model Delete();
				trig Delete();
				break;
			}
			else
			{
				IPrintLnBold(player.playername + " already has a lockpick");
			}
			wait(0.3);
		}

		level.has_ganzua[player.playername]= true;

	}

	function CreateGanzuaTextForPlayer(player,text, align_x, align_y, font_scale)
{
    hud = NewScoreHudElem(player);
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
    level waittill (player.playername + "_code_checked");
    hud fadeOverTime(0.1);
    hud.alpha = 0;
    wait(0.1);
    hud Destroy();
}
function show_ganzua_image_hud(imagen) //self = player
{
	wait(0.15);
	menu_ganzua = NewClientHudElem( self ); 
	menu_ganzua.alignX = "center";
	menu_ganzua.alignY = "center";
	menu_ganzua.horzAlign = "center";
	menu_ganzua.vertAlign = "center";
	
	menu_ganzua SetShader( imagen, 480, 480 ); 
	menu_ganzua.alpha = 1;  
	if ((imagen == "ganzua3")||(imagen == "ganzua_error"))
	{
		wait(0.3);
	}
	else
	{
		level waittill (self.playername + "button_pressed");
	}
	menu_ganzua FadeOverTime( 0.1 ); 
	menu_ganzua.alpha = 0; 
	wait( 0.1 ); 
	menu_ganzua Destroy();
}
function premios()
{
	a = RandomIntRange(1,4); //(min result, max rasult + 1)
	while(1)
	{
		WAIT_SERVER_FRAME;
		b = RandomIntRange(1,4); //(min result, max rasult + 1)
		if(b != a)
		{
			break;
		}
	}
	while(1)
	{
		WAIT_SERVER_FRAME;
		c = RandomIntRange(1,4); //(min result, max rasult + 1)
		if((c != a)&&(c != b))
		{
			break;
		}
	}

	arma1 = getEnt("arma1", "targetname");
	arma2 = getEnt("arma2", "targetname");
	botella = getEnt("botella", "targetname");
	pos[1] = arma1.origin;
	pos[2] = arma2.origin;
	pos[3] = botella.origin;
	WAIT_SERVER_FRAME;

	arma1 MoveTo(pos[a],0.1);
	arma2 MoveTo(pos[b],0.1);
	botella MoveTo(pos[c],0.1);

	thread premio_arma(arma1,a,"t9_me_sledgehammer");
	thread premio_arma(arma2,b,"s2_win21");
	thread premio_perk(botella,c,"specialty_fastreload");
}

function premio_arma(model,i,arma)
{
	trig = getEnt("premio"+i, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take weapon"); 
	trig SetCursorHint("HINT_NOICON");
	trig SetInvisibleToAll();
	notif = "ganzua_resuelto"+i;
	level waittill(notif);
	trig SetVisibleToAll();
	trig waittill("trigger", player);
	armas = player GetWeaponsListPrimaries();
	if (armas.size >= 2)
	{		
		player TakeWeapon(player GetCurrentWeapon());
	}
	player zm_weapons::weapon_give(getweapon(arma));
	model Delete();
}
function premio_perk(model,i,perk)
{
	level.has_fastreload = false;
	trig = getEnt("premio"+i, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to take perk"); 
	trig SetCursorHint("HINT_NOICON");
	trig SetInvisibleToAll();
	notif = "ganzua_resuelto"+i;
	level waittill(notif);
	trig SetVisibleToAll();
	while(1)
	{
		trig waittill("trigger", player);
		level.has_fastreload = true;
		if (player HasPerk(perk) == false )
		{
			thread zm_perks::vending_trigger_post_think(player, perk);
		}
	}
	
}
	
	function check_use_button(player)
	{
		while(1)
		{
			WAIT_SERVER_FRAME;
			while( player UseButtonPressed() )
			{
				//IPrintLnBold("use button pressed");
				level.button_pressed[player.playername]= "use";
				level notify (player.playername + "button_pressed");
				
				wait(0.5);
				level.button_pressed[player.playername]="none";
			}

		}
	}
	function check_jump_button(player)
	{
		while(1)
		{
			WAIT_SERVER_FRAME;
			while( player JumpButtonPressed() )
			{
				//IPrintLnBold("jump button pressed");
				level.button_pressed[player.playername]= "jump";
				level notify (player.playername + "button_pressed");
				
				wait(0.5);
				level.button_pressed[player.playername]="none";
			}

		}
	}
	function check_melee_button(player)
	{
		while(1)
		{
			WAIT_SERVER_FRAME;
			while( player MeleeButtonPressed() )
			{
				//IPrintLnBold("melee button pressed");
				level.button_pressed[player.playername]= "melee";
				level notify (player.playername + "button_pressed");
				
				wait(0.5);
				level.button_pressed[player.playername]="none";
			}

		}
	}
	function check_weaponswitch_button(player)
	{
		while(1)
		{
			WAIT_SERVER_FRAME;
			while( player WeaponSwitchButtonPressed() )
			{
				//IPrintLnBold("weaponswitch button pressed");
				level.button_pressed[player.playername]= "weaponswitch";
				level notify (player.playername + "button_pressed");
				
				wait(0.5);
				level.button_pressed[player.playername]="none";
			}

		}
	}




function check_botones()
	{
		level flag::wait_till("initial_blackscreen_passed");
		foreach (player in GetPlayers())
		{
			level.button_pressed[player.playername]="none";
			thread check_use_button(player);
			thread check_jump_button(player);
			thread check_melee_button(player);
			thread check_weaponswitch_button(player);
		}
	}
function puzzle_luz()
{
	level.zonas_iluminadas = 0;
	thread esperar_cinematica_luces();
    NUMERO_ZONAS_LUZ = 5; //PONER 6 ZONAS
    for (i = 1;i<NUMERO_ZONAS_LUZ + 1;i++)
    {
        thread zona_puzzle_luz(i);
        trig[i] = getEnt("trig_cambioluz_"+i, "targetname");
    }
    wait(1);
    while(1)
    {
        WAIT_SERVER_FRAME;
        jugador_en_zona_oscura = false;
        for (i = 1;i<NUMERO_ZONAS_LUZ + 1;i++)
        {
            if (level.zona_con_luz[i] == false)
            {
                foreach(player in getplayers())
                {
                    if (player IsTouching(trig[i]))
                    {
                        jugador_en_zona_oscura = true;
                    }
                }
            }
        }
        if(jugador_en_zona_oscura == true)
        {
            level util::set_lighting_state(1);
        }
        else
        {
            level util::set_lighting_state(0);
        }
    }
}
function zona_puzzle_luz(i)
{
    level.zona_con_luz[i] = false;
    trig = getEnt("trig_interruptorluz_"+i, "targetname");
    trig SetHintString( "Press and Hold ^3&&1^7 to activate power" );
    trig SetCursorHint("HINT_NOICON");
    subido = getEnt("model_palanca_luzfinal_"+i, "targetname");
    bajado = getEnt("model_palancaluz_"+i, "targetname");
    subido SetInvisibleToAll();
    trig waittill( "trigger", player );
    bajado MoveTo(subido.origin,0.5);
    bajado RotateTo(subido.anlges,0.5);
    level.zona_con_luz[i] = true;
    level.zonas_iluminadas ++;
    if (level.zonas_iluminadas >= 5)
    {
        puerta = getEnt("puerta_bossfight", "targetname");
        puerta SetInvisibleToAll();
        clip_puerta = getEnt("clip_puerta_bossfight", "targetname");
        clip_puerta SetInvisibleToAll();
    }


}
function esperar_cinematica_luces()
{
	trig = getEnt("act_cinem_luces", "targetname");
	trig waittill( "trigger", player );
		model = getEnt("jigsaw_luces", "targetname");
		model useanimtree(#animtree);
    	model AnimScripted( "jigsaw_habla_colgado", model.origin , model.angles, %jigsaw_habla_colgado);
	array::thread_all( GetPlayers(), &cinematica_luces, self );
				txt1 = "^1 JIGSAW: ^7I want to play a game. In this challenge, you must cross to the other";
				txt2 = "side by walking on these wooden planks. If you fall, you will die. ";
				txt3 = "";
				txt4 = "";
				if (level.idioma == "SPANISH")
				{
				txt1 = "^1 JIGSAW: ^7Quiero jugar a un juego. En este reto, tendreis que cruzar al otro";
				txt2 = "lado andando por los tablones de madera. Si caeis, moriréis.";
				txt3 = "";
				txt4 = "";
				}
				thread crear_texto(txt1,txt2,txt3,txt4,6);
	wait(6);
				txt1 = "^1 JIGSAW: ^7So, every time you step on a plank, the lights will go out,";
				txt2 = "and you'll have to rely on your memory to find each switch to turn on the lights";
				txt3 = "in the corresponding area.";
				txt4 = "";
				if (level.idioma == "SPANISH")
				{
				txt1 = "^1 JIGSAW: ^7Asi que, cada vez que piseis un tablon de madera, las luces se apagarán";
				txt2 = "y tendrés que dejaros guiar por vuestra memoria para encontrar los interruptores que";
				txt3 = "enciendan las luces del area correspondiente.";
				txt4 = "";
				}
				thread crear_texto(txt1,txt2,txt3,txt4,12);
	wait(6);
	model StopAnimScripted();
}


/////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
// MINI BOSSFIGHT
////////////////////////////////////////////
/////////////////////////////////////////////////
function minibossfight()
{
	puerta = getEnt("puerta_miniboss", "targetname");
    puerta useanimtree(#animtree);
    puerta AnimScripted( "optionalNotify", puerta.origin , puerta.angles, %anim_puerta_boss_abierto);
	clip_entrada = getEnt("clip_entrada_mini", "targetname");
	clip_entrada SetInvisibleToAll();
	trig = getEnt("trig_mult_mini", "targetname");

	trig_brutus = getEnt("trig_brutus_drop", "targetname");
	trig_brutus SetHintString( "" );
	trig_brutus SetCursorHint("HINT_NOICON");
	trig_camilla = getEnt("trig_camilla", "targetname");
	trig_camilla SetHintString( "" );
	trig_camilla SetCursorHint("HINT_NOICON");
	manilla = getEnt("manivela_camilla", "targetname");
	manilla SetInvisibleToAll();
	manilla_final = getEnt("manivela_camilla_final", "targetname");
	manilla_final SetInvisibleToAll();
	thread auxilio_tom();
	while(1)
	{
		trig waittill( "trigger", player );
		count = 0;
		n = 0;
		foreach(player in getplayers())
		{
			n++;
			if (player IsTouching(trig))
			{
				count ++;
			}
		}
		if (n == count)
		{
			clip_entrada SetVisibleToAll();
			foreach(player in getplayers())
			{
				n++;
				if (player IsTouching(trig))
				{
					count ++;
				}
			}
			if (n == count)
			{
				array::thread_all( GetPlayers(), &cinematica_minibossfight, self );
				thread playsoundok("jisaw3");
				txt1 = "^1 JIGSAW: ^7Hello player, do you know Tom? He's trapped under this guillotine,";
				txt2 = "and each swing brings him closer to death. ";
				txt3 = "";
				txt4 = "";
				if (level.idioma == "SPANISH")
				{
				txt1 = "^1 JIGSAW: ^7Hola jugadores, ¿conoceis a Tom? Está atrapado bajo esta guillotina,";
				txt2 = "y cada balanceo lo aproxima más a su muerte.";
				txt3 = "";
				txt4 = "";
				}
				thread crear_texto(txt1,txt2,txt3,txt4,6);
				wait(6);
				txt1 = "^1 JIGSAW: ^7Fortunately, you only need to turn a crank to stop the mechanism and save him.";
				txt2 = "The only problem is that the person who has that crank ";
				txt3 = "isn't very reasonable, so if you want to save him, you'll have to fight. ";
				txt4 = "Good luck.";
				if (level.idioma == "SPANISH")
				{
				txt1 = "^1 JIGSAW: ^7Afortunadamente, solo teneis que girar una válvula par parar el mecanismo y salvarle.";
				txt2 = "El único problema es que la persona que tiene esa válvula no es muy razonable,";
				txt3 = "asi que si quereis salvarle, tendreis que luchar.";
				txt4 = "Buena suerte.";
				}
				thread crear_texto(txt1,txt2,txt3,txt4,14);
				break;
			}
		}
	}
	puerta useanimtree(#animtree);
    puerta AnimScripted( "optionalNotify", puerta.origin , puerta.angles, %anim_puerta_boss_cerrado);
	level.brutus_dropea = false;
	level waittill ("spawn_brutus");
	level.brutus_dropea = true;

	players = GetPlayers();
	level.vida_miniboss= 40000*players.size;
	zm_cellbreaker::spawn_brutus(level.vida_miniboss);

	model = getEnt("brutus_drop", "targetname");
	trig_brutus waittill( "trigger", player );
	level notify("pieza_brutus_recogida");
	level.brutus_dropea = false;
	trig_brutus Delete();
	model Delete();
	trig_camilla waittill( "trigger", player );
	manilla SetVisibleToAll();
	manilla RotateTo(manilla_final.angles,1);
	wait(1);
	//PARAR ANIMACION GUILLOTINA
	foreach(player in getplayers())
			{
				array::thread_all( GetPlayers(), &cinematica_minibossfight2, self );
			}

	clip_entrada SetInvisibleToAll();
	puerta useanimtree(#animtree);
    puerta AnimScripted( "optionalNotify", puerta.origin , puerta.angles, %anim_puerta_boss_abierto);
	wait(7);
	level notify("subir_puerta_telefonos");
}
function auxilio_tom()
{
	trig = getEnt("trig_auxilio", "targetname");
	trig waittill( "trigger", player );
	model = getEnt("tom_tumbado", "targetname");
	PlaySoundAtPosition("tom1",model.origin);
	txt1 = "^4 TOM: ^7Hey you! Please, please, help me! Set me free!";
	txt2 = "";
	txt3 = "";
	txt4 = "";
	if (level.idioma == "SPANISH")
				{
				txt1 = "^4 TOM: ^7Hey tu! Por favor, por favor, ayudame! Liberame de aqui!";
				txt2 = "";
				txt3 = "";
				txt4 = "";
				}
	thread crear_texto(txt1,txt2,txt3,txt4,5);
}
//////////////////////////////////////////////////////
/////////////////////////////////////////////////////
///////    PUZLE JAULAS PUZLE JAULAS///////////////////
///////////////////////////////////////////////////
//////////////////////////////////////////////////

function puzzle_jaulas()
{
    thread palanca_jaulas("verde");
    thread palanca_jaulas("amarillo");
    thread palanca_jaulas("azul");
    thread palanca_jaulas("rojo");
}
function palanca_jaulas(color)
{
    DAMAGE_PALANCA = 10;
    palanca = getEnt("palancajaula"+color, "targetname");
    trig = getEnt("trigjaula"+color, "targetname");
    trig SetHintString( "Press and Hold ^3&&1^7 activate the mechanism" ); 
    trig SetCursorHint("HINTNOICON");
    suelos = GetEntArray("jaula_"+color, "targetname");
    foreach(jaula in suelos)
    {
        partes_jaula = GetEntArray(jaula.target, "targetname");
        foreach(parte_jaula in partes_jaula)
        {
            parte_jaula EnableLinkTo();
            parte_jaula LinkTo(jaula);
        }
        thread rotatejaula(jaula,color);
    }
    while(1)
    {
        trig waittill( "trigger", player );
        level notify("rotar"+color);
        palanca useanimtree(#animtree);
		palanca AnimScripted("zmb_tower_elec_lever_pull", palanca.origin, palanca.angles, %zmb_tower_elec_lever_pull);
		PlaySoundAtPosition("palanca",trig.origin);
		palanca waittill("zmb_tower_elec_lever_pull");
 		palanca useanimtree(#animtree);
		palanca AnimScripted("zmb_tower_elec_lever_reverse", palanca.origin, palanca.angles, %zmb_tower_elec_lever_reverse);
        wait(2);


    }
}
function rotatejaula(jaula,color)
{
    while(1)
    {
        level waittill ("rotar"+color);
        jaula RotateYaw(90,2);
		PlaySoundAtPosition("rotar_jaula",jaula.origin);
    }
}

/////////////////PUERTAS PRIMER PASILLO
function puertas_primer_pasillo()
{
    thread puerta_derecha();
    thread puerta_izquierda();
}
function puerta_derecha()
{
    puerta = GetEnt( "puerta_d", "targetname" );
    puerta_f = GetEnt( "puerta_d_f", "targetname" );
    clip = GetEnt( "clip_puerta_d", "targetname" );
    clip EnableLinkTo();
    clip LinkTo(puerta);
    puerta_f SetInvisibleToAll();

    trig = getEnt("trig_puerta_d", "targetname");
    trig SetHintString( "" );
    trig SetCursorHint("HINT_NOICON");

    level.has_door_key=false;
    level.puerta_izq_abierta = false;
    has_llamado_antes = false;
    while(1)
    {
        trig waittill( "trigger", player );
        if (level.has_door_key == true)
        {
            //thread ganzua
    		puerta MoveTo(puerta_f.origin,1);
    		puerta RotateTo(puerta_f.angles,1);
    		PlaySoundAtPosition("abrir_puerta",puerta.origin);
        }
        else
        {
			PlaySoundAtPosition("puerta_cerrada",puerta.origin);
            if ((level.puerta_izq_abierta == false)&&(has_llamado_antes == false))
            {
                //PONER SONIDO FRASE DE MIEDO JISAW DICE "NONONO, VEN POR AQUI"
                has_llamado_antes = true;
            }
        }

    }
}
function puerta_izquierda()
{
    puerta = GetEnt( "puerta_i", "targetname" );
    puerta_f = GetEnt( "puerta_i_f", "targetname" );
    clip = GetEnt( "clip_puerta_i", "targetname" );
    clip EnableLinkTo();
    clip LinkTo(puerta);
    puerta_f SetInvisibleToAll();

    trig = getEnt("trig_puerta_i", "targetname");
    trig SetHintString( "" );
    trig SetCursorHint("HINT_NOICON");
    trig waittill( "trigger", player );
    puerta MoveTo(puerta_f.origin,1);
    puerta RotateTo(puerta_f.angles,1);
    level.puerta_izq_abierta = true;
    PlaySoundAtPosition("abrir_puerta",puerta.origin);

}


/////////////////////////////////////////////////////////////
///////////	 CABEZAS BILLY
////////////////////////////////////////////////////////////
function cabezas_billy()
{
	cabezas = GetEntArray("cabeza_billy", "targetname");
	foreach (cabeza in cabezas)
	{
		centro = GetEnt(cabeza.target,"targetname");
		cabeza EnableLinkTo();
		cabeza LinkTo(centro);
		centro thread girar_cabeza();
	}
}
function jugador_mas_cercano()
{
	while(1)
	{
		WAIT_SERVER_FRAME;
		
	}
}
function girar_cabeza()
{
	while(1)
	{
		players = GetPlayers();
		jugador_cercano = ArrayGetClosest( self.origin, players );
		WAIT_SERVER_FRAME();
		direccion = jugador_cercano.origin - self.origin;
		angles = VectortoAngles(direccion);
		girar_modelo = (0,angles[1],0);	//orientacion del modelo pero solo en Z
		self RotateTo(girar_modelo, 0.1) ;
	}
}


////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
//LABERINTO LABERINTO LABERINTO LABERINTO
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

function quitar_tablones_laberinto()
{
	
	level.tablones_recogidos = 0;
	thread puente_madera();
	trigs = GetEntArray("tablon", "targetname");
	foreach (trig in trigs)
	{
		trig thread coger_tablon();
	}
	for (i = 1;i<6;i++)
	{
		tablon[i] = getEnt("tablon_"+i, "targetname");
		tablon_fin[i] = getEnt("ftablon_"+i, "targetname");
		tablon_fin[i] SetInvisibleToAll();
	}
	trig = getEnt("trig_tablones", "targetname");
	trig2 = getEnt("recoger_tablones", "targetname");
	trig2 SetHintString("Press and Hold ^3&&1^7 to get a wooden board"); 
	trig3 = getEnt("trig_puente", "targetname");
	trig3 SetHintString( "You need wooden boards "+ level.tablones_recogidos + "/10"); 
	quitados = 0;
	while(1)
	{
		trig waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
       //if(mod == "MOD_MELEE")  
       if(weapon == GetWeapon("melee_fireaxe") && (mod == "MOD_MELEE") ) // Weapon you want the player to have when shot
        {
			PlaySoundAtPosition("quitar_tablon",trig.origin);
        	wait(0.2);
        	quitados ++;
        	tablon[quitados] MoveTo(tablon_fin[quitados].origin,0.5);
        	tablon[quitados] RotateTo(tablon_fin[quitados].angles,0.5);
        }
        if(quitados >= 5)
        {
        	clip_tablones = getEnt("clip_tablones", "targetname");
        	clip_tablones Delete();
        	break;
        }
	}
	for (i = 1;i<6;i++)
	{
		trig2 waittill( "trigger", player );
		level.tablones_recogidos ++;
		trig3 SetHintString( "You need wooden boards "+ level.tablones_recogidos + "/10"); 
        IPrintLnBold(level.tablones_recogidos + "/10"); 
		tablon[i] Delete();
		PlaySoundAtPosition("coger_tablon",trig2.origin);
	}

}
function coger_tablon()
{
	model = GetEnt(self.target, "targetname");
	self SetHintString( "Press and Hold ^3&&1^7 to get a wooden board" );  
	self SetCursorHint("HINT_NOICON");
	self waittill( "trigger", player );
	model Delete();
	level.tablones_recogidos ++;

	trig3 = getEnt("trig_puente", "targetname");
	trig3 SetHintString( "You need wooden boards "+ level.tablones_recogidos + "/10"); 
	IPrintLnBold(level.tablones_recogidos + "/10"); 
	PlaySoundAtPosition("coger_tablon",self.origin); 
	trig3 SetCursorHint("HINT_NOICON");
}
function puente_madera()
{
	trig3 = getEnt("trig_puente", "targetname");
	clip_puente = GetEnt("clip_puente", "targetname");
	puente_tablones = GetEntArray("puente_tablones", "targetname");
	puente_trasparente = GetEntArray("puente_trasparente", "targetname");

	foreach (tabla in puente_tablones)
	{
		tabla SetInvisibleToAll();
	}
	while(1)
	{
		WAIT_SERVER_FRAME;
		{
			if (level.tablones_recogidos >= 10)
			{
				wait(1);
				trig3 SetHintString( "Press and Hold ^3&&1^7 to build a bridge");
				trig3 waittill( "trigger", player );
				trig3 Delete();
				break;
			}
		}
	}

	foreach (trasparente in puente_trasparente)
	{
		trasparente Delete();
	}
	foreach (tabla in puente_tablones)
	{
		tabla SetVisibleToAll();
		tabla MoveZ(-25,0.4);
		wait(0.4);
	}
	clip_puente Delete();

}
//////////////////////////////////////////fuego
function fuego_laberinto()
{
	valvula_fuego_final = getEnt("valvula_fuego_final", "targetname");
	valvula_fuego_final SetInvisibleToAll();
	fuego_laberinto = GetEntArray("fuego_laberinto", "targetname");
	foreach (struct in fuego_laberinto)
	{
		thread PlayFxWithCleanup("dlc3/stalingrad/fx_fire_inferno_tall_1_evb_md_stalingrad",struct.origin,struct.angles,"parar_fuego");
	}
	trig = getEnt("trig_valvula_fuego", "targetname");
	trig SetHintString( "" );  
	trig SetCursorHint("HINT_NOICON");
	trig waittill( "trigger", player );
	valvula_fuego = getEnt("valvula_fuego", "targetname");
	valvula_fuego RotateTo(valvula_fuego_final.angles,1);
	PlaySoundAtPosition("rotar_valvula",valvula_fuego.origin);
	fuego_damage = getEnt("fuego_damage", "targetname");
	fuego_damage Delete();
	wait(1);
	array::thread_all( GetPlayers(), &enfocar_fuego, self );



}
function enfocar_fuego()
{
	cin_1 = struct::get("enfocar_fuego", "targetname");

	self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
    self CameraActivate(true);
    self FreezeControls(true);
	self CameraSetLookAt(cin_1);
    self CameraSetPosition(cin_1.origin, cin_1.angles);
    wait(1);
    level notify ("parar_fuego");
    wait(1);
    self CameraSetPosition(self GetTagOrigin("j_head").origin, self GetTagOrigin("j_head").angles);
	self CameraActivate(false);
	self FreezeControls(false);

}
function PlayFxWithCleanup(fx, origin,angles, notification)
{
    fxModel = Spawn("script_model", origin);
    fxModel SetModel("tag_origin");
    fxModel RotateTo(angles,0.1);
    wait(0.2);
    fx = PlayFXOnTag(fx, fxModel, "tag_origin");
    level waittill(notification);
    fxModel Delete();

    if (isdefined(fx))
        fx Delete();
}

///////////////////////////////////////////

function check_points()
{
	level flag::wait_till("initial_blackscreen_passed");
	level.cargar_stamin = false;
	level.respawn_point_name = "checkpoint_spawn";
	thread enter_boss_fight();
	thread cargar_algo_mas_checkpoint();
	thread desbuggear_hurt_triggers();
	level.cargar_algo_mas = "no";	
	trig1 = getEnt("trig_checkpoint_1", "targetname");
	trig1 waittill( "trigger", player );
	level.respawn_point_name = "checkpoint_1";		
	trig2 = getEnt("trig_mult_mini", "targetname");
	trig2 waittill( "trigger", player );
	level.cargar_algo_mas = "minibossfight";	
	level.respawn_point_name = "checkpoint_2";			
	trig3 = getEnt("trig_sala_telefono", "targetname");
	trig3 waittill( "trigger", player );
	level.cargar_algo_mas = "no";
	level.cargar_stamin = true;	
	level.respawn_point_name = "checkpoint_3";	
	trig4 = getEnt("trig_checkpoint_4", "targetname");
	trig4 waittill( "trigger", player );
	level.cargar_algo_mas = "no";	
	level.respawn_point_name = "checkpoint_4";
	trig5 = getEnt("trig_checkpoint_5", "targetname");
	trig5 waittill( "trigger", player );
	level.cargar_algo_mas = "bossfight";	
	level.respawn_point_name = "checkpoint_5";

}
function cargar_algo_mas_checkpoint()
{
	level.es_reset = false;
	while(1)
	{
		level waittill("bossfight_quick_reset");
		foreach(player in getplayers())
    	{
        	player DisableOffhandWeapons();
    	}
		if (level.cargar_algo_mas == "minibossfight")
		{
			wait(1);
			//level.brutus_actual.health = level.vida_miniboss;
			level.brutus_actual Delete();
			wait(1);
			zm_cellbreaker::spawn_brutus(level.vida_miniboss);
			
		}
		if (level.cargar_algo_mas == "stamin")
		{
			wait(1);
			thread zm_perks::vending_trigger_post_think(self, "specialty_staminup");
		}
		
		if (level.cargar_algo_mas == "bossfight")
		{
			wait(1);
			level.es_reset = true;
			//level.brutus_actual.health = level.vida_miniboss;
			level.brutus_actual Delete();
			wait(1);
			zm_cellbreaker::spawn_brutus(level.vida_boss);
			level.es_reset = false;
		}
		if (level.has_deadshot)
		{
			foreach(player in getplayers())
			{
				thread zm_perks::vending_trigger_post_think(player, "specialty_deadshot");
			}
		}
		if (level.has_doubletap)
		{
			foreach(player in getplayers())
			{
				thread zm_perks::vending_trigger_post_think(player, "specialty_doubletap2");
			}
		}
		if (level.has_fastreload)
		{
			foreach(player in getplayers())
			{
				thread zm_perks::vending_trigger_post_think(player, "specialty_fastreload");
			}
		}
		if (level.has_jugger)
		{
			foreach(player in getplayers())
			{
				thread zm_perks::vending_trigger_post_think(player, "specialty_armorvest");
			}
		}
		if (level.has_fastmantle)
		{
			foreach(player in getplayers())
			{
				thread zm_perks::vending_trigger_post_think(player, "specialty_fastmantle");
			}
		}
	}
}
function desbuggear_hurt_triggers()
{
	trig1 = getEnt("fuego_damage", "targetname");
	while(1)
	{
		WAIT_SERVER_FRAME;
		if (level.bossfight_quick_resetting == true)
		{trig1 SetInvisibleToAll();}
		else
		{trig1 SetVisibleToAll();}
	}
}
function show_checkpoint_imagen(imagen) //self = player
{
	menu_perk = NewClientHudElem( self ); 
	menu_perk.alignX = "center";
	menu_perk.alignY = "center";
	menu_perk.horzAlign = "center";
	menu_perk.vertAlign = "center";
	
	menu_perk SetShader( imagen, 860, 480 ); //860 580 = full screen
	menu_perk.alpha = 1;  

	level waittill ("quitar_checkpoint_imagen");
	menu_perk FadeOverTime( 0.1 ); 
	menu_perk.alpha = 0; 
}
function enter_boss_fight()
{
    if(!IsFunctionPtr(level._game_module_game_end_check) || level._game_module_game_end_check != &check_game_over_bossfight)
    {
        level.__game_module_game_end_check = level._game_module_game_end_check;
        level._game_module_game_end_check = &check_game_over_bossfight;
    }

    foreach(player in getplayers())
    {
    	player thread player_bossfight_watch_death();
    }
}

function exit_bossfight()
{
    level._game_module_game_end_check = undefined;
    if(isdefined(level.__game_module_game_end_check))
    {
        level._game_module_game_end_check = level.__game_module_game_end_check;
    }
}


function check_game_over_bossfight()
{
    // guaranteed that all players are downed at this point
    // also, because of specifications, guaranteed that nobody has bled out!
    foreach(player in getplayers())
    {
        if(player laststand::player_is_in_laststand())
        {
            continue;
        }   
        //estamos aqui si el jugador no esta en lastand
        if(player.sessionstate != "playing")
        {
            continue;
        }
        //estamos aqui si el jugador esta jugando
        if(player hasperk("specialty_quickrevive"))
        {
        	
            return true; //si ademas tiene quick revive devuelve TRUE y corta la iteracion
        }
        //si el jugador esta jugando y no tiene quick revive se le otorga el quick revive
        // stop the player from dying (and ending the game)
        player.lives = 1;
        player SetPerk("specialty_quickrevive");
        
    }
    //hemos llegado aqui si todos los jugadores estan jugando y no tenian quick revive.
    //level thread bossfight_quick_reset(3.0);
    //IPrintLnBold("game over reset");
    //player ClearPerks();
    wait(0.3);
    foreach(player in getplayers())
    {
        //player thread show_checkpoint_imagen("checkpoint_saw");
    }
    return false;
}






function bossfight_quick_reset(n_delay = 0.05)
{
    level notify("bossfight_quick_reset");
    level endon("end_game");
    
    wait n_delay;

    if(level.bossfight_quick_resetting === true)
    {
        return;
    }


    level.bossfight_quick_resetting = true;
    
    foreach(player in getplayers())
    {
        player thread show_checkpoint_imagen("checkpoint_saw");
    }
    thread playsoundok("risa_jigsaw");
    wait(3);
    // revive all players and respawn spectators
    foreach(player in getplayers())
    {
    	
        if(player.sessionstate != "playing")
        {
            player [[ level.spawnplayer ]]();
            continue;
        }
        //estamos aqui si el jugador esta jugando

        if(player laststand::player_is_in_laststand())
        {
            player zm_laststand::auto_revive(player);
            continue;
        }
        //estamos aqui si el jugador estaba jugando y no estaba caido

        // BUG IF THIS HAPPENS
        player.health = player.maxhealth;
    }

    // TODO: reset the boss's health

    // kill all zombies
    foreach(ai in zombie_utility::get_round_enemy_array())
    {
        ai kill();
        ai Delete();
    }

     corpse_array = GetCorpseArray();
        for ( i = 0; i < corpse_array.size; i++ )
    {
        if ( IsDefined( corpse_array[ i ] ) )
        {
            corpse_array[ i ] Delete();
        }
    }

    foreach(powerup in level.active_powerups)
    {
        powerup notify("powerup_timedout");
        powerup thread zm_powerups::powerup_delete();
    }
    destination = struct::get(level.respawn_point_name, "targetname" ); 
    respawn_point = destination.origin; // TODO: change this to the respawn point you want them to be at
    i = -int(getplayers().size / 2);
    foreach(player in getplayers())
    {
        player setorigin(respawn_point + (i * 20, 0, 0));
        i++;
        player.lives = 1;
        player SetPerk("specialty_quickrevive");
    }
    level.bossfight_quick_resetting = false;
    wait(0.3);  
    level notify ("quitar_checkpoint_imagen");
}

function player_bossfight_watch_death()
{
    self endon("disconnect");
    self endon("end_game");
    player.lives = 1;
    player SetPerk("specialty_quickrevive");
    while(1)
    {
        if((self laststand::player_is_in_laststand()))//no esta caido
        {
        	level thread bossfight_quick_reset(0.05);
        	player.lives = 1;
    		player SetPerk("specialty_quickrevive");
        	level waittill ("quitar_checkpoint_imagen");
        	player.lives = 1;
    		player SetPerk("specialty_quickrevive");
        }
        WAIT_SERVER_FRAME;
        	
    }
}

////////////////////////////////////////
////////////////////////////////////
///////SPAWN
function spawnear_zombies_zona()
{
	trigs = GetEntArray("zona_spawn", "targetname");
	foreach (trig in trigs)
	{
		thread funcion_spawnear(trig);
		thread matar_zombies(trig);
	}
}
function matar_zombies(trig)
{
	while(1)
	{
		wait(1);
		zombies = zombie_utility::get_round_enemy_array();
				foreach (zombie in zombies)
				{
					players = GetPlayers();
					player = util::get_array_of_closest( zombie.origin, players, undefined, undefined, undefined );
					dist = Distance( player.origin, zombie.origin );
					if (dist >= 1200)
					{
						zombie Kill();
					}
				}
	}
}
function funcion_spawnear(trig)
{
	level.es_cinematica = false;
	spawns = struct::get_array( trig.target, "targetname" );
	while(1)
	{
		trig waittill( "trigger", player );
		if(level.es_cinematica == false)
		{
			spawn =spawns[randomint(spawns.size)];
			dig_zombie = SpawnActor("actor_spawner_zm_human_zombie_1",spawn.origin,spawn.angles,"",true,true);
    		dig_zombie zm_spawner::zombie_spawn_init( undefined );	
    		dig_zombie._rise_spot = spawn;
    		dig_zombie.is_boss = 0;
    		dig_zombie.gibbed = 1;
    		dig_zombie.in_the_ground = 1;
    		dig_zombie.ignore_enemy_count = 0;
    		dig_zombie.ignore_nuke = 0;
    		dig_zombie.no_powerups = 0;
    		dig_zombie.no_damage_points = 0;
    		dig_zombie.deathpoints_already_given = 0;
    		dig_zombie.script_string = "find_flesh";
    		dig_zombie zm_spawner::do_zombie_spawn();
    		wait(0.3);
    		spawn =spawns[randomint(spawns.size)];
			dig_zombie = SpawnActor("actor_spawner_zm_human_zombie_1",spawn.origin,spawn.angles,"",true,true);
    		dig_zombie zm_spawner::zombie_spawn_init( undefined );	
    		dig_zombie._rise_spot = spawn;
    		dig_zombie.is_boss = 0;
    		dig_zombie.gibbed = 1;
    		dig_zombie.in_the_ground = 1;
    		dig_zombie.ignore_enemy_count = 0;
    		dig_zombie.ignore_nuke = 0;
    		dig_zombie.no_powerups = 0;
    		dig_zombie.no_damage_points = 0;
    		dig_zombie.deathpoints_already_given = 0;
    		dig_zombie.script_string = "find_flesh";
    		dig_zombie zm_spawner::do_zombie_spawn();
    		wait(20);
		}
		
	}
	
}
function zonas_corren()
{
	trigs = GetEntArray("zona_run", "targetname");
	foreach (trig in trigs)
	{
		thread zona_corre(trig);
	}
}
function zona_corre(trig)
{
	while(1)
	{
		wait(2);
		a_zombies = getAITeamArray( level.zombie_team );
        		for ( i = 0; i < a_zombies.size; i++ )
				{
					if (a_zombies[i] IsTouching(trig))
					{
						a_zombies[i] zombie_utility::set_zombie_run_cycle( "run" ); //"walk" "run" "sprint"
					}
					else
					{
						a_zombies[i] zombie_utility::set_zombie_run_cycle( "run" );
					}
				}
	}
}

function llaves_laberinto()
{
	llaves = getEnt("llaves", "targetname");
	trig = getEnt("llaves_trig", "targetname");
	trig SetHintString( "" );  
	trig SetCursorHint("HINT_NOICON");
	trig waittill( "trigger", player );

	llaves Delete();
	level.has_door_key=true;
	PlaySoundAtPosition("objeto",trig.origin);
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
	txt1= "You have rescued ^1"+level.prisioneros +" ^7players.";
	if (level.idioma == "SPANISH")
				{
				txt1 = "Has rescatado a ^1"+level.prisioneros +"^7 jugadores.";
				}
	game_over SetText(txt1);

	game_over FadeOverTime( 1 );
	game_over.alpha = 1;
	if ( player isSplitScreen() )
	{
		game_over.fontScale = 2;
		game_over.y += 40;
	}
}
function CreateIntroText(text, align_x, align_y, font_scale, time, fade_time)
{
	align_x = 100;
	font_scale = 1.3;
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
function crear_texto(txt1,txt2,txt3,txt4,tiempo)
{
	thread CreateIntroText(txt1, 320,95,2,tiempo,1);
	thread CreateIntroText(txt2, 320,75,2,tiempo,1);
	thread CreateIntroText(txt3, 320,55,2,tiempo,1);
	thread CreateIntroText(txt4, 320,35,2,tiempo,1);
}

function billy_triciclo()
{
	billys = GetEntArray("billy_bike", "targetname");
	foreach (billy in billys)
	{
		thread triciclo_animado(billy);
	}
}
function triciclo_animado(model)
{
	tiempo = 12;
	desplazamiento = 300;
	while(1)
	{
		WAIT_SERVER_FRAME;
		miran = false;
		foreach(player in getplayers())
    	{
			if(player zm_utility::is_player_looking_at(model.origin, 0.85, true, player))
			{
				miran = true;
			}
		}
		if (miran == true)
		{

			bici = GetEnt(model.target, "targetname");
			link = util::spawn_model( "tag_origin", model.origin, model.angles );
			model LinkTo( link );
			bici LinkTo( link );
			if (model.script_string == "x")
			{		
				link MoveX(desplazamiento, tiempo);
			}
			if (model.script_string == "-x")
			{		
				link MoveX(-desplazamiento, tiempo);
			}
			if (model.script_string == "y")
			{		
				link MoveY(desplazamiento, tiempo);
			}
			if (model.script_string == "-y")
			{		
				link MoveY(-desplazamiento, tiempo);
			}
			bici PlaySound("sonido_bici");
			bici PlaySound("risa_jigsaw");

			wait(0.4);
			model useanimtree(#animtree);
			model AnimScripted("jigsaw_triciclo_billy", model.origin, model.angles, %jigsaw_triciclo_billy);
			bici useanimtree(#animtree);
			bici AnimScripted("jigsaw_triciclo", bici.origin, bici.angles, %jigsaw_triciclo);
			wait(tiempo);
			model Delete();
			bici Delete();
			break;
		}
	}


}
////////////////////////////////////////
//////////////////////////////////////
////HUD INTRO
//////////////////////////////////////
//////////////////////////////////////
function hud_intro()
{
		level flag::wait_till("initial_blackscreen_passed");
		foreach(player in getplayers())
		{
			player thread intro_control();
		}
		wait(1);
		destination = struct::get(level.respawn_point_name, "targetname" ); 
    	respawn_point = destination.origin; // TODO: change this to the respawn point you want them to be at
    	i = -int(getplayers().size / 2);
    	foreach(player in getplayers())
    	{
       		player setorigin(respawn_point + (i * 20, 0, 0));
        	i++;
    	}
}
function intro_control()
{
	level.pantalla_idioma[self.playername] = false;
	level.ultima_pagina[self.playername] = false;
	level.empieza_partida[self.playername]=false;
	i=1;
	self FreezeControlsAllowLook(true);
	self util::show_hud(0);
	self thread show_imagen("saw_hudintro1","quitar_hud"+self.playername);
	thread CreateTextForPlayer(self,"^4[{+melee}] ^7BACK                                                                                                                                                                   NEXT ^4[{+gostand}]", 30,75,2,"quitar_hud"+self.playername);
	thread cambiar_idioma(self);
	thread iniciar_juego(self);
	
	while(1)
	{
		if (level.empieza_partida[self.playername]==true)
		{
			self FreezeControlsAllowLook(false);
			level notify ("quitar_hud"+self.playername);
			self util::show_hud(1);
			level notify ("quitar_hud"+self.playername);
			break;
		}
		WAIT_SERVER_FRAME;
		if (level.button_pressed[self.playername]== "jump")
		{
			level notify ("quitar_hud"+self.playername);
			level notify ("quitar_hud_idioma"+self.playername);
			i ++;
			if (i == 6) {i=5;}
			self thread show_imagen("saw_hudintro"+i,"quitar_hud"+self.playername);
			thread CreateTextForPlayer(self,"^4[{+melee}] ^7BACK                                                                                                                                                                   NEXT ^4[{+gostand}]", 30,75,2,"quitar_hud"+self.playername);
			level.button_pressed[self.playername]="none";
			if (i == 4)
			{
				level.pantalla_idioma[self.playername] = true;
				level.ultima_pagina[self.playername] = false;
			}
			else if (i == 5)
			{
				level.ultima_pagina[self.playername] = true;
				level.pantalla_idioma[self.playername] = false;
				thread CreateTextForPlayer(self,"^1[{+activate}] ^7to Start the Game.", 180,100,2,"quitar_hud"+self.playername);
			}
			else
			{
				level.ultima_pagina[self.playername] = false;
				level.pantalla_idioma[self.playername] = false;
			}
			wait(0.5);
		}
		if (level.button_pressed[self.playername]== "melee")
		{
			level notify ("quitar_hud"+self.playername);
			level notify ("quitar_hud_idioma"+self.playername);
			i --;
			if (i == 0) {i=1;}
			self thread show_imagen("saw_hudintro"+i,"quitar_hud"+self.playername);
			thread CreateTextForPlayer(self,"^4[{+melee}] ^7BACK                                                                                                                                                                   NEXT ^4[{+gostand}]", 30,75,2,"quitar_hud"+self.playername);
			level.button_pressed[self.playername]="none";
			if (i == 4)
			{
				level.pantalla_idioma[self.playername] = true;
				level.ultima_pagina[self.playername] = false;
			}
			else if (i == 5)
			{
				level.ultima_pagina[self.playername] = true;
				level.pantalla_idioma[self.playername] = false;
				thread CreateTextForPlayer(self,"^1[{+activate}] ^7to Start the Game.", 180,100,2,"quitar_hud"+self.playername);
			}
			else
			{
				level.ultima_pagina[self.playername] = false;
				level.pantalla_idioma[self.playername] = false;
			}
			wait(0.5);
		}
	}
}
function cambiar_idioma(player)
{
	thread control_idioma(player);
	while(1)
	{
		WAIT_SERVER_FRAME;
		if (level.pantalla_idioma[player.playername]==true)
		{
			thread CreateTextForPlayer(player,"^1[{+weapnext_inventory}] ^7to change language. Current Language: ^1"+ level.idioma, 100,220,2,"quitar_hud_idioma"+self.playername);
			wait(0.1);
			level notify ("quitar_hud_idioma"+self.playername);
		}
	}
}
function control_idioma(player)
{
	level.idioma = "ENGLISH";
		while(1)
		{
			WAIT_SERVER_FRAME;
			while( player WeaponSwitchButtonPressed() )
			{
				if (level.pantalla_idioma[player.playername]==true)
				{
					if(level.idioma == "ENGLISH")
					{
						level.idioma = "SPANISH";
					}
					else 
					{
						level.idioma = "ENGLISH";
					}
				}
				wait(0.5);
			}

		}
}
function iniciar_juego(player)
{
	level.jugadores_en_partida = 0;
	players = GetPlayers();
	while(1)
	{
		WAIT_SERVER_FRAME;
		while( player UseButtonPressed() )
			{
				WAIT_SERVER_FRAME;
				if (level.ultima_pagina[player.playername]==true)
				{
					level.jugadores_en_partida ++;
					level.empieza_partida[player.playername]=true;
					if (level.jugadores_en_partida >= players.size)
					{
						level notify ("informar_linternas");
					}
					break;
				}
				wait(0.5);
			}
	}
}

function show_imagen(imagen,notification) //self = player
{
	menu_perk = NewClientHudElem( self ); 
	menu_perk.alignX = "center";
	menu_perk.alignY = "center";
	menu_perk.horzAlign = "center";
	menu_perk.vertAlign = "center";
	
	menu_perk SetShader( imagen, 860, 480 ); //860 580 = full screen
	menu_perk.alpha = 1;  

	level waittill (notification);
	menu_perk FadeOverTime( 0.1 ); 
	menu_perk.alpha = 0; 
}
	function CreateTextForPlayer(player,text, align_x, align_y, font_scale, notification)
{
    hud = NewScoreHudElem(player);
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
    level waittill (notification);
    hud fadeOverTime(0.1);
    hud.alpha = 0;
    wait(0.1);
    hud Destroy();
}

///////////////////////////////////////////
//////////////////////////////////////////
///BOSSFIGHT BOSSFIGHT
/////////////////////////////////////////
/////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////
///////BOSSFIGHT
 function bossfight()
 {
 	
 		thread bot_electrificado();
 		thread bot_agua();
 		thread bot_aplastado();
 		thread matar_tom();
 	
 	thread sierras();
 	agua = getEnt("agua", "targetname");
 	level.posicion_inicial_agua = agua.origin;
 	trig = getEnt("trig_checkpoint_5", "targetname");
 	trig waittill( "trigger", player );
 	array::thread_all( GetPlayers(), &cinematica_bossfight, self );

 	txt1 = "^1 JIGSAW: ^7Hello, players, we are about to finish the game, the final duel is here. ";
	txt2 = "Once you enter, there is no turning back. You will face a deadly showdown, honestly, ";
	txt3 = "with your current resources, you won't get very far. ";
	txt4 = "";
	if (level.idioma == "SPANISH")
				{
				txt1 = "^1 JIGSAW: ^7Hola, jugadores, estamos a punto de acabar el juego. EL duelo final se acerca.";
				txt2 = "Una vez empiece, no hay vuelta atrás. Te enfrentaras a un combate a muerte, sinceramente,";
				txt3 = "con tus recursos actuales, no llegaras muy lejos";
				txt4 = "";
				}
	thread crear_texto(txt1,txt2,txt3,txt4,11);
	wait(11);
	 destination = struct::get("checkpoint_5", "targetname" ); 
    respawn_point = destination.origin; // TODO: change this to the respawn point you want them to be at
    i = -int(getplayers().size / 2);
    foreach(player in getplayers())
    {
        player setorigin(respawn_point + (i * 20, 0, 0));
        i++;
    }
    puerta = getEnt("puerta_bossfight", "targetname");
    puerta SetVisibleToAll();
    clip_puerta = getEnt("clip_puerta_bossfight", "targetname");
    clip_puerta SetVisibleToAll();
	txt1 = "^1 JIGSAW: ^7In front of you are different players, you already know some of them, ";
	txt2 = " do you remember Tom? Each one is under a torture device that will lead them  ";
	txt3 = "to death, and you are responsible for deciding whether to activate it or not. ";
	txt4 = "";
	if (level.idioma == "SPANISH")
				{
				txt1 = "^1 JIGSAW: ^7En frente tuyo hay distintos jugadores, tu ya conoces a alguno de ellos,";
				txt2 = "¿recuerdas a Tom? Cada uno esta en una maquina de tortura que les matará.";
				txt3 = "y tu eres el responsable para decidir si se activa o no.";
				txt4 = "";
				}
	thread crear_texto(txt1,txt2,txt3,txt4,15);
	wait(15);
	txt1 = "^1 JIGSAW: ^7For every life taken, you will be rewarded with something  ";
	txt2 = "that will help you save your own life.  ";
	txt3 = "Live or die, you decide...";
	txt4 = "";
	if (level.idioma == "SPANISH")
				{
				txt1 = "^1 JIGSAW: ^7Por cada vida quitada, vas a ser recompensado con algo";
				txt2 = "que te ayudara a salvar tu propia vida.";
				txt3 = "Vivir o morir, tu decides.";
				txt4 = "";
				}
	thread crear_texto(txt1,txt2,txt3,txt4,8);

 	level waittill ("empieza_bossfight");
 	players = GetPlayers();
	level.vida_boss= 60000*players.size;
	level.vida_boss_total= level.vida_boss;
	zm_cellbreaker::spawn_brutus(level.vida_boss);
	thread esperar_muerte_brutus();
	thread funcion_spawnear_zmb_bossfight();
 	
 	
 }

function esperar_muerte_brutus()
{
	while(1)
	{
		level waittill("brutus_muerto");
		if (level.es_reset == false)
		{
			break;
		}
	}	
	//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
    array::thread_all( GetPlayers(), &cinematica_final, self );

    level waittill("subtitulos_finales");
    			txt1 = "^1 JIGSAW: ^7Congratulations, you are still alive. Most people are so ungrateful ";
				txt2 = "to be alive...But not you, not anymore... ";
				txt3 = "";
				txt4 = "";
				if (level.idioma == "SPANISH")
				{
				txt1 = "^1 JIGSAW: ^7Felicidades, seguis vivos. La mayoria de la gente esta desagradecida ";
				txt2 = "de estar viva... Pero tu no, ya nunca mas...";
				txt3 = "";
				txt4 = "";
				}
	thread crear_texto(txt1,txt2,txt3,txt4,8);

	level waittill("escribir_supervivientes");
	
	level.custom_game_over_hud_elem = &function_f7b7d070;
	level notify("end_game");

}

 function bot_electrificado()
 {
 	level.has_deadshot = false;
 	self endon("empieza_bossfight");
 	bot = getEnt("bot_electrificado", "targetname");
 	bot useanimtree(#animtree);
    bot AnimScripted( "bot_1_idle", bot.origin , bot.angles, %bot_1_idle);
    struct = getEnt("fx_electrificado", "targetname");
 	trig = getEnt("trig_electrificado", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to kill him and get Deadshot" );  
	trig SetCursorHint("HINT_NOICON");
	trig SetVisibleToAll();
	trig waittill( "trigger", player );
	trig SetInvisibleToAll();
	bot StopAnimScripted();
	bot AnimScripted( "bot_1_muerte_electrica", bot.origin , bot.angles, %bot_1_muerte_electrica);
	thread PlayFxWithCleanup("dlc5/cosmo/fx_weather_lightning_cheap_tower_impact",struct.origin,struct.angles,"a");
	wait(0.3);	
	thread PlayFxWithCleanup("dlc5/cosmo/fx_weather_lightning_cheap_tower_impact",struct.origin,struct.angles,"a");
	wait(0.5);
	level.prisioneros --;
	level.has_deadshot = true;
	foreach(player in getplayers())
	{
		thread zm_perks::vending_trigger_post_think(player, "specialty_deadshot");
	}
 }
 function bot_agua()
 {
 	level.has_doubletap = false;
 	self endon("empieza_bossfight");
 	agua = getEnt("agua", "targetname");
 	agua MoveTo(level.posicion_inicial_agua,0.2);
 	bot = getEnt("bot_agua", "targetname");
 	bot useanimtree(#animtree);
    bot AnimScripted( "trampa5_agua", bot.origin , bot.angles, %trampa5_agua);
 	trig = getEnt("trig_agua", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to kill him and get double tap" );  
	trig SetCursorHint("HINT_NOICON");
	trig SetVisibleToAll();
	trig waittill( "trigger", player );
	trig SetInvisibleToAll();
    level.prisioneros --;
    level.has_doubletap = true;
    foreach(player in getplayers())
    {
        thread zm_perks::vending_trigger_post_think(player, "specialty_doubletap2");
    }
	bot waittill ("trampa5_agua");
	agua MoveZ(20,2);
	bot StopAnimScripted();
	bot AnimScripted( "trampa5a_agua", bot.origin , bot.angles, %trampa7_agua);
	bot waittill ("trampa5a_agua");
	bot StopAnimScripted();
	bot AnimScripted( "trampa7_agua", bot.origin , bot.angles, %trampa7_agua);
	bot waittill ("trampa7_agua");
	bot StopAnimScripted();
	bot AnimScripted( "trampa8_agua_muerte", bot.origin , bot.angles, %trampa8_agua_muerte);
	bot waittill ("trampa8_agua");
	
 }
function bot_aplastado()
{
	level.has_fastmantle = false;
	self endon("empieza_bossfight");
	struct = getEnt("fx_aplasta", "targetname");
	pared_aplasta = getEnt("pared_aplasta", "targetname");
	pared_aplasta_f = getEnt("pared_aplasta_f", "targetname");
	pared_aplasta_f SetInvisibleToAll();
 	bot = getEnt("bot_aplastado", "targetname");
 	bot useanimtree(#animtree);
    bot AnimScripted( "victima1_colgado_loop", bot.origin , bot.angles, %victima1_colgado_loop);
 	trig = getEnt("trig_aplasta", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to kill him and get muscle milk" );  
	trig SetCursorHint("HINT_NOICON");
	trig SetVisibleToAll();
	trig waittill( "trigger", player );
	trig SetInvisibleToAll();
    level.prisioneros --;
    level.has_fastmantle = true;
    foreach(player in getplayers())
    {
        thread zm_perks::vending_trigger_post_think(player, "specialty_fastmantle");
    }

	pared_aplasta MoveTo(pared_aplasta_f.origin,0.2);
	bot StopAnimScripted();
	bot AnimScripted( "victima1_muerte_de_pendulo", bot.origin , bot.angles, %victima1_muerte_de_pendulo);
	wait(0.1);
	thread PlayFxWithCleanup("dlc5/cosmo/fx_blood_decal_impact_ground_zmb",struct.origin,struct.angles,"a");
	wait(3);
	
}
function matar_tom()
{
	level.has_jugger = false;
	self endon("empieza_bossfight");
 	bot = getEnt("tom_trampa", "targetname");
 	bot useanimtree(#animtree);
    bot AnimScripted( "ai_bot_saw_idle", bot.origin , bot.angles, %ai_bot_saw_idle);
 	trig = getEnt("trig_matar_tom", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to stop Tom`s heart and get jugger" );  
	trig SetCursorHint("HINT_NOICON");
	trig SetVisibleToAll();
	trig waittill( "trigger", player );
    level.prisioneros --;
    level.has_jugger = true;
    foreach(player in getplayers())
    {
        thread zm_perks::vending_trigger_post_think(player, "specialty_armorvest");
    }
	trig SetInvisibleToAll();
	bot StopAnimScripted();
	bot AnimScripted( "ai_bot_saw_muere", bot.origin , bot.angles, %ai_bot_saw_muere);
	wait(0.1);
	wait(3);
	
}


function funcion_spawnear_zmb_bossfight()
{
	self endon ("creditos_finales");
	spawns = struct::get_array( "bossfight_spawn_point", "targetname" );
	while(1)
	{
		zombies = zombie_utility::get_round_enemy_array();
        if ( zombies.size <= 24 )
        {
         	spawn =spawns[randomint(spawns.size)];
			dig_zombie = SpawnActor("actor_spawner_zm_human_zombie_1",spawn.origin,spawn.angles,"",true,true);
    		dig_zombie zm_spawner::zombie_spawn_init( undefined );	
    		dig_zombie._rise_spot = spawn;
    		dig_zombie.is_boss = 0;
    		dig_zombie.gibbed = 1;
    		dig_zombie.in_the_ground = 1;
    		dig_zombie.ignore_enemy_count = 0;
    		dig_zombie.ignore_nuke = 0;
    		dig_zombie.no_powerups = 0;
    		dig_zombie.no_damage_points = 0;
    		dig_zombie.deathpoints_already_given = 0;
    		dig_zombie.script_string = "find_flesh";
    		dig_zombie zm_spawner::do_zombie_spawn();
        }
		
    	wait(1);
	}
	
}
function sierras()
{
	sierras = GetEntArray("sierra", "targetname");
	foreach (sierra in sierras)
	{
		thread rotar_sierra(sierra);
		thread desplazar_sierra(sierra);
		thread damage_sierra(sierra);
	}
}

function rotar_sierra(sierra)
{
	while(1)
	{
		sierra RotatePitch(360,0.3);
		wait(0.2);
	}
}
function desplazar_sierra(sierra)
{
	self endon ("creditos_finales");
	sonido_model = Spawn("script_model", sierra.origin);
   	sonido_model SetModel("tag_origin");
   	sonido_model EnableLinkTo();
	sonido_model LinkTo(sierra);
	sonido_model PlayLoopSound("sierra_loop");
	while(1)
	{
		i = RandomIntRange(10,17); //(min result, max rasult + 1) 
		j = RandomIntRange(1,4); //(min result, max rasult + 1) 
		sierra MoveX(976,i);
		wait(i);
		wait(j);
		i = RandomIntRange(10,17); //(min result, max rasult + 1) 
		j = RandomIntRange(1,4); //(min result, max rasult + 1) 
		sierra MoveX(-976,i);
		wait(i);
		wait(j);

	}
}
function damage_sierra(sierra)
{
	self endon ("creditos_finales");
	while(1)
	{
		wait(0.2);
		foreach(player in getplayers())
		{
			if (player IsTouching(sierra))
			{
				player.health = player.health - 10;
				if (player.health <=10)
				{
					player Kill();
				}
			}
		}
	}
}

function creditos()
{
	andres = getEnt("don_andres_666", "targetname");
	andres SetInvisibleToAll();
	brack = getEnt("zmbrack115", "targetname");
	brack SetInvisibleToAll();
	level waittill ("creditos_finales");
	 cabeza = getEnt("cabeza", "targetname");
     cabeza useanimtree(#animtree);
     cabeza AnimScripted( "cabeza_tortura_muerte", cabeza.origin , cabeza.angles, %cabeza_tortura_muerte);

     puerta = getEnt("puerta", "targetname");
     puerta useanimtree(#animtree);
     puerta AnimScripted( "puerta_bunker_tortura_abre", puerta.origin , puerta.angles, %puerta_bunker_tortura_abre);

     cadenas = getEnt("cadenas", "targetname");
     cadenas useanimtree(#animtree);
     cadenas AnimScripted( "cadenas_bunker_tortura_abre", cadenas.origin , cadenas.angles, %cadenas_bunker_tortura_abre);
	andres SetVisibleToAll();
	brack SetVisibleToAll();
}
//---------------------------------------------------//MUSICA_AMBIENTAL//----------------------------------------------------------------------
function musicplaying()
{
    //Wait till game starts
    level flag::wait_till( "initial_blackscreen_passed" );
    //IPrintLn("Herro?");
    musicmulti = GetEntArray("musicmulti","targetname");
    //IPrintLn("Found " + musicmulti.size + " Ents");
    foreach(musicpiece in musicmulti)
       musicpiece thread sound_logic();
}
 
function sound_logic()
{
    while(1)
    {
        self waittill("trigger", player);
        if(level.musicplay == false)
        {
            level.musicplay = true;
            //IPrintLn("Music Activated: "+self.script_string);
            player PlaySoundWithNotify(self.script_string, "soundcomplete");
            player waittill("soundcomplete");
            //IPrintLn("Music Over");
            level.musicplay = false;
        }
        else
        {
            //IPrintLn("Music Already Playing");
        }
 
    }
}
//---------------------------------------------------//MUSICA_AMBIENTAL//----------------------------------------------------------------------


//KEYCARD
function init_keycard()
{
    level.key_obtained = false;
    key = GetEnt( "key_trigger", "targetname" );
    key SetCursorHint( "HINT_NOICON" );
    key SetHintString( "Press and Hold ^3&&1^7 to Pick Up Keycard" );
    key thread wait_for_pickup();

    trig = GetEnt( "key_door_trig", "targetname" );
    trig SetCursorHint( "HINT_NOICON" );
    trig SetHintString( "A Key is Required to Open the Door" );
    puerta = GetEnt( "key_door", "targetname" );
    clip = GetEnt( "key_door_clip", "targetname" ); 
    puerta_abierta = GetEnt( "key_door_abierta", "targetname" );
    puerta_abierta SetInvisibleToAll();
     while( !level.key_obtained )
        wait(0.25);

    trig SetHintString( "Press and Hold ^3&&1^7 to Unlock Door" );
    trig waittill( "trigger", player );
    PlaySoundAtPosition( "puerta_metal", player.origin );
    clip EnableLinkTo();
    clip LinkTo(puerta);
    puerta MoveTo(puerta_abierta.origin,1);
    puerta RotateTo(puerta_abierta.angles,1);
    
}

function wait_for_pickup()
{
    self waittill( "trigger", player );
    model = GetEnt( self.target, "targetname" );
    model delete();
    self delete();
    level.key_obtained = true;
    iprintlnbold( "The Keycard Has Been Obtained" );
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

function sustos_laberinto()
{
    thread susto_risa_jisaw();
    thread paciente_trampa_osos();
    thread susto_sierra();
    thread susto_mono();
    thread susto_puerta(1);
    thread susto_puerta(2);
}

    function susto_risa_jisaw()
{
	trig = getEnt("trig_susto_risa", "targetname");
	model = getEnt("model_susto_risa", "targetname");
	trig waittill("trigger", player);
	model useanimtree(#animtree);
    model AnimScripted( "jigsaw_habla_colgado", model.origin , model.angles, %jigsaw_habla_colgado);
    PlaySoundAtPosition("risa_jigsaw",model.origin);
    
}
function paciente_trampa_osos()
{
	trig = getEnt("trig_paciente_osos", "targetname");
	model = getEnt("paciente_trampa_osos", "targetname");

	model useanimtree(#animtree);
    model AnimScripted( "saw_pasiente1_loop", model.origin , model.angles, %saw_pasiente1_loop);
    while(1)
    {
    	trig waittill("trigger", player);
    	if(player zm_utility::is_player_looking_at(model.origin, 0.85, true, player))
			{
				//model waittill ("saw_pasiente1_trampa_osos");
				model StopAnimScripted();
				model AnimScripted( "saw_pasiente1_trampa_osos", model.origin , model.angles, %saw_pasiente1_trampa_osos);
				model waittill ("saw_pasiente1_trampa_osos");
				model StopAnimScripted();
				model AnimScripted( "saw_pasiente1_loop_parado", model.origin , model.angles, %saw_pasiente1_loop_parado);
				break;
			}
    }
}
function susto_sierra()
{

	sierra = GetEnt("sierra_susto", "targetname");
	thread girar_sierra_susto(sierra);
	brushes = GetEntArray("sierra_susto_brush", "targetname");
	trig = getEnt("trig_bot_colgado", "targetname");
	trig_mirar = getEnt("trig_mirar_bot_colgado", "targetname");
	model = getEnt("bot_trampa_colgado", "targetname");

	model useanimtree(#animtree);
    model AnimScripted( "saw_trampa1_loop_colgado", model.origin , model.angles, %saw_trampa1_loop_colgado);
    while(1)
    {
    	trig waittill("trigger", player);
    	if(player zm_utility::is_player_looking_at(trig_mirar.origin, 0.85, true, player))
			{			
				foreach(brush in brushes)
				{
					brush MoveX(30,2);
				}
				sierra MoveX(30,2);
				wait(3);
				foreach(brush in brushes)
				{
					brush MoveX(-30,2);
				}
				sierra MoveX(-30,2);

				wait(1);
				//model waittill ("saw_trampa1_loop_colgado");
				model StopAnimScripted();
				model AnimScripted( "saw_trampa1_loop_colgado_muere", model.origin , model.angles, %saw_trampa1_loop_colgado_muere);
				break;
			}
    }
}
function girar_sierra_susto(sierra)
{
	sierra PlaySound("sierra_loop");
	while(1)
	{
		sierra RotatePitch(360,0.3);
		wait(0.2);
	}
}


function susto_mono()
{
	model = getEnt("mono", "targetname");
	trig = getEnt("trig_mono", "targetname");
	trig waittill("trigger", player);
	PlaySoundAtPosition("sonido_mono",model.origin);
}


function susto_puerta(i)
{
	puerta = getEnt("puerta_susto_"+i, "targetname");
	puerta_abierta = getEnt("puerta_susto_abierta_"+i, "targetname");
	puerta_abierta SetInvisibleToAll();
	trig = getEnt("trig_susto_puerta_"+i, "targetname");
	model = getEnt("bot_puerta_susto_"+i, "targetname");
	origen = puerta.origin;
	angulos = puerta.angles;
	while(1)
	{
		trig waittill("trigger", player);
    	puerta MoveTo(puerta_abierta.origin,1);
    	puerta RotateTo(puerta_abierta.angles,1);
    	PlaySoundAtPosition("abrir_puerta",puerta.origin);
    	PlaySoundAtPosition("susto1",puerta.origin);
    	model useanimtree(#animtree);
    	model AnimScripted( "saw_pasiente2_jumpscare_puerta", model.origin , model.angles, %saw_pasiente2_jumpscare_puerta);
    	wait(2);
    	puerta MoveTo(origen,1);
    	puerta RotateTo(angulos,1);
    	wait(10);


	}
}