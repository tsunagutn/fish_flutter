// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// enum enumLureDiv {
//   tairaba,
//   jig,
//   slowjig,
// }
//
// //ルアーマスタ
// class LuresModel {
//   late List<LureModel> lures = [];
//
//   //コンストラクタ
//   LuresModel() {
//     //シーダーみたいなやつ
//     lures.add(new LureModel(
//       id: enumLureDiv.tairaba,
//       name: "タイラバ",
//       image: "tairaba.png",
//       lv: 1,
//       totalExp: 0,
//       weightList: new LureWeights(),
//       useWeightId: 0,
//       fall: 0.2,
//       reeling: 0.5,
//       jerk: 0.1,
//       lvAddFall: 0.02,
//       lvAddReeling: 0.05,
//       lvAddJerk: 0.01,
//     ));
//     lures.add(new LureModel(
//       id: enumLureDiv.jig,
//       name: "メタルジグ",
//       image: "jig.png",
//       lv: 1,
//       totalExp: 0,
//       weightList: new LureWeights(),
//       useWeightId: 0,
//       fall: 0.2,
//       reeling: 0.1,
//       jerk: 0.5,
//       lvAddFall: 0.03,
//       lvAddReeling: 0.01,
//       lvAddJerk: 0.05,
//     ));
//
//     lures.add(new LureModel(
//       id: enumLureDiv.slowjig,
//       name: "スロージグ",
//       image: "slowjig.png",
//       lv: 1,
//       totalExp: 0,
//       weightList: new LureWeights(),
//       useWeightId: 0,
//       fall: 0.4,
//       reeling: 0.2,
//       jerk: 0.2,
//       lvAddFall: 0.04,
//       lvAddReeling: 0.02,
//       lvAddJerk: 0.02,
//     ));
//   }
//
//   //IDを指定してルアーデータを取得
//   LureModel getLureData(enumLureDiv id) {
//     return lures
//         .firstWhere((element) => element.id.index.compareTo(id.index) == 0);
//   }
// }
//
// class LureModel {
//   enumLureDiv id; //一意識別キー
//   String name; //名前
//   String image; //画像ファイル名
//   int lv; //レベル
//   double totalExp; //累計EXP
//   LureWeights weightList; //重さリスト
//   int useWeightId; //使用重さ
//   double fall; //フォール志向
//   double reeling; //巻き志向
//   double jerk; //ジャーク志向
//   double lvAddFall; //フォール成長値
//   double lvAddReeling; //巻き成長値
//   double lvAddJerk; //ジャーク成長値
//
//   //Lv1→2に必要なEXP
//   static const double basicExp = 100.0;
//   //システム上最大Lv
//   static const int maxLv = 99;
//
//   //コンストラクタ
//   LureModel({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.lv,
//     required this.totalExp,
//     required this.weightList,
//     required this.useWeightId,
//     required this.fall,
//     required this.reeling,
//     required this.jerk,
//     required this.lvAddFall,
//     required this.lvAddReeling,
//     required this.lvAddJerk,
//   });
//
//   //重さを取得
//   double getWeight(int id) {
//     double ret = 0.0;
//     //IDの存在チェック
//     if (weightList.list.asMap().containsKey(id)) {
//       ret = weightList.list[useWeightId].weight;
//     }
//     return ret;
//   }
//
//   //自分の重さを取得
//   double getMyWeight() {
//     return getWeight(useWeightId);
//   }
//
//   //累計EXPから現在のレベルを取得
//   int getLv() {
//     int retLv = 1;
//     double nextExp = basicExp;
//     double divExp = nextExp;
//     //最大レベルまでループ
//     while (retLv < maxLv) {
//       if (totalExp >= divExp) {
//         retLv++;
//       } else {
//         //現Lv判明時にループ抜け
//         break;
//       }
//       //次Lvに必要なEXP
//       nextExp = nextExp * 1.1;
//       divExp += nextExp;
//     }
//     //現レベルを返す
//     return retLv;
//   }
//
//   //次のレベルまでのEXPを返す
//   int getNextLvExp() {
//     //既に最大レベルの場合は-1を返す
//     if (lv >= maxLv) return -1;
//     //次Lvの合計EXPと現EXPの差分を返す
//     return (getExp(lv + 1) - totalExp).floor();
//   }
//
//   //指定したレベルに必要な累計EXPを返す
//   double getExp(int nextLv) {
//     double exp = basicExp;
//     //次Lvに必要な合計EXPを算出
//     for (int iLv = 1; iLv < nextLv; iLv++) {
//       exp = exp * 1.1;
//     }
//     return exp;
//   }
//
//   //レベルアップ処理
//   String lvUp() {
//     String ret = "";
//     //既に最大レベルの場合はなにもしない
//     if (lv >= maxLv) return ret;
//     int oldLv = lv;
//     //新レベルの値をセット
//     lv = getLv();
//     //現レベル-新レベル間ループ
//     for (int i = oldLv; i < lv; i++) {
//       //fall成長
//       fall = stsUp(fall, lvAddFall);
//       //reeling成長
//       reeling = stsUp(reeling, lvAddReeling);
//       //jerk成長
//       jerk = stsUp(jerk, lvAddJerk);
//     }
//     ret = name + "がレベルアップ Lv " + oldLv.toString() + " → " + lv.toString();
//
//     //3レベル毎に新しい重さをアンロック
//     int maxWeightId = weightList.list.length;
//     int newWeightLv = (lv ~/ 3);
//     //if (maxWeightId > newWeightLv) {
//     String strWeight = "";
//     weightList.list.forEach((element) {
//       if (weightList.list.indexOf(element) <= newWeightLv && !element.enabled) {
//         element.enabled = true;
//         strWeight += element.weight.toString() + "g ";
//       }
//     });
//
//     if (strWeight != "") {
//       ret += "\n" + strWeight + "が使えるようになった";
//     }
//     //}
//     return ret;
//   }
//
//   double stsUp(double old, double add) {
//     double ret = old + add;
//     if (ret >= 1.0) ret = 1.0;
//     return ret;
//   }
//
//   //レベルダウン処理
//   lvDown() {
//     //現在1レベルの場合はなにもしない
//     if (lv <= 1) return;
//
//     //新レベルの値をセット
//     lv = lv - 1;
//     //累計EXPセット
//     totalExp = getExp(lv);
//     //fallマイナス
//     fall = fall - lvAddFall;
//     //reelingマイナス
//     reeling = reeling - lvAddReeling;
//     //jerkマイナス
//     jerk = jerk - lvAddJerk;
//   }
//
//   //ルアー種による色を取得
//   Color getLureColor(id) {
//     var ret;
//     switch (id) {
//       case enumLureDiv.jig:
//         ret = Colors.cyan[500];
//         break;
//       case enumLureDiv.tairaba:
//         ret = Colors.red[200];
//         break;
//       case enumLureDiv.slowjig:
//         ret = Colors.green[200];
//         break;
//     }
//     return ret;
//   }
// }
//
// class LureWeights {
//   List<LureWeight> list = [];
//
//   //コンストラクタ
//   LureWeights() {
//     list.add(new LureWeight(weightId: 0, weight: 10, enabled: true));
//     list.add(new LureWeight(weightId: 1, weight: 20, enabled: false));
//     list.add(new LureWeight(weightId: 2, weight: 40, enabled: false));
//     list.add(new LureWeight(weightId: 3, weight: 60, enabled: false));
//     list.add(new LureWeight(weightId: 4, weight: 80, enabled: false));
//     list.add(new LureWeight(weightId: 5, weight: 100, enabled: false));
//     list.add(new LureWeight(weightId: 6, weight: 150, enabled: false));
//     list.add(new LureWeight(weightId: 7, weight: 200, enabled: false));
//   }
// }
//
// //ルアー重さリスト用クラス
// class LureWeight {
//   int weightId; //重さのID
//   double weight; //重さ(g)
//   bool enabled; //解放済みフラグ
//
//   //コンストラクタ
//   LureWeight({
//     required this.weightId,
//     required this.weight,
//     required this.enabled,
//   });
// }
