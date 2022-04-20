import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:fish_flutter/Model/TutorialModel.dart';
import 'package:flutter/material.dart';

import '../Main.dart';

class tutorialDialog extends StatefulWidget {
  @override
  const tutorialDialog({
    required this.tutorialId,
    required this.dispSize,
    required this.flgAll,
  });
  final int tutorialId;
  final Size dispSize;
  final bool flgAll;

  _tutorialDialogState createState() => _tutorialDialogState();
}

class _tutorialDialogState extends State<tutorialDialog>
    with TickerProviderStateMixin {

  int nowPageId = 0;
  List<int> historyStack = [];
  late TutorialModel tutorial;
  bool flgDispPrev = false;
  bool flgDispNext = false;

  @override
  void initState() {
    super.initState();
    nowPageId = widget.tutorialId;
    changePage(nowPageId);
  }

  //次のページ
  void prevPage() {
    historyStack.remove(nowPageId);
    changePage(nowPageId - 1);
  }
  //次のページ
  void nextPage() {
    historyStack.add(nowPageId + 1);
    changePage(nowPageId + 1);
  }
  //ページ切り替え
  void changePage(int id) {
    setState(() {
    tutorial = tutorials.tutorialList[id]!;
    nowPageId = id;
    flgDispPrev = (historyStack.length > 0);
    if (widget.flgAll || tutorial.flgNext) {
      if (tutorials.tutorialList.keys.contains(id + 1)) {
        flgDispNext = true;
      } else {
        flgDispNext = false;
      }
    }
    });
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
        titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(2.0, 4.0),
                  blurRadius: 2.0,
                  color: Colors.black)
            ]),
        title: Text(
          tutorial.title,
        ),
        content: Container(
          height: widget.dispSize.height,
          width: widget.dispSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Column(children:[
              new Image(
                image:
                    AssetImage('assets/images/tutorial/' + tutorial.imageName),
                width: widget.dispSize.width,
                fit: BoxFit.fitWidth,
              ),
          ],
          ),
              SizedBox(width: widget.dispSize.width,child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  (flgDispPrev) ?
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.arrow_left),
                    onPressed: () {
                      //前のチュートリアルを表示
                      prevPage();
                    },
                  ) : Container(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.close_sharp),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  (flgDispNext) ?
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.arrow_right),
                    onPressed: () {
                      //次のチュートリアルを表示
                      nextPage();
                    },
                  ):Container(),
                ],
              ),),
            ],
          ),
        ),
      );
  }
}
