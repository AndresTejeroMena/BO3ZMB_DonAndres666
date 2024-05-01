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

//MANGLER
#using scripts\zm\_zm_ai_raz;
//magicbox
#using scripts\zm\_hb21_zm_magicbox;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_perks;
#insert scripts\zm\_zm_perks.gsh;
//perks
#using scripts\zm\logical\perks\_zm_perk_ffyl;
#using scripts\zm\logical\perks\_zm_perk_icu;
#using scripts\zm\logical\perks\_zm_perk_tactiquilla;
#using scripts\zm\logical\perks\_zm_perk_milk;
#using scripts\zm\_zm_perk_banana_colada;
#using scripts\zm\_zm_perk_crusaders_ale;
#using scripts\zm\_zm_perk_madgaz_moonshine;
#using scripts\zm\_zm_perk_bull_ice_blast;
#using scripts\zm\_zm_perk_wunderfizz2;

//Attackable
//#using scripts\zm\symbo_harrybo_attackable;
//TELEPORT
#using scripts\shared\lui_shared;
//soulbox
#using scripts\zm\growing_soulbox;
//hud bar
#using scripts\shared\hud_util_shared;



#precache( "fx", "zombie/fx_meatball_trail_sky_zod_zmb" );

#precache( "fx", "explosions/fx_exp_bomb_demo_mp" );

#precache( "fx", "dlc2/island/fx_gas_takeo_reveal");
#precache( "fx", "dlc2/island/fx_skull_quest_electric_shock_lg_island");

#namespace script_cyber;

