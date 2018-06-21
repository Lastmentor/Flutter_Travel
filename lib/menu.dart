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
  String accountPhoto,accountEmail,accountName;

  static const String routeName = "/Menu";

  Menu({Key key,this.value,this.accountPhoto,this.accountEmail,this.accountName}) : super(key:key);

  @override
  _MenuState createState() => new _MenuState();
}

class _MenuState extends State<Menu> {

  var title = "All";

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference = Firestore.instance.collection("Shared");

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("$title"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.power_settings_new,), onPressed: () {
            Navigator.of(context).pop();
          })
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
              onTap: () {
                _onPress();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new SharePost(value:widget.value)));
              },
            ),
            new ListTile(
              leading: new Icon(Icons.account_box,color: Colors.green,),
              title: new Text("My Shared"),
              onTap: _stateMyShared,
            ),
            new Divider(color: Colors.grey,),
            new ListTile(
              leading: new Icon(Icons.home,color: Colors.pink,),
              title: new Text("All"),
              onTap: _stateAll,
            ),
            new ListTile(
              leading: new Icon(Icons.photo_library,color: Colors.orange,),
              title: new Text("Photos"),
              onTap: _statePhotos,
            ),
            new ListTile(
              leading: new Icon(Icons.local_movies,color: Colors.green,),
              title: new Text("Videos"),
              onTap: _stateVideos,
            ),
            new ListTile(
              leading: new Icon(Icons.notifications,color: Colors.purple,),
              title: new Text("Notifications"),
            ),
            new Divider(color: Colors.grey,),
            new ListTile(
              leading: new Icon(Icons.info,color: Colors.blue),
              title: new Text("About Us"),
              onTap: () {
                _onPress();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new AboutUs()));
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
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
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
                      "https://www.duvarkapla.com/media/catalog/product/cache/9/image/750x/17f82f742ffe127f42dca9de82fb58b1/T/R/TR0149.jpg"
                  ),
                ),
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.add,color: Colors.blue,),
              title: new Text("Share Post"),
              onTap: () {
                _onPress();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new SharePost(accountEmail:widget.accountEmail)));
              },
            ),
            new ListTile(
              leading: new Icon(Icons.account_box,color: Colors.green,),
              title: new Text("My Shared"),
              onTap: _stateMyShared,
            ),
            new Divider(color: Colors.grey,),
            new ListTile(
              leading: new Icon(Icons.home,color: Colors.pink,),
              title: new Text("All"),
              onTap: _stateAll,
            ),
            new ListTile(
              leading: new Icon(Icons.photo_library,color: Colors.orange,),
              title: new Text("Photos"),
              onTap: _statePhotos,
            ),
            new ListTile(
              leading: new Icon(Icons.local_movies,color: Colors.green,),
              title: new Text("Videos"),
              onTap: _stateVideos,
            ),
            new ListTile(
              leading: new Icon(Icons.notifications,color: Colors.purple,),
              title: new Text("Notifications"),
            ),
            new Divider(color: Colors.grey,),
            new ListTile(
              leading: new Icon(Icons.info,color: Colors.blue),
              title: new Text("About Us"),
              onTap: () {
                _onPress();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new AboutUs()));
              },
            ),
          ],
        ),
      ),
      body: wallpapersList != null?
      new StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          padding: const EdgeInsets.all(8.0),
          itemCount: wallpapersList.length,
          itemBuilder: (context,i){
            String imgPath = wallpapersList[i].data['url'];
            return new Material(
              elevation: 8.0,
              borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
              child: new InkWell(
                onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new ImagePage(imgPath))),
                child: new Hero(
                    tag: imgPath,
                    child: new FadeInImage(
                        placeholder: new AssetImage("images/wallfy.png"),
                        image: new NetworkImage(imgPath),
                        fit: BoxFit.cover,
                    )
                ),
              ),
            );
          },
        staggeredTileBuilder: (i) => new StaggeredTile.count(2, i.isEven?2:3),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ): new Center(
        child: new CircularProgressIndicator(),
      )
    );
  }

  void _onPress() {
    Navigator.of(context).pop();
  }

  void _stateMyShared() {
    setState((){
      title='My Shared';
      _onPress();
    });
  }

  void _stateAll() {
    setState((){
      title='All';
      _onPress();
    });
  }

  void _statePhotos() {
    setState((){
      title='Photos';
      _onPress();
    });
  }

  void _stateVideos() {
    setState((){
      title='Videos';
      _onPress();
    });
  }
}
