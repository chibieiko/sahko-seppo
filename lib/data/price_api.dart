import 'dart:developer';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:sahko_seppo/data/electricity_models.dart';
import 'package:sahko_seppo/utils/utils.dart';

part 'price_api.g.dart';

@RestApi(baseUrl: "https://web-api.tp.entsoe.eu/api")
abstract class ElectricityApi {
  factory ElectricityApi(Dio dio, {String? baseUrl}) {
    dio.interceptors.addAll([
      InterceptorsWrapper(onResponse: (Response response, handler) {
        response.data = Utils.decodeXmlResponseToJson(response.data);
        return handler.next(response);
      }, onError: (DioError e, handler) {
        log("Error: $e");
        return handler.next(e);
      })
    ]);

    return _ElectricityApi(dio, baseUrl: baseUrl);
  }

  @GET("")
  @DioResponseType(ResponseType.plain)
  Future<MarketDocument> getSpotPrices(
    @Query("securityToken") String securityToken,
    @Query("documentType") String documentType,
    @Query("in_Domain") String inDomain,
    @Query("out_Domain") String outDomain,
    @Query("periodStart") String periodStart,
    @Query("periodEnd") String periodEnd,
  );
}
