import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/model/external/class_kill.dart';
import 'package:logstf/model/external/heal_spread.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/internal/match_type.dart';
import 'package:logstf/model/external/player.dart';
import 'package:logstf/util/application_localization.dart';

class LogHelper {
  static HashMap<String, String> _weaponNames = HashMap();
  static HashMap<String, String> _weaponImages = HashMap();

  static void _initWeaponNames() {
    _weaponNames["scattergun"] = "Scattergun";
    _weaponNames["maxgun"] = "Lugermorph";
    _weaponNames["pistol_scout"] = "Pistol";
    _weaponNames["soda_popper"] = "Soda Popper";
    _weaponNames["wrap_assassin"] = "Wrap Assassin";
    _weaponNames["the_winger"] = "Winger";
    _weaponNames["pep_brawlerblaster"] = "Baby Face's Blaster";
    _weaponNames["back_scatter"] = "Back Scatter";
    _weaponNames["pep_pistol"] = "Pretty Boy's Pocket Pistol";
    _weaponNames["world"] = "Env. death";
    _weaponNames["tf_projectile_rocket"] = "Rocket Launcher";
    _weaponNames["unique_pickaxe_escape"] = "Escape Plan";
    _weaponNames["blackbox"] = "Black Box";
    _weaponNames["rocketlauncher_directhit"] = "Direct Hit";
    _weaponNames["quake_rl"] = "Original";
    _weaponNames["market_gardener"] = "Market Gardener";
    _weaponNames["the_capper"] = "C.A.P.P.E.R";
    _weaponNames["boston_basher"] = "Boston Basher";
    _weaponNames["panic_attack"] = "Panic Attack";
    _weaponNames["scout_sword"] = "Three-Rune Blade";
    _weaponNames["shotgun_soldier"] = "Shotgun";
    _weaponNames["degreaser"] = "Degreaser";
    _weaponNames["flaregun"] = "Flare Gun";
    _weaponNames["scorch_shot"] = "Scorch Shot";
    _weaponNames["flamethrower"] = "Flamethrower";
    _weaponNames["powerjack"] = "Powerjack";
    _weaponNames["reserve_shooter"] = "Reserve Shooter";
    _weaponNames["phlogistinator"] = "Phlogistinator";
    _weaponNames["backburner"] = "Backburner";
    _weaponNames["loose_cannon"] = "Loose Cannon";
    _weaponNames["iron_bomber"] = "Iron Bomber";
    _weaponNames["loch_n_load"] = "Loch-n-load";
    _weaponNames["tf_projectile_pipe_remote"] = "Stickybomb Launcher";
    _weaponNames["scotland_shard"] = "Scottish Resistance";
    _weaponNames["sword"] = "Eyelander";
    _weaponNames["tf_projectile_pipe"] = "Grenade Launcher";
    _weaponNames["fryingpan"] = "Frying Pan";
    _weaponNames["quickiebomb_launcher"] = "Quickiebomb Launcher";
    _weaponNames["nonnonviolent_protest"] = "Conscientious Objector";
    _weaponNames["tide_turner"] = "Tide Turner";
    _weaponNames["skullbat"] = "Bat Outta Hell";
    _weaponNames["force_a_nature"] = "Force-A-Nature";
    _weaponNames["brass_beast"] = "Brass Beast";
    _weaponNames["tomislav"] = "Tomislav";
    _weaponNames["iron_curtain"] = "Iron Curtain";
    _weaponNames["family_business"] = "Family Business";
    _weaponNames["minigun"] = "Minigun";
    _weaponNames["gloves_running_urgently"] = "G.R.U.";
    _weaponNames["shotgun_primary"] = "Shotgun";
    _weaponNames["giger_counter"] = "Giger Counter";
    _weaponNames["obj_minisentry"] = "Minisentry";
    _weaponNames["obj_sentrygun3"] = "Sentry gun level 3";
    _weaponNames["obj_sentrygun2"] = "Sentry gun level 2";
    _weaponNames["obj_sentrygun"] = "Sentry gun level 1";
    _weaponNames["rescue_ranger"] = "Rescue Ranger";
    _weaponNames["frontier_justice"] = "Frontier Justice";
    _weaponNames["robot_arm"] = "Gunslinger";
    _weaponNames["wrench_jag"] = "Jag";
    _weaponNames["wrangler_kill"] = "Wrangler";
    _weaponNames["wrench"] = "Wrench";
    _weaponNames["awper_hand"] = "AWPer Hand";
    _weaponNames["sniperrifle"] = "Sniper Rifle";
    _weaponNames["smg"] = "Submachine Gun";
    _weaponNames["bazaar_bargain"] = "Bazaar Bargain";
    _weaponNames["airstrike"] = "Air Strike";
    _weaponNames["tf_projectile_arrow"] = "Huntsman";
    _weaponNames["shahanshah"] = "Shahanshah";
    _weaponNames["tribalkukri"] = "Tribalman's Shiv";
    _weaponNames["club"] = "Kukri";
    _weaponNames["deflect_rocket"] = "Deflected Rocket";
    _weaponNames["deflect_promode"] = "Deflected Flare";
    _weaponNames["rocketpack_stomp"] = "Thermal Thruster Stomp";
    _weaponNames["shotgun_pyro"] = "Shotgun";
    _weaponNames["defelect_promode"] = "Deflected Flare";
    _weaponNames["pistol"] = "Pistol";
    _weaponNames["disciplinary_action"] = "Disciplinary Action";
    _weaponNames["big_earner"] = "Big Earner";
    _weaponNames["ambassador"] = "Ambassador";
    _weaponNames["knife"] = "Knife";
    _weaponNames["revolver"] = "Revolver";
    _weaponNames["letranger"] = "L'Etranger";
    _weaponNames["enforcer"] = "Enforcer";
    _weaponNames["eternal_reward"] = "Eternal Reward";
    _weaponNames["kunai"] = "Kunai";
    _weaponNames["black_rose"] = "Black Rose";
    _weaponNames["spy_cicle"] = "Spy-cicle";
    _weaponNames["necro_smasher"] = "Necro Smasher";
    _weaponNames["player"] = "Player";
    _weaponNames["detonator"] = "Detonator";
    _weaponNames["bottle"] = "Bottle";
    _weaponNames["dumpster_device"] = "Beggar's Bazooka";
    _weaponNames["taunt_sniper"] = "Sniper's Skewer Taunt";
    _weaponNames["sticky_resistance"] = "Scottish Resistance";
    _weaponNames["freedom_staff"] = "Freedom Staff";
    _weaponNames["bleed_kill"] = "Bleeding";
    _weaponNames["the_classic"] = "Classic";
    _weaponNames["persian_persuader"] = "Persian Persuader";
    _weaponNames["splendid_screen"] = "Splednid Screen";
    _weaponNames["telefrag"] = "Telefrag";
    _weaponNames["eureka_effect"] = "Eureka effect";
    _weaponNames["southern_hospitality"] = "Southern Hospitality";
    _weaponNames["widowmaker"] = "Widowmaker";
    _weaponNames["pomson"] = "Pomson 6000";
    _weaponNames["short_circuit"] = "Short Circuit";
    _weaponNames["taunt_guitar_kill"] = "Engineer's Dischord Taunt";
    _weaponNames["robot_arm_blender_kill"] = "Engineer's Organ Grinder Taunt";
    _weaponNames["cow_mangler"] = "Cow Mangler 5000";
    _weaponNames["demokatana"] = "Half-Zatoichi";
    _weaponNames["liberty_launcher"] = "Liberty Launcher";
    _weaponNames["righteous_bison"] = "Righteous Bison";
    _weaponNames["unique_pickaxe"] = "Equalizer";
    _weaponNames["shovel"] = "Shovel";
    _weaponNames["paintrain"] = "Pain Train";
    _weaponNames["mantreads"] = "Mantreads";
    _weaponNames["taunt_soldier"] = "Soldier's Kamikaze Taunt";
    _weaponNames["taunt_soldier_lumbricus"] = "Soldier's Holy Kamikaze Taunt";
    _weaponNames["sandman"] = "Sandman";
    _weaponNames["shortstop"] = "Shortstop";
    _weaponNames["candy_cane"] = "Candy Cane";
    _weaponNames["bat"] = "Bat";
    _weaponNames["warfan"] = "Fan O'War";
    _weaponNames["lava_bat"] = "Sun-on-a-Stick";
    _weaponNames["guillotine"] = "Flying Guillotine";
    _weaponNames["atomizer"] = "Atomizer";
    _weaponNames["ball"] = "Ball";
    _weaponNames["taunt_scout"] = "Scout's Home Run Taunt";
    _weaponNames["taunt_demoman"] = "Demoman's Decapitation Taunt";
    _weaponNames["claidheamhmor"] = "Claidheamh Mòr";
    _weaponNames["headtaker"] = "Horseless Headless Horsemann's Headtaker";
    _weaponNames["demoshield"] = "Chargin' Targe";
    _weaponNames["stickybomb_defender"] = "Stickybomb Defender";
    _weaponNames["ullapool_caber"] = "Ullapool Caber";
    _weaponNames["battleaxe"] = "Scotsman's Skullcutter";
    _weaponNames["ullapool_caber_explosion"] = "Ullapool Caber's Explosion";
    _weaponNames["rainblower"] = "Rainblower";
    _weaponNames["dragons_fury"] = "Dragon's Fury";
    _weaponNames["manmelter"] = "Manmelter";
    _weaponNames["lava_axe"] = "Sharpened Volcano Fragment";
    _weaponNames["annihilator"] = "Neon Annihilator";
    _weaponNames["sledgehammer"] = "Homewrecker";
    _weaponNames["hot_hand"] = "Hot Hand";
    _weaponNames["fireaxe"] = "Fire Axe";
    _weaponNames["thirddegree"] = "Third Degree";
    _weaponNames["axtinguisher"] = "Axtinguiser";
    _weaponNames["taunt_pyro"] = "Pyro's Hadouken Taunt";
    _weaponNames["armageddon"] = "Pyro's Armageddon Taunt";
    _weaponNames["execution"] = "Pyro's Execution Taunt";
    _weaponNames["jar_gas"] = "Gas Passer";
    _weaponNames["dragons_fury_bonus"] = "Dragon's Fury Bonus";
    _weaponNames["pro_smg"] = "Cleaner's Carbine";
    _weaponNames["pro_rifle"] = "Hitman's Heatmaker";
    _weaponNames["machina"] = "Machina";
    _weaponNames["sydney_sleeper"] = "Sydney Sleeper";
    _weaponNames["bushwacka"] = "Bushwacka";
    _weaponNames["compound_bow"] = "Fortified Compound";
    _weaponNames["taunt_heavy"] = "Heavy's Showdown Taunt";
    _weaponNames["warrior_spirit"] = "Warrior's Spirit";
    _weaponNames["natascha"] = "Natascha";
    _weaponNames["long_heatmaker"] = "Huo-Long Heater";
    _weaponNames["fists"] = "Fists";
    _weaponNames["gloves"] = "K.G.B.";
    _weaponNames["holiday_punch"] = "Holiday Punch";
    _weaponNames["steel_fists"] = "Fists Of Steel";
    _weaponNames["eviction_notice"] = "Eviction Notice";
    _weaponNames["shotgun_hwg"] = "Shotgun";
    _weaponNames["diamondback"] = "Diamondback";
    _weaponNames["taunt_spy"] = "Spy's Fencing Taunt";
    _weaponNames["ai_flamethrower"] = "Nostromo Napalmer";
    _weaponNames["voodoo_pin"] = "Wanga Prick";
    _weaponNames["golden_fryingpan"] = "Golden Frying Pan";
    _weaponNames["wrench_golden"] = "Golden Wrench";
    _weaponNames["saxxy"] = "Saxxy";
    _weaponNames["memory_maker"] = "Memory Maker";
    _weaponNames["shooting_star"] = "Shooting Star";
    _weaponNames["ham_shank"] = "Ham Shank";
    _weaponNames["crossing_guard"] = "Crossing Guard";
    _weaponNames["player_penetration"] = "Machina Player Penetration";
    _weaponNames["deflect_arrow"] = "Deflected Arrow";
    _weaponNames["deflect_flare"] = "Deflected Flare";
    _weaponNames["back_scratcher"] = "Back Scratcher";
    _weaponNames["the_maul"] = "Maul";
    _weaponNames["mailbox"] = "Postal Pummeler";
    _weaponNames["lollichop"] = "Lollichop";
    _weaponNames["holymackerel"] = "Holy Mackerel";
    _weaponNames["unarmed_combat"] = "Unarmed Combat";
    _weaponNames["batsaber"] = "Batsaber";
    _weaponNames["apocofists"] = "Apoco-fists";
    _weaponNames["bread_bite"] = "Bread bite";
    _weaponNames["sharp_dresser"] = "Sharp Dresser";
    _weaponNames["samrevolver"] = "Big Kill";
    _weaponNames["prinny_machete"] = "Prinny Machete";
    _weaponNames["crusaders_crossbow"] = "Crusader's Crossbow";
    _weaponNames["ubersaw"] = "Übersaw";
    _weaponNames["blutsauger"] = "Blutsauger";
    _weaponNames["amputator"] = "Amputator";
    _weaponNames["bonesaw"] = "Bonesaw";
    _weaponNames["syringegun_medic"] = "Syringe Gun";
  }

