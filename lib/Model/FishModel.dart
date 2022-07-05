import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum enumFishType {
  blue, //青魚
  bream, //鯛系
  bottom, //底物
}

class FishsModel {
  late List<FishModel> fishs = [];

  //コンストラクタ
  FishsModel() {
    fishs.add(new FishModel(
        id: 0,
        type: enumFishType.blue,
        name: 'アジ',
        rare: 1,
        image: 'fish/aji.png',
        text: '',
        hp: 1200,
        wariai: 1,
        point: 100,
        tanaMin: 0,
        tanaMax: 100,
        hereTanaMin: 0,
        hereTanaMax: 100,
        hitMaki: 1,
        hitJerk: 1,
        hitFall: 1,
        hitSpeedJust: 50,
        hitSpeedRange: 40,
        sizeMin: 7.6,
        sizeMax: 51.3,
        weightMin: 100,
        weightMax: 1500,
        abareLv: 2,
        baitCntMax: 20,
        fookingTension: 200,
        bareEasy: 0.5));
    fishs.add(new FishModel(
        id: 1,
        type: enumFishType.blue,
        name: 'サバ',
        rare: 1,
        image: 'fish/saba.png',
        text: '',
        hp: 1200,
        wariai: 1,
        point: 100,
        tanaMin: 0,
        tanaMax: 100,
        hereTanaMin: 50,
        hereTanaMax: 200,
        hitMaki: 0.8,
        hitJerk: 1,
        hitFall: 0.7,
        hitSpeedJust: 150,
        hitSpeedRange: 50,
        sizeMin: 14.3,
        sizeMax: 67.2,
        weightMin: 200,
        weightMax: 2000,
        abareLv: 5,
        baitCntMax: 15,
        fookingTension: 350,
        bareEasy: 0.6));
    fishs.add(new FishModel(
        id: 2,
        type: enumFishType.blue,
        name: 'サゴシ',
        rare: 2,
        image: 'fish/sagoshi.png',
        text: '',
        hp: 1500,
        wariai: 0.8,
        point: 200,
        tanaMin: 0,
        tanaMax: 150,
        hereTanaMin: 100,
        hereTanaMax: 300,
        hitMaki: 0.6,
        hitJerk: 0.9,
        hitFall: 0.6,
        hitSpeedJust: 230,
        hitSpeedRange: 70,
        sizeMin: 18.3,
        sizeMax: 69.9,
        weightMin: 200,
        weightMax: 1900,
        abareLv: 6,
        baitCntMax: 15,
        fookingTension: 400,
        bareEasy: 0.8));
    fishs.add(new FishModel(
        id: 3,
        type: enumFishType.blue,
        name: 'ワカナ',
        rare: 2,
        image: 'fish/wakana.png',
        text: '',
        hp: 2100,
        wariai: 0.7,
        point: 150,
        tanaMin: 0,
        tanaMax: 230,
        hereTanaMin: 200,
        hereTanaMax: 400,
        hitMaki: 0.7,
        hitJerk: 1,
        hitFall: 0.8,
        hitSpeedJust: 220,
        hitSpeedRange: 60,
        sizeMin: 21.5,
        sizeMax: 39.9,
        weightMin: 430,
        weightMax: 3500,
        abareLv: 6,
        baitCntMax: 25,
        fookingTension: 400,
        bareEasy: 0.6));
    fishs.add(new FishModel(
        id: 4,
        type: enumFishType.blue,
        name: 'ハマチ',
        rare: 3,
        image: 'fish/hamachi.png',
        text: '',
        hp: 3600,
        wariai: 0.6,
        point: 300,
        tanaMin: 0,
        tanaMax: 410,
        hereTanaMin: 300,
        hereTanaMax: 500,
        hitMaki: 0.6,
        hitJerk: 0.9,
        hitFall: 0.5,
        hitSpeedJust: 370,
        hitSpeedRange: 60,
        sizeMin: 40,
        sizeMax: 59.9,
        weightMin: 900,
        weightMax: 5400,
        abareLv: 7,
        baitCntMax: 25,
        fookingTension: 700,
        bareEasy: 0.6));
    fishs.add(new FishModel(
        id: 5,
        type: enumFishType.blue,
        name: 'サワラ',
        rare: 3,
        image: 'fish/sawara.png',
        text: '',
        hp: 4000,
        wariai: 0.4,
        point: 470,
        tanaMin: 50,
        tanaMax: 300,
        hereTanaMin: 400,
        hereTanaMax: 650,
        hitMaki: 0.6,
        hitJerk: 0.9,
        hitFall: 0.7,
        hitSpeedJust: 430,
        hitSpeedRange: 100,
        sizeMin: 70,
        sizeMax: 111.2,
        weightMin: 2400,
        weightMax: 9600,
        abareLv: 7,
        baitCntMax: 40,
        fookingTension: 560,
        bareEasy: 0.8));
    fishs.add(new FishModel(
        id: 6,
        type: enumFishType.blue,
        name: 'メジ',
        rare: 4,
        image: 'fish/meji.png',
        text: '',
        hp: 4500,
        wariai: 0.5,
        point: 600,
        tanaMin: 0,
        tanaMax: 600,
        hereTanaMin: 500,
        hereTanaMax: 800,
        hitMaki: 0.4,
        hitJerk: 0.8,
        hitFall: 0.5,
        hitSpeedJust: 510,
        hitSpeedRange: 80,
        sizeMin: 60,
        sizeMax: 79.9,
        weightMin: 2600,
        weightMax: 6800,
        abareLv: 8,
        baitCntMax: 25,
        fookingTension: 1200,
        bareEasy: 0.6));
    fishs.add(new FishModel(
        id: 7,
        type: enumFishType.blue,
        name: 'ブリ',
        rare: 4,
        image: 'fish/buri.png',
        text: '',
        hp: 5100,
        wariai: 0.4,
        point: 1180,
        tanaMin: 100,
        tanaMax: 800,
        hereTanaMin: 650,
        hereTanaMax: 900,
        hitMaki: 0.3,
        hitJerk: 0.7,
        hitFall: 0.4,
        hitSpeedJust: 550,
        hitSpeedRange: 70,
        sizeMin: 80,
        sizeMax: 112,
        weightMin: 6800,
        weightMax: 13000,
        abareLv: 9,
        baitCntMax: 25,
        fookingTension: 2000,
        bareEasy: 0.6));
    fishs.add(new FishModel(
        id: 8,
        type: enumFishType.blue,
        name: 'シイラ',
        rare: 5,
        image: 'fish/shira.png',
        text: '',
        hp: 5300,
        wariai: 0.2,
        point: 1200,
        tanaMin: 0,
        tanaMax: 100,
        hereTanaMin: 800,
        hereTanaMax: 1000,
        hitMaki: 0.5,
        hitJerk: 1,
        hitFall: 0.7,
        hitSpeedJust: 610,
        hitSpeedRange: 100,
        sizeMin: 46,
        sizeMax: 134.2,
        weightMin: 1000,
        weightMax: 11000,
        abareLv: 10,
        baitCntMax: 20,
        fookingTension: 2600,
        bareEasy: 0.7));
    fishs.add(new FishModel(
        id: 9,
        type: enumFishType.blue,
        name: 'ヒラマサ',
        rare: 4,
        image: 'fish/hiramasa.png',
        text: '',
        hp: 4500,
        wariai: 0.4,
        point: 900,
        tanaMin: 0,
        tanaMax: 700,
        hereTanaMin: 500,
        hereTanaMax: 1000,
        hitMaki: 0.5,
        hitJerk: 1,
        hitFall: 0.6,
        hitSpeedJust: 400,
        hitSpeedRange: 60,
        sizeMin: 35,
        sizeMax: 120.1,
        weightMin: 700,
        weightMax: 12000,
        abareLv: 8,
        baitCntMax: 40,
        fookingTension: 1200,
        bareEasy: 0.4));
    fishs.add(new FishModel(
        id: 10,
        type: enumFishType.bream,
        name: 'チヌ',
        rare: 2,
        image: 'fish/tinu.png',
        text: '',
        hp: 2300,
        wariai: 0.6,
        point: 180,
        tanaMin: 0,
        tanaMax: 100,
        hereTanaMin: 0,
        hereTanaMax: 100,
        hitMaki: 0.8,
        hitJerk: 0.1,
        hitFall: 0.5,
        hitSpeedJust: 60,
        hitSpeedRange: 20,
        sizeMin: 24.9,
        sizeMax: 53,
        weightMin: 400,
        weightMax: 1800,
        abareLv: 3,
        baitCntMax: 30,
        fookingTension: 300,
        bareEasy: 0.3));
    fishs.add(new FishModel(
        id: 11,
        type: enumFishType.bream,
        name: 'シーバス',
        rare: 3,
        image: 'fish/seabass.png',
        text: '',
        hp: 3000,
        wariai: 0.5,
        point: 200,
        tanaMin: 10,
        tanaMax: 200,
        hereTanaMin: 50,
        hereTanaMax: 200,
        hitMaki: 0.7,
        hitJerk: 0.3,
        hitFall: 0.3,
        hitSpeedJust: 100,
        hitSpeedRange: 50,
        sizeMin: 25,
        sizeMax: 112.5,
        weightMin: 400,
        weightMax: 7000,
        abareLv: 6,
        baitCntMax: 20,
        fookingTension: 200,
        bareEasy: 0.9));
    fishs.add(new FishModel(
        id: 12,
        type: enumFishType.bream,
        name: 'サバフグ',
        rare: 1,
        image: 'fish/sabahugu.png',
        text: '',
        hp: 1800,
        wariai: 0.5,
        point: 100,
        tanaMin: 0,
        tanaMax: 300,
        hereTanaMin: 100,
        hereTanaMax: 300,
        hitMaki: 1,
        hitJerk: 0.8,
        hitFall: 0.7,
        hitSpeedJust: 80,
        hitSpeedRange: 60,
        sizeMin: 13.4,
        sizeMax: 53.9,
        weightMin: 170,
        weightMax: 1500,
        abareLv: 4,
        baitCntMax: 40,
        fookingTension: 60,
        bareEasy: 0.1));
    fishs.add(new FishModel(
        id: 13,
        type: enumFishType.bream,
        name: 'イサキ',
        rare: 4,
        image: 'fish/isaki.png',
        text: '',
        hp: 3100,
        wariai: 0.6,
        point: 310,
        tanaMin: 80,
        tanaMax: 400,
        hereTanaMin: 200,
        hereTanaMax: 400,
        hitMaki: 0.8,
        hitJerk: 0.4,
        hitFall: 0.5,
        hitSpeedJust: 210,
        hitSpeedRange: 60,
        sizeMin: 31,
        sizeMax: 51,
        weightMin: 500,
        weightMax: 1600,
        abareLv: 5,
        baitCntMax: 35,
        fookingTension: 500,
        bareEasy: 0.7));
    fishs.add(new FishModel(
        id: 14,
        type: enumFishType.bream,
        name: 'レンコダイ',
        rare: 3,
        image: 'fish/renkodai.png',
        text: '',
        hp: 4200,
        wariai: 0.6,
        point: 390,
        tanaMin: 150,
        tanaMax: 530,
        hereTanaMin: 300,
        hereTanaMax: 500,
        hitMaki: 0.9,
        hitJerk: 0.1,
        hitFall: 0.4,
        hitSpeedJust: 150,
        hitSpeedRange: 70,
        sizeMin: 26.8,
        sizeMax: 49,
        weightMin: 500,
        weightMax: 2300,
        abareLv: 5,
        baitCntMax: 40,
        fookingTension: 600,
        bareEasy: 0.3));
    fishs.add(new FishModel(
        id: 15,
        type: enumFishType.bream,
        name: 'イトヨリ',
        rare: 3,
        image: 'fish/itoyori.png',
        text: '',
        hp: 2321,
        wariai: 0.4,
        point: 470,
        tanaMin: 200,
        tanaMax: 600,
        hereTanaMin: 400,
        hereTanaMax: 650,
        hitMaki: 1,
        hitJerk: 0.4,
        hitFall: 0.4,
        hitSpeedJust: 250,
        hitSpeedRange: 100,
        sizeMin: 23,
        sizeMax: 47.2,
        weightMin: 565,
        weightMax: 2211,
        abareLv: 4,
        baitCntMax: 40,
        fookingTension: 700,
        bareEasy: 0.4));
    fishs.add(new FishModel(
        id: 16,
        type: enumFishType.bream,
        name: 'アカヤガラ',
        rare: 2,
        image: 'fish/akayagara.png',
        text: '',
        hp: 1500,
        wariai: 0.3,
        point: 400,
        tanaMin: 400,
        tanaMax: 800,
        hereTanaMin: 500,
        hereTanaMax: 800,
        hitMaki: 1,
        hitJerk: 0.5,
        hitFall: 0.6,
        hitSpeedJust: 100,
        hitSpeedRange: 80,
        sizeMin: 60.6,
        sizeMax: 154.3,
        weightMin: 500,
        weightMax: 2500,
        abareLv: 2,
        baitCntMax: 25,
        fookingTension: 700,
        bareEasy: 0.5));
    fishs.add(new FishModel(
        id: 17,
        type: enumFishType.bream,
        name: 'マダイ',
        rare: 4,
        image: 'fish/madai.png',
        text: '',
        hp: 5000,
        wariai: 0.5,
        point: 700,
        tanaMin: 300,
        tanaMax: 1000,
        hereTanaMin: 650,
        hereTanaMax: 900,
        hitMaki: 1,
        hitJerk: 0.1,
        hitFall: 0.2,
        hitSpeedJust: 150,
        hitSpeedRange: 50,
        sizeMin: 26.3,
        sizeMax: 86.8,
        weightMin: 500,
        weightMax: 10000,
        abareLv: 4,
        baitCntMax: 30,
        fookingTension: 1000,
        bareEasy: 0.4));
    fishs.add(new FishModel(
        id: 18,
        type: enumFishType.bream,
        name: 'アマダイ',
        rare: 5,
        image: 'fish/amadai.png',
        text: '',
        hp: 8000,
        wariai: 0.2,
        point: 930,
        tanaMin: 500,
        tanaMax: 1000,
        hereTanaMin: 800,
        hereTanaMax: 1000,
        hitMaki: 0.5,
        hitJerk: 0.3,
        hitFall: 0.2,
        hitSpeedJust: 260,
        hitSpeedRange: 30,
        sizeMin: 45,
        sizeMax: 87,
        weightMin: 1300,
        weightMax: 12000,
        abareLv: 6,
        baitCntMax: 20,
        fookingTension: 1300,
        bareEasy: 0.6));
    fishs.add(new FishModel(
        id: 19,
        type: enumFishType.bream,
        name: '近目金時',
        rare: 5,
        image: 'fish/chikamekintoki.png',
        text: '',
        hp: 1530,
        wariai: 0.1,
        point: 860,
        tanaMin: 400,
        tanaMax: 1000,
        hereTanaMin: 400,
        hereTanaMax: 1000,
        hitMaki: 0.6,
        hitJerk: 0.3,
        hitFall: 0.4,
        hitSpeedJust: 230,
        hitSpeedRange: 100,
        sizeMin: 25,
        sizeMax: 60.2,
        weightMin: 500,
        weightMax: 3210,
        abareLv: 5,
        baitCntMax: 20,
        fookingTension: 800,
        bareEasy: 0.5));
    fishs.add(new FishModel(
        id: 20,
        type: enumFishType.bottom,
        name: 'エソ',
        rare: 1,
        image: 'fish/eso.png',
        text: '',
        hp: 600,
        wariai: 0.6,
        point: 50,
        tanaMin: 0,
        tanaMax: 100,
        hereTanaMin: 0,
        hereTanaMax: 100,
        hitMaki: 0.6,
        hitJerk: 0.6,
        hitFall: 1,
        hitSpeedJust: 60,
        hitSpeedRange: 60,
        sizeMin: 25,
        sizeMax: 60.2,
        weightMin: 500,
        weightMax: 2300,
        abareLv: 2,
        baitCntMax: 20,
        fookingTension: 100,
        bareEasy: 0.5));
    fishs.add(new FishModel(
        id: 21,
        type: enumFishType.bottom,
        name: 'カサゴ',
        rare: 1,
        image: 'fish/kasago.png',
        text: '',
        hp: 500,
        wariai: 1,
        point: 80,
        tanaMin: 50,
        tanaMax: 200,
        hereTanaMin: 50,
        hereTanaMax: 200,
        hitMaki: 0.7,
        hitJerk: 0.5,
        hitFall: 1,
        hitSpeedJust: 40,
        hitSpeedRange: 20,
        sizeMin: 12,
        sizeMax: 28,
        weightMin: 100,
        weightMax: 600,
        abareLv: 4,
        baitCntMax: 40,
        fookingTension: 250,
        bareEasy: 0.5));
    fishs.add(new FishModel(
        id: 22,
        type: enumFishType.bottom,
        name: 'アオハタ',
        rare: 3,
        image: 'fish/aohata.png',
        text: '',
        hp: 1800,
        wariai: 0.8,
        point: 300,
        tanaMin: 100,
        tanaMax: 300,
        hereTanaMin: 100,
        hereTanaMax: 300,
        hitMaki: 0.6,
        hitJerk: 0.6,
        hitFall: 1,
        hitSpeedJust: 80,
        hitSpeedRange: 60,
        sizeMin: 20.6,
        sizeMax: 63.2,
        weightMin: 400,
        weightMax: 1500,
        abareLv: 3,
        baitCntMax: 25,
        fookingTension: 400,
        bareEasy: 0.5));
    fishs.add(new FishModel(
        id: 23,
        type: enumFishType.bottom,
        name: 'アヤメカサゴ',
        rare: 2,
        image: 'fish/ayamekasago.png',
        text: '',
        hp: 1500,
        wariai: 0.2,
        point: 700,
        tanaMin: 200,
        tanaMax: 400,
        hereTanaMin: 200,
        hereTanaMax: 400,
        hitMaki: 0.9,
        hitJerk: 0.5,
        hitFall: 0.8,
        hitSpeedJust: 90,
        hitSpeedRange: 40,
        sizeMin: 20.7,
        sizeMax: 44.2,
        weightMin: 600,
        weightMax: 1200,
        abareLv: 3,
        baitCntMax: 40,
        fookingTension: 600,
        bareEasy: 0.5));
    fishs.add(new FishModel(
        id: 24,
        type: enumFishType.bottom,
        name: 'キジハタ',
        rare: 4,
        image: 'fish/kijihata.png',
        text: '',
        hp: 2100,
        wariai: 0.4,
        point: 500,
        tanaMin: 300,
        tanaMax: 500,
        hereTanaMin: 300,
        hereTanaMax: 500,
        hitMaki: 0.4,
        hitJerk: 0.4,
        hitFall: 0.8,
        hitSpeedJust: 100,
        hitSpeedRange: 60,
        sizeMin: 20.6,
        sizeMax: 63.2,
        weightMin: 400,
        weightMax: 4300,
        abareLv: 4,
        baitCntMax: 25,
        fookingTension: 500,
        bareEasy: 0.5));
    fishs.add(new FishModel(
        id: 25,
        type: enumFishType.bottom,
        name: 'オキボッコ',
        rare: 3,
        image: 'fish/okibokko.png',
        text: '',
        hp: 2600,
        wariai: 0.7,
        point: 320,
        tanaMin: 400,
        tanaMax: 650,
        hereTanaMin: 400,
        hereTanaMax: 650,
        hitMaki: 0.3,
        hitJerk: 0.2,
        hitFall: 0.9,
        hitSpeedJust: 100,
        hitSpeedRange: 70,
        sizeMin: 26,
        sizeMax: 62,
        weightMin: 480,
        weightMax: 4800,
        abareLv: 3,
        baitCntMax: 30,
        fookingTension: 700,
        bareEasy: 0.4));
    fishs.add(new FishModel(
        id: 26,
        type: enumFishType.bottom,
        name: 'マハタ',
        rare: 5,
        image: 'fish/mahata.png',
        text: '',
        hp: 3800,
        wariai: 0.4,
        point: 780,
        tanaMin: 500,
        tanaMax: 800,
        hereTanaMin: 500,
        hereTanaMax: 800,
        hitMaki: 0.4,
        hitJerk: 0.6,
        hitFall: 0.8,
        hitSpeedJust: 260,
        hitSpeedRange: 80,
        sizeMin: 36,
        sizeMax: 63,
        weightMin: 700,
        weightMax: 5100,
        abareLv: 6,
        baitCntMax: 30,
        fookingTension: 1000,
        bareEasy: 0.6));
    fishs.add(new FishModel(
        id: 27,
        type: enumFishType.bottom,
        name: '未定',
        rare: 4,
        image: 'fish/aaaa.png',
        text: '',
        hp: 4000,
        wariai: 0.4,
        point: 800,
        tanaMin: 650,
        tanaMax: 900,
        hereTanaMin: 650,
        hereTanaMax: 900,
        hitMaki: 0.2,
        hitJerk: 0.3,
        hitFall: 0.7,
        hitSpeedJust: 240,
        hitSpeedRange: 100,
        sizeMin: 40,
        sizeMax: 70,
        weightMin: 600,
        weightMax: 3100,
        abareLv: 5,
        baitCntMax: 40,
        fookingTension: 1100,
        bareEasy: 0.4));
    fishs.add(new FishModel(
        id: 28,
        type: enumFishType.bottom,
        name: 'クエ',
        rare: 5,
        image: 'fish/kue.png',
        text: '',
        hp: 6900,
        wariai: 0.1,
        point: 1300,
        tanaMin: 800,
        tanaMax: 1000,
        hereTanaMin: 800,
        hereTanaMax: 1000,
        hitMaki: 0.3,
        hitJerk: 0.3,
        hitFall: 0.5,
        hitSpeedJust: 280,
        hitSpeedRange: 60,
        sizeMin: 36,
        sizeMax: 69,
        weightMin: 700,
        weightMax: 8000,
        abareLv: 6,
        baitCntMax: 25,
        fookingTension: 2300,
        bareEasy: 0.6));
    fishs.add(new FishModel(
        id: 29,
        type: enumFishType.bottom,
        name: 'キハッソク',
        rare: 5,
        image: 'fish/kihassoku.png',
        text: '',
        hp: 2600,
        wariai: 0.2,
        point: 361,
        tanaMin: 400,
        tanaMax: 1000,
        hereTanaMin: 400,
        hereTanaMax: 1000,
        hitMaki: 0.3,
        hitJerk: 0.1,
        hitFall: 0.6,
        hitSpeedJust: 150,
        hitSpeedRange: 30,
        sizeMin: 23,
        sizeMax: 45.2,
        weightMin: 500,
        weightMax: 1500,
        abareLv: 5,
        baitCntMax: 15,
        fookingTension: 70,
        bareEasy: 0.4));
  }

