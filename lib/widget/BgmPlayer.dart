import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers_api.dart';
import 'package:fish_flutter/Main.dart';
import 'package:flutter/material.dart';
import 'package:fish_flutter/widget/SoundManagerPool.dart';

class BgmPlayer {
  late AudioCache _cache;
  //SE
  SoundManagerPool soundManagerPool = new SoundManagerPool(20);

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
    bgmUriMap["bgm_book.mp3"] = await _cache.load("Bgm/bgm_book.mp3");
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
    if (settings.flgBgm) {
      //設定でBGM有効の時のみ
      _player?.play(bgmUriMap[name].toString(), volume: 0.1);
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

  Future<void> disposeBgm() async {
    return await _player?.dispose();
  }
}
