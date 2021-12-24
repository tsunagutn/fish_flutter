//☆基本概要
//・モード１：ずっとモード
//　　　　　　好きなロケ、道具等で好きにできる、状態保存して続きからできる
//・モード２：だんだん条件が厳しくなる

//☆残タス
//済・ソナー光点をアニメーション光るにする
//済・HIT率でソナー光点の色を変える or 光る頻度を変える
//済・背景（メインのところ）をソナーにする。
//済・ソナーを画像じゃなく描画にする。
//済・テンションバーを指数的にする。
//済・糸巻中はスピードバーの色変える
//済・深さの変化に傾向をつける
//済・テンションによってテンションバーの色可変
//済・深さ表示をやっぱり上にする
//済・棚の可変化
//済・海上の範囲を描画
//済・海面の波
//済・船押して船長呼び出しの機能 深いとこ／浅いとこ行って欲しい機能
//済・船長呼び出しボタン→子メニュー（ポップアップ？横メニュー？）で選択→船長絵「わかった」
//済・水深によってバックの色の濃さ変える
//済・海底を描画（波と同じようなロジックでいける？）
//済・魚種毎にいい棚の設定
//済・魚種毎にいい速度の設定
//済・ソナーの0m地点に水面とか船の画像。
//済・スライダー関係を全部canvasにする
//済・テンションバーのデザインが変
//済・テンションバー 危ないときアニメーション光るようにする
//済・テンションとスピードバーのデザインを整備 スライダーじゃなくする？
//済・ソナーに反応光点描画にする。
//済・テンション連動点滅がおかしい
//済・魚種毎に大きさ範囲
//済・ドラグが出てる時はどっか揺らすみたいな
//済・ヘッダを大改修
//済・画面左に竿リール表示
//済・竿リール表示を左右切り替えるやつを反対側に
//済・ロッドの曲がりを表現
//済・アワセシステム
//済・魚種毎にバレ条件の設定
//済・アワセの上手くいきかたで初期バラシレベルが決まるみたいな
//済・バレシステムを何とかする
//・波の下の罫線が気になる、波をBOTTOMで描画すれば解決かも？→しない
//済・HIT時にHIT宣言とアワセ評価を画面中央に出す目立つ
//済・魚図鑑画面
//済・%を表示してる方がおもしろい・・・
//済・ルアー変更
//済・意図のスライダーをテンションとひっつける
//済・糸のHPシステム？糸切れ値でぷっつり行くのが何か変
//済・魚詳細画面
//済・魚種毎に巻き志向←→リアクション志向
//済・魚種毎に底生志向
//済・上下ドラッグで動かす、ジグのシャクリ
//済・大きさでHP可変
//済・タックル変更モーダルに閉じるボタン
//済・自分で船動かす 0m時に左右矢印表示
//済・船動くときに魚反応動かして動いてるのわかるようにする
//済・ワンタッチで回収ボタン
//済・船動かすときにポイント使うようにする
//済・超過画面出すときに画面全体光らす
//・雲
//済・ゲームオーバー無しにする
//・王冠つきじゃないと詳細アンロックしない
//・魚種毎に実績
//・ルアー耐久システム
//・設定画面 合わせの強さ調節
//・音
//・実績
//・いけすシステム
//・赤ポイント緑ポイント青ポイント
//・光点が横に走る
//・水流
//・水中に泡とか
//・海底に漁礁とか
//・通知インフォメーション 今が時合で！みたいな
//・ポイントで色々　道具買ったり、糸替え、船長指示、ゲームオーバーから復活とか
//・HIT時につっこみモード、おとなしいモードつけて勢い度
//・糸切れ判定 勢い度を加味して切れるようにする
//・魚種データをDB化して登録画面実装
//・エリア選択 エリアによって魚種、深さ等変える
//・チュートリアル
//夢
//・アワセシステム ARVRモード時はスマホをジャイロで動かす、通常時は下にドラッグでアワセ
//・背景にAR的なカメラ映像（カメラ無いときはアニメーション）
//・背景にrod、ジャイロで動かす

import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:fish_flutter/Model/HaveTackleModel.dart';
import 'package:fish_flutter/Model/SpeedRange.dart';
import 'package:fish_flutter/widget/BookDialog.dart';
import 'package:fish_flutter/widget/FishRangeSliderPainter.dart';
import 'package:fish_flutter/widget/LightSpot.dart';
import 'package:fish_flutter/widget/RadarChart.dart';
import 'package:fish_flutter/widget/TapPointer.dart';
import 'package:fish_flutter/widget/FishPointer.dart';
import 'package:fish_flutter/widget/WaveClipper.dart';
import 'package:fish_flutter/widget/SenchoDialog.dart';
import 'package:fish_flutter/widget/SliderPainter.dart';
import 'package:fish_flutter/widget/fishGetDialog.dart';
import 'package:fish_flutter/widget/tacklePainter.dart';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';

class Fishing extends StatefulWidget {
  Fishing({Key? key}) : super(key: key);

  @override
  _FishingState createState() => _FishingState();
}

// つりページのステータス管理
class _FishingState extends State<Fishing> with TickerProviderStateMixin {
  //定数の定義？？？いろいろ環境設定にした方がいいかと

  //デバッグフラグ すぐつれちゃう
  static const DEBUGFLG = true;
  //static const DEBUGFLG = false;

  //魚種定義
  late FishsModel FISH_TABLE;
  //ルアーリスト定義
  late LuresModel lures;
  //所持定義
  late HaveTackleModel haveTackle;

  //光点の点滅速度
  static const Map<int, int> POINT_DURATION_MSEC = {
    0: 50,
    1: 100,
    2: 300,
    3: 700,
    4: 1000,
    5: 2000,
  };

  //static const TIMER_INTERVAL = 50; //1スキャン時間(msec) 20FPS
  static const TIMER_INTERVAL = 33; //1スキャン時間(msec) 30FPS
  //static const TIMER_INTERVAL = 17; //1スキャン時間(msec) 60FPS
  static const TENSION_VAL_MAX = 300.0; //テンションスライダーMAX値
  static const TENSION_VAL_MIN = 0.0; //テンションスライダーMIN値
  static const TENSION_LINECUT = 290.0; //糸切れ判定値
  static const SPEED_VAL_MAX = 300.0; //巻き速度スライダーMAX値
  static const SPEED_VAL_MIN = 0.0; //巻き速度スライダーMIN値
  static const HOSEI_MAX = 3;
  //static const BARE_MAX = 20; //バレ判定条件成立からバレ発生までのスキャン数 ？？？魚のでかさによって可変にするべき
  static const MAX_RAND_ADD_TENSION = 2; //何もしてない時テンションがウロウロするののMAX値
  static const MIN_RAND_ADD_TENSION = -11; //〃 MIN値
  final TENSION_COLOR_SAFE = clsColor._getColorFromHex("4CFF00");
  final TENSION_COLOR_DRAG = clsColor._getColorFromHex("FFD800");
  final TENSION_COLOR_DANGER = clsColor._getColorFromHex("DD0000");
  final SPEED_COLOR = clsColor._getColorFromHex("83BBE2");
  final SPEED_COLOR_REELING = clsColor._getColorFromHex("0026FF");
  static const DEPTH_CHANGE_SCAN = 500; //このスキャン毎に深さの変化傾向が変わる
  static const JIAI_CHANGE_SCAN = 1500; //このスキャン毎に時合度が変わる
  static const TANA_CHANGE_SCAN = 3000; //このスキャン毎にタナが変わる
  static const POINTER_SIZE = 5.0; //ソナー光点の基本サイズ
  static const POINTER_BACK_SIZE = 4.0; //ソナー光点後光の最大サイズ
  static const ROD_STANDUP_MAX = 100.0; //竿立て度MAX
  static const JERK_SCAN = 10; //ジャークの継続スキャン数
  // static const BAIT_CNT_MAX = 30; //アタリ判定期間
  // static const FOOKING_TENSION = 150; //アワセ成功閾値
  static const MOVE_FISHPOINTER_MAX = 20.0; //最高速度 +-0.5の時の魚反応光点移動量

  static const SHIP_MOVE_POINT = 1; //船移動時の1スキャンポイント消費
  //static const Map<int, double> DEPTH_CHANGE_ORDERS = {0: 0.5, 1: 0.45, 2: 0.55};
  static const Map<int, double> DEPTH_CHANGE_ORDERS = {0: 0.5, 1: 0.2, 2: 0.8};

  // グローバル変数としてGlobalKey型の変数（プロパティ）を定義
  GlobalKey globalKeySonar = GlobalKey();
  GlobalKey globalKeyShore = GlobalKey();
  GlobalKey globalKeyBottom = GlobalKey();

  //アニメーション関連
  late AnimationController _animationController; //光点の光アニメーション
  late Animation<double> _animationRadius;
  late AnimationController _centerTextAnimationController; //画面中央に出すテキストアニメーション
  late Animation<double> _centerTextLeft;
  late AnimationController
      _tackleMenuAnimationController; //タックルメニューをフワフワさすアニメーション
  late Animation<double> _tackleMenuAnime;
  late AnimationController _jerkTextAnimationController; //ジャーク時のテキストアニメーション
  late Animation<double> _jerkTextLocation;

