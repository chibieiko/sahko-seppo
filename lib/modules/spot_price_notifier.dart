import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahko_seppo/data/spot_price_repository.dart';
import 'package:sahko_seppo/modules/spot_price_state.dart';

SpotPriceState initialState =
    SpotPriceState(electricityPrices: List.empty(), isLoading: true);

class SpotPriceNotifier extends StateNotifier<SpotPriceState> {
  final SpotPriceRepository _service;

  SpotPriceNotifier(this._service) : super(initialState) {
    fetch();
  }

  Future<void> fetch() async {
    state = state.copyWith(isLoading: true);
    final spotPrices =
        await _service.fetchSpotPrices(const String.fromEnvironment('API_KEY'));
    state = state.copyWith(electricityPrices: spotPrices, isLoading: false);
  }
}
