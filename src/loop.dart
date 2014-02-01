import 'dart:html';
import 'game.dart';
import 'renderer.dart';

class Loop {
  Game game;
  Renderer renderer;
  
  Loop(this.game, this.renderer);
  
  void run(){

    game.update();
    renderer.draw(game);
    
    window.animationFrame.then((_) => run());
  }
}