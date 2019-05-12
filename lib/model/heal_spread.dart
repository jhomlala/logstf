class HealSpread {
  final String name;
  final List<String> classes;
  final double percentage;

  HealSpread(this.name, this.classes, this.percentage);

  @override
  String toString() {
    return 'HealSpread{name: $name, percentage: $percentage}';
  }


}
