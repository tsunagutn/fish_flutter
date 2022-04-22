//チュートリアルマスタ
class TutorialsModel {
  late Map<int, TutorialModel> tutorialList= {};
  //コンストラクタ
  TutorialsModel() {
    //シーダーみたいなやつ
    tutorialList[1] = new TutorialModel(
      title: "ゲーム画面",
      text: "",
      imageName: "tutorial1.png",
      flgNext: true,
    );
    tutorialList[2] = (new TutorialModel(
      title: "魚の釣り方",
      text: "",
      imageName: "tutorial2.png",
      flgNext: true,
    ));
    tutorialList[3] = (new TutorialModel(
      title: "魚がヒットした時",
      text: "",
      imageName: "tutorial3.png",
      flgNext: true,
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
