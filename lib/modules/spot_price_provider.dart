import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahko_seppo/data/price_api.dart';
import 'package:sahko_seppo/data/spot_price_repository.dart';
import 'package:sahko_seppo/modules/spot_price_notifier.dart';
import 'package:sahko_seppo/modules/spot_price_state.dart';

final spotPriceProvider =
    StateNotifierProvider<SpotPriceNotifier, SpotPriceState>(
  (ref) => SpotPriceNotifier(
      SpotPriceRepository(electricityApi: ElectricityApi(Dio()))),
);
