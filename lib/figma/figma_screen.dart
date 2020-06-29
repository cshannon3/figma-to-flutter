
import 'package:figma_test/figma/figma_frame.dart';
import 'package:figma_test/figma/figma_text.dart';
import 'package:figma_test/figma/figma_vector.dart';
import 'package:figma_test/figma/utils/screen_size_info.dart';
import 'package:flutter/material.dart';

class FigmaScreen{
  final ScreenSizeInfo screenSizeInfo;
  final String name;
  final dynamic data;
  final String id;
  List components=[];

  FigmaScreen({
    @required this.screenSizeInfo,
    @required this.name, 
    @required this.data,
    @required this.id,
    
    });
     
   FigmaScreen.fromJson(Map<String, dynamic> jsonData):
      this.screenSizeInfo = ScreenSizeInfo.fromJson(jsonData), 
      this.name=jsonData["name"], 
      this.id = jsonData["id"],
      this.data=jsonData;


  init(){
    components=[];
    data["children"].forEach((component){
      String type = component["type"];
      // Choice 1
      List<String> frames = ["CANVAS", "FRAME","COMPONENT","INSTANCE"];
      List<String> vectors = ["RECTANGLE", "VECTOR", "STAR","LINE","ELLIPSE", "REGULAR_ POLYGON","SLICE"];
    
      if(type =="TEXT"){
        components.add(FigmaText.fromJson(component, screenSizeInfo));
      }else if (frames.contains(type)){
        components.add(FigmaFrame.fromJson(component, screenSizeInfo));
      }else if (vectors.contains(type)){
        components.add(FigmaVector.fromJson(component, screenSizeInfo));
      }
    });
  }

  Widget getScreen({@required Rect windowFrame, @required Size screenSize})=>
        
              SingleChildScrollView(
                child: Stack(children: [
                  Container(height: screenSizeInfo.figmaScreenSize.height,),
                  ..._getWidgets(
                    screenSize:  screenSize,
                    windowFrame: windowFrame,
                    ),
                ])
          );
  
  List<String> getImageIDs(){
    List<String> out=[];
    components.forEach((component) {
      out.addAll(component.getImageIDs());
    });
    return out;
  }

  setImageUrls(Map<String,dynamic> idUrlsMap){
    components.forEach((childComponent) {
     childComponent.setImageUrls(idUrlsMap);
    });
  }

  List<Widget> _getWidgets({@required Rect windowFrame, @required Size screenSize}){
      screenSizeInfo.setCurrentPositioning(newWindowFrame: windowFrame, screenSize: screenSize );
      List<Widget> widgets = [];
      components.forEach((component) {
        widgets.addAll(component.toWidgets(screenSizeInfo: screenSizeInfo)); //
      });
      return widgets;
  }
}














    //Positioned.fromRect( // todo some sort of auto positioning algo based on length
          //rect: windowFrame,
          //child: 
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
