class HealSpread {
  final String name;
  final List<String> classes;
  final double percentage;
  final int health;

  HealSpread(this.name, this.classes, this.percentage, this.health);

  @override
  String toString() {
    return 'HealSpread{name: $name, percentage: $percentage}';
  }


}
