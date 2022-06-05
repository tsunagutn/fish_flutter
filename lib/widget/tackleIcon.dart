import 'package:flutter/material.dart';
import '../Model/LuresModel.dart';

//タックルサムネの表示
Widget tackleIcon({
  required double tackleIconSize,
  required LureModel lure,
  required bool flgSelect,
  double opacity = 1.0,
}) {
  //final value = hp / maxHp;
  return SizedBox(
    width: tackleIconSize,
    height: tackleIconSize,
    child: Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(
            color: flgSelect ? Colors.yellow : Colors.black,
            width: flgSelect ? 3 : 1),
        image: DecorationImage(
            image: AssetImage('assets/images/' + lure.image),
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(opacity), BlendMode.dstATop),
            fit: BoxFit.contain),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lure.getWeight(lure.useWeightId).toString() + 'g',
            style: TextStyle(fontSize: 12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Lv ' + lure.lv.toString(),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
