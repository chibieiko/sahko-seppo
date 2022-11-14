import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sahko_seppo/modules/spot_price_service.dart';
import 'package:sahko_seppo/modules/spot_price_state.dart';

SpotPriceState initialState =
    SpotPriceState(electricityPeriods: List.empty(), isLoading: true);

class SpotPriceNotifier extends StateNotifier<SpotPriceState> {
  final SpotPriceService _service;

  SpotPriceNotifier(this._service) : super(initialState) {
    fetch();
  }

  Future<void> fetch() async {
    state = state.copyWith(isLoading: true);
    final spotPrices = await _service.fetchSpotPrices();
    state = state.copyWith(electricityPeriods: spotPrices, isLoading: false);
  }
}
