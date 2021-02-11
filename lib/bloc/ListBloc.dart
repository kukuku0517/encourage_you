import 'dart:async';
import 'package:encourage_you/bloc/Bloc.dart';
import 'package:encourage_you/data/DayItem.dart';
import 'package:encourage_you/data/StickerItem.dart';
import 'package:rxdart/rxdart.dart';

enum DecorType { PLAIN, EDGE, ROUND }

class DayDecorTextItem extends DayItem {
  DecorType type;
  String text;
  int size;

  int direction; //0= left, 1 = right

  DayDecorTextItem({this.type, this.text, this.size = 2, this.direction = 0});
}

class DayDecorIconItem extends DayItem {
  String path;
  int size;

  DayDecorIconItem({this.path, this.size = 1});
}

class ListBloc extends Bloc {
  final _listController = BehaviorSubject<List<DayItem>>();
  final _dateController = BehaviorSubject<DateTime>();

  Stream<List<DayItem>> get listStream => _listController.stream;
  Stream<DateTime> get dateStream => _dateController.stream;

  void init() {
    List<DayItem> list = [];
    Iterable<int>.generate(28)
        .toList()
        .forEach((i) => {list.add(DayItem(date: i))});
    _listController.sink.add(list);
    _dateController.sink.add(DateTime.now());
  }

  @override
  void dispose() {
    _listController.close();
    _dateController.close();
  }

  void setSticker(StickerItem sticker, DayItem item) {
    item.sticker = sticker;
    _listController.sink.add(_listController.value);
  }
}
