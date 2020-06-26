



import 'package:figma_test/figma/figma_screen.dart';
import 'package:figma_test/figma/utils/parse_color.dart';
import 'package:figma_test/figma/utils/screen_size_info.dart';
import 'package:flutter/material.dart';

import 'figma_vector.dart';



class FigmaText {
  final Rect figmaRect;
   final Color color;
   final String type;
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final dynamic data;
  //final dynamic figmaItem;


  FigmaText( {
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
    //print(text);
   // print(fontSize);
    //print(fontSize*screenSizeInfo.scaleX);
    return
      Positioned(
          top:screenSizeInfo.relativeWindowHeight*figmaRect.top,
          height: screenSizeInfo.relativeWindowHeight*figmaRect.height,
          left: screenSizeInfo.relativeWindowWidth*figmaRect.left,
          width:screenSizeInfo.relativeWindowWidth*figmaRect.width,
        child: Container(
          child: 
          Text(
            text, 
          textAlign: textAlign,
          style: TextStyle(
            color: color,
            fontSize: fontSize*screenSizeInfo.scaleX,
          ),)
        )
      );
  }
 

}

TextAlign getTextAlign(dynamic jsonData){
  if(jsonData['type']!="TEXT")return null;
  String al= jsonData['style']['textAlignHorizontal'];
  return (al=="LEFT")?TextAlign.left:(al=="RIGHT")?TextAlign.right:(al=="CENTER")?TextAlign.center:TextAlign.left;
}



