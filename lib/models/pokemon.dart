import 'package:lspokedex/models/pokemonAttributes/ability.dart';
import 'package:lspokedex/models/pokemonAttributes/evolvesTo.dart';
import 'package:lspokedex/models/pokemonAttributes/item.dart';
import 'package:lspokedex/models/pokemonAttributes/stat.dart';
import 'package:lspokedex/models/pokemonAttributes/type.dart';


import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon {
  int id;
  final String name;
  final List<Ability> abilities;
  final String cries;
  final int height;
  final List<String> location_area_encounters;
  final List<EvolvesTo?> evolves_to;
  final List<Item> moves;
  final Item species;
  final String image;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  Pokemon({
    required this.id,
    required this.name,
    required this.abilities,
    required this.cries,
    required this.height,
    required this.location_area_encounters,
    required this.evolves_to,
    required this.moves,
    required this.species,
    required this.image,
    required this.stats,
    required this.types,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}
