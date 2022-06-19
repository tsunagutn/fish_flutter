import 'dart:async';

import 'package:fish_flutter/widget/BgmPlayer.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import '../Main.dart';
import 'dart:math' as math;

abstract class BasePageState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver, RouteAware {
  late BgmPlayer _bgm;
  // 自身の画面が表に表示されているかのフラグ
  bool isActive = false;
  List<String> _fileNames = [];
  bool _defaultPlay = false;

  BgmPlayer get bgm => _bgm;
  //List<String> get fileNames => _fileNames;
  String nowFileName = "";

  //前画面に戻る許可
  bool isBack = false;

  // コンストラクタ --------------------------------------------------
  BasePageState({required List<String> fileNames, required bool defaultPlay}) {
    if (fileNames.length > 0 && fileNames.isNotEmpty) {
      this._fileNames = fileNames;
    }
    nowFileName = getRandomPlayBgm();
    _defaultPlay = defaultPlay;
  }

  String getRandomPlayBgm() {
    int irnd = (new math.Random()).nextInt(this._fileNames.length);
    return this._fileNames[irnd];
  }

  //ランダムで再生
  Future bgmPlay(List<String> fileNames) async {
    //再生するBGMをリストからランダムに決定
    int irnd = (new math.Random()).nextInt(fileNames.length);
    nowFileName = fileNames[irnd];
    bgm.playBgm(name: nowFileName);
  }

  //中断中のBGMを再開
  Future bgmResume() async {
    if (nowFileName != "") bgm.resumeBgm();
  }

  //ファイル名を指定して再生
  Future bgmPlaytoFile(String fileName) async {
    nowFileName = fileName;
    bgm.playBgm(name: nowFileName);
  }

  Future bgmStop() async {
    bgm.stopBgmAny();
  }

  // アプリケーションのライフサイクル start --------------------------------------------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      this.onForeground();
    } else if (state == AppLifecycleState.paused) {
      this.onBackground();
    }
    super.didChangeAppLifecycleState(state);
  }

  void onBackground() {
    // ホーム画面に切り替わり、バックグラウンド状態のとき、BGMを一時停止する
    if (_defaultPlay) this._bgm.pauseBgm(nowFileName);
  }

  void onForeground() {
    if (this.isActive && nowFileName != "") {
      // 自分自身の画面がトップに表示されていれば、以降の処理を実施
      // ホーム画面からアプリに戻り、フォアグラウンド状態に戻ったとき、BGMを再生する
      if (_defaultPlay) this._bgm.playBgm(name: nowFileName);
    }
  }

  // アプリケーションのライフサイクル end --------------------------------------------------
  // StatefulWidget（画面）のライフサイクル start --------------------------------------------------
  @override
  void initState() {
    super.initState();
    // アプリの状態遷移をハンドリングできるようにする
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bgm = Provider.of<BgmPlayer>(context);
    // 画面遷移をハンドリングできるようにする
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  //？？？前後の画面で同じBGMの場合、POPで戻った時、戻り先のdidPopNextの次に元のdisposeが走ってBGMがとまってしまう
  @override
  void dispose() {
    // POP、replace時に画面終了する際、後始末をする
    this.isActive = false;
    if (_defaultPlay) this._bgm.pauseBgm(nowFileName);
    WidgetsBinding.instance?.removeObserver(this);
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // StatefulWidget（画面）のライフサイクル end --------------------------------------------------
  // routeObserverによる画面遷移時のライフサイクル start --------------------------------------------------
  @override
  void didPush() {
    // 自身の画面がコールされたときに、isActiveをtrueにする
    this.isActive = true;
    if (_defaultPlay) {
      this._bgm.playBgm(name: nowFileName);
    }
      super.didPush();
  }

  @override
  void didPopNext() {
    // 次画面がPOPされ自身の画面に戻ってきたとき、isActiveをtrueにし、BGMを再生させる
    this.isActive = true;
    // 自分自身の画面がトップに表示されていれば、以降の処理を実施
    // ホーム画面からアプリに戻り、フォアグラウンド状態に戻ったとき、BGMを再生する
    if (_defaultPlay) this._bgm.playBgm(name: nowFileName);
    super.didPopNext();
  }

  @override
  void didPushNext() {
    // Pushにて次画面に遷移する際、isActiveをfalseにし、BGMを一時停止させる
    this.isActive = false;
    if (_defaultPlay) this._bgm.pauseBgm(nowFileName);
    super.didPushNext();
  }

  // 画面遷移時のライフサイクル end --------------------------------------------------

  //バイブレーション
  void vibe(int duration) async {
    bool? vibeEnable = await Vibration.hasAmplitudeControl();
    if (vibeEnable != null && vibeEnable) {
      Vibration.vibrate(amplitude: 128, duration: duration);
    }
  }

  // 子クラスにおいては標準のbuildの代わりに実装を強制させる
  // 標準のbuildを利用したい場合、本メソッドの戻り値にnullを設定可能とする
  Widget? buildChildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => WillPopScope(
            child: this.buildChildWidget(context) ?? Text(""), // 上記の抽象メソッドをコール
            onWillPop: () async {
              // 自身の画面がPOPされたときに、Playerクラスの後始末をする
              // Androidでの戻るボタンでアプリを終了させる場合、
              // POP実行前のタイミングで後始末しないとBGMが止まらなくなる・・・
              this.isActive = false;
              this._bgm.pauseBgm(nowFileName);
              if (!Navigator.canPop(context)) {
                // 戻り先が存在しない場合、アプリ終了とみなし、bgmをdisposeする
                this._bgm.disposeBgm();
              }
              return true;
            }));
  }
}
