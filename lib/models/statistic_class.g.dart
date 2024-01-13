// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatisticClassAdapter extends TypeAdapter<StatisticClass> {
  @override
  final int typeId = 6;

  @override
  StatisticClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatisticClass(
      year: fields[0] as int,
      finished: fields[1] as int,
      current: fields[2] as int,
      abandonned: fields[3] as int,
      categories: (fields[6] as List)
          .map((dynamic e) => (e as Map).cast<String, int>())
          .toList(),
      digitalBook: fields[8] as int,
      digitalPages: fields[10] as int,
      englishVersion: fields[11] as int,
      finishedPerMonth: (fields[5] as List)
          .map((dynamic e) => (e as Map).cast<DateTime, int>())
          .toList(),
      frenchVersion: fields[12] as int,
      pagesPerDay: fields[13] as int,
      paperBook: fields[7] as int,
      paperPages: fields[9] as int,
      totalFinishedPage: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StatisticClass obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.finished)
      ..writeByte(2)
      ..write(obj.current)
      ..writeByte(3)
      ..write(obj.abandonned)
      ..writeByte(4)
      ..write(obj.totalFinishedPage)
      ..writeByte(5)
      ..write(obj.finishedPerMonth)
      ..writeByte(6)
      ..write(obj.categories)
      ..writeByte(7)
      ..write(obj.paperBook)
      ..writeByte(8)
      ..write(obj.digitalBook)
      ..writeByte(9)
      ..write(obj.paperPages)
      ..writeByte(10)
      ..write(obj.digitalPages)
      ..writeByte(11)
      ..write(obj.englishVersion)
      ..writeByte(12)
      ..write(obj.frenchVersion)
      ..writeByte(13)
      ..write(obj.pagesPerDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatisticClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
