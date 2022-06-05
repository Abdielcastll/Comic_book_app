import 'package:comic_book_app/models/detail_comic_model.dart';
import 'package:flutter/material.dart';

class CharactersTabletWidget extends StatelessWidget {
  final String subtitle;
  final List<Credit> credits;
  const CharactersTabletWidget({
    Key? key,
    required this.subtitle,
    required this.credits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
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
                Orientation.landscape == orientation
                    ? GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              Orientation.landscape == orientation ? 2 : 1,
                          childAspectRatio: 22 / 7,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: credits.length,
                        itemBuilder: (context, i) {
                          final credit = credits[i];
                          return ListTile(
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
                              maxLines: 2,
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: credits.length,
                        itemBuilder: (context, i) {
                          final credit = credits[i];
                          return Padding(
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
                          );
                        },
                      ),
              ],
            ),
          );
  }
}
