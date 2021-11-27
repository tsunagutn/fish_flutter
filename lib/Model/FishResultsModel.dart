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

  //釣果の最大サイズを返す
  double getMaxSize(int fishId) {
    var maxSize = 0.0;
    //まだつくってない
    return maxSize;
  }
}

//釣果単体のモデル
class FishResultModel {
  int fishId;
  double size;

  //コンストラクタ
  FishResultModel({
    required this.fishId,
    required this.size,
  });
}
