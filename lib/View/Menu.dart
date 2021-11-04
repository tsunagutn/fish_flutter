import 'package:flutter/material.dart';

import 'package:fish_flutter/View/DrawerItem.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("メインメニュー"),
        ]),
      ),
      endDrawer: DrawerItem(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              color: Color(0xffffffe0),
              elevation: 10,
              shadowColor: Color(0xff555555),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  borderRadius: BorderRadius.circular(30),
                  onTap: () async {
                    final result =
                        await Navigator.of(context).pushNamed('/fishing');
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 400,
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 60.0,
                            ),
                            Text(
                              "開始",
                              style:
                                  TextStyle(fontSize: 32, color: Colors.black),
                            ),
                          ]))),
            ),
            Card(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              color: Color(0xffffffe0),
              elevation: 10,
              shadowColor: Color(0xff555555),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  borderRadius: BorderRadius.circular(30),
                  onTap: () async {
                    final result =
                        await Navigator.of(context).pushNamed('/settings');
                    // if (result != null) {
                    //   setState(() {
                    //     todoList.add(result);
                    //   });
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 400,
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.green,
                              size: 60.0,
                            ),
                            Text(
                              "設定を変更する",
                              style:
                                  TextStyle(fontSize: 32, color: Colors.black),
                            ),
                          ]))),
            ),
            Card(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              color: Color(0xffffffe0),
              elevation: 10,
              shadowColor: Color(0xff555555),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  borderRadius: BorderRadius.circular(30),
                  onTap: () async {
                    final result =
                        await Navigator.of(context).pushNamed('/lightspot');
                    // if (result != null) {
                    //   setState(() {
                    //     todoList.add(result);
                    //   });
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 400,
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.green,
                              size: 60.0,
                            ),
                            Text(
                              "てすと",
                              style:
                                  TextStyle(fontSize: 32, color: Colors.black),
                            ),
                          ]))),
            ),
          ],
        ),
      ),
    );
  }
}
