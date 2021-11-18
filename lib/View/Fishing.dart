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
//・ヘッダを大改修
//・魚図鑑画面
//・%を表示してる方がおもしろい・・・
//・海底に漁礁とか
//・通知インフォメーション 今が時合で！みたいな
//・ポイントで色々　道具買ったり、糸替え、船長指示、ゲームオーバーから復活とか
//・ドラグが出てる時はどっか揺らすみたいな
//・糸のHPシステム？糸切れ値でぷっつり行くのが何か変
//・HIT時につっこみモード、おとなしいモードつけて勢い度
//・糸切れ判定 勢い度を加味して切れるようにする
//・魚種毎にバレ条件の設定
//・魚種毎に底生志向
//・魚種毎に巻き志向←→リアクション志向
//・画面左に竿リール表示、上下ドラッグで動かす、ジグのシャクリ
//・竿リール表示を左右切り替えるやつを反対側に
//・アワセシステム
//  アワセの上手くいきかたで初期バラシレベルが決まるみたいな
//・魚種データをDB化して登録画面実装
//・エリア選択 エリアによって魚種、深さ等変える
//夢
//・アワセシステム ARVRモード時はスマホをジャイロで動かす、通常時は下にドラッグでアワセ
//・背景にAR的なカメラ映像（カメラ無いときはアニメーション）
//・背景にrod、ジャイロで動かす

import 'package:fish_flutter/Model/LightSpot.dart';
import 'package:fish_flutter/Model/TapPointer.dart';
import 'package:fish_flutter/Model/FishPointer.dart';
import 'package:fish_flutter/Model/WaveClipper.dart';
import 'package:fish_flutter/Model/SenchoDialog.dart';
import 'package:fish_flutter/Model/SliderPainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'DrawerItem.dart';
import 'dart:async';
import 'dart:math' as math;

class Fishing extends StatefulWidget {
  Fishing({Key? key}) : super(key: key);

  @override
  _FishingState createState() => _FishingState();
}

// つりページのステータス管理
class _FishingState extends State<Fishing> with TickerProviderStateMixin {
  //定数の定義？？？いろいろ環境設定にした方がいいかと

  //デバッグフラグ すぐつれる
  static const DEBUGFLG = true;
//  static const DEBUGFLG = false;

