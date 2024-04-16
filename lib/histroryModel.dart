// To parse this JSON data, do
//
//     final speechs = speechsFromJson(jsonString);

import 'dart:convert';

List<Speechs> speechsFromJson(String str) => List<Speechs>.from(json.decode(str).map((x) => Speechs.fromJson(x)));

String speechsToJson(List<Speechs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Speechs {
  String id;
  String userId;
  String speech;
  int v;

  Speechs({
    required this.id,
    required this.userId,
    required this.speech,
    required this.v,
  });

  factory Speechs.fromJson(Map<String, dynamic> json) => Speechs(
    id: json["_id"],
    userId: json["userId"],
    speech: json["speech"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "speech": speech,
    "__v": v,
  };
}
