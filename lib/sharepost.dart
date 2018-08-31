import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class Sharepost extends StatefulWidget {

  final FirebaseUser value;
  final String accountEmail;
  final String accountPhoto;
  final String accountName;

  Sharepost({Key key,this.value,this.accountEmail,this.accountPhoto,this.accountName}) : super(key:key);

  @override
  _SharepostState createState() => _SharepostState();
}

class _SharepostState extends State<Sharepost> {

  final DocumentReference documentReference = Firestore.instance.collection('Shared').document();

  File _image;
  bool checkUpload = false;

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
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: const Color(0xFF003333),
          leading: new IconButton(
              icon: new Icon(
                  Icons.arrow_back_ios
              ),
              onPressed: _back2
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
                  color: const Color(0xFF006633),
                  textColor: Colors.white,
                  child: new Text("Select an Image"),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _addData,
          backgroundColor: const Color(0xFF006633),
          tooltip: 'Upload Image',
          child: new Icon(Icons.send),
        ),
      ),
    );
  }

  void _back() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _back2() {
    Navigator.of(context).pop();
  }

  void _addData() async {
    _uploadDialog();
    String realEmail;
    String realPhoto;
    String realName;
    if(widget.accountEmail == null){
      realEmail = widget.value.email;
      realPhoto = widget.value.photoUrl;
      realName = widget.value.displayName;
    }else{
      realEmail = widget.accountEmail;
      realPhoto = widget.accountPhoto;
      realName = widget.accountName;
    }

    var now = new DateTime.now();
    final String rand1 = "${new Random().nextInt(10000)}";
    final String rand2 = "${new Random().nextInt(10000)}";
    final String rand3 = "${new Random().nextInt(10000)}";
    final StorageReference ref = FirebaseStorage.instance.ref().child('${rand1}_${rand2}_${rand3}.jpg');
    final StorageUploadTask uploadTask = ref.put(_image);
    final Uri downloadUrl = (await uploadTask.future).downloadUrl;

    documentReference.setData({'aurl': realPhoto, 'email': realEmail, 'name': realName, 'text': textfield.text, 'time': now.toString().substring(0,16), 'url': downloadUrl.toString()});

    _doneDialog();

    textfield.text = "";
    setState(() {
      _image = null;
    });
  }

  void _uploadDialog() {
    if(checkUpload == false){
      showDialog(context: context, barrierDismissible: false, child: new Dialog(
          child:  new Container(
            width: 233.0,
            height: 233.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: Colors.white),
            ),
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Padding(padding: const EdgeInsets.only(top: 17.0)),
                  new Text("Uploading Image ...",style: new TextStyle(color: Colors.blue,fontSize: 20.0)),
                ],
              ),
            ),
          )
      ),);
    }
    else {
      Navigator.of(context).pop();
    }
  }

  void _doneDialog(){
    setState((){
      checkUpload = true;
    });
    _uploadDialog();
    AlertDialog dialog = new AlertDialog(
      content: new Text("Upload Completed!",textAlign: TextAlign.center),
      actions: <Widget>[
        new FlatButton(onPressed: () => _back(), child: new Text("Close")),
      ],
    );
    showDialog(context: context, barrierDismissible: false, child: dialog);
    checkUpload = false;
  }
}
