import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sahko_seppo/modules/spot_price_provider.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotPrices = ref.read(spotPriceProvider.notifier);
    final spotPricesState = ref.watch(spotPriceProvider);

    Map<Duration, Duration> durationDelayMap =
        spotPricesState.getDurationDelayMap();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sähko Seppo"),
      ),
      body: Column(
        children: [
          Text(spotPricesState.getCurrentPrice()),
          Center(
            child: Table(
                border: TableBorder.all(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(flex: 1.0),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                      const TableRow(
                          decoration: BoxDecoration(color: Colors.amber),
                          children: <Widget>[
                            Text('Duration'),
                            Text('Delay'),
                            Text('When')
                          ]),
                    ] +
                    durationDelayMap.keys.map((key) {
                      return TableRow(children: <Widget>[
                        Text("${key.inMinutes} minutes"),
                        Text(durationToString(durationDelayMap[key])),
                        Text(timeAsString(
                            DateTime.now().add(durationDelayMap[key]!)))
                      ]);
                    }).toList()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: spotPrices.fetch,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
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
