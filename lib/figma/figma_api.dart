import 'dart:async';
import 'dart:convert';
import 'package:figma_test/figma/figma_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class FigmaApiGenerator extends ChangeNotifier{
  final String authToken;
  final BaseClient http;
  Map<String, dynamic> data;
  Map<String, FigmaScreen> screens = {};
  bool loading=true;

  FigmaApiGenerator(this.http, this.authToken);
  Widget imageTest;
  
  Future<dynamic> _getFile(String fileKey) async {
    var response = await http.get(
        "https://api.figma.com/v1/files/$fileKey?geometry=paths",
        headers: {
          "X-FIGMA-TOKEN": this.authToken,
        });
    return json.decode(response.body);
  } 

  Future<Map<String,dynamic>> _getImages(String fileKey, List<String> ids) async {
    print(ids);
    String urlids = ids.join(",");
    
    var response = await http.get(
        "https://api.figma.com/v1/images/$fileKey?ids=$urlids",
        headers: {
          "X-FIGMA-TOKEN": this.authToken,
        });
     var jsonData = json.decode(response.body);
  //   if(jsonData["error"]==null)
     return jsonData["error"]??jsonData["images"];
    // jsonData[""]

  }

  init(String fileKey,{bool getImages = false}) async {
    loading=true;
    data = await _getFile(fileKey);
    print("init");
    var page1 = data['document']['children'][0];
   // print(page1);
    int n = 0;
   // print(page1['children'].length);
    page1['children'].forEach((screen) async {

        if(screen.containsKey("children")){
          screens[screen["name"]]=FigmaScreen.fromJson(screen);
          screens[screen["name"]].init();
          if(getImages){
            List<String> ids=screens[screen["name"]].getImageIDs();
            //print(ids);
           Map<String,dynamic> imagenodes = await _getImages(fileKey, ids);
          // print(imagenodes);
           screens[screen["name"]].setImageUrls(imagenodes);
          }
        }
        n+=1;
        if(n== page1['children'].length){
          //print("doneSSSS");
          loading=true;
          notifyListeners();
        }
   });
   
  }


}



// class FigmaApiGenerator {
//   final String authToken;
//   final BaseClient http;
//   Map<String, dynamic> data;
//   Map<String, FigmaScreen> screens = {};
//   FigmaApiGenerator(this.http, this.authToken);
  
//   Future<dynamic> _getFile(String fileKey) async {
//     var response = await http.get(
//         "https://api.figma.com/v1/files/$fileKey?geometry=paths",
//         headers: {
//           "X-FIGMA-TOKEN": this.authToken,
//         });
//     return json.decode(response.body);
//   }

//   init(String fileKey) async {
//     data = await _getFile(fileKey);
//     var page1 = data['document']['children'][0];

//     page1['children'].forEach((screen){
//         screens[screen["name"]]=FigmaScreen.fromJson(screen);
//        screens[screen["name"]].init();
//    });
//   }

//   List<Widget> getScreens({@required double h,@required double w, double scale=0.5}){
//     List<Widget> screenWidgets =[];
//     double l= 0.0;
//     screens.forEach((key, value) {
//       print(key);
//       screenWidgets.add(
//         Positioned(
//           left: l*w,
//           width: w*scale,
//           height: h*scale,
//           top: 0.0,
//           child: Container(
//             height: h*scale,
//             width: w*scale,
//             child: SingleChildScrollView(
//               child: Stack(children: [
//                 Container(
//         height: value.fullH,
//       ),
//                 ...value.getWidgets(h, w, scale: scale),
//               ]
//               )
//               ),
//           ),
//       )
//       );//print("ok");
//      l+=0.3;
//     });
//     return screenWidgets;
//   }

// }








   // print(screen);
    //.forEach((screen){
        //screens[screen["name"]]=FigmaScreen.fromJson(screen);
       // screens[screen["name"]].init();
   // });
   // List<Widget> getWidgets(double h, double w, {double scale=1.0})
    //     =>components.map((e) 
    //           => e.toWidget(h, w,fullH, fullW, scale: scale, relative: false))
    //       .toList();
 
  //Map<String, dynamic> d= await api.getFile("58ieGqOKtHUp9rwoTBnJBk");
  // Map<String, dynamic> dj = jsonDecode(d);

 // print(data['document']['children'][0]['children'][0]['name']);
    // print(data['document']['children'][0]['children'][0]['children'][0]['name']);
    // var r= data['document']['children'][0]['children'][0]['children'][0];         //print(c['name']);
        // print(figmaIcons[c['name']]);
         //if()
        //  var header = desktop1['children'][0];

        
  // List<Widget> getWidgets(double h, double w, {double scale=1.0})
  // =>widgets.map((e) 
  //       => e.toWidget(h, w, scale: 0.25, relative: false)).toList();
    //var screen = page1['children'][0];
    //print(screen);