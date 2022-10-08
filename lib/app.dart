import 'package:flutter/material.dart';

import 'package:sahko_seppo/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sähkö Seppo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      onGenerateRoute: routes,
    );
  }
}

