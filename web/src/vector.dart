library vector;

import 'dart:math' as math;

class Vector {
  double x = 0.0;
  double y = 0.0;
  
  Vector([this.x = 0.0, this.y = 0.0]);
  
  Vector.fromVector(Vector other){
    this.x = other.x;
    this.y = other.y;
  }
  
  bool operator ==(other) {
    return x == other.x && y == other.y;
  }

  Vector operator +(Vector other) {
    return new Vector(x + other.x, y + other.y);
  }

  Vector operator -(Vector other) {
    return new Vector(x - other.x, y - other.y);
  }

  Vector operator *(num factor) {
    return new Vector(x * factor, y * factor);
  }
  
  Vector operator /(num factor) {
    return new Vector(x / factor, y / factor);
  }
  
  void normalize(){
    double d = magnitude;
    if(d > 0) {
      this.x = this.x / d;
      this.y = this.y / d;
    }
  }
  
  double get magnitude => math.sqrt(x * x + y * y);

  double get angle{
    double angle = math.atan2(y, x);
    return angle;
  } 
}

