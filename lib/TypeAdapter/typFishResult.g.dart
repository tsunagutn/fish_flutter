// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typFishResult.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class typFishResultAdapter extends TypeAdapter<typFishResult> {
  @override
  final int typeId = 4;

  @override
  typFishResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return typFishResult(
      fishId: fields[0] as int,
      size: fields[1] as double,
      depth: fields[2] as double,
      maxDepth: fields[3] as double,
      resultKbn: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, typFishResult obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fishId)
      ..writeByte(1)
      ..write(obj.size)
      ..writeByte(2)
      ..write(obj.depth)
      ..writeByte(3)
      ..write(obj.maxDepth)
      ..writeByte(4)
      ..write(obj.resultKbn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is typFishResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
