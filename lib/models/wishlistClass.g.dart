// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlistClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistClassAdapter extends TypeAdapter<WishlistClass> {
  @override
  final int typeId = 3;

  @override
  WishlistClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishlistClass(
      title: fields[0] as String,
      author: fields[1] as String,
      version: fields[2] as String,
      priority: fields[3] as String,
      resume: fields[4] as String,
      category: fields[6] as String,
      nbrPage: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WishlistClass obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.version)
      ..writeByte(3)
      ..write(obj.priority)
      ..writeByte(4)
      ..write(obj.resume)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.nbrPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
