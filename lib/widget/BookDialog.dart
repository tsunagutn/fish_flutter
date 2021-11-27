import 'dart:html';

import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:flutter/material.dart';

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
  bool _isAwesome = false;
  List<FishModel> fishList = [];

  @override
  void initState() {
    super.initState();
    widget.fishsTable.fishs.forEach((key, value) {
      fishList.add(value);
    });
  }

  Widget _buildAwesomeButton() {
    return RaisedButton(
      child: Text(""),
      onPressed: () {
        setState(() {});
      },
    );
  }

  Widget _buildSenchoMessage() {
    return Text("");
  }

  Widget fishWidget() {
    bool flgResult;
    return Container(
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
        ));
    // return Column(
    //     children: fishList
    //         .map((FishModel fish) => Container(child: _fishTile(fish)))
    //         .toList());
  }
  //   var maxColumnCnt = 3;
  //   var i = 0;
  //   Column retCol = new Column();
  //   // Row row = new Row(
  //   //   children:
  //   //     widget.fishTable.map((key, value) => Text("test"))

  //   //   ],
  //   // );
  //   widget.fishTable.forEach((key, value) {
  //     // if (maxColumnCnt % i == 0) {
  //     //   retCol.children.add(row);
  //     //   row = new Row();
  //     // }
  //     //row.children.add(Text(value["name"]));
  //     i++;
  //   });

  // Padding ret = new Padding(
  //   padding: EdgeInsets.only(top: 12.0),
  //   child: retCol,
  // );

  // Padding ret = new Padding(
  //     padding: EdgeInsets.only(top: 12.0),
  //     child: StaggeredGridView.count(
  //       crossAxisCount: 3,
  //       staggeredTiles: const <StaggeredTile>[
  //         const StaggeredTile.count(3, 2),
  //         const StaggeredTile.count(1, 1),
  //         const StaggeredTile.count(1, 1),
  //         // const StaggeredTile.count(2, 2),
  //         // const StaggeredTile.count(2, 1),
  //         // const StaggeredTile.count(1, 2),
  //         // const StaggeredTile.count(1, 1),
  //         // const StaggeredTile.count(2, 2),
  //         // const StaggeredTile.count(1, 2),
  //         // const StaggeredTile.count(1, 1),
  //         // const StaggeredTile.count(3, 1),
  //         // const StaggeredTile.count(1, 1),
  //         // const StaggeredTile.count(4, 1),
  //       ],
  //       children: [
  //         const _SampleTile(Colors.green),
  //         const _SampleTile(Colors.lightBlue),
  //         const _SampleTile(Colors.amber),
  //         // const _SampleTile(Colors.brown),
  //         // const _SampleTile(Colors.deepOrange),
  //         // const _SampleTile(Colors.indigo),
  //         // const _SampleTile(Colors.red),
  //         // const _SampleTile(Colors.pink),
  //         // const _SampleTile(Colors.purple),
  //         // const _SampleTile(Colors.blue),
  //         // const _SampleTile(Colors.black),
  //         // const _SampleTile(Colors.red),
  //         // const _SampleTile(Colors.brown),
  //       ],
  //     ));

  //   return ret;
  // }

  @override
  Widget build(BuildContext context) {
    // return SimpleDialog(
    //   title: const Text('船長'),
    //   children: <Widget>[
    //     const Text('Flutter is awesome.'),
    //     _buildAwesomeButton(),
    //   ],
    // );

    //_depth_change_order = widget.depth_change_order;

    return AlertDialog(
        title: Text("おさかな図鑑"),
        content: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Column(children: <Widget>[
            fishWidget(),
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

// builder: (BuildContext context) {

class _fishTile extends StatelessWidget {
  const _fishTile(this.fish, this.fishResult);

  final FishModel fish;
  final Iterable<FishResultModel> fishResult;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    String image;
    String name;
    // String sizeRange =
    //     fish.sizeMin.toString() + "～" + fish.sizeMax.toString() + "cm";
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
