import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:json_test/z_directory/point_3D.dart';
import 'package:json_test/z_directory/standart_shapes.dart';
import 'package:json_test/z_directory/start_points_for_shapes.dart';
import 'package:json_test/z_directory/way.dart';
import 'dart:convert';

import 'package:zflutter/zflutter.dart';

class PageRenderer extends StatefulWidget {
  final Map<String, dynamic> data;

  const PageRenderer({Key key, @required this.data}) : super(key: key);

  @override
  _PageRendererState createState() => _PageRendererState();
}

double lightRadiusValue = 300.0;
//List<double> translateValues = [0.0, 0.0];

class _PageRendererState extends State<PageRenderer>
    with SingleTickerProviderStateMixin {
  List<List<Point3D>> circle = [];
  List<List<Point3D>> circleStroke = [];
  List<bool> toggleOptions = [false, false];
  List shapeList = [];
  List<fourPoints> corners = [];

//  print ('$ {parsedJson.runtimeType}: $ parsedJson');

  Point3D A;
  Point3D B;
  Point3D C;
  Point3D D;
  Point3D strokeA;
  Point3D strokeB;
  Point3D strokeC;
  Point3D strokeD;
  Point3D I;
  Point3D I22;
  Point3D ps;
  Point3D ps1;
  Point3D ps2;
  Point3D center;
  Point3D center1;
  Point3D center2;
  Point3D A2;
  double radius;
  Way way1;
  List<Way> choreographer = [];
  List<Point3D> deleteThisShit;

  List<List<ZShape>> objects = [];
  Map scores;

  double zoomValue = 0.5;
  double zoomSliderValue = 0.0;
  double lightRadiusSliderValue = 0.0;

  List<ZShape> temporaryList = [];

  @override
  void initState() {
    // Creating base Points
    plane();
    // Adding Objects on screen
    initShape();

    super.initState();
  }

//    temporaryList.add(Shapes().quadrilateralPoints(A, B, C, D, scenario: 0.3));
  //shapeList.add( Shapes().quadrilateralSides(10, 20) );
  plane() async {
    var data = widget.data;
//    print (data["pictures"][0]["objects"]["figures"][0]["windows"][0][0]["x"].toString());
//    print(300);

    List<Point3D> input;

    for (int i = 0; i < 4; i++) {
      A = Point3D(
          data["pictures"][0]["objects"]["figures"][0]["windows"][i][0]["x"] *
                  1.0 -
              150,
          data["pictures"][0]["objects"]["figures"][0]["windows"][i][0]["y"] *
                  1.0 -
              200,
          5);
      B = Point3D(
          data["pictures"][0]["objects"]["figures"][0]["windows"][i][1]["x"] *
                  1.0 -
              150,
          data["pictures"][0]["objects"]["figures"][0]["windows"][i][1]["y"] *
                  1.0 -
              200,
          5);
      C = Point3D(
          data["pictures"][0]["objects"]["figures"][0]["windows"][i][2]["x"] *
                  1.0 -
              150,
          data["pictures"][0]["objects"]["figures"][0]["windows"][i][2]["y"] *
                  1.0 -
              200,
          5);
      D = Point3D(
          data["pictures"][0]["objects"]["figures"][0]["windows"][i][3]["x"] *
                  1.0 -
              150,
          data["pictures"][0]["objects"]["figures"][0]["windows"][i][3]["y"] *
                  1.0 -
              200,
          5);
      corners.add(fourPoints(A, B, C, D));
    }

    A = Point3D(
        data["pictures"][0]["objects"]["figures"][1]["triangles"][0][0]["x"] *
                1.0 -
            150,
        data["pictures"][0]["objects"]["figures"][1]["triangles"][0][0]["y"] *
                1.0 -
            200,
        5);
    B = Point3D(
        data["pictures"][0]["objects"]["figures"][1]["triangles"][0][1]["x"] *
                1.0 -
            150,
        data["pictures"][0]["objects"]["figures"][1]["triangles"][0][1]["y"] *
                1.0 -
            200,
        5);
    C = Point3D(
        data["pictures"][0]["objects"]["figures"][1]["triangles"][0][2]["x"] *
                1.0 -
            150,
        data["pictures"][0]["objects"]["figures"][1]["triangles"][0][2]["y"] *
                1.0 -
            200,
        5);
    //D = Point3D(data["pictures"][0]["objects"]["figures"][0]["triangles"][0][3]["x"] * 1.0, data["pictures"][0]["objects"]["figures"][0]["triangles"][0][3]["y"] * 1.0, 0);

    deleteThisShit.add(A);
    deleteThisShit.add(B);
    deleteThisShit.add(C);
    //corners.add();


//    I = Point3D(0, 0, -100);
//    I22 = Point3D(0, 0, -200);
//    A2 = Point3D(50, 50, 50);
//
//    radius = 40;
//    ps = Point3D(40, 0, 0);
//    center = Point3D(0, 0, 0);
//    ps1 = Point3D(-50, -40, 0);
//    ps2 = Point3D(50, 40, 0);
//    center1 = Point3D(-50, 0, 0);
//    center2 = Point3D(130, 0, 0);

    //corners.add(fourPoints(ps, center, ps1, ps2));

    choreographer
        .add(Way(up: 300, right: -100, forward: 0, radius: 10, coef: 1));
    choreographer.add(Way(up: 250, right: 200, forward: 0, radius: 0, coef: 1));
    choreographer
        .add(Way(up: -150, right: 300, forward: 0, radius: 10, coef: 1));
    choreographer
        .add(Way(up: -300, right: -200, forward: 0, radius: 0, coef: 1));
    choreographer.add(Way(up: 0, right: 0, forward: 0, radius: 0, coef: 1));
    choreographer.add(Way(up: 0, right: 0, forward: 0, radius: 0, coef: 1));

    //objects.add(Shapes().quadrilateralPoints(A, B, C, D, scenario: 0, up: choreographer[0].up ));

    /*

    temporaryList.addAll(Shapes().parallelepipedFull(A,
        a: 90,
        b: 30,
        c: 60,
        scenario: 0.3,
        up: 90,
        right: 0,
        forward: 80,
        radius: 60));

 */
  }

  initShape() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: Colors.cyan,
          child: Stack(children: [
            ZDragDetector(builder: (context, controller) {
              return ZIllustration(zoom: 1.9, children: [
                ZPositioned(
                    rotate: ZVector.only(
                        x: controller.rotate.x, y: controller.rotate.y),
                    child: ZPositioned.scale(
                      x: 0.5,
                      y: 0.5,
                      z: 0.5,
                      child: ZGroup(children: [
                        ZPositioned.translate(
                          z: -100,
                          child: ZToBoxAdapter(
                              width: 300,
                              height: 400,
                              child: Image.asset(
                                  widget.data["pictures"][0]["image"])),
                        ),
                        ZToBoxAdapter(
                          child: Container(
                            color: Colors.amber.withOpacity(0.5),
                          ),
                          width: 300,
                          height: 400,
                        ),
                        ...shapeList
                      ]),
                    ))
              ]);
            }),
            SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: ZDragDetector(builder: (context, controller) {
                  return ZIllustration(zoom: 1.9, children: [
                    ZPositioned(
                        rotate: ZVector.only(
                            x: controller.rotate.x, y: controller.rotate.y),
                        child: ZGroup(children: [
                          for (dynamic shape in temporaryList) shape
                        ]))
                  ]);
                })),
            Positioned(
                bottom: 20,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(children: [
                          SliderTheme(
                              data: SliderThemeData(trackHeight: 6),
                              child: Slider(
                                  activeColor: Colors.greenAccent,
                                  inactiveColor: Colors.lightGreenAccent,
                                  value: zoomSliderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      shapeList.clear();

                                      way1 = choreographer[0];

                                      shapeList.addAll(Shapes()
                                          .quadrilateralPoints(deleteThisShit));
                                      //print(scores["width"]);
/*
                                      shapeList.addAll(Shapes()
                                          .quadrilateralPoints(corners[0]));
                                      shapeList.addAll(Shapes()
                                          .quadrilateralPoints(corners[1]));
                                      shapeList.addAll(Shapes()
                                          .quadrilateralPoints(corners[2]));
                                      shapeList.addAll(Shapes()
                                          .quadrilateralPoints(corners[3]));
                                      shapeList.addAll(Shapes()
                                          .quadrilateralPoints(corners[4]));

 */
//                                      shapeList.addAll(Shapes().tetrahedronFull(I,
//                                        a: 50,
//                                        scenario: value,
//                                        w: choreographer[4],
//                                        //axisX: 90,
//                                        //axisY: 40,
//                                        axisY: 1200,
//                                      ));
//
//
//                                      shapeList.addAll(Shapes().tetrahedronFull(I,
//                                        a: 50,
//                                        scenario: value,
//                                        w: choreographer[4],
//                                        //axisX: 90,
//                                        //axisY: 40,
//                                        axisX: 1200,
//                                      ));

                                      //shapeList.addAll(Shapes().quadrilateralPoints(A, B, C, D, scenario: value, w: choreographer[0].up ));

                                      //shapeList.add( Shapes().quadrilateralSides(10, 20) );
                                      //shapeList.add( Shapes().parallelepipedSides(A, a: 40, b: 40, c: 10, scenario: value, up: 0, right: 0, forward: 0, radius: 40) );
                                      zoomSliderValue = value;
                                      zoomValue = 0.5 + value * 1.5;
                                    });
                                  })),
                          SizedBox(height: 12),
                        ]))))
          ]),
        ));
  }
}
