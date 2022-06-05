import 'dart:convert';

import 'package:comic_book_app/models/last_comics_model.dart';

DetailsResponse detailsResponseFromJson(String str) =>
    DetailsResponse.fromJson(json.decode(str));

String detailsResponseToJson(DetailsResponse data) =>
    json.encode(data.toJson());

class DetailsResponse {
  DetailsResponse({
    this.results,
  });

  DetailsComic? results;

  factory DetailsResponse.fromJson(Map<String, dynamic> json) =>
      DetailsResponse(
        results: DetailsComic.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "results": results?.toJson(),
      };
}

class DetailsComic {
  DetailsComic({
    this.characterCredits,
    this.id,
    this.image,
    this.locationCredits,
    this.name,
    this.personCredits,
    this.teamCredits,
  });

  List<Credit>? characterCredits;
  int? id;
  Image? image;
  List<Credit>? locationCredits;
  String? name;
  List<Credit>? personCredits;
  List<Credit>? teamCredits;

  factory DetailsComic.fromJson(Map<String, dynamic> json) => DetailsComic(
        characterCredits: List<Credit>.from(
            json["character_credits"].map((x) => Credit.fromJson(x))),
        id: json["id"],
        image: Image.fromJson(json["image"]),
        locationCredits: List<Credit>.from(
            json["location_credits"].map((x) => Credit.fromJson(x))),
        name: json["name"],
        personCredits: List<Credit>.from(
            json["person_credits"].map((x) => Credit.fromJson(x))),
        teamCredits: List<Credit>.from(
            json["team_credits"].map((x) => Credit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "character_credits":
            List<dynamic>.from(characterCredits!.map((x) => x.toJson())),
        "id": id,
        "image": image?.toJson(),
        "location_credits":
            List<dynamic>.from(locationCredits!.map((x) => x.toJson())),
        "name": name,
        "person_credits":
            List<dynamic>.from(personCredits!.map((x) => x.toJson())),
        "team_credits": List<dynamic>.from(teamCredits!.map((x) => x.toJson())),
      };
}

class Credit {
  Credit({
    this.apiDetailUrl,
    this.id,
    this.name,
  });

  String? apiDetailUrl;
  int? id;
  String? name;

  factory Credit.fromJson(Map<String, dynamic> json) => Credit(
        apiDetailUrl: json["api_detail_url"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "api_detail_url": apiDetailUrl,
        "id": id,
        "name": name,
      };
}
