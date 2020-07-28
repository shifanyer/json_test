import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_test/z_directory/adding_objects.dart';

void main() {
  runApp(MaterialApp(title: 'MyApp', home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class PictureInformation {
  String image;
  int width;
  int height;
  LeftUpper leftUpper;

  PictureInformation({this.image, this.width, this.height, this.leftUpper});

  PictureInformation.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    width = json['width'];
    height = json['height'];
    leftUpper = json['left_upper'] != null
        ? new LeftUpper.fromJson(json['left_upper'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['width'] = this.width;
    data['height'] = this.height;
    if (this.leftUpper != null) {
      data['left_upper'] = this.leftUpper.toJson();
    }
    return data;
  }
}

class LeftUpper {
  int x;
  int y;

  LeftUpper({this.x, this.y});

  LeftUpper.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}

class Point {
  int x;
  int y;

  Point({this.x, this.y});

  Point.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}

class Figures{
  List <List <double> > vertices;


}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> data;

  Future<Map<String, dynamic>> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/objects.json');
    print(1);
    print(48);
    Map<String, dynamic> pictures = json.decode(jsonText)["pictures"];
    pictures.forEach((key, value) {
      PictureInformation tmp = PictureInformation.fromJson(value["information"]);

      Map<String, dynamic> points = value["objects"]["points"];
      Map<String, dynamic> figures = value["objects"]["figures"];


      (points).forEach((key, value) {

      });

      (figures).forEach((key, value) {

      });


    });
    // print (data[1]["width"].toString());

    return json.decode(jsonText);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text('Beta_Light')),
        body: FutureBuilder<Map<String, dynamic>>(
            future: loadJsonData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) return PageRenderer(data: snapshot.data);
              return (Container());
            }));
  }
}
