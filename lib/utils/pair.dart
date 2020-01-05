class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);

  factory Pair.reverse(Pair pair) {
    return Pair(pair.second, pair.first);
  }
}
