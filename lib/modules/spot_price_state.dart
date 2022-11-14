import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:sahko_seppo/data/electricity_models.dart';

part 'spot_price_state.freezed.dart';

@freezed
class SpotPriceState with _$SpotPriceState {
  factory SpotPriceState(
      {required List<ElectricityPeriod> electricityPeriods,
      required bool isLoading}) = _SpotPriceState;
}
