// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthorClassAdapter extends TypeAdapter<AuthorClass> {
  @override
  final int typeId = 1;

  @override
  AuthorClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthorClass(
      author: fields[0] as String,
      biography: fields[1] as String,
      books: (fields[2] as List).cast<String>(),
      profile: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthorClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.biography)
      ..writeByte(2)
      ..write(obj.books)
      ..writeByte(3)
      ..write(obj.profile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
