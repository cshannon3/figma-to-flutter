
import 'dart:math';

import 'package:flutter/material.dart';

List<Color>col=[Colors.blue, Colors.green, Colors.red, Colors.orange, Colors.yellow];
  Color parseColor(var data){
    Color h;
try{
  var c = data['fills'][0]['color'];
    h= Color.fromARGB(
    (255*c['a']).toInt(), 
    (255*c['r']).toInt(), 
    (255*c['g']).toInt(), 
    (255*c['b']).toInt(), );
}catch(r){
h=col[Random().nextInt(5)];
}
return h;
  }


dynamic safeGet({@required String key, @required Map map,@required dynamic alt}){
  try{
    return map.containsKey(key)?map[key]
    :map.containsKey(key.toLowerCase())?map[key.toLowerCase()]:alt;
  }catch(e){
    return alt;
  }
}