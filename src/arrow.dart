library arrow;

import 'vector.dart';

class Arrow {
    
  Vector position = new Vector();
  Vector initPos = new Vector();
  Vector velocity = new Vector();
  double angle = 0.0;
  double width;
  double height;
  bool lock = false;
  
  Arrow(this.position, this.width, this.height){
    initPos = new Vector.fromVector(position);
  }
  
  void updateAngle(double angle){
    if(lock == false){
      this.angle = angle;
    }
  }
  
  void update(double deltaTime){
    
    if(lock == true){
      Vector target = new Vector.fromVector(velocity);
      angle = target.angle;
    }
    
    position.x += velocity.x * deltaTime;
    position.y += velocity.y * deltaTime;
  }
  
  void reset(){
    position = new Vector.fromVector(initPos);
    lock = false;
    velocity = new Vector();
  }
  
}