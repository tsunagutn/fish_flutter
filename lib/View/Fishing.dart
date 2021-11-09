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
//・海面の波
//・船押して船長呼び出しの機能 深いとこ／浅いとこ行って欲しい機能
//・船長呼び出しボタン→子メニュー（ポップアップ？横メニュー？）で選択→船長絵「わかった」
//・ポイントで色々　道具買ったり、糸替え、船長指示、ゲームオーバーから復活とか
//・ドラグが出てる時はどっか揺らすみたいな
//・糸のHPシステム？糸切れ値でぷっつり行くのが何か変
//・テンションバーのデザインが変
//・テンションバー 危ないときアニメーション光るようにする
//・テンションとスピードバーのデザインを整備 スライダーじゃなくする？
//・ソナーに反応光点描画にする。
//・ソナーの0m地点に水面とか船の画像。
//・HIT時につっこみモード、おとなしいモードつけて勢い度
//・糸切れ判定 勢い度を加味して切れるようにする
//・魚種毎にいい棚の設定
//・魚種毎にいい速度の設定
//・魚種毎にバレ条件の設定
//・画面左に竿リール表示、上下ドラッグで動かす、ジグのシャクリ
//・アワセシステム ARVRモード時はスマホをジャイロで動かす、通常時は下にドラッグでアワセ
//  アワセの上手くいきかたで初期バラシレベルが決まるみたいな
//・背景にAR的なカメラ映像（カメラ無いときはアニメーション）
//・背景にrod、ジャイロで動かす
//・アワセシステム
//・魚種データをDB化して登録画面実装
//・エリア選択 エリアによって魚種、深さ等変える

