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
        title: new Text("Flutter Travel"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.power_settings_new,), onPressed: () {
            Navigator.of(context).pop();
          })
        ],
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
                      "https://www.duvarkapla.com/media/catalog/product/cache/9/image/750x/17f82f742ffe127f42dca9de82fb58b1/T/R/TR0149.jpg"
                  ),
                ),
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.add,color: Colors.blue,),
              title: new Text("Share Post"),
            ),
            new ListTile(
              leading: new Icon(Icons.account_box,color: Colors.green,),
              title: new Text("My Shared"),
            ),
            new Divider(color: Colors.grey,),
            new ListTile(
              leading: new Icon(Icons.home,color: Colors.pink,),
              title: new Text("All"),
            ),
            new ListTile(
              leading: new Icon(Icons.photo_library,color: Colors.orange,),
              title: new Text("Photos"),
            ),
            new ListTile(
              leading: new Icon(Icons.local_movies,color: Colors.green,),
              title: new Text("Videos"),
            ),
            new ListTile(
              leading: new Icon(Icons.notifications,color: Colors.purple,),
              title: new Text("Notifications"),
            ),
            new Divider(color: Colors.grey,),
            new ListTile(
              leading: new Icon(Icons.info,color: Colors.blue),
              title: new Text("About Us"),
            ),
          ],
        ),
      ),
    );
  }
}
