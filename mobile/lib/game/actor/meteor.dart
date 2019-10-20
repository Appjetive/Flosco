import 'dart:ui';

import 'package:flame/flare_animation.dart';
import 'package:mobile/game/flosco_game.dart';

class Meteor {
  static const meteorWidth = 50.0;
  static const meteorHeight = 50.0;
  static const speed = 100.0;

  final FloscoGame game;
  FlareAnimation animation;
  final int yPos;

  bool isReady = false;
  bool explode = false;
  double maxX;

  Meteor(this.game, this.yPos) {
    initialize();
  }

  initialize() async {
    animation =
        await FlareAnimation.load('assets/animations/meteor_animation.flr');
    animation.updateAnimation('meteor_animation');
    animation.width = meteorWidth;
    animation.height = meteorHeight;
    animation.y = yPos.toDouble();
    animation.x = game.size.width - meteorWidth;
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
      animation.x -= dt * speed;
      animation.update(dt);

      bool destroy = animation.x < 0;

      if (destroy) {
        game.meteors.remove(this);
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
