import 'dart:convert';

LastComicsResponse lastComicsFromJson(String str) =>
    LastComicsResponse.fromJson(json.decode(str));

String lastComicsToJson(LastComicsResponse data) => json.encode(data.toJson());

class LastComicsResponse {
  LastComicsResponse({
    this.results,
  });

  List<LastComics>? results;

  factory LastComicsResponse.fromJson(Map<String, dynamic> json) =>
      LastComicsResponse(
        results: List<LastComics>.from(
            json["results"].map((x) => LastComics.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class LastComics {
  LastComics({
    this.image,
    this.issueNumber,
    this.name,
    this.id,
    this.volume,
    this.dateAdded,
    this.apiDetailUrl,
  });

  Image? image;
  String? issueNumber;
  String? name;
  int? id;
  Volume? volume;
  DateTime? dateAdded;
  String? apiDetailUrl;

  factory LastComics.fromJson(Map<String, dynamic> json) => LastComics(
        image: Image.fromJson(json["image"]),
        issueNumber: json["issue_number"],
        name: json["name"],
        id: json["id"],
        volume: Volume.fromJson(json["volume"]),
        dateAdded: DateTime.parse(json["date_added"]),
        apiDetailUrl: json["api_detail_url"],
      );

  Map<String, dynamic> toJson() => {
        "image": image?.toJson(),
        "issue_number": issueNumber,
        "name": name,
        "id": id,
        "volume": volume?.toJson(),
        "date_added": dateAdded?.toIso8601String(),
        "api_detail_url": apiDetailUrl,
      };
}

class Image {
  Image({
    this.originalUrl,
  });

  String? originalUrl;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        originalUrl: json["original_url"],
      );

  Map<String, dynamic> toJson() => {
        "original_url": originalUrl,
      };
}

class Volume {
  Volume({
    this.name,
  });

  String? name;

  factory Volume.fromJson(Map<String, dynamic> json) => Volume(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
