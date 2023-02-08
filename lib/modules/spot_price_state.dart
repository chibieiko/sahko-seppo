import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sahko_seppo/modules/electricity_price.dart';

part 'spot_price_state.freezed.dart';

@freezed
class SpotPriceState with _$SpotPriceState {
  factory SpotPriceState(
      {required List<ElectricityPrice> electricityPrices,
      required bool isLoading}) = _SpotPriceState;
}
