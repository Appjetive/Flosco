import 'dart:math';
import 'dart:ui';

import 'package:flame/flare_animation.dart';
import 'package:mobile/game/flosco_game.dart';

enum MaterialType { Rock, Gold }

class Meteor {
  static const meteorWidth = 50.0;
  static const meteorHeight = 50.0;
  final _random = Random();

  final FloscoGame game;
  FlareAnimation animation;
  final int yPos;
  final int xPos;
  final int directionY;
  final int directionX;
  final int speed;

  bool isReady = false;
  bool explode = false;
  double maxX;

  Meteor(this.game, this.xPos, this.yPos, this.directionY, this.directionX,
      this.speed) {
    initialize();
  }

  initialize() async {
    var element = _random.nextBool();
    if (element) {
      animation = await FlareAnimation.load('assets/animations/asteroid.flr');
      animation.updateAnimation('Untitled');
    } else {
      animation =
          await FlareAnimation.load('assets/animations/space_trash.flr');
      animation.updateAnimation('Untitled');
    }
    animation.width = meteorWidth;
    animation.height = meteorHeight;
    animation.y = yPos.toDouble();
    animation.x = xPos.toDouble();
    isReady = true;
  }

  @override
  void render(Canvas canvas) {
    if (isReady) {
      animation.render(canvas);
    }
  }

  void update(double dt) {
    if (isReady) {
      animation.x -= dt * speed * this.directionX;
      animation.y -= dt * speed * this.directionY;
      animation.update(dt);

      bool destroy = animation.x < -(game.screenSize.width + meteorWidth * 2) ||
          animation.x > (game.screenSize.width + meteorWidth * 2) ||
          animation.y < -(game.screenSize.height + meteorHeight * 2) ||
          animation.y > (game.screenSize.height + meteorHeight * 2);

      if (destroy) {
        List<Meteor> newMeteors = [];
        game.meteors.forEach((meteor) {
          if (meteor != this) {
            newMeteors.add(meteor);
          }
        });
        game.meteors = newMeteors;
      }
    }
  }

  void resize(Size size) {
    if (isReady) {
      animation.y = yPos.toDouble();
      animation.x = size.width - meteorWidth;
    }

    maxX = size.width;
  }
}
