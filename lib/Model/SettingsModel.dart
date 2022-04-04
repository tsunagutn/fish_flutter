class SettingsModel {
  bool flgBgm;
  bool flgControlRight;
  double volumeBgm;
  double volumeSe;
  double jerkSense;
  //コンストラクタ
  SettingsModel({
    required this.flgBgm,
    required this.flgControlRight,
    required this.volumeBgm,
    required this.volumeSe,
    required this.jerkSense,
  });
}
