



import 'package:figma_test/figma/figma_screen.dart';
import 'package:figma_test/figma/figma_text.dart';
import 'package:figma_test/figma/figma_vector.dart';
import 'package:flutter/material.dart';



class FigmaFrame {
  final Rect figmaRect;
  final List children;
  final String type;
  final Map data;

  FigmaFrame( {
    @required this.figmaRect, 
    this.children,
    this.type,
    this.data
    });

  FigmaFrame.fromJson(Map<String, dynamic> jsonData, ScreenSizeInfo screenSizeInfo): //
      this.figmaRect = screenSizeInfo.toFigmaRect(absoluteBoundingBox: jsonData["absoluteBoundingBox"]),
      this.type = jsonData["type"],
      this.data=jsonData,
      this.children = jsonData.containsKey("children")?jsonData["children"]
        .map((child){
          String type = child["type"];
          List<String> frames = ["CANVAS", "FRAME","COMPONENT","INSTANCE"];
          List<String> vectors = ["RECTANGLE", "VECTOR", "STAR","LINE","ELLIPSE", "REGULAR_ POLYGON","SLICE"];
          if(type =="TEXT"){
            return FigmaText.fromJson(child, screenSizeInfo);//todo
          }else if (frames.contains(type)){
            return FigmaFrame.fromJson(child, screenSizeInfo);
          }else if (vectors.contains(type)){
           return FigmaVector.fromJson(child, screenSizeInfo);
          }
          return FigmaVector.fromJson(child, screenSizeInfo);
              
       }
        ).toList():[];

  List<Widget> toWidgets({@required ScreenSizeInfo screenSizeInfo})=>    
    [
      _getSelf(screenSizeInfo: screenSizeInfo),
      ..._getChildren(screenSizeInfo: screenSizeInfo)
  ];
  Widget _getSelf({@required ScreenSizeInfo screenSizeInfo})=>
   
      Positioned(
          top:screenSizeInfo.relativeWindowHeight*figmaRect.top,
          height: screenSizeInfo.relativeWindowHeight*figmaRect.height,
          left: screenSizeInfo.relativeWindowWidth*figmaRect.left,
          width:screenSizeInfo.relativeWindowWidth*figmaRect.width,
        child: Container(
          child: Container(
            width:double.infinity, height:double.infinity,
            decoration: BoxDecoration(
              color:parseColor(data),
              border:(data["strokes"].length>0)?Border.all(
                color: parseColor(data["strokes"][0]),
                width: data["strokeWeight"].toDouble(),
              ):null,
              borderRadius:data.containsKey("rectangleCornerRadii") ?BorderRadius.only(
                topLeft: Radius.circular(data["rectangleCornerRadii"][0]),
                topRight: Radius.circular(data["rectangleCornerRadii"][1]),
                bottomLeft: Radius.circular(data["rectangleCornerRadii"][2]),
                bottomRight: Radius.circular(data["rectangleCornerRadii"][3]),
              ):null,
              boxShadow: (!data.containsKey("effects") || data["effects"].length==0)?[]:
             data["effects"].map<BoxShadow>((effect)=>
                BoxShadow(
                      color:parseColor(effect),
                      offset:Offset(effect['offset']['x'], effect['offset']['y']),
                      blurRadius:effect['radius'].toDouble(),
                      //spreadRadius:,
                    )
                ).toList(),
              gradient: null,
              backgroundBlendMode: null,
            ),
          )
        )
      );

  List<Widget> _getChildren({@required ScreenSizeInfo screenSizeInfo}){
    List<Widget> childrenWidgets = [];
    children?.forEach((childComponent) {
      childrenWidgets.addAll(
        childComponent.toWidgets(screenSizeInfo: screenSizeInfo)
      ); 
    });
    return childrenWidgets;
  }

}
