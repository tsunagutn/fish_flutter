import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:fish_flutter/Main.dart';

//連続再生を禁止する区分
enum enumDisableContainPlay {
  drag,
  jerk,
}

class SoundManagerPool {
  int playIndex = 0;
  List<SoundManager> managers = [];
  List<int> lstDisableContainIdx = [];

  SoundManagerPool(int managerCount) {
    for (int i = 0; i < managerCount; i++) {
      managers.add(SoundManager());
    }
    //連続再生禁止用のインデックスリスト
    //dragのインデックスをadd
    lstDisableContainIdx.add(0);
    //jerkのインデックスをadd
    lstDisableContainIdx.add(0);
  }

  SoundManagerPoolInit() {
    List<String> lstSeFileName = [];
    //？？？これはあまりにもひどくないか・・・？
    lstSeFileName.add("se/bait.mp3");
    lstSeFileName.add("se/book.mp3");
    lstSeFileName.add("se/bookclose.mp3");
    lstSeFileName.add("se/boxclose.mp3");
    lstSeFileName.add("se/boxopen.mp3");
    lstSeFileName.add("se/clutch.mp3");
    lstSeFileName.add("se/drag.mp3");
    lstSeFileName.add("se/drag2.mp3");
    lstSeFileName.add("se/drag2_high.mp3");
    lstSeFileName.add("se/engineon.mp3");
    lstSeFileName.add("se/highjerk.mp3");
    lstSeFileName.add("se/hit.mp3");
    lstSeFileName.add("se/jingle01.mp3");
    lstSeFileName.add("se/kk_sonar_low.mp3");
    lstSeFileName.add("se/linebreak.mp3");
    lstSeFileName.add("se/lowjerk.mp3");
    lstSeFileName.add("se/lurebroken.mp3");
    lstSeFileName.add("se/middlejerk.mp3");
    lstSeFileName.add("se/muon01.mp3");
    lstSeFileName.add("se/shipmove.mp3");
    lstSeFileName.add("se/shop.mp3");
    lstSeFileName.add("se/system27.mp3");
    lstSeFileName.add("se/waterlanding.mp3");
    lstSeFileName.add("se/waterup.mp3");
    lstSeFileName.add("se/waterupfish.mp3");

    //全SEのプリロード？
    loadSound(lstSeFileName);
    managers.forEach((element) async {
      //定義済みの全managerで0.1secの無音を再生 IOSブラウザ対策
      await element.playSound('se/muon01.mp3');
    });
  }

  Future<void> loadSound(List<String> fileNames) async {
    for (var manager in managers) {
      await manager.loadSound(fileNames);
    }
    return;
  }

  playSoundDisableContain(String path, enumDisableContainPlay kbn) {
    if (managers[lstDisableContainIdx[kbn.index]].advancedPlayer.state !=
        PlayerState.PLAYING) {
      //同じ区分の効果音がまだ再生中でない時のみ再生する
      lstDisableContainIdx[kbn.index] = playIndex;
      playSound(path);
    }
  }

  Future<void> playSound(String path) async {
    // if (managers[playIndex].advancedPlayer.state != PlayerState.PLAYING) {
    // }
    await managers[playIndex].playSound(path);
    playIndex++;
    if (managers.length == playIndex) {
      playIndex = 0;
    }
    print("playIndex" + playIndex.toString());
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
      await audioCache.play(path, isNotification: true);
      advancedPlayer.setVolume(maxVolume * settings.volumeSe);
    }
    return;
  }
}
