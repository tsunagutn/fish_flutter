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
      name: "針",
      image: "hari.png",
      text: "絶対壊れない\n絶対釣れないことはない",
      hp: -1,
      weight: 1.0,
      size: 1.0,
      fall: 0.1,
      reeling: 0.1,
      jerk: 0.1,
      prise: 0,
    ));
    lures.add(new LureModel(
      id: 1,
      div: enumLureDiv.tairaba.index,
      name: "タイラバ ストレート 60g",
      image: "tairaba.png",
      text: "鉛にシリコンのヒラヒラが付いた、シンプルなルアー。\nとても傷みやすい。\nタダ巻きで使おう！",
      hp: 3000,
      weight: 60.0,
      size: 15.0,
      fall: 0.2,
      reeling: 0.9,
      jerk: 0.1,
      prise: 700,
    ));

    lures.add(new LureModel(
      id: 2,
      div: enumLureDiv.tairaba.index,
      name: "タイラバ ストレート 120g",
      image: "tairaba.png",
      text: "タダ巻きで使おう2",
      hp: 3000,
      weight: 120.0,
      size: 20.0,
      fall: 0.2,
      reeling: 0.9,
      jerk: 0.1,
      prise: 700,
    ));

    lures.add(new LureModel(
      id: 3,
      div: enumLureDiv.tairaba.index,
      name: "タイラバ ストレート 999g",
      image: "tairaba.png",
      text: "テスト用\nバチクソ重い",
      hp: 3000,
      weight: 999.0,
      size: 50.0,
      fall: 0.8,
      reeling: 0.7,
      jerk: 0.5,
      prise: 700,
    ));
    lures.add(new LureModel(
      id: 4,
      div: enumLureDiv.jig.index,
      name: "メタルジグ バーチカル 80g",
      image: "jig.png",
      text: "鉛製で頑丈\nジャークに特化している",
      hp: 5000,
      weight: 80.0,
      size: 20.0,
      fall: 0.5,
      reeling: 0.1,
      jerk: 0.9,
      prise: 700,
    ));
    lures.add(new LureModel(
      id: 5,
      div: enumLureDiv.jig.index,
      name: "メタルジグ バーチカル 100g",
      image: "jig.png",
      text: "鉛製で頑丈\nジャークに特化している",
      hp: 6000,
      weight: 100.0,
      size: 25.0,
      fall: 0.5,
      reeling: 0.1,
      jerk: 0.9,
      prise: 700,
    ));
    lures.add(new LureModel(
      id: 6,
      div: enumLureDiv.jig.index,
      name: "メタルジグ スロー 60g",
      image: "slowjig.png",
      text: "鉛製で頑丈\nフォールでヒラヒラと誘う\n巻いてもOK",
      hp: 4000,
      weight: 100.0,
      size: 15.0,
      fall: 0.8,
      reeling: 0.5,
      jerk: 0.4,
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
