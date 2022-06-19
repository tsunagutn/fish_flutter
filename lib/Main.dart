//flutter run -d chrome でchrome動作

import 'package:fish_flutter/Model/SettingsModel.dart';
import 'package:fish_flutter/TypeAdapter/typFishResult.dart';
import 'package:fish_flutter/TypeAdapter/typLureData.dart';
import 'package:fish_flutter/TypeAdapter/typResults.dart';
import 'package:fish_flutter/View/Book.dart';
import 'package:fish_flutter/widget/SoundManagerPool.dart';
import 'package:flutter/material.dart';
import 'package:fish_flutter/View/Menu.dart';
import 'package:fish_flutter/View/Settings.dart';
import 'package:fish_flutter/View/Term.dart';
import 'package:fish_flutter/View/Fishing.dart';
import 'package:fish_flutter/View/History.dart';
import 'package:fish_flutter/View/Test.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import 'Model/StageModel.dart';
import 'Model/TutorialModel.dart';
import 'TypeAdapter/typGameData.dart';
import 'TypeAdapter/typHistory.dart';
import 'TypeAdapter/typSettings.dart';
import 'View/BookHistory.dart';
import 'View/GameMenu.dart';
import 'View/Goal.dart';
import 'View/LightSpotWegit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:fish_flutter/widget/BgmPlayer.dart';

import 'View/Loading.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './Class/BasePageState.dart';

late typSettings settings = typSettings(
  flgBgm: true,
  flgControlRight: true,
  volumeBgm: 0.5,
  volumeSe: 0.5,
  jerkSense: 0.5,
  makiSense: 0.5,
  isReversal: false,
  isVibe: true,
);

//Hive BOX名
const settingsBoxName = 'settings2';
const gamedataBoxName = 'gamedata11';
const fishResultBoxName = 'fishResult3';
const lureDataBoxName = 'lureData4';
const historyBoxName = 'history8';
//Hive Key名
const settingsKeyName = 'settings';
const gamedataKeyName = 'gamedata';
const fishResultKeyName = 'fishResult';
const lureDataKeyName = 'lureData';
const historyKeyName = 'history';

const List<String> lstOldBoxName = [
  'fishResult',
  'fishResult1',
  'fishResult2',
  'settings',
  'settings1',
  'gamedata8',
  'gamedata9',
  'gamedata10',
  'lureData1',
  'lureData2',
  'lureData3',
  'history7',
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //縦固定
  ]);

  await Hive.initFlutter();
  //環境設定データのタイプアダプタ
  Hive.registerAdapter(typSettingsAdapter());
  Hive.registerAdapter(typResultsAdapter());
  Hive.registerAdapter(typGameDataAdapter());
  Hive.registerAdapter(typFishResultAdapter());
  Hive.registerAdapter(typLureDataAdapter());
  Hive.registerAdapter(typHistoryAdapter());

  lstOldBoxName.forEach((oldBoxName) async {
    //過去のHiveBOXを削除する
    await Hive.deleteBoxFromDisk(oldBoxName);
  });
  var settingsBox = await Hive.openBox(settingsBoxName);
  var gameDataBox = await Hive.openBox(gamedataBoxName);
  var fishResultBox = await Hive.openBox(fishResultBoxName);
  var lureDataBox = await Hive.openBox(lureDataBoxName);
  var historyBox = await Hive.openBox(historyBoxName);

  //環境設定が無い場合
  if (!settingsBox.containsKey(settingsKeyName)) {
    //環境設定に初期値を格納
    settingsBox.put(settingsKeyName, settings);
  }
  settings = settingsBox.get(settingsKeyName);
  // //履歴が無い場合
  // if (!historyBox.containsKey(historyKeyName)) {
  //   //初期データ格納
  //   typHistory history = typHistory();
  //   history.lstGameDatas = HiveList(gameDataBox);
  //   historyBox.put(settingsKeyName, settings);
  // }

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

      // routesの代わりにonGenerateRouteを使う
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          '/': (_) => Loading(),
          '/menu': (_) => Menu(),
          '/settings': (_) => Settings(),
          '/term': (_) => Term(),
          '/fishing': (_) => Fishing(),
          '/gamemenu': (_) => GameMenu(),
          '/history': (_) => History(),
          '/book': (_) => Book(
              arguments: settings.arguments as String,
              bgmMode: enumBgmMode.auto),
          '/booknonbgm': (_) => Book(
              arguments: settings.arguments as String,
              bgmMode: enumBgmMode.none),
          '/bookhistory': (_) => BookHistory(),
          '/goal': (_) => Goal(),
        };
        WidgetBuilder builder = routes[settings.name] ?? routes['/']!;
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },

      // routes: {
      //   '/': (_) => Loading(),
      //   '/menu': (_) => Menu(),
      //   '/settings': (_) => Settings(),
      //   '/term': (_) => Term(),
      //   '/fishing': (_) => Fishing(),
      //   '/gamemenu': (_) => GameMenu(),
      //   '/history': (_) => History(),
      //   '/book': (_) => Book(bgmMode: enumBgmMode.auto),
      //   '/booknonbgm': (_) => Book(bgmMode: enumBgmMode.none),
      //   '/bookhistory': (_) => BookHistory(),
      //   '/goal': (_) => Goal(),
      // },
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