  //IDを指定して魚情報を取得
  FishModel getFishDetail(int id) {
    FishModel ret = fishs.firstWhere((fish) => fish.id == id);
    return ret;
  }

  //水深から可能性のある魚種のみ抽出して返す
  List<FishModel> extractDepth(
      {required double depth, required double maxDepth, required bool bottom}) {
    //ディープコピー
    List<FishModel> extractFishs = [...fishs];
    //深さから可能性のある魚種のみ抽出
    extractFishs.removeWhere((value) => depth < value.tanaMin);
    extractFishs.removeWhere((value) => depth > value.tanaMax);
    extractFishs.removeWhere((value) => maxDepth < value.hereTanaMin);
    extractFishs.removeWhere((value) => maxDepth > value.hereTanaMax);

    if (!bottom) {
      //現在底付近でなければ底物を除外
      extractFishs.removeWhere((value) => value.type == enumFishType.bottom);
    }
    return extractFishs;
  }

  //現在の最大水深から可能性のある魚種のみ抽出して返す
  List<FishModel> extractMaxDepth({required double maxDepth}) {
    //ディープコピー
    List<FishModel> extractFishs = [...fishs];
    //深さから可能性のある魚種のみ抽出
    extractFishs.removeWhere((value) => maxDepth < value.hereTanaMin);
    extractFishs.removeWhere((value) => maxDepth > value.hereTanaMax);

    return extractFishs;
  }
}

