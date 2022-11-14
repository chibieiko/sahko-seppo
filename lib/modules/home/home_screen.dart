import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahko_seppo/data/electricity_models.dart';
import 'package:sahko_seppo/modules/home/home_item_widget.dart';

import 'package:sahko_seppo/modules/spot_price_provider.dart';

import 'calculations.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spotPrices = ref.read(spotPriceProvider.notifier);
    final spotPricesState = ref.watch(spotPriceProvider);

    if (spotPricesState.isLoading) {
      animationController.animateTo(1);
      animationController.repeat();
    } else {
      animationController.reset();
    }

    List<ElectricityPeriod> electricityPeriods =
        spotPricesState.electricityPeriods;

    String currentPrice =
        "Current price ${getCurrentPrice(electricityPeriods) ?? "-"} snt/kWh";
    String dishwasherDelay =
        "Delay ${getOptimalDelayForNightTime(electricityPeriods, 3) ?? "-"} h";
    int? bestTimeFor60degrees = getBestTimeForDayUse(electricityPeriods, 3);
    int? bestTimeFor30and40Degrees = getBestTimeForDayUse(electricityPeriods, 2);
    String degrees60 =
        bestTimeFor60degrees != null ? "Start $bestTimeFor60degrees:00" : "-";
    String degrees30and40 = bestTimeFor30and40Degrees != null
        ? "Start $bestTimeFor30and40Degrees:00"
        : "-";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentPrice,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: (Column(children: [
        Card(
            child: Column(
          children: [
            HomeItemWidget(
                title: dishwasherDelay,
                subTitle: 'Dishwasher',
                icon: Icons.flatware),
            const Divider(),
            HomeItemWidget(
                title: degrees60,
                subTitle: 'Laundry Lasse and towels',
                icon: Icons.local_laundry_service_outlined),
            HomeItemWidget(
                title: degrees30and40,
                subTitle: 'Laundry normal',
                icon: Icons.local_laundry_service_outlined),
          ],
        ))
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: spotPrices.fetch,
        tooltip: 'Refresh',
        child: RotationTransition(
            turns: animationController, child: const Icon(Icons.refresh)),
      ),
    );
  }
}

String durationToString(Duration? duration) {
  return (duration != null)
      ? "${duration.toString().split(":").sublist(0, 2).join(" h ")} min"
      : "N/A";
}

String timeAsString(DateTime time) {
  return "${time.hour >= 10 ? "" : 0}${time.hour}:${time.minute >= 10 ? "" : 0}${time.minute}";
}
