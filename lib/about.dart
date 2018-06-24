import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = "/AboutUs";
  @override
  Widget build(BuildContext context) {

    final alucard =  new Image(
      image: new AssetImage("images/logo.png"),width: 150.0,height: 150.0,
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome Flutter Travel',
        style: TextStyle(fontSize: 28.0, color: const Color(0xFF003333)),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Flutter Travel is an application which you can share photos and videos around places where you travel in the world and chat with your friends about what they shared',
        style: TextStyle(fontSize: 16.0, color: const Color(0xFF003333),),textAlign: TextAlign.center,
      ),
    );

    final button = new Opacity(
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
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
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
                new Padding(padding: const EdgeInsets.only(top: 15.0)),
                alucard,
                welcome,
                lorem,
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                button
              ],
            ),
          )
        ],
      ),
    );

    return new Scaffold(
      body: body,
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