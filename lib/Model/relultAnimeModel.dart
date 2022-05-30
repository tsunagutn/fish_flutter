enum enumAnimeState {
  standby,
  doing,
  end,
}

//リザルト画面のアニメーション管理用クラス
class relultAnimeModel {
  int span; //msec単位のアニメーション周期
  enumAnimeState state = enumAnimeState.standby; //アニメ状態

  //コンストラクタ
  relultAnimeModel({
    required this.span,
  });
}
