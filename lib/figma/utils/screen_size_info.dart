
import 'package:flutter/material.dart';

class ScreenSizeInfo{
  final Size figmaScreenSize;
  final double figmaOffsetX;
  final double figmaOffsetY;
  Rect windowFrame;
  double relativeWindowWidth;
  double relativeWindowHeight; 
  double scaleY=1.0;
  double scaleX=1.0;
  bool relative=false;

  ScreenSizeInfo(this.figmaScreenSize, this.figmaOffsetX, this.figmaOffsetY);
  ScreenSizeInfo.fromJson(var jsonData):
    this.figmaScreenSize= Size(jsonData["absoluteBoundingBox"]['width'], jsonData["absoluteBoundingBox"]['height']), 
    this.figmaOffsetX=jsonData["absoluteBoundingBox"]['x'], 
    this.figmaOffsetY=jsonData["absoluteBoundingBox"]['y'];

  setCurrentPositioning({@required Rect newWindowFrame, @required Size screenSize}){
    windowFrame=newWindowFrame;
    relativeWindowWidth = windowFrame.width/figmaScreenSize.width;
    relativeWindowHeight = windowFrame.height/figmaScreenSize.height;
    scaleX = windowFrame.width/screenSize.width;
    scaleY = windowFrame.height/screenSize.height;
  }
 
  Rect toFigmaRect({@required Map<String, dynamic> absoluteBoundingBox})
        =>Rect.fromLTWH(
              absoluteBoundingBox['x']-figmaOffsetX, 
              absoluteBoundingBox['y']-figmaOffsetY, 
              absoluteBoundingBox['width'], 
              absoluteBoundingBox['height']
            );
}



