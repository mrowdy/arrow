library game;

import 'input.dart';
import 'arrow.dart';
import 'vector.dart';
import 'target.dart';
import 'dart:html';
import 'dart:math' as Math;

class Game {
  
  double width;
  double height;
  double gameTime = 0.0;
  Vector gravity = new Vector(0.0, -4.0);
  Arrow arrow;
  Stopwatch stopwatch = new Stopwatch()..start();
  int count = 0;
  bool gameOver = false;
  
  double clickTime = 0.0;
  Vector clickPosition = new Vector();
  bool click = false;
  
  List<Target> targetList = new List<Target>();
  

  Game(this.width, this.height, Input input){
    
    Vector arrowPosition = new Vector(60.0, height / 2);
    double arrowWidth = this.height / 10;
    ImageElement arrowImg = querySelector('.assets .arrow');
    double ratio = arrowImg.height / arrowImg.width;
    double arrowHeight = ratio * this.height / 10;
    arrow = new Arrow(arrowPosition, this.height / 10, arrowHeight);
    
    generateTargets();
    
    input.onDown.listen((data){
      click = true;
      clickPosition = data;
      clickTime = getTime();
    });
    
    input.onUp.listen((data){
      if(click){
        clickPosition = data;
        double time = getTime() - clickTime;
        clickTime = 0.0;
        click = false;
        _shoot(time);
      }
    });
    
    input.onMove.listen((data){
      clickPosition = data;
    });
    
  }
  
  void update(){
    double currentTime = getTime();
    double deltaTime = currentTime - gameTime;
    gameTime = currentTime;
    
    if(count >= 5){
      gameOver = true;
      return;
    }
    
    _checkCollision();
    
    if(clickPosition != null){
     Vector target = clickPosition - arrow.position;
     double angle = target.angle;
     arrow.updateAngle(angle);
    }
    
    if(arrow.lock == true){
      arrow.velocity -= gravity;
    }

    arrow.update(deltaTime);
  }
  
  void _shoot(double time){
    arrow.lock = true;
    double speed = capSpeed(time);
    Vector target = clickPosition - arrow.position;
    target.normalize();
    target *= speed;
    clickPosition = null;
    arrow.velocity = target;
    
  }
  
  double capSpeed(double speed){
    speed *= 40;
    speed = Math.max(speed, 50.0);
    speed = Math.min(speed, 200.0);
    return speed;
  }
  
  void generateTargets() {
    double height = this.height / 10;
    double width = height;
    for(num i = 0; i < 5; i++ ){
      double posY = this.height / 5 * i + this.height / 10;
       Vector position = new Vector(this.width - width, posY);
       Target target = new Target(position, width, height, i);
       targetList.add(target);
    }
  }
  
  void _checkCollision(){
    Vector arrowTop = new Vector(arrow.position.x + arrow.width / 2, arrow.position.y);
    if(arrowTop.x > this.width - this.height / 10
        && arrowTop.x < this.width){
      targetList.forEach((Target target){
        if(target.isHit == false){
          if(arrowTop.y > target.position.y - target.height / 2
              && arrowTop.y < target.position.y + target.height / 2){
              target.hit();
              arrow.reset();
              count++;
          }
        }
      });
    }
    
    if(arrow.position.x - arrow.width / 2 > this.width
        || arrow.position.y + arrow.height / 2 > this.height
        || arrow.position.x < 0){
      arrow.reset();
    }
  }
  
  double getTime() => stopwatch.elapsedMilliseconds / 100;


}