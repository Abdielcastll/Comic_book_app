import 'package:comic_book_app/views/details_comics/details_view.dart';
import 'package:comic_book_app/views/home/home_view.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(dynamic)> router = {
  HomeView.routeName: (_) => const HomeView(),
  DetailsComicView.routeName: (_) => const DetailsComicView(),
};
