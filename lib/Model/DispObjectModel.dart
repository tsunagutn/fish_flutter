enum dispPosition {
  sky, //各スライダーの下に表示
  shore, //スライダーの上、水面の下に表示
  water, //水中の上、底の下に表示表示
  bottom, //底の上に表示
}

//画面に表示するオブジェクトの定義
class DispObjectsModel {
  late List<DispObjectModel> obj = [];

  //コンストラクタ
  dispObjectsModel() {
    //シーダーみたいなやつ
    obj.add(new DispObjectModel(
      id: 0,
      imagePath: 'assets/Images/teibou.png',
      positon: dispPosition.sky,
      dispDepth: 0.0,
      top: 20,
      width: 100,
    ));
  }

  DispObjectModel getdispObjectData(int id) {
    return obj.firstWhere((element) => element.id.compareTo(id) == 0);
  }

  List<DispObjectModel> getDispObj(
      dispPosition p, double d, List<int> dispList) {
    //ディープコピー
    List<DispObjectModel> extractObj = [...obj];
    //深さから表示する画像を抽出
    extractObj.removeWhere((value) => p != value.positon);
    extractObj.removeWhere((value) => d < value.dispDepth);
    //既に表示中の画像は排除
    dispList.forEach((id) {
      extractObj.removeWhere((value) => id < value.id);
    });
    return extractObj;
  }
}

class DispObjectModel {
  int id; //一意識別キー
  String imagePath; //画像ファイル名
  dispPosition positon; //表示位置（縦）
  double dispDepth; //表示開始する最大水深
  double top; //上マージン
  double width; //幅

  //コンストラクタ
  DispObjectModel({
    required this.id,
    required this.imagePath,
    required this.positon,
    required this.dispDepth,
    required this.top,
    required this.width,
  });
}
