

// import 'package:flutter/material.dart';

// abstract class FigmaItem {
//   final Rect positionOnScreen;
//   final Rect positionInComponent;
//   final Color color;
//   final String text;
//   final double fontSize;
//   final IconData iconData;
//   final String imageUrl;


//   FigmaItem({
//     @required this.positionOnScreen,
//     this.positionInComponent,
//     @required this.color,
    
//     this.text,
//     this.fontSize,
//     this.iconData,
//     this.imageUrl
//     });

  

//   FigmaComponent.fromJson(Map<String, dynamic> jsonData, double offsetX, double offsetY):
//       this.height= jsonData["size"]['y'],
//       this.width= jsonData["size"]['x'],
//       this.top=  jsonData["absoluteBoundingBox"]['y']-offsetY, 
//       this.left=  jsonData["absoluteBoundingBox"]['x']-offsetX, 
//       this.color= parseColor(jsonData),
//     // jsonData.containsKey('fills')? parseColor(jsonData['fills'][0]['color']):col[Random().nextInt(col.length)],
//       this.text= jsonData['type']=="TEXT"?jsonData['characters']:null,
//       this.iconData = figmaIcons.containsKey(jsonData['name'])?figmaIcons[jsonData['name']]:null,
//       this.fontSize = jsonData['type']=="TEXT"?jsonData['style']['fontSize']:null,
//       this.imageUrl = jsonData["name"].contains("image")?jsonData["name"].substring("image:".length):null;
// }


// class FigmaText extends FigmaItem{
//   final Color color;
//   final String text;
//   final double fontSize;
//   final IconData iconData;
//   final String imageUrl;


//   FigmaText({
//     @required this.color,
//     this.text,
//     this.fontSize,
//     this.iconData,
//     this.imageUrl
//     });

  

//   FigmaComponent.fromJson(Map<String, dynamic> jsonData, double offsetX, double offsetY):
//       this.height= jsonData["size"]['y'],
//       this.width= jsonData["size"]['x'],
//       this.top=  jsonData["absoluteBoundingBox"]['y']-offsetY, 
//       this.left=  jsonData["absoluteBoundingBox"]['x']-offsetX, 
//       this.color= parseColor(jsonData),
//     // jsonData.containsKey('fills')? parseColor(jsonData['fills'][0]['color']):col[Random().nextInt(col.length)],
//       this.text= jsonData['type']=="TEXT"?jsonData['characters']:null,
//       this.iconData = figmaIcons.containsKey(jsonData['name'])?figmaIcons[jsonData['name']]:null,
//       this.fontSize = jsonData['type']=="TEXT"?jsonData['style']['fontSize']:null,
//       this.imageUrl = jsonData["name"].contains("image")?jsonData["name"].substring("image:".length):null;
// }
