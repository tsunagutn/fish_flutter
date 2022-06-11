import 'package:hive/hive.dart';

part 'typLureData.g.dart';

enum enumLureDiv {
  tairaba,
  jig,
  slowjig,
}

@HiveType(typeId: 5)
class typLureData extends HiveObject {
  @HiveField(0)
  int lureId; //0:タイラバ 1:ジグ 2:スロージグ

  @HiveField(1)
  String name; //名前

  @HiveField(2)
  String image; //画像ファイル名

  @HiveField(3)
  int lv; //現在のレベル

  @HiveField(4)
  double totalExp; //累計EXP

  @HiveField(5)
  int unLockweightid; //使用可能な重さID

  @HiveField(6)
  int useWeightId; //使用中重さID

  @HiveField(7)
  double fall; //フォール能力

  @HiveField(8)
  double reeling; //巻き能力

  @HiveField(9)
  double jerk; //ジャーク能力

  @HiveField(10)
  double lvAddFall; //1LV毎のフォール成長値

  @HiveField(11)
  double lvAddReeling; //1LV毎の巻き成長値

  @HiveField(12)
  double lvAddJerk; //1LV毎のジャーク成長値

  //コンストラクタ
  typLureData({
    required this.lureId,
    required this.name,
    required this.image,
    required this.lv,
    required this.totalExp,
    required this.unLockweightid,
    required this.useWeightId,
    required this.fall,
    required this.reeling,
    required this.jerk,
    required this.lvAddFall,
    required this.lvAddReeling,
    required this.lvAddJerk,
  });

}
