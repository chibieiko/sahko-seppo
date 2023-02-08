import 'package:collection/collection.dart';
import 'package:sahko_seppo/modules/electricity_price.dart';

ElectricityPrice? getCurrentElectricityPrice(
    List<ElectricityPrice> electricityPrices, DateTime currentDateTime) {
  if (electricityPrices.isEmpty) {
    return null;
  }

  ElectricityPrice? currentPrice =
      electricityPrices.firstWhereOrNull((element) {
    DateTime startTime = element.startTime.toLocal();
    return startTime.day == currentDateTime.day &&
        startTime.hour == currentDateTime.hour;
  });

  if (currentPrice == null) {
    return null;
  }

  return currentPrice;
}

int getOptimalDelayForNightTime(List<ElectricityPrice> electricityPrices,
    int runTime, DateTime currentDateTime) {
  List<ElectricityPrice> prices = List.from(electricityPrices);

  prices.retainWhere((element) {
    bool sameDay = element.startTime.day == currentDateTime.day;
    bool nextDay = element.startTime.day ==
        currentDateTime.add(const Duration(days: 1)).day;
    bool greaterOrSameHour = element.startTime.hour >= currentDateTime.hour;
    bool lessThanMorning =
        element.startTime.hour < 7 && element.startTime.hour >= 0;

    return sameDay && greaterOrSameHour || nextDay && lessThanMorning;
  });

  DateTime startTime = getOptimalStartTime(prices, runTime, currentDateTime);
  return startTime.difference(currentDateTime).inHours;
}

DateTime getOptimalStartTime(List<ElectricityPrice> electricityPrices,
    int runTime, DateTime currentDateTime) {
  num cheapestPrice = 100000000000000;

  if (electricityPrices.isEmpty) {
    return currentDateTime;
  }

  for (int i = 0; i < electricityPrices.length; i++) {
    if (i + runTime < electricityPrices.length - 1) {
      double price = 0;
      for (int a = 0; a < runTime; a++) {
        price += electricityPrices[a + i].centsPerMwh;
      }

      if (price < cheapestPrice) {
        cheapestPrice = price;
        currentDateTime = electricityPrices[i].startTime;
      }
    }
  }

  return currentDateTime;
}
