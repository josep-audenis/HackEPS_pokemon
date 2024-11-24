import 'package:json_annotation/json_annotation.dart';

part 'tournamentTeamPosition.g.dart';

@JsonSerializable()
class TournamentTeamPosition {
  final String team_id;
  final List<String> pokemon_uuid_list;

  TournamentTeamPosition({
    required this.team_id,
    required this.pokemon_uuid_list,
  });

  factory TournamentTeamPosition.fromJson(Map<String, dynamic> json) => _$TournamentTeamPositionFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentTeamPositionToJson(this);
}
