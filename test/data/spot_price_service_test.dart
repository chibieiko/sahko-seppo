import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sahko_seppo/data/dto/electricity_price_dto.dart';
import 'package:sahko_seppo/data/price_api.dart';
import 'package:sahko_seppo/data/spot_price_repository.dart';
import 'package:sahko_seppo/modules/electricity_price.dart';

@GenerateNiceMocks([MockSpec<Dio>(), MockSpec<ElectricityApi>()])
import 'spot_price_service_test.mocks.dart';

void main() {
  List<ElectricityPriceDto> mockPrices = [
    ElectricityPriceDto(
        startTime: "2022-12-18T15:00:00Z",
        endTime: "2022-12-18T16:00:00Z",
        centsPerMwh: 17216),
    ElectricityPriceDto(
        startTime: "2022-12-18T16:00:00Z",
        endTime: "2022-12-18T17:00:00Z",
        centsPerMwh: 20428),
    ElectricityPriceDto(
        startTime: "2022-12-18T17:00:00Z",
        endTime: "2022-12-18T18:00:00Z",
        centsPerMwh: 22065),
    ElectricityPriceDto(
        startTime: "2022-12-18T18:00:00Z",
        endTime: "2022-12-18T19:00:00Z",
        centsPerMwh: 20829),
    ElectricityPriceDto(
        startTime: "2022-12-18T19:00:00Z",
        endTime: "2022-12-18T20:00:00Z",
        centsPerMwh: 13002),
    ElectricityPriceDto(
        startTime: "2022-12-18T20:00:00Z",
        endTime: "2022-12-18T21:00:00Z",
        centsPerMwh: 16308),
    ElectricityPriceDto(
        startTime: "2022-12-18T21:00:00Z",
        endTime: "2022-12-18T22:00:00Z",
        centsPerMwh: 13076),
    ElectricityPriceDto(
        startTime: "2022-12-18T22:00:00Z",
        endTime: "2022-12-18T23:00:00Z",
        centsPerMwh: 10322),
    ElectricityPriceDto(
        startTime: "2022-12-18T23:00:00Z",
        endTime: "2022-12-19T00:00:00Z",
        centsPerMwh: 5564),
    ElectricityPriceDto(
        startTime: "2022-12-19T00:00:00Z",
        endTime: "2022-12-19T01:00:00Z",
        centsPerMwh: 6020),
    ElectricityPriceDto(
        startTime: "2022-12-19T01:00:00Z",
        endTime: "2022-12-19T02:00:00Z",
        centsPerMwh: 5861),
    ElectricityPriceDto(
        startTime: "2022-12-19T02:00:00Z",
        endTime: "2022-12-19T03:00:00Z",
        centsPerMwh: 5947),
    ElectricityPriceDto(
        startTime: "2022-12-19T03:00:00Z",
        endTime: "2022-12-19T04:00:00Z",
        centsPerMwh: 7258),
    ElectricityPriceDto(
        startTime: "2022-12-19T04:00:00Z",
        endTime: "2022-12-19T05:00:00Z",
        centsPerMwh: 10911),
    ElectricityPriceDto(
        startTime: "2022-12-19T05:00:00Z",
        endTime: "2022-12-19T06:00:00Z",
        centsPerMwh: 17536),
    ElectricityPriceDto(
        startTime: "2022-12-19T06:00:00Z",
        endTime: "2022-12-19T07:00:00Z",
        centsPerMwh: 24003),
    ElectricityPriceDto(
        startTime: "2022-12-19T07:00:00Z",
        endTime: "2022-12-19T08:00:00Z",
        centsPerMwh: 24957),
    ElectricityPriceDto(
        startTime: "2022-12-19T08:00:00Z",
        endTime: "2022-12-19T09:00:00Z",
        centsPerMwh: 23666),
    ElectricityPriceDto(
        startTime: "2022-12-19T09:00:00Z",
        endTime: "2022-12-19T10:00:00Z",
        centsPerMwh: 19803),
    ElectricityPriceDto(
        startTime: "2022-12-19T10:00:00Z",
        endTime: "2022-12-19T11:00:00Z",
        centsPerMwh: 23999),
    ElectricityPriceDto(
        startTime: "2022-12-19T11:00:00Z",
        endTime: "2022-12-19T12:00:00Z",
        centsPerMwh: 24870),
    ElectricityPriceDto(
        startTime: "2022-12-19T12:00:00Z",
        endTime: "2022-12-19T13:00:00Z",
        centsPerMwh: 24580),
    ElectricityPriceDto(
        startTime: "2022-12-19T13:00:00Z",
        endTime: "2022-12-19T14:00:00Z",
        centsPerMwh: 24943),
    ElectricityPriceDto(
        startTime: "2022-12-19T14:00:00Z",
        endTime: "2022-12-19T15:00:00Z",
        centsPerMwh: 24881),
    ElectricityPriceDto(
        startTime: "2022-12-19T15:00:00Z",
        endTime: "2022-12-19T16:00:00Z",
        centsPerMwh: 24902),
    ElectricityPriceDto(
        startTime: "2022-12-19T16:00:00Z",
        endTime: "2022-12-19T17:00:00Z",
        centsPerMwh: 24885),
    ElectricityPriceDto(
        startTime: "2022-12-19T17:00:00Z",
        endTime: "2022-12-19T18:00:00Z",
        centsPerMwh: 24885),
    ElectricityPriceDto(
        startTime: "2022-12-19T18:00:00Z",
        endTime: "2022-12-19T19:00:00Z",
        centsPerMwh: 23589),
    ElectricityPriceDto(
        startTime: "2022-12-19T19:00:00Z",
        endTime: "2022-12-19T20:00:00Z",
        centsPerMwh: 23999),
    ElectricityPriceDto(
        startTime: "2022-12-19T20:00:00Z",
        endTime: "2022-12-19T21:00:00Z",
        centsPerMwh: 24828),
    ElectricityPriceDto(
        startTime: "2022-12-19T21:00:00Z",
        endTime: "2022-12-19T22:00:00Z",
        centsPerMwh: 17115),
    ElectricityPriceDto(
        startTime: "2022-12-19T22:00:00Z",
        endTime: "2022-12-19T23:00:00Z",
        centsPerMwh: 12006),
  ];

  test("should return list of ElectricityPrices", () async {
    final electricityApi = MockElectricityApi();
    SpotPriceRepository spotPriceRepository =
        SpotPriceRepository(electricityApi: electricityApi);

    when(electricityApi.getSpotPrices(any))
        .thenAnswer((realInvocation) async => mockPrices);

    final result = await spotPriceRepository.fetchSpotPrices("");

    final expectedPrice = ElectricityPrice(
        startTime: DateTime.parse("2022-12-18T15:00:00Z"),
        endTime: DateTime.parse("2022-12-18T16:00:00Z"),
        centsPerMwh: 17216);

    expect(result.first.startTime.hour, expectedPrice.startTime.hour);
    expect(result.first.endTime.hour, expectedPrice.endTime.hour);
    expect(result.first.centsPerMwh, expectedPrice.centsPerMwh);
  });
}
