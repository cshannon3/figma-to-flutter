


import 'dart:typed_data';

import 'package:figma_test/figma/figma_component_base.dart';
import 'package:figma_test/figma/figma_screen.dart';
import 'package:figma_test/figma/utils/box_decoration_from_json.dart';
import 'package:figma_test/figma/utils/checks.dart';
import 'package:figma_test/figma/utils/parse_color.dart';
import 'package:figma_test/figma/utils/screen_size_info.dart';
import 'package:flutter/material.dart';

import 'utils/fill_geometry_painter.dart';

class FigmaVector extends FigmaComponentBase  {
  final Rect figmaRect;
 // final Color color;
  final String type;
  String imageUrl;
  final Map data;
  final String id;
  //final BoxDecoration decoration;


  FigmaVector( {
    @required this.figmaRect, 
     @required this.type,
    //this.imageUrl,
    this.id,
    this.data
    });

  FigmaVector.fromJson(Map<String, dynamic> jsonData, ScreenSizeInfo screenSizeInfo): //
      this.figmaRect = screenSizeInfo.toFigmaRect(absoluteBoundingBox: jsonData["absoluteBoundingBox"]),
      this.id= jsonData["id"],
      this.type = jsonData['type'],
      this.data=jsonData;
      //this.imageUrl = jsonData["name"].contains("image")?  jsonData["name"].substring(jsonData["name"].indexOf("http://")):null;
    

  List<Widget> toWidgets({@required ScreenSizeInfo screenSizeInfo})=>    
    [
      _getSelf(screenSizeInfo: screenSizeInfo),
  ];
  @override
  List<String> getImageIDs(){
    
    if (isImage(data))return [id];
    return [];
  }

  @override
  setImageUrls(Map<String,dynamic> idUrlsMap){

    if(idUrlsMap.containsKey(id)){
      
      imageUrl= idUrlsMap[id];
      //print(imageUrl);
    }
    
  }
  Widget _getSelf({@required ScreenSizeInfo screenSizeInfo})=>
  
      Positioned(
          top:screenSizeInfo.relativeWindowHeight*figmaRect.top,
          height: screenSizeInfo.relativeWindowHeight*figmaRect.height,
          left: screenSizeInfo.relativeWindowWidth*figmaRect.left,
          width:screenSizeInfo.relativeWindowWidth*figmaRect.width,
        child: Container(
          child: 
        (imageUrl!=null)?
          Image.network(imageUrl, fit: BoxFit.cover,)
          :Container(
            width:double.infinity, height:double.infinity,
            decoration: FigmaStyles(data).getDecoration((!data.containsKey('fillGeometry')||data['fillGeometry'].length==0)?parseColor(data):null),
            child: (!data.containsKey('fillGeometry')||data['fillGeometry'].length==0)?null:
            CustomPaint(
              size: Size(
                figmaRect.width,
                figmaRect.height,
              ),
              painter: FillGeometryPainter(data['fillGeometry'][0]['path'], parseColor(data))
            )
          )
        )
      );
}



// BoxDecoration(
//               color://parseColor(data),
//               (!data.containsKey('fillGeometry')||data['fillGeometry'].length==0)?parseColor(data):null,
//               border:(data["strokes"].length>0)?Border.all(
//                 color: parseColor(data["strokes"][0]),
//                 width: data["strokeWeight"].toDouble(),
//               ):null,
//               borderRadius:data.containsKey("rectangleCornerRadii") ?BorderRadius.only(
//                 topLeft: Radius.circular(data["rectangleCornerRadii"][0]),
//                 topRight: Radius.circular(data["rectangleCornerRadii"][1]),
//                 bottomLeft: Radius.circular(data["rectangleCornerRadii"][2]),
//                 bottomRight: Radius.circular(data["rectangleCornerRadii"][3]),
//               ):null,
//               boxShadow: (!data.containsKey("effects") || data["effects"].length==0)?[]:
//              data["effects"].map<BoxShadow>((effect)=>
//                 BoxShadow(
//                       color:parseColor(effect),
//                       offset:Offset(effect['offset']['x'], effect['offset']['y']),
//                       blurRadius:effect['radius'].toDouble(),
//                       spreadRadius:effect['radius'].toDouble(),
//                     )
//                 ).toList(),
//               gradient: null,
//               backgroundBlendMode: null,
//             )