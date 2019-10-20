import 'dart:ui';

class GameUtils {
  static const gameWidthTiles = 9.0;

  static Size boxSizeInTiles(double width, double height) {
    var widthInTiles = width / gameWidthTiles;
    return Size(widthInTiles, height / widthInTiles);
  }

  static double tilesPerPixel(double gameTiles, double pixels) {
    return pixels / gameTiles;
  }
}
