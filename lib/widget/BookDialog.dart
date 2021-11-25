import 'dart:html';

import 'package:flutter/material.dart';

class BookDialog extends StatefulWidget {
  @override
  const BookDialog({
    required this.fishTable,
  });
  final Map<int, Map<String, dynamic>> fishTable;
  _BookDialogState createState() => _BookDialogState();
}

class _BookDialogState extends State<BookDialog>
    with SingleTickerProviderStateMixin {
  bool _isAwesome = false;

  @override
  void initState() {
    super.initState();
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
    var maxColumnCnt = 3;
    var i = 0;
    Column retCol = new Column();
    // Row row = new Row(
    //   children:
    //     widget.fishTable.map((key, value) => Text("test"))

    //   ],
    // );
    widget.fishTable.forEach((key, value) {
      // if (maxColumnCnt % i == 0) {
      //   retCol.children.add(row);
      //   row = new Row();
      // }
      //row.children.add(Text(value["name"]));
      i++;
    });

    Padding ret = new Padding(
      padding: EdgeInsets.only(top: 12.0),
      child: retCol,
    );

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

    return ret;
  }

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

class _SampleTile extends StatelessWidget {
  const _SampleTile(this.backgroundColor);

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
          ),
        ),
      ),
    );
  }
}
