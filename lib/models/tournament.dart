import 'package:json_annotation/json_annotation.dart';
import 'package:lspokedex/models/tournamentCombat.dart';
import 'package:lspokedex/models/tournamentTeam.dart';
import 'package:lspokedex/models/tournamentTeamPosition.dart';

part 'tournament.g.dart';

@JsonSerializable()
class Tournament {
  final String id;
  final String? time;
  final bool can_register;
  final List<TournamentTeam> teams;
  final String? winner;
  final List<TournamentTeamPosition> teams_positions;
  final List<TournamentCombat> tournament_combats;

  Tournament({
    required this.id,
    this.time,
    this.can_register = true,
    this.teams = const [],
    this.winner,
    this.teams_positions = const [],
    this.tournament_combats = const [],
  });

  factory Tournament.fromJson(Map<String, dynamic> json) => _$TournamentFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentToJson(this);
}