//素材元
//YouTuberのための素材屋さん
//https://ytsozaiyasan.com/
//魔王魂
//https://maou.audio/
//効果音ラボ
//https://soundeffect-lab.info/

//☆基本概要
//・モード案１：ずっとモード
//　　　　　　好きなロケ、道具等で好きにできる、状態保存して続きからできる
//・モード案２：だんだん条件が厳しくなる
//・モード案３：水深500mにいるボスを倒す

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
//済・波の下の罫線が気になる、波をBOTTOMで描画すれば解決かも？→しない
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
//済・ゲームオーバー無しにする
//済・ルアー耐久システム
//済・スライダーの右下に数値も出す
//済・沖合何メートルの表示
//済・最大水深によって釣れる魚の大きさを制限
//済・ルアー大きさによって釣れる魚の大きさを制限
//済・当たった時にアワセ判定ラインを表示
//済・バレるラインを表示
//済・リールタップしていいとき光らすとかの表示
//済・ルアーめげるシステムいらんくね？
//済・おさかな図鑑画面で？でも何mでつれるかの表示出す
//・今釣れる可能性のある魚をリスト表示
//・店
//・風
//・陸から何メートルで釣れる魚変わるシステム
//・雲
//・時合度が低いのが続かんようにするか、高くできるようにする
//・王冠つきじゃないと詳細アンロックしない
//・魚種毎に実績
//・設定画面 合わせの強さ調節
//・設定画面 音ボリューム
//・音
//・実績
//・中断セーブ機能
//・赤ポイント緑ポイント青ポイント
//・光点が横に走る
//・水流
//・水中に泡とか
//・海底に漁礁とか
//・全体的見た目何とかする、水中にテカリ的なグラデーションとか
//・通知インフォメーション 今が時合で！みたいな
//・ポイントで色々　道具買ったり、糸替え、船長指示、ゲームオーバーから復活とか
//・HIT時につっこみモード、おとなしいモードつけて勢い度
//・糸切れ判定 勢い度を加味して切れるようにする
//・魚種データをDB化して登録画面実装
//・エリア選択 エリアによって魚種、深さ等変える
//・チュートリアルか、ヘルプか
//夢
//・アワセシステム ARVRモード時はスマホをジャイロで動かす、通常時は下にドラッグでアワセ
//・背景にAR的なカメラ映像（カメラ無いときはアニメーション）
//・背景にrod、ジャイロで動かす

import 'package:fish_flutter/Main.dart';
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:fish_flutter/Model/HaveTackleModel.dart';
import 'package:fish_flutter/Model/SpeedRange.dart';
import 'package:fish_flutter/widget/BookDialog.dart';
import 'package:fish_flutter/widget/FishRangeSliderPainter.dart';
import 'package:fish_flutter/widget/LightSpot.dart';
import 'package:fish_flutter/widget/RadarChart.dart';
import 'package:fish_flutter/widget/ShopDialog.dart';
import 'package:fish_flutter/widget/SettingDialog.dart';
import 'package:fish_flutter/widget/TapPointer.dart';
import 'package:fish_flutter/widget/FishPointer.dart';
import 'package:fish_flutter/widget/WaveClipper.dart';
import 'package:fish_flutter/widget/SenchoDialog.dart';
import 'package:fish_flutter/widget/SliderPainter.dart';
import 'package:fish_flutter/widget/fishGetDialog.dart';
import 'package:fish_flutter/widget/imagePainter.dart';
import 'package:fish_flutter/widget/tacklePainter.dart';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

import 'package:flutter/rendering.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:fish_flutter/widget/BgmPlayer.dart';
import 'package:fish_flutter/Class/BasePageState.dart';
import 'package:fish_flutter/Model/DispObjectModel.dart';

class Fishing extends StatefulWidget {
  Fishing({Key? key}) : super(key: key);
  static String screenBgm = 'bgm_field.mp3';

  @override
  _FishingState createState() => _FishingState();
}

enum PlayerState { stopped, playing, paused }

