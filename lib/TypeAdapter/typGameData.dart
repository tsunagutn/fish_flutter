import 'package:fish_flutter/TypeAdapter/typFishResult.dart';
import 'package:fish_flutter/TypeAdapter/typLureData.dart';
import 'package:hive/hive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/material/colors.dart';

import '../Main.dart';

part 'typGameData.g.dart';

enum enumResult {
  success,
  bare,
  cut,
}

@HiveType(typeId: 3)
class typGameData extends HiveObject {
  @HiveField(0)
  int gameId;

  @HiveField(1)
  int timeCount;

  @HiveField(2)
  int maxTimeCount;

  @HiveField(3)
  int point;

  @HiveField(4)
  double maxDepth;

  @HiveField(5)
  double windLevel;

  @HiveField(6)
  double maxWindLevel;

  @HiveField(7)
  double maxTension;

  @HiveField(8)
  double maxLineHp;

  @HiveField(9)
  double maxSpeed;

  @HiveField(10)
  int useLureIdx;

  @HiveField(11)
  String saveDateTime;

  @HiveField(12)
  late HiveList<typFishResult> fishResults;

  @HiveField(13)
  late HiveList<typLureData> lureData;

  @HiveField(14)
  late bool isEnd;

  typGameData({
    required this.gameId,
    required this.timeCount,
    required this.maxTimeCount,
    required this.point,
    required this.maxDepth,
    required this.windLevel,
    required this.maxWindLevel,
    required this.maxTension,
    required this.maxLineHp,
    required this.maxSpeed,
    required this.useLureIdx,
    required this.saveDateTime,
    required this.isEnd,
  });

  //ルアー重さの定義
  static const List<double> LST_LURE_WEIGHT = [
    10.0, //0番目
    20.0,
    40.0,
    60.0,
    80.0,
    100.0,
    150.0,
    200.0, //7番目
  ];

  //Lv1→2に必要なEXP
  static const double basicExp = 100.0;
  //システム上最大Lv
  static const int maxLv = 99;

  //save処理
  @override
  save() async {
    saveDateTime = DateTime.now().toString();
    super.save();
  }

  //値をコピーして新しいインスタンスを返す（履歴データに保存用）
  copy() {
    var ret = typGameData(
        gameId: gameId,
        timeCount: timeCount,
        maxTimeCount: maxTimeCount,
        point: point,
        maxDepth: maxDepth,
        windLevel: windLevel,
        maxWindLevel: maxWindLevel,
        maxTension: maxTension,
        maxLineHp: maxLineHp,
        maxSpeed: maxSpeed,
        useLureIdx: useLureIdx,
        saveDateTime: saveDateTime,
        isEnd: isEnd);
    final fishResultBox = Hive.box(fishResultBoxName);
    final lureDataBox = Hive.box(lureDataBoxName);
    ret.fishResults = HiveList(fishResultBox);
    ret.lureData = HiveList(lureDataBox);
    ret.fishResults = fishResults;
    ret.lureData = lureData;
    return ret;
  }

  //指定した魚種の釣果数を返す
  int getCount(int fishId) {
    int ret = 0;
    fishResults.forEach((val) {
      if (val.fishId == fishId && val.resultKbn == enumResult.success.index) {
        ret++;
      }
    });
    return ret;
  }

  //釣果の最小サイズを返す
  double getMinSize(int fishId) {
    var minSize = 1.1;
    fishResults.forEach((val) {
      if (val.fishId == fishId && val.resultKbn == enumResult.success.index) {
        if (minSize > val.size) {
          minSize = val.size;
        }
      }
    });
    if (minSize == 1.1) minSize = 0.0;
    return minSize;
  }

  //釣果の最大サイズを返す
  double getMaxSize(int fishId) {
    var maxSize = -0.1;
    fishResults.forEach((val) {
      if (val.fishId == fishId && val.resultKbn == enumResult.success.index) {
        if (maxSize < val.size) {
          maxSize = val.size;
        }
      }
    });
    if (maxSize == -0.1) maxSize = 0.0;
    return maxSize;
  }

  //ルアー替え処理
  changeLure(enumLureDiv en) async {
    useLureIdx = en.index;
    await this.save();
  }

  //ルアー重さ替え処理
  changeLureWeight(int idx) async {
    lureData[useLureIdx].useWeightId = idx;
    lureData[useLureIdx].save();
    await this.save();
  }

  //指定したルアーデータを返す
  typLureData getLureData(enumLureDiv en) {
    return lureData[en.index];
  }

  //現在使用中のルアーデータを返す
  typLureData getUseLure() {
    return getLureData(enumLureDiv.values[useLureIdx]);
  }

  //ルアーの重さを取得
  double getLureWeight(int id) {
    double ret = 0.0;
    //IDの存在チェック
    if (LST_LURE_WEIGHT.length > id + 1) {
      ret = LST_LURE_WEIGHT[id];
    }
    return ret;
  }

