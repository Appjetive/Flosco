import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
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
  Collector collector;

  Size screenSize;
  double tileSize;
  var boxSize = GameUtils.boxSizeInTiles(1920, 1080);

  double creationTimer = 0.0;

  Spawner spawner;

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

    if (!isHandled && startButton.rect.contains(details.globalPosition)) {
      if (currentScreen == Screens.home || currentScreen == Screens.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }
  }

  onDragUpdate(DragUpdateDetails details) {
    collector.move(details);
  }

  onDragEnd(DragEndDetails details) {
    collector.stopMove(details);
  }
}
