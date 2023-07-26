// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotyClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuotyClassAdapter extends TypeAdapter<QuotyClass> {
  @override
  final int typeId = 0;

  @override
  QuotyClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuotyClass(
      author: fields[0] as String,
      book: fields[1] as String,
      quote: fields[2] as String,
      fond: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuotyClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.book)
      ..writeByte(2)
      ..write(obj.quote)
      ..writeByte(3)
      ..write(obj.fond);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuotyClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
