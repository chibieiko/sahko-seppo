class ElectricityPrice {
  DateTime startTime;
  DateTime endTime;
  num centsPerMwh;

  ElectricityPrice(
      {required this.startTime,
      required this.endTime,
      required this.centsPerMwh});
}

extension Vat on ElectricityPrice {
  double centsPerkWhWithVat() {
    double priceWithVat24 = (centsPerMwh / 1000) * 1.1;
    return double.parse(priceWithVat24.toStringAsFixed(2));
  }
}
