class FishsModel {
  late List<FishModel> fishs = [];

  //コンストラクタ
  FishsModel() {
    //シーダーみたいなやつ
    fishs.add(new FishModel(
      id: 0,
      name: "アジ",
      rare: 1,
      image: "fish/aji.png",
      text: "おいしさナンバーワン",
      hp: 1200,
      // addMax: 3,
      // addMin: -2,
      wariai: 1.0,
      point: 100,
      tanaMin: 0,
      tanaMax: 100,
      hereTanaMin: 0,
      hereTanaMax: 100,
      hitMaki: 1.0,
      hitJerk: 0.5,
      hitFall: 0.4,
      hitSpeedJust: 50,
      hitSpeedRange: 40,
      sizeMin: 7.6,
      sizeMax: 51.3,
      weightMin: 100,
      weightMax: 1000,
      abareLv: 2,
      baitCntMax: 20,
      fookingTension: 200,
      bareMin: 20,
      flgBottom: false,
    ));

    fishs.add(new FishModel(
      id: 1,
      name: "タチウオ",
      rare: 3,
      image: "fish/tachiuo.jpg",
      text: "おおきいぞっ",
      hp: 1500, //このスキャン経過で0になる
      wariai: 0.7,
      point: 200, //ポイントの基礎値
      tanaMin: 100, //生息域 上 0.1m単位
      tanaMax: 300, //生息域 下 0.1m単位
      hereTanaMin: 100,
      hereTanaMax: 300,
      hitMaki: 0.7,
      hitJerk: 0.7,
      hitFall: 0.5,
      hitSpeedJust: 100,
      hitSpeedRange: 50,
      sizeMin: 64.0,
      sizeMax: 150.5,
      weightMin: 400,
      weightMax: 2000,
      abareLv: 5,
      baitCntMax: 20,
      fookingTension: 200,
      bareMin: 20,
      flgBottom: false,
    ));
    fishs.add(new FishModel(
      id: 2,
      name: "鯉",
      rare: 2,
      image: "fish/koi.jpg",
      text: "スーパーレア",
      hp: 6000, //このスキャン経過で0になる
      // addMax: 15,
      // addMin: -4,
      // weight: 1000, //重さ
      wariai: 0.2,
      point: 200, //ポイントの基礎値
      tanaMin: 0, //生息域 上 0.1m単位
      tanaMax: 300, //生息域 下 0.1m単位
      hereTanaMin: 0,
      hereTanaMax: 100,
      hitMaki: 0.9,
      hitJerk: 0.1,
      hitFall: 0.1,
      hitSpeedJust: 75,
      hitSpeedRange: 50,
      sizeMin: 34.4,
      sizeMax: 114.8,
      weightMin: 800,
      weightMax: 4000,
      abareLv: 2,
      baitCntMax: 40,
      fookingTension: 200,
      bareMin: 20,
      flgBottom: false,
    ));
    fishs.add(new FishModel(
      id: 3,
      name: "マダイ",
      rare: 3,
      image: "fish/madai.png",
      text: "やるなすたべ",
      hp: 5000,
      // addMax: 23,
      // addMin: -15,
      // weight: 1000, //重さ
      wariai: 0.5,
      point: 300, //ポイントの基礎値
      tanaMin: 500, //生息域 上 0.1m単位
      tanaMax: 1000, //生息域 下 0.1m単位
      hereTanaMin: 500,
      hereTanaMax: 2000,
      hitMaki: 1.0,
      hitJerk: 0.1,
      hitFall: 0.2,
      hitSpeedJust: 150,
      hitSpeedRange: 50,
      sizeMin: 26.3,
      sizeMax: 86.8,
      weightMin: 500,
      weightMax: 5000,
      abareLv: 4,
      baitCntMax: 30,
      fookingTension: 1000,
      bareMin: 20,
      flgBottom: false,
    ));

    fishs.add(new FishModel(
      id: 4,
      name: "宮澤クン",
      rare: 5,
      image: "fish/sakana.jpg",
      text: "スー　パー　レア",
      hp: 10000,
      // addMax: 30,
      // addMin: -10,
      // weight: 4000, //重さ
      wariai: 0.05,
      point: 99999, //ポイントの基礎値
      tanaMin: 500, //生息域 上 0.1m単位
      tanaMax: 5000, //生息域 下 0.1m単位
      hereTanaMin: 1000,
      hereTanaMax: 5000,
      hitMaki: 0.3,
      hitJerk: 0.8,
      hitFall: 0.6,
      hitSpeedJust: 250,
      hitSpeedRange: 50,
      sizeMin: 9999.9,
      sizeMax: 19999.9,
      weightMin: 50000,
      weightMax: 60000,
      abareLv: 10,
      baitCntMax: 10,
      fookingTension: 1000,
      bareMin: 20,
      flgBottom: false,
    ));

    fishs.add(new FishModel(
      id: 5,
      name: "サバ", //魚種名
      rare: 1,
      image: "fish/saba.png", //超過画面の画像
      text: "写真は仮です", //釣果画面のコメント
      hp: 1200, //このスキャン経過で0になる
      // addMax: 19, //引きの最大
      // addMin: -6, //引きの最小（最大との乖離が暴れ度）
      // weight: 600, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 1.0, //HIT率 条件全一致で確定1.0～
      point: 100, //ポイントの基礎値
      tanaMin: 0, //生息域 上 0.1m単位
      tanaMax: 100, //生息域 下 0.1m単位
      hereTanaMin: 0,
      hereTanaMax: 400,
      hitMaki: 0.8,
      hitJerk: 0.5,
      hitFall: 0.7, //フォール志向
      hitSpeedJust: 150, //スピード志向
      hitSpeedRange: 30, //スピード志向範囲+-
      sizeMin: 14.3,
      sizeMax: 67.2,
      weightMin: 200,
      weightMax: 1200,
      abareLv: 5,
      baitCntMax: 15,
      fookingTension: 150,
      bareMin: 20,
      flgBottom: false,
    ));

    fishs.add(new FishModel(
      id: 6,
      name: "サゴシ", //魚種名
      rare: 2,
      image: "fish/sagoshi.png", //超過画面の画像
      text: "この魚は美味です", //釣果画面のコメント
      hp: 2000, //このスキャン経過で0になる
      // addMax: 15, //引きの最大
      // addMin: -10, //引きの最小（最大との乖離が暴れ度）
      // weight: 700, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 0.8, //HIT率 条件全一致で確定1.0～
      point: 300, //ポイントの基礎値
      tanaMin: 80, //生息域 上 0.1m単位
      tanaMax: 450, //生息域 下 0.1m単位
      hereTanaMin: 0,
      hereTanaMax: 450,
      hitMaki: 0.8,
      hitJerk: 0.6,
      hitFall: 0.9, //フォール志向
      hitSpeedJust: 300, //スピード志向
      hitSpeedRange: 100, //スピード志向範囲+-
      sizeMin: 18.3,
      sizeMax: 69.9,
      weightMin: 200,
      weightMax: 1000,
      abareLv: 6,
      baitCntMax: 15,
      fookingTension: 100,
      bareMin: 20,
      flgBottom: false,
    ));
    fishs.add(new FishModel(
      id: 7,
      name: "アオハタ", //魚種名
      rare: 2,
      image: "fish/aohata.png", //超過画面の画像
      text: "底でよく釣れる", //釣果画面のコメント
      hp: 1800, //このスキャン経過で0になる
      // addMax: 16, //引きの最大
      // addMin: -7, //引きの最小（最大との乖離が暴れ度）
      // weight: 1000, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 0.8, //HIT率 条件全一致で確定1.0～
      point: 400, //ポイントの基礎値
      tanaMin: 80, //生息域 上 0.1m単位
      tanaMax: 850, //生息域 下 0.1m単位
      hereTanaMin: 80,
      hereTanaMax: 1000,
      hitMaki: 0.9,
      hitJerk: 0.8,
      hitFall: 1.0, //フォール志向
      hitSpeedJust: 80, //スピード志向
      hitSpeedRange: 60, //スピード志向範囲+-
      sizeMin: 20.6,
      sizeMax: 63.2,
      weightMin: 400,
      weightMax: 1500,
      abareLv: 3,
      baitCntMax: 25,
      fookingTension: 400,
      bareMin: 35,
      flgBottom: true,
    ));
    fishs.add(new FishModel(
      id: 8,
      name: "キジハタ", //魚種名
      rare: 3,
      image: "fish/kijihata.png", //超過画面の画像
      text: "この魚は贅沢です", //釣果画面のコメント
      hp: 2100, //このスキャン経過で0になる
      // addMax: 18, //引きの最大
      // addMin: -7, //引きの最小（最大との乖離が暴れ度）
      // weight: 1000, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 0.4, //HIT率 条件全一致で確定1.0～
      point: 800, //ポイントの基礎値
      tanaMin: 50, //生息域 上 0.1m単位
      tanaMax: 700, //生息域 下 0.1m単位
      hereTanaMin: 50,
      hereTanaMax: 700,
      hitMaki: 0.8,
      hitJerk: 0.8,
      hitFall: 1.0, //フォール志向
      hitSpeedJust: 70, //スピード志向
      hitSpeedRange: 60, //スピード志向範囲+-
      sizeMin: 20.6,
      sizeMax: 63.2,
      weightMin: 400,
      weightMax: 1700,
      abareLv: 3,
      baitCntMax: 25,
      fookingTension: 500,
      bareMin: 35,
      flgBottom: true,
    ));
    fishs.add(new FishModel(
      id: 9,
      name: "アカヤガラ",
      rare: 4,
      image: "fish/akayagara.png",
      text: "潮が悪いとき釣れる",
      hp: 1000,
      // addMax: 18,
      // addMin: -7, //引きの最小（最大との乖離が暴れ度）
      // weight: 1000, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 0.3, //HIT率 条件全一致で確定1.0～
      point: 500, //ポイントの基礎値
      tanaMin: 400, //生息域 上 0.1m単位
      tanaMax: 1500, //生息域 下 0.1m単位
      hereTanaMin: 400,
      hereTanaMax: 2000,
      hitMaki: 1.0,
      hitJerk: 0.5,
      hitFall: 0.6,
      hitSpeedJust: 100,
      hitSpeedRange: 80,
      sizeMin: 60.6,
      sizeMax: 154.3,
      weightMin: 500,
      weightMax: 1800,
      abareLv: 2,
      baitCntMax: 25,
      fookingTension: 700,
      bareMin: 20,
      flgBottom: false,
    ));
    fishs.add(new FishModel(
      id: 10,
      name: "アヤメカサゴ",
      rare: 4,
      image: "fish/ayamekasago.png",
      text: "ちょっと珍しいカサゴ",
      hp: 1300,
      // addMax: 26,
      // addMin: -20, //引きの最小（最大との乖離が暴れ度）
      // weight: 1000, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 0.2, //HIT率 条件全一致で確定1.0～
      point: 1200, //ポイントの基礎値
      tanaMin: 500, //生息域 上 0.1m単位
      tanaMax: 1500, //生息域 下 0.1m単位
      hereTanaMin: 500,
      hereTanaMax: 1500,
      hitMaki: 0.9,
      hitJerk: 0.5,
      hitFall: 0.8,
      hitSpeedJust: 90,
      hitSpeedRange: 40,
      sizeMin: 20.7,
      sizeMax: 44.2,
      weightMin: 600,
      weightMax: 1200,
      abareLv: 3,
      baitCntMax: 40,
      fookingTension: 600,
      bareMin: 35,
      flgBottom: true,
    ));
    fishs.add(new FishModel(
      id: 11,
      name: "サバフグ",
      rare: 1,
      image: "fish/sabahugu.png",
      text: "毒が無いらしい",
      hp: 2000,
      // addMax: 20,
      // addMin: -10, //引きの最小（最大との乖離が暴れ度）
      // weight: 500, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 0.5, //HIT率 条件全一致で確定1.0～
      point: 10, //ポイントの基礎値
      tanaMin: 00, //生息域 上 0.1m単位
      tanaMax: 150, //生息域 下 0.1m単位
      hereTanaMin: 0,
      hereTanaMax: 150,
      hitMaki: 1.0,
      hitJerk: 0.8,
      hitFall: 0.8,
      hitSpeedJust: 80,
      hitSpeedRange: 60,
      sizeMin: 13.4,
      sizeMax: 53.9,
      weightMin: 170,
      weightMax: 1500,
      abareLv: 4,
      baitCntMax: 40,
      fookingTension: 60,
      bareMin: 35,
      flgBottom: false,
    ));
    fishs.add(new FishModel(
      id: 12,
      name: "ヒラマサ",
      rare: 4,
      image: "fish/hiramasa.png",
      text: "ヤッターマン",
      hp: 5000,
      // addMax: 40,
      // addMin: -40, //引きの最小（最大との乖離が暴れ度）
      // weight: 3000, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 0.5, //HIT率 条件全一致で確定1.0～
      point: 2300, //ポイントの基礎値
      tanaMin: 200, //生息域 上 0.1m単位
      tanaMax: 1500, //生息域 下 0.1m単位
      hereTanaMin: 200,
      hereTanaMax: 5000,
      hitMaki: 0.7,
      hitJerk: 1.0,
      hitFall: 0.8,
      hitSpeedJust: 400,
      hitSpeedRange: 100,
      sizeMin: 35.0,
      sizeMax: 120.1,
      weightMin: 700,
      weightMax: 4000,
      abareLv: 8,
      baitCntMax: 40,
      fookingTension: 130,
      bareMin: 35,
      flgBottom: false,
    ));
    fishs.add(new FishModel(
      id: 13,
      name: "サワラ",
      rare: 4,
      image: "fish/sawara.png",
      text: "サゴシのでかいやつ",
      hp: 4000,
      // addMax: 46,
      // addMin: -40, //引きの最小（最大との乖離が暴れ度）
      // weight: 2800, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 0.4, //HIT率 条件全一致で確定1.0～
      point: 2100, //ポイントの基礎値
      tanaMin: 50, //生息域 上 0.1m単位
      tanaMax: 300, //生息域 下 0.1m単位
      hereTanaMin: 200,
      hereTanaMax: 5000,
      hitMaki: 0.6,
      hitJerk: 0.9,
      hitFall: 1.0,
      hitSpeedJust: 430,
      hitSpeedRange: 100,
      sizeMin: 70.0,
      sizeMax: 111.2,
      weightMin: 1000,
      weightMax: 2600,
      abareLv: 7,
      baitCntMax: 40,
      fookingTension: 70,
      bareMin: 20,
      flgBottom: false,
    ));
  }

