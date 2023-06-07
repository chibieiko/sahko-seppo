// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electricity_price_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectricityPriceDto _$ElectricityPriceDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['startTime', 'endTime', 'centsPerMwh'],
  );
  return ElectricityPriceDto(
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
    centsPerMwh: json['centsPerMwh'] as num,
  );
}

Map<String, dynamic> _$ElectricityPriceDtoToJson(
        ElectricityPriceDto instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'centsPerMwh': instance.centsPerMwh,
    };
