import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:sahko_seppo/data/price_api.dart';
import 'package:sahko_seppo/data/electricity_models.dart';

class SpotPriceService {
  final _electricityApi = ElectricityApi(Dio());

  Future<List<ElectricityPeriod>> fetchSpotPrices() async {
    DateTime now = DateTime.now();
    String startString = _getDateString(now.subtract(const Duration(days: 1)));
    String endString = _getDateString(now);

    MarketDocument marketDocument = await _electricityApi.getSpotPrices(
      dotenv.env['ENTSOE_ACCESS_TOKEN'] ?? "",
      "A44", // Document type
      "10YFI-1--------U", // EIC code for Finland
      "10YFI-1--------U", // EIC code for Finland
      startString,
      endString,
    );

    return marketDocument.electricityPeriods;
  }

  String _getDateString(DateTime date) {
    return "${date.year}${date.month.doubleDigit()}${date.day.doubleDigit()}0000";
  }
}

extension DoubleDigitString on int {
  String doubleDigit() {
    if (toString().length < 2) {
      return "0$this";
    } else {
      return toString();
    }
  }
}