  //IDを指定して魚情報を取得
  FishModel getFishDetail(int id) {
    FishModel ret = fishs.firstWhere((fish) => fish.id == id);
    return ret;
  }

  //水深から可能性のある魚種のみ抽出して返す
  List<FishModel> extractDepth(
      {required double depth, required double maxDepth, required bool bottom}) {
    //ディープコピー
    List<FishModel> extractFishs = [...fishs];
    //深さから可能性のある魚種のみ抽出
    extractFishs.removeWhere((value) => depth < value.tanaMin);
    extractFishs.removeWhere((value) => depth > value.tanaMax);
    extractFishs.removeWhere((value) => maxDepth < value.hereTanaMin);
    extractFishs.removeWhere((value) => maxDepth > value.hereTanaMax);

    if (!bottom) {
      extractFishs.removeWhere((value) => value.flgBottom);
    }
    return extractFishs;
  }
}

class FishModel {
  int id; //一意識別キー
  String name; //魚種名
  int rare; //レアド
  String image; //画像ファイル名
  String text; //釣果画面のコメント
  int hp; //このスキャン経過で0になる
  // int addMax; //引きの最大
  // int addMin; //引きの最小（最大との乖離が暴れ度）
  double wariai; //HIT率 条件全一致で確定1.0～
  int point; //ポイントの基礎値
  int tanaMin; //生息タナ 上 0.1m単位
  int tanaMax; //生息タナ 下 0.1m単位
  int hereTanaMin; //生息域 水深これより深くない場所にはいない 0.1m単位
  int hereTanaMax; //生息域 水深これより深い場所にはいない 0.1m単位
  double hitMaki; //巻き志向 0.0～1.0
  double hitJerk; //ジャーク志向 0.0～1.0
  double hitFall; //フォール志向 0.0～1.0
  int hitSpeedJust; //スピード志向
  int hitSpeedRange; //スピード志向範囲+-
  double sizeMin; //大きさ範囲最小
  double sizeMax; //大きさ範囲最大
  double weightMin; //重さ g単位（HP0時の最低重量、これが無いとバレ判定にひっかかる）
  double weightMax; //重さ g単位（HP0時の最低重量、これが無いとバレ判定にひっかかる）
  int abareLv; //自重の何倍まで暴れるか
  int baitCntMax; //アタリ発生からアワセまでの猶予スキャン
  double fookingTension; //アワセ成功テンション
  int bareMin; //HIT後のバレ判定スキャン数（これプラスアワセレベル）
  bool flgBottom; //底生

