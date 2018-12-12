import 'package:flutter/material.dart';
import 'product_page.dart';
import 'home_page.dart';

class ListProduct extends StatelessWidget {
  static String tag ='List-Product';
  static int numberCount=10;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
            appBar: new AppBar(
              /// Créer un Inkwell qui retourne vers la page de list event
              leading: InkWell(
                child: Icon(Icons.keyboard_return),
                onTap: () => Navigator.of(context).pushNamed(HomePage.tag),
              ),
              title: new Text('La mega teuf'),
            ),
            body: new Container(
              //height: 500.0,
              color: Color.fromRGBO(52, 59, 69, 1),
              padding: EdgeInsets.all(8.0),
              child: new ListView.builder(
                  itemCount: numberCount,
                  itemBuilder:(BuildContext context , int i){
                    if(i == numberCount-1){
                      return ListTile(
                        title: Icon(Icons.add),
                        onTap: () {},
                      );
                    }
                    return Column(
                      children: <Widget>[
                        _buidRow(context,i),
                        Divider(
                          color: Colors.orange,
                        ),
                      ],
                    );
                  }
              ),
            ),

            bottomNavigationBar:new Container(
                color: Colors.orange,
                height: 55.0,
                child: new IconButton(
                  iconSize: 32.0,
                  color: Colors.white,
                  icon:Icon(Icons.add),
                  tooltip: 'Add a product',
                  onPressed:null ,
                )

            )

        );
  }


  Widget _buidRow( BuildContext context ,int idx){
    return ListTile(
      leading: /*new Image.network(
        'http://earlycoke.com/images/martin_metalsigns_81.jpg?crc=4247472040',
        width: 50.0,
        height: 50.0,
      ),*/
      new Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage('http://earlycoke.com/images/martin_metalsigns_81.jpg?crc=4247472040')
          )
        ),
      ),
      title: Text('Coca',
        style: TextStyle(fontSize: 20.0, color: Colors.blueGrey[300]),
      ),
      trailing: Column(
        children: [
          Text('Qte:',style: TextStyle(fontSize: 15.0, color: Colors.blueGrey[300]),),
          Text('15',style: TextStyle(fontSize: 15.0, color: Colors.blueGrey[300]),)
        ],
      ),
      onTap: () => Navigator.of(context).pushNamed(ProductPage.tag),

    );

  }
}
