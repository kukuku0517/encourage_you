
import 'package:encourage_you/MyTheme.dart';
import 'package:encourage_you/bloc/ListBloc.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class DayDecorHeartItemButton extends StatefulWidget {
  final DayDecorIconItem item;

  DayDecorHeartItemButton({this.item});

  @override
  _DayDecorHeartItemButtonState createState() =>
      _DayDecorHeartItemButtonState();
}

class _DayDecorHeartItemButtonState extends State<DayDecorHeartItemButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
        debugLabel: "lalala")
      ..repeat(reverse: true)
      ..addListener(() {
        setState(() {});
      });
    animation = Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.elasticIn,
    ));
    // animation = IntTween(begin: 0, end:100).animate(controller);
    // controller.animateWith(animation);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 60,
                child: Image.asset(
                  widget.item.path,
                  color: myColor.orange,
                ),
              ),
            ),
            SizedBox(
                width: 60,
                height: 60,
                child: CustomPaint(painter: HeartBeat())),
          ],
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class HeartBeat extends CustomPainter {
  var height = [0, 0, -1, 2, -3, 5, -8, 6, 0, 1, 0];
  static var a = 0;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2.0;
    final centerY = size.height / 2.0;
    // final centerOffset = Offset(centerX, centerY);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = myColor.black;

    var beats = List<Offset>();
    var count = 10.0;

    for (int i = 0; i < height.length; i++) {
      beats.add(Offset(i * size.width / count, height[i] + centerY));
    }

    // var start = a % height.length;
    // var end =  (a + 5 > height.length) ? (a + 5) % height.length : a +5;
    // var sub = beats.sublist(start, math.max(start,math.min(end, height.length)));
    // a++;
    // a %= height.length;

    canvas.drawPath(Path()..addPolygon(beats, false), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
