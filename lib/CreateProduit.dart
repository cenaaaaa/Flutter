import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//import des pages
import 'Party.dart';


class CreateProduct extends StatefulWidget {

  static String tag = "create-product";

  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {

  List<Party> party;

  Future<Party> getData() async {
    /// Insertion de l'URL contenant le json avec les informations à récupérer
    final response = await http.get('https://raw.githubusercontent.com/ZygoMatic74/Fake-Json/master/party/parties/1/parties.json',
        headers: {
          "Accept": "application/json"
        });

    this.setState((){
      party= emptyFromJson(response.body);
    });


  }

  @override
  void initState() {
    this.getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout produit"),
      ),
      body: Container(
          color: Color.fromRGBO(52, 59, 69, 1),
          child: Center(
            child: Text(party[0].title),
        )
      ),
    );
  }
}

List<Party> emptyFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Party>.from(jsonData.map((x) => Party.fromJson(x)));
}