  //状態フラグ変数
  var _onTap = false; //現在タップ中フラグ
  var _onClutch = false; //現在クラッチ状態
  var _flgBait = false; //現在アタリ中フラグ
  var _flgHit = false; //現在HIT中フラグ
  //var _flgGameOver = false; //現在ゲームオーバーフラグ

  //ステート変数
  var _tension = 0.0; //テンション値
  var _drag = 250.0; //ドラグレベル値
  var _speed = 0.0; //巻き速度値
  var _depth = 0.0; //現在糸出し量(0.1m)
  var _maxDepth = 187.0; //最大水深(0.1m)
  var _dispDepth = '0.0 m'; //深さ表示用
  //var _dispInfo = '0.00 %'; //HIT率表示用（デバッグ用）
  var _tensionActiveTrackColor =
      clsColor._getColorFromHex("4CFF00"); //テンションゲージの色
  var _flgShaKe = false; //ドラグスライダーを揺らす用
  var _speedActiveTrackColor = clsColor._getColorFromHex("0094FF"); //スピードゲージの色
  var _infoBackColor = Colors.white; //HIT率表示の背景色（デバッグ用）
  var _clutchBackColor = Colors.red; //クラッチボタンの背景色
  Color _pointerColor = Colors.yellow; //ソナー部光点の色
  var _lightSpotY = 0.0; //ソナー部光点TOP
  var _lightSpotX = 50.0; //ソナー部光点LEFT
  var _point = 0; //獲得ポイント
  var _justTana = 0.5; //HIT確率判定 時合棚 0.0～1.0
  var _justTanaRange = 50.0; //0.1m単位 +-までは時合圏内
  var _tanaChangeScanCnt = 0; //棚変化スキャンカウント数
  var _jiai = 0.9; //時合度 0.0～0.9999...
  var _jiaiChangeScanCnt = 0; //時合度の変化スキャンカウント数
  var _maxLineHp = 50.0; //ラインHP最大値
  var _nowLineHp = 50.0; //現在ラインHP

  List<SpeedRange> _listSpeedRange = []; //可能性ある魚種毎のスピード範囲

  var _cursorX = 0.0; //ドラッグ操作開始時の座標X
  var _cursorY = 0.0; //ドラッグ操作開始時の座標Y
  var _jerkCnt = 0; //ジャークの継続スキャン数

  var _baitCnt = 0; //当たってからのスキャン数
  var _baitMaxTension = 0.0; //バイト中の最大テンション
  var _fookingLv = 0.0; //フッキングの成功度

  var _fishidx = 0; //現在HIT中の魚種IDX
  var _fishSize = 0.0; //現在HIT中の魚の大きさ MAXを1.0とした時の割合
  var _hitScanCnt = 0; //HITしてからのスキャン数
  var _bareCnt = 0; //バレ判定カウント

  var _depthChange = 0.5; //深さの変化傾向 1.0～0,0 +なら深くなる、-なら浅くなる
  var _depthChangeScanCnt = 0; //深さの変化傾向スキャンカウント数
  var _depthChangeOrder = 0; //変化傾向 初期値は現状維持
  var _dispDepthLv1 = 0.45; //深さ画面色変える 中層 0m：1.0 70m：0.8
  var _dispDepthLv2 = 0.9; //深さ画面色変える 深層 0m：1.0 100m：0.9

  var _nowDurationLv; //光点点滅レベル
  var _shoreHeight = 0.0;
  var _bottomHeight = 0.0;

  var _centerTextMain = "";
  var _centerTextMainColor = Colors.red;
  var _centerTextSub = "";
  var _centerTextSubColor = Colors.black;
  var _senchoMessage = ""; //船長の発言

  late Offset offset = Offset(0.0, 0.0);
  late double _appBarHeight = 0.0;

  late AnimationController waveController; // AnimationControllerの宣言

  var _ligntSpotAnimationChangeing = false;

  //タックルの描画関連
  var _tackleCenterX = 0.0;
  var _rodSizeX = 0.0;
  var _rodSizeY = 0.0;
  var _reelSizeX = 0.0;
  var _reelSizeY = 0.0;
  var _reelCenterY = 0.0;
  var _takclePositionLeft = true;
  var _takcleChangeButtonPosition = MainAxisAlignment.end;
  var _rodStandUp = 0.0;

  //タックル変更モーダル表示非表示
  var _showTacleChangeDialog = false;
  //タックル変更モーダル内で選択している種類
  var _selectTacleIcon = '';

  //釣果リスト
  late FishesResultModel fishesResult;

  //船移動
  // var _MoveLeft = false;
  // var _MoveRight = false;
  //船加速度の目標値
  var _moveShipTarget = 0.5;

  var _collect = false; //高速回収中フラグ

  //ドラグ音
  // var url = "./static/sound/drag.mp3";
  // var audio = new Audio(url);

  @override
  void initState() {
    //魚テーブルを初期化？？？本当はエリアで絞る
    FISH_TABLE = new FishsModel();
    //釣果リストを初期化
    fishesResult = new FishesResultModel();
    //ルアーリストを初期化？？？本当はDBマスタから全取得
    lures = new LuresModel();
    //所持リストを初期化
    haveTackle = new HaveTackleModel();

    // buildメソッドが回り、AppBarの描画終了後に、GlobalKeyの情報を取得するようにするため、
    // addPostFrameCallbackメソッドを実行
    // null safety対応で?（null以外の時のみアクセス）をつける
    WidgetsBinding.instance?.addPostFrameCallback((cb) {
      //AppBarの高さを取得
      _appBarHeight = AppBar().preferredSize.height;

      //定周期タイマの開始
      Timer.periodic(
        Duration(milliseconds: TIMER_INTERVAL),
        _onTimer,
      );
    });

    //光点アニメーションの初期化
    _nowDurationLv = POINT_DURATION_MSEC.length - 1; //初期値は最大値
    ligntSpotAnimation(true, POINT_DURATION_MSEC[_nowDurationLv]!);

    waveController = AnimationController(
      duration: const Duration(seconds: 3), // アニメーションの間隔を3秒に設定
      vsync: this, // おきまり
    )..repeat(); // リピート設定

    _centerTextAnimationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    _jerkTextAnimationController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);