import 'package:fish_flutter/Model/LightSpot.dart';
import 'package:fish_flutter/Model/TapPointer.dart';
import 'package:fish_flutter/Model/FishPointer.dart';
import 'package:fish_flutter/Model/WaveClipper.dart';
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

  //魚種定義 wariaiの合計値は10にすること
  final Map<int, Map<String, dynamic>> FISH_TABLE = {
    0: {
      'name': "アジ", //魚種名
      'image': "aji.jpg", //超過画面の画像
      'text': "あなたは幸せを感じました", //釣果画面のコメント
      'hp': 1000, //このスキャン経過で0になる
      'add_max': 30, //引きの最大
      'add_min': -10, //引きの最小（最大との乖離が暴れ度）
      'weight': 2, //重さ（HP0時の最低重量、これが無いとバレ判定にひっかかる）
      'wariai': 3, //HIT率
      'point': 100, //ポイントの基礎値
      'tana_min': 0.0,
      'tana_max': 0.5,
    },
    1: {
      'name': "タチウオ",
      'image': "tachiuo.jpg",
      'text': "おおきいぞっ",
      'hp': 250, //このスキャン経過で0になる
      'add_max': 13,
      'add_min': -5,
      'weight': 2, //重さ
      'wariai': 2,
      'point': 200, //ポイントの基礎値
      'tana_min': 0.2,
      'tana_max': 0.6,
    },
    2: {
      'name': "鯉",
      'image': "koi.jpg",
      'text': "うれしいね",
      'hp': 3000, //このスキャン経過で0になる
      'add_max': 10,
      'add_min': -6,
      'weight': 3, //重さ
      'wariai': 2,
      'point': 200, //ポイントの基礎値
      'tana_min': 0.0,
      'tana_max': 0.3,
    },
    3: {
      'name': "マダイ",
      'image': "madai.jpg",
      'text': "あなたは満足を得ました",
      'hp': 1000,
      'add_max': 15,
      'add_min': -6,
      'weight': 3, //重さ
      'wariai': 2,
      'point': 300, //ポイントの基礎値
      'tana_min': 0.5,
      'tana_max': 0.8,
    },
    4: {
      'name': "宮澤クン",
      'image': "sakana.jpg",
      'text': "スー　パー　レア",
      'hp': 5000,
      'add_max': 30,
      'add_min': -10,
      'weight': 4, //重さ
      'wariai': 1,
      'point': 99999, //ポイントの基礎値
      'tana_min': 0.9,
      'tana_max': 1.0,
    },
  };

  //光点の点滅速度
  final Map<int, int> POINT_DURATION_MSEC = {
    0: 100,
    1: 300,
    2: 700,
    3: 1000,
    4: 2000,
  };

  final TIMER_INTERVAL = 50; //1スキャン時間(msec)
  final TENSION_VAL_MAX = 300.0; //テンションスライダーMAX値
  final TENSION_VAL_MIN = 0.0; //テンションスライダーMIN値
  final TENSION_LINECUT = 290.0; //糸切れ判定値
  final SPEED_VAL_MAX = 300.0; //巻き速度スライダーMAX値
  final SPEED_VAL_MIN = 0.0; //巻き速度スライダーMIN値
  final HOSEI_MAX = 3;
  final HIT_JUST_SPEED = 150;
  final HIT_SPEED_RANGE = 80; //+-まではHIT県内
  final BARE_MAX = 20; //バレ判定条件成立からバレ発生までのスキャン数 ？？？魚のでかさによって可変にするべき
  final MAX_RAND_ADD_TENSION = 3; //何もしてない時テンションがウロウロするののMAX値
  final MIN_RAND_ADD_TENSION = -8; //〃 MIN値
  final TENSION_COLOR_SAFE = clsColor._getColorFromHex("4CFF00");
  final TENSION_COLOR_DRAG = clsColor._getColorFromHex("FFD800");
  final TENSION_COLOR_DANGER = clsColor._getColorFromHex("DD0000");
  final SPEED_COLOR = clsColor._getColorFromHex("0094FF");
  final SPEED_COLOR_REELING = clsColor._getColorFromHex("0026FF");
  final TAP_POINTER_DURATION_MSEC = 500; //タップ時のエフェクト 速度
  final TAP_POINTER_MAX_RADIUS = 10.0; //タップ時のエフェクト 最大大きさ
  // final DEPTH_CHANGE_SCAN = 500; //このスキャン毎に深さの変化傾向が変わる
  // final JIAI_CHANGE_SCAN = 1500; //このスキャン毎に時合度が変わる
  final DEPTH_CHANGE_SCAN = 50; //このスキャン毎に深さの変化傾向が変わる
  final JIAI_CHANGE_SCAN = 150; //このスキャン毎に時合度が変わる
  final TANA_CHANGE_SCAN = 300; //このスキャン毎にタナが変わる
  final POINTER_SIZE = 5.0; //ソナー光点の基本サイズ
  final POINTER_BACK_SIZE = 4.0; //ソナー光点後光の最大サイズ

