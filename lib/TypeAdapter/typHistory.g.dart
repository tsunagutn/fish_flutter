// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typHistory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class typHistoryAdapter extends TypeAdapter<typHistory> {
  @override
  final int typeId = 6;

  @override
  typHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return typHistory()..lstGameDatas = (fields[1] as HiveList).castHiveList();
  }

  @override
  void write(BinaryWriter writer, typHistory obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.lstGameDatas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is typHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
