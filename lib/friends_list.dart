import 'dart:math';
import 'package:flutter/material.dart';

class UserData {
  static final allUsers = <UserData>[
    UserData("John Doe", true),
    UserData("Micheline", true),
    UserData("Jeanne", true),
    UserData("Jannine", true),
    UserData("Fred", true),
    UserData("Jammy", true),
    UserData("Jacky", false),
    UserData("Michel", false),
    UserData("Turtle", false)
  ];

  final String _name;
  bool _friend;

  get name => this._name;
  get friend => this._friend;
  set friend(bool value) => this._friend = value;

  UserData(this._name, this._friend);

  static List<UserData> getFriendsList() {
    return UserData.allUsers.toList().where((UserData user) => user._friend).toList();
  }

  static List<UserData> getUsersList({bool includeFriends : false}) {
    return includeFriends
        ? UserData.allUsers.toList()
        : UserData.allUsers.toList().where((UserData user) => !user._friend).toList();
  }
}

class FriendsListPage extends StatefulWidget {
  static String tag = "friends-list";

  @override
  _FriendsListPageState createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  ListView userListView;

  @override
  Widget build(BuildContext context) {
    var friendsList = UserData.getFriendsList();

    userListView = ListView.builder(
        itemCount: friendsList.length,
        itemBuilder: (BuildContext context, int i) {
          return _buildUserCard(context, user: friendsList[i], callback: () => setState(() {}));
        }
    );

    return Scaffold(
        appBar: AppBar(
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
                await showSearch<List<Widget>>(
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
            child: userListView
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

  static Widget _buildUserCard(BuildContext context, { UserData user, Function callback }){
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
                        Text(user.name, style: TextStyle(fontSize: 18.0)),
                        IconButton(
                          iconSize: 30.0,
                          icon: Icon(user.friend ? Icons.remove_circle : Icons.add_circle),
                          color: Colors.orange,
                          onPressed: () {
                            user.friend = !user.friend;
                            if (callback != null) {
                              callback();
                            }
                          },
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

    return Container(
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
  SearchFriend() : super();

  @override
  ThemeData appBarTheme(BuildContext context) {
    var appBar = super.appBarTheme(context);
    return appBar.copyWith(
        primaryIconTheme: IconThemeData(color: Colors.white),
        /// TODO: Trouver comment mettre le hintText "Search" en blanc
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
    var resultsList = UserData.getUsersList().where(
            (UserData user) {
          return user.name.toString().toUpperCase().contains(this.query.toUpperCase());
        }
    ).toList();
    return Container(
        color: Color.fromRGBO(52, 59, 69, 1),
        padding: EdgeInsets.all(8.0),
        child: new ListView.builder(
            itemCount: resultsList.length,
            itemBuilder: (BuildContext context, int i) {
              final result = resultsList[i];
              return _FriendsListPageState._buildUserCard(
                  context,
                  user: result,
                  callback: () => Navigator.of(context).pop()
              );
            }
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
        color: Color.fromRGBO(52, 59, 69, 1),
        child: _SuggestionList(
            query: this.query,
            onSelected: (String suggestions) {
              this.query = suggestions;
              showResults(context);
            }
        )
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          tooltip: "Effacer",
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          }
      )
    ];
  }
}

class _SuggestionList extends StatefulWidget {
  final ValueChanged<String> onSelected;
  final String query;

  _SuggestionList({this.query, this.onSelected});

  @override
  _SuggestionListState createState() => _SuggestionListState(query: query, onSelected: onSelected);
}

class _SuggestionListState extends State<_SuggestionList> {
  final ValueChanged<String> onSelected;
  final List<String> suggestions = <String>[
    "Billy", "Micheline", "Jeanne"
  ];
  String query;

  _SuggestionListState({this.query, this.onSelected});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead.copyWith(color: Colors.white);
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int i) {
          final suggestion = suggestions[i];
          return ListTile(
              title: RichText(
                  text: TextSpan(
                      text: suggestion.substring(0, min(suggestion.length, query.length)),
                      style: textTheme.copyWith(fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: suggestion.substring(min(suggestion.length, query.length)),
                            style: textTheme
                        )
                      ]
                  )
              ),
              onTap: () => onSelected(suggestion)
          );
        }
    );
  }
}

class FriendsListPageRoute extends MaterialPageRoute<FriendsListPage> {
  FriendsListPageRoute() : super(builder: (BuildContext context) {
    return FriendsListPage();
  });
}
