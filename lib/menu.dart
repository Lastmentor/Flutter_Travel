import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final FirebaseUser value;

  static const String routeName = "/Menu";

  Menu({Key key,this.value}) : super(key:key);

  @override
  _MenuState createState() => new _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Travel"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                "${widget.value.displayName}",
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              accountEmail: new Text(
                "${widget.value.email}",
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              currentAccountPicture: new GestureDetector(
                onTap: null,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                    "${widget.value.photoUrl}",
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage(
                      "https://bilgibirikimi.net/wp-content/uploads/2012/04/izmir-saat-kulesi.jpg"
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: _cikis,
          child: new Text("Sign Out",style: new TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  void _cikis() {
    Navigator.of(context).pop();
  }
}
