import 'package:flutter/material.dart';
// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

List<Posts> postsFromJson(String str) => List<Posts>.from(json.decode(str).map((x) => Posts.fromJson(x)));

String postsToJson(List<Posts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Posts {

  String name;
  String age;
  String adress;
  String phone;
  String email;
  String password;


  Posts({

    required this.name,
    required this.age,
    required this.adress,
    required this.phone,
    required this.email,
    required this.password

  });

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(

    name: json["Name"],
    age: json["Age"],
    adress: json["Adress"],
    phone: json["phone"],
    email: json["email"],
    password: json["Password"],

  );

  Map<String, dynamic> toJson() => {

    "Name": name,
    "Age": age,
    "Adress": adress,
    "phone": phone,
    "email": email,
    "Password": password

  };
}
