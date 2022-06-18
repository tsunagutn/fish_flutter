import 'package:fish_flutter/TypeAdapter/typGameData.dart';
import 'package:hive/hive.dart';

part 'typHistory.g.dart';

@HiveType(typeId: 6)
class typHistory extends HiveObject {
  @HiveField(1)
  late HiveList<typGameData> lstGameDatas;

  //コンストラクタ
  typHistory();
}
