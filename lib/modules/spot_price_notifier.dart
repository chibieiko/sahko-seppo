import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sahko_seppo/modules/spot_price_service.dart';
import 'package:sahko_seppo/modules/spot_price_state.dart';

class SpotPriceNotifier extends StateNotifier<SpotPriceState> {
  final SpotPriceService _service;

  SpotPriceNotifier(this._service) : super(SpotPriceState()) {
    _init();
  }

  Future<void> _init() async {
    final spotPrices = await _service.fetchSpotPrices();
    state = SpotPriceState(electricityPeriods: spotPrices);
  }

  Future<void> fetch() async {
    final spotPrices = await _service.fetchSpotPrices();
    state = SpotPriceState(electricityPeriods: spotPrices);
  }
}
