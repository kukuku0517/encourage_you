import 'dart:math';

import 'package:encourage_you/MyTheme.dart';
import 'package:encourage_you/Util.dart';
import 'package:encourage_you/bloc/BlocProvider.dart';
import 'package:encourage_you/bloc/ListBloc.dart';
import 'package:encourage_you/data/DayItem.dart';
import 'package:encourage_you/data/StickerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:toast/toast.dart';

import 'DayDecorDumbbellItemButton.dart';
import 'DayDecorHeartItemButton.dart';
import 'DayDecorKettleItemButton.dart';
import 'DayDecorStairItemButton.dart';
import 'DayItemButton.dart';
import 'StickerButton.dart';

class ListPage extends StatelessWidget {
  static const routeName = '/list';

  ListBloc _bloc = ListBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListBloc>(
        init: () => _bloc.init(),
        bloc: _bloc,
        child: Scaffold(
            backgroundColor: myColor.black,
            appBar: AppBar(
              backgroundColor: myColor.black,
              title: Builder(
                builder: (context) => StreamBuilder(
                    stream: BlocProvider.of<ListBloc>(context).dateStream,
                    builder: (context, snapshot) {
                      DateTime date = snapshot.data;
                      if (date == null) return Empty();

                      return Text("${date.month}월",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .apply(color: myColor.orange));
                    }),
              ),
              actions: [
                Builder(
                  builder: (context) => StreamBuilder(
                      stream: BlocProvider.of<ListBloc>(context).listStream,
                      builder: (context, snapshot) {
                        List<DayItem> dayItems = snapshot.data;
                        if (dayItems == null) return Empty();

                        return Text(
                          "완료: ${dayItems.where((e) => e.sticker != null).length}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .apply(color: myColor.orange),
                        );
                      }),
                )
              ],
            ),
            body: NestedScrollView(
              reverse: false,
              headerSliverBuilder: (context, value) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      GestureDetector(
                        onTap: () {
                          _bloc.init();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("너의\n오늘을\n응원해",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline1),
                        ),
                      ),
                    ]),
                  ),
                ];
              },
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Builder(
                            builder: (context) => StreamBuilder(
                                stream: BlocProvider.of<ListBloc>(context)
                                    .listStream,
                                builder: (context, snapshot) {
                                  List<DayItem> dayItems = snapshot.data;
                                  if (dayItems == null) return Text("Loading");

                                  List<DayItem> adjustedItems = [];
                                  adjustedItems.addAll(dayItems);
                                  adjustedItems.insert(
                                      2,
                                      DayDecorIconItem(
                                          path: "assets/images/kettle.png"));
                                  adjustedItems.insert(
                                      5,
                                      DayDecorTextItem(
                                          type: DecorType.EDGE,
                                          text: "GO AHEAD",
                                          size: 3,
                                          direction: 1));
                                  adjustedItems.insert(
                                      7,
                                      DayDecorIconItem(
                                          path: "assets/images/dumbbell.png"));
                                  adjustedItems.insert(
                                      12,
                                      DayDecorTextItem(
                                          type: DecorType.ROUND,
                                          text: "KEEP",
                                          size: 2));
                                  adjustedItems.insert(
                                      13,
                                      DayDecorTextItem(
                                          type: DecorType.ROUND,
                                          text: "GOING",
                                          size: 2,
                                          direction: 1));
                                  adjustedItems.insert(
                                      16,
                                      DayDecorTextItem(
                                          type: DecorType.PLAIN,
                                          text: "BE THE BEST VERSION OF YOU",
                                          size: 4));

                                  adjustedItems.insert(
                                      21,
                                      DayDecorIconItem(
                                          size: 2,
                                          path: "assets/images/stair.png"));

                                  adjustedItems.insert(
                                      27,
                                      DayDecorIconItem(
                                          path: "assets/images/heart.webp"));

                                  return StaggeredGridView.countBuilder(
                                    crossAxisCount: 4,
                                    scrollDirection: Axis.vertical,
                                    itemCount: adjustedItems.length,
                                    staggeredTileBuilder: (index) {
                                      var item = adjustedItems[index];
                                      if (item is DayDecorTextItem) {
                                        return StaggeredTile.count(
                                            item.size, 1);
                                      } else if (item is DayDecorIconItem) {
                                        return StaggeredTile.count(
                                            item.size, 1);
                                      } else {
                                        return StaggeredTile.count(1, 1);
                                      }
                                    },
                                    itemBuilder: (context, index) {
                                      var dayItem = adjustedItems[index];
                                      if (dayItem is DayDecorTextItem) {
                                        return getDecorItemButton(dayItem);
                                      } else if (dayItem is DayDecorIconItem) {
                                        return getDecorIconItemButton(dayItem);
                                      } else {
                                        final stickerPadding = 15;
                                        return Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            DayItemButton(
                                                dayItem: dayItem,
                                                callback: () {
                                                  showStickerModal(
                                                      context, dayItem);
                                                }),
                                            dayItem.sticker != null
                                                ? StickerButton(
                                                    stickerItem:
                                                        dayItem.sticker)
                                                : Empty()
                                          ],
                                        );
                                      }
                                    },
                                  );
                                }))),
                  ),
                ],
              ),
            )));
  }

  StatelessWidget getDecorItemButton(DayDecorTextItem dayItem) {
    switch (dayItem.type) {
      case DecorType.PLAIN:
        return DayDecorPlainItemButton(item: dayItem);
        break;
      case DecorType.EDGE:
        return DayDecorEdgeItemButton(item: dayItem);
        break;
      case DecorType.ROUND:
        return DayDecorRoundItemButton(item: dayItem);
        break;
      default:
        return Text("");
    }
  }

  Widget getDecorIconItemButton(DayDecorIconItem dayItem) {
    if (dayItem.path.contains("kettle")) {
      return DayDecorKettleItemButton(item: dayItem);
    } else if (dayItem.path.contains("dumbbell")) {
      return DayDecorDumbbellItemButton(item: dayItem);
    } else if (dayItem.path.contains("heart")) {
      return DayDecorHeartItemButton(item: dayItem);
    } else {
      return DayDecorStairItemButton();
    }
  }

  void showStickerModal(BuildContext context, DayItem item) {
    var stickers = [
      StickerItem(
          shape: Random().nextInt(3), color: myColor.orange, text: "수고했어"),
      StickerItem(
          shape: Random().nextInt(3), color: myColor.orange, text: "수고했어"),
      StickerItem(
          shape: Random().nextInt(3), color: myColor.orange, text: "수고했어"),
      StickerItem(shape: Random().nextInt(3), color: Colors.red, text: "수고했어"),
      StickerItem(shape: Random().nextInt(3), color: Colors.red, text: "수고했어"),
      StickerItem(shape: Random().nextInt(3), color: Colors.red, text: "수고했어"),
      StickerItem(shape: Random().nextInt(3), color: Colors.red, text: "수고했어"),
      StickerItem(shape: Random().nextInt(3), color: Colors.grey, text: "수고했어"),
      StickerItem(shape: Random().nextInt(3), color: Colors.grey, text: "수고했어"),
      StickerItem(shape: Random().nextInt(3), color: Colors.grey, text: "수고했어"),
      StickerItem(shape: Random().nextInt(3), color: Colors.grey, text: "수고했어"),
    ];
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: myColor.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "\"운동을 해낸 오늘의 나에게\n어떤 말을 해주고 싶나요?\"",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .apply(color: myColor.black, fontWeightDelta: 2),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemCount: stickers.length,
                        itemBuilder: (context, index) {
                          var sticker = stickers[index];
                          return StickerButton(
                            stickerItem: sticker,
                            callback: () {
                              Navigator.pop(context);
                              Toast.show(sticker.toString(), context);
                              _bloc.setSticker(sticker, item);
                            },
                          );
                        }),
                  ),
                ],
              ));
        });
  }
}
