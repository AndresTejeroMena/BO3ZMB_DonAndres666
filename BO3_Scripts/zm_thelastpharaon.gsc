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
#using scripts\zm\_zm_powerup_weapon_minigun;

#using scripts\zm\_hb21_zm_behavior;
#using scripts\shared\spawner_shared;
#using scripts\zm\_hb21_zm_behavior;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_perks;
#insert scripts\zm\_zm_perks.gsh;

//Traps
#using scripts\zm\_zm_trap_electric;

// DRAGONHEADS
#using scripts\zm\zm_castle_weap_quest;

//BOWS
#using scripts\zm\_zm_weap_elemental_bow;
#using scripts\zm\_zm_weap_elemental_bow_storm;
#using scripts\zm\_zm_weap_elemental_bow_rune_prison;
#using scripts\zm\_zm_weap_elemental_bow_wolf_howl;
#using scripts\zm\_zm_weap_elemental_bow_demongate;

//cinematica
#using scripts\shared\lui_shared;

// SONIC ZOMBIE
#using scripts\zm\_zm_ai_sonic;

//arma escorpion
#using scripts\zm\t8_zm_weap_orion;

//soulbox
#using scripts\zm\growing_soulbox;

//TELEPORT
	#using scripts\shared\lui_shared;

//BOX
#using scripts\zm\_hb21_zm_magicbox;

#using scripts\zm\zm_usermap;

//explosion carrito
#precache( "fx", "explosions/fx_exp_grenade_wood" );

//fuego
#precache( "fx", "dlc3/stalingrad/fx_fire_inferno_tall_1_evb_md_stalingrad" );

#precache( "fx", "zombie/fx_powerup_grab_red_zmb" ); 

//SLOW ZOMBIE PERK
#precache( "material", "slow_zombie_perk" ); 
//hud intro
#precache( "material", "egipto_hudintro1" );

//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{
	level.dog_rounds_allowed = false;
	zm_usermap::main();
	level._effect["powerup_grabbed"] = "zombie/fx_powerup_on_grab_zmb";
	level.perk_purchase_limit = 20;
	level.player_starting_points = 500;
	level.start_weapon = getWeapon("t5_m1911");
	level._zombie_custom_add_weapons =&custom_add_weapons;
	
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	level.pathdist_type = PATHDIST_ORIGINAL;

	//eyes zombies
	spawner::add_archetype_spawn_function( "zombie", &eye_fx );
	//GROW_SOUL
	grow_soul::init(  );

	//TESTING
	flag::init("startflag");
	flag::set("startflag");
	//thread testing(true);//true = hay zombies

	//INTRO
	thread intro();

	//PRINCIPAL
	thread misiones_egipto();
	thread teleport_lava();
	thread modelo_arco();
	thread pistas();

	//PUZZLES
	thread puzzle_circulos_giratorios();
	thread puzzle_carro();
	thread puzzle_balancin();
	thread puzzle_dibujar();
	thread puzzle_cubos();
	thread puzzle_puerta_simbolos_disparables();
	thread puzzle_vista();
	thread sonic_apaga_llamas();

	thread ra_perk();
	thread quickperkmachine("trig_qr1","PERK_QUICK_REVIVE",1500,"Quick Revive","specialty_quickrevive");

	thread perkmachine("trig_electriccherry","PERK_ELECTRIC_CHERRY",2000,"Electric Cherry","specialty_electriccherry","specialty_electriccherry_power_on");
	thread perkmachine("trig_coz","PERK_ADDITIONAL_PRIMARY_WEAPON",4000,"Mule Kick","specialty_additionalprimaryweapon","specialty_additionalprimaryweapon_power_on");
	thread perkmachine("trig_widows","PERK_WIDOWS_WINE",4000,"Widows Wine","specialty_widowswine","specialty_widowswine_power_on");
	thread perkmachine("trig_deadshot","PERK_DEADSHOT",1500,"Deadshot","specialty_deadshot","specialty_deadshot_power_on");

	thread perkmachine("trig_speedcola","PERK_SLEIGHT_OF_HAND",3000,"Speed Cola","specialty_fastreload","specialty_fastreload_power_on");
	thread perkmachine("trig_staminup","PERK_STAMINUP",2000,"Stamin Up","specialty_staminup","specialty_staminup_power_on");
	thread perkmachine("trig_doubletap","PERK_DOUBLETAP2",2000,"Double Tap","specialty_doubletap2","doubletap_on");
	thread perkmachine("trig_jugger","PERK_JUGGERNOG",2500,"Juggernog","specialty_armorvest","specialty_armorvest_power_on");
	level.zombie_init_done = &mpjw_make_sprinter;

	thread sonido_ambiente();
	//thread no_zombies_help();

	
	
}

function usermap_test_zone_init()
{
	level flag::init( "always_on" );
	level flag::set( "always_on" );
	self hb21_zm_behavior::enable_side_step();

	zm_zonemgr::add_adjacent_zone("start_zone","zone1","startflag");
	zm_zonemgr::add_adjacent_zone("zone1","zone1a");

	zm_zonemgr::add_adjacent_zone("zone1","zone2","flag12");
	zm_zonemgr::add_adjacent_zone("zone1","zone3","flag13");

	zm_zonemgr::add_adjacent_zone("zone3","zone3a");
	zm_zonemgr::add_adjacent_zone("zone3b","zone3a");
	zm_zonemgr::add_adjacent_zone("zone3","zone3c");

	zm_zonemgr::add_adjacent_zone("zone3c","zone3d","flag3d");
	zm_zonemgr::add_adjacent_zone("zone3d","zone3e");
	zm_zonemgr::add_adjacent_zone("zone3f","zone3d");
	zm_zonemgr::add_adjacent_zone("zone3f","zone3e");

	zm_zonemgr::add_adjacent_zone("zone1","zone4","flag14");
	zm_zonemgr::add_adjacent_zone("zone4","zone5","flag45");
	zm_zonemgr::add_adjacent_zone("zone5","zone6","flag56");
	zm_zonemgr::add_adjacent_zone("zone4","zone6","flag56");
	zm_zonemgr::add_adjacent_zone("zone6","zone7","flag67");
	zm_zonemgr::add_adjacent_zone("zone8","zone7","flag78");
	zm_zonemgr::add_adjacent_zone("zone8","zone6","flag78");
	zm_zonemgr::add_adjacent_zone("zone8","zone9","flag89");
	zm_zonemgr::add_adjacent_zone("zone8","zone8a");

}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

