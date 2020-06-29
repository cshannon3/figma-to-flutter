


import 'package:figma_test/figma/figma_component_base.dart';
import 'package:figma_test/figma/positioned_wrapper.dart';
import 'package:figma_test/figma/utils/box_decoration_from_json.dart';
import 'package:figma_test/figma/utils/checks.dart';
import 'package:figma_test/figma/utils/parse_color.dart';
import 'package:figma_test/figma/utils/screen_size_info.dart';
import 'package:flutter/material.dart';

import 'utils/fill_geometry_painter.dart';

class FigmaVector extends FigmaComponentBase  {
  final Rect figmaRect;
  final String type;
  String imageUrl;
  final Map data;
  final String id;

  FigmaVector( {
    @required this.figmaRect, 
     @required this.type,
    this.id,
    this.data
    });

  FigmaVector.fromJson(Map<String, dynamic> jsonData, ScreenSizeInfo screenSizeInfo): //
      this.figmaRect = screenSizeInfo.toFigmaRect(absoluteBoundingBox: jsonData["absoluteBoundingBox"]),
      this.id= jsonData["id"],
      this.type = jsonData['type'],
      this.data=jsonData;

  List<Widget> toWidgets({@required ScreenSizeInfo screenSizeInfo})=>    
    [
      _getSelf(screenSizeInfo: screenSizeInfo),
  ];


  Widget _getSelf({@required ScreenSizeInfo screenSizeInfo})=>
      positionedWrapper(
      screenSizeInfo: screenSizeInfo, 
      figmaRect: figmaRect, 
      child: 
        (imageUrl!=null)?
          Image.network(imageUrl, fit: BoxFit.cover,)
          :Container(
            width:double.infinity, height:double.infinity,
            decoration: FigmaStyles(data).getDecoration((!data.containsKey('fillGeometry')||data['fillGeometry'].length==0)?parseColor(data):null),
            child: 
            (!data.containsKey('fillGeometry')||data['fillGeometry'].length==0)?null:
            CustomPaint(
              size: Size(
                figmaRect.width,
                figmaRect.height,
              ),
              painter: 
              FillGeometryPainter(data['fillGeometry'][0]['path'], parseColor(data))
            )
          )
      );



 @override
  List<String> getImageIDs(){
    if (isImage(data))return [id];
    return [];
  }

  @override
  setImageUrls(Map<String,dynamic> idUrlsMap){
    if(idUrlsMap.containsKey(id)){
      imageUrl= idUrlsMap[id];
    }
  }

}


