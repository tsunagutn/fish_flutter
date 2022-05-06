import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers_api.dart';
import 'package:fish_flutter/Main.dart';

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

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
    bgmUriMap["boatnouta.mp3"] = await _cache.load("bgm/boatnouta.mp3");
    bgmUriMap["hamabenouta.mp3"] = await _cache.load("bgm/hamabenouta.mp3");
    bgmUriMap["ieji.mp3"] = await _cache.load("bgm/ieji.mp3");
    bgmUriMap["kaigarabushi.mp3"] = await _cache.load("bgm/kaigarabushi.mp3");
    bgmUriMap["kanpainouta.mp3"] = await _cache.load("bgm/kanpainouta.mp3");
    bgmUriMap["namiunouta.mp3"] = await _cache.load("bgm/namiunouta.mp3");
    bgmUriMap["saitarobushi.mp3"] = await _cache.load("bgm/saitarobushi.mp3");
    bgmUriMap["sendosan.mp3"] = await _cache.load("bgm/sendosan.mp3");
    bgmUriMap["syusen.mp3"] = await _cache.load("bgm/syusen.mp3");
    bgmUriMap["bgm_fight_star1.mp3"] =
        await _cache.load("bgm/bgm_fight_star1.mp3");
    bgmUriMap["bgm_fight_star2.mp3"] =
        await _cache.load("bgm/bgm_fight_star2.mp3");
    bgmUriMap["bgm_fight_star3.mp3"] =
        await _cache.load("bgm/bgm_fight_star3.mp3");
    bgmUriMap["bgm_fight_star4.mp3"] =
        await _cache.load("bgm/bgm_fight_star4.mp3");
    bgmUriMap["bgm_fight_star5.mp3"] =
        await _cache.load("bgm/bgm_fight_star5.mp3");
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
