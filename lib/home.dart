import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tree/includes/tree.utils.dart';
import 'package:tree/widgets/snowfall.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  bool snowfallEnabled = false;

  @override
  void initState() {
    // Enable fullscreen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [

            // SNOWFALL
            if (snowfallEnabled) ...[
              LayoutBuilder(
                builder: (context, constraints) {
                  return Snowfall(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  );
                },
              ),
            ],

            // BODY
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 60,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: drawText(),
                    ),
                    drawFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // *** DRAW CGRISTMAS TREE ***
  Widget drawText() {
    List<Widget> list = [];
    list.add(addRow("*"));
    list.add(addRow("if"));
    list.add(addRow("New"));
    list.add(addRow("Year="));

    list.add(addRow("'coming'"));
    list.add(addRow("then begin"));
    list.add(addRow("*** fireworks ***"));
    list.add(addRow("mode.safe; sound.max"));
    list.add(addRow("if (current_time == 00:00)"));
    list.add(addRow("Champagne.open(bubbles)"));
    list.add(addRow("class NewYear = happy"));
    list.add(addRow("end"));
    list.add(addRow("end"));
    list.add(addRow("end"));
    list.add(addRow("~~~~~~~~~~~~~~~~~~~"));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...list,
      ],
    );
  }

  // Returns a Text widget that represents a single row inside Column
  Widget addRow(String text) {
    return Text(
      text,
      style: bodyTextStyle.copyWith(
        color: getRandomColor(),
      ),
    );
  }

  // *** DRAW FOOTER ***
  drawFooter() {
    String text = "Merry Christmas";
    return GestureDetector(
      onTap: () {
        setState(() {
          snowfallEnabled = !snowfallEnabled;
          if (snowfallEnabled) playSound();
        });
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: footerTextStyle,
      ),
    );
  }
}
