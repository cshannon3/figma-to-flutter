



import 'package:figma_test/figma/figma_screen.dart';
import 'package:figma_test/figma/utils/figma_to_dart_maps.dart';
import 'package:figma_test/figma/utils/parse_color.dart';
import 'package:flutter/material.dart';


class FigmaComponent {
  final Rect figmaRect;
   final Color color;
   final String type;
  final String text;
  final double fontSize;
  final IconData iconData;
  final TextAlign textAlign;
  final String imageUrl;
  final List<FigmaComponent> children;
  //final dynamic figmaItem;


  FigmaComponent( {
    @required this.figmaRect, 
    @required this.color,
     @required this.type,
    this.text,
    this.fontSize,
    this.textAlign,
    this.iconData,
    this.imageUrl,
    this.children,
    
    });

  FigmaComponent.fromJson(Map<String, dynamic> jsonData, ScreenSizeInfo screenSizeInfo): //
      this.figmaRect = screenSizeInfo.toFigmaRect(absoluteBoundingBox: jsonData["absoluteBoundingBox"]),
      this.children = jsonData.containsKey("children")?jsonData["children"].map<FigmaComponent>((child)=>FigmaComponent.fromJson(child, screenSizeInfo)).toList():[],
      this.type = jsonData['type'],
      this.color= parseColor(jsonData),
      //this.opacity= parseOpacity(jsonData),
      this.text= jsonData['type']=="TEXT"?jsonData['characters']:null,
      this.iconData = figmaIcons.containsKey(jsonData['name'])?figmaIcons[jsonData['name']]:null,
      this.fontSize = jsonData['type']=="TEXT"?jsonData['style']['fontSize']:null,
      this.textAlign = getTextAlign(jsonData),
      this.imageUrl = jsonData["name"].contains("image")?
        jsonData["name"].substring(jsonData["name"].indexOf("http://")):null;
      // this.figmaItem=
      //   jsonData['type']=="TEXT"? :
      //   jsonData['type']=="RECTANGLE"? :
      //   jsonData['type']=="TEXT"? :
      //   jsonData['type']=="TEXT"? :;


  List<Widget> toWidgets({@required ScreenSizeInfo screenSizeInfo})=>    
    [
      _getSelf(screenSizeInfo: screenSizeInfo),
      ..._getChildren(screenSizeInfo: screenSizeInfo)
  ];

