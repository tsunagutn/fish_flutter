//装備しているタックルのモデル
import 'package:fish_flutter/Model/LuresModel.dart';

class HaveTackleModel {
  late List<HaveLureModel> haveLures = [];

  //コンストラクタ
  HaveTackleModel() {
    //テスト用 初期所持ルアーを登録
    haveLures.add(new HaveLureModel(lureId: 0, lureHp: 700, flgUse: true));
  }

  // //使用中ルアーを返す
  // HaveLuresModel getUseLure() {
  //   HaveLuresModel ret;
  //   Iterable<HaveLuresModel> useLure =
  //       haveLures.where((HaveLuresModel value) => value.flgUse == true);
  //   if (useLure.length > 0) {
  //     ret = haveLures[0];
  //   }
  //   return ret;
  // }

  //ルアー追加
  addLure(LureModel lure) {
    haveLures.add(
        new HaveLureModel(lureId: lure.id, lureHp: lure.hp, flgUse: false));
  }

  //ルアーチェンジ
  changeLure(int lureId) {
    //haveLures全てのレコードのflgUseをfalseにする
    //引数のレコードのflgUseをtrueにする
  }

  //使用中のルアーIDを返す
  HaveLureModel getUseLure() {
    return haveLures.firstWhere((item) => item.flgUse);
  }
}

class HaveLureModel {
  int lureId;
  int lureHp;
  bool flgUse;

  //コンストラクタ
  HaveLureModel({
    required this.lureId,
    required this.lureHp,
    required this.flgUse,
  });
}
