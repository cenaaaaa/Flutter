import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Party> fetchPost() async {
  /// Insertion de l'URL contenant le json avec les informations à récupérer
  final response = await http.get('https://raw.githubusercontent.com/ZygoMatic74/Fake-Json/master/party/parties/1/parties.json');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Party.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load user');
  }
}

class Party {
  String id;
  String organisateurId;
  String title;
  String description;
  String image;
  String address;
  String date;

  Party({
    this.id,
    this.organisateurId,
    this.title,
    this.description,
    this.image,
    this.address,
    this.date,
  });

  factory Party.fromJson(Map<String, dynamic> json) =>
      new Party(
        id: json["id"],
        organisateurId: json["organisateur_id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        address: json["address"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "organisateur_id": organisateurId,
        "title": title,
        "description": description,
        "image": image,
        "address": address,
        "date": date,
      };
}