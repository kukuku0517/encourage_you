import 'package:json_annotation/json_annotation.dart';

import 'StickerItem.dart';

@JsonSerializable()
class DayItem {
  int date;
  StickerItem sticker;

  DayItem({this.date});
}
