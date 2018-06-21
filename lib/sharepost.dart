import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class SharePost extends StatefulWidget {

  final FirebaseUser value;
  String accountEmail;

  SharePost({Key key,this.value,this.accountEmail}) : super(key:key);

  @override
  _SharePostState createState() => new _SharePostState();
}

class _SharePostState extends State<SharePost> {

  final DocumentReference documentReference = Firestore.instance.collection('Shared').document();

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
        primaryColor: const Color(0xFF006400),
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
              icon: new Icon(
                  Icons.arrow_back_ios
              ),
              onPressed: _back
          ),
          title: new Text('Upload Image'),
        ),
        body: new ListView(
          padding: new EdgeInsets.all(32.0),
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new TextField(
                  decoration: new InputDecoration(
                    labelText: 'Add Information',
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
                      child: new Text("Select an Image"),
                      splashColor: Colors.redAccent,
                    ),
              ],
            )
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _addData,
          tooltip: 'Upload Image',
          child: new Icon(Icons.send),
        ),
      ),
    );
  }

  void _back() {
    Navigator.of(context).pop();
  }

  void _addData() async {
    String realEmail;
    widget.accountEmail == null ? realEmail = widget.value.email : realEmail = widget.accountEmail;
    var now = new DateTime.now();
    final String rand1 = "${new Random().nextInt(10000)}";
    final String rand2 = "${new Random().nextInt(10000)}";
    final String rand3 = "${new Random().nextInt(10000)}";
    final StorageReference ref = FirebaseStorage.instance.ref().child('${rand1}_${rand2}_${rand3}.jpg');
    final StorageUploadTask uploadTask = ref.put(_image);
    final Uri downloadUrl = (await uploadTask.future).downloadUrl;

    documentReference.setData({'email': realEmail, 'text': textfield.text, 'time': now.toString().substring(0,16), 'url': downloadUrl.toString()});

    textfield.text = "";
    setState(() {
      _image = null;
    });
  }
}
