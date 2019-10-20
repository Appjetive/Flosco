import 'dart:math';
import 'dart:ui';

import 'package:flame/components/flare_component.dart';
import 'package:flame/flare_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:mobile/game/flosco_game.dart';

class Collector extends FlareComponent {
  static const collectorWidth = 90.0;
  static const collectorHeight = 40.0;
  static const topSpeed = 180.0;
  static const deceleration = 150;
  static const acceleration = 180;

  final FloscoGame game;
  bool canMove = false;
  Offset nextDelta;
  double maxWidth;
  double maxHeight;
  double minHeight;

  double speed = 0;
  var lastMovedRadAngle = 90.0;
  FlareAnimation flareAnimation;

  Collector(this.game)
      : super(
          'assets/animations/rocket_animation.flr',
          'rocket_animation',
          collectorWidth,
          collectorHeight,
        );

  @override
  void resize(Size size) {
    this.x = game.tileSize * 0.05;
    this.y = (game.screenSize.height / 2) - (collectorHeight / 2);
    maxWidth = game.screenSize.width - collectorWidth;
    maxHeight = game.screenSize.height - collectorHeight;
    minHeight = collectorHeight / 2;

    super.resize(size);
  }

  @override
  void update(double t) {
    angle += 0.25 * t;
    angle %= 2 * pi;
    if (nextDelta != null && canMove) {
      var dx = nextDelta.dx - x;
      var dy = nextDelta.dy - y;

      var distance = sqrt(pow(dx, 2) + pow(dy, 2));
      var decDistance = pow(speed, 2) / (deceleration * 2);

      if (distance > decDistance) {
        speed = min(speed + acceleration * t, topSpeed);
      } else {
        speed = max(speed - deceleration * t, 0);
      }

      var angle = atan2(dy, dx);
      lastMovedRadAngle = angle;
      var cosangle = cos(angle);
      var sinangle = sin(angle);
      /*var rect = toRect();


      var diffBase =
          Offset(rect.center.dx + nextDelta.dx, rect.center.dy + nextDelta.dy) -
              rect.center;*/

      x += speed * cosangle * t;
      y += speed * sinangle * t;

      if (distance < speed * t) {
        x = nextDelta.dx;
        y = nextDelta.dy;
        speed = 0;
        canMove = false;
      }
    }
    super.update(t);
  }

  void move2(DragUpdateDetails details) {
    nextDelta = details.delta;
    canMove = true;
  }

  void move(TapDownDetails details) {
    nextDelta = details.globalPosition;
    canMove = true;
  }

  void stopMove(DragEndDetails details) {
    canMove = false;
  }
}
