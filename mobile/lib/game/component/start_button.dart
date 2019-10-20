import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:mobile/game/core/utils.dart';
import 'package:mobile/game/flosco_game.dart';
import 'package:mobile/game/screen/screens.dart';

class StartButton {
  final FloscoGame game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    var widthInTiles = GameUtils.tilesPerPixel(game.boxSize.width, 720);
    var heightInTiles = GameUtils.tilesPerPixel(game.boxSize.width, 360);
    var tileOffset = GameUtils.gameWidthTiles / widthInTiles;

    rect = Rect.fromLTWH(
      game.tileSize * tileOffset,
      (game.screenSize.height * 0.75) - (game.tileSize * tileOffset),
      game.tileSize * widthInTiles,
      game.tileSize * heightInTiles,
    );

    sprite = Sprite('start-button.png');
  }

  render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  update(double t) {}

  onTapDown() {
    game.currentScreen = Screens.game;
  }
}
