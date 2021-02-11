import 'package:encourage_you/MyTheme.dart';
import 'package:encourage_you/bloc/ListBloc.dart';
import 'package:flutter/cupertino.dart';

class DayDecorKettleItemButton extends StatefulWidget {
  final DayDecorIconItem item;

  DayDecorKettleItemButton({this.item});

  @override
  _DayDecorKettleItemButtonState createState() =>
      _DayDecorKettleItemButtonState();
}

class _DayDecorKettleItemButtonState extends State<DayDecorKettleItemButton>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this)
      ..repeat(reverse: true);

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linearToEaseOut,
    );

    // animation = IntTween(begin: 0, end:100).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return RotationTransition(
              turns: Tween(begin: -.1, end: .1).animate(animation),
              child: child,
            );
          },
          child: Container(
            alignment: Alignment.center,
            height: 60,
            width: 60,
            child: Image.asset(
              widget.item.path,
              color: myColor.orange,
            ),
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
