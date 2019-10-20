import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/game/flosco_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var util = Flame.util;

  await util.fullScreen();
  await util.setLandscape();

  Flame.images.loadAll([
    'background.jpg',
    'joystick_background.png',
    'joystick_knob.png',
  ]);

  FloscoGame game = FloscoGame();

  runApp(game.widget);

  // Tap events
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  util.addGestureRecognizer(tapper);

  // Drag events
  PanGestureRecognizer panDragger = PanGestureRecognizer();
  panDragger.onUpdate = game.onDragUpdate;
  panDragger.onEnd = game.onDragEnd;
  util.addGestureRecognizer(panDragger);
}
