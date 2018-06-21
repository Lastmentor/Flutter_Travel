import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {

  String imgPath;
  ImagePage(this.imgPath);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SizedBox.expand(
        child: new Container(
          decoration: new BoxDecoration(
            color: Colors.black,
          ),
          child: new Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.center,
                child: new Hero(tag: imgPath, child: new Image.network(imgPath)),
              ),
              new Align(
                alignment: Alignment.topCenter,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      leading: new IconButton(icon: new Icon(Icons.arrow_back_ios,color: Colors.red,size: 30.0,), onPressed: () => Navigator.of(context).pop()),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
