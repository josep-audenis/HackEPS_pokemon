import 'package:json_annotation/json_annotation.dart';
import 'package:lspokedex/models/tournamentTurn.dart';

part 'tournamentCombat.g.dart';

@JsonSerializable()
class TournamentCombat {
  final List<String> teams;
  final String winner;
  final List<TournamentTurn> turns;

  TournamentCombat({
    required this.teams,
    required this.winner,
    this.turns = const [],
  });

  factory TournamentCombat.fromJson(Map<String, dynamic> json) => _$TournamentCombatFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentCombatToJson(this);
}
