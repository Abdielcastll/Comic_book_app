import 'package:comic_book_app/views/details_comics/details_view.dart';
import 'package:comic_book_app/views/home/home_view_model.dart';
import 'package:comic_book_app/widgets/error_app.dart';
import 'package:comic_book_app/widgets/header_app.dart';
import 'package:comic_book_app/widgets/loading_app.dart';
import 'package:comic_book_app/widgets/search_app.dart';
import 'package:comic_book_app/widgets/title_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  static const routeName = 'home';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: vm.search
            ? AppSearch(onSubmitted: (query) async {
                var resp = await vm.searchComic(query);
                if (!resp) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('No results found', textAlign: TextAlign.center),
                  ));
                }
              })
            : const AppTitle('ComicBook'),
        actions: [
          IconButton(
            icon: Icon(vm.search ? Icons.close : Icons.search),
            onPressed: () => vm.search = !vm.search,
          ),
        ],
      ),
      body: _body(context, vm),
    );
  }

  SafeArea _body(BuildContext context, HomeViewModel vm) {
    return SafeArea(
      child: vm.loading
          ? const AppLoading()
          : vm.error
              ? AppError(
                  vm.failure.errorResponse,
                  () => vm.getlastComics(),
                )
              : Column(
                  children: [
                    AppHeader(
                      title: 'Latest Comics',
                      grid: () => vm.isList = false,
                      list: () => vm.isList = true,
                      isList: vm.isList,
                    ),
                    vm.isList ? _listView(context, vm) : _gridView(context, vm),
                  ],
                ),
    );
  }

  Widget _listView(BuildContext context, HomeViewModel vm) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        physics: const BouncingScrollPhysics(),
        itemCount: vm.lastComics?.length ?? 0,
        itemBuilder: (context, index) {
          final comic = vm.lastComics?[index];
          return InkWell(
            onTap: () => Navigator.pushNamed(
                context, DetailsComicView.routeName,
                arguments: comic?.apiDetailUrl),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Image.network(
                    comic?.image?.originalUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: size.width > 500 ? 4 : 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${comic?.name ?? comic?.volume?.name} #${comic?.issueNumber ?? 'n/a'}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.yMMMMd()
                            .format(comic?.dateAdded ?? DateTime.now()),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 25,
          thickness: 1,
        ),
      ),
    );
  }

  Widget _gridView(BuildContext context, HomeViewModel vm) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final useMobileLayout = shortestSide < 600;
    final orientation = MediaQuery.of(context).orientation;
    return Expanded(
      child: GridView.builder(
        itemCount: vm.lastComics?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: useMobileLayout
              ? Orientation.portrait == orientation
                  ? 2
                  : 4
              : Orientation.landscape == orientation
                  ? 6
                  : 4,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        padding: const EdgeInsets.all(8),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          final comic = vm.lastComics?[i];
          return InkWell(
            onTap: () => Navigator.pushNamed(
                context, DetailsComicView.routeName,
                arguments: comic?.apiDetailUrl),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    comic?.image?.originalUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 60,
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      Text(
                        "${comic?.name ?? comic?.volume?.name} #${comic?.issueNumber ?? 'n/a'}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        DateFormat.yMMMMd()
                            .format(comic?.dateAdded ?? DateTime.now()),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
