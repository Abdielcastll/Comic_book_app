import 'package:comic_book_app/models/detail_comic_model.dart';
import 'package:flutter/material.dart';

class CharactersWidget extends StatelessWidget {
  final String subtitle;
  final List<Credit> credits;
  const CharactersWidget({
    Key? key,
    required this.subtitle,
    required this.credits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useMobileLayout = MediaQuery.of(context).size.shortestSide < 600;
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
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: useMobileLayout
                        ? Orientation.portrait == orientation
                            ? 2
                            : 2
                        : Orientation.landscape == orientation
                            ? 2
                            : 1,
                    childAspectRatio: useMobileLayout ? 21 / 7 : 21 / 5,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemCount: credits.length,
                  itemBuilder: (context, i) {
                    final credit = credits[i];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/img/no-avatar.jpg',
                          height: 60,
                          width: 60,
                        ),
                      ),
                      title: Text(credit.name ?? ''),
                    );
                  },
                )
              ],
            ),
          );
  }
}
