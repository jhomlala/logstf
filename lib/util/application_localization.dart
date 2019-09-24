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
      "log_scroll_right_to_see_more":"Scroll right to see more stats",
      "log_stats": "Stats:",
      "log_kills_and_assists":"Kills and Assists",
      "log_award_mvp_title":"Most valuable players",
      "log_award_mvp_description":"Players which were most valuable in game.",
      "log_award_kills_title":"Top kills",
      "log_award_kills_description":"Players which had most kills overall.",
      "log_award_assists_title":"Top assists",
      "log_award_assists_description":"Players which had most asissts overall (without medics).",
      "log_award_damage_title":"Top damage",
      "log_award_damage_description":"Players which dealed the most damage.",
      "log_award_medic_kills_title":"Top medic kills",
      "log_award_medic_kills_description":"Players which killed most medics.",
      "log_award_kpd_title":"Top kills per deaths",
      "log_award_kpd_description":"Players which had best kills per deaths.",
      "log_award_kapd_title":"Top kills & assists per deaths",
      "log_award_kapd_description":"Players which had best kills & assists per deaths.",
      "log_seconds":"seconds",
      "log_1st":"1st",
      "log_2nd":"2nd",
      "log_3rd":"3rd",
      "log_nth":"<n>th",
      "log_timeline_round_started":"<round_id> round started.",
      "log_timeline_capped_point":"has capped point.",
      "log_timeline_medic_drop":"medic has died and dropped uber.",
      "log_timeline_medic_died":"medic has died.",
      "log_timeline_medic_charged":"medic has charged uber.",
      "log_timeline_won_round":"has won round.",
      "log_timeline_picked_intel":"has picked up intelligence.",
      "log_timeline_captured_intel":"has captured intelligence.",
      "log_timeline_defended_intel":"has defended intelligence.",
      "log_timeline_dropped_intel":"has dropped intelligence."


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
      "log_hp_pickups": "HP pickupy",
      "log_hp_from_pickups": "HP z pickupów",
      "log_headshots": "Headshoty",
      "log_sentries": "Działka",
      "log_backstabs": "Backstaby",
      "log_map": "Mapa:",
      "log_type": "Typ:",
      "log_played_at": "Grany o:",
      "log_played": "Grany:",
      "log_uploaded_by": "Zuploadowany przez:",
      "log_match_id": "Id meczu:",
      "log_player": "Gracz",
      "log_class": "Klasa",
      "log_scroll_right_to_see_more":"Przesuń w prawo aby zobaczyć więcej statystyk",
      "log_stats": "Statystyka:",
      "log_kills_and_assists":"Zabójstwa i Asysty",
      "log_award_mvp_title":"Naj. wartościowi gracze",
      "log_award_mvp_description":"Gracze, którzy byli najbardziej wartościowi w meczu.",
      "log_award_kills_title":"Naj. zabójstwa",
      "log_award_kills_description":"Gracze, którzy mieli najwięcej zabójstw.",
      "log_award_assists_title":"Naj. asysty",
      "log_award_assists_description":"Gracze, którzy mieli najwięcej asyst (bez medyków).",
      "log_award_damage_title":"Naj. obrażenia",
      "log_award_damage_description":"Gracze, którzy zadali najwięcej obrażeń.",
      "log_award_medic_kills_title":"Naj. zabójstw medyków",
      "log_award_medic_kills_description":"Gracze, którzy zabili najwięcej medyków.",
      "log_award_kpd_title":"Naj. zabójstw na śmierć",
      "log_award_kpd_description":"Gracze, którzy mieli najlepszą statystykę zabójstw na śmierć.",
      "log_award_kapd_title":"Naj. zabójstw i asyst na śmierć",
      "log_award_kapd_description":"Gracze, którzy mieli najwięcej zabójstw i asyst na śmierć.",
      "log_seconds":"sekund",
      "log_1st":"1sza",
      "log_2nd":"2ga",
      "log_3rd":"3cia",
      "log_nth":"<n>ta",
      "log_timeline_round_started":"runda wystartowała.",
      "log_timeline_capped_point":"przejął punkt.",
      "log_timeline_medic_drop":"medyk umarł i zdropił ubera.",
      "log_timeline_medic_died":"medyk umarł.",
      "log_timeline_medic_charged":"medyk naładował ubera.",
      "log_timeline_won_round":"wygrał rundę.",
      "log_timeline_picked_intel":"podniósł intela.",
      "log_timeline_captured_intel":"przejął intela.",
      "log_timeline_defended_intel":"obronił intela.",
      "log_timeline_dropped_intel":"upuścił intela."

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