import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePage extends StatelessWidget {

  final String imgPath;
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
                child: new PhotoView(imageProvider: new NetworkImage(imgPath)),
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: new Opacity(
                          opacity: 0.7,
                          child: new Container(
                          width: 40.0,
                          height: 40.0,
                          margin: const EdgeInsets.only(top: 35.0,left: 15.0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                                image: new AssetImage("images/kapat.png"),
                                fit: BoxFit.cover
                            ),
                            color: const Color(0xFF696969),
                            borderRadius: new BorderRadius.circular(30.0)
                          ),
                        ),
                      )
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}