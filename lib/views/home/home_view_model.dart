import 'package:comic_book_app/core/api_status.dart';
import 'package:comic_book_app/core/http_services.dart';
import 'package:comic_book_app/models/last_comics_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel() {
    getlastComics();
  }

  bool _loading = false;
  List<LastComics>? lastComics = [];
  late bool error;
  bool _isList = false;
  bool _search = false;
  late Failure failure;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get isList => _isList;
  set isList(bool value) {
    _isList = value;
    notifyListeners();
  }

  bool get search => _search;
  set search(bool value) {
    _search = value;
    notifyListeners();
  }

  Future<void> getlastComics() async {
    error = false;
    loading = true;
    var resp = await HttpServices.getLastComics();
    if (resp is Success) {
      var data = resp.response as LastComicsResponse;
      lastComics = data.results;
    } else if (resp is Failure) {
      error = true;
      failure = resp;
    }
    loading = false;
  }

  Future<bool> searchComic(String query) async {
    loading = true;
    var resultTemp = await HttpServices.searchComics(query);
    if (resultTemp.isEmpty) {
      loading = false;
      return false;
    } else {
      lastComics = resultTemp;
      loading = false;
      return true;
    }
  }
}
