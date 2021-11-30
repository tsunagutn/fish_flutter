enum enumLureDiv {
  tairaba,
  jig,
  inchiku,
}

//ルアーマスタ
class LuresModel {
  late Map<int, LureModel> lures = new Map<int, LureModel>();

  //コンストラクタ
  LuresModel() {
    //シーダーみたいなやつ
    lures[0] = new LureModel(
      id: 0,
      div: enumLureDiv.tairaba.index,
      name: "タイラバ ストレート 60g",
      image: "tairaba.png",
      text: "タダ巻きで使おう",
      hp: 2000,
      weight: 60.0,
      size: 20,
      fall: 0.1,
      reeling: 0.7,
      jerk: 0.1,
      prise: 700,
    );
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
