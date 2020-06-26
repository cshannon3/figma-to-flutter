
import 'package:figma_test/figma/utils/parse_color.dart';
import 'package:flutter/material.dart';

class FigmaStyles{
  final Map data;

  FigmaStyles(this.data);

  BoxDecoration getDecoration(Color color){
    // check if visible/ pass through
    if(data.containsKey("blendMode") && data["blendMode"]=="PASS_THROUGH"){
          return null;
    }
    return BoxDecoration(
              color:color,
              border:_getBoxBorder(),
              borderRadius:_getBorderRadius(),
              boxShadow:_getBoxShadows(),
              gradient: _getGradient(), //Todo
              backgroundBlendMode: _getBlendMode(),
            );
  }

  List<BoxShadow> _getBoxShadows(){
     if(!data.containsKey("effects") || data["effects"].length==0)return [];
     return  data["effects"].map<BoxShadow>((effect)=>
                BoxShadow(
                      color:parseColor(effect),
                      offset:Offset(effect['offset']['x'], effect['offset']['y']),
                      blurRadius:effect['radius'].toDouble(),
                      //spreadRadius:,
                    )
                ).toList();
  }

  BorderRadiusGeometry _getBorderRadius(){
    return data.containsKey("rectangleCornerRadii") ?BorderRadius.only(
                topLeft: Radius.circular(data["rectangleCornerRadii"][0]),
                topRight: Radius.circular(data["rectangleCornerRadii"][1]),
                bottomLeft: Radius.circular(data["rectangleCornerRadii"][2]),
                bottomRight: Radius.circular(data["rectangleCornerRadii"][3]),
              ):null;
  }

  BoxBorder _getBoxBorder(){
    return (data["strokes"].length>0)?Border.all(
                color: parseColor(data["strokes"][0]),
                width: data["strokeWeight"].toDouble(),
              ):null;
  }
  Gradient _getGradient()=>null; //todo
  BlendMode _getBlendMode()=>null; // todo

}