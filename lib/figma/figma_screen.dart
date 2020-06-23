


import 'package:figma_test/figma/figma_component.dart';
import 'package:flutter/material.dart';

// TODO screen_sizes

class FigmaScreen{
  final double fullW;
  final double fullH;
  final double offsetX;
  final double offsetY;
  final String name;
  final dynamic data;
  List<FigmaComponent>  components=[];

  FigmaScreen({
    @required this.fullW, 
    @required this.fullH, 
    @required this.offsetX, 
    @required this.offsetY,
    @required this.name, 
    @required this.data,
    });
     
   FigmaScreen.fromJson(Map<String, dynamic> jsonData):
      this.fullW=jsonData["size"]['y'],
      this.fullH=jsonData["size"]['x'], 
      this.offsetX=jsonData["absoluteBoundingBox"]['x'], 
      this.offsetY=jsonData["absoluteBoundingBox"]['y'], 
      this.name=jsonData["name"], 
      this.data=jsonData;

// TODO Recursion
  init(){

    data["children"].forEach((component){
      print(component);
      if(component.containsKey("children")){
        component['children'].forEach((c){
          components.add(
            FigmaComponent.fromJson(c, offsetX, offsetY)
          );
        });
      }
    });
  }


  List<Widget> getWidgets(double h, double w, {double scale=1.0})
      =>components.map((e) 
            => e.toWidget(h, w,fullH, fullW, scale: scale, relative: false))
        .toList();
}
