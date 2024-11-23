// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stat _$StatFromJson(Map<String, dynamic> json) => Stat(
      base_stat: (json['base_stat'] as num).toInt(),
      effort: (json['effort'] as num).toInt(),
      stat: Item.fromJson(json['stat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'base_stat': instance.base_stat,
      'effort': instance.effort,
      'stat': instance.stat,
    };
