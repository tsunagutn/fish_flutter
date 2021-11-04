import 'package:flutter/material.dart';
import 'package:fish_flutter/Model/TermModel.dart';
import 'package:fish_flutter/View/DrawerItem.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Term extends StatefulWidget {
  Term({Key? key}) : super(key: key);

  @override
  _TermState createState() => _TermState();
}

// 設定ページのステータス管理
class _TermState extends State<Term> {
  // todoの一覧リスト変数を用意
  List<TermModel> settingsList = [];

  bool _check = false;
  late DateTime _checkdate;

  //同意するボタン押下時の処理
  void _termCheck(bool e) async {
    if (_check) {
      openDialog(context, '既に同意済みです。');
      return;
    }
    setState(() {
      _check = e;
    });
    if (e) {
      _checkdate = DateTime.now();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("termcheck", true);
    }
  }

  //これを画面表示時にじっこうせねばならぬ
  void testtest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool termcheck = false;
    if (prefs.getKeys().contains('termcheck')) {
      termcheck = prefs.getBool("termcheck")!;
    }
    if (termcheck) {
      setState(() {
        _check = termcheck;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("利用規約"),
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
        body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              Text("あいうえおです\nかきくけこ"),
              TextButton(
                onPressed: testtest,
                child: Text(
                  'てすとです',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              CheckboxListTile(
                activeColor: Colors.blue,
                title: Text('同意するよ'),
                controlAffinity: ListTileControlAffinity.leading,
                value: _check,
                onChanged: (value) => _termCheck(value!),
              ),
            ])));
  }

  //ダイアログ表示？？？共通化した方がよいかもしれない
  void openDialog(BuildContext context, String message) {
    showDialog<Answers>(
      context: context,
      builder: (BuildContext context) => new SimpleDialog(
        title: new Text(message),
        children: <Widget>[
          createDialogOption(context, Answers.OK, 'OK'),
        ],
      ),
    );
  }

  createDialogOption(BuildContext context, Answers answer, String str) {
    return new SimpleDialogOption(
      child: new Text(str),
      onPressed: () {
        Navigator.pop(context, answer);
      },
    );
  }
}

enum Answers { OK }
