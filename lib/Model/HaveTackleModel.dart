//装備しているタックルのモデル
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

class HaveTackleModel {
  late List<HaveLureModel> haveLures = [];

  //コンストラクタ
  HaveTackleModel() {
    //テスト用 初期所持ルアーを登録
    haveLures
        .add(new HaveLureModel(id: 0, lureId: 0, lureHp: 0, flgUse: false));
    haveLures
        .add(new HaveLureModel(id: 1, lureId: 1, lureHp: 500, flgUse: true));
    haveLures
        .add(new HaveLureModel(id: 2, lureId: 2, lureHp: 800, flgUse: false));
    haveLures
        .add(new HaveLureModel(id: 3, lureId: 3, lureHp: 1000, flgUse: false));
    haveLures
        .add(new HaveLureModel(id: 4, lureId: 4, lureHp: 5000, flgUse: false));
    haveLures
        .add(new HaveLureModel(id: 5, lureId: 4, lureHp: 5000, flgUse: false));
    haveLures
        .add(new HaveLureModel(id: 6, lureId: 5, lureHp: 6000, flgUse: false));
    haveLures
        .add(new HaveLureModel(id: 7, lureId: 6, lureHp: 4000, flgUse: false));
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
    //最大のIDを取得
    int maxId = 0;
    haveLures.forEach((row) {
      if (maxId < row.id) {
        maxId = row.id;
      }
    });
    haveLures.add(new HaveLureModel(
        id: maxId + 1, lureId: lure.id, lureHp: lure.hp, flgUse: false));
  }

  //ルアーチェンジ
  changeLure(int id) {
    debugPrint(id.toString());
    //haveLures全てのレコードのflgUseをfalseにする
    haveLures.where((item) => item.id != id).forEach((value) {
      value.flgUse = false;
    });
    //引数のレコードのflgUseをtrueにする
    haveLures.firstWhere((item) => item.id == id).flgUse = true;
  }

  //ルアーロスト
  lostLure(int id) {
    if (getUseLure().lureId == 0) {
      //既に針装備中はロストしない
      return;
    }
    //強制的に針を装備
    changeLure(0);
    debugPrint("きれた");
    haveLures.removeAt(
        haveLures.indexOf(haveLures.firstWhere((item) => item.id == id)));
  }

  //使用中のルアーを返す
  HaveLureModel getUseLure() {
    return haveLures.firstWhere((item) => item.flgUse);
  }
}

class HaveLureModel {
  int id;
  int lureId;
  int lureHp;
  bool flgUse;

  //コンストラクタ
  HaveLureModel({
    required this.id,
    required this.lureId,
    required this.lureHp,
    required this.flgUse,
  });
}
