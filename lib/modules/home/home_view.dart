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
        "Delay ${getOptimalDelayForNightTime(electricityPrices, 3, now)} h";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Current price: ${currentPrice?.centsPerkWhWithVat()} cent/kWh",
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: (SafeArea(
          child: ListView(children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Card(
                child: HomeItemWidget(
                    title: dishwasherDelay,
                    subTitle: 'Dishwasher',
                    icon: Icons.flatware),
              ),
              const SizedBox(height: 20),
              ...spotPricesState.electricityPrices
                  .map((price) => electricityPrice(price))
            ]))
      ]))),
      floatingActionButton: FloatingActionButton(
        onPressed: spotPrices.fetch,
        tooltip: 'Refresh',
        child: RotationTransition(
            turns: animationController, child: const Icon(Icons.refresh)),
      ),
    );
  }

  Widget electricityPrice(ElectricityPrice price) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Text("${price.startTime.toLocal().hour}",
            style: const TextStyle(fontSize: 16)),
        const Spacer(),
        Text("${price.centsPerkWhWithVat()} cent/kWh",
            style: const TextStyle(fontSize: 16))
      ]),
    );
  }
}
