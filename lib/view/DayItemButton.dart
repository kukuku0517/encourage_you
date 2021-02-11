import 'package:encourage_you/MyTheme.dart';
import 'package:encourage_you/bloc/ListBloc.dart';
import 'package:encourage_you/data/DayItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'StarPainter.dart';

const stickerSize = 70.0;

class DayItemButton extends StatelessWidget {
  final DayItem dayItem;
  final VoidCallback callback;

  const DayItemButton({this.dayItem, this.callback}) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          callback.call();
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            getDecoration(),
            Text(
              "${dayItem.date + 1}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }

  Widget getDecoration() {
    final shapeType = dayItem.date.hashCode % 3;

    switch (shapeType) {
      case 0:
        return Container(
          width: stickerSize,
          height: stickerSize,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                  width: 1,
                  color: myTheme.accentColor,
                  style: BorderStyle.solid)),
        );

        break;
      case 1:
        return Container(
            width: stickerSize,
            height: stickerSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                border: Border.all(
                    width: 1,
                    color: myTheme.accentColor,
                    style: BorderStyle.solid)));
        break;
      case 2:
        final scale = 1.3;
        return Container(
            width: scale * stickerSize,
            height: scale * stickerSize,
            child:
                CustomPaint(painter: StarPainter(style: PaintingStyle.stroke)));

        break;
    }
  }
}

class DayDecorPlainItemButton extends StatelessWidget {
  final DayDecorTextItem item;

  DayDecorPlainItemButton({this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        color: Theme.of(context).primaryColor,
        child: Marquee(
          text: item.text,
          style:
              Theme.of(context).textTheme.headline2.apply(color: myColor.black),
          blankSpace: 100,
        ),
      ),
    );
  }
}

class DayDecorEdgeItemButton extends StatelessWidget {
  final DayDecorTextItem item;

  DayDecorEdgeItemButton({this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        color: Theme.of(context).primaryColor,
        child: Marquee(
          text: item.text,
          style:
              Theme.of(context).textTheme.headline2.apply(color: myColor.black),
          blankSpace: 100,
        ),
      ),
    );
  }
}

class DayDecorRoundItemButton extends StatelessWidget {
  final DayDecorTextItem item;

  DayDecorRoundItemButton({this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: item.direction == 0
              ? BorderRadius.only(
                  topLeft: Radius.circular(40), bottomLeft: Radius.circular(40))
              : BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
          color: myColor.orange,
        ),
        child: Text(item.text,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline2
                .apply(color: myColor.black)),
      ),
    );
  }
}
