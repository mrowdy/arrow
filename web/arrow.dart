import 'dart:html';
import 'src/loop.dart';
import 'src/game.dart';
import 'src/renderer.dart';
import 'src/input.dart';

void main() {
  Element container = querySelector('#game');
  Renderer renderer = new Renderer(container, window.innerWidth, window.innerHeight);
  Input input = new Input(renderer.canvas);
  Game game = new Game(window.innerWidth.toDouble(), window.innerHeight.toDouble(), input);
  Loop loop = new Loop(game, renderer);
  loop.run();
}
