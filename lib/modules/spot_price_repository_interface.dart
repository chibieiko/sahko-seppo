import 'package:sahko_seppo/modules/electricity_price.dart';

abstract class SpotPriceRepositoryInterface {
  Future<List<ElectricityPrice>> fetchSpotPrices(String apiKey);
}
