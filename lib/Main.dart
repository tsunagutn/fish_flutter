//flutter run -d chrome でchrome動作

import 'package:fish_flutter/Model/SettingsModel.dart';
import 'package:fish_flutter/widget/SoundManagerPool.dart';
import 'package:flutter/material.dart';
import 'package:fish_flutter/View/Menu.dart';
import 'package:fish_flutter/View/Settings.dart';
import 'package:fish_flutter/View/Term.dart';
import 'package:fish_flutter/View/Fishing.dart';
import 'package:fish_flutter/View/Test.dart';
import 'package:provider/provider.dart';

import 'View/LightSpotWegit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:fish_flutter/widget/BgmPlayer.dart';

void main() {
  runApp(Provider(
    create: (context) => BgmPlayer(),
    child: MyApp(),
  ));
}

// RouteObserverを利用するので、本件ではクラス外にて定義
var routeObserver = RouteObserver<PageRoute>();

//環境設定のインスタンス
var settings = new SettingsModel(
    //？？？ここは本当は環境設定のファイルかDBから読むように
    flgBgm: false,
    flgControlRight: true,
    volumeBgm: 0.5,
    volumeSe: 0.5,
    jerkSense: 0.5,
);

//SEプール
SoundManagerPool soundManagerPool = new SoundManagerPool(5);

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
        '/': (_) => Menu(),
        '/settings': (_) => Settings(),
        '/term': (_) => Term(),
        '/fishing': (_) => Fishing(),
        '/test': (_) => Test(),
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
