import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:flutter/material.dart';

import 'RadarChart.dart';

class BookDialog extends StatefulWidget {
  @override
  const BookDialog({
    required this.fishsTable,
    required this.fishesResult,
  });
  final FishsModel fishsTable;
  final FishesResultModel fishesResult;
  _BookDialogState createState() => _BookDialogState();
}

class _BookDialogState extends State<BookDialog>
    with SingleTickerProviderStateMixin {
  List<FishModel> fishList = [];
  //bool _showFishDetail = false;
  bool _showFishDetail = true; //テスト用でtrue
  int _showFishId = 0;

  @override
  void initState() {
    super.initState();
    widget.fishsTable.fishs.forEach((value) {
      fishList.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
      title: Text("おさかな図鑑"),
      content: Container(
        //height: MediaQuery.of(context).size.height / 2,
        child: Stack(children: [
          Column(children: <Widget>[
            Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 2,
                margin: EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        makeFishTile(
                            fish: fishList[index],
                            fishResult: widget.fishesResult.listFishResult
                                .where((FishResultModel value) =>
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
          //詳細のモーダル
          IgnorePointer(
              ignoring: !_showFishDetail,
              child: AnimatedOpacity(
                  opacity: _showFishDetail ? 1.0 : 0.0,
                  duration: Duration(microseconds: 200),
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("Assets/Images/fishback.jpg"),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                            color: Colors.black.withOpacity(1.0), width: 3)),
                    child: Container(
                      color: Colors.white.withOpacity(0.5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //写真
                            new Image(
                              image: AssetImage('Assets/Images/' +
                                  widget.fishsTable
                                      .getFishDetail(_showFishId)
                                      .image),
                              width: 200,
                              height: 200,
                            ),
                            //名前
                            Text(
                                widget.fishsTable
                                    .getFishDetail(_showFishId)
                                    .name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    shadows: <Shadow>[
                                      Shadow(
                                          offset: Offset(2.0, 4.0),
                                          blurRadius: 2.0,
                                          color: Colors.black)
                                    ])),
                            Row(
                              children: [
                                new RadarChart(
                                  key: UniqueKey(),
                                  items: getFishRadarChartItem(widget.fishsTable
                                      .getFishDetail(_showFishId)),
                                  radarColors: [Colors.green],
                                  fontColor: Colors.black,
                                ),
                              ],
                            ),
                            //閉じるボタン
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
                                setState(() {
                                  _showFishDetail = false;
                                });
                              },
                            ),
                          ]),
                    ),
                  ))),
        ]),
      ),
    );
  }

  //図鑑の一覧リスト
  Widget makeFishTile(
      {required FishModel fish,
      required Iterable<FishResultModel> fishResult}) {
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
        onTap: () {
          if (fishResult.length > 0) {
            //釣果有り
            //カードタップで詳細画面を表示
            setState(() {
              _showFishId = fish.id;
              _showFishDetail = true;
            });
          }
        },
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
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

  List<RadarChartItemModel> getFishRadarChartItem(FishModel fish) {
    List<RadarChartItemModel> ret = [];
    var lvHp = -1.0;
    var lvAddMax = -1.0;
    var lvAbare = -1.0;
    var lv = fish.getPrmLevels();
    //HPのレベル取得
    for (var idx = 1; idx < lv['hp']!.length; idx++) {
      if (fish.hp < lv['hp']![idx]) {
        lvHp = idx / lv['hp']!.length;
        break;
      }
    }
    if (lvHp == -1.0) lvHp = 1.0;
    //ﾊﾟﾜｰのレベル取得
    for (var idx = 1; idx < lv['addMax']!.length; idx++) {
      if (fish.addMax < lv['addMax']![idx]) {
        lvAddMax = idx / lv['addMax']!.length;
        break;
      }
    }
    if (lvAddMax == -1.0) lvAddMax = 1.0;
    //暴れのレベル取得
    for (var idx = 1; idx < lv['abare']!.length; idx++) {
      if (fish.addMax + fish.addMin < lv['abare']![idx]) {
        lvAbare = idx / lv['abare']!.length;
        break;
      }
    }
    if (lvAbare == -1.0) lvAbare = 1.0;

    ret.add(new RadarChartItemModel(itemName: 'HP', value: lvHp));
    ret.add(new RadarChartItemModel(itemName: '引強', value: lvAddMax));
    ret.add(new RadarChartItemModel(itemName: '暴れ', value: lvAbare));
    return ret;
  }
}

// class fishTile extends StatelessWidget {
//   const fishTile(this.fish, this.fishResult);

//   final FishModel fish;
//   final Iterable<FishResultModel> fishResult;

//   @override
//   Widget build(BuildContext context) {
//     Color backgroundColor;
//     String image;
//     String name;
//     String resultCount;
//     String resultMaxSize;
//     double max = 0.0;

//     if (fishResult.length > 0) {
//       //釣果有り
//       backgroundColor = Colors.blue;
//       image = fish.image;
//       name = fish.name;
//       resultCount = fishResult.length.toString() + "匹";
//       fishResult.forEach((value) {
//         if (max < value.size) {
//           max = value.size;
//         }
//       });
//       resultMaxSize = fish.getSize(max).toStringAsFixed(1).toString() + "cm";
//     } else {
//       //釣ったことがない
//       backgroundColor = Colors.grey;
//       image = "unknownfish.png";
//       name = "?????";
//       resultCount = "0匹";
//       resultMaxSize = "";
//     }
//     return new Card(
//       color: backgroundColor,
//       child: new InkWell(
//         onTap: () {
//           debugPrint("たっぷ");
//           //カードタップで詳細画面を表示
//           return new FishDetail(fish: fish, fishResult: fishResult);
//         },
//         child: new Center(
//           child: new Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Row(
//               children: [
//                 //画像
//                 Column(
//                   children: [
//                     new Image(
//                       image: AssetImage('Assets/Images/' + image),
//                       width: 50,
//                       height: 50,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           name,
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text("釣った数：" + resultCount),
//                         Row(
//                           children: [
//                             Text("最大サイズ：" + resultMaxSize),
//                             if (max > 0.8 && max < 0.95)
//                               Icon(Icons.star, color: Colors.grey),
//                             if (max > 0.95)
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                               ),
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class FishDetail extends StatelessWidget {
// //   const FishDetail({required this.fish, required this.fishResult});

// //   final FishModel fish;
// //   final Iterable<FishResultModel> fishResult;

// //   @override
// //   Widget build(BuildContext context) {
// //     Color backgroundColor;
// //     String image;
// //     String name;
// //     String resultCount;
// //     String resultMaxSize;
// //     double max = 0.0;
// //     //詳細画面を表示
// //     debugPrint("test");
// //     return
// //     Container(
// //       decoration: BoxDecoration(
// //           border: Border.all(color: Colors.black.withOpacity(0.3), width: 1)),
// //       //title: Text("タックル変更"),
// //       child: Container(
// //         color: Colors.black.withOpacity(0.3),
// //         child: Column(children: <Widget>[Text('aeaeae')]),
// //       ),
// //     );
// //   }
// // }
