import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers_api.dart';
import 'package:fish_flutter/Main.dart';

class BgmPlayer {
  //ボリュームの最大値
  static const maxVolume = 0.5;

  late AudioCache _cache;

  AudioPlayer? _player = AudioPlayer();
  String nowBgmName = '';
  Map<String, Uri> bgmUriMap = Map<String, Uri>();

  BgmPlayer() {
    _cache = AudioCache(fixedPlayer: _player);
  }

  Future<void> loadBgm() async {
    // 本件ではあらかじめBGMをバッファに保持させておく、
    // 戻り値のURIはファイル名をキーとしてMap内に保持し、再生時に使用する
    bgmUriMap["bgm_field.mp3"] = await _cache.load("bgm/bgm_field.mp3");
    bgmUriMap["bgm_fight.mp3"] = await _cache.load("bgm/bgm_fight.mp3");
    bgmUriMap["bgm_book.mp3"] = await _cache.load("bgm/bgm_book.mp3");
  }

  void playBgm({required String name, bool isLoop = true}) {
    //if (nowBgmName != '') {
    //現在何か再生中なら止める
    stopBgmAny();
    //}
    //設定でBGM有効の時のみ
    if (settings.flgBgm) {
      nowBgmName = name;
      if (isLoop) {
        _player?.setReleaseMode(ReleaseMode.LOOP);
      } else {
        _player?.setReleaseMode(ReleaseMode.RELEASE);
      }
      _player?.play(bgmUriMap[name].toString(),
          volume: maxVolume * settings.volumeBgm);
    }
  }

  void pauseBgm(String? name) async {
    if (nowBgmName == name) {
      await _player?.pause();
    }
  }

  void pauseBgmAny() async {
    await _player?.pause();
  }

  void resumeBgm() async {
    if (settings.flgBgm) {
      //設定でBGM有効の時のみ再生再開
      await _player?.resume();
    } else {
      //有効で無ければ再生を止める
      await _player?.stop();
    }
  }

  void stopBgm(String? name) async {
    if (nowBgmName == name) {
      await _player?.stop();
    }
  }

  void stopBgmAny() async {
    await _player?.stop();
  }

  void volumeBgm() async {
    await _player?.setVolume(settings.volumeBgm);
  }

  Future<void> disposeBgm() async {
    return await _player?.dispose();
  }
}