    _tackleMenuAnimationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    //アニメーションの定義
    _tackleMenuAnimationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _tackleMenuAnime = Tween(begin: 0.0, end: 1.0)
        .animate(_tackleMenuAnimationController)
        .drive(CurveTween(curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
    _tackleMenuAnimationController.repeat(reverse: true);

    super.initState();
  }

  void dispose() {
    _animationController.dispose();
    waveController.dispose(); // AnimationControllerは明示的にdisposeする。
    _centerTextAnimationController.dispose();
    _tackleMenuAnimationController.dispose();
    _jerkTextAnimationController.dispose();
    fishPointerList.clear();
    super.dispose();
  }

  //定周期処理
  void _onTimer(Timer timer) {
    if (!mounted) {
      //既に画面が無効の場合は無処理
      return;
    }

    // if (_flgGameOver) {
    //   //ゲームオーバー中は無処理
    //   return;
    // }

    num addVal = 0;
    var mx = MAX_RAND_ADD_TENSION;
    var mn = MIN_RAND_ADD_TENSION;
    var weight = 0;
    //画面サイズ取得用
    final Size size = MediaQuery.of(context).size;

    //ソナー部のY位置と高さを取得
    var sonarWidget =
        globalKeySonar.currentContext?.findRenderObject() as RenderBox;
    var sonarHeight = sonarWidget.size.height;
    var sonarTop = sonarWidget.localToGlobal(Offset.zero).dy;

    //海上部の高さ
    var shoreWidget =
        globalKeyShore.currentContext?.findRenderObject() as RenderBox;
    _shoreHeight = shoreWidget.size.height;

    //海底部の高さ
    var bottomWidget =
        globalKeyBottom.currentContext?.findRenderObject() as RenderBox;
    _bottomHeight = bottomWidget.size.height;

    //共通乱数 0.0～0.999... の乱数の作成 ※共通じゃだめなところには使っちゃだめ
    var rand = (new math.Random()).nextDouble();

    // //深さの変化傾向判定
    // _depthChangeScanCnt++;
    // if (_depthChangeScanCnt > DEPTH_CHANGE_SCAN) {
    //   _depthChangeScanCnt = 0;
    //   _depthChange = DEPTH_CHANGE_ORDERS[_depthChangeOrder]! +
    //       ((DEPTH_CHANGE_ORDERS[_depthChangeOrder]! - rand) / 10);
    //   debugPrint("深さ変化傾向" + _depthChange.toString());
    // }

    //時合の変化判定
    _jiaiChangeScanCnt++;
    if (_jiaiChangeScanCnt > JIAI_CHANGE_SCAN) {
      _jiaiChangeScanCnt = 0;
      _jiai = (new math.Random()).nextDouble();
      debugPrint("時合度" + _jiai.toString());
    }

    //タナの変化判定
    _tanaChangeScanCnt++;
    if (_tanaChangeScanCnt > TANA_CHANGE_SCAN) {
      _tanaChangeScanCnt = 0;
      _justTana = (new math.Random()).nextDouble();
      debugPrint("タナ" + _justTana.toString());
    }

    //ジャーク継続スキャンカウントダウン
    _jerkCnt--;
    if (_jerkCnt < 0) {
      _jerkCnt = 0;
    }

    //船移動
    if (_moveShipTarget > _depthChange) {
      _depthChange += 0.01;
    }
    if (_moveShipTarget < _depthChange) {
      _depthChange -= 0.01;
    }
    //船移動中
    if (_depthChange != 0.5) {
      //魚反応を移動させる
      fishPointerList.forEach((element) {
        //描画ごとにglovalkeyを付けているのでそれにアクセス
        RenderCustomPaint obj = element.painterKey.currentContext
            ?.findRenderObject() as RenderCustomPaint;
        FishPainter obj2 = obj.painter as FishPainter;
        //addxの値を加減算で移動
        obj2.addX += MOVE_FISHPOINTER_MAX * (_depthChange - 0.5) * -1;
      });
    }
    //船移動の指示中
    if (_moveShipTarget != 0.5) {
      if (_point > 0) {
        //ポイント消費
        _point -= SHIP_MOVE_POINT;
      }
      if (_point <= 0) {
        //ポイント切れ
        _point = 0;
        _moveShipTarget = 0.5;
      }
    }
    //座礁判定
    if (_maxDepth < 1.0) {
      //これ以上浅くいけない
      _maxDepth = 1.0;
      if (_moveShipTarget < 0.5) _moveShipTarget = 0.5;
    }

    //ルアー重さ
    var lureWeight =
        lures.getLureData(haveTackle.getUseLure().lureId).weight.floor();
    if (_flgBait || _flgHit) {
      //debugPrint("HIT中1");
      //魚残HPの計算
      if (_hitScanCnt > 0) {
        var minusHp = 1;
        //テンションが200以上
        if (_tension > 200.0) {
          //200との差分の10分の1を補正として加算
          minusHp += ((_tension - 200.0) / 10).floor();
        }
        //テンションが強いほどマイナス値を上げる
        _hitScanCnt -= minusHp;
        if (_hitScanCnt < 0) _hitScanCnt = 0;
      }
      //アタリ中 or HIT中 テンション増減にHIT中補正をかける
      var fish = FISH_TABLE.fishs[_fishidx];
      mx += fish.addMax * (_hitScanCnt / fish.hp * _fishSize).round();
      mn += fish.addMin * (_hitScanCnt / fish.hp * _fishSize).round();
      weight = fish.weight + lureWeight;
    } else {
      //HIT中でない時はルアー重さで補正をかける
      weight = lureWeight;
    }
    addVal = (rand * (mx + 1 - (mn))).floor() + (mn) + (weight / 200);

    if (_collect) {
      //高速回収中
      _depth -= _maxDepth / 10;
      _onClutch = false;
      addVal = HOSEI_MAX * -1;
    } else if (_onClutch) {
      //クラッチON中はマイナス補正を最大化
      addVal = HOSEI_MAX * -1;
      //水深を加算
      //ルアー重さによってフォール速度に補正をかける 60gの時0.1m/スキャン
      _depth += (lures.getLureData(haveTackle.getUseLure().lureId).weight / 60);
    } else {
      if (_onTap) {
        //巻きスピード
        var hosei = (_speed % SPEED_VAL_MAX) % HOSEI_MAX;
        //var hosei = (_speed % SPEED_VAL_MAX);
        //タップ中は補正を加味する
        addVal += hosei.round();
        //水深減算
        _depth = _depth - _speed / SPEED_VAL_MAX;
      } else {
        if (!_flgBait && !_flgHit) {
          //巻いていない&釣れていない時はマイナス補正
          addVal -= HOSEI_MAX;
        }
      }

      //debugPrint(_rodStandUp.toString());
      //シャクリによるテンション増加？？？竿長さによって係数を可変にする
      addVal += _rodStandUp * 35;
      //シャクリによる水深減算
      _depth -= _rodStandUp * 2;
    }
    if (addVal > 0) {
      //テンション+時は現在テンションによって補正をかける
      //addVal * ((TENSION_VAL_MAX - _tension) / TENSION_VAL_MAX);
      //二次関数 テンション上がるごとに上がりにくくする
      addVal = addVal +
          (addVal * -1) * (MathPow._getPow(2, (_tension / TENSION_VAL_MAX)));
    }
    var val = _tension + addVal;

    // //ゲームオーバー判定
    // var gameovertext = "";
    //糸ダメージ判定
    if (val > TENSION_LINECUT) {
      _nowLineHp--; //ラインHPを減らす
      if (_nowLineHp < 0) {
        //糸切れ
        debugPrint("いときれ");
        //HITメッセージ
        _centerTextMain = "BREAK";
        _centerTextMainColor = Colors.red;
        _centerTextSub = "糸が切れちまった!";
        _centerTextSubColor = Colors.yellow;
        startCenterInfo();
        //使用中のルアーを削除
        haveTackle.lostLure(haveTackle.getUseLure().id);
        _flgBait = false;
        _flgHit = false;
      }
    }
    // //座礁
    // debugPrint("座礁");
    //   _flgGameOver = true;
    //   gameovertext = "船が座礁しました。\nゲームオーバーです。\nゲームオーバーなのもう何もできません";
    // }
    // if (gameovertext != "") {
    //   //ゲームオーバーモーダル
    //   var result = showDialog<int>(
    //       context: context,
    //       barrierDismissible: false,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: Text("あーあ"),
    //           content: Column(children: <Widget>[
    //             Text(gameovertext),
    //             Text("あなたは" + _point.toString() + "ポイント獲得して終わりました"),
    //           ]),
    //           actions: <Widget>[
    //             FlatButton(
    //               child: Text("メニューに戻ることしかできません"),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //             ),
    //           ],
    //         );
    //       });
    //   return;
    // }

    //ドラグ判定
    var dragVal = _drag;
    //_tensionActiveTrackColor = TENSION_COLOR_SAFE;
    if (val > dragVal) {
      //テンションとドラグレベルの差分
      var dragDiff = val - dragVal;
      //ドラグ出た分深さを増やす？？？出すぎ？
      _depth = _depth + dragDiff / 30;
      //ドラグ出た分テンションを減らす？？？減らなすぎ？
      val = val - (dragDiff / 25);
      //テンションゲージの色を変える
      _tensionActiveTrackColor = TENSION_COLOR_DRAG;
      //audio.currentTime = 0;
      //audio.play();
      //var duration = 200; // 振動時間
      //navigator.vibrate(duration);
    } else {
      //   //テンションMAX（切れそう）判定 最大値の9割で切れそうと判定
      //   if (val >= (TENSION_VAL_MAX * 0.9)) {
      //     _tensionActiveTrackColor = TENSION_COLOR_DANGER;
      //   }
    }

    if (val > TENSION_VAL_MAX) val = TENSION_VAL_MAX;
    if (val < TENSION_VAL_MIN) val = TENSION_VAL_MIN;

    if (_depth > _maxDepth) _depth = _maxDepth;
    if (_depth <= 0) {
      //深さ0m
      _depth = 0.0;
      //ラインHPを回復
      _nowLineHp = _maxLineHp;
      //高速回収中フラグをリセット
      _collect = false;
    }

    //テンション確定
    _tension = val;

    //テンションによってテンションバーの色を変える
    _tensionActiveTrackColor = clsColor._getColorRange(
        TENSION_COLOR_SAFE, TENSION_COLOR_DANGER, _tension, TENSION_VAL_MAX);

    //水深表示
    _dispDepth = ((_depth).round() / 10).toStringAsFixed(1) +
        " / " +
        ((_maxDepth).round() / 10).toStringAsFixed(1) +
        ' m';

    //光点表示位置設定
    if (_takclePositionLeft) {
      _lightSpotX = size.width * (2 / 3);
    } else {
      _lightSpotX = size.width * (1 / 3);
    }
    _lightSpotY =
        ((_depth / _maxDepth) * (size.height - _shoreHeight - _bottomHeight));

    //背景色
    if (_maxDepth < 100) {
      //水深10mまでは中層の範囲は固定
      _dispDepthLv1 = 1.0;
    } else {
      //水深150mで0.1にする
      _dispDepthLv1 = ((_maxDepth - 100) / 1400) * -0.9 + 1;
      //debugPrint(_dispDepthLv1.toString());
    }
    if (_maxDepth < 1000) {
      //水深10mまでは深層の範囲は固定
      _dispDepthLv2 = 1.0;
    } else {
      //水深500mで0.1にする
      _dispDepthLv2 = ((_maxDepth - 1000) / 4000) * -0.9 + 1;
    }

    //釣り上げ判定
    if (_flgHit && _depth <= 0) {
      _flgBait = false;
      _flgHit = false;
      _pointerColor = clsColor._getColorFromHex("ffd900");
      _nowDurationLv = POINT_DURATION_MSEC.length - 1;
      debugPrint("つりあげ");
      var fish = FISH_TABLE.fishs[_fishidx];
      //debugPrint("おおきさ" + size.toString());
      var point = fish.point + (fish.point * _fishSize).floor();
      //ポイントを加算
      _point += point;
      //初釣果判定
      var flgNew = true;
      fishesResult.listFishResult.forEach((val) {
        if (val.fishId == fish.id) {
          flgNew = false;
          return;
        }
      });
      //釣果リストに登録
      fishesResult.addResult(fish.id, _fishSize);
      //釣りあげ時のモーダル
      var result = showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Stack(
            children: [
              //釣りあげダイアログ
              fishGetDialog(
                  dispSize: size,
                  fish: fish,
                  fishSize: _fishSize,
                  addPoint: point,
                  flgNew: flgNew),
            ],
          );
        },
      );
      _depth = 0.0;
    }

