// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookClassAdapter extends TypeAdapter<BookClass> {
  @override
  final int typeId = 8;

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
      category: fields[5] as String,
      couverture: fields[6] as String,
      nbrPage: fields[7] as String,
      date: fields[8] as DateTime,
      status: fields[9] as String,
      debut: fields[10] as DateTime,
      isPaper: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BookClass obj) {
    writer
      ..writeByte(12)
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
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.couverture)
      ..writeByte(7)
      ..write(obj.nbrPage)
      ..writeByte(8)
      ..write(obj.date)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.debut)
      ..writeByte(11)
      ..write(obj.isPaper);
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
