import 'package:hive/hive.dart';

import '../Model/FishResultsModel.dart';

part 'typResults.g.dart';

@HiveType(typeId: 2)
class typResults extends HiveObject {
  @HiveField(0)
  List<FishesResultModel> lstResults = [];
  //List<int> lstResults = [];

  // typResults({
  //   required this.lstResults,
  // });

  typResults() {
    final FishesResultModels = Hive.box<FishesResultModel>('box');
    lstResults = HiveList(FishesResultModels);
  }
}