    //光点点滅速度関連の変数
    final durationMax = POINT_DURATION_MSEC[POINT_DURATION_MSEC.length - 1]!;
    final durationMin = POINT_DURATION_MSEC[0]!;
    var duration = POINT_DURATION_MSEC[_nowDurationLv]!;

    if (!(_flgBait || _flgHit || _collect)) {
      var flgFall = false;
      var flgMaki = false;
      var flgJerk = false;
      //現在の状態
      if (_depth > 0) {
        if (_jerkCnt > 0) {
          //ジャーク状態の継続
          flgJerk = true;
        } else {
          if (_onClutch && _depth < _maxDepth) {
            //糸出中、かつ水深MAXではない時はフォール中
            flgFall = true;
          } else if (_tensionActiveTrackColor != TENSION_COLOR_DRAG &&
              _rodStandUp > 0.5 &&
              _depth < _maxDepth) {
            //ドラグ出中ではない、ロッド操作による補正中、水深0mやMAXではない時はジャーク中
            flgJerk = true;
            _jerkCnt = JERK_SCAN; //一度ジャークと判定されたら一定スキャン数ジャーク継続
          } else if (_tensionActiveTrackColor != TENSION_COLOR_DRAG &&
              _onTap &&
              _depth < _maxDepth) {
            //ドラグ出中ではない、リーリング中、水深0mやMAXではない時は巻き中
            flgMaki = true;
          }
        }
      }

      if (flgFall || flgMaki || flgJerk) {
        //アタリ判定処理
        var hitTanaProb = 0.0;
        //HIT棚との差分
        final justTana = (_maxDepth * _justTana);
        var tanaDiff = (_depth - justTana).abs();
        //差分が範囲内か
        if (tanaDiff < _justTanaRange) {
          hitTanaProb =
              1.0 * ((tanaDiff - _justTanaRange).abs() / _justTanaRange);
        }
        if (hitTanaProb < 0.2) {
          hitTanaProb = 0.2; //棚範囲外の最低保証
        }

        //現在底付近か？
        var bottom = (_depth > (_maxDepth * 0.8)) ? true : false;
        // //深さから可能性のある種を抽出
        var fishs = FISH_TABLE.extractDepth(depth: _depth, bottom: bottom);

        var maxProb = 0.0;
        _listSpeedRange = []; //速度リスト初期化
        duration = durationMax;
        //種毎の判定
        fishs.forEach((fish) {
          var hitSpeedprob = 0.0;
          var hitSpeedprobDisp = 0.0;
          var hitProb = 0.0;
          if (flgFall) {
            //フォール中のHIT率判定 魚のフォール志向 * ルアーのフォール能力
            hitSpeedprob = fish.hitFall *
                lures.getLureData(haveTackle.getUseLure().lureId).fall;
            hitSpeedprobDisp = 0.0; //フォール中は巻き速度手本を見せない
            //HIT確率の算出 フォールは時合の影響を半分にする
            hitProb = (hitTanaProb * hitSpeedprob * ((1.0 + _jiai) / 2)) *
                fish.wariai /
                100;
          } else if (flgJerk) {
            //ジャーク中のHIT率判定 魚のジャーク志向 * ルアーのジャーク能力
            hitSpeedprob = fish.hitJerk *
                lures.getLureData(haveTackle.getUseLure().lureId).jerk;
            hitSpeedprobDisp = 0.0; //ジャーク中は巻き速度手本を見せない
            //HIT確率の算出 ジャークは時合の影響を半分にする
            hitProb = (hitTanaProb * hitSpeedprob * ((1.0 + _jiai) / 2)) *
                fish.wariai /
                100;
            //debugPrint("じゃーく" + hitSpeedprob.toString());
            //ジャーク表示
            startJerk();
          } else if (flgMaki) {
            //巻き中のHIT率判定
            //HITスピードとの差分
            var speedDiff = (_speed - fish.hitSpeedJust).abs();
            //差分が範囲内か
            if (speedDiff < fish.hitSpeedRange) {
              //巻き中のHIT率判定 HITスピード理想値との乖離割合 * 魚の巻き志向 * ルアーの巻き能力
              hitSpeedprob = ((speedDiff - fish.hitSpeedRange).abs() /
                      fish.hitSpeedRange) *
                  fish.hitMaki *
                  lures.getLureData(haveTackle.getUseLure().lureId).reeling;
            }
            if (hitSpeedprob < 0.1) {
              hitSpeedprob = 0.1; //速度範囲外の最低保証
            }
            hitSpeedprobDisp = hitSpeedprob;
            hitProb = (hitTanaProb * hitSpeedprob * _jiai) * fish.wariai / 100;
          }
          // //HIT確率の算出
          // var hitProb =
          //     (hitTanaProb * hitSpeedprob * _jiai) * fish.wariai / 100;

          //全魚種で最も高い確率の取得
          if (hitTanaProb * hitSpeedprob > maxProb) {
            maxProb = hitTanaProb * hitSpeedprob * _jiai * fish.wariai;
          }
          //魚種毎の速度レンジと確率を記憶（描画用）
          _listSpeedRange.add(new SpeedRange(
              justSpeed: fish.hitSpeedJust,
              rangeSpeed: fish.hitSpeedRange,
              hitSpeedProb: hitSpeedprobDisp));

          //1～0の乱数生成
          var hitrnd = (new math.Random()).nextDouble();
          if (DEBUGFLG) {
            //すぐつれる
            hitrnd = 0.0005;
          }

          //HIT判定
          if (hitProb > hitrnd) {
            //i 番目HIT
            _fishidx = FISH_TABLE.fishs.indexOf(fish);
            //大きさ決定
            _fishSize = (new math.Random()).nextDouble();
            if (flgFall) {
              //フォール中のみアワセ時間を倍にする
              _baitCnt -= fish.baitCntMax;
            } else {
              _baitCnt = 0;
            }
            _hitScanCnt = fish.hp + (fish.hp * _fishSize).floor();
            //アタリと判定
            _flgBait = true;
            _baitMaxTension = 0.0;
            debugPrint("アタリ");
            //_dispInfo = 'アタリ';
            _infoBackColor = TENSION_COLOR_DANGER;
          }
          if (_flgBait || _flgHit) {
          } else {
            //HIT確率から点滅速度を算出
            //duration =
            //durationMax - ((durationMax - durationMin) * maxProb).floor();
            //debugPrint(duration.toString());
            //_dispInfo = (maxProb * 100).toStringAsFixed(0) + ' %';
            _infoBackColor = Colors.white;
            //HIT率に伴いポインタの色を変える？
            _pointerColor = clsColor._getColorFromHex("ffd900"); //？？？とりあえず黄色固定
          }
        });
        //debugPrint(maxProb.toString());
      }
    } else {
      //アタリ中またはHIT中の処理
      var fish = FISH_TABLE.fishs[_fishidx];
      if (_flgBait) {
        //アタリ中の処理
        //当たってからのスキャン数加算
        _baitCnt++;
        if (_baitCnt > fish.baitCntMax) {
          //アタリ判定期間終了
          if (_baitMaxTension > fish.fookingTension) {
            //バイト中の最大テンションが一定値を超えるとHIT
            _flgBait = false;
            _flgHit = true;
            debugPrint('HIT!!!!');
            //_dispInfo = "HIT!";
            //フッキングの成功度
            _fookingLv = _tension - fish.fookingTension;
            if (_fookingLv > 100.0) _fookingLv = 100.0;
            //HITメッセージ
            _centerTextMain = "HIT!";
            _centerTextMainColor = Colors.red;
            _centerTextSub = "アワセLv " + _fookingLv.floor().toString();
            _centerTextSubColor = Colors.yellow;
            startCenterInfo();
          } else {
            //アワセ失敗
            _flgBait = false;
          }
        } else {
          //アタリ中
          if (_tension > _baitMaxTension) {
            //バイト中の最大テンションを記憶
            _baitMaxTension = _tension;
          }
          _pointerColor = clsColor._getColorFromHex("FF6A00"); //アタリ中はオレンジ
          //点滅速度最大
          duration = durationMin;
        }
      } else if (_flgHit) {
        //HIT中の処理
        _pointerColor = clsColor._getColorFromHex("ff0000"); //HIT中は赤固定表示

        //テンションから点滅速度を算出
        duration = durationMax -
            ((durationMax - durationMin) * (_tension / TENSION_VAL_MAX))
                .floor();

        //バレ判定 水深MAXかテンション一定未満で条件成立？？？
        if (_depth >= _maxDepth || val <= TENSION_VAL_MIN + 20) {
          _bareCnt++;
        } else {
          //_bareCnt = 0;
        }
        if (_bareCnt >= fish.bareMin + _fookingLv.floor()) {
          //バレ条件成立が一定スキャン保持でバレとする
          debugPrint("バレ");
          _flgBait = false;
          _flgHit = false;
          //console.log("bare...");
          //バレのモーダル表示
          //show_modal_bare();
          //バレメッセージ
          _centerTextMain = "";
          _centerTextMainColor = Colors.blue;
          _centerTextSub = "バレました";
          _centerTextSubColor = Colors.blue;
          startCenterInfo();

          _bareCnt = 0;
        }
      }
    }

