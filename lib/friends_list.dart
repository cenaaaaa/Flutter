import 'package:flutter/material.dart';

class UserData {
  final String _name;
  final bool _isMyFriend;

  get name => this._name;
  get isMyFriend => this._isMyFriend;

  UserData(this._name, this._isMyFriend);
}

class FriendsListPage extends StatefulWidget {
  static String tag = "friends-list";

  @override
  _FriendsListPageState createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  static final List<String> myFriendsName = <String>[
    "John Doe", "Micheline", "Jeanne", "Jannine", "Fred", "Jammy"
  ];
  List<Widget> myFriendsCards = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /// Créer un Inkwell qui retourne vers la page de list event
          leading: InkWell(
            child: IconButton(
                tooltip: "Menu",
                icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_arrow,
                    progress: kAlwaysDismissedAnimation
                ),
                onPressed: () => Navigator.of(context).pop()
            ),
          ),
          title: new Text("Liste d'amis"),
          actions: <Widget>[
            IconButton(
              tooltip: "Chercher un ami",
              icon: const Icon(Icons.search),
              onPressed: () async {
                final List<Widget> selected = await showSearch<List<Widget>>(
                    context: context,
                    delegate: SearchFriend()
                );
              },
            )
          ],
        ),
        body: new Container(
          //height: 500.0,
            color: Color.fromRGBO(52, 59, 69, 1),
            padding: EdgeInsets.all(8.0),
            child: new ListView.builder(
                itemCount: myFriendsName.length,
                itemBuilder: (BuildContext context, int i) {
                  return _buildRow(context, myFriendsName[i]);
                }
            )
        )
    );
  }

  final defaultAvatar = Container(
      height: 75.0,
      width: 75.0,
      margin: new EdgeInsets.symmetric(
          vertical: 12.5
      ),
      alignment: FractionalOffset.centerLeft,
      child: CircleAvatar(
          radius: 34.0,
          child: IconTheme(data: IconThemeData(), child: FlutterLogo(size: 30.0))
      )
  );

  static Widget _buildRow(BuildContext context, String name, { isMyFriend: true }){
    final imageCircle = new Container(
      height: 75.0,
      width: 75.0,
      margin: new EdgeInsets.symmetric(
          vertical: 12.5
      ),
      alignment: FractionalOffset.centerLeft,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage('http://earlycoke.com/images/martin_metalsigns_81.jpg?crc=4247472040')
          )
      ),
    );

    final planetCard = new Container(
        height: 100.0,
        margin: new EdgeInsets.only(left: 46.0),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            ),
          ],
        ),

        child: Container(
            margin: new EdgeInsets.fromLTRB(50.0, 28.0, 16.0, 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(name, style: TextStyle(fontSize: 18.0)),
                        IconButton(
                          icon: Icon(isMyFriend ? Icons.remove_circle : Icons.add_circle),
                          color: Colors.blue,
                          onPressed: () {},
                          /*icon: AnimatedIcon(
                                icon: AnimatedIcons.add_event,
                                progress: kAlwaysDismissedAnimation
                            ),*/
                        )
                      ]
                  )
                ]
            )
        )
    );

    return InkWell(
        child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0
            ),
            child: new Stack(
                children: <Widget>[
                  planetCard,
                  imageCircle
                ]
            )
        )
    );
  }
}

class SearchFriend extends SearchDelegate<List<Widget>> {
  /*static final List<String> allUsersName = <String>[
    "John Doe", "Micheline", "Jeanne", "Jannine", "Fred", "Jammy",
    "Michel", "Jacky", "Turtle"
  ];*/
  static final List<UserData> allUsers = <UserData>[
    UserData("John Doe", true),
    UserData("Micheline", true),
    UserData("Jeanne", true),
    UserData("Jannine", true),
    UserData("Fred", true),
    UserData("Jammy", true),
    UserData("Michel", false),
    UserData("Jacky", false),
    UserData("Turtle", false)
  ];

  SearchFriend() : super();

  @override
  ThemeData appBarTheme(BuildContext context) {
    var appBar = super.appBarTheme(context);
    return appBar.copyWith(
        primaryIconTheme: IconThemeData(color: Colors.white),
        /// Trouver comment mettre le hintText "Search" en blanc
        /// Ceci met juste ce que l'on rentre en blanc
        textTheme: TextTheme(
            title: TextStyle(color: Colors.white, fontSize: 20)
        ),
        primaryColor: Colors.orange
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        tooltip: "Retour",
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation
        ),
        onPressed: () { this.close(context, null); }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        color: Color.fromRGBO(52, 59, 69, 1),
        padding: EdgeInsets.all(8.0),
        child: new ListView.builder(
            itemCount: allUsers.length,
            itemBuilder: (BuildContext context, int i) {
              return _FriendsListPageState._buildRow(context, allUsers[i].name, isMyFriend: allUsers[i].isMyFriend);
            }
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
        color: Color.fromRGBO(52, 59, 69, 1)
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          tooltip: "Clear",
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          }
      )
    ];
  }
}

class FriendsListPageRoute extends MaterialPageRoute<FriendsListPage> {
  FriendsListPageRoute() : super(builder: (BuildContext context) {
    return FriendsListPage();
  });
}
