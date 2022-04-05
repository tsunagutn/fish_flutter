import 'package:flutter/material.dart';
import 'package:fish_flutter/Model/SettingsModel.dart';
import 'package:fish_flutter/View/DrawerItem.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

// 設定ページのステータス管理
class _SettingsState extends State<Settings> {

  // コントローラーの初期化
  void initState() {
    super.initState();
  }

// statefulオブジェクトが削除されるときに、参照を削除してくれる
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("環境設定"),
          ]),
          leading: IconButton(
            // 表示アイコン
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
        // 背景色
        //backgroundColor: Colors.teal[50],
        body: Container(),
    );
  }
}
