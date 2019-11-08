import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:galaxygame/main.dart';

class Dragon extends SpriteComponent {
  Size dimenstions;
  String image;
  int postion;
  int ypostion;
  bool explode = false;
  double maxY;
  double bubSize;

  Dragon(
      this.dimenstions, this.postion, this.ypostion, this.bubSize, this.image)
      : super.square(bubSize, image);

  void setBubSize(double bub) {
    bubSize = bub;
  }

  double resizeTime = 0.0;
  @override
  void update(double t) {
    y += (t * DRAGON_SPEED);
    if (resizeTime < 1) {
      height = this.dimenstions.height + 30 * t;
      width = this.dimenstions.width + 30 * t;
     
    } else if (resizeTime > 2) {
      resizeTime = 0.0;
    } else {
      height = this.dimenstions.height - 30 * t;
      width = this.dimenstions.width - 30 * t;
    }
  }

  @override
  bool destroy() {
    if (y >= maxY + DRAGON_SIZE / 2) {
      //se sale de la pantalla 
      points = 0;
      return true;
    }

    if (y == null || maxY == null) {
      return false;
    }
    return false;
  }

  @override
  void resize(Size size) {
    this.x = (DRAGON_SIZE * postion);
    this.y = DRAGON_SIZE * ypostion;
    this.maxY = size.height;
    this.dimenstions = Size(width, height);
  }
}
