import 'package:hive/hive.dart';

part 'typGameData.g.dart';

@HiveType(typeId: 3)
class typGameData extends HiveObject {
  @HiveField(0)
  int gameId;

  @HiveField(1)
  int timeCount;

  @HiveField(2)
  int maxTimeCount;

  @HiveField(3)
  int point;

  @HiveField(4)
  double maxDepth;

  @HiveField(5)
  double windLevel;

  @HiveField(6)
  double maxWindLevel;

  @HiveField(7)
  double maxTension;

  @HiveField(8)
  double maxLineHp;

  @HiveField(9)
  double maxSpeed;

  @HiveField(10)
  bool isEnd;

  typGameData({
    required this.gameId,
    required this.timeCount,
    required this.maxTimeCount,
    required this.point,
    required this.maxDepth,
    required this.windLevel,
    required this.maxWindLevel,
    required this.maxTension,
    required this.maxLineHp,
    required this.maxSpeed,
    required this.isEnd,
  });
}
