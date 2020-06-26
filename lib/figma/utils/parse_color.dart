
import 'package:flutter/material.dart';

//List<Color>col=[Colors.blue, Colors.green, Colors.red, Colors.orange, Colors.yellow];


Color parseColor(var data){
    Color h;
    double op; ///=1.0;
     try{
          op=data['fills'][0]["opacity"]??1.0;
     }catch(e){op =1.0;}
     if(op==0)return Colors.transparent;
    // data['fills'][0]["opacity"].toDouble());
    try{
      var c = data['fills'][0]['color'];
        h= Color.fromARGB(
        (255*c['a']).toInt(), 
        (255*c['r']).toInt(), 
        (255*c['g']).toInt(), 
        (255*c['b']).toInt(),)..withOpacity(op);
        //.withOpacity(data['fills'][0]["opacity"].toDouble());
    }catch(r){
    h=Colors.transparent;//col[Random().nextInt(col.length)]; 
    }
    return h;
}

