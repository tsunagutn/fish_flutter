//チュートリアルマスタ
class TutorialsModel {
  late Map<int, TutorialModel> tutorialList= {};
  //コンストラクタ
  TutorialsModel() {
    //シーダーみたいなやつ
    tutorialList[1] = new TutorialModel(
      title: "ゲーム画面について 1/2",
      text: "",
      imageName: "aeae.png",
      flgNext: true,
    );
    tutorialList[2] = (new TutorialModel(
      title: "ゲーム画面について 2/2",
      text: "",
      imageName: "aeae.png",
      flgNext: false,
    ));
  }
}

class TutorialModel {
  String title; //タイトル
  String text; //説明文
  String imageName; //説明画像名
  bool flgNext; //次ページの有無

  //コンストラクタ
  TutorialModel({
    required this.title,
    required this.text,
    required this.imageName,
    required this.flgNext,
  });
}
