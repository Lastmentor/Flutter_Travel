import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = "/AboutUs";
  @override
  Widget build(BuildContext context) {

    final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 70.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('images/logo.png'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome Flutter Travel',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final back = new Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: new Row(
        children: <Widget>[
          new IconButton(icon:
          new Icon(Icons.arrow_back_ios,color: Colors.white,),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec hendrerit condimentum mauris id tempor. Praesent eu commodo lacus. Praesent eget mi sed libero eleifend tempor. Sed at fringilla ipsum. Duis malesuada feugiat urna vitae convallis. Aliquam eu libero arcu.',
        style: TextStyle(fontSize: 16.0, color: Colors.white,),textAlign: TextAlign.center,
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        children: <Widget>[back, alucard, welcome, lorem],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}