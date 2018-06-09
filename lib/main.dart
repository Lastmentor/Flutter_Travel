import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_picture_app/menu.dart';
import 'package:flutter_picture_app/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

void main() => runApp(new MyApp());

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new PicApp(),
      routes: <String, WidgetBuilder>{
        Register.routeName:(BuildContext context) =>
        new Register(),
        Menu.routeName: (BuildContext context) =>
        new Menu(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class PicApp extends StatefulWidget {
  @override
  _PicAppState createState() => new _PicAppState();
}

class _PicAppState extends State<PicApp> {
  FirebaseUser _currentUser;
  TwitterLoginResult _twitterLoginResult;
  TwitterLoginStatus _twitterLoginStatus;
  TwitterSession _currentUserTwitterSession;

  // Twitter Sign-in
  Future<FirebaseUser> _handleTwitterSignIn() async {
    String snackBarMessage = '';

    final TwitterLogin twitterLogin = new TwitterLogin(
        consumerKey: '7zZ3gFiyomYWBfQe7NAqrjcQL',
        consumerSecret: '2vSWEeYbdtTAEjm1Qwi6D8Qb4jkZzDsjQPBadaT5n8ZYi3hGz6'
    );

    _twitterLoginResult = await twitterLogin.authorize();
    _currentUserTwitterSession = _twitterLoginResult.session;
    _twitterLoginStatus = _twitterLoginResult.status;

    switch (_twitterLoginStatus) {
      case TwitterLoginStatus.loggedIn:
        _currentUserTwitterSession = _twitterLoginResult.session;
        snackBarMessage = 'Successfully signed in as';
        break;

      case TwitterLoginStatus.cancelledByUser:
        snackBarMessage = 'Sign in cancelled by user.';
        break;

      case TwitterLoginStatus.error:
        snackBarMessage = 'An error occurred signing with Twitter.';
        break;
    }

    _currentUser = await _firebaseAuth.signInWithTwitter(
        authToken: _currentUserTwitterSession?.token ?? '',
        authTokenSecret: _currentUserTwitterSession?.secret ?? ''
    );

    var _user = _currentUser;
    var route = new MaterialPageRoute(
      builder: (BuildContext context) =>
      new Menu(value: _user),
    );
    Navigator.of(context).push(route);
    return _currentUser;
  }

  final GoogleSignIn googleSignIn = new GoogleSignIn();

  // Google Sign-in
  Future<FirebaseUser> signin() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _firebaseAuth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    var _user = user;
    _signout();
    var route = new MaterialPageRoute(
      builder: (BuildContext context) =>
      new Menu(value: _user),
    );
    Navigator.of(context).push(route);
    return user;
  }

  void _signout(){
    googleSignIn.signOut();
    print("User Signed Out");
  }

  void giris(){
    final user = signin();
    if(user!=null){
      _menu;
    }
  }

  void giris_twitter(){
    final user = _handleTwitterSignIn();
    if(user!=null){
      _menu;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(image: new AssetImage("images/bg.jpg"),fit: BoxFit.cover),
        ),
        child: new Stack(
          children: <Widget>[
            new ListView(
              children: <Widget>[
                new Center(
                    child: new Column(
                      children: <Widget>[
                        new Image(
                          image: new AssetImage("images/logo.png"),width: 110.0,height: 110.0,
                        ),
                        new Text(
                          "Flutter Travel",
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF003333),
                            fontSize: 30.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        new Padding(padding: const EdgeInsets.all(8.0)),

                        new Opacity(
                            opacity: 0.7,
                            child: new Container(
                              width: 300.0,
                              height: 55.0,
                              child: new DecoratedBox(
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                                  color: const Color(0xFF003333),
                                ),
                                child: new ListTile(
                                  leading: const Icon(Icons.person,color: Colors.white),
                                  title: new TextField(
                                    style: new TextStyle(color: Colors.white,fontSize: 18.0,),
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle: new TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ),
                        new Padding(padding: const EdgeInsets.all(5.0)),
                        new Opacity(
                            opacity: 0.7,
                            child: new Container(
                              width: 300.0,
                              height: 55.0,
                              child: new DecoratedBox(
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                                  color: const Color(0xFF003333),
                                ),
                                child: new ListTile(
                                  leading: const Icon(Icons.lock,color: Colors.white),
                                  title: new TextField(
                                    style: new TextStyle(color: Colors.white,fontSize: 18.0,),
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: new TextStyle(color: Colors.white),
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                              ),
                            )
                        ),
                        new Padding(padding: const EdgeInsets.all(5.0)),
                        new Opacity(
                          opacity: 0.7,
                          child: new Container(
                            width: 300.0,
                            height: 55.0,
                            child: new RaisedButton(
                              onPressed: _menu,
                              child: new Text("GO",style: new TextStyle(color: Colors.white,fontSize: 20.0)),
                              color: const Color(0xFF006633),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0)
                              ),
                            ),
                          ),
                        ),
                        new Padding(padding: const EdgeInsets.all(8.0)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new GestureDetector(
                                onTap: _alertDialog,
                                child:  new Text("Forgot Password?",style: new TextStyle(color: Colors.white,fontSize: 15.0,decoration: TextDecoration.underline),)
                            ),
                          ],
                        ),

                        new Padding(padding: const EdgeInsets.all(10.0)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Container(
                              width: 90.0,
                              height: 1.0,
                              color: Colors.white,
                            ),
                            new Text("OR",style: new TextStyle(color: Colors.white,fontSize: 15.0),),
                            new Container(
                              width: 90.0,
                              height: 1.0,
                              color: Colors.white,
                            ),
                          ],
                        ),

                        new Padding(padding: const EdgeInsets.all(7.0)),
                        new Text(
                          "Login with Social Network",
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        new Padding(padding: const EdgeInsets.all(7.0)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new GestureDetector(
                              onTap: _alertDialog,
                              child: new Container(
                                width: 45.0,
                                height: 45.0,
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("images/facebook.png"),
                                      fit: BoxFit.cover,
                                    )
                                ),

                              ),
                            ),
                            new GestureDetector(
                              onTap: giris_twitter,
                              child: new Container(
                                width: 45.0,
                                height: 45.0,
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("images/twitter.png"),
                                      fit: BoxFit.cover,
                                    )
                                ),

                              ),
                            ),
                            new GestureDetector(
                              onTap: giris,
                              child: new Container(
                                width: 45.0,
                                height: 45.0,
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("images/google.png"),
                                      fit: BoxFit.cover,
                                    )
                                ),

                              ),
                            ),
                          ],
                        ),
                        new Padding(padding: const EdgeInsets.all(15.0)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text("Don't have an account?",style: new TextStyle(color: Colors.white,fontSize: 15.0),),
                            new GestureDetector(
                                onTap: _register,
                                child:  new Text("Sign Up",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0,decoration: TextDecoration.underline),)
                            ),
                          ],
                        ),
                      ],
                    )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _alertDialog(){
    AlertDialog dialog = new AlertDialog(
      content: new Text("Başarılı",textAlign: TextAlign.center,),
      actions: <Widget>[
        new FlatButton(onPressed: () => Navigator.of(context).pop(), child: new Text("OK")),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  void _menu(){
    Navigator.of(context).pushNamed(Menu.routeName);
  }

  void _register(){
    Navigator.of(context).pushNamed(Register.routeName);
  }
}



