import 'package:figma_test/figma/utils/screen_size_info.dart';
import 'package:flutter/material.dart';


Widget positionedWrapper({@required ScreenSizeInfo screenSizeInfo, @required Rect figmaRect, @required child})
=> Positioned(
          top:screenSizeInfo.relativeWindowHeight*figmaRect.top,
          left: screenSizeInfo.relativeWindowWidth*figmaRect.left,
        child: SizedBox(
          height:screenSizeInfo.relativeWindowHeight*figmaRect.height,
          width:screenSizeInfo.relativeWindowWidth*figmaRect.width,
          child: child
        )
);
