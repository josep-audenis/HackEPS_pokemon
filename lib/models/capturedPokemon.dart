import 'package:json_annotation/json_annotation.dart';

part 'capturedPokemon.g.dart';

@JsonSerializable()
class CapturedPokemon {
  final String id;
  final int pokemon_id;

  CapturedPokemon({
    required this.id,
    required this.pokemon_id,
  });

  factory CapturedPokemon.fromJson(Map<String, dynamic> json) => _$CapturedPokemonFromJson(json);
  Map<String, dynamic> toJson() => _$CapturedPokemonToJson(this);
}