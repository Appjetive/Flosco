import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/gestures.dart';

import 'actor/collector.dart';
import 'actor/meteor.dart';
import 'component/background.dart';
import 'component/start_button.dart';
import 'core/spawner.dart';
import 'core/utils.dart';
import 'screen/home.dart';
import 'screen/screens.dart';

class FloscoGame extends BaseGame {
  Background background;

  Screens currentScreen = Screens.home;
  HomeScreen homeScreen;
  StartButton startButton;

  Size screenSize;
  double tileSize;
  var boxSize = GameUtils.boxSizeInTiles(1339, 1080);

  TextConfig textConfig = TextConfig(
    color: BasicPalette.white.color,
    fontSize: 32.0,
  );

  double creationTimer = 0.0;
  bool gamePaused = false;
  bool gameStarted = false;
  bool gameFinished = false;

  Spawner spawner;
  Collector collector;

  // Rocks and Elements List
  List<Meteor> meteors;

  FloscoGame() {
    collector = Collector(this);
    initialize();
  }

  initialize() async {
    meteors = List<Meteor>();
    resize(await Flame.util.initialDimensions());

    background = Background(this);
    homeScreen = HomeScreen(this);
    startButton = StartButton(this);
    spawner = Spawner(this);
  }

  @override
  render(Canvas canvas) {
    background.render(canvas);

    switch (currentScreen) {
      case Screens.home:
//        homeScreen.render(canvas);
        break;
      default:
    }

    if (currentScreen == Screens.home || currentScreen == Screens.lost) {
//      startButton.render(canvas);
    }
    collector.render(canvas);

    meteors.forEach((meteor) => meteor.render(canvas));
    textConfig.render(
      canvas,
      'Score 0',
      Position(this.size.width.toInt() - 200.0, 10),
    );

    super.render(canvas);
  }

  @override
  update(double t) {
    collector.update(t);
    spawner.update(t);
    meteors.forEach((meteor) => meteor.update(t));

    super.update(t);
  }

  @override
  resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / GameUtils.gameWidthTiles;

    background?.resize();
    collector?.resize(size);
    meteors.forEach((meteor) => meteor?.resize(size));

    super.resize(size);
  }

  @override
  onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    bool isHandled = false;

    collector.move(details);

    /*if (!isHandled && startButton.rect.contains(details.globalPosition)) {
      if (currentScreen == Screens.home || currentScreen == Screens.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }*/
  }

  onDragUpdate(DragUpdateDetails details) {
    collector.move2(details);
  }

  onDragEnd(DragEndDetails details) {
    collector.stopMove(details);
  }
}
