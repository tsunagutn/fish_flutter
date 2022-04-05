import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:flutter/material.dart';

class FishCardList extends StatefulWidget {
  @override
  const FishCardList({
    required this.fishsTable,
    required this.fishesResult,
    required this.hitFishId,
    required this.pointerColor,
    required this.borderWidth,
  });

  final List<FishModel> fishsTable;
  final FishesResultModel fishesResult;
  final int hitFishId; //HITorアタリ中の魚ID 非HIT中は-1
  final Color pointerColor; //光点の色
  final double borderWidth; //枠線の幅
  _FishCardListState createState() => _FishCardListState();
}

class _FishCardListState extends State<FishCardList>
    with SingleTickerProviderStateMixin {
  List<FishModel> fishList = [];

  static const double cardWidth = 90.0;
  static const double cardHeight = 19.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fishList = [];
    widget.fishsTable.forEach((value) {
      fishList.add(value);
    });
    //リストソート レア度→棚
    fishList.sort((a, b) {
      int result = a.rare.compareTo(b.rare);
      if (result != 0) return result;
      return a.tanaMax.compareTo(b.tanaMax);
    });
    //リストビューの高さを算出
    double listHeight = cardHeight * fishList.length + (8 * fishList.length);

    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.red),
      // ),
      width: cardWidth,
      height: listHeight,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 0, bottom: 0),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              makeFishCard(
                  fish: fishList[index],
                  fishResult: widget.fishesResult.listFishResult.where(
                      (FishResultModel value) =>
                          value.fishId == fishList[index].id)),
            ],
          );
        },
        itemCount: fishList.length,
      ),
    );
  }

  //魚のリストアイテム
  Widget makeFishCard(
      {required FishModel fish,
      required Iterable<FishResultModel> fishResult}) {
    Color backgroundColor;
    bool flgBorder = false;
    String name;

    if (fishResult.length > 0) {
      //釣果有り
      name = fish.name;
      backgroundColor = Color(0xffffffe0);
    } else {
      //釣果なし
      name = "";
      for (var i = 0; i < fish.name.length; i++) name += "？";
      if (fish.id == widget.hitFishId) {
        flgBorder = true;
        backgroundColor = Color(0xffffffff);
      } else {
        backgroundColor = Color(0xffc0c0c0).withOpacity(0.8);
      }
    }

    return new Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: (flgBorder ? widget.borderWidth : 0),
          color: widget.pointerColor,
        ),
      ),
      // child:
      // new InkWell(
      //     splashColor: Colors.blue.withAlpha(30),
          //borderRadius: BorderRadius.circular(30),
          //onTap: () async {
          //タップ時 ？？？なにするかまだ未定
          //？？？ヒント出す？図鑑のページ出す？
          //？？？誤タップになるので何もし無い方がよいかも
          //},
          child: Container(
            height: cardHeight,
              margin: EdgeInsets.only(left:3,right: 3),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  name,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black,fontSize: 12),
                ),
              ]),
          ),
      //),
    );
  }
}
