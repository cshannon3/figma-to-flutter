import 'dart:async';
import 'dart:convert';
import 'package:figma_test/figma/figma_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class FigmaApiGenerator extends ChangeNotifier{
  final String authToken;
  final BaseClient http;
  String currentScreen;
  String currentPage;

  Map<String, dynamic> data;
  Map<String, FigmaScreen> screens = {};
  List pages = [];
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
    String urlids = ids.join(",");
    
    var response = await http.get(
        "https://api.figma.com/v1/images/$fileKey?ids=$urlids",
        headers: {
          "X-FIGMA-TOKEN": this.authToken,
        });
     var jsonData = json.decode(response.body);
     return jsonData["error"]??jsonData["images"];
  }

  init(String fileKey,{bool getImages = false}) async {
    loading=true;
    data = await _getFile(fileKey);
    print("init");
    data['document']['children'].forEach((page){
      pages.add(page["name"]);
    });
    
    var page1 = data['document']['children'][0];
    int n = 0;
    page1['children'].forEach((screen) async {
        if(screen.containsKey("children")){
          screens[screen["name"]]=FigmaScreen.fromJson(screen);
          screens[screen["name"]].init();
          if(getImages){
            List<String> ids=screens[screen["name"]].getImageIDs();
           Map<String,dynamic> imagenodes = await _getImages(fileKey, ids);
           screens[screen["name"]].setImageUrls(imagenodes);
          }
        }
        n+=1;
        if(n== page1['children'].length){
          loading=true;
          notifyListeners();
        }
   });
  }


}


