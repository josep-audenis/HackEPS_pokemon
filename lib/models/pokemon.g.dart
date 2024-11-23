// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) => Pokemon(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => Ability.fromJson(e as Map<String, dynamic>))
          .toList(),
      cries: json['cries'] as String,
      height: (json['height'] as num).toInt(),
      location_area_encounters:
          (json['location_area_encounters'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      evolves_to: (json['evolves_to'] as List<dynamic>)
          .map((e) =>
              e == null ? null : EvolvesTo.fromJson(e as Map<String, dynamic>))
          .toList(),
      moves: (json['moves'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      species: Item.fromJson(json['species'] as Map<String, dynamic>),
      image: json['image'] as String,
      stats: (json['stats'] as List<dynamic>)
          .map((e) => Stat.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: (json['types'] as List<dynamic>)
          .map((e) => Type.fromJson(e as Map<String, dynamic>))
          .toList(),
      weight: (json['weight'] as num).toInt(),
    );

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abilities': instance.abilities,
      'cries': instance.cries,
      'height': instance.height,
      'location_area_encounters': instance.location_area_encounters,
      'evolves_to': instance.evolves_to,
      'moves': instance.moves,
      'species': instance.species,
      'image': instance.image,
      'stats': instance.stats,
      'types': instance.types,
      'weight': instance.weight,
    };
