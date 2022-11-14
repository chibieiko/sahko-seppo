import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeItemWidget extends ConsumerStatefulWidget {
  final String title;
  final String subTitle;
  final IconData icon;

  const HomeItemWidget(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.icon})
      : super(key: key);

  @override
  HomeItemWidgetState createState() => HomeItemWidgetState();
}

class HomeItemWidgetState extends ConsumerState<HomeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text(
        widget.subTitle,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
      leading: Icon(
        widget.icon,
        color: Colors.black,
      ),
    );
  }
}
