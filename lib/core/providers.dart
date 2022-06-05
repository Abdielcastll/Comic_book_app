import 'package:comic_book_app/views/details_comics/details_view_model.dart';
import 'package:comic_book_app/views/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderInjector {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => HomeViewModel()),
    ChangeNotifierProvider(create: (context) => DetailsComicViewModel()),
  ];
}
