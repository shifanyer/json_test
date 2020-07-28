import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_test/z_directory/point_3D.dart';
import 'package:json_test/z_directory/start_points_for_shapes.dart';
import 'package:json_test/z_directory/way.dart';
import 'package:zflutter/zflutter.dart';

class Shapes {

  final Point3D Q = Point3D (0, 0, 0);
  final Point3D O = Point3D (0, 0, 0);



  List <ZShape> quadrilateralSides ( double a, double b ){
    List <ZShape> planes = [];
    ZShape plane = ZShape(path: [
      ZMove.only(x: Q.x, y: Q.y, z: Q.z),
      ZLine.only(x: Q.x, y: Q.y+a, z: Q.z),
      ZLine.only(x: Q.x+b, y: Q.y+a, z: Q.z),
      ZLine.only(x: Q.x+b, y: Q.y, z: Q.z),
    ], closed: true, stroke: 1, fill: true, color: Colors.blue);
    planes.add(plane);
    return planes;
  }

  List <ZShape> quadrilateralPoints ( List<Point3D> dots, /*Point3D A, Point3D B, Point3D C, Point3D D,*/ {bool filling = false,
    double scenario = 0,
    //double up = 0, double right = 0, double forward = 0, double radius = 0
    Way w,
    Point3D med,
    double axisX = 0,
    double axisY = 0,
    double axisZ = 0,
    bool rotation = false

  }){




    w = w ?? Way(up: 0, right: 0, forward: 0, radius: 0, coef: 0);

    double right = w.right;
    double forward = w.forward;
    double up = w.up;
    double radius = w.radius;

    //(scenario - 1 + w.coef) / (w.coef) ;

    double X = right * scenario - (radius - radius * cos(2 * pi * scenario));
    double Y = - up * scenario - radius * sin(2 * pi * scenario);
    double Z = forward * scenario;

    double tmpX;
    double tmpY;
    double tmpZ;


    int dotsCount = dots.length;

    for (int i = 0; i < dotsCount; i++){
       tmpX += dots[i].x;
       tmpY += dots[i].x;
       tmpZ += dots[i].x;
    }


    med = med ?? Point3D((tmpX) / dotsCount, (tmpY) / dotsCount, (tmpZ) / dotsCount);

    double medX = X + med.x;
    double medY = Y + med.y;
    double medZ = Z + med.z;

    if (rotation) {
      axisX = scenario * axisX * 2 * pi / 360;
      axisY = scenario * axisY * 2 * pi / 360;
      axisZ = scenario * axisZ * 2 * pi / 360;
    }
    else{
      axisX = axisX * 2 * pi / 360;
      axisY = axisY * 2 * pi / 360;
      axisZ = axisZ * 2 * pi / 360;
    }

    List <Point3D> dotsA = [];
    List <Point3D> dotsOA = [];
    for (int i = 0; i < dotsCount; i++){
      dotsA.add(Point3D(dots[i].x + X - medX, dots[i].y + Y - medY, dots[i].z + Z - medZ));
      dotsOA.add(Point3D(0,0,0));
    }


    // X axis turn
    for (int i = 0; i < dotsCount; i++){
      dotsOA[i] = (Point3D(
          dotsA[i].x,
          dotsA[i].y * cos(axisX) + dotsA[i].z * (sin(axisX)),
          dotsA[i].z * cos(axisX) - dotsA[i].y * sin(axisX))
      );
    }
    for (int i = 0; i < dotsCount; i++){
      dotsA[i] = dotsOA[i];
    }
/*
    OAX = (AX);
    OBX = (BX);
    OCX = (CX);
    ODX = (DX);

    OAY = (AY) * cos(axisX) + (AZ) * (sin(axisX));
    OBY = (BY) * cos(axisX) + (BZ) * (sin(axisX));
    OCY = (CY) * cos(axisX) + (CZ) * (sin(axisX));
    ODY = (DY) * cos(axisX) + (DZ) * (sin(axisX));

    OAZ = (AZ) * cos(axisX) - (AY) * sin(axisX);
    OBZ = (BZ) * cos(axisX) - (BY) * sin(axisX);
    OCZ = (CZ) * cos(axisX) - (CY) * sin(axisX);
    ODZ = (DZ) * cos(axisX) - (DY) * sin(axisX);

    AX = OAX;
    BX = OBX;
    CX = OCX;
    DX = ODX;
    AY = OAY;
    BY = OBY;
    CY = OCY;
    DY = ODY;
    AZ = OAZ;
    BZ = OBZ;
    CZ = OCZ;
    DZ = ODZ;

 */

    //Y axis turn
    for (int i = 0; i < dotsCount; i++){
      dotsOA[i] = (Point3D(
          dotsA[i].x * cos(axisY) + dotsA[i].z * sin(axisY),
          dotsA[i].y,
          dotsA[i].z * cos(axisY) - dotsA[i].x * sin(axisY))
      );
    }
    for (int i = 0; i < dotsCount; i++){
      dotsA[i] = dotsOA[i];
    }
/*
    OAX = (AX) * cos(axisY) + (AZ) * sin(axisY);
    OBX = (BX) * cos(axisY) + (BZ) * sin(axisY);
    OCX = (CX) * cos(axisY) + (CZ) * sin(axisY);
    ODX = (DX) * cos(axisY) + (DZ) * sin(axisY);

    OAY = AY;
    OBY = BY;
    OCY = CY;
    ODY = DY;

    OAZ = (AZ) * cos(axisY) - (AX) * sin(axisY);
    OBZ = (BZ) * cos(axisY) - (BX) * sin(axisY);
    OCZ = (CZ) * cos(axisY) - (CX) * sin(axisY);
    ODZ = (DZ) * cos(axisY) - (DX) * sin(axisY);

    AX = OAX;
    BX = OBX;
    CX = OCX;
    DX = ODX;
    AY = OAY;
    BY = OBY;
    CY = OCY;
    DY = ODY;
    AZ = OAZ;
    BZ = OBZ;
    CZ = OCZ;
    DZ = ODZ;

 */

    //Z axis turn
    for (int i = 0; i < dotsCount; i++){
      dotsOA[i] = (Point3D(
          dotsA[i].x * cos(axisZ) - dotsA[i].y * sin(axisZ),
          dotsA[i].y * cos(axisZ) + dotsA[i].x * sin(axisZ),
          dotsA[i].z)
      );
    }
    for (int i = 0; i < dotsCount; i++){
      dotsA[i] = dotsOA[i];
    }
/*
    OAX = (AX) * cos(axisZ) - (AY) * sin(axisZ);
    OBX = (BX) * cos(axisZ) - (BY) * sin(axisZ);
    OCX = (CX) * cos(axisZ) - (CY) * sin(axisZ);
    ODX = (DX) * cos(axisZ) - (DY) * sin(axisZ);

    OAY = (AY) * cos(axisZ) + (AX) * sin(axisZ);
    OBY = (BY) * cos(axisZ) + (BX) * sin(axisZ);
    OCY = (CY) * cos(axisZ) + (CX) * sin(axisZ);
    ODY = (DY) * cos(axisZ) + (DX) * sin(axisZ);

    OAZ = AZ;
    OBZ = BZ;
    OCZ = CZ;
    ODZ = DZ;

    AX = OAX;
    BX = OBX;
    CX = OCX;
    DX = ODX;
    AY = OAY;
    BY = OBY;
    CY = OCY;
    DY = ODY;
    AZ = OAZ;
    BZ = OBZ;
    CZ = OCZ;
    DZ = ODZ;

 */

    List <ZShape> planes = [];

    List<ZPathCommand> minipath;
    minipath.add(ZMove.only(x: dotsA[0].x + medX, y: dotsA[0].y + medY, z: dotsA[0].z + medZ));
    for (int i = 1; i < dotsCount; i++){
      minipath.add(ZLine.only( x: dotsA[i].x + medX, y: dotsA[i].y + medY, z: dotsA[i].z + medZ  ));
    }


    ZShape plane = ZShape(path: minipath,
        closed: true,
        stroke: 1,
        fill: filling,
        color: Colors.blue);
    planes.add(plane);
    return planes;
  }

