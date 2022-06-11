// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typLureData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class typLureDataAdapter extends TypeAdapter<typLureData> {
  @override
  final int typeId = 5;

  @override
  typLureData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return typLureData(
      lureId: fields[0] as int,
      name: fields[1] as String,
      image: fields[2] as String,
      lv: fields[3] as int,
      totalExp: fields[4] as double,
      unLockweightid: fields[5] as int,
      useWeightId: fields[6] as int,
      fall: fields[7] as double,
      reeling: fields[8] as double,
      jerk: fields[9] as double,
      lvAddFall: fields[10] as double,
      lvAddReeling: fields[11] as double,
      lvAddJerk: fields[12] as double,
    );
  }

  @override
  void write(BinaryWriter writer, typLureData obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.lureId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.lv)
      ..writeByte(4)
      ..write(obj.totalExp)
      ..writeByte(5)
      ..write(obj.unLockweightid)
      ..writeByte(6)
      ..write(obj.useWeightId)
      ..writeByte(7)
      ..write(obj.fall)
      ..writeByte(8)
      ..write(obj.reeling)
      ..writeByte(9)
      ..write(obj.jerk)
      ..writeByte(10)
      ..write(obj.lvAddFall)
      ..writeByte(11)
      ..write(obj.lvAddReeling)
      ..writeByte(12)
      ..write(obj.lvAddJerk);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is typLureDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
