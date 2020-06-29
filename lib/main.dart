



import 'package:figma_test/secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';

import 'figma/figma_api.dart';
import 'dart:ui';

final Map figmafiles ={
"a":"rCp1ekGyTPz1K92TE32ZwL",
"b":"58ieGqOKtHUp9rwoTBnJBk",
"c":"NBrXfF9tqmaNu4xlXtSY7d",
"prototyping":"Uvf5arrdAPCgXbSV8a2lT1"
};

int columns;
//https://www.figma.com/file/58ieGqOKtHUp9rwoTBnJBk/FriendlyEats?node-id=0%3A1
void main() async {
  var api = FigmaApiGenerator(BrowserClient(), figmaSecret);
  await api.init(figmafiles["a"], getImages: true);
  runApp(MyApp(figmaApiGenerator: api,));
}

class MyApp extends StatefulWidget {
  final FigmaApiGenerator figmaApiGenerator;

  const MyApp({Key key, @required this.figmaApiGenerator}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
      appBar: AppBar(
        title: Text( 'Flutter Demo Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:// Center()
        Home(figmaApiGenerator: widget.figmaApiGenerator,),
      ),
      ),
    
    );
  }
}
class Home extends StatefulWidget {
  final FigmaApiGenerator figmaApiGenerator;

  const Home({Key key, this.figmaApiGenerator}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentScreen;
  double pctSize = 0.3;

  @override
  void initState() {
    super.initState();
    widget.figmaApiGenerator.addListener(() {
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
  
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.figmaApiGenerator.pages.map((e) 
        => 
        RaisedButton(
          onPressed:(){}, 
          child: Text(e),)
          ).toList(),),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
               children:  
                 getScreenWidgets(screenSize: s)
  ),
          ),
        ),
      ],
    );
  }

  List<Widget> getScreenWidgets({@required Size screenSize}){    //@required double h, @required double w, double scale=1.0
    List<Widget> screenWidgets =[];
    widget.figmaApiGenerator.screens.forEach((figmaScreenName, figmaScreenModel) {
       double figmaH= figmaScreenModel.screenSizeInfo.figmaScreenSize.height;
        double figmaW= figmaScreenModel.screenSizeInfo.figmaScreenSize.width;
      if(currentScreen==null){
      screenWidgets.add(
          GestureDetector(
            onLongPress: (){
              setState(() {
                currentScreen=figmaScreenName;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(50.0),
              child: AnimatedContainer(
                duration: Duration(seconds:2),
                height: pctSize*figmaH,
                width:  pctSize*figmaW,
                child:   figmaScreenModel.getScreen(
             windowFrame: Rect.fromLTWH(
               0.1*screenSize.width, 
               0.1*screenSize.height, 
               pctSize*figmaW, 
               pctSize*figmaH
             ), 
             screenSize: screenSize
            ))),
          )
      );

    }else if(currentScreen==figmaScreenName){
         screenWidgets.add(
          GestureDetector(
            onLongPress: (){
              setState(() {
                currentScreen=null;
              });
            },
            child: Container(
              height: figmaH,//h*scale,
              width:  figmaW,
              child:   figmaScreenModel.getScreen(
             windowFrame: Rect.fromLTWH( 0,  0, figmaW, figmaH), 
             screenSize: screenSize
            )),
          )
      );
    }
    });
    return screenWidgets;
  }
}


