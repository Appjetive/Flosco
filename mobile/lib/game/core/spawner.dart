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
    var yPosition = _random.nextInt(
      game.size.height.toInt() - Meteor.meteorHeight.toInt(),
    );

    game.meteors.add(Meteor(game, yPosition));
  }

  void destroyAll() {
    game.meteors.forEach((meteor) => meteor.explode = true);
  }
}
