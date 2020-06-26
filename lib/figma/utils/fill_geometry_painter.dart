
// final Paint black = Paint()
//   ..color = Colors.black
//   ..strokeWidth = 1.0
//   ..style = PaintingStyle.;
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
/*
Future tests
- Bad data 
- No data 
-Wrong input type
- Scaling 
*/
class FillGeometryPainter extends CustomPainter {
  FillGeometryPainter(String path, Color color) : 
  p = parseSvgPathData(path),
  c=color;

  final Path p;
  final Color c;
  @override
  bool shouldRepaint(FillGeometryPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {

    Path newP = getClip(size);
    final Paint paint = Paint()
        ..color=c
        ..strokeWidth = 1.0
        ..style = PaintingStyle.fill;
    canvas.drawPath(
      newP, 
      paint
    );

  }

  Path getClip(Size size) {
    //parseSvgPathData comes from a package
    //Library link: https://pub.dev/packages/path_drawing (Library link)
    //parseSvgPathData returns a Path object
    //extracting path from SVG data
    final Rect pathBounds = p.getBounds();
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(size.width / pathBounds.width, size.height / pathBounds.height);
    return p.transform(matrix4.storage);// path is returned to ClipPath clipper
  }
}
