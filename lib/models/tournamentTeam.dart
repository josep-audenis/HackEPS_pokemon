import 'package:json_annotation/json_annotation.dart';

part 'tournamentTeam.g.dart';

@JsonSerializable()
class TournamentTeam {
  final String team_id;
  final List<String> pokemon_uuid_list;

  TournamentTeam({
    required this.team_id,
    this.pokemon_uuid_list = const [],
  });

  factory TournamentTeam.fromJson(Map<String, dynamic> json) => _$TournamentTeamFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentTeamToJson(this);
}