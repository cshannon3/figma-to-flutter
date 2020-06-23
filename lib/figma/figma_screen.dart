


import 'package:figma_test/figma/figma_component.dart';
import 'package:flutter/material.dart';

class FigmaScreen{
  final ScreenSizeInfo screenSizeInfo;
  final String name;
  final dynamic data;
  List<FigmaComponent>  components=[];

  FigmaScreen({
    @required this.screenSizeInfo,
    @required this.name, 
    @required this.data,
    });
     
   FigmaScreen.fromJson(Map<String, dynamic> jsonData):
      this.screenSizeInfo = ScreenSizeInfo.fromJson(jsonData), 
      this.name=jsonData["name"], 
      this.data=jsonData;


  init(){
    data["children"].forEach((component){
      components.add(FigmaComponent.fromJson(component, screenSizeInfo)); //offsetX, offsetY
    });
  }

  Widget getScreen({@required Rect windowFrame, @required Size screenSize})=>
    
    //Positioned.fromRect( // todo some sort of auto positioning algo based on length
          //rect: windowFrame,
          //child: 
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Container(
              height: windowFrame.height,//h*scale,
              width: windowFrame.width,
              child: SingleChildScrollView(
                child: Stack(children: [
                  Container(height: screenSizeInfo.figmaScreenSize.height,),
                  ..._getWidgets(
                    screenSize:  screenSize,
                    windowFrame: windowFrame,
                    ),
                ]
                )
                ),
         // ),
      ),
          );
  


  List<Widget> _getWidgets({@required Rect windowFrame, @required Size screenSize}){
      screenSizeInfo.setCurrentPositioning(newWindowFrame: windowFrame, screenSize: screenSize );
      List<Widget> widgets = [];
      components.forEach((component) {
        widgets.addAll(component.toWidgets(screenSizeInfo: screenSizeInfo)); //
      });
      return widgets;
  }
}

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


          // left: l*w,
          // width: value.*scale,
          // height: value.fullH*scale,
          // top: 0.0,
// component['children'].forEach((c){
      //     components.add(FigmaComponent.fromJson(c, offsetX, offsetY));
      //   });

//       class FigmaScreen{
//   final double fullW;
//   final double fullH;
//   final double offsetX;
//   final double offsetY;
//   final String name;
//   final dynamic data;
//   List<FigmaComponent>  components=[];

//   FigmaScreen({
//     @required this.fullW, 
//     @required this.fullH, 
//     @required this.offsetX, 
//     @required this.offsetY,
//     @required this.name, 
//     @required this.data,
//     });
     
//    FigmaScreen.fromJson(Map<String, dynamic> jsonData):
//       this.fullW=jsonData["size"]['y'],
//       this.fullH=jsonData["size"]['x'], 
//       this.offsetX=jsonData["absoluteBoundingBox"]['x'], 
//       this.offsetY=jsonData["absoluteBoundingBox"]['y'], 
//       this.name=jsonData["name"], 
//       this.data=jsonData;

// // TODO Recursion
//   init(){
//     data["children"].forEach((component){
//       components.add(FigmaComponent.fromJson(component, offsetX, offsetY));
//     });
//   }


//   List<Widget> getWidgets(double h, double w, {double scale=0.5}){
//       List<Widget> widgets = [];
//       components.forEach((component) {
//         widgets.addAll(component.toWidgets(h, w, fullH, fullW, scale: scale));
//       });
//       return widgets;
//   }
// }
