  
  
import 'package:flutter/material.dart';
//



//




// double checkTextFits(
//       TextSpan text, double scale, int maxLines, BoxConstraints constraints) {
//     if (!widget.wrapWords) {
//       var words = text.toPlainText().split(RegExp('\\s+'));

//       var wordWrapTp = TextPainter(
//         text: TextSpan(
//           style: text.style,
//           text: words.join('\n'),
//         ),
//         textAlign: widget.textAlign ?? TextAlign.left,
//         textDirection: widget.textDirection ?? TextDirection.ltr,
//         textScaleFactor: scale ?? 1,
//         maxLines: words.length,
//         locale: widget.locale,
//         strutStyle: widget.strutStyle,
//       );

//       wordWrapTp.layout(maxWidth: constraints.maxWidth);

//       if (wordWrapTp.didExceedMaxLines ||
//           wordWrapTp.width > constraints.maxWidth) {
//         return false;
//       }
//     }