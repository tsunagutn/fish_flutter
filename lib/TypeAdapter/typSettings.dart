import 'package:hive/hive.dart';

part 'typSettings.g.dart';

@HiveType(typeId: 1)
class typSettings {
  @HiveField(0)
  bool flgBgm;  //BGM有無

  @HiveField(1)
  bool flgControlRight; //操作系左右

  @HiveField(2)
  double volumeBgm; //BGMボリューム

  @HiveField(3)
  double volumeSe;  //SEボリューム

  @HiveField(4)
  double jerkSense; //ジャーク感度

  @HiveField(5)
  double makiSense; //巻き感度

  @HiveField(6)
  bool isReversal;  //上下操作の反転有無

  @HiveField(7)
  bool isVibe;  //バイブレーション有無

  typSettings({
    required this.flgBgm,
    required this.flgControlRight,
    required this.volumeBgm,
    required this.volumeSe,
    required this.jerkSense,
    required this.makiSense,
    required this.isReversal,
    required this.isVibe,
  });
}
