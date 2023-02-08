import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahko_seppo/data/electricity_price_dto.dart';

part 'price_api.g.dart';

@RestApi()
abstract class ElectricityApi {
  factory ElectricityApi(Dio dio, {String? baseUrl}) {
    dio.interceptors.addAll([
      InterceptorsWrapper(onResponse: (Response response, handler) {
        return handler.next(response);
      }, onError: (DioError e, handler) {
        log("Error: $e");
        return handler.next(e);
      })
    ]);

    return _ElectricityApi(dio, baseUrl: dotenv.env['API_BASE_URL']);
  }

  @GET("/electricity-prices")
  @DioResponseType(ResponseType.json)
  Future<List<ElectricityPriceDto>> getSpotPrices(
    @Header("x-api-key") String apiKey,
  );
}
