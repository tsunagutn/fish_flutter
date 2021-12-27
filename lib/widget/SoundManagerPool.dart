import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class SoundManagerPool {
  int playIndex = 0;
  List<SoundManager> managers = [];

  SoundManagerPool(int managerCount) {
    for (int i = 0; i < managerCount; i++) {
      managers.add(SoundManager());
    }
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
    await audioCache.play(path, mode: PlayerMode.LOW_LATENCY);
    advancedPlayer.setVolume(0.5);

    return;
  }
}