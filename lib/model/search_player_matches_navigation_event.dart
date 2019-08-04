import 'navigation_event.dart';

class SearchPlayerMatchesNavigationEvent extends NavigationEvent{
  final String steamId;

  SearchPlayerMatchesNavigationEvent(this.steamId) : super("SEARCH_PLAYER_MATCHES");

}