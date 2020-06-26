
/*
https://github.com/dnfield/dart_path_parsing/blob/master/example/main.dart
1. Add fills and fillgeometries
2. Convert to
*/
import 'package:flutter/material.dart';


import 'dart:ui';
import 'package:path_drawing/path_drawing.dart';


class SVGWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: PathTestPainter(pat));
  }
}




const String pat = 
  '''
  M40 0
  C17.92 0 0 17.92 0 40
  C0 62.08 17.92 80 40 80
  C62.08 80 80 62.08 80 40
  C80 17.92 62.08 0 40 0Z
  M60 44
  L44 44
  L44 60
  L36 60
  L36 44
  L20 44
  L20 36
  L36 36
  L36 20
  L44 20
  L44 36
  L60 36
  L60 44Z
  '''
;


final Paint black = Paint()
  ..color = Colors.black
  ..strokeWidth = 1.0
  ..style = PaintingStyle.stroke;
class PathTestPainter extends CustomPainter {
  PathTestPainter(String path) : p = parseSvgPathData(path);

  final Path p;

  @override
  bool shouldRepaint(PathTestPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(p, black);
  }
}

// class TrimPathPainter extends CustomPainter {
//   TrimPathPainter(this.percent, this.origin);

//   final double percent;
//   final PathTrimOrigin origin;

//   final Path p = Path()
//     ..moveTo(10.0, 10.0)
//     ..lineTo(100.0, 100.0)
//     ..quadraticBezierTo(125.0, 20.0, 200.0, 100.0);

//   @override
//   bool shouldRepaint(TrimPathPainter oldDelegate) =>
//       oldDelegate.percent != percent;

//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawPath(trimPath(p, percent, origin: origin), black);
//   }
// }

// class DashPathPainter extends CustomPainter {
//   final Path p = Path()
//     ..moveTo(10.0, 10.0)
//     ..lineTo(100.0, 100.0)
//     ..quadraticBezierTo(125.0, 20.0, 200.0, 100.0)
//     ..addRect(Rect.fromLTWH(0.0, 0.0, 50.0, 50.0));

//   @override
//   bool shouldRepaint(DashPathPainter oldDelegate) => true;

//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawPath(
//         dashPath(
//           p,
//           dashArray: CircularIntervalList<double>(
//             <double>[5.0, 2.5],
//           ),
//         ),
//         black);
//   }
// }



// class PathPrinter extends PathProxy {
//   @override
//   void close() {
//     print('Path.close();');
//   }

//   @override
//   void cubicTo(
//       double x1, double y1, double x2, double y2, double x3, double y3) {
//     print('Path.cubicTo($x1, $y1, $x2, $y2, $x3, $y3);');
//   }

//   @override
//   void lineTo(double x, double y) {
//     print('Path.lineTo($x, $y);');
//   }

//   @override
//   void moveTo(double x, double y) {
//     print('Path.moveTo($x, $y);');
//   }
// }

// void main() {
//   const String pathData =
//       'M22.1595 3.80852C19.6789 1.35254 16.3807 -4.80966e-07 12.8727 -4.80966e-07C9.36452 -4.80966e-07 6.06642 1.35254 3.58579 3.80852C1.77297 5.60333 0.53896 7.8599 0.0171889 10.3343C-0.0738999 10.7666 0.206109 11.1901 0.64265 11.2803C1.07908 11.3706 1.50711 11.0934 1.5982 10.661C2.05552 8.49195 3.13775 6.51338 4.72783 4.9391C9.21893 0.492838 16.5262 0.492728 21.0173 4.9391C25.5082 9.38548 25.5082 16.6202 21.0173 21.0667C16.5265 25.5132 9.21893 25.5133 4.72805 21.0669C3.17644 19.5307 2.10538 17.6035 1.63081 15.4937C1.53386 15.0627 1.10252 14.7908 0.66697 14.887C0.231645 14.983 -0.0427272 15.4103 0.0542205 15.8413C0.595668 18.2481 1.81686 20.4461 3.5859 22.1976C6.14623 24.7325 9.50955 26 12.8727 26C16.236 26 19.5991 24.7326 22.1595 22.1976C27.2802 17.1277 27.2802 8.87841 22.1595 3.80852Z';

//   writeSvgPathDataToPath(pathData, new PathPrinter());
// }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
         
//         ),
//         body: Stack(
//               children: <Widget>[
//                 CustomPaint(painter: PathTestPainter(pat)),
//                 GestureDetector(
//                   onTap: null,
//                 ),
//               ],
            
          
//         ),
    
//     );
//   }
// }