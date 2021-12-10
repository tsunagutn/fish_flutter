import 'package:fish_flutter/Model/FishModel.dart';

//釣果全体のモデル
class FishesResultModel {
  late List<FishResultModel> listFishResult;
  //コンストラクタ
  FishesResultModel() {
    listFishResult = [];
  }

  //釣果の追加
  addResult(int fishId, double size) {
    FishResultModel fishResult =
        new FishResultModel(fishId: fishId, size: size);
    listFishResult.add(fishResult);
  }

  //釣果の最小サイズを返す
  double getMinSize(int fishId) {
    var minSize = 1.1;
    listFishResult.forEach((val) {
      if (minSize > val.size) {
        minSize = val.size;
      }
    });
    if (minSize == 1.1) minSize = 0.0;
    return minSize;
  }

  //釣果の最大サイズを返す
  double getMaxSize(int fishId) {
    var maxSize = -0.1;
    listFishResult.forEach((val) {
      if (maxSize < val.size) {
        maxSize = val.size;
      }
    });
    if (maxSize == -0.1) maxSize = 0.0;
    return maxSize;
  }
}

//釣果単体のモデル
class FishResultModel {
  int fishId;
  double size; //0.0～1.0

  //コンストラクタ
  FishResultModel({
    required this.fishId,
    required this.size,
  });
}
