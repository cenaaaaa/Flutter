import 'package:flutter/material.dart';
import 'product_page.dart';

class ListProduct extends StatelessWidget {
  static String tag ='List-Product';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
            appBar: new AppBar(
              title: new Text('La mega teuf'),
            ),
            body: new Container(
              //height: 500.0,
              color: Color.fromRGBO(52, 59, 69, 1),
              padding: EdgeInsets.all(8.0),
              child: new ListView.builder(
                  itemCount: 10,
                  itemBuilder:(BuildContext context , int i){
                    //return _buidRow(i);
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
      leading: new Image.asset(
        'images/coca.jpg',
        width: 50.0,
        height: 50.0,
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