  List <ZShape> parallelepipedSides( Point3D O, { double a = 10, double b = 10, double c = 10,
    double scenario = 0,
    Way w,
    //double up = 0, double right = 0, double forward = 0, double radius = 0,
    double axisX = 0, double axisY = 0, double axisZ = 0 } ){

    List <ZShape> carcasses = [];

    double right = w.right;
    double forward = w.forward;
    double up = w.up;
    double radius = w.radius;

    double X = O.x + right * scenario - (radius - radius * cos(2 * pi * scenario));
    double Y = O.y - up * scenario - radius * sin(2 * pi * scenario);
    double Z = O.z + forward * scenario;


    ZShape carcass = ZShape(path: [

      ZMove.only(x: (X), y: Y, z: Z),
      ZLine.only(x: (X), y: Y+b, z: Z),
      ZLine.only(x: (X+a), y: Y+b, z: Z),
      ZLine.only(x: (X+a), y: Y, z: Z),
      ZLine.only(x: (X), y: Y, z: Z),

      ZMove.only(x: (X), y: Y, z: Z+c),
      ZLine.only(x: (X), y: Y+b, z: Z+c),
      ZLine.only(x: (X+a), y: Y+b, z: Z+c),
      ZLine.only(x: (X+a), y: Y, z: Z+c),
      ZLine.only(x: (X), y: Y, z: Z+c),

      ZMove.only(x: (X), y: Y, z: Z+c),
      ZLine.only(x: (X), y: Y, z: Z),

      ZMove.only(x: (X), y: Y+b, z: Z+c),
      ZLine.only(x: (X), y: Y+b, z: Z),

      ZMove.only(x: (X+a), y: Y+b, z: Z+c),
      ZLine.only(x: (X+a), y: Y+b, z: Z),

      ZMove.only(x: (X+a), y: Y, z: Z+c),
      ZLine.only(x: (X+a), y: Y, z: Z),

    ], closed: false, stroke: 1, fill: false, color: Colors.blue);
    carcasses.add(carcass);
    return carcasses;
  }

//  Point3D placeOfParallelepiped ( Point3D O,
//      { double a = 10, double b = 10, double c = 10,
//        double scenario = 0,
//        Way w,
//        double axisX = 0, double axisY = 0, double axisZ = 0} ){
//
//  }

