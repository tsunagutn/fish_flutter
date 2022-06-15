// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typGameData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class typGameDataAdapter extends TypeAdapter<typGameData> {
  @override
  final int typeId = 3;

  @override
  typGameData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return typGameData(
      gameId: fields[0] as int,
      timeCount: fields[1] as int,
      maxTimeCount: fields[2] as int,
      point: fields[3] as int,
      maxDepth: fields[4] as double,
      windLevel: fields[5] as double,
      maxWindLevel: fields[6] as double,
      maxTension: fields[7] as double,
      maxLineHp: fields[8] as double,
      maxSpeed: fields[9] as double,
      useLureIdx: fields[10] as int,
      saveDateTime: fields[11] as String,
      isEnd: fields[14] as bool,
    )
      ..fishResults = (fields[12] as HiveList).castHiveList()
      ..lureData = (fields[13] as HiveList).castHiveList();
  }

  @override
  void write(BinaryWriter writer, typGameData obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.gameId)
      ..writeByte(1)
      ..write(obj.timeCount)
      ..writeByte(2)
      ..write(obj.maxTimeCount)
      ..writeByte(3)
      ..write(obj.point)
      ..writeByte(4)
      ..write(obj.maxDepth)
      ..writeByte(5)
      ..write(obj.windLevel)
      ..writeByte(6)
      ..write(obj.maxWindLevel)
      ..writeByte(7)
      ..write(obj.maxTension)
      ..writeByte(8)
      ..write(obj.maxLineHp)
      ..writeByte(9)
      ..write(obj.maxSpeed)
      ..writeByte(10)
      ..write(obj.useLureIdx)
      ..writeByte(11)
      ..write(obj.saveDateTime)
      ..writeByte(12)
      ..write(obj.fishResults)
      ..writeByte(13)
      ..write(obj.lureData)
      ..writeByte(14)
      ..write(obj.isEnd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is typGameDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
