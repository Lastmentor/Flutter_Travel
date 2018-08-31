import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'dart:math';

class Register extends StatefulWidget {

  static const String routeName = "/Register";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool checkUpload = false;

  final DocumentReference documentReference = Firestore.instance.collection('Accounts').document();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  final _nametextfield = new TextEditingController();
  final _usernametextfield = new TextEditingController();
  final _emailtextfield = new TextEditingController();
  final _passwordtextfield = new TextEditingController();
  final _repeatpasswordtextfield = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(image: new AssetImage("images/bg.jpg"),fit: BoxFit.cover),
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
                                  controller: _nametextfield,
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
                                  controller: _emailtextfield,
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
                                  controller: _usernametextfield,
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
                                  controller: _passwordtextfield,
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
                                  controller: _repeatpasswordtextfield,
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
                            onPressed: _addData,
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
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _addData() async {
    if(_emailtextfield.text != "" && _nametextfield.text != "" && _passwordtextfield.text != "" && _usernametextfield.text != "" && _repeatpasswordtextfield.text != "" && _image != null){
      if(_passwordtextfield.text == _repeatpasswordtextfield.text){

        _uploadDialog();

        File compressedFile = await FlutterNativeImage.compressImage(_image.path, quality: 90, percentage: 80);

        final String rand1 = "${new Random().nextInt(10000)}";
        final String rand2 = "${new Random().nextInt(10000)}";
        final String rand3 = "${new Random().nextInt(10000)}";
        final StorageReference ref = FirebaseStorage.instance.ref().child('${rand1}_${rand2}_${rand3}.jpg');
        final StorageUploadTask uploadTask = ref.put(compressedFile);
        final Uri downloadUrl = (await uploadTask.future).downloadUrl;

        documentReference.setData({ 'email': _emailtextfield.text, 'name': _nametextfield.text, 'password': _passwordtextfield.text, 'photo': downloadUrl.toString() , 'username': _usernametextfield.text});

        _doneDialog();

        _emailtextfield.text = "";
        _nametextfield.text = "";
        _passwordtextfield.text = "";
        _usernametextfield.text = "";
        _repeatpasswordtextfield.text = "";
        setState(() {
          _image = null;
        });
      }else{
        _alertDialog2();
      }
    }else {
      _alertDialog();
    }
  }

  void _alertDialog(){
    AlertDialog dialog = new AlertDialog(
      content: new Text("Fill All The Blanks",textAlign: TextAlign.center,),
      actions: <Widget>[
        new FlatButton(onPressed: () => Navigator.of(context).pop(), child: new Text("OK")),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  void _alertDialog2(){
    AlertDialog dialog = new AlertDialog(
      content: new Text("Passwords Are Not Same",textAlign: TextAlign.center,),
      actions: <Widget>[
        new FlatButton(onPressed: () => Navigator.of(context).pop(), child: new Text("OK")),
      ],
    );
    showDialog(context: context, child: dialog);
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
                  new Text("Account Creating ...",style: new TextStyle(color: Colors.blue,fontSize: 20.0)),
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
      content: new Text("Successfully Created!",textAlign: TextAlign.center),
      actions: <Widget>[
        new FlatButton(onPressed: () => Navigator.of(context).pop(), child: new Text("Close")),
      ],
    );
    showDialog(context: context, barrierDismissible: false, child: dialog);
    checkUpload = false;
  }

}
