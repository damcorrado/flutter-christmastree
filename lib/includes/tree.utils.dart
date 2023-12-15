import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// *** CONSTANTS ***
const String PREFS_SNOW_KEY = "snow_enabled";
const String PREFS_COLORS_KEY = "colors_enabled";

final List<Color> colorsArray = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.white
];

// *** TEXT STYLES ***
TextStyle treeFooterTextStyle = const TextStyle(
  fontSize: 34,
  color: Colors.white,
  height: 1,
  fontFamily: 'Monofett',
);

const TextStyle treeBodyTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  fontFamily: 'CutiveMono',
);

const TextStyle settingsTitleTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.grey,
);

const TextStyle settingsLabelTextStyle = TextStyle(
  fontSize: 14,
  color: Colors.grey,
);

// *** FUNCTION TO GET A RANDOM COLOR ***
Color getRandomColor() {
  Random random = Random();
  int index = random.nextInt(colorsArray.length);
  return colorsArray[index];
}

void playSound() async {
  final AudioPlayer audioPlayer = AudioPlayer();
  String soundPath = 'audio/bells.mp3';
  await audioPlayer.play(AssetSource(soundPath));
}