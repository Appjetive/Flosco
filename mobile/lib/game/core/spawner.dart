import 'dart:math';

import 'package:mobile/game/actor/meteor.dart';
import 'package:mobile/game/flosco_game.dart';

class Spawner {
  final FloscoGame game;
  final int maxSpawnInterval = 2000;
  final int minSpawnInterval = 250;
  final int intervalChange = 3;
  final int maxObjectsOnScreen = 5;
  int currentInterval;
  int nextSpawn;

  final _random = Random();

  Spawner(this.game) {
    start();
  }

  void start() {
    destroyAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    if (nowTimestamp >= nextSpawn && game.meteors.length < maxObjectsOnScreen) {
      this.spawnElement();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }

  void spawnElement() {
    var dirProb = _random.nextBool();
    var yPosition = 0;
    var xPosition = 0;
    var speed = 50 + _random.nextInt(150);
    if (dirProb) {
      yPosition = game.size.height.toInt();

      xPosition = game.size.width.toInt() +
          _random.nextInt(game.size.width.toInt() - Meteor.meteorWidth.toInt());
    } else {
      yPosition = game.size.height.toInt() +
          _random
              .nextInt(game.size.height.toInt() - Meteor.meteorHeight.toInt());

      xPosition = game.size.width.toInt();
    }

    var directionY = 1;
    var directionX = 1;

    var directionProbY = _random.nextBool();
    var directionProbX = _random.nextBool();

    if (!directionProbY) {
      yPosition = (yPosition - game.size.height.toInt()) * -1;
      directionY = -1;
    }

    if (!directionProbX) {
      xPosition = (xPosition - game.size.width.toInt()) * -1;
      directionX = -1;
    }

    game.meteors
        .add(Meteor(game, xPosition, yPosition, directionY, directionX, speed));
  }

  void destroyAll() {
    game.meteors.forEach((meteor) => meteor.explode = true);
  }
}
