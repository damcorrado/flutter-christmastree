import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xmastree/includes/tree.utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SecondPageState createState() => SecondPageState();
}

class SecondPageState extends State<SettingsPage> {
  bool loading = true;
  bool snowEnabled = false;
  bool colorsEnabled = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      init();
    });
    super.initState();
  }

  Future<void> init() async {
    // init shared preferences and retrieve values
    prefs = await SharedPreferences.getInstance();
    setState(() {
      snowEnabled = prefs.getBool(PREFS_SNOW_KEY) ?? false;
      colorsEnabled = prefs.getBool(PREFS_COLORS_KEY) ?? false;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: buildContent(),
        ),
      ),
    );
  }

  Widget buildContent() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: false,
          pinned: false,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Xmas Settings', style: settingsTitleTextStyle),
          ),
          backgroundColor: Colors.transparent,
        ),
        if (loading) ...[
          // **** LOADER ****
          const SliverFillRemaining(
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ] else ...[
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    _onColorsChanged(!colorsEnabled);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Text(
                          "Enable lights",
                          style: settingsLabelTextStyle,
                        ),
                      ),
                      Checkbox(value: colorsEnabled, onChanged: _onColorsChanged),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _onSnowChanged(!snowEnabled);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Text(
                          "Enable snow",
                          style: settingsLabelTextStyle,
                        ),
                      ),
                      Checkbox(value: snowEnabled, onChanged: _onSnowChanged),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _onSnowChanged(bool? value) async {
    await prefs.setBool(PREFS_SNOW_KEY, value ?? false);
    setState(() {
      snowEnabled = value ?? false;
    });
  }

  Future<void> _onColorsChanged(bool? value) async {
    await prefs.setBool(PREFS_COLORS_KEY, value ?? false);
    setState(() {
      colorsEnabled = value ?? false;
    });
  }
}
