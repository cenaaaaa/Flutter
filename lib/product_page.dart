import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'listproduct_page.dart';

String _ProductName(int id) {
  return 'Coca-cola';
}

double _ProductPrice(int id){
  return 8.75;
}

String _ProductDescription(int id){
  return 'Eau gazéifiée ; sucre ; colorant : caramel (E 150d) ; acidifiant : aci, de phosphorique ; extraits végétaux ; arôme caféine ; caféine 10 mg';
}

class ProductPage extends StatefulWidget {
  static String tag = 'product-page';

  @override
  _ProductPageState createState() => new _ProductPageState();
}


class _ProductPageState extends State<ProductPage> {
  static int id;
  String name = _ProductName(id);
  double price = _ProductPrice(id);
  String description = _ProductDescription(id);

  String barcode = "";
  int nbProduit=0;

  Container _BarCodeEmpty(){
    if (barcode!=""){
      return new Container(
        padding: EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: RaisedButton(
                  child: Text(
                    'Retour',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.pop(context),
                  splashColor: Theme.of(context).splashColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: RaisedButton(
                  child: Text(
                    'Valider',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirmation'),
                          content: Text(
                              'Vous souhaitez apporter ${nbProduit} ${name} à la soirée.'
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Annuler'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                              child: Text('Ok'),

                              ///probleme lors du retour vers la liste des evenement, lors du clic sur le bouton retour
                              ///on reviens sur la popup

                              onPressed: () => Navigator.of(context).pushNamed(ListProduct.tag), ///retour liste produits
                            )
                          ],
                        )
                    );
                  },
                  splashColor: Theme.of(context).splashColor,
                ),
              ),
            ]
        ),
        color: Color.fromRGBO(52, 59, 69, 1),
      );
    }
  }

  Widget _scanner(){
    if (barcode==""){
      return new Container(
        child: RaisedButton(
          child: Text(
            'SCANNER',
            style: TextStyle(color: Colors.white),
          ),
          color: Theme.of(context).primaryColor,
          onPressed: barcodeScanning,
          splashColor: Theme.of(context).splashColor,
        ),
      );
    }else {
      return new Container(
          child: Row(
              children: [
                Text(
                  'Nombre: ${nbProduit}  ',
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
                Column(
                    children: [
                      IconButton(
                          icon: Icon(Icons.add_circle),
                          color: Colors.green,
                          onPressed: () => setState(() => nbProduit++)
                      ),
                      nbProduit!=0? IconButton(
                        icon: Icon(Icons.do_not_disturb_on),
                        color: Colors.red,
                        onPressed: () => setState(() => nbProduit--),
                      ):new Container(child: Text('\n\n'))
                    ]
                )
              ]
          )
      );
    }
  }

  @override
  initState()
  {
    super.initState();
  }

  File galleryFile;

  imageSelectorGallery() async
  {
    galleryFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
// maxHeight: 50.0,
// maxWidth: 50.0,
    );
    print("Vous avez selectionner la gallerie d'image : " + galleryFile.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Description Produit'),
      ),
      backgroundColor: Color.fromRGBO(52, 59, 69, 1),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Image.network(
                      'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            '${name}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Prix: ${price}€',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                        _scanner(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  Text(
                    'Description du produit: \n\n',
                    textAlign: TextAlign.justify,
                    style: TextStyle(decoration: TextDecoration.underline,color: Colors.blueGrey, fontSize: 18.0),
                  ),
                  Text(
                    '${description}\n\n',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  Text(
                    'Code barre du produit: ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(decoration: TextDecoration.underline,color: Colors.blueGrey, fontSize: 18.0),
                  ),
                  Text(
                    '${barcode}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet:

      _BarCodeEmpty(),
    );
  }

  Widget displayImage()
  {
    return new SizedBox(
      height: 300.0,
      width: 400.0,
      child: galleryFile == null
          ? new Text('Rien à afficher')
          : new Image.file(galleryFile),
    );
  }

  // Methode pour Scanner le CodeBarre
  Future barcodeScanning() async
  {
//imageSelectorGallery();

    try
    {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    }

    on PlatformException catch (e)
    {
      if (e.code == BarcodeScanner.CameraAccessDenied)
      {
        setState(()
        {
          this.barcode = 'No camera permission!';
        });
      }
      else
      {
        setState(() => this.barcode = 'Error Inconnu: $e');
      }
    }
    on FormatException
    {
      setState(() => this.barcode = 'Rien Scanné.');
    }
    catch (e)
    {
      setState(() => this.barcode = 'Error Inconnu: $e');
    }
  }
}