class FishModel {
  int id; //一意識別キー
  String name; //魚種名
  int rare; //レアド
  String image; //画像ファイル名
  String text; //釣果画面のコメント
  int hp; //このスキャン経過で0になる
  // int addMax; //引きの最大
  // int addMin; //引きの最小（最大との乖離が暴れ度）
  double wariai; //HIT率 条件全一致で確定1.0～
  int point; //ポイントの基礎値
  int tanaMin; //生息タナ 上 0.1m単位
  int tanaMax; //生息タナ 下 0.1m単位
  int hereTanaMin; //生息域 水深これより深くない場所にはいない 0.1m単位
  int hereTanaMax; //生息域 水深これより深い場所にはいない 0.1m単位
  double hitMaki; //巻き志向 0.0～1.0
  double hitJerk; //ジャーク志向 0.0～1.0
  double hitFall; //フォール志向 0.0～1.0
  int hitSpeedJust; //スピード志向
  int hitSpeedRange; //スピード志向範囲+-
  double sizeMin; //大きさ範囲最小
  double sizeMax; //大きさ範囲最大
  double weightMin; //重さ g単位（HP0時の最低重量、これが無いとバレ判定にひっかかる）
  double weightMax; //重さ g単位（HP0時の最低重量、これが無いとバレ判定にひっかかる）
  int abareLv; //自重の何倍まで暴れるか
  int baitCntMax; //アタリ発生からアワセまでの猶予スキャン
  double fookingTension; //アワセ成功テンション
  double bareEasy; //バレやすさ 0.0～1.0
  //bool flgBottom; //底生
  enumFishType type; //魚タイプ

