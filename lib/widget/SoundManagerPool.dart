import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:fish_flutter/Main.dart';

class SoundManagerPool {
  int playIndex = 0;
  List<SoundManager> managers = [];

  SoundManagerPool(int managerCount) {
    for (int i = 0; i < managerCount; i++) {
      managers.add(SoundManager());
    }
  }

  SoundManagerPoolInit() {
    //定義済みの全managerで0.1secの無音を再生 IOSブラウザ対策
    managers.forEach((element) {
      element.playSound('se/muon01.mp3');
    });
  }

  Future<void> loadSound(List<String> fileNames) async {
    for (var manager in managers) {
      await manager.loadSound(fileNames);
    }
    return;
  }

  Future<void> playSound(String path) async {
    await managers[playIndex].playSound(path);
    playIndex++;
    if (managers.length == playIndex) {
      playIndex = 0;
    }
    //print("playIndex" + playIndex.toString());
    return;
  }
}

class SoundManager {
  //ボリュームの最大値
  static const maxVolume = 0.5;

  late AudioPlayer advancedPlayer;
  late AudioCache audioCache;
  SoundManager() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }

  Future<void> loadSound(List<String> fileNames) async {
    await audioCache.loadAll(fileNames);
    return;
  }

  Future<void> playSound(String path) async {
    if (settings.flgBgm) {
      await audioCache.play(path, mode: PlayerMode.LOW_LATENCY);
      advancedPlayer.setVolume(maxVolume * settings.volumeSe);
    }
    return;
  }
}