  //コンストラクタ
  FishModel({
    required this.id,
    required this.name,
    required this.rare,
    required this.image,
    required this.text,
    required this.hp,
    // required this.addMax,
    // required this.addMin,
    required this.wariai,
    required this.point,
    required this.tanaMin,
    required this.tanaMax,
    required this.hereTanaMin,
    required this.hereTanaMax,
    required this.hitFall,
    required this.hitMaki,
    required this.hitJerk,
    required this.hitSpeedJust,
    required this.hitSpeedRange,
    required this.sizeMin,
    required this.sizeMax,
    required this.weightMax,
    required this.weightMin,
    required this.abareLv,
    required this.baitCntMax,
    required this.fookingTension,
    required this.bareMin,
    required this.flgBottom,
  });

  //サイズ割合（0.0～1.0）を元に実サイズを返す
  double getSize(size) {
    return ((sizeMax - sizeMin) * size + sizeMin);
  }

  //サイズ割合（0.0～1.0）を元に実重さを返す
  double getWeight(size) {
    return ((weightMax - weightMin) * size + weightMin);
  }

  Map<String, List<double>> getPrmLevels() {
    final Map<String, List<double>> ret = {
      'hp': [500, 1000, 2000, 4000, 8000],
      'addMax': [6, 10, 20, 35, 50],
      'abare': [6, 10, 15, 30, 50],
    };
    return ret;
  }
}
