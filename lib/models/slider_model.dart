import 'dart:convert';

List<SliderModel> SliderFromJson(String str) => List<SliderModel>.from(json.decode(str).map((x) => SliderModel.fromJson(x)));

String SliderToJson(List<SliderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  SliderModel({
    this.id,
    this.catId,
    this.vId,
    this.imageUrl,
  });

  String id;
  String catId;
  String vId;
  String imageUrl;

  //factory SliderModel.fromRawJson(String str) => SliderModel.fromJson(json.decode(str));

  //String toRawJson() => json.encode(toJson());

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["Id"],
    catId: json["cat_id"],
    vId: json["v_id"],
    imageUrl: json["Image_url"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "cat_id": catId,
    "v_id": vId,
    "Image_url": imageUrl,
  };
}
