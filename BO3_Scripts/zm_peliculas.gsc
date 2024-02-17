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

#using scripts\zm\_zm_perk_electric_cherry;
#using scripts\zm\_zm_perk_widows_wine; 

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

//AÑADIDOS
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_weap_thundergun;
#using scripts\zm\_zm_weap_riotshield;
#using scripts\shared\ai\zombie_death;
#using scripts\zm\ugxmods_timedgp;
#using scripts\shared\hud_util_shared;

#using scripts\zm\_zm_perks;
#insert scripts\zm\_zm_perks.gsh;

#using scripts\zm\_zm_spawner;
#using scripts\shared\spawner_shared;


	// NSZ Jumpscare
	#using scripts\_NSZ\nsz_jumpscare;
	//PARASITOS
	#using scripts\zm\_zm_ai_wasp;
	// SONIC ZOMBIE
	#using scripts\zm\_zm_ai_sonic;
	#using scripts\zm\_hb21_zm_behavior;
	//almas
	#using scripts\zm\growing_soulbox;
	//karosel
	#using scripts\zm\weapon_karosel;
	//TELEPORT
	#using scripts\shared\lui_shared;



//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{
	//PARASITOS
	level.dog_rounds_allowed = false;
	zm_ai_wasp::init();

	zm_usermap::main();
	callback::on_ai_spawned(&check_death);
	
	level._zombie_custom_add_weapons =&custom_add_weapons;
	//level.start_weapon = getWeapon("ar_standard_upgraded");
	
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	level.dog_rounds_allowed = false; // BE AWARE - disables dog rounds
	level.perk_purchase_limit = 20;
	level.player_starting_points = 1000;

	level.pathdist_type = PATHDIST_ORIGINAL;
	//sprinters
	level.zombie_init_done = &mpjw_make_sprinter;
	//GROW_SOUL
	grow_soul::init(  );
	//karosel
	weap_kar::init(  );

	level thread sistema_menos_puntos();

	
	thread gameplay_8doors();
	thread zonamedia();
	thread credit();
	thread startzone_lights();

	thread perkmachine("trig_qr1","PERK_QUICK_REVIVE",2000,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr2","PERK_QUICK_REVIVE",2000,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr3","PERK_QUICK_REVIVE",2000,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr4","PERK_QUICK_REVIVE",2000,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr5","PERK_QUICK_REVIVE",2000,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr6","PERK_QUICK_REVIVE",2000,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr7","PERK_QUICK_REVIVE",2000,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_qr8","PERK_QUICK_REVIVE",2000,"Quick Revive","specialty_quickrevive");
	thread perkmachine("trig_electriccherry1","PERK_ELECTRIC_CHERRY",2000,"Electric Cherry","specialty_electriccherry");
	thread perkmachine("trig_electriccherry2","PERK_ELECTRIC_CHERRY",2000,"Electric Cherry","specialty_electriccherry");
	thread maxammo("spawn_maxammo_1","max_ammo1");
	thread maxammo("spawn_maxammo_2","max_ammo2");
	thread maxammo("spawn_maxammo_3","max_ammo3");
	thread maxammo("spawn_maxammo_4","max_ammo4");
	thread maxammo("spawn_maxammo_5","max_ammo5");
	thread maxammo("spawn_maxammo_6","max_ammo6");


}

function usermap_test_zone_init()
{
	level flag::init( "always_on" );
	level flag::set( "always_on" );
	flag::init( "power_on" ); 
    flag::set("power_on");

    zm_zonemgr::add_adjacent_zone("start_zone","zonamedia","zonamediaflag");

    zm_zonemgr::add_adjacent_zone("zona300","zonamedia","300flag");
    zm_zonemgr::add_adjacent_zone("zonapa","zonamedia","paflag");
    zm_zonemgr::add_adjacent_zone("zonare","zonamedia","reflag");
    zm_zonemgr::add_adjacent_zone("zonaib","zonamedia","ibflag");
    zm_zonemgr::add_adjacent_zone("zonama","zonamedia","maflag");
    zm_zonemgr::add_adjacent_zone("zonapf","zonamedia","pfflag");
    zm_zonemgr::add_adjacent_zone("zonara","zonamedia","raflag");
    zm_zonemgr::add_adjacent_zone("zonarb","zonamedia","rbflag");

}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

