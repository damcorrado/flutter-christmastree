import 'dart:math';

import 'package:flutter/material.dart';

class Snowfall extends StatefulWidget {

  final double width;
  final double height;

  const Snowfall({super.key, required this.width, required this.height});

  @override
  SnowfallState createState() => SnowfallState();
}

class SnowfallState extends State<Snowfall> with TickerProviderStateMixin {
  late List<Snowflake> snowflakes;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    snowflakes = List.generate(100, (index) => Snowflake());
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: SnowfallPainter(snowflakes, animationController),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class SnowfallPainter extends CustomPainter {
  final List<Snowflake> snowflakes;
  final AnimationController animationController;

  SnowfallPainter(this.snowflakes, this.animationController) : super(repaint: animationController);

  @override
  void paint(Canvas canvas, Size size) {
    for (var snowflake in snowflakes) {
      snowflake.update(size);
      snowflake.draw(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Snowflake {
  late double x;
  late double y;
  late double size;
  late double fallSpeed;
  late int alpha;

  Snowflake() {
    reset();
  }

  void reset() {
    x = Random().nextDouble();
    y = Random().nextDouble();
    size = Random().nextDouble() * 3.0 + 1.0;
    fallSpeed = Random().nextDouble() * 0.5 + 0.2;
    alpha = Random().nextInt(255) + 1;
  }

  void update(Size size) {
    y += fallSpeed;

    if (y > size.height) {
      y = 0;
      reset();
    }
  }

  void draw(Canvas canvas, Size canvasSize) {
    final paint = Paint()..color = Colors.white.withAlpha(alpha);
    canvas.drawCircle(Offset(x * canvasSize.width, y), size, paint);
  }
}