function init()
{
	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
    	//Stop Spawning
    	level flag::clear( "spawn_zombies" );

	wait(0.5);
	thread dificultades();
	thread tren();
	thread todas_las_cajas();
	thread bailarina();
	thread prender_maquinas();
	thread cae_atacable();
	thread gas_toxico();
	thread easter_egg();
	thread final_comprable();
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TODAS LAS CAJAS
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function todas_las_cajas()
{
	
	level waittill ("dificultad_seleccionada");
	for ( i = 0; i < level.chests.size; i++ )
    {
        show_firesale_box = level.chests[i] [[level._zombiemode_check_firesale_loc_valid_func]]();

        if ( show_firesale_box )
        {
            level.chests[i].zombie_cost = level.precio_caja;

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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// BAILARINA
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function bailarina()
{
	trig = getEnt("zona_bailarina", "targetname");
	bailarina1 = getEnt("bailarina1", "targetname");
	bailarina2 = getEnt("bailarina2", "targetname");
	bailarina1 SetInvisibleToAll();
	level waittill ("dificultad_seleccionada");
	t = level.tiempo_cambio_de_modelo_bailarina;
	while(1)
	{
		trig waittill("trigger", player);
		bailarina1 SetVisibleToAll();
		bailarina2 SetInvisibleToAll();
		wait(t);
		trig waittill("trigger", player);
		bailarina2 SetVisibleToAll();
		bailarina1 SetInvisibleToAll();
		wait(t);
	}

}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PRENDER MAQUINAS
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function prender_maquinas()
{
	flag::init( "power_on" ); 
    flag::set("power_on");
    thread quickperkmachine("trig_qr1","PERK_QUICK_REVIVE",1500,"Quick Revive","specialty_quickrevive","quickrevive_on");
    thread perkmachine("trig_jg1","PERK_JUGGERNOG",2500,"Juggernog","specialty_armorvest","armorvest_on");
    thread perkmachine("trig_speedcola","PERK_SLEIGHT_OF_HAND",3000,"Speed Cola","specialty_fastreload","fastreload_on");
    thread perkmachine("trig_milk","PERK_MILK",3000,"Muscle Milk","specialty_fastmantle","milk_on");
    thread perkmachine("trig_bull","PERK_BULL_ICE_BLAST",3000,"Bull Ice Blast","specialty_proximityprotection","bull_on");
	
}
function perkmachine(trigger,perk,cost,perkname,specialtyperk,notification)
{
	trig = getEnt(trigger, "targetname");
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString( "Need Power...");
	level waittill(notification);
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
function quickperkmachine(trigger,perk,cost,perkname,specialtyperk,notification)
{
	trig = getEnt(trigger, "targetname");
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString( "Need Power...");
	level waittill ("dificultad_seleccionada");
	numero_de_quicks = 0;
	if (GetPlayers().size==1)
	{
		cost = 500;
	}
	else
	{	
	level waittill(notification);
	}
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
        numero_de_quicks++;
        if (numero_de_quicks >= 3)
        {
        	if (GetPlayers().size==1)
        	{
        		trig SetHintString( "Empty... "); 
        		break;
        	}
        }
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CAE ATACABLE
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function cae_atacable()
{
	for( i = 0; i < level.numero_de_atacables_normales; i++ )
	{
		n = i + 1;
		thread cae_un_atacable(n);
	}
	thread otra_puerta_atacable();
}
function cae_un_atacable(i)
{
	DISTANCIA_CAIDA = level.distancia_de_caida_del_meteorito;
	TIEMPO_CAIDA = level.tiempo_de_caida_del_meteorito;
	SONIDO_METEORITO = level.sonido_caida_meteorito;
	SONIDO_IMPACTO = level.sonido_impacto_meteorito;
	clip_atacable = GetEnt("clip_atacable"+i, "targetname");
	atacable = GetEnt("atacable_cae"+i, "targetname");
	trig = getEnt("trig_cea_atacable"+i, "targetname");
	fx_array = GetEntArray("fx_atacable"+i, "targetname");

	paredes = GetEntArray("pared_atacable"+i, "targetname");
	trig_activar = getEnt("trig_atacable"+i, "targetname");
	zona = getEnt("zona_atacable"+i, "targetname");

	abierta = getEnt("abierta_zona"+i, "targetname");
	abierta SetInvisibleToAll();
	puerta = getEnt("puerta_zona"+i, "targetname");
	clip = getEnt("clip_puerta_zona"+i, "targetname");

	modelos_explosion = GetEntArray("model_explosion"+i, "targetname");
	fx_explosion = GetEnt("fx_explosion_atacable"+i, "targetname");

	foreach(model in modelos_explosion)
	{
		model SetInvisibleToAll();
	}
	foreach(pared in paredes)
	{
		pared SetInvisibleToAll();
	}
	trig_activar SetInvisibleToAll();


	atacable SetInvisibleToAll();
	atacable MoveZ(DISTANCIA_CAIDA,0.1);
	foreach(fx in fx_array)
	{
		fx MoveZ(DISTANCIA_CAIDA,0.1);
	}
	trig waittill("trigger", player);
	foreach(fx in fx_array)
	{
		thread PlayFxWithCleanup("zombie/fx_meatball_trail_sky_zod_zmb",fx.origin,fx.angles,"atacable_suelo");	
	}
	wait(0.2);
	atacable SetVisibleToAll();
	sonido_model = Spawn("script_model", atacable.origin);
   	sonido_model SetModel("tag_origin");
   	sonido_model EnableLinkTo();
	sonido_model LinkTo(atacable);
	sonido_model PlayLoopSound(SONIDO_METEORITO);
	atacable MoveZ(-DISTANCIA_CAIDA,TIEMPO_CAIDA,0.1,0.1);
	wait(TIEMPO_CAIDA);
	PlayFX("explosions/fx_exp_bomb_demo_mp",fx_explosion.origin);
	foreach(model in modelos_explosion)
	{
		model SetVisibleToAll();
	}
	PlaySoundAtPosition(level.sonido_fx_explosion, trig_activar.origin);
	level notify ("atacable_suelo");
	sonido_model Delete();
	PlaySoundAtPosition(SONIDO_IMPACTO,atacable.origin);
	Earthquake(0.5, 2, atacable.origin ,1500 );//CUSTOM: terremoto Earthquake(<escala>,<duracion>,<localizacion del terremoto>,<radio>)


	trig_activar SetCursorHint("HINT_NOICON");
	trig_activar SetHintString( "Press and Hold ^3&&1^7 to defend hardpoint (All players in Hardpoint)");
	
	level.zona_completada[i] = false;
	while(1)
	{
		level.estan_en_zona = false;
		foreach(pared in paredes)
		{
			pared SetInvisibleToAll();
		}
		if (level.zona_completada[i] == true)
		{
			break;
		}
		trig_activar SetVisibleToAll();
		trig_activar waittill("trigger", player);
		level.estan_en_zona = true;
		foreach(pared in paredes)
		{
			pared SetVisibleToAll();
		}
		players = GetPlayers();
		a = 0;
	    for( j = 0; j < players.size; j++ ) //set up a for loop for player size
	    {
	        if (players[j] IsTouching(zona)) {a++;}
	    }
	    if (a == players.size)
	    {
	    	for( j = 0; j < players.size; j++ ) //set up a for loop for player size
		    {
	    		thread contador_zona(players[j],i);
		    }
	    	IPrintLnBold("Stay within the hard point!");
	    	trig_activar SetInvisibleToAll();
	    	level notify ("spawn_bolas_atacable");
	    	while(1)
	    	{
	    		WAIT_SERVER_FRAME;
	    		players = GetPlayers();
				b = 0;
			    for( j = 0; j < players.size; j++ ) //set up a for loop for player size
			    {
			        if (players[j] IsTouching(zona)) {b++;}
			    }
			    if (b < players.size)
			    {
			    	level.estan_en_zona = false;
			    	break;
			    }
			    if (level.zona_completada[i] == true)
			    {
			    	break;
			    }
	    	}
	    	level notify ("stop_spawn_bolas_atacable");
	    }
	}

	PlayFX("explosions/fx_exp_bomb_demo_mp",fx_explosion.origin);
	PlaySoundAtPosition(level.sonido_fx_explosion, trig_activar.origin);
	thread playsoundok(level.sonido_zona_completada);
	puerta MoveTo(abierta.origin,1);
	puerta RotateTo(abierta.angles,1);
	clip Delete();
	atacable Delete();
	clip_atacable Delete();
	level notify ("puerta_atacable"+i);
	flag::init( "atacable"+i);
    flag::set("atacable"+i);

	
}
function PlayFxWithCleanup(fx, origin,angles, notification)
{
    fxModel = Spawn("script_model", origin);
    fxModel SetModel("tag_origin");
    fxModel RotateTo(angles,0.1);
    wait(0.2);
    WAIT_SERVER_FRAME;
    fxModel.arc_fx = util::spawn_model("tag_origin", fxModel.origin, fxModel.angles);
    PlayFXOnTag(fx, fxModel.arc_fx, "tag_origin");
    fxModel.arc_fx MoveZ(-level.distancia_de_caida_del_meteorito,level.tiempo_de_caida_del_meteorito);
    fxModel.arc_fx MoveZ(-level.distancia_de_caida_del_meteorito,level.tiempo_de_caida_del_meteorito);
    level waittill(notification);
    fxModel.arc_fx Delete();
}
function contador_zona(player,i)
{
	player.HealthBar = player hud::createBar((1,0.5,0),100,10);
	carga=0;
	while( 1 )
			{
				wait(0.1);
				carga ++;
				fraccion = carga/(level.tiempo_en_zona*10);
				player.HealthBar hud::updateBar(fraccion);
				if (fraccion >= 1)
				{
					level.zona_completada[i] = true;
					break;
				}
				if (level.estan_en_zona == false)
				{
					break;
				}
			}
			player.HealthBar hud::destroyElem();
}
function otra_puerta_atacable()
{
	puerta = GetEnt("otra_puerta_atacable_a", "targetname");
	abierta = GetEnt("otra_puerta_atacable_abierta_a", "targetname");
	abierta SetInvisibleToAll();
	clip = GetEnt("clip_otra_puerta_a", "targetname");
	puertas_b = GetEntArray("otra_puerta_atacable_b", "targetname");
	clips_b = GetEntArray("clip_otra_puerta_b", "targetname");
	level waittill("puerta_atacable1");
	puerta MoveTo(abierta.origin,0.3);
	puerta RotateTo(abierta.angles,0.3);
	clip Delete();

	foreach (puerta_b in puertas_b)
	{
		puerta_b Delete();
	}
	foreach (clip_b in clips_b)
	{
		clip_b Delete();
	}

}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TREN
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function tren()
{
	tren[1] = getEnt("tren_i", "targetname");
	tren_f[1] = getEnt("tren_f", "targetname");
	tren[2] = getEnt("tren2_i", "targetname");
	tren_f[2] = getEnt("tren2_f", "targetname");
	tren[3] = getEnt("tren3_i", "targetname");
	tren_f[3] = getEnt("tren3_f", "targetname");
	tren_f[1] SetInvisibleToAll();
	tren_f[2] SetInvisibleToAll();
	tren_f[3] SetInvisibleToAll();
	pos_inicial[1] = tren[1].origin;
	pos_inicial[2] = tren[2].origin;
	pos_inicial[3] = tren[3].origin;
	TIEMPO_DESPLAZAMIENTO = level.tiempo_de_desplazamiento_del_tren;
	TIEMPO_ENTRE_TRENES = level.tiempo_entre_un_tren_y_otro;
	SONIDO_TREN_LOOP = level.sonido_del_tren;

	while(1)
	{
		for( i = 1; i < 4; i++ )
		{
			tren[i] SetVisibleToAll();
			wait(TIEMPO_ENTRE_TRENES);
			sonido_model = Spawn("script_model", tren[i].origin);
	   		sonido_model SetModel("tag_origin");
	   		sonido_model EnableLinkTo();
			sonido_model LinkTo(tren[i]);
			sonido_model PlayLoopSound(SONIDO_TREN_LOOP);
			tren[i] MoveTo(tren_f[i].origin,TIEMPO_DESPLAZAMIENTO);
			wait (TIEMPO_DESPLAZAMIENTO);
			sonido_model Delete();
			tren[i] SetInvisibleToAll();
			wait(1);
			tren[i] MoveTo(pos_inicial[i],0.5);
		}
		
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// DIFICULTADES
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function dificultades()
{
	level flag::wait_till("initial_blackscreen_passed");
	level.dificultad_seleccionada = false;
	thread facil();
	thread dificil();
	level waittill ("dificultad_seleccionada");
	level.dificultad_seleccionada = true;
	//Start zombies spawn
		level flag::set( "spawn_zombies" );
	thread teleport_players_start_game();
	for (i = 1; i < level.zombies_sprintan_ronda ; i++)
	{
		level waittill ("end_of_round");
		wait(1);
	}
	level.zombie_init_done = &mpjw_make_sprinter;

}
function mpjw_make_sprinter()
{
    if ( isDefined( level.ptr_zombie_init_done ) )
        self [ [ level.ptr_zombie_init_done ] ]();
    
    self zombie_utility::set_zombie_run_cycle( "sprint" ); //"walk" "run" "sprint"
}
function facil()
{
	trig = getEnt("modo_facil", "targetname");
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString( "Press and Hold ^3&&1^7 to Start Normal Mode.");

	trig waittill("trigger", player);
	if (level.dificultad_seleccionada == false)
	{
		level.es_dificil = false;
		level.dificultad_seleccionada = true;

		level.maximo_zombies = level.maximo_zombies_facil;
		level.precio_caja = level.precio_de_la_caja_facil;
		level.zombies_sprintan_ronda = level.zombies_sprintan_en_ronda_facil;
		level.numero_manglers_bossfight = level.numero_manglers_bossfight_facil;
		level.numero_panzzers_bossfight = level.numero_panzzers_bossfight_facil;

		level notify ("dificultad_seleccionada");
	}
}
function dificil()
{

	trig = getEnt("modo_dificil", "targetname");
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString( "Press and Hold ^3&&1^7 to Start Hard Mode.");
	trig waittill("trigger", player);
	if (level.dificultad_seleccionada == false)
	{
		level.es_dificil = true;
		level.dificultad_seleccionada = true;

		level.maximo_zombies = level.maximo_zombies_dificil;
		level.precio_caja = level.precio_de_la_caja_dificil;
		level.zombies_sprintan_ronda = level.zombies_sprintan_en_ronda_dificil;
		level.numero_manglers_bossfight = level.numero_manglers_bossfight_dificil;
		level.numero_panzzers_bossfight = level.numero_panzzers_bossfight_dificil;

		level notify ("dificultad_seleccionada");
	}
}
function teleport_players_start_game()
{
	players = GetPlayers();
    for( i = 0; i < players.size; i++ ) //set up a for loop for player size
    {
        players[i] thread teleport_player(i);
    }

	flag::init( "zona1flag");
    flag::set("zona1flag");
}
function teleport_player(i)
{
    self SetElectrified(2.5);
    self FreezeControls(true);
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, "white" );
    wait(.2);
        destinations[i] = struct::get("teleport_" + i, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// GAS TOXICO
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function gas_toxico()
{
	SONIDO_ALARMA = level.sonido_alarma_comienzo_gas;
	trig = getEnt("zona_segura", "targetname");
	trig waittill("trigger", player);
	level util::clientnotify("empieza_gas");
	thread fx_gas();
	thread playsoundok(SONIDO_ALARMA);
	wait(1);
	foreach(player in getplayers() )
        {
        	thread check_zona_gas(player,trig);
            player StartPoisoning();
            thread quitar_vida(player,player.playername);
            thread sin_regeneracion_de_vida(player,player.playername);
        }
    

}
function check_zona_gas(jugador,trig)
{
	while(1)
	{
            jugador StartPoisoning();
            thread quitar_vida(jugador,jugador.playername);
            thread sin_regeneracion_de_vida(jugador,jugador.playername);
            while(1)
            {	
            	WAIT_SERVER_FRAME;
            	if (jugador IsTouching(trig))
            	{
            		break;
            	}
            }
            wait(0.2);
            level notify (jugador.playername + "_zona_segura");
            jugador StopPoisoning();
            while(1)
            {
            	WAIT_SERVER_FRAME;
            	if (jugador IsTouching(trig))
            	{
            		continue;
            	}
            	else{break;}
            }

	}
}
function quitar_vida(player,playername)
{
	self endon (playername + "_zona_segura");
	while(1)
    {
    	wait(level.tiempo_maximo_en_gas / 100);
        if (player.health <= 2)
       	{
        	player Kill();
        }
        player.health -=1;
    }
}
function sin_regeneracion_de_vida(player,playername)
{
	self endon (playername + "_zona_segura");
	while(1)
	{
		WAIT_SERVER_FRAME;
		player.hurtAgain = true;
	}

}
function fx_gas()
{
	fxs = GetEntArray("fx_gas", "targetname");
	foreach (fx in fxs)
	{
		thread playfx_gas(fx);
	}
}
function playfx_gas(fx)
{
	fxModel = Spawn("script_model", fx.origin);
    fxModel SetModel("tag_origin");
	fxModel RotateTo(fx.angles,0.1);
    wait(0.2);
    WAIT_SERVER_FRAME;
    fxModel.arc_fx = util::spawn_model("tag_origin", fxModel.origin, fxModel.angles);
    PlayFXOnTag("dlc2/island/fx_gas_takeo_reveal", fxModel.arc_fx, "tag_origin");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// FINAL COMPRABLE
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function final_comprable()
{
	level waittill("dificultad_seleccionada");
    players = GetPlayers();
	trig = getEnt("end_trigger", "targetname");	
	trig SetCursorHint("HINT_NOICON");
	total = level.pts_final_comprable + players.size;
	trig SetHintString("Press and Hold ^3&&1^7 to end the game. (Total players points: "+total+" pts)"); 
	while(1)
		{
			trig waittill("trigger", player);
			puntos_tot = 0;

			foreach(player in getplayers() )
        	{
        		puntos_tot += player.score;
        	}
			if (puntos_tot >= total)
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
	game_over SetText("Thx for playing. Support our maps on workshop to keep us motivated. DonAndres_666 & ZMbrack115");

	game_over FadeOverTime( 1 );
	game_over.alpha = 1;
	if ( player isSplitScreen() )
	{
		game_over.fontScale = 2;
		game_over.y += 40;
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// EASTER EGG 		EASTER EGG 		EASTER EGG 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function easter_egg()
{
	thread paso1_modelo_secreto();
	thread paso2_encontrar_llave();
	thread paso3_disparables();
	thread paso4_almas();
	thread paso5_montar_nuke();

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PASO 1: MODELO SECRETO
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function paso1_modelo_secreto()
{
	SONIDO = level.sonido_recoger_objeto_secreto;
	trig = getEnt("trig_secreto", "targetname");
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString( "");
	level waittill ("dificultad_seleccionada");
	if (level.es_dificil == true)
	{
		trig waittill("trigger", player);
		trig Delete();
		thread playsoundok(SONIDO);
		level notify ("paso1_completado");
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PASO 2: ENCONTRAR LLAVE Y CAJAS FUERTES
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function paso2_encontrar_llave()
{
	SONIDO = level.sonido_recoger_llave;
	trig = getEnt("trig_keycard", "targetname");
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString( "Press and Hold ^3&&1^7 to take keycard");
	model = getEnt("keycard", "targetname");
	model SetInvisibleToAll();
	trig SetInvisibleToAll();

	thread cajafuerte(1);
	thread cajafuerte(2);
	thread cajafuerte(3);
	level waittill ("paso1_completado");
	model SetVisibleToAll();
	trig SetVisibleToAll();
	trig waittill("trigger", player);
	trig Delete();
	model Delete();
	thread playsoundok(SONIDO);
	level notify ("keycard_encontrada");
}
function cajafuerte(i)
{
	level.piezas_nuke = 0;
	trig = getEnt("trig_cajafuerte"+i, "targetname");
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString( "Press and Hold ^3&&1^7 to open");
	trig SetInvisibleToAll();
	abierta = getEnt("cajafuerte_abierta"+i, "targetname");
	abierta SetInvisibleToAll();
	puerta = getEnt("cajafuerte_cerrada"+i, "targetname");
	model = getEnt("cajafuerte_obj"+i, "targetname");

	level waittill ("keycard_encontrada");
	trig SetVisibleToAll();
	trig waittill("trigger", player);
	trig SetHintString( "");
	puerta MoveTo(abierta.origin,1);
	puerta RotateTo(abierta.angles,1);
	wait(1.1);
	trig SetHintString( "Press and Hold ^3&&1^7 to take part");
	trig waittill("trigger", player);
	trig Delete();
	model Delete();
	level.piezas_nuke ++;
	if (level.piezas_nuke == 3)
	{
		level notify ("paso2_completado");
	}
	trig_nuke = getEnt("trig_nuke", "targetname");
	trig_nuke SetHintString( "Press and Hold ^3&&1^7 to build nuke. ^3(" + level.piezas_nuke +"/" +3 + ")"  ); 


}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PASO 3:DISPARABLES
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function paso3_disparables()
{
	alldisparables = GetEntArray("disparable", "targetname");
	level.disparables_disparados = 0;
	level.contar_5_disparables = 0;
	level.total_disparables = alldisparables.size;

	foreach (disparable in alldisparables)
	{
		disparable thread esperar_a_ser_disparado();
		disparable thread rotar_objeto_continuamente();
	}
}
function rotar_objeto_continuamente()
{
	modelo_target = GetEnt(self.target, "targetname");
	velocidad = 1;
	while(1)
	{
		modelo_target RotateYaw(360,velocidad);
		wait ((velocidad)-0.1);
	}
}
function esperar_a_ser_disparado()
{
	self waittill("trigger", player);
	PlayFX("dlc2/island/fx_skull_quest_electric_shock_lg_island",self.origin);
	thread playseondok();
	modelo_target = GetEnt(self.target, "targetname");
	modelo_target Delete();
	level.disparables_disparados ++;
	level.contar_5_disparables ++;
	IPrintLnBold(level.disparables_disparados + "/" + level.total_disparables);

	if (level.contar_5_disparables == 5)
	{
		level.contar_5_disparables = 0;
		player parasite_drop_item(self.origin,"full_ammo"); //spawnea powerup y llega a jugador
		perk_origin = (self.origin[0] + 50,self.origin[1] + 50,self.origin[2]);

		player parasite_drop_item(perk_origin,"free_perk"); //spawnea powerup y llega a jugador
	}
	if (level.disparables_disparados == level.total_disparables)
	{
		level notify("paso3_completado");
	}
}
function parasite_drop_item( v_parasite_origin , powerup )// Calculates spawn position for powerup and moves it if in invalid spawn position
{	
	if ( !( zm_utility::check_point_in_enabled_zone( v_parasite_origin, true, level.active_zones ) ) )
	{
		// Checks type of item, then spawns item at the parasite's origin
		e_parasite_drop = level zm_powerups::specific_powerup_drop( powerup, v_parasite_origin );
		
		current_zone = self zm_utility::get_current_zone();
		if( isdefined( current_zone ) )
		{
			const n_ground_offset = 20;

			v_start = e_parasite_drop.origin;
						
			e_closest_player = ArrayGetClosest( v_start, level.activeplayers );
			if( isdefined( e_closest_player ) )
			{
				v_target = e_closest_player.origin + (0, 0, n_ground_offset);

				// We know the target position is valid
				// - Project a vector to the target position and drop the item at the first available point along the vector 
				//   that is inside playable space
				
				n_distance_to_target = Distance( v_start, v_target );
				v_dir = VectorNormalize( v_target - v_start );

				n_step = 50;
				n_distance_moved = 0;
				v_position = v_start;
				while( n_distance_moved <= n_distance_to_target )
				{
					v_position += (v_dir * n_step);

					if ( zm_utility::check_point_in_enabled_zone( v_position, true, level.active_zones ) )
					{
						// Only accept the position if the dist to the target ground position isn't too large
						// - This check stops pickups getting stuck on ledges
						n_height_diff = abs( v_target[2] - v_position[2] );
						if( n_height_diff < 60 )
						{
							break;
						}
					}

					n_distance_moved += n_step;
				}

				// Push the drop position to the floor
				trace = bullettrace( v_position, v_position + (0,0,-256 ), false, undefined );
				v_ground_position = trace["position"];
				if( isdefined(v_ground_position) )
				{
					v_position = ( v_position[0], v_position[1], v_ground_position[2] + n_ground_offset );
				}

				// Move to the drop position
				n_flight_time = Distance( v_start, v_position ) / 100;
				if( n_flight_time > 4.0 )
				{
					n_flight_time = 4.0;
				}
				e_parasite_drop MoveTo( v_position, n_flight_time );
			}
			else
			{
				// Failsafe
				v_nav_check = GetClosestPointOnNavMesh( e_parasite_drop.origin, 2000, 32 );
			}
		}
	}
	else
	{
		// If parasite is above navmesh, checks type of item and then spawns item on the ground below the parasite
		level zm_powerups::specific_powerup_drop( powerup, GetClosestPointOnNavMesh( v_parasite_origin, 1000, 30 ) );
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PASO 4:ALMAS
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function paso4_almas()
{
	trig = getEnt("trig_almas", "targetname");
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString( "Press and Hold ^3&&1^7 to start the charge of souls. (PANZERS WILL SPAWN)");
	trig SetInvisibleToAll();
	modelo = getEnt("almas", "targetname");
	clip = getEnt("clip_almas", "targetname");
	modelo SetInvisibleToAll();
	clip SetInvisibleToAll();
	nuke_normal = getEnt("nuke_normal", "targetname");
	nuke_normal SetInvisibleToAll();
	level waittill ("dificultad_seleccionada");
	if (level.es_dificil == true)
	{
		modelo SetVisibleToAll();
		clip SetVisibleToAll();
		trig SetVisibleToAll();
		trig waittill("trigger", player);
		trig Delete();
		level notify("comienza_recoleccion_de_almas");
		level.grow_soul_start_scale = 1;//starting scale of model
		level.grow_soul_growth = 0.01;//growth per zombie
		level.grow_soul_size = (level.numero_almas_a_recolectar/100)+1;//how big you want it to get scale wise
		thread cargar_almas("almas");
		level waittill ("almas" + "_allgrowsouls");
		modelo = getEnt("almas", "targetname");
		nuke_normal SetVisibleToAll();
		modelo Delete();
		clip Delete();
		level.almas_llenas ++;
		level notify ("paso4_completado");
	}
}
function cargar_almas(system)
{
		grow_soul::SetUpReward(system); 
		grow_soul::WatchZombies();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PASO 5:MONTAR NUKE
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function paso5_montar_nuke(i)
{
	model = getEnt("nuke_model", "targetname");
	model SetInvisibleToAll();
	trig = getEnt("trig_nuke", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to build nuke. ^3(" + level.piezas_nuke +"/" +3 + ")"  ); 
	trig SetCursorHint("HINT_NOICON");
	trig SetInvisibleToAll();
	level waittill ("paso4_completado");
	trig SetVisibleToAll();
	while(1)
	{
		trig waittill( "trigger", player );
		if (level.piezas_nuke <= 2)
		{
			IPrintLnBold("You need more parts to build it.");
		}
		else
		{
			player.HealthBar = player hud::createBar((0,0.6,0),100,10);
			carga=0;
			completado = false;
			while( player UseButtonPressed() )
			{
				wait(0.1);
				carga ++;
				fraccion = carga/50;
				player.HealthBar hud::updateBar(fraccion);
				if (fraccion >= 1)
				{
					completado = true;
					break;
				}
			}
			player.HealthBar hud::destroyElem();
			if (completado == true)
			{
				break;
			}		
		}
	}
	model SetVisibleToAll();
	wait(1);
	trig SetHintString( "Press and Hold ^3&&1^7 to activate NUKE (survive one minute and end the game)" );	
	trig waittill( "trigger", player );
	trig Delete();
	level notify("nuke_activada");
	IPrintLnBold("NUKE HAS BEEN ACTIVATED!");
	thread playsoundok(level.sonido_alarma_nuke);
	thread cuenta_atras_nuke(level.tiempo_cuenta_atras);
	wait(level.tiempo_cuenta_atras - 3);
	foreach( player in GetPlayers() )
	{
		self thread lui::screen_flash( 2, 1, 2, 1.0, "white" );
	}

}

function cuenta_atras_nuke(tiempo)
{
	level endon( "end_game" );
	time = int(tiempo);
	max = time;
	
	hud = NewHudElem();
	hud.horzAlign = "center";
   	hud.vertAlign = "top";
   	hud.alignX = "center";
   	hud.alignY = "top";
   	hud.y = 0;
   	 hud.x =0;
   	hud.foreground = 1;
   	hud.fontscale = 2.5;
   	hud.alpha = 1;
   	hud.color = (1.00, 1.00, 0.99 );
	
	hud SetTimer(time);
	while(time)
	{
		if(level.desactivar == true)
		{
			hud destroy();
			
			return;
		}
		
		wait 1;
		time--;
	}
	hud destroy();
	wait 0.2;
	foreach( player in GetPlayers() )
	{
		player Kill();
	}
	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
    thread playsoundok(level.sonido_explosion_nuke);
	level notify( "end_game" );
}
