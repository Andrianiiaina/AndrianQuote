// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookClassAdapter extends TypeAdapter<BookClass> {
  @override
  final int typeId = 2;

  @override
  BookClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookClass(
      title: fields[0] as String,
      author: fields[1] as String,
      version: fields[2] as String,
      note: fields[3] as String,
      resume: fields[4] as String,
      isFinished: fields[5] as bool,
      category: fields[6] as String,
      couverture: fields[7] as String,
      nbrPage: fields[8] as String,
      isbn: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookClass obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.version)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.resume)
      ..writeByte(5)
      ..write(obj.isFinished)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.couverture)
      ..writeByte(8)
      ..write(obj.nbrPage)
      ..writeByte(9)
      ..write(obj.isbn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