    //シャクリ値を減算
    if (_rodStandUp > 0.0) {
      _rodStandUp -= 0.5; //1スキャン毎に0.5ずつ消える
    }
    if (_rodStandUp < 0.0) {
      //マイナスになったら0にする
      _rodStandUp = 0.0;
    }

    duration = duration > durationMax ? durationMax : duration;
    duration = duration < durationMin ? durationMin : duration;
    //今回の点滅速度レベル 初期値は最大値
    var newDurationLv = POINT_DURATION_MSEC.length - 1;
    for (var lv = 0; lv < POINT_DURATION_MSEC.length; lv++) {
      var d = POINT_DURATION_MSEC[lv]!;
      if (d > duration) {
        newDurationLv = lv;
        break;
      }
    }
    //debugPrint(newDurationLv.toString());
    //点滅速度レベルが変化した？
    if (newDurationLv != _nowDurationLv || _ligntSpotAnimationChangeing) {
      if (ligntSpotAnimation(
          false, POINT_DURATION_MSEC[newDurationLv] as int)) {
        //今回のアニメーションが止まってから変化させる
        _nowDurationLv = newDurationLv;
      }
    }

    //最大深さをランダムで増減
    var depthrnd = (new math.Random()).nextDouble();
    _maxDepth += 1 * ((_depthChange) - depthrnd);

    //棚を示す光点の表示
    var hannornd = (new math.Random()).nextDouble();
    if (hannornd > 0.96 && _jiai > depthrnd) {
      var fishy = sonarTop + (sonarHeight * _justTana);
      //レンジ分バラケ
      var barakeLevel = 4; //バラケ度
      var barake = (_justTanaRange * ((0.5 - depthrnd) * barakeLevel));
      fishy = fishy + barake;
      fishy = (fishy < _shoreHeight) ? _shoreHeight : fishy;
      fishy = (fishy > _shoreHeight + sonarHeight)
          ? _shoreHeight + sonarHeight
          : fishy;
      generateFishPointer(fishy, 20.0);
    }

    //タックルの描画
    if (_takclePositionLeft) {
      _tackleCenterX = 80.0;
      _takcleChangeButtonPosition = MainAxisAlignment.end;
    } else {
      _takcleChangeButtonPosition = MainAxisAlignment.start;
      _tackleCenterX = size.width - 80.0;
    }
    _rodSizeX = 20.0;
    _rodSizeY = size.height - _shoreHeight;
    _reelSizeX = 60.0;
    _reelSizeY = 60.0;
    _reelCenterY = size.height - 60 - 40;

