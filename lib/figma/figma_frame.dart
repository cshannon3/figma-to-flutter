



import 'package:figma_test/figma/figma_text.dart';
import 'package:figma_test/figma/figma_vector.dart';
import 'package:figma_test/figma/positioned_wrapper.dart';
import 'package:figma_test/figma/utils/box_decoration_from_json.dart';
import 'package:figma_test/figma/utils/screen_size_info.dart';
import 'package:flutter/material.dart';

import 'figma_component_base.dart';
import 'utils/parse_color.dart';



class FigmaFrame  extends FigmaComponentBase {
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

  @override
  List<String> getImageIDs(){
    List<String> out = [];
    children?.forEach((childComponent) {
      out.addAll(childComponent.getImageIDs()); 
    });
    return out;
  }

  @override
  setImageUrls(Map<String,dynamic> idUrlsMap){
    // if(data.containsKey("transitionNodeID"))print(data);
    children?.forEach((childComponent) {
     childComponent.setImageUrls(idUrlsMap);
    });
  }

  List<Widget> toWidgets({@required ScreenSizeInfo screenSizeInfo})=>    
    [
      _getSelf(screenSizeInfo: screenSizeInfo),
      ..._getChildren(screenSizeInfo: screenSizeInfo)
  ];

  
  Widget _getSelf({@required ScreenSizeInfo screenSizeInfo}){
   
     return  positionedWrapper(
      screenSizeInfo: screenSizeInfo, 
      figmaRect: figmaRect, 
      child:  Container(
          width:double.infinity, height:double.infinity,
          decoration: FigmaStyles(data).getDecoration(parseColor(data))
        )
      );
  }
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

