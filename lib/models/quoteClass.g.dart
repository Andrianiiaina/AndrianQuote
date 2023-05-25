// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quoteClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuoteClassAdapter extends TypeAdapter<QuoteClass> {
  @override
  final int typeId = 0;

  @override
  QuoteClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuoteClass(
      author: fields[0] as String,
      book: fields[1] as String,
      quote: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuoteClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.book)
      ..writeByte(2)
      ..write(obj.quote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
