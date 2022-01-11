//竿マスタ
class RodsModel {
  late List<RodModel> rods = [];

  //コンストラクタ
  RodsModel() {
    //シーダーみたいなやつ
    rods.add(new RodModel(
      id: -1,
      name: "もうない",
      image: "rod1.png",
      text: "もう最強です",
      prise: -1,
      maxTention: -1,
    ));

    rods.add(new RodModel(
      id: 0,
      name: "カンタンロッドA",
      image: "rod1.png",
      text: "最初の竿\n一番へぼい",
      prise: 0,
      maxTention: 200,
    ));
    rods.add(new RodModel(
      id: 1,
      name: "中級ロッドX",
      image: "rod2.png",
      text: "本格的船用ロッド\nカーボン含有率95％",
      prise: 500,
      maxTention: 500,
    ));
    rods.add(new RodModel(
      id: 2,
      name: "上級ロッドZ",
      image: "rod2.png",
      text: "究極の船用ロッド\n魚をねじ伏せる",
      prise: 500,
      maxTention: 1000,
    ));
  }

  RodModel getRodData(int id) {
    return rods.firstWhere((element) => element.id.compareTo(id) == 0);
  }
}

class RodModel {
  int id; //一意識別キー
  String name; //名前
  String image; //画像ファイル名
  String text; //コメント
  int prise; //価値
  double maxTention; //テンションの最大値

  //コンストラクタ
  RodModel({
    required this.id,
    required this.name,
    required this.image,
    required this.text,
    required this.prise,
    required this.maxTention,
  });
}
