library input;

import 'dart:html';
import 'dart:async';
import 'vector.dart';

class Input {
  
  StreamController<Vector> _onMove = new StreamController.broadcast(),
                   _onDown = new StreamController.broadcast(),
                   _onUp = new StreamController.broadcast();
      
 
  Input(CanvasElement canvas){
    canvas.onMouseDown.listen((MouseEvent evt){
      double x = evt.offset.x.toDouble();
      double y = evt.offset.y.toDouble();
      _onDown.add(new Vector(x, y));
    });
    
    canvas.onMouseMove.listen((MouseEvent evt){
      double x = evt.offset.x.toDouble();
      double y = evt.offset.y.toDouble();
      _onMove.add(new Vector(x, y));
    });
    
    canvas.onMouseUp.listen((MouseEvent evt){
      double x = evt.offset.x.toDouble();
      double y = evt.offset.y.toDouble();
      _onUp.add(new Vector(x, y));
    });
   
  }
 
  Stream<Vector> get onMove => _onMove.stream; 
  Stream<Vector> get onUp => _onUp.stream;
  Stream<Vector> get onDown => _onDown.stream;
 
}