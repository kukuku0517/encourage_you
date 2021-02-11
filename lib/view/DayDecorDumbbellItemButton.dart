
import 'package:encourage_you/MyTheme.dart';
import 'package:encourage_you/bloc/ListBloc.dart';
import 'package:flutter/cupertino.dart';


class DayDecorDumbbellItemButton extends StatefulWidget {
  final DayDecorIconItem item;

  DayDecorDumbbellItemButton({this.item});

  @override
  _DayDecorDumbbellItemButtonState createState() =>
      _DayDecorDumbbellItemButtonState();
}

class _DayDecorDumbbellItemButtonState extends State<DayDecorDumbbellItemButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
        debugLabel: "lalala")
      ..repeat(reverse: true)
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<Offset>(begin: Offset(0, .1), end: Offset(0, -.3))
        .animate(CurvedAnimation(
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
        child: SlideTransition(
          position: animation,
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
