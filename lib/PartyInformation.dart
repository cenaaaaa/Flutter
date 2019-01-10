//Classe contenant les informations d'une Party ainsi que les produits associés à cette Party

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<PartyInformation> fetchPost() async {
  /// Insertion de l'URL contenant le json avec les informations à récupérer
  final response = await http.get('https://raw.githubusercontent.com/ZygoMatic74/Fake-Json/master/party/information/3/party.json');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return PartyInformation.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load user');
  }
}

class PartyInformation {
  Information information;
  List<Product> products;

  PartyInformation({
    this.information,
    this.products,
  });

  factory PartyInformation.fromJson(Map<String, dynamic> json) => new PartyInformation(
    information: Information.fromJson(json["information"]),
    products: new List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "information": information.toJson(),
    "products": new List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Information {
  int id;
  int organisateurId;
  String title;
  String description;
  dynamic image;
  String address;
  String date;

  Information({
    this.id,
    this.organisateurId,
    this.title,
    this.description,
    this.image,
    this.address,
    this.date,
  });

  factory Information.fromJson(Map<String, dynamic> json) => new Information(
    id: json["id"],
    organisateurId: json["organisateur_id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    address: json["address"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "organisateur_id": organisateurId,
    "title": title,
    "description": description,
    "image": image,
    "address": address,
    "date": date,
  };
}

class Product {
  int id;
  int partyId;
  int productId;
  int requiredQte;

  Product({
    this.id,
    this.partyId,
    this.productId,
    this.requiredQte,
  });

  factory Product.fromJson(Map<String, dynamic> json) => new Product(
    id: json["id"],
    partyId: json["party_id"],
    productId: json["product_id"],
    requiredQte: json["required_qte"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "party_id": partyId,
    "product_id": productId,
    "required_qte": requiredQte,
  };
}