function testing(hayzombies)
{

flag::init("startflag");
flag::set("startflag");
	level flag::wait_till("initial_blackscreen_passed");
	if (hayzombies == false)
	{
		//Clear zombies
    	zombies = zombie_utility::get_round_enemy_array();
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
    	//Stop Spawning
    	level flag::clear( "spawn_zombies" );
	}
	
	
    foreach(player in GetPlayers())
			{
   				 //player bgb::give( "zm_bgb_perkaholic" );
			}

			//abrir puerta puzzle giratorio
						door = getEnt("cg_puerta", "targetname");
						door MoveZ(-150,3);
						clip = getEnt("cg_door_clip", "targetname");
						clip MoveZ(-150,3);

			//abrir puerta carrito
						clip_puerta_carrito = getEnt("clip_puerta_carrito", "targetname");
						clip_puerta_carrito Delete();
						flag::init("flag45");
    					flag::set("flag45");
						level notify("puerta_carrito_abierta");
}
function quickperkmachine(trigger,perk,cost,perkname,specialtyperk,power_on_message)
{
	level flag::wait_till("initial_blackscreen_passed");
	trig = getEnt(trigger, "targetname");
	
	trig SetCursorHint("HINT_NOICON");
	numero_de_quicks = 0;
	if (GetPlayers().size==1)
	{
		cost = 500;
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
function perkmachine(trigger,perk,cost,perkname,specialtyperk,power_on_message)
{
	trig = getEnt(trigger, "targetname");
	
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString("Need Power"); 
	level flag::wait_till( "power_on" );
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
function mpjw_make_sprinter()
{
    if ( isDefined( level.ptr_zombie_init_done ) )
        self [ [ level.ptr_zombie_init_done ] ]();
    
    self zombie_utility::set_zombie_run_cycle( "sprint" ); //"walk" "run" "sprint"
}

function teleport_lava()
{
	trig = getEnt("trig_lava", "targetname");
	while(1)
	  	{
	  		 trig waittill("trigger", player);
	  		 player thread quemar_y_teletransportar();
	  		 wait(0.5);
	  	}
}
function quemar_y_teletransportar()
{
	self clientfield::set( "burn", 1 );
	self playloopsound ("chr_burn_loop_overlay");
	wait(0.3);
	self thread teleport_player_to(1,"teleport_la");
	self zm_score::minus_to_player_score(1500);
	wait(2);
	self clientfield::set("burn", 0 );
	self stoploopsound(1);
}
function teleport_player_to(i,destinos)
{
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
function modelo_arco()
{
	arco = getEnt("arco", "targetname");
	arco SetInvisibleToAll();
	level waittill("Dragonheads_Filled");
	arco SetVisibleToAll();
	while(1)
	{
		arco RotateYaw(360,1);
		wait(0.9);
	}

}
function crear_texto(txt1,txt2,txt3,txt4,tiempo)
{
	thread CreateIntroText(txt1, 400,95,2,tiempo,1);
	thread CreateIntroText(txt2, 400,75,2,tiempo,1);
	thread CreateIntroText(txt3, 400,55,2,tiempo,1);
	thread CreateIntroText(txt4, 400,35,2,tiempo,1);
}
function pistas()
{
	level waittill ("start_game");
	thread pista1();
	thread pista2();
	thread pista3();
	thread pista4();
	thread pista5();
	thread pista6();
	thread pista7();
	thread pista8();
}
function pista1()
{
	trig = getEnt("pista_1", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: 2000 pts" ); 
	trig SetCursorHint("HINT_NOICON");	
	txt1 = "There are small pyramids around the map, and on them, you can unlock codes in the form of drawings. ";
	txt2 = "Observe those codes and replicate them on this wall.";
	txt3 = "To draw, you must stand on the illuminated tile and look at the squares.";
	txt4 = "If they are turned off, they will light up, and if they are already illuminated, they will turn off.";
	txt5 = "If the code is correct, you will hear a verification sound, and something will unlock near the small pyramid.";
	if (level.idioma == "SPANISH")
		{
		txt1 = "Hay pequeñas piramides por el mapa, y en ellas, puedes desbloquear codigos en forma de dibujos.";
		txt2 = "Observa esos codigos y replicalos en esta pared.";
		txt3 = "Para dibujar, debes estar en la baldosa iluminada y mirar a los cuadrados.";
		txt4 = "Si estan apagados, se iluminaran, y si estaban iluminados se apagaran.";
		txt5 = "Si el codigo es correcto, escucharas un sonido  de verificacion, y se desbloqueara algo cerca de la piramide pequeña.";
		}
	if (level.idioma == "FRENCH")
		{
		txt1 = "Il y a de petites pyramides sur la carte, et en elles, vous pouvez débloquer des codes sous forme de dessins.";
		txt2 = "Observez ces codes et reproduisez-les sur ce mur.";
		txt3 = "Pour dessiner, vous devez être sur la dalle illuminée et regarder les carrés.";
		txt4 = "S'ils sont éteints, ils s'allumeront, et s'ils étaient allumés, ils s'éteindront";
		txt5 = "Si le code est correct, vous entendrez un son de vérification, et quelque chose près de la petite pyramide se débloquera.";
		}
	if (level.idioma == "PORTUGUESE") 
		{
		txt1 = "Existem pequenas pirâmides no mapa, e nelas, você pode desbloquear códigos na forma de desenhos.";
		txt2 = "Observe esses códigos e reproduza-os nesta parede. ";
		txt3 = "Para desenhar, você deve estar na telha iluminada e olhar para os quadrados.";
		txt4 = "Se estiverem apagados, eles se iluminarão, e se estavam iluminados, se apagarão.";
		txt5 = "Se o código estiver correto, você ouvirá um som de verificação, e algo próximo à pequena pirâmide será desbloqueado.";
		}
	while(1)
	{
		trig waittill( "trigger", player );
		if(player.score >= 2000)
		{
			player zm_score::minus_to_player_score(2000);
			break;
		}
	}
	
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: Free" );

	while(1)
	{
		thread playsoundok("pista1");
		thread CreateIntroText("^6 Pharaoh: ^7" + txt1, 400,75,2,11,1);
		thread CreateIntroText(txt2, 400,55,2,11,1);
		wait(11);
		thread CreateIntroText("^6 Pharaoh: ^7" + txt3, 400,75,2,14,1);
		thread CreateIntroText(txt4, 400,55,2,14,1);
		wait(14);
		thread CreateIntroText("^6 Pharaoh: ^7" + txt5, 400,75,2,9,1);
		wait(9);
		trig waittill( "trigger", player );
	}
	
}
function pista2()
{
	trig = getEnt("pista_2", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: 2000 pts" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );
		if(player.score >= 2000)
		{
			player zm_score::minus_to_player_score(2000);
			break;
		}
	}
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: Free" );
	while(1)
	{
		if(level.cuerdas_rotas <= 1)
		{
			txt1 = "It seems that the next door is closed. Fortunately, there's a ramp just ";
			txt2 = "in front of it. If we throw the cart, we'll be able to clear the way.";
			txt3 = "To do this, the first thing we need is a bow to shoot at the ropes and unhook the rails. ";
			txt4 = "The bow can be obtained by feeding the 3 dragons located in the pyramid.";
			if (level.idioma == "SPANISH")
				{
				txt1 = "Parece que la proxima puerta esta cerrada. Afortunadamente, hay una rampa ";
				txt2 = "justo delante. Si tiras el carrito, podremos abrir paso.";
				txt3 = "Para hacer esto, lo primero que necesitamos es un arco para disparar a las cuerdas y desbloquear los railes.";
				txt4 = "El arco se puede obtener llenando los 3 dragones que están en la pirámide.";
				}
			if (level.idioma == "FRENCH")
				{
				txt1 = "Il semble que la prochaine porte soit fermée. Heureusement, il y a une rampe juste devant.";
				txt2 = "Si vous tirez le chariot, nous pourrons ouvrir le passage.";
				txt3 = "Pour ce faire, la première chose dont nous avons besoin est un arc pour tirer sur les cordes et débloquer les rails.";
				txt4 = "L'arc peut être obtenu en alimentant les 3 dragons qui se trouvent dans la pyramide.";
				}
			if (level.idioma == "PORTUGUESE")
				{
				txt1 = "Parece que a próxima porta está fechada. Felizmente, há uma rampa";
				txt2 = "logo à frente. Se você puxar o carrinho, poderemos abrir caminho.";
				txt3 = "Para fazer isso, a primeira coisa que precisamos é de um arco para atirar nas cordas e desbloquear os trilhos.";
				txt4 = "O arco pode ser obtido alimentando os 3 dragões que estão na pirâmide.";
				}
			thread playsoundok("pista2a");
		}
		if(level.cuerdas_rotas >= 2)
		{
			txt1 = "There is a cart that we need to push until it falls down the ramp and destroys the door.  ";
			txt2 = " However, we have to rotate the platforms to be able to take it to the ramp.";
			txt3 = "To do this, we must place a lever that activates the rotation mechanism on the wall. ";
			txt4 = "There are arrows indicating where the lever should be placed.";
			if (level.idioma == "SPANISH")
				{
				txt1 = "Necesitamos empujar el carrito hasta que caiga por la rampa y destruya la puerta.";
				txt2 = "Sin embargo, tenemos que rotar las plataformas para poder llevarlo hasta la rampa.";
				txt3 = "Para hacer esto, debemos colocar una palanca en la pared para que active la rotacion del mecanismo.";
				txt4 = "Hay unas flechas que indican donde debes colocar dicha palanca.";
				}
			if (level.idioma == "FRENCH")
				{
				txt1 = "Nous devons pousser le chariot jusqu'à ce qu'il tombe de la rampe et détruise la porte.";
				txt2 = "Cependant, nous devons faire pivoter les plates-formes pour pouvoir le porter jusqu'à la rampe.";
				txt3 = "Pour ce faire, nous devons placer un levier sur le mur pour activer la rotation du mécanisme.";
				txt4 = "Il y a des flèches qui indiquent où vous devez placer ce levier.";
				}
			if (level.idioma == "PORTUGUESE")
				{
				txt1 = "Precisamos empurrar o carrinho até que ele caia pela rampa e destrua a porta.";
				txt2 = "No entanto, precisamos girar as plataformas para conseguir levá-lo até a rampa.";
				txt3 = "Para fazer isso, devemos colocar uma alavanca na parede para ativar a rotação do mecanismo.";
				txt4 = "Há setas que indicam onde você deve colocar essa alavanca.";
				}
			thread playsoundok("pista2b");
		}
		thread CreateIntroText("^6 Pharaoh: ^7" + txt1, 400,75,2,10,1);
		thread CreateIntroText(txt2, 400,55,2,10,1);
		wait(10);
		thread CreateIntroText("^6 Pharaoh: ^7" + txt3, 400,75,2,15,1);
		thread CreateIntroText(txt4, 400,55,2,15,1);
		wait(15);
		trig waittill( "trigger", player );
	}
	
}
function pista3()
{
	trig = getEnt("pista_3", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: 2000 pts" ); 
	trig SetCursorHint("HINT_NOICON");	
	txt1 = "With the skulls, you can rotate the symbols. ";
	txt2 = "You must arrange them just like in the drawing in the room next door,";
	txt3 = "with each symbol in its corresponding area and leaving empty spaces where two circles intersect.";
	if (level.idioma == "SPANISH")
				{
				txt1 = "Puedes rotar los simbolos con las calaveras.";
				txt2 = "Debes colocar los simbolos justo como en el dibujo de la habitacion de al lado,";
				txt3 = "colocando  cada simbolo en su área correspondiente y dejando un espacio vacio donde los dos circulos intersectan.";
				}
				if (level.idioma == "FRENCH")
				{
				txt1 = "Vous pouvez faire tourner les symboles avec les crânes";
				txt2 = "Vous devez placer les symboles exactement comme dans le dessin de la pièce à côté,";
				txt3 = "en plaçant chaque symbole dans sa zone correspondante et laissant un espace vide où les deux cercles se croisent.";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "Você pode girar os símbolos com as caveiras.";
				txt2 = "Você deve colocar os símbolos exatamente como no desenho da sala ao lado,";
				txt3 = "colocando cada símbolo em sua área correspondente e deixando um espaço vazio onde os dois círculos se intersectam.";
				}
	while(1)
	{
		trig waittill( "trigger", player );
		if(player.score >= 2000)
		{
			player zm_score::minus_to_player_score(2000);
			break;
		}
	}
	
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: Free" );

	while(1)
	{
		thread playsoundok("pista3");
		thread CreateIntroText("^6 Pharaoh: ^7" + txt1, 400,75,2,16,1);
		thread CreateIntroText(txt2, 400,55,2,16,1);
		thread CreateIntroText(txt3, 400,35,2,16,1);
		wait(16);
		trig waittill( "trigger", player );
	}
	
}
function pista4()
{
	trig = getEnt("pista_4", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: 2000 pts" ); 
	trig SetCursorHint("HINT_NOICON");	
	txt1 = "You should use the scream of a shrieker zombie to extinguish the fire. ";
	if (level.idioma == "SPANISH")
				{
				txt1 = "Utiliza el grito de un zombi chillon para apagar el fuego";
				}
				if (level.idioma == "FRENCH")
				{
				txt1 = "Utilisez le cri d'un zombie bruyant pour éteindre le feu.";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "Use o grito de um zumbi barulhento para apagar o fogo.";
				}
	while(1)
	{
		trig waittill( "trigger", player );
		if(player.score >= 2000)
		{
			player zm_score::minus_to_player_score(2000);
			break;
		}
	}
	
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: Free" );

	while(1)
	{
		thread playsoundok("pista4");
		thread CreateIntroText("^6 Pharaoh: ^7" + txt1, 400,75,2,6,1);
		wait(6);
		trig waittill( "trigger", player );
	}
	
}
function pista5()
{
	trig = getEnt("pista_5", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: 2000 pts" ); 
	trig SetCursorHint("HINT_NOICON");	
	txt1 = "The platforms in front work like a seesaw. To raise the bridge, you need to load weight onto the other platform.";
	txt2 = "You can use a bomb monkey to make the zombies jump onto it. ";
	txt3 = "If the weight is sufficient, the platform will tilt.";
	txt4 = " You can obtain bomb monkeys from the mystery box or at the end of the fire hallway.";
	if (level.idioma == "SPANISH")
				{
				txt1 = "Las plataformas en frente tuyo funcionan como una balanza. Para subir el puente, debes cargar de peso la otra plataforma.";
				txt2 = "Puedes usar un mono bomba para hacer a los zombies saltar hasta el.";
				txt3 = "Si el peso es suficiente, la plataforma tambaleará.";
				txt4 = "Puedes obtener los monos bomba en la caja misteriosa o al final del pasillo de fuego.";
				}
				if (level.idioma == "FRENCH")
				{
				txt1 = "Les plates-formes devant vous fonctionnent comme une balance. Pour lever le pont, vous devez charger l'autre plate-forme de poids.";
				txt2 = "Vous pouvez utiliser un singe bombe pour faire sauter les zombies jusqu'à lui.";
				txt3 = "Si le poids est suffisant, la plate-forme vacillera.";
				txt4 = "Vous pouvez obtenir les singes bombes dans la boîte mystérieuse ou à la fin du couloir enflammé.";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "As plataformas à sua frente funcionam como uma balança. Para levantar a ponte, você precisa carregar de peso a outra plataforma.";
				txt2 = "Você pode usar um macaco bomba para fazer os zumbis pular até ele.";
				txt3 = "Se o peso for suficiente, a plataforma vai balançar.";
				txt4 = "Você pode obter os macacos bomba na caixa misteriosa ou no final do corredor de fogo.";
				}
	while(1)
	{
		trig waittill( "trigger", player );
		if(player.score >= 2000)
		{
			player zm_score::minus_to_player_score(2000);
			break;
		}
	}
	
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: Free" );

	while(1)
	{
		thread playsoundok("pista5");
		thread CreateIntroText("^6 Pharaoh: ^7" + txt1, 400,75,2,12,1);
		thread CreateIntroText(txt2, 400,55,2,12,1);
		wait(12);
		thread CreateIntroText("^6 Pharaoh: ^7" + txt3, 400,75,2,13,1);
		thread CreateIntroText(txt4, 400,55,2,13,1);
		wait(13);
		trig waittill( "trigger", player );
	}
	
}
function pista6()
{
	trig = getEnt("pista_6", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: 2000 pts" ); 
	trig SetCursorHint("HINT_NOICON");	
	txt1 = "To unlock the barrier, you must shoot three of the paintings on the wall in a specific order. ";
	txt2 = "To find out the order, stand on one of the eye symbols on the floor and look at the figures.";
	txt3 = "The silhouette they form on the wall corresponds to one of the paintings, ";
	txt4 = "and the number you observe will tell you the order in which to shoot them.";
	if (level.idioma == "SPANISH")
				{
				txt1 = "Para desbloquear la barrera, debes disparar a tres de las pinturas en la pared en un orden en especifico.";
				txt2 = "Para encontrar ese orden, colocate encima de uno de los simbolos de ojo que hay en el suelo y mira las figuras.";
				txt3 = "La sirueta que formnan en la pared corresponde con una de esas pinturas,";
				txt4 = "y el numero que ves te dirá en que orden debes disparar.";
				}
	if (level.idioma == "FRENCH")
				{
				txt1 = "Pour débloquer la barrière, vous devez tirer sur trois des tableaux sur le mur dans un ordre spécifique.";
				txt2 = "Pour trouver cet ordre, placez-vous sur l'un des symboles d'œil au sol et regardez les figures.";
				txt3 = "La silhouette qu'ils forment sur le mur correspond à l'un de ces tableaux,";
				txt4 = "et le numéro que vous voyez vous indiquera dans quel ordre tirer.";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "Para desbloquear a barreira, você precisa atirar em três das pinturas na parede em uma ordem específica.";
				txt2 = "Para encontrar essa ordem, coloque-se sobre um dos símbolos de olho que estão no chão e observe as figuras.";
				txt3 = "A silhueta que eles formam na parede corresponde a uma dessas pinturas,";
				txt4 = "e o número que você vê indicará a ordem em que deve atirar.";
				}
	while(1)
	{
		trig waittill( "trigger", player );
		if(player.score >= 2000)
		{
			player zm_score::minus_to_player_score(2000);
			break;
		}
	}
	
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: Free" );

	while(1)
	{
		thread playsoundok("pista6");
		thread CreateIntroText("^6 Pharaoh: ^7" + txt1, 400,75,2,13,1);
		thread CreateIntroText(txt2, 400,55,2,13,1);
		wait(13);
		thread CreateIntroText("^6 Pharaoh: ^7" + txt3, 400,75,2,12,1);
		thread CreateIntroText(txt4, 400,55,2,12,1);
		wait(12);
		trig waittill( "trigger", player );
	}
	
}
function pista7()
{
	trig = getEnt("pista_7", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: 2000 pts" ); 
	trig SetCursorHint("HINT_NOICON");	
	txt1 = "On this wall, there are some symbols. ";
	txt2 = "These same symbols, but in red, are scattered throughout the pyramid.";
	txt3 = "Shoot each one of them with an upgraded weapon.";
	if (level.idioma == "SPANISH")
				{
				txt1 = "En esta pared hay unos simbolos.";
				txt2 = "Estos mismos simbolos, pero en rojo, estan repartidos por la piramide.";
				txt3 = "Dispara a esos simbolos con un arma mejorada.";
				}
				if (level.idioma == "FRENCH")
				{
				txt1 = "Sur ce mur, il y a des symboles.";
				txt2 = "Ces mêmes symboles, mais en rouge, sont dispersés dans la pyramide.";
				txt3 = "Tirez sur ces symboles avec une arme améliorée.";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "Nesta parede, há alguns símbolos.";
				txt2 = "Esses mesmos símbolos, mas em vermelho, estão espalhados pela pirâmide.";
				txt3 = "Atire nesses símbolos com uma arma aprimorada.";
				}
	while(1)
	{
		trig waittill( "trigger", player );
		if(player.score >= 2000)
		{
			player zm_score::minus_to_player_score(2000);
			break;
		}
	}
	
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: Free" );

	while(1)
	{
		thread playsoundok("pista7");
		thread CreateIntroText("^6 Pharaoh: ^7" + txt1, 400,75,2,12,1);
		thread CreateIntroText(txt2, 400,55,2,12,1);
		thread CreateIntroText(txt3, 400,35,2,12,1);
		wait(6);
		trig waittill( "trigger", player );
	}
	
}
function pista8()
{
	trig = getEnt("pista_8", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: 2000 pts" ); 
	trig SetCursorHint("HINT_NOICON");	
	txt1 = "When you shoot these cubes, they rotate. On the wall, you can see two paintings. ";
	txt2 = "You need to replicate the paintings' drawings on each side by rotating the cubes.";
	txt3 = "It is easier if you first obtain the drawing on one side, then the other, ";
	txt4 = "and repeating this process, until is correct in both sides. ";
	if (level.idioma == "SPANISH")
				{
				txt1 = "Cuando disparas a estos cubos, rotan. En la pared puedes ver dos pinturas.";
				txt2 = "Tienes que replicar las pinturas en cada lado rotantdo los cubos.";
				txt3 = "Es mas facil si primero obtienes el dibujo de un lado, luego el del otro,";
				txt4 = "y repites este proceso, hasta que es correcto en ambos lados.";
				}
				if (level.idioma == "FRENCH")
				{
				txt1 = "Lorsque vous tirez sur ces cubes, ils tournent. Sur le mur, vous pouvez voir deux tableaux.";
				txt2 = "Vous devez reproduire les tableaux de chaque côté en faisant tourner les cubes.";
				txt3 = "C'est plus facile si vous obtenez d'abord le dessin d'un côté, puis celui de l'autre,";
				txt4 = "et répétez ce processus jusqu'à ce qu'il soit correct des deux côtés.";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "Quando você atira nesses cubos, eles giram. Na parede, você pode ver duas pinturas.";
				txt2 = "Você precisa replicar as pinturas em cada lado girando os cubos.";
				txt3 = "É mais fácil se você primeiro obtiver o desenho de um lado, depois o do outro,";
				txt4 = "e repetir esse processo até que esteja correto em ambos os lados.";
				}
	while(1)
	{
		trig waittill( "trigger", player );
		if(player.score >= 2000)
		{
			player zm_score::minus_to_player_score(2000);
			break;
		}
	}
	
	trig SetHintString( "Press and Hold ^3&&1^7 to request the Pharaoh's assistance.^3Cost: Free" );

	while(1)
	{
		thread playsoundok("pista8");
		thread CreateIntroText("^6 Pharaoh: ^7" + txt1, 400,75,2,10,1);
		thread CreateIntroText(txt2, 400,55,2,10,1);
		wait(10);
		thread CreateIntroText("^6 Pharaoh: ^7" + txt3, 400,75,2,12,1);
		thread CreateIntroText(txt4, 400,55,2,12,1);
		wait(12);
		trig waittill( "trigger", player );
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
//////////////////////puzzle CIRCULOS///////////////////////
function puzzle_circulos_giratorios()
{
	/*nombre piezas inicial

				Pieza1		Pieza2

			         CentroUP

		Pieza5	Pieza3		Pieza4  Pieza7

		   CentroL				CentroR

		Pieza6  Pieza9		Pieza10 Pieza8

					CentroD

				Pieza11		Pieza12

	Vectores:
	 - cg_posicion_pieza[n] = numero (pieza que esta ahi)
	 - cg_posicion_simbolo[n] = nombre (simbolo de la pieza que esta ahi)

	 */
	 //Primero inicializamos que simbolo corresponde a cada pieza
	 level.cg_pieza_simbolo[1] ="Espiral"; 
	 level.cg_pieza_simbolo[2] =""; 
	 level.cg_pieza_simbolo[3] ="Rayas"; 
	 level.cg_pieza_simbolo[4] ="Circulo"; 
	 level.cg_pieza_simbolo[5] =""; 
	 level.cg_pieza_simbolo[6] ="Espiral"; 
	 level.cg_pieza_simbolo[7] ="Arbol"; 
	 level.cg_pieza_simbolo[8] ="Arbol"; 
	 level.cg_pieza_simbolo[9] =""; 
	 level.cg_pieza_simbolo[10] ="Circulo"; 
	 level.cg_pieza_simbolo[11] ="Rayas"; 
	 level.cg_pieza_simbolo[12] =""; 

	 //indicamos que pieza esta en cada posicion inicialmente
	level.cg_posicion_pieza[1]= 1;
	level.cg_posicion_pieza[2]= 2;
	level.cg_posicion_pieza[3]= 3;
	level.cg_posicion_pieza[4]= 4;
	level.cg_posicion_pieza[5]= 5;
	level.cg_posicion_pieza[6]= 6;
	level.cg_posicion_pieza[7]= 7;
	level.cg_posicion_pieza[8]= 8;
	level.cg_posicion_pieza[9]= 9;
	level.cg_posicion_pieza[10]= 10;
	level.cg_posicion_pieza[11]= 11;
	level.cg_posicion_pieza[12]= 12;

	thread cg_movimiento_piezas();

		//chequeo de solucion
	while(1)
	{		
		WAIT_SERVER_FRAME;
		if((level.cg_pieza_simbolo[level.cg_posicion_pieza[1]]=="Arbol")&&(level.cg_pieza_simbolo[level.cg_posicion_pieza[2]]=="Arbol"))
		{
			//si en la posicion 1 y 2 estan los arbol
			if((level.cg_pieza_simbolo[level.cg_posicion_pieza[5]]=="Rayas")&&(level.cg_pieza_simbolo[level.cg_posicion_pieza[6]]=="Rayas"))
			{
				//si en la posicion 5 y 6 estan las Rayas
				if((level.cg_pieza_simbolo[level.cg_posicion_pieza[7]]=="Espiral")&&(level.cg_pieza_simbolo[level.cg_posicion_pieza[8]]=="Espiral"))
				{
					//si en la posicion 7 y 8 estan las Espiral
					if((level.cg_pieza_simbolo[level.cg_posicion_pieza[11]]=="Circulo")&&(level.cg_pieza_simbolo[level.cg_posicion_pieza[12]]=="Circulo"))
					{
						//si en la posicion 11 y 12 estan los Circulo
						IPrintLnBold("Something has been opened...");
						door = getEnt("cg_puerta", "targetname");
						door MoveZ(-150,3);
						clip = getEnt("cg_door_clip", "targetname");
						clip MoveZ(-150,3);
						flag::init("flag67");
    					flag::set("flag67");
						break;
					}
				}	

			}
		}
	}
}
function cg_movimiento_piezas()
{
	level.cg_mecanismo_activado = false;//para no poder rotar dos a la vez
	thread cg_trig_up();
	thread cg_trig_down();
	thread cg_trig_Left();
	thread cg_trig_Right();
}
function cg_trig_up()
{
	trig = getEnt("cg_trig_up", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to Activate the mechanism" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );	
		if (level.cg_mecanismo_activado == false) //chequeo que el mecanismo no se esta moviendo
		{
			level.cg_mecanismo_activado = true;
				//primero rotamos las piezas correspondientes
				thread cg_rotar_pieza_eje_y(level.cg_posicion_pieza[1],level.cg_posicion_pieza[2],level.cg_posicion_pieza[3],level.cg_posicion_pieza[4],"cg_giro_up");
				wait(1.1);
				//asignamos que pieza se encuentra ahora en cada posición
				posicion_nueva[1] = level.cg_posicion_pieza[2];
				posicion_nueva[3] = level.cg_posicion_pieza[1];
				posicion_nueva[4] = level.cg_posicion_pieza[3];
				posicion_nueva[2] = level.cg_posicion_pieza[4];

				level.cg_posicion_pieza[1] = posicion_nueva[1];
				level.cg_posicion_pieza[2] = posicion_nueva[2];
				level.cg_posicion_pieza[3] = posicion_nueva[3];
				level.cg_posicion_pieza[4] = posicion_nueva[4];
			//indicamos que el movimiento ha terminado
			level.cg_mecanismo_activado = false;		
		}
	}
}
function cg_trig_down()
{
	trig = getEnt("cg_trig_down", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to Activate the mechanism" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );	
		if (level.cg_mecanismo_activado == false) //chequeo que el mecanismo no se esta moviendo
		{
			level.cg_mecanismo_activado = true;
				//primero rotamos las piezas correspondientes
				thread cg_rotar_pieza_eje_y(level.cg_posicion_pieza[9],level.cg_posicion_pieza[10],level.cg_posicion_pieza[11],level.cg_posicion_pieza[12],"cg_giro_d");
				wait(1.1);
				//asignamos que pieza se encuentra ahora en cada posición
				posicion_nueva[9] = level.cg_posicion_pieza[10];
				posicion_nueva[11] = level.cg_posicion_pieza[9];
				posicion_nueva[12] = level.cg_posicion_pieza[11];
				posicion_nueva[10] = level.cg_posicion_pieza[12];

				level.cg_posicion_pieza[9] = posicion_nueva[9];
				level.cg_posicion_pieza[10] = posicion_nueva[10];
				level.cg_posicion_pieza[11] = posicion_nueva[11];
				level.cg_posicion_pieza[12] = posicion_nueva[12];
			//indicamos que el movimiento ha terminado
			level.cg_mecanismo_activado = false;		
		}
	}
}
function cg_trig_Left()
{
	trig = getEnt("cg_trig_L", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to Activate the mechanism" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );	
		if (level.cg_mecanismo_activado == false) //chequeo que el mecanismo no se esta moviendo
		{
			level.cg_mecanismo_activado = true;
				//primero rotamos las piezas correspondientes
				thread cg_rotar_pieza_eje_y(level.cg_posicion_pieza[5],level.cg_posicion_pieza[6],level.cg_posicion_pieza[3],level.cg_posicion_pieza[9],"cg_giro_l");
				wait(1.1);
				//asignamos que pieza se encuentra ahora en cada posición
				posicion_nueva[5] = level.cg_posicion_pieza[3];
				posicion_nueva[6] = level.cg_posicion_pieza[5];
				posicion_nueva[9] = level.cg_posicion_pieza[6];
				posicion_nueva[3] = level.cg_posicion_pieza[9];

				level.cg_posicion_pieza[5] = posicion_nueva[5];
				level.cg_posicion_pieza[6] = posicion_nueva[6];
				level.cg_posicion_pieza[9] = posicion_nueva[9];
				level.cg_posicion_pieza[3] = posicion_nueva[3];
			//indicamos que el movimiento ha terminado
			level.cg_mecanismo_activado = false;		
		}
	}
}
function cg_trig_Right()
{
	trig = getEnt("cg_trig_R", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to Activate the mechanism" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );	
		if (level.cg_mecanismo_activado == false) //chequeo que el mecanismo no se esta moviendo
		{
			level.cg_mecanismo_activado = true;
				//primero rotamos las piezas correspondientes
				thread cg_rotar_pieza_eje_y(level.cg_posicion_pieza[4],level.cg_posicion_pieza[10],level.cg_posicion_pieza[8],level.cg_posicion_pieza[7],"cg_giro_r");
				wait(1.1);
				//asignamos que pieza se encuentra ahora en cada posición
				posicion_nueva[4] = level.cg_posicion_pieza[7];
				posicion_nueva[10] = level.cg_posicion_pieza[4];
				posicion_nueva[8] = level.cg_posicion_pieza[10];
				posicion_nueva[7] = level.cg_posicion_pieza[8];

				level.cg_posicion_pieza[4] = posicion_nueva[4];
				level.cg_posicion_pieza[10] = posicion_nueva[10];
				level.cg_posicion_pieza[8] = posicion_nueva[8];
				level.cg_posicion_pieza[7] = posicion_nueva[7];
			//indicamos que el movimiento ha terminado
			level.cg_mecanismo_activado = false;		
		}
	}
}
function cg_rotar_pieza_eje_y(numero_pieza_1,numero_pieza_2,numero_pieza_3,numero_pieza_4,nombre_centro)
{
	objeto1 = getEnt("pieza" + numero_pieza_1, "targetname");	
	objeto2 = getEnt("pieza" + numero_pieza_2, "targetname");
	objeto3 = getEnt("pieza" + numero_pieza_3, "targetname");
	objeto4 = getEnt("pieza" + numero_pieza_4, "targetname");
	centro = getEnt(nombre_centro, "targetname");

	objeto1 EnableLinkTo();
	objeto1 LinkTo(centro);
	objeto2 EnableLinkTo();
	objeto2 LinkTo(centro);
	objeto3 EnableLinkTo();
	objeto3 LinkTo(centro);
	objeto4 EnableLinkTo();
	objeto4 LinkTo(centro);

	centro RotatePitch(-90,0.5);
	wait(0.8);
	objeto1 Unlink();
	objeto2 Unlink();
	objeto3 Unlink();
	objeto4 Unlink();

}

///////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
// PUZZLE DIBUJAR           PUZZLE DIBUJAR        PUZZLE DIBUJAR//
///////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

function puzzle_dibujar()
{
	pixeles = GetEntArray("puzzle_dibujar", "targetname");//trigger multiple
	foreach (pixel in pixeles)
	{
		pixel thread puzzle_dibujar_pixel();
	}

	thread pdp_open("electricidad");
	thread pdp_open("palanca");
	//thread pdp_open("monos");
	thread pdp_open("arma");


	
}
function pdp_open(txt)
{
	puerta = GetEnt("pdp_puerta_"+txt, "targetname");
	marco = GetEnt("pdp_"+txt, "targetname");
	codigo1 = GetEnt("pdp_"+txt+"1", "targetname");
	codigo2 = GetEnt("pdp_"+txt+"2", "targetname");
	codigo3 = GetEnt("pdp_"+txt+"3", "targetname");
	codigo1 SetInvisibleToAll();
	codigo2 SetInvisibleToAll();
	codigo3 SetInvisibleToAll();
	trig = GetEnt("trig_pdp_"+txt, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to reveal the code (1000 pts)" ); 
	trig SetCursorHint("HINT_NOICON");
	while(1)
	{
		trig waittill( "trigger", player );	
		if (player.score >= 1000)
		{
			player.score -= 1000;
			trig Delete();
			r = RandomIntRange(1,99); //(min result, max rasult + 1) randomizar el destino entre 1 y 3
			if (r<=33)
			{
				i=1;
			}
			else if (r>=67)
			{
				i=3;
			}
			else
			{
				i=2;
			}
			codigo = GetEnt("pdp_"+txt+i, "targetname");
			codigo MoveX(1.5,0.1);
			wait(0.2);
			codigo SetVisibleToAll();
			codigo MoveX(-1.5,0.4);
			thread check_dibujo(txt,i);
			level waittill (txt);
			puerta MoveZ(-127,1);
			PlaySoundAtPosition("girar_piedra",puerta.origin);
			wait(1.1);
			puerta Delete();
			break;
		}
	}
}
function puzzle_dibujar_pixel()
{
	trig = GetEnt("puzzle_dibujar_posicion", "targetname");
	modelo = GetEnt(self.target, "targetname");
	modelo SetInvisibleToAll();
	while(1)
	{
		modelo SetInvisibleToAll();
		level.puzzle_dibujar_pixel[self.script_string] = false;
		trig waittill( "trigger", player );	
		while(player IsTouching(trig))
		{
			
			WAIT_SERVER_FRAME;
			if (player IsLookingAt(self)) //self = trigger del pixel
			{				
				if (level.puzzle_dibujar_pixel[self.script_string] == false)
				{
					level.puzzle_dibujar_pixel[self.script_string] = true;
					modelo SetVisibleToAll();
					while(player IsLookingAt(self))
					{
						WAIT_SERVER_FRAME;
					}
				}
			
				else 
				{
					level.puzzle_dibujar_pixel[self.script_string] = false;
					modelo SetInvisibleToAll();
					while(player IsLookingAt(self))
					{
						WAIT_SERVER_FRAME;
					}
				}
			}
			
		}
	}
}
function check_dibujo(desbloquea,n)
{
	dibujo = desbloquea + n;
	//IPrintLnBold (dibujo);
	if (dibujo == "palanca1")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(11,12,13,14,15,16,17,31,32,33,34,35,36,37,51,52,53,54,55,56,57,71,72,73,74,75,76,77);			
		}
	if (dibujo == "palanca2")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(22,32,42,52,62,26,36,46,56,66,23,24,25,63,64,65);			
		}
	if (dibujo == "palanca3")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(14,23,25,32,36,41,47,52,56,63,65,74);			
		}

	if (dibujo == "electricidad1")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(16,21,25,31,34,37,41,42,43,44,45,46,47,51,54,57,61,65,76);			
		}
	if (dibujo == "electricidad2")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(22,23,25,26,33,36,46,52,53,56,63,65,66);			
		}
	if (dibujo == "electricidad3")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(11,13,14,15,17,22,26,31,37,41,44,47,51,57,62,66,71,73,74,75,77);			
		}

	if (dibujo == "arma1")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(22,23,24,25,26,33,44,53,62,63,64,65,66);			
		}
	if (dibujo == "arma2")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(22,23,24,25,26,32,34,36,42,44,46,52,53,54,56,64,65,66);			
		}
	if (dibujo == "arma3")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(25,26,34,35,36,37,43,44,45,46,47,52,54,55,56,57,65,66);			
		}

	/*if (dibujo == "arma1")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(11,13,15,17,22,24,26,33,34,35,44,53,54,55,62,64,66,71,73,75,77);			
		}
	if (dibujo == "arma2")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(14,22,26,27,32,34,37,44,51,56,61,62,64,66);			
		}
	if (dibujo == "arma3")//pixel(1,j) -> i=columna , j=fila
		{
			pixeles_trues = array(14,22,26,31,32,34,36,37,41,42,46,47,51,52,54,56,57,62,66,74);			
		}*/

	while(1)
	{
		WAIT_SERVER_FRAME;
	
		total_trues = 0;
		for (i = 1; i < 8; i++)
			{
				for (j = 1; j < 8; j++)
				{
					number = (i*10)+(j);
					text = "" + number + ""; //script_string es un texto por eso hay que pasar el numero a texto para el "if"
					if (level.puzzle_dibujar_pixel[text] == true)
					{
						total_trues ++;
					}
				}
			}
		//se ha checkeado si el numero de pixeles encendidos= al numero que debe haber
		//ahora se checkea si esos pixeles son los que deben estar encendidos
		trues_correctos=false;
		if (total_trues == pixeles_trues.size)
		{
			trues_correctos=true;
			for ( i = 0; i < pixeles_trues.size; i++ )
			{
				text = "" + pixeles_trues[i] + "";
				if(level.puzzle_dibujar_pixel[text]==false)
				{
					trues_correctos=false;
				}
			}
		}


		if ((total_trues == pixeles_trues.size) && (trues_correctos == true))
		{
			level notify (desbloquea);
			thread playsoundok("correcto");
			break;
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

///////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
// PUZZLE CUBOS           PUZZLE CUBOS        PUZZLE CUBOS//
///////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

function puzzle_cubos()
{
	level.cubos_completado = false;
	trig = GetEnt("orion_trigger", "targetname");
	trig SetHintString( "Solve the puzzle or pay 10.000 pts to unlock Serket's Kiss" ); 
	trig SetCursorHint("HINT_NOICON");
	orion_model = GetEnt("orion_model", "targetname");
	orion_model SetInvisibleToAll();
	thread skip_cubos_puzzle(trig,orion_model);

	pixeles = GetEntArray("puzzle_cubos", "targetname");//trigger multiple
	foreach (pixel in pixeles)
	{
		pixel thread puzzle_cubos_pixel();
	}
	//solucion
	level.puzzle_cubos_solucion["11"] = 1;
	level.puzzle_cubos_solucion["12"] = 1;
	level.puzzle_cubos_solucion["13"] = 1;
	level.puzzle_cubos_solucion["14"] = 1;
	level.puzzle_cubos_solucion["15"] = 1;
	level.puzzle_cubos_solucion["16"] = 1;
	level.puzzle_cubos_solucion["17"] = 1;
	level.puzzle_cubos_solucion["18"] = 1;

	level.puzzle_cubos_solucion["21"] = 2;
	level.puzzle_cubos_solucion["22"] = 3;
	level.puzzle_cubos_solucion["23"] = 1;
	level.puzzle_cubos_solucion["24"] = 3;
	level.puzzle_cubos_solucion["25"] = 1;
	level.puzzle_cubos_solucion["26"] = 3;
	level.puzzle_cubos_solucion["27"] = 3;
	level.puzzle_cubos_solucion["28"] = 2;

	level.puzzle_cubos_solucion["31"] = 2;
	level.puzzle_cubos_solucion["32"] = 3;
	level.puzzle_cubos_solucion["33"] = 1;
	level.puzzle_cubos_solucion["34"] = 3;
	level.puzzle_cubos_solucion["35"] = 1;
	level.puzzle_cubos_solucion["36"] = 3;
	level.puzzle_cubos_solucion["37"] = 1;
	level.puzzle_cubos_solucion["38"] = 2;

	level.puzzle_cubos_solucion["41"] = 2;
	level.puzzle_cubos_solucion["42"] = 3;
	level.puzzle_cubos_solucion["43"] = 1;
	level.puzzle_cubos_solucion["44"] = 3;
	level.puzzle_cubos_solucion["45"] = 1;
	level.puzzle_cubos_solucion["46"] = 3;
	level.puzzle_cubos_solucion["47"] = 4;
	level.puzzle_cubos_solucion["48"] = 2;

	level.puzzle_cubos_solucion["51"] = 1;
	level.puzzle_cubos_solucion["52"] = 3;
	level.puzzle_cubos_solucion["53"] = 1;
	level.puzzle_cubos_solucion["54"] = 3;
	level.puzzle_cubos_solucion["55"] = 1;
	level.puzzle_cubos_solucion["56"] = 1;
	level.puzzle_cubos_solucion["57"] = 3;
	level.puzzle_cubos_solucion["58"] = 2;

	level.puzzle_cubos_solucion["61"] = 1;
	level.puzzle_cubos_solucion["62"] = 3;
	level.puzzle_cubos_solucion["63"] = 1;
	level.puzzle_cubos_solucion["64"] = 3;
	level.puzzle_cubos_solucion["65"] = 1;
	level.puzzle_cubos_solucion["66"] = 2;
	level.puzzle_cubos_solucion["67"] = 4;
	level.puzzle_cubos_solucion["68"] = 2;

	level.puzzle_cubos_solucion["71"] = 1;
	level.puzzle_cubos_solucion["72"] = 3;
	level.puzzle_cubos_solucion["73"] = 1;
	level.puzzle_cubos_solucion["74"] = 3;
	level.puzzle_cubos_solucion["75"] = 1;
	level.puzzle_cubos_solucion["76"] = 3;
	level.puzzle_cubos_solucion["77"] = 4;
	level.puzzle_cubos_solucion["78"] = 2;

	level.puzzle_cubos_solucion["81"] = 1;
	level.puzzle_cubos_solucion["82"] = 1;
	level.puzzle_cubos_solucion["83"] = 1;
	level.puzzle_cubos_solucion["84"] = 1;
	level.puzzle_cubos_solucion["85"] = 1;
	level.puzzle_cubos_solucion["86"] = 1;
	level.puzzle_cubos_solucion["87"] = 1;
	level.puzzle_cubos_solucion["88"] = 1;

	while(1)
	{
		level waittill ("check_puzzle_cubos");

		total_errors = 0;
		for (i = 1; i < 9; i++)
			{
				for (j = 1; j < 9; j++)
				{
					number = (i*10)+(j);
					text = "" + number + ""; //script_string es un texto por eso hay que pasar el numero a texto para el "if"
					if (level.puzzle_cubo[text] != level.puzzle_cubos_solucion[text])
					{
						total_errors ++;
					}
				}
			}
		if ((total_errors ==0)&&(level.cubos_completado==false))
		{
			IPrintLnBold("PUZZLE COMPLETED!");
			level notify ("puzzle_cubos_completado");
			level.cubos_completado = true;
			foreach (pixel in pixeles)
				{
					pixel SetInvisibleToAll();//triggers
				}
			orion_model SetVisibleToAll();
			trig SetHintString( "Hold ^3&&1^7 to get Serket's Kiss" ); 
			thread dar_arma("death_orion_upgraded","Serket's Kiss",trig );

		}
	}
}
function puzzle_cubos_pixel()//self = trigger_damage
{
	level.cubos_completado = false;
	cubo = GetEnt(self.target, "targetname");
	level.puzzle_cubo[self.script_string]=1;
	while(1)
	{
		self waittill( "trigger", player );
		if (level.cubos_completado == true)
		{break;}
		cubo RotateYaw(90,0.4);
		wait(0.4);
		level.puzzle_cubo[self.script_string] = 2;
		level notify ("check_puzzle_cubos");

		self waittill( "trigger", player );
		if (level.cubos_completado == true)
		{break;}
		cubo RotateYaw(90,0.4);
		wait(0.4);
		level.puzzle_cubo[self.script_string] = 3;
		level notify ("check_puzzle_cubos");

		self waittill( "trigger", player );
		if (level.cubos_completado == true)
		{break;}
		cubo RotateRoll(90,0.4);
		wait(0.4);
		level.puzzle_cubo[self.script_string] = 4;
		level notify ("check_puzzle_cubos");

		self waittill( "trigger", player );
		if (level.cubos_completado == true)
		{break;}
		cubo RotateRoll(90,0.4);
		wait(0.4);
		level.puzzle_cubo[self.script_string] = 1;
		level notify ("check_puzzle_cubos");
		
	}
}
function donandres_rotateobject(model)
{
	while(1)
	{
		model RotateYaw(360,1.2);
		wait(1.21);
	}
}
function dar_arma(weap,nombre_arma,trig)
{
	while(1)
	{
		trig waittill("trigger", player);
		
		player TakeWeapon(player GetCurrentWeapon());
		player zm_weapons::weapon_give(getweapon(weap));
	}
	
}
function skip_cubos_puzzle(trig,orion_model)
{
	self endon ("puzzle_cubos_completado");
	while(1)
	{
		trig waittill( "trigger", player );	
		if(player.score >= 10000)
		{
			player zm_score::minus_to_player_score(10000);
			level.cubos_completado = true;
			orion_model SetVisibleToAll();
			trig SetHintString( "Hold ^3&&1^7 to get Serket's Kiss" ); 
			thread dar_arma("death_orion_upgraded","Serket's Kiss",trig );
			break;
		}
	}
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
////////////////PUZZLE CARRO PUZZLE CARRO ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
function puzzle_carro()
{
	thread recoger_palanca();
	thread romper_cuerdas(1,-14.2);
	thread romper_cuerdas(2,14.2);
	thread movimiento_carro();
	thread rotacion_vias();
	thread descenso_carrito();
}
function recoger_palanca()
{
	level.palanca_colocada = false;
	palanca_model_1 = getEnt("palanca_model_1", "targetname");
	palanca_model_2 = getEnt("palanca_model_2", "targetname");
	palanca_trig_1 = getEnt("palanca_trig_1", "targetname");
	palanca_trig_2 = getEnt("palanca_trig_2", "targetname");
	palanca_model_2 SetInvisibleToAll();
	palanca_trig_1 SetHintString( "Hold ^3&&1^7 to take lever" ); 
	palanca_trig_1 SetCursorHint("HINT_NOICON");
	palanca_trig_2 SetHintString( "Need a lever to activate mechanism..." ); 
	palanca_trig_2 SetCursorHint("HINT_NOICON");
	palanca_trig_1 waittill ( "trigger", player );
	palanca_model_1 Delete();
	palanca_trig_1 Delete();
	palanca_trig_2 SetHintString( "Hold ^3&&1^7 to place lever" ); 
	palanca_trig_2 waittill ( "trigger", player );
	palanca_model_2 SetVisibleToAll();
	level notify ("palanca_colocada");
	level.palanca_colocada = true;

}
function romper_cuerdas(i,giro)
{
	via = getEnt("via_cuerdas_" + i, "targetname");
	cuerda_a = getEnt("cuerdas_a_" + i, "targetname");
	cuerda_b = getEnt("cuerdas_b_" + i, "targetname");
	eje = getEnt("eje_via_cuerdas_" + i, "targetname");
	clip = getEnt("via_cuerdas_clip_" + i, "targetname");
	trig = getEnt("trig_cuerdas_" + i, "targetname");
	arco = GetWeapon("elemental_bow");
	level.cuerdas_rotas = 0;
	while(1)
	{
		trig waittill( "damage", damage, player, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		arma_actual = player GetCurrentWeapon();
		if(arma_actual == arco)
		{
			cuerda_a Delete();
			cuerda_b Delete();
			trig Delete();
			via EnableLinkTo();
			via LinkTo(eje);   
			eje RotatePitch(giro,1);
			wait(1);
			clip Delete();
			level.cuerdas_rotas++;
			break;
		}
	}
		
}
function rotacion_vias()
{
	

	suelo_via1 = getEnt("suelo_via1", "targetname");
	stop1_via1 = getEnt("stop1_via1", "targetname");
	stop2_via1 = getEnt("stop2_via1", "targetname");
	stop3_via1 = getEnt("stop3_via1", "targetname");
	via1 = getEnt("via1", "targetname");
	suelo_via1 EnableLinkTo();
	stop1_via1 EnableLinkTo();
	stop2_via1 EnableLinkTo();
	stop3_via1 EnableLinkTo();
	suelo_via1 LinkTo(via1);
	stop1_via1 LinkTo(via1);
	stop2_via1 LinkTo(via1);
	stop3_via1 LinkTo(via1);

	suelo_via2 = getEnt("suelo_via2", "targetname");
	stop1_via2 = getEnt("stop1_via2", "targetname");
	stop2_via2 = getEnt("stop2_via2", "targetname");
	stop3_via2 = getEnt("stop3_via2", "targetname");
	via2 = getEnt("via2", "targetname");
	suelo_via2 EnableLinkTo();
	stop1_via2 EnableLinkTo();
	stop2_via2 EnableLinkTo();
	stop3_via2 EnableLinkTo();
	suelo_via2 LinkTo(via2);
	stop1_via2 LinkTo(via2);
	stop2_via2 LinkTo(via2);
	stop3_via2 LinkTo(via2);

	carrito = getEnt("carrito", "targetname");
	level.posicion_rotacion_vias = 1;
	/*
	1-> salida 1
	2-> entrada 1
	3-> salida 2
	4-> entrada 2
	*/
	level.vias_rotando = false;
	level waittill ("palanca_colocada");
	trig = getEnt("palanca_trig_2", "targetname");
	trig SetCursorHint("HINT_NOICON");
	trig SetHintString( "Hold ^3&&1^7 to activate mechanism..." );
	while(1)
	{
		trig waittill( "trigger", player );
		if (level.tramo_carrito == 2)
		{
			carrito EnableLinkTo();
			carrito LinkTo(via1);
			thread cambiar_movimiento_carrito();
		}
		if (level.tramo_carrito == 4)
		{
			carrito EnableLinkTo();
			carrito LinkTo(via2);
			thread cambiar_movimiento_carrito();
		}
		level.vias_rotando = true;
		wait(0.25);
		via1 RotateYaw(90,1.5);
		via2 RotateYaw(90,1.5);
		PlaySoundAtPosition("girar_piedra",via1.origin);
		PlaySoundAtPosition("girar_piedra",via2.origin);
		wait(1.7);
		if (level.posicion_rotacion_vias<=3)
		{
			level.posicion_rotacion_vias ++;
		}
		else
		{
			level.posicion_rotacion_vias = 1;
		}
		carrito Unlink();
		level.vias_rotando = false;

	}


}
function movimiento_carro()
{
	self endon ("descenso_carrito");
	carrito = getEnt("carrito", "targetname");
	carrito_clip_zmb = getEnt("carrito_clip_zmb", "targetname");
	clip = getEnt("carrito_clip", "targetname");
	trig_use = getEnt("carrito_trig_use", "targetname");
	trig_multiple = getEnt("carrito_trig_multiple", "targetname");
	trig_use SetHintString( "Hold ^3&&1^7 and push to move the cart" ); 
	trig_use SetCursorHint("HINT_NOICON");

	carrito_clip_zmb EnableLinkTo();
	carrito_clip_zmb LinkTo(carrito);
	clip EnableLinkTo();
	clip LinkTo(carrito);
	trig_use EnableLinkTo();
	trig_use LinkTo(carrito);
	trig_multiple EnableLinkTo();
	trig_multiple LinkTo(carrito);
	thread detectar_tramo(carrito);
	level.carrito_en_X = true;

	while(1)
	{
		trig_use waittill( "trigger", player );
		pos_j = player.origin; //jugador
		pos_c = carrito.origin; //carrito
		sonido_model = Spawn("script_model", carrito.origin);
   		sonido_model SetModel("tag_origin");
   		sonido_model EnableLinkTo();
		sonido_model LinkTo(carrito);
		sonido_model PlayLoopSound("carritoloop");
		sonido_model thread borrar_en_descenso();
		if (level.carrito_en_X == true)
		{
			dif = pos_c[0]-pos_j[0];
			while(( player UseButtonPressed() ) && (carrito_toca_limite() == false) && (level.vias_rotando == false))
			{
				clip SetInvisibleToPlayer(player);
				if (player IsTouching(trig_multiple))
				{
					posicion = player.origin;
					mover = dif + posicion[0];
					carrito MoveTo((mover,pos_c[1],pos_c[2]),0.1);
					WAIT_SERVER_FRAME;
				}
				WAIT_SERVER_FRAME;

			}
			clip SetVisibleToAll();
			thread recolocar_carrito(carrito);
		}
		else
		{
			dif = pos_c[1]-pos_j[1];
			while(( player UseButtonPressed() ) && (carrito_toca_limite() == false) && (level.vias_rotando == false))
			{
				clip SetInvisibleToPlayer(player);
				if (player IsTouching(trig_multiple))
				{
					posicion = player.origin;
					mover = dif + posicion[1];
					carrito MoveTo((pos_c[0],mover,pos_c[2]),0.1);
					WAIT_SERVER_FRAME;
				}
				WAIT_SERVER_FRAME;

			}
			clip SetVisibleToAll();
			thread recolocar_carrito(carrito);
		}
		sonido_model Delete();
		
		
	}


}

function carrito_toca_limite()
{
	toca = false;
	carrito = getEnt("carrito", "targetname");
	limites = array("stop1_via1","stop2_via1","stop3_via1","stop1_via2","stop2_via2","stop3_via2","stop_pared_via","volume2_via_1","volume3_via_1","volume2_via_2","volume4_via_2"); 
		for ( i = 0; i < limites.size; i++ )
				{
					limite[i] = getEnt(limites[i], "targetname");
					if (carrito IsTouching(limite[i]))
					{
						toca = true;
					}
				}
	return toca;
}
function recolocar_carrito(carrito)
{
	toca = false;
	wait(0.1);
	carrito = getEnt("carrito", "targetname");
	limites = array("stop1_via1","stop2_via1","stop3_via1","stop1_via2","stop2_via2","stop3_via2","stop_pared_via"); 
		for ( i = 0; i < limites.size; i++ )
				{
					limite[i+1] = getEnt(limites[i], "targetname");
					if (carrito IsTouching(limite[i]))
					{
						toca = true;
					}
				}
	volumenes = array("volume1_via_1","volume2_via_1","volume3_via_1","volume4_via_1","volume1_via_2","volume2_via_2","volume3_via_2","volume4_via_2"); 
		for ( i = 0; i < volumenes.size; i++ )
				{
					volumen[i+1] = getEnt(volumenes[i], "targetname");
			}
				
		if ( level.tramo_carrito == 1)
		{
			if (carrito IsTouching(limite[7]))
			{
				carrito MoveX(50,0.1); //si toca pared del principio
			}
			if ((carrito IsTouching(limite[1]))||(carrito IsTouching(limite[2]))||(carrito IsTouching(limite[3])))
			{
				carrito MoveX(-30,0.1);//si toca el stop desde el tramo 1
			}
		}
		if ( level.tramo_carrito == 2)
		{
			if (carrito IsTouching(limite[2]))
			{
				if (level.posicion_rotacion_vias == 1)
				{
					carrito MoveY(30,0.1); 
				}
				if (level.posicion_rotacion_vias == 2)
				{
					carrito MoveX(-30,0.1); 
				}
				if (level.posicion_rotacion_vias == 3)
				{
					carrito MoveY(-30,0.1); 
				}
				if (level.posicion_rotacion_vias == 4)
				{
					carrito MoveX(30,0.1); 
				}
			}
			else
			{
				if (carrito IsTouching(volumen[2]))
				{
					carrito MoveX(-30,0.1); 
				}
				if (carrito IsTouching(volumen[3]))
				{
					carrito MoveY(30,0.1); 
				}
			}			
		}
		if ( level.tramo_carrito == 3)
		{
			if ((carrito IsTouching(limite[1]))||(carrito IsTouching(limite[2]))||(carrito IsTouching(limite[3])))
			{
				carrito MoveY(30,0.1);//si toca el stop desde el tramo 1
			}
			if ((carrito IsTouching(limite[4]))||(carrito IsTouching(limite[5]))||(carrito IsTouching(limite[6])))
			{
				carrito MoveY(-30,0.1);//si toca el stop desde el tramo 1
			}
		}
		if ( level.tramo_carrito == 4)
		{
			if (carrito IsTouching(limite[5]))
			{
				if (level.posicion_rotacion_vias == 1)
				{
					carrito MoveX(30,0.1); 
				}
				if (level.posicion_rotacion_vias == 2)
				{
					carrito MoveY(30,0.1); 
				}
				if (level.posicion_rotacion_vias == 3)
				{
					carrito MoveX(-30,0.1); 
				}
				if (level.posicion_rotacion_vias == 4)
				{
					carrito MoveY(-30,0.1); 
				}
			}
			else
			{
				if (carrito IsTouching(volumen[6]))
				{
					carrito MoveX(-30,0.1); 
				}
				if (carrito IsTouching(volumen[8]))
				{
					carrito MoveY(-30,0.1); 
				}
			}
		}
		if ( level.tramo_carrito == 5)
		{
			if ((carrito IsTouching(limite[4]))||(carrito IsTouching(limite[5]))||(carrito IsTouching(limite[6])))
			{
				carrito MoveX(-30,0.1);//si toca el stop desde el tramo 1
			}
		}
		wait(0.1);
		

	
}
function detectar_tramo(carrito)
{

	level.tramo_carrito = 1;
	LIM_1_2=749;
	LIM_2_3=-1932;
	LIM_3_4=-1589;
	/*
	1->primera via
	2->rotacion 1
	3->segunda via
	4->rotacion 2
	5-> tercera via
	*/
	while(1)
	{
		WAIT_SERVER_FRAME;
		posicion = carrito.origin;
		if (level.tramo_carrito == 1)
		{
			if(posicion[0]>=LIM_1_2)
			{
				level.tramo_carrito = 2;
			}
		}
		if (level.tramo_carrito == 2)
		{
			if(posicion[0]<=LIM_1_2)
			{
				level.tramo_carrito = 1;
			}
			if(posicion[1]>=LIM_2_3)
			{
				level.tramo_carrito = 3;
			}
		}
		if (level.tramo_carrito == 3)
		{
			if(posicion[1]<=LIM_2_3)
			{
				level.tramo_carrito = 2;
			}
			if(posicion[1]>=LIM_3_4)
			{
				level.tramo_carrito = 4;
			}
		}
		if (level.tramo_carrito == 4)
		{
			if(posicion[1]<=LIM_3_4)
			{
				level.tramo_carrito = 3;
			}
			if(posicion[0]<=LIM_1_2)
			{
				level.tramo_carrito = 5;
			}
		}
		if (level.tramo_carrito == 5)
		{
			if(posicion[0]>=LIM_1_2)
			{
				level.tramo_carrito = 4;
			}
		}

	}
}
function cambiar_movimiento_carrito()
{
	if (level.carrito_en_X == true)
	{
		level.carrito_en_X = false;
		
	}
	else
	{
		level.carrito_en_X = true;
	}
}
function descenso_carrito()
{
	carrito = getEnt("carrito", "targetname");
	carrito_pos_i = getEnt("carrito_pos_i", "targetname");
	carrito_pos_m = getEnt("carrito_pos_m", "targetname");
	carrito_pos_f = getEnt("carrito_pos_f", "targetname");
	carrito_pos_i SetInvisibleToAll();
	carrito_pos_m SetInvisibleToAll();
	carrito_pos_f SetInvisibleToAll();
	trig = getEnt("trig_final_carrito", "targetname");
	pos_final_puerta_carro_1 = getEnt("puerta_carro_f1", "targetname");
	pos_final_puerta_carro_2 = getEnt("puerta_carro_f2", "targetname");
	pos_final_puerta_carro_3 = getEnt("puerta_carro_f3", "targetname");
	pos_final_puerta_carro_1 SetInvisibleToAll();
	pos_final_puerta_carro_2 SetInvisibleToAll();
	pos_final_puerta_carro_3 SetInvisibleToAll();
	while(1)
	{
		WAIT_SERVER_FRAME;
		if (carrito IsTouching(trig))
		{
			level notify ("descenso_carrito");
			carrito MoveTo(carrito_pos_i.origin,0.5);
			carrito RotateTo(carrito_pos_i.angles,0.5);
			wait(0.52);
			carrito MoveTo(carrito_pos_m.origin,3,2,0.1);
			carrito RotateTo(carrito_pos_m.angles,3,2,0.1);
			wait(3);
			carrito MoveTo(carrito_pos_f.origin,0.3,0.1,0.1);
			carrito RotateTo(carrito_pos_f.angles,0.3,0.1,0.1);
			wait(0.3);
			puerta_carro_1 = getEnt("puerta_carro_1", "targetname");
			puerta_carro_2 = getEnt("puerta_carro_2", "targetname");
			puerta_carro_3 = getEnt("puerta_carro_3", "targetname");
				clip_puerta_carrito = getEnt("clip_puerta_carrito", "targetname");
				clip = getEnt("carrito_clip", "targetname");
				carrito_clip_zmb = getEnt("carrito_clip_zmb", "targetname");
				trig_use = getEnt("carrito_trig_use", "targetname");
				trig_multiple = getEnt("carrito_trig_multiple", "targetname");
			puerta_carro_1 MoveTo(pos_final_puerta_carro_1.origin,0.5);
			puerta_carro_2 MoveTo(pos_final_puerta_carro_2.origin,0.5);
			puerta_carro_3 MoveTo(pos_final_puerta_carro_3.origin,0.5);
			puerta_carro_1 RotateTo(pos_final_puerta_carro_1.angles,0.5);
			puerta_carro_2 RotateTo(pos_final_puerta_carro_2.angles,0.5);
			puerta_carro_3 RotateTo(pos_final_puerta_carro_3.angles,0.5);
			fxModel = Spawn("script_model", carrito.origin);
   			fxModel SetModel("tag_origin");
		    fx = PlayFXOnTag("explosions/fx_exp_grenade_wood", fxModel, "tag_origin");
		    PlaySoundAtPosition("romper_madera",carrito.origin);
			carrito Delete();
				clip Delete();
				clip_puerta_carrito Delete();
				carrito_clip_zmb Delete();
				trig_use Delete();
				trig_multiple Delete();
				flag::init("flag45");
    			flag::set("flag45");
			level notify("puerta_carrito_abierta");
			break;
		}
	}

}
function borrar_en_descenso()
{
	level waittill ("puerta_carrito_abierta");
	self Delete();
}


/*................................................................................
...................................................................................
PUZZLE BALANCIN             PUZZLE BALANCIN            PUZZLE BALANCIN
..................................................................................
...................................................................................*/

function puzzle_balancin()
{
	balanza_puente = getEnt("balanza_puente", "targetname");
	balanza_palo_puente = getEnt("balanza_palo_puente", "targetname");
	balanza_zombies = getEnt("balanza_zombies", "targetname");
	balanza_palo_zombies = getEnt("balanza_palo_zombies", "targetname");
	trig = getEnt("trigger_balanza", "targetname");
	balanza_puente MoveZ(-300,0.1);
	balanza_palo_puente MoveZ(-300,0.1);
	
	while(1)
            {
            	numero_zmbs = 0;
                a_zombies = getAITeamArray( level.zombie_team );
                 foreach(ai in a_zombies)
                   {
                   	if (ai IsTouching(trig))
                   	{
                   		numero_zmbs ++;
                   	}
           	       }
           	      if (numero_zmbs >= 7)
           	      {
           	      	for( i = 1; i < 5; i++ )
						{
							balanza_zombies MoveX(5,0.1);
							balanza_palo_zombies MoveX(5,0.1);
							wait(0.15);
							balanza_zombies MoveX(-5,0.1);
							balanza_palo_zombies MoveX(-5,0.1);
							wait(0.15);
						}
					balanza_puente MoveZ(300,2,0.1,1);
					balanza_zombies MoveZ(-300,2,0.1,1);
					balanza_palo_puente MoveZ(300,2,0.1,1);
					balanza_palo_zombies MoveZ(-300,2,0.1,1);
					a_zombies = getAITeamArray( level.zombie_team );
					flag::init("flag89");
    				flag::set("flag89");
             		

					break;
           	      }
                wait 0.05;
            }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PUZZLE PUERTA SIMBOLOS DISPARABLES           PUZZLE PUERTA SIMBOLOS DISPARABLES       PUZZLE PUERTA SIMBOLOS DISPARABLES//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function puzzle_puerta_simbolos_disparables()
{
	level.ppsd_contador = 0;
	for (i = 1; i < 6; i++)
			{
				simbolo_azul = GetEnt("puerta_simbolo_azul_" + i, "targetname");
				simbolo_azul SetInvisibleToAll();
				thread ppsd_disparable(i);
			}
	level waittill ( "ppsd_bajar_puerta");
	for (i = 1; i < 6; i++)
			{
				simbolo_azul = GetEnt("puerta_simbolo_azul_" + i, "targetname");
				simbolo_azul MoveZ(-500,2);
			}
	ppsd_pared = GetEnt("ppsd_pared", "targetname");
	ppsd_pared MoveZ(-500,2);

}

function ppsd_disparable(i)
{
	simbolo_azul = GetEnt("puerta_simbolo_azul_" + i, "targetname");
	simbolo_rojo = GetEnt("puerta_simbolo_rojo_" + i, "targetname");
	simbolo_disparable = GetEnt("puerta_simbolo_disparable_" + i, "targetname");
	simbolo_disparable SetCanDamage(1);
	while(1)
	{
		simbolo_disparable waittill( "damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel );
		if ( zm_weapons::is_weapon_upgraded( weapon ))
		{
			simbolo_disparable Delete();
			simbolo_azul SetVisibleToAll();
			simbolo_rojo SetInvisibleToAll();
			level.ppsd_contador ++;
			if (level.ppsd_contador >= 5)
			{
				level notify ("ppsd_bajar_puerta");
			}
			break;
		}
	}
    
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PUZZLE VISTA           PUZZLE VISTA      PUZZLE VISTA
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function puzzle_vista()
{
	level.pv_marcado = 0;
	thread pv_trig("pv_trig_0",0);
	thread pv_trig("pv_trig_1",1);
	thread pv_trig("pv_trig_2",2);
	thread pv_trig("pv_trig_3",3);
	pv_barrera_1 = getEnt("pv_barrera_1", "targetname");
	pv_barrera_2 = getEnt("pv_barrera_2", "targetname");
	pv_barrera_clip = getEnt("pv_barrera_clip", "targetname");
	while(1)
	{
		level waittill ("pv_marcado");
		pv1 = level.pv_marcado;
		PlaySoundAtPosition("seleccionar",pv_barrera_clip.origin);
		level waittill ("pv_marcado");
		pv2 = level.pv_marcado;
		PlaySoundAtPosition("seleccionar",pv_barrera_clip.origin);
		level waittill ("pv_marcado");
		pv3 = level.pv_marcado;
		if ((pv1 ==1) && (pv2 ==2) && (pv3 == 3))
		{
			PlaySoundAtPosition("girar_piedra",pv_barrera_1.origin);
			pv_barrera_1 MoveZ(-120,1);
			pv_barrera_2 MoveZ(-120,1);
			pv_barrera_clip Delete();
			break;
		}
		else
		{
			PlaySoundAtPosition("error",pv_barrera_clip.origin);
		}
	}
}


function pv_trig(name,i)
{
	trig = getEnt(name, "targetname");
	while(1)
	{
		trig waittill( "trigger", player );	
		level.pv_marcado = i;
		level notify ("pv_marcado");
		wait(0.5);
	}
	
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SONIC APAGA FUEGO                SONIC APAGA FUEGO                      SONIC APAGA FUEGO
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function sonic_apaga_llamas()
{

	sensor_grito = getEnt("sensorgrito", "targetname");
	for( i = 1; i < 7; i++ )
		{
			fx_model = getEnt("fx_fuego_"+i, "targetname");
			notificacion = "apagar_fuego_" + i;
			thread PlayFxWithCleanup("dlc3/stalingrad/fx_fire_inferno_tall_1_evb_md_stalingrad",fx_model.origin,fx_model.angles,notificacion);
		}
	fxModel = Spawn("script_model", sensor_grito.origin);
    fxModel SetModel("tag_origin");
	fxModel PlayLoopSound("small_fire");
	while(1)
	{
		level waittill ("sonic_scream");
		//IPrintLnBold("sonicscream");
		sonic_zombie = level.sonic_zombie;
		if (sensor_grito _in_blur_area( sonic_zombie ))
		{
			//IPrintLnBold("apaga fuego");
			fuego_hurt = getEnt("fuego_hurt", "targetname");
			fuego_hurt Delete();
			for( i = 1; i < 7; i++ )
			{
			notificacion = "apagar_fuego_" + i;
			level notify (notificacion);
			fxModel Delete();
			wait(0.2);
			}

		}
		else
		{
			//IPrintLnBold("no apaga fuego");
		}

	}
}
function PlayFxWithCleanup(fx, origin,angles, notification)
{
	
    fxModel = Spawn("script_model", origin);
    fxModel SetModel("tag_origin");
    fxModel RotateTo(angles,0.1);
    wait(0.2);
    
    fx = PlayFXOnTag(fx, fxModel, "tag_origin");
    level waittill(notification);
    fxModel StopLoopSound();
    fxModel Delete();

    if (isdefined(fx))
        fx Delete();
}


function _in_blur_area( sonic_zombie )
{
	if ( ( abs( self.origin[ 2 ] - sonic_zombie.origin[ 2 ] ) ) > 70 )
		return 0;
	
	radiussqr = level.sonicscreamdamageradius * level.sonicscreamdamageradius;
	if ( distance2dSquared( self.origin, sonic_zombie.origin ) > radiussqr )
		return 0;
	
	dirtosensor = self.origin - sonic_zombie.origin;
	dirtosensor = vectorNormalize( dirtosensor );
	sonicdir = anglesToForward( sonic_zombie.angles );
	dot = vectorDot( dirtosensor, sonicdir );
	if ( dot < .4 )
		return 0;
	
	return 1;
}

/* ////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
 MISIONES EGIPTO                 MISIONES EGIPTO                   MISIONES EGIPTO       
 ////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////*/

function misiones_egipto()
{
	trig = getEnt("trig_final", "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to escape " ); 
	trig SetCursorHint("HINT_NOICON");
	trig SetInvisibleToAll();

	trig_mult_final = getEnt("trig_mult_final", "targetname");
	
	level flag::wait_till("initial_blackscreen_passed");
	level.misiones_egipto_hechas = 0;
	exploder::exploder_stop("light_mision1");
	exploder::exploder_stop("light_mision2");
	exploder::exploder_stop("light_mision3");
	exploder::exploder_stop("light_mision4");
	exploder::exploder_stop("light_mision5");
	exploder::exploder_stop("light_mision6");
	exploder::exploder_stop("light_mision7");
	exploder::exploder_stop("light_mision8");
	thread mision_egipto_1();
	thread mision_egipto_2();
	thread mision_egipto_3();
	thread mision_egipto_4();
	thread mision_egipto_5();
	thread mision_egipto_6();
	thread mision_egipto_7();
	thread mision_egipto_8();
	while (1)
	{
		level waittill ("mision completada");
		if (level.misiones_egipto_hechas == 8)
		{
			trig_mult_final	waittill( "trigger", player );	
			thread dialogo_final();	
			trig SetVisibleToAll();
			trig waittill( "trigger", player );
			level.custom_game_over_hud_elem = &function_f7b7d070;
			level notify("end_game");
		}
	}
}
function dialogo_final()
{
	txt1 = "You have lifted the curse; soon the curse will end. My people and I are grateful to you.";
	txt2 = " Escape before the wrath of the gods falls upon you.";
	if (level.idioma == "SPANISH")
		{
		txt1 = "Has liberado la maldición; pronto la maldicion terminará. Mi pueblo y yo te estamos agradecidos.";
		txt2 = "Escapa antes de que la ira de los dioses cargue contra vosotros.";
		}
	if (level.idioma == "FRENCH")
		{
		txt1 = "Tu as levé la malédiction ; bientôt la malédiction prendra fin. Mon peuple et moi te sommes reconnaissants.";
		txt2 = "Échappe-toi avant que la colère des dieux ne s'abatte sur vous.";
		}
	if (level.idioma == "PORTUGUESE") 
		{
		txt1 = "Você levantou a maldição; em breve a maldição terminará. Meu povo e eu estamos gratos a você. ";
		txt2 = "Escape antes que a ira dos deuses se abata sobre você.";
		}
	thread playsoundok("dialogo_final");
		thread CreateIntroText("^6 Pharaoh: ^7" + txt1, 400,75,2,12,1);
		thread CreateIntroText(txt2, 400,55,2,12,1);
		wait(12);
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
	txt1= "Support the map in the workshop! To be continued...";
	game_over SetText(txt1);

	game_over FadeOverTime( 1 );
	game_over.alpha = 1;
	if ( player isSplitScreen() )
	{
		game_over.fontScale = 2;
		game_over.y += 40;
	}
}
function mision_egipto_1() //usar el pap
{
	trig = getEnt("trig_mision1", "targetname");
	trig SetHintString( "^3Mision:^7 Use the Pack a Punch Machine" ); 
	trig SetCursorHint("HINT_NOICON");

	 foreach(player in GetPlayers())
			{
   				 player thread esperar_a_pap();
			}
	level waittill ("arma mejorada");

	level.misiones_egipto_hechas ++;
	exploder::exploder("light_mision1");
	wait(0.5);
	level notify ("mision completada");

}
function esperar_a_pap()
{
	self waittill ( "pap_taken" );
	level notify ("arma mejorada");
}

function mision_egipto_2() //conseguir el arma especial
{
	trig = getEnt("trig_mision2", "targetname");
	trig SetHintString( "^3Mision:^7 Unlock Serket's Kiss" ); 
	trig SetCursorHint("HINT_NOICON");

	 foreach(player in GetPlayers())
			{
   				 player thread esperar_a_serket_kiss();
			}
	level waittill ("serket kiss obtenida");
	level.misiones_egipto_hechas ++;
	exploder::exploder("light_mision2");
	wait(0.5);
	level notify ("mision completada");

}
function esperar_a_serket_kiss()
{
	weapon = GetWeapon( "death_orion_upgraded" );
	while(1)
	{
		WAIT_SERVER_FRAME;
		arma_actual = self GetCurrentWeapon();
		if ( arma_actual == weapon )
		{
			level notify ("serket kiss obtenida");
			break;
		}
	}
}
function mision_egipto_3() //disparables
{
	alldisparables = GetEntArray("disparable", "targetname");

	trig = getEnt("trig_mision3", "targetname");
	trig SetHintString( "^3Mision:^7 Shoot all shootables (ceramic vase) 0/" + alldisparables.size); 
	trig SetCursorHint("HINT_NOICON");
	level.disparables_disparados = 0;

	foreach (disparable in alldisparables)
	{
		disparable thread esperar_a_ser_disparado();
	}
	while (1)
	{
		level waittill ("disparable_roto");
		IPrintLnBold(level.disparables_disparados + "/" + alldisparables.size);
		trig SetHintString( "^3Mision:^7 Shoot all shootables " + level.disparables_disparados + "/" + alldisparables.size); 
		if (level.disparables_disparados >= alldisparables.size)
		{			
			level.misiones_egipto_hechas ++;
			exploder::exploder("light_mision3");
			wait(0.5);
			level notify ("mision completada");
			break;
		}
	}
}

function esperar_a_ser_disparado()
{
	self waittill("trigger", player);
	modelo_target = GetEnt(self.target, "targetname");
	modelo_target Delete();
	level.disparables_disparados ++;
	level notify ("disparable_roto");

}

function mision_egipto_4() //consigue los monos bomba
{
	trig = getEnt("trig_mision4", "targetname");
	trig SetHintString( "^3Mision:^7 Get Monkey Bombs" ); 
	trig SetCursorHint("HINT_NOICON");

	 foreach(player in GetPlayers())
			{
   				 player thread esperar_a_monkeybombs();
			}
	level waittill ("monos obtenidos");

	level.misiones_egipto_hechas ++;
	exploder::exploder("light_mision4");
	wait(0.5);
	level notify ("mision completada");

}
function esperar_a_monkeybombs()
{
	self waittill("starting_monkey_watch");
	level notify ("monos obtenidos");
}

function mision_egipto_5() //completa las almas
{
	NUMERO_DE_SOULBOXES = 3;
	trig = getEnt("trig_mision5", "targetname");
	trig SetHintString( "^3Mision:^7 Complete all soulboxes 0/" + NUMERO_DE_SOULBOXES); 
	trig SetCursorHint("HINT_NOICON");
	level.almas_llenas = 0;

	for( i = 1; i < 4; i++ )
	{
		thread esperar_a_llenar(i);
	}

	while(1)
	{
		level waittill ("alma_llena");
		trig SetHintString( "^3Mision:^7 Complete all soulboxes " + level.almas_llenas + "/" + NUMERO_DE_SOULBOXES); 
		if (level.almas_llenas >= NUMERO_DE_SOULBOXES)
		{			
			level.misiones_egipto_hechas ++;
			exploder::exploder("light_mision5");
			wait(0.5);
			level notify ("mision completada");
			break;
		}
	}
}
function esperar_a_llenar(i)
{
	level.grow_soul_start_scale = 0.3;//starting scale of model
	level.grow_soul_growth = 0.01;//growth per zombie
	level.grow_soul_size = 0.5;//how big you want it to get scale wise
	almas =("almas_" + i);
	thread cargar_almas(almas);
	level waittill (almas + "_allgrowsouls");
	modelo = getEnt(almas, "targetname");
	modelo Delete();
	level.almas_llenas ++;
	level notify ("alma_llena");

}
function cargar_almas(system)
{
		grow_soul::SetUpReward(system);  //esto es para activar las almas del pulsador 1
		grow_soul::WatchZombies();
}

function mision_egipto_6() //estar vivos 
{
	RONDA_EMPEZAR = 15;
	trig = getEnt("trig_mision6", "targetname");
	trig SetHintString( "^3Mision:^7 Stay alive for 3 rounds in a row (starts counting at round "+ RONDA_EMPEZAR + ")" ); 
	trig SetCursorHint("HINT_NOICON");
	for( i = 1; i < RONDA_EMPEZAR; i++ )
	{
		level waittill ("end_of_round");
	}
	 foreach(player in GetPlayers())
			{
   				 player thread check_3_rounds_in_a_row();
			}
	level waittill ("mision6_completada");
	level.misiones_egipto_hechas ++;
	exploder::exploder("light_mision6");
	wait(0.5);
	level notify ("mision completada");

}
function check_3_rounds_in_a_row()
{
	self endon ("player_down");
	self thread check_dead();
	level waittill ("end_of_round");
	wait(1);
	level waittill ("end_of_round");
	wait(1);
	level waittill ("end_of_round");
	level notify ("mision6_completada");
}
function check_dead()
{
	while(1)
	{
		wait(2);
		if(self.sessionstate == "spectator")
                {
                    self notify ("player_down");
                    level waittill ("end_of_round");
                    wait(1);
                    self thread check_3_rounds_in_a_row();
                    break;
                }
        if(self laststand::player_is_in_laststand())
        		{
                    self notify ("player_down");
                    level waittill ("end_of_round");
                    wait(1);
                    self thread check_3_rounds_in_a_row();
                    break;
                }
	}
}

function mision_egipto_7() //textos del faraon
{
	trig = getEnt("trig_mision7", "targetname");
	trig SetHintString( "^3Mision:^7 Translate pharaoh's writings" ); 
	trig SetCursorHint("HINT_NOICON");
	level.textos_traducidos = 0;
	 for( i = 1; i < 4; i++ )
	{
		thread traducir_escritura(i);
	}
	while(1)
	{
		level waittill ("escritura_traducida");
		if (level.textos_traducidos >= 3)
		{
			level.misiones_egipto_hechas ++;
			exploder::exploder("light_mision7");
			wait(0.5);
			level notify ("mision completada");
			break;
		}
	}
}
function traducir_escritura(i)
{
	trig = getEnt("trig_texto_" + i, "targetname");
	trig SetHintString( "Press and Hold ^3&&1^7 to Translate Writing" ); 
	trig SetCursorHint("HINT_NOICON");
	texto = getEnt("texto" + i, "targetname");
	texto SetInvisibleToAll();
	trig waittill( "trigger", player );	
	texto SetVisibleToAll();
	trig Delete();
	level.textos_traducidos ++;
	level notify ("escritura_traducida");
}

function mision_egipto_8() //consigue los monos bomba
{
	trig = getEnt("trig_mision8", "targetname");
	trig SetHintString( "^3Mision:^7 Unlock Ra Perk" ); 
	trig SetCursorHint("HINT_NOICON");

	level waittill ("arma");

	level.misiones_egipto_hechas ++;
	exploder::exploder("light_mision8");
	wait(0.5);
	level notify ("mision completada");

}



////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//SLOW ZOMBIES PERK             SLOW ZOMBIES PERK         SLOW ZOMBIES PERK
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
function ra_perk()
{
	trig = getEnt("trig_raperk", "targetname");
	trig SetHintString( "Ra Perk needs to be activated." ); 
	trig SetCursorHint("HINT_NOICON");
	level waittill ("arma");
	trig SetHintString( "Press and Hold ^3&&1^7 to get Ra Perk (When you aim at a zombie it slows down)" );
	thread slow_zombies_perk();
	thread player_down();
	while(1)
	{
		trig waittill( "trigger", player );
		player_numb = player.characterindex; 
		level.has_slow_zombies_perk[player_numb]= true;
		player thread show_perk_image_hud("slow_zombie_perk");
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

function show_perk_image_hud(imagen) //self = player
{
	menu_perk = NewClientHudElem( self ); 
	menu_perk.alignX = "center";
	menu_perk.alignY = "center";
	menu_perk.horzAlign = "center";
	menu_perk.vertAlign = "center";
	
	menu_perk SetShader( imagen, 860, 480 ); //860 580 = full screen
	menu_perk.alpha = 1;  

	level waittill (self.playername + "dead");
	menu_perk FadeOverTime( 0.1 ); 
	menu_perk.alpha = 0; 
}

function player_down()
{
		while(1)
		{
			foreach(player in GetPlayers())
			{
                 if(player laststand::player_is_in_laststand())
                 {
                     level notify (player.playername + "dead");
                     player_numb = player.characterindex; 
                     level.has_slow_zombies_perk[player_numb]= false;                  
                 }
            }
            wait(0.5);
        }
}


//////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
///////// INTRO INTRO INTRO INTRO ///////////////////////////
//////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

function intro()
{
	level.idioma = "ENGLISH";
	level flag::wait_till("initial_blackscreen_passed");
	//Stop Spawning
    	level flag::clear( "spawn_zombies" );
	foreach(player in GetPlayers())
			{
   				 player thread show_imagen("egipto_hudintro1","quitar_hud_intro");
   				 thread CreateTextForPlayer(player,"Press ^1[{+melee}] ^7to change language.", 350,300,2,"empezar_cinematica");
   				 thread selector_idioma(player);
   				 thread empezar_partida(player);
			}
	
	
	foreach(player in GetPlayers())
			{
   				 thread cinematica_intro(player);
			}

	level waittill("empezar_cinematica");
	level.musica_sonando = false;
	thread tiempo_intro(120);
	thread playsoundok("intro_con_musica");
	thread subtitulos_intro();
	thread saltar_intro();

	level waittill ("start_game");
	foreach(player in GetPlayers())
			{
				player util::show_hud(1);
			}
	//Start zombies spawn
	level flag::set( "spawn_zombies" );

}
function subtitulos_intro()
{
	txt1 = "^6 Pharaoh: ^7I was a man who believed himself a god throughout his life.";
	txt2 = "I scorned and oppressed my subjects, thinking I was superior to them. But at the end of my days";
	txt3 = "I realized that, despite being the pharaoh, I was nothing more than a mere human. ";
	txt4 = "My dreams of immortality clouded my judgment, and I asked the Egyptian gods to become an eternal being.";
	if (level.idioma == "SPANISH")
				{
				txt1 = "^6Faraón: ^7Fui un hombre que se creyó un dios durante toda mi vida.";
				txt2 = "Desprecié y oprimí a mis súbditos, creyendo que era superior a ellos. ";
				txt3 = "Pero al final de mis días, me di cuenta de que, aunque era el faraon, no era más que un simple humano.";
				txt4 = "Mis sueños de inmortalidad nublaron mi juicio, y pedí a los dioses egipcios ser un ser eterno.";
				}
				if (level.idioma == "FRENCH")
				{
				txt1 = "^6Pharaon : ^7J'ai été un homme qui s'est cru un dieu toute ma vie.";
				txt2 = "J'ai méprisé et opprimé mes sujets, croyant être supérieur à eux.";
				txt3 = "Mais à la fin de mes jours, j'ai réalisé que, bien que je fusse le pharaon, je n'étais qu'un simple humain.";
				txt4 = "Mes rêves d'immortalité ont obscurci mon jugement, et j'ai demandé aux dieux égyptiens de devenir un être éternel.";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "^6Faraó: ^7Fui um homem que se acreditou um deus durante toda a minha vida.";
				txt2 = "Desprezei e oprimi meus súditos, acreditando ser superior a eles";
				txt3 = "Mas no final dos meus dias, percebi que, embora fosse o faraó, não passava de um simples humano.";
				txt4 = "Meus sonhos de imortalidade nublaram meu julgamento, e implorei aos deuses egípcios para ser um ser eterno.";
				}
	tiempo = 26;
	thread crear_texto(txt1,txt2,txt3,txt4,tiempo);
	wait(tiempo);
	txt1 = "^6 Pharaoh: ^7However, the gods, in their wisdom and fury, granted my wish as a punishment.";
	txt2 = "They sealed me alive in this pyramid, shattered my body, and condemned me to exist eternally without peace.";
	txt3 = "Moreover, the gods' wrath fell upon my people, turning them into cursed beings, ";
	txt4 = "wandering zombies condemned to roam these dark chambers.";
	if (level.idioma == "SPANISH")
				{
				txt1 = "^6Faraón: ^7Pero los dioses, en su sabiduría y furia, concedieron mi deseo como un castigo. ";
				txt2 = "Me encerraron vivo en esta pirámide, fragmentaron mi cuerpo y me condenaron a existir eternamente sin paz. ";
				txt3 = "Además, la ira de los dioses cayó sobre mi pueblo, convirtiéndolos en seres malditos, ";
				txt4 = "zombies errantes condenados a vagar por estas cámaras oscuras.";
				}
				if (level.idioma == "FRENCH")
				{
				txt1 = "^6Pharaon : ^7Mais les dieux, dans leur sagesse et leur colère, ont exaucé mon vœu comme une punition.";
				txt2 = "Ils m'ont enfermé vivant dans cette pyramide, ont fragmenté mon corps et m'ont condamné à exister éternellement sans paix.";
				txt3 = "De plus, la colère des dieux s'est abattue sur mon peuple, les transformant en êtres maudits,";
				txt4 = "des zombies errants condamnés à errer dans ces chambres sombres.";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "^6Faraó: ^7Mas os deuses, em sua sabedoria e fúria, atenderam meu desejo como uma punição.";
				txt2 = "Eles me aprisionaram vivo nesta pirâmide, fragmentaram meu corpo e me condenaram a existir eternamente sem paz.";
				txt3 = "Além disso, a ira dos deuses caiu sobre meu povo, transformando-os em seres amaldiçoados,";
				txt4 = "zumbis errantes condenados a vagar por estas câmaras escuras.";
				}
	tiempo = 28;
	thread crear_texto(txt1,txt2,txt3,txt4,tiempo);
	wait(tiempo);
	txt1 = "^6 Pharaoh: ^7Now, anyone who enters this pyramid will be cursed as well.";
	txt2 = "Yet, there is hope, a way to end this curse. Around this pyramid, there are magical statues.";
	txt3 = "If you manage to activate them, my soul will be freed, and the curse consuming my people will dissipate.";
	txt4 = "";
	if (level.idioma == "SPANISH")
				{
				txt1 = "^6Faraón: ^7Ahora, cualquiera que se adentre en esta pirámide será maldito también. ";
				txt2 = "Sin embargo, hay una esperanza, una forma de poner fin a esta maldición. Alrededor de esta pirámide, hay estatuas mágicas.";
				txt3 = "Si logras activarlas, mi alma será liberada, y la maldición que consume a mi pueblo se desvanecerá.";
				txt4 = "";
				}
				if (level.idioma == "FRENCH")
				{
				txt1 = "^6Pharaon : ^7Maintenant, quiconque pénètre dans cette pyramide sera également maudit.";
				txt2 = "Cependant, il y a un espoir, une façon de mettre fin à cette malédiction. Autour de cette pyramide, il y a des statues magiques.";
				txt3 = "Si vous parvenez à les activer, mon âme sera libérée, et la malédiction qui consume mon peuple disparaîtra";
				txt4 = "";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "^6Faraó: ^7Agora, qualquer um que entre nesta pirâmide também será amaldiçoado.";
				txt2 = "No entanto, há uma esperança, uma maneira de pôr fim a esta maldição. Ao redor desta pirâmide, existem estátuas mágicas.";
				txt3 = "Se você conseguir ativá-las, minha alma será libertada, e a maldição que consome meu povo desaparecerá.";
				txt4 = "";
				}
	tiempo = 22;
	thread crear_texto(txt1,txt2,txt3,txt4,tiempo);
	wait(tiempo);
	txt1 = "^6 Pharaoh: ^7But beware, brave adventurer, this pyramid is filled with dangers.";
	txt2 = "The undead, my former subjects, wander these halls. ";
	txt3 = "There are also traps and riddles you must solve to reach the statues. It is a daunting task,";
	txt4 = "but if you succeed, you will find a way to end this eternal nightmare.";
	if (level.idioma == "SPANISH")
				{
				txt1 = "^6Faraón: ^7Pero ten cuidado, valiente aventurero, esta pirámide está llena de peligros. ";
				txt2 = "Los no muertos, mis antiguos súbditos, vagan por estos pasillos. ";
				txt3 = "También hay trampas y acertijos que debes resolver para llegar a las estatuas. Es una tarea ardua,";
				txt4 = "pero si tienes éxito, encontrarás la manera de poner fin a esta pesadilla eterna.";
				}
				if (level.idioma == "FRENCH")
				{
				txt1 = "^6Pharaon : ^7Mais fais attention, courageux aventurier, cette pyramide est pleine de dangers.";
				txt2 = "Les morts-vivants, mes anciens sujets, errent dans ces couloirs.";
				txt3 = "Il y a aussi des pièges et des énigmes que vous devez résoudre pour atteindre les statues. C'est une tâche ardue,";
				txt4 = "mais si vous réussissez, vous trouverez le moyen de mettre fin à ce cauchemar éternel.";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "^6Faraó: ^7Mas tenha cuidado, valente aventureiro, esta pirâmide está cheia de perigos.";
				txt2 = "Os mortos-vivos, meus antigos súditos, vagam por esses corredores.";
				txt3 = "Há também armadilhas e enigmas que você deve resolver para chegar às estátuas. É uma tarefa árdua,";
				txt4 = "mas se você tiver sucesso, encontrará o meio de acabar com este pesadelo eterno.";
				}
	tiempo = 24;
	thread crear_texto(txt1,txt2,txt3,txt4,tiempo);
	wait(tiempo);
	txt1 = "^6 Pharaoh: ^7I wish you the best of luck on your quest to free us from this eternal curse.";
	txt2 = "May the gods guide you and grant you the strength to face the challenges that await you in this dark abode.";
	txt3 = "Go forth, intrepid adventurer! The fate of my soul and my people lies in your hands.";
	txt4 = "";
	if (level.idioma == "SPANISH")
				{
				txt1 = "^6Faraón: ^7Te deseo la mejor de las suertes en tu búsqueda para liberarnos de esta maldición eterna. ";
				txt2 = "Que los dioses te guíen y te otorguen la fuerza necesaria para enfrentar los desafíos que te esperan en esta oscura morada.";
				txt3 = "¡Adelante, intrépido aventurero! El destino de mi alma y mi pueblo yace en tus manos.";
				txt4 = "";
				}
				if (level.idioma == "FRENCH")
				{
				txt1 = "^6Pharaon : ^7Je te souhaite la meilleure des chances dans ta quête pour nous libérer de cette malédiction éternelle.";
				txt2 = "Que les dieux te guident et te donnent la force nécessaire pour affronter les défis qui t'attendent dans cette sombre demeure.";
				txt3 = "Allez, intrépide aventurier ! Le destin de mon âme et de mon peuple repose entre tes mains.";
				txt4 = "";
				}
				if (level.idioma == "PORTUGUESE")
				{
				txt1 = "^6Faraó: ^7Desejo-lhe a melhor sorte em sua busca por nos libertar desta maldição eterna.";
				txt2 = "Que os deuses o guiem e lhe concedam a força necessária para enfrentar os desafios que o aguardam nesta morada escura.";
				txt3 = "Avance, intrépido aventureiro! O destino da minha alma e do meu povo está em suas mãos.";
				txt4 = "";
				}
	tiempo = 19;
	thread crear_texto(txt1,txt2,txt3,txt4,tiempo);
	wait(tiempo);

}
function cinematica_intro(player)
{
	self endon ("intro_saltada");
	player util::show_hud(0);
	cin_1 = struct::get("cin_intro_1", "targetname");
	cin_2 = struct::get("cin_intro_2", "targetname");
	cin_3 = struct::get("cin_intro_3", "targetname");
	cin_4 = struct::get("cin_intro_4", "targetname");
	cin_5 = struct::get("cin_intro_5", "targetname");
	cin_6 = struct::get("cin_intro_6", "targetname");
	cin_7 = struct::get("cin_intro_7", "targetname");
	cin_8 = struct::get("cin_intro_8", "targetname");
	cin_9 = struct::get("cin_intro_9", "targetname");
	cin_10 = struct::get("cin_intro_10", "targetname");
	/*cin_11 = struct::get("cin_intro_11", "targetname");
	cin_12 = struct::get("cin_intro_12", "targetname");
	cin_13 = struct::get("cin_intro_13", "targetname");
	cin_14 = struct::get("cin_intro_14", "targetname");
	cin_15 = struct::get("cin_intro_15", "targetname");
	cin_16 = struct::get("cin_intro_16", "targetname");
	cin_17 = struct::get("cin_intro_17", "targetname");
	cin_18 = struct::get("cin_intro_18", "targetname");
	cin_19 = struct::get("cin_intro_19", "targetname");
	cin_20 = struct::get("cin_intro_20", "targetname");
	cin_21 = struct::get("cin_intro_21", "targetname");
	cin_22 = struct::get("cin_intro_22", "targetname");
	cin_23 = struct::get("cin_intro_23", "targetname");
	cin_24 = struct::get("cin_intro_24", "targetname");
	cin_25 = struct::get("cin_intro_25", "targetname");*/

	player lui::screen_fade_in(3);
    player CameraSetPosition(player GetTagOrigin("j_head"), player GetAngles());
    player CameraActivate(true);
    player FreezeControls(true);
    level waittill("empezar_cinematica");
	player CameraSetLookAt(cin_1);
    player CameraSetPosition(cin_1.origin, cin_1.angles);
    wait(0.1);
    
	
	player StartCameraTween(20);
	player CameraSetLookAt(cin_2);
    player CameraSetPosition(cin_2.origin, cin_2.angles);
    wait(20);

	player CameraSetLookAt(cin_3);
    player CameraSetPosition(cin_3.origin, cin_3.angles);
    wait(0.1);
	player StartCameraTween(20);
	player CameraSetLookAt(cin_4);
    player CameraSetPosition(cin_4.origin, cin_4.angles);
    wait(20);

	player CameraSetLookAt(cin_5);
    player CameraSetPosition(cin_5.origin, cin_5.angles);
    wait(0.1);
	player StartCameraTween(20);
	player CameraSetLookAt(cin_6);
    player CameraSetPosition(cin_6.origin, cin_6.angles);
    wait(20);

	player CameraSetLookAt(cin_7);
    player CameraSetPosition(cin_7.origin, cin_7.angles);
    wait(0.1);

    player StartCameraTween(18);
	player CameraSetLookAt(cin_8);
    player CameraSetPosition(cin_8.origin, cin_8.angles);
    wait(18);
    
	player CameraSetLookAt(cin_9);
    player CameraSetPosition(cin_9.origin, cin_9.angles);
    wait(0.1);
    player StartCameraTween(40);
	player CameraSetLookAt(cin_10);
    player CameraSetPosition(cin_10.origin, cin_10.angles);
    wait(35);
    player CameraSetPosition(player GetTagOrigin("j_head").origin, player GetTagOrigin("j_head").angles);
    wait(5);
    player CameraActivate(false);    
	player FreezeControls(false);
	player util::show_hud(1);
	level notify ("start_game");
	level notify ("alguien_salta_intro");

}
function saltar_intro()
{
	self endon ("start_game");
	level.jugadores_saltan_intro = 0;
	wait(5);
	foreach(player in GetPlayers())
			{
   				 thread control_saltar_intro(player);
			}
	while(1)
	{
		txt = "^3[{+activate}]^7 to skip cinemtatic ("+level.jugadores_saltan_intro+"/"+GetPlayers().size+")";
		if (level.idioma == "SPANISH")
				{
				txt1 = "^3[{+activate}]^7 para saltar la cinematica ("+level.jugadores_saltan_intro+"/"+GetPlayers().size+")";
				}
		thread CreateTextForPlayer(player,txt, 700,30,1,"alguien_salta_intro");
		level waittill ("alguien_salta_intro");
		if (level.jugadores_saltan_intro >= GetPlayers().size)
		{
			break;
		}
	}
	level notify ("intro_saltada");
	wait(0.1);
	cin_10 = struct::get("cin_intro_10", "targetname");
	foreach(player in GetPlayers())
			{
				player CameraSetLookAt(cin_10);
   				player CameraSetPosition(cin_10.origin, cin_10.angles);
   				player StartCameraTween(0.1);
				player CameraSetLookAt(cin_10);
    			player CameraSetPosition(cin_10.origin, cin_10.angles);
   				player CameraSetPosition(player GetTagOrigin("j_head").origin, player GetTagOrigin("j_head").angles); 
				player CameraActivate(false);
				player FreezeControls(false);
			}
	self util::show_hud(1);
	level notify ("start_game");

	
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
function control_saltar_intro(player)
{
	self endon ("start_game");
	a=false;
	wait(0.3);
		while(1)
		{
			WAIT_SERVER_FRAME;
			while( player UseButtonPressed() )
			{
				WAIT_SERVER_FRAME;
				a=true;
			}
			if (a==true)
			{
				break;
			}

		}
		level.jugadores_saltan_intro ++;
		level notify ("alguien_salta_intro");
}
function selector_idioma(player)
{
	self endon ("empezar_cinematica");
	level.idioma = "ENGLISH";
	thread mostrar_idioma(player);

	while(1)
		{
			WAIT_SERVER_FRAME;
			while( player MeleeButtonPressed() )
			{
					a=false;
					if(level.idioma == "ENGLISH")
					{
						level.idioma = "SPANISH";
						a=true;
					}
					if ((level.idioma == "SPANISH")&&(a==false))
					{
						level.idioma = "FRENCH";
						a=true;
					}
					if ((level.idioma == "FRENCH")&&(a==false))
					{
						level.idioma = "PORTUGUESE";
						a=true;
					}
					if ((level.idioma == "PORTUGUESE")&&(a==false))
					{
						level.idioma = "ENGLISH";
						a=true;
					}
				level notify ("cambio_idioma");
				wait(0.5);
			}

		}
}
function mostrar_idioma(player)
{
	self endon ("empezar_cinematica");
	wait(1);
	 i = player.characterindex;
    destinations[i] = struct::get( "despedida_teleport_" + i, "targetname" ); 
    player setorigin( destinations[i].origin );
    player setplayerangles( destinations[i].angles );
	while(1)
	{
		
		if(level.idioma == "ENGLISH")
					{						
						thread CreateTextForPlayer(player,"^6ENGLISH", 200,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"SPANISH", 300,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"FRENCH", 400,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"PORTUGUESE", 500,200,2,"cambio_idioma");
					}
		if(level.idioma == "SPANISH")
					{						
						thread CreateTextForPlayer(player,"ENGLISH", 200,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"^6SPANISH", 300,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"FRENCH", 400,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"PORTUGUESE", 500,200,2,"cambio_idioma");
					}
		if(level.idioma == "FRENCH")
					{						
						thread CreateTextForPlayer(player,"ENGLISH", 200,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"SPANISH", 300,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"^6FRENCH", 400,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"PORTUGUESE", 500,200,2,"cambio_idioma");
					}
		if(level.idioma == "PORTUGUESE")
					{						
						thread CreateTextForPlayer(player,"ENGLISH", 200,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"SPANISH", 300,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"FRENCH", 400,200,2,"cambio_idioma");
						thread CreateTextForPlayer(player,"^6PORTUGUESE", 500,200,2,"cambio_idioma");
					}
		level waittill ("cambio_idioma");

	}
	
}
function empezar_partida(player)
{
	wait(1);
	thread CreateTextForPlayer(player,"^3[{+activate}]^7 to start game", 350,100,2,"empezar_cinematica");
	a=false;
	while(1)
		{
			WAIT_SERVER_FRAME;
			while( player UseButtonPressed() )
			{
				a=true;
				WAIT_SERVER_FRAME;
			}
			if (a==true)
			{
				break;
			}
		}
	level notify ("empezar_cinematica");
	wait(0.2);
	level notify("cambio_idioma");
	wait(3);
	level notify("quitar_hud_intro");
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
	menu_perk FadeOverTime( 1 ); 
	menu_perk.alpha = 0; 
}
function sonido_ambiente()
{
	level.musica_sonando = false;
	level flag::wait_till( "initial_blackscreen_passed" );
	wait(60);
	while(1)
	{
		WAIT_SERVER_FRAME;
		if(level.musica_sonando == false)
		{
			thread playsoundok("musica_tension");
			wait(220);
			wait(20);
			thread playsoundok("musica_tension2");
			wait(92);
			wait(20);
			thread playsoundok("musica_tension3");
			wait(265);
			wait(20);

		}
	}
    
}

function tiempo_intro(t)
{
	level.musica_sonando = true;
	wait(t);
	wait(20);
	level.musica_sonando = false;
}
function eye_fx()
{
    self.no_eye_glow = true;
}
function no_zombies_help()
{
	trigs = GetEntArray("no_zombies", "targetname");
	foreach(trig in trigs)
	{
		//trig thread no_zombies();
	}
	
}
function no_zombies()
{
	model = GetEnt(self.target, "targetname");
	self SetInvisibleToAll();
	model SetInvisibleToAll();

	cost = 5000;

	level flag::wait_till( "initial_blackscreen_passed" );
	if (GetPlayers().size==1)
	{
		self SetVisibleToAll();
		model SetVisibleToAll();
		self SetCursorHint("HINT_NOICON");
		while(1)
		{	
			self SetHintString("Hold ^3&&1^7 for 3 minutes without zombies. Cost:"+ cost +" pts"); 
			self waittill("trigger", player);
			if(player.score < cost)
        		{
            	PlaySoundAtPosition("cc_hack_fail", self.origin);
            	wait 0.2;
            	continue;
       			}
       		player zm_score::minus_to_player_score(cost);
			IPrintLnBold("3 minutes without zombies starting now.You can return to reactivate the spawn.")
			thread tiempo_sin_zombies(180);
			thread forzar_no_spawn();
			self SetHintString("Hold ^3&&1^7 for reactivate spawn"); 
			thread trig_reactivar_spawn(self);
			level waittill ("reactivar_spawn_not");
			self SetHintString("Hold ^3&&1^7 for 3 minutes without zombies. Cost:"+ cost +" pts"); 
			level notify ("reactivar_spawn");
			wait(1);
			IPrintLnBold("empezar spawn");
			//Start zombies spawn
			level flag::set( "spawn_zombies" );

		}
	}
}
function forzar_no_spawn()
{
	self endon ("reactivar_spawn");
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
function tiempo_sin_zombies(t)
{
	self endon ("reactivar_spawn");
	wait(t);
	IPrintLnBold("fin tiempo");
	level notify("reactivar_spawn_not");
}
function trig_reactivar_spawn(trig)
{
	self endon ("reactivar_spawn");
	wait(0.5);
	self waittill("trigger", player);
	IPrintLnBold("Spawn manually reactivated.");
	level notify ("reactivar_spawn_not");
}
