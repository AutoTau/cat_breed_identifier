import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Future<File> imageFile;
  var _image;
  String result = 'Persian';
  var imagePicker;

  selectPhoto() async {}

  capturePhoto() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/pictureframe.jpg'),
                  fit: BoxFit.scaleDown)),
          child: Column(
            children: [
              SizedBox(width: 100),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Stack(children: <Widget>[
                  Center(
                      child: TextButton(
                    onPressed: selectPhoto,
                    onLongPress: capturePhoto,
                    child: Container(
                      margin: EdgeInsets.only(top: 30, right: 35, left: 18),
                      // ignore: unnecessary_null_comparison
                      child: _image != null
                          ? Image.file(_image,
                              height: 160, width: 400, fit: BoxFit.scaleDown)
                          : Container(
                              height: 140,
                              width: 90,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ))
                ]),
              ),
              SizedBox(height: 160),
              Container(
                margin: EdgeInsets.only(top: 80),
                child: Text(
                  '$result' + ' Kitty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Brand Bold',
                      fontSize: 35,
                      color: Colors.black),
                ),
              ),
            ],
          )),
    ));
  }
}
