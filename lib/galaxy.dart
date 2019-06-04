import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxygame/bullet.dart';
import 'package:galaxygame/dragon.dart';
import 'package:galaxygame/main.dart';

class Galaxy extends BaseGame {
  bool checkOnce = true;
  Random random;

  List<Dragon> dragonList = <Dragon>[];
  List<Bullet> bulletList = <Bullet>[];
  Size dimenstions;
  List<String> images = [
    'milenario.png',
    'tiefighter.png',
    'estrellamuerte2.png'
  ];
  Galaxy(this.dimenstions);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    String text = points.toString();
    TextPainter p = Flame.util
        .text(text, color: Colors.white, fontSize: 48.0, fontFamily: 'Halo');
    p.paint(canvas,
        new Offset(size.width - p.width - 10, size.height - p.height - 10));
  }

  double creationTimer = 0.0;
  double speedUpTimer = 0.0;
  @override
  void update(double t) {
    speedUpTimer += t;
    creationTimer += t;
    if (creationTimer >= 0.5) {
      random = new Random();
      creationTimer = 0.0;
      int startOfScreen = (2 * size.width / DRAGON_SIZE).round();
      double bubSize = random.nextDouble() * 240;
      int i = random.nextInt(3);
      int j = random.nextInt(images.length);
      //0 is top of screen
      dragon = new Dragon(dimenstions, i, 0, bubSize, images[j]);
      dragonList.add(dragon);
      add(dragon);

      if (speedUpTimer > 5) {
        //increase velocity each 5 seconds
        DragonSpeed *= 1.25;
        speedUpTimer = 0;
      }
    }
    super.update(t);
  }

  void tapInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    bulletStartStop = true;
    bulletList.add(bullet);
    bullet = new Bullet(dragonList, bulletList);
    add(bullet);
  }

  void dragInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    bulletStartStop = true;
  }

  void onUp() {
    bulletStartStop = false;
  }
}
