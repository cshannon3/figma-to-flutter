



import 'package:figma_test/figma/utils/figma_to_dart_maps.dart';
import 'package:figma_test/figma/utils/parse_color.dart';
import 'package:flutter/material.dart';

// abstract class FigmaComponent{


// }


class FigmaComponent {
  final double left;
  final double width;
  final double top;
  final double height;
  final Color color;
  final String text;
  final double fontSize;
  final IconData iconData;
  final String imageUrl;


  FigmaComponent({
    @required this.left, 
    @required this.width, 
    @required this.top, 
    @required this.height, 
    @required this.color,
    this.text,
    this.fontSize,
    this.iconData,
    this.imageUrl
    });

  FigmaComponent.fromJson(Map<String, dynamic> jsonData, double offsetX, double offsetY):
      this.height= jsonData["size"]['y'],
      this.width= jsonData["size"]['x'],
      this.top=  jsonData["absoluteBoundingBox"]['y']-offsetY, 
      this.left=  jsonData["absoluteBoundingBox"]['x']-offsetX, 
      this.color= parseColor(jsonData),
    // jsonData.containsKey('fills')? parseColor(jsonData['fills'][0]['color']):col[Random().nextInt(col.length)],
      this.text= jsonData['type']=="TEXT"?jsonData['characters']:null,
      this.iconData = figmaIcons.containsKey(jsonData['name'])?figmaIcons[jsonData['name']]:null,
      this.fontSize = jsonData['type']=="TEXT"?jsonData['style']['fontSize']:null,
      this.imageUrl = jsonData["name"].contains("image")?jsonData["name"].substring("image:".length):null;


  Widget toWidget(double h, double w, double fullH, double fullW, {double scale=1.0, bool relative =true})=>    
    Positioned(
      left: relative?w*(left/fullW):left*scale,
      width: relative?w*(width/fullW):width*scale,
      top: relative?h*(top/fullH):top*scale,
      height: relative?h*(height/fullH):height*scale,
      child: (text!=null)?
      Text(text, style: TextStyle(
        color: color,
        fontSize: fontSize*scale
      ),):
      (iconData!=null)?
      Icon(iconData, color: color, size: 24*scale,)
      : (imageUrl!=null)?
      Image.network(imageUrl, fit: BoxFit.cover,)
      :Container(
        width:double.infinity, height:double.infinity,
        color:color// col[Random().nextInt(5)]
      )
  );
}

  
