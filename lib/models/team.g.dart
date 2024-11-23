// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: json['id'] as String,
      name: json['name'] as String,
      pve_score: (json['pve_score'] as num?)?.toInt() ?? 0,
      pvp_score: (json['pvp_score'] as num?)?.toInt() ?? 0,
      pokedex_score: (json['pokedex_score'] as num?)?.toInt() ?? 0,
      captured_pokemons: (json['captured_pokemons'] as List<dynamic>?)
              ?.map((e) => CapturedPokemon.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      is_active: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pve_score': instance.pve_score,
      'pvp_score': instance.pvp_score,
      'pokedex_score': instance.pokedex_score,
      'captured_pokemons': instance.captured_pokemons,
      'is_active': instance.is_active,
    };
