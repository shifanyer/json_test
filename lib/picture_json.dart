import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

class Picture{

  //final Image image = Image.asset('assets/images/test_json.png');

  final Image image;
  final int width;
  final int height;
  //final Map <String, Map <String, List <double> > > objects;

  Picture({this.image, this.width, this.height/*, this.objects*/});

  factory Picture.fromJson(Map<String, dynamic> json){
    return Picture(
      image: Image.asset(json['image'] as String),
      width: json['width'] as int,
      height: json['height'] as int,
    );
  }
}