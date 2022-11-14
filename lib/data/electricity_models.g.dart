// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electricity_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketDocument _$MarketDocumentFromJson(Map<String, dynamic> json) =>
    MarketDocument(
      electricityPeriods: (json['TimeSeries'] as List<dynamic>)
          .map((e) => ElectricityPeriod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MarketDocumentToJson(MarketDocument instance) =>
    <String, dynamic>{
      'TimeSeries': instance.electricityPeriods,
    };

ElectricityPeriod _$ElectricityPeriodFromJson(Map<String, dynamic> json) =>
    ElectricityPeriod(
      timeInterval:
          TimeInterval.fromJson(json['timeInterval'] as Map<String, dynamic>),
      electricityPoints: (json['Point'] as List<dynamic>)
          .map((e) => ElectricityPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ElectricityPeriodToJson(ElectricityPeriod instance) =>
    <String, dynamic>{
      'timeInterval': instance.timeInterval,
      'Point': instance.electricityPoints,
    };

TimeInterval _$TimeIntervalFromJson(Map<String, dynamic> json) => TimeInterval(
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
    );

Map<String, dynamic> _$TimeIntervalToJson(TimeInterval instance) =>
    <String, dynamic>{
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };

Point _$PointFromJson(Map<String, dynamic> json) => Point(
      electricityPoints: (json['Point'] as List<dynamic>)
          .map((e) => ElectricityPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PointToJson(Point instance) => <String, dynamic>{
      'Point': instance.electricityPoints,
    };

ElectricityPoint _$ElectricityPointFromJson(Map<String, dynamic> json) =>
    ElectricityPoint(
      position: json['position'] as int,
      price: (json['price.amount'] as num).toDouble(),
    );

Map<String, dynamic> _$ElectricityPointToJson(ElectricityPoint instance) =>
    <String, dynamic>{
      'position': instance.position,
      'price.amount': instance.price,
    };
