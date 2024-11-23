import 'package:json_annotation/json_annotation.dart';
import 'package:lspokedex/models/pokemonAttributes/item.dart';

part 'type.g.dart';

@JsonSerializable()
class Type {
  final int slot;
  final Item type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
  Map<String, dynamic> toJson() => _$TypeToJson(this);
}