    //debugPrint(_tension.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //スプライトウィジットの初期化
    //_spriteWidget = new SpriteWidget(new GameNode(MediaQuery.of(context).size));
    //画面サイズ取得用
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        // appBar: AppBar(
        //   title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //     Text("環境設定"),
        //   ]),
        //   leading: IconButton(
        //     // 戻るアイコン
        //     icon: Icon(Icons.arrow_back),
        //     color: Colors.white,
        //     iconSize: 30.0,
        //     onPressed: () {
        //       //前画面に戻る
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ),
        extendBodyBehindAppBar: true, // <--- ここ
        appBar: AppBar(
          // title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //   Text("環境設定"),
          // ]),
          backgroundColor: clsColor._getColorFromHex("FFFFFF").withOpacity(0.1),
          //title: Text(_senchoMessage),
          //左上
          leading: Row(
            children: [
              IconButton(
                // 図鑑アイコン
                icon: Icon(Icons.menu_book),
                color: Colors.white,
                iconSize: 30.0,
                onPressed: () async {
                  // //図鑑モーダルの表示
                  var result = await showDialog<int>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return BookDialog(
                        fishsTable: FISH_TABLE,
                        fishesResult: fishesResult,
                      );
                    },
                  );
                  debugPrint(result.toString());
                  setState(() {});
                },
              ),
            ],
          ),
          //右上（複数可）
          actions: [
            Container(
                child: ElevatedButton(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 30.0,
                ),
                Text(
                  _point.toString() + "ポイント",
                ),
              ]),
              onPressed: () {
                //買い物モーダルの表示
              },
            )),
          ],
          flexibleSpace:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                color: Colors.white,
                child: Text(
                  _senchoMessage,
                  style: TextStyle(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            ]),
          ]),
        ),
        //endDrawer: DrawerItem(),

        // body: SafeArea(
        //   child: SpriteWidget(
        //     RootNode(size),
        //   ),
        // ),

        body: GestureDetector(
            //ドラッグ操作が開始された時
            onPanStart: (DragStartDetails details) {
              debugPrint("ドラッグ開始");
              _showTacleChangeDialog = false;
              _cursorX = details.localPosition.dx;
              _cursorY = details.localPosition.dy;
              //クラッチOFF時、タップ箇所がクラッチ部分か？
              if (!_onClutch &&
                  // _cursorX > _tackleCenterX - (_reelSizeX) &&
                  // _cursorX < _tackleCenterX + (_reelSizeX) &&
                  // _cursorY > _reelCenterY + _reelSizeY / 2 + 3 &&
                  // _cursorY < _reelCenterY + _reelSizeY)
                  //リールをタップで
                  _cursorX > _tackleCenterX - _reelSizeX &&
                  _cursorX < _tackleCenterX + _reelSizeX &&
                  _cursorY > _reelCenterY - _reelSizeY &&
                  _cursorY < _reelCenterY + _reelSizeY) {
                chengeClutch(true);
                return;
              }

              chengeClutch(false);
              _onTap = true;
              //タップ時の画面エフェクト
              offset =
                  Offset(details.globalPosition.dx, details.globalPosition.dy);
              generateTapPointer(details);

              //generateFishPointer(100);
              //タップ時はスピードスライダの色替え
              _speedActiveTrackColor = SPEED_COLOR_REELING;
            },
            //ドラッグ操作で位置が変化した時
            onPanUpdate: (DragUpdateDetails details) {
              if (size.isEmpty) {
                return;
              }
              if (!_onTap) {
                return;
              }
              //現在の座標を取得する
              var mX = details.localPosition.dx; //X座標
              var mY = details.localPosition.dy; //Y座標
              //初期位置から動いた値を取得
              var moveX = mX - _cursorX;
              var moveY = mY - _cursorY;
              //x座標記憶を更新
              _cursorX = mX;
              _cursorY = mY;
              //巻き速度値の計算
              var addVal = (moveX / (1000 / 2) * SPEED_VAL_MAX);
              var val = _speed + addVal;
              if (val > SPEED_VAL_MAX) val = SPEED_VAL_MAX;
              if (val < SPEED_VAL_MIN) val = SPEED_VAL_MIN;
              _speed = val;
              //アワセ値
              addVal = (moveY / 100);
              val = _rodStandUp + addVal;
              if (val > ROD_STANDUP_MAX) val = ROD_STANDUP_MAX;
              if (val < 0) val = 0;
              _rodStandUp = val;
            },
            //タップ、ドラッグ操作が終了した時
            onPanEnd: (DragEndDetails details) {
              debugPrint("タップはなし");
              //chengeClutch(false);
              //add_min = -10;
              _onTap = false;
              //スピードスライダの色を戻す
              _speedActiveTrackColor = SPEED_COLOR;
            },
            child: new Stack(children: <Widget>[
              Column(children: <Widget>[
                //海上
                Container(
                  key: globalKeyShore,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      clsColor._getColorFromHex("5495FF"),
                      clsColor._getColorFromHex("EFFAFF")
                    ],
                    stops: const [
                      0.0,
                      1.0,
                    ],
                  )),
                  child: Column(children: <Widget>[
                    Container(
                        //appBarは透過なのでその分の高さを加算
                        margin: EdgeInsets.only(top: _appBarHeight + 10),
                        height: 40,
                        //テンションとドラグレベルのスライダーをstackで重ねて表示
                        child: new Stack(children: <Widget>[
                          // //テンションスライダー
                          Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              //color: Colors.white,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //Text("TENSION/DRAG"),
                                    new Image(
                                      image: AssetImage(
                                          'Assets/Images/TENSIONDRAG.png'),
                                    ),
                                    CustomPaint(
                                      painter: new SliderPainter(
                                        height: 20,
                                        activeColor: _tensionActiveTrackColor,
                                        inactiveColor: (_flgBait || _flgHit)
                                            ? Colors.black
                                            : Colors.white,
                                        value: _tension / TENSION_VAL_MAX,
                                        backRadius: _animationRadius.value,
                                        maxBackRadius: POINTER_BACK_SIZE,
                                        flgShaKe:
                                            (_flgBait || (_tension > _drag))
                                                ? true
                                                : false,
                                      ),
                                      child: Container(
//                                  height: 500,
                                          ),
                                    )
                                  ])),
                          //ドラグスライダー
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 40,
                            child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  //trackHeight: 1, //全体の縦長
                                  valueIndicatorColor:
                                      Colors.black.withOpacity(0.0), //背景の色
                                  activeTrackColor:
                                      Colors.black.withOpacity(0.0), //値有りエリアの色
                                  inactiveTrackColor:
                                      Colors.black.withOpacity(0.0), //値無しエリアの色
                                  activeTickMarkColor:
                                      Colors.black.withOpacity(0.0), //各value値の色
                                  thumbColor: Colors.red, //値ツマミの色
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 10), //ツマミの大きさ
                                  overlayColor: Colors.black
                                      .withOpacity(0.0), //値ツマミフォーカス時の色
                                ),
                                child: Slider(
                                  value: _drag,
                                  //MAX-MINはテンションと同じ
                                  min: TENSION_VAL_MIN,
                                  max: TENSION_VAL_MAX,
                                  divisions: (TENSION_VAL_MAX - TENSION_VAL_MIN)
                                      .floor(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _drag = value.roundToDouble();
                                    });
                                  },
                                )),
                          )
                        ])),
                    //ラインHPスライダー
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        height: 5,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomPaint(
                                painter: new SliderPainter(
                                  height: 5,
                                  activeColor:
                                      clsColor._getColorFromHex("FF3030"),
                                  inactiveColor: Colors.white,
                                  value: _nowLineHp / _maxLineHp,
                                  backRadius: 0,
                                  maxBackRadius: 0,
                                  flgShaKe: false,
                                ),
                                child: Container(),
                              ),
                            ])),

                    //巻速度スライダー
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Text("SPEED"),
                              new Image(
                                image: AssetImage('Assets/Images/SPEED.png'),
                              ),
                              CustomPaint(
                                painter: new SliderPainter(
                                  height: 20,
                                  activeColor: _speedActiveTrackColor,
                                  inactiveColor: Colors.white,
                                  value: _speed / SPEED_VAL_MAX,
                                  backRadius: 0,
                                  maxBackRadius: 0,
                                  flgShaKe: false,
                                ),
                                child: Container(),
                              ),
                              //可能性のある魚種の速度範囲表示
                              CustomPaint(
                                painter: new FishRangeSliderPainter(
                                  activeColor: _speedActiveTrackColor,
                                  inactiveColor: Colors.red,
                                  backRadius: 0,
                                  maxBackRadius: 0,
                                  maxSpeed: SPEED_VAL_MAX,
                                  speedRange: _listSpeedRange,
                                ),
                                child: Container(),
                              )
                            ])),

                    Stack(children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        // margin: EdgeInsets.only(
                        //     top: math.sin(waveController.value * 0.5 * math.pi),
                        //     left: math.sin(waveController.value * math.pi)),
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              //_senchoMessage = "わしゃあ忙しいんで！";
                            });
                            // var result = await showDialog<int>(
                            //   context: context,
                            //   barrierDismissible: false,
                            //   builder: (_) {
                            //     return SenchoDialog(
                            //       depth_change_order: _depthChangeOrder,
                            //       point: _point,
                            //     );
                            //   },
                            // );
                            // debugPrint(result.toString());
                            // setState(() {
                            //   _depthChangeOrder = result as int;
                            // });
                          },
                          child: Transform.rotate(
                            //angle: 45 * math.pi / 180,
                            angle: (405 - (90 * _depthChange)) * math.pi / 180,
                            child: new Image(
                              image: AssetImage('Assets/Images/ship.png'),
                              width: 60,
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: 40,
                          child: AnimatedBuilder(
                            animation: waveController, // waveControllerを設定
                            builder: (context, child) => Stack(
                              children: <Widget>[
                                //？？？iPhoneのsafariで描画できない,androidはOK
                                // 1つ目の波
                                ClipPath(
                                  child: Container(
                                      color: clsColor
                                          ._getColorFromHex("02D5F2")
                                          .withOpacity(1.0)),
                                  clipper: WaveClipper(
                                      context, waveController.value, 0),
                                ),
                                // 2つ目の波
                                ClipPath(
                                  child: Container(
                                      color: clsColor
                                          ._getColorFromHex("02D5F2")
                                          .withOpacity(0.3)),
                                  clipper: WaveClipper(
                                      context, waveController.value, 0.5),
                                ),
                                // ↑ 追加部分
                              ],
                            ),
                          )),
                      AnimatedOpacity(
                          opacity: (_depth > 0.0 || _point <= 0) ? 0.0 : 1.0,
                          duration: Duration(milliseconds: 200),
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    //タップ開始
                                    onTapDown: (details) {
                                      if (_depth <= 0.0) {
                                        setState(() {
                                          _moveShipTarget = 0.3;
                                        });
                                      }
                                    },
                                    //タップ終了
                                    onTapUp: (details) {
                                      setState(() {
                                        _moveShipTarget = 0.5;
                                      });
                                    },
                                    //タップしたままフォーカス外れた時
                                    onTapCancel: () {
                                      setState(() {
                                        _moveShipTarget = 0.5;
                                      });
                                    },
                                    child: new Image(
                                      image: AssetImage(
                                          'Assets/Images/arrow_left.png'),
                                      height: 30,
                                    ),
                                  ),
                                  GestureDetector(
                                    //タップ開始
                                    onTapDown: (details) {
                                      if (_depth <= 0.0) {
                                        setState(() {
                                          _moveShipTarget = 0.7;
                                        });
                                      }
                                    },
                                    //タップ終了
                                    onTapUp: (details) {
                                      setState(() {
                                        _moveShipTarget = 0.5;
                                      });
                                    },
                                    //タップしたままフォーカス外れた時
                                    onTapCancel: () {
                                      setState(() {
                                        _moveShipTarget = 0.5;
                                      });
                                    },
                                    child: new Image(
                                      image: AssetImage(
                                          'Assets/Images/arrow_right.png'),
                                      height: 30,
                                    ),
                                  ),
                                ],
                              ))),
                    ]),
                  ]),
                ),
                //海中
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: clsColor._getColorFromHex("02D5F2")),
                            //color: clsColor._getColorFromHex("200070"),
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                clsColor._getColorFromHex("02D5F2"),
                                clsColor._getColorFromHex("013367"),
                                clsColor._getColorFromHex("002142"),
                                clsColor._getColorFromHex("000000"),
                              ],
                              stops: [0.0, _dispDepthLv1, _dispDepthLv2, 1.0],
                            )),
                        child: Column(children: <Widget>[
                          //ソナー画面
                          Expanded(
                            //描画エリア
                            child: Container(
                              key: globalKeySonar,
                              child: Stack(children: <Widget>[
                                //ソナー光点
                                Container(
                                  width: size.width,
                                  margin: EdgeInsets.only(
                                      top: _lightSpotY, left: _lightSpotX),
                                  child: CustomPaint(
                                    painter: LightSpot(
                                        POINTER_SIZE,
                                        POINTER_BACK_SIZE,
                                        _animationRadius.value,
                                        _pointerColor,
                                        0,
                                        0),
                                  ),
                                ),
                                //ジャーク時のテキスト
                                if (_jerkTextAnimationController.isAnimating)
                                  Container(
                                    //width: 30,
                                    margin: EdgeInsets.only(
                                        top: _lightSpotY -
                                            ((_lightSpotY < 18.0)
                                                ? _lightSpotY
                                                : (18.0 +
                                                    _jerkTextLocation.value)),
                                        left: _lightSpotX +
                                            (10.0 * _jerkTextLocation.value)),
                                    child: Text(
                                      'ｼｬｸﾘ!',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                //魚HPスライダ
                                Visibility(
                                  visible: _flgHit,
                                  child: Container(
                                    width: 30,
                                    margin: EdgeInsets.only(
                                        top: _lightSpotY -
                                            ((_lightSpotY < 18.0)
                                                ? _lightSpotY
                                                : 18.0),
                                        left: _lightSpotX - 18.0),
                                    child: CustomPaint(
                                      painter: new SliderPainter(
                                        height: 5,
                                        activeColor:
                                            Colors.red.withOpacity(0.7),
                                        inactiveColor: Colors.white,
                                        value: _hitScanCnt /
                                            (FISH_TABLE.fishs[_fishidx].hp +
                                                (FISH_TABLE.fishs[_fishidx].hp *
                                                    _fishSize)),
                                        backRadius: 0,
                                        maxBackRadius: 0,
                                        flgShaKe: false,
                                      ),
                                      child: Container(),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          )
                        ]))),

                //海底
                Container(
                    key: globalKeyBottom,
                    height: 60,
                    decoration: BoxDecoration(

                        //color: clsColor._getColorFromHex("200070"),
                        gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        clsColor._getColorFromHex("758661"),
                        clsColor._getColorFromHex("455E42"),
                        clsColor._getColorFromHex("0A081F"),
                      ],
                      stops: [0.0, 0.6, 1.0],
                    )),
                    //画面下部
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width / 3,
                              child: (!_takclePositionLeft)
                                  ? _tacklePositionChangeButton()
                                  : Text(''),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: size.width / 3,
                              child: Row(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.red, width: 3),
                                        color: Colors.white),
                                    child: Text(_dispDepth,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width / 3,
                              child: (_takclePositionLeft)
                                  ? _tacklePositionChangeButton()
                                  : Text(''),
                            ),
                          ],
                        ),
                      ],
                    )),
              ]),
              //画面全体的に描画するもの
              Stack(children: <Widget>[
                //タップ時の光点
                (tapPointerList.isNotEmpty)
                    ? Stack(children: tapPointerList)
                    : Text(""),
                //反応光点
                (fishPointerList.isNotEmpty)
                    ? Stack(children: fishPointerList)
                    : Text(""),
                //タックルの描画
                CustomPaint(
                  painter: new tacklePainter(
                    shoreHeight: _shoreHeight,
                    dispSize: size,
                    takclePositionLeft: _takclePositionLeft,
                    tackleCenterX: _tackleCenterX,
                    rodSizeX: _rodSizeX,
                    rodSizeY: _rodSizeY,
                    reelSizeX: _reelSizeX,
                    reelSizeY: _reelSizeY,
                    reelCenterY: _reelCenterY,
                    clutchBackColor:
                        (_onClutch ? Colors.lightBlue : Colors.red),
                    rodStandUp: _rodStandUp,
                    rodTension: _tension / TENSION_VAL_MAX,
                  ),
                ),
                if (_centerTextAnimationController.isAnimating)
                  Container(
                      margin: EdgeInsets.only(
                          left: _centerTextLeft.value, top: size.height / 2),
                      child: Column(
                        children: [
                          Text(
                            _centerTextMain,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: _centerTextMainColor.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 100,
                                fontFamily: 'OpenSans',
                                fontStyle: FontStyle.italic,
                                shadows: <Shadow>[
                                  Shadow(
                                      offset: Offset(5.0, 10.0),
                                      blurRadius: 2.0,
                                      color: Colors.black.withOpacity(0.8))
                                ]),
                          ),
                          Text(
                            _centerTextSub,
                            style: TextStyle(
                                color: _centerTextSubColor.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                fontFamily: 'OpenSans',
                                fontStyle: FontStyle.italic,
                                shadows: <Shadow>[
                                  Shadow(
                                      offset: Offset(5.0, 10.0),
                                      blurRadius: 2.0,
                                      color: Colors.black.withOpacity(0.8))
                                ]),
                          ),
                        ],
                      )),
                //UI関係
                Column(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: _shoreHeight + (5 * _tackleMenuAnime.value),
                              left: 10),
                          height: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //竿
                              GestureDetector(
                                  onTap: () async {
                                    if (_depth <= 0.0) {
                                      setState(() {
                                        _selectTacleIcon = 'rod';
                                        _showTacleChangeDialog = true;
                                      });
                                    }
                                  },
                                  child: tackleIcon(
                                      tackleIconSize: 40.0,
                                      imagePath: 'Assets/Images/rod.png',
                                      flgSelect: false,
                                      subText: '')),
                              //リール
                              GestureDetector(
                                  onTap: () async {
                                    if (_depth <= 0.0) {
                                      setState(() {
                                        _selectTacleIcon = 'reel';
                                        _showTacleChangeDialog = true;
                                      });
                                    }
                                  },
                                  child: tackleIcon(
                                      tackleIconSize: 40.0,
                                      imagePath: 'Assets/Images/reel.png',
                                      flgSelect: false,
                                      subText: '')),
                              //ルアー
                              GestureDetector(
                                  onTap: () async {
                                    if (_depth <= 0.0) {
                                      setState(() {
                                        _selectTacleIcon = 'lure';
                                        _showTacleChangeDialog = true;
                                      });
                                    }
                                  },
                                  child: tackleIcon(
                                      tackleIconSize: 40.0,
                                      imagePath: 'Assets/Images/' +
                                          lures
                                              .getLureData(haveTackle
                                                  .getUseLure()
                                                  .lureId)
                                              .image,
                                      flgSelect: false,
                                      subText: lures
                                              .getLureData(haveTackle
                                                  .getUseLure()
                                                  .lureId)
                                              .weight
                                              .toString() +
                                          'g')),
                            ],
                          ),
                        ),
                        //回収ボタン デザインは仮だから
                        AnimatedOpacity(
                          opacity:
                              _depth > 0.0 && !_flgBait && !_flgHit ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 200),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: _shoreHeight + 20, right: 10),
                            child: ElevatedButton(
                                child: const Text('回収'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.amber, //背景色
                                  onPrimary: Colors.black, //押したときの色
                                  shape: const StadiumBorder(),
                                  side: BorderSide(
                                    color: Colors.black, //枠線の色
                                    width: 2, //枠線の太さ
                                  ),
                                ),
                                onPressed: () {
                                  _collect = true;
                                  _onClutch = true;
                                }),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
                AnimatedPadding(
                  //curve: Curves.easeOutExpo,
                  padding: EdgeInsets.only(
                    right: _showTacleChangeDialog ? 0.0 : size.width,
                    top: _shoreHeight,
                  ),
                  duration: Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: () {
                      //欄外のタップイベントを起こさないための空イベント
                    },
                    onPanStart: (DragStartDetails details) {
                      //欄外のタップイベントを起こさないための空イベント
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.3), width: 1)),
                      //title: Text("タックル変更"),
                      child: Visibility(
                          visible: _showTacleChangeDialog,
                          child: Container(
                            color: Colors.black.withOpacity(0.3),
                            child: Column(children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "使用中のタックル",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'OpenSans',
                                          decoration: TextDecoration.none,
                                          shadows: <Shadow>[
                                            Shadow(
                                                offset: Offset(1.0, 3.0),
                                                blurRadius: 2.0,
                                                color: Colors.black
                                                    .withOpacity(0.8))
                                          ]),
                                    )
                                  ]),
                              Container(
                                //margin: EdgeInsets.only(top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //現在選択中のルアー
                                    //竿
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectTacleIcon = 'rod';
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: tackleIcon(
                                              tackleIconSize: 60.0,
                                              imagePath:
                                                  'Assets/Images/rod.png',
                                              flgSelect:
                                                  _selectTacleIcon == 'rod'
                                                      ? true
                                                      : false,
                                              subText: '')),
                                    ),

                                    //リール
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectTacleIcon = 'reel';
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: tackleIcon(
                                              tackleIconSize: 60.0,
                                              imagePath:
                                                  'Assets/Images/reel.png',
                                              flgSelect:
                                                  _selectTacleIcon == 'reel'
                                                      ? true
                                                      : false,
                                              subText: '')),
                                    ),
                                    //ルアー
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectTacleIcon = 'lure';
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: tackleIcon(
                                              tackleIconSize: 60.0,
                                              imagePath: 'Assets/Images/' +
                                                  lures
                                                      .getLureData(haveTackle
                                                          .getUseLure()
                                                          .lureId)
                                                      .image,
                                              flgSelect:
                                                  _selectTacleIcon == 'lure'
                                                      ? true
                                                      : false,
                                              subText: lures
                                                      .getLureData(haveTackle
                                                          .getUseLure()
                                                          .lureId)
                                                      .weight
                                                      .toString() +
                                                  'g')),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  child: Column(
                                children: [Text("")],
                              )),
                              //交換
                              Container(
                                margin: EdgeInsets.only(top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width: size.width - 60,
                                        height: 60,
                                        color: Colors.white.withOpacity(0.6),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    //タックル替え
                                                    haveTackle.changeLure(
                                                        haveTackle
                                                            .haveLures[index]
                                                            .id);
                                                  });
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: tackleIcon(
                                                        tackleIconSize: 40.0,
                                                        imagePath: 'Assets/Images/' +
                                                            lures
                                                                .getLureData(
                                                                    haveTackle
                                                                        .haveLures[
                                                                            index]
                                                                        .lureId)
                                                                .image,
                                                        flgSelect: haveTackle
                                                                    .haveLures[
                                                                        index]
                                                                    .id ==
                                                                haveTackle
                                                                    .getUseLure()
                                                                    .id
                                                            ? true
                                                            : false,
                                                        subText: lures
                                                                .getLureData(
                                                                    haveTackle
                                                                        .haveLures[
                                                                            index]
                                                                        .lureId)
                                                                .weight
                                                                .toString() +
                                                            'g')),
                                              ),
                                            ]);
                                          },
                                          itemCount:
                                              haveTackle.haveLures.length,
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  lures
                                      .getLureData(
                                          haveTackle.getUseLure().lureId)
                                      .name,
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //ステータス
                                    new RadarChart(
                                      key: UniqueKey(),
                                      items: getLureRadarChartItem(),
                                      radarColors: [Colors.green],
                                      fontColor: Colors.white,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //重さ
                                          Row(
                                            children: [
                                              Text(
                                                '重さ：',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                lures
                                                        .getLureData(haveTackle
                                                            .getUseLure()
                                                            .lureId)
                                                        .weight
                                                        .toString() +
                                                    'g',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          //説明テキスト
                                          // Expanded(
                                          //     child:
                                          Container(
                                              height: 100,
                                              width: size.width / 2,
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 3),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7.0)),
                                                  color:
                                                      clsColor._getColorFromHex(
                                                          '#DFDFDF')),
                                              child: Text(
                                                lures
                                                    .getLureData(haveTackle
                                                        .getUseLure()
                                                        .lureId)
                                                    .text,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                          //),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //閉じるボタン
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  label: const Text('閉じる'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey.withOpacity(0.5),
                                    onPrimary: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showTacleChangeDialog = false;
                                    });
                                  },
                                ),
                              ),
                            ]),
                          )),
                    ),
                  ),
                ),
              ]),
            ])));
  }

  //タップ時のエフェクトのリスト
  List<TapPointer> tapPointerList = <TapPointer>[];
  // アニメーションの終了を Future<void>.delayed で待ち、終わった時に removeAt(0) でリストから取り出している
  // 取り出すと そのタイミングで dispose が呼ばれる。
  Future<void> generateTapPointer(DragStartDetails details) async {
    const duration = const Duration(milliseconds: 1000);
    final tapPointer = TapPointer(
      key: UniqueKey(), // 必ずキーを与えること。これによりそれぞれが独立した描画になります。
      offset: offset,
      duration: duration,
    );
    setState(() {
      tapPointerList.add(tapPointer);
    });
    await Future<void>.delayed(duration);
    setState(() {
      tapPointerList.removeAt(0);
    });
  }

  //魚アイコンのリスト
  List<FishPointer> fishPointerList = <FishPointer>[];
  // アニメーションの終了を Future<void>.delayed で待ち、終わった時に removeAt(0) でリストから取り出している
  // 取り出すと そのタイミングで dispose が呼ばれる。
  Future<void> generateFishPointer(offsetY, fishPointerSize) async {
    const duration = const Duration(milliseconds: 20000);
    var size = MediaQuery.of(context).size;
    var rnd = (new math.Random()).nextDouble();
    var offsetX =
        (size.width / 4) + (size.width / 2) * (rnd * rnd); //真ん中に集約するように累乗する
    if (_takclePositionLeft) {
      offsetX += size.width / 4;
    } else {
      offsetX -= size.width / 4;
    }
    offsetX = (offsetX < 0) ? 0 : offsetX;
    offsetX = (offsetX > size.width) ? size.width : offsetX;

    final fishPointer = FishPointer(
      key: UniqueKey(), // 必ずキーを与えること。これによりそれぞれが独立した描画になります。
      dispSizeX: size.width, //画面サイズX
      offsetY: offsetY,
      offsetX: offsetX,
      duration: duration,
      fishPointerSize: fishPointerSize,
      takclePositionLeft: _takclePositionLeft,
      painterKey: GlobalKey(),
    );
    setState(() {
      fishPointerList.add(fishPointer);
    });
    await Future<void>.delayed(duration);
    setState(() {
      fishPointerList.removeAt(0);
    });
  }

  //クラッチ状態変更
  void chengeClutch(bool flg) {
    if (flg == _onClutch) {
      //状態変更無し時は無処理
      return;
    }
    if (_collect) {
      return;
    }
    if (flg) {
      //クラッチOFF→ONに変更
      _clutchBackColor = Colors.lightBlue;
    } else {
      _clutchBackColor = Colors.red;
    }
    _onClutch = flg;
  }

  bool ligntSpotAnimation(bool initflg, int durationMsec) {
    if (initflg || !_animationController.isAnimating) {
      //アニメーションの定義
      _animationController = AnimationController(
          duration: Duration(milliseconds: durationMsec), vsync: this);
      _animationRadius = Tween(begin: 0.0, end: POINTER_BACK_SIZE)
          .animate(_animationController)
        ..addListener(() {
          setState(() {});
        });
      _animationController.repeat(reverse: false);
      _ligntSpotAnimationChangeing = false;
      return true;
    } else {
      if (!_ligntSpotAnimationChangeing) {
        _animationController.forward();
        _ligntSpotAnimationChangeing = true;
      }
      return false;
    }
  }

  //持ち替えボタン
  Widget _tacklePositionChangeButton() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
            mainAxisAlignment: _takcleChangeButtonPosition,
            children: <Widget>[
              // Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[

              ElevatedButton(
                  child: const Text('持替'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber, //背景色
                    onPrimary: Colors.black, //押したときの色
                    shape: const StadiumBorder(),
                    side: BorderSide(
                      color: Colors.black, //枠線の色
                      width: 2, //枠線の太さ
                    ),
                  ),
                  onPressed: () {
                    if (_takclePositionLeft) {
                      _takclePositionLeft = false;
                    } else {
                      _takclePositionLeft = true;
                    }
                  }),
            ]));
  }

  //画面中央のメッセージ
  startCenterInfo() {
    //HIT時のアニメーションの定義
    _centerTextAnimationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _centerTextLeft =
        Tween(begin: 0.0, end: MediaQuery.of(context).size.width / 2).animate(
            _centerTextAnimationController
                .drive(CurveTween(curve: Curves.slowMiddle)))
          ..addListener(() {
            setState(() {});
          });
    _centerTextAnimationController.forward();
  }

  //ジャーク表示
  startJerk() {
    //ジャーク時のアニメーションの定義
    _jerkTextAnimationController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _jerkTextLocation =
        Tween(begin: 0.0, end: 1.0).animate(_jerkTextAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _jerkTextAnimationController.forward();
  }

  //タックルサムネの表示
  Widget tackleIcon({
    required double tackleIconSize,
    required String imagePath,
    required bool flgSelect,
    required String subText,
  }) {
    return SizedBox(
      width: tackleIconSize,
      height: tackleIconSize,
      child: Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          border: Border.all(
              color: flgSelect ? Colors.yellow : Colors.black,
              width: flgSelect ? 3 : 1),
          image: DecorationImage(
              image: AssetImage(imagePath),
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity((_depth > 0.0 ? 0.7 : 1.0)),
                  BlendMode.dstATop),
              fit: BoxFit.contain),
        ),
        child: Text(subText),
      ),
    );
  }

  List<RadarChartItemModel> getLureRadarChartItem() {
    List<RadarChartItemModel> ret = [];
    ret.add(new RadarChartItemModel(
        itemName: '巻き',
        value: lures.getLureData(haveTackle.getUseLure().lureId).reeling));
    ret.add(new RadarChartItemModel(
        itemName: 'ﾌｫｰﾙ',
        value: lures.getLureData(haveTackle.getUseLure().lureId).fall));
    ret.add(new RadarChartItemModel(
        itemName: 'ｼｬｸﾘ',
        value: lures.getLureData(haveTackle.getUseLure().lureId).jerk));
    return ret;
  }
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    return 64 * math.sin(2 * math.pi * t);
  }
}

//色コード関連操作クラス
class clsColor {
  //色を色コード文字列で指定する
  static Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  //色を値範囲によって可変にする
  static Color _getColorRange(
      Color startColor, Color endColor, double val, double maxVal) {
    var diffVal = (val / maxVal);
    //R
    var r =
        startColor.red + ((endColor.red - startColor.red) * diffVal).floor();
    //G
    var g = startColor.green +
        ((endColor.green - startColor.green) * diffVal).floor();
    //B
    var b =
        startColor.blue + ((endColor.blue - startColor.blue) * diffVal).floor();
    return _getColorFromHex(r.toRadixString(16).padLeft(2, "0") +
        g.toRadixString(16).padLeft(2, "0") +
        b.toRadixString(16).padLeft(2, "0"));
  }
}

//累乗の計算（DartのMath.powだと実数の戻り値ができないため自作）
class MathPow {
  static double _getPow(int x, double d) {
    double ret = d;
    for (var i = 1; i < x; i++) {
      ret = ret * d;
    }
    return ret;
  }
}
