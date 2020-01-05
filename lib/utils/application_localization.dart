import 'package:flutter/material.dart';

class ApplicationLocalization {
  final Locale locale;

  ApplicationLocalization(this.locale);

  static ApplicationLocalization of(BuildContext context) {
    return Localizations.of<ApplicationLocalization>(
        context, ApplicationLocalization);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      "help_mvp_title": "How MVP is calculated",
      "help_mvp_description":
          "Each person is evaluated based on his stats. Here is calculation formula: kills * 0.39 + assists * 0.2 + damage * 0.01 + caps * 0.2 + medic kills * 0.2.",
      "help_bug_title": "I have found bug!",
      "help_bug_description":
          "Nice! You can report it to developer. Please go to project page and report issue there (you can find project page in 'About' section).",
      "help_help_title": "How I can help?",
      "help_help_description":
          "You can share ideas with developers in project page or steam.",
      "help_free_title": "Is this app free?",
      "help_free_description":
          "Yes, this app is free and will be free forever! If you appreciate this app, you can donate steam items to authors.",
      "help_purpose_title": "What is purpose of this app?",
      "help_purpose_description":
          "This app is dedicated for professional competetive Team Fortress 2 players, who want to see stats from their matches.",
      "help_data_title": "How do you get data?",
      "help_data_description": "All data is from logs.tf website.",
      "menu_help": "Help",
      "menu_settings": "Settings",
      "menu_about": "About",
      "logs_active_filters": "Active Filters",
      "logs_all_matches": "All matches",
      "logs_saved_players": "Saved players",
      "logs_saved_matches": "Saved matches",
      "logs_no_logs_found": "There's no logs found.",
      "logs_players_observed_no_observed_players":
          "No players observed. Please add player by clicking Observe player in player details.",
      "logs_players_observed_no_data": "There's no logs found.",
      "logs_players_observed_player": "Player:",
      "logs_saved_no_data": "There's no saved logs.",
      "logs_failed_to_load_logs": "Failed to load data from logs.tf",
      "unknown_error": "Unknown error",
      "loading": "Loading",
      "log_highlander_match": "Highlander Match",
      "log_6v6_match": "6v6 Match",
      "log_x_players_match": "<players_count> Players Match",
      "log_bball_match": "BBall Match",
      "log_ultiduo_match": "Ultiduo Match",
      "log_x_v_x_match": "<player_count>v<player_count> Match",
      "log_search_logs_search": "Logs search",
      "log_search_players_search": "Players search",
      "log_search_map": "Map",
      "log_search_uploader": "Uploader",
      "log_search_title": "Title",
      "log_search_player_steam_id": "Player steam id",
      "log_search_clear_filters": "Clear filters",
      "log_search_search": "Search",
      "log_search_player_name": "Player name",
      "retry": "Retry",
      "settings_color_purple": "Purple",
      "settings_color_orange": "Orange",
      "settings_color_green": "Green",
      "settings_color_blue": "Blue",
      "settings_color_red": "Red",
      "settings_color_pink": "Pink",
      "settings_color_black": "Black",
      "settings_brightness_light": "Light",
      "settings_brightness_dark": "Dark",
      "settings_app_color": "App color:",
      "settings_app_brightness": "App brightness:",
      "settings_observed_players": "Observed players:",
      "settings_clear_observed_players": "Clear observed players",
      "settings_saved_matches": "Saved matches:",
      "settings_clear_saved_matches": "Clear saved matches",
      "log_general_stats": "General stats",
      "log_players_stats": "Player stats",
      "log_players_matrix": "Players matrix",
      "log_awards_stats": "Awards stats",
      "log_match_timeline": "Match timeline",
      "log_metric": "METRIC",
      "log_kills": "Kills",
      "log_deaths": "Deaths",
      "log_assists": "Assists",
      "log_damage": "Damage",
      "log_damage_taken": "Damage taken",
      "log_caps": "Caps",
      "log_charges": "Charges",
      "log_drops": "Drops",
      "log_hp_pickups": "HP pickups",
      "log_hp_from_pickups": "HP from pickups",
      "log_headshots": "Headshots",
      "log_sentries": "Sentries",
      "log_backstabs": "Backstabs",
      "log_map": "Map:",
      "log_type": "Type:",
      "log_played_at": "Played at:",
      "log_played": "Played:",
      "log_uploaded_by": "Uploaded by:",
      "log_match_id": "Match id:",
      "log_player": "Player",
      "log_class": "Class",
      "log_scroll_right_to_see_more": "Scroll right to see more stats",
      "log_stats": "Stats:",
      "log_kills_and_assists": "Kills and Assists",
      "log_award_mvp_title": "Most valuable players",
      "log_award_mvp_description": "Players which were most valuable in game.",
      "log_award_kills_title": "Top kills",
      "log_award_kills_description": "Players which had most kills overall.",
      "log_award_assists_title": "Top assists",
      "log_award_assists_description":
          "Players which had most asissts overall (without medics).",
      "log_award_damage_title": "Top damage",
      "log_award_damage_description": "Players which dealed the most damage.",
      "log_award_medic_kills_title": "Top medic kills",
      "log_award_medic_kills_description": "Players which killed most medics.",
      "log_award_kpd_title": "Top kills per deaths",
      "log_award_kpd_description": "Players which had best kills per deaths.",
      "log_award_kapd_title": "Top kills & assists per deaths",
      "log_award_kapd_description":
          "Players which had best kills & assists per deaths.",
      "log_seconds": "seconds",
      "log_1st": "1st",
      "log_2nd": "2nd",
      "log_3rd": "3rd",
      "log_nth": "<n>th",
      "log_timeline_round_started": "<round_id> round started.",
      "log_timeline_capped_point": "has capped point.",
      "log_timeline_medic_drop": "medic has died and dropped uber.",
      "log_timeline_medic_died": "medic has died.",
      "log_timeline_medic_charged": "medic has charged uber.",
      "log_timeline_won_round": "has won round.",
      "log_timeline_picked_intel": "has picked up intelligence.",
      "log_timeline_captured_intel": "has captured intelligence.",
      "log_timeline_defended_intel": "has defended intelligence.",
      "log_timeline_dropped_intel": "has dropped intelligence.",
      "log_player_player_overview": "Player overview",
      "log_player_general_stats": "General stats",
      "log_player_class_overview": "Class overview",
      "log_player_class_compare": "Class compare",
      "log_player_match_matrix": "Match matrix",
      "log_player_awards": "Awards",
      "log_player_logs_tf_matches":
          "Player has <matches_count> matches in history",
      "log_player_matches": "Show matches",
      "log_player_observe": "Observe player",
      "log_player_observe_remove": "Remove from observed",
      "log_damage_per_minute": "Damage per minute",
      "log_kapd": "Kills & assists per death",
      "log_kpd": "Kills per death",
      "log_damage_taken_per_minute": "Damage taken per minute",
      "log_medkits": "Medkits",
      "log_global_average": "Global average",
      "log_team_average": "Team average",
      "log_opponent_team_average": "Opponent team average",
      "log_class": "Class",
      "log_class_time_played": "Time played",
      "log_class_highlights": "Class highlights",
      "log_class_weapon_stats": "Weapon stats",
      "log_class_overall_top_kills": "overall top kills",
      "log_class_overall_top_assists": "overall top assists",
      "log_class_overall_top_kpd": "overall top K/D",
      "log_class_overall_top_kapd": "overall top KA/D",
      "log_class_overall_top_damage": "overall top damage",
      "log_class_overall_top_dapm": "overall top DA/M",
      "log_class_medics_killed": "Medics killed",
      "log_class_overall_top_medics_killed": "overall top medics killed",
      "log_class_airshots": "Airshots",
      "log_class_overall_top_airshots": "overall top airshots",
      "log_class_caps": "Caps",
      "log_class_overall_top_caps": "overall top caps",
      "log_class_soldiers_killed": "Soldiers killed",
      "log_class_overall_top_soldiers_killed": "overall top soldiers killed",
      "log_class_avg_da": "Avg. DA",
      "log_class_shots": "Shots",
      "log_class_hits": "Hits",
      "log_class_accuracy": "Accuracy",
      "log_class_no_weapon_data": "No weapon data",
      "log_class_scouts_killed": "Scouts killed",
      "log_class_overall_top_scouts_killed": "overall top scouts killed",
      "log_class_medkits_picked": "Medkits picked",
      "log_class_overall_top_medkits_picked": "overall top medkits picked",
      "log_class_heavies_killed": "Heavies killed",
      "log_class_overall_top_heavies_killed": "overall top heavies killed",
      "log_class_overall_top_dt": "overall top dt",
      "log_class_demomans_killed": "Demomans killed",
      "log_class_overall_top_demomans_killed": "overall top demomans killed",
      "log_class_snipers_killed": "Snipers killed",
      "log_class_overall_top_snipers_killed": "overall top snipers killed",
      "log_class_headshots": "Headshots",
      "log_class_overall_top_headshots": "overall top headshots",
      "log_class_headshots_hits": "Headshot hits",
      "log_class_overall_top_headshot_hits": "overall top headshots hits",
      "log_class_backstabs": "Backstabs",
      "log_class_overall_top_backstabs": "overall top backstabs",
      "log_class_no_medic_data": "No medic data",
      "log_class_medic_healing": "Healing",
      "log_class_medic_charges": "Charges",
      "log_class_medic_hpm": "Heal/minute",
      "log_class_medic_drops": "Drops",
      "log_class_medic_drops_drops": "drop(s)",
      "log_class_medic_avg_time_to_build": "Avg time to build",
      "log_class_medic_avg_time_before_using": "Avg time before using",
      "log_class_medic_near_full": "Near full charge death",
      "log_class_medic_avg_uber_recipients": "Avg. uber recipients",
      "log_class_medic_deaths_after_charge": "Deaths after charge",
      "log_class_medic_major_advantage_lost": "Major advantages lost",
      "log_class_medic_biggest_advantage_lost": "Biggest advantage lost",
      "log_class_medic_deaths": "Death(s)",
      "log_class_medic_medigun_ubers": "Medigun uber(s)",
      "log_class_medic_krtizkrieg_ubers": "Kritzkrieg uber(s)",
      "log_class_medic_other_ubers": "Other uber(s)",
      "log_class_medic_avg_uber_length": "Avg uber length",
      "log_class_medic_charges": "charge(s)",
      "log_class_medic_seconds": "second(s)",
      "log_class_medic_players": "player(s)",
      "log_class_medic_deaths_deaths": "deaths(s)",
      "log_class_medic_advantages": "advantage(s)",
      "log_class_medic_healing_chart": "Healing chart",
      "log_class_medic_ubers_ubers": "Ubers",
      "log_compare_to": "Compare to",
      "log_compare_to_no_players":
          "There is no other player with same class to compare",
      "log_compare_wins": "wins",
      "log_compare_tie": "It's a tie",
      "log_compare_had": "had",
      "log_compare_more": "more",
      "log_compare_less": "less",
      "log_compare_than": "than",
      "log_compare_kills": "kills",
      "log_compare_assists": "assists",
      "log_compare_damage": "damage",
      "log_compare_dpm": "damage per minute",
      "log_compare_kapd": "kills & assists per death",
      "log_compare_kpd": "kills per death",
      "log_compare_damage_taken": "damage taken",
      "log_compare_captured_points": "Captured points",
      "log_compare_captured_points_captured_points": "captured points",
      "log_compare_captured_intel_captured_intel": "Intel captures",
      "log_compare_captured_intel": "intel captures",
      "log_compare_longest_kill_streak": "Longest kill streak",
      "log_compare_longest_kill_streak_longest_kill_streak":
          "longest kill streak",
      "log_compare_medkits_picked_medkits_picked": "medkits picked",
      "log_compare_medkits_picked": "Medkits picked",
      "log_compare_restored_hp_from_medkits": "Restored HP from medkits",
      "log_compare_restored_hp_from_medkits_restored_hp_from_medkits":
          "restored HP from medkits",
      "log_compare_headshots": "headshots",
      "log_compare_headshots_hits": "headshots hits",
      "log_compare_ubers_ubers": "ubers",
      "log_compare_drops": "drops",
      "log_compare_ubers": "Ubers",
      "log_matrix_class": "CLASS",
      "log_matrix_kills": "KILLS",
      "log_matrix_kills_and_assists": "K + A",
      "log_matrix_deaths": "DEATHS",
      "log_matrix_total": "Total",
      "log_player_awards_position": "Position",
      "log_player_awards_500_dpm_club_title": "500 DPM Club",
      "log_player_awards_500_dpm_club_description":
          "Players who had 500+ DPM in a game.",
      "log_player_awards_10k_damage_title": "10000 DMG Club",
      "log_player_awards_10k_damage_description":
          "Players who had 10k DMG in a game.",
      "log_player_awards_deathless_title": "Deathless",
      "log_player_awards_10k_deathless_description":
          "Players who had 0 deaths in a game.",
      "about_developer": "Developer",
      "about_ideas_tests": "Ideas, tests",
      "about_problems":
          "If you encountered any problem, please report it in project page.",
      "about_project_page": "Project page",
      "about_donate":
          "Do you like this app? You can donate TF2 items to the author!",
      "about_send_trade": "Send trade offer",
      "about_team_fortress_privacy":
          "Team Fortress, the Team Fortress logo, Steam, the Steam logo are trademarks and/or registered trademarks of Valve Corporation. Logs thanks to logs.tf created by zoob. Weapon images thanks to wiki.teamfortress.com.",
      "about_page": "Page",
    },
    'pl': {
      "help_mvp_title": "Jak jest obliczane MVP",
      "help_mvp_description":
          "Każda osoba jest oceniana na podstawie jego statystyk. Formuła obliczeń: zabójstwa * 0.39 + asysty * 0.2 + obrażenia * 0.01 + przejęcia * 0.2 + zabójstwa medyków * 0.2.",
      "help_bug_title": "Znalazłem buga!",
      "help_bug_description":
          "Super! Możesz przesłać go do developera. Przejdź do strony projektu i wyślij raport (możesz znaleźć stronę projektu w menu 'O Aplikacji').",
      "help_help_title": "Jak mogę pomóc?",
      "help_help_description":
          "Możesz przekazać swoje pomysły developerom na stronie projektu lub na steamie.",
      "help_free_title": "Czy ta aplikacja jest darmowa?",
      "help_free_description":
          "Tak, aplikacja jest darmowa i będzie darmowa na zawsze. Jeżeli lubisz tą aplikację, możesz przekazać datek autorom przez steam.",
      "help_purpose_title": "Jaki jest cel aplikacji?",
      "help_purpose_description":
          "Aplikacja jest detykowana profesjonalnym graczom Team Fortress 2, którzy chcą sprawdzić statystyki swoich meczy.",
      "help_data_title": "Skąd pochodzą dane?",
      "help_data_description": "Wszystkie dane pochodzą ze strony logs.tf.",
      "menu_help": "Pomoc",
      "menu_settings": "Ustawienia",
      "menu_about": "O Aplikacji",
      "logs_active_filters": "Aktywne filtry",
      "logs_all_matches": "Mecze",
      "logs_saved_players": "Zapisani gracze",
      "logs_saved_matches": "Zapisane mecze",
      "logs_no_logs_found": "Nie znaleziono logów.",
      "logs_players_observed_no_observed_players":
          "Nie znaleziono graczy. Kliknij na 'Obserwuj' w widoku detali gracza, aby go obserwować.",
      "logs_players_observed_no_data": "Nie znaleziono logów.",
      "logs_players_observed_player": "Gracz:",
      "logs_saved_no_data": "Brak zapisanych logów.",
      "logs_failed_to_load_logs":
          "Wystąpił problem podczas ładowania logów z logs.tf.",
      "unknown_error": "Nieznany błąd",
      "loading": "Ładowanie",
      "log_highlander_match": "Mecz Highlander",
      "log_6v6_match": "Mecz 6v6",
      "log_x_players_match": "Mecz <players_count> graczy",
      "log_bball_match": "Mecz BBall",
      "log_ultiduo_match": "Mecz Ultiduo",
      "log_x_v_x_match": "Mecz <players_count>v<players_count>",
      "log_search_logs_search": "Wyszukaj logów",
      "log_search_players_search": "Wyszukaj graczy",
      "log_search_map": "Mapa",
      "log_search_uploader": "Przesyłający",
      "log_search_title": "Tytuł",
      "log_search_player_steam_id": "Steam id gracza",
      "log_search_clear_filters": "Wyczyść filtry",
      "log_search_search": "Szukaj",
      "log_search_player_name": "Nazwa gracza",
      "retry": "Spróbuj ponownie",
      "settings_color_purple": "Fioletowy",
      "settings_color_orange": "Pomarańczowy",
      "settings_color_green": "Zielony",
      "settings_color_blue": "Niebieski",
      "settings_color_red": "Czerwony",
      "settings_color_pink": "Różowy",
      "settings_color_black": "Czarny",
      "settings_brightness_light": "Jasny",
      "settings_brightness_dark": "Ciemny",
      "settings_app_color": "Kolor aplikacji:",
      "settings_app_brightness": "Jasność aplikacji:",
      "settings_observed_players": "Obserwowani gracze:",
      "settings_clear_observed_players": "Wyczyść obserwowanych graczy",
      "settings_saved_matches": "Zapisane mecze:",
      "settings_clear_saved_matches": "Wyczyść zapisane mecze",
      "log_general_stats": "Statystyki ogólne",
      "log_players_stats": "Statystyki graczy",
      "log_players_matrix": "Macierz graczy",
      "log_awards_stats": "Nagrody",
      "log_match_timeline": "Oś czasu meczu",
      "log_metric": "METRYKA",
      "log_kills": "Zabójstwa",
      "log_deaths": "Śmierci",
      "log_assists": "Asysty",
      "log_damage": "Obrażenia",
      "log_damage_taken": "Obrażenia otrz.",
      "log_caps": "Przejęcia",
      "log_charges": "Ładunki",
      "log_drops": "Dropy",
      "log_hp_pickups": "Podniesione apt.",
      "log_hp_from_pickups": "HP z apteczek",
      "log_headshots": "Headshoty",
      "log_sentries": "Działka",
      "log_backstabs": "Backstaby",
      "log_map": "Mapa:",
      "log_type": "Typ:",
      "log_played_at": "Rozegrany:",
      "log_played": "Mecz trwał:",
      "log_uploaded_by": "Wysłany przez:",
      "log_match_id": "ID meczu:",
      "log_player": "Gracz",
      "log_class": "Klasa",
      "log_scroll_right_to_see_more":
          "Przesuń w prawo aby zobaczyć więcej statystyk",
      "log_stats": "Statystyka:",
      "log_kills_and_assists": "Zabójstwa i asysty",
      "log_award_mvp_title": "Naj. wartościowi gracze",
      "log_award_mvp_description":
          "Gracze, którzy byli najbardziej wartościowi w meczu.",
      "log_award_kills_title": "Naj. zabójstwa",
      "log_award_kills_description": "Gracze, którzy mieli najwięcej zabójstw.",
      "log_award_assists_title": "Naj. asysty",
      "log_award_assists_description":
          "Gracze, którzy mieli najwięcej asyst (bez medyków).",
      "log_award_damage_title": "Naj. obrażenia",
      "log_award_damage_description":
          "Gracze, którzy zadali najwięcej obrażeń.",
      "log_award_medic_kills_title": "Naj. zabójstw medyków",
      "log_award_medic_kills_description":
          "Gracze, którzy zabili najwięcej medyków.",
      "log_award_kpd_title": "Naj. zabójstw na śmierć",
      "log_award_kpd_description":
          "Gracze, którzy mieli najlepszą statystykę zabójstw na śmierć.",
      "log_award_kapd_title": "Naj. zabójstw i asyst na śmierć",
      "log_award_kapd_description":
          "Gracze, którzy mieli najwięcej zabójstw i asyst na śmierć.",
      "log_seconds": "sekund",
      "log_1st": "1sza",
      "log_2nd": "2ga",
      "log_3rd": "3cia",
      "log_nth": "<n>ta",
      "log_timeline_round_started": "runda wystartowała.",
      "log_timeline_capped_point": "przejęło punkt.",
      "log_timeline_medic_drop": "medyk umarł i zdropił ubera.",
      "log_timeline_medic_died": "medyk umarł.",
      "log_timeline_medic_charged": "medyk naładował ubera.",
      "log_timeline_won_round": "wygrało rundę.",
      "log_timeline_picked_intel": "podniosło intela.",
      "log_timeline_captured_intel": "przejęło intela.",
      "log_timeline_defended_intel": "obroniło intela.",
      "log_timeline_dropped_intel": "upuściło intela.",
      "log_player_player_overview": "Przegląd graczy",
      "log_player_general_stats": "Ogólne statystki",
      "log_player_class_overview": "Przegląd klas",
      "log_player_class_compare": "Porównanie klas",
      "log_player_match_matrix": "Macierz meczu",
      "log_player_awards": "Nagrody",
      "log_player_logs_tf_matches": "Gracz ma <matches_count> meczy w historii",
      "log_player_matches": "Pokaż mecze",
      "log_player_observe": "Obserwuj gracza",
      "log_player_observe_remove": "Usuń z obserwowanych",
      "log_damage_per_minute": "Obrażenia na minutę",
      "log_kapd": "Zabójstwa i asysty na śmierć",
      "log_kpd": "Zabójstwa na śmierć",
      "log_damage_taken_per_minute": "Obrażenia otrzymane na minutę",
      "log_medkits": "Apteczki",
      "log_global_average": "Średnia ogólna",
      "log_team_average": "Średnia drużyny",
      "log_opponent_team_average": "Średnia przeciwnej drużyny",
      "log_class": "Klasa",
      "log_class_time_played": "Czas grany",
      "log_class_highlights": "Naj. momenty klasy",
      "log_class_weapon_stats": "Statystyki broni",
      "log_class_overall_top_kills": "ogólnie najwięcej zabójstw",
      "log_class_overall_top_assists": "ogólnie najwięcej asyst",
      "log_class_overall_top_kpd": "najlepsze K/D",
      "log_class_overall_top_kapd": "najlepsze KA/D",
      "log_class_overall_top_damage": "najlepsze obrażenia",
      "log_class_overall_top_dapm": "najlepsze DA/M",
      "log_class_medics_killed": "Medycy zabici",
      "log_class_overall_top_medics_killed": "najwięcej zabitych medyków",
      "log_class_airshots": "Airshoty",
      "log_class_overall_top_airshots": "najwięcej airshotów",
      "log_class_caps": "Przejęcia",
      "log_class_overall_top_caps": "najwięcej przejęć",
      "log_class_soldiers_killed": "Żołnierze zabici",
      "log_class_overall_top_soldiers_killed": "najwięcej zabitych żołnierzy",
      "log_class_avg_da": "Śr. Obr.",
      "log_class_shots": "Strzały",
      "log_class_hits": "Trafienia",
      "log_class_accuracy": "Celność",
      "log_class_no_weapon_data": "Brak danych broni",
      "log_class_scouts_killed": "Skauci zabici",
      "log_class_overall_top_scouts_killed": "najwięcej zabitych skautów",
      "log_class_medkits_picked": "Podniesione medkity",
      "log_class_overall_top_medkits_picked": "naj. pod. medkitów",
      "log_class_heavies_killed": "Heavich zabitych",
      "log_class_overall_top_heavies_killed": "najwięcej zabitych heavich",
      "log_class_overall_top_dt": "największe DT",
      "log_class_demomans_killed": "Demomanów zabitych",
      "log_class_overall_top_demomans_killed": "naj. zabitych demomanów",
      "log_class_snipers_killed": "Snajperzy zabici",
      "log_class_overall_top_snipers_killed": "najwięcej zabitych sniperów",
      "log_class_headshots": "Headshoty",
      "log_class_overall_top_headshots": "najwięcej headshotów",
      "log_class_headshots_hits": "Uderzenia headshot",
      "log_class_overall_top_headshot_hits": "najwięcej uderzeń head.",
      "log_class_backstabs": "Backstaby",
      "log_class_overall_top_backstabs": "najwięcej backstabów",
      "log_class_no_medic_data": "Brak danych medyka",
      "log_class_medic_healing": "Leczenie",
      "log_class_medic_charges": "Ładunki",
      "log_class_medic_hpm": "Leczenie/minutę",
      "log_class_medic_drops": "Dropy",
      "log_class_medic_drops_drops": "drop(y)",
      "log_class_medic_avg_time_to_build": "Śr. czas ładowania ubera",
      "log_class_medic_avg_time_before_using": "Śr. czas przed użyciem ubera",
      "log_class_medic_near_full": "Dropy przy prawie nał. uberze",
      "log_class_medic_avg_uber_recipients": "Śr. odbiorcy ubera",
      "log_class_medic_deaths_after_charge": "Śmierci po nał. ubera",
      "log_class_medic_major_advantage_lost": "Główne przewagi utracone",
      "log_class_medic_biggest_advantage_lost": "Największa przewaga utracona",
      "log_class_medic_deaths": "Śmierć(i)",
      "log_class_medic_medigun_ubers": "Ubery Mediguna",
      "log_class_medic_krtizkrieg_ubers": "Ubery Kritzkriega",
      "log_class_medic_other_ubers": "Inne ubery:",
      "log_class_medic_avg_uber_length": "Śr. czas ubera",
      "log_class_medic_charges_charges": "ładunków",
      "log_class_medic_seconds": "sekund",
      "log_class_medic_players": "graczy",
      "log_class_medic_deaths_deaths": "śmerci",
      "log_class_medic_advantages": "przewagi",
      "log_class_medic_healing_chart": "Wykres leczenia",
      "log_class_medic_ubers_ubers": "uberów",
      "log_compare_to": "Porównaj do",
      "log_compare_to_no_players": "Nie ma innych graczy z tą samą klasą",
      "log_compare_wins": "wygrywa",
      "log_compare_tie": "Remis",
      "log_compare_had": "miał(a)",
      "log_compare_more": "więcej",
      "log_compare_less": "mniej",
      "log_compare_than": "niż",
      "log_compare_kills": "zabójstw",
      "log_compare_assists": "asyst",
      "log_compare_damage": "obrażeń",
      "log_compare_dpm": "obrażeń na minutę",
      "log_compare_kapd": "zabójstw i asyst na śmierć",
      "log_compare_kpd": "zabójstw na śmierć",
      "log_compare_damage_taken": "obrażenia przyjęta",
      "log_compare_captured_points": "Przejęte punkty",
      "log_compare_captured_points_captured_points": "przejęte punkty",
      "log_compare_captured_intel": "Przejęte intele",
      "log_compare_captured_intel_captured_intel": "przejętych inteli",
      "log_compare_longest_kill_streak": "Naj. seria zabójstw",
      "log_compare_longest_kill_streak_longest_kill_streak":
          "naj. serię zabójstw",
      "log_compare_medkits_picked_medkits_picked": "Podniesione medkity",
      "log_compare_medkits_picked": "podniesionych medkitów",
      "log_compare_restored_hp_from_medkits": "Przywrócone HP z medkitów",
      "log_compare_restored_hp_from_medkits_restored_hp_from_medkits":
          "przywróconych HP z medkitów",
      "log_compare_headshots": "headshotów",
      "log_compare_headshots_hits": "uderzeń headshot",
      "log_compare_ubers_ubers": "uberów",
      "log_compare_drops": "dropów",
      "log_compare_ubers": "Ubery",
      "log_matrix_class": "KLASA",
      "log_matrix_kills": "ZABÓJSTWA",
      "log_matrix_kills_and_assists": "ZAB. + ASYSTY",
      "log_matrix_deaths": "ŚMIERCI",
      "log_matrix_total": "Razem",
      "log_player_awards_position": "Pozycja",
      "log_player_awards_500_dpm_club_title": "Klub 500 DPM",
      "log_player_awards_500_dpm_club_description":
          "Gracze, którzy mieli 500+ DPM.",
      "log_player_awards_10k_damage_title": "Klub 10000 DMG",
      "log_player_awards_10k_damage_description":
          "Gracze, którzy mieli 10k obrażeń.",
      "log_player_awards_deathless_title": "Nieśmiertelny",
      "log_player_awards_10k_deathless_description":
          "Gracze, którzy mieli 0 śmierci.",
      "about_developer": "Developer",
      "about_ideas_tests": "Pomysły, testy",
      "about_problems":
          "Jeżeli znalazłeś błąd, zgłoś go na stronie projektu.",
      "about_project_page": "Strona projektu",
      "about_donate":
          "Podoba Ci się aplikacja? Możesz przekazać w ramach podziękowania przedmioty TF2 autorom!",
      "about_send_trade": "Wyślij ofertę wymiany",
      "about_team_fortress_privacy":
          "Team Fortress, logo Team Fortress, Steam, logo Steam są znakami towarowymi i / lub zastrzeżonymi znakami towarowymi Valve Corporation. Logi dzięki logs.tf utworzonemu przez zoob. Obrazy broni dzięki wiki.teamfortress.com.",
      "about_page": "Strona",
    }
  };

  String getText(String tag) {
    if (_localizedValues.containsKey(locale.languageCode) &&
        _localizedValues[locale.languageCode].containsKey(tag)) {
      return _localizedValues[locale.languageCode][tag];
    } else {
      return "???";
    }
  }
}
