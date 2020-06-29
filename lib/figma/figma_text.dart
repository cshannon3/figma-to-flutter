




import 'package:figma_test/figma/figma_component_base.dart';
import 'package:figma_test/figma/utils/parse_color.dart';
import 'package:figma_test/figma/utils/screen_size_info.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
 
  final rand = math.Random();


class FigmaText extends FigmaComponentBase {
  final Rect figmaRect;
   final Color color;
   final String type;
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final dynamic data;
  //final dynamic figmaItem;


  FigmaText({
    @required this.figmaRect, 
    @required this.color,
     @required this.type,
    this.text,
    this.fontSize,
    this.textAlign,
    this.data
    
    });

  FigmaText.fromJson(Map<String, dynamic> jsonData, ScreenSizeInfo screenSizeInfo): //
      this.figmaRect = screenSizeInfo.toFigmaRect(absoluteBoundingBox: jsonData["absoluteBoundingBox"]),
      this.type = jsonData['type'],
      this.color= parseColor(jsonData),
      this.data= jsonData,
      this.text= jsonData['type']=="TEXT"?jsonData['characters']:null,
      this.fontSize = jsonData['type']=="TEXT"?jsonData['style']['fontSize']:null,
      this.textAlign = getTextAlign(jsonData);
 
  List<Widget> toWidgets({@required ScreenSizeInfo screenSizeInfo})=>    
    [
      _getSelf(screenSizeInfo: screenSizeInfo), 
  ];


  Widget _getSelf({@required ScreenSizeInfo screenSizeInfo}){
    return 
      Positioned(
          top:screenSizeInfo.relativeWindowHeight*figmaRect.top,
         // height: screenSizeInfo.windowFrame.height- screenSizeInfo.relativeWindowHeight*figmaRect.top,
        // screenSizeInfo.relativeWindowHeight*figmaRect.height,
          left: screenSizeInfo.relativeWindowWidth*figmaRect.left,
        child: SizedBox(
          height:screenSizeInfo.relativeWindowHeight*figmaRect.height,
          width:screenSizeInfo.relativeWindowWidth*figmaRect.width,
          child: 
          //CustomPaint(  painter: FigmaTextPainter(text, fontSize, color),),
          Text(
            text, 
          textAlign: textAlign,
          style: TextStyle(
            color: color,
            fontSize: autoSize(
              quoteLength: text.length, 
              parentArea: (screenSizeInfo.relativeWindowHeight*figmaRect.height*screenSizeInfo.relativeWindowWidth*figmaRect.width).toInt()
            ),
          ),
          ),
        
        )
      );
  }
 

}


  double autoSize({@required int quoteLength, @required int parentArea}) {
    assert(quoteLength != null, "`quoteLength` may not be null");
    assert(parentArea != null, "`parentArea` may not be null");
    final areaOfLetter = parentArea / quoteLength;
    final pixelOfLetter = math.sqrt(areaOfLetter);
    final pixelOfLetterP = pixelOfLetter - (pixelOfLetter * 3) / 100;
    return pixelOfLetterP;
  }

TextAlign getTextAlign(dynamic jsonData){
  if(jsonData['type']!="TEXT")return null;
  String al= jsonData['style']['textAlignHorizontal'];
  return (al=="LEFT")?TextAlign.left:(al=="RIGHT")?TextAlign.right:(al=="CENTER")?TextAlign.center:TextAlign.left;
}



    
    // var s= data.containsKey("constraints")?data["constraints"]:{};
    // print(s);
    // print(data["name"]);



        // width:screenSizeInfo.relativeWindowWidth*figmaRect.width,
          
         // screenSizeInfo.windowFrame.width-screenSizeInfo.relativeWindowWidth*figmaRect.left,
        //  *figmaRect.width,
       

// class FigmaTextPainter extends CustomPainter {
//   final String text;
//   double fontSize;
//   Color color;
  
//   FigmaTextPainter(this.text, this.fontSize, this.color);
  
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Backgroud to expose where the canvas is
//   //canvas.drawRect(Offset(0, 0) & size, Paint()..color = Colors.red[100]);

//     // Since text is overflowing, you have two options: cliping before drawing text or/and defining max lines.    
//     canvas.clipRect(Offset(0, 0) & size);
    
//     final TextStyle style = TextStyle(
//       color: color,
//      // decorationThickness: 0.25,
//     );
  
//          TextPainter textPainter = TextPainter(
//           text: TextSpan(text: text, style: style), // TextSpan could be whole TextSpans tree :)
//           textAlign: TextAlign.left,
//           //maxLines: 25, // In both TextPainter and Paragraph there is no option to define max height, but there is `maxLines` 
//           textDirection: TextDirection.ltr // It is necessary for some weird reason... IMO should be LTR for default since well-known international languages (english, esperanto) are written left to right.
//         )
//           ..layout(maxWidth: size.width, minWidth: size.width); // TextPainter doesn't need to have specified width (would use infinity if not defined). 
//         // BTW: using the TextPainter you can check size the text take to be rendered (without `paint`ing it).

//         print("HEIGHT 2");
//         print(fontSize);
//         print(size.height);
//         print( textPainter.height);
//         //textPainter.setPlaceholderDimensions()
//         //paint(canvas, const Offset(0.0, 0.0));
      
    
   
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true; // Just for example, in real environment should be implemented!
//   }
// }


//     //print(text);
//    // print(fontSize);
//     //print(fontSize*screenSizeInfo.scaleX);
//  //final total = DateTime.now().difference(start100).inMicroseconds;
//    // print("Using ${useTextPainter ? 'TextPainter' : 'Paragraph'}: total $total microseconds for rendering 100 times");

//     // You definitely should check out https://api.flutter.dev/flutter/dart-ui/Canvas-class.html and related

//     //     TextSpan span = new TextSpan(style: new TextStyle(color: Colors.blue[800]), text: name);
// // TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
// //tp.layout();
// //tp.paint(canvas, new Offset(5.0, 5.0));


//     //    print("HEIGHT 1");
//     //     print(size.height);
//     //     print( textPainter.height);
//     //     while(textPainter.height>size.height && fontSize>12.0){
//     //       fontSize-=2.0;
//     //       textPainter=TextPainter(
//     //       text: TextSpan(text: text, 
//     //       style:  TextStyle(
//     //            fontSize: fontSize,
//     //            color: color
//     //       )), // TextSpan could be whole TextSpans tree :)
//     //       textAlign: TextAlign.left,
//     //       //maxLines: 25, // In both TextPainter and Paragraph there is no option to define max height, but there is `maxLines` 
//     //       textDirection: TextDirection.ltr // It is necessary for some weird reason... IMO should be LTR for default since well-known international languages (english, esperanto) are written left to right.
//     //     )
//     //       ..layout(maxWidth: size.width );
         
//     // final pixelOfLetter = math.sqrt(areaOfLetter);
//     // final pixelOfLetterP = pixelOfLetter - (pixelOfLetter * AREA_LOST_PERCENT) / 100;
//     // return pixelOfLetterP;
//     //       // .text= TextSpan(
//     //       //   text: text, 
//     //       //   style: TextStyle(
//     //       //     fontSize: fontSize,
//     //       //     color: color
//     //       // ));
//     //     }