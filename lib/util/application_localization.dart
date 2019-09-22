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
      "log_search_player_name":"Player name",
      "retry":"Retry"
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
      "logs_all_matches": "Wszystkie mecze",
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
      "log_search_player_name":"Nazwa gracza",
      "retry":"Spróbuj ponownie"
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
