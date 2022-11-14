import 'package:collection/collection.dart';

import '../../data/electricity_models.dart';

double? getCurrentPrice(List<ElectricityPeriod> electricityPeriods) {
  if (electricityPeriods.isEmpty) {
    return null;
  }

  DateTime now = DateTime.now();
  ElectricityPeriod? todayPrices = electricityPeriods
      .firstWhereOrNull((element) => element.timeInterval.end.day == now.day);
  double? price = todayPrices?.electricityPoints
      .firstWhereOrNull((element) => element.position == now.hour)
      ?.price;

  if (price == null) {
    return null;
  }

  double priceWithVat24 = (price * 1.24) / 10;
  double priceInCents = double.parse(priceWithVat24.toStringAsFixed(2));

  return priceInCents;
}

int? getOptimalDelayForNightTime(
    List<ElectricityPeriod> electricityPeriods, int runTime) {
  DateTime now = DateTime.now();

  if (electricityPeriods.isEmpty) {
    return null;
  }

  List<ElectricityPoint>? pricePoints =
      getPricePointsForDate(electricityPeriods, now);

  if (pricePoints == null || pricePoints.isEmpty) {
    return null;
  }

  pricePoints.retainWhere((element) {
    return (element.position < 7 && element.position > 0) ||
        element.position == 23 ||
        element.position == 24;
  });

  int optimalDelay = 0;
  int startHour = getOptimalStartHour(pricePoints, runTime);

  DateTime tomorrow = now.add(const Duration(days: 1));
  DateTime startDate = startHour <= 6
      ? DateTime(tomorrow.year, tomorrow.month, tomorrow.day, startHour)
      : DateTime(now.year, now.month, now.day, startHour);

  optimalDelay = startDate.difference(now).inHours;

  return optimalDelay;
}

List<ElectricityPoint>? getPricePointsForDate(
    List<ElectricityPeriod> electricityPeriods, DateTime dateTime) {
  List<ElectricityPoint>? pricePoints = electricityPeriods
      .firstWhereOrNull((element) => element.timeInterval.end.day == dateTime.day)
      ?.electricityPoints;

  return pricePoints;
}

int getOptimalStartHour(List<ElectricityPoint> pricePoints, int runTime) {
  int startHour = 0;
  double cheapestPrice = 100000;

  if (pricePoints.isEmpty) {
    return startHour;
  }

  for (int i = 0; i < pricePoints.length; i++) {
    if (i + runTime < pricePoints.length - 1) {
      double price = 0;
      for (int a = 0; a < runTime; a++) {
        price += pricePoints[a].price;
      }

      if (price < cheapestPrice) {
        cheapestPrice = price;
        startHour = pricePoints[i].position;
      }
    }
  }

  return startHour;
}

int? getBestTimeForDayUse(
    List<ElectricityPeriod> electricityPeriods, int runTime) {
  DateTime now = DateTime.now();
  List<ElectricityPoint>? pricePoints;
  if (now.hour > 19) {
    DateTime tomorrow = now.add(const Duration(days: 1));
    pricePoints = getPricePointsForDate(electricityPeriods, tomorrow);
  } else {
    pricePoints = getPricePointsForDate(electricityPeriods, now);
  }

  if (pricePoints == null || pricePoints.isEmpty) {
    return null;
  }

  pricePoints
      .retainWhere((element) => element.position > 5 && element.position < 20);
  return getOptimalStartHour(pricePoints, runTime);
}