// つりページのステータス管理
class _FishingState extends BasePageState<Fishing>
    with TickerProviderStateMixin {
  _FishingState()
      : super(fileName: Fishing.screenBgm); // <-- 親クラスのコンストラクタにファイル名設定

  //定数の定義？？？いろいろ環境設定にした方がいいかと
  //モーダル中のBGM

  //late AudioCache _subBgm;
  late AudioPlayer _ap;

  //デバッグフラグ すぐつれちゃう
  //static const DEBUGFLG = true;
  static const DEBUGFLG = false;

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

  //最大水深(0.1m)ごとの風の強さ
  static const Map<int, double> WIND_FOR_DEPTH = {
    // 0: 0.5,
    // 200: 0.6, //0～20mまでは微風で進む
    // 500: 0.5, //20～50mまでは無風
    // 1000: 0.4,
    // 2000: 0.3,
    9999: 0.7,
  };

  //static const TIMER_INTERVAL = 50; //1スキャン時間(msec) 20FPS
  static const TIMER_INTERVAL = 33; //1スキャン時間(msec) 30FPS
  //static const TIMER_INTERVAL = 17; //1スキャン時間(msec) 60FPS
  //static const TENSION_VAL_MAX = 300.0; //テンションスライダーMAX値
  static const TENSION_VAL_MIN = 0.0; //テンションスライダーMIN値
  //static const TENSION_LINECUT = 290.0; //糸切れ判定値
  //static const _speedValMax = 300.0; //巻き速度スライダーMAX値
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
  late AnimationController _commonAnimationController; //共通アニメーション
  late Animation<double> _commonAnime;
  late AnimationController _jerkTextAnimationController; //ジャーク時のテキストアニメーション
  late Animation<double> _jerkTextLocation;
  late AnimationController _clutchAnimationController; //クラッチの表示アニメーション
  late Animation<double> _clutchAnime;

  //定周期タイマ
  late Timer _timer;

  //状態フラグ変数
  var _onTap = false; //現在タップ中フラグ
  var _onClutch = false; //現在クラッチ状態
  var _flgBait = false; //現在アタリ中フラグ
  var _flgHit = false; //現在HIT中フラグ
  //var _flgGameOver = false; //現在ゲームオーバーフラグ

  //ステート変数
  var _tension = 0.0; //テンション値
  var _tensionValMax = 0.0; //テンション最大値 竿によって可変
  var _fookingTension = 0.0; //アタリ時のアワセ判定値
  var _drag = 0.0; //ドラグレベル値
  var _speed = 0.0; //巻き速度値
  var _speedValMax = 0.0; //スピード最大値 リールによって可変
  var _depth = 0.0; //現在糸出し量(0.1m)
  var _prevDepth = 0.0; //前回スキャンの糸出し量（浮上判定用）
  var _maxDepth = 50.0; //最大水深(0.1m)
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
  var _point = 1000; //獲得ポイント
  var _justTana = 0.5; //HIT確率判定 時合棚 0.0～1.0
  var _justTanaRange = 50.0; //0.1m単位 +-までは時合圏内
  var _tanaChangeScanCnt = 0; //棚変化スキャンカウント数
  var _jiai = 0.9; //時合度 0.0～0.9999...
  var _jiaiChangeScanCnt = 0; //時合度の変化スキャンカウント数
  var _maxLineHp = 500.0; //ラインHP最大値
  var _nowLineHp = 50.0; //現在ラインHP

  var _shipMoveSeScan = 0;

  List<SpeedRange> _listSpeedRange = []; //可能性ある魚種毎のスピード範囲

  var _cursorX = 0.0; //ドラッグ操作開始時の座標X
  var _cursorY = 0.0; //ドラッグ操作開始時の座標Y
  var _jerkCnt = 0; //ジャークの継続スキャン数

  var _baitCnt = 0; //当たってからのスキャン数
  //var _baitMaxTension = 0.0; //バイト中の最大テンション
  var _fookingLv = 0.0; //フッキングの成功度

  var _fishidx = 0; //現在HIT中の魚種IDX
  var _fishSize = 0.0; //現在HIT中の魚の大きさ MAXを1.0とした時の割合
  var _hitScanCnt = 0; //HITしてからのスキャン数
  var _bareCnt = 0; //バレ判定カウント
  var _abareLv = 0;

  var _shipMove = 0.5; //船の動き 1.0～0,0 +なら深くなる、-なら浅くなる
  var _depthChange = 0.5; //深さの変化傾向 1.0～0,0 +なら深くなる、-なら浅くなる
  //var _depthChangeScanCnt = 0; //深さの変化傾向スキャンカウント数
  //var _depthChangeOrder = 0; //変化傾向 初期値は現状維持
  var _dispDepthLv1 = 0.45; //深さ画面色変える 中層 0m：1.0 70m：0.8
  var _dispDepthLv2 = 0.9; //深さ画面色変える 深層 0m：1.0 100m：0.9

  var _windLevel = 0.5; //風レベル 0.0～1.0 0.5で無風

  var _nowDurationLv; //光点点滅レベル
  var _sonarTop = 0.0;
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
  var _takcleChangeButtonPosition = MainAxisAlignment.end;
  var _rodStandUp = 0.0;
  var _handleRoll = 0.0;

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

  //沖合何km
  var offShore = 0.0;

  late ui.Image imageTeibou;
  var getImageTeibou = false;

  //ドラグ音
  // var url = "./static/sound/drag.mp3";
  // var audio = new Audio(url);

  @override
  void initState() {
    //サブBGM再生
    _ap = new AudioPlayer();
    // AudioCache _player = AudioCache();
    // AudioCache _subBgm = AudioCache(
    //   fixedPlayer: _ap,
    // );

    // this.bgmPlay('Bgm/bgm_field.mp3');

    //魚テーブルを初期化？？？本当はエリアで絞る
    FISH_TABLE = new FishsModel();
    //釣果リストを初期化
    fishesResult = new FishesResultModel();
    //ルアーリストを初期化？？？本当はDBマスタから全取得
    lures = new LuresModel();
    //所持リストを初期化
    haveTackle = new HaveTackleModel();
    _tensionValMax = haveTackle.getUseRod().maxTention;
    _speedValMax = haveTackle.getUseReel().maxSpeed;
    _drag = _tensionValMax * 0.8;

    // buildメソッドが回り、AppBarの描画終了後に、GlobalKeyの情報を取得するようにするため、
    // addPostFrameCallbackメソッドを実行
    // null safety対応で?（null以外の時のみアクセス）をつける
    WidgetsBinding.instance?.addPostFrameCallback((cb) {
      createImage();

      //AppBarの高さを取得
      _appBarHeight = AppBar().preferredSize.height;

      //定周期タイマの開始
      startTimer();
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

    _commonAnimationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    //アニメーションの定義
    _commonAnimationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _commonAnime = Tween(begin: 0.0, end: 1.0)
        .animate(_commonAnimationController)
        .drive(CurveTween(curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
    _commonAnimationController.repeat(reverse: true);

    //クラッチのアニメーション
    _clutchAnimationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _clutchAnimationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _clutchAnime = Tween(begin: 0.0, end: 1.0)
        .animate(_clutchAnimationController)
        .drive(CurveTween(curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
    _clutchAnimationController.repeat(reverse: true);

    super.initState();
  }

  void createImage() async {
    final rawData = await rootBundle.load('assets/Images/teibou.png');
    final imgList = Uint8List.view(rawData.buffer);
    imageTeibou = await decodeImageFromList(imgList);
    getImageTeibou = true;
  }

  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    waveController.dispose(); // AnimationControllerは明示的にdisposeする。
    _centerTextAnimationController.dispose();
    _commonAnimationController.dispose();
    _clutchAnimationController.dispose();
    _jerkTextAnimationController.dispose();
    fishPointerList.clear();
    _ap.stop();
    _ap.dispose();
    super.dispose();
  }

  //画面の基本BGM関連
  Future bgmPlay(file) async {
    super.bgm.playBgm(name: file);
  }

  Future bgmPause() async {
    super.bgm.pauseBgmAny();
  }

  Future bgmResume() async {
    super.bgm.resumeBgm();
  }

  Future bgmStop() async {
    super.bgm.stopBgmAny();
  }

  //ダイアログ等 一時BGM
  Future subBgmPlay(file) async {
    if (settings.flgBgm) {
      _ap.setReleaseMode(ReleaseMode.RELEASE);
      await _ap.play('assets/' + file, volume: settings.volumeBgm);
    }
  }

  Future subBgmLoop(file) async {
    if (settings.flgBgm) {
      _ap.setReleaseMode(ReleaseMode.LOOP);
      await _ap.play('assets/' + file, volume: settings.volumeBgm);
    }
  }

  Future subBgmStop() async {
    await _ap.stop();
  }

  //定周期タイマの起動
  void startTimer() {
    _timer = Timer.periodic(
      Duration(milliseconds: TIMER_INTERVAL),
      onTimer,
    );
  }

  //定周期処理
  void onTimer(Timer timer) async {
    if (!mounted) {
      //既に画面が無効の場合は無処理
      return;
    }

    // if (_flgGameOver) {
    //   //ゲームオーバー中は無処理
    //   return;
    // }

    _tensionValMax = haveTackle.getUseRod().maxTention;
    _speedValMax = haveTackle.getUseReel().maxSpeed;
    //画面サイズ取得用
    final Size size = MediaQuery.of(context).size;

    //ソナー部のY位置と高さを取得
    var sonarWidget =
        globalKeySonar.currentContext?.findRenderObject() as RenderBox;
    var sonarHeight = sonarWidget.size.height;
    _sonarTop = sonarWidget.localToGlobal(Offset.zero).dy;

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

    //現在使用中のルアーデータ
    LureModel lureData = lures.getLureData(haveTackle.getUseLure().lureId);

    //風レベル判定
    for (int key in WIND_FOR_DEPTH.keys) {
      if (_maxDepth.toInt() < key) {
        _windLevel = WIND_FOR_DEPTH[key] as double;
        break;
      }
    }

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
      //地合値の計算 0.5以下にはしない
      _jiai = 0.5 + (0.5 * (new math.Random()).nextDouble());
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
    if (_moveShipTarget > _shipMove) {
      _shipMove += 0.01;
    }
    if (_moveShipTarget < _shipMove) {
      _shipMove -= 0.01;
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
      _shipMoveSeScan++;
      if (_shipMoveSeScan >= (800 / TIMER_INTERVAL).floor()) {
        //船動作音が連続再生しすぎるのを防止
        bgm.soundManagerPool.playSound('Se/shipmove.mp3');
        _shipMoveSeScan = 0;
      }
    }
    //深さ変化度合の決定
    _depthChange = (_shipMove - 0.5) + ((_windLevel - 0.5) / 10);

    //深さ決定 船移動分と風分
    _maxDepth += _depthChange;

    //深さ変化中
    if (_depthChange != 0.0) {
      //魚反応を移動させる
      fishPointerList.forEach((element) {
        //描画ごとにglovalkeyを付けているのでそれにアクセス
        RenderCustomPaint obj = element.painterKey.currentContext
            ?.findRenderObject() as RenderCustomPaint;
        FishPainter obj2 = obj.painter as FishPainter;
        //addxの値を加減算で移動
        obj2.addX += MOVE_FISHPOINTER_MAX * (_depthChange) * -1;
        obj2.addX += 0.5 - element.randMove;
      });
    }

    //座礁判定
    if (_maxDepth < 3.0) {
      //これ以上浅くいけない
      _maxDepth = 3.0;
      if (_moveShipTarget < 0.5) _moveShipTarget = 0.5;
    }

    //魚の残HP
    if (_flgHit) {
      //HIT中
      //暴れレベル変化判定
      if (rand < 0.05) {
        _abareLv =
            (new math.Random()).nextInt(FISH_TABLE.fishs[_fishidx].abareLv) + 1;
        debugPrint(_abareLv.toString());
      }
      //残HP減算 暴れLv分減算
      _hitScanCnt -= _abareLv;
      // //魚残HPの計算
      // if (_hitScanCnt > 0) {
      //   var minusHp = 1;
      //   //テンションが200以上
      //   if (_tension > 200.0) {
      //     //最大テンションとの差分の10分の1を補正として加算
      //     minusHp += ((_tension - _tensionValMax) / 10).floor();
      //   }
      //   //テンションが強いほどマイナス値を上げる
      //   //_hitScanCnt -= minusHp;
      // }
      if (_hitScanCnt < 0) _hitScanCnt = 0;
    }

    //テンションの処理
    num addVal = 0;
    var weight = 0.0;
    var mx = MAX_RAND_ADD_TENSION;
    var mn = MIN_RAND_ADD_TENSION;
    //ルアー重さ
    weight = lureData.weight;
    if (_collect) {
      //高速回収中
      weight -= 1000;
      _onClutch = false;
    }
    if (_onClutch) {
      //クラッチON中
      weight -= 1000;
    }
    if (_flgBait || _flgHit) {
      //アタリかHIT中
      //アタリ中 or HIT中 テンション増減にHIT中補正をかける
      var fish = FISH_TABLE.fishs[_fishidx];
      // mx += fish.addMax * (_hitScanCnt / fish.hp * _fishSize).round();
      // mn += fish.addMin * (_hitScanCnt / fish.hp * _fishSize).round();

      //魚重量
      var fishWeight = fish.getWeight(_fishSize);
      //weight += (fish.abareWeight * (0.3 - rand) * (_hitScanCnt / fish.hp) * _fishSize;
      //暴れ重量 ((魚重量 * 暴れレベル) * rnd値 * 残HP割合
      var abareWeight =
          ((fishWeight * _abareLv) * rand) * (_hitScanCnt / fish.hp);

      weight += fishWeight + abareWeight;
    }
    //シャクリによるテンション増加？？？竿長さによって係数を可変にする
    weight += _rodStandUp * 1000;

    //巻き中の時、重量に巻速度を加味
    if (_onTap) {
      weight = weight + (weight * (_speed / _speedValMax));
      //ハンドル回転の描画用
      _handleRoll += (_speed / _speedValMax) / 10;
      _handleRoll = (_handleRoll > 1.0) ? 0.0 : _handleRoll;
    }
    //浮力分調整（てきとーに２で割る）
    weight = weight / 2;
    //addVal = ((mx + 1 - mn) * rand).floor() + (mn) + (weight / 200);
    var tensionDiff = ((weight - _tension) * rand / 10).floor();
    addVal = tensionDiff;

    //現在深さの処理
    if (_collect) {
      //高速回収中
      _depth -= _maxDepth / 10;
    } else if (_onClutch) {
      //クラッチON中は強制的にテンション減算
      //水深を加算
      //ルアー重さによってフォール速度に補正をかける 20gの時0.1m/スキャン
      _depth += (lureData.weight / 20);
    } else {
      if (_onTap) {
        //水深減算
        _depth = _depth - _speed / 300;
      } else {
        // if (!_flgBait && !_flgHit) {
        //   //巻いていない&釣れていない時はマイナス補正
        //   addVal -= HOSEI_MAX;
        //}
      }
      //debugPrint(_rodStandUp.toString());
      //シャクリによる水深減算
      _depth -= _rodStandUp * 2;
    }

    if (addVal > 0) {
      //テンション+時は現在テンションによって補正をかける
      //addVal * ((TENSION_VAL_MAX - _tension) / TENSION_VAL_MAX);
      //二次関数 テンション上がるごとに上がりにくくする
      addVal = addVal +
          (addVal * -1) * (MathPow._getPow(3, (_tension / _tensionValMax)));
    }
    var val = _tension + addVal;

    // //ゲームオーバー判定
    // var gameovertext = "";
    //糸ダメージ判定
    if (val > _tensionValMax * 0.95) {
      _nowLineHp -= val - _tensionValMax * 0.95; //ラインHPを減らす
      if (_nowLineHp < 0) {
        //糸切れ
        debugPrint("いときれ");
        //メッセージ
        _centerTextMain = "BREAK";
        _centerTextMainColor = Colors.red;
        _centerTextSub = "糸が切れた!";
        _centerTextSubColor = Colors.yellow;
        startCenterInfo();
        //使用中のルアーを削除
        haveTackle.lostLure(haveTackle.getUseLure().id);
        _flgBait = false;
        _flgHit = false;
        val = 0.0;
        bgm.soundManagerPool.playSound('Se/linebreak.mp3');
        bgmPlay(Fishing.screenBgm);
      }
    }
    //ドラグ判定
    var dragVal = _drag;
    //_tensionActiveTrackColor = TENSION_COLOR_SAFE;
    if (val > dragVal) {
      //テンションとドラグレベルの差分
      var dragDiff = val - dragVal;
      //ドラグ出た分深さを増やす？？？出すぎ？
      _depth = _depth + dragDiff / 300;
      //ドラグ出た分テンションを減らす？？？減らなすぎ？
      val = val - (dragDiff / 10);
      //テンションゲージの色を変える
      _tensionActiveTrackColor = TENSION_COLOR_DRAG;

      //ドラグ音再生
      if (dragDiff > 15) {
        bgm.soundManagerPool.playSound('Se/drag2_high.mp3');
      } else {
        bgm.soundManagerPool.playSound('Se/drag2.mp3');
      }
    } else {
      //   //テンションMAX（切れそう）判定 最大値の9割で切れそうと判定
      //   if (val >= (_tensionValMax * 0.9)) {
      //     _tensionActiveTrackColor = TENSION_COLOR_DANGER;
      //   }
    }

    if (val > _tensionValMax) val = _tensionValMax;
    if (val < TENSION_VAL_MIN) val = TENSION_VAL_MIN;

    if (_depth > _maxDepth) _depth = _maxDepth;
    if (_depth <= 0) {
      //深さ0m
      _depth = 0.0;
      if (_prevDepth > 0.0) {
        if (_flgHit) {
          bgm.soundManagerPool.playSound('Se/waterupfish.mp3');
        } else {
          bgm.soundManagerPool.playSound('Se/waterup.mp3');
        }
      }
      //ラインHPを回復
      _nowLineHp = _maxLineHp;
      //高速回収中フラグをリセット
      _collect = false;
    }
    _prevDepth = _depth;

    //テンション確定
    _tension = val;

    //テンションによってテンションバーの色を変える
    _tensionActiveTrackColor = clsColor._getColorRange(
        TENSION_COLOR_SAFE, TENSION_COLOR_DANGER, _tension, _tensionValMax);

    //水深表示
    _dispDepth = ((_depth).round() / 10).toStringAsFixed(1) +
        " / " +
        ((_maxDepth).round() / 10).toStringAsFixed(1) +
        ' m';

    // //使用中ルアーのHP減算
    // HaveLureModel lure = haveTackle.getUseLure();
    // //針は対象外
    // if (lure.lureId != 0) {
    //   //テンションに応じたダメージを与える
    //   lure.lureHp -= (_tension / 100).floor();
    //   if (lure.lureHp < 0.0) {
    //     //ルアーがめげた
    //     haveTackle.lostLure(lure.id);
    //     //メッセージ
    //     _centerTextMain = "BROKEN";
    //     _centerTextMainColor = Colors.blue;
    //     _centerTextSub = "ルアーが破壊!";
    //     _centerTextSubColor = Colors.yellow;
    //     startCenterInfo();
    //     bgm.soundManagerPool.playSound('Se/lurebroken.mp3');
    //   }
    // }

    //光点表示位置設定
    if (!settings.flgControlRight) {
      _lightSpotX = size.width * (2 / 3);
    } else {
      _lightSpotX = size.width * (1 / 3);
    }
    // _lightSpotY =
    //     ((_depth / _maxDepth) * (size.height - _shoreHeight - _bottomHeight));
    _lightSpotY = ((_depth / _maxDepth) *
        (size.height - (_shoreHeight + 50) - _bottomHeight));

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

      //bgm.soundManagerPool.playSound('Se/jingle01.mp3');
      //釣りあげ時のモーダル
      _timer.cancel(); //定周期タイマ停止
      bgmStop();
      subBgmPlay('Se/jingle01.mp3');
      var result = await showDialog<int>(
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
      //モーダル閉じた時
      _depth = 0.0;
      _tension = 0.0;
      //ポイントを加算
      _point += point;

      startTimer(); //定周期タイマ再開
      //subBgmStop();
      bgmPlay(Fishing.screenBgm);
    }

    //光点点滅速度関連の変数
    final durationMax = POINT_DURATION_MSEC[POINT_DURATION_MSEC.length - 1]!;
    final durationMin = POINT_DURATION_MSEC[0]!;
    var duration = POINT_DURATION_MSEC[_nowDurationLv]!;

    if (!(_flgBait || _flgHit || _collect)) {
      var flgFall = false;
      var flgMaki = false;
      var flgJerk = false;
      //アタリ中でない時はアワセ判定値をリセット
      _fookingTension = 0.0;
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
        if (hitTanaProb < 0.3) {
          hitTanaProb = 0.3; //棚範囲外の最低保証
        }

        //現在底付近か？
        var bottom = (_depth > (_maxDepth * 0.8)) ? true : false;
        // //深さから可能性のある種を抽出
        var fishs = FISH_TABLE.extractDepth(
            depth: _depth, maxDepth: _maxDepth, bottom: bottom);

        var maxProb = 0.0;
        _listSpeedRange = []; //速度リスト初期化
        duration = durationMax;

        //種毎の判定
        fishs.forEach((fish) {
          var hitSpeedprob = 0.0;
          var hitSpeedprobDisp = 0.0;
          var hitProb = 0.0;

          // //棚による大きさ補正値
          // var tanawari =
          //     (_maxDepth - fish.tanaMin) / (fish.tanaMax - fish.tanaMin);
          // tanawari = (tanawari < 0.1) ? 0.1 : tanawari;
          // tanawari = (tanawari > 0.9) ? 1.0 : tanawari;
          // //大きさ決定
          // var fishSize = (new math.Random()).nextDouble() * tanawari;
          var fishSize = (new math.Random()).nextDouble();
          //使用中ルアーサイズと魚大きさによる確率 魚サイズの1/4が適正値
          var lureProb = 0.0;
          if (lureData.size * 4 > fish.getSize(fishSize)) {
            lureProb = (lureData.size * 4) / fish.getSize(fishSize);
          } else {
            lureProb = fish.getSize(fishSize) / (lureData.size * 4);
          }
          var jiaiProb = 0.0;
          if (flgFall) {
            //フォール中のHIT率判定 魚のフォール志向 * ルアーのフォール能力
            hitSpeedprob = fish.hitFall * lureData.fall;
            hitSpeedprobDisp = 0.0; //フォール中は巻き速度手本を見せない
            //フォールは時合の影響を半分にする
            jiaiProb = (1.0 + _jiai) / 2;
            //HIT確率の算出 フォールは時合の影響を半分にする
            // hitProb = (hitTanaProb * hitSpeedprob * ((1.0 + _jiai) / 2)) *
            //     fish.wariai /
            //     100;
          } else if (flgJerk) {
            //ジャーク中のHIT率判定 魚のジャーク志向 * ルアーのジャーク能力
            hitSpeedprob = fish.hitJerk * lureData.jerk;
            hitSpeedprobDisp = 0.0; //ジャーク中は巻き速度手本を見せない
            //ジャークは時合の影響を1/3にする
            jiaiProb = (2.0 + _jiai) / 3;
            // //HIT確率の算出 ジャークは時合の影響を半分にする
            // hitProb = (hitTanaProb * hitSpeedprob * ((1.0 + _jiai) / 2)) *
            //     fish.wariai /
            //     100;

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
                  lureData.reeling;
            }
            if (hitSpeedprob < 0.01) {
              hitSpeedprob = 0.01; //速度範囲外の最低保証
            }
            hitSpeedprobDisp = hitSpeedprob;
            jiaiProb = _jiai;
          }
          //HIT確率の算出
          hitProb = (hitTanaProb * hitSpeedprob * jiaiProb * lureProb) *
              fish.wariai /
              100;

          if (hitSpeedprob < 0.01) {
            debugPrint(hitSpeedprob.toString());
            debugPrint(fish.id.toString());
          }
          //全魚種で最も高い確率の取得
          if (hitTanaProb * hitSpeedprob > maxProb) {
            maxProb = hitTanaProb * hitSpeedprob * jiaiProb * fish.wariai;
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

            _fishSize = fishSize;

            if (flgFall) {
              //フォール中のみアワセ時間を倍にする
              _baitCnt -= fish.baitCntMax;
            } else {
              _baitCnt = 0;
            }
            _hitScanCnt = fish.hp + (fish.hp * _fishSize).floor();

            _abareLv = 0;
            //フッキング判定テンション
            _fookingTension = _tension + fish.fookingTension;
            _fookingTension = (_fookingTension > _tensionValMax
                ? _tensionValMax
                : _fookingTension);
            //アタリと判定
            _flgBait = true;
            //_baitMaxTension = 0.0;
            debugPrint("アタリ");
            //_dispInfo = 'アタリ';
            _infoBackColor = TENSION_COLOR_DANGER;

            bgm.soundManagerPool.playSound('Se/bait.mp3');
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
        debugPrint(_fookingTension.toString());

        //アタリ中の処理
        if (_tension > _fookingTension) {
          //バイト中の最大テンションが一定値を超えるとHIT
          _flgBait = false;
          _flgHit = true;
          //_fookingTension = 0.0;
          debugPrint('HIT!!!!');
          //_dispInfo = "HIT!";
          //フッキングの成功度
          _fookingLv = (_tension - _fookingTension) / 2;
          if (_fookingLv > 100.0) _fookingLv = 100.0;
          //フッキング成功度によってバレ判定値に補正
          _fookingTension -= _fookingLv;
          _fookingTension = _fookingTension < 20 ? 20 : _fookingTension;
          //HITメッセージ
          _centerTextMain = "HIT!";
          _centerTextMainColor = Colors.red;
          _centerTextSub = "アワセLv " + _fookingLv.floor().toString();
          _centerTextSubColor = Colors.yellow;
          startCenterInfo();

          bgm.soundManagerPool.playSound('Se/hit.mp3');
          bgmPlay('bgm_fight.mp3');
        } else {
          //当たってからのスキャン数加算
          _baitCnt++;
          if (_baitCnt > fish.baitCntMax) {
            //アタリ判定期間終了
            //アワセ失敗
            _flgBait = false;
          }
          //アタリ中
          // if (_tension > _baitMaxTension) {
          //   //バイト中の最大テンションを記憶
          //   //_baitMaxTension = _tension;
          // }
          _pointerColor = clsColor._getColorFromHex("FF6A00"); //アタリ中はオレンジ
          //点滅速度最大
          duration = durationMin;
        }
      } else {
        if (_flgHit) {
          //HIT中の処理
          _pointerColor = clsColor._getColorFromHex("ff0000"); //HIT中は赤固定表示

          //テンションから点滅速度を算出
          duration = durationMax -
              ((durationMax - durationMin) * (_tension / _tensionValMax))
                  .floor();

          //バレ値 時間経過で徐々にバレる
          _fookingTension += 0.1;
          //バレ判定 水深MAXか、テンションがアワセ値未満で条件成立
          if (_depth >= _maxDepth || val < _fookingTension) {
            //_bareCnt++;
            _fookingTension += 5;
          } else {
            //_bareCnt = 0;
          }
          //if (_bareCnt >= fish.bareMin + _fookingLv.floor()) {
          if (_fookingTension > _tensionValMax) {
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

            bgmPlay(Fishing.screenBgm);
            _bareCnt = 0;
          }
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

    //沖合何kmを計算
    offShore = _maxDepth * 7 / 1000;

    var tanarnd = (new math.Random()).nextDouble();
    //棚を示す光点の表示
    var hannornd = (new math.Random()).nextDouble();
    if (hannornd > 0.96 && _jiai > tanarnd) {
      var fishy = _sonarTop + (sonarHeight * _justTana);
      //レンジ分バラケ
      var barakeLevel = 4; //バラケ度
      var barake = (_justTanaRange * ((0.5 - tanarnd) * barakeLevel));
      fishy = fishy + barake;
      fishy = (fishy < _shoreHeight) ? _shoreHeight : fishy;
      fishy = (fishy > _shoreHeight + sonarHeight)
          ? _shoreHeight + sonarHeight
          : fishy;
      generateFishPointer(fishy, 20.0);
    }

    //タックルの描画
    if (!settings.flgControlRight) {
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
  Widget buildChildWidget(BuildContext context) {
    // <-- 通常のbuildメソッドの代わりに実装
    //画面サイズ取得用
    final Size size = MediaQuery.of(context).size;
    return Material(
        child: Scaffold(
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
              backgroundColor:
                  clsColor._getColorFromHex("FFFFFF").withOpacity(0.1),
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
                      _timer.cancel(); //定周期タイマ停止
                      bgmPause();
                      subBgmLoop('Bgm/bgm_book.mp3');
                      // //図鑑モーダルの表示
                      bgm.soundManagerPool.playSound('Se/book.mp3');
                      var result = await showDialog<int>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return BookDialog(
                            fishsTable: FISH_TABLE,
                            fishesResult: fishesResult,
                            soundManagerPool: bgm.soundManagerPool,
                          );
                        },
                      );
                      bgm.soundManagerPool.playSound('Se/bookclose.mp3');
                      startTimer(); //定周期タイマ再開
                      subBgmStop();
                      bgmResume();

//                  debugPrint(result.toString());
                      setState(() {});
                    },
                  ),
                ],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('沖合' + offShore.toStringAsFixed(1) + 'km'),
                ],
              ),
              //右（複数可）
              actions: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            Text(
                              _point.toString() + "ポイント",
                            ),
                          ]),
                      onPressed: () async {
                        //買い物モーダルの表示
                        _timer.cancel(); //定周期タイマ停止
                        bgmPause();
                        subBgmLoop('Bgm/bgm_book.mp3');
                        bgm.soundManagerPool.playSound('Se/book.mp3'); //音は仮
                        int? result = await showDialog<int>(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return ShopDialog(
                              haveTakcle: haveTackle,
                              soundManagerPool: bgm.soundManagerPool,
                              originPoint: _point,
                            );
                          },
                        );
                        _point = result!;
                        bgm.soundManagerPool
                            .playSound('Se/bookclose.mp3'); //音は仮
                        startTimer(); //定周期タイマ再開
                        subBgmStop();
                        bgmResume();
                        setState(() {});
                      },
                    )),
                Container(
                    child: ElevatedButton(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        Text("設定"),
                      ]),
                  onPressed: () async {
                    //買い物モーダルの表示
                    _timer.cancel(); //定周期タイマ停止
                    bgmStop();
                    //subBgmLoop('Bgm/bgm_book.mp3');
                    //bgm.soundManagerPool.playSound('Se/book.mp3'); //音は仮
                    int? result = await showDialog<int>(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return SettingDialog(
                          soundManagerPool: bgm.soundManagerPool,
                          ap: _ap,
                        );
                      },
                    );
                    _point = result!;
                    //bgm.soundManagerPool.playSound('Se/bookclose.mp3'); //音は仮
                    startTimer(); //定周期タイマ再開
                    subBgmStop();
                    bgm.playBgm(name: Fishing.screenBgm); // 遷移先のBGM再生
                    setState(() {});
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
              //automaticallyImplyLeading: true,
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
                  if (_showTacleChangeDialog) {
                    bgm.soundManagerPool.playSound('Se/boxclose.mp3');
                    _showTacleChangeDialog = false;
                  }
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
                  offset = Offset(
                      details.globalPosition.dx, details.globalPosition.dy);
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
                  var addVal = (moveX / (1000 / 2) * _speedValMax);
                  var val = _speed + addVal;
                  if (val > _speedValMax) val = _speedValMax;
                  if (val < SPEED_VAL_MIN) val = SPEED_VAL_MIN;
                  _speed = val;
                  //アワセ値
                  addVal = (moveY / 100);
                  //シャクリ音（小）
                  if (addVal > 0.2) {
                    bgm.soundManagerPool.playSound('Se/lowjerk.mp3');
                  } else if (addVal > 0.5) {
                    bgm.soundManagerPool.playSound('Se/middlejerk.mp3');
                  }
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
                child: Container(
                    //key: globalKeyShore,
                    //margin: EdgeInsets.only(bottom: 50),
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
                        0.3,
                      ],
                    )),
                    child: new Stack(children: <Widget>[
                      if (getImageTeibou)
                        Stack(
                          children: [
                            Container(
                              //margin: EdgeInsets.only(top: _shoreHeight),
                              width: double.infinity,
                              height: double.infinity,
                              child: CustomPaint(
                                painter: new imagePainter(
                                    dispSize: size,
                                    //imagePath: 'assets/Images/teibou.png',
                                    image: imageTeibou,
                                    top: _shoreHeight + 10,
                                    left: imageTeibou.width - (_maxDepth * 10),
                                    width: size.width,
                                    height: imageTeibou.height.toDouble() * 2),
                              ),
                            ),
                          ],
                        ),
                      Column(children: <Widget>[
                        //海上
                        Container(
                          key: globalKeyShore,
                          //margin: EdgeInsets.only(bottom: 50),
                          // decoration: BoxDecoration(
                          //     gradient: LinearGradient(
                          //   begin: FractionalOffset.topCenter,
                          //   end: FractionalOffset.bottomCenter,
                          //   colors: [
                          //     clsColor._getColorFromHex("5495FF"),
                          //     clsColor._getColorFromHex("EFFAFF")
                          //   ],
                          //   stops: const [
                          //     0.0,
                          //     1.0,
                          //   ],
                          // )),
                          child: Column(children: <Widget>[
                            Container(
                                //appBarは透過なのでその分の高さを加算
                                margin:
                                    EdgeInsets.only(top: _appBarHeight + 10),
                                height: 40,
                                //テンションとドラグレベルのスライダーをstackで重ねて表示
                                child: new Stack(children: <Widget>[
                                  // //テンションスライダー
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      //color: Colors.white,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Text("TENSION/DRAG"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                new Image(
                                                  image: AssetImage(
                                                      'assets/Images/TENSIONDRAG.png'),
                                                ),
                                              ],
                                            ),
                                            new Stack(children: <Widget>[
                                              CustomPaint(
                                                painter: new SliderPainter(
                                                  height: 20,
                                                  activeColor:
                                                      _tensionActiveTrackColor,
                                                  inactiveColor: (_flgHit)
                                                      ? Colors.black
                                                      : Colors.white,
                                                  value: _tension,
                                                  maxValue: _tensionValMax,
                                                  backRadius:
                                                      _animationRadius.value,
                                                  maxBackRadius:
                                                      POINTER_BACK_SIZE,
                                                  flgShaKe: (_flgBait ||
                                                          (_tension > _drag))
                                                      ? true
                                                      : false,
                                                  flgDispValue: true,
                                                  flgDispMaxValue: true,
                                                  value2: _fookingTension,
                                                  value2Color: Colors.black
                                                      .withOpacity(0.3),
                                                ),
                                                child: Container(),
                                              ),
                                              // Container(
                                              //   margin:
                                              //       EdgeInsets.only(left: 10 + 400),
                                              //   child: new Image(
                                              //     image: AssetImage(
                                              //         'assets/Images/denryu.gif'),
                                              //     height: 30,
                                              //   ),
                                              // ),
                                            ]),
                                          ])),
                                  //ドラグスライダー
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    height: 40,
                                    child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          //trackHeight: 1, //全体の縦長
                                          valueIndicatorColor: Colors.black
                                              .withOpacity(0.0), //背景の色
                                          activeTrackColor: Colors.black
                                              .withOpacity(0.0), //値有りエリアの色
                                          inactiveTrackColor: Colors.black
                                              .withOpacity(0.0), //値無しエリアの色
                                          activeTickMarkColor: Colors.black
                                              .withOpacity(0.0), //各value値の色
                                          thumbColor: Colors.red
                                              .withOpacity(0.5), //値ツマミの色
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 10), //ツマミの大きさ
                                          overlayColor: Colors.black
                                              .withOpacity(0.0), //値ツマミフォーカス時の色
                                        ),
                                        child: Slider(
                                          value: _drag,
                                          //MAX-MINはテンションと同じ
                                          min: TENSION_VAL_MIN,
                                          max: _tensionValMax,
                                          divisions:
                                              (_tensionValMax - TENSION_VAL_MIN)
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
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5),
                                height: 5,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CustomPaint(
                                        painter: new SliderPainter(
                                          height: 5,
                                          activeColor: clsColor
                                              ._getColorFromHex("FF3030"),
                                          inactiveColor: Colors.white,
                                          value: _nowLineHp,
                                          maxValue: _maxLineHp,
                                          backRadius: 0,
                                          maxBackRadius: 0,
                                          flgShaKe: false,
                                          flgDispValue: false,
                                          flgDispMaxValue: false,
                                        ),
                                        child: Container(),
                                      ),
                                    ])),

                            //巻速度スライダー
                            Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                height: 50,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //Text("SPEED"),
                                      new Image(
                                        image: AssetImage(
                                            'assets/Images/SPEED.png'),
                                      ),
                                      CustomPaint(
                                        painter: new SliderPainter(
                                          height: 20,
                                          activeColor: _speedActiveTrackColor,
                                          inactiveColor: Colors.white,
                                          value: _speed,
                                          maxValue: _speedValMax,
                                          backRadius: 0,
                                          maxBackRadius: 0,
                                          flgShaKe: false,
                                          flgDispValue: true,
                                          flgDispMaxValue: true,
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
                                          maxSpeed: _speedValMax,
                                          speedRange: _listSpeedRange,
                                        ),
                                        child: Container(),
                                      )
                                    ])),
                          ]),
                        ),
                        //海中
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 50),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: clsColor
                                            ._getColorFromHex("02D5F2")),
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
                                      stops: [
                                        0.0,
                                        _dispDepthLv1,
                                        _dispDepthLv2,
                                        1.0
                                      ],
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
                                        ),
                                        //ジャーク時のテキスト
                                        if (_jerkTextAnimationController
                                            .isAnimating)
                                          Container(
                                            //width: 30,
                                            margin: EdgeInsets.only(
                                                top: _lightSpotY -
                                                    ((_lightSpotY < 18.0)
                                                        ? _lightSpotY
                                                        : (18.0 +
                                                            _jerkTextLocation
                                                                .value)),
                                                left: _lightSpotX +
                                                    (10.0 *
                                                        _jerkTextLocation
                                                            .value)),
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
                                                activeColor: clsColor
                                                    .getRaitoColor(_hitScanCnt /
                                                        (FISH_TABLE
                                                                .fishs[_fishidx]
                                                                .hp +
                                                            (FISH_TABLE
                                                                    .fishs[
                                                                        _fishidx]
                                                                    .hp *
                                                                _fishSize))),
                                                inactiveColor: Colors.white,
                                                value: _hitScanCnt.toDouble(),
                                                maxValue: (FISH_TABLE
                                                        .fishs[_fishidx].hp +
                                                    (FISH_TABLE.fishs[_fishidx]
                                                            .hp *
                                                        _fishSize)),
                                                backRadius: 0,
                                                maxBackRadius: 0,
                                                flgShaKe: false,
                                                flgDispValue: false,
                                                flgDispMaxValue: false,
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
                                      child: (settings.flgControlRight)
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
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.red,
                                                    width: 3),
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
                                      child: (!settings.flgControlRight)
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: _shoreHeight +
                                      20 -
                                      //(math.sin(
                                      // waveController.value * 0.5 * math.pi)),

                                      ((waveController.value < 0.5)
                                          ? 7 * waveController.value * 2
                                          : (7 *
                                                  (waveController.value - 0.5) *
                                                  -2) +
                                              7),
                                  //left: math.sin(waveController.value * math.pi)
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {});
                                  },
                                  //船の描画
                                  child: Transform.rotate(
                                    //angle: 45 * math.pi / 180,
                                    angle: (405 - (90 * _shipMove)) *
                                        math.pi /
                                        180,
                                    child: new Image(
                                      image:
                                          AssetImage('assets/Images/ship.png'),
                                      width: 60,
                                      height: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        Container(
                            height: 40,
                            margin: EdgeInsets.only(
                              top: (_shoreHeight + 10),
                            ),
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
                                margin: EdgeInsets.only(
                                    top: _shoreHeight, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      //タップ開始
                                      onTapDown: (details) {
                                        bgm.soundManagerPool
                                            .playSound('Se/engineon.mp3');
                                        _shipMoveSeScan = 0;
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
                                            'assets/Images/arrow_left.png'),
                                        height: 30,
                                      ),
                                    ),
                                    GestureDetector(
                                      //タップ開始
                                      onTapDown: (details) {
                                        bgm.soundManagerPool
                                            .playSound('Se/engineon.mp3');
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
                                            'assets/Images/arrow_right.png'),
                                        height: 30,
                                      ),
                                    ),
                                  ],
                                ))),
                        //]),

                        //ソナー光点
                        Container(
                          width: size.width,
                          margin: EdgeInsets.only(
                              top: _shoreHeight + 50 + _lightSpotY,
                              left: _lightSpotX),
                          child: CustomPaint(
                            painter: LightSpot(POINTER_SIZE, POINTER_BACK_SIZE,
                                _animationRadius.value, _pointerColor, 0, 0),
                          ),
                        ),
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
                            takclePositionRight: settings.flgControlRight,
                            tackleCenterX: _tackleCenterX,
                            rodSizeX: _rodSizeX,
                            rodSizeY: _rodSizeY,
                            reelSizeX: _reelSizeX,
                            reelSizeY: _reelSizeY,
                            reelCenterY: _reelCenterY,
                            clutchBackColor:
                                (_onClutch ? Colors.lightBlue : Colors.red),
                            rodStandUp: _rodStandUp,
                            rodTension: _tension / _tensionValMax,
                            clutchTextSize: (_onClutch
                                ? 0.0
                                : 20 * (_clutchAnime.value + 3.0) / 4),
                            handleRoll: _handleRoll,
                          ),
                        ),
                        if (_centerTextAnimationController.isAnimating)
                          Container(
                              margin: EdgeInsets.only(
                                  left: _centerTextLeft.value,
                                  top: size.height / 2),
                              child: Column(
                                children: [
                                  Text(
                                    _centerTextMain,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: _centerTextMainColor
                                            .withOpacity(0.8),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 100,
                                        fontFamily: 'OpenSans',
                                        fontStyle: FontStyle.italic,
                                        shadows: <Shadow>[
                                          Shadow(
                                              offset: Offset(5.0, 10.0),
                                              blurRadius: 2.0,
                                              color:
                                                  Colors.black.withOpacity(0.8))
                                        ]),
                                  ),
                                  Text(
                                    _centerTextSub,
                                    style: TextStyle(
                                        color: _centerTextSubColor
                                            .withOpacity(0.8),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                        fontFamily: 'OpenSans',
                                        fontStyle: FontStyle.italic,
                                        shadows: <Shadow>[
                                          Shadow(
                                              offset: Offset(5.0, 10.0),
                                              blurRadius: 2.0,
                                              color:
                                                  Colors.black.withOpacity(0.8))
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
                                      top: _shoreHeight +
                                          50 +
                                          (5 * _commonAnime.value),
                                      left: 10),
                                  //height: 180,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // //竿
                                      // GestureDetector(
                                      //     onTap: () async {
                                      //       if (_depth <= 0.0) {
                                      //         setState(() {
                                      //           _selectTacleIcon = 'rod';
                                      //           _showTacleChangeDialog = true;
                                      //           bgm.soundManagerPool
                                      //               .playSound('Se/boxopen.mp3');
                                      //         });
                                      //       }
                                      //     },
                                      //     child: tackleIcon(
                                      //       tackleIconSize: 40.0,
                                      //       imagePath: 'assets/Images/' +
                                      //           haveTackle.getUseRod().image,
                                      //       flgSelect: false,
                                      //       opacity: (_depth > 0.0 ? 0.7 : 1.0),
                                      //     )),
                                      // //リール
                                      // GestureDetector(
                                      //     onTap: () async {
                                      //       if (_depth <= 0.0) {
                                      //         setState(() {
                                      //           _selectTacleIcon = 'reel';
                                      //           _showTacleChangeDialog = true;
                                      //           bgm.soundManagerPool
                                      //               .playSound('Se/boxopen.mp3');
                                      //         });
                                      //       }
                                      //     },
                                      //     child: tackleIcon(
                                      //       tackleIconSize: 40.0,
                                      //       imagePath: 'assets/Images/reel.png',
                                      //       flgSelect: false,
                                      //       opacity: (_depth > 0.0 ? 0.7 : 1.0),
                                      //     )),
                                      //ルアー
                                      GestureDetector(
                                          onTap: () async {
                                            if (_depth <= 0.0) {
                                              setState(() {
                                                _selectTacleIcon = 'lure';
                                                _showTacleChangeDialog = true;
                                                bgm.soundManagerPool.playSound(
                                                    'Se/boxopen.mp3');
                                              });
                                            }
                                          },
                                          child: tackleIcon(
                                            tackleIconSize: 40.0,
                                            imagePath: 'assets/Images/' +
                                                lures
                                                    .getLureData(haveTackle
                                                        .getUseLure()
                                                        .lureId)
                                                    .image,
                                            flgSelect: false,
                                            opacity: (_depth > 0.0 ? 0.7 : 1.0),
                                            subText: lures
                                                    .getLureData(haveTackle
                                                        .getUseLure()
                                                        .lureId)
                                                    .weight
                                                    .toString() +
                                                'g',
                                            // hp: haveTackle.getUseLure().lureHp,
                                            // maxHp: lures
                                            //     .getLureData(haveTackle
                                            //         .getUseLure()
                                            //         .lureId)
                                            //     .hp
                                          )),
                                    ],
                                  ),
                                ),
                                //回収ボタン デザインは仮だから
                                AnimatedOpacity(
                                  opacity: _depth > 0.0 && !_flgBait && !_flgHit
                                      ? 1.0
                                      : 0.0,
                                  duration: Duration(milliseconds: 200),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: _shoreHeight + 70, right: 10),
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
                                      color: Colors.black.withOpacity(0.3),
                                      width: 1)),
                              //title: Text("タックル変更"),
                              child: Visibility(
                                  visible: _showTacleChangeDialog,
                                  child: Container(
                                    color: Colors.black.withOpacity(0.3),
                                    child: Column(children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "使用中のタックル",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  fontFamily: 'OpenSans',
                                                  decoration:
                                                      TextDecoration.none,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                        offset:
                                                            Offset(1.0, 3.0),
                                                        blurRadius: 2.0,
                                                        color: Colors.black
                                                            .withOpacity(0.8))
                                                  ]),
                                            )
                                          ]),
                                      Container(
                                        //margin: EdgeInsets.only(top: 4, bottom: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                        'assets/Images/' +
                                                            haveTackle
                                                                .getUseRod()
                                                                .image,
                                                    flgSelect:
                                                        _selectTacleIcon ==
                                                                'rod'
                                                            ? true
                                                            : false,
                                                    opacity: (_depth > 0.0
                                                        ? 0.7
                                                        : 1.0),
                                                  )),
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
                                                        'assets/Images/reel.png',
                                                    flgSelect:
                                                        _selectTacleIcon ==
                                                                'reel'
                                                            ? true
                                                            : false,
                                                    opacity: (_depth > 0.0
                                                        ? 0.7
                                                        : 1.0),
                                                  )),
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
                                                    imagePath: 'assets/Images/' +
                                                        lures
                                                            .getLureData(
                                                                haveTackle
                                                                    .getUseLure()
                                                                    .lureId)
                                                            .image,
                                                    flgSelect:
                                                        _selectTacleIcon ==
                                                                'lure'
                                                            ? true
                                                            : false,
                                                    opacity: (_depth > 0.0
                                                        ? 0.7
                                                        : 1.0),
                                                    subText: lures
                                                            .getLureData(
                                                                haveTackle
                                                                    .getUseLure()
                                                                    .lureId)
                                                            .weight
                                                            .toString() +
                                                        'g',
                                                    // hp: haveTackle
                                                    //     .getUseLure()
                                                    //     .lureHp,
                                                    // maxHp: lures
                                                    //     .getLureData(haveTackle
                                                    //         .getUseLure()
                                                    //         .lureId)
                                                    //     .hp
                                                  )),
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
                                        margin:
                                            EdgeInsets.only(top: 4, bottom: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                width: size.width - 60,
                                                height: 60,
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Row(children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            //タックル替え
                                                            haveTackle.changeLure(
                                                                haveTackle
                                                                    .haveLures[
                                                                        index]
                                                                    .id);
                                                          });
                                                        },
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: tackleIcon(
                                                              tackleIconSize:
                                                                  40.0,
                                                              imagePath: 'assets/Images/' +
                                                                  lures
                                                                      .getLureData(haveTackle
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
                                                              opacity:
                                                                  (_depth > 0.0
                                                                      ? 0.7
                                                                      : 1.0),
                                                              subText: lures
                                                                      .getLureData(haveTackle
                                                                          .haveLures[
                                                                              index]
                                                                          .lureId)
                                                                      .weight
                                                                      .toString() +
                                                                  'g',
                                                              //hp: haveTackle.haveLures[index].lureHp,
                                                              //maxHp: lures.getLureData(haveTackle.haveLures[index].lureId).hp
                                                            )),
                                                      ),
                                                    ]);
                                                  },
                                                  itemCount: haveTackle
                                                      .haveLures.length,
                                                ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          lures
                                              .getLureData(haveTackle
                                                  .getUseLure()
                                                  .lureId)
                                              .name,
                                          style: TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //ステータス
                                            new RadarChart(
                                              key: UniqueKey(),
                                              items: getLureRadarChartItem(),
                                              borderColor: Colors.white,
                                              radarColors: [Colors.orange],
                                              fontColor: Colors.white,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
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
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        lures
                                                                .getLureData(
                                                                    haveTackle
                                                                        .getUseLure()
                                                                        .lureId)
                                                                .weight
                                                                .toString() +
                                                            'g',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                                              color:
                                                                  Colors.black,
                                                              width: 3),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          7.0)),
                                                          color: clsColor
                                                              ._getColorFromHex(
                                                                  '#DFDFDF')),
                                                      child: Text(
                                                        lures
                                                            .getLureData(
                                                                haveTackle
                                                                    .getUseLure()
                                                                    .lureId)
                                                            .text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
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
                                            primary:
                                                Colors.grey.withOpacity(0.5),
                                            onPrimary: Colors.white,
                                          ),
                                          onPressed: () {
                                            bgm.soundManagerPool
                                                .playSound('Se/boxclose.mp3');
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
                    ])))));
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
    if (settings.flgControlRight) {
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
      takclePositionRight: settings.flgControlRight,
      painterKey: GlobalKey(),
      randMove: (new math.Random()).nextDouble(),
    );
    setState(() {
      fishPointerList.add(fishPointer);
    });
    //_cache.play('Se/kk_sonar_low.mp3');
    //play('assets/Se/kk_sonar_low.mp3');
    if (!_flgHit) bgm.soundManagerPool.playSound('Se/kk_sonar_low.mp3');
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
      if (_depth <= 0.0) {
        //着水音
        bgm.soundManagerPool.playSound('Se/waterlanding.mp3');
      } else {
        bgm.soundManagerPool.playSound('Se/clutch.mp3');
      }
    } else {
      _clutchBackColor = Colors.red;
      bgm.soundManagerPool.playSound('Se/clutch.mp3');
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

              // ElevatedButton(
              //     child: const Text('持替'),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.amber, //背景色
              //       onPrimary: Colors.black, //押したときの色
              //       shape: const StadiumBorder(),
              //       side: BorderSide(
              //         color: Colors.black, //枠線の色
              //         width: 2, //枠線の太さ
              //       ),
              //     ),
              //     onPressed: () {
              //       if (_takclePositionLeft) {
              //         _takclePositionLeft = false;
              //       } else {
              //         _takclePositionLeft = true;
              //       }
              //     }),
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

  //ルアーの能力チャート描画
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

  //0.0～1.0のアニメーション値を倍々にする
  double animeHosei(double val, int multiple) {
    //return val / (1.0 / multiple);
    var v = val % (1.0 / multiple);
    //return (1 / multiple) * math.sin(4 * v);
    return v;
  }
}

//タックルサムネの表示
Widget tackleIcon({
  required double tackleIconSize,
  required String imagePath,
  required bool flgSelect,
  String subText = '',
  int hp = 0,
  int maxHp = 0,
  double opacity = 1.0,
}) {
  //final value = hp / maxHp;
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
                Colors.black.withOpacity(opacity), BlendMode.dstATop),
            fit: BoxFit.contain),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subText,
            style: TextStyle(fontSize: 12),
          ),
          Visibility(
            visible: (maxHp > 0),
            child: Container(
              margin: EdgeInsets.all(3),
              child: CustomPaint(
                painter: new SliderPainter(
                  height: 4,
                  activeColor: clsColor.getRaitoColor(hp / maxHp),
                  inactiveColor: Colors.white,
                  value: hp.toDouble(),
                  maxValue: maxHp.toDouble(),
                  backRadius: 0,
                  maxBackRadius: 0,
                  flgShaKe: false,
                  flgDispValue: false,
                  flgDispMaxValue: false,
                ),
                child: Container(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
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

  //割合によって色を返す
  static Color getRaitoColor(double raito) {
    if (raito > 0.7) return Colors.green;
    if (raito > 0.3) return Colors.amber;
    return Colors.red;
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
