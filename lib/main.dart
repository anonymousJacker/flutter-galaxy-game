import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' show Colors, TextPainter, runApp;

import 'package:flame/game.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/flame.dart';

const SPEED = 20.0;
const CRATE_SIZE = 25.0;

var points = 0;
Dragon dragon;
Bullet bullet;


var game;

main() async {
  Flame.audio.disableLog();
  Flame.images.loadAll(['fire.png', 'dragon.png', 'gun.png', 'bullet.png']);

  game = new MyGame();
  runApp(game.widget);

  Flame.audio.loop('music.ogg');
  HorizontalDragGestureRecognizer gestureRecognizer =
      new HorizontalDragGestureRecognizer();

// Adds ondrag feature to fire bullets
  Flame.util.addGestureRecognizer(gestureRecognizer
    ..onUpdate = (startDetails) => game.input(startDetails.globalPosition));



//  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
//    ..onTapDown = (TapDownDetails evt) => game.input(evt.globalPosition));
}

class Dragon extends SpriteComponent {
  bool explode = false;
  double maxY;

  Dragon() : super.square(CRATE_SIZE, 'dragon.png');


  @override
  void update(double t) {
    y += t * SPEED;

//    print("y -> ${y}");
    if(game!=null&&dragon!=null&&bullet!=null && y>0.0) {
//      print("bullet.toPosition().toOffset() -> ${bullet.toPosition().toOffset()}");
//      print("dragon.toRect().toString() -> ${dragon.toRect().toString()}");
      bool remove = dragon.toRect().contains(bullet.toPosition().toOffset());
      if (remove) {
        dragon.explode = true;
        game.add(new Explosion(dragon));
      }
    }

  }

  @override
  bool destroy() {


    if (explode) {
      print("exploded");
      return true;
    }
    if (y == null || maxY == null) {
      return false;
    }
    bool destroy = y >= maxY + CRATE_SIZE / 2;
    if (destroy) {
//      points -= 20;
//      Flame.audio.play('miss.mp3');
    }
    return destroy;
//    bool destroy = this.y==this.maxY;
//    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = size.width / 2;
    this.y = 0.0;
    this.maxY = size.height;
  }
}

class Bullet extends SpriteComponent {
  bool explode = false;
  double maxY;



  Bullet() : super.square(CRATE_SIZE, 'bullet.png');
//  {
//
//    bulletPositionDx=bullet.x;
//    bulletPositionDy = bullet.y;
//  }

  @override
  void update(double t) {
    y -= t * SPEED;

  }

  @override
  bool destroy() {
    if (explode) {
      return true;
    }
    if (y == null || maxY == null) {
      return false;
    }
    bool destroy = y >= maxY + CRATE_SIZE / 2;
    if (destroy) {
//      points += 20;
//      Flame.audio.play('miss.mp3');
    }
    return destroy;
  }



  @override
  void resize(Size size) {
    this.x = size.width / 2;
    this.y = size.height;
    this.maxY = size.height;
  }
}

class Explosion extends AnimationComponent {
  static const TIME = 0.75;

  Explosion(Dragon dragon)
      : super.sequenced(CRATE_SIZE, CRATE_SIZE, 'explosion-4.png', 7,
            textureWidth: 31.0, textureHeight: 31.0) {
    this.x = dragon.x;
    this.y = dragon.y;
    this.animation.stepTime = TIME / 7;
  }

  bool destroy() {
    return this.animation.isLastFrame;
  }
}

Random rnd = new Random();

double touchPositionDx = 0.0;
double touchPositionDy = 0.0;

double bulletPositionDx = 0.0;
double bulletPositionDy = 0.0;

class MyGame extends BaseGame {
  double creationTimer = 0.0;
bool checkOnce =true;
  @override
  void render(Canvas canvas) {
    super.render(canvas);

//    print("rendered");
    String text = points.toString();
    TextPainter p = Flame.util
        .text(text, color: Colors.white, fontSize: 48.0, fontFamily: 'Halo');
    p.paint(canvas,
        new Offset(size.width - p.width - 10, size.height - p.height - 10));
  }




  @override
  void update(double t) {
//    creationTimer += t;
//    if (creationTimer >= 20) {
//      creationTimer = 0.0;
  if(checkOnce) {
    checkOnce=false;

    bullet =new Bullet();
    dragon = new Dragon();
    add(dragon);
    add(bullet);

//    components.forEach((component) {
//      print("component -> ${component.toString()}");
//      if (!(component is Dragon)&&!(component is Bullet)) {
//        return;
//      }
//      if(component is Dragon){
//        dragon = component;
//
//      }else{
//        bullet = component as Bullet;
//      }
//      if(dragon!=null&&bullet!=null) {
//        print("bullet.toPosition().toOffset() -> ${bullet.toPosition().toOffset()}");
//        bool remove = dragon.toRect().contains(bullet.toPosition().toOffset());
//        if (remove) {
//          dragon.explode = true;
//          add(new Explosion(dragon));
//        }
//      }
//    });

  }
//    }
    super.update(t);
  }

  void input(Offset position) {
    print("direction: ${position.direction}");
//    touchPositionDx = position.dx;
//    touchPositionDy = position.dy;

//    components.forEach((component) {
//      if (!(component is Crate)) {
//        return;
//      }
//      Crate crate = component as Crate;
//      bool remove = crate.toRect().contains(position);
//      if (remove) {
//        crate.explode = true;
//        add(new Explosion(crate));
//        Flame.audio.play('explosion.mp3');
//        points += 10;
//      }
//    });
  }
}