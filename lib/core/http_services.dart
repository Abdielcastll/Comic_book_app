import 'dart:io';

import 'package:comic_book_app/core/api_status.dart';
import 'package:comic_book_app/models/detail_comic_model.dart';
import 'package:comic_book_app/models/last_comics_model.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  static const apiKey = '9f155fc9fbd8ce89bb3e56367151743bca928dd6';
  static const baseUrl = 'https://comicvine.gamespot.com/api/';

  static Future<Object> getLastComics(int offset) async {
    final url = Uri.parse(
        '${baseUrl}issues/?api_key=$apiKey&format=json&limit=28&offset=$offset');
    try {
      var resp = await http.get(url);
      if (resp.statusCode == 200) {
        return Success(response: lastComicsFromJson(resp.body));
      }
      return Failure(errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(errorResponse: 'No Internet');
    } on FormatException {
      return Failure(errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> getDetailsComic(String urlDetails) async {
    final url = Uri.parse("$urlDetails?api_key=$apiKey&format=json");

    try {
      var resp = await http.get(url);
      if (resp.statusCode == 200) {
        return Success(response: detailsResponseFromJson(resp.body));
      }
      return Failure(errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(errorResponse: 'No Internet');
    } on FormatException {
      return Failure(errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(errorResponse: 'Unknown Error');
    }
  }

  static Future<List<LastComics>> searchComics(String query) async {
    final url = Uri.parse(
        "${baseUrl}issues?api_key=$apiKey&format=json&filter=name:$query");
    try {
      var resp = await http.get(url);
      if (resp.statusCode == 200) {
        return lastComicsFromJson(resp.body).results ?? [];
      }
      return [];
    } on HttpException {
      return [];
    } on FormatException {
      return [];
    } catch (e) {
      return [];
    }
  }
}
