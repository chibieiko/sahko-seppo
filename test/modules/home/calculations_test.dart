import 'package:flutter_test/flutter_test.dart';
import 'package:sahko_seppo/modules/electricity_price.dart';
import 'package:sahko_seppo/modules/home/calculations.dart';

void main() {
  List<ElectricityPrice> testPrices = [
    ElectricityPrice(
        startTime: DateTime(2022, 12, 22, 21, 00, 00),
        endTime: DateTime(2022, 12, 22, 22, 00, 00),
        centsPerMwh: 100),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 22, 22, 00, 00),
        endTime: DateTime(2022, 12, 22, 23, 00, 00),
        centsPerMwh: 200),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 22, 23, 00, 00),
        endTime: DateTime(2022, 12, 23, 00, 00, 00),
        centsPerMwh: 333),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 23, 00, 00, 00),
        endTime: DateTime(2022, 12, 23, 01, 00, 00),
        centsPerMwh: 4),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 23, 01, 00, 00),
        endTime: DateTime(2022, 12, 23, 02, 00, 00),
        centsPerMwh: 5),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 23, 02, 00, 00),
        endTime: DateTime(2022, 12, 23, 03, 00, 00),
        centsPerMwh: 6),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 23, 03, 00, 00),
        endTime: DateTime(2022, 12, 23, 04, 00, 00),
        centsPerMwh: 7),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 23, 04, 00, 00),
        endTime: DateTime(2022, 12, 23, 05, 00, 00),
        centsPerMwh: 8),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 23, 05, 00, 00),
        endTime: DateTime(2022, 12, 23, 06, 00, 00),
        centsPerMwh: 9),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 23, 06, 00, 00),
        endTime: DateTime(2022, 12, 23, 07, 00, 00),
        centsPerMwh: 10),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 23, 07, 00, 00),
        endTime: DateTime(2022, 12, 23, 08, 00, 00),
        centsPerMwh: 11),
    ElectricityPrice(
        startTime: DateTime(2022, 12, 23, 08, 00, 00),
        endTime: DateTime(2022, 12, 23, 09, 00, 00),
        centsPerMwh: 12)
  ];

  test("should return current price", () {
    DateTime currentDateTime = DateTime(2022, 12, 23, 3, 00, 00);
    ElectricityPrice? currentPrice =
        getCurrentElectricityPrice(testPrices, currentDateTime);
    expect(7, currentPrice?.centsPerMwh);
  });

  test(
      "should return optimal start time so that machine running for three hours costs as little as possible",
      () {
    DateTime currentDateTime = DateTime(2022, 12, 22, 19, 00, 00);
    DateTime optimalStartTime =
        getOptimalStartTime(testPrices, 3, currentDateTime);
    expect(DateTime(2022, 12, 23, 00, 00, 00), optimalStartTime);
  });

  test(
      "should return optimal delay for dishwasher running three hours when checking at seven",
      () {
    DateTime currentDateTime = DateTime(2022, 12, 22, 19, 00, 00);
    int optimalDelay =
        getOptimalDelayForNightTime(testPrices, 3, currentDateTime);
    expect(5, optimalDelay);
  });

  test(
      "should return optimal delay for dishwasher running three hours when checking at midnight",
      () {
    DateTime currentDateTime = DateTime(2022, 12, 23, 00, 00, 00);
    int optimalDelay =
        getOptimalDelayForNightTime(testPrices, 3, currentDateTime);
    expect(0, optimalDelay);
  });
}