  //現在使用中の重さを取得
  double getUseLureWeight() {
    return getLureWeight(useLureIdx);
  }

  //ルアー種による色を取得
  Color getLureColor(enumLureDiv en) {
    var ret;
    switch (en) {
      case enumLureDiv.jig:
        ret = Colors.cyan[500];
        break;
      case enumLureDiv.tairaba:
        ret = Colors.red[200];
        break;
      case enumLureDiv.slowjig:
        ret = Colors.green[200];
        break;
    }
    return ret;
  }

  //現在使用中ルアーの色を取得
  Color getUseLureColor() {
    return getLureColor(enumLureDiv.values[useLureIdx]);
  }

  //累計EXPから現在のレベルを取得
  int getLv() {
    int retLv = 1;
    double nextExp = basicExp;
    double divExp = nextExp;
    //最大レベルまでループ
    while (retLv < maxLv) {
      if (lureData[useLureIdx].totalExp >= divExp) {
        retLv++;
      } else {
        //現Lv判明時にループ抜け
        break;
      }
      //次Lvに必要なEXP
      nextExp = nextExp * 1.1;
      divExp += nextExp;
    }
    //現レベルを返す
    return retLv;
  }

  //次のレベルまでのEXPを返す
  int getNextLvExp() {
    //既に最大レベルの場合は-1を返す
    if (lureData[useLureIdx].lv >= maxLv) return -1;
    //次Lvの合計EXPと現EXPの差分を返す
    return (getExp(lureData[useLureIdx].lv + 1) - lureData[useLureIdx].totalExp)
        .floor();
  }

  //指定したレベルに必要な累計EXPを返す
  double getExp(int nextLv) {
    double exp = basicExp;
    //次Lvに必要な合計EXPを算出
    for (int iLv = 1; iLv < nextLv; iLv++) {
      exp = exp * 1.1;
    }
    return exp;
  }

  //レベルアップ処理
  String lureLvUp() {
    String ret = "";
    //既に最大レベルの場合はなにもしない
    if (lureData[useLureIdx].lv >= maxLv) return ret;
    int oldLv = lureData[useLureIdx].lv;
    //新レベルの値をセット
    lureData[useLureIdx].lv = getLv();
    //現レベル-新レベル間ループ
    for (int i = oldLv; i < lureData[useLureIdx].lv; i++) {
      //fall成長
      lureData[useLureIdx].fall =
          lureStsUp(lureData[useLureIdx].fall, lureData[useLureIdx].lvAddFall);
      //reeling成長
      lureData[useLureIdx].reeling = lureStsUp(
          lureData[useLureIdx].reeling, lureData[useLureIdx].lvAddReeling);
      //jerk成長
      lureData[useLureIdx].jerk =
          lureStsUp(lureData[useLureIdx].jerk, lureData[useLureIdx].lvAddJerk);
    }
    ret = lureData[useLureIdx].name +
        "がレベルアップ Lv " +
        oldLv.toString() +
        " → " +
        lureData[useLureIdx].lv.toString();

    //3レベル毎に新しい重さをアンロック
    //int maxWeightId = weightList.list.length;
    String strWeight = "";
    int newWeightId = (lureData[useLureIdx].lv ~/ 3);
    if (lureData[useLureIdx].unLockweightid < newWeightId) {
      for (var i = lureData[useLureIdx].unLockweightid + 1;
          i <= newWeightId;
          i++) {
        strWeight += LST_LURE_WEIGHT[i].toString() + "g ";
      }
    }
    lureData[useLureIdx].unLockweightid = newWeightId;
    if (strWeight != "") {
      ret += "\n" + strWeight + "が使えるようになった";
    }
    //変更を保存
    lureData[useLureIdx].save();
    //this.save();  //呼び出し元でセーブするのでここではしない
    return ret;
  }

  double lureStsUp(double old, double add) {
    double ret = old + add;
    if (ret >= 1.0) ret = 1.0;
    return ret;
  }

  //ルアーレベルダウン処理
  lureLvDown() {
    //現在1レベルの場合はなにもしない
    if (lureData[useLureIdx].lv <= 1) return;

    //新レベルの値をセット
    lureData[useLureIdx].lv = lureData[useLureIdx].lv - 1;
    //累計EXPセット
    lureData[useLureIdx].totalExp = getExp(lureData[useLureIdx].lv);
    //fallマイナス
    lureData[useLureIdx].fall =
        lureData[useLureIdx].fall - lureData[useLureIdx].lvAddFall;
    //reelingマイナス
    lureData[useLureIdx].reeling =
        lureData[useLureIdx].reeling - lureData[useLureIdx].lvAddReeling;
    //jerkマイナス
    lureData[useLureIdx].jerk =
        lureData[useLureIdx].jerk - lureData[useLureIdx].lvAddJerk;
    //変更を保存
    lureData[useLureIdx].save();
    this.save();
  }
}
