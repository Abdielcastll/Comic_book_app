import 'package:comic_book_app/views/details_comics/details_view_model.dart';
import 'package:comic_book_app/views/details_comics/widgets/characters_mobile_widget.dart';
import 'package:comic_book_app/views/details_comics/widgets/characters_tablet_widget.dart';
import 'package:comic_book_app/widgets/error_app.dart';
import 'package:comic_book_app/widgets/loading_app.dart';
import 'package:comic_book_app/widgets/title_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsComicView extends StatefulWidget {
  static const routeName = 'detailsComic';
  const DetailsComicView({Key? key}) : super(key: key);

  @override
  State<DetailsComicView> createState() => _DetailsComicViewState();
}

class _DetailsComicViewState extends State<DetailsComicView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<DetailsComicViewModel>().getDetailsComic(
          ModalRoute.of(context)?.settings.arguments as String),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppTitle('ComicBook'),
      ),
      body: _loading(),
    );
  }

  _loading() {
    final vm = context.watch<DetailsComicViewModel>();
    final useMobileLayout = MediaQuery.of(context).size.shortestSide < 600;
    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: vm.loading
          ? const AppLoading()
          : vm.error
              ? AppError(
                  vm.failure.errorResponse,
                  () => vm.getDetailsComic(
                      ModalRoute.of(context)?.settings.arguments as String),
                )
              : useMobileLayout
                  ? Orientation.landscape == orientation
                      ? _bodyTablet(vm)
                      : _bodyMobile(vm)
                  : _bodyTablet(vm),
    );
  }

  Widget _bodyMobile(DetailsComicViewModel vm) {
    return ListView(
      padding: const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(),
      children: [
        Image.network(
          vm.detailsComic?.image?.originalUrl ?? '',
          height: MediaQuery.of(context).size.height * .40,
        ),
        CharactersMobileWidget(
          subtitle: 'Characters',
          credits: vm.detailsComic!.characterCredits ?? [],
        ),
        CharactersMobileWidget(
          subtitle: 'Teams',
          credits: vm.detailsComic!.teamCredits ?? [],
        ),
        CharactersMobileWidget(
          subtitle: 'Locations',
          credits: vm.detailsComic!.locationCredits ?? [],
        ),
        CharactersMobileWidget(
          subtitle: 'Concepts',
          credits: vm.detailsComic!.personCredits ?? [],
        ),
      ],
    );
  }

  Widget _bodyTablet(DetailsComicViewModel vm) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8),
            physics: const BouncingScrollPhysics(),
            children: [
              CharactersTabletWidget(
                subtitle: 'Characters',
                credits: vm.detailsComic!.characterCredits ?? [],
              ),
              CharactersTabletWidget(
                subtitle: 'Teams',
                credits: vm.detailsComic!.teamCredits ?? [],
              ),
              CharactersTabletWidget(
                subtitle: 'Locations',
                credits: vm.detailsComic!.locationCredits ?? [],
              ),
              CharactersTabletWidget(
                subtitle: 'Concepts',
                credits: vm.detailsComic!.personCredits ?? [],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 20, 20),
          child: Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width * .45,
            child: Image.network(
              vm.detailsComic?.image?.originalUrl ?? '',
            ),
          ),
        ),
      ],
    );
  }
}
