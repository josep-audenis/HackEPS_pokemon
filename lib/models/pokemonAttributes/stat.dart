import 'package:lspokedex/models/pokemonAttributes/item.dart';

class Stat {
    final int base_stat;
    final int effort;
    final Item stat;

  Stat({required this.base_stat, required this.effort, required this.stat});
}