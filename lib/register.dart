import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  static const String routeName = "/Register";
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("images/bg.jpg"), fit: BoxFit.cover),
        ),
        child: new Stack(
          children: <Widget>[
            new ListView(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new IconButton(
                        icon: new Icon(
                          Icons.arrow_back_ios,
                          size: 35.0,
                          color: const Color(0xFF003333),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
                new Center(
                    child: new Column(
                    children: <Widget>[
                    new Container(
                      width: 110.0,
                      height: 110.0,
                      child: _image == null
                        ?
                      new DecoratedBox(
                          decoration: BoxDecoration(
                            border: new Border.all(
                                color: const Color(0xFF006633), width: 2.0),
                            image: new DecorationImage(
                              image: new AssetImage(
                                "images/addpic.png",
                              ),
                            ),
                            color: const Color(0xFF003333),
                          ))
                        :
                      new Image.file(_image,fit: BoxFit.cover,),
                    ),
                    new Padding(padding: const EdgeInsets.all(5.0)),
                    new Opacity(
                      opacity: 0.7,
                      child: new Container(
                        width: 115.0,
                        height: 45.0,
                        child: new RaisedButton(
                          onPressed: getImage,
                          child: new Text("Add Image",
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 15.0)),
                          color: const Color(0xFF006633),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                        ),
                      ),
                    ),
                    new Padding(padding: const EdgeInsets.all(7.0)),
                    new Opacity(
                        opacity: 0.7,
                        child: new Container(
                          width: 300.0,
                          height: 55.0,
                          child: new DecoratedBox(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(50.0)),
                              color: const Color(0xFF003333),
                            ),
                            child: new ListTile(
                              leading: const Icon(Icons.person_add,
                                  color: Colors.white),
                              title: new TextField(
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Your Name",
                                  hintStyle: new TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )),
                    new Padding(padding: const EdgeInsets.all(5.0)),
                    new Opacity(
                        opacity: 0.7,
                        child: new Container(
                          width: 300.0,
                          height: 55.0,
                          child: new DecoratedBox(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(50.0)),
                              color: const Color(0xFF003333),
                            ),
                            child: new ListTile(
                              leading:
                                  const Icon(Icons.mail, color: Colors.white),
                              title: new TextField(
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: new TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )),
                    new Padding(padding: const EdgeInsets.all(5.0)),
                    new Opacity(
                        opacity: 0.7,
                        child: new Container(
                          width: 300.0,
                          height: 55.0,
                          child: new DecoratedBox(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(50.0)),
                              color: const Color(0xFF003333),
                            ),
                            child: new ListTile(
                              leading:
                                  const Icon(Icons.person, color: Colors.white),
                              title: new TextField(
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle: new TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )),
                    new Padding(padding: const EdgeInsets.all(5.0)),
                    new Opacity(
                        opacity: 0.7,
                        child: new Container(
                          width: 300.0,
                          height: 55.0,
                          child: new DecoratedBox(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(50.0)),
                              color: const Color(0xFF003333),
                            ),
                            child: new ListTile(
                              leading:
                                  const Icon(Icons.lock, color: Colors.white),
                              title: new TextField(
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: new TextStyle(color: Colors.white),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                        )),
                    new Padding(padding: const EdgeInsets.all(5.0)),
                    new Opacity(
                        opacity: 0.7,
                        child: new Container(
                          width: 300.0,
                          height: 55.0,
                          child: new DecoratedBox(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(50.0)),
                              color: const Color(0xFF003333),
                            ),
                            child: new ListTile(
                              leading:
                                  const Icon(Icons.lock, color: Colors.white),
                              title: new TextField(
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Repeat Password",
                                  hintStyle: new TextStyle(color: Colors.white),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                        )),
                    new Padding(padding: const EdgeInsets.all(5.0)),
                    new Opacity(
                      opacity: 0.7,
                      child: new Container(
                        width: 300.0,
                        height: 55.0,
                        child: new RaisedButton(
                          onPressed: _alertDialog,
                          child: new Text("CREATE ACCOUNT",
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 20.0)),
                          color: const Color(0xFF006633),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _alertDialog() {
    AlertDialog dialog = new AlertDialog(
      content: new Text(
        "Başarılı",
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text("OK")),
      ],
    );
    showDialog(context: context, child: dialog);
  }
}
