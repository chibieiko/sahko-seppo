import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sahko_seppo/modules/spot_price_notifier.dart';
import 'package:sahko_seppo/modules/spot_price_service.dart';
import 'package:sahko_seppo/modules/spot_price_state.dart';

final spotPriceProvider =
    StateNotifierProvider<SpotPriceNotifier, SpotPriceState>(
  (ref) => SpotPriceNotifier(SpotPriceService()),
);
