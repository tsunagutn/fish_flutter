// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typResults.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class typResultsAdapter extends TypeAdapter<typResults> {
  @override
  final int typeId = 2;

  @override
  typResults read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return typResults(
      lstResults: (fields[0] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, typResults obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.lstResults);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is typResultsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
