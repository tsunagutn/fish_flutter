// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typSettings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class typSettingsAdapter extends TypeAdapter<typSettings> {
  @override
  final int typeId = 1;

  @override
  typSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return typSettings(
      flgBgm: fields[0] as bool,
      flgControlRight: fields[1] as bool,
      volumeBgm: fields[2] as double,
      volumeSe: fields[3] as double,
      jerkSense: fields[4] as double,
      makiSense: fields[5] as double,
      isReversal: fields[6] as bool,
      isVibe: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, typSettings obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.flgBgm)
      ..writeByte(1)
      ..write(obj.flgControlRight)
      ..writeByte(2)
      ..write(obj.volumeBgm)
      ..writeByte(3)
      ..write(obj.volumeSe)
      ..writeByte(4)
      ..write(obj.jerkSense)
      ..writeByte(5)
      ..write(obj.makiSense)
      ..writeByte(6)
      ..write(obj.isReversal)
      ..writeByte(7)
      ..write(obj.isVibe);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is typSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