  static void _initWeaponImages() {
    _weaponImages["scattergun"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/1b/Item_icon_Scattergun.png/150px-Item_icon_Scattergun.png";
    _weaponImages["maxgun"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/86/Item_icon_Lugermorph.png/150px-Item_icon_Lugermorph.png";
    _weaponImages["pistol_scout"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/52/Item_icon_Pistol.png/150px-Item_icon_Pistol.png";
    _weaponImages["soda_popper"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f1/Item_icon_Soda_Popper.png/150px-Item_icon_Soda_Popper.png";
    _weaponImages["wrap_assassin"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/6b/Item_icon_Wrap_Assassin.png/150px-Item_icon_Wrap_Assassin.png";
    _weaponImages["the_winger"] =
        "https://wiki.teamfortress.com/w/images/thumb/4/4e/Item_icon_Winger.png/150px-Item_icon_Winger.png";
    _weaponImages["pep_brawlerblaster"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/e6/Item_icon_Baby_Face%27s_Blaster.png/150px-Item_icon_Baby_Face%27s_Blaster.png";
    _weaponImages["back_scatter"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/11/Item_icon_Back_Scatter.png/150px-Item_icon_Back_Scatter.png";
    _weaponImages["world"] =
        "https://wiki.teamfortress.com/w/images/5/50/Killicon_skull.png";
    _weaponImages["tf_projectile_rocket"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/fe/Item_icon_Rocket_Launcher.png/150px-Item_icon_Rocket_Launcher.png";
    _weaponImages["unique_pickaxe_escape"] =
        "https://wiki.teamfortress.com/w/images/thumb/0/0c/Item_icon_Escape_Plan.png/150px-Item_icon_Escape_Plan.png";
    _weaponImages["blackbox"] =
        "https://wiki.teamfortress.com/w/images/thumb/d/d2/Item_icon_Black_Box.png/150px-Item_icon_Black_Box.png";
    _weaponImages["rocketlauncher_directhit"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/e7/Item_icon_Direct_Hit.png/150px-Item_icon_Direct_Hit.png";
    _weaponImages["quake_rl"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/88/Item_icon_Original.png/150px-Item_icon_Original.png";
    _weaponImages["market_gardener"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/ac/Item_icon_Market_Gardener.png/150px-Item_icon_Market_Gardener.png";
    _weaponImages["the_capper"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/a6/Item_icon_C.A.P.P.E.R.png/150px-Item_icon_C.A.P.P.E.R.png";
    _weaponImages["boston_basher"] =
        "https://wiki.teamfortress.com/w/images/thumb/b/b5/Item_icon_Boston_Basher.png/150px-Item_icon_Boston_Basher.png";
    _weaponImages["panic_attack"] =
        "https://wiki.teamfortress.com/w/images/thumb/b/be/Item_icon_Panic_Attack.png/150px-Item_icon_Panic_Attack.png";
    _weaponImages["scout_sword"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f6/Item_icon_Three-Rune_Blade.png/150px-Item_icon_Three-Rune_Blade.png";
    _weaponImages["shotgun_soldier"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/5f/Item_icon_Shotgun.png/150px-Item_icon_Shotgun.png";
    _weaponImages["degreaser"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/94/Item_icon_Degreaser.png/150px-Item_icon_Degreaser.png";
    _weaponImages["flaregun"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/7b/Item_icon_Flare_Gun.png/150px-Item_icon_Flare_Gun.png";
    _weaponImages["scorch_shot"] =
        "https://wiki.teamfortress.com/w/images/thumb/b/be/Item_icon_Scorch_Shot.png/150px-Item_icon_Scorch_Shot.png";
    _weaponImages["flamethrower"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ec/Item_icon_Flame_Thrower.png/150px-Item_icon_Flame_Thrower.png";
    _weaponImages["powerjack"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/cf/Item_icon_Powerjack.png/150px-Item_icon_Powerjack.png";
    _weaponImages["reserve_shooter"] =
        "https://wiki.teamfortress.com/w/images/thumb/3/34/Item_icon_Reserve_Shooter.png/150px-Item_icon_Reserve_Shooter.png";
    _weaponImages["phlogistinator"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/22/Item_icon_Phlogistinator.png/150px-Item_icon_Phlogistinator.png";
    _weaponImages["backburner"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/5d/Item_icon_Backburner.png/150px-Item_icon_Backburner.png";
    _weaponImages["loose_cannon"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/70/Item_icon_Loose_Cannon.png/150px-Item_icon_Loose_Cannon.png";
    _weaponImages["iron_bomber"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/cd/Item_icon_Iron_Bomber.png/150px-Item_icon_Iron_Bomber.png";
    _weaponImages["loch_n_load"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/62/Item_icon_Loch-n-Load.png/150px-Item_icon_Loch-n-Load.png";
    _weaponImages["tf_projectile_pipe_remote"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/7c/Item_icon_Stickybomb_Launcher.png/150px-Item_icon_Stickybomb_Launcher.png";
    _weaponImages["scotland_shard"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/2c/Item_icon_Scottish_Resistance.png/150px-Item_icon_Scottish_Resistance.png";
    _weaponImages["sword"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/94/Item_icon_Eyelander.png/150px-Item_icon_Eyelander.png";
    _weaponImages["tf_projectile_pipe"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/e6/Item_icon_Grenade_Launcher.png/150px-Item_icon_Grenade_Launcher.png";
    _weaponImages["fryingpan"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/c1/Item_icon_Frying_Pan.png/150px-Item_icon_Frying_Pan.png";
    _weaponImages["quickiebomb_launcher"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f9/Item_icon_Quickiebomb_Launcher.png/150px-Item_icon_Quickiebomb_Launcher.png";
    _weaponImages["nonnonviolent_protest"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/cb/Item_icon_Conscientious_Objector.png/150px-Item_icon_Conscientious_Objector.png";
    _weaponImages["tide_turner"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/cd/Item_icon_Tide_Turner.png/150px-Item_icon_Tide_Turner.png";
    _weaponImages["skullbat"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/c5/Item_icon_Bat_Outta_Hell.png/150px-Item_icon_Bat_Outta_Hell.png";
    _weaponImages["force_a_nature"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ed/Item_icon_Force-A-Nature.png/150px-Item_icon_Force-A-Nature.png";
    _weaponImages["brass_beast"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/64/Item_icon_Brass_Beast.png/150px-Item_icon_Brass_Beast.png";
    _weaponImages["tomislav"] =
        "https://wiki.teamfortress.com/w/images/thumb/3/3e/Item_icon_Tomislav.png/150px-Item_icon_Tomislav.png";
    _weaponImages["iron_curtain"] =
        "https://wiki.teamfortress.com/w/images/thumb/d/da/Item_icon_Iron_Curtain.png/150px-Item_icon_Iron_Curtain.png";
    _weaponImages["family_business"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/cd/Item_icon_Family_Business.png/150px-Item_icon_Family_Business.png";
    _weaponImages["minigun"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/a7/Item_icon_Minigun.png/150px-Item_icon_Minigun.png";
    _weaponImages["gloves_running_urgently"] =
        "https://wiki.teamfortress.com/w/images/thumb/4/4f/Item_icon_Gloves_of_Running_Urgently.png/150px-Item_icon_Gloves_of_Running_Urgently.png";
    _weaponImages["shotgun_primary"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/5f/Item_icon_Shotgun.png/150px-Item_icon_Shotgun.png";
    _weaponImages["giger_counter"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/5d/Item_icon_Giger_Counter.png/150px-Item_icon_Giger_Counter.png";
    _weaponImages["obj_minisentry"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ea/Red_Mini_Sentry.png/150px-Red_Mini_Sentry.png";
    _weaponImages["obj_sentrygun3"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/78/RED_Level_3_Sentry_Gun.png/150px-RED_Level_3_Sentry_Gun.png";
    _weaponImages["obj_sentrygun2"] =
        "https://wiki.teamfortress.com/w/images/thumb/0/0d/RED_Level_2_Sentry_Gun.png/150px-RED_Level_2_Sentry_Gun.png";
    _weaponImages["obj_sentrygun"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/8a/RED_Level_1_Sentry_Gun.png/150px-RED_Level_1_Sentry_Gun.png";
    _weaponImages["rescue_ranger"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/29/Item_icon_Rescue_Ranger.png/150px-Item_icon_Rescue_Ranger.png";
    _weaponImages["frontier_justice"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/26/Item_icon_Frontier_Justice.png/150px-Item_icon_Frontier_Justice.png";
    _weaponImages["robot_arm"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/ca/Item_icon_Gunslinger.png/150px-Item_icon_Gunslinger.png";
    _weaponImages["wrench_jag"] =
        "https://wiki.teamfortress.com/w/images/thumb/4/49/Item_icon_Jag.png/150px-Item_icon_Jag.png";
    _weaponImages["wrangler_kill"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/ce/Item_icon_Wrangler.png/150px-Item_icon_Wrangler.png";
    _weaponImages["wrench"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/7d/Item_icon_Wrench.png/150px-Item_icon_Wrench.png";
    _weaponImages["awper_hand"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/24/Item_icon_AWPer_Hand.png/150px-Item_icon_AWPer_Hand.png";
    _weaponImages["sniperrifle"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/a1/Item_icon_Sniper_Rifle.png/150px-Item_icon_Sniper_Rifle.png";
    _weaponImages["smg"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/12/Item_icon_Submachine_Gun.png/150px-Item_icon_Submachine_Gun.png";
    _weaponImages["bazaar_bargain"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f4/Item_icon_Bazaar_Bargain.png/150px-Item_icon_Bazaar_Bargain.png";
    _weaponImages["airstrike"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f8/Item_icon_Air_Strike.png/150px-Item_icon_Air_Strike.png";
    _weaponImages["tf_projectile_arrow"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f8/Item_icon_Huntsman.png/150px-Item_icon_Huntsman.png";
    _weaponImages["shahanshah"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/8d/Item_icon_Shahanshah.png/150px-Item_icon_Shahanshah.png";
    _weaponImages["club"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ea/Item_icon_Kukri.png/150px-Item_icon_Kukri.png";
    _weaponImages["tribalkukri"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/55/Item_icon_Tribalman%27s_Shiv.png/150px-Item_icon_Tribalman%27s_Shiv.png";
    _weaponImages["deflect_rocket"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ec/Item_icon_Flame_Thrower.png/150px-Item_icon_Flame_Thrower.png";
    _weaponImages["shotgun_pyro"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/5f/Item_icon_Shotgun.png/150px-Item_icon_Shotgun.png";
    _weaponImages["defelect_promode"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ec/Item_icon_Flame_Thrower.png/150px-Item_icon_Flame_Thrower.png";
    _weaponImages["pistol"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/52/Item_icon_Pistol.png/150px-Item_icon_Pistol.png";
    _weaponImages["disciplinary_action"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/cf/Item_icon_Disciplinary_Action.png/150px-Item_icon_Disciplinary_Action.png";
    _weaponImages["big_earner"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/c9/Item_icon_Big_Earner.png/150px-Item_icon_Big_Earner.png";
    _weaponImages["ambassador"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ec/Item_icon_Ambassador.png/150px-Item_icon_Ambassador.png";
    _weaponImages["knife"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/57/Item_icon_Knife.png/150px-Item_icon_Knife.png";
    _weaponImages["revolver"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/1f/Item_icon_Revolver.png/150px-Item_icon_Revolver.png";
    _weaponImages["letranger"] =
        "https://wiki.teamfortress.com/w/images/thumb/b/b1/Item_icon_L%27Etranger.png/150px-Item_icon_L%27Etranger.png";
    _weaponImages["enforcer"] =
        "https://wiki.teamfortress.com/w/images/thumb/b/b6/Item_icon_Enforcer.png/150px-Item_icon_Enforcer.png";
    _weaponImages["eternal_reward"] =
        "https://wiki.teamfortress.com/w/images/thumb/d/d3/Item_icon_Your_Eternal_Reward.png/150px-Item_icon_Your_Eternal_Reward.png";
    _weaponImages["kunai"] =
        "https://wiki.teamfortress.com/w/images/thumb/0/02/Item_icon_Conniver%27s_Kunai.png/150px-Item_icon_Conniver%27s_Kunai.png";
    _weaponImages["black_rose"] =
        "https://wiki.teamfortress.com/w/images/thumb/3/33/Item_icon_Black_Rose.png/150px-Item_icon_Black_Rose.png";
    _weaponImages["spy_cicle"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/a3/Item_icon_Spy-cicle.png/150px-Item_icon_Spy-cicle.png";
    _weaponImages["necro_smasher"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/1a/Item_icon_Necro_Smasher.png/150px-Item_icon_Necro_Smasher.png";
    _weaponImages["player"] =
        "https://wiki.teamfortress.com/w/images/5/50/Killicon_skull.png";
    _weaponImages["detonator"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/53/Item_icon_Detonator.png/150px-Item_icon_Detonator.png";
    _weaponImages["bottle"] =
        "https://wiki.teamfortress.com/w/images/thumb/b/b2/Item_icon_Bottle.png/150px-Item_icon_Bottle.png";
    _weaponImages["dumpster_device"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/77/Item_icon_Beggar%27s_Bazooka.png/150px-Item_icon_Beggar%27s_Bazooka.png";
    _weaponImages["taunt_sniper"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/1e/Snipertaunt4.PNG/225px-Snipertaunt4.PNG";
    _weaponImages["sticky_resistance"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/2c/Item_icon_Scottish_Resistance.png/150px-Item_icon_Scottish_Resistance.png";
    _weaponImages["freedom_staff"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/28/Item_icon_Freedom_Staff.png/150px-Item_icon_Freedom_Staff.png";
    _weaponImages["bleed_kill"] =
        "https://wiki.teamfortress.com/w/images/d/dd/Bleed_drop.png";
    _weaponImages["the_classic"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/73/Item_icon_Classic.png/150px-Item_icon_Classic.png";
    _weaponImages["persian_persuader"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/98/Item_icon_Persian_Persuader.png/150px-Item_icon_Persian_Persuader.png";
    _weaponImages["splendid_screen"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/c3/Item_icon_Splendid_Screen.png/150px-Item_icon_Splendid_Screen.png";
    _weaponImages["telefrag"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/6c/Telefrag.png/450px-Telefrag.png";
    _weaponImages["eureka_effect"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/cf/Item_icon_Eureka_Effect.png/150px-Item_icon_Eureka_Effect.png";
    _weaponImages["southern_hospitality"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ec/Item_icon_Southern_Hospitality.png/150px-Item_icon_Southern_Hospitality.png";
    _weaponImages["widowmaker"] =
        "https://wiki.teamfortress.com/w/images/thumb/b/b8/Item_icon_Widowmaker.png/150px-Item_icon_Widowmaker.png";
    _weaponImages["pomson"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/89/Item_icon_Pomson_6000.png/150px-Item_icon_Pomson_6000.png";
    _weaponImages["short_circuit"] =
        "https://wiki.teamfortress.com/w/images/thumb/3/36/Item_icon_Short_Circuit.png/150px-Item_icon_Short_Circuit.png";
    _weaponImages["taunt_guitar_kill"] =
        "https://wiki.teamfortress.com/w/images/thumb/3/35/EngyGuitarSmash.png/164px-EngyGuitarSmash.png";
    _weaponImages["robot_arm_blender_kill"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/87/EngyGunslinger.png/116px-EngyGunslinger.png";
    _weaponImages["cow_mangler"] =
        "https://wiki.teamfortress.com/w/images/thumb/4/46/Item_icon_Cow_Mangler_5000.png/150px-Item_icon_Cow_Mangler_5000.png";
    _weaponImages["demokatana"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/a9/Item_icon_Half-Zatoichi.png/150px-Item_icon_Half-Zatoichi.png";
    _weaponImages["liberty_launcher"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/24/Item_icon_Liberty_Launcher.png/150px-Item_icon_Liberty_Launcher.png";
    _weaponImages["righteous_bison"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/1d/Item_icon_Righteous_Bison.png/150px-Item_icon_Righteous_Bison.png";
    _weaponImages["unique_pickaxe"] =
        "https://wiki.teamfortress.com/w/images/thumb/b/ba/Item_icon_Equalizer.png/150px-Item_icon_Equalizer.png";
    _weaponImages["shovel"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/73/Item_icon_Shovel.png/150px-Item_icon_Shovel.png";
    _weaponImages["paintrain"] =
        "https://wiki.teamfortress.com/w/images/thumb/4/4b/Item_icon_Pain_Train.png/150px-Item_icon_Pain_Train.png";
    _weaponImages["mantreads"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/6a/Item_icon_Mantreads.png/150px-Item_icon_Mantreads.png";
    _weaponImages["taunt_soldier"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f4/Soldiergrenadekill.png/81px-Soldiergrenadekill.png";
    _weaponImages["taunt_soldier_lumbricus"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f4/Soldiergrenadekill.png/81px-Soldiergrenadekill.png";
    _weaponImages["candy_cane"] =
        "https://wiki.teamfortress.com/w/images/thumb/0/05/Item_icon_Candy_Cane.png/150px-Item_icon_Candy_Cane.png";
    _weaponImages["bat"] =
        "https://wiki.teamfortress.com/w/images/thumb/b/b5/Item_icon_Bat.png/150px-Item_icon_Bat.png";
    _weaponImages["warfan"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f4/Item_icon_Fan_O%27War.png/150px-Item_icon_Fan_O%27War.png";
    _weaponImages["lava_bat"] =
        "https://wiki.teamfortress.com/w/images/thumb/0/06/Item_icon_Sun-on-a-Stick.png/150px-Item_icon_Sun-on-a-Stick.png";
    _weaponImages["guillotine"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/5a/Item_icon_Flying_Guillotine.png/150px-Item_icon_Flying_Guillotine.png";
    _weaponImages["atomizer"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/29/Item_icon_Atomizer.png/150px-Item_icon_Atomizer.png";
    _weaponImages["ball"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/70/Item_icon_Sandman.png/150px-Item_icon_Sandman.png";
    _weaponImages["taunt_scout"] =
        "https://wiki.teamfortress.com/w/images/thumb/4/47/Scouttaunt4.PNG/225px-Scouttaunt4.PNG";
    _weaponImages["sandman"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/70/Item_icon_Sandman.png/150px-Item_icon_Sandman.png";
    _weaponImages["shortstop"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/84/Item_icon_Shortstop.png/150px-Item_icon_Shortstop.png";
    _weaponImages["pep_pistol"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f6/Item_icon_Pretty_Boy%27s_Pocket_Pistol.png/150px-Item_icon_Pretty_Boy%27s_Pocket_Pistol.png";
    _weaponImages["taunt_demoman"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/fa/Demoeyelander.png/187px-Demoeyelander.png";
    _weaponImages["claidheamhmor"] =
        "https://wiki.teamfortress.com/w/images/thumb/0/0f/Item_icon_Claidheamh_M%C3%B2r.png/150px-Item_icon_Claidheamh_M%C3%B2r.png";
    _weaponImages["headtaker"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/1f/Item_icon_Horseless_Headless_Horsemann%27s_Headtaker.png/150px-Item_icon_Horseless_Headless_Horsemann%27s_Headtaker.png";
    _weaponImages["demoshield"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/7a/Item_icon_Chargin%27_Targe.png/150px-Item_icon_Chargin%27_Targe.png";
    _weaponImages["stickybomb_defender"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/7c/Item_icon_Stickybomb_Launcher.png/150px-Item_icon_Stickybomb_Launcher.png";
    _weaponImages["ullapool_caber"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/a5/Item_icon_Ullapool_Caber.png/150px-Item_icon_Ullapool_Caber.png";
    _weaponImages["battleaxe"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/c6/Item_icon_Scotsman%27s_Skullcutter.png/150px-Item_icon_Scotsman%27s_Skullcutter.png";
    _weaponImages["ullapool_caber_explosion"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/a5/Item_icon_Ullapool_Caber.png/150px-Item_icon_Ullapool_Caber.png";
    _weaponImages["rainblower"] =
        "https://wiki.teamfortress.com/w/images/thumb/3/3c/Item_icon_Rainblower.png/150px-Item_icon_Rainblower.png";
    _weaponImages["dragons_fury"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/1f/Item_icon_Dragon%27s_Fury.png/150px-Item_icon_Dragon%27s_Fury.png";
    _weaponImages["manmelter"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/9d/Item_icon_Manmelter.png/150px-Item_icon_Manmelter.png";
    _weaponImages["lava_axe"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/ac/Item_icon_Sharpened_Volcano_Fragment.png/150px-Item_icon_Sharpened_Volcano_Fragment.png";
    _weaponImages["annihilator"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/e9/Item_icon_Neon_Annihilator.png/150px-Item_icon_Neon_Annihilator.png";
    _weaponImages["sledgehammer"] =
        "https://wiki.teamfortress.com/w/images/thumb/4/4a/Item_icon_Homewrecker.png/150px-Item_icon_Homewrecker.png";
    _weaponImages["hot_hand"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f6/Item_icon_Hot_Hand.png/150px-Item_icon_Hot_Hand.png";
    _weaponImages["fireaxe"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/9f/Item_icon_Fire_Axe.png/150px-Item_icon_Fire_Axe.png";
    _weaponImages["thirddegree"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/91/Item_icon_Third_Degree.png/150px-Item_icon_Third_Degree.png";
    _weaponImages["axtinguisher"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/c9/Item_icon_Axtinguisher.png/150px-Item_icon_Axtinguisher.png";
    _weaponImages["taunt_pyro"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ec/Pyrotaunt2.PNG/225px-Pyrotaunt2.PNG";
    _weaponImages["armageddon"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/79/Pyro_Armageddon_Taunt.png/225px-Pyro_Armageddon_Taunt.png";
    _weaponImages["execution"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/8b/Execution.PNG/220px-Execution.PNG";
    _weaponImages["jar_gas"] =
        "https://wiki.teamfortress.com/w/images/thumb/0/0e/Item_icon_Gas_Passer.png/150px-Item_icon_Gas_Passer.png";
    _weaponImages["dragons_fury_bonus"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/1f/Item_icon_Dragon%27s_Fury.png/150px-Item_icon_Dragon%27s_Fury.png";
    _weaponImages["pro_smg"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/64/Item_icon_Cleaner%27s_Carbine.png/150px-Item_icon_Cleaner%27s_Carbine.png";
    _weaponImages["pro_rifle"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/18/Item_icon_Hitman%27s_Heatmaker.png/150px-Item_icon_Hitman%27s_Heatmaker.png";
    _weaponImages["machina"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/ae/Item_icon_Machina.png/150px-Item_icon_Machina.png";
    _weaponImages["sydney_sleeper"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/6a/Item_icon_Sydney_Sleeper.png/150px-Item_icon_Sydney_Sleeper.png";
    _weaponImages["bushwacka"] =
        "https://wiki.teamfortress.com/w/images/thumb/4/46/Item_icon_Bushwacka.png/150px-Item_icon_Bushwacka.png";
    _weaponImages["compound_bow"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/89/Item_icon_Fortified_Compound.png/150px-Item_icon_Fortified_Compound.png";
    _weaponImages["taunt_heavy"] =
        "https://wiki.teamfortress.com/w/images/thumb/7/7d/Heavytaunt3.PNG/225px-Heavytaunt3.PNG";
    _weaponImages["warrior_spirit"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/87/Item_icon_Warrior%27s_Spirit.png/150px-Item_icon_Warrior%27s_Spirit.png";
    _weaponImages["natascha"] =
        "https://wiki.teamfortress.com/w/images/thumb/c/cc/Item_icon_Natascha.png/150px-Item_icon_Natascha.png";
    _weaponImages["long_heatmaker"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/81/Item_icon_Huo-Long_Heater.png/150px-Item_icon_Huo-Long_Heater.png";
    _weaponImages["fists"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/19/Item_icon_Fists.png/150px-Item_icon_Fists.png";
    _weaponImages["gloves"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f6/Item_icon_Killing_Gloves_of_Boxing.png/150px-Item_icon_Killing_Gloves_of_Boxing.png";
    _weaponImages["holiday_punch"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/54/Item_icon_Holiday_Punch.png/150px-Item_icon_Holiday_Punch.png";
    _weaponImages["steel_fists"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/9c/Item_icon_Fists_of_Steel.png/150px-Item_icon_Fists_of_Steel.png";
    _weaponImages["eviction_notice"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/62/Item_icon_Eviction_Notice.png/150px-Item_icon_Eviction_Notice.png";
    _weaponImages["shotgun_hwg"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/5f/Item_icon_Shotgun.png/150px-Item_icon_Shotgun.png";
    _weaponImages["diamondback"] =
        "https://wiki.teamfortress.com/w/images/thumb/b/b4/Item_icon_Diamondback.png/150px-Item_icon_Diamondback.png";
    _weaponImages["taunt_spy"] =
        "https://wiki.teamfortress.com/w/images/thumb/3/32/Spytaunt2.PNG/125px-Spytaunt2.PNG";
    _weaponImages["ai_flamethrower"] =
        "https://wiki.teamfortress.com/w/images/thumb/d/d3/Item_icon_Nostromo_Napalmer.png/150px-Item_icon_Nostromo_Napalmer.png";
    _weaponImages["voodoo_pin"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f5/Item_icon_Wanga_Prick.png/150px-Item_icon_Wanga_Prick.png";
    _weaponImages["deflect_promode"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ec/Item_icon_Flame_Thrower.png/150px-Item_icon_Flame_Thrower.png";
    _weaponImages["rocketpack_stomp"] =
        "https://wiki.teamfortress.com/w/images/thumb/0/00/Item_icon_Thermal_Thruster.png/150px-Item_icon_Thermal_Thruster.png";
    _weaponImages["golden_fryingpan"] =
        "https://wiki.teamfortress.com/w/images/thumb/0/0f/Backpack_Golden_Frying_Pan.png/150px-Backpack_Golden_Frying_Pan.png";
    _weaponImages["wrench_golden"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/54/Backpack_Golden_Wrench.png/150px-Backpack_Golden_Wrench.png";
    _weaponImages["saxxy"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/6e/Backpack_Saxxy.png/135px-Backpack_Saxxy.png";
    _weaponImages["memory_maker"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/9b/Backpack_Memory_Maker.png/135px-Backpack_Memory_Maker.png";
    _weaponImages["shooting_star"] =
        "https://wiki.teamfortress.com/w/images/thumb/3/3e/Backpack_Shooting_Star.png/150px-Backpack_Shooting_Star.png";
    _weaponImages["ham_shank"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/1b/Backpack_Ham_Shank.png/150px-Backpack_Ham_Shank.png";
    _weaponImages["crossing_guard"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/8c/Item_icon_Crossing_Guard.png/150px-Item_icon_Crossing_Guard.png";
    _weaponImages["player_penetration"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/ae/Item_icon_Machina.png/150px-Item_icon_Machina.png";
    _weaponImages["deflect_arrow"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ec/Item_icon_Flame_Thrower.png/150px-Item_icon_Flame_Thrower.png";
    _weaponImages["deflect_flare"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ec/Item_icon_Flame_Thrower.png/150px-Item_icon_Flame_Thrower.png";
    _weaponImages["back_scratcher"] =
        "https://wiki.teamfortress.com/w/images/thumb/4/48/Item_icon_Back_Scratcher.png/150px-Item_icon_Back_Scratcher.png";
    _weaponImages["the_maul"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/2e/Item_icon_Maul.png/150px-Item_icon_Maul.png";
    _weaponImages["mailbox"] =
        "https://wiki.teamfortress.com/w/images/thumb/2/2d/Item_icon_Postal_Pummeler.png/150px-Item_icon_Postal_Pummeler.png";
    _weaponImages["lollichop"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/65/Item_icon_Lollichop.png/150px-Item_icon_Lollichop.png";
    _weaponImages["holymackerel"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/86/Item_icon_Holy_Mackerel.png/150px-Item_icon_Holy_Mackerel.png";
    _weaponImages["unarmed_combat"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/96/Item_icon_Unarmed_Combat.png/150px-Item_icon_Unarmed_Combat.png";
    _weaponImages["batsaber"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ef/Item_icon_Batsaber.png/150px-Item_icon_Batsaber.png";
    _weaponImages["apocofists"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/91/Item_icon_Apoco-Fists.png/150px-Item_icon_Apoco-Fists.png";
    _weaponImages["bread_bite"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/a4/Item_icon_Bread_Bite.png/150px-Item_icon_Bread_Bite.png";
    _weaponImages["sharp_dresser"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/eb/Item_icon_Sharp_Dresser.png/150px-Item_icon_Sharp_Dresser.png";
    _weaponImages["samrevolver"] =
        "https://wiki.teamfortress.com/w/images/thumb/3/31/Item_icon_Big_Kill.png/150px-Item_icon_Big_Kill.png";
    _weaponImages["prinny_machete"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/ef/Item_icon_Prinny_Machete.png/150px-Item_icon_Prinny_Machete.png";
    _weaponImages["crusaders_crossbow"] =
        "https://wiki.teamfortress.com/w/images/thumb/9/9c/Item_icon_Crusader%27s_Crossbow.png/150px-Item_icon_Crusader%27s_Crossbow.png";
    _weaponImages["ubersaw"] =
        "https://wiki.teamfortress.com/w/images/thumb/0/04/Item_icon_Ubersaw.png/150px-Item_icon_Ubersaw.png";
    _weaponImages["blutsauger"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/13/Item_icon_Blutsauger.png/150px-Item_icon_Blutsauger.png";
    _weaponImages["amputator"] =
        "https://wiki.teamfortress.com/w/images/thumb/a/ab/Item_icon_Amputator.png/150px-Item_icon_Amputator.png";
    _weaponImages["bonesaw"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/8d/Item_icon_Bonesaw.png/150px-Item_icon_Bonesaw.png";
    _weaponImages["syringegun_medic"] = "https://wiki.teamfortress.com/w/images/thumb/c/c4/Item_icon_Syringe_Gun.png/150px-Item_icon_Syringe_Gun.png";
  }

  static String getWeaponImage(String weaponNameKey) {
    if (_weaponImages.isEmpty) {
      _initWeaponImages();
    }
    if (_weaponImages.containsKey(weaponNameKey)) {
      return _weaponImages[weaponNameKey];
    } else {
      return "https://wiki.teamfortress.com/w/images/thumb/1/1b/Item_icon_Scattergun.png/150px-Item_icon_Scattergun.png";
    }
  }

  static String getWeaponName(String weaponNameKey) {
    if (_weaponNames.isEmpty) {
      _initWeaponNames();
    }

    if (_weaponNames.containsKey(weaponNameKey)) {
      return _weaponNames[weaponNameKey];
    } else {
      return weaponNameKey;
    }
  }

  static List<Player> getOtherPlayersWithClass(
      Log log, String className, String excludedSteamId) {
    List<Player> allPlayers =
        log.players != null ? log.players.values.toList() : List();
    return allPlayers
        .where((player) =>
            excludedSteamId != player.steamId &&
            isClassPlayedByPlayer(player, className))
        .toList();
  }

  static bool isClassPlayedByPlayer(Player player, String className) {
    return player != null &&
        player.classStats
                .where((classStats) => classStats.type == className)
                .isNotEmpty;
  }

  static ClassKill getClassKill(Log log, Player player) {
    return log.classKills[player.steamId];
  }

  static List<Player> getPlayers(Log log, String teamName, {String className}) {
    List<Player> allPlayers = log.players.values.toList();
    List<Player> teamPlayers =
        allPlayers.where((player) => player.team == teamName).toList();
    if (className != null) {
      teamPlayers = teamPlayers
          .where((player) => isClassPlayedByPlayer(player, className))
          .toList();
    }
    return teamPlayers;
  }

  static int sumDeaths(List<Player> players) {
    int deaths = 0;
    players.forEach((player) => deaths += player.deaths);
    return deaths;
  }

  static List<HealSpread> getHealSpread(Log log, String steamId) {
    List<HealSpread> healSpreadList = List();
    var healSpreadMap = log.healspread[steamId];
    if (healSpreadMap == null) {
      return null;
    }
    int sum = _getSumOfMap(healSpreadMap);
    healSpreadMap.forEach((steamId, value) {
      var player = log.players[steamId];
      healSpreadList.add(HealSpread(log.getPlayerName(steamId),
          getPlayerClasses(player), (value / sum) * 100, value));
    });
    healSpreadList.sort((healSpread1, healSpread2) =>
        healSpread2.percentage.compareTo(healSpread1.percentage));
    return healSpreadList;
  }

  static int _getSumOfMap(Map<String, int> map) {
    int sum = 0;
    map.values.forEach((value) => sum += value);
    return sum;
  }

  static List<Player> getPlayersWithClass(Log log, String className) {
    List<Player> allPlayers = log.players.values.toList();
    return allPlayers
        .where((player) => isClassPlayedByPlayer(player, className))
        .toList();
  }

  static List<String> getPlayerClasses(Player player) {
    return player.classStats != null
        ? player.classStats.map((classStat) => classStat.type).toList()
        : List();
  }

  static Map<String, int> getHealSpreadMapWithNames(Log log, String steamId) {
    var healSpreadMap = log.healspread[steamId];
    return healSpreadMap
        .map((steamId, heal) => MapEntry(log.getPlayerName(steamId), heal));
  }

  static int getKillsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.kills;
    });
    return sum;
  }

  static int getDeathsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.deaths;
    });
    return sum;
  }

  static int getAssistsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.assists;
    });
    return sum;
  }

  static int getDamageSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.dmg;
    });
    return sum;
  }

  static int getDamageTakenSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.dt;
    });
    return sum;
  }

  static int getCapSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.cpc;
    });
    return sum;
  }

  static int getChargeSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.ubers;
    });
    return sum;
  }

  static int getDropSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.drops;
    });
    return sum;
  }

  static double getTeamKAPD(Log log, String team) {
    var kills = getKillsSum(log, team);
    var assists = getAssistsSum(log, team);
    var deaths = getDeathsSum(log, team);
    return (kills + assists) / deaths;
  }

  static double getTeamDamagePerMinute(Log log, String team) {
    var damage = getDamageSum(log, team);
    return damage / (log.length / 60);
  }

  static double getTeamKillsPerDeaths(Log log, String team) {
    var kills = getKillsSum(log, team);
    var deaths = getDeathsSum(log, team);
    return kills / deaths;
  }

  static double getTeamDamageTakenPerMinute(Log log, String team) {
    var damageTaken = getDamageTakenSum(log, team);
    return damageTaken / (log.length / 60);
  }

  static int getMedkitsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.medkits;
    });
    return sum;
  }

  static int getMedkitsHPSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.medkitsHp;
    });
    return sum;
  }

  static int getHeadshotsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.headshots;
    });
    return sum;
  }

  static int getSentriesSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.sentries;
    });
    return sum;
  }

  static int getBackstabsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.backstabs;
    });
    return sum;
  }

  static List<String> getPlayerNames(Log log) {
    List<Player> allPlayers = log.players.values.toList();
    return allPlayers
        .map((player) => log.getPlayerName(player.steamId))
        .toList();
  }

  static List<Player> getPlayersSortedByKills(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.kills.compareTo(player1.kills));
    return players;
  }

  static List<Player> getPlayersSortedByAssists(Log log, bool medicsIncluded) {
    List<Player> players = log.players.values.toList();
    if (!medicsIncluded) {
      players = players
          .where((player) => !getPlayerClasses(player).contains("medic"))
          .toList();
    }
    players
        .sort((player1, player2) => player2.assists.compareTo(player1.assists));
    return players;
  }

  static List<Player> getPlayersSortedByDamage(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.dmg.compareTo(player1.dmg));
    return players;
  }

  static List<Player> getPlayersSortedByMedicKills(Log log) {
    List<Player> players = log.players.values.toList();
    players = players
        .where((player) =>
            log.classKills[player.steamId] != null &&
            log.classKills[player.steamId].medic != null)
        .toList();
    players.sort((player1, player2) => log.classKills[player2.steamId].medic
        .compareTo(log.classKills[player1.steamId].medic));
    return players;
  }

  static List<Player> getPlayerSortedByMVPScore(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => getPlayerMVPScore(player2, log)
        .compareTo(getPlayerMVPScore(player1, log)));
    return players;
  }

  static double getPlayerMVPScore(Player player, Log log) {
    var kills = player.kills;
    var assists = player.assists;
    var damage = player.dmg;
    var caps = player.cpc;
    var medicKills = 0;
    if (log.classKills.containsKey(player.steamId)) {
      medicKills = log.classKills[player.steamId].medic;
      if (medicKills == null) {
        medicKills = 0;
      }
    }

    return kills * 0.39 +
        assists * 0.2 +
        damage * 0.01 +
        caps * 0.2 +
        medicKills * 0.2;
  }

  static List<Player> getPlayersSortedByKPD(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.kpd.compareTo(player1.kpd));
    return players;
  }

  static List<Player> getPlayersSortedByKAPD(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.kapd.compareTo(player1.kapd));
    return players;
  }

  static MatchType getMatchType(
      int playersCount, String mapName, BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    String matchType = "";
    Color color = Colors.lightBlue;
    if (playersCount % 2 == 0) {
      double half = playersCount / 2;
      matchType = applicationLocalization
          .getText("log_x_v_x_match")
          .replaceAll("<players_count>", half.toStringAsFixed(0));
    } else {
      matchType = applicationLocalization
          .getText("log_x_players_match")
          .replaceAll("<players_count>", playersCount.toString());
    }

    if (playersCount == 4) {
      if (mapName.contains("ultiduo")) {
        matchType = applicationLocalization.getText("log_ultiduo_match");
        color = Colors.pink;
      } else {
        matchType = applicationLocalization.getText("log_bball_match");
        color = Colors.teal;
      }
    }
    if (playersCount >= 12 && playersCount < 18) {
      matchType = applicationLocalization.getText("log_6v6_match");
      color = Colors.green;
    } else if (playersCount >= 18) {
      matchType = applicationLocalization.getText("log_highlander_match");
      color = Colors.orange;
    }
    return MatchType(matchType, color);
  }

  static double getDamagePerMinute(Player player, int length) {
    final damage = player.dmg;
    return damage / (length / 60);
  }

  static getPlayersSortedByDAPM(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => getDamagePerMinute(player2, log.length)
        .compareTo(getDamagePerMinute(player1, log.length)));
    return players;
  }

  static getPlayersSortedByMedkits(Log log) {
    List<Player> players = log.players.values.toList();
    players
        .sort((player1, player2) => player2.medkits.compareTo(player1.medkits));
    return players;
  }

  static int getMedicKills(Player player, Log log) {
    if (log.classKills.containsKey(player.steamId)) {
      return log.classKills[player.steamId].medic;
    } else {
      return 0;
    }
  }

  static List<Player> getPlayersSortedByMedicsKilled(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) =>
        getMedicKills(player2, log).compareTo(getMedicKills(player1, log)));
    return players;
  }

  static List<Player> getPlayersSortedByCaps(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.cpc.compareTo(player1.cpc));
    return players;
  }

  static List<Player> getPlayersSortedByAirshots(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.as.compareTo(player1.as));
    return players;
  }

  static List<Player> getPlayersSortedByScoutKills(Log log) {
    List<Player> players = log.players.values.toList();
    players = players
        .where((player) =>
            log.classKills[player.steamId] != null &&
            log.classKills[player.steamId].scout != null)
        .toList();
    players.sort((player1, player2) => log.classKills[player2.steamId].scout
        .compareTo(log.classKills[player1.steamId].scout));
    return players;
  }

  static List<Player> getPlayersSortedBySoldierKills(Log log) {
    List<Player> players = log.players.values.toList();
    players = players
        .where((player) =>
            log.classKills[player.steamId] != null &&
            log.classKills[player.steamId].soldier != null)
        .toList();
    players.sort((player1, player2) => log.classKills[player2.steamId].soldier
        .compareTo(log.classKills[player1.steamId].soldier));
    return players;
  }

  static List<Player> getPlayersSortedByDT(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.dt.compareTo(player1.dt));
    return players;
  }

  static List<Player> getPlayersSortedByHeavyKills(Log log) {
    List<Player> players = log.players.values.toList();
    players = players
        .where((player) =>
            log.classKills[player.steamId] != null &&
            log.classKills[player.steamId].heavyweapons != null)
        .toList();
    players.sort((player1, player2) => log
        .classKills[player2.steamId].heavyweapons
        .compareTo(log.classKills[player1.steamId].heavyweapons));
    return players;
  }

  static getPlayersSortedBySniperKills(Log log) {
    List<Player> players = log.players.values.toList();
    players = players
        .where((player) =>
            log.classKills[player.steamId] != null &&
            log.classKills[player.steamId].sniper != null)
        .toList();
    players.sort((player1, player2) => log.classKills[player2.steamId].sniper
        .compareTo(log.classKills[player1.steamId].sniper));
    return players;
  }

  static List<Player> getPlayersSortedByHeadshots(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort(
        (player1, player2) => player2.headshots.compareTo(player1.headshots));
    return players;
  }

  static List<Player> getPlayersSortedByHeadshotsHits(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) =>
        player2.headshotsHit.compareTo(player1.headshotsHit));
    return players;
  }

  static List<Player> getPlayersSortedByBackstabs(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort(
        (player1, player2) => player2.backstabs.compareTo(player1.backstabs));
    return players;
  }

  static List<Player> getPlayersSortedByKillsPerDeath(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.kpd.compareTo(player1.kpd));
    return players;
  }

  static getPlayersSortedByDemomanKills(Log log) {
    List<Player> players = log.players.values.toList();
    players = players
        .where((player) =>
            log.classKills[player.steamId] != null &&
            log.classKills[player.steamId].demoman != null)
        .toList();
    players.sort((player1, player2) => log.classKills[player2.steamId].demoman
        .compareTo(log.classKills[player1.steamId].demoman));
    return players;
  }
}
