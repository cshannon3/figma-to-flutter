


bool isImage(Map json){
  try{
    String type = json["fills"][0]["type"];
    if(type=="IMAGE")return true;
    return false;
  }catch(e){
    return false;
  }
}

