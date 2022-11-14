import 'package:json_annotation/json_annotation.dart';

part 'electricity_models.g.dart';

@JsonSerializable()
class MarketDocument {
  @JsonKey(name: "TimeSeries")
  List<ElectricityPeriod> electricityPeriods;

  MarketDocument({required this.electricityPeriods});

  factory MarketDocument.fromJson(Map<String, dynamic> json) {
    var test = json['Publication_MarketDocument'];
    return _$MarketDocumentFromJson(test);
  }
}

@JsonSerializable()
class ElectricityPeriod {
  TimeInterval timeInterval;
  @JsonKey(name: "Point")
  List<ElectricityPoint> electricityPoints;

  ElectricityPeriod(
      {required this.timeInterval, required this.electricityPoints});

  factory ElectricityPeriod.fromJson(Map<String, dynamic> json) {
    final period = json['Period'];

    return _$ElectricityPeriodFromJson(period);
  }
}

@JsonSerializable()
class TimeInterval {
  DateTime start;
  DateTime end;

  TimeInterval({required this.start, required this.end});

  factory TimeInterval.fromJson(Map<String, dynamic> json) {
    final start = DateTime.parse(json['start']['\$t']);
    final end = DateTime.parse(json['end']['\$t']);
    return TimeInterval(start: start, end: end);
  }
}

@JsonSerializable()
class Point {
  @JsonKey(name: "Point")
  List<ElectricityPoint> electricityPoints;

  Point({required this.electricityPoints});

  factory Point.fromJson(Map<String, dynamic> json) {
    return _$PointFromJson(json);
  }
}

@JsonSerializable()
class ElectricityPoint {
  int position;
  @JsonKey(name: "price.amount")
  double price;

  ElectricityPoint({required this.position, required this.price});

  factory ElectricityPoint.fromJson(Map<String, dynamic> json) {
    final position = json['position']['\$t'];
    final price = json['price.amount']['\$t'];
    return ElectricityPoint(
        position: int.parse(position), price: double.parse(price));
  }
}
