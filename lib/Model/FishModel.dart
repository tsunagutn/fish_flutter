class FishsModel {
  late Map<int, FishModel> fishs = new Map<int, FishModel>();

  //コンストラクタ
  FishsModel() {
    //シーダーみたいなやつ
    fishs[0] = new FishModel(
        id: 0,
        name: "アジ",
        image: "aji.jpg",
        text: "あなたは幸せを感じました",
        hp: 300,
        addMax: 30,
        addMin: -10,
        weight: 200,
        wariai: 1.0,
        point: 100,
        tanaMin: 0,
        tanaMax: 100,
        hitFall: 0.2,
        hitSpeedJust: 50,
        hitSpeedRange: 40,
        sizeMin: 7.6,
        sizeMax: 51.3,
        baitCntMax: 20,
        fookingTension: 50,
        bareMin: 20);

    fishs[1] = new FishModel(
      id: 1,
      name: "タチウオ",
      image: "tachiuo.jpg",
      text: "おおきいぞっ",
      hp: 250, //このスキャン経過で0になる
      addMax: 13,
      addMin: -5,
      weight: 500, //重さ
      wariai: 0.7,
      point: 200, //ポイントの基礎値
      tanaMin: 100, //生息域 上 0.1m単位
      tanaMax: 300, //生息域 下 0.1m単位
      hitFall: 0.3,
      hitSpeedJust: 100,
      hitSpeedRange: 50,
      sizeMin: 64.0,
      sizeMax: 150.5,
      baitCntMax: 20,
      fookingTension: 80,
      bareMin: 20,
    );
    fishs[2] = new FishModel(
      id: 2,
      name: "鯉",
      image: "koi.jpg",
      text: "スーパーレア",
      hp: 3000, //このスキャン経過で0になる
      addMax: 10,
      addMin: -6,
      weight: 1500, //重さ
      wariai: 0.5,
      point: 200, //ポイントの基礎値
      tanaMin: 0, //生息域 上 0.1m単位
      tanaMax: 300, //生息域 下 0.1m単位
      hitFall: 0.1,
      hitSpeedJust: 75,
      hitSpeedRange: 50,
      sizeMin: 34.4,
      sizeMax: 114.8,
      baitCntMax: 40,
      fookingTension: 100,
      bareMin: 20,
    );
    fishs[3] = new FishModel(
      id: 3,
      name: "マダイ",
      image: "madai.jpg",
      text: "あなたは満足を得ました",
      hp: 1000,
      addMax: 15,
      addMin: -6,
      weight: 2000, //重さ
      wariai: 0.5,
      point: 300, //ポイントの基礎値
      tanaMin: 500, //生息域 上 0.1m単位
      tanaMax: 1000, //生息域 下 0.1m単位
      hitFall: 0.1,
      hitSpeedJust: 150,
      hitSpeedRange: 50,
      sizeMin: 26.3,
      sizeMax: 86.8,
      baitCntMax: 30,
      fookingTension: 150,
      bareMin: 20,
    );

    fishs[4] = new FishModel(
      id: 4,
      name: "宮澤クン",
      image: "sakana.jpg",
      text: "スー　パー　レア",
      hp: 5000,
      addMax: 30,
      addMin: -10,
      weight: 4000, //重さ
      wariai: 0.05,
      point: 99999, //ポイントの基礎値
      tanaMin: 500, //生息域 上 0.1m単位
      tanaMax: 5000, //生息域 下 0.1m単位
      hitFall: 0.6,
      hitSpeedJust: 250,
      hitSpeedRange: 50,
      sizeMin: 9999.9,
      sizeMax: 19999.9,
      baitCntMax: 10,
      fookingTension: 150,
      bareMin: 20,
    );

    fishs[5] = new FishModel(
      id: 5,
      name: "サバ", //魚種名
      image: "aji.jpg", //超過画面の画像
      text: "写真は仮です", //釣果画面のコメント
      hp: 500, //このスキャン経過で0になる
      addMax: 10, //引きの最大
      addMin: -5, //引きの最小（最大との乖離が暴れ度）
      weight: 700, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 1.0, //HIT率 条件全一致で確定1.0～
      point: 100, //ポイントの基礎値
      tanaMin: 0, //生息域 上 0.1m単位
      tanaMax: 70, //生息域 下 0.1m単位
      hitFall: 0.2, //フォール志向
      hitSpeedJust: 150, //スピード志向
      hitSpeedRange: 30, //スピード志向範囲+-
      sizeMin: 14.3,
      sizeMax: 67.2,
      baitCntMax: 15,
      fookingTension: 80,
      bareMin: 20,
    );

    fishs[6] = new FishModel(
      id: 6,
      name: "サゴシ", //魚種名
      image: "aji.jpg", //超過画面の画像
      text: "あなたは満足を得ました", //釣果画面のコメント
      hp: 1000, //このスキャン経過で0になる
      addMax: 20, //引きの最大
      addMin: -5, //引きの最小（最大との乖離が暴れ度）
      weight: 1000, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      wariai: 0.6, //HIT率 条件全一致で確定1.0～
      point: 300, //ポイントの基礎値
      tanaMin: 0, //生息域 上 0.1m単位
      tanaMax: 200, //生息域 下 0.1m単位
      hitFall: 1.0, //フォール志向
      hitSpeedJust: 170, //スピード志向
      hitSpeedRange: 40, //スピード志向範囲+-
      sizeMin: 35.3,
      sizeMax: 69.9,
      baitCntMax: 15,
      fookingTension: 120,
      bareMin: 20,
    );
  }

  //水深から可能性のある魚種のみ抽出して返す
  Map<int, FishModel> extractDepth(double depth) {
    //Mapを値コピー
    Map<int, FishModel> extractFishs = {...fishs};
    //深さから可能性のある魚種のみ抽出
    extractFishs.removeWhere((key, value) => depth < value.tanaMin);
    extractFishs.removeWhere((key, value) => depth > value.tanaMax);

    return extractFishs;
  }
}

