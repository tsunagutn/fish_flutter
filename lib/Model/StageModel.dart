//ステージマスタ
class StagesModel {
  late List<StageModel> stages = [];
  //コンストラクタ
  StagesModel() {
    //シーダーみたいなやつ
    stages.add(new StageModel(
      id: 1,
      name: "益田沖",
      startDepth: 40.0,
      maximumDepth: 1000.0,
      windLevel: 0.7,
      tutorial: false,
    ));
  }

  StageModel getStageData(int id) {
    return stages.firstWhere((element) => element.id.compareTo(id) == 0);
  }
}

class StageModel {
  int id; //一意識別キー
  String name; //名前
  double startDepth; //スタート水深
  double maximumDepth; //ゴール水深
  double windLevel; //風レベル
  bool tutorial;  //チュートリアル

  //コンストラクタ
  StageModel({
    required this.id,
    required this.name,
    required this.startDepth,
    required this.maximumDepth,
    required this.windLevel,
    required this.tutorial,
  });
}
