import 'package:hive/hive.dart';

part 'typSettings.g.dart';

@HiveType(typeId: 1)
class typSettings {
  @HiveField(0)
  bool flgBgm;

  @HiveField(1)
  bool flgControlRight;

  @HiveField(2)
  double volumeBgm;

  @HiveField(3)
  double volumeSe;

  @HiveField(4)
  double jerkSense;

  @HiveField(5)
  double makiSense;

  typSettings({
    required this.flgBgm,
    required this.flgControlRight,
    required this.volumeBgm,
    required this.volumeSe,
    required this.jerkSense,
    required this.makiSense,
  });
}
