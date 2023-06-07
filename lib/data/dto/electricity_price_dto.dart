import 'package:json_annotation/json_annotation.dart';
import 'package:sahko_seppo/modules/electricity_price.dart';

part 'electricity_price_dto.g.dart';

@JsonSerializable()
class ElectricityPriceDto {
  @JsonKey(required: true)
  String startTime;

  @JsonKey(required: true)
  String endTime;

  @JsonKey(required: true)
  num centsPerMwh;

  ElectricityPriceDto(
      {required this.startTime,
      required this.endTime,
      required this.centsPerMwh});

  factory ElectricityPriceDto.fromJson(Map<String, dynamic> json) =>
      _$ElectricityPriceDtoFromJson(json);
}

extension ToEntity on ElectricityPriceDto {
  ElectricityPrice toEntity() {
    return ElectricityPrice(
        startTime: DateTime.parse(startTime),
        endTime: DateTime.parse(endTime),
        centsPerMwh: centsPerMwh);
  }
}
