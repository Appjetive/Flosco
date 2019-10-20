import 'dart:ui';

import 'package:flame/components/flare_component.dart';
import 'package:flutter/gestures.dart';
import 'package:mobile/game/flosco_game.dart';

class Collector extends FlareComponent {
  static const collectorWidth = 90.0;
  static const collectorHeight = 40.0;
  static const speed = 80.0;

  final FloscoGame game;
  bool canMove = false;
  Offset nextDelta;
  double maxWidth;
  double maxHeight;
  double minHeight;

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
    if (canMove) {
      var xPoint = this.x + nextDelta.dx * (speed * t);
      var yPoint = this.y + nextDelta.dy * (speed * t);

      if (xPoint < maxWidth && xPoint > 0) {
        this.x = xPoint;
      }

      if (yPoint < maxHeight && yPoint > minHeight) {
        this.y = yPoint;
      }
    }
    super.update(t);
  }

  void move(DragUpdateDetails details) {
    nextDelta = details.delta;
    canMove = true;
  }

  void stopMove(DragEndDetails details) {
    canMove = false;
  }
}
