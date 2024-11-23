// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
      ability: Item.fromJson(json['ability'] as Map<String, dynamic>),
      is_hidden: json['is_hidden'] as bool,
      slot: (json['slot'] as num).toInt(),
    );

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'ability': instance.ability,
      'is_hidden': instance.is_hidden,
      'slot': instance.slot,
    };