  Widget _getSelf({@required ScreenSizeInfo screenSizeInfo})=>
    (type=="FRAME"||type=="COMPONENT")?SizedBox():
      Positioned(
          top:screenSizeInfo.relativeWindowHeight*figmaRect.top,
          height: screenSizeInfo.relativeWindowHeight*figmaRect.height,
          left: screenSizeInfo.relativeWindowWidth*figmaRect.left,
          width:screenSizeInfo.relativeWindowWidth*figmaRect.width,
        child: Container(
          child: (text!=null)?
          Text(text, 
          textAlign: textAlign,
          style: TextStyle(
            color: color,
            fontSize: fontSize*screenSizeInfo.scaleX,
            
          ),):
          (iconData!=null)?
          Icon(iconData, color: color, size: 24*screenSizeInfo.scaleX,)
          : (imageUrl!=null)?
          Image.network(imageUrl, fit: BoxFit.cover,)
          :Container(
            width:double.infinity, height:double.infinity,
            color:color
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

TextAlign getTextAlign(dynamic jsonData){
  if(jsonData['type']!="TEXT")return null;
  String al= jsonData['style']['textAlignHorizontal'];
  return (al=="LEFT")?TextAlign.left:(al=="RIGHT")?TextAlign.right:(al=="CENTER")?TextAlign.center:TextAlign.left;
}


//## `blendMode` 
/*
layoutAlign String: How the layer is aligned inside an auto-layout frame. This property is only provided for direct children of auto-layout frames.
MIN
CENTER
MAX
STRETCH
In horizontal auto-layout frames, "MIN" and "MAX" correspond to "TOP" and "BOTTOM". In vertical auto-layout frames, "MIN" and "MAX" correspond to "LEFT" and "RIGHT"
 */
/*
opacityNumber default: 1
Opacity of the node
absoluteBoundingBoxRectangle
Bounding box of the node in absolute space coordinates

effectsEffect[] default: []
An array of effects attached to this node (see effects section for more details)

sizeVector
Width and height of element. This is different from the width and height of the bounding box in that the absolute bounding box represents the element after scaling and rotation. Only present if geometry=paths is passed
relativeTransformTransform
The top two rows of a matrix that represents the 2D transform of this node relative to its parent. The bottom row of the matrix is implicitly always (0, 0, 1). Use to transform coordinates in geometry. Only present if geometry=paths is passed
fillsPaint[] default: []
An array of fill paints applied to the node
fillGeometryPath[]
Only specified if parameter geometry=paths is used. An array of paths representing the object fill
strokeAlignString
Position of stroke relative to vector outline, as a string enum
INSIDE: stroke drawn inside the shape boundary
OUTSIDE: stroke drawn outside the shape boundary
CENTER: stroke drawn centered along the shape boundary
stylesMap<StyleType, String>
A mapping of a StyleType to style ID (see Style) of styles present on this node. The style ID can be used to look up more information about the style in the top-level styles field.
*/




class Vector {
  final String blendMode;
  final String layoutAlign;
  final double opacity;
  final Rect rect;
  final Size  size;

  Vector(this.blendMode, this.layoutAlign, this.opacity, this.rect, this.size);
  




}

class Frame {

}




class TransitionInfo{
  /*
  transitionNodeIDString default: null
Node ID of node to transition to in prototyping
transitionDurationNumber default: null
The duration of the prototyping transition on this node (in milliseconds)
transitionEasingEasingType default: null
The easing curve used in the prototyping transition on this node
  */
}














// abstract class VectorBase {
// //## `blendMode` 
// /*
// layoutAlign String: How the layer is aligned inside an auto-layout frame. This property is only provided for direct children of auto-layout frames.
// MIN
// CENTER
// MAX
// STRETCH
// In horizontal auto-layout frames, "MIN" and "MAX" correspond to "TOP" and "BOTTOM". In vertical auto-layout frames, "MIN" and "MAX" correspond to "LEFT" and "RIGHT"
//  */
// /*
// opacityNumber default: 1
// Opacity of the node
// absoluteBoundingBoxRectangle
// Bounding box of the node in absolute space coordinates
// effectsEffect[] default: []
// An array of effects attached to this node (see effects section for more details)
// sizeVector
// Width and height of element. This is different from the width and height of the bounding box in that the absolute bounding box represents the element after scaling and rotation. Only present if geometry=paths is passed
// relativeTransformTransform
// The top two rows of a matrix that represents the 2D transform of this node relative to its parent. The bottom row of the matrix is implicitly always (0, 0, 1). Use to transform coordinates in geometry. Only present if geometry=paths is passed
// fillsPaint[] default: []
// An array of fill paints applied to the node
// fillGeometryPath[]
// Only specified if parameter geometry=paths is used. An array of paths representing the object fill
// strokeAlignString
// Position of stroke relative to vector outline, as a string enum
// INSIDE: stroke drawn inside the shape boundary
// OUTSIDE: stroke drawn outside the shape boundary
// CENTER: stroke drawn centered along the shape boundary
// stylesMap<StyleType, String>
// A mapping of a StyleType to style ID (see Style) of styles present on this node. The style ID can be used to look up more information about the style in the top-level styles field.
// */



// }

// abstract class FrameBase {

// }

// class Vector extends VectorBase {


// }



// class Rectangle extends VectorBase {

// }

// class Star extends VectorBase {

// }

// class Line extends VectorBase {

// }

// class Ellipse extends VectorBase {

// }
// class Polygon extends VectorBase {

// }
// class Slice extends VectorBase {

// }








// class FigmaComponent {
//   final Rect figmaRect;
//   // final Color color;
//   // final String type;
//   // final String text;
//   // final double fontSize;
//   // final IconData iconData;
//   // final TextAlign textAlign;
//   // final String imageUrl;
//   final List<FigmaComponent> children;
//   final dynamic figmaItem;


//   FigmaComponent( {
//     @required this.figmaRect, 
//     // @required this.color,
//     // @required this.type,
//     // this.text,
//     // this.fontSize,
//     // this.textAlign,
//     // this.iconData,
//     // this.imageUrl,
//     this.children,
    
//     });

//   FigmaComponent.fromJson(Map<String, dynamic> jsonData, ScreenSizeInfo screenSizeInfo): //
//       this.figmaRect = screenSizeInfo.toFigmaRect(absoluteBoundingBox: jsonData["absoluteBoundingBox"]),
//       this.color= parseColor(jsonData),
//       this.type = jsonData['type'],
//     // jsonData.containsKey('fills')? parseColor(jsonData['fills'][0]['color']):col[Random().nextInt(col.length)],
//       this.text= jsonData['type']=="TEXT"?jsonData['characters']:null,
//       this.iconData = figmaIcons.containsKey(jsonData['name'])?figmaIcons[jsonData['name']]:null,
//       this.fontSize = jsonData['type']=="TEXT"?jsonData['style']['fontSize']:null,
//       this.textAlign = getTextAlign(jsonData),

//       this.imageUrl = jsonData["name"].contains("image")?jsonData["name"].substring("image:".length):null,
//       this.children = jsonData.containsKey("children")?jsonData["children"].map<FigmaComponent>((child)=>FigmaComponent.fromJson(child, screenSizeInfo)).toList():[];

  
//   List<Widget> toWidgets({@required ScreenSizeInfo screenSizeInfo})=>    
//     [
//       _getSelf(screenSizeInfo: screenSizeInfo),
//       ..._getChildren(screenSizeInfo: screenSizeInfo)
//   ];

//   Widget _getSelf({@required ScreenSizeInfo screenSizeInfo})=>
//     (type=="FRAME"||type=="COMPONENT")?SizedBox():
//       Positioned(
//           top:screenSizeInfo.relativeWindowHeight*figmaRect.top,
//           height: screenSizeInfo.relativeWindowHeight*figmaRect.height,
//           left: screenSizeInfo.relativeWindowWidth*figmaRect.left,
//           width:screenSizeInfo.relativeWindowWidth*figmaRect.width,
//         child: Container(
//           child: (text!=null)?
//           Text(text, 
//           textAlign: textAlign,
//           style: TextStyle(
//             color: color,
//             fontSize: fontSize*screenSizeInfo.scaleX,
            
//           ),):
//           (iconData!=null)?
//           Icon(iconData, color: color, size: 24*screenSizeInfo.scaleX,)
//           : (imageUrl!=null)?
//           Image.network(imageUrl, fit: BoxFit.cover,)
//           :Container(
//             width:double.infinity, height:double.infinity,
//             color:color
//           )
//         )
//       );
  
//   List<Widget> _getChildren({@required ScreenSizeInfo screenSizeInfo}){
//     List<Widget> childrenWidgets = [];
//     children?.forEach((childComponent) {
//       childrenWidgets.addAll(
//         childComponent.toWidgets(screenSizeInfo: screenSizeInfo)
//       ); 
//     });
//     return childrenWidgets;
//   }

// }

// TextAlign getTextAlign(dynamic jsonData){
//   if(jsonData['type']!="TEXT")return null;
//   String al= jsonData['style']['textAlignHorizontal'];
//   return (al=="LEFT")?TextAlign.left:(al=="RIGHT")?TextAlign.right:(al=="CENTER")?TextAlign.center:TextAlign.left;
// }
