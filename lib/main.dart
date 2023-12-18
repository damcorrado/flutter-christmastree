import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xmastree/page_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // Fix to portrait mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Set to fullscreen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return MaterialApp(
      title: 'Xmas Tree',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}


