import 'package:json_annotation/json_annotation.dart';

part 'evolvesTo.g.dart'; 

@JsonSerializable()
class EvolvesTo {
  final String name;
  final String id;

  EvolvesTo({
    required this.name,
    required this.id,
  });

  factory EvolvesTo.fromJson(Map<String, dynamic> json) => _$EvolvesToFromJson(json);
  Map<String, dynamic> toJson() => _$EvolvesToToJson(this);
}