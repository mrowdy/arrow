library renderer;

import 'dart:html';
import 'game.dart';
import 'arrow.dart';
import 'vector.dart';
import 'target.dart';

class Renderer {
  
  Element _container;
  CanvasElement canvas;
  CanvasRenderingContext2D _context;
  int _width = 0;
  int _height = 0;
  Game game;
  
  //Images
  ImageElement arrowImg = querySelector('.assets .arrow');
  ImageElement backgroundImg = querySelector('.assets .bg');
  ImageElement dartImg = querySelector('.assets .dartLogo');
  
  Renderer(this._container, this._width, this._height){
    _setupCanvas();
  }
  
  void draw(Game game){
    this.game = game;
    _clear();
    _renderBackground();
    _renderArrow();
    _renderTargets();
    _renderScore();
  }
  
  void _setupCanvas(){
    canvas = new CanvasElement();
    _container.children.add(canvas);
    canvas.width = _width;
    canvas.height = _height;
    _context = canvas.getContext('2d');
  }
  
  void _clear(){
    _context
      ..setFillColorRgb(0, 0, 0, 1)
      ..clearRect(0, 0, _width, _height)
      ..fillRect(0, 0, _width, _height);
  }
  
  void _renderBackground(){
    _context.drawImage(
        backgroundImg, 
        _width / 2 - backgroundImg.width / 2, 
        0.0
    );
    _context
      ..setFillColorRgb(0, 0, 0, .7)
      ..fillRect(0, 0, _width, _height);
  }
  
  void _renderArrow(){
    Arrow arrow = game.arrow;
    Vector pos = arrow.position;
    _context
      ..save()
      ..translate(pos.x, pos.y)
      ..rotate(arrow.angle)
      ..drawImageScaled(arrowImg, - arrow.width / 2, - arrow.height / 2, arrow.width, arrow.height)
      ..restore();
  }
  
  void _renderTargets(){
    game.targetList.forEach((Target target){
      Vector pos = target.position;
      _context
      ..save()
      ..translate(pos.x, pos.y)
      ..drawImageScaled(target.img, - target.width / 2, - target.height / 2, target.width, target.height)
      ..restore();
    });
  }
  
  void _renderScore(){
    String score = 'Dart support: ${game.count * 20}%';
   
    if(game.gameOver == true){
      _context
      ..drawImage(dartImg, _width / 2 - dartImg.width / 2, _height / 2 - dartImg.height / 2 - 50)
      ..lineWidth = 2
      ..strokeStyle = '#0081c6'
      ..fillStyle = '#00a4e4'
      ..font = '60pt Arial'
      ..strokeText(score, _width / 2 - 300, _height / 2 + 200)
      ..fillText(score, _width / 2 - 300, _height / 2 + 200);
    } else {
      _context
      ..lineWidth = 2
      ..strokeStyle = '#0081c6'
      ..fillStyle = '#00a4e4'
      ..font = '20pt Arial'
      ..strokeText(score, 10, 40)
      ..fillText(score, 10, 40);
    }
  }
}