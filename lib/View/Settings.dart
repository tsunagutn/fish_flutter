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
  // todoの一覧リスト変数を用意
  List<SettingsModel> settingsList = [];

  // テキストフィールドのコントローラー設定
  // コントローラーの宣言
  late TextEditingController _settingsInputController;

  // コントローラーの初期化
  void initState() {
    super.initState();
    _settingsInputController = TextEditingController();
  }

// statefulオブジェクトが削除されるときに、参照を削除してくれる
  void dispose() {
    super.dispose();
    _settingsInputController.dispose();
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
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _settingsInputController,
              decoration: InputDecoration(hintText: '入力してください'),
              autofocus: true,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: 0.0, right: 0.0, bottom: 30.0, left: 0.0),
              child: ElevatedButton(
                  child: Text(
                    '保存',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    // 変数の変化をリアルタイムに通知する
                    setState(
                      () {
                        // 何かしらの入力があるときだけ実行
                        if (_settingsInputController.text.length > 0) {
                          // 配列に入力値を追加
                          settingsList.add(SettingsModel(
                              text: _settingsInputController.text));
                          // テキストボックスを初期化
                          _settingsInputController.clear();
                        }
                      },
                    );
                  })),
          Expanded(
            child: ListView.builder(
              // リストの長さを計算
              itemCount: settingsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(
                      top: 0.0, right: 0.0, bottom: 0.0, left: 0.0),
                  margin: EdgeInsets.only(
                      top: 1.0, right: 0.0, bottom: 0.0, left: 0.0),
                  color: Colors.cyan[600],
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text(
                      // リストに表示する文字列を設定
                      ("$index : ${settingsList[index].text}"),
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]));
  }
}
