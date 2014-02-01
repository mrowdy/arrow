library target;

import 'vector.dart';
import 'dart:html';

class Target {
  
  Vector position = new Vector();
  double width;
  double height;
  ImageElement img;
  ImageElement defaultImg;
  bool isHit = false;
  
  List<ImageElement> images = [
    querySelector('.assets .chrome'),
    querySelector('.assets .firefox'),   
    querySelector('.assets .safari'),   
    querySelector('.assets .opera'),   
    querySelector('.assets .ie'),   
  ];
  
  Target(this.position, this.width, this.height, int index){
    img = images[index];

    img.width = width.toInt();
    img.height = height.toInt();
    
    defaultImg = querySelector('.assets .dart');
  }
  
  void hit(){
    img = defaultImg;
    isHit = true;
  }
  
}