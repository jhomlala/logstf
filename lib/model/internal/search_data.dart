class SearchData {
  String map;
  String uploader;
  String title;
  String player;
  bool clearData;

  SearchData(
      {this.map,
      this.uploader,
      this.title,
      this.player,
      this.clearData = false});

  @override
  String toString() {
    return 'SearchData{map: $map, uploader: $uploader, title: $title, player: $player, clearData: $clearData}';
  }


}
