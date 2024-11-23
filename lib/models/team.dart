import 'package:lspokedex/models/capturedPokemon.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable()
class Team {
  final String id;
  final String name;
  final int pve_score;
  final int pvp_score;
  final int pokedex_score;
  final List<CapturedPokemon> captured_pokemons;
  final bool is_active;

  Team({
    required this.id,
    required this.name,
    this.pve_score = 0,
    this.pvp_score = 0,
    this.pokedex_score = 0,
    this.captured_pokemons = const [],
    this.is_active = true,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}