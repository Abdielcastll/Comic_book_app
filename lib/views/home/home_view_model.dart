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
  List<LastComics>? comicsSearch = [];
  late bool error;
  bool _isList = false;
  bool _search = false;
  late Failure failure;
  int offset = 0;

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
    var resp = await HttpServices.getLastComics(0);
    if (resp is Success) {
      var data = resp.response as LastComicsResponse;
      lastComics = data.results;
    } else if (resp is Failure) {
      error = true;
      failure = resp;
    }
    loading = false;
  }

  Future<void> getMoreComics() async {
    offset += 28;
    if (!search) {
      var resp = await HttpServices.getLastComics(offset);
      if (resp is Success) {
        var data = resp.response as LastComicsResponse;
        lastComics!.addAll(data.results!);
        notifyListeners();
      } else if (resp is Failure) {
        failure = resp;
      }
    }
  }

  Future<bool> searchComic(String query) async {
    loading = true;
    var resultTemp = await HttpServices.searchComics(query);
    if (resultTemp.isEmpty) {
      loading = false;
      return false;
    } else {
      comicsSearch = resultTemp;
      loading = false;
      return true;
    }
  }

  void clearSearch() {
    comicsSearch = [];
    notifyListeners();
  }
}