// グローバル変数としてGlobalKey型の変数（プロパティ）を定義
  GlobalKey globalKeySonar = GlobalKey();
  GlobalKey globalKeyShore = GlobalKey();

  //アニメーション関連
  late AnimationController _animationController; //光点の光アニメーション
  late Animation<double> _animationRadius;
  // late AnimationController _tapAnimation; //タップ時の波紋アニメーション
  // late Animation<double> _TapPointerRadius;

  //状態フラグ変数
  var _ontap = false; //現在タップ中フラグ
  var _onclutch = false; //現在クラッチ状態
  var _flg_hit = false; //現在HIT中フラグ
  var _flg_gameover = false; //現在ゲームオーバーフラグ

  //ステート変数
  var _tension = 0.0; //テンション値
  var _drag = 250.0; //ドラグレベル値
  var _speed = 0.0; //巻き速度値
  var _depth = 0.0; //現在糸出し量(0.1m)
  var _max_depth = 187.0; //最大水深(0.1m)
  var _disp_depth = '0.0 m'; //深さ表示用
  var _disp_info = '0.00 %'; //HIT率表示用（デバッグ用）
  var _tension_activeTrackColor =
      clsColor._getColorFromHex("4CFF00"); //テンションゲージの色
  var _speed_activeTrackColor = clsColor._getColorFromHex("0094FF"); //スピードゲージの色
  var _info_backColor = Colors.white; //HIT率表示の背景色（デバッグ用）
  var _clutch_backColor = Colors.red; //クラッチボタンの背景色
  Color _pointer_color = Colors.yellow; //ソナー部光点の色
  var _pointer_y = 0.0; //ソナー部光点TOP
  var _pointer_x = 50.0; //ソナー部光点LEFT
  var _point = 0; //獲得ポイント
  var _just_tana = 0.5; //HIT確率判定 棚
  var _tana_range = 50.0; //0.1m単位 +-まではHIT圏内
  var _tana_change_scan_cnt = 0; //棚変化スキャンカウント数
  var _jiai = 0.5; //時合度 0.0～0.9999...
  var _jiai_change_scan_cnt = 0; //時合度の変化スキャンカウント数

  var _cursorx = 0.0; //ドラッグ操作開始時の座標X

  var _fishidx = 0; //現在HIT中の魚種IDX
  var _hit_scan_cnt = 0; //HITしてからのスキャン数
  var _bare_cnt = 0; //バレ判定カウント

  var _depth_change = 0.5; //深さの変化傾向 1.0～0,0 +なら深くなる、-なら浅くなる
  var _depth_change_scan_cnt = 0; //深さの変化傾向スキャンカウント数

  var _now_duration_lv; //光点点滅レベル
  var _shoreHeight = 0.0;
  late Offset offset = Offset(0.0, 0.0);
  late double _appBarHeight = 0.0;

  late AnimationController waveController; // AnimationControllerの宣言
  static const darkBlue = Color(0xFF264bc5); // 波の色

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
    ligntSpotAnimation(POINT_DURATION_MSEC[_now_duration_lv]!);
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

    if (_flg_gameover) {
      //ゲームオーバー中は無処理
      return;
    }

    num add_val = 0;
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

    //共通乱数 0.0～0.999... の乱数の作成 ※共通じゃだめなところには使っちゃだめ
    var rand = (new math.Random()).nextDouble();

    //深さの変化傾向判定
    _depth_change_scan_cnt++;
    if (_depth_change_scan_cnt > DEPTH_CHANGE_SCAN) {
      _depth_change_scan_cnt = 0;
      _depth_change = 0.5 + ((0.5 - rand) / 10);
      debugPrint("深さ変化傾向" + _depth_change.toString());
    }

    //時合の変化判定
    _jiai_change_scan_cnt++;
    if (_jiai_change_scan_cnt > JIAI_CHANGE_SCAN) {
      _jiai_change_scan_cnt = 0;
      _jiai = (new math.Random()).nextDouble();
      debugPrint("時合度" + _jiai.toString());
    }

    //タナの変化判定
    _tana_change_scan_cnt++;
    if (_tana_change_scan_cnt > TANA_CHANGE_SCAN) {
      _tana_change_scan_cnt = 0;
      _just_tana = (new math.Random()).nextDouble();
      debugPrint("タナ" + _just_tana.toString());
    }

    if (_flg_hit) {
      //debugPrint("HIT中1");
      if (_hit_scan_cnt > 0) {
        _hit_scan_cnt--;
      }
      //テンション増減にHIT中補正をかける
      var fish = FISH_TABLE[_fishidx]!;
      mx += (fish['add_max'] as int) *
          (_hit_scan_cnt / (fish['hp'] as int)).round();
      mn += (fish['add_min'] as int) *
          (_hit_scan_cnt / (fish['hp'] as int)).round();
      weight = fish['weight'];
    }
    add_val = (rand * (mx + 1 - (mn))).floor() + (mn) + weight;

    if (_onclutch) {
      //クラッチON中はマイナス補正を最大化
      add_val = HOSEI_MAX * -1;
      //水深を加算
      _depth++;
    } else {
      if (_ontap) {
        //巻きスピード
        var hosei = (_speed % SPEED_VAL_MAX) % HOSEI_MAX;
        //var hosei = (_speed % SPEED_VAL_MAX);
        //タップ中は補正を加味する
        add_val = add_val + hosei.round();
        //水深減算
        _depth = _depth - _speed / SPEED_VAL_MAX;
      }
    }
    if (add_val > 0) {
      //テンション+時は現在テンションによって補正をかける
      add_val * ((TENSION_VAL_MAX - _tension) / TENSION_VAL_MAX);
      //二次関数 テンション上がるごとに上がりにくくする
      add_val = add_val +
          (add_val * -1) * (MathPow._getPow(2, (_tension / TENSION_VAL_MAX)));
    }
    var val = _tension + add_val;

    //ゲームオーバー判定
    var gameovertext = "";
    //糸切れ判定
    if (val > TENSION_LINECUT) {
      //糸切れ
      debugPrint("いときれ");
      _flg_gameover = true;
      gameovertext = "糸が切れました。\nゲームオーバーです。\nゲームオーバーなのでもう何もできません";
    }
    //座礁判定
    if (_max_depth < 2.0) {
      //座礁
      debugPrint("座礁");
      _flg_gameover = true;
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
    //_tension_activeTrackColor = TENSION_COLOR_SAFE;
    if (val > drag_val) {
      //テンションとドラグレベルの差分
      var drag_diff = val - drag_val;
      //ドラグ出た分深さを増やす
      _depth = _depth + drag_diff / 30;
      //ドラグ出た分テンションを減らす
      val = val - (drag_diff / 25);
      //テンションゲージの色を変える
      _tension_activeTrackColor = TENSION_COLOR_DRAG;
      //audio.currentTime = 0;
      //audio.play();
      //var duration = 200; // 振動時間
      //navigator.vibrate(duration);
    }
    //  else {
    //   //テンションMAX（切れそう）判定 最大値の9割で切れそうと判定
    //   if (val >= (TENSION_VAL_MAX * 0.9)) {
    //     _tension_activeTrackColor = TENSION_COLOR_DANGER;
    //   }
    // }

    if (val > TENSION_VAL_MAX) val = TENSION_VAL_MAX;
    if (val < TENSION_VAL_MIN) val = TENSION_VAL_MIN;

    if (_depth > _max_depth) _depth = _max_depth;
    if (_depth < 0) _depth = 0.0;

    //テンション確定
    _tension = val;

    //テンションによってテンションバーの色を変える
    _tension_activeTrackColor = clsColor._getColorRange(
        TENSION_COLOR_SAFE, TENSION_COLOR_DANGER, _tension, TENSION_VAL_MAX);

    //水深表示
    _disp_depth = ((_depth).round() / 10).toStringAsFixed(1) +
        " / " +
        ((_max_depth).round() / 10).toStringAsFixed(1) +
        ' m';
    _pointer_x = 0;
    _pointer_y = ((_depth / _max_depth) * (size.height - _appBarHeight) * 0.60);
    //_pointer_y += sonarTop + _appBarHeight;
    //debugPrint(_pointer_y.toString());
//         //魚探画像に光点表示
//         $('.point_img').css('margin-top', (point_height * 1.2) + "%");

    //釣り上げ判定
    if (_flg_hit && _depth <= 1) {
      debugPrint("つりあげ");
      //釣りあげ時のモーダル
      var fish = FISH_TABLE[_fishidx]!;
      var result = showDialog<int>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(fish['name'] + "がつれました"),
              content: Column(children: <Widget>[
                new Image(
                  image: AssetImage('assets/images/' + fish['image']),
                  width: 150,
                  height: 150,
                ),
                Text(fish['point'].toString() + 'ポイント獲得です'),
                Text(fish['text']),
              ]),
              actions: <Widget>[
                // ボタン領域
                // FlatButton(
                //   child: Text("Cancel"),
                //   onPressed: () => Navigator.pop(context),
                // ),
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    _point += fish['point'] as int;
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      _flg_hit = false;
    }

    //光点点滅速度関連の変数
    final durationMax = POINT_DURATION_MSEC[POINT_DURATION_MSEC.length - 1]!;
    final durationMin = POINT_DURATION_MSEC[0]!;
    var duration;

    //HIT確率の算出
    if (!_flg_hit) {
      var hit_prob = 0.0;
      //HIT棚との差分
      final just_tana = (_max_depth * _just_tana);
      var tana_diff = (_depth - just_tana).abs();
      //差分が範囲内か
      if (tana_diff < _tana_range) {
        hit_prob = 1.0 * ((tana_diff - _tana_range).abs() / _tana_range);
      }
      if (hit_prob < 0.1) {
        hit_prob = 0.1; //最低でも1割
      }

      //速さが範囲内か
      var hit_speedprob = 0.0;
      //糸出中、かつ水深MAXではない時
      if (_onclutch && _depth < _max_depth) {
        hit_speedprob = 0.2; //フォール中の補正
      } else {
        //ドラグ出中、止めている時、水深1m未満、水深MAXの時は判定しない
        if (_tension_activeTrackColor != TENSION_COLOR_DRAG &&
            _ontap &&
            _depth > 10 &&
            _depth < _max_depth) {
          //HITスピードとの差分
          var speed_diff = (_speed - HIT_JUST_SPEED).abs();
          //差分が範囲内か
          if (speed_diff < HIT_SPEED_RANGE) {
            hit_speedprob =
                1.0 * ((speed_diff - HIT_SPEED_RANGE).abs() / HIT_SPEED_RANGE);
          }
          if (hit_speedprob < 0.1) {
            hit_speedprob = 0.1;
          }
        }
      }
      //HIT確率の算出
      var hitprob = (hit_prob * hit_speedprob) / 100;

      //HIT確率から点滅速度を算出
      duration = durationMax -
          ((durationMax - durationMin) * (hit_prob * hit_speedprob)).floor();

      _disp_info = (hitprob * 100).toStringAsFixed(2) + ' %';
      _info_backColor = Colors.white;

      //HIT率に伴いポインタの色を変える
      _pointer_color = clsColor._getColorFromHex("ffd900"); //？？？とりあえず黄色固定

      //1～0の乱数よりも大きい？
      var hitrnd = (new math.Random()).nextDouble();

      //debugPrint("HIT比較" + (hitprob).toString() + hitrnd.toString());
      if (hitprob > hitrnd) {
        //0以上10未満の乱数
        var rndfish = (new math.Random()).nextInt(9);
        //何が釣れたか判定
        var wariai_add = 0;
        for (var i = 0; i < FISH_TABLE.length; i++) {
          var row = FISH_TABLE[i]!;
          wariai_add += (row['wariai'] as int);
          if (rndfish < wariai_add) {
            //i 番目の魚が釣れた
            _fishidx = i;
            _hit_scan_cnt = row['hp'];
            break;
          }
        }
        //HITと判定
        _flg_hit = true;
        //ligntSpotAnimation(POINT_DURATION_MSEC_FAST); //光点アニメーションを早くする

        //console.log("HIT!!!");
        debugPrint("HIT!!!");
        _disp_info = 'HIT!!!';
        _info_backColor = TENSION_COLOR_DANGER;
      }
    } else {
      //HIT中の処理
      _pointer_color = clsColor._getColorFromHex("ff0000"); //HIT中は赤固定表示

      //テンションから点滅速度を算出
      duration = durationMax -
          ((durationMax - durationMin) * (_tension / TENSION_VAL_MAX)).floor();

      //バレ判定 水深MAXかテンション一定未満で条件成立
      if (_depth >= _max_depth || val <= TENSION_VAL_MIN + 20) {
        _bare_cnt++;
      } else {
        _bare_cnt = 0;
      }
      if (_bare_cnt >= BARE_MAX) {
        //バレ条件成立が一定スキャン保持でバレとする
        debugPrint("バレ");

        _flg_hit = false;
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
    if (new_duration_lv != _now_duration_lv) {
      _now_duration_lv = new_duration_lv;
      ligntSpotAnimation(POINT_DURATION_MSEC[_now_duration_lv] as int);
    }

    //最大深さをランダムで増減
    var depthrnd = (new math.Random()).nextDouble();
    _max_depth += 1 * ((_depth_change) - depthrnd);

    //棚を示す光点の表示
    var hannornd = (new math.Random()).nextDouble();
    if (hannornd > 0.96 && _jiai > depthrnd) {
      var fishy = (sonarTop - _appBarHeight) + (sonarHeight * _just_tana);
      //レンジ分バラケ
      var barake = (_tana_range * ((0.2 - depthrnd) * 1.5));
      barake = (barake < 0) ? 0 : barake;
      barake = (barake > (sonarTop - _appBarHeight) + sonarHeight)
          ? (sonarTop - _appBarHeight) + sonarHeight
          : barake;
      fishy = fishy + (_tana_range * ((0.2 - depthrnd) * 1.5));
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
            //behavior: HitTestBehavior.translucent,
            //子のコントロールタップ時は反応しないようにできないか・・・？
            //画面タップ時
            //onPanDown: (DragDownDetails details) {
            //debugPrint("タップ");
            // chenge_clutch(false);
            // _ontap = true;
            //},
            //タップした時
            // onTapDown: (TapDownDetails details) {
            //   debugPrint("たっぷだうん");
            //   offset = Offset(details.globalPosition.dx,
            //       details.globalPosition.dy - _appBarHeight);
            //   _tapAnimation = AnimationController(
            //       duration: Duration(milliseconds: TAP_POINTER_DURATION_MSEC),
            //       vsync: this);
            //   generateTapPointer(details);
            //   debugPrint(tapPointerList.length.toString());
            // },
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
              _ontap = true;
              //タップ時の画面エフェクト
              offset = Offset(details.globalPosition.dx,
                  details.globalPosition.dy - _appBarHeight);
              generateTapPointer(details);

              //generateFishPointer(100);
              //タップ時はスピードスライダの色替え
              _speed_activeTrackColor = SPEED_COLOR_REELING;
            },
            //ドラッグ操作で位置が変化した時
            onPanUpdate: (DragUpdateDetails details) {
              if (size.isEmpty) {
                return;
              }
              var mX = 0.0;
              if (!_ontap) {
                return;
              }
              //現在のX座標を取得する
              mX = details.localPosition.dx; //X座標
              //初期位置から動いた値を取得
              var movex = mX - _cursorx;
              //x座標記憶を更新
              _cursorx = mX;
              var add_val = (movex / (1000 / 2) * SPEED_VAL_MAX);
              //巻き速度値に加算
              var val = _speed + add_val;
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
              _ontap = false;
              //スピードスライダの色を戻す
              _speed_activeTrackColor = SPEED_COLOR;
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
                        //テンションとドラグレベルのスライダーをstackで重ねて表示
                        child: new Stack(children: <Widget>[
                          //テンションスライダー ？？？描画のみなのでスライダーは不適切かも
                          SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 20, //全体の縦長
                                valueIndicatorColor: Colors.white, //背景の色
                                activeTrackColor:
                                    _tension_activeTrackColor, //値有りエリアの色
                                inactiveTrackColor: Colors.white,
                                activeTickMarkColor:
                                    Colors.black.withOpacity(0.0), //値ツマミの色
                                thumbColor:
                                    Colors.black.withOpacity(0.0), //現在レベルの色
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 0), //値ツマミの径
                                overlayColor: Colors.black
                                    .withOpacity(0.0), //値ツマミフォーカス時の色
                                //inactiveTrackColor: Colors.amber,
                                //inactiveTickMarkColor: Colors.blue,
                              ),
                              child: Slider(
                                value: _tension,
                                min: TENSION_VAL_MIN,
                                max: TENSION_VAL_MAX,
                                divisions:
                                    (TENSION_VAL_MAX - TENSION_VAL_MIN) as int,
                                onChanged: (double value) {
                                  //ユーザが変更するものではないのでコメント
                                  //   setState(() {
                                  //     _tension = value.roundToDouble();
                                  //   });
                                },
                              )),
                          //ドラグスライダー
                          SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 2, //全体の縦長
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
                                    enabledThumbRadius: 12), //ツマミの大きさ
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
                                divisions:
                                    (TENSION_VAL_MAX - TENSION_VAL_MIN) as int,
                                onChanged: (double value) {
                                  setState(() {
                                    _drag = value.roundToDouble();
                                  });
                                },
                              )),
                        ])),

                    //巻速度スライダー
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 20, //全体の縦長
                        valueIndicatorColor: Colors.white, //背景の色
                        activeTrackColor: _speed_activeTrackColor, //値有りエリアの色
                        inactiveTrackColor: Colors.white,
                        activeTickMarkColor:
                            Colors.black.withOpacity(0.0), //値ツマミの色
                        thumbColor: Colors.black.withOpacity(0.0), //現在レベルの色
                        thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 0), //値ツマミの径
                        overlayColor:
                            Colors.black.withOpacity(0.0), //値ツマミフォーカス時の色
                        //inactiveTrackColor: Colors.amber,
                        //inactiveTickMarkColor: Colors.blue,
                      ),
                      child: Slider(
                        value: _speed,
                        //MAX-MINはテンションと同じ
                        min: SPEED_VAL_MIN,
                        max: SPEED_VAL_MAX,
                        divisions: (SPEED_VAL_MAX - SPEED_VAL_MIN) as int,
                        onChanged: (double value) {
                          //画面スワイプで動かす
                        },
                      ),
                    ),
                    Stack(children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            var result = showDialog<int>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("何かや！"),
                                    content: Column(children: <Widget>[
                                      new Image(
                                        image: AssetImage(
                                            'assets/images/sencho.png'),
                                        width: 150,
                                        height: 150,
                                      ),
                                      Text('わしゃあ忙しいんで！'),
                                      //Text('もっと浅く'),
                                    ]),
                                    actions: <Widget>[
                                      // ボタン領域
                                      // FlatButton(
                                      //   child: Text("Cancel"),
                                      //   onPressed: () => Navigator.pop(context),
                                      // ),
                                      FlatButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          //_point += fish['point'] as int;
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
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
                                // ↓ 追加部分
                                // 1
                                ClipPath(
                                  // 3
                                  child: Container(
                                      color: clsColor
                                          ._getColorFromHex("02D5F2")
                                          .withOpacity(1.0)),
                                  // 2
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
                          ],
                          stops: const [
                            0.0,
                            1.0,
                          ],
                        )
                        // ,
                        // // 背景画像
                        // image: DecorationImage(
                        //   image: AssetImage('Assets/Images/sencho.png'),
                        //   fit: BoxFit.cover, //？？？全画面にするときはここ有効化
                        // ),
                        ),
                    // 内側の余白（パディング）
                    //padding: EdgeInsets.all(8),
                    // 外側の余白（マージン）
                    //margin: EdgeInsets.all(8),
                    width: size.width,
                    height: size.height - _appBarHeight - _shoreHeight,
                    child: Column(
                      children: <Widget>[
                        // new Expanded(
                        //     child:

                        //),
                        //ソナー画面
                        Expanded(
                          //描画エリア
                          child: Container(
                            key: globalKeySonar,
                            child: Stack(children: <Widget>[
                              //ソナー光点
                              Container(
                                margin: EdgeInsets.only(
                                    top: _pointer_y, left: _pointer_x),
                                child: CustomPaint(
                                  painter: LightSpot(
                                      POINTER_SIZE,
                                      POINTER_BACK_SIZE,
                                      _animationRadius.value,
                                      _pointer_color,
                                      0,
                                      0),
                                ),
                              ),
                            ]),
                          ),
                        ),
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
                                              primary: _clutch_backColor, //背景色
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
                                              if (!_onclutch) {
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
                                          child: Text(_disp_depth,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              )),
                                        ),
                                        // Text(_disp_info,
                                        //     style: TextStyle(
                                        //       backgroundColor: _info_backColor,
                                        //     )),
                                      ],
                                    ),
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
    if (flg == _onclutch) {
      //状態変更無し時は無処理
      return;
    }
    if (flg) {
      //クラッチOFF→ONに変更
      _clutch_backColor = Colors.lightBlue;
    } else {
      _clutch_backColor = Colors.red;
    }
    _onclutch = flg;
  }

  void ligntSpotAnimation(int duration_msec) {
    //アニメーションの定義
    _animationController = AnimationController(
        duration: Duration(milliseconds: duration_msec), vsync: this);
    _animationRadius =
        Tween(begin: 0.0, end: POINTER_BACK_SIZE).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.repeat(reverse: false);
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
