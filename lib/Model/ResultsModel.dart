enum enumResult {
  success,
  bare,
  cut,
}

class ResultsModel {
  late List<FishResultModel> lstResults = [];

  // //コンストラクタ
  // ResultsModel({
  //   required this.fishResults,
  // });
}

class FishResultModel {
  int fishId;
  double size;
  double depth;
  double maxDepth;
  enumResult resultKbn;

  //コンストラクタ
  FishResultModel({
    required this.fishId,
    required this.size,
    required this.depth,
    required this.maxDepth,
    required this.resultKbn,
  });
}
