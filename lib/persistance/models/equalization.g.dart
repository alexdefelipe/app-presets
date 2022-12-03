// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equalization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Equalization _$EqualizationFromJson(Map<String, dynamic> json) => Equalization()
  ..bass = (json['bass'] as num).toDouble()
  ..middle = (json['middle'] as num).toDouble()
  ..treble = (json['treble'] as num).toDouble();

Map<String, dynamic> _$EqualizationToJson(Equalization instance) =>
    <String, dynamic>{
      'bass': instance.bass,
      'middle': instance.middle,
      'treble': instance.treble,
    };