  var prob = 0.0; //今 釣れる確率の入れ物

  //コンストラクタ
  FishModel({
    required this.id,
    required this.name,
    required this.rare,
    required this.image,
    required this.text,
    required this.hp,
    // required this.addMax,
    // required this.addMin,
    required this.wariai,
    required this.point,
    required this.tanaMin,
    required this.tanaMax,
    required this.hereTanaMin,
    required this.hereTanaMax,
    required this.hitFall,
    required this.hitMaki,
    required this.hitJerk,
    required this.hitSpeedJust,
    required this.hitSpeedRange,
    required this.sizeMin,
    required this.sizeMax,
    required this.weightMax,
    required this.weightMin,
    required this.abareLv,
    required this.baitCntMax,
    required this.fookingTension,
    required this.bareEasy,
    //required this.flgBottom,
    required this.type,
  });

  //サイズ割合（0.0～1.0）を元に実サイズを返す
  double getSize(size) {
    return ((sizeMax - sizeMin) * size + sizeMin);
  }

  //サイズ割合（0.0～1.0）を元に実重さを返す
  double getWeight(size) {
    return ((weightMax - weightMin) * size + weightMin);
  }

  //魚種類名の表示を返す
  Widget getNameContainer(enumFishType type, double fontSize) {
    String name;
    var borderColor;
    var boxColor;

    switch (type) {
      case enumFishType.blue:
        name = "青魚";
        borderColor = Colors.indigo[500];
        boxColor = Colors.cyan[500];
        break;
      case enumFishType.bream:
        name = "鯛他";
        borderColor = Colors.red[700];
        boxColor = Colors.red[200];
        break;
      case enumFishType.bottom:
        name = "底物";
        borderColor = Colors.green[700];
        boxColor = Colors.green[200];
        break;
      default:
        return Container();
    }

    return Container(
      margin: EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 3),
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
          color: boxColor),
      child: Text(name,
          style: TextStyle(
            color: Colors.black,
            //fontWeight: FontWeight.bold,
            fontSize: fontSize,
          )),
    );
  }

  Map<String, List<double>> getPrmLevels() {
    final Map<String, List<double>> ret = {
      'hp': [500, 1000, 2000, 4000, 8000],
      'addMax': [6, 10, 20, 35, 50],
      'abare': [6, 10, 15, 30, 50],
    };
    return ret;
  }
}
