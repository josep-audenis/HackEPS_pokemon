// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournamentCombat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentCombat _$TournamentCombatFromJson(Map<String, dynamic> json) =>
    TournamentCombat(
      teams: (json['teams'] as List<dynamic>).map((e) => e as String).toList(),
      winner: json['winner'] as String,
      turns: (json['turns'] as List<dynamic>?)
              ?.map((e) => TournamentTurn.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TournamentCombatToJson(TournamentCombat instance) =>
    <String, dynamic>{
      'teams': instance.teams,
      'winner': instance.winner,
      'turns': instance.turns,
    };
