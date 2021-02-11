import 'package:encourage_you/data/StickerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'StarPainter.dart';

const stickerSize = 70.0;

class StickerButton extends StatelessWidget {
  final StickerItem stickerItem;
  final VoidCallback callback;

  StickerButton({this.stickerItem, this.callback});

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
            getDecoration(stickerItem.shape, stickerItem.color),
            Text(
              stickerItem.text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .apply(fontWeightDelta: 4),
            )
          ],
        ),
      ),
    );
  }

  Widget getDecoration(int shape, Color color) {
    switch (shape) {
      case 0:
        return Container(
          width: stickerSize,
          height: stickerSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            color: color,
          ),
        );

        break;
      case 1:
        return Container(
            width: stickerSize,
            height: stickerSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: color,
            ));
        break;
      case 2:
        final scale = 1.3;
        return Container(
            width: scale * stickerSize,
            height: scale * stickerSize,
            child:
            CustomPaint(painter: StarPainter(style: PaintingStyle.fill)));

        break;
    }
  }
}