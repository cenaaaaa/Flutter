import 'package:flutter/material.dart';


class CreateProduct extends StatefulWidget {

  static String tag = "create-product";

  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout produit"),
      ),
      body: Container(
          color: Color.fromRGBO(52, 59, 69, 1),
          child: Center(
            child: Text("Ajouter le meme code que la création de soirée"),
        )
      ),
    );
  }
}