  //魚種定義 wariaiの合計値は10にすること
  static const Map<int, Map<String, dynamic>> FISH_TABLE = {
    0: {
      'name': "アジ", //魚種名
      'image': "aji.jpg", //超過画面の画像
      'text': "あなたは幸せを感じました", //釣果画面のコメント
      'hp': 300, //このスキャン経過で0になる
      'add_max': 30, //引きの最大
      'add_min': -10, //引きの最小（最大との乖離が暴れ度）
      'weight': 2, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      'wariai': 1.0, //HIT率 条件全一致で確定1.0～
      'point': 100, //ポイントの基礎値
      'tana_min': 0, //生息域 上 0.1m単位
      'tana_max': 100, //生息域 下 0.1m単位
      'hit_fall': 0.2, //フォール志向
      'hit_speed_just': 50, //スピード志向
      'hit_speed_range': 40, //スピード志向範囲+-
      'size_min': 7.6, //大きさ範囲最小
      'size_max': 51.3, //大きさ範囲最大
    },
    1: {
      'name': "タチウオ",
      'image': "tachiuo.jpg",
      'text': "おおきいぞっ",
      'hp': 250, //このスキャン経過で0になる
      'add_max': 13,
      'add_min': -5,
      'weight': 2, //重さ
      'wariai': 0.7,
      'point': 200, //ポイントの基礎値
      'tana_min': 100, //生息域 上 0.1m単位
      'tana_max': 300, //生息域 下 0.1m単位
      'hit_fall': 0.3,
      'hit_speed_just': 100,
      'hit_speed_range': 50,
      'size_min': 64.0,
      'size_max': 150.5,
    },
    2: {
      'name': "鯉",
      'image': "koi.jpg",
      'text': "スーパーレア",
      'hp': 3000, //このスキャン経過で0になる
      'add_max': 10,
      'add_min': -6,
      'weight': 3, //重さ
      'wariai': 0.5,
      'point': 200, //ポイントの基礎値
      'tana_min': 0, //生息域 上 0.1m単位
      'tana_max': 300, //生息域 下 0.1m単位
      'hit_fall': 0.1,
      'hit_speed_just': 75,
      'hit_speed_range': 50,
      'size_min': 34.4,
      'size_max': 114.8,
    },
    3: {
      'name': "マダイ",
      'image': "madai.jpg",
      'text': "あなたは満足を得ました",
      'hp': 1000,
      'add_max': 15,
      'add_min': -6,
      'weight': 3, //重さ
      'wariai': 0.5,
      'point': 300, //ポイントの基礎値
      'tana_min': 500, //生息域 上 0.1m単位
      'tana_max': 1000, //生息域 下 0.1m単位
      'hit_fall': 0.1,
      'hit_speed_just': 150,
      'hit_speed_range': 50,
      'size_min': 26.3,
      'size_max': 86.8,
    },
    4: {
      'name': "宮澤クン",
      'image': "sakana.jpg",
      'text': "スー　パー　レア",
      'hp': 5000,
      'add_max': 30,
      'add_min': -10,
      'weight': 4, //重さ
      'wariai': 0.05,
      'point': 99999, //ポイントの基礎値
      'tana_min': 500, //生息域 上 0.1m単位
      'tana_max': 1000, //生息域 下 0.1m単位
      'hit_fall': 0.6,
      'hit_speed_just': 250,
      'hit_speed_range': 50,
      'size_min': 9999.9,
      'size_max': 19999.9,
    },
    5: {
      'name': "サバ", //魚種名
      'image': "aji.jpg", //超過画面の画像
      'text': "写真は仮です", //釣果画面のコメント
      'hp': 500, //このスキャン経過で0になる
      'add_max': 10, //引きの最大
      'add_min': -5, //引きの最小（最大との乖離が暴れ度）
      'weight': 2, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      'wariai': 1.0, //HIT率 条件全一致で確定1.0～
      'point': 100, //ポイントの基礎値
      'tana_min': 0, //生息域 上 0.1m単位
      'tana_max': 70, //生息域 下 0.1m単位
      'hit_fall': 0.2, //フォール志向
      'hit_speed_just': 150, //スピード志向
      'hit_speed_range': 30, //スピード志向範囲+-
      'size_min': 14.3,
      'size_max': 67.2,
    },
    6: {
      'name': "サゴシ", //魚種名
      'image': "aji.jpg", //超過画面の画像
      'text': "あなたは満足を得ました", //釣果画面のコメント
      'hp': 1000, //このスキャン経過で0になる
      'add_max': 20, //引きの最大
      'add_min': -5, //引きの最小（最大との乖離が暴れ度）
      'weight': 3, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      'wariai': 0.6, //HIT率 条件全一致で確定1.0～
      'point': 300, //ポイントの基礎値
      'tana_min': 0, //生息域 上 0.1m単位
      'tana_max': 200, //生息域 下 0.1m単位
      'hit_fall': 1.0, //フォール志向
      'hit_speed_just': 170, //スピード志向
      'hit_speed_range': 40, //スピード志向範囲+-
      'size_min': 35.3,
      'size_max': 69.9,
    },
  };

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
  static const HIT_JUST_SPEED = 150;
  static const HIT_SPEED_RANGE = 80; //+-まではHIT県内
  static const BARE_MAX = 20; //バレ判定条件成立からバレ発生までのスキャン数 ？？？魚のでかさによって可変にするべき
  static const MAX_RAND_ADD_TENSION = 3; //何もしてない時テンションがウロウロするののMAX値
  static const MIN_RAND_ADD_TENSION = -8; //〃 MIN値
  final TENSION_COLOR_SAFE = clsColor._getColorFromHex("4CFF00");
  final TENSION_COLOR_DRAG = clsColor._getColorFromHex("FFD800");
  final TENSION_COLOR_DANGER = clsColor._getColorFromHex("DD0000");
  final SPEED_COLOR = clsColor._getColorFromHex("0094FF");
  final SPEED_COLOR_REELING = clsColor._getColorFromHex("0026FF");
  static const TAP_POINTER_DURATION_MSEC = 500; //タップ時のエフェクト 速度
  static const TAP_POINTER_MAX_RADIUS = 10.0; //タップ時のエフェクト 最大大きさ
  // static const DEPTH_CHANGE_SCAN = 500; //このスキャン毎に深さの変化傾向が変わる
  // static const JIAI_CHANGE_SCAN = 1500; //このスキャン毎に時合度が変わる
  static const DEPTH_CHANGE_SCAN = 50; //このスキャン毎に深さの変化傾向が変わる
  static const JIAI_CHANGE_SCAN = 150; //このスキャン毎に時合度が変わる
  static const TANA_CHANGE_SCAN = 300; //このスキャン毎にタナが変わる
  static const POINTER_SIZE = 5.0; //ソナー光点の基本サイズ
  static const POINTER_BACK_SIZE = 4.0; //ソナー光点後光の最大サイズ

  //static const Map<int, double> DEPTH_CHANGE_ORDERS = {0: 0.5, 1: 0.45, 2: 0.55};
  static const Map<int, double> DEPTH_CHANGE_ORDERS = {0: 0.5, 1: 0.2, 2: 0.8};

// グローバル変数としてGlobalKey型の変数（プロパティ）を定義
  GlobalKey globalKeySonar = GlobalKey();
  GlobalKey globalKeyShore = GlobalKey();
  GlobalKey globalKeyBottom = GlobalKey();

  //アニメーション関連
  late AnimationController _animationController; //光点の光アニメーション
  late Animation<double> _animationRadius;
  // late AnimationController _tapAnimation; //タップ時の波紋アニメーション
  // late Animation<double> _TapPointerRadius;

