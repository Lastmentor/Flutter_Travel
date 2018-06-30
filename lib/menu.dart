import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picture_app/about.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_picture_app/fullscreen.dart';
import 'package:flutter_picture_app/sharepost.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Menu extends StatefulWidget {
  final FirebaseUser value;
  String accountPhoto, accountEmail, accountName;

  static const String routeName = "/Menu";

  Menu(
      {Key key,
      this.value,
      this.accountPhoto,
      this.accountEmail,
      this.accountName})
      : super(key: key);

  @override
  _MenuState createState() => new _MenuState();
}

class _MenuState extends State<Menu> {
  String tempEmail;
  var title = "All";
  bool check = false;
  var actionTitle = "Normal View";

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  List <AllItems> temp;
  final CollectionReference collectionReference = Firestore.instance.collection("Shared");

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
        _listeFiltrele();
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  Widget _buildList() {
    if (actionTitle != "Normal View") {
      return new ListView.builder(
          itemCount: temp.length,
          itemBuilder: (context, i) {
            String imgPath2 = temp[i].url;
            String userPhoto = temp[i].aurl;
            return new Card(
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                        width: 70.0,
                        height: 70.0,
                        margin: const EdgeInsets.all(10.0),
                        decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.black26),
                          shape: BoxShape.circle,
                          image: new DecorationImage(image: new NetworkImage(userPhoto))
                        ),
                      ),
                      new Text(temp[i].name,style: new TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  new Image.network(
                      imgPath2,
                      width: 400.0,
                      height: 300.0,
                      fit: BoxFit.cover,
                  ),
                  new ListTile(
                    title: new Text(
                      temp[i].text,
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: new Text(temp[i].time),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Icon(Icons.favorite,color: Colors.red),
                      new Icon(Icons.chat_bubble_outline),
                      new Icon(Icons.turned_in_not),
                    ],
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                  ),
                ],
              ),
            );
          });
    } else {
      return new StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        padding: const EdgeInsets.all(4.0),
        itemCount: temp.length,
        itemBuilder: (context, i) {
          String imgPath = temp[i].url;
          return new Material(
            elevation: 8.0,
            borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
            child: new InkWell(
              onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ImagePage(imgPath))),
              child: new Hero(
                  tag: imgPath,
                  child: new FadeInImage(
                    placeholder: new AssetImage("images/l.png"),
                    image: new NetworkImage(imgPath),
                    fit: BoxFit.cover,
                  )),
            ),
          );
        },
        staggeredTileBuilder: (i) =>
            new StaggeredTile.count(2, i.isEven ? 2 : 3),
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: const Color(0xFF003333),
          title: new Text("$title"),
          centerTitle: true,
          actions: <Widget>[
            new GestureDetector(
              onTap: () {
                setState(() {
                  check == false
                      ? actionTitle = "Detailed View"
                      : actionTitle = "Normal View";
                  check = !check;
                });
              },
              child: new Center(
                child: new Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: new Text(
                    "$actionTitle",
                    style: new TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: widget.accountEmail == null
            ? new Drawer(
                child: new ListView(
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                      accountName: new Text(
                        "${widget.value.displayName}",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
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
                              "https://www.duvarkapla.com/media/catalog/product/cache/9/image/750x/17f82f742ffe127f42dca9de82fb58b1/T/R/TR0149.jpg"),
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      title: new Text("Share Post"),
                      onTap: () {
                        _onPress();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new SharePost(value: widget.value)));
                      },
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.account_box,
                        color: Colors.green,
                      ),
                      title: new Text("My Shared"),
                      onTap: _stateMyShared,
                    ),
                    new Divider(
                      color: Colors.grey,
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.home,
                        color: Colors.pink,
                      ),
                      title: new Text("All"),
                      onTap: _stateAll,
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: Colors.orange,
                      ),
                      title: new Text("Photos"),
                      onTap: _statePhotos,
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.local_movies,
                        color: Colors.green,
                      ),
                      title: new Text("Videos"),
                      onTap: _stateVideos,
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      title: new Text("Favorites"),
                      onTap: _stateFavorites,
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.notifications,
                        color: Colors.purple,
                      ),
                      title: new Text("Notifications"),
                    ),
                    new Divider(
                      color: Colors.grey,
                    ),
                    new ListTile(
                      leading: new Icon(Icons.info, color: Colors.blue),
                      title: new Text("About Us"),
                      onTap: () {
                        _onPress();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new AboutUs()));
                      },
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.power_settings_new,
                        color: Colors.red,
                      ),
                      title: new Text("Log Out"),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              )
            : new Drawer(
                child: new ListView(
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                      accountName: new Text(
                        "${widget.accountName}",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      accountEmail: new Text(
                        "${widget.accountEmail}",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      currentAccountPicture: new GestureDetector(
                        onTap: null,
                        child: new CircleAvatar(
                          backgroundImage: new NetworkImage(
                            "${widget.accountPhoto}",
                          ),
                        ),
                      ),
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://www.duvarkapla.com/media/catalog/product/cache/9/image/750x/17f82f742ffe127f42dca9de82fb58b1/T/R/TR0149.jpg"),
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      title: new Text("Share Post"),
                      onTap: () {
                        _onPress();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new SharePost(
                                    accountEmail: widget.accountEmail, accountPhoto: widget.accountPhoto, accountName: widget.accountName)));
                      },
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.account_box,
                        color: Colors.green,
                      ),
                      title: new Text("My Shared"),
                      onTap: _stateMyShared,
                    ),
                    new Divider(
                      color: Colors.grey,
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.home,
                        color: Colors.pink,
                      ),
                      title: new Text("All"),
                      onTap: _stateAll,
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: Colors.orange,
                      ),
                      title: new Text("Photos"),
                      onTap: _statePhotos,
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.local_movies,
                        color: Colors.green,
                      ),
                      title: new Text("Videos"),
                      onTap: _stateVideos,
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      title: new Text("Favorites"),
                      onTap: _stateFavorites,
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.notifications,
                        color: Colors.purple,
                      ),
                      title: new Text("Notifications"),
                    ),
                    new Divider(
                      color: Colors.grey,
                    ),
                    new ListTile(
                      leading: new Icon(Icons.info, color: Colors.blue),
                      title: new Text("About Us"),
                      onTap: () {
                        _onPress();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new AboutUs()));
                      },
                    ),
                    new ListTile(
                      leading: new Icon(
                        Icons.power_settings_new,
                        color: Colors.red,
                      ),
                      title: new Text("Log Out"),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
        body: new Container(
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: [
            const Color(0xFFD6A4A4),
            const Color(0xFFFFEDBC),
          ])),
          child: temp != null
              ? _buildList()
              : new Center(
                  child: new CircularProgressIndicator(),
                ),
        ));
  }

  void _onPress() {
    Navigator.of(context).pop();
  }

  void _stateMyShared() {
    setState(() {
      title = 'My Shared';
      _listeFiltrele();
      _onPress();
    });
  }

  void _stateAll() {
    setState(() {
      title = 'All';
      _listeFiltrele();
      _onPress();
    });
  }

  void _statePhotos() {
    setState(() {
      title = 'Photos';
      _listeFiltrele();
      _onPress();
    });
  }

  void _stateVideos() {
    setState(() {
      title = 'Videos';
      _listeFiltrele();
      _onPress();
    });
  }

  void _stateFavorites() {
    setState(() {
      title = 'Favorites';
      _listeFiltrele();
      _onPress();
    });
  }

  void _listeFiltrele() {
    widget.accountEmail == null
        ? tempEmail = widget.value.email
        : tempEmail = widget.accountEmail;
    temp = new List<AllItems>();
    for (int i = 0; i < wallpapersList.length; i++) {
      if (title.toString() == "All") {
        temp.add(new AllItems(wallpapersList[i].data['aurl'],wallpapersList[i].data['email'],wallpapersList[i].data['name'],wallpapersList[i].data['text'],wallpapersList[i].data['time'],wallpapersList[i].data['url']));
      } else if (title.toString() == "Photos") {
        temp.add(new AllItems(wallpapersList[i].data['aurl'],wallpapersList[i].data['email'],wallpapersList[i].data['name'],wallpapersList[i].data['text'],wallpapersList[i].data['time'],wallpapersList[i].data['url']));
      } else if (title.toString() == "Videos") {
        temp.add(new AllItems(wallpapersList[i].data['aurl'],wallpapersList[i].data['email'],wallpapersList[i].data['name'],wallpapersList[i].data['text'],wallpapersList[i].data['time'],wallpapersList[i].data['url']));
      } else if (title.toString() == "Favorites") {
        temp.add(new AllItems(wallpapersList[i].data['aurl'],wallpapersList[i].data['email'],wallpapersList[i].data['name'],wallpapersList[i].data['text'],wallpapersList[i].data['time'],wallpapersList[i].data['url']));
      } else if (title.toString() == "My Shared") {
        if (wallpapersList[i].data['email'] == tempEmail) {
          temp.add(new AllItems(wallpapersList[i].data['aurl'],wallpapersList[i].data['email'],wallpapersList[i].data['name'],wallpapersList[i].data['text'],wallpapersList[i].data['time'],wallpapersList[i].data['url']));
        }
      }
    }
  }
}

class AllItems {
  final String aurl;
  final String email;
  final String name;
  final String text;
  final String time;
  final String url;
  AllItems(this.aurl,this.email,this.name,this.text,this.time,this.url);
}
