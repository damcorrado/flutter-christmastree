import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xmastree/includes/tree.utils.dart';
import 'package:xmastree/widgets/page_settings.dart';
import 'package:xmastree/widgets/snowfall.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Timer _timer;
  late SharedPreferences prefs;
  bool snowEnabled = false;
  bool colorsEnabled = false;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {});
    });
    Future.delayed(Duration.zero).then((_) { init(); });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> init() async {
    // init shared preferences and retrieve values
    prefs = await SharedPreferences.getInstance();
    setState(() {
      snowEnabled = prefs.getBool(PREFS_SNOW_KEY) ?? false;
      colorsEnabled = prefs.getBool(PREFS_COLORS_KEY) ?? false;
      if (snowEnabled) playSound();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [

            // SNOWFALL
            if (snowEnabled) ...[
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

  // *** DRAW XMAS TREE ***
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
      style: treeBodyTextStyle.copyWith(
        color: colorsEnabled ? getRandomColor() : Colors.green,
      ),
    );
  }

  // *** DRAW FOOTER ***
  drawFooter() {
    String text = "Merry Christmas";
    return GestureDetector(
      onTap: () {
        setState(() {

          // Show the settings page
          Widget content = const SettingsPage();
          showModalBottomSheet(context: context,
            builder: (BuildContext context) {
              return content;
            },
          ).then((value) {
            init();
          });
        });
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: treeFooterTextStyle,
      ),
    );
  }
}
