import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// *** CONSTANTS ***
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
TextStyle footerTextStyle = const TextStyle(
  fontSize: 34,
  color: Colors.white,
  height: 1,
  fontFamily: 'Monofett',
);

const TextStyle bodyTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  fontFamily: 'CutiveMono',
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