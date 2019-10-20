import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:mobile/game/core/utils.dart';
import 'package:mobile/game/flosco_game.dart';

class HomeScreen {
  final FloscoGame game;
  Rect titleRect;
  Sprite titleSprite;

  HomeScreen(this.game) {
    var widthInTiles = GameUtils.tilesPerPixel(game.boxSize.width, 840);
    var heightInTiles = GameUtils.tilesPerPixel(game.boxSize.width, 480);
    var tileOffset = GameUtils.gameWidthTiles / widthInTiles;

    titleRect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * heightInTiles),
      game.tileSize * widthInTiles,
      game.tileSize * heightInTiles,
    );
//    titleSprite = Sprite('title.png');
  }

  render(Canvas canvas) {
    titleSprite.renderRect(canvas, titleRect);
  }

  update(double t) {}
}
