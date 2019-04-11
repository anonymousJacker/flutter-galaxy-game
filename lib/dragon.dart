import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:galaxygame/explosion.dart';
import 'package:galaxygame/main.dart';

class Dragon extends SpriteComponent {
  Size dimenstions;
  int postion;
  int ypostion;
  bool explode = false;
  double maxY;
  double bubSize ;
 
Dragon(this.dimenstions, this.postion, this.ypostion, this.bubSize)
      : super.square(bubSize, 'bub.png');
void setBubSize (double bub){
  bubSize = bub;
}
  @override
  void update(double t) {
    y -= (t * DRAGONSPEED);
  }

  @override
  bool destroy() {
      if (explode) {
      return true;
    }
    if (y == null || maxY == null) {
      return false;
    }
    bool destroy = false;
    if (destroy) {
      gameOver = true;

      print("Game over");
      return true;
    }
    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = (DRAGON_SIZE * postion);
    this.y = DRAGON_SIZE * ypostion;
    this.maxY = size.height;
  }
}
