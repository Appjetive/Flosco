import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:mobile/game/core/utils.dart';
import 'package:mobile/game/flosco_game.dart';

class Background {
  final FloscoGame game;
  Rect bgRect;
  Sprite bgSprite;

  Background(this.game) {
    bgSprite = Sprite('background.png');
  }

  render(Canvas canvas) {
    bgSprite.renderRect(canvas, bgRect);
  }

  resize() {
    bgRect = Rect.fromLTWH(
      0,
      0,
      game.tileSize * GameUtils.gameWidthTiles,
      game.tileSize * game.boxSize.height,
    );
  }

  update(double t) {}
}
