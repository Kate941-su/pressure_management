// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pressure_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PressureItem _$$_PressureItemFromJson(Map<String, dynamic> json) =>
    _$_PressureItem(
      uuid: json['uuid'] as String?,
      maxPressure: json['maxPressure'] as int?,
      minPressure: json['minPressure'] as int?,
      pulse: json['pulse'] as int?,
      measurementTime: json['measurementTime'] == null
          ? null
          : DateTime.parse(json['measurementTime'] as String),
    );

Map<String, dynamic> _$$_PressureItemToJson(_$_PressureItem instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'maxPressure': instance.maxPressure,
      'minPressure': instance.minPressure,
      'pulse': instance.pulse,
      'measurementTime': instance.measurementTime?.toIso8601String(),
    };
