//flutter run -d chrome でchrome動作

import 'package:fish_flutter/Model/SettingsModel.dart';
import 'package:fish_flutter/TypeAdapter/typResults.dart';
import 'package:fish_flutter/widget/SoundManagerPool.dart';
import 'package:flutter/material.dart';
import 'package:fish_flutter/View/Menu.dart';
import 'package:fish_flutter/View/Settings.dart';
import 'package:fish_flutter/View/Term.dart';
import 'package:fish_flutter/View/Fishing.dart';
import 'package:fish_flutter/View/History.dart';
import 'package:fish_flutter/View/Test.dart';
import 'package:provider/provider.dart';

import 'Model/StageModel.dart';
import 'Model/TutorialModel.dart';
import 'TypeAdapter/typGameData.dart';
import 'TypeAdapter/typSettings.dart';
import 'View/LightSpotWegit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:fish_flutter/widget/BgmPlayer.dart';

import 'View/Loading.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

late typSettings settings = typSettings(
    flgBgm: true,
    flgControlRight: true,
    volumeBgm: 0.5,
    volumeSe: 0.5,
    jerkSense: 0.5,
    makiSense: 0.5);

void main() async {
  await Hive.initFlutter();
  //環境設定データのタイプアダプタ
  Hive.registerAdapter(typSettingsAdapter());
  Hive.registerAdapter(typResultsAdapter());
  Hive.registerAdapter(typGameDataAdapter());

  //Hive TYPEの構成変えたら一回BOXを削除する用
  //var gameDataBox = await Hive.deleteBoxFromDisk('gamedata');
  var settingsBox = await Hive.openBox('settings');
  var gameDataBox = await Hive.openBox('gamedata');
  var fishResultBox = await Hive.openBox('fishResult');

  if (!settingsBox.containsKey('settings')) {
    //環境設定に初期値を格納
    settingsBox.put('settings', settings);
  }
  settings = settingsBox.get('settings');

  runApp(Provider(
    create: (context) => BgmPlayer(),
    child: MyApp(),
  ));
}

// RouteObserverを利用するので、本件ではクラス外にて定義
var routeObserver = RouteObserver<PageRoute>();

// //環境設定のインスタンス
// var settings = new SettingsModel(
//   //Hiveから読込
//   flgBgm: stg.flgBgm,
//   flgControlRight: stg.flgControlRight,
//   volumeBgm: stg.volumeBgm,
//   volumeSe: stg.volumeSe,
//   jerkSense: stg.jerkSense,
//   makiSense: stg.makiSense,
// );

//ステージ情報のインスタンス
var stages = new StagesModel();
//チュートリアル情報のインスタンス
var tutorials = new TutorialsModel();

//SEプール
SoundManagerPool soundManagerPool = new SoundManagerPool(7);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FISH',
      theme: ThemeData(
        //これはアプリケーションのテーマです。
        //
        //「flutter run」でアプリケーションを実行してみてください。 が表示されます
        //アプリケーションには青いツールバーがあります。 次に、アプリを終了せずに、
        //以下のprimarySwatchをColors.greenに変更してから、
        //「ホットリロード」（「flutterrun」を実行したコンソールで「r」を押します。
        //または単にFlutterIDEの「ホットリロード」への変更を保存します）。
        //カウンタがゼロにリセットされなかったことに注意してください。 アプリケーション
        //再起動されません。

        //ヘッダバーの色
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //基本フォント
        textTheme: GoogleFonts.yuseiMagicTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => Loading(),
        '/menu': (_) => Menu(),
        '/settings': (_) => Settings(),
        '/term': (_) => Term(),
        '/fishing': (_) => Fishing(),
        '/history': (_) => History(),
        '/lightspot': (_) => LightSpotWegit(),
      },
      //home: MyHomePage(title: 'チェックリスト'),
      navigatorObservers: [
        routeObserver,
      ],
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   //このウィジェットはアプリケーションのホームページです。
//   //ステートフルです。
//   //つまり、外観に影響を与えるフィールドを含むStateオブジェクト（以下で定義）があります。

//   //このクラスは状態の構成です。
//   //これは、親（この場合はAppウィジェット）によって提供され、
//   //Stateのbuildメソッドによって使用される値（この場合はタイトル）を保持します。
//   //ウィジェットサブクラスのフィールドは常に「final」とマークされます。

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text(widget.title),
//           ]),
//         ),
//         endDrawer: Drawer(child: Center(child: Text("Drawer"))),
//         body: Menu());
//   }
// }
