// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biblio_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BiblioClassAdapter extends TypeAdapter<BiblioClass> {
  @override
  final int typeId = 4;

  @override
  BiblioClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BiblioClass(
      filepath: fields[0] as String,
      imagepath: fields[1] as String,
      currentPage: fields[2] as int,
      nbrPage: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BiblioClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.filepath)
      ..writeByte(1)
      ..write(obj.imagepath)
      ..writeByte(2)
      ..write(obj.currentPage)
      ..writeByte(3)
      ..write(obj.nbrPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BiblioClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
