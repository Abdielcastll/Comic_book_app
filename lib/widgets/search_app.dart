import 'package:flutter/material.dart';

class AppSearch extends StatelessWidget {
  final void Function(String) onSubmitted;
  const AppSearch({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search',
        filled: true,
        isDense: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
