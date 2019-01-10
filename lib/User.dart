import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<User> fetchPost() async {
  /// Insertion de l'URL contenant le json avec les informations à récupérer
  final response = await http.get('https://raw.githubusercontent.com/ZygoMatic74/Fake-Json/master/user/1/users.json');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load user');
  }
}

class User {
  int id;
  String username;
  String email;
  String password;
  String image;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.image,
  });


  factory User.fromJson(Map<String, dynamic> json) => new User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "password": password,
    "image": image,
  };
}