  //状態フラグ変数
  var _onTap = false; //現在タップ中フラグ
  var _onClutch = false; //現在クラッチ状態
  var _flgHit = false; //現在HIT中フラグ
  var _flgGameOver = false; //現在ゲームオーバーフラグ

  //ステート変数
  var _tension = 0.0; //テンション値
  var _drag = 250.0; //ドラグレベル値
  var _speed = 0.0; //巻き速度値
  var _depth = 0.0; //現在糸出し量(0.1m)
  var _maxDepth = 187.0; //最大水深(0.1m)
  var _dispDepth = '0.0 m'; //深さ表示用
  var _dispInfo = '0.00 %'; //HIT率表示用（デバッグ用）
  var _tensionActiveTrackColor =
      clsColor._getColorFromHex("4CFF00"); //テンションゲージの色
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
  var _jiai = 0.5; //時合度 0.0～0.9999...
  var _jiaiChangeScanCnt = 0; //時合度の変化スキャンカウント数

  var _cursorx = 0.0; //ドラッグ操作開始時の座標X

  var _fishidx = 0; //現在HIT中の魚種IDX
  var _fishSize = 0.0; //現在HIT中の魚の大きさ MAXを1.0とした時の割合
  var _hit_scan_cnt = 0; //HITしてからのスキャン数
  var _bare_cnt = 0; //バレ判定カウント

  var _depth_change = 0.5; //深さの変化傾向 1.0～0,0 +なら深くなる、-なら浅くなる
  var _depth_change_scan_cnt = 0; //深さの変化傾向スキャンカウント数
  var _depth_change_order = 0; //変化傾向 初期値は現状維持
  var _disp_depth_lv1 = 0.45; //深さ画面色変える 中層 0m：1.0 70m：0.8
  var _disp_depth_lv2 = 0.9; //深さ画面色変える 深層 0m：1.0 100m：0.9

  var _now_duration_lv; //光点点滅レベル
  var _shoreHeight = 0.0;
  var _BottomHeight = 0.0;

  var _senchoMessage = ""; //船長の発言

  late Offset offset = Offset(0.0, 0.0);
  late double _appBarHeight = 0.0;

  late AnimationController waveController; // AnimationControllerの宣言

  var _ligntSpotAnimationChangeing = false;

  //ドラグ音
  // var url = "./static/sound/drag.mp3";
  // var audio = new Audio(url);

  @override
  void initState() {
    // buildメソッドが回り、AppBarの描画終了後に、GlobalKeyの情報を取得するようにするため、
    // addPostFrameCallbackメソッドを実行
    // null safety対応で?（null以外の時のみアクセス）をつける
    WidgetsBinding.instance?.addPostFrameCallback((cb) {
      //AppBarの高さを取得
      _appBarHeight = AppBar().preferredSize.height;
    });

    //光点アニメーションの初期化
    _now_duration_lv = POINT_DURATION_MSEC.length - 1; //初期値は最大値
    ligntSpotAnimation(true, POINT_DURATION_MSEC[_now_duration_lv]!);
    //定周期タイマの設定
    Timer.periodic(
      Duration(milliseconds: TIMER_INTERVAL),
      _onTimer,
    );

    waveController = AnimationController(
      duration: const Duration(seconds: 3), // アニメーションの間隔を3秒に設定
      vsync: this, // おきまり
    )..repeat(); // リピート設定

    super.initState();
  }

  void dispose() {
    _animationController.dispose();
    waveController.dispose(); // AnimationControllerは明示的にdisposeする。
    super.dispose();
  }

