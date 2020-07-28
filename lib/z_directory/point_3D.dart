import 'dart:math';

class Point3D {
  final double x;
  final double y;
  final double z;

  Point3D([this.x, this.y, this.z]);

  double qA2(Point3D A, Point3D I) {
    double result = (A.x - I.x) * (A.x - I.x) +
        (A.y - I.y) * (A.y - I.y) +
        (A.z - I.z) * (A.z - I.z);
    return result;
  }

  Point3D strokePoint(Point3D A, Point3D I) {
    double qa2 = sqrt(qA2(A, I));
    double strokeAX = A.x + ((A.x - I.x) * 300 * (200 / qa2)) / qa2;
    double strokeAY = A.y + ((A.y - I.y) * 300 * (200 / qa2)) / qa2;
    double strokeAZ = A.z + ((A.z - I.z) * 300 * (200 / qa2)) / qa2;
    return Point3D(strokeAX, strokeAY, strokeAZ);
  }
}
