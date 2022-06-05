import 'package:comic_book_app/models/detail_comic_model.dart';
import 'package:flutter/material.dart';

class CharactersMobileWidget extends StatelessWidget {
  final String subtitle;
  final List<Credit> credits;
  const CharactersMobileWidget({
    Key? key,
    required this.subtitle,
    required this.credits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return credits.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ...credits.map(
                  (credit) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/img/no-avatar.jpg',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      title: Text(
                        credit.name ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
