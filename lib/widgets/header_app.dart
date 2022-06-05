import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String? title;
  final void Function()? list;
  final void Function()? grid;
  final bool isList;
  const AppHeader({
    Key? key,
    required this.isList,
    required this.title,
    required this.list,
    required this.grid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey[350] ?? Colors.grey,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
              child: Text(
            title ?? 'title',
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
          Row(
            children: [
              TextButton.icon(
                onPressed: list,
                icon: Icon(
                  Icons.menu,
                  color: isList ? Colors.black : Colors.grey,
                  size: 15,
                ),
                label: Text(
                  'List',
                  style: TextStyle(
                    color: isList ? Colors.black : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              TextButton.icon(
                onPressed: grid,
                icon: Icon(
                  Icons.grid_view_sharp,
                  color: !isList ? Colors.black : Colors.grey,
                  size: 15,
                ),
                label: Text(
                  'Grid',
                  style: TextStyle(
                    color: !isList ? Colors.black : Colors.grey,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
