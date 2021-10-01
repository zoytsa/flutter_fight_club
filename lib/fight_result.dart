class FightResult {
  final String result;

  const FightResult._(this.result);

  static const won = FightResult._('won');
  static const lost = FightResult._('lost');
  static const draw = FightResult._('draw');

  static FightResult? calculateResult(
      final int yourLives, final int enemysLife) {
    if (yourLives == 0 && enemysLife == 0) {
      return draw;
    } else if (yourLives == 0) {
      return lost;
    } else if (enemysLife == 0) {
      return won;
    }
  }
}
