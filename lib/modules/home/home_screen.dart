import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahko_seppo/modules/electricity_price.dart';
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

    List<ElectricityPrice> electricityPrices =
        spotPricesState.electricityPrices;

    DateTime now = DateTime.now();
    ElectricityPrice? currentPrice =
        getCurrentElectricityPrice(electricityPrices, now.toLocal());

    String dishwasherDelay =
        "Delay ${getOptimalDelayForNightTime(electricityPrices, 3, now) ?? "-"} h";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Current price: ${currentPrice?.centsPerkWhWithVat()} cent/kWh",
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
