import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SharePost extends StatefulWidget {
  @override
  _SharePostState createState() => new _SharePostState();
}

class _SharePostState extends State<SharePost> {

  String _value = null;
  List<String> _values = new List<String>();

  @override
  void initState() {
    _values.addAll([
      "Image",
      "Video",
    ]);
    _value = _values.elementAt(0);
  }

  void _onChangged(String value) {
    setState(() {
      _value = value;
    });
  }

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  final textfield = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Colors.green,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
              icon: new Icon(
                  Icons.arrow_back_ios
              ),
              onPressed: _back
          ),
          title: new Text('Share Post'),
        ),
        body: new ListView(
          padding: new EdgeInsets.all(32.0),
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "Konu :",
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    new DropdownButton(
                      value: _value,
                      items: _values.map((String value) {
                        return new DropdownMenuItem(
                            value: value,
                            child: new Row(
                              children: <Widget>[new Text('${value}')],
                            ));
                      }).toList(),
                      onChanged: (String value) {
                        _onChangged(value);
                      },
                    ),
                  ],
                ),
                new TextField(
                  decoration: new InputDecoration(
                    labelText: 'Açıklama Girin',
                  ),
                  controller: textfield,
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Center(
                  child: _image == null
                      ? new Text('Content Not Selected')
                      : new Image.file(_image),
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new MaterialButton(
                      onPressed: getImage,
                      height: 40.0,
                      minWidth: 140.0,
                      color: Colors.green,
                      textColor: Colors.white,
                      child: new Text("Pick Image"),
                      splashColor: Colors.redAccent,
                    ),
              ],
            )
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _back,
          tooltip: 'Share Post',
          child: new Icon(Icons.send),
        ),
      ),
    );
  }

  void _back() {
    Navigator.of(context).pop();
  }
}