class FishModel {
  int id; //一意識別キー
  String name; //魚種名
  String image; //画像ファイル名
  String text; //釣果画面のコメント
  int hp; //このスキャン経過で0になる
  int addMax; //引きの最大
  int addMin; //引きの最小（最大との乖離が暴れ度）
  int weight; //重さ g単位（HP0時の最低重量、これが無いとバレ判定にひっかかる）
  double wariai; //HIT率 条件全一致で確定1.0～
  int point; //ポイントの基礎値
  int tanaMin; //生息域 上 0.1m単位
  int tanaMax; //生息域 下 0.1m単位
  double hitFall; //フォール志向 0.0～1.0
  int hitSpeedJust; //スピード志向
  int hitSpeedRange; //スピード志向範囲+-
  double sizeMin; //大きさ範囲最小
  double sizeMax; //大きさ範囲最大
  int baitCntMax; //アタリ発生からアワセまでの猶予スキャン
  int fookingTension; //アワセ成功テンション
  int bareMin; //HIT後のバレ判定スキャン数（これプラスアワセレベル）

  //コンストラクタ
  FishModel({
    required this.id,
    required this.name,
    required this.image,
    required this.text,
    required this.hp,
    required this.addMax,
    required this.addMin,
    required this.weight,
    required this.wariai,
    required this.point,
    required this.tanaMin,
    required this.tanaMax,
    required this.hitFall,
    required this.hitSpeedJust,
    required this.hitSpeedRange,
    required this.sizeMin,
    required this.sizeMax,
    required this.baitCntMax,
    required this.fookingTension,
    required this.bareMin,
  });

  //サイズ割合（0.0～1.0）を元に実サイズを返す
  double getSize(size) {
    return ((sizeMax - sizeMin) * size + sizeMin);
  }
}
