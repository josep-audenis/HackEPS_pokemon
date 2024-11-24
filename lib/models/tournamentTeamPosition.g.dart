// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournamentTeamPosition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentTeamPosition _$TournamentTeamPositionFromJson(
        Map<String, dynamic> json) =>
    TournamentTeamPosition(
      team_id: json['team_id'] as String,
      pokemon_uuid_list: (json['pokemon_uuid_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TournamentTeamPositionToJson(
        TournamentTeamPosition instance) =>
    <String, dynamic>{
      'team_id': instance.team_id,
      'pokemon_uuid_list': instance.pokemon_uuid_list,
    };
