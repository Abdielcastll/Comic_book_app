import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String title;
  const AppTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
