import 'package:json_annotation/json_annotation.dart';

part 'tournamentTurn.g.dart';

@JsonSerializable()
class TournamentTurn {
  final List<String> pokemons;
  final String winner;

  TournamentTurn({
    required this.pokemons,
    required this.winner,
  });

  factory TournamentTurn.fromJson(Map<String, dynamic> json) => _$TournamentTurnFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentTurnToJson(this);
}