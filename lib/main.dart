import 'package:comic_book_app/core/providers.dart';
import 'package:comic_book_app/core/router.dart';
import 'package:comic_book_app/core/theme.dart';
import 'package:comic_book_app/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
        title: 'Comic Book App',
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: HomeView.routeName,
        routes: router,
      ),
    );
  }
}
