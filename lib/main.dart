
import 'package:figma_test/secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';

import 'figma/figma_api.dart';
double sc=0.35;
double leftstart=0.15;
double topstart=0.35;
int columns;
//https://www.figma.com/file/58ieGqOKtHUp9rwoTBnJBk/FriendlyEats?node-id=0%3A1
void main() async {
  var api = FigmaApiGenerator(BrowserClient(), figmaSecret);
  await api.init("58ieGqOKtHUp9rwoTBnJBk");
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
        child: Home(figmaApiGenerator: widget.figmaApiGenerator,),
      ),
      ),
    
    );
  }
}
class Home extends StatelessWidget {
  final FigmaApiGenerator figmaApiGenerator;

  const Home({Key key, this.figmaApiGenerator}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Wrap(
         children:  //[
         //  ...
           getScreenWidgets(screenSize: s) //h: s.height, w:s.width, scale: 0.3
        //]
      //   [
  ),
    );
  }


  List<Widget> getScreenWidgets({@required Size screenSize}){    //@required double h, @required double w, double scale=1.0
    List<Widget> screenWidgets =[];
    //double l= 0.0;

    figmaApiGenerator.screens.forEach((figmaScreenName, figmaScreenModel) {
      screenWidgets.add(
         figmaScreenModel.getScreen(
           windowFrame: Rect.fromLTWH(
             0.2*screenSize.width, 
             0.2*screenSize.height, 
             0.4*screenSize.width, 
            (0.4*screenSize.width)*(figmaScreenModel.screenSizeInfo.figmaScreenSize.height/figmaScreenModel.screenSizeInfo.figmaScreenSize.width)
           ), 
           screenSize: screenSize
          )
      );//print("ok");
    // l+=0.3;
    });
    return screenWidgets;
  }
}



    //     Positioned(
    //       left: s.width*leftstart,
    //       width: s.width*sc,
    //       top: s.height*topstart,
    //       height: s.height*sc,
    //       child: 
    //               children: [
    //                 ...figmaApiGenerator.getWidgets(s.height*sc, s.width*sc, scale:sc),
    //               ]
             
    //                 ...figmaApiGenerator.getWidgets(s.height*sc, s.width*sc, scale:sc),
              
    //     ),
    //   ],
    // );
// class Home extends StatelessWidget {
//   final FigmaApiGenerator figmaApiGenerator;

//   const Home({Key key, this.figmaApiGenerator}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     Size s = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         Positioned(
//           left: s.width*leftstart,
//           width: s.width*sc,
//           top: s.height*topstart,
//           height: s.height*sc,
//           child: Draggable(
//             feedback: Container(
//               height: s.height*sc,
//               width: s.width*sc,
//               child: Stack(
//                   children: [
//                     ...figmaApiGenerator.getWidgets(s.height*sc, s.width*sc, scale:sc),
//                   ]
//               ),
//             ),
//             child: Container(
//               height: s.height*sc,
//               width: s.width*sc,
//               child: Stack(
//                   children: [
//                     ...figmaApiGenerator.getWidgets(s.height*sc, s.width*sc, scale:sc),
//                   ]
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Home extends StatelessWidget {
//   final FigmaApiGenerator figmaApiGenerator;

//   const Home({Key key, this.figmaApiGenerator}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     Size s = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       child: Stack(
//           children: [
//             Container(height: 5000,),
//             ...figmaApiGenerator.getWidgets(s.height, s.width),
//           ]
  
//       ),
    
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title,  @required this.figmaApiGenerator}) : super(key: key);
//   final String title;
//   final FigmaApiGenerator figmaApiGenerator;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {

//     return  
//   }
// }
