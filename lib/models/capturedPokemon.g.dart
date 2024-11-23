// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capturedPokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapturedPokemon _$CapturedPokemonFromJson(Map<String, dynamic> json) =>
    CapturedPokemon(
      id: json['id'] as String,
      pokemon_id: (json['pokemon_id'] as num).toInt(),
    );

Map<String, dynamic> _$CapturedPokemonToJson(CapturedPokemon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pokemon_id': instance.pokemon_id,
    };
