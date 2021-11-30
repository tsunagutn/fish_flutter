import 'dart:html';

import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:flutter/material.dart';

class TackleMenuDialog extends StatefulWidget {
  @override
  const TackleMenuDialog({
    required this.fishsTable,
    required this.fishesResult,
  });
  final FishsModel fishsTable;
  final FishesResultModel fishesResult;
  _TackleMenuDialogState createState() => _TackleMenuDialogState();
}

class _TackleMenuDialogState extends State<TackleMenuDialog>
    with SingleTickerProviderStateMixin {
  List<FishModel> fishList = [];

  @override
  void initState() {
    super.initState();
    widget.fishsTable.fishs.forEach((key, value) {
      fishList.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("おさかな図鑑"),
        content: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Column(children: <Widget>[
            Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 2 - 100,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        _fishTile(
                            fishList[index],
                            widget.fishesResult.listFishResult.where(
                                (FishResultModel value) =>
                                    value.fishId == fishList[index].id)),
                      ],
                    );
                  },
                  itemCount: fishList.length,
                )),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              label: const Text('閉じる'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.5),
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]),
        ));
  }
}

class _fishTile extends StatelessWidget {
  const _fishTile(this.fish, this.fishResult);

  final FishModel fish;
  final Iterable<FishResultModel> fishResult;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    String image;
    String name;
    String resultCount;
    String resultMaxSize;
    double max = 0.0;

    if (fishResult.length > 0) {
      //釣果有り
      backgroundColor = Colors.blue;
      image = fish.image;
      name = fish.name;
      resultCount = fishResult.length.toString() + "匹";
      fishResult.forEach((value) {
        if (max < value.size) {
          max = value.size;
        }
      });
      resultMaxSize = fish.getSize(max).toStringAsFixed(1).toString() + "cm";
    } else {
      //釣ったことがない
      backgroundColor = Colors.grey;
      image = "unknownfish.png";
      name = "?????";
      resultCount = "0匹";
      resultMaxSize = "";
    }
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                //Text("a"),
                //画像
                Column(
                  children: [
                    new Image(
                      image: AssetImage('Assets/Images/' + image),
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("釣った数：" + resultCount),
                        Row(
                          children: [
                            Text("最大サイズ：" + resultMaxSize),
                            if (max > 0.8 && max < 0.95)
                              Icon(Icons.star, color: Colors.grey),
                            if (max > 0.95)
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
