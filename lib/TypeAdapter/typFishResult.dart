import 'package:hive/hive.dart';

part 'typFishResult.g.dart';

@HiveType(typeId: 4)
class typFishResult extends HiveObject {
  @HiveField(0)
  int fishId;

  @HiveField(1)
  double size;

  @HiveField(2)
  double depth;

  @HiveField(3)
  double maxDepth;

  @HiveField(4)
  int resultKbn;

  typFishResult({
    required this.fishId,
    required this.size,
    required this.depth,
    required this.maxDepth,
    required this.resultKbn,
  });
}