function mpjw_make_sprinter()
{
    if ( isDefined( level.ptr_zombie_init_done ) )
        self [ [ level.ptr_zombie_init_done ] ]();
    
    self zombie_utility::set_zombie_run_cycle( "sprint" ); //"walk" "run" "sprint"
}
function zonamedia()
{
    trigg = getEnt("trigger_zonamedia", "targetname");
    trigg waittill("trigger", action); 
    action IPrintLnBold("zonamedia activada");
         flag::init( "zonamediaflag" );
            flag::set("zonamediaflag");
}
  function credit()
{
	level flag::wait_till("initial_blackscreen_passed");
	iprintlnbold("This map was created by DonAndres_666, Enjoy!"); 
	  wait(3);
	iprintlnbold("You can adjust the volume of music on the options menu, sound, music volume. No Copyright Music.");
}
function startzone_lights()
{
    trigg = getEnt("start_zone_trigger_multiple", "targetname");
    thread musica_fondo(trigg);
   while(1)
   {
    trigg waittill("trigger",player);
    wait(10);
   }
}
function musica_fondo(trigg)
{
	level flag::wait_till("initial_blackscreen_passed");
	while(1)
	{
		PlaySoundAtPosition("fondo",trigg.origin);
		wait(185);
	}
}
function stop_spawn()
{
	self endon ("start_spawning_zombies");
	while(1)
	{
		WAIT_SERVER_FRAME;
		zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
    	//Stop Spawning
    	level flag::clear( "spawn_zombies" );
	}
	
}
function start_spawn()
{
	level notify ("start_spawning_zombies");
	wait(0.5);
	//Start zombies spawn
		level flag::set( "spawn_zombies" );
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
}
function maxammo(spawn_name,trigger_name)
{
	trig = getEnt(trigger_name, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to MAX AMMO. Cost: 2000 pts" ); 
	trig SetCursorHint("HINT_NOICON");
	max_ammo_spawn = struct::get(spawn_name, "targetname");
	while(1)
	{
		trig waittill("trigger", player);
		if(player.score >= 2000)
        {
            player.score -= 2000;
			max_ammo_spawn thread zm_powerups::specific_powerup_drop("full_ammo", max_ammo_spawn.origin);
		}
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

function sistema_menos_puntos()
{
    spawner::add_archetype_spawn_function( "zombie", &disable_t9_zombie_death_points );
    zombie_utility::set_zombie_var( "zombie_score_kill_4player", 60 ); // Individual Points for a zombie kill in a 4 player game
    zombie_utility::set_zombie_var( "zombie_score_kill_3player", 60 ); // Individual Points for a zombie kill in a 3 player game
    zombie_utility::set_zombie_var( "zombie_score_kill_2player", 60 ); // Individual Points for a zombie kill in a 2 player game
    zombie_utility::set_zombie_var( "zombie_score_kill_1player", 60 ); // Individual Points for a zombie kill in a 1 player game
    zombie_utility::set_zombie_var( "zombie_score_bonus_melee", 20 ); // Bonus points for a melee kill
    zombie_utility::set_zombie_var( "zombie_score_bonus_head", 15 ); // Bonus points for a head shot kill
    zombie_utility::set_zombie_var( "zombie_score_bonus_neck", 0 ); // Bonus points for a neck shot kill
    zombie_utility::set_zombie_var( "zombie_score_bonus_torso", 0 ); // Bonus points for a torso shot kill
    zombie_utility::set_zombie_var( "zombie_score_bonus_burn",  0 ); // Bonus 
}
function disable_t9_zombie_death_points()
{
    self.no_damage_points = 1;
}
////////////////////////////////////////////////////
//	EL PADRINO 		EL PADRINO 		EL PADRINO   //
///////////////////////////////////////////////////
function elpadrino()
{
	level flag::wait_till("initial_blackscreen_passed");
	gemelas = getEnt("gemelas", "targetname");
    gemelas SetInvisibleToAll();
	trig_ayuda = getEnt("padrino_ayuda", "targetname");
	trig_ayuda SetHintString( "Press and Hold ^3&&1^7 to request the help of the godfather ^3(500pts)" ); 
	trig_ayuda SetCursorHint("HINT_NOICON");
	trig_ayuda SetInvisibleToAll();
	for( i = 1; i < 7; i++ )
	{
		level.cuadro[i] = getEnt("cuadro_"+i, "targetname");
		trig[i] = getEnt("tcuadro_"+i, "targetname");
		trig[i] SetHintString( "Press and Hold ^3&&1^7 to place/remove the picture." ); 
		trig[i] SetCursorHint("HINT_NOICON");
		trig[i] SetInvisibleToAll();
		level.cuadro_origin[i] = level.cuadro[i].origin;
		level.cuadro_angles[i] = level.cuadro[i].angles;
	}
	level.cuadro[6] SetInvisibleToAll();

	thread stop_spawn();
	thread playsoundok("pa_1");
	wait(10);
	thread start_spawn();


	level.cuadro_en_mano = 6; ///vacio
	wait(120);
	thread stop_spawn();

	wait(1);//TIEMPO HASTA QUE EMPIEZA EL PUZZLE
	thread elpadrino_ayuda(trig_ayuda);
	for( i = 1; i < 7; i++ )
	{
		level.cuadro_en_posicion[i] = i;
		thread triggers_cuadros(i);
	}

	solucion = array(0,3,1,5,2,4,6);
	while(1)
	{
		wait(0.5);
		correcto = true;
		for( i = 1; i < 7; i++ )
		{
			if (solucion[i] != level.cuadro_en_posicion[i])
			{
				correcto = false;
			}
		}
		if (correcto == true)
		{
			IPrintLnBold("Completed!");
			level notify ("challenge_completed");
			level notify("pa_completed");
			thread start_spawn();
			break;
		}
	}
	for( i = 1; i < 7; i++ )
	{
		trig [i] Delete();
	}
}

function triggers_cuadros(i)
{
	trig = getEnt("tcuadro_"+i, "targetname");
	trig SetVisibleToAll();
	while(1)
	{
			trig waittill( "trigger", player );
		if (level.cuadro_en_posicion[i] == 6)//vacio
		{
			if (level.cuadro_en_mano == 6) 
			{
				IPrintLnBold("You haven't any pictures to place here");
			}
			else 
			{
				level.cuadro[level.cuadro_en_mano] MoveTo(level.cuadro_origin[i],0.05);
				level.cuadro[level.cuadro_en_mano] RotateTo(level.cuadro_angles[i],0.05);
				wait(0.2);
				level.cuadro[level.cuadro_en_mano] SetVisibleToAll();
				level.cuadro_en_posicion[i] = level.cuadro_en_mano; //decimos que ahora el cuadro que teniamos en mano esta colocado en la posicion i
				level.cuadro_en_mano = 6; //decimos que ahora no tenemos ningun cuadro en la mano
			}
		}
		else //si si que hay un cuadro
		{
			if (level.cuadro_en_mano == 6) 
			{
				level.cuadro_en_mano = level.cuadro_en_posicion[i]; //decimoos que ahora tenemos en mano el cuadro que estaba en la posicion i
				level.cuadro[level.cuadro_en_mano] SetInvisibleToAll(); //invisibilizamos ese cuadro
				level.cuadro_en_posicion[i] = 6; //decimos que ahora en esa posicion no hay ningun cuadro
			}
			else 
			{
				IPrintLnBold("You must place a picture first before taking the next one");
			}
		}
	}

}
function elpadrino_ayuda(trig)
{
	trig SetVisibleToAll();
	while(1)
	{
		trig waittill( "trigger", player );
		if(player.score >= 500 )
		{
			thread playsoundok("pa_2");
			player zm_score::minus_to_player_score(500);
			wait(15);
			trig SetHintString( "1.-Wedding 2.-Horse 3.-Street 4.-Car 5.-Women" ); 
			break;
		}
	}
}



//////////////////////////////////////////////////////////////
//	EL RESPLANDOR 		EL RESPLANDOR 		EL RESPLANDOR   //
/////////////////////////////////////////////////////////////

function elresplandor()
{
	level flag::wait_till("initial_blackscreen_passed");
	gemelas = getEnt("gemelas", "targetname");
	gemelas SetInvisibleToAll();
	gemelas MoveZ(-150,0.2);
	for( i = 1; i < 7; i++ )
	{
		thread resplandor_trig_puertas(i);
	}

	level.resplandor_correctas = 0;

	while(1)
	{
		wait(45);//tiempo hasta que se apagan las luces
		thread playsoundok("re_1");
		wait(3);
		for( i = 1; i < 8; i++ )
		{
			thread parpadear_luz(1,0.2);
			wait(0.2);
			thread parpadear_luz(2,0.2);
			wait(0.3);
			thread parpadear_luz(3,0.2);
			wait(0.2);
		}
		wait(0.3);
		exploder::exploder("abajo1");//va al reves stop seria encender
		exploder::exploder("abajo2");
		exploder::exploder("abajo3");
		exploder::exploder("arriba1");
		exploder::exploder("arriba2");
		exploder::exploder("arriba3");
		exploder::exploder("otras_luces");
		thread playsoundok("re_2");
		wait(17); //TIEMPO CON LUCES APAGADAS
		thread stop_spawn();
		thread resplandor_juego();
		thread susto_resplandor();
		level waittill("fin_resplandor_juego");
		thread start_spawn();
		exploder::exploder_stop("abajo1");//encender luces
		exploder::exploder_stop("abajo2");
		exploder::exploder_stop("abajo3");
		exploder::exploder_stop("arriba1");
		exploder::exploder_stop("arriba2");
		exploder::exploder_stop("arriba3");
		exploder::exploder_stop("otras_luces");
		if (level.resplandor_correctas == 3)
		{
			IPrintLnBold("Challenge Completed!");
			level notify("challenge_completed");
			level notify("re_completed");
			thread start_spawn();
			break;
		}
	}
	
	
}
function parpadear_luz(i,time)
{
	exploder::exploder("abajo"+i);
	exploder::exploder("arriba"+i);
	wait(time);
	exploder::exploder_stop("abajo"+i);
	exploder::exploder_stop("arriba"+i);

}
function resplandor_trig_puertas(i)
{
	trig = getEnt("res_"+i, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to knock at the door" ); 
	trig SetCursorHint("HINT_NOICON");
	trig SetInvisibleToAll();
	while(1)
	{
		trig waittill( "trigger", player );
		level notify("puerta_seleccionada");
		level.puerta_seleccionada=i;

	}
}
function resplandor_juego()
{
	level notify ("empieza_resplandor_juego");
	for( i = 1; i < 7; i++ )
	{
		trig = getEnt("res_"+i, "targetname");
		trig SetVisibleToAll();
	}
	solucion = RandomIntRange(1,7);
	thread iluminar_solucion(solucion);
	level waittill("puerta_seleccionada");
	for( i = 1; i < 7; i++ )
	{
		trig = getEnt("res_"+i, "targetname");
		trig SetInvisibleToAll();
	}
	WAIT_SERVER_FRAME;
	if(level.puerta_seleccionada == solucion)
	{
		IPrintLnBold("Nice Choice!");
		level.resplandor_correctas ++;
		level notify ("acierto_resplandor");
		gemelas = getEnt("gemelas", "targetname");
		gemelas SetInvisibleToAll();
	}
	else
	{
		foreach(player in GetPlayers())
		{
			player thread do_jumpscare();
		}
	}
	level notify("fin_resplandor_juego");
}
function iluminar_solucion(solucion)
{
	if (solucion ==1)
	{
		exploder::exploder_stop("abajo1");
		exploder::exploder_stop("arriba1");
	}
	if (solucion ==2)
	{
		exploder::exploder_stop("abajo2");
		exploder::exploder_stop("arriba2");
	}
	if (solucion ==3)
	{
		exploder::exploder_stop("abajo1");
		exploder::exploder_stop("arriba1");
		exploder::exploder_stop("abajo2");
		exploder::exploder_stop("arriba2");
	}
	if (solucion ==4)
	{
		exploder::exploder_stop("abajo3");
		exploder::exploder_stop("arriba3");
	}
	if (solucion ==5)
	{
		exploder::exploder_stop("abajo1");
		exploder::exploder_stop("arriba1");
		exploder::exploder_stop("abajo3");
		exploder::exploder_stop("arriba3");
	}
	if (solucion ==6)
	{
		exploder::exploder_stop("abajo3");
		exploder::exploder_stop("arriba3");
		exploder::exploder_stop("abajo2");
		exploder::exploder_stop("arriba2");
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
function susto_resplandor()
{
    level flag::wait_till("initial_blackscreen_passed");
    gemelas = getEnt("gemelas", "targetname");
    gemelas SetInvisibleToAll();
    level.susto_resplandor = false;
    foreach(player in GetPlayers())
        {
            player thread check_susto_resplandor();
        }
}
function check_susto_resplandor()
{
    trig_cuadro = getEnt("pista_resplandor", "targetname");
    zona_cuadro = getEnt("zona_cuadro", "targetname");

    while(1)
    {
        WAIT_SERVER_FRAME;
        if (self IsTouching(zona_cuadro))
        {
                if(self zm_utility::is_player_looking_at(trig_cuadro.origin, 0.85, true, self))
                {
                   
                     if (level.susto_resplandor == false)
                        {
                           gemelas = getEnt("gemelas", "targetname");
                            gemelas SetVisibleToAll();
                            level.susto_resplandor = true;
                            while(1)
                            {
                                WAIT_SERVER_FRAME;
                               if(self zm_utility::is_player_looking_at(gemelas.origin, 0.85, true, self))
                               {
                                     thread playsoundok("re_3");
                                    wait(3);
                                     gemelas SetInvisibleToAll();
                                     break;
                              }
                        
                            }
                            break;
                        }   
                }
            
                
            
            
        }
    }


}
 
 ///////////////////////////////////////////////////////////////////////
//	300 		300 		300   //
////////////////////////////////////////////////////////////////////////
function trescientos()
{
	level flag::wait_till("initial_blackscreen_passed");
	thread stop_spawn();
	montanas = GetEntArray("montanas", "targetname");
	foreach(montana in montanas)
	{montana SetVisibleToAll();}
	modelo1 = getEnt("almas300_1", "targetname");
	modelo1 SetVisibleToAll();
	modelo2 = getEnt("almas300_2", "targetname");
	modelo2 SetVisibleToAll();
	thread teleport_pozo_trescientos();
	level.grow_soul_start_scale = 0.3;//starting scale of model
	level.grow_soul_growth = 0.01;//growth per zombie
	level.grow_soul_size = 0.6;//how big you want it to get scale wise
	thread cargar_almas("almas300_1");
	thread cargar_almas("almas300_2");
	level.almas["almas300_1"]=false;
	level.almas["almas300_2"]=false;
	thread playsoundok("300_1");
	wait(7);
	thread start_spawn();
	while(1)
	{
		wait(1);
		if(level.almas["almas300_1"]==true)
		{
			modelo1 Delete();
		}
		if(level.almas["almas300_2"]==true)
		{
			modelo2 Delete();
		}
		if ((level.almas["almas300_1"]==true)&&(level.almas["almas300_2"]==true))
		{
			IPrintLnBold("Spartan kick unlocked.^3(Jump + Knife)");
			IPrintLnBold("Kill zombies with Spartan Kick to complete the challenge");
			thread playsoundok("300_2");
			break;
		}
	}
	level.bajas_espartanas = 0;

	foreach(player in GetPlayers())
		{
			player thread patada_trescientos();
		}
		a=0;
	while(1)
	{
		wait(10);
		IPrintLnBold("Spartan kick unlocked.^3(Jump + Knife)");
		IPrintLnBold("Kill zombies with Spartan Kick to complete the challenge");
		a ++;
		if (level.bajas_espartanas >= 30)
		{
			break;
		}
		if (a == 6)
		{
			break;
		}
	}
	IPrintLnBold("Challenge Completed!");
			level notify("challenge_completed");
			level notify("300_completed");

}
function patada_trescientos()
{
	while(1)
	{
		self waittill( "weapon_melee", weapon );
		if( self IsOnGround() ) 
		{
			//
		}
		else
		{
			self [[level.riotshield_melee]]( weapon );
        	self thread riotshield::riotshield_melee();
        	level notify ("patada_trescientos");
		}
	}
}

function check_death(mod, hit_location, hit_origin, player, amount, weapon, direction_vec, tagName, modelName, partName, dFlags, inflictor, chargeLevel)
{ 

    self waittill("death", player);
    weapon = self.damageweapon;
        if(weapon == GetWeapon("knife") )
        {
         level.bajas_espartanas ++;
         }

    

}

function teleport_pozo_trescientos()
{
	trig = getEnt("pozo_300", "targetname");
	while(1)
	  	{
	 
	  		 trig waittill("trigger", player);
	  		 	wait(0.5);
	  		 	
	  		 	player thread teleport_player_to(4,"teleport_300");
	  	      
       	}
}
 ///////////////////////////////////////////////////////////////////////
//	RATATUILLE 		RATATUILLE 		RATATUILLE   //
////////////////////////////////////////////////////////////////////////

function ratatuille()
{
	thread teleport_suelo_ratatuille();
	trig_cortar_patata = getEnt("cortar_patatas", "targetname");
	trig_cortar_patata SetCursorHint("HINT_NOICON");

	trig_freir = getEnt("freir", "targetname");
	trig_freir SetCursorHint("HINT_NOICON");
	trig_freir SetHintString( "Press and Hold ^3&&1^7 to fry the potatoes" );
	trig_freir SetInvisibleToAll();

	patata_sarten = GetEntArray("chips", "targetname");
	foreach(chip in patata_sarten)
	{chip SetInvisibleToAll();}

	trig_plato = getEnt("plato", "targetname");
	trig_plato SetCursorHint("HINT_NOICON");
	trig_plato SetHintString( "Press and Hold ^3&&1^7 to place chips" );
	trig_plato SetInvisibleToAll();

	patatas_plato = GetEntArray("chips_f", "targetname");
	foreach(patata_plato in patatas_plato)
	{patata_plato SetInvisibleToAll();}

	ketchup = getEnt("ketchup", "targetname");
	ketchup_clip = getEnt("ketchup_clip", "targetname");
	trig_ketchup = getEnt("trig_ketchup", "targetname");
	trig_ketchup SetCursorHint("HINT_NOICON");
	trig_ketchup SetHintString( "Press and Hold ^3&&1^7 to take ketchup" );
	trig_ketchup SetInvisibleToAll();

	ketchups_plato = GetEntArray("chips_ketch", "targetname");
	foreach(ketchup_plato in ketchups_plato)
	{ketchup_plato SetInvisibleToAll();}

	sal = getEnt("sal", "targetname");
	trig_sal = getEnt("trig_sal", "targetname");
	trig_sal SetCursorHint("HINT_NOICON");
	trig_sal SetHintString( "Press and Hold ^3&&1^7 to take salt" );
	trig_sal SetInvisibleToAll();


	trig_nota = getEnt("nota_cocina", "targetname");
	trig_nota SetCursorHint("HINT_NOICON");
	trig_nota SetHintString( "^3PLATE OF FRIES: ^7 Cut potatoes with the knife several times" );
	thread stop_spawn();
	wait(1);
	thread playsoundok("ra_1");
	wait(20);
	thread start_spawn();
	cortes = 0;
	while(1)
	{
		WAIT_SERVER_FRAME;
		trig_cortar_patata waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		if (mod == "MOD_MELEE")
		{
			PlaySoundAtPosition("hitmarker",trig_cortar_patata.origin);
			cortes ++;
			IPrintLnBold(cortes + "/10");
			if (cortes == 10)
			{
				break;
			}
		}
	}
	patatas = GetEntArray("patatas", "targetname");
	foreach(patata in patatas)
	{patata SetInvisibleToAll();}

	trig_nota SetHintString( "^3PLATE OF FRIES: ^7 Fry chips in the pan and place them on the plate" );
	trig_freir SetVisibleToAll();
	trig_freir waittill( "trigger", player );
	foreach(chip in patata_sarten)
	{chip SetVisibleToAll();}
	trig_freir SetHintString( "Chips are cooking" );
	foreach(chip in patata_sarten)
	{chip SetVisibleToAll();}
	PlaySoundAtPosition("freidora",trig_freir.origin);
	wait(100);
	trig_freir SetHintString( "Press and Hold ^3&&1^7 to take chips" );
	trig_freir waittill( "trigger", player );
	trig_freir SetInvisibleToAll();
	foreach(chip in patata_sarten)
	{chip SetInvisibleToAll();}

	trig_plato SetVisibleToAll();
	trig_plato waittill( "trigger", player );
	trig_plato SetInvisibleToAll();
	foreach(patata_plato in patatas_plato)
	{patata_plato SetVisibleToAll();}

	trig_nota SetHintString( "^3PLATE OF FRIES: ^7 Pour ketchup on the chips" );
	trig_ketchup SetVisibleToAll();
	trig_ketchup waittill( "trigger", player );
	trig_ketchup SetInvisibleToAll();
	ketchup SetInvisibleToAll();
	ketchup_clip SetInvisibleToAll();

	trig_plato SetVisibleToAll();
	trig_plato SetHintString( "Press and Hold ^3&&1^7 to pour ketchup" );
	trig_plato waittill( "trigger", player );
	trig_plato SetInvisibleToAll();
	foreach(ketchup_plato in ketchups_plato)
	{ketchup_plato SetVisibleToAll();}

	trig_nota SetHintString( "^3PLATE OF FRIES: ^7 Pour salt on the chips" );
	trig_sal SetVisibleToAll();
	trig_sal waittill( "trigger", player );
	trig_sal SetInvisibleToAll();
	sal SetInvisibleToAll();

	trig_plato SetVisibleToAll();
	trig_plato SetHintString( "Press and Hold ^3&&1^7 to pour salt" );
	trig_plato waittill( "trigger", player );
	trig_nota SetHintString( "^3PLATE OF FRIES: ^7 DONE!" );

	IPrintLnBold("Challenge completed!");
	level notify("challenge_completed");
			level notify("ra_completed");

}
function teleport_suelo_ratatuille()
{
	trig = getEnt("caida_ratatuille", "targetname");
	while(1)
	  	{
	 
	  		 trig waittill("trigger", player);
	  		 	wait(0.5);
	  		 	
	  		 	player thread teleport_player_to(4,"teleport_ra");
	  	      
       	}
}

 ///////////////////////////////////////////////////////////////////////
//	MATRIX 		MATRIX 		MATRIX   //
////////////////////////////////////////////////////////////////////////
function matrix()
{
	level flag::wait_till("initial_blackscreen_passed");
	trigmun = getEnt("max_ammo7", "targetname");
	trigmun SetHintString( "" ); 
	trigmun SetCursorHint("HINT_NOICON");
	trig = getEnt("trig_matrix", "targetname");
	trig SetCursorHint("HINT_NOICON");
	trig waittill( "trigger", player );
	foreach(player in GetPlayers())
		{
			player thread matrix_armas();
		}
	thread stop_spawn();
	thread playsoundok("ma_1");
	wait(17);
	thread start_spawn();
	
	IPrintLnBold("Don't fight, just dodge");

	wait(40);/////////////////////////////////////////////tiempo a sobrevivir con zombies 40
	level notify ("matrix_dar_armas");
	IPrintLnBold("Fight!");
    //Stop Spawning
    level flag::clear( "spawn_zombies" );
    while(1)
    {
    	WAIT_SERVER_FRAME;
    	vivos = false;
    	a_zombies = getAITeamArray( level.zombie_team );
	                 foreach(zombie in a_zombies)
						{
							if (IsAlive(zombie))
							{
								vivos = true;
							}
						}
		if (vivos == false)
		{
			break;
		}

    }
    IPrintLnBold("First training completed!");

    wait(1);
    foreach(player in GetPlayers())
		{
			player thread matrix_armas();
		}
    IPrintLnBold("Don't fight, just dodge");
    zm_ai_wasp::special_wasp_spawn();
    wait(0.5);
    zm_ai_wasp::special_wasp_spawn();
    wait(0.5);
    zm_ai_wasp::special_wasp_spawn();
    wait(0.5);
    zm_ai_wasp::special_wasp_spawn();
	
	wait(30);///////////////////////////////tiempo a sobrevivir con parasitos 30
	level notify ("matrix_dar_armas");
	IPrintLnBold("Fight!");
	while(1)
    {
    	WAIT_SERVER_FRAME;
    	vivos = false;
    	a_zombies = getAITeamArray( level.zombie_team );
	                 foreach(zombie in a_zombies)
						{
							if (IsAlive(zombie))
							{
								vivos = true;
							}
						}
		if (vivos == false)
		{
			break;
		}

    }
    IPrintLnBold("Second training completed!");
    wait(1);
    foreach(player in GetPlayers())
		{
			player thread matrix_armas();
		}
    IPrintLnBold("Don't fight, just dodge");
    level notify ("spawnear_sonic");
    wait(2);
    level notify ("spawnear_sonic");
    wait(30);///////////////////////////////tiempo a sobrevivir con sonics 30
	level notify ("matrix_dar_armas");
	IPrintLnBold("Fight!");
	while(1)
    {
    	WAIT_SERVER_FRAME;
    	vivos = false;
    	a_zombies = getAITeamArray( level.zombie_team );
	                 foreach(zombie in a_zombies)
						{
							if (IsAlive(zombie))
							{
								vivos = true;
							}
						}
		if (vivos == false)
		{
			break;
		}

    }
    IPrintLnBold("Third training completed!");

     wait(1);
    foreach(player in GetPlayers())
		{
			player thread matrix_armas();
		}
    IPrintLnBold("Don't fight, just dodge");
    //Start zombies spawn
		level flag::set( "spawn_zombies" );
    level notify ("spawnear_sonic");
    zm_ai_wasp::special_wasp_spawn();
    wait(0.5);
     zm_ai_wasp::special_wasp_spawn();
    wait(30);///////////////////////////////tiempo a sobrevivir con sonics 30
    //Stop Spawning
    level flag::clear( "spawn_zombies" );
	level notify ("matrix_dar_armas");
	IPrintLnBold("Fight!");
	while(1)
    {
    	WAIT_SERVER_FRAME;
    	vivos = false;
    	a_zombies = getAITeamArray( level.zombie_team );
	                 foreach(zombie in a_zombies)
						{
							if (IsAlive(zombie))
							{
								vivos = true;
							}
						}
		if (vivos == false)
		{
			break;
		}

    }
    IPrintLnBold("Training completed!");
    thread start_spawn();
	level notify ("challenge_completed");
			level notify("ma_completed");

	thread maxammo("spawn_maxammo_7","max_ammo7");

}
function matrix_armas()
 {
  
  a_weapon_list = self GetWeaponsList();
  
  // If we still don't have a valid weapon saved off for current weapon, use the first weapon
  // in the player's weapon list
 
  foreach ( weapon in a_weapon_list )
  {
   self TakeWeapon( weapon );
  }
  self GiveWeapon(getweapon("pistol_standard"));
  self SetWeaponAmmoClip (getweapon("pistol_standard"),0);
  self SetWeaponAmmoStock(getweapon("pistol_standard"),0);
	level waittill("matrix_dar_armas");
	self TakeWeapon( getweapon("pistol_standard") );

	foreach ( weapon in a_weapon_list )
  {
   self GiveWeapon( weapon );
  }
  
 }

 //////////////////////////////////////////////////////////////
//	RIO BRAVO 		RIO BRAVO 		RIO BRAVO   //
//////////////////////////////////////////////////////////////

function rio_bravo()
{
	level flag::wait_till("initial_blackscreen_passed");
	montanas = GetEntArray("montanas", "targetname");
	foreach(montana in montanas)
	{montana SetInvisibleToAll();}
	radio = getEnt("rb_radio", "targetname");
	trig = getEnt("riobravozone", "targetname");
	trig waittill( "trigger", player );	
	foreach(player in GetPlayers())
			{
   				player thread riobravo_armas();
   			}
   	thread comprar_guitarrita();
   	PlaySoundAtPosition("riobravo",radio);
   	PlaySoundAtPosition("riobravo",radio.origin);
   	wait(140);
   	trig = getEnt("guitarrita", "targetname");
   	trig Delete();
   	level notify ("challenge_completed");
			level notify("rb_completed");

   	wait(1);
   	level notify ("rio_bravo_completed");

}
function riobravo_armas()
 {
  
  a_weapon_list = self GetWeaponsList();
  
  // If we still don't have a valid weapon saved off for current weapon, use the first weapon
  // in the player's weapon list
 
  foreach ( weapon in a_weapon_list )
  {
   self TakeWeapon( weapon );
  }
	self GiveWeapon(getweapon("bo3_melee_bat"));
	level waittill("rio_bravo_completed");

	self TakeWeapon( getweapon("bo3_melee_bat") );
	foreach ( weapon in a_weapon_list )
  {
   self GiveWeapon( weapon );
  }
  
 }

function comprar_guitarrita()
{
	self endon ("rb_completed");
	trig = getEnt("guitarrita", "targetname");
	trig SetHintString( "Hold ^3[{+activate}]^7 to get GUITARRITA" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill("trigger", player);
			level notify ("end_open");
		
			player TakeWeapon(player GetCurrentWeapon());
			player zm_weapons::weapon_give(getweapon("bo3_melee_bat"));
	}

}
 ///////////////////////////////////////////////////////////////////////
//	INSTINTO BÁSICO 		INSTINTO BÁSICO 		INSTINTO BÁSICO   //
////////////////////////////////////////////////////////////////////////
function instinto_basico()
{
	trig = getEnt("ib_saltar_puzzle", "targetname");
	trig SetInvisibleToAll();
	ib_pantalla_1 = getEnt("ib_pantalla_1" , "targetname");
	ib_pantalla_2 = getEnt("ib_pantalla_2" , "targetname");
	ib_pantalla_3 = getEnt("ib_pantalla_3" , "targetname");
	ib_pantalla_2 SetInvisibleToAll();
	ib_pantalla_1 SetInvisibleToAll();

	ib_inst_0 = getEnt("ib_instruccion_0" , "targetname");
	ib_inst_1 = getEnt("ib_instruccion_1" , "targetname");
	ib_inst_2 = getEnt("ib_instruccion_2" , "targetname");
	ib_inst_3 = getEnt("ib_instruccion_3" , "targetname");
	ib_inst_1 SetInvisibleToAll();
	ib_inst_2 SetInvisibleToAll();
	ib_inst_3 SetInvisibleToAll();
	for( i = 1; i < 41; i++ )
	{
		thread rt_activar_desactivar_linea(i);
	}
	numeros_cuadrados = array(11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44);
	foreach (number in numeros_cuadrados)
	{
		cuadrado = getEnt("panel_" + number , "targetname");
		cuadrado SetInvisibleToAll();
	}
	level flag::wait_till("initial_blackscreen_passed");

	modelo = getEnt("almas", "targetname");
	thread start_spawn();
	wait(1);
	thread esperar_llenar_almas();
	level waittill ("almas" + "_allgrowsouls");
	while(1)
	{
		WAIT_SERVER_FRAME;
		fin = false;
		foreach(player in GetPlayers())
			{
   				if( player.score>= 3000)
   				{
   					fin = true;
   				}
   			}
   		if (fin == true)
   		{
   			modelo SetInvisibleToAll();
   			break;
   		}
	}
	thread stop_spawn();

    	thread ib_trig_saltar_puzzle(1);
    	ib_pantalla_3 SetInvisibleToAll();
    	ib_pantalla_1 SetVisibleToAll();
    	ib_inst_0 SetInvisibleToAll();
    	ib_inst_1 SetVisibleToAll();
///////////////////////////////////////////////////////////primer puzzle (Redistribuir Terreno)
	IPrintLnBold("Shoot the puzzle to show the lines.");
	IPrintLnBold("If it seems difficult to you, you can skip it by paying on the clues screen");
	thread rt_check();
	level waittill ("rt_puzzle_done");
	level notify ("ib_puzzle_completed");
	wait(1);
	trig SetInvisibleToAll();
	ib_inst_1 SetInvisibleToAll();
   	ib_inst_0 SetVisibleToAll();
	thread start_spawn();



	thread esperar_llenar_almas();
	level waittill ("almas" + "_allgrowsouls");
	while(1)
	{
		WAIT_SERVER_FRAME;
		fin = false;
		foreach(player in GetPlayers())
			{
   				if( player.score>= 3000)
   				{
   					fin = true;
   				}
   			}
   		if (fin == true)
   		{
   			modelo SetInvisibleToAll();
   			break;
   		}
	}
	thread stop_spawn();
    	ib_pantalla_1 SetInvisibleToAll();
    	ib_pantalla_2 SetVisibleToAll();
    	ib_inst_0 SetInvisibleToAll();
    	ib_inst_2 SetVisibleToAll();
    	thread ib_trig_saltar_puzzle(2);
//////////////////////////////////////////////////////////////segundo puzzle (lineas segun numeros)
	thread puzzle_lineas();
	level waittill ("puzzle_lineas_done");
	level notify ("ib_puzzle_completed");
	wait(1);
	trig SetInvisibleToAll();
	ib_inst_2 SetInvisibleToAll();
   	ib_inst_0 SetVisibleToAll();
	 thread start_spawn();
	for( i = 1; i < 41; i++ )
	{
		trig = getEnt("trt_" + i , "targetname");
		linea = getEnt("rt_" + i , "targetname");
		trig Delete();
		linea Delete();
	}



	thread esperar_llenar_almas();
	level waittill ("almas" + "_allgrowsouls");
	while(1)
	{
		WAIT_SERVER_FRAME;
		fin = false;
		foreach(player in GetPlayers())
			{
   				if( player.score>= 3000)
   				{
   					fin = true;
   				}
   			}
   		if (fin == true)
   		{
   			modelo SetInvisibleToAll();
   			break;
   		}
	}
	thread stop_spawn();
    	ib_pantalla_2 SetInvisibleToAll();
    	ib_pantalla_3 SetVisibleToAll();
    	ib_inst_0 SetInvisibleToAll();
    	ib_inst_3 SetVisibleToAll();
    	thread ib_trig_saltar_puzzle(3);
//////////////////////////////////////////////////////////////tercer puzzle (completar cuadrados)
	thread puzzle_pantallas();
	level waittill ("puzzle_pantallas_done");
	level notify ("ib_puzzle_completed");
	wait(1);
	trig SetInvisibleToAll();
	 thread start_spawn();
	IPrintLnBold("challenge completed!");
	level notify ("challenge_completed");
			level notify("ib_completed");


}
function rt_activar_desactivar_linea(i)
{
	trig = getEnt("trt_" + i , "targetname");
	linea = getEnt("rt_" + i , "targetname");
	linea SetInvisibleToAll();
	level.rt_linea[i] = false; //false = invisible /// true = visible
	while(1)
	{
		trig waittill( "damage", damage, player, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		linea SetVisibleToAll();
		level.rt_linea[i] = true;
		wait(0.3); //por si se disparan varias balas
		trig waittill( "damage", damage, player, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		linea SetInvisibleToAll();
		level.rt_linea[i] = false;
		wait(0.3);
	}
}
function rt_check()
{
	self endon ("ib_puzzle_completed");
	trues = array(4,8,9,12,13,17,25,26,30,31,35,36);
	falses = array(2,3,7,14,18,19,27,28,29,32,33,34);
	trues2 = array(2,8,9,12,13,19,26,28,30,31,33,35);
	falses2 = array(3,4,7,14,17,18,25,27,29,32,34,36);
	trues3 = array(3,7,8,9,12,13,14,18,26,27,33,36);
	falses3 = array(2,4,17,19,25,28,29,30,31,32,34,35);
	while(1)
	{
		correct= true;
		wait(0.5);
		foreach (number in trues)
		{
			if (level.rt_linea[number] == false)
			{
				correct = false;
			}
		}
		foreach (number in falses)
		{
			if (level.rt_linea[number] == true)
			{
				correct = false;
			}
		}
		if (correct == true)
		{
			IPrintLnBold("Puzzle Completed!");
			level notify ("rt_puzzle_done");
			break;
		}	
		correct= true;		
		foreach (number in trues2)
		{
			if (level.rt_linea[number] == false)
			{
				correct = false;
			}
		}
		foreach (number in falses2)
		{
			if (level.rt_linea[number] == true)
			{
				correct = false;
			}
		}
		if (correct == true)
		{
			IPrintLnBold("Puzzle Completed!");
			level notify ("rt_puzzle_done");
			break;
		}	
		correct= true;		
		foreach (number in trues3)
		{
			if (level.rt_linea[number] == false)
			{
				correct = false;
			}
		}
		foreach (number in falses3)
		{
			if (level.rt_linea[number] == true)
			{
				correct = false;
			}
		}
		if (correct == true)
		{
			IPrintLnBold("Puzzle Completed!");
			level notify ("rt_puzzle_done");
			break;
		}	
	}
}

function puzzle_lineas()
{
	self endon ("ib_puzzle_completed");
	trues = array(1,3,6,7,11,13,14,15,16,20,21,22,26,30,32,35,37,38,39,40);
	falses = array(2,4,5,8,9,10,12,17,18,19,23,24,25,27,28,29,31,33,34,36);
	trues2 = array(1,2,3,5,6,10,13,14,18,20,21,23,24,26,29,30,32,36,39,40);
	falses2 = array(4,7,8,9,11,12,15,16,17,19,22,25,27,28,31,33,34,35,37,38);
	while(1)
	{
		correct= true;
		wait(0.5);
		foreach (number in trues)
		{
			if (level.rt_linea[number] == false)
			{
				correct = false;
			}
		}
		foreach (number in falses)
		{
			if (level.rt_linea[number] == true)
			{
				correct = false;
			}
		}
		if (correct == true)
		{
			IPrintLnBold("Puzzle Completed!");
			level notify ("puzzle_lineas_done");
			break;
		}	
		correct= true;
		foreach (number in trues2)
		{
			if (level.rt_linea[number] == false)
			{
				correct = false;
			}
		}
		foreach (number in falses2)
		{
			if (level.rt_linea[number] == true)
			{
				correct = false;
			}
		}
		if (correct == true)
		{
			IPrintLnBold("Puzzle Completed!");
			level notify ("puzzle_lineas_done");
			break;
		}				
	}
}

function puzzle_pantallas()
{
	self endon ("ib_puzzle_completed");
	numeros_cuadrados = array("11","12","13","14","21","22","23","24","31","32","33","34","41","42","43","44");
	foreach (number in numeros_cuadrados)
	{
		level.pzl_pantallas[number]=false;
		thread sistema_pantallas(number);
	}
	while(1)
	{
		wait(0.5);
		correct = true;
		foreach (number in numeros_cuadrados)
			{
				if (level.pzl_pantallas[number]==false)
				{
					correct = false;
				}
			}
			if (correct==true)
				{
					IPrintLnBold("Puzzle Completed!");
					level notify ("puzzle_pantallas_done");
					break;
				}

	}
}
function sistema_pantallas(number)
{
	fila = number[0];
	columna = number[1];
	numeros_afectados = array(fila+columna,fila+"1",fila+"2",fila+"3",fila+"4","1"+columna,"2"+columna,"3"+columna,"4"+columna);
	trig = getEnt("tpanel_" + number , "targetname");
	while(1)
	{
		trig waittill( "damage", damage, player, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		foreach (afectado in numeros_afectados)
		{
			if ( level.pzl_pantallas[afectado]==false)
				{
					cuadrado = getEnt("panel_" + afectado , "targetname");
					cuadrado SetVisibleToAll();
					level.pzl_pantallas[afectado]=true;
				}
			else
				{
					cuadrado = getEnt("panel_" + afectado , "targetname");
					cuadrado SetInvisibleToAll();
					level.pzl_pantallas[afectado]=false;
				}
		}
	}
}
function esperar_llenar_almas()
{
	modelo = getEnt("almas", "targetname");
	modelo SetVisibleToAll();
	level.grow_soul_start_scale = 0.3;//starting scale of model
	level.grow_soul_growth = 0.01;//growth per zombie
	level.grow_soul_size = 0.5;//how big you want it to get scale wise
	thread cargar_almas("almas");
	level waittill ("almas" + "_allgrowsouls");

}
function cargar_almas(system)
{
		grow_soul::SetUpReward(system);  //esto es para activar las almas del pulsador 1
		grow_soul::WatchZombies();
}
function ib_trig_saltar_puzzle(i)
{
	self endon ("rt_puzzle_done");
	self endon ("puzzle_lineas_done");
	self endon ("puzzle_pantallas_done");

	trig = getEnt("ib_saltar_puzzle", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to skip puzzle ^3(2000pts)" ); 
	trig SetCursorHint("HINT_NOICON");
	trig SetVisibleToAll();
	while(1)
	{
		trig waittill( "trigger", player );	
		if(player.score >= 2000)
		{
			player zm_score::minus_to_player_score(2000);
			if(i==1)
			{level notify ("rt_puzzle_done");}
			if(i==2)
			{level notify ("puzzle_lineas_done");}
			if(i==3)
			{level notify ("puzzle_pantallas_done");}
		}
	}

}
//////////////////////////////////////////////////////////////
//	PULP FICTION 		PULP FICTION 		PULP FICTION   //
//////////////////////////////////////////////////////////////
function pulp_fiction()
{
	level flag::wait_till("initial_blackscreen_passed");
	thread persona_bailando();
	thread zombie_bailando();
	wait(1);
	radios = getEnt("radios_ynct", "targetname");
   	
	trig = getEnt("zona_baile", "targetname");
	PlaySoundAtPosition("younevercantell",trig.origin);
	trig waittill( "trigger", player );	

	foreach(player in GetPlayers())
			{
   				player.HealthBar = player hud::createBar((0,0.6,0),100,10);
   			}
	tiempo_bailado=0;
	while(1)
	{
		wait(1);
		if ((level.persona_bailando == true)&&(level.zombie_bailando == true))
		{
			tiempo_bailado ++;
			fraccion = tiempo_bailado/120;
			foreach(player in GetPlayers())
			{
   				player.HealthBar hud::updateBar(fraccion);
   			}
			if (fraccion == 1)
			{
				foreach(player in GetPlayers())
			{
   				player.HealthBar hud::destroyElem();
   			}
				break;
			}
		}
	}
	level notify ("challenge_completed");
			level notify("pf_completed");
	IPrintLnBold("CHALLENGE COMPLETED!");
}

function persona_bailando()
{
	trig = getEnt("zona_baile", "targetname");
	while(1)
	{
		WAIT_SERVER_FRAME;
		bailando = 0;
		foreach(player in GetPlayers())
			{				
   				if (player IsTouching(trig))
   				 {
   				 	bailando ++;
   				 }
			}
		if (bailando == 0)
		{
			level.persona_bailando = false;
		}
		else 
		{
			level.persona_bailando = true;
		}
	}
	
}
function zombie_bailando()
{
	trig = getEnt("zona_baile", "targetname");
	while(1)
	{
		WAIT_SERVER_FRAME;
		bailando = 0;
		a_zombies = getAITeamArray( level.zombie_team );
                 foreach(ai in a_zombies)
                   {
                   	if (ai IsTouching(trig))
                   	{
                   		if (IsAlive(ai))
                   		{
                   			bailando ++;
                   		}
                   	}
           	       }
		if (bailando == 0)
		{
			level.zombie_bailando = false;
		}
		else 
		{
			level.zombie_bailando = true;
		}
	}
	
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// 8 DOORS CHALLENGE GAMEPLAY   ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function gameplay_8doors()
{
	level.number_of_challenges_completed = 0;
	thread recompensas();
	thread teleport_to_challenges();

	level waittill ("challenge_completed");
	thread teleport_players_start_room("teleport_inf");
	wait(0.5);
	level waittill ("challenge_completed");
	thread teleport_players_start_room("teleport_inf");
	wait(0.5);
	level waittill ("challenge_completed");
	thread teleport_players_start_room("teleport_inf");
	wait(0.5);
	level waittill ("challenge_completed");
	thread teleport_players_start_room("teleport_inf");
	wait(0.5);
	level waittill ("challenge_completed");
	thread teleport_players_start_room("teleport_sup");
	wait(0.5);
	IPrintLnBold("PAP Unlock!");
	level waittill ("challenge_completed");
	thread teleport_players_start_room("teleport_sup");
	wait(0.5);
	level waittill ("challenge_completed");
	thread teleport_players_start_room("teleport_sup");
	wait(0.5);
	level waittill ("challenge_completed");
	thread teleport_players_start_room("teleport_sup");
	level.custom_game_over_hud_elem = &function_f7b7d070;
	wait(0.5);
	level notify ("end_game");

}

function recompensas()
{
	thread recompensa("300");
	thread recompensa("pa");
	thread recompensa("re");
	thread recompensa("ib");
	thread recompensa("ma");
	thread recompensa("pf");
	thread recompensa("ra");
	thread recompensa("rb");
}
function recompensa(peli)
{
	level waittill (peli + "_completed");
	clip_inf = getEnt( "clip_inf_" + peli, "targetname");
	clip_sup = getEnt( "clip_sup_" + peli, "targetname");
	door_inf = getEnt( "door_inf_" + peli, "targetname");
	door_sup = getEnt( "door_sup_" + peli, "targetname");
	trigs = getEnt( "trig_sup_" + peli, "targetname");
	trigi = getEnt( "trig_inf_" + peli, "targetname");
	trigs Delete();
	trigi Delete();
	clip_inf Delete();
	clip_sup Delete();
	door_inf Delete();
	door_sup Delete();
}
function teleport_to_challenges()
{
	//hay dos zonas iniciales una sin pap (inf) y otra con pap (sup) a la que se va tras 5 desafios conseguidos
	thread teleport_players_to("trig_inf_300","300");
	thread teleport_players_to("trig_inf_pa","pa");
	thread teleport_players_to("trig_inf_re","re");
	thread teleport_players_to("trig_inf_ib","ib");
	thread teleport_players_to("trig_inf_ma","ma");
	thread teleport_players_to("trig_inf_pf","pf");
	thread teleport_players_to("trig_inf_ra","ra");
	thread teleport_players_to("trig_inf_rb","rb");

	thread teleport_players_to("trig_sup_300","300");
	thread teleport_players_to("trig_sup_pa","pa");
	thread teleport_players_to("trig_sup_re","re");
	thread teleport_players_to("trig_sup_ib","ib");
	thread teleport_players_to("trig_sup_ma","ma");
	thread teleport_players_to("trig_sup_pf","pf");
	thread teleport_players_to("trig_sup_ra","ra");
	thread teleport_players_to("trig_sup_rb","rb");
}
function teleport_players_to(teleport,peli)
{
	trig = getEnt( teleport , "targetname");
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
                        players[j] thread teleport_player_to(j,"teleport_"+peli);          			
                  }
                  thread activar_juego(peli);
              break;
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
    self thread lui::screen_flash( 0.1, 0.3, .2, 1.0, (0,0,0) );
    wait(.2);
    	lugar = destinos + i ;
        destinations[i] = struct::get(lugar, "targetname" ); 
	

        self setorigin( destinations[i].origin );
        self setplayerangles( destinations[i].angles );
        self FreezeControls(true);
        wait(1);
        self FreezeControls( false );
}
function teleport_players_start_room(teleport)
{
	wait(2);
	while(1)
	{
		WAIT_SERVER_FRAME;
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
                        players[j] thread teleport_player_to(j,teleport); 

                      }  
                    zombies = zombie_utility::get_round_enemy_array();
        			if ( isdefined( zombies ) )
       			 {
       			     array::run_all( zombies, &Kill );
      			  }

              break;
       }

    }
}
function activar_juego(i)
{
	//300
	if (i == "300")
	{
	thread trescientos();
	flag::init( "300flag" );
    flag::set( "300flag" );  
	}

	//padrino
	if (i == "pa")
	{
	thread elpadrino();
	flag::init( "paflag" );
    flag::set( "paflag" );
	}
	//resplandor
	if (i == "re")
	{
	thread elresplandor();
	flag::init( "reflag" );
    flag::set( "reflag" );
	}

	//instinto basico
	if (i == "ib")
	{
	thread instinto_basico();
	flag::init( "ibflag" );
    flag::set( "ibflag" );
	}

	//matrix
	if (i == "ma")
	{
	thread matrix();
	flag::init( "maflag" );
    flag::set( "maflag" );
	}

	//pulp fiction
	if (i == "pf")
	{
	thread pulp_fiction();
	flag::init( "pfflag" );
    flag::set( "pfflag" );
	}

	//ratatuille
	if (i == "ra")
	{
	thread ratatuille();
	flag::init( "raflag" );
    flag::set( "raflag" );
	}

	//rio bravo
	if (i == "rb")
	{
	thread rio_bravo();
	flag::init( "rbflag" );
    flag::set( "rbflag" );
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