  //定周期処理
  void _onTimer(Timer timer) {
    if (!mounted) {
      //既に画面が無効の場合は無処理
      return;
    }

    if (_flgGameOver) {
      //ゲームオーバー中は無処理
      return;
    }

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
    var BottomWidget =
        globalKeyBottom.currentContext?.findRenderObject() as RenderBox;
    _BottomHeight = BottomWidget.size.height;

    //共通乱数 0.0～0.999... の乱数の作成 ※共通じゃだめなところには使っちゃだめ
    var rand = (new math.Random()).nextDouble();

    //深さの変化傾向判定
    _depth_change_scan_cnt++;
    if (_depth_change_scan_cnt > DEPTH_CHANGE_SCAN) {
      _depth_change_scan_cnt = 0;
      _depth_change = DEPTH_CHANGE_ORDERS[_depth_change_order]! +
          ((DEPTH_CHANGE_ORDERS[_depth_change_order]! - rand) / 10);
      debugPrint("深さ変化傾向" + _depth_change.toString());
    }

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

    if (_flgHit) {
      //debugPrint("HIT中1");
      if (_hit_scan_cnt > 0) {
        _hit_scan_cnt--;
      }
      //テンション増減にHIT中補正をかける
      var fish = FISH_TABLE[_fishidx]!;
      mx += (fish['add_max'] as int) *
          (_hit_scan_cnt / (fish['hp'] as int) * _fishSize).round();
      mn += (fish['add_min'] as int) *
          (_hit_scan_cnt / (fish['hp'] as int) * _fishSize).round();
      weight = fish['weight'];
    }
    addVal = (rand * (mx + 1 - (mn))).floor() + (mn) + weight;

    if (_onClutch) {
      //クラッチON中はマイナス補正を最大化
      addVal = HOSEI_MAX * -1;
      //水深を加算
      _depth++;
    } else {
      if (_onTap) {
        //巻きスピード
        var hosei = (_speed % SPEED_VAL_MAX) % HOSEI_MAX;
        //var hosei = (_speed % SPEED_VAL_MAX);
        //タップ中は補正を加味する
        addVal = addVal + hosei.round();
        //水深減算
        _depth = _depth - _speed / SPEED_VAL_MAX;
      }
    }
    if (addVal > 0) {
      //テンション+時は現在テンションによって補正をかける
      addVal * ((TENSION_VAL_MAX - _tension) / TENSION_VAL_MAX);
      //二次関数 テンション上がるごとに上がりにくくする
      addVal = addVal +
          (addVal * -1) * (MathPow._getPow(2, (_tension / TENSION_VAL_MAX)));
    }
    var val = _tension + addVal;

    //ゲームオーバー判定
    var gameovertext = "";
    //糸切れ判定
    if (val > TENSION_LINECUT) {
      //糸切れ
      debugPrint("いときれ");
      _flgGameOver = true;
      gameovertext = "糸が切れました。\nゲームオーバーです。\nゲームオーバーなのでもう何もできません";
    }
    //座礁判定
    if (_maxDepth < 2.0) {
      //座礁
      debugPrint("座礁");
      _flgGameOver = true;
      gameovertext = "船が座礁しました。\nゲームオーバーです。\nゲームオーバーなのでもう何もできません";
    }
    if (gameovertext != "") {
      //ゲームオーバーモーダル
      var result = showDialog<int>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("あーあ"),
              content: Column(children: <Widget>[
                Text(gameovertext),
                Text("あなたは" + _point.toString() + "ポイント獲得して終わりました"),
              ]),
              actions: <Widget>[
                FlatButton(
                  child: Text("メニューに戻ることしかできません"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      return;
    }

    //ドラグ判定
    var drag_val = _drag;
    //_tensionActiveTrackColor = TENSION_COLOR_SAFE;
    if (val > drag_val) {
      //テンションとドラグレベルの差分
      var drag_diff = val - drag_val;
      //ドラグ出た分深さを増やす
      _depth = _depth + drag_diff / 30;
      //ドラグ出た分テンションを減らす
      val = val - (drag_diff / 25);
      //テンションゲージの色を変える
      _tensionActiveTrackColor = TENSION_COLOR_DRAG;
      //audio.currentTime = 0;
      //audio.play();
      //var duration = 200; // 振動時間
      //navigator.vibrate(duration);
    }
    //  else {
    //   //テンションMAX（切れそう）判定 最大値の9割で切れそうと判定
    //   if (val >= (TENSION_VAL_MAX * 0.9)) {
    //     _tensionActiveTrackColor = TENSION_COLOR_DANGER;
    //   }
    // }

    if (val > TENSION_VAL_MAX) val = TENSION_VAL_MAX;
    if (val < TENSION_VAL_MIN) val = TENSION_VAL_MIN;

    if (_depth > _maxDepth) _depth = _maxDepth;
    if (_depth < 0) _depth = 0.0;

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
    _lightSpotX = 0;
    _lightSpotY = ((_depth / _maxDepth) *
        (size.height - _appBarHeight - _shoreHeight - _BottomHeight));

    //背景色
    if (_maxDepth < 100) {
      //水深10mまでは中層の範囲は固定
      _disp_depth_lv1 = 1.0;
    } else {
      //水深150mで0.1にする
      _disp_depth_lv1 = ((_maxDepth - 100) / 1400) * -0.9 + 1;
      //debugPrint(_disp_depth_lv1.toString());
    }
    if (_maxDepth < 1000) {
      //水深10mまでは深層の範囲は固定
      _disp_depth_lv2 = 1.0;
    } else {
      //水深500mで0.1にする
      _disp_depth_lv2 = ((_maxDepth - 1000) / 4000) * -0.9 + 1;
    }

    //釣り上げ判定
    if (_flgHit && _depth <= 1) {
      debugPrint("つりあげ");
      //釣りあげ時のモーダル
      var fish = FISH_TABLE[_fishidx]!;
      var fishSize = ((fish['size_max'] - fish['size_min']) * _fishSize +
          fish['size_min']);
      debugPrint("おおきさ" + size.toString());
      var point = fish['point'] + (fish['point'] * _fishSize).floor();
      var result = showDialog<int>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Container(
                // height: size.height / 3,
                // width: size.width / 1.5,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                  image: new AssetImage("assets/images/fishback.jpg"),
                  fit: BoxFit.cover,
                )),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  backgroundColor:
                      clsColor._getColorFromHex('D1F6FF').withOpacity(0.7),
                  title: Text(fish['text']),
                  content: Container(
                      height: size.height / 3,
                      // decoration: new BoxDecoration(
                      //     image: new DecorationImage(
                      //   image: new AssetImage("assets/images/fishback.jpg"),
                      //   fit: BoxFit.cover,
                      // )),
                      child: Column(children: <Widget>[
                        new Image(
                          image: AssetImage('assets/images/' + fish['image']),
                          // width: 150,
                          // height: 150,
                        ),
                        Text(fish['name'] +
                            "　" +
                            fishSize.toStringAsFixed(1) +
                            "cm"),
                        Text(point.toString() + 'ポイント獲得です'),
                      ])),
                  actions: <Widget>[
                    // ボタン領域
                    // FlatButton(
                    //   child: Text("Cancel"),
                    //   onPressed: () => Navigator.pop(context),
                    // ),
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        _point += point as int;
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
          });
      _flgHit = false;
    }

    //光点点滅速度関連の変数
    final durationMax = POINT_DURATION_MSEC[POINT_DURATION_MSEC.length - 1]!;
    final durationMin = POINT_DURATION_MSEC[0]!;
    var duration = 0;

    if (!_flgHit) {
      //HIT判定処理
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

      //var fishs = FISH_TABLE;
      Map<int, Map<String, dynamic>> fishs = {...FISH_TABLE};

      //深さから可能性のある種を抽出
      fishs.removeWhere((key, value) => _depth < value['tana_min']);
      fishs.removeWhere((key, value) => _depth > value['tana_max']);

      var maxProb = 0.0;
      //種毎の判定
      fishs.forEach((key, value) {
        var fish = fishs[key]!;
        var hitSpeedprob = 0.0;
        //糸出中、かつ水深MAXではない時
        if (_onClutch && _depth < _maxDepth) {
          hitSpeedprob = fish['hit_fall']; //フォール中の補正
        } else {
          //ドラグ出中、止めている時、水深0m未満、水深MAXの時は判定しない
          if (_tensionActiveTrackColor != TENSION_COLOR_DRAG &&
              _onTap &&
              _depth > 0 &&
              _depth < _maxDepth) {
            //HITスピードとの差分
            var speedDiff = (_speed - fish['hit_speed_just']).abs();
            //差分が範囲内か
            if (speedDiff < fish['hit_speed_range']) {
              hitSpeedprob = 1.0 *
                  ((speedDiff - fish['hit_speed_range']).abs() /
                      fish['hit_speed_range']);
            }
            if (hitSpeedprob < 0.2) {
              hitSpeedprob = 0.2; //速度範囲外の最低保証
            }
          }
        }
        //HIT確率の算出
        var hitProb =
            (hitTanaProb * hitSpeedprob * _jiai) * fish['wariai'] / 100;

        if (hitTanaProb * hitSpeedprob > maxProb) {
          maxProb = hitTanaProb * hitSpeedprob * _jiai * fish['wariai'];
        }
        //1～0の乱数生成
        var hitrnd = (new math.Random()).nextDouble();
        if (DEBUGFLG) {
          //すぐつれる
          hitrnd = 0.001;
        }

        //HIT判定
        if (hitProb > hitrnd) {
          //i 番目HIT
          _fishidx = key;
          //大きさ決定
          _fishSize = (new math.Random()).nextDouble();
          _hit_scan_cnt = fish['hp'];
          //HITと判定
          _flgHit = true;
          debugPrint("HIT!!!");
          _dispInfo = 'HIT!!!';
          _infoBackColor = TENSION_COLOR_DANGER;
        }
        if (_flgHit) {
          //ループ抜け
          return;
        } else {
          //HIT確率から点滅速度を算出
          duration =
              durationMax - ((durationMax - durationMin) * maxProb).floor();
          _dispInfo = (maxProb * 100).toStringAsFixed(0) + ' %';
          _infoBackColor = Colors.white;
          //HIT率に伴いポインタの色を変える？
          _pointerColor = clsColor._getColorFromHex("ffd900"); //？？？とりあえず黄色固定
        }
      });
    } else {
      //HIT中の処理
      _pointerColor = clsColor._getColorFromHex("ff0000"); //HIT中は赤固定表示

      //テンションから点滅速度を算出
      duration = durationMax -
          ((durationMax - durationMin) * (_tension / TENSION_VAL_MAX)).floor();

      //バレ判定 水深MAXかテンション一定未満で条件成立
      if (_depth >= _maxDepth || val <= TENSION_VAL_MIN + 20) {
        _bare_cnt++;
      } else {
        _bare_cnt = 0;
      }
      if (_bare_cnt >= BARE_MAX) {
        //バレ条件成立が一定スキャン保持でバレとする
        debugPrint("バレ");

        _flgHit = false;
        //console.log("bare...");
        //バレのモーダル表示
        //show_modal_bare();
        _bare_cnt = 0;
      }
    }

    duration = duration > durationMax ? durationMax : duration;
    duration = duration < durationMin ? durationMin : duration;
    //今回の点滅速度レベル 初期値は最大値
    var new_duration_lv = POINT_DURATION_MSEC.length - 1;
    for (var lv = 0; lv < POINT_DURATION_MSEC.length; lv++) {
      var d = POINT_DURATION_MSEC[lv]!;
      if (d > duration) {
        new_duration_lv = lv;
        break;
      }
    }
    //点滅速度レベルが変化した？
    if (new_duration_lv != _now_duration_lv || _ligntSpotAnimationChangeing) {
      if (ligntSpotAnimation(
          false, POINT_DURATION_MSEC[new_duration_lv] as int)) {
        //今回のアニメーションが止まってから変化させる
        _now_duration_lv = new_duration_lv;
      }
    }

    //最大深さをランダムで増減
    var depthrnd = (new math.Random()).nextDouble();
    _maxDepth += 1 * ((_depth_change) - depthrnd);

    //棚を示す光点の表示
    var hannornd = (new math.Random()).nextDouble();
    if (hannornd > 0.96 && _jiai > depthrnd) {
      var fishy = (sonarTop - _appBarHeight) + (sonarHeight * _justTana);
      //レンジ分バラケ
      var barake = (_justTanaRange * ((0.2 - depthrnd) * 1.5));
      barake = (barake < 0) ? 0 : barake;
      barake = (barake > (sonarTop - _appBarHeight) + sonarHeight)
          ? (sonarTop - _appBarHeight) + sonarHeight
          : barake;
      fishy = fishy + (_justTanaRange * ((0.2 - depthrnd) * 1.5));
      generateFishPointer(fishy, 20);
    }

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
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("環境設定"),
          ]),
          leading: IconButton(
            // 戻るアイコン
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () {
              //前画面に戻る
              Navigator.of(context).pop();
            },
          ),
        ),
        endDrawer: DrawerItem(),

        // body: SafeArea(
        //   child: SpriteWidget(
        //     RootNode(size),
        //   ),
        // ),

        body: GestureDetector(
            //ドラッグ操作が開始された時
            onPanStart: (DragStartDetails details) {
              debugPrint("ドラッグ開始");
              _cursorx = details.localPosition.dx;
              //add_min = -1;
              // var video = $('#bg-video').get(0);
              // video.src = './static/videos/Position2_巻き上げ3.mp4';
              // video.play();
              // $('#bg-video1').get(0).play();
              // $('#bg-video1').removeClass("invisible");
              // $('#bg-video2').addClass("invisible");

              chenge_clutch(false);
              _onTap = true;
              //タップ時の画面エフェクト
              offset = Offset(details.globalPosition.dx,
                  details.globalPosition.dy - _appBarHeight);
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
              var mX = 0.0;
              if (!_onTap) {
                return;
              }
              //現在のX座標を取得する
              mX = details.localPosition.dx; //X座標
              //初期位置から動いた値を取得
              var movex = mX - _cursorx;
              //x座標記憶を更新
              _cursorx = mX;
              var addVal = (movex / (1000 / 2) * SPEED_VAL_MAX);
              //巻き速度値に加算
              var val = _speed + addVal;
              if (val > SPEED_VAL_MAX) val = SPEED_VAL_MAX;
              if (val < SPEED_VAL_MIN) val = SPEED_VAL_MIN;
              _speed = val;
              setState(() {});

              //videoの再生スピード調整（1～300）
              //$('#bg-video1').get(0).playbackRate = Math.floor(val / 15) / 10;

              // if (size.isEmpty) {
              //   return;
              // }
            },
            //タップ、ドラッグ操作が終了した時
            onPanEnd: (DragEndDetails details) {
              debugPrint("タップはなし");
              chenge_clutch(false);
              //add_min = -10;
              _onTap = false;
              //スピードスライダの色を戻す
              _speedActiveTrackColor = SPEED_COLOR;
              // var video = $('#bg-video').get(0);
              // video.src = './static/videos/Position2_巻き上げ3.mp4';
              // video.pause();
              // $('#bg-video1').get(0).pause();
              // $('#bg-video1').removeClass("invisible");
              // $('#bg-video2').addClass("invisible");
            },
            //child: new Stack(children: <Widget>[
            //背景スプライト
            //SpriteWidget(RootNode(size)),
            child: new Stack(children: <Widget>[
              Column(children: <Widget>[
                //海上
                Container(
                  key: globalKeyShore,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('Assets/Images/sencho.png'),
                      //   fit: BoxFit.cover, //？？？全画面にするときはここ有効化
                      // ),
                      //color: clsColor._getColorFromHex("200070"),
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
                        margin: EdgeInsets.only(top: 5),
                        height: 45,
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
                                        activeColor: _tensionActiveTrackColor,
                                        value: _tension / TENSION_VAL_MAX,
                                        backRadius: _animationRadius.value,
                                        maxBackRadius: POINTER_BACK_SIZE,
                                      ),
                                      child: Container(
//                                  height: 500,
                                          ),
                                    )
                                  ])),
                          // SliderTheme(
                          //     data: SliderTheme.of(context).copyWith(
                          //       trackHeight: 20, //全体の縦長
                          //       valueIndicatorColor: Colors.white, //背景の色
                          //       activeTrackColor:
                          //           _tensionActiveTrackColor, //値有りエリアの色
                          //       inactiveTrackColor: Colors.white,
                          //       activeTickMarkColor:
                          //           Colors.black.withOpacity(0.0), //値ツマミの色
                          //       thumbColor:
                          //           Colors.black.withOpacity(0.0), //現在レベルの色
                          //       thumbShape: RoundSliderThumbShape(
                          //           enabledThumbRadius: 0), //値ツマミの径
                          //       overlayColor: Colors.black
                          //           .withOpacity(0.0), //値ツマミフォーカス時の色
                          //       //inactiveTrackColor: Colors.amber,
                          //       //inactiveTickMarkColor: Colors.blue,
                          //     ),
                          //     child: Slider(
                          //       value: _tension,
                          //       min: TENSION_VAL_MIN,
                          //       max: TENSION_VAL_MAX,
                          //       divisions:
                          //           (TENSION_VAL_MAX - TENSION_VAL_MIN) as int,
                          //       onChanged: (double value) {
                          //         //ユーザが変更するものではないのでコメント
                          //         //   setState(() {
                          //         //     _tension = value.roundToDouble();
                          //         //   });
                          //       },
                          //)),
                          //ドラグスライダー
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 50,
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
                                  //inactiveTrackColor: Colors.amber,
                                  //inactiveTickMarkColor: Colors.blue,
                                ),
                                child: Slider(
                                  value: _drag,
                                  //MAX-MINはテンションと同じ
                                  min: TENSION_VAL_MIN,
                                  max: TENSION_VAL_MAX,
                                  divisions: (TENSION_VAL_MAX - TENSION_VAL_MIN)
                                      as int,
                                  onChanged: (double value) {
                                    setState(() {
                                      _drag = value.roundToDouble();
                                    });
                                  },
                                )),
                          )
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
                                  activeColor: _speedActiveTrackColor,
                                  value: _speed / SPEED_VAL_MAX,
                                  backRadius: 0,
                                  maxBackRadius: 0,
                                ),
                                child: Container(),
                              )
                            ])),
                    // SliderTheme(
                    //   data: SliderTheme.of(context).copyWith(
                    //     trackHeight: 20, //全体の縦長
                    //     valueIndicatorColor: Colors.white, //背景の色
                    //     activeTrackColor: _speedActiveTrackColor, //値有りエリアの色
                    //     inactiveTrackColor: Colors.white,
                    //     activeTickMarkColor:
                    //         Colors.black.withOpacity(0.0), //値ツマミの色
                    //     thumbColor: Colors.black.withOpacity(0.0), //現在レベルの色
                    //     thumbShape: RoundSliderThumbShape(
                    //         enabledThumbRadius: 0), //値ツマミの径
                    //     overlayColor:
                    //         Colors.black.withOpacity(0.0), //値ツマミフォーカス時の色
                    //     //inactiveTrackColor: Colors.amber,
                    //     //inactiveTickMarkColor: Colors.blue,
                    //   ),
                    //   child: Slider(
                    //     value: _speed,
                    //     //MAX-MINはテンションと同じ
                    //     min: SPEED_VAL_MIN,
                    //     max: SPEED_VAL_MAX,
                    //     divisions: (SPEED_VAL_MAX - SPEED_VAL_MIN) as int,
                    //     onChanged: (double value) {
                    //       //画面スワイプで動かす
                    //     },
                    //   ),
                    // ),
                    Stack(children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        // margin: EdgeInsets.only(
                        //     top: math.sin(waveController.value * 0.5 * math.pi),
                        //     left: math.sin(waveController.value * math.pi)),
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              _senchoMessage = "わしゃあ忙しいんで！";
                            });
                            var result = await showDialog<int>(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return SenchoDialog(
                                  depth_change_order: _depth_change_order,
                                  point: _point,
                                );
                              },
                            );
                            debugPrint(result.toString());
                            setState(() {
                              _depth_change_order = result as int;
                            });
                          },
                          child: new Image(
                            image: AssetImage('Assets/Images/ship.png'),
                            width: 60,
                            height: 40,
                          ),
                        ),
                      ),
                      Container(
                          height: 40,
                          child: AnimatedBuilder(
                            animation: waveController, // waveControllerを設定
                            builder: (context, child) => Stack(
                              children: <Widget>[
                                //Text(waveController.value.toString()), // テスト用
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
                          ))
                    ]),
                  ]),
                ),
                //海中
                Container(
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
                          stops: [0.0, _disp_depth_lv1, _disp_depth_lv2, 1.0],
                        )),
                    width: size.width,
                    height: size.height -
                        _appBarHeight -
                        _shoreHeight -
                        _BottomHeight,
                    child: Column(children: <Widget>[
                      //ソナー画面
                      Expanded(
                        //描画エリア
                        child: Container(
                          key: globalKeySonar,
                          child: Stack(children: <Widget>[
                            //ソナー光点
                            Container(
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
                          ]),
                        ),
                      ),
                    ])),

                //海底
                Container(
                    key: globalKeyBottom,
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
                    // 内側の余白（パディング）
                    //padding: EdgeInsets.all(8),
                    // 外側の余白（マージン）
                    //margin: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        // new Expanded(
                        //     child:

                        //画面下部
                        Container(
                          margin: EdgeInsets.all(3),
                          child: Row(
                              //3分割カラムを均等配置
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //1分割目カラム 水深表示
                                Column(
                                  children: <Widget>[
                                    // Container(
                                    //   padding: const EdgeInsets.all(5.0),
                                    //   decoration: BoxDecoration(
                                    //       border: Border.all(
                                    //           color: Colors.red, width: 3),
                                    //       color: Colors.white),
                                    //   child: Text(_disp_depth,
                                    //       style: TextStyle(
                                    //         color: Colors.black,
                                    //         fontWeight: FontWeight.bold,
                                    //         fontSize: 20,
                                    //       )),
                                    // )
                                  ],
                                ),
                                //2分割目カラム（クラッチボタン）
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                          width: 150,
                                          height: 50,
                                          child: ElevatedButton(
                                            child: const Text('クラッチ'),
                                            style: ElevatedButton.styleFrom(
                                              primary: _clutchBackColor, //背景色
                                              onPrimary: Colors.black, //押したときの色
                                              shape: const StadiumBorder(),
                                              side: BorderSide(
                                                color: Colors.black, //枠線の色
                                                width: 2, //枠線の太さ
                                              ),
                                            ),
                                            onPressed: () {
                                              //audio.load();
                                              //document.getElementById( 'clutch_sound' ).currentTime = 0 ;
                                              //$('#clutch_sound').get(0).play();
                                              ////var video = $('#bg-video').get(0);
                                              if (!_onClutch) {
                                                //クラッチOFFの場合、クラッチONする
                                                //$('#btn_clutch').addClass("btn_clutch_on");
                                                chenge_clutch(true);

                                                //// video.src = './static/videos/Position2_クラッチ2.mp4';
                                                //// video.play();
                                                //$('#bg-video1').addClass("invisible");
                                                //$('#bg-video2').removeClass("invisible");
                                                //var video =  $('#bg-video2').get(0);
                                                //video.play();
                                              } else {
                                                //$('#btn_clutch').removeClass("btn_clutch_on");
                                                chenge_clutch(false);

                                                // // video.src = './static/videos/Position2_巻き上げ3.mp4';
                                                // // video.pause();
                                                // $('#bg-video1').get(0).pause();
                                                // $('#bg-video1').removeClass("invisible");
                                                // $('#bg-video2').addClass("invisible");
                                              }
                                            },
                                          )),
                                    ]),
                                //3分割目カラム（ポイント表示）
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.red, width: 3),
                                              color: Colors.white),
                                          child: Text(_dispDepth,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Text(_dispInfo,
                                        style: TextStyle(
                                          backgroundColor: _infoBackColor,
                                        )),
                                    Container(
                                      //width: size.width / 3,
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(_point.toString() + "ポイント",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          )),
                                    )
                                  ],
                                )
                              ]),
                        ),
                      ],
                    )),
              ]),
              Stack(children: <Widget>[
                //タップ時の光点
                (tapPointerList.isNotEmpty)
                    ? Stack(children: tapPointerList)
                    : Text(""),
                //反応光点
                (fishPointerList.isNotEmpty)
                    ? Stack(children: fishPointerList)
                    : Text(""),
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
  Future<void> generateFishPointer(offsetY, fishsize) async {
    const duration = const Duration(milliseconds: 20000);
    var size = MediaQuery.of(context).size;
    final fishPointer = FishPointer(
      key: UniqueKey(), // 必ずキーを与えること。これによりそれぞれが独立した描画になります。
      dispsizeX: size.width, //画面サイズX
      offsetY: offsetY,
      duration: duration,
      fishsize: fishsize,
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
  void chenge_clutch(bool flg) {
    if (flg == _onClutch) {
      //状態変更無し時は無処理
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

  bool ligntSpotAnimation(bool initflg, int duration_msec) {
    if (initflg || !_animationController.isAnimating) {
      debugPrint("あたらしい");
      //アニメーションの定義
      _animationController = AnimationController(
          duration: Duration(milliseconds: duration_msec), vsync: this);
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
        debugPrint("止める指示");
        _animationController.forward();
        _ligntSpotAnimationChangeing = true;
      }
      return false;
    }
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
