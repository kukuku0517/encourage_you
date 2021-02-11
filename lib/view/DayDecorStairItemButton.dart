
import 'package:encourage_you/MyTheme.dart';
import 'package:encourage_you/bloc/ListBloc.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class DayDecorStairItemButton extends StatefulWidget {
  @override
  _DayDecorStairItemButtonState createState() =>
      _DayDecorStairItemButtonState();
}

class _DayDecorStairItemButtonState extends State<DayDecorStairItemButton>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  var progress = 0.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..repeat();

    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Curves.fastLinearToSlowEaseIn));

    controller.addListener(() {
      setState(() {
        this.progress = animation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: StairPainter(progress: progress),
      ),
    );
  }
}

class StairPainter extends CustomPainter {
  double progress = 0.0;

  StairPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2.0;
    final centerY = size.height / 2.0;
    // final centerOffset = Offset(centerX, centerY);

    var paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 0
      ..color = myColor.orange;

    final bottomLeft = Offset(30, size.height);
    final centerTop = Offset(centerX + 29, 0);
    final centerBottom = Offset(centerX + 29, size.height);
    final stairWidth = size.width / 6;
    final stairHeight = size.height / 3;

    canvas.drawRect(
        Rect.fromPoints(centerTop, Offset(size.width, size.height)), paint);

    var paths = List<Offset>();
    var curr = bottomLeft;
    paths.add(curr);
    curr = curr.translate(0, -stairHeight * (1.0 - progress));
    paths.add(curr);
    curr = curr.translate(stairWidth * (1 - progress), 0);
    paths.add(curr);

    while (curr.dx < centerTop.dx && curr.dy > centerTop.dy) {
      curr = Offset(curr.dx, math.max(curr.dy - stairHeight, centerTop.dy));
      paths.add(curr);
      curr = Offset(math.min(curr.dx + stairWidth, centerTop.dx), curr.dy);
      paths.add(curr);
    }
    paths.add(centerBottom);
    canvas.drawPath(Path()..addPolygon(paths, true), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
