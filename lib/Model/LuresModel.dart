enum enumLureDiv {
  tairaba,
  jig,
  inchiku,
}

//ルアーマスタ
class LuresModel {
  late List<LureModel> lures = [];

  //コンストラクタ
  LuresModel() {
    //シーダーみたいなやつ
    lures.add(new LureModel(
      id: 0,
      div: enumLureDiv.tairaba.index,
      name: "タイラバ ストレート 60g",
      image: "tairaba.png",
      text: "鉛にシリコンのヒラヒラが付いた、シンプルなルアー。\nとても傷みやすい。\nタダ巻きで使おう！",
      hp: 500,
      weight: 60.0,
      size: 200,
      fall: 0.3,
      reeling: 0.9,
      jerk: 0.1,
      prise: 700,
    ));

    lures.add(new LureModel(
      id: 1,
      div: enumLureDiv.tairaba.index,
      name: "タイラバ ストレート 120g",
      image: "tairaba.png",
      text: "タダ巻きで使おう2",
      hp: 800,
      weight: 120.0,
      size: 250,
      fall: 0.2,
      reeling: 0.9,
      jerk: 0.1,
      prise: 700,
    ));

    lures.add(new LureModel(
      id: 2,
      div: enumLureDiv.tairaba.index,
      name: "タイラバ ストレート 999g",
      image: "tairaba.png",
      text: "タダ巻きで使おう3",
      hp: 1000,
      weight: 999.0,
      size: 500,
      fall: 0.8,
      reeling: 0.7,
      jerk: 0.5,
      prise: 700,
    ));

    lures.add(new LureModel(
      id: 3,
      div: enumLureDiv.jig.index,
      name: "メタルジグ バーチカル 80g",
      image: "jig.png",
      text: "キラキラしている",
      hp: 5000,
      weight: 80.0,
      size: 230,
      fall: 0.7,
      reeling: 0.1,
      jerk: 0.9,
      prise: 700,
    ));
  }

  LureModel getLureData(int id) {
    return lures.firstWhere((element) => element.id.compareTo(id) == 0);
  }
}

class LureModel {
  int id; //一意識別キー
  int div; //種類 0:タイラバ 1:ジグ 2:インチク
  String name; //名前
  String image; //画像ファイル名
  String text; //コメント
  int prise; //価値
  double weight; //重さ
  double size; //大きさ 0.1cm
  int hp; //耐久度
  double fall; //フォール志向
  double reeling; //巻き志向
  double jerk; //ジャーク志向

  //コンストラクタ
  LureModel({
    required this.id,
    required this.div,
    required this.name,
    required this.image,
    required this.text,
    required this.prise,
    required this.weight,
    required this.size,
    required this.hp,
    required this.fall,
    required this.reeling,
    required this.jerk,
  });
}