  List <ZShape> parallelepipedFull ( Point3D O, { double a = 10, double b = 10, double c = 10,
    double scenario = 0,
    //double up = 0, double right = 0, double forward = 0, double radius = 0
    Way w,
    double axisX = 0, double axisY = 0, double axisZ = 0} ){

    double right = w.right;
    double forward = w.forward;
    double up = w.up;
    double radius = w.radius;

    Point3D med = Point3D((2 * O.x + a) / 2, (2 * O.y + b) / 2, (2 * O.z + c) / 2);

    double X = O.x;
    double Y = O.y;
    double Z = O.z;



    List <ZShape> parallelepiped = [];

    Point3D A1 = Point3D(X, Y, Z);;
    Point3D B1 = Point3D(X, Y+b, Z);
    Point3D C1 = Point3D(X+a, Y+b, Z);
    Point3D D1 = Point3D(X+a, Y, Z);

    Point3D A2 = Point3D(X, Y, Z+c);
    Point3D B2 = Point3D(X, Y+b, Z+c);
    Point3D C2 = Point3D(X+a, Y+b, Z+c);
    Point3D D2 = Point3D(X+a, Y, Z+c);

//
//
//    parallelepiped.addAll(quadrilateralPoints( A1, B1, C1, D1, filling: true,scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true ));
//    parallelepiped.addAll(quadrilateralPoints( A1, B1, B2, A2, filling: true,scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true ));
//    parallelepiped.addAll(quadrilateralPoints( A2, B2, C2, D2, filling: true,scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true ));
//    parallelepiped.addAll(quadrilateralPoints( C2, D2, D1, C1, filling: true,scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true ));
//    parallelepiped.addAll(quadrilateralPoints( C2, B2, B1, C1, filling: true,scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true ));
//    parallelepiped.addAll(quadrilateralPoints( A2, D2, D1, A1, filling: true,scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true ));

    return ( parallelepiped );
  }

  List <ZShape> tetrahedronFull ( Point3D O,
      { double a = 10,
        double scenario = 0,
        Way w,
        double axisX = 0, double axisY = 0, double axisZ = 0} ){

    double right = w.right;
    double forward = w.forward;
    double up = w.up;
    double radius = w.radius;

    Point3D med = Point3D(O.x, O.y - a * 2 * sqrt(2 / 3) / 3, O.z);

    double X = O.x;
    double Y = O.y;
    double Z = O.z;



    List <ZShape> tetrahedron = [];

    Point3D A1 = Point3D(X, Y, Z);
    Point3D B1 = Point3D(X - a / 2, Y - a * sqrt(2 / 3), Z + a * sqrt(3) / 6);
    Point3D C1 = Point3D(X + a / 2, Y - a * sqrt(2 / 3), Z + a * sqrt(3) / 6);
    Point3D D1 = Point3D(X        , Y - a * sqrt(2 / 3), Z - a * sqrt(3) / 3);
//
//    tetrahedron.addAll(quadrilateralPoints( A1, B1, C1, A1, filling: false,scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true ));
//    tetrahedron.addAll(quadrilateralPoints( A1, B1, D1, A1, filling: false,scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true ));
//    tetrahedron.addAll(quadrilateralPoints( A1, C1, D1, A1, filling: false,scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true ));
//    tetrahedron.addAll(quadrilateralPoints( B1, D1, C1, B1, filling: false,scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true ));

    return ( tetrahedron );
  }

}
