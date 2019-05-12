class MedicStats {
  final int deathsWith9599Uber;
  final int advantagesLost;
  final int biggestAdvantageLost;
  final int deathsWithin20sAfterUber;
  final double avgTimeBeforeHealing;
  final double avgTimeToBuild;
  final double avgTimeBeforeUsing;
  final double avgUberLength;

  MedicStats(
      {this.deathsWith9599Uber,
      this.advantagesLost,
      this.biggestAdvantageLost,
      this.deathsWithin20sAfterUber,
      this.avgTimeBeforeHealing,
      this.avgTimeToBuild,
      this.avgTimeBeforeUsing,
      this.avgUberLength});

  factory MedicStats.fromJson(Map<String, dynamic> json) => MedicStats(
      deathsWith9599Uber: json["deaths_with_95_99_uber"],
      advantagesLost: json["advantages_lost"],
      biggestAdvantageLost: json["biggest_advantage_lost"],
      deathsWithin20sAfterUber: json["deaths_within_20s_after_uber"],
      avgTimeBeforeHealing: json["avg_time_before_healing"].toDouble(),
      avgTimeToBuild: json ["avg_time_to_build"].toDouble(),
      avgTimeBeforeUsing: json["avg_time_before_using"].toDouble(),
      avgUberLength: json["avg_uber_length"].toDouble());
}
