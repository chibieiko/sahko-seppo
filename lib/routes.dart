import 'package:flutter/material.dart';
import 'package:sahko_seppo/modules/home/home_view.dart';

class Routes {
  static const String home = '/';
}

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return _page(const Home(), settings);
    default:
      return _page(const Home(), settings);
  }
}

MaterialPageRoute _page(page, RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => page, settings: settings);
}
