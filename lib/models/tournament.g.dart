// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tournament _$TournamentFromJson(Map<String, dynamic> json) => Tournament(
      id: json['id'] as String,
      time: json['time'] as String?,
      can_register: json['can_register'] as bool? ?? true,
      teams: (json['teams'] as List<dynamic>?)
              ?.map((e) => TournamentTeam.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      winner: json['winner'] as String?,
      teams_positions: (json['teams_positions'] as List<dynamic>?)
              ?.map((e) =>
                  TournamentTeamPosition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tournament_combats: (json['tournament_combats'] as List<dynamic>?)
              ?.map((e) => TournamentCombat.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TournamentToJson(Tournament instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'can_register': instance.can_register,
      'teams': instance.teams,
      'winner': instance.winner,
      'teams_positions': instance.teams_positions,
      'tournament_combats': instance.tournament_combats,
    };
