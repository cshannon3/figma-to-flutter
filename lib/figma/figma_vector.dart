


import 'dart:typed_data';

import 'package:figma_test/figma/figma_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import 'utils/fill_geometry_painter.dart';

class FigmaVector {
  final Rect figmaRect;
 // final Color color;
  final String type;
  final String imageUrl;
  final Map data;
  //final BoxDecoration decoration;


  FigmaVector( {
    @required this.figmaRect, 
   // @required this.color,
     @required this.type,
    this.imageUrl,
  //  this.decoration,
    this.data
    });

  FigmaVector.fromJson(Map<String, dynamic> jsonData, ScreenSizeInfo screenSizeInfo): //
      this.figmaRect = screenSizeInfo.toFigmaRect(absoluteBoundingBox: jsonData["absoluteBoundingBox"]),
      this.type = jsonData['type'],
      this.data=jsonData,
     // this.color= parseColor(jsonData),
      this.imageUrl = jsonData["name"].contains("image")?
        jsonData["name"].substring(jsonData["name"].indexOf("http://")):null;
    

  List<Widget> toWidgets({@required ScreenSizeInfo screenSizeInfo})=>    
    [
      _getSelf(screenSizeInfo: screenSizeInfo),
  ];

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
            decoration: BoxDecoration(
              color://parseColor(data),
              (!data.containsKey('fillGeometry')||data['fillGeometry'].length==0)?parseColor(data):null,
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
                      spreadRadius:effect['radius'].toDouble(),
                    )
                ).toList(),
              gradient: null,
              backgroundBlendMode: null,
            ),
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


List<Color>col=[Colors.blue, Colors.green, Colors.red, Colors.orange, Colors.yellow];
Color parseColor(var data){
    Color h;
     double op; ///=1.0;
     try{
          op=data['fills'][0]["opacity"]??1.0;
          
          //print(op);
     }catch(e){op =1.0;}
     if(op==0)return Colors.transparent;
    // data['fills'][0]["opacity"].toDouble());
    try{
      var c = data['fills'][0]['color'];
        h= Color.fromARGB(
        (255*c['a']).toInt(), 
        (255*c['r']).toInt(), 
        (255*c['g']).toInt(), 
        (255*c['b']).toInt(),)..withOpacity(op);
        //.withOpacity(data['fills'][0]["opacity"].toDouble());
    }catch(r){
    h=Colors.transparent;//col[Random().nextInt(col.length)]; 
    }
    return h;
}

