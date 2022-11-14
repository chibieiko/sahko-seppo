import '../../data/electricity_models.dart';

String getCurrentPrice(List<ElectricityPeriod> electricityPeriods) {
  DateTime now = DateTime.now();
  if (electricityPeriods.isNotEmpty) {
    var todayPrices = electricityPeriods
        .firstWhere((element) => element.timeInterval.end.day == now.day);
    var price = todayPrices.electricityPoints
        .firstWhere((element) => element.position == now.hour)
        .price;

    double priceWithVat24 = (price * 1.24) / 10;
    String priceInCents = priceWithVat24.toStringAsFixed(2);

    return priceInCents;
  } else {
    return '-';
  }
}

int? getOptimalDelayForNightTime(
    List<ElectricityPeriod> electricityPeriods, int runTime) {
  DateTime now = DateTime.now();
  List<ElectricityPoint> pricePoints =
      getPricePointsForDate(electricityPeriods, now);
  if (pricePoints.isNotEmpty) {
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
  return null;
}

List<ElectricityPoint> getPricePointsForDate(
    List<ElectricityPeriod> electricityPeriods, DateTime dateTime) {
  if (electricityPeriods.isNotEmpty) {
    List<ElectricityPoint> pricePoints = electricityPeriods
        .firstWhere((element) => element.timeInterval.end.day == dateTime.day)
        .electricityPoints;

    return pricePoints;
  }

  return List.empty(growable: false);
}

int getOptimalStartHour(List<ElectricityPoint> pricePoints, int runTime) {
  int startHour = 0;
  double cheapestPrice = 100000;

  if (pricePoints.isNotEmpty) {
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
  }

  return startHour;
}

int? getBestTimeForDayUse(
    List<ElectricityPeriod> electricityPeriods, int runTime) {
  DateTime now = DateTime.now();
  List<ElectricityPoint> pricePoints;
  if (now.hour > 19) {
    DateTime tomorrow = now.add(const Duration(days: 1));
    pricePoints = getPricePointsForDate(electricityPeriods, tomorrow);
  } else {
    pricePoints = getPricePointsForDate(electricityPeriods, now);
  }

  if (pricePoints.isNotEmpty) {
    pricePoints.retainWhere(
        (element) => element.position > 5 && element.position < 20);
    return getOptimalStartHour(pricePoints, runTime);
  } else {
    return null;
  }
}
