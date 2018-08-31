import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {

  static const String routeName = "/AboutUs";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xFFD6A4A4),
            const Color(0xFFFFEDBC),
          ]),
        ),
        child: new ListView(
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
                      new Image(
                      image: new AssetImage("images/logo.png"),width: 150.0,height: 150.0,
                      ),
                      new Text(
                        'Flutter Travel',
                        style: TextStyle(fontSize: 28.0, color: const Color(0xFF003333),),textAlign: TextAlign.center,
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 18.0)),
                      new Text(
                      'Flutter Travel is an application which you can share photos and videos around places where you travel in the world',
                      style: TextStyle(fontSize: 16.0, color: const Color(0xFF003333),),textAlign: TextAlign.center,
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 23.0)),
                      new Opacity(
                        opacity: 0.7,
                        child: new Container(
                          width: 280.0,
                          height: 55.0,
                          child: new RaisedButton(
                            onPressed: _launchURL,
                            child: new Text("Visit Facebook Page",
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 20.0)),
                            color: const Color(0xFF006633),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 10.0)),
                    ],
                  ),
                )
              ],
            )
      ),
    );
  }

  void _launchURL() async {
    const url = 'https://www.facebook.com/Flutter-Travel-198549500800595/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
