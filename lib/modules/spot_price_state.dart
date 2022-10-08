import 'package:sahko_seppo/data/electricity_models.dart';

class SpotPriceState {
  List<ElectricityPeriod>? electricityPeriods = List.empty(growable: true);

  SpotPriceState({this.electricityPeriods});

  String getCurrentPrice() {
    DateTime now = DateTime.now();
    List<ElectricityPeriod> periods =
        electricityPeriods ?? List.empty(growable: true);
    if (periods.isNotEmpty) {
      var todayPrices = periods
          .firstWhere((element) => element.timeInterval.end.day == now.day);
      var price = todayPrices.electricityPoints
          .firstWhere((element) => element.position == now.hour.toString())
          .price;

      double priceWithVat24 = (double.parse(price) * 1.24) / 10;
      String priceInCents = priceWithVat24.toStringAsFixed(2);

      return "Current price: $priceInCents snt/kWh";
    } else {
      return "No knowledge of current price";
    }
  }

  Map<Duration, Duration> getDurationDelayMap() {
    final Map<Duration, Duration> durationDelayMap = {
      const Duration(minutes: 30): const Duration(),
      const Duration(minutes: 60): const Duration(),
      const Duration(minutes: 90): const Duration(),
      const Duration(minutes: 120): const Duration(),
      const Duration(minutes: 150): const Duration(),
      const Duration(minutes: 180): const Duration(),
      const Duration(minutes: 240): const Duration(),
      const Duration(minutes: 300): const Duration(),
    };

    DateTime now = DateTime.now();
    for (var duration in durationDelayMap.keys) {
      durationDelayMap[duration] = _getDelay(duration, now);
    }

    return durationDelayMap;
  }

  double _hourPrice(DateTime time) {
    int hour = time.hour;
    double price = 0.0;
    List<ElectricityPeriod> ePeriods =
        electricityPeriods ?? List.empty(growable: false);
    for (var element in ePeriods) {
      if (element.timeInterval.end.day == time.day) {
        var node = element.electricityPoints
            .firstWhere((element) => int.parse(element.position) == hour);
        price = double.parse(node.price);
      }
    }
    return price;
  }

  double _getPrice(DateTime start, DateTime end) {
    final int firstHourMinutes = 60 - start.minute;
    final int lastHourMinutes = end.minute;
    final int wholeHours = ((end.difference(start).inMinutes -
                firstHourMinutes -
                lastHourMinutes) /
            60.0)
        .round();
    double price = (firstHourMinutes / 60.0) * _hourPrice(start);
    for (int hour = 1; hour <= wholeHours; ++hour) {
      var time = start.add(Duration(hours: hour));
      price += _hourPrice(time);
    }
    price += (lastHourMinutes / 60.0) * _hourPrice(end);

    return price;
  }

  DateTime _simplifiedDateTime(DateTime other) {
    return DateTime(
        other.year, other.month, other.day, other.hour, other.minute);
  }

  Duration _getDelay(Duration duration, DateTime now) {
    double bestPrice = 300;
    int bestDelay = 0;
    for (int delayHours = 0; delayHours < 10; ++delayHours) {
      var start = _simplifiedDateTime(now).add(Duration(hours: delayHours));
      var end = start.add(duration);
      var price = _getPrice(start, end);
      if (price < bestPrice) {
        bestPrice = price;
        bestDelay = delayHours;
      }
    }

    return Duration(hours: bestDelay);
  }
}
