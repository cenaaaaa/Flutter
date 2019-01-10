import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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