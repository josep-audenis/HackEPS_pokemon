// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournamentTurn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentTurn _$TournamentTurnFromJson(Map<String, dynamic> json) =>
    TournamentTurn(
      pokemons:
          (json['pokemons'] as List<dynamic>).map((e) => e as String).toList(),
      winner: json['winner'] as String,
    );

Map<String, dynamic> _$TournamentTurnToJson(TournamentTurn instance) =>
    <String, dynamic>{
      'pokemons': instance.pokemons,
      'winner': instance.winner,
    };
