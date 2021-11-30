import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:flutter/material.dart';

class TackleChangeButton extends StatefulWidget {
  @override
  const TackleChangeButton({
    required this.mode,
    required this.depth,
    required this.image,
  });
  final String mode;  //rod/reel/lure
  final double depth;
  final String image;
  _TackleChangeButtonState createState() => _TackleChangeButtonState();
}

class _TackleChangeButtonState extends State<TackleChangeButton> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0),
            primary: Colors.orange.withOpacity(0.0),
            //onPrimary: Colors.purple,
            shape: RoundedRectangleBorder(
              //borderRadius: BorderRadius.circular(30.0),
            ),
            side: BorderSide(
              color: Colors.black, //枠線!
              width: 1, //枠線！
            )),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            image: DecorationImage(
                image:
                AssetImage(widget.image),
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity((widget.depth > 0.0? 0.7 : 1.0)), BlendMode.dstATop),
                fit: BoxFit.fill),
          ),
        ),
        onPressed: () async {
          Navigator.of(context).pop(1);
        },
      ),
    );
  }
}
