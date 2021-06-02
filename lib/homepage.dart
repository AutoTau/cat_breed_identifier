import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Future<File> imageFile;
  var _image;
  String result = '';
  var imagePicker;

  @override
  initState() {
    super.initState();
    imagePicker = ImagePicker();
    loadDataModelFiles();
  }

  loadDataModelFiles() async {
    var output = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
    print(output);
  }

  doImageClassification() async {
    var recognitions = await Tflite.runModelOnImage(
        path: _image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 3,
        threshold: 0.1,
        asynch: true);
    print(recognitions?.length.toString());
    setState(() {
      result = "";
    });
    recognitions?.forEach((element) {
      setState(() {
        //print(element.toString());
        print('hello');
        if (element["label"].toString() == recognitions.last["label"].toString()) {
          result += '%';
          result += element["label"];
        } else {
          result += '%';
          result += element["label"].toString().padRight(2);
          result += ', ';
        }
      });
    });
  }

  selectPhoto() async {
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

  capturePhoto() async {
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.camera);
    _image = File(pickedFile.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

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
                      margin: EdgeInsets.only(top: 285, right: 35, left: 40),
                      // ignore: unnecessary_null_comparison
                      child: _image != null
                          ? Image.file(_image,
                              height: 100, width: 150, fit: BoxFit.contain)
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
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  '$result',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Brand Bold',
                      fontSize: 25,
                      color: Colors.black),
                ),
              ),
            ],
          )),
    ));
  }
}
