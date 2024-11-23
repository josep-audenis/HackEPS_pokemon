import 'package:json_annotation/json_annotation.dart';
import 'package:lspokedex/models/pokemonAttributes/item.dart';

part 'stat.g.dart';

@JsonSerializable()
class Stat {
  final int base_stat;
  final int effort;
  final Item stat;

  Stat({
    required this.base_stat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
  Map<String, dynamic> toJson() => _$StatToJson(this);
}