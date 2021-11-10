import 'package:flutter/material.dart';

class SenchoDialog extends StatefulWidget {
  @override
  const SenchoDialog({
    required this.depth_change_order,
    required this.point,
  });
  final int depth_change_order;
  final int point;
  _SenchoDialogState createState() => _SenchoDialogState();
}

class _SenchoDialogState extends State<SenchoDialog> {
  bool _isAwesome = false;
  String _sencho_message = "";
  int _depth_change_order = -1;

  @override
  void initState() {
    super.initState();
    _isAwesome = false;
    _sencho_message = '何かや！';
  }

  Widget _buildAwesomeButton() {
    return RaisedButton(
      child: Text(_sencho_message),
      onPressed: () {
        setState(() {
          _isAwesome = !_isAwesome;
          _sencho_message =
              _isAwesome ? 'u a Awesome!' : 'please tap Awesome..';
        });
      },
    );
  }

  Widget _buildSenchoMessage() {
    return Text(_sencho_message);
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
        title: Text("船長"),
        content: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Column(children: <Widget>[
            new Image(
              image: AssetImage('assets/images/sencho.png'),
              width: 150,
              height: 150,
            ),
            _buildSenchoMessage(),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              label: const Text('深さは今が丁度いい'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.withOpacity(0.5),
                onPrimary: Colors.white,
              ),
              onPressed: () {
                _depth_change_order = 0;
                setState(() {
                  _sencho_message = "このぐらいの深さじゃのう";
                });
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              label: const Text('深いとこがいい'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.withOpacity(0.5),
                onPrimary: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (widget.depth_change_order == 2) {
                    _sencho_message = "もう深くしていっとる！";
                  } else {
                    _depth_change_order = 2;
                    _sencho_message = "深くしていくで！";
                  }
                });
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              label: const Text('浅いとこがいい'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.withOpacity(0.5),
                onPrimary: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (widget.depth_change_order == 1) {
                    _sencho_message = "もう浅くしていっとる！";
                  } else {
                    _depth_change_order = 1;
                    _sencho_message = "浅くしていくで！";
                  }
                });
              },
            ),
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
                Navigator.of(context).pop(_depth_change_order);
              },
            ),
            Text(widget.point.toString() + "ポイント"),
          ]),
        ));
  }
}

                              // builder: (BuildContext context) {
