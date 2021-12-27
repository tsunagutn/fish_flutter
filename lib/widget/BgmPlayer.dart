import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers_api.dart';
import 'package:flutter/material.dart';

class BgmPlayer {
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
    bgmUriMap["bgm_field.mp3"] = await _cache.load("Bgm/bgm_field.mp3");
    bgmUriMap["bgm_fight.mp3"] = await _cache.load("Bgm/bgm_fight.mp3");
  }

  void playBgm({required String name, bool isLoop = true}) {
    //if (nowBgmName != '') {
    //現在何か再生中なら止める
    stopBgmAny();
    //}
    nowBgmName = name;
    if (isLoop) {
      _player?.setReleaseMode(ReleaseMode.LOOP);
    } else {
      _player?.setReleaseMode(ReleaseMode.RELEASE);
    }
    _player?.play(bgmUriMap[name].toString(), volume: 0.5);
  }

  void pauseBgm(String? name) async {
    if (nowBgmName == name) {
      await _player?.pause();
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

  Future<void> disposeBgm() async {
    return await _player?.dispose();
  }
}