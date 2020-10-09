// To parse this JSON data, do
//
//     final catData = catDataFromJson(jsonString);

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<CatData> catDataFromJson(String str) => List<CatData>.from(json.decode(str).map((x) => CatData.fromJson(x)));

String catDataToJson(List<CatData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatData with ChangeNotifier{
    CatData({
        @required this.id,
        @required this.name,
        @required this.videos,
        bool watched
    });

    final String id;
    final String name;
    final List<Video> videos;
    bool watched=true;

    factory CatData.fromJson(Map<String, dynamic> json) => CatData(
        id: json["id"],
        name: json["name"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    };
    void togglefavoriteStatus(){
        watched= !watched;
        notifyListeners();
    }
}

class Video {
    Video({
        @required this.title,
        @required this.url,
    });

    final String title;
    final String url;

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        title: json["Title"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "Title": title,
        "url": url,
    };

}
