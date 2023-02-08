import 'package:sahko_seppo/data/electricity_price_dto.dart';
import 'package:sahko_seppo/data/price_api.dart';
import 'package:sahko_seppo/modules/electricity_price.dart';
import 'package:sahko_seppo/modules/spot_price_repository_interface.dart';

class SpotPriceRepository implements SpotPriceRepositoryInterface {
  final ElectricityApi electricityApi;

  SpotPriceRepository({required this.electricityApi});

  @override
  Future<List<ElectricityPrice>> fetchSpotPrices(String apiKey) async {
    List<ElectricityPriceDto> prices =
        await electricityApi.getSpotPrices(apiKey);

    return prices.map((e) => e.toEntity()).toList();
  }
}
