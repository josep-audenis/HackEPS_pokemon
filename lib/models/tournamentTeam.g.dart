// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournamentTeam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentTeam _$TournamentTeamFromJson(Map<String, dynamic> json) =>
    TournamentTeam(
      team_id: json['team_id'] as String,
      pokemon_uuid_list: (json['pokemon_uuid_list'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TournamentTeamToJson(TournamentTeam instance) =>
    <String, dynamic>{
      'team_id': instance.team_id,
      'pokemon_uuid_list': instance.pokemon_uuid_list,
    };
