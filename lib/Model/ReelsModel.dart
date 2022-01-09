//リールマスタ
class ReelsModel {
  late List<ReelModel> reels = [];

  //コンストラクタ
  ReelsModel() {
    //シーダーみたいなやつ
    reels.add(new ReelModel(
      id: -1,
      name: "もうない",
      image: "reel1.png",
      text: "もう最強です",
      prise: -1,
      maxSpeed: -1,
    ));

    reels.add(new ReelModel(
      id: 0,
      name: "カンタンリール",
      image: "reel1.png",
      text: "最初のリール\n一番へぼい",
      prise: 0,
      maxSpeed: 100,
    ));
    reels.add(new ReelModel(
      id: 1,
      name: "中級リール",
      image: "reel2.png",
      text: "本格的船用リール\nなかなかすごい",
      prise: 500,
      maxSpeed: 500,
    ));
    reels.add(new ReelModel(
      id: 2,
      name: "上級リール",
      image: "reel3.png",
      text: "究極の船用リール\n超すごい",
      prise: 500,
      maxSpeed: 1000,
    ));
  }

  ReelModel getReelData(int id) {
    return reels.firstWhere((element) => element.id.compareTo(id) == 0);
  }
}

class ReelModel {
  int id; //一意識別キー
  String name; //名前
  String image; //画像ファイル名
  String text; //コメント
  int prise; //価値
  double maxSpeed; //スピードの最大値

  //コンストラクタ
  ReelModel({
    required this.id,
    required this.name,
    required this.image,
    required this.text,
    required this.prise,
    required this.maxSpeed,
  });
}
