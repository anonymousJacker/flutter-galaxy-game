import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flame/flame.dart';
import 'package:galaxygame/bullet.dart';
import 'package:galaxygame/dragon.dart';
import 'package:galaxygame/galaxy.dart';

bool gameOver = false;
const DRAGONSPEED = 30.0;
const BULLETSPEED = 260.0;
const DRAGON_SIZE = 240.0;
const BULLET_SIZE = 20.0;

var points = 0;
Dragon dragon;
Bullet bullet;

var game;

bool bulletStartStop = false;

double touchPositionDx = 0.0;
double touchPositionDy = 0.0;

main() async {
  Flame.audio.disableLog();
  Flame.images.loadAll(['fire.png', 'bub.png', 'gun.png', 'bullet.png']);

  var dimensions = await Flame.util.initialDimensions();

  game = new Galaxy(dimensions);
  runApp(MaterialApp(
      home: Scaffold(
          body: Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage("assets/images/sea.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: GameWrapper(game),
  ))));

  HorizontalDragGestureRecognizer horizontalDragGestureRecognizer =
      new HorizontalDragGestureRecognizer();

  Flame.util.addGestureRecognizer(horizontalDragGestureRecognizer
    ..onUpdate = (startDetails) => game.dragInput(startDetails.globalPosition));

  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => game.tapInput(evt.globalPosition));

  // Adds onUP feature to fire bullets
  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapUp = (TapUpDetails evt) => game.onUp(evt.globalPosition));
}

class GameWrapper extends StatelessWidget {
  final Galaxy game;
  GameWrapper(this.game);

  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}
