import 'package:lspokedex/models/pokemonAttributes/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ability.g.dart';

@JsonSerializable()
class Ability {
  final Item ability;
  final bool is_hidden;
  final int slot;

  Ability({
    required this.ability,
    required this.is_hidden,
    required this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);
  
  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}



