import 'package:comic_book_app/core/api_status.dart';
import 'package:comic_book_app/core/http_services.dart';
import 'package:comic_book_app/models/detail_comic_model.dart';
import 'package:flutter/material.dart';

class DetailsComicViewModel with ChangeNotifier {
  DetailsComicViewModel();

  bool _loading = false;
  DetailsComic? detailsComic;
  late bool error;
  late Failure failure;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> getDetailsComic(String urlDetails) async {
    error = false;
    loading = true;
    var resp = await HttpServices.getDetailsComic(urlDetails);
    if (resp is Success) {
      var data = resp.response as DetailsResponse;
      detailsComic = data.results;
    } else if (resp is Failure) {
      error = true;
      failure = resp;
    }
    loading = false;
  }
}
